#MaxThreads 255
#MaxHotkeysPerInterval 400
Process, Priority,, Realtime
SendMode Input
DetectHiddenWindows, on
DetectHiddenText, on
SetTitleMatchMode 2
SetWinDelay, 100
CoordMode,Mouse,Screen
SetControlDelay -1
SetKeyDelay, -1            



GroupAdd, 3dsMax, ahk_class 3DSMAX
GroupAdd, MatEditor,Material Editor
GroupAdd, 3dsMax, ahk_class AutoHotkeyGUI

#IfWinActive ahk_group 3dsMax

CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
WinSet, TransColor, %CustomColor% 255
Gui,Font,s7,Tahoma,q5

;;Drop Down Lists
Gui, Add, DropDownList, x246 y52 w100 h20 R100 gModifierSwitch vModifierList Choose 1, Modifier List...||EditPoly|EditSpline
Gui, Add, DropDownList, x146 y52 w100 h20 R100 gObjectSwitch vObjectList Choose 1, Object List...||Box|Plane
Gui, Add, DropDownList, x346 y52 w100 h20 R100 gScriptSwitch vScriptList Choose 1, Script List...||Clear UVW1 Channel

;;Tabs
Gui, Add, Tab, x236 y93 w120 h18 -BackgroundTrans, Edit Poly|Edit Spline

;;Buttons	
Gui, Tab, Edit Poly
Gui, Add, Button, x286 y142 w20 h20 , C
Gui, Add, Button, x266 y112 w60 h30 , Extrude
Gui, Add, Button, x206 y142 w80 h20 , Chamfer
Gui, Add, Button, x306 y142 w80 h20 , Connect
Gui, Add, Button, x266 y162 w60 h30 , Inset
Gui, Add, Button, x326 y112 w30 h30 , Simi Quick
Gui, Add, Button, x326 y162 w30 h30 , Remove
Gui, Add, Button, x236 y162 w30 h30 , Cut
Gui, Add, Button, x236 y112x w30 h30 , Bri dge
Gui, Add, Button, x206 y122 w30 h20 , Weld
Gui, Add, Button, x356 y122 w30 h20 -Wrap +Left, tWeld


;;DropDownList Auto Expand
TimerLabel:
SetTimer, CheckMouseOver, 0
Return

CheckMouseOver:
{
	IfWinActive, ahk_class AutoHotkeyGUI
	{ 
	act:
	SetTimer, CheckMouseOver, 10
	
		MouseGetPos,,,,Control

		if  (control = "ComboBox1")
		{
			sleep 150
			MouseGetPos,,,,WControl
			ControlFocus,ComboBox1,NoActivate
			{
			if  (Wcontrol = "ComboBox1")
				{
					MouseClick, left
					act2:
					SetTimer, CheckMouseOver, Off
					MouseGetPos,,,,QControl
					if  (Qcontrol != "ComboBox1")
					{
						GoTo Act
					}
					else
					{
						GoTo Act2
					}
					Return
				}
				else
				{
					
					Return
				}
			}
		}

		if  (control = "ComboBox2")
		{
			sleep 150
			MouseGetPos,,,,WControl
			ControlFocus,ComboBox2,NoActivate
			{
			if  (Wcontrol = "ComboBox2")
				{
					MouseClick, left
					act22:
					SetTimer, CheckMouseOver, Off
					MouseGetPos,,,,QControl
					if  (Qcontrol != "ComboBox2")
					{
						GoTo Act
					}
					else
					{
						GoTo Act22
					}
					Return
				}
				else
				{				
					Return
				}
			}
		}

		if  (control = "ComboBox3")
		{
			sleep 150
			MouseGetPos,,,,WControl
			ControlFocus,ComboBox3,NoActivate
			{
			if  (Wcontrol = "ComboBox3")
				{
					MouseClick, left
					act23:
					SetTimer, CheckMouseOver, Off
					MouseGetPos,,,,QControl
					if  (Qcontrol != "ComboBox3")
					{
						GoTo Act
					}
					else
					{
						GoTo Act23
					}
					Return
				}
				else
				{
					Return
				}
			}
		}
	}
}
Return

