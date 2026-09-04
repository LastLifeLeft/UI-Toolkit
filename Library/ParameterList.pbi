#ParameterList_ItemHeight = 24
#ParameterList_Margin = 6
#ParameterList_FoldWidth = 14			; the chevron column, and the indent one child step costs
#ParameterList_ButtonWidth = 20			; the plus on a group row and the cross on a removable one
#ParameterList_ToolbarThickness = 7		; scrollbar - always reserved, so no column moves when it appears
#ParameterList_MinColumn = 48			; narrowest a column may be dragged
#ParameterList_GripWidth = 4			; grab zone either side of a column rule

Enumeration ; Which part of a row the pointer is over
	#ParameterList_Zone_Body
	#ParameterList_Zone_Fold
	#ParameterList_Zone_Add
	#ParameterList_Zone_Remove
	#ParameterList_Zone_Name
	#ParameterList_Zone_Expression
	#ParameterList_Zone_GripName		; the rule between the name and the expression
	#ParameterList_Zone_GripValue		; and the one between the expression and the reading
EndEnumeration

Structure ParameterList_Item
	Text.Text							; the NAME cell - stays first, where a VerticalList-style callback expects it
	Expression.Text
	Value.Text
	Kind.b
	Depth.b								; 0 = top level, 1 = inside the nearest shallower row above, and so on
	Folded.b
	Editable.b							; bit 0 the name cell, bit 1 the expression cell
	Removable.b
	Faulty.b
	Adder.b								; a group row that offers a plus
	*Data
EndStructure

Structure ParameterListData Extends GadgetData
	ItemHeight.l
	VisibleScrollBar.b
	ItemState.i							; hovered row as a list index, or -1
	HoverZone.b
	NameWidth.l
	ValueWidth.l						; the expression column is whatever is left between the two
	DragGrip.b							; the rule being dragged, #ParameterList_Zone_Body for none
	DragOriginX.i
	DragOriginWidth.l
	
	Editable.l
	Editing.b
	EditRow.i							; list index under the LIVE editor
	EditColumn.b						; …and which of its cells, 0 the name and 1 the expression
	CommitRow.i							; …and the LAST COMMIT: read after the posted event, by when the editor may have moved on
	CommitColumn.b
	EditCursor.b						; the cursor in force, and so also "the pointer is inside the editor"
	
	*String.StringData					; the inline editor, only allocated with #Editable
	*ScrollBar.ScrollBarData
	
	List Items.ParameterList_Item()
EndStructure

Declare ParameterList_EventHandler(*GadgetData.ParameterListData, *Event.Event)
Declare ParameterList_EndEdit(*GadgetData.ParameterListData, Keep)
Declare ParameterList_PrepareItem(*GadgetData.ParameterListData, *Item.ParameterList_Item)

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

;- Geometry
Procedure ParameterList_ContentWidth(*GadgetData.ParameterListData)
	ProcedureReturn *GadgetData\Width - *GadgetData\Border * 2 - #ParameterList_ToolbarThickness - 2
EndProcedure

Procedure ParameterList_ExprWidth(*GadgetData.ParameterListData)
	Protected Width = ParameterList_ContentWidth(*GadgetData) - *GadgetData\NameWidth - *GadgetData\ValueWidth
	
	If Width < #ParameterList_MinColumn
		Width = #ParameterList_MinColumn
	EndIf
	ProcedureReturn Width
EndProcedure

Procedure ParameterList_ExprX(*GadgetData.ParameterListData)
	ProcedureReturn *GadgetData\Border + *GadgetData\NameWidth
EndProcedure

Procedure ParameterList_ValueX(*GadgetData.ParameterListData)
	ProcedureReturn ParameterList_ExprX(*GadgetData) + ParameterList_ExprWidth(*GadgetData)
EndProcedure

Procedure ParameterList_TextX(*GadgetData.ParameterListData, Depth)
	; The name cell's own text, indented by depth with the chevron in the step left of it
	ProcedureReturn *GadgetData\Border + #ParameterList_Margin + (Depth + 1) * #ParameterList_FoldWidth
EndProcedure

