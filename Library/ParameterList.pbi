#ParameterList_ItemHeight = 24
#ParameterList_HeaderHeight = 24
#ParameterList_Margin = 6
#ParameterList_FoldWidth = 14			; the chevron column, and the indent one child step costs
#ParameterList_ButtonWidth = 20			; the plus on a group row and the cross on a removable one
#ParameterList_ToolbarThickness = 7		; scrollbar - always reserved, so no column moves when it appears
#ParameterList_MinColumn = 48			; narrowest a column may be dragged
#ParameterList_GripWidth = 4			; grab zone either side of a column rule
#ParameterList_MaxColumn = 32

Enumeration ; Which part of a row the pointer is over
	#ParameterList_Zone_Body
	#ParameterList_Zone_Fold
	#ParameterList_Zone_Add
	#ParameterList_Zone_Remove
	#ParameterList_Zone_Cell
	#ParameterList_Zone_Grip
	#ParameterList_Zone_Header
EndEnumeration

Structure ParameterList_Column
	Text.Text
	Width.l
	Role.b
EndStructure

Structure ParameterList_Item
	Text.Text							; cell 0, kept first for the VerticalList-style callbacks
	Array Cells.Text(0)					; column c is Cells(c - 1)
	Kind.b
	Depth.b								; 0 = top level, 1 = inside the nearest shallower row above, and so on
	Folded.b
	Editable.l
	Removable.b
	Faulty.b
	Adder.b								; a group row that offers a plus
	*Data
EndStructure

Structure ParameterListData Extends GadgetData
	ItemHeight.l
	HeaderHeight.l
	VisibleScrollBar.b
	ItemState.i							; hovered row as a list index, or -1
	HoverZone.b
	HoverColumn.b
	ColumnCount.l
	StretchColumn.l
	ClickedColumn.b
	Array Columns.ParameterList_Column(0)
	DragGrip.b
	DragColumn.b
	DragSign.b
	DragOriginX.i
	DragOriginWidth.l
	
	Editable.l
	Editing.b
	EditRow.i							; list index under the LIVE editor
	EditColumn.b
	CommitRow.i							; …and the LAST COMMIT: read after the posted event, by when the editor may have moved on
	CommitColumn.b
	EditCursor.b						; the cursor in force, and so also "the pointer is inside the editor"
	
	*String.StringData					; the inline editor, only allocated with #Editable
	*ScrollBar.ScrollBarData
	
	List Items.ParameterList_Item()
EndStructure

;- Structure walking
; SelectElement() is only HALF a guard: an index past the end answers #False, but a NEGATIVE one is a runtime error
; …and -1 is exactly what RowToIndex answers for a pointer below the last row, and what \State holds with nothing picked
Procedure.i ParameterList_Select(*GadgetData.ParameterListData, Index)
	If Index < 0
		ProcedureReturn #False
	EndIf
	ProcedureReturn SelectElement(*GadgetData\Items(), Index)
EndProcedure

Procedure ParameterList_ChildCount(*GadgetData.ParameterListData, Parent)
	; The whole subtree under Parent, cursor put back: every caller reads \Items() either side of it
	Protected Count, Depth
	
	With *GadgetData
		PushListPosition(\Items())
		If ParameterList_Select(*GadgetData, Parent)
			Depth = \Items()\Depth
			While NextElement(\Items()) And \Items()\Depth > Depth
				Count + 1
			Wend
		EndIf
		PopListPosition(\Items())
	EndWith
	
	ProcedureReturn Count
EndProcedure

; HIDDEN is the depth of the shallowest folded row we are still inside, -1 out in the open
Procedure ParameterList_RowCount(*GadgetData.ParameterListData)
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

Procedure ParameterList_RowToIndex(*GadgetData.ParameterListData, Row)
	; Screen row -> list index, or -1 when Row is past the end
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

Procedure ParameterList_IndexToRow(*GadgetData.ParameterListData, Index)
	; List index -> screen row, or -1 when the row sits inside a folded subtree
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

;- Columns
Procedure.i ParameterList_Cell(*Item.ParameterList_Item, Column)
	If Column <= 0
		ProcedureReturn @*Item\Text
	EndIf
	ProcedureReturn @*Item\Cells(Column - 1)
EndProcedure

Procedure ParameterList_SizeCells(*GadgetData.ParameterListData, *Item.ParameterList_Item)
	; one spare either side of every index
	ReDim *Item\Cells(*GadgetData\ColumnCount)
EndProcedure

Procedure ParameterList_StretchIndex(*GadgetData.ParameterListData)
	With *GadgetData
		If \StretchColumn >= 0 And \StretchColumn < \ColumnCount
			ProcedureReturn \StretchColumn
		EndIf
		ProcedureReturn \ColumnCount - 1
	EndWith
EndProcedure

Procedure ParameterList_TreeColumn(*GadgetData.ParameterListData)
	Protected Loop
	
	With *GadgetData
		For Loop = 0 To \ColumnCount - 1
			If \Columns(Loop)\Role = #ParameterList_Tree
				ProcedureReturn Loop
			EndIf
		Next
	EndWith
	
	ProcedureReturn -1
EndProcedure

;- Geometry
Procedure ParameterList_ContentWidth(*GadgetData.ParameterListData)
	ProcedureReturn *GadgetData\Width - *GadgetData\Border * 2 - #ParameterList_ToolbarThickness - 2
EndProcedure

Procedure ParameterList_ColumnWidth(*GadgetData.ParameterListData, Column)
	Protected Width, Loop
	
	With *GadgetData
		If Column < 0 Or Column >= \ColumnCount
			ProcedureReturn 0
		EndIf
		If Column <> ParameterList_StretchIndex(*GadgetData)
			ProcedureReturn \Columns(Column)\Width
		EndIf
		
		Width = ParameterList_ContentWidth(*GadgetData)
		For Loop = 0 To \ColumnCount - 1
			If Loop <> Column
				Width - \Columns(Loop)\Width
			EndIf
		Next
		If Width < #ParameterList_MinColumn
			Width = #ParameterList_MinColumn
		EndIf
	EndWith
	
	ProcedureReturn Width
EndProcedure

Procedure ParameterList_ColumnX(*GadgetData.ParameterListData, Column)
	Protected X, Loop
	
	With *GadgetData
		X = \Border
		For Loop = 0 To Column - 1
			X + ParameterList_ColumnWidth(*GadgetData, Loop)
		Next
	EndWith
	
	ProcedureReturn X
EndProcedure

Procedure ParameterList_TextX(*GadgetData.ParameterListData, Column, Depth)
	ProcedureReturn ParameterList_ColumnX(*GadgetData, Column) + #ParameterList_Margin + (Depth + 1) * #ParameterList_FoldWidth
EndProcedure

Procedure ParameterList_RowTop(*GadgetData.ParameterListData)
	ProcedureReturn *GadgetData\Border + *GadgetData\HeaderHeight
EndProcedure

