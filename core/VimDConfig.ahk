VimDConfig: ;{
    vim.SetPlugin("VimDConfig", "Array", "0.1", "VimDesktop的配置界面")
    vim.SetAction("<VimDConfig_Plugin>", "显示 VimDesktop 插件信息")
    vim.SetAction("<VimDConfig_Keymap>", "显示 VimDesktop 热键信息")
    vim.SetAction("<VimDConfig_EditConfig>", "打开 VimDesktop 配置文件")
return
;}
<VimDConfig_KeymapEdit>: ;{
    ;初始化所有数据
    global vim
    vim:=
    vim := class_vim()
    for plugin, flag in ini.plugins
    {
        try
            vim.LoadPlugin(plugin)
    }
    ; 第二个参数为存放描述信息的全局变量名
    act := vim.SetAction("VIMD_CMD", "VIMD_CMD_LIST")
    act.SetFunction("VIMD_CMD")
    CheckHotKey()
    
    ;生成窗体
    menu, VimDConfig_keymap_menu, add
    menu, VimDConfig_keymap_menu, add, &Exit, VimDConfig_keymap_exit

    GUI, VimDConfig_keymap:Destroy
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:Font, s10, Microsoft YaHei

    GUI, VimDConfig_keymap:Add, GroupBox, x10 y10 w200 h345, 插件(右键：启用/禁用)
    GUI, VimDConfig_keymap:Add, Listview,  x20 y35 w180 h310 grid altsubmit gVimDConfig_keymap_loadmodelist , 状态|插件名称
    
    
    GUI, VimDConfig_keymap:Add, GroupBox, x10 y360 w200 h135, 模式(右键：设置默认)
    GUI, VimDConfig_keymap:Add, Listview,  x20 y385 w180 h100 grid altsubmit  gVimDConfig_keymap_loadhotkey, 默认|模式名称

    GUI, VimDConfig_keymap:Add, GroupBox, x215 y10 w650 h486, 映射(左键：双击改键，右键：双击编辑)
    ;~ GUI, VimDConfig_keymap:Add,  Button, x225 y36 w80 h25 gBtn_New, 新增(&A)
    ;~ GUI, VimDConfig_keymap:Add,  Button, x325 y36 w80 h25 gBtn_Edit, 修改(&E)
    ;~ GUI, VimDConfig_keymap:Add,  Button, x425 y36 w80 h25 gBtn_Delete, 删除(&D)
    ;~ GUI, VimDConfig_keymap:Add,  Button, x525 y36 w80 h25 gBtn_Save, 保存(&S)
    
    GUI, VimDConfig_keymap:Add, Text, x670 y38 w30 h21, 过滤
    GUI, VimDConfig_keymap:Add, Edit, gsearch_keymap v_search x705 y36 w150 h25
    
    GUI, VimDConfig_keymap:Add, Listview,glistview x225 y66 w630 h420 grid , 序号|热键|动作|描述

    LV_ModifyCol(1, "left 40")
    LV_ModifyCol(2, "left 100")
    LV_ModifyCol(3, "left 250")
    LV_ModifyCol(4, "left 235")

    VimDConfig_keymap_loadwinlist()
    ;~ VimDConfig_keymap_loadhotkey(VimDConfig_keymap_loadmodelist(thiswin))

    GUI, VimDConfig_keymap:Show
    
    ;~ GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview321
    LV_Modify(1, "Select")
    
    GUI, VimDConfig_keymap:ListView, sysListview322
    LV_Modify(1, "Select")
    
    ControlFocus, Edit1, A
return
;}

