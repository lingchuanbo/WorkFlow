;Author:BoBO
;Version:v1.1
;Date:20200412
;########################################
;更新内容
;2019-08-09 空格+1 笔刷变小  空格+3 笔刷变大  空格+2 橡皮檫
;
;
;2019-08-08 F2标签切换双按逆 | F3增加颜色明度 | F4增加颜色暗度  
;---------- 空格+w 当前图层上移动    空格+s 当前图层下移动
;---------- 空格+q 透明度加5        空格+e 透明度减5
;---------- 双按c 颜色面板          双按g 填充
;2019-08-07 Photoshop框架搭建
;
;
;已知Bug：归为0时如果是空对象 会导致报错 需要加个判断执行
;重命名大于3层 会莫名其妙新建个图层
Photoshop:
;定义注释
    global Photoshop_update_version:="0.8"

    vim.SetAction("<Photoshop_NormalMode>", "返回正常模式")
    vim.SetAction("<Photoshop_InsertMode>", "进入VIM模式")
    vim.SetWin("Photoshop","ahk_exe","photoshop.exe")

;normal模式
    vim.SetMode("normal", "Photoshop")
    vim.Comment("<Photoshop_SwithMode>", "【-----模式切换-----】")
    vim.map("<insert>","<Photoshop_SwithMode>","Photoshop")
;insert模式
    ;载入自定义注释
    #Include %A_ScriptDir%\plugins\Photoshop\PhotoshopComment.ahk 
    vim.SetMode("insert", "Photoshop")
    vim.Map("<insert>", "<Photoshop_SwithMode>", "Photoshop")

    ; vim.Map("q", "<PS_Duplicate_画笔橡皮擦涂抹>", "Photoshop")
    vim.Map("<Alt>", "<Photoshop_Alt>", "Photoshop")
    vim.Map("w", "<PS_OneKeyDefault>", "Photoshop")
    vim.Map("q", "<PS_选区切换>", "Photoshop")

    vim.Map("e", "<PS_选区合并>", "Photoshop")
    ; vim.Map("e", "<PS_OneKeyDefaultSmudgePath>", "Photoshop")
    vim.Map("r", "<PS_Duplicate_旋转>", "Photoshop")
    
    vim.Map("g", "<PS_GradientPaint>", "Photoshop")
    vim.Map("b", "<PS_Brush_Swith>", "Photoshop")
    vim.Map("h", "<PS_Duplicate_独立显示>", "Photoshop")

    vim.Map("0", "<PS_Duplicate_图层中心>", "Photoshop")
    vim.Map("1", "<PS_Brush_Small>", "Photoshop")
    vim.Map("2", "<PS_Brush_Big>", "Photoshop")
    vim.Map("-", "<PS_Screen_Small>", "Photoshop")
    vim.Map("=", "<PS_Screen_Big>", "Photoshop")


    vim.Map("o", "<PS_Duplicate_打开保存>", "Photoshop")
    vim.Map("d", "<PS_Duplicate_D>", "Photoshop")
    vim.Map("n", "<PS_Double_N>", "Photoshop")
    vim.Map("x", "<PS_Duplicate_X>", "Photoshop")
    vim.Map("t", "<PS_Double_T>", "Photoshop")
    

    vim.Map("c", "<PS_颜色面板>", "Photoshop")

    vim.Map("<F2>", "<PS_切换标签>", "Photoshop")
    vim.Map("<F7>", "<PS_创建新文档>", "Photoshop")

    vim.Map("<F8>1", "<PS_Remove_AllEmptyLayer>", "Photoshop")
    vim.Map("<F8>2", "<PS_Remove_AllInvisibleHiddenLayers>", "Photoshop")
    vim.Map("<F8>3", "<PS_Script_RotateMe>", "Photoshop")
    vim.Map("<F8>4", "<PS_Script_TransformEach>", "Photoshop") 

    vim.map("?","<ShowHelp>","Photoshop")

    vim.Map("/u", "<PS_AutoUpdate>", "Photoshop")
    

    ; vim.Map("<F1>", "<PS-Test>", "Photoshop")
    vim.Map("<LB-d>", "<PS_向下合并>", "Photoshop")
    vim.Map("<LB-e>", "<PS_多边形选区>", "Photoshop")


    vim.BeforeActionDo("Photoshop_CheckMode", "Photoshop") ; by Array
