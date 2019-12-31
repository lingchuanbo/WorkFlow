app.bringToFront();  
var originalRulerUnits = app.preferences.rulerUnits;
var bounds = activeDocument.activeLayer.bounds
var emptyLayer=false;
if (Number(bounds[0]) == 0 && Number(bounds[1]) == 0 && Number(bounds[2]) == 0 && Number(bounds[3]) == 0) {emptyLayer = true};
try{
if (activeDocument.activeLayer.kind != undefined && activeDocument.activeLayer.isBackgroundLayer == false && emptyLayer == false)
{
    // //创建执行
    var doc = app.activeDocument;
    var layer = activeDocument.activeLayer;
    _restoreLayer = true

    function wrapLCLayer(doc, layer, ftn) {
      var ad = app.activeDocument;
      if (doc) {
        if (ad != doc) {
          app.activeDocument = doc;
        }
      } else {
        doc = ad;
      }
    
      var al = doc.activeLayer;
      var alvis = al.visible;
    
      if (layer && doc.activeLayer != layer) {
        doc.activeLayer = layer;
    
      } else {
        layer = doc.activeLayer;
      }
    
      var res = undefined;
    
      try {
        res = ftn(doc, layer);
    
      } finally {
        if (_restoreLayer) {
          if (doc.activeLayer != al) {
            doc.activeLayer = al;
          }
          if (!doc.activeLayer.isBackgroundLayer) {
            doc.activeLayer.visible = alvis;
          }
        }
    
        if (Stdlib._restoreDoc) {
          if (app.activeDocument != ad) {
            app.activeDocument = ad;
          }
        }
      }
    
      return res;
    };
    
    function hasLayerMask(doc, layer) {
      function _ftn() {
        var ref = new ActionReference();
        ref.putEnumerated(cTID("Lyr "), cTID("Ordn"), cTID("Trgt"));
        var desc = executeActionGet(ref);
        return desc.hasKey(cTID("UsrM"));
      }
      return wrapLCLayer(doc, layer, _ftn);
    };
    
    function getLayerBounds(doc, layer) {
    
      var reenable = false;
      var st;
      if (hasLayerMask(doc, layer) &&
        isLayerMaskEnabled(doc, layer)) {
        st = doc.activeHistoryState;
        disableLayerMask(doc, layer);
        reenable = true;
      }
    
      var lbnds = layer.bounds;
    
      // fix this to modify the history state
      if (reenable) {
        Stdlib.enableLayerMask(doc, layer);
      }
      for (var i = 0; i < 4; i++) {
        lbnds[i] = lbnds[i].value;
      }
      return lbnds;
    }
    //检测空对象
    function removeallemptylayergroups(doc) {
      var foundEmpty = true;
      for( var i = doc.layerSets.length-1; 0 <= i; i--) {
          if( removeallemptylayergroups(doc.layerSets[i])) {
              doc.layerSets[i].remove();
          } else {
              foundEmpty = false;
          }
      }
      if (doc.artLayers.length > 0) {
          foundEmpty = false;
      }
      return foundEmpty;
    }
    
    function centerLayer(doc, layer) {
      var ru = app.preferences.rulerUnits;
      app.preferences.rulerUnits = Units.PIXELS;
    
      var bnds = getLayerBounds(doc, layer);
      var layerW = bnds[2] - bnds[0];
      var layerH = bnds[3] - bnds[1];
      var docW = doc.width.value;
      var docH = doc.height.value;
      var x = (docW / 2) - (layerW / 2);
      var y = (docH / 2) - (layerH / 2);
      var deltaX = x - bnds[0];
      var deltaY = y - bnds[1];
      layer.translate(deltaX, deltaY);
    }
    centerLayer(doc, layer);
 }
}catch(err){
  alert("请选择图层操作！！")
}