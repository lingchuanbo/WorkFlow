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

Constructor: ProceduralRcMenu
Instantiated Global: pMenu

[METHODS]

[DESCRIPTION]

[USAGE]

__END__
*/



struct ProceduralRcMenu
(
public
	
	debug = False,
	
	-- regex with legal characters for menu item names
	rgx_menuItem = dotnetobject "System.Text.RegularExpressions.Regex" "[a-zA-Z0-9_]",
	
	fn ValidateMenuItemName _itemName regex:this.rgx_menuItem =
	(
		/* 
		This function is used during the programatic building of the rcmenu
		
		the _timeName arg is meant to be the Object.name. This function compares each character in the name with a regex and strips out characters that are invalid ofr menu item names
		
		It appends the string 'item_' to the beginning to handle cases where the object name is made up of only numbers.
		It then appends a random number to the end of the item name to help ensure the uniqueness of the name.
		 */
		local nameArr = for i = 1 to _itemName.count collect _itemName[i]
			
		for n in nameArr do
		(
			if not ( this.rgx_menuItem.isMatch n ) then
			(
				_itemName = SubstituteString _itemName n ""
			)
		)
		
		local out = ( "item_" + ( _itemName as string ) + ( ( random 0 9999999 ) as string ) )
	),
	
	fn SelectionMenu objArr =
	(
		/* 
		This programatically creates a pop-up menu with the names of all objects containing illegal characters
		
		This code concatenates a string that makes up the code for an rcmenu with a unique item for each object.
		 */
		
		local rcTxt = "rcmenu pop_m\n(\n%\n%)\n"
		local st = stringStream ""
		local items = ""
		local events = ""
		
		for obj in objArr do
		(
			local itemStr = stringStream ""
			local mItem = stringStream ""
			local mEvent = stringStream ""
			local itemName = ( this.ValidateMenuItemName obj.name )
			
			format "\tmenuItem %_item \"%\"\n" itemName obj.name to:mItem
			
			format "\ton %_item picked do (select (GetNodeByName (\"%\")))\n" itemName obj.name to:mEvent
			
			format "%\n" ( mItem as string ) to:itemStr
			
			items += itemStr as string 
			events += mEvent as string
			----
		)
		
		format rcTxt items events to:st
		
		if this.debug then
		(
			format "===== PopUp Menu =====\n"
			format "%" ( st as string )
		)
		
		local m = execute ( st as string )
		popUpMenu m pos:mouse.screenPos
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

pMenu = ProceduralRcMenu()
