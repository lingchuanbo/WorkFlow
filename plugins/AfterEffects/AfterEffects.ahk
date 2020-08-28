;Author:BoBO
;Version:2.1

;更新内容
;2020-04-13 细节优化！
;2019-09-02 细节优化！
;2019-08-28 正式提升2.0版本 优化细节 操作更舒服！
;2019-05-07 新增修改选择按键  选择:空格+w 手势平移:空格+w 长按
;2019-03-08 修复打字卡顿
;2019-02-15 1.正式引如F1超强辅助
;           2.删除dd.图层按'dd'删除(帧/效果/表达式/遮罩)& 重置(Transfrom&All)集成F1 操作更人性化
;           3.新增操作11整理素材
;
;2018-12-20 编辑与Space相关操作
;2018-12-11 引入UMSS函数,(已经删除)
;           主要作用引入修饰符作组合
;2018-12-10 引入全局快捷函数
;2018-12-07 封装Ae调用函数使用方式
;           getAeScriptPath =
;           getAeScript(getAeScriptPath)
;2018-12-04 新增双按8循环模式
;           新增自动遮罩分层
;2018-11-19 对图层按'dd'删除(帧/效果/表达式/遮罩)& 重置(Transfrom&All)
;2018-10-25 1.移植Ae脚本到VIMD，已经把常用功能移植到.
;           2.新增操作"/0-5" 打开|保存|最近打开|导入|退出|操作
;           3.优化使用频率 v系组合调整 vcc创建固态 vcn创建合成组
;2018-10-24 新增加zz窗口最大化功能，新增加此功能为了ahk调用脚本时窗口会缩放无法最大化严重影响体验，查阅Google目前还无法解决，但
;           好在窗口最大化环境下可以完美使用，下个版本将把脚本移动本地化运行，实现便携式.
;2018-09-20 新增加输入状态屏蔽功能
;
;功能备忘录
;
;1.一键刷新素材
;
;SetCapsLockState, AlwaysOff
;
AfterEffects:
    ; GetModea
    vim.SetAction("<AfterEffects_NormalMode>", "返回正常模式")
    vim.SetAction("<AfterEffects_InsertMode>", "进入VIM模式")
    ; vim.SetWin("AfterEffects","AE_CApplication_15.1") ; 因为我使用FX console
    vim.SetWin("AfterEffects","ahk_exe","AfterFX.exe") ; 未使用FX console 激活这个可兼容所有版本
    vim.BeforeActionDo("AE_CheckMode", "AfterEffects")

    #Include %A_ScriptDir%\plugins\AfterEffects\AfterEffectsComment.ahk 
    
;normal模式
    vim.SetMode("normal", "AfterEffects")
    vim.Map("<insert>", "<AfterEffects_SwithMode>", "AfterEffects")
;insert模式
    vim.SetMode("insert", "AfterEffects")
    vim.Map("<insert>", "<AfterEffects_SwithMode>", "AfterEffects")
    ;载入按键
    #Include %A_ScriptDir%\plugins\AfterEffects\AfterEffectsKey.ahk
    ;载入增强按键
    #Include %A_ScriptDir%\plugins\AfterEffects\AfterEffectsPlus.ahk
    #Include %A_ScriptDir%\plugins\AfterEffects\AfterEfftetcsMenu.ahk

return

;   输入状时态屏蔽
AE_CheckMode(){
    ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
    ;屏蔽FxConsole
    IfWinActive, ahk_class VCSDK_WINDOW_CLASS
    {
        ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
        return True
    }
    ;表达式编辑器
    IfWinActive, ahk_class DroverLord - Window Class
    {
        ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
        return True
    }
    ControlGetFocus, ctrl, A
    If RegExMatch(ctrl,"i)Edit")
        {
            ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
            return True 
        }
    If (A_Cursor=="IBeam") ;工字光标
        {
            ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
            return True
        }
    else
        {
            ; setEnglishLayout(s=0,h=0) ;操作过程自动切换至英文输入法，如果遇到问题可以注释
            ; Menu, Tray, Icon, %A_ScriptDir%\workflow.ico ;切换到默认模式
            return False
        }
    PixelGetColor, psinputt, 236, 64 ; 
    ; 匹配颜色2018
    if (psinputt = 0x383838) 	;
		{
            Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
            return true
		}

    ; If WinExist("ahk_class VCSDK_WINDOW_CLASS")
    ;     {
    ;         return True 
    ;     }
}


<AeVim>:
    FunBoBO_VimShow()
return

<AE_热键帮助>:  ;{
;    QZ_VIMD_ShowKeyHelp()
return
;}

<AeSpace>:
send,{Space}
return

;   脚本帮助窗口
<HelpAe>:
{
    getAeScript("custom\ae_scripts\commands\Help.jsx")
    return
}

