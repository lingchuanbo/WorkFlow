/***************************************************************************************************
__MXSDOC__
GTVFX appropriation of Blur 3dsmax code library.
Much of the logic has been completely rewritten and structured much differently
but the design concept remains much the same as the original Blur implementaion

Author: Gavyn Thompson
Company: GTVFX
Website: https://github.com/gtvfx
Email: gftvfx@gmail.com
__END__
***************************************************************************************************/

/***************************************************************************************************
__HELP__

[Purpose]

The primary purpose of this package is to facilitate a module based approach to MaxScript
libraries.This attempts to replicate the utility of C# namespaces and the �Using� operator,
or the Python �import� operator. The result isn�t one-to-one, but the use-case is similar and
very functional.

[Environment Variables]

"MXSPATH"
	This is a semicolon separated path that behaves much like the PYTHONPATH
	The individual paths are searched when sourcing a module.
	The first module found while searching is returned and loaded

"MXS_CODEROOT"
	This is the base path to the code directories of the main MXS package

"MXS_TOOLS"
	This is a semicolon separated path that behaves much like the PYTHONPATH
	Much like modules, there is logic here to support a tool framework that can be 
	expanded by child packages.

[Coding standards]

- All modules must be within a directory that is in the MXSPATH environment variable

- Supported MaxScript files are .ms and .mse

- Libraries are searched for by filename
	Sourcing in the Logger module would look like this:
		- mxs.using �Logger�
		- This will search the paths in the MXSPATH, in order, until it finds a file named 
		Logger.ms or Logger.mse.
		- It will then return the module and perform a FileIn operation on it

- All modules should create a global variable of the same name upon being loaded
	- Logger.ms should create a global variable �Logger�
	- This global variable is used to track if the module is already loaded or not

- This global variable should either contain an instance of a Struct or it should contain the
uninstantiated struct for objects that will be instanced by the consumer.

- It�s a good practice to compose your Struct with the same name that you will instantiate it with,
if for no other reason than reducing the number of variables in the system. But this also makes
it more intuitive as a consumer if you know that you�re going to call a global variable that
matches the name of the module you�re sourcing.
	- For example:
		- struct Logger ( <logic> )  
		- Logger = Logger() -- Instantiate the struct to a global variable of the same name

- You can have helper structs within the module so long as they are only used by the main 
struct and not intended to be used individually. 
	- This ensures that the usage of the structs are intuitive and we�re not just sourcing in 
	random global variables without any guidance on how to use them.

- Each module should contain these two methods:
	- Fn GetModule = ( GetSourceFileName() )
	- Fn Help = ( ::mxs.GetScriptHelp (GetSourceFileName()) )
	- These methods can be used by the main module for various purposes.
	- The Help method is purposefully written as a static method so that it can be called on an 
	un-instantiated object.
- All modules should contain a Help block above the start of the code.
	- This should just be a commented block with the text �__HELP__� at the beginning and 
	�__END__� to finish it off. 
	- The main mxs lib has a method that parses the text file and returns this block of text and 
	prints it to the listener window.
	- In this way we can provide help for consuming modules without external documentation.
- Variable scoping:
	- All variables should have their scope declared
		- Variables used only within a function should be declared as �local�
			- local foo
		- Variables and Methods within a struct should always be called using the �this� keyword.
			- this.foo
			- this.foo()
		- Global variables should always be prefixed with a double-colon, �::�.
			- This ensures that the compiler will only search the variable from the global pool.
			- It also makes your code easier to read as this tells the reader that the variable 
			is coming from another source not defined in the current scope.
			- Technical info about this can be found here:
				- https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2015/ENU/MAXScript-Help/files/GUID-382E7583-DD2A-4DF5-B568-71502DF95ED9-htm.html
- Module sourcing loops!
	- If a module is sourcing in another module that, in turn, sources it, you�ll need to do a 
	forward declaration of your modules global variable before all of your �using� declarations.
	- For example: MeshFns and MaterialFns source oneanother. In these modules, 
	you�ll find that we define their global variables prior to our �using� declarations by just 
	defining it as an empty string. ( ::MeshFns = �� )


__END__
***************************************************************************************************/



global mxs


