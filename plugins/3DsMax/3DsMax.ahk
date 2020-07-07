;Author:BoBO
;Version:20190308
;
;20190814   优化操作
;           新增对英文支持
;20190308   修正输入状态延迟
;20181114   修正activeType本地初始化
;20181102   修复载入渲染乱码显示！
;20181102   修正渲染附加组件无法使用，加入预加载列表.
;20181023   对接口路径做判断修复只能打开一次，主要涉及到脚本本身
;20181022   新增加对MaxScript的支持,采用第3方接口MXSPyCOM.exe,配置
;           %A_ScriptDir%\custom\maxScripts\initialize_COM_server.ms 拷贝到...3ds Max 2014\scripts\Startup
;20180920   新增输入状态屏蔽功能
;20180919   新增activeType设置快捷为Ctrl+Shift+Alt+C
;;Windows Groups
;   
;            runPath = startObjectCreation box 创建对象 可拉扯
;            runMaxScriptTxt(runPath)
;   
;提前运行

;待解决
;1.Octopus本地化
;2 http://www.scriptspot.com/3ds-max/scripts/dropbox看使用率在集成
;3.IKMAX本地化

3DsMax:

    vim.SetAction("<3DsMax_NormalMode>", "返回正常模式")
    vim.SetAction("<3DsMax_InsertMode>", "进入VIM模式")
    vim.SetWin("3DsMax","ahk_exe","3DsMax.exe")
    vim.BeforeActionDo("3DsMax_CheckMode","3DsMax")
    #include %A_ScriptDir%\plugins\3DsMax\3DsMaxComment.ahk   
 
;normal模式
    vim.SetMode("normal","3DsMax")
    vim.Map("<insert>", "<3DsMax_SwithMode>", "3DsMax")
;insert模式
    vim.SetMode("insert", "3DsMax")
    vim.Map("<insert>", "<3DsMax_SwithMode>", "3DsMax")
    #include %A_ScriptDir%\plugins\3DsMax\3DsMaxKey.ahk
    ;#include %A_ScriptDir%\plugins\3DsMax\3DsMaxPlus.ahk //看时机在激活
    #Include %A_ScriptDir%\plugins\3DsMax\3DsMaxMenu.ahk
return


;【输入状态检测】
3DsMax_CheckMode(){
    ControlGetFocus, ctrl, A
    if RegExMatch(ctrl, "i)Edit")||RegExMatch(ctrl, "i)MXS_Scintilla")||RegExMatch(ctrl, "i)EDITDUMMY")||RegExMatch(ctrl, "i)WindowsForms10")||RegExMatch(ctrl, "i)ComboBox") ;  or WinExist("ahk_class MXS_SciTEWindow")) ;|| RegExMatch(ctrl, "i)MXS_Scintilla1")
        {
            return True
        }
    else
        {
            ; setEnglishLayout(s=0,h=1) ;操作过程自动切换至英文输入法，如果遇到问题可以注释
            return False
        }
}


<3DsMax_Vim>:
FunBoBO_VimShow()
return

;【全局运行Max】
<Run3DsMax>:
    ExePath := ini.BOBOPath_Config.MaxPath
    tClass := ini.ahk_class_Config.3DsMax_Class
    FunBoBO_RunActivation(ExePath,tClass)
 return

;【切换模式】
<3DsMax_SwithMode>:
;   单键切换
        if 3DsMax_var=2 ; 总
        3DsMax_var=0
        3DsMax_var+=1
        3DsMaxE_var=0
        if (3DsMax_var=1 )
        {    
            GoSub,<3DsMax_NormalMode>
            return
        }
        if (3DsMax_var=2)
        {
            GoSub,<3DsMax_InsertMode>
            return
        }
return

<3DsMax_NormalMode>:
;   send,{esc}
    vim.SetMode("normal", "3DsMax")
    Gui,Ae_insert: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,Ae_insert: Color, %color4%
    Gui,Ae_insert: Font,cwhite s20 %FontSize% wbold q5,Segoe UI
    Gui,Ae_insert: Add, Text, ,%_ExitVIMMode%
    Gui,Ae_insert: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
    sleep %SleepTime%
    Gui,Ae_insert: Destroy

return

