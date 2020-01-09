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
Updated:				06/17/2014
[Purpose]
Selects objects that have the chosen modifier in their stack
***************************************************************************************************/
try(destroyDialog gtvfx_selByMod.ro)catch()
struct selByModifierClass
(
	self,
	ro,
	
	fn collectModifierItems sceneFilter:False =
	(
		arr = #()
		ro.prg_items.value = 0
		ro.prg_items.color = orange
		inc = (100.0/modifier.classes.count)
		incu = inc
		for i in modifier.classes do
		(
			if sceneFilter then
			(
				if (getClassInstances i).count != 0 then append arr (i as string)
			)
			else
			(
				append arr (i as string)
			)
			incu += inc
			ro.prg_items.value = incu
		)
		ro.prg_items.value = 100
		ro.prg_items.color = blue
		if arr.count == 0 then
		(
			#("<none>")
		)
		else
		(
			sort arr
		)
	),
	fn selectByModifierClass modClass =
	(
		if classOf modClass != modifier then
		(
			messageBox "modClass argument expected a modifier class" title:"GTVFX:"
			return False
		)
		arr = #()
		for obj in objects do
		(
			for i in obj.modifiers where classOf i == modClass do append arr obj
		)
		format "***** Selecting % Objects: % *****\n" arr.count arr
		if arr.count != 0 then
		(
			select arr
		)
		else
		(
			messageBox "There are no objects with that modifier... :(" title:"GTVFX:"
		)
	),
	fn ui =
	(
		rollout ro "Select Objects by Modifier by GTVFX" width:300
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			
			dropDownList ddl_mods "Modifier:"
			dotNetControl dNbtn_filter "button" width:(ro.width-25) height:20
			progressBar prg_items "" height:10
			dotNetControl dNbtn_select "button" width:(ro.width-25) height:40
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com"
			
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
			fn normalizeRGB val =
			(
				if val <0 then val = 0 else if val >255 then val = 255
				val
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
			fn _init pself =
			(
				self = pself
				initDnetBtn dNbtn_filter "Filter list by scene modifiers" 9 style:#flat tooltip:"Filter modifier list by modifiers in scene"
				initDnetBtn dNbtn_select "Select Objects" 12 style:#popup colorOffsetInt:10 tooltip:"Select objects with chosen modifier"
				ddl_mods.items = self.collectModifierItems sceneFilter:False
			)
			on dNbtn_filter mouseClick do
			(
				ddl_mods.items = self.collectModifierItems sceneFilter:True
			)
			on dNbtn_select mouseClick do
			(
				self.selectByModifierClass (execute ddl_mods.selected)
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
gtvfx_selByMod = selByModifierClass()

