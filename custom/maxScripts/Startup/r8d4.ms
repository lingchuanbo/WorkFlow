--本地化初始设置
Include "$scripts\\Startup\setEvn.ms"

if rs_Rollout != undefined do destroyDialog rs_Rollout
if R8DSet_rollout != undefined do destroyDialog R8DSet_rollout
startT = timeStamp()
if not doesFileExist ("$maxScripts\plugcfg\R8Dinfo.txt") do createFile ("$maxScripts\plugcfg\R8Dinfo.txt")
global RVers="7.6.2" ,OldFFram,OldBFram
global StartATS=true,StarTime,AllT=0,OneDo=true
if (getinisetting "$maxScripts\plugcfg\custom_prefs.ini" "saveTimeInterface" "uiXY") == "" do setinisetting "$scripts\plugcfg\custom_prefs.ini" "saveTimeInterface" "uiXY" "[160,100]"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DOUBLESIDE") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DOUBLESIDE" "false"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING" "false"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEBONE") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEBONE" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "RSS_SET") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "RSS_SET" "true"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHK") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHK" "false"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHKCS") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHKCS" "false"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTROT") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTROT" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SFRS") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SFRS" "false"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEUNSSOBJ") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEUNSSOBJ" "false"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN" "false"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OFset" "SAVEMSG") == "" do setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "OFset" "SAVEMSG" "true"
if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "VFBPOS") == "" do setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "VFBPOS" "6"

if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_" "0"  
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES" "45" 
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_" "90" 
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN" "135"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_" "180"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN" "225"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_" "270"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS" "315"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O" "180"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_Cut")=="" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_Cut" "180"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1")=="" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SC1" "1"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_AN2" "2"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_SS3" "3"
if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4") == "" do setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SORT_DI4" "4"
fn CurRenNum = (
	CR = filterstring (renderers.production as string) ":"
	RS = finditem ::r8dfn.RNL CR[2]
	return RS
)
fn CreateCodePOW NN =(
	CODES = #("C","B","u","F","G","I","J","Z","g","l","N","O","e","f","a","P","H","_","+","U","V","W","X","%","^","&","*","(","Y","}",":","b","3",",","5","c","~","E","@","d","6","{","M","h","i","j","k","n","o","[","p","q","L","4","v","A","$",")","r","s","t","w","D","m","-","#","x","K","y","R","!","S","z","1","7","Q","0","T","8","9","=","`","2","]",".")
	CPNnum = #()
	NS = ""
	for i in 1 to NN.count do(
		aa = substring NN i 1
		cNum = finditem CODES aa
		append CPNnum cNum
	)
	for n in CPNnum do(
		NS += (n as string)
	)
	if NS.count > 6 do(
		NS = substring NS (NS.count / 8) 6
	)
	COD = NS as integer
	return COD
)
fn CreateNUM NNNN = (
	local Ccode="",Ckkkk=""
	CODES = #("C","B","u","F","G","I","J","Z","g","l","N","O","e","f","a","P","H","_","+","U","V","W","X","%","^","&","*","(","Y","}",":","b","3",",","5","c","~","E","@","d","6","{","M","h","i","j","k","n","o","[","p","q","L","4","v","A","$",")","r","s","t","w","D","m","-","#","x","K","y","R","!","S","z","1","7","Q","0","T","8","9","=","`","2","]",".")
	if NNNN.count > 2 then CPN = NNNN else CPN = NNNN + "aSR"
	CPNnum = #()
	UID = ""
	for i in 1 to CPN.count do(
		aa = substring CPN i 1
		cNum = finditem CODES aa
		append CPNnum cNum
	)
	for cc in CPNnum do(
		UID += cc as string
	)
	if UID.count > 37 do(
		mis = UID.count - 37
		UID=replace UID 15 mis ""
	)
	return UID
)
struct r8dStart (
	COldMat=#(),COldNam=#(),oldMS=false,oldMSa=false,
	CNAME = #("WS","W","WN","N","EN","E","ES","S"),
	vfbPos=#(#vfb_upper_left, #vfb_lower_left, #vfb_upper_right, #vfb_lower_right, #vfb_center, #vfb_renderer_position, #vfb_vprimary_position, #vfb_vsecondary_position),
	CODEPOW = (CreateCodePOW (sysInfo.computername)),VVV=RVers,
	-- IOOIIIOIOttt = ("try"+CreateNUM (sysInfo.username+sysInfo.computername)+"07"),
	IOOIIIOIO = ("0"+CreateNUM (sysInfo.username+sysInfo.computername)+"7")
)
::r8dStart = r8dStart()
	--------------------------
