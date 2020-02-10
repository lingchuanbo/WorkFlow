;定义启动1
FunBoBO_HideOrActivation1(ExePath,tClass) {
	IfWinNotExist,ahk_class %tClass%
	Run,"%ExePath%"
	IfWinActive
	WinMinimize
	else
	WinActivate
	return
}
;定义启动2
FunBoBO_HideOrActivation2(ExePath,tClass) {
    DetectHiddenWindows, on
    IfWinNotExist %ExePath% %tClass%
    { 
   		Run %ExePath% ;
    	WinActivate 
    } 
    	Else IfWinNotActive ahk_class %tClass%
    { 
    	WinActivate
    } 
    Else 
    { 
        WinMinimize 
    } 
}
FunBoBO_RunActivation(ExePath,tClass){
    IfWinExist, AHK_CLASS %tClass%
    {
        WinGet, AC, MinMax, AHK_CLASS %tClass%
        if Ac = -1
            Winactivate, AHK_ClASS %tClass%
        else
            Ifwinnotactive, AHK_CLASS %tClass%
                Winactivate, AHK_CLASS %tClass%
            else
                Winminimize, AHK_CLASS %tClass%
    }
    else
    {
        Run, %ExePath%
        Loop, 4
        {
            IfWinNotActive, AHK_CLASS %tClass%
                WinActivate, AHK_CLASS %tClass%               
            else
                Break
            Sleep, 500
        }
} 
}
;显示函数---------------------------------------
FunBoBO_VimShow(){
    run,%A_ScriptDir%\apps\HuntAniidPeck\hap.exe /hint
    return
}
FunBoBO_ShowLayout(img){
	;ShowLayout:
		Gui,ShowLayout:Add,pic,Center,%A_ScriptDir%\ui\%img% 
		Gui,ShowLayout:+LastFound +AlwaysOnTop -Caption ; +ToolWindow -DPIScale
		Gui,ShowLayout:Show,Center NoActivate
        WinSet, Transparent, 250
		;WinSet, TransColor,f0f0f0 ;去掉灰色边框
	Return
}
;隐藏
FunBoBO_HideLayout(){
	;HideLayout:
	Gui,ShowLayout:Hide
	return
}
;显示图片函数结束---------------------------------------


