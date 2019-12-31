(
	if selection.count != 0 then
	(
		tempObjArray = for i = $ where i.modifiers.count != 0 collect i
		if tempObjArray.count > 0 then
		(
			setCommandPanelTaskMode #modify
			global stanModifierArray
			stanModifierArray = #()
			rollout copyModifier "copyModifier"
			(
				button okButton "Copy selected modifier"
				MultiListBox modifierList "modifierList:" height:(tempObjArray[tempObjArray.count].modifiers).count selection:#{1..((tempObjArray[tempObjArray.count].modifiers).count)} items:(for m = tempObjArray[tempObjArray.count].modifiers collect m.name)
				on okButton pressed do
				(
					for i = (modifierList.selection as array) do
					(
						append stanModifierArray tempObjArray[tempObjArray.count].modifiers[i]
					)
					DestroyDialog copyModifier
				)
			)
			createDialog copyModifier pos:mouse.screenpos()
		)
		else messagebox "No valid modifier!"
	)
	else messagebox "Please select some object!"
)