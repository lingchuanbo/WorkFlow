;=========================================================
;最后修改于2020-03-24
;rdingding
;天下随我意，道德只本心
; Mod:BoBO
;=========================================================

; #SingleInstance Force
; #NoEnv
; ;自定义任务栏图标右键菜单功能
; Menu, Tray, NoStandard 
; Menu, Tray, NoDefault 
; Menu, tray, add, 重启, Reload 
; Menu, tray, add, 退出, Exit 
function_SystemMonitor:

   applicationname := "fox_monitor"
   Gosub, GETBIANLIANG

   ; windowTitle := "ClockInfo"

   regionMargin := 10
   progressBarPos := regionMargin - 1


   clockFontStyle = s%fontsize% bold
   infoFontStyle = s%infoFontSize% bold

   FormatTime, clockText ,, %timeFormat%
   clockWidth := GetTextSize(clockText, clockFontStyle "," clockFont )+10

   memText := memLabel . "100%"
   memWidth := GetTextSize(memText, infoFontStyle "," infoFont )+10

   cpuText := cpuLabel . "100.00%"
   cpuWidth := GetTextSize(cpuText, infoFontStyle "," infoFont )+10

   gpuText := gpuLabel . "100.00%"
   gpuWidth := GetTextSize(gpuText, infoFontStyle "," infoFont )+10

   maxWidth := Max(memWidth, cpuWidth)

   cpuWidth := maxWidth
   gpuWidth := maxWidth
   memWidth := maxWidth

   memProgressWidth := memWidth + 1
   cpuProgressWidth := cpuWidth + 1
   gpuProgressWidth := gpuWidth + 1

   height := fontSize + (fontsize * 0.7)
   infoHeight := infoFontSize + (fontsize * 0.7)
   txtY := 0
   txtX := 15
   posFromRight = 120

   showtrans = 0
   tqstatus = 0
   sjstatus = 0
   ylstatus = 0

VarSetCapacity( IdleTicks, 2*4 )
VarSetCapacity( memstatus, 100 )



Gosub, CALCULATEPOSITIONS
Gosub, CREATECLOCKWINDOW


; SetTimer, UPDATECLOCK, 250
SetTimer, UPDATECPU, 1500
; SetTimer, WATCHCURSOR, 115
SetTimer, KEEPONTOP, 1000


getDistance(mX, mY, x, y, w, h)
{

    If (mX > x) and (mX < (x + w))
    and (mY > y) and (mY < (y + h))
    {
        xDistance := 0
        yDistance := 0
    }
    Else
    {

        If (mX < x)
            xDistance := x - mX

        Else If (mX > (x + w))
            xDistance := mX - (x + w)


        If (mY < y)
            yDistance := y - mY

        Else If (mY > (y + h))
            yDistance := mY - (y + h)
    }
    distance := max(xDistance, yDistance) * 3
    return distance
}

CALCULATEPOSITIONS:
   savedScreenWidth := A_ScreenWidth
   savedScreenHeight := A_ScreenHeight
   width := clockWidth  + memWidth + cpuWidth + gpuWidth + margin * 4
   xPos := savedScreenWidth - width - posFromRight -50
   yPos := 5
    memPos := xPos + clockWidth + margin 
    cpuPos := memPos + memWidth + margin
    gpuPos := cpuPos + memWidth + margin
   ;  volPos := cpuPos + cpuWidth + margin
Return

WATCHCURSOR:
   ;  if showtrans <> 1
   ;  return
   ;  CoordMode, Mouse
   ;  MouseGetPos, mouseX, mouseY
   ;  clockTransparency := min(getDistance(mouseX, mouseY, xPos + regionMargin, yPos, regionMargin + clockWidth, height), transparency)
   ;  memTransparency := min(getDistance(mouseX, mouseY, memPos + regionMargin, yPos, regionMargin + memWidth, height), transparency)
   ;  cpuTransparency := min(getDistance(mouseX, mouseY, cpuPos + regionMargin, yPos, regionMargin + cpuWidth, height), transparency)
   ;  gpuTransparency := min(getDistance(mouseX, mouseY, cpuPos + regionMargin, yPos, regionMargin + cpuWidth, height), transparency)
   ;  tqTransparency := min(getDistance(mouseX, mouseY, xxPos + regionMargin, yPos, regionMargin + Length, height), transparency)
   ;  volTransparency := min(getDistance(mouseX, mouseY, volPos + regionMargin, yPos, regionMargin + 40, height), transparency)
   ; WinSet, Transparent, %clockTransparency%, %windowTitle%
   ; WinSet, Transparent, %memTransparency%, MemBarGui
   ; WinSet, Transparent, %cpuTransparency%, CpuBarGui
   ; WinSet, Transparent, %gpuTransparency%, GpuBarGui
   ; WinSet, Transparent, %tqTransparency%, tq
   ; WinSet, Transparent, %volTransparency%, volshow
