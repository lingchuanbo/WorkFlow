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


::Logger = ""
::PYTHON_RETURN -- Global variable for return values from the Python interface


mxs.Using "HashTables"


struct Logger
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This module manages logging, both in the Listener and
	writing output to log files on disk.
	
	Members:
		[Var] Enum_LevelVal = (Enum_LevelVal none:0 info:1 debug:2)
		[Var] Enum_LoggerLevel = (Enum_LoggerLevel none:#none info:#info debug:#debug)
		[Var] sys = <module 'sys' (built-in)>
		
		[FN] CleanUpLogs
		[FN] CollectOldFiles
		[FN] Critical
		[FN] DumpListenerTextToFile
		[FN] EnableLogging
		[FN] EndLogging
		[FN] GetEffectiveLevel
		[FN] GetLogDir
		[FN] GetLogFilepath
		[FN] GetModule
		[FN] GetVerbosity
		[FN] IsEnabledFor
		[FN] OpenLogDir
		[FN] SetLevel
		[FN] SetVerbosity
		[FN] debug
		[FN] error
		[FN] format
		[FN] help
		[FN] info
		[FN] log
		[FN] warning
	
	__END__
	--------------------------------------------------------------------_END*/
	
public

	-- All output is done through sys.stdout and sys.stderr
	sys = python.import "sys",
	
	Enum_LoggerLevel, 
	Enum_LevelVal,


	fn DumpListenerTextToFile filepath =
	(
		/*DOC_--------------------------------------------------------------------
		Collects the entire string stream of the MaxScript Listener and writes
		it out to a text file at the inputed filepath.
		
		Args:
			filepath (string) : Path to text file to write the log to
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		-- 3dsmax has a really slow write speed to the network ( Seems most prevelant on ISOLON storage )
		-- writing local and copying up is a fast work-around
		local temp_file = (( GetDir #temp ) + "\\mxs_log.log" )

		if ( DoesFileExist temp_file ) then
		(
			DeleteFile temp_file
		)

		if ( DoesFileExist filepath ) then
		(
			DeleteFile filepath
		)

		-- This has to be a gloabal variable, because reasons
		global ListenerText -- Declare variable to capture the Listener to
		SetListenerSel #(0,-1) -- Select all the text
		::ListenerText = GetListenerSelText() -- Get selected text

		local strm = openFile temp_file mode:"w"
		format ( ListenerText as string ) to:strm
		close strm

		-- Copy the local file to the desired filepath
		CopyFile temp_file filepath
		
		-- stdout the full listener
		this.sys.stdout.write( ListenerText as string )
		
		-- Clear the global from memory
		::ListenerText = undefined
		
		format "----- Listener log dumped to: % -----\n" filepath
	),

	fn EndLogging =
	(
		/*DOC_--------------------------------------------------------------------
		Flushes and closes the log
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		flushLog() -- ensures that we push everything from the listener inot the log file before closing
		closeLog()
	),

	fn EnableLogging filepath =
	(
		/*DOC_--------------------------------------------------------------------
		Ends any open logging stream and begins a new one that ouputs to
		the inputed filepath.
		
		Args:
			filepath (string) : Path to text file to write the log to
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.EndLogging()
		openLog filepath mode:"w" outputOnly:False
	),

	fn GetLogDir =
	(
		/*DOC_--------------------------------------------------------------------
		Get a default directory for writing out logs
		Creates a directory in the #temp path for the Logger log files
		
		Returns:
			logDir: (string) : Path to the default Logger directory
		
		--------------------------------------------------------------------_END*/
		
		local logDir = ( GetDir #temp ) + @"\Logger\"
		MakeDir logDir
		logDir
	),

	fn GetLogFilepath =
	(
		/*DOC_--------------------------------------------------------------------
		Derives a unique filename for the log file in the default log directory
		
		Returns:
			(string) : Path to unique log file
		
		--------------------------------------------------------------------_END*/
		
		local base_filename = "Logger"
		local file_xt = ".log"
		
		local filename = base_filename + "_" + ( ::mxs.DateTime pathFriendly:True ) + file_xt
		
		( ( this.GetLogDir() ) + filename )
	),

	fn CollectOldFiles dir threshold_days:12 =
	(
		/*DOC_--------------------------------------------------------------------
		Collects files in the inputed dir that are older than the inputed threshold_days
		
		Args:
			dir (string) : Directory to collect files from
		
		Kwargs:
			threshold_days (integer) : age of files in days
		
		Returns:
			(array[string]) : Array of file paths
		
		--------------------------------------------------------------------_END*/
		
		local pyCmd = StringStream ""

		format "
import os, time

def collect_old_files(file_dir, threshold_days=None):
	if threshold_days == None:
		threshold_days = 0

	threshold_time = ( time.time() ) - ( 60 * 60* 24 * threshold_days )

	file_list = [os.path.join(file_dir, f) for f in os.listdir(file_dir) if '.log' in f and ( os.path.getmtime(os.path.join(file_dir, f)) <= threshold_time )]

	return file_list



files = collect_old_files(r'%', %)

arr = '#({0})'.format(','.join([str('@\"'+str(n)+'\"') for n in files]))
MaxPlus.Core.EvalMAXScript('PYTHON_RETURN = {0}'.format(arr))

		" ( TrimRight dir "\\" ) threshold_days to:pyCmd

		python.execute ( pyCmd as string )

		::PYTHON_RETURN
	),

	fn CleanUpLogs threshold_days:12 =
	(
		/*DOC_--------------------------------------------------------------------
		Collects all log files in the default location that are older than the inputed
		threshold_days and deletes them.
		
		Kwargs:
			threshold_days (integer) : age of files in days (type)
		
		Returns:
			(VOID)
		
		See Also:
			CollectOldFiles
		
		--------------------------------------------------------------------_END*/
		
		local old_files = this.CollectOldFiles ( this.GetLogDir() ) threshold_days:threshold_days

		if old_files.count != 0 then
		(
			this.info "Cleaning up {1} old logs" args:#(old_files.count) cls:this

			for f in old_files do
			(
				try
				(
					DeleteFile f
				)
				catch
				(
					this.Error "Unable to clean up {1}" args:#(f) cls:this
				)
			)
		)
	),

	fn OpenLogDir =
	(
		/*DOC_--------------------------------------------------------------------
		Opens the directory of the default log directory
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		ShellLaunch ( this.GetLogDir() ) ""
	),

	fn SetLevel lvl =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the Log Level to the inputed lvl
		
		Args:
			lvl (integer | name) : Takes either an integer value or named value
		
		Returns:
			vals: (array[#name, integer]) : vals array index[1] = #name, index[2] = integer
		
		--------------------------------------------------------------------_END*/
		
		local vals = this.GetLevelValues lvl
		
		if ( vals != undefined ) then
		(
			this.level = vals[1]
			level_val = vals[2]
		)
		
		vals
	),

	fn SetVerbosity v =
	(
		/*DOC_--------------------------------------------------------------------
		Set the verbosity to the inputed integer.
		If input exceeds maximum value then an error message is printed letting
		the user know that verbosity will be set to the maximum allowable value.
		
		Args:
			v (integer)
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( v > this._maxVerbosity ) then
		(
			this.error "Maximum verbosity is {1}, setting to maximum" args:#( (this._maxVerbosity as string) ) cls:this
			this.verbosity = this._maxVerbosity
		)
		else
		(
			this.verbosity = v
		)
	),

	fn IsEnabledFor lvl =
	(
		/*DOC_--------------------------------------------------------------------
		Checks of the inputed lvl is enabled for output.
		
		Args:
			lvl (integer | name) : Takes either an integer value or named value
		
		Returns:
			(Boolean)
		
		--------------------------------------------------------------------_END*/
		
		local lvlVals = this.GetLevelValues lvl
		if ( lvlVals == undefined ) then return undefined
		
		lvl = lvlVals[1]
		
		case lvl of
		(
			( this.Enum_LoggerLevel.none ):
			(
				this.level == lvl
			)
			( this.Enum_LoggerLevel.info ):
			(
				if ( this.level == lvl ) or ( this.level == ( this.Enum_LoggerLevel.debug ) ) then
				(
					true
				)
				else
				(
					false
				)
			)
			( this.Enum_LoggerLevel.debug ):
			(
				this.level == lvl
			)
		)
	),

	fn GetEffectiveLevel =
	(
		/*DOC_--------------------------------------------------------------------
		Returns a value array of the current log level
				
		Returns:
			(array[#name, integer]) : vals array index[1] = #name, index[2] = integer
		
		--------------------------------------------------------------------_END*/
		
		#(this.level, this.level_val)
	),

	fn GetVerbosity =
	(
		/*DOC_--------------------------------------------------------------------
		Get the current verbosity level
		
		Returns:
			(integer) : Current verbosity level
		
		--------------------------------------------------------------------_END*/
		
		this.verbosity
	),

	fn Debug msg args:#() kwargsDict: verbosity:1 cls: =
	(
		/*DOC_--------------------------------------------------------------------
		Prints out the inputed msg if the log level is set to #debug with matching verbosity level
		
		Args:
			msg (string)
		
		Kwargs:
			args (array['string])
			kwargsDict (DotNet Hashtable) : You can pas a hastable as kwargs to format to the inputed msg
			verbosity (integer)
			cls (struct) : default unsupplied. Fill in the 'this' keyword when calling from within a struct
		
		Returns:
			(Void)
		
		--------------------------------------------------------------------_END*/
		
		if ( verbosity <= this.verbosity ) then
		(
			if ( this.GetEffectiveLevel() )[1] == ( this.Enum_LoggerLevel.debug ) then
			(
				if ( args.count != 0 ) then
				(
					msg = this.format msg args:args
				)
				
				local extraStr = ""
				
				if ( kwargsDict != unsupplied ) and ( ClassOf kwargsDict == dotNetObject ) then
				(
					extraStr = " " + this.ConcatStrFromHashtable kwargsDict
				)
				
				if ( cls != unsupplied ) then cls = ( this.GetClassTitle cls ) else cls = ""
				
				local log_str = StringStream ""
				
				format "DEBUG :: [%] *----- % -----*\n" cls ( msg + extraStr ) to:log_str
				
				this.sys.stdout.write( log_str as string )
			)
		)
	),

	fn Info msg args:#() kwargsDict: cls: =
	(
		/*DOC_--------------------------------------------------------------------
		Prints out the inputed msg if the log level is set to #info or higher
		
		Args:
			msg (string)
		
		Kwargs:
			args (array['string])
			kwargsDict (DotNet Hashtable) : You can pas a hastable as kwargs to format to the inputed msg
			cls (struct) : default unsupplied. Fill in the 'this' keyword when calling from within a struct
		
		Returns:
			(Void)
		
		--------------------------------------------------------------------_END*/
		
		if ( this.GetEffectiveLevel() )[2] != ( this.Enum_LoggerLevel.none ) then
		(
			if ( args.count != 0 ) then
			(
				msg = this.format msg args:args
			)

			local extraStr = ""

			if ( kwargsDict != unsupplied ) and ( ClassOf kwargsDict == dotNetObject ) then
			(
				extraStr = " " + this.ConcatStrFromHashtable kwargsDict
			)

			if ( cls != unsupplied ) then cls = ( this.GetClassTitle cls ) else cls = ""

			local log_str = StringStream ""

			format "INFO :: [%] ***** % *****\n" cls ( msg + extraStr ) to:log_str

			this.sys.stdout.write( log_str as string )
		)
	),

	fn Warning msg args:#() kwargsDict: cls: message:True =
	(
		/*DOC_--------------------------------------------------------------------
		Prints out the inputed msg as an error ( red text in listener window )
		
		Args:
			msg (string)
		
		Kwargs:
			args (array['string])
			kwargsDict (DotNet Hashtable) : You can pas a hastable as kwargs to format to the inputed msg
			cls (struct) : default unsupplied. Fill in the 'this' keyword when calling from within a struct
			message (boolean) : if True then a messageBox is displayed
		
		Returns:
			(Void)
		
		--------------------------------------------------------------------_END*/
		
		if ( args.count != 0 ) then
		(
			msg = this.format msg args:args
		)

		local extraStr = ""

		if ( kwargsDict != unsupplied ) and ( ClassOf kwargsDict == dotNetObject ) then
		(
			extraStr = " " + this.ConcatStrFromHashtable kwargsDict
		)

		if ( cls != unsupplied ) then cls = ( this.GetClassTitle cls ) else cls = ""

		if message then
		(
			messageBox ( msg + extraStr ) title:( cls + ":" )
		)

		local log_str = StringStream ""

		format "WARNING :: [%] !!---------- % ----------!!\n" cls ( msg + extraStr ) to:log_str

		this.sys.stderr.write( log_str as string )
	),

	fn Error msg args:#() kwargsDict: cls: =
	(
		/*DOC_--------------------------------------------------------------------
		Prints out the inputed msg as an error ( red text in listener window )
		
		Args:
			msg (string)
		
		Kwargs:
			args (array['string])
			kwargsDict (DotNet Hashtable) : You can pas a hastable as kwargs to format to the inputed msg
			cls (struct) : default unsupplied. Fill in the 'this' keyword when calling from within a struct
		
		Returns:
			(Void)
		
		--------------------------------------------------------------------_END*/
		
		if ( args.count != 0 ) then
		(
			msg = this.format msg args:args
		)

		local extraStr = ""

		if ( kwargsDict != unsupplied ) and ( ClassOf kwargsDict == dotNetObject ) then
		(
			extraStr = " " + this.ConcatStrFromHashtable kwargsDict
		)

		if ( cls != unsupplied ) then cls = ( this.GetClassTitle cls ) else cls = ""

		local log_str = StringStream ""

		format "ERROR :: [%] !-!-!-!-!-! % !-!-!-!-!-!\n" cls ( msg + extraStr ) to:log_str

		this.sys.stderr.write( log_str as string )
	),

	fn Critical msg args:#() kwargsDict: cls: =
	(
		/*DOC_--------------------------------------------------------------------
		Prints out the inputed msg as an error ( red text in listener window )
		Throws a LOGGER::CRITICAL error
		
		Args:
			msg (string)
		
		Kwargs:
			args (array['string])
			kwargsDict (DotNet Hashtable) : You can pas a hastable as kwargs to format to the inputed msg
			cls (struct) : default unsupplied. Fill in the 'this' keyword when calling from within a struct
		
		Returns:
			(Void)
		
		--------------------------------------------------------------------_END*/
		
		if ( args.count != 0 ) then
		(
			msg = this.format msg args:args
		)
		
		local extraStr = ""
		
		if ( kwargsDict != unsupplied ) and ( ClassOf kwargsDict == dotNetObject ) then
		(
			extraStr = " " + this.ConcatStrFromHashtable kwargsDict
		)
		
		if ( cls != unsupplied ) then cls = ( this.GetClassTitle cls ) else cls = ""
		
		local log_str = StringStream ""
		
		format "Critical :: [%] !-!-!-!-!-! % !-!-!-!-!-!\n" cls ( msg + extraStr ) to:log_str
		
		this.sys.stderr.write( log_str as string )
		
		-- this.DumpListenerTextToFile ( this.GetLogFilepath() )
		
		-- this.OpenLogDir()
		
		throw "LOGGER::CRITICAL"
	),

	fn Log msg statement:"LOG" lvl:( this.Enum_LoggerLevel.info ) args:#() kwargsDict: cls: =
	(
		/*DOC_--------------------------------------------------------------------
		Prints out the inputed msg if the log level is set to the inputed lvl or higher
		
		Args:
			msg (string)
		
		Kwargs:
			statement (string) : default "LOG"
			lvl ( Enum_LoggerLevel, integer, name )
			args (array['string])
			kwargsDict (DotNet Hashtable) : You can pas a hastable as kwargs to format to the inputed msg
			cls (struct) : default unsupplied. Fill in the 'this' keyword when calling from within a struct
		
		Returns:
			(Void)
		
		--------------------------------------------------------------------_END*/
		
		local logLevel = this.GetLevelValues lvl

		if ( logLevel != undefined ) and ( this.level == logLevel[1] ) then
		(
			if ( args.count != 0 ) then
			(
				msg = this.format msg args:args
			)

			local extraStr = ""

			if ( kwargsDict != unsupplied ) and ( ClassOf kwargsDict == dotNetObject ) then
			(
				extraStr = " " + this.ConcatStrFromHashtable kwargsDict
			)

			local log_str = StringStream ""

			if ( cls != unsupplied ) then cls = ( this.GetClassTitle cls ) else cls = ""

			format "% :: [%] ========== % ==========\n" statement cls ( msg + extraStr ) to:log_str

			this.sys.stdout.write( log_str as string )
		)
	),

	fn Format msg args:#() =
	(
		/*DOC_--------------------------------------------------------------------
		Allows you to format a string in place
		Replaces demarked substrings within the inputed msg with matching
		index value from the args array
		
		
		Uses more similar to Python sintax where arg variables in the string
		must be in format: {<index>}
			- where <index> matches the arguments index in the args array
			- Example: tstStr = Logger.format "This {1} a {2} to {3} if {4} works" args:#("is", "test", "see", "this")
		
		Args:
			msg (string)
		
		Kwargs:
			args (array[string])
		
		Returns:
			(string)
		
		--------------------------------------------------------------------_END*/
		
		local str = msg

		for i = 1 to args.count do
		(
			str = SubstituteString str ( "{" + ( i as string ) + "}" ) ( args[i] as string )
		)

		str
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

	level,
	level_val,
	_maxVerbosity = 4,
	verbosity = 1,

	fn ConcatStrFromHashtable dict =
	(
		/*DOC_--------------------------------------------------------------------
		Concatenates a string of the key/value pairs in the inputed dict
		
		Args:
			dict (DotNet Hashtable)
		
		Returns:
			(string)
		
		--------------------------------------------------------------------_END*/
		
		local str = StringStream ""
		local dictKeys = ::_hash.GetDicKeys dict
		
		for k in dictKeys do
		(
			format "| % :: % " k dict.item[k] to:str
		)

		( str as string ) + "|"
	),

	fn InvalidLevel lvl =
	(
		/*DOC_--------------------------------------------------------------------
		Generates an error message based on the type of inputed lvl
		
		Args:
			lvl (integer | name) : Takes either an integer value or named value
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( ClassOf lvl ) == Integer then
		(
			lvl = lvl as string
			this.Error ( lvl + " is not a valid level value, expected one of: " + (#(0, 1, 2) as string ))
		)
		else
		(
			this.Error ( lvl + " is not a valid level, expected one of: " + (( GetPropNames this.Enum_LoggerLevel ) as string ))
		)
	),

	fn GetLevelValues lvl =
	(
		/*DOC_--------------------------------------------------------------------
		returns an array of the enum values of the inputed lvl
		
		Args:
			lvl (integer | name) : Takes either an integer value or named value
		
		Returns:
			vals: (array[#name, integer]) : vals array index[1] = #name, index[2] = integer
		
		--------------------------------------------------------------------_END*/
		
		local out = #()

		if ( ClassOf lvl ) == Integer then
		(
			if ( lvl > 2 ) then
			(
				this.InvalidLevel lvl
				return undefined
			)
			
			local prps = ( GetPropNames this.Enum_LevelVal )
			
			prp = ( for p in prps where ( GetProperty this.Enum_LevelVal p ) == lvl collect p )[1]
			
			out = #(prp, ( GetProperty this.Enum_LevelVal prp ))
		)
		else if ( IsProperty this.Enum_LoggerLevel lvl ) then
		(
			local prp = ( GetProperty this.Enum_LoggerLevel lvl )
			out = #(prp, ( GetProperty this.Enum_LevelVal prp ))
		)
		else
		(
			this.InvalidLevel lvl
		)
		
		out
	),

	fn GetClassTitle cls =
	(
		/*DOC_--------------------------------------------------------------------
		Splits the string of the inputed struct object and returns the object name
		
		Args:
			cls (struct)
		
		Returns:
			(string)
		
		--------------------------------------------------------------------_END*/
		
		( trimLeft ( FilterString ( cls as string ) " " )[1] "(" )
	),
	
	fn GetLogLevelEnum =
	(
		/*DOC_--------------------------------------------------------------------
		Generates the enumeration struct for the Log Level Enum names
		
		Returns:
			Enum_LoggerLevel: (struct)
		
		--------------------------------------------------------------------_END*/
		
		struct Enum_LoggerLevel
		(
			/*DOC_--------------------------------------------------------------------
			Enumerations for Log Level by name
			
			--------------------------------------------------------------------_END*/
			none = #none,
			info = #info,
			debug = #debug
		)
		
		this.Enum_LoggerLevel = Enum_LoggerLevel()
	),
	
	fn GetEnumLevelVal =
	(
		/*DOC_--------------------------------------------------------------------
		Generates the enumeration struct for the Log Level Enum index values
		
		Returns:
			Enum_LevelVal: (struct)
		
		--------------------------------------------------------------------_END*/
		
		struct Enum_LevelVal
		(
			/*DOC_--------------------------------------------------------------------
			Enumerations for Log Level by index
			
			--------------------------------------------------------------------_END*/
			none = 0,
			info = 1,
			debug = 2
		)
		
		this.Enum_LevelVal = Enum_LevelVal()
	),

	fn _init =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.GetLogLevelEnum()
		this.GetEnumLevelVal()
		
		this.level = this.Enum_LoggerLevel.info
		this.level_val = ( GetProperty this.Enum_LevelVal this.level )
		
		this.CleanUpLogs threshold_days:12 -- Delete old log files
		this.EnableLogging ( this.GetLogFilepath() )
	),

	__init__ = _init()
)

Logger = Logger()