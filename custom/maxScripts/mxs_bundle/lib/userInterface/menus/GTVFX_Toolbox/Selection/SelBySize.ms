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
Updated:				02/25/2014
[Purpose]
Selects objects with the same bounding box volume.
Optionally you can set a tolerance for selection to collect objects similar in size.
***************************************************************************************************/
try(destroyDialog selBySize.ro)catch()
struct selectBySize_Lib
(
	self,
	ro,
	
	fn calcBboxVolume obj =
	(
		vMin = obj.min
		vMax = obj.max
		fX = vMax.x - vMin.x
		fY = vMax.y - vMin.y
		fZ = vMax.z - vMin.z
		out = (fX*fY*fZ)
		out
	),
	fn selectByBboxVolume obj:$ tolerance:1.0 arr:#() =
	(
		if obj == $ and selection.count != 1 then
		(
			messageBox "Select only one object."
		)
		else
		(
			baseVol = execute ((abs (calcBboxVolume obj)) as string)
			highVol = baseVol*tolerance
			lowVol =  baseVol/tolerance
			for i in objects do
			(
				iVol = execute ((abs (calcBboxVolume i)) as string)
				if iVol <= highVol and iVol >= lowVol then append arr i
			)
			select arr
		)
	),
	fn ui =
	(
		try(destroyDialog self.ro)catch()
		rollout ro "Select By Size By Gavyn Thompson" width:270 --height:115
		(
			local self
			local objSel
			
			group "Base Object:"
			(
				pickButton pck_objSel "Select Comparison Obj" width:(ro.width-20) height:30 offset:[0,5] message:"Select object" autoDisplay:true tooltip:"Select a base object to set the comparison size"
			)
			group "Settings:"
			(
				spinner spn_tol "Tolerance:" type:#float range:[1.0,999999999.0,1.0] fieldWidth:50 across:2 tooltip:"A value of size deviation between selected objects\n1.0 represents exact same size" enabled:false
				checkBox chk_realTime "Real-time:" offset:[30,0] tooltip:"If checked then object selection will automatically update when the tolerance value is changed." enabled:false
				button btn_sel "Select" width:(ro.width-30) height:25 enabled:false
			)
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" offset:[(ro.width/2-50),0]--pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on pck_objSel picked obj do
			(
				objSel = obj
				spn_tol.enabled = true
				chk_realTime.enabled = true
				btn_sel.enabled = true
			)
			on spn_tol changed newVal do
			(
				if chk_realTime.state then
				(
					if objSel == undefined then
					(
						if selection.count == 1 then
						(
							objSel = selection[1]
							self.selectByBboxVolume obj:objSel tolerance:newVal
						)
						else
						(
							messageBox "Select only one object to base the comparison on." title:"GTVFX:"
						)
					)
					else
					(
						self.selectByBboxVolume obj:objSel tolerance:newVal
					)
				)
			)
			on chk_realTime changed state do
			(
				btn_sel.enabled = not state
			)
			on btn_sel pressed do
			(
				if objSel == undefined and selection.count == 1 then
				(
					self.selectByBboxVolume tolerance:spn_tol.value
				)
				else if objSel != undefined then
				(
					self.selectByBboxVolume obj:objSel tolerance:spn_tol.value
				)
				else messageBox "Select only one object or define a comparison object to continue" title:"GTVFX:"
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
selBySize = selectBySize_Lib()