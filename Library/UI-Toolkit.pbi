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
	Declare SetAccessibilityMode(State) 					; Enable or disable accessibility mode. If enabled, gadget falls back on to their default PB version, making them compatible with important features like screen readers or RTL languages.
	Declare SetGadgetColorScheme(Gadget, ThemeJson.s)		; Apply a complete color scheme at once
	
	; Getters
	Declare GetAccessibilityMode()							; Returns the current accessibility state.
	Declare.s GetGadgetColorScheme(Gadget)					; Apply a complete color scheme at once
	
	; Window
	
	; Gadgets
	Declare Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
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
		
		; Setters
		*GadgetData\VT\SetGadgetFont = @Default_SetFont()
		*GadgetData\VT\SetGadgetColor = @Default_SetColor()
		
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
				VectorSourceColor(*GadgetData\Theme\LineColor[*GadgetData\State])
				StrokePath(2)
			EndIf
			StopVectorDrawing()
		Else
			StartDrawing(CanvasOutput(*GadgetData\Gadget))
			Box(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, *GadgetData\Theme\WindowColor)
			*GadgetData\Redraw(*this)
			If *GadgetData\Border
				DrawingMode(#PB_2DDrawing_Outlined )
				Box(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, *GadgetData\Theme\LineColor[*GadgetData\State])
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
	
	Enumeration ;Theme state
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
		
		State.b
		
		SupportedEvent.b[#__EVENTSIZE]
		
		TextAlignement.b
		
		Redraw.Redraw
		EventHandler.EventHandler
		Theme.Theme
		ParentWindow.i
	EndStructure
	
	Global AccessibilityMode = #False
	Global DefaultTheme.Theme, DarkTheme.Theme
	Global DefaultFont = FontID(LoadFont(#PB_Any, "Segoe UI", 9, #PB_Font_HighQuality))
	
	With DefaultTheme
		\WindowColor = SetAlpha(FixColor($F0F0F0), 255)
		
		\BackColor[#Cold]	= SetAlpha(FixColor($F0F0F0), 255)
		\BackColor[#Warm]	= SetAlpha(FixColor($D8E6F2), 255)
		\BackColor[#Hot]	= SetAlpha(FixColor($C0DCF3), 255)
		
		\LineColor[#Cold]	= SetAlpha(FixColor($ADADAD), 255)
		\LineColor[#Warm]	= SetAlpha(FixColor($90C8F6), 255)
		\LineColor[#Hot]	= SetAlpha(FixColor($90C8F6), 255)
		
		\FrontColor[#Cold] 	= SetAlpha(FixColor($000000), 255)
		\FrontColor[#Warm]	= SetAlpha(FixColor($000000), 255)
		\FrontColor[#Hot]	= SetAlpha(FixColor($000000), 255)
	EndWith
	
	With DarkTheme
		\WindowColor		= SetAlpha(FixColor($2F3136), 255)
		
		\BackColor[#Cold]	= SetAlpha(FixColor($2F3136), 255)
		\BackColor[#Warm]	= SetAlpha(FixColor($44474C), 255)
		\BackColor[#Hot]	= SetAlpha(FixColor($54575C), 255)
		
		\LineColor[#Cold]	= SetAlpha(FixColor($7E8287), 255)
		\LineColor[#Warm]	= SetAlpha(FixColor($A2A3A5), 255)
		\LineColor[#Hot]	= SetAlpha(FixColor($A2A3A5), 255)
		
		\FrontColor[#Cold] 	= SetAlpha(FixColor($FAFAFB), 255)
		\FrontColor[#Warm]	= SetAlpha(FixColor($FFFFFF), 255)
		\FrontColor[#Hot]	= SetAlpha(FixColor($FFFFFF), 255)
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
	
	Procedure Default_DisableGadget(*This.PB_Gadget, State) ; Wut? Doesn't exist?
		Protected *GadgetData.GadgetData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		DisableGadget(*GadgetData\Gadget, State)
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
	Procedure SetAccessibilityMode(State)
		AccessibilityMode = State
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
	
	;}
	
	; Window
	
	; Gadgets :
	
	;{ Button
	Structure ButtonData Extends GadgetData
		Text.s
		Icon.b
		Toggle.b
		ToggleState.b
	EndStructure
	
	Procedure Button_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		
		With *GadgetData
			Box(\OriginX, \OriginY, \Width, \Height, \Theme\BackColor[\State])
			
			DrawingFont(\FontID)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - TextHeight(\Text) * 0.5 * \Border, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\BackColor[\State])
			ElseIf \TextAlignement = #AlignLeft
				DrawText(TextHeight(\Text) * 0.5 * \Border, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\BackColor[\State])
			Else
				DrawText((\Width - TextWidth(\Text)) * 0.5, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\BackColor[\State])
			EndIf
		EndWith
	EndProcedure
	
	Procedure Button_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		With *GadgetData
			AddPathBox(\OriginX, \OriginY, \Width, \Height, #PB_Path_Relative)
			ClipPath(#PB_Path_Preserve)
			VectorSourceColor(\Theme\BackColor[\State])
			FillPath()
			
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[\State])
			
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
						\ToggleState = Bool(Not \ToggleState) * #hot
					EndIf
					
					PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					
					\State = #Warm
					Redraw = #True
					
				Case #MouseEnter
					\State = #Warm
					Redraw = #True
					
				Case #MouseLeave
					If \ToggleState = #False
						\State = #Cold
					Else
						\State = #Hot
					EndIf
					Redraw = #True
					
				Case #KeyDown
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						If \Toggle
							\ToggleState = Bool(Not \ToggleState) * #hot
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						
						\State = #Hot
						Redraw = #True
					EndIf
				Case #KeyUp
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						If \ToggleState = #False
							\State = #Cold
						Else
							\State = #Hot
						EndIf
						Redraw = #True
					EndIf
				Case #LeftButtonDown
					\State = #Hot
					Redraw = #True
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	; Getters
	Procedure Button_GetState(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		ProcedureReturn *GadgetData\ToggleState
	EndProcedure
	
	Procedure.s Button_GetText(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		ProcedureReturn *GadgetData\Text
	EndProcedure
	
	; Setters
	Procedure Button_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.ButtonData = *this\vt
		*GadgetData\ToggleState = State
		RedrawObject()
	EndProcedure
	
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
					\VT\GetGadgetState = @Button_GetState()
					
					\VT\SetGadgetText = @Button_SetText()
					\VT\SetGadgetState = @Button_SetState()
					
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
	Structure ToggleData Extends GadgetData
		Text.s
		ToggleState.b
	EndStructure
	
	Procedure Toggle_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt, X, Y
		
		With *GadgetData
			DrawingFont(\FontID)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\WindowColor)
				X = 12 + BorderMargin
			Else
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\WindowColor)
				X = \Width - 38 - BorderMargin
			EndIf
			Y = (\Height - 25) * 0.5
			
			Circle(X, Y + 12, 12, \Theme\LineColor[\State])
			Circle(X + 25, Y + 12, 12, \Theme\LineColor[\State])
			Box(X, Y, 25, 25, \Theme\LineColor[\State])
			
			If \ToggleState
				Circle(X + 25, Y + 12, 10, \Theme\BackColor[#cold])
			Else
				Circle(X, Y + 12, 10, \Theme\BackColor[#cold])
			EndIf
		EndWith
	EndProcedure
	
	Procedure Toggle_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt, X, Y
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[\State])
			
			If \TextAlignement = #AlignRight
				MovePathCursor(\Width - VectorTextWidth(\Text) - VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + 12 + VectorBorderMargin
			Else
				MovePathCursor(VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + \Width - 36 - VectorBorderMargin
			EndIf
			
			DrawVectorText(\Text)
			
			Y = \OriginY + Floor((\Height - 25) * 0.5 + 12)
			
			AddPathCircle(X, Y, 12, 0, 360, #PB_Path_Default)
			AddPathCircle(12, 0, 12, 0, 360, #PB_Path_Relative)
			AddPathBox(-38, -12, 24, 24, #PB_Path_Relative)
			VectorSourceColor(\Theme\LineColor[\State])
			FillPath(#PB_Path_Winding)
			
			VectorSourceColor(\Theme\BackColor[#cold])
			
			If \ToggleState
				AddPathCircle(X + 24, Y, 10)
			Else
				AddPathCircle(X, Y, 10)
			EndIf
			
			FillPath()
			
		EndWith
	EndProcedure
	
	Procedure Toggle_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.ToggleData = *this\vt, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseEnter
					\State = #Warm
					Redraw = #True
					
				Case #MouseLeave
					\State = #Cold
					Redraw = #True
					
				Case #LeftClick
					\ToggleState = Bool(Not \ToggleState)
					PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					
					\State = #Warm
					Redraw = #True
				
				Case #KeyDown
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						\ToggleState = Bool(Not \ToggleState)
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
	Procedure Toggle_GetState(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt
		ProcedureReturn *GadgetData\ToggleState
	EndProcedure
	
	Procedure.s Toggle_GetText(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt
		ProcedureReturn *GadgetData\Text
	EndProcedure
	
	; Setters
	Procedure Toggle_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.ToggleData = *this\vt
		*GadgetData\ToggleState = State
		RedrawObject()
	EndProcedure
	
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
				\VT\GetGadgetState = @Toggle_GetState()
				
				\VT\SetGadgetText = @Toggle_SetText()
				\VT\SetGadgetState = @Toggle_SetState()
				
				; Enable only the needed events
				\SupportedEvent[#LeftClick] = #True
				\SupportedEvent[#LeftButtonDown] = #True
				\SupportedEvent[#MouseEnter] = #True
				\SupportedEvent[#MouseLeave] = #True
				\SupportedEvent[#KeyDown] = #True
				\SupportedEvent[#KeyUp] = #True
			EndWith
			
			SetGadgetAttribute(Gadget, #PB_Canvas_Cursor, #PB_Cursor_Hand)
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ Checkbox
	Structure CheckBoxData Extends GadgetData
		Text.s
		CheckBoxState.b
	EndStructure
	
	Procedure CheckBox_Redraw(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt, X, Y
		
		With *GadgetData
			DrawingFont(\FontID)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\WindowColor)
				X = BorderMargin
			Else
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\State], \Theme\WindowColor)
				X = \Width - 24 - BorderMargin
			EndIf
			Y = (\Height - 24) * 0.5
			
			Box(X, Y, 24, 24, \Theme\LineColor[\State])
			Box(X + 2, Y + 2, 20, 20, \Theme\WindowColor)
			
			If \CheckBoxState
				Box(X + 14, Y, 10, 10, \Theme\WindowColor)
				
				Line(X + 4, Y + 10, 8, 8, \Theme\LineColor[\State])
				Line(X + 5, Y + 10, 8, 8, \Theme\LineColor[\State])
				
				Line(X + 12, Y + 18, 10, -19, \Theme\LineColor[\State])
				Line(X + 13, Y + 18, 10, -19, \Theme\LineColor[\State])
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure CheckBox_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt, X, Y
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[\State])
			
			If \TextAlignement = #AlignRight
				MovePathCursor(\Width - VectorTextWidth(\Text) - VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + VectorBorderMargin
			Else
				MovePathCursor(VectorBorderMargin, Floor((\Height - VectorTextHeight(\Text)) * 0.5), #PB_Path_Relative)
				X = \OriginX + \Width - 24 - VectorBorderMargin
			EndIf
			
			DrawVectorText(\Text)
			
			Y = Floor(\OriginY + (\Height - 24) * 0.5)
			
			AddPathBox(X, Y, 24, 24)
			AddPathBox(X + 2, Y + 2, 20, 20)
			VectorSourceColor(\Theme\LineColor[\State])
			FillPath()
			
			If \CheckBoxState
				AddPathBox(X + 14, Y, 10, 10)
				VectorSourceColor(\Theme\WindowColor)
				FillPath()
				VectorSourceColor(\Theme\LineColor[\State])
				
				MovePathCursor(X + 4, Y + 12)
				AddPathLine(8, 6, #PB_Path_Relative)
				AddPathLine(10, -18, #PB_Path_Relative)
				
				StrokePath(2)
			EndIf
		EndWith
	EndProcedure
	
	Procedure CheckBox_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.CheckBoxData = *this\vt, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseEnter
					\State = #Warm
					Redraw = #True
					
				Case #MouseLeave
					\State = #Cold
					Redraw = #True
					
				Case #LeftClick
					\CheckBoxState = Bool(Not \CheckBoxState)
					PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					
					\State = #Warm
					Redraw = #True
				
				Case #KeyDown
					If GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						\CheckBoxState = Bool(Not \CheckBoxState)
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
	Procedure CheckBox_GetState(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt
		ProcedureReturn *GadgetData\CheckBoxState
	EndProcedure
	
	Procedure.s CheckBox_GetText(*this.PB_Gadget)
		Protected *GadgetData.CheckBoxData = *this\vt
		ProcedureReturn *GadgetData\Text
	EndProcedure
	
	; Setters
	Procedure CheckBox_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.CheckBoxData = *this\vt
		*GadgetData\CheckBoxState = State
		RedrawObject()
	EndProcedure
	
	Procedure CheckBox_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.CheckBoxData = *this\vt
		*GadgetData\Text = Text
		RedrawObject()
	EndProcedure
	
	Procedure CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.CheckBoxData
		
		If AccessibilityMode
			Result = CheckBoxGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #AlignRight) * #PB_CheckBox_Right) |
			                                                           (Bool(Flags & #AlignCenter) * #PB_CheckBox_Center))
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
					\VT\GetGadgetState = @CheckBox_GetState()
					
					\VT\SetGadgetText = @CheckBox_SetText()
					\VT\SetGadgetState = @CheckBox_SetState()
					
					; Enable only the needed events
					\SupportedEvent[#LeftClick] = #True
					\SupportedEvent[#LeftButtonDown] = #True
					\SupportedEvent[#MouseEnter] = #True
					\SupportedEvent[#MouseLeave] = #True
					\SupportedEvent[#KeyDown] = #True
					\SupportedEvent[#KeyUp] = #True
				EndWith
				
				SetGadgetAttribute(Gadget, #PB_Canvas_Cursor, #PB_Cursor_Hand)
				
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
; CursorPosition = 1172
; Folding = JsBAAAAAAE5
; EnableXP