Module MainWindow
	EnableExplicit
	
	;{ Private variables, structures and constants
	#Window_Width = 1300
	#Window_Height = 800
	#RightPanel_Width = 280
	#Margin = 6
	#TopPanel_Height = 100
	
	Global Window, TreeGadget, PropertyBox, ComponantList
	Global WindowContainer_Width, WindowContainer_Height
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
		Protected *WindowData.ThemedWindow = GetProp_(hWnd, "UITK_WindowData"), cursor.POINT, OffsetX, OriginalProc
		
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
				WindowContainer_Width = *WindowData\Width - #RightPanel_Width - #Margin * 2
				WindowContainer_Height = *WindowData\Height - #WindowBarHeight - #TopPanel_Height - #Margin
				
				
				SetWindowPos_(GadgetID(*WindowData\Container), 0, 0, 0, WindowContainer_Width, WindowContainer_Height, #SWP_NOMOVE | #SWP_NOZORDER)
				ResizeGadget(ComponantList, #PB_Ignore, #PB_Ignore, WindowContainer_Width - #Margin, #TopPanel_Height)
				ResizeGadget(PropertyBox, #Margin, (*WindowData\Height - #Margin) * 0.5 + #Margin, #RightPanel_Width, (*WindowData\Height - #Margin) * 0.5 - #Margin)
				ResizeGadget(TreeGadget, #Margin, #WindowBarHeight, #RightPanel_Width, (*WindowData\Height - #Margin) * 0.5 - #WindowBarHeight)
				
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
					If posX <= #SizableBorder And posY <= #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
						*WindowData\sizeCursor = #HTTOPLEFT
					ElseIf posX > #SizableBorder And posX <= *WindowData\Width - #SizableBorder And posY <= #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
						*WindowData\sizeCursor = #HTTOP
					ElseIf posX > *WindowData\Width - #SizableBorder And posY <= #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
						*WindowData\sizeCursor = #HTTOPRIGHT
					ElseIf posX > *WindowData\Width - #SizableBorder And posY > #SizableBorder And posY <= *WindowData\Height - #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
						*WindowData\sizeCursor = #HTRIGHT
					ElseIf posX <= #SizableBorder
						If posY >= *WindowData\Height - #SizableBorder
							SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
							*WindowData\sizeCursor = #HTBOTTOMLEFT
						Else
							SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
							*WindowData\sizeCursor = #HTLEFT
						EndIf
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
	
	Procedure WindowContainer_Handler(hWnd, Msg, wParam, lParam)
		Protected *ContainerData.WindowContainer = GetProp_(hWnd, "UITK_ContainerData"), *WindowData.ThemedWindow, posX, posY
		
		Select Msg
			Case #WM_MOUSEMOVE ;{
				*WindowData.ThemedWindow = GetProp_(*ContainerData\Parent, "UITK_WindowData")
				
				posX = lParam & $FFFF
				posY = (lParam >> 16) & $FFFF
				*ContainerData\sizeCursor = 0
				
				If *WindowData\Sizable
					If posY > WindowContainer_Height - #SizableBorder
						If posX > WindowContainer_Width - #SizableBorder 
							SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
							*ContainerData\sizeCursor = #HTBOTTOMRIGHT
						Else
							SetCursor_(LoadCursor_(0, #IDC_SIZENS))
							*ContainerData\sizeCursor = #HTBOTTOM
						EndIf
					ElseIf posX > WindowContainer_Width - #SizableBorder 
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
						*ContainerData\sizeCursor = #HTRIGHT
					EndIf
				EndIf
				;}
			Case #WM_LBUTTONDOWN ;{
				Select *ContainerData\sizeCursor
					Case #HTBOTTOMRIGHT
						SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
						SendMessage_(*ContainerData\Parent, #WM_NCLBUTTONDOWN, *ContainerData\sizeCursor, 0)
					Case #HTBOTTOM
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
						SendMessage_(*ContainerData\Parent, #WM_NCLBUTTONDOWN, *ContainerData\sizeCursor, 0)
					Case #HTBOTTOMLEFT
						SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
						SendMessage_(*ContainerData\Parent, #WM_NCLBUTTONDOWN, *ContainerData\sizeCursor, 0)
					Case #HTLEFT, #HTRIGHT
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
						SendMessage_(*ContainerData\Parent, #WM_NCLBUTTONDOWN, *ContainerData\sizeCursor, 0)
				EndSelect
				;}
		EndSelect
		
		ProcedureReturn CallWindowProc_(*ContainerData\OriginalProc, hWnd, Msg, wParam, lParam)
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
	
	;{ Private procedures declaration
	;}
	
	; Public procedures
	Procedure Open()
		Protected *WindowData.ThemedWindow
		Protected Height, Width
		Window = UITK::Window(#PB_Any, 0, 0, #Window_Width, #Window_Height, General::#AppName, General::ColorMode | #PB_Window_SizeGadget | UITK::#Window_CloseButton | #PB_Window_ScreenCentered | #PB_Window_Invisible)
		UITK::SetWindowBounds(Window, 1200, 700, -1, -1)
		Height = WindowHeight(Window) - #WindowBarHeight
		Width = WindowWidth(Window)
		
		*WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
		
		ResizeGadget(*WindowData\Container, #RightPanel_Width + #Margin * 2, #WindowBarHeight + #TopPanel_Height + #Margin, Width - #RightPanel_Width - #Margin * 2, Height - #TopPanel_Height - #Margin)
		CloseGadgetList()
		
		TreeGadget = UITK::Tree(#PB_Any, #Margin, #WindowBarHeight, #RightPanel_Width, (Height - #Margin) * 0.5)
		SetGadgetAttribute(TreeGadget, UITK::#Attribute_CornerRadius, 5)
		SetGadgetColor(TreeGadget, UITK::#Color_Parent, SetAlpha(UITK::WindowGetColor(Window, UITK::#Color_WindowBorder), 255))
		
		PropertyBox = UITK::PropertyBox(#PB_Any, #Margin, (Height - #Margin) * 0.5 + #WindowBarHeight + #Margin, #RightPanel_Width, (Height - #Margin) * 0.5 - #Margin)
		SetGadgetAttribute(PropertyBox, UITK::#Attribute_CornerRadius, 5)
		SetGadgetColor(PropertyBox, UITK::#Color_Parent, SetAlpha(UITK::WindowGetColor(Window, UITK::#Color_WindowBorder), 255))
		
		ComponantList = UITK::HorizontalList(#PB_Any, #RightPanel_Width + #Margin * 2, #WindowBarHeight, Width - #RightPanel_Width - #Margin * 3, #TopPanel_Height)
		SetGadgetAttribute(ComponantList, UITK::#Attribute_CornerRadius, 5)
		SetGadgetColor(ComponantList, UITK::#Color_Parent, SetAlpha(UITK::WindowGetColor(Window, UITK::#Color_WindowBorder), 255))
		
		SetWindowLongPtr_(GadgetID(*WindowData\Container), #GWL_WNDPROC, @WindowContainer_Handler())
		SetWindowLongPtr_(WindowID(Window), #GWL_WNDPROC, @Window_Handler())
		HideWindow(Window, #False)
	EndProcedure
	
	; Private procedures
	
	
EndModule

















































; IDE Options = PureBasic 6.00 Beta 7 (Windows - x86)
; CursorPosition = 332
; FirstLine = 78
; Folding = HCgt-
; EnableXP