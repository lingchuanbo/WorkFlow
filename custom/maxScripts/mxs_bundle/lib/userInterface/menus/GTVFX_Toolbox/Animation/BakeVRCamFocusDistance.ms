/*************************************************************************************
__MXSDOC__

Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0
Updated:				08/29/2013
[Purpose]
Constains a point to a selected object and bakes the cameras focus distance to that point.

__END__
*************************************************************************************/
clearListener()
struct bakeVRCamFocus_struct
(
	self,
	meshArr = #(),
	attachPointArr,
	bakePointArr,
	curCam,
	ro,
	
	fn VRcamera_filt obj = isKindOf obj VRayPhysicalCamera,
		
	fn createLayerAndSetCurrent layerName =
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
	fn deleteLayerByName layerName =
	(
		if LayerManager.getLayerFromName layerName != undefined then
		(
			(LayerManager.getLayer 0).current = true
			if not layermanager.deleteLayerByName layerName then messageBox ("Layer: "+layerName+ " contains objects.\nCannot delte layer until all objects are removed.")
		)
	),
	fn collectCamNames vrayCam:false=
	(
		if vrayCam then
		(
			arr = for i in cameras where classOf i == VRayPhysicalCamera collect i.name
		)
		else
		(
			arr = for i in cameras where classOf i != Targetobject and classOf i != VRayPhysicalCamera collect i.name
		)
		arr
	),
	fn collectCamsFromNames nameArr arr:#()=
	(
		for i in nameArr do append arr (getNodeByName i)
		arr
	),
	fn attachPointToObject_FN objArr faceID = 
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
	fn bakePointToObject objArr =
	(
		createLayerAndSetCurrent "###_Anm_Baked"
		maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true -- Sets the New Key value to Auto
		bakePointArr = #()
		for i in objArr do
		(
			if isProperty i "transform" == true then
			(
				bakePoint = point size:10 centerMarker:false cross:false box:true axistripod:true wirecolor:orange name:(i.name + "_bakePoint")
				append bakePointArr bakePoint
				with animate on 
				(
					for t = (animationRange.start - 5f) to (animationrange.end + 5f) do
					(
						at time t 
						(
							bakePoint.transform = i.transform
						)
					)
				)
			)	
		)
		bakePointArr
	),
	fn bakeCamFocusDistance_FN camArr obj =
	(
		if camArr.count != 0 do
		(
			for i in camArr do
			(
				i.specify_focus = true
				with animate on 
				(
					for t = (animationRange.start - 5f) to (animationrange.end + 5f) do
					(
						at time t 
						(
							i.focus_distance = (distance i obj)
						)
					)
				)
			)
		)
	),
	fn ui =
	(
		rollout ro "Bake VRay Cam Focus Distance By GTVFX"
		(
			local self
			label lbl_cam "Camera: " align:#left
			multiListBox mlb_cams height:10
			group "Select Object"
			(
				button btn_pickObject "Pick Focus Object" width:250 height:40 toolTip:"Hit the button, then select the object you wish to focus on."
				label lbl_object "Focus Obj: " 
			)
			group "Bake Focus Distance"
			(
				button btn_Bake "Bake It!" width:250 height:45 toolTip:"Bake the cameras focus distance." enabled:false
			)
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
				mlb_cams.items = self.collectCamNames vrayCam:true
				mlb_cams.selection = #{1}
			)
			on btn_pickObject pressed do
			(
				clearSelection()
				print "**** Select Focus Object ***"
				self.meshArr = #()
				self.meshArr += pickObject()
				lbl_object.text = "Focus Obj: "
				lbl_object.text += self.meshArr[1].name
				btn_Bake.enabled = true
			)
			on btn_Bake pressed do
			(
				camNameArr = for i in mlb_cams.selection collect mlb_cams.items[i]
				self.attachPointToObject_FN self.meshArr 1
				self.bakePointToObject self.attachPointArr
				delete self.attachPointArr
				self.deleteLayerByName "###_Atch_Points"
				self.bakeCamFocusDistance_FN (self.collectCamsFromNames camNameArr) self.bakePointArr[1]
			)
		)
		createdialog ro width:350 height:350
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog bakeVRCamFocus.ro)catch()
bakeVRCamFocus = bakeVRCamFocus_struct()
