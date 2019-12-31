Swf2SpriteSheetPack:
;操作方面请使用Surfingkeys，只做功能补充
;定义注释
    vim.SetAction("<Swf2SpriteSheetPack_NormalMode>", "返回正常模式")
    vim.SetAction("<Swf2SpriteSheetPack_InsertMode>", "进入VIM模式")
    vim.SetWin("Swf2SpriteSheetPack","","Swf2SpriteSheetPack.exe")

;normal模式（必需）
    vim.SetMode("normal", "Swf2SpriteSheetPack")
    vim.map("<insert>","<Swf2SpriteSheetPack_InsertMode>","Swf2SpriteSheetPack")

;vim.comment("<Phantom_切换到【VIM模式】>","按下Esc键可以切换为VIM模式")

;insert模式
    vim.SetMode("insert", "Swf2SpriteSheetPack")
    vim.Map("<esc>","<3DsMax_NormalMode>","3DsMax")
    vim.map("<Space>","<Swf2SpriteSheetPack_test>","Swf2SpriteSheetPack")

    vim.BeforeActionDo("Swf2SpriteSheetPack_BeforeActionDo", "Swf2SpriteSheetPack") 
return
; 对符合条件的控件使用insert模式，而不是normal模式
Swf2SpriteSheetPack_BeforeActionDo()
{
    ControlGetFocus, ctrl, AHK_CLASS Chrome_WidgetWin_1
	If RegExMatch(ctrl,"Swf2SpriteSheetPack") ; || RegExMatch(ctrl,"i)qwidget")
        return true
    return false
}
<Swf2SpriteSheetPack_test>:
{
    MsgBox,HelloWorld!
    return
}
<Swf2SpriteSheetPack_空格_Space>:
{
    send,{Space}
    return
}
<Swf2SpriteSheetPack_NormalMode>:
;   send,{esc}
    vim.SetMode("normal", "Swf2SpriteSheetPack")
    MsgBox, 0, 提示, 【正常模式】, 0.5
return

<Swf2SpriteSheetPack_InsertMode>:
;   send,{esc}
    vim.SetMode("insert", "Swf2SpriteSheetPack")
    MsgBox, 0, 提示, 【VIM模式】, 0.5
return