IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu, Image

Procedure ButtonEvent()
	UITK::ShowFlatMenu(Menu)
EndProcedure

Window0 = UITK::Window(#PB_Any, (Width - 1024) * 0.5 - 200, (Height - 600) * 0.5 - 100, 1024, 600, "UI Toolkit : showcase raster", UITK::#Window_CloseButton)

Image = CreateImage(#PB_Any, 24, 24, 32, $FFFF00FF)

Gadget = UITK::Button(#PB_Any, 20, 20, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
UITK::SetGadgetImage(Gadget, Image)
UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Button_Toggle)
UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UITK::#HAlignLeft | UITK::#Border)

UITK::Toggle(#PB_Any, 20, 185, 200, 38, "Toggle with a slightly longer description")
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#ScrollBar_Vertical)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25)

Gadget = UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")

UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight | UITK::#Vector)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)

UITK::ScrollArea(#PB_Any, 260, 120, 200, 200, 300, 300, 10)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area", UITK::#HAlignCenter)
CloseGadgetList()



Window1 = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 1024, 600, "UI Toolkit : showcase dark vector", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter)
UITK::SetWindowBounds(Window1, 1024, 630, 0, 0)
Gadget = UITK::Button(#PB_Any, 20, 20, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", UITK::#Vector | UITK::#DarkMode)
UITK::SetGadgetImage(Gadget, Image)
UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Vector | UITK::#DarkMode | UITK::#Button_Toggle)
UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UITK::#HAlignLeft | UITK::#Vector | UITK::#Border | UITK::#DarkMode)

UITK::Toggle(#PB_Any, 20, 185, 200, 38, "Toggle with a slightly longer description", UITK::#Vector | UITK::#DarkMode)
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight | UITK::#Vector | UITK::#DarkMode)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox", UITK::#Vector | UITK::#DarkMode)
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight | UITK::#Vector | UITK::#DarkMode)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#ScrollBar_Vertical | UITK::#Vector | UITK::#DarkMode)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25, UITK::#Vector | UITK::#DarkMode)

Gadget = UITK::Label(#PB_Any, 260, 20, 200, 20, "Label", UITK::#HAlignLeft | UITK::#Vector | UITK::#DarkMode)
UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight | UITK::#Vector | UITK::#DarkMode)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter | UITK::#Vector | UITK::#DarkMode)

UITK::ScrollArea(#PB_Any, 260, 120, 200, 200, 300, 300, 10, UITK::#DarkMode | UITK::#Vector)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area", UITK::#Vector | UITK::#DarkMode | UITK::#HAlignCenter)
CloseGadgetList()



UITK::SetAccessibilityMode(#True)
OpenWindow(2, (Width - 1024) * 0.5 + 200, (Height - 600) * 0.5 + 100, 1024, 600, "UI Toolkit : Accessibility", #PB_Window_SystemMenu)
UITK::Button(#PB_Any, 20, 20, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Vector | UITK::#Button_Toggle)
UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left", UITK::#HAlignLeft)

UITK::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle")
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 17, 148, 0, 100, 25, UITK::#ScrollBar_Vertical | UITK::#Vector | UITK::#DarkMode)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 17, 0, 100, 25, UITK::#Vector | UITK::#DarkMode)

UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")
UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)



Menu = UITK::FlatMenu(UITK::#DarkMode)
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 2")
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 3")
UITK::AddFlatMenuItem(Menu, 0, 0, "Item 1")
UITK::AddFlatMenuSeparator(Menu, -1)
UITK::AddFlatMenuItem(Menu, 0, -1, "Variable Viewer")
UITK::AddFlatMenuItem(Menu, 0, -1, "Compare Files/Folder")
UITK::AddFlatMenuItem(Menu, 0, -1, "Procedure Browser")

BindEvent(#PB_Event_RightClick, @ButtonEvent())


Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		Result = 0
		
		phandle = OpenProcess_(#PROCESS_TERMINATE, #False, GetCurrentProcessId_()) ;< I clearly have issues with my windows, but killing the process is a valid workaround for my own ineptitude.
		TerminateProcess_(phandle, @Result)
		End
	EndIf
ForEver

; IDE Options = PureBasic 6.00 Beta 6 (Windows - x64)
; CursorPosition = 20
; Folding = +
; EnableXP