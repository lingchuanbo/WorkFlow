#WinActivateForce ;强制激活窗口
#InstallKeybdHook
#InstallMouseHook
#SingleInstance Force
#NoEnv
#Persistent
#MaxThreads 255
#MaxHotkeysPerInterval 400
#MenuMaskKey vk07
Process, Priority, , High						;脚本高优先级
;Process, Priority,, Realtime
SendMode Input
DetectHiddenWindows, on
;DetectHiddenText, on
SetTitleMatchMode 2
SetWinDelay, 100
CoordMode,Mouse,Screen
SetControlDelay -1
;SetBatchLines -1  ;脚本全速执行
SetKeyDelay, -1    ;控件修改命令自动延时,-OMatic
; SetWorkingDir %A_ScriptDir%
; CreatTrayMenu()
;;GUI
GV_ReloadTimer := % 1000*60*5
CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui,Ae:  +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui,Ae: Color, %CustomColor%
WinSet, TransColor, %CustomColor% 220
Gui,Ae:Font,s8,Tahoma,q5

; Menu, Tray, Icon, %A_ScriptDir%\AfterEffectsPlus.ico


;;Windows Groups
GroupAdd, AfterEffects, ahk_exe AfterFX.exe
GroupAdd, AfterEffects, ahk_class AE_CApplication_14.1
GroupAdd, AfterEffects, ahk_class AE_CApplication_15.1
GroupAdd, AfterEffects, ahk_class AE_CApplication_16.1
GroupAdd, AfterEffects, ahk_class AutoHotkeyGUI

;;AfterEffects
#IfWinActive ahk_group AfterEffects

;;GUI
CustomColor = EEAA99  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
WinSet, TransColor, %CustomColor% 255
Gui,Font,s7,Tahoma,q5

;;Drop Down Lists 下拉列表
;Gui,Ae: Add, DropDownList, x246 y52 w100 h20 R100 gAeModifierSwitch vModifierList Choose 1, Modifier List...||EditPoly|EditSpline
;Gui,Ae: Add, DropDownList, x146 y52 w100 h20 R100 gAeObjectSwitch vObjectList Choose 1, 创建 列表...||合成组|固态层|调节层
;Gui,Ae: Add, DropDownList, x346 y52 w100 h20 R100 gAeScriptSwitch vScriptList Choose 1, 脚本 列表...||Script1|Script2|Script3|

;;Tabs
Gui,Ae: Add, Tab, x236 y93 w180 h18 -BackgroundTrans,Basic|Render|Delete|Tools ;|Test |Tools ;Spline

Gui,Ae: Tab, Render
Gui,Ae: Add, Button,x236 y112 w90 gImmigrationREG, %_AeImmigrationREG%
Gui,Ae: Add, Button,x326 y112 w90 gBatchReplaceFile,%_AeBatchReplaceFile%
Gui,Ae: Add, Button,x236 y136 w180 gRENDER, %_AeRENDER%
Gui,Ae: Add, Button,x236 y160 w180 gNameRENDER,%_AeNameRENDER%
Gui,Ae: Add, Button,x236 y184 w180 gNameDirection,%_AeNameDirection%
Gui,Ae: Add, Button,x236 y208 w180 gName,%_AeName%
Gui,Ae: Add, Button,x236 y232 w180 gRenderGarden,%_AeRenderGarden%RenderGarden 
Gui,Ae: Tab, Tools
Gui,Ae: Add, Button,x236 y112 w90 gProjectConver,%_AeProjectConver%
Gui,Ae: Add, Button,x326 y112 w90 gSaveCompAsProject,%_AeSaveCompAsProject%
Gui,Ae: Add, Button,x236 y136 w90 gCompDuplicator,%_AeCompDuplicator%
Gui,Ae: Add, Button,x326 y136 w90 gPropertiesToFxControls, %_AePropertiesToFxControls%
Gui,Ae: Add, Button,x236 y160 w90 gBatchRename, %_AeBatchRename%
Gui,Ae: Add, Button,x326 y160 w90 gBakeExpressionsKey,%_AeBakeExpressionsKey%

; Gui,Ae: Add, Button, vB1 w32 h32 hwndHBT1 gCopy,
; 	Opt1 := { 1:0, 2:0xECEFF3, 7:0xBCC4D0, icon:{file:A_ScriptDir "\ui\icon\copy.png"} }
; 	Opt2 := { 1:0, 2:0xCAD3DE, 7:0xA5AFBF, icon:{file:A_ScriptDir "\ui\icon\copy.png"} }
; 	Opt3 := { 1:0, 2:0xC1CAD7, 7:0x99A5B7, icon:{file:A_ScriptDir "\ui\icon\copy.png"} }
; 	ImageButton.Create(HBT1, Opt1, Opt2, Opt3)