Procedure ParameterList_ZoneAt(*GadgetData.ParameterListData, Index, MouseX, MouseY, *Column.Long)
	Protected Loop, TextX, AddX, RemoveX, Tree, *Item.ParameterList_Item
	
	With *GadgetData
		*Column\l = -1
		
		For Loop = 1 To \ColumnCount - 1
			If Abs(MouseX - ParameterList_ColumnX(*GadgetData, Loop)) <= #ParameterList_GripWidth
				*Column\l = Loop
				ProcedureReturn #ParameterList_Zone_Grip
			EndIf
		Next
		
		For Loop = 0 To \ColumnCount - 1
			If MouseX >= ParameterList_ColumnX(*GadgetData, Loop) And MouseX < ParameterList_ColumnX(*GadgetData, Loop + 1)
				*Column\l = Loop
				Break
			EndIf
		Next
		
		If \HeaderHeight And MouseY < ParameterList_RowTop(*GadgetData)
			ProcedureReturn #ParameterList_Zone_Header
		EndIf
		
		If Not ParameterList_Select(*GadgetData, Index)
			ProcedureReturn #ParameterList_Zone_Body	; …including the empty space below the last row
		EndIf
		*Item = @\Items()
		Tree = ParameterList_TreeColumn(*GadgetData)
		
		If Tree > -1 And ParameterList_ChildCount(*GadgetData, Index)
			TextX = ParameterList_TextX(*GadgetData, Tree, *Item\Depth)
			If MouseX >= TextX - #ParameterList_FoldWidth And MouseX < TextX
				ProcedureReturn #ParameterList_Zone_Fold
			EndIf
		EndIf
		
		If *Item\Kind = #ParameterList_Group
			If *Item\Adder And Tree > -1
				AddX = ParameterList_ColumnX(*GadgetData, Tree + 1) - #ParameterList_ButtonWidth
				If MouseX >= AddX And MouseX < AddX + #ParameterList_ButtonWidth
					ProcedureReturn #ParameterList_Zone_Add
				EndIf
			EndIf
			ProcedureReturn #ParameterList_Zone_Body
		EndIf
		
		RemoveX = \Border + ParameterList_ContentWidth(*GadgetData) - #ParameterList_ButtonWidth
		If *Item\Removable And Index = \ItemState And MouseX >= RemoveX
			ProcedureReturn #ParameterList_Zone_Remove
		EndIf
		
		If *Column\l > -1
			ProcedureReturn #ParameterList_Zone_Cell
		EndIf
	EndWith
	
	ProcedureReturn #ParameterList_Zone_Body
EndProcedure

Procedure ParameterList_UpdateScrollBar(*GadgetData.ParameterListData)
	Protected Rows
	
	With *GadgetData
		If \Freeze	; a rebuild clamps the position against a ceiling still climbing, and zeroes it while the rows are too few to scroll
			ProcedureReturn	; ParameterList_Redraw does it once, after the thaw
		EndIf
		
		Rows = ParameterList_RowCount(*GadgetData)
		\VisibleScrollBar = Bool(Rows * \ItemHeight > \Height - ParameterList_RowTop(*GadgetData) - \Border)
		ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, Rows * \ItemHeight)
		If Not \VisibleScrollBar
			ScrollBar_SetState_Meta(\ScrollBar, 0)
		EndIf
	EndWith
EndProcedure

Procedure ParameterList_ScrollOffset(*GadgetData.ParameterListData)
	If *GadgetData\VisibleScrollBar
		ProcedureReturn *GadgetData\ScrollBar\State
	EndIf
	ProcedureReturn 0
EndProcedure

Procedure ParameterList_RowAt(*GadgetData.ParameterListData, MouseY)
	With *GadgetData
		If MouseY < ParameterList_RowTop(*GadgetData)
			ProcedureReturn -1
		EndIf
		ProcedureReturn Floor((MouseY - ParameterList_RowTop(*GadgetData) + ParameterList_ScrollOffset(*GadgetData)) / \ItemHeight)
	EndWith
EndProcedure

Procedure ParameterList_DirtyItem(*GadgetData.ParameterListData, *Item.ParameterList_Item)
	Protected Loop, *Cell.Text
	
	With *GadgetData
		For Loop = 0 To \ColumnCount - 1
			*Cell = ParameterList_Cell(*Item, Loop)
			*Cell\Dirty = #True
		Next
	EndWith
EndProcedure

Procedure ParameterList_PrepareItem(*GadgetData.ParameterListData, *Item.ParameterList_Item)
	Protected Loop, Width, Tree, *Cell.Text
	
	With *GadgetData
		Tree = ParameterList_TreeColumn(*GadgetData)
	
		For Loop = 0 To \ColumnCount - 1
			*Cell = ParameterList_Cell(*Item, Loop)
			If Not *Cell\Dirty
				Continue
			EndIf
			
			If \Columns(Loop)\Role = #ParameterList_Tree
				Width = ParameterList_ColumnX(*GadgetData, Loop + 1) - ParameterList_TextX(*GadgetData, Loop, *Item\Depth) - #ParameterList_Margin
				If *Item\Adder And Loop = Tree
					Width - #ParameterList_ButtonWidth
				EndIf
			Else
				Width = ParameterList_ColumnWidth(*GadgetData, Loop) - #ParameterList_Margin * 2
			EndIf
			If Width < 1
				Width = 1
			EndIf
			
			*Cell\Width = Width
			*Cell\Height = \ItemHeight
			PrepareVectorTextBlock(*Cell)
		Next
	EndWith
EndProcedure

Procedure ParameterList_PrepareColumns(*GadgetData.ParameterListData)
	Protected Loop
	
	With *GadgetData
		If Not \HeaderHeight
			ProcedureReturn
		EndIf
		
		For Loop = 0 To \ColumnCount - 1
			\Columns(Loop)\Text\Width = ParameterList_ColumnWidth(*GadgetData, Loop) - #ParameterList_Margin * 2
			If \Columns(Loop)\Text\Width < 1
				\Columns(Loop)\Text\Width = 1
			EndIf
			\Columns(Loop)\Text\Height = \HeaderHeight
			PrepareVectorTextBlock(@\Columns(Loop)\Text)
		Next
	EndWith
EndProcedure

Procedure ParameterList_PrepareAll(*GadgetData.ParameterListData)
	With *GadgetData
		ParameterList_PrepareColumns(*GadgetData)
		ForEach \Items()
			ParameterList_DirtyItem(*GadgetData, @\Items())
		Next
	EndWith
EndProcedure

