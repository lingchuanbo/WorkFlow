
;Author:BoBO
;Version:0.1
;
;
XnView:

;20181023   一键到AE 前提需要获得XnView的打开方式 否则无效

#IfWinActive ahk_exe xnview.exe

;定义注释
    vim.SetAction("<Xnview_NormalMode>", "返回正常模式")
    vim.SetAction("<Xnview_InsertMode>", "进入VIM模式")
    vim.SetWin("Xnview","ahk_exe","Xnview.exe")
;normal模式（必需）
    vim.SetMode("normal", "Xnview")
    vim.map("<insert>","<Xnview_InsertMode>","Xnview")

    vim.Comment("<ShowHelp>","帮助")
;insert模式
    vim.SetMode("insert", "Xnview")
    vim.Map("<esc>", "<Xnview_NormalMode>", "Xnview")
    vim.Map("g", "<XnView_Double_g>", "Xnview")
    vim.Map("/", "<XnView_Play>", "Xnview")
    vim.map("?","<ShowHelp>","Xnview")

    vim.BeforeActionDo("Xnview_CheckMode", "Xnview")

return

Xnview_CheckMode(){
    ControlGetFocus, ctrl, A
    ; msgbox, ctrl
    if RegExMatch(ctrl, "i)Edit") || RegExMatch(ctrl, "i)MXS_Scintilla") ;  or WinExist("ahk_class MXS_SciTEWindow")) ;// RegExMatch(ctrl, "i)MXS_Scintilla1")
        return true
    return false
}

; Xnview_BeforeActionDo(){
;     ControlGetFocus, ctrl, A
; 	If RegExMatch(ctrl,"Edit") ;//RegExMatch(ctrl,"MXS_SciTEWindow")
;     ;ControlGetFocus,ctrl,ahk_class,Xnview.exe
;     ;if RegExMatch(ctrl,"edit")// RegExMatch(ctrl,"qwidget") 
;         Return true
;     Return False
; }

;【全局运行Max】
; <RunMax>:
;     MaxPath := ini.BOBOPath_Config.MaxPath
;     Max_Class := ini.ahk_class_Config.Max_Class
;     DetectHiddenWindows, on
;     IfWinNotExist MaxPath Max_Class 
;     { 
;    		Run %MaxPath%
;     	WinActivate 
;     } 
;     	Else IfWinNotActive ahk_class Max_Class 
;     { 
;     	WinActivate
;     } 
;     Else 
;     { 
;         WinMinimize 
;     } 
;  Return

<Xnview_NormalMode>:
;   send,{esc}
    vim.SetMode("normal", "Xnview")
    MsgBox, 0, 提示, 【正常模式】, 0.5
return

<Xnview_InsertMode>:
;   send,{esc}
    vim.SetMode("insert", "Xnview")
    MsgBox, 0, 提示, 【VIM模式】, 0.5
return

<Xnview_Play>:
   send,{Pause}
return



;双按操作
<XnView_Double_g>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, XnView_tappedkey_g, %t%
    if (t == "off")
    goto XnView_double_g
    return

    XnView_tappedkey_g:
    Send g
    return

    XnView_double_g:
    Send, !1
}
 Return


