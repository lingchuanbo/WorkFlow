;=========================================================
;最后修改于2020-03-25
;BoBO
;=========================================================
function_menuAfterEffect:

#If WinActive("ahk_exe AfterFX.exe")
{
    ; ~LButton & RButton::send,^w
    F1::Gosub,Ae_pluginTools
     ;;AE快速打开文件所在位置 至于是否启用TC到时候在考虑目前可以一直按alt+w
     ; !w::getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
    ;  ^+!LButton::getAeScript("custom\ae_scripts\commands\BoBO_OpenLocalFlies.jsx")
     ;;便捷菜单
    +RButton::Gosub,menuAe
    !RButton::Gosub,menuAeAltExpressions
    LButton & Alt::Gosub,AeAltLButton

    ; Alt::
	; 	GV_KeyClickAction1 := "Gosub,menuAe"
	; 	GV_KeyClickAction2 := "send,+{F3}"
	; 	GoSub,Sub_KeyClick
    ; return
    Alt::
        GV_KeyClickAction1 := "GoSub,menuAe"
        GV_KeyClickAction2 := "GoSub,menuAeAlt"
        GoSub,Sub_KeyClick
    return	


    ; 1::
	; 	GV_KeyClickAction1 := "Gosub,<Ae_Double_[>"
	; 	GV_KeyClickAction2 := "Gosub,<Ae_SplitLayer>"
	; 	GoSub,Sub_KeyClick
	; return	

    ; 2::
	; 	GV_KeyClickAction1 := "Gosub,<Ae_Double_]>"
	; 	GV_KeyClickAction2 := "send,+{F3}"
	; 	GoSub,Sub_KeyClick
    ; return
    ; 3::send,{RButton}

; 截取工作台
    ` & 1::send,{b}
    ` & 2::send,{n}
    ` & 3::send, ^+x

    ; `::
    ; 	GV_KeyClickAction1 := "Gosub,<Ae_QuickMenu>"
	; 	GV_KeyClickAction2 := "Send,{~`}"
	; 	GoSub,Sub_KeyClick
    ; return
    ; Alt & `::send,{`}
}


Ae_pluginTools:
    GroupAdd,AfterEffects,ahk_exe AfterFX.exe
    GroupAdd,AfterEffects,ahk_class %tClass% 
    WinActivate,ahk_group AfterEffects
    MouseGetPos, MX, MY
    MouseX:=MX-325
    MouseY:=MY-150 
    Gui,Ae: Show,X%MouseX% Y%MouseY% ,NoActivate ; 
    ;保存当前信息
    KeyWait,F1
    Sleep, 20                                                                                              
    IfWinActive, ahk_class AutoHotkeyGUI
    { 
        Click down 
        Sleep, 20  
        Click up
        Sleep, 20                 
        Gui,Ae: Hide
        sleep 200
        Click 1
    }
return


AeAltLButton:
    Menu, AeAltLButton, add, (&D) 克隆合成组, CompDuplicator
    Menu, AeAltLButton, add, (&R) 批量重命名, BatchRename
    Menu, AeAltLButton, add, (&R) 精简项目,<Ae_ReduceProject>
    Menu, AeAltLButton, add, (&P) 项目清理,<Ae_ProjectCleaner>
    ; Menu, menuAlt, add, (&R) 批量替换素材, BatchReplaceFile
    ; Menu, menuAlt, add, (&R) 批量重命名, BatchRename
    ; Menu, menuAlt, add, (&R) 批量渲染, :ManageRender
    ;     Menu, ManageRender, add, %_AeRENDER%,RENDER
    ;     Menu, ManageRender, add, %_AeNameRENDER%,NameRENDER
    ;     Menu, ManageRender, add, %_AeNameDirection%,NameDirection
    ;     Menu, ManageRender, add, %_AeName%, Name
    Menu, AeAltLButton, Show
return

menuAeAlt:
    Menu, menuAlt, add, (&R) 批量导入素材, ImmigrationREG
    Menu, menuAlt, add, (&R) 批量替换素材, BatchReplaceFile
    Menu, menuAlt, add, (&R) 批量重命名, BatchRename
    Menu, menuAlt, add, (&R) 批量渲染, :ManageRender
        Menu, ManageRender, add, %_AeRENDER%,RENDER
        Menu, ManageRender, add, %_AeNameRENDER%,NameRENDER
        Menu, ManageRender, add, %_AeNameDirection%,NameDirection
        Menu, ManageRender, add, %_AeName%, Name
    Menu, menuAlt, Show
return

menuAeAltExpressions:
	; menu, menuAltExpressions, add, AE动态脚本菜单(%_Author%), WHATSUP
    dirMenu3=%A_ScriptDir%\custom\ae_scripts\Expression
    menu_fromfiles("filelist3", "表达式", "Expression", dirMenu3, "*.txt", "menuAltExpressions", 1)

    Menu, menuAltExpressions, add, (&R) 表达式库, iExpressions
    Menu, menuAltExpressions, add, (&R) 表达式修复, ExpressionUniversalizer
    Menu, menuAltExpressions, Show
return

iExpressions:
getAeScript("custom\ae_scripts\Expression\iExpressions3.jsxbin")
return
ExpressionUniversalizer:
getAeScript("custom\ae_scripts\Expression\ExpressionUniversalizer.jsxbin")
return


