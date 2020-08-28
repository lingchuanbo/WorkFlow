macroScript CreateCameraFromView
	buttonText:"Create Camera from View"
	tooltip:"Create Camera from View"
	category:"Lights and Cameras"
	icon:#("Cameras",3)
--	author:"Vojtech Cada"
(
	fn getOrthoFOV =
	(
		local size = getViewSize()
		local viewWidth = gw.getVPWorldWidth [0,0,0] * amax 1.0 (size.x / size.y)
		2 * atan (viewWidth / (2 * viewport.getFocalDistance()))
	)

	fn predefinedToIso = case viewport.getType() of
	(
		#view_top: viewport.setType #view_iso_user
		#view_bottom: viewport.setType #view_iso_user
		#view_front: viewport.setType #view_iso_user
		#view_back: viewport.setType #view_iso_user
		#view_left: viewport.setType #view_iso_user
		#view_right: viewport.setType #view_iso_user
	); 

	fn makeCameraFromView =
	(
		
		local isOrthoView = viewport.getType() == #view_iso_user
		local isCurrentlyMatching = isKindOf Perspective_Match MAXWrapper and Perspective_Match.isMatching()
		local cameraClass = if viewport.getType() == #view_persp_user then Physical_Camera else TargetCamera

		local viewCam = cameraClass targetDistance:(gw.getFocalDist()) \
			transform:(inverseHighPrecision (viewport.getTM())) \
			type:(if isCurrentlyMatching then #free else #target) \
			targeted:(not isCurrentlyMatching) wireColor:(color 5 54 179) \
			fov:(if isOrthoView then getOrthoFOV() else getViewFOV()) \
			specify_fov:on isSelected:on orthoProjection:isOrthoView

		viewport.setCamera viewCam
	)

	on execute do
	(
		if viewport.getType() == #view_persp_user and isKindOf selection[1] Camera then
		(
			actionMan.executeAction 0 "40249" -- call the 'match camera to view' action
			viewport.setCamera selection[1]
		)
		else
		(
			predefinedToIso()
			if viewport.getFocalDistance() < 1e-4 do with redraw off
				(viewport.setType #view_persp_user; viewport.setType #view_iso_user)
			makeCameraFromView()
		)
	)
)