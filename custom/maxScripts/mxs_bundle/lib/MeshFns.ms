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


::MeshFns = ""


mxs.using "EventTimer"
mxs.using "Logger"
mxs.using "EnsureObjectClass"
mxs.using "MaterialFns"


struct MeshFns
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	A collection of various methods for working with and manipulating
	mesh objects
	
	Members:
		[FN] AddSmoothModWithStack
		[FN] AttachByMaterial
		[FN] AttachObjs
		[FN] CheckIfModifiersPresent
		[FN] ConvertToMeshWithModifierStack
		[FN] ConvertToMesh_mapped
		[FN] DetachElements
		[FN] DetachMeshElements
		[FN] DetachSplineElements
		[FN] EnsureClassOfObj
		[FN] EnsureEditMesh
		[FN] EnsureEditPoly
		[FN] EnsureEditSpline
		[FN] FastCenterPivot
		[FN] FastResetXform
		[FN] GetModule
		[FN] GetUniqueMatIds
		[FN] IsValidMesh
		[FN] QuadrifySelection
		[FN] ReplaceWithInstance
		[FN] ReplaceWithReference
		[FN] ResetMesh
		[FN] ResetXformWithRotation
		[FN] ShowObjMatIDs
		[FN] ZeroOutMatrix_mapped
		[FN] help
		[FN] weldVerts
	
	__END__
	--------------------------------------------------------------------_END*/
	
