
#LayerList_ItemHeight = 24				; row height
#LayerList_Margin = 3
#LayerList_FoldWidth = 16				; fold-chevron column; doubles as the child indent step
#LayerList_EyeWidth = 22				; visibility-button column, right aligned
#LayerList_LockWidth = 20				; padlock column, immediately left of the eye
#LayerList_ToolbarThickness = 7			; scrollbar thickness — always reserved, so the eye never shifts
#LayerList_ReorderDelay = 400			; ms between auto-scroll steps while dragging against an edge
#LayerList_MarkerHeight = 3				; thickness of the drop-position marker

Enumeration ; Which part of a row the pointer is over
	#LayerList_Zone_Body
	#LayerList_Zone_Fold
	#LayerList_Zone_Eye
	#LayerList_Zone_Lock
EndEnumeration

Structure LayerList_Item
	Text.Text							; must stay first: a VerticalList-style *CustomItem callback expects it there
	Depth.b								; 0 = top level, 1 = child of the nearest shallower row above it, and so on
	Folded.b							; anything holding a subtree: it stays in the list and takes no row
	Visible.b							; this row's own eye state
	Locked.b							; …and its own padlock
	Selected.b							; part of the current selection (#MultiSelect)
	*Data
EndStructure

Structure LayerListData Extends GadgetData
	ItemHeight.l
	VisibleScrollBar.b
	ItemState.i							; hovered row, as a list index, or -1
	MultiSelect.l
	SelectAnchor.l						; where a shift-click range starts
	PendingSelect.l						; row to collapse the selection onto when a press turns out not to be a drag
	HoverZone.b							; which part of the hovered row (#LayerList_Zone_*)
	
	Reorder.i
	DragState.i
	DragOriginX.i
	DragOriginY.i
	DragIndex.i							; list index of the row being dragged
	DragDepth.b							; the depth of the row in flight: 0 is a top-level row and its whole subtree
	ReorderRow.i						; row the dragged item would land before, or -1
	ReorderTimer.i
	ReorderDirection.b
	ReorderWindow.i
	ReorderCanvas.i
	
	Editable.l
	Editing.b
	EditCursor.b					; the cursor shape in force, and so also "pointer inside the editor"
	
	*String.StringData				; inline rename editor, only allocated with #Editable
	*ItemRedraw.ItemRedraw
	*ScrollBar.ScrollBarData
	
	List Items.LayerList_Item()
EndStructure

Declare LayerList_EventHandler(*GadgetData.LayerListData, *Event.Event)

;- Structure walking
Procedure LayerList_DepthAt(*GadgetData.LayerListData, Index)
	; How deep the row at Index sits, or -1 when there is no such row.
	With *GadgetData
		If SelectElement(\Items(), Index)
			ProcedureReturn \Items()\Depth
		EndIf
	EndWith
	
	ProcedureReturn -1
EndProcedure

Procedure LayerList_ParentOf(*GadgetData.LayerListData, Index)
	; List index of the nearest row above Index that sits shallower, -1 if there is none
	Protected Result = -1, Depth
	
	With *GadgetData
		If SelectElement(\Items(), Index) And \Items()\Depth > 0
			Depth = \Items()\Depth
			While PreviousElement(\Items())
				If \Items()\Depth < Depth
					Result = ListIndex(\Items())
					Break
				EndIf
			Wend
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure LayerList_ChildCount(*GadgetData.LayerListData, Parent)
	; The whole subtree under Parent, not just the rows one step down
	Protected Count, Depth
	
	With *GadgetData
		If SelectElement(\Items(), Parent)
			Depth = \Items()\Depth
			While NextElement(\Items()) And \Items()\Depth > Depth
				Count + 1
			Wend
		EndIf
	EndWith
	
	ProcedureReturn Count
EndProcedure

; HIDDEN is the depth of the shallowest folded row we are still inside, -1 out in the open
Procedure LayerList_RowCount(*GadgetData.LayerListData)
	; Rows currently on screen, folded-away subtrees excluded.
	Protected Count, Hidden = -1
	
	With *GadgetData
		ForEach \Items()
			If Hidden >= 0
				If \Items()\Depth > Hidden
					Continue
				EndIf
				Hidden = -1
			EndIf
			Count + 1
			If \Items()\Folded
				Hidden = \Items()\Depth
			EndIf
		Next
	EndWith
	
	ProcedureReturn Count
EndProcedure

Procedure LayerList_RowToIndex(*GadgetData.LayerListData, Row)
	; Screen row -> list index, or -1 when Row is past the end.
	Protected Count = -1, Hidden = -1
	
	With *GadgetData
		ForEach \Items()
			If Hidden >= 0
				If \Items()\Depth > Hidden
					Continue
				EndIf
				Hidden = -1
			EndIf
			
			Count + 1
			If Count = Row
				ProcedureReturn ListIndex(\Items())
			EndIf
			If \Items()\Folded
				Hidden = \Items()\Depth
			EndIf
		Next
	EndWith
	
	ProcedureReturn -1
EndProcedure

Procedure LayerList_IndexToRow(*GadgetData.LayerListData, Index)
	; List index -> screen row, or -1 when the item sits inside a folded subtree.
	Protected Count = -1, Hidden = -1
	
	With *GadgetData
		ForEach \Items()
			If Hidden >= 0
				If \Items()\Depth > Hidden
					If ListIndex(\Items()) = Index
						ProcedureReturn -1
					EndIf
					Continue
				EndIf
				Hidden = -1
			EndIf
			
			Count + 1
			If ListIndex(\Items()) = Index
				ProcedureReturn Count
			EndIf
			If \Items()\Folded
				Hidden = \Items()\Depth
			EndIf
		Next
	EndWith
	
	ProcedureReturn -1
EndProcedure

Procedure LayerList_EffectiveVisible(*GadgetData.LayerListData, Index)
	; A row shows through only when its own eye and every eye it sits under are on
	Protected Result, Parent = Index
	
	With *GadgetData
		If SelectElement(\Items(), Index)
			Result = \Items()\Visible
			
			While Result
				Parent = LayerList_ParentOf(*GadgetData, Parent)
				If Parent < 0 Or Not SelectElement(\Items(), Parent)
					Break
				EndIf
				Result = \Items()\Visible
			Wend
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

;- Selection
Procedure LayerList_ClearSelection(*GadgetData.LayerListData)
	With *GadgetData
		ForEach \Items()
			\Items()\Selected = #False
		Next
	EndWith
EndProcedure

Procedure LayerList_SelectOnly(*GadgetData.LayerListData, Index)
	; Collapse the selection onto one row and make it the focus.
	With *GadgetData
		LayerList_ClearSelection(*GadgetData)
		
		If Index > -1 And SelectElement(\Items(), Index)
			\Items()\Selected = #True
		EndIf
		
		\State = Index
		\SelectAnchor = Index
	EndWith
EndProcedure

Procedure LayerList_SelectRange(*GadgetData.LayerListData, FromIndex, ToIndex)
	; Select every row on screen between two items. Ranges run over visible rows, so children
	; folded away inside a group are passed over rather than silently swept in.
	Protected FromRow, ToRow, Row
	
	With *GadgetData
		FromRow = LayerList_IndexToRow(*GadgetData, FromIndex)
		ToRow = LayerList_IndexToRow(*GadgetData, ToIndex)
		
		If FromRow < 0 Or ToRow < 0
			LayerList_SelectOnly(*GadgetData, ToIndex)
			ProcedureReturn
		EndIf
		
		If FromRow > ToRow
			Swap FromRow, ToRow
		EndIf
		
		LayerList_ClearSelection(*GadgetData)
		
		For Row = FromRow To ToRow
			If SelectElement(\Items(), LayerList_RowToIndex(*GadgetData, Row))
				\Items()\Selected = #True
			EndIf
		Next
		
		\State = ToIndex
	EndWith
EndProcedure

Procedure LayerList_SelectedCount(*GadgetData.LayerListData)
	Protected Count
	
	With *GadgetData
		ForEach \Items()
			If \Items()\Selected
				Count + 1
			EndIf
		Next
	EndWith
	
	ProcedureReturn Count
EndProcedure


Procedure LayerList_IsSelected(*GadgetData.LayerListData, Index)
	If Index > -1 And SelectElement(*GadgetData\Items(), Index)
		ProcedureReturn *GadgetData\Items()\Selected
	EndIf
	
	ProcedureReturn #False
EndProcedure

Procedure LayerList_MoveFocus(*GadgetData.LayerListData, Index)
	; Arrow-key move. Shift drags the selection along from the anchor, otherwise the
	; selection collapses onto the row we land on.
	With *GadgetData
		If \MultiSelect And (GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Shift) And \SelectAnchor > -1
			LayerList_SelectRange(*GadgetData, \SelectAnchor, Index)
		Else
			LayerList_SelectOnly(*GadgetData, Index)
		EndIf
	EndWith
EndProcedure

Procedure LayerList_ToggleVisibility(*GadgetData.LayerListData, Index)
	; Flip a row's eye. When that row is part of a multi-row selection the whole selection
	; follows it, so switching a batch of layers off is one click rather than N.
	;
	; LayerList_SelectedCount walks the list, and a walk leaves the current element
	; wherever it finished - on the LAST item. Testing it inside the condition therefore
	; moved the cursor off the row we had just selected, and the single-row branch below
	; wrote the eye of the last row in the list instead. Hiding one selected item did
	; nothing (unless it happened to BE the last one); a multi-row selection was fine,
	; because its branch starts a fresh ForEach; and an unselected row was fine too,
	; because \Items()\Selected is #False and the count is never reached. Take the count
	; first, then re-select.
	Protected NewState, Batch
	
	With *GadgetData
		If Not SelectElement(\Items(), Index)
			ProcedureReturn
		EndIf
		
		NewState = Bool(Not \Items()\Visible)
		Batch = Bool(\MultiSelect And \Items()\Selected And LayerList_SelectedCount(*GadgetData) > 1)
		
		If Batch
			ForEach \Items()
				If \Items()\Selected
					\Items()\Visible = NewState
				EndIf
			Next
		ElseIf SelectElement(\Items(), Index)
			\Items()\Visible = NewState
		EndIf
	EndWith
EndProcedure

Procedure LayerList_ToggleLock(*GadgetData.LayerListData, Index)
	Protected NewState, Batch
	
	With *GadgetData
		If Not SelectElement(\Items(), Index)
			ProcedureReturn
		EndIf
		
		NewState = Bool(Not \Items()\Locked)
		Batch = Bool(\MultiSelect And \Items()\Selected And LayerList_SelectedCount(*GadgetData) > 1)
		
		If Batch
			ForEach \Items()
				If \Items()\Selected
					\Items()\Locked = NewState
				EndIf
			Next
		ElseIf SelectElement(\Items(), Index)
			\Items()\Locked = NewState
		EndIf
	EndWith
EndProcedure

Procedure LayerList_ClickSelect(*GadgetData.LayerListData, Index, Modifiers)
	; Work out what a press on a row's body does to the selection. Returns #True when
	; anything changed.
	;
	; Pressing an already-selected row with no modifier deliberately leaves the selection
	; alone and only notes what to collapse to on release: otherwise grabbing a multi-row
	; selection to drag it would throw that selection away on the way down.
	With *GadgetData
		\PendingSelect = -1
		
		If Not \MultiSelect
			If Index = \State
				ProcedureReturn #False
			EndIf
			LayerList_SelectOnly(*GadgetData, Index)
			ProcedureReturn #True
		EndIf
		
		If Modifiers & #PB_Canvas_Control
			If SelectElement(\Items(), Index)
				\Items()\Selected = Bool(Not \Items()\Selected)
			EndIf
			\State = Index
			\SelectAnchor = Index
			ProcedureReturn #True
		EndIf
		
		If (Modifiers & #PB_Canvas_Shift) And \SelectAnchor > -1
			LayerList_SelectRange(*GadgetData, \SelectAnchor, Index)
			ProcedureReturn #True
		EndIf
		
		If LayerList_IsSelected(*GadgetData, Index)
			\PendingSelect = Index		; settled on release, if this doesn't become a drag
			\State = Index
			ProcedureReturn #False
		EndIf
		
		LayerList_SelectOnly(*GadgetData, Index)
		ProcedureReturn #True
	EndWith
EndProcedure

;- Geometry
; Indent in pixels: a chevron column for the row's own arrow, plus one per level above it
Procedure LayerList_IndentOf(Depth)
	If Depth < 0
		Depth = 0
	EndIf
	ProcedureReturn #LayerList_FoldWidth * (Depth + 1)
EndProcedure

Procedure LayerList_TextWidth(*GadgetData.LayerListData, Depth)
	; Width left for a row's content once the chevron, indent, eye and scrollbar are taken out.
	ProcedureReturn *GadgetData\Width - *GadgetData\Border * 2 - LayerList_IndentOf(Depth) - #LayerList_EyeWidth - #LayerList_LockWidth - #LayerList_ToolbarThickness - #LayerList_Margin * 2
EndProcedure

Procedure LayerList_TextX(*GadgetData.LayerListData, Depth)
	ProcedureReturn *GadgetData\Border + LayerList_IndentOf(Depth) + #LayerList_Margin
EndProcedure

Procedure LayerList_EyeX(*GadgetData.LayerListData)
	ProcedureReturn *GadgetData\Width - *GadgetData\Border - #LayerList_ToolbarThickness - #LayerList_EyeWidth
EndProcedure

Procedure LayerList_LockX(*GadgetData.LayerListData)
	ProcedureReturn LayerList_EyeX(*GadgetData) - #LayerList_LockWidth
EndProcedure

Procedure LayerList_ZoneAt(*GadgetData.LayerListData, Index, MouseX)
	; Which part of the row at Index the pointer is over.
	Protected Result = #LayerList_Zone_Body, EyeX = LayerList_EyeX(*GadgetData)
	Protected LockX = LayerList_LockX(*GadgetData)
	
	With *GadgetData
		If MouseX >= EyeX And MouseX < EyeX + #LayerList_EyeWidth
			Result = #LayerList_Zone_Eye
		ElseIf MouseX >= LockX And MouseX < LockX + #LayerList_LockWidth
			Result = #LayerList_Zone_Lock
		ElseIf SelectElement(\Items(), Index) And LayerList_ChildCount(*GadgetData, Index)
			; The chevron rides at the row's own indent, not at the left edge
			SelectElement(\Items(), Index)
			Protected FoldX = \Border + LayerList_IndentOf(\Items()\Depth) - #LayerList_FoldWidth
			If MouseX >= FoldX And MouseX < FoldX + #LayerList_FoldWidth
				Result = #LayerList_Zone_Fold
			EndIf
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure LayerList_UpdateScrollBar(*GadgetData.LayerListData)
	Protected Total
	
	With *GadgetData
		Total = LayerList_RowCount(*GadgetData) * \ItemHeight
		
		If Total > \Height
			\VisibleScrollBar = #True
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, Total)
		Else
			; Don't touch the bar's position here: while it's too short to scroll, its
			; Maximum is below one page, so ScrollBar_SetState_Meta would clamp against a
			; negative ceiling and leave a negative position behind.
			\VisibleScrollBar = #False
		EndIf
	EndWith
EndProcedure

Procedure LayerList_ScrollOffset(*GadgetData.LayerListData)
	; How far the rows are scrolled up. A hidden bar keeps whatever position it last had,
	; which needn't be 0 and needn't even be positive, so a hidden bar means pinned to the
	; top. Every screen-position calculation goes through here so drawing and hit-testing
	; can't disagree.
	If *GadgetData\VisibleScrollBar
		ProcedureReturn *GadgetData\ScrollBar\State
	EndIf
	
	ProcedureReturn 0
EndProcedure

Procedure LayerList_PrepareItem(*GadgetData.LayerListData, *Item.LayerList_Item)
	; (Re)lay out one row's text block for its current indent level.
	*Item\Text\Width = LayerList_TextWidth(*GadgetData, *Item\Depth)
	*Item\Text\Height = *GadgetData\ItemHeight
	PrepareVectorTextBlock(@*Item\Text)
EndProcedure

;- Drawing
Procedure LayerList_DrawFold(X, Y, Size, Folded)
	; A small triangle: pointing right when the group is folded, down when it's open.
	Protected CX.d = X + Size * 0.5, CY.d = Y + Size * 0.5
	
	If Folded
		MovePathCursor(CX - 2.5, CY - 4)
		AddPathLine(CX + 3.5, CY)
		AddPathLine(CX - 2.5, CY + 4)
	Else
		MovePathCursor(CX - 4, CY - 2.5)
		AddPathLine(CX + 4, CY - 2.5)
		AddPathLine(CX, CY + 3.5)
	EndIf
	
	ClosePath()
	FillPath()
EndProcedure

Procedure LayerList_DrawEye(X, Y, Width, Height, Visible)
	; An eye outline with a pupil; struck through when the row is switched off.
	Protected CX.d = X + Width * 0.5, CY.d = Y + Height * 0.5
	
	AddPathEllipse(CX, CY, 6.5, 4.2)
	StrokePath(1.2)
	AddPathCircle(CX, CY, 2.1)
	FillPath()
	
	If Not Visible
		MovePathCursor(CX - 7, CY + 5.5)
		AddPathLine(CX + 7, CY - 5.5)
		StrokePath(1.4)
	EndIf
EndProcedure

Procedure LayerList_DrawLock(X, Y, Width, Height, Locked)
	Protected CX.d = X + Width * 0.5, CY.d = Y + Height * 0.5
	Protected BodyW.d = 9, BodyH.d = 7
	
	If Locked
		AddPathEllipse(CX, CY - BodyH * 0.5, 3.1, 3.1, 180, 360)
	Else
		AddPathEllipse(CX + 2.2, CY - BodyH * 0.5, 3.1, 3.1, 180, 330)
	EndIf
	StrokePath(1.3)
	AddPathBox(CX - BodyW * 0.5, CY - BodyH * 0.5, BodyW, BodyH)
	If Locked
		FillPath()
	Else
		StrokePath(1.3)
	EndIf
EndProcedure

Procedure LayerList_ItemRedraw(*Item.LayerList_Item, X, Y, Width, Height, State, *Theme.Theme)
	; Default row content. The gadget has already painted the row shade and set the
	; source colour, and it draws the chevron and the eye itself — a *CustomItem
	; callback only has to fill this content rectangle.
	DrawVectorTextBlock(@*Item\Text, X, Y)
EndProcedure

Procedure LayerList_Redraw(*GadgetData.LayerListData)
	Protected Y, Row, FirstRow, Rows, Index, ShadeState, TextState, TextX, EyeX, MarkerX, MarkerY
	
	With *GadgetData
		If \Border
			AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
			VectorSourceColor(\ThemeData\LineColor[#Cold])
			StrokePath(2, #PB_Path_Preserve)
		Else
			AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
		EndIf
		
		VectorSourceColor(\ThemeData\ShadeColor[#Cold])
		ClipPath(#PB_Path_Preserve)
		FillPath()
		
		If Not ListSize(\Items())
			ProcedureReturn
		EndIf
		
		Rows = LayerList_RowCount(*GadgetData)
		EyeX = \OriginX + LayerList_EyeX(*GadgetData)
		
		Y = \OriginY + \Border
		If \VisibleScrollBar
			FirstRow = Floor(\ScrollBar\State / \ItemHeight)
			Y - (\ScrollBar\State % \ItemHeight)
		EndIf
		
		Row = FirstRow
		MarkerY = -1
		
		While Y < \OriginY + \Height
			Index = LayerList_RowToIndex(*GadgetData, Row)
			If Index = -1
				Break
			EndIf
			
			If Row = \ReorderRow
				MarkerY = Y
			EndIf
			
			SelectElement(\Items(), Index)
			
			If \Items()\Selected	; NOT the focus row: a padlock click moves that on purpose
				ShadeState = #Hot
			ElseIf Index = \ItemState
				ShadeState = #Warm
			Else
				ShadeState = #Cold
			EndIf
			
			; A row that doesn't show through is drawn in the disabled ink, so a whole
			; switched-off group reads as inactive without losing hover or selection.
			If LayerList_EffectiveVisible(*GadgetData, Index)
				TextState = ShadeState
			Else
				TextState = #Disabled
			EndIf
			
			SelectElement(\Items(), Index)
			
			If ShadeState > #Cold
				AddPathBox(\OriginX + \Border, Y, \Width - \Border * 2, \ItemHeight)
				VectorSourceColor(\ThemeData\ShadeColor[ShadeState])
				FillPath()
			EndIf
			
			; Fold chevron — any row holding a subtree, at its own indent.
			If LayerList_ChildCount(*GadgetData, Index)
				SelectElement(\Items(), Index)
				VectorSourceColor(\ThemeData\TextColor[TextState])
				LayerList_DrawFold(\OriginX + \Border + LayerList_IndentOf(\Items()\Depth) - #LayerList_FoldWidth, Y, #LayerList_FoldWidth, \Items()\Folded)
			EndIf
			SelectElement(\Items(), Index)
			
			TextX = \OriginX + LayerList_TextX(*GadgetData, \Items()\Depth)
			VectorSourceColor(\ThemeData\TextColor[TextState])
			\ItemRedraw(@\Items(), TextX, Y, \Items()\Text\Width, \ItemHeight, TextState, \ThemeData)
			
			SelectElement(\Items(), Index)
			VectorSourceColor(\ThemeData\TextColor[TextState])
			LayerList_DrawEye(EyeX, Y, #LayerList_EyeWidth, \ItemHeight, \Items()\Visible)
			
			SelectElement(\Items(), Index)
			If \Items()\Locked	; a shut padlock speaks up; an open one keeps quiet
				VectorSourceColor(\ThemeData\TextColor[TextState])
			Else
				VectorSourceColor(\ThemeData\TextColor[#Disabled])
			EndIf
			LayerList_DrawLock(\OriginX + LayerList_LockX(*GadgetData), Y, #LayerList_LockWidth, \ItemHeight, \Items()\Locked)
			
			Y + \ItemHeight
			Row + 1
		Wend
		
		If \ReorderRow = Rows And Rows >= Row
			MarkerY = Y			; dropping past the last row
		EndIf
		
		If \ReorderRow > -1 And MarkerY > -1
			; Indent the marker to the depth in flight, so it's clear what it lands inside.
			MarkerX = \OriginX + \Border
			If \DragDepth > 0
				MarkerX + LayerList_IndentOf(\DragDepth)
			EndIf
			AddPathBox(MarkerX, MarkerY - #LayerList_MarkerHeight * 0.5, \Width - \Border * 2 - (MarkerX - \OriginX - \Border), #LayerList_MarkerHeight)
			VectorSourceColor(\ThemeData\TextColor[#Hot])
			FillPath()
		EndIf
		
		If \Editing
			SaveVectorState()
			\String\Redraw(\String)
			RestoreVectorState()
		EndIf
		
		If \VisibleScrollBar
			\ScrollBar\Redraw(\ScrollBar)
		EndIf
	EndWith
EndProcedure

;- Scrolling and reordering
Procedure LayerList_StateFocus(*GadgetData.LayerListData)
	; Scroll the selected row into view.
	Protected Result, Row
	
	With *GadgetData
		If \VisibleScrollBar
			Row = LayerList_IndexToRow(*GadgetData, \State)
			
			If Row > -1
				If Ceil(\ScrollBar\State / \ItemHeight) > Row
					ScrollBar_SetState_Meta(\ScrollBar, Row * \ItemHeight)
					Result = #True
				ElseIf Floor((\ScrollBar\State + \Height - \ItemHeight) / \ItemHeight) < Row
					ScrollBar_SetState_Meta(\ScrollBar, Row * \ItemHeight - \Height + \ItemHeight)
					Result = #True
				EndIf
			EndIf
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure LayerList_DropRow(*GadgetData.LayerListData, MouseY)
	; The landing row, legalised: a top-level row only ever lands between top-level rows
	Protected Row, Rows, R, Best, BestDistance, Distance, Hidden = -1
	
	With *GadgetData
		Rows = LayerList_RowCount(*GadgetData)
		Row = Clamp(Floor((MouseY + LayerList_ScrollOffset(*GadgetData) + \ItemHeight * 0.5) / \ItemHeight), 0, Rows)
		
		If \DragDepth > 0
			If Row < \DragDepth
				Row = \DragDepth	; a nested row always has something to belong to
			EndIf
		Else
			Best = Rows
			BestDistance = Abs(Rows - Row)
			
			ForEach \Items()
				If Hidden >= 0
					If \Items()\Depth > Hidden
						Continue
					EndIf
					Hidden = -1
				EndIf
				If \Items()\Depth = 0
					Distance = Abs(R - Row)
					If Distance < BestDistance
						BestDistance = Distance
						Best = R
					EndIf
				EndIf
				If \Items()\Folded
					Hidden = \Items()\Depth
				EndIf
				R + 1
			Next
			
			Row = Best
		EndIf
	EndWith
	
	ProcedureReturn Row
EndProcedure

Procedure LayerList_DragSetKind(*GadgetData.LayerListData)
	; What a drag is carrying: 0 = just the row that was grabbed, 1 = every selected row and
	; they're all children, 2 = every selected row and they're all groups.
	;
	; Only those two homogeneous shapes move as a set. A selection mixing groups with loose
	; children has no one sensible landing place - dropping it somewhere would have to invent
	; an answer - so it falls back to dragging the single grabbed row.
	Protected Children, Groups
	
	With *GadgetData
		If Not \MultiSelect Or Not LayerList_IsSelected(*GadgetData, \DragIndex)
			ProcedureReturn 0
		EndIf
		
		ForEach \Items()
			If \Items()\Selected
				If \Items()\Depth > 0
					Children + 1
				Else
					Groups + 1
				EndIf
			EndIf
		Next
		
		If Children + Groups < 2
			ProcedureReturn 0
		ElseIf Groups = 0
			ProcedureReturn 1
		ElseIf Children = 0
			ProcedureReturn 2
		EndIf
	EndWith
	
	ProcedureReturn 0
EndProcedure

Procedure LayerList_ApplyDrop(*GadgetData.LayerListData)
	; Move what's in flight to \ReorderRow. Linked-list element addresses survive MoveElement,
	; so everything travels by re-inserting its elements, in order, before the destination
	; element - which also covers "insert before the next group", the position that means
	; "append to the group above".
	;
	; A homogeneous multi-selection moves as a set: several children collapse into the target
	; group in list order, several groups reorder as a run with their own children in tow.
	Protected *Destination, *Dragged, DestinationIndex, Parent
	Protected NewList Roots.i()
	Protected NewList Block.i()
	
	With *GadgetData
		If \ReorderRow < 0
			ProcedureReturn
		EndIf
		
		DestinationIndex = LayerList_RowToIndex(*GadgetData, \ReorderRow)
		If DestinationIndex > -1 And SelectElement(\Items(), DestinationIndex)
			*Destination = @\Items()
		EndIf
		
		If Not SelectElement(\Items(), \DragIndex)
			ProcedureReturn
		EndIf
		*Dragged = @\Items()
		
		; The rows to move, in list order.
		If LayerList_DragSetKind(*GadgetData)
			ForEach \Items()
				If \Items()\Selected
					AddElement(Roots())
					Roots() = @\Items()
				EndIf
			Next
		Else
			AddElement(Roots())
			Roots() = *Dragged
		EndIf
		
		; Each root, followed by its children when it's a group. A homogeneous set never holds
		; both a group and its own children, so nothing can land in the block twice.
		ForEach Roots()
			ChangeCurrentElement(\Items(), Roots())
			Protected RootDepth = \Items()\Depth
			AddElement(Block())
			Block() = @\Items()
			
			While NextElement(\Items()) And \Items()\Depth > RootDepth
				AddElement(Block())
				Block() = @\Items()
			Wend
		Next
		
		; Dropping inside the block being carried would be a no-op at best.
		ForEach Block()
			If Block() = *Destination
				ProcedureReturn
			EndIf
		Next
		
		ForEach Block()
			ChangeCurrentElement(\Items(), Block())
			If *Destination
				MoveElement(\Items(), #PB_List_Before, *Destination)
			Else
				MoveElement(\Items(), #PB_List_Last)
			EndIf
		Next
		
		ChangeCurrentElement(\Items(), *Dragged)
		\State = ListIndex(\Items())
		
		; A row dropped into a folded parent would vanish - open the parent instead.
		If \DragDepth > 0
			Parent = LayerList_ParentOf(*GadgetData, \State)
			If Parent > -1 And SelectElement(\Items(), Parent)
				\Items()\Folded = #False
			EndIf
		EndIf
	EndWith
EndProcedure

Procedure LayerList_ReorderTimer(*GadgetData.LayerListData, Timer)
	; Auto-scroll while the pointer is held past the top or bottom edge.
	Protected Event.Event
	
	With *GadgetData
		Event\EventType = #MouseMove
		Event\MouseX = WindowX(\ReorderWindow) - \DragOriginX
		Event\MouseY = WindowY(\ReorderWindow) - \DragOriginY
		
		If \ReorderDirection = -1
			If \ScrollBar\State > 0
				ScrollBar_SetState_Meta(\ScrollBar, Max(0, \ScrollBar\State - \ItemHeight))
				LayerList_EventHandler(*GadgetData, @Event)
			EndIf
		Else
			If \ScrollBar\State < \ScrollBar\Max - \ScrollBar\PageLength
				ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State + \ItemHeight)
				LayerList_EventHandler(*GadgetData, @Event)
			EndIf
		EndIf
	EndWith
EndProcedure

Procedure LayerList_DragCanvasHandler()
	; The floating preview swallows the wheel while it's under the pointer; hand it back.
	Protected Gadget = EventGadget(), *GadgetData.LayerListData = GetProp_(GadgetID(Gadget), "UITK_LayerData"), Event.Event
	
	Event\EventType = #MouseWheel
	Event\MouseX = WindowX(*GadgetData\ReorderWindow) - *GadgetData\DragOriginX
	Event\MouseY = WindowY(*GadgetData\ReorderWindow) - *GadgetData\DragOriginY
	Event\Param = GetGadgetAttribute(*GadgetData\ReorderCanvas, #PB_Canvas_WheelDelta)
	
	LayerList_EventHandler(*GadgetData, @Event)
EndProcedure

Procedure LayerList_StartReorder(*GadgetData.LayerListData, *Event.Event)
	; Fill the floating preview with the grabbed row and show it under the cursor.
	Protected Row
	
	With *GadgetData
		If Not SelectElement(\Items(), \DragIndex)
			ProcedureReturn
		EndIf
		
		\DragDepth = \Items()\Depth
		\DragState = #Drag_Active
		
		Row = LayerList_IndexToRow(*GadgetData, \DragIndex)
		\DragOriginX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginX
		\DragOriginY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginY + Row * \ItemHeight - LayerList_ScrollOffset(*GadgetData)
		
		StartVectorDrawing(CanvasVectorOutput(\ReorderCanvas))
		AddPathBox(0, 0, \Width, \ItemHeight)
		VectorSourceColor(\ThemeData\ShadeColor[#Hot])
		FillPath()
		
		SelectElement(\Items(), \DragIndex)
		VectorSourceColor(\ThemeData\TextColor[#Hot])
		\ItemRedraw(@\Items(), LayerList_TextX(*GadgetData, \Items()\Depth), 0, \Items()\Text\Width, \ItemHeight, #Hot, \ThemeData)
		StopVectorDrawing()
		
		\ReorderRow = LayerList_DropRow(*GadgetData, *Event\MouseY)
		
		ResizeWindow(\ReorderWindow, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, #PB_Ignore, #PB_Ignore)
		HideWindow(\ReorderWindow, #False, #PB_Window_NoActivate)
		SetActiveGadget(\Gadget)
	EndWith
EndProcedure

;- Inline renaming (#Editable)
Procedure LayerList_BeginEdit(*GadgetData.LayerListData)
	; Drop the editor over the selected row. Refused when there's nothing to edit, or when
	; the row can't be seen - editing a row tucked inside a folded group would put the box
	; nowhere useful.
	Protected Event.Event, Row
	
	With *GadgetData
		If Not \Editable Or \Editing Or \State < 0
			ProcedureReturn #False
		EndIf
		
		Row = LayerList_IndexToRow(*GadgetData, \State)
		If Row < 0 Or Not SelectElement(\Items(), \State)
			ProcedureReturn #False
		EndIf
		
		\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
		\String\String = \Items()\Text\OriginalText
		String_ProcessString(\String)
		
		; Sit exactly where the row's text is drawn: the row's content origin plus the text
		; block's own offset, which already accounts for the item's icon. That offset has to
		; come back off the width too, or the box overshoots to the right by the width of the
		; icon and covers the eye.
		\String\OriginX = LayerList_TextX(*GadgetData, \Items()\Depth) + \Items()\Text\TextX
		\String\OriginY = \Border + Row * \ItemHeight - LayerList_ScrollOffset(*GadgetData) + \Items()\Text\TextY - 2
		\String\Width = \Items()\Text\Width - \Items()\Text\TextX
		
		Event\EventType = #Focus
		\String\EventHandler(\String, Event)
		StringSetSelection_Meta(\String, 0, Len(\String\String))
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure LayerList_EndEdit(*GadgetData.LayerListData, Keep)
	; Fold the editor away. Keep writes the typed text back into the row and reports it
	; with #EventType_ItemTextChange; otherwise the row keeps the text it had (Escape, or
	; the row being removed from under the editor).
	Protected Event.Event
	
	With *GadgetData
		If Not \Editing
			ProcedureReturn #False
		EndIf
		
		\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
		
		; \EditCursor means "the pointer is inside the editor", and every
		; click consults it to decide between typing and clicking the row.
		; It must not outlive the editor: left standing it sends the NEXT
		; click into a String that is no longer open, and nothing works
		; again until the pointer happens to cross a row body.
		If \EditCursor
			\EditCursor = #PB_Cursor_Default
			\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_Default)
		EndIf
		
		If Keep And SelectElement(\Items(), \State)
			\Items()\Text\OriginalText = \String\String
			LayerList_PrepareItem(*GadgetData, @\Items())
			PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
		EndIf
		
		Event\EventType = #LostFocus
		\String\EventHandler(\String, Event)
	EndWith
	
	ProcedureReturn #True
EndProcedure

;- Events
Procedure LayerList_EventHandler(*GadgetData.LayerListData, *Event.Event)
	Protected Redraw, Row, Index, Zone, Rows, Modifiers, Cursor = *GadgetData\EditCursor, CursorWas = Cursor
	
	With *GadgetData
		Select *Event\EventType
			Case #MouseMove ;{
				If \String And \String\Selecting ;{ dragging out a selection inside the editor
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
					;}
				ElseIf \DragState = #Drag_Init ;{ waiting to clear the drag threshold
					If Abs(\DragOriginX - *Event\MouseX) > #Drag_Distance Or Abs(\DragOriginY - *Event\MouseY) > #Drag_Distance
						LayerList_StartReorder(*GadgetData, *Event)
						Redraw = #True
					EndIf
					;}
				ElseIf \DragState = #Drag_Active ;{ carrying a row
					SetWindowPos_(WindowID(\ReorderWindow), 0, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, 0, 0, #SWP_NOSIZE | #SWP_NOZORDER | #SWP_NOREDRAW)
					
					If \VisibleScrollBar
						If *Event\MouseY < 0
							If Not \ReorderTimer
								\ReorderTimer = AddGadgetTimer(*GadgetData, #LayerList_ReorderDelay, @LayerList_ReorderTimer())
								\ReorderDirection = -1
							EndIf
							*Event\MouseY = 0
						ElseIf *Event\MouseY > \Height
							If Not \ReorderTimer
								\ReorderTimer = AddGadgetTimer(*GadgetData, #LayerList_ReorderDelay, @LayerList_ReorderTimer())
								\ReorderDirection = 1
							EndIf
							*Event\MouseY = \Height
						ElseIf \ReorderTimer
							RemoveGadgetTimer(\ReorderTimer)
							\ReorderTimer = 0
						EndIf
					EndIf
					
					Row = LayerList_DropRow(*GadgetData, *Event\MouseY)
					If Row <> \ReorderRow
						\ReorderRow = Row
						Redraw = #True
					EndIf
					;}
				Else;{ plain hover
					Cursor = #PB_Cursor_Default
					
					If \VisibleScrollBar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ScrollBar\MouseState
						\ScrollBar\MouseState = #False
						Redraw = #True
					EndIf
					
					If \ScrollBar\MouseState
						If \ItemState > -1
							\ItemState = -1
							Redraw = #True
						EndIf
					Else
						Index = LayerList_RowToIndex(*GadgetData, Floor((*Event\MouseY + LayerList_ScrollOffset(*GadgetData)) / \ItemHeight))
						
						If Index > -1
							Zone = LayerList_ZoneAt(*GadgetData, Index, *Event\MouseX)
						Else
							Zone = #LayerList_Zone_Body
						EndIf
						
						If Index <> \ItemState Or Zone <> \HoverZone
							\ItemState = Index
							\HoverZone = Zone
							Redraw = #True
						EndIf
						
						; Over the open editor the pointer becomes a caret, which is also how
						; #LeftButtonDown below knows the click belongs to the editor. The
						; RIGHT edge matters as much as the left: the editor deliberately
						; stops short of the eye, so without that bound the eye counted as
						; "inside the editor" - clicking it placed a caret instead of
						; committing the name, and the caret cursor stuck.
						If \Editing And Index = \State
							If *Event\MouseX > \String\OriginX And *Event\MouseX < \String\OriginX + \String\Width And *Event\MouseY > \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height
								Cursor = #PB_Cursor_IBeam
							EndIf
						EndIf
					EndIf
				EndIf ;}
					  ;}
			Case #LeftButtonDown ;{
								 ; A click anywhere but inside the editor commits what was being typed - on a
								 ; row, on the scrollbar, or on empty space below the rows.
				If Not \EditCursor
					Redraw = LayerList_EndEdit(*GadgetData, #True)
				EndIf
				
				If \EditCursor ;{ inside the open editor: the click places the caret
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
					;}
				ElseIf \ScrollBar\MouseState
					Redraw + ScrollBar_EventHandler(\ScrollBar, *Event)
				ElseIf \ItemState > -1
					Index = \ItemState
					Modifiers = GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers)
					
					; Whatever was clicked, the row it belongs to becomes the focus, so a handler
					; can read GetGadgetState for every one of the events below.
					If Index <> \State
						Redraw = #True
					EndIf
					
					Select \HoverZone
						Case #LayerList_Zone_Fold ;{
							\State = Index
							If LayerList_ChildCount(*GadgetData, Index) And SelectElement(\Items(), Index)
								\Items()\Folded = Bool(Not \Items()\Folded)
								LayerList_UpdateScrollBar(*GadgetData)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerFold)
								Redraw = #True
							EndIf
							;}
						Case #LayerList_Zone_Eye ;{
							\State = Index
							LayerList_ToggleVisibility(*GadgetData, Index)
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerVisibility)
							Redraw = #True
							;}
						Case #LayerList_Zone_Lock ;{
							\State = Index
							LayerList_ToggleLock(*GadgetData, Index)
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerLock)
							Redraw = #True
							;}
						Default ;{ the row body: pick the selection, then arm a drag
							If LayerList_ClickSelect(*GadgetData, Index, Modifiers)
								Redraw = #True
							EndIf
							
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							
							; Depth 2 and deeper never lifts: DropRow has no landing place it could honestly draw
							If \Reorder And LayerList_DepthAt(*GadgetData, Index) < 2
								\DragState = #Drag_Init
								\DragIndex = Index
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							EndIf
							;}
					EndSelect
				Else
					; A press on empty space below the rows drops the selection.
					If \MultiSelect And LayerList_SelectedCount(*GadgetData)
						LayerList_SelectOnly(*GadgetData, -1)
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
						Redraw = #True
					EndIf
				EndIf
				;}
			Case #LeftButtonUp ;{
				If \Editing And \String\Selecting	; the editor's own press needs its release, or Selecting sticks
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
				ElseIf \ScrollBar\Drag
					Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
				ElseIf \DragState = #Drag_Active
					LayerList_ApplyDrop(*GadgetData)
					
					HideWindow(\ReorderWindow, #True)
					
					If \ReorderTimer
						RemoveGadgetTimer(\ReorderTimer)
						\ReorderTimer = 0
					EndIf
					
					\ReorderRow = -1
					LayerList_UpdateScrollBar(*GadgetData)
					LayerList_StateFocus(*GadgetData)
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
					Redraw = #True
				ElseIf \PendingSelect > -1
					; The press landed on an already-selected row and never became a drag, so
					; it was a plain click after all: collapse onto that row now.
					LayerList_SelectOnly(*GadgetData, \PendingSelect)
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
					Redraw = #True
				EndIf
				
				\PendingSelect = -1
				\DragState = #Drag_None
				;}
			Case #MouseLeave ;{
				If \ScrollBar\MouseState
					Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
				EndIf
				
				If \ItemState > -1
					\ItemState = -1
					Redraw = #True
				EndIf
				;}
			Case #MouseWheel ;{
							 ; Commit first: the editor is placed against a row's screen position, so
							 ; scrolling would leave it stranded away from the row it belongs to.
				Redraw = LayerList_EndEdit(*GadgetData, #True)
				
				If \VisibleScrollBar
					ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 0.5)
					*Event\EventType = #MouseMove
					Redraw + Bool(Not LayerList_EventHandler(*GadgetData, *Event))
				EndIf
				;}
			Case #LeftDoubleClick ;{
								  ; Asked fresh, not the cached hover: the click under this one may have rebuilt the list to -1
				Index = LayerList_RowToIndex(*GadgetData, Floor((*Event\MouseY + LayerList_ScrollOffset(*GadgetData)) / \ItemHeight))
				If Index > -1
					\ItemState = Index	; Put the hover back, so the row it landed on draws hot
					\HoverZone = LayerList_ZoneAt(*GadgetData, Index, *Event\MouseX)
					\State = Index	; …and FOCUS it: the host reads the hit row back with GetGadgetState
				EndIf
				If Index > -1
					If \HoverZone = #LayerList_Zone_Body
						; The press under this double-click half-armed a reorder
						; drag. The gesture supersedes it — and the app may well
						; answer the posted event by opening the row's inline
						; editor, which a pending drag arm would refuse
						\DragState = #Drag_None
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ForcefulChange)
					EndIf
				EndIf
				;}
			Case #KeyDown ;{
				If \Editing ;{ the editor owns the keyboard while it's open
					Select *Event\Param
						Case #PB_Shortcut_Return
							Redraw = LayerList_EndEdit(*GadgetData, #True)
						Case #PB_Shortcut_Escape
							Redraw = LayerList_EndEdit(*GadgetData, #False)		; keep the old name
						Default
							Redraw = \String\EventHandler(\String, *Event)
					EndSelect
					;}
				ElseIf \DragState = #Drag_None
					Row = LayerList_IndexToRow(*GadgetData, \State)
					
					Select *Event\Param
						Case #PB_Shortcut_Down ;{
							Index = LayerList_RowToIndex(*GadgetData, Row + 1)
							If Row > -1 And Index > -1
								LayerList_MoveFocus(*GadgetData, Index)
								LayerList_StateFocus(*GadgetData)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
								Redraw = #True
							EndIf
							;}
						Case #PB_Shortcut_Up ;{
							If Row > 0
								LayerList_MoveFocus(*GadgetData, LayerList_RowToIndex(*GadgetData, Row - 1))
								LayerList_StateFocus(*GadgetData)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
								Redraw = #True
							EndIf
							;}
						Case #PB_Shortcut_Left ;{ fold the row, or jump to the one it sits inside
							If SelectElement(\Items(), \State)
								; An open row holding a subtree closes; anything else steps out to its parent
								If \Items()\Folded Or Not LayerList_ChildCount(*GadgetData, \State)
									Index = LayerList_ParentOf(*GadgetData, \State)
									If Index > -1
										LayerList_SelectOnly(*GadgetData, Index)	; …and selects it, as every other arrow key does
										PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
										Redraw = #True
									EndIf
								ElseIf SelectElement(\Items(), \State)
									\Items()\Folded = #True
									LayerList_UpdateScrollBar(*GadgetData)
									PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerFold)
									Redraw = #True
								EndIf
							EndIf
							;}
						Case #PB_Shortcut_Right ;{ open the row
							If SelectElement(\Items(), \State) And \Items()\Folded
								\Items()\Folded = #False
								LayerList_UpdateScrollBar(*GadgetData)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerFold)
								Redraw = #True
							EndIf
							;}
						Case #PB_Shortcut_Space ;{ toggle the eye - ctrl+space toggles the selection instead
							If \MultiSelect And (GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Control)
								If SelectElement(\Items(), \State)
									\Items()\Selected = Bool(Not \Items()\Selected)
									\SelectAnchor = \State
									PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
									Redraw = #True
								EndIf
							ElseIf \State > -1
								LayerList_ToggleVisibility(*GadgetData, \State)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerVisibility)
								Redraw = #True
							EndIf
							;}
						Case #PB_Shortcut_F2 ;{ rename the selected row in place
							Redraw = LayerList_BeginEdit(*GadgetData)
							;}
					EndSelect
				EndIf
				;}
			Case #LostFocus ;{ clicking away from the gadget commits the rename
				Redraw = LayerList_EndEdit(*GadgetData, #True)
				;}
			Default ;{ #Input and the rest belong to the editor while it's open
				If \Editing
					Redraw = \String\EventHandler(\String, *Event)
				EndIf
				;}
		EndSelect
		
		If Cursor <> \EditCursor And Cursor <> CursorWas	; only a hover decided here wins; never undo EndEdit's clear
			\EditCursor = Cursor
			\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
		EndIf
		
		If Redraw
			RedrawObject()
		EndIf
	EndWith
	
	ProcedureReturn Redraw
EndProcedure

;- Items
Procedure LayerList_AddItem(*this.PB_Gadget, Position.l, *Text, ImageID, Level.l)
	; Level is CLAMPED one step deeper than the row before, so no row is left without a parent
	Protected *GadgetData.LayerListData = *this\vt, *NewItem.LayerList_Item, Depth, Ceiling
	
	With *GadgetData
		If Level < 0
			Level = 0
		EndIf
		
		If Position > -1 And Position < ListSize(\Items())
			SelectElement(\Items(), Position)
			*NewItem = InsertElement(\Items())
		Else
			LastElement(\Items())
			*NewItem = AddElement(\Items())
		EndIf
		
		Depth = Level
		If PreviousElement(\Items())
			Ceiling = \Items()\Depth + 1
			ChangeCurrentElement(\Items(), *NewItem)
		Else
			Ceiling = 0			; first in the list: nothing above it to belong to
			ChangeCurrentElement(\Items(), *NewItem)
		EndIf
		If Depth > Ceiling
			Depth = Ceiling
		EndIf
		
		*NewItem\Depth = Depth
		*NewItem\Visible = #True
		*NewItem\Text\OriginalText = PeekS(*Text)
		*NewItem\Text\Image = ImageID
		*NewItem\Text\LineLimit = 1
		*NewItem\Text\FontID = \TextBlock\FontID
		*NewItem\Text\FontScale = \TextBlock\FontScale
		*NewItem\Text\VAlign = \TextBlock\VAlign
		*NewItem\Text\HAlign = \TextBlock\HAlign
		
		LayerList_PrepareItem(*GadgetData, *NewItem)
		
		ChangeCurrentElement(\Items(), *NewItem)
		Position = ListIndex(\Items())
		
		If Position <= \State
			\State + 1
		EndIf
		
		LayerList_UpdateScrollBar(*GadgetData)
		RedrawObject()
	EndWith
	
	ProcedureReturn Position
EndProcedure

Procedure LayerList_RemoveItem(*this.PB_Gadget, Position.l)
	; Removing a row takes its whole subtree with it.
	Protected *GadgetData.LayerListData = *this\vt, Count, Loop
	
	With *GadgetData
		; Drop the editor rather than let it commit into whatever lands on this index.
		LayerList_EndEdit(*GadgetData, #False)
		
		If Position > -1 And Position < ListSize(\Items())
			SelectElement(\Items(), Position)
			
			Count = 1 + LayerList_ChildCount(*GadgetData, Position)
			
			For Loop = 1 To Count
				If SelectElement(\Items(), Position)
					DeleteElement(\Items())
				EndIf
			Next
			
			If \State > Position
				\State = Max(-1, \State - Count)
			ElseIf \State >= Position
				\State = -1
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
			EndIf
			
			\ItemState = -1
			LayerList_UpdateScrollBar(*GadgetData)
			RedrawObject()
			
			ProcedureReturn #True
		EndIf
	EndWith
EndProcedure

Procedure LayerList_ClearItems(*this.PB_Gadget)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		LayerList_EndEdit(*GadgetData, #False)
		ClearList(\Items())
		\State = -1
		\ItemState = -1
		\ReorderRow = -1
		LayerList_UpdateScrollBar(*GadgetData)
		RedrawObject()
	EndWith
EndProcedure

Procedure LayerList_CountItem(*this.PB_Gadget)
	Protected *GadgetData.LayerListData = *this\vt
	ProcedureReturn ListSize(*GadgetData\Items())
EndProcedure

Procedure LayerList_GetItemState(*this.PB_Gadget, Position.l)
	; Nonzero when the row is selected - same answer a ListViewGadget gives.
	Protected *GadgetData.LayerListData = *this\vt
	
	ProcedureReturn LayerList_IsSelected(*GadgetData, Position)
EndProcedure

Procedure LayerList_SetItemState(*this.PB_Gadget, Position.l, State.l)
	; Select or deselect one row. Without #MultiSelect, selecting a row moves the selection
	; onto it, since there can only ever be one.
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		If Position < 0 Or Position >= ListSize(\Items())
			ProcedureReturn
		EndIf
		
		If Not \MultiSelect
			If State
				LayerList_SelectOnly(*GadgetData, Position)
			Else
				LayerList_SelectOnly(*GadgetData, -1)
			EndIf
		ElseIf SelectElement(\Items(), Position)
			\Items()\Selected = Bool(State)
			If State
				\State = Position
				\SelectAnchor = Position
			EndIf
		EndIf
		
		RedrawObject()
	EndWith
EndProcedure

Procedure LayerList_SetState(*this.PB_Gadget, State)
	; -1 clears the selection, anything else selects that row alone - as SetGadgetState does
	; on a ListViewGadget. Going through here keeps the per-item flags and \State in step.
	Protected *GadgetData.LayerListData = *this\vt
	
	If State < 0 Or State >= ListSize(*GadgetData\Items())
		State = -1
	EndIf
	
	LayerList_SelectOnly(*GadgetData, State)
	RedrawObject()
EndProcedure

Procedure LayerList_GetItemAttribute(*this.PB_Gadget, Position.l, Attribute.l)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		If Position > -1 And Position < ListSize(\Items())
			Select Attribute
				Case #Attribute_LayerList_Visible
					If SelectElement(\Items(), Position)
						ProcedureReturn \Items()\Visible
					EndIf
				Case #Attribute_LayerList_EffectiveVisible
					ProcedureReturn LayerList_EffectiveVisible(*GadgetData, Position)
				Case #Attribute_LayerList_Folded
					If SelectElement(\Items(), Position)
						ProcedureReturn \Items()\Folded
					EndIf
				Case #Attribute_LayerList_IsChild
					If SelectElement(\Items(), Position)
						ProcedureReturn Bool(\Items()\Depth > 0)
					EndIf
				Case #Attribute_LayerList_Depth
					ProcedureReturn LayerList_DepthAt(*GadgetData, Position)
				Case #Attribute_LayerList_ScreenRow
					ProcedureReturn LayerList_IndexToRow(*GadgetData, Position)
				Case #Attribute_LayerList_Parent
					ProcedureReturn LayerList_ParentOf(*GadgetData, Position)
				Case #Attribute_LayerList_ChildCount
					ProcedureReturn LayerList_ChildCount(*GadgetData, Position)
				Case #Attribute_LayerList_Locked
					If SelectElement(\Items(), Position)
						ProcedureReturn \Items()\Locked
					EndIf
			EndSelect
		EndIf
	EndWith
	
	ProcedureReturn -1
EndProcedure

Procedure LayerList_SetItemAttribute(*this.PB_Gadget, Position.l, Attribute.l, Value.l)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		If Position > -1 And SelectElement(\Items(), Position)
			Select Attribute
				Case #Attribute_LayerList_Visible
					\Items()\Visible = Bool(Value)
					RedrawObject()
				Case #Attribute_LayerList_Locked
					\Items()\Locked = Bool(Value)
					RedrawObject()
				Case #Attribute_LayerList_Folded
					If LayerList_ChildCount(*GadgetData, Position) And SelectElement(\Items(), Position)
						\Items()\Folded = Bool(Value)
						LayerList_UpdateScrollBar(*GadgetData)
						RedrawObject()
					EndIf
			EndSelect
		EndIf
	EndWith
EndProcedure

Procedure LayerList_GetItemData(*this.PB_Gadget, Position.l)
	Protected *GadgetData.LayerListData = *this\vt, *Result
	
	If Position > -1 And SelectElement(*GadgetData\Items(), Position)
		*Result = *GadgetData\Items()\Data
	EndIf
	
	ProcedureReturn *Result
EndProcedure

Procedure LayerList_SetItemData(*this.PB_Gadget, Position.l, *Data)
	Protected *GadgetData.LayerListData = *this\vt
	
	If Position > -1 And SelectElement(*GadgetData\Items(), Position)
		*GadgetData\Items()\Data = *Data
	EndIf
EndProcedure

Procedure.s LayerList_GetItemText(*this.PB_Gadget, Position.l)
	Protected *GadgetData.LayerListData = *this\vt, Result.s
	
	If Position > -1 And SelectElement(*GadgetData\Items(), Position)
		Result = *GadgetData\Items()\Text\OriginalText
	EndIf
	
	ProcedureReturn Result
EndProcedure

Procedure LayerList_SetItemText(*this.PB_Gadget, Position.l, *Text)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		If Position > -1 And SelectElement(\Items(), Position)
			\Items()\Text\OriginalText = PeekS(*Text)
			LayerList_PrepareItem(*GadgetData, @\Items())
			RedrawObject()
			ProcedureReturn #True
		EndIf
	EndWith
EndProcedure

Procedure LayerList_GetItemImage(*this.PB_Gadget, Position)
	Protected *GadgetData.LayerListData = *this\vt
	
	If Position > -1 And SelectElement(*GadgetData\Items(), Position)
		ProcedureReturn *GadgetData\Items()\Text\Image
	EndIf
EndProcedure

Procedure LayerList_SetItemImage(*this.PB_Gadget, Position.l, ImageID)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		If Position > -1 And SelectElement(\Items(), Position)
			\Items()\Text\Image = ImageID
			LayerList_PrepareItem(*GadgetData, @\Items())
			RedrawObject()
		EndIf
	EndWith
EndProcedure

Procedure LayerList_SetAttribute(*this.PB_Gadget, Attribute.l, Value)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		Select Attribute
			Case #Attribute_ItemHeight ;{
				\ItemHeight = Value
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_ScrollStep, \ItemHeight)
				
				ForEach \Items()
					LayerList_PrepareItem(*GadgetData, @\Items())
				Next
				
				If \Reorder
					SetWindowPos_(WindowID(\ReorderWindow), 0, 0, 0, \Width, \ItemHeight, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
					ResizeGadget(\ReorderCanvas, 0, 0, \Width, \ItemHeight)
				EndIf
				
				LayerList_UpdateScrollBar(*GadgetData)
				;}
			Default ;{
				Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
				ProcedureReturn	; already redraws
								;}
		EndSelect
	EndWith
	
	RedrawObject()
EndProcedure

Procedure LayerList_SetFont(*this.PB_Gadget, FontID)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		\TextBlock\FontID = FontID
		
		ForEach \Items()
			\Items()\Text\FontID = FontID
			LayerList_PrepareItem(*GadgetData, @\Items())
		Next
		
		RedrawObject()
	EndWith
EndProcedure

Procedure LayerList_Resize(*this.PB_Gadget, x.l, y.l, Width.l, Height.l)
	Protected *GadgetData.LayerListData = *this\vt
	
	; The editor is placed against the current geometry, so settle it before moving things.
	LayerList_EndEdit(*GadgetData, #True)
	
	*this\VT = *GadgetData\OriginalVT
	ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
	*this\VT = *GadgetData
	
	With *GadgetData
		\Width = GadgetWidth(\Gadget)
		\Height = GadgetHeight(\Gadget)
		
		ForEach \Items()
			LayerList_PrepareItem(*GadgetData, @\Items())
		Next
		
		ScrollBar_ResizeMeta(\ScrollBar, \Width - #LayerList_ToolbarThickness - \Border - 1, \Border + 1, #LayerList_ToolbarThickness, \Height - \Border * 2 - 2)
		ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
		
		If \Reorder
			SetWindowPos_(WindowID(\ReorderWindow), 0, 0, 0, \Width, \ItemHeight, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
			ResizeGadget(\ReorderCanvas, 0, 0, \Width, \ItemHeight)
		EndIf
		
		LayerList_UpdateScrollBar(*GadgetData)
	EndWith
	
	RedrawObject()
EndProcedure

Procedure LayerList_FreeGadget(*this.PB_Gadget)
	Protected *GadgetData.LayerListData = *this\vt
	
	With *GadgetData
		If \ReorderTimer
			RemoveGadgetTimer(\ReorderTimer)
			\ReorderTimer = 0
		EndIf
		
		If \Reorder And IsWindow(\ReorderWindow)
			CloseWindow(\ReorderWindow)
		EndIf
		
		DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
		FreeStructureX(\ScrollBar)
		
		If \String
			RemoveGadgetTimers(\String)
			FreeMemory(\String\ThemeData)		; the editor's own copy of the theme
			FreeStructureX(\String)
		EndIf
	EndWith
	
	Default_FreeGadget(*this)
EndProcedure

Procedure LayerList_Meta(*GadgetData.LayerListData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags, *CustomItem)
	Protected GadgetList
	*GadgetData\ThemeData = *ThemeData
	InitializeObject(LayerList)
	
	With *GadgetData
		If Not (Flags & (#VAlignTop | #VAlignBottom))
			\TextBlock\VAlign = #VAlignCenter
		EndIf
		
		If *CustomItem
			\ItemRedraw = *CustomItem
		Else
			\ItemRedraw = @LayerList_ItemRedraw()
		EndIf
		
		\MultiSelect = Bool(Flags & #MultiSelect)
		\SelectAnchor = -1
		\PendingSelect = -1
		\ItemHeight = #LayerList_ItemHeight
		\State = -1
		\ItemState = -1
		\ReorderRow = -1
		\DragIndex = -1
		
		AllocateStructureX(\ScrollBar, ScrollBarData)
		ScrollBar_Meta(\ScrollBar, *ThemeData, -1, Width - #LayerList_ToolbarThickness - \Border - 1, \Border + 1, #LayerList_ToolbarThickness, Height - \Border * 2 - 2, 0, \ItemHeight, Height, #Gadget_Vertical)
		
		If Flags & #ReOrder
			GadgetList = UseGadgetList(0)
			\Reorder = #True
			\ReorderWindow = OpenWindow(#PB_Any, 0, 0, Width, \ItemHeight, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(CurrentWindow()))
			\ReorderCanvas = CanvasGadget(#PB_Any, 0, 0, Width, \ItemHeight)
			SetProp_(GadgetID(\ReorderCanvas), "UITK_LayerData", *GadgetData)
			BindGadgetEvent(\ReorderCanvas, @LayerList_DragCanvasHandler(), #PB_EventType_MouseWheel)
			SetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED)
			SetLayeredWindowAttributes_(WindowID(\ReorderWindow), 0, 128, #LWA_ALPHA)
			UseGadgetList(GadgetList)
		EndIf
		
		\VT\AddGadgetItem3 = @LayerList_AddItem()
		\VT\RemoveGadgetItem = @LayerList_RemoveItem()
		\VT\ClearGadgetItemList = @LayerList_ClearItems()
		\VT\CountGadgetItems = @LayerList_CountItem()
		\VT\GetGadgetItemState = @LayerList_GetItemState()
		\VT\SetGadgetItemState = @LayerList_SetItemState()
		\VT\SetGadgetState = @LayerList_SetState()
		\VT\GetGadgetItemAttribute2 = @LayerList_GetItemAttribute()
		\VT\SetGadgetItemAttribute2 = @LayerList_SetItemAttribute()
		\VT\GetGadgetItemData = @LayerList_GetItemData()
		\VT\SetGadgetItemData = @LayerList_SetItemData()
		\VT\GetGadgetItemText = @LayerList_GetItemText()
		\VT\SetGadgetItemText = @LayerList_SetItemText()
		\VT\GetGadgetItemImage = @LayerList_GetItemImage()
		\VT\SetGadgetItemImage = @LayerList_SetItemImage()
		\VT\SetGadgetAttribute = @LayerList_SetAttribute()
		\VT\SetGadgetFont = @LayerList_SetFont()
		\VT\ResizeGadget = @LayerList_Resize()
		\VT\FreeGadget = @LayerList_FreeGadget()
		
		; Enable only the needed events
		\SupportedEvent[#MouseMove] = #True
		\SupportedEvent[#MouseLeave] = #True
		\SupportedEvent[#MouseWheel] = #True
		\SupportedEvent[#LeftButtonDown] = #True
		\SupportedEvent[#LeftButtonUp] = #True
		\SupportedEvent[#LeftDoubleClick] = #True
		\SupportedEvent[#KeyDown] = #True
		
		; #Editable adds an inline editor: a String meta gadget parked over the row being
		; renamed. It needs the extra keyboard/focus events, hence String_SupportedEvents.
		Protected *StringThemeData.Theme
		\Editable = Bool(Flags & #Editable)
		\EditCursor = #PB_Cursor_Default
		
		If \Editable
			*StringThemeData = AllocateMemory(SizeOf(Theme))
			CopyMemory(*ThemeData, *StringThemeData, SizeOf(Theme))
			*StringThemeData\CornerRadius = 0
			*StringThemeData\ShadeColor[#Cold] = *ThemeData\ShadeColor[#Hot]
			AllocateStructureX(\String, StringData)
			String_Meta(\String, *StringThemeData, Gadget, 0, 0, \Width, \ItemHeight - 2, "", #HAlignLeft | #Gadget_Meta)
			String_SupportedEvents()
			CloseGadgetList()
		EndIf
	EndWith
EndProcedure

Procedure LayerList(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
	Protected Result, *this.PB_Gadget, *GadgetData.LayerListData, *ThemeData
	
	; #PB_Canvas_Container is what lets the inline rename editor live inside the canvas.
	Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Editable) * #PB_Canvas_Container))
	
	If Result
		CreateGadgetObject(LayerListData)
		LayerList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
		
		RedrawObject()
	EndIf
	
	ProcedureReturn Result
EndProcedure

; IDE Options = PureBasic 6.41 (Windows - x64)
; CursorPosition = 991
; FirstLine = 115
; Folding = AAAAAAAAAAAAAAw
; EnableXP
; DPIAware