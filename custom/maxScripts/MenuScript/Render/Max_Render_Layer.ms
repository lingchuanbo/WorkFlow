try(cui.UnRegisterDialogBar panelFloatRo) catch()
try (destroydialog panelFloatRo) catch ()

currentRenderLayer
panelRLPos
panelRLSize
renderLayerRoFn
renderLayersRo
trialModeRo
renderLayerArray
panelFloatRo
panelFloatRo
camIndex = 1
refreshRLRo
getBits
setRenderPresetFn
simpleProp
newLayerProp
defaultExt
properties
configRoFn
setMasterRenderChecks
setMasterPropsChecks
setPropChecks
replaceSlash
replaceInvSlash
configRo
defineInitialSettings
getMasterBits
webbrowserRo
getFolderFromFile
activationRoFn
activationRo
getTrialMode
checkInternetConnection
checkServerConnection
refreshPanelHeight
helpMenu
optBitsMaster
optBitsTo
setMasterOverrideChecks
netWarningRo
netWarning

webSiteUrl = "www.maxrenderlayer.com"
buyUrl = "www.maxrenderlayer.com/buy.html"
helpUrl = "www.maxrenderlayer.com/_help.html"
knownBugsUrl = "www.maxrenderlayer.com/_known_bugs.html"
requestFeatureUrl = "www.maxrenderlayer.com/_request_feature.html"
reportBugUrl = "www.maxrenderlayer.com/_report_bug.html"
bugNetRenderUrl = "www.maxrenderlayer.com/videos/bug_net_render.html"
contactUrl = "www.maxrenderlayer.com/contact.html"
--alanUrl = "www.alancamilo.com/p/reel.html"
downloadUrl = "www.maxrenderlayer.com/download.html"
activationWebFilesPath = "www.maxrenderlayer.com/activation_files/"
checkForUpdatesPath = "www.maxrenderlayer.com/lastUpdateInfo.txt"
createActivationPhpUrl = "maxrenderlayer.com/php/create_activation.php"
configFileRL = (getDir #maxScripts) +"\\max_render_layer_prefs.ini"
versionFileRL = "version.ini"




defaultProperties = #("Light_Properties", "Light_Transforms", "Object_Properties", "Camera_Transforms", "Camera_Properties", "Layer_Properties", "Layer_Assignment", "Materials", "Environment", "Anim_Layer_Properties","Render_Setup")
initialPropColor = #(white, yellow, gray, blue, (color 0 120 200), (color 180 170 0), brown, (color 0 170 0), black, orange,red)
defaultPropertiesTips = #()
append defaultPropertiesTips ((substituteString defaultProperties[1] "_" " ")+"\n\nLight parameters such as color, intensity, and shadow settings are recorded with the scene for each light or luminaire.")
append defaultPropertiesTips ((substituteString defaultProperties[2] "_" " ")+"\n\nTransforms such as position, orientation, and scale are recorded for each light.")
append defaultPropertiesTips ((substituteString defaultProperties[3] "_" " ")+"\n\nCurrent Object Properties values are recorded for each object. This includes settings for Advanced Lighting and mental ray.")
append defaultPropertiesTips ((substituteString defaultProperties[4] "_" " ")+"\n\nCamera transform modes such as position, orientation and scale are recorded for each camera.")
append defaultPropertiesTips ((substituteString defaultProperties[5] "_" " ")+"\n\nCamera parameters such as FOV and depth of field, including any corrections made by the Camera Correction modifier are recorded for each camera.")
append defaultPropertiesTips ((substituteString defaultProperties[6] "_" " ")+"\n\nRecords the settings for each layer in the Layer Properties dialog at the time the scene state is saved.")
append defaultPropertiesTips ((substituteString defaultProperties[7] "_" " ")+"\n\nRecords each object's layer assignment.")
append defaultPropertiesTips ((substituteString defaultProperties[8] "_" " ")+"\n\nAll materials and material assignments used in the scene are recorded.")
append defaultPropertiesTips ((substituteString defaultProperties[9] "_" " ")+"\n\nRecords these Environment and Atmosphere Effects settings: Background, Ambient, and Tint colors; Global Lighting  Level; Environment Map; Environment Map on/off state; Exposure Control rollout settings.")
append defaultPropertiesTips ((substituteString defaultProperties[10] "_" " ")+"\n\nRecords Animation Layers parameters.")
append defaultPropertiesTips ((substituteString defaultProperties[11] "_" " ")+"\n\nRecords all Render Setup parameters.")

initialSimpleProp = #{1,3,6,8,11}
initialNewLayerProp = #{1,6,8}
initialDefaultExt = "tga"



fn getFolderFromFile p n =
(
	a = filterString p "\\"
	t = ""
	if (substring a[1] 1 1) as number != undefined do t+= "\\\\"	
	for i =1 to ((a.count - n)) do (	t += (a[i] + "\\"))
	return t		
)


--activation--------------------------------------------------------------------------------------------------------------
actPathFile = (getFolderFromFile (getDir #maxScripts) 3)+"3DSmax.ini" -- contem o path para os arquivos abaixo
actLaunchFile = "$maxScripts\\plugcfg\\"+"boneTools.ini" --contem numero de launchs
actIdFile = "$maxScripts\\plugcfg\\"+"EditPolyTool.ini" -- contem o computer id
actKey = 5649456459456
maxLaunchs = 20
-------------

fn writeEncryptFile filePath contents =
(
	fileTmp = substring filePath 1 (filePath.count - 3)	
	f = createFile fileTmp
	format "%" contents to:f
	close f
	encryptFile fileTmp filePath actKey		
	deleteFile fileTmp	
)

fn readEncryptFile filePath =
(
	f = openEncryptedFile filePath actKey
	contents = readLine  f
	close f
	return contents
)

fn setComputerID = 
(
	id = ""
	for i = 1 to 4 do
	(
		n = random 0 9999 as string
		while n.count < 4 do n = "0"+n
		id += n + "-"
	)
	id  = (substring id 1 (id.count-1))
	return id
	
	
)

fn getComputerID =
(
	id = readEncryptFile (readEncryptFile actPathFile+actIdFile)
	return id
)

fn checkWebActivationFile file =
(
	/* Http socket open */
	rollout httpSock "httpSock" width:0 height:0
	(
	activeXControl port "Microsoft.XMLHTTP" setupEvents:false releaseOnClose:false
	);
	createDialog httpSock pos:[-100,-100];
	destroyDialog httpSock;

	--for?a refresh
	rd = random 0 9999 as string
		
	/* HTTP socket connect */
	httpSock.port.open "GET" (file+"?rd="+rd as string) false;
	httpSock.port.send();

	/* HTTP socket return */
	if httpSock.port.responsetext == "this computer is activated" then
	(
		return true
	) else 
	(
		return false
	)
	
)

fn checkActivation email =
(
	--verifica path file
	if doesFileExist actPathFile == false do
	(
		writeEncryptFile actPathFile (getFolderFromFile (getDir #maxScripts) 1)			
	)

	actIdPath = (readEncryptFile actPathFile+actIdFile)
	if doesFileExist actIdPath == false do
	(
		writeEncryptFile actIdPath (setComputerID())
	)
	
	actLaunchPath = (readEncryptFile actPathFile+actLaunchFile)
	if doesFileExist actLaunchPath == false do
	(
		writeEncryptFile actLaunchPath 0	
	)
	
	launchs = (readEncryptFile actLaunchPath) as number
	id = readEncryptFile actIdPath
	activationWebFile = email+"_"+id+".activation"
	
	
-- 	print ("launchs "+launchs as string)
	
	if launchs  >= 1 do isActivated = true
	
	if (checkInternetConnection()) then
	(
-- 		print "encontrou google"
		if (checkServerConnection()) then
		(
-- 			print "encontrou site"
-- 			print (activationWebFilesPath+activationWebFile)
			--checa activation web file
			if checkWebActivationFile ("http://"+activationWebFilesPath+activationWebFile) then
			(
-- 				print "encontrou activation file"
				--launch = 20
				writeEncryptFile actLaunchPath maxLaunchs
			) else 
			(
-- 				print "nao encontrou"
				writeEncryptFile actLaunchPath 0
			)
		) else (
			--n?o subtrai launchs
			
		)
	) else
	(
		--subtrai launchs --
		writeEncryptFile actLaunchPath (launchs - 1)
	)
	
	launchs = (readEncryptFile actLaunchPath) as number
	global panelName = "Max Render Layer"
	if launchs >=1 then
	(
		activated = true
		panelName += " - Activated"
		--panelName += " - Activated ("+launchs as string+")"
	) else (
		activated = false		
		panelName += " - Trial"
		--se estava ativado e chegou no 0, avisa usu?rio  
		if isActivated == true and email != "" do 
		(
			destroydialog activationRo
			messagebox "Max Render Layer\n\nIt was not possible to check your activation.\nPlease check your internet connection, make sure there is no antivirus or firewall blocking 3DS MAX from having internet access and restart Max Render Layer."		
		)
	)
	
-- 	print ("activated "+activated as string)
-- 	print ("launchs "+launchs as string)
	
	return activated

)

fn activateLicense email id activate=
(	
	if (checkInternetConnection()) then
	(
-- 		print "encontrou google"
		if (checkServerConnection()) then
		(
				
			/* Http socket open */
			rollout httpSock "httpSock" width:0 height:0
			(
			activeXControl port "Microsoft.XMLHTTP" setupEvents:false releaseOnClose:false
			);
			createDialog httpSock pos:[-100,-100];
			destroyDialog httpSock;

				--for?a refresh
			rd = random 0 9999 as string
			
			/* HTTP socket connect */
			httpSock.port.open "GET" ("http://"+createActivationPhpUrl as string+"?rd="+rd as string+"&client_email="+email as string+"&computer_id="+id as string+"&do_activate="+activate as string+"") false;
			httpSock.port.send();

			/* HTTP socket return */
			result = substring httpSock.port.responsetext (findString  httpSock.port.responsetext "#") ((httpSock.port.responsetext).count)
			compileResult = execute ("\""+result+"\"")
			
			--print compileResult
			
			return (execute(compileResult))
		) else (
			createdialog serverOutRo  350 120	panelRLPos[1] panelRLPos[2]	
		)
	) else (
		destroydialog activationRo
		messagebox "It was not possible to check your activation.\nPlease check your internet connection, make sure there is no antivirus or firewall blocking 3DS MAX from having internet access and restart Max Render Layer."		
	)
)

fn getTrialMode =
(
	if panelFloatRo.title == "Max Render Layer - Trial" then
	(
		return "trial"
	) else (
		return "full"
	)
)
--------------------------------------------------------------



---cria data current layer
fn hasRenderLayerDataFn =
(
	ii = 1
	i = ""
	global RenderLayerDataTracks = #()
	while i != undefined do
	(
		i = (custAttributes.getdef globaltracks ii)
		ii += 1
	)
	ii -= 2
	hasRenderLayerData = false
	for i = 1 to ii do
	(
		if ((custAttributes.getdef globaltracks i).name) == "RenderLayerData" do
		(
			hasRenderLayerData = true
			append RenderLayerDataTracks i
		)
	)
	return hasRenderLayerData
)

fn hasAnyRenderLayerDataFn =
(	
	has = false
	if hasRenderLayerDataFn() == true do
	(
		has = true
		
		if hasProperty globaltracks.RenderLayerData "currentRenderLayer" == false do has = false

	)
	return has
)	

fn checkInternetConnection =
(
	if (internet.CheckConnection url:("http://www.google.com") force:true) or (internet.CheckConnection url:("http://www.microsoft.com") force:true) or (internet.CheckConnection url:("http://www.youtube.com") force:true) then
	(
		return true
	) else 
	(
		return false
	)
)

fn checkServerConnection =
(
	if (internet.CheckConnection url:("http://"+webSiteUrl) force:true) then
	(
		return true
	)else 
	(
		return false
	)

)

struct rolloutCreatorCustom
(
	-- variables
	name, caption, str, def, width, height, quote="\"", category,
	
	-- functions
	fn begin = 
	( 
		if name == undefined then
		(
			__rcCounter += 1
			name = "rolloutCreator" + __rcCounter as string
		)
		if caption == undefined then caption = ""
		str = ""
	),
	
	fn addLocal name init: = 
	(
		local dStr = "\tlocal " + name as string
		if init != unsupplied then append dStr (" = " + init as string)
		append dStr "\n"
		append str dStr
	),

	fn addControl type name caption paramStr:"" =
	(	
		append str ("\t" + type as string + " " + name as string + " " + quote + caption + quote + paramStr + "\n")
	),
	
	fn strFilter codeStr =
	(
			local last_is_at = codeStr[codeStr.count] == "@"
			local fltStr = filterString codeStr "@"
			local rep = "\""
			codeStr = (if (codeStr[1] == "@") then rep else "") + fltStr[1]
			for i=2 to fltStr.count do
			(
				append codeStr (rep + fltStr[i])
			)
			if last_is_at then append codeStr rep
			codeStr
	),

	fn addHandler ctrl event paramStr:"" filter:on codeStr:"" =
	(
		if filter do codeStr = (strFilter codeStr)
		append str ("\non " + ctrl as string + " " + event as string + " " + paramStr as string + " do \n(\n" + codeStr + ";ok\n)\n")
	),
	
	fn addText txt filter:on =
	(
		if filter do txt = (strFilter txt )
		append str ("\t " + txt + "\n")
	),
	
	fn end = 
	( 
		local dStr = "rollout " + name + " " + quote + caption + quote 
		if width != undefined then
			append dStr (" width:" + width as string)
		if height != undefined then
			append dStr (" height:" + height as string)
		if category != undefined then
			append dStr (" category:" + category as string)
		append dStr "\n(\n" 
		append dStr str
		append dStr "\n)\n"
		str = dStr
		def = execute str
	)
)

fn getBitConfig c =
(
	bits = #{}
	for u =1 to defaultProperties.count do
	(
		if execute("configRo."+c+defaultProperties[u]+".checked") == true do
		(
			append bits u
		)
	)
	return bits as string
)

fn saveConfigIni =
(
	setINISetting configFileRL "defaults" "newLayerProp" (getBitConfig "newLayerProp")
	setINISetting configFileRL "defaults" "simpleProp" (getBitConfig "simpleProp")
	--salva default extension
	if configRo.btEXTENSION.visible == true then
	(
		setINISetting configFileRL "defaults" "extension" configRo.btEXTENSION.text
	) else (
		setINISetting configFileRL "defaults" "extension" configRo.btEXTENSIONLIST.selected
	)
	defineInitialSettings()
)

fn simplePropFn =
(
	c = (GetINISetting configFileRL "defaults" "simpleProp") 
	if c != "" then
	(
		return execute c
	) else (
		return initialSimpleProp 
	)
)

fn newLayerPropFn =
(
	c = (GetINISetting configFileRL "defaults" "newLayerProp") 
	if c != "" then
	(
		return execute c 
	) else (
		return initialNewLayerProp
	)
)

fn defaultExtFn =
(
	c = (GetINISetting configFileRL "defaults" "extension") 
	if c != "" then
	(
		return c
	) else (
		return initialDefaultExt
	)
)

fn defaultPropFn p =
(
	tmp = #{}
	for i =1 to p.count do
	(
		if p[i] == true do append tmp (findItem properties defaultProperties[i])
	)
	return tmp
)

fn setInitialPropChecks =
(
		for u =1 to defaultProperties.count do
		(	
			execute("configRo.simpleProp"+properties[u]+".checked = "+(defaultPropFn simpleProp)[u] as string+"")
			if (defaultPropFn simpleProp)[u] == true do execute("configRo.simpleProp"+properties[u]+".caption = \"\"")	
			execute("configRo.newLayerProp"+properties[u]+".checked = "+(defaultPropFn newLayerProp)[u] as string+"")
			if (defaultPropFn newLayerProp)[u] == true do execute("configRo.newLayerProp"+properties[u]+".caption = \"\"")				
		)
)

fn defineInitialSettings =
(
	global simpleProp = simplePropFn()
	global newLayerProp = newLayerPropFn()
	global defaultExt = defaultExtFn()

	global fullRoWidth = 1400
	global simpleRoWidth = (250+(((simpleProp as array).count)*12))
	--sort properties
	global properties = #()
	global propertiesTips = #()
	tmpColor = #()
	for i = 1 to defaultProperties.count do if simpleProp[i] == true do (append properties defaultProperties[i]; append propertiesTips defaultPropertiesTips[i]; append tmpColor initialPropColor[i])
	for i = 1 to defaultProperties.count do if simpleProp[i] == false do (append properties defaultProperties[i]; append propertiesTips defaultPropertiesTips[i]; append tmpColor initialPropColor[i])
	global propColor = tmpColor

)

fn getRenderPresetCheck l =
(
	if l != "MASTER LAYER" then 
	(
		if execute("renderLayersRo.bt"+((findItem renderLayerArray l) as string+ "Render_Setup.checked")) == true do return true
	) else (
		return true
	)
--		if doesFileExist  (maxFilePath +"render_layer_presets"+ "/"+l+".rps") do  return true
)

fn refreshRenderLayerArray =
(
	global renderLayerArray = #()
	totalLayers = sceneStateMgr.GetCount()
	if getTrialMode() == "trial" and totalLayers >3 do totalLayers = 3
	for i = 1 to totalLayers do
	(
		n = (sceneStateMgr.GetSceneState i)
		if n != "MASTER LAYER" do append renderLayerArray n
	)
	sort renderLayerArray
)	

fn loadMasterProp l p =
(
	--print l
	if l == currentRenderLayer then
	(
		b = #{}
		append b (findItem defaultProperties p)
		sceneStateMgr.Restore "MASTER LAYER" b
	)	
)

fn checkMasterRenderSetup =
(	
	dir = maxFilePath +"render_layer_presets"
	if maxFilePath != "" then
	(
		if doesFileExist  (maxFilePath +"render_layer_presets/MASTER LAYER.rps") == false do
		(
			makedir dir
			renderPresets.SaveAll 0 (dir + "/MASTER LAYER.rps")
		)
	)			
)
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


fn refreshRLProps l =
(
	with redraw off 
	(
		sceneStateMgr.Capture currentRenderLayer (getBits currentRenderLayer)
		if l != currentRenderLayer then
		(				
			sceneStateMgr.Restore "MASTER LAYER" (getBits currentRenderLayer)
			sceneStateMgr.Restore l (getBits l)	
			sceneStateMgr.Capture l (getBits l)	
			sceneStateMgr.Restore "MASTER LAYER" (getBits l)
			sceneStateMgr.Restore currentRenderLayer (getBits currentRenderLayer)	
			--render setup
			deleteFile (maxFilePath +"render_layer_presets"+ "/"+l+".rps")			
		) 
		
	)
	max views redraw 

)

fn changeRLFn f t =
(
-- 	with redraw off 
-- 	(	
	displayColor.shaded = #object
	
	nf = findItem renderLayerArray f
	if nf == 0 do nf = "MASTER_LAYER"
	execute("renderLayersRo.bt"+(nf as string+"mainbutton")+".checked = false")
	global lastChecked = t
	nt = findItem renderLayerArray t
	if nt == 0 do nt = "MASTER_LAYER"
	execute("renderLayersRo.bt"+(nt as string+"mainbutton")+".checked = true")
		
	if f != t then
	(
		
		if sceneStateMgr.Delete f do
		(
			if sceneStateMgr.Capture f (getBits f) do
			(

				currentRenderLayer = t
				globaltracks.RenderLayerData.currentRenderLayer = currentRenderLayer

				--save presets
				dir = maxFilePath +"render_layer_presets"
				if maxFilePath != "" then
				(
					if getRenderPresetCheck f == true then
					(
						checkMasterRenderSetup()
						makedir dir
						renderPresets.SaveAll 0 (dir + "/"+f+".rps")
						setRenderPresetFn f
						--print "00"
					)else (
						--print "0"
						deleteFile (maxFilePath +"render_layer_presets"+ "/"+f+".rps")
					)
					if getRenderPresetCheck t == true and t != "MASTER LAYER" then	(
						--print "1"
						renderpresets.LoadAll 0 (dir + "/"+t+".rps")
					) else if getRenderPresetCheck f == true and getRenderPresetCheck t == undefined and f != "MASTER LAYER" then (
						--print "2"
						renderpresets.LoadAll 0 (dir + "/MASTER LAYER.rps")
					) else if t == "MASTER LAYER" and getRenderPresetCheck f == true then	(
						--print "3"
						renderpresets.LoadAll 0 (dir + "/MASTER LAYER.rps")
					)
				) else if getRenderPresetCheck f == true and f != "MASTER LAYER" then (
					messagebox "You need to save the Max file in order to use Render Setup."
					setAllPropsEnabled false "Render_Setup"
					setMasterPropsChecks()
				)
				--
		--  		print ("bits "+(getBits f) as string+", "+(getBits t) as string)
				if f == "MASTER LAYER" then
				(
					sceneStateMgr.Restore t (getBits t)	
					
					print ("salvou from "+(getBits f) as string)
					print ("loadou master nada")
					print ("loadou to "+((getBits t) as string))
					print "----------------------"			
				) else if t == "MASTER LAYER" then
				(
					sceneStateMgr.Restore t (getBits f)
					
					print ("salvou from "+(getBits f) as string)
					print ("loadou master nada")
					print ("loadou to "+((getBits f) as string))
					print "----------------------"	
				) else
				(			
					sceneStateMgr.Restore "MASTER LAYER" (optBitsMaster (getBits f) (getBits t))
					sceneStateMgr.Restore t (optBitsTo (getBits f) (getBits t))				
									
					print ("salvou from "+(getBits f) as string)
					print ("loadou master "+(optBitsMaster (getBits f) (getBits t)) as string)
					print ("loadou to "+((optBitsTo (getBits f) (getBits t)) as string))
					print "----------------------"	
				)
			)
		)
	)else
	(
		sceneStateMgr.Restore t (getBits t)
	)
		
		
	displayColor.shaded = #material

		--sceneStateMgr.RestoreAllParts "MASTER LAYER"
-- 		sceneStateMgr.RestoreAllParts t 
		
-- 	)
	--max views redraw 
)

fn deleteRLFn l =
(
	with redraw off 
	(				
		if currentRenderLayer ==  l then 
		(	
			currentRenderLayer = "MASTER LAYER"
			sceneStateMgr.Restore "MASTER LAYER" (getBits l)
			globaltracks.RenderLayerData.currentRenderLayer = currentRenderLayer
		) 
		
		sceneStateMgr.Delete l
		batchRenderMgr.DeleteView (batchRenderMgr.FindView l)
		deleteFile (maxFilePath +"render_layer_presets"+ "/"+currentRenderLayer+".rps")
		
		refreshRLRo l 0 "panel"		
	)
	max views redraw 
)

fn createRLFn l =
(

	--checa se ja existe o layer
	refreshRenderLayerArray()
	if getTrialMode() == "trial" and renderLayerArray.count >=2 then
	(
		createdialog trialModeRo  350 120	panelRLPos[1] panelRLPos[2]	
	) else (
		newLayerName = l
		u = false
		n = 1
		while u == false do
		(
			for i in renderLayerArray do
			(
				if newLayerName as name == i as name do u = true
			)
			if u == true then
			(
				newLayerName = l+n as string
				n += 1
				u = false
			) else (
				u = true
			)
		)
		if currentRenderLayer == "MASTER LAYER" then
		(
			sceneStateMgr.Capture currentRenderLayer (getBits currentRenderLayer)
			--sceneStateMgr.Capture currentRenderLayer (newLayerPropFn() as string)
			print ((getBits currentRenderLayer) as string)
		) else (
			sceneStateMgr.Capture currentRenderLayer (getBits currentRenderLayer)
		)
		sceneStateMgr.Capture newLayerName #{}
		b = batchRenderMgr.CreateView (viewport.getCamera())
		b.name = newLayerName
		b.sceneStateName = newLayerName
		b.startFrame = animationrange.start
		b.endFrame = animationrange.end
			
		m = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
		b.outputFilename = m.outputFilename + newLayerName+"_."+defaultExtFn()	
		
			
		currentRenderLayer = newLayerName
		globaltracks.RenderLayerData.currentRenderLayer = currentRenderLayer	
			
		refreshRLRo 0 newLayerName "panel"
	)
)

fn refreshRLRo deleted created type = --refresh o rolout render layers
(
	
	bitProps = #()
	for i = 1 to renderLayerArray.count do
	(
		if type == "props" then
		(
			bitProp = sceneStateMgr.GetParts renderLayerArray[i]
		) else (
			bitProp = #{}
			for u =1 to defaultProperties.count do
			(	
				if (execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".checked")) == true do append bitProp u
				
			)
		)
		append bitProps bitProp
	)
	if deleted != 0 do 
	(
		deleteItem bitProps (findItem renderLayerArray deleted)		
	)
	refreshRenderLayerArray()
	-- se criou novo layer
	if created != 0 do 
	(
		insertItem newLayerProp bitProps (findItem renderLayerArray created)
		dir = maxFilePath +"render_layer_presets"
		if maxFilePath != "" then
		(
			if newLayerProp[11] == true then
			(
				checkMasterRenderSetup()
				makedir dir
				renderPresets.SaveAll 0 (dir + "/"+created+".rps")
				setRenderPresetFn created
			)	
		)else if newLayerProp[11] == true then (
			messagebox "You need to save the Max file in order to use Render Setup."
		)
	)

	refreshPanelHeight()
	if renderLayersRo != undefined do removerollout renderLayersRo		
	AddSubRollout panelFloatRo.subRo (renderLayerRoFn panelFloatRo.collapseBt.checked) rolledUp:false	
	setMasterRenderChecks()
	if panelFloatRo.collapseBt.checked do setMasterOverrideChecks()
	setPropChecks bitProps
	setMasterPropsChecks()	
	
)
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

fn getCameraListFn type = 
(
	names = #("viewport")
	nodes = #(undefined)
	for i in $* do
	(
		if classof i == Targetcamera or classof i == Freecamera do
		(
			append names i.name
			append nodes i
		)
	)
	if type == "names" do return names
	if type == "nodes" do return nodes
)

fn setRenderEnabled i arg = 
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
	b.enabled = arg
)

fn setAllRenderEnabled arg =
(
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		b.enabled = arg
		execute("renderLayersRo.bt"+(i as string+"check")+".checked = "+arg as string+"")
	)
)

fn setMasterRenderChecks =
(
	masterCheck = true
	for i = 1 to renderLayerArray.count do
	(
		if execute("renderLayersRo.bt"+(i as string+"check")+".checked") == false do
		(
			masterCheck = false
		)
	)
	execute("renderLayersRo.btMASTER_LAYERcheck.checked = "+masterCheck as string+"")
)

fn setOverrideEnabled i arg = 
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
	b.overridePreset  = arg
)

fn setOverrideOptionsEnabled arg i =
(
	execute("renderLayersRo.bt"+(i as string+"startframe")+".visible = "+arg as string)
	execute("renderLayersRo.bt"+(i as string+"endframe")+".visible = "+arg as string)
	execute("renderLayersRo.bt"+(i as string+"width")+".visible = "+arg as string)
	execute("renderLayersRo.bt"+(i as string+"height")+".visible = "+arg as string)
	execute("renderLayersRo.bt"+(i as string+"pixel")+".visible = "+arg as string)

)

fn setAllOverrideEnabled arg =
(
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		b.overridePreset = arg
		execute("renderLayersRo.bt"+(i as string+"override")+".checked = "+arg as string+"")
		setOverrideOptionsEnabled arg i
	)
)

