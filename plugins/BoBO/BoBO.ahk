﻿BoBO:
; 全局控制
; ################# `相关 #################
; `剪贴复制粘贴删除
` & 1:: SendInput,^x
` & 2:: SendInput,^c
` & 3:: SendInput,^v
` & 4:: SendInput,{Del}
` & `;:: SendInput,{Blind}{Home}+{End}

` & j:: SendInput,{Blind}+{Down}
` & k:: SendInput,{Blind}+{Up}
` & h:: SendInput,{Blind}+{Left}
` & l:: SendInput,{Blind}+{Right}

` & b:: SendInput,{Blind}^+{Left}
` & w:: SendInput,{Blind}^+{Right}

` & n:: SendInput,{Blind}+{PgDn}
` & m:: SendInput,{Blind}+{PgUp}

` & u::
	GV_KeyClickAction1 := "SendInput,+{End}"
	GV_KeyClickAction2 := "SendInput,^+{End}"
	GoSub,Sub_KeyClick
return

` & i::
	GV_KeyClickAction1 := "SendInput,+{Home}"
	GV_KeyClickAction2 := "SendInput,^+{Home}"
	GoSub,Sub_KeyClick
return

` & y::
	GV_KeyClickAction1 := "SendInput,{Blind}{Home}+{End}"
	GV_KeyClickAction2 := "SendInput,^{Home}"
	GoSub,Sub_KeyClick
return

;点不是默认的“确定”或者OK按钮，如果没有就点第一个Button1，适用与那种简单的对话框，比如TC的备注
` & Enter::
	try {
		SetTitleMatchMode RegEx
		SetTitleMatchMode Slow
		ControlClick, i).*确定|OK.*, A
	} catch e {
		ControlClick, Button1, A
	}
return


+`::SendInput,~
`::SendInput,``
^`::SendInput,^``
!`::SendInput,!``
+!`::SendInput,+!``

; ################# CapsLock相关 #################
; 大写键控制上下左右
CapsLock & s::SendInput,{Blind}{Down}
CapsLock & w::SendInput,{Blind}{Up}
CapsLock & a::SendInput,{Blind}{Left}
CapsLock & d::SendInput,{Blind}{Right}

CapsLock & q::SendInput,{Blind}{PgUp}
CapsLock & f::SendInput,{Blind}{PgDn}



; ################# Tab相关 #################
#If GV_ToggleTabKeys=1
    Tab & s::SendInput,{Blind}{Down}
    Tab & w::SendInput,{Blind}{Up}
    Tab & a::SendInput,{Blind}{Left}
    Tab & d::SendInput,{Blind}{Right}

; Tab & q::SendInput,{Blind}{PgUp}
; Tab & f::SendInput,{Blind}{PgDn}
	Tab & q::SendInput,{Blind}{Backspace}

    Tab & 1::SendInput,send,#1
    Tab & 2::SendInput,send,#2
    Tab & 3::SendInput,send,#3
    Tab & 4::SendInput,send,#4
    Tab & 5::SendInput,send,#5

    Tab & r::SendInput,{Blind}{Del}
    Tab & e::SendInput,{Blind}{Enter}
    Tab & Space::SendInput,{Blind}{Backspace}
	; 任务栏切换
    Tab & RButton::Gosub,<BoBO_TaskSwch>

	;恢复tab自身功能
	Tab::
		GV_KeyClickAction1 := "SendInput,{Tab}"
		GV_KeyClickAction2 := "SendInput,#{Tab}"
		GoSub,Sub_KeyClick
	return		

	#Tab:: SendInput,#{Tab}
	+Tab:: SendInput,+{Tab}
	^Tab:: SendInput,^{Tab}
	^+Tab:: SendInput,^+{Tab}
	Escape::send,{Escape}
#If 

; Shift切换任务栏

LShift & WheelDown::AltTab
LShift & WheelUp::ShiftAltTab



; 功能：窗口置顶

#MButton::
WinSet, AlwaysOnTop, toggle,A
WinGetTitle, getTitle, A
Winget, getTop,ExStyle,A
if (getTop & 0x8)
{
	toolTip,"已置顶"
    SetTimer, RemoveToolTip, -500
	return
}

else
{
	toolTip,"取消置顶"
	SetTimer, RemoveToolTip, -500
	return
}

return

; 功能：软件启动器	
; 热键：Win+右键						
#RButton::
	IniRead, PopSel,config.ini, config, PopSel, 1
    if PopSel = 1
	{
		Gosub,<BoBO_PopSel>
	}
	else
	{
		return
	}
return
<BoBO_PopSel>:
{
    run %A_ScriptDir%\custom\apps\Popsel\PopSel.exe /n
	return
;    run %A_ScriptDir%\custom\apps\Popsel\PopSel.exe /pc /n ;带图标
}

; 打开记事本
#n::run %A_ScriptDir%\tools\TotalCMD\Tools\notepad\Notepad.exe /c
#h::run,cmd
^#h::run,*RunAs cmd

; 
; 功能：窗口居中
; 热键：Win+Z	或鼠标点击按 Z 键
#z::Gosub,<BoBO_CenterWindow>
;窗口居中
~LButton & z:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    Gosub,<BoBO_CenterWindow>
return

<BoBO_CenterWindow>:
{
	WinGetActiveTitle, var_title
	CenterWindow(var_title)
	return
}


;窗口Vim 目前体验不是很好
; ~^v::DoublePressV()


;功能定位程序对应的目录 打开当前程序所在位置
;Ctrl+Alt+点击，定位程序对应的目录 打开当前程序所在位置
^!LButton::Gosub,<opemLocalDirExe>

