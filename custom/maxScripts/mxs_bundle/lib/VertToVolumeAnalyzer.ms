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
Author:				    Gavyn Thompson
Company:				GTVFX
Website:				https://github.com/gtvfx
Email:				    gftvfx@gmail.com
ScriptVersion:			
Updated:				
***************************************************************************************************/
/*
__HELP__

Constructor: VertToVolumeAnalyzer
Instantiated Global: VertToVolumeAnalyzer

[METHODS]

	CalculateVolumeVertexCount <obj>
		- Calculates the volume of the nodeLocalBoundingBox
		- returns a tuple containing the volume and the vertex count of the object
	
	GetVertToVolumeRatio <obj> multiplier:<10>
		- returns the quotient of ( vertexCount/( volume * multiplier) )

	AnalyzeObjects <objArr>
		- Gets the ratio for each object in objArr
		- Stores an array of tuples to the cacheArr parameter of the class
		- tuples contains the object and ratio
	
	GetObjsByRatio <ratio>
		- Queries the array of tuples in the cacheArr parameter
		- returns the objects with ratios that are greater than or equal to the supplied ratio
	
	Ui
		- Constructs and launches the UI
	
	Run
		- Executes the UI method


[DESCRIPTION]
Class for analyzing objects using a ratio derived from volume to vertex count.
- methods for collecting objects within a certion ratio
- purposed for finding objects that are small but dense

[USAGE]
Methods can be called individually or you can use the Run method to launch a UI

for obj in geometry where (VertToVolumeAnalyzer.GetVertToVolumeRatio obj) > 10 do delete obj

__END__
*/





/*
__HELP__


	
__END__
*/

try(destroyDialog VertToVolumeAnalyzer.ro)catch()

-- We can aggregate the Python module to Maxscript by using the python.import method
if ( ::progress_bar == undefined ) and ( ( MaxVersion() )[1] > 18000 ) then ::progress_bar = python.import "mxs.lib.widgets.progress_bar"
-- in order to use the reload() method to get changes to the python module, we'll first need to load the module into the Python instance
-- even though we've already imported the module through aggregation into Maxscript.
python.execute "from mxs.lib.widgets import progress_bar"
-- We can then call the reload method on the module
python.execute "reload(progress_bar)"



mxs.Using "DotNetUi"

struct VertToVolumeAnalyzer
(
public

	ro,
	showUi = False,
	cacheArr = #(),
	
	fn CalculateVolumeVertexCount obj =
	(
		with undo off 
		(
			if ( isProperty obj #mesh ) and ( isProperty obj.mesh #numverts ) then
			(
				local vertCount = obj.mesh.numVerts
				
				local bBox = nodeLocalBoundingBox obj
				
				local dif = ( bBox[2] - bBox[1] )
				
				local volume = abs( dif.x*dif.y*dif.z )
				
				#( volume, vertCount )
			)
			else
			(
				--format "***** % Does not have a Mesh property *****\n" obj
				undefined
			)
		)
	),
	
	fn GetVertToVolumeRatio obj multiplier:10 =
	(
		local data = this.CalculateVolumeVertexCount obj
		
		local ratio = 0
		
		if data != undefined then
		(
			local volume = data[1]
			local vertexCount = data[2]
			
			ratio = vertexCount/( volume * multiplier)
		)
		
		ratio
	),
	
	fn AnalyzeObjects objArr =
	(
		::mxs.BlockUi True
		
		this.cacheArr = #()
		
		local _progBar = ::progress_bar.Run title:"Calculating Vertex to Volume Ratio:" maximum:objArr.count
		
		--local arr = #()	
		
		for obj in objArr while not Keyboard.EscPressed do
		(
			_progBar.update_label ( "Calculating Ratio For: " + obj.name )
			
			local ratio = ( this.GetVertToVolumeRatio obj )
			
			append this.cacheArr #( obj, ratio )
			
			_progBar.step()
		)
		
		_progBar.close()
		
		::mxs.BlockUi False
	),
	
	fn GetObjsByRatio ratio =
	(
		local out = #()
		
		if this.cacheArr.count != 0 then
		(
			out = for i in this.cacheArr where not ( isDeleted i[1] ) and i[2] >= ratio collect i[1]
		)
		else
		(
			format "***** No Cached Objects *****\n"
		)
		
		out
	),
	
	fn UI =
	(
		rollout ro "Vertex To Volume Ratio" width:400
		(
			local self
			local sliderMax = 2000
			
			slider sld_index "Tolerence:" range:[0,sliderMax,500] type:#float ticks:10 orient:#horizontal offset:[5,0]
			
			label lbl_count "Dense Objects: ?" align:#left across:2
			spinner spn_scale "Slider Scale:" range:[0,999,1] type:#float fieldWidth:40 tooltip:"Use this to adjust the precision of the slider"
			
			group "Objects:"
			(
				checkBox chk_selection ":Selection" checked:False tooltip:"Only analyze the objects in your current selection" across:2
				checkBox chk_scene ":Full Scene" checked:True tooltip:"Aanalyze all objects in your scene"
			)
			
			dotNetControl dNbtn_collect "Button" height:40
			
			fn _init pself =
			(
				self = pself
				
				self.cacheArr = #()
				
				::DotNetUi.InitDnetBtn dNbtn_collect "Analyze Objects" 12 style:#popup colorOffsetInt:10 tooltip:""
			)
			
			on chk_selection changed state do
			(
				chk_scene.state = not state
			)
			
			on chk_scene changed state do
			(
				chk_selection.state = not state
			)
			
			on dNbtn_collect mouseClick args do
			(
				local objArr = case chk_selection.state of
				(
					( True ): ( GetCurrentSelection() )
					default: ( objects as array )
				)
				
				if objArr.count == 0 then return ( format "Nothing to analyze\n" )
				
				self.AnalyzeObjects objArr
				
				select ( self.GetObjsByRatio sld_index.value )
				lbl_count.text = ( "Dense Objects: " + ( selection.count as string ) )
			)
			
			on sld_index changed val do
			(
				select (self.GetObjsByRatio val)
				lbl_count.text = ( "Dense Objects: " + ( selection.count as string ) )
			)
			
			on spn_scale changed val do
			(
				sld_index.range = [0, ( sliderMax * spn_scale.value ) , sld_index.value]
			)
		)
		
		createDialog ro
		ro._init this
	),
	
	fn Run =
	(
		this.Ui()
	),
	
	fn GetModule =
	(
		( GetThisScriptFileName() )
	),
	
	fn Help =
	(
		::mxs.GetScriptHelp ( GetThisScriptFileName() )
	),
	
private
	
	fn _init =
	(
		if this.showUi then
		(
			this.Run()
		)
	),
	
	__init__ = _init()
)

VertToVolumeAnalyzer = VertToVolumeAnalyzer()


