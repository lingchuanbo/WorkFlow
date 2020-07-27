//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

//var selectedItem =app.project.item

for (var i = 0, len = selectedItems.length; i < len; i++) {

  var item = selectedItems[i];
  var myLayer = 1;
  var fps = 1 / item.frameDuration;
  var getDuration = item.duration;
  var itemComp = item.layer(myLayer);

  var Markerkey = new Array();

  var MarkerName = new Array();
  var layerDuplicate = new Array();

  var itemCompInPoint = itemComp.inPoint;
  var itemCompOutPoint = itemComp.outPoint;
  var itemCompMarker = itemComp.property("ADBE Marker");
  var itemCompMarkerKeys = itemCompMarker.numKeys;

  for (var i = 0; i < selectedItems.length; i += 1) {
    var numTimes = -(item.layer(myLayer).startTime) * fps;
  }
  for (var i = 1; i <= itemCompMarkerKeys; i += 1) {
    if (itemCompMarker.keyTime(i) > itemCompInPoint && itemCompMarker.keyTime(i) < itemCompOutPoint) {
      Markerkey.push(itemCompMarker.keyTime(i));
      MarkerName.push(itemCompMarker.keyValue(i).comment);
    }
  }

  var itemCompDuplicate = itemComp.duplicate();
  itemComp.enabled = false;
  itemCompMarker = itemCompDuplicate.property("Marker");


  for (var i = 0; i < Markerkey.length; i += 1) {
    newDuplicate = itemCompDuplicate.duplicate();
    newDuplicate.outPoint = Markerkey[i];
    layerDuplicate.push(newDuplicate);
    itemCompDuplicate.inPoint = Markerkey[i];
    itemCompDuplicate.outPoint = itemComp.outPoint;
    itemCompDuplicate.moveBefore(newDuplicate);
  }

  layerDuplicate.push(itemCompDuplicate);
  var ab = 0;
  if (layerDuplicate[0].inPoint < Markerkey[0]) {
    ab = 1;
  }
  for (var i = 0; i < Markerkey.length; i += 1) {
    addMarker = new MarkerValue(MarkerName[i]);
    (layerDuplicate[i + ab]).property("Marker").setValueAtTime(Markerkey[i], addMarker);
    var strTime = [0, getDuration * 1, getDuration * 2];
    var strTimes = strTime[i];
    (layerDuplicate[i + ab]).startTime = -strTimes - getDuration - numTimes; //
  }
}