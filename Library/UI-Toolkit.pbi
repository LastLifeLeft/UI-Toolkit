DeclareModule UITK
	;{ Public variables, structures and constants
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
		#ReOrder										; Allow user to reorder items by draging them arround the gadget. Mutually exclusive with #Drag.
		#Drag											; Enable drag from this gadget. Mutually exclusive with #Reorder.
		
		; Special
		#Button_Toggle									; Creates a toggle button: one click pushes it, another will release it.
		#Gadget_Vertical								; scrollbar/trackbar/... is vertical (instead of horizontal, which is the default).
		#Trackbar_ShowState								; Display the numerical state on the trackbar
		#Tree_NoLine
		#Tree_StraightLine
		
		; Window
		#Window_CloseButton
		#Window_MaximizeButton
		#Window_MinimizeButton
	EndEnumeration
	
	#Tree_DotLine = 0
	
	Enumeration 5000 ; Gadget attribues
		#ScrollBar_Minimum	
		#ScrollBar_Maximum	
		#ScrollBar_PageLength
		
		#ScrollArea_InnerWidth
		#ScrollArea_InnerHeight
		#ScrollArea_X		
		#ScrollArea_Y		
		#ScrollArea_ScrollStep
		
		#PropertyBox_Title
		#PropertyBox_Text
		#PropertyBox_TextNumerical
		#PropertyBox_Combo
		#PropertyBox_Color
		#PropertyBox_Checkbox
		
		#Attribute_ItemHeight
		#Attribute_ItemWidth
		#Attribute_CornerRadius
		#Attribute_Border
		#Attribute_TextScale
		#Attribute_SortItems
		#Attribute_CornerType
		
		#Tab_Color
		
		#Trackbar_Scale
		
		#Attribute_Library_SectionHeight
		
	EndEnumeration
	
	Enumeration ; Corners
		#Corner_All
		#Corner_Top
		#Corner_Bottom
		#Corner_Left
		#Corner_Right
		#Corner_TopLeft
		#Corner_TopRight
		#Corner_BottomLeft
		#Corner_BottomRight
	EndEnumeration
	
	Enumeration; Colors
		#Color_Text_Cold	= #PB_Gadget_FrontColor
		#Color_Back_Cold	= #PB_Gadget_BackColor 
		#Color_Line_Cold	= #PB_Gadget_LineColor 
		
		#Color_Back_Warm
		#Color_Back_Hot
		#Color_Back_Disabled
		
		#Color_Text_Warm
		#Color_Text_Hot
		#Color_Text_Disabled
		
		#Color_Parent										; The parent (window or container) color, used for rounded corners and stuff like that
		
		#Color_Shade_Cold
		#Color_Shade_Warm
		#Color_Shade_Hot
		#Color_Shade_Disabled
		
		#Color_Line_Warm
		#Color_Line_Hot
		#Color_Line_Disabled
		
		#Color_Special1_Cold
		#Color_Special1_Warm
		#Color_Special1_Hot
		#Color_Special1_Disabled
		
		#Color_Special2_Cold
		#Color_Special2_Warm
		#Color_Special2_Hot
		#Color_Special2_Disabled
		
		#Color_Special3_Cold
		#Color_Special3_Warm
		#Color_Special3_Hot
		#Color_Special3_Disabled
		
		#Color_WindowBorder
	EndEnumeration
	
	Enumeration; Subclass
		#SubClass_EventHandler
		#SubClass_GadgetCallback
		#SubClass_FreeGadget
		#SubClass_GetGadgetState
		#SubClass_SetGadgetState
		#SubClass_GetGadgetText
		#SubClass_SetGadgetText
		#SubClass_AddGadgetItem2
		#SubClass_AddGadgetItem3
		#SubClass_RemoveGadgetItem
		#SubClass_ClearGadgetItemList
		#SubClass_ResizeGadget
		#SubClass_CountGadgetItems
		#SubClass_GetGadgetItemState
		#SubClass_SetGadgetItemState
		#SubClass_GetGadgetItemText
		#SubClass_SetGadgetItemText
		#SubClass_OpenGadgetList2
		#SubClass_GadgetX
		#SubClass_GadgetY
		#SubClass_GadgetWidth
		#SubClass_GadgetHeight
		#SubClass_HideGadget
		#SubClass_AddGadgetColumn
		#SubClass_RemoveGadgetColumn
		#SubClass_GetGadgetAttribute
		#SubClass_SetGadgetAttribute
		#SubClass_GetGadgetItemAttribute2
		#SubClass_SetGadgetItemAttribute2
		#SubClass_SetGadgetColor
		#SubClass_GetGadgetColor
		#SubClass_SetGadgetItemColor2
		#SubClass_GetGadgetItemColor2
		#SubClass_SetGadgetItemData
		#SubClass_GetGadgetItemData
		#SubClass_GetRequiredSize
		#SubClass_SetActiveGadget
		#SubClass_GetGadgetFont
		#SubClass_SetGadgetFont
		#SubClass_SetGadgetItemImage
	EndEnumeration
	
	Enumeration ;State
		#Cold
		#Warm
		#Hot
		#Disabled
	EndEnumeration
	
	Enumeration 1 ;Drag private
		#Drag_HListItem
		#Drag_VListItem
		#Drag_LibraryItem
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
	
	Enumeration #PB_EventType_FirstCustomValue; EventType
		#EventType_ForcefulChange
		#EventType_ItemRightClick
		
		#EventType_FirstAvailableCustomValue
	EndEnumeration	
	
	Enumeration #PB_Event_FirstCustomValue
		#Event_CloseMenu
		
		#Event_FirstAvailableCustomValue
	EndEnumeration
	
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
		FontScale.i
		HAlign.b
		VAlign.b
		Width.l
		Height.l
		RequieredWidth.w
		RequieredHeight.w
	EndStructure
	
	Structure VerticalListItem
		Text.Text
		*Data
	EndStructure
	
	Structure Library_Item
		ImageID.i
		ImageX.i
		ImageY.i
		ImageWidth.i
		ImageHeight.i
		HoverState.b
		Selected.b
		*Section.Library_Section
		*Data
		Text.Text
	EndStructure
	
	Structure Library_Section
		Height.l
		Text.Text
		*Data
		List *Items.Library_Item()
	EndStructure
	
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
	;}
	
	;{ Public procedures declaration
	; Setters
	Declare SetAccessibilityMode(State) 					; Enable or disable accessibility mode. If enabled, gadget falls back on to their default PB version, making them compatible with important features like screen readers or RTL languages.
	Declare SetGadgetColorScheme(Gadget, ThemeJson.s)		; Apply a complete color scheme at once
	Declare SubClassFunction(Gadget, Function, *Adress)		; Subclass any gadget function (Works with native pb gadgets too)
	
	; Getters
	Declare GetAccessibilityMode()							; Returns the current accessibility state.
	Declare.s GetGadgetColorScheme(Gadget)					; Apply a complete color scheme at once
	
	; Window
	Declare Window(Window, X, Y, InnerWidth, InnerHeight, Title.s, Flags = #Default, Parent = #Null)
	Declare OpenWindowGadgetList(Window)
	Declare AddWindowMenu(Window, Menu, Title.s)
	Declare SetWindowBounds(Window, MinWidth, MinHeight, MaxWidth, MaxHeight)
	Declare SetWindowIcon(Window, Image)
	Declare WindowSetColor(Window, ColorType, Color)
	Declare GetWindowIcon(Window)
	Declare WindowGetColor(Window, ColorType)
	
	; Menu
	Declare FlatMenu(Flags = #Default)
	Declare AddFlatMenuItem(Menu, MenuItem, Position, Text.s, ImageID = 0, SubMenu = 0, Flag = 0)
	Declare RemoveFlatMenuItem(Menu, Position)
	Declare AddFlatMenuSeparator(Menu, Position)
	Declare ShowFlatMenu(FlatMenu, X = -1, Y = -1)
	Declare SetFlatMenuColor(Menu, ColorType, Color)
	
	; Gadgets
	Declare GetGadgetImage(Gadget)
	Declare SetGadgetImage(Gadget, Image)
	Declare GetGadgetItemImage(Gadget, Position)
	
	Declare Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags = #Default)
	Declare Label(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollArea(Gadget, x, y, Width, Height, ScrollAreaWidth, ScrollAreaHeight, ScrollStep = #Default, Flags = #Default)
	Declare TrackBar(Gadget, x, y, Width, Height, Minimum, Maximum, Flags = #Default)
	Declare Combo(Gadget, x, y, Width, Height, Flags = #Default)
	Declare VerticalList(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
	Declare Container(Gadget, x, y, Width, Height, Flags = #Default)
	Declare Radio(Gadget, x, y, Width, Height, Text.s, RadioGroup.s = "", Flags = #Default)
	Declare Library(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
	Declare PropertyBox(Gadget, x, y, Width, Height, Flags = #Default)
	Declare Tree(Gadget, x, y, Width, Height, Flags = #Default)
	Declare HorizontalList(Gadget, x, y, Width, Height, Flags = #Default)
	Declare Tab(Gadget, x, y, Width, Height, Flags = #Default)
	
	; Misc
	Declare PrepareVectorTextBlock(*TextData.Text)
	Declare DrawVectorTextBlock(*TextData.Text, X, Y, Alpha = 255)
	Declare Disable(Gadget, State)
	Declare Freeze(Gadget, State)
	Declare AddPathRoundedBox(X, Y, Width, Height, Radius, Type = #Corner_All)
	
	; Drag & drop
	Declare AdvancedDragPrivate(Type, ImageID, Action = #PB_Drag_Copy)
	Declare AdvancedDragFiles(File.s, ImageID, Action = #PB_Drag_Copy)
	Declare AdvancedDragText(Text.s, ImageID, Action = #PB_Drag_Copy)
	Declare AdvancedDragImage(ImageID, Action = #PB_Drag_Copy)
	;}
EndDeclareModule

Module UITK
	EnableExplicit
	
	;{ Macro
	Macro InitializeObject(GadgetType)
		*GadgetData\Gadget = Gadget
		*GadgetData\ParentWindow = CurrentWindow()
		
		*GadgetData\Width = Width
		*GadgetData\Height = Height
		
		*GadgetData\Border = Bool(Flags & #Border)
		
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
		*GadgetData\VT\SetGadgetAttribute = @Default_SetAttribute()
		
		*GadgetData\DefaultEventHandler = @Default_EventHandle()
		
		*GadgetData\TextBock\LineLimit = -1
		*GadgetData\TextBock\FontID = DefaultFont
		
		*GadgetData\Enabled = #True
		
		If Gadget > -1
			BindGadgetEvent(Gadget, *GadgetData\DefaultEventHandler)
		Else
			*GadgetData\MetaGadget = #True
			*GadgetData\OriginX = X
			*GadgetData\OriginY = Y
		EndIf
	EndMacro
	
	Macro RedrawObject()
		If Not *GadgetData\Freeze
			If *GadgetData\MetaGadget
				
			Else
				StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
				AddPathBox(*GadgetData\OriginX, *GadgetData\OriginY, *GadgetData\Width, *GadgetData\Height, #PB_Path_Default)
				ClipPath(#PB_Path_Preserve)
				VectorSourceColor(*GadgetData\ThemeData\WindowColor)
				FillPath()
				*GadgetData\Redraw(*GadgetData)
				StopVectorDrawing()
			EndIf
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
	
	CompilerIf #PB_Compiler_Debugger
		
		Structure SAllocation
			Size.i
			File.s
			Line.i
			Pointer.i
		EndStructure
		
		Global NewList Memories.SAllocation()
		
		Macro AllocateStructureX(Variable, StructureName)
			AddElement(Memories())
			Memories()\Size = SizeOf(StructureName)
			Memories()\File = #PB_Compiler_File
			Memories()\Line = #PB_Compiler_Line
			Memories()\Pointer = AllocateStructure(StructureName)
			Variable = Memories()\Pointer
		EndMacro
		
		Macro FreeStructureX(Memory)
			ForEach Memories()
				If Memories()\Pointer = Memory
					DeleteElement(Memories())
					Break
				EndIf
			Next
			FreeStructure(Memory)
		EndMacro
	CompilerElse
		Macro AllocateStructureX(Variable, StructureName)
			Variable = AllocateStructure(StructureName)
		EndMacro
		
		Macro FreeStructureX(Memory)
			FreeStructure(Memory)
		EndMacro
	CompilerEndIf
	
	;}
	
	;{ Private variables, structures and constants
	CompilerSelect #PB_Compiler_OS
		CompilerCase #PB_OS_Windows ;{
			Prototype GetAttribute(*This, Attribute)
			Prototype SetAttribute(*This, Attribute, Value)
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
				*SetGadgetAttribute.SetAttribute
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
				
				; From here on, custom procedures
				*GetGadgetItemImage
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
				
			EndStructure
			CompilerError "PLEASE SEND HELP ! AU SECOUR! TASEKETE KUDASAI!"
			;}
	CompilerEndSelect
		
	Enumeration ;DragState
		#Drag_None
		#Drag_Init
		#Drag_Active
	EndEnumeration
	
	Structure Event
		EventType.l
		MouseX.l
		MouseY.l
		Param.l
	EndStructure
	
	Prototype Redraw(*GadgetData)
	Prototype EventHandler(*this.PB_Gadget, *Event.Event)
	
	Structure GadgetData
		VT.GadgetVT ;Must be the first element of this structure!
		*OriginalVT.GadgetVT
		Gadget.i
		*MetaGadget
		Border.b
		
		OriginX.i
		OriginY.i
		Width.i
		Height.i
		
		State.i
		
		MouseState.b
		
		SupportedEvent.b[#__EVENTSIZE]
		
		HMargin.w
		VMargin.w
		
		CornerType.a
		
		*ThemeData.THeme
		
		Redraw.Redraw
		EventHandler.EventHandler
		TextBock.Text
		ParentWindow.i
		
		Freeze.b
		Enabled.b
		
		*DefaultEventHandler
	EndStructure
	
	Enumeration ;Menu types
		#Item
		#Separator
	EndEnumeration
	
	Structure MenuItem
		Type.b
		Text.Text
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
		FontID.i
		Border.i
		Theme.Theme
		*HotItem
		List Item.MenuItem()
	EndStructure
	
	Global MenuWindow
	Global AccessibilityMode = #False
	Global DefaultTheme.Theme, DarkTheme.Theme
	Global DefaultFont = FontID(LoadFont(#PB_Any, "Segoe UI", 9, #PB_Font_HighQuality))
	Global BoldFont = FontID(LoadFont(#PB_Any, "Segoe UI Black", 7, #PB_Font_HighQuality))
	Global IconFont = FontID(LoadFont(#PB_Any, "Segoe MDL2 Assets", 10, #PB_Font_HighQuality))
	
	Prototype ItemRedraw(*Item, X, Y, Width, Height, State, *Theme.Theme)
	
	;{ Set default themes
	With DefaultTheme 
		\WindowColor = SetAlpha(FixColor($F0F0F0), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($F0F0F0), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($D8E6F2), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($C0DCF3), 255)
		\BackColor[#Disabled]	= SetAlpha(FixColor($F0F0F0), 255)
		
		\FrontColor[#Cold]		= SetAlpha(FixColor($ADADAD), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($999999), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($999999), 255)
		
		\ShadeColor[#Cold]		= SetAlpha(FixColor($DEDEDE), 255)
		\ShadeColor[#Warm]		= SetAlpha(FixColor($D3D3D3), 255)
		\ShadeColor[#Hot]		= SetAlpha(FixColor($C4C4C4), 255)
		
		\LineColor[#Cold]		= SetAlpha(FixColor($ADADAD), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($90C8F6), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($90C8F6), 255)
		\LineColor[#Disabled]	= SetAlpha(FixColor($ADADAD), 255)
		
		\TextColor[#Cold] 		= SetAlpha(FixColor($000000), 255)
		\TextColor[#Warm]		= SetAlpha(FixColor($000000), 255)
		\TextColor[#Hot]		= SetAlpha(FixColor($000000), 255)
		\TextColor[#Disabled]	= SetAlpha(FixColor($808080), 255)
		
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
		\WindowTitle			= SetAlpha(FixColor($FFFFFF), 255)
		
		\CornerRadius			= 4
	EndWith
	
	With DarkTheme
		\WindowColor			= SetAlpha(FixColor($36393F), 255)
		
		\BackColor[#Cold]		= SetAlpha(FixColor($36393F), 255)
		\BackColor[#Warm]		= SetAlpha(FixColor($44474C), 255)
		\BackColor[#Hot]		= SetAlpha(FixColor($54575C), 255)
		\BackColor[#Disabled]	= SetAlpha(FixColor($36393F), 255)
		
		\FrontColor[#Cold]		= SetAlpha(FixColor($7E8287), 255)
		\FrontColor[#Warm]		= SetAlpha(FixColor($8F9399), 255)
		\FrontColor[#Hot]		= SetAlpha(FixColor($8F9399), 255)
		
		\ShadeColor[#Cold]		= SetAlpha(FixColor($44474C), 255)
		\ShadeColor[#Warm]		= SetAlpha(FixColor($4F545C), 255)
		\ShadeColor[#Hot]		= SetAlpha(FixColor($676A70), 255)
		
		\LineColor[#Cold]		= SetAlpha(FixColor($7E8287), 255)
		\LineColor[#Warm]		= SetAlpha(FixColor($A2A3A5), 255)
		\LineColor[#Hot]		= SetAlpha(FixColor($A2A3A5), 255)
		\LineColor[#Disabled]	= SetAlpha(FixColor($7E8287), 255)
		
		\TextColor[#Cold]	 	= SetAlpha(FixColor($FAFAFB), 255)
		\TextColor[#Warm]		= SetAlpha(FixColor($FFFFFF), 255)
		\TextColor[#Hot]		= SetAlpha(FixColor($FFFFFF), 255)
		\TextColor[#Disabled]	= SetAlpha(FixColor($808080), 255)
		
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
		\WindowTitle			= SetAlpha(FixColor($202225), 255)
		
		\CornerRadius			= 4
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
	
	Procedure AddPathRoundedBox(Border_X, Border_Y, Border_Width, Border_Height, Radius, Type = #Corner_All)
		
		Select Type
			Case #Corner_All
				MovePathCursor(Border_X, Border_Y + Radius + 1)
				AddPathArc(Border_X, Border_Y + Border_Height, Border_X + Border_Width, Border_Y + Border_Height, Radius)
				AddPathArc(Border_X + Border_Width, Border_Y + Border_Height, Border_X + Border_Width, Border_Y, Radius)
				AddPathArc(Border_X + Border_Width, Border_Y, Border_X, Border_Y, Radius)
				AddPathArc(Border_X, Border_Y, Border_X, Border_Y + Border_Height, Radius)
				ClosePath()
				
			Case #Corner_Top
				MovePathCursor(Border_X, Border_Y + Border_Height)
				AddPathArc(Border_X, Border_Y, Border_X + Border_Width,Border_Y, Radius)
				AddPathArc(Border_X + Border_Width, Border_Y, Border_X + Border_Width, Border_Y + Border_Height, Radius)
				AddPathLine(Border_X + Border_Width, Border_Y + Border_Height)
				ClosePath()
				
			Case #Corner_Bottom
				MovePathCursor(Border_X, Border_Y)
				AddPathLine(Border_X + Border_Width, Border_Y)
				AddPathArc(Border_X + Border_Width, Border_Y + Border_Height, Border_X, Border_Y + Border_Height, Radius)
				AddPathArc(Border_X, Border_Y + Border_Height, Border_X, Border_Y, Radius)
				ClosePath()
				
			Case #Corner_Left
				MovePathCursor(Border_X + Border_Width, Border_Y + Border_Height)
				AddPathArc(Border_X, Border_Y + Border_Height, Border_X, Border_Y, Radius)
				AddPathArc(Border_X, Border_Y, Border_X + Border_Width, Border_Y, Radius)
				AddPathLine(Border_X + Border_Width, Border_Y)
				ClosePath()
				
			Case #Corner_Right
				MovePathCursor(Border_X, Border_Y)
				AddPathArc(Border_X + Border_Width, Border_Y, Border_X + Border_Width, Border_Y + Border_Height, Radius)
				AddPathArc(Border_X + Border_Width, Border_Y + Border_Height, Border_X, Border_Y + Border_Height, Radius)
				AddPathLine(Border_X, Border_Y + Border_Height)
				ClosePath()
				
			Case #Corner_TopLeft
				MovePathCursor(Border_X, Border_Y + Border_Height)
				AddPathArc(Border_X, Border_Y, Border_X + Border_Width, Border_Y, Radius)
				AddPathLine(Border_X + Border_Width, Border_Y)
				AddPathLine(Border_X + Border_Width, Border_Y + Border_Height)
				AddPathLine(Border_X, Border_Y + Border_Height)
				ClosePath()
				
			Case #Corner_TopRight
				MovePathCursor(Border_X, Border_Y + Border_Height)
				AddPathLine(Border_X, Border_Y)
				AddPathArc(Border_X + Border_Width, Border_Y, Border_X + Border_Width, Border_Y + Border_Height, Radius)
				AddPathLine(Border_X + Border_Width, Border_Y + Border_Height)
				ClosePath()
				
			Case #Corner_BottomLeft
				MovePathCursor(Border_X, Border_Y)
				AddPathLine(Border_X + Border_Width, Border_Y)
				AddPathLine(Border_X + Border_Width, Border_Y + Border_Height)
				AddPathArc(Border_X, Border_Y + Border_Height, Border_X, Border_Y, Radius)
				ClosePath()
				
			Case #Corner_BottomRight
				MovePathCursor(Border_X, Border_Y)
				AddPathLine(Border_X + Border_Width, Border_Y)
				AddPathArc(Border_X + Border_Width, Border_Y + Border_Height, Border_X, Border_Y + Border_Height, Radius)
				AddPathLine(Border_X, Border_Y + Border_Height)
				ClosePath()
		EndSelect
	EndProcedure
	
	Procedure PrepareVectorTextBlock(*TextData.Text)
		Protected String.s, Word.s, NewList StringList.s(), Loop, Count, Image, TextHeight, MaxLine, Width, FinalWidth, TextWidth, LineCount, HBitmap.BITMAP
		
		*TextData\RequieredHeight = 0
		*TextData\RequieredWidth = 0
		*TextData\Text = ""
		
		String = ReplaceString(*TextData\OriginalText, #CRLF$, #CR$)
		String = ReplaceString(String, #LF$, #CR$)
		
		Count = CountString(String, #CR$) + 1
		
		Image = CreateImage(#PB_Any, 10, 19)
		StartVectorDrawing(ImageVectorOutput(Image))
		If *TextData\FontScale
			VectorFont(*TextData\FontID, *TextData\FontScale)
		Else
			VectorFont(*TextData\FontID)
		EndIf
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
			GetObject_(*TextData\Image, SizeOf(BITMAP), @HBitmap.BITMAP)
			HBitmap\bmWidth + #TextBlock_ImageMargin
			*TextData\RequieredWidth + HBitmap\bmWidth
		EndIf
		
		Width = *TextData\Width - HBitmap\bmWidth
		
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
			*TextData\ImageY = (*TextData\Height - HBitmap\bmHeight) * 0.5
			*TextData\TextY = (*TextData\Height - LineCount * TextHeight) * 0.5
		ElseIf *TextData\VAlign = #VAlignBottom
			*TextData\TextY = *TextData\Height - LineCount * TextHeight
			*TextData\ImageY = *TextData\Height - HBitmap\bmHeight
		Else 
			*TextData\TextY = 0
			*TextData\ImageY = 0
		EndIf
		
		If *TextData\HAlign = #HAlignCenter
			*TextData\ImageX = (Width - FinalWidth) * 0.5
			*TextData\TextX = HBitmap\bmWidth * 0.5
			*TextData\VectorAlign = #PB_VectorParagraph_Center
		ElseIf *TextData\HAlign = #HAlignRight
			*TextData\ImageX = Width + #TextBlock_ImageMargin
			*TextData\TextX = - HBitmap\bmWidth
			*TextData\VectorAlign =  #PB_VectorParagraph_Right
		Else
			*TextData\ImageX = 0
			*TextData\TextX = HBitmap\bmWidth
			*TextData\VectorAlign =  #PB_VectorParagraph_Left
		EndIf
		
		*TextData\RequieredWidth + 1
		
		StopVectorDrawing()
		FreeImage(Image)
	EndProcedure
	
	Procedure DrawVectorTextBlock(*TextData.Text, X, Y, Alpha = 255)
		MovePathCursor(X + *TextData\TextX, Y + *TextData\TextY, #PB_Path_Default)
		DrawVectorParagraph(*TextData\Text, *TextData\Width, *TextData\Height, *TextData\VectorAlign)
		
		If *TextData\Image
			MovePathCursor(X + *TextData\ImageX, Y + *TextData\ImageY, #PB_Path_Default)
			DrawVectorImage(*TextData\Image, Alpha)
		EndIf
		
	EndProcedure
	
	Procedure Disable(Gadget, State)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		DisableGadget(Gadget, State)
		*GadgetData\Enabled = Bool(Not State)
		*GadgetData\MouseState = #Cold
		RedrawObject()
	EndProcedure
	
	Procedure Freeze(Gadget, State)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		*GadgetData\Freeze = Bool(State)
		RedrawObject()
	EndProcedure
	
	; Default functions
	Procedure Default_EventHandle()
		Protected Event.Event, *this.PB_Gadget = IsGadget(EventGadget()), *GadgetData.GadgetData = *this\vt
		If *GadgetData\Enabled
			Select EventType()
				Case #PB_EventType_MouseEnter
					If *GadgetData\SupportedEvent[#MouseEnter]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #MouseEnter
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_MouseLeave
					If *GadgetData\SupportedEvent[#MouseLeave]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #MouseLeave
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_MouseMove
					If *GadgetData\SupportedEvent[#MouseMove]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #MouseMove
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_MouseWheel
					If *GadgetData\SupportedEvent[#MouseWheel]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\Param = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_WheelDelta)
						Event\EventType = #MouseWheel
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_LeftButtonDown
					If *GadgetData\SupportedEvent[#LeftButtonDown]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #LeftButtonDown
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_LeftButtonUp
					If *GadgetData\SupportedEvent[#LeftButtonUp]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #LeftButtonUp
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_LeftClick
					If *GadgetData\SupportedEvent[#LeftClick]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #LeftClick
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_LeftDoubleClick
					If *GadgetData\SupportedEvent[#LeftDoubleClick]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #LeftDoubleClick
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_RightButtonDown
					If *GadgetData\SupportedEvent[#RightButtonDown]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\Param = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_Key)
						Event\EventType = #RightButtonDown
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_RightButtonUp
					If *GadgetData\SupportedEvent[#RightButtonUp]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #RightButtonUp
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_RightClick
					If *GadgetData\SupportedEvent[#RightClick]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #RightClick
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_RightDoubleClick
					If *GadgetData\SupportedEvent[#RightDoubleClick]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #RightDoubleClick
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_MiddleButtonDown
					If *GadgetData\SupportedEvent[#MiddleButtonDown]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #MiddleButtonDown
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_MiddleButtonUp
					If *GadgetData\SupportedEvent[#MiddleButtonUp]
						Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
						Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
						Event\EventType = #MiddleButtonUp
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_Focus
					If *GadgetData\SupportedEvent[#Focus]
						Event\EventType = #Focus
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_LostFocus
					If *GadgetData\SupportedEvent[#LostFocus]
						Event\EventType = #LostFocus
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_KeyDown
					If *GadgetData\SupportedEvent[#KeyDown]
						Event\EventType = #KeyDown
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_KeyUp
					If *GadgetData\SupportedEvent[#KeyUp]
						Event\EventType = #KeyUp
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_Input
					If *GadgetData\SupportedEvent[#Input]
						Event\EventType = #Input
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Case #PB_EventType_Resize
					If *GadgetData\SupportedEvent[#Resize]
						Event\EventType = #Resize
						*GadgetData\EventHandler(*GadgetData, Event)
					EndIf
					
				Default
					ProcedureReturn
			EndSelect
		EndIf
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
	
	Procedure Default_ResizeGadget(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.GadgetData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			*GadgetData\TextBock\Width = \Width 
			*GadgetData\TextBock\Height = \Height 
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
			RedrawObject()
		EndWith
	EndProcedure
	
	; Getters
	Procedure Default_GetFont(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\TextBock\FontID
	EndProcedure
	
	Procedure Default_GetColor(*This.PB_Gadget, ColorType)
		Protected *GadgetData.GadgetData = *this\vt, Result
		
		Select ColorType
			Case #Color_Back_Cold
				Result = *GadgetData\ThemeData\BackColor[#Cold]
			Case #Color_Back_Warm
				Result = *GadgetData\ThemeData\BackColor[#Warm]
			Case #Color_Back_Hot
				Result = *GadgetData\ThemeData\BackColor[#Hot]
			Case #Color_Back_Disabled
				Result = *GadgetData\ThemeData\BackColor[#Disabled]
			Case #Color_Text_Cold
				Result = *GadgetData\ThemeData\TextColor[#Cold]
			Case #Color_Text_Warm
				Result = *GadgetData\ThemeData\TextColor[#Warm]
			Case #Color_Text_Hot
				Result = *GadgetData\ThemeData\TextColor[#Hot]
			Case #Color_Text_Disabled
				Result = *GadgetData\ThemeData\TextColor[#Disabled]
			Case #Color_Parent
				Result = *GadgetData\ThemeData\WindowColor
			Case #Color_Shade_Cold
				Result = *GadgetData\ThemeData\ShadeColor[#Cold]
			Case #Color_Shade_Warm
				Result = *GadgetData\ThemeData\ShadeColor[#Warm]
			Case #Color_Shade_Hot
				Result = *GadgetData\ThemeData\ShadeColor[#Hot]
			Case #Color_Shade_Disabled
				Result = *GadgetData\ThemeData\ShadeColor[#Disabled]
			Case #Color_Line_Cold
				Result = *GadgetData\ThemeData\LineColor[#Cold]
			Case #Color_Line_Warm
				Result = *GadgetData\ThemeData\LineColor[#Warm]
			Case #Color_Line_Hot
				Result = *GadgetData\ThemeData\LineColor[#Hot]
			Case #Color_Line_Disabled
				Result = *GadgetData\ThemeData\LineColor[#Disabled]
			Case #Color_Special1_Cold
				Result = *GadgetData\ThemeData\Special1[#Cold]
			Case #Color_Special1_Warm
				Result = *GadgetData\ThemeData\Special1[#Warm]
			Case #Color_Special1_Hot
				Result = *GadgetData\ThemeData\Special1[#Hot]
			Case #Color_Special1_Disabled
				Result = *GadgetData\ThemeData\Special1[#Disabled]
			Case #Color_Special2_Cold
				Result = *GadgetData\ThemeData\Special2[#Cold]
			Case #Color_Special2_Warm
				Result = *GadgetData\ThemeData\Special2[#Warm]
			Case #Color_Special2_Hot
				Result = *GadgetData\ThemeData\Special2[#Hot]
			Case #Color_Special2_Disabled
				Result = *GadgetData\ThemeData\Special2[#Disabled]
			Case #Color_Special3_Cold
				Result = *GadgetData\ThemeData\Special3[#Cold]
			Case #Color_Special3_Warm
				Result = *GadgetData\ThemeData\Special3[#Warm]
			Case #Color_Special3_Hot
				Result = *GadgetData\ThemeData\Special3[#Hot]
			Case #Color_Special3_Disabled
				Result = *GadgetData\ThemeData\Special3[#Disabled]
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
	
	Procedure Default_GetAttribute(*This.PB_Gadget, Attribute)
		Protected *GadgetData.GadgetData = *this\vt, Result
		
		With *GadgetData
			Select Attribute
				Case #Attribute_CornerRadius
					Result = \ThemeData\CornerRadius
				Case #Attribute_Border
					Result = \Border
				Case #Attribute_TextScale
					Result = \TextBock\FontScale
				Case #Attribute_CornerType
					Result = \CornerType
				Default
					*GadgetData\OriginalVT\GetGadgetAttribute(*This, Attribute)
			EndSelect
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure.s Default_GetText(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\TextBock\OriginalText
	EndProcedure
	
	Procedure GetGadgetImage(Gadget)
		
	EndProcedure
	
	Procedure GetGadgetItemImage(Gadget, Position)
		Protected *this.PB_Gadget = IsGadget(Gadget)
		
		If *this\vt\GetGadgetItemImage
			ProcedureReturn CallFunctionFast(*this\vt\GetGadgetItemImage, *this, Position)
		EndIf
	EndProcedure
	
	Procedure GetAccessibilityMode()
		ProcedureReturn AccessibilityMode
	EndProcedure
	
	; Setters
	Procedure SetAccessibilityMode(MouseState)
		AccessibilityMode = MouseState
	EndProcedure
	
	Procedure SetGadgetColorScheme(Gadget, ThemeJson.s)
	EndProcedure
	
	Procedure.s GetGadgetColorScheme(Gadget)	
	EndProcedure
	
	Procedure SetGadgetImage(Gadget, Image)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		*GadgetData\TextBock\Image = Image
		
		PrepareVectorTextBlock(@*GadgetData\TextBock)
		RedrawObject()
	EndProcedure
	
	Procedure SubClassFunction(Gadget, Function, *Adress) ; Advanced functionnality! Probably too much of a niche usage, move it to the private branche of UITK?
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt, *Result
		
		Select Function
			Case #SubClass_EventHandler
				*Result = *GadgetData\EventHandler
				*GadgetData\EventHandler = *Adress
			Case #SubClass_GadgetCallback
				*Result = *this\vt\GadgetCallback
				*this\vt\GadgetCallback = *Adress
			Case #SubClass_FreeGadget
				*Result = *this\vt\FreeGadget
				*this\vt\FreeGadget = *Adress
			Case #SubClass_GetGadgetState
				*Result = *this\vt\GetGadgetState
				*this\vt\GetGadgetState = *Adress
			Case #SubClass_SetGadgetState
				*Result = *this\vt\SetGadgetState
				*this\vt\SetGadgetState = *Adress
			Case #SubClass_GetGadgetText
				*Result = *this\vt\GetGadgetText
				*this\vt\GetGadgetText = *Adress
			Case #SubClass_SetGadgetText
				*Result = *this\vt\SetGadgetText
				*this\vt\SetGadgetText = *Adress
			Case #SubClass_AddGadgetItem2
				*Result = *this\vt\AddGadgetItem2
				*this\vt\AddGadgetItem2 = *Adress
			Case #SubClass_AddGadgetItem3
				*Result = *this\vt\AddGadgetItem3
				*this\vt\AddGadgetItem3 = *Adress
			Case #SubClass_RemoveGadgetItem
				*Result = *this\vt\RemoveGadgetItem
				*this\vt\RemoveGadgetItem = *Adress
			Case #SubClass_ClearGadgetItemList
				*Result = *this\vt\ClearGadgetItemList
				*this\vt\ClearGadgetItemList = *Adress
			Case #SubClass_ResizeGadget
				*Result = *this\vt\ResizeGadget
				*this\vt\ResizeGadget = *Adress
			Case #SubClass_CountGadgetItems
				*Result = *this\vt\CountGadgetItems
				*this\vt\CountGadgetItems = *Adress
			Case #SubClass_GetGadgetItemState
				*Result = *this\vt\GetGadgetItemState
				*this\vt\GetGadgetItemState = *Adress
			Case #SubClass_SetGadgetItemState
				*Result = *this\vt\SetGadgetItemState
				*this\vt\SetGadgetItemState = *Adress
			Case #SubClass_GetGadgetItemText
				*Result = *this\vt\GetGadgetItemText
				*this\vt\GetGadgetItemText = *Adress
			Case #SubClass_SetGadgetItemText
				*Result = *this\vt\SetGadgetItemText
				*this\vt\SetGadgetItemText = *Adress
			Case #SubClass_OpenGadgetList2
				*Result = *this\vt\OpenGadgetList2
				*this\vt\OpenGadgetList2 = *Adress
			Case #SubClass_GadgetX
				*Result = *this\vt\GadgetX
				*this\vt\GadgetX = *Adress
			Case #SubClass_GadgetY
				*Result = *this\vt\GadgetY
				*this\vt\GadgetY = *Adress
			Case #SubClass_GadgetWidth
				*Result = *this\vt\GadgetWidth
				*this\vt\GadgetWidth = *Adress
			Case #SubClass_GadgetHeight
				*Result = *this\vt\GadgetHeight
				*this\vt\GadgetHeight = *Adress
			Case #SubClass_HideGadget
				*Result = *this\vt\HideGadget
				*this\vt\HideGadget = *Adress
			Case #SubClass_AddGadgetColumn
				*Result = *this\vt\AddGadgetColumn
				*this\vt\AddGadgetColumn = *Adress
			Case #SubClass_RemoveGadgetColumn
				*Result = *this\vt\RemoveGadgetColumn
				*this\vt\RemoveGadgetColumn = *Adress
			Case #SubClass_GetGadgetAttribute
				*Result = *this\vt\GetGadgetAttribute
				*this\vt\GetGadgetAttribute = *Adress
			Case #SubClass_SetGadgetAttribute
				*Result = *this\vt\SetGadgetAttribute
				*this\vt\SetGadgetAttribute = *Adress
			Case #SubClass_GetGadgetItemAttribute2
				*Result = *this\vt\GetGadgetItemAttribute2
				*this\vt\GetGadgetItemAttribute2 = *Adress
			Case #SubClass_SetGadgetItemAttribute2
				*Result = *this\vt\SetGadgetItemAttribute2
				*this\vt\SetGadgetItemAttribute2 = *Adress
			Case #SubClass_SetGadgetColor
				*Result = *this\vt\SetGadgetColor
				*this\vt\SetGadgetColor = *Adress
			Case #SubClass_GetGadgetColor
				*Result = *this\vt\GetGadgetColor
				*this\vt\GetGadgetColor = *Adress
			Case #SubClass_SetGadgetItemColor2
				*Result = *this\vt\SetGadgetItemColor2
				*this\vt\SetGadgetItemColor2 = *Adress
			Case #SubClass_GetGadgetItemColor2
				*Result = *this\vt\GetGadgetItemColor2
				*this\vt\GetGadgetItemColor2 = *Adress
			Case #SubClass_SetGadgetItemData
				*Result = *this\vt\SetGadgetItemData
				*this\vt\SetGadgetItemData = *Adress
			Case #SubClass_GetGadgetItemData
				*Result = *this\vt\GetGadgetItemData
				*this\vt\GetGadgetItemData = *Adress
			Case #SubClass_GetRequiredSize
				*Result = *this\vt\GetRequiredSize
				*this\vt\GetRequiredSize = *Adress
			Case #SubClass_SetActiveGadget
				*Result = *this\vt\SetActiveGadget
				*this\vt\SetActiveGadget = *Adress
			Case #SubClass_GetGadgetFont
				*Result = *this\vt\GetGadgetFont
				*this\vt\GetGadgetFont = *Adress
			Case #SubClass_SetGadgetFont
				*Result = *this\vt\SetGadgetFont
				*this\vt\SetGadgetFont = *Adress
			Case #SubClass_SetGadgetItemImage
				*Result = *this\vt\SetGadgetItemImage
				*this\vt\SetGadgetItemImage = *Adress
		EndSelect
		
		ProcedureReturn *Result
	EndProcedure
	
	Procedure Default_SetAttribute(*This.PB_Gadget, Attribute, Value)
		Protected *GadgetData.GadgetData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #Attribute_CornerRadius
					\ThemeData\CornerRadius = Value
				Case #Attribute_Border
					\Border = Value
				Case #Attribute_TextScale
					\TextBock\FontScale = Value
					PrepareVectorTextBlock(@\TextBock)
				Case #Attribute_CornerType
					\CornerType = Value
				Default
					*GadgetData\OriginalVT\SetGadgetAttribute(*This, Attribute, Value)
			EndSelect
		EndWith
		
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetFont(*this.PB_Gadget, FontID)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\TextBock\FontID = FontID
		PrepareVectorTextBlock(@*GadgetData\TextBock)
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.GadgetData = *this\vt
		
		Select ColorType
			Case #Color_Back_Cold
				*GadgetData\ThemeData\BackColor[#Cold] = Color
			Case #Color_Back_Warm
				*GadgetData\ThemeData\BackColor[#Warm] = Color
			Case #Color_Back_Hot
				*GadgetData\ThemeData\BackColor[#Hot] = Color
			Case #Color_Back_Disabled
				*GadgetData\ThemeData\BackColor[#Disabled] = Color
			Case #Color_Text_Cold
				*GadgetData\ThemeData\TextColor[#Cold] = Color
			Case #Color_Text_Warm
				*GadgetData\ThemeData\TextColor[#Warm] = Color
			Case #Color_Text_Hot
				*GadgetData\ThemeData\TextColor[#Hot] = Color
			Case #Color_Text_Disabled
				*GadgetData\ThemeData\TextColor[#Disabled] = Color
			Case #Color_Parent
				*GadgetData\ThemeData\WindowColor = Color
			Case #Color_Shade_Cold
				*GadgetData\ThemeData\ShadeColor[#Cold] = Color
			Case #Color_Shade_Warm                      
				*GadgetData\ThemeData\ShadeColor[#Warm] = Color
			Case #Color_Shade_Hot                       
				*GadgetData\ThemeData\ShadeColor[#Hot] = Color
			Case #Color_Shade_Disabled
				*GadgetData\ThemeData\ShadeColor[#Disabled] = Color
			Case #Color_Line_Cold
				*GadgetData\ThemeData\LineColor[#Cold] = Color
			Case #Color_Line_Warm                   
				*GadgetData\ThemeData\LineColor[#Warm] = Color
			Case #Color_Line_Hot                    
				*GadgetData\ThemeData\LineColor[#Hot] = Color
			Case #Color_Line_Disabled              
				*GadgetData\ThemeData\LineColor[#Disabled] = Color
			Case #Color_Special1_Cold
				*GadgetData\ThemeData\Special1[#Cold] = Color
			Case #Color_Special1_Warm
				*GadgetData\ThemeData\Special1[#Warm] = Color
			Case #Color_Special1_Hot
				*GadgetData\ThemeData\Special1[#Hot] = Color
			Case #Color_Special1_Disabled
				*GadgetData\ThemeData\Special1[#Disabled] = Color
			Case #Color_Special2_Cold
				*GadgetData\ThemeData\Special2[#Cold] = Color
			Case #Color_Special2_Warm
				*GadgetData\ThemeData\Special2[#Warm] = Color
			Case #Color_Special2_Hot
				*GadgetData\ThemeData\Special2[#Hot] = Color
			Case #Color_Special2_Disabled
				*GadgetData\ThemeData\Special2[#Disabled] = Color
			Case #Color_Special3_Cold
				*GadgetData\ThemeData\Special3[#Cold] = Color
			Case #Color_Special3_Warm
				*GadgetData\ThemeData\Special3[#Warm] = Color
			Case #Color_Special3_Hot
				*GadgetData\ThemeData\Special3[#Hot] = Color
			Case #Color_Special3_Disabled
				*GadgetData\ThemeData\Special3[#Disabled] = Color
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
	;}
	
	;{ Timer 
	Prototype TimerCallback(*Gadget.GadgetData, Timer)
	Structure TimerData
		*Callback.TimerCallback
		*Gadget.GadgetData
	EndStructure
	
	Global NewMap Timers.TimerData(), TimerWindow = OpenWindow(#PB_Any, 0, 0, 100, 100, "", #PB_Window_Invisible)
	
	Procedure Timer_Handler()
		Protected Timer = EventTimer()
		FindMapElement(Timers(), Hex(Timer))
		Timers()\Callback(Timers()\Gadget, Timer)
	EndProcedure
	
	BindEvent(#PB_Event_Timer, @Timer_Handler(), TimerWindow)
	
	Procedure AddGadgetTimer(*Gadget.GadgetData, TimeOut, *Callback)
		Protected Timer
		
		Timer = AddWindowTimer(TimerWindow, Random(1048575, 1), TimeOut) ; can't use PB_Any with a timer...
		
		AddMapElement(Timers(), Hex(Timer))
		Timers()\Callback = *Callback
		Timers()\Gadget = *Gadget
		
		ProcedureReturn Timer
	EndProcedure
	
	Procedure RemoveGadgetTimer(Timer)
		RemoveWindowTimer(TimerWindow, Timer)
		DeleteMapElement(Timers(), Hex(Timer))
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
					ElseIf posX <= #SizableBorder And posY > #SizableBorder And posY <= *WindowData\Height - #SizableBorder
						SetCursor_(LoadCursor_(0, #IDC_SIZEWE))
						*WindowData\sizeCursor = #HTLEFT
					EndIf
				EndIf
				;}
			Case #WM_LBUTTONDBLCLK ;{
				If cursor\y <= #WindowBarHeight And *WindowData\sizeCursor = 0 And *WindowData\Sizable
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
				
				If *WindowData\Sizable
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
			*WindowData.ThemedWindow = GetProp_(*WindowBarData\Parent, "UITK_WindowData")
			If *WindowData\Sizable
				If IsZoomed_(*WindowBarData\Parent)
					ShowWindow_(*WindowBarData\Parent, #SW_RESTORE)
				Else
					ShowWindow_(*WindowBarData\Parent, #SW_MAXIMIZE)
				EndIf
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
			
			If *WindowData\Sizable
				posX = lParam & $FFFF
				posY = (lParam >> 16) & $FFFF
				*WindowBarData\sizeCursor = 0
				
				If posY < #SizableBorder
					SetCursor_(LoadCursor_(0, #IDC_SIZENS))
					*WindowBarData\sizeCursor = #HTTOP
				EndIf
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
			Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, (Bool(Flags & #Window_CloseButton) * #PB_Window_SystemMenu) |
			                                                                  (Bool(Flags & #Window_MaximizeButton) * #PB_Window_Maximize) |
			                                                                  (Bool(Flags & #Window_MinimizeButton) * #PB_Window_Minimize) |
			                                                                  (Bool(Flags & #PB_Window_SizeGadget) * #PB_Window_SizeGadget) |
			                                                                  (Bool(Flags & #PB_Window_Invisible) * #PB_Window_Invisible) |
			                                                                  (Bool(Flags & #PB_Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
		Else
			AllocateStructureX(*WindowData, ThemedWindow)
			*WindowData\Sizable = Bool(Flags & #PB_Window_SizeGadget)
			
			If *WindowData\Sizable
				Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, (#WS_OVERLAPPEDWINDOW&~#WS_SYSMENU) | #PB_Window_Invisible | (Bool(Flags & #PB_Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
			Else
				InnerHeight + #WindowBarHeight
				Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, #PB_Window_BorderLess | #PB_Window_Invisible | (Bool(Flags & #PB_Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
			EndIf
			
			If Window = #PB_Any
				Window = Result
			EndIf
			
			WindowID = WindowID(Window)
			
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, *WindowData\Theme, Theme)
			Else
				CopyStructure(@DefaultTheme, *WindowData\Theme, Theme)
			EndIf
			
			Image = CreateImage(#PB_Any, 8, 8, 32, SetAlpha(*WindowData\Theme\WindowTitle, 255)) ; Removing SetAlpha makes LightTheme goes derp. Can anybody explain?
			*WindowData\Brush = CreatePatternBrush_(ImageID(Image))
			*WindowData\Width = WindowWidth(Window)
			*WindowData\Height = WindowHeight(Window)
			
			FreeImage(Image)
			
			SetClassLongPtr_(WindowID, #GCL_HBRBACKGROUND, *WindowData\Brush)
			
			SetProp_(WindowID, "UITK_WindowData", *WindowData)
			
			*WindowData\OriginalProc = SetWindowLongPtr_(WindowID, #GWL_WNDPROC, @Window_Handler())
			
			If Flags & #Window_CloseButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonClose = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "", Flags & #DarkMode * #DarkMode)
				
				SetGadgetAttribute(*WindowData\ButtonClose, #Attribute_CornerRadius, 0)
				
				SetGadgetFont(*WindowData\ButtonClose, IconFont)
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
				
				BindGadgetEvent(*WindowData\ButtonClose, @CloseButton_Handler(), #PB_EventType_Change)
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Warm, SetAlpha(FixColor($E81123), 255))
				SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Hot, SetAlpha(FixColor($F1707A), 255))
				
				SetGadgetColor(*WindowData\ButtonClose, #Color_Text_Warm, SetAlpha(FixColor($FFFFFF), 255))
				SetGadgetColor(*WindowData\ButtonClose, #Color_Text_Hot, SetAlpha(FixColor($FFFFFF), 255))
			EndIf
			
			If Flags & #Window_MaximizeButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonMaximize = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "", Flags & #DarkMode * #DarkMode)
				
				SetGadgetAttribute(*WindowData\ButtonMaximize, #Attribute_CornerRadius, 0)
				
				SetGadgetFont(*WindowData\ButtonMaximize, IconFont)
				
				SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
			EndIf
			
			If Flags & #Window_MinimizeButton
				OffsetX + #WindowButtonWidth
				*WindowData\ButtonMinimize = Button(#PB_Any, *WindowData\Width - OffsetX, 0, #WindowButtonWidth, #WindowBarHeight, "",Flags & #DarkMode * #DarkMode)
				
				SetGadgetAttribute(*WindowData\ButtonMinimize, #Attribute_CornerRadius, 0)
				
				SetGadgetFont(*WindowData\ButtonMinimize, IconFont)
				
				SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
			EndIf
			
			*WindowData\Label = Label(#PB_Any, #SizableBorder, 0, *WindowData\Width - OffsetX, #WindowBarHeight , Title, (Flags & #DarkMode * #DarkMode) | #HAlignLeft | #VAlignCenter)
			SetGadgetColor(*WindowData\Label, #Color_Parent, *WindowData\Theme\WindowTitle)
			*WindowData\LabelWidth = GadgetWidth(*WindowData\Label, #PB_Gadget_RequiredSize)
			ResizeGadget(*WindowData\Label, #PB_Ignore, #PB_Ignore, *WindowData\LabelWidth, #PB_Ignore)
			
			If Flags & #HAlignRight
				*WindowData\LabelAlign = #HAlignRight
			ElseIf Flags & #HAlignCenter
				*WindowData\LabelAlign = #HAlignCenter
			Else
				*WindowData\LabelAlign = #HAlignLeft
			EndIf
			
			AllocateStructureX(*WindowBarData, WindowBar)
			*WindowBarData\Parent = WindowID
			SetProp_(GadgetID(*WindowData\Label), "UITK_WindowBarData", *WindowBarData)
			*WindowBarData\OriginalProc = SetWindowLongPtr_(GadgetID(*WindowData\Label), #GWL_WNDPROC, @WindowBar_Handler())
			
			*WindowData\Container = ContainerGadget(#PB_Any, 0, #WindowBarHeight, *WindowData\Width, *WindowData\Height - #WindowBarHeight, #PB_Container_BorderLess)
			AllocateStructureX(*ContainerData, WindowContainer)
			*ContainerData\Parent = WindowID
			SetProp_(GadgetID(*WindowData\Container), "UITK_ContainerData", *WindowBarData)
			*ContainerData\OriginalProc = SetWindowLongPtr_(GadgetID(*WindowData\Container), #GWL_WNDPROC, @WindowContainer_Handler())
			SetGadgetColor(*WindowData\Container, #PB_Gadget_BackColor, RGB(Red(*WindowData\Theme\WindowColor), Green(*WindowData\Theme\WindowColor), Blue(*WindowData\Theme\WindowColor)))
			
			SetWindowPos_(WindowID, 0, 0, 0, 0, 0, #SWP_NOSIZE|#SWP_NOMOVE|#SWP_FRAMECHANGED)
			
			HideWindow(Window, Bool(Flags & #PB_Window_Invisible))
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure Handler_Menu()
		Protected MenuButton = GetGadgetData(EventGadget())
		
		If GetGadgetState(MenuButton)
			SetGadgetState(MenuButton, #False)
		EndIf
	EndProcedure
	
	Procedure Handler_MenuButton()
		Protected Button = EventGadget()
		ShowFlatMenu(GetGadgetData(Button), GadgetX(Button, #PB_Gadget_ScreenCoordinate) - 1, GadgetY(Button, #PB_Gadget_ScreenCoordinate) + GadgetHeight(Button))
	EndProcedure
	
	Procedure AddWindowMenu(Window, Menu, Title.s)
		Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		Protected WindowGadgetList
		
		With *WindowData
			If ListSize(\MenuList()) = 0
				SetGadgetText(\Label, "")
				\LabelWidth = GadgetWidth(\Label, #PB_Gadget_RequiredSize)
				\LabelAlign = #HAlignLeft
				ResizeGadget(\Label, #SizableBorder, #PB_Ignore, \LabelWidth, #PB_Ignore)
				\MenuOffset = \LabelWidth + #SizableBorder
			EndIf
			
			AddElement(\MenuList())
			If UseGadgetList(0) = WindowID(Window)
				CloseGadgetList()
			Else
				WindowGadgetList = UseGadgetList(WindowID(Window))
			EndIf
			
			UseGadgetList(WindowID(Window))
			
			\MenuList() = Button(#PB_Any, \MenuOffset, 0, 100, #WindowBarHeight, Title, #Button_Toggle)
			SetGadgetAttribute(\MenuList(), #Attribute_CornerRadius, 0)
			SetGadgetColor(\MenuList(), #Color_Back_Cold, \Theme\WindowTitle)
			SetGadgetColor(\MenuList(), #Color_Back_Warm, \Theme\ShadeColor[#Warm])
			SetGadgetColor(\MenuList(), #Color_Back_Hot, \Theme\ShadeColor[#Cold])
			ResizeGadget(\MenuList(), #PB_Ignore, #PB_Ignore, GadgetWidth(\MenuList(), #PB_Gadget_RequiredSize) + 2 * #SizableBorder, #PB_Ignore)
			\MenuOffset + GadgetWidth(\MenuList())
			
			BindGadgetEvent(*MenuData\Canvas, @Handler_Menu(), #PB_EventType_CloseItem)
			BindGadgetEvent(\MenuList(), @Handler_MenuButton(), #PB_EventType_Change)
			SetGadgetData(*MenuData\Canvas, \MenuList())
			SetGadgetData(\MenuList(), Menu)
			*MenuData\Border = 1
			ResizeGadget(*MenuData\Canvas, #PB_Ignore, 0, #PB_Ignore, #PB_Ignore)
			ResizeWindow(*MenuData\Window, #PB_Ignore, #PB_Ignore, *MenuData\Width + 2, *MenuData\Height + *MenuData\Border)
			
			
			If WindowGadgetList
				UseGadgetList(WindowGadgetList)
				*WindowData.ThemedWindow = GetProp_(WindowID(WindowGadgetList), "UITK_WindowData")
				OpenGadgetList(\Container)
			Else
				OpenGadgetList(\Container)
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure OpenWindowGadgetList(Window)
		Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
		
		OpenGadgetList(*WindowData\Container)
	EndProcedure
	
	; Setters
	
	Procedure SetWindowBounds(Window, MinWidth, MinHeight, MaxWidth, MaxHeight)
		Protected *WindowData.ThemedWindow
		
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		
		*WindowData\MinHeight = MinHeight
		*WindowData\MinWidth = MinWidth
		*WindowData\MaxWidth = MaxWidth
		*WindowData\MaxHeight = MaxHeight
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
	
	Procedure WindowSetColor(Window, ColorType, Color)
		Protected *WindowData.ThemedWindow, Image, *OldBrush
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		
		Select ColorType
			Case #Color_Back_Cold
				*WindowData\Theme\BackColor[#Cold] = Color
			Case #Color_Back_Warm
				*WindowData\Theme\BackColor[#Warm] = Color
			Case #Color_Back_Hot
				*WindowData\Theme\BackColor[#Hot] = Color
			Case #Color_Back_Disabled
				*WindowData\Theme\BackColor[#Disabled] = Color
			Case #Color_Text_Cold
				*WindowData\Theme\TextColor[#Cold] = Color
			Case #Color_Text_Warm
				*WindowData\Theme\TextColor[#Warm] = Color
			Case #Color_Text_Hot
				*WindowData\Theme\TextColor[#Hot] = Color
			Case #Color_Text_Disabled
				*WindowData\Theme\TextColor[#Disabled] = Color
			Case #Color_Parent
				*WindowData\Theme\WindowColor = Color
				SetGadgetColor(*WindowData\Container, #PB_Gadget_BackColor, RGB(Red(Color),Green(Color),Blue(Color)))
			Case #Color_Shade_Cold
				*WindowData\Theme\ShadeColor[#Cold] = Color
			Case #Color_Shade_Warm                      
				*WindowData\Theme\ShadeColor[#Warm] = Color
			Case #Color_Shade_Hot                       
				*WindowData\Theme\ShadeColor[#Hot] = Color
			Case #Color_Shade_Disabled
				*WindowData\Theme\ShadeColor[#Disabled] = Color
			Case #Color_Line_Cold
				*WindowData\Theme\LineColor[#Cold] = Color
			Case #Color_Line_Warm                   
				*WindowData\Theme\LineColor[#Warm] = Color
			Case #Color_Line_Hot                    
				*WindowData\Theme\LineColor[#Hot] = Color
			Case #Color_Line_Disabled              
				*WindowData\Theme\LineColor[#Disabled] = Color
			Case #Color_Special1_Cold
				*WindowData\Theme\Special1[#Cold] = Color
			Case #Color_Special1_Warm
				*WindowData\Theme\Special1[#Warm] = Color
			Case #Color_Special1_Hot
				*WindowData\Theme\Special1[#Hot] = Color
			Case #Color_Special1_Disabled
				*WindowData\Theme\Special1[#Disabled] = Color
			Case #Color_Special2_Cold
				*WindowData\Theme\Special2[#Cold] = Color
			Case #Color_Special2_Warm
				*WindowData\Theme\Special2[#Warm] = Color
			Case #Color_Special2_Hot
				*WindowData\Theme\Special2[#Hot] = Color
			Case #Color_Special2_Disabled
				*WindowData\Theme\Special2[#Disabled] = Color
			Case #Color_Special3_Cold
				*WindowData\Theme\Special3[#Cold] = Color
			Case #Color_Special3_Warm
				*WindowData\Theme\Special3[#Warm] = Color
			Case #Color_Special3_Hot
				*WindowData\Theme\Special3[#Hot] = Color
			Case #Color_Special3_Disabled
				*WindowData\Theme\Special3[#Disabled] = Color
			Case #Color_WindowBorder
				*WindowData\Theme\WindowTitle = Color
				*OldBrush = *WindowData\Brush
				Image = CreateImage(#PB_Any, 8, 8, 32, SetAlpha(*WindowData\Theme\WindowTitle, 255)) ; Removing SetAlpha makes LightTheme goes derp. Can anybody explain?
				*WindowData\Brush = CreatePatternBrush_(ImageID(Image))
				FreeImage(Image)
				SetClassLongPtr_(WindowID(Window), #GCL_HBRBACKGROUND, *WindowData\Brush)
				DeleteObject_(*OldBrush)
				SetGadgetColor(*WindowData\Label, #Color_Parent, *WindowData\Theme\WindowTitle)
				
				If *WindowData\ButtonMinimize
					SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
				EndIf
				If *WindowData\ButtonMaximize
					SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
				EndIf
				If *WindowData\ButtonClose
					SetGadgetColor(*WindowData\ButtonClose, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
				EndIf
				
		EndSelect
		
		
	EndProcedure
	
	; Getters
	Procedure GetWindowIcon(Window)
		Protected *WindowData.ThemedWindow
		
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		ProcedureReturn GetGadgetImage(*WindowData\Label)
	EndProcedure
	
	Procedure WindowGetColor(Window, ColorType)
		Protected *WindowData.ThemedWindow, Result
		
		*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
		
		Select ColorType
			Case #Color_Back_Cold
				Result = *WindowData\Theme\BackColor[#Cold]
			Case #Color_Back_Warm
				Result = *WindowData\Theme\BackColor[#Warm]
			Case #Color_Back_Hot
				Result = *WindowData\Theme\BackColor[#Hot]
			Case #Color_Back_Disabled
				Result = *WindowData\Theme\BackColor[#Disabled]
			Case #Color_Text_Cold
				Result = *WindowData\Theme\TextColor[#Cold]
			Case #Color_Text_Warm
				Result = *WindowData\Theme\TextColor[#Warm]
			Case #Color_Text_Hot
				Result = *WindowData\Theme\TextColor[#Hot]
			Case #Color_Text_Disabled
				Result = *WindowData\Theme\TextColor[#Disabled]
			Case #Color_Parent
				Result = *WindowData\Theme\WindowColor
			Case #Color_Shade_Cold
				Result = *WindowData\Theme\ShadeColor[#Cold]
			Case #Color_Shade_Warm                      
				Result = *WindowData\Theme\ShadeColor[#Warm]
			Case #Color_Shade_Hot                       
				Result = *WindowData\Theme\ShadeColor[#Hot]
			Case #Color_Shade_Disabled
				Result = *WindowData\Theme\ShadeColor[#Disabled]
			Case #Color_Line_Cold
				Result = *WindowData\Theme\LineColor[#Cold]
			Case #Color_Line_Warm                   
				Result = *WindowData\Theme\LineColor[#Warm]
			Case #Color_Line_Hot                    
				Result = *WindowData\Theme\LineColor[#Hot]
			Case #Color_Line_Disabled              
				Result = *WindowData\Theme\LineColor[#Disabled]
			Case #Color_Special1_Cold
				Result = *WindowData\Theme\Special1[#Cold]
			Case #Color_Special1_Warm
				Result = *WindowData\Theme\Special1[#Warm]
			Case #Color_Special1_Hot
				Result = *WindowData\Theme\Special1[#Hot]
			Case #Color_Special1_Disabled
				Result = *WindowData\Theme\Special1[#Disabled]
			Case #Color_Special2_Cold
				Result = *WindowData\Theme\Special2[#Cold]
			Case #Color_Special2_Warm
				Result = *WindowData\Theme\Special2[#Warm]
			Case #Color_Special2_Hot
				Result = *WindowData\Theme\Special2[#Hot]
			Case #Color_Special2_Disabled
				Result = *WindowData\Theme\Special2[#Disabled]
			Case #Color_Special3_Cold
				Result = *WindowData\Theme\Special3[#Cold]
			Case #Color_Special3_Warm
				Result = *WindowData\Theme\Special3[#Warm]
			Case #Color_Special3_Hot
				Result = *WindowData\Theme\Special3[#Hot]
			Case #Color_Special3_Disabled
				Result = *WindowData\Theme\Special3[#Disabled]
			Case #Color_WindowBorder
				Result = *WindowData\Theme\WindowTitle
		EndSelect
		
		ProcedureReturn RGB(Red(Result), Green(Result), Blue(Result))
	EndProcedure
	;}
	
	;{ Advanced drag & drop
	Global ADNDWindow = OpenWindow(#PB_Any, 0, 0, 10, 10, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(TimerWindow)) ; Timer window? Shouldn't there be an universal hidden window for UITK rather than piggy backing this one?
	SetWindowLongPtr_(WindowID(ADNDWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(ADNDWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED)
	SetLayeredWindowAttributes_(WindowID(ADNDWindow), 0, 128, #LWA_ALPHA)
	Global ADNDGadget = ImageGadget(#PB_Any, 0, 0, 1, 1, 0)
	Global ADNDHook
	
	#ADND_OffsetX = 8
	#ADND_OffsetY = 8
	
	Procedure ADND_Hook(nCode, wParam, *p.MOUSEHOOKSTRUCT)
		SetWindowPos_(WindowID(ADNDWindow), 0, *p\pt\x + #ADND_OffsetX, *p\pt\y + #ADND_OffsetY, 0, 0, #SWP_NOSIZE|#SWP_NOREDRAW)
		ProcedureReturn CallNextHookEx_(#NUL, nCode, wParam, *p)
	EndProcedure
	
	Procedure AdvancedDragPrivate(Type, ImageID, Action = #PB_Drag_Copy)
		Protected HBitmap.BITMAP
		
		ExamineDesktops()
		GetObject_(ImageID, SizeOf(BITMAP), @HBitmap.BITMAP)
		ResizeWindow(ADNDWindow, DesktopMouseX() + #ADND_OffsetX, DesktopMouseY() + #ADND_OffsetY, HBitmap\bmWidth, HBitmap\bmHeight)
		SetGadgetState(ADNDGadget, ImageID)
		HideWindow(ADNDWindow, #False)
		
		ADNDHook = SetWindowsHookEx_(#WH_MOUSE_LL, @ADND_Hook(), GetModuleHandle_(0), 0)
		
		DragPrivate(Type, Action)
		
		HideWindow(ADNDWindow, #True)
		UnhookWindowsHookEx_(ADNDHook)
	EndProcedure
	
	Procedure AdvancedDragFiles(File.s, ImageID, Action = #PB_Drag_Copy)
		Protected HBitmap.BITMAP
		
		ExamineDesktops()
		GetObject_(ImageID, SizeOf(BITMAP), @HBitmap.BITMAP)
		ResizeWindow(ADNDWindow, DesktopMouseX() + #ADND_OffsetX, DesktopMouseY() + #ADND_OffsetY, HBitmap\bmWidth, HBitmap\bmHeight)
		SetGadgetState(ADNDGadget, ImageID)
		HideWindow(ADNDWindow, #False)
		
		ADNDHook = SetWindowsHookEx_(#WH_MOUSE_LL, @ADND_Hook(), GetModuleHandle_(0), 0)
		
		DragFiles(File, Action)
		
		HideWindow(ADNDWindow, #True)
		UnhookWindowsHookEx_(ADNDHook)
	EndProcedure
	
	Procedure AdvancedDragText(Text.s, ImageID, Action = #PB_Drag_Copy)
		Protected HBitmap.BITMAP
		
		ExamineDesktops()
		GetObject_(ImageID, SizeOf(BITMAP), @HBitmap.BITMAP)
		ResizeWindow(ADNDWindow, DesktopMouseX() + #ADND_OffsetX, DesktopMouseY() + #ADND_OffsetY, HBitmap\bmWidth, HBitmap\bmHeight)
		SetGadgetState(ADNDGadget, ImageID)
		HideWindow(ADNDWindow, #False)
		
		ADNDHook = SetWindowsHookEx_(#WH_MOUSE_LL, @ADND_Hook(), GetModuleHandle_(0), 0)
		
		DragText(Text, Action)
		
		HideWindow(ADNDWindow, #True)
		UnhookWindowsHookEx_(ADNDHook)
	EndProcedure
	
	Procedure AdvancedDragImage(ImageID, Action = #PB_Drag_Copy)
		Protected HBitmap.BITMAP
		
		ExamineDesktops()
		GetObject_(ImageID, SizeOf(BITMAP), @HBitmap.BITMAP)
		ResizeWindow(ADNDWindow, DesktopMouseX() + #ADND_OffsetX, DesktopMouseY() + #ADND_OffsetY, HBitmap\bmWidth, HBitmap\bmHeight)
		SetGadgetState(ADNDGadget, ImageID)
		HideWindow(ADNDWindow, #False)
		
		ADNDHook = SetWindowsHookEx_(#WH_MOUSE_LL, @ADND_Hook(), GetModuleHandle_(0), 0)
		
		DragImage(ImageID, Action)
		
		HideWindow(ADNDWindow, #True)
		UnhookWindowsHookEx_(ADNDHook)
	EndProcedure
	;}
	
	
	;Gadgets:
	;{ Button
	#Button_Margin = 3
	Structure ButtonData Extends GadgetData
		Toggle.b
	EndStructure
	
	Procedure Button_Redraw(*GadgetData.ButtonData)
		Protected State
		
		With *GadgetData
			If \Enabled
				If \State And \MouseState = #cold
					State = #Hot
				Else
					State = \MouseState
				EndIf
			Else
				State = #Disabled
			EndIf
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(\ThemeData\LineColor[State])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\BackColor[State])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			VectorSourceColor(\ThemeData\TextColor[State])
			
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			
			DrawVectorTextBlock(@\TextBock, \OriginX + \HMargin, \OriginY + \VMargin, 145 + Bool(State <> #Disabled) * 110)
			
		EndWith
	EndProcedure
	
	Procedure Button_EventHandler(*GadgetData.ButtonData, *Event.Event)
		Protected Redraw
		
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
					\MouseState = #Cold
					Redraw = #True
					
				Case #KeyDown
					If *Event\Param = #PB_Shortcut_Space
						If \Toggle
							\State = Bool(Not \State) * #hot
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						
						\MouseState = #Hot
						Redraw = #True
					EndIf
				Case #KeyUp
					If *Event\Param = #PB_Shortcut_Space
						\MouseState = #Cold
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
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure Button_Meta(*GadgetData.ButtonData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
		*GadgetData\ThemeData = *ThemeData
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
			
			If \TextBock\HAlign <> #HAlignCenter
				\HMargin = #Button_Margin + \Border
				\VMargin = #Button_Margin
			EndIf
			
			\TextBock\Width = Width - \HMargin * 2
			\TextBock\Height = Height - \VMargin * 2
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
			
			\VT\GetGadgetState = @Default_GetState()
			\VT\SetGadgetState = @Default_SetState()
			
			; Enable only the needed events
			\SupportedEvent[#LeftClick] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#MouseEnter] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#KeyDown] = #True
			\SupportedEvent[#KeyUp] = #True
		EndWith
	EndProcedure
	
	Procedure Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ButtonData, *ThemeData
		
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
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, ButtonData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Button_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
				
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
	
	Procedure Toggle_Redraw(*GadgetData.ToggleData)
		Protected X, Y
		
		With *GadgetData
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			
			VectorSourceColor(\ThemeData\TextColor[\MouseState])
			
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
				VectorSourceColor(\ThemeData\Special2[\MouseState])
				FillPath(#PB_Path_Winding)
				AddPathCircle(X, Y, #ToggleSize * 0.37)
				VectorSourceColor(\ThemeData\Highlight)
				FillPath()
				
				VectorSourceColor(\ThemeData\Special2[\MouseState])
				MovePathCursor(X - #ToggleSize * 0.26, Y, #PB_Path_Default)
				AddPathLine(#ToggleSize * 0.18, #ToggleSize * 0.18, #PB_Path_Relative)
				AddPathLine(#ToggleSize * 0.27, #ToggleSize * -0.37, #PB_Path_Relative)
				
				StrokePath(2)
			Else
				VectorSourceColor(\ThemeData\FrontColor[\MouseState])
				FillPath(#PB_Path_Winding)
				AddPathCircle(X, Y, #ToggleSize * 0.37)
				VectorSourceColor(\ThemeData\Highlight)
				FillPath()
				
				VectorSourceColor(\ThemeData\FrontColor[\MouseState])
				MovePathCursor(X - #ToggleSize * 0.18, Y - #ToggleSize * 0.18, #PB_Path_Default)
				AddPathLine(#ToggleSize * 0.36, #ToggleSize * 0.36, #PB_Path_Relative)
				MovePathCursor(0, #ToggleSize * -0.36, #PB_Path_Relative)
				AddPathLine(#ToggleSize * -0.36, #ToggleSize * 0.36, #PB_Path_Relative)
				StrokePath(2)
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Toggle_EventHandler(*GadgetData.ToggleData, *Event.Event)
		Protected Redraw
		
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
					If *Event\Param = #PB_Shortcut_Space
						\State = Bool(Not \State)
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						Redraw = #True
					EndIf
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure Toggle_Meta(*GadgetData.ToggleData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
		*GadgetData\ThemeData = *ThemeData
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
	EndProcedure
	
	Procedure Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ToggleData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
		
		If Result
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			*this = IsGadget(Gadget)
			AllocateStructureX(*GadgetData, ToggleData)
			CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
			*GadgetData\OriginalVT = *this\VT
			*this\VT = *GadgetData
			
			AllocateStructureX(*ThemeData, Theme)
			
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, *ThemeData, Theme)
			ElseIf Flags & #LightMode
				CopyStructure(@DefaultTheme, *ThemeData, Theme)
			Else
				Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
				If *WindowData
					CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
				Else
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				EndIf
			EndIf
			
			Toggle_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ Checkbox
	#CheckboxSize = 20
	
	Structure CheckBoxData Extends GadgetData
	EndStructure
	
	Procedure CheckBox_Redraw(*GadgetData.CheckBoxData)
		Protected X, Y
		
		With *GadgetData
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			
			VectorSourceColor(\ThemeData\TextColor[\MouseState])
			
			If \TextBock\HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBock, X + \HMargin * 2, Y)
				X = \OriginX + BorderMargin
			Else
				DrawVectorTextBlock(@\TextBock, X, Y)
				X = \OriginX + \Width - #CheckboxSize - BorderMargin
			EndIf
			
			Y = Floor(\OriginY + (\Height - #CheckboxSize) * 0.5)
			
			VectorSourceColor(\ThemeData\FrontColor[\MouseState])
			AddPathBox(X, Y, #CheckboxSize, #CheckboxSize)
			AddPathBox(X + #CheckboxSize * 0.1, Y + #CheckboxSize * 0.1, #CheckboxSize * 0.8, #CheckboxSize * 0.8)
			
			If \State = #True
				AddPathBox(X + #CheckboxSize, Y, #CheckboxSize * -0.25, #CheckboxSize * 0.1)
				AddPathBox(X + #CheckboxSize * 0.9, Y + #CheckboxSize * 0.1, #CheckboxSize * 0.1, #CheckboxSize * 0.25)
				FillPath()
				
				VectorSourceColor(\ThemeData\FrontColor[\MouseState])
				
				MovePathCursor(X + #CheckboxSize * 0.2, Y + #CheckboxSize * 0.4)
				AddPathLine(#CheckboxSize * 0.28, #CheckboxSize * 0.28, #PB_Path_Relative)
				AddPathLine(#CheckboxSize * 0.5, -#CheckboxSize * 0.7, #PB_Path_Relative)
				
				StrokePath(2)
			Else
				FillPath()
				If \State = #PB_Checkbox_Inbetween
					AddPathBox(X + #CheckboxSize * 0.25, Y + #CheckboxSize * 0.25, #CheckboxSize * 0.5, #CheckboxSize * 0.5)
					VectorSourceColor(\ThemeData\FrontColor[\MouseState])
					FillPath()
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure CheckBox_EventHandler(*GadgetData.CheckBoxData, *Event.Event)
		Protected Redraw
		
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
					If *Event\Param = #PB_Shortcut_Space
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
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure CheckBox_Meta(*GadgetData.CheckBoxData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
		*GadgetData\ThemeData = *ThemeData
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
	EndProcedure
	
	Procedure CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.CheckBoxData, *ThemeData 
		
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
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, CheckBoxData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				CheckBox_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
				
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
		DragOffset.l
		ScrollStep.l
		Background.b
	EndStructure
	
	Procedure ScrollBar_Redraw(*GadgetData.ScrollBarData)
		Protected Radius.f, Point
		
		With *GadgetData
			Radius = \Thickness * 0.5
			AddPathCircle(\OriginX + Radius, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
			If \Background
				VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			Else
				VectorSourceColor(0)
			EndIf
			
			If \Vertical
				AddPathBox(- \Thickness, 0, \Width, \Height - \Thickness, #PB_Path_Relative)
				AddPathCircle(\OriginX + Radius, \OriginY + \Height - Radius, Radius, 0, 360, #PB_Path_Default)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\ThemeData\FrontColor[\MouseState])
				
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
					VectorSourceColor(\ThemeData\FrontColor[\MouseState])
					
					AddPathCircle(\OriginX + Radius + \Position, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
					AddPathBox(- Radius, - Radius, \BarSize, \Height, #PB_Path_Relative)
					AddPathCircle(\OriginX + Radius + \Position + \BarSize, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
					
					FillPath(#PB_Path_Winding)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure ScrollBar_EventHandler(*GadgetData.ScrollBarData, *Event.Event)
		Protected Redraw, Mouse, Lenght, Position
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \Drag
						If \Vertical
							Mouse = *Event\MouseY - \OriginY
							Lenght = \Height - \BarSize - \Thickness
						Else
							Mouse = *Event\MouseX - \OriginX
							Lenght = \Width - \BarSize - \Thickness
						EndIf
						
						Position = Clamp(Mouse - \DragOffset, 0, Lenght)
						
						If Position <> \Position
							\Position = Position
							\State = Round(Position / (Lenght) * (\Max - \Min - \PageLenght), #PB_Round_Down)
							Redraw = #True
							If \Gadget > -1
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
						EndIf
					Else
						If \Vertical
							Mouse = *Event\MouseY - \OriginY
						Else
							Mouse = *Event\MouseX - \OriginX
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
							Mouse = *Event\MouseY - \OriginY
							Lenght = \Height
						Else
							Mouse = *Event\MouseX - \OriginX
							Lenght = \Width
						EndIf
						
						If \MouseState
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
							
							If \Gadget > -1
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
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
						If \Gadget > -1
							PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						EndIf
						Redraw = #True
					EndIf
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
		
		ProcedureReturn Redraw
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
	
	Procedure ScrollBar_SetAttribute_Meta(*GadgetData.ScrollBarData, Attribute, Value)
		Protected Lenght
		
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
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
						
						\State = Clamp(\State, \Min, Max(\Max - \PageLenght, \Min))
						If \Vertical
							Lenght = \Height
						Else
							Lenght = \Width
						EndIf
						\Position = Round(\State / (\Max - \Min) * Lenght, #PB_Round_Nearest)
						
						RedrawObject()
					EndIf
					;}
				Case #ScrollBar_Maximum ;{
					If Value > \Min
						\Max = Value
						
						If \PageLenght >= (\Max - \Min)
							\BarSize = -1
						EndIf
						
						If \Vertical
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
						
						\State = Clamp(\State, \Min, Max(\Max - \PageLenght, \Min))
						If \Vertical
							Lenght = \Height
						Else
							Lenght = \Width
						EndIf
						\Position = Round(\State / (\Max - \Min) * Lenght, #PB_Round_Nearest)
						
						RedrawObject()
					EndIf
					;}
				Case #ScrollBar_PageLength ;{
					\PageLenght = Value
					If \PageLenght >= (\Max - \Min)
						\BarSize = -1
					Else
						If \Vertical
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLenght / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
					EndIf
					
					\State = Clamp(\State, \Min, Max(\Max - \PageLenght, \Min))
					If \Vertical
						Lenght = \Height
					Else
						Lenght = \Width
					EndIf
					\Position = Round(\State / (\Max - \Min) * Lenght, #PB_Round_Nearest)
					
					RedrawObject()
					;}
				Default	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
			EndSelect
		EndWith
	EndProcedure
	
	Procedure ScrollBar_SetAttribute(*This.PB_Gadget, Attribute, Value)
		ScrollBar_SetAttribute_Meta(*this\vt, Attribute, Value)
	EndProcedure
	
	Procedure ScrollBar_SetState_Meta(*GadgetData.ScrollBarData, State)
		Protected Lenght
		
		With *GadgetData
			State = Clamp(State, \Min, \Max - \PageLenght)
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
	
	Procedure Scrollbar_SetState(*this.PB_Gadget, State)
		ScrollBar_SetState_Meta(*this\vt, State)
	EndProcedure
	
	Procedure Scrollbar_ResizeMeta(*GadgetData.ScrollBarData, X, Y, Width, Height)
		With *GadgetData
			\Width = Width
			\Height = Height
			\OriginX = X
			\OriginY = Y
			
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
	
	Procedure Scrollbar_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.ScrollBarData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		Scrollbar_ResizeMeta(*GadgetData, 0, 0, GadgetWidth(*GadgetData\Gadget), GadgetHeight(*GadgetData\Gadget))
	EndProcedure
	
	Procedure Scrollbar_Meta(*GadgetData.ScrollBarData, *ThemeData, Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(ScrollBar)
		
		With *GadgetData
			\Max = Max
			\Min = Min
			\PageLenght = PageLenght
			
			If Flags & #Gadget_Vertical
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
		
		ProcedureReturn *GadgetData
	EndProcedure
	
	Procedure ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags = #Default)
		Protected Result, *GadgetData.ScrollBarData, *this.PB_Gadget, *ThemeData
		
		If AccessibilityMode
			Result = ScrollBarGadget(Gadget, x, y, Width, Height, Min, Max, PageLenght, Bool(Flags & #Gadget_Vertical) * #PB_ScrollBar_Vertical)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, ScrollBarData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				*GadgetData\Background = #True
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Scrollbar_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Min, Max, PageLenght, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Label Gadget
	Structure LabelData Extends GadgetData
	EndStructure
	
	Procedure Label_Redraw(*GadgetData.LabelData)
		With *GadgetData
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			VectorSourceColor(\ThemeData\TextColor[#Cold])
			DrawVectorTextBlock(@\TextBock, \OriginX, \OriginY)
		EndWith
	EndProcedure
	
	Procedure Label_EventHandler(*GadgetData.LabelData, *Event.Event)
	EndProcedure
	
	Procedure Label_Meta(*GadgetData.LabelData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Label)
		
		With *GadgetData
			\TextBock\Width = Width
			\TextBock\Height = Height
			\TextBock\OriginalText = Text
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
			
			UnbindGadgetEvent(*GadgetData\Gadget, *GadgetData\DefaultEventHandler)
			*GadgetData\DefaultEventHandler = 0
		EndWith
	EndProcedure
	
	Procedure Label(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.LabelData, *ThemeData
		
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
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, LabelData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Label_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
				
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
					
				Default	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
			EndSelect
		EndWith
	EndProcedure
	
	Procedure ScrollArea_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		With *GadgetData
			Select ColorType
				Case #Color_Back_Cold
					*GadgetData\ThemeData\BackColor[#Cold] = Color
				Case #Color_Back_Warm
					*GadgetData\ThemeData\BackColor[#Warm] = Color
				Case #Color_Back_Hot
					*GadgetData\ThemeData\BackColor[#Hot] = Color
				Case #Color_Text_Cold
					*GadgetData\ThemeData\TextColor[#Cold] = Color
				Case #Color_Text_Warm
					*GadgetData\ThemeData\TextColor[#Warm] = Color
				Case #Color_Text_Hot
					*GadgetData\ThemeData\TextColor[#Hot] = Color
				Case #Color_Line_Cold
					*GadgetData\ThemeData\LineColor = Color
				Case #Color_Parent
					*GadgetData\ThemeData\WindowColor = Color
					SetGadgetColor(*GadgetData\ScrollArea, #PB_Gadget_BackColor, RGB(Red(*GadgetData\ThemeData\WindowColor), Green(*GadgetData\ThemeData\WindowColor), Blue(*GadgetData\ThemeData\WindowColor)))
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
			
			AllocateStructureX(*GadgetData, ScrollAreaData)
			
			With *GadgetData
				\Gadget = Gadget
				*this = IsGadget(Gadget)
				CopyMemory(*this\vt, \vt, SizeOf(GadgetVT))
				\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*GadgetData\ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *GadgetData\ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *GadgetData\ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *GadgetData\ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *GadgetData\ThemeData, Theme)
					EndIf
				EndIf
				
				*GadgetData\ScrollArea = ScrollAreaGadget(#PB_Any, 0, 0, Width - #ScrollArea_Bar_Thickness + ScrollbarThickness, Height - #ScrollArea_Bar_Thickness + ScrollbarThickness, ScrollAreaWidth, ScrollAreaHeight, ScrollStep, #PB_ScrollArea_BorderLess)
				SetProp_(GadgetID(\ScrollArea), "UITK_ScrollAreaData", *GadgetData)
				BindGadgetEvent(\ScrollArea, @ScrollArea_Handler())
				
				SetGadgetColor(\ScrollArea, #PB_Gadget_BackColor, RGB(Red(*GadgetData\ThemeData\WindowColor), Green(*GadgetData\ThemeData\WindowColor), Blue(*GadgetData\ThemeData\WindowColor)))
				SetGadgetColor(\Gadget, #PB_Gadget_BackColor, RGB(Red(*GadgetData\ThemeData\WindowColor), Green(*GadgetData\ThemeData\WindowColor), Blue(*GadgetData\ThemeData\WindowColor)))
				
				CloseGadgetList()
				CloseGadgetList()
				
				\Width = Width
				\Height = Height
				\VerticalScrollbar = ScrollBar(#PB_Any, x + \Width - #ScrollArea_Bar_Thickness, y, #ScrollArea_Bar_Thickness, \Height - #ScrollArea_Bar_Thickness, 0, ScrollAreaHeight + #ScrollArea_Bar_Thickness, \Height, #Gadget_Vertical)
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
	
	;{ VerticalList
	#VerticalList_Margin = 3
	#VerticalList_IconWidth = 30
	#VerticalList_ItemHeight = 40
	#VerticalList_ToolbarThickness = 7
	
	Structure VerticalListData Extends GadgetData
		ItemHeight.l
		MaxDisplayedItem.i
		VisibleScrollbar.b
		SortItem.i
		ItemState.i
		
		Drag.i
		DragState.i
		DragOriginX.i
		DragOriginY.i
		
		Reorder.i
		ReorderPosition.i
		ReorderTimer.i
		ReorderDirection.b
		ReorderWindow.i	; We should share with the drag window? Might add some issues since it's subclassed?
		ReorderCanvas.i
		
		*ItemRedraw.ItemRedraw
		*ScrollBar.ScrollBarData
		
		List Items.VerticalListItem()
	EndStructure
	
	Declare VerticalList_EventHandler(*GadgetData.VerticalListData, *Event.Event)
	
	Procedure VerticalList_DragCanvasHandler()
		Protected Gadget = EventGadget(), *GadgetData.VerticalListData = GetProp_(GadgetID(Gadget), "UITK_VerticalData"), Event.Event
		
		Event\EventType = #MouseWheel
		Event\MouseX =  WindowX(*GadgetData\ReorderWindow) - *GadgetData\DragOriginX
		Event\MouseY =  WindowY(*GadgetData\ReorderWindow) - *GadgetData\DragOriginY
		Event\Param = GetGadgetAttribute(*GadgetData\ReorderCanvas, #PB_Canvas_WheelDelta)
		
		VerticalList_EventHandler(*GadgetData, @Event)
	EndProcedure
	
	Procedure VerticalList_ItemRedraw(*Item.VerticalListItem, X, Y, Width, Height, State, *Theme.Theme)
		If State > #Cold
			AddPathBox(X, Y, Width, Height)
			VectorSourceColor(*Theme\ShadeColor[State])
			FillPath()
			
			VectorSourceColor(*Theme\TextColor[State])
		EndIf
		
		DrawVectorTextBlock(@*Item\Text, X, Y)
		
		If State = #Hot
			MovePathCursor(X + *Item\Text\Width - #VerticalList_IconWidth, Y + (*Item\Text\Height - 14) * 0.5)
			VectorFont(IconFont, 16)
			DrawVectorText("")
			
			If *Item\Text\FontScale
				VectorFont(*Item\Text\FontID, *Item\Text\FontScale)
			Else
				VectorFont(*Item\Text\FontID)
			EndIf
		EndIf
	EndProcedure
	
	Procedure VerticalList_Redraw(*GadgetData.VerticalListData)
		Protected Y = *GadgetData\OriginY, Width = *GadgetData\Width - 2 * *GadgetData\Border, Position, ItemCount, State, CurrentItem, Drawn
		
		With *GadgetData
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			If *GadgetData\Border
				VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			EndIf
			
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			If ListSize(\Items())
				If \VisibleScrollbar
					Position = Floor(\ScrollBar\State / \ItemHeight)
					Y - (\ScrollBar\State % \ItemHeight)
				EndIf
				
				SelectElement(\Items(), Position)
				
				If (\ReorderPosition > - 1) And Position > \ItemState
					NextElement(\Items())
				EndIf
				
				If \TextBock\FontScale
					VectorFont(\TextBock\FontID, \TextBock\FontScale)
				Else
					VectorFont(\TextBock\FontID)
				EndIf
				
				Repeat
					CurrentItem = ListIndex(\Items())
					
					If CurrentItem = \ReorderPosition
						AddPathBox(\Border, Y - 1, 80, 3)
						VectorSourceColor(\ThemeData\TextColor[#Cold])
						FillPath()
						Drawn = #True
					EndIf
					
					If CurrentItem = \State
						If \DragState = #Drag_Active
							Continue
						EndIf
						State = #Hot
					ElseIf CurrentItem = \ItemState
						State = #Warm
					Else
						State = #Cold
					EndIf
					
					VectorSourceColor(\ThemeData\TextColor[State])
					
					\ItemRedraw(@\Items(), \Border + #VerticalList_Margin, Y, Width, \ItemHeight, State, \ThemeData)
					Y + \ItemHeight
					ItemCount + 1
				Until ItemCount > \MaxDisplayedItem Or (Not NextElement(\Items()))
				
				If CurrentItem + 1 = \ReorderPosition Or (\ReorderPosition = \State + 1 And Drawn = #False)
					AddPathBox(\Border, Y - 2, 80, 3)
					VectorSourceColor(\ThemeData\TextColor[#Cold])
					FillPath()
				EndIf
				
				If \VisibleScrollbar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure VerticalList_StateFocus(*GadgetData.VerticalListData)
		Protected Result
		
		With *GadgetData
			If \VisibleScrollbar
				If Ceil(\ScrollBar\State / \ItemHeight) > \State
					ScrollBar_SetState_Meta(\ScrollBar, \State * \ItemHeight)
					Result = #True
				ElseIf Floor((\ScrollBar\State + \Height - \ItemHeight) / \ItemHeight) < \State
					ScrollBar_SetState_Meta(\ScrollBar, \State * \ItemHeight - \Height + \ItemHeight)
					Result = #True
				EndIf
			EndIf
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure VerticalList_FocusTimer(*GadgetData.VerticalListData, Timer)
		RemoveGadgetTimer(Timer)
		
		If VerticalList_StateFocus(*GadgetData.VerticalListData)
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure VerticalList_ReorderTimer(*GadgetData.VerticalListData, Timer)
		Protected Event.Event
		
		With *GadgetData
			If \ReorderDirection = -1
				If \ScrollBar\State > 0
					Event\EventType = #MouseMove
					Event\MouseX = WindowX(\ReorderWindow) - \DragOriginX
					Event\MouseY = WindowY(\ReorderWindow) - \DragOriginY
					ScrollBar_SetState_Meta(\ScrollBar, Max(0, Floor(\ScrollBar\State / \ItemHeight) - 1) * \ItemHeight)
					VerticalList_EventHandler(*GadgetData, @Event)
				EndIf
			Else
				If \ScrollBar\State < \ScrollBar\Max - \ScrollBar\PageLenght
					Event\EventType = #MouseMove
					Event\MouseX = WindowX(\ReorderWindow) - \DragOriginX
					Event\MouseY = WindowY(\ReorderWindow) - \DragOriginY
					ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State + \ItemHeight)
					VerticalList_EventHandler(*GadgetData, @Event)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure VerticalList_EventHandler(*GadgetData.VerticalListData, *Event.Event)
		Protected Redraw, Item, *Element, Image
		With *GadgetData
			
			Select *Event\EventType
				Case #MouseMove ;{
					If \DragState = #Drag_Init ;{
						If Abs(\DragOriginX - *Event\MouseX) > 7 Or Abs(\DragOriginY - *Event\MouseY) > 7
							If \Drag 
								Image = CreateImage(#PB_Any, \Width, \ItemHeight, 32, \ThemeData\ShadeColor[#Hot])
								SelectElement(\Items(),\State)
								
								StartVectorDrawing(ImageVectorOutput(Image))
								VectorFont(\TextBock\FontID)
								VectorSourceColor(\ThemeData\TextColor[#Hot])
								\ItemRedraw(@\Items(), \Border + #VerticalList_Margin, 0, \Width, \ItemHeight, #Hot, \ThemeData)
								StopVectorDrawing()
								
								AdvancedDragPrivate(#Drag_VListItem, ImageID(Image))
								\DragState = #Drag_None
								FreeImage(Image)
								\DragState = #Drag_None
							Else
								\DragState = #Drag_Active
								\DragOriginX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginX
								\DragOriginY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginY + \ItemState * \ItemHeight - \ScrollBar\State
								\ReorderPosition = Clamp(Floor((*Event\MouseY + \ScrollBar\State + \ItemHeight * 0.5) / \ItemHeight), 0, ListSize(\Items()) - 1)
								
								If (ListSize(\Items()) - 1) * \ItemHeight > \Height 
									\VisibleScrollbar = #True
									ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \ScrollBar\Max - \ItemHeight)
								Else
									\VisibleScrollbar = #False
								EndIf
								
								StartVectorDrawing(CanvasVectorOutput(\ReorderCanvas))
								VectorSourceColor(\ThemeData\ShadeColor[#Hot])
								AddPathBox(0, 0, \Width, \ItemHeight)
								
								If \TextBock\FontScale
									VectorFont(\TextBock\FontID, \TextBock\FontScale)
								Else
									VectorFont(\TextBock\FontID)
								EndIf
								FillPath()
								
								SelectElement(\Items(), \State)
								VectorSourceColor(\ThemeData\TextColor[#Hot])
								\ItemRedraw(@\Items(), \Border + #VerticalList_Margin, 0, \Width, \ItemHeight, #Hot, \ThemeData)
								
								StopVectorDrawing()
								
								ResizeWindow(\ReorderWindow, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, #PB_Ignore, #PB_Ignore)
								HideWindow(\ReorderWindow, #False, #PB_Window_NoActivate)
								SetActiveGadget(\Gadget)
								Redraw = #True
							EndIf
						EndIf
						;}
					ElseIf \DragState = #Drag_Active ;{
						SetWindowPos_(WindowID(\ReorderWindow), 0, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, 0, 0, #SWP_NOSIZE | #SWP_NOZORDER | #SWP_NOREDRAW)
						
						If \VisibleScrollbar
							If (*Event\MouseY < 0)
								If Not \ReorderTimer
									\ReorderTimer = AddGadgetTimer(*GadgetData, 400, @VerticalList_ReorderTimer())
									\ReorderDirection = - 1
									ScrollBar_SetState_Meta(\ScrollBar, Max(0, Floor(\ScrollBar\State / \ItemHeight)) * \ItemHeight)
									Redraw = #True
								EndIf
								*Event\MouseY = 0
							ElseIf (*Event\MouseY > \Height)
								If Not \ReorderTimer
									\ReorderTimer = AddGadgetTimer(*GadgetData, 400, @VerticalList_ReorderTimer())
									\ReorderDirection = 1
									ScrollBar_SetState_Meta(\ScrollBar, Max(0, Floor(\ScrollBar\State / \ItemHeight)) * \ItemHeight + (\ItemHeight - \ScrollBar\PageLenght % \ItemHeight))
									Redraw = #True
								EndIf
								*Event\MouseY = \Height
							Else
								If \ReorderTimer
									RemoveGadgetTimer(\ReorderTimer)
									\ReorderTimer = 0
								EndIf
							EndIf
						EndIf
						
						Item = Clamp(Floor((*Event\MouseY + \ScrollBar\State + \ItemHeight * 0.5) / \ItemHeight), 0, ListSize(\Items()) - 1)
						Item + Bool(Item >= \State)
						
						If \ReorderPosition <> Item
							\ReorderPosition = Item
							Redraw = #True
						EndIf
						;}
					Else;{
						If \VisibleScrollbar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
							Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
							
						ElseIf \ScrollBar\MouseState
							\ScrollBar\MouseState = #False
							Redraw = #True
						EndIf
						
						If Not \ScrollBar\MouseState
							Item = Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight)
							
							If item >= ListSize(\Items())
								Item = -1
							EndIf
							
							If Item <> \ItemState
								\ItemState = Item
								Redraw = #True
							EndIf
						Else
							\ItemState = -1
						EndIf
					EndIf ;}
						  ;}
				Case #LeftButtonDown ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					Else
						If \ItemState > -1 
							If \ItemState <> \State
								\State = \ItemState
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
								AddGadgetTimer(*GadgetData, 200, @VerticalList_FocusTimer())
								Redraw = #True
							EndIf
							If \Reorder
								\DragState = #Drag_Init
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							ElseIf \Drag
								\DragState = #Drag_Init
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					
					If \DragState = #Drag_Active
						If \ReorderPosition = ListSize(\Items())
							Item = SelectElement(\Items(), \State)
							MoveElement(\Items(), #PB_List_Last)
						Else
							*Element = SelectElement(\Items(), \ReorderPosition)
							Item = SelectElement(\Items(), \State)
							MoveElement(\Items(), #PB_List_Before, *Element)
						EndIf
						ChangeCurrentElement(\Items(), Item)
						\State = ListIndex(\Items())
						HideWindow(\ReorderWindow, #True)
						
						If \ReorderTimer
							RemoveGadgetTimer(\ReorderTimer)
							\ReorderTimer = 0
						EndIf
						
						VerticalList_StateFocus(*GadgetData)
						
						If ListSize(\Items()) * \ItemHeight > \Height
							\VisibleScrollbar = #True
							ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
						Else
							\VisibleScrollbar = #False
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						
						Redraw = #True
						\ReorderPosition = -1
					EndIf
					
					\DragState = #Drag_None
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					
					If \ItemState > -1
						\ItemState = -1
						Redraw = #True
					EndIf
					;}
				Case #MouseWheel ;{
					If \VisibleScrollbar
						ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 0.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not VerticalList_EventHandler(*GadgetData, *Event))
					EndIf
					;}
				Case #KeyDown ;{
					If \DragState = #Drag_None
						Select *Event\Param
							Case #PB_Shortcut_Down
								If \State < ListSize(\Items()) - 1
									\State + 1
									VerticalList_StateFocus(*GadgetData)
									Redraw = #True
								EndIf
							Case #PB_Shortcut_Up
								If \State > 0
									\State - 1
									VerticalList_StateFocus(*GadgetData)
									Redraw = #True
								EndIf
						EndSelect
					EndIf
					;}
				Case #LeftDoubleClick ;{
					If \ItemState > -1
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #Eventtype_ForcefulChange)
					EndIf
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure VerticalList_AddItem(*this.PB_Gadget, Position, *Text, ImageID)
		Protected *GadgetData.VerticalListData = *this\vt, *NewItem
		
		With *GadgetData
			
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			\Items()\Text\OriginalText = PeekS(*Text)
			\Items()\Text\Image = ImageID
			\Items()\Text\LineLimit = 1
			\Items()\Text\FontID = \TextBock\FontID
			
			\Items()\Text\Width = \TextBock\Width - #VerticalList_Margin * 2
			\Items()\Text\Height = \ItemHeight
			\Items()\Text\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@\Items()\Text)
			
			If ListSize(\Items()) * \ItemHeight > \Height
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			If \SortItem
				SortStructuredList(\Items(), #PB_Sort_Ascending, OffsetOf(VerticalListItem\Text), #PB_String)
			EndIf
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			
			If Position <= \State
				\State + 1
			EndIf
			
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure VerticalList_RemoveItem(*this.PB_Gadget, Position)
		Protected *GadgetData.VerticalListData = *this\vt, *Result
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				DeleteElement(\Items())
				
				If ListSize(\Items()) * \ItemHeight > \Height
					\VisibleScrollbar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
				Else
					\VisibleScrollbar = #False
				EndIf
				
				If \State > Position
					\State - 1
				ElseIf \State = Position
					If \State = ListSize(\Items())
						\State - 1
					EndIf
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
				EndIf
				
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure VerticalList_Resize(*this.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.VerticalListData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			ForEach \Items()
				\Items()\Text\Width = \Width - #VerticalList_Margin * 2
				PrepareVectorTextBlock(@\Items()\Text)
			Next
			
			\MaxDisplayedItem = Ceil((\Height - 2 * \Border) / \ItemHeight)
			
			
			Scrollbar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			If ListSize(\Items()) * \ItemHeight > \Height
				\VisibleScrollbar = #True
			Else
				\VisibleScrollbar = #False
			EndIf
			
			If \Reorder
				SetWindowPos_(WindowID(\ReorderWindow), 0, 0, 0, \Width, \ItemHeight, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
				ResizeGadget(\ReorderCanvas, 0, 0, \Width, \ItemHeight)
			EndIf
			
		EndWith
		
		RedrawObject()
	EndProcedure
	
	Procedure VerticalList_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.VerticalListData = *this\vt
		
		FreeStructure(*GadgetData\ScrollBar)
		
		Default_FreeGadget(*this.PB_Gadget)
	EndProcedure
	
	; Getters
	Procedure VerticalList_CountItem(*this.PB_Gadget)
		Protected *GadgetData.VerticalListData = *this\vt
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	Procedure VerticalList_GetItemData(*this.PB_Gadget, Position)
		Protected *GadgetData.VerticalListData = *this\vt, *Result
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			SelectElement(*GadgetData\Items(), Position)
			*Result = *GadgetData\Items()\Data
		EndIf
		
		ProcedureReturn *Result
	EndProcedure
	
	Procedure.s VerticalList_GetItemText(*this.PB_Gadget, Position)
		Protected *GadgetData.VerticalListData = *this\vt, Result.s
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			SelectElement(*GadgetData\Items(), Position)
			Result = *GadgetData\Items()\Text\OriginalText
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure VerticalList_GetItemImage(*this.PB_Gadget, Position)
		Protected *GadgetData.VerticalListData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				ProcedureReturn \Items()\Text\Image
			EndIf
		EndWith
	EndProcedure
	
	
	; Setters
	Procedure VerticalList_SetAttribute(*this.PB_Gadget, Attribute, Value)
		Protected *GadgetData.VerticalListData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #Attribute_ItemHeight ;{
					\ItemHeight = Value
					\MaxDisplayedItem = Ceil((\Height - 2 * \Border) / \ItemHeight)
					
					If ListSize(\Items()) * \ItemHeight > \Height
						\VisibleScrollbar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
					Else
						\VisibleScrollbar = #False
					EndIf
					
					ForEach \Items()
						\Items()\Text\Height = \ItemHeight
						PrepareVectorTextBlock(@\Items()\Text)
					Next
					
					If \Reorder
						SetWindowPos_(WindowID(\ReorderWindow), 0, 0, 0, \Width, \ItemHeight, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
						ResizeGadget(\ReorderCanvas, 0, 0, \Width, \ItemHeight)
					EndIf
					
					;}
				Case #Attribute_SortItems ;{
					\SortItem = Value
					;}
				Default ;{	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					;}
			EndSelect
		EndWith
		RedrawObject()
	EndProcedure
	
	Procedure VerticalList_SetItemData(*this.PB_Gadget, Position, *Data)
		Protected *GadgetData.VerticalListData = *this\vt
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			SelectElement(*GadgetData\Items(), Position)
			*GadgetData\Items()\Data = *Data
			
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure VerticalList_SetItemText(*this.PB_Gadget, Position, *Text)
		
		
	EndProcedure
	
	
	Procedure VerticalList_Meta(*GadgetData.VerticalListData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
		Protected GadgetList
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(VerticalList)
		
		With *GadgetData
			\TextBock\Width = Width - #VerticalList_Margin
			
			If *CustomItem
				\ItemRedraw = *CustomItem 
			Else
				\ItemRedraw = @VerticalList_ItemRedraw() 
			EndIf
			
			\ItemHeight = #VerticalList_ItemHeight
			\State = -1
			\ItemState = -1
			\MaxDisplayedItem = Ceil((\Height - 2 * \Border) / \ItemHeight)
			AllocateStructureX(*GadgetData\ScrollBar, ScrollBarData)
			\ReorderPosition = -1
			
			If Flags & #ReOrder
				GadgetList = UseGadgetList(0)
				\Reorder = #True
				\ReorderWindow = OpenWindow(#PB_Any, 0, 0, Width, \ItemHeight, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(CurrentWindow()))
				\ReorderCanvas = CanvasGadget(#PB_Any, 0, 0, Width, \ItemHeight)
				SetProp_(GadgetID(\ReorderCanvas), "UITK_VerticalData", *GadgetData)
				BindGadgetEvent(\ReorderCanvas, @VerticalList_DragCanvasHandler(), #PB_EventType_MouseWheel)
				SetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED)
				SetLayeredWindowAttributes_(WindowID(\ReorderWindow), 0, 128, #LWA_ALPHA)
				UseGadgetList(GadgetList)
			Else
				\Drag = Flags & #Drag
			EndIf
			
			Scrollbar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \ItemHeight, Height , #Gadget_Vertical)
			
			\VT\SetGadgetAttribute = @VerticalList_SetAttribute()
			\VT\CountGadgetItems = @VerticalList_CountItem()
			\VT\SetGadgetItemData = @VerticalList_SetItemData()
			\VT\GetGadgetItemData = @VerticalList_GetItemData()
			\VT\RemoveGadgetItem = @VerticalList_RemoveItem()
			\VT\AddGadgetItem2 = @VerticalList_AddItem()
			\VT\ResizeGadget = @VerticalList_Resize()
			\VT\GetGadgetItemText = @VerticalList_GetItemText()
			\VT\FreeGadget = @VerticalList_FreeGadget()
			\VT\GetGadgetItemImage = @VerticalList_GetItemImage()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			\SupportedEvent[#KeyDown] = #True
		EndWith
		
	EndProcedure
	
	Procedure VerticalList(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
		Protected Result, *this.PB_Gadget, *GadgetData.VerticalListData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, VerticalListData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				VerticalList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
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
		DisplayState.b
		Unit.s
		Scale.d
		List Items.TrackBarIndent()
	EndStructure
	
	Procedure TrackBar_Redraw(*GadgetData.TrackBarData)
		Protected Progress, X, Y, Ratio.d, TextHeight, Height, Width, Text.s, TextWidth
		
		With *GadgetData
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			
			VectorSourceColor(\ThemeData\LineColor[#Cold])
			TextHeight = VectorTextHeight("a")
			
			If \Vertical
				Height = \Height - 2 * #Trackbar_Margin
				Ratio = (Height - #TracKbar_CursorWidth) / (\Maximum - \Minimum)
				Progress = Round((\State - \Minimum) * Ratio, #PB_Round_Nearest)
				
				If \TextBock\HAlign = #HAlignRight
					X = \OriginX + \Width - #TracKbar_CursorHeight - #Trackbar_Margin
					
					ForEach \Items()
						Y = Round((\Items()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						MovePathCursor(X + 2, Y + 1)
						AddPathLine(#Trackbar_IndentWidth, 0, #PB_Path_Relative)
						MovePathCursor(0, Y - Floor(TextHeight * 0.5 ))
						DrawVectorParagraph(\Items()\Text, \Width - X, TextHeight, #PB_VectorParagraph_Right)
					Next
					
					If \DisplayState
						MovePathCursor(0, \OriginY  + #Trackbar_Thickness + Progress - Floor(TextHeight * 0.5 ))
						If \Scale = 1
							DrawVectorParagraph(Str(\State) + \Unit, \Width - X, TextHeight, #PB_VectorParagraph_Right)
						Else
							DrawVectorParagraph(StrD(\State * \Scale, 1) + \Unit, \Width - X, TextHeight, #PB_VectorParagraph_Right)
						EndIf
					EndIf
				Else
					X = \OriginX + #Trackbar_Margin
					
					ForEach \Items()
						Y = Round((\Items()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						MovePathCursor(X + 2, Y + 1)
						AddPathLine(#Trackbar_IndentWidth, 0, #PB_Path_Relative)
						MovePathCursor(X + #TracKbar_CursorHeight + #Trackbar_Margin, Y - Floor(TextHeight * 0.5 ))
						DrawVectorParagraph(\Items()\Text, \Width, TextHeight, #PB_VectorParagraph_Left)
					Next
					
					If \DisplayState
						MovePathCursor(X + #TracKbar_CursorHeight + #Trackbar_Margin, \OriginY  + #Trackbar_Thickness + Progress - Floor(TextHeight * 0.5 ))
						If \Scale = 1
							DrawVectorParagraph(Str(\State) + \Unit, \Width, TextHeight, #PB_VectorParagraph_Left)
						Else
							DrawVectorParagraph(StrD(\State * \Scale, 1) + \Unit, \Width, TextHeight, #PB_VectorParagraph_Left)
						EndIf
					EndIf
				EndIf
				
					X + #TracKbar_CursorHeight * 0.5
				Y = \OriginY + #Trackbar_Margin
				
				VectorSourceColor(\ThemeData\ShadeColor[#Warm])
				StrokePath(2)
				AddPathBox(X - #Trackbar_Thickness * 0.5, Y + #Trackbar_Thickness * 0.5 + Progress, #Trackbar_Thickness, Height - #Trackbar_Thickness - Progress)
				AddPathCircle(X, Y + Height - #Trackbar_Thickness * 0.5, #Trackbar_Thickness * 0.5)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\ThemeData\Special3[#Cold])
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
					
					ForEach \Items()
						X = Round((\Items()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						
						MovePathCursor(X + 1, Y + 2)
						AddPathLine(0, #Trackbar_IndentWidth, #PB_Path_Relative)
						MovePathCursor(X - 24, Y + #Trackbar_Margin + #TracKbar_CursorHeight)
						DrawVectorParagraph(\Items()\Text, 50, TextHeight, #PB_VectorParagraph_Center)
					Next
					
					If \DisplayState
						If \Scale = 1
							Text = Str(\State) + \Unit
						Else
							Text = StrD(\State * \Scale, 1) + \Unit
						EndIf
						
						TextWidth = VectorTextWidth(Text)
						MovePathCursor(\OriginX + Min(Max(#Trackbar_Thickness + Progress - TextWidth * 0.4, 0), \Width - TextWidth), Y + #Trackbar_Margin + #TracKbar_CursorHeight)
						DrawVectorParagraph(Text, 50, TextHeight, #PB_VectorParagraph_Left)
					EndIf
					
					Y + #TracKbar_CursorHeight * 0.5
				Else
					Y = \OriginY + \Height - #TracKbar_CursorHeight - #Trackbar_Margin
					
					ForEach \Items()
						X = Round((\Items()\Position - \Minimum) * Ratio + #Trackbar_Thickness * 0.5 + #Trackbar_Margin, #PB_Round_Nearest)
						
						MovePathCursor(X + 1, Y + 2)
						AddPathLine(0, #Trackbar_IndentWidth, #PB_Path_Relative)
						MovePathCursor(X - 24, Y - TextHeight - #Trackbar_Margin)
						DrawVectorParagraph(\Items()\Text, 50, TextHeight, #PB_VectorParagraph_Center)
					Next
					
					If \DisplayState
						If \Scale = 1
							Text = Str(\State) + \Unit
						Else
							Text = StrD(\State * \Scale, 1) + \Unit
						EndIf
						
						TextWidth = VectorTextWidth(Text)
						MovePathCursor(\OriginX + Min(Max(#Trackbar_Thickness + Progress - TextWidth * 0.4, 0), \Width - TextWidth), Y + #Trackbar_Margin + #TracKbar_CursorHeight)
						DrawVectorParagraph(Text, 50, TextHeight, #PB_VectorParagraph_Left)
					EndIf
					
					Y + #TracKbar_CursorHeight * 0.5
				EndIf
				
				X = \OriginX + #Trackbar_Margin
				
				VectorSourceColor(\ThemeData\ShadeColor[#Warm])
				StrokePath(2)
				AddPathBox(X + #Trackbar_Thickness * 0.5 + Progress, Y - #Trackbar_Thickness * 0.5, Width - #Trackbar_Thickness - Progress, #Trackbar_Thickness)
				AddPathCircle(X + Width - #Trackbar_Thickness * 0.5, Y, #Trackbar_Thickness * 0.5)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\ThemeData\Special3[#Cold])
				AddPathCircle(X + #Trackbar_Thickness * 0.5, Y, #Trackbar_Thickness * 0.5)
				AddPathBox(X + #Trackbar_Thickness * 0.5, Y - #Trackbar_Thickness * 0.5, Progress, #Trackbar_Thickness)
				FillPath(#PB_Path_Winding)
				
				AddPathRoundedBox(X + Progress, Y - #TracKbar_CursorHeight * 0.5, #TracKbar_CursorWidth, #TracKbar_CursorHeight, 3)
			EndIf
			
			VectorSourceColor(\ThemeData\TextColor[#Cold])
			StrokePath(1, #PB_Path_Preserve)
			VectorSourceColor(\ThemeData\Highlight)
			FillPath(#PB_Path_Winding)
		EndWith
		
	EndProcedure
	
	Procedure TrackBar_EventHandler(*GadgetData.TrackBarData, *Event.Event)
		Protected Redraw, CursorX, CursorY, NewState
		
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
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure Trackbar_AddGadgetItem(*this.PB_Gadget, Position, *Text, ImageID)
		Protected *GadgetData.TrackBarData = *this\vt, ListSize
		
		With *GadgetData
			ListSize = ListSize(\Items())
			
			If ListSize
				ListSize - 1
				ForEach \Items()
					If \Items()\Position = Position
						Break
					ElseIf \Items()\Position > Position
						InsertElement(\Items())
						Break
					ElseIf ListIndex(\Items()) = ListSize
						AddElement(\Items())
					EndIf
				Next
			Else
				AddElement(\Items())
			EndIf
			
			\Items()\Text = PeekS(*Text)
			\Items()\Position = Position
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure Trackbar_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.TrackBarData = *this\vt
		*GadgetData\unit = Text
		RedrawObject()
	EndProcedure
	
	Procedure Trackbar_SetAttribute(*this.PB_Gadget, Attribute, Value)
		Protected *GadgetData.TrackBarData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #Trackbar_Scale ;{
					\Scale = 1 / Value
					;}
				Default ;{	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					;}
			EndSelect
		EndWith
		RedrawObject()
	EndProcedure
	
	Procedure TrackBar_Meta(*GadgetData.TrackBarData, *ThemeData, Gadget, x, y, Width, Height, Minimum, Maximum, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(TrackBar)
		
		With *GadgetData
			
			\Vertical = Bool(Flags & #Gadget_Vertical)
			\Maximum = Maximum
			\Minimum = Minimum
			\DisplayState = Bool(Flags & #Trackbar_ShowState)
			\Scale = 1
			
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
			\VT\SetGadgetText = @Trackbar_SetText()
			\vt\SetGadgetAttribute = @Trackbar_SetAttribute()
			
			\SupportedEvent[#LeftClick] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#KeyDown] = #True
			\SupportedEvent[#KeyUp] = #True
		EndWith
	EndProcedure
	
	Procedure TrackBar(Gadget, x, y, Width, Height, Minimum, Maximum, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.TrackBarData, *ThemeData
		
		If AccessibilityMode
			Result = TrackBarGadget(Gadget, x, y, Width, Height, Minimum, Maximum, Bool(Flags & #Gadget_Vertical) * #PB_TrackBar_Vertical)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, TrackBarData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				TrackBar_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Minimum, Maximum, Flags)
				
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
		ItemCount.i
		List ItemList.Text()
		*Scrollbar.ScrollBarData
	EndStructure
	
	Procedure Combo_Redraw(*GadgetData.ComboData)
		With *GadgetData
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(\ThemeData\LineColor[Bool(\MouseState Or \Unfolded)])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\BackColor[Bool(\MouseState Or \Unfolded)])
			FillPath()
			
			VectorSourceColor(\ThemeData\TextColor[\MouseState])
			
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			
			DrawVectorTextBlock(@\TextBock, \OriginX + #Combo_ItemMargin, \OriginY + \VMargin)
			VectorFont(IconFont)
			VectorSourceColor(\ThemeData\TextColor[#Cold])
			MovePathCursor(\Width - #Combo_IconWidth, (\Height - #Combo_IconHeight) * 0.6)
			
			If \Unfolded
				DrawVectorText("")
			Else
				DrawVectorText("")
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Combo_EventHandler(*GadgetData.ComboData, *Event.Event)
		Protected Redraw
		
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
					
				Case #KeyDown
					
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure Combo_TimerHandler(*GadgetData.ComboData, Timer)
		RemoveGadgetTimer(Timer)
		If *GadgetData\Unfolded
			*GadgetData\Unfolded = #False
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure Combo_WindowHandler()
		Protected Window = EventWindow(), *GadgetData.ComboData = GetProp_(WindowID(Window), "UITK_ComboData")
		
		AddGadgetTimer(*GadgetData, 20, @Combo_TimerHandler())
		HideWindow(*GadgetData\MenuWindow , #True)
	EndProcedure
	
	Procedure Combo_VListHandler()
		Protected Gadget = EventGadget(), *GadgetData.ComboData = GetProp_(GadgetID(Gadget), "UITK_ComboData")
		Protected *SubGadget.PB_Gadget = IsGadget(*GadgetData\MenuCanvas), *VListData.VerticalListData = *SubGadget\vt
		
		*GadgetData\State = *VListData\State
		SelectElement(*VListData\Items(), *VListData\State)
		*GadgetData\TextBock\OriginalText = *VListData\Items()\Text\OriginalText
		*GadgetData\TextBock\Image = *VListData\Items()\Text\Image
		PrepareVectorTextBlock(@*GadgetData\TextBock)
		*GadgetData\Unfolded = #False
		RedrawObject()
		HideWindow(*GadgetData\MenuWindow , #True)
		PostEvent(#PB_Event_Gadget, *GadgetData\ParentWindow, *GadgetData\Gadget, #PB_EventType_Change)
	EndProcedure
	
	Procedure Combo_Free(*this.PB_Gadget)
		Protected *GadgetData.ComboData = *this\vt
		
		With *GadgetData
			UnbindEvent(#PB_Event_DeactivateWindow, @Combo_WindowHandler(), \MenuWindow)
			UnbindGadgetEvent(\MenuCanvas, @Combo_VListHandler(), #PB_EventType_Change)
			FreeGadget(\MenuCanvas)
			CloseWindow(\MenuWindow)
			
			If *GadgetData\DefaultEventHandler
				UnbindGadgetEvent(\Gadget, \DefaultEventHandler)
			EndIf
			
			*this\vt = \OriginalVT
		EndWith
		
		FreeStructure(*GadgetData)
		
		ProcedureReturn CallFunctionFast(*this\vt\FreeGadget, *this)
	EndProcedure
	
	Procedure Combo_AddItem(*this.PB_Gadget, Position, *Text, ImageID, Flag)
		Protected *GadgetData.ComboData = *this\vt
		
		*GadgetData\ItemCount + 1
		
		If *GadgetData\ItemCount <= 7
			ResizeGadget(*GadgetData\MenuCanvas, #PB_Ignore, #PB_Ignore, #PB_Ignore, *GadgetData\ItemCount * #Combo_ItemHeight)
			ResizeWindow(*GadgetData\MenuWindow, #PB_Ignore, #PB_Ignore, #PB_Ignore, *GadgetData\ItemCount * #Combo_ItemHeight + *GadgetData\Border)
		EndIf
		
		AddGadgetItem(*GadgetData\MenuCanvas, Position, PeekS(*Text), ImageID, Flag)
	EndProcedure
	
	Procedure Combo_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.ComboData = *this\vt
		Protected *SubGadget.PB_Gadget = IsGadget(*GadgetData\MenuCanvas), *VListData.VerticalListData = *SubGadget\vt
		
		SetGadgetState(*GadgetData\MenuCanvas, State)
		*VListData\State = State
		SelectElement(*VListData\Items(), *VListData\State)
		*GadgetData\TextBock\OriginalText = *VListData\Items()\Text\OriginalText
		*GadgetData\TextBock\Image = *VListData\Items()\Text\Image
		PrepareVectorTextBlock(@*GadgetData\TextBock)
		*GadgetData\Unfolded = #False
		RedrawObject()
	EndProcedure
	
	Procedure Combo_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.ComboData = *this\vt
		Default_SetColor(*This, ColorType, Color)
		
		With *GadgetData
			SetGadgetColor(\MenuCanvas, #Color_Shade_Cold, \ThemeData\BackColor[#Warm])
			SetGadgetColor(\MenuCanvas, #Color_Shade_Warm, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\MenuCanvas, #Color_Shade_Hot, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\MenuCanvas, #Color_Text_Cold, \ThemeData\TextColor[#Cold])
			SetGadgetColor(\MenuCanvas, #Color_Text_Warm, \ThemeData\TextColor[#Warm])
			SetGadgetColor(\MenuCanvas, #Color_Text_Hot, \ThemeData\TextColor[#Hot])
		EndWith
	EndProcedure
	
	Procedure Combo_Meta(*GadgetData.ComboData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		Protected *ListData.VerticalListData, *List.PB_Gadget, GadgetList = UseGadgetList(0)
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
			SetProp_(WindowID(\MenuWindow), "UITK_ComboData", *GadgetData)
			BindEvent(#PB_Event_DeactivateWindow, @Combo_WindowHandler(), \MenuWindow)
			
			SetWindowColor(\MenuWindow, RGB(Red(\ThemeData\LineColor[#Warm]), Green(\ThemeData\LineColor[#Warm]), Blue(\ThemeData\LineColor[#Warm])))
			
			\MenuCanvas = VerticalList(#PB_Any, \Border, 0, \Width - \Border * 2, \Height)
			
			UseGadgetList(GadgetList)
			
			SetProp_(GadgetID(\MenuCanvas), "UITK_ComboData", *GadgetData)
			BindGadgetEvent(\MenuCanvas, @Combo_VListHandler(), #PB_EventType_Change)
			SetGadgetAttribute(\MenuCanvas, #Attribute_CornerRadius, 0)
			
			SetGadgetColor(\MenuCanvas, #Color_Shade_Cold, \ThemeData\BackColor[#Warm])
			SetGadgetColor(\MenuCanvas, #Color_Shade_Warm, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\MenuCanvas, #Color_Shade_Hot, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\MenuCanvas, #Color_Text_Cold, \ThemeData\TextColor[#Cold])
			SetGadgetColor(\MenuCanvas, #Color_Text_Warm, \ThemeData\TextColor[#Warm])
			SetGadgetColor(\MenuCanvas, #Color_Text_Hot, \ThemeData\TextColor[#Hot])
			
			\VT\AddGadgetItem2 = @Combo_AddItem()
			\VT\SetGadgetState = @Combo_SetState()
			\VT\SetGadgetColor = @Combo_SetColor()
			\VT\FreeGadget = @Combo_Free()
			
			; Enable only the needed events
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#MouseEnter] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#KeyDown] = #True
			\SupportedEvent[#KeyUp] = #True
		EndWith
	EndProcedure
	
	Procedure Combo(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ComboData, GadgetList = UseGadgetList(0), *ThemeData
		
		If AccessibilityMode
			Result = ComboBoxGadget(Gadget, x, y, Width, Height)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, ComboData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Combo_Meta(*GadgetData.ComboData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
				
			EndIf
			
			UseGadgetList(GadgetList)
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Container
	Structure ContainerData Extends GadgetData
	EndStructure
	
	Procedure Container_Redraw(*GadgetData.ContainerData)
		With *GadgetData
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			FillPath()
		EndWith
	EndProcedure
	
	Procedure Container_EventHandler(*GadgetData.ContainerData, *Event.Event)
	EndProcedure
	
	Procedure Container_Meta(*GadgetData.ContainerData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Container)
		
		UnbindGadgetEvent(*GadgetData\Gadget, *GadgetData\DefaultEventHandler)
		*GadgetData\DefaultEventHandler = 0
	EndProcedure
	
	Procedure Container(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ContainerData, *ThemeData
		
		If AccessibilityMode
			Result = ContainerGadget(#PB_Any, x, y, Width, Height)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Container)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, ContainerData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Container_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Radio
	#RadioSize = 20
	
	Structure RadioGroup
		List Items.i()
	EndStructure
	
	Global NewMap RadioGroups.RadioGroup()
	
	Structure RadioData Extends GadgetData
		RadioGroup.s
		HAlign.l
	EndStructure
	
	Procedure Radio_Redraw(*GadgetData.RadioData)
		Protected X, Y, State
		
		With *GadgetData
			If \TextBock\FontScale
				VectorFont(\TextBock\FontID, \TextBock\FontScale)
			Else
				VectorFont(\TextBock\FontID)
			EndIf
			
			If \State
				State = #Hot
			Else
				State = \MouseState
			EndIf
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(\ThemeData\LineColor[\MouseState])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\BackColor[State])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			VectorSourceColor(\ThemeData\TextColor[State])
			
			If \HAlign = #HAlignLeft
				DrawVectorTextBlock(@\TextBock, X + \HMargin, 0)
				X = \OriginX + \Width - #RadioSize - BorderMargin - \HMargin
			ElseIf \HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBock, X + \HMargin, 0)
				X = \OriginX + BorderMargin + \HMargin
			Else
				X = \OriginX + BorderMargin + \HMargin
				DrawVectorTextBlock(@\TextBock, X + \HMargin + #RadioSize, 0)
			EndIf
			
			Y = Floor(\OriginY + (\Height - #RadioSize) * 0.5)
			
			VectorSourceColor(\ThemeData\FrontColor[\MouseState])
			AddPathCircle(X + #RadioSize * 0.5, Y + #RadioSize * 0.5,#RadioSize * 0.5)
			AddPathCircle(X + #RadioSize * 0.5, Y + #RadioSize * 0.5,#RadioSize * 0.4)
			
			If \State = #True
				AddPathCircle(X + #RadioSize * 0.5, Y + #RadioSize * 0.5,#RadioSize * 0.3)
			EndIf
			
			FillPath()
		EndWith
	EndProcedure
	
	Procedure Radio_EventHandler(*GadgetData.RadioData, *Event.Event)
		Protected Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseEnter
					\MouseState = #Warm
					Redraw = #True
					
				Case #MouseLeave
					\MouseState = #Cold
					Redraw = #True
					
				Case #LeftClick
					If Not \State
						If \RadioGroup <> ""
							FindMapElement(RadioGroups(), \RadioGroup)
							ForEach RadioGroups()\Items()
								If GetGadgetState(RadioGroups()\Items())
									SetGadgetState(RadioGroups()\Items(), #False)
								EndIf
							Next
						EndIf
						
						\State = #True
						Redraw = #True
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					EndIf
					
				Case #KeyDown
					If *Event\Param = #PB_Shortcut_Space
						*Event\EventType = #LeftClick
						Radio_EventHandler(*GadgetData, *Event)
					EndIf
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
			
		EndWith
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure Radio_Free(*this.PB_Gadget)
		Protected *GadgetData.RadioData = *this\vt
		
		With *GadgetData
			If \RadioGroup
				FindMapElement(RadioGroups(), \RadioGroup)
				ForEach RadioGroups()\Items()
					If RadioGroups()\Items() = \Gadget
						DeleteElement(RadioGroups()\Items())
						Break
					EndIf
				Next
				If ListSize(RadioGroups()\Items()) = 0
					DeleteMapElement(RadioGroups(), \RadioGroup)
				EndIf
			EndIf
			
			Default_FreeGadget(*this)
			
		EndWith
	EndProcedure
	
	Procedure Radio_SetState(*This.PB_Gadget, State)
		Protected *GadgetData.RadioData = *this\vt
		
		If Bool(State) = #True And *GadgetData\State = #False And *GadgetData\RadioGroup <> ""
			FindMapElement(RadioGroups(), *GadgetData\RadioGroup)
			ForEach RadioGroups()\Items()
				If GetGadgetState(RadioGroups()\Items())
					SetGadgetState(RadioGroups()\Items(), #False)
				EndIf
			Next
		EndIf
		
		*GadgetData\State = Bool(State)
		RedrawObject()
	EndProcedure
	
	Procedure Radio_Meta(*GadgetData.RadioData, *ThemeData, Gadget, x, y, Width, Height, Text.s, RadioGroup.s, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Radio)
		
		With *GadgetData
			\TextBock\Width = Width - #RadioSize - BorderMargin * 2
			\TextBock\Height = Height - BorderMargin * 2
			\TextBock\OriginalText = Text
			\HMargin = #RadioSize * 0.5 + BorderMargin
			\VMargin = BorderMargin
			\HAlign = \TextBock\HAlign
			
			If Flags & #HAlignCenter
				\TextBock\HAlign = #HAlignLeft
			EndIf
			
			\TextBock\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
			
			\VT\FreeGadget = @Radio_Free()
			\VT\SetGadgetState = @Radio_SetState()
			
			; Enable only the needed events
			\SupportedEvent[#LeftClick] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#MouseEnter] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#KeyDown] = #True
			\SupportedEvent[#KeyUp] = #True
			
			If RadioGroup <> ""
				If Not FindMapElement(RadioGroups(), RadioGroup)
					AddMapElement(RadioGroups(), RadioGroup)
				EndIf
				AddElement(RadioGroups()\Items())
				RadioGroups()\Items() = Gadget
				\RadioGroup = RadioGroup
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Radio(Gadget, x, y, Width, Height, Text.s, RadioGroup.s = "", Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.RadioData, *ThemeData
		
		If AccessibilityMode
			; 			Result = RadioGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #HAlignRight) * #PB_Radio_Right) |
			; 			                                                           (Bool(Flags & #HAlignCenter) * #PB_Radio_Center) |
			; 			                                                           #PB_Radio_ThreeState)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, RadioData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Radio_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text, RadioGroup, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Library
	#Library_SectionHeight = 50
	#Library_ItemWidth = 160
	#Library_ItemTextHeight = 20
	#Library_ItemHeight = 110
	#Library_ItemMinimumHMargin = 10
	#Library_ItemVMargin = 15
	
	Structure LibraryData Extends GadgetData
		InternalHeight.l
		VisibleScrollbar.b
		
		*RedrawSection.ItemRedraw
		*RedrawItem.ItemRedraw
		*ScrollBar.ScrollBarData
		
		ItemState.i
		SectionHeight.l
		ItemHeight.l
		ItemWidth.l
		ItemPerLine.l
		ItemMinimumHMargin.l
		ItemHMargin.l
		ItemVMargin.l
		
		DragOriginX.l
		DragOriginY.l
		Drag.b
		DragState.b
		
		List Sections.Library_Section()
		List Items.Library_Item()
	EndStructure
	
	Procedure Library_Redraw(*GadgetData.LibraryData)
		Protected Y, ItemX, ItemY, ItemCount
		
		With *GadgetData
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			VectorSourceColor(\ThemeData\TextColor[#Cold])
			
			If ListSize(\Sections())
				ForEach \Sections()
					If \ScrollBar\State > Y + \Sections()\Height
						Y + \Sections()\Height
					Else
						Break
					EndIf
				Next
				
				Y - \ScrollBar\State
				
				Repeat 
					If \Sections()\Height
						\RedrawSection(@\Sections(), \OriginX, Y, \Width, \SectionHeight, 0, \ThemeData)
						ItemY = Y + \SectionHeight
						ItemX = \ItemHMargin
						ItemCount = 0
						
						ForEach \Sections()\Items()
							\RedrawItem(\Sections()\Items(), ItemX, ItemY, \ItemWidth, \ItemHeight, 0, \ThemeData)
							ItemX + (\ItemHMargin + \ItemWidth)
							ItemCount + 1
							If ItemCount = \ItemPerLine
								ItemY + (\ItemHeight + \ItemVMargin)
								ItemCount = 0
								ItemX = \ItemHMargin
							EndIf
						Next
						
						Y + \Sections()\Height
					EndIf
				Until Not NextElement(\Sections()) Or Y >= \Height
				
				If \VisibleScrollbar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure Library_RedrawSection(*Section.Library_Section, X, Y, Width, Height, State, *Theme.Theme)
		If *Section\Text\FontScale
			VectorFont(*Section\Text\FontID, *Section\Text\FontScale)
		Else
			VectorFont(*Section\Text\FontID)
		EndIf
		
		DrawVectorTextBlock(@*Section\Text, X + 20, Y)
	EndProcedure
	
	Procedure Library_RedrawItem(*Item.Library_Item, X, Y, Width, Height, State, *Theme.Theme)
		Protected TextHeight = Height - *Item\Text\Height
		With *Item
			If \Text\FontScale
				VectorFont(\Text\FontID, \Text\FontScale)
			Else
				VectorFont(\Text\FontID)
			EndIf
			
			MovePathCursor(X + \ImageX, Y + \ImageY)
			DrawVectorImage(\ImageID)
						
			DrawVectorTextBlock(@\Text, X, Y + TextHeight + 2)
			
			If \HoverState
				AddPathBox(X, Y, #Library_ItemWidth, TextHeight)
				VectorSourceColor(SetAlpha($FFFFFF, 35))
				FillPath()
				VectorSourceColor(*Theme\TextColor[#Cold])
			EndIf
			
			If \Selected
				AddPathBox(X - 0.5, Y - 0.5, #Library_ItemWidth + 1, TextHeight + 1)
				VectorSourceColor(*Theme\Special3[#Cold])
				StrokePath(3)
				VectorSourceColor(*Theme\TextColor[#Cold])
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Library_AddColumn(*This.PB_Gadget, Position, *Text, Width)
		Protected *GadgetData.LibraryData = *this\vt, *NewSection.Library_Section
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Sections())
				SelectElement(\Sections(), Position)
				*NewSection = InsertElement(\Sections())
			Else
				LastElement(\Sections())
				*NewSection = AddElement(\Sections())
			EndIf
			
			*NewSection\Text\OriginalText = PeekS(*Text)
			*NewSection\Text\LineLimit = 1
			*NewSection\Text\FontID = \TextBock\FontID
			*NewSection\Text\FontScale = 20
			*NewSection\Text\VAlign = #VAlignCenter
			
			*NewSection\Text\Width = \Width - #VerticalList_Margin * 2
			*NewSection\Text\Height = \SectionHeight
			*NewSection\Text\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*NewSection\Text)
			
			ChangeCurrentElement(\Sections(), *NewSection)
			Position = ListIndex(\Sections())
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure Library_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.LibraryData = *this\vt, *NewItem.Library_Item, HBitmap.BITMAP
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			*NewItem\ImageID = ImageID
			*NewItem\Text\OriginalText = PeekS(*Text)
			*NewItem\Text\LineLimit = 1
			*NewItem\Text\FontID = \TextBock\FontID
			*NewItem\Text\Width = \ItemWidth
			*NewItem\Text\Height = #Library_ItemTextHeight
			*NewItem\Text\VAlign = #VAlignTop
			*NewItem\Text\HAlign = #HAlignLeft
			
			PrepareVectorTextBlock(@*NewItem\Text)
			
			GetObject_(*NewItem\ImageID, SizeOf(BITMAP), @HBitmap.BITMAP)
			
			*NewItem\ImageWidth = HBitmap\bmWidth
			*NewItem\ImageHeight = HBitmap\bmHeight
			*NewItem\ImageX = (\ItemWidth - HBitmap\bmWidth) * 0.5
			*NewItem\ImageY = (\ItemHeight - *NewItem\Text\Height - HBitmap\bmHeight) * 0.5
			
			If Flags > -1 And Flags < ListSize(\Sections())
				SelectElement(\Sections(), Flags)
			Else
				LastElement(\Sections())
			EndIf
			
			*NewItem\Section = @\Sections()
			
			AddElement(\Sections()\Items())
			\Sections()\Items() = *NewItem
			
			If ListSize(\Sections()\Items()) % \ItemPerLine = 1
				If ListSize(\Sections()\Items()) = 1
					\Sections()\Height + \SectionHeight
					\InternalHeight + \SectionHeight
				EndIf
				\Sections()\Height + (\ItemVMargin + \ItemHeight)
				\InternalHeight + (\ItemVMargin + \ItemHeight)
				
				If \InternalHeight > \Height
					\VisibleScrollbar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
				Else
					\VisibleScrollbar = #False
				EndIf
				
			EndIf
			
			Position = ListIndex(\Items())
			
		EndWith
		
		RedrawObject()
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure Library_EventHandler(*GadgetData.LibraryData, *Event.Event)
		Protected Redraw, NewItem = -1, ItemRow, Image
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \DragState = #Drag_None
						If \VisibleScrollbar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
							Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
						ElseIf \ScrollBar\MouseState
							\ScrollBar\MouseState = #False
							Redraw = #True
						EndIf
						
						If Not \ScrollBar\MouseState
							If ListSize(\Sections())
								*Event\MouseY + \ScrollBar\State
								ForEach \Sections()
									If *Event\MouseY > \Sections()\Height
										*Event\MouseY - \Sections()\Height
									Else
										If *Event\MouseY > \SectionHeight
											*Event\MouseY - \SectionHeight
											If (*Event\MouseY % (\ItemHeight + \ItemVMargin ) < \ItemHeight - #Library_ItemTextHeight) And(*Event\MouseX % (\ItemHMargin + \ItemWidth) > \ItemHMargin)
												If SelectElement(\Sections()\Items(), Floor(*Event\MouseY / (\ItemHeight + \ItemVMargin )) * \ItemPerLine + Floor(*Event\MouseX / (\ItemHMargin + \ItemWidth)))
													ChangeCurrentElement(\Items(), \Sections()\Items())
													NewItem = ListIndex(\Items())
												EndIf
											EndIf
										EndIf
										Break
									EndIf
								Next
							EndIf
						EndIf
						
						If \ItemState <> NewItem
							If NewItem > -1
								\Items()\HoverState = #True
							EndIf
							If \ItemState > -1
								SelectElement(\Items(), \ItemState)
								\Items()\HoverState = #False
							EndIf
							\ItemState = NewItem
							Redraw = #True
						EndIf
					ElseIf \DragState = #Drag_Init
						If Abs(\DragOriginX - *Event\MouseX) > 7 Or Abs(\DragOriginY - *Event\MouseY) > 7
							SelectElement(\Items(), \State)
							AdvancedDragPrivate(#Drag_LibraryItem, \Items()\ImageID)
							\DragState = #Drag_None
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					
					If \ItemState > -1
						SelectElement(\Items(), \ItemState)
						\Items()\HoverState = #False
						\ItemState = -1
						Redraw = #True
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ItemState > -1
						If \State > -1
							SelectElement(\Items(), \State)
							\Items()\Selected = #False
						EndIf
						\State = \ItemState
						
						SelectElement(\Items(), \State)
						\Items()\Selected = #True
						Redraw = #True
						
						If \Drag
							\DragState = #Drag_Init
							\DragOriginX = *Event\MouseX
							\DragOriginY = *Event\MouseY
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					\DragState = #Drag_None
					;}
				Case #LeftDoubleClick ;{
					;}
				Case #MouseWheel ;{
					If \VisibleScrollbar
						Redraw = ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 0.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not Library_EventHandler(*GadgetData, *Event))
					EndIf
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
		EndWith
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure Library_RemoveItem(*This.PB_Gadget, Position)
		Protected *GadgetData.LibraryData = *this\vt
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				
				If \State = Position
					\State = -1
				ElseIf \State > Position
					\State -1
				EndIf
				
				If \ItemState > -1
					SelectElement(\Items(), \ItemState)
					\Items()\HoverState = #False
					\ItemState = -1
				EndIf
				
				SelectElement(\Items(), Position)
				ChangeCurrentElement(\Sections(), \Items()\Section)
				
				ForEach \Sections()\Items()
					If \Sections()\Items() = @\Items()
						DeleteElement(\Sections()\Items())
						Break
					EndIf
				Next
				
				DeleteElement(\Items())
				
				If ListSize(\Sections()\Items()) % \ItemPerLine = 0
					If ListSize(\Sections()\Items()) = 0
						\InternalHeight - \Sections()\Height
						\Sections()\Height = 0
					Else
						\Sections()\Height - (\ItemVMargin + \ItemHeight)
						\InternalHeight - (\ItemVMargin + \ItemHeight)
					EndIf
					
					If \InternalHeight > \Height
						\VisibleScrollbar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
					Else
						\VisibleScrollbar = #False
						\ScrollBar\State = 0
					EndIf
					
				EndIf
				
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Library_ClearItems(*This.PB_Gadget)
		Protected *GadgetData.LibraryData = *this\vt
		
		With *GadgetData
			ClearList(\Items())
			ClearList(\Sections())
			
			\InternalHeight = 0
			\VisibleScrollbar = #False
			\ScrollBar\State = 0
			
			RedrawObject()
		EndWith
		
	EndProcedure
	
	Procedure Library_Resize(*this.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.LibraryData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			\ItemPerLine = Floor((\Width - \ItemMinimumHMargin) / (\ItemWidth + \ItemMinimumHMargin))
			\ItemHMargin = Floor((\Width - \ItemPerLine * \ItemWidth) / (\ItemPerLine + 1))
			
			Scrollbar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			\InternalHeight = 0
			
			ForEach \Sections()
				If \Sections()\Height
					\Sections()\Height = \SectionHeight
					\Sections()\Height + Round(ListSize(\Sections()\Items()) / \ItemPerLine, #PB_Round_Up) * (\ItemVMargin + \ItemHeight)
					\InternalHeight + \Sections()\Height
				EndIf
			Next
			
			If \InternalHeight > \Height
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollbar = #False
			EndIf
			
		EndWith
		
		RedrawObject()
	EndProcedure
	
	Procedure Library_CountItem(*This.PB_Gadget)
		Protected *GadgetData.LibraryData = *this\vt
		
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	;Setters
	Procedure Library_SetItemData(*this.PB_Gadget, Position, *Data)
		Protected *GadgetData.LibraryData = *this\vt
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			SelectElement(*GadgetData\Items(), Position)
			*GadgetData\Items()\Data = *Data
			
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure Library_SetAttribute(*This.PB_Gadget, Attribute, Value)
		Protected *GadgetData.LibraryData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #Attribute_Library_SectionHeight
					ForEach \Sections()
						If \Sections()\Height
							\Sections()\Height - \SectionHeight + Value
						EndIf
					Next
					
					\SectionHeight = Value
					
				Default	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
			EndSelect
			
			RedrawObject()
		EndWith
	EndProcedure
	
	;Getters
	Procedure Library_GetItemData(*this.PB_Gadget, Position)
		Protected *GadgetData.LibraryData = *this\vt, *Result
		
		If Position > -1 And SelectElement(*GadgetData\Items(), Position)
			*Result = *GadgetData\Items()\Data
		EndIf
		
		ProcedureReturn *Result
	EndProcedure
	
	Procedure Library_GetItemImage(*this.PB_Gadget, Position)
		Protected *GadgetData.LibraryData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				ProcedureReturn \Items()\Text\Image
			EndIf
		EndWith
	EndProcedure
	
	
	Procedure Library_Meta(*GadgetData.LibraryData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Library)
		
		With *GadgetData
			
			AllocateStructureX(\ScrollBar, ScrollBarData)
			Scrollbar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \InternalHeight, Height , #Gadget_Vertical)
			\RedrawSection = @Library_RedrawSection()
			If *CustomItem
				\RedrawItem = *CustomItem 
			Else
				\RedrawItem = @Library_RedrawItem() 
			EndIf
			\SectionHeight = #Library_SectionHeight
			\ItemWidth = #Library_ItemWidth
			\ItemHeight = #Library_ItemHeight
			\ItemMinimumHMargin = #Library_ItemMinimumHMargin
			\ItemVMargin = #Library_ItemVMargin
			\ItemState = -1
			\State = -1
			
			\Drag = Bool(Flags & #Drag)
			
			\ItemPerLine = Floor((\Width - \ItemMinimumHMargin) / (\ItemWidth + \ItemMinimumHMargin))
			\ItemHMargin = Floor((\Width - \ItemPerLine * \ItemWidth) / (\ItemPerLine + 1))
			
			\VT\AddGadgetColumn = @Library_AddColumn()
			\VT\AddGadgetItem3 = @Library_AddItem()
			\VT\RemoveGadgetItem = @Library_RemoveItem()
			\VT\ClearGadgetItemList = @Library_ClearItems()
			\VT\ResizeGadget = @Library_Resize()
			
			\VT\SetGadgetItemData = @Library_SetItemData()
			\VT\SetGadgetAttribute = @Library_SetAttribute()
			
			\VT\GetGadgetItemData = @Library_GetItemData()
			\VT\GetGadgetItemImage = @Library_GetItemImage()
			\VT\CountGadgetItems = @Library_CountItem()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			\SupportedEvent[#KeyDown] = #True
		EndWith
	EndProcedure
	
	Procedure Library(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
		Protected Result, *this.PB_Gadget, *GadgetData.LibraryData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
		
		If Result
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			*this = IsGadget(Gadget)
			AllocateStructureX(*GadgetData, LibraryData)
			CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
			*GadgetData\OriginalVT = *this\VT
			*this\VT = *GadgetData
			
			AllocateStructureX(*ThemeData, Theme)
			
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, *ThemeData, Theme)
			ElseIf Flags & #LightMode
				CopyStructure(@DefaultTheme, *ThemeData, Theme)
			Else
				Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
				If *WindowData
					CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
				Else
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				EndIf
			EndIf
			
			Library_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Property box
	#PropertyBox_MarginWidth = 28
	#PropertyBox_ColumnWidth = 125
	#PropertyBox_ItemHeight = 19
	
	Structure PropertyBox_Item
		Text.Text
		Type.l
		
	EndStructure
	
	Structure PropertyBoxData Extends GadgetData
		InternalHeight.l
		ItemHeight.l
		MarginWidth.l
		ColumnWidth.l
		ContentWidth.l
		VisibleScrollbar.b
		*ScrollBar.ScrollBarData
		List Items.PropertyBox_Item()
	EndStructure
	
	Procedure PropertyBox_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.PropertyBoxData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			\TextBock\Width = \Width 
			\TextBock\Height = \Height 
			
			Scrollbar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			If \InternalHeight > \Height
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure PropertyBox_Redraw(*GadgetData.PropertyBoxData)
		Protected Y, X, FirstElement
		
		With *GadgetData
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\ShadeColor[#Warm])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			If ListSize(\Items())
				X = \OriginX + \Border + \MarginWidth + 3
				Y = *GadgetData\OriginY + \Border
				
				If \VisibleScrollbar
					SelectElement(\Items(), Floor(\ScrollBar\State / \ItemHeight))
					Y - (\ScrollBar\State % \ItemHeight)
				Else
					FirstElement(\Items())
				EndIf
				
				VectorFont(\TextBock\FontID)
				VectorSourceColor(\ThemeData\TextColor[#Cold])
				
				Repeat
					If \Items()\Type = #PropertyBox_Title
						VectorFont(\Items()\Text\FontID, \Items()\Text\FontScale)
						DrawVectorTextBlock(@\Items()\Text, X + 3, Y - 1)
						VectorFont(\TextBock\FontID)
					Else
						VectorSourceColor(\ThemeData\ShadeColor[#Cold])
						AddPathBox(X, Y, \Width, \ItemHeight - 1)
						FillPath()
						
						VectorSourceColor(\ThemeData\TextColor[#Cold])
						DrawVectorTextBlock(@\Items()\Text, X + 3, Y - 2)
					EndIf
					
					Y + \ItemHeight
				Until Not NextElement(\Items()) Or Y > \Height
				
				VectorSourceColor(\ThemeData\ShadeColor[#Warm])
				MovePathCursor(\OriginX + \ColumnWidth + \MarginWidth + 0.5, \Border)
				AddPathLine(0, \Height, #PB_Path_Relative)
				StrokePath(1)
				
				If Y < \Height
					VectorSourceColor(\ThemeData\ShadeColor[#Cold])
					AddPathBox(X, Y, \Width, \Height - Y)
					FillPath()
				EndIf
				
				If \VisibleScrollbar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure PropertyBox_EventHandler(*GadgetData.PropertyBoxData, *Event.Event)
		Protected Redraw, Y, NewItem = -1, ItemRow
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \VisibleScrollbar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ScrollBar\MouseState
						\ScrollBar\MouseState = #False
						Redraw = #True
					EndIf
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #MouseWheel ;{
					If \VisibleScrollbar
						Redraw = ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 1.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not PropertyBox_EventHandler(*GadgetData, *Event))
					EndIf
					;}		
			EndSelect
			If Redraw
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.PropertyBoxData = *this\vt, *NewItem.PropertyBox_Item
		With *GadgetData
			
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			*NewItem\Text\OriginalText = PeekS(*Text)
			*NewItem\Text\Image = ImageID
			*NewItem\Text\LineLimit = 1
			*NewItem\Type = Flags
			If *NewItem\Type = #PropertyBox_Title
				*NewItem\Text\FontID = BoldFont
				*NewItem\Text\FontScale = 11
			Else
				*NewItem\Text\FontID = \TextBock\FontID
			EndIf
			*NewItem\Text\Width = \ColumnWidth
			*NewItem\Text\Height = \ItemHeight
			*NewItem\Text\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			\InternalHeight + \ItemHeight
			
			If \InternalHeight > \Height
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure PropertyBox_Meta(*GadgetData.PropertyBoxData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(PropertyBox)
		
		With *GadgetData
			AllocateStructureX(\ScrollBar, ScrollBarData)
			\ItemHeight = #PropertyBox_ItemHeight
			\ColumnWidth = #PropertyBox_ColumnWidth
			\MarginWidth = #PropertyBox_MarginWidth
			
			Scrollbar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \InternalHeight, Height , #Gadget_Vertical)
			
			\VT\AddGadgetItem3 = @PropertyBox_AddItem()
			\VT\ResizeGadget = @PropertyBox_Resize()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			
		EndWith
	EndProcedure
	
	Procedure PropertyBox(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.PropertyBoxData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Container)
		
		If Result
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			*this = IsGadget(Gadget)
			AllocateStructureX(*GadgetData, PropertyBoxData)
			CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
			*GadgetData\OriginalVT = *this\VT
			*this\VT = *GadgetData
			
			AllocateStructureX(*ThemeData, Theme)
			
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, *ThemeData, Theme)
			ElseIf Flags & #LightMode
				CopyStructure(@DefaultTheme, *ThemeData, Theme)
			Else
				Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
				If *WindowData
					CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
				Else
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				EndIf
			EndIf
			
			PropertyBox_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
			
			RedrawObject()
		EndIf
		
		CloseGadgetList()
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ Tree
	#Tree_BranchWidth = 18
	#Tree_ColumnWidth = 125
	#Tree_ItemHeight = 19
	#Tree_BranchHeight = 9.5
	#Tree_Dot = 2
	#Tree_Straight = 1
	
	Structure Tree_Item
		Text.Text
		Level.b
	EndStructure
	
	Structure TreeData Extends GadgetData
		InternalHeight.l
		ItemHeight.l
		BranchWidth.l
		VisibleScrollbar.b
		MaxLevel.b
		DrawLine.l
		*ScrollBar.ScrollBarData
		List Items.Tree_Item()
	EndStructure
	
	Procedure Tree_Redraw(*GadgetData.TreeData)
		Protected Y, X, FirstElement, PreviousLevel, Dim LastLevel(*GadgetData\MaxLevel), Height
		
		With *GadgetData
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			Height = \Height + \ItemHeight
			
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			If ListSize(\Items())
				X = \OriginX + \Border + \BranchWidth + 1
				Y = *GadgetData\OriginY + \Border - (\ScrollBar\State % \ItemHeight)
				
				If \VisibleScrollbar And Floor(\ScrollBar\State / \ItemHeight)
					SelectElement(\Items(), Floor(\ScrollBar\State / \ItemHeight) - 1)
					PreviousLevel = \Items()\Level
					NextElement(\Items())
				Else
					PreviousLevel = 1
					LastLevel(0) = #Tree_BranchHeight + Y
					FirstElement(\Items())
				EndIf
				
				VectorFont(\TextBock\FontID)
				VectorSourceColor(\ThemeData\TextColor[#Cold])
				
				Repeat
					If PreviousLevel = \Items()\Level
						MovePathCursor( X + \Items()\Level * \BranchWidth - #Tree_BranchHeight, Y - 10)
						AddPathLine(0, 10 + #Tree_BranchHeight, #PB_Path_Relative)
					Else
						If PreviousLevel > \Items()\Level
							MovePathCursor( X + \Items()\Level * \BranchWidth - #Tree_BranchHeight, LastLevel(\Items()\Level))
							AddPathLine(0, Y - LastLevel(\Items()\Level) + #Tree_BranchHeight, #PB_Path_Relative)
						Else
							LastLevel(PreviousLevel) = Y + #Tree_BranchHeight - \ItemHeight
							MovePathCursor( X + \Items()\Level * \BranchWidth - #Tree_BranchHeight, Y)
							AddPathLine(0, #Tree_BranchHeight, #PB_Path_Relative)
						EndIf
					EndIf
					AddPathLine(X + \Items()\Level * \BranchWidth, Y + #Tree_BranchHeight)
					
					If \State = ListIndex(\Items())
						If \DrawLine = #Tree_Dot
							DotPath(1, 3)
						ElseIf \DrawLine = #Tree_Straight
							StrokePath(1)
						Else
							ResetPath()
						EndIf
						AddPathBox(X + \Items()\Level * \BranchWidth - 2, Y + 1, \Items()\Text\RequieredWidth + 2, \ItemHeight - 1)
						VectorSourceColor(\ThemeData\ShadeColor[#Hot])
						FillPath()
						VectorSourceColor(\ThemeData\TextColor[#Cold])
					EndIf
					
					DrawVectorTextBlock(@\Items()\Text, X + \Items()\Level * \BranchWidth, Y)
					PreviousLevel = \Items()\Level
					Y + \ItemHeight
				Until Y > Height Or Not NextElement(\Items()) 
				
				
				If \DrawLine
					If PreviousLevel And Not (ListIndex(\Items()) + 1 = ListSize(\Items()))
						Repeat
							If \Items()\Level < PreviousLevel
								MovePathCursor( X + \Items()\Level * \BranchWidth - #Tree_BranchHeight, LastLevel(\Items()\Level))
								AddPathLine(0, \Height - LastLevel(\Items()\Level) + #Tree_BranchHeight, #PB_Path_Relative)
								If \Items()\Level = 0
									Break
								Else
									PreviousLevel = \Items()\Level
								EndIf
							EndIf
						Until Not NextElement(\Items()) 
					EndIf
					
					If \DrawLine = #Tree_Dot
						DotPath(1, 3)
					Else
						StrokePath(1)
					EndIf
				EndIf
				
				If \VisibleScrollbar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Tree_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.TreeData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			\TextBock\Width = \Width 
			\TextBock\Height = \Height 
			
			Scrollbar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			If \InternalHeight > \Height
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			PrepareVectorTextBlock(@*GadgetData\TextBock)
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure Tree_EventHandler(*GadgetData.TreeData, *Event.Event)
		Protected Redraw, Y, NewItem = -1, ItemRow
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \VisibleScrollbar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ScrollBar\MouseState
						\ScrollBar\MouseState = #False
						Redraw = #True
					EndIf
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #LeftButtonDown, #RightButtonDown ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf SelectElement(\Items(), Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight))
						If (*Event\MouseX > \Border + \BranchWidth * (\Items()\Level + 1)) And (*Event\MouseX < \Border + \BranchWidth * (\Items()\Level + 1) + \Items()\Text\RequieredWidth)
							If \State <> ListIndex(\Items())
								\State = ListIndex(\Items())
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
							
							If *Event\EventType = #RightButtonDown
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #EventType_ItemRightClick)
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #MouseWheel ;{
					If \VisibleScrollbar
						Redraw = ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 1.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not Tree_EventHandler(*GadgetData, *Event))
					EndIf
					;}	
				Case #LeftDoubleClick ;{
					If (Not \ScrollBar\MouseState) And SelectElement(\Items(), Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight))
						If (*Event\MouseX > \Border + \BranchWidth * (\Items()\Level + 1)) And (*Event\MouseX < \Border + \BranchWidth * (\Items()\Level + 1) + \Items()\Text\RequieredWidth)
							If \State <> ListIndex(\Items())
								\State = ListIndex(\Items())
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #Eventtype_ForcefulChange)
							EndIf
						EndIf
					EndIf
					;}
			EndSelect
			If Redraw
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tree_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.TreeData = *this\vt, *NewItem.Tree_Item
		With *GadgetData
			
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			*NewItem\Text\OriginalText = PeekS(*Text)
			*NewItem\Text\Image = ImageID
			*NewItem\Text\LineLimit = 1
			
			If PreviousElement(\Items())
				*NewItem\Level = Min(Flags, \Items()\Level + 1)
				\MaxLevel = Max(\MaxLevel, *NewItem\Level + 1)
			Else
				*NewItem\Level = 0
			EndIf
			
			*NewItem\Text\FontID = \TextBock\FontID
			
			*NewItem\Text\Width = \Width - (*NewItem\Level + 1) * #Tree_BranchWidth
			*NewItem\Text\Height = \ItemHeight
			*NewItem\Text\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			\InternalHeight + \ItemHeight
			
			If \InternalHeight > \Height
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure Tree_RemoveItem(*This.PB_Gadget, Position)
		Protected *GadgetData.TreeData = *this\vt
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				If Position <= \State
					\State - 1
				EndIf
				
				DeleteElement(\Items())
				
				\InternalHeight - \ItemHeight
				
				If \InternalHeight > \Height
					\VisibleScrollbar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
				Else
					\VisibleScrollbar = #False
				EndIf
				
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tree_CountItem(*This.PB_Gadget)
		Protected *GadgetData.TreeData = *this\vt
		
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	Procedure Tree_ClearItems(*This.PB_Gadget)
		Protected *GadgetData.TreeData = *this\vt
		
		With *GadgetData
			ClearList(\Items())
			\State = - 1
			\InternalHeight = 0
			\ScrollBar\State = 0
			\VisibleScrollbar = #False
			
			RedrawObject()
		EndWith
	EndProcedure
	
	; Getters
	Procedure Tree_GetItemImage(*this.PB_Gadget, Position)
		Protected *GadgetData.TreeData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				ProcedureReturn \Items()\Text\Image
			EndIf
		EndWith
	EndProcedure
	
	
	; Setters
	
	
	Procedure Tree_Meta(*GadgetData.TreeData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Tree)
		
		With *GadgetData
			AllocateStructureX(\ScrollBar, ScrollBarData)
			\ItemHeight = #Tree_ItemHeight
			\BranchWidth= #Tree_BranchWidth
			\MaxLevel = 1
			\State = -1
			\InternalHeight = 5
			
			Scrollbar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \InternalHeight, Height , #Gadget_Vertical)
			
			If Flags & #Tree_NoLine
				\DrawLine = 0
			ElseIf Flags & #Tree_StraightLine
				\DrawLine = #Tree_Straight
			Else
				\DrawLine = #Tree_Dot
			EndIf
			
			\VT\AddGadgetItem3 = @Tree_AddItem()
			\VT\ResizeGadget = @Tree_Resize()
			\VT\CountGadgetItems = @Tree_CountItem()
			\VT\GetGadgetItemImage = @Tree_GetItemImage()
			\VT\ClearGadgetItemList = @Tree_ClearItems()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#RightButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
		EndWith
	EndProcedure
	
	Procedure Tree(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.TreeData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Container)
		
		If Result
			If Gadget = #PB_Any
				Gadget = Result
			EndIf
			
			*this = IsGadget(Gadget)
			AllocateStructureX(*GadgetData, TreeData)
			CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
			*GadgetData\OriginalVT = *this\VT
			*this\VT = *GadgetData
			
			AllocateStructureX(*ThemeData, Theme)
			
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, *ThemeData, Theme)
			ElseIf Flags & #LightMode
				CopyStructure(@DefaultTheme, *ThemeData, Theme)
			Else
				Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
				If *WindowData
					CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
				Else
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				EndIf
			EndIf
			
			Tree_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
			
			RedrawObject()
		EndIf
		
		CloseGadgetList()
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ HorizontalList
	#HList_ItemHeight = 100
	
	Structure HorizontalList_Item
		ImageX.l
		ImageY.l
		imageID.i
		Text.Text
	EndStructure
	
	Structure HorizontalListData Extends GadgetData
		ItemWidth.l
		VisibleScrollbar.b
		*ScrollBar.ScrollBarData
		InternalWidth.i
		DragOriginX.l
		DragOriginY.l
		Drag.b
		DragState.b
		List Items.HorizontalList_Item()
	EndStructure
	
	Procedure HorizontalList_ItemRedraw(*Item.HorizontalList_Item, X, Y, Width, Height, State, *Theme.Theme)
		If State = #Hot
			AddPathBox(X, Y, Width, Height)
			VectorSourceColor(*Theme\ShadeColor[#Hot])
			FillPath()
			VectorSourceColor(*Theme\TextColor[#Cold])
		ElseIf State = #Warm
			AddPathBox(X, Y, Width, Height)
			VectorSourceColor(*Theme\ShadeColor[#Warm])
			FillPath()
			VectorSourceColor(*Theme\TextColor[#Cold])
		EndIf
		
		If *Item\imageID
			MovePathCursor(X + *Item\ImageX, Y + *Item\ImageY)
			DrawVectorImage(*Item\imageID)
		EndIf
		
		DrawVectorTextBlock(@*Item\Text, X, Y)
	EndProcedure
	
	Procedure HorizontalList_Redraw(*GadgetData.HorizontalListData)
		With *GadgetData
			Protected X = \OriginX + \Border
			
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			If ListSize(\Items())
				VectorFont(\TextBock\FontID)
				VectorSourceColor(\ThemeData\TextColor[#Cold])
				
				If \ScrollBar\State
					SelectElement(\Items(), Floor(\ScrollBar\State / \ItemWidth))
					X - (\ScrollBar\State % \ItemWidth)
				Else
					FirstElement(\Items())
				EndIf
					
				Repeat
					If ListIndex(\Items()) = \State
						HorizontalList_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Hot, \ThemeData)
					ElseIf ListIndex(\Items()) = \MouseState
						HorizontalList_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Warm, \ThemeData)
					Else
						HorizontalList_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Cold, \ThemeData)
					EndIf
					
					X + \ItemWidth
				Until X > \Width Or Not NextElement(\Items())
			EndIf
			
			If \VisibleScrollbar
				\ScrollBar\Redraw(\ScrollBar)
			EndIf
		EndWith
	EndProcedure
	
	Procedure HorizontalList_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.HorizontalListData = *this\vt, PreviousHeight
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			PreviousHeight = \Height
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			Scrollbar_ResizeMeta(\ScrollBar, \Border + 1, \Height - \Border - 1 - #VerticalList_ToolbarThickness, \Width - \Border * 2 - 2, #VerticalList_ToolbarThickness)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Width)
			
			If \InternalWidth > \Width
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			If PreviousHeight <> \Height
				ForEach \Items()
					\Items()\Text\Height = \Height
					PrepareVectorTextBlock(@\Items()\Text)
				Next
			EndIf
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure HorizontalList_StateFocus(*GadgetData.HorizontalListData)
		Protected Result
		
		With *GadgetData
			If \VisibleScrollbar
				If Ceil(\ScrollBar\State / \ItemWidth) > \State
					ScrollBar_SetState_Meta(\ScrollBar, \State * \ItemWidth)
					Result = #True
				ElseIf Floor((\ScrollBar\State + \Width - \ItemWidth) / \ItemWidth) < \State
					ScrollBar_SetState_Meta(\ScrollBar, \State * \ItemWidth - \Width + \ItemWidth)
					Result = #True
				EndIf
			EndIf
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure HorizontalList_FocusTimer(*GadgetData.HorizontalListData, Timer)
		RemoveGadgetTimer(Timer)
		
		If HorizontalList_StateFocus(*GadgetData)
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure HorizontalList_EventHandler(*GadgetData.HorizontalListData, *Event.Event)
		Protected Redraw, HoverItem, Keyboard, Image
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \DragState = #Drag_None
						If \VisibleScrollbar And (*Event\MouseY >= \ScrollBar\OriginY Or \ScrollBar\Drag = #True)
							Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
						ElseIf \ScrollBar\MouseState
							\ScrollBar\MouseState = #False
							Redraw = #True
						EndIf
						
						If Not \ScrollBar\MouseState
							HoverItem = Floor((*Event\MouseX + \ScrollBar\State) / \ItemWidth)
							If HoverItem <> \MouseState
								\MouseState = HoverItem
								Redraw = #True
							EndIf
						ElseIf \MouseState > -1
							\MouseState = -1
							Redraw = #True
						EndIf
					ElseIf \DragState = #Drag_Init
						If Abs(\DragOriginX - *Event\MouseX) > 7 Or Abs(\DragOriginY - *Event\MouseY) > 7
							Image = CreateImage(#PB_Any, \ItemWidth, \Height, 32, \ThemeData\ShadeColor[#Cold])
							StartVectorDrawing(ImageVectorOutput(Image))
							VectorFont(\TextBock\FontID)
							VectorSourceColor(\ThemeData\TextColor[#Cold])
							SelectElement(\Items(),\State)
							HorizontalList_ItemRedraw(@\Items(), 0, 0, \ItemWidth, \Height, #Hot, \ThemeData)
							StopVectorDrawing()
							AdvancedDragPrivate(#Drag_HListItem, ImageID(Image))
							\DragState = #Drag_None
							FreeImage(Image)
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \MouseState > -1
						\MouseState = -1
						Redraw = #True
					EndIf
					
					;}
				Case #LeftButtonDown ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					Else
						If \MouseState > -1 
							If \State <> \MouseState
								\State = \MouseState
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
								AddGadgetTimer(*GadgetData, 200, @HorizontalList_FocusTimer())
							EndIf
							
							If \Drag
								\DragState = #Drag_Init
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					\DragState = #Drag_None
					;}
				Case #LeftDoubleClick ;{
					If \MouseState > -1
							PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #Eventtype_ForcefulChange)
					EndIf
					;}
				Case #KeyDown ;{
					If *Event\Param = #PB_Shortcut_Left
						If \State > 0
							\State - 1
							HorizontalList_StateFocus(*GadgetData)
							Redraw = #True
						EndIf
					ElseIf *Event\Param = #PB_Shortcut_Right
						If \State < ListSize(\Items()) - 1
							\State + 1
							HorizontalList_StateFocus(*GadgetData)
							Redraw = #True
						EndIf
					EndIf
					;}
			EndSelect
			If Redraw
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure HorizontalList_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.HorizontalListData = *this\vt, *NewItem.HorizontalList_Item, HBitmap.BITMAP
		With *GadgetData
			
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			*NewItem\Text\OriginalText = PeekS(*Text)
			*NewItem\Text\LineLimit = 1
			*NewItem\Text\FontID = \TextBock\FontID
			*NewItem\Text\Width = \ItemWidth
			*NewItem\Text\Height = Floor(\Height * 0.9)
			*NewItem\Text\VAlign = #VAlignBottom
			*NewItem\Text\HAlign = #HAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			
			*NewItem\imageID = ImageID
			
			If *NewItem\imageID
				GetObject_(*NewItem\imageID, SizeOf(BITMAP), @HBitmap.BITMAP)
				*NewItem\ImageX = (\ItemWidth - HBitmap\bmWidth) * 0.5
				*NewItem\ImageY = (\Height - 20 - HBitmap\bmHeight) * 0.5
			EndIf
			
			\InternalWidth = ListSize(\Items()) * \ItemWidth
			
			If \InternalWidth > \Width
				\VisibleScrollbar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
			Else
				\VisibleScrollbar = #False
			EndIf
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure HorizontalList_RemoveItem(*This.PB_Gadget, Position)
		Protected *GadgetData.HorizontalListData = *this\vt
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				DeleteElement(\Items())
				\InternalWidth = ListSize(\Items()) * \ItemWidth
				
				If \InternalWidth > \Width
					\VisibleScrollbar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
				Else
					\VisibleScrollbar = #False
				EndIf
				
				If \State > Position
					\State - 1
				ElseIf \State = Position
					If \State = ListSize(\Items())
						\State - 1
					EndIf
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
				EndIf
				
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure HorizontalList_CountItem(*This.PB_Gadget)
		Protected *GadgetData.HorizontalListData = *this\vt
		
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	Procedure HorizontalList_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.HorizontalListData = *this\vt
		
		FreeStructure(*GadgetData\ScrollBar)
		
		Default_FreeGadget(*this.PB_Gadget)
	EndProcedure
	
	
	; Getters
	Procedure.s HorizontalList_GetItemText(*this.PB_Gadget, Position)
		Protected *GadgetData.HorizontalListData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				ProcedureReturn \Items()\Text\OriginalText
			EndIf
		EndWith
	EndProcedure
	
	Procedure HorizontalList_GetItemImage(*this.PB_Gadget, Position)
		Protected *GadgetData.HorizontalListData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				ProcedureReturn \Items()\imageID
			EndIf
		EndWith
	EndProcedure
	
	
	; Setters
	Procedure HorizontalList_SetAttribute(*this.PB_Gadget, Attribute, Value)
		Protected *GadgetData.HorizontalListData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #Attribute_ItemWidth ;{
					\ItemWidth = Value
					\InternalWidth = ListSize(\Items()) * \ItemWidth
					
					If \InternalWidth > \Width
						\VisibleScrollbar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
					Else
						\VisibleScrollbar = #False
					EndIf
					
					ForEach \Items()
						\Items()\Text\Width = \ItemWidth
						PrepareVectorTextBlock(@\Items()\Text)
					Next
					;}
				Default ;{	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					;}
			EndSelect
		EndWith
		RedrawObject()
	EndProcedure
	
	
	Procedure HorizontalList_Meta(*GadgetData.HorizontalListData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(HorizontalList)
		
		With *GadgetData
			AllocateStructureX(\ScrollBar, ScrollBarData)
			\VisibleScrollbar = #False
			\ItemWidth = Height
			\State = -1
			\MouseState = -1
			\Drag = Bool(Flags & #Drag)
			
			Scrollbar_Meta(\ScrollBar, *ThemeData, -1, \Border + 1, \Height - \Border - 1 - #VerticalList_ToolbarThickness, \Width - \Border * 2 - 2, #VerticalList_ToolbarThickness, 0, 0, \Width, #Null)
			
			\VT\AddGadgetItem2 = @HorizontalList_AddItem()
			\VT\RemoveGadgetItem = @HorizontalList_RemoveItem()
			\VT\ResizeGadget = @HorizontalList_Resize()
			\VT\SetGadgetAttribute = @HorizontalList_SetAttribute()
			\VT\CountGadgetItems = @HorizontalList_CountItem()
			\VT\GetGadgetItemImage = @HorizontalList_GetItemImage()
			\VT\GetGadgetItemText = @HorizontalList_GetItemText()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			\SupportedEvent[#KeyDown] = #True
		EndWith
	EndProcedure
	
	Procedure HorizontalList(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.HorizontalListData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, HorizontalListData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				HorizontalList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Menu
	#MenuMinimumWidth = 140
	#MenuSeparatorHeight = 5
	#MenuMargin = 5
	#MenuItemLeftMargin = 20 + #menuMargin
	
	Procedure FlatMenu_Redraw(*MenuData.FlatMenu)
		Protected Y = 0, VerticalOffset
		
		With *MenuData
			StartVectorDrawing(CanvasVectorOutput(\Canvas))
			AddPathBox(0, 0, \Width, \Height)
			VectorSourceColor(\Theme\ShadeColor[#Cold])
			FillPath()
			VectorFont(\FontID)
			VectorSourceColor(\Theme\TextColor[#Warm])
			
			ForEach \Item()
				If \Item()\Type = #Separator
					MovePathCursor(#MenuMargin, Y + #MenuSeparatorHeight * 0.5)
					VectorSourceColor(\Theme\TextColor[#Disabled])
					AddPathLine(\Width - #MenuMargin * 2, 0, #PB_Path_Relative)
					StrokePath(1)
					VectorSourceColor(\Theme\TextColor[#Warm])
					Y + #MenuSeparatorHeight
				Else
					If ListIndex(\Item()) = \State
						AddPathBox(0, Y, \Width, \ItemHeight)
						VectorSourceColor(\Theme\ShadeColor[#Warm])
						FillPath()
						VectorSourceColor(\Theme\TextColor[#Hot])
						DrawVectorTextBlock(@\Item()\Text, #MenuMargin, Y)
						VectorSourceColor(\Theme\TextColor[#Warm])
					Else
						DrawVectorTextBlock(@\Item()\Text, #MenuMargin, Y)
					EndIf
					
					Y + \ItemHeight
				EndIf
			Next
			
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure FlatMenu_WindowEvent()
		Protected *MenuData.FlatMenu = GetProp_(WindowID(EventWindow()), "UITK_MenuData"), PreviousState
		
		With *MenuData
			HideWindow(\Window, #True)
			PostEvent(#Event_CloseMenu, \Window, 0, 0, \Window)
		EndWith
	EndProcedure
	
	Procedure FlatMenu_CanvasEvent()
		Protected *MenuData.FlatMenu = GetProp_(GadgetID(EventGadget()), "UITK_MenuData"), Y, MouseY, State = - 1
		
		With *MenuData
			Select EventType()
				Case #PB_EventType_MouseMove ;{
					MouseY = GetGadgetAttribute(\Canvas, #PB_Canvas_MouseY)
					
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
						
					If State <> \State
						\State = State
						FlatMenu_Redraw(*MenuData)
					EndIf
					;}
				Case #PB_EventType_MouseLeave ;{
					If \State <> -1
						\State = -1
						FlatMenu_Redraw(*MenuData)
					EndIf
					;}
				Case #PB_EventType_LeftClick ;{
					If \State > -1
						SelectElement(\Item(), \State)
						PostEvent(#PB_Event_Menu, EventWindow(), \Item()\ID)
						FlatMenu_WindowEvent()
						\State = -1
						FlatMenu_Redraw(*MenuData)
					EndIf
					;}
				Case #PB_EventType_LostFocus
					PostEvent(#PB_Event_Gadget, \Window, \Canvas, #PB_EventType_CloseItem)
			EndSelect
			
		EndWith
	EndProcedure
	
	Procedure SetFlatMenuColor(Menu, ColorType, Color)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		
		With *MenuData
			Select ColorType
				Case #Color_WindowBorder
					\Theme\WindowTitle =  RGB(Red(Color), Green(Color), Blue(Color))
					SetWindowColor(\Window, \Theme\WindowTitle)
					
				Case #Color_Back_Cold
					\Theme\ShadeColor[#Cold] = Color
					
				Case #Color_Back_Warm
					\Theme\ShadeColor[#Warm] = Color
					
				Case #Color_Back_Disabled
					
				Case #Color_Text_Cold
					\Theme\TextColor[#Warm] = Color
					
				Case #Color_Text_Warm
					\Theme\TextColor[#Hot] = Color
					
				Case #Color_Text_Disabled
					
			EndSelect
		EndWith
	EndProcedure
	
	Procedure FlatMenu(Flags = #Default)
		Protected Result, *MenuData.FlatMenu, GadgetList = UseGadgetList(0)
		
		If Not MenuWindow
			MenuWindow = WindowID(OpenWindow(#PB_Any, 0, 0, 100, 100, "Menu Parent", #PB_Window_Invisible | #PB_Window_SystemMenu))
		EndIf
		
		AllocateStructureX(*MenuData, FlatMenu)
		
		With *MenuData
			\Window = OpenWindow(#PB_Any, 0, 0, #MenuMinimumWidth, 0, "", #PB_Window_BorderLess | #PB_Window_Invisible, MenuWindow)
			\Canvas = CanvasGadget(#PB_Any, 1, 1, #MenuMinimumWidth, 0, #PB_Canvas_Keyboard)
			\FontID = DefaultFont
			\Width = #MenuMinimumWidth
			\Height = 0
			\State = -1
			\ItemHeight = 30
			\Border = 2
			
			If Flags & #DarkMode
				CopyStructure(DarkTheme, \Theme, Theme)
			Else
				CopyStructure(DefaultTheme, \Theme, Theme)
			EndIf
			
			SetWindowColor(\Window, \Theme\WindowTitle)
			
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
	
	Procedure AddFlatMenuItem(Menu, MenuItem, Position, Text.s, ImageID = 0, SubMenu = 0, Flag = 0) 
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData"), TextWidth
		
		With *MenuData
			
			If Position > -1 And Position < ListSize(\Item())
				SelectElement(\Item(), Position)
				InsertElement(\Item())
			Else
				LastElement(\Item())
				AddElement(\Item())
			EndIf
			
			\Item()\Type = #Item
			\Item()\Text\VAlign = #VAlignCenter
			\Item()\Text\OriginalText = Text
			\Item()\Text\Height = \ItemHeight
			\Item()\Text\Width = 500
			\Item()\Text\FontID = \FontID
			\Item()\Text\Image = ImageID
			\Item()\ID = MenuItem
			\Height + \ItemHeight
			PrepareVectorTextBlock(@\Item()\Text)
			
			If \Item()\Text\RequieredWidth + #MenuMargin + #MenuItemLeftMargin > \Width 
				\Width  = \Item()\Text\RequieredWidth + #MenuMargin + #MenuItemLeftMargin
			EndIf
			
			ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width + 2, \Height + \Border)
			ResizeGadget(\Canvas, #PB_Ignore, #PB_Ignore, \Width, \Height)
			
			FlatMenu_Redraw(*MenuData)
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
			
			ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width + 2, \Height + \Border)
			ResizeGadget(\Canvas, #PB_Ignore, #PB_Ignore, \Width, \Height)
			
			\Height + #MenuSeparatorHeight
			
			FlatMenu_Redraw(*MenuData)
			
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
	
	;{ Tab
	#HList_ItemHeight = 100
	
	Structure Tab_Item
		ImageX.l
		ImageY.l
		imageID.i
		Color.i
		Text.Text
	EndStructure
	
	Structure TabData Extends GadgetData
		ItemWidth.l
		InternalWidth.i
		DragOriginX.l
		DragOriginY.l
		Drag.b
		DragState.b
		List Items.Tab_Item()
	EndStructure
	
	Procedure Tab_ItemRedraw(*Item.Tab_Item, X, Y, Width, Height, State, *Theme.Theme)
		If State = #Hot
			AddPathRoundedBox(X,Y, Width, 10, 4, #Corner_Top)
			VectorSourceColor(*Item\Color)
			FillPath()
			AddPathBox(X, Y + 5, Width, Height - 5)
			VectorSourceColor(*Theme\ShadeColor[#Hot])
			FillPath()
			VectorSourceColor(*Theme\TextColor[#Cold])
			
			Y - 4
		ElseIf State = #Warm
			AddPathRoundedBox(X, Y + 4, Width, Height - 4, 4, #Corner_Top)
			VectorSourceColor(*Theme\ShadeColor[#Warm])
			FillPath()
			VectorSourceColor(*Theme\TextColor[#Cold])
		EndIf
		
		If *Item\imageID
			MovePathCursor(X + *Item\ImageX, Y + *Item\ImageY)
			DrawVectorImage(*Item\imageID)
		EndIf
		
		DrawVectorTextBlock(@*Item\Text, X, Y)
	EndProcedure
	
	Procedure Tab_Redraw(*GadgetData.TabData)
		With *GadgetData
			Protected X = \OriginX + \Border
			
			If ListSize(\Items())
				VectorFont(\TextBock\FontID)
				VectorSourceColor(\ThemeData\TextColor[#Cold])
				
				FirstElement(\Items())
					
				Repeat
					If ListIndex(\Items()) = \State
						Tab_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Hot, \ThemeData)
					ElseIf ListIndex(\Items()) = \MouseState
						Tab_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Warm, \ThemeData)
					Else
						Tab_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Cold, \ThemeData)
					EndIf
					
					X + \ItemWidth
				Until X > \Width Or Not NextElement(\Items())
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure Tab_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.TabData = *this\vt, PreviousHeight
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			PreviousHeight = \Height
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			If \InternalWidth > \Width
				
			Else
				
			EndIf
			
			If PreviousHeight <> \Height
				ForEach \Items()
					\Items()\Text\Height = \Height
					PrepareVectorTextBlock(@\Items()\Text)
				Next
			EndIf
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure Tab_StateFocus(*GadgetData.TabData)
		Protected Result
		
		With *GadgetData
			
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure Tab_EventHandler(*GadgetData.TabData, *Event.Event)
		Protected Redraw, HoverItem
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					HoverItem = Floor(*Event\MouseX / \ItemWidth)
					If HoverItem <> \MouseState 
						If HoverItem < ListSize(\Items())
							\MouseState = HoverItem
							Redraw = #True
						Else
							\MouseState = -1
							Redraw = #True
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \MouseState <> -1
						\MouseState = -1
						Redraw = #True
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \MouseState > - 1 And \MouseState <> \State
						\State = \MouseState
						Redraw = #True
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					EndIf
					;}
				Case #KeyDown ;{
					
					;}
			EndSelect
			If Redraw
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tab_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.TabData = *this\vt, *NewItem.Tab_Item, HBitmap.BITMAP
		With *GadgetData
			
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			*NewItem\Text\OriginalText = PeekS(*Text)
			*NewItem\Text\LineLimit = 1
			*NewItem\Text\FontID = \TextBock\FontID
			*NewItem\Text\Width = \ItemWidth
			*NewItem\Text\Height = Floor(\Height * 0.95)
			*NewItem\Text\VAlign = #VAlignBottom
			*NewItem\Text\HAlign = #HAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			
			*NewItem\imageID = ImageID
			*NewItem\Color = \ThemeData\Special3[#Warm]
			
			If *NewItem\imageID
				GetObject_(*NewItem\imageID, SizeOf(BITMAP), @HBitmap.BITMAP)
				*NewItem\ImageX = (\ItemWidth - HBitmap\bmWidth) * 0.5
				*NewItem\ImageY = (\Height - 10 - HBitmap\bmHeight) * 0.5
			EndIf
			
			\InternalWidth = ListSize(\Items()) * \ItemWidth
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure Tab_RemoveItem(*This.PB_Gadget, Position)
		Protected *GadgetData.TabData = *this\vt
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				DeleteElement(\Items())
				\InternalWidth = ListSize(\Items()) * \ItemWidth
				
				If \State > Position
					\State - 1
				ElseIf \State = Position
					If \State = ListSize(\Items())
						\State - 1
					EndIf
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
				EndIf
				
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tab_CountItem(*This.PB_Gadget)
		Protected *GadgetData.TabData = *this\vt
		
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	Procedure Tab_ClearItems(*This.PB_Gadget)
		
	EndProcedure
	
	; Getters
	Procedure.s Tab_GetItemText(*this.PB_Gadget, Position)
		Protected *GadgetData.TabData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				ProcedureReturn \Items()\Text\OriginalText
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tab_GetItemImage(*this.PB_Gadget, Position)
		Protected *GadgetData.TabData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				ProcedureReturn \Items()\imageID
			EndIf
		EndWith
	EndProcedure
	
	
	; Setters
	Procedure Tab_SetAttribute(*this.PB_Gadget, Attribute, Value)
		Protected *GadgetData.TabData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #Attribute_ItemWidth ;{
					\ItemWidth = Value
					\InternalWidth = ListSize(\Items()) * \ItemWidth
					
					ForEach \Items()
						\Items()\Text\Width = \ItemWidth
						PrepareVectorTextBlock(@\Items()\Text)
					Next
					;}
				Default ;{	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					;}
			EndSelect
		EndWith
		RedrawObject()
	EndProcedure
	
	Procedure Tab_SetItemAttribute(*this.PB_Gadget, Position, Attribute, Value)
		Protected *GadgetData.TabData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				Select Attribute
					Case #Tab_Color
						\Items()\Color = Value
						RedrawObject()
				EndSelect
			EndIf
		EndWith
	EndProcedure
	
	
	Procedure Tab_Meta(*GadgetData.TabData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Tab)
		
		With *GadgetData
			\ItemWidth = Height
			\State = -1
			\MouseState = -1
			\Drag = Bool(Flags & #Drag)
			
			\VT\AddGadgetItem2 = @Tab_AddItem()
			\VT\RemoveGadgetItem = @Tab_RemoveItem()
			\VT\ResizeGadget = @Tab_Resize()
			\VT\SetGadgetAttribute = @Tab_SetAttribute()
			\VT\CountGadgetItems = @Tab_CountItem()
			\VT\GetGadgetItemImage = @Tab_GetItemImage()
			\VT\GetGadgetItemText = @Tab_GetItemText()
			\VT\SetGadgetItemAttribute2 = @Tab_SetItemAttribute()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#KeyDown] = #True
		EndWith
	EndProcedure
	
	Procedure Tab(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.TabData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				If Gadget = #PB_Any
					Gadget = Result
				EndIf
				
				*this = IsGadget(Gadget)
				AllocateStructureX(*GadgetData, TabData)
				CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
				*GadgetData\OriginalVT = *this\VT
				*this\VT = *GadgetData
				
				AllocateStructureX(*ThemeData, Theme)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *ThemeData, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@DefaultTheme, *ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
					Else
						CopyStructure(@DefaultTheme, *ThemeData, Theme)
					EndIf
				EndIf
				
				Tab_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
EndModule























; IDE Options = PureBasic 6.00 LTS (Windows - x64)
; CursorPosition = 302
; FirstLine = 6
; Folding = JAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAACAAAAAAAAAAA+
; EnableXP
; DPIAware