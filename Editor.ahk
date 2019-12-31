/*
AutoHotkey 版本: 1.x
操作系统:    WinXP
原作者:        甲壳虫<jdchenjian@gmail.com>
甲壳虫博客:        http://hi.baidu.com/jdchenjian
[说明]
脚本描述＝此工具用来修改 AutoHotkey 脚本的右键菜单关联，适用于 AutoHotkey 安装版、绿色版。
LastChangedRevision = 7
LastChangedDate = 2013-3-17
*/
; #Persistent
; #NoEnv
; #SingleInstance, force
; SendMode Input
; SetWorkingDir %A_ScriptDir%
; #InstallKeybdHook

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#singleinstance force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

IniRead LastChangedRevision, %A_ScriptFullPath%,  说明, LastChangedRevision, %A_Space%
IniRead LastChangedDate, %A_ScriptFullPath%,  说明, LastChangedDate, %A_Space%

ScriptName = Vimdesktop路径配置 By BoBO 20190729

Change_History=
(
修改历史：
2018.11.28 新增路径可视化编辑

使用方法：
1.打开路径配置，选择对应路径保存.
2.运行VIMD.exe或者WorkFlow.ahk

AE使用方法：
使用本脚本请在Ae窗口双按zz下最大化使用，效果最佳，否则会有点影响体验
漠视说默认多开会一闪，解决方式把多开-m多开设置去掉.
)
IsLimitedUser:=0
RegWrite, REG_SZ, HKCR, .test
If ErrorLevel
	IsLimitedUser:=1
RegDelete, HKCR, .test
If ErrorLevel
	IsLimitedUser:=1

If IsLimitedUser=0 ; 非受限用户操作HKCR键
{
	RootKey=HKCR
	Subkey=
}
Else ; 受限用户操作HKCU键
{
	RootKey=HKCU
	Subkey=Software\Classes\ ; <-- 为简化后面的脚本，此子键须以“\”结尾
	;~ MsgBox hkcu
}

; 检查是否存在AHK注册表项
RegRead, FileType, %RootKey%, %Subkey%.ahk
If FileType<>
{
	RegRead, value, %RootKey%, %Subkey%, FileName ;AE
	AE_Path:=PathGetPath(value)
	RegRead, value, %RootKey%, %Subkey%, FileName ;Max
	Max_Path:=PathGetPath(value)
	RegRead, value, %RootKey%, %Subkey%, FileName ;TC
	TC_Path:=PathGetPath(value)
	RegRead, value, %RootKey%, %Subkey%, FileName ;Everything
	EV_Path:=PathGetPath(value)
	RegRead, value, %RootKey%, %Subkey%, FileName ;Unity
	Unity_Path:=PathGetPath(value)
	RegRead, value, %RootKey%, %Subkey%, FileName ;PS
	PS_Path:=PathGetPath(value)
}
 If PS_Path=
 {
  IniRead, OutputVar, config.ini, BOBOPath_Config, PSPath
  PS_Path=%OutputVar%
 }
 If AE_Path=
 {
  IniRead, OutputVar, config.ini, BOBOPath_Config, AEPath
  AE_Path=%OutputVar%
 }

 If Max_Path=
 {
  IniRead, OutputVar, config.ini, BOBOPath_Config, MaxPath
  Max_Path=%OutputVar%
 }

If TC_Path=
{
  IniRead, OutputVar, config.ini, TotalCommander_Config, TCPath
  TC_Path=%OutputVar%
}

If EV_Path=
{
  IniRead, OutputVar, config.ini, BOBOPath_Config, EverythingPath
  EV_Path=%OutputVar%
}
If Unity_Path=
{
  IniRead, OutputVar, config.ini, BOBOPath_Config, UnityPath
  Unity_Path=%OutputVar%
}

Gui, Add, Tab, x10 y10 w480 h600 Choose1, 设置 ;|说明|更新历史
Gui, Tab, 1