return
; 对符合条件的控件使用insert模式，而不是normal模式
Photoshop_CheckMode()
{
    ControlGetFocus, ctrl, A
    PixelGetColor, psinputt, 13, 473 ; By 天甜
    ;匹配颜色2019
    if ((psinputt = 0x1f1f1f) or (psinputt = 0x383838) or (psinputt = 0x808080) or (psinputt = 0xbfbfbf)) 	;
		{
		    return true
		}
    if RegExMatch(ctrl, "i)Edit")  ; or WinExist("ahk_class #32770"))
    {
        return True
    }
    else
    {
        return False
    }
    return
}
PSCheckInput()
{
	ControlGetFocus, ctrl, A	;if (RegExMatch(ctrl, "Edit|Static88") or WinExist("ahk_class #32768"))
	PixelGetColor, psinputt, 16, 493
	;~ PixelGetColor, psinputj, 30, 38
    if (psinputt = 0x383838) ;&& (psinputj = 0x989898)) 	;Static88为输入文字时的ClassNN
		{
		return true
		}
    if (A_CaretX) 	;Static88为输入文字时的ClassNN
		{
		return true
		}
    if (RegExMatch(ctrl, "Edit|Static151|Static88")) ;|| (ConvMode = 1025) || A_CaretX	;Static88为输入文字时的ClassNN
		{
		return true
		}
    if (RegExMatch(ctrl, "Static152"))
		{
		return false
		}
	else
	{
		return false
	}
}

<Photoshop_Alt>:
		GV_KeyClickAction1 := "send,{Alt}"
		GV_KeyClickAction2 := "GoSub,menuPsAlt"
		GoSub,Sub_KeyClick
return	

;【全局运行PS】
<RunPS>:
    ExePath := ini.BOBOPath_Config.PSPath
    tClass := ini.ahk_class_Config.PSClass
    FunBoBO_RunActivation(ExePath,tClass)
 Return

<PS-Test>:
; global TxFileRecv = ini.config.TxFileRecv
; msgbox %TxFileRecv%
return


 <Photoshop_SwithMode>:
;   单键切换
        if PS_Swith_var=2 ;
        PS_Swith_var=0
        PS_Swith_var+=1
        PS_var=0
        if (PS_Swith_var=1 )
        {    
            GoSub,<Photoshop_NormalMode>
            return
        }
        if (PS_Swith_var=2)
        {
            GoSub,<Photoshop_InsertMode>
            return
        }
return

<Photoshop_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "Photoshop")
return

;   进入模式
<Photoshop_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "Photoshop")
return

;辅助帮助显示
<PS_Help>:
ShowLayoutIMG("psHelp1.png")
KeyWait i
HideLayoutIMG()
return


<PS_Double_N>:
{
; return
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_n, %t%
    if (t == "off")
    goto ps_double_n
    return
    ps_tappedkey_n:
        {
            ; 创建新图层
            app:=ComObjCreate("Photoshop.Application")
            alert=
            (
                %A_ScriptDir%\custom\ps_script\NewLayer.jsx
            )
            app.DoJavaScriptFile(alert)
            return
        }
    return

    ps_double_n:
        {

            Send,^{n}
            return
        }
    return
}

<PS_Double_T>:
{
; return
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_t, %t%
    if (t == "off")
    goto ps_double_t
    return
    ps_tappedkey_t:
        {
            ; send, {t}
            return
        }
    return

    ps_double_t:
        {

            Send,^{t}
            return
        }
    return
}

<PS_Space>:
{
    SendInput,{Space}
    ; send, {Enter}
    return
}
; ^#l::MouseClick,WheelDown,,,10,0,D,R
; ^#h::MouseClick,WheelUp,,,10,0,D,R
<PS_发送V>:
send {v}
return

<PS_切换标签>:
   DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, F2
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        
        return
    }
    KeyWait, F2, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {
        send ^+{F6}
        return
    }
    else
    {
        send ^{Tab}
        return
    }
return

<PS_层上>:
send ^{]}
return

