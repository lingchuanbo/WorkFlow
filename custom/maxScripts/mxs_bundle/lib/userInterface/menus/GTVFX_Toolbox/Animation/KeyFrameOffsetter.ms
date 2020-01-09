/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.23
Updated:				06/06/2014
[Purpose]
Offset the keyframes of all selected objects.
Offset all keyframes or just the selected keyframes
Option to ranomize the offset value for each object in selection
[KEYWORDS]
Animate, Keyframe, Keyframes, Offset, random, randomize
__END__
******************************************/
struct offsetKeyFrames_lib
(
	self,
	ro,
	
	fn bumpTime t delta =
	(
		t + delta
	),
	fn offsetKeys objArr val keyArr = --keyArr = #allKeys, #selection
	(
		mapKeys objArr bumpTime val keyArr
	),
	fn ui =
	(
		rollout ro "Keyframe Offsetter By GTVFX" width:260 height:125
		(
			local self
			checkBox chk_allKeys "All Keys" checked:true across:2
			checkBox chk_selKeys "Selected Keys"
			
			spinner spn_offset "Offset Amount:" fieldWidth:50  width:72 height:16 type:#integer range:[-10000,10000,0] align:#left across:2
			checkBox chk_rndm "Randomize" offset:[30,0]
			button btn_offsetKeys "Offset Keys"  width:(ro.width - 20) height:50
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on chk_selKeys changed state do
			(
				if state then chk_allKeys.checked = false
			)
			on chk_allKeys changed state do
			(
				if state then chk_selKeys.checked = false
			)
			on btn_offsetKeys pressed do
			(
				if chk_allKeys.state then
				(
					if chk_rndm.state then
					(
						for i in selection do
						(
							offset = random (spn_offset.value*-1) spn_offset.value
							format "***** val: % *****\n" offset
							self.offsetKeys i offset #allKeys
						)
					)
					else
					(
						self.offsetKeys selection spn_offset.value #allKeys
					)
				)
				else
				(	
					if chk_rndm.state then
					(
						for i in selection do
						(
							offset = random (spn_offset.value*-1) spn_offset.value
							format "***** val: % *****\n" offset
							self.offsetKeys i offset #selection
						)
					)
					else
					(
						self.offsetKeys selection spn_offset.value #selection
					)
				)
			)
		)
		createdialog ro
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog offsetKeyFrames.ro)catch()
offsetKeyFrames = offsetKeyFrames_lib()
