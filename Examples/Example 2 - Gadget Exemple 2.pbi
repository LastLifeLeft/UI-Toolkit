UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png"), SquaredImage = ImageID(LoadImage(#PB_Any, "Squared.png"))

Window = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 961, 609, "UI Toolkit : Light theme", UITK::#Window_CloseButton | UITK::#HAlignCenter | #PB_Window_Invisible)
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

Gadget = UITK::Tree(#PB_Any, 20, 320, 280, 270, UITK::#Border | UITK::#Tree_StraightLine)
EnableGadgetDrop(Gadget, #PB_Drop_Private, #PB_Drag_Move | #PB_Drag_Copy | #PB_Drag_Link, UITK::#Drag_HListItem)

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

VList1 = UITK::HorizontalList(#PB_Any, 320, 20, 621, 80, UITK::#Border | UITK::#Drag)
EnableGadgetDrop(VList1, #PB_Drop_Private, #PB_Drag_Move | #PB_Drag_Copy | #PB_Drag_Link, UITK::#Drag_HListItem)

For a = 0 To 10
	AddGadgetItem(VList1, -1, "Item " + a, SquaredImage, 2)
Next

VList2 = UITK::HorizontalList(#PB_Any, 320, 120, 621, 80, UITK::#Border | UITK::#Drag)
EnableGadgetDrop(VList2, #PB_Drop_Private, #PB_Drag_Move | #PB_Drag_Copy | #PB_Drag_Link, UITK::#Drag_HListItem)

Tab = UITK::Tab(#PB_Any, 320, 220, 621, 70)
AddGadgetItem(Tab, -1, "Prululu 1", ImageID(Image))
AddGadgetItem(Tab, -1, "Prululu 2", ImageID(Image))
AddGadgetItem(Tab, -1, "Prululu 3", ImageID(Image))
SetGadgetItemAttribute(Tab, 2, UITK::#Tab_Color, $FFFF00FF)

HideWindow(Window, #False)

Repeat
	Select WaitWindowEvent()
		Case #PB_Event_CloseWindow
			Result = 0
			phandle = OpenProcess_(#PROCESS_TERMINATE, #False, GetCurrentProcessId_()) ;< I clearly have issues with my windows, but killing the process is a valid workaround for my own ineptitude.
			TerminateProcess_(phandle, @Result)
			End
		Case #PB_Event_GadgetDrop
			; this is a bad example : you can drag from a gadget to itself, resulting in an empty item. Can't figure how to get the ID of the source of the drag through PB api.
			Select EventGadget()
				Case VList1
					state = GetGadgetState(VList2)
					AddGadgetItem(VList1, -1, GetGadgetItemText(VList2, state), UITK::GetGadgetItemImage(VList2, state))
					RemoveGadgetItem(VList2, state)
				Case VList2
					state = GetGadgetState(VList1)
					AddGadgetItem(VList2, -1, GetGadgetItemText(VList1, state), UITK::GetGadgetItemImage(VList1, state))
					RemoveGadgetItem(VList1, state)
			EndSelect
	EndSelect
ForEver

; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 15
; EnableXP
; DPIAware