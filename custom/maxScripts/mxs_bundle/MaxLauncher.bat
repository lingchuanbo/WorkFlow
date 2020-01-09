:: %DEV_PATH% is a user environment variable with a path to the code repository


:: @echo off

set NETROOT=G:\
set DEV_PATH=F:\BoBOAHK\WorkFlow\custom\maxScripts
set MXS_CODEROOT=%DEV_PATH%\mxs_bundle
set MXSPATH=%MXS_CODEROOT%\lib
set MXS_TOOLS=%MXSPATH%\tools
set MXS_STARTUPPATH=%MXSPATH%\_mxsStartup.ms
set MAXEXE="C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe"

:: Set the PYTHONPATH to a clean environment with the bundle namespace as well as the 3dsmax paths
:: You should be able to prepend or append any additional paths here
:: Caret symbol (^) used to split lines
set PYTHONPATH=^
%MXSPATH%\python;^
C:\Program Files\Autodesk\3ds Max 2020;^
C:\Program Files\Autodesk\3ds Max 2020\python;^
C:\Program Files\Autodesk\3ds Max 2020\python\Lib;^
C:\Program Files\Autodesk\3ds Max 2020\scripts\Python

xcopy /s/y "%DEV_PATH%\mxs_bundle\mxs_init.ms" "%LOCALAPPDATA%\Autodesk\3dsMax\2020 - 64bit\ENU\scripts\startup"
xcopy /s/y "%DEV_PATH%\mxs_bundle\mxs_props\MXS_EditorAbbrev.properties" "%LOCALAPPDATA%\Autodesk\3dsMax\2020 - 64bit\ENU\MXS_EditorAbbrev.properties"
xcopy /s/y "%DEV_PATH%\mxs_bundle\mxs_props\MXS_EditorUser.properties" "%LOCALAPPDATA%\Autodesk\3dsMax\2020 - 64bit\MXS_EditorUser.properties"

call %MAXEXE%