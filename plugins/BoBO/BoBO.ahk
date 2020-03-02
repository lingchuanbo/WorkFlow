BoBO:
; 全局控制
; ################# `相关 #################
; `剪贴复制粘贴删除
` & 1:: SendInput,^x
` & 2:: SendInput,^c
` & 3:: SendInput,^v
` & 4:: SendInput,{Del}
+`::SendInput,~
`::SendInput,``
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
    Tab & q::SendInput,{Blind}{PgUp}
    Tab & f::SendInput,{Blind}{PgDn}

    Tab & 1::SendInput,send,#1
    Tab & 2::SendInput,send,#2
    Tab & 3::SendInput,send,#3
    Tab & 4::SendInput,send,#4
    Tab & 5::SendInput,send,#5

    Tab & r::SendInput,{Blind}{Del}
    Tab & e::SendInput,{Blind}{Enter}send,send,send,send,
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
#If 

Sub_KeyClick:
{
	t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, tappedkey, %t%
    if (t == "off")
    goto double
    return
    tappedkey:
        {
            KeyClickAction(GV_KeyClickAction1)
            return
        }
    return

    double:
        {
            KeyClickAction(GV_KeyClickAction2)
            return
        }
return
}

; 用法：ctrl+a ctrl+a+a
; 截图/录制/Gif
~^!a:: Gosub,<ShareX_PrintScreen>

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
			Menu, ShareX, Add, (&G) 录制GIF, mRecordingScreenGif
			Menu, ShareX, Add, (&G) 录制GIF>>ScreenToGif, mRecordingScreenGif2
			; 需要设置ScreenToGif快捷方式为Ctrl+Alt+PrintScreen
			Menu, ShareX, Show
            return
        }
    return
}


; 用法：选中文字，按两次Ctrl+C翻译或搜索或加解密
; 热键：Ctrl+C+C
; 辅助菜单增强

;--------------------------------------------------
~^c:: MenuPlugins()

MenuPlugins() ; Simulate double press
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
	return
}

; 功能：软件启动器	
; 热键：Win+右键						
#RButton::Gosub,<BoBO_PopSel>
<BoBO_PopSel>:
{
    run %A_ScriptDir%\custom\apps\Popsel\PopSel.exe /n
	return
;    run %A_ScriptDir%\custom\apps\Popsel\PopSel.exe /pc /n ;带图标
}

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
    run %A_ScriptDir%\custom\apps\TaskSwch\TaskMuEx.exe /n
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
;##########程序便捷.社交##########大部份参考EZ
; Tim
#If WinActive("ahk_class TXGuiFoundation") and WinActive("ahk_exe Tim.exe")
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
; run, http://www.baidu.com/s?wd=%Keywords% 
run, https://www.dogedoge.com/results?q=%Keywords%
return
#IfWinActive

#IfWinActive ahk_exe PanDownload.exe
{
	!w::run,"%TCPath%" /T /O /S /L="D:\Download"
}

; 常用浏览器设置
#If WinActive("ahk_group group_browser")
{
	F1::SendInput,^t
    F2::send,{Blind}^+{Tab}
    F3::send,{Blind}^{Tab}
    F4::SendInput,^w
    ~LButton & RButton::send ^w
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

	F1::
		ActiveDocumentFile := ComObjActive("Word.Application").ActiveDocument.FullName
		Run, % "explorer /select, " ActiveDocumentFile
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
#If WinActive("ahk_exe 3dsmax.exe")
{
	
	!w::runMaxScript("maxToTotalcmd.ms")
	; +RButton::Gosub,menuAe
	` & 1:: Gosub, <3DsMax_getUp>
    ` & 2:: Gosub, <3DsMax_getDown>
    ` & 3:: Gosub, <3DsMax_Key>

	return
}

