UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png")

Procedure ButtonEvent()
	UITK::ShowFlatMenu(Menu)
EndProcedure

Window0 = UITK::Window(#PB_Any, (Width - 1024) * 0.5 - 200, (Height - 600) * 0.5 - 100, 705, 600, "UI Toolkit : component showcase", UITK::#Window_CloseButton | #PB_Window_SizeGadget)

UITK::SetWindowIcon(Window0, ImageID(Image))

Gadget = UITK::Button(#PB_Any, 20, 20, 200, 40, "Button center")
UITK::SetGadgetImage(Gadget, ImageID(Image))
SetGadgetAttribute(Gadget, UITK::#Attribute_TextScale, 16)
Gadget = UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Button_Toggle)
UITK::SetGadgetImage(Gadget, ImageID(Image))
UITK::Disable(Gadget, #True)
Gadget = UITK::Button(#PB_Any, 20, 120, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", UITK::#HAlignLeft | UITK::#Border)
UITK::SetGadgetImage(Gadget, ImageID(Image))

UITK::Toggle(#PB_Any, 20, 185, 200, 38, "Toggle with a slightly longer description")
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

UITK::ScrollBar(#PB_Any, 213, 420, 7, 148, 0, 100, 25, UITK::#Gadget_Vertical)
UITK::ScrollBar(#PB_Any, 20, 568, 193, 7, 0, 100, 25)

Gadget = UITK::Label(#PB_Any, 260, 20, 200, 20, "Label")

UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)

UITK::ScrollArea(#PB_Any, 260, 120, 200, 180, 300, 300, 10)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area", UITK::#HAlignCenter)
CloseGadgetList()

Gadget = UITK::TrackBar(#PB_Any, 260, 330, 200, 40, 0, 100, UITK::#VAlignBottom)
AddGadgetItem(Gadget, 0, "x.5")
AddGadgetItem(Gadget, 13, "x1")
AddGadgetItem(Gadget, 100, "x4")
SetGadgetState(Gadget, 31)

Gadget = UITK::TrackBar(#PB_Any, 260, 390, 60, 180, 0, 4, UITK::#Gadget_Vertical | UITK::#HAlignRight)
AddGadgetItem(Gadget, 0, "Low")
AddGadgetItem(Gadget, 4, "High")

Gadget = UITK::VerticalList(#PB_Any,  500, 20, 200, 250, UITK::#Border)
SetGadgetAttribute(Gadget, UITK::#Attribute_SortItems, #True)
AddGadgetItem(Gadget, -1, "aItem 0")
AddGadgetItem(Gadget, -1, "Item 1")
AddGadgetItem(Gadget, -1, "bItem 2")
AddGadgetItem(Gadget, -1, "Item 3")
AddGadgetItem(Gadget, -1, "Item 4")
AddGadgetItem(Gadget, -1, "Item 5")
AddGadgetItem(Gadget, -1, "Item 6")
AddGadgetItem(Gadget, -1, "vItem 7")
AddGadgetItem(Gadget, -1, "Item 8")
AddGadgetItem(Gadget, -1, "Item 9")
AddGadgetItem(Gadget, -1, "cItem 10")
AddGadgetItem(Gadget, -1, "Item 11")
RemoveGadgetItem(Gadget, 3)

Gadget = UITK::Combo(#PB_Any, 500, 290, 200, 40, UITK::#Border)
AddGadgetItem(Gadget, -1, "Item 0")
AddGadgetItem(Gadget, -1, "Item 2")
AddGadgetItem(Gadget, -1, " Item 3", ImageID(Image))
AddGadgetItem(Gadget, -1, "Item ♥")
AddGadgetItem(Gadget, -1, "Item 5")
AddGadgetItem(Gadget, -1, "Item 6")
AddGadgetItem(Gadget, -1, "Item 7")
AddGadgetItem(Gadget, -1, "Item 8")
AddGadgetItem(Gadget, -1, "Item 9")
SetGadgetState(Gadget, 2)

Gadget = UITK::Container(#PB_Any, 500, 350, 200, 230)
CloseGadgetList()

Menu = UITK::FlatMenu(UITK::#LightMode)
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 2")
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 3")
UITK::AddFlatMenuItem(Menu, 0, 0, "Item 1")
UITK::AddFlatMenuSeparator(Menu, -1)
UITK::AddFlatMenuItem(Menu, 0, -1, "Variable Viewer")
UITK::AddFlatMenuItem(Menu, 0, -1, "Compare Files/Folder")
UITK::AddFlatMenuItem(Menu, 0, -1, "Procedure Browser")

UITK::AddWindowMenu(Window0, Menu, "File")

Window1 = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 961, 609, "UI Toolkit : dark theme", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter)
UITK::SetWindowIcon(Window1, ImageID(Image))

Gadget = UITK::Button(#PB_Any, 20, 20, 200, 40, "Button center", UITK::#Border)
SetGadgetAttribute(Gadget, UITK::#Attribute_CornerType, UITK::#Corner_Right)
UITK::SetGadgetImage(Gadget, ImageID(Image))
SetGadgetAttribute(Gadget, UITK::#Attribute_TextScale, 16)
Gadget = UITK::Button(#PB_Any, 20, 70, 200, 40, "Toggle button right", UITK::#HAlignRight | UITK::#Button_Toggle)
UITK::SetGadgetImage(Gadget, ImageID(Image))
UITK::Disable(Gadget, #True)
Gadget = UITK::Button(#PB_Any, 20, 120, 200, 40, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", UITK::#HAlignLeft | UITK::#Border)
UITK::SetGadgetImage(Gadget, ImageID(Image))

UITK::Toggle(#PB_Any, 20, 185, 200, 38, "Toggle with a slightly longer description")
UITK::Toggle(#PB_Any, 20, 230, 200, 28, "Toggle aligned right", UITK::#HAlignRight)

UITK::CheckBox(#PB_Any, 20, 310, 200, 28, "Checkbox")
Gadget = UITK::CheckBox(#PB_Any, 20, 350, 200, 28, "Checkbox aligned right", UITK::#HAlignRight)
SetGadgetState(Gadget, #PB_Checkbox_Inbetween)

Gadget = UITK::Container(#PB_Any, 20, 395, 200, 195)
CloseGadgetList()

Gadget = UITK::Label(#PB_Any, 260, 20, 200, 20, "Label", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 260, 50, 200, 20, "Label to the right", UITK::#HAlignRight)
UITK::Label(#PB_Any, 260, 80, 200, 20, "Label centered", UITK::#HAlignCenter)

UITK::ScrollArea(#PB_Any, 260, 120, 200, 210, 300, 300, 10)
UITK::Label(#PB_Any, 50, 145, 200, 20, "Inside the scroll area",  UITK::#HAlignCenter)
CloseGadgetList()

Gadget = UITK::TrackBar(#PB_Any, 260, 353, 200, 40, 0, 100,  UITK::#VAlignTop | UITK::#Trackbar_ShowState)
AddGadgetItem(Gadget, 0, "x.5")
AddGadgetItem(Gadget, 13, "x1")
AddGadgetItem(Gadget, 100, "x4")
SetGadgetState(Gadget, 31)

Gadget = UITK::TrackBar(#PB_Any, 260, 413, 60, 180, 0, 4,  UITK::#Gadget_Vertical)
AddGadgetItem(Gadget, 0, "Low")
AddGadgetItem(Gadget, 4, "High")

Gadget = UITK::VerticalList(#PB_Any,  500, 20, 200, 200, UITK::#Border | UITK::#ReOrder)
AddGadgetItem(Gadget, -1, "Item 0")
AddGadgetItem(Gadget, -1, "Item 1", ImageID(Image))
AddGadgetItem(Gadget, -1, "Item 2")
AddGadgetItem(Gadget, -1, "Item 3")
AddGadgetItem(Gadget, -1, "Item 4")
AddGadgetItem(Gadget, -1, "Item 5")
AddGadgetItem(Gadget, -1, "Item 6")
AddGadgetItem(Gadget, -1, "Item 7")
AddGadgetItem(Gadget, -1, "Item 8")
AddGadgetItem(Gadget, -1, "Item 9")
AddGadgetItem(Gadget, -1, "Item 10")
AddGadgetItem(Gadget, -1, "Item 11")
RemoveGadgetItem(Gadget, 3)

Gadget = UITK::Radio(#PB_Any, 740, 20, 200, 28, "Radio 1", "Exemple group", UITK::#HAlignRight)
Gadget = UITK::Radio(#PB_Any, 740, 60, 200, 28, "Radio 2", "Exemple group", UITK::#HAlignRight)
Gadget = UITK::Radio(#PB_Any, 740, 100, 200, 28, "Radio 3", "Exemple group", UITK::#HAlignRight)
Gadget = UITK::Radio(#PB_Any, 740, 140, 200, 28, "Radio 4", "Exemple group", UITK::#HAlignRight)

Gadget = UITK::Combo(#PB_Any, 740, 180, 200, 40, UITK::#Border)
AddGadgetItem(Gadget, -1, "Item 0")
AddGadgetItem(Gadget, -1, "Item 2")
AddGadgetItem(Gadget, -1, "Item 3", ImageID(Image))
AddGadgetItem(Gadget, -1, "Item ♥")
AddGadgetItem(Gadget, -1, "Item 5")
AddGadgetItem(Gadget, -1, "Item 6")
AddGadgetItem(Gadget, -1, "Item 7")
AddGadgetItem(Gadget, -1, "Item 8")
AddGadgetItem(Gadget, -1, "Item 9")
SetGadgetState(Gadget, 2)

Gadget = UITK::Library(#PB_Any, 500, 250, 440, 340, UITK::#Border)

Menu = UITK::FlatMenu(UITK::#DarkMode)
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 2")
UITK::AddFlatMenuItem(Menu, 0, -1, "Item 3", ImageID(Image))
UITK::AddFlatMenuItem(Menu, 0, 0, "Item 1")
UITK::AddFlatMenuSeparator(Menu, -1)
UITK::AddFlatMenuItem(Menu, 0, -1, "Variable Viewer")
UITK::AddFlatMenuItem(Menu, 0, -1, "Compare Files/Folder")
UITK::AddFlatMenuItem(Menu, 0, -1, "Procedure Browser")

BindEvent(#PB_Event_RightClick, @ButtonEvent())

UITK::AddWindowMenu(Window1, Menu, "File")
UITK::AddWindowMenu(Window1, Menu, "Edit")

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		Result = 0
		
		phandle = OpenProcess_(#PROCESS_TERMINATE, #False, GetCurrentProcessId_()) ;< I clearly have issues with my windows, but killing the process is a valid workaround for my own ineptitude.
		TerminateProcess_(phandle, @Result)
		End
	EndIf
ForEver

; IDE Options = PureBasic 6.00 Beta 7 (Windows - x64)
; CursorPosition = 172
; FirstLine = 114
; Folding = +
; EnableXP