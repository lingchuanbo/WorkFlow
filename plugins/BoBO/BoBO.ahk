BoBO:
; 全局控制
; `剪贴复制粘贴删除
` & 1:: SendInput,^x
` & 2:: SendInput,^c
` & 3:: SendInput,^v
` & 4:: SendInput,{Del}
+`::SendInput,~
`::SendInput,``

; 大写键控制上下左右
CapsLock & s::SendInput,{Blind}{Down}
CapsLock & w::SendInput,{Blind}{Up}
CapsLock & a::SendInput,{Blind}{Left}
CapsLock & d::SendInput,{Blind}{Right}

CapsLock & q::SendInput,{Blind}{PgUp}
CapsLock & e::SendInput,{Blind}{PgDn}

~^!a:: Gosub,<ShareX_PrintScreen>
~^c:: DoublePress()
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
;集成快捷启动
<BoBO_PopSel>:
{
    run %A_ScriptDir%\custom\apps\Popsel\PopSel.exe /n
	return
;    run %A_ScriptDir%\custom\apps\Popsel\PopSel.exe /pc /n

}
<BoBO_CenterWindow>:
{
	WinGetActiveTitle, var_title
	CenterWindow(var_title)
	return
}
;任务栏切换
<BoBO_TaskSwch>:
{
    run %A_ScriptDir%\custom\apps\TaskSwch\TaskSwch.exe /n
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


; Tim/QQ客户端
#IfWinActive ahk_class TXGuiFoundation
{
    ;快速到QQ接收的文件目录，请在config.ini对应修改qq号
	F4::Gosub, <BoBO_F4Close>
    !w::Gosub, <Tx_OpenWithTc>
	!`::CoordWinClick(Tim_Start_X, Tim_Start_Y+(1-1)*Tim_Bar_Height)

	!1::CoordWinClick(Tim_Start_X, Tim_Start_Y+(2-1)*Tim_Bar_Height)
	!2::CoordWinClick(Tim_Start_X, Tim_Start_Y+(3-1)*Tim_Bar_Height)
	!3::CoordWinClick(Tim_Start_X, Tim_Start_Y+(4-1)*Tim_Bar_Height)
	!4::CoordWinClick(Tim_Start_X, Tim_Start_Y+(5-1)*Tim_Bar_Height)
	!5::CoordWinClick(Tim_Start_X, Tim_Start_Y+(6-1)*Tim_Bar_Height)
	!6::CoordWinClick(Tim_Start_X, Tim_Start_Y+(7-1)*Tim_Bar_Height)
	!7::CoordWinClick(Tim_Start_X, Tim_Start_Y+(8-1)*Tim_Bar_Height)
	!8::CoordWinClick(Tim_Start_X, Tim_Start_Y+(9-1)*Tim_Bar_Height)
	!9::CoordWinClick(Tim_Start_X, Tim_Start_Y+(10-1)*Tim_Bar_Height)
}

;微信PC客户端
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
;telegram客户端
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
; ShareX截图相关
<ShareX_PrintScreen>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ShareX_tappedkey_PrintScreen, %t%
    if (t == "off")
    goto ShareX_double_PrintScreen
    return
    ShareX_tappedkey_PrintScreen:
        {
			SendInput,^{PrintScreen}
			return
        }
    return

    ShareX_double_PrintScreen:
        {
			Menu, ShareX, Add, (&A) 矩形区域截图, mPrintScreen
			Menu, ShareX, Add, (&D) 矩形截图屏幕, mPrintScreenAll
			Menu, ShareX, Add, (&T) 捕捉当前活动窗口, mPrintScreenActive
			Menu, ShareX, Add, (&R) 录制屏幕, mRecordingScreen
			Menu, ShareX, Add, (&G) 录制屏幕_GIF, mRecordingScreenGif
			Menu, ShareX, Add, (&G) 截图OCR, mPandaOCR
			Menu, ShareX, Show
            return
        }
    return
}

