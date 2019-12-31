#SingleInstance,force
;FileName:OpenInTC.ahk
; File encoding:  UTF-8 BOM
/*
AutoHotkey 版本: 1.1.9.0
操作系统:    Windows XP/Vista/7
作者:        sunwind <1576157@qq.com>
博客:        http://blog.csdn.net/liuyukuan
设计目的：[ahk]让TC 识别已经打开的路径tab，若已存在则仅激活不重复打开。
设计思路：先保存当前配置，再检测其是否存在要打开的标签
功能：
1.新开tab标签如果已存在则激活，若不存在则打开之
2.按住shift 右侧窗口激活，不按左侧
3.接收路径以参数形式传给本脚本，可以为candy等工具调用 
在candy的配置中设置菜单项:  在tc中打开             =cango|openWithTC|"{file:pathfull}"
4.兼容路径 末尾无\ 的情况
5.兼容带空格路径
6.兼容wincmd.ini中RedirectSection的情况
7.修正最小化在托盘中时激活的bug
形如[Left] RedirectSection=%COMMANDER_PATH%\USER\user.ini
 
若把本脚本放到TOTALCMD.EXE所在目录则免配置
否则，可以以命令行参数指定wincmd.ini路径，不指定则需要配置本脚本的tc_exe
 
脚本版本：   v1.7
时间戳:20130227 0:15:47
*/
SetWorkingDir %A_ScriptDir%
DetectHiddenWindows,on

    TCpath := ini.TotalCommander_Config.TCPath
    ; TCDirPath := ini.TotalCommander_Config.TCDirPath
    TCini := ini.TotalCommander_Config.TCINI

tc_exe=F:\BoBOProgram\TotalCMD\TOTALCMD.EXE

wincmd_ini=F:\BoBOProgram\TotalCMD\wincmd.ini

OutputDebug %1%
SplitPath,tc_exe,,tc_dir
GetKeyState, state, Shift
;state=D Shift key is down.用右侧打开
;state=U Shift key is Up.用左侧打开
;用特殊的0变量判断，调用者所传过来的需要打开的路径
If 0 > 0
  {
    targetPath=%1%
  }
Else
  {
    targetPath=%tc_dir%
  }
If (SubStr(Trim(targetPath),0)!="`\")
    targetPath.="`\"
;检验配置并得到正确的tabs信息存储位置
tabs_ini:=getTabs_ini(tc_exe,wincmd_ini)
OutputDebug,  %tabs_ini%
IfExist,%tabs_ini%
  {
    Loop,10
      {
        sendTCCommand(580,1 ) ;保存配置,582保存文件夹历史记录
        Sleep,200
      }until (checkTime(tabs_ini))
  }
Else
  {
    MsgBox,,请修改配置文件,%wincmd_ini%中的`nRedirectSection=路径存在错误
    ExitApp
  }
isFinded=-1
If state = D ;在右侧检测
  {
    rightArray:=getRightArray(tabs_ini)  ;必须用:=不能用用=
    printArray(RightArray)
    for index, element in rightArray
    {
      If  targetPath=%element%
        {
          isFinded=2
          TargetNum:=5300+index+1
          OutputDebug,在右侧检测到%element%,激活%TargetNum%
        }
    }
  }
Else
  {
    leftArray:=getLeftArray(tabs_ini)
    printArray(leftArray)
    for index, element in leftArray
    {
      If  targetPath=%element%
        {
          isFinded=1
          TargetNum:=5200+index+1
          OutputDebug,在左侧检测到%element%,激活%TargetNum%
        }
    }
  }
If  isFinded>0
  {
    OutputDebug,isFinded=%isFinded%  找到激活之
    activeTC(tc_exe,TargetNum)
  }
Else
  {
    OutputDebug,isFinded=%isFinded%  未找到打开之
    If state = D ;在右侧打开
        tc_cmd=`"%tc_exe%`"  /O  /T  /R=`"%targetPath%`"
    Else
        tc_cmd=`"%tc_exe%`"  /O  /T  /L=`"%targetPath%`"
    Run %tc_cmd%
  }
Return
getLeftArray(tabs_ini)
  {
    LeftActiveTab=
    IniRead, LeftActiveTab_Section, %tabs_ini%, left
    Loop, Parse, LeftActiveTab_Section, `n, `r  ;%a_tab%%a_Space%`r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"path"))
          {
            p:= InStr(A_LoopField, "=")
            LeftActiveTab := SubStr(A_LoopField, p + 1)
            Break
          }
      }
    IniRead, lefttabs_Section, %tabs_ini%, lefttabs
    LeftHas:=-1
    LeftActiveTabNum:=-1
    leftArray := Object()
    printlog=
    Loop, Parse, lefttabs_Section, `n, `r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"_path"))||(InStr(curline,"activetab"))
          {
            match1 := SubStr(A_LoopField, (p1:=InStr(A_LoopField, "_"))+1, (p2:= InStr(A_LoopField, "="))-p1-1 )
            match2 := SubStr(A_LoopField, p2 + 1)
            If  (match1="path") ;必须有括号括起
              {
                LeftHas++
                leftArray[LeftHas]:=match2
              }
            Else
              {
                LeftActiveTabNum:=match2
              }
          }
      }
    leftArray.Insert(LeftActiveTabNum,LeftActiveTab)
    Return leftArray
  }
