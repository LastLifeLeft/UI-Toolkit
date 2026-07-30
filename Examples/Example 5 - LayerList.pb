; The LayerList is compiled in only when this module exists before the include - same
; opt-in scheme as the TimeLine, so a programme that doesn't need it doesn't carry it.
DeclareModule EnableLayerList :: EndDeclareModule
Module EnableLayerList :: EndModule

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global List, Status, Counter

; Builds a little swatch on the fly so the example needs no asset files.
Procedure LayerIcon(r, g, b, Shape)
	Protected Image = CreateImage(#PB_Any, 16, 16, 32, #PB_Image_Transparent)

	StartDrawing(ImageOutput(Image))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	Select Shape
		Case 0 : Box(2, 2, 12, 12, RGBA(r, g, b, 255))
		Case 1 : Circle(8, 8, 6, RGBA(r, g, b, 255))
		Case 2 : Box(2, 6, 12, 4, RGBA(r, g, b, 255))
	EndSelect
	StopDrawing()

	ProcedureReturn Image
EndProcedure

; The three events all report which row they're about through GetGadgetState.
Procedure RefreshStatus(Tag.s)
	Protected Row = GetGadgetState(List), Text.s

	If Row < 0 Or Row >= CountGadgetItems(List)
		SetGadgetText(Status, Tag + " - nothing selected")
		ProcedureReturn
	EndIf

	Text = Tag + " - " + GetGadgetItemText(List, Row)

	; GetGadgetItemState answers the same question a ListViewGadget's does: is this row selected.
	Protected i, Selected
	For i = 0 To CountGadgetItems(List) - 1
		If GetGadgetItemState(List, i) : Selected + 1 : EndIf
	Next
	If Selected > 1
		Text + " [" + Str(Selected) + " selected]"
	EndIf

	If GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_IsChild)
		Text + " (child of " + GetGadgetItemText(List, GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_Parent)) + ")"
	Else
		Text + " (group of " + Str(GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_ChildCount)) + ")"
	EndIf

	; The eye a row carries and whether it actually shows through are two different questions:
	; a lit child inside a switched-off group reports eye on, shows off.
	Text + ", eye " + Str(GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_Visible))
	Text + ", shows " + Str(GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_EffectiveVisible))

	SetGadgetText(Status, Text)
EndProcedure

Procedure Handler_List()
	Select EventType()
		Case UITK::#EventType_LayerVisibility
			RefreshStatus("eye clicked")
		Case UITK::#EventType_LayerFold
			RefreshStatus("folded/unfolded")
		Case UITK::#EventType_ItemTextChange
			RefreshStatus("renamed")
		Case UITK::#EventType_ForcefulChange
			RefreshStatus("double-clicked")
		Default
			RefreshStatus("selected/reordered")
	EndSelect
EndProcedure

; EditGadgetItemText is the library's way in: it just sends F2 to the gadget.
Procedure Handler_Rename()
	If GetGadgetState(List) > -1
		UITK::EditGadgetItemText(List)
	EndIf
EndProcedure

Procedure Handler_AddGroup()
	Counter + 1
	SetGadgetState(List, AddGadgetItem(List, -1, "Group " + Str(Counter), ImageID(LayerIcon(Random(255, 90), Random(255, 90), Random(255, 90), 0)), 0))
	RefreshStatus("group added")
EndProcedure

; Adds a child at the end of whichever group the selection sits in - a small tour of the
; read-only attributes: IsChild to find out what's selected, Parent to climb to the group,
; ChildCount to land after its last child.
Procedure Handler_AddChild()
	Protected Row = GetGadgetState(List), Group, Position

	If Row < 0
		ProcedureReturn
	EndIf

	If GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_IsChild)
		Group = GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_Parent)
	Else
		Group = Row
	EndIf

	Position = Group + 1 + GetGadgetItemAttribute(List, Group, UITK::#Attribute_LayerList_ChildCount)
	If Position >= CountGadgetItems(List)
		Position = -1
	EndIf

	Counter + 1
	SetGadgetState(List, AddGadgetItem(List, Position, "Layer " + Str(Counter), ImageID(LayerIcon(Random(255, 90), Random(255, 90), Random(255, 90), 1)), 1))
	RefreshStatus("child added")
EndProcedure

; Removing a group takes its children with it.
Procedure Handler_RemoveRow()
	If GetGadgetState(List) > -1
		RemoveGadgetItem(List, GetGadgetState(List))
		RefreshStatus("removed")
	EndIf
EndProcedure

Procedure Handler_ToggleEye()
	Protected Row = GetGadgetState(List)

	If Row > -1
		SetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_Visible, Bool(Not GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_Visible)))
		RefreshStatus("eye toggled")
	EndIf
EndProcedure

