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
Updated:				04/20/2014
[Purpose]
Converts a standard Max camera to a VRay camera.
Converts a VRayPhysicalCamera to a Standard Camera.
[KEYWORDS]
VRay, Camera, Convert, VRCam, Physical Cam
__END__
***************************************************************************************************/
try(destroyDialog MaxCamToVRCam.ro)catch()
struct MaxCamToVRayCam_lib
(
	self,
	ro,
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
	fn collectCamNames vrayCam:false=
	(
		if vrayCam then
		(
			arr = for i in cameras where classOf i == VRayPhysicalCamera collect i.name
		)
		else
		(
			arr = for i in cameras where classOf i == FreeCamera or classOf i == TargetCamera collect i.name
		)
		sort arr
		arr
	),
	fn standardCamToVRcam camArr fov:false = 
	(
		for i in camArr do
		(
			createLayerAndSetCurrent ("###_" + i.name + "_Baked")
			VRcamName = ("VRay_" + (i.name as string))
			VRcam = VRayPhysicalCamera whiteBalance_preset:4 whiteBalance:white name:(VRcamName) isSelected:on
			VRcam.targeted = off
			VRcam.target_distance = 100
			VRcam.specify_focus = on
			VRcam.vignetting = false
			VRcam.type = 1 --moviecamera
			VRcam.shutter_angle	= 180
			VRcam.shutter_offset = -90
			VRcam.exposure = false
			VRcam.focus_distance = 1000000 as double
			VRcam.zoom_factor = 1
			VRcam.film_width = getRendApertureWidth()
			VRcam.parent = undefined
			if fov then VRcam.specify_fov = true else VRcam.specify_fov = false
			with animate on 
			(
				for t = animationrange.start to animationrange.end do 
				(
					at time t 
					(	
						VRcam.transform = i.transform
						if fov then VRcam.fov = i.fov else VRcam.focal_length = (cameraFOV.FOVtoMM i.fov)
					)
				)
			)
			setTransformLockFlags VRcam #all
			clearSelection()
		)
	),
	fn VRcamToStandardCam_FN camArr =
	(
		for i in camArr do
		(
			createLayerAndSetCurrent ("###_Stndrd_" + i.name + "_Baked")
			newCam = freecamera name:("Stndrd_" + i.name + "_Baked")
			with animate on 
			(
				for t = (animationRange.start - 5f ) to (animationRange.end + 5f) do
				(
					at time t 
					(
						in coordsys world newCam.transform = i.transform
						if i.specify_fov == true then newcam.fov = i.fov else newcam.fov = i.fov
					)
				)
			)
			setTransformLockFlags newCam #all
		)
	),
	fn ui =
	(
		rollout ro "Max/VRay Camera Converter By GTVFX" width:340 height:410
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local tHeight = 12
			dotNetcontrol dNtab_switch "TabControl" height:20 offset:[0,10]
			dotNetControl dgv_cams "DataGridView" align:#left width:(ro.width-25) height:(ro.height-135)
			checkBox chk_fov "Use FOV:" checked:true across:2
			checkBox chk_focal "Use Focal Length:"
			dotNetControl dNbtn_convert "button" width:(ro.width-25) height:40 
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			
			fn normalizeRGB val =
			(
				if val <0 then val = 0 else if val >255 then val = 255
				val
			)
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
			fn setDotNetWidget dNobj caption fontSize colorOffsetInt:0 =
			(
				dNobj.text = caption
				dNobj.forecolor = dNobj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNobj.backColor = dNobj.backcolor.FromArgb (normalizeRGB (ClrBackGround.x+colorOffsetInt)) (normalizeRGB (ClrBackGround.y+colorOffsetInt)) (normalizeRGB (ClrBackGround.z+colorOffsetInt))
				dNobj.Font = dotNetObject "System.Drawing.Font" "Tahoma" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
			)
			fn initDnetBtn dNbtn caption fontSize style:#popup colorOffsetInt:0 tooltip:"" = 
			(
				case style of
				(
					#flat:(dNbtn.flatStyle = dNbtn.flatStyle.flat)
					#popup:(dNbtn.flatStyle = dNbtn.flatStyle.popup)
					#system:(dNbtn.flatStyle = dNbtn.flatStyle.system)
				)
				setDotNetWidget dNbtn caption fontSize colorOffsetInt:colorOffsetInt
				initToolTip dNbtn tooltip
				dNbtn.tag = tooltip
			)
			fn setDataGridColor dNObj fontSize =
			(
				dNObj.forecolor = dNObj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNObj.BackgroundColor = dNObj.BackgroundColor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.DefaultCellStyle.BackColor = dNObj.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").regular)
			)
			fn drawData dgv dataArr =
			(
				dgv.rows.clear()
				
				for a in dataArr do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					tempRow.SetValues #(a)
				)
			)
			fn initDgv dgv fontsize tooltip:"" =
			(
				dgv.MultiSelect = true
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
				colAr = #()
				append colAr #(#text,"Camera:",True,#left)
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
				for i in 0 to dgv.columns.count-1 do
				(
					dgv.Columns.item[i].SortMode = (dotNetClass "System.Windows.Forms.DataGridViewColumnSortMode").NotSortable
				)
				setDataGridColor dgv fontSize
				dgv.AlternatingRowsDefaultCellStyle.BackColor = dgv.AlternatingRowsDefaultCellStyle.BackColor.FromArgb (clrWindow.x-15) (clrWindow.y-15) (clrWindow.z-15)
				initToolTip dgv tooltip
			)
			fn initTabs dNtab =
			(
				dNtab.controls.clear()
				setDotNetWidget dNtab "" 11 colorOffsetInt:10
				tabArr = #("Max to VRay:","VRay to Max:")
				for r in tabArr do
				(
					tP = dotNetObject "System.Windows.Forms.TabPage"
					setDotNetWidget tP r 10 colorOffsetInt:10
					dNtab.controls.add tP
				)
			)
			fn refreshDataGrid dgv tabIndex: =
			(
				case tabIndex of
				(
					0:
					(
						chk_fov.enabled = True
						chk_focal.enabled = True
						drawData dgv_cams (self.collectCamNames vrayCam:False)
					)
					1:
					(
						chk_fov.enabled = False
						chk_focal.enabled = False
						drawData dgv_cams (self.collectCamNames vrayCam:True)
					)
				)
			)
			fn _init pself =
			(
				self = pself
				initTabs dNtab_switch
				initDgv dgv_cams 12 tooltip:"Select cameras to bake out"
				refreshDataGrid dgv_cams tabIndex:dNtab_switch.selectedIndex
				initDnetBtn dNbtn_convert "Convert selected cameras" 11 style:#popup colorOffsetInt:10
			)
			on dNtab_switch click arg do
			(
				refreshDataGrid dgv_cams tabIndex:dNtab_switch.selectedIndex
			)
			on chk_fov changed state do
			(
				if state then chk_focal.state = false else chk_focal.state = true
			)
			on chk_focal changed state do
			(
				if state then chk_fov.state = false else chk_fov.state = true
			)
			on dNbtn_convert mouseClick do
			(
				selRows = dgv_cams.SelectedRows
				camNameArr = #()
				for i in 0 to selRows.count-1 do
				(
					append camNameArr #(selRows.item[i].cells.item[0].value)
				)
				camArr = #()
				for i in camNameArr do append camArr (getNodeByName i[1])
				case dNtab_switch.selectedIndex of
				(
					(0):self.standardCamToVRcam camArr fov:chk_fov.state
					(1):self.VRcamToStandardCam_FN camArr
				)
			)
		)
		createDialog ro 
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)

MaxCamToVRCam = MaxCamToVRayCam_lib()
