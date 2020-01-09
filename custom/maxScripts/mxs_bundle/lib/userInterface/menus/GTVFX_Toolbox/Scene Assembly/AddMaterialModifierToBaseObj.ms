/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/21/2013
[Purpose]
Assigns a Material Modifier to the bottom level of the Modifier Stack with an option to collapse to the modifier once applied.
Usefule for quickly changing the MatID for an entire mesh while preserving the modifier stack.
[KEYWORDS]
Material, Modifier
__END__
******************************************/
struct addMatModToBaseObj_lib
(
	self,
	ro,
	fn addMatModToBaseObj newMatID collapseMesh:true= 
	(
		selArray = for obj in selection where superclassof obj.baseobject == geometryClass and isGroupMember obj == false collect obj
		for obj in selArray do
		(
			addModifier obj (Materialmodifier materialID:newMatID) before:obj.modifiers.count
			if collapseMesh then maxOps.CollapseNodeTo obj obj.modifiers.count off
		)
		select selArray
	),
	fn ui =
	(
		rollout ro "Add Material Mod to BaseObject By GTVFX" width:300 height:120
		(
			local self
			group "Set Material ID" 
			(
				spinner spn_MatID range:[1,999,1] fieldWidth:80 type:#integer align:#left across:2
				checkBox chk_collapse ":Collapse To Modifier" checked:true toolTip:"Check if you want to collapse the object to this modifier after it's applied.\n This will preserve the modifier stack."
			)
			button btn_SetMatID "Add Material Modifier" width:250 height:40 tooltip:"Adds a material modifier below all other modifiers in the stack.\nIf the option is checked this will then collapse this modifier into the object keeping all existing modifiers."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on btn_SetMatID pressed do
			(
				if selection.count != 0 then
				(
					self.addMatModToBaseObj spn_MatID.value collapseMesh:chk_collapse.state
				)
				else messageBox "Select at least one object."
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
try(destroyDialog addMatMod.ro)catch()
addMatMod = addMatModToBaseObj_lib()