Procedure FoldEvery(State)
	Protected Row

	For Row = 0 To CountGadgetItems(List) - 1
		If Not GetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_IsChild)
			SetGadgetItemAttribute(List, Row, UITK::#Attribute_LayerList_Folded, State)
		EndIf
	Next
EndProcedure

Procedure Handler_FoldAll()
	FoldEvery(#True)
	RefreshStatus("all folded")
EndProcedure

Procedure Handler_UnfoldAll()
	FoldEvery(#False)
	RefreshStatus("all unfolded")
EndProcedure

Window = UITK::Window(#PB_Any, (Width - 620) * 0.5, (Height - 460) * 0.5, 620, 460, "UI Toolkit : LayerList", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter)

; #ReOrder turns on dragging: a child moves between groups, a group travels with its children.
; #Editable turns on renaming a row in place with F2.
; #MultiSelect turns on ctrl / shift click, like a #PB_ListView_Multiselect ListViewGadget.
List = UITK::LayerList(#PB_Any, 20, 20, 300, 380, UITK::#Border | UITK::#ReOrder | UITK::#Editable | UITK::#MultiSelect)

UITK::Label(#PB_Any, 340, 20, 260, 20, "Drag rows to reorder - a child can be dropped", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 340, 38, 260, 20, "into any group, a group carries its children.", UITK::#HAlignLeft)

Button = UITK::Button(#PB_Any, 340, 70, 125, 30, "Add group", UITK::#Border)
BindGadgetEvent(Button, @Handler_AddGroup(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 475, 70, 125, 30, "Add child", UITK::#Border)
BindGadgetEvent(Button, @Handler_AddChild(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 340, 108, 125, 30, "Remove", UITK::#Border)
BindGadgetEvent(Button, @Handler_RemoveRow(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 475, 108, 125, 30, "Toggle eye", UITK::#Border)
BindGadgetEvent(Button, @Handler_ToggleEye(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 340, 146, 125, 30, "Fold all", UITK::#Border)
BindGadgetEvent(Button, @Handler_FoldAll(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 475, 146, 125, 30, "Unfold all", UITK::#Border)
BindGadgetEvent(Button, @Handler_UnfoldAll(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 340, 184, 125, 30, "Rename", UITK::#Border)
BindGadgetEvent(Button, @Handler_Rename(), #PB_EventType_Change)

UITK::Label(#PB_Any, 340, 228, 260, 20, "Keys: up/down select, left folds, right", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 340, 246, 260, 20, "unfolds, space toggles the eye, F2 renames", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 340, 264, 260, 20, "(Enter keeps it, Escape drops it).", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 340, 288, 260, 20, "Ctrl / shift click to select several - the eye", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 340, 306, 260, 20, "then hits all of them, and dragging moves the", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 340, 324, 260, 20, "lot (all children, or all groups).", UITK::#HAlignLeft)

Status = UITK::Label(#PB_Any, 340, 356, 260, 60, "", UITK::#HAlignLeft | UITK::#VAlignTop)

; The fifth AddGadgetItem argument is the level: 0 makes a group, 1 a child of the group above it.
AddGadgetItem(List, -1, "Background", ImageID(LayerIcon(90, 140, 230, 0)), 0)
AddGadgetItem(List, -1, "Sky",        ImageID(LayerIcon(120, 200, 255, 2)), 1)
AddGadgetItem(List, -1, "Clouds",     ImageID(LayerIcon(230, 230, 240, 1)), 1)

AddGadgetItem(List, -1, "Characters", ImageID(LayerIcon(230, 160, 90, 0)), 0)
AddGadgetItem(List, -1, "Hero",       ImageID(LayerIcon(240, 100, 100, 1)), 1)
AddGadgetItem(List, -1, "Sidekick",   ImageID(LayerIcon(240, 200, 90, 1)), 1)
AddGadgetItem(List, -1, "Enemies",    ImageID(LayerIcon(150, 90, 200, 1)), 1)

AddGadgetItem(List, -1, "Effects",    ImageID(LayerIcon(120, 220, 170, 0)), 0)
AddGadgetItem(List, -1, "Particles",  ImageID(LayerIcon(160, 240, 200, 2)), 1)

AddGadgetItem(List, -1, "Overlay",    ImageID(LayerIcon(200, 200, 200, 0)), 0)
Counter = 10

SetGadgetItemAttribute(List, 2, UITK::#Attribute_LayerList_Visible, #False)	; Clouds switched off on its own
SetGadgetItemAttribute(List, 7, UITK::#Attribute_LayerList_Folded, #True)	; Effects starts folded

SetGadgetState(List, 4)
RefreshStatus("ready")

BindGadgetEvent(List, @Handler_List(), #PB_EventType_Change)
BindGadgetEvent(List, @Handler_List(), UITK::#EventType_LayerVisibility)
BindGadgetEvent(List, @Handler_List(), UITK::#EventType_LayerFold)
BindGadgetEvent(List, @Handler_List(), UITK::#EventType_ItemTextChange)
BindGadgetEvent(List, @Handler_List(), UITK::#EventType_ForcefulChange)

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		End
	EndIf
ForEver