<3DsMax_InsertMode>:
    ; GoSub,<3DsMax_ScritAll>
    vim.SetMode("insert", "3DsMax")
    Gui,Ae_insert: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,Ae_insert: Color, %color2%
    Gui,Ae_insert: Font,cwhite s30 %FontSize% wbold q5,Segoe UI
    Gui,Ae_insert: Add, Text, ,%_VIMMode%
    Gui,Ae_insert: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
    sleep %SleepTime%
    Gui,Ae_insert: Destroy
return
;辅助帮助显示
<3DsMax_Help>:
; ShowLayoutIMG("ae3DsMax1.png")
; KeyWait i
; HideLayoutIMG()
return


<3DsMax_ScritAll>:
    runMaxScriptCommands("ShowTime.ms")
    sleep 100
    runMaxScriptCommands("Timeslider.ms")
return



;基本操作
<3DsMax_RButton>:
{
    send,{RButton}
    return
}

<3DsMax_Archive>:
{
    runMaxScriptCommands("Archive.ms")
}
return
<3DsMax_Reset>:
{
    runMaxScriptCommands("Reset.ms")
}
return

<3DsMax_Import>:
{
    runMaxScriptCommands("Import.ms")
}
return
<3DsMax_Export>:
{
    runMaxScriptCommands("Export.ms")
}
return

<3DsMax_displayFloater>:
{
    KeyWait, LButton
    runMaxScriptCommands("displayFloater.ms")
}
return

<3DsMax_Enter>:
{
    send {Enter}
    return
}
; <3DsMax_attachSelection>:
; {
;     WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
;     tool_pathandname = "%activePath%"
;     runMaxScriptCommands("attachSelection.ms")
;     return
; }
; return

<3DsMax_copyModifiers>:
{
    ;拷贝Modifiers
    runMaxScriptCommands("copyModifiers.ms")
}
return
<3DsMax_pasteCopyModifiers>:
{
    ;粘贴Modifiers
    runMaxScriptCommands("pasteCopyModifiers.ms")
}
return

<3DsMax_convertToPoly>:
{
    ;转成Poly
    KeyWait LButton
    runMaxScriptCommands("convertToPoly.ms")
    return
}
return

<3DsMax_convertToMesh>:
{
    ;转成Mesh
    KeyWait LButton
    runMaxScriptCommands("convertToMesh.ms")
    return
}
return

<3DsMax_convertToSpline>:
{
    ;转成Spline
    KeyWait LButton
    runMaxScriptCommands("convertToSpline.ms")
}
return
;end
<3DsMax_CloseAllUI>:
{
    WinClose, Measure
	WinClose, Display Floater
	WinClose, Layer: 
	WinClose, Transform Type-In
	WinClose, Material Editor -
	WinClose, Slate Material Editor 
	WinClose, Render Setup: 
	WinClose, Scene Explorer -
	WinClose, materialByName
	WinClose, LPM v2.00 
    return
}

<3DsMax_SwithObjectMode>:

    ; keyPress:=analyseKeyPress()
	; if (keyPress=1){
    ;     if Max_var=2 ; 总共几次 
    ;     Max_var=0
    ;     Max_var+=1
    ;     if (Max_var=1)
    ;     {
    ;         GoSub,<3DsMax_Viewport_Wireframe>
    ;         return
    ;     }
    ;     if (Max_var=2)
    ;     {
    ;          GoSub,<3DsMax_Viewport_EdgedFaces>
    ;         return
    ;     }
    ;     return
	; }
    ; if (keyPress=2){
    ;     GoSub,<3DsMax_Viewport_DefaultShading>
    ;     return
	; }
    ; return

    if Max_var=2 ; 总共几次 
    Max_var=0
    Max_var+=1
    if (Max_var=1)
    {
        GoSub,<3DsMax_Viewport_DefaultShading>
        return
    }
    if (Max_var=2)
    {
        GoSub,<3DsMax_Viewport_Wireframe>
        return
    }
    ; if (Max_var=3)
    ; {
    ;     GoSub,<3DsMax_Viewport_EdgedFaces>
    ;     return
    ; }
return

;轴操作
<3DsMax_PivotCenter>:
    runMaxScriptCommands("PivotCenter.ms")
return
<3DsMax_PivotReset>:
    runMaxScriptCommands("PivotReset.ms")
return
<3DsMax_PivotRotate>:
    runMaxScriptCommands("PivotRotate.ms")
return
<3DsMax_PivotSet>:
    runMaxScriptCommands("PivotSet.ms")
return

<3DsMax_Key>:
    send, {k}
