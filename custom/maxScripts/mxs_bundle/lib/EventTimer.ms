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


::EventTimer = ""


struct EventTimer
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This is a callable object that can be used to track the time taken
	between tasks.
	
	Create an instance of an EventTimer object, then run process, then 
	call End() on the EventTimer object. You'll get a printed message of
	the time taken to run the process.
	
	Members:
		[Var] caption
		
		[FN] End
		[FN] GetModule
		[FN] help
		[FN] start
	
	Example:
		-- The Start method is called upon instantiation. Best practice is to define the caption parameter at the time of instantiation. 
		
		assetPublishTimer = ::EventTimer caption:"Asset Publish"
		< Logic for asset publish >
		assetPublishTimer.End()
		>>> Asset Publish took 32.066s
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	caption = "Event",
	
	
	fn Start =
	(
		/*DOC_--------------------------------------------------------------------
		Stores a timestamp value when called
		
		Returns:
			TimeStamp (integer)
		
		--------------------------------------------------------------------_END*/
		
		this._eventStart = TimeStamp()
	),
	
	fn End =
	(
		/*DOC_--------------------------------------------------------------------
		Takes a timestamp value and compares it to the timestamp value stored
		from the Start method. Prints the time delta to the listener in a readable format.
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( classOf this._eventStart == integer ) then
		(
			this._eventEnd = TimeStamp()
			
			local dTime = (( this._eventEnd - this._eventStart )/1000.0 )
			
			if dTime > 60 then
			(
				format "% took: %m\n" caption (dTime/60.0)
			)
			else
			(
				format "% took: %s\n" caption dTime
			)
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
	
	_eventStart,
	_eventEnd,
	
	fn _init =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.Start()
	),
	
	__init__ = _init()
)
