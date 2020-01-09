/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/20/2013
[Purpose]
Eplodes a mesh object creating single objects for each material ID.
[KEYWORDS]
Detach, Explode, MatID
__END__
******************************************/
struct DetachElementsByMatID_lib
(
	fn DetachElementsByMatID_FN SourceOBJ =
	(
		convertTo SourceOBJ (Editable_Poly) 
		FaceTest = ((SourceOBJ.getnumfaces()) != 0)
		for matId = 1 to 999 while faceTest do --ends loop when there are no faces left to select
		(
			faceCount = SourceOBJ.getnumfaces()
			detachArr = #{}
			for i in 1 to faceCount do
			(
				if polyop.getFaceMatID SourceOBJ i == matId then append detachArr i
			)
			if detachArr.count > 0 then
			(
				newName = (uniquename (SourceOBJ.name as string))
				SourceOBJ.EditablePoly.SetSelection #Face detachArr
				TargetFaces = polyop.getFaceSelection SourceOBJ
				polyop.detachFaces SourceOBJ TargetFaces asNode:true name:newName
				NewObj = getnodebyname newName
				NewObj.wireColor = SourceOBJ.wirecolor
				resetXForm NewObj 
				convertTo NewObj (Editable_Mesh)
				ResetTransform NewObj 
				ResetScale NewObj 
				ResetPivot NewObj 
				centerpivot NewObj
				FaceTest = ((SourceOBJ.getnumfaces()) != 0)
			)
		)
		delete SourceOBJ
	),
	fn _init =
	(
		cui.commandPanelOpen = false
		ObjsSource = getCurrentSelection()
		if ObjsSource.count == 0 then
		(	
			messagebox "Nothing is selected!"
		)
		else for obj in 1 to ObjsSource.count do with redraw off
		(
			SourceOBJ = ObjsSource[obj]
			DetachElementsByMatID_FN SourceOBJ
		)
		max views redraw
		cui.commandPanelOpen = true
	),
	init = _init()
)
detachElements = DetachElementsByMatID_lib()