fn setMasterOverrideChecks =
(
	masterCheck = true
	for i = 1 to renderLayerArray.count do
	(
		if execute("renderLayersRo.bt"+(i as string+"override")+".checked") == false do
		(
			masterCheck = false
		)
	)
	execute("renderLayersRo.btMASTER_LAYERoverride.checked = "+masterCheck as string+"")
)

fn setAllPropsEnabled arg prop =
(
	for i = 1 to renderLayerArray.count do
	(
		execute("renderLayersRo.bt"+(i as string+prop as string)+".checked = "+arg as string+"")
		if arg == true then 
		(
			execute("renderLayersRo.bt"+(i as string+prop as string)+".caption = \"\"")
		) else (
			execute("renderLayersRo.bt"+(i as string+prop as string)+".caption = \""+(substring prop 1 1) as string+"\"")
		)
		if renderLayerArray[i] != currentRenderLayer then
		(
			refreshRLProps renderLayerArray[i]
		) else (
			loadMasterProp renderLayerArray[i] prop
		)
	)
)

fn setMasterPropsChecks =
(
	
	for u =1 to defaultProperties.count do
	(
		masterCheck = true
		for i = 1 to renderLayerArray.count do
		(
			if execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".checked") == false do
			(
				masterCheck = false
			)
		)
		execute("renderLayersRo.btMASTER_LAYER"+defaultProperties[u]+".checked = "+masterCheck as string+"")
-- 		if masterCheck == true then
-- 		(
-- 			execute("renderLayersRo.btMASTER_LAYER"+defaultProperties[u]+".caption = \"\"")
-- 		) else (
-- 			execute("renderLayersRo.btMASTER_LAYER"+defaultProperties[u]+".caption = \"\"")
-- 		)
	)
)

