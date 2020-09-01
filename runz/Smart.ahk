#NoEnv
#Persistent
#SingleInstance FORCE
#NoTrayIcon
SendMode Input
SetWorkingDir %A_WorkingDir%
SetBatchLines -1
ListLines Off
DetectHiddenWindows, on

global old_id
global g_version="1.4.0 Build200503"
global g_hicon
global g_config:=A_WorkingDir . "\configSmart.ini"

IfNotExist, %g_config%
{
    filecopy, %A_WorkingDir%\configSmart.firstrun , %A_WorkingDir%\configSmart.ini
}

global g_hotstringexec:=Object()
global g_hotstringtext:=Object()
global g_window_title :="PD "
global ar_folder_change
global ar
global exar
global appar
global appar2
global appar_temp
global appar_temp2
global apps_1st_folder_num
global g_apps_menuname:="程序"
global g_apps_submenu_iconname:=A_WinDir . "\System32\imageres.dll"
global g_apps_submenu_iconindex:="-87"
global g_pdres_icon:=A_WorkingDir . "\pdres.dll"
global lisetview_fullpath_temp2
global lisetview_fullpath_temp3

IniRead , g_menuiconsize , %g_config% , general , menuiconsize
    if ( g_menuiconsize = "ERROR") or ( g_menuiconsize = "")
    {
    g_menuiconsize:=24
    }

global g_hotstringext

IniRead , g_hotstringext , %g_config% , general , hotstringext
    if ( g_hotstringext = "ERROR") or ( g_hotstringext = "")
    {
    g_hotstringext:="+"
    }
global ev_res :=Object()
global ev_count
global ev_EXE
global ev_DLL
global ev_find_str
global g_maxsearchitems

IniRead , g_maxsearchitems , %g_config% , general , maxsearchitems

if (g_maxsearchitems = "ERROR" ) or   (g_maxsearchitems = "" )
{
g_maxsearchitems:="1000"
}

IniRead , ev_EXE , %g_config% , general , everythingexe
IniRead , ev_DLL , %g_config% , general , everythingdll
if (ev_EXE = "ERROR" )  or   (ev_EXE = "" )
{
IfExist, %A_WorkingDir%\tools\TotalCMD\Everything.exe
{
ev_EXE:= A_WorkingDir . "\tools\TotalCMD\Everything.exe"
}
IfNotExist, %A_WorkingDir%\tools\TotalCMD\Everything.exe
{
    msgbox, % "没有找到ev\Everything.exe文件，`n`n请修改config.ini设置后刷新！"
    EmptyMem()
return
}
}
else
{
IfNotExist,% ev_exe
{
    msgbox, % "设置中的everything.exe文件不存在，`n`n`请修改config.ini设置后刷新！"
    EmptyMem()
    return
}
}
if (ev_DLL = "ERROR" ) or   (ev_DLL = "" )
{
    IfExist, %A_WorkingDir%\tools\TotalCMD\everything64.dll
{
    ev_DLL:= A_WorkingDir . "\tools\TotalCMD\everything64.dll"
}
IfNotExist, %A_WorkingDir%\tools\TotalCMD\everything64.dll
    {
        msgbox, % "没有找到ev\everything64.dll文件， `n`n请修改config.ini设置后刷新！"
        EmptyMem()
        return
    }
}else{
    IfNotExist,% ev_dll
    {
        msgbox, % "设置中的everything64.dll文件不存在，`n`n`请修改config.ini设置后刷新！"
        EmptyMem()
        return
    }
}

errorlevel:=0

run, % ev_EXE . " -close" ,,UseErrorLevel

