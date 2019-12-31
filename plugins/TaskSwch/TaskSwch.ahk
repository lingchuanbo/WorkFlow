TaskSwch:
    vim.SetPlugin(TaskSwch,Author="",Ver="",Comment="")
    ;vim.SetWin("AfterEffects","ahk_exe","AfterFX.exe")
    vim.SetWin("TaskSwch", "ahk_exe","TaskSwch.exe")
    vim.mode("insert","TaskSwch")
    vim.map("<esc>","<Normal_Mode_TaskSwch>","TaskSwch")


    vim.mode("normal","TaskSwch")
    vim.map("i","<Insert_Mode_TaskSwch>","TaskSwch")
    
;定义注释
    vim.Comment("<TaskSwch_上>","TaskSwch_上")
    vim.comment("<TaskSwch_下>","TaskSwch_下")

;映射热键
    vim.map("1","<TaskSwch_上>","TaskSwch")
    vim.map("2","<TaskSwch_下>","TaskSwch")
    vim.map("3","<TaskSwch_Enter>","TaskSwch")
    vim.BeforeActionDo("TaskSwch_CheckMode", "TaskSwch") ; by Array
    Return

TaskSwch_CheckMode(){
	ControlGetFocus, ctrl, A
	If RegExMatch(ctrl,"Edit")
		return True
	return False
}


;快捷键设定为Win+f

<Normal_Mode_TaskSwch>:
    Send,{Esc}
    vim.Mode("normal","TaskSwch")
;    gosub,<normalmode_LED1>
    ;emptymem()
return
; <insert_TC> {{{1
<Insert_Mode_TaskSwch>:
    vim.Mode("insert","TaskSwch")
;    gosub,<insertmode_LED1>
return

; <mode_window_TaskSwch>:
;     vim.mode("window","TaskSwch")
;     gosub,<windowmode_LED1>
; return
<TaskSwch_上>:
{
    Send,{Up}
    return
}
<TaskSwch_下>:
{
    Send,{Down}
    return
}
<TaskSwch_Enter>:
{
    Send,{Enter}
    return
} 

; <TC_Test_double1>:
; {
;     FunBoBO_Double()
;     doubleVar1()
;     {
;     MsgBox, Hello11
;     return
;     }
;     doubleVar1()
;     {
;     MsgBox, Hello12
;     return
;     }
; }
; <TC_Test_double2>:
; {
;     FunBoBO_Double()
;     doubleVar1()
;     {
;     MsgBox, Hello21
;     return
;     }
;     doubleVar1()
;     {
;     MsgBox, Hello22
;     return
;     }
; }