Return

CREATECLOCKWINDOW:
   ;  Gui, 1:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   ;  Gui, 1:Color, %clockBGColor%
   ;  Gui, 1:Font, c%clockFontColor% %clockFontStyle%, %clockFont%
   ; ;  Gui, 1:Add,Text,vDate grl y%txtY% x%txtX%, %clockText%
   ;  Gui, 1:Add,Text,vDate y%txtY% x%txtX%, %clockText%
   ;  Gui, 1:Show,NoActivate x%xPos% y%yPos% ,%windowTitle%
   ;  WinSet, Region, %regionMargin%-0 W%clockWidth% H%height% R5-5, %windowTitle%

   Gui, 7:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   Gui, 7:Add, Progress, y0 x%progressBarPos% w%memProgressWidth% h%infoHeight% c%memBarColor% vMemBar Background%memBGColor%
   Gui, 7:Show,NoActivate x%memPos% y%yPos%, MemBarGui
   WinSet, Region, %regionMargin%-0 W%memWidth% H%infoHeight% R5-5, MemBarGui
   GuiControl, 7:, MemBar, 50


   Gui, 3:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   Gui, 3:Color, %memBGColor%
   Gui, 3:Font, c%memFontColor% %infoFontStyle%, %infoFont%
   Gui, 3:Add,Text,vMem y%txtY% x%txtX%, %memText%
   Gui, 3:Show,NoActivate x%memPos% y%yPos% ,Mem
   WinSet, Region, %regionMargin%-0 W%memWidth% H%infoHeight% R5-5, Mem
   WinSet, TransColor, %memBGColor%


   Gui, 5:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   Gui, 5:Add, Progress, y0 x%progressBarPos% w%cpuProgressWidth% h%infoHeight% c%cpuBarColor% vCpuBar Background%cpuBGColor%
   Gui, 5:Show,NoActivate x%cpuPos% y%yPos%, CpuBarGui
   WinSet, Region, %regionMargin%-0 W%cpuWidth% H%infoHeight% R5-5, CpuBarGui

   Gui, 4:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   Gui, 4:Color, %cpuBGColor%
   Gui, 4:Font, c%cpuFontColor% %infoFontStyle%, %infoFont%
   Gui, 4:Add,Text,vCpu y%txtY% x%txtX%, %cpuText%
   Gui, 4:Show,NoActivate x%cpuPos% y%yPos% ,Cpu
   WinSet, Region, %regionMargin%-0 W%cpuWidth% H%height% R5-5, Cpu
   WinSet, TransColor, %cpuBGColor%

   Gui, 2:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   Gui, 2:Add, Progress, y0 x%progressBarPos% w%gpuProgressWidth% h%infoHeight% c%gpuBarColor% vCpuBar Background%gpuBGColor%
   Gui, 2:Show,NoActivate x%gpuPos% y%yPos%, GpuBarGui
   WinSet, Region, %regionMargin%-0 W%gpuWidth% H%infoHeight% R5-5, GpuBarGui

   Gui, 8:+LastFound +AlwaysOnTop +ToolWindow -SysMenu -Caption
   Gui, 8:Color, %gpuBGColor%
   Gui, 8:Font, c%gpuFontColor% %infoFontStyle%, %infoFont%
   Gui, 8:Add,Text,vGpu y%txtY% x%txtX%, %gpuText%
   Gui, 8:Show,NoActivate x%gpuPos% y%yPos% ,Gpu
   WinSet, Region, %regionMargin%-0 W%gpuWidth% H%height% R5-5, Gpu
   WinSet, TransColor, %gpuBGColor%

