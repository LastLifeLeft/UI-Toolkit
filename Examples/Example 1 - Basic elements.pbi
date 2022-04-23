UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png")

Procedure ButtonEvent()
	UITK::ShowFlatMenu(Menu)
EndProcedure

Window0 = UITK::Window(#PB_Any, (Width - 1024) * 0.5 - 200, (Height - 600) * 0.5 - 100, 470, 600, "UI Toolkit : component showcase", UITK::#Window_CloseButton)

UITK::SetWindowIcon(Window0, Image)

Gadget = UITK::Button(#PB_Any, 20, 20, 200, 40, "Toggle button Center")
UITK::SetGadgetImage(Gadget, Image)
Gadget = UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Button_Toggle)
UITK::SetGadgetImage(Gadget, Image)
Gadget = UITK::Button(#PB_Any, 20, 120, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", UITK::#HAlignLeft | UITK::#Border)
UITK::SetGadgetImage(Gadget, Image)

UITK::Toggle(#PB_Any, 20, 185, 200, 38, "Toggle with a slightly longer description")
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#ScrollBar_Vertical)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25)

Gadget = UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")

UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)

UITK::ScrollArea(#PB_Any, 260, 120, 200, 200, 300, 300, 10)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area", UITK::#HAlignCenter)
CloseGadgetList()

Gadget = UITK::TrackBar(#PB_Any, 260, 330, 200, 40, 0, 100, UITK::#VAlignTop)
AddGadgetItem(Gadget, 0, "x.5")
AddGadgetItem(Gadget, 13, "x1")
AddGadgetItem(Gadget, 100, "x4")
SetGadgetState(Gadget, 31)

Gadget = UITK::TrackBar(#PB_Any, 260, 390, 60, 180, 0, 4, UITK::#Trackbar_Vertical)
AddGadgetItem(Gadget, 0, "Low")
AddGadgetItem(Gadget, 4, "High")



Window1 = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 470, 600, "UI Toolkit : dark theme", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter)
UITK::SetWindowIcon(Window1, Image)
UITK::SetWindowBounds(Window1, 480, 630, 0, 0)

Gadget = UITK::Button(#PB_Any, 20, 20, 200, 40, "Button center", UITK::#DarkMode)
UITK::SetGadgetImage(Gadget, Image)
Gadget = UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Button_Toggle)
UITK::SetGadgetImage(Gadget, Image)
Gadget = UITK::Button(#PB_Any, 20, 120, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", UITK::#HAlignLeft | UITK::#Border)
UITK::SetGadgetImage(Gadget, Image)

UITK::Toggle(#PB_Any, 20, 185, 200, 38, "Toggle with a slightly longer description", UITK::#DarkMode)
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#ScrollBar_Vertical)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25, UITK::#DarkMode)

Gadget = UITK::Label(#PB_Any, 260, 20, 200, 20, "Label", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)

UITK::ScrollArea(#PB_Any, 260, 120, 200, 180, 300, 300, 10, UITK::#DarkMode)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area",  UITK::#HAlignCenter)
CloseGadgetList()

Gadget = UITK::TrackBar(#PB_Any, 260, 330, 200, 40, 0, 100,  UITK::#VAlignTop)
AddGadgetItem(Gadget, 0, "x.5")
AddGadgetItem(Gadget, 13, "x1")
AddGadgetItem(Gadget, 100, "x4")
SetGadgetState(Gadget, 31)

Gadget = UITK::TrackBar(#PB_Any, 260, 390, 60, 180, 0, 4,  UITK::#Trackbar_Vertical)
AddGadgetItem(Gadget, 0, "Low")
AddGadgetItem(Gadget, 4, "High")


; UITK::SetAccessibilityMode(#True)
; OpenWindow(2, (Width - 1024) * 0.5 + 200, (Height - 600) * 0.5 + 100, 1024, 600, "UI Toolkit : Accessibility", #PB_Window_SystemMenu)
; UITK::Button(#PB_Any, 20, 20, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
; UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Button_Toggle)
; UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left", UITK::#HAlignLeft)
; 
; UITK::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle")
; UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)
; 
; UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
; Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
; SetGadgetState(Gadget, #PB_Checkbox_Inbetween)
; 
; UITK::ScrollBar(#PB_Any, 213, 420, 17, 148, 0, 100, 25, UITK::#ScrollBar_Vertical)
; UITK::ScrollBar(#PB_Any, 20, 568, 193, 17, 0, 100, 25)
; 
; UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")
; UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight)
; UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)



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
; CursorPosition = 60
; FirstLine = 34
; Folding = +
; EnableXP