;   全局运行AE
<RunAE>:
    ExePath := ini.BOBOPath_Config.AEPath
    tClass := ini.ahk_class_Config.AEClass
    NewTitle = 【a b同时搜a和b】【a|b搜a或b】【a!b搜a排除b】开正则后.单个?(0或1) *(0或多) +(1或多)  \b边界 ^开始 $结尾 \转义
    FunBoBO_RunActivationTitle(ExePath,tClass,NewTitle) 
    ; FunBoBO_RunActivation(ExePath,tClass)
Return

;   单键切换
<AfterEffects_SwithMode>:

        if AE_var=2 ; 总
        AE_var=0
        AE_var+=1
        AEE_var=0
        if (AE_var=1 )
        {    
            GoSub,<AfterEffects_NormalMode>
            return
        }
        if (AE_var=2)
        {
            GoSub,<AfterEffects_InsertMode>
            return
        }
return

<AfterEffects_Alt>:
		GV_KeyClickAction1 := "SendInput,{Alt}"
		GV_KeyClickAction2 := "GoSub,menuAeAlt"
		GoSub,Sub_KeyClick
return		

<displyTips>:
    ; 测试显示
    hParent := WinExist("ahk_exe AfterFX.exe")
    ; Gui, -Caption HWNDhChild
    DllCall("SetParent", Ptr, hChild, Ptr, hParent)
    ToolTip,Hello,100,150
return
;   默认模式
<AfterEffects_NormalMode>:
    SetModUINormal()
    ; getMOD=vim.ExistMode()
    ; MsgBox %getMOD%
    vim.SetMode("normal", "AfterEffects")
return
;   进入模式
<AfterEffects_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "AfterEffects")
return

; <Ae_Remove>:
;     send, ^+{e}
; return

;基本操作

;   打开
<Ae_Open>:
{
    send,^o
    return
}


<Ae_OpenRecent>:
{
    send,^!+p
    return
}

;   保存
<Ae_Save>:
{
    send,^s
    return
}

;   另存为
<Ae_SaveAs>:
{
    send,^+s
    return
}

;   导入
<Ae_Import>:
{
    send,^i
    return
}

;   退出
<Ae_Exit>:
{
    send,^q
    return
}

;   简化文件
<Ae_CllectFiles>:
{
    getAeScriptCommand(app.executeCommand(2482))
    return
}

;   清理内存
<Ae_AllMemoryDisk>:
{
    getAeScriptCommand(app.executeCommand(10200))
    return
}

<Ae_SwitchLabel>:
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, s
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,^{w}
        return
    }
    KeyWait, s, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
            tool_pathandname = "%activePath%"
            send !+{<}
            return

        }
    else
        {
            WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
            tool_pathandname = "%activePath%"
            send !+{>}
            return
        }
return




;新建
<AfterEffects_新建合成>:
    send, ^n
return

<AfterEffects_固态层>:
    send, ^y
return

<AfterEffects_调节层>:
    send, ^!y
return

<AfterEffects_Null>:
    send, ^!+y
return

<AfterEffects_优化合成时间>:
    send, ^+x
Return

<AfterEffects_渲染输出>:
    send, ^m
Return

<AfterEffects_QuickMenu>:
    send, ^!6
return

<AfterEffects_我的工具>:
    send, ^!7
return

;面板

<Ae_ui_y>:
{
    return
}
return
; Double组


; Double_K 合成设置
; #if WinActive("ahk_class Qt5QWindowIcon")
<Ae_Double_0>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, 0
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ;Null Command
        return
    }
    KeyWait, 0, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {       
        getAeScript("custom\ae_scripts\commands\resetTransformations.jsx")
        return
    }

    else
    {
        send, {0}
        return
    } 
}
<Ae_Double_Tab>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_Tab, %t%
    if (t == "off")
    goto ae_double_Tab
    return
    ae_tappedkey_Tab:
        {
            Send, {Tab}
            return
        }
    return

    ae_double_Tab:
        {
            GoSub,<Ae_Script_QuickMenu>
            return
        }
    return
}
<Ae_Double_F2>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_F2, %t%
    if (t == "off")
    goto ae_double_F2
    return
    ae_tappedkey_F2:
        {
            Send, {PgUp}
            return
        }
    return

    ae_double_F2:
        {
            Send, {Home}
            return
        }
    return
}

<Ae_Double_F3>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_F3, %t%
    if (t == "off")
    goto ae_double_F3
    return
    ae_tappedkey_F3:
        {
            Send, {PgDn}
            return
        }
    return

    ae_double_F3:
        {
            Send, {End}
            return
        }
    return     

}