Btn_New: ;{
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview323
    Actions:=""
    Loop % LV_GetCount()
    {
        LV_GetText(TemAction, A_Index, 3) 
        Actions.=TemAction "|"
    }

    GUI, VimDConfig_NewKeyMap:Destroy
    GUI, VimDConfig_NewKeyMap:Default
    GUI, VimDConfig_NewKeyMap:Font, s10, Microsoft YaHei
    GUI, VimDConfig_NewKeyMap:Add, GroupBox, x10 y10 h65 w540, 热键名称
    GUI, VimDConfig_NewKeyMap:Add, Edit, x20 y35 h26 w355
    GUI, VimDConfig_NewKeyMap:Add, Button, x380 y35 h26 w80 gBtn_KeyFront, 热键前缀
    GUI, VimDConfig_NewKeyMap:Add, Button, x460 y35 h26 w80 gBtn_KeyHelp, 热键说明
    GUI, VimDConfig_NewKeyMap:Add, GroupBox, x10 y80 h65 w540,功能
    GUI, VimDConfig_NewKeyMap:Add, DDL, x20 y105 w520 readonly,%Actions%
    GUI, VimDConfig_NewKeyMap:Add, GroupBox, x10 y150 h65 w540,热键说明
    GUI, VimDConfig_NewKeyMap:Add, Edit, x20 y175 h26 w520
    ;~ GUI, VimDConfig_NewKeyMap:Add, CheckBox, x15 y225 h26
    GUI, VimDConfig_NewKeyMap:Add, Button, x200 y225 h26 w100 gBtn_KeyContinue, 添加并继续
    GUI, VimDConfig_NewKeyMap:Add, Button, x320 y225 h26 w100 default gBtn_KeyOK, 确定
    GUI, VimDConfig_NewKeyMap:Add, Button, x440 y225 h26 w100 gBtn_KeyCancle, 取消
    
    GUI, VimDConfig_NewKeyMap:show

return
;}
Btn_Edit: ;{
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview323
return
;}
Btn_Delete: ;{
    
return
;}
Btn_Save: ;{
    ini.save()
    reload
return
;}

Btn_KeyFront: ;{
    
return
;}
Btn_KeyHelp: ;{
    
return
;}
Btn_KeyContinue: ;{
    
return
;}
Btn_KeyOK: ;{
    
return
;}
Btn_KeyCancle: ;{
    GUI, VimDConfig_NewKeyMap:Destroy
return
;}

<VimDConfig_EditConfig>: ;{
    Run, %A_ScriptDir%\config.ini
return
;}

<VimDConfig_EditCustom>: ;{
    global editor
    try 
    {
        IfExist,%editor%
            Run "%editor%" "%A_ScriptDir%\custom.ahk"
        else
            Run notepad.exe "%A_ScriptDir%\custom.ahk"
    }
;}

;~ VimDConfig_LoadActions: ;{
    ;~ If A_GuiEvent = I
    ;~ {
        ;~ if not InStr(ErrorLevel, "S", true)
        ;~ {
            ;~ return
        ;~ }

        ;~ GUI, VimDConfig_plugin:ListView, sysListview322
        ;~ LV_GetText(plugin, A_EventInfo)
        ;~ GUI, VimDConfig_plugin:Default
        ;~ GUI, VimDConfig_plugin:ListView, sysListview321
        ;~ idx := 1
        ;~ LV_Delete()

        ;~ global current_plugin := ""
        ;~ for action, type in vim.ActionFromPlugin
        ;~ {
            ;~ If type = %plugin%
            ;~ {
                ;~ Desc := vim.GetAction(action)
                ;~ LV_Add("", idx, action, Desc.Comment)
                ;~ current_plugin .= idx "`t" action "`t" Desc.Comment "`n"
                ;~ idx++
            ;~ }
        ;~ }
    ;~ }

    ;~ ControlFocus, Edit1, A
;~ return
;~ ;}

VimDConfig_keymap_exit: ;{
    GUI, VimDConfig_keymap:Destroy
return
;}

VimDConfig_keymap_loadwinlist(){
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview321
    LV_delete()
    LV_Add("","启用", "全局")
    for plugin, flag in ini.plugins
        if flag
            LV_Add("","启用", plugin)
        else
            LV_Add("","禁用", plugin)
    
}