<opemLocalDirExe>:
{
	WinGet, pPath, Processpath, A
	SplitPath,pPath,pName,pDir,,pNameNoExt
	Run % "explorer.exe /select," pPath
	sleep,200
	send,{esc}
	return
}
;双击关闭显示器
<BoBO_CloseScreen>:
{
	keyPress:=analyseKeyPress()
	if (keyPress=1){
        return
	}
    if (keyPress=2){
            Sleep 1000
	        SendMessage, 0x112, 0xF170, 2,, Program Manager
            return
	}
    return
}
<BoBO_HuntAndPeck>:
{
    run %A_ScriptDir%\custom\apps\HuntAndPeck\hap.exe /hint
	return
}

;任务栏切换
<BoBO_TaskSwch>:
{
	IniRead, TaskMuEx,config.ini, config, TaskMuEx, 1
    if TaskMuEx = 1
	{
		run %A_ScriptDir%\custom\apps\TaskSwch\TaskMuEx.exe /n
	}
	else
	{
		return
	}
return
}
;社交软件便捷
<Tx_OpenWithTc>:
{
    global TxFileRecv := ini.config.TxFileRecv
    run,"%TCPath%" /T /O /S /L="%TxFileRecv%"
    Return
}
<Wx_OpenWithTc>:
{
	WeixinFiles := ini.config.WeixinFiles 
	; wx_path = % "D:\My Documents\WeChat Files\你的微信目录\FileStorage\File\" . fun_GetFormatTime( "yyyy-MM" )
	run,"%TCPath%" /T /O /S /L="%WeixinFiles%".fun_GetFormatTime( "yyyy-MM" )
    Return
}
<Tg_OpenWithTc>:
{
	WeixinFiles := ini.config.WeixinFiles 
	; wx_path = % "D:\My Documents\WeChat Files\你的微信目录\FileStorage\File\" . fun_GetFormatTime( "yyyy-MM" )
	run,"%TCPath%" /T /O /S /L="C:\Users\Administrator\Downloads\Telegram Desktop"
    Return
}
<BoBO_F4Close>:
{
	send,!{F4}
	return
}
<BoBO_OpenLocalFliesWord>:
{
	; If ProcessExist("WINWORD.EXE")
	; {
		DocumentFile := ComObjActive("Word.Application").ActiveDocument.FullName
		Run, % "explorer /select, " DocumentFile
		return
	; }else{
	; 	MsgBox,,%_AppName%,【Microsoft Office Word】未运行！
	; 	return
	; }
}
<BoBO_OpenLocalFliesExcel>:
{
	; If ProcessExist("EXCEL.EXE")
	; {
		DocumentFile := ComObjActive("Excel.Application").ActiveWorkbook.FullName
		Run, % "explorer /select, " DocumentFile
		return
	; }else{
	; 	MsgBox,,%_AppName%,【Microsoft Office Excel】未运行！
	; 	return
	; }
}
<BoBO_OpenLocalFliesPowerPoint>:
{
	; If ProcessExist("EXCEL.EXE")
	; {
		DocumentFile := ComObjActive("PowerPoint.Application").ActivePresentation.FullName
		Run, % "explorer /select, " DocumentFile
		return
	; }else{
	; 	MsgBox,,%_AppName%,【Microsoft Office Excel】未运行！
	; 	return
	; }
}
<BoBO_OpenLocalDirCommander>:
{
	OutputText:=""
	WinGet, OutWindowID, id, A
	WinGetClass, OutClass, ahk_id %OutWindowID%
	if (OutClass in "ExploreWClass,CabinetWClass")
	{
		send ^l
		controlclick,Edit1,a
		controlsettext,Edit1,cmd,a
		send {enter}
	}
	if (OutClass ="TTOTAL_CMD")
	{
		PostMessage 1075,511,0,,ahk_class TTOTAL_CMD 
	}
	return
}
<BoBO_Test>:
global BoBO_Test=ini.BOBOPath_Config.testPath
msgbox %BoBO_Test%
return
;##########程序便捷.社交##########大部份来自EZ大神
; Tim
; #If WinActive("ahk_class TXGuiFoundation") and WinActive("ahk_exe Tim.exe")
{
    ;快速到QQ接收的文件目录，请在config.ini对应修改qq号
	F4::Gosub, <BoBO_F4Close>
    !w::Gosub, <Tx_OpenWithTc>
	; !`::CoordWinClick(Tim_Start_X, Tim_Start_Y+(1-1)*Tim_Bar_Height)

	!1::CoordWinClick(Tim_Start_X, Tim_Start_Y+(1-1)*Tim_Bar_Height)
	!2::CoordWinClick(Tim_Start_X, Tim_Start_Y+(2-1)*Tim_Bar_Height)
	!3::CoordWinClick(Tim_Start_X, Tim_Start_Y+(3-1)*Tim_Bar_Height)
	!4::CoordWinClick(Tim_Start_X, Tim_Start_Y+(4-1)*Tim_Bar_Height)
	!5::CoordWinClick(Tim_Start_X, Tim_Start_Y+(5-1)*Tim_Bar_Height)
	!6::CoordWinClick(Tim_Start_X, Tim_Start_Y+(6-1)*Tim_Bar_Height)
	!7::CoordWinClick(Tim_Start_X, Tim_Start_Y+(7-1)*Tim_Bar_Height)
	!8::CoordWinClick(Tim_Start_X, Tim_Start_Y+(8-1)*Tim_Bar_Height)
	!9::CoordWinClick(Tim_Start_X, Tim_Start_Y+(9-1)*Tim_Bar_Height)
	!0::CoordWinClick(Tim_Start_X, Tim_Start_Y+(10-1)*Tim_Bar_Height)
	!-::CoordWinClick(Tim_Start_X, Tim_Start_Y+(11-1)*Tim_Bar_Height)
	!=::CoordWinClick(Tim_Start_X, Tim_Start_Y+(12-1)*Tim_Bar_Height)
	; ^r::Gosub, <BoBO_Test>
}
; QQ
#If WinActive("ahk_class TXGuiFoundation") and WinActive("ahk_exe qq.exe")
{
	!1::CoordWinClick(QQ_Start_X, QQ_Start_Y+(1-1)*QQ_Bar_Height)
	!2::CoordWinClick(QQ_Start_X, QQ_Start_Y+(2-1)*QQ_Bar_Height)
	!3::CoordWinClick(QQ_Start_X, QQ_Start_Y+(3-1)*QQ_Bar_Height)
	!4::CoordWinClick(QQ_Start_X, QQ_Start_Y+(4-1)*QQ_Bar_Height)
	!5::CoordWinClick(QQ_Start_X, QQ_Start_Y+(5-1)*QQ_Bar_Height)
	!6::CoordWinClick(QQ_Start_X, QQ_Start_Y+(6-1)*QQ_Bar_Height)
	!7::CoordWinClick(QQ_Start_X, QQ_Start_Y+(7-1)*QQ_Bar_Height)
	!8::CoordWinClick(QQ_Start_X, QQ_Start_Y+(8-1)*QQ_Bar_Height)
	!9::CoordWinClick(QQ_Start_X, QQ_Start_Y+(9-1)*QQ_Bar_Height)
	!0::CoordWinClick(QQ_Start_X, QQ_Start_Y+(10-1)*QQ_Bar_Height)
	!-::CoordWinClick(QQ_Start_X, QQ_Start_Y+(11-1)*QQ_Bar_Height)
	!=::CoordWinClick(QQ_Start_X, QQ_Start_Y+(12-1)*QQ_Bar_Height)
	!w::Gosub, <Tx_OpenWithTc>
}
; 微信
#IfWinActive ahk_exe WeChat.exe
{
	;聚焦搜索框
	!/::CoordWinClick(100,36)
	;点击绿色聊天的数字
	!,::
		CoordMode, Mouse, Window
		click 28,90 2
		Sleep,100
		click 180,100
	Return
	;聚焦打字框
	!`;::
		WinGetPos, wxx, wxy,wxw,wxh, ahk_class WeChatMainWndForPC
		wxw := wxw - 80
		wxh := wxh - 60
		CoordWinClick(wxw,wxh)
	return

	!1::CoordWinClick(WX_Start_X, WX_Start_Y+(1-1)*WX_Bar_Height)
	!2::CoordWinClick(WX_Start_X, WX_Start_Y+(2-1)*WX_Bar_Height)
	!3::CoordWinClick(WX_Start_X, WX_Start_Y+(3-1)*WX_Bar_Height)
	!4::CoordWinClick(WX_Start_X, WX_Start_Y+(4-1)*WX_Bar_Height)
	!5::CoordWinClick(WX_Start_X, WX_Start_Y+(5-1)*WX_Bar_Height)
	!6::CoordWinClick(WX_Start_X, WX_Start_Y+(6-1)*WX_Bar_Height)
	!7::CoordWinClick(WX_Start_X, WX_Start_Y+(7-1)*WX_Bar_Height)
	!8::CoordWinClick(WX_Start_X, WX_Start_Y+(8-1)*WX_Bar_Height)
	!9::CoordWinClick(WX_Start_X, WX_Start_Y+(9-1)*WX_Bar_Height)
	!0::CoordWinClick(WX_Start_X, WX_Start_Y+(10-1)*WX_Bar_Height)

	;快速到微信接收的文件目录，请自己修改对应目录
	!w::Gosub, <Wx_OpenWithTc>
	return
}
; telegram
#IfWinActive ahk_exe Telegram.exe
{
	!w::Gosub, <Tg_OpenWithTc>

	!/::CoordWinClick(150,52)
	!1::CoordWinClick(TG_Start_X, TG_Start_Y+(1-1)*TG_Bar_Height)
	!2::CoordWinClick(TG_Start_X, TG_Start_Y+(2-1)*TG_Bar_Height)
	!3::CoordWinClick(TG_Start_X, TG_Start_Y+(3-1)*TG_Bar_Height)
	!4::CoordWinClick(TG_Start_X, TG_Start_Y+(4-1)*TG_Bar_Height)
	!5::CoordWinClick(TG_Start_X, TG_Start_Y+(5-1)*TG_Bar_Height)
	!6::CoordWinClick(TG_Start_X, TG_Start_Y+(6-1)*TG_Bar_Height)
	!7::CoordWinClick(TG_Start_X, TG_Start_Y+(7-1)*TG_Bar_Height)
	!8::CoordWinClick(TG_Start_X, TG_Start_Y+(8-1)*TG_Bar_Height)
	!9::CoordWinClick(TG_Start_X, TG_Start_Y+(9-1)*TG_Bar_Height)
	!0::CoordWinClick(TG_Start_X, TG_Start_Y+(10-1)*TG_Bar_Height)
}

