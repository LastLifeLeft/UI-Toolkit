UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png"), LibraryImageID = ImageID(LoadImage(#PB_Any, "Tiled.png"))

Window = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 961, 609, "UI Toolkit : dark theme", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter)
UITK::SetWindowIcon(Window, ImageID(Image))
Gadget = UITK::PropertiesBox(#PB_Any, 20, 20, 320, 400, UITK::#Border)
AddGadgetItem(Gadget, -1, "Title", 0, UITK::#PropertiesBox_Title)
AddGadgetItem(Gadget, -1, "Text", 0, UITK::#PropertiesBox_Text)
AddGadgetItem(Gadget, -1, "Color", 0, UITK::#PropertiesBox_Text)
AddGadgetItem(Gadget, -1, "Combo", 0, UITK::#PropertiesBox_Text)
AddGadgetItem(Gadget, -1, "Another Title", 0, UITK::#PropertiesBox_Title)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertiesBox_Text)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertiesBox_Text)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertiesBox_Text)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertiesBox_Text)

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		Result = 0
		phandle = OpenProcess_(#PROCESS_TERMINATE, #False, GetCurrentProcessId_()) ;< I clearly have issues with my windows, but killing the process is a valid workaround for my own ineptitude.
		TerminateProcess_(phandle, @Result)
		End
	EndIf
ForEver

; IDE Options = PureBasic 6.00 Beta 7 (Windows - x86)
; CursorPosition = 20
; EnableXP