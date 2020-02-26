Blender:
  vim.setwin("Word","OpusApp","WINWORD.EXE")
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
    vim.SetMode("normal", "Blender")
    Gui,Ae_insert: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,Ae_insert: Color, %color4%
    Gui,Ae_insert: Font,cwhite s20 %FontSize% wbold q5,Segoe UI
    Gui,Ae_insert: Add, Text, ,%_ExitVIMMode%
    Gui,Ae_insert: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
    sleep %SleepTime%
    Gui,Ae_insert: Destroy
return

;进入模式
<Blender_InsertMode>:
    vim.SetMode("insert", "Blender")
    Gui,Ae_insert: +LastFound +AlwaysOnTop -Caption +ToolWindow
    Gui,Ae_insert: Color, %color2%
    Gui,Ae_insert: Font,cwhite s20 %FontSize% wbold q5,Segoe UI
    Gui,Ae_insert: Add, Text, ,%_VIMMode%
    Gui,Ae_insert: Show,AutoSize Center NoActivate
    WinSet, Transparent,200
    sleep %SleepTime%
    Gui,Ae_insert: Destroy
return

; #搜索命令
<Blender_QuickCommander>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, Blender_tappedkey_tab, %t%
    if (t == "off")
    goto Blender_double_tab
    return
    Blender_tappedkey_tab:
        {
            Send, {F3}
            return
        }
    Blender_double_tab:
        {
            Send, {Tab}
            return
        }
    return
}

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
    Run,"F:/BoBOProgram/Blender/blender.exe" -b -P "F:/BoBOAHK/WorkFlow/custom/blender/test.py"
    return
}
; filename = "F:/BoBOAHK/WorkFlow/custom/blender/test.py"
; exec(compile(open(filename).read(), filename, 'exec'))

