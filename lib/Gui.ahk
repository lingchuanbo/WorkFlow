CreateGUI:

;FileCreateDir,%ProgramFilesDir% 
;FileInstall,ui\74按键模板Vimd—TC.png, %ProgramFilesDir%\ui\74按键模板Vimd—TC.png,1
; picwidth:=A_screenwidth*93/A_screendpi
; Gui,TCLayout:Add,pic,w%picwidth% h-1,%A_ScriptDir%\ui\74按键模板Vimd—TC.png
; Gui,TCLayout:Color,Green

;Return

ShowTCLayout:
;picwidth:=A_screenwidth*93/A_screendpi
;Gui,TCLayout:Add,pic,w%picwidth% h-1,%A_ScriptDir%\ui\74按键模板Vimd—TC.png
Gui,TCLayout:Add,pic,Center,%A_ScriptDir%\ui\74按键模板Vimd—TC.png 
;Gui,TCLayout:Color,d4d0c8
;+ToolWindow +DPIScale +LastFound iii
Gui,TCLayout:+LastFound +AlwaysOnTop -Caption +ToolWindow -DPIScale
Gui,TCLayout:Show, Center NoActivate
WinSet, TransColor,d4d0c8
Return

HideTCLayout:
Gui,TCLayout:Hide
Return