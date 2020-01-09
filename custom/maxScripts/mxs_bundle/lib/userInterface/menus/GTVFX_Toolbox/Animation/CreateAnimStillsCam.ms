/******************************************
Copyright (C) 2013 - 2014  Gavyn Thompson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
******************************************/
/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v2.00
Updated:				02/06/2014
[Purpose]
Creates a single camera that is baked frame by frame to each camera that is selected in the list.
Useful for creating production stills and sending a single camera off to be rendered.
[KEYWORDS]
Camera, Stills, Animate
__END__
******************************************/
try(destroyDialog animStillCam.ro)catch()
Struct animStillCam_lib
(
	self,
	ro,
	CamDataArr = #(),
		
	fn CollectObjsAndNames objArr =
	(
		arr = for i in objArr collect #(i.name, i)
		arr
	),

	fn LookupTableComparator a b =
	(
		if a[1] > b[1] then 1
		else if a[1] < b[1] then -1
		else 0
	),

	fn LookupTableLookup itemKey itemTable =
	(
		lookupKey = #(itemKey)
		bsearch lookupKey itemTable LookupTableComparator
	),
	
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
	
	fn createAnimatedStillsCamera_FN camArr startTime =
	(
		createLayerAndSetCurrent "###_camera"
		animStillCam = freeCamera name:("Cam_" + (getFileNameFile maxFileName) + "_animStills") wireColor:orange
		for i in camArr do
		(
			with animate on 
			(
				at time startTime 
				(
					in coordsys world animStillCam.transform = i.transform
					animStillCam.fov = i.fov
				)
				startTime += 1
			)
		)
		setTransformLockFlags animStillCam #all
		select animStillCam
	),
	
	fn animStillCam_VrayPhys camArr startTime =
	(
		createLayerAndSetCurrent "###_camera"
		animStillCam = VRayPhysicalCamera name:("VRayCam_" + (getFileNameFile maxFileName) + "_animStills") wireColor:orange targeted:false specify_fov:true  whiteBalance_preset:4 whiteBalance:white
		for i in camArr do
		(
			with animate on 
			(
				at time startTime 
				(
					if classOf i == VrayPhysicalCamera then
					(
						in coordsys world animStillCam.transform = i.transform
						if i.specify_fov == false then animStillCam.fov = (cameraFOV.MMtoFOV i.focal_length) else animStillCam.fov = i.fov
						animStillCam.distortion_type = i.distortion_type
						animStillCam.lens_file = i.lens_file
						animStillCam.distortion_map = i.distortion_map
						animStillCam.lens_shift_auto = i.lens_shift_auto
						animStillCam.specify_focus = i.specify_focus
						animStillCam.exposure = i.exposure
						animStillCam.vignetting = i.vignetting
						animStillCam.type = i.type
						animStillCam.systemLightingUnits = i.systemLightingUnits
						animStillCam.systemLightingUnits = i.systemLightingUnits
						animStillCam.whiteBalance = i.whiteBalance
						animStillCam.whiteBalance_preset = i.whiteBalance_preset
						animStillCam.use_blades = i.use_blades
						animStillCam.blades_number = i.blades_number
						animStillCam.use_dof = i.use_dof
						animStillCam.use_moblur = i.use_moblur
						animStillCam.subdivs = i.subdivs
						animStillCam.clip_on = i.clip_on
						animStillCam.horizon_on = i.horizon_on
						animStillCam.legacy_ISO = i.legacy_ISO
						animStillCam.show_camera_cone = i.show_camera_cone
						--Animatable
						animStillCam.film_width = i.film_width
						animStillCam.zoom_factor = i.zoom_factor
						animStillCam.horizontal_offset = i.horizontal_offset
						animStillCam.vertical_offset = i.vertical_offset
						animStillCam.distortion = i.distortion
						animStillCam.f_number = i.f_number
						animStillCam.target_distance = i.target_distance
						animStillCam.lens_shift = i.lens_shift
						animStillCam.lens_horShift = i.lens_horShift
						animStillCam.focus_distance = i.focus_distance
						animStillCam.dof_display_thresh = i.dof_display_thresh
						animStillCam.vignetting_amount = i.vignetting_amount
						animStillCam.shutter_speed = i.shutter_speed
						animStillCam.shutter_angle = i.shutter_angle
						animStillCam.shutter_offset = i.shutter_offset
						animStillCam.latency = i.latency
						animStillCam.ISO = i.ISO
						animStillCam.temperature = i.temperature
						animStillCam.blades_rotation = i.blades_rotation
						animStillCam.center_bias = i.center_bias
						animStillCam.anisotropy = i.anisotropy
						animStillCam.clip_near = i.clip_near
						animStillCam.clip_far = i.clip_far
						animStillCam.environment_near = i.environment_near
						animStillCam.environment_far = i.environment_far
					)
					else
					(
						in coordsys world animStillCam.transform =  i.transform
						animStillCam.fov = i.fov
					)
				)
				startTime += 1
			)
		)
		setTransformLockFlags animStillCam #all
		select animStillCam
	),
	
	fn CollectCamNames =
	(
		arr = for i in cameras where classOf i != Targetobject collect i.name
		arr
	),
	
	fn CollectCamData =
	(
		self.CamDataArr = for i in cameras where ClassOf i != TagetObject collect #(i.name, i)
		qsort self.CamDataArr LookupTableComparator
		self.CamDataArr
	),
	
	fn ui =
	(
		rollout ro "Create Animated Still Camera By GTVFX" width:350 height:400
		(
			local self
			local dnTooltip
			local tHeight = 12
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			label lbl_camBox "Selct the cameras you would like to use:" align:#left
			dotNetControl dgv_cams "System.Windows.Forms.DataGridView" align:#right width:(ro.width-25) height:(ro.height-140)
			spinner spn_startTime "Anim Start Time" range:[0,9999,animationRange.start] type:#integer fieldWidth:50 align:#left tooltip:"Choose the frame you would like the animation to start from"
			checkBox chk_vrayCam "Bake as VRay Physical Camera" tooltip:"The Camera created will be a VRay Physical Camera"
			dotNetControl dNbtn_bake "button" width:(ro.width-30) height:40 offset:[2,0]
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			
			fn initToolTip dNetObj caption =
			(
				if dnTooltip == undefined then
				(
					dnToolTip = dotnetobject "ToolTip"
					dnToolTip.AutoPopDelay = 5000
					dnToolTip.InitialDelay = 300
					dnToolTip.ReshowDelay = 300
					dnToolTip.ShowAlways = true
					dnToolTip.IsBalloon = true
				)
				dnToolTip.SetToolTip dNetObj caption
			)
			fn setDataGridColor dNObj fontSize =
			(
				dNObj.forecolor = dNObj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNObj.BackgroundColor = dNObj.BackgroundColor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.DefaultCellStyle.BackColor = dNObj.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
			)
			fn setDotNetWidget dNobj caption fontSize =
			(
				dNobj.text = caption
				dNobj.forecolor = dNobj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNobj.backColor = dNobj.backcolor.FromArgb ClrBackGround.x ClrBackGround.y ClrBackGround.z
				dNobj.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
			)
			fn DrawData dgv =
			(
				dgv.rows.clear()
				for a in (self.CollectCamData()) do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					tempRow.SetValues #(a[1],(classOf a[2] as string))
				)
				dgv.update()
			)
			fn dgv_cams_colAr arr:#() =
			(
				append arr #(#text,"Camera:",True,#left)
				append arr #(#text,"Class:",True,#left)
				arr
			)
			fn initDgv dgv colAr tooltip:"" =
			(
				dgv.AllowUserToAddRows = off
				dgv.AutoSize = on
				dgv.AutoSizeColumnsMode = dgv.AutoSizeColumnsMode.Fill
				dgv.ShowEditingIcon = dgv.RowHeadersVisible = off
				dnSelectionMode = dotNetClass "System.Windows.Forms.DataGridViewSelectionMode"
				dgv.SelectionMode = dnSelectionMode.FullRowSelect 
				dgv.AllowUserToResizeRows = false
				dgv.AllowUserToOrderColumns = false
				dgv.AllowUserToResizeColumns = false
				dgv.ColumnHeadersHeightSizeMode = dgv.ColumnHeadersHeightSizeMode.DisableResizing
				for col in colAr do
				(
					dnNewColumn
					case col[1] of
					(
						(#Text):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewTextBoxColumn"
						(#Bool):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewCheckBoxColumn"
						default:dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewComboBoxColumn"
					)
					dnNewColumn.HeaderText = col[2]
					dnNewColumn.ReadOnly = col[3]
					dnAlignment = dotNetClass "System.Windows.Forms.DataGridViewContentAlignment"
					case col[4] of
					(
						#Right:		dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleRight
						#Center:	dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleCenter
						#Left:		dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleLeft
						default:	dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleLeft
					)
					dgv.columns.add dnNewColumn
				)
				dgv.columns.item[0].width = 190
				for i in 0 to dgv.columns.count-1 do
				(
					dgv.Columns.item[i].SortMode = (dotNetClass "System.Windows.Forms.DataGridViewColumnSortMode").NotSortable
				)
				setDataGridColor dgv 12
				initToolTip dgv tooltip
				dgv.update()
			)
			fn initDnetBtn dNbtn caption fontSize tooltip:"" = 
			(
				dNbtn.flatStyle = dNbtn.flatStyle.flat
				setDotNetWidget dNbtn caption fontSize
				initToolTip dNbtn tooltip
				dNbtn.update()
			)
			fn _init pself =
			(
				self = pself
				initDgv dgv_cams (dgv_cams_colAr()) tooltip:"Select the cameras from your scene that you want to include in the animation"
				drawData dgv_cams
				initDnetBtn dNbtn_bake "Create animated stills camera" tHeight tooltip:"Create animated stills camera"
			)
			on dNbtn_bake mouseDown arg do
			(
				if arg.button == dNbtn_bake.mouseButtons.left then
				(
					selRows = dgv_cams.SelectedRows
					format "***** selRows: % *****\n" selRows
					
					bakeDataArr = #()
					
					for i = 0 to selRows.count-1 do
					(
						append bakeDataArr (self.LookupTableLookup (selRows.item[i].cells.item[0].value) self.camDataArr)
					)
					
					qsort bakeDataArr self.LookupTableComparator
					
					if bakeDataArr.count > 1 then endFrame = (bakeDataArr.count - 1) else endFrame = (spn_startTime.value + 1)
					
					camArr = for i in bakeDataArr collect i[2]
					
					if chk_vrayCam.state then
					(
						self.animStillCam_VrayPhys camArr spn_startTime.value
						
						animationRange = interval spn_startTime.value (spn_startTime.value + endFrame)
					)
					else
					(
						self.createAnimatedStillsCamera_FN camArr spn_startTime.value
						animationRange = interval spn_startTime.value (spn_startTime.value + endFrame)
					)
				)
			)
		)
		createDialog ro 
		ro._init self
	),
	fn __init =
	(
		self = this
		ui()
	),
	init = __init()
)
animStillCam = animStillCam_lib()	