<PS_层下>:
send ^{[}
return
; Win + S, key
<PS_透明度加>:
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\透明度加.jsx
    )
    app.DoJavaScriptFile(alert)
return
<PS_透明度减>:
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\透明度减.jsx
    )
    app.DoJavaScriptFile(alert)
return
<ps_test>:
{
    ;//独立显示IsolateLayerSelection
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\IsolateLayerSelection.jsx
    )
    app.DoJavaScriptFile(alert)
return
}
<PS_明颜色>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\ColorLighten.jsx
    )
    app.DoJavaScriptFile(alert)
return
}
<PS_暗颜色>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\ColorDarken.jsx
    )
    app.DoJavaScriptFile(alert)
return
}

<PS_加亮加暗>:
{
    Send, {O}
    return
}
<PS_颜色面板>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_c, %t%
    if (t == "off")
    goto ps_double_c
    return
    ps_tappedkey_c:
        {
            ; 创建新图层
            app:=ComObjCreate("Photoshop.Application")
            alert=
            (
                %A_ScriptDir%\custom\ps_script\打开颜色面板.jsx
            )
            app.DoJavaScriptFile(alert)
            return
        }
    ; return

    ps_double_c:
        {
            send !{Delete}
            return
        }
    return
}
<PS_GradientPaint>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_g, %t%
    if (t == "off")
    goto ps_double_g
    return
    ps_tappedkey_g:
        {
            Send, +{g}
            return
        }
    return

    ps_double_g:
        {
            GoSub, <PS_填充>
            return
        }
    return
}
<PS_多边形选区>:
{
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    
    send,+{l}
    return
}

<PS_填充>:
{
    send !{Delete}
    return
}
<PS_SwithColor>:
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton
    msgbox Hello
    send, x
return
; <ps_test2>:
; {
;     if var=3 ; 总共几次 
;     var=0
;     var+=1
;     ; msgbox %var%

;     if (var=1)
;     {
;         msgbox 1
;     }
;     if (var=2)
;     {
;         msgbox 2
;     }
;     if (var=3)
;     {
;         msgbox 3
;     }
;     return
; }

<PS_选区切换>:
    send +{m}
return

<PS_选区合并>:
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_e, %t%
    if (t == "off")
    goto ps_double_e
    return
    ps_tappedkey_e:
        {
            send,{l}
            return
        }
    return

    ps_double_e:
        {
            ; 合并
            send, ^{e}
            return
        }
    return
return
; <PS_橡皮檫>:
;     send +{e}
return
<PS_工笔>:
    send +{b}
return

<PS_创建新文档>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\NewFile.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}

<PS_创建新图层>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\NewLayer.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}

<PS_复制图层>:
{

    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\CopyToANewLayer.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}
;

<PS_Duplicate_画笔橡皮擦涂抹>:
        ; 单按切换画笔和橡皮檫|双按涂抹|长按未指定
;     DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
;     ; Wait for 'd' to be released
;     KeyWait, q
;     if (A_TimeSinceThisHotkey > DoubleClickTime) {
;         msgbox,未绑定
;         return
;     }
;     ; Wait for 'd' to be pressed down again (option "d")
;     ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
;    ;  KeyWait, q, % "d T"DoubleClickTime/3000
;      KeyWait, q, % "d T"DoubleClickTime/2000
;     If ! Errorlevel
;     {
;         app:=ComObjCreate("Photoshop.Application")
;         alert=
;         (
;             %A_ScriptDir%\custom\ps_script\smudgeTools.jsx
;         )
;         app.DoJavaScriptFile(alert)
;         return
;     }
;     else
;     {
;         if B_var=2 ; 总
;         B_var=0
;         B_var+=1
;         bo_var=0
;         if (B_var=1 )
;         {    
;             send b
;             return
;         }
;         if (B_var=2)
;         {
;             send e
;             return
;         }
;     }
return
<PS_Duplicate_独立显示>:
        app:=ComObjCreate("Photoshop.Application")
        alert=
        (
            %A_ScriptDir%\custom\ps_script\IsolateLayerSelection.jsx
        )
        app.DoJavaScriptFile(alert)
        return
return


