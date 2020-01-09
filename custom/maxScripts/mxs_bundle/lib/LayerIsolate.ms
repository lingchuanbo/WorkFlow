/***************************************************************************************************
Copyright (C) 2013 - 2017  Gavyn Thompson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. if not, see <http://www.gnu.org/licenses/>.
***************************************************************************************************/
/***************************************************************************************************
__MXSDOC__
Author: Gavyn Thompson
Company: GTVFX
Website: https://github.com/gtvfx
Email: gftvfx@gmail.com
__END__
***************************************************************************************************/


::LayerIsolate = ""


struct LayerIsolate
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This utility simulates the effects of the Isolate Selection Toggle but
	instead operates at the scope of the entire layer that the selected
	objects reside in. This logic looks at the currently selected objects and
	determines which layers those objects occupy. It then hides all other
	layers. A small dialog is generated with a toggle button to revert the
	layer states back to their previous values.
	
	Members:
		[Var] ro
		[Var] storedLayerStateArr 
		[FN] GetLayerStates
		[FN] GetModule
		[FN] IsolateLayersByObj <objArr>
		[FN] RestoreLayerStates <layerStateArr>
		[FN] help
		[FN] run
		[FN] ui
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	
	ro,
	storedLayerStateArr,
	
	fn GetLayerStates =
	(
		/*DOC_--------------------------------------------------------------------
		Stores the current layer states as nested arrays.
		#( Layer Name , Layer State)
		
		This data is used to restore the layer states after isolating
		
		
		Returns:
			storedLayerStateArr ( array[array[string, boolean]] )
		
		See Also:
			RestoreLayerStates()
		
		--------------------------------------------------------------------_END*/
		
		local out = #()
		
		for i = 0 to layerManager.count-1 do
		(
			local iLayer = layerManager.getLayer i
			append out #(iLayer.name, iLayer.on)
		)
		
		out
	),
	
	fn RestoreLayerStates layerStateArr =
	(
		/*DOC_--------------------------------------------------------------------
		Uses the nested array data of the storedLayerStateArr to set
		the state of all layers back to what they were at the time the data
		was captured
		
		Args:
			layerStateArr (Nested array data)
		
		--------------------------------------------------------------------_END*/
		
		if layerStateArr != undefined and layerStateArr.count != 0 then
		(
			for i in layerStateArr do
			(
				( layerManager.getLayerFromName i[1] ).on = i[2]
			)
		)
		else 
		(
			format "***** Error with layerStateArr: % *****\n" layerStateArr
		)
	),
	
	fn IsolateLayersByObj objArr =
	(
		/*DOC_--------------------------------------------------------------------
		Loops through the objects in the inputed objArr and collects all the 
		unique layers. Then loops through all the layers in the LayerManager
		and turns off all layers not used by object in the objArr.
		
		Args:
			objArr (array[Node])
		
		Returns:
			(boolean) : True on success
		
		--------------------------------------------------------------------_END*/
		
		objArr = ::mxs.EnsureArgIsArray objArr
		
		if objArr.count != 0 then
		(
			local layerArr = #()
			
			for obj in objArr do
			(
				appendIfUnique layerArr obj.layer
			)
			
			for i = 0 to layerManager.count-1 do
			(
				local iLayer = layerManager.getLayer i
				if ( findItem layerArr iLayer == 0 ) then iLayer.on = false
			)
			
			True
		)
		else
		(
			messageBox "Nothing selected... :(" title:"GTVFX:"
			False
		)
	),

	fn Ui =
	(
		/*DOC_--------------------------------------------------------------------
		Constructs the MaxScript Rollout that connects logic back to the
		main struct.
		
		Returns:
			ro (Constructed MaxScript Rollout)
		
		--------------------------------------------------------------------_END*/
		
		rollout ro "Layer Isolate By GTVFX" width:180
		(
			local self
			checkButton cBtn_isolate "Layers Isolated" checked:true width:(ro.width-20) height:40 
			
			fn _init pself =
			(
				self = pself
			)
			
			fn ExitIso =
			(
				self.RestoreLayerStates self.storedLayerStateArr
				destroyDialog ro
			)
			
			on cBtn_isolate changed arg do
			(
				ExitIso()
			)
			
			on ro_layIso moved pos do
			(
				try( SetIniSetting ::mxs.uiSettingsIni "layIso_UI" "Position" ( pos as string ) )catch()
			)
			
			on ro_layIso close do
			(
				ExitIso()
			)
		)
		
		local roPos = [850,420]
		
		if ::mxs != undefined then
		(
			if ( DoesFileExist ::mxs.uiSettingsIni ) and ( HasIniSetting ::mxs.uiSettingsIni "layIso_UI" "Position" ) then
			(
				roPos = ( execute ( GetIniSetting ::mxs.uiSettingsIni "layIso_UI" "Position" ) ) 
			)
			else 
			(
				roPos = [850,420]
			)
		)
		
		createDialog ro pos:roPos
		ro._init this
	),
	
	fn Run =
	(
		/*DOC_--------------------------------------------------------------------
		Performs the necessary logic to store the current layer states and
		constructs the UI to toggle the layer isolation
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.storedLayerStateArr = this.GetLayerStates()
		
		if not ( this.IsolateLayersByObj ( GetCurrentSelection() ) ) then return false
		
		this.Ui()
	),
	
	fn GetModule =
	(
		/*DOC_--------------------------------------------------------------------
		Get the full path to the current MaxScript file
	
		Returns:
			String
		--------------------------------------------------------------------_END*/
	
		( GetSourceFileName() )
	),
	
	fn Help _fn: =
	(
		/*DOC_--------------------------------------------------------------------
		Get help on the current module or a specific function
	
		Kwargs:
			_fn (string) : Name of the internal method as a string
	
		Returns:
			VOID
	
		--------------------------------------------------------------------_END*/
	
		::mxs.GetScriptHelp ( GetSourceFileName() ) _fn:_fn
	),

private
	
	fn _init =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		-- Pass
	),

	__init__ = _init()
)

LayerIsolate = LayerIsolate()