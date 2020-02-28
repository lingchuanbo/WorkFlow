;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Mod作者：BoBO
; 自用只支持 win10
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;作者：天甜；QQ：105224583
;一花一世界，一叶一枯荣，心无挂碍,无挂碍故,无有恐怖,远离颠倒梦想,究竟涅盘。
;更新于：2018-3-2-V2.1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Process, Priority,,high			;脚本高优先级
; #NoTrayIcon 						;隐藏托盘图标
#NoEnv								;不检查空变量是否为环境变量
#Persistent						;让脚本持久运行(关闭或ExitApp)
#SingleInstance Force				;跳过对话框并自动替换旧实例
#WinActivateForce					;强制激活窗口
#MaxHotkeysPerInterval 200		;时间内按热键最大次数
SetBatchLines -1					;脚本全速执行
SetControlDelay 0					;控件修改命令自动延时
CoordMode Menu Window				;坐标相对活动窗口
SendMode Input						;更速度和可靠方式发送键盘点击
SetTitleMatchMode 2				;窗口标题模糊匹配-3为必须精确匹配 -2部分匹配 -1开头匹配
DetectHiddenWindows On				;显示隐藏窗口
SetWorkingDir %A_ScriptDir%		;当前脚本所在目录的绝对路径.不包含最后的反斜线（根目录同样如此）;A_ScriptDir指的是D:\zxh\QuickZ\Apps

;另存为|保存|复制|新建|打开|图形另存为|文件打开|保存副本|上传|选择文件 ahk_class #32770
GroupAdd, Windows32770, 另存为 ahk_class #32770
GroupAdd, Windows32770, 保存 ahk_class #32770
GroupAdd, Windows32770, 复制 ahk_class #32770
GroupAdd, Windows32770, 新建 ahk_class #32770
GroupAdd, Windows32770, 打开 ahk_class #32770
GroupAdd, Windows32770, 图形另存为 ahk_class #32770
GroupAdd, Windows32770, 文件打开 ahk_class #32770
GroupAdd, Windows32770, 打开文件 ahk_class #32770
GroupAdd, Windows32770, 保存副本 ahk_class #32770
GroupAdd, Windows32770, 上传 ahk_class #32770
GroupAdd, Windows32770, 选择文件 ahk_class #32770
GroupAdd, Windows32770, 插入图片 ahk_class #32770
GroupAdd, Windows32770, 导入 ahk_class #32770
GroupAdd, Windows32770, 置入嵌入对象 ahk_class #32770
GroupAdd, Windows32770, 浏览 ahk_class #32770
GroupAdd, Windows32770, Open ahk_class #32770
GroupAdd, Windows32770, Open Folder ahk_class #32770
GroupAdd, Windows32770, Open File ahk_class #32770
GroupAdd, Windows32770, Save As ahk_class #32770
GroupAdd, Windows32770, Import File ahk_class #32770
GroupAdd, Windows32770, Export As ahk_class #32770
GroupAdd, Windows32770, Output Movie To: ahk_class #32770
GroupAdd, Windows32770, Choose Folder ahk_class #32770

global this_title=
global zParam
;~ OnMessage(0x5555, "MsgMonitor")

