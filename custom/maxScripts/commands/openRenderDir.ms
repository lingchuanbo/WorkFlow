if (getfiles (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini")).count == 0 then
	(
		setinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "1" "empty"
	)
global get_totalcmd_dir = getinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "path"

if rendOutputFilename != "" then
	(
		get_open_dir = ("\"" + rendOutputFilename + "\"")
		ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
	)
	else
	(
		messagebox "渲染输出目录为空！"
	)