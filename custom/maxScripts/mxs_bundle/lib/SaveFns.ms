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


::SaveFns = ""


mxs.using "Logger"
mxs.using "DotNetUi"


struct SaveFns
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	Various methods for common file save logic
	
	Members:
		[FN] CancelShutdown
		[FN] GetModule
		[FN] LaunchBackburnerSlave
		[FN] LaunchDeadlineSlave
		[FN] SaveAndCloseMax
		[FN] SaveAndClose_ui
		[FN] SaveAndRestart
		[FN] SaveAndShutdown
		[FN] SaveIncrement
		[FN] SaveMajorVersion
		[FN] VerPadding
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public

	fn VerPadding base_number: digit_count:3 =
	(
		/*DOC_--------------------------------------------------------------------
		Pads the inputed base_number with zeros up to the inputed digit_count
		
		Kwargs:
			base_number (integer)
			digit_count (integer)
		
		Returns:
			String
		
		--------------------------------------------------------------------_END*/
		
		if ( base_number != unsupplied ) then
		(
			local base_string = ""
			for x = 1 to (digit_count - ( base_number as string ).count) do ( base_string = base_string + "0" )
			( base_string + ( base_number as string ))
		)
		else
		(
			::Logger.error "VerPadding function requires a valid base_number passed as keyword" args:#() cls:this
		)
	),
	
	fn SaveIncrement filepath: filename: save_to_dir:"_incrementalSave" increment_separator:"_" useNewFile:True =
	(
		/*DOC_--------------------------------------------------------------------
		This takes the currently opened file and moves it to the derived directory
		and renames it with an incremented padding. It then creates a fresh
		save file at the original location.
		
		This logic never overwrites an existing file so there is no risk of data loss
		if a crash occurs during the save.
		
		Kwargs:
			filepath (string): Path to the root directory of the increment directory
			filename (string): Base name of the increment file without the increment padding
			save_to_dir (string): directory name of the directory with all the incremented files
			increment_separator (string): character used to separator the increment number from base name
			useNewFile (boolean): Matching flag for the MaxScript SaveMaxFile function
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "SaveIncrement filepath:{1} filename:{2} save_to_dir:{3} increment_separator:{4} useNewFile:{5}" \
							args:#(filepath, filename, save_to_dir, increment_separator, useNewFile) cls:this
		
		if ( filepath == unsupplied ) then filepath = maxfilepath
		if ( filename == unsupplied ) then filename = maxfilename
		
		if filepath == "" then
		(
			return ( MessageBox "You'll need to save your Max file before you can incrementl" title:"GTVFX: Error" )
		)
		
		MakeDir ( filepath + save_to_dir )
		
		local maxPreName = GetFileNameFile filename
		local verSaveFiles = ( Getfiles ( filepath + save_to_dir + "\\" + maxPreName + increment_separator + "*.max" ))
		local verSaveFilesArr = for v in verSaveFiles collect ( GetFileNameFile v )
		local verNum = ( verSaveFilesArr.count + 1 )
			
		verNum = this.VerPadding base_number:verNum digit_count:4
		
		local verMaxFileName = filepath + save_to_dir + "\\" + maxPreName  + increment_separator + verNum + ".max"
		local newSaveFile = filepath + filename
			
		::Logger.debug "Saveing Increment to: {1}" args:#(verMaxFileName) cls:this
		
		-- move the current file to the increment dir and rename it
		RenameFile newSaveFile verMaxFileName
			
		-- save the new file
		SaveMaxFile newSaveFile useNewFile:useNewFile
		
		::Logger.info "SaveIncrement Successful" cls:this
	),
	
	fn CancelShutdown =
	(
		/*DOC_--------------------------------------------------------------------
		Sends a dos commnad to cancel the Windows shutdown process
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		dosCommand "shutdown /a"
	),
	
	fn LaunchDeadlineSlave =
	(
		/*DOC_--------------------------------------------------------------------
		Attempts to launch deadlineSlave.exe
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if not ( shellLaunch "deadlineSlave.exe" "" ) then messageBox "Unable to lauch Deadline Slave." title:"ERROR: Application Launch Error"
	),
	
	fn LaunchBackburnerSlave =
	(
		/*DOC_--------------------------------------------------------------------
		Attempts to launch Slave.exe
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if not ( shellLaunch "Slave.exe" "" ) then messageBox "Unable to lauch Backburner Slave." title:"ERROR: Application Launch Error"
	),
	
	fn SaveAndCloseMax slave_dl:false slave_bb:false=
	(
		/*DOC_--------------------------------------------------------------------
		Runs SaveIncrement with default flags then closes the 3dsmax applicaiton
		
		Kwargs:
			slave_dl (boolean) : If true will attempt to launch Deadline slave prior to shutdon
			slave_bb (boolean) : If true will attempt to launch Backburner slave prior to shutdon
		
		Returns:
			VOID
		
		See Also:
			SaveIncrement
			LaunchDeadlineSlave
			LaunchBackburnerSlave
			
		
		--------------------------------------------------------------------_END*/
		
		this.SaveIncrement()
		if slave_dl then this.LaunchDeadlineSlave()
		else if slave_bb then this.LaunchBackburnerSlave()
		quitMax #noPrompt
	),
	
	fn SaveAndRestart =
	(
		/*DOC_--------------------------------------------------------------------
		Runs SaveIncrement with default flags and then starts a 30 second timer to
		restart the machine and closes the 3dsmax applicaiton.
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		this.SaveIncrement()
		dosCommand "shutdown -t 30 -f -r -d up:125:1 -c \"Save & Close By GTVFX: 30 Seconds to restart...\""
		quitMax #noPrompt
	),
	
	fn SaveAndShutdown =
	(
		/*DOC_--------------------------------------------------------------------
		Runs SaveIncrement with default flags and then starts a 30 second timer to
		shutdown the machine and closes the 3dsmax applicaiton.
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		this.SaveIncrement()
		dosCommand "shutdown -t 30 -f -s -d up:125:1 -c \"Save & Close By GTVFX: 30 Seconds to shutdown...\""
		quitMax #noPrompt
	),
	
	fn SaveAndClose_ui =
	(
		/*DOC_--------------------------------------------------------------------
		GUI to choose from options of logic to perform when while closing the application
		
		Returns:
			ro (MaxScript Dialog)
		
		--------------------------------------------------------------------_END*/
		
		rollout ro "Save & Close By GTVFX" width:300 
		(
			local self
			local clrWindow = ((colorMan.getColor #window)*255)
			local clrText = ((colorMan.getColor #text)*255)
			local ClrBackGround = ((colorMan.getColor #background)*255)
			
			group "Save And Close Options:"
			(
				dropDownList ddl_option items:#("Quit Max","Quit Max and Launch Deadline Slave","Restart","Shutdown")
			)
			
			dotNetControl dNbtn_execute "button" height:40 
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" offset:[ro.width/2-50,0]
			
			fn _init pself =
			(
				self = pself
				::DotNetUi.initDnetBtn dNbtn_execute "Save & Close" 12 colorOffsetInt:15 tooltip:"Execute the selected option."
			)
			
			on dNbtn_execute mouseClick do
			(
				case ddl_option.selected of
				(
					("Quit Max"): self.SaveAndCloseMax()
					("Quit Max and Launch Deadline Slave"): self.SaveAndCloseMax slave:true
					("Restart"): self.SaveAndRestart()
					("Shutdown"): self.SaveAndShutdown()
				)
			)
			
			on dNbtn_execute MouseEnter arg do
			(
				::DotNetUi.initToolTip dNbtn_execute dNbtn_execute.tag
			)
			
			on dNbtn_execute MouseLeave arg do
			(
				::DotNetUi.destroyToolTip()
			)
		)
		
		createDialog ro
		ro._init this
		
		ro
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
		
		-- pass
	),
	
	__init__ = _init()
)

SaveFns = SaveFns()