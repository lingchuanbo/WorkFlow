--macroScript TotalCommanderRCM
--			category:"IllusionBoxStudio"
--			tooltip:"TotalCommanderRCM"
(
	
-- CloseDialog
	try(destroydialog select_node_maps_dialog)catch()
	
-- Globals
	global all_maps_in_scene = #()
	global bitmap_tex = #()
	global bitmap_tex_list = #()
	global clean_bitmap_tex = #()
	global select_node_maps_dialog
	global get_open_dir
	global get_totalcmd_dir = #()
	global get_totalcmd_dir_folder

--  本地化处理
Include "$scripts\\Startup\setEvn.ms"

	if (getfiles (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini")).count == 0 then
	(
		setinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "1" "empty"
	)
	global get_totalcmd_dir = getinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "path"
	global new_clean_array = #()
	
	fn get_all_maps_in_scene mat = 
	(
		for i = 1 to mat.numsubs do
		(
			if mat[i] != undefined then
			(
				if classof mat[i] == SubAnim then
				(
					if superclassof mat[i].object == TextureMap then
					(
						if mat[i].object != undefined then append all_maps_in_scene mat[i].object
					)
				)
				get_all_maps_in_scene mat[i]
			)
		)
	)
	
	fn clean_array arr =
	(
		global new_clean_array = #()
		if arr.count != 0 then
		(
			for i in arr do
			(
				if (findItem new_clean_array i) == 0 then append new_clean_array i
			)
		)
		return new_clean_array
	)
	
	if (GetFiles get_totalcmd_dir).count != 0 then
	(
	
	-- RCM
		rcmenu Totalcmd
		(
			menuItem version "v2.0" enabled:false
			menuItem logo "Total Commander"
			seperator sp0
			menuItem open_maxfile_dir "Open MaxFile Folder"
			menuItem open_render_dir "Open Render Folder"
			seperator sp2
			menuItem open_vray_seperate_dir "Open VraySeparate Folder"
			menuItem open_vray_rawimage_dir "Open VrayRawImage Folder"
			seperator sp3
			submenu "Materials"
			(
				menuItem sel_node_material "Selected Objects Maps"
				menuItem active_mat_slot "Active MaterialSlot Maps"
			)
			
		-- Run TotalCommander
			on logo picked do
			(
				--ShellLaunch get_totalcmd_dir ("/O /L=")
				ShellLaunch get_totalcmd_dir ("/O") 
			)

		-- Open MaxFile Folder
			on open_maxfile_dir picked do
			(
				if maxfilepath != "" then
				(
					get_open_dir = ("\"" + maxfilepath + maxfilename + "\"")
					ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
				)
				else
				(
					messagebox "Open MaxFile First"
				)
			)
		
		--Open Render Folder
			on open_render_dir picked do
			(
				if rendOutputFilename != "" then
				(
					get_open_dir = ("\"" + rendOutputFilename + "\"")
					ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
				)
				else
				(
					messagebox "Render Output is Empty"
				)
			)
			
			--Open VraySeparate Folder
			on open_vray_seperate_dir picked do
			(
				try
				(
					if renderers.current.output_splitfilename != "" then
					(
						get_open_dir = ("\"" + renderers.current.output_splitfilename + "\"")
						ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
					)
					else
					(
						messagebox "Separate Output is Empty"
					)
				)
				catch()
			)		
			
			
			--Open VrayRawImage Folder
			on open_vray_rawimage_dir picked do
			(
				try
				(
					if renderers.current.output_rawFileName != "" then
					(
						get_open_dir = ("\"" + renderers.current.output_rawFileName + "\"")
						ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
					)
					else
					(
						messagebox "RawImage Output is Empty"
					)
				)
				catch()
			)
			
			
			
		--Open ObjectMaps Folder
			on sel_node_material picked do
			(
				if selection.count != 0 then
				(
					all_maps_in_scene = #()
					bitmap_tex = #()
					bitmap_tex_list = #()
					for i in selection do
					(
						if i.material != undefined then
						(
							get_all_maps_in_scene i.material
							if all_maps_in_scene.count != 0 then
							(
								for i in all_maps_in_scene do
								(
									if classof i == Bitmaptexture then
									(
										append bitmap_tex i.filename
									)
									else if classof i == VrayHDRI then
									(
										append bitmap_tex i.HDRIMapName
									)
								)
							)
						)
					)
					if bitmap_tex.count != 0 then
					(
						clean_bitmap_tex = clean_array bitmap_tex
						for i in clean_bitmap_tex do
						(
							append bitmap_tex_list (filenameFromPath i)
						)
						
						rollout select_node_maps_dialog "Maps" 
						(
							listbox obj_maps_list "" items:bitmap_tex_list
							on obj_maps_list doubleClicked sel do
							(
								try(destroyDialog select_node_maps_dialog)catch()
								get_open_dir = ("\"" + clean_bitmap_tex[obj_maps_list.selection] + "\"")
								ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
							)
						)
						createdialog select_node_maps_dialog
					)
				)
			)
		
		--Open MaterialSlot Maps
			on active_mat_slot picked do
			(
				get_mat_slot = medit.GetActiveMtlSlot()
				
				all_maps_in_scene = #()
				bitmap_tex = #()
				bitmap_tex_list = #()
				
				get_all_maps_in_scene meditMaterials[get_mat_slot]
				if all_maps_in_scene.count != 0 then
				(
					for i in all_maps_in_scene do
					(
						if classof i == Bitmaptexture then
						(
							append bitmap_tex i.filename
						)
						else if classof i == VrayHDRI then
						(
							append bitmap_tex i.HDRIMapName
						)
					)
				)
				if bitmap_tex.count != 0 then
				(
					clean_bitmap_tex = clean_array bitmap_tex
					for i in clean_bitmap_tex do
					(
						append bitmap_tex_list (filenameFromPath i)
					)
					
					rollout select_node_maps_dialog "Maps" 
					(
						listbox obj_maps_list "" items:bitmap_tex_list
						on obj_maps_list doubleClicked sel do
						(
							try(destroyDialog select_node_maps_dialog)catch()
							get_open_dir = ("\"" + clean_bitmap_tex[obj_maps_list.selection] + "\"")
							ShellLaunch get_totalcmd_dir ("/O /S /L=" + get_open_dir)
						)
					)
					createdialog select_node_maps_dialog
				)
			)
		)
		registerRightClickMenu Totalcmd
		PopupMenu Totalcmd
	)
	else
	(
		--messagebox "Config TotalCommander Path"
		--初始化路径设置
		rcmenu Totalcmd
		(
			menuItem config_totalcmd "Find TotalCommander Path"
			on config_totalcmd picked do
			(
				local f_path = getsavepath caption:"Select TotalCommander Directory"
				if f_path != undefined then
				(
					setinisetting (symbolicPaths.expandFileName "$maxScripts\\total_commander.ini") "TotalCommander" "path" (f_path + "\\TOTALCMD.EXE.exe")
				)
			)
		)
		registerRightClickMenu Totalcmd
		PopupMenu Totalcmd
	)
)