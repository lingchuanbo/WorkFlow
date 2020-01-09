try(destroyDialog _phm.ro)catch()
struct pointHelperManipulator
(
	self,
	ro,
	
	fn ui =
	(
		rollout ro "Point Helper UI by GTVFX" width:200
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			
			group "Point Helper UI:"
			(
				dotNetControl dNbtn_get "Button" width:(ro.width-25) height:25
				spinner spn_size "Point Size:" range:[-999999999,999999999,20] type:#float align:#left fieldWidth:50
				checkbox chk_cm ":Center Marker" checked:False
				checkbox chk_at ":Axis Tripod" checked:True
				checkbox chk_cr ":Cross" checked:False
				checkbox chk_bc ":Box" checked:True
				colorPicker clr_pnt "Color:" color:orange fieldwidth:60 title:"GTVFX: Point Object Color" across:2
				checkBox chk_disable ":Disable" offset:[13,3]
				checkBox chk_screenSize ":Constant Screen Size" checked:False
				checkBox chk_drawOnTop ":Draw On Top" checked:False
				dotNetControl dNbtn_apply "Button" width:(ro.width-25) height:25
			)
			
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
			fn posHyperLink posX posY =
			(
				hyp_website.pos = [posX,posY]
			)
			fn getPointArr =
			(
				arr = for i in selection where classOf i == point collect i
				arr
			)
			fn updateUI =
			(
				pointArr = getPointArr()
				if pointArr.count != 0 then
				(
					spn_size.value = pointArr[1].size
					chk_cm.state = pointArr[1].centermarker
					chk_at.state = pointArr[1].axistripod
					chk_cr.state = pointArr[1].cross
					chk_bc.state = pointArr[1].box
					clr_pnt.color = pointArr[1].wireColor
					chk_screenSize.state = pointArr[1].constantscreensize
					chk_drawOnTop.state = pointArr[1].drawontop
				)
			)
			fn updatePoints =
			(
				pointArr = getPointArr()
				for i in pointArr do
				(
					i.size = spn_size.value
					i.centermarker = chk_cm.state
					i.axistripod = chk_at.state
					i.cross = chk_cr.state
					i.box = chk_bc.state
					if not chk_disable.state then i.wireColor = clr_pnt.color
					i.constantscreensize = chk_screenSize.state
					i.drawontop = chk_drawOnTop.state
				)
			)
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_apply "Apply Settings" 10 style:#popup colorOffsetInt:10 tooltip:"Apply current settings to selected point helpers"
				initDnetBtn dNbtn_get "Get Settings" 10 style:#popup colorOffsetInt:10 tooltip:"Get the settings from the first point helper in your selection"
				updateUI()
			)
			on dNbtn_get mouseClick arg do
			(
				updateUI()
			)
			on spn_size changed val do
			(
				updatePoints()
			)
			on chk_cm changed state do
			(
				updatePoints()
			)
			on chk_at changed state do
			(
				updatePoints()
			)
			on chk_cr changed state do
			(
				updatePoints()
			)
			on chk_bc changed state do
			(
				updatePoints()
			)
			on clr_pnt changed newColor do
			(
				updatePoints()
			)
			on chk_disable changed state do
			(
				clr_pnt.enabled = not state
			)
			on chk_screenSize changed state do
			(
				updatePoints()
			)
			on chk_drawontop changed state do
			(
				updatePoints()
			)
			on dNbtn_apply mouseClick arg do
			(
				updatePoints()
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
_phm = pointHelperManipulator()