Return


; UPDATECLOCK:
; if sjstatus =1
; {
; return
; }

;    if (savedScreenWidth <> A_ScreenWidth)
;    {

;        Gosub, CalculatePositions
;       ;  Gui, 1:Hide
;        Gui, 3:Hide
;        Gui, 4:Hide
;        Gui, 5:Hide
;        Gui, 6:Hide
;        Gui, 7:Hide

;     }
;    FormatTime, clockText ,, %timeFormat%
;     GuiControl, 1:,Date, %clockText%
; Return


UPDATECPU:
    load:=CPULoad()

   If (load > cpuThreshold)
   {
      Gui, 4:Font, c%cpuFontColorAlert%
      GuiControl, 5: +Background%cpuBGColorAlert%, CpuBar
      GuiControl, 5: +c%cpuBarColorAlert%, CpuBar
   }
    Else
    {
      Gui, 4:Font, c%cpuFontColor%
      GuiControl, 5: +Background%cpuBGColor%, CpuBar
      GuiControl, 5: +c%cpuBarColor%, CpuBar
   }
    GuiControl, 4:Font, Cpu

    GuiControl, 4:, Cpu, %cpuLabel%%load%`%
    GuiControl, 5:, CpuBar, %load%

   GPUload:=NvAPI.GPU_GetDynamicPstatesInfoEx().GPU.percentage
      If (GPUload > gpuThreshold)
   {
      Gui, 8:Font, c%gpuFontColorAlert%
      GuiControl, 2: +Background%gpuBGColorAlert%, GpuBar
      GuiControl, 2: +c%gpuBarColorAlert%, GpuBar
   }
    Else
    {
      Gui, 8:Font, c%gpuFontColor%
      GuiControl, 2: +Background%gpuBGColor%, GpuBar
      GuiControl, 2: +c%gpuBarColor%, GpuBar
   }
    GuiControl, 8:Font, Gpu
    GuiControl, 8:, Gpu, %GpuLabel%%GPUload%`%
    GuiControl, 2:, GpuBar, %GPUload%




    DllCall("kernel32.dll\GlobalMemoryStatus", "uint",&memstatus)
    mem := *( &memstatus + 4 )
   If (mem > memThreshold)
   {
      Gui, 3:Font, c%memFontColorAlert%
      GuiControl, 7: +Background%memBGColorAlert%, MemBar
      GuiControl, 7: +c%memBarColorAlert%, MemBar
   }
    Else
    {
      Gui, 3:Font, c%memFontColor%
      GuiControl, 7: +Background%memBGColor%, MemBar
      GuiControl, 7: +c%memBarColor%, MemBar
   }
    GuiControl, 3:Font, Mem
    GuiControl, 3:,Mem, %memLabel%%mem%`%
   GuiControl, 7:, MemBar, %mem%

Return



ReadInteger( p_address, p_offset, p_size, p_hex=true )
{
    value = 0
    old_FormatInteger := a_FormatInteger
    if ( p_hex )
        SetFormat, integer, hex
    else
        SetFormat, integer, dec
    loop, %p_size%
        value := value+( *( ( p_address+p_offset )+( a_Index-1 ) ) << ( 8* ( a_Index-1 ) ) )
    SetFormat, integer, %old_FormatInteger%
    return, value
}


Max(In_Val1,In_Val2)
{
   IfLess In_Val1,%In_Val2%, Return In_Val2
   Return In_Val1
}

Min(In_Val1,In_Val2)
{
   IfLess In_Val1,%In_Val2%, Return In_Val1
   Return In_Val2
}

GETBIANLIANG:
   IfNotExist,%applicationname%.ini
   {
      clockFont := "Verdana"
      fontSize := 10
      clockFontColor := "Silver"
      clockBGColor := "Black"

      infoFontSize := 10
      infoFont := "Tahoma"

      memFontColor := "Fuchsia"
      memFontColorAlert := "Yellow"
      memBGColor := "Black"
      memBGColorAlert := "Maroon"
      memBarColor := "Purple"
      memBarColorAlert := "Red"
      memThreshold := 80

      cpuFontColor := "Aqua"
      cpuFontColorAlert := "Yellow"
      cpuBGColor := "Black"
      cpuBGColorAlert := "Maroon"
      cpuBarColor := "Blue"
      cpuBarColorAlert := "Red"
      cpuThreshold := 80
      margin := 2
      transparency := 200
      memLabel := "内存: "
      cpuLabel := "CPU: "
      gpuLabel := "GPU: "

      gpuFontColor := "Yellow"
      gpuFontColorAlert := "Aqua"
      gpuBGColor := "Black"
      gpuBGColorAlert := "Maroon"
      gpuBarColor := "Yellow"
      gpuBarColorAlert := "Red"
      gpuThreshold := 80

      ; timeFormat := "yy-M-d ddd HH:mm:ss"
      timeFormat := "yy-M-d HH:mm:ss"
   }
Return


ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4)
{
    Loop %pSize%
        result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1)
    if (!pIsSigned OR pSize > 4 OR result < 0x80000000)
        return result

    return -(0xFFFFFFFF - result + 1)
}



GetTextSize(pStr, pFont="", pHeight=false) {
   local height, weight, italic, underline, strikeout , nCharSet
   local hdc := DllCall("GetDC", "Uint", 0)
   local hFont, hOldFont

   if (pFont != "") {
      italic      := InStr(pFont, "italic")
      underline   := InStr(pFont, "underline")
      strikeout   := InStr(pFont, "strikeout")
      weight      := InStr(pFont, "bold") ? 700 : 0

      RegExMatch(pFont, "(?<=[S|s])(\d{1,2})(?=[ ,])", height)
      if (height != "")
         height := -DllCall("MulDiv", "int", height, "int", DllCall("GetDeviceCaps", "Uint", hDC, "int", 90), "int", 72)

      RegExMatch(pFont, "(?<=,).+", fontFace)
      fontFace := RegExReplace( fontFace, "(^\s+)|(\s+$)")
   }

   hFont := DllCall("CreateFont", "int", height, "int", 0, "int", 0, "int", 0 ,"int", weight, "Uint", italic, "Uint", underline ,"uint", strikeOut, "Uint", nCharSet, "Uint", 0, "Uint", 0, "Uint", 0, "Uint", 0, "str", fontFace)
   hOldFont := DllCall("SelectObject", "Uint", hDC, "Uint", hFont)
   DllCall("GetTextExtentPoint32", "Uint", hDC, "str", pStr, "int", StrLen(pStr), "int64P", nSize)
   DllCall("SelectObject", "Uint", hDC, "Uint", hOldFont)
   DllCall("DeleteObject", "Uint", hFont)
   DllCall("ReleaseDC", "Uint", 0, "Uint", hDC)

   nWidth  := nSize & 0xFFFFFFFF
   nHeight := nSize >> 32 & 0xFFFFFFFF

   if (pHeight)
      nWidth .= "," nHeight
   return   nWidth
}

CPULoad(){ ; By SKAN, 
  Static PIT, PKT, PUT                           ; http://ahkscript.org/boards/viewtopic.php?p=17166#p17166
  IfEqual, PIT,, Return 0, DllCall( "GetSystemTimes", "Int64P",PIT, "Int64P",PKT, "Int64P",PUT )

  DllCall( "GetSystemTimes", "Int64P",CIT, "Int64P",CKT, "Int64P",CUT )
, IdleTime := PIT - CIT,    KernelTime := PKT - CKT,    UserTime := PUT - CUT
, SystemTime := KernelTime + UserTime 


   Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT 
   ; Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT 
}

KEEPONTOP:
   if sjstatus =0
   Gui, 1:Show, NA x%xPos% y%yPos%, %windowTitle%
   Gui, 7:Show, NA x%memPos% y%yPos% ,MemBarGui
   Gui, 3:Show, NA x%memPos% y%yPos% ,Mem
   Gui, 5:Show, NA x%cpuPos% y%yPos% ,CpuBarGui
   Gui, 4:Show, NA x%cpuPos% y%yPos% ,Cpu
   Gui, 2:Show, NA x%gpuPos% y%yPos% ,GpuBarGui
   Gui, 8:Show, NA x%gpuPos% y%yPos% ,Gpu
Return

; Reload:
; Reload
; return
; Exit:
; ExitSub:
; ExitApp