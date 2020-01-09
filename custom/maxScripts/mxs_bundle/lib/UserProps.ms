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
Website: www.gtvfx.com
Email: gthompson@gtvfx.com
__END__
***************************************************************************************************/


::UserProps = ""


mxs.using "HashTables"


struct UserProps
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	Various methods for working with the UserPropBuffer
	
	Members:
		[FN] ClearUserPropBuffer
		[FN] CollectAllNameSpaces
		[FN] DictionaryToUserPropBuffer
		[FN] EnsureNameSpace
		[FN] EnsurePropBuffer
		[FN] FilterPropBufferDict
		[FN] FormatPropStringFromDict
		[FN] GetModule
		[FN] GetProp
		[FN] HasNameSpace
		[FN] HashPropBufferString
		[FN] PropBufferStringToDictionary
		[FN] QsortAphlabetical
		[FN] RemoveNameSpaceGroup
		[FN] RemoveUserPropItem
		[FN] SetProp
		[FN] SortObjectsByUserPropBuffer
		[FN] SortPropBuffer
		[FN] UserPropBufferToDictionary
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	fn QsortAphlabetical str1 str2 =
	(
		/*DOC_--------------------------------------------------------------------
		Qsort filter function for sorting string values alphabetically
		
		Usage:
			Qsort <array[String]> QsortAphlabetical
		
		Args:
			str1 (string)
			str2 (string)
		
		Returns:
			index
		
		--------------------------------------------------------------------_END*/
		
		case of
		(
			(str1 < str2): -1
			(str1 > str2): 1
			default: 0
		)
	),
	
	fn HasNameSpace str =
	(
		/*DOC_--------------------------------------------------------------------
		Tests the inputed string for a namespace separator
		
		Currently assumes that a colon ':' in a string is denoting a namespace separation
		
		Args:
			str (string)
		
		Returns:
			Boolean
		
		--------------------------------------------------------------------_END*/
		
		out = ( MatchPattern str pattern:"*:*" )
	),
	
	fn EnsurePropBuffer obj =
	(
		/*DOC_--------------------------------------------------------------------
		Ensures that the last character of the UserPropBuffer is a new line
		
		Args:
			obj (Node)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		local propBuffer = ( GetUserPropBuffer obj )
	
		if ( propBuffer[propBuffer.count] != "\n" ) then
		(
			SetUserPropBuffer obj ( propBuffer + "\n" )
		)
	),
	
	fn EnsureNameSpace nameSpaceStr =
	(
		/*DOC_--------------------------------------------------------------------
		Ensures that the inputed nameSpaceStr, if valid, ends with a colon
		
		Args:
			nameSpaceStr (string)
		
		Returns:
			nameSpaceStr (string)
		
		--------------------------------------------------------------------_END*/
		
		if ( nameSpaceStr != "" ) and ( nameSpaceStr[nameSpaceStr.count] != ":" ) then ( nameSpaceStr += ":" )
		
		nameSpaceStr
	),
	
	fn ClearUserPropBuffer obj =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the UserPropBuffer of the inputed object to an empty string
		
		Args:
			obj (Node)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		SetUserPropBuffer obj ""
	),
	
	fn HashPropBufferString propStr =
	(
		/*DOC_--------------------------------------------------------------------
		Returns a hashcode of the inputed string
		
		Used for fast comparison of one string to another
		
		Args:
			propStr (string)
		
		Returns:
			String : HashCode as string
		
		--------------------------------------------------------------------_END*/
		
		local out = ( dotNetObject "System.String" ( propStr as string ) ).GetHashCode()
		( out as string )
	),
	
	fn SetProp obj propKey propVal nameSpace:"" overwrite:True =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the property on the inputed object.
		
		Options to add a namespace
		
		If overwrite is set to False then this will check for the property on the object first.
		If it already exist then this method will simply return True without changing the value
		
		Args:
			obj (Node)
			propKey (string)
			propVal (string)
		
		Kwargs:
			nameSpace (string)
			overwrite (boolean)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		nameSpace = this.EnsureNameSpace nameSpace
		
		propKey = ( nameSpace + propKey )
		
		if not overwrite and ( GetUserProp obj propKey ) != undefined then
		(
			::Logger.error "{1} is already a property of {2}" args:#(propKey, obj.name) cls:this
			
			return True
		)
		
		SetUserProp obj ( propKey ) ( propVal as string )
	),
	
	fn GetProp obj propKey nameSpace:"" =
	(
		/*DOC_--------------------------------------------------------------------
		Returns the property from the object. Will concatenate the namespace
		onto the property.
		
		Args:
			obj (Node)
			propKey (string)
		
		Kwargs:
			nameSpace (string)
		
		Returns:
			String | undefined
		
		--------------------------------------------------------------------_END*/
		
		if nameSpace != "" and namespace[nameSpace.count] != ":" then nameSpace += ":"
		format "PropKey: %\n" ( nameSpace + propKey )
		GetUserProp obj ( nameSpace + propKey )
	),
	
	fn PropBufferStringToDictionary propString =
	(
		/*DOC_--------------------------------------------------------------------
		Parses the inputed propString into Key/Value pairs in a DotNet Hashtable
		
		Args:
			propString (string)
		
		Returns:
			DotNet Hashtable
		
		--------------------------------------------------------------------_END*/
		
		local propStringArr = ( FilterString propString "\n\r" )
		
		local dict = dotNetObject "System.Collections.Hashtable"
		
		for i in propStringArr do
		(
			local keyVal = ( FilterString i "=" )
			
			if keyVal[1][keyVal[1].count] == " " then keyVal[1] = ( replace keyVal[1] keyVal[1].count 1 "" )
			
			if keyVal[2][1] == " " then keyVal[2] = ( replace keyVal[2] 1 1 "" )
			
			if not ( dict.ContainsKey keyVal[1] ) then
			(
				dict.add keyVal[1] keyVal[2]
			)
		)
		
		dict
	),
	
	fn UserPropBufferToDictionary obj =
	(
		/*DOC_--------------------------------------------------------------------
		Calls PropBufferStringToDictionary with the UserPropBuffer of the
		inputed object.
		
		Args:
			obj (Node)
		
		Returns:
			DotNet Hashtable
		
		See Also:
			PropBufferStringToDictionary
		
		--------------------------------------------------------------------_END*/
		
		this.PropBufferStringToDictionary ( GetUserPropBuffer obj )
	),
	
	fn DictionaryToUserPropBuffer dict obj overwrite:True clean:True =
	(
		/*DOC_--------------------------------------------------------------------
		Converts a DotNet Hashtable of simple Key/Value pairs of string values
		into the PropBuffer of the inputed object.
		
		Args:
			dict (DotNet Hashtable)
			obj (Node)
		
		Kwargs:
			overwrite (boolean) : controls the overwrite flag on the SetProp method
			clean (boolean) : If True then run the ClearUserPropBuffer method before setting any props
		
		Returns:
			VOID
		
		See Also:
			ClearUserPropBuffer
			SetProp
		
		--------------------------------------------------------------------_END*/
		
		local keyArr = ::HashTables.GetDictKeys dict
		Qsort keyArr this.QsortAphlabetical
		
		if clean then
		(
			this.ClearUserPropBuffer obj
		)
		
		for k in keyArr do
		(
			this.SetProp obj k dict.item[k] nameSpace:"" overwrite:overwrite 
		)
	),
	
	fn FormatPropStringFromDict propDict = 
	(
		/*DOC_--------------------------------------------------------------------
		Formats a StringStream of the Key/Values pairs fo the inputed DotNet Hashtable
		
		Args:
			propDict (DotNet Hashtable)
		
		Returns:
			String
		
		--------------------------------------------------------------------_END*/
		
		local keyArr = ::HashTables.GetDictKeys propDict
		Qsort keyArr this.QsortAphlabetical
		
		local str = StringStream ""
		
		for k in keyArr do
		(
			format "% = %\n\r" k propDict.item[k] to:str
		)
		
		::Logger.debug "{1}" args:#((str as string)) cls:this
		
		( str as string )
	),
	
	fn FilterPropBufferDict obj nameSpace:"" =
	(
		/*DOC_--------------------------------------------------------------------
		Returns a dictionary containing only the userPropBuffer items that match the supplied nameSpace
		
		Args:
			obj (Node)
		
		Kwargs:
			nameSpace (string)
		
		Returns:
			DotNet Hashtable
		
		--------------------------------------------------------------------_END*/
		
		local propDict = this.UserPropBufferToDictionary obj
		
		local dicKeyArr = ::HashTables.GetDictKeys propDict
		
		for dicKey in dicKeyArr do
		(
			if not ( matchPattern dicKey pattern:( nameSpace + "*" ) ) then
			(
				propDict.Remove dicKey
			)
		)
		
		propDict
	),
	
	fn SortPropBuffer obj =
	(
		/*DOC_--------------------------------------------------------------------
		Gets the UserPropBuffer of the inputed object. Sorts it alphabetically
		and reapplies it to the obejct
		
		Args:
			ARG1 (type)
		
		Returns:
			VOID
		
		See Also:
			UserPropBufferToDictionary
			DictionaryToUserPropBuffer
		
		--------------------------------------------------------------------_END*/
		
		local propDict = this.UserPropBufferToDictionary obj
		
		this.DictionaryToUserPropBuffer propDict obj overwrite:True clean:True
	),

	fn SortObjectsByUserPropBuffer objArr mode:#hash nameSpace:"" =
	(
		/*DOC_--------------------------------------------------------------------
		This returns a dictionary
				Key = ( Unique User Prop Buffer )
				
				mode can be either #hash or #name
				
				Depending on mode:
					Value:
						#hash = ( Array of node hash values from the GetHandleByAnim method )
						#name = ( Array of object names )
		
		Args:
			objArr (array[String])
		
		Kwargs:
			mode (name) : either #hash, or #name
			nameSpace (string)
		
		Returns:
			DotNet Hashtable : Key = Unique hash of the UserPropBuffer, Value = Array of Anim Handles or Object Names
		
		--------------------------------------------------------------------_END*/
		
		local dict = dotNetObject "System.Collections.Hashtable"
		
		for obj in objArr do
		(
			local propBufferDict = this.FilterPropBufferDict obj nameSpace:nameSpace
			local propBuffer = this.FormatPropStringFromDict propBufferDict
			
			if ( propBuffer == "" ) or ( propBuffer == OK ) then
			(
				propBuffer = "empty"
			)
			
			local val = undefined
				
			case mode of 
			(
				( #hash ):val = ( GetHandleByAnim obj )
				( #name ):val = ( obj.name )
			)
			
			local hashKey = this.HashPropBufferString propBuffer
			
			if dict.ContainsKey hashKey then
			(
				local valArr = dict.item[hashKey]
				
				dict.Remove hashKey
				
				append valArr val
				
				dict.add hashKey valArr
			)
			else
			(
				dict.add hashKey #(val)
			)
		)
		
		dict
	),
	
	fn RemoveNameSpaceGroup obj nameSpace =
	(
		/*DOC_--------------------------------------------------------------------
		This removes all properties from the UserPropBuffer of the inputed object
		that match the inputed nameSpace.
		
		Args:
			obj (Node)
			nameSpace (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		nameSpace = this.EnsureNameSpace nameSpace
		
		local propDict = this.UserPropBufferToDictionary obj
		local keyArr = ::HashTables.GetDictKeys propDict
		
		for k in keyArr do
		(
			if ( matchPattern k pattern:( namespace + "*" ) ) then
			(
				propDict.Remove k
			)
		)
		
		this.ClearUserPropBuffer obj
		this.DictionaryToUserPropBuffer propDict obj overwrite:True
	),
	
	fn RemoveUserPropItem obj propKey =
	(
		/*DOC_--------------------------------------------------------------------
		Removes the property form the UserPropBuffer matching the inputed
		propKey.
		
		Args:
			obj (Node)
			propKey (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		local propDict = this.UserPropBufferToDictionary obj
		
		if ( propDict.ContainsKey propKey ) then
		(
			propDict.Remove propKey
			
			this.DictionaryToUserPropBuffer propDict obj overwrite:True
		)
		else
		(
			format "***** Object prop buffer does not contain the value: % *****\n" propKey
		)
	),
	
	fn CollectAllNameSpaces propDict =
	(
		/*DOC_--------------------------------------------------------------------
		Looks through all of the keys in the inputed DotNet Hashtable and
		filters them for a namespace. Collects a unique array of namespace strings
		
		Args:
			propDict (DotNet Hashtable)
		
		Returns:
			array[string]
		
		--------------------------------------------------------------------_END*/
		
		local keyArr = ::HashTables.GetDictKeys propDict
		local nameSpaceArr = #()
		
		for k in keyArr do
		(
			if ( matchPattern k pattern:"*:*" ) then
			(
				local strArr = ( FilterString k ":" )
				
				appendIfUnique nameSpaceArr strArr[1]
			)
		)
		
		nameSpaceArr
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

UserProps = UserProps()