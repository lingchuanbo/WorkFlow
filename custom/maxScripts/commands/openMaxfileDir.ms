if (getfiles (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini")).count == 0 then
	(
		setinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "1" "empty"
	)
global get_totalcmd_dir = getinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "path"
	
if maxfilepath != "" then
	(
		get_open_dir = ("\"" + maxfilepath + maxfilename + "\"")
		ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
	)
	else
	(
		messagebox "请先保存文件！"
	)