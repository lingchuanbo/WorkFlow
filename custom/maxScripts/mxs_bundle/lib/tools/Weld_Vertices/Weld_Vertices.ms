::mxs.using "MeshFns"
::mxs.using "DotNetUi"

global weld_verts_ui

(
	try(DestroyDialog weld_verts_ui)catch()
	
	
	rollout weld_verts_ui "Weld Verts" width:400
	(
		spinner spn_threshold "Threshold:" type:#float align:#left fieldwidth:40 range:[0, 999, .01]
		
		DotNetControl dNbtn_weld "Button" height:40
		
		
		on weld_verts_ui open do
		(
			::DotNetUi.InitDnetBtn dNbtn_weld "Weld Verts" 12 style:#popup colorOffsetInt:20 tooltip:"Weld the verts on the selected objects using the supplied threshold setting" 
		)
		
		on dNbtn_weld mouseClick args do
		(
			local objArr = GetCurrentSelection()
			
			if objArr.count != 0 then
			(
				for obj in objArr do
				(
					::MeshFns.WeldVerts obj threshold:spn_threshold.value
				)
			)
		)
		
		on dNbtn_weld MouseEnter arg do
		(
			::DotNetUi.initToolTip dNbtn_weld dNbtn_weld.tag
		)
		on dNbtn_weld dNbtn_weld arg do
		(
			::DotNetUi.DestroyToolTip()
		)
		
		
	)
	
	CreateDialog weld_verts_ui style:#(#style_titlebar, #style_sunkenedge, #style_sysmenu, #style_minimizebox, #style_maximizebox)
)