<Ae_Double_F4>:
{
    ; DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; ; Wait for 'd' to be released
    ; KeyWait, F4
    ; if (A_TimeSinceThisHotkey > DoubleClickTime) {
    ;     ; Send,^+{w}
    ;     ; Click 1
    ;     return
    ; }
    ; KeyWait, F4, % "d T"DoubleClickTime/1000
    ; If ! Errorlevel
    ;     {
    ;         Send, ^{w}
    ;         return
    ;     }
    ; else
    ;     {
            getAeScript("custom\ae_scripts\add_keys.jsx")
            return
        ; }
return
}
<Ae_Double_8>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_8, %t%
    if (t == "off")
    goto ae_double_8
    return

    ae_tappedkey_8:
    Send, 8
    return

    ae_double_8:
        getAeScript("custom\ae_scripts\(BOBOToolsFunctions)\LoopMaker.jsx")
    return
}
<Ae_Double_F9>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_F9, %t%
    if (t == "off")
    goto ae_double_F9
    return

    ae_tappedkey_F9:
        Send, ^{m}
    return

    ae_double_F9:
        getAeScript("custom\ae_scripts\(BOBOToolsFunctions)\SPRenderQueueTools.jsx")
    return
}
Return

<Ae_Double_y>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, y
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,{Delete}
        Click 1
        return
    }
    KeyWait, y, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            send, ^+{y}
            return

        }
    else
        {
           ; Send, y
           ;快速创建
            send, ^y
            sleep 100
            send {Enter}
            return
        }
return
}

<Ae_Double_h>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, h
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        getAeScript("custom\ae_scripts\commands\layer_Lock.jsx")
        Click 1
        return
    }
    KeyWait, h, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            getAeScript("custom\ae_scripts\commands\layer_Solo.jsx")
            return
        }
    else
        {
            getAeScript("custom\ae_scripts\commands\layer_Hides.jsx")
            return
        }
return
}

<Ae_Double_w>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, w
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ; send, ^{w}
        return
    }
    KeyWait, w, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            Send,w
            
            return

        }
    else
        {
            Send, v
            return
        }
}
Return

<Ae_Double_Ctrl>:
{
    ; ; GetKeyState("Ctrl", "T")
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, ae_tappedkey_Ctrl, %t%
    ; if (t == "off")
    ; goto ae_double_Ctrl
    ; return
    ; ae_tappedkey_Ctrl:
    ;     {
    ;         Send, {Ctrl}
    ;         return
    ;     }
    ; ae_double_Ctrl:
    ;     {
    ;         getAeScript("custom\ae_scripts\add_keys.jsx")
    ;         return
    ;     }
    ; KeyWait,Ctrl
    ; return


    ; KeyWait,Ctrl
    ; if A_TimeSinceThisHotkey >= 300 ; in milliseconds.
    ; {
    ;     Send, {Ctrl}
    ;     return
    ; }
}
Return
<Ae_Double_Shift>:
{
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, ae_tappedkey_Shift, %t%
    ; if (t == "off")
    ; goto ae_double_Shift
    ; return
    ; ae_tappedkey_Shift:
    ;     {
    ;         Send, {Shift}
    ;         return
    ;     }


    ; ae_double_Shift:
    ;     {
    ;         send +{F3}
    ;         return
    ;     }
    keyPress:=analyseKeyPress()
	if (keyPress=1){
        Send, {Shift}
        return
	}
    if (keyPress=2){
        send +{F3}
        return
	}
    return
}
Return

<Ae_Double_d>:

    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, d
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,{Delete}
        Click 1
        return
    }
    KeyWait, d, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            Send,^{d}
            
            return

        }
    else
        {
            Send, d
            return
        }
return

<Ae_Double_k>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_k, %t%
    if (t == "off")
    goto ae_double_k
    return

    ae_tappedkey_k:
    Send, k
    return

    ae_double_k:
    send, ^k
}
Return

<Ae_Double_e>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_e, %t%
    if (t == "off")
    goto ae_double_e
    return

    ae_tappedkey_e:
    ; Send, e
    GoSub,<Ae_RevealLayerSourceInProject>
    return

    ae_double_e:
        If ProcessExist("TOTALCMD.exe"){
            getAeScript("custom\ae_scripts\commands\RevealInFinderTC.jsx")
        }else{
            getAeScript("custom\ae_scripts\commands\RevealInFinder.jsx")
        }
}
Return

<Ae_RevealInFinder>:
{
    If ProcessExist("TOTALCMD.exe"){
        getAeScript("custom\ae_scripts\commands\RevealInFinderTC.jsx")
    }else{
        getAeScript("custom\ae_scripts\commands\RevealInFinder.jsx")
    }
}
<Ae_RevealLayerSourceInProject>:
{
    getAeScript("custom\ae_scripts\commands\RevealLayerSourceInProject.jsx")
    return
}

; 快速定位Ae文件
<Ae_Double_FindAeFiles>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_FindAe, %t%
    if (t == "off")
    goto ae_double_FindAe
    return

    ae_tappedkey_FindAe:
    Send, e
    return

    ae_double_FindAe:
        If ProcessExist("TOTALCMD.exe"){
            SaveFileFindForTc()
        }else{
            SaveFileFindForExplorer()
        }
}
Return

