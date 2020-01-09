/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.01
Updated:				01/07/2014
[Purpose]
This tool will list the properties of any object you select. 
The title of the dialog will change to the Class Of the selected object and the Name of the selected object.
You can press the "Freeze Property List" button to prevent the dialog from updating with each new selection.
You can copy the text from the dialog, so this is usefull if you're writing a script and need to find which property you want to control.
If you need to list the properties of something that you can't select (Like a material...) you can use the section at the bottom of the dialog.
Check the "Object from Script" box and then enter the Maxscript line for what you want to see the properties for. (fe: VRayMTL(), meditMaterials[1], etc...)
******************************************/
try(destroyDialog ro_propLister)catch()
rollout ro_propLister "Property Lister By GTVFX" width:340 height:680
(
	local titleTxt = ""
	dotNetControl commentTxt "System.Windows.Forms.Textbox" height:(ro_propLister.height - 180)
	checkBox chk_vray "Vray/User Properties" pos:[10,(ro_propLister.height - 160)]
	checkbutton cbtn_freeze "Freeze Property List" width:280 height:40 pos:[10,(ro_propLister.height - 135)]
	checkBox chk_useCustObj "Object From Script:" pos:[10,(ro_propLister.height - 85)]
	editText edt_customObj "" pos:[10,(ro_propLister.height - 60)] enabled:false
	hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro_propLister.width/2-40),(ro_propLister.height - 23)]
	fn setDotNetWidgetColor dNObj =
	(
		ClrBackGround = ((colorMan.getColor #window)*255)	
		ClrForeGround = ((colorMan.getColor #text)*255)
		dNObj.backcolor = dNObj.backcolor.FromArgb ClrBackGround.x ClrBackGround.y ClrBackGround.z
		dNObj.forecolor = dNObj.forecolor.FromArgb ClrForeGround.x ClrForeGround.y ClrForeGround.z
	)
	fn initTxtBx tbx =
	(
		setDotNetWidgetColor tbx
		tbx.Font = dotNetObject "System.Drawing.Font" "MS Sans Serif" 12 ((dotNetClass "System.Drawing.FontStyle").Regular)
		tbx.BorderStyle = (dotNetClass "System.Windows.Forms.BorderStyle").FixedSingle
		tbx.MultiLine = true
		tbx.AcceptsReturn = true
		tbx.AcceptsTab = true
		tbx.WordWrap = true
		tbx.ScrollBars = (dotNetClass "System.Windows.Forms.ScrollBars").Vertical
		tbx.readOnly = true
		tbx.update()
	)
	fn resizeUI val =
	(
		commentTxt.height = (val[2] - 180)
		commentTxt.width = (val[1] - 20)
		chk_vray.pos = [10,(val[2] - 160)]
		cbtn_freeze.pos = [10,(val[2] - 135)]
		chk_useCustObj.pos = [10,(ro_propLister.height - 85)]
		edt_customObj.pos = [10,(ro_propLister.height - 60)]
		hyp_website.pos = [(ro_propLister.width/2-40),(ro_propLister.height - 23)]
	)
	fn formatProperties obj vrayPrps:false=
	(
		prpStr = stringStream ""
		if not vrayPrps then 
		(
			propArr = getPropNames obj 
			if propArr.count != 0 then
			(
				for i in propArr do
				(
					format (".%\r\n") (i as string) to:prpStr
				)
			)
			else prpStr = "No Properties to display... :("
		)
		else
		(
			prpStr = getUserPropBuffer obj 
			if prpStr as string == "" then prpStr = "No VRay or User properties have been generated... :("
		)
		prpStr as string
	)
	fn autoRefresh =
	(
		obj = selection[1]
		if obj != undefined then
		(
			commentTxt.text = formatProperties obj vrayPrps:chk_vray.state
			ro_propLister.title = ((classOf obj as string)+" | "+obj.name)
		)
		else
		(
			ro_propLister.title = commentTxt.text = "Nothing Selected... :("
		)
	)
	fn setCB =
	(
		callbacks.addScript #selectionSetChanged "ro_propLister.autoRefresh()" id:#GTVFX_prop
	)
	fn delCB =
	(
		callbacks.removeScripts id:#GTVFX_prop
	)
	fn _init =
	(
		setCB()
		initTxtBx commentTxt
		if selection.count != 0 then
		(
			commentTxt.text = formatProperties selection[1]
			ro_propLister.title = ((classOf selection[1] as string)+" | "+selection[1].name)
		)
	)
	on chk_useCustObj changed state do
	(
		edt_customObj.enabled = state
		cbtn_freeze.state = state
		if state then delCB() else setCB()
	)
	on edt_customObj entered newText do
	(
		try (obj = execute newText)catch
		(
			obj = undefined
			format "***** % is not a valid MaxScript Object *****\n" newText
		)
		if obj != undefined then
		(
			commentTxt.text = formatProperties obj vrayPrps:chk_vray.state
			ro_propLister.title = ((classOf obj as string)+" | "+newText)
		)
		else
		(
			format "***** % is undefined *****\n" newText
		)
	)
	on chk_vray changed state do autoRefresh()
	on cbtn_freeze changed state do
	(
		if state then
		(
			delCB()
			commentTxt.text = formatProperties selection[1] vrayPrps:chk_vray.state
			ro_propLister.title = ((classOf selection[1] as string)+" | "+selection[1].name)
		)
		else
		(
			setCB()
			autoRefresh()
			chk_useCustObj.state = false
			edt_customObj.enabled = false
		)
	)
	on ro_propLister resized val do resizeUI val
	on ro_propLister close do delCB()
	on ro_propLister help do
	(
		print "GTVFX: Help"
	)
)
createDialog ro_propLister style:#(#style_titlebar, #style_sysmenu, #style_resizing)
ro_propLister._init()