<PS_Duplicate_放大镜>:
    ; 单按发送Z|双按画布100%%
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, z
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send, ^0
        return
    }
    ; Wait for 'd' to be pressed down again (o1ption "d")
    ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
    KeyWait, z, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {
        app:=ComObjCreate("Photoshop.Application")
        alert=
        (
            %A_ScriptDir%\custom\ps_script\zoom100.jsx
        )
        app.DoJavaScriptFile(alert)
        return
    }
    else
    {
        send {z}
        return
    }

return

<PS_Duplicate_旋转>:
    ; 单按R|双水平翻转|当前图层水平翻转
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, r
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
            app:=ComObjCreate("Photoshop.Application")
            alert=
            (
            %A_ScriptDir%\custom\ps_script\画布旋转左右.jsx
            )
            app.DoJavaScriptFile(alert)
        return
    }
    ; Wait for 'd' to be pressed down again (option "d")
    ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
    KeyWait, r, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            app:=ComObjCreate("Photoshop.Application")
            alert=
            (
            %A_ScriptDir%\custom\ps_script\水平翻转.jsx
            )
            app.DoJavaScriptFile(alert)
        }
    else
        {
            send {r}
            return
        }
    return

return


<PS_Duplicate_X>:
 
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, x
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        msgbox,未绑定
        return
    }
    ; Wait for 'd' to be pressed down again (option "d")
    ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
    KeyWait, x, % "d T"DoubleClickTime/1000
    If ! Errorlevel
    {
        send ^{w}
        return
    }
    else
    {
        send {x}
        return
    }

return



<PS_Duplicate_D>:
{
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
            app:=ComObjCreate("Photoshop.Application")
            alert=
            (
            %A_ScriptDir%\custom\ps_script\CopyToANewLayer.jsx
            )
            app.DoJavaScriptFile(alert)
            return

        }
    else
        {
            Send, d
            return
        }
return
}

<PS_Duplicate_打开保存>:
    ; 单按新建图层|双按复制图层|长按删除
    DoubleClickTime := DllCall("GetDoubleClickTime") ; in milliseconds
    ; Wait for 'd' to be released
    KeyWait, o
    if (A_TimeSinceThisHotkey > DoubleClickTime) {
        Send,^{s}
        return
    }
    ; Wait for 'd' to be pressed down again (option "d")
    ; But timeout after T0.5 seconds (If DoubleClickTime is 500)
    KeyWait, o, % "d T"DoubleClickTime/1000
    If ! Errorlevel
        {
            send ^{o}
            return
        }
    else
        {
            send +o
            return
        }
    return

return

<PS_Duplicate_图层中心>:
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, PS_tappedkey_0, %t%
    if (t == "off")
    goto PS_double_0
    return

    PS_tappedkey_0:

    return

    PS_double_0:
        app:=ComObjCreate("Photoshop.Application")
        alert=
        (
            %A_ScriptDir%\custom\ps_script\CenterLayer.jsx
        )
        app.DoJavaScriptFile(alert)
    return
return

<PS_OneKeyDefault>:
{
    ;多次切换影响效率，故决定只做一个事件
    ; if O_var=4 ; 总共几次 
    ; O_var=0
    ; O_var+=1

    ; if (O_var=1)
    ; {
    send v
    return
    ; }
    ; if (O_var=2)
    ; {
    ;     send m
    ;     return
    ; }
    ; if (O_var=3)
    ; {
    ;     send l
    ;     return
    ; }
    ; if (O_var=4)
    ; {
    ;     send w
    ;     return
    ; }
    ; return
}

<PS_OneKeyDefaultSmudgePath>:
{
    ; if var=2 ; 总共几次 
    ; var=0
    ; var+=1
    ; ; msgbox %var%

    ; if (var=1)
    ; {
    ;     send o
    ;     return
    ; }
    ; if (var=2)
    ; {
    ;     send p
    ;     return
    ; }
    ; return
}

<PS_Remove_AllEmptyLayer>:
    ;删除所有空文件
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\RemoveAllEmptyLayerGroups.jsx
    )
    app.DoJavaScriptFile(alert)
    return
return

<PS_Remove_AllInvisibleHiddenLayers>:
    ;删除隐藏图层
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\RemoveAllInvisibleHiddenLayers.jsx
    )
    app.DoJavaScriptFile(alert)
    return
