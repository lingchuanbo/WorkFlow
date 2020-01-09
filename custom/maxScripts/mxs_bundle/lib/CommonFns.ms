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
E-mail: gftvfx@gmail.com
Company: GTVFX
__END__
***************************************************************************************************/

/*
__HELP__

Constructor: CommonFns
Instantiated Global: CommonFns

[METHODS]

[DESCRIPTION]

[USAGE]

__END__
*/


mxs.Using "HashTableMethods"


struct CommonFns
(
public
    
--( INI settings
    
    fn SetIniFromDic iniFile headerStr dic =
    (
        local keyArr = ::_hash.GetDicKeys dic
        
        for item in keyArr do
        (
            SetIniSetting iniFile headerStr item dic.item[item]
        )
    ),
    
    fn DicFromIniHeader iniFile headerStr =
    (
        if ( iniFile == undefined ) or not ( DoesFileExist iniFile ) then
        (
            format "***** iniFile does not exist: % *****\n" iniFile
            return undefined
        )
        
        if not ( HasIniSetting iniFile headerStr ) then
        (
            format "***** iniFile does not a header that matches: % *****\n" headerStr
            return undefined
        )
        
        local keyArr = GetIniSetting iniFile headerStr
        
        local dic = dotNetObject "System.Collections.Hashtable"
        
        for item in keyArr do
        (
            dic.Add item ( GetIniSetting iniFile headerStr item )
        )
        
        dic
    ),
	
	fn MakeAlembicExportIni =
	(
		local abcIni = ( GetDir #plugcfg ) + "\\AlembicExport.ini"
		
		if not ( DoesFileExist abcIni ) then
		(
			SetIniSetting abcIni "General" "CoordinateSystem" 1
			SetIniSetting abcIni "General" "ArchiveType" 1
			SetIniSetting abcIni "General" "ParticleAsMesh" 0
			SetIniSetting abcIni "General" "CacheTimeRange" 0
			SetIniSetting abcIni "General" "StepFrameTime" 1.000000
			SetIniSetting abcIni "General" "StartFrameTime" 1001
			SetIniSetting abcIni "General" "EndFrameTime" 1200
			SetIniSetting abcIni "General" "ShapeName" 1
			
			format "***** Alembic Export INI created *****\n"
		)
		else
		(
			format "***** Alembic Export INI Exists *****\n"
		)
	),
    
--)
	
--( File Operations
	
	fn TransferFiles _fromDir: _toDir: fileArr:#all deleteAfter:False =
	(
		if _toDir == unsupplied then return ( messageBox "TransferFiles requires you to supply a valid directory to transfer files: use the _toDir arg" title:"Missing args:" )
		if not ( DoesFileExist _toDir ) then return ( messageBox "The _toDir arg supplied to TransferFiles does not exist" title:"Invalid Directory:" )
		if fileArr == #all and _fromDir == unsupplied then return ( messageBox "TransferFiles requires you to supply a valid directory to collect files to transfer: use the _fromDir arg" title:"Missing args:" )
		
		
		if fileArr == #all then
		(
			fileArr = GetFiles ( _fromDir + "/*" )
		)
		else
		(
			local arr = #()
            
			for i in fileArr do
			(
				if not ( DoesFileExist i ) then
				(
					format "***** File does not exist: % *****\n" i
					append arr i
				)
			)
			
			for i in arr do
			(
				DeleteItem fileArr ( FindItem fileArr i )
			)
		)
		
		if fileArr.count != 0 then
		(
			for file in fileArr do
			(
				local copyFileName = ( pathConfig.NormalizePath ( _toDir + "\\" + ( FileNameFromPath file ) ) )
				format "***** Copying % to % *****\n" file copyFileName
				CopyFile file copyFileName
			)
		)
		
		if deleteAfter then
		(
			for i in fileArr do
			(
				DeleteFile i
			)
		)
        
		format "***** % files transfered *****\n" fileArr.count
	),
	
	fn CopyMaxFilePathToClipboard =
	(
		SetClipBoardText ( maxFilePath + maxFileName )
	),
	
	fn OpenMaxFileLocation =
	(
		ShellLaunch "explorer" maxfilepath 
	),
	
	fn OpenRenderLocation =
	(
		if DoesFileExist ( GetFilenamePath rendOutputFilename ) then ShellLaunch "explorer" ( GetFilenamePath rendOutputFilename ) else messageBox "Unable to access render path directory." title:"Error:"
	),
	
	fn OpenTempDir =
	(
		ShellLaunch "explorer" ( GetDir #temp )
	),

	fn GetLatestFile filePath ext pattern:"" = 
	(			
		local fileList = (getfiles (filePath + "\\*." + ext))
		local assumedLatestFile = ""
		local latestWriteTime = 0L
        
		for newFile in fileList do 
		(
			if matchPattern newFile pattern:("*" + pattern + "*" ) then 
			(
				local FileInfo = dotNetObject "System.IO.FileInfo" newFile
				if FileInfo != undefined then 
				(
					local fileTime = FileInfo.LastWriteTime.Ticks
					if fileTime > latestWriteTime then 
					(
						assumedLatestFile = newFile
						latestWriteTime = FileInfo.LastWriteTime.Ticks
					)
				)
			)
		)
		assumedLatestFile
	),
	
--) End File Operations
	
--( System Helpers
	
	fn SetHeapSize mem =
	( -- 200000000
		if HeapSize < mem then HeapSize = (mem as integer)
	),
    
    fn IncreaseHeapSize _increment =
    (
        HeapSize += _increment
    ),
	
	fn GetScreenResolution displayIndex:1 =
	(
		/* 
		Get the screen resolution to determine the width of the toolbar
                */
        
        local scr = undefined
        
        if displayIndex == 1 then
        (
            scr = ( DotNetClass "System.Windows.Forms.Screen" ).PrimaryScreen.Bounds
        )
        else
        (
            scr = ( DotNetClass "System.Windows.Forms.Screen" ).AllScreens[displayIndex]
            
            if ( scr != undefined ) then
            (
                scr = scr.Bounds
            )
            else
            (
                format "***** This is now screen at index: % *****\n" displayIndex
                return undefined
            )
        )
		
		[scr.Width, scr.Height]
	),
	
--)

--( Hierarchies
	
	mapped fn SetParent_mapped objArr obj _replace:False =
	(
		/* 
		Set the parent of each object in objArr to obj
		
		using the _replace argument will flatten the hierarchy of objArr and directly parent
		each object to obj
		 */
		if _replace then
		(
			objArr.parent = obj
		)
		else
		(
			if objArr.parent == undefined then objArr.parent = obj
		)
	),
	
	fn Set_Parent objArr obj _replace:False =
	(
		/* 
		Set the parent of each object in objArr to obj
		
		using the _replace argument will flatten the hierarchy of objArr and directly parent
		each object to obj
		
		This method wraps the mapped function so that we can also perform an unmapped operation
		to see if any of the objects in the provided array have a parent outside of the selection.
		 */
		
		if not _replace then
		(
			for i in objArr where i.parent != undefined and (finditem objArr i.parent) == 0 do i.parent = obj
		)
		
		this.SetParent_mapped objArr obj _replace:_replace 
	),
	
	mapped fn RemoveParent_mapped objArr =
	(
		/* 
		Sets the parent of each object in the supplied array to 'undefined'
                */
		
		objArr.parent = undefined
	),
	
	fn GetTopLevelParent obj =
	(
		/* 
		Recursses up through the objects hierarchy and returns the top-most object
                */
		
		if not (IsValidNode obj) then
		(
			throw ( "GetTopLevelParent() expected a valid object node.\n-- Got: " + ( obj as string ) )
		)
		
		if obj.parent != undefined then
		(
			obj = GetTopLevelParent obj.parent
		)
        
		obj
	),
	
	fn GetParentsRecursive obj arr:#() skipNamePattern: skipClass: skipSuperClass: =
	(
		/* 
		recurses upstream through a node's hierarchy collecting all nodes above obj
		 */
        
        -- A boolean that will exit the recurse if set to true
		local skipCase = False
        
		if obj.parent != undefined then
		(
			if ( FindItem arr obj.parent ) == 0 then
			(
                if ( skipNamePattern != unsupplied ) and ( ClassOf skipNamePattern == String ) then
				(
					exitCase = ( MatchPattern obj.parent.name pattern:skipNamePattern )
				)
				
				if ( skipClass != unsupplied ) and ( skipClass != undefined ) then
				(
					exitCase = ( ( ClassOf obj.parent ) == skipClass )
				)
				
				if ( skipSuperClass != unsupplied ) and ( skipSuperClass != undefined ) then
				(
					exitCase = ( ( SuperClassOf obj.parent ) == skipSuperClass )
				)
                
				if not skipCase then
				(
					append arr obj.parent
					
					this.GetParentsRecursive obj.parent arr:arr skipNamePattern:skipNamePattern skipClass:skipClass skipSuperClass:skipSuperClass
				)
			)
			
		)
		arr
	),
	
	fn GetChildrenRecursive obj arr:#() skipNamePattern: skipClassArr: skipSuperClassArr: debug:False =
	(
		/* 
		recurses downstream through a node's hierarchy collecting all nodes below obj
                */
		
		-- ensure that these arguments are array values
		if ( skipClassArr != unsupplied ) then skipClassArr = ::_ilmLibrary.EnsureArgIsArray skipClassArr
		if ( skipSuperClassArr != unsupplied ) then skipSuperClassArr = ::_ilmLibrary.EnsureArgIsArray skipSuperClassArr
		
		
		fn GetSkipCaseFromSkipPattern obj pattern =
		( -- This imbedded function allows us to match against either a single name pattern or an array of name patterns
			local out = False
			
			if ( ClassOf pattern == String ) then
			(
				return ( MatchPattern obj.name pattern:pattern )
			)
			else if ( ClassOf pattern == Array ) then
			(
				for each in pattern do
				(
					if ( MatchPattern obj.name pattern:each ) then
					(
						return True
					)
				)
			)
			
			out
		)
		
		
		if obj.children.count != 0 then
		(
			if debug then format "***** Evaluating children: % *****\n" obj.children
			
			for c in obj.children do
			(
				local skipCase = False -- A boolean that will exit the recurse if set to true
				
				if debug then format "***** Child: % *****\n" c
				
				if ( skipNamePattern != unsupplied ) then
				(
					if debug then format "***** Testing for skipNamePattern: % *****\n" skipNamePattern
						
					skipCase = ( GetSkipCaseFromSkipPattern c skipNamePattern )
					
					if debug then format "***** skipCase: % *****\n" skipCase
				)
				
				if not skipCase and ( skipClassArr != unsupplied ) and ( skipClassArr != undefined ) then
				(
					if debug then format "***** Testing for skpClass: % *****\n" skipClassArr
						
					skipCase = ( FindItem skipClassArr ( ClassOf c ) != 0 )
					
					if debug then format "***** skipCase: % *****\n" skipCase
				)
				
				if not skipCase and ( skipSuperClassArr != unsupplied ) and ( skipSuperClassArr != undefined ) then
				(
					if debug then format "***** Testing for skipSuperClassArr: % *****\n" skipSuperClassArr
						
					skipCase = ( FindItem skipSuperClassArr ( skipSuperClassArr c ) != 0 )
					
					if debug then format "***** skipCase: % *****\n" skipCase
				)
				
				if not skipCase then
				(
					append arr c
					this.GetChildrenRecursive c arr:arr skipNamePattern:skipNamePattern skipClassArr:skipClassArr skipSuperClassArr:skipSuperClassArr
				)
			)
		)
        
		arr
	),
	
	fn GetNodeHierarchyTree obj =
	(
		/* 
		Collects all parents and children and return a combined arr including the obj
		 */
		local parentArr = this.GetParentsRecursive obj
		local childArr = this.GetChildrenRecursive obj
		
		( parentArr + childArr + obj )
	),
	
	fn GetNodeHierarchyAsPath obj fromWorld:True =
	(
		/* 
		- Concotenates a path to the object through it's hierarch
		- Used for the Alembic export and Material collection
		 */
        
		if ( IsValidNode obj ) then
		(
			local str = stringstream ""
			
			local worldRoot = ""
			
			if fromWorld then
			(
				worldRoot = "/root/world/geo/"
			)
            
			format "%" worldRoot to:str
            
			local parentArr = #()
            
			this.GetParentsRecursive obj arr:parentArr
            
			for i = parentArr.count to 1 by -1 do format "%/" parentArr[i].name to:str
                
			format "%" obj.name to:str
            
			( str as string )
		)
		else
		(
			undefined
		)
	),

    
    -- Not sure who wrote this or where it's being used. ( gthompson )
	fn ConvertStrArrToNodeArr theStringArr parentObjName = 
	(
		local tmpArrStr = execute( theStringArr )
		local tmpArrNode = #()
        
		for objName in tmpArrStr do 
		(
			try
			(
				local objSel = GetNodeByName objName all:True
				for obj in objSel where ( this.GetTopLevelParent obj ).name == parentObjName do append tmpArrNode obj
			)
			catch()
		)
        
		tmpArrNode
	),
	
--) END: Hierarchies
	
--( Layers
	
	mapped fn AddObjectsToLayer_mapped objArr layer =
	(
		layer.addNode objArr
	),
    
    fn GetLayerFromName layerName makeNew:False =
    (
        local layer = undefined
        
        if LayerManager.getLayerFromName layerName == undefined and makeNew then
        (
            layer = layermanager.newLayerFromName layerName
        )
        else
        (
            layer = LayerManager.getLayerFromName layerName
        )
        
        layer
    ),
    
    fn StoreObjectLayerRelationship objArr =
    (
        /* 
                Returns a dictionary formated as:
                Key = LayerName
                Value = Array of object names
                */
        
        local dic = dotNetObject "System.Collections.Hashtable"
        
        local layerNameArr = for i in objArr collect i.layer.name
        layerNameArr = MakeUniqueArray layerNameArr
        
        for layerName in layerNameArr do
        (
            local layer = LayerManager.getLayerFromName layerName
            local layerNodes = #()
            layer.nodes &layerNodes
            
            local layerObjNames = for obj in layerNodes collect obj.name
            layerObjNames = MakeUniqueArray layerObjNames
            
            dic.add layerName layerObjNames
        )
        
        dic
    ),
    
    fn RestoreObjectLayerRelationship objArr dic =
    (
        /* 
                Takes the dictionary from StoreObjectLayerRelationship()
                Creates layers if necessary
                Collects objects by name and sets their layer based on the dictionary key/value pairing
                */
        
        local layerNameArr = this.GetHashtableKeys dic
        
        for layerName in layerNameArr do
        (
            local layer = this.GetLayerFromName layerName makeNew:True
            
            for objName in dic.item[layerName] do
            (
                local nodeArr = ( GetNodeByName objName all:True )
                
                for n in nodeArr where ( FindItem objArr n ) != 0 do
                (
                    this.AddObjectsToLayer_mapped nodeArr layer
                )
            )
        )
    ),
	
	
--) END: Layers
	
--( Materials
	
	fn ApplyGreyMat objArr =
	(
		greyMat = (Standard name:"default" diffuse:(color 128 128 128))
		for i in objArr do i.material = greyMat
		True
	),
	
	fn HasMultipleMats objArr =
	(
		/* 
		Collects the material from the first object in the supplied array and then
		tests against the materials of every other object in the array.
		
		returns True if there is more than the one material used
		returns False if all of the objects share the same material
		 */
		testMat = objArr[1].material
		for i in objArr do
		(
			if i.material != testMat then return True
		)
		False
	),
	
	fn HasMultiMatte objArr =
	(
		/* 
		Test each object in the supplied array to see if its' material is a MultiMaterial
		 */
		arr = for i in objArr where classof i.material == MultiMaterial collect i
		if arr.count == 0 then False else True
	),
	
	fn CollectObjectsByMaterial objArr mat =
	(
		/* 
		Filters through the objects in objArr to find only the objects with mat applied
		 */
		arr = for i in objArr where i.material == mat collect i
		arr
	),
	
	fn ExportMatLib matArr exportPath =
	(
		/* 
		Creates a material library from matarr and exports it to exportPath
		 */
		if matArr.count != 0 then
		(
			local matLib = materialLibrary()
			for i in matArr where i != undefined do append matLib i
			if ( DoesFileExist ( GetFileNamePath exportPath ) ) == true then
			(
				SaveTempMaterialLibrary matLib exportPath
			)
		)
	),
	
	fn CollectMaterials objArr =
	(
		/* 
		Collect all materials applied to the objects in the objArr
		 */
		arr = #()
		for i in objArr where i.material != undefined do
		(
			AppendIfUnique arr i.material
		)
		arr
	),
    
    fn GetFinalMapLoader mapLoader =
    (
        /* 
                Recurse down a branch of the shader tree to find maploader at the base
                */
        local numSubTexmaps = (GetNumSubTexmaps mapLoader)
            
        if numSubTexmaps != 0 then
        (
            tMap = (GetSubTexmap mapLoader 1)
            if ( GetNumSubTexmaps tMap ) != 0 then
            (
                GetFinalMapLoader tMap
            )
            
            return tMap
        )
        
        mapLoader
    ),
	
--) END: Materials
    
--( Map Methods
  
    fn GetFileFromMapLoader mapLoader = 
    (
        out = undefined
        
        case ( ClassOf mapLoader ) of
        (
            ( VRayHdri ):
            (
                out = mapLoader.HdriMapName
            )
            ( BitmapTexture ):
            (
                out = mapLoader.Filename
            )
        )
        
        out
    ),    

--)
	
--( Mesh operations
    
    fn ConvertBaseObject obj type:#mesh =
    (
        local typeMod = case type of
        (
            ( #mesh ):( Mesh_Select() )
            ( #poly ):( Edit_Poly() )
        )
        
        if ( ValidModifier obj typeMod ) then
        (
             addmodifier obj typeMod before:obj.modifiers.count
            maxOps.CollapseNodeTo obj obj.modifiers.count off
        )
        else
        (
            format "***** % cannot be applied to % *****\n" typeMod obj
        )
    ),
    
    fn HasPointCache objArr = 
	(
        objArr = ::mxs.EnsureArgIsArray objArr
        
		local out = False
        
        if objArr.count != 0 then
        (
            for obj in objArr do 
            (
                if ( GetClassInstances PointCache target:obj ).count != 0 then
                (
                    out = True
                    exit
                )
            )
        )
		
		out
	),
    
    fn GetMaximumFramRangeFromPointCacheMods objArr =
    (
        local pcArr = #()

        for obj in objArr do
        (
            local pcMods = ( GetClassInstances PointCache target:obj )
            
            if pcMods.count != 0 then
            (
                pcArr += pcMods
            )
        )
        
        local startTimeArr = #()
        local endTimeArr = #()
        
        for pcMod in pcArr do
        (
            local startTime = undefined
            local endTime = undefined
            
            case pcMod.playbackType of
            (
                ( 0 ): -- Original Range
                (
                    startTime = pcMod.recordStart
                    endTime = pcMod.recordEnd
                )
                ( 1 ): -- Custom Start
                (
                    startTime = pcMod.playbackStart
                    endTime = ( pcMod.playbackStart + pcMod.recordEnd )
                )
                ( 2 ): -- Custom Range
                (
                    startTime = pcMod.playbackStart
                    endTime = pcMod.playbackEnd
                )
                ( 3 ): -- Playback Graph
                (
                    startTime = animationRange.Start
                    endTime = animationRange.End
                )
            )
            
            append startTimeArr startTime
            append endTimeArr endTime
        )
        
        #( ( amin startTimeArr ), ( amax endTimeArr ) )
    ),
    
    fn DeleteAll =
    (
        SetCommandPanelTaskMode #create
        ::mxs.BlockUi True
        delete $*
        ::mxs.BlockUi False
    ),
	
	fn GetLocalizedBasePoint objArr =
	(
		/* 
		Retuns a Point3 value representing the worlspace coordinate at the X and Y center of the objects and the minimum Z coordinate.
		 */
		local out
		
		if classof objArr != ObjectSet then
		(
			ClearSelection()
			Select objArr
		)
		
		local minPoint = selection.min
		local maxPoint = selection.max
		
		out = [(minPoint.x + ((maxPoint.x - minPoint.x)/2)),(minPoint.y + ((maxPoint.y - minPoint.y)/2)),minPoint.z]
	),
	
	mapped fn AutoProOptimize objArr perc:25 optArr:#() =
	(
		/* 
		Creates a ProOptimize Mod on every object in objArr and sets the vertexPercent to perc
		
		optArr needs to be fed an empty array assigned to a variable
		This function varifies each object in objArr is valid for the ProOptimzer mod and appends all valid objects to optArr
		*/
		
		SetCommandPanelTaskMode #create
		
		if ValidModifier objArr (ProOptimizer()) and SuperClassOf objArr == GeometryClass then
		(
			if objArr.modifiers[#Auto_ProOptimizer] == undefined then
			(
				AddModifier objArr (ProOptimizer name:#Auto_ProOptimizer vertexPercent:perc)
			)
			append optArr objArr
		)
		--else format "***** % is not a valid object for ProOptimizer *****\n" objArr.name
	),
	
	mapped fn CalculateProOptModifiers classArr =
	(
		/* 
		Setting the calculate property has to be done after the object has been re-evaluated. 
		That's why this is in a function by itself
		*/
		classArr.calculate = True
	),
	
	fn AlignPivotToObject sourceObj targetObj = 
	(
		/* 
		Aligning pivots in Max is tricking, esecially if trying to maintain a clean transform and object offset
		
		This method stores the world position of each vertex of the sourceObj
		It then sets the sourceObj transform to the targetObj transfrom (This aligns the pivot)
		Then it goes through and moves each vertex back to their stored transform
		 */
		if CanConvertTo sourceObj Editable_Poly then 
		(
			if classof sourceObj != Editable_Poly then convertToPoly sourceObj
			
			local vertsPosArr = For i = 1 to ( polyOp.getNumverts sourceObj ) collect ( polyOP.getvert sourceObj i )
			
			sourceObj.transform = targetObj.transform
			
			for i = 1 to vertsPosArr.count do polyOP.setvert sourceObj i vertsPosArr[i]
				
			ConvertToMesh sourceObj
		)
	),
	
	fn AttachObjs objArr garbageCollect:false =
	(
		/* 
		- Attaches all geo objects in objArr into a single mesh
		- Creates a single MultiMat for the resultant obj
		
		- Returns the collapsed object
		 */
		if objArr.count < 2 then
		(
			messagebox "Must have at least 2 objects selected!"
		)
		else
		(
			with undo off
			(
				with redraw off
				(
					local nonGeoArr = for i in objArr where superClassOf i != GeometryClass or classof i == TargetObject collect i
					for i in nonGeoArr do
					(
						deleteItem objArr (findItem objArr i)
					)							
					while objArr.count > 1 do
					(	
						for i = objArr.count to 2 by -2 do 
						(
							InstanceMgr.MakeObjectsUnique #(objArr[i], objArr[i-1]) #individual
							case (classOf objArr[i]) of
							(
								(Editable_Poly):
								(
									polyOp.attach objArr[i] objArr[i-1]
								)
								(PolymeshObject):
								(
									polyOp.attach objArr[i] objArr[i-1]
								)
								(Editable_Mesh):
								(
									attach objArr[i] objArr[i-1]
								)
								default:
								(
									if (classOf objArr[i]) != Editable_Mesh then convertToMesh objArr[i]
									attach objArr[i] objArr[i-1]
								)
							)
							deleteItem objArr (i-1)
							if garbageCollect then gc()
						)
					)
					if (classOf objArr[1]) != Editable_Mesh then convertToMesh objArr[1]
					objArr[1]
				)
			)
		)
	),
	
	fn CondenseObjects objArr tolerance:1000 =
	(
		/* 
		- tolerance is the number of objects to collapse together
		
		 */
		format "***** Condensing Objects *****\n"
		
		local newObjArr = #()
		
		while objArr.count != 0 do
		(
			local subArr = #()
			
			for i = 1 to ( tolerance as integer ) do
			(
				if objArr[i] == undefined then exit
				append subArr objArr[i]
				deleteItem objArr i
			)
			
			if subArr.count > 1 then
			(
				local newObj = this.AttachObjs subArr
				append newObjArr newObj
			)
			else
			(
				newObjArr += subArr
			)
		)
		
		newObjArr
	),
	
	mapped fn CollapseModifierStack objArr =
	(
		/* 
		Collapses the whole modifier stack
		*/
		
		with undo off
		(
			maxOps.CollapseNode objArr True
		)
	),
	
	
--) END: Mesh operations
	
--( Export Helper Methods
	
	fn SaveCheck =
	(
		/* 
		Presents a Yes/No/Cancel box asking if the user would like to save the file.
		
		If #yes then we run the SaveIncrement tool from the Library.
		Options #yes and #no return True
		#cancel returns false allowing us to escape the operation
		 */
		test = YesNoCancelBox "!!!-- Any work since your last save will be lost --!!!\n\nWould you like to save the file before continuing?" title:"Save Check:"
		case test of
		(
			#yes:mxs.RunTool "SaveIncrement"
			#cancel: return False
		)
		True
	),
	
	mapped fn SetRenderByLayer objArr state:True =
	(
		/* 
		Meant to be run on each assetnull's AssetObjects
		This sets all objects to the RenderByLayer state that the tool RenderLayers requires
		 */
		objarr.renderByLayer = state
	),
    
    fn StripRenderPaths =
    (
		local elmntMgr = maxOps.GetCurRenderElementMgr() 
		local numElements = elmntMgr.NumRenderElements()
        
		for i = 0 to ( numElements - 1 ) do
		(
			if elmntMgr.GetRenderElementFilename i != undefined then
			(
				elmntMgr.SetRenderElementFilename i ""
			)
			else exit
		)
        
		rendOutputFilename = ""
		try( renderers.current.output_rawFileName = "" )catch() -- Clears the VRay Frame Buffer if using VRay
    ),
	
	fn RemoveRenderElements =
	(
		/* 
		- Removes all render elements
		- The material collection export sees render elements as texture paths so we remove these to avoid that confusion
		 */
		( maxOps.GetCurRenderElementMgr() ).removeallrenderelements()
		True
	),
	
	mapped fn ConvertToDummy_mapped objArr =
	(
		/* 
		- Converts all helper objects to Dummy helpers
		- Simplifying the objects helps the Alembic export
		 */
		if SuperClassOf objArr == Helper and ClassOf objArr != Dummy then
		(
			local repDummy = (Dummy name:objArr.name)
			
			repDummy.scale.controller = (ScaleXYZ())
			if ClassOf objArr.scale.controller != ScaleXYZ then objArr.scale.controller = (ScaleXYZ())
				
			try
			(
				replaceInstances objArr repDummy
			)
			catch
			(
				objArr.baseObject = repDummy
			)
			
			try(delete repDummy)catch()
		)
    ),
	
	fn CleanSaveNodes objArr fpath =
	(
		/* 
		The SaveNodes method in Max keeps a lot of unrelated garbage data in the scene. (Layers, metadata references, etc...)
		
		This method does a SaveNodes and then does a HoldMaxFile while it does a reset and merges the new objects into a fresh
		scene (This gets rid of all the garbage data). It then saves this clean file to the suppled fpath and then Fetches the file back.
		 */
		local tempDir = ( GetDir #temp )
		local tempFile
        
		if ( DoesFileExist tempDir ) then
		(
			format "***** Cleaning Exported Scene *****\n"
			with redraw off
			(
                HoldMaxFile()
                
				objArr = for i in objArr where not isDeleted i collect i
				
				tempFile = ( tempDir + @"\cleansavenodes.max" )
                
				SaveNodes objArr tempFile quiet:True
				
				ResetMaxFile #noPrompt
				Try( Delete ( objects as array ) )Catch()
				
				if ( animationRange.start == 0 ) then
				(
					animationRange = ( interval 1f animationRange.End )
				)
				
				MergeMaxFile tempFile #noRedraw quiet:True
				SaveMaxFile fpath useNewFile:False quiet:True
                
				DeleteFile tempFile
                
                --format "***** Fetching Max File *****\n"
				FetchMaxFile quiet:True
                --format "***** MaxFilename: % *****\n" MaxFilename
			)
		)
		else
		(
			Throw "Unable to access temp directory"
		)
	),
    
    fn GetFaceCount objArr =
    (
        local numFaces = 0
        
		for obj in objArr do
		(
			if ( ClassOf obj != TargetObject ) and ( IsProperty obj #mesh ) then
			(
				numFaces += ( GetNumFaces obj.mesh )
			)
		)
        
		numFaces 
    ),
	
	fn ExportVrmesh objArr pName exportDir:unsupplied parent:undefined customMesh:undefined animation:False =
	(
		/* 
		- Attaches all objects in objArr to a single mesh and exports a vrmesh of that object
		- If separate "topnulls" exist within the objArr hierarchy then this function is run on the children of each topnull separately
		- Otherwise this is run on the whole objArr
		 */
		
		if exportDir == unsupplied or not (DoesFileExist exportDir) then
		(
			throw "ExportVrmesh() expects an existing directory for 'exportDir'"
		)
		
        -- The VrayMeshExport method assumes instanced objects share the same material so here we just kill all instancing to avoid wrong material assignments
        InstanceMgr.MakeObjectsUnique objArr #individual
        
		-- The VrayMeshExport method is limited in the number of objects it's able to export, so this CondenseObjects method is used to
		-- reduce the object count prior to export.        
		if objArr.count > 7000 then objArr = this.CondenseObjects objArr tolerance:1000
		
		local numFaces = this.GetFaceCount objArr
        
		-- This is a sort of logic for optimizing the face count display of the proxy object
		if numFaces < 10000 then numFaces = numFaces/3
		while numFaces > 50000 do numFaces = numFaces/2
		if numFaces > 30000 then numFaces = 30000
        if animation and numFaces > 10000 then numFaces = 10000
		
		local meshFilePath = (exportDir + pName + ".vrmesh")
		local matLibPath = (substituteString meshFilePath ".vrmesh" ".mat")

		format "***** VRProxy ObjArr: % *****\n" objArr
		if customMesh == undefined then customMesh = unsupplied
            
        local animStart = animationRange.Start
        local animEnd = animationRange.Start -- purposely set to the start frame
            
        if animation then
        (
            format "***** VRay Mesh Export With Animation *****\n"
            
            local timeRange = this.GetMaximumFramRangeFromPointCacheMods objArr
            
            animStart = ( timeRange[1] - 5f )
            animEnd = ( timeRange[2] + 5f )
            
            animationRange = ( interval animStart animEnd )
            
            format "***** animStart: % | animEnd: % *****\n" animStart animEnd
        )
        
        
		local vProxy = ( VrayMeshExport meshFile:meshFilePath autoCreateProxies:True exportMultiple:False \
                                        animation:animation animationRange:#explicit animationStart:animStart animationEnd:animEnd \
                                        animationRedrawViews:False maxPreviewFaces:numFaces previewMesh:customMesh \
                                        nodes:objArr proxyName:"test_name" createMultiMtl:True condenseMultiMtl:True \
                                        facesPerVoxel:20000 oneVoxelPerMesh:False exportPointClouds:True pointSize:2.0 )[1]
		
		vProxy.parent = parent
		vProxy.name = pName
		vProxy.material.name = pName
		vProxy.force_first_map_channel = False
		
		-- export a matlib of the material applied to the VRayProxy object
		this.ExportMatLib #(vProxy.material) matLibPath
		
		vProxy
	),
	
	fn FormatNodeList nameArr =
    (
        local nodeStr = ""
            
        for i in nameArr do
        (
            nodeStr += i
            if i != nameArr[nameArr.count] then
            (
                nodeStr += ","
            )
        )
        
        nodeStr
    ),
    
    fn GetAlembicExportString _filename:unsupplied _exportSelected:False _in:1 
		_out:1 _step:1 _subStep:1 _particleSystemToMeshConversion:True _automaticinstancing:True 
		_facesets:"partitioningFacesetsOnly" _purePointCache:False _normals:True _uvs:True 
		_materialIDs:True _flattenHierarchy:False _transformCache:False _validateMeshTopology:False 
		_storageFormat:"ogawa" _objects:unsupplied =
	(
		/* 
		- This function formats a string of values used by the Alembic export function
		- The arugments expose all the values that can be supplied to the string
		 */
		local str = StringStream ""
		local xStr = ""
		-- filename
		if _filename == unsupplied then
		(
			messageBox "GetAlembicExportString expects the _filename argument to be supplied" title:"Args Missing:"
			return False
		)
		--
		format "filename=%;exportSelected=%;in=%;out=%;step=%;substep=%;particleSystemToMeshConversion=%;automaticinstancing=%;" _filename _exportSelected _in _out _step _subStep _particleSystemToMeshConversion _automaticinstancing to:str
		xStr += (str as string)
		-- facesets
		if _facesets != unsupplied then
		(
			str = StringStream ""
			format "facesets=%;" _facesets to:str
			xStr += (str as string)
		)
		--
		str = StringStream ""
		format "purePointCache=%;normals=%;uvs=%;materialIDs=%;flattenHierarchy=%;transformCache=%;validateMeshTopology=%;storageFormat=%" _purePointCache _normals _uvs _materialIDs _flattenHierarchy _transformCache _validateMeshTopology _storageFormat to:str
		xStr += (str as string)
		-- objects
		if _objects != unsupplied then
		(
            if ( _objects != unsupplied ) and ( ClassOf _objects == Array ) then
            (
                _objects = this.FormatNodeList _objects
            )
            
			str = StringStream ""
			format ";objects=%" _objects to:str
			xStr += (str as string)
		)
		xStr
	),
	
	fn Matrix_Yup_to_Zup Yup_Matrix = 
    (
        local out = Yup_Matrix * ( inverse (matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) ) --* mayaMatrix
        out
    ),
	
	fn Matrix_Zup_to_Yup Zup_Matrix =
	(
		local Yup_Identity_matrix = (matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0])
		--local out = Yup_Identity_matrix * Zup_Matrix * ( inverse Yup_Identity_matrix )
		local out = Zup_Matrix * (matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0])
		out
	),
	
	fn Matrix3_To_Matrix4 matrix =
	( 
		-- from NST module
		-- "M44d((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (279.034, 0.0, 0.0, 1.0))"
		
		-- from unflipped matrix3
		-- "M44d((1.0, 0.0, 0.0, 0.0), (0.0, 1.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0), (279.034, 0.0, 0.0, 1.0))"
		
		-- from flipped matrix3
		-- "M44d((1.0, 0.0, 0.0, 0.0), (0.0, 0.0, -1.0, 0.0), (0.0, 1.0, 0.0, 0.0), (279.034, 0.0, 0.0, 1.0))"
		
		local out = StringStream ""
		
		format "M44d((%, %, %, 0.0), (%, %, %, 0.0), (%, %, %, 0.0), (%, %, %, 1.0))" matrix[1].x matrix[1].y matrix[1].z matrix[2].x matrix[2].y matrix[2].z matrix[3].x matrix[3].y matrix[3].z matrix[4].x matrix[4].y matrix[4].z to:out 
		
		( out as string )
	),
	
	fn Matrix4_To_Matrix3 matrix4Str =
	(
		local str = SubstituteString matrix4Str "M44d" ""
		str = SubstituteString str " " ""
		str = SubstituteString str "(" ""
		str = SubstituteString str ")" ""
		
		p3Arr = FilterString str ","
		
		local out = StringStream ""
		
		format "(matrix3 [%, %, %] [%, %, %] [%, %, %] [%, %, %])" p3Arr[1] p3Arr[2] p3Arr[3] p3Arr[5] p3Arr[6] p3Arr[7] p3Arr[9] p3Arr[10] p3Arr[11] p3Arr[13] p3Arr[14] p3Arr[15] to:out 
		
		( execute ( out as string ) )
	),
	
--) END: Export Helper Methods
	
--( External File Methods
	
	fn DumpStringToFile str pPath =
	(
		/* 
		A simplified method to format a string into a text file
                */
		if ( DoesfileExist pPath ) then deletefile pPath
		local strm = openFile pPath mode:"w"
		format ( str as string ) to:strm
		close strm
	),
    
    fn TraverseUpDirectory basePath up:1 =
    (
        local out = basePath
        for i = 1 to up do
        (
            out = pathConfig.removePathLeaf out
        )
        
        out
    ),
    
    fn CacheIcon image iconPrefix:"" =
	(
        /* 
                    Copies the icon file to the local machine with a new prefix
                    deletes old files if they exist
                    
                    We do this because DotNet latches on to the icon files and does not allow us to update them as long as someone has them referenced
                    So you cannot delete or change icons if you leave them referenced from the server.
                */
        
        local cacheDir = ( GetDir #userIcons )
		local newPath = ( cacheDir + "\\" + iconPrefix + ( FileNameFromPath image ) )
        
		if ( DoesFileExist newPath ) then DeleteFile newPath
		CopyFile image newPath
        
		newPath
	),
	
--) END: External File Methods
    
--( Modifier Methods
    
    fn Mod_ViewportDisplay modClass enabled:False =
    (
        /* 
                Disables the modifiers effect in the viewport
                */
        
        local modArr = ( GetClassInstances modClass )
        
        for each in modArr do
        (
            each.enabledInViews = enabled
        )
    ),
    
    
--) END: Modifier Methods
    
--( Property Methods
	
	fn GetObjectPropDict obj =
	(
		local dict = dotNetObject "System.Collections.Hashtable"
		
		for prop in ( GetPropNames obj ) do
		(
			local propVal = ( GetProperty obj prop )
			
			case ( ClassOf propVal ) of
			(
				( ArrayParameter ):
				(
					dict.add ( prop as string ) ( ::_hash.MxsArrayToDotNetArray propVal )
				)
				default:
				(
					dict.add ( prop as string ) propVal
				)
			)
		)
		
		dict
	),
	
	fn GetNodeDataObject obj =
	(
		if ( not IsValidNode obj ) then
		(
			format "***** % is not a valid node *****\n" obj
			return undefined
		)
		
		struct NodeDataObject
		(
			obj,
			-------
			layer, pivot, transform, 
			minimum, maximum, center,
			name, baseobject, material,
			parent, children, mesh,
			displayByLayer, motionByLayer, renderByLayer,
			colorByLayer, globalIlluminationByLayer,
			isTarget, lookAt, target, targetDistance,
			isHidden, isNodeHidden, isHiddenInVpt,
			isFrozen, isNodeFrozen, isSelected,
			xray, boxMode, allEdges, vertexTicks,
			backFaceCull, showTrajectory, ignoreExtents,
			showFrozenInGray, wireColor, showLinks, showLinksOnly,
			showVertexColors, vertexColorType, vertexColorsShaded,
			isDependent, visibility, renderable,
			inheritVisibility, primaryVisibility, secondaryVisibility,
			receiveShadows, castShadows, applyAtmospherics, renderOccluded, gbufferChannel,
			imageMotionBlurMultiplier, motionBlurOn, motionBlurOnController, motionBlur,
			generatecaustics, rcvcaustics, generateGlobalIllum, rcvGlobalIllum,
			
			
		private
			
			fn __init__ =
			(
				for each in ( GetPropNames this ) do
				(
					if ( each == #obj ) then continue
					
					try
					(
						SetProperty this each ( GetProperty this.obj each )
					)
					catch
					(
						format "***** Could not SetProperty: ObjDataObject.% from % *****\n" each this.obj
					)
				)
			),
			
			init = __init__()
		)
		
		NodeDataObject obj
	),
	
	fn SetNodePropertiesFromDataObject obj dataObject skipPropArr:#() =
	(
		-- ensure that the values of the array are names instead of string so that we can accurately compare them to the prop names.
		if ( skipPropArr.count != 0 ) then skipPropArr = for item in skipPropArr collect ( item as name )
		
		for prop in ( GetPropNames dataObject ) where ( FindItem skipPropArr each == 0 ) do
		(
			try
			(
				SetProperty obj prop ( GetProperty dataObject prop )
			)
			catch
			(
				format "***** Could not SetProperty for this object: % prop:% *****\n" obj prop
			)
		)
	),
	
	fn SetObjectPropertiesFromDict obj propDict skipPropArr:#() =
	(
		-- ensure that the values of the array are strings instead of names so that we can accurately compare them to the key values.
		if ( skipPropArr.count != 0 ) then skipPropArr = for item in skipPropArr collect ( item as string )
		
		local dictKeys = ::_hash.GetDicKeys propDict
		
		for each in dictKeys where ( FindItem skipPropArr each == 0 ) do
		(
			if ( IsProperty obj each ) then
			(
				SetProperty obj each propDict.item[each]
			)
		)
	),
	
	fn FormatPropsAndVals obj =
	(
		local propNameList = GetPropNames obj
		
		for prop in propNameList do
		(
			format "> % = %\n" prop ( GetProperty obj prop )
		)
		
		OK
	),
	
    fn WirecolorUserPropData objArr:( Geometry as array ) =
    (
        -- If objects have UserProp data they will be colored red
        -- all other objects will be gray
        for obj in objArr do 
        (
            if ( GetUserPropBuffer obj ) != "" then
            (
                obj.wirecolor = red
            )
            else
            (
                obj.wirecolor = ( color 128 128 128 )
            )
        )
    ),
	
--)
	
	fn GetRandomColor =
	(
		color ( random 20 230 ) ( random 20 230 ) ( random 20 230 )
	),

    fn GetModule =
    (
        ( GetThisScriptFileName() )
    ),
    
    fn Help =
    (
        ::mxs.GetScriptHelp ( GetThisScriptFileName() )
    ),
	
private
    
    fn _init =
	(
		this.SetHeapSize 400000000
	),
	
	__init__ = _init()
)

CommonFns = CommonFns()