;##########程序便捷.工具##########
; Everything
#IfWinActive ahk_class EVERYTHING
^Enter::
ControlGetText,Keywords,Edit1,A
OutputDebug %Keywords%
run, http://www.baidu.com/s?wd=%Keywords% 
; run, https://www.dogedoge.com/results?q=%Keywords%
return
#IfWinActive

; #IfWinActive ahk_class #32770
#If WinActive("ahk_group GroupDiagJump") and WinActive("ahk_class #32770")
{
	!e::GoSub,Sub_SendCurDiagPath2Exp		;发送对话框路径到_系统资管中
	; !t:: GoSub,Sub_SendCurDiagPath2Tc ;发送对话框路径到_TC
	; !g:: GoSub,Sub_SendTcCurPath2Diag
	!LButton:: GoSub,Sub_SendTcCurPath2Diag ;发送TC路径到对话框路径
	!w:: GoSub,Sub_SendCurDiagPath2Tc ;发送TC路径到对话框路径
	; ^LButton:: GoSub,Sub_SendCurDiagPath2Tc
	; ~LButton::
	; 	; GV_KeyClickAction1 := "GoSub,Sub_SendTcCurPath2Diag"
	; 	GV_KeyClickAction1 := ""
	; 	GV_KeyClickAction2 := "GoSub,Sub_SendCurDiagPath2Tc"
	; 	GoSub,Sub_KeyClick
	return	
	; ~LButton:: 
	; 	KeyWait,LButton
	; 	KeyWait,LButton, d T0.1
	; 	If ! Errorlevel
	; 	{
	; 		GoSub,Sub_SendCurDiagPath2Tc
	; 	}else{
	; 		GoSub,Sub_SendTcCurPath2Diag
	; 	}
	return
}


