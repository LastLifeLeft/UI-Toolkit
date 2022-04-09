DeclareModule UITK
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
		#ScrollBar_Vertical								; The scrollbar is vertical (instead of horizontal, which is the default).
		
		; Window
		#Window_CloseButton
		#Window_MaximizeButton
		#Window_MinimizeButton
	EndEnumeration
	
	; Gadget attribues
	#ScrollBar_Minimum			= #PB_ScrollBar_Minimum
	#ScrollBar_Maximum			= #PB_ScrollBar_Maximum
	#ScrollBar_PageLength		= #PB_ScrollBar_PageLength
	
	#ScrollArea_InnerWidth		= #PB_ScrollArea_InnerWidth 
	#ScrollArea_InnerHeight		= #PB_ScrollArea_InnerHeight
	#ScrollArea_X				= #PB_ScrollArea_X          
	#ScrollArea_Y				= #PB_ScrollArea_Y          
	#ScrollArea_ScrollStep		= #PB_ScrollArea_ScrollStep 
	
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
	Declare Window(Window, X, Y, InnerWidth, InnerHeight, Title.s, Flags = #Default, Parent = #Null)
	Declare OpenWindowGadgetList(Window)
	Declare SetWindowBounds(Window, MinWidth, MinHeight, MaxWidth, MaxHeight)
	
	; Menu
	Declare FlatMenu(ParentID, Flags = #Default)
	Declare AddFlatMenuItem(Menu, MenuItem, Position, Text.s, ImageID = 0, SubMenu = 0)
	Declare RemoveFlatMenuItem(Menu, Position)
	Declare AddFlatMenuSeparator(Menu, Position)
	Declare ShowFlatMenu(FlatMenu, X = -1, Y = -1)
	
	; Gadgets
	Declare Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags = #Default)
	Declare Label(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollArea(Gadget, x, y, Width, Height, ScrollAreaWidth, ScrollAreaHeight, ScrollStep = #Default, Flags = #Default)
	
	; Misc
	
	
	;}a
EndDeclareModule

Module UITK
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
		*GadgetData\VT\GetGadgetState = @Default_GetState()
		*GadgetData\VT\GetRequiredSize = @Default_GetRequiredSize()
		
		; Setters
		*GadgetData\VT\SetGadgetFont = @Default_SetFont()
		*GadgetData\VT\SetGadgetColor = @Default_SetColor()
		*GadgetData\VT\SetGadgetState = @Default_SetState()
		
		*GadgetData\DefaultEventHandler = @Default_EventHandle()
		
		BindGadgetEvent(Gadget, *GadgetData\DefaultEventHandler)
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
			Prototype GetAttribute(*This, Attribute)
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
				*GetGadgetAttribute.GetAttribute
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
		
		RequieredWidth.w
		RequieredHeight.w
		
		Redraw.Redraw
		EventHandler.EventHandler
		Theme.Theme
		ParentWindow.i
		
		*DefaultEventHandler
	EndStructure
	
	Global AccessibilityMode = #False
	Global DefaultTheme.Theme, AltTheme.Theme, DarkTheme.Theme
	Global DefaultFont = FontID(LoadFont(#PB_Any, "Segoe UI", 9, #PB_Font_HighQuality))
	Global MaterialFont = FontID(LoadFont(#PB_Any, "Material Design Icons Desktop", 12, #PB_Font_HighQuality))
	
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
		Protected Event.Event, *this.PB_Gadget = IsGadget(EventGadget()), *GadgetData.GadgetData = *this\vt
		
		Select EventType()
			Case #PB_EventType_MouseEnter
				If *GadgetData\SupportedEvent[#MouseEnter]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #MouseEnter
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_MouseLeave
				If *GadgetData\SupportedEvent[#MouseLeave]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #MouseLeave
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_MouseMove
				If *GadgetData\SupportedEvent[#MouseMove]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #MouseMove
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_MouseWheel
				If *GadgetData\SupportedEvent[#MouseWheel]
					Event\EventType = #MouseWheel
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_LeftButtonDown
				If *GadgetData\SupportedEvent[#LeftButtonDown]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #LeftButtonDown
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_LeftButtonUp
				If *GadgetData\SupportedEvent[#LeftButtonUp]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #LeftButtonUp
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_LeftClick
				If *GadgetData\SupportedEvent[#LeftClick]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #LeftClick
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_LeftDoubleClick
				If *GadgetData\SupportedEvent[#LeftDoubleClick]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #LeftDoubleClick
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_RightButtonDown
				If *GadgetData\SupportedEvent[#RightButtonDown]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #RightButtonDown
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_RightButtonUp
				If *GadgetData\SupportedEvent[#RightButtonUp]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #RightButtonUp
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_RightClick
				If *GadgetData\SupportedEvent[#RightClick]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #RightClick
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_RightDoubleClick
				If *GadgetData\SupportedEvent[#RightDoubleClick]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #RightDoubleClick
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_MiddleButtonDown
				If *GadgetData\SupportedEvent[#MiddleButtonDown]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #MiddleButtonDown
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_MiddleButtonUp
				If *GadgetData\SupportedEvent[#MiddleButtonUp]
					Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
					Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
					Event\EventType = #MiddleButtonUp
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_Focus
				If *GadgetData\SupportedEvent[#Focus]
					Event\EventType = #Focus
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_LostFocus
				If *GadgetData\SupportedEvent[#LostFocus]
					Event\EventType = #LostFocus
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_KeyDown
				If *GadgetData\SupportedEvent[#KeyDown]
					Event\EventType = #KeyDown
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_KeyUp
				If *GadgetData\SupportedEvent[#KeyUp]
					Event\EventType = #KeyUp
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_Input
				If *GadgetData\SupportedEvent[#Input]
					Event\EventType = #Input
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Case #PB_EventType_Resize
				If *GadgetData\SupportedEvent[#Resize]
					Event\EventType = #Resize
					*GadgetData\EventHandler(*this, Event)
				EndIf
				
			Default
				ProcedureReturn
		EndSelect
		
		
		
	EndProcedure
	
	Procedure Default_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		
		If *GadgetData\DefaultEventHandler
			UnbindGadgetEvent(*GadgetData\Gadget, *GadgetData\DefaultEventHandler)
		EndIf
		
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
	
	Procedure Default_GetRequiredSize(*This.PB_Gadget, *Width, *Height)
		Protected *GadgetData.GadgetData = *this\vt
		
		PokeW(*Width, *GadgetData\RequieredWidth)
		PokeW(*Height, *GadgetData\RequieredHeight)
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
		
		Select ColorType
			Case #Color_Back_Cold
				*GadgetData\Theme\BackColor[#Cold] = Color
			Case #Color_Back_Warm
				*GadgetData\Theme\BackColor[#Warm] = Color
			Case #Color_Back_Hot
				*GadgetData\Theme\BackColor[#Hot] = Color
			Case #Color_Front_Cold
				*GadgetData\Theme\FrontColor[#Cold] = Color
			Case #Color_Front_Warm
				*GadgetData\Theme\FrontColor[#Warm] = Color
			Case #Color_Front_Hot
				*GadgetData\Theme\FrontColor[#Hot] = Color
			Case #Color_Line
				*GadgetData\Theme\LineColor = Color
			Case #Color_Parent
				*GadgetData\Theme\WindowColor = Color
		EndSelect
		
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
	
	Procedure GetGadgetParent(Gadget.i)
		CompilerIf #PB_Compiler_OS = #PB_OS_Windows
			ProcedureReturn GetParent_(Gadget)
		CompilerElseIf #PB_Compiler_OS = #PB_OS_Linux
			ProcedureReturn Gtk_Widget_Get_Parent_(Gadget)
		CompilerEndIf  
	EndProcedure
	;}
	
	;{ Window
	#WM_SYSMENU = $313
	#SizableBorder = 8
	#WindowButtonWidth = 45
	#WindowBarHeight = 30
	#MenuLabelOffset = #SizableBorder
	
	Structure ThemedWindow
		*Brush
		*OriginalProc
		
		Width.l
		Height.l
		MinWidth.l
		MinHeight.l
		
		SizeCursor.l
		
		ButtonClose.l
		ButtonMinimize.l
		ButtonMaximize.l
		
		Container.i
		
		Label.i
		LabelWidth.l
		LabelAlign.b
		
		Theme.Theme
	EndStructure
	
	Structure WindowBar
		*Parent
		*OriginalProc
	EndStructure
	
	Structure WindowContainer
		*Parent
		*OriginalProc
		sizeCursor.l
	EndStructure
	
	Global DWMEnabled = -1
	
	Procedure Window_Init()
		Protected Margin.RECT, Window
		
		Window = OpenWindow(#PB_Any, 0, 0, 100, 100, "", #PB_Window_Invisible)
		
		SetRect_(@Margin.RECT, 0, 0, 1, 0)
		If OpenLibrary(0, "dwmapi.dll")
			CallFunction(0, "DwmExtendFrameIntoClientArea", WindowID(Window), @Margin)
			CallFunction(0, "DwmIsCompositionEnabled", @DWMEnabled)
			CloseLibrary(0)
		EndIf
		
		CloseWindow(Window)
	EndProcedure
		
	Procedure CloseButton_Handler()
		PostEvent(#PB_Event_CloseWindow, EventWindow(), 0)
	EndProcedure
	
	Procedure Window_Handler(hWnd, Msg, wParam, lParam)
		Protected *WindowData.ThemedWindow = GetProp_(hWnd, "UITK_WindowData"), cursor.POINT, OffsetX
		
		Select Msg
			Case #WM_GETMINMAXINFO ;{
				Protected *mmi.MINMAXINFO = lParam
				Protected hMon = MonitorFromWindow_(hWnd, #MONITOR_DEFAULTTONEAREST)
				Protected mie.MONITORINFOEX\cbSize = SizeOf(mie)
				GetMonitorInfo_(hMon, mie)
				*mmi\ptMaxPosition\x = Abs(mie\rcWork\left - mie\rcMonitor\left)
				*mmi\ptMaxPosition\y = Abs(mie\rcWork\top - mie\rcMonitor\top)
				*mmi\ptMaxSize\x = Abs(mie\rcWork\right - mie\rcWork\left)
				*mmi\ptMaxSize\y = Abs(mie\rcWork\bottom - mie\rcWork\top) - 1
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
				*WindowData\Width = lParam & $FFFF
				*WindowData\Height = (lParam >> 16) & $FFFF
				
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
				
				If *WindowData\LabelAlign = #AlignRight
					SetWindowPos_(GadgetID(*WindowData\Label), 0, *WindowData\Width - OffsetX, #MenuLabelOffset, 0, 0, #SWP_NOSIZE)
				ElseIf *WindowData\LabelAlign = #AlignCenter
					SetWindowPos_(GadgetID(*WindowData\Label), 0, (*WindowData\Width - *WindowData\LabelWidth) * 0.5, #MenuLabelOffset, 0, 0, #SWP_NOSIZE)
				EndIf
				
				ResizeGadget(*WindowData\Container, #PB_Ignore, #PB_Ignore, *WindowData\Width, *WindowData\Height - #WindowBarHeight)
				
				;}
			Case #WM_NCACTIVATE ;{
				ProcedureReturn 1
				;}
			Case #WM_COMMAND ;{
; 				Select wParam
; 					Case 1
; 						ShowWindow_(hWnd, #SW_MINIMIZE)
; 					Case 2
; 						If IsZoomed_(hWnd)
; 							ShowWindow_(hWnd, #SW_RESTORE)
; 						Else
; 							ShowWindow_(hWnd, #SW_MAXIMIZE)
; 						EndIf
; 					Case 3
; 						SendMessage_(hWnd, #WM_CLOSE, 0, 0)
; 					Case 4
; 						MapWindowPoints_(hWnd, 0, p.POINT, 1)
; 						SendMessage_(hWnd, #WM_SYSMENU, 0, (p\y+22+border)<<16 + p\x)
; 				EndSelect
				;}
			Case #WM_MOUSEMOVE ;{
				Protected posX = lParam & $FFFF
				Protected posY = (lParam >> 16) & $FFFF
				*WindowData\sizeCursor = 0
				
				If IsZoomed_(hWnd) = 0
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
					ElseIf posX <= #SizableBorder And posY > #SizableBorder And posY <= *WindowData\Height - #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
						*WindowData\sizeCursor = #HTLEFT
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
			Case #WM_SYSMENU ;{
				SetWindowLongPtr_(hwnd, #GWL_STYLE, GetWindowLongPtr_(hwnd, #GWL_STYLE)|#WS_SYSMENU)
				DefWindowProc_(hWnd, Msg, wParam, lParam)
				SetWindowLongPtr_(hwnd, #GWL_STYLE, GetWindowLongPtr_(hwnd, #GWL_STYLE)&~#WS_SYSMENU)
				ProcedureReturn 0
				;}
			Case #WM_NCDESTROY ;{
				If *WindowData\ButtonClose And IsGadget(*WindowData\ButtonClose)
					UnbindGadgetEvent(*WindowData\ButtonClose, @CloseButton_Handler(), #PB_EventType_Change)
				EndIf
				
				SetWindowLongPtr_(hWnd, #GWL_WNDPROC, *WindowData\OriginalProc)
				ProcedureReturn 0
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
				
				If posY > *WindowData\Height - #SizableBorder - #WindowBarHeight
					If posX <= #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZENESW))
						*ContainerData\sizeCursor = #HTBOTTOMLEFT
					ElseIf posX > *WindowData\Width - #SizableBorder 
						SetCursor_(LoadCursor_(0, #IDC_SIZENWSE))
						*ContainerData\sizeCursor = #HTBOTTOMRIGHT
					Else
						SetCursor_(LoadCursor_(0, #IDC_SIZENS))
						*ContainerData\sizeCursor = #HTBOTTOM
					EndIf
				ElseIf posX <= #SizableBorder
					SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
					*ContainerData\sizeCursor = #HTLEFT
				ElseIf posX > *WindowData\Width - #SizableBorder 
					SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
					*ContainerData\sizeCursor = #HTRIGHT
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
	
	Procedure WindowBar_Handler(hWnd, Msg, wParam, lParam)
		Protected *WindowBarData.WindowBar = GetProp_(hWnd, "UITK_WindowBarData")
		If msg = #WM_LBUTTONDBLCLK
			If IsZoomed_(*WindowBarData\Parent)
				ShowWindow_(*WindowBarData\Parent, #SW_RESTORE)
			Else
				ShowWindow_(*WindowBarData\Parent, #SW_MAXIMIZE)
			EndIf
		ElseIf msg = #WM_LBUTTONDOWN
			SendMessage_(*WindowBarData\Parent, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
		EndIf
		
		ProcedureReturn CallWindowProc_(*WindowBarData\OriginalProc, hWnd, Msg, wParam, lParam)
	EndProcedure
	
	Procedure Window(Window, X, Y, InnerWidth, InnerHeight, Title.s, Flags = #Default, Parent = #Null)
		Protected Result, Image, *WindowData.ThemedWindow, *WindowBarData.WindowBar, *ContainerData.WindowContainer ,WindowID, OffsetX
		
		If DWMEnabled = - 1
			Window_Init()
		EndIf
		
		If AccessibilityMode Or DWMEnabled = #False Or (Flags & #PB_Window_BorderLess)
			Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, (Bool(Flags & #Window_CloseButton) * #PB_Window_ScreenCentered) |
			                                                                  (Bool(Flags & #Window_MaximizeButton) * #PB_Window_Maximize) |
			                                                                  (Bool(Flags & #Window_MinimizeButton) * #PB_Window_Minimize), Parent)
		Else
			Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, (#WS_OVERLAPPEDWINDOW&~#WS_SYSMENU) | #PB_Window_Invisible, Parent)
			
			If Window = #PB_Any
				Window = Result
			EndIf
			
			WindowID = WindowID(Window)
			
			*WindowData = AllocateStructure(ThemedWindow)
			
			If Flags & #DarkMode
				Image = CreateImage(#PB_Any, 8, 8, 32, FixColor($202225))
			Else
				Image = CreateImage(#PB_Any, 8, 8, 32, FixColor($FFFFFF))
			EndIf
			
			*WindowData\Brush = CreatePatternBrush_(ImageID(Image))
			*WindowData\Width = WindowWidth(Window)
			*WindowData\Height = WindowHeight(Window)

			
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, *WindowData\Theme, Theme)
			Else
				CopyStructure(@DefaultTheme, *WindowData\Theme, Theme)
			EndIf
			
			FreeImage(Image)
			
			SetClassLongPtr_(WindowID, #GCL_HBRBACKGROUND, *WindowData\Brush)
			
			SetProp_(WindowID, "UITK_WindowData", *WindowData)
			
			*WindowData\OriginalProc = SetWindowLongPtr_(WindowID, #GWL_WNDPROC, @Window_Handler())
			
			If Flags & #Window_CloseButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonClose = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "󰖭", Bool(Flags & #DarkMode) * #DarkMode)
				
				SetGadgetFont(*WindowData\ButtonClose, MaterialFont)
				
				If Flags & #DarkMode
					SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Cold, SetAlpha(FixColor($202225), 255))
				Else
					SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Cold, SetAlpha(FixColor($FFFFFF), 255))
				EndIf
				
				BindGadgetEvent(*WindowData\ButtonClose, @CloseButton_Handler(), #PB_EventType_Change)
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Warm, SetAlpha(FixColor($E81123), 255))
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Hot, SetAlpha(FixColor($F1707A), 255))
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Front_Warm, SetAlpha(FixColor($FFFFFF), 255))
				SetGadgetColor(*WindowData\ButtonClose, #Color_Front_Hot, SetAlpha(FixColor($FFFFFF), 255))
			EndIf
			
			If Flags & #Window_MaximizeButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonMaximize = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "󰖯", Bool(Flags & #DarkMode) * #DarkMode)
				
				SetGadgetFont(*WindowData\ButtonMaximize, MaterialFont)
				
				If Flags & #DarkMode
					SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, SetAlpha(FixColor($202225), 255))
				Else
					SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, SetAlpha(FixColor($FFFFFF), 255))
				EndIf
			EndIf
			
			If Flags & #Window_MinimizeButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonMinimize = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "󰖰", Bool(Flags & #DarkMode) * #DarkMode)
				
				SetGadgetFont(*WindowData\ButtonMinimize, MaterialFont)
				
				If Flags & #DarkMode
					SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, SetAlpha(FixColor($202225), 255))
				Else
					SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, SetAlpha(FixColor($FFFFFF), 255))
				EndIf
			EndIf
			
			*WindowData\Label = Label(#PB_Any, #MenuLabelOffset, #MenuLabelOffset, *WindowData\Width - OffsetX, #WindowBarHeight - #MenuLabelOffset , Title, (Bool(Flags & #DarkMode) * #DarkMode) | #AlignLeft)
			If Flags & #DarkMode
				SetGadgetColor(*WindowData\Label, #Color_Parent, SetAlpha(FixColor($202225), 255))
			Else
				SetGadgetColor(*WindowData\Label, #Color_Parent, SetAlpha(FixColor($FFFFFF), 255))
			EndIf
			*WindowData\LabelWidth = GadgetWidth(*WindowData\Label, #PB_Gadget_RequiredSize)
			ResizeGadget(*WindowData\Label, #PB_Ignore, #PB_Ignore, *WindowData\LabelWidth, #PB_Ignore)
			
			If Flags & #AlignRight
				*WindowData\LabelAlign = #AlignRight
			ElseIf Flags & #AlignCenter
				*WindowData\LabelAlign = #AlignCenter
			Else
				*WindowData\LabelAlign = #AlignLeft
			EndIf
			
			*WindowBarData = AllocateStructure(WindowBar)
			*WindowBarData\Parent = WindowID
			UnbindGadgetEvent(*WindowData\Label, @Default_EventHandle())
			SetProp_(GadgetID(*WindowData\Label), "UITK_WindowBarData", *WindowBarData)
			*WindowBarData\OriginalProc = SetWindowLongPtr_(GadgetID(*WindowData\Label), #GWL_WNDPROC, @WindowBar_Handler())
			
			*WindowData\Container = ContainerGadget(#PB_Any, 0, #WindowBarHeight, *WindowData\Width, *WindowData\Height - #WindowBarHeight, #PB_Container_BorderLess)
			*ContainerData.WindowContainer = AllocateStructure(WindowContainer)
			*ContainerData\Parent = WindowID
			SetProp_(GadgetID(*WindowData\Container), "UITK_ContainerData", *WindowBarData)
			*ContainerData\OriginalProc = SetWindowLongPtr_(GadgetID(*WindowData\Container), #GWL_WNDPROC, @WindowContainer_Handler())
			SetGadgetColor(*WindowData\Container, #PB_Gadget_BackColor, RGB(Red(*WindowData\Theme\WindowColor), Green(*WindowData\Theme\WindowColor), Blue(*WindowData\Theme\WindowColor)))
			
			SetWindowPos_(WindowID, 0, 0, 0, 0, 0, #SWP_NOSIZE|#SWP_NOMOVE|#SWP_FRAMECHANGED)
			
			HideWindow(Window, Bool(Flags & #PB_Window_Invisible))
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure OpenWindowGadgetList(Window)
		Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
		
		OpenGadgetList(*WindowData\Container)
	EndProcedure
	
	Procedure SetWindowBounds(Window, MinWidth, MinHeight, MaxWidth, MaxHeight)
		Protected *WindowData.ThemedWindow
		
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		
		*WindowData\MinHeight = MinHeight
		*WindowData\MinWidth = MinWidth
	EndProcedure
	;}
	
	;{ Menu
	#MenuMinimumWidth = 160
	#MenuDefaultItemHeight = 21
	#MenuSeparatorHeight = 9
	#MenuMargin = 3
	#MenuItemLeftMargin = 20 + #menuMargin
	
	Enumeration ;Menu types
		#Item
		#Separator
	EndEnumeration
	
	Structure MenuItem
		Type.b
		Text.s
		Icon.i
		ID.i
	EndStructure
	
	Structure FlatMenu
		Window.i
		Canvas.i
		Height.i
		Width.i
		State.i
		ItemHeight.i
		Vector.b
		FontID.i
		Theme.Theme
		*HotItem
		List Item.MenuItem()
	EndStructure
	
	Procedure FlatMenu_Redraw(*MenuData.FlatMenu)
		Protected Y = #MenuMargin, VerticalOffset
		
		With *MenuData
			StartDrawing(CanvasOutput(\Canvas))
			
			Box(0, 0, \Width, \Height, \Theme\LineColor[#Cold])
			Box(1, 1, \Width - 2, \Height - 2, \Theme\BackColor[#Cold])
			
			DrawingMode(#PB_2DDrawing_Transparent)
			DrawingFont(\FontID)
			VerticalOffset = (\ItemHeight - TextHeight("a")) * 0.5
			
			ForEach \Item()
				If \Item()\Type = #Item
					If ListIndex(\Item()) = \State
						DrawingMode(#PB_2DDrawing_Default)
						Box(#MenuMargin, Y,  \Width - 2 * #MenuMargin, \ItemHeight, \Theme\BackColor[#Hot])
						DrawingMode(#PB_2DDrawing_Transparent)
						DrawText(#MenuItemLeftMargin, Y + VerticalOffset, \Item()\Text, \Theme\FrontColor[#Hot])
					Else
						DrawText(#MenuItemLeftMargin, Y + VerticalOffset, \Item()\Text, \Theme\FrontColor[#Cold])
					EndIf
					Y + \ItemHeight
				Else
					Line(2 * #MenuMargin, Y + Floor(#MenuSeparatorHeight * 0.5), \Width - 4 * #MenuMargin, 1, \Theme\LineColor[#Cold])
					Y + #MenuSeparatorHeight
				EndIf
			Next
			
			StopDrawing()
		EndWith
	EndProcedure
	
	Procedure FlatMenu_VectorRedraw(*MenuData.FlatMenu)
		
		With *MenuData
			StartVectorDrawing(CanvasVectorOutput(\Canvas))
			
			AddPathBox(0, 0, \Width, \Height)
			VectorSourceColor(\Theme\BackColor[#Cold])
			FillPath()
			
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure FlatMenu_CanvasEvent()
		Protected *MenuData.FlatMenu = GetProp_(GadgetID(EventGadget()), "UITK_MenuData"), Y, MouseY, State = - 1, Redraw
		
		With *MenuData
			Select EventType()
				Case #PB_EventType_MouseMove ;{
					MouseY = GetGadgetAttribute(\Canvas, #PB_Canvas_MouseY)
					Y = #MenuMargin
					
					If MouseY > #MenuMargin
						ForEach \Item()
							If \Item()\Type = #Item
								Y + \ItemHeight
								If MouseY <= Y
									State = ListIndex(\Item())
									Break
								EndIf
							Else
								Y + #MenuSeparatorHeight
								If MouseY <= Y
									Break
								EndIf
							EndIf
						Next
					EndIf
					
					If State <> \State
						\State = State
						Redraw = #True
					EndIf
					;}
				Case #PB_EventType_MouseLeave ;{
					If \State <> -1
						\State = -1
						Redraw = #True
					EndIf
					;}
				Case #PB_EventType_LeftClick ;{
					If \State > -1
						SelectElement(\Item(), \State)
						PostEvent(#PB_Event_Menu, EventWindow(), \Item()\ID)
						HideWindow(\Window, #True)
						Redraw = #True
					EndIf
					;}
			EndSelect
			
			If Redraw
				If \Vector
					FlatMenu_VectorRedraw(*MenuData)
				Else
					FlatMenu_Redraw(*MenuData)
				EndIf
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure FlatMenu_WindowEvent()
		Protected *MenuData.FlatMenu = GetProp_(WindowID(EventWindow()), "UITK_MenuData"), PreviousState
		
		With *MenuData
			HideWindow(\Window, #True)
			
			If \State <> -1
				PreviousState = \State
				\State = -1
				If \Vector
					FlatMenu_VectorRedraw(*MenuData)
				Else
					FlatMenu_Redraw(*MenuData)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure FlatMenu(ParentID, Flags = #Default)
		Protected Result, *MenuData.FlatMenu, GadgetList = UseGadgetList(0)
		
		*MenuData = AllocateStructure(FlatMenu)
		
		With *MenuData
			\Window = OpenWindow(#PB_Any, 0, 0, #MenuMinimumWidth, 0, "", #PB_Window_BorderLess | #PB_Window_Invisible, ParentID)
			\Canvas = CanvasGadget(#PB_Any, 0, 0, #MenuMinimumWidth, 0, #PB_Canvas_Keyboard)
			\ItemHeight = #MenuDefaultItemHeight
			\Vector = Bool(Flags & #Vector)
			\Width = #MenuMinimumWidth
			\Height = 2 * #MenuMargin
			\FontID = DefaultFont
			\State = -1
			
			If Flags & #DarkMode
				CopyStructure(DarkTheme, \Theme, Theme)
			Else
				CopyStructure(DefaultTheme, \Theme, Theme)
			EndIf
			
			SetProp_(WindowID(\Window), "UITK_MenuData", *MenuData)
			SetProp_(GadgetID(\Canvas), "UITK_MenuData", *MenuData)
			
			BindEvent(#PB_Event_DeactivateWindow, @FlatMenu_WindowEvent(), \Window)
			BindGadgetEvent(\Canvas, @FlatMenu_CanvasEvent())
			
			UseGadgetList(GadgetList)
		EndWith
		ProcedureReturn *MenuData\Window
	EndProcedure
	
	Procedure ShowFlatMenu(FlatMenu, X = -1, Y = -1)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(FlatMenu), "UITK_MenuData")
		
		ExamineDesktops()
		
		If X = -1 And Y = -1
			X = DesktopMouseX()
			Y = DesktopMouseY()
		EndIf
		
		ResizeWindow(*MenuData\Window, X, Y, #PB_Ignore, #PB_Ignore)
		HideWindow(*MenuData\Window, #False)
		SetActiveGadget(*MenuData\Canvas)
	EndProcedure
	
	Procedure AddFlatMenuItem(Menu, MenuItem, Position, Text.s, ImageID = 0, SubMenu = 0) 
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData"), TextWidth
		
		With *MenuData
			If Position < 0 Or Position >= ListSize(\Item())
				LastElement(\Item())
				AddElement(\Item())
			Else
				SelectElement(\Item(), Position)
				InsertElement(\Item())
			EndIf
			
			\Item()\Type = #Item
			\Item()\Text = Text
			\Item()\ID = MenuItem
			\Height + \ItemHeight
			
			If \Vector
				StartVectorDrawing(CanvasVectorOutput(\Canvas))
				VectorFont(\FontID)
				TextWidth = VectorTextWidth(Text)
				StopVectorDrawing()
			Else
				StartDrawing(CanvasOutput(\Canvas))
				DrawingFont(\FontID)
				TextWidth = TextWidth(Text)
				StopDrawing()
			EndIf
			
			If TextWidth + #MenuItemLeftMargin + #MenuMargin > \Width
				\Width = TextWidth + #MenuItemLeftMargin + #MenuMargin
			EndIf
			
			ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width, \Height)
			ResizeGadget(\Canvas, 0, 0, \Width, \Height)
			
			If \Vector
				FlatMenu_VectorRedraw(*MenuData)
			Else
				FlatMenu_Redraw(*MenuData)
			EndIf
			
		EndWith
	EndProcedure
		
	Procedure AddFlatMenuSeparator(Menu, Position)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		
		With *MenuData
			If Position < 0 Or Position >= ListSize(\Item())
				LastElement(\Item())
				AddElement(\Item())
			Else
				SelectElement(\Item(), Position)
				InsertElement(\Item())
			EndIf
			
			\Item()\Type = #Separator
			
			ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width, \Height)
			ResizeGadget(\Canvas, 0, 0, \Width, \Height)
			
			\Height + #MenuSeparatorHeight
			
			If \Vector
				FlatMenu_VectorRedraw(*MenuData)
			Else
				FlatMenu_Redraw(*MenuData)
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure RemoveFlatMenuItem(Menu, Position)
		
		
	EndProcedure

	; Getters
	Procedure FlatMenuWidth(FlatMenu)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(FlatMenu), "UITK_MenuData")
		
		ProcedureReturn *MenuData\Width
	EndProcedure
	
	Procedure FlatMenuHeight(FlatMenu)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(FlatMenu), "UITK_MenuData")
		
		ProcedureReturn *MenuData\Height
	EndProcedure
	
	; Setters
	
	;}
	
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
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\BackColor[\MouseState])
			ElseIf \TextAlignement = #AlignLeft
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\BackColor[\MouseState])
			Else
				DrawText((\Width - TextWidth(\Text)) * 0.5, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState], \Theme\BackColor[\MouseState])
			EndIf
		EndWith
	EndProcedure
	
	Procedure Button_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		With *GadgetData
			AddPathBox(\OriginX, \OriginY, \Width, \Height, #PB_Path_Default)
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
					If *GadgetData\OriginalVT\GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
						If \Toggle
							\State = Bool(Not \State) * #hot
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						
						\MouseState = #Hot
						Redraw = #True
					EndIf
				Case #KeyUp
					If *GadgetData\OriginalVT\GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
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
			DrawingMode(#PB_2DDrawing_Transparent)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState])
				X = #ToggleSize * 0.5 + BorderMargin
			Else
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState])
				X = \Width - #ToggleSize * 1.5 - BorderMargin - 1
			EndIf
			
			DrawingMode(#PB_2DDrawing_Default)
			
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
					If *GadgetData\OriginalVT\GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
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
			DrawingMode(#PB_2DDrawing_Transparent)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState])
				X = BorderMargin
			Else
				DrawText(BorderMargin, (\Height - TextHeight(\Text) * 1.05) * 0.5, \Text, \Theme\FrontColor[\MouseState])
				X = \Width - #CheckboxSize - BorderMargin
			EndIf
			
			DrawingMode(#PB_2DDrawing_Default)
			
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
					If *GadgetData\OriginalVT\GetGadgetAttribute(\Gadget, #PB_Canvas_Key) = #PB_Shortcut_Space
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
		ScrollStep.l
	EndStructure
	
	Procedure ScrollBar_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ScrollBarData = *this\vt, Radius
		
		With *GadgetData
			Radius = Floor(\Thickness * 0.5)
			Circle(Radius, Radius, Radius, \Theme\BackColor[#Cold])
			
			If \Vertical
				Box(0, Radius, \Width, \Height - \Thickness, \Theme\BackColor[#Cold])
				Circle(Radius, \Height - Radius - 1, Radius, \Theme\BackColor[#Cold])
				
				If \BarSize >= 0
					Circle(Radius, Radius + \Position, Radius, \Theme\LineColor[\MouseState])
					Box(0, Radius + \Position, \Width, \BarSize, \Theme\LineColor[\MouseState])
					Circle(Radius, Radius + \Position + \BarSize, Radius, \Theme\LineColor[\MouseState])
				EndIf
			Else
				Box(Radius, 0, \Width - \Thickness, \Height, \Theme\BackColor[#Cold])
				Circle(\Width - Radius - 1, Radius, Radius, \Theme\BackColor[#Cold])
				
				If \BarSize >= 0
					Circle(Radius + \Position, Radius, Radius, \Theme\LineColor[\MouseState])
					Box(Radius + \Position, 0, \BarSize, \Height, \Theme\LineColor[\MouseState])
					Circle(Radius + \Position + \BarSize, Radius, Radius, \Theme\LineColor[\MouseState])
				EndIf
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
				
				If \BarSize >= 0
					AddPathCircle(\OriginX + Radius, \OriginY + Radius + \Position, Radius, 0, 360, #PB_Path_Default)
					AddPathBox(- \Thickness, 0, \Width, \BarSize, #PB_Path_Relative)
					AddPathCircle(\OriginX + Radius, \OriginY + Radius + \BarSize + \Position, Radius, 0, 360, #PB_Path_Default)
					
					FillPath(#PB_Path_Winding)
				EndIf
			Else
				AddPathBox(- Radius, - Radius, \Width - \Thickness, \Height, #PB_Path_Relative)
				AddPathCircle(\OriginX + \Width - Radius, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
				FillPath(#PB_Path_Winding)
				
				If \BarSize >= 0
					VectorSourceColor(\Theme\LineColor[\MouseState])
					
					AddPathCircle(\OriginX + Radius + \Position, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
					AddPathBox(- Radius, - Radius, \BarSize, \Height, #PB_Path_Relative)
					AddPathCircle(\OriginX + Radius + \Position + \BarSize, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
					
					FillPath(#PB_Path_Winding)
				EndIf
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
							\State = Round(Position / (Lenght) * (\Max - \Min - \PageLenght), #PB_Round_Down)
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
					If \BarSize >= 0
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
							\Position = Round(\State / (\Max - \Min) * Lenght, #PB_Round_Nearest)
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					\Drag = #False
					;}
				Case #MouseWheel ;{
					If \Vertical
						Mouse = *Event\MouseY
						Lenght = \Height
					Else
						Mouse = *Event\MouseX
						Lenght = \Width
					EndIf
					
					Position = Clamp(\State - *GadgetData\OriginalVT\GetGadgetAttribute(*GadgetData\Gadget, #PB_Canvas_WheelDelta) * \ScrollStep, \Min, \Max - \PageLenght)
					If Position <> \State
						\State = Position
						\Position = Round(\State / (\Max - \Min) * Lenght, #PB_Round_Nearest)
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						Redraw = #True
					EndIf
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure ScrollBar_GetAttribute(*This.PB_Gadget, Attribute)
		Protected *GadgetData.ScrollBarData = *this\vt, Result
		
		Select Attribute
			Case #ScrollBar_Minimum
				Result = *GadgetData\Min
			Case #ScrollBar_Maximum
				Result = *GadgetData\Max
			Case #ScrollBar_PageLength
				Result = *GadgetData\PageLenght
			CompilerIf #PB_Compiler_Debugger
			Default	
				Debug "WARNING! Attribute #"+Attribute+ " unused on Scrollbar gadget... Might be wanting to get canvas attribute?"
			CompilerEndIf
		EndSelect
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure ScrollBar_SetAttribute(*This.PB_Gadget, Attribute, Value)
		Protected *GadgetData.ScrollBarData = *this\vt, Result
		
		With *GadgetData
			Select Attribute
				Case #ScrollBar_Minimum ;{
					If Value < \Max
						\Min = Value
						
						If \State < \Min
							\State = \Min
						EndIf
						
						If \PageLenght >= (\Max - \Min)
							\BarSize = -1
						EndIf
						
						If \Vertical
							\Position = Round(\State / (\Max - \Min) * \Height, #PB_Round_Nearest)
						Else
							\Position = Round(\State / (\Max - \Min) * \Width, #PB_Round_Nearest)
						EndIf
						
						RedrawObject()
					EndIf
					;}
				Case #ScrollBar_Maximum ;{
					If Value > \Min
						\Max = Value
						
						If \State < \Max
							\State = \Max
						EndIf
						
						If \PageLenght >= (\Max - \Min)
							\BarSize = -1
						EndIf
						
						If \Vertical
							\Position = Round(\State / (\Max - \Min) * \Height, #PB_Round_Nearest)
						Else
							\Position = Round(\State / (\Max - \Min) * \Width, #PB_Round_Nearest)
						EndIf
						
						RedrawObject()
					EndIf
					;}
				Case #ScrollBar_PageLength ;{
					Result = \PageLenght
					If \PageLenght >= (\Max - \Min)
						\BarSize = -1
					Else
						\PageLenght = Value
						If \Vertical = #True
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
					EndIf
					
					RedrawObject()
					;}
					CompilerIf #PB_Compiler_Debugger
					Default	
						Debug "WARNING! Attribute #"+Attribute+ " unused on Scrollbar gadget... Might be wanting to set canvas attribute?"
					CompilerEndIf
			EndSelect
		EndWith
	
		ProcedureReturn Result
	EndProcedure
	
	Procedure Scrollbar_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.ScrollBarData = *this\vt, Lenght
		
		With *GadgetData
			
			State = Clamp(State, \Min, \Max)
			If State <> \State
				\State = State
				If \Vertical
					Lenght = \Height
				Else
					Lenght = \Width
				EndIf
				
				\Position = Round(\State / (\Max - \Min) * Lenght, #PB_Round_Nearest)
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
				\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
			Else
				\Thickness = \Height
				\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
			EndIf
			
			If \PageLenght >= (\Max - \Min)
				\BarSize = -1
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
					
					If \PageLenght >= (\Max - \Min)
						\BarSize = -1
					EndIf
					
					\ScrollStep = 3
					
					\VT\GetGadgetAttribute = @ScrollBar_GetAttribute()
					\VT\SetGadgetAttribute = @ScrollBar_SetAttribute()
					\VT\SetGadgetState = @Scrollbar_SetState()
					\VT\ResizeGadget = @Scrollbar_Resize()
					
					; Enable only the needed events
					\SupportedEvent[#MouseWheel] = #True
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
	
	;{ Label Gadget
	Structure LabelData Extends GadgetData
		Text.s
	EndStructure
	
	Procedure Label_Redraw(*this.PB_Gadget)
		Protected *GadgetData.LabelData = *this\vt
		
		With *GadgetData
			DrawingFont(\FontID)
			DrawingMode(#PB_2DDrawing_Transparent)
			
			If \TextAlignement = #AlignRight
				DrawText((\Width - TextWidth(\Text)) - BorderMargin, BorderMargin, \Text, \Theme\FrontColor[#Cold])
			ElseIf \TextAlignement = #AlignLeft
				DrawText(BorderMargin, BorderMargin, \Text, \Theme\FrontColor[#Cold])
			Else
				DrawText((\Width - TextWidth(\Text)) * 0.5, BorderMargin, \Text, \Theme\FrontColor[#Cold], \Theme\BackColor[#Cold])
			EndIf
		EndWith
	EndProcedure
	
	Procedure Label_RedrawVector(*this.PB_Gadget)
		Protected *GadgetData.LabelData = *this\vt
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\FrontColor[#Cold])
			
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
	
	Procedure Label_EventHandler(*this.PB_Gadget, *Event.Event)
	EndProcedure
	
	; Getters
	Procedure.s Label_GetText(*this.PB_Gadget)
		Protected *GadgetData.LabelData = *this\vt
		
		ProcedureReturn *GadgetData\Text
	EndProcedure
		
	; Setters
	Procedure Label_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.LabelData = *this\vt
		*GadgetData\Text = Text
		RedrawObject()
	EndProcedure
	
	Procedure Label(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.LabelData
		
		If AccessibilityMode
			Result = TextGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #AlignRight) * #PB_Text_Right) |
			                                                       (Bool(Flags & #AlignCenter) * #PB_Text_Center) |
			                                                       (Bool(Flags & #Border) * #PB_Text_Border))
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(Label)
				
				With *GadgetData
					\Text = Text
					If Flags & #AlignRight
						\TextAlignement = #AlignRight
					ElseIf Flags & #AlignCenter
						\TextAlignement = #AlignCenter
					Else
						\TextAlignement = #AlignLeft
					EndIf
					
					; Functions
					\VT\GetGadgetText = @Label_GetText()
					
					\VT\SetGadgetText = @Label_SetText()
					
					If \Vector
						StartVectorDrawing(CanvasVectorOutput(\Gadget))
						VectorFont(\FontID)
						\RequieredHeight = VectorTextHeight(\Text)
						\RequieredWidth = VectorTextWidth(\Text)
						StopVectorDrawing()
					Else
						StartDrawing(CanvasOutput(\Gadget))
						DrawingFont(\FontID)
						\RequieredHeight = TextHeight(\Text)
						\RequieredWidth = TextWidth(\Text)
						StopDrawing()
					EndIf
					
					UnbindGadgetEvent(*GadgetData\Gadget, *GadgetData\DefaultEventHandler)
					*GadgetData\DefaultEventHandler = 0
				EndWith
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ ScrollArea
	#ScrollArea_Bar_Thickness = 7
	
	Structure ScrollAreaData Extends GadgetData
		ScrollArea.i
		VerticalScrollbar.i
		HorizontalScrollbar.i
		HiddenVScrollBar.i
		HiddenHScrollBar.i
	EndStructure
	
	Global ScrollbarThickness
	
	Procedure ScrollArea_ScrollbarHandler()
		Protected Gadget = EventGadget(), *GadgetData.ScrollAreaData = GetProp_(GadgetID(Gadget), "UITK_ScrollAreaData")
		
		If Gadget = *GadgetData\HorizontalScrollbar
			SetGadgetAttribute(*GadgetData\ScrollArea, #PB_ScrollArea_X, GetGadgetState(Gadget))
		Else
			SetGadgetAttribute(*GadgetData\ScrollArea, #PB_ScrollArea_Y, GetGadgetState(Gadget))
		EndIf
		
	EndProcedure
	
	Procedure ScrollArea_Handler()
		Protected Gadget, *GadgetData.ScrollAreaData

		If EventType() = 0
			Gadget = EventGadget()
			*GadgetData = GetProp_(GadgetID(Gadget), "UITK_ScrollAreaData")
 			SetGadgetState(*GadgetData\VerticalScrollbar, GetGadgetAttribute(Gadget, #PB_ScrollArea_Y))
		EndIf
	EndProcedure
	
	Procedure ScrollArea_Resize(*this.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			
		EndWith
	EndProcedure
	
	Procedure ScrollArea_Free(*this.PB_Gadget)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		With *GadgetData
			If IsGadget(*GadgetData\VerticalScrollbar) : FreeGadget(*GadgetData\VerticalScrollbar) : EndIf
			If IsGadget(*GadgetData\HorizontalScrollbar) : FreeGadget(*GadgetData\HorizontalScrollbar) : EndIf
			If IsGadget(*GadgetData\ScrollArea) : FreeGadget(*GadgetData\ScrollArea) : EndIf
			
			*this\vt = *GadgetData\OriginalVT
			FreeStructure(*GadgetData)
			CallFunctionFast(*this\vt\FreeGadget, *this)
		EndWith
	EndProcedure
	
	Procedure ScrollArea_GetAttribute(*This.PB_Gadget, Attribute)
		Protected *GadgetData.ScrollAreaData = *this\vt, Result
		
		With *GadgetData
			Result = GetGadgetAttribute(*GadgetData\ScrollArea, Attribute)
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure ScrollArea_SetAttribute(*This.PB_Gadget, Attribute, Value)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		SetGadgetAttribute(*GadgetData\ScrollArea, Attribute, Value)
		
		With *GadgetData
			Select Attribute
				Case #ScrollArea_InnerWidth
					SetGadgetAttribute(*GadgetData\ScrollArea, #ScrollArea_InnerWidth, Value)
					SetGadgetAttribute(*GadgetData\HorizontalScrollbar, #ScrollBar_Maximum, Value)
					
; 					If Value <= \Width + Bool(Not \HiddenVScrollBar) * #ScrollArea_Bar_Thickness
; 						If Not \HiddenHScrollBar
; 							\HiddenHScrollBar = #True
; 							HideGadget(\HorizontalScrollbar, #True)
; 							ResizeGadget(*GadgetData\Gadget, #PB_Ignore, #PB_Ignore, \Width - #ScrollArea_Bar_Thickness * Bool(Not \HiddenVScrollBar), \Height - #ScrollArea_Bar_Thickness * Bool(Not \HiddenHScrollBar))
; 						EndIf
; 					Else
; 						If \HiddenHScrollBar
; 							\HiddenHScrollBar = #False
; 							ResizeGadget(*GadgetData\Gadget, #PB_Ignore, #PB_Ignore, \Width - #ScrollArea_Bar_Thickness * Bool(Not \HiddenVScrollBar), \Height - #ScrollArea_Bar_Thickness * Bool(Not \HiddenHScrollBar))
; 							HideGadget(\HorizontalScrollbar, #True)
; 						EndIf
; 					EndIf
						
				Case #ScrollArea_InnerHeight
					SetGadgetAttribute(*GadgetData\VerticalScrollbar, #ScrollBar_Maximum, Value)
					SetGadgetAttribute(*GadgetData\ScrollArea, #ScrollArea_InnerHeight, Value)
					
; 					If Value >= \Height + Bool(Not \HiddenVScrollBar) * #ScrollArea_Bar_Thickness
; 						If Not \HiddenHScrollBar
; 							\HiddenHScrollBar = #True
; 							HideGadget(\VerticalScrollbar, #True)
; 							ResizeGadget(*GadgetData\Gadget, #PB_Ignore, #PB_Ignore, \Width - #ScrollArea_Bar_Thickness * Bool(Not \HiddenVScrollBar), \Height - #ScrollArea_Bar_Thickness * Bool(Not \HiddenHScrollBar))
; 						EndIf
; 					Else
; 						If \HiddenHScrollBar
; 							\HiddenHScrollBar = #False
; 							HideGadget(\VerticalScrollbar, #False)
; 							ResizeGadget(*GadgetData\Gadget, #PB_Ignore, #PB_Ignore, \Width - #ScrollArea_Bar_Thickness * Bool(Not \HiddenVScrollBar), \Height - #ScrollArea_Bar_Thickness * Bool(Not \HiddenHScrollBar))
; 						EndIf
; 					EndIf
				Case #ScrollArea_X
					
				Case #ScrollArea_Y
					
				Case #ScrollArea_ScrollStep
					
			EndSelect
		EndWith
	EndProcedure
	
	Procedure ScrollArea_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		With *GadgetData
			Select ColorType
				Case #Color_Back_Cold
					*GadgetData\Theme\BackColor[#Cold] = Color
				Case #Color_Back_Warm
					*GadgetData\Theme\BackColor[#Warm] = Color
				Case #Color_Back_Hot
					*GadgetData\Theme\BackColor[#Hot] = Color
				Case #Color_Front_Cold
					*GadgetData\Theme\FrontColor[#Cold] = Color
				Case #Color_Front_Warm
					*GadgetData\Theme\FrontColor[#Warm] = Color
				Case #Color_Front_Hot
					*GadgetData\Theme\FrontColor[#Hot] = Color
				Case #Color_Line
					*GadgetData\Theme\LineColor = Color
				Case #Color_Parent
					*GadgetData\Theme\WindowColor = Color
			EndSelect
		EndWith
	EndProcedure
	
	Procedure ScrollArea(Gadget, x, y, Width, Height, ScrollAreaWidth, ScrollAreaHeight, ScrollStep = #Default, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ScrollAreaData, ScrollBar
		
		If AccessibilityMode
			Result = ScrollAreaGadget(Gadget, x, y, Width, Height, ScrollAreaWidth, ScrollAreaHeight)
		Else
			Result = ContainerGadget(Gadget, x, y, Width - #ScrollArea_Bar_Thickness, Height - #ScrollArea_Bar_Thickness, #PB_Container_BorderLess)
			
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			If ScrollStep = 0
				ScrollStep = 3
			EndIf
			
			If ScrollbarThickness = 0
				ScrollBar = ScrollBarGadget(#PB_Any, 0, 0, 100, 20, 0, 10, 1)
				ScrollbarThickness = GadgetHeight(ScrollBar, #PB_Gadget_RequiredSize)
				FreeGadget(ScrollBar)
			EndIf
			
			*GadgetData = AllocateStructure(ScrollAreaData)
			
			With *GadgetData
				\Gadget = Gadget
				*this = IsGadget(Gadget)
				CopyMemory(*this\vt, \vt, SizeOf(GadgetVT))
				\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *GadgetData\Theme, Theme)
				Else
					CopyStructure(@DefaultTheme, *GadgetData\Theme, Theme)
				EndIf
				
				*GadgetData\ScrollArea = ScrollAreaGadget(#PB_Any, 0, 0, Width - #ScrollArea_Bar_Thickness + ScrollbarThickness, Height - #ScrollArea_Bar_Thickness + ScrollbarThickness, ScrollAreaWidth, ScrollAreaHeight, ScrollStep, #PB_ScrollArea_BorderLess)
				SetProp_(GadgetID(\ScrollArea), "UITK_ScrollAreaData", *GadgetData)
				BindGadgetEvent(\ScrollArea, @ScrollArea_Handler())
				
				If Flags & #DarkMode
					SetGadgetColor(\ScrollArea, #PB_Gadget_BackColor, RGB(Red(DarkTheme\WindowColor), Green(DarkTheme\WindowColor), Blue(DarkTheme\WindowColor)))
				EndIf
				
				CloseGadgetList()
				CloseGadgetList()
				
				\Width = Width
				\Height = Height
				\VerticalScrollbar = ScrollBar(#PB_Any, x + \Width - #ScrollArea_Bar_Thickness, y, #ScrollArea_Bar_Thickness, \Height - #ScrollArea_Bar_Thickness, 0, ScrollAreaHeight + #ScrollArea_Bar_Thickness, \Height, #ScrollBar_Vertical |
				                                                                                                                                                                                                                     (Bool(Flags & #DarkMode) * #DarkMode) |
				                                                                                                                                                                                                                     (Bool(Flags & #Vector) * #Vector))
				BindGadgetEvent(\VerticalScrollbar, @ScrollArea_ScrollbarHandler(), #PB_EventType_Change)
				SetProp_(GadgetID(\VerticalScrollbar), "UITK_ScrollAreaData", *GadgetData)
				
				\HorizontalScrollbar = ScrollBar(#PB_Any, x, y + \Height - #ScrollArea_Bar_Thickness, \Width - #ScrollArea_Bar_Thickness, #ScrollArea_Bar_Thickness, 0, ScrollAreaWidth + #ScrollArea_Bar_Thickness, \Width, (Bool(Flags & #DarkMode) * #DarkMode) |
				                                                                                                                                                                                                                     (Bool(Flags & #Vector) * #Vector))
				BindGadgetEvent(\HorizontalScrollbar, @ScrollArea_ScrollbarHandler(), #PB_EventType_Change)
				SetProp_(GadgetID(\HorizontalScrollbar), "UITK_ScrollAreaData", *GadgetData)
				
				\VT\GetGadgetAttribute = @ScrollArea_GetAttribute()
				
				\VT\SetGadgetAttribute = @ScrollArea_SetAttribute()
				\VT\SetGadgetColor = @ScrollArea_SetColor()
				
				\VT\ResizeGadget = @ScrollArea_Resize()
				\VT\FreeGadget = @ScrollArea_Free()
				
				OpenGadgetList(\ScrollArea)
			EndWith
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ One-way List
	Structure OneWayList Extends GadgetData
		
	EndStructure
	
	
	;}
	
	;{ Two-way list
	Structure TwoWayList Extends GadgetData
		
	EndStructure
	
	
	;}
EndModule
































; IDE Options = PureBasic 6.00 Beta 6 (Windows - x64)
; CursorPosition = 1383
; FirstLine = 150
; Folding = PsDAAAAIAAAYJCAAAAACBAAw
; EnableXP