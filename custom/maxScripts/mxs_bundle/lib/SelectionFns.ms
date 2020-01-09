/***************************************************************************************************
Copyright (C) 2013 - 2017  Gavyn Thompson

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
Author:				    Gavyn Thompson
Company:				GTVFX
Website:				https://github.com/gtvfx
Email:				    gftvfx@gmail.com
ScriptVersion:			
Updated:				
***************************************************************************************************/
/*
__HELP__

Constructor: 
Instantiated Global: 

[METHODS]


[DESCRIPTION]


[USAGE]


__END__
*/



struct SelectionFns
(
	self,
	ro,
	ro_selectBySize,
	ro_selectEveryNth,
	
	
	fn CollectInstances obj =
	(
		local out = ( refs.dependentNodes obj.baseObject )
		out
	),
	
	fn GetInstances =
	(
		if selection.count == 1 then
		(
			select ( this.CollectInstances $ )
		)
		else messageBox "Select one(1) object only."
	),
	
	fn CollectByMaterial mat =
	(
		local out = ( refs.dependentNodes mat )
		out
	),
	
	fn ByMaterial =	
	(
		if selection.count == 1 then
		(
			local baseMat = selection[1].material
			
			select ( this.CollectByMaterial baseMat )
		)
		else messageBox "Select only one object."
	),
	
	fn CollectByName objArr namePattern =
	(
		local out = ( for obj in objArr where ( matchPattern obj.name pattern:( namePattern+"*" ) ) and not obj.isHidden collect obj )
	),
	
	fn ByName =
	(
		if selection.count != 0 then
		(	
			local objName = ( $.name as stringstream )
			
			seek objName #eof
			
			local nChars = filePos objName
			
			seek objName 0
			local cName = readChars objName (nChars - 3)
			
			select ( this.CollectByName ( objects as array ) ( cName + "*" ) )
		)
		else messageBox "You must have only 1 object selected"
	),
	
	fn HasMeshProp obj =
	(
		if ( isProperty obj #mesh ) and ( isProperty obj.mesh #numFaces ) then
		(
			True
		)
		else
		(
			False
		)
	),
	
	fn CollectByNumFaces numFaces =
	(
		local out = for obj in objects where ( this.HasMeshProp obj ) and not obj.isHidden and ( obj.mesh.numFaces == numFaces ) collect obj
		out
	),
	
	fn ByNumFaces =
	(
		if selection.count == 1 and ( this.HasMeshProp $ ) then
		(
			select ( this.CollectByNumFaces $.mesh.numFaces )
		)
		else messageBox "Select only one object."
	),
	
	fn CollectByNumVerts numVerts =
	(
		local out = for obj in objects where ( this.HasMeshProp obj ) and not obj.isHidden and ( obj.mesh.numVerts == numVerts ) collect obj
		out
	),
	
	fn ByNumVerts arr:#() =
	(
		if selection.count == 1 and ( this.HasMeshProp $ ) then
		(
			select ( this.CollectByNumVerts $.mesh.numVerts )
		)
		else messageBox "Select only one object."
	),
	
	fn CollectByModifier objMod =
	(
		local out = ( for obj in objects where ( isProperty obj #modifiers ) and ( obj.modifiers.count != 0 ) and not obj.isHidden collect ( for m in obj.modifiers where ( classof m == classof objMod ) do exit with obj ) )
	),
	
	fn ByModifier =
	(
		select ( this.CollectByModifier selection[1].modifiers[1] )
	),
	
	fn GetBboxVolume obj =
	(
		local bBox = nodeLocalBoundingBox obj
		local dif = ( bBox[2] - bBox[1] )
		
		-- convert value to string to avoid float value rounding discrepencies
		local volume = execute ( ( abs ( dif.x * dif.y * dif.z ) ) as string )
		volume
	),
	
	fn ByBboxVolume tolerance:1.0 =
	(
		if selection.count != 1 then
		(
			 messageBox "Select only one object."
		)
		else
		(
			--baseVol = execute ((abs (calcBboxVolume obj)) as string) -- convert value to string to avoid float value rounding discrepencies
			local out = #()
			
			local baseVol = this.GetBboxVolume $
			local highVol = baseVol*tolerance
			local lowVol =  baseVol/tolerance
			format "***** HighVol: % | LowVol: % *****\n" highVol lowVol
			
			for obj in objects do
			(
				local iVol = this.GetBboxVolume obj
				
				if iVol <= highVol and iVol >= lowVol then append out obj
			)
			
			select out
		)
	),
	
	fn BySize_ui =
	(
		try(destroyDialog self.ro_selectBySize)catch()
		rollout ro_selectBySize "Select By Size By Gavyn Thompson" width:270 height:80
		(
			local self
			local objSel
			
			spinner spn_tol "Tolerance:" type:#float range:[1.0,999999999.0,1.0] fieldWidth:50 pos:[10,10]
			button btn_sel "Select" width:(ro_selectBySize.width/2-20) height:40 pos:[140,10]
			checkBox chk_realTime "Real-time:" pos:[20,35] 
			pickButton pck_objSel "Select Comparison Obj" width:(ro_selectBySize.width-20) message:"Select object" autoDisplay:true
			
			fn _init pself =
			(
				self = pself
			)
			
			on pck_objSel picked obj do
			(
				objSel = obj
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
							self.ByBboxVolume obj:objSel tolerance:newVal
						)
						else
						(
							messageBox "Select only one object to base the comparison on." title:"GTVFX:"
						)
					)
					else
					(
						self.ByBboxVolume obj:objSel tolerance:newVal
					)
					format "***** objSel: % *****\n" objSel
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
					self.ByBboxVolume tolerance:spn_tol.value
				)
				else if objSel != undefined then
				(
					self.ByBboxVolume obj:objSel tolerance:spn_tol.value
				)
				else messageBox "Select only one object or define a comparison object to continue" title:"GTVFX:"
			)
		)
		createDialog ro_selectBySize
		ro_selectBySize._init this
	),
	
	fn ByWireColor arr:#() =
	(
		if selection.count == 1 then
		(
			local out = #()
			local baseClr = $.wirecolor
			
			for obj in objects do
			(
				if obj.wirecolor == baseClr and obj.ishidden == false then
				(
					append out obj
				)
			)
			select out
		)		
		else messageBox "Only select one(1) object"
	),
	
	fn SelectEveryNth objArr nth:2 =
	(
		local out = #()
		
		for i in 1 to objArr.count by nth do
		(
			append out objArr[i]
		)
		select out
	),
	
	fn SelectEveryNth_Ui =
	(
		rollout ro_selectEveryNth "Select Every Nth By GTVFX" width:300 height:80
		(
			local self
			local objArr
			
			spinner spn_nth "Nth Value:" type:#integer range:[2,9999,2] across:2 tooltip:"Set the Nth value to skip that number of objects between selections"
			checkBox chk_keep "Store Object Array" offset:[20,0] tooltip:"If checked this will remember your current object selection at the time that you checked it.\nNth operations will continue to be calculated based on this selection.\nOtherwise Nth operations are calculated cumulativevly as the selection is set."
			button btn_select "Select by Nth" width:(ro_selectEveryNth.width-20) height:40 tooltip:"Do it!!"
				
			fn _init pself =
			(
				self = pself
			)
			on spn_nth changed newVal do
			(
				if chk_keep.state and objArr != undefined then
				(
					self.SelectEveryNth objArr nth:spn_nth.value
				)
			)
			on chk_keep changed state do
			(
				if state then objArr = ( GetCurrentSelectioN() ) else objArr = undefined
			)
			on btn_select pressed do
			(
				if objArr == undefined then objArr = selection
				self.SelectEveryNth objArr nth:spn_nth.value
			)
		)
		createDialog ro_selectEveryNth
		ro_selectEveryNth._init this
	),
	
	fn CollectClassObjects objClass equalTo:true =
	(
		local out = #()
		
		if equalTo then
		(
			out = for i in objects where classOf i.baseObject == objClass collect i
		)
		else
		(
			out = for i in objects where classOf i.baseObject != objClass collect i
		)
	),
	
	fn GetAbcCacheGeo =
	(
		local out = #()
		
		if Alembic_Mesh_Geometry != undefined then
		(
			for i in ( GetClassInstances Alembic_Mesh_Geometry ) do out += ( refs.dependentNodes i )
		)
		
		out
	),
	
	fn SelAbcCacheGeo =
	(
		select ( this.GetAbcCacheGeo() )
	),
	
	fn SelVRayProxyObjects = 
	(
		local out = #()
		
		if VRayProxy != undefined then
		(
			out = this.CollectClassObjects VRayProxy equalTo:true
		)
		
		out
	),
	
	fn SelEditableMeshObjects equalTo:True =
	(
		local out = #()
		
		if Editable_Mesh != undefined then
		(
			out = this.CollectClassObjects Editable_Mesh equalTo:equalTo
		)
		
		out
	),
	
	fn SelEditPolyObjects =
	(
		local out = #()
		
		out = ( this.CollectClassObjects Editable_Mesh ) + ( this.CollectClassObjects PolyMeshObject )
		
		out
	),
	
	fn CollectAnimatedObjects objArr =
	(
		local out = #()
		
		if objArr.count != 0 then
		(
			out = for obj in objArr where obj.isAnimated collect obj
		)
		else
		(
			messageBox "There are no objects to check.\nSupply an array of nodes to test."
		)
		
		out
	),
	
	fn SelAnimatedObjs objArr = 
	(
		select ( this.CollectAnimatedObjects objArr )
	),
	
	fn ClassUsage =
	(
		format "
---------------
CLASS USAGE: 
	Constructor: SelectionFns

	Instantiated global: _selFns
---------------\n"
	),
	
private
	
	fn __init__ =
	(
		-- Pass
	),
	
	_init = __init__()
)

SelectionFns = SelectionFns()