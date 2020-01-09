/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/21/2013

[Purpose]
Will pointcache out all objects in selection
Saves the cache files in the given directory
Cache files are named the same as each object

Will load caches back on to each object by name

Saves World Space Point Cache
Loads Local Point Cache

[KEYWORDS]
Animate, Bake, PC, Cache, PointCache, Point
__END__
******************************************/
struct pointCacheHelper_lib
(
	self,
	ro,
	fn resetMatrix_FN obj =
	(
		obj.objectOffsetPos = [0,0,0]
		obj.objectOffsetRot = (quat 0 0 0 1)
		obj.objectOffsetScale = [1,1,1]
		obj.transform = matrix3 1
	),
	fn savePointCache objArr dirPath fileType sampleRate =
	(
		for i in objArr do
		(
			if validmodifier i (Point_CacheSpacewarpModifier()) then
			(
				PCmod = (Point_CacheSpacewarpModifier name:#World_PC loadType:2 loadTypeSlave:2 fileName:(dirPath +"\\" + i.name + "." + fileType) recordStart:(animationRange.start - 5) recordEnd:(animationRange.end + 5) sampleRate:sampleRate)
				addmodifier i PCmod
				cacheOps.RecordCache i.modifiers[#World_PC]
			)
			else format "***** % Will not accept Point Cache modifier *****\n" i.name
		)
	),
	fn loadPointCache objArr dirPath fileType resetMatrix:true =
	(
		for i in objArr do
		(
			fileName = (dirPath +"\\" + i.name + "." + fileType)
			if doesFileExist filename then
			(
				i.parent = undefined 
				if resetMatrix then resetMatrix_FN i
				addModifier i (Point_Cache name:#Local_PC filename:fileName)
			)
			else format "***** % does not have an associated cache file in that folder *****\n" i.name
		)
	),
	fn ui =
	(
		rollout ro "Point Cache Helper By: GTVFX"
		(
			local self
			local pcPath
			local LCmod
			local cacheXT = "pc2"
			label lbl_setDir "Source Directory:" pos:[15,5] 
			editText edTxt_pcPath "" fieldWidth:330 pos:[10,20] 
			button btn_pcPath "...." width:20 height:20 pos:[350,18] tooltip:"Paste path in text field or use this button to choose path"
			spinner spn_sRate "Sample Rate:" type:#float range:[0,999,1] pos:[265,45] fieldWidth:50 enabled:false toolTip:"Set to a lower value to bake more samples per frame."
			button btn_saveCache "Save Cache" width:120 height:25 pos:[10,45] enabled:false
			button btn_loadCache "Load Cache" width:120 height:25 pos:[10,75] enabled:false
			checkBox chk_XML "XML" pos:[350,70] enabled:false
			checkBox chk_PC2 "PC2" checked:true pos:[350,90] enabled:false
			checkBox chk_matrix "Reset Matrix before load" checked:true pos:[10,110] enabled:false
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[310,115]
			fn _init pself =
			(
				self = pself
			)
			fn enableUI =
			(
				spn_sRate.enabled = true
				btn_saveCache.enabled = true
				btn_loadCache.enabled = true
				chk_XML.enabled = true
				chk_PC2.enabled = true
				chk_matrix.enabled = true
			)
			on chk_XML changed state do
			(
				if state then
				(
					chk_PC2.checked = false
					cacheXT = "xml"
				)
			)
			on chk_PC2 changed state do
			(
				if state then
				(
					chk_XML.checked = false
					cacheXT = "pc2"
				)
			)
			on edTxt_pcPath entered newpath do
			(
				pcPath = newpath
				enableUI()
			)
			on btn_pcPath pressed do
			(
				pcPath = getSavePath caption:"** POINT TO YOUR CACHE LOCATION ** " initialDir:maxFilePath
				if pcPath != undefined then
				(
					edTxt_pcPath.text = pcPath
					enableUI()
				)
			)
			on btn_loadCache pressed do
			(
				if selection.count != 0 then
				(
					self.loadPointCache (getCurrentSelection()) pcPath cacheXT resetMatrix:chk_matrix.state
				)
			)
			on btn_saveCache pressed do
			(
				if selection.count != 0 then
				(
					self.savePointCache (getCurrentSelection()) pcPath cacheXT spn_sRate.value
				)
			)
		)
		createdialog ro width:400 height:135
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog pCacheHelper.ro)catch()
pCacheHelper = pointCacheHelper_lib()