;启动记事本并去标题等
#n::
	run F:\BoBOProgram\TotalCMD\Tools\Notepad3\x64\Notepad3.exe /f F:\BoBOProgram\TotalCMD\Tools\Notepad3\x64\Notepad3.ini, , , OutputVarPID
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
	run F:\BoBOProgram\TotalCMD\Tools\Notepad3\x64\Notepad3.exe /b /f F:\BoBOProgram\TotalCMD\Tools\Notepad3\x64\Notepad3.ini, , , OutputVarPID
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
#IfWinActive ahk_class TTOTAL_CMD
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

	F1::
		ActiveDocumentFile := ComObjActive("Word.Application").ActiveDocument.FullName
		Run, % "explorer /select, " ActiveDocumentFile
#IfWinActive

#If WinActive("ahk_class CabinetWClass") or WinActive("ahk_class ExploreWClass")
{
	!w::openPathTc() ;Explorer到 TC 互相调用【alt+w】
	NumpadDiv::HideShowfiles() ;显示隐藏文件
	^!t::Gosub,<BoBO_OpenLocalDirCommander>
	return
}

#If WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
{
	!w::openPathTc() ;桌面到TC
	!q::HideOrShowDesktopIcons() ;隐藏、显示桌面图标！
	return
}

#If WinActive("ahk_class TTOTAL_CMD")
{
	!w::openPathExplorer() ;TC 到 Explorer
	NumpadDiv::TcSendPos(2011) ;显示隐藏文件
	^!t::Gosub,<BoBO_OpenLocalDirCommander>

	; 2011
	return
}
#If WinActive("ahk_class OpusApp")
{
	!w::Gosub, <BoBO_OpenLocalFliesWord>
}
#If WinActive("ahk_class XLMAIN")
{
	!w::Gosub, <BoBO_OpenLocalFliesExcel>
}
#If WinActive("ahk_class Case_POWERPNT")
{
	!w::Gosub, <BoBO_OpenLocalFliesPowerPoint>
}

;AE快速打开文件所在位置 至于是否启用TC到时候在考虑目前可以一直按alt+w
#If WinActive("ahk_exe AfterFX.exe")
{
	!w::getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
	return
}
mPandaOCR:
    ; ExePath := ini.BOBOPath_Config.AEPath
    ; tClass := ini.ahk_class_Config.AEClass
    FunBoBO_RunActivation(ExePath:="F:\BoBOProgram\PandaOCR\PandaOCR.exe",tClass:="WTWindow")
		sleep 2000
		Send,{F4}
		return
return
mPrintScreen:
	SendInput,^{PrintScreen}
return
mPrintScreenAll:
	SendInput,{PrintScreen}
return
mPrintScreenActive:
	SendInput,!{PrintScreen}
return
mRecordingScreen:
	SendInput,+{PrintScreen}
return
mRecordingScreenGif:
	SendInput,^+{PrintScreen}
return
; 用法：选中文字，按两次Ctrl+C翻译或搜索或加解密
; 热键：Ctrl+C, Ctrl+C 
; 快捷键位置在TrayMenu.ahk
;--------------------------------------------------
DoublePress() ; Simulate double press
{
   static pressed1 = 0
   if pressed1 and A_TimeSincePriorHotkey <= 300
   {
      pressed1 = 0
      ;Translate("en","ru") ; from English to Russian
    ;   keyword=%Clipboard%
    ;   ToolTip % GoogleTranslate(keyword)
        Menu, MyMenu, Add, (&G) %_searchGoogle%, mGoogle
        Menu, MyMenu, Add, (&D) %_searchDogeDoge%, mDogeDoge
		Menu, MyMenu, Add, (&T) %_googleTranslate%, mGoogleTranslate
        ; Menu, MyMenu, Add, (&T) %_googleTranslateCn%, mGoogleTranslateCn
		; Menu, MyMenu, Add, (&T) %_googleTranslateEn%, mGoogleTranslateEn
		Menu, MyMenu, Add, (&T) 智能处理, mSmartSearch
        ; Menu, MyMenu, Add  ; 添加分隔线.
        Menu, MyMenu, Add, (&B) %_Base64En%, mBase64En
        Menu, MyMenu, Add, (&B) %_Base64De%, mBase64De
		Menu, MyMenu, Add, (&B) %_QR%, mGenQR
        ; Menu, Submenu1, Add, Item2, MenuHandler
        ; Menu, MyMenu, Add, My Submenu, :Submenu1
        ; Menu, MyMenu, Add  ; 在子菜单下添加分隔线.
        ; Menu, MyMenu, Add, Item3, MenuHandler  ; 在子菜单下添加另一个菜单项.
        Menu, MyMenu, Show
        return

   }
   else
      pressed1 = 1
}

