#TimeLine_List_Width = 222
#TimeLine_List_TextMargin = 10
#TimeLine_List_FoldWidth = 16
#TimeLine_List_TextIndent = 26			; always reserved, so a label never shifts sideways when its line gains a fold
#TimeLine_Header_Height = 60
#TimeLine_List_LineHeight = 58
#TimeLine_Body_BlockHeight = 44
#TimeLine_Body_BlockMargin = 7
#TimeLine_Body_SubRowHeight = 26		; the band a line grows by when its containers are unfolded
#TimeLine_Body_IconSize = 24
#TimeLine_TrackBarThickness = 7
#TimeLine_Focus_Timer = 400

#TimeLine_Block_MinWidth = 5			; narrower than this and a block is drawn as a bare tick
#TimeLine_Block_TextWidth = 37			; narrower than this and the icon and the label are dropped
#TimeLine_Block_Radius = 4
#TimeLine_ResizeGrip = 5				; how close to an edge the pointer has to be to resize instead of move

#TimeLine_Ruler_MinSpacing = 8			; smallest gap tolerated between two minor ticks
#TimeLine_Ruler_LabelSpacing = 46		; …and between two labels, which are far wider
#TimeLine_Ruler_MinorTick = 9
#TimeLine_Ruler_MajorTick = 22

#TimeLine_Player_Width = 11
#TimeLine_Player_Height = 15
#TimeLine_Player_Grab = 7				; half-width of the header band that grabs the playhead

#TimeLine_Duration_Extension = 50		; slack left past a block that would otherwise run off the end

#TimeLine_Hatch_Pitch = 6				; width of one bar of the hatching that strikes out a band a block has no use for
#TimeLine_Hatch_Alpha = 90				; …how faint it is against the band, at the block's own opacity
#TimeLine_Band_Alpha = 110				; how far a sub-row is shaded off its block's own back colour
#TimeLine_Band_AltAlpha = 150			; …and the same for every other one, so a stack of bands reads apart
#TimeLine_Band_RuleAlpha = 100			; …and of the hairline that separates two of them
#TimeLine_Key_Diamond = 5				; half-height of a key drawn as a diamond
#TimeLine_Key_Dot = 2.5					; radius of a key drawn as a dot
#TimeLine_Key_Pip = 1.5					; …and of one drawn as a bare pip
#TimeLine_Key_DiamondScale = 8			; pixels per unit from which keys are worth drawing as diamonds
#TimeLine_Key_DotScale = 3				; …and from which they are worth more than a pip
#TimeLine_Key_Grab = 4					; how close to a key the pointer counts as on it

Enumeration ; Line fold state
	#TimeLine_NoFold					; nothing under this line to reveal
	#TimeLine_Folded
	#TimeLine_Unfolded
EndEnumeration

Enumeration ; What the pointer is currently doing over the body
	#TimeLine_Action_None
	#TimeLine_Action_BlockInitDrag
	#TimeLine_Action_BlockDrag
	#TimeLine_Action_BlockResize
	#TimeLine_Action_KeyInitDrag
	#TimeLine_Action_KeyDrag
	#TimeLine_Action_PlayerDrag
EndEnumeration

Enumeration ; Which edge of a block the pointer is sitting on
	#TimeLine_Resize_None
	#TimeLine_Resize_Left
	#TimeLine_Resize_Right
EndEnumeration

#__TimeLine_Zoom_Count = 12
#TimeLine_Zoom_Default = 2

