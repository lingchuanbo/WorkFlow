try(UILockTimer.stop())catch()
global UILockTimer=DotnetObject "Timer"
global checkAltPresstFNForUILockTimer
global oldStateUILock = True
fn checkAltPresstFNForUILockTimer =
(

 	if  keyboard.altPressed == true then 
 	(
 		if oldStateUILock == true do 
 		(
 			max lock UI layout
 			oldStateUILock = false 
		)
	)else 
	(
		if oldStateUILock == false do 
		(
			max lock UI layout
 			oldStateUILock = true 
		)
	)
	

)

dotnet.addeventhandler UILockTimer "tick" checkAltPresstFNForUILockTimer
UILockTimer.Start()
