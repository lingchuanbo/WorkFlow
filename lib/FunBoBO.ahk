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

FunBoBO_VimShow(){
    run,%A_ScriptDir%\apps\HuntAniidPeck\hap.exe /hint
    return
}
;函数功能:显示图片做为Help帮助
;;显示
ShowLayoutIMG(img){
	;ShowLayout:
		Gui,ShowLayout:Add,pic,Center,%A_ScriptDir%\ui\%img% 
		Gui,ShowLayout:+LastFound +AlwaysOnTop -Caption ; +ToolWindow -DPIScale
		Gui,ShowLayout:Show,Center NoActivate
        WinSet, Transparent, 250
		;WinSet, TransColor,f0f0f0 ;去掉灰色边框
	Return
}
;;隐藏
HideLayoutIMG(){
	;HideLayout:
	Gui,ShowLayout:Hide
	return
}
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
	return Explorer_GetPath()
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
getCurrentDir(ByRef CurWinClass="")
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
        DirectionDir:=Explorer_GetSelected(Curhwnd)
        IfInString,DirectionDir,`;		;我的电脑、回收站、控制面板等退出
            return
    }
    if CurWinClass in WorkerW,Progman    ;如果当前激活窗口为桌面
    {
        DirectionDir:=Explorer_GetSelected(Curhwnd)
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

; ################3DsMax相关函数######################
;;运行3DsMaxScript函数1
;;用法 runMaxScriptCommands("脚本名字.ms")
runMaxScriptCommands(MaxScriptPath){
    run, %A_ScriptDir%\custom\maxScripts\MXSPyCOM.exe -f %A_ScriptDir%\custom\maxScripts\commands\%MaxScriptPath%
    return
}
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

; ################Photoshop相关函数######################
runPsScript(PsPath){
    app:=ComObjCreate("Photoshop.Application")
    app.DoJavaScriptFile(%PsPath%)
    return
}

; 函数功能：运行自定义标题
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

; 函数功能：检测进程
ProcessExist(Name){ ; 
Process,Exist,%Name%
return Errorlevel
}

; 函数功能：单双长按函数
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
	; appName:=RegExMatch(getPath,"(\\|.:\\).*\\",candysel)
	tc_open_path:=Explorer_Get()
	; candysel=%candysel%  ;去掉首尾空格
	candysel=%title%  ;去掉首尾空格
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
	; msgbox %this_title%
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


; 狗狗搜索
DogeDoge(keyword){
    Run,https://www.dogedoge.com/results?q=%keyword%
    return
}
; 谷歌搜索http://www.google.com/s?wd=%Clipboard% 
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


KeyClickAction(act){
	If RegExMatch(act,"i)^(run,)",m) {
		run,% substr(act,strlen(m1)+1)
	}
	else If RegExMatch(act,"i)^(send,)",m) {
		Send,% substr(act,strlen(m1)+1)
	}
	else If RegExMatch(act,"i)^(SendInput,)",m) {		
		SendInput,% substr(act,strlen(m1)+1)
	}
	else If RegExMatch(act,"i)^(GoSub,)",m) {
		GoSub,% substr(act,strlen(m1)+1)
	}
}

 PostMsg(CommandID)
{
    PostMessage 1075, %CommandID%, 0, , ahk_class TTOTAL_CMD
}

BaiduOCR() {
	; http://ai.baidu.com/docs#/Begin/top
	apiKey := "7U2OgTyTuH5NG2ZAxHZfbfQR"
	secretKey := "yFklkou5XySgF1WkxBeKmePphkOESFhO"
	; 获取Access Token
	; http://ai.baidu.com/docs#/Auth/top
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", "https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=" apiKey "&client_secret=" secretKey)
	whr.Send()
	ret := Jxon_Load(whr.ResponseText)
	if !ret.access_token
		throw ret.error "`n" ret.error_description

	; 通用文字识别
	whr.Open("POST", "https://aip.baidubce.com/rest/2.0/ocr/v1/general_basic?access_token=" ret.access_token)
	whr.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	; img:=%imgPath%
	b64Data := Base64Enc_FromFile("test.png")
	body := "image=" UriEncode(b64Data) "&language_type=CHN_ENG"
	whr.Send(body)

	Txtmp:=GetWinHttpText(whr)
	OutputVar:=GetWinHttpText(whr)

	; 测试保存数据到 txt 文件
	; FileDelete, %A_ScriptDir%\text.txt
	; Sleep, 100
	; FileAppend , %Txtmp%, %A_ScriptDir%\text.txt, UTF-8
	; FileRead, OutputVar, %A_ScriptDir%\text.txt
	
	RegExMatch(OutputVar,"\[.*\]",getTx)
	get01 := RegExReplace(getTx,"\[|\]","")
	get02 := RegExReplace(get01,"words","")
	get03 := RegExReplace(get02,"""","")
	get04 := RegExReplace(get03,"{: ","")
	get05 := RegExReplace(get04,"},","`n")
	keyword := RegExReplace(get05,"}","")
	return keyword
return  
}

GetWinHttpText(objWinHttp, encoding := "UTF-8") {
	ado := ComObjCreate("adodb.stream")
	ado.Type     := 1 ; adTypeBinary = 1
	ado.Mode     := 3 ; adModeReadWrite = 3
	ado.Open()
	ado.Write(objWinHttp.ResponseBody)
	ado.Position := 0
	ado.Type     := 2 ; adTypeText = 2
	ado.Charset  := encoding
	return ado.ReadText(), ado.Close()
}


;-----------------------截图画框功能---------------------------------------
ScreenCapture()
{
	; !2::
	Loop
	{  
		Gui, +LastFound   ;找到上一次的窗口  
		Gui, -Caption   ;隐藏标题栏
		Gui, +Owner    ;设置阻止任务栏按钮的显示
		Gui, +AlwaysOnTop   ;让GUI界面，开置顶
		WinSet, Transparent, 1 ;透明度
		Gui, Show,Maximize
		KeyWait ,LButton,D   ;等待左键点击
	GetKeyState,判断按钮,LButton,P  ;判断是否按住鼠标左键
		MouseGetPos,MX1,MY1   ;获取当前鼠标坐标
		xpos := MX1
		ypos := MY1
		Gui, +Owner    ;设置阻止任务栏按钮的显示
		Gui, Destroy ;重置GUI窗口，销毁窗口记录
		Gui, Show  ;显示重置窗口
	Loop  ;使用不断循环让窗口出现移动效果，松开为停止
	{
	Sleep ,1 ;适当加延迟，否则变量来不急赋值，导致画面会闪
		GetKeyState,判断按钮,LButton,P  ;判断是否按住鼠标左键
		MouseGetPos,MX2,MY2  ;获取移动后鼠标的坐标
		xpos:=MX2<MX1 ? MX2:MX1, ypos:=MY2<MY1 ? MY2:MY1   ;表达式计算截取区域四周自由变换。
		wpos1 :=Abs(MX1-MX2), hpos1 :=Abs(MY1-MY2) ;表达式计算截取区,两表达式之间，可用(,)逗号链接。  
		Gui, +LastFound   ;找到上一次的窗口  
		WinSet, Transparent, 150  ;透明度
		Gui, -Caption   ;隐藏标题栏
		Gui, +Owner    ;设置阻止任务栏按钮的显示
		; Gui, Color, 292929 ;设置背景颜色
		Gui, Color, ffd800
		Gui, Show, NA x%xpos% y%ypos% h%hpos1% w%wpos1%  
		WinGetPos, XXX1, YYY1, WWW1,HHH1, A  ; "A" 表示获取活动窗口的位置。截图区域确定后，执行获取位置大小。

	}until (判断按钮 = "U")  ;松开鼠标为停止
	}until (判断按钮 = "U")  ;松开鼠标为停止
	Gui, +LastFound   ;找到上一次的窗口  
	gui,Hide
	;~ WinClose, A  ;关闭窗口，参数A为，当前活动窗口。
	;~ return
	;~ ;---------截图显示功能（注释上和下总两行，截图即时完成。不注释可逐步调试）-----------
	;~ F6::
	时间命名 :=A_Now
	;~ MsgBox ,% 时间命名
	;~ PicPath := "D:\aaaa.png"
	; FileCreateDir, D:\picTP\   ;创建图片保存文件夹，如存在不会再次创建
	; PicPath := "D:\picTP\" 时间命名 ".png"  ;设置保存目录
	PicPath = %A_ScriptDir%\test.png
	; msgbox %PicPath%
	
	;~ PicPath := "D:\" 时间命名 ".png"  ;设置保存目录,此函数库保存格式为png，质量比jpg好。
	pToken := Gdip_Startup() ; Start gdi+
			; pBitmapAlpha := Gdip_CreateBitmapFromFile(PicPath)
			;~ pBitmapAlpha := Gdip_BitmapFromScreen("0|0|800|800")
			pBitmapAlpha := Gdip_BitmapFromScreen(xpos "|" ypos "|" wpos1 "|" hpos1)
			;首要设置鼠标获取屏幕坐标，CoordMode,Mouse, Screen。
	;Gdip_BitmapFromScreen参数分别是，xpos|ypos为左上角区域，wpos1|hpos1为右下角区域（需表达式运算得出）。
			ImgWidth := Gdip_GetImageWidth(pBitmapAlpha)  ; 获取宽度，高度，可省略
			ImgHeight := Gdip_GetImageHeight(pBitmapAlpha)
			;~ Gdip_SaveBitmapToFile(pBitmapAlpha, PicPath,"255") ;第三个参数控制图片质量
			Gdip_SaveBitmapToFile(pBitmapAlpha, PicPath) ;第三个参数控制图片质量
			Gdip_DisposeImage(pBitmapAlpha)
			
	; Gdip_Shutdown(pToken) ; close gdi+
	; Traytip, 截图完毕:, 宽: %ImgWidth% 高: %ImgHeight%`n保存为: %PicPath%
	; return
}