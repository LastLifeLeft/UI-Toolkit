DeclareModule EnableTimeline :: EndDeclareModule
Module EnableTimeline :: EndModule

IncludeFile "../Library/UI-Toolkit.pbi"

Global Window, Timeline, IconClip, IconFx

; Builds a small, distinct icon on the fly so the demo needs no extra asset files.
Procedure ToolIcon(Shape)
	Protected Image = CreateImage(#PB_Any, 22, 22, 32, #PB_Image_Transparent)
	StartDrawing(ImageOutput(Image))
	DrawingMode(#PB_2DDrawing_AlphaBlend)
	Select Shape
		Case 0 : Box(3, 9, 16, 4, RGBA(230, 230, 230, 255)) : Box(9, 3, 4, 16, RGBA(230, 230, 230, 255))
		Case 1 : Box(3, 9, 16, 4, RGBA(230, 230, 230, 255))
		Case 2 : Box(2, 7, 18, 8, RGBA(120, 220, 150, 255))
		Case 3 : Box(1, 4, 20, 14, RGBA(200, 130, 240, 255)) : Box(3, 10, 7, 6, RGBA(40, 44, 55, 255)) : Box(12, 10, 7, 6, RGBA(40, 44, 55, 255))
	EndSelect
	StopDrawing()
	ProcedureReturn ImageID(Image)
EndProcedure

Procedure Status(Text.s)
	UITK::SetWindowLabel(Window, "UI Toolkit : timeline — " + Text)
EndProcedure

Procedure AddLine()
	SetGadgetState(Timeline, AddGadgetItem(Timeline, -1, "Line " + Str(CountGadgetItems(Timeline))))
	UITK::EditGadgetItemText(Timeline)
EndProcedure

Procedure RemoveLine()
	RemoveGadgetItem(Timeline, GetGadgetState(Timeline))
EndProcedure

Procedure AddBlock()
	Protected Line = GetGadgetState(Timeline)
	UITK::AddMediaBlock(Timeline, Line, Random(400, 0), Random(120, 20), "Clip " + Str(UITK::CountMediaBlocks(Timeline, Line)), RGB($39, $DA, $8A), IconClip)
EndProcedure

Procedure AddContainer()
	Protected Line = GetGadgetState(Timeline), *Block

	*Block = UITK::AddMediaBlock(Timeline, Line, Random(300, 0), 200, "Group", RGB($EF, $0F, $8E), IconFx)
	If *Block
		UITK::SetMediaBlockAttribute(Timeline, *Block, UITK::#Attribute_MediaBlock_Container, #True)
		UITK::AddMediaBlock(Timeline, Line, 10, 60, "Take 1", RGB($65, $AC, $FF), 0, 0, *Block)
		UITK::AddMediaBlock(Timeline, Line, 110, 70, "Take 2", RGB($65, $AC, $FF), 0, 0, *Block)
	EndIf
EndProcedure

Procedure Handler_ToolBar()
	Select GetGadgetState(EventGadget())
		Case 0 : AddLine()
		Case 1 : RemoveLine()
		Case 2 : AddBlock()
		Case 3 : AddContainer()
	EndSelect
EndProcedure

Procedure Handler_Timeline()
	Select EventType()
		Case UITK::#EventType_TimeLinePlayerMove
			Status("playhead " + Str(EventData()))

		Case UITK::#EventType_TimeLineBlockSelect
			Status(Str(UITK::CountSelectedMediaBlocks(Timeline)) + " block(s) selected")

		Case UITK::#EventType_TimeLineBlockChange
			Status("blocks changed")

		Case UITK::#EventType_TimeLineBlockEdit
			Status("edit " + UITK::GetMediaBlockText(Timeline, EventData()))

		Case UITK::#EventType_TimeLineFold
			Status("line " + Str(EventData()) + " folded or unfolded")
	EndSelect
EndProcedure

Window = UITK::Window(#PB_Any, 0, 0, 980, 500, "UI Toolkit : timeline — drag the header to scrub, ctrl+wheel to zoom, shift+wheel to pan", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#Window_Sizable | UITK::#Window_ScreenCentered)

IconClip = ImageID(UITK::LoadSvgIcon("../Media/undo.svg", 24, RGB($F0, $F0, $F0)))
IconFx = ImageID(UITK::LoadSvgIcon("../Media/redo.svg", 24, RGB($F0, $F0, $F0)))

; #PB_Canvas_Container keeps the gadget list open, so the toolbar below lands inside the
; timeline — in the empty corner above the line list, where it stays clear of the ruler.
Timeline = UITK::TimeLine(#PB_Any, 10, 10, 960, 480, #PB_Canvas_Container)
BindGadgetEvent(Timeline, @Handler_Timeline())

ToolBar = UITK::ToolBar(#PB_Any, 8, 14, 136, 32)
AddGadgetItem(ToolBar, -1, "Add line", ToolIcon(0), 0)
AddGadgetItem(ToolBar, -1, "Remove line", ToolIcon(1), 0)
AddGadgetItem(ToolBar, -1, "Add block", ToolIcon(2), 0)
AddGadgetItem(ToolBar, -1, "Add group", ToolIcon(3), 0)
BindGadgetEvent(ToolBar, @Handler_ToolBar(), #PB_EventType_Change)

CloseGadgetList()

AddGadgetItem(Timeline, -1, "Background")
AddGadgetItem(Timeline, -1, "Characters")
AddGadgetItem(Timeline, -1, "Music")
SetGadgetState(Timeline, 0)

UITK::AddMediaBlock(Timeline, 0, 0, 240, "Establishing shot", RGB($39, $DA, $8A), IconClip)
UITK::AddMediaBlock(Timeline, 0, 260, 180, "Wide", RGB($39, $DA, $8A), IconClip)
UITK::AddMediaBlock(Timeline, 2, 0, 500, "Main theme", RGB($FF, $0F, $84), IconFx)

Define *Group = UITK::AddMediaBlock(Timeline, 1, 40, 300, "Dialogue", RGB($8E, $0F, $EF), IconFx)
UITK::SetMediaBlockAttribute(Timeline, *Group, UITK::#Attribute_MediaBlock_Container, #True)
UITK::AddMediaBlock(Timeline, 1, 20, 90, "Line A", RGB($65, $AC, $FF), 0, 0, *Group)
UITK::AddMediaBlock(Timeline, 1, 140, 120, "Line B", RGB($65, $AC, $FF), 0, 0, *Group)

SetGadgetAttribute(Timeline, UITK::#Attribute_TimeLine_PlayerPosition, 120)

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		End
	EndIf
ForEver
; IDE Options = PureBasic 6.40 (Windows - x64)
; CursorPosition = 42
; Folding = -
; EnableXP
; DPIAware