rollout kkkkRollout "R8D -KEY" width: 358 height: 150
(
	label lbl1 "请输入R8D KEY：  微信关注 [勤劳蜗牛] 获取更多帮助 →" pos:[22,15] height:18
	button code_btn "扫" pos:[321,13] width:18 height:18 transparent:(color 0 255 0) tooltip:"扫码 关注[勤劳蜗牛]"
	editText edt1 "" pos:[31,40] width:292 height:17
	label lbl2 "将上框中的数字发给作者QQ：51570900  注:R8D-KEY" pos:[37,62] enabled:false
	button btn1 "OK" pos:[135,85] width:81 height:27
	hyperLink likNetBuy "R8D-KEY购买链接" address:"http://item.taobao.com/item.htm?id=41961866931" color:(color 20 120 225) hoverColor:(color 255 98 27) across:2 align:#center offset:[0,10]
	hyperLink likNetSina "欢迎进入我的博客" address:"http://blog.sina.com.cn/qinlaowoniu" align:#center offset:[0, 10] color:(color 0 100 205) hoverColor:(color 255 128 57)
	on code_btn pressed do(
		rollout code_rol "获得最新帮助" width:258 height:258(
			imgtag code "" pos:[0,0] bitmap:(openBitMap "$scripts\oxTOOLSfiles\Icons\qrcode.jpg") transparent:(color 0 255 0) tooltip:"关闭"
			on code click do destroyDialog code_rol
		)
		po=GetDialogPos kkkkRollout
		createdialog code_rol style:#() pos:[po.x,(po.y-260)]
	)
	on kkkkRollout open do edt1.text=(CreateNUM(sysInfo.username+sysInfo.computername)+"v"+::r8dStart.VVV)
	on btn1 pressed do(
		if edt1.text == (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "c") then(
			try(f = CreateFile ::r8dfn.TmpF)catch(messagebox "请尝试以管理员身份登录Windows或者先关闭MAX，在MAX程序图标右键选择以管理员身份运行MAX程序，再重试激活。" title:"CD-KEY Fail!")
			if f != undefined then(
			-- if edt1.text == (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "c") do(
				format "%\n" ("\""+(::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "kkk")+"\"") to:f
				::r8dui.r8ui.renderDir_btn.text = ">>> START <<<"
				::r8dui.r8ui.title = ("R8D v"+::r8dStart.VVV)
				::r8dui.r8ui.chose_btn.enabled = true
				::r8dui.r8ui.getSS_chk.enabled = true
			::r8dui.r8ui.E_btn.enabled = true
			::r8dui.r8ui.EN_btn.enabled = true
			::r8dui.r8ui.N_btn.enabled = true
			::r8dui.r8ui.WN_btn.enabled = true
			::r8dui.r8ui.W_btn.enabled = true
			::r8dui.r8ui.WS_btn.enabled = true
			::r8dui.r8ui.O_btn.enabled = true
			::r8dui.r8ui.All_chkbtn.enabled = true
				if ::r8dfn.RS_rol != undefined do ::r8dfn.RS_rol.helpFN_btn.enabled = true
				if ::r8dui.r8ui.getani_chk.checked == false do ::r8dui.r8ui.rSingle_btn.enabled = true
			
			close f
			try(
			if (encryptFile ::r8dfn.TmpF ::r8dfn.CDKEYP ::r8dStart.CODEPOW)==OK then(
				deletefile ::r8dfn.TmpF
				if (messagebox "恭喜您的R8D注册成功，全部功能已开通，欢迎使用！" title:"CD-KEY OK..." beep:false)==OK do(
					destroyDialog kkkkRollout
				)
			)else(
				messagebox "KEY正确，但创建激活文件失败，请尝试以管理员身份登录Windows，或者先关闭MAX，在MAX程序图标右键选择以管理员身份运行MAX程序，再重试激活。" title:"CD-KEY Fail!"
			)
			)catch()
			)else(
				messagebox "请尝试以管理员身份登录Windows，或者先关闭MAX，在MAX程序图标右键选择以管理员身份运行MAX程序，再重试激活。" title:"CD-KEY Fail!"
			)
		)else(
				messagebox "KEY错误，请重新输入！" title:"CD-KEY Fail!"
			)
		)
)
rollout rs_Rollout "Render Setting" width:214 height:406
(
	button refreRS_btn "刷新" pos:[1,2] width:32
	dropDownList selR_ddl "" width:172 height:22 items:::r8dfn.RNL pos:[35,2]
	button getPreset_btn "读取>" width:40 height:18 pos:[3,24] tooltip:": 选择渲染预设\n +shift : 保存当前渲染设置预设\n RMB : 指定预设读取路径"
	checkbutton useColorSet_chk "读取预设文件.rps" width:160 height:18 highlightColor: (color 30 160 82) pos:[45,24] tooltip:"批量渲染时自动运用渲染预设\n RMB : 读取指定的渲染预设"
	label BG_color "BGcolor:" across:4 offset:[-6,-2]
	label T_color "Tint:" offset:[-6,-2]
	label T_level "Level:" offset:[-2,-2]
	label AB_color "Ambient:" offset:[5,-2]
	colorPicker BGcolor_cp "" width:50 height:20 across:4 offset:[-12,0]
	colorPicker Tintcolor_cp "" width:50 height:20 offset:[-10,0]
	spinner LightLevel_spn "" width:50 range:[0,100,1] type:#float scale:0.1 offset:[-12,2]
	colorPicker ABcolor_cp "" width:50 height:20 offset:[0,0]
	subrollout rs_SubRollout "" pos:[0,92] width:(::r8dfn.RS_rol.width) height:(::r8dfn.RS_rol.height-115)
	checkButton createLightS "L" pos:[5,385] width:19 height:19 tooltip:"增强功能" highlightColor:(color 30 120 252)
	checkbutton helpFN_btn "H" pos:[28,385] width:19 height:19 tooltip:"强大的辅助功能" highlightColor:(color 20 180 222)
	fn refreshRS = (
		selR_ddl.selection = CurRenNum()
		BGcolor_cp.color = backgroundColor
		Tintcolor_cp.color = lightTintColor
		ABcolor_cp.color = ambientColor
		LightLevel_spn.value = lightLevel
	)
	-----------Function End-------------------
	on getPreset_btn pressed do(
		::r8dfn.MAXPreset_fn()
	)
	on getPreset_btn rightclick do(
		psE = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSPath"
		PSP = getSavePath caption:"指定渲染预设路径" initialDir:psE
		if PSP != undefined do(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSPath" PSP
		)
	)
	on refreRS_btn pressed do refreshRS()
	on helpFN_btn changed state do (
		if state then(
			addSubRollout rs_SubRollout ::r8dfn.H_rol rolledUp: false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "HHH" "true"
		)else(
			removeSubRollout rs_SubRollout ::r8dfn.H_rol
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "HHH" "false"
		)
	)
	on rs_Rollout open do(
if doesFileExist "$scripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp" do (
	local IPC = openbitmap "$scripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp"
	helpFN_btn.images = #(IPC,IPC,32,23,23,23,23)
	createLightS.images = #(IPC,IPC,32,1,1,1,1)
)
		-- keey = ::r8dfn.getkkkk()
		-- if keey != (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "kkk") do(
			-- helpFN_btn.enabled = false
			-- setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "HHH" "false"
		-- )
		helpFN_btn.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "HHH")
		refreshRS()
		createLightS.checked = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "LLL" )
		if createLightS.checked do addSubRollout rs_SubRollout ::r8dfn.RS_CL rolledUp: false
		useColorSet_chk.checked = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" )
		usePS = ::r8dui.r8ui.rps_txt.text
		if  doesFileExist(usePS) do(
			uPStmp = filterstring usePS "\\"
			useColorSet_chk.text = uPStmp[uPStmp.count]
		)
		if (not doesFileExist(usePS)) then(
			useColorSet_chk.checked = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" "false"
		)
	)
	on useColorSet_chk changed state do(
		if doesFileExist(::r8dui.r8ui.rps_txt.text) then
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" (state as string)
		else(
			messagebox "请指定一个渲染预设.rps文件" title:"R8D"
			useColorSet_chk.checked = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "RSUSECOMMON" "false"
		)
		if doesFileExist(::r8dui.r8ui.rps_txt.text) do ::r8dui.r8ui.useColorSet_chk.checked = state
	)
	on useColorSet_chk rightclick do(
		if doesFileExist(::r8dui.r8ui.rps_txt.text) do
		if (querybox "确定要读取当前指定的渲染预设吗？") do
			renderpresets.LoadAll 0 (::r8dui.r8ui.rps_txt.text)
	)
	on LightLevel_spn changed val do(
		lightLevel = val
	)
	on BGcolor_cp changed color do(
		backgroundColor = color
	)
	on Tintcolor_cp changed color do(
		lightTintColor = color
	)
	on ABcolor_cp changed color do(
		ambientColor = color
	)
	on selR_ddl selected item do(
		try(renderers.production = ::r8dfn.RRRer[item]())catch(messagebox "渲染器设置有误，你可能没有安装该渲染器")
		refreshRS()
	)
	on createLightS changed state do(
		if state then(
			addSubRollout rs_SubRollout ::r8dfn.RS_CL rolledUp: false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "LLL" "true" 
		)else(
			removeSubRollout rs_SubRollout ::r8dfn.RS_CL
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "RS" "LLL" "false" 
		)
	)
)
rollout PSList_rol "选择预设" width:192 height:270
(
	listBox PS_lbx "" pos:[6,8] width:180 height:18
	checkbox PSsub_chk "查子目录" offset:[0,-3] across:1
	on PSList_rol close do setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSListUIpos" ((getDialogPos PSList_rol)as string)
	on PSList_rol open do(
		PSsub_chk.checked = ::r8dfn.ConvertToBool( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSSubPathCHK")
		::r8dfn.getRpsNum()
		PS_lbx.selection = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSlistSel")as integer
	)
	on PS_lbx doubleclicked item do(
		psE = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSPath"
		if PSsub_chk.checked then(
			::r8dfn.RmFilesPS = #()	--Info: RmFiles里包含文件夹(***)和文件(c:\text\text.max)	在 ::r8dfn.findSubDir_FN 函数执行完成后被赋值
			::r8dfn.findSubDirPS_FN psE
			if ::r8dfn.RmFilesPS[PS_lbx.selection] == "***" then(
				messagebox "不要选中带[+]的文件夹！" title:"R8D"
				files = #()
			)else(files = ::r8dfn.RmFilesPS)
		)else(
			files = getFiles (psE+"\\*.rps")
		)
		if files.count > 0 do(
			::r8dfn.RS_rol.useColorSet_chk.text = PS_lbx.selected
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSfileUse" files[PS_lbx.selection]
			::r8dui.r8ui.rps_txt.text = files[PS_lbx.selection]
			::r8dui.r8ui.useColorSet_chk.tooltip = ("批量渲染时自动运用渲染预设\n"+::r8dui.r8ui.rps_txt.text)
			::r8dui.r8ui.rps_tv.text = ("[ "+(getFilenamefile ::r8dui.r8ui.rps_txt.text)+".rps ]")
			destroyDialog PSList_rol
		)
	)
	on PS_lbx selected item do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSlistSel" (item as string)
	)
	on PSsub_chk changed state do(
		::r8dfn.getRpsNum()
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSSubPathCHK" (state as string)
	)
)
rollout RS_CLight_Rollout "Lightting"
(
--	bitmap cc_bmp pos:[0,0] width:193 height:8 bitmap:(bitmap 195 8 color: (color 30 120 252))
	imgTag cc_img pos:[2,0] width:189 height:5 bitmap:(bitmap 195 8 color: (color 30 120 252))
	button btn1 "Light01" pos:[5,10] tooltip:"创建灯光模板01\\右键删除"
	spinner CLScale_spn "Scale:" pos:[73,12] width:70 range:[0.1,80,1] scale:0.01
	button btn2 "Floor" pos:[147,10] tooltip:"创建接收阴影地板"
	imgTag cc2_img offset:[-11,0] width:189 height:3 bitmap:(bitmap 195 8 color: (color 30 120 252)) across:1
	fn CreateFloor = (
		if $CL_DirectLight != undefined then(
			delete $CL_DirectLight
			delete $CL_floorLight1
			delete $CL_floorLight2
			delete $CL_floorLight3
			delete $CL_floorLight4
			delete $CL_floorLight5
			delete $CL_floorLight6
			delete $CL_floorLight7
			delete $CL_floorLight8
			delete $CL_floorLight9
			delete $CL_floorLight10
			delete $CL_floorLight11
			delete $CL_floorLight12
		)
		
		if $ScaleL_dummy != undefined do delete $ScaleL_dummy
		Dummy name:"ScaleL_dummy" pos:[0,0,0] isHidden: on
		TargetDirectionallight name:"CL_DirectLight" rgb:(color 255 255 255) shadowColor:(color 3 0 10) multiplier:1 castShadows:on samplerange:16 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 shadowMultiplier:1\
hotspot:180 falloff:200 aspect:1 pos:[12,-42,200] isSelected:off target:(Targetobject transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0])) parent:$ScaleL_dummy
		Omnilight name:"CL_floorLight1" rgb:(color 144 183 205) pos:[140,0,-150] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight2" rgb:(color 155 154 210) pos:[-140,0,-150] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight3" rgb:(color 172 183 135) pos:[0,-140,-150] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight4" rgb:(color 144 205 187) pos:[0,140,-150] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight5" rgb:(color 182 172 124) pos:[0,256,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight6" rgb:(color 182 172 124) pos:[0,-256,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight7" rgb:(color 182 172 124) pos:[181,181,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight8" rgb:(color 182 172 124) pos:[-181,-181,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight9" rgb:(color 182 172 124) pos:[256,0,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight10" rgb:(color 182 172 124) pos:[-256,0,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight11" rgb:(color 182 172 124) pos:[181,-181,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off
		Omnilight name:"CL_floorLight12" rgb:(color 182 172 124) pos:[-181,181,27] multiplier:0.1 contrast:0 softenDiffuseEdge:0 nearAttenStart:0 nearAttenEnd:40 farAttenStart:80 farAttenEnd:200 decayRadius:40 atmosOpacity:100 atmosColorAmt:100 parent:$ScaleL_dummy isFrozen:true showFrozenInGray:off

		if $Floor_For_Shadow == undefined then Plane name:"Floor_For_Shadow" length:500 width:500 pos:[0,0,0] isSelected:off parent:$ScaleL_dummy isFrozen:true showFrozenInGray:on
		meditMaterials[24] = MatteShadow shadowBrightness:0.2
		$Floor_For_Shadow.material = meditMaterials[24]
		meditMaterials[24] = Standard ()
		$ScaleL_dummy.scale=[CLScale_spn.value,CLScale_spn.value,CLScale_spn.value]
	)
	-------------------------
	on btn2 pressed do(
		if $ScaleL_dummy == undefined do Dummy name:"ScaleL_dummy" pos:[0,0,0] isHidden: on
		if $Floor_For_Shadow == undefined then(
			Plane name:"Floor_For_Shadow" length:500 width:500 pos:[0,0,0] isSelected:off isFrozen:true showFrozenInGray:on parent:$ScaleL_dummy
			meditMaterials[24] = MatteShadow shadowBrightness:0.2
			$Floor_For_Shadow.material = meditMaterials[24]
			meditMaterials[24] = Standard ()
		)else(messagebox "地板已经创建！" beep:false)
	)
	on btn2 rightclick do(
		if $Floor_For_Shadow != undefined do delete $Floor_For_Shadow
	)
	on CLScale_spn changed val do(
		if $ScaleL_dummy != undefined do $ScaleL_dummy.scale=[val,val,val]
	)
	on btn1 pressed do CreateFloor()
	on btn1 rightclick do(
		if $CL_DirectLight != undefined then(
			delete $CL_DirectLight
			delete $CL_floorLight1
			delete $CL_floorLight2
			delete $CL_floorLight3
			delete $CL_floorLight4
			delete $CL_floorLight5
			delete $CL_floorLight6
			delete $CL_floorLight7
			delete $CL_floorLight8
			delete $CL_floorLight9
			delete $CL_floorLight10
			delete $CL_floorLight11
			delete $CL_floorLight12
		)
	)
)
rollout rendering_rol "R8D Render Info" width: 390 height: 358(
	label lbl1 "正在渲染中，爱干啥干啥去吧......" pos:[30,20] width:320 height:15
	label lbl2 "（按Esc中断渲染）" pos:[280,5] width:150 height:15
	listbox Ring_lbx "" pos:[10,43] width:370 height:17
	button btn "OK" pos:[185,279]
	button openF_btn "打开目录" pos:[39,279] tooltip:"打开输出文件夹"
	label rC_lbl "0" pos:[3,311] visible:false
	progressBar load_pro2 color:(color 245 52 70) pos:[25,309] width:340 height:18
	label fC_lbl "0" pos:[369,311] visible:false
	progressBar load_pro color:(color 253 121 15) pos:[25,330] width:340 height:12
	progressBar load_pro3 color:(color 245 161 15) pos:[25,345] width:340 height:10 visible:false
	on btn pressed do destroydialog rendering_rol
	on openF_btn pressed do(
		shellLaunch "Explorer.EXE" ::r8dui.r8ui.outDir_edt.text
	)
)
--辅助功能---------------------------------------------
rollout HelpFN_rollout "辅助功能" width:214 height:183
(
	Group "(RepDel)批量替换或清除"(
	button getDR_btn ".MAX" offset:[-33,0] width:31 height:17 tooltip:"指定带像机或灯光的max文件/右键获取列表中选中的场景" across:2
	editText DR_edt "" offset:[-63,0] width:155 height:17
	checkbox lig_chk "灯光" width:48 height:15 across:2
	checkbox cam_chk "摄像机" width:60 height:15
	checkbox cusname_chk "指定名称" width:72 height:15 across:2
	checkbox tcam_chk "工具像机" width:72 height:15
	editText cusname_edt "" width:187 height:17 across:1 offset:[-7,0]
	checkbutton useScrt "右键指定脚本文件" width:180 height:17 across:1 offset:[0,0] tooltip:"激活执行脚本\\RMB: 指定脚本文件（在所有命令后执行）"
	checkbox DRRep_chk "备份原文件"align:#left across:1
	button replace_btn ">批量替换<" tooltip:"批量替换灯光像机及指定物体" across:2 align:#right
	button clearLight_btn ">批量清除<" tooltip:"批量清除指定物件" align:#right
	)
	Group "(RS)批量应用渲染设置及灯光"(
	button getM_btn ".MAX" offset:[-33,0] width:31 height:17 tooltip:"指定要应用渲染设置的max文件/右键获取列表中选中的场景" across:2
	editText edt1 "" offset:[-63,0] width:155 height:17
	checkbox useCurS_chk "用当前场景" across:2
	checkbox outputRep_chk "备份原文件"
	label rsUse_lbl "！分块前应用" across:2
	button doHFN_btn ">批量应用<" align:#right tooltip:"批量应用指定场景的渲染设置，注意该操作将去除分块！"
	)
	Group "(SS)批量应用分块"(
	button getSS_btn ".MAX" width:31 height:17 tooltip:"指定带正确分块的max文件/右键获取列表中选中的场景" offset:[-33,0] across:2
	edittext ssMax_edt "" width:157 height:17 offset:[-63,0]
	checkbox useCurSss_chk "用当前场景" across:2
	checkbox RepDirSS_chk "备份原文件"
	checkbox megMask_chk "导入遮罩物" across:2
	checkbox useMaskmat_chk "设置遮罩物体"
	button getMaskObjN_btn "获取遮罩" width:55 height:18 align:#left offset:[-5,0] across:2 tooltip:"可选择多个物体作为遮罩物体，批量应用时所有场景的相同物体也会被赋予和指定的物体相同的材质和属性"
	edittext maskName_edt "" width:130 height:17 offset:[-37,0] align:#left
	button SetMask "设置为遮罩" align:#left height:18 tooltip:"对选择的物体进行遮罩设置(自动匹配渲染器)\\右键还原上次操作(并去除遮罩物体标记)" across:2
	checkbox CSh_chk "接收阴影"
	button doGetSS_btn ">批量应用<" align:#right tooltip:"批量复制指定场景的分块到选中的场景" across:1
	)
	on useScrt changed state do setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPTCHK" (state as string)
	on useScrt rightclick do(
		pp = getOpenFileName caption:"选择脚本文件" filename:(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPT") types:"MS(*.ms)|*.ms|MSE(*.mse)|*.mse|All(*.*)|*.*|"
		if pp != undefined do(
			f=filterstring pp "\\"
			useScrt.text=f[f.count]
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPT" pp
		)
		
	)
	on CSh_chk changed state do (setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CSHCHK" (state as string))
	on getSS_btn rightclick do(
		if ::r8dui.r8ui.getani_chk.checked then(
			messagebox "请取消 当前渲染 选项，以读取max文件。" title:"R8D"
		)else(
			if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
			try(
			if (querybox "确定要获取该场景吗？" title:"R8D") do(
				if ::r8dui.r8ui.subdir_chk.checked then(
					::r8dfn.RmFiles = #()
					::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
					Sta = 0
					for o in ::r8dui.r8ui.lbx1.selection do(
						if ::r8dfn.RmFiles[o] == "***" then Sta += 1
					)
					if Sta == 0 then files = ::r8dfn.RmFiles else(
						messagebox "不要选中带[+]的文件夹！" title:"R8D"
						files = #()
					)
				)else(
					files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
				)
				if files.count > 0 then(
				SELs=(::r8dui.r8ui.lbx1.selection as array).count
				if SELs == 1 then(
					ssMax_edt.text=files[(::r8dui.r8ui.lbx1.selection as array)[1]]
					setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "SSMAX" ssMax_edt.text
				)else(messagebox "只能选择一个max文件!" title:"R8D")
				)
			)
			)catch(messagebox "请指定正确的渲染路径..目录。" title:"R8D")
			)else(messagebox "请在列表中选择要应用的max文件。" title:"R8D")
		)
	)
	on HelpFN_rollout open do(
		if getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPT" != "" do(
			f=filterstring (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPT") "\\"
			useScrt.text=f[f.count]
		)
		useScrt.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPTCHK")
		edt1.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "RSMAX"
		ssMax_edt.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "SSMAX"
		DR_edt.text = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "DRMAX"
		DRRep_chk.checked = ::r8dfn.ConvertToBool(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DRREPCHK")
		lig_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTCHK" )
		cam_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CAMERACHK" )
		tcam_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TCAMERACHK" )
		cusname_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTNACHK" )
		useCurS_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USECURSCHK" )
		outputRep_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "REPLACEFILE" )
		RepDirSS_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "REPFILESS" )
		megMask_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "MEGMASK" )
		useCurSss_chk.checked = ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USECURSSCHK" )
		useMaskmat_chk.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USEMASKMAT")
		CSh_chk.checked = ::r8dfn.ConvertToBool(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CSHCHK")
		if useMaskmat_chk.checked == false do(
			getMaskObjN_btn.enabled = false
			maskName_edt.enabled = false
		)
		cusName=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTNAEDT"
		if cusName != "" then
			cusname_edt.text = cusName
		else
			cusname_edt.text = "name1,name2（逗号隔开）"
		if cusname_chk.checked then cusname_edt.enabled = true else cusname_edt.enabled = false
		AllSS=(for o in objects where (getUserProp o "00x_mask") == true collect o)
		if AllSS.count > 0 then (
			OName=""
			for o in AllSS do(
				if OName!="" then OName = (OName+","+o.name) else OName = o.name
			)
			maskName_edt.text = OName
		)else maskName_edt.text = ""
	)
	on SetMask pressed do(
		::r8dfn.SetOBJMasker CShadow:CSh_chk.checked
	)
	on SetMask rightclick do ::r8dfn.ResetSSmask()
	on useMaskmat_chk changed state do(
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USEMASKMAT" (state as string)
		getMaskObjN_btn.enabled = state
		maskName_edt.enabled = state
	)
	on getSS_btn pressed do(	
		pp = getOpenFileName caption:"选择一个带分块场景" filename:ssMax_edt.text types:"MAX(*.max)|*.max|"
		if pp != undefined do(
			ssMax_edt.text=pp
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "SSMAX" pp
		)
	)
	on getMaskObjN_btn pressed do(
		AllSS=(for o in objects where (getUserProp o "00x_mask") == true collect o)
		if AllSS.count > 0 then(
			OName=""
			for o in AllSS do(
				if OName!="" then OName = (OName+","+o.name) else OName = o.name
			)
			maskName_edt.text = OName
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "MASKSNAME" OName
		)else(
			messagebox "该场景没有遮罩物体！" title:"R8D" beep:false
			maskName_edt.text = ""
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "MASKSNAME" ""
		)
	)
	on replace_btn pressed do(
		if (querybox "确定要进行替换操作吗？" title:"Help辅助功能") do(
		if lig_chk.checked==false and cam_chk.checked==false then(
			messagebox "需要勾选替换灯光或像机选项！" title:"Help辅助功能"
		)else(
		if DR_edt.text == "" or DR_edt.text == "<--点这里指定" then(
			if (messagebox "请指定要进行批量替换的源MAX文件！" title:"Help辅助功能") == OK do
			DR_edt.text = "<--点这里指定"
		)else(
		try(
			if ::r8dui.r8ui.subdir_chk.checked then(
				::r8dfn.RmFiles = #()
				::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
				Sta = 0
				for o in ::r8dui.r8ui.lbx1.selection do(
					if ::r8dfn.RmFiles[o] == "***" then Sta += 1
				)
				if Sta == 0 then files = ::r8dfn.RmFiles else(
					messagebox "不要选中带[+]的文件夹！" title:"R8D"
					files = #()
				)
			)else(
				files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
			)
			if files.count > 0 then(
			SELs=(::r8dui.r8ui.lbx1.selection as array).count
			if SELs > 0 then(
				::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
				::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
				if ::r8dfn.UIx < 390 then
					createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
				else
					createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
				::r8dfn.RR_rol.load_pro2.visible = true
				::r8dfn.RR_rol.load_pro.visible = false
				::r8dfn.RR_rol.openF_btn.visible = false
				::r8dfn.RR_rol.lbl2.visible = false
				::r8dfn.RR_rol.lbl1.text = "正在批量替换......"
				rCount = 0
				rItem = #()
				loC2=1
				::r8dfn.RR_rol.load_pro2.value = 0
				for i in ::r8dui.r8ui.lbx1.selection do(
					FNa = filterstring files[i] "\\"
				FNaPat = filterstring files[i] "."
				if DRRep_chk.checked then(
				NFolder = ""
				for i = 1 to (FNa.count-1) do if NFolder=="" then NFolder = FNa[i] else NFolder = (NFolder+"\\"+FNa[i])
				NFolder = (NFolder+"_backup")
				makedir NFolder
				Finame = getfilenamefile files[i]
				BKfile = (NFolder+"\\"+Finame+".max")
					if (copyfile files[i] BKfile) then(
						rCount += 1
						insertitem ("    "+FNa[FNa.count]+" 备份成功") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)else(
					if (deletefile BKfile) do
					if (copyfile files[i] BKfile) do(
						rCount += 1
						insertitem ("    "+FNa[FNa.count]+" 旧备份被替换") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
					)
				)
					if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
						allL = (for o in objects where superclassof o == light collect o)
						if lig_chk.checked and allL.count > 0 do(
							delete allL
					rCount += 1
					insertitem ("    "+FNa[FNa.count]+"共换掉了 "+(allL.count as string)+" 个灯光") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
						allC = (for o in objects where superclassof o == camera collect o)
						if cam_chk.checked and allC.count > 0 do(
							delete allC
						if $qianFront != undefined do(
							try(
							delete $qianFront
							delete $D_1
							delete $D_2
							delete $D_3
							delete $D_4
							delete $D_5
							delete $D_6
							delete $D_7
							delete $D_8
							delete $Ccenter
							delete $AllCamera
							)catch()
							try(delete $R8D_Dummy)catch()
							for n in ::r8dStart.CNAME do(
								try delete (getnodebyname n) catch ()
							)
						)
					rCount += 1
					insertitem ("    "+FNa[FNa.count]+"共换掉了 "+(allC.count as string)+" 个摄像机") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
						if cusname_chk.checked do(
							if cusname_edt.text != "" then(
								NameS = filterstring cusname_edt.text ","
								for n in NameS do(
									try (delete (getnodebyname n)
					rCount += 1
					insertitem ("    "+FNa[FNa.count]+"清除了: "+n) rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
									)catch (
					rCount += 1
					insertitem ("              "+n+" 不存在！") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
									)
								)
							)
						)
		if (ismaxfile DR_edt.text) then(
			if (mergeMAXFile DR_edt.text #alwaysReparent #deleteOldDups #useMergedMtlDups quiet:true) then(
					if useScrt.checked do(
						try(filein (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "USESCRIPT")
				rCount += 1
				insertitem (" -- "+useScrt.text+" 脚本执行成功") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)catch(
				rCount += 1
				insertitem ("  *---"+useScrt.text+" 脚本执行有误！") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
					)
				if (saveMaxFile files[i] quiet:true) do(
				::r8dfn.RR_rol.load_pro2.value = 100.*loC2/SELs
				loC2+=1
				rCount += 1
				insertitem (" -- "+FNa[FNa.count]+" 替换完成") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)
			)else(
				rCount += 1
				insertitem ("  *---"+FNa[FNa.count]+" 替换不成功，源MAX文件可能是较高版本!") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
		)else(messagebox "请确认您指定的MAX源文件是否正确！" title:"Help辅助功能"
		exit
		)
						
					)else(
						rCount += 1
						insertitem (" !"+" --> "+FNa[FNa.count]+"  (无法打开)") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
				)
				rCount += 1
				insertitem (" 替换操作已经完成......") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "全部操作已完成"
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
			)else(messagebox "请在列表里选择要应用渲染设置的max文件，双击列表选择全部。" title:"R8D")
			)
		)catch(messagebox "请输入正确的渲染路径!" title:"Help辅助功能")
		)))
	)
	on getDR_btn pressed do(	
		pp = getOpenFileName caption:"选择带像机或灯光的场景" filename:DR_edt.text types:"MAX(*.max)|*.max|"
		if pp != undefined do(
			DR_edt.text=pp
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "DRMAX" pp
		)
	)
	on getDR_btn rightclick do(
		if ::r8dui.r8ui.getani_chk.checked then(
			messagebox "请取消 当前渲染 选项，以读取max文件。" title:"R8D"
		)else(
			if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
			try(
			if (querybox "确定要获取该场景吗？" title:"R8D") do(
				if ::r8dui.r8ui.subdir_chk.checked then(
					::r8dfn.RmFiles = #()
					::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
					Sta = 0
					for o in ::r8dui.r8ui.lbx1.selection do(
						if ::r8dfn.RmFiles[o] == "***" then Sta += 1
					)
					if Sta == 0 then files = ::r8dfn.RmFiles else(
						messagebox "不要选中带[+]的文件夹！" title:"R8D"
						files = #()
					)
				)else(
					files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
				)
				if files.count > 0 then(
				SELs=(::r8dui.r8ui.lbx1.selection as array).count
				if SELs == 1 then(
					DR_edt.text=files[(::r8dui.r8ui.lbx1.selection as array)[1]]
					setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "DRMAX" DR_edt.text
				)else(messagebox "只能选择一个max文件!" title:"R8D")
				)
			)
			)catch(messagebox "请指定正确的渲染路径..目录。" title:"R8D")
			)else(messagebox "请在列表中选择要应用的max文件。" title:"R8D")
		)
	)
	on DR_edt entered text do(
		if isMaxFile text then(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "DRMAX" text
		)else(messagebox "请输入正确的文件名和路径！" title:"Help辅助功能")
	)
	on getM_btn pressed do(	
		pp = getOpenFileName caption:"选择渲染设置场景" filename:edt1.text types:"MAX(*.max)|*.max|"
		if pp != undefined do(
			edt1.text=pp
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "RSMAX" pp
		)
	)
	on getM_btn rightclick do(
		if ::r8dui.r8ui.getani_chk.checked then(
			messagebox "请取消 当前渲染 选项，以读取max文件。" title:"R8D"
		)else(
			if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
			try(
			if (querybox "确定要获取该场景吗？" title:"R8D") do(
				if ::r8dui.r8ui.subdir_chk.checked then(
					::r8dfn.RmFiles = #()
					::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
					Sta = 0
					for o in ::r8dui.r8ui.lbx1.selection do(
						if ::r8dfn.RmFiles[o] == "***" then Sta += 1
					)
					if Sta == 0 then files = ::r8dfn.RmFiles else(
						messagebox "不要选中带[+]的文件夹！" title:"R8D"
						files = #()
					)
				)else(
					files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
				)
				if files.count > 0 then(
				SELs=(::r8dui.r8ui.lbx1.selection as array).count
				if SELs == 1 then(
					edt1.text=files[(::r8dui.r8ui.lbx1.selection as array)[1]]
					setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "RSMAX" edt1.text
				)else(messagebox "只能选择一个max文件!" title:"R8D")
				)
			)
			)catch(messagebox "请指定正确的渲染路径..目录。" title:"R8D")
			)else(messagebox "请在列表中选择要应用的max文件。" title:"R8D")
		)
	)
	on DRRep_chk changed state do
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DRREPCHK" (state as string)
	on lig_chk changed state do
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTCHK" (state as string)
	on cam_chk changed state do(
	if state then(
		tcam_chk.checked = true
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CAMERACHK" "true"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TCAMERACHK" "true"
	)else
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CAMERACHK" "false"
	)
	on tcam_chk changed state do(
	if state then
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TCAMERACHK" "true"
	else
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "TCAMERACHK" "false"
	)
	on useCurS_chk changed state do(
	if state then
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USECURSCHK" "true"
	else
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USECURSCHK" "false"
	)
	on outputRep_chk changed state do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "REPLACEFILE" (state as string)
	)
	on RepDirSS_chk changed state do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "REPFILESS" (state as string)
	)
	on megMask_chk changed state do(
		if state then
			if (querybox "确定要导入带_mask后缀的物体吗？注意暂不支持带蒙皮的遮罩物体！" title:"Help辅助功能") then(
				setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "MEGMASK" "true"
			)else(
				megMask_chk.checked = false
			)
		else
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "MEGMASK" "false"
	)
	on useCurSss_chk changed state do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USECURSSCHK" (state as string)
	)
	on cusname_chk changed state do(
	if state then(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTNACHK" "true"
		cusname_edt.enabled = true
	)else(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTNACHK" "false"
		cusname_edt.enabled = false
	)
	)
	on cusname_edt changed text do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CUSTNAEDT" text
	)
	on ssMax_edt entered text do(
		if isMaxFile text then(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "SSMAX" text
		)else(messagebox "请输入正确的文件名和路径！" title:"Help辅助功能")
	)
	on edt1 entered text do(
		if isMaxFile text then(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "HelpFunction" "RSMAX" text
		)else(messagebox "请输入正确的文件名和路径！" title:"Help辅助功能")
	)
	on clearLight_btn pressed do(
		if (querybox "确定要进行场景清除物件操作吗？" title:"Help辅助功能") do(
		if lig_chk.checked==false and cam_chk.checked==false and tcam_chk.checked==false and cusname_chk.checked==false then(
			messagebox "需要选择要清除的物体类型！" title:"Help辅助功能"
		)else(
		try(
			if ::r8dui.r8ui.subdir_chk.checked then(
				::r8dfn.RmFiles = #()
				::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
				Sta = 0
				for o in ::r8dui.r8ui.lbx1.selection do(
					if ::r8dfn.RmFiles[o] == "***" then Sta += 1
				)
				if Sta == 0 then files = ::r8dfn.RmFiles else(
					messagebox "不要选中带[+]的文件夹！" title:"R8D"
					files = #()
				)
			)else(
				files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
			)
			if files.count > 0 then(
			SELs=(::r8dui.r8ui.lbx1.selection as array).count
			if SELs > 0 then(
				::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
				::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
				if ::r8dfn.UIx < 390 then
					createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
				else
					createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
				::r8dfn.RR_rol.load_pro2.visible = true
				::r8dfn.RR_rol.load_pro.visible = false
				::r8dfn.RR_rol.openF_btn.visible = false
				::r8dfn.RR_rol.lbl2.visible = false
				::r8dfn.RR_rol.lbl1.text = "正在批量清除场景......"
				rCount = 0
				rItem = #()
				loC2=1
				::r8dfn.RR_rol.load_pro2.value = 0
				for i in ::r8dui.r8ui.lbx1.selection do(
					FNa = filterstring files[i] "\\"
				FNaPat = filterstring files[i] "."
				if DRRep_chk.checked then(
				NFolder = ""
				for i = 1 to (FNa.count-1) do if NFolder=="" then NFolder = FNa[i] else NFolder = (NFolder+"\\"+FNa[i])
				NFolder = (NFolder+"_backup")
				makedir NFolder
				Finame = getfilenamefile files[i]
				BKfile = (NFolder+"\\"+Finame+".max")
					if (copyfile files[i] BKfile) then(
						rCount += 1
						insertitem ("    "+FNa[FNa.count]+" 备份成功") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)else(
					if (deletefile BKfile) do
					if (copyfile files[i] BKfile) do(
						rCount += 1
						insertitem ("    "+FNa[FNa.count]+" 旧备份被替换") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
					)
				)
					if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
						allL = (for o in objects where superclassof o == light collect o)
						allC = (for o in objects where superclassof o == camera collect o)
						if lig_chk.checked do(
							delete allL
					rCount += 1
					insertitem ("    "+FNa[FNa.count]+"共清除了 "+(allL.count as string)+" 个灯光") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
						if cam_chk.checked do(
							delete allC
					rCount += 1
					insertitem ("    "+FNa[FNa.count]+"共清除了 "+(allC.count as string)+" 个摄像机") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
						if tcam_chk.checked do(
							try(
							delete $qianFront
							delete $D_1
							delete $D_2
							delete $D_3
							delete $D_4
							delete $D_5
							delete $D_6
							delete $D_7
							delete $D_8
							delete $Ccenter
							delete $AllCamera
							)catch()
							try(delete $R8D_Dummy)catch()
							for n in ::r8dStart.CNAME do(
								try delete (getnodebyname n) catch ()
							)
						)
						if cusname_chk.checked do(
							if cusname_edt.text != "" then(
								NameS = filterstring cusname_edt.text ","
								for n in NameS do(
									try delete (getnodebyname n) catch ()
								)
							)
						)
							if (saveMaxFile files[i] quiet:true) do(
					::r8dfn.RR_rol.load_pro2.value = 100.*loC2/SELs
					loC2+=1
					rCount += 1
					insertitem (" -- "+FNa[FNa.count]+" 清除完成") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)
					)else(
						rCount += 1
						insertitem (" !"+" --> "+FNa[FNa.count]+"  (无法打开)") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
				)
				rCount += 1
				insertitem (" 清除操作已经完成......") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "全部操作已完成"
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
			)else(messagebox "请在列表里选择要应用渲染设置的max文件，双击列表选择全部。" title:"R8D")
			)
		)catch(messagebox "请输入正确的渲染路径!" title:"Help辅助功能")
		))
	)
	on doGetSS_btn pressed do(
		if (querybox "确定要进行批量复制分块操作吗？" title:"Help辅助功能") do(
		if ssMax_edt.text == "" and useCurSss_chk.checked == false or ssMax_edt.text == "<--点这里指定" and useCurSss_chk.checked == false then(
			if (messagebox "请指定要进行批量分块复制的源MAX文件！" title:"Help辅助功能") == OK do
			ssMax_edt.text = "<--点这里指定"
		)else(
	try(
		if ::r8dui.r8ui.subdir_chk.checked then(
			::r8dfn.RmFiles = #()
			::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
			Sta = 0
			for o in ::r8dui.r8ui.lbx1.selection do(
				if ::r8dfn.RmFiles[o] == "***" then Sta += 1
			)
			if Sta == 0 then files = ::r8dfn.RmFiles else(
				messagebox "不要选中带[+]的文件夹！" title:"R8D"
				files = #()
			)
		)else(
			files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
		)
		if files.count > 0 then(
		SELs=(::r8dui.r8ui.lbx1.selection as array).count
		if SELs > 0 then(
			::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
			::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
			if ::r8dfn.UIx < 390 then
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			else
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			::r8dfn.RR_rol.load_pro2.visible = true
			::r8dfn.RR_rol.load_pro.visible = false
			::r8dfn.RR_rol.openF_btn.visible = false
			::r8dfn.RR_rol.lbl2.visible = false
			::r8dfn.RR_rol.lbl1.text = "正在批量应用分块设置......"
			rCount = 0
			rItem = #()
			loC2=1
			HAVEMask = false
			HAVESS = false
			NoERROR = true
			ERRMsg = true
			MASKmat = undefined
			--VRay properties
			Matte_Enable = false
			Matte_Alpha = 1
			Matte_Shadows = false
			Matte_ShadowAlpha = false
			Matte_ShadowColor = [0,0,0]
			
			::r8dfn.RR_rol.load_pro2.value = 0
		--work in here
			if useCurSss_chk.checked then(
				if megMask_chk.checked do(
				select $*_mask
				if selection.count > 0 do(
					if (saveNodes selection ("$temp\mask_tmp.max") quiet:true)==OK do HAVEMask=true
				))
			if useMaskmat_chk.checked do(
				if maskName_edt.text != "" do(
					allMaskN = filterstring maskName_edt.text ","
					maskOMat = getnodebyname allMaskN[1]
					curR = filterstring (renderers.production as string) "_"
					if curR[1] == "V" then(
						Matte_Enable = getUserProp maskOMat "VRay_Matte_Enable"
						Matte_Alpha = getUserProp maskOMat "VRay_Matte_Alpha"
						Matte_Shadows = getUserProp maskOMat "VRay_Matte_Shadows"
						Matte_ShadowAlpha = getUserProp maskOMat "VRay_Matte_ShadowAlpha"
						Matte_ShadowColor = getUserProp maskOMat "VRay_Matte_ShadowColor"
					)else(
						if maskOMat != undefined do
							MASKmat = maskOMat.material
					)
				)
			)
			--input
				SSs=getNumNamedSelSets()
				if SSs > 0 then(
				setinisetting ("$temp\mask_tmp.ini") "SS" "SScount" (SSs as string)
				aSet=selectionSets
				-- SelSets=#()
				for i =1 to SSs do(
					setinisetting ("$temp\mask_tmp.ini") "SS" (i as string) (aSet[i].name)
					os = getNamedSelSetItemCount i
					setinisetting ("$temp\mask_tmp.ini") "SS" (aSet[i].name) (os as string)
					for item in 1 to os do(
						setinisetting ("$temp\mask_tmp.ini") (aSet[i].name) (item as string) ((getNamedSelSetItem i item).name)
					)
				)--input end
				HAVESS = true
							rCount += 1
							insertitem ("   目标场景共有 "+(SSs as string)+" 个分块，"+(selection.count as string)+" 个静态遮罩物体。") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)else( messagebox "当前场景里没有创建模型分块！" title:"Help辅助功能")
			)else(
				if (loadMaxFile ssMax_edt.text useFileUnits:true quiet:true) then (
					if megMask_chk.checked do(
					select $*_mask
					if selection.count > 0 do(
						if (saveNodes selection ("$temp\mask_tmp.max") quiet:true)==OK do HAVEMask=true
					))
					if useMaskmat_chk.checked do(
						if maskName_edt.text != "" do(
							allMaskN = filterstring maskName_edt.text ","
							maskOMat = getnodebyname allMaskN[1]
							curR = filterstring (renderers.production as string) "_"
							if curR[1] == "V" then(
								Matte_Enable = getUserProp maskOMat "VRay_Matte_Enable"
								Matte_Alpha = getUserProp maskOMat "VRay_Matte_Alpha"
								Matte_Shadows = getUserProp maskOMat "VRay_Matte_Shadows"
								Matte_ShadowAlpha = getUserProp maskOMat "VRay_Matte_ShadowAlpha"
								Matte_ShadowColor = getUserProp maskOMat "VRay_Matte_ShadowColor"
							)else(
								if maskOMat != undefined do
									MASKmat = maskOMat.material
							)
						)
					)
				--input
					SSs=getNumNamedSelSets()
					if SSs > 0 then(
					setinisetting ("$temp\mask_tmp.ini") "SS" "SScount" (SSs as string)
					aSet=selectionSets
					-- SelSets=#()
					for i =1 to SSs do(
						setinisetting ("$temp\mask_tmp.ini") "SS" (i as string) (aSet[i].name)
						os = getNamedSelSetItemCount i
						setinisetting ("$temp\mask_tmp.ini") "SS" (aSet[i].name) (os as string)
						for item in 1 to os do(
							setinisetting ("$temp\mask_tmp.ini") (aSet[i].name) (item as string) ((getNamedSelSetItem i item).name)
						)
					)--input end
				HAVESS = true
							rCount += 1
							insertitem ("   目标场景共有 "+(SSs as string)+" 个分块，"+(selection.count as string)+" 个静态遮罩物体。") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)else( messagebox "您指定的max档里没有创建模型分块！" title:"Help辅助功能")
				)
			)
		if HAVESS do(
		for i in ::r8dui.r8ui.lbx1.selection do(
			if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
			NoERROR = true
				FNa = filterstring files[i] "\\"
				FNaPat = filterstring files[i] "."
				if RepDirSS_chk.checked then(
				NFolder = ""
				for i = 1 to (FNa.count-1) do if NFolder=="" then NFolder = FNa[i] else NFolder = (NFolder+"\\"+FNa[i])
				NFolder = (NFolder+"_backup")
				makedir NFolder
				Finame = getfilenamefile files[i]
				BKfile = (NFolder+"\\"+Finame+".max")
					if (copyfile files[i] BKfile) then(
						rCount += 1
						insertitem ("    "+FNa[FNa.count]+" 备份成功") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)else(
					if (deletefile BKfile) do
					if (copyfile files[i] BKfile) do(
						rCount += 1
						insertitem ("    "+FNa[FNa.count]+" 旧备份被替换") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
					)
				)
		--delete all SS
			oldSSs=getNumNamedSelSets()
			for i in 1 to oldSSs do (deleteItem selectionSets selectionSets[1])
			--设置mask材质
			if useMaskmat_chk.checked do(
				if maskName_edt.text != "" do(
					allMaskN = filterstring maskName_edt.text ","
					curR = filterstring (renderers.production as string) "_"
					for o in allMaskN do(
						maskOMat = getnodebyname o
						if maskOMat != undefined do
						if curR[1] == "V" then(
							setUserProp maskOMat "VRay_Matte_Enable" Matte_Enable
							setUserProp maskOMat "VRay_Matte_Alpha" Matte_Alpha
							setUserProp maskOMat "VRay_Matte_Shadows" Matte_Shadows
							setUserProp maskOMat "VRay_Matte_ShadowAlpha" Matte_ShadowAlpha
							setUserProp maskOMat "VRay_Matte_ShadowColor" Matte_ShadowColor
						)else(
							maskOMat.material = MASKmat
						)
					)
				)
			)
				if HAVEMask and megMask_chk.checked do (mergeMAXFile ("$temp\mask_tmp.max") #deleteOldDups #useMergedMtlDups quiet:true)
			--output
				SSc=(getinisetting ("$temp\mask_tmp.ini") "SS" "SScount")as integer
				for i in 1 to SSc do(
					SOBJ=#()
					sName = (getinisetting ("$temp\mask_tmp.ini") "SS" (i as string))
					sNnum = (getinisetting ("$temp\mask_tmp.ini") "SS" sName) as integer
					for ii in 1 to sNnum do(
						append SOBJ (getnodebyname((getinisetting ("$temp\mask_tmp.ini") sName (ii as string))))
					)
					try(selectionSets[sName] = SOBJ)catch(
						if ERRMsg do(
							rCount += 1
							insertitem (" -- "+FNa[FNa.count]+"应用分块不完全！检查场景模型是否一至") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
							NoERROR = false
							ERRMsg = false
						)
					)
				)--output end
					saveMaxFile files[i] quiet:true
				if NoERROR do(
					::r8dfn.RR_rol.load_pro2.value = 100.*loC2/SELs
					loC2+=1
					rCount += 1
					insertitem (" -- "+FNa[FNa.count]+" 分块创建完成") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)
			)
			ERRMsg = true
		)
				if NoERROR then(
							rCount += 1
							insertitem (" 批量应用分块已成功完成......") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "批量应用分块已完成。"
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
				)else(
							rCount += 1
							insertitem (" 批量应用分块操作完成，未全部成功！......") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "批量应用分块有误，请检查。"
				)
	deletefile ("$temp\mask_tmp.ini")
		)
		)else(messagebox "请在列表里选择要应用渲染设置的max文件，双击列表选择全部。" title:"Help辅助功能")
		)
	)catch(messagebox "请输入正确的渲染路径!" title:"Help辅助功能")
	)))
	
	on doHFN_btn pressed do(
	if (querybox "确定要进行应用渲染设置场景操作吗？注意以下几点：\n1.该应用后场景中的分块将会消失\n2.如果场景中有添加Effects特效（快捷键8）将不会保持" title:"Help辅助功能") do(
		if edt1.text == "" and useCurS_chk.checked == false or edt1.text == "<--点这里指定" and useCurS_chk.checked == false then(
			if (messagebox "请指定要进行批量渲染设置应用的源MAX文件！" title:"Help辅助功能") == OK do
			edt1.text = "<--点这里指定"
		)else(
	try(
		if ::r8dui.r8ui.subdir_chk.checked then(
			::r8dfn.RmFiles = #()
			::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
			Sta = 0
			for o in ::r8dui.r8ui.lbx1.selection do(
				if ::r8dfn.RmFiles[o] == "***" then Sta += 1
			)
			if Sta == 0 then files = ::r8dfn.RmFiles else(
				messagebox "不要选中带[+]的文件夹！" title:"R8D"
				files = #()
			)
		)else(
			files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
		)
		if files.count > 0 then(
		SELs=(::r8dui.r8ui.lbx1.selection as array).count
		if SELs > 0 then(
			::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
			::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
			if ::r8dfn.UIx < 390 then
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			else
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			::r8dfn.RR_rol.load_pro2.visible = true
			::r8dfn.RR_rol.load_pro.visible = false
			::r8dfn.RR_rol.openF_btn.visible = false
			::r8dfn.RR_rol.lbl2.visible = false
			::r8dfn.RR_rol.lbl1.text = "正在批量应用渲染设置......"
			rCount = 0
			rItem = #()
			loC2=1
			::r8dfn.RR_rol.load_pro2.value = 0
			if useCurS_chk.checked then(
				SUnit = units.SystemType
				holdMaxFile()
				for i in ::r8dui.r8ui.lbx1.selection do(
					FNa = filterstring files[i] "\\"
				FNaPat = filterstring files[i] "."
						if outputRep_chk.checked then(
				NFolder = ""
				for i = 1 to (FNa.count-1) do if NFolder=="" then NFolder = FNa[i] else NFolder = (NFolder+"\\"+FNa[i])
				NFolder = (NFolder+"_backup")
				makedir NFolder
				Finame = getfilenamefile files[i]
				BKfile = (NFolder+"\\"+Finame+".max")
							if (copyfile files[i] BKfile) then(
								rCount += 1
								insertitem ("    "+FNa[FNa.count]+" 备份成功") rItem rCount
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)else(
							if (deletefile BKfile) do
							if (copyfile files[i] BKfile) do(
								rCount += 1
								insertitem ("    "+FNa[FNa.count]+" 旧备份被替换") rItem rCount
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)
							)
						)
					if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
						aniSE = animationRange
						units.SystemType = SUnit
					)
					fetchMaxFile quiet:true
					if (mergeMAXFile files[i] #deleteOldDups #useMergedMtlDups #alwaysReparent quiet:true) then(
						animationRange = aniSE
						if (saveMaxFile files[i] quiet:true) then(
							::r8dfn.RR_rol.load_pro2.value = 100.*loC2/SELs
							loC2+=1
							rCount += 1
							insertitem (" -- "+FNa[FNa.count]+" 渲染参数应用完成") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
					)else(
						rCount += 1
						insertitem (" !"+" --> "+FNa[FNa.count]+"  (无法打开)") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
					fetchMaxFile quiet:true
				)
							rCount += 1
							insertitem (" 应用渲染设置已完成......") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "应用渲染设置已完成。"
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
				
			)else(
				if (ismaxfile edt1.text) then(
				if (loadMaxFile edt1.text useFileUnits:true quiet:true) then (
				SUnit = units.SystemType
				holdMaxFile()
				for i in ::r8dui.r8ui.lbx1.selection do(
					FNa = filterstring files[i] "\\"
				FNaPat = filterstring files[i] "."
						if outputRep_chk.checked then(
				NFolder = ""
				for i = 1 to (FNa.count-1) do if NFolder=="" then NFolder = FNa[i] else NFolder = (NFolder+"\\"+FNa[i])
				NFolder = (NFolder+"_backup")
				makedir NFolder
				Finame = getfilenamefile files[i]
				BKfile = (NFolder+"\\"+Finame+".max")
							if (copyfile files[i] BKfile) then(
								rCount += 1
								insertitem ("    "+FNa[FNa.count]+" 备份成功") rItem rCount
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)else(
							if (deletefile BKfile) do
							if (copyfile files[i] BKfile) do(
								rCount += 1
								insertitem ("    "+FNa[FNa.count]+" 旧备份被替换") rItem rCount
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)
							)
						)
					if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
						aniSE = animationRange
						units.SystemType = SUnit
						saveMaxFile files[i] quiet:true
					)
					fetchMaxFile quiet:true
					if (mergeMAXFile files[i] #deleteOldDups #useMergedMtlDups #alwaysReparent quiet:true) then(
						animationRange = aniSE
						if (saveMaxFile files[i] quiet:true) then(
							::r8dfn.RR_rol.load_pro2.value = 100.*loC2/SELs
							loC2+=1
							rCount += 1
							insertitem (" -- "+FNa[FNa.count]+" 渲染参数应用完成") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
					)else(
						rCount += 1
						insertitem (" !"+" --> "+FNa[FNa.count]+"  (无法打开)") rItem rCount
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
					fetchMaxFile quiet:true
				)
							rCount += 1
							insertitem (" 应用渲染设置已完成......") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "应用渲染设置已完成。"
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
			)
			)else(messagebox "请确认您指定的MAX源文件是否正确！" title:"Help辅助功能"
			exit
			)
		)
		)else(messagebox "请在列表里选择要应用渲染设置的max文件，双击列表选择全部。" title:"Help辅助功能")
		)
	)catch(messagebox "请输入正确的渲染路径!" title:"Help辅助功能")
	)))
)
--辅助功能end----------------------------------
global DefFilter = #(Area(),Blackman(),Blendfilter(),Catmull_Rom(),Cook_Variable(),cubic(),Mitchell_Netravali(),Plate_Match_MAX_R2(),Quadratic(),Sharp_Quadratic(),Soften(),Video())

rollout default_RS_Rollout "Default_Renderer Parameters"
(
	imgTag cc_img pos:[2,0] width:189 height:5 bitmap:(bitmap 195 8 color: (color 200 40 32))
	label filter_lbl "Filter:" pos:[13,13]
	dropDownList def_filt_ddl "" pos:[50,10] width:127 height:22 items:#("Area","Blackman","Blend","Catmull-Rom","Cook Variable","Cubic","Mitchell-Netravali","Plate Match/MAX R2","Quadratic","Sharp Quadratic","Soften","Video")
	imgTag cc2_img offset:[-11,0] width:189 height:3 bitmap:(bitmap 195 8 color: (color 200 40 32)) across:1
	fn refreshParameDF = (
	if ::r8dfn.ConvertToBool( getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "HIDERS" ) do(
		a = scanlineRender.antiAliasFilter as string
		b = filterstring a ":"
		def_filt_ddl.selection = finditem def_filt_ddl.items b[1]
		)
	)
	on default_RS_Rollout open do(
		refreshParameDF()
	)
	on def_filt_ddl selected item do(
		scanlineRender.antiAliasFilter = DefFilter[item]
	)
)
rcMenu gammaMenu_mu (
	menuitem N_mi "关闭矫正"
	separator sep2
	menuitem g_mi "Gamma"
	menuitem l_mi "LUT"
	on gammaMenu_mu open do(
		if (IDisplayGamma.colorCorrectionMode == #none) then N_mi.checked = true else N_mi.checked = false
		if (IDisplayGamma.colorCorrectionMode == #gamma) then g_mi.checked = true else g_mi.checked = false
		if (IDisplayGamma.colorCorrectionMode == #LUT) then l_mi.checked = true else l_mi.checked = false
	)
	on N_mi picked do(
		IDisplayGamma.colorCorrectionMode = #none
		::r8dui.r8ui.gamma_lbl.text = "-Off-"
		::r8dui.r8ui.gamma_spn.enabled = false
	)
	on g_mi picked do(
		IDisplayGamma.colorCorrectionMode = #gamma
		::r8dui.r8ui.gamma_lbl.text = "gamma"
		::r8dui.r8ui.gamma_spn.enabled = true
	)
	on l_mi picked do(
		IDisplayGamma.colorCorrectionMode = #LUT
		::r8dui.r8ui.gamma_lbl.text = "LUT"
		::r8dui.r8ui.gamma_spn.enabled = false
	)
)
rcMenu rpsMenu_mu (
	menuitem lodPSPath_mi "②选择渲染预设(.rps)"
	menuitem setPSPath_mi "①指定预设读取路径(.rps)"
	menuitem useRps_mi "应用指定的渲染预设(.rps)"
	menuitem savPSPath_mi "保存当前渲染设置(.rps)"
	on savPSPath_mi picked do (
		psE = ::r8dui.r8ui.rps_txt.text
		saveSet = getsavefilename caption:"保存全局渲染设置" filename:psE types:"RenderSet(*.rps)|*.rps|All|*.*|"
		if saveSet != undefined do(
			renderpresets.Save 0 saveSet #{}
		)
	)
	on setPSPath_mi picked do (
		psE = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSPath"
		PSP = getSavePath caption:"指定渲染预设路径" initialDir:psE
		if PSP != undefined do(
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSPath" PSP
		)
	)
	on useRps_mi picked do (
		if ::r8dui.r8ui.rps_txt.text != "" then(
		if doesFileExist(::r8dui.r8ui.rps_txt.text) do
		psn=filterstring (::r8dui.r8ui.rps_txt.text) "\\"
		if psn.count != 0 do
		if (querybox ("确定要应用 [ "+psn[psn.count]+" ] 渲染预设到当前场景吗？") title:"R8D") do
			renderpresets.LoadAll 0 (::r8dui.r8ui.rps_txt.text)
	)else(messagebox "请先指定预设路径，并导入一个预设才能读取" title:"R8D")
	)
	on lodPSPath_mi picked do (
		::r8dfn.MAXPreset_fn()
	)
)
rcMenu r8dMenu_mu (
	fn GetReg = (		::r8dfn.getkkkk() != (::r8dfn.CreateKEY ::r8dStart.IOOIIIOIO "kkk")	)
	menuitem oxSetting_mi "R8D设置"
	separator sep0
	menuitem rHelp_mi "即时帮助 √"
	menuitem Help_mi "全面帮助(Web)"
	menuitem verMsg_mi "关于 R8D"
	separator sepcode
	menuitem qrcode_mi "微信扫二维码关注 [勤劳蜗牛] ←"
	-- menuitem AUpdata_mi "有更新时提醒 √"
	-- menuitem Updata_mi "★有新版本，查看更新信息" filter:UPyes
	menuitem DonwloadNew_mi "★ 手动更新下载 ★"
	separator sep4 filter:GetReg
	menuitem About_mi ">>> 注  册 <<<" filter:GetReg
	separator sep1
	menuitem oxCloseUI_mi "X 关闭"
	on qrcode_mi picked do(
		rollout code_rol "获得最新帮助" width:258 height:258(
			imgtag code "" pos:[0,0] bitmap:(openBitMap "$scripts\oxTOOLSfiles\Icons\qrcode.jpg") transparent:(color 0 255 0) tooltip:"关闭"
			on code click do destroyDialog code_rol
		)
		createdialog code_rol style:#()
	)
	fn readAboutFile =(
		aboutFile = openFile ("$scripts\Lincence.txt") mode:#rt
		if aboutFile != undefined then(
			fileText = readDelimitedString aboutFile "~"
			close aboutFile
			fileText
		)else(
			return "..."
		)
	)
	function AboutDM =
	(
		try(destroyDialog rollout_R8Dabout)catch()
		
		rollout rollout_R8Dabout "关于 R8D" width:650 height:680
		(
			dotnetcontrol aboutTextbox "System.Windows.Forms.RichTextBox" width:(rollout_R8Dabout.width - 10) height:(rollout_R8Dabout.height - 10) align:#left pos:[5,5]
			
			on rollout_R8Dabout open do
			(
				aboutText = (" 自动化八方向渲染工具 R8D v" + RVers + "\n 作者：勤劳蜗牛 00x\n 工具简介：\n    cici-R8D是一个3DsMax八方向渲染脚本工具，是目前功能最完善的八方向渲染工具，支持所有MAX版本，用于2.5D游戏多方向批量渲染，也可用于场景物件渲染，简单易用，基本适用所有项目的制作需要。可以跨文件夹对多个Max文档进行批量多方向渲染， 支持模型分块渲染，可以用于角色换装，特效分层等，支持全局设置保存多文档自动运用，省去每个Max文档都要做相机和渲染设置的繁琐工作。\n\n有任何问题或建议可至我邮箱：51570900@qq.com\n" + readAboutFile())
				aboutTextbox.multiline = true
				aboutTextbox.wordwrap = true
				aboutTextbox.ReadOnly = true
				aboutTextbox.DetectUrls = false
				aboutTextbox.BackColor = (dotNetClass "System.Drawing.Color").FromArgb 220 230 220 
				aboutTextbox.ForeColor = (dotNetClass "System.Drawing.Color").FromArgb 20 20 50
				aboutTextbox.BorderStyle = none
				aboutTextbox.text = aboutText
			)
		)
		createDialog rollout_R8Dabout	
	)
	on verMsg_mi picked do AboutDM()
	local rH = false
	-- on AUpdata_mi picked do(
		-- setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USEAUTOUP" ((not AUpdata_mi.checked) as string)
	-- )
	on oxSetting_mi picked do (
		createdialog ::r8dfn.r8dsetting style:#(#style_toolwindow)
	)
	on rHelp_mi picked do (
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK" ((not rHelp_mi.checked) as string)
		if rHelp_mi.checked == false then(
		if ::r8dui.r8ui.bitCount.checked then(
			::r8dui.r8ui.height = 450
			::r8dui.r8ui.helpline.pos = [5,402]
		)else(
			::r8dui.r8ui.height = 420
			::r8dui.r8ui.helpline.pos = [5,372]
		)
			::r8dui.r8ui.helpline.visible = true
		)else(
		if ::r8dui.r8ui.bitCount.checked then(
			::r8dui.r8ui.height = 400
		)else(
			::r8dui.r8ui.height = 370
		)
			::r8dui.r8ui.helpline.visible = false
		)
	)
	on Help_mi picked do (
		doscommand "start explorer http://www.cgjoy.com/data/WebHelp/index.htm"
	)
	on DonwloadNew_mi picked do (
		doscommand "start explorer http://blog.sina.com.cn/s/blog_753586a60101b62q.html"
	)
	on About_mi picked do(
		createdialog ::r8dfn.kkkr8d
	)
	on oxCloseUI_mi picked do(
		try DestroyDialog ::r8dui.r8ui catch()
	)
	on r8dMenu_mu open do(
		-- AUpdata_mi.checked = ::r8dfn.ConvertToBool (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USEAUTOUP")
		rHelp_mi.checked = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "MenuSet" "rHelpCHK")
	)
)
	
rollout R8DSet_rollout "R8D 设置" width:478 height:340(
group "渲染输出设置:"(
	checkbox doubleSide_chk "强制双面" across:6
	checkbox hideBone_chk "隐藏骨骼"
	checkbox lightRot_chk "灯光旋转"
	checkbox delFF_chk "去除头帧"
	checkbox delEF_chk "去除尾帧"
	checkbox singleFrame_chk "单帧输出"
	checkbox rSS_chk "分块渲染(批)" width:87 across:5 tooltip:"批量渲染文件时将有分块的场景按分块渲出（取消则只渲染显示的模型）"
	checkbox SSmask_chk "分块遮罩" tooltip:"渲染分块时自动将其它没渲染到的分块作为当前渲染分块的遮罩物体"
	checkbox SSmaskCS_chk "遮罩接收阴影" width:90
	checkbox HideUnSS_chk "隐藏未分块" tooltip:"渲染时隐藏没有被创建分块的模型"
	checkbox SelK_chk "渲染挑帧" tooltip:"（如果有动作记录挑帧则无效）"
)
--	groupbox outset_grp "渲染输出设置:" pos:[4,5] width:380 height:64
group "文件夹设置:"(
	checkbox CFolder_chk "文件夹归档 (数字越小层级越高)" width:365 across:1
	checkbutton FFF_chk "上级文件夹" across:5 tooltip:"会以MAX文档的所在目录名称创建文件夹"
	checkbutton SceneF_chk "场景文件夹" tooltip:"会以MAX文档的名称创建文件夹"
	checkbutton AnimF_chk "动作文件夹" tooltip:"有创建动作记录，一文档多动作的文档会以每个动作名创建文件夹"
	checkbutton SelSetF_chk "分块文件夹" tooltip:"有创模型分块的文档会以每个分块名创建文件夹"
	checkbutton DirecF_chk "方向文件夹" tooltip:"会以该设置面板下方的对应自定方向名创建文件夹"
	label tmp "" across:5
	spinner Scene_spn range:[1,3,1] type:#integer align:#center
	spinner Anim_spn range:[1,3,2] type:#integer align:#center
	spinner SS_spn range:[1,3,3] type:#integer align:#center
	label tmp2 ""
	label S_CDN_lbl "S" 	offset:[0,15] across:9
	label ES_CDN_lbl "ES"	offset:[0,15]
	label E_CDN_lbl "E" 	offset:[0,15]
	label EN_CDN_lbl "EN" 	offset:[0,15]
	label N_CDN_lbl "N" 	offset:[0,15]
	label WN_CDN_lbl "WN" 	offset:[0,15]
	label W_CDN_lbl "W" 	offset:[0,15]
	label WS_CDN_lbl "WS" 	offset:[0,15]
	label O_CDN_lbl "C" 	offset:[0,15]
	edittext S_CDN "" width:42 height:17 across:9
	edittext ES_CDN "" width:42 height:17 
	edittext E_CDN "" width:42 height:17 
	edittext EN_CDN "" width:42 height:17 
	edittext N_CDN "" width:42 height:17 
	edittext WN_CDN "" width:42 height:17 
	edittext W_CDN "" width:42 height:17 
	edittext WS_CDN "" width:42 height:17 
	edittext O_CDN "" width:42 height:17 
	groupbox DirS_grp "自定方向文件夹命名:" pos:[10,156] width:456 height:58
)
group "自定方向度数设置"(
	label DS_CDN_lbl "S" 	across:9
	label DES_CDN_lbl "ES"
	label DE_CDN_lbl "E" 
	label DEN_CDN_lbl "EN"
	label DN_CDN_lbl "N" 
	label DWN_CDN_lbl "WN"
	label DW_CDN_lbl "W" 
	label DWS_CDN_lbl "WS"
	label DO_CDN_lbl "C"
	spinner Degree_S_spn	offset:[-10,0] range:[0,360,0] type:#float width:52 across:9
	spinner Degree_ES_spn	offset:[-10,0] range:[0,360,45] type:#float width:52
	spinner Degree_E_spn	offset:[-10,0] range:[0,360,90] type:#float width:52
	spinner Degree_EN_spn	offset:[-10,0] range:[0,360,135] type:#float width:52
	spinner Degree_N_spn	offset:[-10,0] range:[0,360,180] type:#float width:52
	spinner Degree_WN_spn	offset:[-10,0] range:[0,360,225] type:#float width:52
	spinner Degree_W_spn	offset:[-10,0] range:[0,360,270] type:#float width:52
	spinner Degree_WS_spn	offset:[-10,0] range:[0,360,315] type:#float width:52
	spinner Degree_O_spn	offset:[-10,0] range:[0,360,180] type:#float width:52
)
	edittext cRotNode_txt text:"输入虚拟体名称" pos:[20,291] width:120 height:17 tooltip:"输入做旋转的虚拟体名称"
	button useDummyRot_btn "Du" pos:[0,293] width:18 height:18 tooltip:"（未使用）使用自定虚拟体替代相机旋转显示标示" border:false enabled:false
	spinner der_spn "" offset:[105,-20] range:[0,360,360] type:#float width:55 enabled:false across:3
	button AutoDir_btn "度平均" offset:[0,-23] height:22 align:#right tooltip:"按自定度数逆时针平均设置激活的方向度数" enabled:false
	button Close_btn "退  出" width:62 height:22 align:#right
	button USEDN_btn "R" pos:[449,167] width:15 height:15 tooltip:"运用当前方向名 \\ 右键清空自定命名"
	button resetDeg "R" pos:[451,238] tooltip:"还原默认8方向角度" width:15 height:15
	edittext seachN "排除关键词(分号;隔开):" text:"（输入不参加去头、尾帧的场景名）" pos:[10,317] width:330 height:17 visible:false
	imgtag sit "" pos:[10,337] width:330 height:4 bitmap:(bitmap 300 8 color: red) visible:false
--	groupbox Fset_grp "文件夹设置:" pos:[4,76] width:380 height:148
	----
	on AutoDir_btn pressed do(
		btns = ::r8dfn.DriBtnChk()
		if btns > 1 do(
			dry=der_spn.value/btns
			add=0
			if ::r8dui.r8ui.S_btn.checked do ( ::r8dui.r8ui.Deg_S_spn.value =Degree_S_spn.value= dry*add;add+=1   )
			if ::r8dui.r8ui.ES_btn.checked do( ::r8dui.r8ui.Deg_ES_spn.value=Degree_ES_spn.value= dry*add;add+=1  )
			if ::r8dui.r8ui.E_btn.checked do ( ::r8dui.r8ui.Deg_E_spn.value =Degree_E_spn.value= dry*add;add+=1   )
			if ::r8dui.r8ui.EN_btn.checked do( ::r8dui.r8ui.Deg_EN_spn.value=Degree_EN_spn.value= dry*add;add+=1  )
			if ::r8dui.r8ui.N_btn.checked do ( ::r8dui.r8ui.Deg_N_spn.value =Degree_N_spn.value= dry*add;add+=1   )
			if ::r8dui.r8ui.WN_btn.checked do( ::r8dui.r8ui.Deg_WN_spn.value=Degree_WN_spn.value= dry*add;add+=1  )
			if ::r8dui.r8ui.W_btn.checked do ( ::r8dui.r8ui.Deg_W_spn.value =Degree_W_spn.value= dry*add;add+=1   )
			if ::r8dui.r8ui.WS_btn.checked do( ::r8dui.r8ui.Deg_WS_spn.value=Degree_WS_spn.value= dry*add;add+=1  )
			::r8dui.r8ui.Deg_O_spn.value=Degree_O_spn.value= der_spn.value
			
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_" (Degree_S_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES" (Degree_ES_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_" (Degree_E_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN" (Degree_EN_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_" (Degree_N_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN" (Degree_WN_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_" (Degree_W_spn.value  as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS" (Degree_WS_spn.value as string)
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O" (Degree_O_spn.value as string)
		::r8dui.r8ui.S_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_")+"°")
		::r8dui.r8ui.ES_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES")+"°")
		::r8dui.r8ui.E_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_")+"°")
		::r8dui.r8ui.EN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN")+"°")
		::r8dui.r8ui.N_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_")+"°")
		::r8dui.r8ui.WN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN")+"°")
		::r8dui.r8ui.W_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_")+"°")
		::r8dui.r8ui.WS_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS")+"°")
		::r8dui.r8ui.O_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O")+"°")
		)
	)
	on resetDeg pressed do(
		::r8dui.r8ui.Deg_S_spn.value =Degree_S_spn.value=	0
		::r8dui.r8ui.Deg_ES_spn.value=Degree_ES_spn.value=45
		::r8dui.r8ui.Deg_E_spn.value =Degree_E_spn.value=	90
		::r8dui.r8ui.Deg_EN_spn.value=Degree_EN_spn.value=135
		::r8dui.r8ui.Deg_N_spn.value =Degree_N_spn.value=	180
		::r8dui.r8ui.Deg_WN_spn.value=Degree_WN_spn.value=225
		::r8dui.r8ui.Deg_W_spn.value =Degree_W_spn.value=	270
		::r8dui.r8ui.Deg_WS_spn.value=Degree_WS_spn.value=315
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_" "0"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES" "45"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_" "90"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN" "135"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_" "180"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN" "225"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_" "270"
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS" "315"
		::r8dui.r8ui.S_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_")+"°")
		::r8dui.r8ui.ES_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES")+"°")
		::r8dui.r8ui.E_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_")+"°")
		::r8dui.r8ui.EN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN")+"°")
		::r8dui.r8ui.N_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_")+"°")
		::r8dui.r8ui.WN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN")+"°")
		::r8dui.r8ui.W_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_")+"°")
		::r8dui.r8ui.WS_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS")+"°")
	)
	fn Refresh_Fol sta = (
		if sta then(
			FFF_chk.enabled = true
			if FFF_chk.checked do(
			::r8dui.r8ui.fff.checked = true
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN" "true"
			)
			SceneF_chk.enabled = true
			if SceneF_chk.checked do(
			::r8dui.r8ui.scF.checked = true
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" "true"
			)
			AnimF_chk.enabled = true
			if AnimF_chk.checked do(
			::r8dui.r8ui.anF.checked = true
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN" "true"
			)
			SelSetF_chk.enabled = true
			if SelSetF_chk.checked do(
			::r8dui.r8ui.sF.checked = true
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN" "true"
			)
			DirecF_chk.enabled = true
			if DirecF_chk.checked do(
			::r8dui.r8ui.diF.checked = true
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN" "true"
			)
		)else(
			FFF_chk.enabled = false
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN" "false"
			::r8dui.r8ui.fff.checked = false
			SceneF_chk.enabled = false
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" "false"
			::r8dui.r8ui.scF.checked = false
			AnimF_chk.enabled = false
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN" "false"
			::r8dui.r8ui.anF.checked = false
			SelSetF_chk.enabled = false
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN" "false"
			::r8dui.r8ui.sF.checked = false
			DirecF_chk.enabled = false
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN" "false"
			::r8dui.r8ui.diF.checked = false
		)
	)
	fn ReCFolder = (
		if FFF_chk.checked==false and SceneF_chk.checked==false and AnimF_chk.checked==false and SelSetF_chk.checked==false and DirecF_chk.checked==false then(
			CFolder_chk.checked = false
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER" "false"
			::r8dui.r8ui.ccF.checked = false
		)else(
			CFolder_chk.checked = true
			setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER" "true"
			::r8dui.r8ui.ccF.checked = true
		)
	)
	fn CheckingCDN = (
		Dif = 0
		sce=::r8dui.r8ui.scSpn.value
		aniC=::r8dui.r8ui.anSpn.value
		ss=::r8dui.r8ui.sSpn.value
		AllVal = #(sce,aniC,ss)
		for n in 2 to 3 do(
			if AllVal[1] == AllVal[n] do Dif += 1
		)
		if AllVal[2] == AllVal[3] do Dif += 1
		return Dif
	)
	----
	fn R8DSETOpen = (
		rSS_chk.checked = ::r8dui.r8ui.eSeting.checked
		if rSS_chk.checked then(
			HideUnSS_chk.enabled = true
			SSmask_chk.enabled = true
			if SSmask_chk.checked do SSmaskCS_chk.enabled = true
		)else(
			HideUnSS_chk.enabled = false
			SSmask_chk.enabled = false
			SSmaskCS_chk.enabled = false
		)
		SSmask_chk.checked = ::r8dui.r8ui.fSeting.checked
		SSmaskCS_chk.checked = ::r8dui.r8ui.gSeting.checked
		if SSmask_chk.checked and rSS_chk.checked then SSmaskCS_chk.enabled = true else SSmaskCS_chk.enabled = false
		HideUnSS_chk.checked = ::r8dui.r8ui.hSeting.checked
		doubleSide_chk.checked = ::r8dui.r8ui.aSeting.checked
		SelK_chk.checked = ::r8dui.r8ui.skSeting.checked
		singleFrame_chk.checked = ::r8dui.r8ui.jSeting.checked
		hideBone_chk.checked = ::r8dui.r8ui.bSeting.checked
		lightRot_chk.checked = ::r8dui.r8ui.cSeting.checked
		delEF_chk.checked = ::r8dui.r8ui.iSeting.checked
		delFF_chk.checked = ::r8dui.r8ui.kSeting.checked
		CFolder_chk.checked = ::r8dui.r8ui.ccF.checked
		Refresh_Fol CFolder_chk.checked
		FFF_chk.checked = ::r8dui.r8ui.fff.checked
		SceneF_chk.checked = ::r8dui.r8ui.scF.checked
		AnimF_chk.checked =  ::r8dui.r8ui.anF.checked
		SelSetF_chk.checked =::r8dui.r8ui.sF.checked
		DirecF_chk.checked = ::r8dui.r8ui.diF.checked
		Scene_spn.value=::r8dui.r8ui.scSpn.value
		Anim_spn.value=	::r8dui.r8ui.anSpn.value
		SS_spn.value=	::r8dui.r8ui.sSpn.value
		S_CDN.text =  ::r8dui.r8ui.S_CDN .text
		ES_CDN.text = ::r8dui.r8ui.ES_CDN.text
		E_CDN.text =  ::r8dui.r8ui.E_CDN .text
		EN_CDN.text = ::r8dui.r8ui.EN_CDN.text
		N_CDN.text =  ::r8dui.r8ui.N_CDN .text
		WN_CDN.text = ::r8dui.r8ui.WN_CDN.text
		W_CDN.text =  ::r8dui.r8ui.W_CDN .text
		WS_CDN.text = ::r8dui.r8ui.WS_CDN.text
		O_CDN.text = ::r8dui.r8ui.O_CDN.text
		Degree_S_spn.value=	::r8dui.r8ui.Deg_S_spn.value 
		Degree_ES_spn.value= ::r8dui.r8ui.Deg_ES_spn.value
		Degree_E_spn.value=	::r8dui.r8ui.Deg_E_spn.value 
		Degree_EN_spn.value= ::r8dui.r8ui.Deg_EN_spn.value
		Degree_N_spn.value=	::r8dui.r8ui.Deg_N_spn.value 
		Degree_WN_spn.value= ::r8dui.r8ui.Deg_WN_spn.value
		Degree_W_spn.value=	::r8dui.r8ui.Deg_W_spn.value 
		Degree_WS_spn.value= ::r8dui.r8ui.Deg_WS_spn.value
		Degree_O_spn.value= ::r8dui.r8ui.Deg_O_spn.value
		der_spn.value =(getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_Cut")as float
		if delEF_chk.checked do sit.visible = seachN.visible = true
		if delFF_chk.checked do sit.visible = seachN.visible = true
		if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT") != "" do
		seachN.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT"
		if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CROTNODE")=="" then ::r8dui.r8ui.useDummyName.text=cRotNode_txt.text = "输入虚拟体名称"
		else
		::r8dui.r8ui.useDummyName.text=cRotNode_txt.text = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CROTNODE"
		IPC = openbitmap "$maxScripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp"
	if ::r8dui.r8ui.useDummyName.text != "输入虚拟体名称" then (
		useDummyRot_btn.images = #(IPC,IPC,32,19,19,19,19)
		useDummyRot_btn.tooltip=("（已使用）名称为："+::r8dui.r8ui.useDummyName.text)
	)else(useDummyRot_btn.images = #(IPC,IPC,32,21,21,21,21)
	useDummyRot_btn.tooltip="（未使用）使用自定虚拟体替代相机旋转显示标示"
	)
	)
	on R8DSet_rollout open do(
	if ::r8dui.r8ui.getani_chk.checked then
	SelK_chk.enabled = false
	else
	SelK_chk.enabled = true
		if ::r8dfn.DriBtnChk() > 1 do( AutoDir_btn.enabled = true ; der_spn.enabled = true)
		if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "R8DSETPOS") != "" do(
			setpos = execute (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "R8DSETPOS")
if setpos.x > sysinfo.desktopSize.x or setpos.y > sysinfo.desktopSize.y or setpos.x < -100 or setpos.y < 0 do(
	setpos = [100,100]
	setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "R8DSETPOS" "[100,100]"
)
			setDialogPos R8DSet_rollout setpos
		)
		R8DSETOpen()
	)
	on R8DSet_rollout moved pos do
		setINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "R8DSETPOS" (pos as string)
	on Close_btn pressed do(
		if CheckingCDN() > 0 then
			(messagebox "您设置的文件夹顺序编号有重复！请检查。" title:"R8D")
		else
			destroyDialog R8DSet_rollout
	)
	on USEDN_btn pressed do(
		::r8dui.r8ui.S_CDN.text = S_CDN.text = ::r8dui.r8ui.S.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "S_CDNsave" S_CDN.text
		::r8dui.r8ui.ES_CDN.text = ES_CDN.text = ::r8dui.r8ui.ES.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ES_CDNsave" ES_CDN.text
		::r8dui.r8ui.E_CDN.text = E_CDN.text = ::r8dui.r8ui.E.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "E_CDNsave" E_CDN.text
		::r8dui.r8ui.EN_CDN.text = EN_CDN.text = ::r8dui.r8ui.EN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "EN_CDNsave" EN_CDN.text
		::r8dui.r8ui.N_CDN.text = N_CDN.text = ::r8dui.r8ui.N.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "N_CDNsave" N_CDN.text
		::r8dui.r8ui.WN_CDN.text = WN_CDN.text = ::r8dui.r8ui.WN.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WN_CDNsave" WN_CDN.text
		::r8dui.r8ui.W_CDN.text = W_CDN.text = ::r8dui.r8ui.W.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "W_CDNsave" W_CDN.text
		::r8dui.r8ui.WS_CDN.text = WS_CDN.text = ::r8dui.r8ui.WS.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WS_CDNsave" WS_CDN.text
		::r8dui.r8ui.O_CDN.text = O_CDN.text = ::r8dui.r8ui.O.text
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "O_CDNsave" O_CDN.text
	)
	on USEDN_btn rightclick do(
		O_CDN.text = WS_CDN.text = W_CDN.text = WN_CDN.text = N_CDN.text = EN_CDN.text = E_CDN.text = ES_CDN.text = S_CDN.text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "S_CDNsave"	""  ; ::r8dui.r8ui.S_CDN .text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ES_CDNsave"	""  ; ::r8dui.r8ui.ES_CDN.text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "E_CDNsave" 	""  ; ::r8dui.r8ui.E_CDN .text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "EN_CDNsave"	""  ; ::r8dui.r8ui.EN_CDN.text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "N_CDNsave" 	""  ; ::r8dui.r8ui.N_CDN .text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WN_CDNsave"	""  ; ::r8dui.r8ui.WN_CDN.text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "W_CDNsave" 	""  ; ::r8dui.r8ui.W_CDN .text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WS_CDNsave"	""  ; ::r8dui.r8ui.WS_CDN.text = ""
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "O_CDNsave"	""  ; ::r8dui.r8ui.O_CDN.text = ""
	)
	on S_CDN  entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "S_CDNsave"	text ; 	::r8dui.r8ui.S_CDN .text = text )
	on ES_CDN entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ES_CDNsave" text ;	::r8dui.r8ui.ES_CDN.text = text )
	on E_CDN  entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "E_CDNsave" 	text ; ::r8dui.r8ui.E_CDN .text = text )
	on EN_CDN entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "EN_CDNsave"	text ; ::r8dui.r8ui.EN_CDN.text = text )
	on N_CDN  entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "N_CDNsave" 	text ; ::r8dui.r8ui.N_CDN .text = text )
	on WN_CDN entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WN_CDNsave"	text ; ::r8dui.r8ui.WN_CDN.text = text )
	on W_CDN  entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "W_CDNsave" 	text ; ::r8dui.r8ui.W_CDN .text = text )
	on WS_CDN entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "WS_CDNsave"	text ; ::r8dui.r8ui.WS_CDN.text = text )
	on O_CDN entered text do( setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "O_CDNsave"	text ; ::r8dui.r8ui.O_CDN.text = text )
	on Degree_S_spn  changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_" (val as string) ; ::r8dui.r8ui.Deg_S_spn.value  = val ; ::r8dui.r8ui.S_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_S_")+"°"))
	on Degree_ES_spn changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES" (val as string) ; ::r8dui.r8ui.Deg_ES_spn.value = val ; ::r8dui.r8ui.ES_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_ES")+"°"))
	on Degree_E_spn  changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_" (val as string) ; ::r8dui.r8ui.Deg_E_spn.value  = val ; ::r8dui.r8ui.E_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_E_")+"°"))
	on Degree_EN_spn changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN" (val as string) ; ::r8dui.r8ui.Deg_EN_spn.value = val ; ::r8dui.r8ui.EN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_EN")+"°"))
	on Degree_N_spn  changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_" (val as string) ; ::r8dui.r8ui.Deg_N_spn.value  = val ; ::r8dui.r8ui.N_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_N_")+"°"))
	on Degree_WN_spn changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN" (val as string) ; ::r8dui.r8ui.Deg_WN_spn.value = val ; ::r8dui.r8ui.WN_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WN")+"°"))
	on Degree_W_spn  changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_" (val as string) ; ::r8dui.r8ui.Deg_W_spn.value  = val ; ::r8dui.r8ui.W_btn.tooltip = ("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_W_")+"°"))
	on Degree_WS_spn changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS" (val as string) ; ::r8dui.r8ui.Deg_WS_spn.value = val ; ::r8dui.r8ui.WS_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_WS")+"°"))
	on Degree_O_spn changed val do(setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O" (val as string) ; ::r8dui.r8ui.Deg_O_spn.value = val ; ::r8dui.r8ui.O_btn.tooltip =("RMB:查看该方向视窗 \\ Ctrl+RMB:预览渲染 : "+(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_O")+"°"))
	on der_spn changed val do (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "Deg_Cut" (val as string)	)
	on doubleSide_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DOUBLESIDE" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.aSeting.checked = state
	)
	on SelK_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SKSETING" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.skSeting.checked = state
	)
	on singleFrame_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SINGLEFRAME" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.jSeting.checked = state
		if state then(
		::r8dui.r8ui.frameGap_chk.checked = true
		::r8dui.r8ui.FG_spn.value = 2)else(
		::r8dui.r8ui.FG_spn.enabled=::r8dui.r8ui.frameGap_chk.checked = false
		::r8dui.r8ui.FG_spn.value = 1
		)
	)
	on hideBone_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEBONE" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.bSeting.checked = state
	)
	on lightRot_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "LIGHTROT" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.cSeting.checked = state
	)
	on rSS_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "RSS_SET" (state as string))==false do ::r8dfn.msgSetErr()
		SSmask_chk.enabled = state
		HideUnSS_chk.enabled = state
		::r8dui.r8ui.eSeting.checked = state
		::r8dui.r8ui.fSeting.enabled = state
		::r8dui.r8ui.hSeting.enabled = state
		if SSmask_chk.checked then(
			SSmaskCS_chk.enabled = state
			::r8dui.r8ui.gSeting.enabled = state
		)else(
			SSmaskCS_chk.enabled = false
			::r8dui.r8ui.gSeting.enabled = false
		)
	)
	on SSmask_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHK" (state as string))==false do ::r8dfn.msgSetErr()
		SSmaskCS_chk.enabled = state
		::r8dui.r8ui.fSeting.checked = state
		::r8dui.r8ui.gSeting.enabled = state
	)
	on SSmaskCS_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SSMASKCHKCS" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.gSeting.checked = state
	)
	on HideUnSS_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "HIDEUNSSOBJ" (state as string))==false do ::r8dfn.msgSetErr()
		::r8dui.r8ui.hSeting.checked = state
	)
	on delEF_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELENDF" (state as string))==false do ::r8dfn.msgSetErr()
		if delFF_chk.checked then(
		sit.visible = seachN.visible = true
		::r8dui.r8ui.iSeting.checked = state
		)else
		sit.visible = seachN.visible = ::r8dui.r8ui.iSeting.checked = state
	)
	on delFF_chk changed state do(
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DELFISTF" (state as string))==false do ::r8dfn.msgSetErr()
		if delEF_chk.checked then(
		sit.visible = seachN.visible = true
		::r8dui.r8ui.kSeting.checked = state
		)else
		sit.visible = seachN.visible = ::r8dui.r8ui.kSeting.checked = state
	)
	on seachN entered text do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT" text
	)
	on cRotNode_txt entered text do(
		setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CROTNODE" text
	IPC = openbitmap "$scripts\oxTOOLSfiles\Icons\CopyPasteAni_icon.bmp"
	if text != "" then (
	if getnodebyname text != undefined then(
		::r8dui.r8ui.useDummyRot_btn.images = useDummyRot_btn.images = #(IPC,IPC,32,19,19,19,19)
		::r8dui.r8ui.useDummyRot_btn.tooltip=useDummyRot_btn.tooltip=("（已使用）名称为："+text)
		::r8dui.r8ui.useDummyName.text=text
	)else(::r8dui.r8ui.useDummyRot_btn.images = useDummyRot_btn.images = #(IPC,IPC,32,21,21,21,21)
	::r8dui.r8ui.useDummyRot_btn.tooltip=useDummyRot_btn.tooltip="（未使用）物体不存在"
	)
	)else(::r8dui.r8ui.useDummyRot_btn.images = useDummyRot_btn.images = #(IPC,IPC,32,21,21,21,21)
	::r8dui.r8ui.useDummyRot_btn.tooltip=useDummyRot_btn.tooltip="（未使用）使用自定虚拟体替代相机旋转显示标示"
	::r8dui.r8ui.useDummyName.text=cRotNode_txt.text="输入虚拟体名称"
	)
	)
	on Scene_spn changed val do(
		oldV = ::r8dui.r8ui.scSpn.value
		if Anim_spn.value == val do(Anim_spn.value = oldV
		::r8dui.r8ui.anSpn.value = oldV
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN"  (oldV as string))==false do ::r8dfn.msgSetErr()
		)
		if SS_spn.value == val do(SS_spn.value = oldV
		::r8dui.r8ui.sSpn.value = oldV
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN"   (oldV as string))==false do ::r8dfn.msgSetErr()
		)
		::r8dui.r8ui.scSpn.value = val
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN" (val as string))==false do ::r8dfn.msgSetErr()
	)
	on Anim_spn changed val do(
		oldV = ::r8dui.r8ui.anSpn.value
		if Scene_spn.value == val do(Scene_spn.value = oldV
		::r8dui.r8ui.scSpn.value = oldV
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN" (oldV as string))==false do ::r8dfn.msgSetErr()
		)
		if SS_spn.value == val do(SS_spn.value = oldV
		::r8dui.r8ui.sSpn.value = oldV
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN"   (oldV as string))==false do ::r8dfn.msgSetErr()
		)
		::r8dui.r8ui.anSpn.value = val
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN"  (val as string))==false do ::r8dfn.msgSetErr()
	)
	on SS_spn changed val do(
		oldV = ::r8dui.r8ui.sSpn.value
		if Scene_spn.value == val do(Scene_spn.value = oldV
		::r8dui.r8ui.scSpn.value = oldV
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SCENE_SPN" (oldV as string))==false do ::r8dfn.msgSetErr()
		)
		if Anim_spn.value == val do(Anim_spn.value = oldV
		::r8dui.r8ui.anSpn.value = oldV
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "ANIM_SPN"  (oldV as string))==false do ::r8dfn.msgSetErr()
		)
		::r8dui.r8ui.sSpn.value = val
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8DSET" "SS_SPN"   (val as string))==false do ::r8dfn.msgSetErr()
	)
	----------------
	on CFolder_chk changed state do(
		::r8dui.r8ui.ccF.checked = state
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "CFOLDER" (state as string))==false do ::r8dfn.msgSetErr()
		Refresh_Fol state
		if ::r8dui.r8ui.bitCount.checked do
		if state then(
		)else(
			::r8dui.r8ui.useDir_chk.checked = true
			::r8dui.r8ui.useAct_chk.checked = true
			::r8dui.r8ui.useSce_chk.checked = true
			::r8dui.r8ui.useSSN_chk.checked = true
		)
		if SceneF_chk.checked==false and AnimF_chk.checked==false and SelSetF_chk.checked==false and DirecF_chk.checked==false then(
			SceneF_chk.checked=true
			SetINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" "true"
			::r8dui.r8ui.scF.checked = true
		)
	)
	on FFF_chk changed state do(
		::r8dui.r8ui.fff.checked = state
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "FFF_CDN" (state as string))==false do ::r8dfn.msgSetErr()
		ReCFolder()
	)
	on SceneF_chk changed state do(
		::r8dui.r8ui.scF.checked = state
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" (state as string))==false do ::r8dfn.msgSetErr()
		if state then(
		)else(
		if ::r8dui.r8ui.bitCount.checked do ::r8dui.r8ui.useSce_chk.checked = true
		if (querybox "如果你选择多个文件批渲染，每个文件创建的方向文件夹将相同，所以<场景文件夹>要一起激活，是否保留激活？" title:"R8D设置") do(
			::r8dui.r8ui.scF.checked = SceneF_chk.checked = true
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" "true"
		)
		)
		ReCFolder()
	)
	on AnimF_chk changed state do(
		::r8dui.r8ui.anF.checked = state
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "ANIM_CDN" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dui.r8ui.bitCount.checked do
		if state then(
		)else(
				::r8dui.r8ui.useAct_chk.checked = true
		)
		ReCFolder()
	)
	on SelSetF_chk changed state do(
		::r8dui.r8ui.sF.checked = state
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEL_CDN" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dui.r8ui.bitCount.checked do
		if state then(
		)else(
				::r8dui.r8ui.useSSN_chk.checked = true
		)
		ReCFolder()
	)
	on DirecF_chk changed state do(
		::r8dui.r8ui.diF.checked = state
		if (setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "DIR_CDN" (state as string))==false do ::r8dfn.msgSetErr()
		if ::r8dui.r8ui.bitCount.checked do
			if state then(
			)else(
					::r8dui.r8ui.useDir_chk.checked = true
				if SceneF_chk.checked == false do if (querybox "如果你选择多个文件批渲染，每个文件创建的方向文件夹将相同，所以<场景文件夹>要一起激活，是否现在激活？" title:"R8D设置") do(
					SceneF_chk.checked = true
					setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SCENE_CDN" "true"
				)
			)
		ReCFolder()
	)
)
struct r8dfn (
	RENDERMSG=false,NORenderCSS,
	CDKEYP = ((getdir #help)+"\Backburner_Install.CAT"),
	TmpF=(getdir #temp+"\NC.tmp"),
	RCCC, UIx, UIy,DEGREE,GLOBHEIGHT,GLOBSCALE,GLFOV,
	RDirMsgCount = 0,
	RR_rol = rendering_rol,STOPRM, RS_CL = RS_CLight_Rollout,
	RS_rol = rs_Rollout,	kkkr8d = kkkkRollout,
	RRRer = (RendererClass.classes),
	RNL = (for r in RendererClass.classes collect r as string),
	H_rol = HelpFN_rollout,
	mFiles=#(), mCount_R8D, maxForLbx=#(), RmFiles=#(), SelDirF=#(),
	PreSetRol = PSList_rol,
	rpsFiles=#(), rpsForLbx=#(), RmFilesPS=#(), SelDirFPS=#(),	--rps file
	SCENEUNIT = #(#Inches, #Feet, #Miles, #Millimeters, #Centimeters, #Meters, #Kilometers),
	r8dmenu=r8dMenu_mu ,rpsmenu=rpsMenu_mu , gamamu = gammaMenu_mu,
	r8dsetting=R8DSet_rollout,
	fn msgSetErr=(messagebox "设置失败！请尝试以管理员身份登录Windows，或者先关闭MAX，在MAX程序图标右键选择以管理员身份运行MAX程序，再重试设置。" title:"R8D Set"),
	function ConvertToBool state =
	(
		if state == "true" then
		(	newState = true	)
		 else( newState = false	)
		return newState
	),
	fn GammaSet_fn = (
		if ::r8dui.r8ui.gamma_lbl.text == "gamma" do(
			try(IDisplayGamma.colorCorrectionMode = #gamma)catch()
			try(IDisplayGamma.gamma = ::r8dui.r8ui.gamma_spn.value)catch()
		)
		if ::r8dui.r8ui.gamma_lbl.text == "LUT" do(
			try(IDisplayGamma.colorCorrectionMode = #LUT)catch()
		)
		if ::r8dui.r8ui.gamma_lbl.text == "-Off-" do(
			try(IDisplayGamma.colorCorrectionMode = #none)catch()
		)
	),
	function isDirectoryExist pathName = (
		if pathName != "" then(
			pN = filterstring pathName "\\"
			ff=""
			if pN.count == 1 then(
				return true
			)else(
			for i in pN do(ff = ff+i+"\\")
			if (substring ff ff.count 1) == "\\" then
				fff=substring ff 1 (ff.count-1)
			else
				fff=ff
			Tm = getDirectories fff
			if Tm.count > 0 then
				return true
			else
				return false
			)
		)else
			return false
	),
	fn getTimeUse_fn T =(
		d = (((T/60)/60)/24) as integer
		h = ((T/60)/60) as integer
		m = (T/60) as integer
		s = T-60*m
		if m >= 60 do(
			m = m - (m as integer / 60)*60
		)
		if h >= 24 do(
			h = h - (h as integer / 24)*24
		)
		outT = (s as string+"s")
		if m > 0 do outT = (m as string+"m:"+s as string+"s")
		if h > 0 do outT = (h as string+"h:"+m as string+"m:"+s as string+"s")
		if d > 0 do outT = (d as string+"d:"+h as string+"h:"+m as string+"m:"+s as string+"s")
		return outT
	),
	fn DelToolCAM RECam = (
		if $D_1 != undefined do(
			try(
			delete $qianFront
			delete $D_1
			delete $D_2
			delete $D_3
			delete $D_4
			delete $D_5
			delete $D_6
			delete $D_7
			delete $D_8
			delete $Ccenter
			delete $AllCamera
			)catch()
			for n in ::r8dui.CNAMEs do(
				try delete (getnodebyname n) catch ()
			)
		)
		if RECam do ::r8dfn.isCameraOk()
	),
	fn SearchNa_fn sntxt ftxt =(
		if ftxt != "" then(
			FTF = filterstring ftxt ";"
			HavF = ""
			for i in FTF do
			if (findstring sntxt i) != undefined do HavF = "ok"
			if HavF == "ok" then return true else return false
		)else return false
	),
	fn CreateKEY NNNN KSKS = (
		local Ccode="",Ckkkk=""
		CODES = #("C","B","u","F","G","I","J","Z","g","l","N","O","e","f","a","P","H","_","+","U","V","W","X","%","^","&","*","(","Y","}",":","b","3",",","5","c","~","E","@","d","6","{","M","h","i","j","k","n","o","[","p","q","L","4","v","A","$",")","r","s","t","w","D","m","-","#","x","K","y","R","!","S","z","1","7","Q","0","T","8","9","=","`","2","]",".")
		CODEsssM = 	"QWERT45TYUIOPLDGHKJ-HGFD-GSAMGHNBVCXSZ543126TH78J9J0P3QRZWSX-PLMOKNIJ6BU-HYGVTFRDCEXW"	--68
		CODEkkk = 	"pi1qzxcv3bnfg5hy4rd2slmp6ow3u5yqyx0y09ftghert8hosmwiqxhzfi5wtz3zcv2ao89k2bnxq4u1ij0ds"
		if NNNN.count > 2 then CPN = NNNN else CPN = NNNN + "aSR"
		CPNnum = #()
		for i in 1 to CPN.count do(
			aa = substring CPN i 1
			cNum = finditem CODES aa
			append CPNnum cNum
		)
		for cc in CPNnum do(
			SC = substring CODEsssM cc 1
			KK = substring CODEkkk cc 1
			Ccode = Ccode+SC
			Ckkkk = Ckkkk+KK
		)
		if Ccode.count <= 40 do(
			Aa = substring Ccode ((Ccode.count / 2)as integer) (Ccode.count)
			Bb = substring Ccode 1 ((Ccode.count / 2)as integer)
			AB = substring CODEsssM CPNnum[((CPNnum.count / 2)as integer)] (40-Ccode.count)
			Ccode = Aa+AB+Bb
			Aa = substring Ckkkk ((Ckkkk.count / 2)as integer) (Ckkkk.count)
			Bb = substring Ckkkk 1 ((Ckkkk.count / 2)as integer)
			AB = substring CODEkkk CPNnum[((CPNnum.count / 2)as integer)] (40-Ckkkk.count)
			Ckkkk = Aa+AB+Bb
		)
		if KSKS == "kkk" do return Ckkkk
		if KSKS == "c" do return Ccode
	),
	fn DriBtnChk =(
		btns = 0
		if ::r8dui.r8ui.S_btn.checked do  btns += 1
		if ::r8dui.r8ui.ES_btn.checked do btns += 1
		if ::r8dui.r8ui.E_btn.checked do  btns += 1
		if ::r8dui.r8ui.EN_btn.checked do btns += 1
		if ::r8dui.r8ui.N_btn.checked do  btns += 1
		if ::r8dui.r8ui.WN_btn.checked do btns += 1
		if ::r8dui.r8ui.W_btn.checked do  btns += 1
		if ::r8dui.r8ui.WS_btn.checked do btns += 1
		if btns > 1 then return btns else return 0
	),
	fn SetOBJMasker CShadow: = (
		if selection.count > 0 do(
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				CMMat = MatteShadow ()
				if CShadow then(
					CMMat.receiveshadows = on
					CMMat.affectAlpha = on
				)else(
					CMMat.receiveshadows = off
					CMMat.affectAlpha = off
				)
			)
			if CR[1] == "mental" do(
				CMMat=Matte_Shadow_Reflection__mi ()
				if CShadow then(
					CMMat.catch_shadows = on
				)else(
					CMMat.catch_shadows = off
				)
				CMMat.ao_on = off
			)
			::r8dStart.COldMat=#()
			::r8dStart.COldNam=#()
			::r8dStart.oldMS=false
			::r8dStart.oldMSa=false
			Oldcount=1
			for o in selection do(
				if superclassof o == GeometryClass do(
					if CR[1] == "V" then(
						setUserProp o "VRay_Matte_Enable" true
						setUserProp o "VRay_Matte_Alpha" -1
						::r8dStart.oldMS=getUserProp o "VRay_Matte_Shadows"
						::r8dStart.oldMSa=getUserProp o "VRay_Matte_ShadowAlpha"
						if CShadow then(
							setUserProp o "VRay_Matte_Shadows" true
							setUserProp o "VRay_Matte_ShadowAlpha" true
						)else(
							setUserProp o "VRay_Matte_Shadows" false
							setUserProp o "VRay_Matte_ShadowAlpha" false
						)
						o.castShadows = off
						::r8dStart.COldNam[Oldcount] = o.name
					)else(
						::r8dStart.COldNam[Oldcount] = o.name
						::r8dStart.COldMat[Oldcount] = o.material
						o.castShadows = off
						o.material = CMMat
					)
					setUserProp o "00x_mask" true
					Oldcount += 1
				)
			)
		)
	),
	fn ResetSSmask =(
		if ::r8dStart.COldNam != undefined do(
			CR = filterstring ((renderers.current) as string) "_"
			for i = 1 to ::r8dStart.COldNam.count do(
				oldNode = getnodebyname ::r8dStart.COldNam[i]
				if oldNode != undefined do(
					if CR[1] == "V" then(
						setUserProp oldNode "VRay_Matte_Enable" false
						setUserProp oldNode "VRay_Matte_Alpha" 1
						setUserProp oldNode "VRay_Matte_Shadows" ::r8dStart.oldMS
						setUserProp oldNode "VRay_Matte_ShadowAlpha" ::r8dStart.oldMSa
						oldNode.castShadows = on
					)else(
						oldNode.material = ::r8dStart.COldMat[i]
						oldNode.castShadows = on
					)
					setUserProp oldNode "00x_mask" false
				)
			)
		)
		if selection.count > 0 do(
			for o in selection do(
				setUserProp o "00x_mask" false
			)
		)
	),
	fn createCCC RCam = (
		if $AllCamera != undefined do(	delete $AllCamera	)
		Dummy name:"AllCamera" pos:[0,0,0] isHidden:true isSelected:off
		ALLC = getnodebyname "AllCamera"
		if $qianFront != undefined do(delete $qianFront)
		text text:"↓" pos:[0,-5,0] size:6 name:"qianFront" wirecolor:black parent:ALLC isFrozen:true showFrozenInGray:off
		if $Ccenter != undefined do	delete $Ccenter
		Point name:"Ccenter" pos:[0,0,0] size:5 parent:ALLC isSelected:off wirecolor:(color 186 26 26) isFrozen:true showFrozenInGray:off
		Coss = #((color 127 43 224),(color 43 85 224),(color 43 158 224),(color 43 224 140),(color 137 224 43),(color 224 206 43),(color 224 130 67),(color 224 67 67))
		for i = 1 to 8 do(
			CC = getnodebyname ::r8dStart.CNAME[i]
			DD = getnodebyname ("D_"+i as string)
			if CC != undefined do delete CC
			if DD != undefined do delete DD
			Dummy name:("D_"+i as string) parent:ALLC pos:[0,0,0] isHidden:true isSelected:off
			DD = getnodebyname ("D_"+i as string)
			Freecamera name:::r8dStart.CNAME[i] parent:DD fov:::r8dui.r8ui.glFOV_spn.value targetDistance:16 nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off fStop:5.6 wirecolor:Coss[i] orthoProjection:::r8dui.r8ui.ortho_chk.checked \
			shutterSpeed:750 filmISO:100 useRotaryShutter:off rotaryShutter:180 diaphragmType:1 diaphragmAngle:0 diaphragmBlades:6 sl_xoffset:0 sl_yoffset:0 expValue:14 expType:1 transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,-16,0]) isSelected:off
			rotate DD (angleaxis (- ::r8dui.r8ui.glDegree_spn.value) [1,0,0])
			rotate DD (angleaxis (-45*i) [0,0,1])
			if DD.parent == undefined do DD.parent = ALLC
		)
		if maxfilename != "" then(
			fileName = #(getfilenamefile maxfilename)
			fileProperties.addProperty #custom "glDegreeSave" (::r8dui.r8ui.glDegree_spn.value)
			fileProperties.addProperty #custom "glHeightSave" (::r8dui.r8ui.glHeight_spn.value)
			fileProperties.addProperty #custom "glScaleSave" (::r8dui.r8ui.glScale_spn.value)
			fileProperties.addProperty #custom "glFOVSave" (::r8dui.r8ui.glFOV_spn.value)
			fileProperties.addProperty #custom "Orthographic" (::r8dui.r8ui.ortho_chk.checked)
		)else(
			setinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X" (::r8dui.r8ui.glDegree_spn.value as string)
		)
		$AllCamera.pos = [0,0,::r8dui.r8ui.glHeight_spn.value]
		$AllCamera.scale = [::r8dui.r8ui.glScale_spn.value,::r8dui.r8ui.glScale_spn.value,::r8dui.r8ui.glScale_spn.value]
		if RCam do ::r8dfn.isCameraOk()
	),
	fn LoadSceneVal = (
		if maxfilename != "" and $AllCamera != undefined and $S != undefined then(
			if (fileProperties.findProperty #custom "glDegreeSave") > 0 then(
				::r8dfn.DEGREE = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "glDegreeSave")
			)else(
				::r8dfn.DEGREE = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X"
			)
			if ::r8dfn.DEGREE != "" then(
				::r8dfn.DEGREE as float
			)else(
				::r8dfn.DEGREE = 35
			)
		)else(
			::r8dfn.DEGREE = (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "DEGREE_X")as float
		)
		if $AllCamera != undefined and $S != undefined then( try(::r8dui.r8ui.ortho_chk.checked = $S.orthoProjection)catch()
			if (fileProperties.findProperty #custom "glHeightSave") > 0 then(
				::r8dfn.GLOBHEIGHT = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "glHeightSave")
			)else(
				::r8dfn.GLOBHEIGHT = $AllCamera.pos.z
			)
			if (fileProperties.findProperty #custom "glScaleSave") > 0 then(
				::r8dfn.GLOBSCALE = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "glScaleSave")
			)else(
				::r8dfn.GLOBSCALE = $AllCamera.scale.x
			)
			if (fileProperties.findProperty #custom "glFOVSave") > 0 then(
				::r8dfn.GLFOV = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "glFOVSave")
			)else(
				try(::r8dfn.GLFOV = (for o in objects where superclassof o == camera collect o)[1].fov)catch(::r8dfn.GLFOV = 15)
			)
		)else(
			::r8dfn.GLOBHEIGHT = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLHEIGHT"
			if ::r8dfn.GLOBHEIGHT != "" then(
				::r8dfn.GLOBHEIGHT as float
			)else(
				::r8dfn.GLOBHEIGHT = 1
			)
			::r8dfn.GLOBSCALE = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLSCALE"
			if ::r8dfn.GLOBSCALE != "" then(
				::r8dfn.GLOBSCALE as float
			)else(
				::r8dfn.GLOBSCALE = 1
			)
			::r8dfn.GLFOV = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "RenderSet" "GLFOV"
			if ::r8dfn.GLFOV != "" then(
				::r8dfn.GLFOV as float
			)else(
				::r8dfn.GLFOV = 15
			)
		)
	),
	fn ClearSS_fn = (
		SSs=getNumNamedSelSets()
		if SSs > 0 do
		for i =1 to SSs do(
			try(Obj = getNamedSelSetItem i 1)catch(Obj = undefined)
			if Obj == undefined do
			try(deleteItem selectionSets selectionSets[i].name)catch()
		)
	),
	fn FindSelSet =(
		::r8dfn.ClearSS_fn()
		SSs=getNumNamedSelSets()
		::r8dui.r8ui.SScount_lbl.text = ("SS: "+(SSs as string))
		aSet=selectionSets
		SelSets=#()
		if SSs > 0 then(
		for i =1 to SSs do(
			ITc = getNamedSelSetItemCount i
			if ITc > 0 then(
				Obj = getNamedSelSetItem i 1
				if Obj != undefined do(
				if Obj.ishidden then HH=" -- Hide" else HH=""
				append SelSets (aSet[i].name+" -> "+(ITc as string)+HH)
				)
			)
			-- else(
				-- append SelSets (aSet[i].name+" --< empty >")
			-- )
		)
		::r8dui.r8ui.ssList_lbx.items = SelSets
		)else(
			::r8dui.r8ui.ssList_lbx.items = #()
			::r8dui.r8ui.ssObjList_lbx.items = #()
		)
		-- if (::r8dui.r8ui.ssList_lbx.selection as array).count > 0 then
			-- ::r8dfn.FindSSitem()
		-- else
			-- ::r8dui.r8ui.ssObjList_lbx.items = #()
	),
	fn FindSSitem =(
		try(
		::r8dui.r8ui.ssObjList_lbx.selection = 0
		SSL = (::r8dui.r8ui.ssList_lbx.selection as array)
		if SSL.count > 0 then(
			os = getNamedSelSetItemCount SSL[1]
			ITn = #()
			for i in 1 to os do(
				if (getNamedSelSetItem SSL[1] i) != undefined do
				append ITn (getNamedSelSetItem SSL[1] i).name
			)
			::r8dui.r8ui.ssObjList_lbx.items = ITn
		)
		)catch(::r8dfn.FindSelSet())
	),
	fn getkkkk=(
		f=openEncryptedFile ::r8dfn.CDKEYP ::r8dStart.CODEPOW
		if f != undefined then(
		try(kkkkCDKEY = readvalue f	)catch(kkkkCDKEY="NO")
			close f
		)else(
			kkkkCDKEY="NO"
		)
		return kkkkCDKEY
	),
	fn HideAllSSobj =(
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				oname.ishidden = true
			)
		)
	),
	fn ShowAllSSobj =(
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				oname.ishidden = false
			)
		)
	),
	fn HideUnSSobj SH = (
		AllOBJ=#()
		CR = filterstring ((renderers.current) as string) "_"
		if CR[1] == "V" do(
			for o in objects where superclassof o == GeometryClass and classof o != Biped_Object and classof o != BoneGeometry and classof o != Targetobject and (getUserProp o "VRay_Matte_Enable")!=true do(
					append AllOBJ o.name
			)
		)
		if CR[1] == "Default" do(
			for o in objects where superclassof o == GeometryClass and classof o != Biped_Object and classof o != BoneGeometry and classof o != Targetobject and (filterstring (o.material as string) ":")[2] != "Matte_Shadow" do(
					append AllOBJ o.name
			)
		)
		if CR[1] == "mental" do(
			for o in objects where superclassof o == GeometryClass and classof o != Biped_Object and classof o != BoneGeometry and classof o != Targetobject and (filterstring (o.material as string) ":")[2] != "Matte_Shadow_Reflection" do(
					append AllOBJ o.name
			)
		)
		if CR[1] != "Default" and CR[1] != "mental" and CR[1] != "V" do(
			for o in objects where superclassof o == GeometryClass and classof o != Biped_Object and classof o != BoneGeometry and classof o != Targetobject do(
					append AllOBJ o.name
			)
		)

		AllSSobj=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSSobj oname.name
			)
		)

		for ro in AllSSobj do(
		for ao in AllOBJ do(
			if ao == ro do(
				deleteitem AllOBJ (finditem AllOBJ ao)
			)
		))
		for o in AllOBJ do(
			oo=getnodebyname o
			if SH == "hide" then
				try(oo.isHidden = true)catch()
			else
				try(oo.isHidden = false)catch()
		)
	),
	fn getAni = (
		itemsArr = #()
		if maxfilepath != "" then(
			fileName = getfilenamefile maxfilename
			itemCount = getinisetting (maxfilepath+fileName+"_AT.ini") "AniTimes" "itemsCount" as integer
			for i in 1 to itemCount do(
				itemTmp = getinisetting (maxfilepath+fileName+"_AT.ini") "AniTimes" (i as string)
				append itemsArr itemTmp
			)
		)
		if itemsArr.count < 1 then
			::r8dui.r8ui.lbx1.items = #("！当前场景没有创建动作帧范围记录...")
		else
			::r8dui.r8ui.lbx1.items = itemsArr
	),
	fn getMaxNum = (
		::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
		::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
		createdialog ::r8dui.r8ui.loading_rol pos:[::r8dfn.UIx+286,::r8dfn.UIy+120] style: #()
		maxFiles_QF = #()
		try(
			::r8dfn.mFiles = #()
			::r8dfn.mCount_R8D = 0
			::r8dfn.maxForLbx = #()
			::r8dfn.RmFiles = #()
			::r8dfn.SelDirF = #()
			if ::r8dui.r8ui.subdir_chk.checked then(
				maxFiles_QF = ::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
				::r8dui.r8ui.maxCount.text = (".max:" + ::r8dfn.mCount_R8D as string)
			)else(
				maFiles = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
				for  f in maFiles do(
					mn = filterString f "\\"
					append maxFiles_QF mn[mn.count]
				)
				::r8dui.r8ui.maxCount.text = (".max:" + maFiles.count as string)
			)
			if ::r8dui.r8ui.getani_chk.checked == false do(
			if maxFiles_QF.count > 0 then
				::r8dui.r8ui.lbx1.items = maxFiles_QF
			else
				::r8dui.r8ui.lbx1.items = #("！该渲染目录指定的目录下没有找到","！max文件，请重新指定渲染目录","！勾选下方(查子目录)项可以查找子目","！录下的max文件")
		)
			)catch()
			-- if ::r8dui.r8ui.r_bmp.visible do
				-- ::r8dui.r8ui.lbx1.items = #("！请指定渲染目录")
		destroyDialog ::r8dui.r8ui.loading_rol
		return true
	),
	fn SetDegerView Deg =(
		CusCam=getnodebyname ::r8dui.r8ui.getCusCam.text
		if CusCam != undefined do(
			if (fileProperties.findProperty #custom "SetViewDeger") > 0 do(
			ABC=for o in selection collect o
				SVD=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "SetViewDeger")
			Dummy name:"R8D_SVDCam" ishidden:true isselected:false
		CusCam.parent = $R8D_SVDCam
			CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
		if CamTag != undefined do CamTag.parent = $R8D_SVDCam
	rotate $R8D_SVDCam (angleaxis -SVD [0,0,1])
	rotate $R8D_SVDCam (angleaxis Deg [0,0,1])
			delete $R8D_SVDCam
			select ABC
			fileproperties.addProperty #custom "SetViewDeger" Deg
		))
	),
	fn quickPV_fn D =(
	if renderers.current as string != "Missing_Renderer:Missing_Renderer" then(
		global BITPV = bitmap renderWidth renderHeight gamma:displayGamma
		global pvRCC = undefined
	-- holdMaxFile()
		RenderC=(for o in objects where superclassof o == camera collect o)	--获取像机
		if RenderC.count > 0 then(
			::r8dfn.SetDegerView 0
			if $R8D_Dummy == undefined do dummy name:"R8D_Dummy" ishidden:true
			--指定前方像机
			if $AllCamera != undefined and $S != undefined then(
				SC_Parent=$S.parent
				pvRCC=$S
				pvRCC.parent = $R8D_Dummy
			)else(
				GetCuCam = getnodebyname ::r8dui.r8ui.getCusCam.text
				if GetCuCam == undefined then(
					pvRCC=RenderC[1]
					-- OldParent = pvRCC.parent
					if classof pvRCC == Targetcamera then(
						execute ("select $"+(pvRCC.name as string)+"*")
						selection.parent = $R8D_Dummy
					)else(
						pvRCC.parent = $R8D_Dummy
					)
				)else(
					pvRCC=GetCuCam
					-- OldParent = GetCuCam.parent
					GetCuCam.parent = $R8D_Dummy
					CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
					if CamTag != undefined do CamTag.parent = $R8D_Dummy
				)
			)
		dummyObj = getnodebyname ::r8dui.r8ui.useDummyName.text
					RenderL=(for o in objects where superclassof o == light collect o)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then(
					--LightRotate link
					if ::r8dui.r8ui.cSeting.checked do(
						if RenderL.count > 0 do(
							LightOldPar = RenderL[1].parent
							for l in RenderL do (
								l.parent = dummyObj
								Tl=getnodebyname (l.name+".Target")
								if Tl != undefined do Tl.parent = dummyObj
							)
						)
					)
			rotate dummyObj (angleaxis (-D) [0,0,1])
		)else(
					--LightRotate link
					if ::r8dui.r8ui.cSeting.checked do(
						if RenderL.count > 0 do(
							LightOldPar = RenderL[1].parent
							for l in RenderL do (
								l.parent = $R8D_Dummy
								Tl=getnodebyname (l.name+".Target")
								if Tl != undefined do Tl.parent = $R8D_Dummy
							)
						)
					)
			rotate $R8D_Dummy (angleaxis (D) [0,0,1])
		)
		render camera:pvRCC outputwidth:renderWidth outputheight:renderHeight vfb:true to:BITPV
		-- fetchMaxFile quiet:true
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then(
			rotate dummyObj (angleaxis (D) [0,0,1])
		)else rotate $R8D_Dummy (angleaxis (-D) [0,0,1])
		
		-- display BITPV
		)else(messagebox "场景中没有创建像机！" title:"快速预览" beep:false)
	)else(messagebox "场景渲染器丢失，请重新设置指定渲染器！" title:"快速预览")
	),
	fn GetDegrees Note =(
		if Note != undefined do(
		Tag=getnodebyname (Note.name+".Target")
		if Tag != undefined then(
		adjacentLine = distance [0,0,Tag.pos.z] [(Note.pos.x),(Note.pos.y),Tag.pos.z]
		hypotenuseLine = distance [0,0,Tag.pos.z] Note.pos
		if adjacentLine<hypotenuseLine then ADeg = adjacentLine/hypotenuseLine else ADeg = hypotenuseLine/adjacentLine
		eDeg = (acos ADeg)
		if Note.pos.z < Tag.pos.z do eDeg = -eDeg
		return eDeg
		)else( messagebox "相机的目标虚拟体不存在，请重新创建Target目标相机。（建议使用工具相机！）" title:"R8D"
		return "error"
		)
		)
	),
	fn GetDegrees_B Note =(
		if Note != undefined do(
		cC = distance [(Note.pos.x),(Note.pos.y),0] [0,0,0]
		if Note.pos.x < 0 and Note.pos.y < 0 or Note.pos.x > 0 and Note.pos.y > 0 do
			zC = distance [0,0,0] [0,(Note.pos.y),0]
		if Note.pos.x < 0 and Note.pos.y > 0 or Note.pos.x > 0 and Note.pos.y < 0 do
			zC = distance [0,0,0] [(Note.pos.x),0,0]
		try(ADeg = zC/cC
		EndDeg = (acos ADeg))catch()
		if Note.pos.y > 0 and Note.pos.x < 0 do EndDeg += 90
		if Note.pos.x > 0 and Note.pos.y > 0 do EndDeg += 180
		if Note.pos.x > 0 and Note.pos.y < 0 do EndDeg += 270
		if Note.pos.x == 0 and Note.pos.y < 0 do EndDeg = 0
		if Note.pos.x < 0 and Note.pos.y == 0 do EndDeg = 90
		if Note.pos.x == 0 and Note.pos.y > 0 do EndDeg = 180
		if Note.pos.x > 0 and Note.pos.y == 0 do EndDeg = 270
		return EndDeg
		)
	),
	fn TimeAdjust stime = (
		if stime > timeStamp() then return true else return false
	),
	fn TimeAdd = (
		if (StarTime >= timeStamp()) do
		if (OneDo == false) then
			AllT+=86400000
		else(
			AllT+=(86400000-StarTime);	StarTime = 0 ; OneDo=false
		)
	),
	fn isCameraOk = (
		if (for o in objects where superclassof o == camera collect o).count > 0 then
			::r8dui.r8ui.cOK_bmp.visible = false
		else
			::r8dui.r8ui.cOK_bmp.visible = true
		-------------------------
		if ::r8dfn.isDirectoryExist ::r8dui.r8ui.outDir_edt.text then
			::r8dui.r8ui.l_bmp.visible = false
		else
			::r8dui.r8ui.l_bmp.visible = true
		-------------------------
		if ::r8dfn.isDirectoryExist ::r8dui.r8ui.renderDir_edt.text then
			::r8dui.r8ui.r_bmp.visible = false
		else
			::r8dui.r8ui.r_bmp.visible = true
		::r8dui.r8ui.unit_ddl.selection = (finditem ::r8dfn.SCENEUNIT units.SystemType)
		if (fileProperties.findProperty #custom "GetTCamera") > 0 then(
			TC=getnodebyname (fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "GetTCamera"))
			if TC != undefined do(
				::r8dui.r8ui.getCusCam.text = TC.name
				::r8dui.r8ui.reCam_btn.enabled = true
					-- Deg=fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "SetViewDeger")
					TagC = getnodebyname (TC.name+".Target")
			::r8dui.r8ui.glHeight_spn.value = TagC.pos.z
			::r8dui.r8ui.glDegree_spn.value =	(::r8dfn.GetDegrees TC)
			::r8dui.r8ui.ortho_chk.checked = TC.orthoProjection
			::r8dui.r8ui.glFOV_spn.value = TC.FOV
				if (fileProperties.findProperty #custom "R8D_CustemCameraScale") > 0 do(
					Scl = fileProperties.getPropertyValue #custom (fileProperties.findProperty #custom "R8D_CustemCameraScale")
					::r8dui.r8ui.glScale_spn.value = Scl
				)
			)
		)else(
			::r8dui.r8ui.getCusCam.text = "- None -"
			::r8dui.r8ui.reCam_btn.enabled = false
		)
	),
	fn getRpsNum = (
		rpsForLbx = #()
		psE = getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSPath"
		if (::r8dfn.isDirectoryExist psE) do(
			::r8dfn.rpsFiles = #()
			::r8dfn.rpsForLbx = #()
			::r8dfn.RmFilesPS = #()
			::r8dfn.SelDirFPS = #()
	--		fName_R8D = #()
			if ::r8dfn.PreSetRol.PSsub_chk.checked then(
				rpsForLbx = ::r8dfn.findSubDirPS_FN psE
			)else(
				rpsFiles = getFiles (psE+"\\*.rps")
				for  f in rpsFiles do(
					mn = filterString f "\\"
					append rpsForLbx mn[mn.count]
				)
			)
			if rpsForLbx.count > 0 then
				::r8dfn.PreSetRol.PS_lbx.items = rpsForLbx
			else
				::r8dfn.PreSetRol.PS_lbx.items = #("--没有找到RPS预设文件")
		)
		return true
	),
	fn findSubDirPS_FN ddd = (
		ff=getFiles (ddd+"\*.rps")
		if ff.count >0 do(
			fCnt = filterString ddd "\\"
			if fCnt.count > 4 then(
				if (getTextExtent ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-3]+"\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])).x < 175 then(
					append ::r8dfn.rpsForLbx ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-3]+"\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
				)else(
					if (getTextExtent ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])).x < 175 then(
						append ::r8dfn.rpsForLbx ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
					)else
						append ::r8dfn.rpsForLbx ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
				)
			)else(
				if (getTextExtent ("  [+] "+ddd)).x < 175 then(
					append ::r8dfn.rpsForLbx ("  [+] "+ddd)
				)else(
					if (getTextExtent ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])).x < 175 then(
						append ::r8dfn.rpsForLbx ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
					)else
						append ::r8dfn.rpsForLbx ("  [+] "+fCnt[1]+"\\...\\"+fCnt[fCnt.count])
				)
			)
			append ::r8dfn.RmFilesPS "***"
			append ::r8dfn.SelDirFPS ddd
		)
		
		if ff.count > 0 do(
			for f in ff do(
				append ::r8dfn.RmFilesPS f
				append ::r8dfn.SelDirFPS "F"
				mn = filterString f "\\"
				append ::r8dfn.rpsForLbx mn[mn.count]
			)
			join ::r8dfn.rpsFiles ff
		)
		dirs = getDirectories (ddd+"\*")
		if dirs.count>0 do(
			for d in dirs do(
				ed = substring d 1 (d.count-1)
				::r8dfn.findSubDirPS_FN ed
			)
		)
		return ::r8dfn.rpsForLbx
	),
	fn findSubDir_FN ddd = (
		ff=getFiles (ddd+"\*.max")
		if ff.count >0 do(
			fCnt = filterString ddd "\\"
			if fCnt.count > 6 then(
				if (getTextExtent ("  [+] ...\\"+fCnt[fCnt.count-3]+"\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])).x < 211 then(
					append ::r8dfn.maxForLbx ("  [+] ...\\"+fCnt[fCnt.count-3]+"\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
				)else(
					if (getTextExtent ("  [+] ...\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])).x < 211 then(
						append ::r8dfn.maxForLbx ("  [+] ...\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
					)else
						append ::r8dfn.maxForLbx ("  [+] ...\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
				)
			)else(
				if (getTextExtent ("  [+] "+ddd)).x < 211 then(
					append ::r8dfn.maxForLbx ("  [+] "+ddd)
				)else(
					if (getTextExtent ("  [+] ...\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])).x < 211 then(
						append ::r8dfn.maxForLbx ("  [+] ...\\"+fCnt[fCnt.count-2]+"\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
					)else
						append ::r8dfn.maxForLbx ("  [+] ...\\"+fCnt[fCnt.count-1]+"\\"+fCnt[fCnt.count])
				)
			)
			append ::r8dfn.RmFiles "***"
			append ::r8dfn.SelDirF ddd
		)
		
		if ff.count > 0 do(
			for f in ff do(
				append ::r8dfn.RmFiles f
				append ::r8dfn.SelDirF "F"
				mn = filterString f "\\"
				append ::r8dfn.maxForLbx mn[mn.count]
				::r8dfn.mCount_R8D += 1
			)
			join ::r8dfn.mFiles ff
		)
		dirs = getDirectories (ddd+"\*")
		if dirs.count>0 do(
			for d in dirs do(
				ed = substring d 1 (d.count-1)
				::r8dfn.findSubDir_FN ed
			)
		)
		return ::r8dfn.maxForLbx
	),
	fn PreviewRR =(
	rollout perview_rollout "预览渲染" width:260
	(
		label lbl1 "对MAX文档批量创建预览渲染图\n选择要渲染的方向" offset:[20,0] height:50 across:1
	checkButton S_btn "S" pos:[116,195] width:26 height:26 highlightColor:(color 224 67 67) checked:true
	checkButton ES_btn "ES" pos:[178,167] width:26 height:26 highlightColor:(color 224 130 67)
	checkButton E_btn "E" pos:[208,119] width:26 height:26 highlightColor:(color 224 206 43)
	checkButton EN_btn "EN" pos:[178,71] width:26 height:26 highlightColor:(color 137 224 43)
	checkButton N_btn "N" pos:[116,43] width:26 height:26 highlightColor:(color 43 224 140)
	checkButton WN_btn "WN" pos:[55,71] width:26 height:26 highlightColor:(color 43 158 224)
	checkButton W_btn "W" pos:[26,119] width:26 height:26 highlightColor:(color 43 85 224)
	checkButton WS_btn "WS" pos:[55,167] width:26 height:26 highlightColor:(color 127 43 224)
		button PerV_go "START" offset:[0,40] across:1 tooltip:"开始批量预览渲染"
		on S_btn changed state do(
			if state then (ES_btn.checked=false ; E_btn.checked=false ; EN_btn.checked=false ; N_btn.checked=false ; WN_btn.checked=false ; W_btn.checked=false ; WS_btn.checked=false
			)else
			if ES_btn.checked==false and E_btn.checked==false and EN_btn.checked==false and N_btn.checked==false and WS_btn.checked==false and W_btn.checked==false and WS_btn.checked==false do S_btn.checked = true
		)
		on ES_btn changed state do(
			if state then (S_btn.checked=false ; E_btn.checked=false ; EN_btn.checked=false ; N_btn.checked=false ; WN_btn.checked=false ; W_btn.checked=false ; WS_btn.checked=false
			)else
			if S_btn.checked==false and E_btn.checked==false and EN_btn.checked==false and N_btn.checked==false and WS_btn.checked==false and W_btn.checked==false and WS_btn.checked==false do ES_btn.checked = true
		)
		on E_btn changed state do(
			if state then (S_btn.checked=false ; ES_btn.checked=false ; EN_btn.checked=false ; N_btn.checked=false ; WN_btn.checked=false ; W_btn.checked=false ; WS_btn.checked=false
			)else
			if S_btn.checked==false and ES_btn.checked==false and EN_btn.checked==false and N_btn.checked==false and WS_btn.checked==false and W_btn.checked==false and WS_btn.checked==false do E_btn.checked = true
		)
		on EN_btn changed state do(
			if state then (S_btn.checked=false ; E_btn.checked=false ; ES_btn.checked=false ; N_btn.checked=false ; WN_btn.checked=false ; W_btn.checked=false ; WS_btn.checked=false
			)else
			if S_btn.checked==false and E_btn.checked==false and ES_btn.checked==false and N_btn.checked==false and WS_btn.checked==false and W_btn.checked==false and WS_btn.checked==false do EN_btn.checked = true
		)
		on N_btn changed state do(
			if state then (S_btn.checked=false ; E_btn.checked=false ; EN_btn.checked=false ; ES_btn.checked=false ; WN_btn.checked=false ; W_btn.checked=false ; WS_btn.checked=false
			)else
			if S_btn.checked==false and E_btn.checked==false and EN_btn.checked==false and ES_btn.checked==false and WN_btn.checked==false and W_btn.checked==false and WS_btn.checked==false do N_btn.checked = true
		)
		on WN_btn changed state do(
			if state then (S_btn.checked=false ; E_btn.checked=false ; EN_btn.checked=false ; N_btn.checked=false ; ES_btn.checked=false ; W_btn.checked=false ; WS_btn.checked=false
			)else
			if S_btn.checked==false and E_btn.checked==false and EN_btn.checked==false and N_btn.checked==false and ES_btn.checked==false and W_btn.checked==false and WS_btn.checked==false do WN_btn.checked = true
		)
		on W_btn changed state do(
			if state then (S_btn.checked=false ; E_btn.checked=false ; EN_btn.checked=false ; N_btn.checked=false ; ES_btn.checked=false ; WN_btn.checked=false ; WS_btn.checked=false
			)else
			if S_btn.checked==false and E_btn.checked==false and EN_btn.checked==false and N_btn.checked==false and ES_btn.checked==false and WN_btn.checked==false and WS_btn.checked==false do W_btn.checked = true
		)
		on WS_btn changed state do(
			if state then (S_btn.checked=false ; E_btn.checked=false ; EN_btn.checked=false ; N_btn.checked=false ; ES_btn.checked=false ; W_btn.checked=false ; WN_btn.checked=false
			)else
			if S_btn.checked==false and E_btn.checked==false and EN_btn.checked==false and N_btn.checked==false and ES_btn.checked==false and W_btn.checked==false and WN_btn.checked==false do WS_btn.checked = true
		)
		fn PerV_FN =(
			destroyDialog perview_rollout
			::r8dfn.STOPRM = false
		if (::r8dfn.isDirectoryExist ::r8dui.r8ui.renderDir_edt.text) then(
				if ::r8dui.r8ui.subdir_chk.checked then(
					::r8dfn.RmFiles = #()	--Info: RmFiles里包含文件夹(***)和文件(c:\text\text.max)	在 ::r8dfn.findSubDir_FN 函数执行完成后被赋值
					::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
					Sta = 0
					for o in ::r8dui.r8ui.lbx1.selection do(
						if ::r8dfn.RmFiles[o] == "***" then Sta += 1
					)
					if Sta == 0 then files = ::r8dfn.RmFiles else(
						messagebox "不要选中带[+]的文件夹！" title:"R8D"
						files = #()
					)
				)else(
					files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
				)
				if files.count > 0 then(
				if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
				local UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
				local UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
				if UIx < 390 then
					createdialog ::r8dfn.RR_rol pos:[UIx+510,UIy] style: #(#style_sysmenu,#style_toolwindow)
				else
					createdialog ::r8dfn.RR_rol pos:[UIx-400,UIy] style: #(#style_sysmenu,#style_toolwindow)
				::r8dfn.RR_rol.lbl2.visible = true
			::r8dfn.RR_rol.openF_btn.enabled = false
		StarTime = timeStamp()
				SetTimes = false
					local rCount = 0
					local rItem = #()
					local loC2=1
					::r8dfn.RR_rol.load_pro.visible = false
					::r8dfn.RR_rol.rC_lbl.visible = true
					::r8dfn.RR_rol.fC_lbl.visible = true
					::r8dfn.RR_rol.load_pro2.color = (color 215 19 18)
					::r8dfn.RR_rol.fC_lbl.text = (::r8dui.r8ui.lbx1.selection as array).count as string
					for i in ::r8dui.r8ui.lbx1.selection do(
					global SRView = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SHOWRV")
					if ::r8dfn.STOPRM == false do( --Files loop Stop
						if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
						if (fileProperties.findProperty #custom "SetViewDeger") > 0 do
							::r8dfn.SetDegerView 0
				local RENDPIC = bitmap renderWidth renderHeight gamma:displayGamma --show render view
						--激活渲染设置RS 2
							if ::r8dui.r8ui.useColorSet_chk.checked do(
							if (renderpresets.LoadAll 0 ::r8dui.r8ui.rps_txt.text) == false do(
								rCount += 1
								insertitem ("  !--- "+(maxFileName)+" 应用渲染预设失败！") rItem rCount
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)
							)
							
						if ::r8dui.r8ui.gamma_lbl.checked do GammaSet_fn()
						--全局参数设置------------
						if ::r8dui.r8ui.glob_chk.checked do(
						if ::r8dui.r8ui.getCusCam.text == "- None -" then(
							RenderR=(for o in objects where superclassof o == camera collect o)
							if RenderR.count > 0 do(	delete RenderR	)
							--Create Cameras----
							::r8dfn.createCCC false
							)else(
								PICKCAM = (getnodebyname ::r8dui.r8ui.getCusCam.text)
								if PICKCAM != undefined then(
									PICKCAMTAG = getnodebyname (::r8dui.r8ui.getCusCam.text + ".Target")
									if PICKCAMTAG != undefined then(
									PICKCAM.pos = ::r8dui.CustemCam
									PICKCAMTAG.pos = ::r8dui.CustemCamTag
									PICKCAM.FOV = ::r8dui.CustemCamFOV
									PICKCAM.orthoProjection = ::r8dui.CustemCamOrt
								)else(
								try(delete PICKCAM)catch()
Targetcamera name:::r8dui.r8ui.getCusCam.text fov:::r8dui.CustemCamFOV orthoProjection:::r8dui.CustemCamOrt nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:::r8dui.CustemCam isSelected:off target:(Targetobject name:(::r8dui.r8ui.getCusCam.text + ".Target") transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] ::r8dui.CustemCamTag))
								)
								)else(
Targetcamera name:::r8dui.r8ui.getCusCam.text fov:::r8dui.CustemCamFOV orthoProjection:::r8dui.CustemCamOrt nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:::r8dui.CustemCam isSelected:off target:(Targetobject name:(::r8dui.r8ui.getCusCam.text + ".Target") transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] ::r8dui.CustemCamTag))
								)
							)
						)--全局参数设置------------end
						if ::r8dui.r8ui.gloSize_chk.checked do(
							renderWidth = ::r8dui.r8ui.RW_spn.value
							renderHeight = ::r8dui.r8ui.RH_spn.value
						)--全局参数设置------------end
						try(renderers.production.output_on = false)catch()
						--HideBone
						if ::r8dui.r8ui.bSeting.checked then(
							for o in objects where classof o == Biped_Object or classof o == BoneGeometry do o.isHidden = true
						)else(
							for o in objects where classof o == Biped_Object or classof o == BoneGeometry do o.isHidden = false
						)
						--DoubleSide
						if ::r8dui.r8ui.aSeting.checked do(
							for o in objects where superclassof o == GeometryClass do
								try(o.material.twoSided = on)catch()
						)
					RenderC=(for o in objects where superclassof o == camera collect o)	--获取像机
					if RenderC.count > 0 then(
						--指定前方像机
						if $AllCamera != undefined and $S != undefined then(
							if S_btn.checked do ::r8dfn.RCCC=$S
							if ES_btn.checked do ::r8dfn.RCCC=$ES
							if E_btn.checked do ::r8dfn.RCCC=$E
							if EN_btn.checked do ::r8dfn.RCCC=$EN
							if N_btn.checked do ::r8dfn.RCCC=$N
							if WN_btn.checked do ::r8dfn.RCCC=$WN
							if W_btn.checked do ::r8dfn.RCCC=$W
							if WS_btn.checked do ::r8dfn.RCCC=$WS
							if O_btn.checked do ::r8dfn.RCCC=$O
						)else(
						GetCuCam = getnodebyname ::r8dui.r8ui.getCusCam.text
						if GetCuCam == undefined then(
							::r8dfn.RCCC=RenderC[1]
							)else(
							::r8dfn.RCCC=GetCuCam
							)
			Dummy name:"R8D_SVDCam" ishidden:true isselected:false
						if classof ::r8dfn.RCCC == Targetcamera then(
							execute ("select $"+(::r8dfn.RCCC.name as string)+"*")
							selection.parent = $R8D_SVDCam
							)else
							::r8dfn.RCCC.parent = $R8D_SVDCam
			CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
		if CamTag != undefined do CamTag.parent = $R8D_SVDCam
			if ES_btn.checked do rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_ES_spn.value [0,0,1])
			if E_btn.checked do  rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_E_spn.value [0,0,1])
			if EN_btn.checked do rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_EN_spn.value [0,0,1])
			if N_btn.checked do  rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_N_spn.value [0,0,1])
			if WN_btn.checked do rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_WN_spn.value [0,0,1])
			if W_btn.checked do  rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_W_spn.value [0,0,1])
			if WS_btn.checked do rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_WS_spn.value [0,0,1])
			if O_btn.checked do rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.Deg_O_spn.value [0,0,1])
						)
						)else(
					::r8dfn.RDirMsgCount+=1
							rCount += 1
							insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxfilename+"  (没有创建像机)") rItem rCount
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
	rdoSet = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH") as integer
	if rdoSet == 0 then
		savePsr = maxfilepath
	else (if rdoSet == 1 then savePsr = maxfilepath else savePsr = (::r8dui.r8ui.outDir_edt.text+"\\"))
	fiNa = getfilenamefile maxfilename
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(savePsr+fiNa+"_preview"+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:animationRange.start pos:#vfb_upper_left to:RENDPIC
	)catch(
		::r8dfn.RENDERMSG = true
	)
	)else(::r8dfn.STOPRM = true)--Stop
					if ::r8dfn.RENDERMSG == false do(
						::r8dfn.RR_rol.rC_lbl.text = loC2 as string
						::r8dfn.RR_rol.load_pro2.value = 100.*loC2/(::r8dui.r8ui.lbx1.selection as array).count
						loC2+=1
					rCount += 1
					insertitem (maxfilename+" --> "+"  渲染完成") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
					::r8dfn.RENDERMSG = false
				)else(
					::r8dfn.RDirMsgCount+=1
					rCount += 1
					FNa = filterstring files[i] "\\"
					insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+FNa[FNa.count]+"  (无法打开)") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)
				if (loC2+::r8dfn.RDirMsgCount-1) != (::r8dui.r8ui.lbx1.selection as array).count and RENDPIC != undefined do unDisplay RENDPIC
					) --Files loop Stop
					)--files for in ::r8dui.r8ui.lbx1.selection 循环
				if ::r8dfn.STOPRM then(
					rCount += 1
					insertitem ("  ！--- 用户中断渲染") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
					::r8dfn.RR_rol.lbl1.text = "渲染已中断..."
				)else(
					rCount += 1
					insertitem "渲染进程完毕......" rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
					if ::r8dfn.RDirMsgCount > 0 then(
						::r8dfn.RR_rol.lbl1.text = ("批量渲染操作完毕，有"+(::r8dfn.RDirMsgCount as string)+"个文档没有渲染成功！")
					)else(
	rdoSet = (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "SRset" "SAVEPATH") as integer
	if rdoSet > 1 then ::r8dfn.RR_rol.lbl1.text = "渲染完毕，预览图存在输出路径下后缀名：_preview" else ::r8dfn.RR_rol.lbl1.text = "渲染完毕，预览图存在max文件相同目录下后缀名：_preview"
						::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
					)
				)
				::r8dfn.RDirMsgCount = 0
		EndTime = timeStamp()
		if SetTimes then(
			useTime=((86400000-StarTime)+EndTime)/1000
		)else(
		useTime = (EndTime - StarTime)/1000
		)
				rCount += 1
				insertitem ("用时："+(::r8dfn.getTimeUse_fn useTime)) rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)else(messagebox "请在列表里选择要批量渲染的max文件，双击列表选择全部。" title:"R8D")
		)
		)else(messagebox "请输入正确的要批量渲染的目录!" title:"R8D")
		)
		
		on PerV_go pressed do PerV_FN()
		)
		createDialog perview_rollout
	),
	fn InOrder NOr  =(
		NameF=""
		NONnum = #(::r8dui.r8ui.Sc1.value,::r8dui.r8ui.An2.value,::r8dui.r8ui.Ss3.value,::r8dui.r8ui.Di4.value)
		for a in 1 to NOr.count do(
			ac = finditem NONnum a
			NameF = NameF + NOr[ac]
		)
		return NameF
	),
	fn getVersion tex=(
		if tex == "18" then return "MAX 2016" else
		if tex == "17" then return "MAX 2015" else
		if tex == "16" then return "MAX 2014" else
		if tex == "15" then return "MAX 2013" else
		if tex == "14" then return "MAX 2012" else
		if tex == "13" then return "MAX 2011" else
		if tex == "12" then return "MAX 2010" else
		if tex == "11" then return "MAX 2009" else
		if tex == "10" then return "MAX 2008" else
		if tex == "9" then return "MAX 9.0"   else
			return "MAX ????"
	),
	fn RRRGO = (
		if ::r8dui.r8ui.ES_btn.checked==false and ::r8dui.r8ui.E_btn.checked==false and ::r8dui.r8ui.EN_btn.checked==false and ::r8dui.r8ui.N_btn.checked==false and ::r8dui.r8ui.WN_btn.checked==false and ::r8dui.r8ui.W_btn.checked==false and ::r8dui.r8ui.WS_btn.checked==false and ::r8dui.r8ui.O_btn.checked==false and ::r8dui.r8ui.S_btn.checked==false then(
			messagebox "请激活要渲染的方向!" title:"R8D"
		)else(
			if (::r8dfn.isDirectoryExist ::r8dui.r8ui.outDir_edt.text) or ::r8dui.r8ui.curDir_cbn.checked then(
				RenderC=(for o in objects where superclassof o == camera collect o)	--获取像机
				if RenderC.count > 0 then(
				if maxFilename == "" then
					messagebox "请保存该场景再进行渲染！" title:"R8D"
				else(
		dummyObj = getnodebyname ::r8dui.r8ui.useDummyName.text
				StarTime = timeStamp()
				local SetTimes = false
				vfbp=(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "VFBPOS")as integer
				try(rendSaveFile = false)catch()
					if ::r8dui.r8ui.iSeting.checked then(if ::r8dfn.SearchNa_fn (getfilenamefile maxfilename) (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT") then DF=0 else DF=1)else DF=0
					if ::r8dui.r8ui.kSeting.checked then(if ::r8dfn.SearchNa_fn (getfilenamefile maxfilename) (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT") then DFF=0 else DFF=1)else DFF=0
					if $R8D_Dummy == undefined do dummy name:"R8D_Dummy" ishidden:true
					--指定前方像机
					if $AllCamera != undefined and $S != undefined then(
						SC_Parent=$S.parent
						::r8dfn.RCCC=$S
						::r8dfn.RCCC.parent = $R8D_Dummy
					)else(
						GetCuCam = getnodebyname ::r8dui.r8ui.getCusCam.text
						if GetCuCam == undefined then(
							::r8dfn.RCCC=RenderC[1]
							OldParent = ::r8dfn.RCCC.parent
							if classof ::r8dfn.RCCC == Targetcamera then(
								execute ("select $"+(::r8dfn.RCCC.name as string)+"*")
								selection.parent = $R8D_Dummy
							)else(
								::r8dfn.RCCC.parent = $R8D_Dummy
							)
						)else(
							::r8dfn.RCCC=GetCuCam
							OldParent = GetCuCam.parent
							GetCuCam.parent = $R8D_Dummy
							CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
							if CamTag != undefined do CamTag.parent = $R8D_Dummy
						)
					)
					--LightRotate link
					RenderL=(for o in objects where superclassof o == light collect o)
					if ::r8dui.r8ui.cSeting.checked do(
						if RenderL.count > 0 do(
							LightOldPar = RenderL[1].parent
							for l in RenderL do (
								l.parent = $R8D_Dummy
								Tl=getnodebyname (l.name+".Target")
								if Tl != undefined do Tl.parent = $R8D_Dummy
							)
						)
					)
					--HideBone
					if ::r8dui.r8ui.bSeting.checked then(
						for o in objects where classof o == Biped_Object or classof o == BoneGeometry do o.isHidden = true
					)else(
						for o in objects where classof o == Biped_Object or classof o == BoneGeometry do o.isHidden = false
					)
					--DoubleSide
					if ::r8dui.r8ui.aSeting.checked do(
						for o in objects where superclassof o == GeometryClass do
							try(o.material.twoSided = on)catch()
					)
					rCount = 0
					rItem = #()
					try(renderers.production.output_on = false)catch()
					Sep = ::r8dui.r8ui.cut_edt.text
				maxName = getfilenamefile maxFileName
				FF = filterstring maxfilepath "\\"
				global SRView = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SHOWRV")
		global BITRENDER = bitmap renderWidth renderHeight gamma:displayGamma	--show render view
		if ::r8dui.r8ui.jSeting.checked do (
			OldFFram = animationRange.start
			OldBFram = animationRange.end
			animationRange = interval animationRange.start (animationRange.start + 1)
		)
				if ::r8dui.r8ui.lbx1.items[1] != "！当前场景没有创建动作帧范围记录..." then( --有动作渲染
			::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
			::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
			if ::r8dfn.UIx < 390 then
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style:#(#style_sysmenu,#style_toolwindow)
			else
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style:#(#style_sysmenu,#style_toolwindow)
			::r8dfn.RR_rol.lbl2.visible = true
					if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(

		if fileProperties.findProperty #contents "Headers" > 0 do(
			a = fileproperties.getPropertyValue #contents (fileProperties.findProperty #contents "Headers")
			b = fileProperties.getItems a[1]
			dd=filterstring b[b.count] ": "
			ddd=filterstring dd[dd.count] "."
			format "% :  %\n" maxFileName (::r8dfn.getVersion ddd[1])
			rCount += 1
			insertitem (maxFileName+" :  "+(::r8dfn.getVersion ddd[1])) rItem rCount
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
---------------------------------------Have Action
if ::r8dui.r8ui.getSS_chk.checked then(
if (::r8dui.r8ui.ssList_lbx.selection as array).count > 0 then(
			rCount += 1
			insertitem ("   --- 包含 "+((getNumNamedSelSets()) as string)+" 个分块") rItem rCount
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
	--隐藏未分块物体
	if ::r8dui.r8ui.hSeting.checked then ::r8dfn.HideUnSSobj "hide"
	for ss in (::r8dui.r8ui.ssList_lbx.selection as array) do(
		SSName = selectionSets[ss].name
	--自动遮罩	1
		AllSS=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSS oname.name
			)
		)
		os = getNamedSelSetItemCount ss
		ROName=#()
		OldNam=#()
		OldMat=#()
		Oldcount = 1
		for ii = 1 to os do(
			oname = getNamedSelSetItem ss ii
			ROName[ii] = oname.name
		)
		if ::r8dui.r8ui.fSeting.checked then(
			::r8dfn.ShowAllSSobj()
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				MMat = MatteShadow ()
				MMat.receiveshadows = off
				MMat.affectAlpha = off
			)
			if CR[1] == "mental" do(
				MMat=Matte_Shadow_Reflection__mi ()
				MMat.catch_shadows = off
				MMat.ao_on = off
			)
			for ro in ROName do(
			for ao in AllSS do(
				if ao == ro do(
					deleteitem AllSS (finditem AllSS ao)
				)
			))
			for o in AllSS do(
				oname=getnodebyname o
				if CR[1] == "V" then(
					setUserProp oname "VRay_Matte_Enable" true
					setUserProp oname "VRay_Matte_Alpha" -1
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					OldNam[Oldcount] = oname.name
				)else(
					OldNam[Oldcount] = oname.name
					OldMat[Oldcount] = oname.material
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					oname.material = MMat
				)
				Oldcount += 1
			)
		)else(
			::r8dfn.HideAllSSobj()
			for ii = 1 to os do(
				oname = getNamedSelSetItem ss ii
				oname.ishidden = false
			)
		)
---------------------------------------
		::r8dfn.RR_rol.load_pro2.visible = true
		if ::r8dfn.STOPRM == false do(
			rCount += 1
			insertitem ("   --- 正在渲染分块: "+SSName) rItem rCount
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)
						loC1=1
						for i in ::r8dui.r8ui.lbx1.selection do(
							sTime = filterString (::r8dui.r8ui.lbx1.items[i]) "-()/" --ActionName
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = (maxfilepath+::r8dui.r8ui.curDir_edt.text+"\\") else
					saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FFn=FF[FF.count]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					--激活F按钮时运用文件夹归档
					if ::r8dui.r8ui.scF.checked then Scene_N=(maxName+"\\") else Scene_N=""
					if ::r8dui.r8ui.anF.checked then Anim_N=(sTime[1]+"\\") else Anim_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					aniC=::r8dui.r8ui.anSpn.value
					ss=::r8dui.r8ui.sSpn.value
						CDNnum = #(sce,aniC,ss)
						CDNnam = #(Scene_N,Anim_N,SS_N)
						for a in 1 to 3 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
						if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
							loC2=1
							sTimeC = ((sTime[3]as integer -DF)-(sTime[2]as integer))/::r8dui.r8ui.FG_spn.value
							for i = ((sTime[2]as integer)+DFF) to ((sTime[3]as integer)-DF) by ::r8dui.r8ui.FG_spn.value do(
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
							::r8dfn.TimeAdd()
		if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.ES.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.ES.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( ESsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.ES.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)--Stop
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.E.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.E.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( EsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.E.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.EN.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.EN.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( ENsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.EN.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.N.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.N.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( NsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.N.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.WN.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WN.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( WNsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WN.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.W.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.W.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( WsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.W.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.WS.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WS.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( WSsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WS.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.O.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.O.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( WSsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.O.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.S.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.S.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else( SsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.S.text+Sep)
				SSSName = (SSName+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		)
							nI += 1
			if ::r8dfn.STOPRM == false do(
				::r8dfn.RR_rol.load_pro.value = 100.*loC2/sTimeC
				loC2+=1
			)
						)--渲染帧循环--end
			if ::r8dfn.STOPRM == false do(
				::r8dfn.RR_rol.load_pro2.value = 100.*loC1/(::r8dui.r8ui.lbx1.selection as array).count
				loC1+=1
				if ::r8dfn.RENDERMSG == false do(
					rCount += 1
					insertitem ("Action:( "+(sTime[1] as string)+" )--- Render Over") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)
			)
					)--动作循环--end SS
					for i = 1 to OldNam.count do(
						OO = getnodebyname OldNam[i]
						if CR[1] == "V" then(
							setUserProp OO "VRay_Matte_Enable" false
							setUserProp OO "VRay_Matte_Alpha" 1
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)else(
							OO.material = OldMat[i]
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)
					)
					)--SS Loop
				)else(messagebox "请选择要渲染的分块！")
			)else( --No SS_GO
						loC1=1
						for i in ::r8dui.r8ui.lbx1.selection do(
							sTime = filterString (::r8dui.r8ui.lbx1.items[i]) "-()/" --ActionName
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = (maxfilepath+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FFn=FF[FF.count]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					--激活F按钮时运用文件夹归档
					if ::r8dui.r8ui.scF.checked then Scene_N=(maxName+"\\") else Scene_N=""
					if ::r8dui.r8ui.anF.checked then Anim_N=(sTime[1]+"\\") else Anim_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					aniC=::r8dui.r8ui.anSpn.value
						if sce < aniC then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,Anim_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
			::r8dfn.RR_rol.load_pro2.visible = true
						if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
			loC2=1
			sTimeC = ((sTime[3]as integer -DF)-(sTime[2]as integer))/::r8dui.r8ui.FG_spn.value
							for i = ((sTime[2]as integer)+DFF) to ((sTime[3]as integer)-DF) by ::r8dui.r8ui.FG_spn.value do(
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
						::r8dfn.TimeAdd()
		if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.ES.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.ES.text+Sep)
				)
			)else( ESsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)--Stop
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.E.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.E.text+Sep)
				)
			)else( EsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.E.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.EN.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.EN.text+Sep)
				)
			)else( ENsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.N.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.N.text+Sep)
				)
			)else( NsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.N.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.WN.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WN.text+Sep)
				)
			)else( WNsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.W.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.W.text+Sep)
				)
			)else( WsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.W.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.WS.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WS.text+Sep)
				)
			)else( WSsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.O.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.O.text+Sep)
				)
			)else( WSsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.O.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		)
		if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (maxName+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.S.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (maxName+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.S.text+Sep)
				)
			)else( SsaveDir = saveDir
				MFName = (maxName+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.S.text+Sep)
			)
		if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
			::r8dfn.RENDERMSG = true
			)
		)else(::r8dfn.STOPRM = true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		)
							nI += 1
			if ::r8dfn.STOPRM == false do(
				::r8dfn.RR_rol.load_pro.value = 100.*loC2/sTimeC
				loC2+=1
			)
						)--渲染帧循环--end
			if ::r8dfn.STOPRM == false do(
				::r8dfn.RR_rol.load_pro2.value = 100.*loC1/(::r8dui.r8ui.lbx1.selection as array).count
				loC1+=1
				if ::r8dfn.RENDERMSG == false do(
					rCount += 1
					insertitem ("Action:( "+(sTime[1] as string)+" )--- Render Over") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)
			)
					)--动作循环--end
			)--No SS
			if ::r8dfn.RENDERMSG then(
				rCount += 1
				insertitem (" ! --- "+maxFileName+"... (渲染失败，检查渲染器或设置是否正确)") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "渲染操作已完毕，未成功！"
			)else(
				::r8dfn.RR_rol.lbl1.text = "所有动作已渲染完毕，请查收..."
			)
			if ::r8dfn.STOPRM then(
				rCount += 1
				insertitem ("  ！--- 用户中断渲染") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "渲染已中断..."
			)else(
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
				::r8dfn.RR_rol.load_pro.color = (color 9 185 197)
				rCount += 1
				insertitem "渲染进程完毕......" rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				if ::r8dui.r8ui.autoOff.checked do (shellLaunch "shutdown.exe" " -s -t 120"
		if (queryBox "电脑将在2分钟后关机，是否要取消？" title:"R8D") do(shellLaunch "shutdown.exe" " -a") )
			)
			::r8dfn.RENDERMSG=false
				)else(messagebox "请在列表里选择要渲染的动作。" title:"R8D")
				)else( --单文档无动作
					if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1

		if fileProperties.findProperty #contents "Headers" > 0 do(
			a = fileproperties.getPropertyValue #contents (fileProperties.findProperty #contents "Headers")
			b = fileProperties.getItems a[1]
			dd=filterstring b[b.count] ": "
			ddd=filterstring dd[dd.count] "."
			format "% :  %\n" maxFileName (::r8dfn.getVersion ddd[1])
			rCount += 1
			insertitem (maxFileName+" :  "+(::r8dfn.getVersion ddd[1])) rItem rCount
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
)
					startF = animationRange.start
					endF = animationRange.end
			::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
			::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
			if ::r8dfn.UIx < 390 then
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			else
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			::r8dfn.RR_rol.lbl2.visible = true
			frameC=(endF-DF-startF+1)/::r8dui.r8ui.FG_spn.value
			::r8dfn.RR_rol.load_pro2.visible = true
			::r8dfn.RR_rol.rC_lbl.visible = false
			::r8dfn.RR_rol.fC_lbl.visible = false
			::r8dfn.RR_rol.load_pro.color = (color 245 52 70)
