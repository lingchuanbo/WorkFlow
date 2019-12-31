FxEditor:
;操作方面请使用Surfingkeys，只做功能补充
;定义注释
    vim.SetAction("<FxEditor_NormalMode>", "返回正常模式")
    vim.SetAction("<FxEditor_InsertMode>", "进入VIM模式")
    vim.SetWin("FxEditor","","adl.exe")

;normal模式（必需）
    vim.SetMode("normal", "0x120796")
    vim.map("<insert>","<FxEditor_InsertMode>","0x120796")
    vim.map("1","<FxEditor_test>","0x120796")
;vim.comment("<Phantom_切换到【VIM模式】>","按下Esc键可以切换为VIM模式")

;insert模式
    vim.SetMode("insert", "FxEditor")
    vim.BeforeActionDo("FxEditor_BeforeActionDo", "ApolloRuntimeContentWindow") 
return
; 对符合条件的控件使用insert模式，而不是normal模式
FxEditor_BeforeActionDo()
{
    ControlGetFocus, ctrl, AHK_CLASS Chrome_WidgetWin_1
	If RegExMatch(ctrl,"Chrome_RenderWidgetHostHWND1") ; || RegExMatch(ctrl,"i)qwidget")
        return true
    return false
}
<FxEditor_test>:
{
    MsgBox,HelloWorld!
    return
}
<FxEditor_空格_Space>:
{
    send,{Space}
    return
}