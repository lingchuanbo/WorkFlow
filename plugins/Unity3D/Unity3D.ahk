;Author:BoBO
;Version:0.1
;
;
Unity3D:

    vim.SetAction("<Unity3D_NormalMode>", "返回正常模式")
    vim.SetAction("<Unity3D_InsertMode>", "进入VIM模式")
    vim.SetWin("Unity3D","ahk_exe","Unity.exe")
    vim.BeforeActionDo("Unity3D_CheckMode", "Unity3D")

;定义注释
    vim.Comment("<Unity3D_Hierarchy>","层级面板")
    vim.Comment("<Unity3D_Project>","项目面板")
    vim.Comment("<Unity3D_Animation>","动作面板")
    vim.Comment("<Unity3D_Add>","快速添加")
    vim.Comment("<Unity3D_Duplicate>","单按粘贴双按删除")
    vim.Comment("<Unity3D_AddCameraView>","双按匹配场景摄像机")
    

    vim.Comment("<Unity3D_ObjectHiden>","激活&禁用")

    vim.Comment("<Unity3D_Retset_All>","重置所有")
    vim.Comment("<Unity3D_Retset_Position>","重置位置")
    vim.Comment("<Unity3D_Retset_Rotation>","重置旋转")
    vim.Comment("<Unity3D_Retset_Scale>","重置缩放")

    vim.Comment("<Unity3D_CreateEmpty>","创建空")
    vim.Comment("<Unity3D_CreateEmptyCh>","创建子空")
    vim.Comment("<Unity3D_Particle_1>","创建粒子")
    vim.Comment("<Unity3D_AddToSelectionSave>","双按保存")
    

;normal模式
    vim.SetMode("normal", "Unity3D")
    vim.map("<insert>","<Unity3D_InsertMode>","Unity3D")
;insert模式
    vim.SetMode("insert", "Unity3D")
    vim.Map("<esc>", "<Unity3D_NormalMode>", "Unity3D")


    vim.Map("4", "<Unity3D_Hierarchy>", "Unity3D")
    vim.Map("5", "<Unity3D_Project>", "Unity3D")
    vim.Map("6", "<Unity3D_Animation>", "Unity3D")

    vim.Map("a", "<Unity3D_Add>", "Unity3D")
    ; vim.Map("p", "<Unity3D_Play>", "Unity3D")
    vim.Map("d", "<Unity3D_Duplicate>", "Unity3D")
    vim.Map("h", "<Unity3D_ObjectHiden>", "Unity3D")

    vim.Map("rr", "<Unity3D_Retset_All>", "Unity3D")
    vim.Map("r1", "<Unity3D_Retset_Position>", "Unity3D")
    vim.Map("r2", "<Unity3D_Retset_Rotation>", "Unity3D")
    vim.Map("r3", "<Unity3D_Retset_Scale>", "Unity3D")

    vim.Map("vcn", "<Unity3D_CreateEmpty>", "Unity3D")
    vim.Map("vcv", "<Unity3D_CreateEmptyCh>", "Unity3D")
    vim.Map("vcc", "<Unity3D_Particle_1>", "Unity3D")

    vim.Map("e", "<Unity3D_基本操作_旋转缩放切换>", "Unity3D")
    vim.Map("w", "<Unity3D_基本操作_位移移动切换>", "Unity3D")
    vim.Map("s", "<Unity3D_AddToSelectionSave>", "Unity3D")
    vim.Map("f", "<Unity3D_AddCameraView>", "Unity3D")
    vim.Map("<SP-i>", "<Unity3D_Help>", "Unity3D")
    vim.map("?","<ShowHelp>","Unity3D")
    vim.Map("/1", "<Unity3D_HelpWeb>", "Unity3D")

return

;判断输入状态屏蔽
Unity3D_CheckMode(){
    ControlGetFocus, ctrl, A
    If (A_Cursor=="Arrow") 
    {
        return False
    }
    else
    {
        return True
    }
    return
}

