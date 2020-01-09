/*************************************************************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.01
Updated:				01/09/2014
[Purpose]
This tool exposes the primary VRay render settings that contribute to the final quality of the rendered image, allowing you to quickly adjust them in one place.
__END__
*************************************************************************************/
struct quickRenderSettings_lib
(
	self,
	ro,
	vr,
	qSetIni = ((getDir #plugCFG)+"\GTVFX_qSettings.ini"),
	roPos,
	
	fn vrayIsRenderer =
	(
		vr = renderers.current
		if matchPattern (vr as string) pattern:"V_Ray*" then true else false
	),
	fn setVrayLightSubDivs lightArr val pString:true =
	(
		for i in lights where isProperty i "subdivs" do
		(
			i.subDivs = val
			if pString then format "***** % :subdivs set to % *****\n" i.name val
		)
	),
	fn setVRayMtlSubdivs matArr val pString:true =
	(
		for i in matArr do
		(
			case (classOf i) of
			(
				(VRayMtl):
				(
					i.reflection_subdivs = val
					i.refraction_subdivs = val
					if pString then format "***** % :refraction subdivs set to % *****\n" i.name val
				)
				(VrayFastSSS2):
				(
					i.specular_subdivs = val
					i.single_scatter_subdivs = val
					if pString then format "***** % :SSS2 subdivs set to % *****\n" i.name val
				)
				(VRayLightMtl):
				(
					i.directLight_subdivs = val
					if pString then format "***** % :direct light subdivs set to % *****\n" i.name val
				)
				(VRayCarPaintMtl):
				(
					i.subdivs = val
					if pString then format "***** % :car paint subdivs set to % *****\n" i.name val
				)
				(VRayBlendMtl):
				(
					subMatArr = #()
					append subMatArr i.baseMtl
					for m in i.coatMtl do if m != undefined then append subMatArr m
					setVRayMtlSubdivs subMatArr val pString:pString
				)
				(VRay2SidedMtl):
				(
					subMatArr = #()
					if i.frontMtl != undefined then append subMatArr i.frontMtl
					if i.backMtl != undefined then append subMatArr i.backMtl
					setVRayMtlSubdivs subMatArr val pString:pString
				)
				(MultiSubMaterial):
				(
					subMatArr = #()
					for m in 1 to i.numSubs do
					(
						if m != undefined then append subMatArr i.materialList[m]
					)
					setVRayMtlSubdivs subMatArr val pString:pString
				)
			)
		)
	),
	fn ui =
	(
		rollout ro "Quick Settings by GTVFX" width:220 height:335
		(
			local self
			group "Primary Rays"
			(
				label lbl_imageSampler "Addaptive DMC Image Sampler:"
				spinner spn_minSubDivs "Min:" type:#integer range:[1,999,1] fieldWidth:45 across:2
				spinner spn_maxSubDivs "Max:" type:#integer range:[1,999,4] fieldWidth:45
				checkBox chk_useDMCthresh "Use DMC Sampler:" checked:true align:#right 
				spinner spn_noiseThrsh "Noise Thrsh:" type:#float range:[0,1,.01] fieldWidth:45 align:#right
				spinner spn_adaptive "Addaptive Amount:" type:#float range:[0,1,.85] fieldWidth:45 align:#right
			)
			group "Secondary Rays"
			(
				spinner spn_lightMinSub "Light/Shadow Subdivs:" type:#integer range:[1,1024,8] fieldWidth:45
				spinner spn_matMinSub "Material/Shader Subdivs:" type:#integer range:[1,1024,8] fieldWidth:45
				label lbl_GISub "GI Brute Force Subdivisions:"
				spinner spn_giSub "Subdivs:" type:#integer range:[1,1024,1] fieldWidth:45 across:2
				checkbutton cbtn_setBruteForce "Set Brute Force" width:90 height:20
			)
			spinner spn_bucketSize "Render Bucket Size:" type:#integer range:[1,1024,48] fieldWidth:45
			group "Tool Feedback"
			(
				checkButton cBtn_feedback "On" width:180 checked:true tooltip:"If on then this tool will provide feedback to the listener window for each light and each material that gets updated.\nIn large scenes this can be very slow, so there is an option here to disable it."
			)
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn putVraySettingsToUI =
			(
				if self.vrayIsRenderer() then
				(
					self.vr.imageSampler_type
					spn_minSubDivs.value = self.vr.twoLevel_baseSubdivs
					spn_maxSubDivs.value = self.vr.twoLevel_fineSubdivs
					chk_useDMCthresh.checked = self.vr.twoLevel_useDMCSamplerThresh
					spn_noiseThrsh.value = if self.vr.twoLevel_useDMCSamplerThresh then self.vr.dmc_earlyTermination_threshold else self.vr.twoLevel_threshold
					spn_giSub.value = self.vr.dmcgi_subdivs
					spn_adaptive.value = self.vr.dmc_earlyTermination_amount
					spn_lightMinSub.value = try((for i in lights where isProperty i "subdivs" collect i)[1].subdivs)catch(8)
					spn_matMinSub.value = try((for i in sceneMaterials where classOf i == VRayMtl collect i)[1].reflection_subdivs)catch(8)
					cbtn_setBruteForce.state = if self.vr.gi_on and self.vr.gi_primary_type == 2 then true else false
					spn_bucketSize.value = self.vr.system_region_x
					if chk_useDMCthresh.checked then spn_noiseThrsh.caption = "Noise Thrsh:" else spn_noiseThrsh.caption = "Clr Thrsh:"
					if cbtn_setBruteForce.state then spn_giSub.enabled = true else spn_giSub.enabled = false
				)
				else
				(
					messageBox "VRay is not the current renderer." title:"GTVFX: Error"
				)
			)
			fn _init pself =
			(
				self = pself
				putVraySettingsToUI()
				if hasIniSetting self.qSetIni "UI" "Feedback" then cBtn_feedback.state = (execute (getIniSetting self.qSetIni "UI" "Feedback"))
				if cBtn_feedback.state then cBtn_feedback.caption = "On" else cBtn_feedback.caption = "Off"
			)
			on ro help do
			(
				format "***** GTVFX: Help coming soon. *****\n"
			)
			on ro moved pos do
			(
				setIniSetting self.qSetIni "UI" "Position" (pos as string)
			)
			on spn_minSubDivs changed val do
			(
				self.vr.twoLevel_baseSubdivs = val
			)
			on spn_maxSubDivs changed val do
			(
				self.vr.twoLevel_fineSubdivs = val
			)
			on chk_useDMCthresh changed state do
			(
				self.vr.twoLevel_useDMCSamplerThresh = state
				if state then
				(
					spn_noiseThrsh.caption = "Noise Thrsh:"
					spn_noiseThrsh.value = self.vr.dmc_earlyTermination_threshold
				)
				else
				(
					spn_noiseThrsh.caption = "Clr Thrsh:"
					spn_noiseThrsh.value = self.vr.twoLevel_threshold
				)
			)
			on spn_noiseThrsh changed val do
			(
				if chk_useDMCthresh.checked then
				(
					self.vr.dmc_earlyTermination_threshold = val
				)
				else
				(
					self.vr.twoLevel_threshold = val
				)
			)
			on spn_adaptive changed val do
			(
				self.vr.dmc_earlyTermination_amount = val
			)
			on spn_lightMinSub changed val do
			(
				self.setVrayLightSubDivs lights val pString:cBtn_feedback.state
			)
			on spn_matMinSub changed val do
			(
				self.setVRayMtlSubdivs sceneMaterials val pString:cBtn_feedback.state
			)
			on spn_giSub changed val do
			(
				if cbtn_setBruteForce.checked then
				(
					self.vr.dmcgi_subdivs = val
				)
			)
			on cbtn_setBruteForce changed state do
			(
				if state then
				(
					spn_giSub.enabled = true
					self.vr.gi_on = true
					self.vr.gi_primary_type = 2 
				)
				else
				(
					spn_giSub.enabled = false
					self.vr.gi_on = false
				)
			)
			on spn_bucketSize changed val do
			(
				self.vr.system_region_x = val
				self.vr.system_region_y = val
			)
			on cBtn_feedback changed state do
			(
				setIniSetting self.qSetIni "UI" "Feedback" (state as string)
				if state then cBtn_feedback.caption = "On" else cBtn_feedback.caption = "Off"
			)
		)
		createDialog ro pos:roPos
		ro._init self
	),
	fn _init =
	(
		self = this
		if doesFileExist self.qSetIni and hasIniSetting self.qSetIni "UI" "Position" then
		(
			roPos = (execute (getIniSetting self.qSetIni "UI" "Position")) 
		)
		else roPos = [850,420]
		ui()
	),
	init = _init()
)
try(destroyDialog qrs.ro)catch()
qrs = quickRenderSettings_lib()

