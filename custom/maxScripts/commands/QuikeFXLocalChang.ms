fn replaceSub str1 str2 str3=(
    while ((i=findstring str1 str2) != undefined) do
    (
        str1 = replace str1 i str2.count str3
    )
    return str1
)

-- theName = "00000"

-- Prefix = ".tga"

str=maxfilename

strName=replaceSub str ".max" ""+"\\"

outPutDir=maxfilepath + strName +"FumeFXdate"
-- 创建文件夹
-- makeDir outPutDir
if selection.count==0 
	then messagebox "请选择FumeFX操作"
else
(
	makeDir(outPutDir+"\\"+"default")all:true
    makeDir(outPutDir+"\\"+"wavelet")all:true
    makeDir(outPutDir+"\\"+"retimer")all:true
    makeDir(outPutDir+"\\"+"illummap")all:true

	setPathDefault=outPutDir+"\\"+"default"+"\\a.fxd"
    setPathWavelet=outPutDir+"\\"+"wavelet"+"\\a.fxd"
    setPathRetimer=outPutDir+"\\"+"retimer"+"\\a.fxd"
    setPathIllummap=outPutDir+"\\"+"illummap"+"\\a.fxd"
	
	for obj in selection do
	(
		obj.SetPath setPathDefault #("default", "nocheck")
		obj.SetPath setPathWavelet #("wavelet", "nocheck")
		obj.SetPath setPathRetimer #("retimer", "nocheck")
		obj.SetPath setPathIllummap #("illummap", "nocheck")
	)
)

-- outPutFiledir =  maxfilepath + strName + theName + Prefix 

-- rendOutputFileName = outPutFiledir


-- rollout FumeFXTools "FumeFX缓存路径更改,输入方式&点选方式" width:300 height:50
-- (
--  	editText etxt_Enter "输入路径\\\\隔开:" 
-- 	button btn_browse "点选目录"
-- 	on etxt_Enter entered txt do
-- 	(
-- 		if selection.count==0 
-- 			then messagebox "请选择FumeFX操作"
-- 		else
-- 		(
-- 			makeDir(txt)all:true
-- 			setPath=txt+"\\a.fxd"
	
-- 			for obj in selection do
-- 			(
-- 				obj.SetPath setPath #("default", "nocheck")
-- 				obj.SetPath setPath #("wavelet", "nocheck")
-- 				obj.SetPath setPath #("retimer", "nocheck")
-- 				obj.SetPath setPath #("illummap", "nocheck")
-- 			)
-- 		)
-- 	)
	
--    on btn_browse pressed do
--    (

-- 	if selection.count==0 
-- 		then messagebox "请选择FumeFX操作"
-- 	else
-- 	(
-- 		fn getFXLocalPath =
-- 		local getFXLocalPath 
		
-- 		for obj in selection do
-- 		(
-- 			getFXLocalPath =obj.GetPath #default
			
-- 		)
-- 		initialGetDirs = getfilenamepath(getFXLocalPath)

-- 		dir = getSavePath caption:"Select Folder" initialDir:initialGetDirs
		
-- 		if dir != undefined do
-- 		(
-- 			allFiles = getFiles (dir + "\\a.fxd")
-- 			-- print allFiles
-- 			Path = dir + "\\a.fxd"
-- 			for obj in selection do
-- 			(
-- 				obj.SetPath Path #("default", "nocheck")
-- 				obj.SetPath Path #("wavelet", "nocheck")
-- 				obj.SetPath Path #("retimer", "nocheck")
-- 				obj.SetPath Path #("illummap", "nocheck")
-- 			)
-- 		)
-- 	)
--    )
--  )
-- createDialog FumeFXTools



