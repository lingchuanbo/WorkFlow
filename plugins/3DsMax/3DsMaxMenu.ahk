#If WinActive("ahk_exe 3dsmax.exe")
{
	Esc::Gosub,<3DsMax_esc>
	+RButton::Gosub,menu3DSMAX
	; ~LButton & RButton::send ^w
	^!+p::runMaxScript("MenuScript\Utilites\初始化.ms")
	^!+o::runMaxScript("MenuScript\Utilites\2倍动画缩放.ms")
	^!+l::runMaxScript("MenuScript\Utilites\3倍动画缩放.ms")
	^!+i::runMaxScript("MenuScript\Utilites\4倍动画缩放.ms")
	^!+u::runMaxScript("MenuScript\Utilites\6倍动画缩放.ms")
}
#If WinActive("ahk_exe maya.exe")
{
	~Alt & MButton::
	send, {alt down}{lbutton down}
	keywait, MButton
	send, {alt up}{lbutton up}
	return
	MButton::
	send, {alt down}{mbutton down}
	keywait, MButton
	send, {alt up}{mbutton up}
	return
	~Alt & LButton::
		send, {mbutton down}
		keywait, LButton
		send, {mbutton up}
	return
	; https://cveld.net/?p=550
	;  ~S &amp; RButton::
	; send, {alt down}{Lbutton down}
	; keywait, RButton
	; send, {alt up}{Lbutton up}
	; return
	; ~S &amp; LButton::
	; send, {alt down}{Mbutton down}
	; keywait, LButton
	; send, {alt up}{Mbutton up}
	; return
	; ~S &amp; MButton::
	; send, {alt down}{Rbutton down}
	; keywait, MButton
	; send, {alt up}{Rbutton up}
	; return
	
	; MButton::
	; send, {alt down}{mbutton down}
	; keywait, MButton
	; send, {alt up}{mbutton up}
	; return
 
}
menu3DSMAX:
	; menu, menu3DsMax, add, 3DsMax脚本菜单(%_Author%), WHATSUPMAX
	dirMenu0=%A_ScriptDir%\custom\maxScripts\MenuScript
	dirMenu1=%A_ScriptDir%\custom\maxScripts\MenuScriptCreate
	dirMenu2=%A_ScriptDir%\custom\maxScripts\GameDevelop

	menu_fromfiles("maxfilelist1", "创建常用物体", "RunScript3DsMax_Create", dirMenu1, "*.ms|*.mse|*.py", "menu3DsMax", 1)
	menu_fromfiles("maxfilelist0", "脚本库", "RunScript3DsMax_Common", dirMenu0, "*.ms|*.mse", "menu3DsMax", 1)
	
	menu_fromfiles("maxfilelist2", "游戏开发工具", "RunScript3DsMax_Develop", dirMenu2, "*.ms|*.mse", "menu3DsMax", 1)

	menu, menu3DsMax, add, .打开文件目录, OpenLocalFiles_3DsMax
	menu, menu3DsMax, add, .打开渲染目录, OpenLocalFilesRender_3DsMax
	menu, menu3DsMax, add, .背景去黑|删除灯光, <3DSMAX_初始化去黑删灯光>
	menu, menu3DsMax, add, .输出同名, RenderDirFile_3DsMax
    ; menu, menu3DsMax, add, .整理项目&清理缓存,<3DsMax_OrganizeProjectAssetsDiskCache>

    menu, menu3DsMax, Show

return
RenderDirFile_3DsMax:
	runMaxScriptCommands("QuikeRender.ms")
return
WHATSUPMAX:
    msgbox, 3DsMax脚本库目录 `n`n %dirMenu0%
RETURN


<3DsMax_OrganizeProjectAssetsDiskCache>:
{
    runMaxScriptCommands("SPCleaner.mse")
    return
}
OpenLocalFiles_3DsMax:
{
	runMaxScriptCommands("openMaxfileDir.ms")
    return
}

OpenLocalFilesRender_3DsMax:
{
	runMaxScriptCommands("openRenderDir.ms")
	return
}



RunScript3DsMax_Common:
{
    runMXSPyCOM(menu_itempath("maxfilelist0", dirMenu0))
	return
}
RETURN

RunScript3DsMax_Create:
{
    runMXSPyCOM(menu_itempath("maxfilelist1", dirMenu1))
	return
}
RETURN

RunScript3DsMax_Develop:
{
    runMXSPyCOM(menu_itempath("maxfilelist2", dirMenu2))
	return
}
RETURN