<ae_double_1>:
{
	GV_KeyClickAction1 := "Gosub,<Ae_Double_[>"
	GV_KeyClickAction2 := "Gosub,<Ae_SplitLayer>"
	GoSub,Sub_KeyClick
    Return
}

<Ae_Double_2>:
{
	GV_KeyClickAction1 := "Gosub,<Ae_Double_]>"
	GV_KeyClickAction2 := "send,+{F3}"
	GoSub,Sub_KeyClick
    return
}

<Ae_Double_3>:
{
    send,{RButton}
    Return
}



<Ae_Double_F1>:
    ; MsgBox,大侠停住 , 此乃捐赠功能 【 F1超级模式 】！！！`n`n 如需开启请联系本主在下！`n`nEmail:lingchuanbo@gmail.com
    ; return
    ; 单F1超级模式 双按F1优化AE
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, ae_tappedkey_F1, %t%
    ; if (t == "off")
    ; goto ae_double_F1
    ; return
    ; ae_tappedkey_F1:
    ;     {

    GroupAdd,AfterEffects,ahk_exe AfterFX.exe
    GroupAdd,AfterEffects,ahk_class %tClass% 


    WinActivate,ahk_group AfterEffects

    MouseGetPos, MX, MY
    MouseX:=MX-325
    MouseY:=MY-150 
    Gui,Ae: Show,X%MouseX% Y%MouseY% ,NoActivate ; 
    ;保存当前信息
    KeyWait,1
    Sleep, 20                                                                                              
    IfWinActive, ahk_class AutoHotkeyGUI
    { 
        Click down 
        Sleep, 20  
        Click up
        Sleep, 20                 
        Gui,Ae: Hide
        sleep 200
        Click 1
    }
return
; Double_Q 渲染输出
; #if WinActive("ahk_class Qt5QWindowIcon")
; <Ae_Double_1>:
; 		; GV_KeyClickAction1 := "GoSub,<Ae_Double_F1>"
; 		; GV_KeyClickAction2 := getAeScript("custom\ae_scripts\commands\OrganizeProjectAssets.jsxbin")
; 		; GoSub,Sub_KeyClick
;     ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
;     ; settimer, ae_tappedkey_1, %t%
;     ; if (t == "off")
;     ; goto ae_double_1
;     ; return
;     ; ae_tappedkey_1:
;     ;     ; getAeScript("custom\ae_scripts\commands\OrganizeProjectAssets.jsxbin")
;         GoSub,<Ae_Double_F1>
;     ; return

;     ; ae_double_1:
;     ;     getAeScript("custom\ae_scripts\commands\OrganizeProjectAssets.jsxbin")
;     ;     ; sleep 500
;     ;     ; getAeScript("custom\ae_scripts\commands\deleteDiskCache.jsx")
;     ; return
; return
<Ae_OrganizeProjectAssetsDiskCache>:
        getAeScript("custom\ae_scripts\commands\OrganizeProjectAssets.jsxbin")
        sleep 500
        getAeScript("custom\ae_scripts\commands\deleteDiskCache.jsx")
        sleep 500
        Process, Wait, memreduct.exe, 1
        NewPID := ErrorLevel  ; 由于 ErrorLevel 会经常发生改变, 所以要立即保存这个值.
        if not NewPID
        {
            Run,%A_ScriptDir%\tools\TotalCMD\Tools\MemReduct\memreduct.exe
            Sleep, 200
            Send, ^{F1}
            return
        }
        if NewPID
        {
            Send, ^{F1}
            return
        }
return

<Ae_Double_q>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, q
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ; send, ^k
        return
    }
    KeyWait, q, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            send, ^m
            return

        }
    else
        {
            Send {q}
            return
        }
    return
}
Return

; Double_C 合成组
<Ae_Double_c>:
{

    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, c
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        send, ^k
        return
    }
    KeyWait, c, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
               send,^+c
            return

        }
    else
        {
            Send, ^n
            return
        }
return

}
Return


<Ae_Double_x>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, x
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
            MsgBox, 4,, 危险操作 清除当前所有特效 继续? (press Yes or No)
            IfMsgBox Yes
            {
                ToolTip, 执行 清除...请稍后！
                sleep 100
                send, ^+{e}
                SetTimer, RemoveToolTip, -1000
                return
            }
            IfMsgBox No
            {
                return
            }
        ; 删除所有效果
        
        return
    }
    KeyWait, x, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            send, ^w
            return

        }
    else
        {
            Send,x
            return
        }
