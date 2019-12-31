if findparent == undefined do
(
	filein "E:\\BoBOAHK\\3DsMaxkey\\maxScriptFunction\\findParent.ms"
)
(
	op1 = pickpoint prompt:"pick object point 1\n" snap:#3D
	op2 = pickpoint prompt:"pick object point 2\n" snap:#3D rubberBand:op1
	r1 = matrixFromNormal(normalize(op2-op1))
	toolMode.coordsys #local
	if selection.count > 1 or selection[1].children.count > 0 then
	(
		tempObj = (findParent selection)[1]
		rotValInv=  ((r1 as quat) * tempObj.rotation)
		tempObj.objectoffsetrot *= rotValInv
		ResetPivot tempObj
	)
	else
	(
		tempObj = selection[1]
		rotValInv= inverse ((r1 as quat) * tempObj.rotation)
		in coordsys tempObj tempObj.rotation *= rotValInv
		tempObj.objectoffsetrot *= rotValInv
		tempObj.objectoffsetpos *= rotValInv
	)
	tempObj.pivot=op1
)