Gui, Add, GroupBox, x20 y40 w460 h50 , AfterEffect
Gui, Add, Edit, x35 y60 w340 h20 vAE_Path, %AE_Path%
Gui, Add, Button, x385 y60 w60 h20 gFind_AE, 浏览

Gui, Add, GroupBox, x20 y100 w460 h50 , 3DsMax
Gui, Add, Edit, x35 y120 w340 h20 vMax_Path, %Max_Path%
Gui, Add, Button, x385 y120 w60 h20 gFind_Max, 浏览


Gui, Add, GroupBox, x20 y160 w460 h50 , TC
Gui, Add, Edit, x35 y180 w340 h20 vTC_Path, %TC_Path%
Gui, Add, Button, x385 y180 w60 h20 gFind_TC, 浏览


Gui, Add, GroupBox, x20 y220 w460 h50 , Everything
Gui, Add, Edit, x35 y240 w340 h20 vEV_Path, %EV_Path%
Gui, Add, Button, x385 y240 w60 h20 gFind_EV, 浏览

Gui, Add, GroupBox, x20 y280 w460 h50 , Unity3D
Gui, Add, Edit, x35 y300 w340 h20 vUnity_Path, %Unity_Path%
Gui, Add, Button, x385 y300 w60 h20 gFind_Unity, 浏览

Gui, Add, GroupBox, x20 y340 w460 h50 , Photoshop
Gui, Add, Edit, x35 y360 w340 h20 vPS_Path, %PS_Path%
Gui, Add, Button, x385 y360 w60 h20 gFind_PS, 浏览



