DeclareModule UIToolkit
	;{ Private variables, structures and constants
	EnumerationBinary ; Gadget flags
		; General
		#Default
		#AlignCenter									; Center text
		#AlignLeft										; Align text left
		#AlignRight										; Align text right
		#Vector											; Gadget drawn in vector mode
		#Border											; Draw a border arround the gadget
		#DarkMode										; Use the dark color scheme
		
		; Special
		#Button_Toggle									; Creates a toggle button: one click pushes it, another will release it.
		#ScrollBar_Vertical 							; The scrollbar is vertical (instead of horizontal, which is the default).
	EndEnumeration
	
	Enumeration; Colors
		#Color_Back_Cold	= #PB_Gadget_FrontColor
		#Color_Front_Cold	= #PB_Gadget_BackColor 
		#Color_Line			= #PB_Gadget_LineColor 
		
		#Color_Back_Warm
		#Color_Back_Hot
		
		#Color_Front_Warm
		#Color_Front_Hot
		
		#Color_Parent										; The parent (window or container) color, used for rounded corners and stuff like that
	EndEnumeration
	;}
	
	;{ Public procedures declaration
	; Setters
	Declare SetAccessibilityMode(MouseState) 					; Enable or disable accessibility mode. If enabled, gadget falls back on to their default PB version, making them compatible with important features like screen readers or RTL languages.
	Declare SetGadgetColorScheme(Gadget, ThemeJson.s)		; Apply a complete color scheme at once
	
	; Getters
	Declare GetAccessibilityMode()							; Returns the current accessibility MouseState.
	Declare.s GetGadgetColorScheme(Gadget)					; Apply a complete color scheme at once
	
	; Window
	
	; Gadgets
	Declare Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags = #Default)
	
	; Misc 
	
	
	;}
	
EndDeclareModule

