
(
	local del_array =#{}
	
	fn scan_for_double_faces c_node =
	(
		local st = timestamp()
		e_node = snapshotAsMesh c_node
		format "Checking Mesh %\n" c_node.name 
		local numFaces =e_node.numfaces  
		format "% Faces in Mesh.\n" numFaces

		face_array = #()
		del_array = #{}
		
		progressStart "DoubleFaces Check:"
		local notCanceled = true
		
		for i = 1 to numFaces while notCanceled do
		(
			if not (progressUpdate (100.0*i/numFaces)) do notCanceled = false
			local theFace = getface e_node i
			local dd_found = false
			if (findItem face_array theFace) > 0 OR \
			(findItem face_array [theFace.x,theFace.z,theFace.y] ) > 0 OR \
			(findItem face_array [theFace.y,theFace.x,theFace.z] ) > 0 OR \
			(findItem face_array [theFace.y,theFace.z,theFace.x] ) > 0 OR \
			(findItem face_array [theFace.z,theFace.x,theFace.y] ) > 0 OR \
			(findItem face_array [theFace.z,theFace.y,theFace.x] ) > 0 do ( del_array[i]=true; dd_found = true )
			if not dd_found then append face_array theFace
		)--end i loop
		
		progressEnd ()
		delete e_node
		
		if notCanceled then
		(
			if del_array.numberset > 0 then 
			(
				format "% DoubleFaces Found!\n" del_array.numberset 
				delete_enabled = true
			)
			else 
			(
				format "No DoubleFaces Found!\n" 
				delete_enabled = false
			)
			format "DDF Scan Completed in % ms\n" (timestamp()-st)
			delete_enabled
		)
		else
		(
			format "DDF Scan Interrupted after % ms\n" (timestamp()-st)
			format "% DoubleFaces Found so far.\n" del_array.numberset 
			false
		)
	)--end check fn

	fn remove_double_faces e_node =
	(
		undo on
		(
			local ms = mesh_select ()
			local dm = deletemesh ()
			select e_node
			max modify mode
			--if chk_add_to_bottom.checked then 
			--modPanel.setCurrentObject e_node.baseobject
			modPanel.addModToSelection ms
			subObjectLevel = 3
			setfaceselection e_node ms del_array 
			modPanel.addModToSelection dm
			
			format "% Faces Selected...\n" del_array.numberset
			format "DeleteMesh Modifier Applied.\n" txt 

			--collapsestack e_node
			--format "Modifier Stack Collapsed.\n" 

		)--end undo	
	)--end on

	fn scan_Nodes =
	(
		obj_array = selection as array
		
		for n = 1 to obj_array.count do
		(
			check_node = obj_array[n]
			select check_node
			ConvertToMesh check_node
			
			if classof check_node == Editable_Mesh then 
			(
				addModifier check_node (vertexWeld())
				scan_result = scan_for_double_faces check_node
				if scan_result then remove_double_faces check_node
			)
		)--end n loop
		
		format "Done. \n\n" 
		select obj_array	
	)
	
	scan_nodes()
)