(
	struct SimpleDict
	(
		/*DOC_--------------------------------------------------------------------
		Simple Dictionary type class for storing data in the mxsLib
		
		Args:
			m_keys (array[string])
			m_values (array[*])
			count (integer)
		
		--------------------------------------------------------------------_END*/
		
		m_keys = #(),
		m_values = #(),
		count = 0,
		
		fn Clear = 
		(
			this.m_keys = #()
			this.m_values = #()
			this.count = 0
		),
		
		fn GetValue inKey =
		(
			for i = 1 to this.m_keys.count do
			(
				if ( toLower ( inKey as string ) == toLower ( this.m_keys[i] as string ) ) then
				(
					return ( this.m_values[i] )
				)
			)
			
			return ""
		),
		
		fn HasKey inKey =
		(
			local out = undefined
			
			if ( ::mxs != undefined ) and ( ::mxs.debugLevel > 0 ) then
			(
				format "HasKey() searching m_keys for inKey: %\n" inKey inValue
				print ("m_keys: " + this.m_keys as string)
			)
			
			out = ( findItem this.m_keys ( toLower ( inKey as string ) ) != 0 )
			out
		),
		
		fn keys =
		(
			this.m_keys
		),
		
		fn SetValue inKey inValue =
		(
			if ( ::mxs != undefined ) and ( ::mxs.debugLevel > 0 ) then format "::mxs.SetValue() inkey: % inValue: %\n " inKey inValue
			
			for i = 1 to this.m_keys.count do
			(
				if ( toLower ( inKey as string ) == toLower ( this.m_keys[i] as string ) ) then
				(
					this.m_values[i] = inValue
					return True
				)
			)
			
			append this.m_keys inKey
			append this.m_values inValue
			this.count = this.m_keys.count
		),
		
		fn values =
		(
			this.m_values
		)
	)
	
	struct mxsCallback
	(
		type,
		command = "",
		id,
		filename
	)
	
	-------------------------------------------------------------------------------------------------------------
	--					DEFINE LIBRARY FUNCTIONALITY
	-------------------------------------------------------------------------------------------------------------
	
	struct EnvironmentClass
	(
		/*DOC_--------------------------------------------------------------------
		Stores environment paths
		
		Args:
			name (string)
			paths (SimpleDict)
		
		--------------------------------------------------------------------_END*/
		
		name = "",
		paths = SimpleDict(),
		
		fn GetPath pathID =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the path whose ID matches the inputed string, or an empty
			string if none is found
			
			Args:
				pathID (string)
			
			Returns:
				path: (string)
			
			--------------------------------------------------------------------_END*/
			
			pathID = toLower ( pathID as string )
			
			if ( this.paths.HasKey pathID ) then
			(
				return this.paths.GetValue pathID
			)
			
			""
		),
		
		fn GetPathIDs =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the paths keys - path IDs for this environment
			
			Args:
				ARG1 (type)
			
			Returns:
				(array[string])
			
			--------------------------------------------------------------------_END*/
			
			this.paths.keys()
		),
		
		fn SetPath pathID path =
		(
			/*DOC_--------------------------------------------------------------------
			Sets the path ID's path value ( all path ID's are converted to lower case strings )
			
			Args:
				pathID (string)
				path (string)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			this.paths.SetValue ( toLower ( pathID as string ) ) path
		)
	)
	
	struct mxsLibraryStruct
	(
		------------------------------------------------------------------------------
		--				PUBLIC MEMBERS
		------------------------------------------------------------------------------
		
		max_version = ( MaxVersion() )[1],
		
		classID = "MXS",
		printStatus = false,
		debugLevel = 0,
		
		toolDict = dotNetObject "System.Collections.Hashtable",
		toollist = #(),
		
		sysEnv = this.GetSysEnv,
		
		-- Stores UI settings like positoin and dimensions
		uiSettingsIni = ( (GetDir #ui) + "mxsUiSettings.ini" ),
		
		------------------------------------------------------------------------------
		--				PRIVATE MEMBERS
		------------------------------------------------------------------------------
		_environments = SimpleDict(),
		_activeEnvironment = "",
		
		_libraries = #(),
		_constantLibraries = #(),
		
		_callbackTypes = #(),
		_callbackIDs = #(),
		_callbackArray = #(),
		
		_blockCount_matEditor = 0,
		_blockCount_renderSceneDialog = 0,
		_blockState_renderSceneDialog = undefined,
		_blockCount_sceneRedraw = 0,
		_blockCount_cmdPanel = 0,
		_blockState_cmdPanel = undefined,
		_blockCount_cursor = 0,
		_blockStack = #(),
		------------------------------------------------------------------------------
		--							PUBLIC METHODS
		------------------------------------------------------------------------------
		
		fn _normEnv environmentID =
		(
			/*DOC_--------------------------------------------------------------------
			Normalizes inputed environmentID.  Function is setup for backwards
			compatibility, setting code path 'local' and 'network' to work with
			new environments and turns the ID to lowercase
			
			Args:
				environmentID (string)
			
			Returns:
				outEnvironmentID: (string)
			
			--------------------------------------------------------------------_END*/
			
			if ( this.debugLevel > 4 ) then format "_normEnv() environmentID: %\n" (if environmentID == "" then "\"\"" else environmentID)
			
			if ( environmentID == "" ) then
			(
				if ( this.debugLevel > 4 ) then format "\tenvironmentID blank, assuming _activeEnvironment: %\n" this._activeEnvironment
				environmentID = this._activeEnvironment
			)
			
			if ( this.debugLevel > 4 ) then format "\tnormalized environmentID: %\n" (if environmentID == "" then "\"\"" else environmentID)

			local outEnvironmentID = toLower environmentID
			
			if ( this.debugLevel > 4 ) then format "\tout: %" (if outEnvironmentID == "" then "\"\"" else outEnvironmentID)
				
			return outEnvironmentID
		),
		
		fn BlockUi state flags:unsupplied =
		(
			/*DOC_--------------------------------------------------------------------
			stacks calls to disable common ui elements
			
			Args:
				state (boolean)
			
			Kwargs:
				flags (name | array[name])
			
			Returns:
				_blockStack: (array)
			
			--------------------------------------------------------------------_END*/
			
			flags = if flags == unsupplied then #(#all) else flags
			if classof flags != Array then flags = #(flags)	
			
			if ( state ) then
			(
				if ( finditem flags #all != 0 ) then
				(
					flags = #(#mateditor,#renderSceneDialog,#sceneRedraw,#cmdPanel)
				)
				append _blockStack flags
				
				-- store each flag option as its own counter.  for dialogs that open and close, only add the count 
				-- if the dialog is open or there's already a count in progress.
				( _blockCount_cursor += 1 )
				
				-- for any counter that just became 1, block the ui
				if _blockCount_cursor == 1 then
				(
					setWaitCursor()
				)
				
				if ( findItem flags #sceneRedraw != 0 ) then
				( 
					_blockCount_sceneRedraw += 1 
					if _blockCount_sceneRedraw == 1 then
					(
						disablesceneredraw()
					)
				)
				
				if ( findItem flags #cmdPanel != 0 ) then
				( 
					_blockCount_cmdPanel += 1
					if _blockCount_cmdPanel == 1 then
					(
						_blockState_cmdPanel = getCommandPanelTaskMode()
						if _blockState_cmdPanel != #create then setCommandPanelTaskMode #create
					)
				)
				
				if ( findItem flags #mateditor != 0 and (_blockCount_matEditor > 0 or matEditor.isOpen()) ) then
				( 
					_blockCount_matEditor += 1
					if _blockCount_matEditor == 1 then
					(
						matEditor.close()
					)					
				)
				
				if ( findItem flags #renderSceneDialog 	!= 0 and (_blockCount_renderSceneDialog > 0 or renderSceneDialog.isOpen()) ) then
				( 
					_blockCount_renderSceneDialog += 1
					if _blockCount_renderSceneDialog == 1 then
					(
						_blockState_renderSceneDialog = ( tabbedDialogs.getCurrentPage #render )
						renderSceneDialog.close()
					)
				)
			)
			else if ( _blockStack.count > 0 ) then
			( -- make sure we have some stuff to unblock
				
				local lastFlagSet = _blockStack[_blockStack.count]
				
				-- remove the last item from the stack
				deleteItem _blockStack _blockStack.count
				
				-- decrement any of the flags if they aren't already at 0
				if ( findItem lastFlagSet #sceneRedraw 	!= 0 and _blockCount_sceneRedraw 	> 0 ) then
				(
					_blockCount_sceneRedraw -= 1
					-- if the item just became 0, unblock it/open it
					if _blockCount_sceneRedraw 	== 0 then
					(
						while isSceneRedrawDisabled() do enableSceneRedraw()
						-- This call is not updating the viewport camera label (max 2010) so it appears that the camera has not switched
						-- trying a safeframe toggle to work around this
						redrawViews()
						max safeframe toggle
						max safeframe toggle
					)
				)
				
				if ( findItem lastFlagSet #cmdPanel != 0 and _blockCount_cmdPanel > 0 ) then
				( 
					_blockCount_cmdPanel -= 1
					if _blockCount_cmdPanel == 0 then
					(
						setCommandPanelTaskMode _blockState_cmdPanel
						_blockState_cmdPanel = undefined
					)
				)
				
				if ( findItem lastFlagSet #mateditor != 0 and _blockCount_matEditor > 0 ) then
				( 
					_blockCount_matEditor -= 1 
					if _blockCount_matEditor == 0 then
					(
						matEditor.open()
					)
				)
				
				if ( findItem lastFlagSet #renderSceneDialog != 0 and _blockCount_renderSceneDialog > 0 ) then
				(
					_blockCount_renderSceneDialog -= 1
					if _blockCount_renderSceneDialog == 0 then
					(
						renderSceneDialog.open()
						tabbedDialogs.SetCurrentPage #render _blockState_renderSceneDialog
						_blockState_renderSceneDialog = undefined
					)
				)
				
				if _blockCount_cursor > 0 then
				(
					_blockCount_cursor -= 1
					if _blockCount_cursor == 0 then
					(
						setArrowCursor()
					)
				)
			)
			
			_blockStack
		),
		
		fn ClearGlobal inString =
		( 
			/*DOC_--------------------------------------------------------------------
			Clears the global value using the globalVars struct
			
			Args:
				inString (string)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			globalVars.remove ( inString as string )
		),
		
		fn ClearLibrary inLibName =
		(
			/*DOC_--------------------------------------------------------------------
			Clears the global variable associated with the inputed library
			name, thus setting it to undefined and removing it from data.
			Also removes the library ID from the library list
			
			Args:
				inLibName (string)
			
			Returns:
				(Boolean)
			
			--------------------------------------------------------------------_END*/
			
			local tIndex = findItem this._libraries inLibName
			
			if ( tIndex > 0 ) then
			(
				if ( this.printStatus ) then
				(
					format "[%] --- Clearing Library: %\n" this.classId inLibName
				)
				
				this.ClearGlobal inLibName
				deleteItem this._libraries tIndex
				return True
			)
			
			return False
		),
		
		fn ClearLibraries =
		(
			/*DOC_--------------------------------------------------------------------
			Sets all the global library variables that are loaded to being
			undefined and then clears the library array.
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			if ( this.debugLevel > 0 ) then 	format "ClearLibraries() inClearLocals: % inClearExternals: %\n" inClearLocals inClearExternals
			
			for index = this._libraries.count to 1 by -1 do
			(
				local tLibName = this._libraries[index]
				this.ClearLibrary tLibName
			)
		),
		
		fn QsortAphlabetical str1 str2 =
		(
			case of
			(
				(str1 < str2): -1
				(str1 > str2): 1
				default: 0
			)
		),
		
		fn Dir inLibName inPrintTo: =
		(
			/*DOC_--------------------------------------------------------------------
			Displays info about the library specified
			
			Args:
				inLibName (string)
			
			Kwargs:
				inPrintTo (<windostream> | <filestream> | <stringstream>)
			
			Returns:
				libinfo: (string)
			
			--------------------------------------------------------------------_END*/
			
			local libinfo = stringstream ""
				
			local tLibraryStr = inLibName
			if (execute tLibraryStr == undefined ) then
			(
				this.Using inLibName
			)
			
			local tLib = execute tLibraryStr
			
			if (ClassOf tLib) == StructDef then
			(
				tLib = tLib()
			)
		
			local pFuncs = #()
			local pPrivateFuncs = #()
			local pVars = #()
			local pPrivateVars = #()
			
			local pNames = getpropnames tLib
			for p in pNames do
			(
				p = p as string
				local pValue = getproperty tLib p
				
				if (classof pValue == MAXScriptFunction) then
				(
					if ( p[1] == "_" )	then
					(
						append pPrivateFuncs p
					)
					else
					(
						append pFuncs p
					)
				)
				else
				(
					if ( p[1] == "_" ) then
					(
						append pPrivateVars p
					)
					else
					(
						append pVars p
					)
				)
			)
			
			Qsort pFuncs this.QsortAphlabetical
			Qsort pPrivateFuncs this.QsortAphlabetical
			Qsort pVars this.QsortAphlabetical
			Qsort pPrivateVars this.QsortAphlabetical
			
			-- print all the info collected about the library
			format "\n---------------------------------------\n" to:libinfo 
			format "MXS Library: %\n" inLibName  to:libinfo 
			format "---------------------------------------\n" to:libinfo 
			
			for p in pPrivateFuncs do
			(	
				local pValue = getproperty tLib p
				format "[PrivateFN] %\n" (p as string) to:libinfo 
			)
			
			for p in pPrivateVars do
			(	
				local pValue = getproperty tLib p
				format "[Private Var] % = %\n" (p as string) pValue to:libinfo 
			)
			
			for p in pVars do
			(	
				local pValue = getproperty tLib p
				format "[Var] % = %\n" (p as string) pValue to:libinfo 
			)
			
			for p in pFuncs do
			(	
				local pValue = getproperty tLib p
				format "[FN] %\n" (p as string) to:libinfo 
			)
			
			if inPrintTo == unsupplied then
			(
				inPrintTo = Listener
			)
			
			format "%\n" libinfo to:inPrintTo
		),
		
		fn Debug inItem inIncludeHead:true inIndent:"" inPrintTo: =
		(
			/*DOC_--------------------------------------------------------------------
			Displays info about the item specified
			
			Args:
				inItem (<object> | <property> | <struct>) : Item to debug
			
			Kwargs:
				inIncludeHead (boolean) : Includes info about the item name
				inIndent (string) : Amount of indentation
				inPrintTo (<windostream> | <filestream> | <stringstream>)
			
			Returns:
				info: (string)
			
			--------------------------------------------------------------------_END*/
			
			local info = stringstream ""
			
			if inPrintTo == unsupplied then
			(
				info = listener
			)
				
			local pFuncs = #()
			local pPrivateFuncs = #()
			local pVars = #()
			local pStructs = #()
			local pPrivateVars = #()
			
			local pNames = try(getpropnames inItem)catch(#())
				
			for p in pNames do
			(
				p = p as string
				local pValue = getproperty inItem p
				
				if (classof pValue == MAXScriptFunction) then
				(
					if (findstring p "__" != undefined)	then
					(
						append pPrivateFuncs p
					)
					else
					(
						append pFuncs p
					)
				)
				else if (superclassof pValue == StructDef) or (classof pValue == StructDef) then
				(
					append pStructs p
				)
				else
				(
					if (findstring p "__" != undefined)	then
					(
						append pPrivateVars p
					)
					else
					(
						append pVars p
					)
				)
			)
			
			with printAllElements on
			(
				-- print all the info collected about the library
				if (includeHead == true) then 
				(
					format "%---------------------------------------\n" inIndent to:info 
					if (superclassof inItem == StructDef) then
					(
						format "%%\n" inIndent ((filterstring ((classof inItem) as string) "#:(")[2]) to:info
					)
					else if (classof inItem == StructDef) then
					(
						format "%%\n" inIndent ((filterstring (inItem as string) "#:(")[2]) to:info
					)
					else
					(
						format "%%\n" inIndent inItem  to:info
					)
					format "%---------------------------------------\n" inIndent to:info 
				)
			
				if (pPrivateFuncs.count >0) then
				(
					format "\n" to:info
				)
				
				for p in pPrivateFuncs do
				(	
					local pValue = getproperty inItem p
					format "%[PrivateFN] %\n" inIndent (p as string) to:info 
				)
			
				if (pPrivateVars.count >0) then
				(
					format "\n" to:info
				)
				
				for p in pPrivateVars do
				(	
					local pValue = getproperty inItem p
					format "%[Private Var] % = %\n" inIndent (p as string) pValue to:info 
				)	
			
				if (pVars.count >0) then
				(
					format "\n" to:info
				)
				
				for p in pVars do
				(	
					local pValue = getproperty inItem p
					format "%[%] % = %\n" inIndent (classof pValue) (p as string) pValue to:info 
				)
			
				if (pFuncs.count >0) then
				(
					format "\n" to:info
				)
				
				for p in pFuncs do
				(	
					local pValue = getproperty inItem p
					format "%[FN] %\n" inIndent (p as string) to:info 
				)
				
				if (pStructs.count >0) then
				(
					format "\n" to:info
				)
				
				for p in pStructs do
				(	
					local pValue = getproperty inItem p
					local pStructStr = this.debug pValue inIndent:(inIndent + "\t") inIncludeHead:false inPrintTo:info
					format "%[STRUCT] %\n%\n" inIndent ((filterstring ((classof pValue) as string) "#:(")[2]) (pStructStr as string) to:info 
					--format "[FN] %\n" (p as string) to:info 
				)
			)
			
			(info as string)		
		),
		
		fn GetCodePath inEnvironment:"" =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the current code root path directory
			
			Kwargs:
				inEnvironment (string)
			
			Returns:
				(string) : directory path
			
			--------------------------------------------------------------------_END*/
			
			pathconfig.NormalizePath ( this.GetPath #MXS_CODEROOT inEnvironment:inEnvironment )
		),
		
		fn GetCurEnv =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the current active environment ID
			
			Returns:
				(string) : environment id
			
			--------------------------------------------------------------------_END*/
			
			this._ActiveEnvironment
		),
		
		fn GetUserDir env:#local =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the path to the user directory. Can be #local or #network
			
			Kwargs:
				env (enum: #local | #network)
			
			Returns:
				userDir: (string)
			
			--------------------------------------------------------------------_END*/
			
			local userDir = undefined
			
			case env of
			(
				(#network): 
				(
					-- TODO: Need to add a network user dir location to the environment
					
					userDir = (( this.GetNetRoot() ) + sysInfo.userName )
					if not DoesFileExist userDir then makeDir userDir
					userDir
				)
				(#local):
				(
					userDir = systemTools.getEnvVariable "USERPROFILE"
					userDir
				)
			)
		),
		
		fn GetLibPath =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the path to the 'Lib' directory under the codeRoot
			
			Returns:
				(string) : Lib directory path
			
			--------------------------------------------------------------------_END*/
			
			pathConfig.NormalizePath ( this.GetCodePath() + "/lib/" )
		),
		
		fn GetSysEnv =
		(
			/*DOC_--------------------------------------------------------------------
			Creates a DotNet System.Environment Object
			
			Returns:
				(dotNetClass)
			
			--------------------------------------------------------------------_END*/
			( dotNetClass "System.Environment" )
		),
		
		fn GetNetRoot =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the network root
			
			Returns:
				(string)
			
			--------------------------------------------------------------------_END*/
			
			this.GetPath #NETROOT
		),
		
		fn EnsureArgIsArray arg =
		(
			/*DOC_--------------------------------------------------------------------
			Tests the object type of the arg passed and returns it as an array
			
			Args:
				arg (VARIABLE)
			
			Returns:
				(array[arg])
			
			--------------------------------------------------------------------_END*/
			
			if ( ClassOf arg ) == ObjectSet then
			(
				arg = ( arg as array )
			)
			else if ( ClassOf arg ) != Array then
			(
				arg = #(arg)
			)
			
			arg
		),
		
		fn GetModuleDependencies mxsModule =
		(
			/*DOC_--------------------------------------------------------------------
			Get a list of modules being sourced by the supplied module
			
			Args:
				mxsModule (string) : file path to an mxs module file
			
			Returns:
				out: (array[string]) : array of string paths to mxs module files
			
			--------------------------------------------------------------------_END*/
			
			if not ( DoesFileExist mxsModule ) then
			(
				format "***** GetModuleDependencies was unable to find the supplied file: % *****\n" mxsModule
				return ""
			)
			
			local out = #()
			local strm = ( openFile mxsModule mode:"r" )
			
			while not ( eof strm ) do
			(
				local l = readLine strm
				if ( matchPattern l pattern:"*mxs.using*" ) then
				(
					local lineStrArr = ( filterString l "\"" )
					
					if lineStrArr != undefined and lineStrArr.count > 1 then
					(
						appendIfUnique out lineStrArr[2]
					)
				)
			)
			
			out
		),
		
		fn GetStringBlock textFile fromStr toStr title:"" filterFromStr:True filterToStr:True =
		(
			/*DOC_--------------------------------------------------------------------
			Collects a block of text in a file between the fromStr and toStr args
			
			Args:
				textFile (string) : filepath to text file
				fromStr (string) : string pattern to find to begin collecting the block of text from
				toStr (string) : string pattern to end collecting at
			
			Kwargs:
				title (str) : Optional title head for the string block
				filterFromStr (boolean) : If true will remove the fromStr text from the string pattern for printing back
				filterToStr (boolean) : If true will remove the toStr text from the string pattern for printing back
			
			Returns:
				strBlock: (string)
			
			--------------------------------------------------------------------_END*/
			
			if not ( DoesFileExist textFile ) then
			(
				format "***** GetStringBlock was unable to find the supplied file: % *****\n" textFile
				return ""
			)
				
			local strBlock = stringStream ""
			local strm = ( openFile textFile mode:"r" )
			local begin = False
			
			while not ( eof strm ) do
			(
				local l = readLine strm
				if ( matchPattern l pattern:fromStr ) then begin = True
				if begin then
				(
					format (l + "\n") to:strBlock
					if matchPattern l pattern:toStr then exit
				)
			)
			
			close strm
			strBlock = ( strBlock as string )
			
			if filterFromStr then
			(
				local iFromStr = SubStituteString fromStr "*" ""
				strBlock = ( SubstituteString strBlock iFromStr "" )
			)
			
			if filterToStr then
			(
				local iToStr = SubStituteString toStr "*" ""
				strBlock = ( SubstituteString strBlock iToStr "" )
			)
			
			format "======================================\n%%\n======================================\n" title strBlock
		),
		
		fn GetScriptHeader mxsModule =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the block of text between "*__MXSDOC__*" and "*__END__*"
			
			Args:
				mxsModule (string) : Path to module script file
			
			Returns:
				(string)
			
			--------------------------------------------------------------------_END*/
			
			this.GetStringBlock mxsModule "__MXSDOC__" "__END__" filterFromStr:True filterToStr:True
		),

		fn GetScriptHelp mxsModule _fn: =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the block of text between "*__Help__*" and "*__END__*"
			
			if _fn is supplied then returns the 'DOC' string of function
			
			Args:
				mxsModule (string) : Path to module script file
			
			Kwargs:
				_fn (string) :  Name of the internal method as a string
			
			Returns:
				(string)
			
			--------------------------------------------------------------------_END*/
			
			if _fn == unsupplied then
			(
				this.GetStringBlock mxsModule "*__HELP__*" "*__END__*" filterFromStr:False filterToStr:True
			)
			else
			(
				if ClassOf _fn == String then
				(
					this.GetStringBlock mxsModule ( "*fn " + _fn + "*" ) "**_END**" filterFromStr:False filterToStr:False
				)
				else
				(
					format "***** _fn must be a String *****\n"
				)
			)
		),
		
		fn ReloadPythonModule moduleVar =
		(
			/*DOC_--------------------------------------------------------------------
			Attempts to reload a Python module that has been aggregated to a MaxScript variable
			
			Args:
				moduleVar (PyWrapperBase) : MaxScript variable holding the Python module
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			local module_str = ( filterString ( moduleVar as string ) "'*'" )[2]
			local module_name_arr = ( FilterString module_str "." )
			local module_name = ""
			
			try
			( -- try to reload the module with the fullname
				python.execute ( "import " + module_str )
				
				module_name = module_name_arr[module_name_arr.count]		
				
				python.execute ( "reload(" + module_name + ")" )
				
				format "***** MXS Reloaded Python Module: % *****\n" module_name
			)
			catch
			(
				try
				( -- try to reload the module that is one level up from the fullname
					module_str = ( module_name_arr[1] + "." )

					for i = 2 to module_name_arr.count - 1 do
					(
						module_str += ( module_name_arr[i] + "." )
					)
					
					module_str = TrimRight module_str "."
					
					python.execute ( "import " + module_str )		
					python.execute ( "reload(" + module_str + ")" )
					
					format "***** MXS Reloaded Python Module: % *****\n" module_str
				)
				catch
				(
					format "***** Unable to reload the python module: % *****\n" module_name
				)
			)
		),
		
		fn GetEnvironment inEnvironment:"" =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the environment instance that matches the inputed ID, if
			one exists, otherwise returns undefined
			
			Kwargs:
				inEnvironmentID (string)
			
			Returns:
				EnvironmentClass | undefined
			
			--------------------------------------------------------------------_END*/
			
			local out = undefined
			
			if ( this.debugLevel > 0 ) then print ("GetEnvironment() inEnvironment: " + (if inEnvironment == "" then "unsupplied" else inEnvironment))
				
			local inEnvironmentID = this._normEnv inEnvironment
				
			if ( this._environments.HasKey inEnvironmentID ) then
			(				
				out = this._environments.GetValue inEnvironmentID
			)
			
			if ( this.debugLevel > 0 ) then print ("GetEnvironment() out: " + out as string)
			
			out
		),
		
		fn GetLoadedLibraries inIncludeLocals:True inIncludeConstants:True =
		(
			/*DOC_--------------------------------------------------------------------
			Returns the names of the libraries that are currently loaded
			
			Kwargs:
				inIncludeLocals (boolean) : Includes the local libraries in the output list
				inIncludeConstants (boolean) : Includes the constant libraries in the output list
			
			Returns:
				(array[string])
			
			--------------------------------------------------------------------_END*/
			
			local outList = #()
			
			if ( inIncludeLocals ) then
			(
				join outList this._libraries
			)
			if ( inIncludeConstants ) then
			(
				join outList this._constantLibraries
			)
				
			outList
		),
		
		fn GetPath inPathID inEnvironment:"" inPathSeparator:"/" =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the path value for the given ID.  If no environment is specified
			then the current active environment is used, seperating the outputed
			folders/path using the given string
	
			Args:
				inPathID (string)
			
			Kwargs:
				inEnvironment (string)
				inPathSeparator (string)
			
			Returns:
				(string) : path
			
			--------------------------------------------------------------------_END*/
			
			if ( this.debugLevel > 0 ) then
			(
				print ("[mxsLib] " + getSourceFilename())
				format "GetPath() inPathID: % inEnvironment: %\n" inPathID inEnvironment
			)
			
			local out = undefined
			
			local outPath = ""
			local tEnvironment = this.GetEnvironment inEnvironment:inEnvironment
			
			if ( tEnvironment != undefined ) then
			(
				outPath = tEnvironment.GetPath inPathID
			)
			
			if ( this.debugLevel > 0 ) then format "\toutPath: %\n" outPath
			
			if out != "" then
			(
				outPath = ( this.RemovePathTemplates outPath inEnvironment:inEnvironment )
			)
			
			out = pathConfig.NormalizePath outPath
			out
		),
		
		fn GetPathIDs inEnvironment:"" =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the path IDs available for the given environment, using the current
			active environment if non is specified
			
			Kwargs:
				inEnvironment (string)
			
			Returns:
				outPathIDs: (array[string])
			
			--------------------------------------------------------------------_END*/
			
			local tEnvironment = this.GetEnvironment inEnvironment:inEnvironment
			
			outPathIDs = for PathID in ( tEnvironment.GetPathIDs() ) collect PathID
			
			outPathIDs
		),
		
		fn GetEnvironmentIDs =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the loaded environment IDs
			
			Returns:
				(array[string])
			
			--------------------------------------------------------------------_END*/
			
			this._environments.keys()
		),
		
		fn IsLoaded inString =
		( 
			/*DOC_--------------------------------------------------------------------
			Checks to see if the given string variable is assigned in the globalVars struct
			
			Args:
				inString (string)
			
			Returns:
				(boolean)
			
			--------------------------------------------------------------------_END*/
			
			try(( globalVars.get inString ) != undefined )catch( False )
		),
		
		fn IsPath pathID inEnvironment:"" =
		(
			/*DOC_--------------------------------------------------------------------
			Checks to see if the inputed string is a path ID in the given
			environment, using the active environment if none is specified
			
			Args:
				pathID (string)
			
			Kwargs:
				inEnvironment (string)
			
			Returns:
				(boolean)			
			
			--------------------------------------------------------------------_END*/
			( findItem ( this.GetPathIDs inEnvironment:inEnvironment ) ( toLower ( pathID as string )) != 0 )
		),
		
		fn GetDateFromTimeString timeString =
		(
			/*DOC_--------------------------------------------------------------------
			Filters the string returned form LocalTime and/or GetFileModDate() for the date
			
			Args:
				timeString (strign) : from LocalTime or GetFileModDate <file>
			
			Returns:
				date: (string)
			
			--------------------------------------------------------------------_END*/
			
			local stringArr = FilterString timeString " "
			
			out = ( for item in stringArr where matchPattern item pattern:"*/*" collect item )
			
			if out != undefined and out.count != 0 then
			(
				out = out[1]
			)
			else
			(
				out = undefined
			)
			
			out
		),
		
		fn IsModuleModified modulePath =
		(
			/*DOC_--------------------------------------------------------------------
			Compares the modified date of the input file with the current date
			
			Args:
				modulePath (string) : path to mxs module
			
			Returns:
				(boolean) : True if modified today
			
			--------------------------------------------------------------------_END*/
			
			local today = GetDateFromTimeString localTime
			local moduleDate = GetDateFromTimeString ( GetFileModDate modulePath )
			
			if today == moduleDate then
			(
				format "[MXS]: ***** File was modified today: % *****\n" ( GetFileNameFile modulePath )
				True
			)
			else
			(
				False
			)
		),
		
		fn FindLibFile inLibName =
		(
			/*DOC_--------------------------------------------------------------------
			Loops through each path in MXSPATH and searches for a file matching the inLibName
			Returns the first file it finds matching the name
			
			Supports dot('.') separated lib names for appending subdirectories to the path
			ie, ::mxs.using "mesh.DetachElementsByMatID" 
			This will find a module named DetachElementsByMatID.ms in a 'mesh' subdirectory
			of one of the directories on the MXSPATH.
			
			Args:
				inLibName (string)
			
			Returns:
				(string) | undefined : Full file path to the mxs module or undefined if not found
			
			--------------------------------------------------------------------_END*/
			
			-- Split the MXSPATH variable into an array of paths
			local pathArr = ( FilterString ( this.GetPath #MXSPATH ) ";" )
			
			for p in pathArr do
			(
				-- Loop through each path in order and see if we can find a matching module.
				-- If we find it we return exit the loop and return it
				
				if p[p.count] != "/" then p = ( p + "/" )
				
				-- Split the inLibName to support sub directories on the path
				local libNameArr = ( FilterString inLibName "." )
				
				-- Assign the inLibName to be the actual modlue name, now without prepended sub directories
				inLibName = libNameArr[libNameArr.count]
				
				-- If a dot separated lib name is provided we append each to the path and check if the directory exists
				if libNameArr.count > 1 then
				(
					for i = 1 to libNameArr.count - 1 do
					( -- we skip the last item as that should be the filename, not a sub directory
						p = p + libNameArr[i] + "/"
					)
				)
				
				p = pathConfig.normalizePath p
				
				if not DoesFileExist p then
				(
					continue
				)
				
				-- Collect all script files at the path
				local fileArr = GetFiles ( p + "*.ms*" )
				
				-- Filter the collected files for any matching the inLibName
				local nameFileArr = for f in fileArr where ( matchPattern ( GetFileNameFile f ) pattern:inLibName ) collect f
				
				-- If a file matching the name is found then we return it
				if nameFileArr.count == 1 then
				(
					return nameFileArr[1]
				)
				else if nameFileArr.count > 1 then
				(
					format "MXS -!-!- More than one file matching that name was found.\n%\n" nameFileArr
					return nameFileArr[1]
				)
			)
			
			undefined
		),
		
		fn Using inLibName reload:( keyboard.escPressed ) =
		(
			/*DOC_--------------------------------------------------------------------
			Checks if the inputed library name is already loaded. If so, it continues.
			If the file is already loaded, but the reload flag is true then it treats the library as if it's not loaded.
			If the library is not already loaded it searches for the lib in the MXSPATH.
			Once found it registers the library and performs a FileIn on the module.
			
			Args:
				inLibName (string) : Name of module to load
			
			Kwargs:
				reload (boolean) : If true, force a reload of the module
			
			Returns:
				if no module is found then | undefined
			
			--------------------------------------------------------------------_END*/
			
			
			if ( this.IsLoaded inLibName) and not reload then
			(
				return ( format "[%] --- Using: %\n" this.classId inLibName )
			)
			
			local tFileStr = this.FindLibFile inLibName
			
			if ( tFileStr == undefined ) then
			(
				messageBox ( "No module found matching name: " + inLibName ) tite:this.classID
				return undefined
			)
			
			if ( DoesFileExist tFileStr ) then
			(
				if ( not this.IsLoaded inLibName or reload or this.IsModuleModified tFileStr ) then
				(
					if ( this.printStatus ) then
					(
						format "[%] --- Loading Library: %\n" this.classId inLibName
					)
					
					this.ClearGlobal inLibName
					--execute ( "global " + inLibName + " = undefined" )
					
					AppendIfUnique this._libraries inLibName
					
					FileIn tFileStr
				)
			)
		),
		
		fn AppendPythonPath devPath =
		(
			/*DOC_--------------------------------------------------------------------
			Appends the inputed path to the PYTHONPATH env variable
			
			Args:
				devPath (string)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			
			local pyCmd = stringStream ""
			
			format "
import sys
tempDevPath = r\"%\"
	
if tempDevPath not in sys.path:
	print 'Appending path'
	sys.path.insert(0,tempDevPath)
else:
	print 'Path already exists'
			" devPath to:pyCmd
			
			python.execute ( pyCmd as string )
		),
		
		fn LoadConfigData envId:"SYS" =
		(
			/*DOC_--------------------------------------------------------------------
			Sets the environment paths from environment variables
			
			Kwargs:
				envId (string) : named id of environment ( default "SYS" )
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			local sysenv = this.GetSysEnv()
			local tEnvironment = EnvironmentClass()
			
			tEnvironment.name = envId
			
			this._environments.Clear()
			this._activeEnvironment = envId
			
			tEnvironment.SetPath "NETROOT" ( sysenv.GetEnvironmentVariable "NETROOT" )
			tEnvironment.SetPath "MXSPATH" ( sysenv.GetEnvironmentVariable "MXSPATH" )
			tEnvironment.SetPath "MXS_CODEROOT" ( sysenv.GetEnvironmentVariable "MXS_CODEROOT" )
			tEnvironment.SetPath "MXS_LIB" ( GetSourceFileName() )
			tEnvironment.SetPath "MXS_TOOLS" ( sysenv.GetEnvironmentVariable "MXS_TOOLS" )
			tEnvironment.SetPath "MXS_STARTUPPATH" ( sysenv.GetEnvironmentVariable "MXS_STARTUPPATH" )
			tEnvironment.SetPath "MXS_ASSEMBLIES" ( sysenv.GetEnvironmentVariable "MXS_ASSEMBLIES" )
			tEnvironment.SetPath "PYTHONPATH" ( sysenv.GetEnvironmentVariable "PYTHONPATH" )
			tEnvironment.SetPath "MXS_STARTUP_SCRIPTS" ( sysenv.GetEnvironmentVariable "MXS_STARTUP_SCRIPTS" )
			
			this._environments.SetValue ( toLower( envId ) ) tEnvironment
		),
		
		fn ReloadAll =
		(
			/*DOC_--------------------------------------------------------------------
			Takes the current libraries that have been loaded and reloads them
			using the latest environment
			
			Args:
				reloadLibraries (boolean)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			for tLibName in this._libraries do
			(
				this.Using tLibName reload:True
			)
		),
		
		fn RemovePathTemplates inPath inEnvironment:"" inCustomKeys:#() inCustomValues:#() =
		(
			/*------------------------------------------------------------
			Removes templates from the inputed path string
			
			Arguments:
				inPath: (string) description
			
			Kwargs:
				inEnvironment: (string) description
				inCustomKeys: (array[String]) description
				inCustomValues: (array[String]) description
			
			Returns: 
				outName (String) : modified file path
			
			See Also:
				this.GetPath()
			------------------------------------------------------------*/
			
			local tSplit = filterstring inPath "[]"
			local outName = ""
			
			for tPart in tSplit do
			(
				if ( toLower tPart == "username" ) then
				(
					tPart = sysinfo.username
				)
				else if ( this.IsPath tPart ) then
				(
					tPart = this.GetPath tPart inEnvironment:inEnvironment
				)
				else if ( findItem inCustomKeys tPart != 0 ) then
				(
					tPart = ( inCustomValues[ findItem inCustomKeys tPart ] as string )
				)
				
				outName += tPart
			)
			
			outName
		),
		
		fn GetToolList =
		(
			/*DOC_--------------------------------------------------------------------
			Using the MXS_TOOLS path this generates a list of tool names from the subdirectories
			of the multiple paths within the MXS_TOOLS value. A dictionary is also generated associating
			the toolname with a path to the MaxScript file within each tool directory.
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			this.toolList = #() -- clear the tool list
			this.toolDict = dotNetObject "System.Collections.Hashtable"
			
			local out = #()
			local pathArr = ( FilterString ( this.GetPath #MXS_TOOLS ) ";" )
			
			for p in pathArr do
			(
				if p[p.count] != "/" then p = ( p + "/" )
				
				local dirArr = GetDirectories (( pathConfig.NormalizePath p ) + "*" )
				
				for dir in dirArr where ( GetFiles ( dir + "\\*.ms" )).count != 0 do
				(
					local toolName = ( TrimRight ( pathConfig.stripPathToLeaf dir ) "\\" )
					
					if not toolDict.containsKey toolName then
					(
						toolDict.add toolName dir
						
						append out toolName
					)
				)
			)
			
			this.toolList = out
		),
		
		fn GetTool toolName =
		(
			/*DOC_--------------------------------------------------------------------
			Gets the path to the MaxScript associated with the toolname
			
			Args:
				toolName (string)
			
			Returns:
				( string ) | undefined : path to MaxScript file or undefined
			
			--------------------------------------------------------------------_END*/
			
			if this.toolDict.containsKey toolName then
			(
				local toolDir = this.toolDict.item[toolName]
				
				local sFile = ( GetFiles (toolDir + "\\*.ms" ))[1]
					
				if DoesFileExist sFile then
				(
					return sFile
				)
			)
			else
			(
				MessageBox ( "No tool matches the given name: " + ( toolName as string )) title:"mxs Error"
			)
			
			undefined
		),
		
		fn RunTool toolName =
		(
			/*DOC_--------------------------------------------------------------------
			Looks for the tool by name. If found this does a FileIn on the MaxScript file.
			
			Args:
				toolName (string)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			local sFile = this.GetTool toolName
			
			if sFile != undefined then
			(
				FileIn sFile
			)
		),
		
		fn SetActiveEnvironment environmentID =
		(
			/*DOC_--------------------------------------------------------------------
			If an environment exists with the inputed ID then this sets it as the active environment
			
			Args:
				environmentID (string)
			
			Returns:
				(boolean)
			
			--------------------------------------------------------------------_END*/
			
			local out = false
			local tNormEnv = this._normEnv environmentID
			
			if ( this.debugLevel > 0 ) then print ("[mxsLib].SetActiveEnvironment (" + getSourceFilename() + ")")
			if ( this.debugLevel > 0 ) then format "thisSetActiveEnvironment() environmentID: % NormEnv: %\n" environmentID tNormEnv
			
			if ( tNormEnv != this._activeEnvironment ) then
			(
				if ( this._environments.HasKey tNormEnv ) then
				(
					this._activeEnvironment = tNormEnv
					if ( this.debugLevel > 0 ) then print ("activeEnvironment is: " + tNormEnv)
					out = true
				)
				else ( format "mxs Library: did not set environment: % (environment not found!)\n" tNormEnv )
			)
			else ( format "mxs Library: did not set environment: % (environment already set.)\n" tNormEnv )
			
			out
		),
		
		-------------------------------------------------------------------------------------------------------------
		-- 							mxs CALLBACK DEFINITIONS
		-------------------------------------------------------------------------------------------------------------
		
		fn BroadcastmxsCallback inCallback_type_name =
		(
			/*DOC_--------------------------------------------------------------------
			This method provides a way for you to simulate one of the events and have
			all the callback scripts for it executed
			
			Args:
				inCallback_type_name (string)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			for c in this._callbackArray where (c.type == inCallback_type_name) do
			(
				if (c.filename == undefined) then
				(
					execute ( c.command )
				)
				else
				(
					filein c.filename
				)
			)
		),
		
		fn ShowCallbacks =
		(
			/*DOC_--------------------------------------------------------------------
			This method lists out the current callback scripts in the Listener window.
			
			Args:
				ARG1 (type)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			for c in this._callbackArray do
			(
				format "mxsCallback type:% command:\"%\" id:% filename:%\n" c.type c.command c.id (if c.filename != undefined then ("\"" + c.filename + "\"") else "undefined")
			)
		),
		
		fn RegisterCallback inCallback_type_name inExecuteString id: filename:undefined =
		(
			/*DOC_--------------------------------------------------------------------
			This method is used to register a new callback script. Requires 
			as the first argument a name that specifies which type of notify 
			event this script is associated with 
			The script is supplied either as a direct String or StringStream 
			value containing the text of the script to run, or as a 
			fileName: keyword argument, in which case the named file is 
			loaded and run whenever the event notification callback occurs. 
			You can specify either a direct string or a fileName:, but not both
			The optional id: parameter lets you tag one or a group of callbacks 
			with a unique name so that you can remove them all as a group 
			without interfering with other callbacks, perhaps registered by 
			other scripted tools.
			
			Args:
				inCallback_type_name (name)
				inExecuteString (string)
			
			Kwargs:
				id (name)
				filename (string)
			
			Returns:
				(boolean)
			
			--------------------------------------------------------------------_END*/
				
			if (finditem this._callbackTypes inCallback_type_name == 0) then
			(
				local mxsCallbackID = ("mxs" + (inCallback_type_name as string) ) as name
				
				callbacks.addScript inCallback_type_name ("BroadcastmxsCallback #"+ (inCallback_type_name as string) ) id:mxsCallbackID
				append this._callbackTypes inCallback_type_name
				append this._callbackIDs mxsCallbackID
			)
			
			append this._callbackArray ( mxsCallback type:inCallback_type_name command:inExecuteString id:id filename:filename )
			
			true
		),
		
		fn UnRegisterCallback callbackType: id: =
		(
			/*DOC_--------------------------------------------------------------------
			This method is used to unregister and remove one or more 
			callback scripts. Specifying just a callback event type name 
			removes all the callback scripts for that event. Specifying 
			just an id:<name> removes all callback scripts in all events 
			with that ID. Specifying both limits the ID-based removal to 
			the specified event type.
			Specifying none remove all the mxs callbacks
			
			Kwargs:
				callbackType (name)
				id (name)
			
			Returns:
				(VOID)
			
			--------------------------------------------------------------------_END*/
			
			-- no callbacks ? , nothing to do here!
			if (this._callbackArray.count == 0) then
			(
				return ok
			)
			
			if (callbackType == unsupplied and id == unsupplied) then
			( -- remove all the mxs Callbacks if nothing is passed to the function
				this._callbackArray = #()
			)
			else if (callbackType != unsupplied and id == unsupplied) then
			(-- remove only by type
				for i = this._callbackArray.count to 1 by -1 do
				(
					local callback = this._callbackArray[i]
					if (callback.type == callbackType) then
					(
						deleteItem this._callbackArray i
					)
				)
			)
			else if (callbackType == unsupplied and id != unsupplied) then
			(-- remove only by id
				for i = this._callbackArray.count to 1 by -1 do
				(
					local callback = this._callbackArray[i]
					if (callback.id == id) then
					(
						deleteItem this._callbackArray i
					)
				)
			)
			else if (callbackType != unsupplied and id != unsupplied) then
			(-- remove by type & id
				for i = this._callbackArray.count to 1 by -1 do
				(
					local callback = this._callbackArray[i]
					if (callback.id == id) and (callback.type == callbackType) then
					(
						deleteItem this._callbackArray i
					)
				)
			)
			
			-- if there is no more mxs callbacks for a type given then remove the real callbackFn
			local existingCallbackIDs = for c in this._callbackArray collect c.type
			
			for i = this._callbackTypes.count to 1 by -1 do
			(-- if we don't find anymore callbacks with a specific type , then remove the real callback
				if (finditem existingCallbackIDs this._callbackTypes[i] == 0) then
				(
					local mxsCallbackID = this._callbackIDs[i]
					callbacks.removescripts this._callbackTypes[i] id:mxsCallbackID
					deleteItem this._callbackTypes i
					deleteItem this._callbackIDs i
				)
			)
		),		
		
		fn DateTime separatorDate:"/" separatorTime:":" pathFriendly:False =
		(
			/*DOC_--------------------------------------------------------------------
			To conform log files to CLF format file we need the date in specific format.
			This function converts the current time to the CLF date format file
			
			[dd/MMM/yyyy:hh:mm:ss +-hhmm]
			dd is the day of the month
			MMM is the month
			yyy is the year
			:hh is the hour
			:mm is the minute
			:ss is the seconds
			+-hhmm is the time zone
			
			Kwargs:
				separatorDate (string)
				separatorTime (string)
				pathFriendly (boolean) : If true, returns a string without illegal path characters
			
			Returns:
				(string)
			
			--------------------------------------------------------------------_END*/

			local months = #("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
			
			local infoArray = getLocalTime() 
			local monthStr = (months[infoArray[2] as integer]) as string
			local dayStr = infoArray[4] as string
			local yearStr = infoArray[1] as string
			local hourStr = infoArray[5] as string
			local minutesStr = infoArray[6] as string
			local secondsStr = infoArray[7] as string
			
			-- fill the gaps to conform to the datetime format
			if dayStr.count < 2 then dayStr = "0" + dayStr 
			if monthStr.count < 3 then dayStr = "00" + dayStr 
			if monthStr.count < 2 then dayStr = "0" + dayStr 
			
			
		
			-- for now timezone is fixed
			local timezoneStr = "-0800"
			
			local dateTimeStr = stringStream ""
			
			if not pathFriendly then
			(
				format "%%%%%%%%%%%%" dayStr separatorDate monthStr separatorDate yearStr separatorTime hourStr separatorTime minutesStr separatorTime secondsStr timezoneStr to:dateTimeStr
			)
			else
			(
				local monthStr = infoArray[2] as string -- Path friendly will have an integer val fo the month
				local pathSeparator = "_"
				
				if secondsStr.count < 2 then secondsStr = "0" + secondsStr -- Path friendly will always have double-digit for seconds
				
				format "%%%%%%%" yearStr monthStr dayStr pathSeparator hourStr minutesStr secondsStr to:dateTimeStr
			)
			
			dateTimeStr as string
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
			
			this.LoadConfigData() -- required to build the environment class for searching paths
			this.GetToolList() -- required to find all available tools
			this.printStatus = True
		),
		
		__init__ = _init()
	)
	
	::mxs = mxsLibraryStruct()
)