return

}
Return
; Double_z 最大化显示
<Ae_Double_z>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_z, %t%
    if (t == "off")
    goto ae_double_z
    return

    ae_tappedkey_z:
    Send,z
    return

    ae_double_z:
    send, ^!\
    return
}
Return
; Double_o 打开
<Ae_Double_o>:
{
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
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, ae_tappedkey_o, %t%

    ; if (t == "off")
    ; goto ae_double_o
    ; return

    ; ae_tappedkey_o:
    ; Send,o
    ; return

    ; ae_double_o:
    ; Send,^o
    ; return
}
Return
<Ae_Double_n>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'c' to be released
    KeyWait, n
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ;创建调节层
        send, ^!y
        return
    }
    KeyWait, n, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {       

        ;创建新合成
        send, ^n
        return
    }

    else
    {
        send, ^y
        return
    } 
}
<Ae_Double_[>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, [
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ;Null Command
        return
    }
    KeyWait, [, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {       
        send, {b}
        return
    }

    else
    {
        send, {[}
        return
    } 
}
<Ae_Double_]>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    KeyWait, ]
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ;Null Command
        return
    }
    KeyWait, ], % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {       
        send, {n}
        return
    }
    else
    {
        send, {]}
        return
    } 
}
<Ae_Double_->:
{
        send, {,}
        return
    ;} 
}
<Ae_Double_=>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ae_tappedkey_minimize, %t%

    if (t == "off")
    goto ae_double_minimize
    return

    ae_tappedkey_minimize:
    send, {.}
    return

    ae_double_minimize:
    Send,{/}
    ; sleep 100
    ; Send,n
    return  
    ;} 
}

; Shift:
;     WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
;     tool_pathandname = "%activePath%"
;     if (A_PriorHotkey <> "~LShift" or A_TimeSincePriorHotkey > 400) 
;     { 
;         KeyWait, LShift
;         return 
;     } 
;     ;執行腳本
;     send +{F3}
; return

; Ctrl:
; ; ~LCtrl::  
;     if (A_PriorHotkey <> "~LCtrl" or A_TimeSincePriorHotkey > 400) 
;     { 
;         KeyWait, LCtrl
;         return 
;     } 
;     ;執行腳本
;     getAeScript("custom\ae_scripts\add_keys.jsx")
; return


; 长按

;長鍵add position key
<Ae_Press_p>:
{
    KeyWait,p
    if A_TimeSinceThisHotkey >= 300 ; in milliseconds.
    {
        send !+p
    }
    else
        send p
    return
}

;长按add scale key
<Ae_Press_s>:
{
    KeyWait,s
    if  A_TimeSinceThisHotkey >= 300  ; in milliseconds.
    {
        send !+s
    }
    else
        send s
    return
}

;长按add rotation key0
<Ae_Press_r>:
{
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'c' to be released
    KeyWait, r
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        send, !+r
        return
    }
    ; Wait for 'c' to be pressed down again (option "d")
    ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
    KeyWait, r, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {
        getAeScript("custom\ae_scripts\commands\RevealLayerSourceInProject.jsx")
        return
    }
    else
    {
        send, {r}
        return
    } 
    Return
}

;长按add opacity key
<Ae_Press_t>:
{
    KeyWait,t
    if A_TimeSinceThisHotkey >= 300 ; in milliseconds.
    {
        send, !+t
    }
    else
        send, t
    return
}
;按键
; <Ae_key_vh>:
; {
;     If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
; 		Send h
; 	else
; 		Send v
; 	return
; }


<Ae_Help3>:
{
    Run,https://www.kancloud.cn/funbobosky/vimd_aftereffect
    return
}


<ShowHelp2>:
{
    getAeScript("custom\ae_scripts\ShowHelp2.jsx")
    return
}
<PluginsReg>:
{
    GoSub, PluginsReg
    sleep 100
    getAeScript("custom\ae_scripts\commands\PluginsReg.jsx")
    return
}
<Ae_ReloadFootage>:
{
    getAeScript("custom\ae_scripts\commands\ReloadFootage.jsx")
    return
}
;调用Script
<AfterEffects_全局控制初始化>:
{
    getAeScript("custom\ae_scripts\commands\Global.jsx")
    return  
}
<Ae_Script_Render>:
{
    getAeScript("custom\ae_scripts\(BOBOToolsFunctions)\SPRenderQueueTools.jsx")
    return  
}

<Ae_Script_BoboTools>:
{
    getAeScript("custom\ae_scripts\02_BOBO_Tools.jsx ")
    return
}

<Ae_Script_KeyBoard>:
{
    ; AeScriptPath = %A_ScriptDir%\custom\ae_scripts\01_Key-board.jsxbin
    ; getAeScript(AeScriptPath)
    return
}

