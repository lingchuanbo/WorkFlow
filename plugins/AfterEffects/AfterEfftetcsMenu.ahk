﻿;=========================================================
;最后修改于2020-03-25
;BoBO
;=========================================================
function_menuAfterEffect:

#If WinActive("ahk_exe AfterFX.exe")
{
    F1::return
     ;;AE快速打开文件所在位置 至于是否启用TC到时候在考虑目前可以一直按alt+w
     ; !w::getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
    ^+!LButton::getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
     ;;便捷菜单
    +RButton::Gosub,menuAe
    ; !RButton::Gosub,menuAeAlt
}

menuAeAlt:
	; menu, menuAlt, add, , WHATSUP11111111111111111
	menu, menuAlt, add, (&R) 渲染, :ManageRender
	menu, ManageRender, add, %_AeRENDER%,RENDER
	menu, ManageRender, add, %_AeNameRENDER%,NameRENDER
	menu, ManageRender, add, %_AeNameDirection%,NameDirection
	menu, ManageRender, add, %_AeName%, Name
   Menu, menuAlt, Show
return


menuAe:
	menu, thismenu, add, AE动态脚本菜单(%_Author%), WHATSUP
	; menu, thismenu, add, (&O).A整理, :AeManage
	dirMenu0=%A_ScriptDir%\custom\ae_scripts\Effect
	dirMenu1=%A_ScriptDir%\custom\ae_scripts\otherScriptCommand\
	dirMenu2=%A_ScriptDir%\custom\ae_scripts\PresetAnimation

	menu_fromfiles("filelist0", "特效库", "RunAePreset0", dirMenu0, "*.ffx", "thismenu", 1)
	menu_fromfiles("filelist1", "脚本库", "RunAeScript", dirMenu1, "*.jsx", "thismenu", 1)
	menu_fromfiles("filelist2", "预设", "RunAePreset1", dirMenu2, "*.ffx", "thismenu", 1)

	menu, thismenu, add, .整理项目&清理缓存,<Ae_OrganizeProjectAssetsDiskCache>
	menu, thismenu, add, .清除时间轴中未使用的素材图层,<Ae_ReduceNoFootage>
	menu, thismenu, add, .精简项目,<Ae_ReduceProject>
	menu, thismenu, add, .文件所在位置, OpenLocalFiles
	menu, thismenu, add, .文件所在位置【渲染】, OpenLocalFilesRender

   Menu, thismenu, Show
return

WHATSUP:
    msgbox, 特效库目录 `n`n %dirMenu0% `n`n 脚本库目录 `n`n %dirMenu1% `n`n 预设目录 `n`n %dirMenu2%
RETURN
OpenLocalFiles:
{
    If ProcessExist("TOTALCMD.exe"){

        getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFliesTC.jsx")

    }else{

	    getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")

    }
	return
}

OpenLocalFilesRender:
{
	AeOpenLocalFilesRender()
	return
}

RunAeScript:
    curpath := menu_itempath("filelist1", dirMenu1)
	WinActivate, ahk_exe AfterFX.exe
    global AeExePath := ini.BOBOPath_Config.AEPath
    RunWait, %AeExePath% -s -r %curpath%,,Hide
    return
RETURN
; AE预设库initialization
RunAePreset0:
{
    curpath := menu_itempath("filelist0", dirMenu0)
	setPath:=StrReplace(curpath,"\", "/")
    setPreset=%dirMenu0%\setPreset.jsx

    FileDelete, %setPreset% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
var	myPreset=File("%setPath%")
var activeItem = app.project.activeItem;
if (activeItem instanceof CompItem) {
    var selectedLayers = activeItem.selectedLayers;
    var numSelectedLayers = selectedLayers.length;
    if (numSelectedLayers >= 1) {
        for (var i = 0; i < numSelectedLayers; i += 1) {
          var layer = app.project.activeItem.selectedLayers[0];
          layer.applyPreset(myPreset);
        }
    } else {
        alert("请选择一个或多个图层.", "BoBO提示你");
    }
}
    ), %dirMenu0%\setPreset.jsx,UTF-8

	sleep 50
	WinActivate, ahk_exe AfterFX.exe
	global AeExePath := ini.BOBOPath_Config.AEPath
    RunWait, %AeExePath% -s -r %setPreset%,,Hide
	sleep 50
	FileDelete, %setPreset% ;避免重复删除文件
    return
}

RunAePreset1:
{
   curpath := menu_itempath("filelist2", dirMenu2)
	setPath:=StrReplace(curpath,"\", "/")
   setPreset=%dirMenu2%\setPreset.jsx

    FileDelete, %setPreset% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
var	myPreset=File("%setPath%")
var activeItem = app.project.activeItem;
if (activeItem instanceof CompItem) {
    var selectedLayers = activeItem.selectedLayers;
    var numSelectedLayers = selectedLayers.length;
    if (numSelectedLayers >= 1) {
        for (var i = 0; i < numSelectedLayers; i += 1) {
          var layer = app.project.activeItem.selectedLayers[0];
          layer.applyPreset(myPreset);
        }
    } else {
        alert("请选择一个或多个图层.", "BoBO提示你");
    }
}
    ), %dirMenu2%\setPreset.jsx,UTF-8

	sleep 50
	WinActivate, ahk_exe AfterFX.exe
	global AeExePath := ini.BOBOPath_Config.AEPath
    RunWait, %AeExePath% -s -r %setPreset%,,Hide
	sleep 50
	FileDelete, %setPreset% ;避免重复删除文件
    return
}
RETURN

AeOpenLocalFilesRender()
{
    If ProcessExist("TOTALCMD.exe"){
        getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFilesRenderTC.jsx")
		return
    }else{
        getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFilesRender.jsx")
		sleep,1000
		SendInput,{Enter}
		return
    }
}