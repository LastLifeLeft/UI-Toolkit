UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global Gadget, Menu,Image = LoadImage(#PB_Any, "Logo.png"), LibraryImageID = ImageID(LoadImage(#PB_Any, "Tiled.png"))
Global TitleFont = FontID(LoadFont(#PB_Any, "Calibry", 9, #PB_Font_HighQuality | #PB_Font_Bold))

Window1 =  UITK::Window(#PB_Any, 0, 0, 1000, 600, "UI Toolkit : it's fixin' time!", UITK::#Window_ScreenCentered | UITK::#HAlignLeft | UITK::#Window_CloseButton | UITK::#DarkMode)

UITK::SetWindowIcon(Window1, ImageID(Image))

UITK::ScrollBar(0, 10, 10, 7, 200, 0, 300, 200, UITK::#Gadget_Vertical) 

Repeat : WaitWindowEvent() : ForEver
; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 15
; EnableXP
; DPIAware