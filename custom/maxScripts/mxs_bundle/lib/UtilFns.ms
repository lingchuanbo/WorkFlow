/***************************************************************************************************
Copyright (C) 2013 - 2017  Gavyn Thompson

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
***************************************************************************************************/
/***************************************************************************************************
Author:				    Gavyn Thompson
Company:				GTVFX
Website:				https://github.com/gtvfx
Email:				    gftvfx@gmail.com
ScriptVersion:			
Updated:				
***************************************************************************************************/
/*
__HELP__

Constructor: UtilFns
Instantiated Global: UtilFns

[METHODS]


[DESCRIPTION]


[USAGE]


__END__
*/




struct UtilFns
(
	fn DeleteEmptyLayers =
	(
		local currLayer = LayerManager.current
		
		if currLayer.name != "0" then
		(
			defLayer = LayerManager.getLayer 0
			( LayerManager.getLayer 0 ).current = true
		)
		
		LayerManager.closeDialog()
		
		local emptyLayers =#()
		
		for i = 0 to layerManager.count-1 do
		(
			local ilayer = layerManager.getLayer i
			local layerName = ilayer.name 
			local layer = ILayerManager.getLayerObject i
			
			layer.Nodes &layerNodesArr
			
			if layerNodesArr.count == 0  do
			(
				append emptyLayers (layerName as string)
			)
		)
		
		with PrintAllElements on format "***** Empty Layers: % \n" emptylayers
			
		for i = 1 to emptyLayers.count do
		( 
			layermanager.deleteLayerByName emptyLayers[i]
		)
		
		LayerManager.CloseDialog()
		layermanager.EditLayerByName ""
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
			local layerArr = #()
			
			for i in objArr do
			(
				appendIfUnique layerArr i.layer
			)
			
			for i = 0 to layerManager.count-1 do
			(
				local iLayer = layerManager.getLayer i
				if FindItem layerArr iLayer == 0 then iLayer.on = False
			)
			
			True
		)
		else
		(
			messageBox "Nothing selected... :(" title:"MXS: Error"
			False
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

private
	
	fn __init__ =
	(
		self = this
	),
	
	_init = __init__()
)

UtilFns = UtilFns()