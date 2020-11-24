;------------------------------------------------------------
; List Environmental Variables - 1.31  - UNICODE
;------------------------------------------------------------
; This little tool lists the environmental variables of the 
; current process environment in an editor window (supports Ctrl+C)
; Ver 1.30: Status bar, mouse click opens Windows' utility 
;------------------------------------------------------------
#title = "Environment Variables "
ID = FindWindow_(0,#title)                     ; already open? 
If ID : PostMessage_(ID,#WM_CLOSE,0,0) : EndIf ; make other window close itself

#width = 500 : #height = 400 : #list = 1
#flags = #PB_Window_SystemMenu|#PB_Window_MinimizeGadget|#PB_Window_MaximizeGadget|#PB_Window_SizeGadget|#PB_Window_ScreenCentered
If OpenWindow(0,0,0,#width,#height,#title,#flags) : Else : End : EndIf 

ListHandle = EditorGadget(#list,0,0,#width,#height,#PB_Editor_ReadOnly) 
SendMessage_(ListHandle,#EM_SETMARGINS,#EC_LEFTMARGIN,8)

; --- Status bar  -------------------------------------------------------------------------------
StatBarHandle = CreateStatusBar(0,WindowID(0))
AddStatusBarField(#PB_Ignore)
StatusBarText(0,0,">> Change or add environment variables")
HandCursor = LoadCursor_(0,#IDC_HAND)
SetClassLong_(StatBarHandle,#GCL_HCURSOR,HandCursor)
  
Procedure IsCursorInStatusbar() 
  Shared StatBarHandle
  GetCursorPos_(@pos.Q) 
  GetWindowRect_(StatBarHandle,@area.RECT)
  ProcedureReturn PtInRect_(@area,pos)
EndProcedure
; -----------------------------------------------------------------------------------------------

Procedure WindowResize()
  ResizeGadget(#list,#PB_Ignore,#PB_Ignore,WindowWidth(0),WindowHeight(0)-StatusBarHeight(0))
EndProcedure
BindEvent(#PB_Event_SizeWindow, @WindowResize(),0)

If ExamineEnvironmentVariables()
  While NextEnvironmentVariable()
    vname$ = EnvironmentVariableName()
    If vname$
      AddGadgetItem(#list,-1,vname$ + "=" + EnvironmentVariableValue())
    EndIf 
  Wend
EndIf 

SendMessage_(ListHandle,#EM_SETSEL,0,0)
SetActiveGadget(#list)
WindowResize()

While WindowEvent() : Wend 
Repeat 
  event = WaitWindowEvent()
  If event = #WM_LBUTTONDOWN And IsCursorInStatusbar() 
;   rundll$ = GetEnvironmentVariable("systemroot") + "\system32\rundll32.exe"
    ShellExecute_(WindowID(0),0,"rundll32.exe","sysdm.cpl,EditEnvironmentVariables",0,#SW_SHOW)
  EndIf 
Until event = #PB_Event_CloseWindow 

End


; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 1
; Folding = -
; Executable = EnvarList.exe
; CompileSourceDirectory
; EnableUnicode