--本地化初始设置
-- Include "E:\BoBOAHK\Vimdesktop\custom\maxScripts\lib\setEvn.ms"
-- if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" "E:\\BoBOAHK\\Vimdesktop\\custom\\maxScripts" 
-- symbolicPaths.setUserPathValue "$maxScripts" "E:\\BoBOAHK\\Vimdesktop\\custom\\maxScripts"
-- symbolicPaths.expandFileName "$maxScripts\\total_commander.ini"

startTi = timeStamp()
if render8Rollout != undefined do destroydialog render8Rollout
try (if render8Rollout.loading_rol != undefined do destroydialog render8Rollout.loading_rol)catch()
if addSetRollout != undefined do destroyDialog addSetRollout
global RENDPIC,UIx
global SRView,RENDERDIRED,RENDERDIRSAVE1,RENDERDIRSAVE2,RENDERDIRSAVE3,RENDERDIRSAVE4,RENDERDIRSAVE5,RENDERDIRSAVE6,RENDERDIRSAVE7,RENDERDIRSAVE8, OUTPUTDIRED,OUTPUTDIR1,OUTPUTDIR2,OUTPUTDIR3,OUTPUTDIR4,OUTPUTDIR5,OUTPUTDIR6,OUTPUTDIR7,OUTPUTDIR8
global GETACT,FINDSUBDIRS,FILETYPESEL,GAPVAL, Ssave,ESsave,Esave,ENsave,Nsave,WNsave,Wsave,WSsave,Osave,CUTsave,DCHKS
global BITNUM,ZEROsave,CHANAMES,SUBDIRCHICK,SELFRAME 
-- global UPUP = ::r8dfn.UPyes()

function loadSet = (
	DCHKS = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DCHKSAVE" )
	GETACT = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GETACT" )
	FINDSUBDIRS = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FINDSUBDIR" )
	ZEROsave = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ZEROsave" )
	SUBDIRCHICK = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "subDirChk" )
	SELFRAME = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "selFrameChk" )
)
loadSet ()
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN")=="" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN" "1"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN" )=="" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN"  "2"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN"   )=="" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN"   "3"

CHANAMES = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CHARACTERNAME"

