/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/20/2013
[Purpose]
Brings in the geometry mesh of the VRay Proxy at the same position and with the same hierarchy as the proxy container.
[KEYWORDS]
VRay, Proxies, VRMesh
__END__
******************************************/
struct replaceVRproxiesWithMesh_lib
(
	ro,
	fn replaceVRproxiesWithMesh_FN objArr arr:#()=
	(	
		inc = 100.0/objArr.count
		j=1
		for i in objArr do
		(
			if classOf i == VRayProxy then
			(
				i.layer.current = true
				proxyMesh = (vrayMeshImport proxy:i explicitNormals:2 weldVertices:2)[1]
				proxyMesh.transform = i.transform
				proxyMesh.material = i.material
				proxyMesh.wireColor = i.wireColor
				proxyMesh.gbufferChannel = i.gbufferChannel
				if i.parent != undefined then proxyMesh.parent = i.parent
				append arr i
			)
			else
			(
				format "***** % is not a VRayProxy object. It will be ignored. *****\n" i.name
			)
			ro.pg1.value = inc * j
			j+=1
		)
		delete arr
	),
	fn ui =
	(
		rollout ro "Collapse Progress" width:600 height:20
		(
			progressBar pg1 "" height:10
		)
		createDialog ro
	),
	fn _init =
	(
		if selection.count != 0 then
		(
			ui()
			replaceVRproxiesWithMesh_FN (getCurrentSelection())
			destroyDialog ro	
		)
		else
		(
			messageBox "Select the VRay Proxies you would like to replace with the mesh."
		)
	),
	init = _init()
)
meshProxies = replaceVRproxiesWithMesh_lib()
	