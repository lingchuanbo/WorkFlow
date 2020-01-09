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
Company: GTVFX
Website: https://github.com/gtvfx
Email: gftvfx@gmail.com
__END__
***************************************************************************************************/


mxs.using "Logger"


struct Menu_Lib
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This module creates system menus from directory structures
	Allows for quick updates to tool menus without the need to update any code
	Remove menu items by deleting the scipt file on disk. 
	Remove a menu by deleting it's directory.
	
	Constructor:
		<VAR> = ::Menu_Lib sourceDir:<string> defaultCategory:<string> strGlobal:<string>
	
	Usage:
		Load the module then instantiate it with sourceDir, defaultCategory, and strGlobal values

		A good idea is to have an init script for this in the startup routine
	
	Members:
		[Var] debug
		[Var] defaultCategory : Each macroscript generated will be set to this category
		[Var] mainMenuBar = <MixinInterface:menu>
		[Var] menuDirs
		[Var] menuTitles
		[Var] menus
		[Var] rgx_prefix
		[Var] sourceDir : Root dir. Every directory within becomes its own menu
		[Var] strGlobal : This is a string value of the Global var name of the generated instance
		
		[FN] AddMacroItem
		[FN] AddPurgeMacrosCallback
		[FN] AddUnregisterCallback
		[FN] BuildAllMenus
		[FN] BuildMenu
		[FN] BuildSubMenu
		[FN] CollectScriptsFromDir
		[FN] CollectSubDirs
		[FN] CreateMenuItemFromScript
		[FN] FormatMacro
		[FN] GetButtonTextFromMacro
		[FN] GetMenuDirFromTitle
		[FN] GetMenuDirs
		[FN] GetMenuTitlesFromDirs
		[FN] GetMenus
		[FN] GetModule
		[FN] PurgeMacros
		[FN] TrimNumericPrefix
		[FN] UnRegisterAllMenus
		[FN] UnregisterMenuByName
		[FN] help
		[FN] unRegisterMenu
	
	__END__
	--------------------------------------------------------------------_END*/
	
