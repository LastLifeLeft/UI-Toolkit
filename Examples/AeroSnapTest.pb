; Smoke test for Aero Snap on a sizable UITK window.
; Drag the title bar to a screen edge, should show snap preview and snap on release.
; Double-click the title bar, it should toggle maximize/restore.
; Win+Left/Right/Up/Down, it should snap natively.
; Drag from the resize edges, it should resize natively.

UsePNGImageDecoder()

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()

Global Window = UITK::Window(#PB_Any, 100, 100, 800, 500, "Aero Snap Test: drag me to a screen edge", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#Window_MaximizeButton | UITK::#Window_MinimizeButton | UITK::#Window_Sizable)

UITK::OpenWindowGadgetList(Window)
UITK::Label(#PB_Any, 20, 20, 760, 40, "If this window snaps to the screen edges when dragged, Aero Snap is back.", UITK::#DarkMode | UITK::#HAlignCenter)
UITK::Label(#PB_Any, 20, 80, 760, 40, "Try Win+Arrow, double-click title bar, drag from edges to resize.", UITK::#DarkMode | UITK::#HAlignCenter)

Repeat
  Select WaitWindowEvent()
    Case #PB_Event_CloseWindow : End
  EndSelect
ForEver
; IDE Options = PureBasic 6.40 (Linux - x64)
; CursorPosition = 14
; EnableXP
; DPIAware