fn setRenderPresetFn i =
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
	presetFile = (maxFilePath +"render_layer_presets"+ "/"+i as string+".rps")
	b.presetFile = presetFile
	
)

fn setCam i cam = 
(

		b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
		b.camera = cam

)

fn setAllCam cam = 
(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
		b.camera = (getCameraListFn "nodes")[cam]
	
		cams = getCameraListFn "nodes"
		for i = 1 to cams.count do
		(
			if cams[i] == b.camera do camIndex = i
		)
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		b.camera = (getCameraListFn "nodes")[cam]
		execute("renderLayersRo.bt"+(i as string+"cam")+".selection = "+camIndex as string+"")
	)


)

fn setFrameRange i f type =
(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
		if type == "start" do b.startframe = f
		if type == "end" do b.endframe = f
)

fn setAllFrameRange f type =
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
	if type == "start" do b.startframe = f
	if type == "end" do b.endframe = f
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		if type == "start" do (b.startframe = f; execute("renderLayersRo.bt"+(i as string+"startframe")+".value = "+f as string+""))
		if type == "end" do (b.endframe = f; execute("renderLayersRo.bt"+(i as string+"endframe")+".value = "+f as string+""))
	)
)

fn setWidthHeight i f type =
(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
		if type == "width" do b.width = f
		if type == "height" do b.height = f
)

