IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)
Global Timeline

Procedure AddLine()
	AddGadgetItem(Timeline, -1, "Line " + CountGadgetItems(Timeline))
EndProcedure

Procedure RemoveLine()
	RemoveGadgetItem(Timeline, GetGadgetState(Timeline))
EndProcedure

Window = UITK::Window(#PB_Any, 0, 0, 961, 609, "UI Toolkit : dark theme", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter | #PB_Window_ScreenCentered)
Timeline = UITK::TimeLine(#PB_Any, 10, 10, 957, 300, #PB_Canvas_Container)

Button = UITK::Button(#PB_Any, 10, 10, 40, 40, "+")
BindGadgetEvent(Button, @AddLine(), #PB_EventType_Change)

Button = UITK::Button(#PB_Any, 50, 10, 40, 40, "-")
BindGadgetEvent(Button, @RemoveLine(), #PB_EventType_Change)

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		End
	EndIf
ForEver
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 12
; Folding = -
; EnableXP
; DPIAware