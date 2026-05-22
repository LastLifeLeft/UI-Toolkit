; Minimal smoke test for the Linux port. Just one window + one button.
; If this crashes immediately, the issue is in the constructor / vtable wiring.

IncludeFile "../Library/UI-Toolkit.pbi"

OpenWindow(0, 100, 100, 400, 200, "UITK Linux Minimal", #PB_Window_SystemMenu)
UITK::Button(0, 20, 20, 200, 40, "I am a UITK button")

Repeat
  Select WaitWindowEvent()
    Case #PB_Event_CloseWindow : End
  EndSelect
ForEver
