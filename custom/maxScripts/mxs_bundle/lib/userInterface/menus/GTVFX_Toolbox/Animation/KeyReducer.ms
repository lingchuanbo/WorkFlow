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
ScriptVersion:			v1.00
Updated:				06/18/2014
[Purpose]
Reduces the keyframes on animation controllers while maintaining overall animation.
Best when used on animation controllers that have been baked out on every frame.
***************************************************************************************************/
try(destroyDialog gtvfx_keyReducer.ro)catch()
struct keyReducerStruct
(
	self,
	ro,
	
	fn getControllers obj ctrls:#() =
	(
		for item in refs.dependsOn obj do   
		(
			if isController item and item.keyable then
			(
				append ctrls item
			)
			getControllers item ctrls:ctrls
		)
		ctrls
	),
	fn reduceKeyFrames objArr controller thresh step range:(interval animationRange.start animationRange.end) =
	(
		if objArr.count != undefined then
		(
			cui.expertModeOn()
			for i in objArr where isProperty i #isAnimated and i.isAnimated == True do
			(
				case controller of
				(
					#position:
					(
						reduceKeys i.position.controller thresh step range
					)
					#rotation:
					(
						reduceKeys i.roation.controller thresh step range
					)
					#scale:
					(
						reduceKeys i.scale.controller thresh step range
					)
					#all:
					(
						cArr = getControllers i
						for c in cArr do
						(
							reduceKeys c thresh step range
						)
					)
				)
			)
			cui.expertModeOff() 
		)
		else
		(
			messageBox "\"objArr\" Expected an array of objects..." title:"GTVFX:"
		)
	),
	fn ui =
	(
		rollout ro "Key Reducer by GTVFX" width:300
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			group "Options:"
			(
				dropDownList ddl_arr "Operate on:" width:120 items:#("selection","geometry","objects","shapes","helpers","cameras","lights","spacewarps","systems") across:2 tooltip:"This is the Object Set that the tool will run on"
				dropDownList ddl_con "Controller:" width:120 items:#(#position,#rotation,#scale,#all) tooltip:"This is the controller that the tool will run on\n\"all\" will reduce keys on all animated tracks not just \"position\",\"rotation\",\"scale\""
			)
			group "Settings:"
			(
				spinner spn_thresh "Threshold:" range:[0,99,0.1] type:#float align:#left across:2 tooltip:"This is the accuracy of the reduction\nSmaller numbers are more accurate keeping the result closer to the original animation"
				spinner spn_step "Step:" range:[0,99,1] type:#float align:#right tooltip:"The tool will sample at every \"Step\" frame\nA value of 1 will sample every frame, 0.5 every half frame, 5.0 every 5th frame"
			)
			group "Optional:"
			(
				checkBox chk_range "Use Custom Range:" tooltip:"You can set a custom range to reduce keys rather than the entire frame range"
				spinner spn_start "Start:" range:[-9999,9999,(animationRange.start)] type:#integer align:#left across:2 enabled:False
				spinner spn_end "End:" range:[-9999,9999,(animationRange.end)] type:#integer align:#right enabled:False
			)
			dotNetControl dNbtn_reduce "button" width:(ro.width-25) height:40
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
			fn posHyperLink posX posY =
			(
				hyp_website.pos = [posX,posY]
			)
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_reduce "Reduce Keys" 11 style:#popup colorOffsetInt:10 tooltip:"Run keyreducer on the selected controller with the input settings."
			)
			on chk_range changed state do
			(
				spn_start.enabled = state
				spn_end.enabled = state
				if not state then
				(
					spn_start.value = animationRange.start
					spn_end.value = animationRange.end
				)
			)
			on dNbtn_reduce mouseClick do
			(
				self.reduceKeyFrames (execute ddl_arr.selected) ddl_con.selected spn_thresh.value spn_step.value
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
gtvfx_keyReducer = keyReducerStruct()