---------------------------------------NO Action
if ::r8dui.r8ui.getSS_chk.checked then(
if (::r8dui.r8ui.ssList_lbx.selection as array).count > 0 then(
			rCount += 1
			insertitem ("   --- 包含 "+((getNumNamedSelSets()) as string)+" 个分块") rItem rCount
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
	loC2=1
	::r8dfn.RR_rol.load_pro2.value=0
	--隐藏未分块物体
	if ::r8dui.r8ui.hSeting.checked then ::r8dfn.HideUnSSobj "hide"
	for ss in (::r8dui.r8ui.ssList_lbx.selection as array) do(
		SSName = selectionSets[ss].name
	--自动遮罩	2
		AllSS=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSS oname.name
			)
		)
		os = getNamedSelSetItemCount ss
		ROName=#()
		OldNam=#()
		OldMat=#()
		Oldcount = 1
		for ii = 1 to os do(
			oname = getNamedSelSetItem ss ii
			ROName[ii] = oname.name
		)
		if ::r8dui.r8ui.fSeting.checked then(
			::r8dfn.ShowAllSSobj()
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				MMat = MatteShadow ()
				MMat.receiveshadows = off
				MMat.affectAlpha = off
			)
			if CR[1] == "mental" do(
				MMat=Matte_Shadow_Reflection__mi ()
				MMat.catch_shadows = off
				MMat.ao_on = off
			)
			for ro in ROName do(
			for ao in AllSS do(
				if ao == ro do(
					deleteitem AllSS (finditem AllSS ao)
				)
			))
			for o in AllSS do(
				oname=getnodebyname o
				if CR[1] == "V" then(
					setUserProp oname "VRay_Matte_Enable" true
					setUserProp oname "VRay_Matte_Alpha" -1
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					OldNam[Oldcount] = oname.name
				)else(
					OldNam[Oldcount] = oname.name
					OldMat[Oldcount] = oname.material
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					oname.material = MMat
				)
				Oldcount += 1
			)
		)else(
			::r8dfn.HideAllSSobj()
			for ii = 1 to os do(
				oname = getNamedSelSetItem ss ii
				oname.ishidden = false
			)
		)
