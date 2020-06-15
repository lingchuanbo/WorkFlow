DeleteEmptyLayers_FN()
fn DeleteEmptyLayers_FN =
(
    currLayer = LayerManager.current
    if currLayer.name != "0" then
    (
        defLayer = LayerManager.getLayer 0
        defLayer.current = true
    )
    LayerManager.closeDialog()
    emptyLayers =#()
    for i = 0 to layerManager.count-1 do
    (
        ilayer = layerManager.getLayer i
        layerName = ilayer.name 
        layer = ILayerManager.getLayerObject i
        layer.Nodes &layerNodesArr
        if layerNodesArr.count == 0  do
        (
            append emptyLayers (layerName as string)
        )
    )
    with printAllElements on format "***** Empty Layers: % \n" emptylayers
    for i = 1 to emptyLayers.count do
    ( 
        layermanager.deleteLayerByName emptyLayers[i]
    )
    LayerManager.closeDialog()
    layermanager.editlayerbyname ""
)