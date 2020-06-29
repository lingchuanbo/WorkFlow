;最后修改于2020-4-3
;BoBO
;定义一些路径需要配置初始化设置
;=========================================================
function_Initialization:

Ps_Init_TotalCMD:
{
    StrTCExePath:=StrReplace(TCExePath,"\","\\")
    getPath = %A_ScriptDir%\custom\ps_script\TC显示位置.jsx
    FileDelete, %getPath% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
20200403
@author: BoBO
人生苦短我用Python,此文件为自动生成,可能会被还原!
"""
import os, re
import sys
import ctypes

from win32com.client import Dispatch, GetActiveObject, GetObject

try:
    app = GetActiveObject("Photoshop.Application")
    Path = app.activeDocument.path
except:
    ctypes.windll.user32.MessageBoxA(0,u"请先保存文件 !!! .^_ ^".encode('gb2312'),u' BoBO'.encode('gb2312'),0)
    print("文件没保存!")
else:
    command ="%StrTCExePath% /O /S /L=" + Path
    os.system(command)
}
    ), %getPath%,UTF-8
}

Ps_Init_Ae:
{
    StrAeExePath:=StrReplace(AeExePath,"\","\\")
    getPath = %A_ScriptDir%\custom\ps_script\openAE.py
    FileDelete, %getPath% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
20200403
@author: BoBO
人生苦短我用Python,此文件为自动生成,可能会被还原!
"""
import os, re
import sys
import ctypes

from win32com.client import Dispatch, GetActiveObject, GetObject

try:
    app = GetActiveObject("Photoshop.Application")
    Path = app.activeDocument.path
    Name = app.activeDocument.name
except:
    ctypes.windll.user32.MessageBoxA(0,u"请先保存文件 !!! .^_ ^".encode('gb2312'),u' BoBO'.encode('gb2312'),0)
    print("文件没保存!")
else:
    command =r'"%StrAeExePath%"'+" "+ Path + Name
    os.system(command)
    ), %getPath%,UTF-8
}


AE_Init_OpenLocalFliesTC:
{
    getTCExePath=%A_ScriptDir%\tools\TotalCMD\TOTALCMD.EXE
    StrTCExePath:=StrReplace(getTCExePath,"\","\\")
    getPath = %A_ScriptDir%\custom\ae_scripts\commands\BoBO_OpenLocalFliesTC.jsx
    FileDelete, %getPath% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
//初始化文件,可能会被覆盖!
function revealFile(filePath) {
	if ( filePath instanceof File ) {
		filePath = filePath.fsName;
	}
	var command = "open -R";
	if ($.os.indexOf("Win") != -1) {
		command = "%StrTCExePath% /O /T /R=";
	}
	arg = "\"" + filePath + "\"";
	return system.callSystem(command + " " + arg);
}

if(app.project.file !== null){
    var path=app.project['file'];
    revealFile(path);
}else{
    alert("文件未保存，请先保存文件！")
}
    ), %getPath%,UTF-8
}


AE_Init_OpenLocalFilesRenderTC:
{
    getTCExePath=%A_ScriptDir%\tools\TotalCMD\TOTALCMD.EXE
    StrTCExePath:=StrReplace(getTCExePath,"\","\\")
    getPath = %A_ScriptDir%\custom\ae_scripts\commands\BoBO_OpenLocalFilesRenderTC.jsx
    FileDelete, %getPath% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
//初始化文件,可能会被覆盖!
var myProject = app.project;
var myNumItemsIndex = myProject.renderQueue.numItems;
if (myNumItemsIndex >= 1) {
    var myRQItem = myProject.renderQueue.item(myNumItemsIndex);
    var myRQFile = myRQItem.outputModule(1).file;
    var myFileName = myProject.file.name;
    var str=decodeURI(myRQFile);
    var getAllDir=str.replace(/\//g,"\\"); 
    var getDir=getAllDir.substr(1,1);
    var getDirPath=getAllDir.substring(2);
    var Dir=getDir + ':' + getDirPath
    system.callSystem("%StrTCExePath% /O /T /R=" + Dir);
}else{
    alert("当前无渲染文件！")
}
    ), %getPath%,UTF-8
}

AE_Init_RevealInFinderTC:
{
    getTCExePath=%A_ScriptDir%\tools\TotalCMD\TOTALCMD.EXE
    StrTCExePath:=StrReplace(getTCExePath,"\","\\")
    getPath = %A_ScriptDir%\custom\ae_scripts\commands\RevealInFinderTC.jsx
    FileDelete, %getPath% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
//初始化文件,可能会被覆盖!
var arif_globals = {
    scriptName: "Reveal in Finder",
    scriptVersion: "1.0",
    strErrScriptAccess: "This script requires access to write files.\nGo to the \"General\" panel of the application preferences and make sure \"Allow Scripts to Write Files and Access Network\" is checked."
};
Ae_RevealInFinder();

function Ae_RevealInFinder() {
    if (!isSecurityPrefSet()) {
        alert(arif_globals.strErrScriptAccess);
        app.executeCommand(2359);
        if (!isSecurityPrefSet()) {
            return;
        }
    }
    app.beginUndoGroup(arif_globals.scriptName);
    var myComp = app.project.activeItem;
    if (myComp == null) {
        return;
    }
    if (myComp instanceof CompItem && myComp.selectedLayers.length != 1) {
        alert("Please select only 1 layer");
        return;
    }
    if (myComp instanceof CompItem) {
        var myLayer = myComp.selectedLayers[0];
        if (myLayer.source == null || myLayer.source.file == null) {
            alert("The selected layer does not have a source in the Finder");
            return;
        }
        myLayer = myLayer.source.file;
    }
    if (myComp instanceof FootageItem) {
        var myLayer = myComp.file;
        if (myLayer == null) {
            alert("The selected item does not have a source in the Finder");
            return;
        }
    }
    if ($.os.indexOf("Mac") != -1) {
        system.callSystem("open -a Finder \"" + myLayer.parent.fsName + "\"");
        if (myLayer.fsName.match(/'/) == null) {
            var revealAppleScript = "osascript -e 'tell application \"Finder\" to select POSIX file \"" + myLayer.fsName + "\"'";
            system.callSystem(revealAppleScript);
        }
    } else {

            system.callSystem("%StrTCExePath% /O /S /L=" + myLayer.fsName + "\"" );
    }

    function isSecurityPrefSet() {
        var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
        return securitySetting == 1;
    }
}
    ), %getPath%,UTF-8
}
