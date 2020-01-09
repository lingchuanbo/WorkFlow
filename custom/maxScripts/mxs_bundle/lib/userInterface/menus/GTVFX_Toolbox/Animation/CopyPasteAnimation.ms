/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				2014-01-06
[Purpose]
Transfers animation keys from one object to another.
This does not bake the animation frame-by-frame, but copies the actual animation controller and applies it to the target object.
Option to save out an objects animation to disk and call it back later, allowing you to save the animation of an object from one scene and apply it in another.
******************************************/
struct copyPastAnimKeys
(
	self,
	ro,
		
	animStoreFile = ((getDir #temp) + "GTVFX_animCopy.max"),
		
	sourceRotX_keys,
	sourceRotY_keys,
	sourceRotZ_keys,
		
	sourcePosX_keys,
	sourcePosY_keys,
	sourcePosZ_keys,
		
	targetRotX_keys,
	targetRotY_keys,
	targetRotZ_keys,
		
	targetPosX_keys,
	targetPosY_keys,
	targetPosZ_keys,
	
	fn collectSourceKeyArrays from_obj =
	(
		--rotation
		sourceRotX_keys = from_obj.rotation.x_rotation.controller.keys
		sourceRotY_keys = from_obj.rotation.y_rotation.controller.keys
		sourceRotZ_keys = from_obj.rotation.z_rotation.controller.keys
		--position
		sourcePosX_keys = from_obj.pos.x_position.controller.keys
		sourcePosY_keys = from_obj.pos.y_position.controller.keys
		sourcePosZ_keys = from_obj.pos.z_position.controller.keys
	),
	fn collectTargetKeyArrays to_obj =
	(
		--rotation
		targetRotX_keys = to_obj.rotation.x_rotation.controller.keys
		targetRotY_keys = to_obj.rotation.y_rotation.controller.keys
		targetRotZ_keys = to_obj.rotation.z_rotation.controller.keys
		--position
		targetPosX_keys = to_obj.pos.x_position.controller.keys
		targetPosY_keys = to_obj.pos.y_position.controller.keys
		targetPosZ_keys = to_obj.pos.z_position.controller.keys
	),
	fn appendKeys_FN sourceKeyArr targetKeyArr =
	(
		for i in 1 to sourceKeyArr.count do
		(
			appendKey targetKeyArr sourceKeyArr[i]
		)
	),
	fn pasteAnimKeys_FN from_obj to_obj =
	(
		deleteKeys to_obj #allKeys
		collectSourceKeyArrays from_obj
		collectTargetKeyArrays to_obj
		
		sourceFOV = hasProperty from_obj "FOV"
		targetFOV = hasProperty to_obj "FOV"
		
		if sourceFOV and targetFOV then
		(
			if from_obj.FOV.controller == undefined then from_obj.FOV.controller = bezier_float()
			if to_obj.FOV.controller == undefined then to_obj.FOV.controller = bezier_float()
			sourceFOV_keys = from_obj.FOV.controller.keys
			targetFOV_keys = to_obj.FOV.controller.keys
			
			appendKeys_FN sourceFOV_keys targetFOV_keys
		)
		--rotation
		appendKeys_FN sourceRotX_keys targetRotX_keys
		appendKeys_FN sourceRotY_keys targetRotY_keys
		appendKeys_FN sourceRotZ_keys targetRotZ_keys
		--position
		appendKeys_FN sourcePosX_keys targetPosX_keys
		appendKeys_FN sourcePosY_keys targetPosY_keys
		appendKeys_FN sourcePosZ_keys targetPosZ_keys
	),
	fn ui =
	(
		rollout ro "Copy/Paste Animation by GTVFX" width:400 height:300
		(
			local self
			local btn_height = 30
			local btn_height2 = 15
			local sourceObj
			local targetObj
			local loadedObjs = #()
			listBox lb_source "Source Object" height:3
			pickbutton pbtn_selSource "Select Source Object" width:160 height:btn_height align:#right tooltip:"Press this button and then select the object you want to copy animation from."
			listBox lb_target "Target Object" height:3
			pickbutton pbtn_target "Select Target Object" width:160 height:btn_height align:#right tooltip:"Press this button and then select the object you want to apply the animation to."
			button btn_paste "Paste Animation" width:(ro.width - 30) height:60 tooltip:"Apply the animation from the source object to the target object."
			button btn_store "Store on disk" width:90 height:20 pos:[13,70] tooltip:"Store the source object to be able to retrieve animation from it within another Max file."
			button btn_load "Load from disk" width:90 height:20 pos:[110,70] tooltip:"Load in the stored source object to copy it's animation."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:(color 0 128 128) address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on pbtn_selSource picked obj do
			(
				sourceObj = obj
				lb_source.items = #(sourceObj.name)
			)
			on pbtn_target picked obj do
			(
				targetObj = obj
				lb_target.items = #(targetObj.name)
			)
			on btn_paste pressed do
			(
				self.pasteAnimKeys_FN sourceObj targetObj
			)
			on btn_store pressed do
			(
				if sourceObj != undefined then
				(
					saveNodes sourceObj self.animStoreFile
				) else messageBox "You must define a source object first" title:"GTVFX:"
			)
			on btn_load pressed do
			(
				if doesFileExist self.animStoreFile then
				(
					sel = getCurrentSelection()
					mergeMaxFile self.animStoreFile #select #mergeDups
					sourceObj = selection[1]
					sourceObj.isHidden = true
					if sel.count != 0 then select sel else clearSelection()
					lb_source.items = #(sourceObj.name)
					append loadedObjs sourceObj
				)
				else messageBox "There is no animation to load." title:"GTVFX:"
			)
			on ro close do
			(
				try(delete loadedObjs)catch()
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
try(destroyDialog copyAnim.ro)catch()
copyAnim = copyPastAnimKeys()
	