public

	-- Required fields --
	sourceDir, -- Root dir. Every directory within becomes its own menu
	defaultCategory, -- Each macroscript generated will be set to this category
	strGlobal, -- This is a string value of the Global var name of the generated instance
	
	-------------------------
	
	mainMenuBar = menuMan.getMainMenuBar(),
	menuDirs,
	menuTitles,
	menus = #(),
	
	debug = False,
	
	rgx_prefix = ( dotnetobject "System.Text.RegularExpressions.Regex" "[0-9_]" ),
	
	fn TrimNumericPrefix str =
	(
		/*DOC_--------------------------------------------------------------------
		Trims the numeric prefix from the inputed string
		
		e.g. trims "00_" from the string
		
		The numeric prefix is used to put the tools in a specific order on the menu
		
		Args:
			str (string)
		
		Returns:
			(string)
		
		--------------------------------------------------------------------_END*/
		
		local out = str
		local extent = 0
		
		for i = 1 to 4 do -- only check the first 4 characters of the string
		(
			::Logger.debug "[TrimNumericPrefix] Testing character: {1}" args:#(str[i]) cls:this
			
			if not ( this.rgx_prefix.IsMatch str[i] ) then exit -- end the loop if the prefix doesn't match the RGX
			
			extent += 1
			
			::Logger.debug "[TrimNumericPrefix] resulting string: {1}" args:#(out) cls:this
		)
		
		if ( extent != 0 ) then
		(
			out = ( replace out 1 extent "" )
		)
		
		out
	),
	
	fn CollectSubDirs dir =
	(
		/*DOC_--------------------------------------------------------------------
		Collects the direct subdirectories of the inputed dir
		non-recursive
		
		Args:
			dir (string)
		
		Returns:
			RETURNDATA: (type)
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "CollectSubDirs {1}" args:#(dir) cls:this
		
		if ( DoesFileExist dir ) then
		(
			GetDirectories ( dir + "*" )
		)
		else
		(
			::Logger.error "Inputed directory does not exist: {1}" args:#(dir) cls:this
			#() -- return an empty array
		)
	),
	
	fn GetMenuDirs =
	(
		/*DOC_--------------------------------------------------------------------
		Collects all the directories in the root of the sourceDir
		All directories here will be a menu added to the main menu bar
		
		Returns:
			array[string]
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "GetMenuDirs" args:#() cls:this
		
		this.menuDirs = this.CollectSubDirs this.sourceDir
	),
	
	fn GetMenuTitlesFromDirs =
	(
		/*DOC_--------------------------------------------------------------------
		Must be run post GetMenuDirs
		The directory names will be the title of the menus
		
		Returns:
			array[string]
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "GetMenuTitlesFromDirs" args:#() cls:this
		
		this.menuTitles = for dir in ( this.GetMenuDirs() ) collect ( TrimRight ( pathConfig.stripPathToLeaf dir ) "\\" )
	),
	
	fn GetMenuDirFromTitle title =
	(
		/*DOC_--------------------------------------------------------------------
		A reverse lookup. Get the directory of the menu from it's title
		
		Args:
			ARG1 (type)
		
		Returns:
			string | undefined : undefined if no menu dir matches the inputed title
		
		--------------------------------------------------------------------_END*/
		
		local out = for dir in this.menuDirs where ( MatchPattern ( pathConfig.stripPathToLeaf dir ) pattern:( title + "\\" ) ) collect dir
		
		if out.count != 0 then 
		(
			out[1]
		)
		else
		(
			undefined
		)
	),
	
	fn GetMenus =
	(
		/*DOC_--------------------------------------------------------------------
		Creates the main menu items for each collected title/dir
		Must be run post GetMenuTitlesFromDirs
		
		The menus at this point are just empty menu objects.
		Menus are fully populated by the BuildMenu method.
		
		Returns:
			array[<MixinInterface:menu>]
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "GetMenus" args:#() cls:this
		
		this.menus = #() -- clear menus array
		
		for title in this.menuTitles do
		(
			this.UnregisterMenuByName title -- remove any menus with the same name
			
			local newMenu = menuMan.createMenu title
			append this.menus newMenu
		)
		
		this.menus
	),
	
	fn CollectScriptsFromDir dir =
	(
		/*DOC_--------------------------------------------------------------------
		Collects all MaxScript files from the inputed directory
		
		Supprts .MS and .MSE file formats
		
		All collected files will become menu items
		
		Args:
			dir (string)
		
		Returns:
			array[string]
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "CollectScriptsFromDir {1}" args:#(dir) cls:this
		
		local out = #()
		
		if ( dir != undefined ) and ( DoesFileExist dir ) then
		(
			out = ( GetFiles ( dir + "*.ms*" ) )
		)
		
		if out.count != 0 then sort out
		
		out
	),
	
	fn GetButtonTextFromMacro sFile =
	(
		/*DOC_--------------------------------------------------------------------
		When laying out the script files for the menu items designers can place
		a commented line of text in the script file that will be used as the title 
		of the menu item
		
		example -> --buttontext:"Item Title"
		
		if this commented string is not found then the name of the file will be 
		used as the menu item title
		
		Args:
			sFile (string) : Path to script file
		
		Returns:
			string
		
		--------------------------------------------------------------------_END*/
		
		if ( DoesFileExist sFile ) then
		(
			local str = OpenFile sFile mode:"r"
			local mString = ""
			
			while not ( eof str ) do
			(
				local iLine = readLine str
				
				if ( MatchPattern iLine pattern:"*buttontext:*" ) then
				(
					Close str
					local colonLocation = FindString iLine ":"
					mString = Replace iLine 1 colonLocation ""
					mString = SubstituteString mString "\"" ""
					
					exit
				)
			)
			
			Close str
			
			mString
		)
		else
		(
			messageBox "Macro file provided does not exist" title:"File Does Not Exist:"
		)
	),
	
	fn FormatMacro macroName sFile category:this.defaultCategory buttonText:"" =
	(
		/*DOC_--------------------------------------------------------------------
		Formats a simple macro for the menu items that is registered to the
		supplied category for us to easily track.
		
		The macro simply does a FileIn of the supplied script file
		
		Args:
			macroName (string)
			sFile (string)
		
		Kwargs:
			category (string)
			buttonText (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		/* 
		
		*/
		local str = StringStream ""
		
		format "
macroScript %
category:\"%\" 
buttonText:\"%\"
(
	on execute do  
	(
		FileIn @\"%\"
	)
)
		" macroName category buttonText sFile to:str
		
		seek str 0
		readExpr str
	),
	
	fn AddMacroItem menu macroName macroCategory macroText =
	(
		/*DOC_--------------------------------------------------------------------
		Add a menu item from the provided macro name and category to the provided menu
		Macro must be created before running this method
		
		Args:
			menu (<MixinInterface:menu>)
			macroName (string)
			macroCategory (string)
			macroText (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		local menuAction = menuMan.createActionItem macroName macroCategory
		menuAction.setTitle macroText
		menuAction.setUseCustomTitle true
		menu.addItem menuAction -1
	),
	
	fn PurgeMacros category:this.defaultCategory =
	(
		/*DOC_--------------------------------------------------------------------
		 Removes the auto-generated macros created by this lib
		
		Kwargs:
			category (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "PurgeMacros category:{1}" args:#(category) cls:this
		
		local libMacros = GetFiles (( GetDir #UserMacros ) + "\\" + category + "*.mcr" )
		if libMacros != undefined then for f in libMacros do DeleteFile f
	),
	
	fn CreateMenuItemFromScript menu script =
	(
		/*DOC_--------------------------------------------------------------------
		Creates a menu item in the inputed menu from the inputed script
		
		Designers can create empty .ms files named "<numeric prefix>_sep.ms" in sequence with the rest of the menu items.
		Macros will not be created for these files, but instead a Menu Separated will be created
		
		Args:
			menu (<MixinInterface:menu>)
			script (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		local macroName = this.TrimNumericPrefix ( GetFileNameFile script )
		
		if macroName == "sep" then
		(
			-- simple trick to programatically create separators in the menu
			local sepItem = menuMan.createSeparatorItem()
			menu.addItem sepItem -1
		)
		else
		(
			local buttonText = this.GetButtonTextFromMacro script
			if ( buttonText == undefined ) or ( buttonText == "" ) then
			(
				buttonText = macroName
			)
			
			this.FormatMacro macroName script category:this.defaultCategory buttonText:buttonText
			this.AddMacroItem menu macroName this.defaultCategory buttonText
		)
	),
	
	fn BuildSubMenu menu dir =
	(
		/*DOC_--------------------------------------------------------------------
		This method handles directories within the primary menu dirs
		Sub menus are created for each subsequent directory within the tree
		This method is recursive
		
		Args:
			menu (<MixinInterface:menu>)
			dir (string)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "BuildSubMenu {1} {2}" args:#(menu, dir) cls:this
		
		local title = ( TrimRight ( pathConfig.stripPathToLeaf dir ) "\\" )
		local scriptItems = this.CollectScriptsFromDir dir
		
		local subMenu = menuMan.createMenu title
		
		for script in scriptItems do
		(
			this.CreateMenuItemFromScript subMenu script
		)
		
		local subDirs = for sdir in ( this.CollectSubDirs dir ) where not ( MatchPattern sdir pattern:"*_resource*" ) collect sdir
		
		if subDirs.count != 0 then
		(
			for dir in subDirs do
			(
				this.BuildSubMenu subMenu dir
			)
		)
		
		if ( scriptItems.count == 0 ) and ( subDirs.count == 0 ) then
		(
			return False
		)
		
		menu.addItem ( menuMan.createSubMenuItem title subMenu ) -1
	),
	
	fn BuildMenu menu =
	(
		/*DOC_--------------------------------------------------------------------
		This is the logic to build out the inputed menu and add it to the main menu bar
		
		Args:
			menu (<MixinInterface:menu>)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "BuildMenu {1}" args:#(menu) cls:this
		
		local title = menu.GetTitle()
		
		::Logger.debug "title: {1} {2}" args:#(title) cls:this
		
		local menuDir = this.GetMenuDirFromTitle title
		
		local scriptItems = this.CollectScriptsFromDir menuDir
		
		for script in scriptItems do
		(
			this.CreateMenuItemFromScript menu script
		)
		
		local subDirs = for dir in ( this.CollectSubDirs menuDir ) where not ( MatchPattern dir pattern:"*_resource*" ) collect dir
		
		if subDirs.count != 0 then
		(
			for dir in subDirs do
			(
				this.BuildSubMenu menu dir
			)
		)
		
		local newMenu = menuMan.createSubMenuItem title menu
		this.mainMenuBar.addItem newMenu -1
		menuMan.updateMenuBar()
	),
	
	fn BuildAllMenus =
	(
		/*DOC_--------------------------------------------------------------------
		Loop through all of the generated menus and build them out and add them
		to the main menu bar.
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.debug "BuildAllMenus" args:#() cls:this
		::Logger.debug "Menus: {1}" args:#(this.menus) cls:this
		
		for menu in this.menus do
		(
			this.BuildMenu menu
		)
	),
	
	fn UnregisterMenu menu =
	(
		/*DOC_--------------------------------------------------------------------
		Removes the inputed menu from menuMan ( The Menu Manager Interface )
		
		Args:
			menu (<MixinInterface:menu>)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "UnregisterMenu {1}" args:#(menu) cls:this
		
		local menuName = menu.GetTitle()
		local sMenu = menuMan.findMenu menuName
		
		if sMenu != undefined then
		(
			try( menuMan.unRegisterMenu sMenu )catch()
			menuMan.updateMenuBar()
		)
		else
		(
			::Logger.error "Menu not found in menuMan" args:#() cls:this
		)
	),
	
	fn UnregisterMenuByName menuName =
	(
		::Logger.info "UnregisterMenuByName {1}" args:#(menuName) cls:this
		
		local menu = menuMan.findMenu menuName
		if ( menu != undefined ) then this.UnregisterMenu menu
	),
	
	fn UnRegisterAllMenus =
	(
		/*DOC_--------------------------------------------------------------------
		Unregisters each of the menus generated by this lib and stored
		in the menus property
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "UnRegisterAllMenus" args:#() cls:this
		
		for menu in this.menus do
		(			
			this.UnregisterMenu menu
		)
	),
	
	fn AddUnregisterCallback strGlobal:this.strGlobal =
	(
		/*DOC_--------------------------------------------------------------------
		This adds a callback that is called at #preSystemShutdown that unregisters the
		menus generated by this utility
		
		Kwargs:
			strGlobal (string) : string value of the global variable storing the Menu_Lib instantiation
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "AddUnregisterCallback" args:#() cls:this
		
		local str = stringStream ""
		format "callbacks.addScript #preSystemShutdown \"::%.UnRegisterAllMenus()\" id:( ( \"%_unregister\" ) as name)" strGlobal strGlobal to:str
		
		if this.debug then format "!!!!! Callback String: % !!!!!\n" (str as string)
		
		seek str 0
		readExpr str
	),
	
	fn AddPurgeMacrosCallback strGlobal:this.strGlobal =
	(
		/*DOC_--------------------------------------------------------------------
		This adds a callback that is called at #preSystemShutdown that deletes all
		of the local macroscripts generated by this utility
		
		Kwargs:
			strGlobal (string) : string value of the global variable storing the Menu_Lib instantiation
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "AddPurgeMacrosCallback" args:#() cls:this
		
		local str = stringStream ""
		format "callbacks.addScript #preSystemShutdown \"::%.PurgeMacros()\" id:( ( \"%_purgeMacros\" ) as name)" strGlobal strGlobal to:str
		if this.debug then format "!!!!! Callback String: % !!!!!\n" (str as string)
		seek str 0
		readExpr str
	),
	
	fn GetModule =
	(
		/*DOC_--------------------------------------------------------------------
		Get the full path to the current MaxScript file
		
		Returns:
			String
		--------------------------------------------------------------------_END*/
		
		( GetSourceFileName() )
	),
	
	fn Help _fn: =
	(
		/*DOC_--------------------------------------------------------------------
		Get help on the current module or a specific function
		
		Kwargs:
			_fn (string) : Name of the internal method as a string
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::mxs.GetScriptHelp ( GetSourceFileName() ) _fn:_fn
	),
	
private
	
	fn _init =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if ( this.sourceDir == undefined ) or not ( DoesFileExist this.sourceDir ) then
		(
			::Logger.error "Menu_Lib instance requires a valid sourceDir" cls:this
			return False
		)
		
		if ( this.defaultCategory == undefined ) or ( this.defaultCategory == "" ) then
		(
			::Logger.error "Menu_Lib requires a valid defaultCategory for the macroscripts" cls:this
			return False
		)
		
		if ( this.strGlobal == undefined ) or ( this.strGlobal == "" ) then
		(
			::Logger.error "Menu_Lib requires a valid strGlobal in order to unregister the menus properly" cls:this
			return False
		)
		
		this.PurgeMacros()
		this.GetMenuTitlesFromDirs()
		this.GetMenus()
		this.BuildAllMenus()
		
		this.AddUnregisterCallback()
		this.AddPurgeMacrosCallback()
	),
	
	__init__ = this._init()
)



/********  Example init  *****************

(
	local menuDir = ( ( ::mxs.GetCodePath() ) + @"\lib\userinterface\menus\"  )
	
	global MXS_MENUS = ::Menu_Lib sourceDir:menuDir defaultCategory:"mxs" strGlobal:"MXS_MENUS"
)


****************************************/