<Unity3D_NormalMode>:
;   send,{esc}
    SetModUINormal()
    vim.SetMode("normal", "Unity3D")
return

<Unity3D_InsertMode>:
;   send,{esc}
    SetModUIInsert()
    vim.SetMode("insert", "Unity3D")
return

;【全局运行Unity3D】
<RunUnity3D>:
{
    ExePath := ini.BOBOPath_Config.UnityPath
    tClass := ini.ahk_class_Config.UnityClass
    FunBoBO_RunActivation(ExePath,tClass)
    Return
}

<Unity3D_Help>:
ShowLayoutIMG("unityHelp1.png")
KeyWait i
HideLayoutIMG()
return

;创建空挂点
<Unity3D_CreateEmpty>:
send,^+{n}
return
;创建空挂点（子）
<Unity3D_CreateEmptyCh>:
send,!+{n}
return
;创建粒子
<Unity3D_Particle_1>:
{
send ^+!{1}
return
}


<Unity3D_Duplicate>:
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, Unity_tappedkey_d, %t%
    if (t == "off")
    goto Unity_double_d
    return

    Unity_tappedkey_d:
    send,^{d}
    return

    Unity_double_d:
    Send,{Delete}
    return
return

<Unity3D_AddCameraView>:
{
    t := A_PriorHotkey == A_ThisHotkey && A_TimeSincePriorHotkey < 200 ? "off" : -200
    settimer, Unity_tappedkey_f, %t%
    if (t == "off")
    goto Unity_double_f
    return

    Unity_tappedkey_f:
    send,f
    return

    Unity_double_f:
    Send,^+{f}
    return
}

<Unity3D_Play>:
{
toggle := !toggle
If (toggle)
    send ^{p}
else
    send ^+{p}
return
}
;窗口切换
<Unity3D_Zoom>:
send !{Space}
return

; https://gist.github.com/katapad/ba6a3c76da1337cb80fde08521c59beb
; ; http://d.hatena.ne.jp/monk_saruhobo/20050712/p1
; ; https://sites.google.com/site/agkh6mze/howto/detect_window
; $^p::
; if ( WinActive("ahk_class SunAwtFrame")  ) {
;   WinActivate, Unity
;   Sleep, 500
;   Send, ^p
;   return
; } else {
;     Send, ^p
; }
; return
; ;hoge-project - [C:\Users\hoge\hoge.sln] - Hoge.cs - Rider 1.0 EAP
; ;ahk_class SunAwtFrame
; ;ahk_exe rider64.exe

;https://github.com/rakete/unity_do

<Unity3D_Hierarchy>:
send ^{4}
return
<Unity3D_Project>:
send ^{5}
return
<Unity3D_Animation>:
send ^{6}
return
<Unity3D_Add>:
send ^+{a}
return

;重置
<Unity3D_Retset_All>:
send ^!{a}
return

<Unity3D_Retset_Position>:
send ^!{z}
return

<Unity3D_Retset_Rotation>:
send ^!{r}
return

<Unity3D_Retset_Scale>:
send ^!{s}
return

<Unity3D_ObjectHiden>:
send ^+!{h}
return


<Unity3D_基本操作_位移移动切换>:
{
	; If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
	; 	Send q
	; else
	; 	Send w
	; return
    toggle := !toggle
    If (toggle)
        Send q
    else
        Send w
    return
}

<Unity3D_基本操作_旋转缩放切换>:
{
    toggle := !toggle
    If (toggle)
        Send e
    else
        Send r
	return
}



<Unity3D_AddToSelectionSave>:
	If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 600){
		;save scene
		Send {LControl downtemp}{s}
		Send {LControl Up}
		return
	}Else{
		;left control
		Send {LCtrl Down}
		KeyWait, s
			Send {LCtrl Up}
		return
	}
return


<Unity3D_HelpWeb>:
run,https://www.kancloud.cn/funbobosky/vim_unity
return