if errorlevel
{
    msgbox, % "everything文件运行有错误，`n`n`请检查后采用服务或者管理员模式运行；"
    EmptyMem()
    return
}
IniRead , g_allow_mbutton , %g_config% , general , allow_mbutton
IniRead , g_allow_apps_menu , %g_config% , general , allow_apps_menu
IniRead , g_allow_apps_submenu , %g_config% , general , allow_apps_submenu
IniRead , g_trayicon_temp_a , %g_config% , general , trayicontype
if (g_trayicon_temp_a = "black")
{
    g_trayicon_index:=4
}
else
{
    g_trayicon_index:=5
}
global g_hostfile:=A_WinDir . "\system32\drivers\etc\hosts"
global g_cmd_error_tip:="未找到匹配结果，请检查后重新输入"
global g_hotkeyname
IniRead , g_hotkeyname , %g_config% , general , hotkeyname
if (g_hotkeyname = "ERROR" ) or   (g_hotkeyname = "" )
{
g_hotkeyname:="~ALT"
}
Hotkey, % g_hotkeyname, mainrunwindow, on
global g_windowfontcolor
IniRead , g_windowfontcolor , %g_config% , general , windowfontcolor
if (g_windowfontcolor = "ERROR" ) or   (g_windowfontcolor = "" )
g_windowfontcolor:=0xEAEAEA
global g_windowbgcolor
IniRead , g_windowbgcolor , %g_config% , general , windowbgcolor
if (g_windowbgcolor = "ERROR" ) or   (g_windowbgcolor = "" )
g_windowbgcolor:=494949
global g_controlbgcolor
IniRead , g_controlbgcolor , %g_config% , general , controlbgcolor
if (g_controlbgcolor = "ERROR" ) or   (g_controlbgcolor = "" )
g_controlbgcolor:=696969
global g_errortipscolor
IniRead , g_errortipscolor , %g_config% , general , errortipscolor
if (g_errortipscolor = "ERROR" ) or   (g_errortipscolor = "" )
g_errortipscolor:=666666
global g_searchdef_path
IniRead , g_searchdef_path , %g_config% , general , searchdef_path
if (g_searchdef_path = "ERROR" ) or   (searchdef_path = "" )
searchdef_path:=""
global g_searchdef_ext
IniRead , g_searchdef_ext , %g_config% , general , searchdef_ext
if (g_searchdef_ext = "ERROR" ) or   (g_searchdef_ext = "" )
g_searchdef_ext:="exe"
global result
global g_realsearchon
IniRead , g_realsearchon , %g_config% , general , realsearchon
if (g_realsearchon = "ERROR" ) or   (g_realsearchon = "" )
g_realsearchon:="0"
Menu, tray, UseErrorLevel
Menu, tray, NoStandard
Menu, tray, icon
menu, tray, icon, %g_pdres_icon% , %g_trayicon_index%
menu, tray, add, 关于PD, aboutpd
menu, tray, add, 重新载入PD, reloadme
menu, tray, add, 运行窗口, mainrunwindow
Menu, Tray, add, 退出PD, exit1
Menu, tray, default, 关于PD
menu, tray, tip, % g_window_title  . g_version
gui, 30:+Owner -Caption +AlwaysOnTop
gui, 30:color, 353535
GUI, 30:add, picture, x20 y40 w96 h96 icon3, % g_pdres_icon
GUI, 30:font , s14 Q5 W700 Bold cEEEEEE , Microsoft Yahei
GUI, 30:add, text,xp+150 yp-10, % "About"
GUI, 30:font , s9 Q5 W400 Normal c999999, Microsoft Yahei
GUI, 30:add, text,xp+0 yp+20 BackgroundTrans, %  "———————"
GUI, 30:add, text,xp+20 yp+20, % "❶  软件名称：PD_x64`n"
. "❷  版本：Ver " . g_version . "`n"
. "❸  类型：一个快速启动及文件查找工具，采用AHK 1.132 编写`n"
. "❹  作者：ilaoyao ( ilaoyao@163.com )`n"
GUI, 30:font , s14 Q5 W700 Bold cEEEEEE, Microsoft Yahei
GUI, 30:add, text,xp-20 yp+80, % "Tips"
GUI, 30:font , s9 Q5 W400 Normal c999999, Microsoft Yahei
GUI, 30:add, text,xp+0 yp+20 BackgroundTrans, %  "——————"
GUI, 30:add, text,xp+20 yp+20, % "❶  配置采用 config.ini 文件手动配置`n"
. "❷  双击 ALT 热键，输入命令或自定义命令。鼠标中键弹出菜单`n"
. "❸  f 关键词可以实时搜索（调用Everything，默认实时为关闭）`n"
. "❹  软件自带内置命令，另见操作手册PDF文件"
GUI, 30:font , s14 Q5 W700 Bold cEEEEEE, Microsoft Yahei
GUI, 30:add, text,xp-20 yp+80, % "Donate"
GUI, 30:font , s9 Q5 W400 Normal c999999, Microsoft Yahei
GUI, 30:add, text,xp+0 yp+20 BackgroundTrans, %  "——————"
GUI, 30:add, text,xp+20 yp+20, % "❶  本软件是免费软件，无内置广告或间谍代码`n"
. "❷  如果觉得本软件对您有帮助，欢迎扫左侧二维码捐赠作者，金额随意    `n"
. "❸  捐赠自愿，捐赠与否不产生任何义务和权利。捐赠后请截图邮`n     件告知，我将您添加到致谢名单中。`n`n"
GUI, 30:add, text, x35 y275 w80 h80 c555555 center BackgroundTrans, % "请勿删除捐赠二维码图片."
GUI, 30:add, picture, x30 y250 w100 h-1 icon2, % g_pdres_icon
GUI, 30:add, text, x30  y160 w80 h18 ReadOnly BackgroundTrans center Border c00FFFF  gthanks, % "致谢名单"
GUI, 30:font , s16 Q5 W300 normal c999999, wingdings
GUI, 30:add, text, x540 y20 w26 h26 +Background353535 center -Border center c999999 gcloseabout, % "x"
EmptyMem()
return
runhotstring_text:
loop , % g_hotstringtext._maxindex()
{
if (a_thishotkey = g_hotstringtext[a_index,1])
{
Clipboard:=g_hotstringtext[a_index,2]
send ^v
EmptyMem()
break
return
}
}
return
changetosearchfile:
if ( g_realsearchon <> "1" )
{
GuiControl, 10:-g, edit1
}
ControlGetText, myinput1 , edit1
StringLower, myinput_temp, myinput1
ControlGetText, text_temp1, static1
if (text_temp1 = g_cmd_error_tip )
{
ControlSetText, static1, % ""
}
if (substr(myinput_temp,1,2) = "f ")
{
if (myinput_temp="f ")
{
GuiControl, 10:hide, SysListView321
GuiControl, 10:Hide, static3
GuiControl, 10:Hide, static2
gui,10:show, w670 h65
}
str2:=substr(myinput_temp,3)
ev_count:=0
Gui, 10:default
LV_Delete()
if (str2 = "")
{
GuiControl, 10:hide, SysListView321
GuiControl, 10:Hide, static2
GuiControl, 10:hide, static3
gui,10:show, w670 h65
EmptyMem()
return
}
exeQuery(str2)
if (ev_count > g_maxsearchitems ) or (ev_count = 0 )
{
GuiControl, 10:hide, SysListView321
GuiControl, 10:Hide, static2
GuiControl, 10:hide, static3
gui,10:show, w670 h65
EmptyMem()
return
}
GuiControl, 10:-Redraw , SysListView321
ev_ImageListID := IL_Create(ev_count)
LV_SetImageList(ev_ImageListID)
loop % ev_count
{
file_temp_result:= ev_res[a_index,2] . "\" . ev_res[a_index,1]
get_file_icon(file_temp_result)
IL_Add(ev_ImageListID, g_hicon)
LV_Add("Icon" . a_index, ev_res[A_index,1] ,  ev_res[A_index,2])
LV_ModifyCol(1,350)
}
guicontrol, 10:hide, static3
GuiControl, 10:+Redraw, SysListView321
GuiControl, 10:show, SysListView321
ControlSetText, static2 , % "  共搜索到 " . ev_count . "个项目。"
GuiControl, 10:show, static2
gui,10:show, w670 h430
EmptyMem()
return
}
else if (myinput1="")
{
GuiControl, 10:hide, SysListView321
GuiControl, 10:Hide, static2
GuiControl, 10:Hide, static3
gui,10:show, w670 h65
EmptyMem()
return
}
EmptyMem()
return
closeabout:
winhide, % "about PD"
EmptyMem()
return
thanks:
run, http://x.ilaoyao.cn:88/?id=120
EmptyMem()
return
startgui:
IfWinExist, % g_window_title
{
WinShow, % g_window_title
WinActivate,  % g_window_title
ControlFocus, edit1, % g_window_title
EmptyMem()
return
}
else
{
gui ,10:  +LastFound +ToolWindow +AlwaysOnTop +Border -caption
Gui, 10:Color, %g_windowbgcolor%, %g_controlbgcolor%
GUI, 10:font , s20 Q5 W700 c%g_windowfontcolor%, Microsoft Yahei
GUI, 10:Add ,edit, x10 y10 W650 H45 center  -WantReturn  gchangetosearchfile
GUI, 10:Add, text, x10 y18 w650 h35 center BackgroundTrans c%g_windowfontcolor% , % ""
gui, 10:font, s9 w400 Normal, Microsoft Yahei
gui, 10:add,listview, r8 X10 Y54 w650 h350 +hdr Hidden  c%g_windowfontcolor% -Multi AltSubmit grunlistview count500, 文件名称|文件路径
gui, 10:add, text, r1 XP yp+354 w650 h30  c%g_windowfontcolor% hidden ,  % "搜索结果"
GUI, 10:Add ,text, x10 y54 W650 H385  hidden   -VScroll
Gui, 10:Add, button,w0 h0 default grunme
Gui, 10:default
startpos_x:=(A_ScreenWidth-650)/2
startpos_y:=(A_Screenheight)/4
Gui, 10:show, xcenter y%startpos_y% w670 h65 ,% g_window_title
hotkey, esc, on
SetTimer, closeme, 250
EmptyMem()
return
}
closeme:
IfWinNotActive, % g_window_title
{
SetTimer, closeme, off
gui,10:hide
EmptyMem()
}
return
runlistview:
if A_GuiEvent = DoubleClick
{
LV_GetText(pathname1, A_EventInfo, 2)
LV_GetText(filename1, A_EventInfo, 1)
gui, destroy
Run, % pathname1 . "\" . filename1 ,, UseErrorLevel
}
else if A_GuiEvent = RightClick
{
LV_GetText(pathname2, A_EventInfo, 2)
LV_GetText(filename2, A_EventInfo, 1)
lisetview_fullpath_temp2 := pathname2 . "\" . filename2
lisetview_fullpath_temp3 := filename2
MouseGetPos,X_TEMP,Y_TEMP
menu, list_menu, add, 打开文件, g001
menu, list_menu, add, 在资源管理器中定位, g001
menu, list_menu, add, 复制全路径, g001
menu, list_menu, add, 复制文件到桌面, g001
menu, list_menu, show , %X_TEMP%, %Y_TEMP%
}
else if A_GuiEvent = normal
{
LV_GetText(filename2, A_EventInfo, 1)
tooltip, % filename2
SetTimer, RemoveToolTip, 3000
}
else if A_GuiEvent = f
{
tooltip
}
EmptyMem()
return
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
g001:
if (a_thismenuitem= "打开文件")
{
GUI ,10:DESTROY
winhide, % g_window_s_title
Run, % lisetview_fullpath_temp2 ,, UseErrorLevel
}
else if (a_thismenuitem= "在资源管理器中定位")
{
GUI ,10:DESTROY
winhide, % g_window_s_title
Run, % "explorer.exe /select`," . lisetview_fullpath_temp2 ,, UseErrorLevel
}
else if (a_thismenuitem= "复制全路径")
{
clipboard :=
clipboard := % lisetview_fullpath_temp2
}
else if (a_thismenuitem= "复制文件到桌面")
{
random, rand1, 1000, 9999
random, , newseed
filecopy, % lisetview_fullpath_temp2 , % A_Desktop . "\" . rand1 . "_" . lisetview_fullpath_temp3
}
EmptyMem()
return
aboutpd:
F1::
hotkey,esc,on
Gui,30:show, autosize center, % "about PD"
WinGetPos, , , w_temp, h_temp, % "about PD"
winset, Region, 0-0 w%w_temp% h%h_temp% R15-15 , % "about PD"
gui,10:Destroy
EmptyMem()
return
exit1:
Process, Exist, ahk_pd.exe
isExistpdahk := ErrorLevel
If ( isExistpdahk > 0 )
{
runwait, cmd.exe /c taskkill /f /IM ahk_pd.exe, , Hide
FileDelete, % g_ahktmpfile
}
exitapp
return
appsmenu:
read_section("s_cmdstr")
Appar:= Object()
appar_temp:=Object()
posnum:=0
Appar2:= Object()
appar_temp2:=Object()
posnum2:=0
s_appscount:=1
while(s_appscount <= ar._maxindex())
{
s_appscount +=1
if (ar[a_index,1]="X")
{
menu, quickmenu , add
posnum2 +=1
appar_temp2[posnum2]:=A_index-posnum2
}
else
{
StringSplit, apps_menu_temp_a, % ar[a_index,2], "|"
appar2[a_index,1]:=apps_menu_temp_a1
if (apps_menu_temp_a2 ="") or (apps_menu_temp_a2="ERROR")
{
appar2[a_index,2]:=ar[a_index,1]
}
else
{
appar2[a_index,2]:=apps_menu_temp_a2
}
if (apps_menu_temp_a3 = "1" )
{
if (apps_menu_temp_a4 = "0")
{
menu, quickmenu , add, % appar2[a_index,2], run_apps_menu_1st
menu, quickmenu , icon, % appar2[a_index,2], % g_apps_iconname , % g_apps_iconindex, %  g_menuiconsize
}
else
{
get_file_icon(appar2[a_index,1])
menu, quickmenu , add, % appar2[a_index,2], run_apps_menu_1st
menu, quickmenu , icon, % appar2[a_index,2], % g_hicon,, %  g_menuiconsize
}
posnum2 +=1
appar_temp2[posnum2]:=A_index-posnum2
}
}
}
EmptyMem()
return
run_apps_menu_1st:
pos1:=appar_temp2[A_ThisMenuItemPos - apps_1st_folder_num ] + A_ThisMenuItemPos - apps_1st_folder_num
appspath:=appar2[pos1,1]
run, %appspath% ,,UseErrorLevel
EmptyMem()
return
~MButton::
read_section("excludeapp")
s_exappcount:=1
WHILE (s_exappcount <= ar._maxindex() )
{
s_exappcount+=1
if winactive("ahk_exe" . ar[a_index,2])
{
EmptyMem()
return
}
}
if (g_allow_mbutton = "1")
{
gosub, gui1exit
ar_folder_change:= Object()
recnum1 :=1
s1_temp1:=""
IniRead, s1_temp1, %g_config%, quick_folder
StringSplit,s1_oneline_temp,s1_temp1,`n,,
apps_1st_folder_num:= s1_oneline_temp0 + 1
while (recnum1 <= s1_oneline_temp0 )
{
s1_temp2:=SubStr(s1_oneline_temp%a_index%,1,instr(s1_oneline_temp%a_index%,"=")-1)
ar_folder_change[a_index,1]:=s1_temp2
menu_temp1:=SubStr(s1_oneline_temp%a_index%,instr(s1_oneline_temp%a_index%,"=")+1)
stringsplit, menuname, % menu_temp1, "|"
ar_folder_change[a_index,2]:=menuname1
if (menuname2 <> "")
{
stringsplit, menuicon_temp2, % menuname2, "`,"
ar_folder_change[a_index,3]:=menuicon_temp21
ar_folder_change[a_index,4]:=menuicon_temp22
if (menuicon_temp22 = "")
{
ar_folder_change[a_index,4]:=""
}
}
else
{
get_file_icon(menuname1)
ar_folder_change[a_index,3]:=g_hicon
ar_folder_change[a_index,4]:=
}
if ( ar_folder_change[a_index,1] = "X")
{
menu , quickmenu , add
}
else
{
menu , quickmenu , add, % ar_folder_change[a_index,1]  , menu_run
if (ar_folder_change[a_index,3] = "")
{
if (ar_folder_change[a_index,4] = "")
{
}
else
{
menu , quickmenu , icon, % ar_folder_change[a_index,1]  , % ar_folder_change[a_index,3], , % g_menuiconsize
}
}
else
{
menu , quickmenu , icon, % ar_folder_change[a_index,1]  , % ar_folder_change[a_index,3], % ar_folder_change[a_index,4], % g_menuiconsize
}
}
recnum1 +=1
}
if (g_allow_apps_menu = 1)
{
menu , quickmenu, add
gosub, appsmenu
}
iniread, donate_yes, % g_config, general, donatestatus
if (donate_yes!="9527")
{
menu , quickmenu , add
menu , quickmenu , add, Donate me, aboutpd
menu , quickmenu , icon, Donate me,%g_pdres_icon%, "-207" ,% g_menuiconsize
}
menu , quickmenu , show
menu , quickmenu, deleteall
menu, % g_apps_menuname, deleteall
}
EmptyMem()
return
menu_run:
newpath :=ar_folder_change[a_thismenuitempos,2]
if winactive("ahk_class CabinetWClass")
{
w_WinID :=WinActive("A")
if (openfromid <> w_WinID)
{
ControlFocus, ToolbarWindow323, ahk_id %w_WinID%
Controlclick, ToolbarWindow323 , ahk_id %w_WinID%
openfromid := w_WinID
}
ControlSetText, edit1, %newpath%, ahk_id %w_WinID%
ControlSend, edit1, {Right}{Enter}, ahk_id %w_WinID%
controlclick, systreeview321, ahk_id %w_WinID%
WinActivate ahk_id %w_WinID%
EmptyMem()
return
}
else if winactive("ahk_class #32770")
{
ControlGetText, w_Edit1Text,edit1, A
ControlFocus, edit1 , A
ControlSetText, edit1, %newpath%, A
ControlSend, edit1,{Enter}, A
ControlSetText, edit1, %w_Edit1Text%, A
sleep, 20
EmptyMem()
return
}
else
{
runwait, %newpath% ,,UseErrorLevel
Sleep, 20
WinGet, old_id, id, % "文件资源管理器"
WinActivate, ahk_id %old_id%
ControlFocus, ToolbarWindow323, ahk_id %old_id%
Controlclick, ToolbarWindow323 , ahk_id %old_id%
ControlFocus, edit1 , ahk_id %old_id%
ControlSetText, edit1, %newpath% , ahk_id %old_id%
ControlSend, edit1, {right}{Enter}, ahk_id %old_id%
controlclick, systreeview321, ahk_id %old_id%
openfromid := old_id
EmptyMem()
return
}
gui1exit:
esc::
Gui, 10:destroy
Gui, 30:hide
IL_Destroy(ev_ImageListID)
LV_Delete()
hotkey,esc,off
EmptyMem()
return
runme:
ControlGetText, myedit_tt , edit1
if ( myedit_tt = "" )
{
GuiControl, 10:hide, SysListView321
GuiControl, 10:hide, static2
}
else{
runcmdstr(myedit_tt)
EmptyMem()
}
EmptyMem()
return
mainrunwindow:
gui, 30:hide
if (A_PriorHotkey <> g_hotkeyname or A_TimeSincePriorHotkey > 350 )
{
KeyWait, % g_hotkeyname
EmptyMem()
return
}
IfWinActive, % g_window_title
{
gui, 10:destroy
}
else
{
Gosub, startgui
}
EmptyMem()
return
reloadme:
^!r::
ReLoad
return
EmptyMem(PID="pd"){
pid:=(pid="pd") ? DllCall("GetCurrentProcessId") : pid
h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", pid)
DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
DllCall("CloseHandle", "Int", h)
}
runcmdstr(cmdstr)
{
strnum:=0
cmdstr:=trim(cmdstr)
StringLower,templower,cmdstr
cmdstr:=templower
Loop, Parse, cmdstr , %a_space% , %A_Space%
{
strnum +=1
}
if ( strnum = 1 )
{
if (cmdstr = "conf")
{
run, %g_config% ,,UseErrorLevel
gosub gui1exit
return
}
if (cmdstr = "pc")
{
Run ::{20d04fe0-3aea-1069-a2d8-08002b30309d} ,,UseErrorLevel
gosub gui1exit
return
}
if (cmdstr ="recycle") or (cmdstr = "hsz" )
{
Run ::{645ff040-5081-101b-9f08-00aa002f954e},,UseErrorLevel
gosub gui1exit
return
}
if (cmdstr ="control") or (cmdstr = "kzmb" )
{
Run, control.exe ,,UseErrorLevel
gosub gui1exit
return
}
if (cmdstr="hosts")
{
run *runas "notepad.exe "%g_hostfile% ,, UseErrorLevel
gosub gui1exit
return
}
run, % cmdstr ,,UseErrorLevel
if  ( A_LastError = 0 )
{
gosub gui1exit
return
}
else
{
iniread, s_realcmdline, % g_config, s_cmdstr , % cmdstr, Nocmdstr
if (s_realcmdline <> "Nocmdstr" )
{
StringSplit, s_realcmdline_temp, s_realcmdline, "|"
s_realcmdline:=s_realcmdline_temp1
run, %s_realcmdline% ,,UseErrorLevel
gosub gui1exit
return
}
else
{
cmdstr_find_temp1 := cmdstr . " ext:" . g_searchdef_ext . " files: " . g_searchdef_path
everytime_find(cmdstr_find_temp1)
EmptyMem()
return
}
EmptyMem()
return
}
}
else
{
str1:=trim(substr(cmdstr,1,instr(cmdstr," ")-1))
str_find_temp:=substr(cmdstr,1,2)
str2:=trim(substr(cmdstr,instr(cmdstr," ")))
if (str1="ssh")
{
IniRead, m_tempa, % g_config, sshhost ,% str2 , NoServeName
if ( m_tempa <> "NoServeName" )
{
stringsplit,servedata,m_tempa,"|"
run , ssh -p %servedata3% %servedata1%@%servedata2% ,,UseErrorLevel
gosub gui1exit
EmptyMem()
return
}
else
{
gosub gui1exit
EmptyMem()
return
}
}
if (str1="admin")
{
Run *Runas %str2% ,,UseErrorLevel
gosub gui1exit
EmptyMem()
return
}
if (str_find_temp="f ")
{
gosub changetosearchfile
EmptyMem()
return
}
IniRead, m_tempb, % g_config, m_cmdstr ,% str1 , Nodefinestr
if ( m_tempb <> "Nodefinestr")
{
if instr(m_tempb,"%q")
{
m_tempb :=strreplace(m_tempb,"%q",str2,,Limit:=-1)
}
else
{
m_tempb:=m_tempb
}
run, %m_tempb% ,,UseErrorLevel
gosub gui1exit
EmptyMem()
return
}
else
{
cmdstr_find_temp1 := cmdstr . " ext:" . g_searchdef_ext . " files: " . g_searchdef_path
everytime_find(cmdstr_find_temp1)
EmptyMem()
return
}
EmptyMem()
return
}
}
exeQuery(s_str){
    ev := new everything
    str:=s_str
    ev.SetMatchWholeWord(false)
    ev.SetSearch(str)
    ev.Query()
    ev_count:=ev.GetTotResults()
    loop ,% ev_count
    {
    ev_res[A_index,1]:=ev.GetResultFileName(A_index-1)
    ev_res[A_index,2]:=ev.GetResultPath(A_index-1)
    }
}
class everything
{
__New(){
this.hModule := DllCall("LoadLibrary", str, ev_DLL)
}
__Get(aName){
}
__Set(aName, aValue){
}
__Delete(){
DllCall("FreeLibrary", "UInt", this.hModule)
return
}
SetSearch(aValue)
{
this.eSearch := aValue
dllcall(ev_DLL "\Everything_SetSearch",str,aValue)
return
}
SetMatchWholeWord(aValue)
{
this.eMatchWholeWord := aValue
dllcall(ev_DLL "\Everything_SetMatchWholeWord",int,aValue)
return
}
Query(aValue=1)
{
    dllcall(ev_DLL "\Everything_Query",int,aValue)
    return
}
GetTotResults()
{
    return dllcall(ev_DLL "\Everything_GetTotResults")
}
GetResultFileName(aValue)
{
    return strget(dllcall(ev_DLL "\Everything_GetResultFileName",int,aValue))
}
GetResultPath(aValue)
{
    return strget(dllcall(ev_DLL "\Everything_GetResultPath",int,aValue))
}
GetResultFullPathName(aValue,cValue=128)
{
    VarSetCapacity(bValue,cValue*2)
    dllcall(ev_DLL "\Everything_GetResultFullPathName",int,aValue,str,bValue,int,cValue)
    return bValue
}
}
read_section(sectionname)
{
    Ar:= Object()
    recnum :=1
    s_temp1:=""
    IniRead, s_temp1, %g_config%, %sectionname%
    StringSplit,s_oneline_temp,s_temp1,`n,,
    while (recnum <= s_oneline_temp0 )
    {
    s_temp2:=SubStr(s_oneline_temp%a_index%,1,instr(s_oneline_temp%a_index%,"=")-1)
    StringLower, s_temp1_lower, s_temp2
    ar[a_index,1]:=s_temp1_lower
    ar[a_index,2]:=SubStr(s_oneline_temp%a_index%,instr(s_oneline_temp%a_index%,"=")+1)
    recnum +=1
    }
}
get_file_icon(this_fullpathname){
VarSetCapacity(fileinfo, fisize := A_PtrSize + 688)
if DllCall("c:\windows\system32\shell32\SHGetFileInfoW", "wstr", this_fullpathname, "uint", 0, "ptr", &fileinfo, "uint", fisize, "uint", 0x100)
{
g_hicon_temp := NumGet(fileinfo, 0, "ptr")
g_hicon = HICON:%g_hicon_temp%
}
}
everytime_find(str2)
{
ev_count:=0
Gui, 10:default
LV_Delete()
if (str2 = "")
{
GuiControl, 10:hide, SysListView321
GuiControl, 10:Hide, static2
GuiControl, 10:hide, static3
gui,10:show, w670 h65
EmptyMem()
return
}
exeQuery(str2)
if (ev_count > g_maxsearchitems ) or (ev_count = 0 )
{
GUI, Font, s16 Q5 W100 c%g_errortipscolor%, microsoft yahei
guicontrol, font, static1
ControlSetText, edit1, % ""
ControlSetText, static1, % g_cmd_error_tip
GuiControl, 10:hide, SysListView321
GuiControl, 10:Hide, static2
GuiControl, 10:hide, static3
gui,10:show, w670 h65
EmptyMem()
return
}
GuiControl, 10:-Redraw , SysListView321
ev_ImageListID := IL_Create(ev_count)
LV_SetImageList(ev_ImageListID)
loop % ev_count
{
file_temp_result:= ev_res[a_index,2] . "\" . ev_res[a_index,1]
get_file_icon(file_temp_result)
IL_Add(ev_ImageListID, g_hicon)
LV_Add("Icon" . a_index, ev_res[A_index,1] ,  ev_res[A_index,2])
LV_ModifyCol(1,350)
}
GuiControl, 10:+Redraw, SysListView321
GuiControl, 10:show, SysListView321
ControlSetText, static2 , % "  共搜索到 " . ev_count . "个项目。"
GuiControl, 10:show, static2
GuiControl, 10:hide, static3
gui,10:show, w670 h430
EmptyMem()
return
}
