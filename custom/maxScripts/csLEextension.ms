-- csLayerExplorerExtension v1.0  
--
-- (c) 2014 Changsoo Eun (www.3dvfxartist.com)
--
-- Layer Explorer Quad Menu Extension
-- Drag-and-drop this ms file into viewport.
-- USE AT OWN RISK
--

macroScript csLEextDeleteSelectedLayerTree
	category:"Layer Explorer Extension"
	toolTip:"Delete selected layer(s) and all child layer(s)/node(s)"
	ButtonText:"Delete Selected Layer and All Children" 
(	
	on isVisible do	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)
	
	on isEnabled do 	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		if (sceneExplorerInstance == undefined) then return false
		count = (sceneExplorerInstance.SelectedItems()).Count
		return (	(sceneExplorerInstance != undefined) and ( count > 0) )
	)

	on execute do	
	(
		local confirmDelete = queryBox "Do you really want to delete selected layer(s)?" title:"Warning"
		if confirmDelete == true then (
			with redraw off (
				sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
				sceneExplorerInstance.SelectChildren()
				local selectedLayers = #()
				local selectedNodes = #()
				for item in sceneExplorerInstance.SelectedItems()  do (
					if (hasProperty item #layerAsRefTarg) == true then 
					(
						append selectedLayers item
					)
					else(
						append selectedNodes item
					)
				)
				local deleteLayer = true
				if selectedNodes.count > 0 then (
					local msg = "You have " + (selectedNodes.count as string) + " children objects.\nDo you also want to delete these objects?"
					local deleteObj = querybox msg title:"Warning"
					if deleteObj == true then ( 
						delete selectedNodes
					)
					else(
						deleteLayer == false
					)

				)
				if deleteLayer == true and selectedLayers.count > 0 then (
					local defaultLayer = LayerManager.getLayerFromName "0"
					defaultLayer.current = true
					for l in selectedLayers do (
						LayerManager.deleteLayerByName l.name	
					)
				)
			)
		)
	)
)
macroScript csLEextDeleteUnusedLayer
	category:"Layer Explorer Extension"
	toolTip:"Delete Unused Layer"
	ButtonText:"Delete Unused Layer"
(
	fn getAncestorLayer layer = (
		local ancestorArr = #()
		local tmpParent = (layer.getParent())
		if tmpParent != undefined then (
			append ancestorArr tmpParent
			join ancestorArr (getAncestor tmpParent)
		)
		ancestorArr
	)

	(layermanager.getLayerFromName "0").current = true
	local layerWithNode = #()
	for o in objects do (
		appendifunique layerWithNode (o.layer)
	)
	local layerToKeep = #()
	local ancestors = #()
	for l in layerWithNode do (
		if (l.getParent()) != undefined then (
			ancestors = getAncestorLayer l 
			for a in ancestors  do (
				appendifunique layerToKeep a
			)
		)
	)
	local tmpLayer
	for i = (LayerManager.count - 1) to 0 by -1 do (
		tmpLayer = LayerManager.getLayer i
		if (findItem layerWithNode tmpLayer) == 0 and  (findItem layerToKeep tmpLayer) == 0 then (
			LayerManager.deleteLayerByName tmpLayer.name
		)
	)
)

macroScript csLEextHideUnhideChildren
	category:"Layer Explorer Extension"
	toolTip:"Hide/Unhide all the child nodes on the selected layer"
	ButtonText:"Hide/Unhide Child Nodes" 
(
	with redraw off (
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		sceneExplorerInstance.SelectChildren()
		selectedNodes = #()
		for item in sceneExplorerInstance.SelectedItems()  do 
		(
			if (hasProperty item #layerAsRefTarg) == false then 
			(
				append selectedNodes item
			)
		)
		print(selectedNodes.count)
		if selectedNodes.count > 0 then (
			hiddenNodes = for n in selectedNodes while (n.isHiddenInVpt) collect n
			print(hiddenNodes.count)
			if hiddenNodes.count == selectedNodes.count then (
				unhide selection
			)
			else(
				hide selection
			)
		)
		clearNodeSelection redraw:false
	)
)

macroScript csLEextUnhideAllNodesOnSelected
	category:"Layer Explorer Extension"
	toolTip:"Unhide all the nodes on the selected layer"
	ButtonText:"Unhide Nodes on Selected Layer" 
(	
	
	on isVisible do	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)
	
	on isEnabled do 	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		if (sceneExplorerInstance == undefined) then return false
		count = (sceneExplorerInstance.SelectedItems()).Count
		return (	(sceneExplorerInstance != undefined) and ( count > 0) )
	)
	
	on execute do
	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		selectedLayers = #()
		for item in sceneExplorerInstance.SelectedItems()  do 
		(
			if (hasProperty item #layerAsRefTarg) == true then 
			(
				append selectedLayers item
			)
		)
		for l in selectedLayers do (
			l.nodes &nodesOnALayer
			unhide nodesOnALayer
		)
	)
)

macroScript csLEextUnfreezeAllNodesOnSelected
	category:"Layer Explorer Extension"
	toolTip:"Unfreeze all the nodes on the selected layer"
	ButtonText:"Unfreeze Nodes on Selected Layer" 

