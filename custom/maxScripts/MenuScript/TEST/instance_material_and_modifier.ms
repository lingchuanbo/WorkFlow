MacroScript Instance_Material_and_Modifiers_Tools
tooltip:"Instance Material. +SHIFT: Instance Mat and All Modifiers. +CTRL: Instance Mat and Align Modifier. +ALT: Delete Mat and All Modifiers."
category:"_My Scripts_"
Icon:#("Material_Modifiers",3)
(
	on isEnabled return(selection.count > 0)
/*
How it Works :
 1 - Select one objcet (Main Object) with Material and Modifier you want to Apply to Other Objcets
 2 - Run the Script and Select All Objects you want to Apply the Material and Modifier to it then Right Click .
 
 *Note 1: When Using (Instance Mat and Align Modifier) Script , the Instanced Modifier Should be on Top of Modifier Stack of the Main Object.
 *Note 2: (Delete Mat and All Modifiers) Apply on Selected Objects (No Need to Pick any Object) 
*/
	
--( FUNCTIONS	
	fn open_groups arr = (
		for obj in arr where arr.count != 0 and isGroupMember obj and (NOT isOpenGroupMember obj) do (
			par = obj.parent ; while par != undefined do (
				if isGroupHead par then (setGroupOpen par true ; par = undefined) else par = par.parent
			)
		)
	)
	fn sel_Ins_Md md = (
		objslist = #()
		for i in Geometry where i.modifiers[1] == md do try(appendIfUnique objslist i ; deleteModifier i 1)catch()
		open_groups objslist
		select objslist
		old_center = selection.center
		if hasProperty md "Gizmo" then Modpos = md.Gizmo.pos else
		if hasProperty md "slice_plane" then Modpos = md.slice_plane.pos else
		if hasProperty md "Mirror" then Modpos = md.Mirror.pos else
		Modpos = undefined
	)
	fn set_all_Md arr obj = (
		for o in arr do (
			for i = obj.modifiers.count to 1 by -1 do try(addModifier o obj.modifiers[i])catch()
		)
	)
	fn set_Mat_Wr arr obj = (
		for i in arr do (
			i.material = obj.material
			i.wirecolor = obj.wirecolor
		)
	)
	fn del_Mat_Md arr = (
		for i in arr do try(i.material = undefined)catch()
		if queryBox "Delete All Modifiers ?" beep:false then (
	     	for i in arr where i.modifiers.count > 0 do (
				for j = i.modifiers.count to 1 by -1 do try(deleteModifier i j)catch()
			)
		)
	)
--)
	on execute do with undo "Get Modifier" on (
      	local objslist = #() , selmodlist = #() , selobjMod = #() , selobjs = #() , pobjs = #()
      	local Modpos , old_center , new_center
       	local pobjs = getCurrentSelection()
		if keyboard.altPressed then (
			del_Mat_Md pobjs ; CompleteRedraw()
		)
		else if keyboard.controlPressed then (
			selobj = pickobject message:"Pick Object to Get its Material and First Modifier"
			if selobj != #escape and selobj != undefined and pobjs.count != 0 then (
				max modify mode
				tobjs = for i in pobjs where (classof i != TargetObject and (superclassof i == geometryclass or superclassof i == shape)) collect i
				set_Mat_Wr tobjs selobj 
				if selobj.modifiers[1] != undefined then (
					selobjMod = selobj.modifiers[1]
					sel_Ins_Md selobjMod ; selectmore tobjs
					modPanel.addModToSelection selobjMod ui:on
					new_center = selection.center
					if Modpos != undefined then (
						Modpos += old_center - new_center
						if hasProperty selobjMod "Gizmo" then selobjMod.Gizmo.pos = Modpos else
						if hasProperty selobjMod "slice_plane" then selobjMod.slice_plane.pos = Modpos else
						if hasProperty selobjMod "Mirror" then selobjMod.Mirror.pos = Modpos
					)
					try(max group close)catch()
					select tobjs
					CompleteRedraw()
				)
				else select pobjs
			)
		)
		else if keyboard.shiftPressed then (
			selobj = pickobject message:"Pick Object to Get its Material and All Modifiers"
			if selobj != #escape and selobj != undefined and pobjs.count != 0 then (
				max modify mode
				tobjs = for i in pobjs where (classof i != TargetObject and (superclassof i == geometryclass or superclassof i == shape)) collect i
				set_Mat_Wr tobjs selobj ; set_all_Md tobjs selobj
				CompleteRedraw()
			)
			else select pobjs
		)
		else (
			selobj = pickobject message:"Pick Object to Get its Material"
			if selobj != #escape and selobj != undefined and pobjs.count != 0 then (
				tobjs = for i in pobjs where (classof i != TargetObject and (superclassof i == geometryclass or superclassof i == shape)) collect i
				set_Mat_Wr tobjs selobj
				CompleteRedraw()
			)
		)
	)
	clearListener()
)
-----------------------------------------------------------------------------------------------
MacroScript Delete_Mat_and_All_Modifiers
tooltip:"Delete Mat and All Modifiers"
category:"_My Scripts_"
Icon:#("Material_Modifiers", 6)
(
	on isEnabled return(selection.count > 0)

-- How it Works : Select All Objects you want to Delete the Material and All Modifiers from it then Run the Script .

	on execute do with undo "Delete Modifiers" on (
		local pobjs = getCurrentSelection()
		for i in pobjs do try(i.material = undefined)catch()
		if queryBox "Delete All Modifiers ?" beep:false then (
	     	for i in pobjs where i.modifiers.count > 0 do (
				for j = i.modifiers.count to 1 by -1 do try(deleteModifier i j)catch()
			)
		)
		CompleteRedraw()
	)	
)
-----------------------------------------------------------------------------------------------
MacroScript Instance_Mat_and_Align_Modifier
tooltip:"Instance Mat and Align Modifier"
category:"_My Scripts_"
Icon:#("Material_Modifiers",3)
(
	on isEnabled return(selection.count > 0)

/*
How it Works :
 1 - Select one objcet (Main Object) with Material and Modifier you want to Apply to Other Objcets
 2 - Run the Script and Select All Objects you want to Apply the Material and Modifier to it then Right Click .
 *Note : the Instanced Modifier Should be on Top of Modifier Stack of the Main Object
*/
	
	fn open_groups arr = (
		for obj in arr where arr.count != 0 and isGroupMember obj and (NOT isOpenGroupMember obj) do (
			par = obj.parent ; while par != undefined do (
				if isGroupHead par then (setGroupOpen par true ; par = undefined) else par = par.parent
			)
		)
	)
	fn sel_Ins_Md md = (
		objslist = #()
		for i in Geometry where i.modifiers[1] == md do try(appendIfUnique objslist i ; deleteModifier i 1)catch()
		open_groups objslist
		select objslist
		old_center = selection.center
		if hasProperty md "Gizmo" then Modpos = md.Gizmo.pos else
		if hasProperty md "slice_plane" then Modpos = md.slice_plane.pos else
		if hasProperty md "Mirror" then Modpos = md.Mirror.pos else
		Modpos = undefined
	)
	fn set_Mat_Wr arr obj = (
		for i in arr do (
			i.material = obj.material
			i.wirecolor = obj.wirecolor
		)
	)

	on execute do with undo "Get Modifier" on (
      	local objslist = #() , selmodlist = #() , selobjMod = #() , selobjs = #()
      	local Modpos , old_center , new_center
     	local pobjs = getCurrentSelection()
		selobj = pickobject message:"Pick Object to Get its Material and First Modifier"
		if selobj != #escape and selobj != undefined and pobjs.count != 0 then (
			max modify mode
			tobjs = for i in pobjs where (classof i != TargetObject and (superclassof i == geometryclass or superclassof i == shape)) collect i
			set_Mat_Wr tobjs selobj
			if selobj.modifiers[1] != undefined then (
				selobjMod = selobj.modifiers[1] ; sel_Ins_Md selobjMod ; selectmore tobjs
				new_center = selection.center ; modPanel.addModToSelection selobjMod ui:on
				if Modpos != undefined then (
					Modpos += old_center - new_center
					if hasProperty selobjMod "Gizmo" then selobjMod.Gizmo.pos = Modpos else
					if hasProperty selobjMod "slice_plane" then selobjMod.slice_plane.pos = Modpos else
					if hasProperty selobjMod "Mirror" then selobjMod.Mirror.pos = Modpos
				)
				try(max group close)catch()
				select tobjs
			)
			CompleteRedraw()
		)
		else select pobjs
	)
	clearListener()
)