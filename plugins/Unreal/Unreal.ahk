Unreal:
    vim.SetAction("<Unreal_InsertMode>", "进入VIM模式")
    vim.SetAction("<Unreal_NormalMode>", "返回正常模式")
    vim.SetWin("Unreal","GHOST_WindowClass","UE4Editor.exe")
    vim.BeforeActionDo("Unreal_CheckMode", "Unreal")
    
;normal模式
    vim.SetMode("normal", "Unreal")
    vim.Map("<insert>", "<Unreal_SwithMode>", "Unreal")

;insert模式
    vim.Comment("<Unreal_Materials_If>", "If_条件表达式")
    vim.Comment("<Unreal_Materials_Multiply>", "Multiply_乘法表达式")
    vim.Comment("<Unreal_Materials_Mask>", "Mask_分离通道")
    vim.Comment("<Unreal_Materials_Constant>", "Constant_常量")
    vim.Comment("<Unreal_Materials_Constant2Vector>", "Constant2Vector_二维常量")
    vim.Comment("<Unreal_Materials_Constant3Vector>", "Constant3Vector_三维常量")
    vim.Comment("<Unreal_Materials_Constant4Vector>", "Constant4Vector_四维常量")
    vim.Comment("<Unreal_Materials_Power>", "Power_求幂值")
    vim.Comment("<Unreal_Materials_Panner>", "Panner_平移器")
    vim.Comment("<Unreal_Materials_ScalarParameter>", "Paramete_参数化常量")
    vim.Comment("<Unreal_Materials_VectorParam>", "VectorParam_参数化(四维常量)")
    vim.Comment("<Unreal_Materials_Add>", "Add_加法")
    vim.Comment("<Unreal_Materials_OneMinus>", "OneMinus_一减去")
    vim.Comment("<Unreal_Materials_ReflectionVector>", "ReflectionVector_反射向量")
    vim.Comment("<Unreal_Materials_Divide>", "Divide_除法")
    vim.Comment("<Unreal_Materials_BumpOffset>", "BumpOffset_凹凸分离")
    vim.Comment("<Unreal_Materials_LinearInterpolate>", "LinearInterpolate_线性插值")
    vim.Comment("<Unreal_Materials_TextureSample>", "TextureSample_贴图采样")
    vim.Comment("<Unreal_Materials_TextureCoordinate>", "TextureCoordinate_贴图坐标")


    vim.SetMode("insert", "Unreal")
    vim.Map("<insert>", "<Unreal_SwithMode>", "Unreal")

    vim.Map("<F2>", "<Unreal_test>", "Unreal")

    vim.Map("=", "<Unreal_屏幕上>", "Unreal")
    vim.Map("-", "<Unreal_屏幕下>", "Unreal")

    ; vim.Map("<Caps-w>", "<Unreal_上>", "Unreal")
    ; vim.Map("<Caps-s>", "<Unreal_下>", "Unreal")
 

    vim.Map("<SP-v>i", "<Unreal_Materials_If>", "Unreal")
    vim.Map("<SP-v>mu", "<Unreal_Materials_Multiply>", "Unreal")
    vim.Map("<SP-v>ma", "<Unreal_Materials_Mask>", "Unreal")
    vim.Map("<SP-v>vv", "<Unreal_Materials_Constant>", "Unreal")
    vim.Map("<SP-v>v1", "<Unreal_Materials_Constant2Vector>", "Unreal")
    vim.Map("<SP-v>v2", "<Unreal_Materials_Constant2Vector>", "Unreal")
    vim.Map("<SP-v>v3", "<Unreal_Materials_Constant3Vector>", "Unreal")
    vim.Map("<SP-v>v4", "<Unreal_Materials_Constant4Vector>", "Unreal")
    vim.Map("<SP-v>po", "<Unreal_Materials_Power>", "Unreal")
    vim.Map("<SP-v>pa", "<Unreal_Materials_Panner>", "Unreal")
    vim.Map("<SP-v>ps1", "<Unreal_Materials_ScalarParameter>", "Unreal")
    vim.Map("<SP-v>ps4", "<Unreal_Materials_VectorParam>", "Unreal")
    vim.Map("<SP-v>a", "<Unreal_Materials_Add>", "Unreal")
    vim.Map("<SP-v>o", "<Unreal_Materials_OneMinus>", "Unreal")
    vim.Map("<SP-v>r", "<Unreal_Materials_ReflectionVector>", "Unreal")
    vim.Map("<SP-v>d", "<Unreal_Materials_Divide>", "Unreal")
    vim.Map("<SP-v>b", "<Unreal_Materials_BumpOffset>", "Unreal")
    vim.Map("<SP-v>l", "<Unreal_Materials_LinearInterpolate>", "Unreal")
    vim.Map("<SP-v>t", "<Unreal_Materials_TextureSample>", "Unreal")
    vim.Map("<SP-v>u", "<Unreal_Materials_TextureCoordinate>", "Unreal")

    ; vim.Map("s", "<Unreal_RButton>", "Unreal")
  

    ; vim.Map("<a-c>", "<Unreal_吸附>", "Unreal")




    vim.Map("<a-h>", "<Unreal_物件_显示>", "Unreal")
    ; vim.Map("d", "<Unreal_快速复制选中>", "Unreal")
    ; vim.Map("w", "<Unreal_视窗_切换显示>", "Unreal")

    vim.Map("<LB-z>", "<Unreal_FindObject>", "Unreal")

    vim.Map("<F4>", "<Unreal_视图>", "Unreal")
    vim.Map("<LB-F4>", "<Unreal_视图_默认>", "Unreal")
    vim.map("<Space>", "<Unreal_Space>", "Unreal")
    vim.Map("<SP-q>1", "<Unreal_视图_透视>", "Unreal")
    vim.Map("<SP-q>2", "<Unreal_视图_顶视图>", "Unreal")
    vim.Map("<SP-q>3", "<Unreal_视图_左视图>", "Unreal")
    vim.Map("<SP-q>4", "<Unreal_视图_前视图>", "Unreal")
    vim.Map("<SP-q>5", "<Unreal_视图_后视图>", "Unreal")

    vim.Map("<a-q>", "<Unreal_RButton>", "Unreal")

    vim.BeforeActionDo("Unrea ml_CheckMode", "Unreal") ; by Array
    #Include %A_ScriptDir%\plugins\Unreal\UnrealPlus.ahk
    ; vim.Map("<Caps-w>", "<Unreal_RButton>", "Unreal")
    ; vim.Map("<Caps-s>", "<Unreal_移动下>", "Unreal")
    ;载入增强按键plugins
    

    ;载入按键
    ; #Include %A_ScriptDir%\plugins\Unreal\UnrealKey.ahk