---------------------------------------
		if ::r8dfn.STOPRM == false do(
			rCount += 1
			insertitem ("   --- 正在渲染分块: "+SSName) rItem rCount
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)
			loC1=1
	::r8dfn.RR_rol.load_pro.value=0
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = (maxfilepath+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FFn=FF[FF.count]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					--激活F按钮时运用文件夹归档
					if ::r8dui.r8ui.scF.checked then Scene_N=(maxName+"\\") else Scene_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					ss=::r8dui.r8ui.sSpn.value
					if sce < ss then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,SS_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
					if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
					for i = (startF+DFF) to (endF-DF) by ::r8dui.r8ui.FG_spn.value do(
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
						::r8dfn.TimeAdd()
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM = true)--Stop
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.E.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.N.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.W.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.O.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.S.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
			SSSName = (SSName+Sep)
			CHAName = ""
		)
	)else( SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
									nI += 1
			if ::r8dfn.STOPRM == false do(
			::r8dfn.RR_rol.load_pro.value = 100.*loC1/frameC
			loC1+=1
			)
				)
			if ::r8dfn.STOPRM == false do(
				::r8dfn.RR_rol.load_pro2.value = 100.*loC2/(::r8dui.r8ui.ssList_lbx.selection as array).count
				loC2+=1
			)
					for i = 1 to OldNam.count do(
						OO = getnodebyname OldNam[i]
						if CR[1] == "V" then(
							setUserProp OO "VRay_Matte_Enable" false
							setUserProp OO "VRay_Matte_Alpha" 1
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)else(
							OO.material = OldMat[i]
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)
					)
					)--SS Loop
				)else(messagebox "请选择要渲染的分块！")
			)else( --No SS NoAction_GO
			loC1 = 1
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = (maxfilepath+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FFn=FF[FF.count]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then(
						saveDir = (saveDir+"\\"+maxName+"\\")
						makedir saveDir
					)
						if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
					for i = (startF+DFF) to (endF-DF) by ::r8dui.r8ui.FG_spn.value do(
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
						::r8dfn.TimeAdd()
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
				ESsaveDir = (saveDir+CDN)
				else
				ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
			CHAName = ""
		)
	)else( ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM = true)--Stop
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
				EsaveDir = (saveDir+CDN)
				else
				EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.E.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
			CHAName = ""
		)
	)else( EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
				ENsaveDir = (saveDir+CDN)
				else
				ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
				CHAName = ""
		)
	)else( ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
				NsaveDir = (saveDir+CDN)
				else
				NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.N.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
				CHAName = ""
		)
	)else( NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
				WNsaveDir = (saveDir+CDN)
				else
				WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
				CHAName = ""
		)
	)else( WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
				WsaveDir = (saveDir+CDN)
				else
				WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.W.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
				CHAName = ""
		)
	)else( WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
				WSsaveDir = (saveDir+CDN)
				else
				WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
				CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
				WSsaveDir = (saveDir+CDN)
				else
				WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.O.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
				CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
				SsaveDir = (saveDir+CDN)
				else
				SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (maxName+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.S.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (maxName+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
				CHAName = ""
		)
	)else( SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (maxName+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
									nI += 1
			if ::r8dfn.STOPRM == false do(
			::r8dfn.RR_rol.load_pro.value = 100.*loC1/frameC
			loC1+=1
			)
					)
			)
			if ::r8dfn.STOPRM then(
				rCount += 1
				insertitem ("  ！--- 用户中断渲染") rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "渲染已中断..."
		if ::r8dui.r8ui.jSeting.checked do (animationRange = interval OldFFram OldBFram)
			)else(
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
				::r8dfn.RR_rol.load_pro.color = (color 9 185 197)
				if ::r8dfn.RENDERMSG then(
					rCount += 1
					insertitem (" ! --- "+maxFileName+"... (渲染失败，检查渲染器或设置是否正确)") rItem rCount
					::r8dfn.RR_rol.Ring_lbx.items = rItem
					::r8dfn.RR_rol.Ring_lbx.selection = rCount
					::r8dfn.RR_rol.lbl1.text = "渲染操作已完毕，未成功！"
				)else(
					::r8dfn.RR_rol.lbl1.text = "所有帧已渲染完毕，请查收..."
				)
				rCount += 1
				insertitem "渲染进程完毕......" rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
		if ::r8dui.r8ui.jSeting.checked do (animationRange = interval OldFFram OldBFram)
				if ::r8dui.r8ui.autoOff.checked do (shellLaunch "shutdown.exe" " -s -t 120"
		if (queryBox "电脑将在2分钟后关机，是否要取消？" title:"R8D") do(shellLaunch "shutdown.exe" " -a") )
			)
			::r8dfn.RENDERMSG = false
				)
					--还原S像机的父级
					if RenderC.count == 8 then(
						$S.parent=SC_Parent
					)else(
						::r8dfn.RCCC=RenderC[1]
						if classof ::r8dfn.RCCC == Targetcamera then(
							execute ("select $"+(::r8dfn.RCCC.name as string)+"*")
							selection.parent = OldParent
						)else(
							::r8dfn.RCCC.parent = OldParent
						)
					)
					--LightRotate break
					if ::r8dui.r8ui.cSeting.checked do(
						if RenderL.count > 0 do(
							for l in RenderL do (
								l.parent = LightOldPar
								Tl=getnodebyname (l.name+".Target")
								if Tl != undefined do Tl.parent = LightOldPar
							)
						)
					)
		EndTime = timeStamp()
		if SetTimes then(
			useTime=((86400000-StarTime)+EndTime)/1000
		)else(
		useTime = (EndTime - StarTime)/1000
		)
				rCount += 1
				insertitem ("用时："+(::r8dfn.getTimeUse_fn useTime)) rItem rCount
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				)
				)else(messagebox "请先创建一个拍正前方的摄像机^^!" title:"R8D")
			)else(messagebox "请输入正确的渲染图输出目录!\n或者右键以管理员身份重新打开MAX重试。" title:"R8D")
		)
		return true
	),--RRRGO---End
	fn RRRDIR = (
		global HAVECCC=true
		if ::r8dui.r8ui.ES_btn.checked==false and ::r8dui.r8ui.E_btn.checked==false and ::r8dui.r8ui.EN_btn.checked==false and ::r8dui.r8ui.N_btn.checked==false and ::r8dui.r8ui.WN_btn.checked==false and ::r8dui.r8ui.W_btn.checked==false and ::r8dui.r8ui.WS_btn.checked==false and ::r8dui.r8ui.O_btn.checked==false and ::r8dui.r8ui.S_btn.checked==false then(
			messagebox "请激活要渲染的方向!" title:"R8D"
		)else(
		if (::r8dfn.isDirectoryExist ::r8dui.r8ui.renderDir_edt.text) then(
			if ::r8dui.r8ui.subdir_chk.checked then(
				::r8dfn.RmFiles = #()	--Info: RmFiles里包含文件夹(***)和文件(c:\text\text.max)	在 ::r8dfn.findSubDir_FN 函数执行完成后被赋值
				::r8dfn.findSubDir_FN ::r8dui.r8ui.renderDir_edt.text
				Sta = 0
				for o in ::r8dui.r8ui.lbx1.selection do(
					if ::r8dfn.RmFiles[o] == "***" then Sta += 1
				)
				if Sta == 0 then files = ::r8dfn.RmFiles else(
					messagebox "不要选中带[+]的文件夹！" title:"R8D"
					files = #()
				)
			)else(
				files = getFiles (::r8dui.r8ui.renderDir_edt.text+"\\*.max")
			)
			if files.count > 0 then(
			if (::r8dui.r8ui.lbx1.selection as array).count > 0 then(
			StarTime = timeStamp()
			local SetTimes = false
			AllT = 0 ; OneDo = true
			registerRedrawViewsCallback ::r8dfn.TimeAdd
				vfbp=(getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "VFBPOS")as integer
				try(rendSaveFile = false)catch()
				Sep = ::r8dui.r8ui.cut_edt.text
				if ::r8dui.r8ui.outDir_edt.text != "" or ::r8dui.r8ui.curDir_cbn.checked then(
			::r8dfn.UIx = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiX" as integer
			::r8dfn.UIy = getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "uiY" as integer
			if ::r8dfn.UIx < 390 then
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx+510,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			else
				createdialog ::r8dfn.RR_rol pos:[::r8dfn.UIx-400,::r8dfn.UIy] style: #(#style_sysmenu,#style_toolwindow)
			::r8dfn.RR_rol.lbl2.visible = true
				rCount = 0
				rItem = #()
				r8dinfoa = openFile ("$scripts\R8Dinfo.txt") mode:#w
				loC2=1
				::r8dfn.RR_rol.load_pro2.visible = true
				::r8dfn.RR_rol.rC_lbl.visible = true
				::r8dfn.RR_rol.fC_lbl.visible = true
				::r8dfn.RR_rol.fC_lbl.text = (::r8dui.r8ui.lbx1.selection as array).count as string
				::r8dfn.NORenderCSS = true
				for i in ::r8dui.r8ui.lbx1.selection do(
				if ::r8dfn.STOPRM == false do( --Files loop Stop
					if (loadMaxFile files[i] useFileUnits:true quiet:true) then (
		dummyObj = getnodebyname ::r8dui.r8ui.useDummyName.text
			if ::r8dui.r8ui.jSeting.checked do animationRange = interval animationRange.start (animationRange.start + 1)
				if ::r8dui.r8ui.iSeting.checked then(if ::r8dfn.SearchNa_fn (getfilenamefile files[i]) (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT") then DF=0 else DF=1)else DF=0
				if ::r8dui.r8ui.kSeting.checked then(if ::r8dfn.SearchNa_fn (getfilenamefile files[i]) (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "SEACHT") then DFF=0 else DFF=1)else DFF=0
					if $R8D_Dummy == undefined do dummy name:"R8D_Dummy" ishidden:true
				global SRView = ::r8dfn.ConvertToBool (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "SHOWRV")
			global BITRENDER = bitmap renderWidth renderHeight gamma:displayGamma --show render view
		if fileProperties.findProperty #contents "Headers" > 0 do(
			a = fileproperties.getPropertyValue #contents (fileProperties.findProperty #contents "Headers")
			b = fileProperties.getItems a[1]
			dd=filterstring b[b.count] ": "
			ddd=filterstring dd[dd.count] "."
			rCount += 1
			insertitem (maxFileName+" :  "+(::r8dfn.getVersion ddd[1])) rItem rCount
			format "\n%" (maxFileName+" :  "+(::r8dfn.getVersion ddd[1])) to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
					--激活渲染设置RS 1
							if ::r8dui.r8ui.useColorSet_chk.checked do(
							if (renderpresets.LoadAll 0 ::r8dui.r8ui.rps_txt.text) == false do(
								rCount += 1
								insertitem ("  !--- "+(maxFileName)+" 应用渲染预设失败！") rItem rCount
			format "\n%" ("  !--- "+(maxFileName)+" 应用渲染预设失败！") to:r8dinfoa
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
							)
						)
						Fname = getfilenamefile maxfilename
						if ::r8dui.r8ui.gamma_lbl.checked do GammaSet_fn()
					--全局参数设置------------
					if ::r8dui.r8ui.glob_chk.checked then(
							RenderR=(for o in objects where superclassof o == camera collect o)
							if RenderR.count > 0 do(	delete RenderR	)
							--Create Cameras----
							::r8dfn.createCCC false
		
		Spar=$S.parent
			Dummy name:"R8D_SVDCam" ishidden:true isselected:false
		$S.parent = $R8D_SVDCam
			CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
		if CamTag != undefined do CamTag.parent = $R8D_SVDCam
	rotate $R8D_SVDCam (angleaxis ::r8dui.r8ui.someDig.value [0,0,1])
			delete $R8D_SVDCam
			fileproperties.addProperty #custom "SetSomeDeger" ::r8dui.r8ui.someDig.value
			$S.parent=Spar
							)else(
							if ::r8dui.r8ui.getCusCam.text != "- None -" do(
								PICKCAM = (getnodebyname ::r8dui.r8ui.getCusCam.text)
								if PICKCAM != undefined then(
									PICKCAMTAG = getnodebyname (::r8dui.r8ui.getCusCam.text + ".Target")
									if PICKCAMTAG != undefined then(
									PICKCAM.pos = ::r8dui.CustemCam
									PICKCAMTAG.pos = ::r8dui.CustemCamTag
									PICKCAM.FOV = ::r8dui.CustemCamFOV
									PICKCAM.orthoProjection = ::r8dui.CustemCamOrt
								)else(
								try(delete PICKCAM)catch()
Targetcamera name:::r8dui.r8ui.getCusCam.text fov:::r8dui.CustemCamFOV orthoProjection:::r8dui.CustemCamOrt nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:::r8dui.CustemCam isSelected:off target:(Targetobject name:(::r8dui.r8ui.getCusCam.text + ".Target") transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] ::r8dui.CustemCamTag))
								)
								)else(
Targetcamera name:::r8dui.r8ui.getCusCam.text fov:::r8dui.CustemCamFOV orthoProjection:::r8dui.CustemCamOrt nearclip:1 farclip:1000 nearrange:0 farrange:1000 mpassEnabled:off mpassRenderPerPass:off pos:::r8dui.CustemCam isSelected:off target:(Targetobject name:(::r8dui.r8ui.getCusCam.text + ".Target") transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] ::r8dui.CustemCamTag))
								)
							)
							)
					--全局参数设置------------end
						if ::r8dui.r8ui.gloSize_chk.checked do(
							renderWidth = ::r8dui.r8ui.RW_spn.value
							renderHeight = ::r8dui.r8ui.RH_spn.value
						)--全局参数设置------------end
					try(renderers.production.output_on = false)catch()
					--HideBone
					if ::r8dui.r8ui.bSeting.checked then(
						for o in objects where classof o == Biped_Object or classof o == BoneGeometry do o.isHidden = true
					)else(
						for o in objects where classof o == Biped_Object or classof o == BoneGeometry do o.isHidden = false
					)
					--DoubleSide
					if ::r8dui.r8ui.aSeting.checked do(
						for o in objects where superclassof o == GeometryClass do
							try(o.material.twoSided = on)catch()
					)
					--LightRotate link
					if ::r8dui.r8ui.cSeting.checked do(
						RenderL=(for o in objects where superclassof o == light collect o)
						if RenderL.count > 0 do(
							for l in RenderL do (
								l.parent = $R8D_Dummy
								Tl=getnodebyname (l.name+".Target")
								if Tl != undefined do Tl.parent = $R8D_Dummy
							)
						)
					)
				RenderC=(for o in objects where superclassof o == camera collect o)	--获取像机
					--判断是否有动作记录
						aniNum = getinisetting (maxfilepath+Fname+"_AT.ini") "AniTimes" "itemsCount"
						if aniNum as integer > 0 then(
				if RenderC.count > 0 then(
					--指定前方像机
					if $AllCamera != undefined and $S != undefined then(
						::r8dfn.RCCC=$S
						::r8dfn.RCCC.parent = $R8D_Dummy
					)else(
						GetCuCam = getnodebyname ::r8dui.r8ui.getCusCam.text
						if GetCuCam == undefined then(
							::r8dfn.RCCC=RenderC[1]
							if classof ::r8dfn.RCCC == Targetcamera then(
								execute ("select $"+(::r8dfn.RCCC.name as string)+"*")
								$.parent = $R8D_Dummy
							)else(
								::r8dfn.RCCC.parent = $R8D_Dummy
							)
						)else(
						::r8dfn.SetDegerView 0
							::r8dfn.RCCC = GetCuCam
							GetCuCam.parent = $R8D_Dummy
							CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
							if CamTag != undefined do CamTag.parent = $R8D_Dummy
						)
					)
			rCount += 1
			insertitem ("   --- 有 "+(aniNum as string)+" 个动作") rItem rCount
			format "\n%" ("   --- 有 "+(aniNum as string)+" 个动作") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
---------------------------------------Have Action
if getNumNamedSelSets() > 0 and ::r8dui.r8ui.eSeting.checked then(
			rCount += 1
			insertitem ("   --- 包含 "+((getNumNamedSelSets()) as string)+" 个分块") rItem rCount
			format "\n%" ("   --- 包含 "+((getNumNamedSelSets()) as string)+" 个分块") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
	--隐藏未分块物体
	if ::r8dui.r8ui.hSeting.checked then ::r8dfn.HideUnSSobj "hide"
if ::r8dui.r8ui.getSS_chk.checked then(
	if (::r8dui.r8ui.ssList_lbx.selection as array).count > 0 then(
		for ss in (::r8dui.r8ui.ssList_lbx.selection as array) do(
			SSName = selectionSets[ss].name
	--自动遮罩	3
		AllSS=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSS oname.name
			)
		)
		os = getNamedSelSetItemCount ss
		ROName=#()
		OldNam=#()
		OldMat=#()
		Oldcount = 1
		for ii = 1 to os do(
			oname = getNamedSelSetItem ss ii
			ROName[ii] = oname.name
		)
		if ::r8dui.r8ui.fSeting.checked then(
			::r8dfn.ShowAllSSobj()
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				MMat = MatteShadow ()
				MMat.receiveshadows = off
				MMat.affectAlpha = off
			)
			if CR[1] == "mental" do(
				MMat=Matte_Shadow_Reflection__mi ()
				MMat.catch_shadows = off
				MMat.ao_on = off
			)
			for ro in ROName do(
			for ao in AllSS do(
				if ao == ro do(
					deleteitem AllSS (finditem AllSS ao)
				)
			))
			for o in AllSS do(
				oname=getnodebyname o
				if CR[1] == "V" then(
					setUserProp oname "VRay_Matte_Enable" true
					setUserProp oname "VRay_Matte_Alpha" -1
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					OldNam[Oldcount] = oname.name
				)else(
					OldNam[Oldcount] = oname.name
					OldMat[Oldcount] = oname.material
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					oname.material = MMat
				)
				Oldcount += 1
			)
		)else(
			::r8dfn.HideAllSSobj()
			for ii = 1 to os do(
				oname = getNamedSelSetItem ss ii
				oname.ishidden = false
			)
		)
	---------------------------------------
		if ::r8dfn.STOPRM == false do(
			rCount += 1
			insertitem ("   --- 正在渲染分块: "+SSName) rItem rCount
			format "\n%" ("   --- 正在渲染分块: "+SSName) to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)
			loC1=1
							for ani = 1 to (aniNum as integer)do(	--多动作循环
							if ::r8dfn.STOPRM == false do( --HaveAction Stop
								sTime = filterString (getinisetting (maxfilepath+Fname+"_AT.ini") "AniTimes" (ani as string)) "-()/"
								if sTime[2] != undefined do(
									if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.anF.checked then Anim_N=(sTime[1]+"\\") else Anim_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked then(
					sce=::r8dui.r8ui.scSpn.value
					aniC=::r8dui.r8ui.anSpn.value
					ss=::r8dui.r8ui.sSpn.value
						CDNnum = #(sce,aniC,ss)
						CDNnam = #(Scene_N,Anim_N,SS_N)
						for a in 1 to 3 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
			loC3=1
			::r8dfn.RR_rol.load_pro3.visible = true
			sTimeC=((sTime[3]as integer -DF)-(sTime[2]as integer))/::r8dui.r8ui.FG_spn.value
									for i = ((sTime[2]as integer)+DFF) to ((sTime[3]as integer)-DF) by ::r8dui.r8ui.FG_spn.value do(	--动画帧循环
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
	if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.ES.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.ES.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(ESsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.ES.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
		HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.E.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.E.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(EsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.E.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.EN.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.EN.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(ENsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.EN.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.N.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.N.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(NsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.N.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.WN.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WN.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WNsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WN.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.W.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.W.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.W.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.WS.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WS.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WSsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WS.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.O.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.O.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WSsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.O.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.S.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.S.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(SsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.S.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
	)
					nI += 1
					if ::r8dfn.STOPRM == false do(
					::r8dfn.RR_rol.load_pro3.value = 100.*loC3/sTimeC
					loC3+=1
					)
									)
								)
		if ::r8dfn.STOPRM == false do(
			if ::r8dfn.RENDERMSG == false do(
				rCount += 1
				insertitem ("   --- "+(ani as string)+".("+sTime[1]+")...完成") rItem rCount
			format "\n%" ("   --- "+(ani as string)+".("+sTime[1]+")...完成") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
			::r8dfn.RR_rol.load_pro.value = 100.*loC1/(aniNum as integer)
			loC1+=1
		)
						::r8dfn.TimeAdd()
							) --HaveAction Stop
							) --多动作循环 SS
					for i = 1 to OldNam.count do(
						OO = getnodebyname OldNam[i]
						if CR[1] == "V" then(
							setUserProp OO "VRay_Matte_Enable" false
							setUserProp OO "VRay_Matte_Alpha" 1
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)else(
							OO.material = OldMat[i]
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)
					)
						) --SS loop HaveAction
	)else(
			rCount += 1
			insertitem ("   --- "+maxFileName+" 未挑选分块") rItem rCount
			format "\n%" ("   --- "+maxFileName+" 未挑选分块") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			::r8dfn.NORenderCSS = false
	)
)else(
	for ss in 1 to getNumNamedSelSets() do(
		SSName = selectionSets[ss].name
	--自动遮罩	4
		AllSS=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSS oname.name
			)
		)
		os = getNamedSelSetItemCount ss
		ROName=#()
		OldNam=#()
		OldMat=#()
		Oldcount = 1
		for ii = 1 to os do(
			oname = getNamedSelSetItem ss ii
			ROName[ii] = oname.name
		)
		if ::r8dui.r8ui.fSeting.checked then(
			::r8dfn.ShowAllSSobj()
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				MMat = MatteShadow ()
				MMat.receiveshadows = off
				MMat.affectAlpha = off
			)
			if CR[1] == "mental" do(
				MMat=Matte_Shadow_Reflection__mi ()
				MMat.catch_shadows = off
				MMat.ao_on = off
			)
			for ro in ROName do(
			for ao in AllSS do(
				if ao == ro do(
					deleteitem AllSS (finditem AllSS ao)
				)
			))
			for o in AllSS do(
				oname=getnodebyname o
				if CR[1] == "V" then(
					setUserProp oname "VRay_Matte_Enable" true
					setUserProp oname "VRay_Matte_Alpha" -1
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					OldNam[Oldcount] = oname.name
				)else(
					OldNam[Oldcount] = oname.name
					OldMat[Oldcount] = oname.material
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					oname.material = MMat
				)
				Oldcount += 1
			)
		)else(
			::r8dfn.HideAllSSobj()
			for ii = 1 to os do(
				oname = getNamedSelSetItem ss ii
				oname.ishidden = false
			)
		)
---------------------------------------
		if ::r8dfn.STOPRM == false do(
			rCount += 1
			insertitem ("   --- 正在渲染分块: "+SSName) rItem rCount
			format "\n%" ("   --- 正在渲染分块: "+SSName) to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)
			loC1=1
							for ani = 1 to (aniNum as integer)do(	--多动作循环
							if ::r8dfn.STOPRM == false do( --HaveAction Stop
								sTime = filterString (getinisetting (maxfilepath+Fname+"_AT.ini") "AniTimes" (ani as string)) "-()/"
								if sTime[2] != undefined do(
									if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.anF.checked then Anim_N=(sTime[1]+"\\") else Anim_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked then(
					sce=::r8dui.r8ui.scSpn.value
					aniC=::r8dui.r8ui.anSpn.value
					ss=::r8dui.r8ui.sSpn.value
						CDNnum = #(sce,aniC,ss)
						CDNnam = #(Scene_N,Anim_N,SS_N)
						for a in 1 to 3 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
			loC3=1
			::r8dfn.RR_rol.load_pro3.visible = true
			sTimeC=((sTime[3]as integer -DF)-(sTime[2]as integer))/::r8dui.r8ui.FG_spn.value
									for i = ((sTime[2]as integer)+DFF) to ((sTime[3]as integer)-DF) by ::r8dui.r8ui.FG_spn.value do(	--动画帧循环
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
	if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.ES.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.ES.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(ESsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.ES.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
		HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.E.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.E.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(EsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.E.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.EN.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.EN.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(ENsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.EN.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.N.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.N.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(NsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.N.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.WN.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WN.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WNsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WN.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.W.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.W.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.W.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.WS.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WS.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WSsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WS.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.O.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.O.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(WSsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.O.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
							MFName = (Fname+Sep)
					)else
						MFName = ""
					if ::r8dui.r8ui.useAct_chk.checked then
						ACTName = (sTime[1]+Sep)
					else
						ACTName = ""
					if ::r8dui.r8ui.useDir_chk.checked then
						DIRName = (::r8dui.r8ui.S.text+Sep)
					else
						DIRName = ""
					if ::r8dui.r8ui.useSSN_chk.checked then
						SSSName = (SSName+Sep)
					else
						SSSName = ""
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.S.text+Sep)
					SSSName = (SSName+Sep)
				)
			)else(SsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.S.text+Sep)
				SSSName = (SSName+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+(InOrder #(MFName,ACTName,SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
	)
					nI += 1
					if ::r8dfn.STOPRM == false do(
					::r8dfn.RR_rol.load_pro3.value = 100.*loC3/sTimeC
					loC3+=1
					)
									)
								)
		if ::r8dfn.STOPRM == false do(
			if ::r8dfn.RENDERMSG == false do(
				rCount += 1
				insertitem ("   --- "+(ani as string)+".("+sTime[1]+")...完成") rItem rCount
			format "\n%" ("   --- "+(ani as string)+".("+sTime[1]+")...完成") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
			::r8dfn.RR_rol.load_pro.value = 100.*loC1/(aniNum as integer)
			loC1+=1
		)
						::r8dfn.TimeAdd()
							) --HaveAction Stop
							) --多动作循环 SS
					for i = 1 to OldNam.count do(
						OO = getnodebyname OldNam[i]
						if CR[1] == "V" then(
							setUserProp OO "VRay_Matte_Enable" false
							setUserProp OO "VRay_Matte_Alpha" 1
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)else(
							OO.material = OldMat[i]
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)
					)
						) --SS loop HaveAction
					)--不挑块
					)else( --No SS HaveAction
					loC1 = 1
							for ani = 1 to (aniNum as integer)do(	--多动作循环
							if ::r8dfn.STOPRM == false do( --HaveAction Stop
								sTime = filterString (getinisetting (maxfilepath+Fname+"_AT.ini") "AniTimes" (ani as string)) "-()/"
								if sTime[2] != undefined do(
									if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					--激活F按钮时运用文件夹归档
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.anF.checked then Anim_N=(sTime[1]+"\\") else Anim_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					aniC=::r8dui.r8ui.anSpn.value
					if sce < aniC then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,Anim_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
			loC3=1
			::r8dfn.RR_rol.load_pro3.visible = true
			sTimeC=((sTime[3]as integer -DF)-(sTime[2]as integer))/::r8dui.r8ui.FG_spn.value
									for i = ((sTime[2]as integer)+DFF) to ((sTime[3]as integer)-DF) by ::r8dui.r8ui.FG_spn.value do(	--动画帧循环
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
	if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.ES.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.ES.text+Sep)
				)
			)else(ESsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.ES.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ESsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
		HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.E.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.E.text+Sep)
				)
			)else(EsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.E.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(EsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.EN.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.EN.text+Sep)
				)
			)else(ENsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.EN.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(ENsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.N.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.N.text+Sep)
				)
			)else(NsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.N.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(NsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.WN.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WN.text+Sep)
				)
			)else(WNsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WN.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WNsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.W.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.W.text+Sep)
				)
			)else(WsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.W.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.WS.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.WS.text+Sep)
				)
			)else(WSsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.WS.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.O.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.O.text+Sep)
				)
			)else(WSsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.O.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(WSsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
		rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
	)
	if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
				if ::r8dui.r8ui.bitCount.checked then(
					if ::r8dui.r8ui.useSce_chk.checked then(
						
						MFName = (Fname+Sep)
					)else(
						MFName = ""
					)
					if ::r8dui.r8ui.useAct_chk.checked then(
						ACTName = (sTime[1]+Sep)
					)else(
						ACTName = ""
					)
					if ::r8dui.r8ui.useDir_chk.checked then(
						DIRName = (::r8dui.r8ui.S.text+Sep)
					)else(
						DIRName = ""
					)
				)else(
					MFName = (Fname+Sep)
					ACTName = (sTime[1]+Sep)
					DIRName = (::r8dui.r8ui.S.text+Sep)
				)
			)else(SsaveDir = saveDir
				MFName = (Fname+Sep)
				ACTName = (sTime[1]+Sep)
				DIRName = (::r8dui.r8ui.S.text+Sep)
		)
	if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(	try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb: SRView outputfile:(SsaveDir+"\\"+(InOrder #(MFName,ACTName,"",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
	HAVECCC = false)
	)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
	)
					nI += 1
					if ::r8dfn.STOPRM == false do(
					::r8dfn.RR_rol.load_pro3.value = 100.*loC3/sTimeC
					loC3+=1
					)
									)
								)
		if ::r8dfn.STOPRM == false do(
			if ::r8dfn.RENDERMSG == false do(
				rCount += 1
				insertitem ("   --- "+(ani as string)+".("+sTime[1]+")...完成") rItem rCount
			format "\n%" ("   --- "+(ani as string)+".("+sTime[1]+")...完成") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
			::r8dfn.RR_rol.load_pro.value = 100.*loC1/(aniNum as integer)
			loC1+=1
		)
						::r8dfn.TimeAdd()
							) --HaveAction Stop
							) --多动作循环 No SS
					)
			if ::r8dfn.RENDERMSG and ::r8dfn.STOPRM == false then(
				rCount += 1
				::r8dfn.RDirMsgCount+=1
				insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+"... (渲染失败，检查渲染器或设置是否正确)") rItem rCount
			format "\n%" (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+"... (渲染失败，检查渲染器或设置是否正确)") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)else(
				if ::r8dfn.STOPRM == false and ::r8dfn.NORenderCSS do(
				rCount += 1
				insertitem ("   OK-- "+maxFileName+"...渲染成功") rItem rCount
			format "\n%" ("   OK-- "+maxFileName+"...渲染成功") to:r8dinfoa
				useTime = (timeStamp() - StarTime)/1000
				rCount += 1
				insertitem ("已用时间："+(::r8dfn.getTimeUse_fn useTime)) rItem rCount
			format "\n%" ("已用时间："+(::r8dfn.getTimeUse_fn useTime)) to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			if ::r8dui.r8ui.overSave_chk.checked do
			if (saveMaxFile (maxfilepath+maxfilename) quiet:true) do(
			rCount += 1
			insertitem ("   ...... "+maxFileName+"...场景保存成功") rItem rCount
			format "\n%" ("   ...... "+maxFileName+"...场景保存成功") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
				)
			)
			::r8dfn.RENDERMSG = false
							)else(
			if ::r8dfn.STOPRM == false do(
				rCount += 1
				::r8dfn.RDirMsgCount+=1
				insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+" (没有创建摄像机)") rItem rCount
			format "\n%" (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+" (没有创建摄像机)") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
			HAVECCC = false
							)
			/*有时间记录*/	)else(  --没有时间记录渲染
				if ::r8dfn.STOPRM == false do( --MulteFile NoAction Stop
				if RenderC.count > 0 then(
					--指定前方像机
					if $AllCamera != undefined and $S != undefined then(
						::r8dfn.RCCC=$S
						::r8dfn.RCCC.parent = $R8D_Dummy
					)else(
						GetCuCam = getnodebyname ::r8dui.r8ui.getCusCam.text
						if GetCuCam == undefined then(
							::r8dfn.RCCC=RenderC[1]
							if classof ::r8dfn.RCCC == Targetcamera then(
								execute ("select $"+(::r8dfn.RCCC.name as string)+"*")
								$.parent = $R8D_Dummy
							)else(
								::r8dfn.RCCC.parent = $R8D_Dummy
							)
						)else(
						::r8dfn.SetDegerView 0
							::r8dfn.RCCC = GetCuCam
							GetCuCam.parent = $R8D_Dummy
							CamTag = getnodebyname (::r8dui.r8ui.getCusCam.text+".Target")
							if CamTag != undefined do CamTag.parent = $R8D_Dummy
						)
					)
---------------------------------------No Action
if getNumNamedSelSets() > 0 and ::r8dui.r8ui.eSeting.checked then(
			rCount += 1
			insertitem ("   --- 包含 "+((getNumNamedSelSets()) as string)+" 个分块") rItem rCount
			format "\n%" ("   --- 包含 "+((getNumNamedSelSets()) as string)+" 个分块") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
	loC3=1
	::r8dfn.RR_rol.load_pro.value=0
	--隐藏未分块物体
	if ::r8dui.r8ui.hSeting.checked then ::r8dfn.HideUnSSobj "hide"
if ::r8dui.r8ui.getSS_chk.checked then(
	if (::r8dui.r8ui.ssList_lbx.selection as array).count > 0 then(
		for ss in (::r8dui.r8ui.ssList_lbx.selection as array) do(
			SSName = selectionSets[ss].name
	--自动遮罩	5
		AllSS=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSS oname.name
			)
		)
		os = getNamedSelSetItemCount ss
		ROName=#()
		OldNam=#()
		OldMat=#()
		Oldcount = 1
		for ii = 1 to os do(
			oname = getNamedSelSetItem ss ii
			ROName[ii] = oname.name
		)
		if ::r8dui.r8ui.fSeting.checked then(
			::r8dfn.ShowAllSSobj()
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				MMat = MatteShadow ()
				MMat.receiveshadows = off
				MMat.affectAlpha = off
			)
			if CR[1] == "mental" do(
				MMat=Matte_Shadow_Reflection__mi ()
				MMat.catch_shadows = off
				MMat.ao_on = off
			)
			for ro in ROName do(
			for ao in AllSS do(
				if ao == ro do(
					deleteitem AllSS (finditem AllSS ao)
				)
			))
			for o in AllSS do(
				oname=getnodebyname o
				if CR[1] == "V" then(
					setUserProp oname "VRay_Matte_Enable" true
					setUserProp oname "VRay_Matte_Alpha" -1
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					OldNam[Oldcount] = oname.name
				)else(
					OldNam[Oldcount] = oname.name
					OldMat[Oldcount] = oname.material
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					oname.material = MMat
				)
				Oldcount += 1
			)
		)else(
			::r8dfn.HideAllSSobj()
			for ii = 1 to os do(
				oname = getNamedSelSetItem ss ii
				oname.ishidden = false
			)
		)
---------------------------------------
		if ::r8dfn.STOPRM == false do(
			rCount += 1
			insertitem ("   --- 正在渲染分块: "+SSName) rItem rCount
			format "\n%" ("   --- 正在渲染分块: "+SSName) to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)
								startF = animationRange.start
								endF = animationRange.end
								loC1=1
			::r8dfn.RR_rol.load_pro3.visible = false
				-- if $OOXChoseKeys_D != undefined then(
				if ::r8dui.r8ui.skSeting.checked then(
	ChoseKeys=#()
	aSK=""
	if ::r8dui.r8ui.rself_chk.checked then(
	aSK=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK"
	)else(
	for i in 1 to rendPickupFrames.count do aSK=aSK+(rendPickupFrames[i] as string)
	)
	aggagja=filterString aSK ","
	for a in aggagja do(
		if (findstring a "-")==undefined then
		append ChoseKeys (a as integer)
		else(
		fsgk=filterString a "-"
		for i in (fsgk[1] as integer) to (fsgk[2] as integer) do
			append ChoseKeys i
		)
	)
			rCount += 1
			insertitem ("   --- 挑帧渲染") rItem rCount
			format "\n%" ("   --- 挑帧渲染") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
								sTimeC=ChoseKeys.count
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked then(
					sce=::r8dui.r8ui.scSpn.value
					ss=::r8dui.r8ui.sSpn.value
					if sce < ss then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,SS_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
								if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
								for i in ChoseKeys do(	--挑帧帧循环
								if ::r8dfn.STOPRM == false do( --NoAction Stop
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
		SSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.E.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
		SSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
		SSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.N.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.W.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.O.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.S.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
									nI += 1
					::r8dfn.RR_rol.load_pro.value = 100.*loC1/sTimeC
					loC1+=1
						::r8dfn.TimeAdd()
					) --NoAction Stop
								) --挑帧帧循环 SS
	/*有挑帧*/	)else(--无挑帧
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					ss=::r8dui.r8ui.sSpn.value
					if sce < ss then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,SS_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
								sTimeC=(endF-DF-startF+1)/::r8dui.r8ui.FG_spn.value
					::r8dfn.RR_rol.load_pro3.visible = true
					loCF=1
						if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
								for i = (startF+DFF) to (endF-DF) by ::r8dui.r8ui.FG_spn.value do(	--帧循环
								if ::r8dfn.STOPRM == false do( --NoAction Stop
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.E.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.N.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.W.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.O.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.S.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
					nI += 1
					::r8dfn.RR_rol.load_pro3.value = 100.*loCF/sTimeC
					loCF+=1
					) --NoAction Stop
								) --无动作帧循环 SS
				) --无挑帧
			if ::r8dfn.STOPRM == false then(
				::r8dfn.RR_rol.load_pro.value = 100.*loC3/(::r8dui.r8ui.ssList_lbx.selection as array).count
				loC3+=1
			)
					for i = 1 to OldNam.count do(
						OO = getnodebyname OldNam[i]
						if CR[1] == "V" then(
							setUserProp OO "VRay_Matte_Enable" false
							setUserProp OO "VRay_Matte_Alpha" 1
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)else(
							OO.material = OldMat[i]
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)
					)
		)--select SS loop
	)else(
			rCount += 1
			insertitem ("   --- "+maxFileName+" 未挑选分块") rItem rCount
			format "\n%" ("   --- "+maxFileName+" 未挑选分块") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			::r8dfn.NORenderCSS = false
	)
	)else(
	for ss in 1 to getNumNamedSelSets() do(
		SSName = selectionSets[ss].name
	--自动遮罩	6
		AllSS=#()
		for i = 1 to selectionSets.count do(
			os = getNamedSelSetItemCount i
			for ii = 1 to os do(
				oname = getNamedSelSetItem i ii
				append AllSS oname.name
			)
		)
		os = getNamedSelSetItemCount ss
		ROName=#()
		OldNam=#()
		OldMat=#()
		Oldcount = 1
		for ii = 1 to os do(
			oname = getNamedSelSetItem ss ii
			ROName[ii] = oname.name
		)
		if ::r8dui.r8ui.fSeting.checked then(
			::r8dfn.ShowAllSSobj()
			CR = filterstring ((renderers.current) as string) "_"
			if CR[1] == "Default" do(
				MMat = MatteShadow ()
				MMat.receiveshadows = off
				MMat.affectAlpha = off
			)
			if CR[1] == "mental" do(
				MMat=Matte_Shadow_Reflection__mi ()
				MMat.catch_shadows = off
				MMat.ao_on = off
			)
			for ro in ROName do(
			for ao in AllSS do(
				if ao == ro do(
					deleteitem AllSS (finditem AllSS ao)
				)
			))
			for o in AllSS do(
				oname=getnodebyname o
				if CR[1] == "V" then(
					setUserProp oname "VRay_Matte_Enable" true
					setUserProp oname "VRay_Matte_Alpha" -1
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					OldNam[Oldcount] = oname.name
				)else(
					OldNam[Oldcount] = oname.name
					OldMat[Oldcount] = oname.material
					if ::r8dui.r8ui.gSeting.checked then
						oname.castShadows = on
					else
						oname.castShadows = off
					oname.material = MMat
				)
				Oldcount += 1
			)
		)else(
			::r8dfn.HideAllSSobj()
			for ii = 1 to os do(
				oname = getNamedSelSetItem ss ii
				oname.ishidden = false
			)
		)
---------------------------------------
		if ::r8dfn.STOPRM == false do(
			rCount += 1
			insertitem ("   --- 正在渲染分块: "+SSName) rItem rCount
			format "\n%" ("   --- 正在渲染分块: "+SSName) to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)
								if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
								startF = animationRange.start
								endF = animationRange.end
								loC1=1
			::r8dfn.RR_rol.load_pro3.visible = false
				-- if $OOXChoseKeys_D != undefined then(
				if ::r8dui.r8ui.skSeting.checked then(
		ChoseKeys=#()
	aSK=""
	if ::r8dui.r8ui.rself_chk.checked then(
	aSK=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK"
	)else(
	for i in 1 to rendPickupFrames.count do aSK=aSK+(rendPickupFrames[i] as string)
	)
	aggagja=filterString aSK ","
	for a in aggagja do(
		if (findstring a "-")==undefined then
		append ChoseKeys (a as integer)
		else(
		fsgk=filterString a "-"
		for i in (fsgk[1] as integer) to (fsgk[2] as integer) do
			append ChoseKeys i
		)
	)
			rCount += 1
			insertitem ("   --- 挑帧渲染") rItem rCount
			format "\n%" ("   --- 挑帧渲染") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
								sTimeC=ChoseKeys.count
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					ss=::r8dui.r8ui.sSpn.value
					if sce < ss then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,SS_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
								for i in ChoseKeys do(	--挑帧帧循环
								if ::r8dfn.STOPRM == false do( --NoAction Stop
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
		SSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.E.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
		SSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
		SSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.N.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.W.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.O.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.S.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
									nI += 1
					::r8dfn.RR_rol.load_pro.value = 100.*loC1/sTimeC
					loC1+=1
						::r8dfn.TimeAdd()
					) --NoAction Stop
								) --挑帧帧循环 SS
	/*有挑帧*/	)else(--无挑帧
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then Scene_N=(Fname+"\\") else Scene_N=""
					if ::r8dui.r8ui.sF.checked then SS_N=(SSName+"\\") else SS_N=""
					if ::r8dui.r8ui.ccF.checked do(
					sce=::r8dui.r8ui.scSpn.value
					ss=::r8dui.r8ui.sSpn.value
					if sce < ss then CDNnum = #(1,2) else CDNnum = #(2,1)
						CDNnam = #(Scene_N,SS_N)
						for a in 1 to 2 do(
							ac = finditem CDNnum a
							saveDir = saveDir + CDNnam[ac]
						)
						makedir saveDir all:true
					)
								sTimeC=(endF-DF-startF+1)/::r8dui.r8ui.FG_spn.value
								loCF=1
					::r8dfn.RR_rol.load_pro3.visible = true
						if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
								for i = (startF+DFF) to (endF-DF) by ::r8dui.r8ui.FG_spn.value do(	--帧循环
								if ::r8dfn.STOPRM == false do( --NoAction Stop
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
					ESsaveDir = (saveDir+CDN)
				else
					ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
					EsaveDir = (saveDir+CDN)
				else
					EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.E.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
					ENsaveDir = (saveDir+CDN)
				else
					ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
					NsaveDir = (saveDir+CDN)
				else
					NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.N.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
					WNsaveDir = (saveDir+CDN)
				else
					WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
					WsaveDir = (saveDir+CDN)
				else
					WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.W.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
					WSsaveDir = (saveDir+CDN)
				else
					WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.O.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
					SsaveDir = (saveDir+CDN)
				else
					SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else
				MFName = ""
			if ::r8dui.r8ui.useDir_chk.checked then
				DIRName = (::r8dui.r8ui.S.text+Sep)
			else
				DIRName = ""
			if ::r8dui.r8ui.useSSN_chk.checked then
				SSSName = (SSName+Sep)
			else
				SSSName = ""
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
			SSSName = (SSName+Sep)
				CHAName = ""
		)
	)else(SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
		SSSName = (SSName+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"",SSSName,DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
					nI += 1
					
					::r8dfn.RR_rol.load_pro3.value = 100.*loCF/sTimeC
					loCF+=1
					) --NoAction Stop
								) --无动作帧循环 SS
				) --无挑帧
			if ::r8dfn.STOPRM == false then(
				::r8dfn.RR_rol.load_pro.value = 100.*loC3/getNumNamedSelSets()
				loC3+=1
			)
					for i = 1 to OldNam.count do(
						OO = getnodebyname OldNam[i]
						if CR[1] == "V" then(
							setUserProp OO "VRay_Matte_Enable" false
							setUserProp OO "VRay_Matte_Alpha" 1
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)else(
							OO.material = OldMat[i]
					if ::r8dui.r8ui.gSeting.checked == false then
							OO.castShadows = on
						)
					)
							) --SS Loop
						)--不挑块
						)else( --on SS
								if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
								startF = animationRange.start
								endF = animationRange.end
								loC1=1
			::r8dfn.RR_rol.load_pro3.visible = false
				-- if $OOXChoseKeys_D != undefined then(
				if ::r8dui.r8ui.skSeting.checked then(
	ChoseKeys=#()
	aSK=""
	if ::r8dui.r8ui.rself_chk.checked then(
	aSK=getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8" "CUSTSK"
	)else(
	for i in 1 to rendPickupFrames.count do aSK=aSK+(rendPickupFrames[i] as string)
	)
	aggagja=filterString aSK ","
	for a in aggagja do(
		if (findstring a "-")==undefined then
		append ChoseKeys (a as integer)
		else(
		fsgk=filterString a "-"
		for i in (fsgk[1] as integer) to (fsgk[2] as integer) do
			append ChoseKeys i
		)
	)
				rCount += 1
				insertitem ("   --- 挑帧渲染") rItem rCount
			format "\n%" ("   --- 挑帧渲染") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
									sTimeC=ChoseKeys.count
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then(
						saveDir = (saveDir+"\\"+Fname+"\\")
						makedir saveDir
					)
									for i in ChoseKeys do(	--挑帧帧循环
								if ::r8dfn.STOPRM == false do( --NoAction Stop
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
				ESsaveDir = (saveDir+CDN)
				else
				ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
				CHAName = ""
		)
	)else( ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
				EsaveDir = (saveDir+CDN)
				else
				EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.E.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
				CHAName = ""
		)
	)else( EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
				ENsaveDir = (saveDir+CDN)
				else
				ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
				CHAName = ""
		)
	)else( ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
				NsaveDir = (saveDir+CDN)
				else
				NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.N.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
				CHAName = ""
		)
	)else( NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
				WNsaveDir = (saveDir+CDN)
				else
				WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
				CHAName = ""
		)
	)else( WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
				WsaveDir = (saveDir+CDN)
				else
				WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.W.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
				CHAName = ""
		)
	)else( WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
				WSsaveDir = (saveDir+CDN)
				else
				WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
				CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
				WSsaveDir = (saveDir+CDN)
				else
				WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.O.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
				CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
				SsaveDir = (saveDir+CDN)
				else
				SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.S.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
				CHAName = ""
		)
	)else( SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
									nI += 1
					::r8dfn.RR_rol.load_pro.value = 100.*loC1/sTimeC
					loC1+=1
						::r8dfn.TimeAdd()
					) --NoAction Stop
								)
				)else(--无挑帧
				if ::r8dui.r8ui.curDir_cbn.checked then saveDir = ((getfilenamepath files[i])+::r8dui.r8ui.curDir_edt.text+"\\") else
				saveDir = (::r8dui.r8ui.outDir_edt.text+"\\")
					if ::r8dui.r8ui.fff.checked then(
						FF=filterstring files[i] "\\"
						FFn=FF[FF.count-1]
						testF=findstring FFn ":"
						if testF == undefined do(
							saveDir = saveDir + FFn + "\\"
							makedir saveDir
						)
					)
					if ::r8dui.r8ui.scF.checked then(
						saveDir = (saveDir+"\\"+Fname+"\\")
						makedir saveDir
					)
								sTimeC=(endF-DF-startF+1)/::r8dui.r8ui.FG_spn.value
						if ::r8dui.r8ui.zero_cbt.checked then nI = 0 else nI = 1
								for i = (startF+DFF) to (endF-DF) by ::r8dui.r8ui.FG_spn.value do(	--帧循环
								if ::r8dfn.STOPRM == false do( --NoAction Stop
							if ::r8dui.r8ui.bit_spn.value > 1 then(
								if (nI as string).count < ::r8dui.r8ui.bit_spn.value then(
									bitIn = ""
									for bi in 1 to (::r8dui.r8ui.bit_spn.value - (nI as string).count) do(
										bitIn = bitIn+"0"
									)
									bitIn = bitIn+(nI as string)
								)else
									bitIn = (nI as string)
							)else(
								bitIn = (nI as string)
							)
						if (::r8dfn.TimeAdjust StarTime) do SetTimes = true
if ::r8dui.r8ui.ES_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.ES_CDN.text
				if CDN!="" then
				ESsaveDir = (saveDir+CDN)
				else
				ESsaveDir = (saveDir+"ES")
				makedir ESsaveDir
			)else ESsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.ES.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.ES.text+Sep)
				CHAName = ""
		)
	)else(ESsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.ES.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ESsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_ES_spn.value) [0,0,1])
)
if ::r8dui.r8ui.E_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.E_CDN.text
				if CDN!="" then
				EsaveDir = (saveDir+CDN)
				else
				EsaveDir = (saveDir+"E")
				makedir EsaveDir
			)else EsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.E.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.E.text+Sep)
				CHAName = ""
		)
	)else( EsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.E.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(EsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_E_spn.value) [0,0,1])
)
if ::r8dui.r8ui.EN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.EN_CDN.text
				if CDN!="" then
				ENsaveDir = (saveDir+CDN)
				else
				ENsaveDir = (saveDir+"EN")
				makedir ENsaveDir
			)else ENsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.EN.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.EN.text+Sep)
				CHAName = ""
		)
	)else( ENsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.EN.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(ENsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_EN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.N_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.N_CDN.text
				if CDN!="" then
				NsaveDir = (saveDir+CDN)
				else
				NsaveDir = (saveDir+"N")
				makedir NsaveDir
			)else NsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.N.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.N.text+Sep)
				CHAName = ""
		)
	)else( NsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.N.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(NsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_N_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WN_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WN_CDN.text
				if CDN!="" then
				WNsaveDir = (saveDir+CDN)
				else
				WNsaveDir = (saveDir+"WN")
				makedir WNsaveDir
			)else WNsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.WN.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WN.text+Sep)
				CHAName = ""
		)
	)else( WNsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WN.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WNsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WN_spn.value) [0,0,1])
)
if ::r8dui.r8ui.W_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.W_CDN.text
				if CDN!="" then
				WsaveDir = (saveDir+CDN)
				else
				WsaveDir = (saveDir+"W")
				makedir WsaveDir
			)else WsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.W.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.W.text+Sep)
				CHAName = ""
		)
	)else( WsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.W.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_W_spn.value) [0,0,1])
)
if ::r8dui.r8ui.WS_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.WS_CDN.text
				if CDN!="" then
				WSsaveDir = (saveDir+CDN)
				else
				WSsaveDir = (saveDir+"WS")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.WS.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.WS.text+Sep)
				CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.WS.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_WS_spn.value) [0,0,1])
)
if ::r8dui.r8ui.O_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.O_CDN.text
				if CDN!="" then
				WSsaveDir = (saveDir+CDN)
				else
				WSsaveDir = (saveDir+"O")
				makedir WSsaveDir
			)else WSsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.O.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.O.text+Sep)
				CHAName = ""
		)
	)else( WSsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.O.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(WSsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
		else
	rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_O_spn.value) [0,0,1])
)
if ::r8dui.r8ui.S_btn.checked do(
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
			if ::r8dui.r8ui.ccF.checked then(
			if ::r8dui.r8ui.diF.checked then(
			CDN = ::r8dui.r8ui.S_CDN.text
				if CDN!="" then
				SsaveDir = (saveDir+CDN)
				else
				SsaveDir = (saveDir+"S")
				makedir SsaveDir
			)else SsaveDir = saveDir
		if ::r8dui.r8ui.bitCount.checked then(
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
			if ::r8dui.r8ui.useSce_chk.checked then(
				MFName = (Fname+Sep)
			)else(
				MFName = ""
			)
			if ::r8dui.r8ui.useDir_chk.checked then(
				DIRName = (::r8dui.r8ui.S.text+Sep)
			)else(
				DIRName = ""
			)
		)else(
			MFName = (Fname+Sep)
			DIRName = (::r8dui.r8ui.S.text+Sep)
				CHAName = ""
		)
	)else( SsaveDir = saveDir
			if ::r8dui.r8ui.useCha_chk.checked then(
				if ::r8dui.r8ui.useCha_edt.text != "" then
					CHAName = (::r8dui.r8ui.useCha_edt.text+Sep)
				else CHAName = ""
			)else(CHAName = "")
		MFName = (Fname+Sep)
		DIRName = (::r8dui.r8ui.S.text+Sep)
	)
if keyboard.altPressed == false and ::r8dfn.STOPRM == false then(try( render camera:::r8dfn.RCCC outputwidth:renderWidth outputheight:renderHeight vfb:SRView outputfile:(SsaveDir+"\\"+CHAName+(InOrder #(MFName,"","",DIRName))+bitIn+::r8dui.r8ui.fileType_ddl.items[::r8dui.r8ui.fileType_ddl.selection]) frame:i pos:(::r8dStart.vfbPos[vfbp]) to:BITRENDER
)catch(
 ::r8dfn.RENDERMSG = true
HAVECCC = false)
)else(::r8dfn.STOPRM=true)
		if dummyObj != undefined and ::r8dui.r8ui.useDummyRot_btn.checked then
			rotate dummyObj (angleaxis (::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
		else
			rotate $R8D_Dummy (angleaxis (-::r8dui.r8ui.Deg_S_spn.value) [0,0,1])
)
									nI += 1
					::r8dfn.RR_rol.load_pro.value = 100.*loC1/sTimeC
					loC1+=1
						::r8dfn.TimeAdd()
					) --NoAction Stop
								)
				)
								
						) --No SS End
	if ::r8dfn.RENDERMSG and ::r8dfn.STOPRM == false then(
			rCount += 1
			::r8dfn.RDirMsgCount+=1
			insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+"... (渲染失败，检查渲染器或设置是否正确)") rItem rCount
			format "\n%" (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+"... (渲染失败，检查渲染器或设置是否正确)") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
		)else(
			if ::r8dfn.STOPRM == false and ::r8dfn.NORenderCSS do(
			rCount += 1
						::r8dfn.TimeAdd()
			insertitem ("   OK-- "+maxFileName+"...渲染成功") rItem rCount
			format "\n%" ("   OK-- "+maxFileName+"...渲染成功") to:r8dinfoa
				useTime = (timeStamp() - StarTime)/1000
				rCount += 1
				insertitem ("已用时间："+(::r8dfn.getTimeUse_fn useTime)) rItem rCount
			format "\n%" ("已用时间："+(::r8dfn.getTimeUse_fn useTime)) to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			if ::r8dui.r8ui.overSave_chk.checked do
			if (saveMaxFile (maxfilepath+maxfilename) quiet:true) do(
			rCount += 1
			insertitem ("   ...... "+maxFileName+"...场景保存成功") rItem rCount
			format "\n%" ("   ...... "+maxFileName+"...场景保存成功") to:r8dinfoa
			::r8dfn.RR_rol.Ring_lbx.items = rItem
			::r8dfn.RR_rol.Ring_lbx.selection = rCount
			)
			)
		)
							)else(
								rCount += 1
								::r8dfn.RDirMsgCount+=1
								insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+" (没有创建摄像机)") rItem rCount
			format "\n%" (" !"+::r8dfn.RDirMsgCount as string+" --> "+maxFileName+" (没有创建摄像机)") to:r8dinfoa
								::r8dfn.RR_rol.Ring_lbx.items = rItem
								::r8dfn.RR_rol.Ring_lbx.selection = rCount
								HAVECCC = false
							)
						) --MulteFile NoAction Stop
						)  --没有时间记录渲染 End
						if HAVECCC and ::r8dfn.STOPRM == false do(
							::r8dfn.RR_rol.rC_lbl.text = loC2 as string
							::r8dfn.RR_rol.load_pro2.value = 100.*loC2/(::r8dui.r8ui.lbx1.selection as array).count
							loC2+=1
						)
						HAVECCC = true
						::r8dfn.RENDERMSG=false
					)else(
						if ::r8dfn.STOPRM == false do(
							rCount += 1
							::r8dfn.RDirMsgCount+=1
							FNa = filterstring files[i] "\\"
							insertitem (" !"+::r8dfn.RDirMsgCount as string+" --> "+FNa[FNa.count]+"  (无法打开)") rItem rCount
			format "\n%" (" !"+::r8dfn.RDirMsgCount as string+" --> "+FNa[FNa.count]+"  (无法打开)") to:r8dinfoa
							::r8dfn.RR_rol.Ring_lbx.items = rItem
							::r8dfn.RR_rol.Ring_lbx.selection = rCount
						)
					)
					if ::r8dfn.STOPRM == false do(
						rCount += 1
						insertitem ("===-==-=--=---=----=-----=------=-------=--------=---------=------------------") rItem rCount
			format "\n%" ("===-==-=--=---=----=-----=------=-------=--------=---------=------------------") to:r8dinfoa
						::r8dfn.RR_rol.Ring_lbx.items = rItem
						::r8dfn.RR_rol.Ring_lbx.selection = rCount
					)
				) --Files loop Stop
				)--files for in ::r8dui.r8ui.lbx1.selection 循环
			if ::r8dfn.STOPRM then(
		unRegisterRedrawViewsCallback ::r8dfn.TimeAdd
				rCount += 1
						::r8dfn.TimeAdd()
				insertitem ("  ！--- 用户中断渲染") rItem rCount
			format "\n%" ("  ！--- 用户中断渲染") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				::r8dfn.RR_rol.lbl1.text = "渲染已中断..."
			)else(
				::r8dfn.RR_rol.load_pro2.color = (color 15 199 158)
				::r8dfn.RR_rol.load_pro.color = (color 9 185 197)
				::r8dfn.RR_rol.load_pro3.color = (color 9 175 207)
				rCount += 1
				insertitem "渲染进程完毕......" rItem rCount
			format "\n%" ("渲染进程完毕......") to:r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
				if ::r8dui.r8ui.autoOff.checked do (shellLaunch "shutdown.exe" " -s -t 120"
		if (queryBox "电脑将在2分钟后关机，是否要取消？" title:"R8D") do(shellLaunch "shutdown.exe" " -a") )
					if ::r8dfn.RDirMsgCount > 0 then(
						::r8dfn.RR_rol.lbl1.text = ("批量渲染操作完毕，有"+(::r8dfn.RDirMsgCount as string)+"个文档没有渲染成功！")
					)else(
						::r8dfn.RR_rol.lbl1.text = "所有文档已渲染完毕，请查收..."
					)
				)
		if ::r8dui.r8ui.getSS_chk.checked do(
			::r8dfn.FindSelSet()
		)
		EndTime = timeStamp()
						::r8dfn.TimeAdd()
		unRegisterRedrawViewsCallback ::r8dfn.TimeAdd
		if SetTimes then(
			useTime=(AllT+EndTime)/1000
		)else(
		useTime = (EndTime - StarTime)/1000
		)
				rCount += 1
				insertitem ("总共用时："+(::r8dfn.getTimeUse_fn useTime)) rItem rCount
			format "\n%" ("用时："+(::r8dfn.getTimeUse_fn useTime)) to:r8dinfoa
				
				close r8dinfoa
				::r8dfn.RR_rol.Ring_lbx.items = rItem
				::r8dfn.RR_rol.Ring_lbx.selection = rCount
		::r8dfn.LoadSceneVal()
				::r8dfn.RDirMsgCount = 0
				)else(messagebox "请输入正确的渲染图输出目录!" title:"R8D")
			)else(messagebox "请在列表里选择要批量渲染的max文件，双击列表选择全部。" title:"R8D")
			)else(messagebox "请仔细选择要渲染的max文件!" title:"R8D")
	)else(messagebox "请输入正确的要批量渲染的目录!" title:"R8D")
	)
	return true
	),--RRRDIR---End
	
	fn MAXPreset_fn shift:keyboard.shiftpressed =(
		if not shift do(
			if (getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSListUIpos") == "" then
				dialogPos = [100,100]
			else
				dialogPos = execute ( getINISetting "$maxScripts\plugcfg\R8D_prefs.ini" "Set" "PSListUIpos" )
			createDialog PSList_rol pos:dialogPos style:#(#style_SysMenu, #style_ToolWindow)
			
		)
		if shift do(
			psE = ::r8dui.r8ui.rps_txt.text
			saveSet = getsavefilename caption:"保存全局渲染设置" filename:psE types:"RenderSet(*.rps)|*.rps|All|*.*|"
			if saveSet != undefined do(
				renderpresets.Save 0 saveSet #{}
			)
		)
	)
)
::r8dfn = r8dfn()
-- if (getinisetting "$maxScripts\plugcfg\R8D_prefs.ini" "R8Interface" "USEAUTOUP")=="true" do ::r8dfn.AutoUpdate()
endT = timeStamp()
format "\nR8DScript Processing: %s" ((endT - startT)/1000)