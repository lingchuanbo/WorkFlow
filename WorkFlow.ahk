; 管理员权限代码
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
; ;--20191216
; #WinActivateForce
; #InstallMouseHook
; #MaxMem 4	;max memory per var use
; #MaxHotkeysPerInterval 100 ;Avoid warning when mouse wheel turned very fast
; ;--20191216
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
;Suspend, on
SetStoreCapslockMode, off
; ;--20191216
Process Priority,,High           	    ;线程,主,高级别
SetTitleMatchMode, 2
SetWinDelay,0
; ;--20191216
SetWorkingDir %A_ScriptDir%

global Version:="3.6.3"

FeedbackLink=https://www.kancloud.cn/funbobosky/vim_unity
HelpLink=https://www.kancloud.cn/funbobosky/vim_unity
FontSize:="30"
SleepTime=1000 ; 消失时间

; 定义颜色
global color1=004073
global color2=004073
global color3=007310
global color4=303030
;tab系列组合键，适合左键右鼠，启用后直接按tab会感觉有一点延迟，默认开启，开关为ctrl+win+alt+花号
global GV_ToggleTabKeys := 1
; Tim/QQ位置
global    Tim_Start_X := 100
global    Tim_Start_Y := 100
global    Tim_Bar_Height := 60 
; 微信位置
global    WX_Start_X := 180
global    WX_Start_Y := 100
global    WX_Bar_Height := 62 
; 电报位置
global    TG_Start_X := 100
global    TG_Start_Y := 110
global    TG_Bar_Height := 62 

;常用浏览器设置
GroupAdd, group_browser,ahk_class Chrome_WidgetWin_0    ;Chrome内核浏览器
GroupAdd, group_browser,ahk_class Chrome_WidgetWin_1    ;Chrome内核浏览器
GroupAdd, group_browser,ahk_exe chrome.exe
GroupAdd, group_browser,ahk_exe msedge.exe

; ----------------------------------
#Include %A_ScriptDir%\lib\checkUser.ahk
#Include %A_ScriptDir%\lib\DownloadFile.ahk
#Include %A_ScriptDir%\lib\AutoExecute.ahk
#Include %A_ScriptDir%\lib\AutoUpdate.ahk
#Include %A_ScriptDir%\lib\FunBoBO.ahk
#Include %A_ScriptDir%\lib\TipColor.ahk
#Include %A_ScriptDir%\lib\TrayMenu.ahk
#Include %A_ScriptDir%\core\Main.ahk
#Include %A_ScriptDir%\core\class_vim.ahk
#Include %A_ScriptDir%\core\VimDConfig.ahk
#Include %A_ScriptDir%\lib\class_EasyINI.ahk
#Include %A_ScriptDir%\lib\acc.ahk
#Include %A_ScriptDir%\lib\ini.ahk
#Include %A_ScriptDir%\lib\gdip.ahk
#Include %A_ScriptDir%\lib\Logger.ahk
#Include %A_ScriptDir%\lib\Updater.ahk
#Include %A_ScriptDir%\lib\TrayMenu.ahk
#Include %A_ScriptDir%\lib\ImageButton.ahk
#Include %A_ScriptDir%\plugins\plugins.ahk
#Include %A_ScriptDir%\lib\libcrypt.ahk
; 用户自定义配置yy
#Include %A_ScriptDir%\custom\custom.ahk
; 动态加载|User|
QZ_UpdatePlugin()

SearchFileForKey(SelectedKeys,SelectedAction, SelectedDesc, true)
Sleep, 1000
#Include *i %A_ScriptDir%\User\plugins.ahk
return

