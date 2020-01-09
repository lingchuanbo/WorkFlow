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

Constructor: PurgeVrayOCIO
Instantiated Global: PurgeVrayOCIO

[METHODS]
	PurgeVRayOCIO:
		- Finds all VRayOCIO nodes and removes them from the shader tree
	
	DisableVrayOcio:
		- Sets the In and Out color space to the same values to create a pass-through effect
		
		
[DESCRIPTION]


[USAGE]


__END__
*/



struct PurgeVrayOCIO
(
public
	
	debug = False,
	
	
	fn CollectMaps target:unsupplied =
	(
		( GetClassInstances VRayOCIO asTrackViewPick:True target:target )
	),
	
	fn GetRefObjects trackPickObj =
	(
		local out = #()
		
		local refsArr = ( refs.Dependents trackPickObj.anim )
		
		local matArr = for i in refsArr where ( SuperClassOf i == Material ) and ( ( ClassOf i ) != MultiMaterial ) collect i
		out += matArr
		
		local texArr = for i in refsArr where ( SuperClassOf i == TextureMap ) collect i
		out += texArr
			
		out = ( MakeUniqueArray out )
		
		out
	),
	
	fn GetUsedSubMaps mat_or_map =
	(
		local out = #()
		
		local numSubTexmaps = ( GetNumSubTexmaps mat_or_map )
		
		for i = 1 to numSubTexmaps do
		(
			local tMap = ( GetSubTexmap mat_or_map i )
			
			if tMap != undefined then
			(
				append out #( tMap , i )
			)
		)
		
		out
	),
	
	fn PurgeVRayOCIO target:unsupplied =
	(
		local trackPickArr = this.CollectMaps target:target
		
		for trackPick in trackPickArr do
		(
			local refObjs = this.GetRefObjects trackPick
			
			for ref in refObjs do
			(
				local subMaps = this.GetUsedSubMaps ref
				
				for map in subMaps do
				(
					if this.debug then ( format "***** mapTuple: % *****\n" map )
					
					if ( map[1] == ( trackPick.anim ) ) then
					(
						if this.debug then ( format "***** Found VRayOCIO match *****\n" )
						
						local subMap = ( GetSubTexMap map[1] 1 )
						
						SetSubTexmap ref map[2] subMap
					)
				)
			)
		)
	),
	
	fn DisableVrayOcio target:unsupplied use:#in =
	(
		local trackPickArr = this.CollectMaps target:target
		
		for trackPick in trackPickArr do
		(
			case use of
			(
				( #in ):
				(
					trackPick.anim.colorspace_out = trackPick.anim.colorspace_in
				)
				( #out ):
				(
					trackPick.anim.colorspace_in = trackPick.anim.colorspace_out
				)
			)
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


PurgeVrayOCIO = PurgeVrayOCIO()