Procedure ParameterList_ZoneAt(*GadgetData.ParameterListData, Index, MouseX)
	Protected TextX, AddX, RemoveX
	
	With *GadgetData
		If Abs(MouseX - ParameterList_ExprX(*GadgetData)) <= #ParameterList_GripWidth
			ProcedureReturn #ParameterList_Zone_GripName
		EndIf
		If Abs(MouseX - ParameterList_ValueX(*GadgetData)) <= #ParameterList_GripWidth
			ProcedureReturn #ParameterList_Zone_GripValue
		EndIf
		If Not ParameterList_Select(*GadgetData, Index)
			ProcedureReturn #ParameterList_Zone_Body	; …including the empty space below the last row
		EndIf
		
		TextX = ParameterList_TextX(*GadgetData, \Items()\Depth)
		If ParameterList_ChildCount(*GadgetData, Index) And MouseX >= TextX - #ParameterList_FoldWidth And MouseX < TextX
			ProcedureReturn #ParameterList_Zone_Fold
		EndIf
		
		If \Items()\Kind = #ParameterList_Group
			AddX = ParameterList_ExprX(*GadgetData) - #ParameterList_ButtonWidth
			If \Items()\Adder And MouseX >= AddX And MouseX < AddX + #ParameterList_ButtonWidth
				ProcedureReturn #ParameterList_Zone_Add
			EndIf
			ProcedureReturn #ParameterList_Zone_Body
		EndIf
		
		RemoveX = \Border + ParameterList_ContentWidth(*GadgetData) - #ParameterList_ButtonWidth
		If \Items()\Removable And Index = \ItemState And MouseX >= RemoveX
			ProcedureReturn #ParameterList_Zone_Remove
		EndIf
		
		If MouseX < ParameterList_ExprX(*GadgetData)
			ProcedureReturn #ParameterList_Zone_Name
		ElseIf MouseX < ParameterList_ValueX(*GadgetData)
			ProcedureReturn #ParameterList_Zone_Expression
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
		\VisibleScrollBar = Bool(Rows * \ItemHeight > \Height - \Border * 2)
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

Procedure ParameterList_PrepareItem(*GadgetData.ParameterListData, *Item.ParameterList_Item)
	; (Re)lay out one row's three cells for the current column widths and its own indent
	Protected NameWidth
	
	With *GadgetData
		NameWidth = ParameterList_ExprX(*GadgetData) - ParameterList_TextX(*GadgetData, *Item\Depth) - #ParameterList_Margin
		If *Item\Adder
			NameWidth - #ParameterList_ButtonWidth
		EndIf
		If NameWidth < 1
			NameWidth = 1
		EndIf
		
		*Item\Text\Width = NameWidth
		*Item\Text\Height = \ItemHeight
		PrepareVectorTextBlock(@*Item\Text)
		
		*Item\Expression\Width = ParameterList_ExprWidth(*GadgetData) - #ParameterList_Margin * 2
		*Item\Expression\Height = \ItemHeight
		PrepareVectorTextBlock(@*Item\Expression)
		
		*Item\Value\Width = \ValueWidth - #ParameterList_Margin * 2
		*Item\Value\Height = \ItemHeight
		PrepareVectorTextBlock(@*Item\Value)
	EndWith
EndProcedure

Procedure ParameterList_PrepareAll(*GadgetData.ParameterListData)
	; Every row, after anything that moved a column rule
	With *GadgetData
		ForEach \Items()
			ParameterList_PrepareItem(*GadgetData, @\Items())
		Next
	EndWith
EndProcedure