; Pixels per time unit. SetGadgetAttribute takes the rung, not the ratio.
Global Dim TimeLine_ZoomLevel.d(#__TimeLine_Zoom_Count - 1)
TimeLine_ZoomLevel(0) = 0.25
TimeLine_ZoomLevel(1) = 0.5
TimeLine_ZoomLevel(2) = 1
TimeLine_ZoomLevel(3) = 2
TimeLine_ZoomLevel(4) = 3
TimeLine_ZoomLevel(5) = 4
TimeLine_ZoomLevel(6) = 6
TimeLine_ZoomLevel(7) = 8
TimeLine_ZoomLevel(8) = 12
TimeLine_ZoomLevel(9) = 16
TimeLine_ZoomLevel(10) = 24
TimeLine_ZoomLevel(11) = 32

Global TimeLine_ListFont = FontID(LoadFont(#PB_Any, "Segoe UI Semibold", 12, #PB_Font_HighQuality))
Global TimeLine_Font = FontID(LoadFont(#PB_Any, "Segoe UI", 10, #PB_Font_HighQuality))
Global TimeLine_RulerFont = FontID(LoadFont(#PB_Any, "Segoe UI", 8, #PB_Font_HighQuality))

Structure TimeLine_Key
	Track.b								; which keyable track it sits on
	Time.i								; relative to its block's start, as the block is to its parent
	Value.d								; the gadget only stores and draws it; interpolating is the caller's business
	Selected.b
	*Block.TimeLine_Block
EndStructure

Structure TimeLine_Block
	Text.s
	Color.l
	Icon.i
	Postion.i							; relative to the parent block when it has one, absolute otherwise
	Duration.i
	State.b								; #Cold / #Warm / #Hot
	Selected.b
	Dragged.b							; drawn faded while its preview outline is being moved
	Container.b							; can hold children, and so gives its line a sub-row
	Tracks.l							; bitmask of the keyable tracks it animates, one sub-row each
	*ParentLine.TimeLine_Line
	*Parent.TimeLine_Block
	*Data
	List *Children.TimeLine_Block()
	List Keys.TimeLine_Key()			; ordered by track, then by time
EndStructure

Structure TimeLine_Line
	Text.Text
	Height.l
	Y.l
	Fold.b								; #TimeLine_NoFold / _Folded / _Unfolded
	SubRows.b							; bands the line shows when unfolded: the children band, then one per track
	ContainerCount.l
	Tracks.l							; every track any of its blocks animates
	List *MediaBlocks.TimeLine_Block()
EndStructure

Structure TimeLineData Extends GadgetData
	BodyHeight.l
	BodyWidth.l
	
	RedrawList.b
	RedrawBody.b
	RedrawHeader.b
	RedrawAll.b
	
	InternalHeight.l
	
	DragState.i
	DragOriginX.i
	DragOriginY.i
	ReorderWindow.i
	ReorderCanvas.i
	ReorderPosition.i
	ReorderFocusTimer.i
	ReorderDirection.i
	
	Editing.i
	EditCursor.i
	
	*FirstDisplayedLine
	
	Duration.i
	Zoom.b								; rung of TimeLine_ZoomLevel()
	Scale.d								; pixels per time unit, ie. TimeLine_ZoomLevel(\Zoom)
	PlayerPosition.i
	
	Action.b							; #TimeLine_Action_*
	ResizeEdge.b						; #TimeLine_Resize_*
	ScaleContents.b						; shift held over a resize: stretch what is inside rather than trim it
	DragGrabOffset.i					; time between the grabbed block's start and the pointer
	DragTime.i							; time every selected block would shift by
	DragLine.i							; lines every selected block would shift by
	*DragParent.TimeLine_Block			; container the drag would drop a single block into
	DropLine.l							; line index under the pointer mid-drag, -1 for none
	
	HoverItem.l							; hovered line index, -1 when none (the base \MouseState stays a #Cold/#Warm/#Hot state)
	HoverFold.b							; …and whether it is the fold chevron rather than the label
	*HoverBlock.TimeLine_Block
	*HoverKey.TimeLine_Key
	
	TrackName.s[#__TimeLine_Band_Count]	; what each band calls itself in the line list
	
	List Lines.TimeLine_Line()
	List Blocks.TimeLine_Block()		; owns every block; the lines only hold pointers into it
	List *Selection.TimeLine_Block()
	List *KeySelection.TimeLine_Key()	; keys and blocks select apart: picking one clears the other
	
	VisibleVerticalScrollBar.b
	*VScrollBar.ScrollBarData
	
	VisibleHorizontalScrollBar.b
	*HScrollBar.ScrollBarData
	
	*String.StringData
	
EndStructure

Declare TimeLine_EventHandler(*GadgetData.TimeLineData, *Event.Event)
Declare TimeLine_Redraw(*GadgetData.TimeLineData)
Declare TimeLine_SetState(*this.PB_Gadget, State)
Declare TimeLine_FirstDisplayed(*GadgetData.TimeLineData)
Declare TimeLine_TrackUsed(*Block.TimeLine_Block, Track)
Declare TimeLine_SortKey(*Block.TimeLine_Block, *Key.TimeLine_Key)
Declare TimeLine_BlockBands(*Block.TimeLine_Block)

;- Geometry
Procedure TimeLine_SetScroll(*Bar.ScrollBarData, Value)
	; Below one page, ScrollBar_SetState_Meta's Max - PageLength ceiling sits under the floor, so asking it for 0 parks the bar far negative.
	If *Bar\Max - *Bar\PageLength <= *Bar\Min
		*Bar\State = *Bar\Min
		*Bar\Position = 0
	Else
		ScrollBar_SetState_Meta(*Bar, Value)
	EndIf
EndProcedure

Procedure TimeLine_TimeToX(*GadgetData.TimeLineData, Time)
	; Gadget-local X of a time unit. Drawing and hit-testing both come through here so they cannot drift apart.
	ProcedureReturn #TimeLine_List_Width + Round((Time - *GadgetData\HScrollBar\State) * *GadgetData\Scale, #PB_Round_Nearest)
EndProcedure

Procedure TimeLine_XToTime(*GadgetData.TimeLineData, X)
	ProcedureReturn Floor((X - #TimeLine_List_Width) / *GadgetData\Scale) + *GadgetData\HScrollBar\State
EndProcedure

Procedure TimeLine_BlockStart(*Block.TimeLine_Block)
	; A child's Postion is relative to its parent, so an absolute start has to be walked up.
	Protected Result = *Block\Postion
	
	While *Block\Parent
		*Block = *Block\Parent
		Result + *Block\Postion
	Wend
	
	ProcedureReturn Result
EndProcedure

Procedure TimeLine_LineHeight(*Line.TimeLine_Line)
	If *Line\Fold = #TimeLine_Unfolded
		ProcedureReturn #TimeLine_List_LineHeight + *Line\SubRows * #TimeLine_Body_SubRowHeight
	EndIf
	
	ProcedureReturn #TimeLine_List_LineHeight
EndProcedure

Procedure TimeLine_BandKind(*Line.TimeLine_Line, Band)
	; What a line's Nth sub-row shows: #TimeLine_Track_Content for the children band, otherwise the
	; keyable track it belongs to. -1 past the last band. Children come first, then tracks in order.
	Protected Track
	
	If Band < 0
		ProcedureReturn -1
	EndIf
	
	If *Line\ContainerCount
		If Band = 0
			ProcedureReturn #TimeLine_Track_Content
		EndIf
		Band - 1
	EndIf
	
	For Track = 0 To #__TimeLine_Track_Count - 1
		If *Line\Tracks & (1 << Track)
			If Band = 0
				ProcedureReturn Track
			EndIf
			Band - 1
		EndIf
	Next
	
	ProcedureReturn -1
EndProcedure

Procedure TimeLine_BlockBands(*Block.TimeLine_Block)
	; How far down its line's stack a block reaches: to the last band it actually uses, and no
	; further. A block that uses none keeps its bare height, and the bands it steps over on the way
	; down to one it does use are the only ones that get hatched.
	Protected Band, Kind, Result, *Line.TimeLine_Line = *Block\ParentLine
	
	If Not *Line Or *Line\Fold <> #TimeLine_Unfolded
		ProcedureReturn 0
	EndIf
	
	For Band = 0 To *Line\SubRows - 1
		Kind = TimeLine_BandKind(*Line, Band)
		
		If Kind = #TimeLine_Track_Content
			If *Block\Container
				Result = Band + 1
			EndIf
		ElseIf Kind > -1 And *Block\Tracks & (1 << Kind)
			Result = Band + 1
		EndIf
	Next
	
	ProcedureReturn Result
EndProcedure

Procedure TimeLine_BandAt(*Line.TimeLine_Line, RowY, Y)
	; Which sub-row a gadget-local Y falls in, -1 for the block row itself.
	If *Line\Fold <> #TimeLine_Unfolded Or Y < RowY + #TimeLine_Body_BlockMargin + #TimeLine_Body_BlockHeight
		ProcedureReturn -1
	EndIf
	
	; Unclamped on purpose: the slack below the last band is not part of it, and an index past the
	; end reads back as -1 from TimeLine_BandKind, which every caller already handles.
	ProcedureReturn Floor((Y - RowY - #TimeLine_Body_BlockMargin - #TimeLine_Body_BlockHeight) / #TimeLine_Body_SubRowHeight)
EndProcedure

Procedure TimeLine_LayoutLines(*GadgetData.TimeLineData)
	; Re-stack every line and hand the vertical scrollbar the new total.
	Protected Y
	
	With *GadgetData
		ForEach \Lines()
			\Lines()\Height = TimeLine_LineHeight(@\Lines())
			\Lines()\Y = Y
			Y + \Lines()\Height
		Next
		
		\InternalHeight = Y
		\VisibleVerticalScrollBar = Bool(\InternalHeight > \BodyHeight)
		ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, Max(\InternalHeight, 1))
		ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_PageLength, Min(Max(\BodyHeight, 1), Max(\InternalHeight, 1)))
		TimeLine_SetScroll(\VScrollBar, \VScrollBar\State)
	EndWith
EndProcedure

Procedure TimeLine_UpdateFold(*GadgetData.TimeLineData, *Line.TimeLine_Line)
	; Recount the bands a line owes its blocks. Counted from the blocks rather than kept as running
	; totals, so no mutation path can leave the two disagreeing.
	Protected Previous = *Line\Fold, Track
	
	*Line\Tracks = 0
	*Line\ContainerCount = 0
	
	ForEach *Line\MediaBlocks()
		*Line\Tracks | *Line\MediaBlocks()\Tracks
		*Line\ContainerCount + Bool(*Line\MediaBlocks()\Container)
	Next
	
	*Line\SubRows = Bool(*Line\ContainerCount > 0)
	For Track = 0 To #__TimeLine_Track_Count - 1
		*Line\SubRows + Bool(*Line\Tracks & (1 << Track))
	Next
	
	If *Line\SubRows
		If *Line\Fold = #TimeLine_NoFold
			*Line\Fold = #TimeLine_Folded
		EndIf
	Else
		*Line\Fold = #TimeLine_NoFold
	EndIf
	
	ProcedureReturn Bool(*Line\Fold <> Previous)
EndProcedure

Procedure TimeLine_RefreshBands(*GadgetData.TimeLineData)
	; Every path that adds, removes or retypes a block ends here.
	With *GadgetData
		ForEach \Lines()
			TimeLine_UpdateFold(*GadgetData, @\Lines())
		Next
		
		TimeLine_LayoutLines(*GadgetData)
		TimeLine_FirstDisplayed(*GadgetData)
		\RedrawList = #True
		\RedrawBody = #True
	EndWith
EndProcedure

Procedure TimeLine_UpdateHScrollBar(*GadgetData.TimeLineData)
	; The bar counts time units, not pixels, so the zoom only ever changes its page length.
	Protected Page = Max(Floor(*GadgetData\BodyWidth / *GadgetData\Scale), 1)
	
	With *GadgetData
		\VisibleHorizontalScrollBar = Bool(\Duration > Page)
		ScrollBar_SetAttribute_Meta(\HScrollBar, #ScrollBar_Maximum, Max(\Duration, 1))
		ScrollBar_SetAttribute_Meta(\HScrollBar, #ScrollBar_PageLength, Min(Page, Max(\Duration, 1)))
		TimeLine_SetScroll(\HScrollBar, \HScrollBar\State)
	EndWith
EndProcedure

Procedure TimeLine_ExtendDuration(*GadgetData.TimeLineData, Time)
	; Keep a little room past whatever was just dropped at the far end.
	If Time >= *GadgetData\Duration
		*GadgetData\Duration = Time + #TimeLine_Duration_Extension
		TimeLine_UpdateHScrollBar(*GadgetData)
		ProcedureReturn #True
	EndIf
	
	ProcedureReturn #False
EndProcedure

Procedure TimeLine_FirstDisplayed(*GadgetData.TimeLineData)
	; The topmost line with any pixel on screen, or 0 when the list is empty.
	With *GadgetData
		ForEach \Lines()
			If \Lines()\Y + \Lines()\Height > \VScrollBar\State
				\FirstDisplayedLine = @\Lines()
				ProcedureReturn \FirstDisplayedLine
			EndIf
		Next
		
		If LastElement(\Lines())
			\FirstDisplayedLine = @\Lines()
		Else
			\FirstDisplayedLine = 0
		EndIf
		
		ProcedureReturn \FirstDisplayedLine
	EndWith
EndProcedure

Procedure TimeLine_LineAt(*GadgetData.TimeLineData, Y)
	; Gadget-local Y to a line index, leaving \Lines() selected on it. -1 above the body or past the last line.
	With *GadgetData
		If Y < #TimeLine_Header_Height Or Not ListSize(\Lines())
			ProcedureReturn -1
		EndIf
		
		Y + \VScrollBar\State - #TimeLine_Header_Height
		
		ForEach \Lines()
			If Y < \Lines()\Y + \Lines()\Height
				ProcedureReturn ListIndex(\Lines())
			EndIf
		Next
	EndWith
	
	ProcedureReturn -1
EndProcedure

Procedure TimeLine_BlockAt(*GadgetData.TimeLineData, X, Y)
	; Geometric hit-test rather than a collision grid: a line carries few blocks, and this cannot disagree with what was drawn.
	Protected Line, RowY, BlockX, BlockWidth, Band, *Block.TimeLine_Block, *Child.TimeLine_Block
	
	With *GadgetData
		If X <= #TimeLine_List_Width
			ProcedureReturn #Null
		EndIf
		
		Line = TimeLine_LineAt(*GadgetData, Y)
		If Line = -1
			ProcedureReturn #Null
		EndIf
		
		RowY = \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
		Band = TimeLine_BandAt(@\Lines(), RowY, Y)
		
		If Band = -1 And Y < RowY + #TimeLine_Body_BlockMargin
			ProcedureReturn #Null						; the gap above the blocks
		EndIf
		
		If LastElement(\Lines()\MediaBlocks())
			Repeat
				*Block = \Lines()\MediaBlocks()
				BlockX = TimeLine_TimeToX(*GadgetData, *Block\Postion)
				BlockWidth = Max(*Block\Duration * \Scale, 1)
				
				If X < BlockX Or X > BlockX + BlockWidth
					Continue
				EndIf
				
				If Band >= TimeLine_BlockBands(*Block)
					Continue
				EndIf
				
				If Band > -1 And TimeLine_BandKind(@\Lines(), Band) = #TimeLine_Track_Content And *Block\Container
					If LastElement(*Block\Children())
						Repeat
							*Child = *Block\Children()
							BlockX = TimeLine_TimeToX(*GadgetData, *Block\Postion + *Child\Postion)
							BlockWidth = Max(*Child\Duration * \Scale, 1)
							
							If X >= BlockX And X <= BlockX + BlockWidth
								ProcedureReturn *Child
							EndIf
						Until Not PreviousElement(*Block\Children())
					EndIf
					
					ChangeCurrentElement(\Lines()\MediaBlocks(), *Block)
				EndIf
				
				ProcedureReturn *Block
			Until Not PreviousElement(\Lines()\MediaBlocks())
		EndIf
	EndWith
	
	ProcedureReturn #Null
EndProcedure

Procedure TimeLine_ResizeEdgeAt(*GadgetData.TimeLineData, *Block.TimeLine_Block, X)
	Protected BlockX, BlockWidth
	
	If Not *Block
		ProcedureReturn #TimeLine_Resize_None
	EndIf
	
	BlockX = TimeLine_TimeToX(*GadgetData, TimeLine_BlockStart(*Block))
	BlockWidth = Max(*Block\Duration * *GadgetData\Scale, 1)
	
	If BlockWidth < #TimeLine_ResizeGrip * 3					; too narrow to split into three zones
		ProcedureReturn #TimeLine_Resize_None
	ElseIf X <= BlockX + #TimeLine_ResizeGrip
		ProcedureReturn #TimeLine_Resize_Left
	ElseIf X >= BlockX + BlockWidth - #TimeLine_ResizeGrip
		ProcedureReturn #TimeLine_Resize_Right
	EndIf
	
	ProcedureReturn #TimeLine_Resize_None
EndProcedure

Procedure TimeLine_ResizedSpan(*Block.TimeLine_Block, Edge, Delta, *Start.Integer, *Duration.Integer)
	Protected Start = *Block\Postion, Finish = Start + *Block\Duration
	
	If Edge = #TimeLine_Resize_Left
		Start = Clamp(Start + Delta, 0, Finish - 1)
	Else
		Finish = Max(Finish + Delta, Start + 1)
	EndIf
	
	*Start\i = Start
	*Duration\i = Finish - Start
EndProcedure

Procedure TimeLine_ScaleContents(*Block.TimeLine_Block, OldDuration, NewDuration)
	Protected Ratio.d, Span
	
	If OldDuration < 1 Or NewDuration < 1 Or OldDuration = NewDuration
		ProcedureReturn #False
	EndIf
	
	Ratio = NewDuration / OldDuration
	
	ForEach *Block\Keys()
		*Block\Keys()\Time = Round(*Block\Keys()\Time * Ratio, #PB_Round_Nearest)
	Next
	
	ForEach *Block\Children()
		Span = Max(Round(*Block\Children()\Duration * Ratio, #PB_Round_Nearest), 1)
		TimeLine_ScaleContents(*Block\Children(), *Block\Children()\Duration, Span)
		*Block\Children()\Postion = Round(*Block\Children()\Postion * Ratio, #PB_Round_Nearest)
		*Block\Children()\Duration = Span
	Next
	
	ProcedureReturn #True
EndProcedure

;- Selection
Procedure TimeLine_ClearSelection(*GadgetData.TimeLineData)
	With *GadgetData
		ForEach \Selection()
			\Selection()\Selected = #False
			\Selection()\State = #Cold
		Next
		ClearList(\Selection())
	EndWith
EndProcedure

Procedure TimeLine_Select(*GadgetData.TimeLineData, *Block.TimeLine_Block, Add)
	With *GadgetData
		If Not Add
			TimeLine_ClearSelection(*GadgetData)
		EndIf
		
		If Not *Block Or *Block\Selected
			ProcedureReturn #False
		EndIf
		
		AddElement(\Selection())
		\Selection() = *Block
		*Block\Selected = #True
		*Block\State = #Hot
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure TimeLine_Deselect(*GadgetData.TimeLineData, *Block.TimeLine_Block)
	With *GadgetData
		ForEach \Selection()
			If \Selection() = *Block
				*Block\Selected = #False
				*Block\State = #Cold
				DeleteElement(\Selection())
				ProcedureReturn #True
			EndIf
		Next
	EndWith
	
	ProcedureReturn #False
EndProcedure

Procedure TimeLine_ClearKeySelection(*GadgetData.TimeLineData)
	With *GadgetData
		ForEach \KeySelection()
			\KeySelection()\Selected = #False
		Next
		ClearList(\KeySelection())
	EndWith
EndProcedure

Procedure TimeLine_SelectKey(*GadgetData.TimeLineData, *Key.TimeLine_Key, Add)
	With *GadgetData
		If Not Add
			TimeLine_ClearKeySelection(*GadgetData)
		EndIf
		
		If Not *Key Or *Key\Selected
			ProcedureReturn #False
		EndIf
		
		AddElement(\KeySelection())
		\KeySelection() = *Key
		*Key\Selected = #True
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure TimeLine_DeselectKey(*GadgetData.TimeLineData, *Key.TimeLine_Key)
	With *GadgetData
		ForEach \KeySelection()
			If \KeySelection() = *Key
				*Key\Selected = #False
				DeleteElement(\KeySelection())
				ProcedureReturn #True
			EndIf
		Next
	EndWith
	
	ProcedureReturn #False
EndProcedure

Procedure TimeLine_DropBlockKeys(*GadgetData.TimeLineData, *Block.TimeLine_Block)
	; Keys go with their block, so nothing may be left pointing into one that is about to go.
	With *GadgetData
		ForEach \KeySelection()
			If \KeySelection()\Block = *Block
				\KeySelection()\Selected = #False
				DeleteElement(\KeySelection())
			EndIf
		Next
		
		If \HoverKey And \HoverKey\Block = *Block
			\HoverKey = #Null
		EndIf
	EndWith
EndProcedure

Procedure TimeLine_KeyAt(*GadgetData.TimeLineData, X, Y)
	; Which key the pointer is on, if any. Only the band belonging to a key's own track can hold it.
	Protected Line, RowY, Band, Track, BlockX, BlockWidth, KeyX, Start, *Block.TimeLine_Block
	
	With *GadgetData
		If X <= #TimeLine_List_Width
			ProcedureReturn #Null
		EndIf
		
		Line = TimeLine_LineAt(*GadgetData, Y)
		If Line = -1
			ProcedureReturn #Null
		EndIf
		
		RowY = \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
		Band = TimeLine_BandAt(@\Lines(), RowY, Y)
		Track = TimeLine_BandKind(@\Lines(), Band)
		
		If Band < 0 Or Track < 0 Or Track = #TimeLine_Track_Content
			ProcedureReturn #Null
		EndIf
		
		; Back to front, like the blocks themselves: the key on top belongs to the block on top.
		If LastElement(\Lines()\MediaBlocks())
			Repeat
				*Block = \Lines()\MediaBlocks()
				BlockX = TimeLine_TimeToX(*GadgetData, *Block\Postion)
				BlockWidth = Max(*Block\Duration * \Scale, 1)
				
				If X < BlockX - #TimeLine_Key_Grab Or X > BlockX + BlockWidth + #TimeLine_Key_Grab Or Not (*Block\Tracks & (1 << Track))
					Continue
				EndIf
				
				Start = TimeLine_BlockStart(*Block)
				
				ForEach *Block\Keys()
					If *Block\Keys()\Track <> Track Or *Block\Keys()\Time < 0 Or *Block\Keys()\Time > *Block\Duration
						Continue
					EndIf
					
					KeyX = TimeLine_TimeToX(*GadgetData, Start + *Block\Keys()\Time)
					
					If Abs(X - KeyX) <= #TimeLine_Key_Grab
						ProcedureReturn @*Block\Keys()
					EndIf
				Next
				
				ChangeCurrentElement(\Lines()\MediaBlocks(), *Block)
			Until Not PreviousElement(\Lines()\MediaBlocks())
		EndIf
	EndWith
	
	ProcedureReturn #Null
EndProcedure

Procedure TimeLine_ApplyKeyDrag(*GadgetData.TimeLineData)
	; Commit the retime the band has been previewing. A key never leaves its own block.
	Protected Changed, Time, *Key.TimeLine_Key
	Protected NewList *Moving.TimeLine_Key()
	
	With *GadgetData
		ForEach \KeySelection()
			AddElement(*Moving())
			*Moving() = \KeySelection()
		Next
		
		ForEach *Moving()
			*Key = *Moving()
			Time = Clamp(*Key\Time + \DragTime, 0, *Key\Block\Duration)
			
			If Time <> *Key\Time
				*Key\Time = Time
				TimeLine_SortKey(*Key\Block, *Key)
				Changed = #True
			EndIf
		Next
		
		\Action = #TimeLine_Action_None
		\DragTime = 0
		\RedrawBody = #True
	EndWith
	
	ProcedureReturn Changed
EndProcedure

;- Drawing
Procedure TimeLine_DrawFold(X, Y, Size, Folded)
	; The same triangle the LayerList uses: pointing right when shut, down when open.
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

Procedure TimeLine_Redraw_ListItem(*GadgetData.TimeLineData, X, Y, State)
	Protected BandY, Band, Kind, Name.s
	
	With *GadgetData
		If State > #Cold
			AddPathBox(X, Y, #TimeLine_List_Width - 0.5, \Lines()\Height)
			VectorSourceColor(\ThemeData\ShadeColor[State])
			FillPath()
		EndIf
		
		If \Lines()\Fold
			If \HoverFold And ListIndex(\Lines()) = \HoverItem
				VectorSourceColor(\ThemeData\TextColor[#Hot])
			Else
				VectorSourceColor(\ThemeData\TextColor[State])
			EndIf
			TimeLine_DrawFold(X + #TimeLine_List_TextMargin, Y + (#TimeLine_List_LineHeight - #TimeLine_List_FoldWidth) * 0.5, #TimeLine_List_FoldWidth, Bool(\Lines()\Fold = #TimeLine_Folded))
		EndIf
		
		If State = #Cold
			VectorSourceColor(SetAlpha(\ThemeData\TextColor[State], 200))
		Else
			VectorSourceColor(\ThemeData\TextColor[State])
		EndIf
		
		DrawVectorTextBlock(@\Lines()\Text, X + #TimeLine_List_TextIndent, Y)
		
		If \Lines()\Fold = #TimeLine_Unfolded ;{ Name each band the body grew by, right against the column edge
			BandY = Y + #TimeLine_List_LineHeight
			VectorFont(TimeLine_Font)
			
			For Band = 0 To \Lines()\SubRows - 1
				Kind = TimeLine_BandKind(@\Lines(), Band)
				
				If Kind > -1
					Name = \TrackName[Kind]
					VectorSourceColor(SetAlpha(\ThemeData\TextColor[State], 170))
					MovePathCursor(X + #TimeLine_List_Width - #TimeLine_List_TextMargin - VectorTextWidth(Name), BandY + (#TimeLine_Body_SubRowHeight - VectorTextHeight(Name)) * 0.5)
					DrawVectorText(Name)
				EndIf
				
				BandY + #TimeLine_Body_SubRowHeight
			Next
			;}
		EndIf
		
		VectorSourceColor(\ThemeData\TextColor[#Cold])
	EndWith
EndProcedure

Procedure TimeLine_DrawHatch(X, Y, Width, Height)
	; Diagonal bars, the way PureTimeline struck out a band the block has nothing to put in it.
	Protected Position
	
	For Position = - Height To Width Step #TimeLine_Hatch_Pitch * 2
		MovePathCursor(X + Position, Y)
		AddPathLine(Height, Height, #PB_Path_Relative)
		AddPathLine(#TimeLine_Hatch_Pitch, 0, #PB_Path_Relative)
		AddPathLine(- Height, - Height, #PB_Path_Relative)
		ClosePath()
	Next
	
	FillPath()
EndProcedure

Procedure TimeLine_Redraw_Keys(*GadgetData.TimeLineData, *Block.TimeLine_Block, Track, X, Y, Width, Alpha)
	Protected KeyX.d, CY.d = Y + #TimeLine_Body_SubRowHeight * 0.5, Start = TimeLine_BlockStart(*Block)
	Protected Previous = -1, Gap = 1 << 30, Drawn, Time, Ratio.d = 1, NewStart, NewDuration
	
	With *GadgetData
		If \Action = #TimeLine_Action_BlockResize And \ScaleContents And *Block\Selected And *Block\Duration > 0
			TimeLine_ResizedSpan(*Block, \ResizeEdge, \DragTime, @NewStart, @NewDuration)
			Ratio = NewDuration / *Block\Duration
			Start + NewStart - *Block\Postion
		EndIf
		ForEach *Block\Keys()
			; A key the trim left outside the span is kept but not shown, so it takes no part here.
			If *Block\Keys()\Track <> Track Or *Block\Keys()\Time < 0 Or *Block\Keys()\Time > *Block\Duration
				Continue
			ElseIf Previous > -1
				Gap = Min(Gap, (*Block\Keys()\Time - Previous) * \Scale)
			EndIf
			
			Previous = *Block\Keys()\Time
		Next
		
		ForEach *Block\Keys()
			If *Block\Keys()\Track <> Track Or *Block\Keys()\Time < 0 Or *Block\Keys()\Time > *Block\Duration
				Continue
			EndIf
			
			Time = Round(*Block\Keys()\Time * Ratio, #PB_Round_Nearest)
			
			If *Block\Keys()\Selected And \Action = #TimeLine_Action_KeyDrag
				Time = Clamp(Time + \DragTime, 0, *Block\Duration)
			EndIf
			
			KeyX = \OriginX + TimeLine_TimeToX(*GadgetData, Start + Time) + 0.5
			
			If KeyX < X - #TimeLine_Key_Diamond Or KeyX > X + Width + #TimeLine_Key_Diamond
				Continue
			EndIf
			
			If Gap >= #TimeLine_Key_Diamond * 2 + 3
				MovePathCursor(KeyX, CY - #TimeLine_Key_Diamond)
				AddPathLine(#TimeLine_Key_Diamond, #TimeLine_Key_Diamond, #PB_Path_Relative)
				AddPathLine(- #TimeLine_Key_Diamond, #TimeLine_Key_Diamond, #PB_Path_Relative)
				AddPathLine(- #TimeLine_Key_Diamond, - #TimeLine_Key_Diamond, #PB_Path_Relative)
				ClosePath()
			ElseIf Gap >= #TimeLine_Key_Dot * 2 + 2
				AddPathCircle(KeyX, CY, #TimeLine_Key_Dot)
			Else
				AddPathCircle(KeyX, CY, #TimeLine_Key_Pip)
			EndIf
			
			If *Block\Keys()\Selected
				VectorSourceColor(SetAlpha(\ThemeData\Special3[#Warm], Alpha))
			ElseIf @*Block\Keys() = \HoverKey
				VectorSourceColor(SetAlpha(\ThemeData\TextColor[#Hot], Alpha))
			Else
				VectorSourceColor(SetAlpha(\ThemeData\TextColor[*Block\State], Alpha))
			EndIf
			
			FillPath()
			Drawn = #True
		Next
	EndWith
	
	ProcedureReturn Drawn
EndProcedure

Procedure TimeLine_Redraw_Child(*GadgetData.TimeLineData, *Child.TimeLine_Block, ParentStart, X, Y, Width, Alpha)
	Protected ChildX, ChildWidth, Height = #TimeLine_Body_SubRowHeight - 6
	
	With *GadgetData
		ChildX = \OriginX + TimeLine_TimeToX(*GadgetData, ParentStart + *Child\Postion)
		ChildWidth = Max(*Child\Duration * \Scale, 1)
		
		If ChildX > X + Width Or ChildX + ChildWidth < X
			ProcedureReturn #False
		ElseIf ChildWidth < #TimeLine_Block_MinWidth
			AddPathBox(ChildX, Y + 3, Max(ChildWidth, 1), Height)
			VectorSourceColor(SetAlpha(*Child\Color, Alpha))
			FillPath()
			ProcedureReturn #True
		EndIf
		
		SaveVectorState()
		AddPathRoundedBox(ChildX, Y + 3, ChildWidth, Height, 3)
		VectorSourceColor(SetAlpha(\ThemeData\LineColor[#Cold], Alpha))
		StrokePath(1.4, #PB_Path_Preserve)
		VectorSourceColor(SetAlpha(\ThemeData\BackColor[*Child\State], Alpha))
		FillPath(#PB_Path_Preserve)
		ClipPath()
		
		AddPathBox(ChildX, Y + 3, ChildWidth, 3)
		VectorSourceColor(SetAlpha(*Child\Color, Alpha))
		FillPath()
		
		If ChildWidth > #TimeLine_Block_TextWidth
			VectorSourceColor(SetAlpha(\ThemeData\TextColor[*Child\State], Alpha))
			VectorFont(TimeLine_Font)
			MovePathCursor(Min(Max(ChildX, \OriginX + #TimeLine_List_Width), ChildX + ChildWidth - #TimeLine_Block_TextWidth) + 6, Y + 7)
			DrawVectorText(*Child\Text)
		EndIf
		
		RestoreVectorState()
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure TimeLine_Redraw_Block(*GadgetData.TimeLineData, *Block.TimeLine_Block, Y, Unfolded)
	Protected X, Width, Height = #TimeLine_Body_BlockHeight, Alpha = 255, TextX, Bands, Band, Kind, Shade, Hatch, Rule
	
	With *GadgetData
		X = \OriginX + TimeLine_TimeToX(*GadgetData, *Block\Postion)
		Width = Max(*Block\Duration * \Scale, 1)
		
		If *Block\Dragged
			Alpha = 80
		EndIf
		
		Hatch = Alpha * #TimeLine_Hatch_Alpha / 255
		Rule = Alpha * #TimeLine_Band_RuleAlpha / 255
		
		Y + #TimeLine_Body_BlockMargin
		
		If Unfolded
			Bands = TimeLine_BlockBands(*Block)
			Height + Bands * #TimeLine_Body_SubRowHeight
		EndIf
		
		If Width < #TimeLine_Block_MinWidth		; no room for chrome, and ClipPath() hates a degenerate rounded box
			AddPathBox(X, Y, Max(Width, 1), Height)
			VectorSourceColor(SetAlpha(*Block\Color, Alpha))
			FillPath()
			ProcedureReturn
		EndIf
		
		BeginVectorLayer()
		SaveVectorState()
		
		AddPathRoundedBox(X, Y, Width, Height, #TimeLine_Block_Radius)
		VectorSourceColor(SetAlpha(\ThemeData\LineColor[#Cold], Alpha))
		StrokePath(1.7, #PB_Path_Preserve)
		VectorSourceColor(SetAlpha(\ThemeData\BackColor[*Block\State], Alpha))
		FillPath(#PB_Path_Preserve)
		ClipPath()
		
		AddPathBox(X, Y, Width, 4)
		VectorSourceColor(SetAlpha(*Block\Color, Alpha))
		FillPath()
		
		If Width > #TimeLine_Block_TextWidth
			; Pinned to the body's edge so a block scrolled off the left still says what it is, but never past its own end.
			TextX = Min(Max(X, \OriginX + #TimeLine_List_Width), X + Width - #TimeLine_Block_TextWidth)
			
			If *Block\Icon
				MovePathCursor(TextX + 6, Y + 10)
				DrawVectorImage(*Block\Icon, Alpha, #TimeLine_Body_IconSize, #TimeLine_Body_IconSize)
				TextX + #TimeLine_Block_TextWidth
			Else
				TextX + 8
			EndIf
			
			VectorSourceColor(SetAlpha(\ThemeData\TextColor[*Block\State], Alpha))
			VectorFont(TimeLine_Font)
			MovePathCursor(TextX, Y + 14)
			DrawVectorText(*Block\Text)
		EndIf
		
		Y + #TimeLine_Body_BlockHeight
		
		For Band = 0 To Bands - 1
			Kind = TimeLine_BandKind(*Block\ParentLine, Band)
			
			Shade = #TimeLine_Band_Alpha
			If Band % 2
				Shade = #TimeLine_Band_AltAlpha
			EndIf
			
			AddPathBox(X, Y, Width, #TimeLine_Body_SubRowHeight)
			VectorSourceColor(SetAlpha(\ThemeData\ShadeColor[#Cold], Shade))
			FillPath()
			
			MovePathCursor(X, Y + 0.5)					; a hairline, so a tall stack of bands still reads as separate rows
			AddPathLine(Width, 0, #PB_Path_Relative)
			VectorSourceColor(SetAlpha(\ThemeData\LineColor[#Cold], Rule))
			StrokePath(1)
			
			If Kind = #TimeLine_Track_Content ;{ Children, or hatching where this block holds none
				If *Block\Container
					ForEach *Block\Children()
						TimeLine_Redraw_Child(*GadgetData, *Block\Children(), *Block\Postion, X, Y, Width, Alpha)
					Next
					
					If \DragParent = *Block
						AddPathBox(X, Y, Width, #TimeLine_Body_SubRowHeight)
						VectorSourceColor(SetAlpha(\ThemeData\TextColor[#Hot], 40))
						FillPath()
					EndIf
				Else
					VectorSourceColor(SetAlpha(\ThemeData\LineColor[#Cold], Hatch))
					TimeLine_DrawHatch(X, Y, Width, #TimeLine_Body_SubRowHeight)
				EndIf
				;}
			ElseIf *Block\Tracks & (1 << Kind) ;{ A track this block animates
				TimeLine_Redraw_Keys(*GadgetData, *Block, Kind, X, Y, Width, Alpha)
				;}
			Else;{ A track it does not
				VectorSourceColor(SetAlpha(\ThemeData\LineColor[#Cold], Hatch))
				TimeLine_DrawHatch(X, Y, Width, #TimeLine_Body_SubRowHeight)
				;}
			EndIf
			
			Y + #TimeLine_Body_SubRowHeight
		Next
		
		RestoreVectorState()
		EndVectorLayer()
	EndWith
EndProcedure

Procedure TimeLine_Redraw_Row(*GadgetData.TimeLineData, X, Y, State, Alt)
	Protected Left, Right
	
	With *GadgetData
		AddPathBox(X, Y, \BodyWidth, \Lines()\Height)
		
		If State > #Cold
			VectorSourceColor(\ThemeData\ShadeColor[State])
			FillPath(#PB_Path_Preserve)
		ElseIf Alt
			VectorSourceColor(SetAlpha(\ThemeData\WindowColor, 150))
			FillPath(#PB_Path_Preserve)
		EndIf
		
		SaveVectorState()
		ClipPath()
		
		Left = \HScrollBar\State
		Right = Left + Ceil(\BodyWidth / \Scale) + 1
		
		ForEach \Lines()\MediaBlocks()
			If \Lines()\MediaBlocks()\Postion > Right
				Break
			ElseIf \Lines()\MediaBlocks()\Postion + \Lines()\MediaBlocks()\Duration >= Left
				TimeLine_Redraw_Block(*GadgetData, \Lines()\MediaBlocks(), Y, Bool(\Lines()\Fold = #TimeLine_Unfolded))
			EndIf
		Next
		
		RestoreVectorState()
	EndWith
EndProcedure

Procedure TimeLine_Redraw_Preview(*GadgetData.TimeLineData)
	; The white outline showing where a dragged or resized selection would land.
	Protected X, Y, Width, Height, Start, Duration, Offset, Index, *Block.TimeLine_Block, *Line.TimeLine_Line
	
	With *GadgetData
		If Not ListSize(\Selection())
			ProcedureReturn
		EndIf
		
		ForEach \Selection()
			*Block = \Selection()
			Start = TimeLine_BlockStart(*Block)
			Duration = *Block\Duration
			
			Select \Action
				Case #TimeLine_Action_BlockResize
					Offset = Start - *Block\Postion			; the parent chain, for a child block
					TimeLine_ResizedSpan(*Block, \ResizeEdge, \DragTime, @Start, @Duration)
					Start + Offset
					
				Case #TimeLine_Action_BlockDrag
					Start = Max(Start + \DragTime, 0)
					
				Default
					Continue
			EndSelect
			
			*Line = *Block\ParentLine
			Index = -1
			
			If \Action = #TimeLine_Action_BlockDrag And \DragParent
				Index = \DropLine						; dropping into a container: the band belongs to the target line
			ElseIf *Line
				ForEach \Lines()
					If @\Lines() = *Line
						Index = Clamp(ListIndex(\Lines()) + \DragLine, 0, ListSize(\Lines()) - 1)
						Break
					EndIf
				Next
			EndIf
			
			If Index < 0 Or Not SelectElement(\Lines(), Index)
				Continue
			EndIf
			
			Y = \OriginY + \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height + #TimeLine_Body_BlockMargin
			Height = #TimeLine_Body_BlockHeight
			
			If \DragParent
				Y + #TimeLine_Body_BlockHeight + 3
				Height = #TimeLine_Body_SubRowHeight - 6
			Else
				Height + TimeLine_BlockBands(*Block) * #TimeLine_Body_SubRowHeight
			EndIf
			
			X = \OriginX + TimeLine_TimeToX(*GadgetData, Start)
			Width = Max(Duration * \Scale, 2)
			
			AddPathRoundedBox(X + 0.5, Y + 0.5, Width, Height, #TimeLine_Block_Radius)
		Next
		
		VectorSourceColor(\ThemeData\Highlight)
		StrokePath(1)
	EndWith
EndProcedure

Procedure TimeLine_Redraw_Player(*GadgetData.TimeLineData, Head)
	; Head draws the pennant sitting in the header, otherwise the thin line down the body.
	Protected X.d
	
	With *GadgetData
		If \PlayerPosition < \HScrollBar\State
			ProcedureReturn
		EndIf
		
		X = \OriginX + TimeLine_TimeToX(*GadgetData, \PlayerPosition) + 0.5
		
		If X > \OriginX + \Width
			ProcedureReturn
		EndIf
		
		If Head
			MovePathCursor(X - #TimeLine_Player_Width * 0.5, \OriginY + #TimeLine_Header_Height - #TimeLine_Player_Height)
			AddPathLine(#TimeLine_Player_Width, 0, #PB_Path_Relative)
			AddPathLine(0, #TimeLine_Player_Height - 5, #PB_Path_Relative)
			AddPathLine(- #TimeLine_Player_Width * 0.5, 5, #PB_Path_Relative)
			AddPathLine(- #TimeLine_Player_Width * 0.5, -5, #PB_Path_Relative)
			ClosePath()
			VectorSourceColor(\ThemeData\Special1[#Cold])
			FillPath()
		Else
			MovePathCursor(X, \OriginY + #TimeLine_Header_Height)
			AddPathLine(0, \BodyHeight, #PB_Path_Relative)
			VectorSourceColor(\ThemeData\Special1[#Cold])
			StrokePath(1)
		EndIf
	EndWith
EndProcedure

Procedure TimeLine_Redraw_Header(*GadgetData.TimeLineData)
	Protected Tick = 1, Mantissa = 1, Decade = 1, Major, Label, Time, X.d, Left, Right
	
	With *GadgetData
		SaveVectorState()
		AddPathBox(\OriginX + #TimeLine_List_Width, \OriginY, \BodyWidth, #TimeLine_Header_Height)
		ClipPath(#PB_Path_Preserve)
		VectorSourceColor(\ThemeData\ShadeColor[#Cold])
		FillPath()
		
		; Walk the 1-2-5 ladder until two ticks read apart; ten decades up is then the labelled one, so labels stay round.
		While Tick * \Scale < #TimeLine_Ruler_MinSpacing
			Select Mantissa
				Case 1
					Mantissa = 2
				Case 2
					Mantissa = 5
				Default
					Mantissa = 1
					Decade * 10
			EndSelect
			Tick = Mantissa * Decade
		Wend
		Major = Decade * 10
		
		; Labels need far more room than a tick, so they climb the decades until two stop touching.
		Label = Major
		While Label * \Scale < #TimeLine_Ruler_LabelSpacing
			Label * 10
		Wend
		
		Left = Max(\HScrollBar\State, 0)
		Right = \HScrollBar\State + Ceil(\BodyWidth / \Scale) + 1
		Time = Left - (Left % Tick)
		
		While Time <= Right
			X = \OriginX + TimeLine_TimeToX(*GadgetData, Time) + 0.5
			MovePathCursor(X, \OriginY + #TimeLine_Header_Height)
			
			If Time % Major
				AddPathLine(0, - #TimeLine_Ruler_MinorTick, #PB_Path_Relative)
			Else
				AddPathLine(0, - #TimeLine_Ruler_MajorTick, #PB_Path_Relative)
			EndIf
			
			Time + Tick
		Wend
		
		VectorSourceColor(SetAlpha(\ThemeData\TextColor[#Cold], 130))
		StrokePath(1)
		
		VectorFont(TimeLine_RulerFont)
		VectorSourceColor(SetAlpha(\ThemeData\TextColor[#Cold], 190))
		Time = Left - (Left % Label)
		
		While Time <= Right
			MovePathCursor(\OriginX + TimeLine_TimeToX(*GadgetData, Time) + 3, \OriginY + #TimeLine_Header_Height - #TimeLine_Ruler_MajorTick - 13)
			DrawVectorText(Str(Time))
			Time + Label
		Wend
		
		TimeLine_Redraw_Player(*GadgetData, #True)
		RestoreVectorState()
		
		MovePathCursor(\OriginX + #TimeLine_List_Width, \OriginY + #TimeLine_Header_Height)
		AddPathLine(\BodyWidth, 0, #PB_Path_Relative)
		MovePathCursor(\OriginX + #TimeLine_List_Width, \OriginY)
		AddPathLine(0, #TimeLine_Header_Height, #PB_Path_Relative)
		VectorSourceColor(\ThemeData\WindowColor)
		StrokePath(2)
	EndWith
EndProcedure

Procedure TimeLine_Redraw_List(*GadgetData.TimeLineData)
	Protected Y
	
	With *GadgetData
		AddPathBox(\OriginX, \OriginY, #TimeLine_List_Width, #TimeLine_Header_Height)
		VectorSourceColor(\ThemeData\ShadeColor[#Cold])
		FillPath()
		
		SaveVectorState()
		AddPathBox(\OriginX, \OriginY + #TimeLine_Header_Height, #TimeLine_List_Width, \BodyHeight)
		ClipPath(#PB_Path_Preserve)
		VectorSourceColor(\ThemeData\ShadeColor[#Cold])
		FillPath()
		
		If \FirstDisplayedLine
			ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
			Y = \OriginY + \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
			
			If \DragState = #Drag_Active And \State < ListIndex(\Lines())
				Y - #TimeLine_List_LineHeight
			EndIf
			
			Repeat
				If ListIndex(\Lines()) = \State
					If \DragState = #Drag_Active
						Continue							; the row in flight lives in the ghost window
					EndIf
					TimeLine_Redraw_ListItem(*GadgetData, \OriginX, Y, #Hot)
				Else
					TimeLine_Redraw_ListItem(*GadgetData, \OriginX, Y, Bool(ListIndex(\Lines()) = \HoverItem) * #Warm)
				EndIf
				
				Y + \Lines()\Height
			Until Y > \OriginY + \Height Or Not NextElement(\Lines())
		EndIf
		
		If \DragState = #Drag_Active
			MovePathCursor(\OriginX, \OriginY + (\ReorderPosition * #TimeLine_List_LineHeight - \VScrollBar\State + #TimeLine_Header_Height))
			AddPathLine(#TimeLine_List_Width, 0, #PB_Path_Relative)
			VectorSourceColor(\ThemeData\TextColor[#Hot])
			StrokePath(3)
		ElseIf \Editing
			\String\Redraw(\String)
		EndIf
		
		RestoreVectorState()
		
		MovePathCursor(\OriginX + #TimeLine_List_Width, \OriginY + #TimeLine_Header_Height)
		AddPathLine(0, \Height - #TimeLine_Header_Height, #PB_Path_Relative)
		VectorSourceColor(\ThemeData\WindowColor)
		StrokePath(2)
	EndWith
EndProcedure

Procedure TimeLine_Redraw_Body(*GadgetData.TimeLineData)
	Protected Y, X, Alt, State
	
	With *GadgetData
		SaveVectorState()
		X = \OriginX + #TimeLine_List_Width
		AddPathBox(X, \OriginY + #TimeLine_Header_Height, \BodyWidth, \BodyHeight)
		ClipPath(#PB_Path_Preserve)
		VectorSourceColor(\ThemeData\ShadeColor[#Cold])
		FillPath()
		
		If \FirstDisplayedLine
			ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
			Y = \OriginY + \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
			Alt = ListIndex(\Lines()) % 2
			
			If \DragState = #Drag_Active And \State < ListIndex(\Lines())
				Y - #TimeLine_List_LineHeight
				Alt = Bool(Not Alt)
			EndIf
			
			Repeat
				If ListIndex(\Lines()) = \State
					If \DragState = #Drag_Active
						Continue
					EndIf
					State = #Hot
				ElseIf ListIndex(\Lines()) = \DropLine And \Action = #TimeLine_Action_BlockDrag
					State = #Warm
				ElseIf ListIndex(\Lines()) = \HoverItem
					State = #Warm
				Else
					State = #Cold
				EndIf
				
				TimeLine_Redraw_Row(*GadgetData, X, Y, State, Alt)
				
				Y + \Lines()\Height
				Alt = Bool(Not Alt)
			Until Y > \OriginY + \Height Or Not NextElement(\Lines())
		EndIf
		
		If \Action = #TimeLine_Action_BlockDrag Or \Action = #TimeLine_Action_BlockResize
			TimeLine_Redraw_Preview(*GadgetData)
		EndIf
		
		TimeLine_Redraw_Player(*GadgetData, #False)
		
		If \VisibleVerticalScrollBar
			\VScrollBar\Redraw(\VScrollBar)
		EndIf
		
		If \VisibleHorizontalScrollBar
			\HScrollBar\Redraw(\HScrollBar)
		EndIf
		
		RestoreVectorState()
	EndWith
EndProcedure

Procedure TimeLine_Redraw(*GadgetData.TimeLineData)
	With *GadgetData
		If Not (\RedrawAll Or \RedrawList Or \RedrawHeader Or \RedrawBody)
			\RedrawAll = #True					; a bare RedrawObject() - SetGadgetColor, Freeze, ... - means all of it
		EndIf
		
		If \Border
			AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
			VectorSourceColor(\ThemeData\LineColor[#Cold])
			StrokePath(2, #PB_Path_Preserve)
		Else
			AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
		EndIf
		
		If \RedrawAll
			\RedrawAll = #False
			\RedrawList = #True
			\RedrawHeader = #True
			\RedrawBody = #True
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			FillPath(#PB_Path_Preserve)
		EndIf
		
		ClipPath()
		
		If \RedrawList
			SaveVectorState()
			TimeLine_Redraw_List(*GadgetData)
			RestoreVectorState()
			\RedrawList = #False
		EndIf
		
		If \RedrawHeader
			SaveVectorState()
			TimeLine_Redraw_Header(*GadgetData)
			RestoreVectorState()
			\RedrawHeader = #False
		EndIf
		
		If \RedrawBody
			SaveVectorState()
			TimeLine_Redraw_Body(*GadgetData)
			RestoreVectorState()
			\RedrawBody = #False
		EndIf
	EndWith
EndProcedure

Procedure TimeLine_Draw(*GadgetData.TimeLineData)
	; Every path that dirties a flag ends here, so none of them repeat the drawing dance.
	With *GadgetData
		If \Freeze Or \Width <= 0 Or \Height <= 0
			ProcedureReturn
		ElseIf Not (\RedrawAll Or \RedrawList Or \RedrawHeader Or \RedrawBody)
			ProcedureReturn
		EndIf
		
		StartVectorDrawing(CanvasVectorOutput(\Gadget))
		TimeLine_Redraw(*GadgetData)
		StopVectorDrawing()
	EndWith
EndProcedure

;- Focus
Procedure TimeLine_VerticalFocus(*GadgetData.TimeLineData)
	Protected Result, *Previous
	
	With *GadgetData
		*Previous = \FirstDisplayedLine
		
		If \VisibleVerticalScrollBar And \State >= 0 And SelectElement(\Lines(), \State)
			If \Lines()\Y < \VScrollBar\State
				TimeLine_SetScroll(\VScrollBar, \Lines()\Y)
				Result = #True
			ElseIf \Lines()\Y + \Lines()\Height > \VScrollBar\State + \BodyHeight
				TimeLine_SetScroll(\VScrollBar, \Lines()\Y + \Lines()\Height - \BodyHeight)
				Result = #True
			EndIf
		EndIf
		
		TimeLine_FirstDisplayed(*GadgetData)
		
		If \FirstDisplayedLine <> *Previous
			Result = #True
		EndIf
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure TimeLine_HorizontalFocus(*GadgetData.TimeLineData, Time)
	; Nudge the view just far enough to bring Time into the body.
	Protected Page = Max(Floor(*GadgetData\BodyWidth / *GadgetData\Scale), 1)
	
	With *GadgetData
		If Time < \HScrollBar\State
			TimeLine_SetScroll(\HScrollBar, Time)
			ProcedureReturn #True
		ElseIf Time > \HScrollBar\State + Page - 1
			TimeLine_SetScroll(\HScrollBar, Time - Page + 1)
			ProcedureReturn #True
		EndIf
	EndWith
	
	ProcedureReturn #False
EndProcedure

Procedure TimeLine_FocusTimer(*GadgetData.TimeLineData, Timer)
	If TimeLine_VerticalFocus(*GadgetData)
		*GadgetData\RedrawBody = #True
		*GadgetData\RedrawList = #True
		TimeLine_Draw(*GadgetData)
	EndIf
	RemoveGadgetTimer(Timer)
EndProcedure

Procedure TimeLine_ReorderFocusTimer(*GadgetData.TimeLineData, Timer)
	With *GadgetData
		ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
		If \ReorderDirection
			If \ReorderPosition < ListSize(\Lines()) - 1
				NextElement(\Lines())
				If ListIndex(\Lines()) = \State
					NextElement(\Lines())
					\ReorderPosition + 1
					TimeLine_SetScroll(\VScrollBar, \VScrollBar\State + #TimeLine_List_LineHeight * 2)
				Else
					TimeLine_SetScroll(\VScrollBar, \VScrollBar\State + #TimeLine_List_LineHeight)
				EndIf
				\FirstDisplayedLine = @\Lines()
				\RedrawBody = #True
				\RedrawList = #True
				\ReorderPosition + 1
			EndIf
		Else
			If ListIndex(\Lines())
				PreviousElement(\Lines())
				If ListIndex(\Lines()) = \State
					PreviousElement(\Lines())
					\ReorderPosition - 1
				EndIf
				\FirstDisplayedLine = @\Lines()
				TimeLine_SetScroll(\VScrollBar, \Lines()\Y)
				\RedrawBody = #True
				\RedrawList = #True
				\ReorderPosition - 1
			EndIf
		EndIf
		
		TimeLine_Draw(*GadgetData)
	EndWith
EndProcedure

;- Inline rename
; Open the inline rename editor over the selected line (F2 / EditGadgetItemText).
Procedure TimeLine_BeginEdit(*GadgetData.TimeLineData)
	Protected Event.Event
	
	With *GadgetData
		If \Editing Or \State < 0 Or Not SelectElement(\Lines(), \State)
			ProcedureReturn #False
		EndIf
		
		\RedrawBody = TimeLine_VerticalFocus(*GadgetData)
		\RedrawList = #True
		\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
		SelectElement(\Lines(), \State)		; VerticalFocus walks the list, re-select
		\String\String = \Lines()\Text\OriginalText
		String_ProcessString(\String)
		
		\String\OriginX = \Lines()\Text\TextX + #TimeLine_List_TextIndent + \Border
		; Same as the VerticalList: TextX is in the origin, so take it off the width.
		\String\Width = \Lines()\Text\Width - \Lines()\Text\TextX
		\String\OriginY = #TimeLine_Header_Height + \Lines()\Y + \Lines()\Text\TextY + \Border - \VScrollBar\State
		
		Event\EventType = #Focus
		\String\EventHandler(\String, Event)
		StringSetSelection_Meta(\String, 0, Len(\String\String))
	EndWith
	
	ProcedureReturn #True
EndProcedure

; Fold the editor away. Keep writes a changed name back and reports #EventType_ItemTextChange.
Procedure TimeLine_EndEdit(*GadgetData.TimeLineData, Keep)
	Protected Event.Event
	
	With *GadgetData
		If Not \Editing
			ProcedureReturn #False
		EndIf
		
		\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
		
		If Keep And \State >= 0 And SelectElement(\Lines(), \State)
			If \Lines()\Text\OriginalText <> \String\String
				\Lines()\Text\OriginalText = \String\String
				PrepareVectorTextBlock(@\Lines()\Text)
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
			EndIf
		EndIf
		
		Event\EventType = #LostFocus
		\String\EventHandler(\String, Event)
		\RedrawList = #True
	EndWith
	
	ProcedureReturn #True
EndProcedure

;- Content mutation
Procedure TimeLine_SortBlock(*Line.TimeLine_Line, *Block.TimeLine_Block)
	; Put a block back in its line's list, ordered by start so drawing can stop at the first one past the right edge.
	With *Line
		ForEach \MediaBlocks()
			If \MediaBlocks() = *Block
				DeleteElement(\MediaBlocks())
				Break
			EndIf
		Next
		
		ForEach \MediaBlocks()
			If \MediaBlocks()\Postion > *Block\Postion
				InsertElement(\MediaBlocks())
				\MediaBlocks() = *Block
				ProcedureReturn
			EndIf
		Next
		
		LastElement(\MediaBlocks())
		AddElement(\MediaBlocks())
		\MediaBlocks() = *Block
	EndWith
EndProcedure

Procedure TimeLine_SortChild(*Parent.TimeLine_Block, *Child.TimeLine_Block)
	With *Parent
		ForEach \Children()
			If \Children() = *Child
				DeleteElement(\Children())
				Break
			EndIf
		Next
		
		ForEach \Children()
			If \Children()\Postion > *Child\Postion
				InsertElement(\Children())
				\Children() = *Child
				ProcedureReturn
			EndIf
		Next
		
		LastElement(\Children())
		AddElement(\Children())
		\Children() = *Child
	EndWith
EndProcedure

Procedure TimeLine_DetachBlock(*GadgetData.TimeLineData, *Block.TimeLine_Block)
	; Unhook a block from wherever it currently hangs, without freeing it.
	With *GadgetData
		If *Block\Parent
			ForEach *Block\Parent\Children()
				If *Block\Parent\Children() = *Block
					DeleteElement(*Block\Parent\Children())
					Break
				EndIf
			Next
			*Block\Parent = #Null
		ElseIf *Block\ParentLine
			ForEach *Block\ParentLine\MediaBlocks()
				If *Block\ParentLine\MediaBlocks() = *Block
					DeleteElement(*Block\ParentLine\MediaBlocks())
					Break
				EndIf
			Next
			
		EndIf
		
		*Block\ParentLine = #Null
	EndWith
EndProcedure

Procedure TimeLine_FreeBlock(*GadgetData.TimeLineData, *Block.TimeLine_Block)
	With *GadgetData
		While FirstElement(*Block\Children())
			TimeLine_FreeBlock(*GadgetData, *Block\Children())
		Wend
		
		TimeLine_Deselect(*GadgetData, *Block)
		TimeLine_DropBlockKeys(*GadgetData, *Block)
		TimeLine_DetachBlock(*GadgetData, *Block)
		
		If \HoverBlock = *Block
			\HoverBlock = #Null
		EndIf
		If \DragParent = *Block
			\DragParent = #Null
		EndIf
		
		ChangeCurrentElement(\Blocks(), *Block)
		DeleteElement(\Blocks())
	EndWith
EndProcedure

Procedure TimeLine_ApplyDrag(*GadgetData.TimeLineData)
	; Commit whatever the preview outline was showing. Returns #True when anything moved.
	Protected Changed, Start, Duration, Shift, Span, Index, *Block.TimeLine_Block, *Line.TimeLine_Line, *Target.TimeLine_Line
	Protected NewList *Moving.TimeLine_Block()
	
	With *GadgetData
		ForEach \Selection()						; the selection list is walked again below
			AddElement(*Moving())
			*Moving() = \Selection()
		Next
		
		ForEach *Moving()
			*Block = *Moving()
			*Block\Dragged = #False
			
			If \Action = #TimeLine_Action_BlockResize
				TimeLine_ResizedSpan(*Block, \ResizeEdge, \DragTime, @Start, @Duration)
				Shift = *Block\Postion - Start		; how far the head moved; zero for a right-edge drag
				Span = *Block\Duration				; …and what it covered before, for the scaling case
				
				If Start <> *Block\Postion Or Duration <> *Block\Duration
					*Block\Postion = Start
					*Block\Duration = Duration
					Changed = #True
				EndIf
				
				If \ScaleContents
					TimeLine_ScaleContents(*Block, Span, Duration)
				ElseIf Shift
					ForEach *Block\Keys()
						*Block\Keys()\Time + Shift
					Next
					
					ForEach *Block\Children()
						*Block\Children()\Postion + Shift
					Next
				EndIf
				
				If *Block\Parent
					TimeLine_SortChild(*Block\Parent, *Block)
				ElseIf *Block\ParentLine
					TimeLine_SortBlock(*Block\ParentLine, *Block)
					TimeLine_ExtendDuration(*GadgetData, Start + Duration)
				EndIf
				
				Continue
			EndIf
			
			Start = Max(TimeLine_BlockStart(*Block) + \DragTime, 0)
			*Line = *Block\ParentLine
			*Target = #Null
			
			If \DragParent And ListSize(*Moving()) = 1 And \DragParent <> *Block
				TimeLine_DetachBlock(*GadgetData, *Block)
				*Block\Parent = \DragParent
				*Block\Postion = Max(Start - \DragParent\Postion, 0)
				TimeLine_SortChild(\DragParent, *Block)
				Changed = #True
				Continue
			EndIf
			
			Index = -1
			If *Line
				ForEach \Lines()
					If @\Lines() = *Line
						Index = Clamp(ListIndex(\Lines()) + \DragLine, 0, ListSize(\Lines()) - 1)
						Break
					EndIf
				Next
			ElseIf \DropLine > -1
				Index = \DropLine
			EndIf
			
			If Index > -1 And SelectElement(\Lines(), Index)
				*Target = @\Lines()
			EndIf
			
			If Not *Target
				Continue
			EndIf
			
			If *Target <> *Line Or Start <> TimeLine_BlockStart(*Block) Or *Block\Parent
				TimeLine_DetachBlock(*GadgetData, *Block)
				*Block\ParentLine = *Target
				*Block\Postion = Start
				
				TimeLine_SortBlock(*Target, *Block)
				TimeLine_ExtendDuration(*GadgetData, Start + *Block\Duration)
				Changed = #True
			EndIf
		Next
		
		TimeLine_RefreshBands(*GadgetData)
		
		\Action = #TimeLine_Action_None
		\DragTime = 0
		\DragLine = 0
		\ScaleContents = #False
		\DragParent = #Null
		\DropLine = -1
	EndWith
	
	ProcedureReturn Changed
EndProcedure

Procedure TimeLine_CancelDrag(*GadgetData.TimeLineData)
	With *GadgetData
		ForEach \Selection()
			\Selection()\Dragged = #False
		Next
		
		\Action = #TimeLine_Action_None
		\DragTime = 0
		\DragLine = 0
		\ScaleContents = #False
		\DragParent = #Null
		\DropLine = -1
		\RedrawBody = #True
	EndWith
EndProcedure

;- Event handling
Procedure TimeLine_Handle_BodyMove(*GadgetData.TimeLineData, X, Y)
	Protected Time, Line, Delta, Band, Scale, *Block.TimeLine_Block, *Key.TimeLine_Key, Cursor = #PB_Cursor_Default
	
	With *GadgetData
		Time = TimeLine_XToTime(*GadgetData, X)
		
		Select \Action
			Case #TimeLine_Action_PlayerDrag ;{
				Time = Clamp(Time, 0, \Duration)
				If \PlayerPosition <> Time
					\PlayerPosition = Time
					\RedrawHeader = #True
					\RedrawBody = #True
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLinePlayerMove, \PlayerPosition)
				EndIf
				;}
			Case #TimeLine_Action_BlockInitDrag ;{
				If Abs(\DragOriginX - X) + Abs(\DragOriginY - Y) > #Drag_Distance
					If \ResizeEdge
						\Action = #TimeLine_Action_BlockResize
					Else
						\Action = #TimeLine_Action_BlockDrag
					EndIf
					
					ForEach \Selection()
						\Selection()\Dragged = #True
					Next
					
					\DragTime = 0
					\DragLine = 0
					\RedrawBody = #True
				EndIf
				;}
			Case #TimeLine_Action_KeyInitDrag ;{
				If Abs(\DragOriginX - X) + Abs(\DragOriginY - Y) > #Drag_Distance
					\Action = #TimeLine_Action_KeyDrag
					\DragTime = 0
					\RedrawBody = #True
				EndIf
				;}
			Case #TimeLine_Action_KeyDrag ;{
				Cursor = #PB_Cursor_LeftRight
				Delta = Time - \DragGrabOffset
				
				If \DragTime <> Delta
					\DragTime = Delta
					\RedrawBody = #True
				EndIf
				;}
			Case #TimeLine_Action_BlockResize ;{
				Cursor = #PB_Cursor_LeftRight
				Delta = Time - \DragGrabOffset
				Scale = Bool(\OriginalVT\GetGadgetAttribute(\this, #PB_Canvas_Modifiers) & #PB_Canvas_Shift)
				
				If \DragTime <> Delta Or \ScaleContents <> Scale
					\DragTime = Delta
					\ScaleContents = Scale		; read every move, so the outline and the commit cannot disagree
					\RedrawBody = #True
				EndIf
				;}
			Case #TimeLine_Action_BlockDrag ;{
				Delta = Time - \DragGrabOffset
				
				If \DragTime <> Delta
					\DragTime = Delta
					\RedrawBody = #True
				EndIf
				
				Line = TimeLine_LineAt(*GadgetData, Y)
				If \DropLine <> Line
					\DropLine = Line
					\RedrawBody = #True
				EndIf
				
				Delta = 0
				*Block = #Null
				
				If ListSize(\Selection()) = 1 And Line > -1
					; Only offered over a container's sub-band, and never into the block being dragged.
					*Block = TimeLine_BlockAt(*GadgetData, X, Y)
					If *Block And *Block\Parent
						*Block = *Block\Parent
					EndIf
					
					If Not (*Block And *Block\Container) Or *Block = \Selection()
						*Block = #Null
					ElseIf SelectElement(\Lines(), Line)
						Band = TimeLine_BandAt(@\Lines(), \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height, Y)
						
						If TimeLine_BandKind(@\Lines(), Band) <> #TimeLine_Track_Content
							*Block = #Null
						EndIf
					EndIf
				EndIf
				
				If Not *Block And ListSize(\Selection()) = 1 And \Selection()\ParentLine And Line > -1
					ForEach \Lines()
						If @\Lines() = \Selection()\ParentLine
							Delta = Line - ListIndex(\Lines())
							Break
						EndIf
					Next
				EndIf
				
				If \DragParent <> *Block Or \DragLine <> Delta
					\DragParent = *Block
					\DragLine = Delta
					\RedrawBody = #True
				EndIf
				;}
			Default ;{
				*Key = TimeLine_KeyAt(*GadgetData, X, Y)
				
				If \HoverKey <> *Key
					\HoverKey = *Key
					\RedrawBody = #True
				EndIf
				
				*Block = TimeLine_BlockAt(*GadgetData, X, Y)
				
				If \HoverBlock <> *Block
					If \HoverBlock And Not \HoverBlock\Selected
						\HoverBlock\State = #Cold
					EndIf
					
					\HoverBlock = *Block
					
					If *Block And Not *Block\Selected
						*Block\State = #Warm
					EndIf
					
					\RedrawBody = #True
				EndIf
				
				If *Key							; a key sits inside its block, and takes the pointer from it
					\ResizeEdge = #TimeLine_Resize_None
					Cursor = #PB_Cursor_LeftRight
				Else
					\ResizeEdge = TimeLine_ResizeEdgeAt(*GadgetData, *Block, X)
					If \ResizeEdge
						Cursor = #PB_Cursor_LeftRight
					EndIf
				EndIf
				;}
		EndSelect
	EndWith
	
	ProcedureReturn Cursor
EndProcedure

Procedure TimeLine_EventHandler(*GadgetData.TimeLineData, *Event.Event)
	Protected HoverItem = -1, HoverFold, VScrollBar, HScrollBar, FirstDisplayedItem, LastDisplayedItem, Y, *Data, Zoom, Changed
	Protected Cursor = *GadgetData\EditCursor, Time, *Block.TimeLine_Block, *Key.TimeLine_Key
	
	With *GadgetData
		Select *Event\EventType
			Case #MouseLeave ;{
				If \HoverItem > -1
					\HoverItem = -1
					\HoverFold = #False
					\RedrawBody = #True
					\RedrawList = #True
				EndIf
				
				If \HoverBlock
					If Not \HoverBlock\Selected
						\HoverBlock\State = #Cold
					EndIf
					\HoverBlock = #Null
					\RedrawBody = #True
				EndIf
				
				If \HoverKey
					\HoverKey = #Null
					\RedrawBody = #True
				EndIf
				
				If \VScrollBar\MouseState
					\VScrollBar\MouseState = #Cold
					\RedrawBody = #True
				EndIf
				
				If \HScrollBar\MouseState
					\HScrollBar\MouseState = #Cold
					\RedrawBody = #True
				EndIf
				;}
			Case #MouseMove ;{
				If \String\Selecting = #True ;{
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					\RedrawList = \String\EventHandler(\String, *Event)
					;}
				ElseIf \DragState = #Drag_None ;{
					Cursor = #PB_Cursor_Default
					
					If \Action > #TimeLine_Action_None ;{ A body action outruns every hover test
						Cursor = TimeLine_Handle_BodyMove(*GadgetData, *Event\MouseX, *Event\MouseY)
						;}
					ElseIf *Event\MouseX > #TimeLine_List_Width ;{ Header, body and their bars
						If \VisibleVerticalScrollBar And (*Event\MouseX > \VScrollBar\OriginX Or \VScrollBar\Drag = #True) And *Event\MouseY > #TimeLine_Header_Height
							\RedrawBody = ScrollBar_EventHandler(\VScrollBar, *Event)
							VScrollBar = #True
							If \RedrawBody And \VScrollBar\Drag
								\RedrawList = #True
								TimeLine_FirstDisplayed(*GadgetData)
							EndIf
						ElseIf \VisibleHorizontalScrollBar And (*Event\MouseY > \HScrollBar\OriginY Or \HScrollBar\Drag = #True)
							\RedrawBody = ScrollBar_EventHandler(\HScrollBar, *Event)
							HScrollBar = #True
							\RedrawHeader = \RedrawBody
						ElseIf *Event\MouseY > #TimeLine_Header_Height
							HoverItem = TimeLine_LineAt(*GadgetData, *Event\MouseY)
							Cursor = TimeLine_Handle_BodyMove(*GadgetData, *Event\MouseX, *Event\MouseY)
						Else
							If Abs(*Event\MouseX - TimeLine_TimeToX(*GadgetData, \PlayerPosition)) <= #TimeLine_Player_Grab
								Cursor = #PB_Cursor_LeftRight
							EndIf
						EndIf
						;}
					ElseIf *Event\MouseY > #TimeLine_Header_Height ;{ List
						HoverItem = TimeLine_LineAt(*GadgetData, *Event\MouseY)
						
						If HoverItem > -1 And \Lines()\Fold
							Y = \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
							If *Event\MouseX >= #TimeLine_List_TextMargin And *Event\MouseX < #TimeLine_List_TextIndent And *Event\MouseY < Y + #TimeLine_List_LineHeight
								HoverFold = #True
							EndIf
						EndIf
					EndIf ;}
					
					If \VScrollBar\MouseState And VScrollBar = #False And \VScrollBar\Drag = #False
						\VScrollBar\MouseState = #Cold
						\RedrawBody = #True
					EndIf
					
					If \HScrollBar\MouseState And HScrollBar = #False And \HScrollBar\Drag = #False
						\HScrollBar\MouseState = #Cold
						\RedrawBody = #True
					EndIf
					
					If \HoverItem <> HoverItem Or \HoverFold <> HoverFold
						\HoverItem = HoverItem
						\HoverFold = HoverFold
						\RedrawBody = #True
						\RedrawList = #True
					EndIf
					
					If \Editing And *Event\MouseX <= #TimeLine_List_Width
						Y = *Event\MouseY - \VScrollBar\State + #TimeLine_Header_Height
						If *Event\MouseX >= \String\OriginX And Y >= \String\OriginY And *Event\MouseX <= \String\OriginX + \String\Width And Y <= \String\OriginY + \String\Height
							Cursor = #PB_Cursor_IBeam
						EndIf
					EndIf
					;}
				ElseIf \DragState = #Drag_Init ;{
					If Abs(\DragOriginX - *Event\MouseX) > #Drag_Distance Or Abs(\DragOriginY - *Event\MouseY) > #Drag_Distance
						SelectElement(\Lines(), \State)
						
						\DragState = #Drag_Active
						\DragOriginX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginX
						\DragOriginY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginY + \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
						
						ResizeWindow(\ReorderWindow, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, \Width, #PB_Ignore)
						
						StartVectorDrawing(CanvasVectorOutput(\ReorderCanvas))
						AddPathBox(#TimeLine_List_Width - 1, 0, 3, #TimeLine_List_LineHeight)
						VectorSourceColor(\ThemeData\WindowColor)
						FillPath()
						SelectElement(\Lines(), \State)
						TimeLine_Redraw_ListItem(*GadgetData, 0, 0, #Hot)
						SelectElement(\Lines(), \State)
						TimeLine_Redraw_Row(*GadgetData, #TimeLine_List_Width, 0, #Hot, 0)
						StopVectorDrawing()
						HideWindow(\ReorderWindow, #False)
						SetActiveGadget(\ReorderCanvas)
						
						ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
						FirstDisplayedItem = ListIndex(\Lines())
						LastDisplayedItem = FirstDisplayedItem + Ceil(\BodyHeight / #TimeLine_List_LineHeight)
						\ReorderPosition = Max(Min(Round((*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height) / #TimeLine_List_LineHeight, #PB_Round_Nearest), LastDisplayedItem), FirstDisplayedItem)
						\RedrawBody = #True
						\RedrawList = #True
						
						If \InternalHeight - #TimeLine_List_LineHeight > \BodyHeight
							ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight - #TimeLine_List_LineHeight)
						Else
							\VisibleVerticalScrollBar = #False
							ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, Max(\InternalHeight - #TimeLine_List_LineHeight, 1))
						EndIf
					EndIf
					;}
				Else;{
					ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
					FirstDisplayedItem = ListIndex(\Lines())
					LastDisplayedItem = FirstDisplayedItem + Ceil(\BodyHeight / #TimeLine_List_LineHeight)
					LastDisplayedItem + Bool(LastDisplayedItem >= \State)
					
					If \VisibleVerticalScrollBar
						If *Event\MouseY < #TimeLine_Header_Height
							If Not \ReorderFocusTimer
								\ReorderDirection = 0
								\ReorderFocusTimer = AddGadgetTimer(*GadgetData, #TimeLine_Focus_Timer, @TimeLine_ReorderFocusTimer())
								
								If \VScrollBar\State > \Lines()\Y
									TimeLine_SetScroll(\VScrollBar, \Lines()\Y)
								EndIf
							EndIf
						ElseIf *Event\MouseY > \Height
							If Not \ReorderFocusTimer
								\ReorderDirection = 1
								\ReorderFocusTimer = AddGadgetTimer(*GadgetData, #TimeLine_Focus_Timer, @TimeLine_ReorderFocusTimer())
								
								If \VScrollBar\State + \BodyHeight < LastDisplayedItem * #TimeLine_List_LineHeight
									TimeLine_SetScroll(\VScrollBar, LastDisplayedItem * #TimeLine_List_LineHeight - \BodyHeight)
								EndIf
							EndIf
						ElseIf \ReorderFocusTimer
							RemoveGadgetTimer(\ReorderFocusTimer)
							\ReorderFocusTimer = 0
						EndIf
						\ReorderPosition = Max(Min(Round((*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height) / #TimeLine_List_LineHeight, #PB_Round_Nearest), LastDisplayedItem), FirstDisplayedItem)
					Else
						\ReorderPosition = Max(Min(Round((*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height) / #TimeLine_List_LineHeight, #PB_Round_Nearest), ListSize(\Lines()) - 1), 0)
					EndIf
					
					\RedrawBody = #True
					\RedrawList = #True
					SetWindowPos_(WindowID(\ReorderWindow), 0, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, 0, 0, #SWP_NOSIZE | #SWP_NOZORDER | #SWP_NOREDRAW)
					;}
				EndIf
				;}
			Case #KeyDown ;{
				Select *Event\Param
					Case #PB_Shortcut_F2 ;{
						TimeLine_BeginEdit(*GadgetData)
						;}
					Case #PB_Shortcut_Escape ;{
						If TimeLine_EndEdit(*GadgetData, #False)	; keep the old name
						ElseIf \Action > #TimeLine_Action_None
							TimeLine_CancelDrag(*GadgetData)
						ElseIf \DragState = #Drag_Active
							\ReorderPosition = \State
							*Event\EventType = #LeftButtonUp
							TimeLine_EventHandler(*GadgetData, *Event)
						EndIf
						;}
					Case #PB_Shortcut_Return ;{
						TimeLine_EndEdit(*GadgetData, #True)
						;}
					Case #PB_Shortcut_Delete ;{
						If \Editing
						ElseIf ListSize(\KeySelection()) ;{ whichever of the two selections is live
							While FirstElement(\KeySelection())
								RemoveMediaBlockKey(\Gadget, \KeySelection())
							Wend
							
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineKeyChange)
							;}
						ElseIf ListSize(\Selection())
							While FirstElement(\Selection())
								TimeLine_FreeBlock(*GadgetData, \Selection())
							Wend
							
							TimeLine_RefreshBands(*GadgetData)
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineBlockChange)
						EndIf
						;}
					Default
						If \Editing
							\RedrawList = \String\EventHandler(\String, *Event)
						EndIf
				EndSelect
				;}
			Case #LeftButtonDown ;{
				If \VScrollBar\MouseState ;{
					\RedrawBody + ScrollBar_EventHandler(\VScrollBar, *Event)
					;}
				ElseIf \HScrollBar\MouseState ;{
					\RedrawBody + ScrollBar_EventHandler(\HScrollBar, *Event)
					\RedrawHeader = #True
					;}
				ElseIf *Event\MouseX > #TimeLine_List_Width ;{ Header or body
					If *Event\MouseY < #TimeLine_Header_Height
						Time = Clamp(TimeLine_XToTime(*GadgetData, *Event\MouseX), 0, \Duration)
						\Action = #TimeLine_Action_PlayerDrag
						
						If \PlayerPosition <> Time
							\PlayerPosition = Time
							\RedrawHeader = #True
							\RedrawBody = #True
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLinePlayerMove, \PlayerPosition)
						EndIf
					Else
						TimeLine_EndEdit(*GadgetData, #True)
						*Key = TimeLine_KeyAt(*GadgetData, *Event\MouseX, *Event\MouseY)
						*Block = TimeLine_BlockAt(*GadgetData, *Event\MouseX, *Event\MouseY)
						
						If *Key ;{ A key takes the click before the block it sits in
							TimeLine_ClearSelection(*GadgetData)
							
							If \OriginalVT\GetGadgetAttribute(\this, #PB_Canvas_Modifiers) & #PB_Canvas_Control
								If *Key\Selected
									Changed = TimeLine_DeselectKey(*GadgetData, *Key)
								Else
									Changed = TimeLine_SelectKey(*GadgetData, *Key, #True)
								EndIf
							ElseIf Not *Key\Selected
								Changed = TimeLine_SelectKey(*GadgetData, *Key, #False)
							EndIf
							
							If Changed
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineKeySelect)
							EndIf
							
							\Action = #TimeLine_Action_KeyInitDrag
							\DragOriginX = *Event\MouseX
							\DragOriginY = *Event\MouseY
							\DragGrabOffset = TimeLine_XToTime(*GadgetData, *Event\MouseX)
							\RedrawBody = #True
							;}
						ElseIf *Block ;{
							TimeLine_ClearKeySelection(*GadgetData)
							
							If \OriginalVT\GetGadgetAttribute(\this, #PB_Canvas_Modifiers) & #PB_Canvas_Control
								If *Block\Selected
									Changed = TimeLine_Deselect(*GadgetData, *Block)
								Else
									Changed = TimeLine_Select(*GadgetData, *Block, #True)
								EndIf
							ElseIf Not *Block\Selected
								Changed = TimeLine_Select(*GadgetData, *Block, #False)
							EndIf
							
							If Changed
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineBlockSelect)
							EndIf
							
							\Action = #TimeLine_Action_BlockInitDrag
							\DragOriginX = *Event\MouseX
							\DragOriginY = *Event\MouseY
							\DragGrabOffset = TimeLine_XToTime(*GadgetData, *Event\MouseX)
							\DropLine = TimeLine_LineAt(*GadgetData, *Event\MouseY)
							\RedrawBody = #True
							;}
						ElseIf ListSize(\Selection()) Or ListSize(\KeySelection()) ;{
							TimeLine_ClearSelection(*GadgetData)
							TimeLine_ClearKeySelection(*GadgetData)
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineBlockSelect)
							\RedrawBody = #True
							;}
						EndIf
					EndIf
					;}
				ElseIf \HoverFold And \HoverItem > -1 ;{ Fold chevron
					TimeLine_EndEdit(*GadgetData, #True)
					SelectElement(\Lines(), \HoverItem)
					
					If \Lines()\Fold = #TimeLine_Folded
						\Lines()\Fold = #TimeLine_Unfolded
					ElseIf \Lines()\Fold = #TimeLine_Unfolded
						\Lines()\Fold = #TimeLine_Folded
					EndIf
					
					TimeLine_LayoutLines(*GadgetData)
					TimeLine_FirstDisplayed(*GadgetData)
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineFold, \HoverItem)
					\RedrawList = #True
					\RedrawBody = #True
					;}
				ElseIf \HoverItem <> \State ;{
					TimeLine_EndEdit(*GadgetData, #True)
					If \HoverItem > -1
						\State = \HoverItem
						\RedrawBody = #True
						\RedrawList = #True
						\DragState = #Drag_Init
						\DragOriginX = *Event\MouseX
						\DragOriginY = *Event\MouseY
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
					EndIf
					;}
				Else;{
					If \EditCursor = #PB_Cursor_IBeam
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						\RedrawList = \String\EventHandler(\String, *Event)
					Else
						TimeLine_EndEdit(*GadgetData, #True)
						If \HoverItem > -1
							\DragState = #Drag_Init
							\DragOriginX = *Event\MouseX
							\DragOriginY = *Event\MouseY
						EndIf
					EndIf
					;}
				EndIf
				;}
			Case #LeftButtonUp ;{
				If \Action > #TimeLine_Action_None ;{
					Select \Action
						Case #TimeLine_Action_BlockDrag, #TimeLine_Action_BlockResize
							If TimeLine_ApplyDrag(*GadgetData)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineBlockChange)
							EndIf
							TimeLine_FirstDisplayed(*GadgetData)
							\RedrawList = #True
							
						Case #TimeLine_Action_KeyDrag
							If TimeLine_ApplyKeyDrag(*GadgetData)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineKeyChange)
							EndIf
							
						Default
							\Action = #TimeLine_Action_None
					EndSelect
					
					\Action = #TimeLine_Action_None
					\DropLine = -1
					\RedrawBody = #True
					;}
				ElseIf \VScrollBar\MouseState ;{
					\RedrawBody + ScrollBar_EventHandler(\VScrollBar, *Event)
					;}
				ElseIf \HScrollBar\MouseState ;{
					\RedrawBody + ScrollBar_EventHandler(\HScrollBar, *Event)
					;}
				ElseIf \DragState = #Drag_Init ;{
					\DragState = #Drag_None
					AddGadgetTimer(*GadgetData, 200, @TimeLine_FocusTimer())
					;}
				ElseIf \DragState = #Drag_Active ;{
					If \ReorderPosition = 0
						SelectElement(\Lines(), \State)
						MoveElement(\Lines(), #PB_List_First)
					ElseIf \ReorderPosition >= ListSize(\Lines())
						SelectElement(\Lines(), \State)
						MoveElement(\Lines(), #PB_List_Last)
					Else
						*Data = SelectElement(\Lines(), \ReorderPosition - Bool(\ReorderPosition < \State))
						SelectElement(\Lines(), \State)
						MoveElement(\Lines(), #PB_List_After, *Data)
					EndIf
					
					TimeLine_LayoutLines(*GadgetData)
					
					If \ReorderFocusTimer
						RemoveGadgetTimer(\ReorderFocusTimer)
						\ReorderFocusTimer = 0
					EndIf
					
					HideWindow(\ReorderWindow, #True)
					
					\DragState = #Drag_None
					\RedrawBody = #True
					\RedrawList = #True
					\State = Clamp(\ReorderPosition, 0, ListSize(\Lines()) - 1)
					\ReorderPosition = -1
					
					TimeLine_VerticalFocus(*GadgetData)
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ForcefulChange)
					;}
				ElseIf \String\Selecting ;{
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					\RedrawList = \String\EventHandler(\String, *Event)
					;}
				EndIf
				;}
			Case #LeftDoubleClick ;{
				If *Event\MouseX > #TimeLine_List_Width And *Event\MouseY > #TimeLine_Header_Height
					*Block = TimeLine_BlockAt(*GadgetData, *Event\MouseX, *Event\MouseY)
					If *Block
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineBlockEdit, *Block)
					EndIf
				EndIf
				;}
			Case #RightButtonDown ;{
				If \Action > #TimeLine_Action_None
					TimeLine_CancelDrag(*GadgetData)
				ElseIf *Event\MouseX > #TimeLine_List_Width And *Event\MouseY > #TimeLine_Header_Height
					; Over the body the click carries the block, 0 on bare canvas; over the list, the line index.
					*Block = TimeLine_BlockAt(*GadgetData, *Event\MouseX, *Event\MouseY)
					If *Block And Not *Block\Selected
						TimeLine_Select(*GadgetData, *Block, #False)
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_TimeLineBlockSelect)
						\RedrawBody = #True
					EndIf
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemRightClick, *Block)
				ElseIf \HoverItem > -1
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemRightClick, \HoverItem)
				EndIf
				;}
			Case #MouseWheel	  ;{
				TimeLine_EndEdit(*GadgetData, #True)
				
				If \OriginalVT\GetGadgetAttribute(\this, #PB_Canvas_Modifiers) & #PB_Canvas_Control ;{ Zoom about the pointer
					Zoom = Clamp(\Zoom + Bool(*Event\Param > 0) - Bool(*Event\Param < 0), 0, #__TimeLine_Zoom_Count - 1)
					
					If Zoom <> \Zoom
						Time = TimeLine_XToTime(*GadgetData, Max(*Event\MouseX, #TimeLine_List_Width))
						\Zoom = Zoom
						\Scale = TimeLine_ZoomLevel(\Zoom)
						TimeLine_UpdateHScrollBar(*GadgetData)
						TimeLine_SetScroll(\HScrollBar, Time - Floor((*Event\MouseX - #TimeLine_List_Width) / \Scale))
						\RedrawHeader = #True
						\RedrawBody = #True
					EndIf
					;}
				ElseIf *Event\MouseX <= #TimeLine_List_Width Or Not (\OriginalVT\GetGadgetAttribute(\this, #PB_Canvas_Modifiers) & #PB_Canvas_Shift) ;{ Vertical
					If \VisibleVerticalScrollBar
						TimeLine_SetScroll(\VScrollBar, \VScrollBar\State - *Event\Param * #TimeLine_List_LineHeight * 0.5)
						TimeLine_FirstDisplayed(*GadgetData)
						\RedrawList = #True
						\RedrawBody = #True
						*Event\EventType = #MouseMove
						TimeLine_EventHandler(*GadgetData, *Event)
					EndIf
					;}
				Else;{ Shift: sideways
					If \VisibleHorizontalScrollBar
						TimeLine_SetScroll(\HScrollBar, \HScrollBar\State - *Event\Param * Max(Floor(\BodyWidth / \Scale / 8), 1))
						\RedrawHeader = #True
						\RedrawBody = #True
					EndIf
					;}
				EndIf
				;}
			Case #LostFocus ;{
				TimeLine_EndEdit(*GadgetData, #True)
				If \Action > #TimeLine_Action_None
					TimeLine_CancelDrag(*GadgetData)
				EndIf
				;}
			Default ;{
				If \Editing
					*Event\MouseX - \String\OriginX
					*Event\MouseY - \String\OriginY
					\RedrawList = \String\EventHandler(\String, *Event)
				EndIf
				;}
		EndSelect
		
		If Cursor <> \EditCursor
			\EditCursor = Cursor
			\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, \EditCursor)
		EndIf
		
		TimeLine_Draw(*GadgetData)
	EndWith
EndProcedure

Procedure TimeLine_DragWindowHandler()
	Protected Event.Event, *GadgetData.TimeLineData
	
	Select EventType()
		Case #PB_EventType_KeyDown
			If GetGadgetAttribute(EventGadget(), #PB_Canvas_Key) = #PB_Shortcut_Escape
				Event\EventType = #KeyDown
				Event\Param = #PB_Shortcut_Escape
				TimeLine_EventHandler(GetProp_(GadgetID(EventGadget()), "UITK_TimeLine"), Event)
			EndIf
		Case #PB_EventType_MouseWheel
			*GadgetData.TimeLineData = GetProp_(GadgetID(EventGadget()), "UITK_TimeLine")
			
			Event\EventType = #MouseWheel
			Event\MouseX =  WindowX(*GadgetData\ReorderWindow) - *GadgetData\DragOriginX
			Event\MouseY =  WindowY(*GadgetData\ReorderWindow) - *GadgetData\DragOriginY
			Event\Param = GetGadgetAttribute(*GadgetData\ReorderCanvas, #PB_Canvas_WheelDelta)
			
			TimeLine_EventHandler(*GadgetData, Event)
	EndSelect
EndProcedure

;- Lines
Procedure TimeLine_AddItem(*This.PB_Gadget, Position.l, *Text, ImageID, Flags.l)
	Protected *GadgetData.TimeLineData = *this\vt, *NewItem.TimeLine_Line, Result
	
	With *GadgetData
		TimeLine_EndEdit(*GadgetData, #True)
		
		If Position > -1 And Position < ListSize(\Lines())
			SelectElement(\Lines(), Position)
			*NewItem = InsertElement(\Lines())
		Else
			LastElement(\Lines())
			*NewItem = AddElement(\Lines())
		EndIf
		
		Result = ListIndex(\Lines())
		
		*NewItem\Text\OriginalText = PeekS(*Text)
		*NewItem\Text\Image = ImageID
		*NewItem\Text\LineLimit = 1
		*NewItem\Text\FontID = TimeLine_ListFont
		
		*NewItem\Text\Width = #TimeLine_List_Width - #TimeLine_List_TextIndent - #TimeLine_List_TextMargin
		*NewItem\Text\Height = #TimeLine_List_LineHeight
		*NewItem\Text\VAlign = #VAlignCenter
		
		*NewItem\Fold = #TimeLine_NoFold
		
		PrepareVectorTextBlock(*NewItem\Text)
		
		TimeLine_LayoutLines(*GadgetData)
		TimeLine_FirstDisplayed(*GadgetData)
		
		\RedrawList = #True
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure TimeLine_RemoveItem(*This.PB_Gadget, Position.l)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		If Position < 0 Or Not SelectElement(\Lines(), Position)
			ProcedureReturn #False
		EndIf
		
		TimeLine_EndEdit(*GadgetData, #True)
		
		While FirstElement(\Lines()\MediaBlocks())	; the blocks belong to the line, so they go with it
			TimeLine_FreeBlock(*GadgetData, \Lines()\MediaBlocks())
			SelectElement(\Lines(), Position)
		Wend
		
		SelectElement(\Lines(), Position)
		DeleteElement(\Lines())
		
		If ListSize(\Lines()) = 0
			\State = -1
		ElseIf \State > Position Or (\State = Position And ListSize(\Lines()) = Position)
			\State - 1
		EndIf
		
		\HoverItem = -1
		TimeLine_LayoutLines(*GadgetData)
		TimeLine_VerticalFocus(*GadgetData)
		
		\RedrawList = #True
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure TimeLine_CountItem(*this.PB_Gadget)
	Protected *GadgetData.TimeLineData = *this\vt
	ProcedureReturn ListSize(*GadgetData\Lines())
EndProcedure

Procedure.s TimeLine_GetItemText(*this.PB_Gadget, Position.l)
	Protected *GadgetData.TimeLineData = *this\vt
	
	If Position >= 0 And SelectElement(*GadgetData\Lines(), Position)
		ProcedureReturn *GadgetData\Lines()\Text\OriginalText
	EndIf
	
	ProcedureReturn ""
EndProcedure

Procedure TimeLine_SetItemText(*this.PB_Gadget, Position.l, *Text)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		If Position >= 0 And SelectElement(\Lines(), Position)
			\Lines()\Text\OriginalText = PeekS(*Text)
			PrepareVectorTextBlock(@\Lines()\Text)
			\RedrawList = #True
			TimeLine_Draw(*GadgetData)
		EndIf
	EndWith
EndProcedure

Procedure TimeLine_ClearItems(*this.PB_Gadget)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		TimeLine_EndEdit(*GadgetData, #False)
		
		ClearList(\KeySelection())
		ClearList(\Selection())
		ClearList(\Blocks())
		ClearList(\Lines())
		
		\State = -1
		\HoverItem = -1
		\HoverBlock = #Null
		\DragParent = #Null
		\FirstDisplayedLine = 0
		
		TimeLine_LayoutLines(*GadgetData)
		TimeLine_SetScroll(\VScrollBar, 0)
		
		\RedrawAll = #True
		TimeLine_Draw(*GadgetData)
	EndWith
EndProcedure

Procedure TimeLine_GetItemState(*this.PB_Gadget, Position.l)
	; Nonzero when the line is the selected one - the same answer a ListViewGadget gives.
	Protected *GadgetData.TimeLineData = *this\vt
	
	ProcedureReturn Bool(Position > -1 And Position = *GadgetData\State)
EndProcedure

Procedure TimeLine_SetItemState(*this.PB_Gadget, Position.l, State.l)
	Protected *GadgetData.TimeLineData = *this\vt
	
	If State And Position > -1 And Position < ListSize(*GadgetData\Lines())
		TimeLine_SetState(*this, Position)
	EndIf
EndProcedure

Procedure TimeLine_GetItemAttribute(*this.PB_Gadget, Position.l, Attribute.l)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		If Position > -1 And SelectElement(\Lines(), Position)
			Select Attribute
				Case #Attribute_TimeLine_Folded
					ProcedureReturn Bool(\Lines()\Fold = #TimeLine_Folded)
				Case #Attribute_TimeLine_SubRows
					ProcedureReturn \Lines()\SubRows
				Case #Attribute_TimeLine_BlockCount
					ProcedureReturn ListSize(\Lines()\MediaBlocks())
			EndSelect
		EndIf
	EndWith
	
	ProcedureReturn 0
EndProcedure

Procedure TimeLine_SetItemAttribute(*this.PB_Gadget, Position.l, Attribute.l, Value.l)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		If Attribute <> #Attribute_TimeLine_Folded Or Position < 0 Or Not SelectElement(\Lines(), Position)
			ProcedureReturn #False
		ElseIf Not \Lines()\Fold					; nothing under it to hide, so nothing to fold
			ProcedureReturn #False
		EndIf
		
		If Value
			\Lines()\Fold = #TimeLine_Folded
		Else
			\Lines()\Fold = #TimeLine_Unfolded
		EndIf
		
		TimeLine_LayoutLines(*GadgetData)
		TimeLine_FirstDisplayed(*GadgetData)
		\RedrawList = #True
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure TimeLine_SetState(*this.PB_Gadget, State)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		TimeLine_EndEdit(*GadgetData, #True)
		\State = Clamp(State, -1, ListSize(\Lines()) - 1)
		TimeLine_VerticalFocus(*GadgetData)
		\RedrawList = #True
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
EndProcedure

;- Media blocks
Procedure.i AddMediaBlock(Gadget, Line, Position, Duration, Text.s, Color = 0, Icon = 0, *Data = 0, *Parent = 0)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, *NewBlock.TimeLine_Block, *Owner.TimeLine_Block = *Parent
	
	If Not *this
		ProcedureReturn #Null
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		If Line < 0 Or Not SelectElement(\Lines(), Line)
			ProcedureReturn #Null
		EndIf
		
		LastElement(\Blocks())
		*NewBlock = AddElement(\Blocks())
		*NewBlock\Text = Text
		*NewBlock\Postion = Max(Position, 0)
		*NewBlock\Duration = Max(Duration, 1)
		*NewBlock\Icon = Icon
		*NewBlock\Data = *Data
		
		If Color
			*NewBlock\Color = SetAlpha(Color, 255)
		Else
			*NewBlock\Color = \ThemeData\Special3[#Warm]
		EndIf
		
		If *Owner
			*NewBlock\Parent = *Owner
			TimeLine_SortChild(*Owner, *NewBlock)
		Else
			*NewBlock\ParentLine = @\Lines()
			TimeLine_SortBlock(@\Lines(), *NewBlock)
			TimeLine_ExtendDuration(*GadgetData, *NewBlock\Postion + *NewBlock\Duration)
		EndIf
		
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn *NewBlock
EndProcedure

Procedure RemoveMediaBlock(Gadget, *Block.TimeLine_Block)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Not *Block
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		TimeLine_FreeBlock(*GadgetData, *Block)
		
		TimeLine_RefreshBands(*GadgetData)
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure MoveMediaBlock(Gadget, *Block.TimeLine_Block, Line, Position, *Parent = 0)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, *Owner.TimeLine_Block = *Parent
	
	If Not *this Or Not *Block Or *Block = *Owner
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		If *Owner
			TimeLine_DetachBlock(*GadgetData, *Block)
			*Block\Parent = *Owner
			*Block\Postion = Max(Position, 0)
			TimeLine_SortChild(*Owner, *Block)
		Else
			If Line < 0 Or Not SelectElement(\Lines(), Line)
				ProcedureReturn #False
			EndIf
			
			TimeLine_DetachBlock(*GadgetData, *Block)
			*Block\ParentLine = @\Lines()
			*Block\Postion = Max(Position, 0)
			
			TimeLine_SortBlock(@\Lines(), *Block)
			TimeLine_ExtendDuration(*GadgetData, *Block\Postion + *Block\Duration)
		EndIf
		
		TimeLine_RefreshBands(*GadgetData)
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure ResizeMediaBlock(Gadget, *Block.TimeLine_Block, Position, Duration)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Not *Block
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		*Block\Postion = Max(Position, 0)
		*Block\Duration = Max(Duration, 1)
		
		If *Block\Parent
			TimeLine_SortChild(*Block\Parent, *Block)
		ElseIf *Block\ParentLine
			TimeLine_SortBlock(*Block\ParentLine, *Block)
			TimeLine_ExtendDuration(*GadgetData, *Block\Postion + *Block\Duration)
		EndIf
		
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure ScaleMediaBlockContents(Gadget, *Block.TimeLine_Block, Position, Duration)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, Old
	
	If Not *this Or Not *Block
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	Old = *Block\Duration
	*Block\Postion = Max(Position, 0)
	*Block\Duration = Max(Duration, 1)
	TimeLine_ScaleContents(*Block, Old, *Block\Duration)
	
	With *GadgetData
		If *Block\Parent
			TimeLine_SortChild(*Block\Parent, *Block)
		ElseIf *Block\ParentLine
			TimeLine_SortBlock(*Block\ParentLine, *Block)
			TimeLine_ExtendDuration(*GadgetData, *Block\Postion + *Block\Duration)
		EndIf
		
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure.i GetMediaBlockAttribute(Gadget, *Block.TimeLine_Block, Attribute)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, Result
	
	If Not *this Or Not *Block
		ProcedureReturn 0
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		Select Attribute
			Case #Attribute_MediaBlock_Position
				Result = *Block\Postion
			Case #Attribute_MediaBlock_AbsolutePosition
				Result = TimeLine_BlockStart(*Block)
			Case #Attribute_MediaBlock_Duration
				Result = *Block\Duration
			Case #Attribute_MediaBlock_Color
				Result = RGB(Red(*Block\Color), Green(*Block\Color), Blue(*Block\Color))
			Case #Attribute_MediaBlock_Icon
				Result = *Block\Icon
			Case #Attribute_MediaBlock_Container
				Result = *Block\Container
			Case #Attribute_MediaBlock_Tracks
				Result = *Block\Tracks
			Case #Attribute_MediaBlock_Selected
				Result = *Block\Selected
			Case #Attribute_MediaBlock_Data
				Result = *Block\Data
			Case #Attribute_MediaBlock_Parent
				Result = *Block\Parent
			Case #Attribute_MediaBlock_ChildCount
				Result = ListSize(*Block\Children())
			Case #Attribute_MediaBlock_Line
				Result = -1
				If *Block\ParentLine
					ForEach \Lines()
						If @\Lines() = *Block\ParentLine
							Result = ListIndex(\Lines())
							Break
						EndIf
					Next
				EndIf
		EndSelect
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure SetMediaBlockAttribute(Gadget, *Block.TimeLine_Block, Attribute, Value)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, Track
	
	If Not *this Or Not *Block
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		Select Attribute
			Case #Attribute_MediaBlock_Position
				ProcedureReturn ResizeMediaBlock(Gadget, *Block, Value, *Block\Duration)
			Case #Attribute_MediaBlock_Duration
				ProcedureReturn ResizeMediaBlock(Gadget, *Block, *Block\Postion, Value)
			Case #Attribute_MediaBlock_Color
				*Block\Color = SetAlpha(Value, 255)
			Case #Attribute_MediaBlock_Icon
				*Block\Icon = Value
			Case #Attribute_MediaBlock_Data
				*Block\Data = Value
			Case #Attribute_MediaBlock_Selected
				If Value
					TimeLine_Select(*GadgetData, *Block, #True)
				Else
					TimeLine_Deselect(*GadgetData, *Block)
				EndIf
			Case #Attribute_MediaBlock_Container ;{
				If Bool(Value) = *Block\Container
					ProcedureReturn #True
				EndIf
				
				*Block\Container = Bool(Value)
				
				TimeLine_RefreshBands(*GadgetData)
				;}
			Case #Attribute_MediaBlock_Tracks ;{
				*Block\Tracks = Value & ((1 << #__TimeLine_Track_Count) - 1)
				
				For Track = 0 To #__TimeLine_Track_Count - 1
					If TimeLine_TrackUsed(*Block, Track)		; a track holding keys always shows them
						*Block\Tracks | (1 << Track)
					EndIf
				Next
				
				TimeLine_RefreshBands(*GadgetData)
				;}
			Default
				ProcedureReturn #False
		EndSelect
		
		\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

Procedure.s GetMediaBlockText(Gadget, *Block.TimeLine_Block)
	If *Block
		ProcedureReturn *Block\Text
	EndIf
	
	ProcedureReturn ""
EndProcedure

Procedure SetMediaBlockText(Gadget, *Block.TimeLine_Block, Text.s)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Not *Block
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	*Block\Text = Text
	*GadgetData\RedrawBody = #True
	TimeLine_Draw(*GadgetData)
	
	ProcedureReturn #True
EndProcedure

Procedure.i CountMediaBlocks(Gadget, Line = -1)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this
		ProcedureReturn 0
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		If Line < 0
			ProcedureReturn ListSize(\Blocks())
		ElseIf SelectElement(\Lines(), Line)
			ProcedureReturn ListSize(\Lines()\MediaBlocks())
		EndIf
	EndWith
	
	ProcedureReturn 0
EndProcedure

Procedure.i GetMediaBlock(Gadget, Line, Index)
	; Line -1 walks every block the gadget owns, children included.
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Index < 0
		ProcedureReturn #Null
	EndIf
	
	*GadgetData = *this\vt
	
	With *GadgetData
		If Line < 0
			If SelectElement(\Blocks(), Index)
				ProcedureReturn @\Blocks()
			EndIf
		ElseIf SelectElement(\Lines(), Line) And SelectElement(\Lines()\MediaBlocks(), Index)
			ProcedureReturn \Lines()\MediaBlocks()
		EndIf
	EndWith
	
	ProcedureReturn #Null
EndProcedure

Procedure.i GetMediaBlockChild(Gadget, *Block.TimeLine_Block, Index)
	If *Block And Index >= 0 And SelectElement(*Block\Children(), Index)
		ProcedureReturn *Block\Children()
	EndIf
	
	ProcedureReturn #Null
EndProcedure

Procedure.i SelectedMediaBlock(Gadget, Index = 0)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Index < 0
		ProcedureReturn #Null
	EndIf
	
	*GadgetData = *this\vt
	
	If SelectElement(*GadgetData\Selection(), Index)
		ProcedureReturn *GadgetData\Selection()
	EndIf
	
	ProcedureReturn #Null
EndProcedure

Procedure.i CountSelectedMediaBlocks(Gadget)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this
		ProcedureReturn 0
	EndIf
	
	*GadgetData = *this\vt
	ProcedureReturn ListSize(*GadgetData\Selection())
EndProcedure

;- Keys
Procedure TimeLine_TrackUsed(*Block.TimeLine_Block, Track)
	ForEach *Block\Keys()
		If *Block\Keys()\Track = Track
			ProcedureReturn #True
		EndIf
	Next
	
	ProcedureReturn #False
EndProcedure

Procedure TimeLine_SortKey(*Block.TimeLine_Block, *Key.TimeLine_Key)
	; Keep the list ordered by track, then by time. MoveElement relinks rather than reallocates,
	; so a key the caller is holding survives being retimed.
	Protected *Target
	
	With *Block
		ForEach \Keys()
			If @\Keys() = *Key
				Continue
			ElseIf \Keys()\Track > *Key\Track Or (\Keys()\Track = *Key\Track And \Keys()\Time > *Key\Time)
				*Target = @\Keys()
				Break
			EndIf
		Next
		
		ChangeCurrentElement(\Keys(), *Key)
		
		If *Target
			MoveElement(\Keys(), #PB_List_Before, *Target)
		Else
			MoveElement(\Keys(), #PB_List_Last)
		EndIf
	EndWith
EndProcedure

Procedure.i AddMediaBlockKey(Gadget, *Block.TimeLine_Block, Track, Time, Value.d = 0)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, *Key.TimeLine_Key
	
	If Not *this Or Not *Block Or Track < 0 Or Track >= #__TimeLine_Track_Count
		ProcedureReturn #Null
	EndIf
	
	*GadgetData = *this\vt
	Time = Max(Time, 0)
	*Key = FindMediaBlockKey(Gadget, *Block, Track, Time)
	
	If *Key							; one key per track per time; a second one just revalues the first
		*Key\Value = Value
		*GadgetData\RedrawBody = #True
		TimeLine_Draw(*GadgetData)
		ProcedureReturn *Key
	EndIf
	
	LastElement(*Block\Keys())
	*Key = AddElement(*Block\Keys())
	*Key\Track = Track
	*Key\Time = Time
	*Key\Value = Value
	*Key\Block = *Block
	
	TimeLine_SortKey(*Block, *Key)
	*Block\Tracks | (1 << Track)
	
	TimeLine_RefreshBands(*GadgetData)
	TimeLine_Draw(*GadgetData)
	
	ProcedureReturn *Key
EndProcedure

Procedure RemoveMediaBlockKey(Gadget, *Key.TimeLine_Key)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData, *Block.TimeLine_Block, Track
	
	If Not *this Or Not *Key
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	*Block = *Key\Block
	Track = *Key\Track
	
	TimeLine_DeselectKey(*GadgetData, *Key)
	
	If *GadgetData\HoverKey = *Key
		*GadgetData\HoverKey = #Null
	EndIf
	
	ChangeCurrentElement(*Block\Keys(), *Key)
	DeleteElement(*Block\Keys())
	
	If Not TimeLine_TrackUsed(*Block, Track)		; the row goes with the last key on it
		*Block\Tracks & ~(1 << Track)
	EndIf
	
	TimeLine_RefreshBands(*GadgetData)
	TimeLine_Draw(*GadgetData)
	
	ProcedureReturn #True
EndProcedure

Procedure MoveMediaBlockKey(Gadget, *Key.TimeLine_Key, Time)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Not *Key
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	*Key\Time = Max(Time, 0)
	TimeLine_SortKey(*Key\Block, *Key)
	
	*GadgetData\RedrawBody = #True
	TimeLine_Draw(*GadgetData)
	
	ProcedureReturn #True
EndProcedure

Procedure.i FindMediaBlockKey(Gadget, *Block.TimeLine_Block, Track, Time)
	If Not *Block
		ProcedureReturn #Null
	EndIf
	
	ForEach *Block\Keys()
		If *Block\Keys()\Track = Track And *Block\Keys()\Time = Time
			ProcedureReturn @*Block\Keys()
		EndIf
	Next
	
	ProcedureReturn #Null
EndProcedure

Procedure.i CountMediaBlockKeys(Gadget, *Block.TimeLine_Block, Track = -1)
	Protected Count
	
	If Not *Block
		ProcedureReturn 0
	ElseIf Track < 0
		ProcedureReturn ListSize(*Block\Keys())
	EndIf
	
	ForEach *Block\Keys()
		If *Block\Keys()\Track = Track
			Count + 1
		EndIf
	Next
	
	ProcedureReturn Count
EndProcedure

Procedure.i GetMediaBlockKey(Gadget, *Block.TimeLine_Block, Track, Index)
	; The Index'th key on a track, in time order.
	If Not *Block Or Index < 0
		ProcedureReturn #Null
	EndIf
	
	ForEach *Block\Keys()
		If *Block\Keys()\Track = Track
			If Index = 0
				ProcedureReturn @*Block\Keys()
			EndIf
			Index - 1
		EndIf
	Next
	
	ProcedureReturn #Null
EndProcedure

Procedure.i GetMediaBlockKeyTime(Gadget, *Key.TimeLine_Key)
	If *Key
		ProcedureReturn *Key\Time
	EndIf
	
	ProcedureReturn 0
EndProcedure

Procedure.d GetMediaBlockKeyValue(Gadget, *Key.TimeLine_Key)
	If *Key
		ProcedureReturn *Key\Value
	EndIf
	
	ProcedureReturn 0
EndProcedure

Procedure SetMediaBlockKeyValue(Gadget, *Key.TimeLine_Key, Value.d)
	If Not *Key
		ProcedureReturn #False
	EndIf
	
	*Key\Value = Value				; nothing on screen reads it, so no redraw
	ProcedureReturn #True
EndProcedure

Procedure SetMediaBlockKeySelected(Gadget, *Key.TimeLine_Key, State)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Not *Key
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	
	If State
		TimeLine_ClearSelection(*GadgetData)		; keys and blocks never hold the selection at once
		TimeLine_SelectKey(*GadgetData, *Key, #True)
	Else
		TimeLine_DeselectKey(*GadgetData, *Key)
	EndIf
	
	*GadgetData\RedrawBody = #True
	TimeLine_Draw(*GadgetData)
	
	ProcedureReturn #True
EndProcedure

Procedure.i SelectedMediaBlockKey(Gadget, Index = 0)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Index < 0
		ProcedureReturn #Null
	EndIf
	
	*GadgetData = *this\vt
	
	If SelectElement(*GadgetData\KeySelection(), Index)
		ProcedureReturn *GadgetData\KeySelection()
	EndIf
	
	ProcedureReturn #Null
EndProcedure

Procedure.i CountSelectedMediaBlockKeys(Gadget)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this
		ProcedureReturn 0
	EndIf
	
	*GadgetData = *this\vt
	ProcedureReturn ListSize(*GadgetData\KeySelection())
EndProcedure

Procedure SetTimeLineTrackName(Gadget, Track, Text.s)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Track < 0 Or Track > #TimeLine_Track_Content
		ProcedureReturn #False
	EndIf
	
	*GadgetData = *this\vt
	*GadgetData\TrackName[Track] = Text
	*GadgetData\RedrawList = #True
	TimeLine_Draw(*GadgetData)
	
	ProcedureReturn #True
EndProcedure

Procedure.s GetTimeLineTrackName(Gadget, Track)
	Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData
	
	If Not *this Or Track < 0 Or Track > #TimeLine_Track_Content
		ProcedureReturn ""
	EndIf
	
	*GadgetData = *this\vt
	ProcedureReturn *GadgetData\TrackName[Track]
EndProcedure

;- Gadget attributes
Procedure TimeLine_GetAttribute(*This.PB_Gadget, Attribute)
	Protected *GadgetData.TimeLineData = *this\vt, Result
	
	With *GadgetData
		Select Attribute
			Case #Attribute_TimeLine_Duration
				Result = \Duration
			Case #Attribute_TimeLine_Zoom
				Result = \Zoom
			Case #Attribute_TimeLine_Scroll
				Result = \HScrollBar\State
			Case #Attribute_TimeLine_PlayerPosition
				Result = \PlayerPosition
			Case #Attribute_TimeLine_HoverItem
				Result = \HoverItem
			Default
				Result = Default_GetAttribute(*This, Attribute)
		EndSelect
	EndWith
	
	ProcedureReturn Result
EndProcedure

Procedure TimeLine_SetAttribute(*This.PB_Gadget, Attribute.l, Value)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		Select Attribute
			Case #Attribute_TimeLine_Duration ;{
				\Duration = Max(Value, 1)
				TimeLine_UpdateHScrollBar(*GadgetData)
				\PlayerPosition = Min(\PlayerPosition, \Duration)
				\RedrawHeader = #True
				\RedrawBody = #True
				;}
			Case #Attribute_TimeLine_Zoom ;{
				\Zoom = Clamp(Value, 0, #__TimeLine_Zoom_Count - 1)
				\Scale = TimeLine_ZoomLevel(\Zoom)
				TimeLine_UpdateHScrollBar(*GadgetData)
				\RedrawHeader = #True
				\RedrawBody = #True
				;}
			Case #Attribute_TimeLine_Scroll ;{
				TimeLine_SetScroll(\HScrollBar, Max(Value, 0))
				\RedrawHeader = #True
				\RedrawBody = #True
				;}
			Case #Attribute_TimeLine_PlayerPosition ;{
				\PlayerPosition = Clamp(Value, 0, \Duration)
				If TimeLine_HorizontalFocus(*GadgetData, \PlayerPosition)
					\RedrawBody = #True
				EndIf
				\RedrawHeader = #True
				\RedrawBody = #True
				;}
			Default
				ProcedureReturn Default_SetAttribute(*This, Attribute, Value)
		EndSelect
		
		TimeLine_Draw(*GadgetData)
	EndWith
	
	ProcedureReturn #True
EndProcedure

;- Housekeeping
Procedure TimeLine_LayoutMeta(*GadgetData.TimeLineData)
	; Put the two bars back where the current size says they belong.
	With *GadgetData
		\BodyHeight = \Height - BorderMargin - #TimeLine_Header_Height
		\BodyWidth = \Width - BorderMargin - #TimeLine_List_Width
		
		ScrollBar_ResizeMeta(\VScrollBar, \Width - #TimeLine_TrackBarThickness - BorderMargin - 2, #TimeLine_Header_Height + BorderMargin,
		                     #TimeLine_TrackBarThickness, Max(\BodyHeight - 1 - BorderMargin, 1))
		ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_PageLength, Max(\BodyHeight, 1))
		
		ScrollBar_ResizeMeta(\HScrollBar, #TimeLine_List_Width + BorderMargin, \Height - #TimeLine_TrackBarThickness - BorderMargin - 2,
		                     Max(\BodyWidth - #TimeLine_TrackBarThickness - BorderMargin - 2, 1), #TimeLine_TrackBarThickness)
		
		TimeLine_UpdateHScrollBar(*GadgetData)
		TimeLine_LayoutLines(*GadgetData)
		TimeLine_FirstDisplayed(*GadgetData)
	EndWith
EndProcedure

Procedure TimeLine_Resize(*This.PB_Gadget, x.l, y.l, Width.l, Height.l)
	Protected *GadgetData.TimeLineData = *this\vt
	
	*this\VT = *GadgetData\OriginalVT
	ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
	*this\VT = *GadgetData
	
	With *GadgetData
		\Width = GadgetWidth(\Gadget)
		\Height = GadgetHeight(\Gadget)
		
		TimeLine_EndEdit(*GadgetData, #True)
		TimeLine_LayoutMeta(*GadgetData)
		ResizeWindow(\ReorderWindow, #PB_Ignore, #PB_Ignore, \Width, #PB_Ignore)
		ResizeGadget(\ReorderCanvas, #PB_Ignore, #PB_Ignore, \Width, #PB_Ignore)
		
		\RedrawAll = #True
		TimeLine_Draw(*GadgetData)
	EndWith
EndProcedure

Procedure TimeLine_Free(*this.PB_Gadget)
	Protected *GadgetData.TimeLineData = *this\vt
	
	With *GadgetData
		If IsWindow(\ReorderWindow)
			CloseWindow(\ReorderWindow)
		EndIf
		
		RemoveGadgetTimers(\String)
		FreeStructureX(\String)		; its ThemeData is the gadget's own theme, freed once in Default_FreeGadget
		FreeStructureX(\VScrollBar)
		FreeStructureX(\HScrollBar)
	EndWith
	
	Default_FreeGadget(*this)
EndProcedure

Procedure TimeLine_Meta(*GadgetData.TimeLineData, *ThemeData, Gadget, x, y, Width, Height, Flags)
	Protected GadgetList
	
	*GadgetData\ThemeData = *ThemeData
	InitializeObject(TimeLine)
	
	With *GadgetData
		\VT\GetGadgetState = @Default_GetState()
		\VT\SetGadgetState = @TimeLine_SetState()
		\VT\AddGadgetItem3 = @TimeLine_AddItem()
		\VT\RemoveGadgetItem = @TimeLine_RemoveItem()
		\VT\CountGadgetItems = @TimeLine_CountItem()
		\VT\ClearGadgetItemList = @TimeLine_ClearItems()
		\VT\GetGadgetItemText = @TimeLine_GetItemText()
		\VT\SetGadgetItemText = @TimeLine_SetItemText()
		\VT\GetGadgetItemState = @TimeLine_GetItemState()
		\VT\SetGadgetItemState = @TimeLine_SetItemState()
		\VT\GetGadgetItemAttribute2 = @TimeLine_GetItemAttribute()
		\VT\SetGadgetItemAttribute2 = @TimeLine_SetItemAttribute()
		\VT\GetGadgetAttribute = @TimeLine_GetAttribute()
		\VT\SetGadgetAttribute = @TimeLine_SetAttribute()
		\VT\ResizeGadget = @TimeLine_Resize()
		\VT\FreeGadget = @TimeLine_Free()
		
		; Enable only the needed events
		\SupportedEvent[#MouseLeave] = #True
		\SupportedEvent[#MouseMove] = #True
		\SupportedEvent[#KeyDown] = #True
		\SupportedEvent[#LeftButtonDown] = #True
		\SupportedEvent[#LeftButtonUp] = #True
		\SupportedEvent[#LeftDoubleClick] = #True
		\SupportedEvent[#RightButtonDown] = #True
		\SupportedEvent[#MouseWheel] = #True
		\SupportedEvent[#LostFocus] = #True
		
		\RedrawAll = #True
		
		\State = -1
		\HoverItem = -1
		\ReorderPosition = -1
		\DropLine = -1
		\Duration = 600
		\Zoom = #TimeLine_Zoom_Default
		\Scale = TimeLine_ZoomLevel(\Zoom)
		
		; Starting points, not a vocabulary — SetTimeLineTrackName relabels any of them.
		\TrackName[#TimeLine_Track_X] = "X"
		\TrackName[#TimeLine_Track_Y] = "Y"
		\TrackName[#TimeLine_Track_Width] = "Width"
		\TrackName[#TimeLine_Track_Height] = "Height"
		\TrackName[#TimeLine_Track_Opacity] = "Opacity"
		\TrackName[#TimeLine_Track_Angle] = "Angle"
		\TrackName[#TimeLine_Track_Content] = "Content"
		
		GadgetList = UseGadgetList(0)
		\ReorderWindow = OpenWindow(#PB_Any, 0, 0, Width, #TimeLine_List_LineHeight, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(CurrentWindow()))
		\ReorderCanvas = CanvasGadget(#PB_Any, 0, 0, Width, #TimeLine_List_LineHeight, #PB_Canvas_Keyboard)
		BindGadgetEvent(\ReorderCanvas, @TimeLine_DragWindowHandler())
		SetProp_(GadgetID(\ReorderCanvas), "UITK_TimeLine", *GadgetData)
		SetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED)
		SetLayeredWindowAttributes_(WindowID(\ReorderWindow), 0, 128, #LWA_ALPHA)
		UseGadgetList(GadgetList)
		
		AllocateStructureX(\VScrollBar, ScrollBarData)
		ScrollBar_Meta(\VScrollBar, *ThemeData, -1, 0, 0, #TimeLine_TrackBarThickness, #TimeLine_TrackBarThickness, 0, 1, 1, #Gadget_Vertical | #Gadget_Meta)
		
		AllocateStructureX(\HScrollBar, ScrollBarData)
		ScrollBar_Meta(\HScrollBar, *ThemeData, -1, 0, 0, #TimeLine_TrackBarThickness, #TimeLine_TrackBarThickness, 0, 1, 1, #Gadget_Meta)
		
		TimeLine_LayoutMeta(*GadgetData)
		
		AllocateStructureX(\String, StringData)
		String_Meta(\String, *ThemeData, Gadget, 0, 0, \Width, 24, "", #HAlignLeft | #Gadget_Meta)
		String_SetFont_Meta(\String, TimeLine_ListFont)
		String_SupportedEvents()
	EndWith
EndProcedure

Procedure TimeLine(Gadget, x, y, Width, Height, Flags = #Default)
	Protected Result, *this.PB_Gadget, *GadgetData.TimeLineData, *ThemeData
	
	Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | #PB_Canvas_Container)
	
	If Result
		CreateGadgetObject(TimeLineData)
		TimeLine_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		
		If Not Flags & #PB_Canvas_Container
			CloseGadgetList()
		EndIf
		
		RedrawObject()
		
	EndIf
	
	ProcedureReturn Result
EndProcedure


; IDE Options = PureBasic 6.41 (Windows - x64)
; CursorPosition = 451
; FirstLine = 223
; Folding = AAAAAAAAAAAAAAAAAAAAAAAAAAA-
; EnableXP
; DPIAware