;~ Gui, Tab, 2
;~ Gui, Font, bold
;~ Gui, Add, Text,, VIMD_ByBoBO 工具  %ScriptName%
;~ Gui, Font
;~ Gui, Font, CBlue Underline
;~ Gui, Add, Text, gWebsite, 作者：BoBO <lingchuanbo@gmail.com>`n`n
;~ Gui, Font
;~ Gui, Add, Text, w450, 此工具用来修改 VIMD 涉及软件路径修改，适用于 VIMD 安装版、绿色版。`n`n win+a打开Ae`n win+3打开Max`n win+f打开everything`n win+e打开TC
;~ Gui, Add, Text, w450, 让所有 Windows 桌面程序便捷操作风格的辅助工具。本人分支支持2D/3D特效相关软件支持！
;~ Gui, Add, Text, w450, 此版本是BoBO(QQ836765757) 基于Vimdesktop_Bykawvin大神版本修改。

;~ Gui, Tab, 3
;~ Gui, Font, bold
;~ Gui, Add, Text,, 更新历史
;~ Gui, Font
 
;~ Gui, Add, Text, w450, %Change_History%

Gui, Tab
Gui, Add, Button, x100 y400 w120 h40 Default gInstall, 设置
;~ ;Gui, Add, Button, x200 y320 w60 h20 gUninstall, 卸载
Gui, Add, Button, x220 y400 w120 h40 gCancel, 取消

Gui, Show, x250 y200 h500 w500 Center,  %ScriptName%
;~ IfNotExist, %EV_Path%
 	;~ GuiControl, Disable, Delete_Template ; 使“删除脚本模板”按钮无效

; 当鼠标指向链接时，指针变成手形
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE")
Return

; 改变鼠标指针为手形
WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static2
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return

GuiClose:
GuiEscape:
Cancel:
ExitApp

; 查找PS
Find_PS:
Gui +OwnDialogs
FileSelectFile, PS_Path, 3, , 查找 Photoshop.exe,*.exe
If PSPath<>
	GuiControl,,PS_Path, %PS_Path%
Return
; 查找AE
Find_AE:
Gui +OwnDialogs
FileSelectFile, AE_Path, 3, , 查找 AfterFX.exe,*.exe
If UnityPath<>
	GuiControl,,AE_Path, %AE_Path%
Return

Find_Max:
Gui +OwnDialogs
FileSelectFile, Max_Path, 3, , 选择, 程序(*.exe)
If Max_Path<>
	GuiControl,,Max_Path, %Max_Path%
Return


Find_TC:
Gui +OwnDialogs
FileSelectFile, TC_Path, 3, , 选择, 程序(*.exe)
If TC_Path<>
	GuiControl,,TC_Path, %TC_Path%
Return

Find_EV:
Gui +OwnDialogs
FileSelectFile, EV_Path, 3, , 选择 程序(*.exe)
If EV_Path<>
	GuiControl,,EV_Path, %EV_Path%
Return

Find_Unity:
Gui +OwnDialogs
FileSelectFile, Unity_Path, 3, , 查找 Unity.exe,*.exe
If Unity_Path<>
	GuiControl,,Unity_Path, %Unity_Path%
Return

; 设置
Install:
Gui, Submit

; 写入ini
IniWrite, %PS_Path%, config.ini, BOBOPath_Config, PSPath
IniWrite, %AE_Path%, config.ini, BOBOPath_Config, AEPath
IniWrite, %Max_Path%, config.ini, BOBOPath_Config, MaxPath
IniWrite, %TC_Path%, config.ini, TotalCommander_Config, TCPath
IniWrite, %EV_Path%, config.ini, BOBOPath_Config, EverythingPath
IniWrite, %Unity_Path%, config.ini, BOBOPath_Config, UnityPath

MsgBox, 64,   %ScriptName%, 设置完毕 ！
ExitApp


;~ ; 新建脚本模板
;~ Create_Template:
;~ GuiControlGet, AE_Path
;~ FileGetVersion, AHK_Ver, %AE_Path%

;~ FileAppend,
;~ (
;~ /*
;~ AutoHotkey 版本: %AHK_Ver%
;~ 操作系统:    %A_OSVersion%
;~ 作者:        %A_UserName%
;~ 网站:        http://www.AutoHotkey.com
;~ 脚本说明：
;~ 脚本版本：   v1.0
;~ */

;~ #NoEnv
;~ SendMode Input
;~ SetWorkingDir `%A_ScriptDir`%

;~ ), %EV_Path%
;~ ), %A_WinDir%\ShellNew\%Template_Name%

;~ GuiControl, Enable, Delete_Template ; 使“删除脚本模板”按钮有效
;~ Return

;~ ; 删除脚本模板
;~ Delete_Template:
;~ MsgBox, 36,  %ScriptName%
;~ , 要删除当前的 AHK 脚本模板吗 ？`n`n脚本模板被删除后，仍可通过本工具重建模板。
;~ IfMsgBox, Yes
	;~ FileDelete, %EV_Path%
	;~ FileDelete, %A_WinDir%\ShellNew\%Template_Name%
;~ GuiControl, Disable, Delete_Template ; 使“删除脚本模板”按钮无效
;~ Return

; 打开网站
;~ Website:
;~ Run, http://www.baidu.com/
;~ Return

RegisterIDs(CLSID, APPID)
{
	RegWrite, REG_SZ, HKCU, Software\Classes\%APPID%,, %APPID%
	RegWrite, REG_SZ, HKCU, Software\Classes\%APPID%\CLSID,, %CLSID%
	RegWrite, REG_SZ, HKCU, Software\Classes\CLSID\%CLSID%,, %APPID%
}

RevokeIDs(CLSID, APPID)
{
	RegDelete, HKCU, Software\Classes\%APPID%
	RegDelete, HKCU, Software\Classes\CLSID\%CLSID%
}


; 从注册表值字符串中提取路径
PathGetPath(pSourceCmd)
{

	 Local Path, ArgsStartPos = 0
	OutputDebug,%pSourceCmd%
	 If (SubStr(pSourceCmd, 1, 1) = """")
		 {
		    Path := SubStr(pSourceCmd, 2, InStr(pSourceCmd, """", False, 2) - 2)
		  	OutputDebug,lf:%Path%
			}
	 Else
	 {
		  ArgsStartPos := InStr(pSourceCmd, " ")
		  If ArgsStartPos
				Path := SubStr(pSourceCmd, 1, ArgsStartPos - 1)
		  Else
				Path = %pSourceCmd%
		OutputDebug,Else:%Path%
	 }
	 Return Path
}