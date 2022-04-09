IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)



; UITK::Window(#PB_Any, (Width - 1280) * 0.5 - 200, (Height - 720) * 0.5 - 100, 1280, 720, "UI Toolkit : showcase raster", UITK::#Window_CloseButton)
; UITK::Button(#PB_Any, 20, 20, 200, 40, "Button")
; UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#AlignRight | UITK::#Button_Toggle)
; UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UITK::#AlignLeft | UITK::#Border)
; 
; UITK::Toggle(#PB_Any, 20, 200, 200, 28, "Toggle")
; UITK::Toggle(#PB_Any, 20, 240, 200, 28, "Toggle aligned right", UITK::#AlignRight)
; 
; UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
; Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#AlignRight)
; SetGadgetState(Gadget, #PB_Checkbox_Inbetween)
; 
; UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#ScrollBar_Vertical)
; UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25)
; 
; UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")
; UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#AlignRight)
; UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#AlignCenter)

Global Gadget, Window, Menu

Procedure ButtonEvent()
	UITK::ShowFlatMenu(Menu)
EndProcedure

Window = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 1024, 600, "UI Toolkit : showcase dark vector", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#AlignCenter)
UITK::SetWindowBounds(Window, 1024, 630, 0, 0)
UITK::Button(#PB_Any, 20, 20, 200, 40, "Button", UITK::#Vector | UITK::#DarkMode)
UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#AlignRight | UITK::#Vector | UITK::#DarkMode | UITK::#Button_Toggle)
UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UITK::#AlignLeft | UITK::#Vector | UITK::#Border | UITK::#DarkMode)

UITK::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle", UITK::#Vector | UITK::#DarkMode)
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#AlignRight | UITK::#Vector | UITK::#DarkMode)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox", UITK::#Vector | UITK::#DarkMode)
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#AlignRight | UITK::#Vector | UITK::#DarkMode)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#ScrollBar_Vertical | UITK::#Vector | UITK::#DarkMode)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25, UITK::#Vector | UITK::#DarkMode)

UITK::Label(#PB_Any, 260, 20, 200, 20, "Label", UITK::#Vector | UITK::#DarkMode)
UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#AlignRight | UITK::#Vector | UITK::#DarkMode)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#AlignCenter | UITK::#Vector | UITK::#DarkMode)

Gadget = UITK::ScrollArea(#PB_Any, 260, 120, 200, 200, 300, 300, 10, UITK::#DarkMode | UITK::#Vector)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area", UITK::#Vector | UITK::#DarkMode | UITK::#AlignCenter)
CloseGadgetList()

Menu = UITK::FlatMenu(WindowID(Window), UITK::#DarkMode)
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 2")
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 3")
UITK::AddFlatMenuItem(Menu, 0, 0, "Item 1")
UITK::AddFlatMenuSeparator(Menu, -1)
UITK::AddFlatMenuItem(Menu, 0, -1, "Variable Viewer")
UITK::AddFlatMenuItem(Menu, 0, -1, "Compare Files/Folder")
UITK::AddFlatMenuItem(Menu, 0, -1, "Procedure Browser")

BindEvent(#PB_Event_RightClick, @ButtonEvent())

; UITK::SetAccessibilityMode(#True)
; OpenWindow(2, (Width - 1280) * 0.5 + 200, (Height - 720) * 0.5 + 100, 1280, 720, "UI Toolkit : Accessibility", #PB_Window_SystemMenu)
; UITK::Button(#PB_Any, 20, 20, 200, 40, "Button")
; UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#AlignRight | UITK::#Vector | UITK::#Button_Toggle)
; UITK::Button(#PB_Any, 20, 120, 200, 40, "Button left", UITK::#AlignLeft)
; 
; UITK::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle")
; UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#AlignRight)
; 
; UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
; Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#AlignRight)
; SetGadgetState(Gadget, #PB_Checkbox_Inbetween)
; 
; UITK::ScrollBar(#PB_Any, 213, 420, 17, 148, 0, 100, 25, UITK::#ScrollBar_Vertical | UITK::#Vector | UITK::#DarkMode)
; UITK::ScrollBar(#PB_Any, 20, 568, 193, 17, 0, 100, 25, UITK::#Vector | UITK::#DarkMode)
; 
; UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")
; UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#AlignRight)
; UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#AlignCenter)



Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		CloseWindow(Window)
		Delay(10)
		End
	EndIf
ForEver






; IDE Options = PureBasic 6.00 Beta 6 (Windows - x64)
; CursorPosition = 57
; FirstLine = 15
; Folding = -
; EnableXP