VimDConfig_keymap_loadmodelist: ;{
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview321
    If (A_GuiEvent = "normal")
    {
        GUI, VimDConfig_keymap:ListView, sysListview321
        FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
        if not FocusedRowNumber  ; 没有焦点行.
            return
        LV_GetText(plugin, FocusedRowNumber, 2) 
        LV_GetText(MyStatus, FocusedRowNumber,1) 
        if (plugin="TotalCommander")
            plugin=TTOTAL_CMD
        If plugin = 全局
            winObj := vim.GetWin()
        Else
            winObj := vim.GetWin(plugin)
        GUI, VimDConfig_keymap:ListView, sysListview322
        LV_delete()
        for mode, obj in winObj.modeList
        {
            if (ini.plugins_DefaultMode[plugin]=mode)
                LV_Add("","默认", mode)
            else
                LV_Add("","", mode)
        }
        LV_Modify(1, "Select")
        GUI, VimDConfig_keymap:ListView, sysListview323
        LV_delete()
        GUI, VimDConfig_keymap:ListView, sysListview321
    }
    If (A_GuiEvent = "RightClick")
    {
        ;获取菜单数据
        GUI, VimDConfig_keymap:ListView, sysListview321
        FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
        if not FocusedRowNumber  ; 没有焦点行.
            return
        LV_GetText(plugin, FocusedRowNumber, 2) 
        LV_GetText(MyStatus, FocusedRowNumber,1) 
        ;生成菜单
        CoordMode, Mouse, Relative
        MouseGetPos,CurX,CurY
        Menu, MyMenu_Plugins, Add
        Menu, MyMenu_Plugins, DeleteAll
        if (MyStatus="禁用")
            Menu, MyMenu_Plugins, Add, 启用 ,_MyMenu_Plugins_Hanlder
        else
            Menu, MyMenu_Plugins, Add, 禁用 ,_MyMenu_Plugins_Hanlder
        Menu, MyMenu_Plugins, Show, %CurX%, %CurY%
        CoordMode, Mouse, Screen
        return
        
        _MyMenu_Plugins_Hanlder:
            GUI, VimDConfig_keymap:Default
            GUI, VimDConfig_keymap:ListView, sysListview321
            FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
            LV_GetText(plugin, FocusedRowNumber, 2) 

            global ini
            if(A_ThisMenuItem="禁用"){
                LV_Modify(FocusedRowNumber,"Col1","禁用")
                Rst:=ini.AddKey("plugins",plugin,0)
                if !Rst
                    ini.plugins[plugin]:=0
            }else{
                LV_Modify(FocusedRowNumber,"Col1","启用" )
                Rst:=ini.AddKey("plugins",plugin,1)
                if !Rst
                    ini.plugins[plugin]:=1
            }
            ini.save()
        return
    }
return
;}

VimDConfig_keymap_loadhotkey: ;{
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview322
    If (A_GuiEvent = "normal")
    {
        GUI, VimDConfig_keymap:Default
        GUI, VimDConfig_keymap:ListView, sysListview321
        FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
        if not FocusedRowNumber  ; 没有焦点行.
            return
        LV_GetText(plugin, FocusedRowNumber, 2) 

        win := RegExMatch(plugin, "^全局$") ? "" : plugin

        ; Convert plugin name TotalCommander to class name TTOTAL_CMD
        if (win = "TotalCommander")
        {
            win := "TTOTAL_CMD"
        }

        GUI, VimDConfig_keymap:ListView, sysListview322
        FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
        if not FocusedRowNumber  ; 没有焦点行.
            return
        LV_GetText(mode, FocusedRowNumber, 2) 
        VimDConfig_keymap_loadhotkey(win, mode)
    }
     If (A_GuiEvent = "RightClick")
    {
        ;获取菜单数据
        GUI, VimDConfig_keymap:ListView, sysListview322
        FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
        ;生成菜单
        CoordMode, Mouse, Relative
        MouseGetPos,CurX,CurY
        Menu, MyMenu_Modes, Add
        Menu, MyMenu_Modes, DeleteAll
        Menu, MyMenu_Modes, Add, 设为默认 ,_MyMenu_Modes_Hanlder
        Menu, MyMenu_Modes, Show, %CurX%, %CurY%
        CoordMode, Mouse, Screen
        return
        
        _MyMenu_Modes_Hanlder:
            GUI, VimDConfig_keymap:Default
            GUI, VimDConfig_keymap:ListView, sysListview321
            FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
            LV_GetText(plugin, FocusedRowNumber, 2) 
            if (plugin="TotalCommander")
                plugin=TTOTAL_CMD
            GUI, VimDConfig_keymap:ListView, sysListview322
            FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
            LV_GetText(mode, FocusedRowNumber, 2) 
            Loop % LV_GetCount()
            {
                if(A_index!=FocusedRowNumber){
                    LV_Modify(A_index,"Col1","")
                }else{
                    LV_Modify(A_index,"Col1","默认")
                    Rst:=ini.AddKey("plugins_DefaultMode",plugin,mode)
                    if !Rst
                        ini.plugins_DefaultMode[plugin]:=mode
                }
            }
            ini.save()
        return
    }
return
;}

