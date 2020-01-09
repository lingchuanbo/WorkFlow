/***************************************************************************************************
Copyright (C) 2013 - 2014  Gavyn Thompson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. if not, see <http://www.gnu.org/licenses/>.
***************************************************************************************************/
/***************************************************************************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v2.10
Updated:				02/09/2014
[Purpose]
Bakes cameras per frame with optional transform, and optional frame range buffer.
Works for Standard Max cameras, VRay Physical Cameras, and VRay Dome Cameras
[KEYWORDS]
gtvfx, Camera, Bake, VRay
__END__
***************************************************************************************************/
try(destroyDialog cameraBaker.ro)catch()
Struct cameraBaker_lib
(
	self,
	ro,
	bakeCamArr = #(),
	
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
	fn deleteErroneousKeys objArr keyArr ctrlr =
	(
		for i in objArr do
		(
			if keyArr[1].time == 0f and keyArr[2].time != 1f then
			(
				case ctrlr of
				(
					#position: deleteKey i.position.controller 1
					#rotation: deleteKey i.rotation.controller 1
					#scale: deleteKey i.scale.controller 1
				)
			)
		)
	),
	fn collectCamNames =
	(
		arr = for i in cameras where classOf i != Targetobject collect i.name
		sort arr
		arr
	),
	fn bakeDomeCam cam camParent frameOffset =
	(
		createLayerAndSetCurrent ("###_" + cam.name + "_Baked")
		domeCam = VrayDomeCamera name:(uniqueName  ("Dome_" + cam.name as string + "_Baked"))
		if camParent != undefined and camParent != cam then (domeCam.parent = camParent)
		domeCam.flip_x = cam.flip_x
		domeCam.flip_y = cam.flip_y
		with animate on 
		(
			for i = (animationrange.start -= frameOffset) to (animationrange.end += frameOffset) do 
			(
				at time i 
				(
					domeCam.transform = cam.transform
					domeCam.fov = cam.fov
				)
			)
		)
	),
	fn bakeVRayCam_FN cam camParent frameOffset = 
	(
		createLayerAndSetCurrent ("###_" + cam.name + "_Baked")
		VRcam = VRayPhysicalCamera name:(uniqueName ("VRay_" + cam.name as string + "_Baked")) targeted:false
		if camParent != undefined and camParent != cam then (VRcam.parent = camParent)
		if cam.specify_fov == true then
		(
			VRcam.specify_fov = true
			VRcam.fov = cam.fov
		)
		else
		(
			VRcam.specify_fov = false
			VRcam.focal_length 	= cam.focal_length
		)
		VRcam.distortion_type = cam.distortion_type
		VRcam.lens_file = cam.lens_file
		VRcam.distortion_map = cam.distortion_map
		VRcam.lens_shift_auto = cam.lens_shift_auto
		VRcam.specify_focus = cam.specify_focus
		VRcam.exposure = cam.exposure
		VRcam.vignetting = cam.vignetting
		VRcam.type = cam.type
		VRcam.systemLightingUnits = cam.systemLightingUnits
		VRcam.systemLightingUnits = cam.systemLightingUnits
		VRcam.whiteBalance = cam.whiteBalance
		VRcam.whiteBalance_preset = cam.whiteBalance_preset
		VRcam.use_blades = cam.use_blades
		VRcam.blades_number = cam.blades_number
		VRcam.use_dof = cam.use_dof
		VRcam.use_moblur = cam.use_moblur
		VRcam.subdivs = cam.subdivs
		VRcam.clip_on = cam.clip_on
		VRcam.horizon_on = cam.horizon_on
		VRcam.legacy_ISO = cam.legacy_ISO
		VRcam.show_camera_cone = cam.show_camera_cone
		--Animatable
		VRcam.film_width = cam.film_width
		VRcam.zoom_factor = cam.zoom_factor
		VRcam.horizontal_offset = cam.horizontal_offset
		VRcam.vertical_offset = cam.vertical_offset
		VRcam.distortion = cam.distortion
		VRcam.f_number = cam.f_number
		VRcam.target_distance = cam.target_distance
		VRcam.lens_shift = cam.lens_shift
		VRcam.lens_horShift = cam.lens_horShift
		VRcam.focus_distance = cam.focus_distance
		VRcam.dof_display_thresh = cam.dof_display_thresh
		VRcam.vignetting_amount = cam.vignetting_amount
		VRcam.shutter_speed = cam.shutter_speed
		VRcam.shutter_angle = cam.shutter_angle
		VRcam.shutter_offset = cam.shutter_offset
		VRcam.latency = cam.latency
		VRcam.ISO = cam.ISO
		VRcam.temperature = cam.temperature
		VRcam.blades_rotation = cam.blades_rotation
		VRcam.center_bias = cam.center_bias
		VRcam.anisotropy = cam.anisotropy
		VRcam.clip_near = cam.clip_near
		VRcam.clip_far = cam.clip_far
		VRcam.environment_near = cam.environment_near
		VRcam.environment_far = cam.environment_far
		maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true -- Sets the New Key value to Auto
		with animate on 
		(
			for i = (animationrange.start -= frameOffset) to (animationrange.end += frameOffset) do 
			(
				at time i 
				(	
					if cam.specify_fov == true then
					(
						if cam.fov.isAnimated then VRcam.fov = cam.fov
					)
					else
					(
						if cam.focal_length.isAnimated then VRcam.focal_length = cam.focal_length
					)
					VRcam.transform = cam.transform
					if cam.film_width.isAnimated then VRcam.film_width = cam.film_width
					if cam.zoom_factor.isAnimated then VRcam.zoom_factor = cam.zoom_factor
					if cam.horizontal_offset.isAnimated then VRcam.horizontal_offset = cam.horizontal_offset
					if cam.vertical_offset.isAnimated then VRcam.vertical_offset = cam.vertical_offset
					if cam.distortion.isAnimated then VRcam.distortion = cam.distortion
					if cam.f_number.isAnimated then VRcam.f_number = cam.f_number
					if cam.target_distance.isAnimated then VRcam.target_distance = cam.target_distance
					if cam.lens_shift.isAnimated then VRcam.lens_shift = cam.lens_shift
					if cam.lens_horShift.isAnimated then VRcam.lens_horShift = cam.lens_horShift
					if cam.focus_distance.isAnimated then VRcam.focus_distance = cam.focus_distance
					if cam.dof_display_thresh.isAnimated then VRcam.dof_display_thresh = cam.dof_display_thresh
					if cam.vignetting_amount.isAnimated then VRcam.vignetting_amount = cam.vignetting_amount
					if cam.shutter_speed.isAnimated then VRcam.shutter_speed = cam.shutter_speed
					if cam.shutter_angle.isAnimated then VRcam.shutter_angle = cam.shutter_angle
					if cam.shutter_offset.isAnimated then VRcam.shutter_offset = cam.shutter_offset
					if cam.latency.isAnimated then VRcam.latency = cam.latency
					if cam.ISO.isAnimated then VRcam.ISO = cam.ISO
					if cam.temperature.isAnimated then VRcam.temperature = cam.temperature
					if cam.blades_rotation.isAnimated then VRcam.blades_rotation = cam.blades_rotation
					if cam.center_bias.isAnimated then VRcam.center_bias = cam.center_bias
					if cam.anisotropy.isAnimated then VRcam.anisotropy = cam.anisotropy
					if cam.clip_near.isAnimated then VRcam.clip_near = cam.clip_near
					if cam.clip_far.isAnimated then VRcam.clip_far = cam.clip_far
					if cam.environment_near.isAnimated then VRcam.environment_near = cam.environment_near
					if cam.environment_far.isAnimated then VRcam.environment_far = cam.environment_far
				)
			)
		)
		setTransformLockFlags VRcam #all
		append bakeCamArr VRcam
	),
	fn bakeCam_FN cam camParent frameOffset bakeTrans:true =
	(
		createLayerAndSetCurrent ("###_" + cam.name + "_Baked")
		newCam = freecamera name:(uniqueName (cam.name + "_Baked"))
		if camParent != undefined and camParent != cam then (newCam.parent = camParent)
		maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true -- Sets the New Key value to Auto
		with animate on 
		(
			for t = (animationrange.start -= frameOffset) to (animationrange.end += frameOffset) do 
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
		deleteErroneousKeys #(newCam) newCam.position.controller.keys #position
		deleteErroneousKeys #(newCam) newCam.rotation.controller.keys #rotation
		if bakeTrans then deleteErroneousKeys #(newCam) newCam.scale.controller.keys #scale
		append bakeCamArr newCam
	),
	fn ui =
	(
		rollout ro "Camera Baker by GTVFX" width:420 height:520
		(
			local self
			local frameOffset = 5
			local camParent
			local dnTooltip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			dotNetControl dgv_cams "System.Windows.Forms.DataGridView" align:#right width:(ro.width-25) height:(ro.height-325)
			dotNetControl dNspn_offset "System.Windows.Forms.NumericUpDown" pos:[15,220] width:60
			dotNetControl dNlbl_offset "System.Windows.Forms.Label" pos:[80,228] height:30
			dotNetControl dNchk_trans "System.Windows.Forms.CheckBox"  pos:[15,260] width:200 height:30
			dotNetControl dNchk_parent "System.Windows.Forms.CheckBox"  pos:[15,290] width:210 height:30
			dotNetControl dNbtn_pick "system.windows.forms.button" width:140 height:25 pos:[15,(ro.height-190)]
			dotNetControl dgv_parent "System.Windows.Forms.DataGridView" align:#right width:(ro.width-30) height:50 pos:[15,(ro.height-160)]
			dotNetControl dNbtn_bake "system.windows.forms.button" width:(ro.width-30) height:60 pos:[15,(ro.height - 100)]
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
			fn setDotNetWidgetColor dNObj =
			(
				dNObj.backcolor = dNObj.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.forecolor = dNObj.forecolor.FromArgb clrText.x clrText.y clrText.z
				
			)
			fn setDotNetWidget dNobj caption fontSize tooltip:"" =
			(
				dNobj.text = caption
				dNobj.forecolor = dNobj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNobj.backColor = dNobj.backcolor.FromArgb ClrBackGround.x ClrBackGround.y ClrBackGround.z
				dNobj.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
				initToolTip dNobj tooltip
				dNObj.update()
			)
			fn drawData dgv =
			(
				dgv.rows.clear()
				for a in self.collectCamNames() do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					classTxt = ((classOf (getNodeByName a) as string))
					tempRow.SetValues #(a,classTxt)
					case classTxt of
					(
						"Freecamera":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").fromARGB 92 174 241
						)
						"Targetcamera":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").paleturquoise
						)
						"VRayPhysicalCamera":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").fromARGB 255 186 43
						)
						"VRayDomeCamera":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").fromARGB 237 131 61
						)
						default:
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").red
						)
					)
				)
				dgv.update()
			)
			fn dgv_cams_colAr arr:#() =
			(
				append arr #(#text,"Camera:",True,#left)
				append arr #(#text,"Class:",True,#left)
				arr
			)
			fn dgv_parent_colAr arr:#() =
			(
				append arr #(#text,"Parent Object:",True,#left)
				append arr #(#text,"Class:",True,#left)
				arr
			)
			fn initDgv dgv colAr =
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
				dgv.columns.item[0].width = 255
				for i in 0 to dgv.columns.count-1 do
				(
					dgv.Columns.item[i].SortMode = (dotNetClass "System.Windows.Forms.DataGridViewColumnSortMode").NotSortable
				)
				setDataGridColor dgv 11
				dgv.AlternatingRowsDefaultCellStyle.BackColor = dgv.AlternatingRowsDefaultCellStyle.BackColor.FromArgb (clrWindow.x-15) (clrWindow.y-15) (clrWindow.z-15)
				dgv.update()
			)
			fn initDnetBtn dNbtn caption fontSize tooltip:"" = 
			(
				dNbtn.flatStyle = dNbtn.flatStyle.flat
				setDotNetWidget dNbtn caption fontSize tooltip:tooltip
				dNbtn.update()
			)
			fn clearCamParent =
			(
				dgv_parent.rows.clear()
				dNchk_parent.checked = false
				camParent = undefined
			)
			fn getCamParent =
			(
				format "***** Select parent object *****\n"
				camParent = (pickObject())
				if camParent != undefined then
				(
					dgv_parent.rows.clear()
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv_parent.rows.add tempRow
					tempRow.SetValues #(camParent.name,((classOf camParent) as string))
					dNchk_parent.checked = true
				)
				else clearCamParent()
			)
			fn _init pself =
			(
				self = pself
				initDgv dgv_cams (dgv_cams_colAr())
				drawData dgv_cams
				initDgv dgv_parent (dgv_parent_colAr())
				initDnetBtn dNbtn_pick "Pick Parent" 12 tooltip:"Select parent object."
				setDotNetWidget dNchk_parent "Bake Camera With Parent:" 12 tooltip:"Bake cameras with parent."
				setDotNetWidget dNspn_offset (frameOffset as string) 12 tooltip:"Number of frames that will be baked before\nand after the current time range."
				setDotNetWidget dNlbl_offset ":Frame Offset" 12
				setDotNetWidget dNchk_trans "Bake Camera With Scale:" 12 tooltip:"If unchecked will only bake position and rotation."
				initDnetBtn dNbtn_bake "Bake selected cameras" 14
			)
			on dNspn_offset TextChanged arg do
			(
				frameOffset = (dNspn_offset.text as integer)
			)
			on dNspn_offset MouseDown arg do
			(
				if arg.button == dNspn_offset.mouseButtons.right then
				(
					dNspn_offset.text = "0"
					frameOffset = 0
				)
			)
			on dNchk_parent CheckStateChanged arg do
			(
				if dNchk_parent.checked then
				(
					getCamParent()
				)
				else
				(
					clearCamParent()
				)
			)
			on dNbtn_pick MouseDown arg do
			(
				if arg.button == dNbtn_pick.mouseButtons.right then
				(
					if dNchk_parent.checked == true then
					(
						dNchk_parent.checked = false
					)
					else clearCamParent()
				)
				else
				(
					if dNchk_parent.checked == false then
					(
						dNchk_parent.checked = true
					)
					else getCamParent()
				)
			)
			on dNbtn_bake mouseClick do
			(
				self.bakeCamArr = #()
				selRows = dgv_cams.SelectedRows
				camNameArr = #()
				for i in 0 to selRows.count-1 do
				(
					append camNameArr #(selRows.item[i].cells.item[0].value,selRows.item[i].cells.item[1].value)
				)
				camArr = #()
				for i in camNameArr do append camArr (getNodeByName i[1])
				for cam in camArr do
				(
					if isKindOf cam VrayPhysicalCamera then
					(
						self.bakeVRayCam_FN cam camParent frameOffset
					)
					else if isKindOf cam VRayDomeCamera then
					(
						self.bakeDomeCam cam camParent frameOffset
					)
					else
					(
						if dNchk_trans.checked then
						(
							self.bakeCam_FN cam camParent frameOffset bakeTrans:true
						)
						else
						(
							transBake = false
							if isKindOf cam targetCamera then
							(
								messageBox (cam.name+"\nThis is a target camera and must have it's entire transform baked which includes scale.\nIf you really do not want to bake the scale of the camera then\ntake the camera from this result and bake it without scale.")
								transBake = true
							)
							else if (classOf cam.transform.controller) == Alembic_Xform then
							(
								messageBox (cam.name+"\nThis is an Alembic camera and must have it's entire transform baked which includes scale.\nIf you really do not want to bake the scale of the camera then\ntake the camera from this result and bake it without scale.")
								transBake = true
							)
							else if classOf cam.position.controller != Position_XYZ or classOf cam.rotation.controller != Euler_XYZ then
							(
								messageBox (cam.name+"\nThis camera has a non-standard animation controller. As a result this camera will have it's entire transform baked which includes scale.\nIf you really do not want to bake the scale of the camera then\ntake the camera from this result and bake it without scale.")
								transBake = true
							)
							self.bakeCam_FN cam camParent frameOffset bakeTrans:transBake
						)
					)
				)
				select self.bakeCamArr
			)
		)
		createdialog ro
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
cameraBaker = cameraBaker_lib()