#If WinActive("ahk_exe 3dsmax.exe")
{
	` & 1:: Gosub, <3DsMax_getUp>
    ` & 2:: Gosub, <3DsMax_getDown>
    ` & 3:: Gosub, <3DsMax_Key>
	return
}
; 浏览器设置 谷歌内核浏览器一般都支持 火狐没测
#If WinActive("ahk_group group_browser")
{
	F1::Send,^{t}
    F2::send,{Blind}^+{Tab}
    F3::send,{Blind}^{Tab}
    F4::SendInput,^w
    ~LButton & RButton::send ^w
	Delete::GoSub,<GoogleChrome_删除>
	!LButton:: Browser_Back
	!RButton:: Browser_Forward
}
; 资源浏览器
#If WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")
{
	!w::openPathTc() ;Explorer到 TC 互相调用【alt+w】
	NumpadDiv::HideShowfiles() ;显示隐藏文件
	^!t::Gosub,<BoBO_OpenLocalDirCommander>
	^!w::Run,%A_ScriptDir%\custom\apps\TaskSwch\ClsFoldr.EXE ;关闭重复窗口
	^#z::Gosub,ZipDirectory
	return
}
;桌面
#If WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
{
	;!w::openPathTc() ;桌面到TC
	!q::HideOrShowDesktopIcons() ;隐藏、显示桌面图标！
	;桌面到TC
	!w:: 
		if(TCPath="")
			return
		selected := Explorer_GetPath()
		if(selected = ""){
			selected := """" A_Desktop """"
			run, %TCPath% /T /O /A /S /L=%selected%
			sleep 200
			selected := """" A_DesktopCommon """"
			run, %TCPath% /T /O /A /S /R=%selected%
		}
		else{
			selected := """" selected """"
			run, %TCPath% /T /O /S /A /L=%selected%
		}
	return

}
; Total Commander
#If WinActive("ahk_class TTOTAL_CMD")
{
	; !w::openPathExplorer() ;TC 到 Explorer
	; !g:: GoSub,Sub_SendTcCurPath2Diag
	+RButton::Gosub,menuTc
	NumpadDiv::TcSendPos(2011) ;显示隐藏文件
	^!t::Gosub,<BoBO_OpenLocalDirCommander>
	^Up::Gosub,<TcPostMsg>

		,:: 
		ControlGetFocus, TC_CurrentControl, A
		;TInEdit1 地址栏和重命名 Edit1 命令行
		if (RegExMatch(TC_CurrentControl, "TMyListBox1|TMyListBox2"))
			TcSendPos(524)   ;cm_ClearAll
		else
			send,`,
	return
	;复制到对面选中目录
	^!F5::
		send,{Tab}^+c{Tab}{F5}
		Sleep,500
		send,^v
		Sleep,500
		send,{Enter 2}
	return
	;移动到对面选中目录
	^!F6::
		send,{Tab}^+c{Tab}{F6}
		Sleep,500
		send,^v
		Sleep,500
		send,{Enter 2}
	return
	;中键点击，在新建标签中打开
	MButton::
		Send,{Click}
		Sleep 50
		TcSendPos(3003)
	return


	;双击右键，发送退格，返回上一级目录
	~RButton::
		KeyWait,RButton
		KeyWait,RButton, d T0.1
		If ! Errorlevel
		{
		  send {Backspace} 
		}
	Return
	;智能对话框跳转 f
	~LButton::
		GV_KeyClickAction1 := ""
		GV_KeyClickAction2 := "Gosub,Sub_SendTcPathCurDiag"
		GoSub,Sub_KeyClick
	return

	; F1::
	; 	GV_KeyClickAction1 := "Send,{F1}"
	; 	GV_KeyClickAction2 := "Gosub,Sub_SendTcBCompare"
	; 	GoSub,Sub_KeyClick
	; return
		;智能对话框跳转 f
	; ~n::
	; 	GV_KeyClickAction1 := "Send,{n}"
	; 	GV_KeyClickAction2 := "TcSendPos(907)"
	; 	GoSub,Sub_KeyClick
	; return
	F7::TcSendPos(907) ;新建文件夹
	F8::

	;按住Tab 鼠标左键 交换两侧
	Tab & LButton::
		Run, "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_Exchange`)"
	return
		
	
	;按住Space 两侧同时滚动
	Space & WheelDown::Tc_WindowScroll(0)		
	Space & WheelUp::Tc_WindowScroll(1)		


	Return
	
	!w::
	!LButton::
		Dlg_HWnd := WinExist("ahk_group GroupDiagJump")
		if Dlg_HWnd 
		;IfWinExist ahk_group GroupDiagOpenAndSave
		{
			WinGetTitle, Dlg_Title, ahk_id %Dlg_HWnd%
			If RegExMatch(Dlg_Title, "Save|Save As|另存为|保存|图形另存为|保存副本"){
				;msgbox "这是保存对话框"
				orgClip:=clipboardAll
				Clipboard =
				;PostMessage, TC_Msg, CM_CopyFullNamesToClip,0,, ahk_class TTOTAL_CMD
				Run, "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`CM_CopyFullNamesToClip`)"
				; TcSendPos(CM_CopyFullNamesToClip)
				ClipWait, 1
				selFiles := Clipboard
				Clipboard:=orgClip
				selFilesArray := StrSplit(selFiles, "`n","`r")
				if selFilesArray.length() > 1 {
					selFiles:=selFilesArray[1]
					; eztip("对话框是保存类型，只认第一个文件",1)
				}
				StringGetPos OutputVar, selFiles,`\,R1
				StringMid, filePath, selFiles,1, OutputVar+1
				StringMid, fileName, selFiles,OutputVar+2,StrLen(selFiles)-OutputVar

				IfWinNotActive, %Dlg_Title% ahk_id %Dlg_HWnd%, , WinActivate, %Dlg_Title% ahk_id %Dlg_HWnd%
				WinWaitActive, %Dlg_Title% ahk_id %Dlg_HWnd%
				if !ErrorLevel
				{
					ControlGetText, orgFileName,Edit1
					ControlFocus, Edit1,
					sleep 200
					Send,{Backspace}
					sleep 300
					setKeyDelay, 10,10
					ControlSetText, Edit1, %filePath% 
					sleep 900
					send,{enter}
					sleep 500
					if StrLen(fileName) > 0 {
						ControlSetText, Edit1, %fileName% 
					}
					else{
						ControlSetText, Edit1, %orgFileName% 
					}
				}
			}
			else {
				; msgbox "打开对话框"
				orgClip:=clipboardAll
				Clipboard =
				;PostMessage, TC_Msg, CM_CopyFullNamesToClip,0,, ahk_class TTOTAL_CMD
				; TcSendPos(CM_CopyFullNamesToClip)
				Run, "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`CM_CopyFullNamesToClip`)"
				ClipWait, 1
				selFiles := Clipboard
				Clipboard:=orgClip
				selFilesArray := StrSplit(selFiles, "`n","`r")
				quote:=(selFilesArray.length() > 1) ? """" : ""
				selFiles=
				Loop % selFilesArray.MaxIndex()
				{
					this_file := selFilesArray[A_Index]
					selFiles=%selFiles% %quote%%this_file%%quote%
				}
				IfWinNotActive, %Dlg_Title% ahk_id %Dlg_HWnd%, , WinActivate, %Dlg_Title% ahk_id %Dlg_HWnd%
				WinWaitActive, %Dlg_Title% ahk_id %Dlg_HWnd%
				if !ErrorLevel
				{
					sleep 300
					setKeyDelay, 10,10
					ControlSetText, Edit1, %selFiles%
					send, {Enter}
				}
			}
			; reload
		}
		else{
			; 打开默认资源管理器
			openPathExplorer()
		}
	return
}
;##########程序便捷.办公##########
; Word
#If WinActive("ahk_class OpusApp")
{
	!w::Gosub, <BoBO_OpenLocalFliesWord>
}
; Excel
#If WinActive("ahk_class XLMAIN")
{
	!w::Gosub, <BoBO_OpenLocalFliesExcel>
}
; PowerPoint
#If WinActive("ahk_class Case_POWERPNT")
{
	!w::Gosub, <BoBO_OpenLocalFliesPowerPoint>
}
;##########程序便捷.专业##########
#If WinActive("ahk_exe blender.exe")
{
	; BlenderCursorRepeat := 10
	; ; Clear screen in console
	; ^k::Send {Blind}{LCtrl Down}{LControl Up}

	; ; Delete one char to the right of cursor
	; ^d::Send {Delete},

	; ; Clear line in console
	; ^c::Send +{Enter}

	; ; Delete word
	; ^w::Send {LCtrl Down}{Backspace}{LCtrl Up}

	; ^a::
	; 	; Move cursor to beginning
	; 	Loop %BlenderCursorRepeat% {
	; 		Send {LCtrl Down}{Left}{LCtrl Up}
	; 	}
	; Return
	; ^e::
	; 	; Move cursor to end
	; 	Loop %BlenderCursorRepeat% {
	; 		Send {LCtrl Down}{Right}{LCtrl Up}
	; 	}
	; Return
}
#If WinActive("ahk_exe Photoshop.exe")
{	
	` & 1:: Gosub, <PS_透明度减>
	` & 2:: Gosub, <PS_透明度加>
	` & 3:: Gosub, <PS_明颜色>
	` & 4:: Gosub, <PS_暗颜色>
	` & 5:: Gosub, <PS_加暗加亮>
    3::SendInput,{RButton}
	

	4::SendInput,{Delete}

	Space & WheelDown::send [		;缩小画笔
	Space & WheelUp::send ]			;放大画笔

	; `::send,{b}
	` & LButton::Gosub, ps_double_BrushSwith
	
	`::
		GV_KeyClickAction1 := "send,{b}"
		GV_KeyClickAction2 := "Gosub,<PS_eraserTool>"
		GoSub,Sub_KeyClick
	return
}

menuPsAlt:
	menu, menuPsAlt, add,用AE编辑, Ps_UserAeEidtor
    menu, menuPsAlt, add,在TC显示, Ps_TotalCMD
    ; menu, menuPsAlt, add,在资源管理器显示, Ps_Export
    menu, menuPsAlt, Show
return

Ps_UserAeEidtor:
    run,python.exe %A_ScriptDir%\custom\ps_script\openAE.py
return
Ps_TotalCMD:
    run,python.exe %A_ScriptDir%\custom\ps_script\openTC.py
return
Ps_Export:
    MsgBox, "有需求在写"
return

; 百度API
menuTc:
	Menu, menuTc, add,新建,:createDir
		Menu, createDir, add,新建文件夹,<Tools_MkDir>
		Menu, createDir, add,新建文件夹_日期,<Tools_NewFilesDate>

	Menu, menuTc, add,转换, :transformSet
		Menu, transformSet, add, Png转Gif,<em_BoBO_PNGToGIF>
		Menu, transformSet, add, Png转Ico,<em_BoBO_PNGToICO>
		Menu, transformSet, add, DDS转PNG,<em_BoBO_DDSToPNG>
		Menu, transformSet, add, 中文转拼音,<Tools_ChineseConversionPinyin>

	IniRead, myCompany,config.ini, config, myCompany, 1
    if myCompany = kuaiyou
	{
		Menu, menuTc, add,游戏开发, :GameDevSet
		Menu, GameDevSet, add, 打包文件_H5,<GameDevSetPackH5>
		Menu, GameDevSet, add, 打包文件_As,<GameDevSetPackAs>
		Menu, GameDevSet, add, 打包文件_H5_换皮,<em_BoBO_PackH5_hp>
		Menu, GameDevSet, add, Atlas前缀修改,<GameDevSetAtlas>
		Menu, GameDevSet, add, 删除游戏资源,<GameDevDeleteH5>
		Menu, GameDevSet, add, 编辑器 >> 仙谕,<GameDevSetFxEditorXY>
		Menu, GameDevSet, add, 编辑器 >> 三国,<GameDevSetFxEditorSG>
	}


	Menu, menuTc, add,工具, :Toolset
		Menu, Toolset, add, 整理: PNG恢复目录,<em_BoBO_pngFilesRest>
		Menu, Toolset, add, 整理: PNG展开,<em_BoBO_openFilesDir>
		Menu, Toolset, add, 整理: 按文件类型,<Tools_Classification>
		Menu, Toolset, add, 整理: 递归文件到当前目录,<Tools_MoveFilesToDir>
		Menu, Toolset, add, 整理: 当前文件向上移,<Tools_MoveUpDir>
		Menu, Toolset, add, 删除: 空目录,<Tools_NullDir>
		Menu, Toolset, add, 删除: PNG文件,<Tools_DeletePNG>

	Menu, menuTc, add,图片, :TcIMG
		Menu, TcIMG, add, 编辑: 在AfterEffect编辑,<menuTcToAe>
		Menu, TcIMG, add, 根据原图和对应的alpha图提取,<em_BoBO_PNGToAlpha>
		
	Menu, menuTc, add,命令行, :CommanderSet
		Menu,CommanderSet , add, AE: 批渲染,<em_BoBO_AeRender>
		Menu,CommanderSet , add, Test,<TcPostMsgTest>
    Menu, menuTc, Show
return 

<TcPostMsg>:
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_FocusTrg`)"
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_OpenNewTab`)"
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_FocusTrg`)"
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_MatchSrc`)"
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_CloseCurrentTab`)"
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_FocusTrg`)"
return

<TcPostMsgTest>:

	Clipboard := ""
	Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_CopySrcPathToClip`)"
	msgbox %Clipboard%