; Gui,Ae: Add, Button, vB2 w32 h32 hwndHBT2 gSave,
; 	Opt1 := { 1:0, 2:0xECEFF3, 7:0xBCC4D0, icon:{file:A_ScriptDir "\ui\icon\save.png"} }
; 	Opt2 := { 1:0, 2:0xCAD3DE, 7:0xA5AFBF, icon:{file:A_ScriptDir "\ui\icon\save.png"} }
; 	Opt3 := { 1:0, 2:0xC1CAD7, 7:0x99A5B7, icon:{file:A_ScriptDir "\ui\icon\save.png"} }
; 	ImageButton.Create(HBT2, Opt1, Opt2, Opt3)

;Gui, Ae: Show,, Image Buttons

Gui,Ae: Tab, Basic


Gui,Ae: Add, Button, x236 y112 w60 h30 gAutoMatte,%_AeAutoMatte%
Gui,Ae: Add, Button, x296 y112 w60 h30 gDynamicComp, %_AeDynamicComp%
Gui,Ae: Add, Button, x356 y112 w60 h30 gRelinker,%_AeRelinker%

Gui,Ae: Add, Button, x236 y142 w80 h20 gFootageBatch,%_AeFootageBatch%
Gui,Ae: Add, Button, x316 y142 w20 h20 , C
Gui,Ae: Add, Button, x336 y142 w80 h20 gCompsitionOption,%_AeCompsitionOption%

Gui,Ae: Add, Button, x236 y162 w60 h30 gMaskTransformer,%_AeMaskTransformer%
Gui,Ae: Add, Button, x296 y162 w60 h30 gSpriteOMatic,%_AeSpriteOMatic%
Gui,Ae: Add, Button, x356 y162 w60 h30 , ??
; Gui,Ae: Add, Button, x196 y122 w40 h20 , Text
; Gui,Ae: Add, Button, x376 y122 w40 h20 -Wrap +Left, Puppet

Gui,Ae: Tab, Delete
Gui,Ae: Add, Button, x236 y112 w60 h30 gDeletePosition, %_AeDeletePosition%
Gui,Ae: Add, Button, x296 y112 w60 h30 gDeleteKey, %_AeDeleteKey%
Gui,Ae: Add, Button, x356 y112 w60 h30 gDeleteMask, %_AeDeleteMask%

; Gui,Ae: Add, Button, x318 y142 w80 h20 gDeleteMark, %_AeDeleteMark%

Gui,Ae: Add, Button, x236 y142 w80 h20 gDisableExpressions, %_AeDisableExpressions%
Gui,Ae: Add, Button, x316 y142 w20 h20 , C
Gui,Ae: Add, Button, x336 y142 w80 h20 gEnableExpressions, %_AeEnableExpressions%

Gui,Ae: Add, Button, x236 y162 w60 h30 gDeleteEff, %_AeDeleteEff%
Gui,Ae: Add, Button, x296 y162 w60 h30 gResetAll, %_AeResetAll%
Gui,Ae: Add, Button, x356 y162 w60 h30 gDeleteExp, %_AeDeleteExp%
; Gui,Ae: Add, Button, x376 y122 w40 h20 -Wrap +Left gAxis0, %_AeAxis0%

return

CompsitionOption:
	Gui,Ae: Hide
	getAeScript("custom\ae_scripts\commands\CompSetter.jsx")
return
FootageBatch:
	Gui,Ae: Hide
	getAeScript("custom\ae_scripts\commands\BatchFootage.jsx")
return
DynamicComp:
	Gui,Ae: Hide
	getAeScript("custom\ae_scripts\commands\Dynamic_Comp.jsx")
Return

SpriteOMatic:
	Gui,Ae: Hide
	getAeScript("custom\ae_scripts\commands\Sprite-O-Matic.jsx")
Return

;表达式转关键帧
BakeExpressionsKey:
	Gui,Ae: Hide   
    getAeScript("custom\ae_scripts\commands\bakeExpressionsKey.jsxbin")
return

;图层特效属性统一链接到调节层上控制
PropertiesToFxControls: 
	Gui,Ae: Hide   
    getAeScript("custom\ae_scripts\commands\PropertiesToFxControls.jsxbin")
return
;独立复制和重组
CompDuplicator:
	Gui,Ae: Hide   
    getAeScript("custom\ae_scripts\commands\trueCompDuplicator.jsx")
return

ProjectConver:
	Gui,Ae: Hide   
    getAeScript("custom\ae_scripts\commands\OpenSesame.jsx")
return

SaveCompAsProject:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\saveCompAsProject.jsxbin")
return

BatchReplaceFile:
	Gui,Ae: Hide   
    getAeScript("custom\ae_scripts\commands\BatchReplaceFileLocationsWithTextFile.jsx")
return

RenderGarden:
	Gui,Ae: Hide   
    ;RG10-6441-1070-2018注册码
    getAeScript("custom\ae_scripts\commands\RenderGarden.jsx")
return
Name:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\BRender_CreateFolderAndOutputForSelectedComps_Name.jsx")
return

Render:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\BRender_CreateFolderAndOutputForSelectedComps_AttackDirection.jsx")
return
NameRENDER:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\BRender_CreateFolderAndOutputForSelectedComps_NameAttackDirection.jsx")
return
NameDirection:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\BRender_CreateFolderAndOutputForSelectedComps_NameDirection.jsx")
return
ImmigrationREG:
	Gui,Ae: Hide 
    getAeScript("custom\ae_scripts\(BOBOToolsFunctions)\Immigration.jsx")
