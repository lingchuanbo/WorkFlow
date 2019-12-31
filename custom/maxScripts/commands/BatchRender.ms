try (destroydialog batcRender)catch()

--by HOOLONG 2014.07.03
--update :2014.07.18
-- batchRender
rollout batcRender "BatchRender v1.2" width:1288 height:297
(

    global files
	global sCurrentDateTime
    local syspath
	local theFolder
	local tga
	local opath
	multiListBox lbx1 "Render List" pos:[8,14] width:1272 height:8
	button runrender "render" pos:[1134,243] width:114 height:24 enabled:false toolTip:"Batchrender"
	button btn70 "-" pos:[1263,164] width:20 height:20
	edittext filename "" pos:[18,163] width:1206 height:20
	button btn82 "..." pos:[1242,163] width:20 height:20 toolTip:"renderPath"
	checkbox shut "shutdown" pos:[24,147] width:114 height:15 toolTip:"Shut down the computer after rendering is completed."
	--label lbl25 "shutdown" pos:[24,147] width:149 height:13
	edittext rendername "" pos:[17,211] width:1172 height:20
	button btn19 "..." pos:[1256,211] width:20 height:20 toolTip:"RenderOutPath"
	GroupBox grp4 "RenderOutPath" pos:[5,195] width:1277 height:44
	--label lbl16 "Render Layers" pos:[305,147] width:175 height:13
	checkbox chk_list "Render Layers" pos:[204,147] width:114 height:15 toolTip:"Ignore default first layer the second layer from the start rendering."
	--checkbutton ckb1 "About" pos:[1149,3] width:135 height:20
	dropdownList dd_tga "" pos:[1199,210] width:53 height:22 enabled:false items:#(".tga", ".png", ".exr", ".bmp", ".tif", ".pic", ".jpg", ".avi") selection:1
	button btn17 "Button" pos:[1255,243] width:24 height:24 images:#("CAT_i.bmp", "CAT_i.bmp", 50, 9, 52, 52, 52) toolTip:"Open render Path"
	--HyperLink myhoolong "--hoolongvfx@gmail.com--" pos:[488,250] width:183 height:18 color:(color 0 255 0) hovercolor:(color 0 0 255) address:"https://vimeo.com/hoolong"

	fn pathaa =(
		if keyboard.altPressed then
		(
			try(shellLaunch theFolder "")catch()
		)
		else
		(
			initialPath = if theFolder != undefined then theFolder else maxFilePath
			preFolder = getSavePath caption:"render Folder" initialDir:initialPath
			if preFolder != undefined then
				(
					
				    theFolder = preFolder
					filename.text = randpath = getFilenamePath theFolder +filenameFromPath theFolder  + "\\*.max"
					files =  getFiles  randpath
					
					
					)
					)
					
		) ---
	fn shutdown = (DOSCommand "shutdown -s -t 120")
		
	fn list=( 
		for i = 1 to layerManager.count-1 
				do(for ii =0 to layerManager.count-1 do 
				(layer = layerManager.getLayer ii
				 layer.ishidden =true
				)
	             layer = layerManager.getLayer i
				 layer.ishidden =false
	             dirname = layer.name 
		sDateTime = (dotNetClass "System.DateTime").Now.ToString()
		aTheDateTime = filterString sDateTime "/: "
		if aTheDateTime[1].count  <= 1 then aTheDateTime[1] = "0" + aTheDateTime[1]
		if aTheDateTime[2].count  <= 1 then aTheDateTime[2] = "0" + aTheDateTime[2]
		if aTheDateTime[3].count  <= 1 then aTheDateTime[3] = "0" + aTheDateTime[3]	
		if aTheDateTime[4].count  <= 1 then aTheDateTime[4] = "0" + aTheDateTime[4]
		if aTheDateTime[5].count  <= 1 then aTheDateTime[5] = "0" + aTheDateTime[5]
		sCurrentDateTime = (aTheDateTime[1]+ "_" + aTheDateTime[2]+"_" + aTheDateTime[3] + "_"  + aTheDateTime[4]) as string   

		myname=substring maxfilename 1 (maxfilename.count-4) 
        if maxfilename == ""then(sencename = "δ����")else (sencename = myname)		
		makename = syspath+"\\"+sCurrentDateTime+"\\"+sencename+"\\RenderLayers\\default\\"+dirname
        makedir makename
        opath= makename+"\\"+dirname
        renderpath =opath+tga
        renderSceneDialog.close()
        rendSaveFile = true		
        rendOutputFilename = renderpath	
		passname = syspath+"\\"+sCurrentDateTime+"\\"+sencename+"\\RenderLayers\\"+"RenderPass\\"+dirname				
        re = maxOps.GetCurRenderElementMgr()
        cc = re.NumRenderElements()	
	    if 	cc>0 do (   for i =0 to (cc-1) do 
	    (a =re.GetRenderElement i
	    c = a as string
	    n = substring c  17 (c.count-15)
	    makefile =	passname + "\\"+n as string
	    makedir makefile
	    re.SetRenderElementFilename  i  (makefile+"\\"+n+"_"+tga)))
	    max quick render
	    max file save
	    print maxfilename
	               )
	

          )
	on lbx1 doubleClicked val do
	( try(file = lbx1.selection
	  subname = file  as string
	  shuzi =  substring 	subname 3 1 as integer
	  loda =files[shuzi]
	  loadMAXFile loda 
	  max render scene
		format "openSucced: %\n" loda)catch()
	)--
	on lbx1 rightClick do
	(
		 try( file = lbx1.selection
		  subname = file  as string
		  shuzi =  substring 	subname 3 1 as integer
		  loda =files[shuzi]
		  renderSceneDialog.close()
		  savemaxfile loda
		  format "SaveSucced: %\n" loda)catch()
	)--
	on runrender pressed do
	(
		if sCurrentDateTime ==undefined do ( sDateTime = (dotNetClass "System.DateTime").Now.ToString()
		aTheDateTime = filterString sDateTime "/: "
		if aTheDateTime[1].count  <= 1 then aTheDateTime[1] = "0" + aTheDateTime[1]
		if aTheDateTime[2].count  <= 1 then aTheDateTime[2] = "0" + aTheDateTime[2]
		if aTheDateTime[3].count  <= 1 then aTheDateTime[3] = "0" + aTheDateTime[3]	
		if aTheDateTime[4].count  <= 1 then aTheDateTime[4] = "0" + aTheDateTime[4]
		if aTheDateTime[5].count  <= 1 then aTheDateTime[5] = "0" + aTheDateTime[5]
		sCurrentDateTime = (aTheDateTime[1]+ "_" + aTheDateTime[2]+"_" + aTheDateTime[3] + "_"  + aTheDateTime[4]) as string   
	)
	  
	  if syspath == undefined do (syspath =rendername.text)
		
		
	try (if chk_list.checked ==true then (for f in files do(loadMAXFile f;list()))
		else(for f in files do (
	loadMAXFile f 
	sDateTime = (dotNetClass "System.DateTime").Now.ToString()
		aTheDateTime = filterString sDateTime "/: "
		if aTheDateTime[1].count  <= 1 then aTheDateTime[1] = "0" + aTheDateTime[1]
		if aTheDateTime[2].count  <= 1 then aTheDateTime[2] = "0" + aTheDateTime[2]
		if aTheDateTime[3].count  <= 1 then aTheDateTime[3] = "0" + aTheDateTime[3]	
		if aTheDateTime[4].count  <= 1 then aTheDateTime[4] = "0" + aTheDateTime[4]
		if aTheDateTime[5].count  <= 1 then aTheDateTime[5] = "0" + aTheDateTime[5]
		sCurrentDateTime = (aTheDateTime[1]+ "_" + aTheDateTime[2]+"_" + aTheDateTime[3] + "_"  + aTheDateTime[4]) as string 		
	myname=substring maxfilename 1 (maxfilename.count-4) 
	if maxfilename == ""then(sencename = "δ����")else (sencename = myname)
	--syspath = getdir #renderoutput + "\\"
	makename = syspath+"\\"+sCurrentDateTime+"\\"+sencename+"\\default"
	makedir makename
	opath= makename+"\\"+sencename	
	if tga ==undefined do (tga = ".tga")
	renderpath =opath+"_"+tga
	renderSceneDialog.close()
	rendSaveFile = true		
	rendOutputFilename = renderpath	
	passname = syspath+"\\"+sCurrentDateTime+"\\"+sencename+"\\"+"RenderPass"		
	
	re = maxOps.GetCurRenderElementMgr()
	cc = re.NumRenderElements()	
	if 	cc>0 do (   for i =0 to (cc-1) do 
	(a =re.GetRenderElement i
	c = a as string
	n = substring c  17 (c.count-15)
	makefile =	passname + "\\"+n as string
	makedir makefile
	re.SetRenderElementFilename  i  (makefile+"\\"+n+tga)))
	max quick render
	max file save
	
	print maxfilename))
	)catch()
	
	if shut.checked==true do (shutdown())
	)
	on btn70 pressed do
	(  try( a=  lbx1.selection 
		c =a as string
		d= (substring c 3 1) as integer
	
	    
	    deleteItem files d
		lbx1.items = files
	    if  files[1]==undefined then (runrender.enabled=false)else(runrender.enabled =true))
		catch()
	
	)
	on btn82 pressed do
	(pathaa()
	lbx1.items = files
	if files[1]==undefined then(runrender.enabled =false)else(runrender.enabled =true)
	)
	on btn19 pressed do
	(
	 try(syspath =getSavepath  caption:"Save File"
	rendername.text = syspath;dd_tga.enabled = true)catch()
	
	)
	on chk_list changed state do
	(
	if chk_list.checked == false do(rendername.text ="";syspath=undefined;dd_tga.enabled = false)
	
	)
	on ckb1 changed state do
	(
	if ckb1.checked ==true do (createdialog help 160 122 1200 200)
	if ckb1.checked ==false do (destroydialog help)
	)
	on dd_tga selected sel do
	(
		sDateTime = (dotNetClass "System.DateTime").Now.ToString()
		aTheDateTime = filterString sDateTime "/: "
		if aTheDateTime[1].count  <= 1 then aTheDateTime[1] = "0" + aTheDateTime[1]
		if aTheDateTime[2].count  <= 1 then aTheDateTime[2] = "0" + aTheDateTime[2]
		if aTheDateTime[3].count  <= 1 then aTheDateTime[3] = "0" + aTheDateTime[3]	
		if aTheDateTime[4].count  <= 1 then aTheDateTime[4] = "0" + aTheDateTime[4]
		if aTheDateTime[5].count  <= 1 then aTheDateTime[5] = "0" + aTheDateTime[5]
		sCurrentDateTime = (aTheDateTime[1]+ "_" + aTheDateTime[2]+"_" + aTheDateTime[3] + "_"  + aTheDateTime[4]) as string 		
	    myname=substring maxfilename 1 (maxfilename.count-4) 
	    if maxfilename == ""then(sencename = "δ����")else (sencename = myname)
		makename = syspath+"\\"+sCurrentDateTime+"\\"+sencename+"\\default"
		tga = dd_tga.items[dd_tga.selection] as string
		--makedir makename
		opath= makename+"\\"+sencename	
	    renderpath =opath+tga
		renderpath =opath+"_"+tga
		rendOutputFilename = renderpath	
		print tga
		print renderpath)
	on btn17 pressed do
	(
	try (shelllaunch syspath "") catch()
	)
)

createdialog batcRender

rollout help "About" width:162 height:122
(
	label lbl1 "BatchRender v1.1" pos:[33,75] width:87 height:15
	HyperLink vimeo "vimeo" pos:[24,22] width:28 height:15 color:(color 0 255 0) hovercolor:(color 0 0 255) address:"https://vimeo.com/hoolong"  
  
  
	HyperLink script "myMAXscripts" pos:[24,44] width:66 height:15 color:(color 0 255 0) hovercolor:(color 0 0 255) address:"http://www.scriptspot.com/users/hoolong"  
  
	label lbl9 "--hoolongvfx@gmail.com--" pos:[16,95] width:129 height:18

)
	