return

<3DsMax_getUp>:
    send, {,}
return
<3DsMax_getDown>:
    send, {.}
return

<3DsMax_Play>:
send,{/}
return
;双按操作
<3DsMax_Double_Z>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, 3DsMax_tappedkey_z, %t%
    if (t == "off")
    goto 3DsMax_double_z
    return

    3DsMax_tappedkey_z:
    Send z
    return

    3DsMax_double_z:
    Send, ^+z
    return
}
 Return
<3DsMax_RenderChanger>:
{
    runMaxScriptCommands("render_changer.mse")
    return
}
<3DsMax_Double_A>:
{
    ; 打开|保存
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, a
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        runMaxScriptCommands("DetachElements.ms")
        return
    }
    KeyWait, a, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            runMaxScriptCommands("attachSelection.ms")
            return
        }
    else
        {
            send {a}
            return
        }
    return
}
Return

<3DsMax_Double_O>:
{
    ; 打开|保存
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, o
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,^{s}
        return
    }
    KeyWait, o, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            send ^{o}
            return
        }
    else
        {
            send {o}
            return
        }
    return
}
Return

<3DsMax_Double_I>:
{
    ; 独立显示|显示全部
    DoubleClickTime := DllCall("GetDoubleClickTime") 
    KeyWait, i
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ; runPath = unhide objects
        ; runMaxScriptTxt(runPath)
        return
    }
    KeyWait, i, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            ; runPath = unhide objects
            ; runMaxScriptTxt(runPath)
            runMaxScriptCommands("IsolateSelection.ms")
            return
        }
    else
        {
            send {i}
            return
        }
    return


}
Return

<3DsMax_Double_H>:
{
    ; 独立显示|显示全部
    DoubleClickTime := DllCall("GetDoubleClickTime") 
    KeyWait, h
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        runPath = unhide objects
        runMaxScriptTxt(runPath)
        return
    }
    KeyWait, h, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            runPath = hide Selection
            runMaxScriptTxt(runPath)
            return
            ; runPath = actionMan.executeAction 0 "281"
            ; runMaxScriptTxt(runPath)
            ; return
        }
    else
        {
            send {h}
            ; runPath = hide Selection
            ; runMaxScriptTxt(runPath)
            return
        }
    return
}
Return


<3DsMax_Space>:
{
    send,{Space}
    return
}

<3DsMax_Double_P>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, 3DsMax_tappedkey_p, %t%

    if (t == "off")
    goto 3DsMax_double_p
    return

    3DsMax_tappedkey_p:
        Send, p
    return

    3DsMax_double_p:
        runMaxScriptCommands("commandPlanel.ms")
    return  
}
return

<3DsMax_Double_Q>:
{

    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, q
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        WinClose, Measure
        WinClose, Display Floater
        WinClose, Layer: 
        WinClose, Transform Type-In
        WinClose, Material Editor -
        WinClose, Slate Material Editor 
        WinClose, Render Setup: 
        WinClose, Scene Explorer -
        WinClose, materialByName
        WinClose, LPM v2.00 
        return
    }
    KeyWait, q, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            Send,+q
            return
        }
    else
        {
            send {q}
            return
        }
    return
}
Return



<3DsMax_Double_W>:
{


    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, 3DsMax_tappedkey_W, %t%

    if (t == "off")
    goto 3DsMax_double_W
    return

    3DsMax_tappedkey_W:
    runMaxScriptCommands("Move.ms")
    return


    3DsMax_double_W:
    ; runMaxScriptCommands("MaximizeViewport.ms")
    SendInput, !{w}
    return  

}
<3DsMax_Double_F>:
{

    ; DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; KeyWait, f
    ; if (A_TimeSinceThisHotkey > DoubleClickTime) {

    ;     runPath =unfreeze objects
    ;     runMaxScriptTxt(runPath)
    ;     return
    ; }
    ; KeyWait, f, % "d T"DoubleClickTime/1000
    ; If ! Errorlevel
    ;     {
    ;         runPath = freeze Selection
    ;         runMaxScriptTxt(runPath)
    ;         return
    ;     }
    ; else
    ;     {
    ;         send {f}
    ;         return
    ;     }
    ; return
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, 3DsMax_tappedkey_f, %t%

    if (t == "off")
    goto 3DsMax_double_f
    return

    3DsMax_tappedkey_f:
        Send, f
    return

    3DsMax_double_f:
            runPath = freeze Selection
            runMaxScriptTxt(runPath)
    return  


}
<3DsMax_unfreeze>:
        KeyWait LButton
        runPath =unfreeze objects
        runMaxScriptTxt(runPath)
