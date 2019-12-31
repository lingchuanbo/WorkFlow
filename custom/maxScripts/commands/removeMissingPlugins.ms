-- removeMissingPlugins v0.17 for 3ds Max 2008+
-- (c) 2010-2016 M. Breidt (martin@breidt.net)
--
-- This code is released under "Quote ware" license:
--      If you use this tool in a production environment with a group of more than two people,
--      or have used it in the past under such conditions, then you are obliged to tell 
--      me (martin@breidt.net) about it and allow me to list that project title and your 
--      company name as a reference on my website http://scripts.breidt.net
--
-- Replaces ALL missing plugins in current scene with default objects
-- This makes some pretty drastic changes to your scene, so USE WITH CARE!
--
-- Changes:
-- v0.17	-	added warning message at start

(
	local verStr = "v0.17"
	
	if (queryBox "WARNING!\n\nYou are about to replace any missing plugin instance in the current scene with the first item that is applicable for that type.\n\nThis might result in some drastic scene changes, so ALWAYS USE WITH CARE, KEEP A BACKUP, DO NOT SAVE TO THE SAME FILE NAME and don't blame the author if something breaks!\n\nProceed?" \
	title:("removeMissingPlugins "+verStr+" - Warning!") beep:true \
	) then (
		clearListener()
		-- get list of missing plugin classes
		local str = stringStream ""
		apropos "*missing*" to:str
		seek str 0
		local cls = #()
		while not (eof str) do (
			local ln = readLine str
			local tk = filterString ln " "
			if tk.count == 4 then (
				local clsName = tk[1]
				try (
					local val = (execute clsName)
					local sc = superClassOf val
					-- Alternative: check for .classID == #(-1,0)
					if sc==MAXWrapper or sc==node or sc==material or sc==MAXWrapperNonRefTarg then (
						append cls val
						--format "Using %:%\n" sc val
					) else (
						format "  Ignoring % (%)\n" val sc
					)
				) catch (
					format "Cannot use % for searching missing plugins.\n" clsName
				)
			) else (
				format "Incorrect string found in missing plugin name list: %\n" tk
			)
		)
		if (classof SceneMissingPlugIns)==Interface then (		-- only run this if we have the SceneMissingPlugIns interface
			format "\n-------------- Missing Plugin Information --------------\n"
			format "3ds Max reports the following missing plugin items:\n"
			for i = 1 to SceneMissingPlugIns.GetMissingPlugInCount() do (
				local theName = SceneMissingPlugIns.GetMissingPlugInClassName i
				local theFileName = SceneMissingPlugIns.GetMissingPlugInFileName i
				local theDesc = SceneMissingPlugIns.GetMissingPlugInDescription i
				format "%: % | % | %\n" i theName theFileName theDesc
			)
			format "--------------------------------------------------------\n\n"
		)
			
		-- install callback to collect any freshly created objects
		global rmpCallbackItem = undefined
		gc lite:true

		global rmpNewNodes = #()
		fn CallbackFn ev nd = (
			-- format "Event Detected: Event%, Nodes %\n" ev nd 
			for h in nd do (
				local n = GetAnimByHandle h
				--format "Node = %\n" n
				--if (isValidNode n) then 
				appendIfUnique rmpNewNodes n
			)
		)
		rmpCallbackItem = NodeEventCallback all:CallbackFn
		
		-- now search for instances of those missing plugins
		local c = 0
		local foundMissing = #()
		for j = 1 to cls.count do (
			local cc = cls[j]
			local ci = getClassInstances cc
			if ci.count > 0 then (
				format "Found % instance(s) of %: %\n" ci.count cc ci
				for i = 1 to ci.count do (
					-- get current class
					local myClass = classOf cc
					append foundMissing myClass
					-- get list of all subclasses
					local allClasses = myClass.classes
					local foundReplacement = false
					for k = 1 to allClasses.count do (
						-- search for a matching replacement
						if allClasses[k].creatable then (
							-- create new instance of default (first) class
							newInst = createInstance allClasses[k]
							try (
								-- replace all instances (requires 3ds Max 2008+ or AVG extensions)
								replaceInstances ci[i] newInst
								c += 1
								foundReplacement = true
								-- and exit for k loop
								exit
							) catch (
								format "Error replacing %\n" ci[i]
								format "Exception: %\n" (getCurrentException())
							)
						)
					) -- end: for k
					-- NO useful replacement was found?
					if not foundReplacement then (
						format "WARNING! Could not find a replacement for %\n" myClass
					)
				) -- end: for i
			) -- end: if
		) -- end: for j
		
		if c > 0 then (
			-- produce summary message for user
			str = "Replaced "
			append str (c as string)
			append str " missing plugin(s) with default objects:\n"
			for i in foundMissing do (
				append str "\t\t"
				append str (i as string)
				append str "\n"
			)
			append str "\nUSE RESULT WITH CAUTION!\n\nSAVE TO A DIFFERENT FILE NAME!"
		messageBox str title:("removeMissingPlugins "+verStr) beep:true
			format "\nFound missing plugins of these classes:\n"
			print foundMissing
			format "\n% scene node(s) created as part of the replacement: \n" rmpNewNodes.count
			print rmpNewNodes
			format "\nNote: There might be other changes to the scene, such as render effects etc.\n"
			select rmpNewNodes
		) else (
		messageBox "Good news! No missing plugins found." title:("removeMissingPlugins "+verStr) beep:false
		)
		
		-- clear out callback
		rmpCallbackItem = undefined
		gc lite:true
		OK
	) -- end of if querybox
)
