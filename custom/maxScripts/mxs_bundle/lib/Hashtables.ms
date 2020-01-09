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


::HashTables = ""


struct HashTables
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	Helper methods for working with DotNet HashTables
	
	Members:
		[FN] DotNetArrayToMxsArray
		[FN] GetDictKeys
		[FN] GetDictValues
		[FN] GetKeyFromValue
		[FN] GetModule
		[FN] MakeDict
		[FN] MxsArrayToDotNetArray
		[FN] PrintDnetDict
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	fn PrintDnetDict dict toStr: =
	(
		/*DOC_--------------------------------------------------------------------
		Print out the Key/Value pairs of a DotNet Hashtable
		
		Args:
			dict (DotNet HashTable)
		
		Kwargs:
			toStr (StringStream) : Optional StringStream object to format to
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		local denum = dict.GetEnumerator()
		
		while ( denum.MoveNext() ) do
		(
			local iKey = denum.Current
			
			case toStr of
			(
				(unsupplied):format "% = %\n" iKey.Key iKey.Value
				default:format "% = %\n\r" iKey.Key iKey.Value to:toStr
			)
		)
	),
	
	fn GetDictKeys dict =
	(
		/*DOC_--------------------------------------------------------------------
		Collect the keys of a hash table. Returns an array of string values.
		
		Args:
			dict (DotNet HashTable)
		
		Returns:
			(array[string])
		
		--------------------------------------------------------------------_END*/
		
		local denum = dict.GetEnumerator()
		local out = #()
		
		while ( denum.MoveNext() ) do
		(
			local iKey = denum.Current
			
			append out iKey.Key
		)
		
		out
	),

	fn GetDictValues dict =
	(
		/*DOC_--------------------------------------------------------------------
		Collect the values of a hash table. Returns an array of string values.
		
		Args:
			dict (DotNet HashTable)
		
		Returns:
			(array[string])
		
		--------------------------------------------------------------------_END*/
		
		local denum = dict.GetEnumerator()
		local out = #()
		
		while ( denum.MoveNext() ) do
		(
			local iKey = denum.Current
			
			append out iKey.Value
		)
		
		out
	),

	fn GetKeyFromValue dict val =
	(
		/*DOC_--------------------------------------------------------------------
		Reverse lookup to find the key matching the inputed value
		
		Args:
			dict (DotNet HashTable)
			val (valid HashTable value)
		
		Returns:
			key (string | undefined)
		
		--------------------------------------------------------------------_END*/
		
		local denum = dict.GetEnumerator()
		
		while ( denum.MoveNext() ) do
		(
			local iKey = denum.Current
			
			if iKey.Value == val then
			(
				return iKey.Key
			)
		)

		undefined
	),
	
	fn MakeDict keys:#() vals:#() =
	(
		/*DOC_--------------------------------------------------------------------
		Makes a dictionary from the inputed keys and vals arrays.
		
		Kwargs:
			keys (array[string])
			vals (array[valid data type])
		
		Returns:
			(DotNet Hashtable)
		
		--------------------------------------------------------------------_END*/
		
		if keys.count != vals.count then
		(
			messageBox "MakeDict:\nThere must be the same number of items for both \"keys\" and \"vals\"" title:"HashTables:"
			return undefined
		)
		
		local dict = dotNetObject "System.Collections.Hashtable"
		
		for i = 1 to keys.count do
		(
			dict.Add keys[i] vals[i] 
		)
		
		out
	),
	
	fn MxsArrayToDotNetArray arr =
	(
		/*DOC_--------------------------------------------------------------------
		Converts a MaxScript array into a DotNet array. 
		
		Large Maxscript arrays cannot be stored in a HashTable, but we can convert to a
		DotNet array and that works just fine. Becuase reasons...
		
		Args:
			arr (MaxScript Array)
		
		Returns:
			(DotNetArray)
		
		--------------------------------------------------------------------_END*/
		
		if arr.count == 0 then return #()
		
		local dNetArr = undefined
		local baseClass = ( ClassOf arr[1] )
		
		case baseClass of
		(
			( BooleanClass ): dNetArr = dotNetObject "System.Boolean[]" arr.count
			( Integer ): dNetArr = dotNetObject "System.Int32[]" arr.count
			( String ): dNetArr = dotNetObject "System.String[]" arr.count
			( Float ): dNetArr = dotNetObject "System.Single[]" arr.count
			default:
			(
				format "***** Array component class not supported: % index:% *****\n" arr[1] 1
				return #()
			)
		)
		
		for i = 0 to (arr.count - 1) do
		(
			local dNetVal = undefined
			local dNetIndex = dotNetObject "System.Int32" i
			
			case baseClass of
			(
				( BooleanClass ): dNetVal = dotNetObject "System.Boolean" arr[i+1]
				( Integer ): dNetVal = dotNetObject "System.Int32" arr[i+1]
				( String ): dNetVal = dotNetObject "System.String" arr[i+1]
				( Float ): dNetVal = dotNetObject "System.Single" arr.count
				default:
				(
					format "***** Array component class not supported: % index:% *****\n" arr[i+1] i
					dNetVal = undefined
				)
			)
			
			dNetArr.SetValue dNetVal dNetIndex
		)
		
		dNetArr
	),

	fn DotNetArrayToMxsArray dotNetArr =
	(
		/*DOC_--------------------------------------------------------------------
		Convert large DotNet arrays back into MaxScript arrays
		
		Args:
			dotNetArr (DotNetArray)
		
		Returns:
			(MaxScript array)
		
		--------------------------------------------------------------------_END*/
		
		
		local mxsArr = #()
		mxsArr.count = dotNetArr.Length
		
		for i = 0 to ( dotNetArr.Length - 1 ) do
		(
			mxsArr[i+1] = ( dotNetArr.GetValue i )
			
		)
		
		mxsArr
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

HashTables = HashTables()