;- Drawing
Procedure ParameterList_StripeColor(*ThemeData.Theme)
	; The field three quarters of the way to the WINDOW colour - the side hover and selection do NOT come from, so a stripe never reads as one of them
	Protected Cold = *ThemeData\ShadeColor[#Cold], Back = *ThemeData\WindowColor
	
	ProcedureReturn RGBA((Red(Cold) + Red(Back) * 3) / 4, (Green(Cold) + Green(Back) * 3) / 4, (Blue(Cold) + Blue(Back) * 3) / 4, Alpha(Cold))
EndProcedure

Procedure ParameterList_DrawAdd(X, Y, Width, Height)
	Protected CX.d = X + Width * 0.5, CY.d = Y + Height * 0.5
	
	MovePathCursor(CX - 4.5, CY)
	AddPathLine(CX + 4.5, CY)
	MovePathCursor(CX, CY - 4.5)
	AddPathLine(CX, CY + 4.5)
	StrokePath(1.6)
EndProcedure

Procedure ParameterList_DrawRemove(X, Y, Width, Height)
	Protected CX.d = X + Width * 0.5, CY.d = Y + Height * 0.5
	
	MovePathCursor(CX - 3.5, CY - 3.5)
	AddPathLine(CX + 3.5, CY + 3.5)
	MovePathCursor(CX + 3.5, CY - 3.5)
	AddPathLine(CX - 3.5, CY + 3.5)
	StrokePath(1.6)
EndProcedure

Procedure ParameterList_DrawHeader(*GadgetData.ParameterListData)
	Protected Loop
	
	With *GadgetData
		AddPathBox(\OriginX + \Border, \OriginY + \Border, \Width - \Border * 2, \HeaderHeight)
		VectorSourceColor(\ThemeData\ShadeColor[#Warm])
		FillPath()
		
		VectorSourceColor(\ThemeData\TextColor[#Cold])
		For Loop = 0 To \ColumnCount - 1
			DrawVectorTextBlock(@\Columns(Loop)\Text, \OriginX + ParameterList_ColumnX(*GadgetData, Loop) + #ParameterList_Margin, \OriginY + \Border)
		Next
		
		VectorSourceColor(\ThemeData\LineColor[#Cold])
		AddPathBox(\OriginX + \Border, \OriginY + ParameterList_RowTop(*GadgetData), \Width - \Border * 2, 1)
		FillPath()
	EndWith
EndProcedure

Procedure ParameterList_Redraw(*GadgetData.ParameterListData)
	Protected Y, Row, FirstRow, Index, Column, ShadeState, TextState, X, RuleTop, RuleBottom, Tree
	Protected *Item.ParameterList_Item
	
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
			If \HeaderHeight
				ParameterList_DrawHeader(*GadgetData)
			EndIf
			ProcedureReturn
		EndIf
		
		ParameterList_UpdateScrollBar(*GadgetData)	; …the rows that arrived while frozen
		Tree = ParameterList_TreeColumn(*GadgetData)
		RuleTop = \OriginY + \Border
		RuleBottom = \OriginY + \Height - \Border
		
		Y = \OriginY + ParameterList_RowTop(*GadgetData)
		If \VisibleScrollBar
			FirstRow = Floor(\ScrollBar\State / \ItemHeight)
			Y - (\ScrollBar\State % \ItemHeight)
		EndIf
		Row = FirstRow
		
		While Y < \OriginY + \Height
			Index = ParameterList_RowToIndex(*GadgetData, Row)
			If Index = -1
				Break
			EndIf
			
			SelectElement(\Items(), Index)
			*Item = @\Items()				; by pointer: helpers move the list cursor
			ParameterList_PrepareItem(*GadgetData, *Item)
			
			If Index = \State
				ShadeState = #Hot
			ElseIf Index = \ItemState
				ShadeState = #Warm
			ElseIf *Item\Kind = #ParameterList_Group
				ShadeState = #Warm			; a group band stands off the field even when nothing is on it
			Else
				ShadeState = #Cold
			EndIf
			TextState = ShadeState
			
			; The stripe is the FALLBACK, never a layer under the others, and bands the SCREEN row so folding cannot leave two of a colour side by side
			If ShadeState > #Cold
				AddPathBox(\OriginX + \Border, Y, \Width - \Border * 2, \ItemHeight)
				VectorSourceColor(\ThemeData\ShadeColor[ShadeState])
				FillPath()
			ElseIf Row % 2
				AddPathBox(\OriginX + \Border, Y, \Width - \Border * 2, \ItemHeight)
				VectorSourceColor(ParameterList_StripeColor(\ThemeData))
				FillPath()
			EndIf
			
			For Column = 0 To \ColumnCount - 1
				Select \Columns(Column)\Role
					Case #ParameterList_Tree ;{
						X = \OriginX + ParameterList_TextX(*GadgetData, Column, *Item\Depth)
						VectorSourceColor(\ThemeData\TextColor[TextState])
						
						If Column = Tree And ParameterList_ChildCount(*GadgetData, Index)
							DrawFold(X - #ParameterList_FoldWidth, Y, #ParameterList_FoldWidth, *Item\Folded)
						EndIf
						
						DrawVectorTextBlock(ParameterList_Cell(*Item, Column), X, Y)
						
						If Column = Tree And *Item\Adder
							ParameterList_DrawAdd(\OriginX + ParameterList_ColumnX(*GadgetData, Column + 1) - #ParameterList_ButtonWidth, Y, #ParameterList_ButtonWidth, \ItemHeight)
						EndIf
						;}
					Case #ParameterList_Derived ;{
						If *Item\Kind = #ParameterList_Value
							If *Item\Faulty
								VectorSourceColor(\ThemeData\TextColor[#Hot])
							Else
								VectorSourceColor(\ThemeData\TextColor[#Disabled])
							EndIf
							DrawVectorTextBlock(ParameterList_Cell(*Item, Column), \OriginX + ParameterList_ColumnX(*GadgetData, Column) + #ParameterList_Margin, Y)
						EndIf
						;}
					Default ;{
						If *Item\Kind = #ParameterList_Value
							VectorSourceColor(\ThemeData\TextColor[TextState])
							DrawVectorTextBlock(ParameterList_Cell(*Item, Column), \OriginX + ParameterList_ColumnX(*GadgetData, Column) + #ParameterList_Margin, Y)
						EndIf
						;}
				EndSelect
			Next
			
			If *Item\Kind = #ParameterList_Value And *Item\Removable And Index = \ItemState
				VectorSourceColor(\ThemeData\TextColor[TextState])
				ParameterList_DrawRemove(\OriginX + \Border + ParameterList_ContentWidth(*GadgetData) - #ParameterList_ButtonWidth, Y, #ParameterList_ButtonWidth, \ItemHeight)
			EndIf
			
			Y + \ItemHeight
			Row + 1
		Wend
		
		If \HeaderHeight
			ParameterList_DrawHeader(*GadgetData)
		EndIf
		
		VectorSourceColor(\ThemeData\LineColor[#Cold])
		For Column = 1 To \ColumnCount - 1
			AddPathBox(\OriginX + ParameterList_ColumnX(*GadgetData, Column), RuleTop, 1, RuleBottom - RuleTop)
			FillPath()
		Next
		
		If \VisibleScrollBar
			\ScrollBar\Redraw(\ScrollBar)
		EndIf
		
		If \Editing
			SaveVectorState()
			\String\Redraw(\String)
			RestoreVectorState()
		EndIf
	EndWith
EndProcedure

;- Editing
Procedure ParameterList_CellEditable(*GadgetData.ParameterListData, *Item.ParameterList_Item, Column)
	With *GadgetData
		If Column < 0 Or Column >= \ColumnCount Or \Columns(Column)\Role = #ParameterList_Derived
			ProcedureReturn #False
		EndIf
		ProcedureReturn Bool(*Item\Kind = #ParameterList_Value And *Item\Editable & (1 << Column))
	EndWith
EndProcedure

Procedure ParameterList_StartEdit(*GadgetData.ParameterListData, Index, Column)
	Protected Event.Event, Row, *Item.ParameterList_Item, *Cell.Text
	
	With *GadgetData
		If Not \Editable Or \Editing Or Index < 0
			ProcedureReturn #False
		EndIf
		
		Row = ParameterList_IndexToRow(*GadgetData, Index)
		If Row < 0 Or Not SelectElement(\Items(), Index)
			ProcedureReturn #False
		EndIf
		*Item = @\Items()
		If Not ParameterList_CellEditable(*GadgetData, *Item, Column)
			ProcedureReturn #False
		EndIf
		
		\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
		\EditRow = Index
		\EditColumn = Column
		
		*Cell = ParameterList_Cell(*Item, Column)
		\String\String = *Cell\OriginalText
		
		If \Columns(Column)\Role = #ParameterList_Tree
			\String\OriginX = ParameterList_TextX(*GadgetData, Column, *Item\Depth)
			\String\Width = ParameterList_ColumnX(*GadgetData, Column + 1) - \String\OriginX - #ParameterList_Margin
		Else
			\String\OriginX = ParameterList_ColumnX(*GadgetData, Column) + #ParameterList_Margin
			\String\Width = ParameterList_ColumnWidth(*GadgetData, Column) - #ParameterList_Margin * 2
		EndIf
		
		String_ProcessString(\String)
		\String\OriginY = ParameterList_RowTop(*GadgetData) + Row * \ItemHeight - ParameterList_ScrollOffset(*GadgetData) + 1
		
		Event\EventType = #Focus
		\String\EventHandler(\String, Event)
		StringSetSelection_Meta(\String, 0, Len(\String\String))
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure ParameterList_EndEdit(*GadgetData.ParameterListData, Keep)
	Protected Event.Event, Changed, *Cell.Text
	
	With *GadgetData
		If Not \Editing
			ProcedureReturn #False
		EndIf
		
		\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
		
		If \EditCursor	; …means "the pointer is inside the editor"; left standing it sends the NEXT click into a String that is no longer open
			\EditCursor = #PB_Cursor_Default
			\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_Default)
		EndIf
		
		Event\EventType = #LostFocus
		\String\EventHandler(\String, Event)
		
		\CommitRow = \EditRow		; what the host will read when the posted event reaches it
		\CommitColumn = \EditColumn
		
		If Keep And ParameterList_Select(*GadgetData, \EditRow)
			*Cell = ParameterList_Cell(@\Items(), \EditColumn)
			Changed = Bool(*Cell\OriginalText <> \String\String)
			*Cell\OriginalText = \String\String
			*Cell\Dirty = #True
			
			If Changed
				\State = \EditRow
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
			EndIf
		EndIf
	EndWith
	
	ProcedureReturn #True
EndProcedure

; Events carry the row's item data: committing the open cell may let the host renumber the rows
Procedure.i ParameterList_ItemDataAt(*GadgetData.ParameterListData, Index)
	If ParameterList_Select(*GadgetData, Index)
		ProcedureReturn *GadgetData\Items()\Data
	EndIf
	ProcedureReturn 0
EndProcedure

Procedure ParameterList_ToggleFold(*GadgetData.ParameterListData, Index)
	With *GadgetData
		If Not ParameterList_Select(*GadgetData, Index) Or Not ParameterList_ChildCount(*GadgetData, Index)
			ProcedureReturn #False
		EndIf
		
		\Items()\Folded = 1 - \Items()\Folded
		ParameterList_UpdateScrollBar(*GadgetData)
		\State = Index
		PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterFold, ParameterList_ItemDataAt(*GadgetData, Index))	; by index: the scroll-bar update above moved the list cursor
	EndWith
	
	ProcedureReturn #True
EndProcedure

;- Events
Procedure ParameterList_EventHandler(*GadgetData.ParameterListData, *Event.Event)
	Protected Redraw, Row, Index, Zone, Width, Stretch, Column.l, Cursor = *GadgetData\EditCursor, CursorWas = Cursor
	
	With *GadgetData
		Select *Event\EventType
			Case #MouseMove ;{
				If \String And \String\Selecting
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
				ElseIf \DragGrip
					Width = \DragOriginWidth + (*Event\MouseX - \DragOriginX) * \DragSign
					If Width < #ParameterList_MinColumn
						Width = #ParameterList_MinColumn
					EndIf
					\Columns(\DragColumn)\Width = Width
					ParameterList_PrepareAll(*GadgetData)
					Redraw = #True
				Else
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
						Index = ParameterList_RowToIndex(*GadgetData, ParameterList_RowAt(*GadgetData, *Event\MouseY))
						If Index <> \ItemState
							\ItemState = Index
							Redraw = #True
						EndIf
						
						Zone = ParameterList_ZoneAt(*GadgetData, Index, *Event\MouseX, *Event\MouseY, @Column)
						\HoverZone = Zone
						\HoverColumn = Column
						If Zone = #ParameterList_Zone_Grip
							Cursor = #PB_Cursor_LeftRight
						EndIf
					EndIf
				EndIf
				;}
			Case #MouseLeave ;{
				If \ItemState > -1
					\ItemState = -1
					\HoverZone = #ParameterList_Zone_Body
					\HoverColumn = -1
					Redraw = #True
				EndIf
				Cursor = #PB_Cursor_Default
				;}
			Case #MouseWheel ;{
				Redraw = ParameterList_EndEdit(*GadgetData, #True)
				
				If \VisibleScrollBar
					ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight)
					*Event\EventType = #MouseMove	; the rows moved under the pointer: refresh the hover
					Redraw = Bool(Not ParameterList_EventHandler(*GadgetData, *Event)) | Redraw
				EndIf
				;}
			Case #LeftButtonDown ;{
				If \Editing
					If *Event\MouseX >= \String\OriginX And *Event\MouseX < \String\OriginX + \String\Width And *Event\MouseY >= \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
						If Redraw
							RedrawObject()
						EndIf
						ProcedureReturn Redraw
					EndIf
					Redraw = ParameterList_EndEdit(*GadgetData, #True)
				EndIf
				
				If \VisibleScrollBar And *Event\MouseX >= \ScrollBar\OriginX
					Redraw = ScrollBar_EventHandler(\ScrollBar, *Event) | Redraw
					If Redraw	; a meta bar cannot repaint itself
						RedrawObject()
					EndIf
					ProcedureReturn Redraw
				EndIf
				
				Index = ParameterList_RowToIndex(*GadgetData, ParameterList_RowAt(*GadgetData, *Event\MouseY))
				Zone = ParameterList_ZoneAt(*GadgetData, Index, *Event\MouseX, *Event\MouseY, @Column)
				
				Select Zone
					Case #ParameterList_Zone_Grip ;{
						Stretch = ParameterList_StretchIndex(*GadgetData)
						If Column <= Stretch
							\DragColumn = Column - 1
							\DragSign = 1
						Else
							\DragColumn = Column
							\DragSign = -1
						EndIf
						\DragGrip = #True
						\DragOriginX = *Event\MouseX
						\DragOriginWidth = \Columns(\DragColumn)\Width
						;}
					Case #ParameterList_Zone_Header
						If Column > -1
							\ClickedColumn = Column
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterColumnClick)
						EndIf
					Case #ParameterList_Zone_Fold
						Redraw = ParameterList_ToggleFold(*GadgetData, Index) | Redraw
					Case #ParameterList_Zone_Add
						\State = Index
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterAdd, ParameterList_ItemDataAt(*GadgetData, Index))
						Redraw = #True
					Case #ParameterList_Zone_Remove
						\State = Index
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterRemove, ParameterList_ItemDataAt(*GadgetData, Index))
						Redraw = #True
					Default
						If Index <> \State
							\State = Index
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							Redraw = #True
						EndIf
						If Zone = #ParameterList_Zone_Cell
							Redraw = ParameterList_StartEdit(*GadgetData, Index, Column) | Redraw
						EndIf
				EndSelect
				;}
			Case #LeftButtonUp ;{
				If \DragGrip
					\DragGrip = #False
					ParameterList_UpdateScrollBar(*GadgetData)
					Redraw = #True
				ElseIf \Editing And \String\Selecting
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
				ElseIf \VisibleScrollBar
					Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
				EndIf
				;}
			Case #LeftDoubleClick ;{
				If \Editing
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
				Else
					Index = ParameterList_RowToIndex(*GadgetData, ParameterList_RowAt(*GadgetData, *Event\MouseY))
					If ParameterList_ChildCount(*GadgetData, Index)
						Redraw = ParameterList_ToggleFold(*GadgetData, Index)
					EndIf
				EndIf
				;}
			Case #KeyDown ;{
				If \Editing
					Select *Event\Param
						Case #PB_Shortcut_Return
							Redraw = ParameterList_EndEdit(*GadgetData, #True)
						Case #PB_Shortcut_Escape
							Redraw = ParameterList_EndEdit(*GadgetData, #False)
						Case #PB_Shortcut_Tab ;{ straight on to the next cell, which is how a table is filled in
							Index = \EditRow
							Zone = \EditColumn
							Row = ParameterList_IndexToRow(*GadgetData, Index)
							Redraw = ParameterList_EndEdit(*GadgetData, #True)
							
							For Column = Zone + 1 To \ColumnCount - 1
								If ParameterList_StartEdit(*GadgetData, Index, Column)
									Break
								EndIf
							Next
							If Not \Editing
								Index = ParameterList_RowToIndex(*GadgetData, Row + 1)
								For Column = 0 To \ColumnCount - 1
									If ParameterList_StartEdit(*GadgetData, Index, Column)
										Break
									EndIf
								Next
							EndIf
							;}
						Default
							Redraw = \String\EventHandler(\String, *Event)
					EndSelect
				Else
					Row = ParameterList_IndexToRow(*GadgetData, \State)
					
					Select *Event\Param
						Case #PB_Shortcut_Down
							Index = ParameterList_RowToIndex(*GadgetData, Row + 1)
							If Row > -1 And Index > -1
								\State = Index
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
								Redraw = #True
							EndIf
						Case #PB_Shortcut_Up
							If Row > 0
								\State = ParameterList_RowToIndex(*GadgetData, Row - 1)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
								Redraw = #True
							EndIf
						Case #PB_Shortcut_Left
							If ParameterList_Select(*GadgetData, \State) And ParameterList_ChildCount(*GadgetData, \State) And Not \Items()\Folded
								Redraw = ParameterList_ToggleFold(*GadgetData, \State)
							EndIf
						Case #PB_Shortcut_Right
							If ParameterList_Select(*GadgetData, \State) And ParameterList_ChildCount(*GadgetData, \State) And \Items()\Folded
								Redraw = ParameterList_ToggleFold(*GadgetData, \State)
							EndIf
						Case #PB_Shortcut_F2
							Redraw = ParameterList_StartEdit(*GadgetData, \State, ParameterList_TreeColumn(*GadgetData))
						Case #PB_Shortcut_Return ;{
							For Column = 0 To \ColumnCount - 1
								If \Columns(Column)\Role <> #ParameterList_Tree And ParameterList_StartEdit(*GadgetData, \State, Column)
									Redraw = #True
									Break
								EndIf
							Next
							;}
					EndSelect
				EndIf
				;}
			Case #Input ;{
				If \Editing
					Redraw = \String\EventHandler(\String, *Event)
				EndIf
				;}
			Case #LostFocus ;{ clicking away from the gadget commits what is in the editor
				If \Editing
					Redraw = ParameterList_EndEdit(*GadgetData, #True)
				EndIf
				;}
		EndSelect
		
		If Cursor <> \EditCursor And Cursor <> CursorWas	; only a hover decided here wins; never undo EndEdit's clear
			\EditCursor = Cursor
			\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
		EndIf
		
		If Redraw	; THE HANDLER REPAINTS ITSELF: Default_EventHandle throws the result away, so a gadget that only returns #True never redraws
			RedrawObject()
		EndIf
	EndWith
	
	ProcedureReturn Redraw
EndProcedure

;- Gadget interface
Procedure ParameterList_AddItem(*this.PB_Gadget, Position.l, *Text, ImageID, Level.l)
	Protected *GadgetData.ParameterListData = *this\vt, *NewItem.ParameterList_Item, *Cell.Text, Loop, Depth, Ceiling, Line.s
	
	ParameterList_EndEdit(*GadgetData, #True)
	
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
		Else
			Ceiling = 0			; first in the list: nothing above it to belong to
		EndIf
		ChangeCurrentElement(\Items(), *NewItem)
		If Depth > Ceiling
			Depth = Ceiling
		EndIf
		
		Line = PeekGadgetText(*Text)
		*NewItem\Depth = Depth
		*NewItem\Kind = #ParameterList_Value
		ParameterList_SizeCells(*GadgetData, *NewItem)
		
		For Loop = 0 To \ColumnCount - 1
			*Cell = ParameterList_Cell(*NewItem, Loop)
			*Cell\OriginalText = StringField(Line, Loop + 1, #LF$)
			*Cell\LineLimit = 1
			*Cell\FontID = \TextBlock\FontID
			*Cell\FontScale = \TextBlock\FontScale
			*Cell\VAlign = \TextBlock\VAlign
			*Cell\HAlign = \TextBlock\HAlign
		Next
		
		ParameterList_DirtyItem(*GadgetData, *NewItem)
		
		ChangeCurrentElement(\Items(), *NewItem)
		Position = ListIndex(\Items())
		
		\State = IndexAfterInsert(\State, Position)
		\ItemState = -1
		
		ParameterList_UpdateScrollBar(*GadgetData)
		RedrawObject()
	EndWith
	
	ProcedureReturn Position
EndProcedure

Procedure ParameterList_RemoveItem(*this.PB_Gadget, Position.l)
	; Removing a row takes its whole subtree with it
	Protected *GadgetData.ParameterListData = *this\vt, Count, Loop
	
	With *GadgetData
		If Position < 0 Or Position >= ListSize(\Items())
			ProcedureReturn
		EndIf
		
		Count = ParameterList_ChildCount(*GadgetData, Position) + 1
		ParameterList_EndEdit(*GadgetData, Bool(\EditRow < Position Or \EditRow >= Position + Count))
		
		For Loop = 1 To Count
			If SelectElement(\Items(), Position)
				DeleteElement(\Items())
			EndIf
		Next
		
		\State = IndexAfterRemove(\State, Position, Count)
		\ItemState = -1
		
		ParameterList_UpdateScrollBar(*GadgetData)
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_ClearItems(*this.PB_Gadget)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		If \Editing
			ParameterList_EndEdit(*GadgetData, #False)
		EndIf
		ClearList(\Items())
		\State = -1
		\ItemState = -1
		ParameterList_UpdateScrollBar(*GadgetData)
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_CountItem(*this.PB_Gadget)
	Protected *GadgetData.ParameterListData = *this\vt
	ProcedureReturn ListSize(*GadgetData\Items())
EndProcedure

Procedure ParameterList_AddColumn(*this.PB_Gadget, Position.l, *Text, Width.l)
	Protected *GadgetData.ParameterListData = *this\vt, *Item.ParameterList_Item, *From.Text, *To.Text, Loop, Mask
	
	With *GadgetData
		If \ColumnCount >= #ParameterList_MaxColumn
			ProcedureReturn -1
		EndIf
		If Position < 0 Or Position > \ColumnCount
			Position = \ColumnCount
		EndIf
		If \Editing
			ParameterList_EndEdit(*GadgetData, #True)
		EndIf
		Mask = (1 << Position) - 1
		
		ReDim \Columns(\ColumnCount)
		For Loop = \ColumnCount - 1 To Position Step -1
			ClearStructure(@\Columns(Loop + 1), ParameterList_Column)
			CopyStructure(@\Columns(Loop), @\Columns(Loop + 1), ParameterList_Column)
		Next
		ClearStructure(@\Columns(Position), ParameterList_Column)
		
		\Columns(Position)\Role = #ParameterList_Cell
		\Columns(Position)\Width = Width
		\Columns(Position)\Text\OriginalText = PeekGadgetText(*Text)
		\Columns(Position)\Text\LineLimit = 1
		\Columns(Position)\Text\FontID = \TextBlock\FontID
		\Columns(Position)\Text\FontScale = \TextBlock\FontScale
		\Columns(Position)\Text\VAlign = \TextBlock\VAlign
		\Columns(Position)\Text\HAlign = \TextBlock\HAlign
		
		ForEach \Items()
			*Item = @\Items()
			ReDim *Item\Cells(\ColumnCount + 1)
			
			For Loop = \ColumnCount - 1 To Position Step -1
				*To = ParameterList_Cell(*Item, Loop + 1)
				*From = ParameterList_Cell(*Item, Loop)
				ClearStructure(*To, Text)
				CopyStructure(*From, *To, Text)
			Next
			
			*From = ParameterList_Cell(*Item, Position)
			ClearStructure(*From, Text)
			*From\LineLimit = 1
			*From\FontID = \TextBlock\FontID
			*From\FontScale = \TextBlock\FontScale
			*From\VAlign = \TextBlock\VAlign
			*From\HAlign = \TextBlock\HAlign
			
			*Item\Editable = (*Item\Editable & Mask) | ((*Item\Editable & ~Mask) << 1)
		Next
		
		\ColumnCount + 1
		If \CommitColumn >= Position	; the host reads it after the posted commit
			\CommitColumn + 1
		EndIf
		If \StretchColumn >= Position
			\StretchColumn + 1
		EndIf
		
		ParameterList_PrepareAll(*GadgetData)
		RedrawObject()
	EndWith
	
	ProcedureReturn Position
EndProcedure

Procedure ParameterList_RemoveColumn(*this.PB_Gadget, Position.l)
	Protected *GadgetData.ParameterListData = *this\vt, *Item.ParameterList_Item, *From.Text, *To.Text, Loop, Mask
	
	With *GadgetData
		If \ColumnCount <= 1 Or Position < 0 Or Position >= \ColumnCount
			ProcedureReturn
		EndIf
		ParameterList_EndEdit(*GadgetData, Bool(\EditColumn <> Position))
		Mask = (1 << Position) - 1
		
		For Loop = Position To \ColumnCount - 2
			ClearStructure(@\Columns(Loop), ParameterList_Column)
			CopyStructure(@\Columns(Loop + 1), @\Columns(Loop), ParameterList_Column)
		Next
		ClearStructure(@\Columns(\ColumnCount - 1), ParameterList_Column)
		
		ForEach \Items()
			*Item = @\Items()
			
			For Loop = Position To \ColumnCount - 2
				*To = ParameterList_Cell(*Item, Loop)
				*From = ParameterList_Cell(*Item, Loop + 1)
				ClearStructure(*To, Text)
				CopyStructure(*From, *To, Text)
			Next
			ClearStructure(ParameterList_Cell(*Item, \ColumnCount - 1), Text)
			
			*Item\Editable = (*Item\Editable & Mask) | ((*Item\Editable >> 1) & ~Mask)
		Next
		
		\ColumnCount - 1
		If \CommitColumn > Position
			\CommitColumn - 1
		EndIf
		If \StretchColumn > Position
			\StretchColumn - 1
		ElseIf \StretchColumn = Position
			\StretchColumn = -1
		EndIf
		ReDim \Columns(\ColumnCount)
		
		ParameterList_PrepareAll(*GadgetData)
		ParameterList_UpdateScrollBar(*GadgetData)
		RedrawObject()
	EndWith
EndProcedure

Procedure.s ParameterList_GetItemText(*this.PB_Gadget, Position.l, Column.l)
	Protected *GadgetData.ParameterListData = *this\vt, *Cell.Text, Result.s
	
	With *GadgetData
		If Column < 0
			Column = 0
		EndIf
		If Position > -1 And Position < ListSize(\Items()) And Column < \ColumnCount
			SelectElement(\Items(), Position)
			*Cell = ParameterList_Cell(@\Items(), Column)
			Result = *Cell\OriginalText
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure ParameterList_SetItemText(*this.PB_Gadget, Position.l, *Text, Column.l)
	Protected *GadgetData.ParameterListData = *this\vt, *Cell.Text
	
	ParameterList_EndEdit(*GadgetData, #True)
	
	With *GadgetData
		If Column < 0
			Column = 0
		EndIf
		If Position > -1 And Position < ListSize(\Items()) And Column < \ColumnCount
			SelectElement(\Items(), Position)
			*Cell = ParameterList_Cell(@\Items(), Column)
			*Cell\OriginalText = PeekGadgetText(*Text)
			*Cell\Dirty = #True
			RedrawObject()
		EndIf
	EndWith
EndProcedure

Procedure ParameterList_GetItemData(*this.PB_Gadget, Position.l)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		If Position > -1 And Position < ListSize(\Items())
			SelectElement(\Items(), Position)
			ProcedureReturn \Items()\Data
		EndIf
	EndWith
	
	ProcedureReturn 0
EndProcedure

Procedure ParameterList_SetItemData(*this.PB_Gadget, Position.l, *Value)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		If Position > -1 And Position < ListSize(\Items())
			SelectElement(\Items(), Position)
			\Items()\Data = *Value
		EndIf
	EndWith
EndProcedure

Procedure ParameterList_GetItemAttribute(*this.PB_Gadget, Position.l, Attribute.l)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		Select Attribute ;{
			Case #Attribute_ParameterList_ColumnWidth
				ProcedureReturn ParameterList_ColumnWidth(*GadgetData, Position)
			Case #Attribute_ParameterList_ColumnRole
				If Position > -1 And Position < \ColumnCount
					ProcedureReturn \Columns(Position)\Role
				EndIf
				ProcedureReturn 0
		EndSelect ;}
		
		If Position < 0 Or Position >= ListSize(\Items())
			ProcedureReturn 0
		EndIf
		
		Select Attribute
			Case #Attribute_ParameterList_ChildCount
				ProcedureReturn ParameterList_ChildCount(*GadgetData, Position)
			Case #Attribute_ParameterList_ScreenRow
				ProcedureReturn ParameterList_IndexToRow(*GadgetData, Position)
		EndSelect
		
		SelectElement(\Items(), Position)
		Select Attribute
			Case #Attribute_ParameterList_Kind
				ProcedureReturn \Items()\Kind
			Case #Attribute_ParameterList_Depth
				ProcedureReturn \Items()\Depth
			Case #Attribute_ParameterList_Folded
				ProcedureReturn \Items()\Folded
			Case #Attribute_ParameterList_Editable
				ProcedureReturn \Items()\Editable
			Case #Attribute_ParameterList_Removable
				ProcedureReturn \Items()\Removable
			Case #Attribute_ParameterList_Faulty
				ProcedureReturn \Items()\Faulty
			Case #Attribute_ParameterList_Adder
				ProcedureReturn \Items()\Adder
		EndSelect
	EndWith
	
	ProcedureReturn 0
EndProcedure

Procedure ParameterList_SetItemAttribute(*this.PB_Gadget, Position.l, Attribute.l, Value.l)
	Protected *GadgetData.ParameterListData = *this\vt
	
	ParameterList_EndEdit(*GadgetData, #True)
	
	With *GadgetData
		Select Attribute ;{
			Case #Attribute_ParameterList_ColumnWidth, #Attribute_ParameterList_ColumnRole
				If Position < 0 Or Position >= \ColumnCount
					ProcedureReturn
				EndIf
				If Attribute = #Attribute_ParameterList_ColumnWidth
					\Columns(Position)\Width = Value
				Else
					\Columns(Position)\Role = Value
				EndIf
				ParameterList_PrepareAll(*GadgetData)
				RedrawObject()
				ProcedureReturn
		EndSelect ;}
		
		If Position < 0 Or Position >= ListSize(\Items()) Or Not SelectElement(\Items(), Position)
			ProcedureReturn
		EndIf
		
		Select Attribute
			Case #Attribute_ParameterList_Kind
				\Items()\Kind = Value
			Case #Attribute_ParameterList_Folded
				\Items()\Folded = Bool(Value)
				ParameterList_UpdateScrollBar(*GadgetData)
			Case #Attribute_ParameterList_Editable
				\Items()\Editable = Value
			Case #Attribute_ParameterList_Removable
				\Items()\Removable = Bool(Value)
			Case #Attribute_ParameterList_Faulty
				\Items()\Faulty = Bool(Value)
			Case #Attribute_ParameterList_Adder
				\Items()\Adder = Bool(Value)
			Default
				ProcedureReturn
		EndSelect
		
		ParameterList_DirtyItem(*GadgetData, @\Items())
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_SetState(*this.PB_Gadget, State)
	Protected *GadgetData.ParameterListData = *this\vt
	
	ParameterList_EndEdit(*GadgetData, #True)
	
	With *GadgetData
		If State < -1 Or State >= ListSize(\Items())
			State = -1
		EndIf
		\State = State
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_GetAttribute(*this.PB_Gadget, Attribute.l)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		Select Attribute
			Case #Attribute_ParameterList_NameWidth
				ProcedureReturn ParameterList_ColumnWidth(*GadgetData, 0)
			Case #Attribute_ParameterList_ValueWidth
				ProcedureReturn ParameterList_ColumnWidth(*GadgetData, \ColumnCount - 1)
			Case #Attribute_ParameterList_ColumnCount
				ProcedureReturn \ColumnCount
			Case #Attribute_ParameterList_StretchColumn
				ProcedureReturn ParameterList_StretchIndex(*GadgetData)
			Case #Attribute_ParameterList_ClickedColumn
				ProcedureReturn \ClickedColumn
			Case #Attribute_ParameterList_EditedRow
				ProcedureReturn \CommitRow
			Case #Attribute_ParameterList_EditedColumn
				ProcedureReturn \CommitColumn
			Case #Attribute_ParameterList_EditingRow
				If \Editing
					ProcedureReturn \EditRow
				EndIf
				ProcedureReturn -1
			Case #Attribute_ParameterList_EditingColumn
				If \Editing
					ProcedureReturn \EditColumn
				EndIf
				ProcedureReturn -1
			Case #Attribute_ParameterList_HoverRow
				ProcedureReturn \ItemState
			Case #Attribute_ParameterList_HoverColumn
				ProcedureReturn \HoverColumn
		EndSelect
	EndWith
	
	ProcedureReturn Default_GetAttribute(*this, Attribute)
EndProcedure

Procedure ParameterList_SetAttribute(*this.PB_Gadget, Attribute.l, Value)
	Protected *GadgetData.ParameterListData = *this\vt
	
	ParameterList_EndEdit(*GadgetData, #True)
	
	With *GadgetData
		Select Attribute
			Case #Attribute_ParameterList_NameWidth
				\Columns(0)\Width = Value
			Case #Attribute_ParameterList_ValueWidth
				\Columns(\ColumnCount - 1)\Width = Value
			Case #Attribute_ParameterList_StretchColumn
				If Value < 0 Or Value >= \ColumnCount
					Value = -1
				EndIf
				\StretchColumn = Value
			Case #Attribute_ParameterList_EditedRow
				\CommitRow = Value
				ProcedureReturn
			Case #Attribute_ParameterList_EditedColumn
				\CommitColumn = Value
				ProcedureReturn
			Default
				ProcedureReturn
		EndSelect
		
		ParameterList_PrepareAll(*GadgetData)
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_SetFont(*this.PB_Gadget, FontID)
	Protected *GadgetData.ParameterListData = *this\vt, *Cell.Text, Loop
	
	ParameterList_EndEdit(*GadgetData, #True)
	
	With *GadgetData
		\TextBlock\FontID = FontID
		
		For Loop = 0 To \ColumnCount - 1
			\Columns(Loop)\Text\FontID = FontID
		Next
		
		ForEach \Items()
			For Loop = 0 To \ColumnCount - 1
				*Cell = ParameterList_Cell(@\Items(), Loop)
				*Cell\FontID = FontID
			Next
			ParameterList_DirtyItem(*GadgetData, @\Items())
		Next
		
		ParameterList_PrepareColumns(*GadgetData)
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_Resize(*this.PB_Gadget, x.l, y.l, Width.l, Height.l)
	Protected *GadgetData.ParameterListData = *this\vt
	
	; The editor is placed against the current geometry, so settle it before moving things.
	ParameterList_EndEdit(*GadgetData, #True)
	
	*this\VT = *GadgetData\OriginalVT
	ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
	*this\VT = *GadgetData
	
	With *GadgetData
		\Width = GadgetWidth(\Gadget)
		\Height = GadgetHeight(\Gadget)
		
		ScrollBar_ResizeMeta(\ScrollBar, \Width - #ParameterList_ToolbarThickness - \Border - 1, ParameterList_RowTop(*GadgetData) + 1, #ParameterList_ToolbarThickness, \Height - ParameterList_RowTop(*GadgetData) - \Border - 2)
		ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height - ParameterList_RowTop(*GadgetData) - \Border)
		
		ParameterList_PrepareAll(*GadgetData)
		ParameterList_UpdateScrollBar(*GadgetData)
	EndWith
	
	RedrawObject()
EndProcedure

Procedure ParameterList_FreeGadget(*this.PB_Gadget)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		FreeStructureX(\ScrollBar)
		InlineEditor_Free(\String)
	EndWith
	
	ProcedureReturn Default_FreeGadget(*this)
EndProcedure

Procedure ParameterList_DefaultColumns(*GadgetData.ParameterListData, Width)
	Protected Loop
	
	With *GadgetData
		\ColumnCount = 3
		Dim \Columns(\ColumnCount)
		
		\Columns(0)\Role = #ParameterList_Tree
		\Columns(1)\Role = #ParameterList_Cell
		\Columns(2)\Role = #ParameterList_Derived
		\Columns(0)\Width = Width * 0.4
		\Columns(2)\Width = Width * 0.22
		\Columns(0)\Text\OriginalText = "Name"
		\Columns(1)\Text\OriginalText = "Expression"
		\Columns(2)\Text\OriginalText = "Value"
		
		For Loop = 0 To \ColumnCount - 1
			\Columns(Loop)\Text\LineLimit = 1
			\Columns(Loop)\Text\FontID = \TextBlock\FontID
			\Columns(Loop)\Text\FontScale = \TextBlock\FontScale
			\Columns(Loop)\Text\VAlign = \TextBlock\VAlign
			\Columns(Loop)\Text\HAlign = \TextBlock\HAlign
		Next
	EndWith
EndProcedure

Procedure ParameterList_Meta(*GadgetData.ParameterListData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags)
	*GadgetData\ThemeData = *ThemeData
	InitializeObject(ParameterList)
	
	With *GadgetData
		If Not (Flags & (#VAlignTop | #VAlignBottom))
			\TextBlock\VAlign = #VAlignCenter
		EndIf
		
		\ItemHeight = #ParameterList_ItemHeight
		\HeaderHeight = Bool(Flags & #ParameterList_Header) * #ParameterList_HeaderHeight
		\State = -1
		\ItemState = -1
		\HoverColumn = -1
		\StretchColumn = 1
		ParameterList_DefaultColumns(*GadgetData, Width)
		ParameterList_PrepareColumns(*GadgetData)
		
		AllocateStructureX(\ScrollBar, ScrollBarData)
		ScrollBar_Meta(\ScrollBar, *ThemeData, -1, Width - #ParameterList_ToolbarThickness - \Border - 1, ParameterList_RowTop(*GadgetData) + 1, #ParameterList_ToolbarThickness, Height - ParameterList_RowTop(*GadgetData) - \Border - 2, 0, \ItemHeight, Height - ParameterList_RowTop(*GadgetData) - \Border, #Gadget_Vertical)
		
		\VT\AddGadgetItem3 = @ParameterList_AddItem()
		\VT\AddGadgetColumn = @ParameterList_AddColumn()
		\VT\RemoveGadgetColumn = @ParameterList_RemoveColumn()
		\VT\RemoveGadgetItem = @ParameterList_RemoveItem()
		\VT\ClearGadgetItemList = @ParameterList_ClearItems()
		\VT\CountGadgetItems = @ParameterList_CountItem()
		\VT\GetGadgetItemText = @ParameterList_GetItemText()
		\VT\SetGadgetItemText = @ParameterList_SetItemText()
		\VT\GetGadgetItemData = @ParameterList_GetItemData()
		\VT\SetGadgetItemData = @ParameterList_SetItemData()
		\VT\GetGadgetItemAttribute2 = @ParameterList_GetItemAttribute()
		\VT\SetGadgetItemAttribute2 = @ParameterList_SetItemAttribute()
		\VT\SetGadgetState = @ParameterList_SetState()
		\VT\GetGadgetAttribute = @ParameterList_GetAttribute()
		\VT\SetGadgetAttribute = @ParameterList_SetAttribute()
		\VT\SetGadgetFont = @ParameterList_SetFont()
		\VT\ResizeGadget = @ParameterList_Resize()
		\VT\FreeGadget = @ParameterList_FreeGadget()
		
		; Enable only the needed events
		\SupportedEvent[#MouseMove] = #True
		\SupportedEvent[#MouseLeave] = #True
		\SupportedEvent[#MouseWheel] = #True
		\SupportedEvent[#LeftButtonDown] = #True
		\SupportedEvent[#LeftButtonUp] = #True
		\SupportedEvent[#LeftDoubleClick] = #True
		\SupportedEvent[#KeyDown] = #True
		
		\Editable = Bool(Flags & #Editable)	; the inline editor: a String meta gadget parked over the cell, hence String_SupportedEvents above
		\EditCursor = #PB_Cursor_Default
		\EditRow = -1
		\CommitRow = -1
		
		If \Editable
			\String = InlineEditor_Create(*GadgetData, *ThemeData, \Width, \ItemHeight - 2, #HAlignLeft)
			String_SupportedEvents()
			CloseGadgetList()
		EndIf
	EndWith
EndProcedure

Procedure ParameterList(Gadget, x, y, Width, Height, Flags = #Default)
	Protected Result, *this.PB_Gadget, *GadgetData.ParameterListData, *ThemeData
	
	; #PB_Canvas_Container is what lets the inline editor live inside the canvas.
	Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Editable) * #PB_Canvas_Container))
	
	If Result
		CreateGadgetObject(ParameterListData)
		ParameterList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		
		RedrawObject()
	EndIf
	
	ProcedureReturn Result
EndProcedure

; A row added under the plus is typed into straight away rather than hunted for - the one reason a host reaches the editor itself
Procedure.i ParameterListEdit(Gadget, Row, Column)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.ParameterListData
	
	If Not *this
		ProcedureReturn #False
	EndIf
	*GadgetData = *this\vt
	
	If ParameterList_StartEdit(*GadgetData, Row, Column)
		RedrawObject()
		ProcedureReturn #True
	EndIf

	ProcedureReturn #False
EndProcedure

Procedure.i ParameterListPoint(Gadget, Row, What, Column, *X.Integer, *Y.Integer)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.ParameterListData
	Protected Screen, Tree, Top

	If Not *this
		ProcedureReturn #False
	EndIf
	*GadgetData = *this\vt

	With *GadgetData
		Screen = ParameterList_IndexToRow(*GadgetData, Row)
		If Screen < 0 Or Not ParameterList_Select(*GadgetData, Row)
			ProcedureReturn #False
		EndIf
		Top = ParameterList_RowTop(*GadgetData) + Screen * \ItemHeight - ParameterList_ScrollOffset(*GadgetData)
		If Top < ParameterList_RowTop(*GadgetData) Or Top + \ItemHeight > \Height
			ProcedureReturn #False
		EndIf
		*Y\i = Top + \ItemHeight / 2
		Tree = ParameterList_TreeColumn(*GadgetData)
		Select What
			Case #ParameterList_PointCell
				If Column < 0 Or Column >= \ColumnCount
					ProcedureReturn #False
				EndIf
				*X\i = (ParameterList_ColumnX(*GadgetData, Column) + ParameterList_ColumnX(*GadgetData, Column + 1)) / 2
			Case #ParameterList_PointButton
				If \Items()\Kind = #ParameterList_Group
					If Tree < 0
						ProcedureReturn #False
					EndIf
					*X\i = ParameterList_ColumnX(*GadgetData, Tree + 1) - #ParameterList_ButtonWidth / 2
				Else
					*X\i = \Border + ParameterList_ContentWidth(*GadgetData) - #ParameterList_ButtonWidth / 2
				EndIf
			Case #ParameterList_PointFold
				If Tree < 0
					ProcedureReturn #False
				EndIf
				*X\i = ParameterList_TextX(*GadgetData, Tree, \Items()\Depth) - #ParameterList_FoldWidth / 2
			Default
				ProcedureReturn #False
		EndSelect
	EndWith

	ProcedureReturn #True
EndProcedure
; IDE Options = PureBasic 6.41 (Windows - x64)
; CursorPosition = 1049
; FirstLine = 80
; Folding = AAAAAAAAA-
; EnableXP
; DPIAware