<Ae_Script_QuickMenu>:
{
    getAeScript("custom\ae_scripts\00_QuickMenu.jsxbin")
    return
}
<Ae_Script_AEProject>:
{
    getAeScript("custom\ae_scripts\AEProject.jsxbin")
    return
}
<Ae_Script_batchFootage>:
{
    getAeScript("custom\ae_scripts\commands\batchFootage.jsxbin")
    return
}
<Ae_Script_CompSetter>:
{
    getAeScript("custom\ae_scripts\commands\CompSetter.jsx")
    return
}
<Ae_Script_AutoMatte>:
{
    getAeScript("custom\ae_scripts\commands\cz_AutoMatte.jsxbin")
    return
}
<Ae_Script_GlobalRename>:
{
    getAeScript("custom\ae_scripts\AEGlobalRenamer.jsxbin")
    return
}
<Ae_OrganizeProjectAssets>:
{
    getAeScript("custom\ae_scripts\commands\OrganizeProjectAssets.jsxbin")
    return
}
<Ae_ProjectCleaner>:
{
    getAeScript("custom\ae_scripts\commands\ProjectCleaner.jsx")
    return
}
<Ae_AutoUpdate>:
    Gui,Ae_insert: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,Ae_insert: Color, %color2%
    Gui,Ae_insert: Font,cwhite s20 %FontSize% wbold q5,Segoe UI
    Gui,Ae_insert: Add, Text, ,%_AutoUpdate%
    Gui,Ae_insert: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
    sleep %SleepTime%
    Gui,Ae_insert: Destroy
    ; 更新第一个文件
    updateIntervalDays := 0
    VERSION_REGEX := "Oi)(?<=Version )?(\d+(?:\.\d+)?)"
    WhatNew_REGEX := "Ois)(?<=----)\R(.*?)(\R\R|$)"
    AutoUpdate(_UrlDownloadToFILE_Ae_1,, updateIntervalDays, [_UrlDownloadToFILE_Photoshop_CHANGELOG, VERSION_REGEX, WhatNew_REGEX])
    ; 更新第二个文件
    sleep 1000
    updateIntervalDays := 0
    VERSION_REGEX := "Oi)(?<=Version )?(\d+(?:\.\d+)?)"
    WhatNew_REGEX := "Ois)(?<=----)\R(.*?)(\R\R|$)"
    AutoUpdate(_UrlDownloadToFILE_Ae_2,, updateIntervalDays, [_UrlDownloadToFILE_Photoshop_CHANGELOG, VERSION_REGEX, WhatNew_REGEX])
    sleep 1000
    ; 更新第三个文件
    updateIntervalDays := 0
    VERSION_REGEX := "Oi)(?<=Version )?(\d+(?:\.\d+)?)"
    WhatNew_REGEX := "Ois)(?<=----)\R(.*?)(\R\R|$)"
    AutoUpdate(_UrlDownloadToFILE_Ae_3,, updateIntervalDays, [_UrlDownloadToFILE_Photoshop_CHANGELOG, VERSION_REGEX, WhatNew_REGEX])
    sleep 1000
    ; 更新第三个文件
    updateIntervalDays := 0
    VERSION_REGEX := "Oi)(?<=Version )?(\d+(?:\.\d+)?)"
    WhatNew_REGEX := "Ois)(?<=----)\R(.*?)(\R\R|$)"
    AutoUpdate(_UrlDownloadToFILE_Ae_4,, updateIntervalDays, [_UrlDownloadToFILE_Photoshop_CHANGELOG, VERSION_REGEX, WhatNew_REGEX])
    sleep 1000
    Reload
return

; 先按鼠标在按按键

; 图层模式切换
; ~LButton & d::
<Ae_differenceToggle>:
{
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton

    ;執行腳本
    getAeScript("custom\ae_scripts\differenceToggle.jsx")
return
}

;截取图层
;按左鍵再按[
<Ae_LayerInterceptLeft>:
{
; ~LButton & [:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    send, !{[}
return
}

;按左鍵再按]
<Ae_LayerInterceptRight>:
{
; ~LButton & ]:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    send, !{]}
    return
}

;按左鍵再按g
<Ae_layerGuideLayer>:
; ~LButton & g:: 
{
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    ;執行腳本
        getAeScript("custom\ae_scripts\commands\layer_GuideLayer.jsx")
    return
}

<Ae_jumpToKey>:
{
; ~LButton & j:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton

    ;執行腳本
    getAeScript("custom\\ae_scripts\jumpToKey.jsx")
    return

}
;按左鍵再按h
<Ae_MaskAndShapeVisibility>:
; ~LButton & h:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    ;執行腳本
    send +^H
    send v
return


;按左鍵再按n
<Ae_simpleNamer>:
;~LButton & n:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton

    CoordMode, Mouse,Screen
    MouseGetPos, xpos, ypos  
    FileDelete, %A_AppData%\\Ola script UI\cursorPos.txt
    FileAppend, %xpos%`,%ypos%, %A_AppData%\\Ola script UI\cursorPos.txt

    ;執行腳本
    getAeScript("custom\ae_scripts\simpleNamer 1.1.jsxbin")
return

;按左鍵再按n
<Ae_PointCenter>:
; ~LButton & c:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton

    send ^!{Home}

return


<Ae_foolParent>:
;~LButton & a:: 
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton

    ;if FileExist("%A_AppData%\\Ola script UI\cursorPos.txt")
    CoordMode, Mouse,Screen
    MouseGetPos, xpos, ypos  
    FileDelete, %A_AppData%\\Ola script UI\cursorPos.txtcursorPos.txt
    FileAppend, %xpos%`,%ypos%, %A_AppData%\\Ola script UI\cursorPos.txt

    ;執行腳本
    getAeScript("custom\\ae_scripts\foolParent.jsxbin")