BITNUM = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "BITNUM" as integer
UIx = execute(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ui")
if UIx == OK or UIx.x > sysinfo.desktopSize.x or UIx.y > sysinfo.desktopSize.y or UIx.x < -100 or UIx.y < 0 do
(UIx = [100,100]
setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ui" "[100,100]"
)
maxwSize = getMAXWindowSize()
if UIx.y > (maxwSize.y-370) do UIx.y = (maxwSize.y-370)
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TYPESEL") != "" then
	FILETYPESEL = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TYPESEL" as integer
else
	FILETYPESEL = 1
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GAPVAL") != "" then
	GAPVAL = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GAPVAL" as integer
else
	GAPVAL = 1
----=========DirectionText save==================
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Ssave") != "" then
	Ssave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Ssave"
else
	Ssave = "S"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ESsave") != "" then
	ESsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ESsave"
else
	ESsave = "ES"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Esave") != "" then
	Esave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Esave"
else
	Esave = "E"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ENsave") != "" then
	ENsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ENsave"
else
	ENsave = "EN"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Nsave") != "" then
	Nsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Nsave"
else
	Nsave = "N"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WNsave") != "" then
	WNsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WNsave"
else
	WNsave = "WN"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Wsave") != "" then
	Wsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Wsave"
else
	Wsave = "W"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WSsave") != "" then
	WSsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WSsave"
else
	WSsave = "WS"
	--------------------------
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Osave") != "" then
	Osave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Osave"
else
	Osave = "C"
	--------------------------
CUTsave = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUT"


----=============================================
::r8dfn.LoadSceneVal()
---------------------------------------------------------------------
-- DIR save
fn GetOutput = (
	RENDERDIRED = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_text"
	OUTPUTDIRED = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_text"
)
GetOutput()

rollout addSetRollout "Add Global Set" width:150 height:100
(
	label lbl1 "Name:" pos:[6,11] width:29 height:16
	editText edt1 "" pos:[34,8] width:100 height:17
	button btn1 "Add R8D Set" pos:[32,62] width:87 height:23
	label lbl2 "Exist:" pos:[10,35] width:26 height:16
	dropDownList ddl1 "" pos:[38,32] width:96 height:20

	fn Addr8dSet SetNa = (
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "DEGREE" (render8Rollout.glDegree_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "HEIGHT" (render8Rollout.glHeight_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SCALE" (render8Rollout.glScale_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "FOV" (render8Rollout.glFOV_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "RWIDTH" (render8Rollout.RW_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "RHEIGHT" (render8Rollout.RH_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "ORT" (render8Rollout.ortho_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "N"  (render8Rollout.N.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "S"  (render8Rollout.S.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "W"  (render8Rollout.W.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "E"  (render8Rollout.E.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "WN" (render8Rollout.WN.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "WS" (render8Rollout.WS.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "EN" (render8Rollout.EN.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "ES" (render8Rollout.ES.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "O" (render8Rollout.O.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "S_CDN"  render8Rollout.S_CDN .text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "ES_CDN" render8Rollout.ES_CDN.text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "E_CDN"  render8Rollout.E_CDN .text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "EN_CDN" render8Rollout.EN_CDN.text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "N_CDN"  render8Rollout.N_CDN .text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "WN_CDN" render8Rollout.WN_CDN.text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "W_CDN"  render8Rollout.W_CDN .text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "WS_CDN" render8Rollout.WS_CDN.text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "O_CDN"  render8Rollout.O_CDN.text
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "FGAP_PR" (render8Rollout.frameGap_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "GAPCnt_PR" (render8Rollout.FG_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "CUTsave" (render8Rollout.cut_edt.text)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "ZERO" (render8Rollout.zero_cbt.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "COUNTN" (render8Rollout.bit_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "CUSNAME" (render8Rollout.bitCount.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SCENAME" (render8Rollout.useSce_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "ANINAME" (render8Rollout.useAct_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SSNAME" (render8Rollout.useSSN_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "DIRNAME" (render8Rollout.useDir_chk.checked as string)
		
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "aSET" (render8Rollout.aSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "jSET" (render8Rollout.jSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "bSET" (render8Rollout.bSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cSET" (render8Rollout.cSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "iSET" (render8Rollout.iSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "kSET" (render8Rollout.kSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "eSET" (render8Rollout.eSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "fSET" (render8Rollout.fSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "gSET" (render8Rollout.gSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "hSET" (render8Rollout.hSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "skSET" (render8Rollout.skSeting.checked as string)
		
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_S_" (render8Rollout.Deg_S_spn.value  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_ES" (render8Rollout.Deg_ES_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_E_" (render8Rollout.Deg_E_spn.value  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_EN" (render8Rollout.Deg_EN_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_N_" (render8Rollout.Deg_N_spn.value  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_WN" (render8Rollout.Deg_WN_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_W_" (render8Rollout.Deg_W_spn.value  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_WS" (render8Rollout.Deg_WS_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "Deg_O"  (render8Rollout.Deg_O_spn.value as string)
		
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_S_" (render8Rollout.S_btn .checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_ES" (render8Rollout.ES_btn.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_E_" (render8Rollout.E_btn .checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_EN" (render8Rollout.EN_btn.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_N_" (render8Rollout.N_btn .checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_WN" (render8Rollout.WN_btn.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_W_" (render8Rollout.W_btn .checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_WS" (render8Rollout.WS_btn.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "cDeg_O"  (render8Rollout.O_btn.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "GLOB_CAM"  (render8Rollout.glob_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "GLOB_SIZE"  (render8Rollout.gloSize_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SORT_SC1"  (render8Rollout.Sc1.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SORT_AN2"  (render8Rollout.An2.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SORT_SS3"  (render8Rollout.Ss3.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SORT_DI4"  (render8Rollout.Di4.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SetSomeDeger"  (render8Rollout.someDig.value as string)
		
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "CCF" (render8Rollout.ccF.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "UPF" (render8Rollout.fff.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SCEF" (render8Rollout.scF.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "AniFo" (render8Rollout.anF.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SSF" (render8Rollout.sF.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "DIRF" (render8Rollout.diF.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SCESPN" (render8Rollout.scSpn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "ANISPN" (render8Rollout.anSpn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "SSSPN" (render8Rollout.sSpn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "CURDIRCBN" (render8Rollout.curDir_cbn.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" SetNa "CURDIREDT" render8Rollout.curDir_edt.text
		setNum=(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount")as integer + 1
		isSame = "No"
		if setNum > 1 then(
			setS = 1
			for sn = 1 to setNum do(
				lname = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (sn as string)
				if SetNa == lname do(
					delInisetting  "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (sn as string)
					setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (setS as string) SetNa
					isSame = "Yes"
				)
				setS += 1
			)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount" ((setNum-1) as string)
		)
		if isSame == "No" do(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount" (setNum as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (setNum as string) SetNa
		)
	)
	-----------------------------
	on addSetRollout open do(
		ddl1.items = render8Rollout.getSetSaveTolbx()
	)
	on ddl1 selected indx do(
		edt1.text = ddl1.items[indx]
	)
	on btn1 pressed do(
		if edt1.text != "" then(
			Addr8dSet edt1.text
			render8Rollout.lbx1.items = render8Rollout.getSetSaveTolbx()
			destroyDialog addSetRollout
		if (render8Rollout.getSetSaveTolbx()).count > 0 then render8Rollout.delGLSet_btn.enabled = true else render8Rollout.delGLSet_btn.enabled = false
		)else(destroyDialog addSetRollout)
	)
)
-------Render Set----------------

rollout singleR_rollout "预览渲染设置" width:311 height:72
(
	radioButtons rdo1 "选择保存路径" pos:[29,9] width:110 height:30 labels:#("max文件路径", "指定输出路径") default:1 columns:2
	editText edt2 "" pos:[15,45] width:279 height:17 enabled:false
	fn loadset = (
		if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH") == "" do setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH" "1"
		rdoSet = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH") as integer
		rdo1.state = rdoSet
		SRs=(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH") as integer
		if SRs > 1 then edt2.text = render8Rollout.outDir_edt.text else edt2.text = ""
	)
	on singleR_rollout open do(
		loadset()
	)
	on rdo1 changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH" (state as string)
		if state == 1 then edt2.text = "" else edt2.text = render8Rollout.outDir_edt.text
	)
)
rollout openSet_rollout "打开场景设置" width:164 height:51
(
	checkbox openSet_chk "提示保存" pos:[28,17] width:111 height:19
	on openSet_rollout open do(
		openSet_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OFset" "SAVEMSG")
	)
	on openSet_chk changed state do
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OFset" "SAVEMSG" (state as string)
)
------
	global rOUTHIS=#(),rINHIS=#()
	TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT") as integer
	if TC>0 do(
	for i =1 to TC do(
		itm=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" ("TYP_"+(i as string))
		append rOUTHIS itm
	)
	append rOUTHIS "--清除历史--"
	)
	inTC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT") as integer
	if inTC>0 do(
	for i =1 to inTC do(
		itm=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" ("TYP_"+(i as string))
		append rINHIS itm
	)
	append rINHIS "--清除历史--"
	)
-------Render Set---end----------------
global UIVer=("cici-R8D v"+::r8dStart.VVV)
rollout render8Rollout UIVer width:500 height:370
(
	imgTag ATS_img "" bitmap:(openBitMap "$maxScripts\oxTOOLSfiles\Icons\ox_SAT_16i.bmp") pos:[3,88] toolTip:"AniTimeSave（多动作帧范围记录工具）"
on ATS_img mouseover do(
	ATS_img.bitmap = (openBitMap "$maxScripts\oxTOOLSfiles\Icons\ox_AT_16o.bmp")
)
on ATS_img mouseout do(
	ATS_img.bitmap = (openBitMap "$maxScripts\oxTOOLSfiles\Icons\ox_SAT_16i.bmp")
)
on ATS_img click do(
	if StartATS do(
		try(filein (symbolicPaths.expandFileName "$maxScripts\\oxT_saveAniTime.ms"))catch(filein (symbolicPaths.expandFileName "$maxScripts\\oxT_saveAniTime.mse")) --调用saveAniTime.
		--try(filein (getdir "$maxScripts\oxT_saveAniTime.ms"))catch(filein (getdir "#maxScripts"+"\oxT_saveAniTime.mse"))
		StartATS = false
	)
uiX = execute (getinisetting "$maxScripts\custom_prefs.ini" "saveTimeInterface" "uiXY")
if uiX.x > sysinfo.desktopSize.x or uiX.y > sysinfo.desktopSize.y or uiX.x < -100 or uiX.y < 0 do
(uiX = [100,100]
setinisetting "$maxScripts\custom_prefs.ini" "saveTimeInterface" "uiXY" "[100,100]"
)
	createdialog ::oxAniTS.oxATS pos:uiX style:#(#style_SysMenu, #style_ToolWindow)
)
	local dragMode = false
	local prevMousePos = [0,0]
	spinner Deg_S_spn  pos:[0,-50]
	spinner Deg_ES_spn pos:[0,-50]
	spinner Deg_E_spn  pos:[0,-50]
	spinner Deg_EN_spn pos:[0,-50]
	spinner Deg_N_spn  pos:[0,-50]
	spinner Deg_WN_spn pos:[0,-50]
	spinner Deg_W_spn  pos:[0,-50]
	spinner Deg_WS_spn pos:[0,-50]
	spinner Deg_O_spn pos:[0,-50]
	checkbox ccF ""	pos:[0,-50]-- pos:[323,385]
	checkbox fff ""	pos:[0,-50]-- pos:[353,385]
	checkbox scF ""	pos:[0,-50]-- pos:[383,385]
	checkbox anF ""	pos:[0,-50]-- pos:[413,385]
	checkbox sF "" 	pos:[0,-50]-- pos:[443,385]
	checkbox diF ""	pos:[0,-50]-- pos:[473,385]
	spinner scSpn range:[1,3,1] type:#integer pos:[0,-50]
	spinner anSpn range:[1,3,2] type:#integer pos:[0,-50]
	spinner sSpn range:[1,3,3] type:#integer  pos:[0,-50]
	edittext rps_txt "" pos:[0,-50]
	edittext S_CDN  "" visible:false
	edittext ES_CDN "" visible:false
	edittext E_CDN  "" visible:false
	edittext EN_CDN "" visible:false
	edittext N_CDN  "" visible:false
	edittext WN_CDN "" visible:false
	edittext W_CDN  "" visible:false
	edittext WS_CDN "" visible:false
	edittext O_CDN "" visible:false
	label info "右键菜单" pos:[2,246] height:18 enabled:false
	checkbox autoOff "自动关机" pos:[0,226] width:67 toolTip:"渲染完成后2分钟自动关机"
	label helpline "\n                                                操 作 时 这 里 会 显 示 各 种 功 能 的 简 介" pos:[5,372] Width:490 height:45 readonly:false visible:false style_sunkenedge:true
	-- button UPdat "★"  pos:[5,233] width:18 height:18 tooltip:"★有新版本，查看更新信息" visible:UPUP
	spinner glDegree_spn "" pos:[7,17] width:50 height:16 range:[-60,90,::r8dfn.DEGREE as float]
	spinner glHeight_spn "" pos:[62,17] width:50 height:16 range:[-1000,1000,::r8dfn.GLOBHEIGHT as float] scale:0.01
	spinner glScale_spn "" pos:[118,17] width:50 height:16 range:[0.01,80000,::r8dfn.GLOBSCALE as float] scale:0.1
	spinner glFOV_spn "" pos:[173,17] width:50 height:16 range:[0.5,175,::r8dfn.GLFOV as float]
	label lbl1 "角度" pos:[11,0] width:36 height:16
	label lbl2 "高度" pos:[67,0] width:35 height:16
	label lbl3 "缩放" pos:[124,0] width:34 height:16
	label lbl4 "广角" pos:[179,0] width:34 height:16
	fn cam_filt obj = classof obj == Targetcamera
	pickButton getCusCam "- None -" tooltip:"拾取一个目标摄相机 Target \\ RMB: 去除拾取的像机" pos:[149,40] width:80 height:16 filter:cam_filt
	button reCam_btn "Re" pos:[211,57] width:18 height:18 tooltip:"恢复相机初始位置和设置 \\ RMB: 设置当前相机为初始状态" border:false enabled:false
	checkbutton useDummyRot_btn "Du" pos:[90,125] width:18 height:18 tooltip:"（未使用）使用自定虚拟体替代相机旋转显示标示"
	editText useDummyName "" pos:[0,-50]
	
	imgTag glDeg_bmp pos:[7,34] width:220 height:6 bitmap:(bitmap 40 8 color: (color 15 150 110)) visible:false
	imgTag glWH_bmp pos:[7,360] width:40 height:6 bitmap:(bitmap 40 8 color: (color 228 200 11)) visible:false
	imgTag glOrt_bmp pos:[228,20] width:60 height:6 bitmap:(bitmap 80 8 color: (color 15 150 110)) visible:false
	checkbox ortho_chk "无透视" pos:[228,4] width:60
	checkbox glob_chk "相机" pos:[2,42] width:55 tooltip:"批量渲染时以当前设置自动创建R8D相机"
	checkbox gloSize_chk "尺寸" pos:[60,42] width:55 tooltip:"批量渲染时应用相同尺寸"
	checkbutton HHH_cbt "<" pos:[2,62] width:19 height:22 tooltip:"打开辅助功能窗口" highlightColor:(color 200 40 232)
	checkButton SAVE_btn "预设" pos:[234,29] width:30 height:20 highlightColor:(color 75 110 255) tooltip:"R8D工具设置导入导出及运用\\右键保存设置到文件"
	button addGLSet_btn "AD" pos:[243,50] width:18 height:16 tooltip:"直接添加当前设置到预设" visible:false border:false
	button delGLSet_btn "DE" pos:[243,67] width:18 height:16 tooltip:"删除预设里选中的" visible:false border:false
	button loadGLSet_btn "lo" pos:[243,84] width:18 height:18 tooltip:"导入.r8d设置文件到预设" visible:false border:false
	button expGLSet_btn "ex" pos:[243,103] width:18 height:17 tooltip:"导出设置到.r8d文件" visible:false border:false
	dropDownList unit_ddl "" pos:[362,2] width:85 height:22 items: #(#Inches, #Feet, #Miles, #Millimeters, #Centimeters, #Meters, #Kilometers)
	-- button createC "8像机" pos:[291,2] width:36 height:20 tooltip:"创建8方向摄像机 \\ 右键删除像机"
	button createT "摄像机" pos:[291,2] width:50 height:20 tooltip:"创建R8D相机 \\ 右键删除R8D相机"
	imgTag cOK_bmp pos:[344,2] width:10 height:20 bitmap:(bitmap 10 20 color:red) visible:false
	button refresh_btn "刷新" pos:[449,2] width:46
	imgTag cameraSep pos:[0,37] width:229 height:2 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag cameraSep2 pos:[227,24] width:2 height:13 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag cameraSep3 pos:[228,24] width:131 height:2 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag cameraSep4 pos:[357,0] width:2 height:24 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag SetSep pos:[0,319] width:500 height:2 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag SetSep1 pos:[129,321] width:2 height:47 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag SetSep2 pos:[184,321] width:2 height:47 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag SetSep3 pos:[312,321] width:2 height:47 bitmap:(bitmap 8 8 color: (color 1 1 1))
	imgTag SetSep4 pos:[0,367] width:186 height:1 bitmap:(bitmap 8 8 color: (color 1 1 1)) visible:false
	imgTag SetSep5 pos:[314,367] width:186 height:1 bitmap:(bitmap 8 8 color: (color 1 1 1)) visible:false
	
	checkButton S_btn "S" pos:[116,195] width:26 height:26 highlightColor:(color 224 67 67)
	checkButton ES_btn "ES" pos:[178,167] width:26 height:26 highlightColor:(color 224 130 67)
	checkButton E_btn "E" pos:[208,119] width:26 height:26 highlightColor:(color 224 206 43)
	checkButton EN_btn "EN" pos:[178,71] width:26 height:26 highlightColor:(color 137 224 43)
	checkButton N_btn "N" pos:[116,43] width:26 height:26 highlightColor:(color 43 224 140)
	checkButton WN_btn "WN" pos:[55,71] width:26 height:26 highlightColor:(color 43 158 224)
	checkButton W_btn "W" pos:[26,119] width:26 height:26 highlightColor:(color 43 85 224)
	checkButton WS_btn "WS" pos:[55,167] width:26 height:26 highlightColor:(color 127 43 224)
	checkButton O_btn "C" pos:[70,216] width:26 height:26 highlightColor:(color 127 120 255)
	editText S "" text:Ssave pos:[99,222] width:60 height:16 bold:true enabled:false
	editText ES "" text:ESsave pos:[161,194] width:60 height:16 bold:true enabled:false
	editText E "" text:Esave pos:[195,146] width:60 height:16 bold:true enabled:false
	editText EN "" text:ENsave pos:[161,98] width:60 height:16 bold:true enabled:false
	editText N "" text:Nsave pos:[99,70] width:60 height:16 bold:true enabled:false
	editText WN "" text:WNsave pos:[38,98] width:60 height:16 bold:true enabled:false
	editText W "" text:Wsave pos:[5,146] width:60 height:16 bold:true enabled:false
	editText WS "" text:WSsave pos:[38,194] width:60 height:16 bold:true enabled:false
	editText O "" text:Osave pos:[50,243] width:60 height:16 bold:true enabled:false
	spinner someDig "" pos:[104,98] width:50 range:[-40,40,0] tooltip:"相机微偏参数"
	checkbutton All_chkbtn "All" pos:[114,118] width:30 height:26 highlightColor:(color 250 250 250) tooltip:"选择全部"
	imgTag r8info "" bitmap:(openBitMap "$maxScripts\\r8d_Info.bmp") transparent:(color 255 0 255) pos:[70,123] tooltip:"渲染报告查询"
	label maxVer "Max 文件版本" pos:[102,146] width:95 height:16
	checkButton gamma_lbl "Gamma" width:42 height:17 pos:[87,162] highlightColor:(color 240 220 50) tooltip:"激活按钮批量渲染时会对每个文档应用设置 \n(不支持Max2008以下版本!)"
	spinner gamma_spn "" pos:[130,162] width:40 range:[0.01,5,2.2] scale:0.01
	label qian_lbl "↓" pos:[124,181]
	
	spinner RW_spn "" pos:[7,324] width:50 height:16 type:#integer range:[2,24096,renderWidth]
	spinner RH_spn "" pos:[7,343] width:50 height:16 type:#integer range:[2,24096,renderHeight]
	spinner Aspect_spn "" pos:[75,333] width:50 height:16 type: #float range:[0.001,1000,(renderWidth/renderHeight as float)] scale:0.001
	label aspect_lbl "图像比例" pos:[77,351] width:50 height:16
	checkButton lockAspect_btn "L" pos:[61,333] width:12 height:16 checked:true tooltip:"锁定渲染长宽比例"
	
	multilistBox lbx1 "" pos:[265,28] width:229 height:17
	button setOutDir_btn "输出路径.." pos:[5,296] width:68 height:20 tooltip:"选择渲染输出目录\\右键打开文件夹"
	editText outDir_edt "" text:OUTPUTDIRED pos:[72,297] width:293 height:17
	dropDownList outDir_ddl "" pos:[367,296] width:35 height:16 items:rOUTHIS
	imgTag l_bmp pos:[403,297] width:8 height:18 bitmap:(bitmap 12 20 color:red) visible:false
	label maxCount ".max:0" pos:[350,256] width:60 height:16 align:#right
	button loadFi_btn "打开场景 ^" pos:[421,255] width:72 height:18 tooltip:"打开选中的场景"
	button setDir_btn "渲染路径.." pos:[5,275] width:68 height:20 tooltip:"选择批量渲染目录\\右键打开文件夹"
	editText renderDir_edt "" text:RENDERDIRED pos:[72,277] width:293 height:17
	dropDownList renderDir_ddl "" pos:[367,275] width:35 height:16 items:rINHIS
	imgTag r_bmp pos:[403,276] width:8 height:18 bitmap:(bitmap 12 20 color:red) visible:false

	editText cut_edt "" text:CUTsave pos:[190,345] width:22
	checkbutton zero_cbt "0" pos:[194,325] width:16 height:16 checked:ZEROsave tooltip:"起始编号从零开始"
	checkbutton bitCount "" pos:[213,323] width:94 height:18 tooltip:"激活自定义命名输出图"
	spinner bit_spn "" pos:[217,344] width:32 range:[1,10,BITNUM] type:#integer
	checkbutton getani_chk "" pos:[421,276] width:72 height:18 checked: GETACT tooltip:"按钮显示|批量渲染|读取渲染路径里的MAX进行批量渲染；\n激活按钮显示|当前渲染|渲染当前场景"
	checkbutton curDir_cbn "源" pos:[416,297] width:18 height:18 highlightColor: (color 70 150 202) tooltip:"渲染图存放到源路径,右边输入渲染目录名称(留空则不创建渲染目录)"
	edittext curDir_edt "" text:"" pos:[432,297] width:61 height:17
	checkbox subdir_chk "含子目录" pos:[265,257] width:72 checked: SUBDIRCHICK--FINDSUBDIRS
	checkbox rself_chk "" pos:[317,324] width:15 checked: SELFRAME tooltip:"统一挑帧（勾选时所有场景都运用相同的统一挑帧参数）"
	button chose_btn "挑帧设置" pos:[333,323] width:86 height:17 tooltip:"打开挑帧设置"
	-- imgTag cho_img pos:[393,323] width:8 height:16 bitmap: (bitmap 10 20 color: (color 175 63 63)) visible:false tooltip:"显示挑帧范围"
	checkbox getSS_chk "挑选分块>" pos:[425,324] width:74 checked: false toolTip:"激活时挑选分块进行渲染（|批量渲染|当前渲染|都有效）"
	button rSingle_btn "> 预览渲染 ^" pos:[317,341] width:76 height:25 tooltip:"批量预览渲染(用于渲染预览图或场景批量渲染)"
	button renderDir_btn ">>> START <<<" pos:[396,341] width:100 height:25
	checkbox frameGap_chk "隔帧" pos:[135,325] width:45 checked: false
	spinner FG_spn "" pos:[134,345] width:40 type:#integer range:[1,100,1] enabled: false
	dropDownList fileType_ddl "" pos:[253,345] width:54 height:22 items: #(".png",".tga",".dds",".jpg",".tif",".rla") selection: FILETYPESEL
	checkbox useCha_chk "角色名" pos:[80,368]  visible:false
	checkbox useSce_chk "场景名" pos:[183,368] visible:false
	checkbox useAct_chk "动作名" pos:[264,368] visible:false
	checkbox useSSN_chk "分块名" pos:[345,368] visible:false
	checkbox useDir_chk "方向名" pos:[426,368] visible:false
	spinner Sc1 "" pos:[198,384] width:30 range:[1,4,1] type:#integer
	spinner An2 "" pos:[279,384] width:30 range:[1,4,2] type:#integer
	spinner Ss3 "" pos:[360,384] width:30 range:[1,4,3] type:#integer
	spinner Di4 "" pos:[441,384] width:30 range:[1,4,4] type:#integer
	checkbox overSave_chk "" pos:[345,368] visible:false
	editText useCha_edt "" text:CHANAMES pos:[75,383] visible:false width:100 height:14 bold:true
	label cusname_lbl "自定命名:" pos:[12,377] visible:false
	
	button hideSS_btn 	"S \\ H"	pos:[500,4] width:30 tooltip:"显示\\隐藏组"
	button createSS_btn 	"{.+}"		pos:[533,4] width:30 tooltip:"创建分块\\右键: 所选物体批量创建分块"
	button deleteSS_btn 	"{.-}"		pos:[566,4] width:30 tooltip:"删除分块"
	button openSSW_btn 	"{...}"	pos:[599,4] width:30 tooltip:"打开选择组编辑窗"
	button addMsk_btn "+" pos:[631,1] width:14 height:13 tooltip:"为选择的分块添加带遮罩后缀的物体"
	button delMsk_btn "-" pos:[631,15] width:14 height:13 tooltip:"去除选择的分块的遮罩物体"
	button makeMask_btn "遮罩" pos:[647,4] width:30 tooltip:"对选择的物体进行遮罩设置 +ctrl: 遮罩接收阴影 \\右键还原上次操作(并去除遮罩物体标记)"
	multilistBox ssList_lbx "" pos:[499,28] width:178 height:17 visible:false
	multilistBox ssObjList_lbx "" pos:[499,257] width:178 height:6 visible:false
	button hideUnSS_btn "隐藏其它" pos:[501,345] width:60 tooltip:"隐藏其它未分块的物体"
	button showUnSS_btn "显示其它" pos:[563,345] width:60 tooltip:"显示其它未分块的物体"
	checkbutton useColorSet_chk "rps" width:30 height:14 highlightColor: (color 30 160 82) pos:[130,243] tooltip:"批量渲染时运用渲染预设\\右键渲染预设菜单"
	label rps_tv "" pos:[162,260]
	label SScount_lbl "SS:" pos:[630,349] width:40
		checkbox aSeting "" pos:[164,225] width:11 tooltip:"强制双面"
		checkbox bSeting "" pos:[181,225] width:11 tooltip:"隐藏骨骼"
		checkbox cSeting "" pos:[198,225] width:11 tooltip:"灯光旋转"
		checkbox kSeting "" pos:[215,225] width:11 tooltip:"去除头帧"
		checkbox iSeting "" pos:[232,225] width:11 tooltip:"去除尾帧"
		checkbox jSeting "" pos:[249,225] width:11 tooltip:"单帧输出 (激活时自动保存场景将不可用)"
		checkbox eSeting "" pos:[164,240] width:11 tooltip:"分块渲染"
		checkbox fSeting "" pos:[181,240] width:11 tooltip:"分块相互遮罩"
		checkbox gSeting "" pos:[198,240] width:11 tooltip:"遮罩接收阴影"
		checkbox hSeting "" pos:[215,240] width:11 tooltip:"隐藏未分块"
	   checkbox skSeting "" pos:[232,240] width:11 tooltip:"渲染挑帧"
	fn CSSetR8D ii = (
		SSL = (::r8dui.r8ui.ssList_lbx.selection as array)
		if SSL.count > 0 do(
		if ::r8dui.r8ui.ssList_lbx.items[ii] != undefined do(
			nn = filterstring ::r8dui.r8ui.ssList_lbx.items[ii] " -"
			selectionSets[nn[1]] = selection
			clearSelection()
		)
			::r8dfn.FindSelSet()
			::r8dfn.FindSSitem()
		)
	)
	fn DelSelSet =(
		SSL = (::r8dui.r8ui.ssList_lbx.selection as array)
		if SSL.count > 0 do(
			deleteItem selectionSets selectionSets[SSL[1]].name
			::r8dfn.FindSelSet()
		)
	)
	fn SelDoubChkSS ii =(
		clearSelection()
		ss=(::r8dui.r8ui.ssList_lbx.selection as array)
		if ss.count > 0 do(
			Ass = #()
			for o in ss do(
				os=getNamedSelSetItemCount o
				for i in 1 to os do(
					append Ass (getNamedSelSetItem o i)
				)
			)
			select Ass
		)
	)
	fn readR8File =(
		aboutFile = openFile ("$maxScripts\R8Dinfo.txt") mode:#rt
		if aboutFile != undefined then(
			fileText = readDelimitedString aboutFile "~"
			close aboutFile
			fileText
		)else(
			return "..."
		)
	)
	function AboutR8info =
	(
		try(destroyDialog rollout_R8Dabout)catch()
		
		rollout rollout_R8Dabout "R8D 渲染报告查询" width:500 height:780
		(
			dotnetcontrol aboutTextbox "System.Windows.Forms.RichTextBox" width:(rollout_R8Dabout.width - 10) height:(rollout_R8Dabout.height - 10) align:#left pos:[5,5]
			
			on rollout_R8Dabout open do
			(
				aboutText = (" 自动化八方向渲染工具 R8D v" + RVers + "   渲染报告：\n" + readR8File())
				aboutTextbox.multiline = true
				aboutTextbox.wordwrap = true
				aboutTextbox.ReadOnly = true
				aboutTextbox.DetectUrls = false
				aboutTextbox.BackColor = (dotNetClass "System.Drawing.Color").FromArgb 20 21 20
				aboutTextbox.ForeColor = (dotNetClass "System.Drawing.Color").FromArgb 20 250 50
				aboutTextbox.BorderStyle = none
				aboutTextbox.text = aboutText
			)
		)
		createDialog rollout_R8Dabout	
	)
	on r8info mouseover do (r8info.bitmap = (openBitMap "$maxScripts\\r8d_Info_o.bmp"))
	on r8info mouseout do (r8info.bitmap = (openBitMap "$maxScripts\\r8d_Info.bmp"))
	on r8info click do(
		AboutR8info()
	)
---------------------------------
	-- on UPdat pressed do(
	rollout CCBox_rol "创建模型分块" width:235 height:82
	(local MASKS
		label lbl1 "分块名称:" pos:[13,8] width:64 height:15
		edittext edt1 "" pos:[72,7] width:125 height:17
		dropDownList ddl1 "" pos:[76,34] width:121 height:22
		button btn1 "OK" pos:[204,7] width:25 height:49
		checkbox useMsk_chk "添加遮罩物体" pos:[14,60]
		label maskC_lbl "" pos:[170,60] height:15
		fn CSSet = (
			if selection.count > 0 and edt1.text != "" then(
				selectionSets[edt1.text] = selection
				destroyDialog CCBox_rol
				::r8dfn.FindSelSet()
				::r8dfn.FindSSitem()
			)else(messagebox "请选择一些要创建选择组的物体并输入选择组名称！" title:"Create Select Set")
		)
		fn SelMarkO =(
			for o in objects do if (getUserProp o "00x_mask") == true do selectmore o
		)
		fn FindMaskCount =(
			MASKS = 0
			for o in objects do (
				if (getUserProp o "00x_mask") == true do MASKS += 1
			)
			return MASKS
		)
		on useMsk_chk changed state do
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "SELSET" "USEMASK" (state as string)
		on CCBox_rol open do(
			useMsk_chk.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "SELSET" "USEMASK")
			SSs=getNumNamedSelSets()
			aSet=selectionSets
			SelSets=#()
			for i =1 to SSs do(
				append SelSets aSet[i].name
			)
			ddl1.items = SelSets
			maskC_lbl.text = ("(有 "+FindMaskCount() as string+" 个遮罩物体)")
		)
		on btn1 pressed do (
			if useMsk_chk.checked then(
				SelMarkO()
				CSSet()
			)else( CSSet() )
		)
		on ddl1 selected item do(
			edt1.text=ddl1.items[item]
		)
	)
----------------------------------------
	fn Setseting = (
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER" (ccF.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN" (fff.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" (scF.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN" (anF.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN" (sF.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN" (diF.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN" (scSpn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN" (anSpn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN" (sSpn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEUNSSOBJ" (hSeting.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING" (skSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "RSS_SET"     (eSeting.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHK"   (fSeting.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHKCS" (gSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DOUBLESIDE"  (aSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SINGLEFRAME"  (jSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELENDF"     (iSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELFISTF"     (kSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEBONE"    (bSeting.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTROT"    (cSeting.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTOMRDcbn" (curDir_cbn.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTOMRD" curDir_edt.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "S_CDNsave"	 S_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ES_CDNsave" ES_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "E_CDNsave"  E_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "EN_CDNsave" EN_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "N_CDNsave"  N_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WN_CDNsave" WN_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "W_CDNsave"  W_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WS_CDNsave" WS_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "O_CDNsave" O_CDN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_" (Deg_S_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES" (Deg_ES_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_" (Deg_E_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN" (Deg_EN_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_" (Deg_N_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN" (Deg_WN_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_" (Deg_W_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS" (Deg_WS_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O" (Deg_O_spn.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FRAMEGAP" (frameGap_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GAPVAL" (FG_spn.value as string)
	)
	fn getMaxV = (
		if fileProperties.findProperty #contents "Headers" > 0 then(
			a = fileproperties.getPropertyValue #contents (fileProperties.findProperty #contents "Headers")
			b = fileProperties.getItems a[1]
			dd=filterstring b[b.count] ": "
			ddd=filterstring dd[dd.count] "."
			if maxVer.text != ::r8dfn.getVersion ddd[1] do maxVer.text = ::r8dfn.getVersion ddd[1]
		)else(maxVer.text = "Max ????")
		if (maxVersion())[1] >= 10000 then(
		if (IDisplayGamma.colorCorrectionMode == #gamma) then(
		gamma_lbl.text = "Gamma"
		try(if gamma_spn.value != IDisplayGamma.gamma do gamma_spn.value = IDisplayGamma.gamma)catch(
			gamma_spn.enabled = true
		)
		)else gamma_spn.enabled = false
		if (IDisplayGamma.colorCorrectionMode == #LUT) do gamma_lbl.text = "LUT"
		if (IDisplayGamma.colorCorrectionMode == #none) do gamma_lbl.text = "-Off-"
		)else(
			gamma_spn.enabled = false
			gamma_lbl.enabled = false
			gamma_lbl.checked = false
		)
	local IPC = openbitmap "$maxScripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp"
	if useDummyName.text != "输入虚拟体名称" then (
	if (getnodebyname useDummyName.text) != undefined then(
		useDummyRot_btn.images = #(IPC,IPC,32,19,19,19,19)
		useDummyRot_btn.tooltip=("（已使用）名称为："+useDummyName.text)
	)else(useDummyRot_btn.images = #(IPC,IPC,32,21,21,21,21)
	useDummyRot_btn.tooltip="（未使用）物体不存在"
	)
	)else( useDummyRot_btn.images = #(IPC,IPC,32,21,21,21,21)
	useDummyRot_btn.tooltip="（未使用）使用自定虚拟体替代相机旋转显示标示")
	)
	on gamma_spn changed val do(
		try(IDisplayGamma.gamma = val)catch()
	)
	on gamma_lbl changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "PSET" "GammaAct" (state as string)
	)
	--保存、读取全局设置函数--------
	global SetName,Deg,Hei,Sca,Fov,RWid,RHei,Ort,UUU,DDD,LLL,RRR,UL,DL,UR,DR,OT,CUTS,ZEROB,CUNNUM, cusNam,sceNam,aniNam,ssNam,dirNam
	global aSET,bSET,cSET,iSET,kSET,eSET,fSET,gSET,hSET ,selK, CCCF,UPF,SCEF,ANIF,SSF,DIRF,SCESPN,ANISPN,SSSPN,CURDCBN,CURDEDT,jSET
	global S_CDNs , ES_CDNs, E_CDNs , EN_CDNs, N_CDNs , WN_CDNs, W_CDNs , WS_CDNs, O_CDNs, FGAP, GAPCount
	global DD_S, DD_ES, DD_E, DD_EN, DD_N, DD_WN, DD_W, DD_WS, DD_O, cDD_S, cDD_ES, cDD_E, cDD_EN, cDD_N, cDD_WN, cDD_W, cDD_WS, cDD_O, glo_Cam, glo_Size, SET_N1, SET_N2, SET_N3, SET_N4, SOMEDIGR
	fn saveGlobalSet = (
		psE = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "PSET" "PSEXP"
		saveSet = getsavefilename caption:"保存R8D全局设置" filename:psE types:"R8D(*.r8d)|*.r8d|All|*.*|"
		if saveSet != undefined do(
		if (not (doesfileexist saveSet)) then(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "PSET" "PSEXP" saveSet
			fName = filterString saveSet "\\"
			fNnoTyp = filterString fName[fName.count] "."
			f = createFile saveSet
			format "%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%\t%" ("\""+fNnoTyp[1]+"\"") glDegree_spn.value glHeight_spn.value glScale_spn.value glFOV_spn.value RW_spn.value RH_spn.value ("\""+(ortho_chk.checked)as string+"\"") ("\""+N.text+"\"") ("\""+S.text+"\"") ("\""+W.text+"\"") ("\""+E.text+"\"") ("\""+WN.text+"\"") ("\""+WS.text+"\"") ("\""+O.text+"\"") ("\""+EN.text+"\"") ("\""+ES.text+"\"") ("\""+cut_edt.text+"\"") ("\""+(zero_cbt.checked)as string+"\"") bit_spn.value ("\""+(bitCount.checked)as string+"\"") ("\""+(useSce_chk.checked)as string+"\"") ("\""+(useAct_chk.checked)as string+"\"") ("\""+(useSSN_chk.checked)as string+"\"") ("\""+(useDir_chk.checked)as string+"\"") \
			("\""+(aSeting.checked)as string+"\"") ("\""+(bSeting.checked)as string+"\"") ("\""+(cSeting.checked)as string+"\"") ("\""+(iSeting.checked)as string+"\"") ("\""+(eSeting.checked)as string+"\"") ("\""+(fSeting.checked)as string+"\"") ("\""+(gSeting.checked)as string+"\"") ("\""+(hSeting.checked)as string+"\"") ("\""+(ccF.checked)as string+"\"") ("\""+(fff.checked)as string+"\"") ("\""+(scF.checked)as string+"\"") ("\""+(anF.checked)as string+"\"") ("\""+(sF.checked)as string+"\"") ("\""+(diF.checked)as string+"\"") scSpn.value anSpn.value sSpn.value ("\""+(curDir_cbn.checked)as string+"\"") ("\""+(curDir_edt.text)as string+"\"") ("\""+(S_CDN.text)as string+"\"") ("\""+(ES_CDN.text)as string+"\"") ("\""+(E_CDN.text)as string+"\"") ("\""+(EN_CDN.text)as string+"\"") ("\""+(N_CDN.text)as string+"\"") ("\""+(WN_CDN.text)as string+"\"") ("\""+(W_CDN.text)as string+"\"") ("\""+(WS_CDN.text)as string+"\"") ("\""+(O_CDN.text)as string+"\"") ("\""+(frameGap_chk.checked)as string+"\"") FG_spn.value Deg_S_spn.value Deg_ES_spn.value Deg_E_spn.value Deg_EN_spn.value Deg_N_spn.value Deg_WN_spn.value Deg_W_spn.value Deg_WS_spn.value Deg_O_spn.value ("\""+(S_btn.checked)as string+"\"") ("\""+(ES_btn.checked)as string+"\"") ("\""+(E_btn.checked)as string+"\"") ("\""+(EN_btn.checked)as string+"\"") ("\""+(N_btn.checked)as string+"\"") ("\""+(WN_btn.checked)as string+"\"") ("\""+(W_btn.checked)as string+"\"") ("\""+(WS_btn.checked)as string+"\"") ("\""+(O_btn.checked)as string+"\"") ("\""+(jSeting.checked)as string+"\"") ("\""+(glob_chk.checked)as string+"\"") ("\""+(gloSize_chk.checked)as string+"\"") ("\""+(Sc1.value)as string+"\"") ("\""+(An2.value)as string+"\"") ("\""+(Ss3.value)as string+"\"") ("\""+(Di4.value)as string+"\"") ("\""+(someDig.value)as string+"\"") ("\""+(kSeting.checked)as string+"\"") ("\""+(skSeting.checked)as string+"\"") to:f
			close f
		)else(messagebox "文件不能替换！" beep: true title:"R8D")
		)
	)
	fn loadGlobalSet = (
		psL = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "PSET" "PSLOAD"
		loadSet = getOpenFileName caption:"读取R8D全局设置" filename:psL types:"R8D(*.r8d)|*.r8d|All|*.*|"
		if loadSet != undefined then(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "PSET" "PSLOAD" loadSet
		f = openfile loadSet
	if f != undefined then (
		try(
			(SetName=readvalue f); (Deg=readvalue f); (Hei=readvalue f); (Sca=readvalue f); (Fov=readvalue f); (RWid=readvalue f); (RHei=readvalue f); (Ort=readvalue f); (UUU=readvalue f); (DDD=readvalue f); (LLL=readvalue f); (RRR=readvalue f); (UL=readvalue f); (DL=readvalue f); (OT=readvalue f); (UR=readvalue f); (DR=readvalue f); (CUTS=readvalue f); (ZEROB=readvalue f); (CUNNUM=readvalue f); (cusNam=readvalue f); (sceNam=readvalue f); (aniNam=readvalue f); (ssNam=readvalue f); (dirNam=readvalue f); 
			(aSET=readvalue f); (bSET=readvalue f); (cSET=readvalue f); (iSET=readvalue f); (eSET=readvalue f); (fSET=readvalue f); (gSET=readvalue f); (hSET=readvalue f); (CCCF=readvalue f); (UPF=readvalue f); (SCEF=readvalue f); (ANIF = readvalue f); (SSF = readvalue f); (DIRF=readvalue f); (SCESPN=readvalue f); (ANISPN=readvalue f); (SSSPN=readvalue f); (CURDCBN=readvalue f); (CURDEDT=readvalue f); (S_CDNs=readvalue f); (ES_CDNs=readvalue f); (E_CDNs=readvalue f); (EN_CDNs=readvalue f); (N_CDNs=readvalue f); (WN_CDNs=readvalue f); (W_CDNs=readvalue f); (WS_CDNs=readvalue f); (O_CDNs=readvalue f); (FGAP=readvalue f); (GAPCount=readvalue f); (DD_S=readvalue f); (DD_ES=readvalue f); (DD_E=readvalue f); (DD_EN=readvalue f); (DD_N=readvalue f); (DD_WN=readvalue f); (DD_W=readvalue f); (DD_WS=readvalue f); (DD_O=readvalue f); (cDD_S=readvalue f); (cDD_ES=readvalue f); (cDD_E=readvalue f); (cDD_EN=readvalue f); (cDD_N=readvalue f); (cDD_WN=readvalue f); (cDD_W=readvalue f); (cDD_WS=readvalue f); (cDD_O=readvalue f); (jSET=readvalue f); (glo_Cam=readvalue f); (glo_Size=readvalue f); (SET_N1=readvalue f); (SET_N2=readvalue f); (SET_N3=readvalue f); (SET_N4=readvalue f); (SOMEDIGR=readvalue f); (kSET=readvalue f); (selK=readvalue f)
			close f
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "DEGREE" (Deg as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "HEIGHT" (Hei as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SCALE" (Sca as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "FOV" (Fov as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "RWIDTH" (RWid as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "RHEIGHT" (RHei as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "ORT" (Ort as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "N" (UUU)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "S" (DDD)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "W" (LLL)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "E" (RRR)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "WN" (UL)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "WS" (DL)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "EN" (UR)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "ES" (DR)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "O" (OT)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "CUTsave" (CUTS)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "ZERO" (ZEROB)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "COUNTN" (CUNNUM as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "CUSNAME" (cusNam)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SCENAME" (sceNam)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "ANINAME" (aniNam)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SSNAME" (ssNam)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "DIRNAME" (dirNam)
			
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "aSET" (aSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "jSET" (jSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "bSET" (bSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cSET" (cSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "iSET" (iSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "kSET" (kSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "eSET" (eSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "fSET" (fSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "gSET" (gSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "hSET" (hSET)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "skSET" (selK)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "CCF" (CCCF)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "UPF" (UPF)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SCEF" (SCEF)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "AniFo" (ANIF)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SSF" (SSF)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "DIRF" (DIRF)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SCESPN" (SCESPN as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "ANISPN" (ANISPN as string)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SSSPN" (SSSPN as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "CURDIRCBN" CURDCBN
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "CURDIREDT" CURDEDT
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "S_CDN"  S_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "ES_CDN" ES_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "E_CDN"  E_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "EN_CDN" EN_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "N_CDN"  N_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "WN_CDN" WN_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "W_CDN"  W_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "WS_CDN" WS_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "O_CDN" O_CDNs
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "FGAP_PR" FGAP
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "GAPCnt_PR" (GAPCount as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_S_" (DD_S  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_ES" (DD_ES as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_E_" (DD_E  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_EN" (DD_EN as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_N_" (DD_N  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_WN" (DD_WN as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_W_" (DD_W  as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_WS" (DD_WS as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "Deg_O"  (DD_O as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_S_" cDD_S 
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_ES" cDD_ES
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_E_" cDD_E 
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_EN" cDD_EN
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_N_" cDD_N 
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_WN" cDD_WN
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_W_" cDD_W 
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_WS" cDD_WS
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "cDeg_O"  cDD_O
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "GLOB_CAM" glo_Cam
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "GLOB_SIZE" glo_Size
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SORT_SC1" SET_N1
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SORT_AN2" SET_N2
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SORT_SS3" SET_N3
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SORT_DI4" SET_N4
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" SetName "SetSomeDeger" SOMEDIGR
		
			setNum=(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount")as integer + 1
			isSame = "No"
			if setNum > 1 then(
				setS = 1
				for sn = 1 to setNum do(
					lname = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (sn as string)
					if SetName == lname do(
						delInisetting  "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (sn as string)
						setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (setS as string) SetName
						isSame = "Yes"
					)
					setS += 1
				)
				setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount" ((setNum-1) as string)
			)
			if isSame == "No" do(
				setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount" (setNum as string)
				setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (setNum as string) SetName
			)
		)catch(messagebox "预设文件版本过低！" title:"R8D")
			)
		)
	)--保存、读取全局设置--------END
	--获取记录名称到lbx
	fn getSetSaveTolbx = (
		sCount = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount")as integer
		if sCount > 0 then(
			setS = #()
			for i = 1 to sCount do(
				append setS (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (i as string))
			)
			return setS
		)else(return #())
	)
	fn loadlbxSet = (
		selSetN = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" ((::r8dui.r8ui.lbx1.selection as array)[1]as string)
		if selSetN != "" then(
		glHeight_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "HEIGHT") as float
		glScale_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SCALE") as float
		glFOV_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "FOV") as float
		ortho_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "ORT")
		glob_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "GLOB_CAM" )
		gloSize_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "GLOB_SIZE" )
		Sc1.value = execute (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SORT_SC1" )
		An2.value = execute (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SORT_AN2" )
		Ss3.value = execute (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SORT_SS3" )
		Di4.value = execute (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SORT_DI4" )
		sDig = execute (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SetSomeDeger")
		someDig.value = sDig
setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1" (Sc1.value as string)
setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2" (An2.value as string)
setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3" (Ss3.value as string)
setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4" (Di4.value as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "GLO_SIZE" (gloSize_chk.checked as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "GLO_CAM" (glob_chk.checked as string)
		if glob_chk.checked then
			glOrt_bmp.visible = glDeg_bmp.visible = true
		else
			glOrt_bmp.visible = glDeg_bmp.visible = false
		if gloSize_chk.checked then
	     glWH_bmp.visible = true
		else
	     glWH_bmp.visible = false
		fileProperties.addProperty #custom "R8D_CustemCameraScale" glScale_spn.value
			local Deg = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "DEGREE") as float
		glDegree_spn.value = Deg
		if (fileProperties.findProperty #custom "glDegreeSave") > 0 then(
			degre = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "glDegreeSave")
		)else(
			degre = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X"
		)
		if $AllCamera != undefined and $S != undefined then(
				$AllCamera.pos = [0,0,glHeight_spn.value]
				$AllCamera.scale = [glScale_spn.value,glScale_spn.value,glScale_spn.value]
				for n in ::r8dui.CNAMEs do(
					try (
					(getnodebyname n).FOV = glFOV_spn.value
					(getnodebyname n).orthoProjection = ortho_chk.checked
					) catch ()
				)
			for i = 1 to 8 do(
				DD = getnodebyname ("D_"+i as string)
				rotate DD (angleaxis (45*i) [0,0,1])
				rotate DD (angleaxis (degre as float) [1,0,0])
				rotate DD (angleaxis (-Deg) [1,0,0])
				rotate DD (angleaxis (-45*i) [0,0,1])
			)
		)else(
		if $TagCamera != undefined then(
			::r8dfn.createCCC false
			fileproperties.addProperty #custom "SetViewDeger" 0
			$TagCamera.pos = $S.pos
			$TagCamera.FOV = $S.FOV
			$TagCamera.orthoProjection = $S.orthoProjection
			$TagCamera.Target.pos = $Ccenter.pos
			::r8dfn.DelToolCAM false
		)else(
			camPicked = getnodebyname getCusCam.text
			if camPicked != undefined do(
			camPicked.FOV = glFOV_spn.value
			camPicked.orthoProjection = ortho_chk.checked
	if $R8D_CustemRenderCam == undefined do
		Dummy name:"R8D_CustemRenderCam" ishidden:true isselected:false
	CamTag = getnodebyname (getCusCam.text+".Target")
	if CamTag != undefined do $R8D_CustemRenderCam.pos.z = CamTag.pos.z
	OldAng = ::r8dfn.GetDegrees_B camPicked
	rotate $R8D_CustemRenderCam (angleaxis -OldAng [0,0,1])
	camPicked.parent = $R8D_CustemRenderCam
	execute ("$"+getCusCam.text+"\.Target.parent = $R8D_CustemRenderCam")
	rotate $R8D_CustemRenderCam (angleaxis OldAng [0,0,1])
	rotate $R8D_CustemRenderCam (angleaxis (::r8dfn.GetDegrees camPicked) [1,0,0])
	rotate $R8D_CustemRenderCam (angleaxis (-Deg) [1,0,0])
	rotate $R8D_CustemRenderCam (angleaxis -OldAng [0,0,1])
	try(delete $R8D_CustemRenderCam)catch()
		--Camera Hight
		if $R8D_CustemRenderHight == undefined do
			Dummy name:"R8D_CustemRenderHight" ishidden:true isselected:false
			if CamTag != undefined do ($R8D_CustemRenderHight.pos.z = CamTag.pos.z
			CamTag.parent = $R8D_CustemRenderHight
			)
		camPicked.parent = $R8D_CustemRenderHight
		$R8D_CustemRenderHight.pos.z = glHeight_spn.value
		try(delete $R8D_CustemRenderHight)catch()
		)
		))
		CusCam=getnodebyname getCusCam.text
		if CusCam != undefined do(
			ABC=for o in selection collect o
			Dummy name:"R8D_SVDCam" ishidden:true isselected:false
		CusCam.parent = $R8D_SVDCam
			CamTag = getnodebyname (getCusCam.text+".Target")
		if CamTag != undefined do CamTag.parent = $R8D_SVDCam
	rotate $R8D_SVDCam (angleaxis sDig [0,0,1])
			delete $R8D_SVDCam
			select ABC
			fileproperties.addProperty #custom "SetSomeDeger" sDig
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X" (Deg as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLHEIGHT" (glHeight_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLSCALE" (glScale_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLFOV" (glFOV_spn.value as string)
		RW_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "RWIDTH") as integer
		RH_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "RHEIGHT") as integer
		if maxfilename != "" do(
			fileProperties.addProperty #custom "glDegreeSave" Deg
			fileProperties.addProperty #custom "glHeightSave" glHeight_spn.value
			fileProperties.addProperty #custom "glScaleSave" glScale_spn.value
			fileProperties.addProperty #custom "glFOVSave" glFOV_spn.value
			fileProperties.addProperty #custom "Orthographic" ortho_chk.checked
		)
		N.text	= getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "N"
		S.text	= getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "S"
		W.text	= getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "W"
		E.text	= getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "E"
		WN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "WN"
		WS.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "WS"
		ES.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "ES"
		EN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "EN"
		O.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "O"
		S_CDN.text =  getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "S_CDN" 
		ES_CDN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "ES_CDN"
		E_CDN.text =  getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "E_CDN" 
		EN_CDN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "EN_CDN"
		N_CDN.text =  getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "N_CDN" 
		WN_CDN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "WN_CDN"
		W_CDN.text =  getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "W_CDN" 
		WS_CDN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "WS_CDN"
		O_CDN.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "O_CDN"
		Deg_S_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_S_") as float
		Deg_ES_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_ES") as float
		Deg_E_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_E_") as float
		Deg_EN_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_EN") as float
		Deg_N_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_N_") as float
		Deg_WN_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_WN") as float
		Deg_W_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_W_") as float
		Deg_WS_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_WS") as float
		Deg_O_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_O") as float
		S_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_S_")+"°")
		ES_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_ES")+"°")
		E_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_E_")+"°")
		EN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_EN")+"°")
		N_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_N_")+"°")
		WN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_WN")+"°")
		W_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_W_")+"°")
		WS_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_WS")+"°")
		O_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "Deg_O")+"°")
		S.enabled  = S_btn.checked  = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_S_")
		ES.enabled = ES_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_ES")
		E.enabled  = E_btn.checked  = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_E_")
		EN.enabled = EN_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_EN")
		N.enabled  = N_btn.checked  = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_N_")
		WN.enabled = WN_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_WN")
		W.enabled  = W_btn.checked  = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_W_")
		WS.enabled = WS_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_WS")
		O.enabled  = O_btn.checked  = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_O" )
		if S_btn.checked=false or ES_btn.checked==false or E_btn.checked==false or EN_btn.checked==false or N_btn.checked==false or WN_btn.checked==false or W_btn.checked==false or WS_btn.checked==false do(
			All_chkbtn.checked = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false"
		)
		if S_btn.checked=true and ES_btn.checked==true and E_btn.checked==true and EN_btn.checked==true and N_btn.checked==true and WN_btn.checked==true and W_btn.checked==true and WS_btn.checked==true do(
			All_chkbtn.checked = true
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "true"
		)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_S"  (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_S_")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_ES" (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_ES")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_E"  (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_E_")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_EN" (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_EN")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_N"  (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_N_")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WN" (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_WN")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_W"  (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_W_")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WS" (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_WS")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_O"  (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cDeg_O" )
		FG_spn.enabled = frameGap_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "FGAP_PR")
		FG_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "GAPCnt_PR")as integer
		cut_edt.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "CUTsave"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUT" cut_edt.text
		zero_cbt.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "ZERO")
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ZEROsave" (zero_cbt.checked as string)
		bitCount.checked   = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "CUSNAME")
		Sc1.enabled = useSce_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SCENAME")
		An2.enabled = useAct_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "ANINAME")
		Ss3.enabled = useSSN_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SSNAME" )
		Di4.enabled = useDir_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "DIRNAME")
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SCENECHK" (useSce_chk.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ACTNAMCHK" (useAct_chk.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SSNCHK" (useSSN_chk.checked as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DIRECHK" (useDir_chk.checked as string)
		
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "BITCOUNT" (bitCount.checked as string)
		if bitCount.checked then(
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") then(
				render8Rollout.height = 450
				helpline.pos = [5,402]
			)else(
				render8Rollout.height = 400
			)
			::r8dui.r8ui.useCha_edt.visible = true
			SetSep4.visible = true
			SetSep5.visible = true
			cusname_lbl.visible = true
			useCha_chk.visible = true
			useSce_chk.visible = true
			useAct_chk.visible = true
			useDir_chk.visible = true
			useSSN_chk.visible = true
			Sc1.visible = true
			An2.visible = true
			Ss3.visible = true
			Di4.visible = true
		)else(
			if ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") then(
				render8Rollout.height = 420
				helpline.pos = [5,372]
			)else(
				render8Rollout.height = 370
			)
			SetSep4.visible = false
			SetSep5.visible = false
			useCha_edt.visible = false
			cusname_lbl.visible = false
			useCha_chk.visible = false
			useSce_chk.visible = false
			useAct_chk.visible = false
			useDir_chk.visible = false
			useSSN_chk.visible = false
			Sc1.visible = false
			An2.visible = false
			Ss3.visible = false
			Di4.visible = false
		)
		
		aSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "aSET")
		jSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "jSET")
		bSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "bSET")
		cSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "cSET")
		iSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "iSET")
		kSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "kSET")
		eSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "eSET")
		fSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "fSET")
		gSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "gSET")
		hSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "hSET")
		skSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "skSET")
		
		ccF.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "CCF")
		fff.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "UPF")
		scF.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SCEF")
		anF.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "AniFo")
		sF.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SSF")
		diF.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "DIRF")
		scSpn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SCESPN") as integer
		anSpn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "ANISPN") as integer
		sSpn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "SSSPN") as integer
		curDir_edt.enabled = curDir_cbn.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "CURDIRCBN")
		outDir_edt.enabled = outDir_ddl.enabled = not curDir_cbn.checked
		curDir_edt.text = (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "CURDIREDT")
		
		Setseting()
		if fSeting.checked and eSeting.checked then gSeting.enabled = true else gSeting.enabled = false
		
		if ::r8dfn.r8dsetting.open do(
		::r8dfn.r8dsetting.S_CDN.text =  S_CDN .text
		::r8dfn.r8dsetting.ES_CDN.text = ES_CDN.text
		::r8dfn.r8dsetting.E_CDN.text =  E_CDN .text
		::r8dfn.r8dsetting.EN_CDN.text = EN_CDN.text
		::r8dfn.r8dsetting.N_CDN.text =  N_CDN .text
		::r8dfn.r8dsetting.WN_CDN.text = WN_CDN.text
		::r8dfn.r8dsetting.W_CDN.text =  W_CDN .text
		::r8dfn.r8dsetting.WS_CDN.text = WS_CDN.text
		::r8dfn.r8dsetting.O_CDN.text = O_CDN.text
		::r8dfn.r8dsetting.Degree_S_spn.value	  =Deg_S_spn.value
		::r8dfn.r8dsetting.Degree_ES_spn.value = Deg_ES_spn.value
		::r8dfn.r8dsetting.Degree_E_spn.value	  =Deg_E_spn.value
		::r8dfn.r8dsetting.Degree_EN_spn.value = Deg_EN_spn.value
		::r8dfn.r8dsetting.Degree_N_spn.value	  =Deg_N_spn.value
		::r8dfn.r8dsetting.Degree_WN_spn.value = Deg_WN_spn.value
		::r8dfn.r8dsetting.Degree_W_spn.value	  =Deg_W_spn.value
		::r8dfn.r8dsetting.Degree_WS_spn.value = Deg_WS_spn.value
		::r8dfn.r8dsetting.Degree_O_spn.value = Deg_O_spn.value
		::r8dfn.r8dsetting.rSS_chk.checked = eSeting.checked
		if ::r8dfn.r8dsetting.rSS_chk.checked then(
			::r8dfn.r8dsetting.HideUnSS_chk.enabled = true
			::r8dfn.r8dsetting.SSmask_chk.enabled = true
			if ::r8dfn.r8dsetting.SSmask_chk.checked do ::r8dfn.r8dsetting.SSmaskCS_chk.enabled = true
		)else(
			::r8dfn.r8dsetting.HideUnSS_chk.enabled = false
			::r8dfn.r8dsetting.SSmask_chk.enabled = false
			::r8dfn.r8dsetting.SSmaskCS_chk.enabled = false
		)
		::r8dfn.r8dsetting.SSmask_chk.checked = fSeting.checked
		::r8dfn.r8dsetting.SSmaskCS_chk.checked = gSeting.checked
		if ::r8dfn.r8dsetting.SSmask_chk.checked and ::r8dfn.r8dsetting.rSS_chk.checked then ::r8dfn.r8dsetting.SSmaskCS_chk.enabled = true else ::r8dfn.r8dsetting.SSmaskCS_chk.enabled = false
		::r8dfn.r8dsetting.HideUnSS_chk.checked = hSeting.checked
		::r8dfn.r8dsetting.doubleSide_chk.checked = aSeting.checked
		::r8dfn.r8dsetting.SelK_chk.checked = skSeting.checked
		::r8dfn.r8dsetting.singleFrame_chk.checked = jSeting.checked
		::r8dfn.r8dsetting.hideBone_chk.checked = bSeting.checked
		::r8dfn.r8dsetting.lightRot_chk.checked = cSeting.checked
		if kSeting.checked == false and iSeting.checked == false then
		::r8dfn.r8dsetting.sit.visible = ::r8dfn.r8dsetting.seachN.visible = false
		else
		::r8dfn.r8dsetting.sit.visible = ::r8dfn.r8dsetting.seachN.visible = true
		::r8dfn.r8dsetting.delFF_chk.checked = kSeting.checked
		::r8dfn.r8dsetting.delEF_chk.checked = iSeting.checked
		::r8dfn.r8dsetting.CFolder_chk.checked = ccF.checked
		::r8dfn.r8dsetting.FFF_chk.checked = fff.checked
		::r8dfn.r8dsetting.SceneF_chk.checked = scF.checked
		::r8dfn.r8dsetting.AnimF_chk.checked = anF.checked
		::r8dfn.r8dsetting.SelSetF_chk.checked =sF.checked
		::r8dfn.r8dsetting.DirecF_chk.checked = diF.checked
		::r8dfn.r8dsetting.Scene_spn.value = scSpn.value
		::r8dfn.r8dsetting.Anim_spn.value = anSpn.value
		::r8dfn.r8dsetting.SS_spn.value = sSpn.value
		::r8dfn.r8dsetting.Refresh_Fol ccF.checked
		)
		if eSeting.checked then(
			hSeting.enabled = true
			fSeting.enabled = true
			if fSeting.checked do gSeting.enabled = true
		)else(
			hSeting.enabled = false
			fSeting.enabled = false
			gSeting.enabled = false
		)
		bit_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" selSetN "COUNTN") as integer
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "BITNUM" (bit_spn.value as string)
		bits = ""
		for i in 2 to bit_spn.value do bits = bits+"0"
		if ::r8dui.r8ui.zero_cbt.checked then(
			bitCount.text = (bits+"0"+::r8dui.r8ui.fileType_ddl.selected)
		)else(
			bitCount.text = (bits+"1"+::r8dui.r8ui.fileType_ddl.selected)
		)
		)
		S_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_S")
	)
	fn delGLSet = (
		setCount = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount")as integer
		if setCount > 0 do(
		if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
				all = getSetSaveTolbx()
			for i in lbx1.selection do(
				delN = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (i as string)
				delINISetting "$maxScripts\plugcfg\R8D_prefs.ini" delN
				delINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (i as string)
				deleteitem all (finditem all delN)
			)
			ind = 1
			if all.count > 0 do(
				for o in all do(
					setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" (ind as string) o
					ind += 1
				)
			)
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "GLOBALPPPPP" "SETNAMECount" ((ind-1) as string)
		if (getSetSaveTolbx()).count == 0 do delGLSet_btn.enabled = false
		)else(messagebox "请在右边选择一个要删除的预设" title:"R8D")
		)
	)

	rollout loading_rol "Whating..." width: 200 height: 70(
		label lbl1 "正在读取max文件请稍候..." pos:[30,29] width:180 height:15
	)
	on gamma_lbl rightclick do (popUpMenu ::r8dfn.gamamu)
	on useColorSet_chk changed state do(
		if doesFileExist(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSfileUse") then
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" (state as string)
		else(
			messagebox "请选择一个渲染预设.rps文件" title:"R8D"
			useColorSet_chk.checked = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" "false"
		)
		if HHH_cbt.checked and doesFileExist(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSfileUse") do ::r8dfn.RS_rol.useColorSet_chk.checked = state
	)
	on aSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DOUBLESIDE" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.doubleSide_chk.checked = state
	)
	on skSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.SelK_chk.checked = state
	)
	on jSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SINGLEFRAME" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.singleFrame_chk.checked = state
		if state then(
		::r8dui.r8ui.frameGap_chk.checked = true
		::r8dui.r8ui.FG_spn.value = 2)else(
		::r8dui.r8ui.FG_spn.enabled=::r8dui.r8ui.frameGap_chk.checked = false
		::r8dui.r8ui.FG_spn.value = 1
		)
	)
	on iSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELENDF" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do
		if kSeting.checked then(
		::r8dfn.r8dsetting.sit.visible = ::r8dfn.r8dsetting.seachN.visible = true
		::r8dfn.r8dsetting.delEF_chk.checked = state
		)else
		::r8dfn.r8dsetting.sit.visible = ::r8dfn.r8dsetting.seachN.visible = ::r8dfn.r8dsetting.delEF_chk.checked = state
	)
	on kSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELFISTF" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do
		if iSeting.checked then(
		::r8dfn.r8dsetting.sit.visible = ::r8dfn.r8dsetting.seachN.visible = true
		::r8dfn.r8dsetting.delFF_chk.checked = state
		)else
		::r8dfn.r8dsetting.sit.visible = ::r8dfn.r8dsetting.seachN.visible = ::r8dfn.r8dsetting.delFF_chk.checked = state
	)
	on bSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEBONE" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.hideBone_chk.checked = state
	)
	on cSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTROT" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.lightRot_chk.checked = state
	)
	-------------
	on eSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "RSS_SET" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do(
			::r8dfn.r8dsetting.rSS_chk.checked = state
			::r8dfn.r8dsetting.HideUnSS_chk.enabled = state
			::r8dfn.r8dsetting.SSmask_chk.enabled = state
		)
			hSeting.enabled = state
			fSeting.enabled = state
		if fSeting.checked then(
			if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.SSmaskCS_chk.enabled = state
			gSeting.enabled = state
		)else(
			if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.SSmaskCS_chk.enabled = false
			gSeting.enabled = false
		)
	)
	on fSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHK" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do(
			::r8dfn.r8dsetting.SSmask_chk.checked = state
			::r8dfn.r8dsetting.SSmaskCS_chk.enabled = state
		)
		gSeting.enabled = state
	)
	on gSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHKCS" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.SSmaskCS_chk.checked = state
	)
	on hSeting changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEUNSSOBJ" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dfn.r8dsetting.open do ::r8dfn.r8dsetting.HideUnSS_chk.checked = state
	)
	-- on cho_img mouseover do cho_img.bitmap = (bitmap 10 20 color: (color 245 83 63))
	-- on cho_img mouseout do cho_img.bitmap = (bitmap 10 20 color: (color 175 63 63))

	on ssList_lbx selected item do ::r8dfn.FindSSitem()
	on ssList_lbx doubleclicked item do(
		SelDoubChkSS item
	)
	on chose_btn pressed do(
		rollout selkeyRollout " 挑帧书写格式：(1,3,5-8) = (1,3,5,6,7,8)" width:431 height:40
		(
			editText edt1 "" pos:[3,9] width:317 height:19
			button btn1 "统一\ 写" pos:[326,8] width:50 height:23 toolTip:"读取统一挑帧参数 \ 右键：写入统一挑帧参数"
			button btn2 "读 \ 写" pos:[379,8] width:46 height:23 toolTip:"读取当前场景挑帧参数 \ 右键：写入当前场景挑帧参数"
			on selkeyRollout open do(
	a=""
	for i in 1 to rendPickupFrames.count do a=a+(rendPickupFrames[i] as string)
	if ::r8dui.r8ui.rself_chk.checked then(
			if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK") != "" then
			edt1.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK"
			else(
			edt1.text = a
			))else(
			edt1.text = a
			)
			)
			on btn1 rightclick do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK" edt1.text
			::r8dui.r8ui.chose_btn.tooltip=::r8dui.r8ui.chose_btn.text = edt1.text
			)
			on btn1 pressed do edt1.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK"
			on btn2 pressed do (
	a=""
	for i in 1 to rendPickupFrames.count do a=a+(rendPickupFrames[i] as string)
			edt1.text = a
			)
			on btn2 rightclick do (
				rendPickupFrames = edt1.text
			)
		)
		createdialog selkeyRollout style:#(#style_sysmenu ,#style_ToolWindow)
	)
	on hideSS_btn pressed do(
		ss=(::r8dui.r8ui.ssList_lbx.selection as array)
		if ss.count > 0 do(
			for o in ss do(
				os=getNamedSelSetItemCount o
				for i in 1 to os do(
					Obj=(getNamedSelSetItem o i)
					if Obj.ishidden then
						Obj.ishidden = false
					else
						Obj.ishidden = true
				)
			)
		)
		::r8dfn.FindSelSet()
	)
	on ssObjList_lbx selected item do (
		clearSelection()
		Ass=#()
		for o in ssObjList_lbx.selection do(
			try(append Ass (getnodebyname ssObjList_lbx.items[o]))catch(exit)
		)
		try(select Ass)catch()
	)
	on createSS_btn pressed do createdialog CCBox_rol
	on createSS_btn rightclick do(
		for o in selection do(
		selectionSets[o.name] = o
		)
		::r8dfn.FindSelSet()
		::r8dfn.FindSSitem()
	)
	on deleteSS_btn pressed do DelSelSet()
	on openSSW_btn pressed do macros.run "Edit" "namedSelSets"
	-- on R8DSet_btn pressed do createdialog ::r8dfn.r8dsetting pos:[80,100] style:#(#style_toolwindow)
	on useCha_edt changed text do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CHARACTERNAME" text
	)
	on useCha_chk changed state do(
		::r8dui.r8ui.useCha_edt.enabled = state
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CHARACTERCHK" (state as string)
	)
	fn SetBitCount ff=(
		if ff then(
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") then(
				render8Rollout.height = 450
				helpline.pos = [5,402]
			)else(
				render8Rollout.height = 400
			)
			::r8dui.r8ui.useCha_edt.visible = true
			SetSep4.visible = true
			SetSep5.visible = true
			cusname_lbl.visible = true

			::r8dui.r8ui.useCha_chk.visible = true
			::r8dui.r8ui.useSce_chk.visible = true
			::r8dui.r8ui.useAct_chk.visible = true
			::r8dui.r8ui.useDir_chk.visible = true
			::r8dui.r8ui.useSSN_chk.visible = true
			::r8dui.r8ui.Sc1.visible = true
			::r8dui.r8ui.An2.visible = true
			::r8dui.r8ui.Ss3.visible = true
			::r8dui.r8ui.Di4.visible = true
		)else(
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") then(
				render8Rollout.height = 420
				helpline.pos = [5,372]
			)else(
				render8Rollout.height = 370
			)
			SetSep4.visible = false
			SetSep5.visible = false
			::r8dui.r8ui.useCha_edt.visible = false
			cusname_lbl.visible = false
			::r8dui.r8ui.useCha_chk.visible = false
			::r8dui.r8ui.useSce_chk.visible = false
			::r8dui.r8ui.useAct_chk.visible = false
			::r8dui.r8ui.useDir_chk.visible = false
			::r8dui.r8ui.useSSN_chk.visible = false
			::r8dui.r8ui.Sc1.visible = false
			::r8dui.r8ui.An2.visible = false
			::r8dui.r8ui.Ss3.visible = false
			::r8dui.r8ui.Di4.visible = false
		)
	)
	on bitCount changed state do(
		SetBitCount state
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "BITCOUNT" (state as string)
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text="当运用自定义图片命名按钮激活时渲染出来的图片名会根据 自定命名:里的设置进行命名，但必需激活F按钮，三个选项分别为(场景名 \\ 动作名 \\ 方向名)，当取消勾选时会去除该命名元素。"
	)
	on render8Rollout close do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK" "false"
		-- unRegisterRedrawViewsCallback getMaxV
		if addSetRollout != undefined do destroyDialog addSetRollout
		if ::r8dfn.RR_rol != undefined do destroyDialog ::r8dfn.RR_rol
		if ::r8dfn.RS_rol != undefined do destroyDialog ::r8dfn.RS_rol
		if ::r8dfn.r8dsetting != undefined do destroyDialog ::r8dfn.r8dsetting
	--	::r8dfn.SetDegerView 0
	)
	on getSS_chk changed state do(
		if state then(
			render8Rollout.width = 680
			ssList_lbx.visible = true
			ssObjList_lbx.visible = true
			createSS_btn.visible = true
			deleteSS_btn.visible = true
			openSSW_btn.visible = true
			::r8dfn.FindSelSet()
		)else(
			render8Rollout.width = 500
			::r8dui.r8ui.ssList_lbx.visible = false
			ssObjList_lbx.visible = false
			createSS_btn.visible = false
			deleteSS_btn.visible = false
			openSSW_btn.visible = false
		)
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text="勾选 “挑选分块” 选项可以为场景物体创建选择组（选择模型创建），运用选择组来分块，创建了选择组的模型会分块渲染输出，没有创建选择组的模型则会一直存在（R8Dv3版本在批量渲染时可以挑选分块进行渲染，要先打开一个带分块场景进行挑选，设置里勾选分块(批渲)）"
	)
	------------------------------------------
	on S changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Ssave" text
	on ES changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ESsave" text
	on E changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Esave" text
	on EN changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ENsave" text
	on N changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Nsave" text
	on WN changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WNsave" text
	on W changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Wsave" text
	on WS changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WSsave" text
	on O changed text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Osave" text
	-----------------
	on zero_cbt changed state do(
		bits = ""
		for i in 2 to bit_spn.value do bits = bits+"0"
		if state then(
			bitCount.text = (bits+"0"+::r8dui.r8ui.fileType_ddl.selected)
		)else(
			bitCount.text = (bits+"1"+::r8dui.r8ui.fileType_ddl.selected)
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ZEROsave" (state as string)
	)
	on cut_edt changed text do(
		if text == "*" or text == "<" or text == ">" then(
			messagebox "分隔符不能为：*    <    >" title:"R8D"
			cut_edt.text = "_"
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUT" "_"
		)else(
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUT" text
		)
	)
	on HHH_cbt changed state do(
		if state then(
			px=execute(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ui")
			createdialog ::r8dfn.RS_rol style:#() pos:[px.x-220,px.y+2]
			if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "HHH") == "true" then
				addSubRollout ::r8dfn.RS_rol.rs_SubRollout ::r8dfn.H_rol rolledUp: false
		)else(
			destroyDialog ::r8dfn.RS_rol
		)
	)
	on unit_ddl selected item do(
		units.SystemType = ::r8dfn.SCENEUNIT[item]
	)
	on bit_spn changed val do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "BITNUM" (val as string)
		bits = ""
		for i in 2 to val do bits = bits+"0"
		if ::r8dui.r8ui.zero_cbt.checked then
			bitCount.text = (bits+"0"+::r8dui.r8ui.fileType_ddl.selected)
		else
			bitCount.text = (bits+"1"+::r8dui.r8ui.fileType_ddl.selected)
	)
	on fileType_ddl selected item do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TYPESEL" (item as string)
		bits = ""
		for i in 2 to bit_spn.value do bits = bits+"0"
		if ::r8dui.r8ui.zero_cbt.checked then
			bitCount.text = (bits+"0"+::r8dui.r8ui.fileType_ddl.selected)
		else
			bitCount.text = (bits+"1"+::r8dui.r8ui.fileType_ddl.selected)
	)
	on curDir_edt entered text do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTOMRD" text
	on curDir_cbn changed state do(curDir_edt.enabled = state
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTOMRDcbn" (state as string)
		outDir_edt.enabled = outDir_ddl.enabled = not state
	)
	on useDummyRot_btn changed state do setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "USEDUMMYROT" (state as string)
	on render8Rollout open do(
		overSave_chk.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "OVERSAVE")
	if getani_chk.checked do (glob_chk.enabled = false ; gloSize_chk.enabled = false)
	if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CROTNODE")=="" then useDummyName.text = "输入虚拟体名称"
	else
	useDummyName.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CROTNODE"
	useDummyRot_btn.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "USEDUMMYROT")
	if doesFileExist "$maxScripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp" do (
		local IPC = openbitmap "$maxScripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp"
		addGLSet_btn.images = #(IPC,IPC,32,1,1,2,2)
		delGLSet_btn.images = #(IPC,IPC,32,11,11,12,12)
		loadGLSet_btn.images = #(IPC,IPC,32,5,5,6,6)
		expGLSet_btn.images = #(IPC,IPC,32,7,7,8,8)
		reCam_btn.images = #(IPC,IPC,32,27,27,28,28)
	)
---
		gamma_lbl.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "PSET" "GammaAct")
		All_chkbtn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All")
		S.enabled = S_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_S")
		ES.enabled = ES_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_ES")
		E.enabled = E_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_E" )
		EN.enabled = EN_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_EN")
		N.enabled = N_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_N" )
		WN.enabled = WN_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WN")
		W.enabled = W_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_W" )
		WS.enabled = WS_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WS")
		O.enabled = O_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_O")
---
		S_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "S_CDNsave"
	    ES_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ES_CDNsave"
	    E_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "E_CDNsave"
	    EN_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "EN_CDNsave"
	    N_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "N_CDNsave"
	    WN_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WN_CDNsave"
	    W_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "W_CDNsave"
	    WS_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WS_CDNsave"
	    O_CDN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "O_CDNsave"
		
		Deg_S_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_") as float
		Deg_ES_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES") as float
		Deg_E_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_") as float
		Deg_EN_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN") as float
		Deg_N_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_") as float
		Deg_WN_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN") as float
		Deg_W_spn.value   = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_") as float
		Deg_WS_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS") as float
		Deg_O_spn.value  = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O") as float
		S_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_")+"°")
		ES_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES")+"°")
		E_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_")+"°")
		EN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN")+"°")
		N_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_")+"°")
		WN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN")+"°")
		W_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_")+"°")
		WS_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS")+"°")
		O_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O")+"°")
		
		ccF.checked=::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER")
		fff.checked=::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN")
		scF.checked=::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN")
		anF.checked=::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN")
		sF.checked=::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN")
		diF.checked=::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN")
		hSeting.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEUNSSOBJ")
		eSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "RSS_SET")
		scSpn.value=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN") as integer
		anSpn.value=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN" ) as integer
		sSpn.value=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN"   ) as integer
		if eSeting.checked then(
			hSeting.enabled = true
			fSeting.enabled = true
			if fSeting.checked do gSeting.enabled = true
		)else(
			hSeting.enabled = false
			fSeting.enabled = false
			gSeting.enabled = false
		)
		fSeting.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHK")
		gSeting.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHKCS")
		if fSeting.checked and eSeting.checked then gSeting.enabled = true else gSeting.enabled = false
		aSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DOUBLESIDE")
		skSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING")
		jSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SINGLEFRAME")
		iSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELENDF")
		kSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELFISTF")
		bSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEBONE")
		cSeting.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTROT")
		curDir_edt.enabled = curDir_cbn.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTOMRDcbn")
		outDir_edt.enabled = outDir_ddl.enabled = not curDir_cbn.checked
		curDir_edt.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTOMRD"
		if GETACT then(
			getani_chk.text = "| 当前渲染 |"
		)else(
			getani_chk.text = "| 批量渲染 |"
		)
		::r8dfn.LoadSceneVal()
		if ::r8dfn.DEGREE != undefined do
			glDegree_spn.value=::r8dfn.DEGREE as float
		if ::r8dfn.GLOBHEIGHT != undefined do
			glHeight_spn.value=::r8dfn.GLOBHEIGHT as float
		if ::r8dfn.GLOBSCALE != undefined do
			glScale_spn.value=::r8dfn.GLOBSCALE as float
		if ::r8dfn.GLFOV != undefined do
			glFOV_spn.value=::r8dfn.GLFOV as float
		bits = ""
		for i in 2 to bit_spn.value do bits = bits+"0"
		if ::r8dui.r8ui.zero_cbt.checked then
			bitCount.text = (bits+"0"+::r8dui.r8ui.fileType_ddl.selected)
		else
			bitCount.text = (bits+"1"+::r8dui.r8ui.fileType_ddl.selected)
		RW_spn.value = renderWidth
		RH_spn.value = renderHeight
		Aspect_spn.value = (renderWidth / renderHeight as float)
		if getani_chk.checked then(
			rSingle_btn.enabled = false
			::r8dfn.getAni()
			skSeting.checked = false
			skSeting.enabled = false
		)else(
			rSingle_btn.enabled = true
			skSeting.enabled = true
			skSeting.checked = ::r8dfn.ConvertToBool(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING")
			::r8dfn.getMaxNum()
		)
		::r8dui.r8ui.useCha_chk.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CHARACTERCHK")
		if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN")!="true" then ::r8dui.r8ui.useSce_chk.checked = true else ::r8dui.r8ui.useSce_chk.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SCENECHK")
		if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN")!="true" then ::r8dui.r8ui.useAct_chk.checked = true else ::r8dui.r8ui.useAct_chk.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ACTNAMCHK")
		if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN")!="true" then ::r8dui.r8ui.useSSN_chk.checked = true else ::r8dui.r8ui.useSSN_chk.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SSNCHK")
		if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN")!="true" then ::r8dui.r8ui.useDir_chk.checked = true else ::r8dui.r8ui.useDir_chk.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DIRECHK")

		if not useSce_chk.checked do Sc1.enabled = false
		if not useAct_chk.checked do An2.enabled = false
		if not useSSN_chk.checked do Ss3.enabled = false
		if not useDir_chk.checked do Di4.enabled = false

		if (fileProperties.findProperty #custom "SetSomeDeger") > 0 do someDig.value=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "SetSomeDeger")
Sc1.value = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1")
An2.value = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2")
Ss3.value = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3")
Di4.value = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4")
		lSel=execute(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "FILESEL")
		if lSel != OK do lbx1.selection = lSel
		
		useColorSet_chk.checked = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" )
		if (not doesFileExist(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSfileUse")) then(
			useColorSet_chk.checked = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" "false"
		)else(
			rps_txt.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSfileUse"
			useColorSet_chk.tooltip = ("批量渲染时自动运用渲染预设\n"+rps_txt.text)
			rps_tv.text = ("[ "+(getFilenamefile rps_txt.text)+".rps ]")
		)
		frameGap_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FRAMEGAP")
		if frameGap_chk.checked do (FG_spn.enabled=true ; FG_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GAPVAL") as integer)
		if jSeting.checked then(
		frameGap_chk.checked = true
		FG_spn.value = 2)else(
		FG_spn.enabled=frameGap_chk.checked = false
		FG_spn.value = 1
		)
		bitCount.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "BITCOUNT")
		glob_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "GLO_CAM")
		gloSize_chk.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "GLO_SIZE")
		if glob_chk.checked do
			glOrt_bmp.visible = glDeg_bmp.visible = true
		if gloSize_chk.checked do
			glWH_bmp.visible = true
		SetBitCount bitCount.checked
		if $AllCamera != undefined and $S != undefined do try(ortho_chk.checked = $S.orthoProjection)catch()
		-- registerRedrawViewsCallback getMaxV
		getMaxV()
		::r8dfn.isCameraOk()
		keey = ::r8dfn.getkkkk()
		-- if keey != (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "kkk") do(
		-- 	chose_btn.enabled = false
		-- 	getSS_chk.checked = false
		-- 	getSS_chk.enabled = false
		-- 	rSingle_btn.enabled = false
		-- 	render8Rollout.title = (UIVer+" [未注册]")
		-- 	renderDir_btn.text = ">>渲染试用<<"
		-- 	All_chkbtn.enabled = All_chkbtn.checked = false
		-- 	E_btn.enabled = E_btn.checked = false
		-- 	EN_btn.enabled = EN_btn.checked = false
		-- 	N_btn.enabled = N_btn.checked = false
		-- 	WN_btn.enabled = WN_btn.checked = false
		-- 	W_btn.enabled = W_btn.checked = false
		-- 	WS_btn.enabled = WS_btn.checked = false
		-- 	O_btn.enabled = O_btn.checked = false
		-- )
		if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK") != "" then chose_btn.tooltip=chose_btn.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK"
	)
	on render8Rollout moved pos do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ui" (pos as string)
		if ::r8dfn.RS_rol != undefined do setDialogPos ::r8dfn.RS_rol [pos.x-220,pos.y+2]
	)
	on render8Rollout rButtondown pos do ( popUpMenu ::r8dfn.r8dmenu)
	
	on Sc1 changed val do(
		oldV = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1")
		if An2.value == val do(An2.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2" (oldV as string)
		)
		if Ss3.value == val do(Ss3.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3" (oldV as string)
		)
		if Di4.value == val do(Di4.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4" (oldV as string)
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1" (val as string)
	)
	on An2 changed val do(
		oldV = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2")
		if Sc1.value == val do(Sc1.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1" (oldV as string)
		)
		if Ss3.value == val do(Ss3.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3" (oldV as string)
		)
		if Di4.value == val do(Di4.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4" (oldV as string)
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2" (val as string)
	)
	on Ss3 changed val do(
		oldV = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3")
		if Sc1.value == val do(Sc1.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1" (oldV as string)
		)
		if An2.value == val do(An2.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2" (oldV as string)
		)
		if Di4.value == val do(Di4.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4" (oldV as string)
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3" (val as string)
	)
	on Di4 changed val do(
		oldV = execute (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4")
		if Sc1.value == val do(Sc1.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1" (oldV as string)
		)
		if An2.value == val do(An2.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2" (oldV as string)
		)
		if Ss3.value == val do(Ss3.value=oldV
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3" (oldV as string)
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4" (val as string)
	)
	
	on useColorSet_chk rightclick do ( popUpMenu ::r8dfn.rpsmenu)
	fn isInTitle pos = (
		--upper left corner
		local tpUL = [0, 0]--[titleGrp.pos.x,titleGrp.pos.y+6] 
		--lower right corner
		local tpLR = [render8Rollout.width, render8Rollout.height]--[titleGrp.pos.x+titleGrp.width-1,titleGrp.pos.y+titleGrp.height-1] 
		pos.x>=tpUL.x AND pos.y>=tpUL.y AND pos.x<=tpLR.x AND pos.y<=tpLR.y
	)
	on render8Rollout lButtonDown pos do (
		if (render8Rollout.dialogBar == false) then --判断窗口是否嵌入界面
		(
			dragMode = isInTitle pos
			if dragMode then
			(
				setSysCur #move
				prevMousePos = pos
			)
		)
	)
	on render8Rollout lButtonUp pos do dragMode = false
	on render8Rollout mouseMove pos do (
		if dragMode then 
		(
			newPos = ((getDialogPos render8Rollout)+(pos-prevMousePos))
			setDialogPos render8Rollout newPos
		)
	)
	on makeMask_btn pressed do ::r8dfn.SetOBJMasker CShadow:keyboard.controlpressed
	on makeMask_btn rightclick do ::r8dfn.ResetSSmask()
	on addMsk_btn pressed do(
		ss=(::r8dui.r8ui.ssList_lbx.selection as array)
		if ss.count > 0 do(
		for i in ss do(
			SelDoubChkSS i
			for o in objects do if (getUserProp o "00x_mask") == true do selectmore o
			CSSetR8D i
		))
	)
	on delMsk_btn pressed do(
		ss=(::r8dui.r8ui.ssList_lbx.selection as array)
		if ss.count > 0 do(
		for o in ss do(
			SelDoubChkSS o
			os = getNamedSelSetItemCount o
			for i in 1 to os do(
				iname=(getNamedSelSetItem o i)
				if (getUserProp iname "00x_mask") == true do deselect iname
			)
			CSSetR8D o
		))
	)
	on loadFi_btn rightclick do(
		if openSet_rollout != undefined do destroyDialog openSet_rollout
		createdialog openSet_rollout
	)
	on loadFi_btn pressed do(
		if getani_chk.checked then(
			messagebox "请点击 |当前渲染| 按钮，变为 |批量渲染|，以读取max文件。" title:"R8D"
		)else(
			if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
			-- if (::r8dfn.isDirectoryExist renderDir_edt.text) then(
			try(
			isSaveCur = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OFset" "SAVEMSG")
			if isSaveCur do
				if (querybox "打开新场景当前场景将不会保存，是否现在保存当前场景？" title:"R8D") then (max file save)
				if (querybox "确定要打开此场景吗？" title:"R8D") do(
			if subdir_chk.checked then(
				::r8dfn.RmFiles = #()
				::r8dfn.findSubDir_FN renderDir_edt.text
				Sta = 0
				for o in ::r8dui.r8ui.lbx1.selection do(
					if ::r8dfn.RmFiles[o] == "***" then Sta += 1
				)
				if Sta == 0 then files = ::r8dfn.RmFiles else(
					messagebox "不要选中带[+]的文件夹！" title:"R8D"
					files = #()
				)
			)else(
				files = getFiles (renderDir_edt.text+"\\*.max")
			)
			if files.count > 0 then(
			SELs=(::r8dui.r8ui.lbx1.selection as array).count
			if SELs == 1 then(
				if (loadMaxFile files[(::r8dui.r8ui.lbx1.selection as array)[1]] useFileUnits:true quiet:true) then (
		----打开文档更新渲染参数
		if HHH_cbt.checked do(
			::r8dfn.RS_rol.refreshRS()
		)
		----打开文档更新渲染参数--END
		if ::r8dui.r8ui.getSS_chk.checked do ::r8dfn.FindSelSet()
		::r8dfn.LoadSceneVal()
		if ::r8dfn.DEGREE != undefined do
			glDegree_spn.value=::r8dfn.DEGREE as float
		if ::r8dfn.GLOBHEIGHT != undefined do
			glHeight_spn.value=::r8dfn.GLOBHEIGHT as float
		if ::r8dfn.GLOBSCALE != undefined do
			glScale_spn.value=::r8dfn.GLOBSCALE as float
		if ::r8dfn.GLFOV != undefined do
			glFOV_spn.value=::r8dfn.GLFOV as float
								::r8dfn.isCameraOk()
								getMaxV()
								RH_spn.value = renderHeight
								RW_spn.value = renderWidth
								Aspect_spn.value = (RW_spn.value / RH_spn.value as float)
								if saveAniTime_Rollout != undefined do saveAniTime_Rollout.SAT_reload()
							) else (messagebox "该模型可能是较高版本的!" title:"R8D")
						)else(messagebox "必需且只能选择一个max文件进行打开。" title:"R8D")
					)
				)--querybox
			)catch(messagebox "请指定正确的渲染路径..目录。" title:"R8D")
			)else(messagebox "请选择要打开的文件。" title:"R8D")
		)
	)
	on frameGap_chk changed state do (
		if state then(
			FG_spn.enabled = true
			FG_spn.value = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GAPVAL") as integer
		)else(
			FG_spn.value = 1
			FG_spn.enabled = false
		)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FRAMEGAP" (state as string)
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 隔帧 勾选时将应用其下面的值进行搓帧渲染,注意值不能大于要渲染的帧数. 如要渲染单帧可以设置时间栏为0到1,搓帧值设为2,即可单帧输出."
	)
	on FG_spn changed val do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GAPVAL" (val as string)
	)
	fn GetAniFN sta =(
		if sta then(
			getani_chk.text = "| 当前渲染 |"
			rSingle_btn.enabled = false
			skSeting.checked = false
			skSeting.enabled = false
			::r8dfn.r8dsetting.SelK_chk.enabled = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GETACT" "true"
			::r8dfn.getAni()
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" “当前渲染” 激活时用于渲染当前打开的场景,如果有创建动作时间记录将只渲染选择的动作,没有时间记录则渲染当前时间栏的所有帧. (可以配合另一个脚本工具AniTimes进行动作时间记录的添加删除编辑等操作.)  AniTimes工具下载地址链接在About里"

		)else(
			getani_chk.text = "| 批量渲染 |"
			keey = ::r8dfn.getkkkk()
			if keey == (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "kkk") do rSingle_btn.enabled = true
			skSeting.enabled = true
			::r8dfn.r8dsetting.SelK_chk.enabled = true
			skSeting.checked = ::r8dfn.ConvertToBool(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING")
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GETACT" "false"
			::r8dfn.getMaxNum()
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" “当前渲染” 取消时用于渲染 （渲染路径..）下的max文件,右边列表将列出目录下的所有max文件, 注意: 如果不勾选UseGlobal应用全局设置,每个max文件都要创建像机并设置好渲染长宽等参数,会根据每个场景不同的设置进行渲染."
			if ::r8dui.r8ui.bitCount.checked do(

			if lbx1.items.count > 0 do(
				::r8dui.r8ui.useAct_chk.visible = true
			)
			)
		)
		SAVE_btn.checked = false
		addGLSet_btn.visible = false
		loadGLSet_btn.visible = false
		expGLSet_btn.visible = false
		delGLSet_btn.visible = false
	)
	on getani_chk changed state do(
		GetAniFN state
		glob_chk.enabled = not state
		gloSize_chk.enabled = not state
	)
	on subdir_chk changed state do(
		if subdir_chk.checked and (filterString renderDir_edt.text "\\").count < 2 then (messagebox "勾选[查子目录]不要指定根目录盘符，否则会使MAX超负！" title:"R8D: 设置批量渲染路径"
		subdir_chk.checked = false
		)else(
		if getani_chk.checked then(
			::r8dfn.getAni()
		)
		::r8dfn.getMaxNum()
		if subdir_chk.checked then(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FINDSUBDIR" "true"
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "subDirChk" "true"
		)else(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FINDSUBDIR" "false"
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "subDirChk" "false"
		)
		SAVE_btn.checked = false
		addGLSet_btn.visible = false
		loadGLSet_btn.visible = false
		expGLSet_btn.visible = false
		delGLSet_btn.visible = false
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" “子文件夹” 勾选时列表中将显示渲染目录..下所有子目录下的max文件. 需要在 “渲染当前” 未勾选时才能显示!"
	))
	on rself_chk changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "selFrameChk" (state as string)
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text="勾选“挑帧渲染”将会渲染有创建挑帧节点的所有挑帧，取消该选项则不管有无挑帧节点都不会渲染挑帧，用“挑帧”按钮来创建或选择挑帧节点，在时间栏复制编辑挑帧，关键帧所在处就是挑选的要渲染的帧。注意：有带动作记录的场景则会优先渲染动作记录，不会渲染挑帧！"
	)
	on loadGLSet_btn pressed do(
		loadGlobalSet()
		if SAVE_btn.checked do
			lbx1.items = getSetSaveTolbx()
		if (getSetSaveTolbx()).count > 0 then delGLSet_btn.enabled = true else delGLSet_btn.enabled = false
	)
	on delGLSet_btn pressed do(
		if (querybox "确定要删除选中的预设吗？" title:"R8D") do(
			delGLSet()
			lbx1.items = getSetSaveTolbx()
		)
	)
	on SAVE_btn rightclick do(
		saveGlobalSet()
	)
	on expGLSet_btn pressed do saveGlobalSet()
	on SAVE_btn changed state do(
		if state then(
			addGLSet_btn.visible = true
			loadGLSet_btn.visible = true
			expGLSet_btn.visible = true
			delGLSet_btn.visible = true
			lbx1.items = getSetSaveTolbx()
		if (getSetSaveTolbx()).count > 0 then delGLSet_btn.enabled = true else delGLSet_btn.enabled = false
		)else(
			addGLSet_btn.visible = false
			loadGLSet_btn.visible = false
			expGLSet_btn.visible = false
			delGLSet_btn.visible = false
			if getani_chk.checked then(
				setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GETACT" "true"
				::r8dfn.getAni()
			)else(
				setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "GETACT" "false"
				::r8dfn.getMaxNum()
			)
			lSel=execute(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "FILESEL")
			if lSel != OK do lbx1.selection = lSel
		)
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 预设 按钮激活时右边的列表将显示用户所保存的全局预设,同时会出现四个按钮用于编辑预设列表,双击列表中的预设即读取该预设储存的设置,右键点击 预设 按钮把当前所有绿标处的设置导出为r8d文件发给同项目组的同事导入使用,点load按钮来导入."
	)
	on addGLSet_btn pressed do(
		if addSetRollout != undefined do destroyDialog addSetRollout
		UI = execute(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ui")
		createdialog addSetRollout pos:[UI.x+306,UI.y+120]
	)
	on useSce_chk changed state do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SCENECHK" (state as string)
Sc1.enabled = state
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 场景名 取消勾选时渲染各场景时会去除输出图片的场景名，只渲染一个场景时才可以输出自定义场景名。"
	)
	on useAct_chk changed state do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ACTNAMCHK" (state as string)
An2.enabled = state
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 动作名 取消勾选时渲染带动作的场景时会去除输出图片的动作名，当只选择一个动作时选项下方会出现输入窗口，可以输入自定义动作名。"
	)
	on useDir_chk changed state do(
Di4.enabled = state
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DIRECHK" (state as string)
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 方向名 取消勾选时渲染各场景时会去除输出图片的方向名，方向名为各个方向按钮下面的文字。"
	)
	on useSSN_chk changed state do(
Ss3.enabled = state
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SSNCHK" (state as string)
	)
	on lbx1 selected item do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "FILESEL" (item as string)

		if getani_chk.checked then
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 可以选择多个动作进行渲染，选择单个动作时可以对该动作自定义动作名。"
		else(
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do (
			if (lbx1.selection as array).count <= 1 then
			helpline.text=" 选择一个max文件时可点击 打开场景 按钮打开该场景。可以自定义 场景名 和 动作名（如果有动作记录），双击带[+]号的文件夹会自动选中该文件夹下的所有文件，双击.max文件则会跨文件夹选择所有max文件。"
			else
			helpline.text=" 可以选择多个max文件一起渲染，可以勾选 全局应用 选项所有选中的场景将应用当前全局设置进行渲染，双击带[+]号的文件夹会自动选中该文件夹下的所有文件，双击.max文件则会跨文件夹选择所有max文件。"
			)
		)
		if SAVE_btn.checked then
			if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 双击预设即读取该全局记录，全局应用 选项将会被激活。"
	)
	on lbx1 doubleclicked item do(
		if SAVE_btn.checked then(
			try(loadlbxSet())catch(messagebox "该预设版本较低，需要重新保存新版预设！（或者没有使用工具相机）")
			Aspect_spn.value = (RW_spn.value / RH_spn.value as float)
			renderWidth = RW_spn.value
			renderHeight = RH_spn.value
			if bit_spn.value < 1 then BitV = 1 else BitV = bit_spn.value
			if zero_cbt.checked then(
				bitCount.text = (replace bitCount.text BitV 1 "0")
			)else(
				bitCount.text = (replace bitCount.text BitV 1 "1")
			)
			
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Ssave" S.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ESsave" ES.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Esave" E.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "ENsave" EN.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Nsave" N.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WNsave" WN.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Wsave" W.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "WSsave" WS.text
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "Osave" O.text
		)else(
			if getani_chk.checked then(
			if maxfilepath != "" do(
				fileName = filterString maxfilename "."
				sTime = filterString (getinisetting (maxfilepath+fileName[1]+"_AT.ini") "AniTimes" (item as string)) "-()/"
				if sTime[2] != undefined do(
					startT = sTime[2]as integer
					endT = sTime[3]as integer
					animationRange = interval startT endT
				)
			)
			)else(
--				i=(::r8dui.r8ui.lbx1.items.count)
--				lbx1.selection=#{1..i}
			if subdir_chk.checked then(
				try (
				SELF = #()
				lbxSEL = #()
				if ::r8dfn.SelDirF[(::r8dui.r8ui.lbx1.selection as array)[1]] != "F" then(
					SELF = getFiles (::r8dfn.SelDirF[(::r8dui.r8ui.lbx1.selection as array)[1]]+"\\*.max")
					for sf in SELF do(
		--				ffn = filterstring sf "\\"
						sc = finditem ::r8dfn.RmFiles sf
						append lbxSEL sc
					)
				)else(
					for i in 1 to ::r8dfn.SelDirF.count do(
						if ::r8dfn.SelDirF[i] == "F" do append lbxSEL i
					)
				)
				if lbxSEL.count > 0 do lbx1.selection = lbxSEL
				)catch()
			)else(
				i=(::r8dui.r8ui.lbx1.items.count)
				lbx1.selection=#{1..i}
			)

			)
		)
	)
	--Render--------------
rollout selPriRollout "R8D Render Setting" width:276 height:108
(
	checkbox RRS_chk1 "显示渲染窗口" pos:[11,15]
	checkbox OS_chk1 "自动保存场景" pos:[11,35]
	dropDownList ddl1 "窗口位置:" items:#("左上角","左下角","右上角","右下角","中心","原位","第一位置","第二位置") pos:[138,15] width:127 height:22 
	button btnRRR "G O" pos:[72,69] width:130 height:29
	on RRS_chk1 changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SHOWRV" (state as string)
		ddl1.enabled = state
	)
	on OS_chk1 changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "OVERSAVE" (state as string)
		::r8dui.r8ui.overSave_chk.checked = state
	)
	on ddl1 selected item do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "VFBPOS" (item as string)
	)
	on selPriRollout open do(
		if render8Rollout.jSeting.checked then(
			OS_chk1.enabled = ::r8dui.r8ui.overSave_chk.checked = OS_chk1.checked = false
		)else(
		::r8dui.r8ui.overSave_chk.checked=OS_chk1.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "OVERSAVE")
		if ::r8dui.r8ui.getani_chk.checked then
			OS_chk1.enabled = false
		else
			OS_chk1.enabled = true
		)
		ddl1.selection = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "VFBPOS")as integer
		ddl1.enabled = RRS_chk1.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SHOWRV")
	)
	on btnRRR pressed do(
		destroyDialog selPriRollout
		::r8dfn.STOPRM = false
		-- KEEY = ::r8dfn.getkkkk()
		-- if KEEY == (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "kkk") then(
			::r8dui.r8ui.GetAniFN ::r8dui.r8ui.getani_chk.checked
			if ::r8dui.r8ui.getani_chk.checked then (
			::r8dfn.SetDegerView 0
			if ::r8dfn.RRRGO() do(
		if ::r8dui.r8ui.getSS_chk.checked do
			::r8dfn.FindSelSet()
			)
			)else(
		CUSCAM = (getnodebyname getCusCam.text)
		if CUSCAM != undefined do(
			::r8dfn.SetDegerView 0
			::r8dui.CustemCam=CUSCAM.pos
			CamTag = getnodebyname (getCusCam.text+".Target")
			::r8dui.CustemCamTag=CamTag.pos
			::r8dui.CustemCamFOV=CUSCAM.FOV
			::r8dui.CustemCamOrt=CUSCAM.orthoProjection
		)
				::r8dfn.RRRDIR()
			)
		-- )else(
			-- if (messagebox "渲染已锁定！请输入CD-KEY来解锁。" title:"R8D CD-KEY")==OK do(
				-- createdialog ::r8dfn.kkkr8d
			-- )
		-- )
		
	)
)
	on renderDir_btn pressed do(
		createdialog selPriRollout style:#(#style_sysmenu,#style_toolwindow)
	)--Render----END
	on renderDir_btn rightclick do(
		if RENDPIC != undefined do display RENDPIC
	)
	on rSingle_btn rightclick do(
		if singleR_rollout != undefined do destroyDialog singleR_rollout
		createdialog singleR_rollout
	)
	on hideUnSS_btn pressed do ::r8dfn.HideUnSSobj "hide"
	on showUnSS_btn pressed do ::r8dfn.HideUnSSobj "show"
	on rSingle_btn pressed do(
		CUSCAM = (getnodebyname getCusCam.text)
		if CUSCAM != undefined do(
			::r8dfn.SetDegerView 0
			::r8dui.CustemCam=CUSCAM.pos
			CamTag = getnodebyname (getCusCam.text+".Target")
			::r8dui.CustemCamTag=CamTag.pos
			::r8dui.CustemCamFOV=CUSCAM.FOV
			::r8dui.CustemCamOrt=CUSCAM.orthoProjection
		)
		::r8dfn.PreviewRR()
	)
	on gloSize_chk changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "GLO_SIZE" (state as string)
		if state then(
	     glWH_bmp  .visible = true
		 )else(
	     glWH_bmp  .visible = false
		 )
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 尺寸 选项用于 >批量渲染< 优先应用工具界面上的尺寸设置，该设置优先于RPS预设读取的尺寸设置. (黄标处参数)"
	)
	on glob_chk changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "GLO_CAM" (state as string)
		if state then(
	     glDeg_bmp .visible = true
	     glOrt_bmp  .visible = true
		 )else(
	     glDeg_bmp .visible = false
	     glOrt_bmp  .visible = false
		 )
		if  ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK") do helpline.text=" 相机 选项用于 >批量渲染< 时对没有相机的max文档根据当前相机参数自动创建相机,该选项勾选时可以渲染没有创建像机的场景,但要确保所有场景的模型大小适合使用当前的设置. (绿标处参数)"
	)
	on someDig changed val do(
		CusCam=getnodebyname getCusCam.text
		if CusCam != undefined do(
		if (fileProperties.findProperty #custom "SetSomeDeger") > 0 then(
			ABC=for o in selection collect o
			SVD=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "SetSomeDeger")
			Dummy name:"R8D_SVDCam" ishidden:true isselected:false
		CusCam.parent = $R8D_SVDCam
			CamTag = getnodebyname (getCusCam.text+".Target")
		if CamTag != undefined do CamTag.parent = $R8D_SVDCam
	rotate $R8D_SVDCam (angleaxis -SVD [0,0,1])
	rotate $R8D_SVDCam (angleaxis val [0,0,1])
			delete $R8D_SVDCam
			select ABC
			fileproperties.addProperty #custom "SetSomeDeger" val
		)else fileproperties.addProperty #custom "SetSomeDeger" 0
		)
	)
	on ES_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_ES_spn.value)
		else(
		try(viewport.setCamera ($ES))catch()
		::r8dfn.SetDegerView (Deg_ES_spn.value) )
	)
	on E_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_E_spn.value)
		else(
		try(viewport.setCamera ($E))catch()
		::r8dfn.SetDegerView (Deg_E_spn.value) )
	)
	on EN_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_EN_spn.value)
		else(
		try(viewport.setCamera ($EN))catch()
		::r8dfn.SetDegerView (Deg_EN_spn.value) )
	)
	on N_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_N_spn.value)
		else(
		try(viewport.setCamera ($N))catch()
		::r8dfn.SetDegerView (Deg_N_spn.value) )
	)
	on WN_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_WN_spn.value)
		else(
		try(viewport.setCamera ($WN))catch()
		::r8dfn.SetDegerView (Deg_WN_spn.value) )
	)
	on W_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_W_spn.value)
		else(
		try(viewport.setCamera ($W))catch()
		::r8dfn.SetDegerView (Deg_W_spn.value)	)
	)
	on WS_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_WS_spn.value)
		else(
		try(viewport.setCamera ($WS))catch()
		::r8dfn.SetDegerView (Deg_WS_spn.value)	)
	)
	on O_btn rightclick do (
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_O_spn.value)
		else(
		try(viewport.setCamera ($O))catch()
		::r8dfn.SetDegerView (Deg_O_spn.value)	)
	)
	on S_btn rightclick do(
		if keyboard.controlpressed then
			::r8dfn.quickPV_fn (Deg_S_spn.value)
		else(
		try(viewport.setCamera ($S))catch()
		::r8dfn.SetDegerView (Deg_S_spn.value)	)
	)
	on S_btn changed state do (if state then S.enabled = true else( S.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_S" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on ES_btn changed state do (if state then ES.enabled = true else( ES.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_ES" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on E_btn changed state do (if state then E.enabled = true else( E.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_E" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on EN_btn changed state do (if state then EN.enabled = true else( EN.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_EN" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on N_btn changed state do (if state then N.enabled = true else( N.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_N" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on WN_btn changed state do (if state then WN.enabled = true else( WN.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WN" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on W_btn changed state do (if state then W.enabled = true else( W.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_W" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on WS_btn changed state do (if state then WS.enabled = true else( WS.enabled = false
	All_chkbtn.checked=false
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All" "false")
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WS" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on O_btn changed state do (if state then O.enabled = true else O.enabled = false
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_O" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)

	on refresh_btn pressed do(
		-- if $OOXChoseKeys_D != undefined then cho_img.visible = true else cho_img.visible = false
		if getSS_chk.checked do(
			::r8dfn.FindSelSet()
		)
		if ::r8dfn.RS_rol.open do ::r8dfn.RS_rol.refreshRS()
		::r8dfn.LoadSceneVal()
		if ::r8dfn.DEGREE != undefined do
			glDegree_spn.value=::r8dfn.DEGREE as float
		if ::r8dfn.GLOBHEIGHT != undefined do
			glHeight_spn.value=::r8dfn.GLOBHEIGHT as float
		if ::r8dfn.GLOBSCALE != undefined do
			glScale_spn.value=::r8dfn.GLOBSCALE as float
		if ::r8dfn.GLFOV != undefined do
			glFOV_spn.value=::r8dfn.GLFOV as float
		if getani_chk.checked then ::r8dfn.getAni() else(::r8dfn.getMaxNum())
		RW_spn.value = renderWidth
		RH_spn.value = renderHeight
		Aspect_spn.value = (RW_spn.value / RH_spn.value as float)
		::r8dfn.isCameraOk()
		getMaxV()
		SAVE_btn.checked = false
		addGLSet_btn.visible = false
		loadGLSet_btn.visible = false
		expGLSet_btn.visible = false
		delGLSet_btn.visible = false
		if saveAniTime_Rollout != undefined do saveAniTime_Rollout.SAT_reload()
	)
	on renderDir_edt entered text do(
	if text != "" then(
		PSP=text
		if subdir_chk.checked and (filterString PSP "\\").count < 2 then (messagebox "勾选[查子目录]不要指定根目录盘符，否则会使MAX超负！" title:"R8D: 设置批量渲染路径")else(
		::r8dfn.isCameraOk()
		if (substring PSP PSP.count 1) == "\\" do PSP = replace PSP PSP.count 1 ""
		if ::r8dfn.isDirectoryExist PSP do(
		CCC = 0
		for i in renderDir_ddl.items do if i == PSP do CCC+=1
		if CCC == 0 then(
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_text" PSP
			TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT") as integer
			if TC == 0 then(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT" "1"
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_1" PSP
			)else(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT" ((TC+1)as string)
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" ("TYP_"+((TC+1) as string)) PSP
			)
		INHIS=#()
		TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT") as integer
		for i =1 to TC do(
		itm=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" ("TYP_"+(i as string))
			append INHIS itm
		)
		append INHIS "--清除历史--"
		renderDir_ddl.items = INHIS
		)
			if (::r8dfn.getMaxNum()) do
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_text" PSP
		)
		)
	)else(
		r_bmp.visible = true
		lbx1.items = #("！请指定渲染目录")
	)
	)
	on renderDir_ddl selected item do (
	if item == renderDir_ddl.items.count then(
		if getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT" != "" do
		if (querybox "确定要删除文件夹历史记录吗？" title:"R8D") then(
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT" ""
			renderDir_ddl.items = #()
		)else(renderDir_ddl.selection = 1)
	)else(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_text" renderDir_ddl.items[item]
		renderDir_edt.text = renderDir_ddl.items[item]
		::r8dfn.getMaxNum()
		::r8dfn.isCameraOk()
		::r8dfn.getMaxNum()
	)
	)
	on setDir_btn pressed do(
		PSP = getsavepath caption:"指定渲染路径" initialDir:renderDir_edt.text
		if subdir_chk.checked and (filterString PSP "\\").count < 2 then (messagebox "勾选[查子目录]不要指定根目录盘符，否则会使MAX超负！" title:"R8D: 设置批量渲染路径")else(
		saveTmp = renderDir_ddl.items
		if PSP != undefined do(
		if (substring PSP PSP.count 1) == "\\" do PSP = replace PSP PSP.count 1 ""
			renderDir_edt.text = PSP
		CCC = 0
		for i in renderDir_ddl.items do if i == PSP do CCC+=1
		if CCC == 0 then(
		INHIS=#()
			TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT") as integer
			if TC == 0 then(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT" "1"
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_1" PSP
			)else(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_COUNT" ((TC+1)as string)
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" ("TYP_"+((TC+1)as string)) PSP
			)
		for i =1 to (TC+1) do(
		itm=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" ("TYP_"+(i as string))
			append INHIS itm
		)
		append INHIS "--清除历史--"
		renderDir_ddl.items = INHIS
		)
			::r8dfn.getMaxNum()
			::r8dfn.isCameraOk()
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "INHIS" "TYP_text" PSP
	)	)
	)
	on setDir_btn rightclick do(
		try(shellLaunch "Explorer.EXE" renderDir_edt.text)catch()
	)
	on outDir_edt entered text do(
		::r8dfn.isCameraOk()
		PSP=text
		if (substring PSP PSP.count 1) == "\\" do PSP = replace PSP PSP.count 1 ""
		if ::r8dfn.isDirectoryExist PSP do(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_text" PSP
		CCC = 0
		for i in outDir_ddl.items do if i == PSP do CCC+=1
		if CCC == 0 then(
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_text" PSP
			TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT") as integer
			if TC == 0 then(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT" "1"
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_1" PSP
			)else(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT" ((TC+1)as string)
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" ("TYP_"+((TC+1) as string)) PSP
			)
		OUTHIS=#()
		TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT") as integer
		for i =1 to TC do(
		itm=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" ("TYP_"+(i as string))
			append OUTHIS itm
		)
		append OUTHIS "--清除历史--"
		outDir_ddl.items = OUTHIS
		)
		)
	)
	on outDir_ddl selected item do (
	if item == outDir_ddl.items.count then(
		if getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT" != "" do
		if (querybox "确定要删除文件夹历史记录吗？" title:"R8D") then(
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT" ""
			outDir_ddl.items = #()
		)else(outDir_ddl.selection = 1)
	)else(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_text" outDir_ddl.items[item]
		outDir_edt.text = outDir_ddl.items[item]
		::r8dfn.isCameraOk()
	)
	)
	on setOutDir_btn pressed do(
		PSP = getsavepath caption:"指定输出路径" initialDir:outDir_edt.text
		if PSP != undefined do(
		if (substring PSP PSP.count 1) == "\\" do PSP = replace PSP PSP.count 1 ""
			outDir_edt.text = PSP
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_text" PSP
		CCC = 0
		for i in outDir_ddl.items do if i == PSP do CCC+=1
		if CCC == 0 then(
		OUTHIS=#()
			TC=(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT") as integer
			if TC == 0 then(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT" "1"
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_1" PSP
			)else(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" "TYP_COUNT" ((TC+1)as string)
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" ("TYP_"+((TC+1) as string)) PSP
			)
		for i =1 to (TC+1) do(
		itm=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "OUTHIS" ("TYP_"+(i as string))
			append OUTHIS itm
		)
		append OUTHIS "--清除历史--"
		outDir_ddl.items = OUTHIS
		)
			::r8dfn.isCameraOk()
		)
	)
	on setOutDir_btn rightclick do(
		try(shellLaunch "Explorer.EXE" outDir_edt.text)catch()
	)
	on ortho_chk changed state do(
		if $AllCamera != undefined and $S != undefined do(
			for n in ::r8dui.CNAMEs do(
			if (getnodebyname n) != undefined do
				(getnodebyname n).orthoProjection = ortho_chk.checked
			)
			fileProperties.addProperty #custom "Orthographic" state
		)
camPicked = getnodebyname getCusCam.text
if camPicked != undefined do(
	camPicked.orthoProjection = state
)
	)
	-- on createC pressed do(
		-- ::r8dfn.createCCC true
	-- )
	-- on createC rightclick do(
		-- ::r8dfn.DelToolCAM true
	-- )
	on RW_spn changed val do(
		renderWidth = val
		if lockAspect_btn.checked then(
			renderHeight = RH_spn.value = (RW_spn.value / Aspect_spn.value)as integer
		)else(
			Aspect_spn.value = (RW_spn.value / RH_spn.value as float)
		)
	)
	on RH_spn changed val do(
		renderHeight = val
		if lockAspect_btn.checked then(
			renderWidth = RW_spn.value = (RH_spn.value * Aspect_spn.value)as integer
		)else(
			Aspect_spn.value = (RW_spn.value / RH_spn.value as float)
		)
	)
	on Aspect_spn changed val do(
		renderHeight = RH_spn.value = (RW_spn.value / Aspect_spn.value)as integer
	)
	on All_chkbtn changed state do(
		if All_chkbtn.checked then(
			S_btn.checked = true
			ES_btn.checked = true
			E_btn.checked = true
			EN_btn.checked = true
			N_btn.checked = true
			WN_btn.checked = true
			W_btn.checked = true
			WS_btn.checked = true
			S.enabled = true
			ES.enabled = true
			E.enabled = true
			EN.enabled = true
			N.enabled = true
			WN.enabled = true
			W.enabled = true
			WS.enabled = true
		)else(
			S_btn.checked = false
			ES_btn.checked = false
			E_btn.checked = false
			EN_btn.checked = false
			N_btn.checked = false
			WN_btn.checked = false
			W_btn.checked = false
			WS_btn.checked = false
			S.enabled = false
			ES.enabled = false
			E.enabled = false
			EN.enabled = false
			N.enabled = false
			WN.enabled = false
			W.enabled = false
			WS.enabled = false
		)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_All"  (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_S"  (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_ES" (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_E"  (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_EN" (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_N"  (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WN" (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_W"  (state as string)
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Direction" "Dir_WS" (state as string)
		if R8DSet_rollout!=undefined do
		if ::r8dfn.DriBtnChk() > 1 then (R8DSet_rollout.AutoDir_btn.enabled = true ; R8DSet_rollout.der_spn.enabled = true )else( R8DSet_rollout.AutoDir_btn.enabled = false ; R8DSet_rollout.der_spn.enabled = false)
	)
	on glDegree_spn changed val do(
		degre = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X"		
		if maxfilename != "" and $AllCamera != undefined and $S != undefined then(
			if (fileProperties.findProperty #custom "glDegreeSave") > 0 then(
				degre = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "glDegreeSave")
			)
			if degre != "" do(
				for i = 1 to 8 do(
					DD = getnodebyname ("D_"+i as string)
					rotate DD (angleaxis (45*i+someDig.value) [0,0,1])
					rotate DD (angleaxis (degre as float) [1,0,0])
					rotate DD (angleaxis (-val) [1,0,0])
					rotate DD (angleaxis (-45*i+someDig.value) [0,0,1])
				)
				fileProperties.addProperty #custom "glDegreeSave" (val)
			)
		)else(
			if degre != "" and $AllCamera != undefined and $S != undefined do(
				for i = 1 to 8 do(
					DD = getnodebyname ("D_"+i as string)
					rotate DD (angleaxis (45*i+someDig.value) [0,0,1])
					rotate DD (angleaxis (degre as float) [1,0,0])
					rotate DD (angleaxis (-val) [1,0,0])
					rotate DD (angleaxis (-45*i+someDig.value) [0,0,1])
				)
			)
		)
if getCusCam.text != "- None -" do(
camPicked = getnodebyname getCusCam.text
if camPicked != undefined do(
if val > -50 and val < 80 do(
	if $R8D_CustemRenderCam == undefined do
		Dummy name:"R8D_CustemRenderCam" ishidden:true isselected:false
	CamTag = getnodebyname (getCusCam.text+".Target")
	if CamTag != undefined do $R8D_CustemRenderCam.pos.z = CamTag.pos.z
	OldAng = ::r8dfn.GetDegrees_B camPicked
	rotate $R8D_CustemRenderCam (angleaxis -OldAng [0,0,1])
	camPicked.parent = $R8D_CustemRenderCam
	execute ("$"+getCusCam.text+"\.Target.parent = $R8D_CustemRenderCam")
	rotate $R8D_CustemRenderCam (angleaxis OldAng [0,0,1])
	rotate $R8D_CustemRenderCam (angleaxis (::r8dfn.GetDegrees camPicked) [1,0,0])
	rotate $R8D_CustemRenderCam (angleaxis (-val) [1,0,0])
	rotate $R8D_CustemRenderCam (angleaxis -OldAng [0,0,1])
	try(delete $R8D_CustemRenderCam)catch()
)))
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X" (val as string)
	)
	on getCusCam picked obj do(
		if obj != undefined do (
		Dval=(::r8dfn.GetDegrees obj)
		if Dval != "error" do(
		fileproperties.addProperty #custom "SetViewDeger" 0
			ortho_chk.checked = obj.orthoProjection
			glFOV_spn.value=obj.FOV
		getCusCam.text = obj.name
			CamTag = getnodebyname (getCusCam.text+".Target")
			if CamTag != undefined do( glHeight_spn.value = CamTag.pos.z
			fileProperties.addProperty #custom "R8D_CustemCameraPosBx" CamTag.pos.x
			fileProperties.addProperty #custom "R8D_CustemCameraPosBy" CamTag.pos.y
			fileProperties.addProperty #custom "R8D_CustemCameraPosBz" CamTag.pos.z)
			fileProperties.addProperty #custom "R8D_CustemCameraPosAx" obj.pos.x
			fileProperties.addProperty #custom "R8D_CustemCameraPosAy" obj.pos.y
			fileProperties.addProperty #custom "R8D_CustemCameraPosAz" obj.pos.z
			fileProperties.addProperty #custom "R8D_CustemCameraFOV" obj.FOV
			fileProperties.addProperty #custom "R8D_CustemCameraOrt" obj.orthoProjection
		fileproperties.addProperty #custom "GetTCamera" getCusCam.text
			glDegree_spn.value=Dval
			reCam_btn.enabled=true
			)
		)
	)
	on getCusCam rightclick do(getCusCam.text = "- None -"	; fileproperties.deleteProperty #custom "GetTCamera")
	on createT pressed do(
		if $AllCamera == undefined do	::r8dfn.createCCC false
		if $TagCamera != undefined do delete $TagCamera
Targetcamera name:"TagCamera" fov:$S.FOV orthoProjection:$S.orthoProjection nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:$S.pos isSelected:off target:(Targetobject name:"TagCamera.Target" isFrozen:true transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] $Ccenter.pos))
ab=geometry.max.y-geometry.min.y
		text text:"↓" pos:[0,-(ab),0] size:(ab) name:"TqianFront" wirecolor:black isFrozen:true showFrozenInGray:off
		::r8dfn.DelToolCAM true
		fileproperties.addProperty #custom "SetViewDeger" 0
		fileproperties.addProperty #custom "GetTCamera" "TagCamera"
		getCusCam.text = "TagCamera"
		reCam_btn.enabled = true
		CusCam=getnodebyname getCusCam.text
			ABC=for o in selection collect o
			Dummy name:"R8D_SVDCam" ishidden:true isselected:false
		CusCam.parent = $R8D_SVDCam
			CamTag = getnodebyname (getCusCam.text+".Target")
		if CamTag != undefined do CamTag.parent = $R8D_SVDCam
	rotate $R8D_SVDCam (angleaxis someDig.value [0,0,1])
			delete $R8D_SVDCam
			select ABC
			fileproperties.addProperty #custom "SetSomeDeger" someDig.value
	)
	on createT rightclick do(
		if getCusCam.text == "TagCamera" do(
		try(delete $TagCamera)catch()
		try(delete $TqianFront)catch()
		getCusCam.text = "- None -"
		reCam_btn.enabled = false
		fileproperties.deleteProperty #custom "GetTCamera"
		::r8dfn.isCameraOk()
		)
	)
	on reCam_btn pressed do (
		CusCam=getnodebyname getCusCam.text
		if CusCam != undefined do(
			::r8dfn.SetDegerView 0
			if (fileProperties.findProperty #custom "R8D_CustemCameraPosAx") > 0 do(
				cBx=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraPosBx")
				cBy=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraPosBy")
				glHeight_spn.value = cBz=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraPosBz")
				cAx=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraPosAx")
				cAy=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraPosAy")
				cAz=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraPosAz")
				CusCam.pos = [cAx,cAy,cAz]
				CamTag = getnodebyname (getCusCam.text+".Target")
				if CamTag != undefined do(
					CamTag.pos = [cBx,cBy,cBz]
				)
			)
			glDegree_spn.value=(::r8dfn.GetDegrees CusCam)
			if (fileProperties.findProperty #custom "R8D_CustemCameraFOV") > 0 do
			glFOV_spn.value = CusCam.FOV=(fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraFOV"))
			if (fileProperties.findProperty #custom "R8D_CustemCameraOrt") > 0 do
			ortho_chk.checked = CusCam.orthoProjection=(fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraOrt"))
		)
	)
	on reCam_btn rightclick do(
		obj = getnodebyname getCusCam.text
		if obj != undefined do(
			::r8dfn.SetDegerView 0
			CamTag = getnodebyname (getCusCam.text+".Target")
			if CamTag != undefined do( glHeight_spn.value = CamTag.pos.z
			fileProperties.addProperty #custom "R8D_CustemCameraPosBx" CamTag.pos.x
			fileProperties.addProperty #custom "R8D_CustemCameraPosBy" CamTag.pos.y
			fileProperties.addProperty #custom "R8D_CustemCameraPosBz" CamTag.pos.z)
			fileProperties.addProperty #custom "R8D_CustemCameraPosAx" obj.pos.x
			fileProperties.addProperty #custom "R8D_CustemCameraPosAy" obj.pos.y
			fileProperties.addProperty #custom "R8D_CustemCameraPosAz" obj.pos.z
			fileProperties.addProperty #custom "R8D_CustemCameraFOV" obj.FOV
			fileProperties.addProperty #custom "R8D_CustemCameraOrt" obj.orthoProjection
		)
	)
	on glHeight_spn changed val do(
		if $AllCamera != undefined do(
			$AllCamera.pos.z = val
			fileProperties.addProperty #custom "glHeightSave" val
		)
		camPicked = getnodebyname getCusCam.text
		if camPicked != undefined do(
		if $R8D_CustemRenderHight == undefined do
			Dummy name:"R8D_CustemRenderHight" ishidden:true isselected:false
			CamTag = getnodebyname (getCusCam.text+".Target")
			if CamTag != undefined do $R8D_CustemRenderHight.pos.z = CamTag.pos.z
		camPicked.parent = $R8D_CustemRenderHight
			CamTag.parent = $R8D_CustemRenderHight
		$R8D_CustemRenderHight.pos.z = val
		try(delete $R8D_CustemRenderHight)catch()
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLHEIGHT" (val as string)
	)
	on glScale_spn changed val do(
		if $AllCamera != undefined do(
			$AllCamera.scale = [val,val,val]
			fileProperties.addProperty #custom "glScaleSave" val
		)
		camPicked = getnodebyname getCusCam.text
		if camPicked != undefined do(
			if $R8D_CustemRenderScale == undefined do
				Dummy name:"R8D_CustemRenderScale" ishidden:true isselected:false
			if (fileProperties.findProperty #custom "R8D_CustemCameraScale") > 0 then(
				Scl = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraScale")
				$R8D_CustemRenderScale.scale = [Scl,Scl,Scl]
			)else(
				$R8D_CustemRenderScale.scale = [val,val,val]
			)
			CamTag = getnodebyname (getCusCam.text+".Target")
			if CamTag != undefined do $R8D_CustemRenderScale.pos.z = CamTag.pos.z
			camPicked.parent = $R8D_CustemRenderScale
			CamTag.parent = $R8D_CustemRenderScale
			$R8D_CustemRenderScale.scale = [val,val,val]
			fileProperties.addProperty #custom "R8D_CustemCameraScale" val
			try(delete $R8D_CustemRenderScale)catch()
		)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLSCALE" (val as string)
	)
	on glFOV_spn changed val do(
		for n in ::r8dui.CNAMEs do(
			try ((getnodebyname n).FOV = val) catch ()
		)
		camPicked = getnodebyname getCusCam.text
		if camPicked != undefined do(
			camPicked.FOV = val
		)
		fileProperties.addProperty #custom "glFOVSave" val
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLFOV" (val as string)
	)
	
)
struct r8dui (
	CustemCam, CustemCamTag, CustemCamFOV, CustemCamOrt,CNAMEs = #("WS","W","WN","N","EN","E","ES","S"),
	r8ui = render8Rollout
)
::r8dui = r8dui()
createdialog render8Rollout pos:UIx style:#(#style_sysmenu,#style_titlebar,#style_minimizebox)

endT = timeStamp()
print ("\nR8DUI Processing: "+((endT - startTi)/1000.0)as string+"s")

