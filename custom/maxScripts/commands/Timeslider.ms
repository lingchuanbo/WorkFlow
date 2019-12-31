(if atime != undefined do (try(cui.unRegisterDialogBar atime;destroydialog  atime)catch())
	
		
rollout atime "HOOLONG" width:1884 height:35
(

	
	label lbl1 "Start Time" pos:[766,6] width:51 height:17
	spinner spn1 "" pos:[820,6] width:70 height:16 range:[-1e+008,1e+008,0] type:#integer scale:1 
 
 
 
 
 
 
 
	label lbl2 "End Time" pos:[903,6] width:48 height:17
	spinner spn2 "" pos:[951,5] width:70 height:16 range:[-1e+008,1e+008,100] type:#integer scale:1 
 
 
 
 
 
 
 
	spinner rate "FPS" pos:[1043,6] width:81 height:16 range:[0,4800,0] type:#integer scale:1 
 
 
 
 
 
 
 
	checkbox rdo1 "Real Time" pos:[1132,6] width:64 height:16 checked:true  
  
  
  
  
  
  
  
	checkbox rdo2 "Loop" pos:[1201,6] width:47 height:16 checked:true 	
 	
 	
 	
 	
	label lbl3 "length:" pos:[1261,7] width:92 height:13
 	
	label lbl4 "FrameCount:" pos:[1363,7] width:107 height:13
 	
	
	fn  initial = (
						   Rate.value = frameRate
						   spn1.value = animationRange.start as time
			               spn2.value = animationRange.End as time
						   rdo1.checked = realTimePlayback
		                   rdo2.checked = timeConfiguration.playbackLoop
							vuale = (spn2.value - spn1.value) as string
							vuale1 =((spn2.value - spn1.value)+1 )as string
						   lbl3.caption ="Length:"+vuale
							lbl4.caption ="FrameCount:"+vuale1
	)

	fn ReupDate = (
	
	oo = sliderTime = animationRange.start
	if oo != undefined do ( 
						   Rate.value = frameRate
						   spn1.value = animationRange.start as time
			               spn2.value = animationRange.End as time
						   rdo1.checked = realTimePlayback
		                   rdo2.checked = timeConfiguration.playbackLoop ) 
	
	)

	 
	
	
								

	
	


	on atime open do
	(                    
		
	try(
		 	
	unregisterRedrawViewsCallback  initial 
	
	registerRedrawViewsCallback  initial
		
		
		
		
		
		
		)catch()
			
	
	)
	on spn1 changed val do
	(
	try (if spn1.value == spn2.value then  ( spn2.value=spn1.value+100;animationRange = interval spn1.value spn2.value)else (animationRange = interval spn1.value spn2.value)
		if spn1.value > spn2.value then  ( spn2.value=spn1.value+100;animationRange = interval spn1.value spn2.value)else (animationRange = interval spn1.value spn2.value)
		
	format  "Start Time:%\n"  animationRange.start 
	format  "End Time:%\n"  animationRange.end) 
	catch(animationRange = interval animationRange.start animationRange.End
			spn1.value = animationRange.start
			spn2.value = animationRange.End)
	
	)
	on spn2 changed val do
	(	try (if spn2.value == spn1.value then  ( spn1.value=spn2.value-100;animationRange = interval spn1.value spn2.value)else (animationRange = interval spn1.value spn2.value)
			                             sliderTime =spn1.value = animationRange.start
			                             format  "Start Time:%\n"  animationRange.start 
										 format  "End Time:%\n"  animationRange.end) 
										 catch(animationRange = interval animationRange.start animationRange.End
	  										 spn1.value = animationRange.start
											 spn2.value = animationRange.End)
								)
	on rate changed val do
	(	try (frameRate=Rate.value;animationRange = interval spn1.value spn2.value; format  "FPS:%\n"  Rate.value) catch()
								)
	on rdo1 changed stat do
	(
	
	try( if rdo1.checked ==true  then (realTimePlayback = true;format  "RealTimePlayback:%\n"   rdo1.checked )else (realTimePlayback = false; format "RealTimePlayback:%\n"  rdo1.checked))catch()
	
	)
	on rdo2 changed stat do
	(
	
	try( if rdo2.checked ==true  then (timeConfiguration.playbackLoop  = true;format  "PlaybackLoop:%\n"   rdo2.checked )else (timeConfiguration.playbackLoop = false; format "PlaybackLoop:%\n"  rdo2.checked))catch()
	
	)
)
createdialog atime 1520 30 style:#(#style_titlebar, #style_border, #style_sysmenu, #style_minimizebox)
cui.RegisterDialogBar atime style:#(#cui_dock_bottom, #cui_floatable, #style_toolwindow)
cui.DockDialogBar atime #cui_dock_bottom
--cui.getExpertMode() 
--updateToolbarButtons()

)
