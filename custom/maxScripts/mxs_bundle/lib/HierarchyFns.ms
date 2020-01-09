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
[Purpose]

***************************************************************************************************/
/*
__HELP__

Constructor: 
Instantiated Global: 

Methods:



__END__
*/


struct HierarchyFns
(
public

	mapped fn SetParent_mapped objArr obj _replace:False =
	(
		/* 
		Set the parent of each object in objArr to obj
		
		using the _replace argument will flatten the hierarchy of objArr and directly parent
		each object to obj
		 */
		if _replace then
		(
			objArr.parent = obj
		)
		else
		(
			if objArr.parent == undefined then objArr.parent = obj
		)
	),
	
	fn Set_Parent objArr obj _replace:False =
	(
		/* 
		Set the parent of each object in objArr to obj
		
		using the _replace argument will flatten the hierarchy of objArr and directly parent
		each object to obj
		
		This method wraps the mapped function so that we can also perform an unmapped operation
		to see if any of the objects in the provided array have a parent outside of the selection.
		 */
		
		if not _replace then
		(
			for i in objArr where i.parent != undefined and (finditem objArr i.parent) == 0 do i.parent = obj
		)
		
		this.SetParent_mapped objArr obj _replace:_replace 
	),
	
	mapped fn RemoveParent_mapped objArr =
	(
		/* 
		Sets the parent of each object in the supplied array to 'undefined'
		 */
		
		objArr.parent = undefined
	),
	
	fn GetTopLevelParent obj =
	(
		/* 
		Recursses up through the objects hierarchy and returns the top-most object
		 */
		
		if not (IsValidNode obj) then
		(
			throw ("GetTopLevelParent() expected a valid object node.\n-- Got: " + (obj as string))
		)
		
		if obj.parent != undefined then
		(
			obj = GetTopLevelParent obj.parent
		)
		obj
	),
	
	fn GetParentsRecursive obj arr:#() skipNamePattern: skipClass: skipSuperClass: =
	(
		/* 
		recurses upstream through a node's hierarchy collecting all nodes above obj
		 */
		
		-- A boolean that will exit the recurse if set to true
		local skipCase = False
		
		if obj.parent != undefined then
		(
			if finditem arr obj.parent == 0 then
			(
				if ( skipNamePattern != unsupplied ) and ( classOf skipNamePattern == String ) then
				(
					exitCase = ( matchPattern obj.parent.name pattern:skipNamePattern )
				)
				
				if ( skipClass != unsupplied ) and ( skipClass != undefined ) then
				(
					exitCase = ((classOf obj.parent) == skipClass)
				)
				
				if ( skipSuperClass != unsupplied ) and ( skipSuperClass != undefined ) then
				(
					exitCase = ( (SuperClassOf obj.parent) == skipSuperClass )
				)
				
				if not skipCase then
				(
					append arr obj.parent
				)
			)
			this.GetParentsRecursive obj.parent arr:arr skipNamePattern:skipNamePattern skipClass:skipClass skipSuperClass:skipSuperClass
		)
		arr
	),
	
	fn GetChildrenRecursive obj arr:#() skipNamePattern: skipClass: skipSuperClass: =
	(
		/* 
		recurses downstream through a node's hierarchy collecting all nodes below obj
				*/
		
		-- A boolean that will exit the recurse if set to true
		local skipCase = False
		
		if obj.children.count != 0 then
		(
			for c in obj.children do
			(
				if ( skipNamePattern != unsupplied ) and ( classOf skipNamePattern == String ) then
				(                    
					skipCase = ( matchPattern c.name pattern:skipNamePattern )
				)
				
				if ( skipClass != unsupplied ) and ( skipClass != undefined ) then
				(
					skipCase = ((classOf c) == skipClass)
				)
				
				if ( skipSuperClass != unsupplied ) and ( skipSuperClass != undefined ) then
				(
					skipCase = ((SuperClassOf c) == skipSuperClass)
				)
				
				if not skipCase then
				(
					append arr c
					this.GetChildrenRecursive c arr:arr skipNamePattern:skipNamePattern skipClass:skipClass skipSuperClass:skipSuperClass
				)
			)
		)
		
		arr
	),
	
	fn GetNodeHierarchyTree obj =
	(
		/* 
		Collects all parents and children and return a combined arr including the obj
		 */
		parentArr = this.GetParentsRecursive obj
		childArr = this.GetChildrenRecursive obj
		
		out = (parentArr + childArr + obj)
	),
	
	fn GetNodeHierarchyAsPath obj =
	(
		/* 
		- Concotenates a path to the object through it's hierarch
		- Used for the Alembic export and Material collection
		 */
		
		if IsValidNode obj then
		(
			local str = stringstream ""
			local worldRoot = "/root/world/geo/"
			
			format "%" worldRoot to:str
			
			local parentArr = #()
			this.GetParentsRecursive obj arr:parentArr
			
			for i = parentArr.count to 1 by -1 do format "%/" parentArr[i].name to:str
				
			format "%" obj.name to:str
			
			str as string
		)
		else
		(
			undefined
		)
	),
	
	fn GetModule =
	(
		( GetSourceFileName() )
	),

	fn Help =
	(
		::mxs.GetScriptHelp ( GetSourceFileName() )
	),

private
	
	fn _init =
	(
		-- Pass
	),

	__init__ = _init()
)

HierarchyFns = HierarchyFns()