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


::EnsureObjectClass = ""


mxs.using "Logger"


struct EnsureObjectClass
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This is an instanceable object that takes will convert an inputed 3dsmax object
	to an inputed 3dsmax Object Class. It stores the objects original class and
	provides a method to restore it.
	
	Use this struct when running logic that requires a specific object class
	
	Members:
		[Var] obj
		[Var] objClass : Class you want the inputed object to be
		[Var] targetClass : Original class of the inputed object
	
		[FN] ConvertToClass
		[FN] GetModule
		[FN] Restore
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public

	-- Required Fields
	obj,
	targetClass,
	
	--
	objClass,
	
	
	fn ConvertToClass obj cls =
	(
		/*DOC_--------------------------------------------------------------------
		Converts the object to the class if it's possible
		
		Args:
			obj (NODE)
			cls (3dsmax Object Class)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "ConvertToClass {1} {2}" args:#(obj, cls) cls:this
		
		if ( CanConvertTo obj cls ) then
		(
			::Logger.info "Converting {1} to {2}" args:#(obj, cls) cls:this
			ConvertTo obj cls
		)
		else
		(
			::Logger.error "Cannot convert {1} to {2}" args:#(obj, cls) cls:this
		)
	),
	
	fn Restore =
	(
		/*DOC_--------------------------------------------------------------------
		Convert the inputed object back to its original class
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if this.objClass != ( ClassOf this.obj ) then
		(
			this.ConvertToClass this.obj this.objClass
		)
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
		
		if this.obj == undefined then
		(
			return "EnsureObjectClass requires a valid object passed to the <obj> flag"
		)
		if this.targetClass == undefined then
		(
			return "EnsureObjectClass requires a valid <Max Class> passed to the <targetClass> flag"
		)
		
		this.objClass = ( ClassOf obj )
		
		if ( this.objClass != this.targetClass ) then
		(
			this.ConvertToClass this.obj this.targetClass
		)
	),

	__init__ = _init()
)

