/*
--
--
--
--BoBO_Ä§¸Ä°æforVimdesktop
--
--
--
ActiveType
version: 0.36.03
by Jefferson D. Lim
Terabyte Inc.

Activetype is a quick way to work around 3dsmax. It gives you a context sensitive input box that generates a 
list of items that you can use to create geometry, assign modifers, access properties, execute scripts and 
custom commands, create maps/materials in slate, and invoke sub-object editing tools.

Credits:

* This script was largely inspired by Houdini's intuitive TAB Menu.
* Thanks to Jordan Walsh for the bit regarding .classes!
* Thanks to Daniel Santana (4+Arquitectos, Lda) for the User Commands/Object Parameters/Script Execution ideas!
* Thanks to Sergo Pogosyan for the History List idea!
* Thanks to Martin Breidt for the max commands ini file!
* Thanks to Arnon Marcus for the bit about adding "Locals"

Notes:

	* Run the script file, it will create commands inside your "Customize User Interface" dialog
		called "ActiveType" and "ActiveType Preferences"
	* When running the script for the first time, the preferences window will pop-up. Here are the options:
		o Exit Token: If you type this text on ActiveType, it will exit the script. 
		  It is recommendable that you use the same character/text for your shortcut and your Exit Token.
		o Command Token: This key will invoke the Custom Commands list. (0.35)
		o Box Width: The width of the ActiveType box.
		o Max Items: The maximum number of items that will be displayed.
		o History List: The maximum number of items that can be displayed in the history list. (0.32)
		o Initialize on Startup:  This will create a startup script on your scripts\startup folder.
		  Whenever 3dsmax starts, it will run activeType invisibly to pre-compile the dotNet
		  classes being used, essentialy speeding up loading on first-run. (0.35)
		o Spaces as Wildcards: Will convert blank spaces (pressing the spacebar) into wildcards (*).
		o Windows Start Menu Bar: If you have the start menu always visible, check this option to offset the ui size overflow. (0.30)
		o Custom Colors: Set the colors for the pop-up UI.
		o Open INI File: Opens the activeType.ini file found in your PlugCfg folder. (0.29)
		o Open Commands File: Opens the activeTypeCommands.ini file found in your PlugCfg folder. (0.29)
	* This will save counters for each class that you select on the list, enabling the script to 
		populate the list with the most commonly used classes first.
	* The script is using some dotNet controls, so it might lag the first time you run it.
	  (enable Initialize on first run to alleviate this)
	* This can also display a History List of previously selected items whenever invoking activeType. (0.31~0.32)
	* To EXIT activeType, do one of the following:
		o Press Enter (will execute highlighted item)
		o Click on an item in the list (will execute the picked item)
		o Type in the "Exit Token"
		o Click anywhere outside the input box
		o Press the ESC button

	
	0.29 Features:
	* User Commands
		o To enter user commands, type "~"(default as of 0.35) as the first character.
		o To add more commands, edit the activeTypeCommands.ini found in the plugcfg folder.
	* Object Parameters
		o To list the parameters for the active modifier in the stack, type "." as the first character.
		o You can then press the TAB or ENTER key to complete the text. (You can also click the item)
		o The completed text will then have an "=" sign which you can then follow with the proper value.
		o Supported parameter classes are Integers, Floats, Strings, & Booleans.
	* Script Execution
		o To execute a one-liner script, type "=" as the first character.
	
	0.30 Features:
	* The UI will now automatically expand based on the text width, and list height.
	* The UI will also reposition itself whenever it detects that the size will overflow off the screen.
	
	0.32 Features:
	* History List
		o A list of previously used geometries/modifiers/operators can be visible whenever invoking activeType.
		o You may disable the history list by setting the count to 0 (zero) from the preferences dialog.
	* Limited PFlow Support
		o You can only create Operators when you have an Operator/Event selected inside Particle View.
		
	0.33 & 0.34 New Features
    * Limited Slate Support (for max2013 only)
        o You can only create nodes inside the Slate Material Editor if:
            The Slate Window is open.
            There is a selection inside the Graph View
        o The created nodes will appear at an offset to the Left of the selected node, and will be selected.
        o Lists will be filtered depending on the current active renderer.
        o Note that you may see un-creatable Material/Maps on the list.
		    3dsMax may have automatic safegaurds preventing those to be created via Maxscript.
    * Pre-Load on Start-up
        o There is now an option called 'Initialize on Startup' to pre-load activeType to
		    defer the lag (caused by DotNet) whenever launching the 3dsmax for the first time.
    * The textbox is now displayed with a cursor and a selectable text.	
	
	0.35 New Features
    * Limited Edit\Editable Mesh / Poly / Spline / Patch Support
		o To invoke the feature, simply be in sub-object mode.
        o The script will work on both Editable and Modifier flavors.
        o Edit Poly in particular, is slightly different. The names will have
		    suffixes for Commands, Buttons, and Pick Buttons.
        o Sadly, Edit\Editable Poly sometimes are unable to execute a command, thus the 'Limited' tag.
		    (You may look at the listener for reports of unexecuted commands)
        o Some of the commands are unfiltered. A command for a sub-object polygon may appear
		    on a vertex sub-object list.
        o This feature does not trigger if you have two or more objects. (no yet)
        o The option "Spaces as wildcards" greatly helps to quickly narrow down your list:
            e.g. On a sub-object Edit_Poly, you may type "t" followed by space (whicih
			     is automatically converted to "*", then type "w" to quickly narrow
				 the list to "TargetWeld"
    * Customizable key for invoking the Custom Commands.
        o Now defaults to the "~" (tilde). Old hotkey was "#".

[0.36]
2015-06-11
- fixed command mode not working
- found part of the cause of the slowdown whenever querying modifiers:
   - removed spacewarp mods query, it was causing the slowdown
   - the speed at which activetype will query modifiers will be the same as the speed at which
     the modifier dropdown on the command panel appears.
   - i may have to build my own modifier cache to query from to speed things up a bit more.
- added "local" to variables to avoid liekly errors against other scipts (Thanks to Arnon Marcus)
- disabled subobject mode as this changed the way activeType initially worked
  - will update this to use capitalization in order to invoke sub-object mode.
- disbaled pflow and slate modes (I will need to look for better methods on detecting the dialogs)


[0.35]
2013-03-17
- fixed alt-press on opening ini files for win7
- disabled custom color checkbox - it was kinda redundant to have the switch
- added (limited) support for subobject mesh/poly/spline/patch modeling
2013-03-19
- updatead the Preferences UI and some functionalities
- added customizable Custom commands token string
- reworked the pre-load feature

[0.34]
2012-10-03
- added startup pre-loading
- restructured some code
- modified textbox to have selectable text
2012-10-04
- added (limited) support for the Slate Material Editor for max2013

[0.33]
2012-07-10
- improved Custom Commands listing (as requested by Martin Breidt)
- upon opening the activeType Preferences, it will auto-create a sample Commands File if it doesnt exist
- under the activeType Preferences, pressing [ALT]+[Open INI/Commands files] will open windows explorer to show the file and is selected.
2012-08-11
- fixed Pflow Dialog Detection using a much simpler method

[0.32d]
2011-12-06
- fixed PFlow Dialog Detection checking error

[0.32c]
2011-12-05
- fixed History List not initialized properly
- fixed PFlow Dialog Detection at index 1-3
- fixed blank "Exit Token" quick exit

[0.32b]
2011-11-30
- fixed Pflow creating ghost operators
- fixed "Color Hisroty BG" typo for INI file
- fixed history list valid modifiers filtering

[0.32]
2011-11-29
- added clean-up for pflow creating unnecessary Display Ops [2012]
2011-11-26~27
- reintegrated/simplified the pflow functionality
- added max2009 check for UIAccessor
2011-09-06
- initial tests for pflow support
- added PFlow support (pfview check and creation methods)
- added classPFExemptions
- added krakatoaClasses

[0.31]
2011-11-25~26
- added class history list
- internally renamed some variables

[0.30]
2010-01-27
- added auto extend width
- added offset UI on screen edge overflow
- added "windows menu bar" checkbox to control overflow at the bottom

[0.29b]
2010-01-27
- fixed max2010 on japanese win vista list height
- added preferences as a built in command
- fixed TAB error if no text entered
2010-01-26
- fixed TAB key error

[0.29]
2010-01-25
- code clean-up
- parameter list will now work on multiple base objects
- added open INI file button
- added open Commands INI file button
- separate INI file for the commands list
- enter key on parameter list to complete
- added parameter and command counters/ranking
- added one line script execution using "="
- added ESC key to exit@@
- added click an item on the parameters list to complete
- added open INI files as built-in commands

[0.28]
2009-12
Daniel Santana added a couple of features:
- added support for user commands using "~" (customizable as of version 0.35)
- added support for object properties (integer, float, bool and string) using "."
- added tab key on parameter list to complete

[0.27b]
- fixed error with japanese characters inside the script

[0.27]
2009-11-04
- fixed error on max9 with spaces as wildcards on
  - I was using the function substituteString which isn't available in max9
- another fix for the dynamic UI height
  - fixed for English/Japanese OS inconsistency
- adjusted width of the list for cosmetic reasons

[0.26]
2009-09-13
- fixed dynamic UI width/height
  - max 2010 was showing inconsistent list height

[0.25]
2009-09-11
- disabled mouse checking within the UI
- fixed small UI size discrepancy
2009-09-10
- added custom colors
- added max items
- added spaces as wildcards

[0.24]
2009-08-14
- UI - colors
- UI - max height
- UI - spaces as wildcards
2009-08-12
- added spacewarp modifiers
- fixed preferences bug

[0.23]
2009-08-11
- a quick fix to exit activeType if it looses focus.
- added notes on how to exit the script.

[0.22]
2009-08-10
- removed internal timer
- added preferences

[0.21]
2009-08-10
- converted listbox to dotnet

[0.20]
- added all creatable classes
- switched editText to dotNet for up/down keypress detection
- added up/down keypress
- fixed listbox height calculation

[0.10]
- initial build
*/

