/******************************************
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/20/2013
[Purpose]
For each object in your selection a proOptimzer modifier will be applied and calculated to the percentage you specify.
******************************************/
struct proOptimizeSelection_lib
(
	self,
	ro,
	optArr = #(),
	fn calculateProOptModifiers_FN objArr =
	(
		for i in objArr do
		(
			i.modifiers[#Auto_ProOptimizer].calculate = true
		)
	),
	fn proOptimizeSelection_FN objArr vert count:false =
	(
		cui.commandPanelOpen = false
		for obj in objArr do
		(
			if validModifier obj (ProOptimizer()) and superClassOf obj == geometryClass then
			(
				addModifier obj (ProOptimizer name:#Auto_ProOptimizer)
				if count then
				(
					obj.modifiers[#Auto_ProOptimizer].vertexCount = vert
				)
				else
				(
					obj.modifiers[#Auto_ProOptimizer].vertexPercent = vert
				)
				append optArr obj
			)
			else format "***** % is not a valid object for ProOptimizer *****\n" obj.name
		)
		cui.commandPanelOpen = true
		select optArr
	),
	fn updateOptimization objArr val count:false =
	(
		for i in objArr do
		(
			if count then
			(
				i.modifiers[#Auto_ProOptimizer].vertexCount = val
			)
			else
			(
				i.modifiers[#Auto_ProOptimizer].vertexPercent = val
			)
		)
	),
	fn collapseToProOptimizer objArr =
	(
		cui.commandPanelOpen = false
		with undo on
		(
			for i in objArr do
			(
				maxOps.collapseNodeTo i 1 off
			)
		)
		cui.commandPanelOpen = true
	),
	fn ui =
	(
		rollout ro "ProOptimize Selection By: GTVFX" width:280 height:150
		(
			local self
			spinner spn_vertex "Vertex Percent" range:[0,99999999,100] type:#float across:2 align:#left
			checkBox chk_vertCount "Vertex Count" align:#right
			button btn_apply "Apply to Selection" width:250 height:45 tooltip:"Adds the Pro-Optimize modifier and calculates it with the supplied settings.\nThis interface can then update the modifiers in realtime once calculated."
			button bt_collapse "Collapse Optimized Objects" width:250 height:45 tooltip:"This will collapse all modifiers into the mesh."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn init pself =
			(
				self = pself
			)
			on chk_vertCount changed state do
			(
				if state then spn_vertex.text = "Vertex Count" else spn_vertex.text = "Vertex Percent"
			)
			on spn_vertex changed val do
			(
				if chk_vertCount.state then
				(
					self.updateOptimization self.optArr val count:true
				)
				else
				(
					self.updateOptimization self.optArr val count:false
				)
			)
			on btn_apply pressed do
			(
				if chk_vertCount.state then
				(
					self.proOptimizeSelection_FN (getCurrentSelection()) spn_vertex.value count:true
					self.calculateProOptModifiers_FN self.optArr
				)
				else
				(
					self.proOptimizeSelection_FN (getCurrentSelection()) spn_vertex.value count:false
					self.calculateProOptModifiers_FN self.optArr
				)
			)
			on bt_collapse pressed do
			(
				self.collapseToProOptimizer self.optArr
			)
		)
		createDialog ro 
		ro.init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
try(destroyDialog optSel.ro)catch()
optSel = proOptimizeSelection_lib()
