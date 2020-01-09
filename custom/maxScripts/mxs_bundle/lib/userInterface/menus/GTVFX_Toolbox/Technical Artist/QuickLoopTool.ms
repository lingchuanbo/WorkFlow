/*************************************************************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.01
Updated:				01/07/2014
[Purpose]
If you're constantly needing to loop through arrays of objects and tweak settings then this tool could offer you some convenience.
This is very simply a tool that will execute a "For i " loop with whatever code you put into the dialog. You can use the drop-down at the top to choose from a predefined array or choose "Other" from the list and then type the variable of an array you've defined yourself.
If you want to keep the loop and save it for later use you can press the slender button above the text box to write out the full code for the loop to a new script file.
__END__
*************************************************************************************/
try(destroyDialog ro_quickLoop)catch()
rollout ro_quickLoop "Quick Loop Tool By GTVFX" width:600 height:450
(
	local arrString
	local ieString = "-- Example: i.wireColor = red"
	local arrItems = #("Selection","Objects","Geometry","Lights","Cameras","Shapes","Helpers","SceneMaterials","- Other -")
	dropDownList ddl_array "Array Items: " items:arrItems width:150 across:2
	editText edt_userArr "Define Array: " visible:false width:240 pos:[170,25]
	label lbl_arrStatus "" visible:false pos:[425,25] align:#left
	label lbl_codeBox2 "This is an i loop. Use i as your loop variable. (ie, i.transform = matrix 3 1)." align:#Center width:220 height:40
	label lbl_codeBox1 "Code Field: Hold CTRL to Enter and Tab." align:#left
	button btn_newScript "Make script from code." width:575 height:15 tooltip:"Copies the code into a new script window where you can save it out."
	dotNetControl commentTxt "System.Windows.Forms.Textbox" width:(ro_quickLoop.width - 20) height:(ro_quickLoop.height - 200)
	button btn_execute "Execute" width:575 height:40 pos:[15,(ro_quickLoop.height - 70)] tooltip:"Enter Maxscript code into the text box and execute with this button.\nie,...obj.wireColor = red"
	hyperLink hyp_website "www.gtvfx.com" color:orange hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro_quickLoop.width/2-40),(ro_quickLoop.height - 23)]
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
		tbx.Font = dotNetObject "System.Drawing.Font" "MS Sans Serif" 14 ((dotNetClass "System.Drawing.FontStyle").Regular)
		tbx.BorderStyle = (dotNetClass "System.Windows.Forms.BorderStyle").FixedSingle
		tbx.MultiLine = true
		tbx.AcceptsReturn = true
		tbx.AcceptsTab = true
		tbx.WordWrap = true
		tbx.ScrollBars = (dotNetClass "System.Windows.Forms.ScrollBars").Vertical
		tbx.update()
	)
	fn executeCode objArr code =
	(
		try(execute ("for i in " + objArr + " do (" + code + ")"))catch(Format "***** Unable to execute code.\n *****")
	)
	fn _init =
	(
		initTxtBx commentTxt
		commentTxt.text = ieString
		arrString = ddl_array.selected
	)
	fn resizeUI val =
	(
		btn_execute.pos = [15,(ro_quickLoop.height - 70)]
		hyp_website.pos = [(ro_quickLoop.width/2-40),(ro_quickLoop.height - 23)]
		commentTxt.height = (val[2] - 200)
		commentTxt.width = (val[1] - 20)
	)
	on ddl_array selected item do
	(
		if ddl_array.selected == "- Other -" then edt_userArr.visible = true
		else
		(
			edt_userArr.visible = false
			lbl_arrStatus.visible = false
			arrString = ddl_array.selected
		)
	)
	on edt_userArr entered newText do
	(
		print newText
		lbl_arrStatus.visible = true
		if classOf (execute newText) == Array then lbl_arrStatus.text = "** Array Accepted **" else lbl_arrStatus.text = "** Array Undefined **"
		arrString = newText
	)
	on btn_newScript pressed do
	(
		str = newScript()
		format ("for i in " + arrString + " do\n(\n" + commentTxt.text + "\n)\n") to:str
	)
	on btn_execute pressed do
	(
		format "***** Executing Code: % *****\n" commentTxt.text
		executeCode arrString commentTxt.text
	)
	on ro_quickLoop open do
	(
		setFocus commentTxt
	)
	on ro_quickLoop resized val do resizeUI val
)
createDialog ro_quickLoop style:#(#style_titlebar, #style_sysmenu, #style_resizing)
ro_quickLoop._init()
