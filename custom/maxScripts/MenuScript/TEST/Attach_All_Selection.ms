(
	fn openGroupsAll objs toggle1 toggle2= (
		group_arr = for o in objs where isValidNode o AND isGroupHead o collect o
	 
		with redraw off (
			for o in group_arr do (
				actionMan.executeAction 0 "40141"  -- Groups: Ungroup
				-- ungroup o
			) -- end for
		)-- end redraw
	) -- end fn

	openGroupsAll selection false true

undo "Quick_Attach" on (
macros.run "Modifier Stack" "Convert_to_Poly"
	b = attachAll()

)

)