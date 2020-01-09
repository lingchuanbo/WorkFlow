/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/21/2013
[Purpose]
A method for transferring material assignments for assets if your pipeline isn't set up for automating that.
[KEYWORDS]
Material, Transfer, Store
__END__
******************************************/
Struct materialTransfer_lib
(
	self,
	ro,
	tempDir = (getDir #temp),
	
	fn copy_FN objArr fileName =
	(	
		makeDir (tempDir+"\\copypaste")
		if objArr.count > 0 then
		(
			saveNodes objArr (tempDir+"\\copypaste\\"+fileName)
		)
		else
		(
			messagebox "Nothing selected......"
		)
	),
	fn paste_FN fileName =
	(
		maxFile = (tempDir+"\\copypaste\\"+fileName)
		if doesFileExist maxFile then
		(
			mergeMaxFile maxFile #select
		)
		else messageBox ("No such file:\n" + maxFile)
	),
	fn storeNodeMaterialArr obj objArr arr:#() =
	(
		appString = "#("
		for each in objArr do
		(
			if each != obj and each.material == obj.material then appString += ("\""+each.name+"\""+",")
		)
		appString += ")"
		appString = substituteString appString ",)" ")"
		setAppData obj 1 appString
	),
	fn storeMaterialsToSpheres objArr arr:#() =
	(
		if objArr.count != 0 then
		(
			(LayerManager.getLayerFromName "0").current = true
			for i in objArr do appendIfUnique arr i.material
			for i in 1 to arr.count do
			(
				theSphere = (sphere name:(uniquename "MTL_Sphere_001") radius:15 position:[(16*i),0,0] material:arr[i] wireColor:(random [20,20,20] [230,230,230]) )
				storeNodeMaterialArr theSphere objArr
			)
			messageBox "Materials saved successfully." Title:"GTVFX: Message"
		) 
		else messageBox "Cannot find materials to save" Title:"GTVFX: Message"
	),
	fn applyMaterialsFromSpheres sphereArr =
	(
		if sphereArr.count != 0 then
		(
			for i in sphereArr do
			(
				appArr = (execute (getAppData i 1))
				for each in appArr do
				(
					appNode = (getNodeByName each)
					if appNode != undefined then
					(
						appNode.material = i.material
					)
				)
			)
			messageBox "Materials applied successfully." Title:"GTVFX: Message"
			delete sphereArr
		)
		else messageBox "Could not find the transfer nodes."
	),
	fn ui =
	(
		rollout ro "Mat Assignment Transfer By GTVFX"
		(
			local self
			local storeArr = geometry
			local sphereArr = #()
			local fileName = "matTransfer.max"
			local spherePattern = "MTL_Sphere_"
			button btn_store "Save Material Assignments" width:230 height:30 tooltip:"Collects and stores the material assignments for all geometry objects."
			button btn_apply "Apply Material Assignments" width:230 height:30 tooltip:"If you have stored a file with material assignments this will run the asignments from your stored file."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on btn_store pressed do
			(
				self.storeMaterialsToSpheres storeArr
				sphereArr = (execute ("$*"+spherePattern+"*"))
				self.copy_FN sphereArr fileName
				delete sphereArr
			)
			on btn_apply pressed do
			(
				self.paste_FN fileName
				sphereArr = (execute ("$*"+spherePattern+"*"))
				self.applyMaterialsFromSpheres sphereArr
			)
		)
		createDialog ro width:250 height:100
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog matTransfer.ro)catch()
matTransfer = materialTransfer_lib()
