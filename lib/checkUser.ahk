/*
    Function: QZ_UpdatePlugin()
    搜索User\下的所有的AHK，并加载到 Lib\plugins.ahk。用于动态加载
*/

QZ_UpdatePlugin()
{
    FileEncoding,utf-8
    ExtensionsAHK := A_ScriptDir "\User\plugins.ahk"
    ; 清理无用#include
    Filedelete, %ExtensionsAHK%
    ;; 查询插件
    Loop, %A_ScriptDir%\User\*.ahk*, 1
    plugins .=  "#include *i `%A_ScriptDir`%\User\" A_LoopFileName ".ahk`n"
    FileAppend, %plugins%, %ExtensionsAHK%

    ; 保存修改时间
    SaveTime := "/*`r`n[ExtensionsTime]`r`n"
    Loop, %A_ScriptDir%\User\*.ahk*, 1
    {
    plugins .=  "#include *i `%A_ScriptDir`%\User\" A_LoopFileName ".ahk`n"
    FileGetTime, ExtensionsTime, %plugin%, M
    SaveTime .= A_LoopFileName "=" ExtensionsTime "`r`n"
    }
    SaveTime .= "*/`r`n"
    FileAppend, %SaveTime%, %ExtensionsAHK%
    FileRead, Extensions, %ExtensionsAHK%
Exit
}
