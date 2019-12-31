--SaveAniTime_v1.0 ---2012/2/5----------------------------------------
--用于保存\读取动作时间,方便查看动作,可保存和读取多套动作时间模板
----------------------------------------------------------------------
if saveAniTime_Rollout != undefined do destroydialog saveAniTime_Rollout
global uiX,uiY,saveAllItemCount,uiMinMax,PLAYS,speed_14x,speed_12x,speed_1x,speed_2x,speed_4x,speed_rate,setFrameRate_rol
global uiAddLock, uiAddLockP, uiDelLock, uiDelLockP, uiEditLock, uiEditLockP, itemSeled, savetimeNum
if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" "E:\\BoBOAHK\\Vimdesktop\\custom\\maxScripts" 
symbolicPaths.setUserPathValue "$maxScripts" "E:\\BoBOAHK\\Vimdesktop\\custom\\maxScripts"
--kkk = getinisetting "$maxScripts\\custom_prefs.ini" "saveTimeInterface" "k"
uiX = getinisetting "$maxScripts\\custom_prefs.ini" "saveTimeInterface" "uiX" as integer
uiY = getinisetting "$maxScripts\\custom_prefs.ini" "saveTimeInterface" "uiY" as integer
if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLockD")=="" do setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLockD" "0"
if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLockD")=="" do setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLockD" "0"
if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLockD")=="" do setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLockD" "0"
if maxfilepath == "" then(
	itemSeled = 1
)else(
	fileName = filterString maxfilename "."
	itemSeled = (getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemSelected") as integer
)

uiAddLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock"
uiDelLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock"
uiEditLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock"
if uiAddLock == "" or uiAddLock == "0" then(
	setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock" "0"
	uiAddLockP = (openBitMap "..\Icons\\ats_addtime.bmp")
)else(
	uiAddLockP = (openBitMap "..\Icons\\ats_addtimelock.bmp")
)
if uiDelLock == "" or uiDelLock == "0" then(
	setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock" "0"
	uiDelLockP = (openBitMap "..\Icons\\ats_deltime.bmp")
)else(
	uiDelLockP = (openBitMap "..\Icons\\ats_deltimelock.bmp")
)
if uiEditLock == "" or uiEditLock == "0" then(
	setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock" "0"
	uiEditLockP = (openBitMap "..\Icons\\ats_edittime.bmp")
)else(
	uiEditLockP = (openBitMap "..\Icons\\ats_edittimelock.bmp")
)

setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax" "false"
setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS" "false"

rcmenu SpeedCusmenu
(
	menuItem mi_Speed_14 "- 1/4x -" checked:false
	menuItem mi_Speed_12 "- 1/2x -" checked:false
	menuItem mi_Speed_1 "-  1x  -" checked:false
	menuItem mi_Speed_2 "-  2x  -" checked:false
	menuItem mi_Speed_4 "-  4x  -" checked:false
	menuItem mi_Speed_rate "CustomFPS: " checked:false

	on SpeedCusmenu open do(
		speed_rate=("CustomFPS: "+(frameRate as string))
		if timeConfiguration.playbackSpeed==1 do mi_Speed_14.checked=true
		if timeConfiguration.playbackSpeed==2 do mi_Speed_12.checked=true
		if timeConfiguration.playbackSpeed==3 do mi_Speed_1.checked=true
		if timeConfiguration.playbackSpeed==4 do mi_Speed_2.checked=true
		if timeConfiguration.playbackSpeed==5 do mi_Speed_4.checked=true
		mi_Speed_rate.text=speed_rate
	)
	on mi_Speed_14 picked do(
		if mi_Speed_14.checked==false then(
			mi_Speed_14.checked=true
			mi_Speed_12.checked=false
			mi_Speed_1.checked=false
			mi_Speed_2.checked=false
			mi_Speed_4.checked=false
			timeConfiguration.playbackSpeed=1
		)
	)
	on mi_Speed_12 picked do(
		if mi_Speed_12.checked==false then(
			mi_Speed_14.checked=false
			mi_Speed_12.checked=true
			mi_Speed_1.checked=false
			mi_Speed_2.checked=false
			mi_Speed_4.checked=false
			timeConfiguration.playbackSpeed=2
		)
	)
	on mi_Speed_1 picked do(
		if mi_Speed_1.checked==false then(
			mi_Speed_14.checked=false
			mi_Speed_12.checked=false
			mi_Speed_1.checked=true
			mi_Speed_2.checked=false
			mi_Speed_4.checked=false
			timeConfiguration.playbackSpeed=3
		)
	)
	on mi_Speed_2 picked do(
		if mi_Speed_2.checked==false then(
			mi_Speed_14.checked=false
			mi_Speed_12.checked=false
			mi_Speed_1.checked=false
			mi_Speed_2.checked=true
			mi_Speed_4.checked=false
			timeConfiguration.playbackSpeed=4
		)
	)
	on mi_Speed_4 picked do(
		if mi_Speed_4.checked==false then(
			mi_Speed_14.checked=false
			mi_Speed_12.checked=false
			mi_Speed_1.checked=false
			mi_Speed_2.checked=false
			mi_Speed_4.checked=true
			timeConfiguration.playbackSpeed=5
		)
	)
	on mi_Speed_rate picked do(
		createdialog setFrameRate_rol pos:[uiX-70,uiY+70]
	)
)
--key
-- rollout kkkRollout "Keys" width: 358 height: 150
-- (
-- 	label lbl1 "请输入密匙：" pos:[56,25] width:182 height:18
-- 	editText edt1 "" text:"4P3WQBQ-P432OKGHKJ-HGFD-GSAMGH1NBVSSFJGD4" pos:[51,54] width:252 height:23
-- 	button btn1 "OK" pos:[135,90] width:81 height:27
-- 	hyperLink likNetSina "Help: Welcome to My Blog qinlaowoniu" address:"http://blog.sina.com.cn/qinlaowoniu" pos:[96, 126] color:(color 0 100 205) hoverColor:(color 255 128 57)

-- 	on btn1 pressed do(
-- 		if edt1.text == "4P3WQBQ-P432OKGHKJ-HGFD-GSAMGH1NBVSSFJGD4" or edt1.text == "00x00x" then(
-- 			setINISetting  "$maxScripts\\custom_prefs.ini" "saveTimeInterface" "k" "101000101110101010111111000000101011110101010111010100010"
-- 			destroyDialog kkkRollout
-- 			messagebox "密匙开启成功... 谢谢使用！" title:"Keys OK..."
-- 			createdialog saveAniTime_Rollout pos:[uiX,uiY]
-- 		)else(
-- 			messagebox "密匙错误，请重试！" title:"Keys Error!"
-- 		edt1.text = ""
-- 		 )
-- 	)
-- )
--rcmenu菜单里调用setFrameRate_rol时，rollout名称需要在前面用Global声明
rollout setFrameRate_rol "SetFrameRate" width:120 height:60
(
	spinner FR_spn "FrameRate:" pos:[20,10] width:90 range:[1,120,frameRate] type:#integer
	button Clo "X" pos:[15,32] width:40
	button OK "OK" pos:[65,32] width:40
	on OK pressed do(
		frameRate=FR_spn.value
		SpeedCusmenu.mi_Speed_rate.text=("CustomFPS: "+(FR_spn.value as string))
		destroydialog setFrameRate_rol
	)
	on Clo pressed do destroydialog setFrameRate_rol
)

rollout saveAniTime_Rollout "AniTimeSave v2.8.3" width:210 height:260
(
	imgTag uiMoveUU "" bitmap: (openBitMap "..\Icons\\ats_moveUU.bmp") pos:[0,0] transparent:(color 255 0 255)
	imgTag uiMoveDD "" bitmap: (openBitMap "..\Icons\\ats_moveDownD.bmp") pos:[0,12] transparent:(color 255 0 255)
	imgTag uiMoveU "" bitmap: (openBitMap "..\Icons\\ats_moveU.bmp") pos:[8,0] transparent:(color 255 0 255)
	imgTag uiMoveD "" bitmap: (openBitMap "..\Icons\\ats_moveD.bmp") pos:[8,12] transparent:(color 255 0 255)
	imgTag uiLogo "" bitmap: (openBitMap "..\Icons\\ats_logo.bmp") pos:[16,0] transparent:(color 255 0 255)
	imgTag uiNumA "" bitmap: (openBitMap "..\Icons\\ats_numA.bmp") pos:[54,0] transparent:(color 255 0 255)
	imgTag uiNumB "" bitmap: (openBitMap "..\Icons\\ats_numB.bmp") pos:[66,0] transparent:(color 255 0 255)
	imgTag uiAddtime "" bitmap: uiAddLockP pos:[78,0] transparent:(color 255 0 255) tooltip:"添加时间记录"
	imgTag uiDeltime "" bitmap: uiDelLockP pos:[100,0] transparent:(color 255 0 255) tooltip:"删除选中的时间记录"
	imgTag uiEdittime "" bitmap: uiEditLockP pos:[122,0] transparent:(color 255 0 255) tooltip:"编辑选中的时间记录"
	imgTag uiReload "" bitmap: (openBitMap "..\Icons\\ats_reload.bmp") pos:[144,0] transparent:(color 255 0 255) tooltip:"刷新"
	imgTag uiPlay "" bitmap: (openBitMap "..\Icons\\ats_play.bmp") pos:[166,0] transparent:(color 255 0 255) tooltip:"播放\\右键停止"
	comboBox cbx1 "" pos:[6,26] selection: itemSeled width:196 height:15
	imgTag uiSave "" bitmap: (openBitMap "..\Icons\\ats_save.bmp") pos:[1,237] transparent:(color 255 0 255) tooltip:"保存当前整组时间记录为模板"
	imgTag uiLoad "" bitmap: (openBitMap "..\Icons\\ats_load.bmp") pos:[24,237] transparent:(color 255 0 255) tooltip:"读取模板"
	imgTag uiEdit "" bitmap: (openBitMap "..\Icons\\ats_edit.bmp") pos:[47,237] transparent:(color 255 0 255) tooltip:"替换模板"
	imgTag uiDel "" bitmap: (openBitMap "..\Icons\\ats_del.bmp") pos:[70,237] transparent:(color 255 0 255) tooltip:"删除模板"
	imgTag uiMM "" bitmap: (openBitMap "..\Icons\\ats_min.bmp") pos:[188,0] transparent:(color 255 0 255)
	dropDownList saveAll_ddl "" pos:[93,237] width:115

	fn saveItemSel =(
		if maxfilepath != "" then(
		fileName = filterString maxfilename "."
		setinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemSelected" (cbx1.selection as string)
	))
	fn getAniNum num = (	--num要转为string
		if num.count == 1 do(
			uiNumA.bitmap = (openBitMap "..\Icons\\ats_numA.bmp")
			if num == "0" then(
				uiNumB.bitmap = (openBitMap ("..\Icons\\ats_numB0.bmp"))
			)else(
				uiNumB.bitmap = (openBitMap ("..\Icons\\ats_numB"+num+".bmp"))
		))
		if num.count == 2 do(
			onum = substring num 1 1
			uiNumA.bitmap = (openBitMap ("..\Icons\\ats_numA"+onum+".bmp"))
			tnum = substring num 2 1
			uiNumB.bitmap = (openBitMap ("..\Icons\\ats_numB"+tnum+".bmp"))
		)
		if num.count == 3 do(
			uiNumA.bitmap = (openBitMap "..\Icons\\ats_numA!.bmp")
			uiNumB.bitmap = (openBitMap ("..\Icons\\ats_numB9.bmp"))
		)
	)
	fn saveItems =(
		if maxfilepath != "" then(
			fileName = filterString maxfilename "."
			for i in 1 to cbx1.items.count do(
				setinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" (i as string) cbx1.items[i]
			)
			setinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemsCount" (cbx1.items.count as string)
			getAniNum (cbx1.items.count as string)
		)else(messagebox "请先保存场景或打开一个场景!" title:"SaveAniTime")
	)
	fn SAT_reload =(
		if maxfilepath != "" then(
			fileName = filterString maxfilename "."
			itemCount = getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemsCount" as integer
			itemsArr = #()
			for i in 1 to itemCount do(
				itemTmp = getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" (i as string)
				append itemsArr itemTmp
			)
			cbx1.items = itemsArr
			getAniNum (itemCount as string)
		)
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		saveAllDllTmp = #()
		for si in 1 to saveAllItemCount do(
			saveAllItem = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" (si as string)
			append saveAllDllTmp saveAllItem
		)
		saveAll_ddl.items = saveAllDllTmp
	)
	fn moveUp = (
	if maxfilepath != "" then(
		if cbx1.selection > 1 then(
			selItem = cbx1.selected
			cbxItem = cbx1.items
			selNum = cbx1.selection
			deleteitem cbxItem selNum
			insertItem selItem cbxItem (selNum-1)
			cbx1.items = cbxItem
			cbx1.selection = (selNum-1)
			saveItems()
			saveItemSel()
		)
	))
	fn moveUpup = (
	if maxfilepath != "" then(
		if cbx1.selection > 1 then(
			selItem = cbx1.selected
			cbxItem = cbx1.items
			selNum = cbx1.selection
			deleteitem cbxItem selNum
			insertItem selItem cbxItem 1
			cbx1.items = cbxItem
			cbx1.selection = 1
			saveItems()
			saveItemSel()
		)
	))
	fn moveDown = (
	if maxfilepath != "" then(
		fileName = filterString maxfilename "."
		itemCount = getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemsCount" as integer
		if cbx1.selection < itemCount then(
			selItem = cbx1.selected
			cbxItem = cbx1.items
			selNum = cbx1.selection
			deleteitem cbxItem selNum
			insertItem selItem cbxItem (selNum+1)
			cbx1.items = cbxItem
			cbx1.selection = (selNum+1)
			saveItems()
			saveItemSel()
		)
	))
	fn moveDowndown = (
	if maxfilepath != "" then(
		fileName = filterString maxfilename "."
		itemCount = getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemsCount" as integer
		if cbx1.selection < itemCount then(
			selItem = cbx1.selected
			cbxItem = cbx1.items
			selNum = cbx1.selection
			deleteitem cbxItem selNum
			insertItem selItem cbxItem itemCount
			cbx1.items = cbxItem
			cbx1.selection = itemCount
			saveItems()
			saveItemSel()
		)
	))
	--On--------------------------------------
	--============================
	on uiLoad mouseover do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loado.bmp")
		)else(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_load.bmp")
		)
	)
	on uiLoad mouseout do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loadh.bmp")
		)else(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_load.bmp")
		)
	)
	on uiLoad mousedown do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loadd.bmp")
		)else(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_load.bmp")
		)
	)
	on uiLoad mouseup do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loado.bmp")
		)else(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_load.bmp")
		)
	)
	on uiLoad click do(
		if saveAll_ddl.selected != undefined then(
			mo = querybox ("确定读取模板：\""+saveAll_ddl.selected+"\" 替换当前所有的时间记录！") title:"读取模板"
			if mo == true then(
				moItemTmp = filterString (getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" saveAll_ddl.selected) "@"
				cbx1.items = moItemTmp
				saveItems()
			)
		)
	)
	--============================
	on uiMoveUU mouseover do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveUU.bitmap = (openBitMap "..\Icons\\ats_moveUUo.bmp")
	)
	on uiMoveUU mouseout do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveUU.bitmap = (openBitMap "..\Icons\\ats_moveUU.bmp")
	)
	on uiMoveUU mousedown do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveUU.bitmap = (openBitMap "..\Icons\\ats_moveUUd.bmp")
	)
	on uiMoveUU mouseup do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveUU.bitmap = (openBitMap "..\Icons\\ats_moveUUo.bmp")
	)
	on uiMoveUU click do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do moveUpup()
	)
	--============================
	on uiMoveDD mouseover do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveDD.bitmap = (openBitMap "..\Icons\\ats_moveDownDo.bmp")
	)
	on uiMoveDD mouseout do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveDD.bitmap = (openBitMap "..\Icons\\ats_moveDownD.bmp")
	)
	on uiMoveDD mousedown do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveDD.bitmap = (openBitMap "..\Icons\\ats_moveDownDd.bmp")
	)
	on uiMoveDD mouseup do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveDD.bitmap = (openBitMap "..\Icons\\ats_moveDownDo.bmp")
	)
	on uiMoveDD click do(	if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do moveDowndown() )
	--============================
	on uiMoveU mouseover do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveU.bitmap = (openBitMap "..\Icons\\ats_moveUo.bmp")
	)
	on uiMoveU mouseout do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveU.bitmap = (openBitMap "..\Icons\\ats_moveU.bmp")
	)
	on uiMoveU mousedown do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveU.bitmap = (openBitMap "..\Icons\\ats_moveUd.bmp")
	)
	on uiMoveU mouseup do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveU.bitmap = (openBitMap "..\Icons\\ats_moveUo.bmp")
	)
	on uiMoveU click do(	if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do moveUp() )
	--============================
	on uiMoveD mouseover do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveD.bitmap = (openBitMap "..\Icons\\ats_moveDo.bmp")
	)
	on uiMoveD mouseout do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveD.bitmap = (openBitMap "..\Icons\\ats_moveD.bmp")
	)
	on uiMoveD mousedown do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveD.bitmap = (openBitMap "..\Icons\\ats_moveDd.bmp")
	)
	on uiMoveD mouseup do(
		if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do uiMoveD.bitmap = (openBitMap "..\Icons\\ats_moveDo.bmp")
	)
	on uiMoveD click do(	if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax") == "false" do moveDown() )
	--============================
	on uiSave mouseover do(
		uiSave.bitmap = (openBitMap "..\Icons\\ats_saveo.bmp")
	)
	on uiSave mouseout do(
		uiSave.bitmap = (openBitMap "..\Icons\\ats_save.bmp")
	)
	on uiSave mousedown do(
		uiSave.bitmap = (openBitMap "..\Icons\\ats_saved.bmp")
	)
	on uiSave click do(
		dllItemTmp = saveAll_ddl.items
		if (finditem dllItemTmp cbx1.text) < 1 and findstring cbx1.text "-" == undefined and cbx1.text != "" and cbx1.items[1] != undefined then(
			mo = querybox "确定将现有的时间记录新建保存模板！" title:"新建模板"
			if mo == true then(
				allAniTmp = cbx1.items[1]
				for i in 2 to cbx1.items.count do(
					allAniTmp = allAniTmp+"@"+cbx1.items[i]
				)
				append dllItemTmp cbx1.text
				saveAll_ddl.items = dllItemTmp
				setinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" (cbx1.text as string) (allAniTmp as string)
				setinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" (saveAll_ddl.items.count as string) (cbx1.text as string)
				setinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" (saveAll_ddl.items.count as string)
			)
		)else(messagebox "在上方输入要新建的模板名称，不能与原有模板重名，\n不能带有\"-\"字符，时间栏里最少要有一个记录！" title:"新建模板")
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loadh.bmp")
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_editl.bmp")
			uiDel.bitmap = (openBitMap "..\Icons\\ats_dell.bmp")
		)
	)
	--============================
	on uiEdit mouseover do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_edito.bmp")
		)
	)
	on uiEdit mouseout do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_editl.bmp")
		)else(
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_edit.bmp")
		)
	)
	on uiEdit mousedown do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_editd.bmp")
		)
	)
	on uiEdit click do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
		if saveAll_ddl.selected != undefined and cbx1.items[1] != undefined then(
			mo=querybox ("确定将现有的时间记录替换掉模板：\""+saveAll_ddl.selected+"\"！") title:"替换模板"
			if mo == true then(
				allAniTmp = cbx1.items[1]
				for i in 2 to cbx1.items.count do(
					allAniTmp = allAniTmp+"@"+cbx1.items[i]
				)
				setinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" saveAll_ddl.selected (allAniTmp as string)
			)
		)else(messagebox "选择模板进行编辑\n时间记录不能是空的！" title:"编辑模板")
		)
	)
	--============================
	on uiDel mouseover do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiDel.bitmap = (openBitMap "..\Icons\\ats_delo.bmp")
		)
	)
	on uiDel mouseout do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiDel.bitmap = (openBitMap "..\Icons\\ats_dell.bmp")
		)else(
			uiDel.bitmap = (openBitMap "..\Icons\\ats_del.bmp")
		)
	)
	on uiDel mousedown do(
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiDel.bitmap = (openBitMap "..\Icons\\ats_deld.bmp")
		)
	)
	on uiDel click do(
		if saveAll_ddl.selected != undefined then(
			mo = querybox ("确定要删除模板：\""+saveAll_ddl.selected+"\"！") title:"删除模板"
			if mo == true then(
				dllItemTmp = saveAll_ddl.items
				delinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" saveAll_ddl.selected
				for i in 1 to dllItemTmp.count do(
					delinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" (i as string)
				)
				deleteitem dllItemTmp saveAll_ddl.selection
				saveAll_ddl.items = dllItemTmp
				for i in 1 to dllItemTmp.count do(
					setinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" (i as string) (dllItemTmp[i] as string)
				)
				setinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" (dllItemTmp.count as string)
			)
		)
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loadh.bmp")
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_editl.bmp")
			uiDel.bitmap = (openBitMap "..\Icons\\ats_dell.bmp")
		)else(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_load.bmp")
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_edit.bmp")
			uiDel.bitmap = (openBitMap "..\Icons\\ats_del.bmp")
		)
	)
	--============================
	on uiAddtime mouseover do(
		uiAddLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock")
		if uiAddLock == "0" then(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimeo.bmp")
		)else(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimelock.bmp")
		)
	)
	on uiAddtime mouseout do(
		uiAddLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock")
		if uiAddLock == "0" then(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtime.bmp")
		)else(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimelock.bmp")
		)
	)
	on uiAddtime mousedown do(
		uiAddLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock")
		if uiAddLock == "0" then(
		uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimed.bmp")
		)else(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimelock.bmp")
		)
	)
	on uiAddtime mouseup do(
		uiAddLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock")
		if uiAddLock == "0" then(
		uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimeo.bmp")
		)else(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimelock.bmp")
		)
	)
	on uiAddtime click do(
		uiAddLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock")
		if uiAddLock == "0" then(
		if maxfilepath != "" then(
			if cbx1.text != "" then(
			cbxItem = cbx1.items
			selItem = cbx1.selection
			
			frameC = filterString cbx1.text "-( )/"
	--		frameS = filterString cbx1.selected "-( )/"
			if frameC[2] != undefined then(
			-- if frameC[2] != frameS[2] or frameC[3] != frameS[3] then(
				startTmp = frameC[2]
				endTmp = frameC[3]
			-- )else(
				-- startTmp = animationRange.start as string
				-- endTmp = animationRange.end as string
			-- )
			)else(
				startTmp = animationRange.start as string
				endTmp = animationRange.end as string
			)
			
			nameSTmp = filterString cbx1.text "-"
			insertItem (nameSTmp[1]+"-("+startTmp+"/"+endTmp+")") cbxItem (selItem+1)
			cbx1.items = cbxItem
			cbx1.selection = (selItem+1)
			saveItems()
			)
		))
	)
	on uiAddtime rightclick do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		uiAddLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock"
		if uiAddLock != "1" then(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimelock.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock" "1"
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLockD" "1"
		)else(
		if uiMinMax == "false" do(
			uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimeo.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock" "0"
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLockD" "0"
		))
	)
	--============================
	on uiDeltime mouseover do(
		uiDelLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock")
		if uiDelLock == "0" then(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimeo.bmp")
		)else(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimelock.bmp")
		)
	)
	on uiDeltime mouseout do(
		uiDelLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock")
		if uiDelLock == "0" then(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltime.bmp")
		)else(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimelock.bmp")
		)
	)
	on uiDeltime mousedown do(
		uiDelLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock")
		if uiDelLock == "0" then(
		uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimed.bmp")
		)else(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimelock.bmp")
		)
	)
	on uiDeltime mouseup do(
		uiDelLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock")
		if uiDelLock == "0" then(
		uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimeo.bmp")
		)else(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimelock.bmp")
		)
	)
	on uiDeltime click do(
		uiDelLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock")
		if uiDelLock == "0" then(
		if maxfilepath != "" then(
			if cbx1.selection != 0 then(
				fileName = filterString maxfilename "."
				cbxItem = cbx1.items
				deleteitem cbxItem cbx1.selection
				cbx1.items = cbxItem
				itemCount = (getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" "itemsCount") as integer
				for i in 1 to itemCount do(
					delinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" (i as string)
				)
				saveItems()
			)
		))
	)
	on uiDeltime rightclick do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		uiDelLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock"
		if uiDelLock != "1" then(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimelock.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock" "1"
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLockD" "1"
		)else(
		if uiMinMax == "false" do(
			uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimeo.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock" "0"
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLockD" "0"
		))
	)
	--============================
	on uiEdittime mouseover do(
		uiEditLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock")
		if uiEditLock == "0" then(
		uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimeo.bmp")
		)else(
			uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimelock.bmp")
		)
	)
	on uiEdittime mouseout do(
		uiEditLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock")
		if uiEditLock == "0" then(
		uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittime.bmp")
		)else(
			uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimelock.bmp")
		)
	)
	on uiEdittime mousedown do(
		uiEditLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock")
		if uiEditLock == "0" then(
		uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimed.bmp")
		)else(
			uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimelock.bmp")
		)
	)
	on uiEdittime mouseup do(
		uiEditLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock")
		if uiEditLock == "0" then(
		uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimeo.bmp")
		)else(
			uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimelock.bmp")
		)
	)
	on uiEdittime click do(
		uiEditLock = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock")
		if uiEditLock == "0" then(
		if cbx1.selected != undefined then(
			frameC = filterString cbx1.text "-( )/"
			frameS = filterString cbx1.selected "-( )/"
			if frameC[2] != undefined then(
			if frameC[2] != frameS[2] or frameC[3] != frameS[3] then(
				startTmp = frameC[2]
				endTmp = frameC[3]
			)else(
				startTmp = animationRange.start as string
				endTmp = animationRange.end as string
			)
			)else(
				startTmp = animationRange.start as string
				endTmp = animationRange.end as string
			)
			nameSTmp = filterString cbx1.text "-"
			cbx1.selected = (nameSTmp[1]+"-("+startTmp+"/"+endTmp+")")
			saveItems()
		)
		)
	)
	on uiEdittime rightclick do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		uiEditLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock"
		if uiEditLock != "1" then(
			uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimelock.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock" "1"
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLockD" "1"
		)else(
		if uiMinMax == "false" do(
			uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimeo.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock" "0"
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLockD" "0"
		))
	)
	--============================
	on uiReload mouseover do(
		uiReload.bitmap = (openBitMap "..\Icons\\ats_reloado.bmp")
	)
	on uiReload mouseout do(
		uiReload.bitmap = (openBitMap "..\Icons\\ats_reload.bmp")
	)
	on uiReload mousedown do(
		uiReload.bitmap = (openBitMap "..\Icons\\ats_reloadd.bmp")
	)
	on uiReload mouseup do(
		uiReload.bitmap = (openBitMap "..\Icons\\ats_reloado.bmp")
	)
	on uiReload click do(
		SAT_reload()
	)
	--============================
	on uiPlay mouseover do(
		PLAYS=(getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS")
		if PLAYS == "false" then(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_playo.bmp")
		)else(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_stopo.bmp")
		)
	)
	on uiPlay mouseout do(
		PLAYS=(getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS")
		if PLAYS == "false" then(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_play.bmp")
		)else(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_stop.bmp")
		)
	)
	on uiPlay mousedown do(
		PLAYS=(getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS")
		if PLAYS == "false" then(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_playd.bmp")
		)else(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_stopd.bmp")
		)
	)
	on uiPlay mouseup do(
		PLAYS=(getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS")
		if PLAYS == "true" then(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_playo.bmp")
		)else(
			uiPlay.bitmap = (openBitMap "..\Icons\\ats_stopo.bmp")
		)
	)
	on uiPlay click do(
		PLAYS=(getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS")
		if PLAYS == "false" then(
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS" "true"
			playAnimation()
		)else(
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS" "false"
			stopAnimation()
		)
	)
	on uiPlay rightclick do(
		popupMenu SpeedCusmenu
	)
	--============================
	on uiMM mouseover do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		if uiMinMax == "false" then(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_mino.bmp")
		)else(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_maxo.bmp")
		)
	)
	on uiMM mouseout do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		if uiMinMax == "false" then(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_min.bmp")
		)else(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_max.bmp")
		)
	)
	on uiMM mousedown do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		if uiMinMax == "false" then(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_mind.bmp")
		)else(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_maxd.bmp")
		)
	)
	on uiMM mouseup do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		if uiMinMax == "true" then(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_mino.bmp")
		)else(
			uiMM.bitmap = (openBitMap "..\Icons\\ats_maxo.bmp")
		)
	)
	on uiMM click do(
		uiMinMax = (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax")
		if uiMinMax == "false" then(
			saveAniTime_Rollout.height=25
setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock" "1"
setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock" "1"
setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock" "1"
uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtimelock.bmp")
uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltimelock.bmp")
uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittimelock.bmp")
			uiMoveUU.bitmap = (openBitMap "..\Icons\\ats_moveUUn.bmp")
			uiMoveDD.bitmap = (openBitMap "..\Icons\\ats_moveDDn.bmp")
			uiMoveU.bitmap = (openBitMap "..\Icons\\ats_moveUn.bmp")
			uiMoveD.bitmap = (openBitMap "..\Icons\\ats_moveDn.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax" "true"
		)else(
			saveAniTime_Rollout.height=260
			if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLockD") == "0" do(
				uiAddtime.bitmap = (openBitMap "..\Icons\\ats_addtime.bmp")
				setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "AddLock" "0"
			)
			if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLockD") == "0" do(
				uiDeltime.bitmap = (openBitMap "..\Icons\\ats_deltime.bmp")
				setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "DelLock" "0"
			)
			if (getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLockD") == "0" do(
				uiEdittime.bitmap = (openBitMap "..\Icons\\ats_edittime.bmp")
				setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock" "0"
			)
			uiMoveUU.bitmap = (openBitMap "..\Icons\\ats_moveUU.bmp")
			uiMoveDD.bitmap = (openBitMap "..\Icons\\ats_moveDownD.bmp")
			uiMoveU.bitmap = (openBitMap "..\Icons\\ats_moveU.bmp")
			uiMoveD.bitmap = (openBitMap "..\Icons\\ats_moveD.bmp")
			setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "uiMinMax" "false"
		)
	)
	
	on saveAniTime_Rollout moved pos do(
		setinisetting "$maxScripts\\custom_prefs.ini" "saveTimeInterface" "uiX" ((pos.x as integer)as string)
		setinisetting "$maxScripts\\custom_prefs.ini" "saveTimeInterface" "uiY" ((pos.y as integer)as string)
	)
	on saveAniTime_Rollout open do(
		SAT_reload()
		registerRedrawViewsCallback SAT_reload
		saveAllItemCount = getinisetting "$maxScripts\\saveAniTimeTmp.ini" "AniSave" "saveAllDllcount" as integer
		if saveAllItemCount>0 then(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_loadh.bmp")
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_editl.bmp")
			uiDel.bitmap = (openBitMap "..\Icons\\ats_dell.bmp")
		)else(
			uiLoad.bitmap = (openBitMap "..\Icons\\ats_load.bmp")
			uiEdit.bitmap = (openBitMap "..\Icons\\ats_edit.bmp")
			uiDel.bitmap = (openBitMap "..\Icons\\ats_del.bmp")
		)
	)
	on saveAniTime_Rollout close do(
		unRegisterRedrawViewsCallback SAT_reload
	)
	on cbx1 selected item do(
		setINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "PLAYS" "false"
		uiPlay.bitmap = (openBitMap "..\Icons\\ats_play.bmp")
		stopAnimation()
		saveItemSel()
		-- uiEditLock = getINISetting "$maxScripts\\custom_prefs.ini" "atsInterface" "EditLock"
		-- if uiEditLock == "0" do(
			-- if maxfilepath != "" do(
				-- fileName = filterString maxfilename "."
				-- sTime = filterString (getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" (item as string)) "-()/"
				-- if sTime[2] != undefined do(
					-- startT = sTime[2]as integer
					-- endT = sTime[3]as integer
					-- animationRange = interval startT endT
				-- )
			-- )
		-- )
	)
	on cbx1 doubleClicked item do(
		if maxfilepath != "" then(
			fileName = filterString maxfilename "."
			sTime = filterString (getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" (item as string)) "-()/"
			if sTime[2] != undefined do(
				startT = sTime[2]as integer
				endT = sTime[3]as integer
				animationRange = interval startT endT
			)
		)else(messagebox "请先保存场景或打开一个场景！" title:"SaveAniTime")
	)

)



-- if kkk == "101000101110101010111111000000101011110101010111010100010" then(
createdialog saveAniTime_Rollout pos:[uiX,uiY] fgcolor:(color 190 20 30)
 )else(
 	createdialog kkkRollout
 )