Module UIToolkit
	EnableExplicit
	
	;{ Macro
	Macro InitializeObject(GadgetType)
		*this = IsGadget(Gadget)
		*GadgetData = AllocateStructure(GadgetType#Data)
		CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
		*GadgetData\OriginalVT = *this\VT
		*this\VT = *GadgetData
		*GadgetData\Gadget = Gadget
		*GadgetData\ParentWindow = CurrentWindow()
		
		*GadgetData\Width = Width
		*GadgetData\Height = Height
		
		*GadgetData\Border = Bool(Flags & #Border)
		
		If Flags & #DarkMode
			CopyStructure(@DarkTheme, *GadgetData\Theme, Theme)
		Else
			CopyStructure(@DefaultTheme, *GadgetData\Theme, Theme)
		EndIf
		
		If Flags & #Vector
			*GadgetData\Vector = #True
			*GadgetData\Redraw = @GadgetType#_RedrawVector()
		Else
			*GadgetData\Redraw = @GadgetType#_Redraw()
		EndIf
		
		*GadgetData\FontID = DefaultFont
		
		*GadgetData\EventHandler = @GadgetType#_EventHandler()
		*GadgetData\VT\FreeGadget = @Default_FreeGadget()
		*GadgetData\VT\ResizeGadget = @Default_ResizeGadget()
		*GadgetData\VT\FreeGadget = @Default_FreeGadget()
		
		; Getters
		*GadgetData\VT\GetGadgetFont = @Default_GetFont()
		*GadgetData\VT\GetGadgetColor = @Default_GetColor()
		*GadgetData\VT\SetGadgetState = @Default_GetState()
		
		; Setters
		*GadgetData\VT\SetGadgetFont = @Default_SetFont()
		*GadgetData\VT\SetGadgetColor = @Default_SetColor()
		*GadgetData\VT\SetGadgetState = @Default_SetState()
		
		BindGadgetEvent(Gadget, @Default_EventHandle())
	EndMacro
	
	Macro RedrawObject()
		If *GadgetData\MetaGadget
			*GadgetData\Redraw(*this)
		ElseIf *GadgetData\Vector
			StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
			AddPathBox(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, #PB_Path_Default)
			ClipPath(#PB_Path_Preserve)
			VectorSourceColor(*GadgetData\Theme\WindowColor)
			FillPath()
			*GadgetData\Redraw(*this)
			If *GadgetData\Border
				AddPathBox(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, #PB_Path_Default)
				VectorSourceColor(*GadgetData\Theme\LineColor[*GadgetData\MouseState])
				StrokePath(2)
			EndIf
			StopVectorDrawing()
		Else
			StartDrawing(CanvasOutput(*GadgetData\Gadget))
			Box(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, *GadgetData\Theme\WindowColor)
			*GadgetData\Redraw(*this)
			If *GadgetData\Border
				DrawingMode(#PB_2DDrawing_Outlined )
				Box(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, *GadgetData\Theme\LineColor[*GadgetData\MouseState])
			EndIf
			StopDrawing()
		EndIf
	EndMacro
	
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
	
	Macro Floor(Number)
		Round(Number, #PB_Round_Down)
	EndMacro
	
	Macro Ceil(Number)
		Round(Number, #PB_Round_Up)
	EndMacro
	
	Macro BorderMargin
		TextHeight(\Text) * 0.5 * \Border
	EndMacro
	
	Macro VectorBorderMargin
		Floor(VectorTextHeight(\Text) * 0.5 * \Border)
	EndMacro
	;}
	
	;{ Private variables, structures and constants
	CompilerSelect #PB_Compiler_OS
		CompilerCase #PB_OS_Windows ;{
			Structure GadgetVT
				GadgetType.l
				SizeOf.l
				*GadgetCallback
				*FreeGadget
				*GetGadgetState
				*SetGadgetState
				*GetGadgetText
				*SetGadgetText
				*AddGadgetItem2
				*AddGadgetItem3
				*RemoveGadgetItem
				*ClearGadgetItemList
				*ResizeGadget
				*CountGadgetItems
				*GetGadgetItemState
				*SetGadgetItemState
				*GetGadgetItemText
				*SetGadgetItemText
				*OpenGadgetList2
				*GadgetX
				*GadgetY
				*GadgetWidth
				*GadgetHeight
				*HideGadget
				*AddGadgetColumn
				*RemoveGadgetColumn
				*GetGadgetAttribute
				*SetGadgetAttribute
				*GetGadgetItemAttribute2
				*SetGadgetItemAttribute2
				*SetGadgetColor
				*GetGadgetColor
				*SetGadgetItemColor2
				*GetGadgetItemColor2
				*SetGadgetItemData
				*GetGadgetItemData
				*GetRequiredSize
				*SetActiveGadget
				*GetGadgetFont
				*SetGadgetFont
				*SetGadgetItemImage
			EndStructure
			
			Structure PB_Gadget
				*Gadget
				*vt.GadgetVT
				UserData.i
				OldCallback.i
				Daten.i[4]
			EndStructure
			;}
		CompilerCase #PB_OS_Linux   ;{
			Structure GadgetVT
				SizeOf.l
				GadgetType.l
				*ActivateGadget
				*FreeGadget
				*GetGadgetState
				*SetGadgetState
				*GetGadgetText
				*SetGadgetText
				*AddGadgetItem2
				*AddGadgetItem3
				*RemoveGadgetItem
				*ClearGadgetItemList
				*ResizeGadget
				*CountGadgetItems
				*GetGadgetItemState
				*SetGadgetItemState
				*GetGadgetItemText
				*SetGadgetItemText
				*SetGadgetFont
				*OpenGadgetList2
				*AddGadgetColumn
				*GetGadgetAttribute
				*SetGadgetAttribute
				*GetGadgetItemAttribute2
				*SetGadgetItemAttribute2
				*RemoveGadgetColumn
				*SetGadgetColor
				*GetGadgetColor
				*SetGadgetItemColor2
				*GetGadgetItemColor2
				*SetGadgetItemData
				*GetGadgetItemData
				*GetGadgetFont
				*SetGadgetItemImage
				*HideGadget
			EndStructure
			
			Structure PB_Gadget
				*Gadget
				*GadgetContainer
				*vt.GadgetVT
				UserData.i
				Daten.i[4]
			EndStructure ;}
		CompilerCase #PB_OS_MacOS   ;{
			Structure PB_Gadget
				*Gadget
				*Container
				*Functions	; ??
				UserData.i
				WindowID.i
				Type.l
				Flags.l
			EndStructure
			CompilerError "MacOS isn't supported, sorry."
			;}
	CompilerEndSelect
	
	Enumeration ;Theme MouseState
		#Cold
		#Warm
		#Hot
		#Disabled
	EndEnumeration
	
	Enumeration ;Ordered Canvas event, starting from 0
		#LeftClick       	
		#RightClick      	
		#LeftDoubleClick 	
		#RightDoubleClick	
		#Focus           	
		#LostFocus       	
		#Resize 		 	
		#MouseEnter      	
		#MouseLeave      	
		#MouseMove       	
		#LeftButtonDown  	
		#LeftButtonUp    	
		#RightButtonDown 	
		#RightButtonUp   	
		#MiddleButtonDown	
		#MiddleButtonUp	
		#MouseWheel      	
		#KeyDown         	
		#KeyUp           	
		#Input           	
		
		#__EVENTSIZE
	EndEnumeration
	
	Structure Event
		EventType.l
		MouseX.l
		MouseY.l
	EndStructure
	
	Structure Theme
		BackColor.l[4]
		FrontColor.l[4]
		LineColor.l[4]
		WindowColor.l
	EndStructure
	
	Prototype Redraw(*this.PB_Gadget)
	Prototype EventHandler(*this.PB_Gadget, *Event.Event)
	
	Structure GadgetData
		VT.GadgetVT ;Must be the first element of this structure!
		*OriginalVT.GadgetVT
		Gadget.i
		*MetaGadget
		Vector.b
		MaterialIcon.b
		Border.b
		
		OriginX.i
		OriginY.i
		Width.i
		Height.i
		FontID.i
		
		State.i
		
		MouseState.b
		
		SupportedEvent.b[#__EVENTSIZE]
		
		TextAlignement.b
		
		Redraw.Redraw
		EventHandler.EventHandler
		Theme.Theme
		ParentWindow.i
	EndStructure
	
	Global AccessibilityMode = #False
	Global DefaultTheme.Theme, AltTheme.Theme, DarkTheme.Theme
	Global DefaultFont = FontID(LoadFont(#PB_Any, "Segoe UI", 9, #PB_Font_HighQuality))
	
	With DefaultTheme
		\WindowColor = SetAlpha(FixColor($F0F0F0), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($F0F0F0), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($D8E6F2), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($C0DCF3), 255)
		                    
		\LineColor[#Cold]		= SetAlpha(FixColor($ADADAD), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($90C8F6), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($90C8F6), 255)
		
		\FrontColor[#Cold] 		= SetAlpha(FixColor($000000), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($000000), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($000000), 255)
	EndWith
	
	With AltTheme
		\WindowColor = SetAlpha(FixColor($F0F0F0), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($DEDEDE), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($D8E6F2), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($C0DCF3), 255)
		                    
		\LineColor[#Cold]		= SetAlpha(FixColor($ADADAD), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($8D8D8D), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($FDFDFD), 255)
		
		
		\FrontColor[#Cold] 		= SetAlpha(FixColor($000000), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($000000), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($000000), 255)
	EndWith
	
	With DarkTheme
		\WindowColor			= SetAlpha(FixColor($2F3136), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($2F3136), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($44474C), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($54575C), 255)
		                    
		\LineColor[#Cold]		= SetAlpha(FixColor($7E8287), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($A2A3A5), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($A2A3A5), 255)
		
		\FrontColor[#Cold]	 	= SetAlpha(FixColor($FAFAFB), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($FFFFFF), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($FFFFFF), 255)
	EndWith
	;}
	
	; Procedures
	;{ General
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		Import ""
			PB_Object_EnumerateStart(Object)
			PB_Object_EnumerateNext(Object,*ID.Integer)
			PB_Object_EnumerateAbort(Object)
			PB_Window_Objects.l
		EndImport
	CompilerElse
		ImportC ""
			PB_Object_EnumerateStart(Object)
			PB_Object_EnumerateNext(Object,*ID.Integer)
			PB_Object_EnumerateAbort(Object)
			PB_Window_Objects.l
		EndImport
	CompilerEndIf
	
	Procedure DrawTextBlock()
		
	EndProcedure
	
	Procedure DrawVectorTextBlock()
		
	EndProcedure
	
	Procedure CurrentWindow()
		Protected Window =- 1
		PB_Object_EnumerateStart(PB_Window_Objects)
		If PB_Window_Objects
			While PB_Object_EnumerateNext(PB_Window_Objects, @Window)
				If WindowID(Window) = UseGadgetList(0)
					Break
				EndIf
			Wend
			PB_Object_EnumerateAbort(PB_Window_Objects) 
		EndIf
		
		ProcedureReturn Window
	EndProcedure
	
	Procedure Default_EventHandle()
		Protected Event.Event, Gadget = EventGadget(), *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		Select EventType()
			Case #PB_EventType_MouseEnter
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #MouseEnter
				
			Case #PB_EventType_MouseLeave
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #MouseLeave
				
			Case #PB_EventType_MouseMove
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #MouseMove
				
			Case #PB_EventType_MouseWheel
				Event\EventType = #MouseWheel
				
			Case #PB_EventType_LeftButtonDown
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #LeftButtonDown
				
			Case #PB_EventType_LeftButtonUp
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #LeftButtonUp
				
			Case #PB_EventType_LeftClick
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #LeftClick
				
			Case #PB_EventType_LeftDoubleClick
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #LeftDoubleClick
				
			Case #PB_EventType_RightButtonDown
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #RightButtonDown
				
			Case #PB_EventType_RightButtonUp
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #RightButtonUp
				
			Case #PB_EventType_RightClick
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #RightClick
				
			Case #PB_EventType_RightDoubleClick
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #RightDoubleClick
				
			Case #PB_EventType_MiddleButtonDown
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #MiddleButtonDown
				
			Case #PB_EventType_MiddleButtonUp
				Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
				Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
				Event\EventType = #MiddleButtonUp
				
			Case #PB_EventType_Focus
				Event\EventType = #Focus
				
			Case #PB_EventType_LostFocus
				Event\EventType = #LostFocus
				
			Case #PB_EventType_KeyDown
				Event\EventType = #KeyDown
				
			Case #PB_EventType_KeyUp
				Event\EventType = #KeyUp
				
			Case #PB_EventType_Input
				Event\EventType = #Input
				
			Case #PB_EventType_Resize
				Event\EventType = #Resize
				
			Default
				ProcedureReturn
		EndSelect
		
		If *GadgetData\SupportedEvent[Event\EventType]
			Event\MouseX = GetGadgetAttribute(Gadget, #PB_Canvas_MouseX)
			Event\MouseY = GetGadgetAttribute(Gadget, #PB_Canvas_MouseY)
			
			*GadgetData\EventHandler(*this, Event)
		EndIf
		
	EndProcedure
	
	Procedure Default_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		
		*this\vt = *GadgetData\OriginalVT
		FreeStructure(*GadgetData)
		CallFunctionFast(*this\vt\FreeGadget, *this)
	EndProcedure
	
	Procedure Default_DisableGadget(*This.PB_Gadget, MouseState) ; Wut? Doesn't exist?
		Protected *GadgetData.GadgetData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		DisableGadget(*GadgetData\Gadget, MouseState)
		*this\VT = *GadgetData
		
		RedrawObject()
	EndProcedure
	
	Procedure Default_ResizeGadget(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.GadgetData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			RedrawObject()
		EndWith
	EndProcedure
	
	; Getters
	Procedure SetAccessibilityMode(MouseState)
		AccessibilityMode = MouseState
	EndProcedure
	
	Procedure SetGadgetColorScheme(Gadget, ThemeJson.s)
	EndProcedure
	
	Procedure Default_GetFont(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\FontID
	EndProcedure
	
	Procedure Default_GetColor(*This.PB_Gadget, ColorType)
		Protected *GadgetData.GadgetData = *this\vt, Result
		
		Select ColorType
			Case #Color_Back_Cold
				Result = *GadgetData\Theme\BackColor[#Cold]
			Case #Color_Back_Warm
				Result = *GadgetData\Theme\BackColor[#Warm]
			Case #Color_Back_Hot
				Result = *GadgetData\Theme\BackColor[#Hot]
			Case #Color_Front_Cold
				Result = *GadgetData\Theme\FrontColor[#Cold]
			Case #Color_Front_Warm
				Result = *GadgetData\Theme\FrontColor[#Warm]
			Case #Color_Front_Hot
				Result = *GadgetData\Theme\FrontColor[#Hot]
			Case #Color_Line
				Result = *GadgetData\Theme\LineColor
			Case #Color_Parent
				Result = *GadgetData\Theme\WindowColor
		EndSelect
		
		ProcedureReturn RGB(Red(Result), Green(Result), Blue(Result))
	EndProcedure
	
	Procedure Default_GetState(*This.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\State
	EndProcedure
	
	; Setters
	Procedure GetAccessibilityMode()
		ProcedureReturn AccessibilityMode
	EndProcedure
	
	Procedure.s GetGadgetColorScheme(Gadget)	
	EndProcedure
	
	Procedure Default_SetFont(*this.PB_Gadget, FontID)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\FontID = FontID
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.GadgetData = *this\vt
		
		
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetState(*This.PB_Gadget, State)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\State = State
		RedrawObject()
	EndProcedure
	
	; Math
	Procedure Clamp(Value, Min, Max)
		If Value < Min
			Value = Min
		EndIf
		
		If Value > Max
			Value = Max
		EndIf
		
		ProcedureReturn Value
	EndProcedure
	
	Procedure Min(A, B)
		If A > B
			ProcedureReturn B
		EndIf
		ProcedureReturn A
	EndProcedure
	
	Procedure Max(A, B)
		If A < B
			ProcedureReturn B
		EndIf
		ProcedureReturn A
	EndProcedure
	;}
	
	; Window
	
	; Gadgets :
	
	;{ Button
	Structure ButtonData Extends GadgetData
		Text.s
		Icon.b
		Toggle.b
	EndStructure
	
	Procedure Button_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		
		With *GadgetData
			Box(\OriginX, \OriginY, \Width, \Height, \Theme\BackColor[\MouseState])
			
			DrawingFont(\FontID)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - TextHeight(\Text) * 0.5 * \Border, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\BackColor[\MouseState])
			ElseIf \TextAlignement = #AlignLeft
				DrawText(TextHeight(\Text) * 0.5 * \Border, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\BackColor[\MouseState])
			Else
				DrawText((\Width - TextWidth(\Text)) * 0.5, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\BackColor[\MouseState])
			EndIf
		EndWith
	EndProcedure
	
	Procedure Button_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		With *GadgetData
			AddPathBox(\OriginX, \OriginY, \Width, \Height, #PB_Path_Relative)
			ClipPath(#PB_Path_Preserve)
			VectorSourceColor(\Theme\BackColor[\MouseState])
			FillPath()
			
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[\MouseState])
			
			If \TextAlignement = #AlignRight
				MovePathCursor(\Width - VectorTextWidth(\Text) - VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
			ElseIf \TextAlignement = #AlignLeft
				MovePathCursor(VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
			Else
				MovePathCursor(Floor((\Width - VectorTextWidth(\Text)) * 0.5), Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
			EndIf
			DrawVectorText(\Text)
			
		EndWith
	EndProcedure
	
	Procedure Button_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.ButtonData = *this\vt, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #LeftClick
					If \Toggle
						\State = Bool(Not \State) * #hot
					EndIf
					
					PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					
					\MouseState = #Warm
					Redraw = #True
					
				Case #MouseEnter
					\MouseState = #Warm
					Redraw = #True
					
				Case #MouseLeave
					If \State = #False
						\MouseState = #Cold
					Else
						\MouseState = #Hot
					EndIf
					Redraw = #True
					
				Case #KeyDown
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						If \Toggle
							\State = Bool(Not \State) * #hot
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						
						\MouseState = #Hot
						Redraw = #True
					EndIf
				Case #KeyUp
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						If \State = #False
							\MouseState = #Cold
						Else
							\MouseState = #Hot
						EndIf
						Redraw = #True
					EndIf
				Case #LeftButtonDown
					\MouseState = #Hot
					Redraw = #True
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	; Getters
	Procedure.s Button_GetText(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		ProcedureReturn *GadgetData\Text
	EndProcedure
	
	; Setters
	Procedure Button_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.ButtonData = *this\vt
		*GadgetData\Text = Text
		RedrawObject()
	EndProcedure
	
	Procedure Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ButtonData
		
		If AccessibilityMode
			Result = ButtonGadget(Gadget, x, y, Width, Height, Text.s, (Bool(Flags & #AlignLeft) * #PB_Button_Left) | 
			                                                           (Bool(Flags & #AlignRight) * #PB_Button_Right) |
			                                                           (Bool(Flags & #Button_Toggle) * #PB_Button_Toggle))
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(Button)
				
				With *GadgetData
					
					\Text = Text
					
					\Toggle = Bool(Flags & #Button_Toggle)
					If Flags & #AlignLeft
						\TextAlignement = #AlignLeft
					ElseIf Flags & #AlignRight
						\TextAlignement = #AlignRight
					EndIf
					
					; Functions
					\VT\GetGadgetText = @Button_GetText()
					
					\VT\SetGadgetText = @Button_SetText()
					
					; Enable only the needed events
					\SupportedEvent[#LeftClick] = #True
					\SupportedEvent[#LeftButtonDown] = #True
					\SupportedEvent[#MouseEnter] = #True
					\SupportedEvent[#MouseLeave] = #True
					\SupportedEvent[#KeyDown] = #True
					\SupportedEvent[#KeyUp] = #True
				EndWith
				
				RedrawObject()
				
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Toggle
	#ToggleSize = 20
	
	Structure ToggleData Extends GadgetData
		Text.s
	EndStructure
	
	Procedure Toggle_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt, X, Y
		
		With *GadgetData
			DrawingFont(\FontID)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\WindowColor)
				X = #ToggleSize * 0.5 + BorderMargin
			Else
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\WindowColor)
				X = \Width - #ToggleSize * 1.5 - BorderMargin - 1
			EndIf
			Y = (\Height - #ToggleSize) * 0.5 + #ToggleSize * 0.5
			
			Circle(X, Y, #ToggleSize * 0.5, \Theme\LineColor[\MouseState])
			Circle(X + #ToggleSize, Y, #ToggleSize * 0.5, \Theme\LineColor[\MouseState])
			Box(X, Y - #ToggleSize * 0.5, #ToggleSize, #ToggleSize + 1, \Theme\LineColor[\MouseState])
			
			If \State
				Circle(X + #ToggleSize, Y, #ToggleSize * 0.4, \Theme\BackColor[#cold])
			Else
				Circle(X, Y, #ToggleSize * 0.4, \Theme\BackColor[#cold])
			EndIf
		EndWith
	EndProcedure
	
	Procedure Toggle_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt, X, Y, ToggleSize = #ToggleSize
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[\MouseState])
			
			If \TextAlignement = #AlignRight
				MovePathCursor(\Width - VectorTextWidth(\Text) - VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + ToggleSize * 0.5 + VectorBorderMargin
			Else
				MovePathCursor(VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + \Width - ToggleSize * 1.5 - VectorBorderMargin
			EndIf
			
			DrawVectorText(\Text)
			
			Y = \OriginY + Floor((\Height - ToggleSize) * 0.5 + ToggleSize * 0.5)
			
			AddPathCircle(X, Y, ToggleSize * 0.5, 0, 360, #PB_Path_Default)
			AddPathCircle(ToggleSize * 0.5, 0, ToggleSize * 0.5, 0, 360, #PB_Path_Relative)
			AddPathBox(-ToggleSize * 1.5, -ToggleSize * 0.5, ToggleSize, ToggleSize, #PB_Path_Relative)
			VectorSourceColor(\Theme\LineColor[\MouseState])
			FillPath(#PB_Path_Winding)
			
			VectorSourceColor(\Theme\BackColor[#cold])
			
			If \State
				AddPathCircle(X + ToggleSize, Y, ToggleSize * 0.4)
			Else
				AddPathCircle(X, Y, ToggleSize * 0.4)
			EndIf
			
			FillPath()
			
		EndWith
	EndProcedure
	
	Procedure Toggle_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.ToggleData = *this\vt, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseEnter
					\MouseState = #Warm
					Redraw = #True
					
				Case #MouseLeave
					\MouseState = #Cold
					Redraw = #True
					
				Case #LeftClick
					\State = Bool(Not \State)
					PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					
					\MouseState = #Warm
					Redraw = #True
				
				Case #KeyDown
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						\State = Bool(Not \State)
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						Redraw = #True
					EndIf
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	; Getters
	Procedure.s Toggle_GetText(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt
		ProcedureReturn *GadgetData\Text
	EndProcedure
	
	; Setters
	Procedure Toggle_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.ToggleData = *this\vt
		*GadgetData\Text = Text
		RedrawObject()
	EndProcedure
	
	Procedure Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ToggleData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
		
		If Result
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			InitializeObject(Toggle)
			
			With *GadgetData
				\Text = Text
				
				If Flags & #AlignRight
					\TextAlignement = #AlignRight
				EndIf
				
				; Functions
				\VT\GetGadgetText = @Toggle_GetText()
				
				\VT\SetGadgetText = @Toggle_SetText()
				
				; Enable only the needed events
				\SupportedEvent[#LeftClick] = #True
				\SupportedEvent[#LeftButtonDown] = #True
				\SupportedEvent[#MouseEnter] = #True
				\SupportedEvent[#MouseLeave] = #True
				\SupportedEvent[#KeyDown] = #True
				\SupportedEvent[#KeyUp] = #True
			EndWith
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ Checkbox
	#CheckboxSize = 20
	
	Structure CheckBoxData Extends GadgetData
		Text.s
	EndStructure
	
	Procedure CheckBox_Redraw(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt, X, Y
		
		With *GadgetData
			DrawingFont(\FontID)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\WindowColor)
				X = BorderMargin
			Else
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\WindowColor)
				X = \Width - #CheckboxSize - BorderMargin
			EndIf
			Y = (\Height - #CheckboxSize) * 0.5
			
			Box(X, Y, #CheckboxSize, #CheckboxSize, \Theme\LineColor[\MouseState])
			Box(X + #CheckboxSize * 0.1, Y + #CheckboxSize * 0.1, #CheckboxSize * 0.8, #CheckboxSize * 0.8, \Theme\WindowColor)
			
			If \State = #True
				Box(X + #CheckboxSize * 0.75, Y, #CheckboxSize * 0.25, #CheckboxSize * 0.3, \Theme\WindowColor)
				
				Line(X + #CheckboxSize * 0.2, Y + #CheckboxSize * 0.38, #CheckboxSize * 0.2, #CheckboxSize * 0.2, \Theme\LineColor[\MouseState])
				Line(X + #CheckboxSize * 0.2 - 1, Y + #CheckboxSize * 0.38, #CheckboxSize * 0.2, #CheckboxSize * 0.2, \Theme\LineColor[\MouseState])
				
				Line(X + #CheckboxSize * 0.4, Y + #CheckboxSize * 0.58, #CheckboxSize * 0.6, - #CheckboxSize * 0.6, \Theme\LineColor[\MouseState])
				Line(X + #CheckboxSize * 0.4 - 1, Y + #CheckboxSize * 0.58, #CheckboxSize * 0.6, -#CheckboxSize * 0.6, \Theme\LineColor[\MouseState])
			ElseIf \State = #PB_Checkbox_Inbetween
				Box(X + #CheckboxSize * 0.25, Y + #CheckboxSize * 0.25, #CheckboxSize * 0.5, #CheckboxSize * 0.5, \Theme\LineColor[\MouseState])
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure CheckBox_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt, X, Y, CheckboxSize = #CheckboxSize
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[\MouseState])
			
			If \TextAlignement = #AlignRight
				MovePathCursor(\Width - VectorTextWidth(\Text) - VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + VectorBorderMargin
			Else
				MovePathCursor(VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + \Width - CheckboxSize - VectorBorderMargin
			EndIf
			
			DrawVectorText(\Text)
			
			Y = Floor(\OriginY + (\Height - CheckboxSize) * 0.5)
			
			AddPathBox(X, Y, CheckboxSize, CheckboxSize)
			AddPathBox(X + CheckboxSize * 0.1, Y + CheckboxSize * 0.1, CheckboxSize * 0.8, CheckboxSize * 0.8)
			VectorSourceColor(\Theme\LineColor[\MouseState])
			FillPath()
			
			If \State = #True
				AddPathBox(X + CheckboxSize * 0.75, Y, CheckboxSize * 0.25, CheckboxSize * 0.3)
				VectorSourceColor(\Theme\WindowColor)
				FillPath()
				VectorSourceColor(\Theme\LineColor[\MouseState])
				
				MovePathCursor(X + CheckboxSize * 0.2, Y + CheckboxSize * 0.4)
				AddPathLine(CheckboxSize * 0.28, CheckboxSize * 0.28, #PB_Path_Relative)
				AddPathLine(CheckboxSize * 0.5, -CheckboxSize * 0.7, #PB_Path_Relative)
				
				StrokePath(2)
			ElseIf \State = #PB_Checkbox_Inbetween
				AddPathBox(X + CheckboxSize * 0.25, Y + CheckboxSize * 0.25, CheckboxSize * 0.5, CheckboxSize * 0.5)
				VectorSourceColor(\Theme\LineColor[\MouseState])
				FillPath()
			EndIf
		EndWith
	EndProcedure
	
	Procedure CheckBox_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.CheckBoxData = *this\vt, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseEnter
					\MouseState = #Warm
					Redraw = #True
					
				Case #MouseLeave
					\MouseState = #Cold
					Redraw = #True
					
				Case #LeftClick
					If \State = #PB_Checkbox_Inbetween
						\State = #True
					Else
						\State = Bool(Not \State)
					EndIf
					PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					
					\MouseState = #Warm
					Redraw = #True
				
				Case #KeyDown
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						If \State = #PB_Checkbox_Inbetween
							\State = #True
						Else
							\State = Bool(Not \State)
						EndIf
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						Redraw = #True
					EndIf
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	; Getters
	Procedure.s CheckBox_GetText(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt
		ProcedureReturn *GadgetData\Text
	EndProcedure
	
	; Setters
	Procedure CheckBox_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.CheckBoxData = *this\vt
		*GadgetData\Text = Text
		RedrawObject()
	EndProcedure
	
	Procedure CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.CheckBoxData
		
		If AccessibilityMode
			Result = CheckBoxGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #AlignRight) * #PB_CheckBox_Right) |
			                                                           (Bool(Flags & #AlignCenter) * #PB_CheckBox_Center) |
			                                                           #PB_CheckBox_ThreeState)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(CheckBox)
				
				With *GadgetData
					\Text = Text
					
					If Flags & #AlignRight
						\TextAlignement = #AlignRight
					EndIf
					
					; Functions
					\VT\GetGadgetText = @CheckBox_GetText()
					
					\VT\SetGadgetText = @CheckBox_SetText()
					
					; Enable only the needed events
					\SupportedEvent[#LeftClick] = #True
					\SupportedEvent[#LeftButtonDown] = #True
					\SupportedEvent[#MouseEnter] = #True
					\SupportedEvent[#MouseLeave] = #True
					\SupportedEvent[#KeyDown] = #True
					\SupportedEvent[#KeyUp] = #True
				EndWith
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ Scrollbar
	Structure ScrollBarData Extends GadgetData
		Min.l
		Max.l
		PageLenght.l
		Vertical.b
		Position.l
		BarSize.l
		Thickness.l
		Drag.b
		DragOffset.b
	EndStructure
	
	Procedure ScrollBar_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ScrollBarData = *this\vt, Radius
		
		With *GadgetData
			Radius = Floor(\Thickness * 0.5)
			Circle(Radius, Radius, Radius, \Theme\BackColor[#Cold])
			
			If \Vertical
				Box(0, Radius, \Width, \Height - \Thickness, \Theme\BackColor[#Cold])
				Circle(Radius, \Height - Radius - 1, Radius, \Theme\BackColor[#Cold])
				
				Circle(Radius, Radius + \Position, Radius, \Theme\LineColor[\MouseState])
				Box(0, Radius + \Position, \Width, \BarSize, \Theme\LineColor[\MouseState])
				Circle(Radius, Radius + \Position + \BarSize, Radius, \Theme\LineColor[\MouseState])
			Else
				Box(Radius, 0, \Width - \Thickness, \Height, \Theme\BackColor[#Cold])
				Circle(\Width - Radius - 1, Radius, Radius, \Theme\BackColor[#Cold])
				
				Circle(Radius + \Position, Radius, Radius, \Theme\LineColor[\MouseState])
				Box(Radius + \Position, 0, \BarSize, \Height, \Theme\LineColor[\MouseState])
				Circle(Radius + \Position + \BarSize, Radius, Radius, \Theme\LineColor[\MouseState])
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure ScrollBar_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.ScrollBarData = *this\vt, Radius.f, Point
		
		With *GadgetData
			Radius = \Thickness * 0.5
			AddPathCircle(\OriginX + Radius, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
			VectorSourceColor(\Theme\BackColor[#Warm])
			
			If \Vertical
				AddPathBox(- \Thickness, 0, \Width, \Height - \Thickness, #PB_Path_Relative)
				AddPathCircle(\OriginX + Radius, \OriginY + \Height - Radius, Radius, 0, 360, #PB_Path_Default)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\Theme\LineColor[\MouseState])
				
				AddPathCircle(\OriginX + Radius, \OriginY + Radius + \Position, Radius, 0, 360, #PB_Path_Default)
				AddPathBox(- \Thickness, 0, \Width, \BarSize, #PB_Path_Relative)
				AddPathCircle(\OriginX + Radius, \OriginY + Radius + \BarSize + \Position, Radius, 0, 360, #PB_Path_Default)
				
				FillPath(#PB_Path_Winding)
			Else
				AddPathBox(- Radius, - Radius, \Width - \Thickness, \Height, #PB_Path_Relative)
				AddPathCircle(\OriginX + \Width - Radius, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\Theme\LineColor[\MouseState])
				
				AddPathCircle(\OriginX + Radius + \Position, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
				AddPathBox(- Radius, - Radius, \BarSize, \Height, #PB_Path_Relative)
				AddPathCircle(\OriginX + Radius + \Position + \BarSize, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
				
				FillPath(#PB_Path_Winding)
			EndIf
		EndWith
	EndProcedure
	
	Procedure ScrollBar_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.ScrollBarData = *this\vt, Redraw, Mouse, Lenght, Position
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \Drag
						If \Vertical
							Mouse = *Event\MouseY
							Lenght = \Height - \BarSize - \Thickness
						Else
							Mouse = *Event\MouseX
							Lenght = \Width - \BarSize - \Thickness
						EndIf
						
						Position = Clamp(Mouse - \DragOffset, 0, Lenght)
						
						If Position <> \Position
							\Position = Position
							\State = Round(Position / (Lenght) * (\Max - \Min), #PB_Round_Down)
							Redraw = #True
							PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						EndIf
					Else
						If \Vertical
							Mouse = *Event\MouseY
						Else
							Mouse = *Event\MouseX
						EndIf
						
						If Mouse >= \Position And Mouse < \Position + \BarSize + \Thickness
							If \MouseState = #Cold
								\MouseState = #Warm
								Redraw = #True
							EndIf
						ElseIf \MouseState = #Warm
							\MouseState = #Cold
							Redraw = #True
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \MouseState
						\MouseState = #Cold
						Redraw = #True
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \Vertical
						Mouse = *Event\MouseY
						Lenght = \Height
					Else
						Mouse = *Event\MouseX
						Lenght = \Width
					EndIf
					
					If Mouse >= \Position And Mouse < \Position + \BarSize + \Thickness
						\Drag = #True
						\DragOffset = Mouse - \Position
					Else
						If Mouse > \Position
							\State = Min(\State + \PageLenght, \Max - \PageLenght)
							Redraw = #True
						Else
							\State = Max(\State - \PageLenght, \Min)
							Redraw = #True
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						\Position = Round(\State / (\max - \min) * Lenght, #PB_Round_Nearest)
					EndIf
					;}
				Case #LeftButtonUp ;{
					\Drag = #False
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Scrollbar_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.ScrollBarData = *this\vt, Lenght
		
		With *GadgetData
			State = Clamp(State, \Min, \Max)
			If State <> \State
				If \Vertical
					Lenght = \Height
				Else
					Lenght = \Width
				EndIf
				
				\Position = Round(\State / (\max - \min) * Lenght, #PB_Round_Nearest)
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Scrollbar_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.ScrollBarData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			If \Vertical
				\Thickness = \Width
				\BarSize = Clamp(Round(\PageLenght / (\max - \min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
			Else
				\Thickness = \Height
				\BarSize = Clamp(Round(\PageLenght / (\max - \min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
			EndIf
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ScrollBarData
		
		If AccessibilityMode
			Result = ScrollBarGadget(Gadget, x, y, Width, Height, Min, Max, PageLenght, Bool(Flags & #ScrollBar_Vertical) * #PB_ScrollBar_Vertical)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(ScrollBar)
				
				If Not Flags & #DarkMode
					CopyStructure(@AltTheme, *GadgetData\Theme, Theme)
				EndIf
				
				With *GadgetData
					\Max = Max
					\Min = Min
					\PageLenght = PageLenght
					
					If Flags & #ScrollBar_Vertical
						\Vertical = #True
						\Thickness = \Width
						\BarSize = Clamp(Round(PageLenght / (max - min) * Height, #PB_Round_Nearest) - \Thickness, 0, Height - \Thickness)
					Else
						\Thickness = \Height
						\BarSize = Clamp(Round(PageLenght / (max - min) * Width, #PB_Round_Nearest) - \Thickness, 0, Width - \Thickness)
					EndIf
					
					\VT\SetGadgetState = @Scrollbar_SetState()
					\VT\ResizeGadget = @Scrollbar_Resize()
					
					; Enable only the needed events
					\SupportedEvent[#MouseEnter] = #True
					\SupportedEvent[#MouseLeave] = #True
					\SupportedEvent[#MouseMove] = #True
					\SupportedEvent[#LeftButtonDown] = #True
					\SupportedEvent[#LeftButtonUp] = #True
				EndWith
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
EndModule

; Notes :

; ProcedureDLL GetGadgetParent(Gadget.i) ;В()
; 	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
; 		ProcedureReturn GetParent_(Gadget)
; 	CompilerElseIf #PB_Compiler_OS = #PB_OS_Linux
; 		ProcedureReturn Gtk_Widget_Get_Parent_(Gadget)
; 	CompilerEndIf  
; EndProcedure



; CompilerSelect #PB_Compiler_OS 
;   CompilerCase #PB_OS_MacOS
;     Import ""
;       PB_Window_GetID(hWnd) 
;     EndImport
; CompilerEndSelect
; 
; Procedure IDWindow( handle.i ) ; Return the id of the window from the window handle
;   Protected Window 
;   
;   CompilerSelect #PB_Compiler_OS 
;     CompilerCase #PB_OS_Linux
;       Window = g_object_get_data_( handle, "pb_id" )
;     CompilerCase #PB_OS_Windows
;       Window = GetProp_( handle, "PB_WindowID" ) - 1
;     CompilerCase #PB_OS_MacOS
;       Window = PB_Window_GetID( handle )
;   CompilerEndSelect
;   
;   If IsWindow( Window ) And 
;      WindowID( Window ) = handle
;     ProcedureReturn Window
;   Else
;     ProcedureReturn - 1
;   EndIf
; EndProcedure
; 
; Procedure IDgadget( handle.i )  ; Return the id of the gadget from the gadget handle
;   Protected gadget
;   
;   CompilerSelect #PB_Compiler_OS 
;     CompilerCase #PB_OS_Linux
;       gadget = g_object_get_data_( handle, "pb_id" ) - 1 
;     CompilerCase #PB_OS_Windows
;       gadget = GetProp_( handle, "PB_ID" )
;     CompilerCase #PB_OS_MacOS
;       gadget = CocoaMessage( 0, handle, "tag" )
;   CompilerEndSelect
;   
;   If IsGadget( gadget ) And 
;      GadgetID( gadget ) = handle
;     ProcedureReturn gadget
;   Else
;     ProcedureReturn - 1
;   EndIf
; EndProcedure






























; IDE Options = PureBasic 6.00 Beta 5 (Windows - x64)
; CursorPosition = 1419
; Folding = JsBgBAAAAAQQ9
; EnableXP