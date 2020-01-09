/*--------------------------------------------------------------------
This is just a simple initialization script that gets the path to
the main startup file from the environment, which handles
the main startup logic, and it simply does a FileIn on this file.
--------------------------------------------------------------------*/

(
	local SysEnv = ( dotNetClass "System.Environment" )
	local startupLib = SysEnv.GetEnvironmentVariable "MXS_STARTUPPATH"
	
	if ( startupLib != undefined ) and ( DoesFileExist startupLib ) then
	(
		format "***** startupLib: % *****\n"  startupLib
		FileIn startupLib
	)
	else
	(
		format "***** Startup Routine Cannot Find the Startup Lib *****\n"
	)

	format "***** MXS Startup Complete *****\n"
)