return

<Ae_CopyPaste>:
; ~LCtrl & c::
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'c' to be released
    KeyWait, c
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Msgbox Longpress
        return
    }
    ; Wait for 'c' to be pressed down again (option "d")
    ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
    KeyWait, c, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        send ^{v}
    else
        send ^{c}
Return

;调用动画预设文件
<Ae_Double_f>:
	GV_KeyClickAction1 := "send,{f}"
	GV_KeyClickAction2 := "Gosub,<Ae_Preset_Apply>"
	GoSub,Sub_KeyClick
return
<Ae_Preset_Apply>:
{
    send ^+!{f}
    return
}
<Ae_Preset_Ani1>:
{
	Gui,Ae: Hide
    getAeScript("custom\ae_scripts\PresetAnimation\add_PresetAnimation_1.jsx")
    return
}
   
<Ae_Help>:
    run,https://www.kancloud.cn/funbobosky/vimd_aftereffect
return

<Ae_Help_Script>:
    run,http://estk.aenhancers.com/#SingleInstance, Force
return

<Ae_FXConsole>:
    send {LCtrl}{Space}
return

<Ae_ReplaceFootageFile>:
{
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    send, ^{h}
    return
}

<Ae_doubleTest>:
{   
	keyPress:=analyseKeyPress()
	if (keyPress=1){
            MsgBox 测试
	}
    if (keyPress=2){
            MsgBox 测试2
	}
    return
}

<Ae_Test>:
    MsgBox 测试
return

; Ae_Test2:
; MsgBox 测试2
; return
<Ae_Tab>:
{
    send {Tab}
    return
}
<Ae_Delete>:
{
    send,{Delete}
    return
}
<Ae_Copy>:
{
    send ^{c}
    return
}
<Ae_Paste>:
{
    send ^{v}
    return
}
<Ae_RButton>:
{
    send ^{v}
    return
}

<Ae_SplitLayer>:
    getAeScript("custom\ae_scripts\commands\SplitLayer.jsx")
return

<Ae_ReduceNoFootage>:
{
    getAeScript("custom\ae_scripts\commands\BoBO_Reduce.jsx")
    return
}

<Ae_ReduceProject>:
{
    MsgBox, 4,Reduce Project, 简化项目文件 继续?
    IfMsgBox Yes
        {
            ToolTip, 正在简化中...请稍后！
            sleep 100
            getAeScript("custom\ae_scripts\commands\ReduceProject.jsx")
            SetTimer, RemoveToolTip, -1000
            return
        }
    else
        {
            return 
        }
        return
}
<Config写入AE路径>:
{
    getAeExePath := GetProcessPath("AfterFX.exe")
    IniWrite, %getAeExePath%, config.ini, BOBOPath_Config, AEPath 
    MsgBox "写入成功！"
    return
}

<Ae_UpDater>:
Gui,Updating: +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui,Updating: Color, %color2%
Gui,Updating: Font,cwhite s%FontSize% wbold q5,Segoe UI
Gui,Updating: Add, Text, ,%_AeUpdating%
Gui,Updating: Show,AutoSize Center NoActivate
UrlDownloadToFile, %UrlDownloadToFile_Ae1%, %A_ScriptDir%\plugins\AfterEffects\latest-Aftereffects.ahk ;

if ErrorLevel
{
    Gosub, AeExitUpdater
}
Else
{
    FileMove,%A_ScriptDir%\plugins\AfterEffects\latest-Aftereffects.ahk, %A_ScriptDir%\plugins\AfterEffects\Aftereffects.ahk,1
    Gosub, AeExitUpdater
}
return

AeExitUpdater:
FileDelete, %A_ScriptDir%\plugins\AfterEffects\latest-Aftereffects.ahk
sleep %SleepTime%
Gui,Updating: Hide
Return


;载入UMSS/增强功能
;#Include,%A_ScriptDir%\plugins\AfterEffects\AfterEffectsKeyUMSS.ahk
;UMSS/增强功能


; #If GetKeyState(N1.keys,"p") AND WinActive("ahk_exe AfterFX.exe") ;## 语境约束:意思是当keys被实际按下时,以下内容就生效
; q::
; 	N1.ST() ;## 这个函数的意思是告诉程序已经触发功能,不需要再等,Send模式1和Send模式2用得到,Send模式3用不到
; 	MsgBox,%Change_History%

;     Change_History=
;         (
;         使用本脚本请在Ae窗口双按zz下最大化使用，效果最佳，否则会有点影响体验!
;         )
; return

