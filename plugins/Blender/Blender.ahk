Blender:
    vim.SetAction("<Blender_InsertMode>", "进入VIM模式")
    vim.SetAction("<Blender_NormalMode>", "返回正常模式")
    vim.SetWin("Blender","ahk_exe","blender.exe")
    vim.BeforeActionDo("Blender_CheckMode", "Blender")
    ; #Include %A_ScriptDir%\plugins\Blender\BlenderComment.ahk 
    
;normal模式
    vim.SetMode("normal", "Blender")
    vim.Map("<insert>", "<Blender_SwithMode>", "Blender")
;insert模式
    vim.SetMode("insert", "Blender")
    vim.Map("<insert>", "<Blender_SwithMode>", "Blender")
    ;载入按键
    #Include %A_ScriptDir%\plugins\Blender\BlenderKey.ahk
    ; #Include %A_ScriptDir%\plugins\Blender\BlenderMenu.ahk

return

;   输入状时态屏蔽
Blender_CheckMode()
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
; <RunBlender>:
;     ExePath := ini.BOBOPath_Config.Blender
;     tClass := ini.ahk_class_Config.BlenderClass
;     FunBoBO_RunActivation(ExePath,tClass)
; Return

;单键切换模式
<Blender_SwithMode>:
        if  Blender_var=2 ; 总
            Blender_var=0
            Blender_var+=1
        if (Blender_var=1 )
        {    
            GoSub,<Blender_NormalMode>
            return
        }
        if (Blender_var=2)
        {
            GoSub,<Blender_InsertMode>
            return
        }
return

;默认模式
<Blender_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "Blender")
return

;进入模式
<Blender_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "Blender")
return

; #搜索命令
<Blender_QuickCommander>:
{
    Send, +{a}
    return
}

; #工具条
<Blender_Toobar>:
send,+{Space}
return
; #Pie菜单
<Blender_PieMenu>:
send,!{w}
return


; Screen
; #渲染
<Blender_Render>:
send,{F12}
return
; #渲染动画
<Blender_RenderAnimation>:
send,^{F12}
return


; #显示渲染
<Blender_ViewRender>:
send,{F11}
return
; #显示渲染动画
<Blender_ViewRenderAnimation>:
send,^{F11}
return

; 显示隐藏渲染窗口
<Blender_ToggleMaxzeArea1>:
send,^{Space}
return
<Blender_ToggleMaxzeArea2>:
send,^!{Space}
return


; 选中和框选
<Blender_SelectObject>:
	GV_KeyClickAction1 := "send,{a}"
	GV_KeyClickAction2 := "send,{b}"
	GoSub,Sub_KeyClick
return

; 选中和框选
<Blender_Alt>:
	GV_KeyClickAction1 := "send,+{a}"
	GV_KeyClickAction2 := "send,^{a}"
	GoSub,Sub_KeyClick
return

<Blender_Duplicate>:
	GV_KeyClickAction1 := "send,{d}"
	GV_KeyClickAction2 := "send,+{d}"
	GoSub,Sub_KeyClick
return


; 选中和框选
<Blender_z>:
	GV_KeyClickAction1 := "send,{z}"
	GV_KeyClickAction2 := "send,{NumpadDot}"
	GoSub,Sub_KeyClick
return

<Blender_w>:
	GV_KeyClickAction1 := "send,{g}"
	GV_KeyClickAction2 := "send,^!{q}"
	GoSub,Sub_KeyClick
return
; 模型最大化
<Blender_ObjectCernt>:
send,{NumpadDot}
return
; 模型位置归0
<Blender_0>:
	GV_KeyClickAction1 := "send,{0}"
	GV_KeyClickAction2 := "gosub,<Blender_Object0>"
	GoSub,Sub_KeyClick
return

<Blender_Object0>:
    send,+{s}
    sleep,50
    send,8
return

<Blender_窗口最大>:
	GV_KeyClickAction1 := "send,{w}"
	GV_KeyClickAction2 := "send,!{w}"
	GoSub,Sub_KeyClick
return

<Blender_视窗_摄像机>:
	send,{Numpad0}
return
<Blender_视窗_前视图>:
	send,{Numpad1}
return
<Blender_视窗_左视图>:
	send,^{Numpad3}
return
<Blender_视窗_右视图>:
	send,{Numpad3}
return
<Blender_视窗_透视与正交>:
	send,{Numpad5}
return
<Blender_视窗_透视>:
	send,{Numpad5}
return
<Blender_视窗_顶视图>:
	send,{Numpad7}
return
; #双击快速添加
<Blender_QuickAdd>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, Blender_tappedkey_add, %t%
    if (t == "off")
    goto Blender_double_add
    return
    Blender_tappedkey_add:
        {
            Send, {a}
            return
        }
    Blender_double_add:
        {
            Send, +{a}
            return
        }
    return

}
; #右键
<Blender_MButton>:
{
    SendInput, {mbutton}
    return
}
; #移动&双Q渲染
<Blender_q>:
{
    GV_KeyClickAction1 := "send,{w}"
	GV_KeyClickAction2 := "gosub,<Blender_Render>"
	GoSub,Sub_KeyClick
return
}

; #增强x 双击删除
<Blender_X>:
	GV_KeyClickAction1 := "send,{x}"
	GV_KeyClickAction2 := "gosub,<Blender_DeleteOK>"
	GoSub,Sub_KeyClick
return

<Blender_V>:
	GV_KeyClickAction1 := "send,{z}"
	GV_KeyClickAction2 := "gosub,<Blender_渲染画面>"
	GoSub,Sub_KeyClick
return

<Blender_渲染画面>:
sendinput,{z}
sendinput,{8}
return

; #搜索
<Blender_F>:
	; GV_KeyClickAction1 := "send,{f}"
	; GV_KeyClickAction2 := "send,{F3}"
	; GoSub,Sub_KeyClick
    send,{F3}
return

<Blender_DeleteOK>:
{
    SendInput, {x}
    SendInput, {Enter}
    return
}
<Blender_显示>:
{
    ; SendInput, {x}
    SendInput, +{z}
    return
}
<Blender_缩放>:
{
    ; SendInput, {x}
    SendInput, {s}
    return
}
; <Blender_旋转>:
; {
;     ; SendInput, {x}
;     SendInput, {r}
;     return
; }
<Blender_上一帧>:
{
    sendinput,{Alt down}{WheelUp}
    KeyWait LButton
	Send {Alt Up}
    return
}
<Blender_下一帧>:
{
	sendinput,{Alt down}{WheelDown}
    KeyWait LButton
	Send {Alt Up}
    return
}
