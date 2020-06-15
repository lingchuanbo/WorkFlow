fn UTIL_trnsfrmLockToggle_FN =
(
	if (getTransformLockFlags selection[1])[1] == false then
	(
		for i in selection do setTransformLockFlags i #all
		format "***** Transform Locked *****\n"
	)
	else
	(
		for i in selection do setTransformLockFlags i #none
		format "***** Transform Unlocked *****\n"
	)
)
if selection.count == 1 then
	(
		UTIL_trnsfrmLockToggle_FN()
	)
	else 
	(
		messagebox "请选择对象操作"

	)