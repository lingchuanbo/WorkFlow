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
__MXSDOC__
Author: Gavyn Thompson
Company: GTVFX
Website: https://github.com/gtvfx
Email: gftvfx@gmail.com
__END__
***************************************************************************************************/


::DetachElementsByMatID = ""


mxs.using "DotNetUi"
mxs.using "Logger"


struct DetachElementsByMatID
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	Takes an object with multip face mat ID assignments and breaks it appart
	into multiple objects of the same face mat IDs
	
	Members:
		[Var] ShowUI = false
		[Var] debug = false
		[Var] ro = undefined
		
		[FN] BreakMultMatByObj
		[FN] CollectFacesById
		[FN] CollectUniqueFaceIds
		[FN] DetachElementById
		[FN] GetModule
		[FN] KillInstances
		[FN] ValidateObj
		[FN] batch
		[FN] help
		[FN] run
		[FN] ui
	
	Args:
		ro (MaxScript Rollout)
		debug (boolean)
		showUi (boolean)
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	ro,
	debug = False,
	showUi = False,
	
	fn CollectUniqueFaceIds obj =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through all of the faces of the inputed Editable_Poly object and returns
		an array of all unique IDs.
		
		Args:
			obj (Editable_Poly)
		
		Returns:
			(array[integer])
		
		--------------------------------------------------------------------_END*/
		
		local out = #()
		
		for i = 1 to ( polyop.getnumfaces obj ) do
		(
			appendIfUnique out ( polyop.getFaceMatID obj i )
		)
		
		out
	),

	fn CollectFacesById obj id =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through all the faces of the inputed Editable_Poly object and returns
		an array of face indices that match the inputed mat id
		
		Args:
			obj (Editable_Poly)
			id (integer)
		
		Returns:
			(array[integer])
		
		--------------------------------------------------------------------_END*/
		
		local out = #{}
		
		for i = 1 to ( polyop.getnumfaces obj ) do
		(
			if polyop.getFaceMatID obj i == id then append out i
		)
		
		out
	),
	
	fn BreakMultMatByObj obj id =
	(
		/*DOC_--------------------------------------------------------------------
		Takes a multiMaterial currently assigned to the inputed obj and
		assigns just the submaterial matching the inputed id. So the obj
		only has a float material as a result.
		
		Args:
			obj (NODE)
			id (integer)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( classOf obj.material == multiMaterial ) then
		(
			if obj.material[id] != undefined then
			(
				obj.material = obj.material[id]
			)
			else
			(
				::Logger.error "id({1}) did not match a material of obj: {2}" args:#(id, obj) cls:this
				obj.material = obj.material.materialList[1]
			)
		)
	),
	
	fn DetachElementById obj parseMaterial:True =
	(
		/*DOC_--------------------------------------------------------------------
		This is the main logic for the struct. This collects all unique face mat IDs
		and then detaches groups of faces with the same ID as elements. If 
		parseMaterial is True then it will also explicitly assign the shader to the
		detached object that matches the group's face ID from the current 
		multimaterial on the object.
		
		Keeps wirecolor, parent and gbufferchannel from original obj
		
		Converts all objects to Editable_Mesh
		
		Args:
			obj (NODE)
		
		Kwargs:
			parseMaterial (boolean)
		
		Returns:
			objArr: (array[NODE])
		
		--------------------------------------------------------------------_END*/
		
		
		::mxs.BlockUi True
		
		local objArr = #()
		local idArr = this.CollectUniqueFaceIds obj
		
		::Logger.debug "idArr: {1}" args:#(idArr) cls:this
		
		for id in idArr do
		(
			-- remove any empty elements
			if ( polyop.getnumfaces obj ) == 0 then
			(
				Delete obj
				exit
			)
			
			local faceArr = this.CollectFacesById obj id
			::Logger.debug "faceArr: {1} | {2}" args:#(faceArr.count, faceArr) cls:this
			
			local newName = ( uniquename ( obj.name as string ) )
				
			obj.EditablePoly.SetSelection #Face faceArr
				
			local targetFaces = polyop.getFaceSelection obj
			
			polyop.detachFaces obj targetFaces asNode:true name:newName
				
			local newObj = GetNodeByName newName
			::Logger.debug "newObj: {1}" args:#(newObj) cls:this
				
			if parseMaterial then
			(
				this.BreakMultMatByObj newObj id
			)
				
			append objArr newObj
			
			newObj.wireColor = obj.wirecolor
			newObj.parent = obj.parent
			newObj.gbufferchannel = obj.gbufferchannel
			
			centerpivot newObj
			ResetXForm newObj 
			ConvertTo newObj (Editable_Mesh)
		)
		
		if (polyop.getnumfaces obj) == 0 then
		(
			Delete obj
		)
		
		::mxs.BlockUi False
		
		objArr
	),
	
	fn KillInstances objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Removes all instancing (Makes all objects unique)
		
		Args:
			objArr (array[NODE])
		
		Returns:
			(boolean)
		
		--------------------------------------------------------------------_END*/
		
		InstanceMgr.MakeObjectsUnique objArr #individual 
	),
		
	fn ValidateObj obj =
	(
		/*DOC_--------------------------------------------------------------------
		Tests if the inputed object can be converted to Editable_Poly
		Collapses the modifier stack
		Converts to Editable_Poly
		
		Args:
			obj (NODE)
		
		Returns:
			(boolean)
		
		--------------------------------------------------------------------_END*/
		
		if ( CanConvertTo obj Editable_Poly ) then
		(
			if obj.modifiers.count != 0 then
			(
				CollapseStack obj
			)
			
			if ( ClassOf obj != Editable_Poly ) then
			(
				ConvertTo obj Editable_Poly
			)
			
			True
		)
		else
		(
			::Logger.error "{1} is not a valid object" args:#(obj) cls:this
			False
		)
	),
	
	fn Batch objArr parseMaterial:True =
	(
		/*DOC_--------------------------------------------------------------------
		This takes an array of objects, validates them and passes them through
		the DetachElementById method.
		
		Args:
			objArr (array[NODE])
		
		Kwargs:
			parseMaterial (boolean)
		
		Returns:
			(array[NODE]) : All of the objects generated from the detach process
		
		--------------------------------------------------------------------_END*/
		
		local out = #()
		
		objArr = for obj in objArr where ( this.ValidateObj obj ) collect obj
		
		if objArr.count == 0 then return ( format "Nothing to analyze\n" )
		
		::Logger.debug "Passed objArr: {1}" args:#(objArr) cls:this
		
		::mxs.BlockUi True
		
		::Logger.info "Killing Instances" args:#() cls:this
		this.KillInstances objArr
		
		for obj in objArr do
		(
			local objElements = this.DetachElementById obj parseMaterial:parseMaterial
			join out objElements
			GC()
		)
		
		::mxs.BlockUi False
		
		out
	),
	
	fn Ui =
	(
		/*DOC_--------------------------------------------------------------------
		Generates a simple UI for running the logic
		
		Returns:
			(MaxScript Rollout)
		
		--------------------------------------------------------------------_END*/
		
		rollout ro "Detach Elements by MatId:" width:400
		(
			local self
			
			group "Objects:"
			(
				checkBox chk_selection ":Selection" checked:True tooltip:"Only analyze the objects in your current selection" across:2
				checkBox chk_scene ":Full Scene" checked:False tooltip:"Aanalyze all objects in your scene"
			)
			
			group "Options:"
			(
				checkBox chk_parse ":Separate Multimat" checked:True tooltip:"Separate the multimaterial into its separate materials"
			)
			
			dotNetControl dNbtn_collect "Button" height:40
			
			fn _init pself =
			(
				self = pself
				
				::DotNetUi.InitDnetBtn dNbtn_collect "Detach Elements" 12 style:#popup colorOffsetInt:10 tooltip:""
			)
			
			on chk_selection changed state do
			(
				chk_scene.state = not state
			)
			
			on chk_scene changed state do
			(
				chk_selection.state = not state
			)
			
			on dNbtn_collect mouseClick args do
			(
				local objArr = case chk_selection.state of
				(
					( True ): ( GetCurrentSelection() )
					default: ( objects as array )
				)
				
				self.Batch objArr parseMaterial:chk_parse.state
			)
		)
		
		createDialog ro
		ro._init this
	),
	
	fn Run =
	(
		/*DOC_--------------------------------------------------------------------
		Simple method so that you can always just call the <object>.Run() method
		to get the tool.
		
		See Also:
			[FN] Ui
		
		--------------------------------------------------------------------_END*/
		
		this.Ui()
	),
	
	fn GetModule =
	(
		/*DOC_--------------------------------------------------------------------
		Get the full path to the current MaxScript file
	
		Returns:
			String
		--------------------------------------------------------------------_END*/
	
		( GetSourceFileName() )
	),
	
	fn Help _fn: =
	(
		/*DOC_--------------------------------------------------------------------
		Get help on the current module or a specific function
	
		Kwargs:
			_fn (string) : Name of the internal method as a string
	
		Returns:
			VOID
	
		--------------------------------------------------------------------_END*/
	
		::mxs.GetScriptHelp ( GetSourceFileName() ) _fn:_fn
	),
	
private
	
	fn _init =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if this.showUi then
		(
			this.Run()
		)
	),
	
	__init__ = _init()
)

DetachElementsByMatID = DetachElementsByMatID()