getRightArray(tabs_ini)
  {
    RightActiveTab=
    IniRead,RightActiveTab_Section, %tabs_ini%, Right
    Loop, Parse, RightActiveTab_Section, `n, `r  ;%a_tab%%a_Space%`r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"path"))
          {
            p:= InStr(A_LoopField, "=")
            RightActiveTab := SubStr(A_LoopField, p + 1)
            Break
          }
      }
    IniRead, Righttabs_Section, %tabs_ini%, Righttabs
    RightHas:=-1
    RightActiveTabNum:=-1
    RightArray := Object()
    printlog=
    Loop, Parse, Righttabs_Section, `n, `r
      {
        curline := Trim(A_LoopField)
        If  (InStr(curline,"_path"))||(InStr(curline,"activetab"))
          {
            match1 := SubStr(A_LoopField, (p1:=InStr(A_LoopField, "_"))+1, (p2:= InStr(A_LoopField, "="))-p1-1 )
            match2 := SubStr(A_LoopField, p2 + 1)
            If  (match1="path") ;必须有括号括起
              {
                RightHas++
                RightArray[RightHas]:=match2
              }
            Else
              {
                RightActiveTabNum:=match2
              }
          }
      }
    RightArray.Insert(RightActiveTabNum,RightActiveTab)
    Return RightArray
  }
checkTime(tabs_ini)
  {
    static LogTime
    test:=LogTime
    FileGetTime, newLogTime,%tabs_ini%
    LogTime:=newLogTime
    OutputDebug,探测TC标签信息:`n上一个快照%test%`n当前快照%LogTime%
    If (newLogTime!=test)
        Return True
    Else
        Return false
  }
sendTCCommand( CommandID, xbWait=1 )
  { If (xbWait)
        SendMessage 1075, %CommandID%, 0, , ahk_class TTOTAL_CMD
    Else
        PostMessage 1075, %CommandID%, 0, , ahk_class TTOTAL_CMD
  }
getTabs_ini(ByRef  tc_exe,ByRef  wincmd_ini)
  { ;参考流彩写的函数，首先默认脚本目录下的tc
    IfExist,TOTALCMD.EXE
        tc_exe=%A_WorkingDir%\TOTALCMD.EXE
    Else
      {
        IfNotExist, %tc_exe%
          {
            MsgBox 请直接配置tc_exe变量为tc全路径
            ExitApp
          }
      }
    SplitPath,tc_exe,,COMMANDER_PATH ;用于 COMMANDER_PATH
    IfExist,WINCMD.INI
        wincmd_ini=%A_WorkingDir%\WINCMD.INI
    Else
      {
        IfNotExist, %wincmd_ini%
          {
            MsgBox,请直接配置wincmd_ini变量为tc配置文件的全路径
            ExitApp
          }
      }
    IniRead, Test_Left_Section, %wincmd_ini%, left
    If InStr(Test_Left_Section,"RedirectSection")
      {
        Loop, Parse, Test_Left_Section, `n, `r
          {
            curline := Trim(A_LoopField)
            If  (InStr(curline,"RedirectSection"))
              {
                isRedirectSection=1
                redirect_ini := SubStr(A_LoopField,  InStr(A_LoopField, "=") + 1)
                StringReplace,tabs_ini,redirect_ini,`%COMMANDER_PATH`%,%COMMANDER_PATH%
              }
          }
      }
    Else
        tabs_ini:=wincmd_ini
    Return tabs_ini
  }
activeTC(tc_exe, TargetNum)
  {
          IfWinExist, ahk_class TTOTAL_CMD
              WinActivate
          else
          {
              Run,%tc_exe% /O
              WinWait, AHK_CLASS TTOTAL_CMD
          }
          PostMessage 1075, %TargetNum%, 0, , AHK_CLASS TTOTAL_CMD	;ActiveTab
  }
  
printArray(Array)
  {
    for index, element in Array
    {
      printlog.=index . "_path is " . element . "`n"
    }
    OutputDebug %printlog%
  }