return

;启动记事本并去标题等

#n::
	run, %A_ScriptDir%\tools\TotalCMD\Tools\Notepad\Notepad.exe /f %A_ScriptDir%\tools\TotalCMD\Tools\Notepad\Notepad.ini, , , OutputVarPID
	sleep 100
	WinWait ahk_pid %OutputVarPID%
	if ErrorLevel
	{
		toolTip 超时了，再试一下？
		sleep 2000
		tooltip
		return
	}

return
;启动记事本并去标题等，并收集剪贴板
^#b::
	run, %COMMANDER_PATH%\Tools\Notepad3\x64\Notepad3.exe /b /f %COMMANDER_PATH%\Tools\Notepad3\x64\Notepad3.ini, , , OutputVarPID
	sleep 100
	WinWait ahk_pid %OutputVarPID%
	if ErrorLevel
	{
		toolTip 超时了，再试一下？
		sleep 2000
		tooltip
		return
	}
return


DoublePressV() ; Simulate double press
{
	t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, hap_tappedkey, %t%
    if (t == "off")
    goto hap_double
    return
    hap_tappedkey:
        {
            ; SendInput,^{v}
            return
        }
    return

    hap_double:
        {
            Run, %A_ScriptDir%\custom\apps\HuntAndPeck\hap.exe /hint
            return
        }
    return
     
}

