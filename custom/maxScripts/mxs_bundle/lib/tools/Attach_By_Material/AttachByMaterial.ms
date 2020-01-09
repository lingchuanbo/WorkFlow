::mxs.using "MeshFns"

(
	local objArr = ( GetCurrentSelection() )
	
	if objArr.count > 1 then
	(
		local _weld = False
		
		if keyboard.shiftpressed then _weld = True
			
		::MeshFns.AttachByMaterial objArr _weldVerts:_weld
	)
	else
	(
		messageBox "You must have more than one object selected!!!" title:":("
	)
)
