
	global octopus
	
	new = dotNetObject
	cls = dotNetClass
	keep = dotNet.setLifetimeControl
	
	-- LOADING FROM DLL
	function loadOctopus = (
		local octopusAssemblyPath = getDir #userscripts + "\\Octopus\\assembly\\octopus.dll"
		local octopusReaderAssembly = (cls "System.Reflection.assembly").Load ((cls "System.IO.File").ReadAllBytes octopusAssemblyPath)
		local dotNetType = octopusReaderAssembly.GetType("Octopus.OctopusInspector") --get Type of className as a dot Net value
		local octopus = (cls "System.Activator").CreateInstance dotNetType
	)
	
	function runOctopus = (
		try (
			octopus.startOctopus "Views"
		)
		catch (
			octopus = loadOctopus()
			keep octopus #dotNet
			octopus.startOctopus "Views"
		)
	)
	runOctopus()	-- STARTING OCTOPUS