return
<3DsMax_Double_D>:
{
    ; 复制粘贴|删除
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, d
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,{Delete}
        return
    }
    KeyWait, d, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            send ^{v}
            return
        }
    else
        {
            send {d}
            return
        }
    return
}

<3DsMax_Double_0>:
{
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, 3DsMax_tappedkey_0, %t%
    ; if (t == "off")
    ; goto 3DsMax_double_0
    ; return

    ; 3DsMax_tappedkey_0:
    ;     Send,0
    ; return

    ; 3DsMax_double_0:
    ;     runMaxScriptCommands("XYZ_0.ms")
    ; return
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, 0
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        runMaxScriptCommands("PivotCenter.ms")
        return
    }
    KeyWait, 0, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            runMaxScriptCommands("XYZ_0.ms") 
            return
        }
    else
        {
            send 0
            return
        }
    return

}

<3DsMax_Double_X>:
{
    ; 搜索|ActiveType|删除
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, x
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,{Delete}
        return
    }
    KeyWait, x, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            runMaxScript("activeType.ms")
            return
        }
    else
        {
            send {x}
            return
        }
    return
}
Return
<3DsMax_Tab>:
{
    runMaxScript("activeType.ms")
    return  
}


<3DsMax_Double_Y>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, 3DsMax_tappedkey_y, %t%
    if (t == "off")
    goto 3DsMax_double_y
    return

    3DsMax_tappedkey_y:
    Send {y}
    return

    3DsMax_double_y:
    Send, ^!+{y}
    return
}
Return


<3DsMax_Double_S>:
{
    GV_KeyClickAction1 := "Gosub,<3DsMax_Tab>"
	GV_KeyClickAction2 := "Send,x"
	GoSub,Sub_KeyClick
}


<3DsMax_Double_F9>:
{
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, 3DsMax_tappedkey_F9, %t%
    ; if (t == "off")
    ; goto 3DsMax_double_F9
    ; return

    ; 3DsMax_tappedkey_F9:
    ; Send {F9}
    ; return

    ; 3DsMax_double_F9:
    ; Send, {F10}
    ; return
}
Return

;发送ESC
<3DsMax_esc>:
{
    Send, {Esc}
    return
}


;播放暂停
<3DsMax_Numpad0>:
{
    Send, /
}
Return

; Scrolllock::
; Suspend,Toggle
; Return

; +Scrolllock::
; reloadgg
; return

<3DsMax_activeType>:
{
    ; run, %A_ScriptDir%\custom\maxScripts\MXSPyCOM.exe -f %A_ScriptDir%\custom\maxScripts\activeType.ms 
}
Return

;动作保存模块
; <3DsMax_saveAniTime>:
; {
;     run, %A_ScriptDir%\custom\maxScripts\MXSPyCOM.exe -f %A_ScriptDir%\custom\maxScripts\saveAniTime.ms 
;     return
; }

;批渲染脚本
<3DsMax_render8Direction>:
{
    runMaxScript("Render8Direction.ms")
    return
}
;
<3DsMax_maxToTotalcmd>:
{
    runMaxScript("maxToTotalcmd.ms")
    return
}
<3DsMax_Renderlayers>:
{
    runMaxScriptCommands("BatchRender.ms")
    return
}

;功能性脚本

<3DsMax_Double_E>:
{
    ; 缩放
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, e
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ; Send,^{s}
        return
    }
    KeyWait, e, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            runPath = rotate $ (angleaxis 90 [0,0,1])
            runMaxScriptTxt(runPath)
            return
        }
    else
        {
            send {e}
            return
        }
    return
}



;#Include,%A_ScriptDir%\plugins\3DsMax\3DsMaxPlus.ahk
; 只在3DsMax界面上生效的热键，这个就只是在max的Label1窗口起作用，
; 在其他地方6还是6，
; #If ActiveControlIs("Label1")
; 6::Send {F5}
; 7::MsgBox
; #If

; ActiveControlIs(Control) {
;     ControlGetFocus, FocusedControl, A
;     return (FocusedControl=Control)
; }