#If WinActive("ahk_exe blender.exe")
{
	; BlenderCursorRepeat := 10
	; ; Clear screen in console
	; ^k::Send {Blind}{LCtrl Down}{LControl Up}

	; ; Delete one char to the right of cursor
	; ^d::Send {Delete}

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

#If WinActive("ahk_exe AfterFX.exe")
{	
	;;快速打开文件所在位置
	;;AE快速打开文件所在位置 至于是否启用TC到时候在考虑目前可以一直按alt+w
	^+!LButton::getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
	;;快速打开渲染文件所在位置
	^+LButton::AeOpenLocalFilesRender()
	;;便捷菜单
	+RButton::Gosub,menuAe
	; !q::
	IfWinActive ahk_class VCSDK_WINDOW_CLASS
		sleep 100
		CoordWinClick(56,22)
	return
}

; #If WinActive("ahk_class VCSDK_WINDOW_CLASS") and WinActive("ahk_exe AfterFX.exe")
; {
; 	;;配合fx console 前提得自定义快捷键为Alt+q
;     !q::CoordWinClick(56,22)
; }

menuAe:
	dirMenu0=%A_ScriptDir%\custom\ae_scripts\Effect
	dirMenu1=%A_ScriptDir%\custom\ae_scripts\otherScriptCommand\
	dirMenu2=%A_ScriptDir%\custom\ae_scripts\PresetAnimation
    menu, thismenu, add, AE动态脚本菜单, WHATSUP
	menu_fromfiles("filelist0", "(&S)_特效库", "RunAePreset0", dirMenu0, "*.ffx", "thismenu", 1)
	menu_fromfiles("filelist1", "(&S)_脚本库", "RunAeScript", dirMenu1, "*.jsx", "thismenu", 1)
	menu_fromfiles("filelist2", "(&P)_预设", "RunAePreset1", dirMenu2, "*.ffx", "thismenu", 1)
	menu, thismenu, add, (&F)_文件所在位置, OpenLocalFiles
	menu, thismenu, add, (&R)_文件所在位置【渲染】, OpenLocalFilesRender
    Menu, thismenu, Show
return 

WHATSUP:
    msgbox, 特效库目录 `n`n %dirMenu0% `n`n 脚本库目录 `n`n %dirMenu1% `n`n 预设目录 `n`n %dirMenu2%
RETURN
OpenLocalFiles:
{
	getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
	return
}

OpenLocalFilesRender:
{
	AeOpenLocalFilesRender()
	return
}

RunAeScript:
    curpath := menu_itempath("filelist1", dirMenu1)
	WinActivate, ahk_exe AfterFX.exe
    global AeExePath := ini.BOBOPath_Config.AEPath
    RunWait, %AeExePath% -s -r %curpath%,,Hide
    return
RETURN
; AE预设库
RunAePreset0:
    curpath := menu_itempath("filelist0", dirMenu0)
	setPath:=StrReplace(curpath,"\", "/")
    setPreset=%dirMenu0%\setPreset.jsx

    FileDelete, %setPreset% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
var	myPreset=File("%setPath%")
var activeItem = app.project.activeItem;
if (activeItem instanceof CompItem) {
    var selectedLayers = activeItem.selectedLayers;
    var numSelectedLayers = selectedLayers.length;
    if (numSelectedLayers >= 1) {
        for (var i = 0; i < numSelectedLayers; i += 1) {
          var layer = app.project.activeItem.selectedLayers[0];
          layer.applyPreset(myPreset);
        }
    } else {
        alert("请选择一个或多个图层.", "BoBO提示你");
    }
}
    ), %dirMenu0%\setPreset.jsx,UTF-8

	sleep 50
	WinActivate, ahk_exe AfterFX.exe
	global AeExePath := ini.BOBOPath_Config.AEPath
    RunWait, %AeExePath% -s -r %setPreset%,,Hide
	sleep 50
	FileDelete, %setPreset% ;避免重复删除文件
    return
RETURN
RunAePreset1:
    curpath := menu_itempath("filelist2", dirMenu2)
	setPath:=StrReplace(curpath,"\", "/")
    setPreset=%dirMenu2%\setPreset.jsx

    FileDelete, %setPreset% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
var	myPreset=File("%setPath%")
var activeItem = app.project.activeItem;
if (activeItem instanceof CompItem) {
    var selectedLayers = activeItem.selectedLayers;
    var numSelectedLayers = selectedLayers.length;
    if (numSelectedLayers >= 1) {
        for (var i = 0; i < numSelectedLayers; i += 1) {
          var layer = app.project.activeItem.selectedLayers[0];
          layer.applyPreset(myPreset);
        }
    } else {
        alert("请选择一个或多个图层.", "BoBO提示你");
    }
}
    ), %dirMenu2%\setPreset.jsx,UTF-8

	sleep 50
	WinActivate, ahk_exe AfterFX.exe
	global AeExePath := ini.BOBOPath_Config.AEPath
    RunWait, %AeExePath% -s -r %setPreset%,,Hide
	sleep 50
	FileDelete, %setPreset% ;避免重复删除文件
    return
RETURN

AeOpenLocalFilesRender()
{
    If ProcessExist("TOTALCMD.exe"){
        getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFilesRenderTC.jsx")
		return
    }else{
        getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFilesRender.jsx")
		sleep,1000
		SendInput,{Enter}
		return
    }
}


#If WinActive("ahk_exe Photoshop.exe")
{	
	` & 1:: Gosub, <PS_透明度减>
	` & 2:: Gosub, <PS_透明度加>
	return
}

<TcPostMsg>:
Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_FocusTrg`)"
Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_OpenNewTab`)"
Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_FocusTrg`)"
Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_MatchSrc`)"
Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_CloseCurrentTab`)"
Run "%TCDirPath%\Tools\TCFS2\TCFS2.exe" /ef "tem(`cm_FocusTrg`)"
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



; mPandaOCR:
;     ; ExePath := ini.BOBOPath_Config.AEPath
;     ; tClass := ini.ahk_class_Config.AEClass
;     FunBoBO_RunActivation(ExePath:="F:\BoBOProgram\PandaOCR\PandaOCR.exe",tClass:="WTWindow")
; 		sleep 2000
; 		Send,{F4}
; 		return
; return
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
mRecordingScreenGif2:
	Run,%A_ScriptDir%\tools\ShareX\ScreenToGif.exe
	sleep 300
	SendInput,^!{PrintScreen}
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


