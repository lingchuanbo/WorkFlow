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
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v2.0
Updated:				07/13/2014
[Purpose]
Set the Out-Of-Range Types for the selected objects
Optionally you can change the tangents on the first and last frames.
This is only for Position, Rotation, Scale, and Visibility
***************************************************************************************************/
try(destroyDialog _setORT.ro)catch()
struct setORT_lib 
(
	self,
	ro,
	nodeArr = #(),
	propArr = #(),
	
	fn SetORT obj conName inType outType =
	(
		case conName of
		(
			
			#position:
			(
				if inType != #none then setBeforeORT obj.position.controller inType
				if outType != #none then setAfterORT obj.position.controller outType
			)
			#rotation:
			(
				if inType != #none then setBeforeORT obj.rotation.controller inType
				if outType != #none then setAfterORT obj.rotation.controller outType
			)
			#scale:
			(
				if inType != #none then setBeforeORT obj.scale.controller inType
				if outType != #none then setAfterORT obj.scale.controller outType
			)
			#visibility:
			(
				if inType != #none then setBeforeORT obj.visibility.controller inType
				if outType != #none then setAfterORT obj.visibility.controller outType
			)
			default:
			(
				if inType != #none then setBeforeORT (getPropertyController obj conName) inType
				if outType != #none then setAfterORT (getPropertyController obj conName) outType
			)
		)
	),
	fn setStartEndTangents obj conName inType outType =
	(
		case conName of
		(
			#position:
			(
				keyArr = obj.position.controller.keys
				if keyArr.count != 0 and classOf obj.position.controller == Position_XYZ then
				(
					for i in 1 to 3 do
					(
						if inType != #none then
						(
							k = obj.position.controller[i].keys[keyArr.count]
							k.outTangentType = outType
							k.inTangentType = inType
						)
						if outType != #none then
						(
							k = obj.position.controller[i].keys[1]
							k.outTangentType = outType
							k.inTangentType = inType
						)
					)
				)
			)
			#rotation:
			(
				keyArr = obj.rotation.controller.keys
				if keyArr.count != 0 and classOf obj.rotation.controller == Euler_XYZ then
				(
					for i in 1 to 3 do
					(
						if inType != #none then
						(
							k = obj.rotation.controller[i].keys[keyArr.count]
							k.outTangentType = outType
							k.inTangentType = inType
						)
						if outType != #none then
						(
							k = obj.rotation.controller[i].keys[1]
							k.outTangentType = outType
							k.inTangentType = inType
						)
					)
				)
			)
			#scale:
			(
				keyArr = obj.scale.controller.keys
				if keyArr.count != 0 then
				(
					case (classOf obj.scale.controller) of
					(
						(bezier_scale):
						(
							if inType != #none then
							(
								k = obj.scale.controller.keys[keyArr.count]
								k.outTangentType = outType
								k.inTangentType = inType
							)
							if outType != #none then
							(
								k = obj.scale.controller.keys[1]
								k.outTangentType = outType
								k.inTangentType = inType
							)
						)
						(scaleXYZ):
						(
							for i in 1 to 3 do
							(
								if inType != #none then
								(
									k = obj.scale.controller[i].keys[keyArr.count]
									k.outTangentType = outType
									k.inTangentType = inType
								)
								if outType != #none then
								(
									k = obj.scale.controller[i].keys[1]
									k.outTangentType = outType
									k.inTangentType = inType
								)
							)
						)
						default:
						(
							format "***** Unable to set tangent on scale controller. *****\n"
						)
					)
				)
			)
			#visibility:
			(
				keyArr = obj.visibility.controller.keys
				if keyArr.count != 0 and classOf obj.visibility.controller == bezier_float then
				(
					if inType != #none then
					(
						k = obj.visibility.controller.keys[keyArr.count]
						k.outTangentType = outType
						k.inTangentType = inType
					)
					if outType != #none then
					(
						k = obj.visibility.controller.keys[1]
						k.outTangentType = outType
						k.inTangentType = inType
					)
				)
			)
			default:
			(
				propCtrlr = (getPropertyController obj conName)
				keyArr = propCtrlr.keys
				if keyArr.count != 0 then
				(
					if inType != #none then
					(
						k = propCtrlr.keys[keyArr.count]
						k.outTangentType = outType
						k.inTangentType = inType
					)
					if outType != #none then
					(
						k = propCtrlr.keys[1]
						k.outTangentType = outType
						k.inTangentType = inType
					)
				)
			)
		)
	),
	fn collectAnimatedProperties objArr  =
	(
		propArr = #()
		objArr = (getCurrentSelection())
		for i in objArr do
		(
			propNameArr = getPropNames i
			if propNameArr.count == 0 then continue
			for p in propNameArr do
			(
				if not isPropertyAnimatable i p then continue
				x = getPropertyController i p
				if x != undefined and x.keys.count != 0 then
				(
					appendIfUnique propArr p
				)
			)
		)
		propArr
	),
	fn setOrtByPropName obj propNameArr OrtIn OrtOut tanIn tanOut =
	(
		for i in propNameArr do
		(
			case i of
			(
				#position:
				(
					if not obj.position.isAnimated then continue
					setORT obj #position OrtIn OrtOut
					setStartEndTangents obj #position tanIn tanOut
				)
				#rotation:
				(
					if not obj.rotation.isAnimated then continue
					setORT obj #rotation OrtIn OrtOut
					setStartEndTangents obj #rotation tanIn tanOut
				)
				#scale:
				(
					if not obj.scale.isAnimated then continue
					setORT obj #scale OrtIn OrtOut
					setStartEndTangents obj #scale tanIn tanOut
				)
				#visibility:
				(
					if not obj.visibility.isAnimated then continue
					setORT obj #visibility OrtIn OrtOut
					setStartEndTangents obj #visibility tanIn tanOut
				)
				default:
				(
					propCtrlr = (getPropertyController obj i)
					if propCtrlr == undefined then continue
					setORT obj i OrtIn OrtOut
					setStartEndTangents obj i tanIn tanOut
				)
			)
		)
	),
	fn ui =
	(
		rollout ro "Set ORT By GTVFX" width:200
		(
			local self
			local conArr = #("Position","Rotation","Scale","Visibility")
			local typeArr = #(#none,#constant,#cycle,#loop,#pingPong,#linear,#relativeRepeat)
			local tanTypeArr = #(#none,#smooth,#linear,#step,#fast,#slow,#custom,#auto)
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			dotNetControl dgv_cons "DataGridView" align:#left width:(ro.width-26) height:200
			dotNetControl dNbtn_refresh "Button" width:(ro.width-25) height:18
			group "Settings:"
			(
				dropDownList ddl_in "Set Type In:" items:typeArr selection:6
				dropDownList ddl_out "Set Type Out:" items:typeArr selection:6
				dropDownList ddl_first "Set First Frame Tangent:" items:tanTypeArr selection:3
				dropDownList ddl_last "Set Last Frame Tangent:" items:tanTypeArr selection:3
			)
			
			dotNetControl dNbtn_set "Button" width:(ro.width-25) height:40
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com"
			
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
			fn setDataGridColor dgv fontSize =
			(
				dgv.forecolor = dgv.forecolor.FromArgb clrText.x clrText.y clrText.z
				dgv.BackgroundColor = dgv.BackgroundColor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dgv.DefaultCellStyle.BackColor = dgv.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dgv.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
				dgv.AlternatingRowsDefaultCellStyle.BackColor = dgv.AlternatingRowsDefaultCellStyle.BackColor.FromArgb (normalizeRGB(clrWindow.x-15)) (normalizeRGB(clrWindow.y-15)) (normalizeRGB(clrWindow.z-15))
			)
			fn drawData dgv dataArr =
			(
				dgv.rows.clear()
				for a in dataArr do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					tempRow.SetValues #(a)
					case a of
					(
						"Position":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").red
						)
						"Rotation":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").green
						)
						"Scale":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").blue
						)
						"Visibility":
						(
							tempRow.DefaultCellStyle.ForeColor = (dotnetClass "System.Drawing.Color").cyan
						)
					)
				)
			)
			fn initDgv dgv =
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
				colAr = #()
				append colAr #(#text,"Controller:",True,#left)
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
				dgv.columns.item[0].width = 180
				setDataGridColor dgv 10
				initToolTip dgv "Select the controllers you want to set the Out-Of-Range types for."
			)
			fn posHyperLink posX posY =
			(
				hyp_website.pos = [posX,posY]
			)
			fn cellValuesToNameArr dgvRowArr =
			(
				arr = #()
				for i = 0 to (dgvRowArr.count-1) do
				(
					append arr (dgvRowArr.item[i].cells.item[0].value as name)
				)
				arr
			)
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_refresh "Refresh controller list" 8 style:#flat colorOffsetInt:10 tooltip:"Refresh the controller list for your current selection"
				initDnetBtn dNbtn_set "Set ORT for selected properties" 10 style:#popup colorOffsetInt:10 tooltip:"Go through all objects in your selection and\nset the ORT for the selected properties."
				initDgv dgv_cons 
				self.nodeArr = (getCurrentSelection())
				dispCons = #()
				dispCons += conArr
				for i in (self.collectAnimatedProperties self.nodeArr) do
				(
					append dispCons (i as string)
				)
				drawData dgv_cons dispCons
			)
			on dNbtn_refresh mouseClick arg do
			(
				self.nodeArr = (getCurrentSelection())
				dispCons = #()
				dispCons += conArr
				for i in (self.collectAnimatedProperties self.nodeArr) do
				(
					append dispCons (i as string)
				)
				drawData dgv_cons dispCons
			)
			on dNbtn_set mouseClick arg do
			(
				if self.nodeArr.count != 0 then
				(
					conArr = cellValuesToNameArr dgv_cons.SelectedRows
					for i in self.nodeArr do
					(
						self.setOrtByPropName i conArr ddl_in.selected ddl_out.selected ddl_first.selected ddl_last.selected
					)
				)
				else messageBox "You must have objects selected...\nMake a selection and press the refresh button." title:"GTVFX: User Error... :("
			)
			on ro open do
			(
				posHyperLink (ro.width/2-40) (ro.height - 20)
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
_setORT = setORT_lib()

