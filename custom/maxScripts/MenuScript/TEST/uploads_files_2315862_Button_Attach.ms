try destroyDialog Quick_Attach catch()
global seq = 300 -- how many objectts add to one part

function attachAll =
(
	if selection.count != 0 then (
	arr = (selection as array)
	clearSelection()
	count = 0
	meshes=#()
	b = Editable_Mesh()
	convertTo b Editable_Poly
	b.name = arr[1].name
	append meshes b
	precents = 0 as float
	for i = 1 to arr.count do
	(
		count += 1
		if count >= seq do (
			count = 1
			b = Editable_Mesh()
			convertTo b Editable_Poly
			b.name = arr[i].name
			append meshes b
			precents = 1000/(arr.count*10 / i)
			Quick_Attach.pb1.value = precents
			gc()
			windows.processPostedMessages() --это чтоб макс не зависал
			if  (keyboard.EscPressed) and (queryBox "you want to abort the Quick_Attach?") then return b
		)
		if (SuperClassOf (arr[i]) == GeometryClass) and (IsValidNode (arr[i])) then (
			polyop.attach b arr[i]
		) else (
		if (Quick_Attach.chk1.checked) and (SuperClassOf (arr[i]) == Shape) and (arr[i].render_renderable) and (IsValidNode (arr[i])) do (
			arr[i].render_displayRenderMesh = true
			polyop.attach b arr[i]
		)
		)
	)
	if meshes.count > 1 do (
		b = meshes[1]
		for i = 2 to meshes.count do
			(
				polyop.attach b meshes[i]
				precents = 1000/(meshes.count*10 / i)
				Quick_Attach.pb1.value = precents
				gc()
				windows.processPostedMessages()
				if  (keyboard.EscPressed) and (queryBox "you want to abort the Quick_Attach?") then return b
			)
	)
	select b
	mymax = b.max
	mymin = b.min
	b.pivot = [(mymax.x+mymin.x)/2, (mymax.y+mymin.y)/2, (mymax.z+mymin.z)/2]
	b
	) else messagebox ("select objects first")
)


rollout AtSel "Untitled" width:133 height:74
(
	button 'btn1' "Attach" pos:[11,12] width:110 height:48 align:#left
	on btn1 pressed do
	(
		   
			fn openGroupsAll objs toggle1 toggle2= (
						group_arr = for o in objs where isValidNode o AND isGroupHead o collect o
					 
						with redraw off (
							for o in group_arr do (
								actionMan.executeAction 0 "40141"  -- Groups: Ungroup
								-- ungroup o
							) -- end for
						)-- end redraw
					) -- end fn
				
					openGroupsAll selection false true
					macros.run "Modifier Stack" "Convert_to_Poly"
				undo "Quick_Attach" on (
					b = attachAll()
				
				)
		)
)
createdialog AtSel