mBase64En:
    keyword=%Clipboard%
	ToolTipFont("s12","Microsoft YaHei")
    ToolTipColor("053445", "40A1EC")
    ToolTip % LC_Base64_EncodeText(text:=keyword) "//ctrl+v Paste"
    Clipboard:=LC_Base64_EncodeText(text:=keyword) 
return

mBase64De:
    keyword=%Clipboard%
	ToolTipFont("s12","Microsoft YaHei")
    ToolTipColor("053445", "40A1EC")
    ToolTip % LC_Base64_DecodeText(text:=keyword) "//ctrl+v Paste"
    Clipboard:=LC_Base64_DecodeText(text:=keyword)
return

mGenQR:
	; GUI,GQR: Default
	; GUIControlGet,Test,,Edit1
	keyword=%Clipboard%
	GUI,pic:Destroy
	GUI,pic:Add,Pic,x0 y0 w200 h-1 hwndhimage,% f:=GEN_QR_CODE(keyword)
	; GUI,pic:Add,Text,x20 y542 h24,按Esc取消
	; GUI,pic:Add,Button,x420 y540 w100 h24 gmSaveAs,另存为(&S)
	GUI,pic:Show,w200 h200
return

PICGUIEscape:
  GUI,pic:Destroy
return

mSaveAs:
  Fileselectfile,nf,s16,,另存为,PNG图片(*.png)
  If not strlen(nf)
    return
  nf := RegExMatch(nf,"i)\.png") ? nf : nf ".png"
  Filecopy,%f%,%nf%,1