fn setAllWidthHeight f type =
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
	if type == "width" do b.width = f
	if type == "height" do b.height = f
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		if type == "width" do (b.width = f; execute("renderLayersRo.bt"+(i as string+"width")+".value = "+f as string+""))
		if type == "height" do (b.height = f; execute("renderLayersRo.bt"+(i as string+"height")+".value = "+f as string+""))
	)
)

fn setPixelAspect i p =
(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
		b.pixelAspect = p
)

fn setAllPixelAspect o =
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
	b.pixelAspect = o
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		b.pixelAspect = o		
		execute("renderLayersRo.bt"+(i as string+"pixel")+".value = "+o as string+"")
	)
)

fn setOutputFolder i o =
(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
		b.outputFilename = o
)

fn setAllOutputFolder o =
(
	b = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
	b.outputFilename = o
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		oAll = o
		oAll += execute("renderLayersRo.bt"+(i as string+"mainbutton")+".caption")+"_."+defaultExtFn()
		b.outputFilename = oAll
		
		execute("renderLayersRo.bt"+(i as string+"output")+".text = \""+oAll as string+"\"")
	)
)

fn getOutputFolder i =
(
	ou = findItem renderLayerArray i
	if ou == 0 do ou = "MASTER_LAYER"
	b = batchRenderMgr.GetView (batchRenderMgr.FindView i)
	o = getSavePath ()
	if o != undefined do 
	(
		o = replaceSlash o false
		--print (substring o o.count 1)
		if (substring o o.count 1) != "/" do (o += "/")
		if ou != "MASTER_LAYER" then
		(
			o += execute("renderLayersRo.bt"+(ou as string+"mainbutton")+".caption")+"_."+defaultExt
		) else (
			setAllOutputFolder o
		)
		execute("renderLayersRo.bt"+(ou as string+"output")+".text = \""+o as string+"\"")

		b.outputFilename = o 
	)
	
)

fn replaceSlash t a =
(
	txt = substituteString t "\\" "/"
	if a == true and t!="" and (substring txt txt.count txt.count) != "/" do txt += "/"
	return txt
)

fn replaceInvSlash t a =
(
	txt = substituteString t "/" "\\"
	if a == true and t!="" and (substring txt txt.count txt.count) != "\\" do txt += "\\"
	return txt
)

fn getBits l =
(
	bits = #{}
	if l == "MASTER LAYER" then
	(
		if renderLayerArray.count == 0 then --se n?o houver layer ele pega o default bits
		(
			bits = newLayerPropFn()
		) else (
			for i = 1 to renderLayerArray.count do
			(
				for u =1 to defaultProperties.count-1 do
				(
					bits = join bits (sceneStateMgr.GetParts renderLayerArray[i])
				)
			)
		)
	) else (
		i = findItem renderLayerArray l
		for u =1 to defaultProperties.count-1 do
		(
			if execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".checked") == true do
			(
				append bits u
			)
		)
	)
	return bits
)

fn getNegBits l =
(
	b = sceneStateMgr.GetParts l 
	b.count = defaultProperties.count 
	return -b
)

fn optBitsMaster f t =
(
	return (f-t)	
)

fn optBitsTo f t =
(
	return (join f t)-(f-t)
)

fn checkMasterBits b =
(
	if (sceneStateMgr.GetParts "MASTER LAYER")[(findItem defaultProperties b)] != true do
	(
		tmpLayer = currentRenderLayer
		changeRLFn currentRenderLayer "MASTER LAYER"
		changeRLFn "MASTER LAYER" tmpLayer
	)
)

fn setPropChecks bitProps =
(
	for i = 1 to renderLayerArray.count do
	(
		for u =1 to defaultProperties.count do
		(	
			if defaultProperties[u] != "Render_Setup" then
			(
				execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".checked = "+bitProps[i][u] as string+"")
				if bitProps[i][u] == true do execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".caption = \"\"")
			) else (
				if doesFileExist  (maxFilePath +"render_layer_presets"+ "/"+renderLayerArray[i]+".rps") do
				(
					execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".checked = true")
					execute("renderLayersRo.bt"+(i as string+defaultProperties[u])+".caption = \"\"")
				)
			)	
		)
	)
)

fn makeOutputDirs =
(
	for i = 1 to batchRenderMgr.numViews do
	(		
		b = batchRenderMgr.GetView i
		if b.enabled == true do
		(
				dir = (getFolderFromFile b.outputFilename 1)
				makedir dir
		)
	)
	
)

fn somethingToRender =
(
	fireRender = false
	for i=1 to batchRenderMgr.numViews do
	(
		if (batchRenderMgr.GetView i).enabled == true do fireRender = true	
	)
	return fireRender
)

fn batchRenderFn =
(
	makeOutputDirs()
	if batchRenderMgr.netRender and netWarning != true then
	(
		actionMan.executeAction -43434444 "4096"  -- Render: Batch Render Dialog Toggle
		createdialog netWarningRo  410 200  panelRLPos[1] panelRLPos[2]
		netWarning = true
	) else (		
		--tmpTime = rendTimeType
		--rendTimeType = 2 --corrige erro de mandar sem seq
		tmpLayer = undefined
		if currentRenderLayer != "MASTER LAYER" do (tmpLayer = currentRenderLayer; changeRLFn currentRenderLayer "MASTER LAYER")
		if somethingToRender() then
		(
			batchRenderMgr.Render()
		) else (
			messagebox "Please enable at least one render layer by checking the \"R\" button at the left side of the layer button."
		)
		if tmpLayer != undefined do (changeRLFn "MASTER LAYER" tmpLayer)
		--rendTimeType = tmpTime
	)
)


fn savePreviewData =
(
	global outputFolders = #()
	global startFrames = #()
	global endFrames = #()
	global tmpTime = rendTimeType
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		append outputFolders b.outputFilename
		append startFrames b.startFrame
		append endFrames b.endFrame

	)
	
)

fn setCurrentPreviewData =
(
	rendTimeType = tmpTime
	for i = 1 to renderLayerArray.count do
	(
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		b.outputFilename = outputFolders[i]
		b.startFrame = startFrames[i]
		b.endFrame = endFrames[i]
	)
)