public

	fn IsValidMesh obj =
	(
		/*DOC_--------------------------------------------------------------------
		Checks the properties we need to perform mesh operations on
		the inputed obj
		
		Args:
			obj (Node)
		
		Returns:
			Boolean
		
		--------------------------------------------------------------------_END*/
		
		if ( IsValidNode obj ) and ( isProperty obj #mesh ) and ( isProperty obj.mesh #numfaces ) then
		(
			True
		)
		else
		(
			False
		)
	),
	
	mapped fn ZeroOutMatrix_mapped objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the transform of each object to an Identity Matrix
		Set each objectOffset value to their default values
		
		Mapped function
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		objArr.objectOffsetPos = [0,0,0]
		objArr.objectOffsetRot = (quat 0 0 0 1)
		objArr.objectOffsetScale = [1,1,1]
		objArr.transform = matrix3 1
	),

	fn GetUniqueMatIds objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through all the faces of each object in the inputed object array
		and returns an array of unique faceMatIds.
		
		Args:
			objArr (array[Node])
		
		Returns:
			array[Integer]
		
		--------------------------------------------------------------------_END*/
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		local out = #()
		
		for obj in objArr do
		(
			if ( this.IsValidMesh obj ) then
			(
				for i = 1 to obj.mesh.numfaces do
				(
					appendIfUnique out ( GetFaceMatID obj.mesh i )
				)
			)
			else
			(
				format "***** % is not a valid mesh *****\n" obj
			)
		)
		
		( sort out )
	),
	
	fn ShowObjMatIDs objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Displays a messageBox with all of the unique faceMatIDs from the
		inputed object array
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		See Also:
			GetUniqueMatIds
		
		--------------------------------------------------------------------_END*/
		
		local idArr = this.GetUniqueMatIds objArr
		
		local str = StringStream ""
		
		if idArr.count != 0 then
		(
			format "MatIds in collection:\n" to:str
			
			for id in idArr do
			(
				format "%...\n" id to:str
			)
		)
		else
		(
			format "No MatIds in collection:\n" to:str
		)
		
		messageBox ( str as string ) title:"GTVFX:"
	),

	fn CheckIfModifiersPresent objArr = 
	(
		/*DOC_--------------------------------------------------------------------
		Loops through all objects in the inputed object array and queries the
		number of modifiers on the object. If Greater than 0 the name of the 
		object is printed to the listener and the method returns True.
		
		Args:
			objArr (array[Node])
		
		Returns:
			Boolean
		
		--------------------------------------------------------------------_END*/
		
		local out = False
		
		for obj in objArr do 
		(
			if obj.modifiers.count > 0 then
			(
				format "***** % has modifiers *****\n" obj.name
				out = True
				exit
			)
		)
	   
		out
	),
	
	mapped fn FastResetXform objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Runs a ResetXform and CollapseStack on each object
		
		Mapped function
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		resetXform objArr
		collapseStack objArr
	),
	
	mapped fn FastCenterPivot objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Runs a CenterPivot on each object
		
		Mapped function
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		CenterPivot objArr
	),
	
	mapped fn ResetXformWithRotation objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Stores the rotation and position values of each object, then zeros the object out
		prior to running FastResetXform. Then restores the stored position and rotation
		values
		
		Mapped function
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		See Also:
			FastResetXform
		
		--------------------------------------------------------------------_END*/
		
		local saveRotation = objArr.rotation.controller.value
		local savePosition = objArr.position.controller.value
		
		objArr.rotation.controller.value = (quat 0 0 0 0)
		objArr.position.controller.value = [0,0,0]
		
		this.FastResetXform objArr
		
		objArr.scale.controller.value = [1,1,1] -- hard code the value after the resetXform to eliminate rounding/precision errors
		
		objArr.rotation.controller.value = saveRotation
		objArr.position.controller.value = savePosition
	),
	
	fn ResetMesh objArr collapseMods:False =
	( 
		/*DOC_--------------------------------------------------------------------
		This completely rebuilds a mesh. This is a huge hack to workaround the
		fact that meshes inevitably become corrupted form time to time. This
		is a very important step in handing off geometry from modeling on down
		the pipe.
		
		Args:
			objArr (array[Node])
		
		Kwargs:
			collapseMods (boolean) : If true will collapse any modifiers rather than try to preserve them
		
		Returns:
			objArr (array[Node])
		
		--------------------------------------------------------------------_END*/
		
		::mxs.BlockUi True
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		-- We need to ensure that all of the inputed objects are unique to each other
		InstanceMgr.MakeObjectsUnique objArr #individual
		
		for obj in objArr do
		(
			local mds = #()
			
			if obj.modifiers.count != 0 then
			(
				if not collapseMods then
				(
					for m = 1 to obj.modifiers.count do 
					(
						if obj.modifiers[m].enabled then
						(
							mds[m] = True
							obj.modifiers[m].enabled = false
						)
						else
						(
							mds[m] = False
						)
					)
				)
				else
				(
				   CollapseStack obj 
				)
			)
			
			--- make a clean shape...
			local bx = box()
			
			objInst = instance obj
			
			convertToPoly bx
			
			bx.transform = obj.transform
			bx.scale.controller = ScaleXYZ() -- Much more accurate than Bezier_Scale
			bx.scale.controller.value = [1,1,1] -- Hard set to 1 to circumvent rounding errors
			
			polyOp.attach bx objInst -- Attach the box and the objInst to recreate all of the polys of the objInst
			polyOp.deleteVerts bx #{1..8} -- Delete the faces making up the bx shape
			
			--- fix the tranform
			local conType = classof obj.scale.controller -- store the controller class
			
			obj.scale.controller = ScaleXYZ() -- Ensure that we are using ScaleXYZ for precision
			obj.transform = bx.transform -- Get the new transform from the clean object
			
			obj.scale.controller = conType() -- Restore the controller to it's original class
			
			-- Clean the object offsets
			obj.ObjectOffsetPos = [0,0,0]
			obj.ObjectOffsetRot = quat 0 0 0 1
			obj.ObjectOffsetScale = [1,1,1]
			
			-- Change out the baseobject with the baseobject of the clean shape
			obj.baseObject = copy bx.baseObject
			
			-- Re-enable the modifiers
			if mds.count != 0 then
			(
				for m = 1 to mds.count do
				(
					if mds[m] then obj.modifiers[m].enabled = True
				)
			)
			
			-- Delete the clean object
			delete bx
			
			-- Clean up the garbage
			GC()
		)
		
		::mxs.BlockUi False
		
		objArr
	),
	
	fn ReplaceWithInstance objArr sourceObj:( pickObject prompt:"**** Pick Source Object ****\n" ) type:1 =
	(
		/*DOC_--------------------------------------------------------------------
		This replaces the objects in the inputed objArr with an instance of the sourceObj
		
		This method allows for 2 ways to replace instances.
		
		1: Creates an instance of the sourceObj for each object in objArr with the sourceObj
		wireColor and gbufferChannel, but the transform of the object. It then deletes
		the original object. If your sourceObj is a mesh you will also get the material.
		
		2: Performs an instanceReplace on each object in the objArr with the inputed sourceObj.
		This just replaces the baseObject with an instance of the sourceObj baseObject.
		Other object settings will not come along with this method. Wirecolor, gbufferChannel, and
		Material will not be transferred from the sourceObj. This just instances the shape.
		
		Args:
			objArr (array[Node]) : Objects to replace
		
		Kwargs:
			sourceObj (Node) : Source node to instance
			type (integer)
		
		Returns:
			(array[Node])
		
		--------------------------------------------------------------------_END*/
		
		if sourceObj == undefined then return format "Pick Object Failed\n"
		
		if objArr.count != 0 and ( IsValidNode sourceObj ) then
		(
			format "***** sourceObj: % *****\n" sourceObj
			
			objArr = ::mxs.EnsureArgIsArray objArr
			
			undo label:"GTVFX: Replace With Instance" on
			(
				-- If the sourceObj is in the inputed objArr we need to remove it
				if ( findItem objArr sourceObj ) != 0 then
				(
					deleteItem objArr srcIndex
				)
				
				case type of
				(
					1:
					(
						local arr = #() -- This is the array of objects we will return from this method
						
						arr = join arr sourceObj
						
						-- Get the layer from the sourceObj. We'll all each new instance to this layer.
						local iLayer = LayerManager.getLayerFromName sourceObj.layer.name
						
						for obj in objArr do
						(
							-- create an instance of the sourceObj with it's wirecolor and gbufferChannel, but the transform of the obj
							local objInst = instance sourceObj wireColor:sourceObj.wireColor gbufferChannel:sourceObj.gbufferchannel transform:obj.transform
							
							-- transfer the parent to the instance
							objInst.parent = obj.parent
							
							-- add the instance to the sourceObj layer
							iLayer.addNode objInst
							
							-- add the objInst to the arr that we'll return
							append arr objInst
						)
						
						-- Delete the original objects
						delete objArr
						
						select arr
						arr
					)
					2:
					(
						for obj in objArr do
						(
							instanceReplace obj sourceObj
						)
						
						objArr
					)
				)
			)
		)
	),
	
	fn ReplaceWithReference objArr sourceObj:( pickObject prompt:"**** Pick Source Object ****\n" ) =
	(
		/*DOC_--------------------------------------------------------------------
		Replaces the baseObject of each object in objArr with a reference of the
		baseObject of the sourceObj.
		
		Args:
			objArr (array[Node])
		
		Kwargs:
			sourceObj (Node)
		
		Returns:
			objArr (array[Node])
		
		--------------------------------------------------------------------_END*/
		
		format "***** sourceObj: % *****\n" sourceObj
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		if objArr.count != 0 and ( IsValidNode sourceObj ) then
		(
			undo label:"GTVFX: Replace With Instance" on
			(  
				-- If the sourceObj is in the inputed objArr we need to remove it
				if ( findItem objArr sourceObj ) != 0 then
				(
					deleteItem objArr srcIndex
				)
				
				for obj in objArr do
				(
					referenceReplace obj sourceObj
				)
			)
			
			objArr
		)
	),
	
	mapped fn ConvertToMesh_mapped objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Runs the ConvertToMesh command on each object
		
		Mapped function
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		ConvertToMesh objArr
	),
	
	fn ConvertToMeshWithModifierStack objArr:( GetCurrentSelection() ) = 
	(
		/*DOC_--------------------------------------------------------------------
		Converts the baseObject of each object to an Editable_Mesh
		
		Kwargs:
			objArr (array[Node])
		
		Returns:
			objArr (array[Node])
		
		--------------------------------------------------------------------_END*/
		
		::mxs.BlockUi True
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		-- Filter the inputed object array for valid object types that can be converted
		objArr = for obj in objArr where ( superclassof obj.baseobject == geometryClass ) and ( isGroupMember obj == false ) and ( CanConvertTo obj Editable_Mesh ) collect obj
			
		for obj in objArr do
		(
			-- Add a Mesh_Select modifier just above the baseObject
			Addmodifier obj ( Mesh_Select() ) before:obj.modifiers.count
			
			-- Collapse the modifier stack at the Mesh_Select modifier, preserving all other modifiers
			maxOps.CollapseNodeTo obj obj.modifiers.count off
			
			GC()
		)
		
		::mxs.BlockUi False
		
		objArr
	),
	
	fn AddSmoothModWithStack objArr autoSmooth:True collapseToMod:True = 
	(
		/*DOC_--------------------------------------------------------------------
		Adds a Smooth modifier to each object right above the baseObject.
		Option to automatically collapse the stack at this modifier. Because this
		modifier is added above the base object we are able to collapse just this
		modifier to bake the smoothing into the mesh.
		
		Args:
			objArr (array[Node])
		
		Kwargs:
			autoSmooth (boolean) : translate to the autoSmooth flag on the Smooth Modifier
			collapseToMod (boolean)
		
		Returns:
			objArr (array[Node])
		
		--------------------------------------------------------------------_END*/
		
		::mxs.BlockUi True
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		-- Filter the inputed object array for valid object types that can be converted
		objArr = for obj in objArr where ( superclassof obj.baseobject == geometryClass ) and ( isGroupMember obj == false ) collect obj
			
		for obj in objArr do
		(
			addmodifier obj ( Smooth autoSmooth:autoSmooth ) before:obj.modifiers.count
			if collapseToMod then maxOps.CollapseNodeTo obj obj.modifiers.count off
		)
		
		::mxs.BlockUi False
		
		objArr
	),
	
	fn EnsureClassOfObj obj targetClass =
	(
		/*DOC_--------------------------------------------------------------------
		Attempts to ensure that the class of the baseobject of the inputed obj
		matches the inputed targetClass. If the classes don't match this will
		attempt to convert the obj to the targetClass, if it's not able it will
		return undefined
		
		Args:
			obj (Node)
			targetClass ( MaxClass )
		
		Returns:
			obj | undefined
		
		--------------------------------------------------------------------_END*/
		
		if ( ClassOf Obj.baseObject ) != targetClass then
		(
			if ( CanConvertTo obj targetClass ) then
			(
				ConvertTo obj targetClass
			)
			else
			(
				format "***** EnsureClassOfObj cannot convert % to % *****\n" obj targetClass
				obj = undefined
			)
		)
		
		obj
	),
	
	fn EnsureEditMesh obj =
	(
		/*DOC_--------------------------------------------------------------------
		Wrapper around EnsureClassOfObj
		
		Enusres the baseObject of the inputed obj is an Editable_Mesh
		
		Args:
			obj (Node)
		
		Returns:
			obj | undefined
		
		--------------------------------------------------------------------_END*/
		
		obj = this.EnsureClassOfObj obj Editable_Mesh
	),
	
	fn EnsureEditPoly obj =
	(
		/*DOC_--------------------------------------------------------------------
		Wrapper around EnsureClassOfObj
		
		Enusres the baseObject of the inputed obj is an Editable_Poly
		
		Args:
			obj (Node)
		
		Returns:
			obj | undefined
		
		--------------------------------------------------------------------_END*/
		
		obj = this.EnsureClassOfObj obj Editable_Poly
	),
	
	fn EnsureEditSpline obj =
	(
		/*DOC_--------------------------------------------------------------------
		Wrapper around EnsureClassOfObj
		
		Enusres the baseObject of the inputed obj is an Edit_Spline
		
		Args:
			obj (Node)
		
		Returns:
			obj | undefined
		
		--------------------------------------------------------------------_END*/
		
		obj = this.EnsureClassOfObj obj Edit_Spline
	),
	
	fn WeldVerts obj threshold:.01 =
	(
		/*DOC_--------------------------------------------------------------------
		Weld all of the verts of the object using the inputed threshold
		
		Args:
			obj (Node)
		
		Kwargs:
			threshold (float)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "WeldVerts {1} threshold:{2}" args:#(obj, threshold) cls:this
		
		-- Ensure the the object is an Editable_Poly
		local ensure_mesh = ::EnsureObjectClass obj Editable_Poly 
		
		obj.WeldThreshold = threshold
		polyop.weldVertsByThreshold obj #all
		
		update obj
		
		-- Convet the object back to it's original class
		ensure_mesh.Restore()
	),
	
	fn AttachObjs objArr garbageCollect:False =
	(
		/*DOC_--------------------------------------------------------------------
		This attaches multiple geometry objects together.
		
		This uses the coined 'Divide and Conquer' logic which has proven
		to be the most eficient way to attach many meshes together.
		
		If this process is using too much memory then you can set the garbageCollect
		flag to True and the memory will flush at the end of each loop. This will
		make it significantly slower, but will use far less memory.
		
		Once the process has started you can cancel it by holding the Esc key
		
		Args:
			objArr (array[Node])
		
		Kwargs:
			garbageCollect (boolean)
		
		Returns:
			Node
		
		--------------------------------------------------------------------_END*/
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		-- Filter the object array for only valid mesh objects
		objArr = for obj in objArr where ( this.IsValidMesh obj ) collect obj
		
		if objArr.count < 2 then
		(
			messagebox "Must have at least 2 objects selected!"
		)
		else
		(
			with undo off
			(
				::mxs.BlockUi True
				
				InstanceMgr.MakeObjectsUnique objArr #individual
				
				local atachTime = ::EventTimer caption:"AttachObjs"
				
				while objArr.count > 1 do
				(	
					for i = objArr.count to 2 by -2 do 
					(
						if keyboard.escpressed then
						(
							exit
						)
						
						attach ( this.EnsureEditMesh objArr[i] ) ( this.EnsureEditMesh objArr[i-1] )
						
						deleteItem objArr (i-1)
						
						if garbageCollect then GC()
					)
				)
				
				atachTime.End()
				
				::mxs.BlockUi False
			)
		)
		
		objArr[1]
	),
	
	fn AttachByMaterial objArr _weldVerts:False =
	(
		/*DOC_--------------------------------------------------------------------
		Collects all unique materials from the object array
		Loops through each material and collects all of the objects in the object
		array using that material
		Attaches all those objects together
		if _weldVerts is set to True then welds the verts on those obejcts
		
		Args:
			objArr (array[Node])
		
		Kwargs:
			_weldVerts (boolean)
		
		Returns:
			objArr (array[Node])
		
		See Also:
			::MaterialFns.CollectUniqueMaterials
			AttachObjs
			WeldVerts
		
		--------------------------------------------------------------------_END*/
		
		::mxs.BlockUi True
		
		local out = #()
		local unique_mats = ::MaterialFns.CollectUniqueMaterials objArr
		
		if unique_mats.count != 0 then
		(
			for mat in unique_mats do
			(
				local mat_objArr = for obj in objArr where not ( IsDeleted obj ) and obj.material == mat collect obj
				
				if mat_objArr.count > 1 then
				(
					local attach_obj = this.AttachObjs mat_objArr
					
					if _weldVerts then
					(
						this.WeldVerts attach_obj
					)
					
					append out attach_obj
				)
			)
		)
		
		::mxs.BlockUi False
		
		out
	),
	
	fn DetachMeshElements sourceObj =
	(
		/*DOC_--------------------------------------------------------------------
		This goes through the entire mesh and detaches each subobject element
		as a new node with a unique name derived from the sourceObj name
		
		Args:
			sourceObj (Node)
		
		Returns:
			objArr (array[Node])
		
		--------------------------------------------------------------------_END*/
		
		if not ( this.IsValidMesh sourceObj ) then
		(
			return ( format "***** % is not a valid mesh *****\n" sourceObj )
		)
		
		::mxs.BlockUi True
		
		sourceObj = this.EnsureEditPoly sourceObj
		
		local faceCount = sourceObj.getnumfaces()
		local faceTest = ((sourceObj.getnumfaces()) != 0)
		
		local out = #()
		
		with undo label:"GTVFX: DetachMeshElements" on
		(
			for i = 1 to faceCount while FaceTest do
			(
				if keyboard.escpressed then
				(
					exit
				)
				
				local newName = ( uniquename sourceObj.name )
				
				-- select the first face of the poly
				sourceObj.EditablePoly.SetSelection #Face #{1}
				
				-- from the face, get the element
				sourceObj.selectElement()
				
				-- get the faces of the selected element
				local targetElement = polyop.GetFaceSelection sourceObj
				
				-- detach the faces of the element as a new node
				polyop.detachFaces sourceObj targetElement asNode:true name:newName
				
				-- Get the new node
				local newObj = GetNodeByName newName
				
				-- Clean the new node
				this.ResetMesh newObj collapseMods:True
				
				-- add the newObj to the array that we'll return
				append out newObj
				
				-- test that the source still has faces to detach
				faceTest = ((sourceObj.getnumfaces()) != 0)
			)
			
			-- At this stage the source object shouldn't have any faces so we can delete it
			Delete sourceObj
		)
		
		::mxs.BlockUi False
		
		out
	),
	
	fn DetachSplineElements sourceObj =
	(
		/*DOC_--------------------------------------------------------------------
		This goes through the entire spline and detaches each subobject element
		as a new node with a unique name derived from the sourceObj name
		
		Args:
			sourceObj (Node)
		
		Returns:
			objArr (array[Node])
		
		--------------------------------------------------------------------_END*/
		
		::mxs.BlockUi True
		
		local splineCount = numsplines sourceObj 	
		
		with undo label:"GTVFX: DetachSplineElements" on
		(
			for i = 1 to splineCount do
			(
				if keyboard.escpressed then
				(
					exit
				)
				
				-- Splines don't have a DetachElement method so we copy the hole object and then delete extaneous segments
				local tempMaster = copy sourceObj
				
				-- Derive the name for the element
				tempMaster.name = ( sourceObj.name + "_Element_" + ( i as string ) )
				
				-- Incrementally set the FirstSpline so that we can programatically go through and delete all other elements
				setFirstSpline tempMaster i
				
				-- Delete all segments other than the FirstSpline
				for x = splineCount to 2 by -1 do DeleteSpline tempMaster x
			)
			
			-- This should be an empty node at this point, so delete it
			Delete sourceObj
		)
		
		::mxs.BlockUi False
	),
	
	fn DetachElements objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through all objects in the object array and tests the SuperClass
		of the object. Kicks off different logic for Geometry and Shapes.
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		See Also:
			DetachMeshElements
			DetachSplineElements
		
		--------------------------------------------------------------------_END*/
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		if objArr.count != 0 then
		(
			for obj in objArr do with redraw off
			(
				case ( SuperClassOf obj ) of
				(
					(GeometryClass):this.DetachMeshElements obj
					(Shape):this.DetachSplineElements obj
					default:format "***** % is of an unsupoorted object type: % *****\n" obj.name (SuperClassOf obj)
				)
			)
			
			CompleteRedraw()
		)
		else
		(
			messageBox "No Valid Objects Selected!" title:"ERROR: :("
		)
	),
	
	fn QuadrifySelection objArr = 
	(
		/*DOC_--------------------------------------------------------------------
		Loops throguh each object and ensures the object is an Edit_Poly
		Then slects the object and run the 'Quadrify' macro on the object.
		
		The 'Quadrify' macro does a pretty good job of removing triangulated faces
		
		Args:
			objArr (array[Node])
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::mxs.BlockUi True
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		for obj in objArr do
		(
			obj = this.EnsureEditPoly obj
			if obj != undefined then
			(
				select obj
				macros.run "PolyTools" "Quadrify"
			)
		)
		
		select objArr
		
		::mxs.BlockUi False
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


MeshFns = MeshFns()