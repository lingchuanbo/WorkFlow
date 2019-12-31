Firefox:
;定义注释
    vim.SetAction("<Firefox_NormalMode>", "返回正常模式")
    vim.SetAction("<Firefox_InsertMode>", "进入VIM模式")
    vim.SetWin("Firefox", "MozillaWindowClass")

;normal模式（必需）
    vim.SetMode("normal", "Firefox")
    vim.map("<insert>","<Firefox_InsertMode>","Firefox")
;vim.comment("<Phantom_切换到【VIM模式】>","按下Esc键可以切换为VIM模式")

;insert模式
    vim.SetMode("insert", "Firefox")
    vim.Map("<esc>", "<Firefox_NormalMode>", "Firefox")
    ; vim.Map("f", "<Firefox_切换标签>", "Firefox")
    ; vim.Map("n", "<Firefox_新建标签>", "Firefox")
    ; vim.Map("v", "<Firefox_上一标签>", "Firefox")
    ; vim.Map("d", "<Firefox_下载>", "Firefox")
    ; vim.Map("x", "<Firefox_关闭当前>", "Firefox")
    ; vim.Map("z", "<Firefox_撤销关闭标签页>", "Firefox")
    ; vim.Map("X", "<Firefox_关闭全部>", "Firefox")
    ; vim.Map("D", "<Firefox_清除最近历史记录>", "Firefox")
    vim.BeforeActionDo("Firefox_CheckMode", "Firefox") 
return

; 对符合条件的控件使用insert模式，而不是normal模式
Firefox_CheckMode()
{
    ControlGetFocus, ctrl, A
    ; msgbox, ctrl
    if RegExMatch(ctrl, "Edit")
        return true
    return false
}

;运行Firefox
<RunFirefox>:
    ExePath := ini.BOBOPath_Config.FirefoxPath
    tClass := ini.ahk_class_Config.Firefox_Class  
    FunBoBO_RunActivation(ExePath,tClass)
 Return



<Firefox_NormalMode>:
;   send,{esc}
    vim.SetMode("normal", "Firefox")
    MsgBox, 0, 提示, 【正常模式】, 0.5
return

<Firefox_InsertMode>:
;   send,{esc}
    vim.SetMode("insert", "Firefox")
    MsgBox, 0, 提示, 【VIM模式】, 0.5
return

<Firefox_切换标签>:
    send, ^{tab}
return

<Firefox_新建标签>:
    send, ^t
return

<Firefox_上一标签>:
    send, ^+{tab}
return

<Firefox_下载>:
    send, ^j
return

<Firefox_关闭当前>:
    send, ^w
return

<Firefox_撤销关闭标签页>:
    send, ^+T
return

<Firefox_清除最近历史记录>:
	send, ^+{Del}
return

<Firefox_关闭全部>:
	send, !{F4}
return