fn setTmpPreviewData =
(	
	global iflString = ""
	global renderFiles = #()
	for i = 1 to renderLayerArray.count do
	(		
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		if b.enabled == true do
		(
			oAll = (replaceSlash (GetDir #renderoutput) false)
			file = "preview_"+i as string+"."+defaultExtFn()
			oAll += "/" + file
			b.outputFilename = oAll
			frame = ((currentTime as integer)/TicksPerFrame) as string
			b.startFrame = currentTime
			b.endFrame = currentTime
			--while frame.count < 4 do frame = "0"+frame 
			--file = "preview_"+i as string+frame+"."+defaultExtFn()
			file = "preview_"+i as string+"."+defaultExtFn()
			iflString +=  file + "\n"
			append renderFiles file
			rendTimeType = 1
		)
	)
)

fn previewRenderFn =
(
	--grava dados
	savePreviewData()
	--aplica temporario
	setTmpPreviewData() 
	--render
	tmpNet = batchRenderMgr.netRender
	batchRenderMgr.netRender = false
	batchRenderFn()	
	batchRenderMgr.netRender = tmpNet
	--retorna dados
	setCurrentPreviewData()
	--write ifl file
	filename=(GetDir #renderoutput)+"/preview.ifl"
	thefile= fopen filename "wt"
	writestring thefile iflString
	fseek thefile -1 #seek_current
	writeshort thefile 2573 #signed
	fclose thefile 
	--abre ram player
	if renderFiles.count == 2 then
	(
		RAMPlayer ((replaceSlash (GetDir #renderoutput) false)+"/"+renderFiles[1]) ((replaceSlash (GetDir #renderoutput) false)+"/"+renderFiles[2])
	) else if renderFiles.count > 2 then (
		RAMPlayer ((replaceSlash (GetDir #renderoutput) false)+"/preview.ifl") ""
	)
)

fn activationRoFn =
(
	print "activationRoFn"
	destroydialog activationRo
	print "activationRo"
	print (activationRo as string)
	print (panelRLPos as string)
	createdialog activationRo  450 70 panelRLPos[1] panelRLPos[2]	
	print "activationRo2"
	
)

fn setButtonsVisibility arg =
(
	panelFloatRo.btBUY.visible = arg
	panelFloatRo.btACTIVATE.visible = arg
	panelFloatRo.btHELP.visible = arg
)


fn renderLayerRoFn c = --cria dinamicamente o rolout dos render layers
(
	r = rolloutCreatorCustom "renderLayersRo" "Render Layers" category:3
	r.begin()
	p = 5
	
	
	--MASTER LAYER
	
		str = ""
		if currentRenderLayer == "MASTER LAYER" do
		(
			str += " checked:true"
			global lastChecked = "MASTER LAYER"
		)	
		
		b = batchRenderMgr.GetView (batchRenderMgr.FindView "MASTER LAYER")
		cams = getCameraListFn "nodes"
		for i = 1 to cams.count do
		(
			if cams[i] == b.camera do camIndex = i
		)
		
	if c == true do p+=20
	
	--R
		bt = ("btMASTER_LAYER"+"check") as name
		r.addControl #checkbutton bt "" paramStr:("border:false pos:[5,"+ p as string +"] width:30 height:19 checked:"+b.enabled as string+" tooltip:\"Enable/Disable all layers for batch render\"")
		r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setRenderEnabled \"MASTER LAYER\" false; setAllRenderEnabled arg")
		
		--LAYER NAME
		bt = ("btMASTER_LAYER"+"mainbutton") as name
		r.addControl #checkbutton bt "MASTER LAYER" paramStr:("border:false pos:[40,"+ p as string +"] width:150 height:19 "+str+"")
		r.addHandler bt #changed filter:on paramStr:"state" codeStr:("changeRLFn currentRenderLayer \"MASTER LAYER\"")
		
		
		
		h = 195
		if renderLayerArray.count < 1 do h = 10000
		 s=0
		for u = 1 to properties.count do
		(
			if c != true and u > simpleProp.numberset  then (
				hL = 1000
				h -= 12
			) else (
				if c == true and u > simpleProp.numberset do s=10
				hL = (h+s)
			)			
				
			bt = ("btMASTER_LAYER"+properties[u]) as name
			r.addControl #checkbutton bt "" paramStr:("border:false pos:["+ hL as string +","+ p as string +"] width:13 height:19 toolTip:\""+propertiesTips[u] as string+"\" highlightColor:"+propColor[u] as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setAllPropsEnabled arg \""+properties[u] as string+"\"")
			--checked:true caption:\"\"
			h+=12
		)
		
		
		if c == true then (
				
				--CAMERA
				bt = ("btMASTER_LAYER"+"cam") as name
				r.addControl #dropdownlist bt "" paramStr:("pos:[350,"+ p as string +"] width:120 height:19 items:(getCameraListFn \"names\") selection:("+camIndex as string+") tooltip:\"Set camera for all layers\"")
				r.addHandler bt #selected filter:on paramStr:"arg" codeStr:("if arg == 1 then (btMASTER_LAYERcam.selection = "+camIndex as string+") else ( setCam \"MASTER LAYER\" (getCameraListFn \"nodes\")[arg]; setAllCam arg)")
			
				bt = ("btMASTER_LAYER"+"cam_label") as name	
				r.addControl #label bt "Camera" paramStr:("pos:[355,("+ p as string +"-20)] width:120 height:19")
			
				--OUTPUT FILE
				bt = ("btMASTER_LAYER"+"output") as name
				r.addControl #edittext bt "" paramStr:("pos:[480,("+ p as string +"+1)] width:500 text:(\""+replaceSlash (b.outputFilename)  false as string+"\")  tooltip:\"Set render output file for this layer\"")
				r.addHandler bt #changed filter:on paramStr:"arg" codeStr:("btMASTER_LAYERoutput.text = replaceSlash arg true; setAllOutputFolder (replaceSlash arg true)")
			
				bt = ("btMASTER_LAYER"+"output_label") as name	
				r.addControl #label bt "Output File" paramStr:("pos:[485,("+ p as string +"-20)] width:120 height:19")
			
				--BROWSE...
				bt = ("btMASTER_LAYER"+"browse") as name
				r.addControl #button bt "..." paramStr:("border:false pos:[985,"+ p as string +"] width:30 height:19  tooltip:\"Browse output folder\"")
				r.addHandler bt #pressed filter:on codeStr:("getOutputFolder \"MASTER LAYER\"")
			
				--OVERRIDE
				bt = ("btMASTER_LAYER"+"override") as name
				r.addControl #checkbutton bt "Override" paramStr:("border:false pos:[1020,"+ p as string +"] width:60 height:19  tooltip:\"Override Preset for all layers\"")
				r.addHandler bt #changed filter:on paramStr:"arg" codeStr:("setOverrideEnabled \"MASTER LAYER\" false; setAllOverrideEnabled arg")
			
				--START FRAME
				bt = ("btMASTER_LAYER"+"startframe") as name
				r.addControl #spinner bt "" paramStr:("pos:[1085,("+ p as string +"+2)] width:50 height:19 type:#integer range:[-99999,99999,"+b.startframe as string+"]  tooltip:\"Set render start frame for all layers\"")
				r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setAllFrameRange arg \"start\"")
			
				bt = ("btMASTER_LAYER"+"range_label") as name	
				r.addControl #label bt "Frame Range" paramStr:("pos:[1090,("+ p as string +"-20)] width:120 height:19")
				
				--END FRAME
				bt = ("btMASTER_LAYER"+"endframe") as name
				r.addControl #spinner bt "" paramStr:("pos:[1135,("+ p as string +"+2)] width:50 height:19 type:#integer range:[-99999,99999,"+b.endframe as string+"] tooltip:\"Set render start frame for all layers\"")
				r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setAllFrameRange arg \"end\"")	
				
				--WIDTH
				bt = ("btMASTER_LAYER"+"width") as name
				r.addControl #spinner bt "" paramStr:("pos:[1190,("+ p as string +"+2)] width:50 height:19 type:#integer range:[1,99999,"+b.width as string+"]  tooltip:\"Set render output width for all layers\"")
				r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setAllWidthHeight arg \"width\"")	
			
				bt = ("btMASTER_LAYER"+"size_label") as name	
				r.addControl #label bt "Width/Height" paramStr:("pos:[1195,("+ p as string +"-20)] width:120 height:19")
				
				--HEIGHT
				bt = ("btMASTER_LAYER"+"height") as name
				r.addControl #spinner bt "" paramStr:("pos:[1240,("+ p as string +"+2)] width:50 height:19 type:#integer range:[1,99999,"+b.height as string+"] tooltip:\"Set render output height for all layers\"")
				r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setAllWidthHeight arg \"height\"")	
				
				--PIXEL ASPECT
				bt = ("btMASTER_LAYER"+"pixel") as name
				r.addControl #spinner bt "" paramStr:("pos:[1295,("+ p as string +"+2)] width:50 height:19 type:#float range:[0.001,99999,"+b.pixelAspect as string+"]  tooltip:\"Set render pixel aspect for all layers\"")
				r.addHandler bt #changed filter:on paramStr:"arg" codeStr:("setAllPixelAspect arg")
			
				bt = ("btMASTER_LAYER"+"pixel_label") as name	
				r.addControl #label bt "Pixel Aspect" paramStr:("pos:[1290,("+ p as string +"-20)] width:120 height:19")
			
			
				panelFloatRo.width = fullRoWidth
				panelFloatRo.subRo.width = fullRoWidth
				global xpos = (fullRoWidth-45)
			) else (
				panelFloatRo.width = simpleRoWidth
				panelFloatRo.subRo.width = simpleRoWidth
				global xpos = (simpleRoWidth - 50)
			)
	

	P+=25


	--cria botoes das camadas
	for i = 1 to renderLayerArray.count do
	(
		--checa se essa ? a render layer atual	
		str = ""
		if currentRenderLayer == renderLayerArray[i] do
		(
			str += " checked:true"
			global lastChecked = renderLayerArray[i]
		)			
		
		b = batchRenderMgr.GetView (batchRenderMgr.FindView renderLayerArray[i])
		cams = getCameraListFn "nodes"
		for i = 1 to cams.count do
		(
			if cams[i] == b.camera do camIndex = i
		)	
		
		
		--R
		bt = ("bt"+i as string+"check") as name
		r.addControl #checkbutton bt "R" paramStr:("border:false pos:[5,"+ p as string +"] width:30 height:19 checked:"+b.enabled as string+" tooltip:\"Enable this layer for batch render\"")
		r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setRenderEnabled \""+renderLayerArray[i] as string+"\" arg; setMasterRenderChecks()")
		
		--LAYER NAME
		bt = ("bt"+i as string+"mainbutton") as name
		r.addControl #checkbutton bt (renderLayerArray[i] as string) paramStr:("border:false pos:[40,"+ p as string +"] width:150 height:19 "+str+" tooltip:\"Shift+Click to rename this layer\"")
		r.addHandler bt #changed filter:on paramStr:"state" codeStr:("if keyboard.shiftpressed == true then	(global renameTxt = "+bt as string+".caption;createdialog renameLayerRo 350 40 panelRLPos[1] panelRLPos[2]); changeRLFn currentRenderLayer \""+renderLayerArray[i] as string+"\";")
		


		h = 195
		 s=0
		for u = 1 to properties.count do
		(
			if c != true and u > simpleProp.numberset  then (
				hL = 1000
				h -= 12
			) else (
				if c == true and u > simpleProp.numberset do s=10
				hL = (h+s)
			)			
				
			bt = ("bt"+i as string+properties[u]) as name
			r.addControl #checkbutton bt (substring properties[u] 1 1) paramStr:("border:false pos:["+ hL as string +","+ p as string +"] width:13 height:19 toolTip:\""+propertiesTips[u] as string+"\" highlightColor:"+propColor[u] as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("if arg == true then ("+bt as string+".caption = \"\"; checkMasterBits \""+properties[u] as string+"\") else ("+bt as string+".caption = \""+(substring properties[u] 1 1) as string+"\"; loadMasterProp \""+renderLayerArray[i] as string+"\" \""+properties[u] as string+"\"; refreshRLProps \""+renderLayerArray[i] as string+"\");setMasterPropsChecks()")
			--checked:true caption:\"\"
			h+=12
		)
		
		
		--print c
		if c == true then (
			

			
			--CAMERA
			bt = ("bt"+i as string+"cam") as name
			r.addControl #dropdownlist bt "" paramStr:("pos:[350,"+ p as string +"] width:120 height:19 items:(getCameraListFn \"names\") selection:("+camIndex as string+") tooltip:\"Set camera for this layer\"")
			r.addHandler bt #selected filter:on paramStr:"arg" codeStr:("if arg == 1 then ("+"bt"+i as string+"cam"+".selection = "+camIndex as string+") else ( setCam \""+renderLayerArray[i] as string+"\"(getCameraListFn \"nodes\")[arg])")

			--OUTPUT FILE
			bt = ("bt"+i as string+"output") as name
			r.addControl #edittext bt "" paramStr:("pos:[480,"+ p as string +"] width:500 text:(\""+replaceSlash (b.outputFilename) false as string+"\")  tooltip:\"Set render output file for this layer\"")
			r.addHandler bt #changed filter:on paramStr:"arg" codeStr:("bt"+i as string+"output.text = replaceSlash arg false; setOutputFolder \""+renderLayerArray[i] as string+"\" arg;")
									
			--BROWSE...
			bt = ("bt"+i as string+"browse") as name
			r.addControl #button bt "..." paramStr:("border:false pos:[985,"+ p as string +"] width:30 height:19  tooltip:\"Browse output folder\"")
			r.addHandler bt #pressed filter:on codeStr:("getOutputFolder \""+renderLayerArray[i] as string+"\"")
			
			--OVERRIDE
			bt = ("bt"+i as string+"override") as name
			r.addControl #checkbutton bt "Override" paramStr:("border:false pos:[1020,"+ p as string +"] width:60 height:19  tooltip:\"Override Preset for this layer\"checked:"+b.overridePreset as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setOverrideEnabled \""+renderLayerArray[i] as string+"\" arg; setMasterOverrideChecks(); setOverrideOptionsEnabled arg "+i as string+"")
		
			--STAR TFRAME
			bt = ("bt"+i as string+"startframe") as name
			r.addControl #spinner bt "" paramStr:("pos:[1085,("+ p as string +"+2)] width:50 height:19 type:#integer range:[-99999,99999,"+b.startframe as string+"]  tooltip:\"Set render start frame for this layer\" visible:"+b.overridePreset as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setFrameRange \""+renderLayerArray[i] as string+"\" arg \"start\"")
			
			--END FRAME
			bt = ("bt"+i as string+"endframe") as name
			r.addControl #spinner bt "" paramStr:("pos:[1135,("+ p as string +"+2)] width:50 height:19 type:#integer range:[-99999,99999,"+b.endframe as string+"] tooltip:\"Set render end frame for this layer\" visible:"+b.overridePreset as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setFrameRange \""+renderLayerArray[i] as string+"\" arg \"end\"")
			
			--WIDTH
			bt = ("bt"+i as string+"width") as name
			r.addControl #spinner bt "" paramStr:("pos:[1190,("+ p as string +"+2)] width:50 height:19 type:#integer range:[1,99999,"+b.width as string+"]  tooltip:\"Set render output width for this layer\" visible:"+b.overridePreset as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setWidthHeight \""+renderLayerArray[i] as string+"\" arg \"width\"")
					
			--HEIGHT
			bt = ("bt"+i as string+"height") as name
			r.addControl #spinner bt "" paramStr:("pos:[1240,("+ p as string +"+2)] width:50 height:19 type:#integer range:[1,99999,"+b.height as string+"] tooltip:\"Set render output height for this layer\" visible:"+b.overridePreset as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setWidthHeight \""+renderLayerArray[i] as string+"\" arg \"height\"")
			
			--PIXEL ASPECT
			bt = ("bt"+i as string+"pixel") as name
			r.addControl #spinner bt "" paramStr:("pos:[1295,("+ p as string +"+2)] width:50 height:19 type:#float range:[0.001,99999,"+b.pixelAspect as string+"]  tooltip:\"Set render pixel aspect for this layer\" visible:"+b.overridePreset as string+"")
			r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("setPixelAspect \""+renderLayerArray[i] as string+"\" arg")
			
			
			
		
		) else (
		)
		
		--X
		bt = ("bt"+i as string+"delete") as name
		r.addControl #button bt "X" paramStr:("border:false pos:[xpos,"+ p as string +"] width:30 height:19  tooltip:\"Delete this layer\"")
		r.addHandler bt #pressed filter:on codeStr:("if querybox (\"Delete layer "+renderLayerArray[i] as string+"?\") beep:false do deleteRLFn \""+renderLayerArray[i] as string+"\"")
		
		p += 20
	)
	
	p += 5
	bt = ("addNewLayerBt") as name
	r.addControl #button bt "+" paramStr:("pos:[5,"+ p as string +"] width:30 height:20 border:true tooltip:\"Add new render layer\"")
	r.addHandler bt #pressed  filter:on codeStr:("createdialog addNewLayerRo 350 40 panelRLPos[1] panelRLPos[2]")	
	
	
	
	r.end()
	
	return r.def
)

fn panelFloatRoFn c nameRo = --cria dinamicamente o painel principal
(
	
	
	r = rolloutCreatorCustom "panelFloatRo" nameRo category:1
	r.begin()
	
	bt = ("batchRenderBt") as name
	r.addControl #button bt "Batch Render" paramStr:("pos:[5,5] width:115 height:20 border:true tooltip:\"Start batch render\"")
	r.addHandler bt #pressed  filter:on codeStr:("batchRenderFn()")
	
	bt = ("previewRenderBt") as name
	r.addControl #button bt "Preview" paramStr:("pos:[5,30] width:115  height:20 border:true tooltip:\"Start current frame batch render and display on the Ram Player\"")
	r.addHandler bt #pressed  filter:on codeStr:("previewRenderFn()")
	
	bt = ("collapseBt") as name
	r.addControl #checkbutton bt "More..." paramStr:("pos:[170,30] width:70 height:20 border:true checked:"+c as string+"")
	r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("refreshRLRo 0 0 \"panel\"; if arg == true then(refreshConfigFn()) else (if configRo != undefined do removerollout configRo); setButtonsVisibility arg;")
	
	bt = ("netRenderCk") as name
	r.addControl #checkbox bt "Net Render" paramStr:("checked:"+batchRenderMgr.netRender as string+" pos:[170,7]")
	r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("batchRenderMgr.netRender = arg")
		
	bt = ("subRo") as name
	r.addControl #subrollout bt "SubRo" paramStr:("width:simpleRoWidth height:8000 pos:[0,60]")
	
	-- about buttons

	bt = ("btBUY") as name
	r.addControl #button bt "Buy Licenses" paramStr:("pos:[300,30] width:107 height:20 border:true visible:false tooltip:\"Buy a Max Render Layer license and get the activation instantly\"")
	r.addHandler bt #pressed  filter:on codeStr:("Shelllaunch \"http://"+buyUrl as string+"\" \"\"")
	
	bt = ("btACTIVATE") as name
	r.addControl #button bt "Activation" paramStr:("pos:[420,30] width:107 height:20 border:true visible:false tooltip:\"Manage the activation of Max Render Layer\nActivate and get access to all Max Render Layer features\"")
	r.addHandler bt #pressed  filter:on codeStr:("activationRoFn()")
	
	bt = ("btHELP") as name
	r.addControl #button bt "Help" paramStr:("pos:[540,30] width:107 height:20 border:true visible:false tooltip:\"Whatever help you need, this is the place to go\"")
	r.addHandler bt #pressed  filter:on codeStr:("PopupMenu helpMenu rollout:panelFloatRo")

	----------------------------

	r.addHandler #panelFloatRo #moved filter:on paramStr:"arg" codeStr:("panelRLPos = arg")
	r.addHandler #panelFloatRo #open filter:on codeStr:("callbacks.removeScripts id:#renderLayer; callbacks.addScript #systemPostNew \"refreshSceneFn()\" id:#renderLayer; callbacks.addScript #systemPostReset \"refreshSceneFn()\" id:#renderLayer; callbacks.addScript #filePostOpenProcess \"refreshSceneFn()\" id:#renderLayer")
	r.addHandler #panelFloatRo #close filter:on codeStr:("callbacks.removeScripts id:#renderLayer;")
-- 	r.addHandler #panelFloatRo #resized filter:on paramStr:"arg" codeStr:("refreshRenderLayerRoWidth arg")
	
	r.end()	
	return r.def
)

fn refreshConfigFn =
(
	if configRo != undefined do removerollout configRo
	AddSubRollout panelFloatRo.subRo (configRoFn()) rolledUp:false
	setInitialPropChecks()
	--set default extension text visibility
	listSelection = findItem (configRo.btEXTENSIONLIST.items) (defaultExtFn() as string)	
	if listSelection != 0 then (configRo.btEXTENSIONLIST.selection = listSelection) else (configRo.btEXTENSIONLIST.selection = 1)
	if configRo.btEXTENSIONLIST.selection != 1 then (configRo.btEXTENSION.visible = false) else (configRo.btEXTENSION.visible = true; configRo.btEXTENSION.text =defaultExtFn() )
)

fn checkForUpdates report =
(
	/* Http socket open */
	rollout httpSock "httpSock" width:0 height:0
	(
	activeXControl port "Microsoft.XMLHTTP" setupEvents:false releaseOnClose:false
	);
	createDialog httpSock pos:[-100,-100];
	destroyDialog httpSock;

	--for?a refresh
	rd = random 0 9999 as string
	
	/* HTTP socket connect */
	httpSock.port.open "GET" ("http://"+checkForUpdatesPath as string+"?rd="+rd as string+"") false;
	httpSock.port.send();

	/* HTTP socket return */
	updateInfo = httpSock.port.responsetext

	--verification
	versionFileRL_load = (getFolderFromFile (getThisScriptFilename()) 1) +versionFileRL
	currentVersion = (GetINISetting versionFileRL_load "about" "version")

	latestVersion = substring updateInfo ((findString updateInfo "<")+1) ((findString updateInfo ">")-2)
	message = substring updateInfo ((findString updateInfo ">")+2) updateInfo.count
	message += "\n\nUpdate now?"
	
	
	if currentVersion != latestVersion and RLupdateChecked != true and (GetINISetting configFileRL "defaults" "checkForUpdates") != "Don't Check" then
	(
		if queryBox message beep:false then
		(
			Shelllaunch ("http://"+downloadUrl) ""
			destroydialog panelFloatRo
		) else (
			if queryBox "Do you want to be warned later?" beep:false then
			(
				
			) else (
				setINISetting configFileRL "defaults" "checkForUpdates" "Don't Check"
				messagebox "If you want to check for new updates in the future, please go to More/Help/Check For Updates."
			)
			
		)
	) else if currentVersion == latestVersion and report == true then
	(
		messagebox ("v"+currentVersion+"\n\nYour Max Render Layer is up-to-date.")
	)
	
	global RLupdateChecked = true
)

fn configRoFn = --cria dinamicamente o config
(
	r = rolloutCreatorCustom "configRo" "Configuration" category:2
	r.begin()	
	
	h = 195

	s = 0
	for u = 1 to properties.count do
	(
			if u > simpleProp.numberset  then (
				s=10
				hL = (h+s)
			) else (
				hL = h
			)	
		
		
		bt = ("simpleProp"+properties[u]) as name
		r.addControl #checkbutton bt (substring properties[u] 1 1) paramStr:("border:false pos:["+ hL as string +",5] width:13 height:19 toolTip:\""+properties[u] as string+"\" highlightColor:"+propColor[u] as string+"")
		r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("if arg == true then ("+bt as string+".caption = \"\") else ("+bt as string+".caption = \""+(substring properties[u] 1 1) as string+"\"); saveConfigIni(); refreshConfigFn(); refreshRLRo 0 0 \"panel\"")
		
		bt = ("newLayerProp"+properties[u]) as name
		r.addControl #checkbutton bt (substring properties[u] 1 1) paramStr:("border:false pos:["+ hL as string +",25] width:13 height:19 toolTip:\""+properties[u] as string+"\" highlightColor:"+propColor[u] as string+"")
		r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("if arg == true then ("+bt as string+".caption = \"\") else ("+bt as string+".caption = \""+(substring properties[u] 1 1) as string+"\"); saveConfigIni()")
		
		h+=12
	)

	r.addControl #label #colPropLb "Simple mode display" paramStr:("pos:[350,8]")
	r.addControl #label #newLayerLb "New layer properties" paramStr:("pos:[350,28]")
	r.addControl #label #extLb "Default output extension" paramStr:("pos:[750,8]")
	
	bt = ("btEXTENSION") as name
	r.addControl #edittext bt "" paramStr:("border:false pos:[985,8] fieldWidth:50 text:\"\"")
	r.addHandler bt #changed  filter:on paramStr:"arg" codeStr:("saveConfigIni();")

	bt = ("btEXTENSIONLIST") as name
	r.addControl #dropdownlist bt "" paramStr:("border:false pos:[880,7] width:100 height:19 items:#(\"CUSTOM\", \"avi\", \"bmp\", \"bw\", \"cin\", \"dds\", \"eps\", \"exr\", \"fxr\", \"hdr\", \"icb\", \"int\", \"inta\", \"jpe\", \"jpeg\", \"jpg\", \"pic\", \"png\", \"ps\", \"rgb\", \"rgba\", \"rla\", \"rpf\", \"sgi\", \"tga\", \"tif\", \"vda\", \"vst\") selection:1 tooltip:\"Select the default output extension.\"")
	r.addHandler bt #selected filter:on paramStr:"arg" codeStr:("if arg != 1 then (btEXTENSION.visible = false) else (btEXTENSION.visible = true); btEXTENSION.text = \"\"; saveConfigIni();")
	
	


	r.end()	
	
	return r.def
)

fn refreshSceneFn = --refresh o painel principal (fecha e abre novamente)
(
	checkActivation (GetINISetting configFileRL "defaults" "email")
	
	try(cui.UnRegisterDialogBar panelFloatRo) catch()
	try (destroydialog panelFloatRo) catch ()
	
	
	if hasAnyRenderLayerDataFn() == false then
	(	
		for i in RenderLayerDataTracks do
		(
			for i in RenderLayerDataTracks do
			(
				t = amin RenderLayerDataTracks
				custAttributes.delete globaltracks t			
			)			
		)
		RenderLayerData = attributes "RenderLayerData"	(
		parameters main rollout:blank
		(		
			currentRenderLayer type:#String animatable:false	
						
		)
		rollout blank "blank"
		(
		)
		)
		custAttributes.add globaltracks RenderLayerData 
		
		globaltracks.RenderLayerData.currentRenderLayer = ""
	)
				
	global currentRenderLayer = globaltracks.RenderLayerData.currentRenderLayer


	if panelRLPos == undefined do panelRLPos = [400,400]
	if panelRLSize == undefined do panelRLSize =  500
	
	createdialog (panelFloatRoFn false panelName) pos:panelRLPos width:simpleRoWidth height:panelRLSize  style:#(#style_titlebar, #style_sysmenu, #style_resizing, #style_minimizebox)
	

	
	--cria master layer
	l = "MASTER LAYER"
	if sceneStateMgr.FindSceneState l == 0 do 
	(
		sceneStateMgr.CaptureAllParts l
		b = batchRenderMgr.CreateView (viewport.getCamera())
		b.name = l
		b.sceneStateName = l
		b.startFrame = animationrange.start
		b.endFrame = animationrange.end
		b.enabled = false		
		currentRenderLayer = l
		globaltracks.RenderLayerData.currentRenderLayer = currentRenderLayer		
	)	
	refreshRenderLayerArray()
	refreshRLRo 0 0 "props"
	if (GetINISetting configFileRL "defaults" "checkForUpdates") != "Don't Check" do checkForUpdates false
)

fn refreshPanelHeight =
(
	initHeight = 144
	if panelFloatRo.collapseBt.checked == true do initHeight += 95
	layersHeight = ((renderLayerArray.count * 20)-20)
	panelFloatRo.height = (initHeight+20+layersHeight)
)

rollout renameLayerRo "Rename Render Layer"
(
	edittext nameRLTx "" pos:[5,10] width:330
	
	on renameLayerRo open do
	(
		setFocus nameRLTx
		nameRLTx.text = renameTxt
	)
	
	on nameRLTx entered arg do
	(
		destroyDialog renameLayerRo
		sceneStateMgr.Rename currentRenderLayer arg
		b = batchRenderMgr.GetView (batchRenderMgr.FindView currentRenderLayer)
		b.name = arg
		currentRenderLayer = arg
		globaltracks.RenderLayerData.currentRenderLayer = currentRenderLayer
		refreshRLRo 0 0 "panel"
	)
)

rollout addNewLayerRo "Render Layer Name"
(
	edittext nameRLTx "" pos:[5,10] width:330
	
	on addNewLayerRo open do
	(
		setFocus nameRLTx
	)
	
	on nameRLTx entered arg do
	(
		destroyDialog addNewLayerRo
		createRLFn arg
		--createRLFn arg (defaultPropFn newLayerProp)
		
	)

)

rollout aboutRo "Max Render Layer" width:300 height:150
(
	label lab1 "Max Render Layer" pos:[10,10] width:300 
	label lab2"The ultimate render pass tool for 3DS Max" pos:[10,30] width:300 
	label lab3 "version" pos:[10,90] 
	HyperLink hyp0 "Max Render Layer website" pos:[10,120] address:("http://"+webSiteUrl) color:(color 130 130 255)
	--label lab2 "Max Render Layer was created by" pos:[10,90] 
	--HyperLink hyp1 "Alan Camilo" pos:[10,110] address:("http://"+alanUrl) color:(color 130 130 255)
	--HyperLink hyp2 "Contact us" pos:[10,50] address:("http://"+contactUrl) color:(color 130 130 255)

	on aboutRo open do
	(
		versionFileRL_load = (getFolderFromFile (getThisScriptFilename()) 1) +versionFileRL
		lab3.text = ("v"+GetINISetting versionFileRL_load "about" "version")
	)
)

rollout allActivatedRo "Max Render Layer" 
(
	label lab1 "" pos:[10,10] width:450 height:150 
	button buyBt      "Buy Licenses" pos:[5,70] width:107 height:20
	button contactBt      "Contact us" pos:[125,70] width:107 height:20
	
	on allActivatedRo open do
	(			
		lab1.text = "There are no more pending licenses to activate under this email.\nPlease buy a license today and get the activation instantly.\nIf you want to swap your license, please contact us.";
	)
	
	on buyBt pressed do
	(
		Shelllaunch ("http://"+buyUrl as string) ""
	)
	
	on contactBt pressed do
	(
		Shelllaunch ("http://"+contactUrl as string) ""
	)
)

rollout noActivationRo "Max Render Layer" 
(
	label lab1 "" pos:[10,10] width:450 height:150 
	button buyBt      "Buy Licenses" pos:[5,70] width:107 height:20
-- 	button contactBt      "Contact us" pos:[125,70] width:107 height:20
	
	on noActivationRo open do
	(			
		lab1.text = "Sorry, we couldn't proccess your activation.\nPlease check if the email you typed match your paypal email.\nIf you just made a purchase, please try again in a few minutes.\nIf you don't have a license, buy a license today and get the activation instantly."
	)
	
	on buyBt pressed do
	(
		Shelllaunch ("http://"+buyUrl as string) ""
	)
	
	on contactBt pressed do
	(
		Shelllaunch ("http://"+contactUrl as string) ""
	)
)

rollout netWarningRo "Max Render Layer" 
(
	label lab1 "You've selected Net Render.\n\nYou need to manually 'confirm' the output path for every batch render, or the render won't work. This is a MaxScript/Batch Render issue, and has already been reported to Autodesk.\n\nBatch Render is now open behind this warning, select the render layer, click on the Output Path Browse button, click on Save and confirm. Do this for all the layers.\nAfter doing that, click on the Batch Render button from the Max Render Layer Panel." pos:[10,10] width:400 height:300 
	HyperLink hyp1 "Watch a video" pos:[10,160] address:("http://"+bugNetRenderUrl) color:(color 130 130 255)
)

rollout trialModeRo "Max Render Layer" 
(
	label lab1 "" pos:[10,10] width:450 height:150 
	button buyBt      "Buy Licenses" pos:[5,80] width:107 height:20
 	button activationBt      "Activation" pos:[125,80] width:107 height:20
	
	on trialModeRo open do
	(	
		lab1.text = "You can use only 2 layers in Trial mode.\nYou need to activate Max Render Layer in order to use as many \nlayers as you want.\nPlease buy a license today and get the activation instantly."
	)
	
	on buyBt pressed do
	(
		destroydialog trialModeRo
		Shelllaunch ("http://"+buyUrl as string) ""
	)
	
	on activationBt pressed do
	(
		destroydialog trialModeRo
		activationRoFn()
	)
)

rollout serverOutRo "Max Render Layer" 
(
	label lab1 "" pos:[10,10] width:450 height:150 
	button contactBt      "Contact us" pos:[5,70] width:107 height:20
	
	on serverOut open do
	(			
		lab1.text = "Sorry, we couldn't proccess your activation.\nOur server is out! Please try again in a few minutes.\nIf you don't succeed, please contact us ASAP."
	)
	on contactBt pressed do
	(
		Shelllaunch ("http://"+contactUrl as string) ""
	)
)

rollout activationRo "Max Render Layer Activation"
(
	edittext emailTx      "Your e-mail          " pos:[5,10] width:330
	button activateBt      "Activate" pos:[350,10] width:90 height:45
	edittext computerIdLb "Your computer Id" pos:[5,40] width:330 readOnly:true border:false
	label lab1 "" pos:[5,10] width:330
	label lab2 "Your current activated Computer Ids:" pos:[5,70] width:330
	edittext activatedIdsTx "" pos:[5,90] width:330 height:20 readOnly:true border:false
	
	fn activateFn =
	(				
		setINISetting configFileRL "defaults" "email" emailTx.text
		activationResults = (activateLicense (emailTx.text) (getComputerID()) "activate")
			
		didActivate = activationResults[1] 
		activationLeft = activationResults[2] 
		activatedIds = execute(activationResults[3])		
		firstName = activationResults[4] 		
		lastName = activationResults[5] 
			
		setINISetting configFileRL "defaults" "first_name" firstName
		setINISetting configFileRL "defaults" "last_name" lastName
			
		activationRoFn()
			
		--print (activationResults as string)
			
		if didActivate == "1" then
		(
			--print "thanks for activating"
			refreshSceneFn()
			messagebox "Thanks for activating Max Render Layer!"
		) else if activatedIds.count >=2 then
		(
			--print "ja estao todos ativados"
			createdialog allActivatedRo  350 120 panelRLPos[1] panelRLPos[2]	
		) else
		(
			--print "compra!!"
			createdialog noActivationRo  410 120 panelRLPos[1] panelRLPos[2]	
		)
		
			
	)
	
	on activationRo open do
	(
		
		lab1.visible = false
		lab2.visible = false
		emailTx.visible = false		
		activatedIdsTx.visible = false	
		activateBt.visible = false
		computerIdLb.visible = false
		
		computerIdLb.text = getComputerID()
		email = GetINISetting configFileRL "defaults" "email"
		
		activationResults = (activateLicense email (getComputerID()) "only_check")
		
			
		if (checkInternetConnection()) then
		(
	-- 		print "encontrou google"
			if (checkServerConnection()) then
			(
				didActivate = activationResults[1] 
				activationLeft = activationResults[2] 
				activatedIds = execute(activationResults[3])		
				firstName = activationResults[4] 		
				lastName = activationResults[5] 	
				
				if (checkActivation email) then
					(
					activateBt.visible = true
					lab1.visible = true
					lab1.caption = "Activated to "+firstName+" "+lastName+" ("+email+")"
						activationRo.width = 350
					)else (
					activateBt.visible = true
					emailTx.visible = true
					setFocus emailTx
					emailTx.text = email
				)
				
				if (activatedIds.count >= 2) then
				(
					lab2.visible = true
					activatedIdsTx.visible = true				
						
					activatedIdsTx.text = ""				
					activationRo.height += 40
					
					
					for i =1 to (activatedIds.count - 1) do
					(
						activatedIdsTx.height += 17
						activationRo.height += 17
						activatedIdsTx.text += activatedIds[i]
						if i < (activatedIds.count - 1) do activatedIdsTx.text += "\n"
					)				
					
					activatedIdsTx.height -= 20			
				) 
			)
		)
		computerIdLb.visible = true
		
	)
	
	on emailTx entered arg do
	(
		activateFn()		
	)
	
	on activateBt pressed do
	(
		activateFn()		
	)
)

rollout webbrowserRo "Max Render Layer Activation Server" width:700 height:400

(

	dotNetControl wb "System.Windows.Forms.WebBrowser" pos:[10,10] width:680 height:380
	
	on webbrowserRo open do
	(
		setFocus wb
	)

)

RCMenu helpMenu
(
	MenuItem helpMn "Max Render Layer Help"
	separator sep1
	MenuItem knownBugsMn "Known Bugs"
	MenuItem requestFeatureMn "Request a Feature"
	MenuItem reportBugMn "Report a Bug"
	MenuItem checkUpdatesMn "Check for Updates"
	separator sep2
	MenuItem aboutMn "About Max Render Layer..."
	
	on helpMn picked do
	(
		Shelllaunch ("http://"+helpUrl) ""
	)

	on knownBugsMn picked do
	(
		Shelllaunch ("http://"+knownBugsUrl) ""
	)
	
	on requestFeatureMn picked do
	(
		Shelllaunch ("http://"+requestFeatureUrl) ""
	)
	
	on reportBugMn picked do
	(		
		Shelllaunch ("http://"+reportBugUrl) ""
	)
		
	on checkUpdatesMn picked do
	(
		global RLupdateChecked = false
		setINISetting configFileRL "defaults" "checkForUpdates" "Check"
		checkForUpdates true
	)	
		
	on aboutMn picked do
	(
		createdialog aboutRo  250 150 panelRLPos[1] panelRLPos[2]	
	)	

)




defineInitialSettings()
refreshSceneFn()

