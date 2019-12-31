AutoExecute:
; if ((A_Is64bitOS+1)*4!=A_PtrSize)
; {
;     msgbox,0x40010,Vimdesktop,%_Require64%
;     shellRun(HelpLink)
;     Exitapp
; }
if !A_IsAdmin
{
    try
    {
        Run *RunAs "%A_ScriptFullPath%" /restart
    }
    ExitApp
}

Suspend,off

regread,temp,HKLM\Software\Microsoft\Windows\CurrentVersion\Run, Vimdesktop
if !ErrorLevel
{
    RegWrite, REG_SZ, HKLM\Software\Microsoft\Windows\CurrentVersion\Run, Vimdesktop, %A_ScriptFullPath%
    StartUp=1
}
Else
{
    StartUp=0
}

; regread,temp,HKLM\Software\szzhiyang\Power Keys,SpaceDisabled
; if temp
; SpaceDisabled=1

; EnvGet,AppDataLocal,LocalAppData

; FileCreateDir,%AppDataLocal%\Power Keys
; FileCreateDir,%ProgramFilesDir%
; SetWorkingDir,%AppDataLocal%\Power Keys

; if (FirstParameter!="silent")
; {
;     Gui,welcome: +LastFound +AlwaysOnTop -Caption +ToolWindow
;     Gui,welcome: Color, red
;     Gui,welcome: Font,cwhite s%FontSize% wbold q5,Segoe UI
;     Gui,welcome: Add, Text, ,Power Keys
;     Gui,welcome: Show,AutoSize Center NoActivate
;     sleep %SleepTime%
;     Gui,welcome: Hide
; }

; RegDelete, HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run, Power Keys
; RegDelete, HKCU\Software\Microsoft\Windows\CurrentVersion\Run, Power Keys
; RegDelete, HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run, Power Keys

Gosub, Createtray

Return