mGoogleTranslateCn:
    keyword=%Clipboard%
	ToolTipFont("s12","Microsoft YaHei")
    ToolTipColor("053445", "40A1EC")
    ToolTip % GoogleTranslate(keyword)
return

mGoogleTranslateEn:
    keyword=%Clipboard%
	ToolTipFont("s12","Microsoft YaHei")
    ToolTipColor("053445", "40A1EC")
    ToolTip % GoogleTranslate(keyword,from := "auto", to :=0409)
return

mDogeDoge:
    keyword=%Clipboard%
    DogeDoge(keyword)
return

mGoogle:
    keyword=%Clipboard%
    Google(keyword)
return

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

mSmartSearch:
	;智能处理
	;自动打开网址
	;自动打路径
	txt = %Clipboard%
	Loop, parse, txt, `n, `r
	{
		S_LoopField=%A_LoopField%
		if (RegExMatch(S_LoopField,"iS)^([\w-]+://?|www[.]).*"))
		{
			run, S_LoopField
			return
		}
		if (RegExMatch(S_LoopField,"S)^(\\\\|.:\\)"))
		{
			If ProcessExist("TOTALCMD.exe")
			{
				run,"%TCPath%" /T /O /S /L= "%A_LoopField%"
				return
			}else{
				Run, % "explorer /select, " S_LoopField
				return
			}
			return
		}
	}
return

mGoogleTranslate:
	;选中文本
	txt = %Clipboard%
	; 判断如果是中文就翻译成英文
	Loop, parse, txt, `n, `r
	{
		S_LoopField=%A_LoopField%
		if (RegExMatch(S_LoopField,"[^\x00-\xff]+"))
		{
			; MsgBox, 中文
			ToolTipFont("s12","Microsoft YaHei")
			ToolTipColor("053445", "40A1EC")
			ToolTip % GoogleTranslate(S_LoopField,from := "auto", to :=0409)
			return
		}
		; ; 判断如果是英文就翻译成中文
		if (RegExMatch(S_LoopField,"^[A-Za-z]+"))
		{
			ToolTipFont("s12","Microsoft YaHei")
			ToolTipColor("053445", "40A1EC")
			ToolTip % GoogleTranslate(S_LoopField)
			return
		}

		; if (RegExMatch(S_LoopField,"iS)^([\w-]+://?|www[.]).*"))
		; {
		; 	MsgBox, 打开网址
		; 	return
		; }
		; if (RegExMatch(S_LoopField,"S)^(\\\\|.:\\)"))
		; {
		; 	MsgBox, 打开目录
		; 	return
		; }
	}

	; if (RegExMatch(txt,"^\d{6,10}\s*$")=1)
	; run,https://search.jd.com/Search?keyword=%txt%
	; else 
	; if (RegExMatch(txt,"[a-zA-z]+://[^\s]*")=0)
	; 	Run  https://www.baidu.com/s?wd=%txt%
	; else
	; {
	; 	while (p := RegExMatch(txt, "[a-zA-z]+://[^\s]*", m, p?p+StrLen(m):1))
	; 	{
	; 		Run % "D:\Program\GoogleChrome\App\chrome.exe" " " m
	; 	}
	; }
return
;--------------------------------------------------

; #常用浏览器设置
#If WinActive("ahk_group group_browser")
{
	F1::SendInput,^t
    F2::send,{Blind}^+{Tab}
    F3::send,{Blind}^{Tab}
    F4::SendInput,^w
    ~LButton & RButton::send ^w
}