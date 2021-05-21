Houdini:
    vim.SetAction("<Houdini_InsertMode>", "进入VIM模式")
    vim.SetAction("<Houdini_NormalMode>", "返回正常模式")
    vim.SetWin("Houdini","ahk_exe","houdinifx.exe")
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