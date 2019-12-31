var originalRulerUnits = app.preferences.rulerUnits;
var bounds = activeDocument.activeLayer.bounds
var emptyLayer=false;
if (Number(bounds[0]) == 0 && Number(bounds[1]) == 0 && Number(bounds[2]) == 0 && Number(bounds[3]) == 0) {emptyLayer = true};
try{
    if (activeDocument.activeLayer.kind != undefined && activeDocument.activeLayer.isBackgroundLayer == false && emptyLayer == false){
        if (app.activeDocument.activeLayer.opacity > 5) {  
            app.activeDocument.activeLayer.opacity = Math.round(app.activeDocument.activeLayer.opacity) -5;  
            }  
    }else{
        alert( "请选择图层操作");
    }
}catch(err){
    alert(err)
}

