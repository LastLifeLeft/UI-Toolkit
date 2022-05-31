Module Project
	EnableExplicit
	
	Structure Project
		Path.s
	EndStructure
	
	Global Project.Project
	
	
	Procedure Load(Path.s)
		
	EndProcedure
	
	Procedure Save(Path.s = "")
		
	EndProcedure
	
	Procedure New()
		MainWindow::AddComponant(#Componant_Window, "Window", 0, 0)
	EndProcedure
	
	Procedure Undo()
		
	EndProcedure
	
	Procedure Redo()
		
	EndProcedure
	
EndModule
; IDE Options = PureBasic 6.00 Beta 7 (Windows - x64)
; CursorPosition = 16
; Folding = --
; EnableXP