return

<PS_转为_RBG>:
return

<PS_Script_RotateMe>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\RotateMe.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}
<PS_Script_TransformEach>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\TransformEach.jsx
    )
    app.DoJavaScriptFile(alert)
    return
    
}

<PS_Script_LayersRenamer>:
{
    ; 重命名
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\LayersRenamer.jsx
    )
    app.DoJavaScriptFile(alert)
return
}

; ; 笔刷小 *********************************
<PS_Brush_Small>:
Loop
	{
		sleep, 14
		GetKeyState, state, 1, p
		if state = u
		break
		if state = d
		send {[}
	}
return
<PS_Brush_Big>:
Loop
	{
	    sleep, 14
		GetKeyState, state, 2, p
		if state = u
		break
		if state = d
		send {]}
        return
	}
return
; ; 画布变大变小 *************************************
<PS_Screen_Small>:
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_Small, %t%
    if (t == "off")
    goto ps_double_Small
    return
    ps_tappedkey_Small:
        {
            send, ^- ;zoom out
            sleep 5
            send, {ctrl up} 
            return
        }
    return

    ps_double_Small:
        {
            ; 百分百
            send, ^{0}
            return
        }

return
<PS_Screen_Big>:
; return
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_Big, %t%
    if (t == "off")
    goto ps_double_Big
    return
    ps_tappedkey_Big:
        {
            ;zoom in |放大
            send, ^= 
            sleep 5
            send, {ctrl up} ;I've had issues with modifier keys getting stuck
            return
        }
    return

    ps_double_Big:
        {
            ; 百分百
            send, ^{1}
            return
        }
return

<PS_Brush_Swith>:
; return
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, ps_tappedkey_BrushSwith, %t%
    if (t == "off")
    goto ps_double_BrushSwith
    return
    ps_tappedkey_BrushSwith:
        {
            ; if B_var=2 ; 总
            ; B_var=0
            ; B_var+=1
            ; ; bo_var=0
            ; if (B_var=1 )
            ; {    
            ;画笔
            send b
            return
            ; }
            ; if (B_var=2)
            ; {
            ;     ;橡皮
            ;     send {e}
            ;     return
            ; }
        }
    return

    ps_double_BrushSwith:
        {
            ;切换至涂抹
            app:=ComObjCreate("Photoshop.Application")
            alert=
            (
             %A_ScriptDir%\custom\ps_script\smudgeTools.jsx
            )
            app.DoJavaScriptFile(alert)
            return
        }
return

<PS_Delete>:
{
        ; 删除
    Send,{Delete}
    return

}



<PS_加暗加亮>:
{
    if PS_flag=2 ; 总
    PS_flag=0
    PS_flag+=1

    if (PS_flag = 1)
    {
        GoSub, <PS_dodgeTool> 
        return
    }
    if (PS_flag = 2)
    {
        GoSub, <PS_spongeTool>
        return
    }
    return
}

<PS_dodgeTool>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\dodgeTool.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}

<PS_spongeTool>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
       %A_ScriptDir%\custom\ps_script\spongeTool.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}

<PS_eraserTool>:
{
    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
       %A_ScriptDir%\custom\ps_script\eraserTool.jsx
    )
    app.DoJavaScriptFile(alert)
    return
}
; ;按左鍵再按d | 向下合并

; ---长按鼠标左键后操作-----------------------------------------------------------------------

; ;按左鍵再按d | 向下合并
<PS_向下合并>:
    WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
    tool_pathandname = "%activePath%"
    KeyWait, LButton

    app:=ComObjCreate("Photoshop.Application")
    alert=
    (
        %A_ScriptDir%\custom\ps_script\向下合并.jsx
    )
    app.DoJavaScriptFile(alert)
return

