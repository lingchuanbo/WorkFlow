/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/20/2013
[Purpose]
Selects all objects in your scene with the Object ID specified. Filters out hidden objects.
******************************************/
struct selObjID_lib
(
	self,
	ro,
	
	fn selObjID_FN id =
	(
		clearSelection()
		objIDarr = for i in objects where i.gBufferChannel == id and i.isHidden == false collect i
		select objIDarr
	),
	fn ui =
	(
		rollout ro "Select By Object ID By GTVFX" width:220 height:95
		(
			local self
			spinner spn_id "Object ID:" type:#integer range:[0,999,1] fieldWidth:45 align:#left
			button btn_select "Slect Objects" width:200 height:40 tooltip:"Selects all objects in your scene that match the supplied Object ID."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on btn_select pressed do
			(
				self.selObjID_FN spn_id.value
			)
		)
		createDialog ro 
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog selObjID.ro)catch()
selObjID = selObjID_lib()
