GoogleChrome:
    ;定义注释
    vim.SetAction("<Google_NormalMode>", "返回正常模式")
    vim.SetAction("<Google_InsertMode>", "进入VIM模式")
    vim.SetWin("GoogleChrome","","Chrome.exe")
    #Include %A_ScriptDir%\plugins\GoogleChrome\GoogleChromeComment.ahk 

;normal模式（必需）
    vim.SetMode("normal", "GoogleChrome")
    vim.map("<insert>","<GoogleChrome_SwithMode>","GoogleChrome")

;insert模式
    vim.SetMode("insert", "GoogleChrome")
    vim.Map("<insert>", "<GoogleChrome_SwithMode>", "GoogleChrome")
    ; vim.Map("<f5>", "<Google_刷新>", "GoogleChrome")
    ; vim.Map("<f8>", "<GoogleChrome_无痕>", "GoogleChrome")
    ; ; vim.Map("<Delete>", "<GoogleChrome_清除浏览数据>", "GoogleChrome")
    ; vim.Map("<f9>", "<GoogleChrome_OpenGoogle>", "GoogleChrome")
    ; vim.Map("<f9>1", "<GoogleChrome_OpenYoutube>", "GoogleChrome")
    ; vim.Map("<f9>2", "<GoogleChrome_OpenTranslate>", "GoogleChrome")
    ; vim.Map("<f9>3", "<GoogleChrome_OpenDogeDoge>", "GoogleChrome")
    ; vim.Map("<f9>4", "<GoogleChrome_下载>", "GoogleChrome")
    ; vim.map("?","<ShowHelp>","GoogleChrome")
return

;【全局运行AE】
<RunGoogleChrome>:
    ExePath := ini.BOBOPath_Config.ChromePath
    tClass := ini.ahk_class_Config.GoogleChrome_Class
    FunBoBO_RunActivation(ExePath,tClass)
 Return

<GoogleChrome_下载>:
{
    send, ^j
    return
}
return

<GoogleChrome_删除>:
{
	GV_KeyClickAction1 := "SendInput,{Delete}"
	GV_KeyClickAction2 := "Gosub,<GoogleChrome_清除浏览数据>"
	GoSub,Sub_KeyClick
}
return

<GoogleChrome_清除浏览数据>:
{
        MsgBox, 4,警告, 是否清除缓存数据 继续?
        IfMsgBox Yes
            {
                ToolTip, 正在清除数据...！
                sleep 100
                    send,^{t}
                    send ^+{Del}
                    sleep 1000
                    send,{Enter}
                    sleep 1000
                    send,^w
                    sleep 500
                    send,^{f5}
                SetTimer, RemoveToolTip, -1000
                return
            }
return
}
<GoogleChrome_无痕>:
{
    ; t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    ; settimer, Google_tappedkey_f, %t%
    ; if (t == "off")
    ; goto Google_double_f
    ; return

    ; Google_tappedkey_f:
    ;     send, ^t
    ; return

    ; Google_double_f:
    Send ^+{n}
    return
}
; 快速打开Google
<GoogleChrome_OpenGoogle>:
{
    CurrentBrowserOpenURL("google.com")
    return
}
; 快速打开Google
<GoogleChrome_OpenYoutube>:
{
    CurrentBrowserOpenURL("youtube.com")
    return
}
<GoogleChrome_OpenTranslate>:
{
    Clipboard=https://translate.google.cn/ ; <-- place url here.
    SendInput,^t
    send, ^v
    send, {Enter}
    return
}
<GoogleChrome_OpenDogeDoge>:
{
    Clipboard=https://www.dogedoge.com/ ; <-- place url here.
    SendInput,^t
    send, ^v
    send, {Enter}
    return
}
<Google_搜索>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, Google_tappedkey_f1, %t%
    if (t == "off")
    goto Google_double_f1
    return

    Google_tappedkey_f1:
    Send,f
    return

    Google_double_f1:
    send,^f
    return
}

<Google_刷新>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, Google_tappedkey_f5, %t%
    if (t == "off")
    goto Google_double_f5
    return

    Google_tappedkey_f5:
    Send,{f5}
    return

    Google_double_f5:
    send,^{f5}
    return
}

<Google_本地游戏打包>:
{
    Run,e:\project\xm4\asset\bldData.bat
    return
}
<Google_空格_Space>:
{
    send,{Space}
    return
}

;   单键切换
<GoogleChrome_SwithMode>:
        if GoogleChrome_var=2 ; 总
        GoogleChrome_var=0
       GoogleChrome_var+=1
        AEE_var=0
        if (GoogleChrome_var=1 )
        {    
            GoSub,<GoogleChrome_NormalMode>
            return
        }
        if (GoogleChrome_var=2)
        {
            GoSub,<GoogleChrome_InsertMode>
            return
        }
return

;   默认模式
<GoogleChrome_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "GoogleChrome")
return

;   进入模式
<GoogleChrome_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "GoogleChrome")
return