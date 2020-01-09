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



mxs.Load "UserProps"
mxs.Load "MeshFns"
mxs.Load "HierarchyFns"


struct WireColorFns
(
	nameSpace = "GTVFX",
	
	fn GetRandomColor =
	(
		random [20,20,20] [230,230,230]
	),
	
	fn WireColorRandom objArr:( GetCurrentSelection() ) =
	(
		if objArr.count == 0 then objArr = ( objects as array )
		
		for obj in objArr do obj.wirecolor = ( this.GetRandomColor() )
	),
	
	fn WireColorByLayer =
	(
		LayerManager.closeDialog()
		
		for i = 0 to layerManager.count-1 do
		(
			local layer = ILayerManager.getLayerObject i
			local nodeArr
			
			layer.Nodes &nodeArr
			
			if nodeArr.count != 0  do
			(
				nodeArr.wireColor = ( this.GetRandomColor() )
			)
		)
	),
	
	fn WireColorByMaterial objArr:( GetCurrentSelection() ) =
	(
		if objArr.count == 0 then objArr = ( objects as array )
		
		for i = 1 to sceneMaterials.count do
		(
			for obj in objArr where obj.material == sceneMaterials[i] do ( obj.wireColor = ( this.GetRandomColor() ) )
		)
	),
	
	fn WireColorByObjId objArr:( GetCurrentSelection() ) =
	(
		if objArr.count == 0 then objArr = ( geometry as array )
		
		local objIdArr = for obj in objArr collect obj.gBufferChannel
			
		objIdArr = MakeUniqueArray objIdArr
		
		for id in objIdArr do
		(
			for obj in objArr where obj.gBufferChannel == id do ( obj.wireColor = ( this.GetRandomColor ) )
		)
	),
	
	fn WireColorByFaceID objArr:( GetCurrentSelection() ) =
	(
		if objArr.count == 0 then objArr = ( geometry as array )
			
		local matIdArr = ::MeshFns.GetUniqueMatIds objArr
		
		for id in matIdArr do
		(
			for obj in objArr where ( ::MeshFns.IsValidMesh obj ) and ( GetFaceMatId obj.mesh 1 ) == id do ( obj.wirecolor = ( this.GetRandomColor() ) )
		)
	),
	
	fn WirecolorByHierarchy objArr:( GetCurrentSelection() ) =
	(
		if objArr.count == 0 then objArr = ( objects as array )
			
		for obj in objArr do
		(
			local childArr = ::HierarchyFns.GetChildrenRecursive obj
			
			if childArr.count != 0 then
			(
				childArr.wireColor = ( this.GetRandomColor() )
			)
		)
	),
	
	fn WireColorByInstance objArr =
	(
		local procObjArr = #()
		
		for obj in objArr do
		(
			if ( findItem procObjArr obj ) == 0 then
			(
				local instanceArr = refs.dependentNodes obj.baseObject
				
				if instanceArr.count > 0 then
				(
					procObjArr += instanceArr
					
					instanceArr.wirecolor = ( this.GetRandomColor() )
				)
				else
				(
					i.wirecolor = (color 128 128 128)
				)
			)
		)
	),
	
	fn StoreWireColor objArr =
	(
		objArr = ::_mxs.EnsureArgIsArray objArr
		
		for obj in objArr do
		(
			::_userProps.SetProp obj "wirecolor" ( obj.wirecolor as string ) nameSpace:this.nameSpace
		)
		
		format "***** WireColor Stored *****\n"
	),
	
	fn RestoreWireColor objArr =
	(
		objArr = ::_mxs.EnsureArgIsArray objArr
		
		for obj in objArr do
		(
			local wColorStr = ( ::_userProps.GetProp obj "wirecolor" nameSpace:this.nameSpace )
			
			if wColorStr != undefined and ( ClassOf ( execute wColorStr ) ) == color then
			(
				obj.wirecolor = ( execute wColorStr )
			)
		)
		format "***** WireColor Restored *****\n"
	),
	
	fn GetModule =
	(
		( GetSourceFileName() )
	),

	fn Help =
	(
		::mxs.GetScriptHelp ( GetSourceFileName() )
	),

	private fn _init =
	(
		-- Pass
	),

	__init__ = _init()
)

WireColorFns = WireColorFns()