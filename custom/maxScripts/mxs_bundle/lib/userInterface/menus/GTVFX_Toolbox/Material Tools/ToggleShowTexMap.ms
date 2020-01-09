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
Updated:				10/02/2014
[Purpose]
Toggles the viewport display of texture maps
***************************************************************************************************/
try(destroyDialog _showTexMaps.ro)catch()
struct showTexMapsLib
(
	self,
	ro,
	
	fn collectMaterials =
	(
		arr
		if selection.count != 0 then
		(
			arr = for i in selection where i.material != undefined collect i.material
		)
		else
		(
			arr = sceneMaterials
		)
		arr
	),
	fn ToggleTexShowTexMap mat map state:False =
	(
		numSubTexmaps = (getNumSubTexmaps map)
		if numSubTexmaps != 0 then
		(
			for i = 1 to numSubTexmaps do
			(
				tMap = (getSubTexmap map i)
				if tMap != undefined then
				(
					ToggleTexShowTexMap mat tMap state:False
				)
			)
		)
		showTextureMap mat map state
	),
	fn ToggleMatShowTexMap mat state:True =
	(
		if mat == undefined then return False
		if SuperClassOf mat != Material then return False
		--format "***** Material: % *****\n" mat.name
		numSubMats = (getNumSubMtls mat)
		if numSubMats != 0 then
		(
			for i = 1 to numSubMats do
			(
				ToggleMatShowTexMap (getSubMtl mat i) state:state
			)
		)
		if not state then
		(
			numSubTexmaps = (getNumSubTexmaps mat)
			if numSubTexmaps != 0 then
			(
				for i = 1 to numSubTexmaps do
				(
					tMap = (getSubTexmap mat i)
					if tMap != undefined then
					(
						ToggleTexShowTexMap mat tMap state:False
					)
				)
			)
		)
		showTextureMap mat state
	),
	fn ui =
	(
		rollout ro "Toggle Texture Map Display By GTVFX" width:300
		(
			local self
			local dnToolTip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			local tHeight = 12
			
			dotNetControl dNbtn_on "button" width:(ro.width-25) height:40
			dotNetControl dNbtn_off "button" width:(ro.width-25) height:40
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
				dnToolTip
			)
			fn destroyToolTip =
			(
				dnToolTip
				if dnToolTip != undefined then
				(
					dnToolTip.RemoveAll()
					dnToolTip.Dispose()
					dnToolTip = undefined
				)
				True
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
				initDnetBtn dNbtn_on "Show Texture Maps" tHeight style:#popup colorOffsetInt:10 tooltip:"Sets every material in the scene to display the texture map in viewport"
				initDnetBtn dNbtn_off "Disable Texture Maps" tHeight style:#popup colorOffsetInt:10 tooltip:"Sets every material and every map to not display in the viewport"
			)
			on dNbtn_on mouseClick arg do
			(
				for i in (self.collectMaterials()) do self.ToggleMatShowTexMap i state:True
			)
			on dNbtn_on MouseEnter arg do
			(
				initToolTip dNbtn_on dNbtn_on.tag
			)
			on dNbtn_on MouseLeave arg do
			(
				destroyToolTip()
			)
			on dNbtn_off mouseClick arg do
			(
				for i in (self.collectMaterials()) do self.ToggleMatShowTexMap i state:False
			)
			on dNbtn_off MouseEnter arg do
			(
				initToolTip dNbtn_off dNbtn_off.tag
			)
			on dNbtn_off MouseLeave arg do
			(
				destroyToolTip()
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
_showTexMaps = showTexMapsLib()

