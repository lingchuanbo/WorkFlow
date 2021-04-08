CreateTray:
Menu, Tray, Icon, %A_ScriptDir%\workflow_icon.png
menu, Tray, DeleteAll
Menu, Tray, NoStandard
;menu, Tray, UseErrorLevel
Menu, Tray, tip, %_AppName%`n版本:%Version%
menu, Tray, add, %_AppName% %Update%.%Version%,About
Menu, Tray, disable, %_AppName% %Update%.%Version%
menu, Tray, add

Menu, LangSet, add, 中文,中文
Menu, LangSet, add, English,English
Menu, tray, add, %_Language%, :LangSet


Menu, aboutMe, add, %_Help%(&H), <VIMD_Help>

Menu, aboutMe, add, %_Web%(&W), <VIMD_WorkFlowWeb>
Menu, tray, add, %_aboutMe%(&L), :aboutMe


Menu, OptionSet, add, %_Initialization%, <VIMD_Initialization>
Menu, OptionSet, add, 将 %_AppName% 目录添加为系统变量(&B), <VIMD_EnvSystem>
Menu, OptionSet, add, %_BackupRestore%, <VIMD_BackupRestore>

Menu, tray, add, %_Option%, :OptionSet

Menu, Tray, Add, %_Pause%(&P), <Pause>
Menu, Tray, Add, %_Restart%(&R), <Reload>
Menu, Tray, Add, %_Exit%(&X), Exit
Menu, Tray, Click, 1

VimdRun()

if (FirstParameter!="silent")
{
    Gui,welcome: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,welcome: Color, %BGColor%
    Gui,welcome: Font,c%BGTxtColor% s8 wbold q5,Segoe UI
    Gui,welcome: Add, Text, ,%_Welcome% 
    Gui,welcome: Font,c%BGTxtColor% s50 wbold q5,Segoe UI
    Gui,welcome: Add, Text, ,%_AppName%
    Gui,welcome: Font,c%BGTxtColor% s8 wbold q5,Segoe UI
    Gui,welcome: Add, Text, ,%_Authors%   %Update%   V:%Version%                                                      
    Gui,welcome: Font,c%BGTxtColor% s8 wbold q5,Segoe UI
    Gui,welcome: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
    sleep %SleepTime%
    Gui,welcome: Hide
}
return

Author:
About:
License:
Return

中文:
IniWrite, CN, config.ini, config, Language
Reload
Return

English:
IniWrite, EN, config.ini, config, Language
Reload
Return

<Pause>:
	Pause
return


系统状态监测:
if 系统状态监测
{
    系统状态监测=0

}
else
{
    系统状态监测=1
}
Return

;开机启动

Startup:

if Startup
{
    RegDelete, HKLM\Software\Microsoft\Windows\CurrentVersion\Run, WorkFlow
    StartUp=0
    menu,tray,uncheck,%_StartUp%
}
else
{
    RegWrite, REG_SZ, HKLM\Software\Microsoft\Windows\CurrentVersion\Run, WorkFlow, %A_ScriptFullPath%
    StartUp=1
    menu,tray,check,%_StartUp%
}
Return

<VIMD_EnvSystem>:
{
    Gui, Color, 37474F
    Gui -Caption
    Gui, Font, s32,Microsoft YaHei
	  Gui, +AlwaysOnTop +Disabled -SysMenu +Owner 
	  Gui, Add, Text,cffffff,设置%_AppName%为系统变量
	  Gui, Show, xCenter yCenter, 状态, NoActivate,
	  sleep, 1200
	  Gui, Destroy
    
    gotoSetEvn=%A_ScriptDir%\Env_SystemAdd.ahk
    FileDelete, %gotoSetEvn% ;先删除文件
    FileAppend,  ; 这里需要逗号.
    (
#Include %A_ScriptDir%\lib\Environment.ahk
Env_SystemAdd("%_AppName%","%A_ScriptDir%")
return
ExitApp
    ), %A_ScriptDir%\Env_SystemAdd.ahk,UTF-8
    sleep 500
    run, %A_ScriptDir%\Env_SystemAdd.ahk
    sleep 2000
    FileDelete, %A_ScriptDir%\Env_SystemAdd.ahk
    return
}

<VIMD_Initialization>:
    Gui, Color, 37474F
    Gui -Caption
    Gui, Font, s32,Microsoft YaHei
	  Gui, +AlwaysOnTop +Disabled -SysMenu +Owner 
	  Gui, Add, Text,cffffff,正在初始化 Photoshop/Aftereffect/3DsMax
	  Gui, Show, xCenter yCenter, 状态, NoActivate,
	  sleep, 1200
	  Gui, Destroy
    gosub,Ps_Init_TotalCMD
    gosub,Ps_Init_Ae
    gosub,AE_Init_OpenLocalFilesRenderTC
    gosub,AE_Init_RevealInFinderTC
    gosub,<3DsMax_Ini>
return
; 用户自定义配置
<EditConfig>:
    run , %A_ScriptDir%\Editor.ahk
return

<VIMD_WorkFlowWeb>:
Run, https://github.com/lingchuanbo/WorkFlow
return

<VIMD_Help>:
Run, https://www.notion.so/WorkFlow-5473b03e9dad41ecb79bc3c5b5ac2913
return

<VIMD_Update>:
; 先执行访问，后面在执行下面
FileCopy, %A_ScriptDir%\config.ini, %A_ScriptDir%\config_back_%d%.ini ,1
; FileCopy, %A_ScriptDir%\config.ini, %A_ScriptDir%\vimd_备份_还原.ini ,1
Run, https://github.com/lingchuanbo/WorkFlow
; 执行备份文件
; d = (%A_YYYY%_%A_MM%_%A_DD%_%A_Hour%%A_Min%%A_Sec%)
; ; 执行备份文件
; FileCopy, %A_ScriptDir%\config.ini, %A_ScriptDir%\vimd_备份_%d%.ini ,1
; ; 执行备份文件2
; FileCopy, %A_ScriptDir%\config.ini, %A_ScriptDir%\vimd_备份_还原.ini ,1
; Sleep, 1000
; 开始运行更新工具
; run, %A_ScriptDir%\updata.exe
; Sleep, 2000
; ; 查看更新日志
; Run, https://github.com/lingchuanbo/WorkFlow
; Sleep, 2000
; Exitapp
; Gosub,Check_Update
return

<VIMD_BackupRestore>:
; MsgBox, 4,, 如果您更新过程序 请选择是? (press Yes or No)
; IfMsgBox Yes
;     if FileExist("%A_ScriptDir%\vimd_备份_还原.ini")
;         {
Gui,Backup: Add, Button, xCenter y20 w80 h50 gBackup, 备份
Gui,Backup: Add, Button, x100 y20 w80 h50 gBackupRestore, 还原
Gui,Backup: Show, xCenter w180 h100, %_AppName%
return

GuiClose:
ExitApp

Backup:
Gui,Backup: Hide
; ToolTipFont("s12","Microsoft YaHei")
; ToolTipColor("053445", "40A1EC")
ToolTip, 正在执行备份！
sleep 100
SetTimer, RemoveToolTip, -1000
FileCopy, %A_ScriptDir%\config.ini, %A_ScriptDir%\vimd_备份_还原.ini ,1
return

BackupRestore:
Gui,Backup: Hide
; ToolTipFont("s12","Microsoft YaHei")
; ToolTipColor("053445", "40A1EC")
ToolTip, 正在执行还原操作！
sleep 100
SetTimer, RemoveToolTip, -1000
FileCopy, %A_ScriptDir%\vimd_备份_还原.ini, %A_ScriptDir%\config.ini ,1
sleep 500
ToolTip, 重启中...
SetTimer, RemoveToolTip, -1000
FileRecycle, %A_ScriptDir%\vimd_备份_还原.ini
sleep 500
Reload
Return

Exit:
FileRemoveDir,%ProgramFilesDir%,1
MsgBox,0x40134,%_AppName%,%_ConfirmExit%
IfMsgBox, Yes
Exitapp
Return

Check_Update:
	checkUpdateFlag:=true
	TrayTip,,%_AppName%检查更新中……,2,1
	gosub,Auto_Update
return

Auto_Update:
	if(FileExist(A_Temp "\WorkFlow_Update.bat"))
		FileDelete, %A_Temp%\WorkFlow_Update.bat
	;[下载最新的更新脚本]
	if(!Check_Github()){
		lpszUrl:=githubUrl
		WorkFlowDownDir:=lpszUrl . GithubDir
		if(!Check_Github()){
			TrayTip,,网络异常，无法连接网络读取最新版本文件,3,1
			return
		}
	}
	URLDownloadToFile(WorkFlowDownDir "/WorkFlow.ahk",A_Temp "\temp_WorkFlow.ahk")
	versionReg=iS)^\t*\s*global WorkFlow_update_version:="([\d\.]*)"
	Loop, read, %A_Temp%\temp_WorkFlow.ahk
	{
		if(RegExMatch(A_LoopReadLine,versionReg)){
			versionStr:=RegExReplace(A_LoopReadLine,versionReg,"$1")
			break
		}
		if(A_LoopReadLine="404: Not Found"){
			TrayTip,,文件下载异常，更新失败！,3,1
			return
		}
	}
	if(versionStr){
		if(WorkFlow_update_version<versionStr){
			MsgBox,33,%_AppName%检查更新,检测到%_AppName%有新版本`n`n%WorkFlow_update_version%`t版本更新后=>`t%versionStr%`n`n是否更新到最新版本？`n覆盖老版本文件，如有修改过config.ini请注意备份！
			IfMsgBox Ok
			{
				TrayTip,,%_AppName%下载最新版本并替换老版本...,5,1
				; gosub,Config_Update
                ; FileCopy, %A_ScriptDir%\config.ini, %A_ScriptDir%\vimd_back.ini ,1
				URLDownloadToFile(WorkFlowDownDir "/vimd.exe",A_Temp "\temp_vimd.exe")
				gosub,vimd_Update
				shell := ComObjCreate("WScript.Shell")
				shell.run(A_Temp "\vimd_Update.bat",0)
				ExitApp
			}
		}else if(checkUpdateFlag){
			FileDelete, %A_Temp%\temp_WorkFlow.ahk
			TrayTip,,%_AppName%已经是最新版本。,5,1
			checkUpdateFlag:=false
		}else if(A_DD!=01 && A_DD!=15){
			FileDelete, %A_Temp%\temp_WorkFlow.ahk
		}
	}
return

vimd_Update:
TrayTip,,%_AppName%已经更新到最新版本。,5,1
FileAppend,
(
@ECHO OFF & setlocal enabledelayedexpansion & TITLE vimd更新版本
set /a x=1
:BEGIN
set /a x+=1
ping -n 2 127.1>nul
if exist "%A_Temp%\temp_WorkFlow.ahk" `(
  MOVE /y "%A_Temp%\temp_WorkFlow.ahk" "%A_ScriptDir%\WorkFlow.ahk"
`)
if exist "%A_Temp%\temp_vimd.exe" `(
  MOVE /y "%A_Temp%\temp_vimd.exe" "%A_ScriptDir%\vimd.exe"
`)
goto INDEX
:INDEX
if !x! GTR 10 `(
  exit
`)
if exist "%A_Temp%\temp_WorkFlow.ahk" `(
  goto BEGIN
`)
if exist "%A_Temp%\temp_vimd.exe" `(
  if !x! EQU 5 `(
    taskkill /f /im %A_ScriptName%
  `)
  goto BEGIN
`)
start "" "%A_ScriptDir%\%A_ScriptName%"
exit
),%A_Temp%\vimd_Update.bat
return

; ~LButton:: 
; 	ToolTip
; return