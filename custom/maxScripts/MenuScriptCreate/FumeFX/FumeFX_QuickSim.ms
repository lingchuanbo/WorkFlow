/*
/* FumeFX QuickSim v1.0
Created:      July  04, 2014
Author :  HOOLONG (hoolongvfx@gmail.com)

*/
-- macroScript FFX_QuickSim
-- 	category:"HOOLONG_VFX"
-- 	buttonText:"QuickSim "
-- 	tooltip:"QuickSim by-HOOLONG"
-- 	icon:#("QuickSim",1)
-- (

if QuickSim==undefined then (try (destroydialog  QuickSim )catch())
	else(try(cui.unRegisterDialogBar QuickSim)
		 catch()
		destroydialog  QuickSim)




rollout QuickSim "FumeFX QuickSim" width:150 height:434
(
	
	global fstart =animationrange.start
	global fend = animationrange.end
	global  i=0
	global theList = #()
	global randpath
	local TempMaxFiles = #()
	 
	fn fumeFilt obj = classOf obj == FumeFX
	fn listHeight =
	(
		h =
		(
			case (sysInfo.getLanguage())[1] of
			(
				9: 13 -- English (US)
				17: 12 -- Japanese (Nihonggo)
				default: 13
			)
		)
		-- [base size (43)] + [OS dependent height] + [item count]
		listH = 43 + h * 10
	)


	
---button 

	checkbox chk_d "" pos:[61,224] width:15 height:15 checked:true toolTip:"Deafuel Sim"
	checkbox chk_dw "" pos:[125,224] width:15 height:15 toolTip:"Deafuel Sim + Wavelet Sim"
	checkbox chk_dwp "" pos:[61,239] width:15 height:15 toolTip:"Deafuel Sim + Wavelet Sim + Retime"
	checkbox chk_w "" pos:[125,239] width:15 height:15 enabled:true checked:false toolTip:"Wavelet Sim"
	checkbox chk_P "" pos:[125,254] width:15 height:15 enabled:true checked:false toolTip:"Retime"

	checkbox chk_r "" pos:[61,269] width:15 height:15 enabled:true checked:false
	checkbox chk_wp "" pos:[61,254] width:15 height:15 enabled:true checked:false toolTip:"Wavelet Sim + Retime"
 
	label l_dw "D+W" pos:[83,224] width:31 height:15
	label l_dwp "D+W+P" pos:[10,239] width:46 height:15
	label l_w "W" pos:[83,239] width:15 height:15 enabled:true 
	label l_d "D" pos:[10,224] width:15 height:15 
	
	label lbl8 "W+P" pos:[10,254] width:32 height:15 enabled:true
	label lbl9 "R" pos:[10,269] width:32 height:15 enabled:true

	button b_QuickSim "QuickSim" pos:[10,3] width:101 height:15 toolTip:"QuickSim by-HOOLONG"
	button b_X "X" pos:[130,3] width:15 height:15
	button b_ "-" pos:[113,3] width:15 height:15
	GroupBox grp1 "Sim" pos:[6,211] width:140 height:103
	-- label lbl7 "Shutdown" pos:[10,284] width:50 height:15 enabled:true
	-- checkbox chk_shutdown "" pos:[61,284] width:15 height:15 enabled:true checked:false
		
	edittext upathname "" pos:[9,366] width:100 height:15
	button btn1 "..." pos:[118,366] width:20 height:15 toolTip:"Render Path"
	spinner width "" pos:[61,321] width:77 height:16 range:[0,10000,960] type:#integer
	spinner height "" pos:[62,343] width:76 height:16 range:[0,10000,540] type:#integer
	label lbl13 "width:" pos:[12,321] width:33 height:19
	label lbl14 "height:" pos:[12,343] width:36 height:19
	label lbl187 "P" pos:[83,254] width:15 height:15 enabled:true
	
	button btn18 "set Cache" pos:[138,567] width:54 height:14
	edittext filename "" pos:[131,527] width:111 height:15
	button btn111 "+" pos:[197,567] width:15 height:14
	dropdownList fumeFlist "DropDownList" pos:[20,526] width:68 height:41 
 
 
 
 
 
	button btn196 "rf" pos:[215,568] width:28 height:11
	label fumedata "" pos:[17,572] width:104 height:16 enabled:false
	GroupBox grp_list "FumeFX List:" pos:[5,20] width:140 height:190
	dotNetControl lb_list "System.Windows.Forms.Listbox" pos:[10,35] width:130 height:173
	button btn_add "+" pos:[10,185] width:25 height:20 toolTip:"Add FumeFX Grid(s)"
	button btn_del "-" pos:[35,185] width:25 height:20 toolTip:"Remove selected FumeFX Grid(s)"
	button btn_up "Up" pos:[60,185] width:40 height:20 toolTip:"Move selected UP"
	button btn_down "Down" pos:[100,185] width:40 height:20 toolTip:"Move selected DOWN"
	GroupBox grp_net "" pos:[5,312] width:140 height:77
	button btn_exe "Simulate" pos:[5,391] width:140 height:25 enabled:false
	label lbl73 "preview" pos:[83,269] width:41 height:15 enabled:true
	checkbox chk_preview "" pos:[125,269] width:15 height:15 enabled:true checked:false
	button render "Dialog" pos:[105,299] width:36 height:16 toolTip:"render dialog"
	button btn14 "FxDate" pos:[57,299] width:46 height:16 toolTip:"Open FumeFX_Data Path"
 



   fn resizeRollout state =
	(
		fumeFXPartitioner.fumeFXPartitionerResize ((if state then 1 else -1) * QuickSim.height)
	)
	
	fn netUI state = 
	(
		con = QuickSim.controls
		count = con.count
		for i in 10 to count do
		(
			con[i].enabled = state
		)
		btn_exe.caption = if state then "Send Simulation" else "Simulate Locally"
	)
	
		fn updateList =
	(
		theList = for i in theList where isValidNode i collect i
		theItems = for i in theList collect dotNetObject "System.String" i.name
		lb_list.Items.clear()
		lb_list.Items.AddRange theItems
		
		btn_exe.enabled = theItems.count != 0
	)
	
	fn checkList =
	(
		try(callbacks.removeScripts #nodePostDelete id:#fumeFXPartitionerDelete_cb)catch()
		callbacks.addscript #nodePostDelete "QuickSim.updateList()" id:#fumeFXPartitionerDelete_cb
	)

	
	
	fn theFilt obj =
	(   
		fumeFilt obj and findItem theList Obj == 0
	)
	
	
	
	fn leadZero val =
	(
		val = val as string
		if val.count == 1 do val = "0" + val
		val
	)
	
	fn timeFormat t =
	(
		preSecs = t/1000
		preMins = preSecs/60
		preHours = preMins/60
		preDays = preHours/24
		
		theSecs = leadZero ((mod preSecs 60) as integer)
		theMins = leadZero ((mod preMins 60) as integer)
		theHours = leadZero ((mod preHours 60) as integer)
		theHours as string + ":" + theMins as string + ":" + theSecs as string
	)
	
	fn simfolder = (
		
	
for i = 1 to theList.count do
(
	
	sTheCurrentFfxGrid = theList[i] 
		if sTheCurrentFfxGrid.EditUI == true then
		(
			actionMan.executeAction 12121256 "40011" 
		)

		if maxFileName != "" then sCurrentOpenFileName = maxFileName else sCurrentOpenFileName = "Untitled"
		sParseFileName = filterstring sCurrentOpenFileName "."
		sNewFileName = sParseFilename[1]
		sDateTime = (dotNetClass "System.DateTime").Now.ToString()
		aTheDateTime = filterString sDateTime "/: "
		if aTheDateTime[1].count  <= 1 then aTheDateTime[1] = "0" + aTheDateTime[1]
		if aTheDateTime[2].count  <= 1 then aTheDateTime[2] = "0" + aTheDateTime[2]
		if aTheDateTime[3].count  <= 1 then aTheDateTime[3] = "0" + aTheDateTime[3]	
		if aTheDateTime[4].count  <= 1 then aTheDateTime[4] = "0" + aTheDateTime[4]
		if aTheDateTime[5].count  <= 1 then aTheDateTime[5] = "0" + aTheDateTime[5]
		sCurrentDateTime = (aTheDateTime[1]+ "_" + aTheDateTime[2]+"_" + aTheDateTime[3] + "_"  + aTheDateTime[4] + aTheDateTime[5]) as string
		sFumeFxNodeName = sTheCurrentFfxGrid.name as string
		sOutputDefaultPath = (getINISetting(getdir #maxroot + "\plugins\Afterworks\FumeFX\FumeFX.ini") "General" "DefaultOutputPath") 

		try
		(	----------------------------------------
			--This method is for FumeFX 2.x----
			----------------------------------------
			if sOutputDefaultPath == "C:\\" and "D:\\" and "E:\\" and "F:\\" and "G:\\" and "H:\\" and "I:\\" and "J:\\" and "K:\\" and "L:\\" and "M:\\" and "N:\\" \
			and "N:\\" and "P:\\" and "Q:\\" and "R:\\" and "S:\\" and "T:\\" and "U:\\" and "V:\\" and "W:\\" and "X:\\" and "Y:\\" and "Z:\\" then
			(
				sNewOutputDefaultPath = sOutputDefaultPath  + sNewFileName + "\\" as string
			)
			else
				(
					sNewOutputDefaultPath = sOutputDefaultPath + "\\" + sNewFileName + "\\" as string
				)
			)
			catch
				(
					----------------------------------------
					--This method is for FumeFX 1.x----
					------------------------------------------
					if sOutputDefaultPath == "C:\\" or "D:\\" or "E:\\" or "F:\\" or "G:\\" or "H:\\" or "I:\\" or "J:\\" or "K:\\" or "L:\\" or "M:\\" or "N:\\" \
					or "N:\\" or "P:\\" or "Q:\\" or "R:\\" or "S:\\" or "T:\\" or "U:\\" or "V:\\" or "W:\\" or "X:\\" or "Y:\\" or "Z:\\" then
					(
						sNewOutputDefaultPath = sOutputDefaultPath  + sNewFileName + "\\" as string
					)
					else
						(
							sNewOutputDefaultPath = sOutputDefaultPath + "\\" + sNewFileName + "\\"as string
						)
				)
			
		sOutputFormat = "_.fxd" as string
		sNewFolderName = sCurrentDateTime as string
		sNewOutputName =  sFumeFxNodeName + sOutputFormat as string	
		sFinalOutputPath = sNewOutputDefaultPath + sNewFolderName + "\\" as string
		sSetPathAndName = sNewOutputDefaultPath + sNewFolderName+ "\\"+sFumeFxNodeName+"\\"+sNewOutputName as String
		makeDir (sNewOutputDefaultPath + sNewFolderName+ "\\"+sFumeFxNodeName) all:true
		sTheCurrentFfxGrid.SetPath sSetPathAndName #default
	)
	
	
	
	
		
		
		
		
		)--thank  you John Rand (littl3fish@gmail.com)
	




--fnction 


	fn pathaa =(
		if keyboard.altPressed then
		(
			try(shellLaunch theFolder "")catch()
		)
		else
		(  try(
			initialPath = if theFolder != undefined then theFolder else maxFilePath
			preFolder = getsaveFileName caption:"Set FumeFX cache Folder" types:"FumeFX cache(*.fxd)"
			if preFolder != undefined then
			(
				
				    theFolder = preFolder
					filename.text = randpath = getFilenamePath theFolder 
					namepath =getFilenamePath theFolder +filenameFromPath theFolder 
				    ss =getFilenamePath theFolder +filenameFromPath theFolder  + "\\*"
					a = getFilenameFile ss
					)
)	catch()	)
		) 
					 						  
	
		
	fn palystart =(for i = 1 to theList.count do
		(
						sf= theList[i].startframe 
						ef=theList[i].endframe
						 theList[i].Playto = ef
                         theList[i].PlayFrom = sf
                         theList[i].offset = sf
					theList[i].PreviewStart = sf
                   theList[i].PreviewEnd = ef
						 						  
		)
	                   
                      )	
		
    fn selectcache = (try(theList[i].SelectedCache = 1)catch(messagebox "Please set Retime")) --ѡ�񻺴�wavelet	
    
	fn wavelet = (  for i =1 to theList.count do (theList[i].ExtraDetailType = 2)
		   ) -- ���ÿ�ʼ���ν���
	
	fn runrender = (
		
	rendSaveFile = true
	rendTimeType  =2 
	rendStart = fstart
	rendEnd  =fend
	renderWidth=width.value
	renderHeight=height.value
	rendFieldRender =true
	max quick render
		       ) -- ������Ⱦ������ʼ��Ⱦ
			   
	
	fn FumeFXplay_Path = (  a = getDir #preview 
							 playpath2=   a +"\*_ffx.avi"
		                   -- playpath = theList[i].GetPath  "default" +".avi"
                            try (shellLaunch playpath2 "/play /loop")catch()
                             )
    
	

					  
	fn palypreview = ( for i = 1 to theList.count do
		                    (aa =theList[i].startframe
		                    bb = theList[i].endframe
						   theList[i].MakePreview aa bb 4  400)
						   
						  )	--FumeFX make preview	  
						  
					  
	fn sim_d = (  for i = 1 to theList.count do(theList[i].RunSimulation 0)
		          ) --Default Simulation
			

	fn sim_w = ( for i = 1 to theList.count do (theList[i].RunSimulation 2)
		        ) -- Wavelet Simulation	
		
        
	fn sim_P = ( for i = 1 to theList.count do (theList[i].RunSimulation 3)
		        ) --retime		
					  				 
	fn shutdown = (cmd ="shutdown -s -t 60"
                        DOSCommand cmd ) --Shutdown
    
    fn savefile = (if maxFileName != "" then (
        max saveplus
        TheFile = maxFilePath + (trimRight (getFilenameFile maxFileName) "1234567890") + ".max"
        if doesFileExist TheFile do deleteFile TheFile
        copyFile (maxFilePath + maxFileName) TheFile
    ) else checkForSave())--Savefile


	
	
	
      
	
	



--execute				  
	 
	 
	
	
	
	
	
	

	
	
	
	
	
	

	on QuickSim open do
	(
	 
		lb_list.SelectionMode = lb_list.SelectionMode.MultiExtended
		lb_list.HorizontalScrollbar = true
		try(callbacks.removeScripts #systemPostNew id:#fumeFXPartitionerNew_cb)catch()
		callbacks.addscript #systemPostNew "QuickSim.updateList()" id:#fumeFXPartitionerNew_cb
		try(callbacks.removeScripts #systemPostReset id:#fumeFXPartitionerReset_cb)catch()
		callbacks.addscript #systemPostReset "QuickSim.updateList()" id:#fumeFXPartitionerReset_cb
	 )--quicksim open do
	on QuickSim close do
	(
		
		try(callbacks.removeScripts #systemPostNew id:#fumeFXPartitionerNew_cb)catch()
		try(callbacks.removeScripts #systemPostReset id:#fumeFXPartitionerReset_cb)catch()		
		try(callbacks.removeScripts #nodePostDelete id:#fumeFXPartitionerDelete_cb)catch()
	)
	on chk_dw changed state do
	(
	
		if chk_dw.checked == true then (  chk_d.checked =false
										  chk_dwp.checked =false
										  chk_wp.checked =false
											chk_w.checked=false
			                                chk_p.checked=false
				                           )			  
						
		
	
	)-- chk_dw
	on chk_dwp changed state do
	(
	
		if chk_dwp.checked == true then ( chk_dw.checked =false
				                            chk_d.checked =false
											chk_wp.checked =false
											chk_w.checked=false
											chk_p.checked=false
				                           )			  
						
		
	
	)
	on chk_w changed state do
	(
	
		if chk_w.checked == true then ( chk_dw.checked =false
				                            chk_dwp.checked =false
											chk_wp.checked =false
											chk_d.checked=false
			                                chk_p.checked=false
				                           )			  
						
		
	
	
	
	
	)
	on chk_d changed state do
	(
		if chk_d.checked == true then (     chk_dw.checked =false
				                            chk_dwp.checked =false
											chk_wp.checked =false
											chk_w.checked=false
			                                chk_p.checked=false
				                           )			  
						
		
	
	)
	on chk_wp changed state do
	(
		if chk_wp.checked == true then ( chk_dw.checked =false
				                            chk_dwp.checked =false
											chk_d.checked =false
											chk_w.checked=false
			                                chk_p.checked=false
				                           )			  
						
		
	
	)
	on b_X pressed do
	(
			try(cui.unRegisterDialogBar QuickSim)
		    catch()
		
		
			destroydialog   QuickSim
		
		
	)
	on b_ pressed do
		(try (cui.unRegisterDialogBar QuickSim)catch())
	on chk_shutdown changed state do
	(
		
		)
	on btn1 pressed do
	(
		
	try (rendername =getSaveFilename  caption:"Save File"
	
	rendOutputFilename = rendername
	upathname.text = rendername)catch()
		
	
	
	
	)
	on chk_P changed state do
	(
	
		if chk_p.checked == true then (    chk_dw.checked =false
				                            chk_dwp.checked =false
											chk_wp.checked =false
											chk_d.checked=false
			                                chk_w.checked=false
				                           )			  
						
		
	
	
	
	
	)
	on btn18 pressed do
		(pathaa()
	
	
	)
	on btn111 pressed do
	(   
	       
	    count = theList.count
		preSel = lb_list.selectedIndices
		selCount = preSel.count
		theSel = for i in 1 to selCount do
			
		   
		for i in count to 1 do
		(
			if findItem theSel i > 0 do
			(   
				
				
				ccname = #()
				if i != undefined  then (i=0)else (i=i+1 )
				dirfile = randpath +theList[c].name+"V_00"+i  as string
	            makeDir  dirfile
				op = dirfile
	
	            yy=substring op (op.count-4) 5
	             FumeNamePath = randpath+theList[c].name+@"\"+yy+"_.fxd" 
				print  FumeNamePath
		
				preSel.SetPath  FumeNamePath  #(#default ,#match)
			)
		)	
	
	
	 
	)
	on btn196 pressed do
	(
	
	
		for i =1 to  ccname.count do
		( copy ccname
			fumeFlist.items = #(ccname[i])
			)
	)
	on lb_list MouseDoubleClick m do
	(
		dex = (lb_list.SelectedIndex)
		select theList[dex+1]
	)
	on btn_add pressed do
	(
		preList = selectByName title:"Select FumeFX Grid(s)" filter:theFilt
		if preList != undefined do
		(
			for i in preList do
			(
				if findItem theList i == 0 do
				(
					append theList i
				)
			)
			updateList()
			checkList()
		)
	)
	on btn_del pressed do
	(
		count = theList.count
		preSel = lb_list.selectedIndices
		selCount = preSel.count
		theSel = for i in 1 to selCount collect (preSel.item[i-1] + 1)
		for i in count to 1 by -1 do
		(
			if findItem theSel i > 0 do
			(
				deleteItem theList i
			)
		)
		updateList()
		checkList()
	)
	on btn_up pressed do
	(
		count = theList.count
		
		preSel = lb_list.selectedIndices
		selCount = preSel.count
		theSel = for i in 1 to selCount collect (preSel.item[i-1]+1)
		pDex = (amin theSel)
		if pDex == undefined do pDex = 0
		if pDex > 1 do
		(
			tempArr = #()
			for i in theSel do append tempArr theList[i]
			for i in selCount to 1 by -1 do
			(
				deleteItem theList theSel[i]
			)
	
			for i in selCount to 1 by -1 do
			(
				insertItem tempArr[i] theList (pDex-1)
			)
			
			updateList()
			
			for i in 1 to selCount do
			(
				dex = (pDex-1) + (i-1)
				if dex >= 0 do
				(
					lb_list.SetSelected (dex-1) on
				)
			)
		)
	)
	on btn_down pressed do
	(
		count = theList.count
		
		preSel = lb_list.selectedIndices
		selCount = preSel.count
		theSel = for i in 1 to selCount collect (preSel.item[i-1]+1)
		
	-- 		format "%\n" theSel
		pDex = (amax theSel)
		if pDex == undefined do pDex = 0
		if pDex < count  do
		(
			tempArr = #()
			for i in theSel do append tempArr theList[i]
			for i in selCount to 1 by -1 do
			(
				deleteItem theList theSel[i]
			)
			for i in selCount to 1 by -1 do
			(
				insertItem tempArr[i] theList ((pDex-(selCount-1))+1)
			)
			updateList()
	
			for i in 1 to selCount do
			(
				dex = pDex-i+1
				if dex >= 0 do lb_list.SetSelected dex on
			)
		)
	)
	on btn_exe pressed do
	(
	simfolder()
	case of (
	(chk_d.checked == true): (sim_d();palystart();fumeFXplay_Path())
	(chk_dw.checked == true): (wavelet() ;sim_d();sim_w();palystart();fumeFXplay_Path())
	(chk_dwp.checked == true): (wavelet();sim_d();sim_w();selectcache();sim_p();palystart();fumeFXplay_Path())
	(chk_w.checked == true): (wavelet() sim_w();FumeFXplay_Path())
	(chk_wp.checked == true): (wavelet();sim_w();selectcache();sim_p();palystart();FumeFXplay_Path())
	(chk_p.checked == true): (sim_p();palystart();FumeFXplay_Path())	
	default:messagebox "please select!"
	
	
	)
	if chk_preview.checked == true do palypreview()
	if chk_r.checked == true do runrender()
	
	if chk_shutdown.checked ==true do( savefile(); shutdown() )
	
	
	)
	on chk_preview changed state do
	(
		
		)
	on render pressed do
		(max render scene)
	on btn14 pressed do
	( if sOutputDefaultPath ==undefined do ( sOutputDefaultPath = (getINISetting(getdir #maxroot + "\plugins\Afterworks\FumeFX\FumeFX.ini") "General" "DefaultOutputPath"))
	        
	try (shellLaunch sOutputDefaultPath "")catch(messagebox "Has not read data path you mean recognize, first identified.")
	)
)
createdialog  QuickSim


cui.RegisterDialogBar QuickSim style:#(#cui_dock_vert,#cui_floatable,#cui_handles) 

cui.DockDialogBar QuickSim #cui_dock_right

cui.getExpertMode() 
updateToolbarButtons()
-- )