----------------------------------------------------------------------------------------
-- Script Name:		UnrealEngineTools.mcr
-- Version:			v0.1
-- Last Modified: 	20/04/2020
-- Code by:			Rub�n Pis�n
-- 					      rubenpison@gmail.com

-- Centra el pivote en la base del objeto, Alinea el pivote con el mundo, reset xform y colapsa a editpoly
----------------------------------------------------------------------------------------


-- macroscript UnrealEngineTools
-- category:"UnrealEngineTools"
-- tooltip:"Prepara objeto para UE4"
-- buttontext:"Para UE4"
-- -- rollout AtSel "Untitled" width:133 height:74
-- (
-- 	on isEnabled return (selection.count >= 1)
-- 	on Execute do
-- 	(
		try
		(
			--Loop de los objetos seleccionados
			for i in selection do (
				a=i.center
				a.z=i.min.z
				i.pivot = a
				WorldAlignPivot i
				ResetXForm i
				convertTo i Editable_Poly
				maxOps.CollapseNode i off
				)
		)
		catch
		(
			messageBox "Error al ejecutar" title:"UnrealEngineTools Error" beep:true
		)
-- 	)
-- )