/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.10
Updated:				05/03/2014
[Purpose]
Analyzes your scene and collect all unique Object IDs and Material IDs.
Will create Multmatte Elements from the IDs with a logical naming convention.
******************************************/
try(destroyDialog cmefs.ro)catch()
struct createMultiMatteElementsForScene
(
	self,
	ro,
	ro_name,
	matte_ini = ((getDir #plugCFG)+@"\GTVFX_matte.ini"),
	idArrObj = #(),
	idArrMat = #(),
	progBar,
	progLbl,
	matIdPrefix = "IdMat_",
	objIdPrefix = "IdObj_",
	fn collectMaterials =
	(
		arr = (for i in sceneMaterials where i != undefined and superClassOf i == material collect i)
		arr
	),
	fn collectObjIds objArr arr =
	(
		progBar.value = 0
		progLbl.text = "Progress: ...Collecting Object IDs"
		progBar.color = blue
		startProgress = 100.0/(objArr.count)
		totalProgress = startProgress
		for i in objArr do
		(
			if i.gbufferChannel != 0 then appendIfUnique arr i.gbufferChannel
			progBar.value = totalProgress
			totalProgress += startProgress
		)
		sort arr
	),
	fn collectMatIds matArr arr updateUI:true=
	(
		if updateUI then
		(
			progBar.value = 0
			progLbl.text = "Progress: ...Collecting Material IDs"
			progBar.color = green
			startProgress = 100.0/(matArr.count)
			totalProgress = startProgress
		)
		for m in matArr do
		(
			numSubMats = (getNumSubMtls m)
			if numSubMats != 0 then
			(
				subMatArr = #()
				for i = 1 to numSubMats do
				(
					subMat = (getSubMtl m i)
					if subMat != undefined then append subMatArr subMat
				)
				collectMatIds subMatArr arr updateUI:false
			)
			if isProperty m "effectsChannel" and m.effectsChannel != 0 then appendIfUnique arr m.effectsChannel
			if updateUI then progBar.value = totalProgress
		)
		sort arr
	),
	fn createMatteElements_FN idArr isMatId:false =
	(
		curElmtMgr = MaxOps.GetCurRenderElementMgr()
		for i = 1 to idArr.count by 3 do
		(
			partArr = #(((idArr[i]) as string),((idArr[i+1]) as string),((idArr[i+2]) as string))
			for i in 1 to partArr.count do
			(
				if partArr[i].count == 1 then partArr[i] = ("0"+partArr[i])
				if partArr[i] == "undefined" then partArr[i] = "00"
			)
			namePrefix = if isMatId then matIdPrefix else objIdPrefix
			matteElm = multiMatteElement()
			matteElm.elementName = (namePrefix + partArr[1] + "_" + partArr[2] + "_" + partArr[3])
			matteElm.MatID = isMatId
			matteElm.R_gbufIDOn = true
			matteElm.G_gbufIDOn = true
			matteElm.B_gbufIDOn = true
			matteElm.R_gbufID = if (idArr[i]) != undefined then (idArr[i]) else 0
			matteElm.G_gbufID = if (idArr[i+1]) != undefined then (idArr[i+1]) else 0
			matteElm.B_gbufID = if (idArr[i+2]) != undefined then (idArr[i+2]) else 0
			curElmtMgr.AddRenderElement matteElm
		)
	),
	fn nameUi =
	(
		rollout ro_name "Set Matte Prefix" width:200
		(
			local self
			editText edt_matPre "Material Matte Prefix:" labelOnTop:true
			editText edt_objPre "Object Matte Prefix:" labelOnTop:true
			button btn_apply "Apply Update"
			fn _init pself =
			(
				self = pself
				edt_matPre.text = self.matIdPrefix
				edt_objPre.text = self.objIdPrefix
			)
			on btn_apply pressed do
			(
				self.matIdPrefix = edt_matPre.text
				self.objIdPrefix = edt_objPre.text
				setIniSetting self.matte_ini "General" "matPre" self.matIdPrefix
				setIniSetting self.matte_ini "General" "objPre" self.objIdPrefix
				destroyDialog ro_name
				self._init()
			)
		)
		createDialog ro_name
		ro_name._init self
	),
	fn ui =
	(
		rollout ro "Create Multimatte Elements for Scene By GTVFX" width:360 height:210
		(
			local self
			local dnTooltip
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			
			label lbl_matPre "MatID Prefix: " align:#left across:2
			label lbl_objPre "ObjID Prefix: " align:#left
			dotNetControl dNbtn_prefix "button" width:(ro.width-20) height:20 offset:[-3,0]
			label lbl_prog "Progress:" align:#left
			progressBar pb_Progress width:(ro.width - 30) height:25
			label lbl_obj "Object IDs in Scene:" align:#left
			label lbl_mat "Material IDs in Scene:" align:#left
			dotNetControl dNbtn_obj  "button" width:(ro.width/2-15) height:40 offset:[-5,5] across:2
			dotNetControl dNbtn_mat  "button" width:(ro.width/2-15) height:40 offset:[5,5]
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn initToolTip dNetObj caption =
			(
				if dnTooltip == undefined then
				(
					dnToolTip = dotnetobject "ToolTip"
					dnToolTip.AutoPopDelay = 5000
					dnToolTip.InitialDelay = 300
					dnToolTip.ReshowDelay = 300
					dnToolTip.ShowAlways = true
					dnToolTip.IsBalloon = true
				)
				dnToolTip.SetToolTip dNetObj caption
			)
			fn setDotNetWidget dNobj caption fontSize colorOffsetInt:0 =
			(
				dNobj.text = caption
				dNobj.forecolor = dNobj.forecolor.FromArgb clrText.x clrText.y clrText.z
				dNobj.backColor = dNobj.backcolor.FromArgb (ClrBackGround.x+colorOffsetInt) (ClrBackGround.y+colorOffsetInt) (ClrBackGround.z+colorOffsetInt)
				dNobj.Font = dotNetObject "System.Drawing.Font" "Tahoma" fontSize ((dotNetClass "System.Drawing.FontStyle").bold)
				dNobj.update()
			)
			fn initDnetBtn dNbtn caption fontSize style:#popup colorOffsetInt:0 tooltip:"" = 
			(
				case style of
				(
					#flat:(dNbtn.flatStyle = dNbtn.flatStyle.flat)
					#popup:(dNbtn.flatStyle = dNbtn.flatStyle.popup)
					#system:(dNbtn.flatStyle = dNbtn.flatStyle.system)
				)
				setDotNetWidget dNbtn caption fontSize colorOffsetInt:colorOffsetInt
				initToolTip dNbtn tooltip
				dNbtn.update()
			)
			fn _init pself =
			(
				self = pself
				
				initDnetBtn dNbtn_prefix "--- Edit Prefix ---" 7 style:#popup colorOffsetInt:10 tooltip:"Change the prefix of the created elements"
				initDnetBtn dNbtn_obj "Create Obj ID Mattes" 10 style:#popup colorOffsetInt:10 tooltip:""
				initDnetBtn dNbtn_mat "Create Mat ID Mattes" 10 style:#popup colorOffsetInt:10 tooltip:""
				
				lbl_matPre.text = ("MatID Prefix: " + self.matIdPrefix)
				lbl_objPre.text = ("ObjID Prefix: " + self.objIdPrefix)
				
				self.progBar = pb_Progress
				self.progLbl = lbl_prog
				self.idArrObj = #()
				self.collectObjIds objects self.idArrObj
				self.idArrMat = #()
				self.collectMatIds (self.collectMaterials()) self.idArrMat
				--self.collectMatIds (for i in sceneMaterials where i != undefined collect i) self.idArrMat
				pb_Progress.value = 100
				pb_Progress.color = orange
				lbl_prog.text = "Progress: Data Collected"
				lbl_obj.text = ("Object IDs in Scene:    " + (self.idArrObj.count as string))
				lbl_mat.text = ("Material IDs in Scene:    " + (self.idArrMat.count as string))
			)
			on dNbtn_prefix mouseClick arg do
			(
				self.nameUi()
			)
			on dNbtn_obj mouseClick arg do
			(
				if self.idArrObj.count != 0 then
				(
					self.createMatteElements_FN self.idArrObj isMatId:false
				)
			)
			on dNbtn_mat mouseClick arg do
			(
				if self.idArrMat.count != 0 then
				(
					self.createMatteElements_FN self.idArrMat isMatId:true
				)
			)
		)
		createDialog ro
		ro._init self
	),
	fn _init =
	(
		self = this
		if doesFileExist matte_ini then
		(
			matIdPrefix = getIniSetting matte_ini "General" "matPre"
			objIdPrefix = getIniSetting matte_ini "General" "objPre" 
		)
		ui()
	),
	init = _init()
)
cmefs = createMultiMatteElementsForScene()