(	
	
	on isVisible do	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)
	
	on isEnabled do 	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		if (sceneExplorerInstance == undefined) then return false
		count = (sceneExplorerInstance.SelectedItems()).Count
		return (	(sceneExplorerInstance != undefined) and ( count > 0) )
	)
	
	on execute do
	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		selectedLayers = #()
		for item in sceneExplorerInstance.SelectedItems()  do 
		(
			if (hasProperty item #layerAsRefTarg) == true then 
			(
				append selectedLayers item
			)
		)
		for l in selectedLayers do (
			l.nodes &nodesOnALayer
			unfreeze nodesOnALayer
		)
	)
)

macroScript csLEextSelectAllNodesOnSelected
	category:"Layer Explorer Extension"
	toolTip:"Select all the nodes on the selected layer"
	ButtonText:"Select Nodes on Selected Layer" 

(	
	
	on isVisible do	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)
	
	on isEnabled do 	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		if (sceneExplorerInstance == undefined) then return false
		count = (sceneExplorerInstance.SelectedItems()).Count
		return (	(sceneExplorerInstance != undefined) and ( count > 0) )
	)
	
	on execute do
	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		selectedLayers = #()
		for item in sceneExplorerInstance.SelectedItems()  do 
		(
			if (hasProperty item #layerAsRefTarg) == true then 
			(
				append selectedLayers item
			)
		)
		for l in selectedLayers do (
			l.nodes &nodesOnALayer
			selectmore nodesOnALayer
		)
	)
)

macroScript csLEextHideUnhideAllLayers
	category:"Layer Explorer Extension"
	toolTip:"Hide/Unhide all Layers"
	ButtonText:"Hide/Unhide All Layers"
(	
	local visibleCount = 0
	for i = 0 to (LayerManager.count - 1 ) do (
		if (LayerManager.getLayer i).on == true then (
			visibleCount = visibleCount + 1
		)
	)
	local layerOn = false
	if visibleCount == 0 then (
		layerOn = true
	)
	local tmpLayer
	for i = 0 to (LayerManager.count - 1 ) do (
		tmpLayer = LayerManager.getLayer i
		tmpLayer.on = layerOn
	)
)

macroScript csLEextFreezeUnfreezeAllLayers
	category:"Layer Explorer Extension"
	toolTip:"Freeze/Unfreeze all Layers"
	ButtonText:"Freeze/Unfreeze All Layers"
( 
	local lockCount = 0
	for i = 0 to (LayerManager.count - 1 ) do (
		if (LayerManager.getLayer i).lock == true then (
			lockCount = lockCount + 1
		)
	)
	local layerLock = true
	if lockCount == LayerManager.count then (
		layerLock = false
	)
	local tmpLayer
	for i = 0 to (LayerManager.count - 1 ) do (
		tmpLayer = LayerManager.getLayer i
		tmpLayer.lock = layerLock
	)
)

macroScript csLEextToggleVisibleIcon
	category:"Layer Explorer Extension"
	toolTip:"Hide Visible Icon[+Shift to Show]" 
	ButtonText:"Hide Visible Icon[+Shift to Show]" 
(	
	on isVisible do	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)
	
	on isEnabled do 	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)

	on execute do
	(
		SEname = (SceneExplorerManager.GetActiveExplorer()).name 
		tmpExplorerIni = (getdir #temp) + "\\" + SEname + ".ini"
		SceneExplorerManager.SaveExplorerConfiguration SEname tmpExplorerIni
		local ShowHideIconStatus 
		if keyboard.shiftPressed == true then (
			ShowHideIconStatus = "true"
		)
		else(
			ShowHideIconStatus = "false"
		)
		setInisetting tmpExplorerIni "Explorer" "ShowHideIcon" ShowHideIconStatus
		delInisetting tmpExplorerIni "Explorer" "Visible" 
		SceneExplorerManager.ConfigureExplorer SEname tmpExplorerIni
		deleteFile tmpExplorerIni
	)
)

macroScript csLEextToggleSyncSelection
	category:"Layer Explorer Extension"
	toolTip:"Turn off SyncSelection [+Shift to turn on]" 
	ButtonText:"Turn off SyncSelection [+Shift to turn on]" 
(	
	on isVisible do	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)
	
	on isEnabled do 	(
		sceneExplorerInstance = SceneExplorerManager.GetActiveExplorer()
		return (	sceneExplorerInstance != undefined )
	)

	on execute do
	(
		SEname = (SceneExplorerManager.GetActiveExplorer()).name 
		tmpExplorerIni = (getdir #temp) + "\\" + SEname + ".ini"
		SceneExplorerManager.SaveExplorerConfiguration SEname tmpExplorerIni
		local SyncSelectionStatus 
		if keyboard.shiftPressed == true then (
			SyncSelectionStatus = "true"
		)
		else(
			SyncSelectionStatus = "false"
		)
		setInisetting tmpExplorerIni "Explorer" "SyncSelection" SyncSelectionStatus
		delInisetting tmpExplorerIni "Explorer" "Visible" 
		SceneExplorerManager.ConfigureExplorer SEname tmpExplorerIni
		deleteFile tmpExplorerIni
	)
)

macroScript csLEextUnhideSelection
	category:"Layer Explorer Extension"
	toolTip:"Unhide Selection"
	ButtonText:"Unhide Selection" 
(	
	unhide selection
)

macroScript csLEextUnhideAllNodesOnCurrent
	category:"Layer Explorer Extension"
	toolTip:"Unhide all the nodes on the current layer"
	ButtonText:"Unhide Nodes on Current Layer" 
(	
	
	local currentLayer = LayerManager.current
	currentLayer.nodes &nodesOnCurrent
	unhide nodesOnCurrent
)
