@echo off
echo 
echo .---1.如果你的3DsMax是安装在默认目录(C:\Program Files\Autodesk\3ds Max 20**)，那么请继续，如果不是请关闭更改路径！
echo .
echo .---2.3DsMax目前支持2014-2020，如需添加请用文本格式打开添加！
echo .
echo .---3.确定了？那么按【回车】继续！
echo .
echo .
echo .
pause

echo.
if exist "C:\Program Files\Autodesk\3ds Max 2014\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2014\scripts\Startup"
if exist "C:\Program Files\Autodesk\3ds Max 2015\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2015\scripts\Startup"
if exist "C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2016\scripts\Startup"
if exist "C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2017\scripts\Startup"
if exist "C:\Program Files\Autodesk\3ds Max 2018\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2018\scripts\Startup"
if exist "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2019\scripts\Startup"
if exist "C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe" xcopy /y /e "%~dp0\custom\maxScripts\Startup\*" "C:\Program Files\Autodesk\3ds Max 2020\scripts\Startup"
echo.
REM echo.
REM if not exist "C:\Program Files\Autodesk\3ds Max 2014\3dsmax.exe" echo "没找到 3ds Max 2014  未安装"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2015\3dsmax.exe" echo "没找到 3ds Max 2015  未安装"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe" echo "没找到 3ds Max 2016  未安装"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe" echo "没找到 3ds Max 2017  未安装"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2018\3dsmax.exe" echo "没找到 3ds Max 2018  未安装"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" echo "没找到 3ds Max 2019  未安装"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe" echo "没找到 3ds Max 2020  未安装"
REM echo.
echo.
echo -------------------匹配成功         
echo.

if exist "C:\Program Files\Autodesk\3ds Max 2014\3dsmax.exe" echo "----------3ds Max 2014 匹配成功"
if exist "C:\Program Files\Autodesk\3ds Max 2015\3dsmax.exe" echo "----------3ds Max 2015 匹配成功"
if exist "C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe" echo "----------3ds Max 2016 匹配成功"
if exist "C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe" echo "----------3ds Max 2017 匹配成功"
if exist "C:\Program Files\Autodesk\3ds Max 2018\3dsmax.exe" echo "----------3ds Max 2018 匹配成功"
if exist "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" echo "----------3ds Max 2019 匹配成功"
if exist "C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe" echo "----------3ds Max 2020 匹配成功"

REM if not exist "C:\Program Files\Autodesk\3ds Max 2014\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2014 目录"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2015\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2015 目录"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2016\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2016 目录"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2017\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2017 目录"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2018\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2018 目录"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2019\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2019 目录"
REM if not exist "C:\Program Files\Autodesk\3ds Max 2020\3dsmax.exe" echo "没找到 C:\Program Files\Autodesk\3ds Max 2020 目录"
echo.
echo -------------------重要事情说 5 遍
echo.
echo ----------请重启 3DsMax 生效
echo ----------请重启 3DsMax 生效
echo ----------请重启 3DsMax 生效
echo ----------请重启 3DsMax 生效
echo ----------请重启 3DsMax 生效
echo.

pause