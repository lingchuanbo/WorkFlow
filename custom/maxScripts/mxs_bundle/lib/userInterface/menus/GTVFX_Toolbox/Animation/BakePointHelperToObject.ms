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
/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/21/2013
[Purpose]
Bakes out a point helper to each object in your selection.
If you have objects that are point cached or have WSM modifiers, then use the "Bake with Attachment Constraint" option.
[KEYWORDS]
Bake, Animate, Animation, Attach
__END__
******************************************/
Struct bakePoints_lib
(
	self,
	ro,
	atchPointsArr = #(),
	bakePointArr = #(),
	noAtchArr = #(),

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
	fn noAttchError =
	(
		if noAtchArr.count != 0 then
		(
			str = ""
			str += "These objects cannot accept an Atachment Constraint:\n\n"
			for i in noAtchArr do
			(
				str += (i.name+"\n")
			)
			messageBox (str as string) title:"GTVFX:"
		)
	),
	fn attachPointToObject_FN objArr face = 
	(
		noAtchArr = #()
		atchPointsArr = #()
		for i in objArr do
		(
			if superClassOf i != GeometryClass then
			(
				format "***** % is not a Geometry object *****\n***** Attachments can only be done on Geometry objects *****\n" i.name
				append noAtchArr i
				continue
			)
			atPoint = point name:(i.name + "_Attachment") centermarker:false cross:false box:true axistripod:true wireColor:(color 255 0 255)
			atPoint.position.controller = attachment()
			atPoint.position.controller.node = i
			atPoint.position.controller.align = true
			AttachCtrl.addNewKey atPoint.position.controller 1
			theKey = AttachCtrl.getKey atPoint.position.controller 1
			theKey.time = animationRange.start
			theKey.face = face
			theKey.coord = [0,1]
			append atchPointsArr atPoint
		)
		noAttchError()
		atchPointsArr
	),
	fn bakePoints_FN objArr start:(animationRange.start-5f) end:(animationRange.end+5f) step:1 =
	(
		arr = #()
		createLayerAndSetCurrent "###_BakePoint"
		maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true -- Sets the New Key value to Auto
		for i in objArr do
		(
			if isProperty i "transform" == true then
			(
				pName = (substituteString i.name "_Attachment" "")
				bakePoint = point name:(pName + "_bakePoint") size:10 centermarker:false cross:false box:true axistripod:true wirecolor:orange
				append arr bakePoint
				with animate on 
				(
					for t = start to end by step do
					(
						at time t 
						(
							bakePoint.transform = i.transform
						)
						at time end
						(
							bakePoint.transform = i.transform
						)
					)
				)
			)	
		)
		arr
	),
	fn collectBakePoints =
	(
		arr = for i in helpers where matchPattern i.name pattern:"*_bakePoint" collect i
		arr
	),
	fn ui =
	(
		rollout ro "Bake Points By GTVFX" width:250
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local btnText01 = "Bake this object..."
			local btnText02 = "...To this object"
			
			checkBox chk_atch ":Bake with Attachment Constraint" checked:false tooltip:"Check this if the object in your selection\n is PointCached or has WSM Modifiers."
			dotNetControl dNbtn_bake "Button" width:(ro.width-25) height:40
			Group "Time Range:"
			(
				spinner spn_start "S:" range:[-999999999,999999999,(((animationRange.start as float)/ticksPerFrame) as integer)] type:#integer align:#left fieldWidth:40 across:3 tooltip:"Start from this frame"
				spinner spn_end "E:" range:[-999999999,999999999,(((animationRange.end as float)/ticksPerFrame) as integer)] type:#integer align:#left fieldWidth:40 tooltip:"End at this frame"
				spinner spn_step "Nth:" range:[-999999999,999999999,1.0] type:#float align:#left fieldWidth:30 tooltip:"Values less than 1.0 will bake to ticks and have more samples per frame.\nValues greater than 1.0 will sample less."
			)
			group "Point Object Settings:"
			(
				spinner spn_size "Point Size:" range:[-999999999,999999999,20] type:#float align:#left fieldWidth:50
				checkbox chk_cm ":Center Marker" checked:False
				checkbox chk_at ":Axis Tripod" checked:True
				checkbox chk_cr ":Cross" checked:False
				checkbox chk_bc ":Box" checked:True
				colorPicker clr_pnt "Color:" color:orange fieldwidth:60 title:"GTVFX: Point Object Color"
				dotNetControl dNbtn_collect "Button" width:(ro.width-25) height:20
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
			fn dNetPickObj dNbtn =
			(
				bText = dNbtn.text
				dNbtn.text = "*** Pick object from scene ***"
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
			fn posHyperLink posX posY =
			(
				hyp_website.pos = [posX,posY]
			)
			fn togglePointSettings enabled:False =
			(
				spn_size.enabled = enabled
				chk_cm.enabled = enabled
				chk_at.enabled = enabled
				chk_cr.enabled = enabled
				chk_bc.enabled = enabled
				clr_pnt.enabled = enabled
				if enabled then
				(
					spn_size.value = self.bakePointArr[1].size
				)
			)
			fn updatePoints pointArr =
			(
				for i in pointArr do
				(
					i.size = spn_size.value
					i.centermarker = chk_cm.state
					i.axistripod = chk_at.state
					i.cross = chk_cr.state
					i.box =  chk_bc.state
				)
			)
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_bake "Bake Points to Selection" 10 style:#popup colorOffsetInt:10 tooltip:"Bake a point helper to the transform of each object in your selection"
				initDnetBtn dNbtn_collect "Collect Baked Points" 8 style:#popup colorOffsetInt:10 tooltip:"Collect any previously baked points to change their settings"
				togglePointSettings enabled:False
			)
			on dNbtn_bake Mouseclick arg do
			(
				if selection.count == 0 then return (messageBox "Nothing selected" title:"GTVFX:")
				if chk_atch.state then
				(
					self.bakePointArr = (self.bakePoints_FN (self.attachPointToObject_FN (getCurrentSelection()) 1) start:spn_start.value end:spn_end.value step:spn_step.value)
					delete self.atchPointsArr
				)
				else
				(
					self.bakePointArr = (self.bakePoints_FN (getCurrentSelection()) start:spn_start.value end:spn_end.value step:spn_step.value)
				)
				if self.bakePointArr.count != 0 then
				(
					togglePointSettings enabled:True
					select self.bakePointArr
				)
				else
				(
					togglePointSettings enabled:False
				)
			)
			on spn_size changed val do
			(
				updatePoints self.bakePointArr
			)
			on chk_cm changed state do
			(
				updatePoints self.bakePointArr
			)
			on chk_at changed state do
			(
				updatePoints self.bakePointArr
			)
			on chk_cr changed state do
			(
				updatePoints self.bakePointArr
			)
			on chk_bc changed state do
			(
				updatePoints self.bakePointArr
			)
			on clr_pnt changed newColor do
			(
				self.bakePointArr.wireColor = newColor
			)
			on dNbtn_collect Mouseclick arg do
			(
				self.bakePointArr = self.collectBakePoints()
				if self.bakePointArr.count != 0 then
				(
					togglePointSettings enabled:True
					select self.bakePointArr
				)
				else
				(
					togglePointSettings enabled:False
					messageBox "No baked points found..." title:"GTVFX:"
				)
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
bakePoints = bakePoints_lib()
