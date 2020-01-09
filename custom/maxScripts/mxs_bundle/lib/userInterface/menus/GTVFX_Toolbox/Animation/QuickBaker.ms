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
ScriptVersion:			v2.0
Updated:				07/07/2014
[Purpose]
Bakes the transform of one object to another. There is an option to auto-generate a point helper to bake.
THere are options for baking within a specific time range and only baking Nth frames.
[KEYWORDS]
Bake, Animate, Animation, Attach
__END__
******************************************/
try(destroyDialog _qBaker.ro)catch()
Struct quickBakerLib
(
	self,
	ro,
	atchPointsArr = #(),
	staticObj,
	toObj,

	fn bakeIt obj1 obj2 prg start:(animationRange.start-5f) end:(animationRange.end+5f) step:1 =
	(
		pgInt = (100.0/(end - start))
		maxOps.setDefaultTangentType #flat #flat writeInCfgFile:true -- Sets the New Key value to Auto
		if (isProperty obj1 #transform) and (isProperty obj2 #transform) then
		(
			with animate on 
			(
				for t = start to end by step do
				(
					at time t 
					(
						obj1.transform = obj2.transform
					)
					prg.value = (pgInt*(t-start))
				)
				at time end
				(
					obj1.transform = obj2.transform
				)
			)
		)
		else
		(
			messageBox "Object is not tranformable..." title:"GTVFX:"
		)
	),
	fn ui =
	(
		rollout ro "Quick Baker By GTVFX" width:300
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local btnText01 = "Bake this object..."
			local btnText02 = "...To this object"
			
			Group "What to bake:"
			(
				checkBox chk_autoPoint ":Auto generate point helper"
				dotNetControl dNbtn_this "Button" width:(ro.width-25) height:25
				dotNetControl dNbtn_toThis "Button" width:(ro.width-25) height:25
			)
			Group "Time Range:"
			(
				spinner spn_start "Start:" range:[-999999999,999999999,(((animationRange.start as float)/ticksPerFrame) as integer)] type:#integer align:#left fieldWidth:40 across:3 tooltip:"Start baking at this frame"
				spinner spn_end "End:" range:[-999999999,999999999,(((animationRange.end as float)/ticksPerFrame) as integer)] type:#integer align:#left fieldWidth:40 tooltip:"Stop baking at this frame"
				spinner spn_step "Nth:" range:[-999999999,999999999,1.0] type:#float align:#left fieldWidth:30 tooltip:"Skip frames"
			)
			dotNetControl dNbtn_bake "Button" width:(ro.width-25) height:40
			progressBar prg_status color:orange
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
			fn checkReady =
			(
				if self.staticObj == undefined then return False
				if self.toObj == undefined then return False
				True
			)
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_this btnText01 10 style:#popup colorOffsetInt:10 tooltip:"Pick object to bake"
				initDnetBtn dNbtn_toThis btnText02 10 style:#popup colorOffsetInt:10 tooltip:"Pick source object to bake from"
				initDnetBtn dNbtn_bake "Bake It" 11 style:#popup colorOffsetInt:10 tooltip:""
				dNbtn_bake.enabled = False
			)
			on chk_autoPoint changed state do
			(
				if state then
				(
					bakePoint = point name:"Point Helper" size:10 centermarker:false cross:false box:true axistripod:true wirecolor:orange
					self.staticObj = bakePoint
					dNbtn_this.text = "Point Helper"
					dNbtn_this.enabled = False
				)
				else
				(
					try(delete $'Point Helper')catch()
					self.staticObj = undefined
					dNbtn_this.text = btnText01
					dNbtn_this.enabled = True
				)
				dNbtn_bake.enabled = checkReady()
			)
			on dNbtn_this mouseClick do
			(
				self.staticObj = (dNetPickObj dNbtn_this)
				dNbtn_bake.enabled = checkReady()
			)
			on dNbtn_toThis mouseClick do
			(
				self.toObj = (dNetPickObj dNbtn_toThis)
				dNbtn_bake.enabled = checkReady()
			)
			on dNbtn_bake mouseClick do
			(
				self.bakeIt self.staticObj self.toObj prg_status start:spn_start.value end:spn_end.value step:spn_step.value
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
_qBaker = quickBakerLib()
