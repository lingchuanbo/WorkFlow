Xplorer2:
    ; GetModea
    vim.SetAction("<Xplorer2_NormalMode>", "返回正常模式")
    vim.SetAction("<Xplorer2_InsertMode>", "进入VIM模式")
    ; vim.SetWin("Xplorer2","AE_CApplication_15.1") ; 因为我使用FX console
    vim.SetWin("Xplorer2","ahk_exe","xplorer2_64.exe") ; 未使用FX console 激活这个可兼容所有版本
    vim.BeforeActionDo("AE_CheckMode", "Xplorer2")
;normal模式
    vim.SetMode("normal", "Xplorer2")
    vim.Map("<insert>", "<Xplorer2_SwithMode>", "Xplorer2")
;insert模式
    vim.SetMode("insert", "Xplorer2")
    vim.Map("<insert>", "<Xplorer2_SwithMode>", "Xplorer2")
    vim.Map("<a-q>", "<Xplorer2_预览>", "Xplorer2")
return




;【全局运行PS】
<RunXplorer2>:
    ExePath := ini.BOBOPath_Config.PSPath
    tClass := ini.ahk_class_Config.PSClass
    FunBoBO_RunActivation(ExePath,tClass)
 Return


; <PS_Space>:
; send,{Space}
; return

 <Xplorer2_SwithMode>:
;   单键切换
        if PS_Swith_var=2 ;
        PS_Swith_var=0
        PS_Swith_var+=1
        PS_var=0
        if (PS_Swith_var=1 )
        {    
            GoSub,<Xplorer2_NormalMode>
            return
        }
        if (PS_Swith_var=2)
        {
            GoSub,<Xplorer2_InsertMode>
            return
        }
return

<Xplorer2_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "Photoshop")
return

;   进入模式
<Xplorer2_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "Photoshop")
return


<Xplorer2_预览>:
send,^{q}
return
