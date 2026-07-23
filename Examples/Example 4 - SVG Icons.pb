IncludeFile "../Library/UI-Toolkit.pbi"

Window = UITK::Window(#PB_Any, 0, 0, 360, 150, "SVG icons", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#Window_ScreenCentered)

UndoSmall = UITK::LoadSvgIcon("../Media/undo.svg", 18, RGB($F0, $F0, $F0))
RedoSmall = UITK::LoadSvgIcon("../Media/redo.svg", 18, RGB($F0, $F0, $F0))

UndoBig   = UITK::CatchSvgIcon(?UndoSvg, ?UndoSvgEnd - ?UndoSvg, 26, RGB($78, $C8, $FF))
RedoBig   = UITK::CatchSvgIcon(?RedoSvg, ?RedoSvgEnd - ?RedoSvg, 26, RGB($78, $C8, $FF))

BtnUndo = UITK::Button(#PB_Any, 20, 20, 150, 36, "Undo", UITK::#Border)
UITK::SetGadgetImage(BtnUndo, ImageID(UndoSmall))
BtnRedo = UITK::Button(#PB_Any, 190, 20, 150, 36, "Redo", UITK::#Border)
UITK::SetGadgetImage(BtnRedo, ImageID(RedoSmall))

Bar = UITK::ToolBar(#PB_Any, 20, 76, 150, 34, UITK::#Border)
AddGadgetItem(Bar, -1, "Undo", ImageID(UndoBig), 0)
AddGadgetItem(Bar, -1, "Redo", ImageID(RedoBig), 0)

Status = UITK::Label(#PB_Any, 190, 82, 150, 24, "", UITK::#DarkMode)

Repeat : Until WaitWindowEvent() = #PB_Event_CloseWindow

DataSection
	UndoSvg:
	IncludeBinary "../Media/undo.svg"
	UndoSvgEnd:
	RedoSvg:
	IncludeBinary "../Media/redo.svg"
	RedoSvgEnd:
EndDataSection
; IDE Options = PureBasic 6.40 (Windows - x64)
; CursorPosition = 29
; EnableXP
; DPIAware