UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png"), LibraryImageID = ImageID(LoadImage(#PB_Any, "Tiled.png"))

Window = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 961, 609, "UI Toolkit : dark theme", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter | #PB_Window_Invisible)
UITK::SetWindowIcon(Window, ImageID(Image))
Gadget = UITK::PropertyBox(#PB_Any, 20, 20, 280, 280, UITK::#Border)
AddGadgetItem(Gadget, -1, "Title", 0, UITK::#PropertyBox_Title)
AddGadgetItem(Gadget, -1, "Text", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Color", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Combo", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Another Title", 0, UITK::#PropertyBox_Title)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)
AddGadgetItem(Gadget, -1, "Even moar entries", 0, UITK::#PropertyBox_Text)

Gadget = UITK::Tree(#PB_Any, 20, 320, 280, 270, UITK::#Border)

For a = 0 To 10
	AddGadgetItem (Gadget, -1, "Normal Item "+Str(a), 0, 0)
	AddGadgetItem (Gadget, -1, "Node "+Str(a), 0, 0)		
	AddGadgetItem(Gadget, -1, "Sub-Item 1", 0, 1)			
	AddGadgetItem(Gadget, -1, "Sub-Item 2", 0, 1)
	AddGadgetItem(Gadget, -1, "Sub-Sub-Item 1", 0, 2)
	AddGadgetItem(Gadget, -1, "Sub-Sub-Item 2", 0, 2)
	AddGadgetItem(Gadget, -1, "Sub-Sub-Item 3", 0, 2)
	AddGadgetItem(Gadget, -1, "Sub-Item 3", 0, 1)
	AddGadgetItem(Gadget, -1, "Sub-Item 4", 0, 1)
	AddGadgetItem (Gadget, -1, "File "+Str(a), 0, 0) ; sublevel 0 again
Next

a = 11
AddGadgetItem(Gadget, -1, "Normal Item with long text and an image", ImageID(Image), 0)
AddGadgetItem(Gadget, -1, "Node "+Str(a), 0, 0)		
AddGadgetItem(Gadget, -1, "Sub-Item 1", 0, 1)			
AddGadgetItem(Gadget, -1, "Sub-Item 2", 0, 1)
AddGadgetItem(Gadget, -1, "Sub-Sub-Item 1", 0, 2)
AddGadgetItem(Gadget, -1, "Sub-Sub-Item 2", 0, 2)
AddGadgetItem(Gadget, -1, "Sub-Sub-Item 3", 0, 2)

HideWindow(Window, #False)

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		Result = 0
		phandle = OpenProcess_(#PROCESS_TERMINATE, #False, GetCurrentProcessId_()) ;< I clearly have issues with my windows, but killing the process is a valid workaround for my own ineptitude.
		TerminateProcess_(phandle, @Result)
		End
	EndIf
ForEver

; IDE Options = PureBasic 6.00 Beta 7 (Windows - x64)
; CursorPosition = 57
; EnableXP