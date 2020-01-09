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
E-mail: gftvfx@gmail.com
Company: GTVFX
__END__
***************************************************************************************************/


::BoundingBox = ""


struct BoundingBox
(
	/*DOC_--------------------------------------------------------------------
	__HELP__
	
	This Struct calculates all of the points of the bounding box of a single
	object, an array of objects, or an ObjectSet.
	
	Members:
		[Var] cenPoint = undefined
		[Var] cenPointXmax = undefined
		[Var] cenPointXmin = undefined
		[Var] cenPointYmax = undefined
		[Var] cenPointYmin = undefined
		[Var] cenPointZmax = undefined
		[Var] cenPointZmin = undefined
		[Var] height = undefined
		[Var] length = undefined
		[Var] maxPoint = undefined
		[Var] maxPointXZmin = undefined
		[Var] maxPointXmin = undefined
		[Var] maxPointZmin = undefined
		[Var] midPointXmaxYmax = undefined
		[Var] midPointXmaxYmin = undefined
		[Var] midPointXmaxZmax = undefined
		[Var] midPointXmaxZmin = undefined
		[Var] midPointXminYmax = undefined
		[Var] midPointXminYmin = undefined
		[Var] midPointXminZmax = undefined
		[Var] midPointXminZmin = undefined
		[Var] midPointYmaxZmax = undefined
		[Var] midPointYmaxZmin = undefined
		[Var] midPointYminZmax = undefined
		[Var] midPointYminZmin = undefined
		[Var] minPoint = undefined
		[Var] minPointXZmax = undefined
		[Var] minPointXmax = undefined
		[Var] minPointZmax = undefined
		[Var] nodeLocal = false
		[Var] obj = undefined
		[Var] size = undefined
		[Var] width = undefined
		
		[FN] Update
		[FN] DrawBox
		[FN] DrawHelper
		[FN] DrawHelperGrid
		[FN] GetGrid
		[FN] GetLength
		[FN] GetMinMax
		[FN] GetModule
		[FN] GetWidth
		[FN] getHeight
		[FN] getsize
		[FN] help
	
	__END__
	--------------------------------------------------------------------_END*/
	
public
	-- required fields
	obj, -- Single object, Array of objects, or ObjectSet
	
	-----------------------------------
	
	nodeLocal = False,
	
	minPoint,
	maxPoint,
	
	cenPoint,
	
	minPointXmax,
	minPointXZmax,
	minPointZmax,
	
	maxPointZmin,
	maxPointXmin,
	maxPointXZmin,
	
	midPointYminZmax,
	midPointYminZmin,
	midPointXminYmin,
	midPointXmaxYmin,
	midPointXminYmax,
	midPointXmaxYmax,
	midPointYmaxZmax,
	midPointYmaxZmin,
	midPointXminZmin,
	midPointXminZmax,
	midPointXmaxZmin,
	midPointXmaxZmax,
	
	cenPointZmax,
	cenPointZmin,
	cenPointXmax,
	cenPointXmin,
	cenPointYmax,
	cenPointYmin,
	
	length,
	width,
	height,
	size,
	
	fn Update =
	(
		/*DOC_--------------------------------------------------------------------
		Recalculate the bounding box from the current #minPoint and #maxPoint
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		this.GetGrid()
		this.GetLength()
		this.GetWidth()
		this.GetHeight()
		this.GetSize()
		OK
	),
	
	fn DrawHelper coord propName:"" multiplier:1 =
	(
		/*DOC_--------------------------------------------------------------------
		Create a Point helper at the inputed coord * the inputed multiplier.
		
		PointHelper name will be "boundingPoint_" + propName + "_###"
		
		Args:
			coord (Point3)
		
		Kwargs:
			propName (string)
			multiplier (integer)
		
		Returns:
			PointHelper
		
		--------------------------------------------------------------------_END*/
		
		Point pos:( coord * multiplier ) name:( uniqueName ( "boundingPoint_" + ( propName as string )+"_001" ) ) cross:True box:False axisTripod:False
	),
	
	fn DrawHelperGrid nodeLocal:this.nodeLocal =
	(
		/*DOC_--------------------------------------------------------------------
		Create a Point helper at points around the calculated bounding box.
		Each corner, each midpoint, and the center of each face
		
		Kwargs:
			nodeLocal (boolean) : 
				If true, Draw the Point helper objects around the bounding
				box in nodeLocal coords and recalculate all of the properties
				of this struct in nodeLocal space
		
		Returns:
			VOID
		
		See Also:
			DrawNodeLocalHelperGrid
		
		--------------------------------------------------------------------_END*/
		
		local prps = GetPropNames this
		
		if nodeLocal then
		(
			return this.DrawNodeLocalHelperGrid this.obj
		)
		
		for p in prps where ( MatchPattern p pattern:"*Point*" ) do
		(
			this.DrawHelper ( GetProperty this p ) propName:p
		)
	),
	
	fn DrawNodeLocalHelperGrid obj =
	(
		/*DOC_--------------------------------------------------------------------
		Draw the Point helper objects around the bounding box in nodeLocal 
		coords and recalculate all of the properties of this struct in nodeLocal space
		
		Args:
			obj (Node)
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		if not IsProperty obj #transform then
		(
			messageBox "nodeLocal can only be calculated on a single object" title:"GTVFX:"
			return OK
		)
		
		this.nodeLocal = True
		
		local minMaxArr = in coordSys local (nodeLocalBoundingBox obj)
		
		this.minPoint = minMaxArr[1]
		this.maxPoint = minMaxArr[2]
		
		this.GetGrid()
		
		local prps = GetPropNames this
		
		for p in prps where matchPattern p pattern:"*Point*" do
		(
			this.DrawHelper ( GetProperty this p ) propName:p multiplier:obj.transform
		)
		
		this.Update()
	),
	
	fn DrawBox =
	(
		/*DOC_--------------------------------------------------------------------
		Create a Box that represents the calculated bounding box
		
		Returns:
			Box
		
		--------------------------------------------------------------------_END*/
		
		Box pos:this.cenPointZmin length:this.length width:this.width height:this.height
	),
	
	fn GetLength =
	(
		/*DOC_--------------------------------------------------------------------
		Calculates the length of the bounding box and sets the #length 
		property of this struct
		
		Returns:
			this.length
		
		--------------------------------------------------------------------_END*/
		
		this.length = ( Distance this.minPoint this.maxPointXZmin )
		this.length
	),
	
	fn GetWidth =
	(
		/*DOC_--------------------------------------------------------------------
		Calculates the width of the bounding box and sets the #width 
		property of this struct
		
		Returns:
			this.width
		
		--------------------------------------------------------------------_END*/
		
		this.width = ( Distance this.minPoint this.minPointXmax )
		this.width
	),
	
	fn GetHeight = 
	(
		/*DOC_--------------------------------------------------------------------
		Calculates the height of the bounding box and sets the #height 
		property of this struct
		
		Returns:
			this.height
		
		--------------------------------------------------------------------_END*/
		
		this.height = ( Distance this.minPoint this.midPointXminZmax )
		this.height
	),
	
	fn GetSize =
	(
		/*DOC_--------------------------------------------------------------------
		Calculates the size of the bounding box and sets the #size 
		property of this struct
		
		Returns:
			this.size
		
		--------------------------------------------------------------------_END*/
		
		this.size = [this.width, this.length, this.height]
		this.size
	),
	
	fn GetMinMax obj:this.obj =
	(
		/*DOC_--------------------------------------------------------------------
		Gets the .min and .max values of the inputed obj and sets the 
		#minPoint and #maxPoint props of this struct
		
		Args:
			obj ( Node | Object Array | ObjectSet )
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		case ( ClassOf obj ) of
		(
			( Array ):
			(
				local currSelection = ( GetCurrentSelection() )
				
				select obj
				
				this.minPoint = selection.min
				this.maxPoint = selection.max
				
				select currSelection
			)
			( ObjectSet ):
			(
				this.minPoint = obj.min
				this.maxPoint = obj.max
				
				this.obj = ( this.obj as array )
			)
			default:
			(
				if ( SuperClassOf obj == GeometryClass ) then
				(
					this.minPoint = obj.min
					this.maxPoint = obj.max
				)
				else
				(
					local str = StringStream ""
					format "Unable to min/max from provided object: %\n" obj to:str
					messageBox ( str as string ) title:"Invalid Type:"
				)
			)
		)
	),
	
	fn GetGrid =
	(
		/*DOC_--------------------------------------------------------------------
		Calculates all of the grid points for the bounding box and sets
		the internal associated properties
		
		Returns:
			VOID
		
		--------------------------------------------------------------------_END*/
		
		in coordSys local
		(
			this.cenPoint = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x) / 2 ) ), ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			
			this.minPointXmax = [ this.maxPoint.x, this.minPoint.y, this.minPoint.z ]
			this.minPointXZmax = [ this.maxPoint.x, this.minPoint.y, this.maxPoint.z ]
			this.minPointZmax = [ this.minPoint.x, this.minPoint.y, this.maxPoint.z ]
			
			this.maxPointZmin = [ this.maxPoint.x, this.maxPoint.y, this.minPoint.z ]
			this.maxPointXmin = [ this.minPoint.x, this.maxPoint.y, this.maxPoint.z ]
			this.maxPointXZmin = [ this.minPoint.x, this.maxPoint.y, this.minPoint.z ]
			
			this.midPointYminZmax = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), this.minPoint.y, this.maxPoint.z]
			this.midPointYminZmin = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), this.minPoint.y, this.minPoint.z]
			this.midPointXminYmin = [ this.minPoint.x, this.minPoint.y, ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.midPointXmaxYmin = [ this.maxPoint.x, this.minPoint.y, ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.midPointXminYmax = [ this.minPoint.x, this.maxPoint.y, ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.midPointXmaxYmax = [ this.maxPoint.x, this.maxPoint.y, ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.midPointYmaxZmax = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), this.maxPoint.y, this.maxPoint.z ]
			this.midPointYmaxZmin = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), this.maxPoint.y, this.minPoint.z ]
			this.midPointXminZmin = [ this.minPoint.x, ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), this.minPoint.z ]
			this.midPointXminZmax = [ this.minPoint.x,( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), this.maxPoint.z ]
			this.midPointXmaxZmin = [ this.maxPoint.x, ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), this.minPoint.z ]
			this.midPointXmaxZmax = [ this.maxPoint.x, ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), this.maxPoint.z ]
			
			this.cenPointZmax = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), this.maxPoint.z ]
			this.cenPointZmin = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), this.minPoint.z ]
			this.cenPointXmax = [ this.maxPoint.x, ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.cenPointXmin = [ this.minPoint.x, ( this.minPoint.y + ( ( this.maxPoint.y - this.minPoint.y ) / 2 ) ), ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.cenPointYmax = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), this.maxPoint.y, ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
			this.cenPointYmin = [ ( this.minPoint.x + ( ( this.maxPoint.x - this.minPoint.x ) / 2 ) ), this.minPoint.y, ( this.minPoint.z + ( ( this.maxPoint.z - this.minPoint.z ) / 2 ) ) ]
		)
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
	
	fn _init obj:this.obj =
	(
		if obj != undefined then
		(
			this.GetMinMax()
		)
		else if ( this.minPoint == undefined ) or ( this.maxPoint == undefined ) then 
		(
			messageBox "BoundingBox requires a valid value for the <obj> field
( Single object, Object Array, or ObjectSet )
			
Or you can instantiate the class and pass it a #minPoint and #maxPoint" title:"GTVFX:"
		)
		
		if ( this.minPoint != undefined ) and ( this.maxPoint != undefined ) then
		(
			this.GetGrid()
			this.GetLength()
			this.GetWidth()
			this.GetHeight()
			this.GetSize()
		)
		else
		(
			format "***** Pass Min and Max values to the struct *****\n"
		)
	),
	
	__init__ = _init()
)

