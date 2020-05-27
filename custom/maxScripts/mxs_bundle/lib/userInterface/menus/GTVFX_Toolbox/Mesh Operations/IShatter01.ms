(
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	
	/*
	*  IShatter v1.0
	*  Copyright (c) 2016 MOAB 
	*  jeromeledrole@aol.com
	*  All rights reserved.
	/*
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND. MOAB DOES NOT MAKE AND HEREBY DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTIES
	INCLUDING, BUT NOT LIMITED TO, THE WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, OR ARISING FROM A COURSE 
	OF DEALING, USAGE, OR TRADE PRACTICE. IN NO EVENT WILL MOAB BE LIABLE FOR ANY LOST REVENUES, DATA, OR PROFITS, OR SPECIAL, DIRECT, INDIRECT, OR 
	CONSEQUENTIAL DAMAGES, EVEN IF MOAB HAS BEEN ADVISED OF THE POSSIBILITY OR PROBABILITY OF SUCH DAMAGES.

	-- This tool was created to cut objects using the voronoi diagram. But instead of using the classical method here you will use your mouse to define an area where fragmentation will occur.
	-- You will need at least the VoroFrag plugin (free plugin) in order for IShatter to work. I also included in this release the possibility to use RayFire Voronoi modifier. (not RayFire Fragmenter)
	
	-- You can refine fragmentation as many times as you want in a continuous way. You can add, remove fragments on the fly. You can also modify a previous fragmentation.
	-- It works with convex, concave and shelled meshes. Each fragment has a different ID for inner and outer faces.

	-- You can swap between methods during the process :  regular or radial. You also have an option to stretch the fragments along an axis to create wood patterns.
	
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	
	-- Instructions, steps to follow :

	* select an object
	* hit shatter button
	* you will enter in a mouse track context
	* click, drag and release your mouse to add voronoi fragments
	* alt, click and drag to remove voronoi fragments
	* repeat this until you are satisfied with the fragmentation
	* just right click to exit the process

	-- During this process you can :
	* turn around your object, zoom inside or outside
	* change the number of fragments, the method, display only the fragments borders...
	
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	
	-- Limitations :
	
	* VoroFrag is really fast but less accurate & robust than RayFire. 
	* it gives more artefacts than Rayfire and it won't be able to cut every objects.
	* moreover with Vorofrag you will need a cleaner mesh (no overlapped faces, no degenerated mesh). 
	* if Vorofrag is not able to cut an object try to use Rayfire instead (in case you got it).	
	* when you change GUI parameters during cutting process, those changes will occur on the next fragmentation, not in realtime (ie wood stretching). This is a limitation due to the mousetrack function.
	
	* In advance, sorry for all the inconvenience
	
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	-- Notes : If you have any questions, suggestions or encounter bugs feel free to contact me at : jeromeledrole@aol.com	
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
	*/
	
	global IShatterObjects -- IShatter objects in your scene
	global IShatterVoroMat -- voronoi material (only need to create once)
	global IShatterHelperMat -- sphere helper material ( only need to create once)	
	
	global IS_IShatter_Roll	
	try (destroyDialog IS_IShatter_Roll) catch()
	(
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Initialize the most used functions (faster access later)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		local fnMapScreenToWorldRay = mapScreenToWorldRay
		local fnMapScreenToView = mapScreenToView		
		
		local fnDeleteItem = deleteItem
		local fnFindItem = findItem
		local fnAppendIfUnique = appendIfUnique
		local fnAppend = append
		local fnQSort = qsort
		local fnJoin = join		
		local fnMax = amax
		
		local fnSelect = select
		local fnIsProperty = isProperty
		local fnClassOf = classOf
		local fnDelete = delete		
		local fnIsValidNode = isValidNode
		local fnUniqueName = uniqueName
		local fnUnhide = unhide
		local fnHide = hide		
		local fnCollapseStack = collapseStack
		local fnCenterPivot = centerPivot	
		local fnAddModifier = addModifier
		local fnDeleteModifier = deleteModifier
		local fnGetAppData = getAppData
		local fnSetAppData = setAppData
		
		local fnMatrixFromNormal = matrixFromNormal
		local fnInverseMatrix = inverse
		local fnUnitVector = normalize		
		local fnDistance = distance
		local fnRandomize = random
		local fnArcCosine = acos
		local fnCosine = cos
		local fnSine = sin		
		local fnDot = dot
		local fnCross = cross
		
		local fnGetFace = getFace
		local fnGetVert = getVert
		
		local fnGetTriMeshFaceCount = getTriMeshFaceCount
		local fnConvertToPoly = convertToPoly
		local fnConvertToMesh = convertToMesh
		local fnSnapshotAsMesh = snapshotAsMesh
		local fnSnapshot = snapshot	
		local fnUpdateMesh = update
		
		local fnSetEdgeVisibility = setEdgeVis
		local fnGetFaceSelection = getFaceSelection
		local fnGetFaceMatID = getFaceMatID		
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Initialize variables
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		local aMInfos = undefined -- Infos to display on top of screen (how to use IShatter, estimated fragments count)
		local aMGrid = undefined -- hold rayMeshGridIntersect structure (Provides advanced ray-to-mesh intersection methods using a uniform voxel grid as acceleration method )
		local aMVoroCoords = undefined -- hold points positions for voronoi modifiers		
		
		local p3MRadialPos = undefined -- hold the center position for radial distribution (point3)
		local p3MPlanePos = undefined -- hold the position on the plane parallel to camera (point3)
		local p3MHitPos = undefined -- hold the intersection position with the surface (point3)
		local p3MHitDir = undefined -- hold the intersection normal of the surface (unit vector)	
		
		local oMVoroEngine = undefined -- wich engine we want to use for IShatter (voroFrag or RayFire)
		local oMVoroObject = undefined -- the object to break (selected object... it will be hidden during IShatter process)
		local oMBorderObject = undefined -- the object to display during IShatter process (full edges or only border edges)
		local oMTrack = undefined -- the object to track and to use with rayMeshGridIntersect (it will be hidden too. It's not the same object as the selected object since we don't need to have a voronoi modifier on top... less calculations to perform)
		local oMImpact = undefined -- the sphere helper object
		local oMPSys = undefined -- the PFlow System to fill the volume of the boolean object created with the sphere helper and the tracked surface
		local oMPEvt = undefined -- the Event connected to the above PFlow System
		
		local iMVoroIndex = undefined -- the index of the voronoi modifier
		local iMVoroMethod = undefined -- the method to use (uniform, radial or wood)
		local iMNumPts = undefined -- the number of points per step for the regular pattern
		local iMNumLoops = undefined -- the number of loops for the radial pattern
		local iMNumRings = undefined -- the number of rings for the radial pattern
		local iMTwist = undefined -- the offset used for the radial pattern
		local fMStretch = undefined -- the stretching value
		local iMStretchAxis = undefined -- the stretching axis
		
		local bMEscape = undefined
		local bMDraged = undefined -- if we are performing a drag context (inside the mousetrack function)
		local bMCanBreak = undefined -- if we can break the object (inside the mousetrack function)
		local bMShowBorder = undefined -- if we want to display or not the border edges
		local bMHideObjects = undefined -- if we want to hide or not the remaining objects inside the viewport		
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Before starting the breaking process, save the current max file (if a filename is found) or use the "hold" command. Just in case 3DS Max crash :D
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnSaveFileOrHold =
		(
			mfn = maxfilename ; mfp = maxfilepath	
			if mfn.count > 0 then 
			(
				pathToSave = mfp + mfn
				savemaxfile pathToSave
			)
			else
			(
				max hold
			)
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Remove unused voroFrag pflow system
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnRemoveUnusedPFlow =
		(
			for o in objects where fnClassOf o == PF_Source do
			(
				if fnGetAppData o 1 == "IShatter" do
				(
					aDependReferences = refs.dependents o			
					aMeshes = for d in aDependReferences where fnClassOf d == Editable_Mesh collect d
					if aMeshes.count == 0 do
					(
						with undo on
						(
							particleFlow.BeginEdit()
							
							oEvent = o.getInitialActionList 1
							if oEvent != undefined do particleFlow.delete oEvent								
							particleFlow.delete o
							
							particleFlow.EndEdit()
						)			
					)						
				)		
			)
		)		
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Check mesh topology for VoroFrag modifier. The only restriction is that the modifier does not support overlapped faces. If some overlapped faces are detected, the modifier is deactivated.
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnCheckMeshForVoroFrag &bContinue =
		(
			with undo off
			(
				bContinue = false
				
				oTmpObject = fnSnapshot oMVoroObject
				iNumFacesBefore = oTmpObject.numfaces			
				
				fnSelect oTmpObject
				max modify mode
				modPanel.addModToSelection (voroFrag numChunks:10 useNormals:true showParticles:false)
				max create mode
				
				iNumFacesAfter = oTmpObject.numfaces
				fnDelete oTmpObject			
				
				if iNumFacesBefore != iNumFacesAfter do bContinue = true -- When voroFrag failed (inactivated) the new number of faces is the same as before.
			)					
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Retrieve all the objects with a IShatter voroFrag modifier.
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnObjWithVoroFragMod =
		(
			IShatterObjects = for o in IShatterObjects where fnIsValidNode o collect o			
			aAllSceneObjects = objects as array
			for o in aAllSceneObjects do
			(
				for m in o.modifiers do
				(					
					if fnClassOf m == VoroFrag do
					(					
						if fnIsProperty m #iShatterSeeds do
						(
							fnAppendIfUnique IShatterObjects m
						)
					)
				)				
			)			
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Check for a valid Voro Engine modifier.
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnCheckForValidEngine &bFoundEngine =
		(
			bFoundEngine = false
			for m = oMVoroObject.modifiers.count to 1 by -1 do 
			(
				modClass = fnClassOf oMVoroObject.modifiers[m]
				if modClass == VoroFrag or modClass == RayFire_Voronoi do
				(					
					if fnIsProperty oMVoroObject.modifiers[m] #iShatterSeeds then
					(
						bFoundEngine = true
						iMVoroIndex = m
						
						oMVoroEngine = modClass as string
						if oMVoroEngine == "voroFrag" do oMVoroEngine = "VoroFrag"
						
					)
					else
					(
						fnDeleteModifier oMVoroObject m
					)
				)			
			)		
		)

		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Reset Voro Engine modifier.
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn	fnResetVoronoiEngine =
		(
			for m = oMVoroObject.modifiers.count to 1 by -1 do
			(
				if fnGetAppData oMVoroObject.modifiers[m] 1 == "IShatter" do
				(
					modClass = fnClassOf oMVoroObject.modifiers[m]
					if modClass == VoroFrag do
					(					
						if fnIsProperty oMVoroObject.modifiers[m] #iShatterSeeds do
						(
							oMVoroObject.modifiers[m].useCustParts = false					
							oVoroPFlow = oMVoroObject.modifiers[m].pickPFlow									
							if oVoroPFlow != undefined do 
							(						
								with undo on
								(
									particleFlow.BeginEdit()
									
									oVoroEvent = oVoroPFlow.getInitialActionList 1
									if oVoroEvent != undefined do particleFlow.delete oVoroEvent								
									particleFlow.delete oVoroPFlow
									
									particleFlow.EndEdit()
								)
							)
						)
					)
					
					fnDeleteModifier oMVoroObject m
				)
			)
		)			
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Create Custom Attributes for the voronoi modifier. There's no way to keep track of existing voro points inside voroFrag and RayFire modifier so we need to store them in a custom attribute
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnCustomVoroCtrl =
		(
			cstA = attributes iShatterA 
			(
				parameters iShatterP
				(
					iShatterSeeds type:#point3Tab tabSize:0 tabSizeVariable:true			
				)
			)
			
			custAttributes.add oMVoroObject.modifiers[iMVoroIndex] cstA
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Create Custom Attributes for Vorofrag modifier. We use particles to drive the fragmentation but if you move the object the particles won't follow the movement... so by clicking on the update buttons it will put particles at the right location 
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnCustomVoroFragCtrl =
		(
			cstA = attributes IShatterA
			(
				parameters IShatterP rollout:IS_Roll
				(
					Voro_ThisObj type:#maxobject
				)
				
				rollout IS_Roll "Miscellaneous"
				(
					button bt_update "  Update Fragments  " height:22 width:130
					on bt_update pressed do
					(
						Voro_ThisObj.node.modifiers[#VoroFrag].useCustParts = false
						Voro_ThisObj.node.modifiers[#VoroFrag].pickPFlow.baseObject.activateParticles false	
						
						oVoroPFlow = Voro_ThisObj.node.modifiers[#VoroFrag].pickPFlow
						if oVoroPFlow != undefined do 
						(						
							with undo on
							(
								particleFlow.BeginEdit()									
								
								oVoroEvent = oVoroPFlow.getInitialActionList 1
								for i = 1 to oVoroEvent.numActions() do
								(
									oAction = oVoroEvent.getAction i
									if classof oAction == Cache do particleFlow.delete oAction								
								)
								
								CacheOp = Cache Use_At:2 Update_Type:1 Range_Type:2 Start_Time:0 End_Time:0 Cache_With_Hold:true Cache_With_File:true Clear_Range_Type:2 Clear_Start_Time:0 Clear_End_Time:1
								CacheOp.name = uniqueName (Voro_ThisObj.node.name + "_CacheSeeds_")
								oVoroEvent.appendAction CacheOp
								
								ParticleFlow.EndEdit()
							)
						)					
						
						Voro_ThisObj.node.modifiers[#VoroFrag].pickPFlow.baseObject.activateParticles true
						redrawViews() -- RedrawViews before... otherwise it will take twice the time to recompute
						select Voro_ThisObj.node
						Voro_ThisObj.node.modifiers[#VoroFrag].useCustParts = true
						
					)				
				)			
			)
			
			custAttributes.add oMVoroObject.modifiers[#IS_Stretch] cstA		
			oMVoroObject.modifiers[#IS_Stretch].Voro_ThisObj = nodeTransformMonitor node:oMVoroObject forwardTransformChangeMsgs:false		
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- When we change the stretching options for VoroFrag
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnUpdateVoroFragStretching =
		(
			fSquash = 1.0 - (fMStretch / 100.0)
			fStretch = 1.0 / fSquash
			
			p3Squash = [1.0, 1.0, 1.0] ; p3Stretch = [1.0, 1.0, 1.0]
			oMVoroObject.modifiers[#IS_Squash].gizmo.scale = p3Squash
			oMVoroObject.modifiers[#IS_Stretch].gizmo.scale = p3Stretch
			
			p3Squash[iMStretchAxis] = fSquash ; p3Stretch[iMStretchAxis] = fStretch							
			oMVoroObject.modifiers[#IS_Squash].gizmo.scale *= p3Squash
			oMVoroObject.modifiers[#IS_Stretch].gizmo.scale *= p3Stretch
			
			oMVoroObject.modifiers[iMVoroIndex].useCustParts = false
			oMVoroObject.modifiers[iMVoroIndex].pickPFlow.baseObject.activateParticles false

			if IS_IShatter_Roll.btn_Shatter.enabled do
			(
				oVoroPFlow = oMVoroObject.modifiers[iMVoroIndex].pickPFlow
				if oVoroPFlow != undefined do
				(								
					particleFlow.BeginEdit()
					
					oVoroEvent = oVoroPFlow.getInitialActionList 1									
					for i = 1 to oVoroEvent.numActions() do
					(										
						oAction = oVoroEvent.getAction i									
						if classof oAction == Cache do particleFlow.delete oAction								
					)
					
					CacheOp = Cache Use_At:2 Update_Type:1 Range_Type:2 Start_Time:0 End_Time:0 Cache_With_Hold:true Cache_With_File:true Clear_Range_Type:2 Clear_Start_Time:0 Clear_End_Time:1
					CacheOp.name = uniqueName (oMVoroObject.name + "_CacheSeeds_")
					oVoroEvent.appendAction CacheOp
					
					ParticleFlow.EndEdit()
				)
			)
			
			oMVoroObject.modifiers[iMVoroIndex].pickPFlow.baseObject.activateParticles true
			
			redrawViews() -- RedrawViews before... otherwise it will take twice the time to recompute
			oMVoroObject.modifiers[iMVoroIndex].useCustParts = true			
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- If we delete current voronoi object
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnWhenDeleteVoroObject &oVoroObject =
		(
			for m in oVoroObject.modifiers do 
			(
				modClass = fnClassOf m
				if modClass == VoroFrag do
				(
					m.useCustParts = false					
					oVoroPFlow = m.pickPFlow
					if oVoroPFlow != undefined do 
					(						
						with undo on
						(
							particleFlow.BeginEdit()
							
							oVoroEvent = oVoroPFlow.getInitialActionList 1
							if oVoroEvent != undefined do particleFlow.delete oVoroEvent								
							particleFlow.delete oVoroPFlow
							
							particleFlow.EndEdit()
						)
					)
				)
			)				
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Get object volume
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnCalculateVolume &fVolume =
		(
			fVolume= 0.0			
			oMesh = fnSnapshotAsMesh oMVoroObject
			iNumFaces = oMesh.numfaces
			
			for f = 1 to iNumFaces do
			(
				aFace = fnGetFace oMesh f
				p3vert2 = fnGetVert oMesh aFace.z
				p3vert1 = fnGetVert oMesh aFace.y
				p3vert0 = fnGetVert oMesh aFace.x
				fdV = fnDot (fnCross (p3Vert1 - p3Vert0) (p3Vert2 - p3Vert0)) p3Vert0
				fVolume += fdV			  
			)
			
			fVolume /= 6
			fnDelete oMesh				
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Create the visual sphere helper
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnCreateIShatterHelper =
		(
			oMImpact = sphere segs:12 radius:1.0
			oMImpact.wirecolor = color 0 255 0
			
			fnSelect oMImpact
			macros.run "Modifier Stack" "Convert_to_Patch"
			setPatchSteps oMImpact 10
			
			oMImpact.material = IShatterHelperMat			
			oMImpact.name = "IS_Helper"
			oMImpact.scale = [0.0,0.0,0.0]
			
			clearSelection()
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Radial mouse points distribution
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnRadialPointDistribution &fExpand =
		(
			if aMVoroCoords == undefined do aMVoroCoords = #()
			
			mNormalMatrix = fnMatrixFromNormal p3MHitDir		
			fStep = fExpand / iMNumLoops		
			fAng = 360.0 / iMNumRings
			fVal = iMTwist / 5.0
			fOffset = 0.0

			p3Origin = [0,0,0]
			mInvMatrix = fnInverseMatrix oMVoroObject.transform
			if oMVoroEngine == "VoroFrag" then p3Origin = p3MHitPos * mInvMatrix else p3Origin = p3MHitPos
			
			for i = 1.0 to 360.0 by fAng do
			(			
				i += fnRandomize (-fAng * .5) (fAng * .5)
				for j = 1 to iMNumLoops do
				(
					fOffset += fVal
					i += fnRandomize (-fAng * .05) (fAng * .05)					
					
					p3Dir = (fnUnitVector ([fnCosine (i + fOffset), fnSine (i + fOffset), 0.0])) * mNormalMatrix 
					p3RadialPos = p3Origin + (p3Dir * (fStep + fnRandomize 0.0 (fStep * 0.1)) * j)			
					fnAppend aMVoroCoords p3RadialPos
				)		
			)			
		)
	
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Create a boolean object from original object and a sphere (radius equal to helper radius when we release the mouse)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnIrregularPointDistribution &fExpand &oVolumeObj =
		(		
			oBoolObj = fnSnapshot oMTrack
			oSphereObj = fnConvertToMesh (sphere segs:12 radius:fExpand pos:p3MHitPos)
			
			boolObj.createBooleanObject oBoolObj
			boolObj.setBoolOp oBoolObj 2
			boolObj.SetOperandB oBoolObj (fnSnapshot oSphereObj) 4 2
			
			if (fnGetTriMeshFaceCount oBoolObj)[2] > 3 then
			(
				oVolumeObj = fnConvertToMesh oBoolObj
				fnDelete oSphereObj
			)
			else 
			(
				oVolumeObj = oSphereObj
				fnDelete oBoolObj
			)
			
			fnHide oVolumeObj	
		)
	
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Create a pFlow system to fill the volume of the boolean object created with the above function.
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnPFSeeds &iLocation =
		(
			oMPSys = PF_Source()
			oMPSys.name = "IS_Seeds"
			
			oMPSys.show_logo = false
			oMPSys.show_emitter = false
			oMPSys.quantity_viewport = 100
			
			particleFlow.BeginEdit()	
			
			BirthEvent = Birth Emit_Start:0 Emit_Stop:0 Amount:0
			PositionEvent = Position_Object Location:iLocation Emitter_Objects:#()					
			
			ParticleFlow.EndEdit()
			
			oMPEvt = Event()
			oMPEvt.appendAction BirthEvent	
			oMPEvt.appendAction PositionEvent

			oMPSys.appendInitialActionList oMPEvt
		)
	
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Fill the volume with particles and retrieve coordinates
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnPopulatePFSeeds &oVolumeObj =
		(
			BirthEv = oMPEvt.getAction 1
			BirthEv.Amount = iMNumPts
			
			PosEv = oMPEvt.getAction 2
			PosEv.Emitter_Objects = #()
			PosEv.Emitter_Objects = #(oVolumeObj)

			RedrawViews()		
			
			if oMVoroEngine == "VoroFrag" then
			(
				mInvMatrix = fnInverseMatrix oMVoroObject.transform
				aCoords = for i = 1 to iMNumPts collect (oMPSys.getParticlePosition i * mInvMatrix)
			)
			else
			(
				aCoords = for i = 1 to iMNumPts collect oMPSys.getParticlePosition i 
			)	
			
			if aMVoroCoords == undefined do aMVoroCoords = #()		
			fnJoin aMVoroCoords aCoords			
			fnDelete oVolumeObj
		)

		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Delete pFlow System
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnErasePFSeeds =
		(
			particleFlow.BeginEdit()
			
			oMPSys.removeInitialActionList 1
			particleFlow.delete oMPSys
			particleFlow.delete oMPEvt
			
			particleFlow.EndEdit()			
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Create a pFlow System to use with VoroFrag plugin (since we can't "send" points directly to VoroFrag except using a particle system)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnVoroFragPF &pSys =
		(
			-- get current time infos (day of creation)
			aTimeInfos = getLocalTime()
			
			-- get 3ds Max current version
			aMaxInfos = filterString (getFileVersion "$max/3dsmax.exe") ","
			iMaxVersion = (aMaxInfos[1] as integer - 2) as string
			iServicePack = aMaxInfos[2]
			iBuildNumber = aMaxInfos[3]
			
			-- get voroFrag plugin version
			stdPluginsPath = (getDir #maxroot) + "stdplugs\\*.dlm"
			aAllFiles = getFiles stdPluginsPath
			voroFragVersion = ""
			
			for f in aAllFiles do 
			(
				pluginName = (filterString f "\\")[(filterString f "\\").count]
				if (filterString pluginName "_")[1] == "VoroFrag" do 
				(
					voroFragName = (filterString pluginName "dlm")[1] 
					voroFragVersion = substring voroFragName 1 (voroFragName.count - 1)
				)
			)			
			
			-- create particle flow system
			pSys = PF_Source()
			pSys.name = fnUniqueName (oMVoroObject.name + "_VoroPFlow_")
			
			pSys.show_logo = false
			pSys.show_emitter = false
			pSys.quantity_viewport = 100
			
			particleFlow.BeginEdit()	
			
			-- Fill in the birth script operator
			ProceedScript = "-- THIS SCRIPT IS USED TO GENERATE VORO FRAG SEEDS \n"
			ProceedScript += "-- \n"
			ProceedScript += "-- Author :  MOAB \n"
			ProceedScript += "-- Created : " +   (formattedPrint aTimeInfos[4] format:".2d") + "/" + (formattedPrint aTimeInfos[2] format:".2d") + "/" + aTimeInfos[1] as string + " " + (formattedPrint aTimeInfos[5] format:".2d") +":" + (formattedPrint aTimeInfos[6] format:".2d") +"\n"			
			ProceedScript += "-- Software : 3ds Max 20" + iMaxVersion + " SP" + iServicePack + " buildNumber " + iBuildNumber + "\n"
			ProceedScript += "-- Plugin : " + voroFragVersion + "\n"
			ProceedScript += "-- \n"
			ProceedScript += "-- MODIFY THIS AT YOUR OWN RISK \n"
			ProceedScript += " \n"
			
			ProceedScript += "on ChannelsUsed pCont do \n"
			ProceedScript += "( \n"
			ProceedScript += "\t pCont.useTime = true \n"
			ProceedScript += "\t pCont.useAge = true \n"
			ProceedScript += "\t pCont.usePosition = true \n"
			ProceedScript += ") \n"
			ProceedScript += " \n"
			
			ProceedScript += "on Init pCont do \n"
			ProceedScript += "( \n"
			ProceedScript += " \n"
			ProceedScript += ") \n"
			ProceedScript += " \n"
			
			ProceedScript += "on Proceed pCont do \n"
			ProceedScript += "( \n"
			ProceedScript += "\t t1 = pCont.getTimeEnd() as float \n"
			ProceedScript += "\t if t1 == 0 do \n"
			ProceedScript += "\t ( \n"
			ProceedScript += "\t \t thePF = pCont.getParticleSystemNode() \n"
			ProceedScript += "\t \t aDependReferences = refs.dependents thePF \n"
			ProceedScript += "\t \t aVoroMod = for d in aDependReferences where classof d == VoroFrag collect d \n"
			ProceedScript += "\t \t aVoroMesh = for d in aDependReferences where classof d == Editable_Mesh collect d \n"
			ProceedScript += "\t \t \n"
			ProceedScript += "\t \t if aVoroMod.count == 1 and aVoroMesh.count == 1 do \n"
			ProceedScript += "\t \t ( \n"
			ProceedScript += "\t \t \t if isProperty aVoroMod[1] #iShatterSeeds do \n"
			ProceedScript += "\t \t \t ( \n"
			ProceedScript += "\t \t \t \t mMatrix = aVoroMesh[1].transform \n"			
			ProceedScript += "\t \t \t \t mScaleMatrix = scaleMatrix aVoroMesh[1].modifiers[#IS_Squash].gizmo.scale \n"
			ProceedScript += "\t \t \t \t mStretchMatrix = mScaleMatrix * mMatrix \n"
			ProceedScript += "\t \t \t \t \n"
			ProceedScript += "\t \t \t \t for c in aVoroMod[1].iShatterSeeds do \n"
			ProceedScript += "\t \t \t \t ( \n"
			ProceedScript += "\t \t \t \t \t pCont.AddParticle() \n"
			ProceedScript += "\t \t \t \t \t pCont.particleIndex = pCont.NumParticles() \n"
			ProceedScript += "\t \t \t \t \t pCont.particleTime = 0 \n"
			ProceedScript += "\t \t \t \t \t pCont.particleAge = 0 \n"
			ProceedScript += "\t \t \t \t \t pCont.particlePosition = c * mStretchMatrix \n"
			ProceedScript += "\t \t \t \t ) \n"
			ProceedScript += "\t \t \t ) \n"
			ProceedScript += "\t \t ) \n"		
			ProceedScript += " \t ) \n"			
			ProceedScript += ") \n"			
			
			BirthScriptEvent = Birth_Script Emit_Start:0 Proceed_Script:ProceedScript	
			BirthScriptEvent.name = fnUniqueName (oMVoroObject.name + "_BirthSeeds_")				
			
			ParticleFlow.EndEdit()
			
			-- add initial event and append birst script operator
			pEv = Event()
			pEv.name = fnUniqueName (oMVoroObject.name + "_VoroEvent_")
			pEv.appendAction BirthScriptEvent
			pSys.appendInitialActionList pEv

			-- set particle flow position inside particle view
			x = y = 0		
			pSys.getPViewLocation &x &y
			pSys.setPViewLocation (x+20) y
			pEv.setPViewLocation (x+20) (y+75)

			fnSetAppData pSys 1 "IShatter"
			freeze pSys
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Hide unecessary edges when object is denser 
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnShowBorderEdges =
		(
			oMBorderObject = fnSnapshot oMVoroObject
			iNumFaces = oMBorderObject.numfaces
			
			baFacesSelected = fnGetFaceSelection oMBorderObject
			if baFacesSelected.isEmpty do
			(
				baFacesSelected = (for f = 1 to iNumFaces where fnGetFaceMatID oMBorderObject f == 2 collect f) as bitarray -- need to test for voroFrag since sometimes it fails selecting inner faces
			)
			
			baFacesToHide = #{1..iNumFaces} - baFacesSelected
			for f in baFacesToHide do for ed = 1 to 3 do fnSetEdgeVisibility oMBorderObject f ed false    
			fnUpdateMesh oMBorderObject

			oMBorderObject.name = "IS_Mesh"
			oMBorderObject.wirecolor = black
			oMBorderObject.material = IShatterVoroMat
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Show all edges
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnShowAllEdges =
		(
			oMBorderObject = fnSnapshot oMVoroObject
			oMBorderObject.name = "IS_Mesh"
			oMBorderObject.wirecolor = black
			oMBorderObject.material = IShatterVoroMat
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- sort intersect rays hits by distance
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnSortHits v1 v2 =
		(
			local d = v1 - v2
			case of
			(
				(d < 0.): -1
				(d > 0.): 1
				default: 0
			)
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Use this method for mouseTrack fuction (fatser than their native intersect ray method in case we have a denser object)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnRayMeshGrid =
		(
			aMGrid = RayMeshGridIntersect() 
			aMGrid.Initialize 100
			aMGrid.addNode oMTrack
			aMGrid.buildGrid()	
		)

		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Clear rayMeshGrid object (free memory)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnClearRayMeshGrid =
		(
			aMGrid.free()
			aMGrid.ClearStats()
			
			aMGrid = undefined		
			gc()
		)
	
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Retrieve intersection data when we first hit the surface
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnGetMouseRegularHitPos =
		(
			rRay = fnMapScreenToWorldRay mouse.pos
			iHits = aMGrid.intersectRay rRay.pos rRay.dir false
			
			if iHits > 0 then
			(
				iClosestHit = aMGrid.getClosestHit()
				fMinDist = aMGrid.getHitDist iClosestHit			
				p3MHitDir = aMGrid.getHitNormal iClosestHit				
				p3MHitPos = rRay.pos + (fMinDist * rRay.dir)			
			)
			else
			(
				p3MHitPos = undefined			
			)
		)

		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Retrieve intersection data when we use the radial method
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnGetMouseRadialHitPos = 
		(			
			iHits = aMGrid.intersectRay p3MHitPos p3MHitDir true			
			if iHits > 0 then
			(
				aHits = for i = 1 to iHits collect aMGrid.getHitDist i				
				if aHits.count > 1 then
				(
					fnQSort aHits fnSortHits									
					fRandDist = fnRandomize 0.0 (aHits[2] * 0.1)
					p3MRadialPos = p3MHitPos + (fRandDist * p3MHitDir)
				)
				else
				(	
					fRandDist = fnRandomize 0.0 (aHits[1] * 0.1)
					p3MRadialPos = p3MHitPos + (fRandDist * p3MHitDir)
				)							
			)
			else
			(
				p3MRadialPos = undefined			
			)		
		)
	
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Retrieve the world mouse position when we perform a drag.
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnGetMouseWorldPos =
		(
			MInvViewTm = fnInverseMatrix (getViewTM())
			
			p3ViewCameraWorldPos = MInvViewTm.row4
			p3ViewCameraWorldDir = -MInvViewTm.row3
		
			fViewAngle = fnArcCosine (fnDot (fnUnitVector (p3MHitPos - p3ViewCameraWorldPos)) p3ViewCameraWorldDir)
			fViewDepth = (fnDistance p3MHitPos p3ViewCameraWorldPos) * (fnCosine fViewAngle)
		
			p2MouseScreenPos = mouse.pos
			p3MouseViewPos = fnMapScreenToView p2MouseScreenPos (-fViewDepth)
			p3MPlanePos = p3MouseViewPos * MInvViewTm
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Mouse track function : here everything's happen (the core function)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnIShatterMouseTrack msg ir obj faceNum shift ctrl alt =
		( 		
			-- when you move the mouse over the surface
			if msg == #freeMove do 
			(					
				fnGetMouseRegularHitPos()			
			)		

			-- when you release the left mouse button after a drag (fragmentation process)
			if msg == #mousePoint do 
			(			
				if p3MHitPos != undefined and bMDraged do
				(
					bMCanBreak = false			
					fnHide oMImpact			
					
					p3GizmoPos = oMImpact.pos
					fGizmoRadius = fnMax #(2.0, oMImpact.scale.x)
					
					-- When we add points
					if not alt then 
					(					
						aMInfos[3] = ""
						aMInfos[3] = "        Please Wait ... Currently Fragmented          "					
						
						with undo off
						(
							case iMVoroMethod of
							(
								1:
								(
									fnIrregularPointDistribution &fGizmoRadius &oVolumeObj	
									fnPopulatePFSeeds &oVolumeObj
								)
								2:
								(
									fnGetMouseRadialHitPos()
									fnRadialPointDistribution &fGizmoRadius									
								)														
							)							
						)
					)
					
					-- When we remove points
					else 
					(
						aMInfos[3] = ""
						aMInfos[3] = "        Please Wait ... Removing Fragments          "					
						
						with undo off
						(
							if oMVoroEngine == "VoroFrag" then
							(								
								mMatrix = oMVoroObject.transform							
								for c = aMVoroCoords.count to 1 by -1 do if fnDistance (aMVoroCoords[c] * mMatrix) p3GizmoPos < fGizmoRadius do fnDeleteItem aMVoroCoords c
							)
							else
							(
								for c = aMVoroCoords.count to 1 by -1 do if fnDistance aMVoroCoords[c] p3GizmoPos < fGizmoRadius do fnDeleteItem aMVoroCoords c								
							)												
						)							
					)
					
					-- Update selected voronoi modifier
					if oMVoroEngine == "VoroFrag" then
					(
						with undo off
						(
							oMVoroObject.modifiers[iMVoroIndex].useCustParts = false
							oMVoroObject.modifiers[iMVoroIndex].pickPFlow.baseObject.activateParticles false		
							oMVoroObject.modifiers[iMVoroIndex].iShatterSeeds = aMVoroCoords	
							oMVoroObject.modifiers[iMVoroIndex].pickPFlow.baseObject.activateParticles true
							
							redrawViews() -- RedrawViews before... otherwise it will take twice the time to recompute
							oMVoroObject.modifiers[iMVoroIndex].useCustParts = true
						)							
					)
					else
					(							
						with undo off
						(
							oMVoroObject.modifiers[iMVoroIndex].setPoints aMVoroCoords
							oMVoroObject.modifiers[iMVoroIndex].iShatterSeeds = aMVoroCoords
						)
					)
					
					-- Display all edges or only borders edges
					fnDelete oMBorderObject
					if bMShowBorder then fnShowBorderEdges() else fnShowAllEdges()					
					
					pushPrompt "Fragmentation Completed"
				
					oMImpact.scale = [0.0, 0.0, 0.0]
					oMImpact.pos = [0.0, 0.0, 0.0]
				
					p3MHitPos = undefined ; p3MHitDir = undefined
					bMCanBreak = true ; bMDraged = false
					
					aMInfos[3] = "                  Estimated Fragments : " + aMVoroCoords.count as string
					redrawViews()
				)
			)
			
			-- when you drag the mouse (change the sphere helper radius)
			if msg == #mouseMove do
			(
				if p3MHitPos != undefined and bMCanBreak do
				(				
					if not alt then oMImpact.wirecolor = oMImpact.material.diffuse = green else oMImpact.wirecolor = oMImpact.material.diffuse = red
					
					fnUnhide oMImpact				
					oMImpact.pos = p3MHitPos
					oMImpact.dir = p3MHitDir	
					
					fnGetMouseWorldPos()				
					if p3MPlanePos != undefined do
					(
						fDist = fnDistance p3MPlanePos p3MHitPos
						oMImpact.scale = [fDist, fDist, fDist] 
					)
					
					bMDraged = true
				)			
			)			
			
			-- when you right click (exit the process)
			if msg != #mouseAbort then #continue else 
			(
				
			)			
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Clear unecessary objects, data created for IShatter
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnClearIShatterData =
		(
			-- if we use voroFrag we need a pflow cache operator
			if oMVoroEngine == "VoroFrag" do 
			(
				fnSelect oMVoroObject
				
				oMVoroObject.modifiers[iMVoroIndex].selInFaces = false				
				oMVoroObject.modifiers[iMVoroIndex].useCustParts = false
				oMVoroObject.modifiers[iMVoroIndex].pickPFlow.baseObject.activateParticles false				
				
				oVoroPFlow = oMVoroObject.modifiers[iMVoroIndex].pickPFlow
				oVoroEvent = oVoroPFlow.getInitialActionList 1					
				
				particleFlow.BeginEdit()
				CacheOp = Cache Use_At:2 Update_Type:1 Range_Type:2 Start_Time:0 End_Time:0 Cache_With_Hold:true Cache_With_File:true Clear_Range_Type:2 Clear_Start_Time:0 Clear_End_Time:1
				CacheOp.name = fnUniqueName (oMVoroObject.name + "_CacheSeeds_")
				oVoroEvent.appendAction CacheOp	
				particleFlow.EndEdit()

				oMVoroObject.modifiers[iMVoroIndex].pickPFlow.baseObject.activateParticles true
				
				redrawViews() -- RedrawViews before... otherwise it will take twice the time to recompute
				oMVoroObject.modifiers[iMVoroIndex].useCustParts = true
			)		
			
			-- delete data
			fnDelete oMBorderObject ; oMBorderObject = undefined
			fnDelete oMTrack ; oMTrack = undefined 
			fnDelete oMImpact ; oMImpact = undefined

			bMEscape = undefined ; bMDraged = undefined ; bMCanBreak = undefined	
			p3MRadialPos = undefined  ; p3MPlanePos = undefined
			p3MHitPos = undefined ; p3MHitDir = undefined	
			fMStretch = undefined		
			
			fnUnhide oMVoroObject			
			aMHiddenObjects = undefined
			
			viewport.setGridVisibility #all true				
			pushPrompt ""
			
			try(NitrousView = NitrousGraphicsManager.GetActiveViewportSetting() ; NitrousView.VisualStyleMode = #Realistic) catch()		
		)
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Display infos on top of your screen (estimated number of fragments...)
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnScreenInfosCallback &aStrings =
		(
			local mViewTM = fnInverseMatrix (getViewTM())
			local p3ViewCameraWorldPos = mViewTM.row4
			local p3ViewCameraWorldDir = -mViewTM.row3

			local fViewAngle = fnArcCosine (fnDot (fnUnitVector ([0,0,0] - p3ViewCameraWorldPos)) p3ViewCameraWorldDir)
			local fViewDepth = (fnDistance [0,0,0] p3ViewCameraWorldPos) * (fnCosine fViewAngle)	

			fXOffset = 0.0 ; fYOffset = 0.0
			aWorldPos = #()	
			
			gw.setTransform(Matrix3 1)	
			
			for i = 1 to aStrings.count do
			(		
				p2ViewSize = getViewSize()	
				
				p2ViewSize.x /= 2.0			
				p2ViewSize.x += fXOffset
				p2ViewSize.y = 30.0 + fYOffset

				p3ViewPos = fnMapScreenToView p2ViewSize (-fViewDepth)
				p3TxtWorldPos = p3ViewPos * mViewTM
				
				gw.text p3TxtWorldPos aStrings[i] color:green
				
				fXOffset -= 5.0
				fYOffset += 20.0
			)	
			
			gw.enlargeUpdateRect #whole 
			gw.updateScreen()		
		)
		
		fn fnRegisterScreenInfos = fnScreenInfosCallback &aMInfos
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- Set viewport settings for IShatter
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		fn fnSetViewOptionsForIShatter =
		(
			viewport.setType #view_persp_user
			viewport.setGridVisibility #all false
			viewport.SetTransparencyLevel 3
			
			try(NitrousGraphicsManager.AntialiasingQuality = #4X) catch() -- avalaible only in 3dsMax 2015 and after
			
			try
			(
				NitrousView = NitrousGraphicsManager.GetActiveViewportSetting()					
				NitrousView.VisualStyleMode = #Shaded
				NitrousView.ShowEdgedFacesEnabled = true
				NitrousView.TransparencyEnabled = true
			)
			catch
			(
			)
			
			fnSelect oMBorderObject					
			Max tool zoomextents
			viewport.zoom 1.25

			aMInfos = #("  Click & Drag to Define an Inpact Area  ", "  Alt Click & Drag to Remove an Inpact Area  ", "                  Estimated Fragments : " + aMVoroCoords.count as string)
			unRegisterRedrawViewsCallback fnRegisterScreenInfos
			RegisterRedrawViewsCallback fnRegisterScreenInfos
			completeredraw()		
		)		
		
		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --		
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- 																													IS - IShatter Rollout Definition
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
		rollout IS_IShatter_Roll "\xa9IShatter v1.0 "  
		(
			fn Mesh_Filter obj = superclassof obj == geometryClass and canConvertTo obj Editable_mesh
			
			group ""
			(
				pickButton pb_Track " <<  Select an Object  >>" width:142 height:26 filter:Mesh_Filter align:#left across:2 offset:[0,-7]
				button bt_Reset "X" height:26 align:#right tooltip:"Remove the selected voronoi engine" offset:[0,-7]
			)		
			
			group ""
			(
				hyperlink hl_Engine "Engine :" align:#left color:(color 0 180 255) across:2 enabled:false
				dropdownlist dd_Engine items:#() width:93 offset:[-10,-4]
				
				hyperlink hl_Method "Method :" align:#left color:(color 0 180 255) across:2 enabled:false
				dropdownlist dd_Method items:#("Uniform", "Radial") width:93 offset:[-10,-4]
				
				hyperlink hl_Iter "Iterations :" align:#left color:(color 0 180 255) across:2 enabled:false	offset:[0,10]			
				spinner sp_Iter "" fieldWidth:35 type:#integer range:[2,500,50] align:#right tooltip:"Number of generated fragments per step" offset:[0,10]				

				hyperlink hl_Loop "Loop / Ring :" align:#left color:(color 0 180 255) across:3 enabled:false visible:false offset:[0,-21]	
				spinner sp_Loop "" fieldWidth:35 type:#integer range:[2,200,5] offset:[8,-21] visible:false
				spinner sp_Ring "" fieldWidth:35 type:#integer range:[3,200,10] offset:[2,-21] visible:false		
				
				hyperlink hl_Offset "Offset :" align:#left color:(color 0 180 255) across:2 enabled:false visible:true offset:[0,2]	
				spinner sp_Offset "" fieldWidth:35 type:#float range:[0.0,100.0,0.0] align:#right enabled:false visible:true offset:[0,2]
				
				hyperlink hl_Stretching "Stretching :" align:#left color:(color 0 180 255) enabled:false visible:true offset:[0,10]
				radiobuttons rb_Axis labels:#("X", "Y", "Z") default:3 columns:3 across:2 align:#left 
				spinner sp_Stretch "" fieldWidth:35 type:#float range:[0.0,100.0,0.0] visible:true tooltip:"Define the amount of stretchiness along the selected axis... useful to create wood patterns"		
			)
			
			group ""
			(				
				hyperlink hl_Border  "Show Only Border Edges " align:#left color:(color 0 180 255) across:2 enabled:false 
				checkBox chk_BorderEdges "" align:#right offset:[8,0] checked:false tooltip:"Improved visibility when using dense meshes"
				hyperlink hl_AutoSave  "Safe Mode" align:#left color:(color 0 180 255) across:2 enabled:false offset:[0,0]
				checkBox chk_AutoSave "" align:#right offset:[8,0] checked:false tooltip:"Perform a File/Save or an Edit/Hold before starting the cutting process"
			)
			
			group ""
			(
				button btn_Shatter "  ISHATTER  " width:165 height:35 offset:[0,-6.5]				
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  When we press the pick button
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --	
			on pb_Track picked obj do
			(
				fnRemoveUnusedPFlow()
				
				oMVoroObject = obj
				oMVoroObject.material = IShatterVoroMat
				oMVoroObject.wirecolor = black
				
				pb_Track.text = obj.name
				dd_Engine.enabled = true
				rb_Axis.state = 3
				sp_Stretch.value = 0
				
				fnCheckForValidEngine &bFoundValid
				if bFoundValid do
				(				
					if oMVoroEngine == "VoroFrag" then 
					(
						p3Squash = oMVoroObject.modifiers[#IS_Squash].gizmo.scale
						aSquashes = #(p3Squash.x, p3Squash.y, p3Squash.z)
						fStretch = aMin aSquashes
						
						if fStretch < 1.0 do
						(
							iAxis = findItem aSquashes fStretch
							rb_Axis.state = iMStretchAxis = iAxis
							sp_Stretch.value = fMStretch = (1.0 - fStretch) *100.0
						)						
						
						dd_Engine.selection = 1
						dd_Engine.enabled = false						
					)
					else
					(		
						aStretches = #(oMVoroObject.modifiers[iMVoroIndex].prescale_x, oMVoroObject.modifiers[iMVoroIndex].prescale_y, oMVoroObject.modifiers[iMVoroIndex].prescale_z)
						fStretch = aMax aStretches									
						
						if fStretch > 0.0 do
						(
							iAxis = findItem aStretches fStretch
							rb_Axis.state = iMStretchAxis = iAxis 
							sp_Stretch.value = fMStretch = fStretch	
						)							
						
						dd_Engine.selection = 2
						dd_Engine.enabled = false					
					)							
				)

				IShatterObjects = for o in IShatterObjects where fnIsValidNode o collect o
				fnAppendIfUnique IShatterObjects obj
				
				-- create a delete callback (used in case of VoroFrag modifier... it will delete the PFlow system used to store points)
				deleteAllChangeHandlers id:#trackDeletion
				when IShatterObjects deleted id:#trackDeletion obj do
				(
					fnWhenDeleteVoroObject &obj					
					
					if obj == oMVoroObject do
					(
						dd_Engine.enabled = true ; dd_Engine.selection = 1 ; dd_Method.selection = 1
						hl_Loop.visible = false ; sp_Loop.visible = false ; sp_Ring.visible = false 
						hl_Iter.visible = true ; sp_Iter.visible = true ; sp_Iter.value = 50
						rb_Axis.state = 3 ; sp_Stretch.value = 0.0
						chk_BorderEdges.state = false						
						pb_Track.text =  " <<  Select an Object  >>"
						
						oMVoroObject = undefined
					)						
				)
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  When we press the reset button
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on bt_Reset pressed do
			(
				if selection.count ==0 then 
				(
					messagebox "别忽悠我，请选中物体不然会报错，真的！" beep:false
				)	
				else
				(				
					if isValidNode oMVoroObject do
					(
						max create mode
						fnResetVoronoiEngine()
					
						dd_Engine.enabled = true ; dd_Engine.selection = 1 ; dd_Method.selection = 1
						hl_Loop.visible = false ; sp_Loop.visible = false ; sp_Ring.visible = false 
						hl_Iter.visible = true ; sp_Iter.visible = true ; sp_Iter.value = 50
						rb_Axis.state = 3 ; sp_Stretch.value = 0.0
						chk_BorderEdges.state = false 			
					)

				)
				redrawViews()
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			-- When we rightclick the pick button
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on pb_Track rightclick do
			(
				if isValidNode oMVoroObject do
				(
					fnUnhide oMVoroObject
				)				
			)

			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  show only edges borders checkbox 
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on chk_BorderEdges changed state do
			(
				bMShowBorder = state
				if oMBorderObject != undefined do
				(
					fnDelete oMBorderObject
					if bMShowBorder then fnShowBorderEdges() else fnShowAllEdges()					
				)
			)

			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  When we change the voronoi cutting method (uniform or radial)
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on dd_Method selected i do
			(
				iMVoroMethod = i
				case i of
				(
					1:
					(
						hl_Loop.visible = false ; sp_Loop.visible = false ; sp_Ring.visible = false
						hl_Iter.visible = true ; sp_Iter.visible = true
						sp_Offset.enabled = false
					)
					2:
					(
						hl_Iter.visible = false ; sp_Iter.visible = false						
						hl_Loop.visible = true ; sp_Loop.visible = true ; sp_Ring.visible = true ; 
						sp_Offset.visible = true ; sp_Offset.enabled = true						
					)					
				)
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  When we change voronoi variables --> those changes will take effects during the next fragmentation
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on sp_Iter changed val do iMNumPts = val
			on sp_Loop changed val do iMNumLoops = val
			on sp_Ring changed val do iMNumRings = val
			on sp_Offset changed val do	iMTwist = val

			on rb_Axis changed axis do
			(
				iMStretchAxis = axis
				if isValidNode oMVoroObject do
				(
					if not dd_Engine.enabled do
					(						
						if oMVoroEngine == "VoroFrag" then
						(
							with undo off
							(							
								fnUpdateVoroFragStretching()
							)							
						)
						else
						(
							oMVoroObject.modifiers[iMVoroIndex].prescale_x = oMVoroObject.modifiers[iMVoroIndex].prescale_y = oMVoroObject.modifiers[iMVoroIndex].prescale_z = 0
							case axis of 
							(
								1: oMVoroObject.modifiers[iMVoroIndex].prescale_x = fMStretch
								2: oMVoroObject.modifiers[iMVoroIndex].prescale_y = fMStretch
								3: oMVoroObject.modifiers[iMVoroIndex].prescale_z = fMStretch
							)
						)
					)
				)			
			)
			
			on sp_Stretch buttonup do
			(
				fMStretch = sp_Stretch.value				
				if isValidNode oMVoroObject do
				(
					if not dd_Engine.enabled do
					(
						iAxis = rb_Axis.state
						if oMVoroEngine == "VoroFrag" then
						(
							with undo off
							(							
								fnUpdateVoroFragStretching()
							)
						)
						else
						(						
							case iAxis of 
							(
								1: oMVoroObject.modifiers[iMVoroIndex].prescale_x = fMStretch
								2: oMVoroObject.modifiers[iMVoroIndex].prescale_y = fMStretch
								3: oMVoroObject.modifiers[iMVoroIndex].prescale_z = fMStretch
							)						
						)
					)
				)
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  when we press the iShatter button
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on btn_Shatter pressed do
			(				
				fnRemoveUnusedPFlow()
				gc()
				
				if isValidNode oMVoroObject do
				(					
					max create mode
					fnUnhide oMVoroObject
					
					pb_Track.enabled = btn_Shatter.enabled = false
					sliderTime = 0
					
					-- first save the scene or "hold" to save the scene and its settings to a disk-based buffer
					if chk_AutoSave.state do fnSaveFileOrHold()					
					
					-- it means that there's no voro engine... if a previous one was found on this object we couldn't select a voro engine in the GUI
					if dd_Engine.enabled	then 
					(
						dd_Engine.enabled = false
						
						-- initialize voronoi coordinates
						aMVoroCoords = #()						
						
						-- center object pivot						
						fnCenterPivot oMVoroObject								
						
						-- create tracked object... it will be use with the mouse track function						
						oMTrack = fnConvertToPoly (fnSnapshot oMVoroObject)
						oMTrack.name = "IS_Track"
						fnHide oMTrack										
						
						-- if we use voroFrag we need to create a custom particle sytem to set the points for the modifier.
						-- VoroFrag is pretty sensitive with input meshes... we need to perform a test to see if voroFrag will work
						if dd_Engine.selected == "VoroFrag" then
						(							
							fnCheckMeshForVoroFrag &bContinue
							if not bContinue do 
							(
								fnDelete oMTrack
								pb_Track.enabled = btn_Shatter.enabled = true ; dd_Engine.enabled = true
								return messageBox "VoroFrag failed... Check your mesh topology !" title:"voroFrag Warning"
							)
							
							iMVoroIndex = 2
							oMVoroEngine = "VoroFrag"
							fnVoroFragPF &voroSysPFlow
							
							materialIDMod = Materialmodifier materialID:1 name:"IS_Material"
							fnSetAppData materialIDMod 1 "IShatter"
							resetXFormMod = XForm name:"IS_Reset"
							fnSetAppData resetXFormMod 1 "IShatter"
							squashMod = XForm name:"IS_Squash"
							fnSetAppData squashMod 1 "IShatter"
							voroMod = VoroFrag useCustParts:true pickPFlow:voroSysPFlow useNormals:true selInFaces:false materialID:2 mappingType:3 multiThreading:true showParticles:false pivotCenter:true fragname:(oMVoroObject.name + "_IShatter_") name:"VoroFrag"
							fnSetAppData voroMod 1 "IShatter"
							stretchMod = XForm name:"IS_Stretch"
							fnSetAppData stretchMod 1 "IShatter"
							
							select oMVoroObject
							
							modPanel.addModToSelection (materialIDMod) ui:on
							modPanel.addModToSelection (resetXFormMod) ui:on
							modPanel.addModToSelection (squashMod) ui:on	
							modPanel.addModToSelection (voroMod) ui:on
							modPanel.addModToSelection (stretchMod) ui:on
							fnCustomVoroFragCtrl()
							
							max create mode
							clearSelection()
						)
						
						-- if we use rayFire we can setPoints directly inside the modifier
						else 
						(							
							iMVoroIndex = 1
							oMVoroEngine = "RayFire"
							
							materialIDMod = Materialmodifier materialID:1 name:"IS_Material"
							fnSetAppData materialIDMod 1 "IShatter"
							resetXFormMod = XForm name:"IS_Reset"
							fnSetAppData resetXFormMod 1 "IShatter"
							voroMod = RayFire_Voronoi display_points:false pc_type:5 fragment:true matID:2 explode_delete:false explode_randomcolor:false explode_suffix:"_IShatter_" name:"IS_RayFire"
							fnSetAppData voroMod 1 "IShatter"
							
							select oMVoroObject
							
							modPanel.addModToSelection (materialIDMod) ui:on
							modPanel.addModToSelection (resetXFormMod) ui:on
							modPanel.addModToSelection (voroMod) ui:on
							
							max create mode
							clearSelection()
						)
						
						-- add selected voronoi modifier and a custom attribute to store voronoi points						
						fnCustomVoroCtrl()					
					)
					
					-- a previous engine is found on this object (means we continue a previous fragmentation)
					else 
					(
						fnCheckForValidEngine &bFoundValid -- in case user converted object to an editable poly (there's no more voronoi modifier)
						if not bFoundValid do
						(
							pb_Track.enabled = btn_Shatter.enabled = true
							dd_Engine.enabled = true ; dd_Engine.selection = 1 ; dd_Method.selection = 1
							hl_Loop.visible = false ; sp_Loop.visible = false ; sp_Ring.visible = false 
							hl_Iter.visible = true ; sp_Iter.visible = true ; sp_Iter.value = 50
							rb_Axis.state = 3 ; sp_Stretch.value = 0.0
							chk_BorderEdges.state = false							
							
							pb_Track.text =  " <<  Select an Object  >>"
							oMVoroObject = undefined
							
							return undefined							
						)
						
						if oMVoroEngine == "VoroFrag" do 
						(
							oMVoroObject.modifiers[iMVoroIndex].useNormals = true 
							oMVoroObject.modifiers[iMVoroIndex].selInFaces = false
							
							oVoroPFlow = oMVoroObject.modifiers[iMVoroIndex].pickPFlow
							oVoroEvent = oVoroPFlow.getInitialActionList 1								
							
							particleFlow.BeginEdit()
							particleFlow.delete (oVoroEvent.getAction 2)
							particleFlow.EndEdit()							

							fnSelect oMVoroObject
							max modify mode ; max create mode
							clearSelection()
						)
						
						oMVoroObject.modifiers[iMVoroIndex].enabled = false
						aMVoroCoords = for c in oMVoroObject.modifiers[iMVoroIndex].iShatterSeeds collect c						
						
						oMTrack = fnConvertToPoly (fnSnapshot oMVoroObject)
						oMTrack.name = "IS_Track"
						fnHide oMTrack
						
						oMVoroObject.modifiers[iMVoroIndex].enabled = true					
					)
					
					-- If we want to display all the edges or only the borders
					bMShowBorder = chk_BorderEdges.state
					if bMShowBorder then fnShowBorderEdges() else fnShowAllEdges()							
					fnHide oMVoroObject					
					
					-- when we know which voro engine we will use, we can start the fragmentation process
					iMNumPts = sp_Iter.value ; iMNumLoops = sp_Loop.value ; iMNumRings = sp_Ring.value ; iMTwist = sp_Offset.value				
					iMStretchAxis = rb_Axis.state ; fMStretch = sp_Stretch.value
					iMVoroMethod = dd_Method.selection
					bMCanBreak = true ; bMDraged = false ; bMEscape = false
					fnSetViewOptionsForIShatter()					
					
					-- create all necessary data for IShatter
					fnCalculateVolume &fVolume
					if fVolume > 0.0 then iLocation = 4 else iLocation = 3					
					fnPFSeeds &iLocation		
					
					fnCreateIShatterHelper()
					fnRayMeshGrid()									
					
					-- launch IShatter mouse track tool
					max create mode
					clearSelection() ; clearListener() ; gc()
					
					with undo off 
					(
						mouseTrack trackCallback:fnIShatterMouseTrack
					)					
					
					-- clear all unecessary data
					fnClearRayMeshGrid()					
					fnErasePFSeeds()
					aMGrid = undefined
					
					unRegisterRedrawViewsCallback fnRegisterScreenInfos					
					fnClearIShatterData()					

					pb_Track.enabled = btn_Shatter.enabled = true
					chk_BorderEdges.state = false
					dd_Engine.enabled = false
				)				
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  when we open the rollout
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on IS_IShatter_Roll open do
			(				
				sliderTime = 0
				fnRemoveUnusedPFlow()
				
				-- Check for installed/loaded voronoi plugins
				aVoroEngines = #()
				if fnFindItem modifier.classes VoroFrag > 0 do fnAppend aVoroEngines "VoroFrag"
				if fnFindItem modifier.classes RayFire_Voronoi > 0 do fnAppend aVoroEngines "RayFire"
				
				if aVoroEngines.count > 0 then
				(					
					dd_Engine.items = aVoroEngines
					
					-- Create IShatter materials
					if IShatterObjects == undefined do IShatterObjects = #()
					fnObjWithVoroFragMod()
					
					if IShatterVoroMat == undefined do IShatterVoroMat = standard selfIllumAmount:12 name:(fnUniqueName "IS_VoroMaterial_")					
					if IShatterHelperMat == undefined do IShatterHelperMat = StandardMaterial shaderType:1 Diffuse:(color 0 255 0) twoSided:false useSelfIllumColor:false selfIllumAmount:100 opacity:20 specularLevel:0 glossiness:0
				)
				else -- if there is no voronoi engine then ask to users if they want to download VoroFrag. If "Yes" then start the download process.
				(
					try (destroyDialog IS_IShatter_Roll) catch()
					if queryBox "Please install a Voronoi engine first ! \n \t Download VoroFrag ?" title:"IShatter Warning" then
					(	
						pushPrompt "Please wait... currently downloading VoroFrag plugin"
						
						url = "http://www.scriptspot.com/files/vorofrag_v2.5a_0.zip"
						localDir = getFilenamePath (getThisScriptFilename())
						localFile = localDir + "vorofrag_v2.5a_0.zip"
						plugsDir = (getDir #maxroot) + "stdplugs"
						
						wc = dotNetObject "System.Net.WebClient"
						wc.downloadFile url localFile
						wc.dispose()
						
						pushPrompt "Download complete !"	
						
						shellLaunch plugsDir " "	
						shellLaunch localDir " "		
					)					
				)								
			)
			
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			--  when we close the rollout
			-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
			on IS_IShatter_Roll close do
			(			
				fnRemoveUnusedPFlow()
				deleteAllChangeHandlers id:#trackDeletion
				gc() ; clearUndoBuffer() ;	freescenebitmaps()				
			)
		)
	)
	
	createDialog IS_IShatter_Roll 190 355
)

-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --		
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- 																													IS - IShatter End Script
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --
-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// --