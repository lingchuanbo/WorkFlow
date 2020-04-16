Eagle:
    senvim.setwin("Word","OpusApp","WINWORD.EXE")
    vim.SetAction("<Eagle_InsertMode>", "进入VIM模式")
    vim.SetAction("<Eagle_NormalMode>", "返回正常模式")
    vim.SetWin("Eagle","Chrome_WidgetWin_1","Eagle.exe")
    vim.BeforeActionDo("Eagle_CheckMode", "Eagle")
    ; #Include %A_ScriptDir%\plugins\Eagle\EagleComment.ahk 
    
;normal模式
    vim.SetMode("normal", "Eagle")
    vim.Map("<insert>", "<Eagle_SwithMode>", "Eagle")
;insert模式
    vim.SetMode("insert", "Eagle")
    vim.Map("<insert>", "<Eagle_SwithMode>", "Eagle")
    ;载入按键
return

;   输入状时态屏蔽
Eagle_CheckMode()
{
    ControlGetFocus, ctrl, A
    If RegExMatch(ctrl,"i)Edit")
        {
            return True 
        }
}

;全局运行
<RunEagle>:
    ExePath := ini.BOBOPath_Config.Eagle
    tClass := ini.ahk_class_Config.EagleClass
    NewTitle =
    FunBoBO_RunActivationTitle(ExePath,tClass,NewTitle) 
Return

;单键切换模式
<Eagle_SwithMode>:
        if  Eagle_var=2 ; 总
            Eagle_var=0
            Eagle_var+=1
        if (Eagle_var=1 )
        {    
            GoSub,<Eagle_NormalMode>
            return
        }
        if (Eagle_var=2)
        {
            GoSub,<Eagle_InsertMode>
            return
        }
return

;默认模式
<Eagle_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "Eagle")
return

;进入模式
<Eagle_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "Eagle")
return





