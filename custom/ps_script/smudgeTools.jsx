app.bringToFront();  
var originalRulerUnits = app.preferences.rulerUnits;
var bounds = activeDocument.activeLayer.bounds
var emptyLayer=false;
if (Number(bounds[0]) == 0 && Number(bounds[1]) == 0 && Number(bounds[2]) == 0 && Number(bounds[3]) == 0) {emptyLayer = true};

try{
    if (activeDocument.activeLayer.kind != undefined && activeDocument.activeLayer.isBackgroundLayer == false && emptyLayer == false){
        setTool("smudgeTool");
    }else{
        alert( "请选择图层操作");
    }
}catch(err){
    alert(err)
}
function setTool(tool) {
    var desc = new ActionDescriptor();
    var ref = new ActionReference();
    ref.putClass( app.stringIDToTypeID(tool) );
    desc.putReference( app.charIDToTypeID('null'), ref);
    executeAction( app.charIDToTypeID('slct'), desc, DialogModes.NO );
}
 
//~ moveTool
//~ marqueeRectTool
//~ marqueeEllipTool
//~ marqueeSingleRowTool
//~ marqueeSingleColumnTool
//~ lassoTool
//~ polySelTool
//~ magneticLassoTool
//~ quickSelectTool
//~ magicWandTool
//~ cropTool
//~ sliceTool
//~ sliceSelectTool
//~ spotHealingBrushTool
//~ magicStampTool
//~ patchSelection
//~ redEyeTool
//~ paintbrushTool
//~ pencilTool
//~ colorReplacementBrushTool
//~ cloneStampTool
//~ patternStampTool
//~ historyBrushTool
//~ artBrushTool
//~ eraserTool
//~ backgroundEraserTool
//~ magicEraserTool
//~ gradientTool
//~ bucketTool
//~ blurTool
//~ sharpenTool
//~ smudgeTool
//~ dodgeTool
//~ burnInTool
//~ saturationTool
//~ penTool
//~ freeformPenTool
//~ addKnotTool
//~ deleteKnotTool
//~ convertKnotTool
//~ typeCreateOrEditTool
//~ typeVerticalCreateOrEditTool
//~ typeCreateMaskTool
//~ typeVerticalCreateMaskTool
//~ pathComponentSelectTool
//~ directSelectTool
//~ rectangleTool
//~ roundedRectangleTool
//~ ellipseTool
//~ polygonTool
//~ lineTool
//~ customShapeTool
//~ textAnnotTool
//~ soundAnnotTool
//~ eyedropperTool
//~ colorSamplerTool
//~ rulerTool
//~ handTool
//~ zoomTool