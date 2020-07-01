rollout FumeFXTools "FumeFX缓存路径更改,输入方式&点选方式" width:300 height:50
(
 	editText etxt_Enter "输入路径\\\\隔开:" 
	button btn_browse "点选目录"
	on etxt_Enter entered txt do
	(
		if selection.count==0 
			then messagebox "请选择FumeFX操作"
		else
		(
			makeDir(txt)all:true
			setPath=txt+"\\a.fxd"
	
			for obj in selection do
			(
				obj.SetPath setPath #("default", "nocheck")
				obj.SetPath setPath #("wavelet", "nocheck")
				obj.SetPath setPath #("retimer", "nocheck")
				obj.SetPath setPath #("illummap", "nocheck")
			)
		)
	)
	
   on btn_browse pressed do
   (

	if selection.count==0 
		then messagebox "请选择FumeFX操作"
	else
	(
		fn getFXLocalPath =
		local getFXLocalPath 
		
		for obj in selection do
		(
			getFXLocalPath =obj.GetPath #default
			
		)
		initialGetDirs = getfilenamepath(getFXLocalPath)

		dir = getSavePath caption:"Select Folder" initialDir:initialGetDirs
		
		if dir != undefined do
		(
			allFiles = getFiles (dir + "\\a.fxd")
			-- print allFiles
			Path = dir + "\\a.fxd"
			for obj in selection do
			(
				obj.SetPath Path #("default", "nocheck")
				obj.SetPath Path #("wavelet", "nocheck")
				obj.SetPath Path #("retimer", "nocheck")
				obj.SetPath Path #("illummap", "nocheck")
			)
		)
	)
   )
 )
createDialog FumeFXTools