VimDConfig_keymap_loadhotkey(win, mode = ""){
    global vim
    global current_keymap := ""
    If strlen(mode)
    {
        winObj  := vim.GetWin(win)
        modeobj := winObj.modeList[mode]
    }
    Else
        modeobj := vim.GetMode(win)
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview323
    LV_delete()
    N:=0
    for key, i in modeobj.keymapList
    {
        ; Type = 1 : Function
        N+=1
        if (vim.GetAction(i).Type = 1)
        {
            ActionDescList := vim.GetAction(i).Comment
            actionDesc := StrSplit(%ActionDescList%[key], "|")
            LV_ADD("",N, Key, actionDesc[1], actionDesc[2])
            current_keymap .= Key "`t" actionDesc[1] "`t" actionDesc[2] "`n"
        }
        else
        {
            ;【Kawvin】2018-04-04-00:01:58-----------------------------------------------------------------
            ShiftKey:=Key
            OutK:=Key
            MyMatchArray:=MyFun_RegExMatchAll(ShiftKey,"<S-.*?>")
            Idx:=1
            while (Idx<=MyMatchArray.maxindex())
            {
                TemK:=StrReplace( MyMatchArray[Idx],"<S-","")
                TemK:=StrReplace(TemK,">","")
                OutK:=StrReplace(OutK,MyMatchArray[Idx],TemK)
                Idx+=1
            }
            LV_Add("",N, OutK, i, vim.GetAction(i).Comment)
            ;~ LV_Add("",N,RegExReplace(key, "<S-(.*)>", "$1"), i, vim.GetAction(i).Comment)        ;注销换上面内容
            ;【Kawvin】2018-04-04-00:01:58-----------------------------------------------------------------
            current_keymap .= Key "`t" i "`t" vim.GetAction(i).Comment "`n"
        }
    }
}

listview: ;{
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview323
    if A_GuiEvent = DoubleClick
    {
        ;~ ToolTip You double-clicked row number %A_EventInfo%.
        LV_GetText(SelectedKeys, A_EventInfo, 2)
        LV_GetText(SelectedAction, A_EventInfo, 3)
        LV_GetText(SelectedDesc, A_EventInfo, 4)
        SearchFileForKey(SelectedKeys,SelectedAction, SelectedDesc, true)
    }
    else if A_GuiEvent = R
    {
        LV_GetText(SelectedAction, A_EventInfo, 3)
        LV_GetText(SelectedDesc, A_EventInfo, 4)
        SearchFileForEdit(SelectedAction, SelectedDesc, false)
    }
return
;}

