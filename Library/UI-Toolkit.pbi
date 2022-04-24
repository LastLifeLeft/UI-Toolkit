﻿DeclareModule UITK
	;{ Private variables, structures and constants
	EnumerationBinary ; Gadget flags
		; General
		#Default
		#HAlignCenter									; Center text
		#HAlignLeft										; Align text left
		#HAlignRight									; Align text right
		#VAlignTop										; Align text top
		#VAlignCenter									; Center text
		#VAlignBottom									; Align text bottom
		#Border											; Draw a border arround the gadget
		#DarkMode										; Use the dark color scheme
		#LightMode										; Use the light color scheme
		
		; Special
		#Button_Toggle									; Creates a toggle button: one click pushes it, another will release it.
		#ScrollBar_Vertical								; The scrollbar is vertical (instead of horizontal, which is the default).
		#Trackbar_Vertical								; The trackbar is vertical (instead of horizontal which is the default).
		
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
		#Color_Text_Cold	= #PB_Gadget_FrontColor
		#Color_Back_Cold	= #PB_Gadget_BackColor 
		#Color_Line			= #PB_Gadget_LineColor 
		
		#Color_Back_Warm
		#Color_Back_Hot
		
		#Color_Text_Warm
		#Color_Text_Hot
		
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
	Declare SetWindowIcon(Window, Image)
	Declare GetWindowIcon(Window)
	
	; Menu
	Declare FlatMenu(Flags = #Default)
	Declare AddFlatMenuItem(Menu, MenuItem, Position, Text.s, ImageID = 0, SubMenu = 0)
	Declare RemoveFlatMenuItem(Menu, Position)
	Declare AddFlatMenuSeparator(Menu, Position)
	Declare ShowFlatMenu(FlatMenu, X = -1, Y = -1)
	
	; Gadgets
	Declare GetGadgetImage(Gadget)
	Declare SetGadgetImage(Gadget, Image)
	Declare Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags = #Default)
	Declare Label(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollArea(Gadget, x, y, Width, Height, ScrollAreaWidth, ScrollAreaHeight, ScrollStep = #Default, Flags = #Default)
	Declare TrackBar(Gadget, x, y, Width, Height, Minimum, Maximum, Flags = #Default)
	Declare Combo(Gadget, x, y, Width, Height, Flags = #Default)
	
	; Misc
	
	
	;}
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
		ElseIf Flags & #LightMode
			CopyStructure(@DefaultTheme, *GadgetData\Theme, Theme)
		Else
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
			If *WindowData
				CopyStructure(@*WindowData\Theme, *GadgetData\Theme, Theme)
			Else
				CopyStructure(@DefaultTheme, *GadgetData\Theme, Theme)
			EndIf
		EndIf
		
		*GadgetData\Redraw = @GadgetType#_Redraw()
		
		If Flags & #HAlignCenter
			*GadgetData\TextBock\HAlign = #HAlignCenter
		ElseIf Flags & #HAlignRight
			*GadgetData\TextBock\HAlign = #HAlignRight
		Else
			*GadgetData\TextBock\HAlign = #HAlignLeft
		EndIf
		
		If Flags & #VAlignCenter
			*GadgetData\TextBock\VAlign = #VAlignCenter
		ElseIf Flags & #VAlignBottom
			*GadgetData\TextBock\VAlign = #VAlignBottom
		Else
			*GadgetData\TextBock\VAlign = #VAlignTop
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
		*GadgetData\VT\GetGadgetText = @Default_GetText()
		
		; Setters
		*GadgetData\VT\SetGadgetFont = @Default_SetFont()
		*GadgetData\VT\SetGadgetColor = @Default_SetColor()
		*GadgetData\VT\SetGadgetState = @Default_SetState()
		*GadgetData\VT\SetGadgetText = @Default_SetText()
		
		*GadgetData\DefaultEventHandler = @Default_EventHandle()
		
		*GadgetData\TextBock\LineLimit = -1
		*GadgetData\TextBock\FontID = DefaultFont
		
		BindGadgetEvent(Gadget, *GadgetData\DefaultEventHandler)
	EndMacro
	
	Macro RedrawObject()
		If *GadgetData\MetaGadget
			*GadgetData\Redraw(*this)
		Else
			StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
			AddPathBox(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, #PB_Path_Default)
			ClipPath(#PB_Path_Preserve)
			VectorSourceColor(*GadgetData\Theme\WindowColor)
			FillPath()
			*GadgetData\Redraw(*this)
			StopVectorDrawing()
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
		7 * \Border
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
	
	Structure Text
		OriginalText.s
		LineCount.b
		LineLimit.b
		Image.i
		ImageX.i
		ImageY.i
		Text.s
		TextX.i
		TextY.i
		VectorAlign.i
		FontID.i
		HAlign.b
		VAlign.b
		Width.l
		Height.l
		RequieredWidth.w
		RequieredHeight.w
	EndStructure
	
	Structure Theme
		BackColor.l[4]
		FrontColor.l[4]
		ShaderColor.l[4]
		TextColor.l[4]
		LineColor.l[4]
		Special1.l[4]
		Special2.l[4]
		Special3.l[4]
		WindowColor.l
		Highlight.l
	EndStructure
	
	Prototype Redraw(*this.PB_Gadget)
	Prototype EventHandler(*this.PB_Gadget, *Event.Event)
	
	Structure GadgetData
		VT.GadgetVT ;Must be the first element of this structure!
		*OriginalVT.GadgetVT
		Gadget.i
		*MetaGadget
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
		
		HMargin.w
		VMargin.w
		
		Redraw.Redraw
		EventHandler.EventHandler
		Theme.Theme
		TextBock.Text
		ParentWindow.i
		
		*DefaultEventHandler
	EndStructure
	
	Global AccessibilityMode = #False
	Global DefaultTheme.Theme, DarkTheme.Theme
	Global DefaultFont = FontID(LoadFont(#PB_Any, "Segoe UI", 9, #PB_Font_HighQuality))
	Global BoldFont = FontID(LoadFont(#PB_Any, "Segoe UI Black", 7, #PB_Font_HighQuality))
	Global MaterialFont = FontID(LoadFont(#PB_Any, "Material Design Icons Desktop", 12, #PB_Font_HighQuality))
	
	;{ Set default themes
	With DefaultTheme 
		\WindowColor = SetAlpha(FixColor($F0F0F0), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($F0F0F0), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($D8E6F2), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($C0DCF3), 255)
		
		\FrontColor[#Cold]		= SetAlpha(FixColor($ADADAD), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($999999), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($999999), 255)
		
		\ShaderColor[#Cold]		= SetAlpha(FixColor($DEDEDE), 255)
		\ShaderColor[#Warm]		= SetAlpha(FixColor($D3D3D3), 255)
		\ShaderColor[#Hot]		= SetAlpha(FixColor($C0DCF3), 255)
		
		\LineColor[#Cold]		= SetAlpha(FixColor($ADADAD), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($90C8F6), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($90C8F6), 255)
		
		\TextColor[#Cold] 		= SetAlpha(FixColor($000000), 255)
		\TextColor[#Warm]		= SetAlpha(FixColor($000000), 255)
		\TextColor[#Hot]		= SetAlpha(FixColor($000000), 255)
		
		\Special1[#Cold]		= SetAlpha(FixColor($D83C3E), 255)
		\Special1[#Warm]		= SetAlpha(FixColor($E06365), 255)
		\Special1[#Hot]			= SetAlpha(FixColor($E06365), 255)
		
		\Special2[#Cold]		= SetAlpha(FixColor($3AA55D), 255)
		\Special2[#Warm]		= SetAlpha(FixColor($6BD08B), 255)
		\Special2[#Hot]			= SetAlpha(FixColor($6BD08B), 255)
		
		\Special3[#Cold]		= SetAlpha(FixColor($5865F2), 255)
		\Special3[#Warm]		= SetAlpha(FixColor($7984F5), 255)
		\Special3[#Hot]			= SetAlpha(FixColor($7984F5), 255)
		
		\Highlight				= SetAlpha(FixColor($FFFFFF), 255)
	EndWith
	
	With DarkTheme
		\WindowColor			= SetAlpha(FixColor($36393F), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($36393F), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($44474C), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($54575C), 255)
		
		\FrontColor[#Cold]		= SetAlpha(FixColor($7E8287), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($8F9399), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($8F9399), 255)
		
		\ShaderColor[#Cold]		= SetAlpha(FixColor($44474C), 255)
		\ShaderColor[#Warm]		= SetAlpha(FixColor($4F545C), 255)
		\ShaderColor[#Hot]		= SetAlpha(FixColor($54575C), 255)
		
		\LineColor[#Cold]		= SetAlpha(FixColor($7E8287), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($A2A3A5), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($A2A3A5), 255)
		
		\TextColor[#Cold]	 	= SetAlpha(FixColor($FAFAFB), 255)
		\TextColor[#Warm]		= SetAlpha(FixColor($FFFFFF), 255)
		\TextColor[#Hot]		= SetAlpha(FixColor($FFFFFF), 255)
		
		\Special1[#Cold]		= SetAlpha(FixColor($D83C3E), 255)
		\Special1[#Warm]		= SetAlpha(FixColor($E06365), 255)
		\Special1[#Hot]			= SetAlpha(FixColor($E06365), 255)
		
		\Special2[#Cold]		= SetAlpha(FixColor($3AA55D), 255)
		\Special2[#Warm]		= SetAlpha(FixColor($6BD08B), 255)
		\Special2[#Hot]			= SetAlpha(FixColor($6BD08B), 255)
		
		\Special3[#Cold]		= SetAlpha(FixColor($5865F2), 255)
		\Special3[#Warm]		= SetAlpha(FixColor($7984F5), 255)
		\Special3[#Hot]			= SetAlpha(FixColor($7984F5), 255)
		
		\Highlight				= SetAlpha(FixColor($FFFFFF), 255)
	EndWith
	;}
	;}
	
	
	;General:
	;{ Shared
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
	
	; Misc
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
	
	; Drawing functions
	#TextBlock_ImageMargin = 4
	
	Procedure PrepareVectorTextBlock(*TextData.Text)
		Protected String.s, Word.s, NewList StringList.s(), Loop, Count, Image, ImageWidth, ImageHeight, TextHeight, MaxLine, Width, FinalWidth, TextWidth, LineCount
		
		*TextData\RequieredHeight = 0
		*TextData\RequieredWidth = 0
		*TextData\Text = ""
		
		String = ReplaceString(*TextData\OriginalText, #CRLF$, #CR$)
		String = ReplaceString(String, #LF$, #CR$)
		
		Count = CountString(String, #CR$) + 1
		
		Image = CreateImage(#PB_Any, 10, 19)
		StartVectorDrawing(ImageVectorOutput(Image))
		VectorFont(*TextData\FontID)
		TextHeight = VectorTextHeight("a")
		MaxLine = Floor(*TextData\Height / TextHeight)
		
		*TextData\RequieredHeight = TextHeight * Count
		
		For Loop = 1 To Count
			AddElement(StringList())
			StringList() = Trim(StringField(String, Loop, #CR$))
			TextWidth = VectorTextWidth(StringList())
			If TextWidth > *TextData\RequieredWidth
				*TextData\RequieredWidth = TextWidth
			EndIf
		Next
		
		If *TextData\Image
			ImageWidth = ImageWidth(*TextData\Image) + #TextBlock_ImageMargin
			ImageHeight = ImageHeight(*TextData\Image)
			*TextData\RequieredWidth + ImageWidth
		EndIf
		
		Width = *TextData\Width - ImageWidth
				
		If *TextData\LineLimit > 0
			MaxLine = Min(MaxLine, *TextData\LineLimit)
		EndIf
		
		ForEach StringList()
			String = ""
			Count = CountString(StringList(), " ") + 1
			
			For Loop = 1 To Count
				Word = StringField(StringList(), Loop, " ")
				
				If VectorTextWidth(String + Word) > Width
					String = Trim(String)
					TextWidth = VectorTextWidth(String)
					
					If TextWidth > FinalWidth
						FinalWidth = TextWidth
					EndIf
					
					*TextData\Text + String
					LineCount + 1
					
					; edge case! What if a word is wider than the width of the whole thingy?
					; 1) check if there is still space at the end of the previous string and put it there (at least 3 characters + ...)
					
					
					; 2) If not, create a new line with just the current word (shortened and add ...)
					String = ""
					
					If LineCount >= MaxLine
						Break 2
					EndIf
					*TextData\Text + #CRLF$
				EndIf
				
				String + Word + " "
			Next
			
			String = Trim(String)
			
			If String <> ""
				String = Trim(String)
				TextWidth = VectorTextWidth(String)
				
				If TextWidth > FinalWidth
					FinalWidth = TextWidth
				EndIf
				
				*TextData\Text + String
				LineCount + 1
				If LineCount >= MaxLine
					Break
				EndIf
				
				*TextData\Text + #CRLF$
			EndIf
		Next
		
		If *TextData\VAlign = #VAlignCenter
			*TextData\ImageY = (*TextData\Height - ImageHeight) * 0.5
			*TextData\TextY = (*TextData\Height - LineCount * TextHeight) * 0.5
		ElseIf *TextData\VAlign = #VAlignBottom
			*TextData\TextY = *TextData\Height - LineCount * TextHeight
			*TextData\ImageY = *TextData\Height - ImageHeight
		Else 
			*TextData\TextY = 0
			*TextData\ImageY = 0
		EndIf
		
		If *TextData\HAlign = #HAlignCenter
			*TextData\ImageX = (Width - FinalWidth) * 0.5
			*TextData\TextX = ImageWidth * 0.5
			*TextData\VectorAlign = #PB_VectorParagraph_Center
		ElseIf *TextData\HAlign = #HAlignRight
			*TextData\ImageX = Width + #TextBlock_ImageMargin
			*TextData\TextX = - ImageWidth
			*TextData\VectorAlign =  #PB_VectorParagraph_Right
		Else
			*TextData\ImageX = 0
			*TextData\TextX = ImageWidth
			*TextData\VectorAlign =  #PB_VectorParagraph_Left
		EndIf
		
		StopVectorDrawing()
		FreeImage(Image)
	EndProcedure
	
	Procedure DrawVectorTextBlock(*TextData.Text, X, Y)
		MovePathCursor(X + *TextData\TextX, Y + *TextData\TextY, #PB_Path_Default)
		DrawVectorParagraph(*TextData\Text, *TextData\Width, *TextData\Height, *TextData\VectorAlign)
		
		If *TextData\Image
			MovePathCursor(X + *TextData\ImageX, Y + *TextData\ImageY, #PB_Path_Default)
			DrawVectorImage(ImageID(*TextData\Image))
		EndIf
		
	EndProcedure
	
	Procedure AddPathRoundedBox(x, y, Width, Height, Radius, Flag = #PB_Path_Default)
		MovePathCursor(x, y + Radius, Flag)
		
		AddPathArc(0, Height - radius, Width, Height - radius, Radius, #PB_Path_Relative)
		AddPathArc(Width - Radius, 0, Width - Radius, - Height, Radius, #PB_Path_Relative)
		AddPathArc(0, Radius - Height, -Width, Radius - Height, Radius, #PB_Path_Relative)
		AddPathArc(Radius - Width, 0, Radius - Width, Height, Radius, #PB_Path_Relative)
		ClosePath()
		
		MovePathCursor(-x,-y-Radius, Flag)
	EndProcedure
	
	; Default functions
	
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
		
		ProcedureReturn CallFunctionFast(*this\vt\FreeGadget, *this)
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
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
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
			Case #Color_Text_Cold
				Result = *GadgetData\Theme\TextColor[#Cold]
			Case #Color_Text_Warm
				Result = *GadgetData\Theme\TextColor[#Warm]
			Case #Color_Text_Hot
				Result = *GadgetData\Theme\TextColor[#Hot]
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
		
		PokeW(*Width, *GadgetData\TextBock\RequieredWidth + *GadgetData\HMargin * 2)
		PokeW(*Height, *GadgetData\TextBock\RequieredHeight + *GadgetData\VMargin * 2)
	EndProcedure
	
	Procedure.s Default_GetText(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\TextBock\OriginalText
	EndProcedure
	
	Procedure GetGadgetImage(Gadget)
		
	EndProcedure
	
	; Setters
	Procedure GetAccessibilityMode()
		ProcedureReturn AccessibilityMode
	EndProcedure
	
	Procedure.s GetGadgetColorScheme(Gadget)	
	EndProcedure
	
	Procedure Default_SetFont(*this.PB_Gadget, FontID)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\TextBock\FontID = FontID
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
			Case #Color_Text_Cold
				*GadgetData\Theme\TextColor[#Cold] = Color
			Case #Color_Text_Warm
				*GadgetData\Theme\TextColor[#Warm] = Color
			Case #Color_Text_Hot
				*GadgetData\Theme\TextColor[#Hot] = Color
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
	
	Procedure Default_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\TextBock\OriginalText = Text
		PrepareVectorTextBlock(@*GadgetData\TextBock)
		RedrawObject()
	EndProcedure
	
	Procedure SetGadgetImage(Gadget, Image)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		*GadgetData\TextBock\Image = Image
		
		PrepareVectorTextBlock(@*GadgetData\TextBock)
		RedrawObject()
		
	EndProcedure
	;}
	
	;{ Window
	#WM_SYSMENU = $313
	#SizableBorder = 8
	#WindowButtonWidth = 45
	#WindowBarHeight = 30
	
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
		sizeCursor.l
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
		Protected *WindowData.ThemedWindow = GetProp_(hWnd, "UITK_WindowData"), cursor.POINT, OffsetX, OriginalProc
		
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
				
				If *WindowData\LabelAlign = #HAlignRight
					SetWindowPos_(GadgetID(*WindowData\Label), 0, *WindowData\Width - OffsetX, 0, 0, 0, #SWP_NOSIZE)
				ElseIf *WindowData\LabelAlign = #HAlignCenter
					SetWindowPos_(GadgetID(*WindowData\Label), 0, (*WindowData\Width - *WindowData\LabelWidth) * 0.5, 0, 0, 0, #SWP_NOSIZE)
				EndIf
				
				SetWindowPos_(GadgetID(*WindowData\Container), 0, 0, 0, *WindowData\Width, *WindowData\Height - #WindowBarHeight, #SWP_NOMOVE | #SWP_NOZORDER)
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
				OriginalProc = *WindowData\OriginalProc
				FreeStructure(*WindowData)
				
				ProcedureReturn CallWindowProc_(OriginalProc, hWnd, Msg, wParam, lParam)
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
		Protected *WindowBarData.WindowBar = GetProp_(hWnd, "UITK_WindowBarData"), *WindowData.ThemedWindow, posX, posY
		If msg = #WM_LBUTTONDBLCLK
			If IsZoomed_(*WindowBarData\Parent)
				ShowWindow_(*WindowBarData\Parent, #SW_RESTORE)
			Else
				ShowWindow_(*WindowBarData\Parent, #SW_MAXIMIZE)
			EndIf
		ElseIf msg = #WM_LBUTTONDOWN
			If *WindowBarData\sizeCursor = 0
				SendMessage_(*WindowBarData\Parent, #WM_NCLBUTTONDOWN, #HTCAPTION, 0)
			Else
				SetCursor_(LoadCursor_(0, #IDC_SIZENS))
				SendMessage_(*WindowBarData\Parent, #WM_NCLBUTTONDOWN, *WindowBarData\sizeCursor, 0)
			EndIf
		ElseIf  msg = #WM_MOUSEMOVE
			*WindowData.ThemedWindow = GetProp_(*WindowBarData\Parent, "UITK_WindowData")
			
			posX = lParam & $FFFF
			posY = (lParam >> 16) & $FFFF
			*WindowBarData\sizeCursor = 0
			
			If posY < #SizableBorder
				SetCursor_(LoadCursor_(0, #IDC_SIZENS))
				*WindowBarData\sizeCursor = #HTTOP
			EndIf
			
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
				CopyStructure(@DarkTheme, *WindowData\Theme, Theme)
			Else
				Image = CreateImage(#PB_Any, 8, 8, 32, FixColor($FFFFFF))
				CopyStructure(@DefaultTheme, *WindowData\Theme, Theme)
			EndIf
			
			*WindowData\Brush = CreatePatternBrush_(ImageID(Image))
			*WindowData\Width = WindowWidth(Window)
			*WindowData\Height = WindowHeight(Window)
			
			FreeImage(Image)
			
			SetClassLongPtr_(WindowID, #GCL_HBRBACKGROUND, *WindowData\Brush)
			
			SetProp_(WindowID, "UITK_WindowData", *WindowData)
			
			*WindowData\OriginalProc = SetWindowLongPtr_(WindowID, #GWL_WNDPROC, @Window_Handler())
			
			If Flags & #Window_CloseButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonClose = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "󰖭", Flags & #DarkMode * #DarkMode)
				
				SetGadgetFont(*WindowData\ButtonClose, MaterialFont)
				
				If Flags & #DarkMode
					SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Cold, SetAlpha(FixColor($202225), 255))
				Else
					SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Cold, SetAlpha(FixColor($FFFFFF), 255))
				EndIf
				
				BindGadgetEvent(*WindowData\ButtonClose, @CloseButton_Handler(), #PB_EventType_Change)
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Warm, SetAlpha(FixColor($E81123), 255))
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Hot, SetAlpha(FixColor($F1707A), 255))
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Text_Warm, SetAlpha(FixColor($FFFFFF), 255))
				SetGadgetColor(*WindowData\ButtonClose, #Color_Text_Hot, SetAlpha(FixColor($FFFFFF), 255))
			EndIf
			
			If Flags & #Window_MaximizeButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonMaximize = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "󰖯", Flags & #DarkMode * #DarkMode)
				
				SetGadgetFont(*WindowData\ButtonMaximize, MaterialFont)
				
				If Flags & #DarkMode
					SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, SetAlpha(FixColor($202225), 255))
				Else
					SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, SetAlpha(FixColor($FFFFFF), 255))
				EndIf
			EndIf
			
			If Flags & #Window_MinimizeButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonMinimize = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "󰖰",Flags & #DarkMode * #DarkMode)
				
				SetGadgetFont(*WindowData\ButtonMinimize, MaterialFont)
				
				If Flags & #DarkMode
					SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, SetAlpha(FixColor($202225), 255))
				Else
					SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, SetAlpha(FixColor($FFFFFF), 255))
				EndIf
			EndIf
			
			*WindowData\Label = Label(#PB_Any, #SizableBorder, 0, *WindowData\Width - OffsetX, #WindowBarHeight , Title, (Flags & #DarkMode * #DarkMode) | #HAlignLeft | #VAlignCenter)
			If Flags & #DarkMode
				SetGadgetColor(*WindowData\Label, #Color_Parent, SetAlpha(FixColor($202225), 255))
			Else
				SetGadgetColor(*WindowData\Label, #Color_Parent, SetAlpha(FixColor($FFFFFF), 255))
			EndIf
			*WindowData\LabelWidth = GadgetWidth(*WindowData\Label, #PB_Gadget_RequiredSize)
			ResizeGadget(*WindowData\Label, #PB_Ignore, #PB_Ignore, *WindowData\LabelWidth, #PB_Ignore)
			
			If Flags & #HAlignRight
				*WindowData\LabelAlign = #HAlignRight
			ElseIf Flags & #HAlignCenter
				*WindowData\LabelAlign = #HAlignCenter
			Else
				*WindowData\LabelAlign = #HAlignLeft
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
	
	Procedure SetWindowIcon(Window, Image)
		Protected *WindowData.ThemedWindow
		
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		SetGadgetImage(*WindowData\Label, Image)
		*WindowData\LabelWidth = GadgetWidth(*WindowData\Label, #PB_Gadget_RequiredSize)
		ResizeGadget(*WindowData\Label, #PB_Ignore, #PB_Ignore, *WindowData\LabelWidth, #PB_Ignore)
		
		If *WindowData\LabelAlign = #HAlignRight
			SetWindowPos_(GadgetID(*WindowData\Label), 0, *WindowData\Width - (*WindowData\ButtonClose + *WindowData\ButtonMaximize + *WindowData\ButtonMinimize) * #WindowButtonWidth, 0, 0, 0, #SWP_NOSIZE)
		ElseIf *WindowData\LabelAlign = #HAlignCenter
			SetWindowPos_(GadgetID(*WindowData\Label), 0, (*WindowData\Width - *WindowData\LabelWidth) * 0.5, 0, 0, 0, #SWP_NOSIZE)
		EndIf
	EndProcedure
	
	Procedure GetWindowIcon(Window)
		Protected *WindowData.ThemedWindow
		
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		ProcedureReturn GetGadgetImage(*WindowData\Label)
	EndProcedure
	;}
	
	;{ Menu
	#MenuMinimumWidth = 160
	#MenuSeparatorHeight = 9
	#MenuMargin = 3
	#MenuItemLeftMargin = 20 + #menuMargin
	
	Global MenuWindow
	
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
						DrawText(#MenuItemLeftMargin, Y + VerticalOffset, \Item()\Text, \Theme\TextColor[#Hot])
					Else
						DrawText(#MenuItemLeftMargin, Y + VerticalOffset, \Item()\Text, \Theme\TextColor[#Cold])
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
	
	Procedure FlatMenu(Flags = #Default)
		Protected Result, *MenuData.FlatMenu, GadgetList = UseGadgetList(0)
		
		If Not MenuWindow
			MenuWindow = WindowID(OpenWindow(#PB_Any, 0, 0, 100, 100, "Menu Parent", #PB_Window_Invisible | #PB_Window_SystemMenu))
		EndIf
		
		*MenuData = AllocateStructure(FlatMenu)
		
		With *MenuData
			\Window = OpenWindow(#PB_Any, 0, 0, #MenuMinimumWidth, 0, "", #PB_Window_BorderLess | #PB_Window_Invisible, MenuWindow)
			\Canvas = CanvasGadget(#PB_Any, 0, 0, #MenuMinimumWidth, 0, #PB_Canvas_Keyboard)
			\FontID = DefaultFont
			\Vector = #True
			\Width = #MenuMinimumWidth
			\Height = 2 * #MenuMargin
			\State = -1
			
			If \Vector
				StartVectorDrawing(CanvasVectorOutput(\Canvas))
				VectorFont(\FontID)
				\ItemHeight = Round(VectorTextHeight("A") * 1.4, #PB_Round_Nearest)
				StopVectorDrawing()
			Else
				StartDrawing(CanvasOutput(\Canvas))
				DrawingFont(\FontID)
				\ItemHeight = Round(TextHeight("A") * 1.4, #PB_Round_Nearest)
				StopDrawing()
			EndIf
			
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
	
	
	;Gadgets:
	;{ Button
	#Button_Margin = 3
	Structure ButtonData Extends GadgetData
		Toggle.b
	EndStructure
	
	Procedure Button_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ButtonData = *this\vt
		With *GadgetData
			
			If *GadgetData\Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height -2, 4)
				VectorSourceColor(*GadgetData\Theme\LineColor[*GadgetData\MouseState])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, 4)
			EndIf
			
			VectorSourceColor(\Theme\BackColor[\MouseState])
			FillPath()
			
			VectorSourceColor(\Theme\TextColor[\MouseState])
			VectorFont(\TextBock\FontID)
			
			DrawVectorTextBlock(@\TextBock, \OriginX + \HMargin, \OriginY + \VMargin)
			
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
	
	Procedure Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ButtonData
		
		If AccessibilityMode
			Result = ButtonGadget(Gadget, x, y, Width, Height, Text.s, (Bool(Flags & #HAlignLeft) * #PB_Button_Left) | 
			                                                           (Bool(Flags & #HAlignRight) * #PB_Button_Right) |
			                                                           (Bool(Flags & #Button_Toggle) * #PB_Button_Toggle))
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(Button)
				
				With *GadgetData
					\Toggle = Bool(Flags & #Button_Toggle)
					\TextBock\OriginalText = Text
					
					; Button alignement is different from default alignement.
					If Flags & #VAlignTop
						\TextBock\VAlign = #VAlignTop
					ElseIf Flags & #VAlignBottom
						\TextBock\VAlign = #VAlignBottom
					Else
						\TextBock\VAlign = #VAlignCenter
					EndIf
					
					If Flags & #HAlignLeft
						*GadgetData\TextBock\HAlign = #HAlignLeft
					ElseIf Flags & #HAlignRight
						*GadgetData\TextBock\HAlign = #HAlignRight
					Else
						*GadgetData\TextBock\HAlign = #HAlignCenter
					EndIf
					
					\HMargin = #Button_Margin + \Border
					\VMargin = #Button_Margin
					
					\TextBock\Width = Width - \HMargin * 2
					\TextBock\Height = Height - \VMargin * 2
					
					PrepareVectorTextBlock(@*GadgetData\TextBock)
					
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
	#ToggleSize = 24
	
	Structure ToggleData Extends GadgetData
	EndStructure
	
	Procedure Toggle_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ToggleData = *this\vt, X, Y
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\TextColor[\MouseState])
			
			If \TextBock\HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBock, X + \HMargin * 2, Y)
				X = \OriginX + #ToggleSize * 0.5 + BorderMargin
			Else
				DrawVectorTextBlock(@\TextBock, X, Y)
				X = \OriginX + \Width - #ToggleSize * 1.5 - BorderMargin
			EndIf
			
			Y = \OriginY + Floor((\Height - #ToggleSize) * 0.5 + #ToggleSize * 0.5)
			
			AddPathCircle(X, Y, #ToggleSize * 0.5, 0, 360, #PB_Path_Default)
			AddPathCircle(#ToggleSize * 0.5, 0, #ToggleSize * 0.5, 0, 360, #PB_Path_Relative)
			AddPathBox(-#ToggleSize * 1.5, -#ToggleSize * 0.5, #ToggleSize, #ToggleSize, #PB_Path_Relative)
			
			If \State
				X + #ToggleSize
				VectorSourceColor(\Theme\Special2[\MouseState])
				FillPath(#PB_Path_Winding)
				AddPathCircle(X, Y, #ToggleSize * 0.37)
				VectorSourceColor(\Theme\Highlight)
				FillPath()
				
				VectorSourceColor(\Theme\Special2[\MouseState])
				MovePathCursor(X - #ToggleSize * 0.26, Y, #PB_Path_Default)
				AddPathLine(#ToggleSize * 0.18, #ToggleSize * 0.18, #PB_Path_Relative)
				AddPathLine(#ToggleSize * 0.27, #ToggleSize * -0.37, #PB_Path_Relative)
				
				StrokePath(2)
			Else
				VectorSourceColor(\Theme\FrontColor[\MouseState])
				FillPath(#PB_Path_Winding)
				AddPathCircle(X, Y, #ToggleSize * 0.37)
				VectorSourceColor(\Theme\Highlight)
				FillPath()
				
				VectorSourceColor(\Theme\FrontColor[\MouseState])
				MovePathCursor(X - #ToggleSize * 0.18, Y - #ToggleSize * 0.18, #PB_Path_Default)
				AddPathLine(#ToggleSize * 0.36, #ToggleSize * 0.36, #PB_Path_Relative)
				MovePathCursor(0, #ToggleSize * -0.36, #PB_Path_Relative)
				AddPathLine(#ToggleSize * -0.36, #ToggleSize * 0.36, #PB_Path_Relative)
				StrokePath(2)
			EndIf
			
			
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
	
	Procedure Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ToggleData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
		
		If Result
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			InitializeObject(Toggle)
			
			With *GadgetData
				\TextBock\Width = Width - #ToggleSize * 2 - BorderMargin * 2
				\TextBock\Height = Height - BorderMargin * 2
				\TextBock\OriginalText = Text
				\HMargin = #ToggleSize + BorderMargin
				\VMargin = BorderMargin
				
				If Flags & #HAlignCenter
					\TextBock\HAlign = #HAlignLeft
				EndIf
				
				\TextBock\VAlign = #VAlignCenter
				
				PrepareVectorTextBlock(@*GadgetData\TextBock)
				
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
	EndStructure
	
	Procedure CheckBox_Redraw(*this.PB_Gadget) ; /!\ Going to be a problem in meta gadgets!
		Protected *GadgetData.CheckBoxData = *this\vt, X, Y
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\TextColor[\MouseState])
			
			If \TextBock\HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBock, X + \HMargin * 2, Y)
				X = \OriginX + BorderMargin
			Else
				DrawVectorTextBlock(@\TextBock, X, Y)
				X = \OriginX + \Width - #CheckboxSize - BorderMargin
			EndIf
			
			Y = Floor(\OriginY + (\Height - #CheckboxSize) * 0.5)
			
			VectorSourceColor(\Theme\FrontColor[\MouseState])
			AddPathBox(X, Y, #CheckboxSize, #CheckboxSize)
			AddPathBox(X + #CheckboxSize * 0.1, Y + #CheckboxSize * 0.1, #CheckboxSize * 0.8, #CheckboxSize * 0.8)
			
			If \State = #True
				AddPathBox(X + #CheckboxSize, Y, #CheckboxSize * -0.25, #CheckboxSize * 0.1)
				AddPathBox(X + #CheckboxSize * 0.9, Y + #CheckboxSize * 0.1, #CheckboxSize * 0.1, #CheckboxSize * 0.25)
				FillPath()
				
				VectorSourceColor(\Theme\FrontColor[\MouseState])
				
				MovePathCursor(X + #CheckboxSize * 0.2, Y + #CheckboxSize * 0.4)
				AddPathLine(#CheckboxSize * 0.28, #CheckboxSize * 0.28, #PB_Path_Relative)
				AddPathLine(#CheckboxSize * 0.5, -#CheckboxSize * 0.7, #PB_Path_Relative)
				
				StrokePath(2)
			Else
				FillPath()
				If \State = #PB_Checkbox_Inbetween
					AddPathBox(X + #CheckboxSize * 0.25, Y + #CheckboxSize * 0.25, #CheckboxSize * 0.5, #CheckboxSize * 0.5)
					VectorSourceColor(\Theme\FrontColor[\MouseState])
					FillPath()
				EndIf
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
	
	Procedure CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.CheckBoxData
		
		If AccessibilityMode
			Result = CheckBoxGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #HAlignRight) * #PB_CheckBox_Right) |
			                                                           (Bool(Flags & #HAlignCenter) * #PB_CheckBox_Center) |
			                                                           #PB_CheckBox_ThreeState)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(CheckBox)
				
				With *GadgetData
					\TextBock\Width = Width - #CheckboxSize - BorderMargin * 2
					\TextBock\Height = Height - BorderMargin * 2
					\TextBock\OriginalText = Text
					\HMargin = #CheckboxSize * 0.5 + BorderMargin
					\VMargin = BorderMargin
					
					If Flags & #HAlignCenter
						\TextBock\HAlign = #HAlignLeft
					EndIf
					
					\TextBock\VAlign = #VAlignCenter
					
					PrepareVectorTextBlock(@*GadgetData\TextBock)
					
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
		Protected *GadgetData.ScrollBarData = *this\vt, Radius.f, Point
		
		With *GadgetData
			Radius = \Thickness * 0.5
			AddPathCircle(\OriginX + Radius, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
			VectorSourceColor(\Theme\ShaderColor[#Cold])
			
			If \Vertical
				AddPathBox(- \Thickness, 0, \Width, \Height - \Thickness, #PB_Path_Relative)
				AddPathCircle(\OriginX + Radius, \OriginY + \Height - Radius, Radius, 0, 360, #PB_Path_Default)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\Theme\FrontColor[\MouseState])
				
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
					VectorSourceColor(\Theme\FrontColor[\MouseState])
					
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
	EndStructure
	
	Procedure Label_Redraw(*this.PB_Gadget)
		Protected *GadgetData.LabelData = *this\vt
		
		With *GadgetData
			VectorFont(\FontID)
			VectorSourceColor(\Theme\TextColor[#Cold])
			DrawVectorTextBlock(@\TextBock, \OriginX, \OriginY)
		EndWith
	EndProcedure
	
	Procedure Label_EventHandler(*this.PB_Gadget, *Event.Event)
	EndProcedure
	
	Procedure Label(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.LabelData
		
		If AccessibilityMode
			Result = TextGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #HAlignRight) * #PB_Text_Right) |
			                                                       (Bool(Flags & #HAlignCenter) * #PB_Text_Center) |
			                                                       (Bool(Flags & #Border) * #PB_Text_Border))
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(Label)
				
				With *GadgetData
					\TextBock\Width = Width
					\TextBock\Height = Height
					\TextBock\OriginalText = Text
					
					PrepareVectorTextBlock(@*GadgetData\TextBock)
					
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
				Case #Color_Text_Cold
					*GadgetData\Theme\TextColor[#Cold] = Color
				Case #Color_Text_Warm
					*GadgetData\Theme\TextColor[#Warm] = Color
				Case #Color_Text_Hot
					*GadgetData\Theme\TextColor[#Hot] = Color
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
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *GadgetData\Theme, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *GadgetData\Theme, Theme)
					Else
						CopyStructure(@DefaultTheme, *GadgetData\Theme, Theme)
					EndIf
				EndIf
				
				*GadgetData\ScrollArea = ScrollAreaGadget(#PB_Any, 0, 0, Width - #ScrollArea_Bar_Thickness + ScrollbarThickness, Height - #ScrollArea_Bar_Thickness + ScrollbarThickness, ScrollAreaWidth, ScrollAreaHeight, ScrollStep, #PB_ScrollArea_BorderLess)
				SetProp_(GadgetID(\ScrollArea), "UITK_ScrollAreaData", *GadgetData)
				BindGadgetEvent(\ScrollArea, @ScrollArea_Handler())
				
				SetGadgetColor(\ScrollArea, #PB_Gadget_BackColor, RGB(Red(*GadgetData\Theme\WindowColor), Green(*GadgetData\Theme\WindowColor), Blue(*GadgetData\Theme\WindowColor)))
				SetGadgetColor(\Gadget, #PB_Gadget_BackColor, RGB(Red(*GadgetData\Theme\WindowColor), Green(*GadgetData\Theme\WindowColor), Blue(*GadgetData\Theme\WindowColor)))
				
				CloseGadgetList()
				CloseGadgetList()
				
				\Width = Width
				\Height = Height
				\VerticalScrollbar = ScrollBar(#PB_Any, x + \Width - #ScrollArea_Bar_Thickness, y, #ScrollArea_Bar_Thickness, \Height - #ScrollArea_Bar_Thickness, 0, ScrollAreaHeight + #ScrollArea_Bar_Thickness, \Height, #ScrollBar_Vertical)
				BindGadgetEvent(\VerticalScrollbar, @ScrollArea_ScrollbarHandler(), #PB_EventType_Change)
				SetProp_(GadgetID(\VerticalScrollbar), "UITK_ScrollAreaData", *GadgetData)
				
				\HorizontalScrollbar = ScrollBar(#PB_Any, x, y + \Height - #ScrollArea_Bar_Thickness, \Width - #ScrollArea_Bar_Thickness, #ScrollArea_Bar_Thickness, 0, ScrollAreaWidth + #ScrollArea_Bar_Thickness, \Width)
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
	
	;{ Menu bar
	Structure ScrollMenuBar Extends GadgetData
		
	EndStructure
	
	
	;}
	
	;{ TrackBar
	#Trackbar_Thickness = 7
	#TracKbar_CursorWidth = 10
	#TracKbar_CursorHeight = 24
	#Trackbar_IndentWidth = 20
	#Trackbar_Margin = 3
	
	Structure TrackBarIndent
		Text.s
		Position.l
	EndStructure
	
	Structure TrackBarData Extends GadgetData
		Minimum.i
		Maximum.i
		Vertical.b
		Drag.b
		DragOffset.i
		Hover.b
		List IndentList.TrackBarIndent()
	EndStructure
	
	Procedure TrackBar_Redraw(*this.PB_Gadget)
		Protected *GadgetData.TrackBarData = *this\vt, Progress, X, Y, Ratio.d, TextHeight, Height, Width
		
		With *GadgetData
			VectorFont(\TextBock\FontID)
			VectorSourceColor(\Theme\LineColor[#Cold])
			TextHeight = VectorTextHeight("a")
			
			If \Vertical
				Height = \Height - 2 * #Trackbar_Margin
				Ratio = (Height - #TracKbar_CursorWidth) / (\Maximum - \Minimum)
				Progress = Round((\State - \Minimum) * Ratio, #PB_Round_Nearest)
				
				If \TextBock\HAlign = #HAlignRight
					X = \OriginX + \Width - #TracKbar_CursorHeight - #Trackbar_Margin
					
					ForEach \IndentList()
						Y = Round((\IndentList()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						MovePathCursor(X + 2, Y + 1)
						AddPathLine(#Trackbar_IndentWidth, 0, #PB_Path_Relative)
						MovePathCursor(0, Y - Floor(TextHeight * 0.5 ))
						DrawVectorParagraph(\IndentList()\Text, \Width - X, TextHeight, #PB_VectorParagraph_Right)
					Next
					
					X + #TracKbar_CursorHeight * 0.5
				Else
					X = \OriginX + #Trackbar_Margin
					
					ForEach \IndentList()
						Y = Round((\IndentList()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						MovePathCursor(X + 2, Y + 1)
						AddPathLine(#Trackbar_IndentWidth, 0, #PB_Path_Relative)
						MovePathCursor(X + #TracKbar_CursorHeight + #Trackbar_Margin, Y - Floor(TextHeight * 0.5 ))
						DrawVectorParagraph(\IndentList()\Text, \Width, TextHeight, #PB_VectorParagraph_Left)
					Next
					
					X + #TracKbar_CursorHeight * 0.5
				EndIf
				
				Y = \OriginY + #Trackbar_Margin
				
				VectorSourceColor(\Theme\ShaderColor[#Warm])
				StrokePath(2)
				AddPathBox(X - #Trackbar_Thickness * 0.5, Y + #Trackbar_Thickness * 0.5 + Progress, #Trackbar_Thickness, Height - #Trackbar_Thickness - Progress)
				AddPathCircle(X, Y + Height - #Trackbar_Thickness * 0.5, #Trackbar_Thickness * 0.5)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\Theme\Special3[#Cold])
				AddPathCircle(X, Y + #Trackbar_Thickness * 0.5, #Trackbar_Thickness * 0.5)
				AddPathBox(X - #Trackbar_Thickness * 0.5, Y + #Trackbar_Thickness * 0.5, #Trackbar_Thickness, Progress)
				FillPath(#PB_Path_Winding)
				
				AddPathRoundedBox(X - #TracKbar_CursorHeight * 0.5, Y + Progress, #TracKbar_CursorHeight, #TracKbar_CursorWidth, 3)
			Else
				Width = \Width - 2 * #Trackbar_Margin
				Ratio = (Width - #TracKbar_CursorWidth) / (\Maximum - \Minimum)
				Progress = Round((\State - \Minimum) * Ratio, #PB_Round_Nearest)
				
				If \TextBock\VAlign = #VAlignTop
					Y = \OriginY + #Trackbar_Margin
					
					ForEach \IndentList()
						X = Round((\IndentList()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						
						MovePathCursor(X + 1, Y + 2)
						AddPathLine(0, #Trackbar_IndentWidth, #PB_Path_Relative)
						MovePathCursor(X - 24, Y + #Trackbar_Margin + #TracKbar_CursorHeight)
						DrawVectorParagraph(\IndentList()\Text, 50, TextHeight, #PB_VectorParagraph_Center)
					Next
					
					Y + #TracKbar_CursorHeight * 0.5
				Else
					Y = \OriginY + \Height - #TracKbar_CursorHeight - #Trackbar_Margin
					
					ForEach \IndentList()
						X = Round((\IndentList()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						
						MovePathCursor(X + 1, Y + 2)
						AddPathLine(0, #Trackbar_IndentWidth, #PB_Path_Relative)
						MovePathCursor(X - 24, Y - TextHeight - #Trackbar_Margin)
						DrawVectorParagraph(\IndentList()\Text, 50, TextHeight, #PB_VectorParagraph_Center)
					Next
					
					Y + #TracKbar_CursorHeight * 0.5
				EndIf
				
				X = \OriginX + #Trackbar_Margin
				
				VectorSourceColor(\Theme\ShaderColor[#Warm])
				StrokePath(2)
				AddPathBox(X + #Trackbar_Thickness * 0.5 + Progress, Y - #Trackbar_Thickness * 0.5, Width - #Trackbar_Thickness - Progress, #Trackbar_Thickness)
				AddPathCircle(X + Width - #Trackbar_Thickness * 0.5, Y, #Trackbar_Thickness * 0.5)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\Theme\Special3[#Cold])
				AddPathCircle(X + #Trackbar_Thickness * 0.5, Y, #Trackbar_Thickness * 0.5)
				AddPathBox(X + #Trackbar_Thickness * 0.5, Y - #Trackbar_Thickness * 0.5, Progress, #Trackbar_Thickness)
				FillPath(#PB_Path_Winding)
				
				AddPathRoundedBox(X + Progress, Y - #TracKbar_CursorHeight * 0.5, #TracKbar_CursorWidth, #TracKbar_CursorHeight, 3)
			EndIf
			
			VectorSourceColor(\Theme\TextColor[#Cold])
			StrokePath(1, #PB_Path_Preserve)
			VectorSourceColor(\Theme\Highlight)
			FillPath(#PB_Path_Winding)
		EndWith
		
	EndProcedure
		
	Procedure TrackBar_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.TrackBarData = *this\vt, Redraw, CursorX, CursorY, NewState
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \Drag
						If \Vertical
							NewState = Clamp(\Minimum + Round((*Event\MouseY - \DragOffset) / (\Height - #TracKbar_CursorWidth - #Trackbar_Margin * 2) * (\Maximum - \Minimum), #PB_Round_Nearest), \Minimum, \Maximum)
							If \State <> NewState
								\State = NewState
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
						Else
							NewState = Clamp(\Minimum + Round((*Event\MouseX - \DragOffset) / (\Width - #TracKbar_CursorWidth - #Trackbar_Margin * 2) * (\Maximum - \Minimum), #PB_Round_Nearest), \Minimum, \Maximum)
							If \State <> NewState
								\State = NewState
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
						EndIf
					Else
						If \Vertical
							CursorY = \OriginY + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Height - #TracKbar_CursorWidth - #Trackbar_Margin * 2), #PB_Round_Nearest) + #Trackbar_Margin
							
							If \TextBock\HAlign = #HAlignRight
								CursorX = \OriginX + \Width - #TracKbar_CursorHeight - #Trackbar_Margin
							Else
								CursorX = \OriginX + #Trackbar_Margin
							EndIf
							
							If (*Event\MouseX >= CursorX) And (*Event\MouseY >= CursorY) And (*Event\MouseX <= CursorX + #TracKbar_CursorHeight) And (*Event\MouseY <= CursorY + #TracKbar_CursorWidth)
								SetGadgetAttribute(\Gadget, #PB_Canvas_Cursor, #PB_Cursor_UpDown)
								\Hover = #True
							Else
								SetGadgetAttribute(\Gadget, #PB_Canvas_Cursor, #PB_Cursor_Default)
								\Hover = #False
							EndIf
						Else
							CursorX = \OriginX + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Width - #TracKbar_CursorWidth - #Trackbar_Margin * 2), #PB_Round_Nearest) + #Trackbar_Margin
							
							If \TextBock\VAlign = #VAlignBottom
								CursorY = \OriginY + \Height - #TracKbar_CursorHeight - #Trackbar_Margin
							Else
								CursorY = \OriginY + #Trackbar_Margin
							EndIf
							
							If (*Event\MouseX >= CursorX) And (*Event\MouseY >= CursorY) And (*Event\MouseX <= CursorX + #TracKbar_CursorWidth) And (*Event\MouseY <= CursorY + #TracKbar_CursorHeight)
								SetGadgetAttribute(\Gadget, #PB_Canvas_Cursor, #PB_Cursor_LeftRight)
								\Hover = #True
							Else
								SetGadgetAttribute(\Gadget, #PB_Canvas_Cursor, #PB_Cursor_Default)
								\Hover = #False
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \Hover
						\Drag = #True
						If \Vertical
							\DragOffset = *Event\MouseY - Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Height - #TracKbar_CursorWidth - #Trackbar_Margin * 2), #PB_Round_Nearest)
						Else
							\DragOffset = *Event\MouseX - Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Width - #TracKbar_CursorWidth - #Trackbar_Margin * 2), #PB_Round_Nearest)
						EndIf
					Else
						If \Vertical
							CursorY = \OriginY + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Height - #TracKbar_CursorWidth), #PB_Round_Nearest)
							
							If *Event\MouseY < CursorY
								NewState = Clamp(\State - Max(Round((\Maximum - \Minimum) * 0.1, #PB_Round_Nearest), 1), \Minimum, \Maximum)
							Else
								NewState = Clamp(\State + Max(Round((\Maximum - \Minimum) * 0.1, #PB_Round_Nearest), 1), \Minimum, \Maximum)
							EndIf
							
						Else
							CursorX = \OriginX + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Width - #TracKbar_CursorWidth), #PB_Round_Nearest)
							
							If *Event\MouseX < CursorX
								NewState = Clamp(\State - Max(Round((\Maximum - \Minimum) * 0.1, #PB_Round_Nearest), 1), \Minimum, \Maximum)
							Else
								NewState = Clamp(\State + Max(Round((\Maximum - \Minimum) * 0.1, #PB_Round_Nearest), 1), \Minimum, \Maximum)
							EndIf
							
						EndIf
						
						If \State <> NewState
							\State = NewState
							Redraw = #True
							PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						EndIf
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
	
	Procedure Trackbar_AddGadgetItem(*this.PB_Gadget, Position, *Text, ImageID, Flag)
		Protected *GadgetData.TrackBarData = *this\vt, ListSize
		
		With *GadgetData
			ListSize = ListSize(\IndentList())
			
			If ListSize
				ListSize - 1
				ForEach \IndentList()
					If \IndentList()\Position = Position
						Break
					ElseIf \IndentList()\Position > Position
						InsertElement(\IndentList())
						Break
					ElseIf ListIndex(\IndentList()) = ListSize
						AddElement(\IndentList())
					EndIf
				Next
			Else
				AddElement(\IndentList())
			EndIf
			
			\IndentList()\Text = PeekS(*Text)
			\IndentList()\Position = Position
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure TrackBar(Gadget, x, y, Width, Height, Minimum, Maximum, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.TrackBarData
		
		If AccessibilityMode
			Result = TrackBarGadget(Gadget, x, y, Width, Height, Minimum, Maximum, Bool(Flags & #Trackbar_Vertical) * #PB_TrackBar_Vertical)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(TrackBar)
				
				With *GadgetData
					
					\Vertical = Bool(Flags & #Trackbar_Vertical)
					\Maximum = Maximum
					\Minimum = Minimum
					
					If \Vertical
						\HMargin = 30
						\VMargin = 50
					Else
						\HMargin = 50
						\VMargin = 20
					EndIf
					
					\TextBock\RequieredHeight = \VMargin * 2
					\TextBock\RequieredWidth = \HMargin * 2
					\TextBock\FontID = BoldFont
					
					\VT\AddGadgetItem2 = @Trackbar_AddGadgetItem()
					
					\SupportedEvent[#LeftClick] = #True
					\SupportedEvent[#LeftButtonDown] = #True
					\SupportedEvent[#LeftButtonUp] = #True
					\SupportedEvent[#MouseLeave] = #True
					\SupportedEvent[#MouseMove] = #True
					\SupportedEvent[#KeyDown] = #True
					\SupportedEvent[#KeyUp] = #True
				EndWith
				
				RedrawObject()
				
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Combo
	#Combo_Margin = 3
	#Combo_IconMargin = 34
	#Combo_IconWidth = 28
	#Combo_IconHeight = 17
	#Combo_Icon = 8
	#Combo_ItemHeight = 40
	#Combo_ItemMargin = 8
	#Combo_Corner = 4
	
	Structure ComboData Extends GadgetData
		Unfolded.b
		MenuWindow.i
		MenuCanvas.i
		MenuState.i
		List Items.Text()
	EndStructure
	
	Procedure Combo_Redraw(*this.PB_Gadget)
		Protected *GadgetData.ComboData = *this\vt
		With *GadgetData
			
			If *GadgetData\Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height -2, 4)
				VectorSourceColor(\Theme\LineColor[Bool(\MouseState Or \Unfolded)])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, 4)
			EndIf
			
			VectorSourceColor(\Theme\BackColor[Bool(\MouseState Or \Unfolded)])
			FillPath()
			
			VectorSourceColor(\Theme\TextColor[\MouseState])
			VectorFont(\TextBock\FontID)
			
			DrawVectorTextBlock(@\TextBock, \OriginX + #Combo_ItemMargin, \OriginY + \VMargin)
			VectorFont(MaterialFont, 20)
			VectorSourceColor(\Theme\TextColor[#Cold])
			MovePathCursor(\Width - #Combo_IconWidth, (\Height - #Combo_IconHeight) * 0.5)
			
			If \Unfolded
				DrawVectorText("󰅃")
			Else
				DrawVectorText("󰅀")
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Combo_MenuRedraw(*GadgetData.ComboData)
		Protected Y, Index
		
		With *GadgetData
			
			StartVectorDrawing(CanvasVectorOutput(\MenuCanvas))
			If *GadgetData\Border
				AddPathBox(1, 0, \Width - 2, VectorOutputHeight() -1)
				VectorSourceColor(\Theme\LineColor[#Warm])
				StrokePath(1, #PB_Path_Preserve)
			Else
				AddPathBox(\OriginX, \OriginY, \Width, VectorOutputHeight())
			EndIf
			
			VectorSourceColor(\Theme\BackColor[#True])
			FillPath()
			
			VectorSourceColor(\Theme\TextColor[#Cold])
			VectorFont(\TextBock\FontID)
			
			ForEach \Items()
				If Index = \MenuState
					AddPathBox(\Border, Y, \Width - \Border * 2, #Combo_ItemHeight)
					VectorSourceColor(\Theme\BackColor[#Hot])
					FillPath()
					VectorSourceColor(\Theme\TextColor[#Cold])
				EndIf
				
				DrawVectorTextBlock(@\Items(), #Combo_ItemMargin, Y)
				
				If Index = \State
					MovePathCursor(\Width - #Combo_IconWidth, Y + (#Combo_ItemHeight - 14) * 0.5)
					VectorFont(MaterialFont, 16)
					DrawVectorText("󰗠")
					VectorFont(\TextBock\FontID)
				EndIf
				
				Index + 1
				Y + #Combo_ItemHeight
			Next
			
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure Combo_EventHandler(*this.PB_Gadget, *Event.Event)
		Protected *GadgetData.ComboData = *this\vt, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseEnter
					\MouseState = #True
					Redraw = #True
					
				Case #MouseLeave
					\MouseState = #Cold
					Redraw = #True
					
				Case #LeftButtonDown
					If \Unfolded
						\Unfolded = #False
						Redraw = #True
					Else
						SetWindowPos_(WindowID(\MenuWindow), 0, GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate), GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) + \Height - #Combo_Corner, 0, 0, #SWP_NOZORDER | #SWP_NOREDRAW | #SWP_NOSIZE)
						HideWindow(\MenuWindow, #False)
						SetActiveGadget(\MenuCanvas)
						\Unfolded = #True
						Redraw = #True
					EndIf
				Case #KeyUp
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Combo_MenuHandler()
		Protected *this.PB_Gadget = GetProp_(GadgetID(EventGadget()), "UITK_ComboData"), *GadgetData.ComboData = *this\vt, Item
		
		With *GadgetData
			Select EventType()
				Case #PB_EventType_LostFocus
					\Unfolded = #False
					RedrawObject()
					HideWindow(\MenuWindow , #True)
					Combo_MenuRedraw(*GadgetData)
					
				Case #PB_EventType_MouseMove
					Item = Floor(GetGadgetAttribute(\MenuCanvas, #PB_Canvas_MouseY) / #Combo_ItemHeight)
					If Item <> \MenuState
						\MenuState = Item
						Combo_MenuRedraw(*GadgetData)
					EndIf
					
				Case #PB_EventType_LeftButtonDown
					If \MenuState < ListSize(\Items())
						\State = \MenuState
						SelectElement(\Items(), \State)
						\TextBock\OriginalText = \Items()\OriginalText
						PrepareVectorTextBlock(@\TextBock)
						\Unfolded = #False
						RedrawObject()
					EndIf
					HideWindow(\MenuWindow, #True)
				Case #PB_EventType_MouseLeave
					If \MenuState > -1
						\MenuState = -1
						Combo_MenuRedraw(*GadgetData)
					EndIf
			EndSelect
		EndWith
	EndProcedure
	
	Procedure Combo_Free(*this.PB_Gadget)
		Protected *GadgetData.ComboData = *this\vt
		
		If *GadgetData\DefaultEventHandler
			UnbindGadgetEvent(*GadgetData\Gadget, *GadgetData\DefaultEventHandler)
		EndIf
		
		*this\vt = *GadgetData\OriginalVT
		FreeStructure(*GadgetData)
		
		ProcedureReturn CallFunctionFast(*this\vt\FreeGadget, *this)
	EndProcedure
	
	Procedure Combo_AddItem(*this.PB_Gadget, Position, *Text, ImageID, Flag)
		Protected *GadgetData.ComboData = *this\vt
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				InsertElement(\Items())
			Else
				LastElement(\Items())
				AddElement(\Items())
			EndIf
			
			\Items()\OriginalText = PeekS(*Text)
			\Items()\LineLimit = -1
			\Items()\FontID = \TextBock\FontID
			
			\Items()\Width = \TextBock\Width - #Combo_Margin
			\Items()\Height = #Combo_ItemHeight
			\Items()\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@\Items())
			
			ResizeGadget(\MenuCanvas, #PB_Ignore, #PB_Ignore, #PB_Ignore, ListSize(\Items()) * #Combo_ItemHeight + \Border)
			Combo_MenuRedraw(*GadgetData)
			ResizeWindow(\MenuWindow, #PB_Ignore, #PB_Ignore, #PB_Ignore, ListSize(\Items()) * #Combo_ItemHeight + \Border)
			
		EndWith
	EndProcedure
	
	Procedure Combo(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ComboData, GadgetList = UseGadgetList(0)
		
		If AccessibilityMode
			Result = ComboBoxGadget(Gadget, x, y, Width, Height)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				InitializeObject(Combo)
				
				With *GadgetData
					*GadgetData\TextBock\VAlign = #VAlignCenter
					
					\HMargin = #Combo_Margin + \Border
					\VMargin = #Combo_Margin
					
					\TextBock\Width = Width - \HMargin * 2
					\TextBock\Height = Height - \VMargin * 2
					
					\MenuState = -1
					\State = -1
					
					\MenuWindow = OpenWindow(#PB_Any, 0, 0, \Width, 0, "", #PB_Window_BorderLess | #PB_Window_Invisible, WindowID(CurrentWindow()))
					SetWindowColor(\MenuWindow, RGB(Red(\Theme\LineColor[#Warm]), Green(\Theme\LineColor[#Warm]), Blue(\Theme\LineColor[#Warm])))
					\MenuCanvas = CanvasGadget(#PB_Any, 0, 0, \Width, 0, #PB_Canvas_Keyboard)
					SetProp_(GadgetID(\MenuCanvas), "UITK_ComboData", *this.PB_Gadget)
					
					BindGadgetEvent(\MenuCanvas, @Combo_MenuHandler())
					
					\VT\AddGadgetItem2 = @Combo_AddItem()
					
					; Enable only the needed events
					\SupportedEvent[#LeftButtonDown] = #True
					\SupportedEvent[#MouseEnter] = #True
					\SupportedEvent[#MouseLeave] = #True
					\SupportedEvent[#KeyDown] = #True
					\SupportedEvent[#KeyUp] = #True
				EndWith
				
				RedrawObject()
				
			EndIf
			
			UseGadgetList(GadgetList)
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
EndModule
































; IDE Options = PureBasic 6.00 Beta 6 (Windows - x64)
; CursorPosition = 3335
; FirstLine = 134
; Folding = NAAAAAAAAAAAAAgBABAABAAgr-
; EnableXP