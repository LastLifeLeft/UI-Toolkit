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
		#Border											; Draw a border around the gadget
		#DarkMode										; Use the dark color scheme
		#LightMode										; Use the light color scheme
		#ReOrder										; Allow user to reorder items by dragging them around the gadget. Mutually exclusive with #Drag.
		#Drag											; Enable drag from this gadget. Mutually exclusive with #ReOrder.
		#Editable										; 
		#MultiSelect									; Allow several items to be selected at once (ctrl / shift click), like #PB_ListView_Multiselect
		#Container										; The gadget will behave as a container
		
		; Window flags
		#Window_MinimizeButton
		#Window_CloseButton
		#Window_MaximizeButton
		#Window_Sizable
		#Window_ScreenCentered
		#Window_Invisible
		
		; Special
		#Button_Toggle									; Creates a toggle button: one click pushes it, another will release it.
		#Gadget_Vertical								; scrollbar/trackbar/... is vertical (instead of horizontal, which is the default).
		#TrackBar_ShowState								; Display the numerical state on the trackbar
		#Tree_NoLine
		#Tree_StraightLine
		
		; DoNotUse
		#Gadget_Meta
	EndEnumeration
	
	#Tree_DotLine = 0
	
	#WindowBarHeight = 30
	
	Enumeration 5000 ; Gadget attributes
		#ScrollBar_Minimum
		#ScrollBar_Maximum	
		#ScrollBar_PageLength
		#ScrollBar_ScrollStep
		
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
		#PropertyBox_CheckBox
		#PropertyBox_Font							; PropertyBox row: font picker - opens FontRequester, family in the value text, size/style in the attributes below
		
		#Toolbar_DefaultButton							; ToolBar item: a plain push button (also used when the AddGadgetItem flag is 0)
		#ToolBar_Toggle									; ToolBar item: a sticky toggle button (passed as the AddGadgetItem flag)
		#ToolBar_Separator								; ToolBar item: a separator line
		#ToolBar_ModeButton								; ToolBar item: a split button - the icon side cycles through modes, the chevron side lists them (see ToolBarAddMode)
		
		#Attribute_ItemHeight
		#Attribute_ItemWidth
		#Attribute_CornerRadius
		#Attribute_Border
		#Attribute_TextScale
		#Attribute_TextVerticalAlignment
		#Attribute_TextHorizontalAlignment
		#Attribute_SortItems
		#Attribute_CornerType
		#Attribute_TextSelectionPosition
		#Attribute_TextSelectionLength
		
		#Tab_Color
		
		#TrackBar_Scale
		
		#Attribute_Library_SectionHeight
		#Attribute_Library_ItemWidth
		#Attribute_Tree_ItemDepth
		#Attribute_PropertyBox_FontSize			; #PropertyBox_Font row: point size (read/write)
		#Attribute_PropertyBox_FontStyle		; #PropertyBox_Font row: #PB_Font_* style bits (read/write)
		
		CompilerIf Defined(EnableLayerList, #PB_Module)
			#Attribute_LayerList_Visible			; LayerList item: this row's own eye state (read/write)
			#Attribute_LayerList_EffectiveVisible	; LayerList item: own eye AND the group's, ie. does it show through (read only)
			#Attribute_LayerList_Folded				; LayerList item: group folded, children hidden (read/write, groups only)
			#Attribute_LayerList_IsChild			; LayerList item: #True when the row is a child (read only)
			#Attribute_LayerList_Parent				; LayerList item: list index of the owning group, -1 for a group (read only)
			#Attribute_LayerList_ChildCount			; LayerList item: children held by the group (read only)
		CompilerEndIf
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
		#Corner_TopLeftBottomRight
		#Corner_TopRightBottomLeft
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
		#SubClass_DropHandler
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
		#EventType_ItemTextChange
		
		CompilerIf Defined(EnableLayerList, #PB_Module)
			#EventType_LayerVisibility			; LayerList: a row's eye was clicked - GetGadgetState is that row
			#EventType_LayerFold				; LayerList: a group was folded or unfolded - GetGadgetState is that group
		CompilerEndIf
		
		#EventType_FirstAvailableCustomValue
	EndEnumeration	
	
	Enumeration #PB_Event_FirstCustomValue
		#Event_CloseMenu
		#Event_Drag_Enter
		#Event_Drag_Update
		#Event_Drag_Leave
		#Event_Drag_Finish
		#Event_MenuDeactivated
		
		#Event_FirstAvailableCustomValue
	EndEnumeration
	
	Enumeration ;Gadget Item State
		#Item_State_Untoggled
		#Item_State_Toggled
		#Item_State_Enabled
		#Item_State_Disabled
	EndEnumeration
	
	Structure Event
		EventType.l
		MouseX.l
		MouseY.l
		Param.l
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
		FontScale.i
		HAlign.b
		VAlign.b
		Width.l
		Height.l
		RequiredWidth.w
		RequiredHeight.w
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
	; Utilities
	Declare CurrentWindow()
	
	; Setters
	Declare SetCurrentTheme(*Theme.Theme)
	Declare SetDarkMode(State)								; Enable or disable the dark theme
	Declare SetAccessibilityMode(State)						; Enable or disable accessibility mode. If enabled, gadget falls back on to their default PB version, making them compatible with important features like screen readers or RTL languages.
	Declare SubClassFunction(Gadget, Function, *Address)	; Subclass any gadget function (Works with native pb gadgets too)
	
	; Getters
	Declare GetAccessibilityMode()							; Returns the current accessibility state.
	Declare GetCurrentTheme()								; Returns the current theme address
	
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
	Declare GetWindowContainer(Window)						; The themed window's client container gadget (-1 on the plain fallback)
	Declare.i GetWindowMenuButton(Window, Index)
	
	Declare SetWindowLabel(Window, Text.s)					; Title text, menu-aware; also sets the OS caption
	Declare FlatMenu(Flags = #Default)
	Declare AddFlatMenuItem(Menu, MenuItem, Position, Text.s, ImageID = 0, SubMenu = 0, Flag = 0)
	Declare RemoveFlatMenuItem(Menu, Position)
	Declare SetFlatMenuItemText(Menu, Position, Text.s)
	Declare AddFlatMenuSeparator(Menu, Position)
	Declare ShowFlatMenu(FlatMenu, X = -1, Y = -1)
	Declare SetFlatMenuColor(Menu, ColorType, Color)
	Declare DisableFlatMenuItem(Menu, Position, State)
	
	; Gadgets
	Declare GetGadgetImage(Gadget)
	Declare SetGadgetImage(Gadget, Image)
	Declare GetGadgetItemImage(Gadget, Position)
	Declare StringSetSelection(Gadget, Position, Length)
	
	Declare Button(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare Toggle(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare CheckBox(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLength, Flags = #Default)
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
	Declare String(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
	Declare ColorPicker(Gadget, x, y, Width, Height, Flags = #Default)
	Declare ToolBar(Gadget, x, y, Width, Height, Flags = #Default)
	Declare ToolBarAddMode(Gadget, Item, Text.s, ImageID = 0)	; Add a mode to a #ToolBar_ModeButton item. Returns the mode index, -1 on failure.
	Declare ToolBarGetMode(Gadget, Item)						; Active mode index of a mode button item (-1 if it has no mode yet)
	Declare ToolBarSetMode(Gadget, Item, Mode)					; Set the active mode of a mode button item (does not post a change event)
	
	; Misc
	Declare PrepareVectorTextBlock(*TextData.Text)
	Declare DrawVectorTextBlock(*TextData.Text, X, Y, Alpha = 255)
	Declare Disable(Gadget, State)
	Declare Freeze(Gadget, State)
	Declare AddPathRoundedBox(X, Y, Width, Height, Radius, Type = #Corner_All)
	Declare LoadSvgIcon(FileName.s, Size, Color)
	Declare CatchSvgIcon(*Buffer, BufferLength, Size, Color)
	Declare DragPreviewVisible(State)						; Show/hide the floating drag preview mid-drag (in-place preview takes over)
	Declare EditGadgetItemText(Gadget)
	Declare ToggleGadgetItemVisibility(Gadget)				; Flip the focused row's eye, as clicking it does
	
	; Drag & drop
	Declare AdvancedDragPrivate(Type, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
	Declare AdvancedDragFiles(File.s, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
	Declare AdvancedDragText(Text.s, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
	Declare AdvancedDragImage(ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
	Declare RegisterDropCallback(*Callback)
	Declare.i AdvancedDragActive()
	
	; The Weird
	Declare.i KeyboardClaimed()
	Declare ForwardKeyToFocus(VirtualKey)
	
	; TimeLine
	CompilerIf Defined(EnableTimeline, #PB_Module)
		Declare TimeLine(Gadget, x, y, Width, Height, Flags = #Default)
		Declare AddMediaBlock(Gadget, Line, Position, Duration, Type, Text.s, *Data)
	CompilerEndIf
	
	; LayerList
	CompilerIf Defined(EnableLayerList, #PB_Module)
		Declare LayerList(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
	CompilerEndIf
	
	; Linux-only verification hook (Phase 3 GTK destroy cleanup). Reports current
	; size of the per-widget property map; tests use it to assert cleanup ran.
	CompilerIf #PB_Compiler_OS <> #PB_OS_Windows
		Declare _Linux_PropMapSize()
	CompilerEndIf
	
	; Debug builds only: Debug-print every UITK allocation still alive and return the count.
	; Call it after closing everything to catch library-side leaks.
	CompilerIf #PB_Compiler_Debugger
		Declare DumpAllocations()
	CompilerEndIf
	;}
EndDeclareModule

Module UITK
	EnableExplicit
	
	;{ Cross-platform stubs — make the Win32-heavy parts of the module compile on Linux.
	CompilerIf #PB_Compiler_OS <> #PB_OS_Windows
		; ThemedWindow is referenced by shared per-gadget theme-inheritance code that
		; does `Protected *WindowData.ThemedWindow = GetProp_(...)` and then reads
		; \Theme. On Linux UITK::Window uses native chrome (Phase 4-final) so we
		; never populate this struct — callers see a NULL pointer and fall through
		; to *DefaultTheme. The Theme field is kept so the struct shape stays valid
		; if a future enhancement decides to attach per-window theme overrides.
		Structure ThemedWindow
			Theme.Theme
		EndStructure
		; Per-widget key/value storage. On Windows the Win32 GetProp_/SetProp_ store on
		; the HWND itself; on Linux we back it with a process-wide PB Map keyed on
		; "<widget>:<name>". A GTK "destroy" signal handler walks the map and removes
		; the matching entries when the widget goes away, so accumulated state doesn't
		; leak for the lifetime of the process. UITK_CleanupRegistered tracks which
		; widgets we've already wired the destroy signal on so we only do it once each.
		Global NewMap UITK_PropMap.i()
		Global NewMap UITK_CleanupRegistered.b()
		; Marks UITK_PropMap entries whose value is an allocation we own and must
		; FreeStructure when the owning widget is destroyed. Most SetProp_ callers
		; just store opaque pointers (PB cleans up the targets via the gadget vtable);
		; only a handful of places allocate cross-widget state — UITK::Window's
		; per-window ThemedWindow being the canonical example.
		Global NewMap UITK_PropOwned.b()
		
		ImportC ""
			; Minimal GTK surface — signal connection for our destroy hook and the
			; two GdkPixbuf accessors used by UITK_GetImageSize. PB already links
			; libgtk-3 / libgdk-3 / libgobject-2 / libgdk_pixbuf-2.0 transitively,
			; so we don't need to name a .so.
			g_signal_connect_data(instance.i, detailed_signal.p-ascii, c_handler.i, user_data.i, destroy_data.i, connect_flags.l)
			gdk_pixbuf_get_width(pixbuf.i)
			gdk_pixbuf_get_height(pixbuf.i)
		EndImport
		
		ProcedureC UITK_PropCleanup_Handler(*widget, *user_data)
			Protected prefix.s = Hex(*widget) + ":"
			Protected prefixLen = Len(prefix)
			Protected key.s, ptr.i
			; Collect keys first; deleting while iterating ForEach a Map is unsafe in PB.
			NewList toDrop.s()
			ForEach UITK_PropMap()
				key = MapKey(UITK_PropMap())
				If Left(key, prefixLen) = prefix
					; FreeStructure any value we own before removing the map entry.
					If FindMapElement(UITK_PropOwned(), key)
						ptr = UITK_PropMap()
						If ptr : FreeStructure(ptr) : EndIf
						DeleteMapElement(UITK_PropOwned())
					EndIf
					AddElement(toDrop()) : toDrop() = key
				EndIf
			Next
			ForEach toDrop()
				DeleteMapElement(UITK_PropMap(), toDrop())
			Next
			DeleteMapElement(UITK_CleanupRegistered(), Hex(*widget))
		EndProcedure
		
		Procedure UITK_EnsureCleanupHook(hWnd)
			; Connect "destroy" once per widget; subsequent SetProp_ calls on the same
			; widget find it in the registry and skip the (idempotent but wasteful) work.
			If hWnd And Not FindMapElement(UITK_CleanupRegistered(), Hex(hWnd))
				UITK_CleanupRegistered(Hex(hWnd)) = #True
				g_signal_connect_data(hWnd, "destroy", @UITK_PropCleanup_Handler(), 0, 0, 0)
			EndIf
		EndProcedure
		
		Procedure GetProp_(hWnd, name.s)
			Protected key.s = Hex(hWnd) + ":" + name
			If FindMapElement(UITK_PropMap(), key)
				ProcedureReturn UITK_PropMap()
			EndIf
			ProcedureReturn 0
		EndProcedure
		
		Procedure SetProp_(hWnd, name.s, value)
			UITK_PropMap(Hex(hWnd) + ":" + name) = value
			UITK_EnsureCleanupHook(hWnd)
			ProcedureReturn 1
		EndProcedure
		
		; SetOwnedProp_: same as SetProp_ but also marks the value as a UITK
		; AllocateStructureX-allocated pointer. When the widget's destroy signal
		; fires, UITK_PropCleanup_Handler will FreeStructure the pointer before
		; dropping the map entry — fixing what would otherwise be a per-widget leak.
		Procedure SetOwnedProp_(hWnd, name.s, *ptr)
			Protected key.s = Hex(hWnd) + ":" + name
			UITK_PropMap(key)  = *ptr
			UITK_PropOwned(key) = #True
			UITK_EnsureCleanupHook(hWnd)
			ProcedureReturn 1
		EndProcedure
		
		Procedure RemoveProp_(hWnd, name.s)
			Protected key.s = Hex(hWnd) + ":" + name
			Protected old = 0
			If FindMapElement(UITK_PropMap(), key)
				old = UITK_PropMap()
				DeleteMapElement(UITK_PropMap())
			EndIf
			ProcedureReturn old
		EndProcedure
		
		Procedure _Linux_PropMapSize()
			; Internal: verification hook for the Phase-3 cleanup test. Reports the
			; current size of UITK_PropMap so tests can assert it drops to zero after
			; the GTK destroy signal fires. Not part of the public API.
			ProcedureReturn MapSize(UITK_PropMap())
		EndProcedure
		Procedure SetWindowLongPtr_(hWnd, idx, val) : ProcedureReturn 0 : EndProcedure
		Procedure GetWindowLongPtr_(hWnd, idx)      : ProcedureReturn 0 : EndProcedure
		Procedure CallWindowProc_(*proc, hWnd, msg, wp, lp) : ProcedureReturn 0 : EndProcedure
		Procedure SendMessage_(hWnd, msg, wp, lp)   : ProcedureReturn 0 : EndProcedure
		Procedure PostMessage_(hWnd, msg, wp, lp)   : ProcedureReturn 0 : EndProcedure
		Procedure IsZoomed_(hWnd)                   : ProcedureReturn 0 : EndProcedure
		Procedure SetWindowPos_(hWnd, after, x, y, w, h, flags) : ProcedureReturn 0 : EndProcedure
		Procedure GetWindowRect_(hWnd, *rect)       : ProcedureReturn 0 : EndProcedure
		Procedure SetClassLongPtr_(hWnd, idx, val)  : ProcedureReturn 0 : EndProcedure
		Procedure GetSystemMetrics_(idx)            : ProcedureReturn 0 : EndProcedure
		Procedure MonitorFromWindow_(hWnd, flag)    : ProcedureReturn 0 : EndProcedure
		Procedure GetMonitorInfo_(hMon, *mi)        : ProcedureReturn 0 : EndProcedure
		Procedure GetModuleHandle_(name.s)          : ProcedureReturn 0 : EndProcedure
		Procedure SetBkMode_(hdc, mode)             : ProcedureReturn 0 : EndProcedure
		Procedure CreatePatternBrush_(hbm)          : ProcedureReturn 0 : EndProcedure
		Procedure DeleteObject_(h)                  : ProcedureReturn 0 : EndProcedure
		Procedure SetWindowsHookEx_(t, *fn, h, tid) : ProcedureReturn 0 : EndProcedure
		Procedure UnhookWindowsHookEx_(h)           : ProcedureReturn 0 : EndProcedure
		Procedure CallNextHookEx_(h, code, wp, lp)  : ProcedureReturn 0 : EndProcedure
		Procedure SetLayeredWindowAttributes_(hWnd, key, alpha, flags) : ProcedureReturn 0 : EndProcedure
		Procedure GetObject_(h, size, *out)         : ProcedureReturn 0 : EndProcedure
		; Win32 constants used across the module — all zero on Linux (the call sites no-op anyway).
		#SWP_NOSIZE        = 0
		#SWP_NOMOVE        = 0
		#SWP_NOZORDER      = 0
		#SWP_NOREDRAW      = 0
		#SWP_FRAMECHANGED  = 0
		#GWL_WNDPROC       = 0
		#GWL_EXSTYLE       = 0
		#GCL_HBRBACKGROUND = 0
		#WS_EX_LAYERED     = 0
		#WS_OVERLAPPEDWINDOW = 0
		#WS_SYSMENU        = 0
		#LWA_ALPHA         = 0
		#SM_CXSIZEFRAME    = 0
		#SM_CYSIZEFRAME    = 0
		#SM_CXPADDEDBORDER = 0
		#WM_NCHITTEST      = 0
		#WM_NCCALCSIZE     = 0
		#WM_NCACTIVATE     = 0
		#WM_NCDESTROY      = 0
		#WM_CTLCOLORSTATIC = 0
		#WM_CTLCOLORBTN    = 0
		#WM_GETMINMAXINFO  = 0
		#WM_SIZE           = 0
		; HT* values mirror the Win32 ones. They never reach a real Win32 API on Linux
		; (every consumer is a stubbed function), but UITK uses them as its own internal
		; edge identifiers, so they MUST be distinct and non-zero — otherwise
		; Linux_HTToPBCursor's Select picks the first case for everything and
		; Linux_TitleBar_LeftButtonDown's `If *WindowData\CurrentEdge` is always false.
		#HTTRANSPARENT     = -1
		#HTCLIENT          = 1
		#HTCAPTION         = 2
		#HTLEFT            = 10
		#HTRIGHT           = 11
		#HTTOP             = 12
		#HTTOPLEFT         = 13
		#HTTOPRIGHT        = 14
		#HTBOTTOM          = 15
		#HTBOTTOMLEFT      = 16
		#HTBOTTOMRIGHT     = 17
		#WH_MOUSE_LL       = 0
		#NUL               = 0
		#MONITOR_DEFAULTTONEAREST = 0
		; BITMAP stub so existing per-gadget code that declares `HBitmap.BITMAP` still compiles.
		Structure BITMAP
			bmType.l
			bmWidth.l
			bmHeight.l
			bmWidthBytes.l
			bmPlanes.w
			bmBitsPixel.w
			bmBits.i
		EndStructure
	CompilerEndIf
	;}
	
	;{ Macro
	Macro InitializeObject(GadgetType)
		*GadgetData\Gadget = Gadget
		*GadgetData\this = IsGadget(Gadget)
		*GadgetData\ParentWindow = CurrentWindow()
		
		*GadgetData\Width = Width
		*GadgetData\Height = Height
		
		*GadgetData\Border = Bool(Flags & #Border)
		
		*GadgetData\Redraw = @GadgetType#_Redraw()
		
		*GadgetData\DropHover = -1
		
		If Flags & #HAlignCenter
			*GadgetData\TextBlock\HAlign = #HAlignCenter
		ElseIf Flags & #HAlignRight
			*GadgetData\TextBlock\HAlign = #HAlignRight
		Else
			*GadgetData\TextBlock\HAlign = #HAlignLeft
		EndIf
		
		If Flags & #VAlignCenter
			*GadgetData\TextBlock\VAlign = #VAlignCenter
		ElseIf Flags & #VAlignBottom
			*GadgetData\TextBlock\VAlign = #VAlignBottom
		Else
			*GadgetData\TextBlock\VAlign = #VAlignTop
		EndIf
		
		*GadgetData\EventHandler = @GadgetType#_EventHandler()
		*GadgetData\VT\FreeGadget = @Default_FreeGadget()
		*GadgetData\VT\ResizeGadget = @Default_ResizeGadget()
		
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
		
		*GadgetData\TextBlock\LineLimit = -1
		*GadgetData\TextBlock\FontID = DefaultFont
		
		*GadgetData\Enabled = #True
		
		If Gadget = -1 Or Flags & #Gadget_Meta
			*GadgetData\MetaGadget = #True
			*GadgetData\OriginX = X
			*GadgetData\OriginY = Y
		Else
			BindGadgetEvent(Gadget, *GadgetData\DefaultEventHandler)
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
	
	; Shared tail of every gadget constructor: resolve #PB_Any, swap the canvas's
	; vtable for the gadget's own GadgetDataType, resolve the theme (explicit flag >
	; owning themed window > current default) and register the OS handle so the
	; global drop callback can route back to this gadget.
	; Expects the constructor's locals: Result, Gadget, Flags, *this, *GadgetData, *ThemeData.
	Macro CreateGadgetObject(GadgetDataType)
		If Gadget = #PB_Any
			Gadget = Result
		EndIf
		
		*this = IsGadget(Gadget)
		AllocateStructureX(*GadgetData, GadgetDataType)
		CopyMemory(*this\vt, *GadgetData\vt, SizeOf(GadgetVT))
		*GadgetData\OriginalVT = *this\VT
		*this\VT = *GadgetData
		
		AllocateStructureX(*ThemeData, Theme)
		
		If Flags & #DarkMode
			CopyStructure(@DarkTheme, *ThemeData, Theme)
		ElseIf Flags & #LightMode
			CopyStructure(@LightTheme, *ThemeData, Theme)
		Else
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
			If *WindowData
				CopyStructure(@*WindowData\Theme, *ThemeData, Theme)
			Else
				CopyStructure(*DefaultTheme, *ThemeData, Theme)
			EndIf
		EndIf
		
		AddMapElement(GadgetHandler(), Str(GadgetID(Gadget)))
		GadgetHandler() = Gadget
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
	
	; SetAlpha — pack a 24-bit RGB color and an 8-bit alpha into PB's 32-bit ARGB
	; format (alpha in the high byte). PB's Red/Green/Blue/Alpha accessors and
	; RGB/RGBA constructors use the same byte order across Windows and Linux, so
	; we use the same macro on both platforms. The old Linux branch produced
	; RRGGBBAA instead of AABBGGRR — every theme color round-tripped to garbage,
	; which is what made the container render bright red on the Linux port.
	Macro SetAlpha(Color, Alpha)
		(Alpha << 24) + Color
	EndMacro
	
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
		
		Procedure DumpAllocations()
			ForEach Memories()
				Debug "UITK leak: " + Str(Memories()\Size) + " bytes, allocated at " + GetFilePart(Memories()\File) + ":" + Str(Memories()\Line)
			Next
			ProcedureReturn ListSize(Memories())
		EndProcedure
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
				*DropHandler
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
			Prototype GetAttribute(*This, Attribute)
			Prototype SetAttribute(*This, Attribute, Value)
			; Mirrors PB 6.40's PB_GadgetVT (sdk/c/PureLibraries/Gadget/Gadget.h).
			; Field order MUST match; PB dispatches by offset, not by name.
			; UITK extensions go strictly AFTER PB's last field.
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
				*ClearGadgetItemList    ; PB header calls this ClearGadgetItems; name diverges from PB but offset is correct
				*ResizeGadget
				*CountGadgetItems
				*GetGadgetItemState
				*SetGadgetItemState
				*GetGadgetItemText
				*SetGadgetItemText
				*SetGadgetFont
				*OpenGadgetList2
				*AddGadgetColumn
				*GetGadgetAttribute.GetAttribute
				*SetGadgetAttribute.SetAttribute
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
				; ---- UITK private extensions, never dispatched by PB ----
				; HideGadget is NOT in PB's Linux vtable (PB calls gtk_widget_hide directly).
				; The other three are needed by InitializeObject() and SubClassFunction shared code.
				*HideGadget
				*GetRequiredSize
				*GetGadgetItemImage
				*DropHandler
			EndStructure
			
			; Mirrors PB 6.40's PB_GadgetStructure. Adding RootWindowID and the full Data[6]
			; so any future cast through *this\UserData or *this\Daten reads the right bytes.
			Structure PB_Gadget
				*Gadget
				*GadgetContainer
				*vt.GadgetVT
				RootWindowID.i
				UserData.i
				Daten.i[6]
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
	
	Prototype Redraw(*GadgetData)
	Prototype EventHandler(*this.PB_Gadget, *Event.Event)
	
	Structure GadgetData
		VT.GadgetVT ;Must be the first element of this structure!
		*OriginalVT.GadgetVT
		*this.PB_Gadget
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
		
		*ThemeData.Theme
		
		Redraw.Redraw
		EventHandler.EventHandler
		TextBlock.Text
		ParentWindow.i
		
		Freeze.b
		Enabled.b
		
		*DefaultEventHandler
		
		DropHover.i
	EndStructure
	
	Enumeration ;Menu types
		#Item
		#Separator
	EndEnumeration
	
	Structure MenuItem
		Type.b
		Text.Text
		Shortcut.Text		; the key column, right-aligned against the menu's edge; empty text = no shortcut
		Icon.i
		ID.i
		Disabled.b
		SubMenu.i			; window of another FlatMenu, unfolded beside this entry on hover; 0 = plain item
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
		ParentMenu.i		; menu this one is currently unfolded from, 0 when root / standalone
		OpenSubMenu.i		; currently unfolded child menu, 0 when none
		Theme.Theme
		*HotItem
		List Item.MenuItem()
	EndStructure
	
	Global MenuWindow
	Global FlatMenuPressed	; the FlatMenu whose canvas took a press whose click is still to come
	Global AccessibilityMode = #False
	Global LightTheme.Theme, DarkTheme.Theme, *DefaultTheme.Theme
	Global DefaultFont = FontID(LoadFont(#PB_Any, "Segoe UI", 9, #PB_Font_HighQuality))
	Global BoldFont = FontID(LoadFont(#PB_Any, "Segoe UI Black", 7, #PB_Font_HighQuality))
	Global IconFont = FontID(LoadFont(#PB_Any, "Segoe MDL2 Assets", 10, #PB_Font_HighQuality))
	Global NewMap GadgetHandler()
	
	Prototype ItemRedraw(*Item, X, Y, Width, Height, State, *Theme.Theme)
	
	#Drag_Distance = 7
	;}
	
	;{ Default themes
	With LightTheme 
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
		\ShadeColor[#Disabled]	= SetAlpha(FixColor($F0F0F0), 255)
		
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
		\ShadeColor[#Disabled]	= SetAlpha(FixColor($36393F), 255)
		
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
	
	*DefaultTheme = @LightTheme
	
	Procedure SetDarkMode(State)
		If State = #True
			*DefaultTheme = @DarkTheme
		Else
			*DefaultTheme = @LightTheme
		EndIf
	EndProcedure
	
	Procedure GetCurrentTheme()
		ProcedureReturn *DefaultTheme
	EndProcedure
	
	Procedure SetCurrentTheme(*Theme.Theme)
		*DefaultTheme = *Theme
	EndProcedure
	;}
	
	;General:
	;{ Shared
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		Import ""
			PB_Object_EnumerateStart(Object)
			PB_Object_EnumerateNext(Object,*ID.Integer)
			PB_Object_EnumerateAbort(Object)
			PB_Window_Objects.i
		EndImport
	CompilerElse
		ImportC ""
			PB_Object_EnumerateStart(Object)
			PB_Object_EnumerateNext(Object,*ID.Integer)
			PB_Object_EnumerateAbort(Object)
			PB_Window_Objects.i
		EndImport
	CompilerEndIf
	
	;Declaration
	Declare RemoveGadgetTimers(*Gadget)	; body lives in the Timer section; used by the Free procedures above it
	Declare.s FlatMenu_NativeLabel(*Item.MenuItem)	; …and this one in the Menu section, used by AddWindowMenu above it
	
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
	
	Procedure.f MinF(A.f, B.f)
		If A < B
			ProcedureReturn A
		EndIf
		ProcedureReturn B
	EndProcedure
	
	Procedure.f MaxF(A.f, B.f)
		If A > B
			ProcedureReturn A
		EndIf
		ProcedureReturn B
	EndProcedure
	
	; Misc
	Procedure CurrentWindow()
		Protected Window = -1
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
	
	Procedure AddPathRoundedBox(X, Y, Width, Height, Radius, Type = #Corner_All)
		
		Select Type
			Case #Corner_All
				MovePathCursor(X, Y + Radius + 1)
				AddPathArc(X, Y + Height, X + Width, Y + Height, Radius)
				AddPathArc(X + Width, Y + Height, X + Width, Y, Radius)
				AddPathArc(X + Width, Y, X, Y, Radius)
				AddPathArc(X, Y, X, Y + Height, Radius)
				ClosePath()
				
			Case #Corner_Top
				MovePathCursor(X, Y + Height)
				AddPathArc(X, Y, X + Width,Y, Radius)
				AddPathArc(X + Width, Y, X + Width, Y + Height, Radius)
				AddPathLine(X + Width, Y + Height)
				ClosePath()
				
			Case #Corner_Bottom
				MovePathCursor(X, Y)
				AddPathLine(X + Width, Y)
				AddPathArc(X + Width, Y + Height, X, Y + Height, Radius)
				AddPathArc(X, Y + Height, X, Y, Radius)
				ClosePath()
				
			Case #Corner_Left
				MovePathCursor(X + Width, Y + Height)
				AddPathArc(X, Y + Height, X, Y, Radius)
				AddPathArc(X, Y, X + Width, Y, Radius)
				AddPathLine(X + Width, Y)
				ClosePath()
				
			Case #Corner_Right
				MovePathCursor(X, Y)
				AddPathArc(X + Width, Y, X + Width, Y + Height, Radius)
				AddPathArc(X + Width, Y + Height, X, Y + Height, Radius)
				AddPathLine(X, Y + Height)
				ClosePath()
				
			Case #Corner_TopLeft
				MovePathCursor(X, Y + Height)
				AddPathArc(X, Y, X + Width, Y, Radius)
				AddPathLine(X + Width, Y)
				AddPathLine(X + Width, Y + Height)
				AddPathLine(X, Y + Height)
				ClosePath()
				
			Case #Corner_TopRight
				MovePathCursor(X, Y + Height)
				AddPathLine(X, Y)
				AddPathArc(X + Width, Y, X + Width, Y + Height, Radius)
				AddPathLine(X + Width, Y + Height)
				ClosePath()
				
			Case #Corner_BottomLeft
				MovePathCursor(X, Y)
				AddPathLine(X + Width, Y)
				AddPathLine(X + Width, Y + Height)
				AddPathArc(X, Y + Height, X, Y, Radius)
				ClosePath()
				
			Case #Corner_BottomRight
				MovePathCursor(X, Y)
				AddPathLine(X + Width, Y)
				AddPathArc(X + Width, Y + Height, X, Y + Height, Radius)
				AddPathLine(X, Y + Height)
				ClosePath()
				
			Case #Corner_TopLeftBottomRight
				MovePathCursor(X, Y + Height)
				AddPathArc(X, Y, X + Width, Y, Radius)
				AddPathLine(X + Width, Y)
				AddPathArc(X + Width, Y + Height, X, Y + Height, Radius)
				ClosePath()
				
			Case #Corner_TopRightBottomLeft
				MovePathCursor(X, Y)
				AddPathArc(X + Width, Y, X + Width, Y + Height, Radius)
				AddPathLine(X + Width, Y + Height)
				AddPathArc(X, Y + Height, X, Y, Radius)
				ClosePath()
				
		EndSelect
	EndProcedure
	
	; Cross-platform image-dimension lookup. Replaces the Win32 BITMAP+GetObject_ pattern.
	; ImageID is whatever PB returns from ImageID(): HBITMAP on Windows, GdkPixbuf* on Linux.
	Structure UITK_BitmapInfo
		bmWidth.l
		bmHeight.l
	EndStructure
	
	; gdk_pixbuf_get_width/height moved into the consolidated Linux ImportC at the top
	; of Module UITK (alongside g_signal_connect_data and the Phase-4 GTK surface).
	
	Procedure UITK_GetImageSize(ImageHandle, *bmp.UITK_BitmapInfo)
		*bmp\bmWidth  = 0
		*bmp\bmHeight = 0
		If Not ImageHandle : ProcedureReturn : EndIf
		CompilerIf #PB_Compiler_OS = #PB_OS_Windows
			Protected wbmp.BITMAP
			GetObject_(ImageHandle, SizeOf(BITMAP), @wbmp)
			*bmp\bmWidth  = wbmp\bmWidth
			*bmp\bmHeight = wbmp\bmHeight
		CompilerElse
			; ImageID on Linux is a GdkPixbuf*
			*bmp\bmWidth  = gdk_pixbuf_get_width(ImageHandle)
			*bmp\bmHeight = gdk_pixbuf_get_height(ImageHandle)
		CompilerEndIf
	EndProcedure
	
	Procedure RenderSvgIcon(Svg.s, Size, Color)
		Protected Result, Pos, ViewBox.s, Path.s
		Protected VbX.f, VbY.f, VbW.f = 24, VbH.f = 24
		
		If Svg
			; viewBox="minX minY width height" - Material Symbols use "0 -960 960 960", older Material Icons "0 0 24 24".
			Pos = FindString(Svg, "viewBox=" + Chr(34))
			If Pos
				ViewBox = ReplaceString(StringField(Mid(Svg, Pos + 9), 1, Chr(34)), ",", " ")
				VbX = ValF(StringField(ViewBox, 1, " "))
				VbY = ValF(StringField(ViewBox, 2, " "))
				VbW = ValF(StringField(ViewBox, 3, " "))
				VbH = ValF(StringField(ViewBox, 4, " "))
			EndIf
			
			If VbW > 0 And VbH > 0
				If Alpha(Color) = 0
					Color = SetAlpha(Color, 255)
				EndIf
				
				Result = CreateImage(#PB_Any, Size, Size, 32, #PB_Image_Transparent)
				If Result And StartVectorDrawing(ImageVectorOutput(Result))
					ScaleCoordinates(Size / VbW, Size / VbH)
					TranslateCoordinates(-VbX, -VbY)
					
					Pos = FindString(Svg, " d=" + Chr(34))
					While Pos
						Path = StringField(Mid(Svg, Pos + 4), 1, Chr(34))
						AddPathSegments(Path)
						Pos = FindString(Svg, " d=" + Chr(34), Pos + Len(Path) + 4)
					Wend
					
					VectorSourceColor(Color)
					FillPath(#PB_Path_Winding)
					StopVectorDrawing()
				ElseIf Result
					FreeImage(Result)
					Result = 0
				EndIf
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure LoadSvgIcon(FileName.s, Size, Color)
		Protected File = ReadFile(#PB_Any, FileName), Svg.s
		
		If File
			Svg = ReadString(File, #PB_UTF8 | #PB_File_IgnoreEOL)
			CloseFile(File)
		EndIf
		
		ProcedureReturn RenderSvgIcon(Svg, Size, Color)
	EndProcedure
	
	Procedure CatchSvgIcon(*Buffer, BufferLength, Size, Color)
		If *Buffer
			ProcedureReturn RenderSvgIcon(PeekS(*Buffer, BufferLength, #PB_UTF8 | #PB_ByteLength), Size, Color)
		EndIf
	EndProcedure
	
	; Shared scratch surface for text measurement: resize paths re-prepare every item's
	; text block, so a create/free pair per call added up to hundreds of image
	; allocations per resize. Created lazily, lives for the program.
	Global MeasuringImage
	
	Procedure PrepareVectorTextBlock(*TextData.Text)
		Protected String.s, Word.s, NewList StringList.s(), Loop, Count, TextHeight, MaxLine, Width, FinalWidth, TextWidth, LineCount, HBitmap.UITK_BitmapInfo
		
		*TextData\RequiredHeight = 0
		*TextData\RequiredWidth = 0
		*TextData\Text = ""
		
		String = ReplaceString(*TextData\OriginalText, #CRLF$, #CR$)
		String = ReplaceString(String, #LF$, #CR$)
		
		Count = CountString(String, #CR$) + 1
		
		If Not IsImage(MeasuringImage)
			MeasuringImage = CreateImage(#PB_Any, 10, 19)
		EndIf
		StartVectorDrawing(ImageVectorOutput(MeasuringImage))
		If *TextData\FontScale
			VectorFont(*TextData\FontID, *TextData\FontScale)
		Else
			VectorFont(*TextData\FontID)
		EndIf
		TextHeight = VectorTextHeight("a")
		MaxLine = Floor(*TextData\Height / TextHeight)
		
		*TextData\RequiredHeight = TextHeight * Count
		
		For Loop = 1 To Count
			AddElement(StringList())
			StringList() = Trim(StringField(String, Loop, #CR$))
			TextWidth = VectorTextWidth(StringList())
			If TextWidth > *TextData\RequiredWidth
				*TextData\RequiredWidth = TextWidth
			EndIf
		Next
		
		If *TextData\Image
			UITK_GetImageSize(*TextData\Image, @HBitmap)
			If Trim(*TextData\OriginalText) <> ""		; the margin is the gap to the text; an icon-only
				HBitmap\bmWidth + #TextBlock_ImageMargin; block has none, so don't let it push the image off-centre
			EndIf
			*TextData\RequiredWidth + HBitmap\bmWidth
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
			*TextData\TextY = (*TextData\Height - LineCount * TextHeight) * 0.55 - 2
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
		
		*TextData\RequiredWidth + 1
		
		StopVectorDrawing()
	EndProcedure
	
	Procedure DrawVectorTextBlock(*TextData.Text, X, Y, Alpha = 255)
		MovePathCursor(X + *TextData\TextX, Y + *TextData\TextY, #PB_Path_Default)
		
		If *TextData\FontScale
			VectorFont(*TextData\FontID, *TextData\FontScale)
		Else
			VectorFont(*TextData\FontID)
		EndIf
		
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
	
	Procedure EditGadgetItemText(Gadget)
		Protected Event.Event, *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		SetActiveGadget(Gadget)
		Event\EventType = #KeyDown
		Event\Param = #PB_Shortcut_F2
		*GadgetData\EventHandler(*GadgetData, Event)
	EndProcedure
	
	; Flip the focused row's eye, exactly as clicking it does - the gadget maps
	; Space to that, so this drives the real path rather than a copy of it.
	Procedure ToggleGadgetItemVisibility(Gadget)
		Protected Event.Event, *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		Event\EventType = #KeyDown
		Event\Param = #PB_Shortcut_Space
		*GadgetData\EventHandler(*GadgetData, Event)
	EndProcedure
	
	; Default functions
	; #Color_* constant -> byte offset of the matching slot inside a Theme structure.
	; One shared table instead of four hand-written 30-case Selects (gadget / window x get / set).
	Global NewMap ThemeColorOffset.i()
	
	Macro MapThemeColorRow(ColorConstant, Field)
		ThemeColorOffset(Str(ColorConstant#_Cold))     = OffsetOf(Theme\Field) + #Cold * SizeOf(Long)
		ThemeColorOffset(Str(ColorConstant#_Warm))     = OffsetOf(Theme\Field) + #Warm * SizeOf(Long)
		ThemeColorOffset(Str(ColorConstant#_Hot))      = OffsetOf(Theme\Field) + #Hot * SizeOf(Long)
		ThemeColorOffset(Str(ColorConstant#_Disabled)) = OffsetOf(Theme\Field) + #Disabled * SizeOf(Long)
	EndMacro
	
	MapThemeColorRow(#Color_Back, BackColor)
	MapThemeColorRow(#Color_Text, TextColor)
	MapThemeColorRow(#Color_Shade, ShadeColor)
	MapThemeColorRow(#Color_Line, LineColor)
	MapThemeColorRow(#Color_Special1, Special1)
	MapThemeColorRow(#Color_Special2, Special2)
	MapThemeColorRow(#Color_Special3, Special3)
	ThemeColorOffset(Str(#Color_Parent))       = OffsetOf(Theme\WindowColor)
	ThemeColorOffset(Str(#Color_WindowBorder)) = OffsetOf(Theme\WindowTitle)
	
	; PB's canvas events arrive in three contiguous #PB_EventType_* blocks (clicks,
	; focus, everything else), each in the same relative order as the ordered #Event
	; enum - asserted here at compile time, so a PB layout change fails loudly.
	CompilerIf #PB_EventType_RightDoubleClick <> #PB_EventType_LeftClick + (#RightDoubleClick - #LeftClick) Or #PB_EventType_LostFocus <> #PB_EventType_Focus + 1 Or #PB_EventType_MouseWheel <> #PB_EventType_MouseEnter + (#MouseWheel - #MouseEnter) Or #PB_EventType_Input <> #PB_EventType_MouseEnter + (#Input - #MouseEnter)
		CompilerError "PB's canvas #PB_EventType_* layout changed - review Default_EventHandle's range translation."
	CompilerEndIf
	
	Procedure Default_EventHandle()
		Protected Event.Event, *this.PB_Gadget = IsGadget(EventGadget()), *GadgetData.GadgetData = *this\vt
		Protected PBType = EventType()
		
		If Not *GadgetData\Enabled
			ProcedureReturn
		EndIf
		
		; Translate the PB event to our 0-based #Event constant, block by block
		Select PBType
			Case #PB_EventType_LeftClick To #PB_EventType_RightDoubleClick
				Event\EventType = #LeftClick + PBType - #PB_EventType_LeftClick
			Case #PB_EventType_Focus, #PB_EventType_LostFocus
				Event\EventType = #Focus + PBType - #PB_EventType_Focus
			Case #PB_EventType_Resize
				Event\EventType = #Resize
			Case #PB_EventType_MouseEnter To #PB_EventType_Input
				Event\EventType = #MouseEnter + PBType - #PB_EventType_MouseEnter
			Default
				ProcedureReturn
		EndSelect
		
		If Not *GadgetData\SupportedEvent[Event\EventType]
			ProcedureReturn
		EndIf
		
		; Payload, for the events that carry one
		Select Event\EventType
			Case #KeyDown, #RightButtonDown
				Event\Param = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_Key)
			Case #Input
				Event\Param = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_Input)
			Case #MouseWheel
				Event\Param = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_WheelDelta)
		EndSelect
		
		; Mouse position, except for the events that have none
		Select Event\EventType
			Case #Focus, #LostFocus, #KeyDown, #KeyUp, #Input, #Resize
			Default
				Event\MouseX = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseX)
				Event\MouseY = *GadgetData\OriginalVT\GetGadgetAttribute(*this, #PB_Canvas_MouseY)
		EndSelect
		
		*GadgetData\EventHandler(*GadgetData, Event)
	EndProcedure
	
	Procedure Default_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		
		DeleteMapElement(GadgetHandler(), Str(GadgetID(*GadgetData\Gadget)))
		RemoveGadgetTimers(*GadgetData)
		
		If *GadgetData\DefaultEventHandler
			UnbindGadgetEvent(*GadgetData\Gadget, *GadgetData\DefaultEventHandler)
		EndIf
		
		*this\vt = *GadgetData\OriginalVT
		FreeStructureX(*GadgetData\ThemeData)	; every constructor allocates the gadget's own theme copy
		FreeStructureX(*GadgetData)
		
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
			
			*GadgetData\TextBlock\Width = \Width 
			*GadgetData\TextBlock\Height = \Height 
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			RedrawObject()
		EndWith
	EndProcedure
	
	; Getters
	Procedure Default_GetFont(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\TextBlock\FontID
	EndProcedure
	
	Procedure Default_GetColor(*This.PB_Gadget, ColorType)
		Protected *GadgetData.GadgetData = *this\vt, Result
		
		If FindMapElement(ThemeColorOffset(), Str(ColorType))
			Result = PeekL(*GadgetData\ThemeData + ThemeColorOffset())
		EndIf
		
		ProcedureReturn RGB(Red(Result), Green(Result), Blue(Result))
	EndProcedure
	
	Procedure Default_GetState(*This.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\State
	EndProcedure
	
	Procedure Default_GetRequiredSize(*This.PB_Gadget, *Width, *Height)
		Protected *GadgetData.GadgetData = *this\vt
		
		PokeW(*Width, *GadgetData\TextBlock\RequiredWidth + *GadgetData\HMargin * 2)
		PokeW(*Height, *GadgetData\TextBlock\RequiredHeight + *GadgetData\VMargin * 2)
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
					Result = \TextBlock\FontScale
				Case #Attribute_CornerType
					Result = \CornerType
				Default
					Result = *GadgetData\OriginalVT\GetGadgetAttribute(*This, Attribute)
			EndSelect
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure.s Default_GetText(*this.PB_Gadget)
		Protected *GadgetData.GadgetData = *this\vt
		ProcedureReturn *GadgetData\TextBlock\OriginalText
	EndProcedure
	
	Procedure GetGadgetImage(Gadget)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData
		
		If *this
			*GadgetData = *this\vt
			ProcedureReturn *GadgetData\TextBlock\Image
		EndIf
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
	
	Procedure SetGadgetImage(Gadget, Image)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt
		
		*GadgetData\TextBlock\Image = Image
		
		PrepareVectorTextBlock(@*GadgetData\TextBlock)
		RedrawObject()
	EndProcedure
	
	; The #SubClass_* enum lists GadgetVT's pointer fields in declaration order, so a
	; slot's address is plain arithmetic off GadgetCallback - asserted right here, so
	; enum or structure drift fails the build instead of patching the wrong slot.
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		CompilerIf OffsetOf(GadgetVT\FreeGadget) <> OffsetOf(GadgetVT\GadgetCallback) + (#SubClass_FreeGadget - #SubClass_GadgetCallback) * SizeOf(Integer) Or OffsetOf(GadgetVT\GetGadgetAttribute) <> OffsetOf(GadgetVT\GadgetCallback) + (#SubClass_GetGadgetAttribute - #SubClass_GadgetCallback) * SizeOf(Integer) Or OffsetOf(GadgetVT\SetGadgetItemImage) <> OffsetOf(GadgetVT\GadgetCallback) + (#SubClass_SetGadgetItemImage - #SubClass_GadgetCallback) * SizeOf(Integer)
			CompilerError "The #SubClass_* enum no longer mirrors GadgetVT's field order - review SubClassFunction."
		CompilerEndIf
	CompilerEndIf
	
	Procedure SubClassFunction(Gadget, Function, *Address) ; Advanced functionality! Probably too much of a niche usage, move it to the private branch of UITK?
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.GadgetData = *this\vt, *Result, *Slot.Integer
		CompilerIf #PB_Compiler_OS <> #PB_OS_Windows
			; TODO Linux: rewrite using the Linux GadgetVT field set (no GadgetCallback /
			; GadgetX/Y/W/H / SetActiveGadget / GetRequiredSize).
			ProcedureReturn 0
		CompilerElse
			Select Function
				Case #SubClass_EventHandler		; not a vtable slot - lives in our GadgetData
					*Result = *GadgetData\EventHandler
					If *Address : *GadgetData\EventHandler = *Address : EndIf
					
				Case #SubClass_GadgetCallback To #SubClass_SetGadgetItemImage
					*Slot = *this\vt + OffsetOf(GadgetVT\GadgetCallback) + (Function - #SubClass_GadgetCallback) * SizeOf(Integer)
					*Result = *Slot\i
					If *Address : *Slot\i = *Address : EndIf
					
				Case #SubClass_DropHandler		; sits past GetGadgetItemImage, which has no #SubClass entry
					*Result = *this\vt\DropHandler
					If *Address : *this\vt\DropHandler = *Address : EndIf
			EndSelect
			
			ProcedureReturn *Result
		CompilerEndIf
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
					\TextBlock\FontScale = Value
					PrepareVectorTextBlock(@\TextBlock)
				Case #Attribute_CornerType
					\CornerType = Value
				Case #Attribute_TextVerticalAlignment
					\TextBlock\VAlign = Value
					PrepareVectorTextBlock(@\TextBlock)
				Case #Attribute_TextHorizontalAlignment
					\TextBlock\HAlign = Value
					PrepareVectorTextBlock(@\TextBlock)
				Default
					*GadgetData\OriginalVT\SetGadgetAttribute(*This, Attribute, Value)
					ProcedureReturn #False
			EndSelect
		EndWith
		
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetFont(*this.PB_Gadget, FontID)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\TextBlock\FontID = FontID
		PrepareVectorTextBlock(@*GadgetData\TextBlock)
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.GadgetData = *this\vt
		
		If Alpha(Color) = 0	; a plain RGB would be drawn fully transparent - store it opaque (same treatment as RenderSvgIcon)
			Color = SetAlpha(Color, 255)
		EndIf
		
		If FindMapElement(ThemeColorOffset(), Str(ColorType))
			PokeL(*GadgetData\ThemeData + ThemeColorOffset(), Color)
		EndIf
		
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetState(*This.PB_Gadget, State)
		Protected *GadgetData.GadgetData = *this\vt
		
		*GadgetData\State = State
		RedrawObject()
	EndProcedure
	
	Procedure Default_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.GadgetData = *this\vt
		*GadgetData\TextBlock\OriginalText = Text
		PrepareVectorTextBlock(@*GadgetData\TextBlock)
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
		
		Repeat ; can't use PB_Any with a timer, and a random ID must not collide with a live one
			Timer = Random(1048575, 1)
		Until FindMapElement(Timers(), Hex(Timer)) = 0
		AddWindowTimer(TimerWindow, Timer, TimeOut)
		
		AddMapElement(Timers(), Hex(Timer))
		Timers()\Callback = *Callback
		Timers()\Gadget = *Gadget
		
		ProcedureReturn Timer
	EndProcedure
	
	Procedure RemoveGadgetTimer(Timer)
		RemoveWindowTimer(TimerWindow, Timer)
		DeleteMapElement(Timers(), Hex(Timer))
	EndProcedure
	
	Procedure RemoveGadgetTimers(*Gadget)
		Protected NewList Stale.s()
		
		ForEach Timers()
			If Timers()\Gadget = *Gadget
				AddElement(Stale()) : Stale() = MapKey(Timers())
			EndIf
		Next
		
		ForEach Stale()
			RemoveWindowTimer(TimerWindow, Val("$" + Stale()))
			DeleteMapElement(Timers(), Stale())
		Next
	EndProcedure
	;}
	
	;{ Tooltip — one shared floating bubble, shown by any gadget that wants one
	; (the ToolBar's hover tips use it). Three properties keep it out of
	; trouble: NON-ACTIVATING (it never steals focus from the app window),
	; CLICK-THROUGH (no click can land on it), and TOPMOST (it clears the
	; caller's window without needing its ownership). Whoever shows it is
	; responsible for hiding it — on leave, press, or item change.
	Global TooltipWindow = -1
	Global TooltipCanvas
	
	Procedure HideTooltip()
		If TooltipWindow <> -1 And IsWindow(TooltipWindow)
			CompilerIf #PB_Compiler_OS = #PB_OS_Windows
				; Raw Win32 hide: PB's HideWindow re-activates the tooltip's owner (the hidden TimerWindow),
				; which deactivates - and therefore closes - any popup menu currently showing (Combo, ToolBar mode menu).
				ShowWindow_(WindowID(TooltipWindow), #SW_HIDE)
			CompilerElse
				HideWindow(TooltipWindow, #True)
			CompilerEndIf
		EndIf
	EndProcedure
	
	Procedure ShowTooltip(Text.s, X, Y, *ThemeData.Theme)
		Protected Width, Height, PreviousList
		
		If Text = ""
			HideTooltip()
			ProcedureReturn
		EndIf
		If TooltipWindow = -1	; Lazily built: piggy-backs the timer window like ADND
			TooltipWindow = OpenWindow(#PB_Any, 0, 0, 10, 10, "", #PB_Window_BorderLess | #PB_Window_Invisible, WindowID(TimerWindow))
			CompilerIf #PB_Compiler_OS = #PB_OS_Windows
				SetWindowLongPtr_(WindowID(TooltipWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(TooltipWindow), #GWL_EXSTYLE) | #WS_EX_NOACTIVATE | #WS_EX_TOOLWINDOW | #WS_EX_TRANSPARENT)
			CompilerEndIf
			PreviousList = UseGadgetList(WindowID(TooltipWindow))
			TooltipCanvas = CanvasGadget(#PB_Any, 0, 0, 10, 10)
			UseGadgetList(PreviousList)
		EndIf
		
		If StartVectorDrawing(CanvasVectorOutput(TooltipCanvas))	; Measure first...
			VectorFont(DefaultFont)
			Width = VectorTextWidth(Text) + 16
			Height = VectorTextHeight(Text) + 8
			StopVectorDrawing()
		EndIf
		ExamineDesktops()	; ...keep it on screen...
		If X + Width > DesktopX(0) + DesktopWidth(0)
			X = DesktopX(0) + DesktopWidth(0) - Width
		EndIf
		ResizeWindow(TooltipWindow, X, Y, Width, Height)
		ResizeGadget(TooltipCanvas, 0, 0, Width, Height)
		If StartVectorDrawing(CanvasVectorOutput(TooltipCanvas))	; ...then draw
			VectorFont(DefaultFont)
			AddPathBox(0, 0, Width, Height)
			VectorSourceColor(*ThemeData\BackColor[#Cold])
			FillPath()
			AddPathBox(0.5, 0.5, Width - 1, Height - 1)
			VectorSourceColor(*ThemeData\LineColor[#Cold])
			StrokePath(1)
			VectorSourceColor(*ThemeData\TextColor[#Cold])
			MovePathCursor(8, 4)
			DrawVectorText(Text)
			StopVectorDrawing()
		EndIf
		HideWindow(TooltipWindow, #False, #PB_Window_NoActivate)
		CompilerIf #PB_Compiler_OS = #PB_OS_Windows
			SetWindowPos_(WindowID(TooltipWindow), #HWND_TOPMOST, 0, 0, 0, 0, #SWP_NOMOVE | #SWP_NOSIZE | #SWP_NOACTIVATE)
		CompilerEndIf
	EndProcedure
	;}
	
	;{ Window
	; ============================================================
	; The themed window is Win32-only (subclassed wndproc + DwmExtendFrameIntoClientArea).
	; On Linux we'll need a separate implementation (likely gtk_window_set_decorated FALSE
	; + gtk_window_begin_move_drag, or accept native decorations). Stubbed for now so the
	; module compiles cross-platform.
	; ============================================================
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		#WM_SYSMENU = $313
		#SizableBorder = 8
		#WindowButtonWidth = 45
		#Icon_ChromeMaximize = $E922			; Segoe MDL2 Assets : maximize glyph (window normal)
		#Icon_ChromeRestore  = $E923			; ...restore glyph (window maximized)
		
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
			
			ButtonClose.i
			ButtonMinimize.i
			ButtonMaximize.i
			
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
		Global DWMLibrary = 0
		
		Structure UITK_MARGINS
			cxLeftWidth.l
			cxRightWidth.l
			cyTopHeight.l
			cyBottomHeight.l
		EndStructure
		
		Procedure Window_Init()
			; Detect DWM and keep dwmapi.dll loaded for the lifetime of the program so per-window calls are cheap.
			DWMLibrary = OpenLibrary(#PB_Any, "dwmapi.dll")
			If DWMLibrary
				CallFunction(DWMLibrary, "DwmIsCompositionEnabled", @DWMEnabled)
			Else
				DWMEnabled = 0
			EndIf
		EndProcedure
		
		Procedure ExtendFrameIntoClient(WindowID)
			; Tells DWM "this is a custom-chrome window" so Snap/Shadow/animations stay alive after we hide the system title bar via WM_NCCALCSIZE. A 1px top margin is the standard incantation used by Windows Terminal, Firefox, modern Win apps.
			; Note: this extended top row is composited by DWM and shows its frame line wherever a gadget paints it (GDI leaves that row alpha 0). That's why every title-bar gadget below is created at y = 1, not 0 — the top row stays pure background, so no line appears.
			Protected Margins.UITK_MARGINS
			Margins\cyTopHeight = 1
			If DWMLibrary
				CallFunction(DWMLibrary, "DwmExtendFrameIntoClientArea", WindowID, @Margins)
			EndIf
		EndProcedure
		
		Procedure CloseButton_Handler()
			PostEvent(#PB_Event_CloseWindow, EventWindow(), 0)
		EndProcedure
		
		Procedure MaximizeButton_Handler()
			Protected hWnd = WindowID(EventWindow())
			If IsZoomed_(hWnd)
				ShowWindow_(hWnd, #SW_RESTORE)
			Else
				ShowWindow_(hWnd, #SW_MAXIMIZE)
			EndIf
		EndProcedure
		
		Procedure MinimizeButton_Handler()
			ShowWindow_(WindowID(EventWindow()), #SW_MINIMIZE)
		EndProcedure
		
		Procedure Window_Handler(hWnd, Msg, wParam, lParam)
			Protected *WindowData.ThemedWindow = GetProp_(hWnd, "UITK_WindowData"), OffsetX, OriginalProc
			
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
					If wParam
						; Returning 0 makes the client fill the whole window rect (custom chrome, no OS frame).
						; When maximised, WM_GETMINMAXINFO already sizes the window to the monitor work area, so no
						; border inset is wanted here : insetting left a ~frame-wide margin around the content.
						ProcedureReturn 0
					EndIf
					;}
				Case #WM_NCHITTEST ;{
					Protected ptX = lParam & $FFFF
					Protected ptY = (lParam >> 16) & $FFFF
					
					If ptX & $8000 : ptX | $FFFF0000 : EndIf
					If ptY & $8000 : ptY | $FFFF0000 : EndIf
					Protected wRect.RECT
					GetWindowRect_(hWnd, @wRect)
					Protected x = ptX - wRect\left
					Protected y = ptY - wRect\top
					Protected w = wRect\right - wRect\left
					Protected h = wRect\bottom - wRect\top
					
					If *WindowData\Sizable And IsZoomed_(hWnd) = 0
						If y < #SizableBorder
							If x < #SizableBorder  : ProcedureReturn #HTTOPLEFT  : EndIf
							If x >= w - #SizableBorder : ProcedureReturn #HTTOPRIGHT : EndIf
							ProcedureReturn #HTTOP
						EndIf
						If y >= h - #SizableBorder
							If x < #SizableBorder  : ProcedureReturn #HTBOTTOMLEFT  : EndIf
							If x >= w - #SizableBorder : ProcedureReturn #HTBOTTOMRIGHT : EndIf
							ProcedureReturn #HTBOTTOM
						EndIf
						If x < #SizableBorder  : ProcedureReturn #HTLEFT  : EndIf
						If x >= w - #SizableBorder : ProcedureReturn #HTRIGHT : EndIf
					EndIf
					
					If y < #WindowBarHeight
						ProcedureReturn #HTCAPTION
					EndIf
					
					ProcedureReturn #HTCLIENT
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
						; Reflect maximised/restored state. WM_SIZE fires for every maximise path (button, title-bar
						; double-click, Win+arrow, OS), so this one spot keeps the glyph right. Guarded so a plain
						; resize-drag doesn't redraw the button on every frame.
						Protected MaxGlyph.s = Chr(#Icon_ChromeMaximize)
						If IsZoomed_(hWnd) : MaxGlyph = Chr(#Icon_ChromeRestore) : EndIf
						If GetGadgetText(*WindowData\ButtonMaximize) <> MaxGlyph
							SetGadgetText(*WindowData\ButtonMaximize, MaxGlyph)
						EndIf
					EndIf
					
					If *WindowData\ButtonMinimize
						OffsetX + #WindowButtonWidth
						ResizeGadget(*WindowData\ButtonMinimize, *WindowData\Width - OffsetX, #PB_Ignore, #PB_Ignore, #PB_Ignore)
					EndIf
					
					If *WindowData\LabelAlign = #HAlignRight
						SetWindowPos_(GadgetID(*WindowData\Label), 0, *WindowData\Width - OffsetX, 1, 0, 0, #SWP_NOSIZE)
					ElseIf *WindowData\LabelAlign = #HAlignCenter
						SetWindowPos_(GadgetID(*WindowData\Label), 0, (*WindowData\Width - *WindowData\LabelWidth) * 0.5, 1, 0, 0, #SWP_NOSIZE)
					EndIf
					
					SetWindowPos_(GadgetID(*WindowData\Container), 0, 0, 0, *WindowData\Width, *WindowData\Height - #WindowBarHeight, #SWP_NOMOVE | #SWP_NOZORDER)
					;}
				Case #WM_NCACTIVATE ;{
					ProcedureReturn 1
					;}
				Case #WM_NCDESTROY ;{
					If *WindowData\ButtonClose And IsGadget(*WindowData\ButtonClose)
						UnbindGadgetEvent(*WindowData\ButtonClose, @CloseButton_Handler(), #PB_EventType_Change)
					EndIf
					
					SetWindowLongPtr_(hWnd, #GWL_WNDPROC, *WindowData\OriginalProc)
					OriginalProc = *WindowData\OriginalProc
					DeleteObject_(*WindowData\Brush)	; the title-bar pattern brush (WindowSetColor already deletes replaced ones)
					FreeStructureX(*WindowData)
					
					ProcedureReturn CallWindowProc_(OriginalProc, hWnd, Msg, wParam, lParam)
					;}
			EndSelect
			
			ProcedureReturn CallWindowProc_(*WindowData\OriginalProc, hWnd, Msg, wParam, lParam)
		EndProcedure
		
		; Screen point (packed NCHITTEST lParam) inside the bottom/left/right resize
		; band of a sizable, un-maximized themed window? The top band is the title
		; bar's business, handled by the bar pieces themselves.
		Procedure Window_InSizeBand(Window, lParam)
			Protected *WindowData.ThemedWindow = GetProp_(Window, "UITK_WindowData")
			Protected ptX, ptY, wRect.RECT, localX, localY, w, h
			
			If *WindowData And *WindowData\Sizable And IsZoomed_(Window) = 0
				ptX = lParam & $FFFF
				ptY = (lParam >> 16) & $FFFF
				If ptX & $8000 : ptX | $FFFF0000 : EndIf
				If ptY & $8000 : ptY | $FFFF0000 : EndIf
				GetWindowRect_(Window, @wRect)
				localX = ptX - wRect\left
				localY = ptY - wRect\top
				w = wRect\right - wRect\left
				h = wRect\bottom - wRect\top
				If localY >= h - #SizableBorder Or localX < #SizableBorder Or localX >= w - #SizableBorder
					ProcedureReturn #True
				EndIf
			EndIf
			ProcedureReturn #False
		EndProcedure
		
		; Every child placed on the container gets this thin subclass, doing two
		; jobs the child can't know it should:
		; - RESIZE BAND: a gadget covering the border used to answer WM_NCHITTEST
		;   with HTCLIENT, stopping the hit-test dead - inside the band it now
		;   steps aside so gadget -> container -> window fall-through reaches the
		;   window's HTBOTTOMRIGHT & co.
		; - SHORTCUT BUBBLING: window shortcuts work from ANY focused gadget. An
		;   unmodified letter the child doesn't claim is forwarded to its
		;   top-level window, whose callback treats it like a viewport keypress.
		;   "Claimed" = the "UITK_KeepKeys" prop: standalone String gadgets set
		;   it for life, hosts of an inline edit (VerticalList/LayerList/
		;   PropertyBox/... meta Strings) set it while \Editing - so typing a
		;   name never triggers shortcuts. Ctrl'd letters are left alone: they
		;   belong to the accelerator table (which eats them pre-dispatch
		;   anyway). The child still processes the key afterwards - no UITK
		;   gadget acts on bare letters outside an edit.
		Procedure ContainerChild_Handler(hWnd, Msg, wParam, lParam)
			Protected OriginalProc = GetProp_(hWnd, "UITK_ChildProc")
			
			If Msg = #WM_NCHITTEST And Window_InSizeBand(GetAncestor_(hWnd, #GA_ROOT), lParam)
				ProcedureReturn #HTTRANSPARENT
			ElseIf Msg = #WM_KEYDOWN And wParam >= 'A' And wParam <= 'Z'
				If GetProp_(hWnd, "UITK_KeepKeys") = 0 And (GetKeyState_(#VK_CONTROL) & $8000) = 0
					SendMessage_(GetAncestor_(hWnd, #GA_ROOT), #WM_KEYDOWN, wParam, lParam)
				EndIf
			ElseIf Msg = #WM_NCDESTROY
				SetWindowLongPtr_(hWnd, #GWL_WNDPROC, OriginalProc)
				RemoveProp_(hWnd, "UITK_ChildProc")
			EndIf
			
			ProcedureReturn CallWindowProc_(OriginalProc, hWnd, Msg, wParam, lParam)
		EndProcedure
		
		Procedure WindowContainer_Handler(hWnd, Msg, wParam, lParam)
			Protected *ContainerData.WindowContainer = GetProp_(hWnd, "UITK_ContainerData")
			
			; The container sits below the title bar and covers the resize border on the bottom/left/right.
			; We return HTTRANSPARENT in those bands so the parent's WM_NCHITTEST gets the chance to return HTLEFT/HTRIGHT/HTBOTTOM/etc; without which the OS-driven resize and Aero Snap would never see the click.
			If Msg = #WM_NCHITTEST
				If Window_InSizeBand(*ContainerData\Parent, lParam)
					ProcedureReturn #HTTRANSPARENT
				EndIf
			ElseIf Msg = #WM_NCDESTROY
				Protected OriginalProc = *ContainerData\OriginalProc
				SetWindowLongPtr_(hWnd, #GWL_WNDPROC, OriginalProc)
				RemoveProp_(hWnd, "UITK_ContainerData")
				FreeStructureX(*ContainerData)
				ProcedureReturn CallWindowProc_(OriginalProc, hWnd, Msg, wParam, lParam)
			ElseIf Msg = #WM_PARENTNOTIFY And (wParam & $FFFF) = #WM_CREATE
				; A new child (gadget, nested child, the 3D screen host - creation
				; notifications bubble up from any depth): give it the child subclass
				; (resize band + shortcut bubbling - see ContainerChild_Handler)
				If IsWindow_(lParam) And GetProp_(lParam, "UITK_ChildProc") = 0
					SetProp_(lParam, "UITK_ChildProc", SetWindowLongPtr_(lParam, #GWL_WNDPROC, @ContainerChild_Handler()))
				EndIf
			EndIf
			
			ProcedureReturn CallWindowProc_(*ContainerData\OriginalProc, hWnd, Msg, wParam, lParam)
		EndProcedure
		
		Procedure WindowBar_Handler(hWnd, Msg, wParam, lParam)
			Protected *WindowBarData.WindowBar = GetProp_(hWnd, "UITK_WindowBarData")
			; The Label that paints the title text covers most of the title-bar strip.
			; Returning HTTRANSPARENT lets the parent's WM_NCHITTEST claim this area as HTCAPTION, so DWM handles drag, double-click maximize, snap, and Aero Shake.
			; The min/max/close buttons are separate child gadgets. They keep their own HTCLIENT hit-test and continue to receive normal clicks.
			If Msg = #WM_NCHITTEST
				ProcedureReturn #HTTRANSPARENT
			ElseIf Msg = #WM_NCDESTROY
				Protected OriginalProc = *WindowBarData\OriginalProc
				SetWindowLongPtr_(hWnd, #GWL_WNDPROC, OriginalProc)
				RemoveProp_(hWnd, "UITK_WindowBarData")
				FreeStructureX(*WindowBarData)
				ProcedureReturn CallWindowProc_(OriginalProc, hWnd, Msg, wParam, lParam)
			EndIf
			
			ProcedureReturn CallWindowProc_(*WindowBarData\OriginalProc, hWnd, Msg, wParam, lParam)
		EndProcedure
		
		Procedure Window(Window, X, Y, InnerWidth, InnerHeight, Title.s, Flags.i = #Default, Parent = #Null)
			Protected Result, Image, *WindowData.ThemedWindow, *WindowBarData.WindowBar, *ContainerData.WindowContainer ,WindowID, OffsetX
			
			If DWMEnabled = - 1
				Window_Init()
			EndIf
			
			If AccessibilityMode Or DWMEnabled = #False Or (Flags & #PB_Window_BorderLess)
				Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, (Bool(Flags & #Window_CloseButton) * #PB_Window_SystemMenu) |
				                                                                  (Bool(Flags & #Window_MaximizeButton) * #PB_Window_Maximize) |
				                                                                  (Bool(Flags & #Window_MinimizeButton) * #PB_Window_Minimize) |
				                                                                  (Bool(Flags & #Window_Sizable) * #PB_Window_SizeGadget) |
				                                                                  (Bool(Flags & #Window_Invisible) * #PB_Window_Invisible) |
				                                                                  (Bool(Flags & #Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
			Else
				AllocateStructureX(*WindowData, ThemedWindow)
				*WindowData\Sizable = Bool(Flags & #Window_Sizable)
				
				If *WindowData\Sizable
					Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, (#WS_OVERLAPPEDWINDOW&~#WS_SYSMENU) | #PB_Window_Invisible | (Bool(Flags & #Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
				Else
					InnerHeight + #WindowBarHeight
					Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title, #PB_Window_BorderLess | #PB_Window_Invisible | (Bool(Flags & #Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
				EndIf
				
				If Window = #PB_Any
					Window = Result
				EndIf
				
				WindowID = WindowID(Window)
				
				If Flags & #DarkMode
					CopyStructure(@DarkTheme, *WindowData\Theme, Theme)
				ElseIf Flags & #LightMode
					CopyStructure(@LightTheme, *WindowData\Theme, Theme)
				Else
					CopyStructure(*DefaultTheme, *WindowData\Theme, Theme)
				EndIf
				
				Image = CreateImage(#PB_Any, 8, 8, 32, SetAlpha(*WindowData\Theme\WindowTitle, 255)) ; Removing SetAlpha makes LightTheme goes derp. Can anybody explain?
				*WindowData\Brush = CreatePatternBrush_(ImageID(Image))
				*WindowData\Width = WindowWidth(Window)
				*WindowData\Height = WindowHeight(Window)
				
				FreeImage(Image)
				
				SetClassLongPtr_(WindowID, #GCL_HBRBACKGROUND, *WindowData\Brush)
				
				SetProp_(WindowID, "UITK_WindowData", *WindowData)
				
				*WindowData\OriginalProc = SetWindowLongPtr_(WindowID, #GWL_WNDPROC, @Window_Handler())
				
				ExtendFrameIntoClient(WindowID)
				
				If Flags & #Window_CloseButton
					OffsetX + #WindowButtonWidth
					*WindowData\ButtonClose = Button(#PB_Any, *WindowData\Width - OffsetX, 1, #WindowButtonWidth, #WindowBarHeight - 1, "", Flags & #DarkMode)
					
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
					*WindowData\ButtonMaximize = Button(#PB_Any, *WindowData\Width - OffsetX, 1, #WindowButtonWidth, #WindowBarHeight - 1, "", Flags & #DarkMode)
					
					SetGadgetAttribute(*WindowData\ButtonMaximize, #Attribute_CornerRadius, 0)
					
					SetGadgetFont(*WindowData\ButtonMaximize, IconFont)
					
					SetGadgetColor(*WindowData\ButtonMaximize, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
					
					BindGadgetEvent(*WindowData\ButtonMaximize, @MaximizeButton_Handler(), #PB_EventType_Change)
				EndIf
				
				If Flags & #Window_MinimizeButton
					OffsetX + #WindowButtonWidth
					*WindowData\ButtonMinimize = Button(#PB_Any, *WindowData\Width - OffsetX, 1, #WindowButtonWidth, #WindowBarHeight - 1, "",Flags & #DarkMode)
					
					SetGadgetAttribute(*WindowData\ButtonMinimize, #Attribute_CornerRadius, 0)
					
					SetGadgetFont(*WindowData\ButtonMinimize, IconFont)
					
					SetGadgetColor(*WindowData\ButtonMinimize, #Color_Back_Cold, *WindowData\Theme\WindowTitle)
					
					BindGadgetEvent(*WindowData\ButtonMinimize, @MinimizeButton_Handler(), #PB_EventType_Change)
				EndIf
				
				*WindowData\Label = Label(#PB_Any, #SizableBorder, 1, *WindowData\Width - OffsetX, #WindowBarHeight , Title, (Flags & #DarkMode) | #HAlignLeft | #VAlignCenter)
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
				SetProp_(GadgetID(*WindowData\Container), "UITK_ContainerData", *ContainerData)
				*ContainerData\OriginalProc = SetWindowLongPtr_(GadgetID(*WindowData\Container), #GWL_WNDPROC, @WindowContainer_Handler())
				SetGadgetColor(*WindowData\Container, #PB_Gadget_BackColor, RGB(Red(*WindowData\Theme\WindowColor), Green(*WindowData\Theme\WindowColor), Blue(*WindowData\Theme\WindowColor)))
				
				SetWindowPos_(WindowID, 0, 0, 0, 0, 0, #SWP_NOSIZE|#SWP_NOMOVE|#SWP_FRAMECHANGED)
				
				HideWindow(Window, Bool(Flags & #Window_Invisible))
			EndIf
			
			ProcedureReturn Result
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
					; The bar reads Icon · Title · Menus: the title KEEPS its text and
					; the menus line up after it. Centered/right titles can't share
					; the row with menus, so the first menu pins the label left.
					\LabelAlign = #HAlignLeft
					ResizeGadget(\Label, #SizableBorder, #PB_Ignore, \LabelWidth, #PB_Ignore)
					\MenuOffset = #SizableBorder + \LabelWidth + #SizableBorder
				EndIf
				
				AddElement(\MenuList())
				If UseGadgetList(0) = WindowID(Window)
					CloseGadgetList()
				Else
					WindowGadgetList = UseGadgetList(WindowID(Window))
				EndIf
				
				UseGadgetList(WindowID(Window))
				
				\MenuList() = Button(#PB_Any, \MenuOffset, 1, 100, #WindowBarHeight - 1, Title, #Button_Toggle)
				SetGadgetAttribute(\MenuList(), #Attribute_CornerRadius, 0)
				SetGadgetColor(\MenuList(), #Color_Back_Cold, \Theme\WindowTitle)
				SetGadgetColor(\MenuList(), #Color_Back_Warm, \Theme\ShadeColor[#Warm])
				SetGadgetColor(\MenuList(), #Color_Back_Hot, \Theme\ShadeColor[#Cold])
				ResizeGadget(\MenuList(), #PB_Ignore, #PB_Ignore, GadgetWidth(\MenuList(), #PB_Gadget_RequiredSize) + 2 * #SizableBorder, #PB_Ignore)
				\MenuOffset + GadgetWidth(\MenuList())
				
				BindGadgetEvent(\MenuList(), @Handler_MenuButton(), #PB_EventType_Change)
				SetGadgetData(*MenuData\Canvas, \MenuList())
				SetGadgetData(\MenuList(), Menu)
				*MenuData\Border = 1
				ResizeGadget(*MenuData\Canvas, #PB_Ignore, 0, #PB_Ignore, #PB_Ignore)
				ResizeWindow(*MenuData\Window, #PB_Ignore, #PB_Ignore, *MenuData\Width + 2, *MenuData\Height + *MenuData\Border)
				
				
				If WindowGadgetList
					UseGadgetList(WindowGadgetList)
					; UseGadgetList hands back the previous list's OS handle, not a PB window number
					*WindowData.ThemedWindow = GetProp_(WindowGadgetList, "UITK_WindowData")
					If *WindowData
						OpenGadgetList(\Container)
					EndIf
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
		
		Procedure SetWindowLabel(Window, Text.s)
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
			
			SetWindowTitle(Window, Text)	; Taskbar / Alt-Tab caption (and the whole
			If *WindowData = 0				; job, on the plain-window fallback)
				ProcedureReturn
			EndIf
			With *WindowData
				SetGadgetText(\Label, Text)
				\LabelWidth = GadgetWidth(\Label, #PB_Gadget_RequiredSize)
				If ListSize(\MenuList())
					\LabelAlign = #HAlignLeft
					ResizeGadget(\Label, #SizableBorder, #PB_Ignore, \LabelWidth, #PB_Ignore)
					\MenuOffset = #SizableBorder + \LabelWidth + #SizableBorder
					ForEach \MenuList()
						ResizeGadget(\MenuList(), \MenuOffset, #PB_Ignore, #PB_Ignore, #PB_Ignore)
						\MenuOffset + GadgetWidth(\MenuList())
					Next
				Else
					ResizeGadget(\Label, #PB_Ignore, #PB_Ignore, \LabelWidth, #PB_Ignore)
				EndIf
			EndWith
		EndProcedure
		
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
				SetWindowPos_(GadgetID(*WindowData\Label), 0, *WindowData\Width - (*WindowData\ButtonClose + *WindowData\ButtonMaximize + *WindowData\ButtonMinimize) * #WindowButtonWidth, 1, 0, 0, #SWP_NOSIZE)
			ElseIf *WindowData\LabelAlign = #HAlignCenter
				SetWindowPos_(GadgetID(*WindowData\Label), 0, (*WindowData\Width - *WindowData\LabelWidth) * 0.5, 1, 0, 0, #SWP_NOSIZE)
			ElseIf ListSize(*WindowData\MenuList())
				; Icon · Title · Menus: the wider label pushes the menu row along
				With *WindowData
					\MenuOffset = #SizableBorder + \LabelWidth + #SizableBorder
					ForEach \MenuList()
						ResizeGadget(\MenuList(), \MenuOffset, #PB_Ignore, #PB_Ignore, #PB_Ignore)
						\MenuOffset + GadgetWidth(\MenuList())
					Next
				EndWith
			EndIf
		EndProcedure
		
		Procedure WindowSetColor(Window, ColorType, Color)
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData"), Image, *OldBrush
			
			If Alpha(Color) = 0	; a plain RGB would be drawn fully transparent - store it opaque
				Color = SetAlpha(Color, 255)
			EndIf
			
			If FindMapElement(ThemeColorOffset(), Str(ColorType))
				PokeL(@*WindowData\Theme + ThemeColorOffset(), Color)
			EndIf
			
			Select ColorType
				Case #Color_Parent			; the client container paints the new background itself
					SetGadgetColor(*WindowData\Container, #PB_Gadget_BackColor, RGB(Red(Color), Green(Color), Blue(Color)))
					
				Case #Color_WindowBorder	; rebuild the title-bar brush and recolour the bar's gadgets
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
		Procedure GetWindowContainer(Window)
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
			
			If *WindowData
				ProcedureReturn *WindowData\Container
			EndIf
			ProcedureReturn -1
		EndProcedure
		
		Procedure.i GetWindowMenuButton(Window, Index)
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData")
			
			If *WindowData And SelectElement(*WindowData\MenuList(), Index)
				ProcedureReturn *WindowData\MenuList()
			EndIf
			ProcedureReturn -1
		EndProcedure
		
		Procedure GetWindowIcon(Window)
			Protected *WindowData.ThemedWindow
			
			*WindowData = GetProp_(WindowID(Window), "UITK_WindowData")
			ProcedureReturn GetGadgetImage(*WindowData\Label)
		EndProcedure
		
		Procedure WindowGetColor(Window, ColorType)
			Protected *WindowData.ThemedWindow = GetProp_(WindowID(Window), "UITK_WindowData"), Result
			
			If FindMapElement(ThemeColorOffset(), Str(ColorType))
				Result = PeekL(@*WindowData\Theme + ThemeColorOffset())
			EndIf
			
			ProcedureReturn RGB(Red(Result), Green(Result), Blue(Result))
		EndProcedure
	CompilerElse
		; ============================================================
		; Linux native window — Phase 4 (final architecture)
		; ============================================================
		; Wayland made the Phase-4a custom-titlebar approach untenable: Mutter
		; silently refuses gtk_window_maximize / begin_resize_drag on borderless
		; windows, and fighting the compositor accumulated more code than it was
		; worth. On Linux we let PB open a fully WM-managed window with its native
		; chrome (title bar, borders, all owned by Mutter / KWin / etc.). The look
		; loses the UITK dark theme on the title bar — but everything else just
		; works: snap, resize, max/min/close buttons, Win+arrow, position tracking.
		; GIMP / Inkscape / etc. take the same per-platform-divergence approach.
		
		Procedure Window_Init() : EndProcedure
		Procedure ExtendFrameIntoClient(WindowID) : EndProcedure
		Procedure GetWindowContainer(Window) : ProcedureReturn -1 : EndProcedure
		Procedure.i GetWindowMenuButton(Window, Index) : ProcedureReturn -1 : EndProcedure
		Procedure SetWindowLabel(Window, Text.s) : SetWindowTitle(Window, Text) : EndProcedure
		
		Procedure Window(Window, X, Y, InnerWidth, InnerHeight, Title.s, Flags.i = #Default, Parent = #Null)
			Protected Result = OpenWindow(Window, X, Y, InnerWidth, InnerHeight, Title,
			                              (Bool(Flags & #Window_CloseButton)    * #PB_Window_SystemMenu) |
			                              (Bool(Flags & #Window_MaximizeButton) * #PB_Window_Maximize)   |
			                              (Bool(Flags & #Window_MinimizeButton) * #PB_Window_Minimize)   |
			                              (Bool(Flags & #Window_Sizable)        * #PB_Window_SizeGadget) |
			                              (Bool(Flags & #Window_Invisible)      * #PB_Window_Invisible)  |
			                              (Bool(Flags & #Window_ScreenCentered) * #PB_Window_ScreenCentered), Parent)
			If Window = #PB_Any : Window = Result : EndIf
			
			; Allocate a ThemedWindow so UITK gadgets created inside this window pick
			; up the right palette via the standard GetProp_("UITK_WindowData") path
			; (per-gadget theme-inheritance is unchanged from Windows). Also set the
			; PB window background color to match — without it, GTK's default (light)
			; background shows through and clashes with DarkMode gadgets.
			;
			; SetOwnedProp_ registers the allocation with UITK_PropOwned so the GTK
			; destroy hook FreeStructure's it when the window goes away — no leak.
			Protected *WindowData.ThemedWindow
			AllocateStructureX(*WindowData, ThemedWindow)
			If Flags & #DarkMode
				CopyStructure(@DarkTheme, @*WindowData\Theme, Theme)
			ElseIf Flags & #LightMode
				CopyStructure(@LightTheme, @*WindowData\Theme, Theme)
			Else
				CopyStructure(*DefaultTheme, @*WindowData\Theme, Theme)
			EndIf
			SetOwnedProp_(WindowID(Window), "UITK_WindowData", *WindowData)
			SetWindowColor(Window, RGB(Red(*WindowData\Theme\WindowColor), Green(*WindowData\Theme\WindowColor), Blue(*WindowData\Theme\WindowColor)))
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure OpenWindowGadgetList(Window)
			; Linux native windows have no Container under the chrome — gadgets go
			; into the window's own gadget list. Forward to PB's gadget-list machinery
			; via UseGadgetList (calling PB's OpenWindowGadgetList from inside a same-
			; named procedure would recurse).
			ProcedureReturn UseGadgetList(WindowID(Window))
		EndProcedure
		
		Procedure SetWindowBounds(Window, MinWidth, MinHeight, MaxWidth, MaxHeight)
			WindowBounds(Window, MinWidth, MinHeight, MaxWidth, MaxHeight)
		EndProcedure
		
		Procedure SetWindowIcon(Window, Image)
			; Most Linux DEs derive the window icon from a .desktop entry, not from a
			; runtime call. Leave as a no-op for now; can wire gdk_window_set_icon
			; later if a use case appears.
		EndProcedure
		
		Procedure GetWindowIcon(Window)                    : ProcedureReturn 0 : EndProcedure
		Procedure WindowSetColor(Window, ColorType, Color) : EndProcedure
		Procedure WindowGetColor(Window, ColorType)        : ProcedureReturn 0 : EndProcedure
		
		; AddWindowMenu — translate a UITK FlatMenu into a native PB menubar attached
		; to the window. The FlatMenu remains usable as a popup via UITK::ShowFlatMenu;
		; this just gives the WM-drawn menubar a representation of its items so users
		; get a real menu on Linux. Each item is re-emitted via MenuItem with the same
		; numeric ID the FlatMenu was created with, so the user's existing
		; #PB_Event_Menu / EventMenu() handlers wire up identically. The PB menu is
		; created lazily on first call and cached on the window via UITK_PropMap.
		Procedure AddWindowMenu(Window, Menu, Title.s)
			Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
			If Not *MenuData : ProcedureReturn : EndIf
			
			Protected pbMenu = GetProp_(WindowID(Window), "UITK_PBMenu")
			If pbMenu = 0
				pbMenu = CreateMenu(#PB_Any, WindowID(Window))
				SetProp_(WindowID(Window), "UITK_PBMenu", pbMenu)
			EndIf
			; PB has no cross-platform UseMenu, so subsequent MenuTitle/MenuItem calls
			; go into whatever PB menu was created most recently. That's fine for the
			; common case where AddWindowMenu is called in sequence right after Window().
			; If the user creates other PB menus between AddWindowMenu calls, items
			; would land in the wrong menu — caveat documented here for the future.
			
			MenuTitle(Title)
			Protected *SubData.FlatMenu
			ForEach *MenuData\Item()
				If *MenuData\Item()\Type = #Separator
					MenuBar()
				ElseIf *MenuData\Item()\SubMenu And IsWindow(*MenuData\Item()\SubMenu)
					; Mirror one level of submenu natively (deeper nesting is not mirrored here)
					*SubData = GetProp_(WindowID(*MenuData\Item()\SubMenu), "UITK_MenuData")
					If *SubData
						OpenSubMenu(*MenuData\Item()\Text\OriginalText)
						ForEach *SubData\Item()
							If *SubData\Item()\Type = #Separator
								MenuBar()
							Else
								MenuItem(*SubData\Item()\ID, FlatMenu_NativeLabel(@*SubData\Item()))
							EndIf
						Next
						CloseSubMenu()
					EndIf
				Else
					MenuItem(*MenuData\Item()\ID, FlatMenu_NativeLabel(@*MenuData\Item()))
				EndIf
			Next
		EndProcedure
	CompilerEndIf	;}
	
	;{ Advanced drag & drop
	; A long note, to not attempt to reinvent the wheel in 3 year when I'll have forgotten why I did this:
	; Why a *low-level* (WH_MOUSE_LL) hook, and not something lighter? During DragPrivate() the OS runs
	; a modal DoDragDrop loop. Inside it, two lighter options both go blind while the cursor is over our
	; own CanvasGadgets (which take the mouse capture): PB's SetDragCallback / IDropSource::GiveFeedback
	; stalls, and a thread-scoped WH_MOUSE hook never sees the moves (they don't pass through our queue).
	; WH_MOUSE_LL fires on raw input below all of that, so the preview keeps up everywhere. It is live
	; only between ShowPreview and HidePreview, so the system-wide reach lasts just the drag.
	; Linux/Mac equivalent would use a GTK drag icon or X11 cursor image : out of scope for now.
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		Global ADNDWindow = OpenWindow(#PB_Any, 0, 0, 10, 10, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(TimerWindow)) ; Piggy-backs the timer window; a dedicated hidden UITK window would be cleaner.
		SetWindowLongPtr_(WindowID(ADNDWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(ADNDWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED | #WS_EX_TRANSPARENT)
		SetLayeredWindowAttributes_(WindowID(ADNDWindow), 0, 128, #LWA_ALPHA)
		Global ADNDGadget = ImageGadget(#PB_Any, 0, 0, 1, 1, 0)
		Global ADNDHook, *DropCallback
		Global ADND_OffsetX, ADND_OffsetY
		
		; Fires for every raw mouse move while installed; MSLLHOOKSTRUCT\pt (aliased here) is in screen coordinates.
		Procedure ADND_Hook(nCode, wParam, *p.POINT)
			If nCode >= 0
				SetWindowPos_(WindowID(ADNDWindow), 0, *p\x + ADND_OffsetX, *p\y + ADND_OffsetY, 0, 0, #SWP_NOSIZE | #SWP_NOACTIVATE | #SWP_NOREDRAW)
			EndIf
			ProcedureReturn CallNextHookEx_(#NUL, nCode, wParam, *p)
		EndProcedure
		
		Procedure ADND_ShowPreview(ImageID)
			Protected HBitmap.BITMAP
			
			GetObject_(ImageID, SizeOf(BITMAP), @HBitmap)
			ResizeWindow(ADNDWindow, DesktopMouseX() + ADND_OffsetX, DesktopMouseY() + ADND_OffsetY, HBitmap\bmWidth, HBitmap\bmHeight)
			SetGadgetState(ADNDGadget, ImageID)	
			HideWindow(ADNDWindow, #False)
			ADNDHook = SetWindowsHookEx_(#WH_MOUSE_LL, @ADND_Hook(), GetModuleHandle_(0), 0)
		EndProcedure
		
		Procedure ADND_HidePreview()
			If ADNDHook
				UnhookWindowsHookEx_(ADNDHook)
				ADNDHook = 0
			EndIf
			HideWindow(ADNDWindow, #True)
		EndProcedure
		
		Procedure AdvancedDragPrivate(Type, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
			ADND_OffsetX = OffsetX
			ADND_OffsetY = OffsetY
			ADND_ShowPreview(ImageID)
			DragPrivate(Type, Action)
			ADND_HidePreview()
		EndProcedure
		
		Procedure AdvancedDragFiles(File.s, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
			ADND_OffsetX = OffsetX
			ADND_OffsetY = OffsetY
			ADND_ShowPreview(ImageID)
			DragFiles(File, Action)
			ADND_HidePreview()
		EndProcedure
		
		Procedure AdvancedDragText(Text.s, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
			ADND_OffsetX = OffsetX
			ADND_OffsetY = OffsetY
			ADND_ShowPreview(ImageID)
			DragText(Text, Action)
			ADND_HidePreview()
		EndProcedure
		
		Procedure AdvancedDragImage(ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)
			ADND_OffsetX = OffsetX
			ADND_OffsetY = OffsetY
			ADND_ShowPreview(ImageID)
			DragImage(ImageID, Action)
			ADND_HidePreview()
		EndProcedure
		
		Procedure DropCallback(TargetHandle, State, Format, Action, x, y)
			Protected *this.PB_Gadget, *GadgetData.GadgetData, Result = #True
			
			If FindMapElement(GadgetHandler(), Str(TargetHandle))
				*this = IsGadget(GadgetHandler())
				*GadgetData = *this\vt
				
				If *this\vt\DropHandler
					Result = CallFunctionFast(*this\vt\DropHandler, *GadgetData, State, Format, Action, x, y)
				ElseIf *DropCallback
					Result = CallFunctionFast(*DropCallback, TargetHandle, State, Format, Action, x, y)
				EndIf
			ElseIf *DropCallback
				Result = CallFunctionFast(*DropCallback, TargetHandle, State, Format, Action, x, y)
			EndIf
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure RegisterDropCallback(*Callback)
			*DropCallback = *Callback
		EndProcedure
		
		Procedure.i AdvancedDragActive()
			ProcedureReturn Bool(ADNDHook <> 0)
		EndProcedure
		
		Procedure DragPreviewVisible(State)
			If ADNDHook	; Only meaningful during an active AdvancedDrag
				If State
					SetLayeredWindowAttributes_(WindowID(ADNDWindow), 0, 128, #LWA_ALPHA)
				Else
					SetLayeredWindowAttributes_(WindowID(ADNDWindow), 0, 0, #LWA_ALPHA)
				EndIf
			EndIf
		EndProcedure
		
		SetDropCallback(@DropCallback())
	CompilerElse
		; ---- Linux/Mac stubs for advanced drag & drop ----
		Procedure AdvancedDragPrivate(Type, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy) : ProcedureReturn 0 : EndProcedure
		Procedure AdvancedDragFiles(File.s, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy) : ProcedureReturn 0 : EndProcedure
		Procedure AdvancedDragText(Text.s, ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)  : ProcedureReturn 0 : EndProcedure
		Procedure AdvancedDragImage(ImageID, OffsetX, OffsetY, Action = #PB_Drag_Copy)         : ProcedureReturn 0 : EndProcedure
		Procedure RegisterDropCallback(*Callback) : EndProcedure
		Procedure DragPreviewVisible(State) : EndProcedure
		Procedure.i AdvancedDragActive() : ProcedureReturn #False : EndProcedure
	CompilerEndIf
	;}
	
	
	;{ The Weird
	; Those are bandaid on an open wound: fixes for problems that only emerged because
	; of the strict adherence To PureBasic's internals. Might be worth reconsidering
	; when the great refactor comes in.
	
	CompilerIf #PB_Compiler_OS = #PB_OS_Windows
		; "UITK_KeepKeys" is set by whatever is taking typed text — a String for
		; its whole life, an inline editor for as long as it is open. It already
		; stops bare letters bubbling up as window shortcuts (see
		; ContainerChild_Handler); this asks the same question from outside, for
		; the keys that never bubble because the ACCELERATOR TABLE takes them
		; first. Del is the one that matters: a host that binds it to a delete
		; command deletes the very row whose name is being typed.
		Procedure.i KeyboardClaimed()
			ProcedureReturn Bool(GetProp_(GetFocus_(), "UITK_KeepKeys") <> 0)
		EndProcedure
		
		; Give a key the accelerator table swallowed back to whoever is typing, so
		; the host can decline it AND the editor still does the obvious thing with
		; it. Sent, not posted: the caller is inside its own menu handler and the
		; editor should have consumed it by the time that returns.
		Procedure ForwardKeyToFocus(VirtualKey)
			Protected Focus = GetFocus_()
			
			If Focus = 0 Or GetProp_(Focus, "UITK_KeepKeys") = 0
				ProcedureReturn
			EndIf
			SendMessage_(Focus, #WM_KEYDOWN, VirtualKey, 0)
			SendMessage_(Focus, #WM_KEYUP, VirtualKey, 0)
		EndProcedure
	CompilerEndIf
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
				If \State And \MouseState = #Cold
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
			
			DrawVectorTextBlock(@\TextBlock, \OriginX + \HMargin, \OriginY + \VMargin, 145 + Bool(State <> #Disabled) * 110)
			
		EndWith
	EndProcedure
	
	Procedure Button_EventHandler(*GadgetData.ButtonData, *Event.Event)
		Protected Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #LeftClick
					If \Toggle
						\State = Bool(Not \State) * #Hot
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
							\State = Bool(Not \State) * #Hot
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
			\TextBlock\OriginalText = Text
			
			; Button alignment is different from default alignment.
			If Flags & #VAlignTop
				\TextBlock\VAlign = #VAlignTop
			ElseIf Flags & #VAlignBottom
				\TextBlock\VAlign = #VAlignBottom
			Else
				\TextBlock\VAlign = #VAlignCenter
			EndIf
			
			If Flags & #HAlignLeft
				*GadgetData\TextBlock\HAlign = #HAlignLeft
			ElseIf Flags & #HAlignRight
				*GadgetData\TextBlock\HAlign = #HAlignRight
			Else
				*GadgetData\TextBlock\HAlign = #HAlignCenter
			EndIf
			
			If \TextBlock\HAlign <> #HAlignCenter
				\HMargin = #Button_Margin + \Border
				\VMargin = #Button_Margin
			EndIf
			
			\TextBlock\Width = Width - \HMargin * 2
			\TextBlock\Height = Height - \VMargin * 2
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			
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
				CreateGadgetObject(ButtonData)
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
			VectorSourceColor(\ThemeData\TextColor[\MouseState])
			
			If \TextBlock\HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBlock, X + \HMargin * 2, Y)
				X = \OriginX + #ToggleSize * 0.5 + BorderMargin
			Else
				DrawVectorTextBlock(@\TextBlock, X, Y)
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
			\TextBlock\Width = Width - #ToggleSize * 2 - BorderMargin * 2
			\TextBlock\Height = Height - BorderMargin * 2
			\TextBlock\OriginalText = Text
			\HMargin = #ToggleSize + BorderMargin
			\VMargin = BorderMargin
			
			If Flags & #HAlignCenter
				\TextBlock\HAlign = #HAlignLeft
			EndIf
			
			\TextBlock\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			
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
			CreateGadgetObject(ToggleData)
			Toggle_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ Checkbox
	#CheckBoxSize = 20
	
	Structure CheckBoxData Extends GadgetData
	EndStructure
	
	Procedure CheckBox_Redraw(*GadgetData.CheckBoxData)
		Protected X, Y
		
		With *GadgetData
			VectorSourceColor(\ThemeData\TextColor[\MouseState])
			
			If \TextBlock\HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBlock, X + \HMargin * 2, Y)
				X = \OriginX + BorderMargin
			Else
				DrawVectorTextBlock(@\TextBlock, X, Y)
				X = \OriginX + \Width - #CheckBoxSize - BorderMargin
			EndIf
			
			Y = Floor(\OriginY + (\Height - #CheckBoxSize) * 0.5)
			
			VectorSourceColor(\ThemeData\FrontColor[\MouseState])
			AddPathBox(X, Y, #CheckBoxSize, #CheckBoxSize)
			AddPathBox(X + #CheckBoxSize * 0.1, Y + #CheckBoxSize * 0.1, #CheckBoxSize * 0.8, #CheckBoxSize * 0.8)
			
			If \State = #True
				AddPathBox(X + #CheckBoxSize, Y, #CheckBoxSize * -0.25, #CheckBoxSize * 0.1)
				AddPathBox(X + #CheckBoxSize * 0.9, Y + #CheckBoxSize * 0.1, #CheckBoxSize * 0.1, #CheckBoxSize * 0.25)
				FillPath()
				
				VectorSourceColor(\ThemeData\FrontColor[\MouseState])
				
				MovePathCursor(X + #CheckBoxSize * 0.2, Y + #CheckBoxSize * 0.4)
				AddPathLine(#CheckBoxSize * 0.28, #CheckBoxSize * 0.28, #PB_Path_Relative)
				AddPathLine(#CheckBoxSize * 0.5, -#CheckBoxSize * 0.7, #PB_Path_Relative)
				
				StrokePath(2)
			Else
				FillPath()
				If \State = #PB_Checkbox_Inbetween
					AddPathBox(X + #CheckBoxSize * 0.25, Y + #CheckBoxSize * 0.25, #CheckBoxSize * 0.5, #CheckBoxSize * 0.5)
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
			\TextBlock\Width = Width - #CheckBoxSize - BorderMargin * 2
			\TextBlock\Height = Height - BorderMargin * 2
			\TextBlock\OriginalText = Text
			\HMargin = #CheckBoxSize * 0.5 + BorderMargin
			\VMargin = BorderMargin
			
			If Flags & #HAlignCenter
				\TextBlock\HAlign = #HAlignLeft
			EndIf
			
			\TextBlock\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			
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
				CreateGadgetObject(CheckBoxData)
				CheckBox_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ String
	Structure String_CharacterData
		Char.s
		Width.i
		Position.i
	EndStructure
	
	Structure StringData Extends GadgetData
		Timer.i
		Caret.i
		AlignmentOffset.i
		CaretVisible.i
		CaretPosition.i
		TextPositionX.i
		TextPositionY.i
		String.s
		SelectionPosition.i
		SelectionLength.i
		CaretHeight.l
		List CharacterData.String_CharacterData()
		Selecting.b
		Focus.b
	EndStructure
	
	Macro String_SupportedEvents()
		*GadgetData\SupportedEvent[#Focus] = #True
		*GadgetData\SupportedEvent[#LostFocus] = #True
		*GadgetData\SupportedEvent[#MouseMove] = #True
		*GadgetData\SupportedEvent[#LeftButtonDown] = #True
		*GadgetData\SupportedEvent[#LeftButtonUp] = #True
		*GadgetData\SupportedEvent[#KeyDown] = #True
		*GadgetData\SupportedEvent[#KeyUp] = #True
		*GadgetData\SupportedEvent[#Input] = #True
	EndMacro
	
	Procedure String_ProcessString(*GadgetData.StringData)
		Protected Loop, CharacterCount, Position
		
		With *GadgetData
			Position = \TextPositionX
			ClearList(\CharacterData())
			CharacterCount = Len(\String)
			
			StartVectorDrawing(CanvasVectorOutput(\Gadget))
			
			If \TextBlock\FontScale
				VectorFont(\TextBlock\FontID, \TextBlock\FontScale)
			Else
				VectorFont(\TextBlock\FontID)
			EndIf
			
			For Loop = 1 To CharacterCount
				AddElement(\CharacterData())
				\CharacterData()\Char = Mid(\String, Loop, 1)
				\CharacterData()\Width = VectorTextWidth(\CharacterData()\Char)
				\CharacterData()\Position = Position
				Position + \CharacterData()\Width
			Next
			
			If \TextBlock\HAlign = #HAlignCenter
				\AlignmentOffset = (\Width - Position) * 0.5
			ElseIf \TextBlock\HAlign = #HAlignRight
				\AlignmentOffset = \Width - Position - BorderMargin
			EndIf
			
			AddElement(\CharacterData())
			\CharacterData()\Position = Position
			
			If \CaretPosition > CharacterCount
				\CaretPosition = CharacterCount
			EndIf
			
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure String_Redraw(*GadgetData.StringData)
		Protected Loop, Size, Position, Text.s
		
		With *GadgetData
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
			Else
				AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
			EndIf
			
			VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			ClipPath(#PB_Path_Preserve)
			FillPath()
			
			If \TextBlock\FontScale
				VectorFont(\TextBlock\FontID, \TextBlock\FontScale)
			Else
				VectorFont(\TextBlock\FontID)
			EndIf
			
			VectorSourceColor(\ThemeData\TextColor[#Cold])
			MovePathCursor(\TextPositionX + \AlignmentOffset + \OriginX, \TextPositionY + \OriginY)
			DrawVectorParagraph(\String, \Width, \Height)
			
			If \SelectionPosition > -1 And \Focus
				SelectElement(\CharacterData(), \SelectionPosition)
				Position = \CharacterData()\Position + \AlignmentOffset + \OriginX
				
				If \SelectionLength < 0
					For Loop = -1 To \SelectionLength Step -1
						PreviousElement(\CharacterData())
						Size + \CharacterData()\Width
						Text = \CharacterData()\Char + Text
					Next
					Position - Size
				Else
					Size = \CharacterData()\Width
					Text = \CharacterData()\Char
					
					For Loop = 2 To \SelectionLength
						NextElement(\CharacterData())
						Size + \CharacterData()\Width
						Text + \CharacterData()\Char
					Next
				EndIf
				
				AddPathBox(Position, \OriginY + \TextPositionY + 1, Size, \CaretHeight)
				VectorSourceColor(SetAlpha(FixColor($4F9BF2), 255))
				FillPath()
				
				VectorSourceColor(\ThemeData\TextColor[#Cold])
				MovePathCursor(Position, \OriginY + \TextPositionY)
				DrawVectorParagraph(Text, \Width, \Height)
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure String_CaretRedraw(*GadgetData.StringData, Timer)
		With *GadgetData
			HideGadget(\Caret, \CaretVisible)
			\CaretVisible = Bool(Not \CaretVisible)
		EndWith
	EndProcedure
	
	Procedure String_RemoveSelection(*GadgetData.StringData)
		Protected Size, Loop
		
		With *GadgetData
			If \SelectionLength < 0
				\CaretPosition = \SelectionPosition + \SelectionLength
				SelectElement(\CharacterData(), \CaretPosition)
				\SelectionLength = Abs(\SelectionLength)
			Else
				\CaretPosition = \SelectionPosition
				SelectElement(\CharacterData(), \SelectionPosition)
			EndIf
			
			\String = Left(\String, \CaretPosition) + Right(\String, Len(\String) - (\CaretPosition + \SelectionLength))
			
			For Loop = 1 To \SelectionLength
				Size + \CharacterData()\Width
				DeleteElement(\CharacterData())
				NextElement(\CharacterData())
				\CharacterData()\Position - Size
			Next
			
			While NextElement(\CharacterData())
				\CharacterData()\Position - Size
			Wend
			
			If \TextBlock\HAlign = #HAlignCenter
				\AlignmentOffset = (\Width - \CharacterData()\Position) * 0.5
			ElseIf \TextBlock\HAlign = #HAlignRight
				\AlignmentOffset = \Width - \CharacterData()\Position - BorderMargin
			EndIf
			
			\SelectionLength = 0
			\SelectionPosition = -1
		EndWith
	EndProcedure
	
	Procedure String_EventHandler(*GadgetData.StringData, *Event.Event)
		Protected Size, Selection, Modifiers, Text.s, Loop, Redraw
		
		With *GadgetData
			Select *Event\EventType
				Case #Input ;{
					If \SelectionPosition > -1
						String_RemoveSelection(*GadgetData.StringData)
					EndIf
					
					If \CaretPosition = 0
						FirstElement(\CharacterData())
						Size = \CharacterData()\Position
						InsertElement(\CharacterData())
					Else
						SelectElement(\CharacterData(), \CaretPosition - 1)
						Size = \CharacterData()\Position + \CharacterData()\Width
						AddElement(\CharacterData())
					EndIf
					
					\CharacterData()\Char = Chr(*Event\Param)
					\CharacterData()\Position = Size
					StartVectorDrawing(CanvasVectorOutput(\Gadget))
					If \TextBlock\FontScale
						VectorFont(\TextBlock\FontID, \TextBlock\FontScale)
					Else
						VectorFont(\TextBlock\FontID)
					EndIf
					
					\CharacterData()\Width = VectorTextWidth(\CharacterData()\Char)
					If \TextBlock\HAlign = #HAlignCenter
						\AlignmentOffset - \CharacterData()\Width * 0.5
					ElseIf \TextBlock\HAlign = #HAlignRight
						\AlignmentOffset - \CharacterData()\Width
					EndIf
					
					ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position + \CharacterData()\Width, #PB_Ignore, #PB_Ignore, #PB_Ignore)
					
					StopVectorDrawing()
					
					Size = \CharacterData()\Width
					
					While NextElement(\CharacterData())
						\CharacterData()\Position + Size
					Wend
					
					\String = Left(\String, \CaretPosition) + Chr(*Event\Param) + Right(\String, Len(\String) - \CaretPosition)
					Redraw = #True
					
					\CaretPosition + 1
					HideGadget(\Caret, #False)
					\CaretVisible = #True
					RemoveGadgetTimer(\Timer)
					\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
					
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
					;}
				Case #LeftButtonDown ;{
					ForEach \CharacterData()
						If \CharacterData()\Position + 2 > (*Event\MouseX - \AlignmentOffset)
							Break
						EndIf
					Next
					
					\CaretPosition = ListIndex(\CharacterData())
					ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
					HideGadget(\Caret, #False)
					\CaretVisible = #True
					RemoveGadgetTimer(\Timer)
					\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
					\Selecting = #True
					\SelectionLength = 0
					\SelectionPosition = -1
					Redraw = #True
					;}
				Case #LeftButtonUp ;{
					\Selecting = #False
					;}
				Case #KeyDown ;{
					Select *Event\Param
						Case #PB_Shortcut_Left ;{
							If \CaretPosition > 0
								Modifiers = GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers)
								If Modifiers & #PB_Canvas_Shift
									If \SelectionPosition > -1
										\SelectionLength -1
										If \SelectionLength = 0
											\SelectionPosition = -1
										EndIf
									Else
										\SelectionPosition = \CaretPosition
										\SelectionLength = -1
									EndIf
									Redraw = #True
								ElseIf \SelectionPosition > -1
									\SelectionPosition = -1
									\SelectionLength = 0
									Redraw = #True
								EndIf
								
								\CaretPosition - 1
								SelectElement(\CharacterData(), \CaretPosition)
								ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
							Else
								If \SelectionPosition > -1 And Not (GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Shift)
									\SelectionPosition = -1
									\SelectionLength = 0
									Redraw = #True
								EndIf
							EndIf
							;}
						Case #PB_Shortcut_Right ;{
							If \CaretPosition < ListSize(\CharacterData()) And SelectElement(\CharacterData(), \CaretPosition + 1)
								Modifiers = GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers)
								If Modifiers & #PB_Canvas_Shift
									If \SelectionPosition > -1
										\SelectionLength +1
										If \SelectionLength = 0
											\SelectionPosition = -1
										EndIf
									Else
										\SelectionPosition = \CaretPosition
										\SelectionLength = 1
									EndIf
									Redraw = #True
									SelectElement(\CharacterData(), \CaretPosition + 1)
								ElseIf \SelectionPosition > -1
									\SelectionPosition = -1
									\SelectionLength = 0
									Redraw = #True
									SelectElement(\CharacterData(), \CaretPosition + 1)
								EndIf
								
								\CaretPosition + 1
								ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
							Else
								If \SelectionPosition > -1 And Not (GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Shift)
									\SelectionPosition = -1
									\SelectionLength = 0
									Redraw = #True
								EndIf
							EndIf
							;}
						Case #PB_Shortcut_Delete ;{
							If \SelectionPosition > -1
								String_RemoveSelection(*GadgetData.StringData)
								SelectElement(\CharacterData(), \CaretPosition)
								ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
								Redraw = #True
								
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							ElseIf \CaretPosition < ListSize(\CharacterData()) - 1
								SelectElement(\CharacterData(), \CaretPosition)
								Size = \CharacterData()\Width
								
								If \TextBlock\HAlign = #HAlignCenter
									\AlignmentOffset + \CharacterData()\Width * 0.5
									ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								ElseIf \TextBlock\HAlign = #HAlignRight
									\AlignmentOffset + \CharacterData()\Width
									ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								EndIf
								
								DeleteElement(\CharacterData())
								
								While NextElement(\CharacterData())
									\CharacterData()\Position - Size
								Wend
								
								\String = Left(\String, \CaretPosition) + Right(\String, Len(\String) - \CaretPosition - 1)
								
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
								Redraw = #True
								
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							EndIf
							;}
						Case #PB_Shortcut_Back ;{
							If \SelectionPosition > -1
								String_RemoveSelection(*GadgetData.StringData)
								SelectElement(\CharacterData(), \CaretPosition)
								ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
								Redraw = #True
								
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							ElseIf \CaretPosition
								\CaretPosition -1
								SelectElement(\CharacterData(), \CaretPosition)
								Size = \CharacterData()\Width
								
								If \TextBlock\HAlign = #HAlignCenter
									\AlignmentOffset + \CharacterData()\Width * 0.5
									ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								ElseIf \TextBlock\HAlign = #HAlignRight
									\AlignmentOffset + \CharacterData()\Width
								Else
									ResizeGadget(\Caret, GadgetX(\Caret) - Size, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								EndIf
								
								DeleteElement(\CharacterData())
								
								While NextElement(\CharacterData())
									\CharacterData()\Position - Size
								Wend
								
								\String = Left(\String, \CaretPosition) + Right(\String, Len(\String) - \CaretPosition - 1)
								
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
								Redraw = #True
								
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							EndIf
							;}
						Case #PB_Shortcut_V ;{
							If GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Control 
								Text = GetClipboardText()
								If Text <> ""
									If \SelectionPosition > -1
										String_RemoveSelection(*GadgetData)
									EndIf
									
									\String = Left(\String, \CaretPosition) + Text + Right(\String, Len(\String) - \CaretPosition)
									\CaretPosition + Len(Text)
									String_ProcessString(*GadgetData)
									
									SelectElement(\CharacterData(), \CaretPosition)
									ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
									HideGadget(\Caret, #False)
									\CaretVisible = #True
									RemoveGadgetTimer(\Timer)
									\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
									Redraw = #True
									
									PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
								EndIf
							EndIf
							;}
						Case #PB_Shortcut_C ;{
							If GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Control And \SelectionPosition > -1
								
								If \SelectionLength < 0
									\CaretPosition = \SelectionPosition + \SelectionLength
									SelectElement(\CharacterData(), \CaretPosition)
									\SelectionLength = Abs(\SelectionLength)
								Else
									\CaretPosition = \SelectionPosition
									SelectElement(\CharacterData(), \SelectionPosition)
								EndIf
								
								For Loop = 1 To \SelectionLength
									Text + \CharacterData()\Char
									NextElement(\CharacterData())
								Next
								
								SetClipboardText(Text)
							EndIf
							;}
						Case #PB_Shortcut_X ;{
							If GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Control And \SelectionPosition > -1
								
								If \SelectionLength < 0
									\CaretPosition = \SelectionPosition + \SelectionLength
									SelectElement(\CharacterData(), \CaretPosition)
									\SelectionLength = Abs(\SelectionLength)
									\SelectionPosition = \CaretPosition
								Else
									\CaretPosition = \SelectionPosition
									SelectElement(\CharacterData(), \SelectionPosition)
								EndIf
								
								ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
								
								For Loop = 1 To \SelectionLength
									Text + \CharacterData()\Char
									NextElement(\CharacterData())
								Next
								
								SetClipboardText(Text)
								String_RemoveSelection(*GadgetData.StringData)
								
								Redraw = #True
								
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							EndIf
							;}
						Case #PB_Shortcut_A ;{
							If GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Control
								\SelectionPosition = 0
								\CaretPosition = ListSize(\CharacterData()) - 1
								\SelectionLength = \CaretPosition
								
								LastElement(\CharacterData())
								
								ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
								HideGadget(\Caret, #False)
								\CaretVisible = #True
								RemoveGadgetTimer(\Timer)
								\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
								Redraw = #True
							EndIf
							;}
						Case #PB_Shortcut_Return ;{
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ForcefulChange)
							;}
					EndSelect
					;}
				Case #Focus ;{
					\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
					\Focus = #True
					
					SelectElement(\CharacterData(), \CaretPosition)
					ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, \OriginY + \TextPositionY + \Border, #PB_Ignore, #PB_Ignore)
					HideGadget(\Caret, #False)
					\CaretVisible = #True
					
					If \SelectionPosition > -1
						Redraw = #True
					EndIf
					;}
				Case #LostFocus ;{
					RemoveGadgetTimer(\Timer)
					If \CaretVisible
						HideGadget(\Caret, #True)
						\CaretVisible = #False
					EndIf
					
					\Focus = #False
					
					If \SelectionPosition > -1
						Redraw = #True
					EndIf
					;}
				Case #MouseMove ;{
					If \Selecting
						ForEach \CharacterData()
							If \CharacterData()\Position + 2 > (*Event\MouseX - \AlignmentOffset)
								Break
							EndIf
						Next
						Selection = ListIndex(\CharacterData())
						
						If Selection <> \CaretPosition
							If \SelectionPosition = -1
								\SelectionPosition = \CaretPosition
							EndIf
							
							\CaretPosition = ListIndex(\CharacterData())
							\SelectionLength = \CaretPosition - \SelectionPosition
							
							If \SelectionLength = 0
								\SelectionPosition = -1
							EndIf
							
							ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
							HideGadget(\Caret, #False)
							\CaretVisible = #True
							RemoveGadgetTimer(\Timer)
							\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
							
							Redraw = #True
						EndIf
					EndIf
					;}
				Case #MouseEnter ;{
					\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_IBeam)
					;}
				Case #MouseLeave ;{
					\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_Default)
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
		EndWith
		
		ProcedureReturn Redraw
	EndProcedure
	
	; Getters
	Procedure.s String_GetText(*this.PB_Gadget)
		Protected *GadgetData.StringData = *this\vt
		ProcedureReturn *GadgetData\String
	EndProcedure
	
	Procedure String_GetAttribute(*this.PB_Gadget, Attribute)
		Protected *GadgetData.StringData = *this\vt, Result
		
		With *GadgetData
			Select Attribute
				Case #Attribute_TextSelectionPosition
					Result =  \SelectionPosition
					
				Case #Attribute_TextSelectionLength
					Result = \SelectionLength
					
				Default
					Result = Default_GetAttribute(*this.PB_Gadget, Attribute)
			EndSelect
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	; Setters
	Procedure String_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.StringData = *this\vt
		
		With *GadgetData
			\String = Text
			\SelectionLength = 0
			\SelectionPosition = -1
			\CaretPosition = Len(\String)
			String_ProcessString(*GadgetData)
			RedrawObject()
			
			LastElement(\CharacterData())
			ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
			
			If \Focus
				HideGadget(\Caret, #False)
				\CaretVisible = #True
				RemoveGadgetTimer(\Timer)
				\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
			EndIf
		EndWith
		
	EndProcedure
	
	Procedure String_SetFont_Meta(*GadgetData.StringData, FontID)
		With *GadgetData
			\TextBlock\FontID = FontID
			StartVectorDrawing(CanvasVectorOutput(\Gadget))
			If \TextBlock\FontScale
				VectorFont(\TextBlock\FontID, \TextBlock\FontScale)
			Else
				VectorFont(\TextBlock\FontID)
			EndIf
			\CaretHeight = Ceil( VectorTextHeight("Oh!"))
			\TextPositionY = \OriginY + Round((\Height - \CaretHeight) * 0.5, #PB_Round_Nearest) - 1
			ResizeGadget(\Caret, #PB_Ignore, #PB_Ignore, #PB_Ignore, \CaretHeight)
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure String_SetFont(*this.PB_Gadget, FontID)
		String_SetFont_Meta(*this\vt, FontID)
	EndProcedure
	
	Procedure StringSetSelection_Meta(*GadgetData.StringData, Position, Length)
		With *GadgetData
			\SelectionPosition = Position
			\SelectionLength = Length
			\CaretPosition = Position + Length
			
			SelectElement(\CharacterData(), \CaretPosition)
			ResizeGadget(\Caret, \OriginX + \AlignmentOffset + \CharacterData()\Position, #PB_Ignore, #PB_Ignore, #PB_Ignore)
			HideGadget(\Caret, #False)
			\CaretVisible = #True
			RemoveGadgetTimer(\Timer)
			\Timer = AddGadgetTimer(*GadgetData, 600, @String_CaretRedraw())
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure StringSetSelection(Gadget, Position, Length)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.StringData = *this\vt
		
		StringSetSelection_Meta(*GadgetData.StringData, Position, Length)
	EndProcedure
	
	
	Procedure String_Meta(*GadgetData.StringData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(String)
		
		With *GadgetData
			
			StartVectorDrawing(CanvasVectorOutput(\Gadget))
			If \TextBlock\FontScale
				VectorFont(\TextBlock\FontID, \TextBlock\FontScale)
			Else
				VectorFont(\TextBlock\FontID)
			EndIf
			\CaretHeight = Ceil( VectorTextHeight("Oh!"))
			
			StopVectorDrawing()
			\TextPositionX = \OriginX + BorderMargin * Bool(\TextBlock\HAlign = #HAlignLeft)						
			\TextPositionY = \OriginY + Round((\Height - \CaretHeight) * 0.5, #PB_Round_Nearest) - 1
			\String = Text
			\SelectionPosition = -1
			
			If \Caret = 0
				\Caret = ContainerGadget(#PB_Any, \TextPositionX, \TextPositionY + 1, 1, \CaretHeight)
				CloseGadgetList()
				SetGadgetColor(\Caret, #PB_Gadget_BackColor, RGB(Red(\ThemeData\TextColor[#Cold]),
				                                                 Green(\ThemeData\TextColor[#Cold]),
				                                                 Blue(\ThemeData\TextColor[#Cold])))
			EndIf
			
			If Flags & #Gadget_Meta
				AddElement(\CharacterData())
				\CharacterData()\Position = \TextPositionX
			Else
				String_ProcessString(*GadgetData)
			EndIf
			
			HideGadget(\Caret, #True)
			
			\VT\GetGadgetText = @String_GetText()
			\VT\SetGadgetText = @String_SetText()
			\VT\SetGadgetFont = @String_SetFont()
			
			String_SupportedEvents()
			*GadgetData\SupportedEvent[#MouseEnter] = #True
			*GadgetData\SupportedEvent[#MouseLeave] = #True
			
		EndWith
	EndProcedure
	
	Procedure String(Gadget, x, y, Width, Height, Text.s, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.StringData, *ThemeData
		
		If AccessibilityMode
			Result = StringGadget(Gadget, x, y, Width, Height, Text, (Bool(Flags & #HAlignRight) * #PB_Text_Right) |
			                                                         (Bool(Flags & #HAlignCenter) * #PB_Text_Center) |
			                                                         (Bool(Flags & #Border) * #PB_Text_Border))
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | #PB_Canvas_Container)
			
			If Result
				CreateGadgetObject(StringData)
				String_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
				SetProp_(GadgetID(Gadget), "UITK_KeepKeys", 1)	; A text field: its letters
																; never bubble to the window as shortcuts (ContainerChild_Handler)
				
				CloseGadgetList()
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ ScrollBar
	Structure ScrollBarData Extends GadgetData
		Min.l
		Max.l
		PageLength.l
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
		Protected Radius.f, Point, Width, Height, Pos
		
		With *GadgetData
			If \Background
				VectorSourceColor(\ThemeData\ShadeColor[#Cold])
			Else
				VectorSourceColor(0)
			EndIf
			
			If \MouseState
				Radius = \Thickness * 0.5
				AddPathCircle(\OriginX + Radius, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
				
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
			Else
				Radius = \Thickness * 0.25
				
				If \Vertical
					Width = Radius * 2
					Pos = Round(\OriginX + \Width - Radius, #PB_Round_Down)
					AddPathCircle(Pos, \OriginY + Radius, Radius, 0, 360, #PB_Path_Default)
					AddPathBox(- Width, 0, Width, \Height - Width, #PB_Path_Relative)
					AddPathCircle(Pos, \OriginY + \Height - Radius, Radius, 0, 360, #PB_Path_Default)
					FillPath(#PB_Path_Winding)
					
					VectorSourceColor(\ThemeData\FrontColor[\MouseState])
					
					If \BarSize >= 0
						AddPathCircle(Pos, \OriginY + Radius + \Position, Radius, 0, 360, #PB_Path_Default)
						AddPathBox(- Width, 0, Width, \BarSize + \Thickness * 0.5, #PB_Path_Relative)
						AddPathCircle(Pos, \OriginY + Radius + \BarSize + \Position + \Thickness * 0.5, Radius, 0, 360, #PB_Path_Default)
						
						FillPath(#PB_Path_Winding)
					EndIf
				Else
					Height = Radius * 2
					Pos = Round(\OriginY + \Height - Radius, #PB_Round_Down)
					AddPathCircle(\OriginX + Radius, Pos, Radius, 0, 360, #PB_Path_Default)
					AddPathBox(- Radius, - Radius, \Width - Width, Height, #PB_Path_Relative)
					AddPathCircle(\OriginX + \Width - Radius, Pos, Radius, 0, 360, #PB_Path_Default)
					FillPath(#PB_Path_Winding)
					
					VectorSourceColor(\ThemeData\FrontColor[\MouseState])
					
					If \BarSize >= 0
						AddPathCircle(\OriginX + Radius + \Position, Pos, Radius, 0, 360, #PB_Path_Default)
						AddPathBox(- Radius, - Radius, \BarSize + \Thickness * 0.5, Height, #PB_Path_Relative)
						AddPathCircle(\OriginX + Radius + \Position + \BarSize + \Thickness * 0.5, Pos, Radius, 0, 360, #PB_Path_Default)
						
						FillPath(#PB_Path_Winding)
					EndIf
				EndIf
				
			EndIf
			
			
		EndWith
	EndProcedure
	
	Procedure ScrollBar_EventHandler(*GadgetData.ScrollBarData, *Event.Event)
		Protected Redraw, Mouse, Length, Position
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \Drag
						If \Vertical
							Mouse = *Event\MouseY - \OriginY
							Length = \Height - \BarSize - \Thickness
						Else
							Mouse = *Event\MouseX - \OriginX
							Length = \Width - \BarSize - \Thickness
						EndIf
						
						Position = Clamp(Mouse - \DragOffset, 0, Length)
						
						If Position <> \Position
							\Position = Position
							\State = Round(Position / (Length) * (\Max - \Min - \PageLength), #PB_Round_Down)
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
							Length = \Height
						Else
							Mouse = *Event\MouseX - \OriginX
							Length = \Width
						EndIf
						
						If \MouseState
							\Drag = #True
							\DragOffset = Mouse - \Position
						Else
							If Mouse > \Position
								\State = Min(\State + \PageLength, \Max - \PageLength)
								Redraw = #True
							Else
								\State = Max(\State - \PageLength, \Min)
								Redraw = #True
							EndIf
							
							If \Gadget > -1
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
							\Position = Round(\State / (\Max - \Min) * Length, #PB_Round_Nearest)
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					\Drag = #False
					;}
				Case #MouseWheel ;{
					If \Vertical
						Mouse = *Event\MouseY
						Length = \Height
					Else
						Mouse = *Event\MouseX
						Length = \Width
					EndIf
					
					Position = Clamp(\State - *Event\Param * \ScrollStep, \Min, \Max - \PageLength)
					If Position <> \State
						\State = Position
						\Position = Round(\State / (\Max - \Min) * Length, #PB_Round_Nearest)
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
				Result = *GadgetData\PageLength
			Case #ScrollBar_ScrollStep
				Result = *GadgetData\ScrollStep
			Default
				Result = *GadgetData\OriginalVT\GetGadgetAttribute(*This, Attribute)
		EndSelect
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure ScrollBar_SetAttribute_Meta(*GadgetData.ScrollBarData, Attribute, Value)
		Protected Length
		
		With *GadgetData
			Select Attribute
				Case #ScrollBar_Minimum ;{
					If Value < \Max
						\Min = Value
						
						If \State < \Min
							\State = \Min
						EndIf
						
						If \PageLength >= (\Max - \Min)
							\BarSize = -1
						ElseIf \Vertical
							\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
						
						\State = Clamp(\State, \Min, Max(\Max - \PageLength, \Min))
						If \Vertical
							Length = \Height
						Else
							Length = \Width
						EndIf
						\Position = Round(\State / (\Max - \Min) * Length, #PB_Round_Nearest)
						
						RedrawObject()
					EndIf
					;}
				Case #ScrollBar_Maximum ;{
					If Value > \Min
						\Max = Value
						
						If \PageLength >= (\Max - \Min)
							\BarSize = -1
						ElseIf \Vertical
							\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
						
						\State = Clamp(\State, \Min, Max(\Max - \PageLength, \Min))
						If \Vertical
							Length = \Height
						Else
							Length = \Width
						EndIf
						\Position = Round(\State / (\Max - \Min) * Length, #PB_Round_Nearest)
						
						RedrawObject()
					EndIf
					;}
				Case #ScrollBar_PageLength ;{
					\PageLength = Value
					If \PageLength >= (\Max - \Min)
						\BarSize = -1
					Else
						If \Vertical
							\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
						Else
							\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
						EndIf
					EndIf
					
					\State = Clamp(\State, \Min, Max(\Max - \PageLength, \Min))
					If \Vertical
						Length = \Height
					Else
						Length = \Width
					EndIf
					\Position = Round(\State / (\Max - \Min) * Length, #PB_Round_Nearest)
					
					RedrawObject()
					;}
				Case #ScrollBar_ScrollStep
					\ScrollStep = Value
				Default	
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
			EndSelect
		EndWith
	EndProcedure
	
	Procedure ScrollBar_SetAttribute(*This.PB_Gadget, Attribute, Value)
		ScrollBar_SetAttribute_Meta(*this\vt, Attribute, Value)
	EndProcedure
	
	Procedure ScrollBar_SetState_Meta(*GadgetData.ScrollBarData, State)
		Protected Length
		
		With *GadgetData
			State = Clamp(State, \Min, \Max - \PageLength)
			If State <> \State
				\State = State
				If \Vertical
					Length = \Height
				Else
					Length = \Width
				EndIf
				
				\Position = Round(\State / (\Max - \Min) * Length, #PB_Round_Nearest)
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure ScrollBar_SetState(*this.PB_Gadget, State)
		ScrollBar_SetState_Meta(*this\vt, State)
	EndProcedure
	
	Procedure ScrollBar_ResizeMeta(*GadgetData.ScrollBarData, X, Y, Width, Height)
		With *GadgetData
			\Width = Width
			\Height = Height
			\OriginX = X
			\OriginY = Y
			
			If \Vertical
				\Thickness = \Width
				\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Height, #PB_Round_Nearest) - \Thickness, 0, \Height - \Thickness)
			Else
				\Thickness = \Height
				\BarSize = Clamp(Round(\PageLength / (\Max - \Min) * \Width, #PB_Round_Nearest) - \Thickness, 0, \Width - \Thickness)
			EndIf
			
			If \PageLength >= (\Max - \Min)
				\BarSize = -1
			EndIf
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure ScrollBar_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.ScrollBarData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		ScrollBar_ResizeMeta(*GadgetData, 0, 0, GadgetWidth(*GadgetData\Gadget), GadgetHeight(*GadgetData\Gadget))
	EndProcedure
	
	Procedure ScrollBar_Meta(*GadgetData.ScrollBarData, *ThemeData, Gadget, x, y, Width, Height, Min, Max, PageLength, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(ScrollBar)
		
		With *GadgetData
			\Max = Max
			\Min = Min
			\PageLength = PageLength
			
			If Flags & #Gadget_Vertical
				\Vertical = #True
				\Thickness = \Width
				\BarSize = Clamp(Round(PageLength / (Max - Min) * Height, #PB_Round_Nearest) - \Thickness, 0, Height - \Thickness)
			Else
				\Thickness = \Height
				\BarSize = Clamp(Round(PageLength / (Max - Min) * Width, #PB_Round_Nearest) - \Thickness, 0, Width - \Thickness)
			EndIf
			
			If \PageLength >= (\Max - \Min)
				\BarSize = -1
			EndIf
			
			\ScrollStep = 3
			
			\VT\GetGadgetAttribute = @ScrollBar_GetAttribute()
			\VT\SetGadgetAttribute = @ScrollBar_SetAttribute()
			\VT\SetGadgetState = @ScrollBar_SetState()
			\VT\ResizeGadget = @ScrollBar_Resize()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
		EndWith
		
		ProcedureReturn *GadgetData
	EndProcedure
	
	Procedure ScrollBar(Gadget, x, y, Width, Height, Min, Max, PageLength, Flags = #Default)
		Protected Result, *GadgetData.ScrollBarData, *this.PB_Gadget, *ThemeData
		
		If AccessibilityMode
			Result = ScrollBarGadget(Gadget, x, y, Width, Height, Min, Max, PageLength, Bool( #Gadget_Vertical) * #PB_ScrollBar_Vertical)
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				CreateGadgetObject(ScrollBarData)
				*GadgetData\Background = #True
				ScrollBar_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Min, Max, PageLength, Flags)
				
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
			VectorSourceColor(\ThemeData\TextColor[#Cold])
			DrawVectorTextBlock(@\TextBlock, \OriginX, \OriginY)
		EndWith
	EndProcedure
	
	Procedure Label_EventHandler(*GadgetData.LabelData, *Event.Event)
	EndProcedure
	
	Procedure Label_Meta(*GadgetData.LabelData, *ThemeData, Gadget, x, y, Width, Height, Text.s, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Label)
		
		With *GadgetData
			\TextBlock\Width = Width
			\TextBlock\Height = Height
			\TextBlock\OriginalText = Text
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			
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
				CreateGadgetObject(LabelData)
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
		VerticalScrollBar.i
		HorizontalScrollBar.i
		HiddenVScrollBar.i
		HiddenHScrollBar.i
	EndStructure
	
	Global ScrollBarThickness
	
	Procedure ScrollArea_ScrollBarHandler()
		Protected Gadget = EventGadget(), *GadgetData.ScrollAreaData = GetProp_(GadgetID(Gadget), "UITK_ScrollAreaData")
		
		If Gadget = *GadgetData\HorizontalScrollBar
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
			SetGadgetState(*GadgetData\VerticalScrollBar, GetGadgetAttribute(Gadget, #PB_ScrollArea_Y))
		EndIf
	EndProcedure
	
	Procedure ScrollArea_Resize(*this.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
	EndProcedure
	
	Procedure ScrollArea_Free(*this.PB_Gadget)
		Protected *GadgetData.ScrollAreaData = *this\vt
		
		With *GadgetData
			DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
			If IsGadget(\VerticalScrollBar) : FreeGadget(\VerticalScrollBar) : EndIf
			If IsGadget(\HorizontalScrollBar) : FreeGadget(\HorizontalScrollBar) : EndIf
			If IsGadget(\ScrollArea) : FreeGadget(\ScrollArea) : EndIf
			
			*this\vt = \OriginalVT
			FreeStructureX(\ThemeData)
			FreeStructureX(*GadgetData)
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
					SetGadgetAttribute(*GadgetData\HorizontalScrollBar, #ScrollBar_Maximum, Value)
					
				Case #ScrollArea_InnerHeight
					SetGadgetAttribute(*GadgetData\VerticalScrollBar, #ScrollBar_Maximum, Value)
					
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
			
			If ScrollBarThickness = 0
				ScrollBar = ScrollBarGadget(#PB_Any, 0, 0, 100, 20, 0, 10, 1)
				ScrollBarThickness = GadgetHeight(ScrollBar, #PB_Gadget_RequiredSize)
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
					CopyStructure(@LightTheme, *GadgetData\ThemeData, Theme)
				Else
					Protected *WindowData.ThemedWindow = GetProp_(WindowID(CurrentWindow()), "UITK_WindowData")
					If *WindowData
						CopyStructure(@*WindowData\Theme, *GadgetData\ThemeData, Theme)
					Else
						CopyStructure(*DefaultTheme, *GadgetData\ThemeData, Theme)
					EndIf
				EndIf
				
				*GadgetData\ScrollArea = ScrollAreaGadget(#PB_Any, 0, 0, Width - #ScrollArea_Bar_Thickness + ScrollBarThickness, Height - #ScrollArea_Bar_Thickness + ScrollBarThickness, ScrollAreaWidth, ScrollAreaHeight, ScrollStep, #PB_ScrollArea_BorderLess)
				SetProp_(GadgetID(\ScrollArea), "UITK_ScrollAreaData", *GadgetData)
				BindGadgetEvent(\ScrollArea, @ScrollArea_Handler())
				
				SetGadgetColor(\ScrollArea, #PB_Gadget_BackColor, RGB(Red(*GadgetData\ThemeData\WindowColor), Green(*GadgetData\ThemeData\WindowColor), Blue(*GadgetData\ThemeData\WindowColor)))
				SetGadgetColor(\Gadget, #PB_Gadget_BackColor, RGB(Red(*GadgetData\ThemeData\WindowColor), Green(*GadgetData\ThemeData\WindowColor), Blue(*GadgetData\ThemeData\WindowColor)))
				
				CloseGadgetList()
				CloseGadgetList()
				
				\Width = Width
				\Height = Height
				\VerticalScrollBar = ScrollBar(#PB_Any, x + \Width - #ScrollArea_Bar_Thickness, y, #ScrollArea_Bar_Thickness, \Height - #ScrollArea_Bar_Thickness, 0, ScrollAreaHeight + #ScrollArea_Bar_Thickness, \Height, #Gadget_Vertical)
				BindGadgetEvent(\VerticalScrollBar, @ScrollArea_ScrollBarHandler(), #PB_EventType_Change)
				SetProp_(GadgetID(\VerticalScrollBar), "UITK_ScrollAreaData", *GadgetData)
				
				\HorizontalScrollBar = ScrollBar(#PB_Any, x, y + \Height - #ScrollArea_Bar_Thickness, \Width - #ScrollArea_Bar_Thickness, #ScrollArea_Bar_Thickness, 0, ScrollAreaWidth + #ScrollArea_Bar_Thickness, \Width)
				BindGadgetEvent(\HorizontalScrollBar, @ScrollArea_ScrollBarHandler(), #PB_EventType_Change)
				SetProp_(GadgetID(\HorizontalScrollBar), "UITK_ScrollAreaData", *GadgetData)
				
				\VT\GetGadgetAttribute = @ScrollArea_GetAttribute()
				
				\VT\SetGadgetAttribute = @ScrollArea_SetAttribute()
				\VT\SetGadgetColor = @ScrollArea_SetColor()
				
				\VT\ResizeGadget = @ScrollArea_Resize()
				\VT\FreeGadget = @ScrollArea_Free()
				
				OpenGadgetList(\ScrollArea)
				AddMapElement(GadgetHandler(), Str(GadgetID(Gadget)))
				GadgetHandler() = Gadget
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
		VisibleScrollBar.b
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
		ReorderWindow.i	; We use the same window as drag window? Might add some issues since it's subclassed?
		ReorderCanvas.i
		
		Editable.l
		Editing.b
		EditCursor.b
		*String.StringData
		
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
		If State > #Cold		; hover (Warm) and selection (Hot) shade — otherwise the combo list is hard to read
			AddPathBox(X, Y, Width, Height)
			VectorSourceColor(*Theme\ShadeColor[State])
			FillPath()
			VectorSourceColor(*Theme\TextColor[State])
		EndIf
		
		DrawVectorTextBlock(@*Item\Text, X + #VerticalList_Margin, Y)
		
		If State = #Hot
			MovePathCursor(X + *Item\Text\Width - #VerticalList_IconWidth, Y + (*Item\Text\Height - 14) * 0.5)
			VectorFont(IconFont, 16)
			DrawVectorText("")
		EndIf
	EndProcedure
	
	Procedure VerticalList_Redraw(*GadgetData.VerticalListData)
		Protected Y = *GadgetData\OriginY, Width = *GadgetData\Width - 2 * *GadgetData\Border, Position, ItemCount, State, CurrentItem, Drawn
		
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
			
			If ListSize(\Items())
				If \VisibleScrollBar
					Position = Floor(\ScrollBar\State / \ItemHeight)
					Y - (\ScrollBar\State % \ItemHeight)
				EndIf
				
				SelectElement(\Items(), Position)
				
				If (\ReorderPosition > - 1) And Position > \ItemState
					NextElement(\Items())
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
					
					\ItemRedraw(@\Items(), \Border, Y, Width, \ItemHeight, State, \ThemeData)
					
					Y + \ItemHeight
					ItemCount + 1
				Until ItemCount > \MaxDisplayedItem Or (Not NextElement(\Items()))
				
				If CurrentItem + 1 = \ReorderPosition Or (\ReorderPosition = \State + 1 And Drawn = #False)
					AddPathBox(\Border, Y - 2, 80, 3)
					VectorSourceColor(\ThemeData\TextColor[#Cold])
					FillPath()
				EndIf
				
				If \Editing
					SaveVectorState()
					\String\Redraw(\String)
					RestoreVectorState()
				EndIf
				
				If \VisibleScrollBar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
				
			EndIf
		EndWith
	EndProcedure
	
	Procedure VerticalList_StateFocus(*GadgetData.VerticalListData)
		Protected Result
		
		With *GadgetData
			If \VisibleScrollBar
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
				If \ScrollBar\State < \ScrollBar\Max - \ScrollBar\PageLength
					Event\EventType = #MouseMove
					Event\MouseX = WindowX(\ReorderWindow) - \DragOriginX
					Event\MouseY = WindowY(\ReorderWindow) - \DragOriginY
					ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State + \ItemHeight)
					VerticalList_EventHandler(*GadgetData, @Event)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure VerticalList_BeginEdit(*GadgetData.VerticalListData)
		Protected Event.Event
		
		With *GadgetData
			If Not \Editable Or \Editing Or \State < 0 Or Not SelectElement(\Items(), \State)
				ProcedureReturn #False
			EndIf
			
			\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
			\String\String = \Items()\Text\OriginalText
			String_ProcessString(\String)
			
			\String\OriginX = \Items()\Text\TextX + #VerticalList_Margin + \Border
			; TextX (the item icon's share of the row) is already in the origin, so it
			; has to come off the width too, or the box overruns the row to the right.
			\String\Width = \Items()\Text\Width - \Items()\Text\TextX
			\String\OriginY = \State * \ItemHeight - \ScrollBar\State + \Items()\Text\TextY + \Border - 2
			
			Event\EventType = #Focus
			\String\EventHandler(\String, Event)
			StringSetSelection_Meta(\String, 0, Len(\String\String))
		EndWith
		
		ProcedureReturn #True
	EndProcedure
	
	Procedure VerticalList_EndEdit(*GadgetData.VerticalListData, Keep)
		Protected Event.Event
		
		With *GadgetData
			If Not \Editing
				ProcedureReturn #False
			EndIf
			
			\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
			
			If Keep And SelectElement(\Items(), \State)
				\Items()\Text\OriginalText = \String\String
				PrepareVectorTextBlock(@\Items()\Text)
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
			EndIf
			
			Event\EventType = #LostFocus
			\String\EventHandler(\String, Event)
		EndWith
		
		ProcedureReturn #True
	EndProcedure
	
	Procedure VerticalList_EventHandler(*GadgetData.VerticalListData, *Event.Event)
		Protected Redraw, Item, *Element, Image, Cursor = *GadgetData\EditCursor
		With *GadgetData
			
			Select *Event\EventType
				Case #MouseMove ;{
					If \String And \String\Selecting = #True ;{
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
						;}
					ElseIf \DragState = #Drag_Init ;{
						If Abs(\DragOriginX - *Event\MouseX) > #Drag_Distance Or Abs(\DragOriginY - *Event\MouseY) > #Drag_Distance
							If \Drag 
								Image = CreateImage(#PB_Any, \Width, \ItemHeight, 32, \ThemeData\ShadeColor[#Hot])
								SelectElement(\Items(),\State)
								
								StartVectorDrawing(ImageVectorOutput(Image))
								VectorSourceColor(\ThemeData\TextColor[#Hot])
								\ItemRedraw(@\Items(), \Border + #VerticalList_Margin, 0, \Width, \ItemHeight, #Hot, \ThemeData)
								StopVectorDrawing()
								
								; Offset the preview so the grabbed point of the row stays under the cursor.
								AdvancedDragPrivate(#Drag_VListItem, ImageID(Image), -\DragOriginX, \State * \ItemHeight - \ScrollBar\State - \DragOriginY)
								\DragState = #Drag_None
								FreeImage(Image)
								\DragState = #Drag_None
							Else
								\DragState = #Drag_Active
								\DragOriginX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginX
								\DragOriginY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginY + \ItemState * \ItemHeight - \ScrollBar\State
								\ReorderPosition = Clamp(Floor((*Event\MouseY + \ScrollBar\State + \ItemHeight * 0.5) / \ItemHeight), 0, ListSize(\Items()) - 1)
								
								If (ListSize(\Items()) - 1) * \ItemHeight > \Height 
									\VisibleScrollBar = #True
									ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \ScrollBar\Max - \ItemHeight)
								Else
									\VisibleScrollBar = #False
								EndIf
								
								StartVectorDrawing(CanvasVectorOutput(\ReorderCanvas))
								VectorSourceColor(\ThemeData\ShadeColor[#Hot])
								AddPathBox(0, 0, \Width, \ItemHeight)
								
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
						
						If \VisibleScrollBar
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
									ScrollBar_SetState_Meta(\ScrollBar, Max(0, Floor(\ScrollBar\State / \ItemHeight)) * \ItemHeight + (\ItemHeight - \ScrollBar\PageLength % \ItemHeight))
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
						Cursor = #PB_Cursor_Default
						
						If \VisibleScrollBar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
							Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
							
						ElseIf \ScrollBar\MouseState
							\ScrollBar\MouseState = #False
							Redraw = #True
						EndIf
						
						If Not \ScrollBar\MouseState
							Item = Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight)
							
							If Item >= ListSize(\Items())
								Item = -1
							EndIf
							
							If Item <> \ItemState
								\ItemState = Item
								Redraw = #True
							EndIf
							
							If Item = \State And \Editing
								If *Event\MouseY > \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height And *Event\MouseX > \String\OriginX
									Cursor = #PB_Cursor_IBeam
								EndIf
							EndIf
						Else
							\ItemState = -1
						EndIf
					EndIf ;}
						  ;}
				Case #LeftButtonDown ;{
					If \EditCursor
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					ElseIf \Editing
						Redraw = VerticalList_EndEdit(*GadgetData, #True)
					EndIf
					
					If \ScrollBar\MouseState
						Redraw + ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ItemState > -1
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
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \DragState = #Drag_Active
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
							\VisibleScrollBar = #True
							ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
						Else
							\VisibleScrollBar = #False
						EndIf
						
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
						
						Redraw = #True
						\ReorderPosition = -1
					ElseIf \String And \String\Selecting
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
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
					If \VisibleScrollBar
						ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 0.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not VerticalList_EventHandler(*GadgetData, *Event))
						
						If VerticalList_EndEdit(*GadgetData, #True)
							Redraw = #True
						EndIf
					EndIf
					;}
				Case #KeyDown ;{
					If \DragState = #Drag_None
						Select *Event\Param
							Case #PB_Shortcut_Down ;{
								If \State < ListSize(\Items()) - 1
									\State + 1
									VerticalList_StateFocus(*GadgetData)
									Redraw = #True
								EndIf ;}
							Case #PB_Shortcut_Up ;{
								If \State > 0
									\State - 1
									VerticalList_StateFocus(*GadgetData)
									Redraw = #True
								EndIf ;}
							Case #PB_Shortcut_F2 ;{
								Redraw = VerticalList_BeginEdit(*GadgetData)
								;}
							Case #PB_Shortcut_Return ;{
								Redraw = VerticalList_EndEdit(*GadgetData, #True)
								;}
							Case #PB_Shortcut_Escape ;{
								Redraw = VerticalList_EndEdit(*GadgetData, #False)	; keep the old name
																					;}
							Default													;{
								If \Editing
									Redraw = \String\EventHandler(\String, *Event)
								EndIf
								;}	
						EndSelect
					EndIf
					;}
				Case #LeftDoubleClick ;{
					If \ItemState > -1
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #EventType_ForcefulChange)
					EndIf
					;}
				Case #LostFocus ;{
					Redraw = VerticalList_EndEdit(*GadgetData, #True)
					;}
				Default ;{
					If \Editing
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					EndIf
					;}
			EndSelect
			
			If Cursor <> \EditCursor
				\EditCursor = Cursor
				\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
			EndIf
			
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
			\Items()\Text\FontID = \TextBlock\FontID
			\Items()\Text\FontScale = \TextBlock\FontScale
			
			\Items()\Text\Width = \TextBlock\Width - #VerticalList_Margin * 2
			\Items()\Text\Height = \ItemHeight
			\Items()\Text\VAlign = \TextBlock\VAlign
			\Items()\Text\HAlign = \TextBlock\HAlign
			
			PrepareVectorTextBlock(@\Items()\Text)
			
			If ListSize(\Items()) * \ItemHeight > \Height
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
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
					\VisibleScrollBar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
				Else
					\VisibleScrollBar = #False
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
				
				ProcedureReturn #True
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
			
			
			ScrollBar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			If ListSize(\Items()) * \ItemHeight > \Height
				\VisibleScrollBar = #True
			Else
				\VisibleScrollBar = #False
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
		If *GadgetData\Reorder And IsWindow(*GadgetData\ReorderWindow)
			CloseWindow(*GadgetData\ReorderWindow)
		EndIf
		DeleteMapElement(GadgetHandler(), Str(GadgetID(*GadgetData\Gadget)))
		FreeStructureX(*GadgetData\ScrollBar)
		
		If *GadgetData\Editable
			RemoveGadgetTimers(*GadgetData\String)
			FreeMemory(*GadgetData\String\ThemeData)	; the editor's own copy of the theme
			FreeStructureX(*GadgetData\String)
		EndIf
		
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
						\VisibleScrollBar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, ListSize(\Items()) * \ItemHeight)
					Else
						\VisibleScrollBar = #False
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
				Case #Attribute_TextScale ;{
					\TextBlock\FontScale = Value
					ForEach \Items()
						\Items()\Text\FontScale = Value
						PrepareVectorTextBlock(@\Items()\Text)
					Next
					;}
				Default ;{
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					ProcedureReturn	; already redraws
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
		Protected *GadgetData.VerticalListData = *this\vt, *Result
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				\Items()\Text\OriginalText = PeekS(*Text)
				PrepareVectorTextBlock(@\Items()\Text)
				RedrawObject()
				ProcedureReturn #True
			EndIf
		EndWith
	EndProcedure
	
	Procedure VerticalList_SetFont(*this.PB_Gadget, FontID)
		Protected *GadgetData.VerticalListData = *this\vt
		
		With *GadgetData
			\TextBlock\FontID = FontID
			
			ForEach \Items()
				\Items()\Text\FontID = FontID
				PrepareVectorTextBlock(@\Items()\Text)
			Next
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure VerticalList_Meta(*GadgetData.VerticalListData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags, *CustomItem)
		Protected GadgetList
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(VerticalList)
		
		With *GadgetData
			\TextBlock\Width = Width - #VerticalList_Margin
			
			If Not (Flags & (#VAlignCenter | #VAlignBottom))
				\TextBlock\VAlign = #VAlignCenter
			EndIf
			
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
			
			ScrollBar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \ItemHeight, Height , #Gadget_Vertical)
			
			\VT\SetGadgetAttribute = @VerticalList_SetAttribute()
			\VT\CountGadgetItems = @VerticalList_CountItem()
			\VT\SetGadgetItemData = @VerticalList_SetItemData()
			\VT\GetGadgetItemData = @VerticalList_GetItemData()
			\VT\RemoveGadgetItem = @VerticalList_RemoveItem()
			\VT\AddGadgetItem2 = @VerticalList_AddItem()
			\VT\ResizeGadget = @VerticalList_Resize()
			\VT\GetGadgetItemText = @VerticalList_GetItemText()
			\VT\SetGadgetItemText = @VerticalList_SetItemText()
			\VT\FreeGadget = @VerticalList_FreeGadget()
			\VT\GetGadgetItemImage = @VerticalList_GetItemImage()
			\VT\SetGadgetFont = @VerticalList_SetFont()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			\SupportedEvent[#KeyDown] = #True
			
			Protected *StringThemeData.Theme
			\Editable = Bool(Flags & #Editable)
			\EditCursor = #PB_Cursor_Default
			If \Editable
				*StringThemeData = AllocateMemory(SizeOf(Theme))
				CopyMemory(*ThemeData, *StringThemeData, SizeOf(Theme))
				*StringThemeData\CornerRadius = 0
				*StringThemeData\ShadeColor[#Cold] = *ThemeData\ShadeColor[#Hot]
				AllocateStructureX(\String, StringData)
				String_Meta(\String, *StringThemeData, Gadget, 0, 0, \Width, 20, "", #HAlignLeft | #Gadget_Meta)
				String_SupportedEvents()
				CloseGadgetList()
			EndIf
			
		EndWith
		
	EndProcedure
	
	Procedure VerticalList(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
		Protected Result, *this.PB_Gadget, *GadgetData.VerticalListData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Editable) * #PB_Canvas_Container))
			
			If Result
				CreateGadgetObject(VerticalListData)
				VerticalList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
				
				RedrawObject()
			EndIf
		EndIf
		
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
		HoverItem.l			; hovered item index, -1 when none (the base \MouseState stays a #Cold/#Warm/#Hot state)
		VisibleScrollBar.b
		InternalWidth.l
		DragOriginX.l
		DragOriginY.l
		
		Editable.l
		Editing.b
		EditCursor.b
		
		Drag.b
		DragState.b
		List Items.HorizontalList_Item()
		*ScrollBar.ScrollBarData
		*String.StringData
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
				VectorFont(\TextBlock\FontID)
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
						
						SaveVectorState()
						If \Editing
							String_Redraw(\String)
						EndIf
						RestoreVectorState()
					ElseIf ListIndex(\Items()) = \HoverItem
						HorizontalList_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Warm, \ThemeData)
					Else
						HorizontalList_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Cold, \ThemeData)
					EndIf
					
					X + \ItemWidth
				Until X > \Width Or Not NextElement(\Items())
			EndIf
			
			If \VisibleScrollBar
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
			
			ScrollBar_ResizeMeta(\ScrollBar, \Border + 1, \Height - \Border - 1 - #VerticalList_ToolbarThickness, \Width - \Border * 2 - 2, #VerticalList_ToolbarThickness)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Width)
			
			If \InternalWidth > \Width
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
			Else
				\VisibleScrollBar = #False
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
			If \VisibleScrollBar
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
	
	Procedure HorizontalList_BeginEdit(*GadgetData.HorizontalListData)
		Protected Event.Event
		
		With *GadgetData
			If Not \Editable Or \Editing Or \State < 0 Or Not SelectElement(\Items(), \State)
				ProcedureReturn #False
			EndIf
			
			\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
			\String\String = \Items()\Text\OriginalText
			String_ProcessString(\String)
			
			\String\OriginX = \State * \ItemWidth - \ScrollBar\State + \Border
			\String\OriginY = \Items()\Text\TextY - 1
			
			Event\EventType = #Focus
			\String\EventHandler(\String, Event)
			StringSetSelection_Meta(\String, 0, Len(\String\String))
		EndWith
		
		ProcedureReturn #True
	EndProcedure
	
	Procedure HorizontalList_EndEdit(*GadgetData.HorizontalListData, Keep)
		Protected Event.Event
		
		With *GadgetData
			If Not \Editing
				ProcedureReturn #False
			EndIf
			
			\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
			
			If Keep And SelectElement(\Items(), \State)
				\Items()\Text\OriginalText = \String\String
				PrepareVectorTextBlock(@\Items()\Text)
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
			EndIf
			
			Event\EventType = #LostFocus
			\String\EventHandler(\String, Event)
		EndWith
		
		ProcedureReturn #True
	EndProcedure
	
	Procedure HorizontalList_EventHandler(*GadgetData.HorizontalListData, *Event.Event)
		Protected Redraw, HoverItem, Keyboard, Image, Cursor = *GadgetData\EditCursor
		
		With *GadgetData
			Select *Event\EventType
				Case #Input ;{
					If \Editing
						Redraw = \String\EventHandler(\String, *Event)
					EndIf
					;}
				Case #MouseMove ;{
					If \EditCursor = #PB_Cursor_IBeam And \String\Selecting = #True
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					Else
						Cursor = #PB_Cursor_Default
						If \DragState = #Drag_None ;{
							If \VisibleScrollBar And (*Event\MouseY >= \ScrollBar\OriginY Or \ScrollBar\Drag = #True)
								Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
							ElseIf \ScrollBar\MouseState
								\ScrollBar\MouseState = #False
								Redraw = #True
							EndIf
							
							If Not \ScrollBar\MouseState
								HoverItem = Floor((*Event\MouseX + \ScrollBar\State) / \ItemWidth)
								If HoverItem <> \HoverItem
									\HoverItem = HoverItem
									Redraw = #True
								EndIf
								
								If HoverItem = \State
									If \Editing
										If *Event\MouseY > \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height
											Cursor = #PB_Cursor_IBeam
										EndIf
									EndIf
								EndIf
							ElseIf \HoverItem > -1
								\HoverItem = -1
								Redraw = #True
							EndIf
							;}
						ElseIf \DragState = #Drag_Init ;{
							If Abs(\DragOriginX - *Event\MouseX) > 7 Or Abs(\DragOriginY - *Event\MouseY) > 7
								Image = CreateImage(#PB_Any, \ItemWidth, \Height, 32, \ThemeData\ShadeColor[#Cold])
								StartVectorDrawing(ImageVectorOutput(Image))
								VectorFont(\TextBlock\FontID)
								VectorSourceColor(\ThemeData\TextColor[#Cold])
								SelectElement(\Items(),\State)
								HorizontalList_ItemRedraw(@\Items(), 0, 0, \ItemWidth, \Height, #Hot, \ThemeData)
								StopVectorDrawing()
								; Offset the preview so the grabbed point of the item stays under the cursor.
								AdvancedDragPrivate(#Drag_HListItem, ImageID(Image), \Border + \State * \ItemWidth - \ScrollBar\State - \DragOriginX, -\DragOriginY)
								\DragState = #Drag_None
								FreeImage(Image)
							EndIf
							;}
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \HoverItem > -1
						\HoverItem = -1
						Redraw = #True
					EndIf
					
					;}
				Case #LeftButtonDown ;{
					If \EditCursor
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					ElseIf \Editing
						Redraw = HorizontalList_EndEdit(*GadgetData, #True)
					EndIf
					
					If \ScrollBar\MouseState
						Redraw + ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \HoverItem > -1
						If \State <> \HoverItem
							\State = \HoverItem
							Redraw = #True
							PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							AddGadgetTimer(*GadgetData, 200, @HorizontalList_FocusTimer())
							
							If \Drag
								\DragState = #Drag_Init
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							EndIf
						Else
							If \Drag
								\DragState = #Drag_Init
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \EditCursor = #PB_Cursor_IBeam And \String\Selecting = #True
						Redraw = \String\EventHandler(\String, *Event)
					Else
						If \ScrollBar\Drag 
							Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
						EndIf
						\DragState = #Drag_None
					EndIf
					;}
				Case #LeftDoubleClick ;{
					If \HoverItem > -1
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #EventType_ForcefulChange)
					EndIf
					;}
				Case #KeyDown ;{
					Select *Event\Param
						Case #PB_Shortcut_Left ;{
							If \Editing
								Redraw = \String\EventHandler(\String, *Event)
							ElseIf \State > 0
								\State - 1
								HorizontalList_StateFocus(*GadgetData)
								Redraw = #True
							EndIf ;}
						Case #PB_Shortcut_Right ;{
							If \Editing
								Redraw = \String\EventHandler(\String, *Event)
							ElseIf \State < ListSize(\Items()) - 1
								\State + 1
								HorizontalList_StateFocus(*GadgetData)
								Redraw = #True
							EndIf ;}
						Case #PB_Shortcut_F2 ;{
							Redraw = HorizontalList_BeginEdit(*GadgetData)
							;}
						Case #PB_Shortcut_Escape ;{
							Redraw = HorizontalList_EndEdit(*GadgetData, #False)	; keep the old name
																					;}
						Case #PB_Shortcut_Return									;{
							Redraw = HorizontalList_EndEdit(*GadgetData, #True)
							;}
						Default	  ;{
							If \Editing
								Redraw = \String\EventHandler(\String, *Event)
							EndIf
							;}
					EndSelect
					;}
				Case #LostFocus ;{
					Redraw = HorizontalList_EndEdit(*GadgetData, #True)
					;}
				Default ;{
					If \Editing
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					EndIf
					;}
			EndSelect
			
			If Cursor <> \EditCursor
				\EditCursor = Cursor
				\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
			EndIf
			
			If Redraw
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure HorizontalList_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.HorizontalListData = *this\vt, *NewItem.HorizontalList_Item, HBitmap.UITK_BitmapInfo
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
			*NewItem\Text\FontID = \TextBlock\FontID
			*NewItem\Text\Width = \ItemWidth
			*NewItem\Text\Height = Floor(\Height * 0.9)
			*NewItem\Text\VAlign = #VAlignBottom
			*NewItem\Text\HAlign = #HAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			
			*NewItem\imageID = ImageID
			
			If *NewItem\imageID
				UITK_GetImageSize(*NewItem\imageID, @HBitmap)
				*NewItem\ImageX = (\ItemWidth - HBitmap\bmWidth) * 0.5
				*NewItem\ImageY = (\Height - 20 - HBitmap\bmHeight) * 0.5
			EndIf
			
			\InternalWidth = ListSize(\Items()) * \ItemWidth
			
			If \InternalWidth > \Width
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
			Else
				\VisibleScrollBar = #False
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
					\VisibleScrollBar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
				Else
					\VisibleScrollBar = #False
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
		
		FreeStructureX(*GadgetData\ScrollBar)
		
		If *GadgetData\Editable
			RemoveGadgetTimers(*GadgetData\String)
			FreeMemory(*GadgetData\String\ThemeData)
			FreeStructureX(*GadgetData\String)
		EndIf
		
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
						\VisibleScrollBar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalWidth)
					Else
						\VisibleScrollBar = #False
					EndIf
					
					ForEach \Items()
						\Items()\Text\Width = \ItemWidth
						PrepareVectorTextBlock(@\Items()\Text)
					Next
					;}
				Default ;{
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					ProcedureReturn	; already redraws
									;}
			EndSelect
		EndWith
		RedrawObject()
	EndProcedure
	
	
	Procedure HorizontalList_Meta(*GadgetData.HorizontalListData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(HorizontalList)
		
		With *GadgetData
			AllocateStructureX(\ScrollBar, ScrollBarData)
			\VisibleScrollBar = #False
			\ItemWidth = Height
			\State = -1
			\HoverItem = -1
			\Drag = Bool(Flags & #Drag)
			
			ScrollBar_Meta(\ScrollBar, *ThemeData, -1, \Border + 1, \Height - \Border - 1 - #VerticalList_ToolbarThickness, \Width - \Border * 2 - 2, #VerticalList_ToolbarThickness, 0, 0, \Width, #Null)
			
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
			
			Protected *StringThemeData.Theme
			\Editable = Bool(Flags & #Editable)
			\EditCursor = #PB_Cursor_Default
			If \Editable
				*StringThemeData = AllocateMemory(SizeOf(Theme))
				CopyMemory(*ThemeData, *StringThemeData, SizeOf(Theme))
				*StringThemeData\CornerRadius = 0
				*StringThemeData\ShadeColor[#Cold] = *ThemeData\ShadeColor[#Hot]
				AllocateStructureX(\String, StringData)
				String_Meta(\String, *StringThemeData, Gadget, 0, 0, \ItemWidth, 20, "", #HAlignCenter | #Gadget_Meta)
				String_SupportedEvents()
				CloseGadgetList()
			EndIf
			
		EndWith
	EndProcedure
	
	Procedure HorizontalList(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.HorizontalListData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Editable) * #PB_Canvas_Container))
			
			If Result
				CreateGadgetObject(HorizontalListData)
				HorizontalList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ TrackBar
	#TrackBar_Thickness = 7
	#TrackBar_CursorWidth = 10
	#TrackBar_CursorHeight = 24
	#TrackBar_IndentWidth = 20
	#TrackBar_Margin = 1
	
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
			VectorSourceColor(\ThemeData\LineColor[#Cold])
			TextHeight = VectorTextHeight("a")
			
			If \Vertical
				Height = \Height - 2 * #TrackBar_Margin
				Ratio = (Height - #TrackBar_CursorWidth) / (\Maximum - \Minimum)
				Progress = Round((\State - \Minimum) * Ratio, #PB_Round_Nearest)
				
				If \TextBlock\HAlign = #HAlignRight
					X = \OriginX + \Width - #TrackBar_CursorHeight - #TrackBar_Margin
					
					ForEach \Items()
						Y = Round((\Items()\Position - \Minimum) * Ratio + #TrackBar_Thickness * 0.5 + #TrackBar_Margin, #PB_Round_Nearest)
						MovePathCursor(X + 2, Y + 1)
						AddPathLine(#TrackBar_IndentWidth, 0, #PB_Path_Relative)
						MovePathCursor(0, Y - Floor(TextHeight * 0.5 ))
						DrawVectorParagraph(\Items()\Text, \Width - X, TextHeight, #PB_VectorParagraph_Right)
					Next
					
					If \DisplayState
						MovePathCursor(0, \OriginY  + #TrackBar_Thickness + Progress - Floor(TextHeight * 0.5 ))
						If \Scale = 1
							DrawVectorParagraph(Str(\State) + \Unit, \Width - X, TextHeight, #PB_VectorParagraph_Right)
						Else
							DrawVectorParagraph(StrD(\State * \Scale, 1) + \Unit, \Width - X, TextHeight, #PB_VectorParagraph_Right)
						EndIf
					EndIf
				Else
					X = \OriginX + #TrackBar_Margin
					
					ForEach \Items()
						Y = Round((\Items()\Position - \Minimum) * Ratio + #TrackBar_Thickness * 0.5 + #TrackBar_Margin, #PB_Round_Nearest)
						MovePathCursor(X + 2, Y + 1)
						AddPathLine(#TrackBar_IndentWidth, 0, #PB_Path_Relative)
						MovePathCursor(X + #TrackBar_CursorHeight + #TrackBar_Margin, Y - Floor(TextHeight * 0.5 ))
						DrawVectorParagraph(\Items()\Text, \Width, TextHeight, #PB_VectorParagraph_Left)
					Next
					
					If \DisplayState
						MovePathCursor(X + #TrackBar_CursorHeight + #TrackBar_Margin, \OriginY  + #TrackBar_Thickness + Progress - Floor(TextHeight * 0.5 ))
						If \Scale = 1
							DrawVectorParagraph(Str(\State) + \Unit, \Width, TextHeight, #PB_VectorParagraph_Left)
						Else
							DrawVectorParagraph(StrD(\State * \Scale, 1) + \Unit, \Width, TextHeight, #PB_VectorParagraph_Left)
						EndIf
					EndIf
				EndIf
				
				X + #TrackBar_CursorHeight * 0.5
				Y = \OriginY + #TrackBar_Margin
				
				VectorSourceColor(\ThemeData\ShadeColor[#Warm])
				StrokePath(2)
				AddPathBox(X - #TrackBar_Thickness * 0.5, Y + #TrackBar_Thickness * 0.5 + Progress, #TrackBar_Thickness, Height - #TrackBar_Thickness - Progress)
				AddPathCircle(X, Y + Height - #TrackBar_Thickness * 0.5, #TrackBar_Thickness * 0.5)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\ThemeData\Special3[#Cold])
				AddPathCircle(X, Y + #TrackBar_Thickness * 0.5, #TrackBar_Thickness * 0.5)
				AddPathBox(X - #TrackBar_Thickness * 0.5, Y + #TrackBar_Thickness * 0.5, #TrackBar_Thickness, Progress)
				FillPath(#PB_Path_Winding)
				
				AddPathRoundedBox(X - #TrackBar_CursorHeight * 0.5, Y + Progress, #TrackBar_CursorHeight, #TrackBar_CursorWidth, 3)
			Else
				Width = \Width - 2 * #TrackBar_Margin
				Ratio = (Width - #TrackBar_CursorWidth) / (\Maximum - \Minimum)
				Progress = Round((\State - \Minimum) * Ratio, #PB_Round_Nearest)
				
				If \TextBlock\VAlign = #VAlignTop
					Y = \OriginY + #TrackBar_Margin
					
					ForEach \Items()
						X = Round((\Items()\Position - \Minimum) * Ratio + #TrackBar_Thickness * 0.5 + #TrackBar_Margin, #PB_Round_Nearest)
						
						MovePathCursor(X + 1, Y + 2)
						AddPathLine(0, #TrackBar_IndentWidth, #PB_Path_Relative)
						MovePathCursor(X - 24, Y + #TrackBar_Margin + #TrackBar_CursorHeight)
						DrawVectorParagraph(\Items()\Text, 50, TextHeight, #PB_VectorParagraph_Center)
					Next
					
					If \DisplayState
						If \Scale = 1
							Text = Str(\State) + \Unit
						Else
							Text = StrD(\State * \Scale, 1) + \Unit
						EndIf
						
						TextWidth = VectorTextWidth(Text)
						MovePathCursor(\OriginX + Min(Max(#TrackBar_Thickness + Progress - TextWidth * 0.4, 0), \Width - TextWidth), Y + #TrackBar_Margin + #TrackBar_CursorHeight)
						DrawVectorParagraph(Text, 50, TextHeight, #PB_VectorParagraph_Left)
					EndIf
					
					Y + #TrackBar_CursorHeight * 0.5
				Else
					Y = \OriginY + \Height - #TrackBar_CursorHeight - #TrackBar_Margin
					
					ForEach \Items()
						X = Round((\Items()\Position - \Minimum) * Ratio + #TrackBar_Thickness * 0.5 + #TrackBar_Margin, #PB_Round_Nearest)
						
						MovePathCursor(X + 1, Y + 2)
						AddPathLine(0, #TrackBar_IndentWidth, #PB_Path_Relative)
						MovePathCursor(X - 24, Y - TextHeight - #TrackBar_Margin)
						DrawVectorParagraph(\Items()\Text, 50, TextHeight, #PB_VectorParagraph_Center)
					Next
					
					If \DisplayState
						If \Scale = 1
							Text = Str(\State) + \Unit
						Else
							Text = StrD(\State * \Scale, 1) + \Unit
						EndIf
						
						TextWidth = VectorTextWidth(Text)
						MovePathCursor(\OriginX + Min(Max(#TrackBar_Thickness + Progress - TextWidth * 0.4, 0), \Width - TextWidth), Y + #TrackBar_Margin + #TrackBar_CursorHeight)
						DrawVectorParagraph(Text, 50, TextHeight, #PB_VectorParagraph_Left)
					EndIf
					
					Y + #TrackBar_CursorHeight * 0.5
				EndIf
				
				X = \OriginX + #TrackBar_Margin
				
				VectorSourceColor(\ThemeData\ShadeColor[#Warm])
				StrokePath(2)
				AddPathBox(X + #TrackBar_Thickness * 0.5 + Progress, Y - #TrackBar_Thickness * 0.5, Width - #TrackBar_Thickness - Progress, #TrackBar_Thickness)
				AddPathCircle(X + Width - #TrackBar_Thickness * 0.5, Y, #TrackBar_Thickness * 0.5)
				FillPath(#PB_Path_Winding)
				
				VectorSourceColor(\ThemeData\Special3[#Cold])
				AddPathCircle(X + #TrackBar_Thickness * 0.5, Y, #TrackBar_Thickness * 0.5)
				AddPathBox(X + #TrackBar_Thickness * 0.5, Y - #TrackBar_Thickness * 0.5, Progress, #TrackBar_Thickness)
				FillPath(#PB_Path_Winding)
				
				AddPathRoundedBox(X + Progress, Y - #TrackBar_CursorHeight * 0.5, #TrackBar_CursorWidth, #TrackBar_CursorHeight, 3)
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
							NewState = Clamp(\Minimum + Round((*Event\MouseY - \DragOffset) / (\Height - #TrackBar_CursorWidth - #TrackBar_Margin * 2) * (\Maximum - \Minimum), #PB_Round_Nearest), \Minimum, \Maximum)
							If \State <> NewState
								\State = NewState
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
						Else
							NewState = Clamp(\Minimum + Round((*Event\MouseX - \DragOffset) / (\Width - #TrackBar_CursorWidth - #TrackBar_Margin * 2) * (\Maximum - \Minimum), #PB_Round_Nearest), \Minimum, \Maximum)
							If \State <> NewState
								\State = NewState
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
						EndIf
					Else
						If \Vertical
							CursorY = \OriginY + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Height - #TrackBar_CursorWidth - #TrackBar_Margin * 2), #PB_Round_Nearest) + #TrackBar_Margin
							
							If \TextBlock\HAlign = #HAlignRight
								CursorX = \OriginX + \Width - #TrackBar_CursorHeight - #TrackBar_Margin
							Else
								CursorX = \OriginX + #TrackBar_Margin
							EndIf
							
							If (*Event\MouseX >= CursorX) And (*Event\MouseY >= CursorY) And (*Event\MouseX <= CursorX + #TrackBar_CursorHeight) And (*Event\MouseY <= CursorY + #TrackBar_CursorWidth)
								\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_UpDown)
								\Hover = #True
							Else
								\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_Default)
								\Hover = #False
							EndIf
						Else
							CursorX = \OriginX + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Width - #TrackBar_CursorWidth - #TrackBar_Margin * 2), #PB_Round_Nearest) + #TrackBar_Margin
							
							If \TextBlock\VAlign = #VAlignBottom
								CursorY = \OriginY + \Height - #TrackBar_CursorHeight - #TrackBar_Margin
							Else
								CursorY = \OriginY + #TrackBar_Margin
							EndIf
							
							If (*Event\MouseX >= CursorX) And (*Event\MouseY >= CursorY) And (*Event\MouseX <= CursorX + #TrackBar_CursorWidth) And (*Event\MouseY <= CursorY + #TrackBar_CursorHeight)
								\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_LeftRight)
								\Hover = #True
							Else
								\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_Default)
								\Hover = #False
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \Hover
						\Drag = #True
						If \Vertical
							\DragOffset = *Event\MouseY - Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Height - #TrackBar_CursorWidth - #TrackBar_Margin * 2), #PB_Round_Nearest)
						Else
							\DragOffset = *Event\MouseX - Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Width - #TrackBar_CursorWidth - #TrackBar_Margin * 2), #PB_Round_Nearest)
						EndIf
					Else
						If \Vertical
							CursorY = \OriginY + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Height - #TrackBar_CursorWidth), #PB_Round_Nearest)
							
							If *Event\MouseY < CursorY
								NewState = Clamp(\State - Max(Round((\Maximum - \Minimum) * 0.1, #PB_Round_Nearest), 1), \Minimum, \Maximum)
							Else
								NewState = Clamp(\State + Max(Round((\Maximum - \Minimum) * 0.1, #PB_Round_Nearest), 1), \Minimum, \Maximum)
							EndIf
							
						Else
							CursorX = \OriginX + Round((\State - \Minimum) / (\Maximum - \Minimum) * (\Width - #TrackBar_CursorWidth), #PB_Round_Nearest)
							
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
	
	Procedure TrackBar_AddGadgetItem(*this.PB_Gadget, Position, *Text, ImageID)
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
	
	Procedure TrackBar_SetText(*this.PB_Gadget, Text.s)
		Protected *GadgetData.TrackBarData = *this\vt
		*GadgetData\Unit = Text
		RedrawObject()
	EndProcedure
	
	Procedure TrackBar_SetAttribute(*this.PB_Gadget, Attribute, Value)
		Protected *GadgetData.TrackBarData = *this\vt
		
		With *GadgetData
			Select Attribute
				Case #TrackBar_Scale ;{
					\Scale = 1 / Value
					;}
				Default ;{
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					ProcedureReturn	; already redraws
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
			\DisplayState = Bool(Flags & #TrackBar_ShowState)
			\Scale = 1
			
			If \Vertical
				\HMargin = 30
				\VMargin = 50
			Else
				\HMargin = 50
				\VMargin = 20
			EndIf
			
			\TextBlock\RequiredHeight = \VMargin * 2
			\TextBlock\RequiredWidth = \HMargin * 2
			\TextBlock\FontID = BoldFont
			
			\VT\AddGadgetItem2 = @TrackBar_AddGadgetItem()
			\VT\SetGadgetText = @TrackBar_SetText()
			\vt\SetGadgetAttribute = @TrackBar_SetAttribute()
			
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
				CreateGadgetObject(TrackBarData)
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
		*ScrollBar.ScrollBarData
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
			
			DrawVectorTextBlock(@\TextBlock, \OriginX + #Combo_ItemMargin, \OriginY + \VMargin)
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
	
	Procedure Combo_CountItems(*this.PB_Gadget)
		Protected *GadgetData.ComboData = *this\vt
		ProcedureReturn *GadgetData\ItemCount
	EndProcedure
	
	Procedure Combo_SetItemData(*this.PB_Gadget, Position, *Data)
		Protected *GadgetData.ComboData = *this\vt
		SetGadgetItemData(*GadgetData\MenuCanvas, Position, *Data)
	EndProcedure
	
	Procedure Combo_GetItemData(*this.PB_Gadget, Position)
		Protected *GadgetData.ComboData = *this\vt
		ProcedureReturn GetGadgetItemData(*GadgetData\MenuCanvas, Position)
	EndProcedure
	
	Procedure Combo_SetItemText(*this.PB_Gadget, Position, *Text)
		Protected *GadgetData.ComboData = *this\vt
		With *GadgetData
			If SetGadgetItemText(\MenuCanvas, Position, PeekS(*Text)) And \State = Position
				\TextBlock\OriginalText = PeekS(*Text)
				PrepareVectorTextBlock(@\TextBlock)
				RedrawObject()
			EndIf
		EndWith
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
		*GadgetData\TextBlock\OriginalText = *VListData\Items()\Text\OriginalText
		*GadgetData\TextBlock\Image = *VListData\Items()\Text\Image
		PrepareVectorTextBlock(@*GadgetData\TextBlock)
		*GadgetData\Unfolded = #False
		RedrawObject()
		HideWindow(*GadgetData\MenuWindow , #True)
		PostEvent(#PB_Event_Gadget, *GadgetData\ParentWindow, *GadgetData\Gadget, #PB_EventType_Change)
	EndProcedure
	
	Procedure Combo_Free(*this.PB_Gadget)
		Protected *GadgetData.ComboData = *this\vt
		
		With *GadgetData
			DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
			If IsGadget(\MenuCanvas)
				UnbindGadgetEvent(\MenuCanvas, @Combo_VListHandler(), #PB_EventType_Change)
				FreeGadget(\MenuCanvas)
			EndIf
			
			If IsWindow(\MenuWindow)
				UnbindEvent(#PB_Event_DeactivateWindow, @Combo_WindowHandler(), \MenuWindow)
				CloseWindow(\MenuWindow)
			EndIf
			
			If \DefaultEventHandler
				UnbindGadgetEvent(\Gadget, \DefaultEventHandler)
			EndIf
			
			RemoveGadgetTimers(*GadgetData)
			*this\vt = \OriginalVT
			FreeStructureX(\ThemeData)
		EndWith
		
		FreeStructureX(*GadgetData)
		
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
	
	Procedure Combo_RemoveItem(*this.PB_Gadget, Position)
		Protected *GadgetData.ComboData = *this\vt
		
		If RemoveGadgetItem(*GadgetData\MenuCanvas, Position)
			*GadgetData\ItemCount - 1
			
			If *GadgetData\ItemCount <= 7
				ResizeGadget(*GadgetData\MenuCanvas, #PB_Ignore, #PB_Ignore, #PB_Ignore, *GadgetData\ItemCount * #Combo_ItemHeight)
				ResizeWindow(*GadgetData\MenuWindow, #PB_Ignore, #PB_Ignore, #PB_Ignore, *GadgetData\ItemCount * #Combo_ItemHeight + *GadgetData\Border)
			EndIf
		EndIf
	EndProcedure
	
	Procedure Combo_SetState(*this.PB_Gadget, State)
		Protected *GadgetData.ComboData = *this\vt
		Protected *SubGadget.PB_Gadget = IsGadget(*GadgetData\MenuCanvas), *VListData.VerticalListData = *SubGadget\vt
		
		SetGadgetState(*GadgetData\MenuCanvas, State)
		*VListData\State = State
		*GadgetData\State = State
		SelectElement(*VListData\Items(), *VListData\State)
		*GadgetData\TextBlock\OriginalText = *VListData\Items()\Text\OriginalText
		*GadgetData\TextBlock\Image = *VListData\Items()\Text\Image
		PrepareVectorTextBlock(@*GadgetData\TextBlock)
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
			*GadgetData\TextBlock\VAlign = #VAlignCenter
			
			\HMargin = #Combo_Margin + \Border
			\VMargin = #Combo_Margin
			
			\TextBlock\Width = Width - \HMargin * 2
			\TextBlock\Height = Height - \VMargin * 2
			
			\MenuState = -1
			\State = -1
			
			\MenuWindow = OpenWindow(#PB_Any, 0, 0, \Width, 0, "", #PB_Window_BorderLess | #PB_Window_Invisible, WindowID(CurrentWindow()))
			SetProp_(WindowID(\MenuWindow), "UITK_ComboData", *GadgetData)
			BindEvent(#PB_Event_DeactivateWindow, @Combo_WindowHandler(), \MenuWindow)
			
			SetWindowColor(\MenuWindow, RGB(Red(\ThemeData\LineColor[#Warm]), Green(\ThemeData\LineColor[#Warm]), Blue(\ThemeData\LineColor[#Warm])))
			
			\MenuCanvas = VerticalList(#PB_Any, \Border, 0, \Width - \Border * 2, \Height)
			SetGadgetAttribute(\MenuCanvas, #Attribute_CornerRadius, 0)
			
			UseGadgetList(GadgetList)
			
			SetProp_(GadgetID(\MenuCanvas), "UITK_ComboData", *GadgetData)
			BindGadgetEvent(\MenuCanvas, @Combo_VListHandler(), #PB_EventType_Change)
			Default_SetAttribute(\this, #Attribute_CornerRadius, 0)
			
			SetGadgetColor(\MenuCanvas, #Color_Shade_Cold, \ThemeData\BackColor[#Warm])
			SetGadgetColor(\MenuCanvas, #Color_Shade_Warm, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\MenuCanvas, #Color_Shade_Hot, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\MenuCanvas, #Color_Text_Cold, \ThemeData\TextColor[#Cold])
			SetGadgetColor(\MenuCanvas, #Color_Text_Warm, \ThemeData\TextColor[#Warm])
			SetGadgetColor(\MenuCanvas, #Color_Text_Hot, \ThemeData\TextColor[#Hot])
			
			\VT\AddGadgetItem2 = @Combo_AddItem()
			\VT\RemoveGadgetItem = @Combo_RemoveItem()
			\VT\SetGadgetState = @Combo_SetState()
			\VT\SetGadgetColor = @Combo_SetColor()
			\VT\FreeGadget = @Combo_Free()
			\VT\SetGadgetItemData = @Combo_SetItemData()
			\VT\SetGadgetItemText = @Combo_SetItemText()
			\VT\GetGadgetItemData = @Combo_GetItemData()
			\VT\CountGadgetItems = @Combo_CountItems()
			
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
				CreateGadgetObject(ComboData)
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
				CreateGadgetObject(ContainerData)
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
				DrawVectorTextBlock(@\TextBlock, X + \HMargin, 0)
				X = \OriginX + \Width - #RadioSize - BorderMargin - \HMargin
			ElseIf \HAlign = #HAlignRight
				DrawVectorTextBlock(@\TextBlock, X + \HMargin, 0)
				X = \OriginX + BorderMargin + \HMargin
			Else
				X = \OriginX + BorderMargin + \HMargin
				DrawVectorTextBlock(@\TextBlock, X + \HMargin + #RadioSize, 0)
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
			\TextBlock\Width = Width - #RadioSize - BorderMargin * 2
			\TextBlock\Height = Height - BorderMargin * 2
			\TextBlock\OriginalText = Text
			\HMargin = #RadioSize * 0.5 + BorderMargin
			\VMargin = BorderMargin
			\HAlign = \TextBlock\HAlign
			
			If Flags & #HAlignCenter
				\TextBlock\HAlign = #HAlignLeft
			EndIf
			
			\TextBlock\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			
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
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Container) * #PB_Canvas_Container))
			
			If Result
				CreateGadgetObject(RadioData)
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
		VisibleScrollBar.b
		
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
						If \SectionHeight
							\RedrawSection(@\Sections(), \OriginX, Y, \Width, \SectionHeight, 0, \ThemeData)
						EndIf
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
				
				If \VisibleScrollBar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure Library_RedrawSection(*Section.Library_Section, X, Y, Width, Height, State, *Theme.Theme)
		DrawVectorTextBlock(@*Section\Text, X + 20, Y)
	EndProcedure
	
	Procedure Library_RedrawItem(*Item.Library_Item, X, Y, Width, Height, State, *Theme.Theme)
		Protected TextHeight = Height - *Item\Text\Height
		With *Item
			MovePathCursor(X + \ImageX, Y + \ImageY)
			DrawVectorImage(\ImageID)
			
			DrawVectorTextBlock(@\Text, X, Y + TextHeight + 2)
			
			If \HoverState
				AddPathBox(X, Y, Width, TextHeight)
				VectorSourceColor(SetAlpha($FFFFFF, 35))
				FillPath()
				VectorSourceColor(*Theme\TextColor[#Cold])
			EndIf
			
			If \Selected
				AddPathBox(X - 0.5, Y - 0.5, Width + 1, TextHeight + 1)
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
			*NewSection\Text\FontID = \TextBlock\FontID
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
	
	Procedure Library_AddItem(*This.PB_Gadget, Position.w, *Text, ImageID, Flags.i)
		Protected *GadgetData.LibraryData = *this\vt, *NewItem.Library_Item, HBitmap.UITK_BitmapInfo
		
		With *GadgetData
			LastElement(\Items())
			*NewItem = AddElement(\Items())
			
			*NewItem\ImageID = ImageID
			*NewItem\Text\OriginalText = PeekS(*Text)
			*NewItem\Text\LineLimit = 1
			*NewItem\Text\FontID = \TextBlock\FontID
			*NewItem\Text\Width = \ItemWidth
			*NewItem\Text\Height = #Library_ItemTextHeight
			*NewItem\Text\VAlign = #VAlignTop
			*NewItem\Text\HAlign = #HAlignLeft
			
			PrepareVectorTextBlock(@*NewItem\Text)
			
			UITK_GetImageSize(*NewItem\ImageID, @HBitmap)
			
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
			
			If Position > -1 And SelectElement(\Sections()\Items(), Position)
				InsertElement(\Sections()\Items())
			Else
				LastElement(\Sections()\Items())
				AddElement(\Sections()\Items())
			EndIf
			
			\Sections()\Items() = *NewItem
			
			If (ListSize(\Sections()\Items()) - 1) % \ItemPerLine = 0
				If ListSize(\Sections()\Items()) = 1
					\Sections()\Height + \SectionHeight
					\InternalHeight + \SectionHeight
				EndIf
				\Sections()\Height + (\ItemVMargin + \ItemHeight)
				\InternalHeight + (\ItemVMargin + \ItemHeight)
				
				If \InternalHeight > \Height
					\VisibleScrollBar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
				Else
					\VisibleScrollBar = #False
				EndIf
				
			EndIf
			
			Position = ListIndex(\Items())
			
		EndWith
		
		RedrawObject()
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure Library_EventHandler(*GadgetData.LibraryData, *Event.Event)
		Protected Redraw, NewItem = -1, ItemRow, Image
		Protected *DraggedItem.Library_Item, *DragSection.Library_Section, InSection, SectionY, CellX, CellY
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					If \DragState = #Drag_None
						If \VisibleScrollBar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
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
							
							; Resolve the dragged item's on-screen cell so the preview keeps the grabbed point under the cursor.
							*DraggedItem = @\Items()
							*DragSection = \Items()\Section
							SectionY = -\ScrollBar\State
							ForEach \Sections()
								If @\Sections() = *DragSection
									Break
								EndIf
								SectionY + \Sections()\Height
							Next
							
							InSection = 0
							ForEach *DragSection\Items()
								If *DragSection\Items() = *DraggedItem
									Break
								EndIf
								InSection + 1
							Next
							
							ItemRow = InSection / \ItemPerLine
							CellX = \ItemHMargin + (InSection % \ItemPerLine) * (\ItemHMargin + \ItemWidth)
							CellY = SectionY + \SectionHeight + ItemRow * (\ItemHeight + \ItemVMargin)
							
							AdvancedDragPrivate(#Drag_LibraryItem, \Items()\ImageID, CellX + \Items()\ImageX - \DragOriginX, CellY + \Items()\ImageY - \DragOriginY)
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
				Case #LeftClick ;{
								; A completed click confirms the press-time selection: post Change
								; like Tab/ToolBar. Posting at PRESS time instead made every drag
								; start fire the event too (the press arms the drag); after a real
								; drag the OS consumes the release, so no click ever arrives here —
								; the event is click-only by construction.
					If \ItemState > -1
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
					EndIf
					;}
				Case #LeftDoubleClick ;{
									  ;}
				Case #MouseWheel	  ;{
					If \VisibleScrollBar
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
						\VisibleScrollBar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
					Else
						\VisibleScrollBar = #False
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
			
			\State = -1
			\InternalHeight = 0
			\VisibleScrollBar = #False
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
			
			ScrollBar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
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
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollBar = #False
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
	
	Procedure Library_SetItemText(*this.PB_Gadget, Position, *Text)
		Protected *GadgetData.LibraryData = *this\vt
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			*GadgetData\Items()\Text\OriginalText = PeekS(*Text)
			PrepareVectorTextBlock(@*GadgetData\Items()\Text)
			
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
				Case #Attribute_Library_ItemWidth
					\ItemWidth = Value
					; The width-dependent layout must follow, or the gadget keeps
					; the old items-per-line until the first resize recomputes it
					\ItemPerLine = Floor((\Width - \ItemMinimumHMargin) / (\ItemWidth + \ItemMinimumHMargin))
					\ItemHMargin = Floor((\Width - \ItemPerLine * \ItemWidth) / (\ItemPerLine + 1))
					\InternalHeight = 0
					ForEach \Sections()
						If \Sections()\Height
							\Sections()\Height = \SectionHeight
							\Sections()\Height + Round(ListSize(\Sections()\Items()) / \ItemPerLine, #PB_Round_Up) * (\ItemVMargin + \ItemHeight)
							\InternalHeight + \Sections()\Height
						EndIf
					Next
					If \InternalHeight > \Height
						\VisibleScrollBar = #True
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
					Else
						\VisibleScrollBar = #False
					EndIf
				Default
					Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
					ProcedureReturn	; already redraws
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
	
	
	Procedure Library_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.LibraryData = *this\vt
		
		FreeStructureX(*GadgetData\ScrollBar)
		
		Default_FreeGadget(*this)
	EndProcedure
	
	Procedure Library_Meta(*GadgetData.LibraryData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Library)
		
		With *GadgetData
			
			AllocateStructureX(\ScrollBar, ScrollBarData)
			ScrollBar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \InternalHeight, Height , #Gadget_Vertical)
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
			
			\Width = Width		; Only Resize used to set these, so the per-line math
			\Height = Height	; below ran on width 0 until the first resize
			\ItemPerLine = Floor((\Width - \ItemMinimumHMargin) / (\ItemWidth + \ItemMinimumHMargin))
			\ItemHMargin = Floor((\Width - \ItemPerLine * \ItemWidth) / (\ItemPerLine + 1))
			
			\VT\AddGadgetColumn = @Library_AddColumn()
			\VT\AddGadgetItem3 = @Library_AddItem()
			\VT\RemoveGadgetItem = @Library_RemoveItem()
			\VT\ClearGadgetItemList = @Library_ClearItems()
			\VT\ResizeGadget = @Library_Resize()
			
			\VT\SetGadgetItemData = @Library_SetItemData()
			\VT\SetGadgetItemText = @Library_SetItemText()
			\VT\SetGadgetAttribute = @Library_SetAttribute()
			
			\VT\GetGadgetItemData = @Library_GetItemData()
			\VT\GetGadgetItemImage = @Library_GetItemImage()
			\VT\CountGadgetItems = @Library_CountItem()
			\VT\FreeGadget = @Library_FreeGadget()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftClick] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			\SupportedEvent[#KeyDown] = #True
		EndWith
	EndProcedure
	
	Procedure Library(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
		Protected Result, *this.PB_Gadget, *GadgetData.LibraryData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
		
		If Result
			CreateGadgetObject(LibraryData)
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
	#PropertyBox_ValueMargin = 4			; horizontal inset of the value cell from the divider and the right edge
	#PropertyBox_CellInset = 3				; vertical inset of the checkbox / colour swatch inside a row
	#PropertyBox_FontEllipsisWidth = 14		; space kept clear at the right of a Font row for its "..."
	
	Structure PropertyBox_Item
		Text.Text							; label (left column)
		Type.l								; #PropertyBox_* row type
		Value.Text							; prepared display text for the value cell (Text / TextNumerical content, or the selected Combo option)
		State.q								; CheckBox tri-state / Color (stored the way ColorPicker does) / Combo selected index
		Options.s							; Combo: newline-delimited option list
		FontName.s							; Font: family, kept apart from Value's "name, size" display text
		FontSize.l							; Font: point size
		FontStyle.l							; Font: #PB_Font_* bits
	EndStructure
	
	Structure PropertyBoxData Extends GadgetData
		InternalHeight.l
		ItemHeight.l
		MarginWidth.l
		ColumnWidth.l
		ContentWidth.l
		VisibleScrollBar.b
		Editing.b							; a Text / TextNumerical value is currently being edited inline
		EditItem.l							; index of the row being edited
		EditNumeric.b						; that row is a TextNumerical (input is filtered to numbers)
		EditCursor.b						; last cursor pushed onto the canvas (I-beam over the editor)
		*String.StringData					; shared inline String editor (meta gadget, repositioned onto the active row)
		ComboPopupWindow.i					; shared dropdown popup for Combo cells (borderless window + VerticalList)
		ComboPopupList.i
		ColorPopupWindow.i					; shared popup for Color cells (borderless window + ColorPicker)
		ColorPopupPicker.i
		PopupItem.l							; row a popup is currently editing
		*ScrollBar.ScrollBarData
		List Items.PropertyBox_Item()
	EndStructure
	
	Procedure PropertyBox_ValueWidth(*GadgetData.PropertyBoxData)
		ProcedureReturn *GadgetData\Width - *GadgetData\ColumnWidth - *GadgetData\MarginWidth - #PropertyBox_ValueMargin * 2 - (Bool(*GadgetData\VisibleScrollBar) * #VerticalList_ToolbarThickness)
	EndProcedure
	
	Procedure PropertyBox_PrepareValue(*GadgetData.PropertyBoxData, *Item.PropertyBox_Item)
		With *Item
			\Value\FontID = *GadgetData\TextBlock\FontID
			\Value\Height = *GadgetData\ItemHeight
			\Value\Width = PropertyBox_ValueWidth(*GadgetData)
			
			; A font summary can be long ("Georgia, 18 Bold Italic"), so keep it clear of the
			; ellipsis rather than letting it run underneath.
			If \Type = #PropertyBox_Font
				\Value\Width - #PropertyBox_FontEllipsisWidth
			EndIf
			\Value\VAlign = #VAlignCenter
			\Value\LineLimit = 1
			
			; Combo shows the currently selected option, Font a "family, size" summary; the others
			; display their own text verbatim.
			If \Type = #PropertyBox_Combo
				\Value\OriginalText = StringField(\Options, \State + 1, #LF$)
			ElseIf \Type = #PropertyBox_Font
				If \FontName
					\Value\OriginalText = \FontName + ", " + Str(\FontSize)
					If \FontStyle & #PB_Font_Bold
						\Value\OriginalText + " Bold"
					EndIf
					If \FontStyle & #PB_Font_Italic
						\Value\OriginalText + " Italic"
					EndIf
				Else
					\Value\OriginalText = ""
				EndIf
			EndIf
			
			PrepareVectorTextBlock(@\Value)
		EndWith
	EndProcedure
	
	Procedure PropertyBox_DrawValue(*GadgetData.PropertyBoxData, *Item.PropertyBox_Item, ValueX, Y)
		Protected CellSize = *GadgetData\ItemHeight - #PropertyBox_CellInset * 2, CellY = Y + #PropertyBox_CellInset, Center
		
		With *GadgetData
			Select *Item\Type
				Case #PropertyBox_CheckBox ;{ Same glyph as the standalone CheckBox gadget
					VectorSourceColor(\ThemeData\FrontColor[#Cold])
					AddPathBox(ValueX, CellY, CellSize, CellSize)
					AddPathBox(ValueX + CellSize * 0.1, CellY + CellSize * 0.1, CellSize * 0.8, CellSize * 0.8)
					
					If *Item\State = #True
						AddPathBox(ValueX + CellSize, CellY, CellSize * -0.25, CellSize * 0.1)
						AddPathBox(ValueX + CellSize * 0.9, CellY + CellSize * 0.1, CellSize * 0.1, CellSize * 0.25)
						FillPath()
						
						VectorSourceColor(\ThemeData\FrontColor[#Cold])
						MovePathCursor(ValueX + CellSize * 0.2, CellY + CellSize * 0.4)
						AddPathLine(CellSize * 0.28, CellSize * 0.28, #PB_Path_Relative)
						AddPathLine(CellSize * 0.5, -CellSize * 0.7, #PB_Path_Relative)
						StrokePath(2)
					Else
						FillPath()
						If *Item\State = #PB_Checkbox_Inbetween
							AddPathBox(ValueX + CellSize * 0.25, CellY + CellSize * 0.25, CellSize * 0.5, CellSize * 0.5)
							VectorSourceColor(\ThemeData\FrontColor[#Cold])
							FillPath()
						EndIf
					EndIf
					;}
				Case #PropertyBox_Color ;{ Swatch filling the value cell
					AddPathRoundedBox(ValueX, CellY, PropertyBox_ValueWidth(*GadgetData), CellSize, 2)
					VectorSourceColor(SetAlpha(*Item\State, 255))
					FillPath(#PB_Path_Preserve)
					VectorSourceColor(\ThemeData\LineColor[#Cold])
					StrokePath(1)
					;}
				Case #PropertyBox_Combo ;{ Selected option + a downward chevron
					VectorSourceColor(\ThemeData\TextColor[#Cold])
					DrawVectorTextBlock(@*Item\Value, ValueX, Y - 2)
					
					Center = Y + *GadgetData\ItemHeight * 0.5
					MovePathCursor(ValueX + PropertyBox_ValueWidth(*GadgetData) - 8, Center - 2)
					AddPathLine(6, 0, #PB_Path_Relative)
					AddPathLine(-3, 4, #PB_Path_Relative)
					ClosePath()
					FillPath()
					;}
				Case #PropertyBox_Font ;{ "family, size" plus an ellipsis, the usual "this opens a dialog" hint
					VectorSourceColor(\ThemeData\TextColor[#Cold])
					DrawVectorTextBlock(@*Item\Value, ValueX, Y - 2)
					
					Center = Y + *GadgetData\ItemHeight * 0.5
					AddPathCircle(ValueX + PropertyBox_ValueWidth(*GadgetData) - 9, Center + 1, 1)
					AddPathCircle(ValueX + PropertyBox_ValueWidth(*GadgetData) - 5, Center + 1, 1)
					AddPathCircle(ValueX + PropertyBox_ValueWidth(*GadgetData) - 1, Center + 1, 1)
					FillPath()
					;}
				Default ;{ Text / TextNumerical
					VectorSourceColor(\ThemeData\TextColor[#Cold])
					DrawVectorTextBlock(@*Item\Value, ValueX, Y - 2)
					;}
			EndSelect
			
			VectorSourceColor(\ThemeData\TextColor[#Cold])
		EndWith
	EndProcedure
	
	Procedure PropertyBox_CountItem(*this.PB_Gadget)
		Protected *GadgetData.PropertyBoxData = *this\vt
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	; Column 0 is the label, column 1 the value. Combo's "value" text is its whole newline-delimited option list.
	Procedure.s PropertyBox_GetItemText(*this.PB_Gadget, Position, Column)
		Protected *GadgetData.PropertyBoxData = *this\vt, Result.s
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				If Column = 0
					Result = \Items()\Text\OriginalText
				ElseIf \Items()\Type = #PropertyBox_Combo
					Result = \Items()\Options
				ElseIf \Items()\Type = #PropertyBox_Font
					Result = \Items()\FontName
				Else
					Result = \Items()\Value\OriginalText
				EndIf
			EndIf
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure PropertyBox_SetItemText(*this.PB_Gadget, Position, *Text, Column)
		Protected *GadgetData.PropertyBoxData = *this\vt, *Item.PropertyBox_Item
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*Item = @\Items()
				
				If Column = 0
					*Item\Text\OriginalText = PeekS(*Text)
					PrepareVectorTextBlock(@*Item\Text)
				ElseIf *Item\Type = #PropertyBox_Combo
					*Item\Options = PeekS(*Text)
					If *Item\State > CountString(*Item\Options, #LF$)
						*Item\State = 0
					EndIf
					PropertyBox_PrepareValue(*GadgetData, *Item)
				ElseIf *Item\Type = #PropertyBox_Font
					*Item\FontName = PeekS(*Text)
					PropertyBox_PrepareValue(*GadgetData, *Item)
				Else
					*Item\Value\OriginalText = PeekS(*Text)
					PropertyBox_PrepareValue(*GadgetData, *Item)
				EndIf
				
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	; Font rows keep their size and style here; every other row type ignores these.
	Procedure PropertyBox_GetItemAttribute(*this.PB_Gadget, Position, Attribute)
		Protected *GadgetData.PropertyBoxData = *this\vt
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				
				Select Attribute
					Case #Attribute_PropertyBox_FontSize
						ProcedureReturn \Items()\FontSize
					Case #Attribute_PropertyBox_FontStyle
						ProcedureReturn \Items()\FontStyle
				EndSelect
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_SetItemAttribute(*this.PB_Gadget, Position, Attribute, Value)
		Protected *GadgetData.PropertyBoxData = *this\vt, *Item.PropertyBox_Item
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*Item = @\Items()
				
				Select Attribute
					Case #Attribute_PropertyBox_FontSize
						*Item\FontSize = Value
					Case #Attribute_PropertyBox_FontStyle
						*Item\FontStyle = Value
					Default
						ProcedureReturn
				EndSelect
				
				PropertyBox_PrepareValue(*GadgetData, *Item)
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_GetItemState(*this.PB_Gadget, Position)
		Protected *GadgetData.PropertyBoxData = *this\vt, Result
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				Result = \Items()\State
			EndIf
		EndWith
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure PropertyBox_SetItemState(*this.PB_Gadget, Position, State)
		Protected *GadgetData.PropertyBoxData = *this\vt, *Item.PropertyBox_Item
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*Item = @\Items()
				*Item\State = State
				If *Item\Type = #PropertyBox_Combo
					PropertyBox_PrepareValue(*GadgetData, *Item)
				EndIf
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.PropertyBoxData = *this\vt
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			
			\TextBlock\Width = \Width 
			\TextBlock\Height = \Height 
			
			ScrollBar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			If \InternalHeight > \Height
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollBar = #False
			EndIf
			
			ForEach \Items()
				PropertyBox_PrepareValue(*GadgetData, @\Items())
			Next
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure PropertyBox_Redraw(*GadgetData.PropertyBoxData)
		Protected Y, X, FirstElement, ValueX
		
		With *GadgetData
			If Not \Freeze
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
					ValueX = \OriginX + \MarginWidth + \ColumnWidth + #PropertyBox_ValueMargin
					
					If \VisibleScrollBar
						SelectElement(\Items(), Floor(\ScrollBar\State / \ItemHeight))
						Y - (\ScrollBar\State % \ItemHeight)
					Else
						FirstElement(\Items())
					EndIf
					
					VectorSourceColor(\ThemeData\TextColor[#Cold])
					
					Repeat
						If \Items()\Type = #PropertyBox_Title
							DrawVectorTextBlock(@\Items()\Text, X + 3, Y - 1)
						Else
							VectorSourceColor(\ThemeData\ShadeColor[#Cold])
							AddPathBox(X, Y, \Width, \ItemHeight - 1)
							FillPath()
							
							VectorSourceColor(\ThemeData\TextColor[#Cold])
							DrawVectorTextBlock(@\Items()\Text, X + 3, Y - 2)
							
							PropertyBox_DrawValue(*GadgetData, @\Items(), ValueX, Y)
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
					
					If \Editing
						SaveVectorState()
						\String\Redraw(\String)
						RestoreVectorState()
					EndIf
					
					If \VisibleScrollBar
						\ScrollBar\Redraw(\ScrollBar)
					EndIf
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_StartEdit(*GadgetData.PropertyBoxData, ItemRow)
		Protected Event.Event, ScrollOffset
		
		With *GadgetData
			If ItemRow < 0 Or ItemRow >= ListSize(\Items()) : ProcedureReturn : EndIf
			SelectElement(\Items(), ItemRow)
			
			\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
			\EditItem = ItemRow
			\EditNumeric = Bool(\Items()\Type = #PropertyBox_TextNumerical)
			\State = ItemRow
			
			; Prime the shared editor with the current value and drop it onto the row.
			\String\String = \Items()\Value\OriginalText
			\String\TextBlock\FontID = \TextBlock\FontID
			String_ProcessString(\String)
			
			ScrollOffset = Bool(\VisibleScrollBar) * \ScrollBar\State
			\String\OriginX = \OriginX + \MarginWidth + \ColumnWidth + #PropertyBox_ValueMargin
			\String\OriginY = \OriginY + \Border + ItemRow * \ItemHeight - ScrollOffset
			\String\Width = PropertyBox_ValueWidth(*GadgetData)
			
			Event\EventType = #Focus
			\String\EventHandler(\String, Event)
			StringSetSelection_Meta(\String, 0, Len(\String\String))
		EndWith
	EndProcedure
	
	Procedure PropertyBox_CommitEdit(*GadgetData.PropertyBoxData)
		Protected Event.Event
		
		With *GadgetData
			If \Editing
				\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
				
				SelectElement(\Items(), \EditItem)
				\Items()\Value\OriginalText = \String\String
				PropertyBox_PrepareValue(*GadgetData, @\Items())
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
				
				Event\EventType = #LostFocus
				\String\EventHandler(\String, Event)
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_CancelEdit(*GadgetData.PropertyBoxData)
		Protected Event.Event
		
		With *GadgetData
			If \Editing
				\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
				Event\EventType = #LostFocus
				\String\EventHandler(\String, Event)
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_ComboPopup_Select()
		Protected Gadget = EventGadget(), *GadgetData.PropertyBoxData = GetProp_(GadgetID(Gadget), "UITK_PropertyData")
		
		With *GadgetData
			If \PopupItem >= 0 And \PopupItem < ListSize(\Items())
				SelectElement(\Items(), \PopupItem)
				\Items()\State = GetGadgetState(\ComboPopupList)
				PropertyBox_PrepareValue(*GadgetData, @\Items())
				\State = \PopupItem
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
			EndIf
			HideWindow(\ComboPopupWindow, #True)
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure PropertyBox_ComboPopup_Deactivate()
		Protected *GadgetData.PropertyBoxData = GetProp_(WindowID(EventWindow()), "UITK_PropertyData")
		If *GadgetData : HideWindow(*GadgetData\ComboPopupWindow, #True) : EndIf
	EndProcedure
	
	Procedure PropertyBox_ColorPopup_Change()
		Protected Gadget = EventGadget(), *GadgetData.PropertyBoxData = GetProp_(GadgetID(Gadget), "UITK_PropertyData")
		
		With *GadgetData
			If \PopupItem >= 0 And \PopupItem < ListSize(\Items())
				SelectElement(\Items(), \PopupItem)
				\Items()\State = GetGadgetState(\ColorPopupPicker)
				\State = \PopupItem
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_ColorPopup_Deactivate()
		Protected *GadgetData.PropertyBoxData = GetProp_(WindowID(EventWindow()), "UITK_PropertyData")
		If *GadgetData : HideWindow(*GadgetData\ColorPopupWindow, #True) : EndIf
	EndProcedure
	
	Procedure PropertyBox_OpenComboPopup(*GadgetData.PropertyBoxData, ItemRow)
		Protected Count, Loop, ScrollOffset, ScreenX, ScreenY, PopupWidth, PopupHeight
		Protected *SubGadget.PB_Gadget, *ListData.VerticalListData
		
		With *GadgetData
			SelectElement(\Items(), ItemRow)
			\PopupItem = ItemRow
			
			; Clear the selection before emptying the list: VerticalList_RemoveItem posts a
			; spurious #PB_EventType_Change when it deletes the *selected* item, which would
			; be queued and then immediately close the popup we are about to open.
			*SubGadget = IsGadget(\ComboPopupList)
			*ListData = *SubGadget\vt
			*ListData\State = -1
			
			; Rebuild the list from this row's options.
			While CountGadgetItems(\ComboPopupList) > 0
				RemoveGadgetItem(\ComboPopupList, 0)
			Wend
			
			If \Items()\Options = ""
				ProcedureReturn
			EndIf
			
			Count = CountString(\Items()\Options, #LF$) + 1
			For Loop = 1 To Count
				AddGadgetItem(\ComboPopupList, -1, StringField(\Items()\Options, Loop, #LF$))
			Next
			
			If \Items()\State >= 0 And \Items()\State < Count
				SetGadgetState(\ComboPopupList, \Items()\State)
			EndIf
			
			PopupWidth = PropertyBox_ValueWidth(*GadgetData) + #PropertyBox_ValueMargin * 2
			PopupHeight = Count * 22
			If PopupHeight > 22 * 8 : PopupHeight = 22 * 8 : EndIf
			
			ResizeGadget(\ComboPopupList, 0, 0, PopupWidth - \Border * 2, PopupHeight)
			ResizeWindow(\ComboPopupWindow, #PB_Ignore, #PB_Ignore, PopupWidth, PopupHeight + \Border)
			
			ScrollOffset = Bool(\VisibleScrollBar) * \ScrollBar\State
			ScreenX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) + \MarginWidth + \ColumnWidth + #PropertyBox_ValueMargin
			ScreenY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) + \Border + ItemRow * \ItemHeight - ScrollOffset + \ItemHeight
			SetWindowPos_(WindowID(\ComboPopupWindow), 0, ScreenX, ScreenY, 0, 0, #SWP_NOZORDER | #SWP_NOREDRAW | #SWP_NOSIZE)
			HideWindow(\ComboPopupWindow, #False)
			SetActiveGadget(\ComboPopupList)
		EndWith
	EndProcedure
	
	; Font rows hand off to PB's own requester rather than a themed popup: it already covers
	; family, size, style and effects, and the alternative is enumerating fonts by hand. It is
	; modal and OS-drawn, so unlike the Combo and Colour popups there's nothing to position or
	; dismiss - it either returns a font or the user cancelled and nothing changes.
	Procedure PropertyBox_OpenFontRequester(*GadgetData.PropertyBoxData, ItemRow)
		With *GadgetData
			If Not SelectElement(\Items(), ItemRow)
				ProcedureReturn
			EndIf
			
			If FontRequester(\Items()\FontName, \Items()\FontSize, #PB_FontRequester_Effects, 0, \Items()\FontStyle, WindowID(\ParentWindow))
				\Items()\FontName = SelectedFontName()
				\Items()\FontSize = SelectedFontSize()
				\Items()\FontStyle = SelectedFontStyle()
				
				PropertyBox_PrepareValue(*GadgetData, @\Items())
				\State = ItemRow
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_OpenColorPopup(*GadgetData.PropertyBoxData, ItemRow)
		Protected ScrollOffset, ScreenX, ScreenY
		
		With *GadgetData
			SelectElement(\Items(), ItemRow)
			\PopupItem = ItemRow
			SetGadgetState(\ColorPopupPicker, \Items()\State)
			
			ScrollOffset = Bool(\VisibleScrollBar) * \ScrollBar\State
			ScreenX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) + \Width - WindowWidth(\ColorPopupWindow) - \Border
			ScreenY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) + \Border + ItemRow * \ItemHeight - ScrollOffset + \ItemHeight
			SetWindowPos_(WindowID(\ColorPopupWindow), 0, ScreenX, ScreenY, 0, 0, #SWP_NOZORDER | #SWP_NOREDRAW | #SWP_NOSIZE)
			HideWindow(\ColorPopupWindow, #False)
			SetActiveGadget(\ColorPopupPicker)
		EndWith
	EndProcedure
	
	Procedure PropertyBox_CreatePopups(*GadgetData.PropertyBoxData, Gadget, Flags)
		Protected SavedList = UseGadgetList(0), ParentWindow = WindowID(CurrentWindow())
		
		With *GadgetData
			; Combo dropdown: a borderless window hosting a compact VerticalList.
			\ComboPopupWindow = OpenWindow(#PB_Any, 0, 0, 100, 22, "", #PB_Window_BorderLess | #PB_Window_Invisible, ParentWindow)
			SetProp_(WindowID(\ComboPopupWindow), "UITK_PropertyData", *GadgetData)
			BindEvent(#PB_Event_DeactivateWindow, @PropertyBox_ComboPopup_Deactivate(), \ComboPopupWindow)
			SetWindowColor(\ComboPopupWindow, RGB(Red(\ThemeData\LineColor[#Warm]), Green(\ThemeData\LineColor[#Warm]), Blue(\ThemeData\LineColor[#Warm])))
			
			\ComboPopupList = VerticalList(#PB_Any, \Border, 0, 100 - \Border * 2, 22)
			SetGadgetAttribute(\ComboPopupList, #Attribute_CornerRadius, 0)
			SetGadgetAttribute(\ComboPopupList, #Attribute_ItemHeight, 22)
			SetProp_(GadgetID(\ComboPopupList), "UITK_PropertyData", *GadgetData)
			BindGadgetEvent(\ComboPopupList, @PropertyBox_ComboPopup_Select(), #PB_EventType_Change)
			SetGadgetColor(\ComboPopupList, #Color_Shade_Cold, \ThemeData\BackColor[#Warm])
			SetGadgetColor(\ComboPopupList, #Color_Shade_Warm, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\ComboPopupList, #Color_Shade_Hot, \ThemeData\BackColor[#Hot])
			SetGadgetColor(\ComboPopupList, #Color_Text_Cold, \ThemeData\TextColor[#Cold])
			SetGadgetColor(\ComboPopupList, #Color_Text_Warm, \ThemeData\TextColor[#Warm])
			SetGadgetColor(\ComboPopupList, #Color_Text_Hot, \ThemeData\TextColor[#Hot])
			
			; Colour picker popup.
			\ColorPopupWindow = OpenWindow(#PB_Any, 0, 0, 200, 250, "", #PB_Window_BorderLess | #PB_Window_Invisible, ParentWindow)
			SetProp_(WindowID(\ColorPopupWindow), "UITK_PropertyData", *GadgetData)
			BindEvent(#PB_Event_DeactivateWindow, @PropertyBox_ColorPopup_Deactivate(), \ColorPopupWindow)
			SetWindowColor(\ColorPopupWindow, RGB(Red(\ThemeData\WindowColor), Green(\ThemeData\WindowColor), Blue(\ThemeData\WindowColor)))
			
			\ColorPopupPicker = ColorPicker(#PB_Any, \Border, \Border, 200 - \Border * 2, 250 - \Border * 2, Flags & (#DarkMode | #LightMode))
			SetGadgetColor(\ColorPopupPicker, #Color_Parent, \ThemeData\WindowColor)
			SetProp_(GadgetID(\ColorPopupPicker), "UITK_PropertyData", *GadgetData)
			BindGadgetEvent(\ColorPopupPicker, @PropertyBox_ColorPopup_Change(), #PB_EventType_Change)
		EndWith
		
		UseGadgetList(SavedList)
	EndProcedure
	
	Procedure PropertyBox_Free(*this.PB_Gadget)
		Protected *GadgetData.PropertyBoxData = *this\vt
		
		With *GadgetData
			DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
			
			UnbindEvent(#PB_Event_DeactivateWindow, @PropertyBox_ComboPopup_Deactivate(), \ComboPopupWindow)
			UnbindEvent(#PB_Event_DeactivateWindow, @PropertyBox_ColorPopup_Deactivate(), \ColorPopupWindow)
			
			If IsWindow(\ComboPopupWindow)
				UnbindGadgetEvent(\ComboPopupList, @PropertyBox_ComboPopup_Select(), #PB_EventType_Change)
				FreeGadget(\ComboPopupList)
				CloseWindow(\ComboPopupWindow)
			EndIf
			
			If IsWindow(\ColorPopupWindow)
				UnbindGadgetEvent(\ColorPopupPicker, @PropertyBox_ColorPopup_Change(), #PB_EventType_Change)
				FreeGadget(\ColorPopupPicker)
				CloseWindow(\ColorPopupWindow)
			EndIf
			
			If \String
				RemoveGadgetTimers(\String)
				FreeMemory(\String\ThemeData)	; the inline editor's own copy of the theme
				FreeStructureX(\String)
			EndIf
			If \ScrollBar : FreeStructureX(\ScrollBar) : EndIf
			
			If \DefaultEventHandler
				UnbindGadgetEvent(\Gadget, \DefaultEventHandler)
			EndIf
			
			RemoveGadgetTimers(*GadgetData)
			*this\vt = \OriginalVT
			FreeStructureX(\ThemeData)
		EndWith
		
		FreeStructureX(*GadgetData)
		
		ProcedureReturn CallFunctionFast(*this\vt\FreeGadget, *this)
	EndProcedure
	
	Procedure PropertyBox_EventHandler(*GadgetData.PropertyBoxData, *Event.Event)
		Protected Redraw, ItemRow, ScrollOffset, Cursor = #PB_Cursor_Default, c
		
		With *GadgetData
			ScrollOffset = Bool(\VisibleScrollBar) * \ScrollBar\State
			
			Select *Event\EventType
				Case #MouseMove ;{
					If \VisibleScrollBar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ScrollBar\MouseState
						\ScrollBar\MouseState = #False
						Redraw = #True
					EndIf
					
					If \Editing
						If *Event\MouseX >= \String\OriginX And *Event\MouseX < \String\OriginX + \String\Width And *Event\MouseY >= \String\OriginY And *Event\MouseY < \String\OriginY + \ItemHeight
							Cursor = #PB_Cursor_IBeam
						EndIf
						If \String\Selecting
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							If \String\EventHandler(\String, *Event) : Redraw = #True : EndIf
						EndIf
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
					ElseIf \Editing And *Event\MouseX >= \String\OriginX And *Event\MouseX < \String\OriginX + \String\Width And *Event\MouseY >= \String\OriginY And *Event\MouseY < \String\OriginY + \ItemHeight
						; Click inside the active editor: place the caret / start a selection.
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					Else
						; Any other click commits an edit in progress first.
						If \Editing
							PropertyBox_CommitEdit(*GadgetData)
							Redraw = #True
						EndIf
						
						If *Event\MouseX >= \OriginX + \MarginWidth + \ColumnWidth
							ItemRow = Floor((*Event\MouseY - \OriginY - \Border + ScrollOffset) / \ItemHeight)
							
							If ItemRow >= 0 And ItemRow < ListSize(\Items())
								SelectElement(\Items(), ItemRow)
								\State = ItemRow
								
								Select \Items()\Type
									Case #PropertyBox_CheckBox
										If \Items()\State = #True
											\Items()\State = #False
										Else
											\Items()\State = #True
										EndIf
										PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
										Redraw = #True
									Case #PropertyBox_Text, #PropertyBox_TextNumerical
										PropertyBox_StartEdit(*GadgetData, ItemRow)
										Redraw = #True
									Case #PropertyBox_Combo
										PropertyBox_OpenComboPopup(*GadgetData, ItemRow)
									Case #PropertyBox_Color
										PropertyBox_OpenColorPopup(*GadgetData, ItemRow)
									Case #PropertyBox_Font
										PropertyBox_OpenFontRequester(*GadgetData, ItemRow)
								EndSelect
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \ScrollBar\Drag
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \Editing And \String\Selecting
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					EndIf
					;}
				Case #KeyDown ;{
					If \Editing
						Select *Event\Param
							Case #PB_Shortcut_Return
								PropertyBox_CommitEdit(*GadgetData)
								Redraw = #True
							Case #PB_Shortcut_Escape
								PropertyBox_CancelEdit(*GadgetData)
								Redraw = #True
							Default
								Redraw = \String\EventHandler(\String, *Event)
						EndSelect
					EndIf
					;}
				Case #KeyUp ;{
					If \Editing
						Redraw = \String\EventHandler(\String, *Event)
					EndIf
					;}
				Case #Input ;{
					If \Editing
						If \EditNumeric
							c = *Event\Param
							If (c >= '0' And c <= '9') Or c = '-' Or c = '.' Or c = ','
								Redraw = \String\EventHandler(\String, *Event)
							EndIf
						Else
							Redraw = \String\EventHandler(\String, *Event)
						EndIf
					EndIf
					;}
				Case #LostFocus ;{
					If \Editing
						PropertyBox_CommitEdit(*GadgetData)
						Redraw = #True
					EndIf
					;}
				Case #MouseWheel ;{
					If \Editing
						PropertyBox_CommitEdit(*GadgetData)
						Redraw = #True
					EndIf
					
					If \VisibleScrollBar
						Redraw = ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 1.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not PropertyBox_EventHandler(*GadgetData, *Event))
					EndIf
					;}
			EndSelect
			
			If Cursor <> \EditCursor
				\EditCursor = Cursor
				\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
			EndIf
			
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
			If *NewItem\Type = #PropertyBox_Font
				*NewItem\FontSize = 9			; so the requester opens somewhere sane before anything is picked
			EndIf
			If *NewItem\Type = #PropertyBox_Title
				*NewItem\Text\FontID = BoldFont
				*NewItem\Text\FontScale = 11
			Else
				*NewItem\Text\FontID = \TextBlock\FontID
			EndIf
			*NewItem\Text\Width = \ColumnWidth
			*NewItem\Text\Height = \ItemHeight
			*NewItem\Text\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			\InternalHeight + \ItemHeight
			
			Protected WasScrollBarVisible = \VisibleScrollBar
			If \InternalHeight > \Height
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollBar = #False
			EndIf
			
			If \VisibleScrollBar <> WasScrollBarVisible
				; The scrollbar appearing / disappearing changes every row's value-cell width.
				ForEach \Items()
					PropertyBox_PrepareValue(*GadgetData, @\Items())
				Next
			Else
				PropertyBox_PrepareValue(*GadgetData, *NewItem)
			EndIf
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure PropertyBox_RemoveItem(*This.PB_Gadget, Position)
		Protected *GadgetData.PropertyBoxData = *this\vt, WasScrollBarVisible
		
		With *GadgetData
			If Position > -1 And SelectElement(\Items(), Position)
				; Removing a row can pull the ground out from under an open editor / popup.
				PropertyBox_CancelEdit(*GadgetData)
				HideWindow(\ComboPopupWindow, #True)
				HideWindow(\ColorPopupWindow, #True)
				
				DeleteElement(\Items())
				
				If Position <= \State
					\State - 1
				EndIf
				
				\InternalHeight - \ItemHeight
				
				WasScrollBarVisible = \VisibleScrollBar
				If \InternalHeight > \Height
					\VisibleScrollBar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
				Else
					\VisibleScrollBar = #False
				EndIf
				
				; The scrollbar (dis)appearing changes every value cell's width.
				If \VisibleScrollBar <> WasScrollBarVisible
					ForEach \Items()
						PropertyBox_PrepareValue(*GadgetData, @\Items())
					Next
				EndIf
				
				RedrawObject()
				ProcedureReturn #True
			EndIf
		EndWith
	EndProcedure
	
	Procedure PropertyBox_ClearItems(*This.PB_Gadget)
		Protected *GadgetData.PropertyBoxData = *this\vt
		
		With *GadgetData
			PropertyBox_CancelEdit(*GadgetData)
			HideWindow(\ComboPopupWindow, #True)
			HideWindow(\ColorPopupWindow, #True)
			
			ClearList(\Items())
			\State = -1
			\InternalHeight = 0
			\ScrollBar\State = 0
			\VisibleScrollBar = #False
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure PropertyBox_Meta(*GadgetData.PropertyBoxData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(PropertyBox)
		
		With *GadgetData
			AllocateStructureX(\ScrollBar, ScrollBarData)
			\ItemHeight = #PropertyBox_ItemHeight
			\ColumnWidth = #PropertyBox_ColumnWidth
			\MarginWidth = #PropertyBox_MarginWidth
			
			ScrollBar_Meta(\ScrollBar, *ThemeData, - 1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \InternalHeight, Height , #Gadget_Vertical)
			
			\VT\AddGadgetItem3 = @PropertyBox_AddItem()
			\VT\RemoveGadgetItem = @PropertyBox_RemoveItem()
			\VT\ClearGadgetItemList = @PropertyBox_ClearItems()
			\VT\ResizeGadget = @PropertyBox_Resize()
			\VT\CountGadgetItems = @PropertyBox_CountItem()
			\VT\GetGadgetItemText = @PropertyBox_GetItemText()
			\VT\SetGadgetItemText = @PropertyBox_SetItemText()
			\VT\GetGadgetItemAttribute2 = @PropertyBox_GetItemAttribute()
			\VT\SetGadgetItemAttribute2 = @PropertyBox_SetItemAttribute()
			\VT\GetGadgetItemState = @PropertyBox_GetItemState()
			\VT\SetGadgetItemState = @PropertyBox_SetItemState()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			
			; Shared inline String editor for Text / TextNumerical value cells. Created as
			; a meta gadget (drawn and driven by us), repositioned onto whichever row is
			; being edited — same approach VerticalList uses for its editable items.
			; String_SupportedEvents() enables the keyboard / focus events on THIS gadget
			; so the parent canvas forwards them to the editor.
			\EditCursor = #PB_Cursor_Default
			Protected *SourceTheme.Theme = *ThemeData
			Protected *StringThemeData.Theme = AllocateMemory(SizeOf(Theme))
			CopyMemory(*ThemeData, *StringThemeData, SizeOf(Theme))
			*StringThemeData\CornerRadius = 0
			*StringThemeData\ShadeColor[#Cold] = *SourceTheme\ShadeColor[#Hot]
			AllocateStructureX(\String, StringData)
			String_Meta(\String, *StringThemeData, Gadget, 0, 0, \Width, \ItemHeight, "", #HAlignLeft | #Gadget_Meta)
			String_SupportedEvents()
			
			; Shared Combo dropdown / Colour picker popups, and cleanup for all of the above.
			\VT\FreeGadget = @PropertyBox_Free()
			PropertyBox_CreatePopups(*GadgetData, Gadget, Flags)
		EndWith
	EndProcedure
	
	Procedure PropertyBox(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.PropertyBoxData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Container | #PB_Canvas_Keyboard)
		
		If Result
			CreateGadgetObject(PropertyBoxData)
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
		*data
	EndStructure
	
	Structure TreeData Extends GadgetData
		InternalHeight.l
		ItemHeight.l
		BranchWidth.l
		VisibleScrollBar.b
		MaxLevel.b
		DrawLine.l
		
		Editable.l
		Editing.b
		EditCursor.b
		*String.StringData
		
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
				
				If \VisibleScrollBar And Floor(\ScrollBar\State / \ItemHeight)
					SelectElement(\Items(), Floor(\ScrollBar\State / \ItemHeight) - 1)
					PreviousLevel = \Items()\Level
					NextElement(\Items())
				Else
					PreviousLevel = 1
					LastLevel(0) = #Tree_BranchHeight + Y
					FirstElement(\Items())
				EndIf
				
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
						AddPathBox(X + \Items()\Level * \BranchWidth - 2, Y + 1, \Items()\Text\RequiredWidth + 2, \ItemHeight - 1)
						VectorSourceColor(\ThemeData\ShadeColor[#Hot])
						FillPath()
						VectorSourceColor(\ThemeData\TextColor[#Cold])
						
						DrawVectorTextBlock(@\Items()\Text, X + \Items()\Level * \BranchWidth, Y)
						
						SaveVectorState()
						If \Editing
							String_Redraw(\String)
						EndIf
						RestoreVectorState()
						
					Else
						DrawVectorTextBlock(@\Items()\Text, X + \Items()\Level * \BranchWidth, Y)
					EndIf
					
					If \DropHover = ListIndex(\Items())
						If \DrawLine = #Tree_Dot
							DotPath(1, 3)
						ElseIf \DrawLine = #Tree_Straight
							StrokePath(1)
						Else
							ResetPath()
						EndIf
						AddPathBox(X + \Items()\Level * \BranchWidth - 2, Y + 1, \Items()\Text\RequiredWidth + 2, \ItemHeight - 1)
						VectorSourceColor(SetAlpha(\ThemeData\TextColor[#Cold],40))
						FillPath()
						VectorSourceColor(\ThemeData\TextColor[#Cold])
					EndIf
					
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
				
				If \VisibleScrollBar
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
			
			\TextBlock\Width = \Width 
			\TextBlock\Height = \Height 
			
			ScrollBar_ResizeMeta(\ScrollBar, \Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, \Height - \Border * 2 - 2)
			ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
			
			If \InternalHeight > \Height
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollBar = #False
			EndIf
			
			PrepareVectorTextBlock(@*GadgetData\TextBlock)
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure Tree_BeginEdit(*GadgetData.TreeData)
		Protected Event.Event
		
		With *GadgetData
			If Not \Editable Or \Editing Or \State < 0 Or Not SelectElement(\Items(), \State)
				ProcedureReturn #False
			EndIf
			
			\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
			\String\String = \Items()\Text\OriginalText
			String_ProcessString(\String)
			
			\String\OriginX = \OriginX + \Border + \BranchWidth + 1 + \Items()\Level * \BranchWidth + \Items()\Text\TextX
			\String\OriginY = \State * \ItemHeight - \ScrollBar\State + \Border + 1
			
			Event\EventType = #Focus
			\String\EventHandler(\String, Event)
			StringSetSelection_Meta(\String, 0, Len(\String\String))
		EndWith
		
		ProcedureReturn #True
	EndProcedure
	
	Procedure Tree_EndEdit(*GadgetData.TreeData, Keep)
		Protected Event.Event
		
		With *GadgetData
			If Not \Editing
				ProcedureReturn #False
			EndIf
			
			\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
			
			If Keep And SelectElement(\Items(), \State)
				\Items()\Text\OriginalText = \String\String
				PrepareVectorTextBlock(@\Items()\Text)
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
			EndIf
			
			Event\EventType = #LostFocus
			\String\EventHandler(\String, Event)
		EndWith
		
		ProcedureReturn #True
	EndProcedure
	
	Procedure Tree_EventHandler(*GadgetData.TreeData, *Event.Event)
		Protected Redraw, Y, NewItem = -1, ItemRow, Cursor = *GadgetData\EditCursor
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					Cursor = #PB_Cursor_Default
					
					If \VisibleScrollBar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf \ScrollBar\MouseState
						\ScrollBar\MouseState = #False
						Redraw = #True
					EndIf
					
					If \Editing
						If \String\Selecting = #True
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							Redraw = \String\EventHandler(\String, *Event)
							Cursor = #PB_Cursor_IBeam
						ElseIf *Event\MouseY > \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height
							Cursor = #PB_Cursor_IBeam
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \ScrollBar\MouseState
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #LeftButtonDown ;{
					If Cursor = #PB_Cursor_IBeam
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					ElseIf \Editing
						Redraw = Tree_EndEdit(*GadgetData, #True)
					EndIf
					
					If \ScrollBar\MouseState
						Redraw + ScrollBar_EventHandler(\ScrollBar, *Event)
					ElseIf SelectElement(\Items(), Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight))
						If (*Event\MouseX > \Border + \BranchWidth * (\Items()\Level + 1)) And (*Event\MouseX < \Border + \BranchWidth * (\Items()\Level + 1) + \Items()\Text\RequiredWidth)
							If \State <> ListIndex(\Items())
								\State = ListIndex(\Items())
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
							EndIf
						EndIf
					EndIf
					;}
				Case #RightButtonDown ;{
					If Cursor = #PB_Cursor_IBeam
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					ElseIf \Editing
						Redraw = Tree_EndEdit(*GadgetData, #True)
					EndIf
					
					If Not \ScrollBar\MouseState
						If SelectElement(\Items(), Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight))
							If (*Event\MouseX > \Border + \BranchWidth * (\Items()\Level + 1)) And (*Event\MouseX < \Border + \BranchWidth * (\Items()\Level + 1) + \Items()\Text\RequiredWidth)
								If \State <> ListIndex(\Items())
									\State = ListIndex(\Items())
									Redraw = #True
									PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
								EndIf
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #EventType_ItemRightClick)
							EndIf
						EndIf
					EndIf
					;}
				Case #LeftButtonUp ;{
					If \EditCursor = #PB_Cursor_IBeam And \String\Selecting = #True
						Redraw = \String\EventHandler(\String, *Event)
					ElseIf \ScrollBar\Drag 
						Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
					EndIf
					;}
				Case #MouseWheel ;{
					If \VisibleScrollBar
						Redraw = ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 1.5)
						*Event\EventType = #MouseMove
						Redraw = Bool(Not Tree_EventHandler(*GadgetData, *Event))
					EndIf
					;}	
				Case #LeftDoubleClick ;{
					If (Not \ScrollBar\MouseState) And SelectElement(\Items(), Floor((*Event\MouseY + \ScrollBar\State) / \ItemHeight))
						If (*Event\MouseX > \Border + \BranchWidth * (\Items()\Level + 1)) And (*Event\MouseX < \Border + \BranchWidth * (\Items()\Level + 1) + \Items()\Text\RequiredWidth)
							If \State <> ListIndex(\Items())
								\State = ListIndex(\Items())
								Redraw = #True
								PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #EventType_ForcefulChange)
							EndIf
						EndIf
					EndIf
					;}
				Case #KeyDown ;{
					Select *Event\Param 
						Case #PB_Shortcut_Up ;{
							If \State > 0
								Tree_EndEdit(*GadgetData, #True)
								
								\State - 1
								Redraw = #True
								
								If \ScrollBar\State > \State * \ItemHeight
									ScrollBar_SetState_Meta(\ScrollBar, \State * \ItemHeight)
								EndIf
								
							EndIf
							;}
						Case #PB_Shortcut_Down ;{
							If \State < ListSize(\Items()) - 1
								Tree_EndEdit(*GadgetData, #True)
								
								\State + 1
								
								If \ScrollBar\State + \Height < (\State + 1) * \ItemHeight
									ScrollBar_SetState_Meta(\ScrollBar, (\State + 1) * \ItemHeight - \Height)
								EndIf
								
								Redraw = #True
							EndIf
							;}
						Case #PB_Shortcut_F2 ;{
							Redraw = Tree_BeginEdit(*GadgetData)
							;}
						Case #PB_Shortcut_Return ;{
							Redraw = Tree_EndEdit(*GadgetData, #True)
							;}
						Case #PB_Shortcut_Escape ;{
							Redraw = Tree_EndEdit(*GadgetData, #False)	; keep the old name
																		;}
						Default											;{
							If \Editing
								Redraw = \String\EventHandler(\String, *Event)
							EndIf
							;}
					EndSelect
					;}
				Case #LostFocus ;{
					Redraw = Tree_EndEdit(*GadgetData, #True)
					;}
				Default ;{
					If \Editing
						*Event\MouseX - \String\OriginX
						*Event\MouseY - \String\OriginY
						Redraw = \String\EventHandler(\String, *Event)
					EndIf
					;}
			EndSelect
			
			If Cursor <> \EditCursor
				\EditCursor = Cursor
				\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
			EndIf
			
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
			
			*NewItem\Text\FontID = \TextBlock\FontID
			
			*NewItem\Text\Width = \Width - (*NewItem\Level + 1) * #Tree_BranchWidth
			*NewItem\Text\Height = \ItemHeight
			*NewItem\Text\VAlign = #VAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			\InternalHeight + \ItemHeight
			
			If \InternalHeight > \Height
				\VisibleScrollBar = #True
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
			Else
				\VisibleScrollBar = #False
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
			If Position > -1 And SelectElement(\Items(), Position)
				DeleteElement(\Items())
				
				If Position < \State
					\State - 1
				ElseIf Position = \State
					\State - 1
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
				EndIf
				
				\InternalHeight - \ItemHeight
				
				If \InternalHeight > \Height
					\VisibleScrollBar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, \InternalHeight)
				Else
					\VisibleScrollBar = #False
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
			\VisibleScrollBar = #False
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure Tree_DropHandler(*GadgetData.TreeData, State, Format, Action, x, y)
		Protected Hover = -1
		
		With *GadgetData
			Select State
				Case #PB_Drag_Enter, #PB_Drag_Update
					If SelectElement(\Items(), Floor((y + \ScrollBar\State) / \ItemHeight))
						If (x > \Border + \BranchWidth * (\Items()\Level + 1)) And (x < \Border + \BranchWidth * (\Items()\Level + 1) + \Items()\Text\RequiredWidth)
							Hover = ListIndex(\Items())
						EndIf
					EndIf
					
					If Hover <> \DropHover
						\DropHover = Hover
						RedrawObject()
					EndIf
					
					If \DropHover > -1
						ProcedureReturn #True
					EndIf
				Case #PB_Drag_Leave
					If \DropHover > -1
						\DropHover = -1
						RedrawObject()
					EndIf
				Case #PB_Drag_Finish
					If \DropHover > -1
						\DropHover = -1
						RedrawObject()
						ProcedureReturn #True
					EndIf
			EndSelect
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
	
	Procedure Tree_GetItemData(*this.PB_Gadget, Position)
		Protected *GadgetData.TreeData = *this\vt, *Result
		
		If Position > -1 And SelectElement(*GadgetData\Items(), Position)
			*Result = *GadgetData\Items()\Data
		EndIf
		
		ProcedureReturn *Result
	EndProcedure
	
	Procedure Tree_GetItemAttribute(*this.PB_Gadget, Position, Attribute)
		Protected *GadgetData.TreeData = *this\vt, *Result
		
		If Position > -1 And SelectElement(*GadgetData\Items(), Position)
			Select Attribute
				Case #Attribute_Tree_ItemDepth
					ProcedureReturn *GadgetData\Items()\Level
					
			EndSelect
		EndIf
	EndProcedure
	
	Procedure.s Tree_GetItemText(*this.PB_Gadget, Position)
		Protected *GadgetData.TreeData = *this\vt, *Result
		
		If Position > -1 And SelectElement(*GadgetData\Items(), Position)
			ProcedureReturn *GadgetData\Items()\Text\OriginalText
		EndIf
	EndProcedure
	
	; Setters
	Procedure Tree_SetItemData(*this.PB_Gadget, Position, *Data)
		Protected *GadgetData.TreeData = *this\vt
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			SelectElement(*GadgetData\Items(), Position)
			*GadgetData\Items()\Data = *Data
			
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure Tree_SetItemText(*this.PB_Gadget, Position, *Text)
		Protected *GadgetData.TreeData = *this\vt
		
		If Position > -1 And Position < ListSize(*GadgetData\Items())
			*GadgetData\Items()\Text\OriginalText = PeekS(*Text)
			PrepareVectorTextBlock(@*GadgetData\Items()\Text)
			
			RedrawObject()
		EndIf
	EndProcedure
	
	Procedure Tree_FreeGadget(*this.PB_Gadget)
		Protected *GadgetData.TreeData = *this\vt
		
		FreeStructureX(*GadgetData\ScrollBar)
		
		If *GadgetData\Editable
			RemoveGadgetTimers(*GadgetData\String)
			FreeMemory(*GadgetData\String\ThemeData)
			FreeStructureX(*GadgetData\String)
		EndIf
		
		Default_FreeGadget(*this)
	EndProcedure
	
	Procedure Tree_Meta(*GadgetData.TreeData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(Tree)
		
		With *GadgetData
			AllocateStructureX(\ScrollBar, ScrollBarData)
			\ItemHeight = #Tree_ItemHeight
			\BranchWidth= #Tree_BranchWidth
			\MaxLevel = 1
			\State = -1
			\InternalHeight = 5
			
			ScrollBar_Meta(\ScrollBar, *ThemeData, -1, Width - #VerticalList_ToolbarThickness - \Border - 1, \Border + 1, #VerticalList_ToolbarThickness, Height - \Border * 2 - 2, 0, \InternalHeight, Height , #Gadget_Vertical)
			
			If Flags & #Tree_NoLine
				\DrawLine = 0
			ElseIf Flags & #Tree_StraightLine
				\DrawLine = #Tree_Straight
			Else
				\DrawLine = #Tree_Dot
			EndIf
			
			\VT\AddGadgetItem3 = @Tree_AddItem()
			\VT\RemoveGadgetItem = @Tree_RemoveItem()
			\VT\ResizeGadget = @Tree_Resize()
			\VT\CountGadgetItems = @Tree_CountItem()
			\VT\ClearGadgetItemList = @Tree_ClearItems()
			
			\VT\SetGadgetItemData = @Tree_SetItemData()
			\VT\SetGadgetItemText = @Tree_SetItemText()
			
			\VT\GetGadgetItemData = @Tree_GetItemData()
			\VT\GetGadgetItemAttribute2 = @Tree_GetItemAttribute()
			\VT\GetGadgetItemText = @Tree_GetItemText()
			\VT\GetGadgetItemImage = @Tree_GetItemImage()
			
			\VT\DropHandler = @Tree_DropHandler()
			\VT\FreeGadget = @Tree_FreeGadget()
			
			; Enable only the needed events
			\SupportedEvent[#MouseWheel] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#RightButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftDoubleClick] = #True
			\SupportedEvent[#KeyDown] = #True
			
			Protected *StringThemeData.Theme
			\Editable = Bool(Flags & #Editable)
			\EditCursor = #PB_Cursor_Default
			If \Editable
				*StringThemeData = AllocateMemory(SizeOf(Theme))
				CopyMemory(*ThemeData, *StringThemeData, SizeOf(Theme))
				*StringThemeData\CornerRadius = 0
				*StringThemeData\ShadeColor[#Cold] = *ThemeData\ShadeColor[#Hot]
				AllocateStructureX(\String, StringData)
				String_Meta(\String, *StringThemeData, Gadget, 0, 0, \Width, 20, "", #HAlignLeft | #Gadget_Meta)
				String_SupportedEvents()
				CloseGadgetList()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tree(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.TreeData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Editable) * #PB_Canvas_Container))
		
		If Result
			CreateGadgetObject(TreeData)
			Tree_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Menu
	#MenuMinimumWidth = 140
	#MenuSeparatorHeight = 5
	#MenuMargin = 5
	#MenuItemLeftMargin = 20 + #menuMargin
	#MenuSubMenuArrowWidth = 12		; room kept clear at the right of an entry for its unfold triangle
	#MenuShortcutGap = 24			; smallest air between the longest label and the key column
	
	Declare FlatMenu_HideBranch(Menu)
	
	Procedure FlatMenu_SetItemText(*MenuData.FlatMenu, *Item.MenuItem, Text.s)
		Protected Separator = FindString(Text, #TAB$)
		
		If Separator
			*Item\Text\OriginalText = Left(Text, Separator - 1)
			*Item\Shortcut\OriginalText = Mid(Text, Separator + 1)
		Else
			*Item\Text\OriginalText = Text
			*Item\Shortcut\OriginalText = ""
		EndIf
		
		*Item\Text\VAlign = #VAlignCenter
		*Item\Text\Height = *MenuData\ItemHeight
		*Item\Text\Width = 500
		*Item\Text\FontID = *MenuData\FontID
		PrepareVectorTextBlock(@*Item\Text)
		
		; Measured against a generous box here, then re-measured to the real menu
		; width by the reflow — RequiredWidth is what the width formula needs, and
		; it must be known before the width it will be aligned in exists.
		*Item\Shortcut\VAlign = #VAlignCenter
		*Item\Shortcut\HAlign = #HAlignRight
		*Item\Shortcut\LineLimit = 1
		*Item\Shortcut\Height = *MenuData\ItemHeight
		*Item\Shortcut\Width = 500
		*Item\Shortcut\FontID = *MenuData\FontID
		PrepareVectorTextBlock(@*Item\Shortcut)
	EndProcedure
	
	Procedure.i FlatMenu_ItemWidth(*Item.MenuItem)
		Protected Result = *Item\Text\RequiredWidth + #MenuMargin + #MenuItemLeftMargin
		
		If *Item\Shortcut\OriginalText <> ""
			Result + #MenuShortcutGap + *Item\Shortcut\RequiredWidth
		EndIf
		If *Item\SubMenu
			Result + #MenuSubMenuArrowWidth
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	Procedure FlatMenu_ReflowShortcuts(*MenuData.FlatMenu)
		With *MenuData
			ForEach \Item()
				If \Item()\Type = #Item And \Item()\Shortcut\OriginalText <> ""
					\Item()\Shortcut\Width = \Width - #MenuMargin * 2 - Bool(\Item()\SubMenu <> 0) * #MenuSubMenuArrowWidth
					PrepareVectorTextBlock(@\Item()\Shortcut)
				EndIf
			Next
		EndWith
	EndProcedure
	
	Procedure FlatMenu_Redraw(*MenuData.FlatMenu)
		Protected Y = 0, VerticalOffset
		
		With *MenuData
			StartVectorDrawing(CanvasVectorOutput(\Canvas))
			AddPathBox(0, 0, \Width, \Height)
			VectorSourceColor(\Theme\ShadeColor[#Cold])
			FillPath()
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
					If Not \Item()\Disabled
						; The entry owning the currently unfolded child stays lit while the pointer roams it
						If ListIndex(\Item()) = \State Or (\Item()\SubMenu And \Item()\SubMenu = \OpenSubMenu)
							AddPathBox(0, Y, \Width, \ItemHeight)
							VectorSourceColor(\Theme\ShadeColor[#Warm])
							FillPath()
							VectorSourceColor(\Theme\TextColor[#Hot])
							DrawVectorTextBlock(@\Item()\Text, #MenuMargin, Y)
						Else
							DrawVectorTextBlock(@\Item()\Text, #MenuMargin, Y)
						EndIf
						
						If \Item()\Shortcut\OriginalText <> ""
							VectorSourceColor(\Theme\TextColor[#Cold])
							DrawVectorTextBlock(@\Item()\Shortcut, #MenuMargin, Y)
						EndIf
						VectorSourceColor(\Theme\TextColor[#Warm])
					Else
						VectorSourceColor(\Theme\TextColor[#Disabled])
						DrawVectorTextBlock(@\Item()\Text, #MenuMargin, Y)
						If \Item()\Shortcut\OriginalText <> ""	; greyed out with the label it belongs to
							DrawVectorTextBlock(@\Item()\Shortcut, #MenuMargin, Y)
						EndIf
						VectorSourceColor(\Theme\TextColor[#Warm])
					EndIf
					
					If \Item()\SubMenu	; a small right-pointing triangle marks the entries that unfold
						MovePathCursor(\Width - #MenuMargin - 6, Y + \ItemHeight * 0.5 - 4)
						AddPathLine(5, 4, #PB_Path_Relative)
						AddPathLine(-5, 4, #PB_Path_Relative)
						ClosePath()
						FillPath()
					EndIf
					
					Y + \ItemHeight
				EndIf
			Next
			
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure FlatMenu_HideBranch(Menu)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		
		If *MenuData
			With *MenuData
				If \OpenSubMenu
					FlatMenu_HideBranch(\OpenSubMenu)
					\OpenSubMenu = 0
				EndIf
				
				\ParentMenu = 0
				\State = -1
				If FlatMenuPressed = \Window	; nothing of this menu's gesture outlives it
					FlatMenuPressed = 0
				EndIf
				
				CompilerIf #PB_Compiler_OS = #PB_OS_Windows
					ShowWindow_(WindowID(\Window), #SW_HIDE)
				CompilerElse
					HideWindow(\Window, #True)
				CompilerEndIf
				PostEvent(#Event_CloseMenu, \Window, 0, 0, \Window)
			EndWith
		EndIf
	EndProcedure
	
	Procedure FlatMenu_CloseChain(*MenuData.FlatMenu)
		Protected Root = *MenuData\Window
		
		While *MenuData\ParentMenu
			Root = *MenuData\ParentMenu
			*MenuData = GetProp_(WindowID(Root), "UITK_MenuData")
		Wend
		
		FlatMenu_HideBranch(Root)
	EndProcedure
	
	Procedure FlatMenu_ChainContains(*MenuData.FlatMenu, Window)
		Protected Menu
		
		If Window = 0
			ProcedureReturn #False
		EndIf
		
		While *MenuData\ParentMenu
			*MenuData = GetProp_(WindowID(*MenuData\ParentMenu), "UITK_MenuData")
		Wend
		
		Menu = *MenuData\Window
		While Menu
			If Menu = Window
				ProcedureReturn #True
			EndIf
			*MenuData = GetProp_(WindowID(Menu), "UITK_MenuData")
			Menu = *MenuData\OpenSubMenu
		Wend
		
		ProcedureReturn #False
	EndProcedure
	
	Procedure FlatMenu_ChainContainsActive(*MenuData.FlatMenu)
		ProcedureReturn FlatMenu_ChainContains(*MenuData, GetActiveWindow())
	EndProcedure
	
	Procedure FlatMenu_OpenSub(*MenuData.FlatMenu, Item)
		Protected *SubData.FlatMenu, X, Y, Loop
		
		With *MenuData
			If \OpenSubMenu
				FlatMenu_HideBranch(\OpenSubMenu)
				\OpenSubMenu = 0
			EndIf
			
			If Not SelectElement(\Item(), Item) Or IsWindow(\Item()\SubMenu) = 0
				ProcedureReturn
			EndIf
			*SubData = GetProp_(WindowID(\Item()\SubMenu), "UITK_MenuData")
			If *SubData = 0
				ProcedureReturn
			EndIf
			
			For Loop = 0 To Item - 1	; the child sits level with its entry
				SelectElement(\Item(), Loop)
				If \Item()\Type = #Separator
					Y + #MenuSeparatorHeight
				Else
					Y + \ItemHeight
				EndIf
			Next
			
			X = WindowX(\Window) + WindowWidth(\Window) - 2
			ExamineDesktops()	; flip to the left side when the child would leave the screen
			If X + WindowWidth(*SubData\Window) > DesktopX(0) + DesktopWidth(0)
				X = WindowX(\Window) - WindowWidth(*SubData\Window) + 2
			EndIf
			
			*SubData\ParentMenu = \Window
			*SubData\State = -1
			ResizeWindow(*SubData\Window, X, WindowY(\Window) + Y, #PB_Ignore, #PB_Ignore)
			HideWindow(*SubData\Window, #False, #PB_Window_NoActivate)
			CompilerIf #PB_Compiler_OS = #PB_OS_Windows
				SetWindowPos_(WindowID(*SubData\Window), 0, 0, 0, 0, 0, #SWP_NOMOVE | #SWP_NOSIZE | #SWP_NOACTIVATE)
			CompilerEndIf
			FlatMenu_Redraw(*SubData)
			\OpenSubMenu = *SubData\Window
			
			SelectElement(\Item(), Item)
		EndWith
	EndProcedure
	
	Procedure FlatMenu_WindowEvent()
		PostEvent(#Event_MenuDeactivated, EventWindow(), 0, 0, EventWindow())
	EndProcedure
	
	Procedure FlatMenu_Deactivated()
		Protected *MenuData.FlatMenu = GetProp_(WindowID(EventWindow()), "UITK_MenuData")
		
		If *MenuData = 0
			ProcedureReturn
		EndIf
		
		If IsWindowVisible_(WindowID(*MenuData\Window)) = 0
			ProcedureReturn
		EndIf
		
		If FlatMenu_ChainContainsActive(*MenuData)
			ProcedureReturn
		EndIf
		
		If FlatMenuPressed And FlatMenu_ChainContains(*MenuData, FlatMenuPressed)
			ProcedureReturn
		EndIf
		
		FlatMenu_CloseChain(*MenuData)
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
								If Not \Item()\Disabled
									State = ListIndex(\Item())
								EndIf
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
						
						If State > -1
							SelectElement(\Item(), State)
							If \Item()\SubMenu
								If \Item()\SubMenu <> \OpenSubMenu
									FlatMenu_OpenSub(*MenuData, State)
								EndIf
							ElseIf \OpenSubMenu	; hovering a plain entry folds the open child away
								FlatMenu_HideBranch(\OpenSubMenu)
								\OpenSubMenu = 0
							EndIf
						EndIf
						
						FlatMenu_Redraw(*MenuData)
					EndIf
					;}
				Case #PB_EventType_MouseLeave ;{
											  ; Only the hover highlight resets - leaving towards an unfolded child
											  ; must not close it, so the chain is only ended by clicks.
					If \State <> -1
						\State = -1
						FlatMenu_Redraw(*MenuData)
					EndIf
					;}
				Case #PB_EventType_LeftButtonDown ;{
					FlatMenuPressed = \Window
					;}
				Case #PB_EventType_LeftClick ;{
					FlatMenuPressed = 0
					If \State > -1
						SelectElement(\Item(), \State)
						If \Item()\SubMenu
							If \Item()\SubMenu <> \OpenSubMenu	; the click unfolds rather than picks
								FlatMenu_OpenSub(*MenuData, \State)
								FlatMenu_Redraw(*MenuData)
							EndIf
						Else
							PostEvent(#PB_Event_Menu, EventWindow(), \Item()\ID)
							FlatMenu_CloseChain(*MenuData)
						EndIf
					EndIf
					;}
				Case #PB_EventType_LostFocus ;{
					If GetGadgetState(GetGadgetData(\Canvas))
						SetGadgetState(GetGadgetData(\Canvas), #False)
					EndIf
					;}
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
					
				Case #Color_Text_Cold
					\Theme\TextColor[#Warm] = Color
					
				Case #Color_Text_Warm
					\Theme\TextColor[#Hot] = Color
					
				Case #Color_Text_Disabled
					\Theme\TextColor[#Disabled] = Color
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
				CopyStructure(LightTheme, \Theme, Theme)
			EndIf
			
			SetWindowColor(\Window, \Theme\WindowTitle)
			
			SetProp_(WindowID(\Window), "UITK_MenuData", *MenuData)
			SetProp_(GadgetID(\Canvas), "UITK_MenuData", *MenuData)
			
			BindEvent(#PB_Event_DeactivateWindow, @FlatMenu_WindowEvent(), \Window)
			BindEvent(#Event_MenuDeactivated, @FlatMenu_Deactivated(), \Window)
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
		
		*MenuData\ParentMenu = 0
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
			\Item()\ID = MenuItem
			\Item()\SubMenu = SubMenu
			\Height + \ItemHeight
			FlatMenu_SetItemText(*MenuData, @\Item(), Text)
			\Item()\Text\Image = ImageID
			PrepareVectorTextBlock(@\Item()\Text)	; again, now that it carries an icon
			
			TextWidth = FlatMenu_ItemWidth(@\Item())
			If TextWidth > \Width
				\Width = TextWidth
			EndIf
			
			FlatMenu_ReflowShortcuts(*MenuData)
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
			
			\Height + #MenuSeparatorHeight
			
			ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width + 2, \Height + \Border)
			ResizeGadget(\Canvas, #PB_Ignore, #PB_Ignore, \Width, \Height)
			
			FlatMenu_Redraw(*MenuData)
			
		EndWith
	EndProcedure
	
	Procedure RemoveFlatMenuItem(Menu, Position)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		
		With *MenuData
			If Not SelectElement(\Item(), Position)
				ProcedureReturn
			EndIf
			
			If \Item()\Type = #Separator
				\Height - #MenuSeparatorHeight
			Else
				\Height - \ItemHeight
			EndIf
			DeleteElement(\Item())
			
			; The removed entry may have been the widest: recompute from what's left.
			\Width = #MenuMinimumWidth
			ForEach \Item()
				If \Item()\Type = #Item And FlatMenu_ItemWidth(@\Item()) > \Width
					\Width = FlatMenu_ItemWidth(@\Item())
				EndIf
			Next
			FlatMenu_ReflowShortcuts(*MenuData)
			
			\State = -1		; the hover index may point past the shortened list
			ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width + 2, \Height + \Border)
			ResizeGadget(\Canvas, #PB_Ignore, #PB_Ignore, \Width, \Height)
			
			FlatMenu_Redraw(*MenuData)
		EndWith
	EndProcedure
	
	Procedure SetFlatMenuItemText(Menu, Position, Text.s)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		
		With *MenuData
			If Not SelectElement(\Item(), Position) Or \Item()\Type <> #Item
				ProcedureReturn
			EndIf
			
			Protected Icon = \Item()\Text\Image	; SetItemText rebuilds the block from scratch
			FlatMenu_SetItemText(*MenuData, @\Item(), Text)
			\Item()\Text\Image = Icon
			PrepareVectorTextBlock(@\Item()\Text)
			
			If FlatMenu_ItemWidth(@\Item()) > \Width
				\Width = FlatMenu_ItemWidth(@\Item())
				ResizeWindow(\Window, #PB_Ignore, #PB_Ignore, \Width + 2, \Height + \Border)
				ResizeGadget(\Canvas, #PB_Ignore, #PB_Ignore, \Width, \Height)
			EndIf
			FlatMenu_ReflowShortcuts(*MenuData)	; the new keys need aiming even when nothing moved
			
			FlatMenu_Redraw(*MenuData)
		EndWith
	EndProcedure
	
	Procedure DisableFlatMenuItem(Menu, Position, State)
		Protected *MenuData.FlatMenu = GetProp_(WindowID(Menu), "UITK_MenuData")
		
		If Position > -1 And SelectElement(*MenuData\Item(), Position)
			*MenuData\Item()\Disabled = State
			FlatMenu_Redraw(*MenuData)
		EndIf
	EndProcedure
	
	Procedure.s FlatMenu_NativeLabel(*Item.MenuItem)
		If *Item\Shortcut\OriginalText <> ""
			ProcedureReturn *Item\Text\OriginalText + #TAB$ + *Item\Shortcut\OriginalText
		EndIf
		ProcedureReturn *Item\Text\OriginalText
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
		HoverItem.l			; hovered item index, -1 when none (the base \MouseState stays a #Cold/#Warm/#Hot state)
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
				VectorSourceColor(\ThemeData\TextColor[#Cold])
				
				FirstElement(\Items())
				
				Repeat
					If ListIndex(\Items()) = \State
						Tab_ItemRedraw(@\Items(), X, \OriginY, \ItemWidth, \Height, #Hot, \ThemeData)
					ElseIf ListIndex(\Items()) = \HoverItem
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
			
			If PreviousHeight <> \Height
				ForEach \Items()
					\Items()\Text\Height = \Height
					PrepareVectorTextBlock(@\Items()\Text)
				Next
			EndIf
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure Tab_EventHandler(*GadgetData.TabData, *Event.Event)
		Protected Redraw, HoverItem
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove ;{
					HoverItem = Floor(*Event\MouseX / \ItemWidth)
					If HoverItem <> \HoverItem
						If HoverItem < ListSize(\Items())
							\HoverItem = HoverItem
							Redraw = #True
						Else
							\HoverItem = -1
							Redraw = #True
						EndIf
					EndIf
					;}
				Case #MouseLeave ;{
					If \HoverItem <> -1
						\HoverItem = -1
						Redraw = #True
					EndIf
					;}
				Case #LeftButtonDown ;{
					If \HoverItem > -1 And \HoverItem <> \State
						\State = \HoverItem
						Redraw = #True
						PostEvent(#PB_Event_Gadget, EventWindow(), \Gadget, #PB_EventType_Change)
					EndIf
					;}
			EndSelect
			If Redraw
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure Tab_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.TabData = *this\vt, *NewItem.Tab_Item, HBitmap.UITK_BitmapInfo
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
			*NewItem\Text\FontID = \TextBlock\FontID
			*NewItem\Text\Width = \ItemWidth
			*NewItem\Text\Height = Floor(\Height * 0.95)
			*NewItem\Text\VAlign = #VAlignBottom
			*NewItem\Text\HAlign = #HAlignCenter
			
			PrepareVectorTextBlock(@*NewItem\Text)
			
			*NewItem\imageID = ImageID
			*NewItem\Color = \ThemeData\Special3[#Warm]
			
			If *NewItem\imageID
				UITK_GetImageSize(*NewItem\imageID, @HBitmap)
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
					ProcedureReturn	; already redraws
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
			\HoverItem = -1
			
			\VT\AddGadgetItem2 = @Tab_AddItem()
			\VT\RemoveGadgetItem = @Tab_RemoveItem()
			\VT\ResizeGadget = @Tab_Resize()
			\VT\SetGadgetAttribute = @Tab_SetAttribute()
			\VT\CountGadgetItems = @Tab_CountItem()
			\VT\GetGadgetItemImage = @Tab_GetItemImage()
			\VT\GetGadgetItemText = @Tab_GetItemText()
			\VT\SetGadgetItemAttribute2 = @Tab_SetItemAttribute()
			
			; Enable only the needed events
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
		EndWith
	EndProcedure
	
	Procedure Tab(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.TabData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				CreateGadgetObject(TabData)
				Tab_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	;{ Color picker
	Enumeration
		#ColorPicker_Drag_None
		#ColorPicker_Drag_Hue
		#ColorPicker_Drag_Brightness
		#ColorPicker_Drag_Alpha
	EndEnumeration
	
	Structure ColorPickerData Extends GadgetData
		WheelImg.i
		WheelRadius.l
		WheelX.l
		WheelY.l
		WheelSize.l
		BarWidth.l
		BarX.l
		BrightnessBarY.l
		AlphaBarY.l
		Color.l
		Hue.f
		HueX.l
		HueY.l
		Saturation.f
		Brightness.f
		BrightnessX.i
		Alpha.b
		Drag.i
		AlphaSelection.b
	EndStructure
	
	#ColorPickerBarHeight = 15
	#ColorPickerVerticalMargin = 20	
	
	Procedure HSBToRGB(Hue.f, Saturation.f, Brightness.f) ; Seems a bit janky. It works for my purpose but I wouldn't trust it beyond that
		Protected Red, Green, Blue
		Protected Max = Round(Brightness * 2.55, #PB_Round_Nearest)
		Protected Min = Round((1 - Saturation * 0.01) * Max, #PB_Round_Nearest)
		
		If Saturation = 0
			ProcedureReturn RGB(Max, Max, Max)
		EndIf
		
		If Hue >= 60 And Hue < 180
			Green = Max
			Hue = (Hue - 120) * (Max - Min) * 0.0166666666
			
			If Hue > 0
				Red = Min
				Blue = hue + Red
			Else
				Blue = Min
				Red = Blue - hue
			EndIf
		ElseIf Hue >= 180 And Hue < 300
			Blue = Max
			Hue = (Hue - 240) * (Max - Min) * 0.0166666666
			
			If Hue > 0
				Green = Min
				Red = hue + Green
			Else
				Red = Min
				Green = Red - hue
			EndIf
		Else
			Red = Max
			If Hue >= 300
				Hue - 360
			EndIf
			
			Hue = Hue * (Max - Min) * 0.0166666666
			If hue > 0
				Blue = Min
				Green = hue + Blue
			Else
				Green = Min
				Blue = Green - hue
			EndIf
		EndIf
		
		ProcedureReturn RGB(Red, Green, Blue)
	EndProcedure
	
	Procedure ColorPicker_DrawWheel(*GadgetData.ColorPickerData)
		Protected LoopX, LoopY, TotalDistance.f, PointDistance.f, Hue.f
		With *GadgetData
			If \WheelImg 
				FreeImage(\WheelImg)
			EndIf
			
			\WheelImg = CreateImage(#PB_Any, \WheelSize, \WheelSize, 24)
			StartDrawing(ImageOutput(\WheelImg))
			TotalDistance = (\WheelRadius + 1) / 100
			For LoopX = - \WheelRadius To \WheelRadius
				For LoopY = - \WheelRadius To \WheelRadius
					PointDistance = Sqr(LoopX * LoopX + LoopY * LoopY)
					If PointDistance <= \WheelRadius + 1
						Hue = Degree(ATan2(LoopX / PointDistance, LoopY / PointDistance))
						If Hue < 0 : Hue + 360 : EndIf
						Plot((LoopX + \WheelRadius), (LoopY + \WheelRadius), HSBToRGB(Hue, PointDistance / TotalDistance, 100))
					EndIf
				Next LoopY	
			Next LoopX
			StopDrawing()
			
			StartVectorDrawing(ImageVectorOutput(\WheelImg))
			AddPathBox(0, 0, \WheelRadius * 2 + 1, \WheelRadius * 2 + 1)
			AddPathCircle(\WheelRadius + 0.5, \WheelRadius + 0.5, \WheelRadius + 0.5)
			
			VectorSourceColor(\ThemeData\WindowColor)
			FillPath()
			StopVectorDrawing()
		EndWith
	EndProcedure
	
	Procedure ColorPicker_Redraw(*GadgetData.ColorPickerData)
		With *GadgetData
			MovePathCursor(\WheelX + \OriginX, \WheelY + \OriginY)
			DrawVectorImage(ImageID(\WheelImg))
			
			AddPathBox(\BarX + \OriginX, \BrightnessBarY + \OriginY, \BarWidth, #ColorPickerBarHeight)
			VectorSourceColor(\ThemeData\Highlight)
			StrokePath(2, #PB_Path_Preserve)
			VectorSourceLinearGradient(\BarX + \OriginX, 0, \BarWidth + \BarX + \OriginX, 0)
			VectorSourceGradientColor(SetAlpha($000000, 255), 0)
			VectorSourceGradientColor(SetAlpha(\Color, 255), 1)
			FillPath()
			
			AddPathCircle(\OriginX + \HueX, \OriginY + \HueY, 5)
			AddPathBox(\OriginX + \BrightnessX, \BrightnessBarY - 5, 10, 10 + #ColorPickerBarHeight)
			VectorSourceColor(SetAlpha($000000, 255))
			StrokePath(2)
			
			AddPathCircle(\OriginX + \HueX, \OriginY + \HueY, 4)
			VectorSourceColor(SetAlpha($FFFFFF, 255))
			StrokePath(2, #PB_Path_Preserve)
			VectorSourceColor(SetAlpha(\Color, 255))
			FillPath()
			
			AddPathBox(\OriginX + \BrightnessX + 1, \BrightnessBarY - 4, 8, 8 + #ColorPickerBarHeight)
			VectorSourceColor(SetAlpha($FFFFFF, 255))
			StrokePath(2, #PB_Path_Preserve)
			VectorSourceColor(SetAlpha(\State, 255))
			FillPath()
		EndWith
	EndProcedure
	
	Procedure ColorPicker_EventHandler(*GadgetData.ColorPickerData, *Event.Event)
		Protected Redraw, Hue.f, Saturation.f, PointDistance.f, Angle.f
		
		With *GadgetData
			Select *Event\EventType
				Case #MouseMove
					Select \Drag
						Case #ColorPicker_Drag_Hue
							PointDistance = MinF(Sqr(Pow(*Event\MouseX - (\WheelX + \WheelRadius), 2) + Pow(*Event\MouseY - (\WheelY + \WheelRadius), 2)), \WheelRadius + 1)
							Angle = ATan2((*Event\MouseX - (\WheelX + \WheelRadius)) / PointDistance, (*Event\MouseY - (\WheelY + \WheelRadius)) / PointDistance)
							Hue = Degree(Angle)
							If Hue < 0 : Hue + 360 : EndIf
							Saturation = PointDistance / (\WheelRadius + 1) * 100
							
							If Hue <> \Hue Or Saturation <> \Saturation
								\Hue = Hue
								\Saturation = Saturation
								\Color = HSBToRGB(\Hue, \Saturation, 100)
								\HueX = \WheelX	+ \WheelRadius + PointDistance * Cos(Angle)
								\HueY = \WheelY	+ \WheelRadius + PointDistance * Sin(Angle)
								\State = HSBToRGB(\Hue, \Saturation, \Brightness)
								Redraw = #True
							EndIf
						Case #ColorPicker_Drag_Brightness
							*Event\MouseX = Clamp(*Event\MouseX, \BarX, \BarX + \BarWidth)
							PointDistance = (*Event\MouseX - \BarX) / \BarWidth * 100
							
							If \Brightness <> PointDistance
								\Brightness = PointDistance
								\BrightnessX = *Event\MouseX - 5
								\State = HSBToRGB(\Hue, \Saturation, \Brightness)
								Redraw = #True
							EndIf
						Case #ColorPicker_Drag_Alpha
							
					EndSelect
				Case #LeftButtonDown ;{
					If *Event\MouseY >= \WheelY
						If *Event\MouseY <= \WheelY + \WheelSize
							If Sqr(Pow(*Event\MouseX - (\WheelX + \WheelRadius), 2) + Pow(*Event\MouseY - (\WheelY + \WheelRadius), 2)) <= \WheelRadius
								\Drag = #ColorPicker_Drag_Hue
							EndIf
						ElseIf *Event\MouseY >= \BrightnessBarY
							If *Event\MouseY <=  \BrightnessBarY + #ColorPickerBarHeight
								\Drag = #ColorPicker_Drag_Brightness
							ElseIf \AlphaSelection And *Event\MouseY >= \AlphaBarY And *Event\MouseY <= \AlphaBarY + #ColorPickerBarHeight
								\Drag = #ColorPicker_Drag_Alpha
							EndIf
						EndIf
					EndIf
					
					If \Drag
						*Event\EventType = #MouseMove
						ColorPicker_EventHandler(*GadgetData, *Event)
					EndIf
					;}
				Case #LeftButtonUp ;{
					\Drag = #ColorPicker_Drag_None
					
					;}
			EndSelect
			If Redraw
				RedrawObject()
				PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
			EndIf
		EndWith
	EndProcedure
	
	Procedure ColorPicker_SetState(*This.PB_Gadget, State)
		Protected *GadgetData.ColorPickerData = *this\vt
		Protected.f Red, Green, Blue, Max, Min, Delta
		
		With *GadgetData
			\State = State
			Red = Red(State) / 255
			Green = Green(State) / 255
			Blue = Blue(State) / 255
			
			Max = MaxF(MaxF(Red, Green),Blue)
			Min = MinF(MinF(Red, Green),Blue)
			
			\Brightness = Max * 100
			Delta = Max - Min
			
			If Delta < 0.00001 Or Max = 0
				\Saturation = 0
				\Hue = 0
			Else
				\Saturation = Delta / Max * 100
				
				If Red = max
					\Hue = (Green - Blue) / Delta * 60
				ElseIf Green = max
					\Hue = (((Blue - Red) * 60) / Delta) + 120
				Else
					\Hue = (((Red - Green) * 60) / Delta) + 240
				EndIf
				
				If \Hue < 0
					\Hue + 360
				ElseIf \Hue > 360
					\Hue - 360
				EndIf
			EndIf
			
			\Color = HSBToRGB(\Hue, \Saturation, 100)
			\HueX = \WheelX	+ \WheelRadius + Round((\Saturation * \WheelRadius) * 0.01 * Cos(Radian(\Hue)), #PB_Round_Nearest)
			\HueY = \WheelY	+ \WheelRadius + Round((\Saturation * \WheelRadius) * 0.01 * Sin(Radian(\Hue)), #PB_Round_Nearest)
			\BrightnessX = \BarX + Round(\Brightness * 0.01 * \BarWidth, #PB_Round_Nearest)
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure ColorPicker_SetColor(*This.PB_Gadget, ColorType, Color)
		Protected *GadgetData.ColorPickerData = *this\vt
		
		If ColorType = #Color_Parent
			*GadgetData\ThemeData\WindowColor = Color
			ColorPicker_DrawWheel(*GadgetData)
		EndIf
		
		Default_SetColor(*This, ColorType, Color)
	EndProcedure
	
	Procedure ColorPicker_Free(*this.PB_Gadget)
		Protected *GadgetData.ColorPickerData = *this\vt
		
		If IsImage(*GadgetData\WheelImg)
			FreeImage(*GadgetData\WheelImg)
		EndIf
		
		Default_FreeGadget(*this)
	EndProcedure
	
	Procedure ColorPicker_Meta(*GadgetData.ColorPickerData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(ColorPicker)
		
		With *GadgetData
			If Width > Height
				
			Else
				\WheelSize = Width - 12
			EndIf
			
			If Not \WheelSize % 2
				\WheelSize - 1
			EndIf
			
			\WheelX = (Width - \WheelSize) * 0.5
			\WheelY = 7
			\BarX = \WheelSize * 0.05
			\BarWidth = \WheelSize - \BarX * 2
			\BarX + \WheelX
			\BrightnessBarY = \WheelSize + \WheelY + #ColorPickerVerticalMargin
			\AlphaBarY = \BrightnessBarY + #ColorPickerVerticalMargin + #ColorPickerBarHeight
			\WheelRadius = Round(\WheelSize * 0.5, #PB_Round_Down)
			\Color = $FFFFFF
			\State = $FFFFFF
			\Hue = 0
			\Saturation = 0
			\HueX = \WheelX	+ \WheelRadius + Round((\Saturation * \WheelRadius) * 0.01 * Cos(0), #PB_Round_Nearest)
			\HueY = \WheelY	+ \WheelRadius + Round((\Saturation * \WheelRadius) * 0.01 * Sin(0), #PB_Round_Nearest)
			\BrightnessX = \BarX + \BarWidth - 5
			\Brightness = 100
			\Alpha = 255	
			ColorPicker_DrawWheel(*GadgetData)
			
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			
			\VT\SetGadgetState = @ColorPicker_SetState()
			\VT\SetGadgetColor = @ColorPicker_SetColor()
			\VT\FreeGadget = @ColorPicker_Free()
			
		EndWith
	EndProcedure
	
	Procedure ColorPicker(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ColorPickerData, *ThemeData
		
		If AccessibilityMode
			
		Else
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard)
			
			If Result
				CreateGadgetObject(ColorPickerData)
				ColorPicker_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				RedrawObject()
			EndIf
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	
	;}
	
	;{ ToolBar
	#ToolBar_SeparatorSize = 9			; span, along the bar's axis, taken by a separator
	#ToolBar_Margin = 3					; inset of a button's box within its square cell
	#ToolBar_TipDelay = 600				; ms of steady hover before an item's tooltip shows
	#ToolBar_ModeChevron_Size = 8		; extra span, along the bar's axis, taken by a mode button's chevron
	#ToolBar_ModeMenuWidth = 140		; minimum width of a mode button's dropdown menu
	#ToolBar_ModeMenuMaxItem = 7		; the dropdown stops growing past this many modes and scrolls instead
	
	Structure ToolBar_Item
		Type.l							; #Toolbar_DefaultButton, #ToolBar_Separator or #ToolBar_ModeButton
		Text.s							; hover-tip text
		*Button.ButtonData				; the button, embedded as a Button_Meta (0 for separators; the icon side of a mode button)
										; Mode button only
		*ModeButton.ButtonData			; the chevron side, opens the mode menu
		ModeChevronIMG.i				; the little triangle drawn on the chevron side
		Mode.l							; active mode index (-1 until a mode is added)
		ModeCount.l
		ModeWindow.i					; borderless popup window hosting the mode menu
		ModeList.i						; VerticalList inside ModeWindow listing the modes
	EndStructure
	
	Structure ToolBarData Extends GadgetData
		Vertical.b
		ButtonSize.l					; square cell size = the bar's cross-axis thickness
		MouseItem.l						; hovered item, or -1
		MouseChevron.b					; the hover is on the chevron side of a mode button
		PressedItem.l					; item with the mouse held on it, or -1
		TipTimer.i						; pending hover-delay timer; 0 = none
		TipItem.l						; the item the timer was armed for
		*ButtonTheme.Theme				; shared palette for the button metas: transparent when cold, ShadeColor on hover/press
		*ModeOpenItem.ToolBar_Item		; item whose mode menu is showing (cleared shortly after the menu closes, like the Combo's Unfolded flag)
		List Items.ToolBar_Item()
	EndStructure
	
	Procedure ToolBar_Forward(*Button.ButtonData, EventType)
		Protected Event.Event
		Event\EventType = EventType
		ProcedureReturn *Button\EventHandler(*Button, @Event)
	EndProcedure
	
	Procedure ToolBar_ItemAt(*GadgetData.ToolBarData, P)
		Protected Offset = *GadgetData\Border, Size
		
		With *GadgetData
			ForEach \Items()
				Select \Items()\Type
					Case #ToolBar_Separator
						Size = #ToolBar_SeparatorSize
					Case #ToolBar_ModeButton
						Size = \ButtonSize + #ToolBar_ModeChevron_Size
					Default
						Size = \ButtonSize
				EndSelect
				
				If P >= Offset And P < Offset + Size
					If \Items()\Type = #ToolBar_Separator
						ProcedureReturn -1
					Else
						ProcedureReturn ListIndex(\Items())
					EndIf
				EndIf
				Offset + Size
			Next
		EndWith
		
		ProcedureReturn -1
	EndProcedure
	
	Procedure ToolBar_Redraw(*GadgetData.ToolBarData)
		Protected Offset, CellX, CellY, *Button.ButtonData
		
		With *GadgetData
			If \Border
				AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
				VectorSourceColor(\ThemeData\LineColor[#Cold])
				StrokePath(2, #PB_Path_Preserve)
				VectorSourceColor(\ThemeData\BackColor[#Cold])
				FillPath()
			EndIf
			
			Offset = \Border
			
			ForEach \Items()
				If \Vertical
					CellX = \OriginX + \Border
					CellY = \OriginY + Offset
				Else
					CellX = \OriginX + Offset
					CellY = \OriginY + \Border
				EndIf
				
				
				Select \Items()\Type
					Case #ToolBar_Separator ;{
						If \Vertical
							MovePathCursor(CellX + #ToolBar_Margin * 2, CellY + #ToolBar_SeparatorSize * 0.5)
							AddPathLine(\ButtonSize - #ToolBar_Margin * 4, 0, #PB_Path_Relative)
						Else
							MovePathCursor(CellX + #ToolBar_SeparatorSize * 0.5, CellY + #ToolBar_Margin * 2)
							AddPathLine(0, \ButtonSize - #ToolBar_Margin * 4, #PB_Path_Relative)
						EndIf
						VectorSourceColor(\ThemeData\LineColor[#Cold])
						StrokePath(1)
						Offset + #ToolBar_SeparatorSize
						;}
					Case #ToolBar_ModeButton ;{ Mode button: icon side then chevron side, adjacent like a split button
						*Button = \Items()\Button
						*Button\OriginX = CellX + #ToolBar_Margin
						*Button\OriginY = CellY + #ToolBar_Margin
						SaveVectorState()
						*Button\Redraw(*Button)
						RestoreVectorState()
						
						*Button = \Items()\ModeButton
						*Button\OriginX = CellX + #ToolBar_Margin
						*Button\OriginY = CellY + #ToolBar_Margin
						If \Vertical
							*Button\OriginY + \ButtonSize - #ToolBar_Margin * 2 + 1
						Else
							*Button\OriginX + \ButtonSize - #ToolBar_Margin * 2 + 1
						EndIf
						
						SaveVectorState()
						*Button\Redraw(*Button)
						RestoreVectorState()
						Offset + \ButtonSize + #ToolBar_ModeChevron_Size
						;}
					Default ;{ Button
						*Button = \Items()\Button
						*Button\OriginX = CellX + #ToolBar_Margin
						*Button\OriginY = CellY + #ToolBar_Margin
						SaveVectorState()			; Button_Redraw clips to its box; isolate so it doesn't shrink the shared clip
						*Button\Redraw(*Button)
						RestoreVectorState()
						Offset + \ButtonSize
						;}
				EndSelect
				
			Next
		EndWith
	EndProcedure
	
	Procedure ToolBar_ItemOffset(*GadgetData.ToolBarData, Index)
		Protected Offset = *GadgetData\Border
		With *GadgetData
			ForEach \Items()
				If ListIndex(\Items()) = Index
					Break
				EndIf
				Select \Items()\Type
					Case #ToolBar_Separator
						Offset + #ToolBar_SeparatorSize
					Case #ToolBar_ModeButton
						Offset + \ButtonSize + #ToolBar_ModeChevron_Size
					Default
						Offset + \ButtonSize
				EndSelect
			Next
		EndWith
		ProcedureReturn Offset
	EndProcedure
	
	Procedure ToolBar_TipShow(*GadgetData.ToolBarData, Timer)
		Protected X, Y
		
		RemoveGadgetTimer(Timer)
		With *GadgetData
			\TipTimer = 0
			If \MouseItem = \TipItem And \TipItem > -1 And SelectElement(\Items(), \TipItem) And \Items()\Text <> ""
				X = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate)
				Y = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate)
				If \Vertical
					X + \Width + 4
					Y + ToolBar_ItemOffset(*GadgetData, \TipItem)
				Else
					X + ToolBar_ItemOffset(*GadgetData, \TipItem)
					Y + \Height + 4
				EndIf
				ShowTooltip(\Items()\Text, X, Y, \ThemeData)
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_CancelTip(*GadgetData.ToolBarData)
		With *GadgetData
			HideTooltip()
			If \TipTimer
				RemoveGadgetTimer(\TipTimer)
				\TipTimer = 0
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_ChevronAt(*GadgetData.ToolBarData, Item, P)
		; #True when P sits on the chevron side of a mode button. Leaves the item list on an undefined element.
		With *GadgetData
			If Item > -1 And SelectElement(\Items(), Item) And \Items()\Type = #ToolBar_ModeButton
				ProcedureReturn Bool(P >= ToolBar_ItemOffset(*GadgetData, Item) + \ButtonSize - #ToolBar_Margin + 1)
			EndIf
		EndWith
		ProcedureReturn #False
	EndProcedure
	
	Procedure ToolBar_PartButton(*GadgetData.ToolBarData, Chevron)
		; The button meta under the cursor for the current item; the item list element must already be selected.
		With *GadgetData
			If \Items()\Type = #ToolBar_ModeButton And Chevron
				ProcedureReturn \Items()\ModeButton
			Else
				ProcedureReturn \Items()\Button
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_ModeApply(*GadgetData.ToolBarData, *Item.ToolBar_Item, Mode)
		; Make Mode the active one: sync the menu's selection and put its icon on the icon side. Doesn't redraw the bar.
		Protected *SubGadget.PB_Gadget, *VListData.VerticalListData
		
		With *Item
			If Mode > -1 And Mode < \ModeCount
				\Mode = Mode
				SetGadgetState(\ModeList, Mode)
				*SubGadget = IsGadget(\ModeList)
				*VListData = *SubGadget\vt
				SelectElement(*VListData\Items(), Mode)
				\Button\TextBlock\Image = *VListData\Items()\Text\Image
				PrepareVectorTextBlock(@\Button\TextBlock)
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_ModeMenuTimer(*GadgetData.ToolBarData, Timer)
		RemoveGadgetTimer(Timer)
		*GadgetData\ModeOpenItem = 0
	EndProcedure
	
	Procedure ToolBar_ModeWindowHandler()
		; The menu window lost activation: hide it. ModeOpenItem lingers 20 ms so a click on the chevron that
		; caused the deactivation reads as "close" instead of instantly reopening (same dance as the Combo).
		Protected Window = EventWindow(), *GadgetData.ToolBarData = GetProp_(WindowID(Window), "UITK_ToolBarData")
		
		AddGadgetTimer(*GadgetData, 20, @ToolBar_ModeMenuTimer())
		HideWindow(Window, #True)
	EndProcedure
	
	Procedure ToolBar_ModeListHandler()
		; A mode was picked in the dropdown.
		Protected Gadget = EventGadget()
		Protected *GadgetData.ToolBarData = GetProp_(GadgetID(Gadget), "UITK_ToolBarData")
		Protected *Item.ToolBar_Item = GetProp_(GadgetID(Gadget), "UITK_ToolBarItem")
		
		With *GadgetData
			ToolBar_ModeApply(*GadgetData, *Item, GetGadgetState(Gadget))
			HideWindow(*Item\ModeWindow, #True)
			\ModeOpenItem = 0
			ChangeCurrentElement(\Items(), *Item)
			\State = ListIndex(\Items())
			RedrawObject()
			PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
		EndWith
	EndProcedure
	
	Procedure ToolBar_ModeMenuShow(*GadgetData.ToolBarData, *Item.ToolBar_Item)
		Protected X, Y, Offset
		
		With *GadgetData
			ChangeCurrentElement(\Items(), *Item)
			Offset = ToolBar_ItemOffset(*GadgetData, ListIndex(\Items()))
			X = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate)
			Y = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate)
			If \Vertical
				X + \Width + 2
				Y + Offset
			Else
				X + Offset
				Y + \Height + 2
			EndIf
			SetWindowPos_(WindowID(*Item\ModeWindow), 0, X, Y, 0, 0, #SWP_NOZORDER | #SWP_NOREDRAW | #SWP_NOSIZE)
			HideWindow(*Item\ModeWindow, #False)
			SetActiveGadget(*Item\ModeList)
			\ModeOpenItem = *Item
		EndWith
	EndProcedure
	
	Procedure ToolBar_EventHandler(*GadgetData.ToolBarData, *Event.Event)
		Protected Redraw, Item, P, Chevron
		
		With *GadgetData
			If \Vertical
				P = *Event\MouseY
			Else
				P = *Event\MouseX
			EndIf
			
			Select *Event\EventType
				Case #MouseMove ;{
					Item = ToolBar_ItemAt(*GadgetData, P)
					Chevron = ToolBar_ChevronAt(*GadgetData, Item, P)
					If Item <> \MouseItem Or Chevron <> \MouseChevron
						; Move hover from the old button to the new one (the two sides of a mode button count as two buttons).
						If \MouseItem > -1 And SelectElement(\Items(), \MouseItem) And \Items()\Button
							ToolBar_Forward(ToolBar_PartButton(*GadgetData, \MouseChevron), #MouseLeave)
						EndIf
						If Item > -1 And SelectElement(\Items(), Item) And \Items()\Button
							ToolBar_Forward(ToolBar_PartButton(*GadgetData, Chevron), #MouseEnter)
						EndIf
						If Item <> \MouseItem
							; Any showing or pending tip is stale; arm a fresh delay.
							ToolBar_CancelTip(*GadgetData)
							If Item > -1
								\TipItem = Item
								\TipTimer = AddGadgetTimer(*GadgetData, #ToolBar_TipDelay, @ToolBar_TipShow())
							EndIf
						EndIf
						\MouseItem = Item
						\MouseChevron = Chevron
						Redraw = #True
					EndIf
					;}
				Case #MouseLeave ;{
					ToolBar_CancelTip(*GadgetData)
					If \MouseItem > -1 And SelectElement(\Items(), \MouseItem) And \Items()\Button
						ToolBar_Forward(ToolBar_PartButton(*GadgetData, \MouseChevron), #MouseLeave)
					EndIf
					If \MouseItem <> -1
						\MouseItem = -1
						\MouseChevron = #False
						Redraw = #True
					EndIf
					;}
				Case #LeftButtonDown ;{
					ToolBar_CancelTip(*GadgetData)	; A press means the user knows what they want
					Item = ToolBar_ItemAt(*GadgetData, P)
					Chevron = ToolBar_ChevronAt(*GadgetData, Item, P)
					If Item > -1 And SelectElement(\Items(), Item) And \Items()\Button And \Items()\Button\Enabled
						ToolBar_Forward(ToolBar_PartButton(*GadgetData, Chevron), #LeftButtonDown)
						If Chevron
							; The menu opens on press, like the Combo. If it was showing an instant ago, this press closed it.
							If \ModeOpenItem = @\Items()
								\ModeOpenItem = 0
							ElseIf \Items()\ModeCount
								ToolBar_ModeMenuShow(*GadgetData, @\Items())
							EndIf
						EndIf
						Redraw = #True
					EndIf
					;}
				Case #LeftClick ;{
					Item = ToolBar_ItemAt(*GadgetData, P)
					Chevron = ToolBar_ChevronAt(*GadgetData, Item, P)
					If Item > -1 And SelectElement(\Items(), Item) And \Items()\Button And \Items()\Button\Enabled
						If \Items()\Type = #ToolBar_ModeButton And Chevron
							\Items()\ModeButton\MouseState = #Warm	; release the press without posting a Change; the menu is already showing
						Else
							If \Items()\Type = #ToolBar_ModeButton And \Items()\ModeCount
								ToolBar_ModeApply(*GadgetData, @\Items(), (\Items()\Mode + 1) % \Items()\ModeCount)
							EndIf
							\State = Item
							ToolBar_Forward(\Items()\Button, #LeftClick)	; toggles + posts Change for the bar
						EndIf
					EndIf
					Redraw = #True
					;}
			EndSelect
			
			If Redraw
				RedrawObject()
			EndIf
		EndWith
		
		ProcedureReturn Redraw
	EndProcedure
	
	Procedure ToolBar_MakeButton(*GadgetData.ToolBarData, ImageID, Toggle)
		Protected *Button.ButtonData, BtnSize = *GadgetData\ButtonSize - #ToolBar_Margin * 2
		AllocateStructureX(*Button, ButtonData)
		Button_Meta(*Button, *GadgetData\ButtonTheme, *GadgetData\Gadget, 0, 0, BtnSize, BtnSize, "", (Bool(Toggle) * #Button_Toggle) | #Gadget_Meta)
		*Button\ParentWindow = *GadgetData\ParentWindow
		*Button\TextBlock\Image = ImageID
		PrepareVectorTextBlock(@*Button\TextBlock)
		ProcedureReturn *Button
	EndProcedure
	
	Procedure ToolBar_MakeModeButton(*GadgetData.ToolBarData, *NewItem.ToolBar_Item, ImageID)
		Protected *Button.ButtonData, BtnSize = *GadgetData\ButtonSize - #ToolBar_Margin * 2
		Protected *ModeButton.ButtonData, GadgetList
		
		; Icon side: shows the active mode's icon, a click cycles to the next mode
		AllocateStructureX(*Button, ButtonData)
		Button_Meta(*Button, *GadgetData\ButtonTheme, *GadgetData\Gadget, 0, 0, BtnSize, BtnSize, "", #Gadget_Meta)
		*Button\ParentWindow = *GadgetData\ParentWindow
		*Button\TextBlock\Image = ImageID
		
		; Chevron side: opens the mode menu. The triangle points along the direction the menu opens.
		AllocateStructureX(*ModeButton, ButtonData)
		If *GadgetData\Vertical
			*NewItem\ModeChevronIMG = CreateImage(#PB_Any, 4, 6, 32, #PB_Image_Transparent)
			StartVectorDrawing(ImageVectorOutput(*NewItem\ModeChevronIMG))
			MovePathCursor(0, 0)
			AddPathLine(4, 3)
			AddPathLine(0, 6)
			ClosePath()
			VectorSourceColor(*GadgetData\ThemeData\TextColor[#Cold])
			FillPath()
			StopVectorDrawing()
			Button_Meta(*ModeButton, *GadgetData\ButtonTheme, *GadgetData\Gadget, 0, 0, BtnSize, #ToolBar_ModeChevron_Size, "", #Gadget_Meta)
			
			*Button\CornerType = #Corner_Top
			*ModeButton\CornerType = #Corner_Bottom
		Else
			*NewItem\ModeChevronIMG = CreateImage(#PB_Any, 6, 4, 32, #PB_Image_Transparent)
			StartVectorDrawing(ImageVectorOutput(*NewItem\ModeChevronIMG))
			MovePathCursor(0, 0)
			AddPathLine(6, 0)
			AddPathLine(3, 4)
			ClosePath()
			VectorSourceColor(*GadgetData\ThemeData\TextColor[#Cold])
			FillPath()
			StopVectorDrawing()
			Button_Meta(*ModeButton, *GadgetData\ButtonTheme, *GadgetData\Gadget, 0, 0, #ToolBar_ModeChevron_Size, BtnSize, "", #Gadget_Meta)
			
			*Button\CornerType = #Corner_Left
			*ModeButton\CornerType = #Corner_Right
		EndIf
		*ModeButton\ParentWindow = *GadgetData\ParentWindow
		*ModeButton\TextBlock\Image = ImageID(*NewItem\ModeChevronIMG)
		
		PrepareVectorTextBlock(@*Button\TextBlock)
		PrepareVectorTextBlock(@*ModeButton\TextBlock)
		*NewItem\Button = *Button
		*NewItem\ModeButton = *ModeButton
		*NewItem\Mode = -1
		
		; Mode menu: borderless popup owning a VerticalList, opened under (or next to) the chevron - same recipe as the Combo.
		GadgetList = UseGadgetList(0)
		*NewItem\ModeWindow = OpenWindow(#PB_Any, 0, 0, #ToolBar_ModeMenuWidth, #VerticalList_ItemHeight + 2, "", #PB_Window_BorderLess | #PB_Window_Invisible, WindowID(*GadgetData\ParentWindow))
		SetWindowColor(*NewItem\ModeWindow, RGB(Red(*GadgetData\ThemeData\LineColor[#Warm]), Green(*GadgetData\ThemeData\LineColor[#Warm]), Blue(*GadgetData\ThemeData\LineColor[#Warm])))
		*NewItem\ModeList = VerticalList(#PB_Any, 1, 1, #ToolBar_ModeMenuWidth - 2, #VerticalList_ItemHeight)
		SetGadgetAttribute(*NewItem\ModeList, #Attribute_CornerRadius, 0)
		UseGadgetList(GadgetList)
		
		SetProp_(WindowID(*NewItem\ModeWindow), "UITK_ToolBarData", *GadgetData)
		SetProp_(GadgetID(*NewItem\ModeList), "UITK_ToolBarData", *GadgetData)
		SetProp_(GadgetID(*NewItem\ModeList), "UITK_ToolBarItem", *NewItem)
		BindEvent(#PB_Event_DeactivateWindow, @ToolBar_ModeWindowHandler(), *NewItem\ModeWindow)
		BindGadgetEvent(*NewItem\ModeList, @ToolBar_ModeListHandler(), #PB_EventType_Change)
		
		SetGadgetColor(*NewItem\ModeList, #Color_Shade_Cold, *GadgetData\ThemeData\BackColor[#Warm])
		SetGadgetColor(*NewItem\ModeList, #Color_Shade_Warm, *GadgetData\ThemeData\BackColor[#Hot])
		SetGadgetColor(*NewItem\ModeList, #Color_Shade_Hot, *GadgetData\ThemeData\BackColor[#Hot])
		SetGadgetColor(*NewItem\ModeList, #Color_Text_Cold, *GadgetData\ThemeData\TextColor[#Cold])
		SetGadgetColor(*NewItem\ModeList, #Color_Text_Warm, *GadgetData\ThemeData\TextColor[#Warm])
		SetGadgetColor(*NewItem\ModeList, #Color_Text_Hot, *GadgetData\ThemeData\TextColor[#Hot])
		
		ProcedureReturn *NewItem
	EndProcedure
	
	Procedure ToolBar_AddItem(*This.PB_Gadget, Position, *Text, ImageID, Flags.l)
		Protected *GadgetData.ToolBarData = *this\vt, *NewItem.ToolBar_Item
		
		If Flags = 0
			Flags = #Toolbar_DefaultButton
		EndIf
		
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				*NewItem = InsertElement(\Items())
			Else
				LastElement(\Items())
				*NewItem = AddElement(\Items())
			EndIf
			
			*NewItem\Text = PeekS(*Text)
			*NewItem\Type = Flags
			
			Select Flags
				Case #ToolBar_Separator
					*NewItem\Type = #ToolBar_Separator
				Case #ToolBar_ModeButton
					*NewItem = ToolBar_MakeModeButton(*GadgetData, *NewItem, ImageID)
					*NewItem\Type = #ToolBar_ModeButton
				Default
					*NewItem\Type = #Toolbar_DefaultButton
					*NewItem\Button = ToolBar_MakeButton(*GadgetData, ImageID, Bool(Flags = #ToolBar_Toggle))
			EndSelect
			
			ChangeCurrentElement(\Items(), *NewItem)
			Position = ListIndex(\Items())
			RedrawObject()
		EndWith
		
		ProcedureReturn Position
	EndProcedure
	
	Procedure ToolBarAddMode(Gadget, Item, Text.s, ImageID = 0)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.ToolBarData
		Protected *SubGadget.PB_Gadget, *VListData.VerticalListData, Mode, MenuWidth
		
		If *this = 0
			ProcedureReturn -1
		EndIf
		*GadgetData = *this\vt
		
		With *GadgetData
			If Item > -1 And SelectElement(\Items(), Item) And \Items()\Type = #ToolBar_ModeButton
				Mode = \Items()\ModeCount
				AddGadgetItem(\Items()\ModeList, -1, Text, ImageID)
				\Items()\ModeCount + 1
				
				; Grow the popup to fit the widest mode name; past #ToolBar_ModeMenuMaxItem entries the list scrolls instead.
				*SubGadget = IsGadget(\Items()\ModeList)
				*VListData = *SubGadget\vt
				SelectElement(*VListData\Items(), Mode)
				MenuWidth = GadgetWidth(\Items()\ModeList)
				If *VListData\Items()\Text\RequiredWidth + #VerticalList_Margin * 2 + #VerticalList_IconWidth > MenuWidth
					MenuWidth = *VListData\Items()\Text\RequiredWidth + #VerticalList_Margin * 2 + #VerticalList_IconWidth
				EndIf
				If \Items()\ModeCount <= #ToolBar_ModeMenuMaxItem
					ResizeWindow(\Items()\ModeWindow, #PB_Ignore, #PB_Ignore, MenuWidth + 2, \Items()\ModeCount * *VListData\ItemHeight + 2)
					ResizeGadget(\Items()\ModeList, #PB_Ignore, #PB_Ignore, MenuWidth, \Items()\ModeCount * *VListData\ItemHeight)
				ElseIf MenuWidth <> GadgetWidth(\Items()\ModeList)
					ResizeWindow(\Items()\ModeWindow, #PB_Ignore, #PB_Ignore, MenuWidth + 2, #PB_Ignore)
					ResizeGadget(\Items()\ModeList, #PB_Ignore, #PB_Ignore, MenuWidth, #PB_Ignore)
				EndIf
				
				; The first mode becomes the active one and takes over the icon side.
				If \Items()\ModeCount = 1
					ToolBar_ModeApply(*GadgetData, @\Items(), 0)
					RedrawObject()
				EndIf
				
				ProcedureReturn Mode
			EndIf
		EndWith
		
		ProcedureReturn -1
	EndProcedure
	
	Procedure ToolBarGetMode(Gadget, Item)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.ToolBarData
		
		If *this
			*GadgetData = *this\vt
			If Item > -1 And SelectElement(*GadgetData\Items(), Item) And *GadgetData\Items()\Type = #ToolBar_ModeButton
				ProcedureReturn *GadgetData\Items()\Mode
			EndIf
		EndIf
		
		ProcedureReturn -1
	EndProcedure
	
	Procedure ToolBarSetMode(Gadget, Item, Mode)
		Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.ToolBarData
		
		If *this
			*GadgetData = *this\vt
			With *GadgetData
				If Item > -1 And SelectElement(\Items(), Item) And \Items()\Type = #ToolBar_ModeButton And Mode > -1 And Mode < \Items()\ModeCount
					ToolBar_ModeApply(*GadgetData, @\Items(), Mode)
					RedrawObject()
					ProcedureReturn #True
				EndIf
			EndWith
		EndIf
	EndProcedure
	
	Procedure ToolBar_FreeItem(*GadgetData.ToolBarData, *Item.ToolBar_Item)
		With *Item
			If \Button
				FreeStructureX(\Button)
			EndIf
			If \Type = #ToolBar_ModeButton
				If *GadgetData\ModeOpenItem = *Item
					*GadgetData\ModeOpenItem = 0
				EndIf
				If \ModeButton
					FreeStructureX(\ModeButton)
				EndIf
				If IsImage(\ModeChevronIMG)
					FreeImage(\ModeChevronIMG)
				EndIf
				If IsGadget(\ModeList)
					UnbindGadgetEvent(\ModeList, @ToolBar_ModeListHandler(), #PB_EventType_Change)
					FreeGadget(\ModeList)
				EndIf
				If IsWindow(\ModeWindow)
					UnbindEvent(#PB_Event_DeactivateWindow, @ToolBar_ModeWindowHandler(), \ModeWindow)
					CloseWindow(\ModeWindow)
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_RemoveItem(*This.PB_Gadget, Position)
		Protected *GadgetData.ToolBarData = *this\vt
		With *GadgetData
			If Position > -1 And SelectElement(\Items(), Position)
				ToolBar_FreeItem(*GadgetData, @\Items())
				DeleteElement(\Items())
				If Position <= \State
					\State - 1
				EndIf
				\MouseItem = -1
				\PressedItem = -1
				RedrawObject()
				ProcedureReturn #True
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_ClearItems(*This.PB_Gadget)
		Protected *GadgetData.ToolBarData = *this\vt
		With *GadgetData
			ForEach \Items()
				ToolBar_FreeItem(*GadgetData, @\Items())
			Next
			ClearList(\Items())
			\State = -1
			\MouseItem = -1
			\PressedItem = -1
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure ToolBar_CountItem(*This.PB_Gadget)
		Protected *GadgetData.ToolBarData = *this\vt
		ProcedureReturn ListSize(*GadgetData\Items())
	EndProcedure
	
	Procedure ToolBar_GetItemState(*This.PB_Gadget, Position)
		Protected *GadgetData.ToolBarData = *this\vt, Result
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				If \Items()\Button
					; Disabled is the dominant state; otherwise report the toggle.
					If Not \Items()\Button\Enabled
						Result = #Item_State_Disabled
					ElseIf \Items()\Button\State
						Result = #Item_State_Toggled
					Else
						Result = #Item_State_Untoggled
					EndIf
				EndIf
			EndIf
		EndWith
		ProcedureReturn Result
	EndProcedure
	
	Procedure ToolBar_SetItemState(*This.PB_Gadget, Position, State)
		Protected *GadgetData.ToolBarData = *this\vt
		With *GadgetData
			If Position > -1 And SelectElement(\Items(), Position) And \Items()\Button
				Select State
					Case #Item_State_Untoggled		; also matches #False
						If \Items()\Button\Toggle
							\Items()\Button\State = #False
						EndIf
					Case #Item_State_Toggled		; also matches #True
						If \Items()\Button\Toggle
							\Items()\Button\State = #Hot
						EndIf
					Case #Item_State_Enabled
						\Items()\Button\Enabled = #True
						If \Items()\Type = #ToolBar_ModeButton
							\Items()\ModeButton\Enabled = #True
						EndIf
					Case #Item_State_Disabled
						\Items()\Button\Enabled = #False
						If \Items()\Type = #ToolBar_ModeButton
							\Items()\ModeButton\Enabled = #False
						EndIf
				EndSelect
				RedrawObject()
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_GetItemImage(*This.PB_Gadget, Position)
		Protected *GadgetData.ToolBarData = *this\vt
		With *GadgetData
			If Position > -1 And Position < ListSize(\Items())
				SelectElement(\Items(), Position)
				If \Items()\Button
					ProcedureReturn \Items()\Button\TextBlock\Image
				EndIf
			EndIf
		EndWith
	EndProcedure
	
	Procedure ToolBar_Resize(*This.PB_Gadget, x, y, Width, Height)
		Protected *GadgetData.ToolBarData = *this\vt, BtnSize
		
		*this\VT = *GadgetData\OriginalVT
		ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
		*this\VT = *GadgetData
		
		With *GadgetData
			\Width = GadgetWidth(\Gadget)
			\Height = GadgetHeight(\Gadget)
			If \Vertical
				\ButtonSize = \Width - \Border * 2
			Else
				\ButtonSize = \Height - \Border * 2
			EndIf
			BtnSize = \ButtonSize - #ToolBar_Margin * 2
			
			ForEach \Items()
				If \Items()\Button
					\Items()\Button\Width = BtnSize
					\Items()\Button\Height = BtnSize
					\Items()\Button\TextBlock\Width = BtnSize
					\Items()\Button\TextBlock\Height = BtnSize
					PrepareVectorTextBlock(@\Items()\Button\TextBlock)
				EndIf
				If \Items()\Type = #ToolBar_ModeButton And \Items()\ModeButton
					If \Vertical
						\Items()\ModeButton\Width = BtnSize
						\Items()\ModeButton\Height = #ToolBar_ModeChevron_Size
					Else
						\Items()\ModeButton\Width = #ToolBar_ModeChevron_Size
						\Items()\ModeButton\Height = BtnSize
					EndIf
					\Items()\ModeButton\TextBlock\Width = \Items()\ModeButton\Width
					\Items()\ModeButton\TextBlock\Height = \Items()\ModeButton\Height
					PrepareVectorTextBlock(@\Items()\ModeButton\TextBlock)
				EndIf
			Next
			
			RedrawObject()
		EndWith
	EndProcedure
	
	Procedure ToolBar_Free(*This.PB_Gadget)
		Protected *GadgetData.ToolBarData = *this\vt
		
		With *GadgetData
			DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
			ToolBar_CancelTip(*GadgetData)
			
			ForEach \Items()
				ToolBar_FreeItem(*GadgetData, @\Items())
			Next
			If \ButtonTheme
				FreeStructureX(\ButtonTheme)
			EndIf
			
			RemoveGadgetTimers(*GadgetData)
			*this\vt = \OriginalVT
			FreeStructureX(\ThemeData)
		EndWith
		
		FreeStructureX(*GadgetData)
		
		ProcedureReturn CallFunctionFast(*this\vt\FreeGadget, *this)
	EndProcedure
	
	Procedure ToolBar_Meta(*GadgetData.ToolBarData, *ThemeData, Gadget, x, y, Width, Height, Flags)
		*GadgetData\ThemeData = *ThemeData
		InitializeObject(ToolBar)
		
		With *GadgetData
			\Vertical = Bool(Flags & #Gadget_Vertical)
			If \Vertical
				\ButtonSize = \Width - \Border * 2
			Else
				\ButtonSize = \Height - \Border * 2
			EndIf
			\State = -1
			\MouseItem = -1
			\PressedItem = -1
			
			; Shared palette for the button metas: nothing when cold, the bar's ShadeColor on hover/press,
			; so Button_Redraw reproduces the flat-until-hover ToolBar look.
			AllocateStructureX(\ButtonTheme, Theme)
			CopyStructure(\ThemeData, \ButtonTheme, Theme)
			\ButtonTheme\BackColor[#Cold]		= 0
			\ButtonTheme\BackColor[#Warm]		= \ThemeData\ShadeColor[#Warm]
			\ButtonTheme\BackColor[#Hot]		= \ThemeData\ShadeColor[#Hot]
			\ButtonTheme\BackColor[#Disabled]	= 0
			
			\VT\AddGadgetItem3 = @ToolBar_AddItem()
			\VT\RemoveGadgetItem = @ToolBar_RemoveItem()
			\VT\ClearGadgetItemList = @ToolBar_ClearItems()
			\VT\ResizeGadget = @ToolBar_Resize()
			\VT\CountGadgetItems = @ToolBar_CountItem()
			\VT\GetGadgetItemState = @ToolBar_GetItemState()
			\VT\SetGadgetItemState = @ToolBar_SetItemState()
			\VT\GetGadgetItemImage = @ToolBar_GetItemImage()
			\VT\FreeGadget = @ToolBar_Free()
			
			; Enable only the needed events
			\SupportedEvent[#MouseMove] = #True
			\SupportedEvent[#MouseLeave] = #True
			\SupportedEvent[#LeftButtonDown] = #True
			\SupportedEvent[#LeftButtonUp] = #True
			\SupportedEvent[#LeftClick] = #True
		EndWith
	EndProcedure
	
	Procedure ToolBar(Gadget, x, y, Width, Height, Flags = #Default)
		Protected Result, *this.PB_Gadget, *GadgetData.ToolBarData, *ThemeData
		
		Result = CanvasGadget(Gadget, x, y, Width, Height)
		
		If Result
			CreateGadgetObject(ToolBarData)
			ToolBar_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
			
			RedrawObject()
		EndIf
		
		ProcedureReturn Result
	EndProcedure
	;}
	
	
	;{ LayerList
	; A layer panel: foldable parent groups, each holding children, every row carrying its own
	; visibility toggle. Children drag from one group to another, a group reorders as a whole
	; block. Structurally this is a VerticalList over a two-level item list.
	;
	; Like the TimeLine it's a specialised gadget, so it's opt-in — declare an EnableLayerList
	; module before including the library to compile it in:
	;
	;	DeclareModule EnableLayerList :: EndDeclareModule
	;	Module EnableLayerList :: EndModule
	;	IncludeFile "UI-Toolkit.pbi"
	
	CompilerIf Defined(EnableLayerList, #PB_Module)
		#LayerList_ItemHeight = 24				; row height
		#LayerList_Margin = 3
		#LayerList_FoldWidth = 16				; fold-chevron column; doubles as the child indent step
		#LayerList_EyeWidth = 22				; visibility-button column, right aligned
		#LayerList_ToolbarThickness = 7			; scrollbar thickness — always reserved, so the eye never shifts
		#LayerList_ReorderDelay = 400			; ms between auto-scroll steps while dragging against an edge
		#LayerList_MarkerHeight = 3				; thickness of the drop-position marker
		
		Enumeration ; Which part of a row the pointer is over
			#LayerList_Zone_Body
			#LayerList_Zone_Fold
			#LayerList_Zone_Eye
		EndEnumeration
		
		Structure LayerList_Item
			Text.Text							; must stay first: a VerticalList-style *CustomItem callback expects it there
			Child.b								; #False = parent group, #True = child of the group above it
			Folded.b							; parents only: children are in the list but take no row
			Visible.b							; this row's own eye state
			Selected.b							; part of the current selection (#MultiSelect)
			*Data
		EndStructure
		
		Structure LayerListData Extends GadgetData
			ItemHeight.l
			VisibleScrollBar.b
			ItemState.i							; hovered row, as a list index, or -1
			MultiSelect.l
			SelectAnchor.l						; where a shift-click range starts
			PendingSelect.l						; row to collapse the selection onto when a press turns out not to be a drag
			HoverZone.b							; which part of the hovered row (#LayerList_Zone_*)
			
			Reorder.i
			DragState.i
			DragOriginX.i
			DragOriginY.i
			DragIndex.i							; list index of the row being dragged
			DragChild.b							; dragging a lone child, rather than a group and its children
			ReorderRow.i						; row the dragged item would land before, or -1
			ReorderTimer.i
			ReorderDirection.b
			ReorderWindow.i
			ReorderCanvas.i
			
			Editable.l
			Editing.b
			EditCursor.b					; the cursor shape in force, and so also "pointer inside the editor"
			
			*String.StringData				; inline rename editor, only allocated with #Editable
			*ItemRedraw.ItemRedraw
			*ScrollBar.ScrollBarData
			
			List Items.LayerList_Item()
		EndStructure
		
		Declare LayerList_EventHandler(*GadgetData.LayerListData, *Event.Event)
		
		;- Structure walking
		; The item list is flat — a parent is followed by its children — but a child inside a
		; folded group takes no row on screen, so list indices and screen rows diverge. These
		; helpers convert between the two. They all walk the list, so they leave the current
		; element wherever they finished: re-select what you need after calling one.
		
		Procedure LayerList_ParentOf(*GadgetData.LayerListData, Index)
			; List index of the group owning Index. -1 for a parent, or for a child with no group above it.
			Protected Result = -1
			
			With *GadgetData
				If SelectElement(\Items(), Index) And \Items()\Child
					While PreviousElement(\Items())
						If Not \Items()\Child
							Result = ListIndex(\Items())
							Break
						EndIf
					Wend
				EndIf
			EndWith
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure LayerList_ChildCount(*GadgetData.LayerListData, Parent)
			; How many children directly follow the group at Parent.
			Protected Count
			
			With *GadgetData
				If SelectElement(\Items(), Parent) And Not \Items()\Child
					While NextElement(\Items()) And \Items()\Child
						Count + 1
					Wend
				EndIf
			EndWith
			
			ProcedureReturn Count
		EndProcedure
		
		Procedure LayerList_RowCount(*GadgetData.LayerListData)
			; Rows currently on screen, folded-away children excluded.
			Protected Count, Folded
			
			With *GadgetData
				ForEach \Items()
					If \Items()\Child
						If Folded
							Continue
						EndIf
					Else
						Folded = \Items()\Folded
					EndIf
					Count + 1
				Next
			EndWith
			
			ProcedureReturn Count
		EndProcedure
		
		Procedure LayerList_RowToIndex(*GadgetData.LayerListData, Row)
			; Screen row -> list index, or -1 when Row is past the end.
			Protected Count = -1, Folded
			
			With *GadgetData
				ForEach \Items()
					If \Items()\Child
						If Folded
							Continue
						EndIf
					Else
						Folded = \Items()\Folded
					EndIf
					
					Count + 1
					If Count = Row
						ProcedureReturn ListIndex(\Items())
					EndIf
				Next
			EndWith
			
			ProcedureReturn -1
		EndProcedure
		
		Procedure LayerList_IndexToRow(*GadgetData.LayerListData, Index)
			; List index -> screen row, or -1 when the item sits inside a folded group.
			Protected Count = -1, Folded
			
			With *GadgetData
				ForEach \Items()
					If \Items()\Child
						If Folded
							If ListIndex(\Items()) = Index
								ProcedureReturn -1
							EndIf
							Continue
						EndIf
					Else
						Folded = \Items()\Folded
					EndIf
					
					Count + 1
					If ListIndex(\Items()) = Index
						ProcedureReturn Count
					EndIf
				Next
			EndWith
			
			ProcedureReturn -1
		EndProcedure
		
		Procedure LayerList_EffectiveVisible(*GadgetData.LayerListData, Index)
			; A row shows through only when its own eye is on and, for a child, its group's is too.
			Protected Result, Parent
			
			With *GadgetData
				If SelectElement(\Items(), Index)
					Result = \Items()\Visible
					
					If Result And \Items()\Child
						Parent = LayerList_ParentOf(*GadgetData, Index)
						If Parent > -1 And SelectElement(\Items(), Parent)
							Result = \Items()\Visible
						EndIf
					EndIf
				EndIf
			EndWith
			
			ProcedureReturn Result
		EndProcedure
		
		;- Selection
		; \State is the focus row and what GetGadgetState reports, exactly like a single-select
		; list. With #MultiSelect the per-item Selected flag rides alongside it, and Get/SetGadgetItemState
		; speak that flag - the same contract as PureBasic's #PB_ListView_Multiselect ListViewGadget.
		
		Procedure LayerList_ClearSelection(*GadgetData.LayerListData)
			With *GadgetData
				ForEach \Items()
					\Items()\Selected = #False
				Next
			EndWith
		EndProcedure
		
		Procedure LayerList_SelectOnly(*GadgetData.LayerListData, Index)
			; Collapse the selection onto one row and make it the focus.
			With *GadgetData
				LayerList_ClearSelection(*GadgetData)
				
				If Index > -1 And SelectElement(\Items(), Index)
					\Items()\Selected = #True
				EndIf
				
				\State = Index
				\SelectAnchor = Index
			EndWith
		EndProcedure
		
		Procedure LayerList_SelectRange(*GadgetData.LayerListData, FromIndex, ToIndex)
			; Select every row on screen between two items. Ranges run over visible rows, so children
			; folded away inside a group are passed over rather than silently swept in.
			Protected FromRow, ToRow, Row
			
			With *GadgetData
				FromRow = LayerList_IndexToRow(*GadgetData, FromIndex)
				ToRow = LayerList_IndexToRow(*GadgetData, ToIndex)
				
				If FromRow < 0 Or ToRow < 0
					LayerList_SelectOnly(*GadgetData, ToIndex)
					ProcedureReturn
				EndIf
				
				If FromRow > ToRow
					Swap FromRow, ToRow
				EndIf
				
				LayerList_ClearSelection(*GadgetData)
				
				For Row = FromRow To ToRow
					If SelectElement(\Items(), LayerList_RowToIndex(*GadgetData, Row))
						\Items()\Selected = #True
					EndIf
				Next
				
				\State = ToIndex
			EndWith
		EndProcedure
		
		Procedure LayerList_SelectedCount(*GadgetData.LayerListData)
			Protected Count
			
			With *GadgetData
				ForEach \Items()
					If \Items()\Selected
						Count + 1
					EndIf
				Next
			EndWith
			
			ProcedureReturn Count
		EndProcedure
		
		
		Procedure LayerList_IsSelected(*GadgetData.LayerListData, Index)
			If Index > -1 And SelectElement(*GadgetData\Items(), Index)
				ProcedureReturn *GadgetData\Items()\Selected
			EndIf
			
			ProcedureReturn #False
		EndProcedure
		
		Procedure LayerList_MoveFocus(*GadgetData.LayerListData, Index)
			; Arrow-key move. Shift drags the selection along from the anchor, otherwise the
			; selection collapses onto the row we land on.
			With *GadgetData
				If \MultiSelect And (GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Shift) And \SelectAnchor > -1
					LayerList_SelectRange(*GadgetData, \SelectAnchor, Index)
				Else
					LayerList_SelectOnly(*GadgetData, Index)
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_ToggleVisibility(*GadgetData.LayerListData, Index)
			; Flip a row's eye. When that row is part of a multi-row selection the whole selection
			; follows it, so switching a batch of layers off is one click rather than N.
			;
			; LayerList_SelectedCount walks the list, and a walk leaves the current element
			; wherever it finished - on the LAST item. Testing it inside the condition therefore
			; moved the cursor off the row we had just selected, and the single-row branch below
			; wrote the eye of the last row in the list instead. Hiding one selected item did
			; nothing (unless it happened to BE the last one); a multi-row selection was fine,
			; because its branch starts a fresh ForEach; and an unselected row was fine too,
			; because \Items()\Selected is #False and the count is never reached. Take the count
			; first, then re-select.
			Protected NewState, Batch
			
			With *GadgetData
				If Not SelectElement(\Items(), Index)
					ProcedureReturn
				EndIf
				
				NewState = Bool(Not \Items()\Visible)
				Batch = Bool(\MultiSelect And \Items()\Selected And LayerList_SelectedCount(*GadgetData) > 1)
				
				If Batch
					ForEach \Items()
						If \Items()\Selected
							\Items()\Visible = NewState
						EndIf
					Next
				ElseIf SelectElement(\Items(), Index)
					\Items()\Visible = NewState
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_ClickSelect(*GadgetData.LayerListData, Index, Modifiers)
			; Work out what a press on a row's body does to the selection. Returns #True when
			; anything changed.
			;
			; Pressing an already-selected row with no modifier deliberately leaves the selection
			; alone and only notes what to collapse to on release: otherwise grabbing a multi-row
			; selection to drag it would throw that selection away on the way down.
			With *GadgetData
				\PendingSelect = -1
				
				If Not \MultiSelect
					If Index = \State
						ProcedureReturn #False
					EndIf
					LayerList_SelectOnly(*GadgetData, Index)
					ProcedureReturn #True
				EndIf
				
				If Modifiers & #PB_Canvas_Control
					If SelectElement(\Items(), Index)
						\Items()\Selected = Bool(Not \Items()\Selected)
					EndIf
					\State = Index
					\SelectAnchor = Index
					ProcedureReturn #True
				EndIf
				
				If (Modifiers & #PB_Canvas_Shift) And \SelectAnchor > -1
					LayerList_SelectRange(*GadgetData, \SelectAnchor, Index)
					ProcedureReturn #True
				EndIf
				
				If LayerList_IsSelected(*GadgetData, Index)
					\PendingSelect = Index		; settled on release, if this doesn't become a drag
					\State = Index
					ProcedureReturn #False
				EndIf
				
				LayerList_SelectOnly(*GadgetData, Index)
				ProcedureReturn #True
			EndWith
		EndProcedure
		
		;- Geometry
		
		Procedure LayerList_TextWidth(*GadgetData.LayerListData, Child)
			; Width left for a row's content once the chevron, indent, eye and scrollbar are taken out.
			ProcedureReturn *GadgetData\Width - *GadgetData\Border * 2 - #LayerList_FoldWidth - Bool(Child) * #LayerList_FoldWidth - #LayerList_EyeWidth - #LayerList_ToolbarThickness - #LayerList_Margin * 2
		EndProcedure
		
		Procedure LayerList_TextX(*GadgetData.LayerListData, Child)
			ProcedureReturn *GadgetData\Border + #LayerList_FoldWidth + Bool(Child) * #LayerList_FoldWidth + #LayerList_Margin
		EndProcedure
		
		Procedure LayerList_EyeX(*GadgetData.LayerListData)
			ProcedureReturn *GadgetData\Width - *GadgetData\Border - #LayerList_ToolbarThickness - #LayerList_EyeWidth
		EndProcedure
		
		Procedure LayerList_ZoneAt(*GadgetData.LayerListData, Index, MouseX)
			; Which part of the row at Index the pointer is over.
			Protected Result = #LayerList_Zone_Body, EyeX = LayerList_EyeX(*GadgetData)
			
			With *GadgetData
				If MouseX >= EyeX And MouseX < EyeX + #LayerList_EyeWidth
					Result = #LayerList_Zone_Eye
				ElseIf MouseX < \Border + #LayerList_FoldWidth
					If SelectElement(\Items(), Index) And Not \Items()\Child
						Result = #LayerList_Zone_Fold
					EndIf
				EndIf
			EndWith
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure LayerList_UpdateScrollBar(*GadgetData.LayerListData)
			Protected Total
			
			With *GadgetData
				Total = LayerList_RowCount(*GadgetData) * \ItemHeight
				
				If Total > \Height
					\VisibleScrollBar = #True
					ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_Maximum, Total)
				Else
					; Don't touch the bar's position here: while it's too short to scroll, its
					; Maximum is below one page, so ScrollBar_SetState_Meta would clamp against a
					; negative ceiling and leave a negative position behind.
					\VisibleScrollBar = #False
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_ScrollOffset(*GadgetData.LayerListData)
			; How far the rows are scrolled up. A hidden bar keeps whatever position it last had,
			; which needn't be 0 and needn't even be positive, so a hidden bar means pinned to the
			; top. Every screen-position calculation goes through here so drawing and hit-testing
			; can't disagree.
			If *GadgetData\VisibleScrollBar
				ProcedureReturn *GadgetData\ScrollBar\State
			EndIf
			
			ProcedureReturn 0
		EndProcedure
		
		Procedure LayerList_PrepareItem(*GadgetData.LayerListData, *Item.LayerList_Item)
			; (Re)lay out one row's text block for its current indent level.
			*Item\Text\Width = LayerList_TextWidth(*GadgetData, *Item\Child)
			*Item\Text\Height = *GadgetData\ItemHeight
			PrepareVectorTextBlock(@*Item\Text)
		EndProcedure
		
		;- Drawing
		
		Procedure LayerList_DrawFold(X, Y, Size, Folded)
			; A small triangle: pointing right when the group is folded, down when it's open.
			Protected CX.d = X + Size * 0.5, CY.d = Y + Size * 0.5
			
			If Folded
				MovePathCursor(CX - 2.5, CY - 4)
				AddPathLine(CX + 3.5, CY)
				AddPathLine(CX - 2.5, CY + 4)
			Else
				MovePathCursor(CX - 4, CY - 2.5)
				AddPathLine(CX + 4, CY - 2.5)
				AddPathLine(CX, CY + 3.5)
			EndIf
			
			ClosePath()
			FillPath()
		EndProcedure
		
		Procedure LayerList_DrawEye(X, Y, Width, Height, Visible)
			; An eye outline with a pupil; struck through when the row is switched off.
			Protected CX.d = X + Width * 0.5, CY.d = Y + Height * 0.5
			
			AddPathEllipse(CX, CY, 6.5, 4.2)
			StrokePath(1.2)
			AddPathCircle(CX, CY, 2.1)
			FillPath()
			
			If Not Visible
				MovePathCursor(CX - 7, CY + 5.5)
				AddPathLine(CX + 7, CY - 5.5)
				StrokePath(1.4)
			EndIf
		EndProcedure
		
		Procedure LayerList_ItemRedraw(*Item.LayerList_Item, X, Y, Width, Height, State, *Theme.Theme)
			; Default row content. The gadget has already painted the row shade and set the
			; source colour, and it draws the chevron and the eye itself — a *CustomItem
			; callback only has to fill this content rectangle.
			DrawVectorTextBlock(@*Item\Text, X, Y)
		EndProcedure
		
		Procedure LayerList_Redraw(*GadgetData.LayerListData)
			Protected Y, Row, FirstRow, Rows, Index, ShadeState, TextState, TextX, EyeX, MarkerX, MarkerY
			
			With *GadgetData
				If \Border
					AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
					VectorSourceColor(\ThemeData\LineColor[#Cold])
					StrokePath(2, #PB_Path_Preserve)
				Else
					AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
				EndIf
				
				VectorSourceColor(\ThemeData\ShadeColor[#Cold])
				ClipPath(#PB_Path_Preserve)
				FillPath()
				
				If Not ListSize(\Items())
					ProcedureReturn
				EndIf
				
				Rows = LayerList_RowCount(*GadgetData)
				EyeX = \OriginX + LayerList_EyeX(*GadgetData)
				
				Y = \OriginY + \Border
				If \VisibleScrollBar
					FirstRow = Floor(\ScrollBar\State / \ItemHeight)
					Y - (\ScrollBar\State % \ItemHeight)
				EndIf
				
				Row = FirstRow
				MarkerY = -1
				
				While Y < \OriginY + \Height
					Index = LayerList_RowToIndex(*GadgetData, Row)
					If Index = -1
						Break
					EndIf
					
					If Row = \ReorderRow
						MarkerY = Y
					EndIf
					
					SelectElement(\Items(), Index)
					
					If Index = \State Or \Items()\Selected
						ShadeState = #Hot
					ElseIf Index = \ItemState
						ShadeState = #Warm
					Else
						ShadeState = #Cold
					EndIf
					
					; A row that doesn't show through is drawn in the disabled ink, so a whole
					; switched-off group reads as inactive without losing hover or selection.
					If LayerList_EffectiveVisible(*GadgetData, Index)
						TextState = ShadeState
					Else
						TextState = #Disabled
					EndIf
					
					SelectElement(\Items(), Index)
					
					If ShadeState > #Cold
						AddPathBox(\OriginX + \Border, Y, \Width - \Border * 2, \ItemHeight)
						VectorSourceColor(\ThemeData\ShadeColor[ShadeState])
						FillPath()
					EndIf
					
					; Fold chevron — groups only, and only when they hold something.
					If Not \Items()\Child
						VectorSourceColor(\ThemeData\TextColor[TextState])
						If LayerList_ChildCount(*GadgetData, Index)
							SelectElement(\Items(), Index)
							LayerList_DrawFold(\OriginX + \Border, Y, #LayerList_FoldWidth, \Items()\Folded)
						EndIf
						SelectElement(\Items(), Index)
					EndIf
					
					TextX = \OriginX + LayerList_TextX(*GadgetData, \Items()\Child)
					VectorSourceColor(\ThemeData\TextColor[TextState])
					\ItemRedraw(@\Items(), TextX, Y, \Items()\Text\Width, \ItemHeight, TextState, \ThemeData)
					
					SelectElement(\Items(), Index)
					VectorSourceColor(\ThemeData\TextColor[TextState])
					LayerList_DrawEye(EyeX, Y, #LayerList_EyeWidth, \ItemHeight, \Items()\Visible)
					
					Y + \ItemHeight
					Row + 1
				Wend
				
				If \ReorderRow = Rows And Rows >= Row
					MarkerY = Y			; dropping past the last row
				EndIf
				
				If \ReorderRow > -1 And MarkerY > -1
					; Indent the marker when a child is in flight, so it's clear it lands inside a group.
					MarkerX = \OriginX + \Border + Bool(\DragChild) * #LayerList_FoldWidth * 2
					AddPathBox(MarkerX, MarkerY - #LayerList_MarkerHeight * 0.5, \Width - \Border * 2 - (MarkerX - \OriginX - \Border), #LayerList_MarkerHeight)
					VectorSourceColor(\ThemeData\TextColor[#Hot])
					FillPath()
				EndIf
				
				If \Editing
					SaveVectorState()
					\String\Redraw(\String)
					RestoreVectorState()
				EndIf
				
				If \VisibleScrollBar
					\ScrollBar\Redraw(\ScrollBar)
				EndIf
			EndWith
		EndProcedure
		
		;- Scrolling and reordering
		
		Procedure LayerList_StateFocus(*GadgetData.LayerListData)
			; Scroll the selected row into view.
			Protected Result, Row
			
			With *GadgetData
				If \VisibleScrollBar
					Row = LayerList_IndexToRow(*GadgetData, \State)
					
					If Row > -1
						If Ceil(\ScrollBar\State / \ItemHeight) > Row
							ScrollBar_SetState_Meta(\ScrollBar, Row * \ItemHeight)
							Result = #True
						ElseIf Floor((\ScrollBar\State + \Height - \ItemHeight) / \ItemHeight) < Row
							ScrollBar_SetState_Meta(\ScrollBar, Row * \ItemHeight - \Height + \ItemHeight)
							Result = #True
						EndIf
					EndIf
				EndIf
			EndWith
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure LayerList_DropRow(*GadgetData.LayerListData, MouseY)
			; The row the dragged item would land before, legalised for what's in flight: a group
			; only ever lands between groups, and a child never lands above the first group.
			Protected Row, Rows, R, Best, BestDistance, Distance, Folded
			
			With *GadgetData
				Rows = LayerList_RowCount(*GadgetData)
				Row = Clamp(Floor((MouseY + LayerList_ScrollOffset(*GadgetData) + \ItemHeight * 0.5) / \ItemHeight), 0, Rows)
				
				If \DragChild
					If Row < 1
						Row = 1			; a child always belongs to a group
					EndIf
				Else
					Best = Rows
					BestDistance = Abs(Rows - Row)
					
					ForEach \Items()
						If \Items()\Child
							If Folded
								Continue
							EndIf
						Else
							Folded = \Items()\Folded
							Distance = Abs(R - Row)
							If Distance < BestDistance
								BestDistance = Distance
								Best = R
							EndIf
						EndIf
						R + 1
					Next
					
					Row = Best
				EndIf
			EndWith
			
			ProcedureReturn Row
		EndProcedure
		
		Procedure LayerList_DragSetKind(*GadgetData.LayerListData)
			; What a drag is carrying: 0 = just the row that was grabbed, 1 = every selected row and
			; they're all children, 2 = every selected row and they're all groups.
			;
			; Only those two homogeneous shapes move as a set. A selection mixing groups with loose
			; children has no one sensible landing place - dropping it somewhere would have to invent
			; an answer - so it falls back to dragging the single grabbed row.
			Protected Children, Groups
			
			With *GadgetData
				If Not \MultiSelect Or Not LayerList_IsSelected(*GadgetData, \DragIndex)
					ProcedureReturn 0
				EndIf
				
				ForEach \Items()
					If \Items()\Selected
						If \Items()\Child
							Children + 1
						Else
							Groups + 1
						EndIf
					EndIf
				Next
				
				If Children + Groups < 2
					ProcedureReturn 0
				ElseIf Groups = 0
					ProcedureReturn 1
				ElseIf Children = 0
					ProcedureReturn 2
				EndIf
			EndWith
			
			ProcedureReturn 0
		EndProcedure
		
		Procedure LayerList_ApplyDrop(*GadgetData.LayerListData)
			; Move what's in flight to \ReorderRow. Linked-list element addresses survive MoveElement,
			; so everything travels by re-inserting its elements, in order, before the destination
			; element - which also covers "insert before the next group", the position that means
			; "append to the group above".
			;
			; A homogeneous multi-selection moves as a set: several children collapse into the target
			; group in list order, several groups reorder as a run with their own children in tow.
			Protected *Destination, *Dragged, DestinationIndex, Parent
			Protected NewList Roots.i()
			Protected NewList Block.i()
			
			With *GadgetData
				If \ReorderRow < 0
					ProcedureReturn
				EndIf
				
				DestinationIndex = LayerList_RowToIndex(*GadgetData, \ReorderRow)
				If DestinationIndex > -1 And SelectElement(\Items(), DestinationIndex)
					*Destination = @\Items()
				EndIf
				
				If Not SelectElement(\Items(), \DragIndex)
					ProcedureReturn
				EndIf
				*Dragged = @\Items()
				
				; The rows to move, in list order.
				If LayerList_DragSetKind(*GadgetData)
					ForEach \Items()
						If \Items()\Selected
							AddElement(Roots())
							Roots() = @\Items()
						EndIf
					Next
				Else
					AddElement(Roots())
					Roots() = *Dragged
				EndIf
				
				; Each root, followed by its children when it's a group. A homogeneous set never holds
				; both a group and its own children, so nothing can land in the block twice.
				ForEach Roots()
					ChangeCurrentElement(\Items(), Roots())
					AddElement(Block())
					Block() = @\Items()
					
					If Not \Items()\Child
						While NextElement(\Items()) And \Items()\Child
							AddElement(Block())
							Block() = @\Items()
						Wend
					EndIf
				Next
				
				; Dropping inside the block being carried would be a no-op at best.
				ForEach Block()
					If Block() = *Destination
						ProcedureReturn
					EndIf
				Next
				
				ForEach Block()
					ChangeCurrentElement(\Items(), Block())
					If *Destination
						MoveElement(\Items(), #PB_List_Before, *Destination)
					Else
						MoveElement(\Items(), #PB_List_Last)
					EndIf
				Next
				
				ChangeCurrentElement(\Items(), *Dragged)
				\State = ListIndex(\Items())
				
				; Children dropped into a folded group would vanish - open the group instead.
				If \DragChild
					Parent = LayerList_ParentOf(*GadgetData, \State)
					If Parent > -1 And SelectElement(\Items(), Parent)
						\Items()\Folded = #False
					EndIf
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_ReorderTimer(*GadgetData.LayerListData, Timer)
			; Auto-scroll while the pointer is held past the top or bottom edge.
			Protected Event.Event
			
			With *GadgetData
				Event\EventType = #MouseMove
				Event\MouseX = WindowX(\ReorderWindow) - \DragOriginX
				Event\MouseY = WindowY(\ReorderWindow) - \DragOriginY
				
				If \ReorderDirection = -1
					If \ScrollBar\State > 0
						ScrollBar_SetState_Meta(\ScrollBar, Max(0, \ScrollBar\State - \ItemHeight))
						LayerList_EventHandler(*GadgetData, @Event)
					EndIf
				Else
					If \ScrollBar\State < \ScrollBar\Max - \ScrollBar\PageLength
						ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State + \ItemHeight)
						LayerList_EventHandler(*GadgetData, @Event)
					EndIf
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_DragCanvasHandler()
			; The floating preview swallows the wheel while it's under the pointer; hand it back.
			Protected Gadget = EventGadget(), *GadgetData.LayerListData = GetProp_(GadgetID(Gadget), "UITK_LayerData"), Event.Event
			
			Event\EventType = #MouseWheel
			Event\MouseX = WindowX(*GadgetData\ReorderWindow) - *GadgetData\DragOriginX
			Event\MouseY = WindowY(*GadgetData\ReorderWindow) - *GadgetData\DragOriginY
			Event\Param = GetGadgetAttribute(*GadgetData\ReorderCanvas, #PB_Canvas_WheelDelta)
			
			LayerList_EventHandler(*GadgetData, @Event)
		EndProcedure
		
		Procedure LayerList_StartReorder(*GadgetData.LayerListData, *Event.Event)
			; Fill the floating preview with the grabbed row and show it under the cursor.
			Protected Row
			
			With *GadgetData
				If Not SelectElement(\Items(), \DragIndex)
					ProcedureReturn
				EndIf
				
				\DragChild = \Items()\Child
				\DragState = #Drag_Active
				
				Row = LayerList_IndexToRow(*GadgetData, \DragIndex)
				\DragOriginX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginX
				\DragOriginY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginY + Row * \ItemHeight - LayerList_ScrollOffset(*GadgetData)
				
				StartVectorDrawing(CanvasVectorOutput(\ReorderCanvas))
				AddPathBox(0, 0, \Width, \ItemHeight)
				VectorSourceColor(\ThemeData\ShadeColor[#Hot])
				FillPath()
				
				SelectElement(\Items(), \DragIndex)
				VectorSourceColor(\ThemeData\TextColor[#Hot])
				\ItemRedraw(@\Items(), LayerList_TextX(*GadgetData, \Items()\Child), 0, \Items()\Text\Width, \ItemHeight, #Hot, \ThemeData)
				StopVectorDrawing()
				
				\ReorderRow = LayerList_DropRow(*GadgetData, *Event\MouseY)
				
				ResizeWindow(\ReorderWindow, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, #PB_Ignore, #PB_Ignore)
				HideWindow(\ReorderWindow, #False, #PB_Window_NoActivate)
				SetActiveGadget(\Gadget)
			EndWith
		EndProcedure
		
		;- Inline renaming (#Editable)
		
		Procedure LayerList_BeginEdit(*GadgetData.LayerListData)
			; Drop the editor over the selected row. Refused when there's nothing to edit, or when
			; the row can't be seen - editing a row tucked inside a folded group would put the box
			; nowhere useful.
			Protected Event.Event, Row
			
			With *GadgetData
				If Not \Editable Or \Editing Or \State < 0
					ProcedureReturn #False
				EndIf
				
				Row = LayerList_IndexToRow(*GadgetData, \State)
				If Row < 0 Or Not SelectElement(\Items(), \State)
					ProcedureReturn #False
				EndIf
				
				\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
				\String\String = \Items()\Text\OriginalText
				String_ProcessString(\String)
				
				; Sit exactly where the row's text is drawn: the row's content origin plus the text
				; block's own offset, which already accounts for the item's icon. That offset has to
				; come back off the width too, or the box overshoots to the right by the width of the
				; icon and covers the eye.
				\String\OriginX = LayerList_TextX(*GadgetData, \Items()\Child) + \Items()\Text\TextX
				\String\OriginY = \Border + Row * \ItemHeight - LayerList_ScrollOffset(*GadgetData) + \Items()\Text\TextY - 2
				\String\Width = \Items()\Text\Width - \Items()\Text\TextX
				
				Event\EventType = #Focus
				\String\EventHandler(\String, Event)
				StringSetSelection_Meta(\String, 0, Len(\String\String))
			EndWith
			
			ProcedureReturn #True
		EndProcedure
		
		Procedure LayerList_EndEdit(*GadgetData.LayerListData, Keep)
			; Fold the editor away. Keep writes the typed text back into the row and reports it
			; with #EventType_ItemTextChange; otherwise the row keeps the text it had (Escape, or
			; the row being removed from under the editor).
			Protected Event.Event
			
			With *GadgetData
				If Not \Editing
					ProcedureReturn #False
				EndIf
				
				\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
				
				; \EditCursor means "the pointer is inside the editor", and every
				; click consults it to decide between typing and clicking the row.
				; It must not outlive the editor: left standing it sends the NEXT
				; click into a String that is no longer open, and nothing works
				; again until the pointer happens to cross a row body.
				If \EditCursor
					\EditCursor = #PB_Cursor_Default
					\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, #PB_Cursor_Default)
				EndIf
				
				If Keep And SelectElement(\Items(), \State)
					\Items()\Text\OriginalText = \String\String
					LayerList_PrepareItem(*GadgetData, @\Items())
					PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
				EndIf
				
				Event\EventType = #LostFocus
				\String\EventHandler(\String, Event)
			EndWith
			
			ProcedureReturn #True
		EndProcedure
		
		;- Events
		
		Procedure LayerList_EventHandler(*GadgetData.LayerListData, *Event.Event)
			Protected Redraw, Row, Index, Zone, Rows, Modifiers, Cursor = *GadgetData\EditCursor
			
			With *GadgetData
				Select *Event\EventType
					Case #MouseMove ;{
						If \String And \String\Selecting ;{ dragging out a selection inside the editor
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							Redraw = \String\EventHandler(\String, *Event)
							;}
						ElseIf \DragState = #Drag_Init ;{ waiting to clear the drag threshold
							If Abs(\DragOriginX - *Event\MouseX) > #Drag_Distance Or Abs(\DragOriginY - *Event\MouseY) > #Drag_Distance
								LayerList_StartReorder(*GadgetData, *Event)
								Redraw = #True
							EndIf
							;}
						ElseIf \DragState = #Drag_Active ;{ carrying a row
							SetWindowPos_(WindowID(\ReorderWindow), 0, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, 0, 0, #SWP_NOSIZE | #SWP_NOZORDER | #SWP_NOREDRAW)
							
							If \VisibleScrollBar
								If *Event\MouseY < 0
									If Not \ReorderTimer
										\ReorderTimer = AddGadgetTimer(*GadgetData, #LayerList_ReorderDelay, @LayerList_ReorderTimer())
										\ReorderDirection = -1
									EndIf
									*Event\MouseY = 0
								ElseIf *Event\MouseY > \Height
									If Not \ReorderTimer
										\ReorderTimer = AddGadgetTimer(*GadgetData, #LayerList_ReorderDelay, @LayerList_ReorderTimer())
										\ReorderDirection = 1
									EndIf
									*Event\MouseY = \Height
								ElseIf \ReorderTimer
									RemoveGadgetTimer(\ReorderTimer)
									\ReorderTimer = 0
								EndIf
							EndIf
							
							Row = LayerList_DropRow(*GadgetData, *Event\MouseY)
							If Row <> \ReorderRow
								\ReorderRow = Row
								Redraw = #True
							EndIf
							;}
						Else;{ plain hover
							Cursor = #PB_Cursor_Default
							
							If \VisibleScrollBar And (*Event\MouseX >= \ScrollBar\OriginX Or \ScrollBar\Drag = #True)
								Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
							ElseIf \ScrollBar\MouseState
								\ScrollBar\MouseState = #False
								Redraw = #True
							EndIf
							
							If \ScrollBar\MouseState
								If \ItemState > -1
									\ItemState = -1
									Redraw = #True
								EndIf
							Else
								Index = LayerList_RowToIndex(*GadgetData, Floor((*Event\MouseY + LayerList_ScrollOffset(*GadgetData)) / \ItemHeight))
								
								If Index > -1
									Zone = LayerList_ZoneAt(*GadgetData, Index, *Event\MouseX)
								Else
									Zone = #LayerList_Zone_Body
								EndIf
								
								If Index <> \ItemState Or Zone <> \HoverZone
									\ItemState = Index
									\HoverZone = Zone
									Redraw = #True
								EndIf
								
								; Over the open editor the pointer becomes a caret, which is also how
								; #LeftButtonDown below knows the click belongs to the editor. The
								; RIGHT edge matters as much as the left: the editor deliberately
								; stops short of the eye, so without that bound the eye counted as
								; "inside the editor" - clicking it placed a caret instead of
								; committing the name, and the caret cursor stuck.
								If \Editing And Index = \State
									If *Event\MouseX > \String\OriginX And *Event\MouseX < \String\OriginX + \String\Width And *Event\MouseY > \String\OriginY And *Event\MouseY < \String\OriginY + \String\Height
										Cursor = #PB_Cursor_IBeam
									EndIf
								EndIf
							EndIf
						EndIf ;}
							  ;}
					Case #LeftButtonDown ;{
										 ; A click anywhere but inside the editor commits what was being typed - on a
										 ; row, on the scrollbar, or on empty space below the rows.
						If Not \EditCursor
							Redraw = LayerList_EndEdit(*GadgetData, #True)
						EndIf
						
						If \EditCursor ;{ inside the open editor: the click places the caret
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							Redraw = \String\EventHandler(\String, *Event)
							;}
						ElseIf \ScrollBar\MouseState
							Redraw + ScrollBar_EventHandler(\ScrollBar, *Event)
						ElseIf \ItemState > -1
							Index = \ItemState
							Modifiers = GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers)
							
							; Whatever was clicked, the row it belongs to becomes the focus, so a handler
							; can read GetGadgetState for every one of the events below.
							If Index <> \State
								Redraw = #True
							EndIf
							
							Select \HoverZone
								Case #LayerList_Zone_Fold ;{
									\State = Index
									If SelectElement(\Items(), Index) And Not \Items()\Child
										\Items()\Folded = Bool(Not \Items()\Folded)
										LayerList_UpdateScrollBar(*GadgetData)
										PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerFold)
										Redraw = #True
									EndIf
									;}
								Case #LayerList_Zone_Eye ;{
									\State = Index
									LayerList_ToggleVisibility(*GadgetData, Index)
									PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerVisibility)
									Redraw = #True
									;}
								Default ;{ the row body: pick the selection, then arm a drag
									If LayerList_ClickSelect(*GadgetData, Index, Modifiers)
										Redraw = #True
									EndIf
									
									PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
									
									If \Reorder
										\DragState = #Drag_Init
										\DragIndex = Index
										\DragOriginX = *Event\MouseX
										\DragOriginY = *Event\MouseY
									EndIf
									;}
							EndSelect
						Else
							; A press on empty space below the rows drops the selection.
							If \MultiSelect And LayerList_SelectedCount(*GadgetData)
								LayerList_SelectOnly(*GadgetData, -1)
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
								Redraw = #True
							EndIf
						EndIf
						;}
					Case #LeftButtonUp ;{
						If \ScrollBar\Drag
							Redraw = ScrollBar_EventHandler(\ScrollBar, *Event)
						ElseIf \DragState = #Drag_Active
							LayerList_ApplyDrop(*GadgetData)
							
							HideWindow(\ReorderWindow, #True)
							
							If \ReorderTimer
								RemoveGadgetTimer(\ReorderTimer)
								\ReorderTimer = 0
							EndIf
							
							\ReorderRow = -1
							LayerList_UpdateScrollBar(*GadgetData)
							LayerList_StateFocus(*GadgetData)
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							Redraw = #True
						ElseIf \PendingSelect > -1
							; The press landed on an already-selected row and never became a drag, so
							; it was a plain click after all: collapse onto that row now.
							LayerList_SelectOnly(*GadgetData, \PendingSelect)
							PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
							Redraw = #True
						EndIf
						
						\PendingSelect = -1
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
									 ; Commit first: the editor is placed against a row's screen position, so
									 ; scrolling would leave it stranded away from the row it belongs to.
						Redraw = LayerList_EndEdit(*GadgetData, #True)
						
						If \VisibleScrollBar
							ScrollBar_SetState_Meta(\ScrollBar, \ScrollBar\State - *Event\Param * \ItemHeight * 0.5)
							*Event\EventType = #MouseMove
							Redraw + Bool(Not LayerList_EventHandler(*GadgetData, *Event))
						EndIf
						;}
					Case #LeftDoubleClick ;{
						If \ItemState > -1
							If \HoverZone = #LayerList_Zone_Body
								; The press under this double-click half-armed a reorder
								; drag. The gesture supersedes it — and the app may well
								; answer the posted event by opening the row's inline
								; editor, which a pending drag arm would refuse
								\DragState = #Drag_None
								PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ForcefulChange)
							EndIf
						EndIf
						;}
					Case #KeyDown ;{
						If \Editing ;{ the editor owns the keyboard while it's open
							Select *Event\Param
								Case #PB_Shortcut_Return
									Redraw = LayerList_EndEdit(*GadgetData, #True)
								Case #PB_Shortcut_Escape
									Redraw = LayerList_EndEdit(*GadgetData, #False)		; keep the old name
								Default
									Redraw = \String\EventHandler(\String, *Event)
							EndSelect
							;}
						ElseIf \DragState = #Drag_None
							Row = LayerList_IndexToRow(*GadgetData, \State)
							
							Select *Event\Param
								Case #PB_Shortcut_Down ;{
									Index = LayerList_RowToIndex(*GadgetData, Row + 1)
									If Row > -1 And Index > -1
										LayerList_MoveFocus(*GadgetData, Index)
										LayerList_StateFocus(*GadgetData)
										Redraw = #True
									EndIf
									;}
								Case #PB_Shortcut_Up ;{
									If Row > 0
										LayerList_MoveFocus(*GadgetData, LayerList_RowToIndex(*GadgetData, Row - 1))
										LayerList_StateFocus(*GadgetData)
										Redraw = #True
									EndIf
									;}
								Case #PB_Shortcut_Left ;{ fold the group, or jump to it from a child
									If SelectElement(\Items(), \State)
										If \Items()\Child
											Index = LayerList_ParentOf(*GadgetData, \State)
											If Index > -1
												\State = Index
												Redraw = #True
											EndIf
										ElseIf Not \Items()\Folded
											\Items()\Folded = #True
											LayerList_UpdateScrollBar(*GadgetData)
											PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerFold)
											Redraw = #True
										EndIf
									EndIf
									;}
								Case #PB_Shortcut_Right ;{ open the group
									If SelectElement(\Items(), \State) And Not \Items()\Child And \Items()\Folded
										\Items()\Folded = #False
										LayerList_UpdateScrollBar(*GadgetData)
										PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerFold)
										Redraw = #True
									EndIf
									;}
								Case #PB_Shortcut_Space ;{ toggle the eye - ctrl+space toggles the selection instead
									If \MultiSelect And (GetGadgetAttribute(\Gadget, #PB_Canvas_Modifiers) & #PB_Canvas_Control)
										If SelectElement(\Items(), \State)
											\Items()\Selected = Bool(Not \Items()\Selected)
											\SelectAnchor = \State
											PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
											Redraw = #True
										EndIf
									ElseIf \State > -1
										LayerList_ToggleVisibility(*GadgetData, \State)
										PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_LayerVisibility)
										Redraw = #True
									EndIf
									;}
								Case #PB_Shortcut_F2 ;{ rename the selected row in place
									Redraw = LayerList_BeginEdit(*GadgetData)
									;}
							EndSelect
						EndIf
						;}
					Case #LostFocus ;{ clicking away from the gadget commits the rename
						Redraw = LayerList_EndEdit(*GadgetData, #True)
						;}
					Default ;{ #Input and the rest belong to the editor while it's open
						If \Editing
							Redraw = \String\EventHandler(\String, *Event)
						EndIf
						;}
				EndSelect
				
				If Cursor <> \EditCursor
					\EditCursor = Cursor
					\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, Cursor)
				EndIf
				
				If Redraw
					RedrawObject()
				EndIf
			EndWith
			
			ProcedureReturn Redraw
		EndProcedure
		
		;- Items
		
		Procedure LayerList_AddItem(*this.PB_Gadget, Position, *Text, ImageID, Level.l)
			; Level 0 adds a group, anything above adds a child of the group above it. A child
			; added when there's no group yet becomes a group, so the two-level shape always holds.
			Protected *GadgetData.LayerListData = *this\vt, *NewItem.LayerList_Item, Child
			
			With *GadgetData
				Child = Bool(Level > 0)
				
				If Position > -1 And Position < ListSize(\Items())
					SelectElement(\Items(), Position)
					*NewItem = InsertElement(\Items())
				Else
					LastElement(\Items())
					*NewItem = AddElement(\Items())
				EndIf
				
				If Child And ListIndex(\Items()) = 0
					Child = #False			; nothing above it to belong to
				EndIf
				
				*NewItem\Child = Child
				*NewItem\Visible = #True
				*NewItem\Text\OriginalText = PeekS(*Text)
				*NewItem\Text\Image = ImageID
				*NewItem\Text\LineLimit = 1
				*NewItem\Text\FontID = \TextBlock\FontID
				*NewItem\Text\FontScale = \TextBlock\FontScale
				*NewItem\Text\VAlign = \TextBlock\VAlign
				*NewItem\Text\HAlign = \TextBlock\HAlign
				
				LayerList_PrepareItem(*GadgetData, *NewItem)
				
				ChangeCurrentElement(\Items(), *NewItem)
				Position = ListIndex(\Items())
				
				If Position <= \State
					\State + 1
				EndIf
				
				LayerList_UpdateScrollBar(*GadgetData)
				RedrawObject()
			EndWith
			
			ProcedureReturn Position
		EndProcedure
		
		Procedure LayerList_RemoveItem(*this.PB_Gadget, Position)
			; Removing a group takes its children with it.
			Protected *GadgetData.LayerListData = *this\vt, Count, Loop
			
			With *GadgetData
				; Drop the editor rather than let it commit into whatever lands on this index.
				LayerList_EndEdit(*GadgetData, #False)
				
				If Position > -1 And Position < ListSize(\Items())
					SelectElement(\Items(), Position)
					
					If \Items()\Child
						Count = 1
					Else
						Count = 1 + LayerList_ChildCount(*GadgetData, Position)
					EndIf
					
					For Loop = 1 To Count
						If SelectElement(\Items(), Position)
							DeleteElement(\Items())
						EndIf
					Next
					
					If \State > Position
						\State = Max(-1, \State - Count)
					ElseIf \State >= Position
						\State = -1
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #PB_EventType_Change)
					EndIf
					
					\ItemState = -1
					LayerList_UpdateScrollBar(*GadgetData)
					RedrawObject()
					
					ProcedureReturn #True
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_ClearItems(*this.PB_Gadget)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				LayerList_EndEdit(*GadgetData, #False)
				ClearList(\Items())
				\State = -1
				\ItemState = -1
				\ReorderRow = -1
				LayerList_UpdateScrollBar(*GadgetData)
				RedrawObject()
			EndWith
		EndProcedure
		
		Procedure LayerList_CountItem(*this.PB_Gadget)
			Protected *GadgetData.LayerListData = *this\vt
			ProcedureReturn ListSize(*GadgetData\Items())
		EndProcedure
		
		Procedure LayerList_GetItemState(*this.PB_Gadget, Position)
			; Nonzero when the row is selected - same answer a ListViewGadget gives.
			Protected *GadgetData.LayerListData = *this\vt
			
			ProcedureReturn LayerList_IsSelected(*GadgetData, Position)
		EndProcedure
		
		Procedure LayerList_SetItemState(*this.PB_Gadget, Position, State)
			; Select or deselect one row. Without #MultiSelect, selecting a row moves the selection
			; onto it, since there can only ever be one.
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				If Position < 0 Or Position >= ListSize(\Items())
					ProcedureReturn
				EndIf
				
				If Not \MultiSelect
					If State
						LayerList_SelectOnly(*GadgetData, Position)
					Else
						LayerList_SelectOnly(*GadgetData, -1)
					EndIf
				ElseIf SelectElement(\Items(), Position)
					\Items()\Selected = Bool(State)
					If State
						\State = Position
						\SelectAnchor = Position
					EndIf
				EndIf
				
				RedrawObject()
			EndWith
		EndProcedure
		
		Procedure LayerList_SetState(*this.PB_Gadget, State)
			; -1 clears the selection, anything else selects that row alone - as SetGadgetState does
			; on a ListViewGadget. Going through here keeps the per-item flags and \State in step.
			Protected *GadgetData.LayerListData = *this\vt
			
			If State < 0 Or State >= ListSize(*GadgetData\Items())
				State = -1
			EndIf
			
			LayerList_SelectOnly(*GadgetData, State)
			RedrawObject()
		EndProcedure
		
		Procedure LayerList_GetItemAttribute(*this.PB_Gadget, Position, Attribute)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				If Position > -1 And Position < ListSize(\Items())
					Select Attribute
						Case #Attribute_LayerList_Visible
							If SelectElement(\Items(), Position)
								ProcedureReturn \Items()\Visible
							EndIf
						Case #Attribute_LayerList_EffectiveVisible
							ProcedureReturn LayerList_EffectiveVisible(*GadgetData, Position)
						Case #Attribute_LayerList_Folded
							If SelectElement(\Items(), Position)
								ProcedureReturn \Items()\Folded
							EndIf
						Case #Attribute_LayerList_IsChild
							If SelectElement(\Items(), Position)
								ProcedureReturn \Items()\Child
							EndIf
						Case #Attribute_LayerList_Parent
							ProcedureReturn LayerList_ParentOf(*GadgetData, Position)
						Case #Attribute_LayerList_ChildCount
							ProcedureReturn LayerList_ChildCount(*GadgetData, Position)
					EndSelect
				EndIf
			EndWith
			
			ProcedureReturn -1
		EndProcedure
		
		Procedure LayerList_SetItemAttribute(*this.PB_Gadget, Position, Attribute, Value)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				If Position > -1 And SelectElement(\Items(), Position)
					Select Attribute
						Case #Attribute_LayerList_Visible
							\Items()\Visible = Bool(Value)
							RedrawObject()
						Case #Attribute_LayerList_Folded
							If Not \Items()\Child
								\Items()\Folded = Bool(Value)
								LayerList_UpdateScrollBar(*GadgetData)
								RedrawObject()
							EndIf
					EndSelect
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_GetItemData(*this.PB_Gadget, Position)
			Protected *GadgetData.LayerListData = *this\vt, *Result
			
			If Position > -1 And SelectElement(*GadgetData\Items(), Position)
				*Result = *GadgetData\Items()\Data
			EndIf
			
			ProcedureReturn *Result
		EndProcedure
		
		Procedure LayerList_SetItemData(*this.PB_Gadget, Position, *Data)
			Protected *GadgetData.LayerListData = *this\vt
			
			If Position > -1 And SelectElement(*GadgetData\Items(), Position)
				*GadgetData\Items()\Data = *Data
			EndIf
		EndProcedure
		
		Procedure.s LayerList_GetItemText(*this.PB_Gadget, Position)
			Protected *GadgetData.LayerListData = *this\vt, Result.s
			
			If Position > -1 And SelectElement(*GadgetData\Items(), Position)
				Result = *GadgetData\Items()\Text\OriginalText
			EndIf
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure LayerList_SetItemText(*this.PB_Gadget, Position, *Text)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				If Position > -1 And SelectElement(\Items(), Position)
					\Items()\Text\OriginalText = PeekS(*Text)
					LayerList_PrepareItem(*GadgetData, @\Items())
					RedrawObject()
					ProcedureReturn #True
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_GetItemImage(*this.PB_Gadget, Position)
			Protected *GadgetData.LayerListData = *this\vt
			
			If Position > -1 And SelectElement(*GadgetData\Items(), Position)
				ProcedureReturn *GadgetData\Items()\Text\Image
			EndIf
		EndProcedure
		
		Procedure LayerList_SetItemImage(*this.PB_Gadget, Position, ImageID)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				If Position > -1 And SelectElement(\Items(), Position)
					\Items()\Text\Image = ImageID
					LayerList_PrepareItem(*GadgetData, @\Items())
					RedrawObject()
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList_SetAttribute(*this.PB_Gadget, Attribute, Value)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				Select Attribute
					Case #Attribute_ItemHeight ;{
						\ItemHeight = Value
						ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_ScrollStep, \ItemHeight)
						
						ForEach \Items()
							LayerList_PrepareItem(*GadgetData, @\Items())
						Next
						
						If \Reorder
							SetWindowPos_(WindowID(\ReorderWindow), 0, 0, 0, \Width, \ItemHeight, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
							ResizeGadget(\ReorderCanvas, 0, 0, \Width, \ItemHeight)
						EndIf
						
						LayerList_UpdateScrollBar(*GadgetData)
						;}
					Default ;{
						Default_SetAttribute(IsGadget(\Gadget), Attribute, Value)
						ProcedureReturn	; already redraws
										;}
				EndSelect
			EndWith
			
			RedrawObject()
		EndProcedure
		
		Procedure LayerList_SetFont(*this.PB_Gadget, FontID)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				\TextBlock\FontID = FontID
				
				ForEach \Items()
					\Items()\Text\FontID = FontID
					LayerList_PrepareItem(*GadgetData, @\Items())
				Next
				
				RedrawObject()
			EndWith
		EndProcedure
		
		Procedure LayerList_Resize(*this.PB_Gadget, x, y, Width, Height)
			Protected *GadgetData.LayerListData = *this\vt
			
			; The editor is placed against the current geometry, so settle it before moving things.
			LayerList_EndEdit(*GadgetData, #True)
			
			*this\VT = *GadgetData\OriginalVT
			ResizeGadget(*GadgetData\Gadget, x, y, Width, Height)
			*this\VT = *GadgetData
			
			With *GadgetData
				\Width = GadgetWidth(\Gadget)
				\Height = GadgetHeight(\Gadget)
				
				ForEach \Items()
					LayerList_PrepareItem(*GadgetData, @\Items())
				Next
				
				ScrollBar_ResizeMeta(\ScrollBar, \Width - #LayerList_ToolbarThickness - \Border - 1, \Border + 1, #LayerList_ToolbarThickness, \Height - \Border * 2 - 2)
				ScrollBar_SetAttribute_Meta(\ScrollBar, #ScrollBar_PageLength, \Height)
				
				If \Reorder
					SetWindowPos_(WindowID(\ReorderWindow), 0, 0, 0, \Width, \ItemHeight, #SWP_NOMOVE | #SWP_NOZORDER | #SWP_NOREDRAW)
					ResizeGadget(\ReorderCanvas, 0, 0, \Width, \ItemHeight)
				EndIf
				
				LayerList_UpdateScrollBar(*GadgetData)
			EndWith
			
			RedrawObject()
		EndProcedure
		
		Procedure LayerList_FreeGadget(*this.PB_Gadget)
			Protected *GadgetData.LayerListData = *this\vt
			
			With *GadgetData
				If \ReorderTimer
					RemoveGadgetTimer(\ReorderTimer)
					\ReorderTimer = 0
				EndIf
				
				If \Reorder And IsWindow(\ReorderWindow)
					CloseWindow(\ReorderWindow)
				EndIf
				
				DeleteMapElement(GadgetHandler(), Str(GadgetID(\Gadget)))
				FreeStructureX(\ScrollBar)
				
				If \String
					RemoveGadgetTimers(\String)
					FreeMemory(\String\ThemeData)		; the editor's own copy of the theme
					FreeStructureX(\String)
				EndIf
			EndWith
			
			Default_FreeGadget(*this)
		EndProcedure
		
		Procedure LayerList_Meta(*GadgetData.LayerListData, *ThemeData.Theme, Gadget, x, y, Width, Height, Flags, *CustomItem)
			Protected GadgetList
			*GadgetData\ThemeData = *ThemeData
			InitializeObject(LayerList)
			
			With *GadgetData
				If Not (Flags & (#VAlignTop | #VAlignBottom))
					\TextBlock\VAlign = #VAlignCenter
				EndIf
				
				If *CustomItem
					\ItemRedraw = *CustomItem
				Else
					\ItemRedraw = @LayerList_ItemRedraw()
				EndIf
				
				\MultiSelect = Bool(Flags & #MultiSelect)
				\SelectAnchor = -1
				\PendingSelect = -1
				\ItemHeight = #LayerList_ItemHeight
				\State = -1
				\ItemState = -1
				\ReorderRow = -1
				\DragIndex = -1
				
				AllocateStructureX(\ScrollBar, ScrollBarData)
				ScrollBar_Meta(\ScrollBar, *ThemeData, -1, Width - #LayerList_ToolbarThickness - \Border - 1, \Border + 1, #LayerList_ToolbarThickness, Height - \Border * 2 - 2, 0, \ItemHeight, Height, #Gadget_Vertical)
				
				If Flags & #ReOrder
					GadgetList = UseGadgetList(0)
					\Reorder = #True
					\ReorderWindow = OpenWindow(#PB_Any, 0, 0, Width, \ItemHeight, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(CurrentWindow()))
					\ReorderCanvas = CanvasGadget(#PB_Any, 0, 0, Width, \ItemHeight)
					SetProp_(GadgetID(\ReorderCanvas), "UITK_LayerData", *GadgetData)
					BindGadgetEvent(\ReorderCanvas, @LayerList_DragCanvasHandler(), #PB_EventType_MouseWheel)
					SetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED)
					SetLayeredWindowAttributes_(WindowID(\ReorderWindow), 0, 128, #LWA_ALPHA)
					UseGadgetList(GadgetList)
				EndIf
				
				\VT\AddGadgetItem3 = @LayerList_AddItem()
				\VT\RemoveGadgetItem = @LayerList_RemoveItem()
				\VT\ClearGadgetItemList = @LayerList_ClearItems()
				\VT\CountGadgetItems = @LayerList_CountItem()
				\VT\GetGadgetItemState = @LayerList_GetItemState()
				\VT\SetGadgetItemState = @LayerList_SetItemState()
				\VT\SetGadgetState = @LayerList_SetState()
				\VT\GetGadgetItemAttribute2 = @LayerList_GetItemAttribute()
				\VT\SetGadgetItemAttribute2 = @LayerList_SetItemAttribute()
				\VT\GetGadgetItemData = @LayerList_GetItemData()
				\VT\SetGadgetItemData = @LayerList_SetItemData()
				\VT\GetGadgetItemText = @LayerList_GetItemText()
				\VT\SetGadgetItemText = @LayerList_SetItemText()
				\VT\GetGadgetItemImage = @LayerList_GetItemImage()
				\VT\SetGadgetItemImage = @LayerList_SetItemImage()
				\VT\SetGadgetAttribute = @LayerList_SetAttribute()
				\VT\SetGadgetFont = @LayerList_SetFont()
				\VT\ResizeGadget = @LayerList_Resize()
				\VT\FreeGadget = @LayerList_FreeGadget()
				
				; Enable only the needed events
				\SupportedEvent[#MouseMove] = #True
				\SupportedEvent[#MouseLeave] = #True
				\SupportedEvent[#MouseWheel] = #True
				\SupportedEvent[#LeftButtonDown] = #True
				\SupportedEvent[#LeftButtonUp] = #True
				\SupportedEvent[#LeftDoubleClick] = #True
				\SupportedEvent[#KeyDown] = #True
				
				; #Editable adds an inline editor: a String meta gadget parked over the row being
				; renamed. It needs the extra keyboard/focus events, hence String_SupportedEvents.
				Protected *StringThemeData.Theme
				\Editable = Bool(Flags & #Editable)
				\EditCursor = #PB_Cursor_Default
				
				If \Editable
					*StringThemeData = AllocateMemory(SizeOf(Theme))
					CopyMemory(*ThemeData, *StringThemeData, SizeOf(Theme))
					*StringThemeData\CornerRadius = 0
					*StringThemeData\ShadeColor[#Cold] = *ThemeData\ShadeColor[#Hot]
					AllocateStructureX(\String, StringData)
					String_Meta(\String, *StringThemeData, Gadget, 0, 0, \Width, \ItemHeight - 2, "", #HAlignLeft | #Gadget_Meta)
					String_SupportedEvents()
					CloseGadgetList()
				EndIf
			EndWith
		EndProcedure
		
		Procedure LayerList(Gadget, x, y, Width, Height, Flags = #Default, *CustomItem = #False)
			Protected Result, *this.PB_Gadget, *GadgetData.LayerListData, *ThemeData
			
			; #PB_Canvas_Container is what lets the inline rename editor live inside the canvas.
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | (Bool(Flags & #Editable) * #PB_Canvas_Container))
			
			If Result
				CreateGadgetObject(LayerListData)
				LayerList_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags, *CustomItem)
				
				RedrawObject()
			EndIf
			
			ProcedureReturn Result
		EndProcedure
	CompilerEndIf
	;}
	
	
	;{ TimeLine
	; This is a big chunk of code, and it's totally useless for anything but a sequence editor, it's disabled by default to avoid your programme getting chonkier for nothing. Declare EnableTimeline module before including the source to enable it.
	
	CompilerIf Defined(EnableTimeline, #PB_Module)
		#TimeLine_List_Width = 222
		#TimeLine_List_TextMargin = 10
		#TimeLine_Header_Height = 60
		#TimeLine_List_LineHeight = 58
		#TimeLine_Body_BlockHeight = 44
		#TimeLine_TrackBarThickness = 7
		#TimeLine_Focus_Timer = 400
		
		#Color_Resources_Media = $4ABF10
		#Color_Resources_Audio = $FF0F84
		#Color_Resources_3D = $8E0FEF
		#Color_Resources_Overlay = $FFAC65
		#Color_Resources_Modifiers = $0FCAEF
		
		#Color_MediaBlock_Back = $4F576B
		#Color_MediaBlock_BackAlternate = $4F576B
		#Color_MediaBlock_Border = $202020
		#Color_MediaBlock_Text = $C4D8FF
		
		Structure TimeLine_Theme
			Back.l[4]
			BackAlt.l[4]
			Text.l[4]
			Border.l
		EndStructure
		
		Global TimeLine_Theme.TimeLine_Theme
		TimeLine_Theme\Back[#Cold] = SetAlpha(FixColor($3B445B), 255)
		TimeLine_Theme\Back[#Warm] = SetAlpha(FixColor($454E63), 255)
		TimeLine_Theme\Back[#Hot] = SetAlpha(FixColor($4F576B), 255)
		
		TimeLine_Theme\BackAlt[#Cold] = SetAlpha(FixColor($2F3648), 255)
		TimeLine_Theme\BackAlt[#Warm] = SetAlpha(FixColor($373E4E), 255)
		TimeLine_Theme\BackAlt[#Hot] = SetAlpha(FixColor($3F4555), 255)
		
		TimeLine_Theme\Text[#Cold] = SetAlpha(FixColor($91A0BC), 255)
		TimeLine_Theme\Text[#Warm] = SetAlpha(FixColor($91A0BC), 255)
		TimeLine_Theme\Text[#Hot] = SetAlpha(FixColor($C4D8FF), 255)
		
		TimeLine_Theme\Border = SetAlpha(FixColor($202020), 255)
		
		Enumeration ;Assets
			#TimeLine_AssetType_Image
			#TimeLine_AssetType_Video
			#TimeLine_AssetType_Music
			#TimeLine_AssetType_Voice
			#TimeLine_AssetType_SFX
			#TimeLine_AssetType_3D
			#TimeLine_AssetType_3DAnimated
			#TimeLine_AssetType_Particles
			#TimeLine_AssetType_Overlay
			#TimeLine_AssetType_Shape
			#TimeLine_AssetType_Transition
			#TimeLine_AssetType_PostProcessing
			#TimeLine_AssetType_Effects			
			
			#__TimeLine_Asset_Count
		EndEnumeration
		
		Enumeration ;MediaType
			#TimeLine_MediaType_Media
			#TimeLine_MediaType_Audio
			#TimeLine_MediaType_3D
			#TimeLine_MediaType_Overlay
			#TimeLine_MediaType_Modifiers
		EndEnumeration
		
		Structure TimeLine_Asset
			MediaType.w
			Color.l
			Icon.s
		EndStructure
		
		Global Dim TimeLine_Asset.TimeLine_Asset(#__TimeLine_Asset_Count) ;{
		TimeLine_Asset(#TimeLine_AssetType_Image)\MediaType = #TimeLine_MediaType_Media
		TimeLine_Asset(#TimeLine_AssetType_Image)\Color = SetAlpha(FixColor($39DA8A), 255)
		TimeLine_Asset(#TimeLine_AssetType_Image)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Video)\MediaType = #TimeLine_MediaType_Media
		TimeLine_Asset(#TimeLine_AssetType_Video)\Color = SetAlpha(FixColor($39DA8A), 255)
		TimeLine_Asset(#TimeLine_AssetType_Video)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Music)\MediaType = #TimeLine_MediaType_Audio
		TimeLine_Asset(#TimeLine_AssetType_Music)\Color = SetAlpha(FixColor($FF0F84), 255)
		TimeLine_Asset(#TimeLine_AssetType_Music)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Voice)\MediaType = #TimeLine_MediaType_Audio
		TimeLine_Asset(#TimeLine_AssetType_Voice)\Color = SetAlpha(FixColor($FF0F84), 255)
		TimeLine_Asset(#TimeLine_AssetType_Voice)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_SFX)\MediaType = #TimeLine_MediaType_Audio
		TimeLine_Asset(#TimeLine_AssetType_SFX)\Color = SetAlpha(FixColor($FF0F84), 255)
		TimeLine_Asset(#TimeLine_AssetType_SFX)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_3D)\MediaType = #TimeLine_MediaType_3D
		TimeLine_Asset(#TimeLine_AssetType_3D)\Color = SetAlpha(FixColor($8E0FEF), 255)
		TimeLine_Asset(#TimeLine_AssetType_3D)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_3DAnimated)\MediaType = #TimeLine_MediaType_3D
		TimeLine_Asset(#TimeLine_AssetType_3DAnimated)\Color = SetAlpha(FixColor($8E0FEF), 255)
		TimeLine_Asset(#TimeLine_AssetType_3DAnimated)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Particles)\MediaType = #TimeLine_MediaType_3D
		TimeLine_Asset(#TimeLine_AssetType_Particles)\Color = SetAlpha(FixColor($8E0FEF), 255)
		TimeLine_Asset(#TimeLine_AssetType_Particles)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Overlay)\MediaType = #TimeLine_MediaType_Overlay
		TimeLine_Asset(#TimeLine_AssetType_Overlay)\Color = SetAlpha(FixColor($FFAC65), 255)
		TimeLine_Asset(#TimeLine_AssetType_Overlay)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Shape)\MediaType = #TimeLine_MediaType_Overlay
		TimeLine_Asset(#TimeLine_AssetType_Shape)\Color = SetAlpha(FixColor($FFAC65), 255)
		TimeLine_Asset(#TimeLine_AssetType_Shape)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Transition)\MediaType = #TimeLine_MediaType_Modifiers
		TimeLine_Asset(#TimeLine_AssetType_Transition)\Color = SetAlpha(FixColor($0FCAEF), 255)
		TimeLine_Asset(#TimeLine_AssetType_Transition)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_PostProcessing)\MediaType = #TimeLine_MediaType_Modifiers
		TimeLine_Asset(#TimeLine_AssetType_PostProcessing)\Color = SetAlpha(FixColor($0FCAEF), 255)
		TimeLine_Asset(#TimeLine_AssetType_PostProcessing)\Icon = ""
		
		TimeLine_Asset(#TimeLine_AssetType_Effects)\MediaType = #TimeLine_MediaType_Modifiers
		TimeLine_Asset(#TimeLine_AssetType_Effects)\Color = SetAlpha(FixColor($0FCAEF), 255)
		TimeLine_Asset(#TimeLine_AssetType_Effects)\Icon = ""
		;}
		
		Global TimeLine_ListFont = FontID(LoadFont(#PB_Any, "Segoe UI Semibold", 12, #PB_Font_HighQuality))
		Global TimeLine_Font = FontID(LoadFont(#PB_Any, "Rubik", 12, #PB_Font_HighQuality))
		Global TimeLine_FontIcon = FontID(LoadFont(#PB_Any, "Font Awesome 5 Pro Regular", 24, #PB_Font_HighQuality))
		
		Structure TimeLine_Block
			AssetType.w
			Text.s
			UUID.s
			Postion.i
			Duration.i
			MaximumDuration.i
			*ParentLine.TimeLine_Line
			*ParentElement
		EndStructure
		
		Structure TimeLine_Line
			Text.Text
			Height.l
			UnfoldedHeight.l
			Y.l
			*FirstDisplayedBlock
			List *MediaBlocks.TimeLine_Block()
		EndStructure
		
		Structure TimeLineData Extends GadgetData
			BodyHeight.l
			BodyWidth.l
			
			RedrawList.b
			RedrawBody.b
			RedrawHeader.b
			RedrawAll.b
			
			InternalHeight.l
			
			DragState.i
			DragOriginX.i
			DragOriginY.i
			ReorderWindow.i
			ReorderCanvas.i
			ReorderPosition.i
			ReorderFocusTimer.i
			ReorderDirection.i
			
			Editing.i
			EditCursor.i
			
			*FirstDisplayedLine
			
			Duration.i
			Scale.q
			
			HoverItem.l			; hovered line index, -1 when none (the base \MouseState stays a #Cold/#Warm/#Hot state)
			
			List Lines.TimeLine_Line()
			Map Blocks.TimeLine_Block()
			
			VisibleVerticalScrollBar.b
			*VScrollBar.ScrollBarData
			
			VisibleHorizontalScrollBar.b
			*HScrollBar.ScrollBarData
			
			*String.StringData
			
		EndStructure
		
		Procedure.s UUID()
			Protected Index, Byte.a, UUID_String.s
			For Index = 0 To 15
				
				If Index = 7 
					Byte = 64 + Random(15)
				ElseIf Index = 9
					Byte = 128 + Random(63)
				Else
					Byte = Random(255)
				EndIf
				
				If Index = 4 Or Index = 6 Or Index = 8 Or Index = 10
					UUID_String + "-"
				EndIf
				
				UUID_String + RSet(Hex(Byte, #PB_Ascii), 2, "0")
			Next
			
			ProcedureReturn UUID_String
		EndProcedure
		
		Procedure TimeLine_Redraw_ListItem(*GadgetData.TimeLineData, X, Y, State)
			With *GadgetData
				If State = #Cold
					VectorSourceColor(SetAlpha(\ThemeData\TextColor[State], 200))
					DrawVectorTextBlock(@\Lines()\Text, X + #TimeLine_List_TextMargin, Y)
				Else
					AddPathBox(X, Y, #TimeLine_List_Width - 0.5, \Lines()\Height)
					VectorSourceColor(\ThemeData\ShadeColor[State])
					FillPath()
					VectorSourceColor(\ThemeData\TextColor[State])
					DrawVectorTextBlock(@\Lines()\Text, X + #TimeLine_List_TextMargin, Y)
					VectorSourceColor(\ThemeData\TextColor[#Cold])
				EndIf
			EndWith
		EndProcedure
		
		Procedure TimeLine_Redraw_Block(*GadgetData.TimeLineData, X, Y, State)
			With *GadgetData
				Protected Duration = Max(\Lines()\MediaBlocks()\Duration * \Scale, 1)
				
				If Duration <= 5
					
					
					
				Else
					Y + 7
					BeginVectorLayer()
					AddPathRoundedBox(X, Y, Duration, #TimeLine_Body_BlockHeight, 10, #Corner_BottomRight)
					VectorSourceColor(TimeLine_Theme\Border)
					StrokePath(1.7, #PB_Path_Preserve)
					VectorSourceColor(TimeLine_Theme\Back[State])
					FillPath(#PB_Path_Preserve)
					ClipPath()
					
					AddPathBox(X, Y, Duration, 4)
					VectorSourceColor(TimeLine_Asset(\Lines()\MediaBlocks()\AssetType)\Color)
					FillPath()
					
					If Duration > 37
						VectorSourceColor(TimeLine_Theme\Text[State])
						VectorFont(TimeLine_FontIcon)
						MovePathCursor(X + 5, Y + 8)
						DrawVectorText(TimeLine_Asset(\Lines()\MediaBlocks()\AssetType)\Icon)
						VectorFont(TimeLine_Font)
						MovePathCursor(X + 40, Y + 8)
						DrawVectorParagraph(\Lines()\MediaBlocks()\Text, Duration, 20)
					EndIf
					
					EndVectorLayer()
				EndIf
			EndWith
		EndProcedure
		
		Procedure TimeLine_Redraw_Body(*GadgetData.TimeLineData, X, Y, State, Alt)
			With *GadgetData
				
				AddPathBox(X, Y, \BodyWidth, \Lines()\Height)
				
				If State = #Cold
					If Alt
						VectorSourceColor(SetAlpha(\ThemeData\WindowColor, 150))
						FillPath(#PB_Path_Preserve)
					EndIf
				Else
					VectorSourceColor(\ThemeData\ShadeColor[State])
					FillPath(#PB_Path_Preserve)
				EndIf
				
				ClipPath()
				
				
				
				If \Lines()\FirstDisplayedBlock
					ChangeCurrentElement(\Lines()\MediaBlocks(), \Lines()\FirstDisplayedBlock)
					Repeat
						TimeLine_Redraw_Block(*GadgetData, #TimeLine_List_Width + 50, Y, 0)
					Until X > \Width Or Not NextElement(\Lines()\MediaBlocks())
				EndIf
				
			EndWith
		EndProcedure
		
		Procedure TimeLine_Redraw(*GadgetData.TimeLineData)
			Protected State, Y, X, Alt, ReorderPosition
			
			With *GadgetData
				If \Border
					AddPathRoundedBox(\OriginX + 1, \OriginY + 1, \Width - 2, \Height - 2, \ThemeData\CornerRadius, \CornerType)
					VectorSourceColor(*GadgetData\ThemeData\LineColor[#Cold])
					StrokePath(2, #PB_Path_Preserve)
				Else
					AddPathRoundedBox(\OriginX, \OriginY, \Width, \Height, \ThemeData\CornerRadius, \CornerType)
				EndIf
				
				VectorSourceColor(\ThemeData\ShadeColor[#Cold])
				
				If \RedrawAll
					\RedrawAll = #False
					\RedrawList = #True
					\RedrawHeader = #True
					\RedrawBody = #True
					FillPath(#PB_Path_Preserve)
				EndIf
				
				ClipPath()
				
				SaveVectorState()
				
				If \RedrawList ;{
					AddPathBox(\OriginX, \OriginY + #TimeLine_Header_Height, #TimeLine_List_Width, \BodyHeight)
					ClipPath(#PB_Path_Preserve)
					FillPath()
					
					MovePathCursor(\OriginX + #TimeLine_List_Width, 0)
					AddPathLine(0, \Height, #PB_Path_Relative)
					VectorSourceColor(\ThemeData\WindowColor)
					StrokePath(2)
					
					If \FirstDisplayedLine
						ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
						Y = \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
						If \DragState = #Drag_Active And \State < ListIndex(\Lines())
							Y - #TimeLine_List_LineHeight
							Alt = Bool(Not Alt)
						EndIf
						
						Repeat
							If Not ListIndex(\Lines()) = \State
								TimeLine_Redraw_ListItem(*GadgetData, \OriginX, Y, Bool(ListIndex(\Lines()) = \HoverItem) * #Warm)
							ElseIf Not \DragState = #Drag_Active
								TimeLine_Redraw_ListItem(*GadgetData, \OriginX, Y, #Hot)
							Else
								Continue
							EndIf
							
							Y + \Lines()\Height
						Until Y > \Height Or (Not NextElement(\Lines()))
					EndIf
					
					If \DragState = #Drag_Active
						MovePathCursor(\OriginX, \OriginY + (\ReorderPosition * #TimeLine_List_LineHeight - \VScrollBar\State + #TimeLine_Header_Height))
						AddPathLine(#TimeLine_List_Width, 0, #PB_Path_Relative)
						VectorSourceColor(\ThemeData\TextColor[#Hot])
						StrokePath(3)
					ElseIf \Editing
						\String\Redraw(\String)
					EndIf
					
					RestoreVectorState()
					SaveVectorState()
					\RedrawList = #False
				EndIf ;}
				
				If \RedrawHeader ;{
					AddPathBox(\OriginX + #TimeLine_List_Width, \OriginY, \BodyWidth, #TimeLine_Header_Height)
					ClipPath(#PB_Path_Preserve)
					FillPath()
					
					MovePathCursor(0, #TimeLine_Header_Height)
					AddPathLine(\Width, 0, #PB_Path_Relative)
					
					VectorSourceColor(\ThemeData\WindowColor)
					StrokePath(2)
					RestoreVectorState()
					SaveVectorState()
					\RedrawHeader = #False
				EndIf ;}
				
				If \RedrawBody ;{
					AddPathBox(\OriginX + #TimeLine_List_Width, \OriginY + #TimeLine_Header_Height, \BodyWidth, \BodyHeight)
					ClipPath(#PB_Path_Preserve)
					FillPath()
					
					If \FirstDisplayedLine
						ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
						Y = \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
						X = \OriginX + #TimeLine_List_Width
						Alt = ListIndex(\Lines()) % 2
						
						If \DragState = #Drag_Active And \State < ListIndex(\Lines())
							Alt = Bool(Not Alt)
						EndIf
						
						Repeat
							If Not ListIndex(\Lines()) = \State
								TimeLine_Redraw_Body(*GadgetData, X, Y, Bool(ListIndex(\Lines()) = \HoverItem) * #Warm, Alt)
							ElseIf Not \DragState = #Drag_Active
								TimeLine_Redraw_Body(*GadgetData, X, Y, #Hot, Alt)
							Else
								Continue
							EndIf
							
							RestoreVectorState()
							SaveVectorState()
							
							Y + \Lines()\Height
							Alt = Bool(Not Alt)
						Until Y > \Height Or (Not NextElement(\Lines()))
					EndIf
					
					RestoreVectorState()
					SaveVectorState()
					\RedrawBody = #False
					
					If \VisibleVerticalScrollBar
						\VScrollBar\Redraw(\VScrollBar)
					EndIf
				EndIf ;}
				
			EndWith
		EndProcedure
		
		Procedure TimeLine_VerticalFocus(*GadgetData.TimeLineData)
			Protected Result
			With *GadgetData
				If \VisibleVerticalScrollBar
					SelectElement(\Lines(), \State)
					If \Lines()\Y < \VScrollBar\State
						ScrollBar_SetState_Meta(\VScrollBar, \Lines()\Y)
						Result = #True
					ElseIf \Lines()\Y + \Lines()\Height > \VScrollBar\State + \BodyHeight
						ScrollBar_SetState_Meta(\VScrollBar, \Lines()\Y + \Lines()\Height - \BodyHeight)
						Result = #True
					EndIf
					
					ForEach \Lines()
						If \Lines()\Y + \Lines()\Height >= \VScrollBar\State
							If \FirstDisplayedLine <> @\Lines()
								\FirstDisplayedLine = @\Lines()
								Result = #True
							EndIf
							Break
						EndIf
					Next
					
				ElseIf ListSize(\Lines())
					FirstElement(\Lines())
					If \FirstDisplayedLine <> @\Lines()
						\FirstDisplayedLine = @\Lines()
						Result = #True
					EndIf
				Else
					If \FirstDisplayedLine
						\FirstDisplayedLine = 0
						Result = #True
					EndIf
				EndIf
			EndWith
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure TimeLine_FocusTimer(*GadgetData.TimeLineData, Timer)
			If TimeLine_VerticalFocus(*GadgetData)
				*GadgetData\RedrawBody = #True
				*GadgetData\RedrawList = #True
				StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
				TimeLine_Redraw(*GadgetData)
				StopVectorDrawing()
			EndIf
			RemoveGadgetTimer(Timer)
		EndProcedure
		
		Procedure TimeLine_ReorderFocusTimer(*GadgetData.TimeLineData, Timer)
			With *GadgetData
				ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
				If \ReorderDirection
					If \ReorderPosition < ListSize(\Lines()) - 1
						NextElement(\Lines())
						If ListIndex(\Lines()) = \State
							NextElement(\Lines())
							\ReorderPosition + 1
							ScrollBar_SetState_Meta(\VScrollBar, \VScrollBar\State + #TimeLine_List_LineHeight * 2)
						Else
							ScrollBar_SetState_Meta(\VScrollBar, \VScrollBar\State + #TimeLine_List_LineHeight)
						EndIf
						\FirstDisplayedLine = @\Lines()
						\RedrawBody = #True
						\RedrawList = #True
						\ReorderPosition + 1
					EndIf
				Else
					If ListIndex(\Lines())
						PreviousElement(\Lines())
						If ListIndex(\Lines()) = \State
							PreviousElement(\Lines())
							\ReorderPosition - 1
						EndIf
						\FirstDisplayedLine = @\Lines()
						ScrollBar_SetState_Meta(\VScrollBar, \Lines()\Y)
						\RedrawBody = #True
						\RedrawList = #True
						\ReorderPosition - 1
					EndIf
				EndIf
				
				If \RedrawAll + \RedrawBody + \RedrawHeader + \RedrawList
					StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
					TimeLine_Redraw(*GadgetData)
					StopVectorDrawing()
				EndIf
			EndWith
		EndProcedure
		
		; Open the inline rename editor over the selected line (F2 / EditGadgetItemText).
		Procedure TimeLine_BeginEdit(*GadgetData.TimeLineData)
			Protected Event.Event
			
			With *GadgetData
				If \Editing Or \State < 0 Or Not SelectElement(\Lines(), \State)
					ProcedureReturn #False
				EndIf
				
				\RedrawBody = TimeLine_VerticalFocus(*GadgetData)
				\RedrawList = #True
				\Editing = #True : SetProp_(GadgetID(\Gadget), "UITK_KeepKeys", 1)
				SelectElement(\Lines(), \State)		; VerticalFocus walks the list, re-select
				\String\String = \Lines()\Text\OriginalText
				String_ProcessString(\String)
				
				\String\OriginX = \Lines()\Text\TextX + #TimeLine_List_TextMargin + \Border
				; Same as the VerticalList: TextX is in the origin, so take it off the width.
				\String\Width = \Lines()\Text\Width - \Lines()\Text\TextX
				\String\OriginY = #TimeLine_Header_Height + \Lines()\Y + \Lines()\Text\TextY + \Border - \VScrollBar\State
				
				Event\EventType = #Focus
				\String\EventHandler(\String, Event)
				StringSetSelection_Meta(\String, 0, Len(\String\String))
			EndWith
			
			ProcedureReturn #True
		EndProcedure
		
		; Fold the editor away. Keep writes the typed text back into the line (when it
		; actually changed) and reports it with #EventType_ItemTextChange; otherwise
		; the line keeps the text it had.
		Procedure TimeLine_EndEdit(*GadgetData.TimeLineData, Keep)
			Protected Event.Event
			
			With *GadgetData
				If Not \Editing
					ProcedureReturn #False
				EndIf
				
				\Editing = #False : RemoveProp_(GadgetID(\Gadget), "UITK_KeepKeys")
				
				If Keep And SelectElement(\Lines(), \State)
					If \Lines()\Text\OriginalText <> \String\String
						\Lines()\Text\OriginalText = \String\String
						PrepareVectorTextBlock(@\Lines()\Text)
						PostEvent(#PB_Event_Gadget, \ParentWindow, \Gadget, #EventType_ItemTextChange)
					EndIf
				EndIf
				
				Event\EventType = #LostFocus
				\String\EventHandler(\String, Event)
				\RedrawList = #True
			EndWith
			
			ProcedureReturn #True
		EndProcedure
		
		Procedure TimeLine_EventHandler(*GadgetData.TimeLineData, *Event.Event)
			Protected HoverItem = -1, VScrollBar = #False, FirstDisplayedItem, LastDisplayedItem, Y, *Data, Cursor = *GadgetData\EditCursor
			
			With *GadgetData
				Select *Event\EventType
					Case #MouseLeave ;{
						If \HoverItem > -1
							\HoverItem = -1
							\RedrawBody = #True
							\RedrawList = #True
						EndIf
						
						If \VScrollBar\MouseState
							\VScrollBar\MouseState = #Cold
							\RedrawBody = #True
						EndIf
						;}
					Case #MouseMove ;{
						If \String\Selecting = #True ;{
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							\RedrawList = \String\EventHandler(\String, *Event)
							;}
						ElseIf \DragState = #Drag_None ;{
							Cursor = #PB_Cursor_Default
							If *Event\MouseX > #TimeLine_List_Width
								If *Event\MouseY > #TimeLine_Header_Height ;{ Body
									If \VisibleVerticalScrollBar And (*Event\MouseX > \VScrollBar\OriginX Or \VScrollBar\Drag = #True) ;{ Vertical ScrollBar
										\RedrawBody = ScrollBar_EventHandler(\VScrollBar, *Event)
										VScrollBar = #True
										If \RedrawBody And \VScrollBar\Drag
											\RedrawList = #True
											ForEach \Lines()
												If \Lines()\Y + \Lines()\Height >= \VScrollBar\State
													\FirstDisplayedLine = @\Lines()
													Break
												EndIf
											Next
										EndIf
										;}
									Else
										*Event\MouseX - #TimeLine_List_Width
										*Event\MouseY - #TimeLine_Header_Height
									EndIf
									
									;}
								Else;{ Header action
									*Event\MouseX - #TimeLine_List_Width
									
								EndIf;}
							ElseIf *Event\MouseY > #TimeLine_Header_Height ;{ List
								If \FirstDisplayedLine
									ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
									Cursor = #PB_Cursor_Default
									
									*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height
									
									Repeat
										If *Event\MouseY < \Lines()\Y + \Lines()\Height
											HoverItem = ListIndex(\Lines())
											Break
										EndIf
									Until Not NextElement(\Lines())
								EndIf
							EndIf ;}
							
							If \VScrollBar\MouseState And VScrollBar = #False And \VScrollBar\Drag = #False
								\VScrollBar\MouseState = #Cold
								\RedrawBody = #True
							EndIf
							
							If \HoverItem <> HoverItem
								\HoverItem = HoverItem
								\RedrawBody = #True
								\RedrawList = #True
							ElseIf \Editing
								*Event\MouseY - \VScrollBar\State + #TimeLine_Header_Height
								If *Event\MouseX >= \String\OriginX And *Event\MouseY >= \String\OriginY And *Event\MouseX <= \String\OriginX + \String\Width And *Event\MouseY <= \String\OriginY + \String\Height
									Cursor = #PB_Cursor_IBeam
								EndIf
							EndIf
							;}
						ElseIf \DragState = #Drag_Init ;{
							If Abs(\DragOriginX - *Event\MouseX) > #Drag_Distance Or Abs(\DragOriginY - *Event\MouseY) > #Drag_Distance
								SelectElement(\Lines(), \State)
								
								\DragState = #Drag_Active
								\DragOriginX = GadgetX(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginX
								\DragOriginY = GadgetY(\Gadget, #PB_Gadget_ScreenCoordinate) - \DragOriginY + \Lines()\Y - \VScrollBar\State + #TimeLine_Header_Height
								
								ResizeWindow(\ReorderWindow, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, \Width, #PB_Ignore)
								
								StartVectorDrawing(CanvasVectorOutput(\ReorderCanvas))
								AddPathBox(#TimeLine_List_Width - 1, 0, 3, #TimeLine_List_LineHeight)
								VectorSourceColor(\ThemeData\WindowColor)
								FillPath()
								TimeLine_Redraw_ListItem(*GadgetData.TimeLineData, 0, 0, #Hot)
								TimeLine_Redraw_Body(*GadgetData.TimeLineData, #TimeLine_List_Width, 0, #Hot, 0)
								StopVectorDrawing()
								HideWindow(\ReorderWindow, #False)
								SetActiveGadget(\ReorderCanvas)
								
								ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
								FirstDisplayedItem = ListIndex(\Lines())
								LastDisplayedItem = FirstDisplayedItem + Ceil(\BodyHeight / #TimeLine_List_LineHeight)
								\ReorderPosition = Max(Min(Round((*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height) / #TimeLine_List_LineHeight, #PB_Round_Nearest), LastDisplayedItem), FirstDisplayedItem)
								\RedrawBody = #True
								\RedrawList = #True
								
								If \InternalHeight - #TimeLine_List_LineHeight > \BodyHeight
									ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight - #TimeLine_List_LineHeight)
								Else
									\VisibleVerticalScrollBar = #False
									ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight - #TimeLine_List_LineHeight)
								EndIf
							EndIf
							;}
						Else;{
							ChangeCurrentElement(\Lines(), \FirstDisplayedLine)
							FirstDisplayedItem = ListIndex(\Lines())
							LastDisplayedItem = FirstDisplayedItem + Ceil(\BodyHeight / #TimeLine_List_LineHeight)
							LastDisplayedItem + Bool(LastDisplayedItem >= \State)
							
							If \VisibleVerticalScrollBar
								If *Event\MouseY < #TimeLine_Header_Height
									If Not \ReorderFocusTimer
										\ReorderDirection = 0
										\ReorderFocusTimer = AddGadgetTimer(*GadgetData, #TimeLine_Focus_Timer, @TimeLine_ReorderFocusTimer())
										
										If \VScrollBar\State > \Lines()\Y
											ScrollBar_SetState_Meta(\VScrollBar, \Lines()\Y)
										EndIf
									EndIf
								ElseIf *Event\MouseY > \Height
									If Not \ReorderFocusTimer
										\ReorderDirection = 1
										\ReorderFocusTimer = AddGadgetTimer(*GadgetData, #TimeLine_Focus_Timer, @TimeLine_ReorderFocusTimer())
										
										If \VScrollBar\State + \BodyHeight < LastDisplayedItem * #TimeLine_List_LineHeight
											ScrollBar_SetState_Meta(\VScrollBar, LastDisplayedItem * #TimeLine_List_LineHeight - \BodyHeight)
										EndIf
									EndIf
								ElseIf \ReorderFocusTimer
									RemoveGadgetTimer(\ReorderFocusTimer)
									\ReorderFocusTimer = 0
								EndIf
								\ReorderPosition = Max(Min(Round((*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height) / #TimeLine_List_LineHeight, #PB_Round_Nearest), LastDisplayedItem), FirstDisplayedItem)
							Else
								\ReorderPosition = Max(Min(Round((*Event\MouseY + \VScrollBar\State - #TimeLine_Header_Height) / #TimeLine_List_LineHeight, #PB_Round_Nearest), ListSize(\Lines()) - 1), 0)
							EndIf
							
							\RedrawBody = #True
							\RedrawList = #True
							SetWindowPos_(WindowID(\ReorderWindow), 0, *Event\MouseX + \DragOriginX, *Event\MouseY + \DragOriginY, 0, 0, #SWP_NOSIZE | #SWP_NOZORDER | #SWP_NOREDRAW)
							;}
						EndIf
						;}
					Case #KeyDown ;{
						Select *Event\Param
							Case #PB_Shortcut_F2 ;{
								TimeLine_BeginEdit(*GadgetData)
								;}
							Case #PB_Shortcut_Escape ;{
								If TimeLine_EndEdit(*GadgetData, #False)	; keep the old name
								ElseIf \DragState = #Drag_Active
									\ReorderPosition = \State
									*Event\EventType = #LeftButtonUp
									TimeLine_EventHandler(*GadgetData, *Event)
								EndIf
								;}
							Case #PB_Shortcut_Return ;{
								TimeLine_EndEdit(*GadgetData, #True)
								;}
							Default
								If \Editing
									\RedrawList = \String\EventHandler(\String, *Event)
								EndIf
						EndSelect
						;}
					Case #LeftButtonDown ;{
						If \VScrollBar\MouseState
							\RedrawBody + ScrollBar_EventHandler(\VScrollBar, *Event)
						ElseIf \HoverItem <> \State
							TimeLine_EndEdit(*GadgetData, #True)
							If \HoverItem > -1
								\State = \HoverItem
								\RedrawBody = #True
								\RedrawList = #True
								\DragState = #Drag_Init
								\DragOriginX = *Event\MouseX
								\DragOriginY = *Event\MouseY
							EndIf
						Else
							If \EditCursor = #PB_Cursor_IBeam
								*Event\MouseX - \String\OriginX
								*Event\MouseY - \String\OriginY
								\RedrawList = \String\EventHandler(\String, *Event)
							Else
								TimeLine_EndEdit(*GadgetData, #True)
								If \HoverItem > -1
									\DragState = #Drag_Init
									\DragOriginX = *Event\MouseX
									\DragOriginY = *Event\MouseY
								EndIf
							EndIf
						EndIf
						;}
					Case #LeftButtonUp ;{
						If \VScrollBar\MouseState
							\RedrawBody + ScrollBar_EventHandler(\VScrollBar, *Event)
						ElseIf \DragState = #Drag_Init
							\DragState = #Drag_None
							AddGadgetTimer(*GadgetData, 200, @TimeLine_FocusTimer())
						ElseIf \DragState = #Drag_Active
							If \ReorderPosition = 0
								SelectElement(\Lines(), \State)
								MoveElement(\Lines(), #PB_List_First)
							ElseIf \ReorderPosition = ListSize(\Lines())
								SelectElement(\Lines(), \State)
								MoveElement(\Lines(), #PB_List_Last)
							Else
								*Data = SelectElement(\Lines(), \ReorderPosition - Bool(\ReorderPosition < \State))
								SelectElement(\Lines(), \State)
								MoveElement(\Lines(), #PB_List_After, *Data)
							EndIf
							
							ForEach \Lines()
								\Lines()\Y = Y
								Y + #TimeLine_List_LineHeight
							Next
							
							If \InternalHeight > \BodyHeight
								\VisibleVerticalScrollBar = #True
								ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight)
							EndIf
							
							If \ReorderFocusTimer
								RemoveGadgetTimer(\ReorderFocusTimer)
								\ReorderFocusTimer = 0
							EndIf
							
							ForEach \Lines()
								If \Lines()\Y + \Lines()\Height >= \VScrollBar\State
									\FirstDisplayedLine = @\Lines()
									Break
								EndIf
							Next
							
							HideWindow(\ReorderWindow, #True)
							
							\DragState = #Drag_None
							\RedrawBody = #True
							\RedrawList = #True
							\State = \ReorderPosition
							\ReorderPosition = -1
							
							TimeLine_VerticalFocus(*GadgetData)
							
						ElseIf \String\Selecting
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							\RedrawList = \String\EventHandler(\String, *Event)
						EndIf
						;}
					Case #RightButtonDown ;{
										  ;}
					Case #MouseWheel	  ;{
						TimeLine_EndEdit(*GadgetData, #True)
						
						If \VisibleVerticalScrollBar
							ScrollBar_SetState_Meta(\VScrollBar, \VScrollBar\State - *Event\Param * #TimeLine_List_LineHeight * 0.5)
							ForEach \Lines()
								If \Lines()\Y + \Lines()\Height >= \VScrollBar\State
									\FirstDisplayedLine = @\Lines()
									Break
								EndIf
							Next
							*Event\EventType = #MouseMove
							\RedrawList = Bool(Not TimeLine_EventHandler(*GadgetData, *Event))
							\RedrawBody = \RedrawList
						EndIf
						;}
					Case #LostFocus ;{
						TimeLine_EndEdit(*GadgetData, #True)
						;}
					Default ;{
						If \Editing
							*Event\MouseX - \String\OriginX
							*Event\MouseY - \String\OriginY
							\RedrawList = \String\EventHandler(\String, *Event)
						EndIf
						;}
				EndSelect
				
				If Cursor <> \EditCursor
					\EditCursor = Cursor
					\OriginalVT\SetGadgetAttribute(\this, #PB_Canvas_Cursor, \EditCursor)
				EndIf
				
				If \RedrawAll + \RedrawBody + \RedrawHeader + \RedrawList
					StartVectorDrawing(CanvasVectorOutput(\Gadget))
					TimeLine_Redraw(*GadgetData)
					StopVectorDrawing()
				EndIf
				
			EndWith
		EndProcedure
		
		Procedure TimeLine_DragWindowHandler()
			Protected Event.Event, *GadgetData.TimeLineData
			
			Select EventType() 
				Case #PB_EventType_KeyDown
					If GetGadgetAttribute(EventGadget(), #PB_Canvas_Key) = #PB_Shortcut_Escape
						Event\EventType = #KeyDown
						Event\Param = #PB_Shortcut_Escape
						TimeLine_EventHandler(GetProp_(GadgetID(EventGadget()), "UITK_TimeLine"), Event)
					EndIf
				Case #PB_EventType_MouseWheel
					*GadgetData.TimeLineData = GetProp_(GadgetID(EventGadget()), "UITK_TimeLine")
					
					Event\EventType = #MouseWheel
					Event\MouseX =  WindowX(*GadgetData\ReorderWindow) - *GadgetData\DragOriginX
					Event\MouseY =  WindowY(*GadgetData\ReorderWindow) - *GadgetData\DragOriginY
					Event\Param = GetGadgetAttribute(*GadgetData\ReorderCanvas, #PB_Canvas_WheelDelta)
					
					TimeLine_EventHandler(*GadgetData, Event)
			EndSelect
		EndProcedure
		
		Procedure TimeLine_AddItem(*This.PB_Gadget, Position.w, *Text, ImageID, Flags.i)
			Protected *GadgetData.TimeLineData = *this\vt, *NewItem.TimeLine_Line, Result
			With *GadgetData
				If Position > -1 And Position < ListSize(\Lines())
					SelectElement(\Lines(), Position)
					*NewItem = InsertElement(\Lines())
				Else
					LastElement(\Lines())
					*NewItem = AddElement(\Lines())
				EndIf
				
				Result = ListIndex(\Lines())
				
				*NewItem\Text\OriginalText = PeekS(*Text)
				*NewItem\Text\Image = ImageID
				*NewItem\Text\LineLimit = 1
				*NewItem\Text\FontID = TimeLine_ListFont
				
				*NewItem\Text\Width = #TimeLine_List_Width - #TimeLine_List_TextMargin * 2
				*NewItem\Text\Height = #TimeLine_List_LineHeight
				*NewItem\Text\VAlign = #VAlignCenter
				
				*NewItem\Height = #TimeLine_List_LineHeight
				
				PrepareVectorTextBlock(*NewItem\Text)
				
				\InternalHeight + #TimeLine_List_LineHeight
				
				If \InternalHeight > \BodyHeight
					\VisibleVerticalScrollBar = #True
					ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight)
				EndIf
				
				\RedrawList = #True
				\RedrawBody = #True
				
				If ListIndex(\Lines())
					PreviousElement(\Lines())
					*NewItem\Y = \Lines()\Y + \Lines()\Height
					NextElement(\Lines())
				EndIf
				
				While NextElement(\Lines())
					\Lines()\Y + *NewItem\Height
				Wend
				
				ForEach \Lines()
					If \Lines()\Y + \Lines()\Height >= \VScrollBar\State
						\FirstDisplayedLine = @\Lines()
						Break
					EndIf
				Next
				
				StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
				TimeLine_Redraw(*GadgetData)
				StopVectorDrawing()
			EndWith
			
			ProcedureReturn Result
		EndProcedure
		
		Procedure TimeLine_RemoveItem(*This.PB_Gadget, Position.w)
			Protected *GadgetData.TimeLineData = *this\vt, Y
			
			With *GadgetData
				If Position >= 0
					If SelectElement(\Lines(), Position)
						\InternalHeight - \Lines()\Height
						Y = \Lines()\Y
						DeleteElement(\Lines())
						While NextElement(\Lines())
							\Lines()\Y = Y
							Y + \Lines()\Height
						Wend
						
						If ListSize(\Lines()) = 0
							\FirstDisplayedLine = 0
							\State = -1
						ElseIf \State > Position Or (\State = Position And ListSize(\Lines()) = Position )
							\State - 1
						EndIf
						
						If \BodyHeight >= \InternalHeight
							\VisibleVerticalScrollBar = #False
							ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight)
						EndIf
						
						ScrollBar_SetAttribute_Meta(\VScrollBar, #ScrollBar_Maximum, \InternalHeight)
						
						TimeLine_VerticalFocus(*GadgetData)
						
						\RedrawList = #True
						\RedrawBody = #True
						
						StartVectorDrawing(CanvasVectorOutput(\Gadget))
						TimeLine_Redraw(*GadgetData)
						StopVectorDrawing()
					EndIf
				EndIf
			EndWith
		EndProcedure
		
		Procedure TimeLine_CountItem(*this.PB_Gadget)
			Protected *GadgetData.TimeLineData = *this\vt
			ProcedureReturn ListSize(*GadgetData\Lines())
		EndProcedure
		
		Procedure AddMediaBlock(Gadget, Line, Position, Duration, AssetType, Text.s, *Data)
			Protected *this.PB_Gadget = IsGadget(Gadget), *GadgetData.TimeLineData = *this\vt, UUID.s, *NewBlock.TimeLine_Block
			With *GadgetData
				If Line >= 0 And SelectElement(\Lines(), Line)
					UUID = UUID()
					While FindMapElement(\Blocks(), UUID)
						UUID = UUID()
					Wend
					
					*NewBlock = AddMapElement(\Blocks(), UUID, #PB_Map_NoElementCheck)
					*NewBlock\Text = Text
					*NewBlock\UUID = UUID
					*NewBlock\AssetType = AssetType
					*NewBlock\Postion = Position
					*NewBlock\Duration = Duration
					*NewBlock\ParentLine = @\Lines()
					
					ForEach \Lines()\MediaBlocks()
						If \Lines()\MediaBlocks()\Postion > Position
							PreviousElement(\Lines()\MediaBlocks())
							Break
						EndIf
					Next
					
					*NewBlock\ParentElement = AddElement(\Lines()\MediaBlocks())
					\Lines()\MediaBlocks() = *NewBlock
					
					ForEach \Lines()\MediaBlocks()
						If \Lines()\MediaBlocks()\Postion + \Lines()\MediaBlocks()\Duration >= \HScrollBar\State
							\Lines()\FirstDisplayedBlock = @\Lines()\MediaBlocks()
							Break
						EndIf
					Next
					
					\RedrawBody = #True
					StartVectorDrawing(CanvasVectorOutput(\Gadget))
					TimeLine_Redraw(*GadgetData)
					StopVectorDrawing()
				EndIf
			EndWith
		EndProcedure
		
		; Getters
		
		
		
		; Setters
		Procedure TimeLine_SetState(*this.PB_Gadget, State)
			Protected *GadgetData.TimeLineData = *this\vt
			
			*GadgetData\State = State
			*GadgetData\RedrawList = #True
			*GadgetData\RedrawBody = #True
			StartVectorDrawing(CanvasVectorOutput(*GadgetData\Gadget))
			TimeLine_Redraw(*GadgetData)
			StopVectorDrawing()
		EndProcedure
		
		
		Procedure TimeLine_Free(*this.PB_Gadget)
			Protected *GadgetData.TimeLineData = *this\vt
			
			With *GadgetData
				If IsWindow(\ReorderWindow)
					CloseWindow(\ReorderWindow)
				EndIf
				
				RemoveGadgetTimers(\String)
				FreeStructureX(\String)		; its ThemeData is the gadget's own theme, freed once in Default_FreeGadget
				FreeStructureX(\VScrollBar)
				FreeStructureX(\HScrollBar)
			EndWith
			
			Default_FreeGadget(*this)
		EndProcedure
		
		Procedure TimeLine_Meta(*GadgetData.TimeLineData, *ThemeData, Gadget, x, y, Width, Height, Flags)
			Protected GadgetList
			
			*GadgetData\ThemeData = *ThemeData
			InitializeObject(TimeLine)
			
			With *GadgetData
				\VT\GetGadgetState = @Default_GetState()
				\VT\SetGadgetState = @TimeLine_SetState()
				\VT\AddGadgetItem3 = @TimeLine_AddItem()
				\VT\RemoveGadgetItem = @TimeLine_RemoveItem()
				\VT\CountGadgetItems = @TimeLine_CountItem()
				\VT\FreeGadget = @TimeLine_Free()
				
				; Enable only the needed events
				\SupportedEvent[#MouseLeave] = #True
				\SupportedEvent[#MouseMove] = #True
				\SupportedEvent[#KeyDown] = #True
				\SupportedEvent[#LeftButtonDown] = #True
				\SupportedEvent[#RightButtonDown] = #True
				\SupportedEvent[#LeftButtonUp] = #True
				\SupportedEvent[#MouseWheel] = #True
				
				\RedrawAll = #True
				
				\BodyHeight = Height - BorderMargin - #TimeLine_Header_Height
				\BodyWidth = Width - BorderMargin - #TimeLine_List_Width
				\State = -1
				\HoverItem = -1
				\ReorderPosition = -1
				\Duration = 600
				\Scale = 1
				
				GadgetList = UseGadgetList(0)
				\ReorderWindow = OpenWindow(#PB_Any, 0, 0, Width, #TimeLine_List_LineHeight, "", #PB_Window_Invisible | #PB_Window_BorderLess, WindowID(CurrentWindow()))
				\ReorderCanvas = CanvasGadget(#PB_Any, 0, 0, Width, #TimeLine_List_LineHeight, #PB_Canvas_Keyboard)
				BindGadgetEvent(\ReorderCanvas, @TimeLine_DragWindowHandler())
				SetProp_(GadgetID(\ReorderCanvas), "UITK_TimeLine", *GadgetData)
				SetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE, GetWindowLongPtr_(WindowID(\ReorderWindow), #GWL_EXSTYLE) | #WS_EX_LAYERED)
				SetLayeredWindowAttributes_(WindowID(\ReorderWindow), 0, 128, #LWA_ALPHA)
				UseGadgetList(GadgetList)
				
				AllocateStructureX(\VScrollBar, ScrollBarData)
				ScrollBar_Meta(\VScrollBar, *ThemeData, -1, Width - #TimeLine_TrackBarThickness - BorderMargin - 2, #TimeLine_Header_Height + BorderMargin, #TimeLine_TrackBarThickness, \BodyHeight - 1 - BorderMargin, 0, 1, \BodyHeight , #Gadget_Vertical | #Gadget_Meta)
				
				AllocateStructureX(\HScrollBar, ScrollBarData)
				ScrollBar_Meta(\HScrollBar, *ThemeData, -1, #TimeLine_List_Width + BorderMargin, Height - #TimeLine_TrackBarThickness - BorderMargin, \BodyWidth - BorderMargin, #TimeLine_TrackBarThickness, 0, \Duration, 1000, #Gadget_Meta)
				
				AllocateStructureX(\String, StringData)
				String_Meta(\String, *ThemeData, Gadget, 0, 0, \Width, 24, "", #HAlignLeft | #Gadget_Meta)
				String_SetFont_Meta(\String, TimeLine_ListFont)
				String_SupportedEvents()
			EndWith
		EndProcedure
		
		Procedure TimeLine(Gadget, x, y, Width, Height, Flags = #Default)
			Protected Result, *this.PB_Gadget, *GadgetData.TimeLineData, *ThemeData
			
			Result = CanvasGadget(Gadget, x, y, Width, Height, #PB_Canvas_Keyboard | #PB_Canvas_Container)
			
			If Result
				CreateGadgetObject(TimeLineData)
				TimeLine_Meta(*GadgetData, *ThemeData, Gadget, x, y, Width, Height, Flags)
				
				If Not Flags & #PB_Canvas_Container
					CloseGadgetList()
				EndIf
				
				RedrawObject()
				
			EndIf
			
			ProcedureReturn Result
		EndProcedure
		
	CompilerEndIf
	;}
	
EndModule




















; IDE Options = PureBasic 6.41 (Windows - x64)
; CursorPosition = 6770
; Folding = AIA+--PAAAAAAAAAAAAAAAAAA9hDAwfAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAw
; EnableXP
; DPIAware