SearchFileForKey(Keys,Action, Desc, EditKeyMapping){
   GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview321
    FocusedRowNumber := LV_GetNext(0, "F")  ; 查找焦点行.
    LV_GetText(plugin, FocusedRowNumber, 2) 
    
    label := "vim.map(" . """" . Keys
    if (Action == "function")
    {
        label := Desc
    }
    ;【Kawvin】2018-04-03-23:04:30--------------------------------------------------------
    ;~ Loop, %A_ScriptDir%\plugins\*.ahk, , 1
    ;~ {
        ;~ Loop, Read, %A_LoopFileFullPath%
        ;~ {
            
            ;~ ;if (InStr(A_LoopReadLine, label) == 1)
            ;~ if (InStr(A_LoopReadLine, label) )
            ;~ {
                ;~ EditFile(A_LoopFileFullPath, A_Index)
                ;~ return
            ;~ }
        ;~ }
    ;~ }
    PluginPath=%A_ScriptDir%\plugins\%plugin%\%plugin%.ahk
    Loop, Read, %PluginPath%
    {
        if (InStr(A_LoopReadLine, label) )
        {
            EditFile(PluginPath, A_Index)
            return
        }
    }
    ;【Kawvin】2018-04-03-23:04:30--------------------------------------------------------
    
    Loop, %A_ScriptDir%\core\*.ahk, , 1
    {
        Loop, Read, %A_LoopFileFullPath%
        {
            ;~ if (InStr(A_LoopReadLine, label) = 1)
            if (InStr(A_LoopReadLine, label) )
            {
                EditFile(A_LoopFileFullPath, A_Index)
                return
            }
        }
    }
    
    IsUserCmd := RegExMatch(Action, "^(run|key|dir|tccmd|wshkey)$")
    if (IsUserCmd || EditKeyMapping)
    {
        SearchLine := "=" Action
        if (IsUserCmd || Action == "function")
        {
            SearchLine := Action "|" Desc
        }

        Loop, Read, %A_ScriptDir%\config.ini
        {
            if (InStr(A_LoopReadLine, SearchLine))
            {
                EditFile(A_ScriptDir "\config.ini", A_Index)
                return
            }
        }

        EditFile(A_ScriptDir "\config.ini")
        return
    }
}

SearchFileForEdit(Action, Desc, EditKeyMapping){
    label := Action ":"
    if (Action == "function")
    {
        label := Desc
    }
    Loop, %A_ScriptDir%\plugins\*.ahk, , 1
    {
        Loop, Read, %A_LoopFileFullPath%
        {
            
            if (InStr(A_LoopReadLine, label) == 1)
            {
                EditFile(A_LoopFileFullPath, A_Index)
                return
            }
        }
    }

    Loop, %A_ScriptDir%\core\*.ahk, , 1
    {
        Loop, Read, %A_LoopFileFullPath%
        {
            if (InStr(A_LoopReadLine, label) = 1)
            {
                EditFile(A_LoopFileFullPath, A_Index)
                return
            }
        }
    }
    
    IsUserCmd := RegExMatch(Action, "^(run|key|dir|tccmd|wshkey)$")
    if (IsUserCmd)
    {
        SearchLine := "=" Action
        if (IsUserCmd || Action == "function")
        {
            SearchLine := Action "|" Desc
        }

        Loop, Read, %A_ScriptDir%\config.ini
        {
            if (InStr(A_LoopReadLine, SearchLine))
            {
                EditFile(A_ScriptDir "\config.ini", A_Index)
                return
            }
        }

        EditFile(A_ScriptDir "\config.ini")
        return
    }
}

EditFile(editPath, line := 1){
    editorArgs := {}
    editorArgs["notepad"] := "/g $line $file"
    editorArgs["notepad2"] := "/g $line $file"
    editorArgs["sublime_text"] := "$file:$line"
    editorArgs["vim"] := "+$line $file"
    editorArgs["gvim"] := "--remote-silent-tab +$line $file"
    editorArgs["everedit"] := "-n$line $file"
    editorArgs["notepad++"] := "-n$line $file"
    editorArgs["EmEditor"] := "-l $line $file"
    editorArgs["uedit32"] := "$file/$line"
    editorArgs["Editplus"] := "$file -cursor $line"
    editorArgs["textpad"] := "$file($line)"
    editorArgs["pspad"] := "$file /$line"
    editorArgs["ConTEXT"] := "$file /g1:$line"
    editorArgs["scite"] := "$file -goto:$line"

    Global editor
    
    If not FileExist(editor)
    {
        MsgBox, 4, 提示, 未配置【编辑器】路径，是否设置路径？`n--------------------------`n【是】设置路径`n【否】以[记事本]打开`n-------------------------- 
        ifmsgbox,Yes
        {
            ;选择文件
            FileSelectFile, MySelFile, 1, , 选择编辑器, 程序(*.exe)
            if ErrorLevel
                editor:=""
            if MySelFile =
                editor:=""
            editor:=MySelFile
            ini.config.editor:=MySelFile
            ini.save()
            reload
        }
    }
    if editor=
        editor:="notepad.exe"

    ; 根据编辑器 exe 名称获取打开参数
    SplitPath, editor, , , OutExtension, OutNameNoExt
    args := editorArgs[OutNameNoExt]
    StringReplace, args, args, $line, %line%
    StringReplace, args, args, $file, "%editPath%"
    target := editor " " args

    run, %target%
}

search_keymap: ;{
    global current_keymap
    search_to_display(current_keymap)
return
;}

search_plugin: ;{
    global current_plugin
    search_to_display(current_plugin)
return
;}

search_to_display(lines){
    Gui Submit, nohide
    GuiControlGet, OutputVar, , _search

    text := StrSplit(lines, "`n")
    GUI, VimDConfig_keymap:Default
    GUI, VimDConfig_keymap:ListView, sysListview323
    LV_Delete() ; 清理不掉，第二次加载后，都成了重复的了，不知道怎么处理
    GuiControl, -Redraw, listview ; 重新启用重绘 (上面把它禁用了)
    N:=0
    for k, v in text
    {
        if v =
            continue
        N+=1
        if Instr(v, OutputVar)
        {
            list := StrSplit(v, "`t")
            LV_Add("", N,list[1], list[2], list[3])
        }
    }
    GuiControl, +Redraw, listview ; 重新启用重绘 (上面把它禁用了)
}
