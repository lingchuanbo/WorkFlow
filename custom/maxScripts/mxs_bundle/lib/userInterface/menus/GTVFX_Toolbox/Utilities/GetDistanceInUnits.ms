try(destroyDialog _getDist.ro)catch()
struct getDistance
(
	self,
	ro,
	distStr,
	objA,
	objB,
	
	fn getDistanceInUnits obj1 obj2 =
	(
		if obj1 != undefined and obj2 != undefined then
		(
			unitExt = case units.SystemType of
			(
				#Inches:"\""
				#Feet:"'"
				#Miles:"Miles"
				#Millimeters:"mm"
				#Centimeters:"cm"
				#Meters:"m"
				#Kilometers:"km"
			)
			d = distance obj1 obj2
			str = stringStream ""
			format "%%" d unitExt to:str
			setClipBoardText str
			str as string
		)
		else messageBox "One of your objects returned Undefined.\nDouble Check your settings and try again." title:"GTVFX: Error"
	),
	fn ui =
	(
		rollout ro "Get Distance by GTVFX" width:200
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local btnA = "Object A"
			local btnB = "Object B"
			
			Group "Object Selection:"
			(
				checkBox chk_vCam ":Use Viewport Camera" tooltip:"Get the camera from the active viewport"
				dotNetControl dNbtn_objA "Button" width:(ro.width-25) height:25
				dotNetControl dNbtn_objB "Button" width:(ro.width-25) height:25
			)
			dotNetControl dNtxt_text "Textbox" height:60 
			dotNetControl dNbtn_get "Button" width:(ro.width-25) height:30
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
				dNobj.update()
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
				dNbtn.update()
			)
			fn initTxtBx tbx caption fontSize tooltip:"" multiLine:False =
			(
				tbx.backcolor = tbx.backcolor.FromArgb clrWindow.x clrWindow.y clrWindow.z
				tbx.forecolor = tbx.forecolor.FromArgb clrText.x clrText.y clrText.z
				tbx.text = caption
				tbx.Font = dotNetObject "System.Drawing.Font" "Calibri" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
				tbx.BorderStyle = (dotNetClass "System.Windows.Forms.BorderStyle").FixedSingle
				tbx.MultiLine = multiLine
				tbx.AcceptsReturn = False
				tbx.AcceptsTab = False
				tbx.WordWrap = False
				tbx.ReadOnly = True
				initToolTip tbx tooltip
				tbx.update()
			)
			fn dNetPickObj dNbtn =
			(
				bText = dNbtn.text
				dNbtn.text = "*** Pick object ***"
				obj = pickObject()
				if obj != undefined then
				(
					dNbtn.text = obj.name
				)
				else
				(
					dNbtn.text = bText
				)
				obj
			)
			fn getViewportCam =
			(
				if (viewport.getType()) == #view_camera then
				(
					cam = getActiveCamera()
				)
				else 
				(
					cam = undefined
					messageBox "Your current viewport is not a camera" title:"GTVFX:"
				)
				cam
			)
			fn checkReady =
			(
				if self.objA == undefined then return False
				if self.objB == undefined then return False
				True
			)
			fn posHyperLink posX posY =
			(
				hyp_website.pos = [posX,posY]
			)
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_objA btnA 9 style:#popup colorOffsetInt:10 tooltip:"Select the first object"
				initDnetBtn dNbtn_objB btnB 9 style:#popup colorOffsetInt:10 tooltip:"Select the second object"
				initTxtBx dNtxt_text "" 12 tooltip:"" multiLine:True
				initDnetBtn dNbtn_get "Get Distance" 10 style:#popup colorOffsetInt:10 tooltip:"Calculate the distance between the two objects.\nReturns a value in system units."
				dNbtn_get.enabled = False
			)
			on chk_vCam changed state do
			(
				if state then
				(
					self.objA = getViewportCam()
					if self.objA != undefined then
					(
						dNbtn_objA.text = self.objA.name
					)
					else
					(
						chk_vCam.state = False
						dNbtn_objA.text = btnA
					)
					dNbtn_get.enabled = checkReady()
				)
				else
				(
					self.objA = undefined
					dNbtn_objA.text = btnA
					dNbtn_get.enabled = checkReady()
				)
			)
			on dNbtn_objA mouseClick arg do
			(
				self.objA = dNetPickObj dNbtn_objA
				dNbtn_get.enabled = checkReady()
			)
			on dNbtn_objB mouseClick arg do
			(
				self.objB = dNetPickObj dNbtn_objB
				dNbtn_get.enabled = checkReady()
			)
			on dNbtn_get mouseClick arg do
			(
				dist = self.getDistanceInUnits self.objA self.objB
				dNtxt_text.text = dist
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
_getDist = getDistance()