return


mdeepLTranslate:
	;选中文本
	; 判断如果是中文就翻译成英文
	; 没有API直接调用请求速度有点慢，所以改成直接访问网页端
	translator := new DeepLTranslator()
	txt = %Clipboard%

	Loop, parse, txt, `n, `r
	{
		S_LoopField=%A_LoopField%
		if (RegExMatch(S_LoopField,"[^\x00-\xff]+"))
		{
			; Clipboard := translator.translate(S_LoopField, "en", "zh")
			; ToolTipFont("s12","Microsoft YaHei")
			; ToolTipColor("053445", "40A1EC")
			; ToolTip % Clipboard
			Run,https://www.deepl.com/translator#zh/en/%S_LoopField%
			return
		}
		; ; 判断如果是英文就翻译成中文
		if (RegExMatch(S_LoopField,"^[A-Za-z]+"))
		{
			; translator := new DeepLTranslator()
			; txt = %Clipboard%
			; Clipboard := translator.translate(S_LoopField, "zh", "en")
			; ToolTipFont("s12","Microsoft YaHei")
			; ToolTipColor("053445", "40A1EC")
			; ToolTip % Clipboard
			Run,https://www.deepl.com/translator#en/zh/%S_LoopField%
			return
		}
	}
return


; #默认资源管理器相关
; #源码来源 https://itenium.be/Mi-Ke/
ZipDirectory:
	currentPath := ActiveFolderPath()
	if currentPath =
		return

	selectedFiles := Explorer_GetSelected()

	; If one file selected, probably by accident?, default to zipping entire directory
	if selectedFiles
	{
		StringReplace, selectedFiles, selectedFiles, `n, `n, UseErrorLevel
		selectedFilesCount := ErrorLevel + 1
		if (selectedFilesCount = 1) {
			MsgBox, 4, Zippy, Selected one file:`n%selectedFiles%`n`nNo to zip just this file`nYes to zip the entire folder instead., 5
			IfMsgBox, Yes
				selectedFiles :=
		}
	}

	if selectedFiles
	{
		; Zip selected file(s)
		toZip =
		Loop, Parse, selectedFiles, `n
		{
			toZip .= """" A_LoopField """ "
		}
	}
	else
	{
		; Zip entire directory
		toZip := """" currentPath "\*"""
	}


	If selectedFilesCount = 1
	{
		; One filename: use that filename for the zip
		SplitPath, selectedFiles, , , , selectedFileName
		zipFileName := selectedFileName
	}
	else
	{
		; Use active directory name as name for the zip
		SplitPath, currentPath, topDirName


		; .NET: If bin/debug/release foldername, go up for full .net name
		; I assume that adding the AssemblyVersion is overkill for this script? :)
		if (topDirName = "Debug" or topDirName = "Release" or topDirName = "bin")
		{
			parentDirectory := GetParentDirectoryName(currentPath)
			SplitPath, parentDirectory, topDirName
			if (topDirName = "bin")
			{
				parentDirectory := GetParentDirectoryName(parentDirectory)
				SplitPath, parentDirectory, topDirName
			}
		}
		zipFileName := topDirName


		; If the target zip already exists?
		; Simply continuing would overwrite the existing zip with the original zip inside it (ie doubling size because 7zip doesn't see what happened)
		fullZipName = %currentPath%\%topDirName%.zip
		if FileExist(fullZipName)
		{
			MsgBox, 4, Zippy already exists?, %topDirName%.zip already exists!`n`nYes to delete it.`nNo to abort
			IfMsgBox, Yes
				FileDelete %fullZipName%
			IfMsgBox, No
				return
		}
	}

	; The actual zipping :)
	fullZipName = %currentPath%\%zipFileName%.zip

	downloadPath := ini.config.zipper
		; downloadPath := ReadMikeIni("core", "zipper", true)
	StringReplace, downloadPath, downloadPath, <fullZipName>, %fullZipName%
	StringReplace, downloadPath, downloadPath, <toZip>, %toZip%

	RunWait, %downloadPath%
	; RunWait so that we can determine file size
	; Which works - sometimes :p
	FileGetSize, zipFileSize, %fullZipName%, M

return