return

;   输入状时态屏蔽
Unreal_CheckMode()
{
    ControlGetFocus, ctrl, A
    If RegExMatch(ctrl,"i)Edit")
        {
            return True 
        }
        
    If (A_Cursor=="IBeam") ;工字光标
        {
            ; Menu, Tray, Icon, %A_ScriptDir%\workflow_icon_normal.png ;切换到默认模式
            return False
        }
}

;全局运行
; <RunUnreal>:
;     ExePath := ini.BOBOPath_Config.Unreal
;     tClass := ini.ahk_class_Config.UnrealClass
;     FunBoBO_RunActivation(ExePath,tClass)
; Return

;单键切换模式
<Unreal_SwithMode>:
        if  Unreal_var=2 ; 总
            Unreal_var=0
            Unreal_var+=1
        if (Unreal_var=1 )
        {    
            GoSub,<Unreal_NormalMode>
            return
        }
        if (Unreal_var=2)
        {
            GoSub,<Unreal_InsertMode>
            return
        }
return

;默认模式
<Unreal_NormalMode>:
    SetModUINormal()
    vim.SetMode("normal", "Unreal")
return

;进入模式
<Unreal_InsertMode>:
    SetModUIInsert()
    vim.SetMode("insert", "Unreal")
return



<Unreal_test>:
 MsgBox, "Hello"
return

<Unreal_Space>:
Send, {Space}
Return
; filename = "F:/BoBOAHK/WorkFlow/custom/Unreal/test.py"
; exec(compile(open(filename).read(), filename, 'exec'))

<Unreal_屏幕上>:
    Send, {WheelUp}
return
<Unreal_屏幕下>:
    Send, {WheelDown}
return


<Unreal_上>:
            Send,{PgUp}

return
<Unreal_下>:
    ; Loop
	; {
	;     sleep, 14
	; 	GetKeyState, state, s, p
	; 	if state = u
	; 	break
	; 	if state = d
		Send,{PgDn}
	; }
return

<Unreal_Materials_If>:
    Unreal_Materials("if")
Return
<Unreal_Materials_Mask>:
    Unreal_Materials("Mask")
Return

