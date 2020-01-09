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


::MaterialFns = ""


mxs.Using "MeshFns"


struct MaterialFns
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	Collection of methods for working with materials in 3dsmax scenes
	
	Members:
		[FN] CollectUniqueMaterials
		[FN] CreateNodeViewByFaceID
		[FN] CreateNodeViewForEachSceneMaterial
		[FN] CreateViewForMat
		[FN] CreateViewPerObject
		[FN] DeleteAllViews
		[FN] GetModule
		[FN] PutMatToActiveMeditSlot
		[FN] PutSceneMatsToMEdit
		[FN] PutSelMatsToMEdit
		[FN] ResetMEdit
		[FN] RestoreMedit
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	fn ResetMEdit =
	(
		/*DOC_--------------------------------------------------------------------
		Runs a built-in macro to clear the contents of the material editor
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		macros.run "Medit Tools" "clear_medit_slots"
	),
	
	fn RestoreMedit =
	(
		/*DOC_--------------------------------------------------------------------
		Runs a built-in macro to restore the contents of the material editor
		after they've been cleared.
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		macros.run "Medit Tools" "restore_medit_slots"
	),
	
	fn PutMatToActiveMeditSlot obj  =
	(
		/*DOC_--------------------------------------------------------------------
		Gets the material from the inputed obj and puts in into the activeMeditslot
		
		Args:
			obj (NODE)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		MatEditor.mode = #basic
		
		if ( obj != undefined ) and ( obj.material != undefined ) then
		(
			meditMaterials[activeMeditslot] = obj.material
		)
		else
		(
			format "***** PutMatToActiveMeditSlot could not collect a valid material *****\n"
		)
	),
	
	fn CollectUniqueMaterials objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Collects an array of unique materials from the inputed array of objects
		
		Args:
			objArr (array[NODE])
		
		Returns:
			(array[material])
		
		--------------------------------------------------------------------_END*/
		
		MakeUniqueArray ( for obj in objArr where obj.material != undefined collect obj.material )
	),
	
	fn PutSelMatsToMEdit objArr:( GetCurrentSelection() ) = 
	(
		/*DOC_--------------------------------------------------------------------
		Collects the unique materials from the inputed object array and puts them
		to the Material Editor
		
		Kwargs:
			objArr (array[Node])
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( objArr.count != 0 ) then
		(
			MatEditor.mode = #basic
			
			local matArr = this.CollectUniqueMaterials objArr
				
			for i = 1 to matArr.count do
			(
				if i > meditMaterials.count then exit
				
				meditMaterials[i] = matArr[i]
			)
			
			if matArr.count > meditMaterials.count then messageBox "There were more materials than MEdit slots."
		)
		else
		(
			messagebox "Nothing selected......"
		)
	),
	
	fn PutSceneMatsToMEdit =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through the materials in the 'sceneMaterials' global and puts them
		to the Material Editor.
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if sceneMaterials.count != 0 then
		(
			MatEditor.mode = #basic
			
			for t = 1 to meditMaterials.count do
			(
				if sceneMaterials[t] == undefined then
				(
					exit
				)
				else
				(
					meditmaterials[t] = sceneMaterials[t]
				)
			)
			
			if sceneMaterials.count > meditMaterials.count do messageBox "There are more materials than MEdit slots." title:"GTVFX"
		)
		else
		(
			messageBox "No materials found in scene." title:"GTVFX: Error"
		)
	),

	fn DeleteAllViews =
	(
		/*DOC_--------------------------------------------------------------------
		Deletes all the view in the Slate Material Editor
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		MatEditor.mode = #advanced
		local numViews = trackViewNodes[#sme].numsubs
		for i = 1 to numViews do sme.DeleteView 1 false
	),
	
	fn CreateViewForMat mat =
	(
		/*DOC_--------------------------------------------------------------------
		Create a view in the Slate Material Editor for the inputed material
		
		Args:
			mat (Material)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if ( sme.GetViewByName mat.name ) == 0 then
		(
			MatEditor.mode = #advanced
			MatEditor.Open()
			
			local viewIndex = sme.CreateView mat.name
			local newView = sme.GetView viewIndex
			
			newView.CreateNode mat [0,0]
		)
		else
		(
			-- If a view with the name already exists then the user can choose to delete it and create a new one.
			
			if queryBox ("Node view..." + mat.name + "...already exists.\nDo you want to replace it?") then
			(
				sme.DeleteView ( sme.GetViewByName mat.name ) false
				
				this.CreateViewForMat mat
			)
		)
	),
	
	fn CreateViewPerObject objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Collects all unique materials from the inputed object array and creates
		a node view for each in the Slate Material Editor.
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if ( objArr.count != 0 ) then
		(
			MatEditor.mode = #advanced
			MatEditor.Open()
			
			local matArr = This.CollectUniqueMaterials objArr
			
			for mat in matArr do
			(
				this.CreateViewForMat mat
			)
		)
		else
		(
			messageBox "**** You must have an object selected ****"
		)
	),
	
	fn CreateNodeViewByFaceID obj =
	(
		/*DOC_--------------------------------------------------------------------
		This takes a single object as an input, loops through all the faces of the
		object and collect an array of unigue FaceMatIDs. Then creates a node
		view in the SlateMaterialEditor for each FaceMatID with the matching
		subMaterial from the inputed objects MultiMaterial.
		
		The material of the inputed obj must be a MultiMaterial
		
		This is usefule for working with objects with particularly complex materials
		
		Args:
			obj (Node)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if obj == undefined then
		(
			messageBox "CreateNodeViewByFaceID expects an obj to be passed.\nBy default this is the first object in Selection."
		)
		else
		(
			local masterMat = obj.material
			
			if ( ClassOf masterMat ) == multiMaterial then
			(
				MatEditor.mode = #advanced
				MatEditor.Open()
				
				local faceIdArr = ::MeshFns.GetUniqueMatIds obj
				
				for id in faceIdArr do
				(
					this.CreateViewForMat obj.material.materialList[id]
				)
			)
			else
			(
				messageBox "The object's material is not a Multi/Sub material."
			)
		)
	),
	
	fn CreateNodeViewForEachSceneMaterial =
	(
		/*DOC_--------------------------------------------------------------------
		Creates a separate node view in the Slate Material Editor for each
		material in the sceneMaterials global
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if sceneMaterials.count != 0 then
		(
			MatEditor.mode = #advanced
			MatEditor.Open()
			
			for mat in sceneMaterials do
			(
				this.CreateViewForMat mat
			)
		)
		else
		(
			messageBox "No materials found in scene."
		)
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
		
		-- Pass
	),

	__init__ = _init()
)

MaterialFns = MaterialFns()