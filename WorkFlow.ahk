﻿; 管理员权限代码
Loop, %0%
  {
    param := %A_Index%  ; Fetch the contents of the variable whose name is contained in A_Index.
    params .= A_Space . param
  }
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
if not A_IsAdmin
{
    If A_IsCompiled
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
    Else
       DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
    ExitApp
}
#Include %A_ScriptDir%\lib\Language.ahk
#NoEnv
#SingleInstance Force
#Persistent
#InstallKeybdHook
#MaxHotkeysPerInterval 1000

Process, Priority,,high			;脚本高优先级
CoordMode, Tooltip, Screen
CoordMode, Mouse, Screen
Coordmode, Menu, Window
SetControlDelay, -1
SetKeyDelay, -1
SetBatchLines -1
Detecthiddenwindows, on
FileEncoding, utf-8
SendMode Input
ListLines Off
SetCapsLockState AlwaysOff
SetStoreCapslockMode, off

SetTitleMatchMode, 2				;窗口标题模糊匹配-3为必须精确匹配 -2部分匹配 -1开头匹配
SetWinDelay,0
SetWorkingDir %A_ScriptDir%

global Version:="1.2"
global Update:="2021"


FeedbackLink=https://www.notion.so/7df31102696b43dd948dab655bd1e1f7?v=5cdef8f68af74cfabca156cfb739a299
HelpLink=https://www.notion.so/7df31102696b43dd948dab655bd1e1f7?v=5cdef8f68af74cfabca156cfb739a299
FontSize:="30"
SleepTime=1500 ; 消失时间

; 定义颜色
global color2=001621
global color3=007310
global color4=303030
;tab系列组合键，适合左键右鼠，启用后直接按tab会感觉有一点延迟，默认开启，开关为ctrl+win+alt+花号
global GV_ToggleTabKeys := 1
;正常鼠标指针
GV_CursorNormal_64Win710 := 124973738
;超链接鼠标指针
GV_CursorClick_64Win710 := 1197314685

GV_CursorInputBox := GV_CursorInputBox_64Win710
GV_CursorClick := GV_CursorClick_64Win710
; Tim/QQ位置
global Tim_Start_X := 100
global Tim_Start_Y := 100
global Tim_Bar_Height := 60 
; 微信位置
global WX_Start_X := 180
global WX_Start_Y := 100
global WX_Bar_Height := 62 
; 电报位置
global TG_Start_X := 100
global TG_Start_Y := 110
global TG_Bar_Height := 62 
global this_title=
global zParam
;在浏览器中启用空格系列快捷键
GV_GroupBrowserToggleSpaceKeys := 1
; 程序路径
; IniRead,TCExePath,config.ini,TotalCommander_Config,TCPath
; IniRead,TCExePath,config.ini,TotalCommander_Config,TCDirPath
; global TCExePath := TCExePath
global TCDirPath := "%A_ScriptDir%\tools\TotalCMD"
global TCPath := "%A_ScriptDir%\tools\TotalCMD\TOTALCMD.EXE"
;颜色
;背景颜色
IniRead,BGColor,config.ini,Color_Config,BGColor
IniRead,BGTxtColor,config.ini,Color_Config,BGTxtColor
; 开启背景文字颜色
;浏览器
IniRead,group_browser,Group.ini,GroupBrowser_Config
Loop,parse,group_browser,`n,`r
{
	if (A_LoopField="")
		continue
	MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
	MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
	if (MyVar_Key && MyVar_Val ) 
    GroupAdd,group_browser,%MyVar_Val%
}
; ;窗口跳转
IniRead,GroupDiagJump,Group.ini,GroupDiagJump_Config
Loop,parse,GroupDiagJump,`n,`r
{
	if (A_LoopField="")
		continue
	MyVar_Key:=RegExReplace(A_LoopField,"=.*?$")
	MyVar_Val:=RegExReplace(A_LoopField,"^.*?=") 
	if (MyVar_Key && MyVar_Val ) 
    GroupAdd,GroupDiagJump,%MyVar_Val%
}

;   获取进程路径
GetProcessPath(){
    WinGet, pPath, ProcessPath, A
    SplitPath,pPath,pName,pDir,,pNameNoExt
    if(pName="AfterFX.exe")
    {
        ; MsgBox %pPath%
        Return pPath
    }else{
        MsgBox "AE未运行，请先运行!"
    }
    return
 }
;   记录窗口
SetTimer, AlertWindowList, 500
WindowList:=[]

#Include %A_ScriptDir%\lib\DynamicFileMenu.ahk
#Include %A_ScriptDir%\lib\checkUser.ahk
#Include %A_ScriptDir%\lib\AutoExecute.ahk
#Include %A_ScriptDir%\lib\AutoUpdate.ahk
#Include %A_ScriptDir%\lib\FunBoBO.ahk
#Include %A_ScriptDir%\lib\TrayMenu.ahk
#Include %A_ScriptDir%\core\Main.ahk
#Include %A_ScriptDir%\core\class_vim.ahk
#Include %A_ScriptDir%\core\VimDConfig.ahk
#Include %A_ScriptDir%\lib\class_EasyINI.ahk
#Include %A_ScriptDir%\lib\acc.ahk
#Include %A_ScriptDir%\lib\gdip.ahk
#Include %A_ScriptDir%\lib\Logger.ahk
#Include %A_ScriptDir%\lib\Updater.ahk
#Include %A_ScriptDir%\lib\TrayMenu.ahk
#Include %A_ScriptDir%\plugins\plugins.ahk
#Include %A_ScriptDir%\lib\libcrypt.ahk
#Include %A_ScriptDir%\lib\OnWin.ahk
; #Include %A_ScriptDir%\lib\Jxon.ahk
; #Include %A_ScriptDir%\lib\Base64Enc.ahk
; #Include %A_ScriptDir%\lib\Translate.ahk
;用户自定义配置yy#Include %A_ScriptDir%\custom\custom.ahk

; ----------------------------------

 GetProcessPathAll(p){
	DetectHiddenWindows,On
	Process,Exist,%P%
	if ErrorLevel>0
	{
		PID=%ErrorLevel%
		WinGet,lujing,ProcessPath,ahk_pid %pid%
		return lujing
	}
	else
		return "Sorry,找不到" %P% "!"
 }
; 动态加载|User|函数
QZ_UpdatePlugin()监测
SearchFileForKey(SelectedKeys,SelectedAction, SelectedDesc, true)
Sleep, 1000
; #Include *i %A_ScriptDir%\User\plugins.ahk
#Include *i %A_ScriptDir%\function\function.ahk
return


