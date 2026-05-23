; Linux cleanup-hook verification:
;   - Phase 3 path: the per-gadget UITK_PropMap entries get dropped when the
;     widget is destroyed via the GTK "destroy" signal.
;   - Phase 4-final path: the per-window ThemedWindow we AllocateStructureX in
;     UITK::Window is registered as an OWNED allocation via SetOwnedProp_, so
;     destroy-hook cleanup ALSO FreeStructure's it (no leak).
; Build:  pbcompiler _phase3_cleanup_test.pb --output _phase3_cleanup_test
; Run:    ./_phase3_cleanup_test  (prints map size at each checkpoint, then exits)

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

; ---- Phase 4-final: UITK::Window allocates a ThemedWindow via SetOwnedProp_.
; Cleanup hook should both DROP the map entry AND FreeStructure the allocation.
themedWin = UITK::Window(#PB_Any, 200, 200, 400, 200, "Owned-alloc Test", UITK::#DarkMode | UITK::#Window_CloseButton)
ReportMapSize("4. after creating a UITK::Window")
CloseWindow(themedWin)
While WindowEvent() : Wend
ReportMapSize("5. after CloseWindow + pump (no double-free, no leak)")

PrintN("done — press Enter to exit")
Input()
CloseConsole()
End
