#If WinActive("ahk_exe 3dsmax.exe")
{
	Esc::Gosub,<3DsMax_esc>
	+RButton::Gosub,menuDSMAX
	; ~LButton & RButton::send ^w
	return
}

menuDSMAX:
	menu, menu3DsMax, add, 3DsMax脚本菜单(%_Author%), WHATSUPMAX
	dirMenu0=%A_ScriptDir%\custom\maxScripts\MenuScript
	dirMenu1=%A_ScriptDir%\custom\maxScripts\MenuScriptCreate
	dirMenu2=%A_ScriptDir%\custom\maxScripts\GameDevelop

	menu_fromfiles("maxfilelist1", "创建常用物体", "RunScript3DsMax_Create", dirMenu1, "*.ms|*.mse|*.py", "menu3DsMax", 1)
	menu_fromfiles("maxfilelist0", "脚本库", "RunScript3DsMax_Common", dirMenu0, "*.ms|*.mse", "menu3DsMax", 1)
	
	menu_fromfiles("maxfilelist2", "游戏开发工具", "RunScript3DsMax_Develop", dirMenu2, "*.ms|*.mse", "menu3DsMax", 1)

	menu, menu3DsMax, add, .打开文件目录, OpenLocalFiles_3DsMax
	menu, menu3DsMax, add, .打开渲染目录, OpenLocalFilesRender_3DsMax
    ; menu, menu3DsMax, add, .整理项目&清理缓存,<3DsMax_OrganizeProjectAssetsDiskCache>

    menu, menu3DsMax, Show

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