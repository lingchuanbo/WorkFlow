Houdini:
    vim.SetAction("<Houdini_InsertMode>", "进入VIM模式")
    vim.SetAction("<Houdini_NormalMode>", "返回正常模式")
    vim.SetWin("Houdini","ahk_exe","houdini.exe")
    vim.BeforeActionDo("Houdini_CheckMode", "Houdini")
    ; #Include %A_ScriptDir%\plugins\Houdini\HoudiniComment.ahk 
    
;normal模式
    vim.SetMode("normal", "Houdini")
    vim.Map("<insert>", "<Houdini_SwithMode>", "Houdini")
;insert模式
    vim.SetMode("insert", "Houdini")
    vim.Map("<insert>", "<Houdini_SwithMode>", "Houdini")
    ;载入按键
    #Include %A_ScriptDir%\plugins\Houdini\HoudiniKey.ahk
    ; #Include %A_ScriptDir%\plugins\Houdini\HoudiniMenu.ahk

return

;   输入状时态屏蔽
Houdini_CheckMode()
{
    ControlGetFocus, ctrl, A
    If RegExMatch(ctrl,"i)Edit")
        {
            return True 
        }
    If (A_Cursor=="IBeam") ;工字光标
        {
            ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
            return True
        }
}

;全局运行
; <RunHoudini>:
;     ExePath := ini.BOBOPath_Config.Houdini
;     tClass := ini.ahk_class_Config.HoudiniClass
;     FunBoBO_RunActivation(ExePath,tClass)
; Return

;单键切换模式
<Houdini_SwithMode>:
        if  Houdini_var=2 ; 总
            Houdini_var=0
            Houdini_var+=1
        if (Houdini_var=1 )
        {    
            GoSub,<Houdini_NormalMode>
            return
        }
        if (Houdini_var=2)
        {
            GoSub,<Houdini_InsertMode>
            return
        }
return

;默认模式
<Houdini_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "Houdini")
return

;进入模式
<Houdini_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "Houdini")
return

; #搜索命令
<Houdini_QuickCommander>:
{
    Send, +{a}
    return
}

<Houdini_删除>:
{
    send,{Delete}
return
}

<Houdini_搜索>:
{
    send,{RButton}
    return
}

<Houdini_旋转>:
{
    send,{r}
    return
}
<Houdini_缩放>:
{
    send,{e}
    return
}
<Houdini_移动>:
{
    send,{t}
    return
}

; 选中和框选
<Houdini_Alt>:
	GV_KeyClickAction1 := "send,{Tab}"
	GV_KeyClickAction2 := ""
	GoSub,Sub_KeyClick
return


; 选中和框选
<Houdini_z>:
	GV_KeyClickAction1 := "send,z"
	GV_KeyClickAction2 := "send,{space}g"
	GoSub,Sub_KeyClick
return


<Houdini_透视>:
{
    ; send,{space}{1}
    sendinput,{space}{o}
    return
}
<Houdini_前视图>:
{
    send,{space}{3}
    return
}
<Houdini_右视图>:
{
    send,{space}{4}
    return
}
<Houdini_顶视图>:
{
    send,{space}{2}
    return
}
<Houdini_UV视图>:
{
    send,{space}{5}
    return
}
<Houdini_切换阴影线框>:
{
    send,w
    return
}

<Houdini_窗口切换>:
{
    GV_KeyClickAction1 := "sendinput,w"
	GV_KeyClickAction2 := "sendinput,{Space}{b}"
	GoSub,Sub_KeyClick
    return
}

<Houdini_窗口切换透视正视>:
{
    GV_KeyClickAction1 := "sendinput,{p}"
	GV_KeyClickAction2 := "gosub,<Houdini_透视正视>"
	GoSub,Sub_KeyClick
    return
}

<Houdini_透视正视>:
    send,{Space}{1}
return

<Houdini_跳转_上一帧>:
{
    GV_KeyClickAction1 := "gosub,<Houdini_上一帧>"
	GV_KeyClickAction2 := "gosub,<Houdini_跳转第一帧>"
	GoSub,Sub_KeyClick
    return
}
<Houdini_面板>:
{
    GV_KeyClickAction1 := "gosub,<Houdini_新标签>"
	GV_KeyClickAction2 := "gosub,<Houdini_独立窗口>"
	GoSub,Sub_KeyClick
    return
}

<Houdini_上一帧>:
Loop
	{
	    sleep, 5
		GetKeyState, state, f2, p
		if state = u
		break
		if state = d
		sendinput,{Left}
        return
	}
return
<Houdini_下一帧>:
Loop
	{
	    sleep, 5
		GetKeyState, state, f3, p
		if state = u
		break
		if state = d
		sendinput,{Right}
        return
	}
return
<Houdini_跳转第一帧>:
sendinput,{Down}
return

; 面板选项
<Houdini_场景视图>:
sendinput,!{1}
return
<Houdini_网络编辑器>:
sendinput,!{2}
return
<Houdini_参数>:
sendinput,!{3}
return
<Houdini_节点树视角>:
sendinput,!{4}
return
<Houdini_文本框>:
sendinput,!{5}
return
<Houdini_频道编辑>:
sendinput,!{6}
return
<Houdini_材质调色板>:
sendinput,!{7}
return
<Houdini_参看详细>:
sendinput,!{8}
return
<Houdini_场景视角>:
sendinput,!{9}
return
; 面板选项2
<Houdini_新标签>:
sendinput,^{t}
return
<Houdini_独立窗口>:
sendinput,!+{c}
return
<Houdini_前标签>:
sendinput,^{PgUp}
return
<Houdini_下一个标签>:
sendinput,^{PgDn}
return
<Houdini_关闭标签>:
sendinput,^{w}
return
<Houdini_关闭所有标签>:
sendinput,!{/}
return