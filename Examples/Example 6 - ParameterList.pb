; The ParameterList is compiled in only when this module exists before the include -
; same opt-in scheme as the TimeLine and the LayerList, so a programme that doesn't
; need it doesn't carry it.
DeclareModule EnableParameterList :: EndDeclareModule
Module EnableParameterList :: EndModule

IncludeFile "../Library/UI-Toolkit.pbi"

ExamineDesktops()
Define Width = DesktopWidth(0)
Define Height = DesktopHeight(0)

Global List, Status, Counter, Filling

; A row of the model behind the table. The gadget holds the three cells it draws;
; this holds what they MEAN, which is the host's job in every UITK list gadget.
Structure Row
	Name.s
	Expression.s
	Kind.b			; #ParameterList_Value, _Group or _Branch
	Depth.b
	Adder.b			; a group row that offers a plus
EndStructure

Global NewList Rows.Row()
Global NewMap Values.d()	; every name that resolved, and what it came to

; Left to right, no brackets and no precedence - an example wants a reading in the
; third column, not an expression parser. A term is a number when it starts with a
; digit and a name otherwise; an unknown name is what makes a row faulty.
Procedure.d Evaluate(Expression.s, *Ok.Integer)
	Protected i = 1, Length = Len(Expression), Term.s, Operator.s = "+", Guard
	Protected.d Accumulator, Operand

	*Ok\i = #False
	While i <= Length
		While i <= Length And Mid(Expression, i, 1) = " "
			i + 1
		Wend

		Term = ""
		While i <= Length And Not FindString("+-*/ ", Mid(Expression, i, 1))
			Term + Mid(Expression, i, 1)
			i + 1
		Wend
		If Term = ""
			ProcedureReturn 0
		EndIf

		If Asc(Term) >= '0' And Asc(Term) <= '9'
			Operand = ValD(Term)
		ElseIf FindMapElement(Values(), Term)
			Operand = Values()
		Else
			ProcedureReturn 0	; a name nothing has defined - the row is a complaint
		EndIf

		Select Operator
			Case "+" : Accumulator + Operand
			Case "-" : Accumulator - Operand
			Case "*" : Accumulator * Operand
			Case "/"
				If Operand = 0
					ProcedureReturn 0
				EndIf
				Accumulator / Operand
		EndSelect

		While i <= Length And Mid(Expression, i, 1) = " "
			i + 1
		Wend
		If i <= Length
			Operator = Mid(Expression, i, 1)
			i + 1
			If Not FindString("+-*/", Operator)
				ProcedureReturn 0
			EndIf
		EndIf

		Guard + 1
		If Guard > 32
			ProcedureReturn 0
		EndIf
	Wend

	*Ok\i = #True
	ProcedureReturn Accumulator
EndProcedure

; Repeated passes rather than a dependency graph: a name defined below the row that
; uses it still resolves, and a cycle simply stops changing anything and drops out.
Procedure Resolve()
	Protected Pass, Ok, Changed
	Protected.d Value

	ClearMap(Values())
	For Pass = 1 To 8
		Changed = #False
		ForEach Rows()
			If Rows()\Kind <> UITK::#ParameterList_Value Or Rows()\Name = ""
				Continue
			EndIf
			Value = Evaluate(Rows()\Expression, @Ok)
			If Ok
				If Not FindMapElement(Values(), Rows()\Name)
					Values(Rows()\Name) = Value
					Changed = #True
				ElseIf Values() <> Value
					Values() = Value
					Changed = #True
				EndIf
			EndIf
		Next
		If Not Changed
			Break
		EndIf
	Next
EndProcedure

