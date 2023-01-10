UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png"), LibraryImageID = ImageID(LoadImage(#PB_Any, "Tiled.png"))

Window1 = UITK::Window(#PB_Any, (Width - 1024) * 0.5, (Height - 600) * 0.5, 961, 609, "UI Toolkit : it's fixin' time!", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignLeft)
UITK::SetWindowIcon(Window1, ImageID(Image))

UITK::VerticalList(0, 10, 10, 300, 500)
AddGadgetItem(0, -1, "Item 1")
AddGadgetItem(0, -1, "Item 2")
AddGadgetItem(0, -1, "Item 3")
AddGadgetItem(0, -1, "Item 4")

Repeat : WaitWindowEvent() : ForEver
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 11
; EnableXP
; DPIAware