<Unreal_Materials_Constant>:
    Unreal_Materials("Constant")
Return

<Unreal_Materials_Constant2Vector>:
    Unreal_Materials("Constant2Vector")
Return

<Unreal_Materials_Constant3Vector>:
    Unreal_Materials("Constant3Vector")
Return

<Unreal_Materials_Constant4Vector>:
    Unreal_Materials("Constant4Vector")
Return

<Unreal_Materials_Power>:
    Unreal_Materials("Power")
Return

<Unreal_Materials_ReflectionVector>:
    Unreal_Materials("ReflectionVector")
Return

<Unreal_Materials_TextureSample>:
    Unreal_Materials("TextureSample")
Return

<Unreal_Materials_TextureCoordinate>:
    Unreal_Materials("TextureCoordinate")
Return

<Unreal_Materials_OneMinus>:
    Unreal_Materials("OneMinus")
Return

<Unreal_Materials_Panner>:
    Unreal_Materials("Panner")
Return

<Unreal_Materials_Add>:
    Unreal_Materials("Add")
Return

<Unreal_Materials_ScalarParameter>:
    Unreal_Materials("ScalarParameter")
Return

<Unreal_Materials_Divide>:
    Unreal_Materials("Divide")
Return

<Unreal_Materials_LinearInterpolate>:
    Unreal_Materials("LinearInterpolate")
Return

<Unreal_Materials_VectorParam>:
    Unreal_Materials("VectorParam")
Return

<Unreal_Materials_BumpOffset>:
    Unreal_Materials("BumpOffset")
Return

<Unreal_Materials_Multiply>:
    Unreal_Materials("Multiply")
Return


<Unreal_RButton>:
    ; Send, {Click, up, right}
    ; MouseMove, -10,  0,, R
    Send, {RButton}
Return

Unreal_Materials(Text){
    Clipboard=%Text%
    Send, {Click, up, right}
    sleep 60
    Send,^{v}
    sleep 10
    Send,{Enter}
    Clipboard:=""
    SetTimer,RemoveToolTip,Off
    return 
}


<Unreal_吸附>:
    Send, !{Mbutton Down}
    sleep 50
    Send,{Mbutton up}
Return

<Unreal_视图>:
{
    ;多次切换影响效率，故决定只做一个事件
    if Unreal_var=4 ; 总共几次 
    Unreal_var=0
    Unreal_var+=1

    if (Unreal_var=1)
    {
        send, !2
        return
    }
    if (Unreal_var=2)
    {
        send, !3
        return
    }
    if (Unreal_var=3)
    {
        send, !4
        return
    }
    if (Unreal_var=4)
    {
        send, !5
        return
    }
    if (Unreal_var=5)
    {
        send, !6
        return
    }
    return
    if (Unreal_var=6)
    {
        send, !7
        return
    }
    if (Unreal_var=7)
    {
        send, !8
        return
    }
    if (Unreal_var=8)
    {
        send, !0
        return
    }
    return
}
<Unreal_视图_默认>:
    send, !4
    return
return

<Unreal_FindObject>:
	GV_KeyClickAction1 := "Send, {f}"
	GV_KeyClickAction2 := "Send, 6"
	GoSub,Sub_KeyClick
Return


<Unreal_视图_透视>:
    GV_KeyClickAction1 := "send, !{g}"
	GV_KeyClickAction2 := "Send,^{p}"
	GoSub,Sub_KeyClick
return

<Unreal_视图_顶视图>:
    send, !{j}
return
<Unreal_视图_底视图>:
    send, !+{j}
return
<Unreal_视图_左视图>:
    send, !{k}
return
<Unreal_视图_右视图>:
    send, !+{k}
return
<Unreal_视图_前视图>:
    send, !{h}
return
<Unreal_视图_后视图>:
    send, !+{h}
return

<Unreal_物件_显示>:
    GV_KeyClickAction1 := "send, {h}"
	GV_KeyClickAction2 := "Send,^{h}"
	GoSub,Sub_KeyClick
return

<Unreal_视窗_切换显示>:
; 需要设置视窗快捷键为Alt+w
    GV_KeyClickAction1 := "send,{w}"
	GV_KeyClickAction2 := "Send,!{w}"
	GoSub,Sub_KeyClick
return

<Unreal_快速复制选中>:
    GV_KeyClickAction1 := "send,{d}"
	GV_KeyClickAction2 := "Send,^{w}"
	GoSub,Sub_KeyClick    
return