/*
Copyright (C) 2001 - 2010  Hyperbolic Enterprises Inc.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

paul(dot)hormis(at)hyperent.com
*/


Global AttachToSurfaceByLocalZ

Struct AttachToSurfaceByLocalZStruct
	(
		FilterObj = undefined,
		BindSurf = undefined,
		BindObj = undefined,
		bindIntersect = undefined,
		
		fn AlreadySelected Bindobj = (for FilterObj in (selection as array) do (if Bindobj == FilterObj do (return false)) return true ),

		fn ZPositive Dobj DSurf =
			(
				Dray = ray Dobj.pos Dobj.dir
				DIntersect = intersectRayex DSurf Dray
				TestDist = distance Dobj.pos DIntersect[1].pos
				return #(TestDist, DIntersect)
			),
		
		fn ZNegative Dobj DSurf =
			(
				Dray = ray Dobj.pos -Dobj.dir
				DIntersect = intersectRayex DSurf Dray
				TestDist = distance Dobj.pos DIntersect[1].pos
				return #(TestDist, DIntersect)
			),
		
		fn DoAttachToSurfaceByLocalZ BindObj =
			(
				if $ != undefined then
				(
					BindSurf = pickObject filter:AlreadySelected rubberband:$.center
					
					if BindSurf != undefined do
						(
							rollout AttachToSurfaceByLocalZDialog "Attach to Surface Progress" width:525 height:30
								(
									label AttachtoSurfaceProgressInfo "Poly Collapse to Origin" pos:[10,2] width:505 height:20
									progressBar AttachtoSurfaceProgress "" pos:[10,20] width:505 height:8
								)
								createdialog AttachToSurfaceByLocalZDialog
							
							progressSteps = 100.0 / BindObj.count
							
							BindObj = selection as array
							
							progressCount = 0
		
							Max Create mode
							
							if (classof BindSurf) != Editable_mesh do
								(
									addmodifier BindSurf (Mesh_Select())
									BindSurf.modifiers[1].name = "BindSurfMeshSelect"
								)
							
							objectsNotBound = #()
							
							for obj in BindObj do
								with redraw off
									(
									progressCount += 1
									
									AttachToSurfaceByLocalZDialog.AttachtoSurfaceProgressInfo.caption = ("Object: " + obj.name as string)
									AttachToSurfaceByLocalZDialog.AttachtoSurfaceProgress.value = progressSteps * progressCount
									
									TestZPos = (try (ZNegative obj BindSurf) catch ())
									TestZNeg = (try (ZPositive obj BindSurf) catch ())
									
									addmodifier BindSurf (NormalModifier())
									BindSurf.modifiers[1].name = "BindSurfNormalMod"
									BindSurf.modifiers[#BindSurfNormalMod].flip = on
									
									TestZPosFlip = (try (ZNegative obj BindSurf) catch ())
									TestZNegFlip = (try (ZPositive obj BindSurf) catch ())
									
									deleteModifier BindSurf BindSurf.modifiers[#BindSurfNormalMod]
									
									DistanceArray = #()
									
									if TestZPos != undefined do (append DistanceArray TestZPos[1])
									if TestZNeg != undefined do (append DistanceArray TestZNeg[1])
									if TestZPosFlip != undefined do (append DistanceArray TestZPosFlip[1])
									if TestZNegFlip != undefined do (append DistanceArray TestZNegFlip[1])
									
									sort DistanceArray
									
									ShortestDistance = DistanceArray[1]
									
									FinalRay = #()
									
									if ((try (finditem TestZPos ShortestDistance) catch()) != undefined) and ((try (finditem TestZPos ShortestDistance) catch()) != 0) do
										(
											if Obj.modifiers[#BindObjMeshSelect] != undefined do (deleteModifier Obj Obj.modifiers[#BindObjMeshSelect])

											append FinalRay ((TestZPos[2])[2] - 1)
											append FinalRay ((TestZPos[2])[3])
										)
									if ((try (finditem TestZNeg ShortestDistance) catch()) != undefined) and ((try (finditem TestZNeg ShortestDistance) catch()) != 0) do
										(
											if Obj.modifiers[#BindObjMeshSelect] != undefined do (deleteModifier Obj Obj.modifiers[#BindObjMeshSelect])

											append FinalRay ((TestZNeg[2])[2] - 1)
											append FinalRay ((TestZNeg[2])[3])
										)
									if ((try (finditem TestZPosFlip ShortestDistance) catch()) != undefined) and ((try (finditem TestZPosFlip ShortestDistance) catch()) != 0) do
										(
											if Obj.modifiers[#BindObjMeshSelect] != undefined do (deleteModifier Obj Obj.modifiers[#BindObjMeshSelect])

											append FinalRay ((TestZPosFlip[2])[2] - 1)
											append FinalRay (meshOp.getBaryCoords BindSurf ((TestZPosFlip[2])[2]) ((TestZPosFlip[2])[1].pos))
										)

									if ((try (finditem TestZNegFlip ShortestDistance) catch()) != undefined) and ((try (finditem TestZNegFlip ShortestDistance) catch()) != 0) do
										(
											if Obj.modifiers[#BindObjMeshSelect] != undefined do (deleteModifier Obj Obj.modifiers[#BindObjMeshSelect])
										
											append FinalRay ((TestZNegFlip[2])[2] - 1)
											append FinalRay (meshOp.getBaryCoords BindSurf ((TestZNegFlip[2])[2]) ((TestZNegFlip[2])[1].pos))
										)
									
									if (FinalRay[1] != undefined) and (FinalRay[2] != undefined) then
										(
											d = Point size:2 centermarker:true axistripod:false cross:false box:false constantscreensize:false drawontop:false
											d.position.controller = attachment()
											d.position.controller.node = BindSurf
											addnewkey d.position.controller 0
											k = attachctrl.getkey d.position.controller 1

											k.face = FinalRay[1]
											k.coord = FinalRay[2]
												
											sliderTime += 1
											sliderTime -= 1
											
											Obj.parent = d
											d.name = (Obj.name + "_SurfAtt")
											setTransformLockFlags d #all
													
										)
										else
										(
											if Obj.modifiers[#BindObjMeshSelect] != undefined do (deleteModifier Obj Obj.modifiers[#BindObjMeshSelect])
											append objectsNotBound obj
										)
									gc()
								)
							destroyDialog AttachToSurfaceByLocalZDialog
							if BindSurf.modifiers[#BindSurfMeshSelect] != undefined do (deleteModifier BindSurf BindSurf.modifiers[#BindSurfMeshSelect])
							if objectsNotBound.count > 0 do
								(
									select objectsNotBound
									messageBox "The objects selected could not be bound.  The Z axis of these objects do not intersect the surface object" title:"Attach to Surface Error"
								)
						)
				)
				else
				(
					messageBox "You must select objects to bind to a surface" title:"Attach to Surface Error"
				)
			)
	)

AttachToSurfaceByLocalZ = AttachToSurfaceByLocalZStruct()

AttachToSurfaceByLocalZ.BindObj = selection as array

AttachToSurfaceByLocalZ.DoAttachToSurfaceByLocalZ AttachToSurfaceByLocalZ.BindObj

