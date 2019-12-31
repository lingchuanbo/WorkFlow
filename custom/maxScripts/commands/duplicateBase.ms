if selection.count != 0 then
(
	setCommandPanelTaskMode #create
	newSel = #()
	srcObjs = selection as array
	trgObjs = #()
	for i = srcObjs do
	(
		maxOps.CloneNodes i cloneType:#copy newNodes:&newSel
		newSel[1].baseobject = i.baseobject
		append trgObjs newSel[1]
	)
	trgObjsRef = #()
	maxops.clonenodes trgObjs cloneType:#reference newNodes:&trgObjsRef
	delete trgObjs
	select trgObjsRef
	setCommandPanelTaskMode #modify
	for m = srcObjs[1].modifiers.count to 1 by -1 do
	(
		try (deleteModifier trgObjsRef m)catch()
	)
)
else messagebox "Please select some objects"