<PS_AutoUpdate>:

    Gui,Ps_insert: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,Ps_insert: Color, %color2%
    Gui,Ps_insert: Font,cwhite s20 %FontSize% wbold q5,Segoe UI
    Gui,Ps_insert: Add, Text, ,%_AutoUpdate%
    Gui,Ps_insert: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
        
    
    ; ; 更新第一个文件
    ; updateIntervalDays := 0
    ; VERSION_REGEX := "Oi)(?<=Version )?(\d+(?:\.\d+)?)"
    ; WhatNew_REGEX := "Ois)(?<=----)\R(.*?)(\R\R|$)"
    ; AutoUpdate(_UrlDownloadToFILE_Photoshop_1,, updateIntervalDays, [_UrlDownloadToFILE_Photoshop_CHANGELOG, VERSION_REGEX, WhatNew_REGEX])
    ; ; 更新第二个文件
    ; sleep 5000
    ; updateIntervalDays := 0
    ; VERSION_REGEX := "Oi)(?<=Version )?(\d+(?:\.\d+)?)"
    ; WhatNew_REGEX := "Ois)(?<=----)\R(.*?)(\R\R|$)"
    ; AutoUpdate(_UrlDownloadToFILE_Photoshop_2,, updateIntervalDays, [_UrlDownloadToFILE_Photoshop_CHANGELOG, VERSION_REGEX, WhatNew_REGEX])
    ; sleep 2000
    ; Reload
    checkUpdateFlag:=true
	TrayTip,,检查更新中……,2,1


    URLDownloadToFile(WorkflowPluginsDownDir "/Photoshop/Photoshop.ahk", A_Temp "\temp_Photoshop.ahk")
    URLDownloadToFile(WorkflowPluginsDownDir "/Photoshop/PhotoshopComment.ahk", A_Temp "\temp_PhotoshopComment.ahk")
	versionReg=iS)^\t*\s*global Photoshop_update_version:="([\d\.]*)"

	Loop, read, %A_Temp%\temp_Photoshop.ahk
	{
        Gui,Ps_insert: Hide
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
		if(Photoshop_update_version<versionStr){
			MsgBox,33,检查更新,检测到新版本>>>>V:%versionStr%<<<<`n`n当前版本:%Photoshop_update_version%`t版本更新后==>>`t%versionStr%`n`n是否更新到最新版本？`n覆盖老版本文件，如有修改过请注意备份！
			IfMsgBox Ok
			{
				TrayTip,,下载最新版本并替换老版本...,5,1
                FileCopy, %A_Temp%\temp_Photoshop.ahk, %A_ScriptDir%\plugins\Photoshop\Photoshop.ahk ,1
                FileCopy, %A_Temp%\temp_PhotoshopComment.ahk, %A_ScriptDir%\plugins\Photoshop\PhotoshopComment.ahk ,1
                sleep 1000
                TrayTip,,已经更新到最新版本。,5,1
                sleep 500
                gosub,<Photoshop_Update>
                Reload
			}
		}else if(checkUpdateFlag){
			FileDelete, %A_Temp%\temp_Photoshop.ahk
            FileDelete, %A_Temp%\temp_PhotoshopComment.ahk
			TrayTip,,已经是最新版本。,5,1
			checkUpdateFlag:=false
		}else if(A_DD!=01 && A_DD!=15){
			FileDelete, %A_Temp%\temp_Photoshop.ahk
            FileDelete, %A_Temp%\temp_PhotoshopComment.ahk
		}
	}
return
<Photoshop_Update>:
Run,https://www.kancloud.cn/funbobosky/vim_unity/1252477
TrayTip,,已经更新到最新版本。,5,1
return

; ~LButton & d:: 
; WinGet, activePath, ProcessPath, % "ahk_id" winActive("A")
; tool_pathandname = "%activePath%"
; KeyWait, LButton

; app:=ComObjCreate("Photoshop.Application")
; alert=
; (
;     %A_ScriptDir%\custom\ps_script\向下合并.jsx
; )
; app.DoJavaScriptFile(alert)

; return

; ~g::
; {
;     Sleep, 150
;     GetKeyState, state, g, U
;     IfEqual, state, U
;     {
;         if (A_PriorHotkey <> "~g" or A_TimeSincePriorHotkey > 400)
;         {
;             KeyWait, g
;             return
;         }
;         Send, % ["^!{F12}","+!{F1}"][(count >= 2 || !count) ? count := 1 : ++count]
;         return
;     }
;     if !GetKeyState("Space","U")
;     {
;         Send, g
;         return
;     }
;     else
;     {
;         Send, ^{Numpad0}
;         Sleep 10
;         Send, z
;         return
;     }
; }