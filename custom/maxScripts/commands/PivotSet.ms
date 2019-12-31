if findparent == undefined do filein "$maxScripts\\maxScripts\\lib\\findParent.ms"
try
(
	local snapstate, a
	snapstate = snapMode.active
	snapMode.active = on
	a = pickPoint snap:#3D
	targetParents = findparent selection
	for i = targetParents do i.pivot = a
	snapMode.active = snapstate
	max move
	setCoordCenter #local
)
catch()
