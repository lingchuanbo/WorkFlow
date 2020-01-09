/***************************************************************************************************
Copyright (C) 2013 - 2017  Gavyn Thompson

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
Author: Gavyn Thompson
Company: GTVFX
Website: https://github.com/gtvfx
Email: gftvfx@gmail.com
__END__
***************************************************************************************************/


::DotNetUi = ""


struct DotNetUi
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This struct is a collection of methods that wrap DotNet UI elements and
	normalizes their look and behavior to seemlessly integrate with the 3dsmax UI.
	
	Members:
		[Var] clrBackground
		[Var] clrBackground_dnet
		[Var] clrText
		[Var] clrText_dnet
		[Var] clrWindow
		[Var] clrWindow_dnet
		[Var] clr_skyblue
		[Var] dnTooltip
		
		[FN] ChangeDgvCellColor
		[FN] ChangeTxtBoxColor
		[FN] DestroyToolTip
		[FN] DicFromDataGrid
		[FN] DisplayImage
		[FN] FilterDataGridRows
		[FN] GetColIndex
		[FN] GetComboBoxItems
		[FN] GetControlByName
		[FN] GetModule
		[FN] GetTabIndex
		[FN] GetUiControlDic
		[FN] GetUiControlName
		[FN] InitDgv
		[FN] InitDnetBtn
		[FN] InitDnetLbl
		[FN] InitToolTip
		[FN] InitTreeView
		[FN] InitTxtBx
		[FN] NormalizeRGB
		[FN] OffsetDnetColorValue
		[FN] ResizeImage
		[FN] RgbToDnetColor
		[FN] SetDataGridColor
		[FN] SetDotNetWidget
		[FN] ToggleDgvRowDisplay
		[FN] UpdateDgvOpt
		[FN] help
		[FN] initDnetRdo
		[FN] initTabs
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	dnTooltip,
	----------------------------
	clrWindow = ( ( colorMan.getColor #window )*255 ),
	clrText = ( ( colorMan.getColor #text )*255 ),
	clrBackground = ( ( colorMan.getColor #background )*255 ),
	
	clrWindow_dnet,
	clrText_dnet,
	clrBackground_dnet,
	----------------------------
	clr_skyblue = ( dotnetClass "System.Drawing.Color" ).SkyBlue,
	
	fn NormalizeRGB val =
	(
		/*DOC_--------------------------------------------------------------------
		Ensures that val is an integer between 0 and 255
		
		Args:
			val (int)
		
		Returns:
			val (int)
		
		--------------------------------------------------------------------_END*/
		
		if val < 0 then val = 0 else if val > 255 then val = 255
		val
	),
	
	fn RgbToDnetColor rgbColor =
	(
		/*DOC_--------------------------------------------------------------------
		Converts the inputed rgbColor value into a dotNetClass "System.Drawing.Color"
		
		Args:
			rgbColor (color | Point3)
		
		Returns:
			(dotNetClass "System.Drawing.Color")
		
		--------------------------------------------------------------------_END*/
		
		try
		(
			rgbColor = rgbColor as color
		)
		catch
		(
			return ( format "***** Undable to convert % to color *****\n" )
		)
		
		(dotNetClass "System.Drawing.Color").fromARGB ( this.NormalizeRGB rgbColor.a ) ( this.NormalizeRGB rgbColor.r ) ( this.NormalizeRGB rgbColor.g) ( this.NormalizeRGB rgbColor.b )
	),
	
	fn OffsetDnetColorValue dnetColor offsetVal =
	(
		/*DOC_--------------------------------------------------------------------
		Uniformly offsets the inputed dnetColor value by the offsetVal
		
		Args:
			dnetColor (dotnetClass "System.Drawing.Color")
			offsetVal (integer)
		
		Returns:
			(dotnetClass "System.Drawing.Color")
		
		--------------------------------------------------------------------_END*/
		
		local p3 = [dnetColor.r, dnetColor.g, dnetColor.b]
		
		this.RgbToDnetColor ( p3 + offsetVal )
	),
	
	fn InitToolTip dNetObj caption =
	(
		/*DOC_--------------------------------------------------------------------
		Creates an instance of a DotNet ToolTip on the inputed dNetObj.
		
		Args:
			dNetObj (dotnetobject) : Object to create the tooltip for
			caption (string) : Tooltip text
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		try( this.dnTooltip.Dispose() )catch()
				
		this.dnToolTip = dotnetobject "ToolTip"
		this.dnToolTip.AutoPopDelay = 5000
		this.dnToolTip.InitialDelay = 300
		this.dnToolTip.ReshowDelay = 300
		this.dnToolTip.ShowAlways = true
		this.dnToolTip.IsBalloon = true
		
		this.dnToolTip.SetToolTip dNetObj caption
	),
	
	fn DestroyToolTip =
	(
		/*DOC_--------------------------------------------------------------------
		This destroys teh DotNet ToolTip object.
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if this.dnToolTip != undefined then
		(
			this.dnToolTip.RemoveAll()
			this.dnToolTip.Dispose()
			this.dnToolTip = Undefined
		)
	),
	
	fn SetDotNetWidget dNobj caption fontSize colorOffsetInt:0 fontStyle:#bold foreColor:unsupplied =
	(
		/*DOC_--------------------------------------------------------------------
		Sets standard options on DotNet Widgets
		
		Args:
			dNobj (dotNetObject)
			caption (string)
			fontSize (integer)
		
		Kwargs:
			colorOffsetInt (integer)
			fontStyle (name)
			forColor (dotNetColor)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if foreColor != unsupplied and ( ClassOf foreColor ) == Color then
		(
			foreColor = this.RgbToDnetColor foreColor
		)
		
		local fStyle = case fontStyle of
		(
			(#bold):
			(
				(( dotNetClass "System.Drawing.FontStyle" ).bold )
			)
			(#italic):
			(
				(( dotNetClass "System.Drawing.FontStyle" ).italic )
			)
			(#regular):
			(
				(( dotNetClass "System.Drawing.FontStyle" ).regular )
			)
		)
		
		dNobj.text = caption
		if foreColor == unsupplied then dNobj.forecolor = this.clrText_dnet else dNobj.forecolor = foreColor
		dNobj.backColor = ( this.OffsetDnetColorValue this.clrBackground_dnet colorOffsetInt )
		dNobj.Font = ( dotNetObject "System.Drawing.Font" "Tahoma" fontSize fStyle )
		dNobj.update()
	),
	
	fn ChangeTxtBoxColor txtBox newcolor =
	(
		/*DOC_--------------------------------------------------------------------
		Change the color of the text in a DotNet TextBox
		
		Args:
			txtBox (dotnetobject)
			newcolor (color)
		
		Returns:
			RETURNDATA: (type)
		
		--------------------------------------------------------------------_END*/
		
		if ( ClassOf newcolor ) == Color then
		(
			newcolor = this.RgbToDnetColor newcolor
		)
		
		txtBox.forecolor = newcolor
	),
	
	fn SetDataGridColor dgv fontSize _forecolor:  =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the color pallette for a DotNet DataGridView
		
		Args:
			dgv (dotnetobject)
			fontSize (integer)
		
		Kwargs:
			_forecolor (color)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if _forecolor != unsupplied and ( ClassOf _forecolor == Color ) then
		(
			_foreColor = this.RgbToDnetColor _foreColor
		)
		else if _foreColor == unsupplied then
		(
			_foreColor = this.clrText_dnet
		)
		
		try( dgv.forecolor = _foreColor )catch()
		try( dgv.BackgroundColor = this.clrWindow_dnet )catch()
		try( dgv.DefaultCellStyle.BackColor = this.clrWindow_dnet )catch()
		try( dgv.AlternatingRowsDefaultCellStyle.BackColor = ( this.OffsetDnetColorValue this.clrWindow_dnet -15 ) )catch()
		try( dgv.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ( (dotNetClass "System.Drawing.FontStyle" ).bold ) )catch()
	),
	
	fn InitTabs dNtab tabArr =
	(
		/*DOC_--------------------------------------------------------------------
		Sets default settings for a DotNet Tab View
		
		Args:
			dNtab (dotNetObject)
			tabArr (array[string])
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		dNtab.controls.clear()
		this.SetDotNetWidget dNtab "" 11 colorOffsetInt:10
		for tab in tabArr do
		(
			local tP = dotNetObject "System.Windows.Forms.TabPage"
			tP.name = tab
			this.SetDotNetWidget tP tab 11 colorOffsetInt:10
			dNtab.controls.add tP
		)
		dNtab.update()
	),
	
	fn initDnetRdo dNrdo caption fontsize useAsButton:false tooltip:"" =
	(
		/*DOC_--------------------------------------------------------------------
		Sets default settings for a DotNet Radio button
		
		Args:
			dNrdo (dotNetObject)
			caption (string)
			fontsize (integer)
		
		Kwargs:
			useAsButton (boolean)
			tooltip (string)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if useAsButton then
		(
			dNrdo.appearance = dNrdo.appearance.button
			dNrdo.flatstyle = dNrdo.flatstyle.Flat
			dNrdo.textAlign = ( dotNetClass "System.Drawing.ContentAlignment" ).middleCenter
			dNrdo.FlatAppearance.CheckedBackColor = ( dotnetClass "System.Drawing.Color" ).dodgerBlue
		)
		else
		(
			dNrdo.appearance = dNrdo.appearance.normal
		)
		
		this.SetDotNetWidget dNrdo caption fontSize
		dNrdo.tag = tooltip
		dNrdo.Update()
	),
	
	fn InitDnetBtn dNbtn caption fontSize style:#popup colorOffsetInt:0 tooltip:"" =
	(
		/*DOC_--------------------------------------------------------------------
		Sets default options for a DotNet Button
		
		Args:
			dNbtn (dotNetObject)
			caption (string)
			fontSize (integer)
		
		Kwargs:
			style (name)
			colorOffsetInt (integer)
			tooltip (string)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		case style of
		(
			#flat:(dNbtn.flatStyle = dNbtn.flatStyle.flat)
			#popup:(dNbtn.flatStyle = dNbtn.flatStyle.popup)
			#system:(dNbtn.flatStyle = dNbtn.flatStyle.system)
		)
		
		this.SetDotNetWidget dNbtn caption fontSize colorOffsetInt:colorOffsetInt
		dNbtn.tag = tooltip
		dNbtn.Update()
	),
	
	fn InitTxtBx tbx caption fontSize tooltip:"" =
	(
		/*DOC_--------------------------------------------------------------------
		Sets default values for DotNet Textbox
		
		Args:
			tbx (dotNetObject)
			caption (string)
			fontSize (integer)
		
		Kwargs:
			tooltip (string)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		tbx.backcolor = this.clrWindow_dnet
		tbx.forecolor = this.clrText_dnet
		tbx.text = caption
		tbx.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ( ( dotNetClass "System.Drawing.FontStyle" ).bold )
		tbx.BorderStyle = ( dotNetClass "System.Windows.Forms.BorderStyle" ).FixedSingle
		tbx.MultiLine = false
		tbx.AcceptsReturn = false
		tbx.AcceptsTab = false
		tbx.WordWrap = false
		tbx.tag = tooltip
		tbx.update()
	),
	
	fn InitDnetLbl lbl caption fontsize fontStyle:#bold foreColor:unsupplied =
	(
		/*DOC_--------------------------------------------------------------------
		Sets default values for a DotNet Label
		
		Args:
			lbl (dotNetObject)
			caption (string)
			fontsize (integer)
		
		Kwargs:
			fontStyle (name)
			foreColor (color)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.SetDotNetWidget lbl caption fontSize fontStyle:fontStyle foreColor:foreColor
	),
	
	fn ChangeDgvCellColor dgvCell _color =
	(
		/*DOC_--------------------------------------------------------------------
		Changes the text color in the inputed DateGridView Cell
		
		Args:
			dgvCell (dotNetObject)
			_color (color)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( ClassOf _color ) == Color or ( ClassOf _color ) == Point3 then
		(
			_color = this.RgbToDnetColor _color
		)
		
		local newStyle = dotNetObject "System.Windows.Forms.DataGridViewCellStyle"
		newStyle.foreColor = _color
		dgvCell.Style = newStyle
	),
	
	fn UpdateDgvOpt dgvCell dataArr setItem: =
	(
		/*DOC_--------------------------------------------------------------------
		Adds items to a DataGridView Cell option box ( ComboBox )
		
		Args:
			dgvCell (dotNetObject)
			dataArr (array[string])
		
		Kwargs:
			setItem ( string | array ) : Sets the current value of the option box to this value
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		dgvCell.items.clear()
		
		for i in dataArr do dgvCell.items.add i
			
		dgvCell.value = dataArr[1]
		
		if setItem != unsupplied then
		(
			if ( ClassOf setItem != Array ) then setItem = #( setItem )
			
			for item in setItem do
			(
				if ( findItem dataArr item ) != 0 then
				(
					dgvCell.value = item
					exit
				)
			)
		)
	),
	
	fn ToggleDgvRowDisplay dgv visible:True =
	(
		/*DOC_--------------------------------------------------------------------
		Hide or unhide all rows in a DataGridView
		
		Args:
			dgv (dotNetObject)
		
		Kwargs:
			visible (boolean)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		for i = 0 to dgv.rows.count-1 do
		(
			dgv.rows.item[i].visible = visible
		)
	),
	
	fn FilterDataGridRows dgv filterTxt cellIndex:1 = -- function for the search feature
	(
		/*DOC_--------------------------------------------------------------------
		Tests the text in the cell at the inputed cellIndex for each row in the 
		inputed DataGridView to see if it's a match for the inputed filterTxt.
		If it's not a match, the row is hidden.
		
		Args:
			dgv (dotNetObject)
			filterTxt (string)
		
		Kwargs:
			cellIndex (integer)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if filterTxt == "" or filterTxt == "Search" then
		(
			for i = 0 to dgv.rows.count-1 do
			(
				dgv.rows.item[i].visible = true
			)
		)
		else
		(
			for i = 0 to dgv.rows.count-1 do
			(
				if not matchPattern dgv.rows.item[i].cells.item[cellIndex].value pattern:("*"+filterTxt+"*") then
				(
					dgv.rows.item[i].visible = false
				)
				else
				(
					dgv.rows.item[i].visible = true
				)
			)
		)
	),
	
	fn ResizeImage DotNetBitmap width: height: =
	(
		/*DOC_--------------------------------------------------------------------
		Resizes a DotNet Bitmap object
		
		Args:
			DotNetBitmap (dotNetObject)
		
		Kwargs:
			width (integer)
			height (integer)
		
		Returns:
			(otnetobject "System.Drawing.Bitmap")
		
		--------------------------------------------------------------------_END*/
		
		if width == unsupplied or height == unsupplied then
		(
			throw "ResizeImage requires valid integer values for the 'width' and 'height' parameters."
		)
		
		local outImg = ( dotnetobject "System.Drawing.Bitmap" width height )
		local graphic = ( dotnetclass "System.Drawing.Graphics" ).fromImage outImg
		
		graphic.CompositingQuality = graphic.CompositingQuality.HighQuality
		graphic.SmoothingMode = graphic.SmoothingMode.HighQuality
		graphic.InterpolationMode = graphic.InterpolationMode.HighQualityBicubic	
		
		local rect = dotnetobject "System.Drawing.Rectangle" 0 0 width height
		graphic.DrawImage DotNetBitmap rect
		
		local out = Copy outImg
		
		outImg.Dispose()
		graphic.Dispose()
		DotNetBitmap.Dispose()
		GC quiet:True
		
		out
	),
	
	fn DisplayImage filePath =
	(
		/*DOC_--------------------------------------------------------------------
		Creates a DotNet Bitmap object form the inputed filePath and sets it to the
		ClipBoard image. It then displays the ClipBoardBitmap.
		
		This is a workaround for displaying an image
		
		Args:
			filePath (string)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		local image = ( dotNetClass "System.Drawing.Bitmap" ).fromFile filePath
		
		--local pformat = image.PixelFormat
		local width = image.Width
		local height = image.Height
		
		local dest = dotnetobject "System.Drawing.Bitmap" width height --pformat
		local graphic = (dotnetclass "System.Drawing.Graphics").fromImage dest
		
		graphic.CompositingQuality = graphic.CompositingQuality.HighQuality
		graphic.SmoothingMode = graphic.SmoothingMode.HighQuality
		graphic.InterpolationMode = graphic.InterpolationMode.HighQualityBicubic
		
		local rect = dotnetobject "System.Drawing.Rectangle" 0 0 width height
		graphic.DrawImage image rect
		
		local clipboard = dotnetclass "Clipboard"
		clipboard.SetImage dest
		
		image.Dispose()
		dest.Dispose()
		graphic.Dispose()
		
		local cBitmap = GetclipboardBitmap()
		
		if cBitmap != undefined then
		(
			Display cBitmap
		)
	),
	
	fn InitDgv dgv fontsize colAr multiSelct:True _forecolor: AllowUserToAddRows:False =
	(
		/*DOC_--------------------------------------------------------------------
		Initialize a DataGridView with the data from the inputed colAr
		
		Args:
			dgv (dotNetObject)
			fontsize (integer)
			colAr (array[data])
		
		Kwargs:
			multiSelect (boolean)
			_forecolor (color)
			AllowUserToAddRows (boolean)
		
		Returns:
			(VOID)
		
		Example colAr:
		#(#Icon,"OPT:",True,#center,optIcon)
		
		--------------------------------------------------------------------_END*/
		
		dgv.Columns.Clear()
		dgv.ShowCellToolTips = False
		dgv.MultiSelect = multiSelct
		dgv.AllowUserToAddRows = AllowUserToAddRows
		dgv.AutoSize = True
		dgv.AutoSizeColumnsMode = dgv.AutoSizeColumnsMode.Fill
		dgv.ShowEditingIcon = dgv.RowHeadersVisible = False
		local dnSelectionMode = dotNetClass "System.Windows.Forms.DataGridViewSelectionMode"
		dgv.SelectionMode = dnSelectionMode.FullRowSelect
		dgv.AllowUserToResizeRows = False
		dgv.AllowUserToOrderColumns = False
		dgv.AllowUserToResizeColumns = True
		dgv.ColumnHeadersHeightSizeMode = dgv.ColumnHeadersHeightSizeMode.DisableResizing
		
		for col in colAr do
		(
			local dnNewColumn
			
			case col[1] of
			(
				(#Text):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewTextBoxColumn"
				(#Bool):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewCheckBoxColumn"
				(#Icon):
				(
					dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewImageColumn"
					-- Need to pass an image
					if  col[5] != undefined and (DoesFileExist col[5]) then
					(
						local sourceImg = (dotNetClass "System.Drawing.Bitmap").fromFile col[5]
						
						dnNewColumn.image = ( this.ResizeImage sourceImg width:48 height:48 )
					)
				)
				(#Combo):dnNewColumn = dotNetObject "System.Windows.Forms.DataGridViewComboBoxColumn"
			)
			
			dnNewColumn.name = col[2]
			dnNewColumn.HeaderText = col[2]
			dnNewColumn.ReadOnly = col[3]
			local dnAlignment = dotNetClass "System.Windows.Forms.DataGridViewContentAlignment"
			
			case col[4] of
			(
				#Right:		dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleRight
				#Center:	dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleCenter
				#Left:		dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleLeft
				default:	dnNewColumn.DefaultCellStyle.Alignment = dnAlignment.MiddleLeft
			)
			dgv.columns.add dnNewColumn
		)
		
		this.SetDataGridColor dgv fontSize _forecolor:_forecolor
		
		for c = 0 to (colAr.count-1) do
		(
			dgv.columns.item[c].sortMode = (dotNetClass "System.Windows.Forms.DataGridViewColumnSortMode").automatic
		)
		
		dgv.update()
	),
	
	fn initTreeview trv fontsize:10 forecolor:( this.RgbToDnetColor this.clrText ) =
	(
		/*DOC_--------------------------------------------------------------------
		Initialize a DotNet TreeView
		
		Args:
			trv (dotNetObject)
		
		Kwargs:
			fontsize (integer)
			forecolor (color)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		-- looking into this tv ops struct? not sure if its a maxsript lib that autodesk uses for their tool dev...
		
		::tvops.InitTreeView trv pFullRowSel:true pAllowDrop:true
	
		-- tvops.InitImageList tv imgFiles pSize:16 pTransparentColor:transparency 
		-----------------------------------------
		--trv.drawMode = trv.drawmode.OwnerDrawText
		--trv.imageList = IL
		trv.showLines = true
		trv.showPlusMinus = true
		trv.scrollable = true
		trv.sorted = false
		trv.labelEdit = false
		trv.hideSelection = false
		trv.fullRowSelect = true
		--------------
		trv.checkBoxes = true
		trv.backcolor = this.RgbToDnetColor this.clrWindow
		trv.forecolor = forecolor
		
		trv.font = dotnetobject "System.Drawing.Font" "Tahoma" fontsize (dotnetclass"System.Drawing.FontStyle").bold
		
		trv.update()
	),
	
	fn GetComboBoxItems dgvCell =
	(
		/*DOC_--------------------------------------------------------------------
		Collect the item values within the DataGridView Cell comboBox
		
		Args:
			dgvCell (dotNetObject)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		local out = #()
		
		if ( isProperty dgvCell #items ) then
		(
			for i = 0 to ( dgvCell.items.count-1 ) do
			(
				append out dgvCell.items.item[i]
			)
		)
		
		out
	),
	
	fn GetColIndex dgv _name =
	(
		/*DOC_--------------------------------------------------------------------
		Gets the index of the column that matches the inputed _name
		
		Requires the name property of the column to be set during dgv_init
		
		Args:
			dgv (dotNetObject)
			_name (string)
		
		Returns:
			(integer)
		
		--------------------------------------------------------------------_END*/
		
		-- Putting into a TryCatch to ensure that it returns a logical value instead of crashing
		try(dgv.columns.item[_name].index)catch(undefined)
	),
	
	fn GetTabIndex tab _name =
	(
		/*DOC_--------------------------------------------------------------------
		Gets the index of the tab page that matches the inputed _name
		
		Requires the name property of the tab to be set during InitTabs
		
		Args:
			tab (dotNetObject)
			_name (string)
		
		Returns:
			(integer)
		
		--------------------------------------------------------------------_END*/
		
		-- Putting into a TryCatch to ensure that it returns a logical value instead of crashing
		try(tab.tabPages.item[_name].TabIndex)catch(undefined)
	),
		
	fn GetUiControlName uiControl = 
	(
		/*DOC_--------------------------------------------------------------------
		Filter the string of a UI Control object for its explicit name
		
		Args:
			uiControl (uiControlObject)
		
		Returns:
			uiName: (string)
		
		--------------------------------------------------------------------_END*/
		
		local str = ( uiControl as string )
		local nameArr = (filterString str ":")
		local uiName = nameArr[2]
		
		if matchPattern nameArr[1] pattern:"Group*Control" then
		(
			local subName = SubstituteString nameArr[1] "Group" ""
			subName = SubstituteString subName "Control" ""
			
			uiName = ("Group_" + nameArr[2] + "_" + subName)
		)
		
		uiName
	),
	
	fn GetControlByName ui controlName =
	(
		/*DOC_--------------------------------------------------------------------
		Seach the UI Controls of a rollout and return the one that matches
		the inputed name
		
		Args:
			ui (MaxScript Rollout)
			controlName (string)
		
		Returns:
			(uiControlObject)
		
		--------------------------------------------------------------------_END*/
		
		local strPattern = ( "*:"+controlName+"*" )
		if matchPattern controlName pattern:"Group_*" then
		(
			local nameArr = filterString controlName "_"
			
			strPattern = ( "*"+nameArr[1]+nameArr[3]+"Control:"+nameArr[2]+"*" )
		)
		
		local out = (for i in ui.controls where matchPattern (i as string) pattern:strPattern collect i)[1]
		out
	),
	
	fn GetUiControlDic ui =
	(
		/*DOC_--------------------------------------------------------------------
		Generates a dictionary of all controls within a MaxScript Rollout with
		all the UI properties of the control objects
		
		This is used to facilitate the UI resizing logic
		
		Args:
			ui (MaxScript Rollout)
		
		Returns:
			(dotNet HashTable)
		
		--------------------------------------------------------------------_END*/
		
		local dic = dotNetObject "System.Collections.Hashtable"
		local subDic = dotNetObject "System.Collections.Hashtable"
		subDic.add "width" ui.width
		subDic.add "height" ui.height
		dic.add "ui" subDic
		
		for c in ui.controls do
		(
			subDic = dotNetObject "System.Collections.Hashtable"
			if isproperty c #width then subDic.add "width" c.width
			if isproperty c #height then subDic.add "height" c.height
			subDic.add "pos.x" c.pos.x
			subDic.add "pos.y" c.pos.y
			dic.add (this.GetUiControlName c) subDic
		)
		
		dic
	),
	
	fn DicFromDataGrid dgv keyCellIndex:0 valueCellIndex:1 =
	(
		/*DOC_--------------------------------------------------------------------
		Generates a simple dictionary from values in the inputed DataGridView
		
		Args:
			dgv (dotNetObject)
		
		Kwargs:
			keyCellIndex (integer)
			valueCellIndex (integer)
		
		Returns:
			(dotNet HashTable)
		
		--------------------------------------------------------------------_END*/
		
		local dic = dotNetObject "System.Collections.Hashtable"
		
		for i = 0 to dgv.rows.count-1 do
		(
			if ( dgv.rows.item[i].cells.item[keyCellIndex].value != undefined ) and ( dgv.rows.item[i].cells.item[valueCellIndex].value != undefined ) then
			(
				dic.add dgv.rows.item[i].cells.item[keyCellIndex].value dgv.rows.item[i].cells.item[valueCellIndex].value
			)
		)
		
		dic
	),
	
	fn GetModule =
	(
		/*DOC_--------------------------------------------------------------------
		Get the full path to the current MaxScript file
	
		Returns:
			String
		--------------------------------------------------------------------_END*/
	
		( GetSourceFileName() )
	),
	
	fn Help _fn: =
	(
		/*DOC_--------------------------------------------------------------------
		Get help on the current module or a specific function
	
		Kwargs:
			_fn (string) : Name of the internal method as a string
	
		Returns:
			VOID
	
		--------------------------------------------------------------------_END*/
	
		::mxs.GetScriptHelp ( GetSourceFileName() ) _fn:_fn
	),
	
private
	
	fn __init__ =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.clrWindow_dnet = this.RgbToDnetColor this.clrWindow 
		this.clrText_dnet = this.RgbToDnetColor this.clrText
		this.clrBackGround_dnet = this.RgbToDnetColor this.clrBackGround
	),

	init = __init__()
)

DotNetUi = DotNetUi()