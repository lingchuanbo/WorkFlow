/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.4
Updated:				09/25/2014
[Purpose]
This is a library of callbacks for my personal use.
******************************************/
struct GTVFX_callbackLib
(
	self,
	ro,
	GTVFX_callbackIdArr = #(#GTVFX_CloseDialogs,#GTVFX_ToggleVpShading,#GTVFX_ForceNitrousShaded,#GTVFX_DeleteCallbacks),
	cb_ini = ((getDir #plugCFG)+@"\GTVFX_callbackLib.ini"),
	ini_CloseDialogs = false,
	ini_ToggleVpShading = false,
	ini_ForceNitrousShaded = false,
	
	fn ui =
	(
		try(destroyDialog gtCallBacks.ro)catch()
		rollout ro "GTVFX: Callback Custimization"
		(
			local self
			local dnTooltip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local uiArr
			
			dotNetControl dgv_callBacks "DataGridView" height:300
			dotNetControl dNbtn_apply "Button" height:40
			
			fn WriteIniSettings dgv iniFile =
			(
				if doesFileExist iniFile then deleteFile iniFile
				for i in 0 to dgv.rows.count-1 do
				(
					iRow = dgv.rows.item[i]
					setIniSetting iniFile iRow.cells.item[1].value "Enabled" (iRow.cells.item[0].value as string)
				)
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
				dNobj.backColor = dNobj.backcolor.FromArgb (ClrBackGround.x+colorOffsetInt) (ClrBackGround.y+colorOffsetInt) (ClrBackGround.z+colorOffsetInt)
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
			)
			fn setDataGridColor dNObj fontSize =
			(
				dNObj.forecolor = dNObj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNObj.BackgroundColor = dNObj.BackgroundColor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.DefaultCellStyle.BackColor = dNObj.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				dNObj.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
			)
			fn drawData dgv arr =
			(
				dgv.rows.clear()
				for a in arr do
				(
					tempRow = dotNetObject "System.Windows.Forms.DataGridViewRow"
					dgv.rows.add tempRow
					tempRow.SetValues #(false, (a as string))
				)
				dgv.AutoResizeColumns()
				dgv.columns.item[0].autoSizeMode = dgv.columns.item[0].autoSizeMode.DisplayedCells
				dgv.columns.item[1].autoSizeMode = dgv.columns.item[1].autoSizeMode.fill
				for i in 0 to dgv.rows.count-1 do
				(
					iRow = dgv.rows.item[i]
					iName = iRow.cells.item[1].value
					case iName of
					(
						"GTVFX_CloseDialogs":
						(
							iRow.cells.item[1].toolTipText = "#filePreOpen\nCloses the Material Editor and the Render Dialog"
							iRow.cells.item[0].value = self.ini_closeDialogs
						)
						"GTVFX_ToggleVpShading":
						(
							iRow.cells.item[1].toolTipText = "#filePostOpen\nDisables Hardware shading in Direct3D viewports"
							iRow.cells.item[0].value = self.ini_toggleVpShading
						)
						"GTVFX_ForceNitrousShaded":
						(
							iRow.cells.item[1].toolTipText = "#filePostOpen\nDisables Realistic mode in all Nitrous viewports"
							iRow.cells.item[0].value = self.ini_ForceNitrousShaded
						)
						default:
						(
							iRow.cells.item[1].toolTipText = "No tooltip text set... :("
						)
					)
				)
			)
			fn initDgv dgv fontsize tooltip:"" =
			(
				dgv.AllowDrop  = true
				dgv.MultiSelect = true
				dgv.AllowUserToAddRows = off
				dgv.AutoSize = off
				dgv.AutoSizeColumnsMode = dgv.AutoSizeColumnsMode.Fill
				dgv.ShowEditingIcon = dgv.RowHeadersVisible = off
				dnSelectionMode = dotNetClass "System.Windows.Forms.DataGridViewSelectionMode"
				dgv.SelectionMode = dnSelectionMode.FullRowSelect 
				dgv.AllowUserToResizeRows = false
				dgv.AllowUserToOrderColumns = false
				dgv.AllowUserToResizeColumns = false
				dgv.ColumnHeadersHeightSizeMode = dgv.ColumnHeadersHeightSizeMode.DisableResizing
				colAr = #()
				append colAr #(#bool,"on",false,#Center)
				append colAr #(#text,"Callback",True,#left)
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
			fn _init pself =
			(
				self = pself
				initDgv dgv_callBacks 11 tooltip:""
				initDnetBtn dNbtn_apply "Apply" 11 style:#popup colorOffsetInt:15 tooltip:"Apply settings to callback library"
				uiArr = #()
				uiArr += self.GTVFX_callbackIdArr
				deleteItem uiArr (findItem uiArr #GTVFX_deleteCallbacks)
				drawData dgv_callBacks uiArr
			)
			on dNbtn_apply mouseClick do
			(
				dgv_callBacks.EndEdit()
				WriteIniSettings dgv_callBacks self.cb_ini
				destroyDialog ro
				self._init()
			)
		)
		createDialog ro width:300
		ro._init self
	),
	fn getIniSettings =
	(
		if doesFileExist cb_ini then
		(
			
			if hasIniSetting cb_ini "GTVFX_closeDialogs" then ini_closeDialogs = execute(getIniSetting cb_ini "GTVFX_closeDialogs" "Enabled")
			if hasIniSetting cb_ini "GTVFX_toggleVpShading" then ini_toggleVpShading = execute(getIniSetting cb_ini "GTVFX_toggleVpShading" "Enabled")
			if hasIniSetting cb_ini "GTVFX_ForceNitrousShaded" then ini_ForceNitrousShaded = execute(getIniSetting cb_ini "GTVFX_ForceNitrousShaded" "Enabled")
		)
		else
		(
			format "***** no ini file *****\n"
		)
	),
	fn CloseDialogs =
	(
		/* 
		#filePreOpen
		Closes the Material Editor, Layer Dialog, and Render Dialog
		When opening files, if these are left open they can greatly add to the time it takes to open a file.
		 */
		MatEditor.Close() 
		layerManager.CloseDialog()
		renderSceneDialog.close()
	),
	fn ToggleVpShading state:false =
	(
		/* 
		#filePostOpen
		This will toggle the Hardware shading option for viewports.
		By default this disables Hardware shading.
		 */
		if (getINISetting (getMAXIniFile()) "WindowState" "GFXType") != "Direct3D" then return False
		index = viewport.activeViewport
		for i = 1 to viewport.numviews do
		(
			viewport.activeViewport = i
			vss = maxops.getViewportShadingSettings()
			vss.ActivateViewportShading = state
		)
		viewport.activeViewport = index
		format "***** GTVFX: Viewport Shading = % *****\n" state
	),
	fn ForceNitrousShaded = 
	(
		/* 
		#filePostOpen
		This disables Realistic mode in nitrous viewports
		*/
		if (getINISetting (getMAXIniFile()) "WindowState" "GFXType") != "Nitrous" then return False
		if nitrousgraphicsmanager.isEnabled() then
		(
			index = viewport.activeViewport
			for i = 1 to viewport.numviews do
			(
				viewport.activeViewport = i
				impl = NitrousGraphicsManager.GetActiveViewportSetting()
				if impl != undefined and impl.VisualStyleMode == #Realistic then impl.VisualStyleMode = #shaded
			)
			viewport.activeViewport = index
		)
	),
	fn DeleteCallbacks =
	(
		/* 
		#preSystemShutdown
		Removes all callbacks added by this library
		Callback IDs must be added to the GTVFX_callbackIdArr array
		 */
		for i in GTVFX_callbackIdArr do callbacks.removeScripts id:i
	),
	fn createCallbacks =
	(
		if ini_closeDialogs then callbacks.addScript #filePreOpen "gtCallBacks.CloseDialogs()" id:#GTVFX_CloseDialogs
		if ini_toggleVpShading then callbacks.addScript #filePostOpen "gtCallBacks.ToggleVpShading()" id:#GTVFX_ToggleVpShading
		if ini_ForceNitrousShaded then callbacks.addScript #filePostOpen "gtCallBacks.ForceNitrousShaded()" id:#GTVFX_ForceNitrousShaded
		callbacks.addScript #preSystemShutdown "gtCallBacks.DeleteCallbacks()" id:#GTVFX_deleteCallbacks
	),
	fn _init =
	(
		self = this
		deleteCallbacks()
		getIniSettings()
		createCallbacks()
		format "***** GTVFX Callbacks Lib Initialized *****\n"
	),
	init = _init()
)
::gtCallBacks = GTVFX_callbackLib()