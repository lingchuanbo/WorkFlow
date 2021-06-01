--messageBox "PolyCloth macro has been installed succesfully!\n\nPlease also make sure you have copied the .gup file to your plugins file. Without the .gup file, plugin will not work.\n\nNow you can hit 'X' in your keyboard and then type PolyCloth brushes. Or go to customize menu and assign polycloth to a hotkey or add it to your custom toolbar.\n\n Please check out our other useful plugins from our pages \n\nThanks for purchasing!" beep:false title:"PolyCloth"


/*
PolyCloth V2
Author: Batuhan Ozer (PolyDesign)
You can not edit, redistribute or share this script anywhere. It is protected by a personal license so only the person who bought the plugin is allowed to use it. 
All rights are reserved. PolyDesign
*/


-- macroScript PolyClothBrushes 
-- category:"PolyDesign" 
-- tooltip:"PolyCloth Brushes V2"
--(
	rollout polyclothroll "PolyCloth V2" width:240 height:600
	(
		button 'btn_startbrush' "Start Cloth Brush" pos:[16,24] width:208 height:32 align:#left
		GroupBox 'grp1' "ClothBrush" pos:[8,8] width:224 height:56 align:#left
		GroupBox 'grp2' "Brush Shortcuts" pos:[8,64] width:224 height:40 align:#left
		label 'lbl5' "To See Brush Shortcuts Hover Here" pos:[16,80] width:208 height:16 toolTip:"Move:		 DRAG
Slide:		 CTRL + Drag
Expand:		 CTRL + SHIFT + Drag
Shrink:		 CTRL + ALT + Drag
Smooth:		 SHIFT + Drag
Mask:		 ALT + Drag
Blur Mask:	 ALT + SHIFT + Drag" align:#left
		GroupBox 'grp3' "Simulation Settings" pos:[8,104] width:224 height:232 align:#left
		spinner 'spn_iters' "" pos:[144,128] width:80 height:16 range:[4,1000,20] type:#integer scale:1 align:#left
		label 'lbl8' "Iterations: " pos:[16,128] width:128 height:16 align:#left
		label 'lbl9' "Move Strength:" pos:[16,144] width:128 height:16 align:#left
		spinner 'spn_movestrength' "" pos:[144,144] width:80 height:16 range:[0,1000,3] type:#float scale:0.1 align:#left
		label 'lbl10' "Damping: " pos:[16,160] width:128 height:16 align:#left
		spinner 'spn_Damping' "" pos:[144,160] width:80 height:16 range:[0,1,0.95] type:#float scale:0.01 align:#left
		GroupBox 'grp4' "About PolyDesign" pos:[8,504] width:224 height:88 align:#left
		button 'btn_fb' "Facebook" pos:[120,520] width:104 height:24 align:#left
		button 'btn_yt' "Youtube" pos:[16,544] width:104 height:24 align:#left
		button 'btn_cgt' "Cgtrader" pos:[16,520] width:104 height:24 align:#left
		spinner 'spn_plasticity' "" pos:[144,176] width:80 height:16 range:[0,1,0.1] type:#float scale:0.01 align:#left
		label 'lbl19' "Plasticity:" pos:[16,176] width:128 height:16 align:#left
		label 'lbl20' "Bendiness: " pos:[16,192] width:128 height:16 align:#left
		spinner 'spn_bendiness' "" pos:[144,192] width:80 height:16 range:[0,1,0.1] type:#float scale:0.01 align:#left
		button 'btn_reset' "Reset" pos:[144,304] width:80 height:24 align:#left
		button 'btn_arts' "Artstation" pos:[120,544] width:104 height:24 align:#left
		label 'lbl11' "Label" pos:[88,576] width:0 height:0 align:#left
		label 'lbl12' "Check for more plugins" pos:[56,576] width:120 height:16 align:#left
		
		GroupBox 'grp5' "" pos:[8,368] width:224 height:136 align:#left
		checkbox 'chk_useVCMask' "Use Mask" pos:[16,376] width:88 height:16 checked:false align:#left
		checkbutton 'chk_dispVCs' "Display Mask" pos:[16,392] width:208 height:24 align:#left
		
		GroupBox 'grp7' "" pos:[16,224] width:208 height:72 align:#left
		
		checkbox 'chk_gravity' "Gravity" pos:[24,240] width:120 height:16 align:#left
		checkbox 'chk_pressure' "Pressure" pos:[24,256] width:120 height:16 align:#left
		checkbox 'chk_ground' "Ground Collision" pos:[24,272] width:120 height:16 align:#left
		spinner 'spn_gravity' "" pos:[144,240] width:72 height:16 range:[-100,100,1] type:#float scale:0.1 align:#left
		spinner 'spn_pressure' "" pos:[144,256] width:72 height:16 range:[0.001,100,1] type:#float scale:0.1 align:#left
		
		slider 'sld_maskValue' "" pos:[24,432] width:192 height:25 range:[0,1,1] ticks:20 align:#left
		GroupBox 'grpmask' "Mask Value" pos:[16,416] width:208 height:56 align:#left
		spinner 'spn_maskblur' "Mask Blur Strength: " pos:[140,478] width:80 height:16 range:[0,1,0.2] scale:0.01 align:#right
		
		label 'lbl_cstrength' "Cloth Strength:" pos:[16,208] width:128 height:16 align:#left
		spinner 'spn_clothStrength' "" pos:[144,208] width:80 height:16 range:[0,1,1] scale:0.01 align:#left
		checkbox 'chk_directionalExpand' "Directional Expand" pos:[16,345] width:120 height:16 enabled:true align:#left
		groupBox 'grp_brushsettings' "" pos:[8,336] width:224 height:32 align:#left
		
		
		
		fn setSettings = (
			polycloth.setsettings spn_iters.value spn_movestrength.value spn_Damping.value spn_plasticity.value spn_bendiness.value
		)
		
		fn setSettingsV2 =
		(
			polycloth.setsettingsV2 chk_useVCMask.checked chk_gravity.checked chk_pressure.checked spn_gravity.value spn_pressure.value chk_ground.checked sld_maskValue.value spn_maskblur.value spn_clothStrength.value chk_directionalExpand.checked
		)
		
		on polyclothroll open do
		(
			try(polycloth.setsettingsV2)catch(
				messagebox "Did you forget to replace the .gup file with the old one? Please replace the old file in plugins directory with the new V2 .gup file. After replacing, please restart 3dsmax!"
				destroydialog polyclothroll
			)
			
			licencetext = "
			PolyCloth V2
Author: Batuhan Ozer (PolyDesign)
You can not edit, redistribute or share this script anywhere. It is protected by a personal license so only the person who bought the plugin is allowed to use it. 
All rights are reserved. -PolyDesign
			"
		)
		
		on btn_startbrush pressed do
		(
			setSettings()
			setSettingsV2()
			
			sel = selection as array
			if (sel.count != 1) then
			(
				messagebox "Please select only one object" beep:true
			)else
			(
				chk_dispVCs.checked = $.showVertexColors
				undo "clothbrush" on (
					workingobj = sel[1]
					orig = copy workingobj
					hide orig
					orig.name += "_original"
					workingobj.pivot = [0,0,0]
					resetxform workingobj
					converttomesh workingobj
					--setSettings()
					--setSettingsV2()
					polycloth.dooperation()
				)
			)
		)
		on spn_iters changed val do
		(
				setSettings()
		)
		on spn_movestrength changed val do
		(
				setSettings()
		)
		on spn_Damping changed val do
		(
				setSettings()
		)
		on btn_fb pressed do
		(
			shellLaunch "https://www.facebook.com/3DPolyDesign" ""
		)
		on btn_yt pressed do
		(
			shellLaunch "https://www.youtube.com/PolyDesignTutorials" ""
		)
		on btn_cgt pressed do
		(
			shellLaunch "https://www.cgtrader.com/batuhanozer52" ""
		)
		on spn_plasticity changed val do
		(
				setSettings()
		)
		on spn_bendiness changed val do
		(
				setSettings()
		)
		on btn_reset pressed do
		(
			spn_iters.value = 20
			spn_movestrength.value = 3.0
			spn_Damping.value = 0.95
			spn_plasticity.value = 0.1
			spn_bendiness.value = 0.1
			
			spn_gravity.value = 1.0
			spn_pressure.value = 1.0
			chk_gravity.checked = false
			chk_pressure.checked = false
			chk_ground.checked = false
			
			setSettings()
		)
		on btn_arts pressed do
		(
			shellLaunch "https://www.artstation.com/artist/batuhanozer" ""
		)
		on chk_useVCMask changed state do
		(
			setSettingsV2()
		)
		on chk_dispVCs changed state do
		(
			if ((selection as array).count == 1) then
			(
				if (state) then
				(
					$.showVertexColors = on
					$.vertexColorsShaded = on
					$.vertexColorType = 0
				)else
				(
					$.showVertexColors = off
				)
				try (update $) catch()
			)else
			(
				chk_dispVCs.checked = false
			)
		)
		on chk_gravity changed state do
		(
			setSettingsV2()
		)
		on chk_pressure changed state do
		(
			setSettingsV2()
		)
		on chk_ground changed state do
		(
			setSettingsV2()
		)
		on spn_gravity changed val do
		(
			setSettingsV2()
		)
		on spn_pressure changed val do
		(
			setSettingsV2()
		)
		on sld_maskValue changed val do
		(
			setSettingsV2()
		)
		on spn_maskblur changed val do
		(
			setSettingsV2()
		)
		on spn_clothStrength changed val do
		(
			setSettingsV2()
		)
		on chk_directionalExpand changed state do
		(
			setSettingsV2()
		)
		
	)
createdialog polyclothroll
--)
