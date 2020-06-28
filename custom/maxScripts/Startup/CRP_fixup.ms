-- CRP persistent global variable and callback removal script
-- version 1.0

::CRP_Authorization = true -- turns off changes to scene by CRP script

fn test_for_CRP_in_startup_scripts =
(
	format "Testing for CRP in startup scripts\n"
	local startup_scripts = getfiles ((getDir #startupScripts) + @"\*.ms")
	local infected_startup_scripts = #()
	local searchFor = "CRP_AScript" + " = \""
	for sf in startup_scripts do
	(
		local f = openfile sf
		local found_CRP = (skipToString f searchFor) != undefined
		close f
		if found_CRP do 
			append infected_startup_scripts sf
	)
	if (infected_startup_scripts.count != 0) do
	(
		local msg = "CRP global variables found in following startup scripts.\n"
		msg += "Recommend shutting 3ds Max down and removing CRP-related\n"
		msg += "lines from these files:\n"
		for f in infected_startup_scripts do
			msg += ("   " + f + "\n")
		format "%" msg
		MessageBox msg title:"CRP Scripts Found"
	)
)

fn test_for_CRP_globals =
(
	format "Testing for CRP persistent globals and callbacks\n"
	callbacks.removeScripts #animationRangeChange  id:#fix_CRP_startup
--	print "=========================================================================================================="
--	callbacks.show()
--	persistents.show()
--	print "=========================================================================================================="
	local the_CRP_globals = #(#CRP_AScript, #CRP_BScript, #CRP_WriteAScript, #CRP_WriteBScript)
	local found_CRP_global = false
	for g in the_CRP_globals while (not found_CRP_global) do found_CRP_global = globalVars.isGlobal g
	if found_CRP_global do
	(
		format "found CRP global variable(s). The following is a list of the CRP callbacks found:\n"
		local logFileName = @"$temp\CRP_callbacks.txt"
		openLog logFileName mode: "w" outputOnly:true
		callbacks.show id:#ID_CRP_preRenderP 		
		callbacks.show id:#ID_CRP_filePostOpenP 	
		callbacks.show id:#ID_CRP_viewportChangeP 	
		callbacks.show id:#ID_CRP_filePostOpen 	
		callbacks.show id:#ID_CRP_filePostMerge 	
		callbacks.show id:#ID_CRP_postImport 		
		closelog()
		local found_CRP_callbacks = false
		local f = openfile logFileName
		while not eof f and not found_CRP_callbacks do
		(
			local l = readline f
			if l != "OK" do found_CRP_callbacks = true
		)
		close f
		deletefile logFileName
		local msg = "CRP global variables found.\nCRP callbacks "
		if not found_CRP_callbacks do msg += "not "
		msg += "found.\nThe presence of these global variables and callbacks\n"
		msg += "will cause data loss and improper operation of 3ds Max.\n"
		if found_CRP_callbacks do 
			msg += "The callbacks may have already resulted in all\nscene lights having been deleted.\n"
		msg += "\nRemove CRP global variables and callbacks?"
		local res = true
		if (not GetQuietMode()) do
			res = queryBox msg title:"CRP Callbacks Found"
		if res do
		(
			-- remove the callbacks
			try(callbacks.removeScripts #preRender 			id:#ID_CRP_preRenderP 			)catch()  
			try(callbacks.removeScripts #filePostOpen 		id:#ID_CRP_filePostOpenP 			)catch()  
			try(callbacks.removeScripts #viewportChange 	id:#ID_CRP_viewportChangeP 	)catch()  
			try(callbacks.removeScripts #filePostOpen 		id:#ID_CRP_filePostOpen		 	)catch() 
			try(callbacks.removeScripts #filePostMerge 		id:#ID_CRP_filePostMerge 			)catch() 
			try(callbacks.removeScripts #postImport 		id:#ID_CRP_postImport 			)catch() 
			-- remove the globals
			for g in the_CRP_globals do globalVars.remove g
			format "CRP global variables and callbacks removed\n"
		)
	)
)

fn test_for_CRP =
(
	test_for_CRP_globals()
	test_for_CRP_in_startup_scripts()
	ok
)

test_for_CRP()

callbacks.removeScripts id:#fix_CRP
 -- #animationRangeChange notification fired after loading mxs persistents, but before the #filePostOpen notification is fired
callbacks.addScript #animationRangeChange "test_for_CRP_globals()" id:#fix_CRP
callbacks.addScript #mtlLibPostOpen "test_for_CRP_globals()" id:#fix_CRP_startup
callbacks.addScript #filePostMerge "test_for_CRP_globals()" id:#fix_CRP