GetParentDirectoryName(path)
{
	return SubStr(path, 1, InStr(SubStr(path, 1, -1), "\", 0, 0) - 1)
}

^+#`::
	GV_ToggleTabKeys := !GV_ToggleTabKeys
	if(GV_ToggleTabKeys == 1)
		tooltip Tab组合键启用
	else
		tooltip Tab组合键关闭
	sleep 2000
	tooltip
return


;将Explorer中路径发送到对话框
Sub_SendExpCurPath2Diag:
{
	WinActivate ahk_class CabinetWClass
	WinGetTitle, Title, ahk_class CabinetWClass	;打开“文件夹选项”，切换到“查看”选项卡，在高级设置列表框中勾选“在标题栏显示完整路径”，单击“确定”按钮使设置生效，现在访问文件夹路径时就会在左上角的标题栏显示完整路径
	if Title=桌面
		Title=%A_Desktop%
	Send !{Tab}
	ControlFocus, Edit1, A
	send,{Backspace}
	sleep 100
	ControlSetText, Edit1, %Title%,A
	send,{enter}
return
}
;将tc中路径发送到对话框
Sub_SendTcCurPath2Diag:
{
	clipraw:=Clipboard
	Clipboard =
	PostMessage, 1075, 2029,0,, ahk_class TTOTAL_CMD
	ClipWait, 1
	srcDIR := Clipboard
	Clipboard:=clipraw

	;再发送剪贴板路径到控件
	ControlFocus, Edit1, A
	send,{Backspace}
	sleep 100
	ControlSetText, Edit1, %srcDIR%,A
	send,{enter}
return
}
;将tc中路径发送到对话框-备份
Sub_SendTcCurPath2Diag2:
{
	;将剪贴板中内容作为文件名
    B_Clip2Name := false
	B_ChangeDiagSize := true

	;先获取TC中当前路径
	clip:=Clipboard
	Clipboard =
    ;TC_Msg := 1075,cm_CopySrcPathToClip 2029
	PostMessage, 1075, 2029,0,, ahk_class TTOTAL_CMD
	ClipWait, 1
	srcDIR := Clipboard
	Clipboard:=clip

	;再发送剪贴板路径到控件
	ControlFocus, Edit1, A
	send,{Backspace}
	sleep 100
	ControlSetText, Edit1, %srcDIR%,A
	send,{enter}
	;msgbox %clip%
	if(B_Clip2Name){
		Sleep 100
		ControlSetText, Edit1, %clip%,A
	}
	;ControlSetText, Edit1, %text%,A
	if(B_ChangeDiagSize){
		;WinGetPos, xTB, yTB,lengthTB,hightTB, ahk_class Shell_TrayWnd
		;改变对话框大小，省事就直接移动到100,100的位置，然后85%屏幕大小，否则就要详细结算任务栏在上下左右的位置
		WinMove, A,,80,80, A_ScreenWidth * 0.85, A_ScreenHeight * 0.85
	}
return
}
;在TC中打开对话框的路径
Sub_SendCurDiagPath2Tc:
{
	WinGetText, CurWinAllText
	Loop, parse, CurWinAllText, `n, `r
	{
		If RegExMatch(A_LoopField, "^地址: "){
			curDiagPath := SubStr(A_LoopField,4)
			break
		}
	}
	{
	DiagPath := % curDiagPath
	WinActivate ahk_class TTOTAL_CMD
	PostMessage 1075, 3001, 0, , AHK_CLASS TTOTAL_CMD
	ControlSetText, Edit1, cd %DiagPath%, ahk_class TTOTAL_CMD
	Sleep 400
	ControlSend, Edit1, {Enter}, ahk_class TTOTAL_CMD
	}
return
}
;在系统资管中打开对话框的路径
Sub_SendCurDiagPath2Exp:
{
	WinGetText, CurWinAllText
	Loop, parse, CurWinAllText, `n, `r
	{
		If RegExMatch(A_LoopField, "^地址: "){
			curDiagPath := SubStr(A_LoopField,4)
			break
		}
	}
	{
	DiagPath := % curDiagPath
	run explorer.exe %DiagPath%
	}
return
}

Sub_SendTcPathCurDiag:
	Dlg_HWnd := WinExist("ahk_group GroupDiagJump")
	if Dlg_HWnd 
			;IfWinExist ahk_group GroupDiagOpenAndSave
	{
		WinGetTitle, Dlg_Title, ahk_id %Dlg_HWnd%
		If RegExMatch(Dlg_Title, "Save|Save As|另存为|保存|图形另存为|保存副本"){
					;msgbox "这是保存对话框"
		orgClip:=clipboardAll
		Clipboard =
					;PostMessage, TC_Msg, CM_CopyFullNamesToClip,0,, ahk_class TTOTAL_CMD
		Run, "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`CM_CopyFullNamesToClip`)"
					; TcSendPos(CM_CopyFullNamesToClip)
		ClipWait, 1
		selFiles := Clipboard
		Clipboard:=orgClip
		selFilesArray := StrSplit(selFiles, "`n","`r")
		if selFilesArray.length() > 1 {
			selFiles:=selFilesArray[1]
						; eztip("对话框是保存类型，只认第一个文件",1)
		}
		StringGetPos OutputVar, selFiles,`\,R1
		StringMid, filePath, selFiles,1, OutputVar+1
		StringMid, fileName, selFiles,OutputVar+2,StrLen(selFiles)-OutputVar

		IfWinNotActive, %Dlg_Title% ahk_id %Dlg_HWnd%, , WinActivate, %Dlg_Title% ahk_id %Dlg_HWnd%
		WinWaitActive, %Dlg_Title% ahk_id %Dlg_HWnd%
		if !ErrorLevel
		{
			ControlGetText, orgFileName,Edit1
			ControlFocus, Edit1,
			sleep 200
			Send,{Backspace}
			sleep 300
			setKeyDelay, 10,10
			ControlSetText, Edit1, %filePath% 
			sleep 900
			send,{enter}
			sleep 500
			if StrLen(fileName) > 0 {
				ControlSetText, Edit1, %fileName% 
			}
			else{
				ControlSetText, Edit1, %orgFileName% 
			}
		}
		}
		else {
					; msgbox "打开对话框"
					orgClip:=clipboardAll
					Clipboard =
					;PostMessage, TC_Msg, CM_CopyFullNamesToClip,0,, ahk_class TTOTAL_CMD
					; TcSendPos(CM_CopyFullNamesToClip)
					Run, "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`CM_CopyFullNamesToClip`)"
					ClipWait, 1
					selFiles := Clipboard
					Clipboard:=orgClip
					selFilesArray := StrSplit(selFiles, "`n","`r")
					quote:=(selFilesArray.length() > 1) ? """" : ""
					selFiles=
					Loop % selFilesArray.MaxIndex()
					{
						this_file := selFilesArray[A_Index]
						selFiles=%selFiles% %quote%%this_file%%quote%
					}
					IfWinNotActive, %Dlg_Title% ahk_id %Dlg_HWnd%, , WinActivate, %Dlg_Title% ahk_id %Dlg_HWnd%
					WinWaitActive, %Dlg_Title% ahk_id %Dlg_HWnd%
					if !ErrorLevel
					{
						sleep 300
						setKeyDelay, 10,10
						ControlSetText, Edit1, %selFiles%
						send, {Enter}
					}
				}
				; reload
	}
return