;- Drawing
Procedure ParameterList_StripeColor(*ThemeData.Theme)
	; The field three quarters of the way to the WINDOW colour - the side hover and selection do NOT come from, so a stripe never reads as one of them
	Protected Cold = *ThemeData\ShadeColor[#Cold], Back = *ThemeData\WindowColor
	
	ProcedureReturn RGBA((Red(Cold) + Red(Back) * 3) / 4, (Green(Cold) + Green(Back) * 3) / 4, (Blue(Cold) + Blue(Back) * 3) / 4, Alpha(Cold))
EndProcedure

Procedure ParameterList_DrawFold(X, Y, Size, Folded)
	; A small triangle: pointing right when the subtree is closed, down when it is open
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

Procedure ParameterList_Redraw(*GadgetData.ParameterListData)
	Protected Y, Row, FirstRow, Index, ShadeState, TextState, TextX, ExprX, ValueX, RuleTop, RuleBottom
	
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
		
		ParameterList_UpdateScrollBar(*GadgetData)	; …the rows that arrived while frozen
		ExprX = \OriginX + ParameterList_ExprX(*GadgetData)
		ValueX = \OriginX + ParameterList_ValueX(*GadgetData)
		RuleTop = \OriginY + \Border
		RuleBottom = \OriginY + \Height - \Border
		
		Y = \OriginY + \Border
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
			
			If Index = \State
				ShadeState = #Hot
			ElseIf Index = \ItemState
				ShadeState = #Warm
			ElseIf \Items()\Kind = #ParameterList_Group
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
			
			SelectElement(\Items(), Index)
			If ParameterList_ChildCount(*GadgetData, Index)
				VectorSourceColor(\ThemeData\TextColor[TextState])
				ParameterList_DrawFold(\OriginX + ParameterList_TextX(*GadgetData, \Items()\Depth) - #ParameterList_FoldWidth, Y, #ParameterList_FoldWidth, \Items()\Folded)
			EndIf
			
			SelectElement(\Items(), Index)
			TextX = \OriginX + ParameterList_TextX(*GadgetData, \Items()\Depth)
			VectorSourceColor(\ThemeData\TextColor[TextState])
			DrawVectorTextBlock(@\Items()\Text, TextX, Y)
			
			SelectElement(\Items(), Index)
			If \Items()\Adder
				VectorSourceColor(\ThemeData\TextColor[TextState])
				ParameterList_DrawAdd(ExprX - #ParameterList_ButtonWidth, Y, #ParameterList_ButtonWidth, \ItemHeight)
			EndIf
			
			SelectElement(\Items(), Index)
			If \Items()\Kind = #ParameterList_Value
				VectorSourceColor(\ThemeData\TextColor[TextState])
				DrawVectorTextBlock(@\Items()\Expression, ExprX + #ParameterList_Margin, Y)
				
				SelectElement(\Items(), Index)
				If \Items()\Faulty		; a complaint is ink the eye stops on, the way a number is not
					VectorSourceColor(\ThemeData\TextColor[#Hot])
				Else
					VectorSourceColor(\ThemeData\TextColor[#Disabled])
				EndIf
				DrawVectorTextBlock(@\Items()\Value, ValueX + #ParameterList_Margin, Y)
				
				SelectElement(\Items(), Index)
				If \Items()\Removable And Index = \ItemState
					VectorSourceColor(\ThemeData\TextColor[TextState])
					ParameterList_DrawRemove(\OriginX + \Border + ParameterList_ContentWidth(*GadgetData) - #ParameterList_ButtonWidth, Y, #ParameterList_ButtonWidth, \ItemHeight)
				EndIf
			EndIf
			
			Y + \ItemHeight
			Row + 1
		Wend
		
		VectorSourceColor(\ThemeData\LineColor[#Cold])
		AddPathBox(ExprX, RuleTop, 1, RuleBottom - RuleTop)
		FillPath()
		AddPathBox(ValueX, RuleTop, 1, RuleBottom - RuleTop)
		FillPath()
		
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
Procedure ParameterList_StartEdit(*GadgetData.ParameterListData, Index, Column)
	; Park the editor over one cell - column 0 the name, 1 the expression; a cell the row is not editable for is left alone
	Protected Event.Event, Row
	
	With *GadgetData
		If Not \Editable Or \Editing Or Index < 0
			ProcedureReturn #False
		EndIf
		
		Row = ParameterList_IndexToRow(*GadgetData, Index)
		If Row < 0 Or Not SelectElement(\Items(), Index)
			ProcedureReturn #False
		EndIf
		If \Items()\Kind <> #ParameterList_Value Or Not (\Items()\Editable & (1 << Column))
			ProcedureReturn #False
		EndIf
		
		\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
		\EditRow = Index
		\EditColumn = Column
		
		If Column = 0
			\String\String = \Items()\Text\OriginalText
			\String\OriginX = ParameterList_TextX(*GadgetData, \Items()\Depth)
			\String\Width = ParameterList_ExprX(*GadgetData) - \String\OriginX - #ParameterList_Margin
		Else
			\String\String = \Items()\Expression\OriginalText
			\String\OriginX = ParameterList_ExprX(*GadgetData) + #ParameterList_Margin
			\String\Width = ParameterList_ExprWidth(*GadgetData) - #ParameterList_Margin * 2
		EndIf
		
		String_ProcessString(\String)
		\String\OriginY = \Border + Row * \ItemHeight - ParameterList_ScrollOffset(*GadgetData) + 1
		
		Event\EventType = #Focus
		\String\EventHandler(\String, Event)
		StringSetSelection_Meta(\String, 0, Len(\String\String))
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure ParameterList_EndEdit(*GadgetData.ParameterListData, Keep)
	; Fold the editor away; Keep writes the typed text back and reports it with #EventType_ItemTextChange, the row in GetGadgetState and the cell in #Attribute_ParameterList_EditedColumn
	Protected Event.Event, Changed
	
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
			If \EditColumn = 0
				Changed = Bool(\Items()\Text\OriginalText <> \String\String)
				\Items()\Text\OriginalText = \String\String
			Else
				Changed = Bool(\Items()\Expression\OriginalText <> \String\String)
				\Items()\Expression\OriginalText = \String\String
			EndIf
			ParameterList_PrepareItem(*GadgetData, @\Items())
			
			If Changed
				\State = \EditRow
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
			EndIf
		EndIf
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure ParameterList_ToggleFold(*GadgetData.ParameterListData, Index)
	With *GadgetData
		If Not ParameterList_Select(*GadgetData, Index) Or Not ParameterList_ChildCount(*GadgetData, Index)
			ProcedureReturn #False
		EndIf
		
		\Items()\Folded = 1 - \Items()\Folded
		ParameterList_UpdateScrollBar(*GadgetData)
		\State = Index
		PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterFold)
	EndWith
	
	ProcedureReturn #True
EndProcedure

;- Events
Procedure ParameterList_EventHandler(*GadgetData.ParameterListData, *Event.Event)
	Protected Redraw, Row, Index, Zone, Cursor = *GadgetData\EditCursor, CursorWas = Cursor
	
	With *GadgetData
		Select *Event\EventType
			Case #MouseMove ;{
				If \String And \String\Selecting
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					Redraw = \String\EventHandler(\String, *Event)
				ElseIf \DragGrip
					If \DragGrip = #ParameterList_Zone_GripName
						\NameWidth = \DragOriginWidth + *Event\MouseX - \DragOriginX
						If \NameWidth < #ParameterList_MinColumn
							\NameWidth = #ParameterList_MinColumn
						EndIf
					Else
						\ValueWidth = \DragOriginWidth - (*Event\MouseX - \DragOriginX)
						If \ValueWidth < #ParameterList_MinColumn
							\ValueWidth = #ParameterList_MinColumn
						EndIf
					EndIf
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
						Index = ParameterList_RowToIndex(*GadgetData, Floor((*Event\MouseY + ParameterList_ScrollOffset(*GadgetData)) / \ItemHeight))
						If Index <> \ItemState
							\ItemState = Index
							Redraw = #True
						EndIf
						
						Zone = ParameterList_ZoneAt(*GadgetData, Index, *Event\MouseX)
						If Zone <> \HoverZone
							\HoverZone = Zone
							Redraw = #True
						EndIf
						If Zone = #ParameterList_Zone_GripName Or Zone = #ParameterList_Zone_GripValue
							Cursor = #PB_Cursor_LeftRight
						EndIf
					EndIf
				EndIf
				;}
			Case #MouseLeave ;{
				If \ItemState > -1
					\ItemState = -1
					\HoverZone = #ParameterList_Zone_Body
					Redraw = #True
				EndIf
				Cursor = #PB_Cursor_Default
				;}
			Case #MouseWheel ;{
				If \VisibleScrollBar
					ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight)
					Redraw = #True
				EndIf
				;}
			Case #LeftButtonDown ;{
				If \Editing
					If *Event\MouseX >= \String\OriginX And *Event\MouseX < \String\OriginX + \String\Width And *Event\MouseY >= \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
						ProcedureReturn Redraw
					EndIf
					Redraw = ParameterList_EndEdit(*GadgetData, #True)
				EndIf
				
				If \VisibleScrollBar And *Event\MouseX >= \ScrollBar\OriginX
					Redraw = ScrollBar_EventHandler(\ScrollBar, *Event) | Redraw
					ProcedureReturn Redraw
				EndIf
				
				Index = ParameterList_RowToIndex(*GadgetData, Floor((*Event\MouseY + ParameterList_ScrollOffset(*GadgetData)) / \ItemHeight))
				Zone = ParameterList_ZoneAt(*GadgetData, Index, *Event\MouseX)
				
				Select Zone
					Case #ParameterList_Zone_GripName, #ParameterList_Zone_GripValue
						\DragGrip = Zone
						\DragOriginX = *Event\MouseX
						If Zone = #ParameterList_Zone_GripName
							\DragOriginWidth = \NameWidth
						Else
							\DragOriginWidth = \ValueWidth
						EndIf
					Case #ParameterList_Zone_Fold
						Redraw = ParameterList_ToggleFold(*GadgetData, Index) | Redraw
					Case #ParameterList_Zone_Add
						\State = Index
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterAdd)
						Redraw = #True
					Case #ParameterList_Zone_Remove
						\State = Index
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ParameterRemove)
						Redraw = #True
					Default
						If Index <> \State
							\State = Index
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							Redraw = #True
						EndIf
						If Zone = #ParameterList_Zone_Name
							Redraw = ParameterList_StartEdit(*GadgetData, Index, 0) | Redraw
						ElseIf Zone = #ParameterList_Zone_Expression
							Redraw = ParameterList_StartEdit(*GadgetData, Index, 1) | Redraw
						EndIf
				EndSelect
				;}
			Case #LeftButtonUp ;{
				If \DragGrip
					\DragGrip = #ParameterList_Zone_Body
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
					Index = ParameterList_RowToIndex(*GadgetData, Floor((*Event\MouseY + ParameterList_ScrollOffset(*GadgetData)) / \ItemHeight))
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
							Redraw = ParameterList_EndEdit(*GadgetData, #True)
							If Zone = 0
								ParameterList_StartEdit(*GadgetData, Index, 1)
							Else
								Row = ParameterList_IndexToRow(*GadgetData, Index)
								ParameterList_StartEdit(*GadgetData, ParameterList_RowToIndex(*GadgetData, Row + 1), 0)
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
							Redraw = ParameterList_StartEdit(*GadgetData, \State, 0)
						Case #PB_Shortcut_Return
							Redraw = ParameterList_StartEdit(*GadgetData, \State, 1)
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
	; Level is CLAMPED one step deeper than the row before, so no row is left without a parent; the text is the three cells joined by #LF$, as a ListIcon row is written
	Protected *GadgetData.ParameterListData = *this\vt, *NewItem.ParameterList_Item, Depth, Ceiling, Line.s
	
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
		
		Line = PeekS(*Text)
		*NewItem\Depth = Depth
		*NewItem\Kind = #ParameterList_Value
		*NewItem\Text\OriginalText = StringField(Line, 1, #LF$)
		*NewItem\Expression\OriginalText = StringField(Line, 2, #LF$)
		*NewItem\Value\OriginalText = StringField(Line, 3, #LF$)
		
		*NewItem\Text\LineLimit = 1
		*NewItem\Text\FontID = \TextBlock\FontID
		*NewItem\Text\FontScale = \TextBlock\FontScale
		*NewItem\Text\VAlign = \TextBlock\VAlign
		*NewItem\Text\HAlign = \TextBlock\HAlign
		
		*NewItem\Expression\LineLimit = 1
		*NewItem\Expression\FontID = \TextBlock\FontID
		*NewItem\Expression\FontScale = \TextBlock\FontScale
		*NewItem\Expression\VAlign = \TextBlock\VAlign
		*NewItem\Expression\HAlign = \TextBlock\HAlign
		
		*NewItem\Value\LineLimit = 1
		*NewItem\Value\FontID = \TextBlock\FontID
		*NewItem\Value\FontScale = \TextBlock\FontScale
		*NewItem\Value\VAlign = \TextBlock\VAlign
		*NewItem\Value\HAlign = \TextBlock\HAlign
		
		ParameterList_PrepareItem(*GadgetData, *NewItem)
		
		ChangeCurrentElement(\Items(), *NewItem)
		Position = ListIndex(\Items())
		
		If Position <= \State
			\State + 1
		EndIf
		
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
		
		If \Editing And \EditRow >= Position
			ParameterList_EndEdit(*GadgetData, #False)
		EndIf
		
		Count = ParameterList_ChildCount(*GadgetData, Position) + 1
		For Loop = 1 To Count
			If SelectElement(\Items(), Position)
				DeleteElement(\Items())
			EndIf
		Next
		
		If \State >= ListSize(\Items())
			\State = ListSize(\Items()) - 1
		EndIf
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

Procedure.s ParameterList_GetItemText(*this.PB_Gadget, Position.l, Column.l)
	Protected *GadgetData.ParameterListData = *this\vt, Result.s
	
	With *GadgetData
		If Position > -1 And Position < ListSize(\Items())
			SelectElement(\Items(), Position)
			Select Column
				Case 1
					Result = \Items()\Expression\OriginalText
				Case 2
					Result = \Items()\Value\OriginalText
				Default
					Result = \Items()\Text\OriginalText
			EndSelect
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure ParameterList_SetItemText(*this.PB_Gadget, Position.l, *Text, Column.l)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		If Position > -1 And Position < ListSize(\Items())
			SelectElement(\Items(), Position)
			Select Column
				Case 1
					\Items()\Expression\OriginalText = PeekS(*Text)
				Case 2
					\Items()\Value\OriginalText = PeekS(*Text)
				Default
					\Items()\Text\OriginalText = PeekS(*Text)
			EndSelect
			ParameterList_PrepareItem(*GadgetData, @\Items())
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
	
	With *GadgetData
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
		
		ParameterList_PrepareItem(*GadgetData, @\Items())
		RedrawObject()
	EndWith
EndProcedure

Procedure ParameterList_SetState(*this.PB_Gadget, State)
	Protected *GadgetData.ParameterListData = *this\vt
	
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
				ProcedureReturn \NameWidth
			Case #Attribute_ParameterList_ValueWidth
				ProcedureReturn \ValueWidth
			Case #Attribute_ParameterList_EditedRow
				ProcedureReturn \CommitRow
			Case #Attribute_ParameterList_EditedColumn
				ProcedureReturn \CommitColumn
			Case #Attribute_ParameterList_HoverRow
				ProcedureReturn \ItemState
		EndSelect
	EndWith
	
	ProcedureReturn Default_GetAttribute(*this, Attribute)
EndProcedure

Procedure ParameterList_SetAttribute(*this.PB_Gadget, Attribute.l, Value)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		Select Attribute
			Case #Attribute_ParameterList_NameWidth
				\NameWidth = Value
			Case #Attribute_ParameterList_ValueWidth
				\ValueWidth = Value
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
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		\TextBlock\FontID = FontID
		ForEach \Items()
			\Items()\Text\FontID = FontID
			\Items()\Expression\FontID = FontID
			\Items()\Value\FontID = FontID
			ParameterList_PrepareItem(*GadgetData, @\Items())
		Next
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
		
		ScrollBar_ResizeMeta(\ScrollBar, \Width - #ParameterList_ToolbarThickness - \Border - 1, \Border + 1, #ParameterList_ToolbarThickness, \Height - \Border * 2 - 2)
		ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
		
		ParameterList_PrepareAll(*GadgetData)
		ParameterList_UpdateScrollBar(*GadgetData)
	EndWith
	
	RedrawObject()
EndProcedure

Procedure ParameterList_FreeGadget(*this.PB_Gadget)
	Protected *GadgetData.ParameterListData = *this\vt
	
	With *GadgetData
		DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
		FreeStructureX(\ScrollBar)
		
		If \String
			RemoveGadgetTimers(\String)
			FreeMemory(\String\ThemeData)		; the editor's own copy of the theme
			FreeStructureX(\String)
		EndIf
		
		ClearList(\Items())
	EndWith
	
	Default_FreeGadget(*this)
EndProcedure

Procedure ParameterList_Meta(*GadgetData.ParameterListData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags)
	Protected *StringThemeData.Theme
	*GadgetData\ThemeData = *ThemeData
	InitializeObject(ParameterList)
	
	With *GadgetData
		If Not (Flags & (#VAlignTop | #VAlignBottom))
			\TextBlock\VAlign = #VAlignCenter
		EndIf
		
		\ItemHeight = #ParameterList_ItemHeight
		\State = -1
		\ItemState = -1
		\NameWidth = Width * 0.4			; a starting split, dragged from there by the rules between the columns
		\ValueWidth = Width * 0.22
		
		AllocateStructureX(\ScrollBar, ScrollBarData)
		ScrollBar_Meta(\ScrollBar, *ThemeData, -1, Width - #ParameterList_ToolbarThickness - \Border - 1, \Border + 1, #ParameterList_ToolbarThickness, Height - \Border * 2 - 2, 0, \ItemHeight, Height, #Gadget_Vertical)
		
		\VT\AddGadgetItem3 = @ParameterList_AddItem()
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
; IDE Options = PureBasic 6.41 (Windows - x64)
; CursorPosition = 463
; FirstLine = 78
; Folding = AAAAAAAAg
; EnableXP
; DPIAware