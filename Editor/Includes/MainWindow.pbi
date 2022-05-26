Module MainWindow
	EnableExplicit
	
	;{ Private variables, structures and constants
	#Window_Width = 1300
	#Window_Height = 800
	#RightPanel_Width = 280
	#Margin = 6
	#TopPanel_Height = 80
	
	Global Window, TreeGadget, PropertyBox, ComponantList, Canvas
	Global WindowContainer_Width, WindowContainer_Height
	Global CornerTLID, CornerTRID, CornerBLID, CornerBRID
	Global MenuFile, MenuEdit, MenuHelp
	
	Enumeration ; MenuItems
		;File
		#Menu_New
		#Menu_Open
		#Menu_Save
		#Menu_SaveAs
		#Menu_Preferences
		#Menu_Quit
		
		;Edit
		#Menu_Undo
		#Menu_Redo
		#Menu_ThemeEditor ;? Maybeeee? Maybe not? Dunno?
		
		;Help
		#Menu_Help
		#Menu_About
	EndEnumeration
	
	Enumeration
		#Tree
		#HList
	EndEnumeration
	
	Global Dim ImageArray(1,Project::#_Componant_Count)
	
	ImageArray(#Tree,Project::#Componant_Window) = CatchImage(#PB_Any, ?Tree_Window)
	ImageArray(#HList,Project::#Componant_Window) = CatchImage(#PB_Any, ?Componant_Window)
	
	ImageArray(#Tree,Project::#Componant_Checkbox) = CatchImage(#PB_Any, ?Tree_Checkbox)
	ImageArray(#HList,Project::#Componant_Checkbox) = CatchImage(#PB_Any, ?Componant_Checkbox)
	
	ImageArray(#Tree,Project::#Componant_Text) = CatchImage(#PB_Any, ?Tree_Text)
	ImageArray(#HList,Project::#Componant_Text) = CatchImage(#PB_Any, ?Componant_Text)
	
	ImageArray(#Tree,Project::#Componant_Button) = CatchImage(#PB_Any, ?Tree_Button)
	ImageArray(#HList,Project::#Componant_Button) = CatchImage(#PB_Any, ?Componant_Button)
	
	ImageArray(#Tree,Project::#Componant_Toggle) = CatchImage(#PB_Any, ?Tree_Toggle)
	ImageArray(#HList,Project::#Componant_Toggle) = CatchImage(#PB_Any, ?Componant_Toggle)
	;}
	
	;{ Private procedures declaration
	Declare RedrawCanvas()
	Declare ROTATE_90(image, dir) ;From https://www.purebasic.fr/english/viewtopic.php?t=58231 . Until I figure out how vector rotation is supposed to work.
	Declare PopulateProperties(Type, *Data)
	;}
	
	;{ Import from UI Toolkit to subclass the window
	#WM_SYSMENU = $313
	#SizableBorder = 8
	#WindowButtonWidth = 45
	#WindowBarHeight = 30
	
	Structure Theme
		BackColor.l[4]
		FrontColor.l[4]
		ShadeColor.l[4]
		TextColor.l[4]
		LineColor.l[4]
		Special1.l[4]
		Special2.l[4]
		Special3.l[4]
		WindowColor.l
		Highlight.l
		CornerRadius.b
		WindowTitle.l
	EndStructure
	
	Structure ThemedWindow
		*Brush
		*OriginalProc
		
		Width.l
		Height.l
		MinWidth.l
		MinHeight.l
		MaxWidth.l
		MaxHeight.l
		
		SizeCursor.l
		Sizable.l
		
		ButtonClose.l
		ButtonMinimize.l
		ButtonMaximize.l
		
		Container.i
		
		Label.i
		LabelWidth.l
		LabelAlign.b
		
		MenuOffset.l
		List MenuList.i()
		
		Theme.Theme
	EndStructure
	
	Structure WindowContainer
		*Parent
		*OriginalProc
		sizeCursor.l
	EndStructure
	
	Procedure Window_Handler(hWnd, Msg, wParam, lParam)
		Protected *WindowData.ThemedWindow = GetProp_(hWnd, "UITK_WindowData"), cursor.POINT, OffsetX, OriginalProc, RightGadgetHeight
		
		Select Msg
			Case #WM_GETMINMAXINFO ;{
				Protected *mmi.MINMAXINFO = lParam
				Protected hMon = MonitorFromWindow_(hWnd, #MONITOR_DEFAULTTONEAREST)
				Protected mie.MONITORINFOEX\cbSize = SizeOf(mie)
				GetMonitorInfo_(hMon, mie)
				*mmi\ptMaxPosition\x = Abs(mie\rcWork\left - mie\rcMonitor\left)
				*mmi\ptMaxPosition\y = Abs(mie\rcWork\top - mie\rcMonitor\top)
				
				If *WindowData\MaxWidth > 0
					*mmi\ptMaxSize\x = *WindowData\MaxWidth
				Else
					*mmi\ptMaxSize\x = Abs(mie\rcWork\right - mie\rcWork\left)
				EndIf
				
				If *WindowData\MaxHeight > 0
					*mmi\ptMaxSize\y = *WindowData\MaxHeight
				Else
					*mmi\ptMaxSize\y = Abs(mie\rcWork\bottom - mie\rcWork\top) - 1
				EndIf
				
				*mmi\ptMinTrackSize\x = *WindowData\MinWidth
				*mmi\ptMinTrackSize\y = *WindowData\MinHeight
				ProcedureReturn 0
				;}
			Case #WM_NCCALCSIZE ;{
				ProcedureReturn 0
				;}
			Case #WM_CTLCOLORSTATIC, #WM_CTLCOLORBTN ;{
				SetBkMode_(wParam, #TRANSPARENT)
				ProcedureReturn *WindowData\Brush
				;}
			Case #WM_SIZE ;{
; 				Protected PreviousWidth = *WindowData\Width 
; 				Protected PreviousHeight = *WindowData\Height
; 				Protected Rect.RECT
				
				*WindowData\Width = lParam & $FFFF
				*WindowData\Height = (lParam >> 16) & $FFFF
				
				SendMessage_(hWnd, #WM_SETREDRAW, #False, 0)
				
				If *WindowData\ButtonClose
					OffsetX + #WindowButtonWidth
					ResizeGadget(*WindowData\ButtonClose, *WindowData\Width - OffsetX, #PB_Ignore, #PB_Ignore, #PB_Ignore)
				EndIf
				
				If *WindowData\ButtonMaximize
					OffsetX + #WindowButtonWidth
					ResizeGadget(*WindowData\ButtonMaximize, *WindowData\Width - OffsetX, #PB_Ignore, #PB_Ignore, #PB_Ignore)
				EndIf
				
				If *WindowData\ButtonMinimize
					OffsetX + #WindowButtonWidth
					ResizeGadget(*WindowData\ButtonMinimize, *WindowData\Width - OffsetX, #PB_Ignore, #PB_Ignore, #PB_Ignore)
				EndIf
				
				If *WindowData\LabelAlign = UITK::#HAlignRight
					SetWindowPos_(GadgetID(*WindowData\Label), 0, *WindowData\Width - OffsetX, 0, 0, 0, #SWP_NOSIZE)
				ElseIf *WindowData\LabelAlign = UITK::#HAlignCenter
					SetWindowPos_(GadgetID(*WindowData\Label), 0, (*WindowData\Width - *WindowData\LabelWidth) * 0.5, 0, 0, 0, #SWP_NOSIZE)
				EndIf
				
				WindowContainer_Width = *WindowData\Width - #RightPanel_Width - #Margin * 3
				WindowContainer_Height = *WindowData\Height - #WindowBarHeight - #TopPanel_Height - #Margin * 2
				RightGadgetHeight = (*WindowData\Height - #WindowBarHeight - #Margin * 2) * 0.5
				
				
				SetWindowPos_(GadgetID(Canvas), 0, 0, 0, WindowContainer_Width, WindowContainer_Height, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
				RedrawCanvas()
				ResizeGadget(ComponantList, #PB_Ignore, #PB_Ignore, WindowContainer_Width, #TopPanel_Height)
				ResizeGadget(PropertyBox, #Margin, RightGadgetHeight + #Margin + #WindowBarHeight - *WindowData\Height % 2, #RightPanel_Width, RightGadgetHeight)
				ResizeGadget(TreeGadget, #Margin, #WindowBarHeight, #RightPanel_Width, RightGadgetHeight)
				
				SendMessage_(hWnd, #WM_SETREDRAW, #True, 0)
				
; 				If PreviousWidth > *WindowData\Width ; Instead of erasing the whole window, I hoped to only erase part of the window background, but I can't get it to work. What am I doing wrong?
; 					Rect\top = #WindowBarHeight
; 					Rect\bottom = #WindowBarHeight + #TopPanel_Height
; 					Rect\left = *WindowData\Width - #Margin
; 					Rect\right = *WindowData\Width
; 					InvalidateRect_(hWnd, @Rect, #True) 
; 				EndIf
				
				RedrawWindow_(hWnd, 0, 0, #RDW_ERASE | #RDW_INVALIDATE) 
				
				;}
			Case #WM_NCACTIVATE ;{
				ProcedureReturn 1
				;}
			Case #WM_MOUSEMOVE ;{
				Protected posX = lParam & $FFFF
				Protected posY = (lParam >> 16) & $FFFF
				*WindowData\sizeCursor = 0
				
				If *WindowData\Sizable And IsZoomed_(hWnd) = 0
					If posX <= #SizableBorder
						If posY <= #SizableBorder
							SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
							*WindowData\sizeCursor = #HTTOPLEFT
						ElseIf posY >= *WindowData\Height - #SizableBorder
							SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
							*WindowData\sizeCursor = #HTBOTTOMLEFT
						Else
							SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
							*WindowData\sizeCursor = #HTLEFT
						EndIf
					ElseIf posX >= *WindowData\Width - #SizableBorder
						If posY >= *WindowData\Height - #SizableBorder
							SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
							*WindowData\sizeCursor = #HTBOTTOMRIGHT
						Else
							SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
							*WindowData\sizeCursor = #HTRIGHT
						EndIf
					ElseIf posY <= #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
						*WindowData\sizeCursor = #HTTOP
					ElseIf posY >= *WindowData\Height - #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
						*WindowData\sizeCursor = #HTBOTTOM
					EndIf
				EndIf
				;}
			Case #WM_LBUTTONDBLCLK ;{
				If cursor\y <= #WindowBarHeight And *WindowData\sizeCursor = 0
					If IsZoomed_(hWnd)
						ShowWindow_(hWnd, #SW_RESTORE)
					Else
						ShowWindow_(hWnd, #SW_MAXIMIZE)
					EndIf
				EndIf
				
				;}
			Case #WM_LBUTTONDOWN ;{
				GetCursorPos_(cursor.POINT)
				MapWindowPoints_(0, hWnd, cursor, 1)
				
				If cursor\y <= #WindowBarHeight And *WindowData\sizeCursor = 0
					SendMessage_(hWnd, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
				EndIf
				
				Select *WindowData\sizeCursor
					Case #HTTOPLEFT, #HTBOTTOMRIGHT
						SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
						SendMessage_(hWnd, #WM_NCLBUTTONDOWN, *WindowData\sizeCursor, 0)
					Case #HTTOP, #HTBOTTOM
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
						SendMessage_(hWnd, #WM_NCLBUTTONDOWN, *WindowData\sizeCursor, 0)
					Case #HTTOPRIGHT, #HTBOTTOMLEFT
						SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
						SendMessage_(hWnd, #WM_NCLBUTTONDOWN, *WindowData\sizeCursor, 0)
					Case #HTLEFT, #HTRIGHT
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
						SendMessage_(hWnd, #WM_NCLBUTTONDOWN, *WindowData\sizeCursor, 0)
				EndSelect
				;}
			Case #WM_LBUTTONUP ;{
				Select *WindowData\sizeCursor
					Case #HTTOPLEFT, #HTBOTTOMRIGHT
						SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
					Case #HTTOP, #HTBOTTOM
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
					Case #HTTOPRIGHT, #HTBOTTOMLEFT
						SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
					Case #HTLEFT, #HTRIGHT
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
				EndSelect
				;}
		EndSelect
		
		ProcedureReturn CallWindowProc_(*WindowData\OriginalProc, hWnd, Msg, wParam, lParam)
	EndProcedure
	;}
	
	; Macro
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows ; Fix color
		Macro FixColor(Color)
			RGB(Blue(Color), Green(Color), Red(Color))
		EndMacro
	CompilerElse
		Macro FixColor(Color)
			Color
		EndMacro
	CompilerEndIf
	
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows ; Set Alpha
		Macro SetAlpha(Color, Alpha)
			Alpha << 24 + Color
		EndMacro
	CompilerElse
		Macro SetAlpha(Color, Alpha) ; Not tested...
			Color << 8 + Alpha
		EndMacro
	CompilerEndIf
	
	; Public procedures
	Procedure Open()
		Protected *WindowData.ThemedWindow
		Protected Height, Width
		Window = UITK::Window(#PB_Any, 0, 0, #Window_Width, #Window_Height, General::#AppName, General::ColorMode | #PB_Window_SizeGadget | UITK::#Window_CloseButton | UITK::#Window_MaximizeButton | UITK::#Window_MinimizeButton | #PB_Window_ScreenCentered | #PB_Window_Invisible)
		UITK::SetWindowIcon(Window, ImageID(CatchImage(#PB_Any, ?Icon)))
		UITK::SetWindowBounds(Window, 1200, 700, -1, -1)
		Height = WindowHeight(Window) - #WindowBarHeight
		Width = WindowWidth(Window)
		
		CornerTLID = CatchImage(#PB_Any, ?Corner)
		CornerTRID = CopyImage(CornerTLID, #PB_Any)
		ROTATE_90(CornerTRID, 1)
		CornerBRID = CopyImage(CornerTRID, #PB_Any)
		ROTATE_90(CornerBRID, 1)
		CornerBLID = CopyImage(CornerBRID, #PB_Any)
		ROTATE_90(CornerBLID, 1)
		
		CornerTLID = ImageID(CornerTLID)
		CornerTRID = ImageID(CornerTRID)
		CornerBRID = ImageID(CornerBRID)
		CornerBLID = ImageID(CornerBLID)
		
		*WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
		
		CloseGadgetList()
		FreeGadget(*WindowData\Container)
		
		TreeGadget = UITK::Tree(#PB_Any, #Margin, #WindowBarHeight, #RightPanel_Width, 20)
		SetGadgetAttribute(TreeGadget, UITK::#Attribute_CornerRadius, 5)
		SetGadgetColor(TreeGadget, UITK::#Color_Parent, SetAlpha(UITK::WindowGetColor(Window, UITK::#Color_WindowBorder), 255))
		
		
		PropertyBox = UITK::PropertyBox(#PB_Any, #Margin, 1, 20, 20)
		SetGadgetAttribute(PropertyBox, UITK::#Attribute_CornerRadius, 5)
		SetGadgetColor(PropertyBox, UITK::#Color_Parent, SetAlpha(UITK::WindowGetColor(Window, UITK::#Color_WindowBorder), 255))
		
		ComponantList = UITK::HorizontalList(#PB_Any, #RightPanel_Width + #Margin * 2, #WindowBarHeight, #RightPanel_Width, #TopPanel_Height)
		SetGadgetAttribute(ComponantList, UITK::#Attribute_CornerRadius, 5)
		SetGadgetColor(ComponantList, UITK::#Color_Parent, SetAlpha(UITK::WindowGetColor(Window, UITK::#Color_WindowBorder), 255))
		AddGadgetItem(ComponantList, -1, "Button", ImageID(ImageArray(#HList,Project::#Componant_Button)))
		AddGadgetItem(ComponantList, -1, "Checkbox", ImageID(ImageArray(#HList,Project::#Componant_Checkbox)))
		AddGadgetItem(ComponantList, -1, "Label", ImageID(ImageArray(#HList,Project::#Componant_Text)))
		AddGadgetItem(ComponantList, -1, "Toggle", ImageID(ImageArray(#HList,Project::#Componant_Toggle)))
		
		Canvas = CanvasGadget(#PB_Any, #RightPanel_Width + #Margin * 2, #WindowBarHeight + #TopPanel_Height + #Margin, 20, 20, #PB_Canvas_Keyboard | #PB_Canvas_Container )
		
		SetWindowLongPtr_(WindowID(Window), #GWL_WNDPROC, @Window_Handler())
		
		MenuFile = UITK::FlatMenu(General::ColorMode)
		UITK::AddFlatMenuItem(MenuFile,#Menu_New, -1, "New window")
		UITK::AddFlatMenuItem(MenuFile,#Menu_Open, -1, "Open window...")
		UITK::AddFlatMenuItem(MenuFile,#Menu_Save, -1, "Save window")
		UITK::AddFlatMenuItem(MenuFile,#Menu_SaveAs, -1, "Save window as...")
		UITK::AddFlatMenuSeparator(MenuFile, -1)
		UITK::AddFlatMenuItem(MenuFile,#Menu_Preferences, -1, "Preferences...")
		UITK::AddFlatMenuSeparator(MenuFile, -1)
		UITK::AddFlatMenuItem(MenuFile,#Menu_Quit, -1, "Quit")
		
		MenuEdit = UITK::FlatMenu(General::ColorMode)
		UITK::AddFlatMenuItem(MenuEdit, #Menu_Undo, -1, "Undo")
		UITK::AddFlatMenuItem(MenuEdit, #Menu_Redo, -1, "Redo")
		
		MenuHelp = UITK::FlatMenu(General::ColorMode)
		UITK::AddFlatMenuItem(MenuHelp, #Menu_Help, -1, "Help...")
		UITK::AddFlatMenuItem(MenuHelp, #Menu_About, -1, "About...")
		
		UITK::AddWindowMenu(Window, MenuFile, "File")
		UITK::AddWindowMenu(Window, MenuEdit, "Edit")
		UITK::AddWindowMenu(Window, MenuHelp, "Help")
		
		Project::New()
		
		HideWindow(Window, #False)
	EndProcedure
	
	Procedure AddComponant(Type, Name.s, Position, Level)
		AddGadgetItem(TreeGadget, Position, Name, ImageID(ImageArray(#Tree, Type)), Level)
		
		Debug CountGadgetItems(TreeGadget)
		
		If CountGadgetItems(TreeGadget) = 1
			SetGadgetState(TreeGadget, 0)
			PopulateProperties(Project::#Componant_Window, 0)
		EndIf
	EndProcedure
	
	; Private procedures
	Procedure RedrawCanvas()
		StartVectorDrawing(CanvasVectorOutput(Canvas))
		AddPathBox(0,0, WindowContainer_Width, WindowContainer_Height)
		VectorSourceColor(SetAlpha(FixColor($36393F), 255))
		FillPath()
		DrawVectorImage(CornerTLID)
		MovePathCursor(WindowContainer_Width - 5,0)
		DrawVectorImage(CornerTRID)
		MovePathCursor(WindowContainer_Width - 5,WindowContainer_Height - 5)
		DrawVectorImage(CornerBRID)
		MovePathCursor(0,WindowContainer_Height - 5)
		DrawVectorImage(CornerBLID)
		StopVectorDrawing()
	EndProcedure
	
	Procedure ROTATE_90(image, dir)
		Protected a,b,c,e,f,h,s,w,x,y,ym,xm,tempImg,depth
		
		If IsImage(image) = 0 : ProcedureReturn 0 : EndIf
		
		StartDrawing(ImageOutput(image))
		w = OutputWidth()
		h = OutputHeight()
		f = DrawingBufferPixelFormat() & $7F
		StopDrawing()
		
		If f = #PB_PixelFormat_32Bits_RGB Or f = #PB_PixelFormat_32Bits_BGR
			depth = 32
		ElseIf f = #PB_PixelFormat_24Bits_RGB Or f = #PB_PixelFormat_24Bits_BGR
			depth = 24
		Else
			ProcedureReturn 0
		EndIf
		
		If w > h : s = w : Else : s = h : EndIf ; find the largest dimension
		
		StartDrawing(ImageOutput(image))
		If depth = 32 : DrawingMode(#PB_2DDrawing_AllChannels) : EndIf
		
		DrawImage(ImageID(image),0,0)
		
		ym = s/2-1 ; max y loop value
		xm = s/2-(s!1&1) ; max x value, subtract 1 if 's' is even
		s-1
		
		If dir <> 0 ; rotate right
			For y = 0 To ym
				For x = 0 To xm
					e = Point(x,y)
					a = s-x : Plot(x,y,Point(y,a))
					b = s-y : Plot(y,a,Point(a,b))
					c = s-a : Plot(a,b,Point(b,c))
					Plot(b,c,e)
				Next x
			Next y
		Else ; rotate left
			For y = 0 To ym
				For x = 0 To xm
					e = Point(x,y)
					a = s-y : Plot(x,y,Point(a,x))
					b = s-x : Plot(a,x,Point(b,a))
					c = s-a : Plot(b,a,Point(c,b))
					Plot(c,b,e)
				Next x
			Next y
		EndIf
		
		StopDrawing()
		
		ProcedureReturn 1
	EndProcedure
	
	Procedure PopulateProperties(Type, *Data)
		Select Type
			Case Project::#Componant_Window
				AddGadgetItem(PropertyBox, -1, "Window", 0, UITK::#PropertyBox_Title)
				AddGadgetItem(PropertyBox, -1, "Name", 0, UITK::#PropertyBox_Text)
				AddGadgetItem(PropertyBox, -1, "Name", 0, UITK::#PropertyBox_TextNumerical)
				
				AddGadgetItem(PropertyBox, -1, "Settings", 0, UITK::#PropertyBox_Title)
				
		EndSelect
	EndProcedure
	
	DataSection ;{
		Icon:
		IncludeBinary "../Media/Icon.png"
		Corner:
		IncludeBinary "../Media/Corner.png"
		
		; Componant icons
		Componant_Window:
		IncludeBinary "../Media/HList Icons/Window.png"
		
		Componant_Button:
		IncludeBinary "../Media/HList Icons/Button.png"
		
		Componant_Checkbox:
		IncludeBinary "../Media/HList Icons/Checkbox.png"
		
		Componant_Toggle:
		IncludeBinary "../Media/HList Icons/Toggle.png"
		
		Componant_Text:
		IncludeBinary "../Media/HList Icons/Text.png"
		
		
		; Tree incons
		Tree_Window:
		IncludeBinary "../Media/Tree Icons/Window.png"
		
		Tree_Button:
		IncludeBinary "../Media/Tree Icons/Button.png"
		
		Tree_Checkbox:
		IncludeBinary "../Media/Tree Icons/Checkbox.png"
		
		Tree_Toggle:
		IncludeBinary "../Media/Tree Icons/Toggle.png"
		
		Tree_Text:
		IncludeBinary "../Media/Tree Icons/Text.png"
		
		
	EndDataSection ;}
EndModule









































; IDE Options = PureBasic 6.00 Beta 7 (Windows - x64)
; CursorPosition = 486
; FirstLine = 51
; Folding = REYP0
; EnableXP