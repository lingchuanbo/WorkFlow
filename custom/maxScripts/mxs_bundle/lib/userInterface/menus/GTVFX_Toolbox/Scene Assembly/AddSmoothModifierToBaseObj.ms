/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/21/2013
[Purpose]
Assigns a Smooth Modifier to the bottom level of the Modifier Stack with an option to collapse to the modifier once applied.
Usefule for quickly changing the Smoothing for an entire mesh while preserving the modifier stack.
[KEYWORDS]
Smooth, Modifier
__END__
******************************************/
struct addSmoothModToBaseObj_lib
(
	self,
	ro,
	
	fn addSmoothModWithStack collapseMesh:true= 
	(
		selArray = for obj in selection where superclassof obj.baseobject == geometryClass and isGroupMember obj == false collect obj
		for obj in selArray do
		(
			addModifier obj (smooth autosmooth:on) before:obj.modifiers.count
			if collapseMesh then maxOps.CollapseNodeTo obj obj.modifiers.count off
		)
		select selArray
	),
	fn ui =
	(
		rollout ro "Add Smooth Mod to BaseObject By GTVFX" width:280 height:95
		(
			local self
			checkBox chk_collapse ":Collapse To Modifier" checked:true toolTip:"Check if you want to collapse the object to this modifier after it's applied.\n This will preserve the modifier stack."
			button btn_smooth "Add Smooth Modifier" width:250 height:40 tooltip:"Adds a smooth modifier below all other modifiers in the stack.\nIf the option is checked this will then collapse this modifier into the object keeping all existing modifiers."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on btn_smooth pressed do
			(
				self.addSmoothModWithStack collapseMesh:chk_collapse.state
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
try(destroyDialog addSmoothMod.ro)catch()
addSmoothMod = addSmoothModToBaseObj_lib()
