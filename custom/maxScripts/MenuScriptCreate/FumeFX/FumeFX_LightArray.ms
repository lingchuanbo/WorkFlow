/* 
* FFX_LightArray v1.0.1
* Created:      July  04, 2014
* Author :  HOOLONG (hoolongvfx@gmail.com)
*/


-- macroScript FFX_LightArray
-- 	category:"**HOOLONG_VFX**"
-- 	buttonText:"LightArray "
-- 	tooltip:"FFX_LightArray v1.0.1"
-- 	icon:#("Lights",3)
-- 	(



try(destroydialog FumeFXLightArray)catch()

rollout FumeFXLightArray "FumeFXLightArray " width:200 height:250
(
	
	
	-- bitmap bmp8 "Bitmap" pos:[0,0] width:200 height:52 fileName:"Tool_logo.bmp"


	button A1 "CreateLight" pos:[26,29] width:70 height:40
	button btn6 "RGBLight" pos:[104,29] width:70 height:40
	button btn28 "K" pos:[57,84] width:20 height:20
	button btn29 "F" pos:[79,84] width:20 height:20
	button btn30 "B1" pos:[101,84] width:20 height:20
	button btn31 "B2" pos:[122,84] width:20 height:20
	label lbl15 "-------------------------------------------------------" pos:[5,104] width:189 height:17
	spinner spn1 "Rotate:" pos:[43,122] width:114 height:16 range:[-12,12,0] scale:0.01
	
	spinner spn2 "Scale: " pos:[43,142] width:114 height:16 range:[0,100,1] scale:0.01
	spinner spn10 "Key_Intensity" pos:[29,203] width:142 height:16 range:[0,9999,1] type:#float scale:0.01
	spinner spn3 "Pos:   " pos:[43,162] width:114 height:16 range:[-99999,99999,0] scale:1
	label lbl16 "-------------------------------------------------------" pos:[6,181] width:191 height:17

	fn createLight =
	(
-- delete all lights
	delete lights
	if $RGB_Rig != undefined do (delete $RGB_Rig)
	_Fumefx	 = $ 
-- Construct Lights
	freespot name:"Spot_BackLight1"  transform:(matrix3 [-0.342328,0.939581,0] [-0.330589,-0.120447,0.936058] [0.879502,0.320439,0.351847] [316.223,102.167,120.162])
	freespot name:"Spot_BackLight2"  transform:(matrix3 [-0.563888,-0.825851,0] [0.344059,-0.234922,0.909085] [-0.750769,0.512622,0.416611] [-225.134,148.736,120.162])
	freespot name:"spot_Key"   transform: (matrix3 [0.618164,0.786049,0] [-0.463351,0.364388,0.807792] [0.634964,-0.499348,0.589468] [268.063,-208.596,249.289]) 
	freespot name:"Spot_Fill" transform: (matrix3 [1,0,0] [0,-1.62921e-007,1] [0,-1,-1.62921e-007] [1.73965,-229.537,54.691])
	point name:"RGB_Rig" position:[0,0,0]
	$spot_Key.wirecolor=(color 255 0 0)

	RGBLights = #()
	RGBLights[1] = $spot_BackLight1
	RGBLights[2] = $spot_BackLight2
	RGBLights[3] = $spot_Key
	RGBLights[4] = $spot_Fill
	RGBLights.parent = $RGB_Rig

	for i = 1 to rgbLights.count do
	(
		if vray == undefined then 
			(
				
			
				RGBLights[i].baseobject.multiplier = 1
				RGBLights[i].baseobject.falloff = 80
				RGBLights[i].baseobject.hotspot = 50
				RGBLights[i].baseobject.castshadows = on
				RGBLights[i].baseobject.shadowmultiplier = 3
				RGBLights[i].baseobject.atmosShadows = on
				RGBLights[i].baseobject.showCone = on
				RGBLights[i].baseobject.overshoot = on
				RGBLights[i].shadowGenerator = raytraceShadow()	
				
			)
			else
			(
				
				
						
				RGBLights[i].baseobject.multiplier = 1
				RGBLights[i].baseobject.falloff = 80
				RGBLights[i].baseobject.hotspot = 50
				RGBLights[i].baseobject.castshadows = on
				RGBLights[i].baseobject.atmosShadows = on
				RGBLights[i].baseobject.showCone = on
				RGBLights[i].baseobject.overshoot = on
				RGBLights[i].baseobject.shadowmultiplier = 3
				RGBLights[i].shadowGenerator = vrayShadow()
						
			)
		
		
	)


	FFXGrp = #()
	MyLights = #()
	tmpLights = lights as array

	-- Collect all Fume Grids
		for obj in ($* as array) do
		(
			if classof obj == fumefx do
			(
				append FFXGrp obj
			)
		)

	-- Sort through lights, exclude Target Lights
		for lights in tmplights do
		(
			if classof lights != TargetObject do
			(
				append MyLights Lights
			)
		)

	-- Modify Fume Color Properties
		for i = 1 to ffxGrp.count do
		(
			FFXGrp[i].standard.SmokeColorSource = 0
			FFXGrp[i].standard.SmokeAmbientColor = [15,15,15]
			FFXGrp[i].standard.smoke_color_gradient.key_0.color = [120,120,120]

			FFXGrp[i].standard.castShadows = on
			FFXGrp[i].standard.receiveshadows = on
		-- 	FFXGrp[i].standard.SmokeDensity = 1
			for L = 1 to myLights.count do
			(
			FFXGrp[i].addlight mylights[L]
			)
		)

		$RGB_Rig.transform   = _FumeFX.transform 
	)

	
	fn RGBLight = 
	(
		
-- delete all lights
	delete lights
	if $RGB_Rig != undefined do (delete $RGB_Rig)
	_Fumefx	 = $ 
-- Construct Lights
	freespot name:"Spot_BackLight1" color:blue transform:(matrix3 [-0.342328,0.939581,0] [-0.330589,-0.120447,0.936058] [0.879502,0.320439,0.351847] [316.223,102.167,120.162])
	freespot name:"Spot_BackLight2" color:blue transform:(matrix3 [-0.563888,-0.825851,0] [0.344059,-0.234922,0.909085] [-0.750769,0.512622,0.416611] [-225.134,148.736,120.162])
	freespot name:"spot_Key" color:green  transform: (matrix3 [0.618164,0.786049,0] [-0.463351,0.364388,0.807792] [0.634964,-0.499348,0.589468] [268.063,-208.596,249.289])
	freespot name:"Spot_Fill" color:red transform: (matrix3 [1,0,0] [0,-1.62921e-007,1] [0,-1,-1.62921e-007] [1.73965,-229.537,54.691])
	point name:"RGB_Rig" position:[0,0,0]
	$spot_Key.wirecolor=(color 0 255 0)
	$spot_Fill.wirecolor=(color 255 0 0)
	$spot_BackLight1.wirecolor=(color 0 0 255)
	$spot_BackLight2.wirecolor=(color 0 0 255)
	RGBLights = #()
		RGBLights[1] = $spot_BackLight1
		RGBLights[2] = $spot_BackLight2
		RGBLights[3] = $spot_Key
		RGBLights[4] = $spot_Fill
	RGBLights.parent = $RGB_Rig

for i = 1 to rgbLights.count do
(
	
		if vray == undefined then 
			(
				
			
				RGBLights[i].baseobject.multiplier = 1
				RGBLights[i].baseobject.falloff = 80
				RGBLights[i].baseobject.hotspot = 50
				RGBLights[i].baseobject.castshadows = on
				RGBLights[i].baseobject.atmosShadows = on
				RGBLights[i].baseobject.showCone = on
				RGBLights[i].baseobject.overshoot = on
				RGBLights[i].baseobject.shadowmultiplier = 3
				RGBLights[i].shadowGenerator = raytraceShadow()	
				
				
				
			)
			else
			(

				RGBLights[i].baseobject.multiplier = 1
				RGBLights[i].baseobject.falloff = 80
				RGBLights[i].baseobject.hotspot = 50
				RGBLights[i].baseobject.castshadows = on
				RGBLights[i].baseobject.atmosShadows = on
				RGBLights[i].baseobject.showCone = on
				RGBLights[i].baseobject.overshoot = on
				RGBLights[i].baseobject.shadowmultiplier = 3
				RGBLights[i].shadowGenerator = vrayShadow()
			)
		
)


FFXGrp = #()
MyLights = #()
tmpLights = lights as array

-- Collect all Fume Grids
	for obj in ($* as array) do
	(
		if classof obj == fumefx do
		(
			append FFXGrp obj
		)
	)

-- Sort through lights, exclude Target Lights
	for lights in tmplights do
	(
		if classof lights != TargetObject do
		(
			append MyLights Lights
		)
	)

-- Modify Fume Color Properties
	for i = 1 to ffxGrp.count do
	(
		FFXGrp[i].standard.SmokeColorSource = 0
		FFXGrp[i].standard.SmokeAmbientColor = [15,15,15]
		FFXGrp[i].standard.smoke_color_gradient.key_0.color = [120,120,120]

		FFXGrp[i].standard.castShadows = on
		FFXGrp[i].standard.receiveshadows = on
	-- 	FFXGrp[i].standard.SmokeDensity = 1
		for L = 1 to myLights.count do
		(
		FFXGrp[i].addlight mylights[L]
		)
	)


	$RGB_Rig.transform   = _FumeFX.transform 	
		
		
	)

fn restart = 
(
	
	if 	$RGB_Rig != undefined then
		(
		spn1.value =  0
		spn2.value = $RGB_Rig.scale.x
		
		spn3.value  = $RGB_Rig.pos.z
		spn10.value = $spot_Key.multiplier
		)
	else
		(
		
		spn1.value =  0
		spn2.value = 1
		
		spn3.value  = 0
		spn10.value = 1
		
		)
	
)

	
	on FumeFXLightArray open do
	(
	 restart()
	)
	
	on A1 pressed do
	(
		if classof $ != FumeFX Then (Messagebox "Please select FumeFX";restart())
		else(CreateLight(); restart())
		
		
	)
	on btn28 pressed do
	(
		
	try(Select $spot_Key)catch(Messagebox "Please Click CreateLight or RGBLight";restart())
	
	)
	on btn29 pressed do
	(
	try(select  $spot_Fill)catch(Messagebox "Please Click CreateLight or RGBLight";restart())
	
	)
	on btn30 pressed do
	(
	
	try(select $spot_BackLight1)catch(Messagebox "Please Click CreateLight or RGBLight";restart())
	)
	on btn31 pressed do
	(
	
	try(select $spot_BackLight2)catch(Messagebox "Please Click CreateLight or RGBLight";restart())
	
	)
	on spn1 changed val do
	(
	
	try(rotate $RGB_Rig (angleaxis (val*30) [0,0,1]))catch(Messagebox "Please Click CreateLight or RGBLight";restart())
		
	)
	on spn2 changed val do
	(
	
	try( $RGB_Rig.scale =[val,val,val])catch(Messagebox "Please Click CreateLight or RGBLight";restart())
		
	)
	on spn10 changed val do
	(
	--print vel
	try($spot_Key.multiplier = val)catch(Messagebox "Please Click CreateLight or RGBLight";restart())
	)
	on spn3 changed val do
	(
	
	 try($RGB_Rig.pos.z =val)catch(Messagebox "Please Click CreateLight or RGBLight";restart())
		
	)
	on btn6 pressed do
	(
		if classof $ != FumeFX Then (Messagebox "Please select FumeFX";restart())
		else(RGBLight(); restart())
		
		
	)
)
	createdialog  FumeFXLightArray 
-- )