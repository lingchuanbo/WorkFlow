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

Constructor: CreateTopNull
Instantiated Global: CreateTopNull

Methods:

	CreateTopNull <objArr> :
		-Takes an array of objects as an argument
		-The objArr is filtered to return top level nodes within the objArr
		-A point helper is created at the Center/Min point of the objArr bounding box
		-The filtered nodes are set as the children of the new point helper
		-The point helper name is set to \"_topNull\" and should be manually changed


__END__
*/


mxs.Using "GenFns"

struct CreateTopNull
(
	fn FilterObjArrForTopLevelNodes objArr =
	(
		out = #()
		
		for i in objArr do
		(
			if i.parent == undefined then
			(
				append out i
			)
			else
			(
				if (findItem objArr i.parent == 0) then
				(
					append out i
				)
			)
		)
		out
	),
	
	fn CreateTopNull objArr =
	(
		local objArr = this.FilterObjArrForTopLevelNodes objArr
		
		if objArr.count == 0 then
		(
			self.msg = "The objects for the top null are not defined\nYou need to make a selection"
			return undefined
		)
		
		::mxs.blockui True
		
		local cenPointZmin = _GenFns.GetLocalizedBasePoint objArr
		local pCtrl = Point name:(uniqueName "_TopNull") pos:cenPointZmin wirecolor:(color 0 255 255)
		
		::MxsCommonFns.SetParent_mapped objArr pCtrl _replace:True
		
		while (mxs.blockui False).count != 0 do mxs.blockui False
		
		pCtrl
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
		this.ClassUsage()
	),

	__init__ = _init()
)
	
CreateTopNull = CreateTopNull()
