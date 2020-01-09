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
ScriptVersion:			v2.0
Updated:				02/17/2014
[Purpose]
Manages the creation of VRay Light Select Elements based on a layer naming convention.
All lights on a layer will be included in that Light Select Element.
Layers are found by matching the pattern of the nameTag variable. You can change this variable if necessary for your pipeline.
[KEYWORDS]
VRay, Light, LightSelect, ByLayer
__END__
***************************************************************************************************/
struct VRayLightSelectByLayer_Lib
(
	self,
	ro,
	VLS_Ini = ((getDir #plugCFG)+@"\GTVFX_VLS.ini"),
	nameTag = "*lgt_*",
	elmntMgr = maxOps.GetCurRenderElementMgr(),
	
	fn getLGTlayerNames_FN arr:#()=
	(
		for i = 0 to layerManager.count-1 do
		(
			layerName = (layerManager.getLayer i).name 
			if matchPattern layerName pattern:nameTag == true then append arr layerName
		)
		sort arr
		arr
	),
	fn clearLightSelectElements_FN arr:#()=
	(
		numElements = elmntMgr.NumRenderElements()
		for i in 0 to (numElements-1) do
		(
			elementEach = elmntMgr.GetRenderElement i
			if matchPattern elementEach.elementName pattern:nameTag then 
			(
				append arr elementEach
			)
		)
		if arr.count != 0 then
		(
			for i in arr do
			(
				format "***** Removing Element: % *****\n" i.elementName
				elmntMgr.RemoveRenderElement i
			)
			renderSceneDialog.update()
		)
		true
	),
	fn createLightSelectElementsByLayer_FN nameArr =
	(
		if nameArr.count > 0 then
		(
			for i in nameArr do
			(
				if LayerManager.getLayerFromName i != undefined then
				(
					lgtLayer =  LayerManager.getLayerFromName i
					lgtLayerNodes = lgtLayer.nodes &lgtArr
					lgtArr = for each in lgtArr where superClassOF each == Light collect each
					layerNameArr = filterString i "_"
					elementName = (filterString (filterString nameTag "*")[1] "_")[1]
					for each in layerNameArr where each != "###" and each != elementName do
					(
						elementName += ("_" + each)
					)
					elmntMgr.addrenderelement (VRayLightSelect elementname:elementName vrayVFB:TRUE color_mapping:FALSE multiplier:1.0 lights:lgtArr lightsExcludeType:1)
				)
			)
			renderSceneDialog.update()
		)
		else messageBox "No LGT layers found."
	),
	fn changeNameTag = 
	(
		rollout ro_name "Change Layer nameTag" width:200 height:80
		(
			local self
			editText edt_nameTag "nameTag:" labelOnTop:true
			button btn_apply "Apply nameTag"
			fn _init pself =
			(
				self = pself
			)
			on btn_apply pressed do
			(
				self.nameTag = edt_nameTag.text
				setIniSetting self.VLS_Ini "General" "nameTag" self.nameTag
				destroyDialog ro_name
				self._init()
			)
		)
		createDialog ro_name 
		ro_name._init self
	),
	fn ui =
	(
		rollout ro "VRay lightSelect Elements By Layer By GTVFX" width:370 height:450
		(
			local self
			local dnTooltip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			dotNetControl dNlbl_nameTag "Label" height:18
			dotNetControl dNbtn_changeName  "button" width:(ro.width-20) height:18 offset:[-3,0]
			dotNetControl dgv_elmntList "DataGridView" align:#left height:(ro.height-150) 
			dotNetControl dNbtn_clearElements "button" width:(ro.width-20) height:20 offset:[-3,0]
			dotNetControl dNbtn_createElements "button" width:(ro.width-20) height:40 offset:[-3,0]
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:(color 0 128 128) address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			
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
				dNobj.backColor = dNobj.backcolor.FromArgb (ClrBackGround.x+colorOffsetInt) (ClrBackGround.y+colorOffsetInt) (ClrBackGround.z+colorOffsetInt)
				dNobj.Font = dotNetObject "System.Drawing.Font" "Tahoma" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
				dNobj.update()
			)
			fn setDataGridColor dgv fontSize =
			(
				dgv.forecolor = dgv.forecolor.FromArgb clrText.x clrText.y clrText.z
				dgv.BackgroundColor = dgv.BackgroundColor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dgv.DefaultCellStyle.BackColor = dgv.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dgv.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
				dgv.AlternatingRowsDefaultCellStyle.BackColor = dgv.AlternatingRowsDefaultCellStyle.BackColor.FromArgb (clrWindow.x-15) (clrWindow.y-15) (clrWindow.z-15)
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
				dNbtn.update()
			)
			fn drawData dgv =
			(
				dgv.rows.clear()
				for a in self.getLGTlayerNames_FN() do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					tempRow.SetValues #(a)
				)
				dgv.update()
			)
			fn initDgv dgv caption =
			(
				dgv.multiSelect = true
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
				append colAr #(#text,caption,True,#left)
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
				dgv.columns.item[0].width = dgv.width
				for i in 0 to dgv.columns.count-1 do
				(
					dgv.Columns.item[i].SortMode = (dotNetClass "System.Windows.Forms.DataGridViewColumnSortMode").NotSortable
				)
				setDataGridColor dgv 10
				dgv.update()
			)
			fn _init pself =
			(
				self = pself
				setDotNetWidget dNlbl_nameTag ("Current nameTag: " + self.nameTag) 8
				dNlbl_nameTag.textAlign = (dotNetClass "System.Drawing.ContentAlignment").middleCenter
				initDgv dgv_elmntList "Lighting Layers:"
				drawData dgv_elmntList
				initDnetBtn dNbtn_createElements "Create Selected Elements" 10 style:#popup colorOffsetInt:10 tooltip:"Create elements for selected layers"
				initDnetBtn dNbtn_clearElements "Clear Existing Elements" 10 style:#popup colorOffsetInt:10 tooltip:"Deletes all VRayLightSelect elements that match the nameTag"
				initDnetBtn dNbtn_changeName "Change nameTag" 8 style:#popup colorOffsetInt:10 tooltip:"Permanently change the string pattern that is searched to find lighting layers"
			)
			fn getItemNames_FN arr:#() =
			(
				selRows = dgv_elmntList.SelectedRows
				for i in 0 to selRows.count-1 do
				(
					appendIfUnique arr selRows.item[i].cells.item[0].value
				)
				arr
			)
			on dNbtn_changeName mouseClick arg do
			(
				self.changeNameTag()
			)
			on dNbtn_clearElements mouseClick arg do
			(
				self.clearLightSelectElements_FN()
			)
			on dNbtn_createElements mouseClick arg do
			(
				self.createLightSelectElementsByLayer_FN (getItemNames_FN())
			)
		)
		createDialog ro 
		ro._init self
	),
	fn _init =
	(
		self = this
		if doesFileExist VLS_Ini then
		(
			nameTag = getIniSetting VLS_Ini "General" "nameTag"
		)
		ui()
	),
	init = _init()
)
try(destroyDialog VLSB.ro)catch()
VLSB = VRayLightSelectByLayer_Lib()
