try
(
	local a, groupFlag
	a = selection as array
	groupFlag = on
	while groupFlag
	do
	(
		select a
		groupFlag = actionMan.executeAction 0 "40143"
	)
)
catch()