-- BoBO 2020-7-2
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


if selection.count == 0 then
	(
		messagebox "*****Please selection Object  *****"
		
	)
	else 
	(
		UTIL_trnsfrmLockToggle_FN()
	)