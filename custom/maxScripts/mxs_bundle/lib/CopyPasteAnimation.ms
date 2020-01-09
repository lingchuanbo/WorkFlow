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

Constructor: CopyPasteAnimation
Instantiated Global: CopyPasteAnimation

Methods:

CopyPasteAnim <from_obj> <to_obj>


__END__
*/





struct CopyPasteAnimation
(
public
	
	fn CopyAnimation obj =
	(
		local out = #()
		--position
		append out obj.pos.x_position.controller.keys
		append out obj.pos.y_position.controller.keys
		append out obj.pos.z_position.controller.keys
		
		--rotation
		append out obj.rotation.x_rotation.controller.keys
		append out obj.rotation.y_rotation.controller.keys
		append out obj.rotation.z_rotation.controller.keys
		
		--scale
		obj.Scale.Controller = ScaleXYZ()
		append out obj.scale.x_scale.controller.keys
		append out obj.scale.y_scale.controller.keys
		append out obj.scale.z_scale.controller.keys
		
		out
	),

	fn AppendKeys from_obj_anim to_obj_anim =
	(
		for x = 1 to from_obj_anim.count do
		(
			for i = 1 to from_obj_anim[x].count do
			(
				appendKey to_obj_anim[x] from_obj_anim[x][i]
			)
		)
	),

	fn CopyPasteAnim from_obj to_obj =
	(
		deleteKeys to_obj #allKeys
		
		from_obj_anim = this.CopyAnimation from_obj
		to_obj_anim = this.CopyAnimation to_obj
		
		this.AppendKeys from_obj_anim to_obj_anim
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
		
	),

	__init__ = _init()
)

CopyPasteAnimation = CopyPasteAnimation()


