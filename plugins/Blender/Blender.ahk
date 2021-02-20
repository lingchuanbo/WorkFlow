Blender:
    vim.SetAction("<Blender_InsertMode>", "进入VIM模式")
    vim.SetAction("<Blender_NormalMode>", "返回正常模式")
    vim.SetWin("Blender","GHOST_WindowClass","blender.exe")
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
<Blender_z>:
	GV_KeyClickAction1 := "send,{z}"
	GV_KeyClickAction2 := "send,{NumpadDot}"
	GoSub,Sub_KeyClick
return

<Blender_w>:
	GV_KeyClickAction1 := "send,{w}"
	GV_KeyClickAction2 := "send,^{Space}"
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
<testBlenderScript>:
{
    Run,"F:/BoBOProgram/Blender/blender.exe" --python-console "F:/BoBOAHK/WorkFlow/custom/blender/test.py"
    return
}
; filename = "F:/BoBOAHK/WorkFlow/custom/blender/test.py"
; exec(compile(open(filename).read(), filename, 'exec'))

