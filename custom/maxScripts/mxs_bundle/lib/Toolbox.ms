/*************************************************************************************
Copyright (C) 2013 - 2014  Gavyn Thompson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. if not, see <http://www.gnu.org/licenses/>.
*************************************************************************************/
/*************************************************************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v2.42
Updated:				01/14/2014
[Purpose]
Artist toolset
__END__
*************************************************************************************/
try(cui.unRegisterDialogBar gtb.ro_toolbox)catch()
try(destroyDialog gtb.ro_toolbox)catch()
struct toolbox_lib
(
	------ Utility Variables
	gtbIni = ((getDir #plugCFG)+@"\GTVFX_toolbox.ini"),
	gtbTemp = (getDir #temp),
	gtbDate = "01/14/2014",
	gtbVer = "2.42",
	gtbMode = "Pro",
	-------
	self,
	thePos,
	theSize,
	startUp = false,
	meshArr,
	attachPointArr,
	bakePointArr,
	curCam,
	storedRenderer,
	vr,
	savedWireColorArr = #(),
	mainUI_rollouts = #(),
	modObjsArr = #(),
	perc,
	percentu,
	layerStateArr = #(),
	macroCategory = "GTVFX_Toolbox",
	------ Main UI Rollouts
	ro_toolbox,
	ro_Save,
	ro_CopyPaste,
	ro_MatTools,
	ro_SlateTools,
	ro_Utilities,
	ro_Render,
	ro_MeshTools,
	ro_wireColor,
	ro_Selection,
	ro_animTools,
	ro_MaxFileOps,
	ro_ObjProps,
	ro_VRayProps,
	ro_Info,
	rcm_UI,
	------ Tool Rollouts
	ro_bakeVRCamFocus,
	ro_pointCacheHelper,
	ro_offsetKeyframes,
	ro_ApplyMatLib,
	ro_SaveMatLib,
	ro_gammaSettings,
	ro_ObjId,
	ro_VRgeomSamples,
	ro_selectBySize,
	ro_selectEveryNth,
	ro_layIso,
	-- Dot Net Use
	dnToolTip,
	clrWindow = ((colorMan.getColor #window)*255),
	clrText = ((colorMan.getColor #text)*255),
	ClrBackGround = ((colorMan.getColor #background)*255),
	-- UI Control
	roBuildOrderArr,
	ro_uiOrder,
	tHeight = 8,
	bHeight = 19,
	bWidth = 132,
	priColor = 25,
	secColor = 5,
	
--( Dot Net Functions
	
	fn InitToolTip dNetObj caption =
	(
		if dnTooltip == undefined then
		(
			dnToolTip = dotnetobject "ToolTip"
			dnToolTip.AutoPopDelay = 5000
			dnToolTip.InitialDelay = 300
			dnToolTip.ReshowDelay = 300
			dnToolTip.ShowAlways = true
			dnToolTip.IsBalloon = true
		)
		dnToolTip.SetToolTip dNetObj caption
		dnToolTip
	),
	
	fn DestroyToolTip =
	(
		dnToolTip
		if dnToolTip != undefined then
		(
			dnToolTip.RemoveAll()
			dnToolTip.Dispose()
			dnToolTip = undefined
		)
		True
	),
	
	fn NormalizeRGB val =
	(
		if val <0 then val = 0 else if val >255 then val = 255
		val
	),
	
	fn SetDotNetWidget dNobj caption fontSize colorOffsetInt:0 =
	(
		dNobj.text = caption
		dNobj.forecolor = dNobj.forecolor.FromArgb clrText.x clrText.y clrText.z
		dNobj.backColor = dNobj.backcolor.FromArgb (normalizeRGB (ClrBackGround.x+colorOffsetInt)) (normalizeRGB (ClrBackGround.y+colorOffsetInt)) (normalizeRGB (ClrBackGround.z+colorOffsetInt))
		dNobj.Font = dotNetObject "System.Drawing.Font" "Tahoma" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
	),
	
	fn InitDnetChk dNchk caption fontsize tooltip:"" =
	(
		setDotNetWidget dNchk caption fontSize
		initToolTip dNchk tooltip
		dNchk.update()
	),
	
	fn InitDnetBtn dNbtn caption fontSize style:#popup colorOffsetInt:0 tooltip:"" = 
	(
		case style of
		(
			#flat:(dNbtn.flatStyle = dNbtn.flatStyle.flat)
			#popup:(dNbtn.flatStyle = dNbtn.flatStyle.popup)
			#system:(dNbtn.flatStyle = dNbtn.flatStyle.system)
		)
		setDotNetWidget dNbtn caption fontSize colorOffsetInt:colorOffsetInt
		dNbtn.tag = tooltip
		dNbtn.update()
	),
	
	fn SetDataGridColor dNObj fontSize =
	(
		dNObj.forecolor = dNObj.forecolor.FromArgb clrText.x clrText.y clrText.z
		dNObj.BackgroundColor = dNObj.BackgroundColor.FromArgb clrWindow.x clrWindow.y clrWindow.z
		dNObj.DefaultCellStyle.BackColor = dNObj.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
		dNObj.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
	),
	
--) End Dot Net Functions
	
--( lib Functions
	
	fn FormatMacro_FN mcrID mcrCategory mcrToolTip mcrName mcrFunction =
	(
		macroStreem = stringStream ""
		format ("macroScript %\n\tcategory:\"%\"\n"+"\ttooltip:\"%\"\n"+"\tbuttonText:\"%\"\n"+"(\n\t::gtb \n %\n)\n") \
		mcrID mcrCategory mcrToolTip mcrName mcrFunction to:macroStreem
		seek macroStreem 0
		readExpr macroStreem
	),
	
	fn CreateToolBoxMacros =
	(
		propArr = getPropNames self
		for i in propArr where classOf i == MAXScriptFunction do
		(
			--gtb.formatMacro_FN "copy01_mcr" "gtb" gtb.gtbFloater.rollouts[2].btn_Copy01.tooltip "copy01_mcr" "gtb.copy_FN 'copypaste_01.max'" stream
			--formatMacro_FN 
		)
	),
	
	fn FindMenuItemIndex mnu strName =
	(
		if mnu != undefined and mnu.numItems() != 0 then
		(
			for i in 1 to mnu.numItems() do
			(
				if ((mnu.getItem i).getTitle() == strName) then return i
			)
			false
		)
		else
		(
			format "***** No items could be collected *****\n"
			return undefined
		)
	),
	
	fn RoundTo Val prec:0 type:#integer =
	(
		/************************************************
		precision values < 0 will round to whole number values
		-1 to nearest 10, -2 to nearest 100, etc...
		values > 0 will round to decimal precision
		.1 to nearest 10th (one decimal place), .2, to nearest 100th (2 decimal places), etc...
		************************************************/
		local mult = 10.0 ^ prec
		out = (floor ((val * mult) + 0.5)) / mult
		case type of
		(
			#integer: out as integer
			#float: out as float
			#double: out as double
			#integer64: out as integer64
			#IntegerPtr: out as IntegerPtr
		)
	),
	
	fn Progress stage caption:"" arrCount:0=
	(
		case stage of
		(
			#start:
			(
				--format "***** Progress Start *****\n"
				progressStart caption
				perc = (100.0 / arrCount)
				percentu = perc	
				
			)
			#update:
			(
				--format "***** Progress Update *****\n"
				progressUpdate percentu
				percentu += perc
			)
			#cancel:
			(
				out = (getProgressCancel())
				--format "***** Progress Cancel: % *****\n" out
				out
			)
			#end:
			(
				--format "***** Progress End *****\n"
				progressEnd()
			)
		)
	),
	
	fn VRcamera_filt obj = isKindOf obj VRayPhysicalCamera,
		
	fn ObjectFilter obj objType = isKindOf obj objType,
	
	fn CallBacksUi =
	(
		if ::gtCallbacks != undefined then gtCallbacks.ui() else messageBox "GTVFX-00_LIB_callbacksLib not initialized..." title:"GTVFX: Error"
	),
	
	fn VrayIsRenderer =
	(
		vr = renderers.current
		if matchPattern (vr as string) pattern:"V_Ray*" then True else False
	),
	
	mapped fn SetTrackViewLocks objArr state children:True =
	(
		lockedTracksMan.setLocks state #(objArr[3][1], objArr[3][2], objArr[3][3]) #(objArr[3], objArr[3], objArr[3]) #(1,2,3) children
	),
	
	fn CreateLayerAndSetCurrent layerName =
	(
		if LayerManager.getLayerFromName layerName == undefined then
		(
			setLayer = layermanager.newLayerFromName layerName
		)
		else
		(
			setLayer = LayerManager.getLayerFromName layerName
		)
		setLayer.current = true
	),
	
	fn DummySaveReset_FN =
	(
		saveNodes #() (GetDir #scene + "\\_Temp.max")
		deleteFile (GetDir #scene + "\\_Temp.max") 
	),
	
	fn FindModifierObjs objArr modtype arr:#() =
	(
		for each in objArr do
		(
			for i in 1 to each.modifiers.count do
			(
				if classOf each.modifiers[i] == modtype then append arr each
			)
		)
		arr
	),
	
	fn GetParentsRecursive obj arr:#() =
	(
		if obj.parent != undefined do
		(
			if finditem arr obj.parent == 0 do 
			(
				append arr obj.parent
			)
			getParentsRecursive obj.parent arr:arr
		)
		arr
	),
	
	fn GetChildrenRecursive obj arr:#() =
	(
		if obj.children.count != 0 then
		(
			for c in obj.children do
			(
			   append arr c
			   getChildrenRecursive c arr:arr
			)
		)
		arr
	),
	
	fn SVL_FN =
	(
		viewport.setLayout  #layout_2V
	),
	
	fn Get_Names name a =
	(
		append a name
	),
	
	fn CalcBboxVolume obj =
	(
		vMin = obj.min
		vMax = obj.max
		fX = vMax.x - vMin.x
		fY = vMax.y - vMin.y
		fZ = vMax.z - vMin.z
		out = (fX*fY*fZ)
		out
	),
	
	fn CollectUniqueMats objArr =
	(
		arr = #()
		for i in objArr where i.material != undefined do appendIfUnique arr i.material
		arr
	),
	
	fn CollectClassObjects objClass equalTo:true =
	(
		arr = #()
		if equalTo then arr = for i in objects where classOf i.baseObject == objClass collect i
		else arr = for i in objects where classOf i.baseObject != objClass collect i
	),
	
	fn CollectAnimatedObjects objArr arr:#() =
	(
		if objArr.count != 0 then
		(
			arr = for i in objArr where i.isanimated collect i
		)
		else
		(
			messageBox "There are no objects to check.\nSupply an array of nodes to test."
		)
		arr
	),
	
	fn SelectCollection arr =
	(
		if arr.count != 0 then select arr
		else messageBox "Nothing to select" title:"GTVFX: Error"
	),
	
	mapped fn ResetMatrix_FN objArr =
	(
		objArr.objectOffsetPos = [0,0,0]
		objArr.objectOffsetRot = (quat 0 0 0 1)
		objArr.objectOffsetScale = [1,1,1]
		objArr.transform = matrix3 1
	),
	
	fn openPath fPath =
	(
		shellLaunch "explorer" fPath 
	),
	
	mapped fn toggleProperty objArr propName val =
	(
		if (hasProperty objArr propName) then setProperty objArr propName val
	),
	
--) End lib Functions
--( Save
	
	fn VerPadding inString: Number: Pad: =
	(
		if (inString != unsupplied) and (Number != unsupplied) and (Pad != unsupplied) do
		(
			ZeroString = ""
			for x = 1 to (Pad - (Number as string).count) do (ZeroString = ZeroString + "0")
			(inString + (ZeroString + (Number as string)))
		)
	),
	
	fn SaveMajorVersion_FN userInit:false=
	(
		maxPreName = getFileNameFile maxFileName
		maxPreNameArr = filterString maxPreName "_"
		maxRootName = maxPreNameArr[1]
		for x = 2 to (maxPreNameArr.count - 2) do
		(
			maxRootName = maxRootName + "_" +  maxPreNameArr[x]
		)
		if not userInit then
		(
			curVersionNumber = ((filterString maxPreNameArr[maxPreNameArr.count - 1] "v")[1] as integer)
			userInit = maxPreNameArr[maxPreNameArr.count]
			newVersionNumber = VerPadding inString:"v" Number:(curVersionNumber + 1) Pad:3
			finalMaxFileName = maxfilepath + maxRootName + "_" + newVersionNumber + "_" + userInit + ".max"
		)
		else
		(
			curVersionNumber = ((filterString maxPreNameArr[maxPreNameArr.count] "v")[1] as integer)
			newVersionNumber = VerPadding inString:"v" Number:(curVersionNumber + 1) Pad:3
			finalMaxFileName = (maxfilepath + maxRootName + "_" + newVersionNumber + ".max")
		)
		if doesFileExist finalMaxFileName then
		(
			messageBox "You are not in the most recent file. \n If you need to create a major version from this file do so manually."
		)
		else
		(
			saveMaxFile finalMaxFileName useNewFile:true
		)
	),
	
	fn SaveIncrement_FN =
	(
		makeDir (maxfilepath + "_incrementalSave")
		maxPreName = getFileNameFile maxFileName
		verSaveFiles = (getfiles (maxFilePath + "_incrementalSave" + "\\" + maxPreName + "*.max"))
		verSaveFilesArr = 	for v in verSaveFiles collect (getFileNameFile v)
		verNum = (verSaveFilesArr.count + 1)
		if verNum < 10 then verNumPadding = "00"
		if verNum >= 10 and verNum < 100 then verNumPadding = "0"
		if verNum >= 100 then verNumPadding = ""
		verMaxFileName = maxFilePath + "_incrementalSave\\" + maxPreName  + "_" + verNumPadding + (verNum as string) + ".max"
		newSaveFile = maxFilePath + maxFileName
		renameFile newSaveFile verMaxFileName
		saveMaxFile newSaveFile useNewFile:true
	),
	
	fn CancelShutdown =
	(
		dosCommand "shutdown /a"
	),
	
	fn LaunchDeadlineSlave =
	(
		if not (shellLaunch "deadlineSlave.exe" "") then messageBox "Unable to lauch Deadline Slave." title:"GTVFX: Application Launch Error"
	),
	
	fn LaunchBackburnerSlave =
	(
		if not (shellLaunch "Slave.exe" "") then messageBox "Unable to lauch Deadline Slave." title:"GTVFX: Application Launch Error"
	),
	
	fn SaveAndCloseMax slave_dl:false slave_bb:false=
	(
		saveIncrement_FN()
		if slave_dl then launchDeadlineSlave()
		else if slave_bb then launchBackburnerSlave()
		quitMax #noPrompt
	),
	
	fn SaveAndRestart =
	(
		saveIncrement_FN()
		dosCommand "shutdown -t 30 -f -r -d up:125:1 -c \"Save & Close By GTVFX: 30 Seconds to restart...\""
		quitMax #noPrompt
	),
	
	fn SaveAndShutdown =
	(
		saveIncrement_FN()
		dosCommand "shutdown -t 30 -f -s -d up:125:1 -c \"Save & Close By GTVFX: 30 Seconds to shutdown...\""
		quitMax #noPrompt
	),
	
	fn SaveAndClose_ui =
	(
		rollout ro "Save & Close By GTVFX" width:300 
		(
			local self
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			group "Save And Close Options:"
			(
				dropDownList ddl_option items:#("Quit Max","Quit Max and Launch Deadline Slave","Restart","Shutdown")
			)
			dotNetControl dNbtn_execute "button" height:40 
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" offset:[ro.width/2-50,0]
			
			fn _init pself =
			(
				self = pself
				self.initDnetBtn dNbtn_execute "Save & Close" 12 colorOffsetInt:15 tooltip:"Execute the selected option."
			)
			on dNbtn_execute mouseClick do
			(
				case ddl_option.selected of
				(
					("Quit Max"): self.saveAndCloseMax()
					("Quit Max and Launch Deadline Slave"): self.saveAndCloseMax slave:true
					("Restart"): self.saveAndRestart()
					("Shutdown"): self.saveAndShutdown()
				)
			)
			on dNbtn_execute MouseEnter arg do
			(
				self.initToolTip dNbtn_execute dNbtn_execute.tag
			)
			on dNbtn_execute MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		createDialog ro
		ro._init self
	),
	
--) End Save
	
--( Copy/Paste
	
	fn Copy_Paste fileName copyArg:true =
	(	
		saveDir = (gtbTemp+ @"\copypaste\")
		if copyArg then
		(
			makeDir saveDir
			if selection.count > 0 then
			(
				saveNodes $ (saveDir + fileName)
			)
			else
			(
				messagebox "Nothing selected......" title:"GTVFX: Error"
			)
		)
		else
		(
			mergeMaxFile (saveDir + fileName) #select
		)
	),
	
--) End Copy/Paste
	
--( Material Tools
	
	fn Mat_ResetMEdit_FN =
	(
		macros.run "Medit Tools" "clear_medit_slots"
	),
	
	fn Mat_RestoreMedit =
	(
		macros.run "Medit Tools" "restore_medit_slots"
	),
	
	fn PutMatToActiveMeditSlot_FN =
	(
		MatEditor.mode = #basic
		if selection[1] != undefined and selection[1].material != undefined then
		(
			meditMaterials[activeMeditslot] = selection[1].material
		)
	),
	
	fn Mat_PutSelMatsToMEdit_FN objArr = 
	(
		if objArr.count != 0 then
		(
			MatEditor.mode = #basic
			arr = #()
			for i in objArr do if i.material != undefined then appendIfUnique arr i.material
			if arr.count <= 24 then meditCount = arr.count else meditCount = 24
			for t = 1 to meditCount do meditmaterials[t] = arr[t]
			if meditCount > 24 then messageBox "There were more materials than MEdit slots."
		)
		else messagebox "Nothing selected......"
	),
	
	fn Mat_PutSceneMatstoMEdit_FN =
	(
		if sceneMaterials.count != 0 then
		(
			MatEditor.mode = #basic
			for t = 1 to 24 do if scenematerials[t] == undefined then exit else meditmaterials[t] = scenematerials[t]
			if sceneMaterials.count > 24 do messageBox "There are more materials than MEdit slots." title:"GTVFX"
		)else messageBox "No materials found in scene." title:"GTVFX: Error"
	),
	
	fn CreateBlackMaterial =
	(
		out
		if VrayIsRenderer() then
		(
			out = (VrayLightMtl name:"Black" color:black)
		)
		else
		(
			out = (Standard diffuse:Black selfIllumAmount:100)
		)
		out
	),
	
	mapped fn Mat_ApplyBlackMtl_FN objArr mtl:(CreateBlackMaterial()) =
	(
		objArr.material = mtl
	),
	
	fn Mat_CreateUtilMtls_FN =
	(
		Mat_ResetMEdit_FN()
		redMtl = vrayLightMtl name:"Red" color:Red
		greenMtl = vrayLightMtl name:"Green" color:Green
		blueMtl = vrayLightMtl name:"Blue" color:Blue
		blackMtl = vrayLightMtl name:"Black" color:Black
		whiteMtl = vrayLightMtl name:"White" color:White
		diffuseMtl = vrayMtl name:"Diffuse" diffuse:(color 58 58 58)
		chromeMtl = vrayMtl name:"Chrome" color:black reflection:white
		meditMaterials[1] = redMtl
		meditMaterials[2] = greenMtl
		meditMaterials[3] = blueMtl
		meditMaterials[4] = blackMtl
		meditMaterials[5] = whiteMtl
		meditMaterials[6] = diffuseMtl
		meditMaterials[7] = chromeMtl
		setMTLMEditFlags meditMaterials[7] #{2,3}
		matEditor.open()
	),
	
	fn Mat_SaveMatLib_FN = 
	(
		try(destroyDialog self.ro_SaveMatLib)catch()
		rollout ro_SaveMatLib "Save Material Library"
		(
			local maxName = getfileNameFile maxFileName 
			local matName = ""
			local finalMatPath = ""	
			local newDirArr = #() 
			editText edt_Path "To:" text:"Paste in the directory where you want your MatLib saved."
			button btn_rnMat "Rename Material" width:120 height:40 pos:[40,40]toolTip:"Renames the shader in slot [Active] to the Max File Name."
			button btn_svMatLib "Save Material Library" width:120 height:40 pos:[200,40] toolTip:"Saves the shader in slot [Active] to the directory in the text field."
			on edt_Path entered newText do
			(
				newDirArr = getDirectories newText
				if newDirArr.count == 1 then
				(
					format "***** Directory Accepted. *****\n"
				)
				else
				(
					MessageBox "Cannot parse the folder path.\nMake sure the folder path is correct and try again."
					edt_Path.text = ""
				)
			)
			on btn_rnMat pressed do
			(
				MeditMaterials[activeMeditslot].name = maxName
			)
			on btn_svMatLib pressed do
			(
				matName = MeditMaterials[activeMeditslot].name
				finalMatPath = edt_Path.text + "\\" + matName + ".mat"
				newMatLib = materialLibrary MeditMaterials[activeMeditslot]
				if doesFileExist edt_Path.text == true then
				(
					saveTempMaterialLibrary newMatLib finalMatPath
				)
				else
				(
					messageBox "Folder does not exist.\nCheck again" title:"GTVFX: Error"
				)
			)
		)
		createdialog ro_SaveMatLib width:350 height:100
	),
	
	fn ApplyMatLibToSelection_FN matPath =
	(
		if selection.count != 0 then
		(
			loadMaterialLibrary matPath
			appMat = currentMaterialLibrary[1]
			for each in selection do each.material = appMat
			format "***** Material Library Applied *****\n"
		)
		else
		(
			messageBox "Select the objects you want the material applied to."
		)
	),
	
	fn ApplyMatLib_dlg_FN =
	(
		try(destroyDialog self.ro_ApplyMatLib)catch()
		rollout ro_ApplyMatLib "Apply Material Library"
		(
			local self
			local libPath = undefined
			editText edt_Path "To:" text:"Paste in the directory where you want your MatLib saved."
			button btn_loadMatLib "Apply Material Library" width:120 height:40 pos:[116,40] toolTip:"Applies the first material in the supplied matLib to your selection."
			fn _init pself =
			(
				self = pself
			)
			on edt_Path entered newText do
			(
				if doesFileExist newText and (getFileNameType newText) == ".mat" then
				(
					libPath = newText
					format "**** Material Library Accepted ****\n"
				)
				else
				(
					MessageBox "Cannot parse the file path.\nMake sure to past the full path to the file."
					edt_Path.text = ""
					libPath = undefined
				)
			)
			on btn_loadMatLib pressed do
			(
				if libPath != undefined then
				(
					self.ApplyMatLibToSelection_FN libPath
				)
				else
				(
					messageBox "Supply a material library file to proceed."
				)
			)
		)
		createdialog ro_ApplyMatLib width:350 height:100
		ro_ApplyMatLib._init self
	),
	
--) End Material Tools
	
--( Slate Tools
	
	fn GetSMEfile dirNames:#(#plugcfg, #plugcfg_ln) =
	(
		fileArr = #()
		for i in dirNames do
		(
			fileArr += (getFiles ((getDir i) + "\\*"))
		)
		ini = (for i in fileArr where matchPattern (fileNameFromPath i) pattern:"SME.ini" collect i)[1]
		ini
	),
	
	fn SME_DisableRendering =
	(
		smeIni = getSMEfile()
		if smeIni != undefined and (doesFileExist smeIni) then
		(
			setIniSetting smeIni "Common" "EnableRendering" "0"
		)
		else
		(
			messageBox "Unable to edit SME.ini\nCould not find the file." title:"GTVFX: Error"
		)
	),
	
	fn SME_DeleteAllViews_FN =
	(
		MatEditor.mode = #advanced
		numViews = trackViewNodes[#sme].numsubs
		for i in 1 to numViews do sme.DeleteView 1 false
	),
	
	fn SME_CreateViewForMat mat =
	(
		MatEditor.mode = #advanced
		MatEditor.Open()
		if (sme.GetViewByName mat.name) == 0 then
		(
			sme.CreateView mat.name
			newView = sme.GetView (sme.GetViewByName mat.name)
			newView.CreateNode mat [0,0]
			True
		)
		else
		(		
			str = stringStream ""
			format "***** Node view % already exists *****\n" mat.name to:str
			messageBox (str as string) title:"GTVFX: Error"
			False
		)
	),
	
	fn SME_CreatenodeViewForObjs_FN objArr =
	(
		arr = #()
		if selection.count != 0 then
		(
			MatEditor.mode = #advanced
			MatEditor.Open()
			matArr = CollectUniqueMats objArr
			for i in matArr do
			(
				SME_createViewForMat i
			)
		)
		else
		(
			messageBox "**** You must have an object selected ****"
		)
	),
	
	fn SME_CreateNodeViewByFaceID_FN =
	(
		if selection.count != 1 then
		(
			messageBox "Select only a single object."
		)
		else
		(
			MatEditor.mode = #advanced
			MatEditor.Open()
			masterMat = $.material
			if classOf masterMat == multiMaterial then
			(
				faceID = (getFaceMatID $ 1)
				theMat = $.material.materialList[faceID]
				if sme.GetViewByName theMat.name == 0 then
				(
					sme.CreateView theMat.name
					newView = sme.GetView (sme.GetViewByName theMat.name)
					newView.CreateNode theMat [0,0]
				)
				else
				(
					if queryBox ("Node view..." + theMat.name + "...already exists.\nDo you want to delete it?") then
					(
						sme.DeleteView (sme.GetViewByName theMat.name) false
						sme.CreateView theMat.name
						newView = sme.GetView (sme.GetViewByName theMat.name)
						newView.CreateNode theMat [0,0]
					)
				)
			)
			else
			(
				messageBox "Selected object's material is not a Multi/Sub material."
			)
		)
	),
	
	fn SME_CreateNodeViewForEachSceneMaterial_FN =
	(
		if sceneMaterials.count != 0 then
		(
			MatEditor.mode = #advanced
			SME_deleteAllViews_FN()
			MatEditor.Open()
			for i in sceneMaterials do
			(
				if sme.GetViewByName i.name == 0 then 
				(
					sme.CreateView i.name
					newView = sme.GetView (sme.GetViewByName i.name)
					newView.CreateNode i [0,0]
				)
				else
				(
					format "***** % is a duplicate material name *****" i.name
				)
			)
		)
		else messageBox "No materials found in scene."
	),
	
--) End Slate Tools
	
--( Utilities
	
	fn DeleteEmptyLayers_FN =
	(
		currLayer = LayerManager.current
		if currLayer.name != "0" then
		(
			defLayer = LayerManager.getLayer 0
			defLayer.current = true
		)
		LayerManager.closeDialog()
		emptyLayers =#()
		for i = 0 to layerManager.count-1 do
		(
			ilayer = layerManager.getLayer i
			layerName = ilayer.name 
			layer = ILayerManager.getLayerObject i
			layer.Nodes &layerNodesArr
			if layerNodesArr.count == 0  do
			(
				append emptyLayers (layerName as string)
			)
		)
		with printAllElements on format "***** Empty Layers: % \n" emptylayers
		for i = 1 to emptyLayers.count do
		( 
			layermanager.deleteLayerByName emptyLayers[i]
		)
		LayerManager.closeDialog()
		layermanager.editlayerbyname ""
	),
	
	fn HideLayersByObjSelection objArr =
	(
		if objArr.count != 0 then
		(
			for i in objArr do
			(
				i.layer.on = false
			)
		)
		else
		(
			messageBox "Nothing selected... :(" title:"GTVFX:"
		)
	),
	
	fn IsolateLayersByObjSelection objArr =
	(
		if objArr.count != 0 then
		(
			layerArr = #()
			for i in objArr do
			(
				appendIfUnique layerArr i.layer
			)
			for i in 0 to layerManager.count-1 do
			(
				iLayer = layerManager.getLayer i
				if findItem layerArr iLayer == 0 then iLayer.on = false
			)
			true
		)
		else
		(
			messageBox "Nothing selected... :(" title:"GTVFX:"
			false
		)
	),
	
	fn SaveLayerStates layerStateArr =
	(
		if classOf layerStateArr == array then
		(
			for i in 0 to layerManager.count-1 do
			(
				iLayer = layerManager.getLayer i
				append layerStateArr #(iLayer.name, iLayer.on)
			)
		)
		else format "***** Error with layerStateArr: % *****\n" layerStateArr
	),
	
	fn RestoreLayerStates layerStateArr =
	(
		if layerStateArr != undefined and layerStateArr.count != 0 then
		(
			for i in layerStateArr do
			(
				(layerManager.getLayerFromName i[1]).on = i[2]
			)
		)
		else format "***** Error with layerStateArr: % *****\n" layerStateArr
	),
	
	fn LayIso_ui =
	(
		saveLayerStates layerStateArr
		if not (isolateLayersByObjSelection (getCurrentSelection())) then return false
		local roPos
		if doesFileExist gtbIni and hasIniSetting gtbIni "layIso_UI" "Position" then
		(
			roPos = (execute (getIniSetting gtbIni "layIso_UI" "Position")) 
		)
		else roPos = [850,420]
		rollout ro_layIso "Layer Isolate By GTVFX"
		(
			local self
			checkButton cBtn_isolate "Layers Isolated" checked:true width:(ro_layIso.width-20) height:40 
			
			fn _init pself =
			(
				self = pself
			)
			fn exitIso =
			(
				self.restoreLayerStates self.layerStateArr
				destroyDialog ro_layIso
			)
			on cBtn_isolate changed arg do
			(
				exitIso()
			)
			on ro_layIso moved pos do
			(
				setIniSetting self.gtbIni "layIso_UI" "Position" (pos as string)
			)
			on ro_layIso close do
			(
				exitIso()
			)
		)
		createDialog ro_layIso width:180 pos:roPos
		ro_layIso._init self
	),
	
	fn GarbageCollect_FN =
	(
		for i = 1 to 5 do GC()
	),
	
	fn FreeSceneBitmaps_FN =
	(
		for i = 1 to 5 do FreeSceneBitmaps()
	),
	
	fn UTIL_CollectMissingFiles_FN arr:#()=
	(
		enumerateFiles get_names arr #missing
		clearListener()
		if arr.count != 0 then for i in arr do print i
		else messageBox "***** No missing files *****"
		arr
	),
	
	fn DeleteObjArr objArr dangerClose:False =
	(
		if queryBox "Are you sure?" == true then
		(
			with undo off
			(
				if dangerClose then
				(
					disableRefMsgs()
					delete objArr
					enableRefMsgs()
				)
				else
				(
					delete objArr
				)
			)
		)			
	),
	
	fn QuickPickParent_FN =
	(
		with Undo on
		(
			parentObj = pickObject()
			$.parent =  parentObj
			select parentObj
		)
	),
	
	fn ParentToPickObjParent_FN =
	(
		with Undo on
		(
			parentObj = (pickObject()).parent
			$.parent =  parentObj
			select parentObj
		)
	),
	
	fn AlignAndLink_FN objArr =
	(
		parentObj = pickObject()
		for i in objArr do
		(
			i.parent = parentObj
			i.rotation.controller.value = (quat 0 0 0 1)
			i.position.controller.value = [0,0,0]
		)
		select parentObj
	),
	
	fn UTIL_ToggleBoxMode_FN =
	(
		if selection[1].boxmode == false then for i in selection do i.boxMode = true else for i in selection do i.boxMode = false
	),
	
	mapped fn SetObjId objArr id =
	(
		objArr.gbufferchannel = id	
	),
	
	fn UTIL_ObjId_Rollout_FN =
	(
		try(destroyDialog self.ro_ObjId)catch()
		rollout ro_ObjId "Object ID" width:170
		(
			local self
			spinner spn_objId "Object ID:" range:[0,100,0] type: #integer
			button btn_objId "Set ID" width:(ro_ObjId.width-20) height:35
			checkBox chk_Quick "Super Fast Mode!" triState:1 tooltip:"Updates the Obj ID of your selection as you update the spinner"
			fn _init pself =
			(
				self = pself
			)
			on spn_objId changed newV do
			(
				if chk_Quick.checked then
				(
					self.SetObjId selection spn_objId.value
				)
			)
			on btn_objId pressed do
			(
				self.SetObjId selection spn_objId.value
			)
		)
		createdialog ro_ObjId
		ro_ObjId._init self
	),
	
	fn GetObjMatIDs_FN =
	(
		if selection.count == 1 then
		(
			arr = #()
			case (classOf $) of
			(
				(Editable_Mesh):
					(
						numFaces = getNumFaces $
						for i in 1 to numFaces do appendIfUnique arr (getFaceMatID $ i)
					)
				(Editable_poly):
					(
						numFaces = polyop.getNumFaces $
						for i in 1 to numFaces do appendIfUnique arr (polyop.getFaceMatID $ i)
					)
				(PolyMeshObject):
					(
						numFaces = polyop.getNumFaces $
						for i in 1 to numFaces do appendIfUnique arr (polyop.getFaceMatID $ i)
					)
				default:
					(
						addModifier $ (mesh_select())
						numFaces = getNumFaces $
						for i in 1 to numFaces do appendIfUnique arr (getFaceMatID $ i)
						deleteModifier $ 1
						--arr = #("Unable to retrieve Material IDs")
					)
			)
			sort arr
			messageTxt = ""
			for i in 1 to arr.count do messageTxt += (arr[i] as string + "...\n")
			messageBox messageTxt title:"GTVFX:"
			arr
		)
		else messageBox "Select only one(1) object" title:"GTVFX: Error"
	),
	
	fn UTIL_trnsfrmLockToggle_FN =
	(
		if (getTransformLockFlags selection[1])[1] == false then
		(
			for i in selection do setTransformLockFlags i #all
			format "***** Transform Locked *****\n"
		)
		else
		(
			for i in selection do setTransformLockFlags i #none
			format "***** Transform Unlocked *****\n"
		)
	),
	fn UTIL_lockAllCams_FN =
	(
		for i in cameras do setTransformLockFlags i #all
		format "***** Cameras Locked *****\n"
	),
	
--) End Utilities
	
--( Render
	
	fn ToggleOutput_FN disable:true =
	(
		renderscenedialog.close()
		if disable then
		(
			rendTimeType = 1
			rendSaveFile = false
			if VrayIsRenderer() then
			(
				vr.output_saveRawFile = false
				vr.output_on = true
			)
		)
		else
		(
			rendTimeType = 2
			rendSaveFile = true
			if vrayIsRenderer() then
			(
				vr.output_saveRawFile = false
				vr.output_on = false
			)
		)
		renderscenedialog.open()
	),
	
	fn RNDR_ToggleMoBlur_FN =
	(
		if vrayIsRenderer() then
		(
			if vr.moblur_on == true then
			(
				vr.moblur_on = false
				format "***** MoBlur Off *****\n"
			)
			else
			(
				vr.moblur_on = true
				format  "***** MoBlur On *****\n"
			)
		)
	),
	
	fn RNDR_ToggleVRcamMoBlur_FN =
	(
		if vrayIsRenderer() then
		(
			vrCams = for i in cameras where classOf i == VRayPhysicalCamera collect i
			if vrCams.count != 0 then
			(
				if vrCams[1].use_moblur == true then
				(
					for i in vrCams do i.use_moblur = false
					format "***** VRcam MoBlur Off *****\n"
				)
				else 
				(
					for i in vrCams do i.use_moblur = true
					format "***** VRcam MoBlur On *****\n"
				)
			)
			else format "***** No VRay Physical Cameras found in your scene *****\n"
		)
	),
	
	fn RNDR_TestSettings_FN =
	(
		if vrayIsRenderer() then
		(
			renderscenedialog.close()
			rendTimeType = 1
			rendUseNet = false
			vr = renderers.current
			vr.imageSampler_type = 1
			vr.twoLevel_baseSubdivs = 1
			vr.twoLevel_fineSubdivs = 4
			vr.dmc_earlyTermination_amount = 1.0
			vr.output_saveRawFile = false
			vr.output_on = true
			vr.dmc_lockNoisePattern = false
			vr.system_lowThreadPriority = true
			vr.system_optimizedAtmospherics = true
			vr.twoLevel_useDMCSamplerThresh = false
			vr.twoLevel_threshold = 0.1
			vr.system_region_x = 24
			vr.system_region_y = 24
			renderscenedialog.open()
			format "***** VRay test settings applied *****\n"
		)
		else format "***** VRay is not the current renderer. No settings applied. *****\n"
	),
	
	fn SaveLoadRenderSettings load:false=
	(
		if not load then
		(
			storedRenderer = copy renderers.current
			format "***** Renderer Saved *****\n"
		)
		else
		(
			renderers.current = storedRenderer
			storedRenderer = copy renderers.current
			format "***** Renderer Loaded *****\n"
		)
	),
	
	fn TestStoredRenderer =
	(
		if storedRenderer == undefined then
		(
			saveLoadRenderSettings load:false
		)
		else if queryBox "There is already a current renderer stored.\nDo you want to over-write this renderer with your current settings?" title:"GTVFX" then 
		(
			saveLoadRenderSettings load:false
		)
	),
	
	fn RemoveRenderElementPaths_FN =
	(
		renderscenedialog.close()
		elmntMgr = maxOps.GetCurRenderElementMgr() 
		numElements = elmntMgr.numrenderelements()
		for i in 0 to (numElements - 1) do
		(
			if elmntMgr.GetRenderElementFilename i != undefined then
			(
				elmntMgr.SetRenderElementFilename i ""
			)
			else exit
		)
		rendOutputFilename = ""
		try(renderers.current.output_rawFileName = "")catch() -- Clears the VRay Frame Buffer if using VRay
		renderscenedialog.open()
	),
	
	fn RNDR_Gamma_FN =
	(
		try(destroyDialog self.ro_gammaSettings)catch()
		rollout ro_gammaSettings "Set gamma settings"
		(
			spinner spn_DG 	"Display Gamma	" 	range:[1,5,2.2] type:#float
			spinner spn_IG 	"Input Gamma      "  	range:[1,5,2.2] type:#float
			spinner spn_OG 	"Output Gamma	" 	range:[1,5,1.0] type:#float
			checkBox chk_gammaEnabled "Enable Gamma/LUT Correction"
			on ro_gammaSettings open do
			(
				spn_DG.value = displayGamma
				spn_IG.value = fileInGamma
				spn_OG.value = fileOutGamma
				if IDisplayGamma.colorCorrectionMode == #none then chk_gammaEnabled.state = false else chk_gammaEnabled.state = true
			)
			on spn_DG changed val do
			(
				displayGamma = val
			)
			on spn_IG changed val do
			(
				fileInGamma = val
			)
			on spn_OG changed val do
			(
				fileOutGamma = val
			)
			on chk_gammaEnabled changed state do
			(
				if state == true then
				(
					IDisplayGamma.colorCorrectionMode = #gamma
					IDisplayGamma.affectColorPickers = true
					IDisplayGamma.affectMEdit = true 
				)
				else
				(
					IDisplayGamma.colorCorrectionMode = #none
				)
			)
		) 
		createdialog ro_gammaSettings width:210 height:110
	),
	
--) End Render
	
--( Mesh Tools
	
	fn CheckIfModifiersPresent_FN objArr = 
	(
		out = False
		for i in objArr do if i.modifiers.count > 0 then
		(
			format "***** % has modifiers *****\n" i.name
			out = True
		)
		out
	),
	
	mapped fn ResetXformWithRotation_FN objArr =
	(
		saveRotation = objArr.rotation.controller.value
		savePosition = objArr.position.controller.value
		objArr.rotation.controller.value = (quat 0 0 0 0)
		objArr.position.controller.value = [0,0,0]
		resetXform objArr
		collapseStack objArr
		objArr.scale.controller.value = [1,1,1]
		objArr.rotation.controller.value = saveRotation
		objArr.position.controller.value = savePosition
	),
	
	mapped fn FastResetXform objArr =
	(
		resetXform objArr
		collapseStack objArr
	),
	
	mapped fn CenterPivot_FN objArr =
	(
		centerPivot objArr
	),
	
	fn ResetMesh objArr =
	( 
		progressStart "Rebuilding Meshes"
		inc = 100.0/objArr.count
		incU = inc
		InstanceMgr.MakeObjectsUnique objArr #individual
		for i in objArr do
		(
			mds = #()
			if i.modifiers.count != 0 then
			(
				for m = 1 to i.modifiers.count do 
				(
					if i.modifiers[m].enabled then
					(
						mds[m] = True
						i.modifiers[m].enabled = false
					)
					else mds[m] = False
				)
			)
			---make a clean shape...
			bx = box()
			objInst = instance i
			convertToPoly bx
			bx.transform = i.transform
			bx.scale.controller = ScaleXYZ()
			bx.scale.controller.value = [1,1,1]
			polyOp.attach bx objInst
			polyOp.deleteVerts bx #{1..8}
			---fix the tranform
			conType = classof i.scale.controller
			i.scale.controller = ScaleXYZ()
			i.transform = bx.transform
			i.scale.controller = conType()
			i.ObjectOffsetPos = [0,0,0]
			i.ObjectOffsetRot = quat 0 0 0 1
			i.ObjectOffsetScale = [1,1,1]
			i.baseObject = copy bx.baseObject
			for m = 1 to mds.count do
			(
				if mds[m] then i.modifiers[m].enabled = true
			)
			delete bx
			progressUpdate incU
			incU += inc
			gc()
		)
		progressEnd()
	),
	
	fn ReplaceWithInstance_FN objArr type:1 =
	(
		srcObj = (pickObject prompt:"**** Pick Source Object ****\n")
		format "***** srcObj: % *****\n" srcObj
		if srcObj == undefined then return messageBox "Pick Object Failed" title:"GTVFX:"
		if objArr.count != 0 then
		(
			arr = #()
			undo label:"GTVFX: Replace With Instance" on
			(
				arr += srcObj
				srcIndex = (findItem objArr srcObj)
				if srcIndex != 0 then
				(
					deleteItem objArr srcIndex
				)
				case type of
				(
					1:
					(
						iLayer = LayerManager.getLayerFromName srcObj.layer.name
						for i in objArr do
						(
							objInst = instance srcObj wireColor:srcObj.wireColor gbufferChannel:srcObj.gbufferchannel transform:i.transform
							objInst.parent = i.parent
							iLayer.addNode objInst
							append arr objInst
						)
						delete objArr
						select arr
					)
					2:
					(
						for i in objArr do
						(
							instanceReplace i srcObj
						)
					)
					3:
					(
						for i in objArr do
						(
							referenceReplace i srcObj
						)
					)
				)
				
			)
		)
	),
	
	fn ReplaceWithReference_FN objArr arr:#() =
	(
		if objArr.count != 0 then
		(
			undo label:"GTVFX: Replace With Reference" on
			(
				arr += obj = Pickobject()
				if (findItem objArr obj) != 0 then
				(
					deleteItem objArr (findItem objArr obj)
				)
				iLayer = LayerManager.getLayerFromName obj.layer.name
				for i in objArr do
				(
					objRef = reference obj wireColor:obj.wireColor gbufferChannel:obj.gbufferchannel transform:i.transform
					objRef.parent = i.parent
					iLayer.addNode objInst
					append arr objRef
				)
				delete objArr
				select arr
			)
		)
	),
	
	mapped fn ConvertToMesh_FN objArr =
	(
		convertToMesh objArr
	),
	
	fn ConvertToMeshWithModifierStack = 
	(
		cui.commandPanelOpen = false
		selArray = for obj in selection where superclassof obj.baseobject == geometryClass and isGroupMember obj == false collect obj
		for obj in selArray do
		(
			addmodifier obj (Mesh_Select ()) before:obj.modifiers.count
			maxOps.CollapseNodeTo obj obj.modifiers.count off
			gc()
		)
		cui.commandPanelOpen = true
		select selArray
	),
	
	fn AddSmoothModWithStack_FN = 
	(
		cui.commandPanelOpen = false
		selArray = for obj in selection where superclassof obj.baseobject == geometryClass and isGroupMember obj == false collect obj
		for obj in selArray do
		(
			addmodifier obj (smooth autoSmooth:on) before:obj.modifiers.count
			maxOps.CollapseNodeTo obj obj.modifiers.count off
		)
		cui.commandPanelOpen = true
		select selArray
	),
	
	fn AttachObjs_FN objArr garbageCollect:false =
	(
		if objArr.count < 2 then
		(
			messagebox "Must have at least 2 objects selected!"
		)
		else
		(
			with undo off
			(
				disableSceneRedraw()
				tStart = timeStamp()
				progress #start caption:"Attaching Objects:" arrCount:objArr.count
				nonGeoArr = for i in objArr where superClassOf i != geometryClass collect i
				for i in nonGeoArr do
				(
					format "***** % is not a mesh object. It will be ignored. *****\n" i.name
					deleteItem objArr (findItem objArr i)
				)							
				while objArr.count > 1 do
				(	
					for i = objArr.count to 2 by -2 do 
					(
						if (progress #cancel) then
						(
							progress #end
							return false
						)
						InstanceMgr.MakeObjectsUnique #(objArr[i], objArr[i-1]) #individual
						case (classOf objArr[i]) of
						(
							(Editable_Poly):
							(
								polyOp.attach objArr[i] objArr[i-1]
							)
							(PolymeshObject):
							(
								polyOp.attach objArr[i] objArr[i-1]
							)
							(Editable_Mesh):
							(
								attach objArr[i] objArr[i-1]
							)
							default:
							(
								if (classOf objArr[i]) != Editable_Mesh then convertToMesh objArr[i]
								attach objArr[i] objArr[i-1]
							)
						)
						deleteItem objArr (i-1)
						progress #update
						if garbageCollect then gc()
					)
				)
				cui.commandPanelOpen = true
				progress #end
				tEnd = timeStamp()
				format "Attach time: %s\n" ((tEnd-tStart)/1000.0) as string
				if (classOf objArr[1]) != Editable_Mesh then convertToMesh objArr[1]
				select objArr[1]
				enableSceneRedraw()
			)
		)
	),
	
	fn DetachPolyElements_fn sourceObj =
	(
		cui.commandPanelOpen = false
		faceCount = sourceObj.getnumfaces()
		FaceTest = ((sourceObj.getnumfaces()) != 0)
		with undo label:"GTVFX: Detach" on
		(
			progress #start caption:"Detaching Poly Elements:" arrCount:faceCount
			for i in 1 to faceCount while FaceTest do
			(
				if (progress #cancel) then
				(
					progress #end
					max undo "GTVFX: Detach"
					return false
				)
				newName = (uniquename (sourceObj.name as string))
				sourceObj.EditablePoly.SetSelection #Face #{1}
				sourceObj.selectElement()
				TargetElement = polyop.getFaceSelection sourceObj
				polyop.detachFaces sourceObj TargetElement asNode:true name:newName
				NewObj = getnodebyname newName
				resetXForm NewObj 
				convertTo NewObj (Editable_Poly)
				ResetTransform NewObj 
				ResetScale NewObj 
				ResetPivot NewObj 
				centerpivot NewObj
				FaceTest = ((sourceObj.getnumfaces()) != 0)
				progress #update
			)
			delete sourceObj
			progress #end
		)
		cui.commandPanelOpen = true
	),
	
	fn DetachSplineElements_fn sourceObj =
	(
		cui.commandPanelOpen = false
		ns = numsplines sourceObj 	
		with undo label:"GTVFX: Detach" on
		(
			progress #start caption:"Detaching Spline Elements:" arrCount:ns
			for i in 1 to ns do
			(
				if (progress #cancel) then
				(
					progress #end
					max undo "GTVFX: Detach"
					return false
				)
				tempMaster = copy sourceObj 
				tempMaster.name = (sourceObj.name + "_Element_" + (i as string))
				select tempMaster 
				setFirstSpline tempMaster i
				for x = ns to 2 by -1 do deleteSpline tempMaster x
				select sourceObj
				progress #update
			)
			delete sourceObj
			progress #end
		)
		cui.commandPanelOpen = true
	),
	
	fn DetachMeshElements_fn sourceObj =
	(
		cui.commandPanelOpen = false
		convertTo sourceObj (Editable_Poly) 
		faceCount = sourceObj.getnumfaces()
		FaceTest = ((sourceObj.getnumfaces()) != 0)
		with undo label:"GTVFX: Detach" on
		(
			progress #start caption:"Detaching Mesh Elements:" arrCount:faceCount
			for x in 1 to faceCount while FaceTest do
			(
				if (progress #cancel) then
				(
					progress #end
					max undo "GTVFX: Detach"
					return false
				)
				newName = (uniquename (sourceObj.name as string))
				sourceObj.EditablePoly.SetSelection #Face #{1}
				sourceObj.selectElement()
				TargetElement = polyop.getFaceSelection sourceObj
				polyop.detachFaces sourceObj TargetElement asNode:true name:newName
				NewObj = getnodebyname newName
				resetXForm NewObj 
				convertTo NewObj (Editable_Mesh)
				ResetTransform NewObj 
				ResetScale NewObj 
				ResetPivot NewObj 
				centerpivot NewObj
				FaceTest = ((sourceObj.getnumfaces()) != 0)
				progress #update
			)
			delete sourceObj
			progress #end
		)
		cui.commandPanelOpen = true
	),
	
	fn DetachElementsByMatID_FN objArr =
	(
		if objArr.count != 0 then
		(
			cui.commandPanelOpen = false
			with undo label:"GTVFX: DetachByMatID" on
			(
				for x in 1 to objArr.count do with redraw off
				(
					sourceObj = objArr[x]
					progress #start caption:("Detaching By MatID: "+sourceObj.name) arrCount:objArr.count
					convertTo sourceObj (Editable_Poly) 
					FaceTest = ((sourceObj.getnumfaces()) != 0)
					for matId = 1 to 9999 while faceTest do
					(
						if (progress #cancel) then
						(
							progress #end
							cui.commandPanelOpen = true
							max undo "GTVFX: DetachByMatID"
							return false
						)
						faceCount = sourceObj.getnumfaces()
						detachArr = #{}
						for i in 1 to faceCount do
						(
							if polyop.getFaceMatID sourceObj i == matId then append detachArr i
						)
						if detachArr.count > 0 then
						(
							newName = (uniquename (sourceObj.name as string))
							sourceObj.EditablePoly.SetSelection #Face detachArr
							TargetFaces = polyop.getFaceSelection sourceObj
							polyop.detachFaces sourceObj TargetFaces asNode:true name:newName
							NewObj = getnodebyname newName
							NewObj.wireColor = random [0,0,0] [255,255,255]
							resetXForm NewObj 
							convertTo NewObj (Editable_Mesh)
							ResetTransform NewObj 
							ResetScale NewObj 
							ResetPivot NewObj 
							centerpivot NewObj
							FaceTest = ((sourceObj.getnumfaces()) != 0)
						)
						progress #update
					)
					delete sourceObj
					progress #end
				)
			)
			cui.commandPanelOpen = true
		)
		else
		(
			messageBox "Nothing Selected!" title:"GTVFX: :("
		)
	),
	
	fn DetachElements objArr =
	(
		if objArr.count != 0 then
		(
			for obj in 1 to objArr.count do with redraw off
			(
				sourceObj = objArr[obj]
				case classOf sourceObj of
				(
					(editable_poly):detachPolyElements_fn sourceObj
					(SplineShape):detachSplineElements_fn sourceObj
					(Editable_Mesh):detachMeshElements_fn sourceObj
					default:format "***** % is of an unsupoorted object type. *****\n" sourceObj.name
				)
			)
			max views redraw
		)
		else messageBox "Nothing Selected!" title:"GTVFX: :("
	),
	
	fn QuadrifySelection_FN objArr = 
	(
		for i in objArr do
		(
			select i
			macros.run "PolyTools" "Quadrify"
		)
		select objArr
	),
	
--) End Mesh Tools
	
--( WireColor
	
	fn UTIL_WireColorRandom_FN objArr:selection =
	(
		if objArr.count == 0 then objArr = objects
		for i in objArr do i.wirecolor = random [20,20,20] [230,230,230]
		true
	),
	
	fn UTIL_WireColorByLayer_FN =
	(
		LayerManager.closeDialog()
		for i = 0 to layerManager.count-1 do
		(
			layer = ILayerManager.getLayerObject i
			layer.Nodes &nodeArr
			if nodeArr.count != 0  do
			(
				nodeArr.wireColor = random [20,20,20] [230,230,230]
			)
		)
		true
	),
	
	fn UTIL_WireColorByMaterial_FN objArr:selection=
	(
		if objArr.count == 0 then objArr = objects
		for i in 1 to sceneMaterials.count do
		(
			randomClor = random [20,20,20] [230,230,230]
			matObjs = for obj in objArr where obj.material == sceneMaterials[i] do ( obj.wireColor = randomClor)
		)
		true
	),
	
	fn UTIL_WireColorByObjID_FN objArr:selection=
	(
		if objArr.count == 0 then objArr = geometry
		objIDsArr = #()
		for i in objArr do appendIfUnique objIDsArr i.gBufferChannel
		for x in 1 to objIDsArr.count do
		(
			randomColor = random [20,20,20] [230,230,230]
			IDobjs = for obj in objArr where obj.gBufferChannel == objIDsArr[x] do ( obj.wireColor = randomColor)
		)
		true
	),
	
	fn UTIL_WireColorByFaceID_FN objArr:selection arr:#()=
	(
		if objArr.count == 0 then objArr = geometry
		for i in objArr do 
		(
			if classOf i == Editable_Mesh then appendIfUnique arr (getFaceMatID i 1)
			if classOf i == Editable_poly then appendIfUnique arr (polyop.getFaceMatID i 1)
		)
		for x in 1 to arr.count do
		(
			randomClor = random [20,20,20] [230,230,230]
			for obj in objArr where classOf obj == Editable_Mesh and (getFaceMatID obj 1) == arr[x] do ( obj.wireColor = randomClor)
			for obj in objArr where classOf obj == Editable_poly and (polyop.getFaceMatID obj 1) == arr[x] do ( obj.wireColor = randomClor)
		)
		true
	),
	
	fn UTIL_WirecolorByHierarchy_FN objArr:selection=
	(
		if objArr.count == 0 then objArr = objects
		for i in objArr do
		(
			childArr = getChildrenRecursive i 
			if childArr.count != 0 then
			(
				childArr.wireColor = random [20,20,20] [230,230,230]
			)
		)
		true
	),
	
	fn WireColorByInstance_FN objArr arr:#()=
	(
		for i in objArr do
		(
			if findItem arr i == 0 then
			(
				instanceArr = refs.dependentNodes i.baseObject
				deleteItem instanceArr (findItem instanceArr i)
				if instanceArr.count > 0 then
				(
					i.wirecolor = random [20,20,20] [230,230,230]
					for each in instanceArr do
					(
						appendIfUnique arr each
						each.wireColor = i.wireColor
					)
				)
				else i.wirecolor = (color 128 128 128)
			)
		)
		true
	),
	
	fn SaveObjWireColor arr =
	(
		savedWireColorArr = #()
		for i in arr do
		(
			subArr = #(i.name,i.wirecolor)
			setUserProp i "GTVFX_WireColor" i.wirecolor
			append savedWireColorArr subArr
		)
		format "***** WireColor Stored *****\n"
		savedWireColorArr
	),
	
	fn WireColorFromSave arr =
	(
		if savedWireColorArr.count != 0 then
		(
			for i in savedWireColorArr do
			(
				if getNodeByName i[1] != undefined then
				(
					(getNodeByName i[1]).wireColor = i[2]
				)
			)
		)
		else for i in arr do
		(
			if (getUserProp i "GTVFX_WireColor") != undefined then i.wireColor = execute (getUserProp i "GTVFX_WireColor")
		)
		format "***** WireColor Restored *****\n"
	),
	
--) End WireColor
	
--( Selection Tools

	fn SelGetInstances_FN =
	(
		if selection.count == 1 then
		(
			select (refs.dependentNodes $.baseObject)
		)
		else messageBox "Select one(1) object only."\
	),
	
	fn SelByMaterial_FN arr:#() =	
	(
		if selection.count == 1 then
		(
			baseMat = $.material
			for i in objects do
			(
				if i.material == oMat and i.ishidden == false then append arr i
			)
		)
		else messageBox "Select only one object."
		select arr
	),
	
	fn SelByName_FN =
	(
		if selection.count != 0 then
		(	
			objName = $.name as stringstream
			seek objName #eof
			nChars = filePos objName
			seek objName 0
			cName = readChars objName (nChars - 3)
			allObjs = execute ("$'" + cName + "*'")
			select allObjs
			hidObjs = #()
			for i in 1 to selection.count do
			(
				if selection[i].ishidden == true then
				(
					hidObjs += selection[i]
				)
			)
			deselect hidObjs
		)
		else messageBox "You must have only 1 object selected"
	),
	
	fn SelByNumFaces_FN arr:#() =
	(
		if selection.count == 1 then
		(
			baseFcount = $.mesh.numFaces
			for i in objects where superClassOf i == geometryClass and classOf i != targetObject do
			(
				if i.mesh.numFaces == baseFcount and i.ishidden == false then
				(
					append arr i
				)
			)
		)
		else messageBox "Select only one object."
		select arr
	),
	
	fn SelByNumVerts_FN arr:#() =
	(
		if selection.count == 1 then
		(
			baseVertCount = $.mesh.numVerts
			for i in objects where superClassOf i == geometryClass and classOf i != targetObject do
			(
				if i.mesh.numVerts == baseVertCount and i.isHidden == false then append arr i
			)
		)
		else messageBox "Select only one object."
		select arr
	),
	
	fn SelByModifier =
	(
		select (for i in geometry where i.modifiers.count != 0 and not i.isHidden collect (for m in i.modifiers where (classof m == classof selection[1].modifiers[1]) do exit with i))
	),
	
	fn SelectByBboxVolume obj:$ tolerance:1.0 arr:#() =
	(
		if obj == $ and selection.count != 1 then
		(
			 messageBox "Select only one object."
		)
		else
		(
			baseVol = execute ((abs (calcBboxVolume obj)) as string) -- convert value to string to avoid float value rounding discrepencies
			highVol = baseVol*tolerance
			lowVol =  baseVol/tolerance
			format "***** HighVol: % | LowVol: % *****\n" highVol lowVol
			for i in objects do
			(
				iVol = execute ((abs (calcBboxVolume i)) as string)
				
				if iVol <= highVol and iVol >= lowVol then append arr i
			)
			select arr
		)
	),
	
	fn SelectBySize_ui =
	(
		try(destroyDialog self.ro_selectBySize)catch()
		rollout ro_selectBySize "Select By Size By Gavyn Thompson" width:270 height:80
		(
			local self
			local objSel
			
			spinner spn_tol "Tolerance:" type:#float range:[1.0,999999999.0,1.0] fieldWidth:50 pos:[10,10]
			button btn_sel "Select" width:(ro_selectBySize.width/2-20) height:40 pos:[140,10]
			checkBox chk_realTime "Real-time:" pos:[20,35] 
			pickButton pck_objSel "Select Comparison Obj" width:(ro_selectBySize.width-20) message:"Select object" autoDisplay:true
			fn _init pself =
			(
				self = pself
			)
			on pck_objSel picked obj do
			(
				objSel = obj
			)
			on spn_tol changed newVal do
			(
				format "***** Spn newVal: % *****\n" newVal
				if chk_realTime.state then
				(
					if objSel == undefined then
					(
						if selection.count == 1 then
						(
							objSel = selection[1]
							self.selectByBboxVolume obj:objSel tolerance:newVal
						)
						else
						(
							messageBox "Select only one object to base the comparison on." title:"GTVFX:"
						)
					)
					else
					(
						self.selectByBboxVolume obj:objSel tolerance:newVal
					)
					format "***** objSel: % *****\n" objSel
				)
			)
			on chk_realTime changed state do
			(
				btn_sel.enabled = not state
			)
			on btn_sel pressed do
			(
				if objSel == undefined and selection.count == 1 then
				(
					self.selectByBboxVolume tolerance:spn_tol.value
				)
				else if objSel != undefined then
				(
					self.selectByBboxVolume obj:objSel tolerance:spn_tol.value
				)
				else messageBox "Select only one object or define a comparison object to continue" title:"GTVFX:"
			)
		)
		createDialog ro_selectBySize
		ro_selectBySize._init self
	),
	
	fn SelByWireColor_FN arr:#() =
	(
		if selection.count == 1 then
		(
			baseClr = $.wirecolor
			for i in objects do
			(
				if i.wirecolor == baseClr and i.ishidden == false then
				(
					append arr i
				)
			)
			select arr
		)		
		else messageBox "Only select one(1) object"
	),
	
	fn SelectEveryNth objArr nth:2 arr:#() =
	(
		for i in 1 to objArr.count by nth do
		(
			append arr objArr[i]
		)
		select arr
	),
	
	fn SelectEveryNth_UI =
	(
		rollout ro_selectEveryNth "Select Every Nth By GTVFX" width:300 height:80
		(
			local self
			local objArr
			
			spinner spn_nth "Nth Value:" type:#integer range:[2,9999,2] across:2 tooltip:"Set the Nth value to skip that number of objects between selections"
			checkBox chk_keep "Store Object Array" offset:[20,0] tooltip:"If checked this will remember your current object selection at the time that you checked it.\nNth operations will continue to be calculated based on this selection.\nOtherwise Nth operations are calculated cumulativevly as the selection is set."
			button btn_select "Select by Nth" width:(ro_selectEveryNth.width-20) height:40 tooltip:"Do it!!"
				
			fn _init pself =
			(
				self = pself
			)
			
			on spn_nth changed newVal do
			(
				if chk_keep.state and objArr != undefined then
				(
					self.selectEveryNth objArr nth:spn_nth.value
				)
			)
			
			on chk_keep changed state do
			(
				if state then objArr = getCurrentSelectioN() else objArr = undefined
			)
			
			on btn_select pressed do
			(
				if objArr == undefined then objArr = selection
				self.selectEveryNth objArr nth:spn_nth.value
			)
		)
		createDialog ro_selectEveryNth
		ro_selectEveryNth._init self
	),
	
	fn GetAbcCacheGeo =
	(
		arr = #()
		for i in (getClassInstances Alembic_Mesh_Geometry) do arr += (refs.dependentNodes i)
		arr
	),
	
	fn SelAbcCacheGeo =
	(
		select (getAbcCacheGeo())
		True
	),
	
	fn SelVRayProxyObjects_FN = 
	(
		selectCollection (collectClassObjects VRayProxy)
	),
	
	fn SelEditableMeshObjects_FN =
	(
		selectCollection (collectClassObjects Editable_Mesh )
	),
	
	fn SelNonEditMeshObjects = 
	(
		selectCollection (collectClassObjects Editable_Mesh equalTo:false)
	),
	
	fn SelEditablePolyObjects_FN =
	(
		selectCollection ((collectClassObjects Editable_Poly)+(collectClassObjects PolyMeshObject))
	),
	
	fn SelFindAnimatedObjs_FN objArr = 
	(
		selectCollection (collectAnimatedObjects objArr)
	),
	
--) End Selection Tools
	
--( Anim Tools
	
	fn SavePointCache objArr dirPath fileType sampleRate =
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
	
	fn LoadPointCache objArr dirPath fileType resetMatrix:true=
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
	
	fn BakeStandardCam_FN =
	(
		if selection.count == 1 and isKindOf $ camera then
		(
			oldCam = $
			createLayerAndSetCurrent ("###_" + oldCam[1].name + "_Baked")
			newCam = freecamera name:(oldCam[1].name + "_Baked")
			with animate on 
			(
				for t = (animationrange.start -= 5f) to (animationrange.end += 5f) do
				(
					at time t 
					(
						if oldCam.target == undefined then
						(
							in coordsys world newCam.rotation =  oldCam.rotation
							in coordsys world newCam.position =  oldCam.position
						)
						else
						(
							in coordsys world newCam.transform =  oldCam.transform
						)
						newcam.fov = oldCam.fov
					)
				)
			)
			setTransformLockFlags newCam #all
			select newCam
		)
		else messagebox "Select only the camera you wish to bake."
	),
	
	fn BakeVRayCam_FN = 
	(
		if selection.count == 1 and isKindOf $ VRayPhysicalCamera then
		(
			oldCam = $
			createLayerAndSetCurrent ("###_" + oldCam.name + "_Baked")
			VRcam = VRayPhysicalCamera()
			VRcam.name = ("VRay_" + oldCam.name as string + "_001")
			VRcam.targeted = false
			if oldCam.specify_fov == true then
			(
				VRcam.specify_fov = true
				VRcam.fov = oldCam.fov
			)
			else
			(
				VRcam.specify_fov = false
				VRcam.focal_length 	= oldCam.focal_length
			)
			VRcam.distortion_type = oldCam.distortion_type
			VRcam.lens_file = oldCam.lens_file
			VRcam.distortion_map = oldCam.distortion_map
			VRcam.lens_shift_auto = oldCam.lens_shift_auto
			VRcam.specify_focus = oldCam.specify_focus
			VRcam.exposure = oldCam.exposure
			VRcam.vignetting = oldCam.vignetting
			VRcam.type = oldCam.type
			VRcam.systemLightingUnits = oldCam.systemLightingUnits
			VRcam.systemLightingUnits = oldCam.systemLightingUnits
			VRcam.whiteBalance = oldCam.whiteBalance
			VRcam.whiteBalance_preset = oldCam.whiteBalance_preset
			VRcam.use_blades = oldCam.use_blades
			VRcam.blades_number = oldCam.blades_number
			VRcam.use_dof = oldCam.use_dof
			VRcam.use_moblur = oldCam.use_moblur
			VRcam.subdivs = oldCam.subdivs
			VRcam.clip_on = oldCam.clip_on
			VRcam.horizon_on = oldCam.horizon_on
			VRcam.legacy_ISO = oldCam.legacy_ISO
			VRcam.show_camera_cone = oldCam.show_camera_cone
			VRcam.film_width = oldCam.film_width
			VRcam.zoom_factor = oldCam.zoom_factor
			VRcam.horizontal_offset = oldCam.horizontal_offset
			VRcam.vertical_offset = oldCam.vertical_offset
			VRcam.distortion = oldCam.distortion
			VRcam.f_number = oldCam.f_number
			VRcam.target_distance = oldCam.target_distance
			VRcam.lens_shift = oldCam.lens_shift
			VRcam.lens_horShift = oldCam.lens_horShift
			VRcam.focus_distance = oldCam.focus_distance
			VRcam.dof_display_thresh = oldCam.dof_display_thresh
			VRcam.vignetting_amount = oldCam.vignetting_amount
			VRcam.shutter_speed = oldCam.shutter_speed
			VRcam.shutter_angle = oldCam.shutter_angle
			VRcam.shutter_offset = oldCam.shutter_offset
			VRcam.latency = oldCam.latency
			VRcam.ISO = oldCam.ISO
			VRcam.temperature = oldCam.temperature
			VRcam.blades_rotation = oldCam.blades_rotation
			VRcam.center_bias = oldCam.center_bias
			VRcam.anisotropy = oldCam.anisotropy
			VRcam.clip_near = oldCam.clip_near
			VRcam.clip_far = oldCam.clip_far
			VRcam.environment_near = oldCam.environment_near
			VRcam.environment_far = oldCam.environment_far
			with animate on 
			(
				for i = animationrange.start to animationrange.end do 
				(
					at time i 
					(	
						if oldCam.specify_fov == true then
						(
							if oldCam.fov.isAnimated then VRcam.fov = oldCam.fov
						)
						else
						(
							if oldCam.focal_length.isAnimated then VRcam.focal_length = oldCam.focal_length
						)
						VRcam.transform = oldCam.transform
						if oldCam.film_width.isAnimated then VRcam.film_width = oldCam.film_width
						if oldCam.zoom_factor.isAnimated then VRcam.zoom_factor = oldCam.zoom_factor
						if oldCam.horizontal_offset.isAnimated then VRcam.horizontal_offset = oldCam.horizontal_offset
						if oldCam.vertical_offset.isAnimated then VRcam.vertical_offset = oldCam.vertical_offset
						if oldCam.distortion.isAnimated then VRcam.distortion = oldCam.distortion
						if oldCam.f_number.isAnimated then VRcam.f_number = oldCam.f_number
						if oldCam.target_distance.isAnimated then VRcam.target_distance = oldCam.target_distance
						if oldCam.lens_shift.isAnimated then VRcam.lens_shift = oldCam.lens_shift
						if oldCam.lens_horShift.isAnimated then VRcam.lens_horShift = oldCam.lens_horShift
						if oldCam.focus_distance.isAnimated then VRcam.focus_distance = oldCam.focus_distance
						if oldCam.dof_display_thresh.isAnimated then VRcam.dof_display_thresh = oldCam.dof_display_thresh
						if oldCam.vignetting_amount.isAnimated then VRcam.vignetting_amount = oldCam.vignetting_amount
						if oldCam.shutter_speed.isAnimated then VRcam.shutter_speed = oldCam.shutter_speed
						if oldCam.shutter_angle.isAnimated then VRcam.shutter_angle = oldCam.shutter_angle
						if oldCam.shutter_offset.isAnimated then VRcam.shutter_offset = oldCam.shutter_offset
						if oldCam.latency.isAnimated then VRcam.latency = oldCam.latency
						if oldCam.ISO.isAnimated then VRcam.ISO = oldCam.ISO
						if oldCam.temperature.isAnimated then VRcam.temperature = oldCam.temperature
						if oldCam.blades_rotation.isAnimated then VRcam.blades_rotation = oldCam.blades_rotation
						if oldCam.center_bias.isAnimated then VRcam.center_bias = oldCam.center_bias
						if oldCam.anisotropy.isAnimated then VRcam.anisotropy = oldCam.anisotropy
						if oldCam.clip_near.isAnimated then VRcam.clip_near = oldCam.clip_near
						if oldCam.clip_far.isAnimated then VRcam.clip_far = oldCam.clip_far
						if oldCam.environment_near.isAnimated then VRcam.environment_near = oldCam.environment_near
						if oldCam.environment_far.isAnimated then VRcam.environment_far = oldCam.environment_far
					)
				)
			)
			setTransformLockFlags VRcam #all
			select VRcam
		)
		else messagebox "Select only the camera you wish to bake."
	),
	
	fn StandardCamToVRcam_focalLenth_FN = 
	(
		if selection.count == 1 and isKindOf $ camera then
		(
			oldCam = $
			createLayerAndSetCurrent ("###_" + oldCam.name + "_Baked")
			Filmback = getRendApertureWidth()
			VRcamName = ("VRay_" + oldCam.name as string + "_001")
			VRcam = VRayPhysicalCamera whiteBalance_preset:4 whiteBalance:(color 255 255 255) name:(uniqueName VRcamName) isSelected:on
			VRcam.targeted = off
			VRcam.target_distance = 100
			VRcam.specify_focus = on
			VRcam.vignetting = false
			VRcam.type = 1 --moviecamera
			VRcam.shutter_angle = 180
			VRcam.shutter_offset = -90
			VRcam.exposure = false
			VRcam.focus_distance = 10000000 as double
			VRcam.zoom_factor = 1
			VRcam.film_width = Filmback
			VRcam.parent = undefined
			VRcam.specify_fov = false
			with animate on 
			(
				for i = animationrange.start to animationrange.end do 
				(
					at time i 
					(	
						if oldCam.target == undefined then
						(
							VRcam.rotation = oldCam.rotation
							VRcam.position = oldCam.position
						)
						else
						(
							VRcam.transform = oldCam.transform
						)
						VRcam.focal_length 	= (cameraFOV.FOVtoMM oldCam.fov)
					)
				)
			)
			setTransformLockFlags VRcam #all
		)
		else messagebox "Select only the camera you wish to bake."
	),
	
	fn StandardCamToVRcam_fov_FN = 
	(
		if selection.count == 1 and isKindOf $ camera then
		(
			oldCam = $
			createLayerAndSetCurrent ("###_" + oldCam.name + "_Baked")
			filmback = getRendApertureWidth()
			VRcamName = ("VRay_" + oldCam.name as string + "_001")
			VRcam = VRayPhysicalCamera whiteBalance_preset:4 whiteBalance:(color 255 255 255) name:(uniqueName VRcamName) isSelected:on
			VRcam.targeted = off
			VRcam.target_distance = 100
			VRcam.specify_focus = on
			VRcam.vignetting = false
			VRcam.type = 1 --moviecamera
			VRcam.shutter_angle = 180
			VRcam.shutter_offset = -90
			VRcam.exposure = false
			VRcam.focus_distance = 10000000 as double
			VRcam.zoom_factor = 1
			VRcam.film_width = filmback
			VRcam.parent = undefined
			VRcam.specify_fov = true
			with animate on 
			(
				for i = animationrange.start to animationrange.end do 
				(
					at time i 
					(	
						if oldCam.target == undefined then
						(
							VRcam.rotation = oldCam.rotation
							VRcam.position = oldCam.position
						)
						else
						(
							VRcam.transform = oldCam.transform
						)
						VRcam.fov = oldCam.fov
					)
				)
			)
			setTransformLockFlags VRcam #all
		)
		else messagebox "Select only the camera you wish to bake."
	),
	
	fn VRcamToStandardCam_FN =
	(
		if selection.count == 1 and isKindOf $ VRayPhysicalCamera then
		(
			oldCam = $
			createLayerAndSetCurrent ("###_Stndrd_" + oldCam.name + "_Baked")
			newCam = freecamera name:("Stndrd_" + oldCam.name + "_Baked")
			with animate on 
			(
				for t = (animationRange.start - 5f ) to (animationRange.end + 5f) do
				(
					at time t 
					(
						if oldCam.target == undefined then
						(
							in coordsys world newCam.rotation =  oldCam.rotation
							in coordsys world newCam.position =  oldCam.position
						)
						else
						(
							in coordsys world newCam.transform =  oldCam.transform
						)
						if oldCam.specify_fov == true then
						(
							newcam.fov = oldCam.fov
						)
						else
						(
							newcam.fov = (cameraFOV.MMtoFOV oldCam.focal_length)
						)
					)
				)
			)
			setTransformLockFlags newCam #all
			select newCam
		)
		else messagebox "Select only the camera you wish to bake."
	),
	
	mapped fn BakePointToObject objArr =
	(
		createLayerAndSetCurrent "###_Anm_Baked"
		maxOps.GetDefaultTangentType &inType &outType
		maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true
		bakePointArr = #()
		if isProperty objArr "transform" == true then
		(
			bakePoint = point size:10 centerMarker:false cross:false box:true axistripod:true wirecolor:orange name:(objArr.name + "_bakePoint")
			append bakePointArr bakePoint
			with animate on 
			(
				for t = (animationRange.start - 5f) to (animationrange.end + 5f) do
				(
					at time t 
					(
						bakePoint.transform = objArr.transform
					)
				)
			)
		)	
		maxOps.setDefaultTangentType inType outType writeInCfgFile:true
		bakePointArr
	),
	
	fn BakeCamFocusDistance_FN cam obj =
	(
		with animate on 
		(
			cam.specify_focus = true
			for t = (animationRange.start - 5f) to (animationrange.end + 5f) do
			(
				at time t 
				(
					cam.focus_distance = (distance cam obj)
				)
			)
		)
		true
	),
	
	fn BakeVRCamFocus_dlg_FN =
	(
		rollout ro_bakeVRCamFocus "Bake VRay Cam Focus Distance"
		(
			local self
			group "Select Object"
			(
				label lbl_cam "Camera: "
				button btn_pickObject "Pick Object" width:200 height:30 toolTip:"Hit the button, then select the object you wish to focus on."
				label lbl_object "Focus Obj: " 
			)
			group "Bake Focus Distance"
			(
				button btn_Bake "Bake It!" width:220 height:40 toolTip:"Bake the cameras focus distance." enabled:false
			)
			fn _init pself =
			(
				self = pself
				if viewport.getCamera() == undefined then
				(
					messageBox "Set viewport to camera first"
					try(destroyDialog self.ro_bakeVRCamFocus)catch()
				)
				else
				(
					self.curCam = viewport.getCamera()
					lbl_cam.text += self.curCam.name
				)
			)
			on btn_pickObject pressed do
			(
				clearSelection()
				format "***** Select Focus Object *****\n"
				self.meshArr = #()
				self.meshArr += pickObject()
				lbl_object.text += self.meshArr[1].name
				btn_Bake.enabled = true
			)
			on btn_Bake pressed do
			(
				self.attachPointToObject_FN self.meshArr 1
				self.bakePointToObject self.attachPointArr
				delete self.attachPointArr
				if self.bakeCamFocusDistance_FN self.curCam self.bakePointArr[1] then
				(
					messageBox "Focus Distance baked."
				)
			)
		)
		createdialog ro_bakeVRCamFocus width:350 height:165
		ro_bakeVRCamFocus._init self
	),
	
	fn AttachPointToObject_FN objArr faceID = 
	(
		attachPointArr = #()
		createLayerAndSetCurrent "###_Atch_Points"
		for i in objArr do
		(
			atPoint = point name:(i.name + "_Atch") size:10 centerMarker:false cross:false box:true axistripod:true wirecolor:(color 255 0 255)
			atPoint.position.controller = attachment node:i align:true
			AttachCtrl.addNewKey atPoint.position.controller 1
			theKey = AttachCtrl.getKey atPoint.position.controller 1
			theKey.time = animationRange.start
			theKey.face = faceID
			theKey.coord = [0,1]
			append attachPointArr atPoint
		)
		select attachPointArr
		attachPointArr
	),
	
	fn PointCacheRollout_FN = 
	(
		try(destroyDialog self.ro_pointCacheHelper)catch()
		rollout ro_pointCacheHelper "Point Cache Helper By: GTVFX"
		(
			local self
			local pcPath
			local LCmod
			local cacheXT = "pc2"
			label lbl_setDir "Source Directory:" pos:[15,5] 
			editText edTxt_pcPath "" fieldWidth:330 pos:[10,20] 
			button btn_pcPath "...." width:20 height:20 pos:[350,18] tooltip:"Paste path in text field or use this button to choose path"
			spinner spn_sRate "Sample Rate:" type:#float range:[0,1,1] pos:[265,45] fieldWidth:50 enabled:false toolTip:"Set to a lower value to bake more samples per frame."
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
		createdialog ro_pointCacheHelper width:400 height:135
		ro_pointCacheHelper._init self
	),
	
	fn OffsetKeyframeRollout_FN =
	(
		try(destroyDialog self.ro_offsetKeyframes)catch()
		rollout ro_offsetKeyframes "Keyframe Offsetter" width:180 height:120
		(
			local KeyFrameOffsetImg = undefined
			checkBox chk_AllKeys "All Keys" checked:true pos:[10, 10]
			checkBox chk_SelKeys "Selected Keys" pos:[80,10]
			spinner spn_offset "Offset Amount:  " fieldWidth:50 pos:[80,35] width:72 height:16 range:[-10000,10000,0]
			button btn_OffsetKeys "Offset Keys" pos:[10,60] width:160 height:50
			fn bumpTime t delta =
			(
				t + delta
			)
			on chk_SelKeys changed state do
			(
				if chk_SelKeys.checked == true then
				(
					chk_AllKeys.checked = false
				)
			)
			on chk_AllKeys changed state do
			(
				if chk_AllKeys.checked == true then
				(
					chk_SelKeys.checked = false
				)
			)
			on btn_OffsetKeys pressed do
			(
				if chk_AllKeys.state then
				(
					mapKeys selection bumpTime spn_offset.value #allKeys
				)
				else
				(	
					mapKeys selection bumpTime spn_offset.value #selection
				)
			)
		)
		createdialog ro_offsetKeyframes
	),
	
--) End Anim Tools
	
--( Max File FNs
	
	fn CopyMaxFilePathToClipboard_FN =
	(
		setClipBoardText (maxFilePath + maxFileName)
	),
	
	fn OpenMaxFileLocation_FN =
	(
		shellLaunch "explorer" maxfilepath 
	),
	
	fn OpenRndrLocation_FN =
	(
		if doesFileExist (getFilenamePath rendOutputFilename) then shellLaunch "explorer" (getFilenamePath rendOutputFilename) else messageBox "Unable to access render path directory." title:"GTVFX: Error"
	),
	
--) End Max File FNs
	
--( Obj Properties
	
	fn CameraVisToggle_FN objArr =
	(
		val = not (objArr[1].primaryVisibility)
		toggleProperty objArr #PrimaryVisibility val
		format "***** Camera Visibility = % *****\n" val
	),
	
	fn RenderableToggle_FN objArr =
	(
		val = not (objArr[1].renderable)
		toggleProperty objArr #Renderable val
		format "***** Renderable = % *****\n" val
	),
	
	fn ReceiveShadowsToggle_FN objArr =
	(
		val = not (objArr[1].receiveshadows)
		toggleProperty objArr #receiveshadows val
		format "***** Receive Shadows = % *****\n" val
	),
	
	fn CastShadowsToggle_FN objArr =
	(
		val = not (objArr[1].castShadows)
		toggleProperty objArr #castShadows val
		format "***** Cast Shadows = % *****\n" val
	),
	
	fn ReflectionVisibilityToggle_FN objArr =
	(
		val = not (objArr[1].secondaryVisibility)
		toggleProperty objArr #secondaryVisibility val
		format "***** Visible To Reflections = % *****\n" val
	),
	
	fn ApplyAtmoToggle_FN objArr =
	(
		val = not (objArr[1].ApplyAtmospherics)
		toggleProperty objArr #ApplyAtmospherics val
		format "***** Apply Atmospherics = % *****\n" val
	),
	
--) End Obj Properties
	
--( VRay Properties
	
	fn VRay_MakeLightsInvisible_FN lightArr =
	(
		if lightArr.count != 0 then
		(
			toggleProperty lightArr #invisible True
			--for i in lightArr where isProperty i "invisible" do i.invisible = true
			format "***** All lights in % set to invisible *****\n" (lightArr as string)
		)
		else MessageBox "No objects found."
	),
	
	fn VRayMatteEnable_FN =
	(
		if getUserProp selection[1] "VRay_Matte_Enable" == undefined or getUserProp selection[1] "VRay_Matte_Enable" == false then
		(
			for i in selection do setUserProp i "VRay_Matte_Enable" true
			format "***** VR Matte Enabled *****\n"
		)
		else
		(
			for i in selection do setUserProp i "VRay_Matte_Enable" false
			format "***** VR Matte Disabled *****\n"
		)
	),
	
	fn VRayMatteAlpha_FN =
	(
		if getUserProp selection[1] "VRay_Matte_Alpha" == undefined or getUserProp selection[1] "VRay_Matte_Alpha" == 1 then
		(
			for i in selection do setUserProp i "VRay_Matte_Alpha" -1
			format "***** VR Alpha -1 *****\n"
		)
		else
		(
			for i in selection do setUserProp i "VRay_Matte_Alpha" 1
			format "***** VR Alpha 1 *****\n"
		)
	),
	
	fn VRayMatteShadow_FN =
	(
		if getUserProp selection[1] "VRay_Matte_Shadows" == undefined or getUserProp selection[1] "VRay_Matte_Shadows" == false then
		(
			for i in selection do
			(
				setUserProp i "VRay_Matte_Shadows"  true
				setUserProp i "VRay_Matte_ShadowAlpha"  true
			)
			format "***** VR Matte Shadows Enabled *****\n"
		)
		else
		(
			for i in selection do
			(
				setUserProp i "VRay_Matte_Shadows"  false
				setUserProp i "VRay_Matte_ShadowAlpha"  false
			)
			format "***** VR Matte Shadows Disabled *****\n"
		)
	),
	
	fn VRayGeomSamples_FN =
	(
		try(destroyDialog self.ro_VRgeomSamples)catch
		rollout ro_VRgeomSamples "VRay Geom Samples"
		(
			spinner spn_GeomSamples "Geom Samples" type:#integer range:[0,999,12]
			button btn_setSelection "Set >>" pos:[10,30]
			button btn_restoreDef "Default" pos:[100, 30]
			on btn_setSelection pressed do
			(
				for i in selection do
				(
					setUserProp i "VRay_MoBlur_DefaultGeomSamples" false
					setUserProp i "VRay_MoBlur_GeomSamples" spn_GeomSamples.value
				)
				format ("***** VR Geom Samples set to % *****\n") (spn_GeomSamples.value as string)
			)
			on btn_restoreDef pressed do
			(
				for i in selection do
				(
					setUserProp i "VRay_MoBlur_DefaultGeomSamples" true
					setUserProp i "VRay_MoBlur_GeomSamples" 2
				)
				format "***** VR Geom Samples set to Default *****\n"
			)
		)
		createDialog ro_VRgeomSamples
	),
	
--) End VRay Properties
	
--( UI Functions
	
	fn UiOrder =
	(
		rollout ro_uiOrder "Customize Rollout Order" width:200 height:365
		(
			local self
			local drag_node
			local drop_node
			local roArr
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local tHeight = 12
			local drag_node
			local drag_index
			local drop_index
			dotNetControl dgv_ui "System.Windows.Forms.DataGridView" height:315 --align:#left --width:(ro_uiOrder.width-46) 
			dotNetControl dNbtn_refresh "button"  height:30 --offset:[-3,0] width:(ro_uiOrder.width - 20)
			
			fn drawData dgv arr =
			(
				dgv.rows.clear()
				for a in arr do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					tempRow.SetValues #(a.title)
				)
			)
			
			fn initDgv dgv fontsize tooltip:"" =
			(
				dgv.ShowCellToolTips = False
				dgv.AllowDrop  = true
				dgv.MultiSelect = false
				dgv.AllowUserToAddRows = off
				dgv.AutoSize = on
				dgv.AutoSizeColumnsMode = dgv.AutoSizeColumnsMode.Fill
				dgv.ShowEditingIcon = dgv.RowHeadersVisible = off
				dnSelectionMode = dotNetClass "System.Windows.Forms.DataGridViewSelectionMode"
				dgv.SelectionMode = dnSelectionMode.FullRowSelect 
				dgv.AllowUserToResizeRows = false
				dgv.AllowUserToOrderColumns = false
				dgv.AllowUserToResizeColumns = false
				dgv.ColumnHeadersHeightSizeMode = dgv.ColumnHeadersHeightSizeMode.DisableResizing
				colAr = #()
				append colAr #(#text,"Rollout:",True,#left)
				for col in colAr do
				(
					dnNewColumn
					case col[1] of
					(
						(#Text):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewTextBoxColumn"
						(#Bool):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewCheckBoxColumn"
						default:dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewComboBoxColumn"
					)
					dnNewColumn.HeaderText = col[2]
					dnNewColumn.ReadOnly = col[3]
					dnAlignment = dotNetClass "System.Windows.Forms.DataGridViewContentAlignment"
					case col[4] of
					(
						#Right:		dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleRight
						#Center:	dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleCenter
						#Left:		dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleLeft
						default:	dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleLeft
					)
					dgv.columns.add dnNewColumn
				)
				--dgv.columns.item[0].width = 100
				for i in 0 to dgv.columns.count-1 do
				(
					dgv.Columns.item[i].SortMode = (dotNetClass "System.Windows.Forms.DataGridViewColumnSortMode").NotSortable
				)
				self.setDataGridColor dgv fontSize
				dgv.AlternatingRowsDefaultCellStyle.BackColor = dgv.AlternatingRowsDefaultCellStyle.BackColor.FromArgb (clrWindow.x-15) (clrWindow.y-15) (clrWindow.z-15)
				self.initToolTip dgv tooltip
			)
			
			fn _init pself =
			(
				self = pself
				roArr = roBuildOrderArr
				deleteItem roArr roArr.count
				initDgv dgv_ui tHeight tooltip:""
				drawData dgv_ui roArr
				self.initDnetBtn dNbtn_refresh "Refresh UI" tHeight style:#flat tooltip:"Press to rebuild the UI with the rollouts in your custom order"
			)
			
			on dgv_ui mouseDown arg do
			(
				if arg.button != dgv_ui.mouseButtons.left then
				(
					position = arg.Location
					hit = dgv_ui.HitTest position.X position.Y
					drag_index = hit.RowIndex
					dgv_ui.rows.item[drag_index].selected = true
					drag_node = dgv_ui.selectedRows.item[0]
					effect = dotNetclass "System.Windows.Forms.DragDropEffects"
					dgv_ui.DoDragDrop drag_node effect.move
					if drop_index <= dgv_ui.rows.count-1 then dgv_ui.rows.item[drop_index].selected = true
				)
			)
			
			on dgv_ui DragOver arg do
			(
				dragDropEffect = dotNetclass "System.Windows.Forms.DragDropEffects"
				arg.effect = dragDropEffect.move
				position = dotNetObject "System.Drawing.Point" arg.x arg.y
				position = dgv_ui.pointToClient position
				hit = dgv_ui.HitTest position.X position.Y
				if hit.RowIndex != -1 then dgv_ui.rows.item[hit.RowIndex].selected = true
			)
			
			on dgv_ui DragDrop arg do
			(
				position = dotNetObject "System.Drawing.Point" arg.x arg.y
				position = dgv_ui.pointToClient position
				hit = dgv_ui.HitTest position.X position.Y
				drop_index = hit.RowIndex
				dgv_ui.rows.removeAt drag_node.index
				dgv_ui.rows.insert drop_index drag_node
			)
			
			on dNbtn_refresh mouseDown arg do
			(
				if arg.button == dNbtn_refresh.mouseButtons.left then
				(
					roNameArr = #()
					for i in 0 to (dgv_ui.rows.count-1) do
					(
						append roNameArr dgv_ui.rows.item[i].cells.item[0].Value
					)
					roNameArr += #("Information")
					setIniSetting self.gtbIni "UI" "mainUi_rollouts" (roNameArr as string)
					try(cui.unRegisterDialogBar self.ro_toolbox)catch()
					try(destroyDialog self.ro_toolbox)catch()
					self.run()
					self.updateUi_FN()
					self.saveUI_FN()
				)
			)
			
			on ro_dnet help do
			(
				format "***** Help Coming Soon *****\n"
			)
			
			on dNbtn_refresh MouseEnter arg do
			(
				self.initToolTip dNbtn_refresh dNbtn_refresh.tag
			)
			
			on dNbtn_refresh MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		createDialog ro_uiOrder
		ro_uiOrder._init self
	),
	
	fn BreakOffRollout arrIndex =
	(
		if gtb == undefined then gtb = toolbox_lib()
		if gtb.mainUI_rollouts.count == 0 then gtb.ui()
		if arrIndex <= gtb.mainUI_rollouts.count then
		(
			try(cui.unRegisterDialogBar gtb.ro_toolbox)catch()
			try(destroyDialog gtb.ro_toolbox)catch()
			try(destroyDialog gtb.mainUI_rollouts[arrIndex])catch()
			ini_Pos = execute (getIniSetting gtb.gtbINI gtb.mainUI_rollouts[arrIndex].name "Position")
			if ini_Pos == OK do ini_Pos = [100,100]
			createDialog gtb.mainUI_rollouts[arrIndex] width:140 pos:ini_Pos
			gtb.mainUI_rollouts[arrIndex]._init gtb.self
		)
		else messageBox "No Such Rollout Index"
	),
	
	fn UpdateUI_FN =
	(
		ini_pos = execute (getIniSetting gtbINI "UI" "Position")
		ini_SizeY = getIniSetting gtbINI "UI" "SizeY"
		for i in 1 to ro_toolbox.gtSub.rollouts.count do
		(
			header = ro_toolbox.gtSub.rollouts[i].title
			if hasIniSetting gtbIni "UI" header then
			(
				ro_toolbox.gtSub.rollouts[i].open = (execute (getIniSetting gtbIni "UI" header))
			)
			else
			(
				openRoArr = #(1,2,3,5,6,14)
				if (findItem openRoArr i) != 0 then
				(
					ro_toolbox.gtSub.rollouts[i].open = true
				)
				else
				(
					ro_toolbox.gtSub.rollouts[i].open = false
				)
			)
		)
		ini_DockState = getIniSetting gtbINI "UI" "DockState"
		if substring ini_DockState 1 1 == "c" then
		(
			cui.RegisterDialogBar ro_toolbox
			cui.DockDialogBar ro_toolbox (execute ("#" + ini_DockState))
		)
		ro_toolbox.gtSub.height = ro_toolbox.height
		format "***** UI Updated *****\n"
	),
	
	fn SaveUI_FN =
	(
		setIniSetting gtbIni "UI" "startUp" (self.startUp as string)
		if (try(GetDialogPos ro_toolbox)catch(undefined)) != undefined then
		(
			setIniSetting gtbIni "UI" "SizeX" (ro_toolbox.width as string)
			setIniSetting gtbIni "UI" "SizeY" (ro_toolbox.height as string)
			for i in 1 to ro_toolbox.gtSub.rollouts.count do
			(
				setIniSetting gtbIni "UI" (ro_toolbox.gtSub.rollouts[i].title) (ro_toolbox.gtSub.rollouts[i].open as string)
			)
			format "***** % UI Saved *****\n" ro_toolbox.gtSub.caption
		)
	),
	
	fn RestoreDefaultUI_FN =
	(
		try(destroyDialog self.ro_toolbox)catch()
		defaultBuildOrder = #(ro_Save,ro_CopyPaste,ro_MatTools,ro_SlateTools,ro_Utilities,ro_Render,ro_MeshTools,ro_wireColor,ro_Selection,ro_animTools,ro_MaxFileOps,ro_ObjProps,ro_VRayProps,ro_Info)
		roNameArr = #()
		
		for i in 1 to (defaultBuildOrder.count) do
		(
			append roNameArr defaultBuildOrder[i].title
			
		)
		
		setIniSetting self.gtbIni "UI" "mainUi_rollouts" (roNameArr as string)
		setIniSetting self.gtbIni "UI" "Save Utility" (true as string)
		setIniSetting self.gtbIni "UI" "Copy/Paste" (true  as string)
		setIniSetting self.gtbIni "UI" "Material Tools" (true  as string)
		setIniSetting self.gtbIni "UI" "Slate Tools" (false  as string)
		setIniSetting self.gtbIni "UI" "Utilities" (true  as string)
		setIniSetting self.gtbIni "UI" "Render" (true  as string)
		setIniSetting self.gtbIni "UI" "Mesh Tools" (false  as string)
		setIniSetting self.gtbIni "UI" "Wire Color" (false  as string)
		setIniSetting self.gtbIni "UI" "Selection" (false  as string)
		setIniSetting self.gtbIni "UI" "Anim Tools" (false  as string)
		setIniSetting self.gtbIni "UI" "File Operations" (false  as string)
		setIniSetting self.gtbIni "UI" "Object Properties" (false  as string)
		setIniSetting self.gtbIni "UI" "VRay Properties" (false  as string)
		setIniSetting self.gtbIni "UI" "Information" (true  as string)
		self.run()
		self.updateUI_FN()
	),
	
	fn MenuBar =
	(
		rcmenu rcm_UI
		(
			local self
			local pos
			subMenu "UI Options"
			(
				menuItem itm_startup "Init on Startup"
				separator sep_1a
				subMenu "Dock"
				(
					menuItem itm_dockLeft "Dock Left"
					menuItem itm_dockRight "Dock Right"
					menuItem itm_undock "Undock"
					
				)
				separator sep_1b
				menuItem itm_callBacks "Manage Callbacks"
				separator sep_1c
				menuItem itm_arrangeUI "Rearrange UI"
				separator sep_1d
				menuItem itm_defUI "Default UI"
				menuItem itm_refresh "Refresh UI"
				menuItem itm_saveUI "Save Current UI"
			)
			on itm_startup picked do 
			(
				if itm_startup.checked then
				(
					itm_startup.checked = false
					self.startup = false
				)
				else
				(
					itm_startup.checked = true
					self.startup = true
				)
				self.saveUI_FN()
			)
			on itm_dockLeft picked do 
			(
				if self.ro_toolbox != undefined then
				(
					cui.RegisterDialogBar self.ro_toolbox
					cui.DockDialogBar self.ro_toolbox #cui_dock_left
					ini_DockState = try(cui.getDockState self.ro_toolbox)catch(undefined)
					setIniSetting self.gtbIni "UI" "DockState" (ini_DockState as string)
					itm_dockLeft.checked = true
					itm_dockRight.checked = false
				)
				else messageBox "Could not detect the Toolbox Floater.\nMake sure the floater is initialized."
			)
			on itm_dockRight picked do 
			(
				if self.ro_toolbox != undefined then
				(
					cui.RegisterDialogBar self.ro_toolbox
					cui.DockDialogBar self.ro_toolbox #cui_dock_right
					ini_DockState = try(cui.getDockState self.ro_toolbox)catch(undefined)
					setIniSetting self.gtbIni "UI" "DockState" (ini_DockState as string)
					itm_dockRight.checked = true
					itm_dockLeft.checked = false
				)
				else messageBox "Could not detect the Toolbox Floater.\nMake sure the floater is initialized."
			)
			on itm_undock picked do 
			(
				if self.ro_toolbox != undefined then
				(
					try
					(
						itm_dockRight.checked = false
						itm_dockLeft.checked = false
						ini_pos = execute (getIniSetting self.gtbINI "UI" "Position")
						cui.unRegisterDialogBar self.ro_toolbox
						ini_DockState = try(cui.getDockState self.ro_toolbox)catch(undefined)
						setIniSetting self.gtbINI "UI" "DockState" (ini_DockState as string)
						try(destroyDialog self.ro_toolbox)catch()
						self.run()
					)catch(messageBox "Something went wrong trying to undox the dialog" title:"GTVFX:")
				)
				else messageBox "Could not detect the Toolbox Floater.\nMake sure the floater is initialized."
			)
			on itm_callBacks picked do
			(
				self.callBacksUi()
			)
			on itm_defUI picked do 
			(
				self.restoreDefaultUI_FN()
				self.saveUI_FN()
			)
			on itm_arrangeUI picked do
			(
				self.uiOrder()
			)
			on itm_refresh picked do
			(
				try(cui.unRegisterDialogBar self.ro_toolbox)catch()
				try(destroyDialog self.ro_toolbox)catch()
				self.run()
				self.updateUi_FN()
			)
			on itm_saveUI picked do 
			(
				self.saveUI_FN()
			)
			fn _init pself =
			(
				self = pself
				itm_startup.checked = self.startup
				local dockState = if hasIniSetting self.gtbIni "UI" "DockState" then getIniSetting self.gtbIni "UI" "DockState"
				if dockState == "cui_dock_left" then itm_dockLeft.checked = true
				else if dockState == "cui_dock_right" then itm_dockRight.checked = true
			)
		)
	),
	
	fn Ui =
	(
		rollout ro_toolbox "Toolbox by GTVFX" width:155 height:970
		(
			local self
			subrollout gtSub "Toolbox" width:(ro_toolbox.width) height:ro_toolbox.height offset:[-12,0]
			fn _init pself = 
			(
				self = pself
			)
			on ro_toolbox moved pos do
			(
				setIniSetting self.gtbIni "UI" "Position" (pos as string)
			)
			on ro_toolbox resized val do
			(
				setIniSetting self.gtbIni "UI" "SizeY" (val.y as string)
				try(ro_toolbox.width = 150)catch()
			)
			on ro_toolbox help do
			(
				format "***** Toolbox Help Coming Soon *****\n"
			)
		)
		
		rollout ro_Save "Save Utility"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_saveInc "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_saveMajor "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_saveAndClose "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_saveInc "Save Increment" tHeight colorOffsetInt:self.priColor tooltip:"Creates an '_incrementalSave' folder in the max file root, copies the original\nmax file there with a numbered suffix, then saves current max file."
				self.initDnetBtn dNbtn_saveMajor "Save Major Version" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: For if the version number is the last part of the file name\nRight-Click: Versions up the current max file leaving the users initials on the end."
				self.initDnetBtn dNbtn_saveAndClose "Save And Close" tHeight colorOffsetInt:self.priColor tooltip:"UI provides options for shuting down or restarting your computer"
			)
			on dNbtn_saveInc mouseDown arg do 
			(
				if arg.button == dNbtn_saveInc.mouseButtons.left then
				(
					self.saveIncrement_FN()
				)
				else if arg.button == dNbtn_saveInc.mouseButtons.right then
				(
					if keyboard.controlPressed then
					(
						self.formatMacro_FN "gtvfx_saveInc" self.macroCategory ("gtvfx_saveInc | \n"+dNbtn_saveInc.tag) "gtvfx_saveInc" "gtb.saveIncrement_FN()"
						format "***** Macro Created *****\n"
					)
				)
			)
			on dNbtn_saveMajor mouseDown arg do
			(
				if arg.button == dNbtn_saveMajor.mouseButtons.left then
				(
					self.saveMajorVersion_FN userInit:true
				)
				else if arg.button == dNbtn_saveMajor.mouseButtons.right then
				(
					if keyboard.controlPressed then
					(
						self.formatMacro_FN "gtvfx_saveMjr" self.macroCategory ("gtvfx_saveMjr | \n"+dNbtn_saveMajor.tag) "gtvfx_saveMjr" "self.saveMajorVersion_FN userInit:False"
						self.formatMacro_FN "gtvfx_saveMjr_usr" "GTVFX_Toolbox" ("gtvfx_saveMjr_usr | \n"+dNbtn_saveMajor.tag) "gtvfx_saveMjr" "self.saveMajorVersion_FN userInit:True"
						format "***** Macro Created *****\n"
					)
					else
					(
						self.saveMajorVersion_FN userInit:false
					)
				)
			)
			on dNbtn_saveAndClose mouseDown arg do
			(
				if arg.button == dNbtn_saveAndClose.mouseButtons.left then
				(
					self.saveAndClose_ui()
				)
				else if arg.button == dNbtn_saveAndClose.mouseButtons.right then
				(
					if keyboard.controlPressed then
					(
						self.formatMacro_FN "gtvfx_saveAndClose" self.macroCategory ("gtvfx_saveAndClose | \n"+dNbtn_saveAndClose.tag) "gtvfx_saveAndClose" "gtb.saveAndClose_ui()"
						format "***** Macro Created *****\n"
					)
				)
			)
			on ro_Save help do
			(
				print "GTVFX Toolbox: Help Coming Soon."
			)
			on dNbtn_saveInc MouseEnter arg do
			(
				self.initToolTip dNbtn_saveInc dNbtn_saveInc.tag
			)
			on dNbtn_saveInc MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_saveMajor MouseEnter arg do
			(
				self.initToolTip dNbtn_saveMajor dNbtn_saveMajor.tag
			)
			on dNbtn_saveMajor MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_saveAndClose MouseEnter arg do
			(
				self.initToolTip dNbtn_saveAndClose dNbtn_saveAndClose.tag
			)
			on dNbtn_saveAndClose MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_CopyPaste "Copy/Paste"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_copy01 "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_copy02 "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_copy03 "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_copy04 "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_copy05 "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_copy06 "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_copy01 "Copy / Paste 01" self.tHeight colorOffsetInt:self.priColor tooltip:"Left-Click Copy | Right-Click Paste"
				self.initDnetBtn dNbtn_copy02 "Copy / Paste 02" self.tHeight colorOffsetInt:self.secColor tooltip:"Left-Click Copy | Right-Click Paste"
				self.initDnetBtn dNbtn_copy03 "Copy / Paste 03" self.tHeight colorOffsetInt:self.priColor tooltip:"Left-Click Copy | Right-Click Paste"
				self.initDnetBtn dNbtn_copy04 "Copy / Paste 04" self.tHeight colorOffsetInt:self.secColor tooltip:"Left-Click Copy | Right-Click Paste"
				self.initDnetBtn dNbtn_copy05 "Copy / Paste 05" self.tHeight colorOffsetInt:self.priColor tooltip:"Left-Click Copy | Right-Click Paste"
				self.initDnetBtn dNbtn_copy06 "Copy / Paste 06" self.tHeight colorOffsetInt:self.secColor tooltip:"Left-Click Copy | Right-Click Paste"
			)
			on dNbtn_copy01 mouseDown arg do
			(
				if arg.button == dNbtn_copy01.mouseButtons.left then
				(
					self.copy_paste "copypaste_01.max"
				)
				else if arg.button == dNbtn_copy01.mouseButtons.right then
				(
					if keyboard.controlPressed then
					(
						self.formatMacro_FN "gtvfx_copy01" self.macroCategory ("gtvfx_copy01 | \n"+dNbtn_copy01.tag) "gtvfx_copy01" "gtb.copy_paste \"copypaste_01.max\""
						format "***** Macro Created *****\n"
					)
					else
					(
						self.copy_paste "copypaste_01.max" copyArg:false
					)
				)
			)
			on dNbtn_copy02 mouseDown arg do
			(
				if arg.button == dNbtn_copy02.mouseButtons.left then
				(
					self.copy_paste "copypaste_02.max"
				)
				else if arg.button == dNbtn_copy02.mouseButtons.right then
				(
					if keyboard.controlPressed then
					(
						self.formatMacro_FN "gtvfx_copy02" self.macroCategory ("gtvfx_copy02 | \n"+dNbtn_copy02.tag) "gtvfx_copy02" "gtb.copy_paste \"copypaste_02.max\""
						format "***** Macro Created *****\n"
					)
					else
					(
						self.copy_paste "copypaste_02.max" copyArg:false
					)
				)
			)
			on dNbtn_copy03 mouseDown arg do
			(
				if arg.button == dNbtn_copy03.mouseButtons.left then
				(
					self.copy_paste "copypaste_03.max"
				)
				else if arg.button == dNbtn_copy03.mouseButtons.right then
				(
					if keyboard.controlPressed then
					(
						self.formatMacro_FN "gtvfx_copy03" self.macroCategory ("gtvfx_copy03 | \n"+dNbtn_copy03.tag) "gtvfx_copy03" "gtb.copy_paste \"copypaste_03.max\""
						format "***** Macro Created *****\n"
					)
					else
					(
						self.copy_paste "copypaste_03.max" copyArg:false
					)
				)
			)
			on dNbtn_copy04 mouseDown arg do
			(
				if arg.button == dNbtn_copy04.mouseButtons.left then
				(
					self.copy_paste "copypaste_04.max"
				)
				else if arg.button == dNbtn_copy04.mouseButtons.right then
				(
					self.copy_paste "copypaste_04.max" copyArg:false
				)
			)
			on dNbtn_copy05 mouseDown arg do
			(
				if arg.button == dNbtn_copy05.mouseButtons.left then
				(
					self.copy_paste "copypaste_05.max"
				)
				else if arg.button == dNbtn_copy05.mouseButtons.right then
				(
					self.copy_paste "copypaste_05.max" copyArg:false
				)
			)
			on dNbtn_copy06 mouseDown arg do
			(
				if arg.button == dNbtn_copy06.mouseButtons.left then
				(
					self.copy_paste "copypaste_06.max"
				)
				else if arg.button == dNbtn_copy06.mouseButtons.right then
				(
					self.copy_paste "copypaste_06.max" copyArg:false
				)
			)
			on dNbtn_copy01 MouseEnter arg do
			(
				self.initToolTip dNbtn_copy01 dNbtn_copy01.tag
			)
			on dNbtn_copy01 MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_copy02 MouseEnter arg do
			(
				self.initToolTip dNbtn_copy02 dNbtn_copy02.tag
			)
			on dNbtn_copy02 MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_copy03 MouseEnter arg do
			(
				self.initToolTip dNbtn_copy03 dNbtn_copy03.tag
			)
			on dNbtn_copy03 MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_copy04 MouseEnter arg do
			(
				self.initToolTip dNbtn_copy04 dNbtn_copy04.tag
			)
			on dNbtn_copy04 MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_copy05 MouseEnter arg do
			(
				self.initToolTip dNbtn_copy05 dNbtn_copy05.tag
			)
			on dNbtn_copy05 MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_copy06 MouseEnter arg do
			(
				self.initToolTip dNbtn_copy06 dNbtn_copy06.tag
			)
			on dNbtn_copy06 MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_MatTools "Material Tools"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_resetMedit "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selMatToMedit "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_getSelMats "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_getAllMats "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_blackMTL "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_UtilsMats "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_sveMatLib "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_loadMatLib "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_resetMedit "Reset Medit Slots" tHeight colorOffsetInt:self.priColor tooltip:"Resets the Material Editor to it's default state."
				self.initDnetBtn dNbtn_selMatToMedit "Sel Mat to Medit" tHeight colorOffsetInt:self.secColor tooltip:"Gets the material of the currently selected object and puts it into the active material slot."
				self.initDnetBtn dNbtn_getSelMats "Get Selection Mats" tHeight colorOffsetInt:self.priColor tooltip:"Collects the materials on the selected objects and uses them to populate the material editor."
				self.initDnetBtn dNbtn_getAllMats "Get Scene Mats" tHeight colorOffsetInt:self.secColor tooltip:"Collects all materials in the scene and populates the material editor with them.\nMaximum of 24 due to material editor limitations."
				self.initDnetBtn dNbtn_blackMTL "Apply Black Mtl" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Applies a black VRayLightMtl to all objects. \nRight-Click Applies a black VRayLightMtl to selection."
				self.initDnetBtn dNbtn_UtilsMats "Utility Mats" tHeight colorOffsetInt:self.secColor tooltip:"Resets the material editor and creates Red, Green, Blue, Black, and White VrayLightMtl."
				self.initDnetBtn dNbtn_sveMatLib "Save MatLib" tHeight colorOffsetInt:self.priColor tooltip:"Dialogue: Quickly save a matLib file of the selected material editor\nslot to the specified network location."
				self.initDnetBtn dNbtn_loadMatLib "Load MatLib" tHeight colorOffsetInt:self.secColor tooltip:"Applies the first material in the supplied matLib to your selection."
			)
			on dNbtn_resetMedit mouseDown arg do
			(
				if arg.button == dNbtn_resetMedit.mouseButtons.left then
				(
					self.Mat_ResetMEdit_FN()
				)
			)
			on dNbtn_selMatToMedit mouseDown arg do
			(
				if arg.button == dNbtn_selMatToMedit.mouseButtons.left then
				(
					print "To Medit"
					self.putMatToActiveMeditSlot_FN()
				)
			)
			on dNbtn_getSelMats mouseDown arg do
			(
				if arg.button == dNbtn_getSelMats.mouseButtons.left then
				(
					self.Mat_PutSelMatsToMEdit_FN selection
				)
			)
			on dNbtn_getAllMats mouseDown arg do
			(
				if arg.button == dNbtn_getAllMats.mouseButtons.left then
				(
					print "Just All"
					self.Mat_PutSceneMatstoMEdit_FN()
				)
			)
			on dNbtn_blackMTL mouseDown arg do
			(
				if arg.button == dNbtn_blackMTL.mouseButtons.left then
				(
					self.Mat_ApplyBlackMtl_FN geometry
				)
				if arg.button == dNbtn_blackMTL.mouseButtons.right then
				(
					self.Mat_ApplyBlackMtl_FN selection
				)
			)
			on dNbtn_UtilsMats mouseDown arg do
			(
				if arg.button == dNbtn_UtilsMats.mouseButtons.left then
				(
					self.Mat_createUtilMtls_FN()
				)
			)
			on dNbtn_sveMatLib mouseDown arg do
			(
				if arg.button == dNbtn_sveMatLib.mouseButtons.left then
				(
					self.Mat_SaveMatLib_FN()
				)
			)
			on dNbtn_loadMatLib mouseDown arg do
			(
				if arg.button == dNbtn_loadMatLib.mouseButtons.left then
				(
					self.ApplyMatLib_dlg_FN()
				)
			)
			on dNbtn_resetMedit MouseEnter arg do
			(
				self.initToolTip dNbtn_resetMedit dNbtn_resetMedit.tag
			)
			on dNbtn_resetMedit MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selMatToMedit MouseEnter arg do
			(
				self.initToolTip dNbtn_selMatToMedit dNbtn_selMatToMedit.tag
			)
			on dNbtn_selMatToMedit MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_getSelMats MouseEnter arg do
			(
				self.initToolTip dNbtn_getSelMats dNbtn_getSelMats.tag
			)
			on dNbtn_getSelMats MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_getAllMats MouseEnter arg do
			(
				self.initToolTip dNbtn_getAllMats dNbtn_getAllMats.tag
			)
			on dNbtn_getAllMats MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_blackMTL MouseEnter arg do
			(
				self.initToolTip dNbtn_blackMTL dNbtn_blackMTL.tag
			)
			on dNbtn_blackMTL MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_UtilsMats MouseEnter arg do
			(
				self.initToolTip dNbtn_UtilsMats dNbtn_UtilsMats.tag
			)
			on dNbtn_UtilsMats MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_sveMatLib MouseEnter arg do
			(
				self.initToolTip dNbtn_sveMatLib dNbtn_sveMatLib.tag
			)
			on dNbtn_sveMatLib MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_loadMatLib MouseEnter arg do
			(
				self.initToolTip dNbtn_loadMatLib dNbtn_loadMatLib.tag
			)
			on dNbtn_loadMatLib MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_SlateTools "Slate Tools"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_smeSelMats "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_smeFaceID "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_smeSceneMats "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_delViews "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_smeSelMats "SME By Selected" tHeight colorOffsetInt:self.priColor tooltip:"Creates an SME node view for each material applied to your object selection."
				self.initDnetBtn dNbtn_smeFaceID "SME By Face ID" tHeight colorOffsetInt:self.secColor tooltip:"If the selected objects material is a multi sub, this will get the face ID of\nface 1 of the object and create a node view of just that sub material."
				self.initDnetBtn dNbtn_smeSceneMats "SME Scene Mats" tHeight colorOffsetInt:self.priColor tooltip:"Creates a seperate node view for each scene material."
				self.initDnetBtn dNbtn_delViews "SME Del Views" tHeight colorOffsetInt:self.secColor tooltip:"Deletes all node views."
			)
			on dNbtn_smeSelMats mouseDown arg do
			(
				if arg.button == dNbtn_smeSelMats.mouseButtons.left then
				(
					self.SME_createnodeViewForObjs_FN selection
				)
			)
			on dNbtn_smeFaceID mouseDown arg do
			(
				if arg.button == dNbtn_smeFaceID.mouseButtons.left then
				(
					self.SME_createNodeViewByFaceID_FN()
				)
			)
			on dNbtn_smeSceneMats mouseDown arg do
			(
				if arg.button == dNbtn_smeSceneMats.mouseButtons.left then
				(
					self.SME_deleteAllViews_FN()
					self.SME_createNodeViewForEachSceneMaterial_FN()
				)
			)
			on dNbtn_delViews mouseDown arg do
			(
				if arg.button == dNbtn_delViews.mouseButtons.left then
				(
					self.SME_deleteAllViews_FN()
				)
			)
			on dNbtn_smeSelMats MouseEnter arg do
			(
				self.initToolTip dNbtn_smeSelMats dNbtn_smeSelMats.tag
			)
			on dNbtn_smeSelMats MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_smeFaceID MouseEnter arg do
			(
				self.initToolTip dNbtn_smeFaceID dNbtn_smeFaceID.tag
			)
			on dNbtn_smeFaceID MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_smeSceneMats MouseEnter arg do
			(
				self.initToolTip dNbtn_smeSceneMats dNbtn_smeSceneMats.tag
			)
			on dNbtn_smeSceneMats MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_delViews MouseEnter arg do
			(
				self.initToolTip dNbtn_delViews dNbtn_delViews.tag
			)
			on dNbtn_delViews MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_Utilities "Utilities"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_delEmptyLayers "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_layIso "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_cleanUp "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_delSelection "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_quickLink "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_boxMode "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_objIDassign "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_getMatIDs "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_transLock "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_delEmptyLayers "Delete Empty Layers" tHeight colorOffsetInt:self.priColor tooltip:"Deletes all empty layers."
				self.initDnetBtn dNbtn_layIso "Isolate By Layer" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Turn off all layers except those of the currently selected objects\nRight-Click: Hide the layers of all objects in your selection\nMiddle-Click: Restore layer states prior to hiding"
				self.initDnetBtn dNbtn_cleanUp "Cache Cleanup" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Garbage Collection\nRight-Click: Free Scene Bitmaps\nMiddle-Click: Collect Missing Files"
				self.initDnetBtn dNbtn_delSelection "Delete Selection" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Deletes all objects in your selection without saving an undo state\nRight-Click: Disables Reference Messages and then deletes your selection\n(Very fast, but could crash your scene if there are dependencies on any of the deleted objects)"
				self.initDnetBtn dNbtn_quickLink "Quick Linking" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Takes all objects in your selection and prompts you to pick the object you want as their parent.\nRight-Click: Aligns and Links all of the objects in your selection to the 'Picked Object'.\nMiddle-Click: Links all objects in your selection to the 'Picked Objects' parent."
				self.initDnetBtn dNbtn_boxMode "Toggle Box Mode" tHeight colorOffsetInt:self.secColor tooltip:"Toggles the Display As Box feature for the selected objects."
				self.initDnetBtn dNbtn_objIDassign "ObjID Assigner" tHeight colorOffsetInt:self.priColor tooltip:"Dialogue: Quickly assign Object IDs to objects."
				self.initDnetBtn dNbtn_getMatIDs "Get Material IDs" tHeight colorOffsetInt:self.secColor tooltip:"Returns all material IDs assigned to the selected object."
				self.initDnetBtn dNbtn_transLock "Transform Lock" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Toggles the transform lock flags for the selection.\nRight-Click: Locks the transform of all cameras in the scene."
			)
			on dNbtn_delEmptyLayers mouseDown arg do
			(
				if arg.button == dNbtn_delEmptyLayers.mouseButtons.left then
				(
					self.deleteEmptyLayers_FN()
				)
			)
			on dNbtn_layIso mouseDown arg do
			(
				if arg.button == dNbtn_layIso.mouseButtons.left then
				(
					self.layIso_ui()
				)
				else if arg.button == dNbtn_layIso.mouseButtons.right then
				(
					self.saveLayerStates self.layerStateArr
					self.hideLayersByObjSelection (getCurrentSelection())
				)
				else if arg.button == dNbtn_layIso.mouseButtons.middle then
				(
					self.restoreLayerStates self.layerStateArr
				)
			)
			on dNbtn_cleanUp mouseDown arg do
			(
				if arg.button == dNbtn_cleanUp.mouseButtons.left then
				(
					format "***** Garbage Collection *****\n"
					self.GarbageCollect_FN()
				)
				else if arg.button == dNbtn_cleanUp.mouseButtons.middle then
				(
					format "***** Collect Missing Files *****\n"
					self.UTIL_collectMissingFiles_FN()
				)
				else if arg.button == dNbtn_cleanUp.mouseButtons.right then
				(
					format "***** Free Scene Bitmaps *****\n"
					self.FreeSceneBitmaps_FN()
				)
			)
			on dNbtn_delSelection mouseDown arg do
			(
				if arg.button == dNbtn_delSelection.mouseButtons.left then
				(
					self.deleteObjArr selection dangerClose:False
				)
				else if arg.button == dNbtn_delSelection.mouseButtons.right then
				(
					self.deleteObjArr selection dangerClose:True
				)
			)
			on dNbtn_quickLink mouseDown arg do
			(
				if arg.button == dNbtn_quickLink.mouseButtons.left then
				(
					self.quickPickParent_FN()
				)
				if arg.button == dNbtn_quickLink.mouseButtons.right then
				(
					self.alignAndLink_FN selection
				)
				if arg.button == dNbtn_quickLink.mouseButtons.middle then
				(
					self.parentToPickObjParent_FN()
				)
			)
			on dNbtn_boxMode mouseDown arg do
			(
				if arg.button == dNbtn_boxMode.mouseButtons.left then
				(
					self.UTIL_toggleBoxMode_FN()
				)
			)
			on dNbtn_objIDassign mouseDown arg do
			(
				if arg.button == dNbtn_objIDassign.mouseButtons.left then
				(
					self.UTIL_objID_Rollout_FN()
				)
			)
			on dNbtn_getMatIDs mouseDown arg do
			(
				if arg.button == dNbtn_getMatIDs.mouseButtons.left then
				(
					self.GetObjMatIDs_FN()
				)
			)
			on dNbtn_transLock mouseDown arg do 
			(
				if arg.button == dNbtn_transLock.mouseButtons.left then
				(
					self.UTIL_trnsfrmLockToggle_FN()
				)
				if arg.button == dNbtn_transLock.mouseButtons.right then
				(
					self.UTIL_lockAllCams_FN()
				)
			)
			on dNbtn_delEmptyLayers MouseEnter arg do
			(
				self.initToolTip dNbtn_delEmptyLayers dNbtn_delEmptyLayers.tag
			)
			on dNbtn_delEmptyLayers MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_layIso MouseEnter arg do
			(
				self.initToolTip dNbtn_layIso dNbtn_layIso.tag
			)
			on dNbtn_layIso MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_cleanUp MouseEnter arg do
			(
				self.initToolTip dNbtn_cleanUp dNbtn_cleanUp.tag
			)
			on dNbtn_cleanUp MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_delSelection MouseEnter arg do
			(
				self.initToolTip dNbtn_delSelection dNbtn_delSelection.tag
			)
			on dNbtn_delSelection MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_quickLink MouseEnter arg do
			(
				self.initToolTip dNbtn_quickLink dNbtn_quickLink.tag
			)
			on dNbtn_quickLink MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_boxMode MouseEnter arg do
			(
				self.initToolTip dNbtn_boxMode dNbtn_boxMode.tag
			)
			on dNbtn_boxMode MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_objIDassign MouseEnter arg do
			(
				self.initToolTip dNbtn_objIDassign dNbtn_objIDassign.tag
			)
			on dNbtn_objIDassign MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_getMatIDs MouseEnter arg do
			(
				self.initToolTip dNbtn_getMatIDs dNbtn_getMatIDs.tag
			)
			on dNbtn_getMatIDs MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_transLock MouseEnter arg do
			(
				self.initToolTip dNbtn_transLock dNbtn_transLock.tag
			)
			on dNbtn_transLock MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_Render "Render"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_disableOutput "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_toggleMoBlur "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_testRndr "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_saveRndrer "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_gamma "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_disableOutput "Disable Output" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Disables the output in the common tab and, if using VRay, disables the VRay VFB output.\nRight-Click: Sets Active Time Segment, Disables VRay VFB, Enables File Save."
				self.initDnetBtn dNbtn_toggleMoBlur "Toggle MoBlur" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Toggles VRay Motion Blur from the render dialog\nRight-Click Toggles motion blur of VRay Cams."
				self.initDnetBtn dNbtn_testRndr "Test Settings" tHeight colorOffsetInt:self.priColor tooltip:"For VRAY: Sets min/max DMC samples to 1/3 and addaptive amount to 1.0.\nAlso saves the current settings so that you can restore them with the below button."
				self.initDnetBtn dNbtn_saveRndrer "Store Renderer" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Save your current render settings.\nRight-Click: Restore the saved render settings."
				self.initDnetBtn dNbtn_gamma "Gamma" tHeight colorOffsetInt:self.priColor tooltip:"Opens a dialog to quickly set system gamma settings."
			)
			on dNbtn_disableOutput mouseDown arg do
			(
				if arg.button == dNbtn_disableOutput.mouseButtons.left then
				(
					self.ToggleOutput_FN disable:True
				)
				if arg.button == dNbtn_disableOutput.mouseButtons.right then
				(
					self.ToggleOutput_FN disable:False
				)
			)
			on dNbtn_toggleMoBlur mouseDown arg do
			(
				if arg.button == dNbtn_toggleMoBlur.mouseButtons.left then
				(
					self.RNDR_toggleMoBlur_FN()
				)
				if arg.button == dNbtn_toggleMoBlur.mouseButtons.right then
				(
					self.RNDR_toggleVRcamMoBlur_FN()
				)
			)
			on dNbtn_testRndr mouseDown arg do
			(
				if arg.button == dNbtn_testRndr.mouseButtons.left then
				(
					self.TestStoredRenderer()
					self.RNDR_testSettings_FN()
				)
			)
			on dNbtn_saveRndrer mouseDown arg do
			(
				if arg.button == dNbtn_saveRndrer.mouseButtons.left then
				(
					self.SaveLoadRenderSettings load:False
				)
				if arg.button == dNbtn_saveRndrer.mouseButtons.right then
				(
					self.SaveLoadRenderSettings load:True
				)
			)
			on dNbtn_gamma mouseDown arg do
			(
				if arg.button == dNbtn_gamma.mouseButtons.left then
				(
					self.RNDR_Gamma_FN()
				)
			)
			on dNbtn_disableOutput MouseEnter arg do
			(
				self.initToolTip dNbtn_disableOutput dNbtn_disableOutput.tag
			)
			on dNbtn_disableOutput MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_toggleMoBlur MouseEnter arg do
			(
				self.initToolTip dNbtn_toggleMoBlur dNbtn_toggleMoBlur.tag
			)
			on dNbtn_toggleMoBlur MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_testRndr MouseEnter arg do
			(
				self.initToolTip dNbtn_testRndr dNbtn_testRndr.tag
			)
			on dNbtn_testRndr MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_saveRndrer MouseEnter arg do
			(
				self.initToolTip dNbtn_saveRndrer dNbtn_saveRndrer.tag
			)
			on dNbtn_saveRndrer MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_gamma MouseEnter arg do
			(
				self.initToolTip dNbtn_gamma dNbtn_gamma.tag
			)
			on dNbtn_gamma MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_MeshTools "Mesh Tools"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_xForm "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_centerPivot "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_resetMesh "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_repInst "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_convrtMsh "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_attachSel "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_detachElements "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_quadrify "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_xForm "Smart Reset XForm" tHeight colorOffsetInt:self.priColor tooltip:"Resets the transform of the selected objects while maintaining world\nspace rotation so that the bounding box doesn't change."
				self.initDnetBtn dNbtn_centerPivot "Center Pivot" tHeight colorOffsetInt:self.secColor tooltip:"Quickly center the pivot of all objects in your selection"
				self.initDnetBtn dNbtn_resetMesh "Reset Mesh" tHeight colorOffsetInt:self.priColor tooltip:"For each object in your selection this will create a box, attach the object to it and then\ndelete the box. Currently maintains Transform,Wirecolor, Name, Parent, Material, GbufferID."
				self.initDnetBtn dNbtn_repInst "Replace With Inst" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Replaces the selected objects with an instance of a Picked object\nRight-Click: Replaces the base object of your current selection with an instance of a Picked object\nMiddle-Click: Replaces the base object of your current selection with a reference of a Picked object"
				self.initDnetBtn dNbtn_convrtMsh "Convert To Mesh" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Quckly convert all objects in selection to Editable Mesh object. Collapses Stack\nRight-Click: Use with objects with a modifier stack that needs to be maintained\nSorts through all objects in selection and converts the baseObject to Editable Mesh"
				self.initDnetBtn dNbtn_attachSel "Attach Objects" tHeight colorOffsetInt:self.secColor tooltip:"A very fast and memory efficient way to collapse objects together.\nLeft-Click: Fastest Method but uses more memory\nRight-Click: Slower but uses far less memory"
				self.initDnetBtn dNbtn_detachElements "Detach Elements" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Takes all objects in selection and parses them to their separate elements.Works with Edit Poly, Edit Mesh, and Edit Spline\nRight-Click: Takes all objects in selection and parses them according to their material ID"
				self.initDnetBtn dNbtn_quadrify "Quadrify Selection" tHeight colorOffsetInt:self.secColor tooltip:"Uses the 3dsMax function to rid the mesh of triangles. Works on all objects in selection."
			)
			on dNbtn_xForm mouseDown arg do
			(
				if arg.button == dNbtn_xForm.mouseButtons.left then
				(
					self.ResetXformWithRotation_FN selection
				)
				else if arg.button == dNbtn_xForm.mouseButtons.right then
				(
					self.FastResetXform selection
				)
			)
			on dNbtn_centerPivot mouseDown arg do
			(
				if arg.button == dNbtn_centerPivot.mouseButtons.left then
				(
					CenterPivot_FN Selection
				)
			)
			on dNbtn_resetMesh mouseDown arg do
			(
				if arg.button == dNbtn_resetMesh.mouseButtons.left then
				(
					self.ResetMesh (getCurrentSelection())
				)
			)
			on dNbtn_repInst mouseDown arg do
			(
				dNbtn_repInst.Enabled = False
				if arg.button == dNbtn_repInst.mouseButtons.left then
				(
					self.ReplaceWithInstance_FN (GetCurrentSelection()) type:1
				)
				else if arg.button == dNbtn_repInst.mouseButtons.right then
				(
					self.ReplaceWithInstance_FN (GetCurrentSelection()) type:2
				)
				else if arg.button == dNbtn_repInst.mouseButtons.middle then
				(
					self.ReplaceWithInstance_FN (GetCurrentSelection()) type:3
				)
				dNbtn_repInst.Enabled = True
			)
			on dNbtn_convrtMsh mouseDown arg do
			(
				if arg.button == dNbtn_convrtMsh.mouseButtons.left then
				(
					self.ConvertToMesh_FN selection
				)
				if arg.button == dNbtn_convrtMsh.mouseButtons.right then
				(
					self.convertToMeshWithModifierStack()
				)
			)
			on dNbtn_attachSel mouseDown arg do
			(
				if arg.button == dNbtn_attachSel.mouseButtons.left then
				(
					if (self.checkIfModifiersPresent_FN selection) == true then
					(
						if queryBox "Modifier Present: Do you want to proceed anyway?" title:"Modifiers Present" == true then
						(
							self.attachObjs_FN (getCurrentSelection())
						)
						else select self.modObjsArr
					)
					else
					(
						self.attachObjs_FN (getCurrentSelection())
					)
				)
				else if arg.button == dNbtn_attachSel.mouseButtons.right then
				(
					if (self.checkIfModifiersPresent_FN selection) == true then
					(
						if queryBox "Modifier Present: Do you want to proceed anyway?" title:"Modifiers Present" == true then
						(
							self.attachObjs_FN (getCurrentSelection()) garbageCollect:true
						)
						else select self.modObjsArr
					)
					else
					(
						self.attachObjs_FN (getCurrentSelection()) garbageCollect:true
					)
				)
			)
			on dNbtn_detachElements mouseDown arg do
			(
				if arg.button == dNbtn_detachElements.mouseButtons.left then
				(
					self.detachElements (getCurrentSelection())
				)
				if arg.button == dNbtn_detachElements.mouseButtons.right then
				(
					self.detachElementsByMatID_FN (getCurrentSelection())
				)
			)
			on dNbtn_quadrify mouseDown arg do
			(
				if arg.button == dNbtn_quadrify.mouseButtons.left then
				(
					self.quadrifySelection_FN (getCurrentSelection())
				)
			)
			on dNbtn_xForm MouseEnter arg do
			(
				self.initToolTip dNbtn_xForm dNbtn_xForm.tag
			)
			on dNbtn_xForm MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_centerPivot MouseEnter arg do
			(
				self.initToolTip dNbtn_centerPivot dNbtn_centerPivot.tag
			)
			on dNbtn_centerPivot MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_resetMesh MouseEnter arg do
			(
				self.initToolTip dNbtn_resetMesh dNbtn_resetMesh.tag
			)
			on dNbtn_resetMesh MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_repInst MouseEnter arg do
			(
				self.initToolTip dNbtn_repInst dNbtn_repInst.tag
			)
			on dNbtn_repInst MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_convrtMsh MouseEnter arg do
			(
				self.initToolTip dNbtn_convrtMsh dNbtn_convrtMsh.tag
			)
			on dNbtn_convrtMsh MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_attachSel MouseEnter arg do
			(
				self.initToolTip dNbtn_attachSel dNbtn_attachSel.tag
			)
			on dNbtn_attachSel MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_detachElements MouseEnter arg do
			(
				self.initToolTip dNbtn_detachElements dNbtn_detachElements.tag
			)
			on dNbtn_detachElements MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_quadrify MouseEnter arg do
			(
				self.initToolTip dNbtn_quadrify dNbtn_quadrify.tag
			)
			on dNbtn_quadrify MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_wireColor "Wire Color"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_wireColorRandom "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorLayer "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorMaterial "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorObjID "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorMatID "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorhierarchy "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorInstance "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_wireColorSave "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_wireColorRandom "Random" tHeight colorOffsetInt:self.priColor tooltip:"Gives each object a randomly generated wire color\nIf you have objects selected it will only work on those objects"
				self.initDnetBtn dNbtn_wireColorLayer "By Layer" tHeight colorOffsetInt:self.secColor tooltip:"Each object gets a unique wire color based on it's layer"
				self.initDnetBtn dNbtn_wireColorMaterial "By Material" tHeight colorOffsetInt:self.priColor tooltip:"Each object gets a unique wire color based on it's Material.\nIf you have objects selected it will only work on those objects"
				self.initDnetBtn dNbtn_wireColorObjID "By Obj ID" tHeight colorOffsetInt:self.secColor tooltip:"Each object gets a unique wire color based on it's Object ID.\nIf you have objects selected it will only work on those objects"
				self.initDnetBtn dNbtn_wireColorMatID "By Mat ID" tHeight colorOffsetInt:self.priColor tooltip:"Based on the MatID of face 1 of the mesh.\nIf you have objects selected it will only work on those objects"
				self.initDnetBtn dNbtn_wireColorhierarchy "By Hierarchy" tHeight colorOffsetInt:self.secColor tooltip:"Gives all children of your currently selected object the same wire color\nIf you have objects selected it will only work on those objects"
				self.initDnetBtn dNbtn_wireColorInstance "By Instance" tHeight colorOffsetInt:self.priColor tooltip:"Gives all Instanced objects the same wirecolor and all objects without an instance gray"
				self.initDnetBtn dNbtn_wireColorSave "Save / Restore" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Stores the wireColor of objects allowing you to temporarily change them\nRight-Click: Restores the wirecolors as they were when saved"
			)
			on dNbtn_wireColorRandom mouseDown arg do
			(
				if arg.button == dNbtn_wireColorRandom.mouseButtons.left then
				(
					self.UTIL_wireColorRandom_FN()
				)
			)
			on dNbtn_wireColorLayer mouseDown arg do
			(
				if arg.button == dNbtn_wireColorLayer.mouseButtons.left then
				(
					self.UTIL_wireColorByLayer_FN()
				)
			)
			on dNbtn_wireColorMaterial mouseDown arg do
			(
				if arg.button == dNbtn_wireColorMaterial.mouseButtons.left then
				(
					self.UTIL_wireColorByMaterial_FN()
				)
			)
			on dNbtn_wireColorObjID mouseDown arg do
			(
				if arg.button == dNbtn_wireColorObjID.mouseButtons.left then
				(
					self.UTIL_wireColorByObjID_FN()
				)
			)
			on dNbtn_wireColorMatID mouseDown arg do
			(
				if arg.button == dNbtn_wireColorMatID.mouseButtons.left then
				(
					self.UTIL_wireColorByFaceID_FN()
				)
			)
			on dNbtn_wireColorhierarchy mouseDown arg do
			(
				if arg.button == dNbtn_wireColorhierarchy.mouseButtons.left then
				(
					self.UTIL_wirecolorByHierarchy_FN()
				)
			)
			on dNbtn_wireColorInstance mouseDown arg do
			(
				if arg.button == dNbtn_wireColorInstance.mouseButtons.left then
				(
					self.saveObjWireColor objects
					self.wireColorByInstance_FN objects
				)
			)
			on dNbtn_wireColorSave mouseDown arg do
			(
				if arg.button == dNbtn_wireColorSave.mouseButtons.left then
				(
					self.saveObjWireColor objects
				)
				else if arg.button == dNbtn_wireColorSave.mouseButtons.right then
				(
					self.wireColorFromSave objects
				)
			)
			on dNbtn_wireColorRandom MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorRandom dNbtn_wireColorRandom.tag
			)
			on dNbtn_wireColorRandom MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorLayer MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorLayer dNbtn_wireColorLayer.tag
			)
			on dNbtn_wireColorLayer MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorMaterial MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorMaterial dNbtn_wireColorMaterial.tag
			)
			on dNbtn_wireColorMaterial MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorObjID MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorObjID dNbtn_wireColorObjID.tag
			)
			on dNbtn_wireColorObjID MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorMatID MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorMatID dNbtn_wireColorMatID.tag
			)
			on dNbtn_wireColorMatID MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorhierarchy MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorhierarchy dNbtn_wireColorhierarchy.tag
			)
			on dNbtn_wireColorhierarchy MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorInstance MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorInstance dNbtn_wireColorInstance.tag
			)
			on dNbtn_wireColorInstance MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_wireColorSave MouseEnter arg do
			(
				self.initToolTip dNbtn_wireColorSave dNbtn_wireColorSave.tag
			)
			on dNbtn_wireColorSave MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_Selection "Selection Tools"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_selNumFaces "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selByNumVerts "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selByBbox "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selWireClr "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selName "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selByMat "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selByNth "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selInstance "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selVproxies "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selAbcGeo "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selPoly "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selMesh "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_selAnim "button" width:bWidth height:bHeight offset:[-8,0]
			
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_selNumFaces "By Number of Faces" tHeight colorOffsetInt:self.priColor tooltip:"Selects all objects with the same face count as the currently selected object."
				self.initDnetBtn dNbtn_selByNumVerts "By Number of Verts" tHeight colorOffsetInt:self.secColor tooltip:"Selects all objects with the same vertex count as the currently selected object."
				self.initDnetBtn dNbtn_selByBbox "By Bounding Box Size" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Selects all objects with the same bounding box volume as the currently selected object.\nRight-Click: Launches a UI where you can set a tolerance for the size comparison."
				self.initDnetBtn dNbtn_selWireClr "By Wire Color" tHeight colorOffsetInt:self.secColor tooltip:"Selects all objects with the same wire color as the currently selected object."
				self.initDnetBtn dNbtn_selName "By Name" tHeight colorOffsetInt:self.priColor tooltip:"Selects all objects with the same name as the currently selected object parsing numbers on the end of the name."
				self.initDnetBtn dNbtn_selByMat "By Material" tHeight colorOffsetInt:self.secColor tooltip:"Selects all objects with the same material as the currently selected object."
				self.initDnetBtn dNbtn_selByNth "Every Nth" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Gets every second object in your selection\nRight-Click: Launches a UI to choose Nth value"
				self.initDnetBtn dNbtn_selInstance "Get Instances" tHeight colorOffsetInt:self.priColor tooltip:"Selects all instances of the currently selected object."
				self.initDnetBtn dNbtn_selVproxies "All VRayProxies" tHeight colorOffsetInt:self.secColor tooltip:"Selects all VRay Porxy objects in the scene."
				self.initDnetBtn dNbtn_selAbcGeo "All Alembic Geo" tHeight colorOffsetInt:self.priColor tooltip:"Selects all objects with Alembic_Mesh_Geometry mods."
				self.initDnetBtn dNbtn_selPoly "All Edit Poly" tHeight colorOffsetInt:self.secColor tooltip:"Selects all Edit Poly objects in the scene."
				self.initDnetBtn dNbtn_selMesh "All Edit Mesh" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Selects all Edit Mesh objects in the scene.\nRight-Click: Selects all Non Edit_Mesh objects."
				self.initDnetBtn dNbtn_selAnim "Animated Objects" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Finds animated objects within your current selection.\nRight-Click: Finds all animated objects."
			)
			on dNbtn_selNumFaces mouseDown arg do
			(
				if arg.button == dNbtn_selNumFaces.mouseButtons.left then
				(
					self.SelByNumFaces_FN()
				)
			)
			on dNbtn_selByNumVerts mouseDown arg do
			(
				if arg.button == dNbtn_selByNumVerts.mouseButtons.left then
				(
					self.selByNumVerts_FN()
				)
			)
			on dNbtn_selByBbox mouseDown arg do
			(
				if arg.button == dNbtn_selByBbox.mouseButtons.left then
				(
					self.selectByBboxVolume()
				)
				else if arg.button == dNbtn_selByBbox.mouseButtons.right then
				(
					self.selectBySize_ui()
				)
			)
			on dNbtn_selWireClr mouseDown arg do
			(
				if arg.button == dNbtn_selWireClr.mouseButtons.left then
				(
					self.SelByWireColor_FN()
				)
			)
			on dNbtn_selName mouseDown arg do
			(
				if arg.button == dNbtn_selName.mouseButtons.left then
				(
					self.SelByName_FN()
				)
			)
			on dNbtn_selByMat mouseDown arg do
			(
				if arg.button == dNbtn_selByMat.mouseButtons.left then
				(
					self.SelByMaterial_FN()
				)
			)
			on dNbtn_selByNth mouseDown arg do
			(
				if arg.button == dNbtn_selByNth.mouseButtons.left then
				(
					self.selectEveryNth selection
				)
				else if arg.button == dNbtn_selByNth.mouseButtons.right then
				(
					self.selectEveryNth_UI()
				)
			)
			on dNbtn_selInstance mouseDown arg do
			(
				if arg.button == dNbtn_selInstance.mouseButtons.left then
				(
					self.SelGetInstances_FN()
				)
			) 
			on dNbtn_selVproxies mouseDown arg do
			(
				if arg.button == dNbtn_selVproxies.mouseButtons.left then
				(
					self.selVRayProxyObjects_FN()
				)
			) 
			on dNbtn_selAbcGeo mouseDown arg do
			(
				if arg.button == dNbtn_selAbcGeo.mouseButtons.left then
				(
					self.SelAbcCacheGeo()
				)
			) 
			on dNbtn_selPoly mouseDown arg do
			(
				if arg.button == dNbtn_selPoly.mouseButtons.left then
				(
					self.SelEditablePolyObjects_FN()
				)
			) 
			on dNbtn_selMesh mouseDown arg do
			(
				if arg.button == dNbtn_selMesh.mouseButtons.left then
				(
					self.SelEditableMeshObjects_FN()
				)
				else if arg.button == dNbtn_selMesh.mouseButtons.right then
				(
					self.SelNonEditMeshObjects()
				)
			) 
			on dNbtn_selAnim mouseDown arg do
			(
				if arg.button == dNbtn_selAnim.mouseButtons.left then
				(
					self.SelFindAnimatedObjs_FN selection
				)
				else if arg.button == dNbtn_selAnim.mouseButtons.right then
				(
					self.SelFindAnimatedObjs_FN objects
				)
			)
			on dNbtn_selNumFaces MouseEnter arg do
			(
				self.initToolTip dNbtn_selNumFaces dNbtn_selNumFaces.tag
			)
			on dNbtn_selNumFaces MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selByNumVerts MouseEnter arg do
			(
				self.initToolTip dNbtn_selByNumVerts dNbtn_selByNumVerts.tag
			)
			on dNbtn_selByNumVerts MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selByBbox MouseEnter arg do
			(
				self.initToolTip dNbtn_selByBbox dNbtn_selByBbox.tag
			)
			on dNbtn_selByBbox MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selWireClr MouseEnter arg do
			(
				self.initToolTip dNbtn_selWireClr dNbtn_selWireClr.tag
			)
			on dNbtn_selWireClr MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selName MouseEnter arg do
			(
				self.initToolTip dNbtn_selName dNbtn_selName.tag
			)
			on dNbtn_selName MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selByMat MouseEnter arg do
			(
				self.initToolTip dNbtn_selByMat dNbtn_selByMat.tag
			)
			on dNbtn_selByMat MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selByNth MouseEnter arg do
			(
				self.initToolTip dNbtn_selByNth dNbtn_selByNth.tag
			)
			on dNbtn_selByNth MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selInstance MouseEnter arg do
			(
				self.initToolTip dNbtn_selInstance dNbtn_selInstance.tag
			)
			on dNbtn_selInstance MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selVproxies MouseEnter arg do
			(
				self.initToolTip dNbtn_selVproxies dNbtn_selVproxies.tag
			)
			on dNbtn_selVproxies MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selAbcGeo MouseEnter arg do
			(
				self.initToolTip dNbtn_selAbcGeo dNbtn_selAbcGeo.tag
			)
			on dNbtn_selAbcGeo MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selPoly MouseEnter arg do
			(
				self.initToolTip dNbtn_selPoly dNbtn_selPoly.tag
			)
			on dNbtn_selPoly MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selMesh MouseEnter arg do
			(
				self.initToolTip dNbtn_selMesh dNbtn_selMesh.tag
			)
			on dNbtn_selMesh MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_selAnim MouseEnter arg do
			(
				self.initToolTip dNbtn_selAnim dNbtn_selAnim.tag
			)
			on dNbtn_selAnim MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_animTools "Anim Tools"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_bakeStandardCam "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_bakeVRcam "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_VRCamFocus "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_standardToVRcam "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_VRtoStandardCam "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_bakePointToObj "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_attachPointToObj "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_frameOffset "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_PointCache "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_bakeStandardCam "Bake Standard Cam" tHeight colorOffsetInt:self.priColor tooltip:"Bakes the transform and FOV from the selected cam to a new Free Camera.\nBakes an additional 5 frames before and after the animation range."
				self.initDnetBtn dNbtn_bakeVRcam "Bake VRay Cam" tHeight colorOffsetInt:self.secColor tooltip:"Bakes the transform and FOV from the selected cam to a new Free Camera.\nBakes an additional 5 frames before and after the animation range."
				self.initDnetBtn dNbtn_VRCamFocus "Bake VR Camera Focus" tHeight colorOffsetInt:self.priColor tooltip:"Launches a dialog to bake out the focus distance of a VR Cam to a selected object."
				self.initDnetBtn dNbtn_standardToVRcam "Max Camera to VRay" tHeight colorOffsetInt:self.secColor tooltip:"Left-Click: Bakes the camera to a VRay Cam with focal-lenght animation.\nRight-Click: Bakes the camera to a VRay Cam with FOV animation"
				self.initDnetBtn dNbtn_VRtoStandardCam "VRay Camera to Max" tHeight colorOffsetInt:self.priColor tooltip:"Bakes the VRay camera to a standard camera with animated FOV."
				self.initDnetBtn dNbtn_bakePointToObj "Bake Point To Object" tHeight colorOffsetInt:self.secColor tooltip:"Bakes the position and rotation of all objects in selection to a point helper."
				self.initDnetBtn dNbtn_attachPointToObj "Attach Point to Obj" tHeight colorOffsetInt:self.priColor tooltip:"Creates a point with an attachment contstraint to faceID 1 for all objects in selection."
				self.initDnetBtn dNbtn_frameOffset "Offset Key Frames" tHeight colorOffsetInt:self.secColor tooltip:"Dialogue: Takes either all or the selected keyframes of objects and offsets them the specified amount."
				self.initDnetBtn dNbtn_PointCache "Point Cache Helper" tHeight colorOffsetInt:self.priColor tooltip:"Dialogue: Quickly pointcache all objects in selection to the specified folder. Creates one file per object with the same name as the object."
			)
			on dNbtn_bakeStandardCam mouseDown arg do
			(
				if arg.button == dNbtn_bakeStandardCam.mouseButtons.left then
				(
					self.bakeStandardCam_FN()
				)
			) 
			on dNbtn_bakeVRcam mouseDown arg do
			(
				if arg.button == dNbtn_bakeVRcam.mouseButtons.left then
				(
					self.bakeVRayCam_FN()
				)
			)
			on dNbtn_VRCamFocus mouseDown arg do
			(
				if arg.button == dNbtn_VRCamFocus.mouseButtons.left then
				(
					if viewport.getCamera() == undefined then
					(
						self.curCam = selectByName title:"Select the VRay Camera:" buttonText:"Set Camera" filter:self.VRcamera_filt single:true
					)
					if self.curCam != undefined then
					(	
						viewport.setCamera self.curCam 
						self.bakeVRCamFocus_dlg_FN()
					)
					else messageBox "Could not find the camera."
				)
			)
			on dNbtn_standardToVRcam mouseDown arg do
			(
				if arg.button == dNbtn_standardToVRcam.mouseButtons.left then
				(
					self.standardCamToVRcam_focalLenth_FN()
				)
				else if arg.button == dNbtn_standardToVRcam.mouseButtons.right then
				(
					self.standardCamToVRcam_fov_FN()
				)
			)
			on dNbtn_VRtoStandardCam mouseDown arg do
			(
				if arg.button == dNbtn_VRtoStandardCam.mouseButtons.left then
				(
					self.VRcamToStandardCam_FN()
				)
			) 
			on dNbtn_bakePointToObj mouseDown arg do
			(
				if arg.button == dNbtn_bakePointToObj.mouseButtons.left then
				(
					self.bakePointToObject selection
				)
			) 
			on dNbtn_attachPointToObj mouseDown arg do
			(
				if arg.button == dNbtn_attachPointToObj.mouseButtons.left then
				(
					self.attachPointToObject_FN selection 1
				)
			)
			on dNbtn_frameOffset mouseDown arg do
			(
				if arg.button == dNbtn_frameOffset.mouseButtons.left then
				(
					self.offsetKeyframeRollout_FN()
				)
			) 
			on dNbtn_PointCache mouseDown arg do
			(
				if arg.button == dNbtn_PointCache.mouseButtons.left then
				(
					self.pointCacheRollout_FN()
				)
			)
			on dNbtn_bakeStandardCam MouseEnter arg do
			(
				self.initToolTip dNbtn_bakeStandardCam dNbtn_bakeStandardCam.tag
			)
			on dNbtn_bakeStandardCam MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_bakeVRcam MouseEnter arg do
			(
				self.initToolTip dNbtn_bakeVRcam dNbtn_bakeVRcam.tag
			)
			on dNbtn_bakeVRcam MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_VRCamFocus MouseEnter arg do
			(
				self.initToolTip dNbtn_VRCamFocus dNbtn_VRCamFocus.tag
			)
			on dNbtn_VRCamFocus MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_standardToVRcam MouseEnter arg do
			(
				self.initToolTip dNbtn_standardToVRcam dNbtn_standardToVRcam.tag
			)
			on dNbtn_standardToVRcam MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_VRtoStandardCam MouseEnter arg do
			(
				self.initToolTip dNbtn_VRtoStandardCam dNbtn_VRtoStandardCam.tag
			)
			on dNbtn_VRtoStandardCam MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_bakePointToObj MouseEnter arg do
			(
				self.initToolTip dNbtn_bakePointToObj dNbtn_bakePointToObj.tag
			)
			on dNbtn_bakePointToObj MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_attachPointToObj MouseEnter arg do
			(
				self.initToolTip dNbtn_attachPointToObj dNbtn_attachPointToObj.tag
			)
			on dNbtn_attachPointToObj MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_frameOffset MouseEnter arg do
			(
				self.initToolTip dNbtn_frameOffset dNbtn_frameOffset.tag
			)
			on dNbtn_frameOffset MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_PointCache MouseEnter arg do
			(
				self.initToolTip dNbtn_PointCache dNbtn_PointCache.tag
			)
			on dNbtn_PointCache MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_MaxFileOps "File Operations"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_pathToClipBoard "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_openFileLoc "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_openRenderLoc "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_pathToClipBoard "Copy File Path" tHeight colorOffsetInt:self.priColor tooltip:"Stores the network path to the current max file in the clipboard."
				self.initDnetBtn dNbtn_openFileLoc "Open File Directory" tHeight colorOffsetInt:self.secColor tooltip:"Opens the network location of the current max file."
				self.initDnetBtn dNbtn_openRenderLoc "Open Render Path" tHeight colorOffsetInt:self.priColor tooltip:"Opens an Explorer window to the files render output path. \nIf there is no output path then this will open a generic Exploer window."
			)
			on dNbtn_pathToClipBoard mouseDown arg do
			(
				if arg.button == dNbtn_pathToClipBoard.mouseButtons.left then
				(
					self.copyMaxFilePathToClipboard_FN()
				)
			) 
			on dNbtn_openFileLoc mouseDown arg do
			(
				if arg.button == dNbtn_openFileLoc.mouseButtons.left then
				(
					self.openMaxFileLocation_FN()
				)
			) 
			on dNbtn_openRenderLoc mouseDown arg do
			(
				if arg.button == dNbtn_openRenderLoc.mouseButtons.left then
				(
					self.openRndrLocation_FN()
				)
			)
			on dNbtn_pathToClipBoard MouseEnter arg do
			(
				self.initToolTip dNbtn_pathToClipBoard dNbtn_pathToClipBoard.tag
			)
			on dNbtn_pathToClipBoard MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_openFileLoc MouseEnter arg do
			(
				self.initToolTip dNbtn_openFileLoc dNbtn_openFileLoc.tag
			)
			on dNbtn_openFileLoc MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_openRenderLoc MouseEnter arg do
			(
				self.initToolTip dNbtn_openRenderLoc dNbtn_openRenderLoc.tag
			)
			on dNbtn_openRenderLoc MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_ObjProps "Object Properties"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_visCam "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_renderable "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_rcvShdws "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_cstShdws "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_visRefl "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_Atmsph "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_visCam "Visible To Camera" tHeight colorOffsetInt:self.priColor tooltip:"Toggle: Prints current state to listener."
				self.initDnetBtn dNbtn_renderable "Renderable" tHeight colorOffsetInt:self.secColor tooltip:"Toggle: Prints current state to listener."
				self.initDnetBtn dNbtn_rcvShdws "Receive Shadows" tHeight colorOffsetInt:self.priColor tooltip:"Toggle: Prints current state to listener."
				self.initDnetBtn dNbtn_cstShdws "Cast Shadows" tHeight colorOffsetInt:self.secColor tooltip:"Toggle: Prints current state to listener."
				self.initDnetBtn dNbtn_visRefl "Reflection/Refraction" tHeight colorOffsetInt:self.priColor tooltip:"Toggle: Prints current state to listener."
				self.initDnetBtn dNbtn_Atmsph "Apply Atmospherics" tHeight colorOffsetInt:self.secColor tooltip:"Toggle: Prints current state to listener."
			)
			on dNbtn_visCam mouseDown arg do
			(
				if arg.button == dNbtn_visCam.mouseButtons.left then
				(
					self.cameraVisToggle_FN selection
				)
			) 
			on dNbtn_renderable mouseDown arg do
			(
				if arg.button == dNbtn_renderable.mouseButtons.left then
				(
					self.renderableToggle_FN selection
				)
			) 
			on dNbtn_rcvShdws mouseDown arg do
			(
				if arg.button == dNbtn_rcvShdws.mouseButtons.left then
				(
					self.receiveShadowsToggle_FN selection
				)
			) 
			on dNbtn_cstShdws mouseDown arg do
			(
				if arg.button == dNbtn_cstShdws.mouseButtons.left then
				(
					self.castShadowsToggle_FN selection
				)
			) 
			on dNbtn_visRefl mouseDown arg do
			(
				if arg.button == dNbtn_visRefl.mouseButtons.left then
				(
					self.reflectionVisibilityToggle_FN selection
				)
			) 
			on dNbtn_Atmsph mouseDown arg do
			(
				if arg.button == dNbtn_Atmsph.mouseButtons.left then
				(
					self.applyAtmoToggle_FN selection
				)
			)
			on dNbtn_visCam MouseEnter arg do
			(
				self.initToolTip dNbtn_visCam dNbtn_visCam.tag
			)
			on dNbtn_visCam MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_renderable MouseEnter arg do
			(
				self.initToolTip dNbtn_renderable dNbtn_renderable.tag
			)
			on dNbtn_renderable MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_rcvShdws MouseEnter arg do
			(
				self.initToolTip dNbtn_rcvShdws dNbtn_rcvShdws.tag
			)
			on dNbtn_rcvShdws MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_cstShdws MouseEnter arg do
			(
				self.initToolTip dNbtn_cstShdws dNbtn_cstShdws.tag
			)
			on dNbtn_cstShdws MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_visRefl MouseEnter arg do
			(
				self.initToolTip dNbtn_visRefl dNbtn_visRefl.tag
			)
			on dNbtn_visRefl MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_Atmsph MouseEnter arg do
			(
				self.initToolTip dNbtn_Atmsph dNbtn_Atmsph.tag
			)
			on dNbtn_Atmsph MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_VRayProps "VRay Properties"
		(
			local self
			local tHeight = 8
			local bHeight = 19
			local bWidth = 132
			dotNetControl dNbtn_vrLights "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_vrMatte "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_vrAlpha "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_vrShdw "button" width:bWidth height:bHeight offset:[-8,0]
			dotNetControl dNbtn_vrMoBlur "button" width:bWidth height:bHeight offset:[-8,0]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_vrLights "VRay Light Invisible" tHeight colorOffsetInt:self.priColor tooltip:"Left-Click: Makes all lights in the scene invisible.\nRight-Click: Makes all lights in your selection invisible."
				self.initDnetBtn dNbtn_vrMatte "VRay Matte Object" tHeight colorOffsetInt:self.secColor tooltip:"Toggles the VR Matte Property. Prints current state to listener."
				self.initDnetBtn dNbtn_vrAlpha "VRay Alpha" tHeight colorOffsetInt:self.priColor tooltip:"Toggles the VR Alpha between 1 and -1. Prints current state to listener."
				self.initDnetBtn dNbtn_vrShdw "VRay Shadow" tHeight colorOffsetInt:self.secColor tooltip:"Toggles the VR Matte Shadows Property. Prints current state to listener."
				self.initDnetBtn dNbtn_vrMoBlur "VRay Motion Blur" tHeight colorOffsetInt:self.priColor tooltip:"Launches a dialog to adjust VR Geom Sample values."
			)
			on dNbtn_vrLights mouseDown arg do
			(
				if arg.button == dNbtn_vrLights.mouseButtons.left then
				(
					self.VRay_MakeLightsInvisible_FN Lights
				)
				if arg.button == dNbtn_vrLights.mouseButtons.right then
				(
					self.VRay_MakeLightsInvisible_FN Selection 
				)
			)
			on dNbtn_vrMatte mouseDown arg do
			(
				if arg.button == dNbtn_vrMatte.mouseButtons.left then
				(
					self.VRayMatteEnable_FN()
				)
			) 
			on dNbtn_vrAlpha mouseDown arg do
			(
				if arg.button == dNbtn_vrAlpha.mouseButtons.left then
				(
					self.VRayMatteAlpha_FN()
				)
			) 
			on dNbtn_vrShdw mouseDown arg do
			(
				if arg.button == dNbtn_vrShdw.mouseButtons.left then
				(
					self.VRayMatteShadow_FN()
				)
			) 
			on dNbtn_vrMoBlur mouseDown arg do
			(
				if arg.button == dNbtn_vrMoBlur.mouseButtons.left then
				(
					self.VRayGeomSamples_FN()
				)
			)
			on dNbtn_vrLights MouseEnter arg do
			(
				self.initToolTip dNbtn_vrLights dNbtn_vrLights.tag
			)
			on dNbtn_vrLights MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_vrMatte MouseEnter arg do
			(
				self.initToolTip dNbtn_vrMatte dNbtn_vrMatte.tag
			)
			on dNbtn_vrMatte MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_vrAlpha MouseEnter arg do
			(
				self.initToolTip dNbtn_vrAlpha dNbtn_vrAlpha.tag
			)
			on dNbtn_vrAlpha MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_vrShdw MouseEnter arg do
			(
				self.initToolTip dNbtn_vrShdw dNbtn_vrShdw.tag
			)
			on dNbtn_vrShdw MouseLeave arg do
			(
				self.destroyToolTip()
			)
			on dNbtn_vrMoBlur MouseEnter arg do
			(
				self.initToolTip dNbtn_vrMoBlur dNbtn_vrMoBlur.tag
			)
			on dNbtn_vrMoBlur MouseLeave arg do
			(
				self.destroyToolTip()
			)
		)
		
		rollout ro_Info "Information" height:150
		(
			local self
			local bWidth = 132
			dotNetControl dNbtn_vrLights "button" width:bWidth height:50 offset:[-8,0]
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro_Info.width/2-40),60]
			fn _init pself = 
			(
				self = pself
				self.initDnetBtn dNbtn_vrLights ("Gavyn Thompson\r\n"+(gtbMode+" Version: "+self.gtbVer)+"\r\n"+self.gtbDate) tHeight style:#flat colorOffsetInt:self.priColor tooltip:""
			)
		)
		mainUI_rollouts = #(ro_Save,ro_CopyPaste,ro_MatTools,ro_SlateTools,ro_Utilities,ro_Render,ro_MeshTools,ro_wireColor,ro_Selection,ro_animTools,ro_MaxFileOps,ro_ObjProps,ro_VRayProps,ro_Info)
		
		if hasIniSetting gtbIni "UI" "mainUI_rollouts" then
		(
			roNameArr = execute (getIniSetting gtbIni "UI" "mainUI_rollouts")
			roBuildOrderArr = #()
			for i in 1 to roNameArr.count do
			(
				roBuildOrderArr[i] = (for each in mainUI_rollouts where each.title == roNameArr[i] collect each)[1]
			)
			roBuildOrderArr[roBuildOrderArr.count] = ro_Info
		)
		else
		(
			roBuildOrderArr = mainUI_rollouts
		)
		true
	),
	
	fn Run  =
	(
		if ui() then
		(
			if thePos == undefined then thePos = OK
			if theSizeY == undefined then theSizeY = OK
			if (hasIniSetting gtbIni "UI" "Position") then thePos = execute (getIniSetting gtbIni "UI" "Position")
			if thePos == OK then thePos = [100,100] 
			if (hasIniSetting gtbIni "UI" "SizeY") then theSizeY = execute (getIniSetting gtbINI "UI" "SizeY")
			if theSizeY == OK do theSizeY = 1155
			createDialog ro_toolbox width:155 height:theSizeY lockWidth:True pos:[thePos.x,thePos.y]  menu:(menuBar()) style:#(#style_titlebar, #style_resizing, #style_sunkenedge, #style_sysmenu)
			ro_toolbox._init self
			for i in roBuildOrderArr do
			(
				addSubRollout ro_toolbox.gtSub i
				i._init self
			)
			rcm_UI._init self
		)
	),
	
--) End UI Functions
	
	fn _init =
	(
		self = this
		if hasINISetting gtbINI "UI" "startUp" then self.startUp = (execute (getINISetting gtbINI "UI" "startUp"))
	),
	
	init = _init()
	
)-- End Struct

::gtb = toolbox_lib()

callbacks.addScript #preSystemShutdown "gtb.saveUI_FN()" id:#callback_gtb_SaveUI
format ("***** Toolbox % % initialized *****\n") gtb.gtbMode gtb.gtbVer


	