; The gadget is rewritten from the model whenever the model moves. Filling stops the
; refill's own SetGadgetItemAttribute calls from being read back as user edits.
Procedure Refill(KeepRow = -1)
	Protected Index, Ok, Reading.s
	Protected.d Value
	Protected NewList Folded.i()

	Filling = #True

	For Index = 0 To CountGadgetItems(List) - 1	; remember the folds before they are thrown away
		AddElement(Folded())
		Folded() = GetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Folded)
	Next

	ClearGadgetItems(List)
	Resolve()

	Index = 0
	ForEach Rows()
		Reading = ""
		Ok = #True
		If Rows()\Kind = UITK::#ParameterList_Value
			Value = Evaluate(Rows()\Expression, @Ok)
			If Ok
				Reading = StrD(Value, 2)
			Else
				Reading = "(unknown)"
			EndIf
		EndIf

		; The three cells joined by #LF$, the way a ListIcon row is written, and the
		; fifth argument is the depth: one step deeper than the row above makes a child.
		AddGadgetItem(List, -1, Rows()\Name + #LF$ + Rows()\Expression + #LF$ + Reading, 0, Rows()\Depth)
		SetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Kind, Rows()\Kind)

		Select Rows()\Kind
			Case UITK::#ParameterList_Value
				SetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Editable, %11)	; bit 0 the name, bit 1 the expression
				SetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Removable, #True)
				SetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Faulty, Bool(Not Ok))
			Case UITK::#ParameterList_Group
				SetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Adder, Rows()\Adder)
		EndSelect

		If SelectElement(Folded(), Index)
			SetGadgetItemAttribute(List, Index, UITK::#Attribute_ParameterList_Folded, Folded())
		EndIf
		Index + 1
	Next

	If KeepRow >= 0 And KeepRow < CountGadgetItems(List)
		SetGadgetState(List, KeepRow)
	EndIf

	Filling = #False
EndProcedure

Procedure Say(Text.s)
	SetGadgetText(Status, Text)
EndProcedure

; WHICH CELL COMMITTED, asked of the gadget rather than of the selection. The event is
; posted, so by the time this runs the click that caused it may already have opened the
; editor on another cell - reading GetGadgetState here would report where the hand ended
; up instead of where the text came from.
Procedure Handler_Cell()
	Protected Row = GetGadgetAttribute(List, UITK::#Attribute_ParameterList_EditedRow)
	Protected Column = GetGadgetAttribute(List, UITK::#Attribute_ParameterList_EditedColumn)
	Protected Typed.s

	If Filling Or Row < 0 Or Row >= ListSize(Rows())
		ProcedureReturn
	EndIf
	SelectElement(Rows(), Row)
	Typed = Trim(GetGadgetItemText(List, Row, Column))

	If Column = 0
		Rows()\Name = Typed
		Say("renamed row " + Str(Row) + " to " + Typed)
	Else
		Rows()\Expression = Typed
		Say("row " + Str(Row) + " now reads " + Typed)
	EndIf

	Refill(Row)
EndProcedure

; The plus on a group row: GetGadgetState is the group it was clicked on. The new row
; goes in at the end of that group's subtree and is typed into straight away.
Procedure Handler_Add()
	Protected Group = GetGadgetState(List), Position

	If Group < 0 Or Group >= ListSize(Rows())
		ProcedureReturn
	EndIf
	Position = Group + 1 + GetGadgetItemAttribute(List, Group, UITK::#Attribute_ParameterList_ChildCount)

	SelectElement(Rows(), Group)
	Counter + 1
	If Position >= ListSize(Rows())
		LastElement(Rows())
		AddElement(Rows())
	Else
		SelectElement(Rows(), Position)
		InsertElement(Rows())
	EndIf
	Rows()\Name = "value" + Str(Counter)
	Rows()\Expression = "1"
	Rows()\Kind = UITK::#ParameterList_Value
	Rows()\Depth = 1

	Refill(Position)
	UITK::ParameterListEdit(List, Position, 0)	; …and land in its name cell
	Say("added row " + Str(Position))
EndProcedure

; The cross on a hovered row: GetGadgetState is that row.
Procedure Handler_Remove()
	Protected Row = GetGadgetState(List)

	If Row < 0 Or Row >= ListSize(Rows())
		ProcedureReturn
	EndIf
	SelectElement(Rows(), Row)
	Say("removed " + Rows()\Name)
	DeleteElement(Rows())

	Refill(Row - 1)
EndProcedure

Procedure Handler_Fold()
	Protected Row = GetGadgetState(List)

	If Row >= 0
		Say("row " + Str(Row) + " folded " + Str(GetGadgetItemAttribute(List, Row, UITK::#Attribute_ParameterList_Folded)))
	EndIf
EndProcedure

Procedure Handler_Select()
	Protected Row = GetGadgetState(List)

	If Filling Or Row < 0 Or Row >= ListSize(Rows())
		ProcedureReturn
	EndIf
	SelectElement(Rows(), Row)
	Say("selected " + Rows()\Name + " (depth " + Str(GetGadgetItemAttribute(List, Row, UITK::#Attribute_ParameterList_Depth)) + ")")
EndProcedure

Procedure Add(Name.s, Expression.s, Kind, Depth, Adder = #False)
	LastElement(Rows())
	AddElement(Rows())
	Rows()\Name = Name
	Rows()\Expression = Expression
	Rows()\Kind = Kind
	Rows()\Depth = Depth
	Rows()\Adder = Adder
EndProcedure

Window = UITK::Window(#PB_Any, (Width - 660) * 0.5, (Height - 460) * 0.5, 660, 460, "UI Toolkit : ParameterList", UITK::#DarkMode | UITK::#Window_CloseButton | UITK::#HAlignCenter)

; #Editable turns on the inline editor - a click into a name or an expression cell parks
; a String over it. Without it the table is a read-only report.
List = UITK::ParameterList(#PB_Any, 20, 20, 380, 380, UITK::#DarkMode | UITK::#Border | UITK::#Editable)

UITK::Label(#PB_Any, 415, 20, 225, 20, "Click a name or an expression to type", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 38, 225, 20, "into it. Enter keeps it, Escape drops it.", UITK::#HAlignLeft)

UITK::Label(#PB_Any, 415, 72, 225, 20, "An expression may name another row:", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 90, 225, 20, "try changing width and watch area", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 108, 225, 20, "and spacing follow it.", UITK::#HAlignLeft)

UITK::Label(#PB_Any, 415, 142, 225, 20, "A name nothing defines makes the row", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 160, 225, 20, "faulty - the reading is a complaint", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 178, 225, 20, "rather than a number, and says so.", UITK::#HAlignLeft)

UITK::Label(#PB_Any, 415, 212, 225, 20, "The plus on a group adds a row under", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 230, 225, 20, "it; hover a row for its cross. Click a", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 248, 225, 20, "group's chevron to fold its subtree.", UITK::#HAlignLeft)

UITK::Label(#PB_Any, 415, 282, 225, 20, "Drag the rules between the columns", UITK::#HAlignLeft)
UITK::Label(#PB_Any, 415, 300, 225, 20, "to give a column more room.", UITK::#HAlignLeft)

Status = UITK::Label(#PB_Any, 415, 340, 225, 60, "", UITK::#HAlignLeft | UITK::#VAlignTop)

; A group carries a plus; a branch is a foldable name with no expression of its own.
Add("Frame", "", UITK::#ParameterList_Group, 0, #True)
Add("width", "120", UITK::#ParameterList_Value, 1)
Add("height", "60", UITK::#ParameterList_Value, 1)
Add("area", "width*height", UITK::#ParameterList_Value, 1)

Add("Plate", "", UITK::#ParameterList_Group, 0, #True)
Add("thickness", "4", UITK::#ParameterList_Value, 1)
Add("holes", "6", UITK::#ParameterList_Value, 1)
Add("spacing", "width/holes", UITK::#ParameterList_Value, 1)
Add("clearance", "bore+1", UITK::#ParameterList_Value, 1)	; nothing defines "bore": a faulty row

Add("Derived", "", UITK::#ParameterList_Branch, 0)
Add("volume", "area*thickness", UITK::#ParameterList_Value, 1)
Counter = 0

SetGadgetAttribute(List, UITK::#Attribute_ParameterList_NameWidth, 130)
SetGadgetAttribute(List, UITK::#Attribute_ParameterList_ValueWidth, 90)

Refill()
SetGadgetState(List, 1)
Say("ready")

BindGadgetEvent(List, @Handler_Select(), #PB_EventType_Change)
BindGadgetEvent(List, @Handler_Cell(), UITK::#EventType_ItemTextChange)
BindGadgetEvent(List, @Handler_Add(), UITK::#EventType_ParameterAdd)
BindGadgetEvent(List, @Handler_Remove(), UITK::#EventType_ParameterRemove)
BindGadgetEvent(List, @Handler_Fold(), UITK::#EventType_ParameterFold)

Repeat
	If WaitWindowEvent() = #PB_Event_CloseWindow
		End
	EndIf
ForEver
