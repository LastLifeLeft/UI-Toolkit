; Phase 3 verification: confirm GTK destroy hook actually clears UITK_PropMap.
; Build:  pbcompiler _phase3_cleanup_test.pb --output _phase3_cleanup_test
; Run:    ./_phase3_cleanup_test  (prints map size at three checkpoints, then exits)

IncludeFile "../Library/UI-Toolkit.pbi"

CompilerIf #PB_Compiler_OS <> #PB_OS_Windows
	Macro ReportMapSize(Label)
		PrintN(Label + ": map size = " + Str(UITK::_Linux_PropMapSize()))
	EndMacro
CompilerElse
	Macro ReportMapSize(Label)
		PrintN(Label + ": (skipped, UITK_PropMap is Linux-only)")
	EndMacro
CompilerEndIf

OpenConsole()

OpenWindow(0, 100, 100, 400, 200, "Phase 3 Cleanup Test", #PB_Window_SystemMenu)

ReportMapSize("0. before any UITK gadget")

; Combo calls UITK::SetProp_ twice (window + canvas). Should add 2 entries.
ComboGadget = UITK::Combo(#PB_Any, 20, 20, 200, 30)

ReportMapSize("1. after creating a UITK::Combo")

FreeGadget(ComboGadget)

; Pump pending GTK events so the destroy signal handlers actually fire.
While WindowEvent() : Wend

ReportMapSize("2. after FreeGadget + WindowEvent pump")

CloseWindow(0)

; Pump again so the window's children (and any straggler props) clean up.
While WindowEvent() : Wend

ReportMapSize("3. after CloseWindow + pump")

PrintN("done — press Enter to exit")
Input()
CloseConsole()
End