return

BatchRename:
	Gui,Ae: Hide 
    getAeScript("custom\ae_scripts\AEGlobalRenamer.jsxbin")
return
COPY:
	Gui,Ae: Hide 
	MsgBox Copy
return
SAVE:
	Gui,Ae: Hide 
	MsgBox Save
return
;;DropDownList Auto Expand
AeTimerLabel:
	SetTimer, AeCheckMouseOver, 0
Return

AeCheckMouseOver:
{
	IfWinActive, ahk_class AutoHotkeyGUI
	{ 
	Aeact:
	SetTimer, AeCheckMouseOver, 10
	
		MouseGetPos,,,,Control

		if  (control = "ComboBox1")
		{
		}


		if  (control = "ComboBox2")
		{
		}

		if  (control = "ComboBox3")
		{
		}
	}
}
Return


;;Objects List
AeObjectSwitch:
	Gui,Ae: Submit, 
	if ObjectList=Box
		{
		Gui,Ae: Hide
		Return
		}
		
	if ObjectList=Plane
		{
		Gui,Ae: Hide
		Return
		}
    if ObjectList=Sphere
		{
		Gui,Ae: Hide
		Return
		}
Return

;;Modifiers List
AeModifierSwitch:
	Gui,Ae: Submit, 
	if ModifierList=EditPoly
		{
		Gui,Ae: Hide
		Return
		}
		
	if ModifierList=EditSpline
		{
		Gui,Ae: Hide
		Return
		}
Return

;;Scripts List
AeScriptSwitch:
	Gui,Ae: Submit, 
	if ScriptList= Clear UVW1 Channel
		{
		Gui,Ae: Hide
		Return
		}
Return


;;Buttons Actions
;Button C
AeButtonC:
	Gui,Ae: Hide
Return

;Button EPoly_Selection
AeButtonSelection:
	Gui,Ae: Hide
	Send,{v}
Return

AutoMatte:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\AutoMatte.jsxbin")
Return

Relinker:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\AAF Relinker.jsxbin")
Return

MaskTransformer:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\MaskTransformer.jsx")
Return

AeButtonPen:
Gui,Ae: Hide
	Send,{g}
Return
;激活Ae面板

DeletePosition:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\resetTransformations.jsx")
Return

DeleteMask:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\deleteMasks.jsx")
Return

DeleteMark:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\deleteMarkers.jsx")
Return

ResetAll:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\resetAll.jsx")
Return

DeleteKey:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\deleteKeys.jsx")
Return

DisableExpressions:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\disableExpressions.jsx")
Return

EnableExpressions:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\enableExpressions.jsx")
Return

DeleteEff:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\deleteEffects.jsx")
Return

DeleteExp:
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\commands\deleteExpressions.jsx")
Return

Axis0:
	Gui,Ae: Hide
	send ^!{Home}
Return


   


;<Ae_AHK>:
; Space::
;  	ControlGetFocus, ctrl, A
;     if RegExMatch(ctrl, "i)Edit")  ; or WinExist("ahk_class #32770"))
;     {
; 		send {Space} 
; 		Return
;     }
;     else
;     {
; 		WinActivate, ahk_exe AfterFX.exe
; 		MouseGetPos, MX, MY
; 		MouseX:=MX-305
; 		MouseY:=MY-155 
; 		Gui,Ae: Show,X%MouseX% Y%MouseY% ,NoActivate ; NoActivate avoids deactivating the currently active window.
; 		;保存当前信息
; 		KeyWait,Space ; ,D                                
; 		Sleep, 20                                                                                              
; 		IfWinActive, ahk_class AutoHotkeyGUI
; 	{ 
; 		Click down 
; 		Sleep, 20  
; 		Click up
; 		Sleep, 20                 
; 		Gui,Ae: Hide 
; 	}
; 	else
; 	{
; 		Return
; 	}
;     }
;     return

; Return

; getAeScript(AeScriptPath){
; 	WinActivate, ahk_exe AfterFX.exe
;     WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
;     run, %activePath% -r %AeScriptPath% ,,Hide
; 	send, +{Enter}
; 	Click 1
; 	return
; }



; Gosub,AutoReloadInit
; AutoReloadInit:
; 	SetTimer, AE_Reload, % GV_ReloadTimer
; return

; CreatTrayMenu()
; {
; Menu,Tray,NoStandard
; Menu,Tray,add,重启(&R),AE_Reload
; Menu,Tray,add
; Menu,Tray,add,暂停热键(&S),Menu_Suspend
; Menu,Tray,add,暂停脚本(&A),Menu_Pause
; Menu,Tray,add,退出(&X),Menu_Exit
; }
; AE_Reload:
; 	Reload
; return
; Menu_Suspend:
; 	Menu,tray,ToggleCheck,暂停热键(&S)
; 	Suspend
; return
; Menu_Pause:
; 	Menu,tray,ToggleCheck,暂停脚本(&A)
; 	Pause
; return
; Menu_Exit:
; 	ExitApp
; return

; Quit:
; ExitApp


