/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				12/10/2013
[Purpose]
Bakes out the selected camera to the end of the current time range with a point helper as it's parent aligned at the last frame of animation.
This allows you to then allign this parent object to a second camera to line them up and begin creating a blend camera.
[KEYWORDS]
Bake, Animate, Animation, Attach
__END__
******************************************/
struct bakeCamWithTransitionParent
(
	fn createLayerAndSetCurrent layerName =
	(
		if LayerManager.getLayerFromName layerName == undefined then setLayer = layermanager.newLayerFromName layerName
		else setLayer = LayerManager.getLayerFromName layerName
		setLayer.current = true
	),
	fn createLastFrameParent cam =
	(
		disableSceneRedraw()
		curTime = sliderTime
		sliderTime = animationRange.end
		camParent = point name:(cam.name + "_Parent") centermarker:false cross:false box:true axistripod:true wireColor:orange
		camParent.parent = cam
		camParent.position.controller.value = [0,0,0]
		camParent.rotation.controller.value = (quat 0 0 0 1)
		camParent.parent = undefined
		sliderTime = curTime
		enableSceneRedraw()
		camParent
	),
	fn bakeCam_FN cam camParent frameOffset bakeTrans:true =
	(
		if isKindOf cam camera then		
		(
			createLayerAndSetCurrent ("###_" + cam.name + "_Baked")
			LayerManager.current.addNode camParent
			newCam = freecamera ()
			newCam.name = (cam.name + "_Baked")
			if camParent != undefined then (newCam.parent = camParent)
			maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true -- Sets the New Key value to Auto
			with animate on 
			(
				for t = (animationrange.start - frameOffset) to animationrange.end do
				(
					at time t 
					(
						if bakeTrans then
						(
							in coordsys world newCam.transform =  cam.transform
						)
						else
						(
							in coordsys world newCam.rotation =  cam.rotation
							in coordsys world newCam.position =  cam.position
						)
						newcam.fov = cam.fov
					)
				)
			)
			setTransformLockFlags newCam #all
			select newCam
		)
		else messagebox "Can't find the right camera.\nOnly select the camera you want to bake."
	),
	fn _init =
	(
		if selection.count == 1 and isKindOf selection[1] camera then
		(
			bakeCam_FN $ (createLastFrameParent $) 5 
		)
		else messageBox "You must have only one camera selected."
	),
	init = _init()
)
bcwtp = bakeCamWithTransitionParent()
