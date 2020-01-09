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


::FileFns = ""


struct FileFns
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	A collection of methods for working with files
	
	Members:
		[FN] CopyMaxFilePathToClipboard
		[FN] GetLatestFile
		[FN] GetModule
		[FN] OpenMaxFileLocation
		[FN] OpenRenderLocation
		[FN] OpenTempDir
		[FN] TransferFiles
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	fn TransferFiles _fromDir: _toDir: fileArr:#all deleteAfter:False =
	(
		/*DOC_--------------------------------------------------------------------
		Copies files from _fromDir to the _toDir
		
		You can provide a specific list of files to transfer from the director or
		leave the fileArr flag set to the default of #all.
		
		Kwargs:
			_fromDir (string) : Directory to find the files to copy
			_toDir (string) : Destination directory for copied files
			fileArr (#all | array[string]) : List of specific file from the directory or #all
			deleteAfter (boolean) : If true, deletes the files from the _fromDir after they've been copied
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if _toDir == unsupplied then
		(
			return (messageBox "TransferFiles requires you to supply a valid directory to transfer files: use the _toDir arg" title:"Missing args:")
		)
		
		if not (DoesFileExist _toDir) then
		(
			return (messageBox "The _toDir arg supplied to TransferFiles does not exist" title:"Invalid Directory:")
		)
		
		if fileArr == #all and _fromDir == unsupplied then
		(
			return (messageBox "TransferFiles requires you to supply a valid directory to collect files to transfer: use the _fromDir arg" title:"Missing args:")
		)
		
		if fileArr == #all then
		(
			fileArr = GetFiles (_fromDir+"/*")
		)
		else
		(
			local arr = #()
				
			for i in fileArr do
			(
				local file = pathConfig.NormalizePath ( _fromDir + "\\" + i )
				
				if not DoesFileExist file then
				(
					format "***** File does not exist: % *****\n" file
				)
				else
				(
					append arr file
				)
			)
		)
		
		if fileArr.count != 0 then
		(
			for i in fileArr do
			(
				CopyFile i (_toDir + "/" + (FileNameFromPath i))
			)
		)
		
		if deleteAfter then
		(
			for i in fileArr do
			(
				deleteFile i
			)
		)
		
		
		format "***** % files transfered *****\n" fileArr.count
	),
	
	fn CopyMaxFilePathToClipboard =
	(
		/*DOC_--------------------------------------------------------------------
		Sets the Windows Clipboard text to the explicit file path of the currently opened file
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		SetClipBoardText (maxFilePath + maxFileName)
	),
	
	fn OpenMaxFileLocation =
	(
		/*DOC_--------------------------------------------------------------------
		Opens a Windows Explorer window at the path of the currently opened file
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		ShellLaunch "explorer" maxfilepath 
	),
	
	fn OpenRenderLocation =
	(
		/*DOC_--------------------------------------------------------------------
		Opens a Windows Explorer window at the path set in the Render Output
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		if DoesFileExist (GetFilenamePath rendOutputFilename) then 
		(
			ShellLaunch "explorer" (GetFilenamePath rendOutputFilename)
		)
		else
		(
			messageBox "Unable to access render path directory." title:"Error:"
		)
	),
	
	fn OpenTempDir =
	(
		/*DOC_--------------------------------------------------------------------
		Opens a Windows Explorer window at the path of the project temp directory
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		ShellLaunch "explorer" (GetDir #temp)
	),

	fn GetLatestFile filePath ext:"*" pattern:"" = 
	(
		/*DOC_--------------------------------------------------------------------
		Returns the most recent file from the inputed filePath
		
		Args:
			filePath (string) : Directory to get files from
		
		Kwargs:
			ext (string) : optional file extension flag. Only files matching this extension will be tested and returned
			pattern (string) : optional filename pattern. Only files matching this pattern in their name will be tested and returned.
		
		Returns:
			assumedLatestFile: (string)
		
		--------------------------------------------------------------------_END*/
		
		local fileList = (getfiles (filePath + "\\*." + ext))
		local assumedLatestFile = ""
		local latestWriteTime = 0L
		
		for newFile in fileList do 
		(
			if matchPattern newFile pattern:("*" + pattern + "*" ) then 
			(
				local FileInfo = dotNetObject "System.IO.FileInfo" newFile
				if FileInfo != undefined then 
				(
					local fileTime = FileInfo.LastWriteTime.Ticks
					if fileTime > latestWriteTime then 
					(
						assumedLatestFile = newFile
						latestWriteTime = FileInfo.LastWriteTime.Ticks
					)
				)
			)
		)
		
		assumedLatestFile
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
		
		-- Pass
	),

	__init__ = _init()
)

FileFns = FileFns()