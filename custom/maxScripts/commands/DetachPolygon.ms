/*
	This script will detach selected polygons into individual objects.
	This means, if you select 50 polygons and run the script you'll end up with 50 objects
	Each one of the objects is one of the previously selected polygons.
	
	The script is created my Miled Rizk
	e-mail: miledrizk@gmail.com
*/



-- macroScript BatchDetatch buttontext: "Batch Detach Polygons" category: "MiRi-Tools"

(
	On IsEnabled return	--the script will be available only when one object only is selected and it's a geometry but not a target object
	(
		selection.count == 1 and (superclassof $ == Geometryclass and classof $ != Targetobject)
	)--end on isenabled
	
	fn detachpolyfaces obj facelist =	--this function will perform the detach operation
	(
		for face in facelist do
		(
			polyop.detachfaces obj #{face} delete: False asNode: True name: (obj.name + (uniquename  "-face 001"))
		)--end for loop
	)--end fn detachpolyfaces
	
	On Execute do
	(
		max create mode
		if isvalidnode $ == true and classof $ == Editable_poly then
		(
			selected_faces = polyop.getfaceselection $
			if selected_faces.count > 0 do
			(
				Undo On
				(
					detachpolyfaces $ selected_faces	-- calling the function that will perform the detach operation
					Subobjectlevel = 0 
				)--end undo on
			)--end if selected faces.....
		)--end if selection.count........
		else
		(
			if isvalidnode $ == true and (classof $ == Polymeshobject or classof $ == Editable_mesh) do
		(
			copyconvertselected = convertto (copy $ name: $.name) Editable_poly
			selected_faces = polyop.getfaceselection copyconvertselected
			if selected_faces.count > 0 do
			(
				Undo On
				(
					detachpolyfaces copyconvertselected selected_faces	-- calling the function that will perform the detach operation
					delete copyconvertselected
				)--end undo on
			)--end if selected faces.....
		)--end if selection.count........
		)
	)--end Execute
)--end macroscript
