/******************************************
Copyright (C) 2013 - 2014  Gavyn Thompson

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
/******************************************
/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.01
Updated:				01/08/2014
[Purpose]
Creates a composite map with the proper UV offsets from the UDIM supplied by Mari.
This tool utilizes the Slate Material Editor as it is much more efficient at handling the composite maps.
******************************************/
struct buildCompMaps_lib
(
	self,
	ro,
	
	fn SME_DisableRendering =
	(
		SmeIni = (getdir #plugcfg) + "\\SME.ini"
		if doesFileExist SmeIni then
		(
			setIniSetting SmeIni "Common" "EnableRendering" "0"
		)
		else
		(
			messageBox "Unable to edit SME.ini\nCould not find the file." title:"GTVFX: Error"
		)
	),
	fn vrayIsRenderer =
	(
		vr = renderers.current
		if matchPattern (vr as string) pattern:"V_Ray*" then true else false
	),
	fn getUniqueMapFileNames_FN dirPath fileXT =
	(
		mapFiles = getFiles (dirPath + "\\*" + fileXT)
		mapFileNames = #()
		for i in mapFiles do
		(
			appendIfUnique mapFileNames (filterString (getFileNameFile i) ".")[1]
		)
		mapFileNames
	),
	fn buildCompositeMap_FN dirPath fileXT isVray:true =
	(
		mapFiles = getFiles	(dirpath + "\\" + ro.lbx_fileNames.selected + "*" + fileXT)
		compMap = CompositeTexturemap()
		compMap.name = ro.lbx_fileNames.selected
		compMap.mapEnabled.count = mapFiles.count
		mapList = 1
		for i in mapFiles do
		(
			mapNamesArr = filterString (getFileNameFile i) "."
			U_space = ((mapNamesArr[2][4] as integer) - 1)
			V_space = (mapNamesArr[2][3] as integer)
			if (mapNamesArr[2][4] as integer) == 0 then
			(
				U_space = 9
				V_space -= 1
			)
			if isVRay then
			(
				newMap = VRayHDRI()
				newMap.name = (getFileNameFile i)
				newMap.mapType = 4
				newMap.gamma = ro.spn_gamma.value
				newMap.color_space = 1
				newMap.UVGen.u_offset = U_space
				newMap.UVGen.v_offset = V_space
				newMap.UVGen.U_Tile	= false
				newMap.UVGen.V_Tile	= false
				newMap.UVGen.blur = ro.spn_blur.value
				newMap.clear_memory = false
				newMap.HDRIMapName = i
			)
			else
			(
				newMap = bitMapTexture()
				newMap.name = (getFileNameFile i)
				newMap.coords.u_offset = U_space
				newMap.coords.v_offset = V_space
				newMap.coords.U_Tile = false
				newMap.coords.V_Tile = false
				newMap.coords.blur = ro.spn_blur.value
				newMap.filename = i
			)
			compMap.layername[mapList] = newMap.name
			compMap.mapList[mapList] = newMap
			mapList += 1
		)
		MatEditor.mode = #advanced
		MatEditor.Open()
		viewName = compMap.name
		sme.CreateView viewName
		newView = sme.GetView (sme.GetViewByName viewName)
		newView.CreateNode compMap [0,0]
	),
	fn ui =
	(
		rollout ro "Build Composite Maps From UDIMs By GTVFX" width:500 height:520
		(
			local self
			local folderLocation
			local imageFileExtension
			editText edt_directory "Maps Directory:" labelOnTop:true
			button btn_fldrBrws "Browse..." width:100 height:20 pos:[13,45] tooltip:"Paste path in text field or use this button to choose path"
			label lbl_imageXT "Image File Type: (exr, jpg, tif, etc...)" align:#left
			editText edt_fileXT "" fieldWidth:60
			ListBox lbx_fileNames "Files Found:" height: 15
			button btn_getFiles "Get Files" width:(ro.width - 30) height:40 pos:[15,330]
			group "Additional Parameters:"
			(
				checkBox chk_vray ":Use VRay HDRiLoader" checked:true --pos:[10,380]
				spinner spn_gamma "Gamma for HDRi Loader:"  fieldWidth:50 range:[0.0,100,1.0] align:#left across:2				--pos:[180,380] align:#right
				spinner spn_blur "Filter Blur Amount:" fieldWidth:50 range:[0.01,100,1.0] align:#left --pos:[15,410]
			)
			button btn_BuildMap "Build Composite Map" width:(ro.width - 20) height:50 --pos:[100,410]
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on edt_directory entered newText do
			(
				folderLocation = newText
			)
			on btn_fldrBrws pressed do
			(
				folderPath = getSavePath  caption:"** Get Texture Map Folder ** " initialDir:maxFilePath
					
				if folderPath != undefined then
				(
					edt_directory.text = folderPath
					folderLocation = folderPath
				)
			)
			on edt_fileXT entered newText do
			(
				if newText.count == 3 then
				(
					imageFileExtension = newText
				)
				else
				(
					messageBox "File extension can only be three(3) letters."
					edt_fileXT.text = ""
					imageFileExtension = undefined
				)
			)
			on btn_getFiles pressed do
			(
				if folderLocation != undefined and imageFileExtension != undefined then
				(
					lbx_fileNames.items = sort (self.getUniqueMapFileNames_FN folderLocation imageFileExtension)
				)
				else
				(
					messageBox "Define Directory and Image File Type first."
				)
			)
			on chk_vray changed state do
			(
				spn_gamma.enabled = state
			)
			on btn_BuildMap pressed do
			(
				if lbx_fileNames.selected != undefined then
				(
					messageBox "Map will be built in a new view in the Slate Material Editor."
					try(self.SME_DisableRendering())catch(format "***** Unabled to edit SMI.ini.\nYou may want to disable rendering in the editor\nby pressing the teapot in the lower left corner. *****\n")
					if chk_vray.state and not self.vrayIsRenderer() then 
					(
						chk_vray.state = false
						spn_gamma.enabled = false
						messageBox "VRay is not set as the current renderer.\nThe standard bitmap loader will be used instead." title:"GTVFX: Error Message"
					)
					self.buildCompositeMap_FN folderLocation imageFileExtension isVray:chk_vray.state
				)
				else
				(
					messageBox "Provide the Maps Directory and Image File Type,\nthen select the file from the list box that you want to build."
				)
			)
			
		)
		createDialog ro 
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog buildCompMaps.ro)catch()
buildCompMaps = buildCompMaps_lib()