-- Include "E:\BoBOAHK\Vimdesktop\custom\maxScripts\lib\setEvn.ms"
-- if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" "E:\\BoBOAHK\\Vimdesktop\\custom\\maxScripts" 
-- symbolicPaths.setUserPathValue "$maxScripts" "E:\\BoBOAHK\\Vimdesktop\\custom\\maxScripts"
	
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
	--global activeTypeINIFile = (getDir #plugcfg + "/activeType.ini")
	--global activeTypeINICmdFile = (getDir #plugcfg + "/activeTypeCommands.ini")
	
	global activeTypeINIFile =("$maxScripts\plugcfg\activeType.ini")
	global activeTypeINICmdFile = ("$maxScripts\plugcfg\activeTypeCommands.ini")
	

	fn activeTypeGetColor theKey default:gray =
	(
		local theColorText = try(getINISetting activeTypeINIFile "Preferences" theKey)catch("")
		if theColorText != "" then
		(
			local arr = filterString theColorText " "
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

try(destroyDialog activeType)catch()
try(destroyDialog activeTypePreferences)catch()
try(destroyDialog activeTypeKeyCatcher)catch()
rollout activeType "" height:(if activeTypeHeight != undefined then activeTypeHeight else 18)
(
	local theClass
	local theSection = "geometryClasses"
	
	local classGeoExemptions = #()
	local classModExemptions = #(OldVertexPaint, Old_Point_Cache, EmptyModifier_Old, Missing_OSM)
	local classMatMapExemptions = #() -- added in 0.34
	local classPFlowExemptions = #() -- added in 0.32
	local AdditionalPFlowClasses = #() -- added in 0.32
	local editClasses = #() -- added in 0.35
	local editOperationClasses = #() -- added in 0.35
	local editPolyClasses = #() -- added in 0.35
	local editPolyCommandClasses = #() -- added in 0.35
	local editPolyButtonClasses = #() -- added in 0.35
	local editPolyPickClasses = #() -- added in 0.35
	local activeTypeClasses = #()
	local defaultClasses = #()
	local sortedClasses = #()	
	local parameterClasses = #()
	local commandNameClasses = #()
	local commandClasses = #()
	local repeatClasses = #() -- added in 0.31
	
	local selectedText
	
	local modeParameter
	local modeCommand
	local modeExecute
	local modePFlow -- added in 0.32
	local modeSlate -- added in 0.34
	local modeObject
	local modeSubObject -- added in 0.31
	local modeModifier
	
	local PFView -- added in 0.32
	local PFSelected -- added in 0.32
	local subObjectClass -- added in 0.35	
	
	-- added in 0.35
	local debugList = off -- type an integer number to overwrite the list array with numbers
	local debugA = off -- show modes	
-- 	local debugB = off--  show trace
	local debugC = off -- show classes
	
	dotNetControl classTxt "TextBox" pos:[2,2] width:(ActiveTypeWidth) visible:on
	dotNetControl classList "ListBox" pos:[2,18] width:(ActiveTypeWidth-4) height:0
	
	fn compareFN v1 v2 valArray: =
	(
		local v1i = valArray[v1][2]
		local v2i = valArray[v2][2]
		local d = v1i - v2i
		case of
		(
			(d > 0.): -1
			(d < 0.): 1
			default: 0
		)
	)
	
	-- this will resize the UI width as you type in the textbox
	-- it will also resize the UI height depending on the listbox height
	-- lastly, it will also offset the UI if the size is off-screen
	-- added in 0.30
	fn resizeUI txt arr =
	(
		local txtWidth = 0
		local arrWidth = 0
		local newWidth = activeTypeWidth
		local theHeight = activeType.height
		local barHeight = if activeTypeStartMenuBar then 30 else 0 -- start menu bar height ?
		
		local txtWidth = (getTextExtent txt).x		

		local tempArr = #()
		for i in arr do
		(
			append tempArr ((getTextExtent (i as string)).x)
		)
		arrWidth = if tempArr.count > 0 then amax tempArr else 0
	
		local maxWidth = amax #(txtWidth, arrWidth)
		
		if (maxWidth + 50) > activeTypeWidth then
		(
			newWidth = maxWidth + 50
			activeType.width = newWidth
			classTxt.width = classList.width = newWidth-4
		)
		else
		(
			activeType.width = activeTypeWidth
			classTxt.width = classList.width = activeTypeWidth-4
		)
		
		local mX = mouse.screenPos.x
		local mY = mouse.screenPos.y
		local pSize = sysInfo.desktopSize
		local pCenter = pSize/2
		local pRight = if mX > pCenter.x then true else false
		local pBottom = if mY > pCenter.y then true else false
		
		local pX = if pRight and activeTypePos.x + newWidth > pSize.x then activeTypePos.x-((activeTypePos.x + newWidth) - pSize.x) else activeTypePos.x
		local pY = if pBottom and activeTypePos.y + theHeight > pSize.y-barHeight then (activeTypePos.y-((activeTypePos.y + theHeight) - pSize.y))-barHeight else activeTypePos.y
		
		setDialogPos activeType [pX,pY]
	)
	
	-- this will sort the classes based on the ini file counters
	fn createSortedClasses =
	(
		local tempArr = #()
		
		for c in defaultClasses do
		(	
			theValue = getINISetting activeTypeINIFile theSection (c as string)
			if theValue != "" then append tempArr #(c, (theValue as integer))
		)
		local count = tempArr.count
		local dexArr = for i in 1 to count collect i
		qSort dexArr compareFN valArray:tempArr
		sortedClasses = for i in 1 to count collect tempArr[dexArr[i]][1]
	)
	
	fn saveFilters theSec theClass val =
	(
		setINISetting activeTypeINIFile theSec theClass val
	)
	
	-- this will update the classes with the sorted classes
	fn updateClassList =
	(
		createSortedClasses()
		local count = defaultClasses.count
		local tempClasses = deepCopy defaultClasses
		for i in count to 1 by -1 do
		(
			if findItem sortedClasses tempClasses[i] != 0 then
			(
				deleteItem tempClasses i
			)
		)
		activeTypeClasses = join sortedClasses tempClasses
		tempClasses = #()
	)
	
	-- max9 equivalent of the substituteString fn on higher max versions
	fn substituteSingleString sourceString fromString toString =
	(
		local newString = sourceString
		for i in sourceString.count to 1 by -1 do
		(
			if sourceString[i] == fromString then newString[i] = toString
		)
		newString
	)
	
	-- will convert spaces into *
	-- forDisplay:
	--    true: will remove the * from the text
	--    false: will return the generated text as is with the *
	fn spacesAsWildcard txt forDisplay:false =
	(
		local txtArr = filterString txt " "
		local count = txtArr.count
		
		local newTxt = ""
		
		if txt[1] == " " do
		(
			newTxt = "*" + newTxt
		)
		
		if count == 0 then
		(
			newTxt
		)
		else
		(
			for i in 1 to count do
			(
				newTxt += txtArr[i] + "*"
			)
		)
		if forDisplay then newTxt = substring newTxt 1 (newTxt.count-1)
-- 		if forDisplay then newTxt = substituteString txt " " "*" -- not max9 compatible
		if forDisplay then newTxt = substituteSingleString txt " " "*"
		
		newTxt
	)
	
	-- will return an array of items that match the txt
	fn searchArray txt arr =
	(
		local isCmd = false
		local items = #()
		local realPat = if activeTypeWildCard then spacesAsWildcard txt else txt + "*"
		if txt != undefined and txt[1] == activeTypeCommandToken do isCmd = true
		for t in arr do
		(
			local t = t as string
			local pat = realPat
			if isCmd do
			(
				pat = substring realPat 2 -1
				if pat.count == 0 do pat = "*"
			)
			if matchPattern t pattern:pat do
			(
				append items t
			)
		)
		items
	)
	
	-- check to see if the mouse is outside the borders of the script UI
	fn checkMouse =
	(
		local state = true
		local mp = mouse.screenpos
		local dp = getdialogpos activeType
		
		local above_this = (mp.y < (dp.y+activeTypeHeight))
		local below_this = (mp.y > (dp.y+activeType.height))
		local left_this = (mp.x < dp.x)
		local right_this = (mp.x >(dp.x+activeType.width))
		
		if (above_this or below_this) \
		or (left_this or right_this) then state = true else state = false
		
		state
	)
	
	fn incrementClassCounter txt =
	(
		local theClass = try(classList.selectedItem)catch()
		if theClass != undefined do
		(
			theSec = theSection
			-- save and increment the counter for the class
			count = try(getINISetting activeTypeINIFile theSec theClass)catch(0)
			saveFilters theSec theClass (((count as integer)+1) as string)
		)
	)
	
	-- new in 0.31
	-- outputs the last items used per mode
	-- sorts and sets the INI file with an updated ranking, the last used item is first on the list
	fn initRepeatClasses mode pushRank:false txt:unsupplied =
	(
		local items = getINISetting activeTypeINIFile mode
		local itemCount = items.count
		local dexArr = for i in 1 to itemCount collect i
		local rankList = for i in 1 to itemCount collect #(items[i], ((getINISetting activeTypeINIFile mode items[i]) as integer))
		qsort dexArr compareFN valArray:rankList
		sortedItems = for i in itemCount to 1 by -1 collect rankList[dexArr[i]][1]
		
		if pushRank then
		(
			txt = txt as string
			
			local dex = finditem sortedItems txt 
			if dex != 0 do deleteItem sortedItems dex
			insertItem txt sortedItems 1
			delINISetting activeTypeINIFile mode
			
			local newCount = sortedItems.count
			for i in 1 to newCount do
			(
				setINISetting activeTypeINIFile mode sortedItems[i] (i as string)
			)
		)
		else
		(
			local filteredItems = #()
			local filteredStrings = for i in defaultClasses collect (i as string)
			for i in 1 to itemCount do
			(
				local dex = findItem filteredStrings sortedItems[i]
				if dex != 0 do append filteredItems defaultClasses[dex]
			)
			local maxCount = amin #(activeTypeHistoryList, itemCount, filteredItems.count)
			repeatItems = for i in 1 to maxCount collect (filteredItems[i] as string)	
		)
	)
	
	-- added in 0.35
	--   using modPanel returns an undesired result for mesh and poly,
	--   there are spaces: 'Editable Poly' instead of 'Editable_Poly'
	--   the former cannot be used to compare against the built in class name.
	fn getCurrentObject =
	(
		theObject = modPanel.getCurrentObject()
		if theObject == selection[1].baseObject then
		(
			theObject = selection[1]
		)
		theObject
	)
	
	fn exec =
	(
		incrementClassCounter selectedText
		case of
		(
			modeParameter:
			(
				global activeTypeTempObj = modPanel.getCurrentObject()
				if activeTypeTempObj == undefined do activeTypeTempObj = $
				execString = "activeTypeTempObj" + classTxt.text
				try(execute execString)catch(format "%\n" (getCurrentException()))
			)
			modeCommand:
			(
				index = findItem commandNameClasses selectedText
				try(execute (commandClasses[index]))catch(format "%\n" (getCurrentException()))
			)
			modePFlow: -- added in 0.32
			(
				if PFSelected == undefined then exit
				try
				(
					-- this is for checking newly created display nodes [2012]
					prePFEventsCount = (for i in helpers where classOf i == Event collect i).count
					prePFDisplaysCount = (for i in helpers where classOf i == DisplayParticles collect i).count
					
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					operatorClass = defaultClasses[index]
					
					selClass = classOf PFSelected
					case selClass of
					(
-- 						undefinedClass: -- if nothing is selected in pview
-- 						(
							--theOperator = operatorClass()							
							/*
							still looking for a way to place/drop the created operator/event under the mouse position..
							*/
-- 							parentEvents = for i in (refs.dependents theOperator) where classOf i == Event and isValidNode i collect i
-- 							parentEvent = parentEvents[1]							
-- 							eventPos = mouse.screenPos - PFViewPos - [0, 0]
-- 							parentEvent.setPViewLocation eventPos.x eventPos.y
-- 						)
						PF_Source:
						(
							particleFlow.beginEdit()
							theOperator = operatorClass()
							if not (PFSelected.appendAction theOperator) then delete theOperator
							particleFlow.endEdit()
						)
						Event:
						(
							particleFlow.beginEdit()
							theOperator = operatorClass()
							if not PFSelected.appendAction theOperator then delete theOperator
							particleFlow.endEdit()
							
						)
						default:
						(
							particleFlow.beginEdit()
							parentEvents = for i in (refs.dependents PFSelected) where classOf i == Event and isValidNode i collect i
							parentEvent = parentEvents[1]
							if parentEvent != undefined then
							(
								actionsCount = parentEvent.numActions()
								actionsArr = for i in 1 to actionsCount collect (parentEvent.getAction i)
								dex = finditem actionsArr PFSelected
								theOperator = operatorClass()
								if not (parentEvent.insertAction theOperator (dex+1)) then delete theOperator
							)
							particleFlow.endEdit()
						)
					)
					initRepeatClasses "modePFlow" pushRank:true txt:(operatorClass)
					try(PFView.selected = #(theOperator))catch()
					pftParticleView.redraw()
-- 					actionMan.executeAction 135018554 "32771" -- close
-- 					actionMan.executeAction 135018554 "32771" -- open
					
					-- this is for checking and deleting uneccessary newly created display nodes [2012]
					postEvents = for i in helpers where classOf i == Event collect i
					postDisplays = for i in helpers where classOf i == DisplayParticles collect i
					postPFEventsCount = postEvents.count
					postPFDisplaysCount = postDisplays.count
					if postPFDisplaysCount > prePFDisplaysCount then try(particleFlow.delete postDisplays[postPFDisplaysCount])catch()
					if postPFEventsCount > prePFEventsCount then try(particleFlow.delete postEvents[postPFEventsCount])catch() -- the particleFlow.delete function is undocumented
				)
				catch
				(
					pushPrompt "Unable to create operator."
				)
			)
			modeSlate: -- added in 0.34
			(
				theView = sme.GetView (sme.activeView)
				count = theView.GetNumNodes()
				selCount = 0
				thePos = [0,0]
				for i in 1 to count do
				(
					theNode = theView.GetNode i
					if theNode != undefined do
					(
						if theNode.selected do
						(
							truePos = (theNode.position)
							thePos = (truePos + thePos)
							selCount += 1
							theNode.selected = false
						)
					)
				)
				thePos = thePos/(if selCount == 0 then 1 else selCount) -- tried allowing multiple selections, i might remove this in the future
				try
				(
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					if index != 0 do
					(
						newPos = thePos + [-200,0]
						newNode = theView.createNode (defaultClasses[index]()) newPos						
						newNode.selected = true
						initRepeatClasses "modeSlate" pushRank:true txt:defaultClasses[index]
					)
				)
				catch
				(
					pushPrompt "Unable to create Material/Texture."
				)
			)
			modeObject:
			(
				try
				(
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					if index != 0 do
					(
						startobjectcreation defaultClasses[index]
						initRepeatClasses "modeObject" pushRank:true txt:defaultClasses[index]
					)
				)
				catch
				(
					pushPrompt "Unable to create object."
				)
			)
			modeSubObject: -- added in 0.35
			(
				try
				(
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					if index != 0 do
					(
						if subObjectClass == Edit_Poly or subObjectClass == Editable_Poly then
						(
							c = editPolyClasses[index]
							cCommand = matchPattern c pattern:"*Command"
							cButton = matchPattern c pattern:"*Button"
							cPick = matchPattern c pattern:"*Pick"
							
							eval = ""
							case of
							(
								cCommand:
									eval = "(activeType.getCurrentObject()).toggleCommandMode #" + (subString c 1 (c.count-"Command".count))
								cButton:
									eval = "(activeType.getCurrentObject()).buttonOp #" + (subString c 1 (c.count-"Button".count))
								cPick:
									eval = "(activeType.getCurrentObject()).GetPickMode #" + (subString c 1 (c.count-"Pick".count))
							)
							
-- 							print eval
							
							try
							(
								execute eval
							)
							catch
							(
								format "\n--> Unrecognized Edit_Poly code.\n%\n" eval
							)
						)
						else
						(
							operator =
							(
								case subObjectClass of
								(
									--Edit_Poly: "polyOps"
									--Editable_Poly: "polyOps"
									Edit_Mesh: "meshOps"
									Editable_Mesh: "meshops"
									Edit_Spline: "splineOps"
									SplineShape: "splineOps"
									Line: "splineOps"
									Edit_Patch: "patchOps"
									Editable_Patch: "patchOps"
								)
							)
							execute (operator + "." + editOperationClasses[index] + " " + "(activeType.getCurrentObject())")
						)
						initRepeatClasses "modeSubObject" pushRank:true txt:defaultClasses[index]
					)
				)
				catch
				(
					pushPrompt "Unable to execute command."
				)
			)
			modeModifier:
			(
				try
				(
					defaultClassesString = for i in defaultClasses collect i as string
					index = findItem defaultClassesString classList.selectedItem
					if index != 0 do
					(
						AddMod defaultClasses[index]
						initRepeatClasses "modeModifier" pushRank:true txt:defaultClasses[index]
					)
				)
				catch
				(
					pushPrompt "Unable to add modifier."
				)
			)
			modeExecute:
			(
				execString = subString classTxt.text 2 classTxt.text.count
				undo "activeType MaxScript" on try(execute execString)catch(format "%\n" (getCurrentException()))
				format "%\n" execString
			)
		)
		destroyDialog activeType
	)
	
	fn cleantxt txt =
	(
		txt_count = txt.count
		the_text = ""
		if txt_count != 0 do
		(
			for i in 1 to txt_count where txt[i] != " " do
			(
				the_text += txt[i]
			)
		)
		the_text
	)
	
	fn dotNetColor clr =
	(		
		(dotNetClass "System.Drawing.Color").fromARGB clr.r clr.g clr.b
	)
	
	fn buildParameterList arr =
	(
		local tmpObj = modPanel.getCurrentObject()
		local parameterClasses = #()
		local validParamClasses = #(Integer, Float, String, BooleanClass)
		
		for obj in arr do
		(
			if tmpObj == undefined do tmpObj = obj
			for i in (getPropNames tmpObj) do
			(
				p = getProperty tmpObj i
				c = classOf p
				if (findItem validParamClasses c) != 0 do
				(
					if (findItem parameterClasses ("." + i)) == 0 do
					(
						append parameterClasses ("." + i)
					)
				)
			)
		)
		parameterClasses
	)
	
	fn buildcommandClasses =
	(
		-- built-in commands
		local theCmd = #("ActiveType INI", "ActiveType Commands", "ActiveType Preferences")
		local theExe = #("shellLaunch activeTypeINIFile \"\"", "shellLaunch activeTypeINICmdFile \"\"", "macros.run \"Terabyte\" \"activeTypePreferences\"")
			
		commandNameClasses = getINISetting activeTypeINICmdFile "Commands"
		commandClasses = #()		
		for i in commandNameClasses do append commandClasses (getINISetting activeTypeINICmdFile "Commands" i)
		
		join commandNameClasses theCmd
		join commandClasses theExe
		
		commandNameClasses
-- 		#(cmd, realCmd)
	)
	
	/*
	- added in 0.32
	- checks if active window is pf (dialogs[3])
	- checks mouse pos if inside pf work area
	- fixed in 0.33
	*/
	fn checkPFlowDialog =
	(
		theDialogs = for i in UIAccessor.GetPopupDialogs() collect UIAccessor.GetWindowText i
		checkPF	= (findItem theDialogs "Particle View") > 0
		
-- 		local PFView
		if checkPF then  
		(
			PFView = (refs.dependentNodes (getClassInstances particleView)[1])[1]
		)
		
		if PFView != undefined then
		(
			max_pos = getMAXWindowPos()
			if PFView.origin == [0,0,0] then PFView.origin = [4,81,0]
			pp = (PFView.origin) + [(max_pos.x), (max_pos.y), 0]
-- 			PFViewPos = [pp.x, pp.y]
			
			pw = PFView.width
			ph = PFView.height
			
			mp = mouse.screenPos
			
			right_pos = mp.x > pp.x + pw
			left_pos = mp.x < pp.x
			up_pos = mp.y < pp.y
			down_pos = mp.y > pp.y + ph
			
			-- check if cursor is inside PView window
			if not ((right_pos or left_pos) or (up_pos or down_pos)) then
			(
				-- check if there is a selected item in pview
				PFSelected = (PFView.selected)[1]
				if PFSelected != undefined then true
				else false
			)
			else false	
		)
		else false
	)
	/*
	- add custom scripts (emtpy flow, standard flow, presets)
	*/

	-- added in 0.34
	-- will check for max2013
	-- still looking for a way to detect if the Slate Window is in Focus
	fn checkSlateDialog =
	(
		checkSlate	= try(sme.IsOpen())catch(false)
		isMax2013 = (maxVersion())[1] >= 15000
				
		-- checks to see if there is a selection in slate
		if checkSlate and isMax2013 then
		(
			hasSelection = false
			theView = sme.GetView (sme.activeView)			
			count = theView.GetNumNodes()
			
			for i in 1 to count do
			(
				theNode = theView.GetNode i				
				if theNode != undefined do
				(
					if theNode.selected do
					(
						hasSelection = true
						exit
					)
				)
			)			
			hasSelection
		)
		else false
	)
	
	-- added in 0.35
	fn checkSubObjectMode =
	(
		isOK = false
		
		if (selection.count == 1) then
		(
			currentClass = classOf (getCurrentObject())
			if findItem editClasses currentClass > 0 then
			(
				if subObjectLevel != 0 then
				(
					subObjectClass = currentClass
					isOK = true
				)
			)
		)
		isOK
	)
	
	-- initialize and define all the classes
	fn initClassList =
	(
		defaultClasses = #()
		txt = classTxt.text
		
		modeParameter = txt[1] == "." and $ != undefined
		modeCommand = txt[1] == activeTypeCommandToken 
		modeExecute = txt[1] == "="
		modePFlow = false--checkPFlowDialog()
		modeSlate = false--checkSlateDialog()
		modeObject = $ == undefined and not modeExecute
		modeSubObject = false--checkSubObjectMode() 
		modeModifier = $ != undefined and not modeExecute and not modeSubObject
		
		if debugA then
		(
			format "- modeParameter: %\n" modeParameter
			format "- modeCommand: %\n" modeCommand
			format "- modeExecute: %\n" modeExecute
			format "- modePFlow: %\n" modePFlow
			format "- modeSlate %\n" modeSlate
			format "- modeObject: %\n" modeObject
			format "- modeSubObject: %\n" modeSubObject
			format "- modeModifier: %\n" modeModifier
			format "\n"
		)
		
		case of
		(
			/*
			theSection is used to set the section inside the INI files.
			defaultClasses is used as items for the activeType list.
			*/
			modeParameter:
			(
				theSection = "parameterClasses"
				defaultClasses = buildParameterList selection
			)
			modeCommand:
			(
				theSection = "commandClasses"
				defaultClasses = buildcommandClasses()
			)
			modeExecute:
			(
				theSection = "geometryClasses"
				defaultClasses = #()
			)
			modeSlate: -- added in 0.34
			(
				theSection = "SlateClasses"
				materialClasses =  for i in material.classes where areMtlAndRendererCompatible i collect i
				textureClasses = for i in textureMap.classes where areMtlAndRendererCompatible i collect i
				
				defaultClasses += materialClasses
				defaultClasses += textureClasses
				
				finalClasses = for i in defaultClasses where (findItem classMatMapExemptions i == 0) collect i
				defaultClasses = finalClasses
			)
			modePFlow: -- added in 0.32
			(
				-- add checking of Birth Classes here (in later versions?)
				theSection = "PFlowClasses"	
				defaultClasses = for i in helper.classes where (i.classID)[2] == 515064320 collect i
				defaultClasses += AdditionalPFlowClasses
				finalClasses = for i in defaultClasses where (findItem classPFlowExemptions i == 0) collect i
				defaultClasses = finalClasses
			)	
			modeObject:
			(
				theSection = "geometryClasses"
				
				geometryClasses = for i in geometryClass.classes where okToCreate i collect i
				shapeClasses = for i in shape.classes where okToCreate i collect i
				lightClasses = for i in light.classes where okToCreate i collect i
				cameraClasses = for i in camera.classes where okToCreate i collect i
				helperClasses = for i in helper.classes where okToCreate i collect i
				spaceWarpClasses = for i in SpacewarpObject.classes where okToCreate i collect i
				systemClasses = for i in System.classes where okToCreate i collect i
				
				--defaultClasses = #()
				defaultClasses += geometryClasses
				defaultClasses += shapeClasses
				defaultClasses += lightClasses
				defaultClasses += cameraClasses
				defaultClasses += helperClasses
				defaultClasses += spaceWarpClasses
				defaultClasses += systemClasses
				
				finalClasses = for i in defaultClasses where (findItem classGeoExemptions i == 0) collect i
				defaultClasses = finalClasses
			)
			modeSubObject: -- added in 0.35
			(
				theSection = "subObjectClasses"
				
				if subObjectClass == Edit_Poly or subObjectClass == Editable_Poly then
				(
					editPolyClasses = #()
					
					for i in editPolyCommandClasses do append editPolyClasses (i + " Command")
					for i in editPolyButtonClasses do append editPolyClasses (i + " Button")
					for i in editPolyPickClasses do append editPolyClasses (i + " Pick")
					
					-- filter out of context commands
					eCount = editPolyClasses.count
					for i in eCount to 1 by -1 do
					(
						kVertex = matchPattern editPolyClasses[i] pattern:"*Vert*"
						kEdge = matchPattern editPolyClasses[i] pattern:"*Edge*"
						kBorder = matchPattern editPolyClasses[i] pattern:"*Border*"
						kFace = matchPattern editPolyClasses[i] pattern:"*Face*"
						kPolygon = matchPattern editPolyClasses[i] pattern:"*Polygon*"
							
						case subObjectLevel of
						(
							1: if kEdge or kBorder or kFace or kPolygon do deleteItem editPolyClasses i
							2: if kVertex or kFace or kPolygon do deleteItem editPolyClasses i
							3: if kVertex or kFace or kPolygon do deleteItem editPolyClasses i
							4: if kVertex or kBorder or kEdge do deleteItem editPolyClasses i
							5: if kVertex or kBorder or kEdge do deleteItem editPolyClasses i
						)
					)
					defaultClasses = editPolyClasses
				)
				else
				(
					operator =
					(
						case subObjectClass of
						(
							--Edit_Poly: polyOps
							--Editable_Poly: polyOps
							Edit_Mesh: meshops
							Editable_Mesh: meshops
							Edit_Spline: splineOps
							SplineShape: splineOps
							Line: splineOps
							Edit_Patch: patchOps
							Editable_Patch: patchOps
						)
					)
					if operator != undefined then
					(
						editOperationClasses = for i in (getPropNames operator) collect i as string
						
						renamedClasses = for i in editOperationClasses collect
						(
							txt = i
							if matchPattern txt pattern:"start*" then
							(
								txt = subString txt 6 txt.count
							)
							txt
						)						
						defaultClasses = renamedClasses
					)
				)
			)
			modeModifier:
			(
				theSection = "modifierClasses"
				
				/*
				Found what was causing the delay on modifier mode.
				It was due to a somewhat slow validModifier querying for SpacewarpModifier.classes
				
				process:
					- get a heavy object (editable poly)
					- add a point cache mod
					- add an edit poly mod
					- run activeType to add any mod, notice the slowdown.
					- this is also noticeable on the modifier stack:
				
				For now, the solution is exclude space warps on the list..
				On the next update, typing a capitalized initial string search would include the spacewarps on the list.
				*/
				
				theObject = $
				theModClasses = modifier.classes 
-- 				theModClasses = SpacewarpModifier.classes 
				
-- 				modifierClasses = for i in theModClasses where (validModifier theObject i) collect i
-- 				theSWCalsses = SpacewarpModifier.classes
-- 				spaceWarpModClasses = for i in theSWCalsses where (validModifier theObject i) collect i
				
-- 				theModClasses = join modifier.classes SpacewarpModifier.classes
				modifierClasses = for i in theModClasses where (validModifier theObject i) collect i
					
				--defaultClasses = #()
				defaultClasses += modifierClasses
-- 				defaultClasses += spaceWarpModClasses
				
				finalClasses = for i in defaultClasses where (findItem classModExemptions i == 0) collect i
				defaultClasses = finalClasses
			)
		)
		repeatClasses = case of
		(
-- 			modeParameter: initRepeatClasses "modeParameter"
-- 			modeCommand: initRepeatClasses "modeCommand"
-- 			modeExecute: initRepeatClasses "modeExecute"
			modePFlow: initRepeatClasses "modePFlow"
			modeSlate: initRepeatClasses "modeSlate"
			modeObject: initRepeatClasses "modeObject"
			modeSubObject: initRepeatClasses "modeSubObject"
			modeModifier: initRepeatClasses "modeModifier"
		)
		updateClassList()
		if debugC then format "Classes: %\n\n" defaultClasses
	)
	
	fn setItems txt items =
	(
		count = try(items.count)catch(0)
		
		if count != 0 then
		(
			classList.items.clear()
			v = maxversion()
			
			for i in items do
			(
				if v[1]/1000 >= 12 then
				(
					classList.items.add i
				)
				else
				(
					classList.items.add (dotNetObject "System.String" i)
				)
			)
			
			h =
			(
				case (sysInfo.getLanguage())[1] of
				(
					9: 13 -- English (US)
					17: -- Japanese (Nihonggo)
					(
						--max2010 on a Japanese Vista OS 64bit seems to be using 12
						if (maxVersion())[1]/1000 == 12 then 13 else 13
					)
					default: 13
				)
			)
			maxCount = activeTypeMaxItems
			
			listH =  (amin (count*h) (maxCount*h)) + 4 -- text height + 6 pixel border offset
			
			activeType.height = activeTypeHeight + listH + 2
			classList.height = listH
			classList.height = listH
			classList.visible = on
			classList.selectedIndex = 0
			selectedText = classList.selectedItem
		)
		else
		(
			classList.items.clear()
			classList.height = 0
			classList.visible = off
			activeType.height = activeTypeHeight + 6
		)
		resizeUI txt items
	)
	
	fn fillItems =
	(
		local txt = classTxt.text
		
		initClassList()
		classTxt.text =
		(
			if txt[1] != "=" then
			(
				if activeTypeWildCard then
				(
					local newTxt = spacesAsWildcard txt forDisplay:true
					classTxt.SelectionStart = newTxt.count
					newTxt
				)
				else txt
			)
			else txt
		)-- override spacesAsWildcard while in execute mode
		
		items = searchArray txt activeTypeClasses
		if debugList do items = try(for i in 1 to (txt as integer) collect (i as string))catch(#()) -- type in numbers to define list height
		try
		(
			setItems txt (if txt == "" then repeatClasses else items)				
			classList.BackColor = dotNetColor (if txt == "" then activeTypeColorHistoryBG else activeTypeColorListBG)
		)
		catch(destroyDialog activeType)
		
		if txt == activeTypeExitToken and txt != "" do
		(
			try(destroyDialog activeType)catch()
		)
	)
	
	on activeType open do
	(
		-- added in 0.32
		-- some of these operators where not meant to be creatable by the user
		classPFlowExemptions = #(Data_Operatorhelper, Data_Iconhelper, Data_Testhelper, Test_Iconhelper, Data_Presethelper, Data_Preset_Test, Viewport_Render, materialhelper, Position_Objecthelper, PhysXWorldObsolete)
		
		-- added in 0.32
		-- this is because some pflow classes like in krakatoa are not using the classID[2] value of 515064320 which is used by the majority of other pflow classes
		AdditionalPFlowClasses = #(Krakatoa_PRT_Birth, Krakatoa_Geometry_Lookup, Krakatoa_PRT_Update, Krakatoa_Collision_Test, Krakatoa_File_ID_Test, Krakatoa_Geometry_Test, Krakatoa_Options)

		-- added in 0.35
		-- this is for activating the subObject commands
		editClasses = #(Edit_Poly, Editable_Poly, Edit_Mesh, Editable_Mesh, Edit_Spline, SplineShape, Line, Edit_Patch, Editable_Patch)
		
		-- added in 0.35
		-- I didn't want to hard code these arrays in here, but querying for these
		-- everytime activetype runs is quit taxing.
		editPolyCommandClasses = #("CreateVertex", "CreateEdge", "CreateFace", "DivideEdge", "DivideFace", "ExtrudeVertex", "ExtrudeEdge", "ExtrudeFace", "ChamferVertex", "ChamferEdge", "Bevel", "SlicePlane", "CutVertex", "CutEdge", "CutFace", "Weld", "EditTriangulation", "InsetFace", "QuickSlice", "HingeFromEdge", "PickLiftEdge", "OutlineFace", "EditSoftSelection", "TurnEdge")
		editPolyButtonClasses = #("GrowSelection", "ShrinkSelection", "SelectEdgeLoop", "SelectEdgeRing", "HideSelection", "HideUnselected", "UnhideAll", "NamedSelectionCopy", "NamedSelectionPaste", "Cap", "Delete", "Remove", "Detach", "AttachList", "SplitEdges", "BreakVertex", "Collapse", "ResetSlicePlane", "Slice", "WeldSelected", "CreateShape", "MakePlanar", "AlignGrid", "AlignView", "RemoveIsoVerts", "MeshSmooth", "Tessellate", "Update", "SelectByVertexColor", "Retriangulate", "FlipNormals", "SelectByMatID", "SelectBySmoothingGroups", "Autosmooth", "ClearSmoothingGroups", "Extrude", "Bevel", "Inset", "Outline", "ExtrudeAlongSpline", "HingeFromEdge", "ConnectEdges", "ConnectVertices", "Chamfer", "Cut", "RemoveIsoMapVerts", "ToggleShadedFaces", "MakePlanarInX", "MakePlanarInY", "MakePlanarInZ", "Relax", "BridgeBorder", "BridgePolygon", "BridgeEdge", "PreserveUVSettings")
		editPolyPickClasses = #("Attach", "PickShape")
		
		classList.ForeColor = dotNetColor activeTypeColorList		
		classList.BackColor = dotNetColor activeTypeColorHistoryBG	

		activeTypePos = getDialogPos activeType
		fillItems()
		
		setfocus classTxt
	)
	
	on classTxt TextChanged arg do
	(
		fillItems()
	)
	
	on classTxt KeyUp arg do
	(
		local txt = classTxt.text
		local dex = classList.selectedIndex
		local count = classList.items.count
		local txtcount = txt.count
		
		case arg.keyValue of
		(
			-- entered
			13:
			(
				if txt.count == 1 and txt[1] == "." and findString txt "=" == undefined then
				(
					classTxt.text = selectedText + "="
					classTxt.SelectionStart = classTxt.text.count
				)
				else
				(
					exec()
				)
			)
			-- up
			38:
			(
				classTxt.SelectionStart = txtcount
				
				newDex = dex - 1
				if newDex <= count-1 and newDex > -1 do classList.selectedIndex = newDex
				selectedText = classList.selectedItem
			)
			
			-- down
			40:
			(
				classTxt.SelectionStart = txtcount
				
				newDex = dex + 1
				try(if newDex <= count-1 and newDex > -1 do classList.selectedIndex = newDex)catch()
				selectedText = classList.selectedItem
			)
			-- TAB
			9:
			(		
				selectedText = classList.selectedItem
				if selectedText != undefined then
				(
					classTxt.text = selectedText
					if selectedText != "" and selectedText[1] == "." do
					(
						classTxt.text += "="
					)
					classTxt.SelectionStart = classTxt.text.count
				)
			)
			-- ESC
			27:
			(
				destroyDialog activeType
			)
			--default: print arg.keyValue
		)
	)
	
	on classTxt LostFocus arg do
	(
		if checkMouse() do
		(
			try(destroyDialog activeType)catch()
		)
	)
	
	on classList mouseUp arg do
	(
		local txt = classTxt.text
		selectedText = classList.selectedItem
		if txt[1] == "." and findString txt "=" == undefined then
		(
			classTxt.text = selectedText + "="
			classTxt.SelectionStart = classTxt.text.count
			setFocus classTxt
		)
		else
		(
			exec()
		)

	)
	
	on activeType close do
	(
		try(destroyDialog activeType)catch()
	)
)

if (getfiles activeTypeINIFile).count == 0 then
(
	try(macros.run "Terabyte" "activeTypePreferences")catch()
)
else
(
	-- added in 0.35
	-- I renamed "Exit Text" to "Exit Token"
	if hasINISetting activeTypeINIFile "Preferences" "Exit Text" then
	(
		local oldToken = getINISetting activeTypeINIFile "Preferences" "Exit Text"
		setINISetting activeTypeINIFile "Preferences" "Exit Token" oldToken
		
		delIniSetting activeTypeINIFile "Preferences" "Exit Text"
	)
	if ((getINISetting activeTypeINIFile "Preferences" "Pre-Startup") as integer) == 1 then
	(
		createDialog activeType pos:[-50,-50]
	)
	else
	(
		local mX = mouse.screenPos.x
		local mY = mouse.screenPos.y
		local pSize = sysInfo.desktopSize
		local pCenter = pSize/2
		local pLeft = if mX < pCenter.x then true else false
		local pTop = if mY < pCenter.y then true else false
		
		local pX = if pLeft and mX < activeTypeWidth then mX else activeTypeWidth
		local pY = if pTop and mY < activeTypeHeight then mY else activeTypeHeight
		
		createDialog activeType pos:(mouse.screenPos-[pX,pY]) \
		escapeEnable:true bgColor:activeTypeColorListBG style:#(style_border) \
		width:activeTypeWidth
	)
)