;无视输入法状态发送字符串
;其实还有一种方法，就是把字符串赋值给粘贴板，然后粘贴
uStr(str)
{
    charList:=StrSplit(str)
	SetFormat, integer, hex
    for key,val in charList
    out.="{U+ " . ord(val) . "}"
	return out
}
isExplorerLike() {
	; Windows Explorer or Desktop
	return FunBoBO_Explorer_GetPath()
}
ActiveFolderPath()
{
	return PathCreateFromURL(ExplorerPath(WinExist("A")))
}
ExplorerPath(_hwnd)
{
	for Item in ComObjCreate("Shell.Application").Windows
		if (Item.hwnd = _hwnd)
			return, Item.LocationURL
}
PathCreateFromURL(URL)
{
	VarSetCapacity(fPath, Sz := 2084, 0)
	DllCall("shlwapi\PathCreateFromUrl" (A_IsUnicode ? "W" : "A" ), Str, URL, Str, fPath, UIntP,Sz, UInt, 0)
	return fPath
}
;获取当前目录
FunBoBO_CustomFunc_getCurrentDir(ByRef CurWinClass="")
{
    if CurWinClass=
    {
        WinGetClass, CurWinClass, A
        sleep 50
    }
    ;获取当前目录
    ;CurWinClass:=QZData("winclass") ;将获取的class名赋值给用户变量
    ;Curhwnd:=QZData("hWnd")
    if CurWinClass in ExploreWClass,CabinetWClass ;如果当前激活窗口为资源管理器
    {
        DirectionDir:=FunBoBO_Explorer_GetSelected(Curhwnd)
        IfInString,DirectionDir,`;		;我的电脑、回收站、控制面板等退出
            return
    }
    if CurWinClass in WorkerW,Progman    ;如果当前激活窗口为桌面
    {
        DirectionDir:=FunBoBO_Explorer_GetSelected(Curhwnd)
    }
    if (CurWinClass="Shell_TrayWnd") ;如果当前激活窗口为任务栏
        DirectionDir:=""

    if CurWinClass in TTOTAL_CMD ;如果当前激活窗口为TC
    {
        IfWinNotActive ahk_class TTOTAL_CMD
        {
            Postmessage, 1075, 2015, 0,, ahk_class TTOTAL_CMD	;最大化
            WinWait,ahk_class TTOTAL_CMD
            WinActivate
        }
        Postmessage, 1075, 332, 0,, ahk_class TTOTAL_CMD	;光标定位到焦点地址栏
        sleep 300
        ;PostMessage,1075,2029,0,,ahk_class TTOTAL_CMD ;获取路径
        PostMessage,1075,2018,0,,ahk_class TTOTAL_CMD ;获取路径2
        sleep 100
        DirectionDir:=Clipboard
    }
    If(DirectionDir="ERROR")		;错误则退出
        DirectionDir:=""
    
    return DirectionDir
}

FunBoBO_Explorer_GetPath(hwnd="")
{
	if !(window := FunBoBO_Explorer_GetWindow(hwnd))
		return ErrorLevel := "ERROR"
	if (window="desktop")
		return A_Desktop
	path := window.LocationURL
	path := RegExReplace(path, "ftp://.*@","ftp://")
	StringReplace, path, path, file:///
	StringReplace, path, path, /, \, All
	loop
		if RegExMatch(path, "i)(?<=%)[\da-f]{1,2}", hex)
			StringReplace, path, path, `%%hex%, % Chr("0x" . hex), All
		else break
	return path
}

FunBoBO_Explorer_GetWindow(hwnd="")
{
	WinGet, Process, ProcessName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")
	WinGetClass class, ahk_id %hwnd%

	if (Process!="explorer.exe")
		return
	if (class ~= "(Cabinet|Explore)WClass")
	{
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				return window
	}
	else if (class ~= "Progman|WorkerW")
		return "desktop" ; desktop found
}

FunBoBO_Explorer_GetSelected(hwnd="")  
{  
    return FunBoBO_Explorer_Get(hwnd,true)  
}  

FunBoBO_Explorer_Get(hwnd="",selection=false)  
{  
    if !(window := FunBoBO_Explorer_GetWindow(hwnd))  
        return ErrorLevel := "ERROR"  
    if (window="desktop")  
    {  
        ControlGet, hwWindow, HWND,, SysListView321, ahk_class Progman  
        if !hwWindow ; #D mode  
            ControlGet, hwWindow, HWND,, SysListView321, A  
        ControlGet, files, List, % ( selection ? "Selected":"") "Col1",,ahk_id %hwWindow%  
        base := SubStr(A_Desktop,0,1)=="\" ? SubStr(A_Desktop,1,-1) : A_Desktop  
        Loop, Parse, files, `n, `r  
        {  
            path := base "\" A_LoopField  
            IfExist %path% ; ignore special icons like Computer (at least for now)  
                ret .= path "`n"  
        }  
    }  
    else  
    {  
        if selection  
            collection := window.document.SelectedItems  
        else  
            collection := window.document.Folder.Items  
        for item in collection  
            ret .= item.path "`n"  
    }  
    return Trim(ret,"`n")  
}  

;   AeScriptFunction调用Ae脚本文件_ByBoBO
;   使用方式
;   getAeScript("路径")
;   文件放置位置必须在本脚本目录下
getAeScript(AeScriptPath){

    WinActivate, ahk_exe AfterFX.exe

    global AeExePath := ini.BOBOPath_Config.AEPath

    RunWait, %AeExePath% -s -r %A_ScriptDir%\%AeScriptPath%,,Hide

    WinActivate, ahk_exe AfterFX.exe

    return
}

;   AeScriptFunction直接调用指令_ByBoBO
;   使用方式
;   getAeScript("指令")
;   文件放置位置必须在本脚本目录下

getAeScriptCommand(AeScriptCommand){

    WinActivate, ahk_exe AfterFX.exe

    global AeExePath := ini.BOBOPath_Config.AEPath

    RunWait, %AeExePath% -s -r %AeScriptCommand%,,Hide

    WinActivate, ahk_exe AfterFX.exe

    return
}


; runMax(runPath){
;     ;tempStr := "filein """ . A_LoopFileFullPath . """"
;     runPath = %A_ScriptDir%\custom\maxScripts\initialize_COM_server.ms
;     tempStr := "filein """ . %runPath% . """"
;     StringReplace, tempStr, tempStr, `\, `\`\, ALL
;     Control, EditPaste, %tempStr%, MXS_Scintilla2, A
;     ControlSend, MXS_Scintilla2, {NumpadEnter}, A
;     return
; }

;;运行3DsMaxScript函数1
;;用法 runMaxScriptCommands("脚本名字.ms")
;;两者区别 目录不一致
runMaxScriptCommands(MaxScriptPath){
    run, %A_ScriptDir%\custom\maxScripts\MXSPyCOM.exe -f %A_ScriptDir%\custom\maxScripts\commands\%MaxScriptPath%
    return
}

;;运行3DsMaxScript函数2
;;用法 runMaxScript("脚本名字.ms")
;;两者区别 目录不一致
runMaxScript(MaxScriptPath){
    run, %A_ScriptDir%\custom\maxScripts\MXSPyCOM.exe -f %A_ScriptDir%\custom\maxScripts\%MaxScriptPath%
    return
}

;;直接运行3DsMax函数
; 用法
;     runPath = startObjectCreation box 创建对象
;     runMaxScriptTxt(runPath)
runMaxScriptTxt(runPath){ ;*[WorkFlow]
    ControlFocus, MXS_Scintilla2
    ControlSetText, MXS_Scintilla2, %runPath%
    send, +{Enter}
    Click 1
    Return
}

;;测试运行函数
; get2MaxScript(runPath){
;     ;tempStr := "filein """ . A_LoopFileFullPath . """"
;     ;runPath = %A_ScriptDir%\custom\maxScripts\initialize_COM_server.ms
;     tempStr := "filein """ . %runPath% . """"
;     StringReplace, tempStr, tempStr, `\, `\`\, ALL
;     Control, EditPaste, %tempStr%, MXS_Scintilla2, A
;     ControlSend, MXS_Scintilla2, {NumpadEnter}, A
;     return
; }




;;Photoshop运行函数
runPsScript(PsPath){
    app:=ComObjCreate("Photoshop.Application")
    app.DoJavaScriptFile(%PsPath%)
    return
}

; 运行自定义标题
FunBoBO_RunActivationTitle(ExePath,tClass,NewTitle){
    IfWinExist, AHK_CLASS %tClass%
    {
        WinGet, AC, MinMax, AHK_CLASS %tClass%
        if Ac = -1
            Winactivate, AHK_ClASS %tClass%

        else
                Ifwinnotactive, AHK_CLASS %tClass%
                Winactivate, AHK_CLASS %tClass%
            else
                Winminimize, AHK_CLASS %tClass%
    }
    else
    {
        Run, %ExePath%
        Loop, 4
        {
            IfWinNotActive, AHK_CLASS %tClass%
                WinActivate, AHK_CLASS %tClass%        
            else
                Break
            Sleep, 500
        }
    } 

    SetTitleMatchMode, regex

    IfWinExist, ahk_class %tClass%,,2
    WinSetTitle, %NewTitle% ; %N_Title%

return
}

Morse(timeout = 400) {
   tout := timeout/1000
   key := RegExReplace(A_ThisHotKey,"[\*\~\$\#\+\!\^]")
   Loop {
      t := A_TickCount
      KeyWait %key%
      Pattern .= A_TickCount-t > timeout
      KeyWait %key%,DT%tout%
      If (ErrorLevel)
         Return Pattern
   }
}

; setZH(){
; 		; PostMessage, 0x50, 0, 0x8040804, , A
; 		if !IME_GET0E1C()
;         PostMessage, 0x50, 0, 0x8040804, , A
; 			; SendInput, {LShift}
; 		return
; }
; setEN(){
;         ; PostMessage, 0x50, 0, 0x4090409, , A ;切换为英文 0x4090409=67699721
;         if IME_GET0E1C()
;         PostMessage, 0x50, 0, 0x4090409, , A ;切换为英文 0x4090409=67699721
;             ; SendInput, {LShift}
; return
; }

IME_GET0E1C(WinTitle="A"){			;借鉴了某日本人脚本中的获取输入法状态的内容,减少了不必要的切换,切换更流畅了
    ;~ ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

varExist(ByRef v) { ; 检测变量是否存在
   return &v = &n ? 0 : v = "" ? 2 : 1 
}

ProcessExist(Name){ ; 检测进程
Process,Exist,%Name%
return Errorlevel
}


; 单双长按函数
analyseKeyPress(comboKeyName="",doubleKeySpeed=0.15,longKeyPressTime=0.3){ ;
   ;Param1:Other Key to make combo; similaire to "&"
   ;Param2:Maximum seconds to execute the doubleKey otherWise it will be a singleKey, Put 0 "zero" if you want direct interaction
   ;Param3:Time(in seconds) you must keep the key down to generate a long Key event
   ;return: 0 to 6
   ;0=Long Press of more then 500 miliseconds
   ;1=single Key 
   ;2=doubleKey
   ;3=long key
   ;4=combo Single Key
   ;5=combo double Key
   ;6=combo long Key
   ;https://autohotkey.com/board/topic/55314-double-keylong-key-press-combo-double-key/
      static diff:=0
      GetKeyState,comboKeyState,%comboKeyName%,P
      ifEqual,comboKeyState,D,hotkey,%comboKeyName%,disableComboKeyHotkey
      
     diff-=a_tickCount
     ifGreater,diff,-550,keywait, %A_thisHotkey%
     ifGreater,diff,-550,return 0
     diff:=a_tickCount
      
      keywait, %A_thisHotkey%,t%longKeyPressTime%
      if errorLevel{
         ifEqual,comboKeyState,D,setEnv,KeyPress,6   ;combo Long Key
         else setEnv,KeyPress,3                  ;long key
      }else{
         keywait, %A_thisHotkey%, d t%doubleKeySpeed%
         if errorLevel{
            ifEqual,comboKeyState,D,setEnv,KeyPress,4   ;combo single Key
            else setEnv,KeyPress,1                  ;Single key
         }else{
            ifEqual,comboKeyState,D,setEnv,KeyPress,5   ;combo double Key
            else setEnv,KeyPress,2                  ;double key
         }
      }
      ifEqual,comboKeyState,D,hotkey,%comboKeyName%,%comboKeyName%
      return %keyPress%
   }
   disableComboKeyHotKey:
      return
   Return ;;66

; 单双长按函数2
analyseKeyPressDouble(){

    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_F12, %t%
    if (t == "off")
    goto ae_double_F12
    return %KeyPress%
    ae_tappedkey_F12:
        {
            KeyPress:= 1

        }
    return

    ae_double_F12:
        {
            KeyPress:= 2
        }

}


/*
[script info]
description = double tap function to send a hotkey or label
author      = davebrny
source      = https://gist.github.com/davebrny/383ab4158e4220f5658223475ad57719
*/

double_tap(single_tap, double_tap, tap_time="T.2") {
    key := LTrim(a_thisHotkey, "~$*")
    key := regExReplace(key, "[\Q^!+#\E]")   ; remove modifiers
    keyWait, % key
    keyWait, % key, D %tap_time%
    if (errorLevel)
         sub_send(single_tap)
    else sub_send(double_tap)
}

sub_send(action) {
    if isLabel(action)
        goSub, % action
    else send, % action
}

GetClickType(double=250,hold=500)	; by Learning one
{
	;Return values: "1" single click, "2" double click, "3" holding key down
	Hotkey := RegExReplace(A_ThisHotkey,"^(\w* & |\W)"), hold /= 1000, double /= 1000
	KeyWait, %Hotkey%, t%hold%
	if ErrorLevel
	return 3
	KeyWait, %Hotkey%, d t%double%
	return (ErrorLevel) ? 1 : 2
}

; Example:
; RButton::MsgBox,,, % GetClickType(),1

; Beautiful popup msg, tooltip美化提示
; To Create PleasantNotification
; PleasantNotify(Title, Messages, width, height, position, time)
; Title - you can use variable, else must be String
; Messages - same as Title
; width - GUI width for PleasantNotify, if omited 700
; height - GUI height for PleasantNotify, if omitted 300
; position - GUI postion for PleasantNotify, it omitted bottom right corner

; position argument syntax is to create a string with the following:
; t=top, vc= vertical center, b=bottom
; l=left, hc=horizontal center, r=right
;https://www.autohotkey.com/boards/viewtopic.php?t=6056
PleasantNotify(title, message, pnW=700, pnH=300, position="b r", time=10) {
    global pn_title, pn_msg, PN_hwnd, w, h
	Notify_Destroy()
	Gui, Notify: +AlwaysOnTop +ToolWindow -SysMenu -Caption +LastFound
	PN_hwnd := WinExist()
	WinSet, ExStyle, +0x20
	WinSet, Transparent, 0
	Gui, Notify: Color, 0xF2F2F0
	Gui, Notify: Font, c0x07D82F s18 wBold, Segoe UI
	Gui, Notify: Add, Text, % " x" 20 " y" 12 " w" pnW-20 " vpn_title", % title
	Gui, Notify: Font, cBlack s15 wRegular
	Gui, Notify: Add, Text, % " x" 20 " y" 56 " w" pnW-20 " h" pnH-56 " vpn_msg", % message
	RealW := pnW + 50
	RealH := pnH + 20
	Gui, Notify: Show, W%RealW% H%RealH% NoActivate
	WinMove(PN_hwnd, position)
	if A_ScreenDPI = 96
		WinSet, Region,0-0 w%pnW% h%pnH% R40-40,%A_ScriptName%
	/* For Screen text size 125%
	if A_ScreenDPI = 120
		WinSet, Region, 0-0 w800 h230 R40-40, %A_ScriptName%
	*/
	winfade("ahk_id " PN_hwnd,210,5)
	if (time <> "P")
	{
		Closetick := time*1000
		SetTimer, ByeNotify, % Closetick
	}
}

Notify_Destroy() {
	global PN_hwnd
	ByeNotify:
	SetTimer, ByeNotify, Off
    winfade("ahk_id " PN_hwnd,0,5)
    Gui, Notify: Destroy
	return
}

pn_mod_title(title) {
	global pn_title
	GuiControl, Notify: Text,pn_title, % title
}

pn_mod_msg(message) {
	global pn_msg
	GuiControl, Notify: Text,pn_msg, % message
}

WinMove(hwnd,position) {
   SysGet, Mon, MonitorWorkArea
   WinGetPos,ix,iy,w,h, ahk_id %hwnd%
   x := InStr(position,"l") ? MonLeft : InStr(position,"hc") ?  (MonRight-w)/2 : InStr(position,"r") ? MonRight - w : ix
   y := InStr(position,"t") ? MonTop : InStr(position,"vc") ?  (MonBottom-h)/2 : InStr(position,"b") ? MonBottom - h : iy
   WinMove, ahk_id %hwnd%,,x,y
}

winfade(w:="",t:=128,i:=1,d:=10) {
    w:=(w="")?("ahk_id " WinActive("A")):w
    t:=(t>255)?255:(t<0)?0:t
    WinGet,s,Transparent,%w%
    s:=(s="")?255:s ;prevent trans unset bug
    WinSet,Transparent,%s%,%w%
    i:=(s<t)?abs(i):-1*abs(i)
    while(k:=(i<0)?(s>t):(s<t)&&WinExist(w)) {
        WinGet,s,Transparent,%w%
        s+=i
        WinSet,Transparent,%s%,%w%
        sleep %d%
    }
}


; 获取Total Commander路径
getTcFolder()
{
	;需要运行Total Commander
    ClipSaved := ClipboardAll 
    clipboard =
    SendMessage 1075, 2029, 0, , ahk_class TTOTAL_CMD ;2029 复制来源路径
    ClipWait,2 
    OutDir=%clipboard%
    Clipboard := ClipSaved 
    ClipSaved = 
    return OutDir
}

;获取Explore当前路径 WinGet, hWnd , Id, A
getExploreFolder(hWnd=0)
{
	If   hWnd || (hWnd :=   WinExist("ahk_class (?:Cabinet|Explore)WClass"))
   {
      For window in ComObjCreate("Shell.Application").Windows
         doc :=   window.Document
      Until   (window.hWnd = hWnd)
	}
      
      sFolder :=   doc.folder.self.path,
      ;~ MsgBox %sFolder%  ;获取forlder
      Return   sFolder
}

;标题路径Explorer打开
SaveFileFindForExplorer(){
    MouseGetPos, , , id, control
    WinGetTitle, title, ahk_id %id%
    getPath=%title%
    RegExMatch(getPath,"(\\|.:\\).*\\",newPath)
    Run % "explorer.exe /select," newPath
    IfWinExist, AHK_CLASS CabinetWClass
    {
        sleep 1000
        send {Enter}
        return
    }
    else
    {
        MsgBox "NoNoNO!"
        }
    return
}
;标题路径TC打开
SaveFileFindForTc(){	
	MouseGetPos, , , id, control
	WinGetTitle, title, ahk_id %id%
    TCPath := ini.TotalCommander_Config.TCPath
    getPath=%title%
    appName:=RegExMatch(getPath,"(\\|.:\\).*\\",candysel)
    ; Run "%TCPath%" /T /O /A /R="%candysel%"
    TC_OpenPath(candysel, newTab, "/L")
    return
}
CustomPlugin_SmartCompress(){
	;~ global   7zip
	;~ global   dir
	;candysel:=QZData("files")
    ; dir:=getTcFolder()
    TCPath := ini.TotalCommander_Config.TCPath
    RegExMatch(TCPath,"(.*\\)",TCPathDir)  ; 提取目录



    candysel := clipboard

;     clipboard:=
;     SendPos(2018)
; MsgBox %candysel%
	ThisProcess := DllCall("GetCurrentProcess")     ;判断系统是多少位 感谢卢霖
	if !DllCall("IsWow64Process", "uint", ThisProcess, "int*", IsWow64Process)
		IsWow64Process := false
	if  %IsWow64Process%=0 ;如果系统是32位
		7zip = %TCPathDir%\Tools\7z\7zG.exe
	else
		7zip = %TCPathDir%\Tools\7z\7zG.exe

	if !InStr(candysel,"`n")  ;若不是多文件则执行下列命令，以所选文件为压缩文件名
	{
		if InStr(FileExist(candysel), "D") ;若为文件夹则执行下来命令
		{
			SplitPath, candysel, name, dir, ext, name_no_ext, Drive
			Loop, %candysel%\* ,1   ;1表示获取文件夹文件夹.
			{
				if A_Index=1
				{
					File=% A_LoopFileFullPath
					continue
				}
				File.= "`r" . "`n" . A_LoopFileFullPath
			}
				FileList := RegExReplace(File, "\r\n", """ """)   ;感谢卢霖
			name_cheack(name,FileList,7zip,dir)
                clipboard :=
;			Run %7zip%  a  "%dir%"\"%name%.7z" "%FileList%"
			return
		}
		else
		{
			SplitPath, candysel, name2, dir, ext, name_no_ext, Drive
;			Run %7zip%  a  "%dir%\%name_no_ext%" "%candysel%"
			name_cheack(name_no_ext,candysel,7zip,dir)
                clipboard :=
			return
		}
	}
	RegExMatch(candysel,"((?!\\)[^\\]+(?=\\[^\\]+\n?$))",m)  ;获取上一级目录的文件名
	Loop,Parse,candysel,`n,`r  ;若为多文件，则执行下列命令,以上一级文件名为压缩文件名
	{
		SplitPath, A_LoopField, name2, dir, ext, name_no_ext, Drive
		if A_Index=1
		{
			File=% A_LoopField
			continue
		}
		File.= "`r" . "`n" . A_LoopField
		;~ FileList.=A_LoopField . """ """
	}
	;~ MsgBox %FileList%
	FileList := RegExReplace(File, "\r\n", """ """)
	Clipboard=%FileList%
;	Run %7zip%  a   "%dir%\%m1%" "%FileList%"
	name_cheack(m1,FileList,7zip,dir)
    clipboard :=
return
}
name_cheack(name,files,7zip,dir){
;name_cheack:
	;~ global   7zip
	;~ global   dir
	IfExist,%dir%\%name%.7z   ;已经存在了以“首层文件夹命名”的文件夹，怎么办？
	{
;	MsgBox %7zip%
		Loop
		{
			FolderName=%dir%\%name%( %A_Index% ).7z
			If !FileExist( FolderName )
			{
				MsgBox %FolderName%
				Run %7zip%  a   "%FolderName%" "%files%"
				break
			}
		}
		return
	}
;	MsgBox %name%
	Run %7zip%  a   "%dir%\%name%.7z" "%files%"
}
; Tc命令函数
TcSendPos(Number)
{
    PostMessage 1075, %Number%, 0, , AHK_CLASS TTOTAL_CMD
}

RemoveToolTip:
ToolTip
return


mouserMove(){
	SetTimer, mouserMoveTest, 500
	return
	mouserMoveTest:
		MouseGetPos,x1,y1
		sleep 100
		MouseGetPos,x2,y2
		If ((x1<>x2) or (y1<>y2))     
			{
			return False
			}
			else
			{
			return True
			}
}


openPathTc(){	
    TCPath := ini.TotalCommander_Config.TCPath
	MouseGetPos, , , id, control
	WinGetTitle, title, ahk_id %id%
	getPath=%title%
	appName:=RegExMatch(getPath,"(\\|.:\\).*\\",candysel)

	tc_open_path:=Explorer_Get()

	candysel=%candysel%  ;去掉首尾空格
	if !candysel			;没有选中文件
	{
		if WinActive("ahk_exe explorer.exe")		;如果当前活动窗口是资管，则用tc打开当前资管所在路径
		{
			tc_Dir := Explorer_GetPath()
			Run "%TCPath%" /T /O /A /R="%tc_Dir%"		;如果没选中，则用tc打开当前资管所在路径
		}
		else
			Run "%TCPath%" /T /O /A /R="%tc_open_path%"		;如果不是资管，则用tc打开程序/文件所在路径
		return
	}
	;~ else if RegExMatch(candysel, "^.:\\\.*")
	if RegExMatch(candysel,"i)\n")		;如果选中的为多文件，则用tc打开父目录，并选中这些文件
	{
		Clipboard:=candysel			;把选中 的文件置入剪切板，方便下面发送消息
		tc_Dir := Explorer_GetPath()
		Run "%TCPath%"  /O /T   /R="%tc_Dir%"
		WinWaitActive,ahk_class TTOTAL_CMD,,10
		Sleep 200
		PostMessage, 1075, 2033, 0, , AHK_CLASS TTOTAL_CMD   ; 从剪贴板导入并选中文件列表
		return
	}
	else
	{
		Run "%TCPath%" /T /O /A /R="%candysel%"
	}
	return
}

openPathExplorer(){
	SendMessage 1074, 21, 0, , ahk_class TTOTAL_CMD
	ControlGetText, varPathInTC, , ahk_id %ErrorLevel%
	StringReplace, this_title, varPathInTC, >, \
    Run, explorer.exe %this_title%
}

openPathEveything(){
    ExePath := ini.BOBOPath_Config.EverythingPath
    ; TCPath := ini.TotalCommander_Config.TCPath
	MouseGetPos, , , id, control
	WinGetTitle, title, ahk_id %id%
	getPath=%title%
	appName:=RegExMatch(getPath,"(\\|.:\\).*\\",candysel)

	tc_open_path:=Explorer_Get()

	candysel=%candysel%  ;去掉首尾空格
	if !candysel			;没有选中文件
	{
		if WinActive("ahk_exe explorer.exe")		;如果当前活动窗口是资管，则用tc打开当前资管所在路径
		{
			tc_Dir := Explorer_GetPath()
			Run "%ExePath%" -p "%tc_Dir%"		;如果没选中，则用tc打开当前资管所在路径
		}
		else
			Run "%ExePath%" -p "%tc_open_path%"		;如果不是资管，则用tc打开程序/文件所在路径
		return
	}
	;~ else if RegExMatch(candysel, "^.:\\\.*")
	if RegExMatch(candysel,"i)\n")		;如果选中的为多文件，则用tc打开父目录，并选中这些文件
	{
		Clipboard:=candysel			;把选中 的文件置入剪切板，方便下面发送消息
		tc_Dir := Explorer_GetPath()
		Run "%TCPath%"  -p %tc_Dir%
		; WinWaitActive,ahk_class TTOTAL_CMD,,10
		; Sleep 200
		; PostMessage, 1075, 2033, 0, , AHK_CLASS TTOTAL_CMD   ; 从剪贴板导入并选中文件列表
		return
	}
	else
	{
        ; run "%TCDirPath%\Tools\Everything\Everything.exe" -p %folder% 
		Run "%ExePath%" -p %candysel%
	}
	return
}

;在窗口内点击坐标
CoordWinClick(x,y){
	CoordMode, Mouse, Relative
	click %x%, %y%
}
;msgbox % fun_GetFormatTime("yyyy-MM-dd-HH-mm-ss")
fun_GetFormatTime(f,t="")
{
	;FormatTime, TimeString, 200504, 'Month Name': MMMM`n'Day Name': dddd
	;FormatTime, TimeString, ,'Month Name': MMMM`n'Day Name': dddd
	FormatTime, TimeString, %t% ,%f%
	return %TimeString%
}

; 谷歌翻译
GoogleTranslate(str, from := "auto", to :=0)  {
   static JS := CreateScriptObj(), _ := JS.( GetJScripObject() ) := JS.("delete ActiveXObject; delete GetObject;")
;  static JS := CreateScriptObj(), _ := JS.( GetJScript() ) := JS.("delete ActiveXObject; delete GetObject;")
   if(!to)				; If no "to" parameter was passed
      to := GetISOLanguageCode()	; Assign the system (OS) language to "to"
   if(from = to)			; If the "from" and "to" parameters are the same
      Return str			; Abort translation and return the original string
   json := SendRequest(JS, str, to, from, proxy := "")
   oJSON := JS.("(" . json . ")")
 
   if !IsObject(oJSON[1])  {
      Loop % oJSON[0].length
         trans .= oJSON[0][A_Index - 1][0]
   }
   else  {
      MainTransText := oJSON[0][0][0]
      Loop % oJSON[1].length  {
         trans .= "`n+"
         obj := oJSON[1][A_Index-1][1]
         Loop % obj.length  {
            txt := obj[A_Index - 1]
            trans .= (MainTransText = txt ? "" : "`n" txt)
         }
      }
   }
   if !IsObject(oJSON[1])
      MainTransText := trans := Trim(trans, ",+`n ")
   else
      trans := MainTransText . "`n+`n" . Trim(trans, ",+`n ")
 
   from := oJSON[2]
   trans := Trim(trans, ",+`n ")
   Return trans
}
 
; Take a 4-digit language code or (if no parameter) the current language code and return the corresponding 2-digit ISO code
GetISOLanguageCode(lang := 0) {
   LanguageCodeArray := { 0436: "af" ; Afrikaans
			, 041c: "sq" ; Albanian
			, 0401: "ar" ; Arabic_Saudi_Arabia
			, 0801: "ar" ; Arabic_Iraq
			, 0c01: "ar" ; Arabic_Egypt
			, 1001: "ar" ; Arabic_Libya
			, 1401: "ar" ; Arabic_Algeria
			, 1801: "ar" ; Arabic_Morocco
			, 1c01: "ar" ; Arabic_Tunisia
			, 2001: "ar" ; Arabic_Oman
			, 2401: "ar" ; Arabic_Yemen
			, 2801: "ar" ; Arabic_Syria
			, 2c01: "ar" ; Arabic_Jordan
			, 3001: "ar" ; Arabic_Lebanon
			, 3401: "ar" ; Arabic_Kuwait
			, 3801: "ar" ; Arabic_UAE
			, 3c01: "ar" ; Arabic_Bahrain
			, 042c: "az" ; Azeri_Latin
			, 082c: "az" ; Azeri_Cyrillic
			, 042d: "eu" ; Basque
			, 0423: "be" ; Belarusian
			, 0402: "bg" ; Bulgarian
			, 0403: "ca" ; Catalan
			, 0404: "zh-CN" ; Chinese_Taiwan
			, 0804: "zh-CN" ; Chinese_PRC
			, 0c04: "zh-CN" ; Chinese_Hong_Kong
			, 1004: "zh-CN" ; Chinese_Singapore
			, 1404: "zh-CN" ; Chinese_Macau
			, 041a: "hr" ; Croatian
			, 0405: "cs" ; Czech
			, 0406: "da" ; Danish
			, 0413: "nl" ; Dutch_Standard
			, 0813: "nl" ; Dutch_Belgian
			, 0409: "en" ; English_United_States
			, 0809: "en" ; English_United_Kingdom
			, 0c09: "en" ; English_Australian
			, 1009: "en" ; English_Canadian
			, 1409: "en" ; English_New_Zealand
			, 1809: "en" ; English_Irish
			, 1c09: "en" ; English_South_Africa
			, 2009: "en" ; English_Jamaica
			, 2409: "en" ; English_Caribbean
			, 2809: "en" ; English_Belize
			, 2c09: "en" ; English_Trinidad
			, 3009: "en" ; English_Zimbabwe
			, 3409: "en" ; English_Philippines
			, 0425: "et" ; Estonian
			, 040b: "fi" ; Finnish
			, 040c: "fr" ; French_Standard
			, 080c: "fr" ; French_Belgian
			, 0c0c: "fr" ; French_Canadian
			, 100c: "fr" ; French_Swiss
			, 140c: "fr" ; French_Luxembourg
			, 180c: "fr" ; French_Monaco
			, 0437: "ka" ; Georgian
			, 0407: "de" ; German_Standard
			, 0807: "de" ; German_Swiss
			, 0c07: "de" ; German_Austrian
			, 1007: "de" ; German_Luxembourg
			, 1407: "de" ; German_Liechtenstein
			, 0408: "el" ; Greek
			, 040d: "iw" ; Hebrew
			, 0439: "hi" ; Hindi
			, 040e: "hu" ; Hungarian
			, 040f: "is" ; Icelandic
			, 0421: "id" ; Indonesian
			, 0410: "it" ; Italian_Standard
			, 0810: "it" ; Italian_Swiss
			, 0411: "ja" ; Japanese
			, 0412: "ko" ; Korean
			, 0426: "lv" ; Latvian
			, 0427: "lt" ; Lithuanian
			, 042f: "mk" ; Macedonian
			, 043e: "ms" ; Malay_Malaysia
			, 083e: "ms" ; Malay_Brunei_Darussalam
			, 0414: "no" ; Norwegian_Bokmal
			, 0814: "no" ; Norwegian_Nynorsk
			, 0415: "pl" ; Polish
			, 0416: "pt" ; Portuguese_Brazilian
			, 0816: "pt" ; Portuguese_Standard
			, 0418: "ro" ; Romanian
			, 0419: "ru" ; Russian
			, 081a: "sr" ; Serbian_Latin
			, 0c1a: "sr" ; Serbian_Cyrillic
			, 041b: "sk" ; Slovak
			, 0424: "sl" ; Slovenian
			, 040a: "es" ; Spanish_Traditional_Sort
			, 080a: "es" ; Spanish_Mexican
			, 0c0a: "es" ; Spanish_Modern_Sort
			, 100a: "es" ; Spanish_Guatemala
			, 140a: "es" ; Spanish_Costa_Rica
			, 180a: "es" ; Spanish_Panama
			, 1c0a: "es" ; Spanish_Dominican_Republic
			, 200a: "es" ; Spanish_Venezuela
			, 240a: "es" ; Spanish_Colombia
			, 280a: "es" ; Spanish_Peru
			, 2c0a: "es" ; Spanish_Argentina
			, 300a: "es" ; Spanish_Ecuador
			, 340a: "es" ; Spanish_Chile
			, 380a: "es" ; Spanish_Uruguay
			, 3c0a: "es" ; Spanish_Paraguay
			, 400a: "es" ; Spanish_Bolivia
			, 440a: "es" ; Spanish_El_Salvador
			, 480a: "es" ; Spanish_Honduras
			, 4c0a: "es" ; Spanish_Nicaragua
			, 500a: "es" ; Spanish_Puerto_Rico
			, 0441: "sw" ; Swahili
			, 041d: "sv" ; Swedish
			, 081d: "sv" ; Swedish_Finland
			, 0449: "ta" ; Tamil
			, 041e: "th" ; Thai
			, 041f: "tr" ; Turkish
			, 0422: "uk" ; Ukrainian
			, 0420: "ur" ; Urdu
			, 042a: "vi"} ; Vietnamese
   If(lang)
     Return LanguageCodeArray[lang]
   Else Return LanguageCodeArray[A_Language]
}
SendRequest(JS, str, tl, sl, proxy) {
   ComObjError(false)
   http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   ( proxy && http.SetProxy(2, proxy) )
   ;~ http.open( "POST", "https://translate.google.com/translate_a/single?client=webapp&sl="
   http.open( "POST", "https://translate.google.cn/translate_a/single?client=webapp&sl="
      . sl . "&tl=" . tl . "&hl=" . tl
      . "&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&otf=0&ssel=0&tsel=0&pc=1&kc=1"
      . "&tk=" . JS.("tk").(str), 1 )
 
   http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
   http.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0")
   http.send("q=" . URIEncode(str))
   http.WaitForResponse(-1)
   Return http.responsetext
}
URIEncode(str, encoding := "UTF-8")  {
   VarSetCapacity(var, StrPut(str, encoding))
   StrPut(str, &var, encoding)
 
   While code := NumGet(Var, A_Index - 1, "UChar")  {
      bool := (code > 0x7F || code < 0x30 || code = 0x3D)
      UrlStr .= bool ? "%" . Format("{:02X}", code) : Chr(code)
   }
   Return UrlStr
}
 
; GetJScript()
; {
;    script =
;    (
;       var TKK = ((function() {
;         var a = 561666268;
;         var b = 1526272306;
;         return 406398 + '.' + (a + b);
;       })());
 
;       function b(a, b) {
;         for (var d = 0; d < b.length - 2; d += 3) {
;             var c = b.charAt(d + 2),
;                 c = "a" <= c ? c.charCodeAt(0) - 87 : Number(c),
;                 c = "+" == b.charAt(d + 1) ? a >>> c : a << c;
;             a = "+" == b.charAt(d) ? a + c & 4294967295 : a ^ c
;         }
;         return a
;       }
 
;       function tk(a) {
;           for (var e = TKK.split("."), h = Number(e[0]) || 0, g = [], d = 0, f = 0; f < a.length; f++) {
;               var c = a.charCodeAt(f);
;               128 > c ? g[d++] = c : (2048 > c ? g[d++] = c >> 6 | 192 : (55296 == (c & 64512) && f + 1 < a.length && 56320 == (a.charCodeAt(f + 1) & 64512) ?
;               (c = 65536 + ((c & 1023) << 10) + (a.charCodeAt(++f) & 1023), g[d++] = c >> 18 | 240,
;               g[d++] = c >> 12 & 63 | 128) : g[d++] = c >> 12 | 224, g[d++] = c >> 6 & 63 | 128), g[d++] = c & 63 | 128)
;           }
;           a = h;
;           for (d = 0; d < g.length; d++) a += g[d], a = b(a, "+-a^+6");
;           a = b(a, "+-3^+b+-f");
;           a ^= Number(e[1]) || 0;
;           0 > a && (a = (a & 2147483647) + 2147483648);
;           a `%= 1E6;
;           return a.toString() + "." + (a ^ h)
;       }
;    )
;    Return script
; }

GetJScripObject()  {   ; Here we create temp file to get a custom COM server using Windows Script Components (WSC) technology.
   VarSetCapacity(tmpFile, ((MAX_PATH := 260) - 14) << !!A_IsUnicode, 0)
   DllCall("GetTempFileName", Str, A_Temp, Str, "AHK", UInt, 0, Str, tmpFile)
   
   FileAppend,
   (
   <component>
   <public><method name='eval'/></public>
   <script language='JScript'></script>
   </component>
   ), % tmpFile
   
   JS := ObjBindMethod( ComObjGet("script:" . tmpFile), "eval" ) ; ComObjGet("script:" . tmpFile) is the way to invoke com-object without registration in the system
   FileDelete, % tmpFile
   Return JS
}

CreateScriptObj() {
   static doc
   doc := ComObjCreate("htmlfile")
   doc.write("<meta http-equiv='X-UA-Compatible' content='IE=9'>")
   Return ObjBindMethod(doc.parentWindow, "eval")
}
; 狗狗搜索
DogeDoge(keyword){
    Run,https://www.dogedoge.com/results?q=%keyword%
    return
}
; 谷歌搜索
Google(keyword){
    Run,https://www.google.com/search?q=%keyword%
    return
}
; 隐藏显示扩展名
HideShowfiles(){
    VarSetCapacity(StatePtr, 36, 0)
	DllCall("Shell32.dll\SHGetSetSettings", "Ptr", &StatePtr, "UInt", 1, "Int", 0)
	StateVal := NumGet(StatePtr, "UInt")
	If StateVal = 0
		NumPut(1, StatePtr, "UInt")
	Else
		NumPut(0, StatePtr, "UInt")
	DllCall("Shell32.dll\SHGetSetSettings", "Ptr", &StatePtr, "UInt", 1, "Int", 1)
return
}
; 隐藏、显示桌面图标！
HideOrShowDesktopIcons()
{
	ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
	If class =
		ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW
 
	If DllCall("IsWindowVisible", UInt,class)
		WinHide, ahk_id %class%
	Else
		WinShow, ahk_id %class%
	return
}
; 输入法智能切换
; 源码来之K神智能切换输入法
BoBO_IMELA_GET(){ ;激活窗口键盘布局检测方法,减少了不必要的切换,切换更流畅了
  SetFormat, Integer, H
  WinGet, WinID,, A
  ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
  InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID)
  ;~ MsgBox, %InputLocaleID%
  return %InputLocaleID%
}
BoBO_IME_GET(WinTitle=""){ ;借鉴了某日本人脚本中的获取输入法状态的内容,减少了不必要的切换,切换更流畅了
;-----------------------------------------------------------
; IMEの状態の取得
;    対象： AHK v1.0.34以降
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り値  1:ON 0:OFF
;-----------------------------------------------------------
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

BoBO_setChineseLayout(s=0,h=1,force=1){	;中文简体键盘布局切换主方法，默认s=0关闭提示,s=1为打开提示;h=0忽略延迟,h=1打开默认延迟
	global CN_Code := ini.config.CN_Code
	global EN_Code := ini.config.EN_Code
	;智能检测,如果发现已经是中文,则不切换
	If (BoBO_IMELA_GET()=CN_Code && force=0) {
		;~ ShowStatus("当前：【中文】")
		ShowToolTip("【中文】")
		; AutoCursor()
		;如果发现虽然是中文的键盘布局,但切换到了内置英文模式,那么也是要改的,改的方法很简单粗暴,切成英文，再切成中文,如果你有快捷键也可以用，但不一定比这个更稳
		If (BoBO_IME_GET()=0){
			;~ MsgBox,% h
			if (h=1){
				Sleep,30
			}
			PostMessage, 0x50,, %EN_Code%,, A
			if (h=1){
				Sleep,30
			}
			PostMessage, 0x50,, %CN_Code%,, A
			if (s=1){
				;~ ShowStatus("切换到【中文】")
				  ShowToolTip("【中文】")
				; AutoCursor()
			}
			return
		}
		return
	}
	
	if (h=1){
		Sleep,120
	}
	
	PostMessage, 0x50,, %CN_Code%,, A
	if (h=1){
		Sleep,35
	}
	if (s=1){
		;~ ShowStatus("切换到【中文】")
		ShowToolTip("【中文】")
		; AutoCursor()
	}
	return
}

BoBO_setEnglishLayout(s=0,h=1,force=1){ ;英文美国键盘布局切换主方法，默认s=0关闭提示,s=1为打开提示;h=0忽略延迟,h=1打开默认延迟
	global CN_Code := ini.config.CN_Code
	global EN_Code := ini.config.EN_Code
	;智能检测,如果发现已经是英文,则不切换
	If (BoBO_IMELA_GET()=EN_Code && force=0){
		;~ ShowStatus("当前：【英文】")
		ShowToolTip("【英文】")
		; AutoCursor()
	return
	}

	if (h=1){
		Sleep,120
	}
	
	PostMessage, 0x50,, %EN_Code%,, A
	if (h=1){
		Sleep,35
	}
	if (s=1){
		;~ ShowStatus("切换到【英文】")
		ShowToolTip("【英文】")
		; AutoCursor()
	}
	return
}

ShowToolTip(Msg:=""){	;显示切换或当前的输入法状态
	ToolTip, %Msg%, A_CaretX, A_CaretY - 40
	SetTimer, Timer_RemoveToolTip, 3000
	return
	
	Timer_RemoveToolTip:  ;移除ToolTip
		SetTimer, Timer_RemoveToolTip, Off
		ToolTip
	return
}
; 输入法智能切换-------End--------------------

; 输入法智能切换-------End--------------------
GEN_QR_CODE(string,file="")
{
  sFile := strlen(file) ? file : A_Temp "\" A_NowUTC ".png"
  DllCall( A_ScriptDir "\dll\quricol32.dll\GeneratePNG","str", sFile , "str", string, "int", 4, "int", 2, "int", 0)
  Return sFile
}
; ------------------
CenterWindow(WinTitle)
{
    WinGetPos,,, Width, Height, %WinTitle%
    WinMove, %WinTitle%,, (A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
}


;DynamicFileMenu.ahk
;by BGM 动态菜单
;http://www.autohotkey.com/board/topic/95219-dynamicfilemenuahk/

menu_fromfiles(submenuname, menutitle, whatsub, whatdir, filemask="*", parentmenu="", folders=1){
        menucount := 0
        loop, %whatdir%\*, 1, 0
        {
            if(file_isfolder(A_LoopFileFullPath)){
                if(folders){
                      menucount := menu_fromfiles(A_LoopFileFullPath, a_loopfilename, whatsub, A_LoopFileFullPath, filemask, submenuname, folders)                                   
                }
            }else{
                 loop, %A_LoopFileDir%\%filemask%, 0, 0
                {
                    menu, %submenuname%, add, %a_loopfilename%, %whatsub%
                    menucount++                
                }                
            }
        }
        if(parentmenu && menucount){
            menu, %parentmenu%, add, %menutitle%, :%submenuname%
            return menucount
        }       
}

;fetches the correct path from the menu
menu_itempath(whatmenu, whatdir){
    if(a_thismenu = whatmenu){
    endpath = %whatdir%\%a_thismenuitem%
        return endpath
    }else{
        endpath = %a_thismenu%\%a_thismenuitem%
        return endpath
    }
}

;returns true if the item is a folder, false if is a file
file_isfolder(whatfile){
    lastchar := substr(whatfile, 0, 1) ;fetch the last character from the string
    if(lastchar != "\")
        whatfile := whatfile . "\"
    if(fileexist(whatfile))
        return true
}
;动态菜单结束
PostMsg(CommandID)
{
    PostMessage 1075, %CommandID%, 0, , ahk_class TTOTAL_CMD
}