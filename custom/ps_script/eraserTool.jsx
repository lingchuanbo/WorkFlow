app.bringToFront();  
var originalRulerUnits = app.preferences.rulerUnits;
var bounds = activeDocument.activeLayer.bounds
var emptyLayer=false;
if (Number(bounds[0]) == 0 && Number(bounds[1]) == 0 && Number(bounds[2]) == 0 && Number(bounds[3]) == 0) {emptyLayer = true};

try{
    if (activeDocument.activeLayer.kind != undefined && activeDocument.activeLayer.isBackgroundLayer == false && emptyLayer == false){
        setTool("eraserTool");
    }else{
        alert( "请选择图层操作");
    }
}catch(err){
    alert(err)
}
function setTool(tool) {
    var desc9 = new ActionDescriptor();
    var ref7 = new ActionReference();
    ref7.putClass( app.stringIDToTypeID(tool) );
    desc9.putReference( app.charIDToTypeID('null'), ref7 );
    executeAction( app.charIDToTypeID('slct'), desc9, DialogModes.NO );
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