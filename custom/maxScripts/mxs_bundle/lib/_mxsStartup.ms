/*--------------------------------------------------------------------
This contains all of the startup logic for the package.

There are two classes here so that we can decide just how much
to load in during startup. For example, we typically don't need to
source int he entired startup logic if we're just running a render on
the farm.

The DefaultInit struct handles the bare minimum requirements to load
in. Everything that needs to be sourced in 100% of the time should
be brought in with this struct.

The WorkstationInit struct aggregates the DefaultInit, so it will run
that logic first. Then the rest of the logic to initialize the larger
code base is run. 

--------------------------------------------------------------------*/


::_mxsStartup = ""


(
	local SysEnv = ( dotNetClass "System.Environment" )
	
	local _codeRoot = SysEnv.GetEnvironmentVariable "MXS_CODEROOT"

	struct DefaultInit
	(
		fn LoadFilesFromDir dir fileType:".ms*" =
		(
			local fileArr = (GetFiles (dir + ("\\*"+fileType)))
			if fileArr.count != undefined then
			(
				for i in fileArr do
				(
					if (DoesFileExist i) then
					(
						format "Loading File: %\n" (GetFileNameFile i)
						filein i
					)
				)
				True
			)
			else
			(
				False
			)
		),

		fn LoadScriptedPlugins =
		(
			/* 
			load all files in the scripted plugins dir
			 */
			format "|=============== Loading Scripted Plugins ===============|\n"
			local sPluginDir = (_codeRoot + @"\Lib\ScriptPlugins")
			if ( DoesFileExist sPluginDir ) then
			(
				this.LoadFilesFromDir sPluginDir
			)
			else
			(
				format "***** Directory does not exist: % *****\n" sPluginDir
			)
		),
		
		fn DisablePythonByteCode =
		(
			python.execute "
import sys
sys.dont_write_bytecode=True
			"
		),
		
		fn _init =
		(
			this.DisablePythonByteCode()
			
			-- Set the applications process priority to low
			-- This prevents 3dsmax from hogging too many resources and preventing Windows from operating
			sysInfo.MAXPriority = #low
			
			-- ensure that we're always loading scripted plugins			
			this.LoadScriptedPlugins()
		),
		
		init = _init()
	)

	-----------------------------------------------------------------------------------------------------------------------------------

	struct WorkstationInit
	(
		_defInit = DefaultInit(),
		
		fn LoadFilesFromDir dir fileType:".ms*" =
		(
			this._defInit.LoadFilesFromDir dir fileType:fileType
		),
		
		fn LoadRequiredLibs = 
		(
			-- Source in the module system
			fileIn ( _codeRoot + @"\lib\__mxsLib.ms" )
		),
		
		fn PrepTempDir =
		(
			local tempDir = (sysInfo.tempDir + "ToolList\\")
			if ( DoesFileExist tempDir ) then
			(
				local tempFiles = getFiles (tempDir + "*.ms")
				for tempFile in tempFiles do deleteFile tempFile
			)
			else
			(
				makeDir tempDir
			)
		),
		
		fn LoadStartupLibs =
		(
			format "|=============== Loading Startup Scripts ===============|\n"
			
			local startupDir = (_codeRoot + @"\lib\startup")
			
			if ( DoesFileExist startupDir ) then
			(
				this.LoadFilesFromDir startUpDir
			)
		),
		fn _init =
		(
			format "|==================== MXS Starup ====================|\n"
			
			this.LoadRequiredLibs()
			
			this.PrepTempDir()
			
			this.LoadStartupLibs()
				
			format "|========================================================|\n"
		),
		
		init = _init()
	)


	-- if ( GetQuietMode() ) then
	-- (
	-- 	::_maxInit = DefaultInit()
	-- )
	-- else
	-- (
	-- 	::_maxInit = WorkstationInit()
	-- )

	::_mxsStartup = WorkstationInit()

)