; #If ;## 语境约束结束
; #If GetKeyState(N2.keys,"p") AND WinActive("ahk_exe AfterFX.exe") ;## 语境约束:意思是当keys被实际按下时,以下内容就生效
; 1::
; 	N2.ST() ;## 这个函数的意思是告诉程序已经触发功能,不需要再等,Send模式1和Send模式2用得到,Send模式3用不到
;     WinActive ("ahk_exe AfterFX.exe")
; 	Send,^{Tab}
; return

; #If ;## 语境约束结束
; #If GetKeyState(N2.keys,"p");## 语境约束:意思是当keys被实际按下时,以下内容就生效
; s::
;     N2.ST() ;
;     run,%A_ScriptDir%\apps\TaskSwch\TaskSwch.exe
;     return
; #If ;## 语境约束结束

; Project界面操作,有点神经病大概率会是windows Class3
#If ActiveControlIs("DroverLord - Window Class3")
; ~LButton:: 
; ;~ 是否双击判定
;     if (A_ThisHotkey!=A_PriorHotkey)
;         send,{Space}
;         return
; return
; 6::
; MsgBox 测试项目窗口
return
; e::
; {
;     DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
;     ; Wait for 'c' to be released
;     KeyWait, e
;     if (A_TimeSinceThisHotkey > DoubleClickTime) {
;         ; send, ^{h}
;         return
;     }
;     ; Wait for 'c' to be pressed down again (option "d")
;     ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
;     KeyWait, e, % "d T"DoubleClickTime/1000
;     If ! Errorlevel
;     {       
;         AeScriptPath = %A_ScriptDir%\custom\ae_scripts\commands\RevealInExplorer.jsx
;         getAeScript(AeScriptPath)
;         return
;     }

;     else
;     {
;         send, e
;         return
;     } 
; }
; Return
; F5::
; {
;     ; 1.ReloadFootage | 2.ReduceProject  |  long：CollectFiles
;     DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
;     KeyWait, F5
;         if (A_TimeSinceThisHotkey > DoubleClickTime) {
;             MsgBox, 4,, 执行打包 continue? (press Yes or No)
;             IfMsgBox Yes
;             {
;                 ToolTip, 执行打包...请稍后！
;                 sleep 100
;                 getAeScript("custom\ae_scripts\commands\CollectFiles.jsx")
;                 SetTimer, RemoveToolTip, -1000
;                 return
;             }
;         else
;             {
;                 return
;             }
;                 ; MsgBox You pressed No.           
;     }
;     KeyWait, F5, % "d T"DoubleClickTime/1000
;     If ! Errorlevel
;     {       
;         MsgBox, 4,Reduce Project, 简化项目文件 继续?
;         IfMsgBox Yes
;             {
;                 ToolTip, 正在简化中...请稍后！
;                 sleep 100
;                 getAeScript("custom\ae_scripts\commands\ReduceProject.jsx")
;                 SetTimer, RemoveToolTip, -1000
;                 return
;             }
;         else
;             {
;                 return 
;             }
            
;     }
;     else
;     {
;         getAeScript("custom\ae_scripts\commands\ReloadFootage.jsx")
;         ToolTip, 正在刷新素材请稍后！
;         SetTimer, RemoveToolTip, -2000
;         return
;     } 
; }
; Return

n::
{
    ;1 NewCompFromSelection| 2 InterpretFootage | long:CompSetter
    DoubleClickTime := DllCall("GetDoubleClickTime") ; 
    KeyWait, n
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        ;CompSetter
        getAeScript("custom\ae_scripts\commands\CompSetter.jsx")
        return
    }
    KeyWait, n, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {   
        ;Interpret Footage
        send, ^!{g}
        return
    }

    else
    {
        ;NewCompFromSelection
        getAeScript("custom\ae_scripts\commands\NewCompFromSelection.jsx")
        return
    } 
}

<Ae_ReplaceFootageFile2>:
{
    ; 替换素材
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    send, ^{h}
    return
}
#If
ActiveControlIs(Control) {
    ControlGetFocus, FocusedControl, A
    return (FocusedControl=Control)
}

<Ae_切换语言>:
{
    ExePath := ini.BOBOPath_Config.AEPath
    painterIni := StrReplace(ExePath, "AfterFX.exe","painter.ini")

    IniRead, OutputVar, %painterIni%, Config, Language
    IniWrite, en_US,%painterIni%, Config, Language
    IniWrite, 1, %painterIni%, Config, ForceLanguage

    if (OutputVar="en_US")
    {
    MsgBox,4,After Effects CC 2018 语言切换 By_BoBO, 当前语言是: 英文 是否切换 中文？
    IfMsgBox, Yes
        IniWrite, zh_CN, %painterIni%, Config, Language
        MsgBox 【记得重启AE】
    Return
    }if (OutputVar="zh_CN")
    {
        MsgBox,4,After Effects CC 2018 语言切换 By_BoBO, 当前语言是: 中文 是否切换 英文？
        IfMsgBox, Yes
        IniWrite, en_US, %painterIni%, Config, Language
        MsgBox 【记得重启AE】
        Return
    }

}


