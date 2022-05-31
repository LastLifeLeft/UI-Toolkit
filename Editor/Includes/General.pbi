DeclareModule General
	#AppName = "UITK Edit"
	
	Global ColorMode = UITK::#DarkMode
	
EndDeclareModule

DeclareModule MainWindow
	Declare Open()
	Declare AddComponant(Type, Name.s, Position, Level)
EndDeclareModule

DeclareModule Project
	Enumeration ;Componant
		#Componant_Window
		#Componant_Toggle
		#Componant_Text
		#Componant_Checkbox
		#Componant_Button
		
		#_Componant_Count
	EndEnumeration
	
	Declare Load(Path.s)
	Declare Save(Path.s = "")
	Declare New()
	Declare Undo()
	Declare Redo()
EndDeclareModule

Module General
	UsePNGImageDecoder()
	UseJPEGImageDecoder()
	UseJPEG2000ImageDecoder()
	UseTGAImageDecoder()
	UseTIFFImageDecoder()
	
EndModule


; IDE Options = PureBasic 6.00 Beta 7 (Windows - x64)
; CursorPosition = 8
; Folding = -
; EnableXP