排除属性(){
WinGetActiveTitle, AllTitle
if ((WinActivate ahk_class #32770)  && InStr(AllTitle, "属性"))
	return false
else
	return true
}

;~ #If 排除属性()		;因为已经精确匹配，故此项可以不要

;在某些程序中自动切换中文，某些英文			注册个窗口钩子然后监听系统消息
Gui +LastFound +hwndhwndshellwindow
DllCall( "RegisterShellHookWindow", "UInt",hwndshellwindow )
OnMessage( DllCall( "RegisterWindowMessage", "Str", "SHELLHOOK" ), "SwitchMessage" )
return
;~ MsgMonitor(wParam, lParam, msg)
;~ {
    ;~ zParam = %wParam%
;~ }

;~ ^+!1::zParam := 1		;鼠标光标测试
;~ ^+!0::zParam := 0

SwitchMessage( wParam,lParam ) 	;{
{
	If ( wParam != 1 )		;新开窗口,这是HOOK,监控创建窗口的消息,=6也可以，原来是!=1
		;wParam值的定义:
		;~ #define HSHELL_ENDTASK 10
		;~ #define HSHELL_GETMINRECT 5
		;~ #define HSHELL_LANGUAGE 8
		;~ #define HSHELL_REDRAW 6
		;~ #define HSHELL_TASKMAN 7
		;~ #define HSHELL_WINDOWACTIVATED 4
		;~ #define HSHELL_WINDOWCREATED 1
		;~ #define HSHELL_WINDOWDESTROYED 2
		;~ wParam: 此参数的值依赖于参数nCode,其依赖关系如下所示:
		;~ HSHELL_ACCESSIBILITYSTATE: 指示哪一个可以访问特征已被改变了状态,可以是以下值之一:
		;~ ACCESS_FILTERKYS,ACCESS_MOUSEKEYS,ACCESS_STICKKEYS.
		;~ HSHELL_GETMINRECT:被最小化或者最大化的窗口句柄.HSHELL_LANGUAGE: 窗口的句柄.
		;~ HSHELL_REDRAW:被重画的窗口的句柄.HSHELL_WINDOWACTIVATED:被激活的窗口的句柄.
		;~ HSHELL_WINDOWCREATED:被创建的窗口的句柄.HSHELL_WINDOWDESTROYED:被销毁的窗口的句柄.

	{
	If WinActive("ahk_class TTOTAL_CMD")
		{
		WinWaitNotActive ahk_class TTOTAL_CMD
		SendMessage 1074, 21, 0, , ahk_class TTOTAL_CMD
		ControlGetText, varPathInTC, , ahk_id %ErrorLevel%
		StringReplace, this_title, varPathInTC, >, \
		IfWinExist ahk_group Windows32770
			{
			WinWaitActive ahk_group Windows32770, , 2
			if !ErrorLevel
			;IfWinActive ahk_group Windows32770
				{
				ControlClick, Edit1, A
				Sleep, 100
				ControlSetText, Edit1, %this_title%, A
				Sleep, 50
				ControlSend, Edit1, {Enter}, A
				}
			else
				return
			}
		else
			return
		return
		}
	If WinActive("ahk_class CabinetWClass")
		{
		; WinWaitNotActive ahk_class CabinetWClass
		; 方法一
		; WinGetTitle, this_title, ahk_class CabinetWClass	;“文件夹选项”，“查看”，“在标题栏显示完整路径”，“确定”,显示完整路径
		; 方法二
		;hExplorer := DllCall("FindWindowEx", Int, 0, Int, 0, Str, "CabinetWClass", Int, 0)
		;hAddressBar := DllCall("FindWindowEx", Int, hExplorer, Int, 0, Str, "ShellTabWindowClass", Int, 0)
		;ControlGetText, path, , ahk_id %hAddressBar%
		; 方法三
		; ControlGetText, this_title, ToolbarWindow322, ahk_class CabinetWClass
		; this_title := StrReplace(this_title, "地址: ", "")
		this_title :=  ExplorerInfo()
		if this_title=桌面
			this_title=%A_Desktop%
		;if this_title=库\文档
			;this_title=%A_MyDocuments%
		; msgbox % ExplorerInfo()
		IfWinExist ahk_group Windows32770
			{
			WinWaitActive ahk_group Windows32770, , 2
			if !ErrorLevel
			;IfWinActive ahk_group Windows32770
				{
				ControlClick, Edit1, A
				Sleep, 100
				ControlSetText, Edit1, %this_title%, A
				Sleep, 50
				ControlSend, Edit1, {Enter}, A
				}
			else
				return
			}
		else
			return
		return
		}
	If WinActive("ahk_class SciTEWindow")
		{
		if zParam = 1
			{
			OCR_IBEAM			=32513
			hbeam := DllCall("LoadCursorFromFile","Str","D:\zxh\QuickZ\User\Icons\zzx.cur")
			DllCall( "SetSystemCursor", Uint,hbeam, Int,OCR_IBEAM )
			}
		if zParam = 0
			{
			SPI_SETCURSORS := 0x57
			DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
			}
		WinWaitNotActive ahk_class SciTEWindow
			{
			SPI_SETCURSORS := 0x57
			DllCall("SystemParametersInfo", "UInt", SPI_SETCURSORS, "UInt", 0, "UInt", 0, "UInt", 0)
			}
		return
		}
	}
}			;}

;~ #If


!#1::MsgBox % ExplorerInfo()
;~ !#2::MsgBox % ExplorerInfo(0)
;~ !#3::MsgBox % ExplorerInfo(1)
;~ !#4::MsgBox % ExplorerInfo(2)
ExplorerInfo(mode="",hwnd="") { ;Method="当前目录"的时候只返回当前目录;
	;mode默认空值时,不论是否选中文件/文件夹皆返回当前路径(目录名);
	;mode=0时,若选择了文件/文件夹则返回选中的目录名,不无选中时返回空;
	;mode=1时,若选择了文件/文件夹则返回完成路径+文件名,无选中时返回目录名;
	;mode=2时,若选择了文件/文件夹则返回完成路径+文件名,无选中时返回空值;

	;@感谢Quant的原始代码
	Toreturn=
	filenum1=0
	filenum2=0
	WinGet, Process, ProcessName, % "ahk_id " (hwnd := hwnd? hwnd:WinExist("A")) ;这个地方判断是否给定了hwnd值,如果给定的为空,则获取当前窗口的句柄；否则就使用给定的句柄。
	;得出给定句柄对应的进程名称；
	WinGetClass class, ahk_id %hwnd% ;根据句柄来获取对应hwnd的窗口的类名；
	ComObjError(0) ;不显示对象显示的错误。
	if (Process = "explorer.exe") ;如果进程为explorer则进行判断到底时处于桌面（Progman|WorkerW）还是资源管理器（(Cabinet|Explore)WClass）；
		if (class ~= "Progman|WorkerW")
		{
			ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class% ;获取选中的文件的列表【无法获取到扩展名】
			if files=
				Toreturn .= A_Desktop
			else
			{
				filenum1++
				Loop, Parse, files, `n, `r
					Toreturn .= A_Desktop "\" A_LoopField "`n"
			}
		}
		else if (class ~= "(Cabinet|Explore)WClass")
		{
			for window in ComObjCreate("Shell.Application").Windows ;遍历当前资源管理器中打开的窗口；
			{
				if (window.hwnd==hwnd) ;在多个窗口中取定位符合前面hwnd的哪个窗口；
				{
					pp:=window.Document.folder.self.path
					sel := window.Document.SelectedItems
					for item in sel
					{
						filenum2++
						Toreturn .= item.path "`r`n"
					}
					if Toreturn=
						Toreturn:=pp
				}
			}
		}

	fde:=Trim(Toreturn,"`r`n") ;完整的路径和文件名,包括扩展名;
	if mode<> ;mode为012时
	{
		if (filenum1+filenum2=0)
		{
			if (mode=0)||(mode=2)
			{
				return
			}
			else ;mod=1时的情况;
				return fde
		}else
		{
			if (mode=1) or (mode=2)
				if (filenum1<>0)
				{
					aa:=选定的文件()
					return aa ;选定的文件()
				}
				else
					return fde
		}
	}
	if InStr(FileExist(fde), "D") ;这里判断目录
		return,RegExReplace(Trim(Toreturn,"`r`n") . "\","\\\\","\") ;这里的. "\"是给选定的文件夹加上\
	else if Toreturn<>
	{
		StringMid,Toreturn2, Toreturn,1,InStr(Toreturn,"\",,0)-1 ;如果不是目录则按最后一个反斜杠进行截取,取前面的目录；
		return RegExReplace(Toreturn2 . "\","\\\\","\")
	}
}

选定的文件(){
	Clip:=ClipboardAll
	Clipboard=
	Send ^c
	ClipWait,0.5
	cliptem:=Clipboard
	if (StrSplit(Cliptem,"`r").MaxIndex()=1)
	{
		Clipboard:= % Clip
		return RegExReplace(cliptem,"`r`n","")
	}
	else
	{
		Clipboard:= % Clip
		return cliptem
	}}



>!o::
	Send, ^o
	WinWaitActive ahk_class #32770
	ControlFocus, Edit1, A
	send,{Backspace}
	sleep 100
	ControlSetText, Edit1, %this_title%, A
	Sleep, 50
	ControlSend, Edit1, {Enter}, A
	return
>!l::
	Send, ^+s
	WinWaitActive ahk_class #32770
	ControlFocus, Edit1, A
	send,{Backspace}
	sleep 100
	ControlSetText, Edit1, %this_title%, A
	Sleep, 50
	ControlSend, Edit1, {Enter}, A
	return
>!n::
	Send, ^n
	WinWaitActive ahk_class #32770
	ControlFocus, Edit1, A
	send,{Backspace}
	sleep 100
	ControlSetText, Edit1, %this_title%, A
	Sleep, 50
	ControlSend, Edit1, {Enter}, A
	return
;~ ^+s::
	;~ Send ^+s
    ;~ WinWaitActive ahk_class #32770
	;~ ControlFocus, Edit1, A
	;~ send,{Backspace}
	;~ sleep 100
	;~ ControlSetText, Edit1, %this_title%, A
	;~ Sleep, 50
	;~ ControlSend, Edit1, {Enter}, A
	;~ return
	
#IfWinActive, ahk_class #32770
^g::		;发送最后 TC or 资管 路径到32770
	ControlClick, Edit1, A
	Sleep, 100
	ControlSetText, Edit1, %this_title%, A
	Sleep, 100
	ControlSend, Edit1, {Enter}, A
return

^e:: GoSub,Sub_SendCurDiagPath2Exp		;在系统资管中打开对话框的路径
^t:: GoSub,Sub_SendCurDiagPath2Tc		;在TC中打开对话框的路径
;~ Space & t:: GoSub,Sub_SendCurDiagPath2Tc
#If

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


GetCursorShape(){   			;获取光标特征码 by nnrxin  
    VarSetCapacity( PCURSORINFO, 20, 0) ;为鼠标信息 结构 设置出20字节空间
    NumPut(20, PCURSORINFO, 0, "UInt")  ;*声明出 结构 的大小cbSize = 20字节
    DllCall("GetCursorInfo", "Ptr", &PCURSORINFO) ;获取 结构-光标信息
    if ( NumGet( PCURSORINFO, 4, "UInt")="0" ) ;当光标隐藏时，直接输出特征码为0
        return, 0
    VarSetCapacity( ICONINFO, 20, 0) ;创建 结构-图标信息
    DllCall("GetIconInfo", "Ptr", NumGet(PCURSORINFO, 8), "Ptr", &ICONINFO)  ;获取 结构-图标信息
    VarSetCapacity( lpvMaskBits, 128, 0) ;创造 数组-掩图信息（128字节）
    DllCall("GetBitmapBits", "Ptr", NumGet( ICONINFO, 12), "UInt", 128, "UInt", &lpvMaskBits)  ;读取 数组-掩图信息
    loop, 128{ ;掩图码
        MaskCode += NumGet( lpvMaskBits, A_Index, "UChar")  ;累加拼合
    }
    if (NumGet( ICONINFO, 16, "UInt")<>"0"){ ;颜色图不为空时（彩色图标时）
        VarSetCapacity( lpvColorBits, 4096, 0)  ;创造 数组-色图信息（4096字节）
        DllCall("GetBitmapBits", "Ptr", NumGet( ICONINFO, 16), "UInt", 4096, "UInt", &lpvColorBits)  ;读取 数组-色图信息
        loop, 256{ ;色图码
            ColorCode += NumGet( lpvColorBits, A_Index*16-3, "UChar")  ;累加拼合
        }  
    } else
        ColorCode := "0"
    DllCall("DeleteObject", "Ptr", NumGet( ICONINFO, 12))  ; *清理掩图
    DllCall("DeleteObject", "Ptr", NumGet( ICONINFO, 16))  ; *清理色图
    VarSetCapacity( PCURSORINFO, 0) ;清空 结构-光标信息
    VarSetCapacity( ICONINFO, 0) ;清空 结构-图标信息
    VarSetCapacity( lpvMaskBits, 0)  ;清空 数组-掩图
    VarSetCapacity( lpvColorBits, 0)  ;清空 数组-色图
    return, % MaskCode//2 . ColorCode  ;输出特征码
}
; MouseIsOver(WinTitle) {			;获取鼠标所在位置窗口的ahk_class
;     MouseGetPos,,, Win
;     return WinExist(WinTitle . " ahk_id " . Win)
; }
; RemoveToolTip:
; 	SetTimer,RemoveToolTip,Off
; 	ToolTip
; 	return

/*          Listary增强
Listary(){
    WinWaitActive ahk_class #32770
    Sleep 100
    Send ^{g}
return
}


    Sleep 200
    if WinActive( "ahk_class #32770")
    {
        Sleep 100
        WinActivate ahk_class Listary_WidgetWin_0
        ControlFocus ListarySearchBox1, ahk_class Listary_WidgetWin_0
        SetControlDelay, 0
        Send ^{g}
    }
*/

	




^F12::Reload
^F11::ExitApp