;;Objects List
ObjectSwitch:
	Gui, Submit, 
	if ObjectList=Box
		{
		Gui, Hide
		WinActivate, Autodesk 3ds Max
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, macros.run "AutoHotBox" "Objects_Box", MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Sleep, 150
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, max modify mode, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Return
		}
		
	if ObjectList=Plane
		{
		Gui, Hide
		WinActivate, Autodesk 3ds Max
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, macros.run "AutoHotBox" "Objects_Plane", MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Sleep, 150
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, max modify mode, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Return
		}
Return

;;Modifiers List
ModifierSwitch:
	Gui, Submit, 
	if ModifierList=EditPoly
		{
		Gui, Hide
		WinActivate, Autodesk 3ds Max
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, modPanel.addModToSelection (Edit_Poly ()) ui:on, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Sleep, 100
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, max modify mode, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		;Sleep, 100
		;ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		;Control, EditPaste, $.modifiers[#Edit_Poly].selectMode = 1, MXS_Scintilla2, Autodesk 3ds Max
		;ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Sleep, 100
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, $.modifiers[#Edit_Poly].ignoreBackfacing = on, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Sleep, 100
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, $.modifiers[#Edit_Poly].selectAngle = 5, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Return
		}
		
	if ModifierList=EditSpline
		{
		Gui, Hide
		WinActivate, Autodesk 3ds Max
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, modPanel.addModToSelection (Edit_Spline ()) ui:on, MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Return
		}
Return

;;Scripts List
ScriptSwitch:
	Gui, Submit, 
	if ScriptList= Clear UVW1 Channel
		{
		Gui, Hide
		WinActivate, Autodesk 3ds Max
		ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
		Control, EditPaste, macros.run "AutoHotBox" "Scripts_ClearUVW1Channel", MXS_Scintilla2, Autodesk 3ds Max
		ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
		Return
		}
Return


;;Buttons Actions
;Button C
ButtonC:
Gui, Hide
Return

;Button EPoly_Extrude
ButtonExtrude:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
	{
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "EPoly_ExtrudeOptions", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "EPoly_Extrude", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return

;Button EPoly_ConnectEdges
ButtonConnect:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
    {
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "AutoHotBox" "EPoly_ConnectEdgesOptions", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "AutoHotBox" "EPoly_ConnectEdges", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return

;Button EPoly_Inset
ButtonInset:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
	{
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "EPoly_Inset", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Shift}+{Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "EPoly_Inset", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return

;Button EPoly_Chamfer
ButtonChamfer:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
	{
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "AutoHotBox" "EPoly_ChamferOptions", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "AutoHotBox" "EPoly_Chamfer", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return

;Button Weld
ButtonWeld:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
    {
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "EPoly_WeldOptions", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "EPoly_Weld", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return

;Button Tweld
ButtontWeld:
Gui, Hide
WinActivate, Autodesk 3ds Max
ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
Control, EditPaste, macros.run "Editable Polygon Object" "EPoly_TargetWeld", MXS_Scintilla2, Autodesk 3ds Max
ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
Return

;Button Bridge
ButtonBridge:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
    {
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "PolyBridgeOptions", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "Ribbon - Modeling" "PolyBridge", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return

;Button Remove
ButtonRemove:
Gui, Hide
WinActivate, Autodesk 3ds Max
ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
Control, EditPaste,$.modifiers[#Edit_Poly].ButtonOp #RemoveEdgeRemoveVertices, MXS_Scintilla2, Autodesk 3ds Max
ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
Sleep, 100
ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
Control, EditPaste, macros.run "AutoHotBox" "EPoly_RemoveEdge", MXS_Scintilla2, Autodesk 3ds Max
ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
Return

;Button Cut
ButtonCut:
Gui, Hide
WinActivate, Autodesk 3ds Max
ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
Control, EditPaste, macros.run "Ribbon - Modeling" "CutsCut", MXS_Scintilla2, Autodesk 3ds Max
ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
Return

;Button SimilarQuick
ButtonSimiQuick:
Gui, Hide
GetKeyState, state, LShift, P
If state = D
	{
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "PolyTools" "SimilarQuick", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
else
	{
	WinActivate, Autodesk 3ds Max
	ControlSetText, MXS_Scintilla2, , Autodesk 3ds Max
	Control, EditPaste, macros.run "PolyTools" "Similar", MXS_Scintilla2, Autodesk 3ds Max
	ControlSend, MXS_Scintilla2, {Enter}, Autodesk 3ds Max
	Return
	}
Return
