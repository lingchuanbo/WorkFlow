<Updater>:
;SetTimer,UpdateFailure,20000,4096
Gui,Updating: +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui,Updating: Color, %color2%
Gui,Updating: Font,cwhite s%FontSize% wbold q5,Segoe UI
Gui,Updating: Add, Text, ,%_Updating%
Gui,Updating: Show,AutoSize Center NoActivate
UrlDownloadToFile,%UrlDownloadToFile_Dater%, %A_ScriptDir%\latest-Vimd.exe ;

if ErrorLevel
{
    Gosub, ExitUpdater
}
Else
{
    FileMove,%A_ScriptDir%\latest-Vimd.exe, %A_ScriptDir%\Vimd.exe,1
    Gosub, ExitUpdater
}
Return


UpdateFailure:
Gui,Updating:Hide
MsgBox,0x40010,%_AppName%,%_PoorNetwork%
Gosub,ExitUpdater
Return

ExitUpdater:
FileDelete, %A_ScriptDir%\latest-Vimd.exe
sleep %SleepTime%
Gui,Updating: Hide
Gui,Updating2: +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui,Updating2: Color, %color3%
Gui,Updating2: Font,cwhite s%FontSize% wbold q5,Segoe UI
Gui,Updating2: Add, Text, ,%_UpdateCompleted%
Gui,Updating2: Show,AutoSize Center NoActivate
sleep %SleepTime%
Gui,Updating2: Hide
Run,%A_ScriptDir%\Vimd.exe
ExitApp
Return