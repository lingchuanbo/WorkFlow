/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.2
Updated:				10/15/2014
[Purpose]
A memory efficient and fast function for combining multipling objects into a single mesh.
[KEYWORDS]
Attach, Combine, Mesh
__END__
******************************************/
struct attachObjects_lib
(
	modObjArr,
	fn checkIfModifiersPresent_FN objArr arr:#() = 
	(
		for i in objArr do
		(
			if i.modifiers.count > 0 then append arr i.name
		)
		if arr.count > 0 then
		(
			with printAllElements on format "***** Objects with modifiers: % *****\n" arr
			modObjArr = arr 
			true
		)
		else false
	),
	fn attachObjs_FN objArr garbageCollect:false =
	(
		if objArr.count < 2 then
		(
			messagebox "Must have at least 2 objects selected!"
		)
		else
		(
			disableSceneRedraw()
			tStart = timeStamp()
			progressStart "Attaching Objects"
			perc = (100.0 / (objArr.count))
			percentu = perc	
			nonGeoArr = for i in objArr where superClassOf i != geometryClass collect i
			for i in nonGeoArr do
			(
				format "***** % is not a mesh object. It will be ignored. *****\n" i.name
				deleteItem objArr (findItem objArr i)
			)							
			while objArr.count > 1 do
			(	
				for i = objArr.count to 2 by -2 do 
				(
					if getProgressCancel() then
					(
						progressEnd()
						return false
					)
					InstanceMgr.MakeObjectsUnique #(objArr[i], objArr[i-1]) #individual
					case (classOf objArr[i]) of
					(
						(Editable_Poly):
						(
							polyOp.attach objArr[i] objArr[i-1]
						)
						default:
						(
							if (classOf objArr[i]) != Editable_Mesh then convertToMesh objArr[i]
							attach objArr[i] objArr[i-1]
						)
					)
					deleteItem objArr (i-1)
					progressUpdate percentu
					percentu += perc
					if garbageCollect then gc()
				)
			)
			cui.commandPanelOpen = true
			progressEnd()
			tEnd = timeStamp()
			format "Attach time: %s\n" ((tEnd-tStart)/1000.0) as string
			if (classOf objArr[1]) != Editable_Mesh then convertToMesh objArr[1]
			select objArr[1]
			enableSceneRedraw()
		)
	),
	fn _init =
	(
		if (checkIfModifiersPresent_FN selection) == true then
		(
			if queryBox "Modifier Present: Do you want to proceed anyway?" title:"Modifiers Present" == true then
			(
				attachObjs_FN (getCurrentSelection())
			)
			else select modObjArr
		)
		else
		(
			attachObjs_FN (getCurrentSelection())
		)
	),
	init = _init()
)
attachObjs = attachObjects_lib()
