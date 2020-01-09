/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.1.00
Updated:				12/12/2013
[Purpose]
Creates a VRay Light Select Element for each light in your scene.
Elements are named with prefix of the nameTag variable. You can change this variable if necessary for your pipeline.
[KEYWORDS]
VRay, LightSelect, Light, perLight
__END__
******************************************/
Struct VRayLightSelectPerLight_Lib
(
	VLS_Ini = ((getDir #scripts)+@"\GTVFX\VLS.ini"),
	elmntMgr = maxOps.GetCurRenderElementMgr(),
	nameTag = "lgt_",
	fn clearLightSelectElements_FN arr:#()=
	(
		numElements = elmntMgr.NumRenderElements()
		for i in 0 to (numElements-1) do
		(
			elementEach = elmntMgr.GetRenderElement i
			if classOf elementEach == VRayLightSelect then 
			(
				append arr elementEach
			)
		)
		if arr.count != 0 then
		(
			for i in arr do
			(
				format "***** Removing Element: % *****\n" i.elementName
				elmntMgr.RemoveRenderElement i
			)
			renderSceneDialog.update()
		)
		true
	),
	fn createLightSelectsPerLight_FN =
	(
		for i in lights where superClassOF i == Light do
		(
			lgtArr = #(i)
			elementName= (nameTag + i.name)
			elmntMgr.addrenderelement (VRayLightSelect elementname:elementName vrayVFB:TRUE color_mapping:FALSE multiplier:1.0 lights:lgtArr lightsExcludeType:1)
		)
	),
	fn _init =
	(
		if doesFileExist VLS_Ini then
		(
			nameTag = (filterString (getIniSetting VLS_Ini "General" "nameTag") "*")[1]
		)
		if queryBox "Remove existing light select elements?" title:"GTVFX: Remove Light Select Elements:" == true then
		(
			clearLightSelectElements_FN()
		)
		createLightSelectsPerLight_FN()
	),
	init = _init()
)
VLSPL = VRayLightSelectPerLight_Lib()
