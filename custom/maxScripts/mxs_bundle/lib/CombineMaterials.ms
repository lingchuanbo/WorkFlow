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
E-mail: gftvfx@gmail.com
Company: GTVFX
__END__
***************************************************************************************************/

/*
__HELP__

Constructor: CombineMaterials
Instantiated Global: CombineMaterials


Methods:
	Run <objArr> mtlName:""
		- Provide an array of objects to create a MultiMaterial for
		- if a string is passed to mtlName then the new MultiMaterial will have this name otherwise it will be named "CombinedMaterial"



__END__
*/

::CombineMaterials = ""


mxs.Using "Logger"
mxs.Using "CommonFns"
mxs.Using "DetachElementsByMatID"


struct CombineMaterials
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	The main purpose of this Struct is to take in an array of objects and
	logically collect all of the materials applied to those objects and combine
	them into a single MultiMaterial.
	
	Members:
		[FN] BuildMultiMat
		[FN] CollectUniqueMaterials
		[FN] ExplodeMultiMat
		[FN] FilterObjArr
		[FN] FindMatIndexInMultMat
		[FN] GetModule
		[FN] GetSubMatById
		[FN] QsortNodeAphlabetical
		[FN] help
		[FN] run
		
	Example:
		CombineMaterials.Run ( GetCurrentSelection() ) mtlName:"New_MulitMat"
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	fn QsortNodeAphlabetical v1 v2 =
	(
		/*DOC_--------------------------------------------------------------------
		This function is meant to be passed to the Qsort function.
		Sorts items alphabetically
		
		Args:
			v1 (string)
			v2 (string)
		
		Returns:
			integer
		
		--------------------------------------------------------------------_END*/
		
		
		local v = v1.name
		local vv = v2.name
		case of
		(
			(v < vv): -1
			(v > vv): 1
			default: 0
		)
	),
	
	fn FilterObjArr objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Filters the inputed object array and returns only objects that are
		able to be converted to Editable_Poly
		
		Args:
			objArr (array[Node])
		
		Returns:
			array[Node]
		
		--------------------------------------------------------------------_END*/
		
		for obj in objArr where ( CanConvertTo obj Editable_Poly ) collect obj
	),
	
	fn ExplodeMultiMat mat arr:#() =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through a MultiMaterial and collects each individual materail
		into an array
		
		Recursive method
		
		Args:
			mat (Material)
		
		Kwargs:
			arr (array[material]) : used for recursion
		
		Returns:
			array[Material]
		
		--------------------------------------------------------------------_END*/
		
		if ( ClassOf mat ) == MultiMaterial then
		(
			for each in mat.materialList do
			(
				this.ExplodeMultiMat each arr:arr
			)
		)
		else 
		(
			if mat != undefined then appendIfUnique arr mat
		)
		
		arr
	),
	
	fn CollectUniqueMaterials objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through each object in the inputed array and collects a flat level
		array of unique materials by collecting each objects' material or by 
		recursing through the objects' multimaterial
		
		Args:
			objArr (array[Node])
		
		Returns:
			array[Material]
		
		--------------------------------------------------------------------_END*/
		
		local arr = #()
		
		for obj in objArr where ( obj.material != undefined ) do
		(
			this.ExplodeMultiMat obj.material arr:arr
		)
		
		arr
	),
	
	fn GetSubMatById multiMat id =
	(
		/*DOC_--------------------------------------------------------------------
		Takes an MultiMaterial and returns the material at the inputed id
		
		Args:
			multiMat (MultiMaterial)
			id (integer)
		
		Returns:
			Material
		
		--------------------------------------------------------------------_END*/
		
		local index = ( FindItem multiMat.materialIDList id )
		local out = undefined
		
		if index != 0 then
		(
			out = multiMat.materialList[index]
		)
		
		out
	),

	fn FindMatIndexInMultMat multiMat mat =
	( -- Returns the index of the mat
		local index = ( FindItem multiMat.materialList mat )
		
		local out = undefined 
		
		if index != 0 then
		(
		   out = index
		)
		
		out
	),
	
	-- Build a new MulitMaterial with newly assigned ID's
	fn BuildMultiMat matArr mtlName:"" =
	(
		-- sort the material array alphabetically, because it's nice to look at ;)
		qsort matArr this.QsortNodeAphlabetical
		
		local out = MultiMaterial name:( if mtlName == "" then "CombineMaterial" else mtlName )
		
		out.count = matArr.count
		out.materialList = matArr
		
		out
	),
	
	fn Run objArr mtlName:"" = 
	(
		--SetCommandPanelTaskMode #create
		::mxs.BlockUi True
		
		objArr = this.FilterObjArr objArr
		
		local matArr = this.CollectUniqueMaterials objArr

		local newMat = this.BuildMultiMat matArr mtlName:mtlName

		for obj in objArr do
		(
			::Logger.debug "Converting To Poly" args:#() cls:this
			
			::CommonFns.ConvertBaseObject obj type:#poly
			
			::Logger.debug "Disabling Modifiers" args:#() cls:this
			
			local mdsArr = #()
			if obj.modifiers.count != 0 then
			(
				for m = 1 to obj.modifiers.count do 
				(
					-- Store the enabled state of the modifier
					mdsArr[m] = obj.modifiers[m].enabled
					-- Disable the modifier
					obj.modifiers[m].enabled = False
				)
			)
			
			::Logger.debug "Building remapArr" args:#() cls:this
			--
			local remapArr = #()
			local idArr = ::DetachElementsByMatID.CollectUniqueFaceIds obj
			local curMat = obj.material
			
			for id in idArr do
			(
				-- Need to collect and store the mesh faces that correspond with the new id
				-- If it's done in-line with getting the newId, there's a potential to overlap the id assignment
				
				local curSubMat = if ( ClassOf curMat ) == MultiMaterial then ( GetSubMatById curMat id ) else curMat
				
				local newId = this.FindMatIndexInMultMat newMat curSubMat
				
				local faceArr = ::DetachElementsByMatID.CollectFacesById obj id
				
				append remapArr #(newId, faceArr)
			)
			
			::Logger.debug "Apply remapping" args:#() cls:this
				
			-- Apply the remapping of the id's
			for each in remapArr do
			(
				::Logger.debug "each: {1}" args:#(each) cls:this
				
				polyop.SetFaceMatId obj each[2] each[1]
			)
			
			::Logger.debug "Apply new Material" args:#() cls:this
			
			obj.material = newMat
			
			::Logger.debug "Enable modifier" args:#() cls:this
			
			for m = 1 to mdsArr.count do
			(
				-- Set the enabled state of the modifier to the stored state
				obj.modifiers[m].enabled = mdsArr[m]
			)
			
			::CommonFns.ConvertBaseObject obj type:#mesh
		)
		
		::mxs.BlockUi False
		
		newMat
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
		-- Pass
	),

	__init__ = _init()
)

CombineMaterials = CombineMaterials()

