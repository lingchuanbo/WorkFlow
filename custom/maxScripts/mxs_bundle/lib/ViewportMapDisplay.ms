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
__MXSDOC
Author: Gavyn Thompson
Company: GTVFX
Website: https://github.com/gtvfx
Email: gftvfx@gmail.com
__END__
***************************************************************************************************/


::ViewportMapDisplay = ""


struct ViewportMapDisplay
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	DESCRIPTION
	
	Members:
		[Var] mClassArr
		[FN] DisableMapsInViewport
		[FN] EnableMapsInViewport
		[FN] GetMaterialClasses
		[FN] GetModule
		[FN] SetViewPortDisplay_mapped
		[FN] SetMapDisplay
		[FN] ToggleSubMapDisplay
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public

	mClassArr,
	
	fn GetMaterialClasses refactor:False =
	(
		/*DOC_--------------------------------------------------------------------
		Collects an array of materials classes directly from Material.Classes
		
		Kwargs:
			refactor (boolean) : If true will collect the array again
		
		Returns:
			array[Material Class]
		
		--------------------------------------------------------------------_END*/
		
		if mClassArr == undefined or refactor then
		(
			this.mClassArr = Material.Classes
		)
		
		this.mClassArr
	),
	
	fn ToggleSubMapDisplay mat_or_map state:False sourceMat:undefined =
	(
		/*DOC_--------------------------------------------------------------------
		Recursive method set the display of all the maps within a shader tree
		
		Args:
			mat_or_map (Material or Texmap) : root of the tree to recurse down
		
		Kwargs:
			state (boolean)
			sourceMat (undefined | Material or Texmap) : used during recursion
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if ( sourceMat == undefined ) then 
		(
			sourceMat = mat_or_map
		)
		
		local numSubTexmaps = ( GetNumSubTexmaps mat_or_map )
		
		for i = 1 to numSubTexmaps do
		(
			local tMap = ( GetSubTexmap mat_or_map i )
			
			if tMap != undefined then
			(
				this.ToggleSubMapDisplay tMap state:state sourceMat:sourceMat
				ShowTextureMap sourceMat tMap state
			)
		)
	),

	mapped fn SetViewPortDisplay_mapped mArr state:False =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the state of the showInViewport property to the inputed state for each 
		material or map in the mArr.
		
		If state is False then this will trigger a recursive method down the entire shader
		tree of the material or map that will disable the viewport display of the entire tree.
		
		Args:
			mArr (array[Material or Map])
		
		Kwargs:
			state (boolean)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if ( IsProperty mArr #showInViewport ) then
		(
			mArr.showInViewport = state
			
			if not state then
			(
				this.ToggleSubMapDisplay mArr state:state
			)
		)
	),
	
	fn SetMapDisplay state:False =
	(
		/*DOC_--------------------------------------------------------------------
		Collects all ClassInstances of any material in the current scene and
		sets their showInViewport property to the inputed state
		
		Kwargs:
			state (boolean)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		for mClass in ( this.GetMaterialClasses() ) do
		(
			local mArr = GetClassInstances mClass
			
			if mArr != undefined and mArr.count != 0 then
			(
				this.SetViewPortDisplay_mapped mArr state:state
			)
		)
	),
	
	fn DisableMapsInViewport =
	(
		/*DOC_--------------------------------------------------------------------
		Disables the viewport display of all materials and maps in the scene
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		this.SetMapDisplay state:False
	),
	
	fn EnableMapsInViewport =
	(
		/*DOC_--------------------------------------------------------------------
		Enables the viewport display of all materials and maps in the scene
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		this.SetMapDisplay state:True
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
		Get hellp on the current module or a specific function
		
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
		
		-- pass
	),

	__init__ = _init()
)

ViewportMapDisplay = ViewportMapDisplay()




