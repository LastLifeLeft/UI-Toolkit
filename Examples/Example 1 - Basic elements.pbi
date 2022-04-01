IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

OpenWindow(0, (Width - 1024) * 0.5 - 200, (Height - 600) * 0.5 - 100, 1024, 600, "UI Toolkit : showcase raster", #PB_Window_SystemMenu)
UIToolkit::Button(#PB_Any, 20, 20, 200, 40, "Button")
UIToolkit::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UIToolkit::#AlignRight | UIToolkit::#Button_Toggle)
UIToolkit::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UIToolkit::#AlignLeft | UIToolkit::#Border)

UIToolkit::Toggle(#PB_Any, 20, 200, 200, 28, "Toggle")
UIToolkit::Toggle(#PB_Any, 20, 240, 200, 28, "Toggle aligned right", UIToolkit::#AlignRight)

UIToolkit::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UIToolkit::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UIToolkit::#AlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)



OpenWindow(1, (Width - 1024) * 0.5, (Height - 600) * 0.5, 1024, 600, "UI Toolkit : showcase dark vector", #PB_Window_SystemMenu)
SetWindowColor(1, $36312F)
UIToolkit::Button(#PB_Any, 20, 20, 200, 40, "Button", UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#DarkMode | UIToolkit::#Button_Toggle)
UIToolkit::Button(#PB_Any, 20, 120, 200, 40, "Button left & border", UIToolkit::#AlignLeft | UIToolkit::#Vector | UIToolkit::#Border | UIToolkit::#DarkMode)

UIToolkit::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle", UIToolkit::#Vector | UIToolkit::#DarkMode)
UIToolkit::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UIToolkit::#AlignRight | UIToolkit::#Vector |UIToolkit::#DarkMode)

UIToolkit::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox", UIToolkit::#Vector | UIToolkit::#DarkMode)
Gadget = UIToolkit::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UIToolkit::#AlignRight | UIToolkit::#Vector |UIToolkit::#DarkMode)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)



OpenWindow(2, (Width - 1024) * 0.5 + 200, (Height - 600) * 0.5 + 100, 1024, 600, "UI Toolkit : Accessibility", #PB_Window_SystemMenu)
UIToolkit::SetAccessibilityMode(#True)
UIToolkit::Button(#PB_Any, 20, 20, 200, 40, "Button")
UIToolkit::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UIToolkit::#AlignRight | UIToolkit::#Vector | UIToolkit::#Button_Toggle)
UIToolkit::Button(#PB_Any, 20, 120, 200, 40, "Button left", UIToolkit::#AlignLeft)

UIToolkit::Toggle(#PB_Any, 20, 190, 200, 28, "Toggle")
UIToolkit::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UIToolkit::#AlignRight)

UIToolkit::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UIToolkit::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UIToolkit::#AlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)



Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		End
	EndIf
ForEver
; IDE Options = PureBasic 6.00 Beta 5 (Windows - x64)
; CursorPosition = 41
; EnableXP