;位置坐标操作
;物体归00点
<3DsMax_maxPos>:
{
    runMaxScriptCommands("XYZ_0.ms")
    return
}
;坐标归物体00点
<3DsMax_maxXYZ>:
{
    runMaxScriptCommands("XYZ_Z.ms")
    return 
}

<3DsMax_SelectLink>:
{
    runPath = max link
    runMaxScriptTxt(runPath)
    return
}
<3DsMax_SelectUnLink>:
{
    runPath = max unlink
    runMaxScriptTxt(runPath)
    return
}
<3DsMax_Align>:
{
    runPath = max align
    runMaxScriptTxt(runPath)
    return
}
<3DsMax_warp>:
{
    runPath = max bind space warp mode
    runMaxScriptTxt(runPath)
    return
}

<3DsMax_ViewRotion>:
send,!{Mbutton}
return


; 发送数字恢复
<3DsMax_1>:
send, 1
return
<3DsMax_2>:
send, 2
return
<3DsMax_3>:
send, 3
return
<3DsMax_4>:
send, 4
return
<3DsMax_5>:
send, 5
return



<3DsMax_CapsLock_Tab>:
{
    send,{Tab}
    return
}




;Ini传递数值给SetEvn
<3DsMax_Ini>:
{
    ; getWorkFLowIni=%A_ScriptDir%\custom\maxScripts

    ; openSetEvn=%A_ScriptDir%\setEvn.ms

    ; gotoSetEvn=%A_ScriptDir%\custom\maxScripts\Startup\setEvn.ms

    ; fileread, ContentsMaxscript, %openSetEvn%

    ; RegExMatch(ContentsMaxscript,"(\\|.:\\).*\\",newPath) ;正则替换内容

    ; FileRead, Contents, %openSetEvn% 
    ;     if not ErrorLevel 
    ;         { 
                
    ;             Contents := StrReplace(Contents, newPath, getWorkFLowIni)

    ;             FileDelete, %gotoSetEvn% ;先删除文件
                
    ;             sleep 500

    ;             FileAppend, %Contents%, %gotoSetEvn% ;输出文件

    ;             Contents = ; 清理内存

    ;             sleep 200

    ;             run, %A_ScriptDir%\3DsMax初始化.bat
    ;         }
; ######第二种写法

    ; Gui, Color, 37474F
    ; Gui -Caption

    ; Gui, Font, s32,Microsoft YaHei
	; Gui, +AlwaysOnTop +Disabled -SysMenu +Owner 
	; Gui, Add, Text,cffffff,3DsMax初始化配置
	; Gui, Show, xCenter yCenter, 状态, NoActivate,
	; sleep, 1200
	; Gui, Destroy
    
    gotoSetEvn=%A_ScriptDir%\custom\maxScripts\Startup\setEvn.ms
    FileDelete, %gotoSetEvn% ;先删除文件
    FileAppend,  ; 这里需要逗号.
    (
    --设置本地环境$maxScripts.
    --读取workflow ini地址
    evnPath="%A_ScriptDir%\custom\maxScripts"
    
    if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" evnPath
    symbolicPaths.setUserPathValue "$maxScripts" evnPath
    
    ), %A_ScriptDir%\custom\maxScripts\Startup\setEvn.ms,UTF-8

    sleep 2000

    ; run, %A_ScriptDir%\plugins\3DsMax\3DsMaxInfo.bat
    Max2021:="C:\Program Files\Autodesk\3ds Max 2020"
    Max2020:="C:\Program Files\Autodesk\3ds Max 2020"
    Max2019:="C:\Program Files\Autodesk\3ds Max 2019"
    Max2018:="C:\Program Files\Autodesk\3ds Max 2018"
    Max2017:="C:\Program Files\Autodesk\3ds Max 2017"
    Max2016:="C:\Program Files\Autodesk\3ds Max 2016"
    Max2015:="C:\Program Files\Autodesk\3ds Max 2015"
    Max2014:="C:\Program Files\Autodesk\3ds Max 2014"

    if FileExist("C:\Program Files\Autodesk\3ds Max 2021\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2021%\scripts\Startup, 1
        MsgBox, %Max2021%已经配置完毕！请重启程序!
        Return
    }

    if FileExist("C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2020%\scripts\Startup, 1
        MsgBox, %Max2020%已经配置完毕！请重启程序!
        Return
    }
    if FileExist("C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2019%\scripts\Startup, 1
        MsgBox, %Max2019%已经配置完毕！请重启程序!
        Return
    }
    if FileExist("C:\Program Files\Autodesk\3ds Max 2018\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2018%\scripts\Startup, 1
        MsgBox,%Max2018% 已经配置完毕！请重启程序!
        Return
    }
    if FileExist("C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2017%\scripts\Startup, 1
        MsgBox, %Max2017% 已经配置完毕！请重启3DsMax
        Return
    }
    if FileExist("C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2016%\scripts\Startup, 1
        MsgBox, %Max2016% 已经配置完毕！请重启3DsMax
        Return
    }
    if FileExist("C:\Program Files\Autodesk\3ds Max 2015\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2015%\scripts\Startup, 1
        MsgBox, %Max2015% 已经配置完毕！请重启3DsMax
        Return
    }
    if FileExist("C:\Program Files\Autodesk\3ds Max 2014\3dsmax.exe")
    {
        FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2014%\scripts\Startup, 1
        MsgBox, %Max2014% 已经配置完毕！请重启3DsMax
        Return
    }else{
        MsgBox, 检测非默认安装 `n`n`n 请手动复制...`n`n 请拷贝文件： `n`n %A_ScriptDir%\custom\maxScripts\Startup `n`n 到： `n`n 3DsMax安装目录下 \scripts\Startup
        return
    }
    ; if FileExist("C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe")
    ; {
    ;     FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2016%\scripts\Startup, 1
    ;     MsgBox, 已经配置完毕！请重启3DsMax
    ;     Return
    ; }else{
    ;     MsgBox, 检测非默认安装 `n`n`n 请手动复制...`n`n 源目录： `n`n %A_ScriptDir%\custom\maxScripts\Startup `n`n 目标目录： `n`n %Max2016%\scripts\Startup
    ;     return
    ; }

    ; if FileExist("C:\Program Files\Autodesk\3ds Max 2014\3dsmax.exe")
    ; {
    ;     FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%Max2014%\scripts\Startup, 1
    ;     MsgBox, 已经配置完毕！请重启3DsMax
    ;     Return
    ; }else{
    ;     MsgBox, 检测非默认安装 `n`n`n 请手动复制...`n`n 源目录： `n`n %A_ScriptDir%\custom\maxScripts\Startup `n`n 目标目录： `n`n %Max2014%\scripts\Startup
    ;     return
    ; }
    return
}


;Ini传递数值给SetEvn
<3DsMax_CopyToStartup>:
{
    getExePath := GetProcessPath("3dsmax.exe")
    gotoSetEvn=%A_ScriptDir%\custom\maxScripts\Startup\setEvn.ms
    FileDelete, %gotoSetEvn% ;先删除文件
    FileAppend,  ; 这里需要逗号.
    (
    --设置本地环境$maxScripts.
    --读取workflow ini地址
    evnPath="%A_ScriptDir%\custom\maxScripts"
    
    if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" evnPath
    symbolicPaths.setUserPathValue "$maxScripts" evnPath
    
    ), %A_ScriptDir%\custom\maxScripts\Startup\setEvn.ms,UTF-8

    sleep 2000

    getExePath := GetProcessPath("3dsmax.exe")

; 写入配置文件
    IniWrite, %getExePath%, config.ini, BOBOPath_Config, MaxPath 

    sleep 100

    candysel := RTrim(getExePath, OmitChars := "\")
    SplitPath, candysel, name, dir, ext, name_no_ext, Drive

    FileCopyDir,%A_ScriptDir%\custom\maxScripts\Startup,%dir%\scripts\Startup, 1

    MsgBox "拷贝完成！请重启 3Ds Max ！"

    return
}



; ViewportDisplay/视窗显示

; Views: Viewport Visual Style Wireframe / Shaded Toggle 线显示
<3DsMax_Viewport_Wireframe>:
{
    runPath=actionMan.executeAction 0 "415" 
    runMaxScriptTxt(runPath)
    return
}
<3DsMax_Viewport_DefaultShading>:
{
    runPath=actionMan.executeAction 0 "63566"
    runMaxScriptTxt(runPath)
    return
}
;  Views: Viewport Visual Style Edged Faces Toggle
<3DsMax_Viewport_EdgedFaces>:
{
    runPath=actionMan.executeAction 0 "557"
    runMaxScriptTxt(runPath)
    return
}



; Viewport Front/Back Toggle/前后切换显示
<3DsMax_Viewport_FrontBack>:
{
    runPath=actionMan.executeAction 98641878 "1834539833"
    runMaxScriptTxt(runPath)
    return
}

; UVW Seam Display Toggle/
<3DsMax_Viewport_UVWDisplay>:
{
    runPath=actionMan.executeAction 98641878 "1696817703"
    runMaxScriptTxt(runPath)
    return
}

;更新
; <3DsMax_UpDater>:
; ; Gui,Updating: +LastFound +AlwaysOnTop -Caption +ToolWindow
; ; Gui,Updating: Color, %color2%
; ; Gui,Updating: Font,cwhite s%FontSize% wbold q5,Segoe UI
; ; Gui,Updating: Add, Text, ,%_MaxUpdating%
; ; Gui,Updating: Show,AutoSize Center NoActivate
; ; UrlDownloadToFile, %UrlDownloadToFile_Ae1%, %A_ScriptDir%\plugins\3DsMax\latest-3DsMax.ahk ;

; ; if ErrorLevel
; ; {
; ;     Gosub, MaxExitUpdater
; ; }
; ; Else
; ; {
; ;     FileMove,%A_ScriptDir%\plugins\3DsMax\latest-3DsMax.ahk, %A_ScriptDir%\plugins\3DsMax\3DsMax.ahk,1
; ;     Gosub, MaxExitUpdater
; ; }
; MsgBox 功能已写好，未测试，没服务器没！！！！
; return

MaxExitUpdater:
FileDelete, %A_ScriptDir%\plugins\3DsMax\latest-3DsMax.ahk
sleep %SleepTime%
Gui,Updating: Hide
Gui,Updating2: +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui,Updating2: Color, %color3%
Gui,Updating2: Font,cwhite s%FontSize% wbold q5,Segoe UI
Gui,Updating2: Add, Text, ,%_UpdateCompleted%
Gui,Updating2: Show,AutoSize Center NoActivate
sleep %SleepTime%
Gui,Updating2: Hide
Run,%A_ScriptDir%\Vimd.exe
Return

; 待整合功能
; lshift & escape::send,{f12}
; +z::
; test2 =try(filein @"D:\3d插件\轮廓.ms")catch()
; ControlFocus, MXS_Scintilla2
; ControlSetText, MXS_Scintilla2, %test1%
; send, +{Enter}
; Return
; lalt & Escape::
; test1 =max move
; ControlFocus, MXS_Scintilla2
; ControlSetText, MXS_Scintilla2, %test1%
; send, +{Enter}
; Return
; ^+!R::
; test =actionMan.executeAction -43434444 "4096"  -- Render: Batch Render Dialog Toggle
; ControlFocus, MXS_Scintilla2
; ControlSetText, MXS_Scintilla2, %test%
; send, +{Enter}
; Return
; +f1::send,{f10}
; f1::send,!+^{pgup}
; f2::send,!+^{pgdn}
; space & v::
; send,+^!v
; return
; space & c::
; send,+^!c
; return
; space & e::
; send,+^!e
; return
; space & b::
; send,+^!b
; return
; space & n::
; send,+^!n
; return
; space & q::
; send,+^!q
; return
; space & w::
; send,+^!w
; return
; space & a::
; send,+^!a
; return
; space & g::
; send,+^!g
; return
; space & m::
; send,+^!m
; return
; space & l::
; send,+^!l

; 只在3dsmax界面上生效的热键，这个就只是在max的Label1窗口起作用，
; 在其他地方6还是6，
; #If ActiveControlIs("Label1")
; 6::Send {F5}
; 7::MsgBox
; #If

; ActiveControlIs(Control) {
;     ControlGetFocus, FocusedControl, A
;     return (FocusedControl=Control)
; }
; ---长按鼠标左键后操作-----------------------------------------------------------------------

;按左鍵再按d | 向下合并

; ~LButton & d:: 
; WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
; tool_pathandname = "%activePath%"
; KeyWait, LButton

;     runMaxScriptCommands("XYZ_0.ms")

; return
;~LButton & d:: 
; WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
; tool_pathandname = "%activePath%"
; KeyWait, LButton

; ;執行腳本
; runMaxScriptCommands("duplicateBase.ms")
;~return
;清楚材质
;for o in $ do (o.material = undefined)
;macros.run "PolyTools" "TransformTools"
;Shift + C 隐藏摄像机
;Shift + G 隐藏模型
