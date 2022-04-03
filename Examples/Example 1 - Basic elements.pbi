IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)



; UIToolkit::Window(#PB_Any, (Width - 1280) * 0.5 - 200, (Height - 720) * 0.5 - 100, 1280, 720, "UI Toolkit : showcase raster", UIToolkit::#Window_CloseButton)
; UIToolkit::Button(#PB_Any, 20, 20, 200, 40, "Button")
; UIToolkit::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UIToolkit::#AlignRight | UIToolkit::#Button_Toggle)
; UIToolkit::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UIToolkit::#AlignLeft | UIToolkit::#Border)
; 
; UIToolkit::Toggle(#PB_Any, 20, 200, 200, 28, "Toggle")
; UIToolkit::Toggle(#PB_Any, 20, 240, 200, 28, "Toggle aligned right", UIToolkit::#AlignRight)
; 
; UIToolkit::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
; Gadget = UIToolkit::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UIToolkit::#AlignRight)
; SetGadgetState(Gadget, #PB_Checkbox_Inbetween)
; 
; UIToolkit::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UIToolkit::#ScrollBar_Vertical)
; UIToolkit::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25)
; 
; UIToolkit::Label(#PB_Any, 260, 20, 200, 20, "Label")
; UIToolkit::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UIToolkit::#AlignRight)
; UIToolkit::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UIToolkit::#AlignCenter)



Window = UIToolkit::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 1024, 600, "UI Toolkit : showcase dark vector", UIToolkit::#DarkMode | UIToolkit::#Window_CloseButton | UIToolkit::#AlignCenter)
UIToolkit::SetWindowBounds(Window, 1024, 630, 0, 0)
UIToolkit::Button(#PB_Any, 20, 20, 200, 40, "Button", UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#DarkMode | UIToolkit::#Button_Toggle)
UIToolkit::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UIToolkit::#AlignLeft | UIToolkit::#Vector | UIToolkit::#Border | UIToolkit::#DarkMode)

UIToolkit::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle", UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#DarkMode)

UIToolkit::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox", UIToolkit::#Vector | UIToolkit::#DarkMode)
Gadget = UIToolkit::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#DarkMode)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UIToolkit::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UIToolkit::#ScrollBar_Vertical | UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25, UIToolkit::#Vector | UIToolkit::#DarkMode)

UIToolkit::Label(#PB_Any, 260, 20, 200, 20, "Label", UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UIToolkit::#AlignCenter | UIToolkit::#Vector | UIToolkit::#DarkMode)



; UIToolkit::SetAccessibilityMode(#True)
; OpenWindow(2, (Width - 1280) * 0.5 + 200, (Height - 720) * 0.5 + 100, 1280, 720, "UI Toolkit : Accessibility", #PB_Window_SystemMenu)
; UIToolkit::Button(#PB_Any, 20, 20, 200, 40, "Button")
; UIToolkit::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#Button_Toggle)
; UIToolkit::Button(#PB_Any, 20, 120, 200, 40, "Button left", UIToolkit::#AlignLeft)
; 
; UIToolkit::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle")
; UIToolkit::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UIToolkit::#AlignRight)
; 
; UIToolkit::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
; Gadget = UIToolkit::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UIToolkit::#AlignRight)
; SetGadgetState(Gadget, #PB_Checkbox_Inbetween)
; 
; UIToolkit::ScrollBar(#PB_Any, 213, 420, 17, 148, 0, 100, 25, UIToolkit::#ScrollBar_Vertical | UIToolkit::#Vector | UIToolkit::#DarkMode)
; UIToolkit::ScrollBar(#PB_Any, 20, 568, 193, 17, 0, 100, 25, UIToolkit::#Vector | UIToolkit::#DarkMode)
; 
; UIToolkit::Label(#PB_Any, 260, 20, 200, 20, "Label")
; UIToolkit::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UIToolkit::#AlignRight)
; UIToolkit::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UIToolkit::#AlignCenter)



Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		CloseWindow(Window)
		Delay(10)
		End
; 		End
	EndIf
ForEver
; IDE Options = PureBasic 6.00 Beta 6 (Windows - x64)
; CursorPosition = 7
; EnableXP