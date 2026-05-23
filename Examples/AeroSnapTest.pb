; Smoke test for a sizable UITK window.
;   - Windows: exercises the Phase-4a custom-titlebar path (WM_NCHITTEST +
;     DwmExtendFrameIntoClientArea give us real Aero Snap behavior).
;   - Linux:   exercises the native-chrome path (WM owns titlebar / borders /
;     buttons / snap / resize). Look should match GIMP / Inkscape / etc.
; In either case the window should support: drag-to-edge snap, double-click
; maximize, Win+arrow snap, and edge resize.

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