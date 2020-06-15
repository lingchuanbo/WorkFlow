#If WinActive("ahk_exe 3dsmax.exe")
{
	Esc::Gosub,<3DsMax_esc>
	+RButton::Gosub,menuDSMAX
	return
}

menuDSMAX:
	menu, menu3DsMax, add, 3DsMax脚本菜单(%_Author%), WHATSUPMAX
	dirMenu0=%A_ScriptDir%\custom\maxScripts\MenuScript

	menu_fromfiles("maxfilelist0", "脚本库", "RunScript3DsMax_Common", dirMenu0, "*.ms|*.mse", "menu3DsMax", 1)

	menu, menu3DsMax, add, .打开文件目录, OpenLocalFiles_3DsMax
	menu, menu3DsMax, add, .打开渲染目录, OpenLocalFilesRender_3DsMax
    ; menu, menu3DsMax, add, .整理项目&清理缓存,<3DsMax_OrganizeProjectAssetsDiskCache>

    menu, menu3DsMax, Show

return

WHATSUPMAX:
    msgbox, 3DsMax脚本目录 `n`n %dirMenu0%
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