menuAe:
    ; Click 1
	menu, thismenu, add, MenuPlus 2021.0, WHATSUP
	; menu, thismenu, add, (&O).A整理, :AeManage
	dirMenu0=%A_ScriptDir%\custom\ae_scripts\Effect
	dirMenu1=%A_ScriptDir%\custom\ae_scripts\otherScript
	dirMenu2=%A_ScriptDir%\custom\ae_scripts\Preset
    dirMenu3=%A_ScriptDir%\custom\ae_scripts\Expression

	menu_fromfiles("filelist0", "&E Effects", "RunAePreset0", dirMenu0, "*.ffx", "thismenu", 1)
	menu_fromfiles("filelist1", "&S Scripts", "RunAeScript", dirMenu1, "*.jsx|*.jsxbin", "thismenu", 1)
	menu_fromfiles("filelist2", "&P Presets", "RunAePreset1", dirMenu2, "*.ffx", "thismenu", 1)
    menu_fromfiles("filelist3", "&X Expression", "Expression", dirMenu3, "*.txt", "thismenu", 1)

	menu, thismenu, add, .整理项目&清理缓存,<Ae_OrganizeProjectAssetsDiskCache>
	menu, thismenu, add, .清除时间轴中未使用的素材图层,<Ae_ReduceNoFootage>
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
	; WinActivate, ahk_exe AfterFX.exe
    ; global AeExePath := ini.BOBOPath_Config.AEPath
    global AeExePath := GetProcessPath()
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
	; WinActivate, ahk_exe AfterFX.exe
	global AeExePath := GetProcessPath()
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
	; WinActivate, ahk_exe AfterFX.exe
	global AeExePath := GetProcessPath()
    RunWait, %AeExePath% -s -r %setPreset%,,Hide
	sleep 50
	FileDelete, %setPreset% ;避免重复删除文件
    return
}
RETURN

Expression:
{
   curpath := menu_itempath("filelist3", dirMenu3)
  setPath:=StrReplace(curpath,"\", "/")
   setPreset=%dirMenu3%\setPreset.jsx
   AeLibPath=%A_ScriptDir%\custom\ae_scripts\commands\lib

   setAeLibPath:=StrReplace(AeLibPath,"\", "/")

   AeInclude_UIParser=#include '%setAeLibPath%/UIParser.jsx'
   AeInclude_Tree=#include '%setAeLibPath%/Tree.jsx'
;    MsgBox %AeInclude_UIParser%
    FileDelete, %setPreset% ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
;(function(Global) {
%AeInclude_UIParser%
%AeInclude_Tree%
var _ = UIParser(Global);
var	Expression=File("%setPath%")
Expression.open();
var myExpression = Expression.read();
Expression.close();

var sl = _.project.getSelectedLayers();
if(sl) {
    for(var i = 0; i < sl.length; i++){
 		var mySelectedProperty = sl[i].selectedProperties;
 		for(var j = 0; j < mySelectedProperty.length; j++){
 			try {
 				mySelectedProperty[j].expression = myExpression;
 			}catch(err){}
 		}
 	}
}
})(this);
    ), %dirMenu3%\setPreset.jsx,UTF-8

	sleep 50
	; WinActivate, ahk_exe AfterFX.exe
	; global AeExePath := ini.BOBOPath_Config.AEPath
    AeExePath := GetProcessPath()
    RunWait, %AeExePath% -s -r %setPreset%,,Hide
	sleep 50
	FileDelete, %setPreset% ;避免重复删除文件
    return
}
RETURN

PluginsReg:
{
   setCommandPath=%A_ScriptDir%\custom\ae_scripts\commands
   AeLibPath=%A_ScriptDir%\custom\ae_scripts\commands\lib
   setAeLibPath:=StrReplace(AeLibPath,"\", "/")
   setCommandPaths:=StrReplace(setCommandPath,"\", "/")

   AeInclude_UIParser=#include '%setAeLibPath%/UIParser.jsx'
   AeInclude_Tree=#include '%setAeLibPath%/Tree.jsx'
;    MsgBox %AeInclude_UIParser%
    FileDelete, %setCommandPath%\PluginsReg.jsx ;避免重复删除文件
    FileAppend,  ; 这里需要逗号.
    (
(function(Global) {
%AeInclude_UIParser%
%AeInclude_Tree%
var _ = UIParser(Global);
var subUIJson = {
 	// 帮助
 	helpUI: {
 		group: {type:'group', orientation:'column', align:'fill', children:{
 			picture: {type:'image', align:'top', label:'picture'},
 			help_box: {type:'edittext', align:'fill', properties:{multiline:1, readonly:1}},
 		}}
 	}
 }

var fns = {
 	createWin: function(title, json, exec, finalexec) {
 		var newWin = new Window('palette', title, undefined, {resizeable: true});
 		_(newWin).addUI(json);
 		_(newWin).layout();
 		_(newWin).find('*').layout();
 		exec(newWin);
 		_.window.resize(newWin);
 		if(finalexec) finalexec(newWin);
 		if(newWin.size[0] < 300) newWin.size[0] = 300;
 		newWin.show();
 		return newWin;
 	},
 };

var helpFile = File("%setCommandPaths%/PluginsReg.txt");
if(helpFile.exists) var helpStr = _.file.read(File("%setCommandPaths%/PluginsReg.txt"));
else helpStr = 'Null';
//alert(helpStr);
fns.createWin('常用注册信息 By.BoBO', subUIJson.helpUI, function(e) {
     try{
     var win = e;
     var pic = _(win).find('#picture')[0];
     var help = _(win).find('#help_box')[0];
    //setImage(pic, pic.label);
     help.text = helpStr;
     }catch(err){alert(err)}
 });
})(this);
    ), %setCommandPath%\PluginsReg.jsx,UTF-8
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