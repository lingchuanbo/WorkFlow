	Include "E:\BoBOAHK\Vimdesktop\custom\maxScripts\lib\setEvn.ms"
	global activeType, activeTypePreferences
	global activeTypeKeyCatcher -- added in 0.35
	global activeTypeGetColor, activeTypeLoadSettings
	global activeTypePos -- added in 0.30
	global activeTypeExitToken -- changed in 0.35
	global activeTypeCommandToken -- added in 0.35
	global activeTypeWidth
	global activeTypeHeight
	global activeTypeMaxItems
	global activeTypeHistoryList -- added in 0.31
	global activeTypeStartup
	global activeTypeWildCard
	global activeTypeStartMenuBar -- added in 0.30
	global activeTypeColorText
	global activeTypeColorTextBG
	global activeTypeColorList
	global activeTypeColorListBG
	global activeTypeColorHistoryBG -- added in 0.31
-- 	global activeTypeINIFile = (getDir #plugcfg + @"\activeType.ini")
-- 	global activeTypeINICmdFile = (getDir #plugcfg + @"\activeTypeCommands.ini")
	global activeTypeINIFile =("$maxScripts\plugcfg\activeType.ini")
	global activeTypeINICmdFile = ("$maxScripts\plugcfg\activeTypeCommands.ini")

	fn activeTypeGetColor theKey default:gray =
	(
		local theColorText = try(getINISetting activeTypeINIFile "Preferences" theKey)catch("")
		if theColorText != "" then
		(
			arr = filterString theColorText " "
			color (arr[1] as float) (arr[2] as float) (arr[3] as float)		
		)
		else
		(
			default
		)
	)

	fn activeTypeLoadSettings =
	(
		local val
		val = (getINISetting activeTypeINIFile "Preferences" "Exit Token")[1]
		activeTypeExitToken = if val != undefined then val else ""
		val = (getINISetting activeTypeINIFile "Preferences" "Command Token")[1]
		activeTypeCommandToken = if val != undefined then val else "~"
		val = (getINISetting activeTypeINIFile "Preferences" "Width") as integer
		activeTypeWidth = if val != 0 then val else 100
		val = (getINISetting activeTypeINIFile "Preferences" "Height") as integer
		activeTypeHeight = if val != 0 then val else 18
		val = (getINISetting activeTypeINIFile "Preferences" "Max Items") as integer
		activeTypeMaxItems = if val != 0 then val else 15
		val = (getINISetting activeTypeINIFile "Preferences" "History List") as integer
		activeTypeHistoryList = if val != 0 then val else 3
		val = (getINISetting activeTypeINIFile "Preferences" "Startup") as integer
		activeTypeStartup = if val == 0 then false else true
		val = (getINISetting activeTypeINIFile "Preferences" "Wild Cards") as integer
		activeTypeWildCard = if val == 0 then false else true
		val = (getINISetting activeTypeINIFile "Preferences" "Start Menu Bar") as integer
		activeTypeStartMenuBar = if val == 0 then false else true
		
		activeTypeColorText = activeTypeGetColor "Color Text" default:black
		activeTypeColorTextBG = activeTypeGetColor "Color Text BG" default:(color 200 200 200)
		activeTypeColorList = activeTypeGetColor "Color List" default:black
		activeTypeColorListBG = activeTypeGetColor "Color List BG" default:(color 160 160 160)
		activeTypeColorHistoryBG = activeTypeGetColor "Color History BG" default:(color 190 190 255)
		
		if off then
		(
			format "@bottom\n"
			format "%\n" activeTypeColorList
			format "%\n" activeTypeColorListBG
			format "%\n" activeTypeColorHistoryBG
			format "\n"
		)
	)
	activeTypeLoadSettings()
	
	--try(destroyDialog activeType)catch()
	--try(destroyDialog activeTypePreferences)catch()
	--try(destroyDialog activeTypeKeyCatcher)catch()
	
-- 	rollout activeTypeKeyCatcher ""
-- 	(
--		editText txtBox ""
-- 		dotNetControl txtBox "TextBox"
-- 		
-- 		on activeTypeKeyCatcher open do
-- 		(
-- 			setFocus activeTypeKeyCatcher.txtBox
-- 		)
-- 		
-- 		fn exitOut =
-- 		(
-- 			local ap = activeTypePreferences
-- 			ap.chk_exit.visible = off
-- 			ap.btn_exit.visible = on
-- 			ap.chk_command.visible = off
-- 			ap.btn_command.visible = on
-- 			destroyDialog activeTypeKeyCatcher
-- 		)
-- 		
-- 		fn processKey token =
-- 		(
-- 			local ap = activeTypePreferences
-- 			if token != " " then
-- 			(
-- 				if ap.chk_exit.visible then
-- 				(
-- 					ap.edt_exit.text = token
-- 					ap.btn_exit.text = token
-- 				)
-- 				else
-- 				(
-- 					ap.edt_command.text = token
-- 					ap.btn_command.text = token
-- 				)
-- 			)
-- 			exitOut()
-- 		)
-- 		
-- 	on txtBox TextChanged arg do processKey txtBox.text
-- 	
-- 	on txtBox KeyUp arg do
-- 	(
-- 		case arg.keyValue of
-- 		(
-- 			-- entered
-- 			13:
-- 			(
-- 				exitOut()
-- 			)
-- 			-- TAB
-- 			9:
-- 			(
-- 				exitOut()
-- 			)
-- 			-- ESC
-- 			27:
-- 			(
-- 				processKey ""
-- 			)
-- 			--default: print arg.keyValue
-- 		)
-- 	)
-- 	
-- 	on txtBox LostFocus arg do exitOut()
-- 	
--		on txtBox changed token do processKey token
--		on txtBox entered token do processKey ""
-- 	)
-- 	
	
	rollout activeTypePreferences "ActiveType 0.36" width:175 height:315
	(
		GroupBox grp_pref "Settings:" pos:[5,5] width:165 height:165
		GroupBox grp_colors "Custom Colors:" pos:[5,170] width:165 height:85
		
		label lbl_exit "Exit Token:" pos:[10,20] height:13
		label lbl_command "Command Token:" pos:[10,40] height:13
		label lbl_width "Box Width:" pos:[10,60] height:13
		label lbl_maxitems "Max Items:" pos:[10,80] height:13
		label lbl_history "History List:" pos:[10,100] height:13
		
		/*
		0.35 Note for next update:
		- temporarily disabled custom color checkbox.
		- find a way to customize the color of the dotNet TextBox, or disable this feature completely
		- and clean up INI saving of the color checkbox.
		*/
		label lbl_listtext "List Text:" pos:[10,193] height:13
		label lbl_listbg "List BG:" pos:[10,213] height:13
		label lbl_historybg "History BG:" pos:[10,233] height:13
		
		edittext edt_exit "" pos:[102,20] width:62 height:17 visible:false
		button btn_exit "" pos:[105,20] width:60 height:17
		checkbutton chk_exit "Enter a Key" pos:[12,20] width:152 height:17 visible:off checked:on
		edittext edt_command "" pos:[102,40] width:62 height:17 visible:false
		button btn_command "" pos:[105,40] width:60 height:17
		checkbutton chk_command "Enter a Key" pos:[12,40] width:152 height:17 visible:off checked:on
		spinner spn_width "" pos:[105,60] width:60 height:16 range:[50,1000,100] type:#integer scale:0.1
		spinner spn_maxitems "" pos:[105,80] width:60 height:16 range:[0,1000,15] type:#integer scale:0.1
		spinner spn_history "" pos:[105,100] width:60 height:16 range:[0,1000,3] type:#integer scale:0.1
		checkbox chk_start "Initialize on Startup" pos:[10,120] width:140 height:15
		checkbox chk_space "[Spaces] as Wildcards [*]" pos:[10,135] width:140 height:15
		checkbox chk_bar "Windows Start Menu Bar" pos:[10,150] width:140 height:15
		
		colorPicker cp_text "" pos:[100,157] width:63 height:19 modal:false enabled:false visible:off
		colorPicker cp_textbg "" pos:[100,177] width:63 height:19 modal:false enabled:false visible:off

		colorPicker cp_list "" pos:[100,188] width:63 height:19 modal:false
		colorPicker cp_listbg "" pos:[100,208] width:63 height:19 modal:false
		colorPicker cp_historybg "" pos:[100,228] width:63 height:19 modal:false
		
		button btn_iniFile "Open INI File" pos:[5,258] width:165 height:25 enabled:true
			toolTip:"Open the activeType.ini file.\n\n[ALT] To Explorer the file."
		button btn_cmdFile "Open Commands File:" pos:[5,283] width:165 height:25
			toolTip:"Open the activeTypeCommands.ini file.\n\n[ALT] To Explorer the file."
		
		fn fixLabels ui offset:10 =
		(
			for p in ui.controls where classOf p == LabelControl do
			(
				local adjust = (ui.width/2)+offset
				local txtSize = getTextExtent p.text
				p.pos.x = adjust-txtSize.x
			)
		)
		
		on activeTypePreferences open do
		(
			activeTypeLoadSettings()
			try(destroyDialog activeTypeKeyCatcher)catch()
			fixLabels activeTypePreferences
			edt_exit.text = btn_exit.text = activeTypeExitToken
			edt_command.text = btn_command.text = activeTypeCommandToken
			spn_width.value = activeTypeWidth
-- 			edt_exit.text = undefined -- <-- BUG: if you enable this, it would stop the open handler at this line.
-- 			print "5"
			spn_maxitems.value = activeTypeMaxItems
			spn_history.value = activeTypeHistoryList
			chk_start.checked = activeTypeStartup
			chk_space.checked = activeTypeWildCard
			chk_bar.checked = activeTypeStartMenuBar
			cp_text.color = activeTypeColorText
			cp_textbg.color = activeTypeColorTextBG
			cp_list.color = activeTypeColorList
			cp_listbg.color = activeTypeColorListBG
			cp_historybg.color = activeTypeColorHistoryBG
			
			-- initialize the activeTypeCommands.ini file
			-- creates a sample "Save" Command
			-- added in 0.33
			if (getFiles activeTypeINICmdFile).count == 0 do
			(
				setINISetting activeTypeINICmdFile "Commands" "Save" "max file save"
			)
		)
		
		fn stringToRGB clr =
		(
			local theR = clr.r as string
			local theG = clr.g as string
			local theB = clr.b as string
			
			theR + " " + theG + " " + theB
		)
		
		on activeTypePreferences close do
		(
			try(destroyDialog activeTypeKeyCatcher)catch()
			activeTypeExitToken = edt_exit.text
			activeTypeCommandToken = edt_command.text
			activeTypeWidth = spn_width.value
			activeTypeMaxItems = spn_maxitems.value
			activeTypeHistoryList = spn_history.value
			activeTypeStartup = chk_start.checked
			activeTypeWildCard = chk_space.checked
			activeTypeStartMenuBar  =chk_bar.checked
			activeTypeColorText = cp_text.color
			activeTypeColorTextBG = cp_textbg.color
			activeTypeColorList = cp_list.color
			activeTypeColorListBG = cp_listbg.color
			activeTypeColorHistoryBG = cp_historybg.color
			
			setINISetting activeTypeINIFile "Preferences" "Exit Token" activeTypeExitToken
			setINISetting activeTypeINIFile "Preferences" "Command Token" activeTypeCommandToken
			setINISetting activeTypeINIFile "Preferences" "Width" (activeTypeWidth as string)
			setINISetting activeTypeINIFile "Preferences" "Max Items" (activeTypeMaxItems as string)
			setINISetting activeTypeINIFile "Preferences" "History List" (activeTypeHistoryList as string)
			setINISetting activeTypeINIFile "Preferences" "Startup" (if activeTypeStartup then "1" else "0")
			setINISetting activeTypeINIFile "Preferences" "Wild Cards" (if activeTypeWildCard then "1" else "0")
			setINISetting activeTypeINIFile "Preferences" "Start Menu Bar" (if activeTypeStartMenuBar then "1" else "0")
			setINISetting activeTypeINIFile "Preferences" "Color Text" (stringToRGB activeTypeColorText)
			setINISetting activeTypeINIFile "Preferences" "Color Text BG" (stringToRGB activeTypeColorTextBG)
			setINISetting activeTypeINIFile "Preferences" "Color List" (stringToRGB activeTypeColorList)
			setINISetting activeTypeINIFile "Preferences" "Color List BG" (stringToRGB activeTypeColorListBG)
			setINISetting activeTypeINIFile "Preferences" "Color History BG" (stringToRGB activeTypeColorHistoryBG)
		)
		
		-- added in 0.35
		on btn_exit pressed do
		(
			btn_exit.visible = off
			chk_exit.visible = on
			try(destroyDialog activeTypeKeyCatcher)catch()
			createDialog activeTypeKeyCatcher pos:[-1000,-1000] modal:true
		)
		
		-- added in 0.35
		on btn_command pressed do
		(
			btn_command.visible = off
			chk_command.visible = on
			try(destroyDialog activeTypeKeyCatcher)catch()
			createDialog activeTypeKeyCatcher pos:[-1000,-1000] modal:true
		)
		
		-- added in 0.35
-- 		on chk_start changed state do
-- 		(
-- 			if state then
-- 			(
-- 				local txt = "setINISetting (getDir #plugcfg + @\"\\activeType.ini\") \"Preferences\" \"Pre-Startup\" \"1\"\n"
-- 				txt+= "try(if (Macros.run \"Terabyte\" \"activeType\") then (Format \"activeType: Initializated\\n\") else (Format \"activeType: Failed to Initialize\\n\"))catch(Format \"activeType: Failed to Initialize\\n\")\n"
-- 				txt+= "try(destroyDialog activeType)catch()\n"
-- 				txt+= "setINISetting (getDir #plugcfg + @\"\\activeType.ini\") \"Preferences\" \"Pre-Startup\" \"0\""
-- 				f = createFile (getDir #Scripts + @"\Startup\activeTypeStartup.ms")
-- 				format "%" txt to:f
-- 				close f
-- 			)
-- 			else
-- 			(
-- 				deleteFile (getDir #Scripts + @"\Startup\activeTypeStartup.ms")
-- 			)
-- 		)		
		
		fn doubleSlash txt =
		(
			local newtxt = ""
			local count = txt.count
			for i in 1 to count do
			(
				newtxt += if txt[i] == "\\" then "\\\\"
				else if txt[i] == "/" then "\\\\" else txt[i]
			)
			newtxt
		)
		
		on btn_iniFile pressed do
		(
			if keyboard.altPressed then
			(
				local arg = "/e,/select,\\\"" + (doubleSlash activeTypeINIFile) + "\\\""
				execute("shellLaunch \"explorer\" \"" + arg + "\"")
			)
			else
			(
				try(shellLaunch activeTypeINIFile "")catch()
			)
		)
		
		on btn_cmdFile pressed do
		(
			if keyboard.altPressed then
			(
				local arg = "/e,/select,\\\"" + (doubleSlash activeTypeINICmdFile) + "\\\""
				execute("shellLaunch \"explorer\" \"" + arg + "\"")
			)
			else
			(
				try(shellLaunch activeTypeINICmdFile "")catch()
			)
		)
	)
	createDialog activeTypePreferences
