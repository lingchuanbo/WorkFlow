//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

//var selectedItem =app.project.item

for (var i = 0, len = selectedItems.length; i < len; i++) {
  var item = selectedItems[i];
  var myLayer = 1 ; 
  var fps = 1/item.frameDuration;
  var getDuration = item.duration;
  //alert(item.layer(myLayer).name);

  var myLayers = item.layer(myLayer);
  var newInPoint = myLayers.inPoint;
  var newOutPoint = myLayers.outPoint;

  var newCompName = "Loop_comp ";
  var layerName = myLayers.name;

  if (layerName.length > 26) {
    layerName = layerName.substring(0, 15);
    //alert(layerName);
  }
  newCompName += layerName;

  //item.layer(4).selected = true; // 激活图层 Active layer index

  var myLayers = item.selectedLayers;
  if (myLayers.length > 0){
    alert (myLayers[0].index);
  }else{
    alert ("No layers selected.");
  }
  //alert(item.layer(4).index);
   //_addCompose();
   
  // var indexComp = item.layer(4).index;
  // var layerIndices = new Array();

  // // 创建新合成
  // layerIndices.push(indexComp - 0,indexComp - 1, indexComp - 2, indexComp - 3);
  // var newComp = item.layers.precompose(layerIndices, newCompName, true);
  
  // // 修改合成5倍时间

  // var preCompLayer = item.selectedLayers[0];

  // preCompLayer.source.duration = getDuration;
  // preCompLayer.inPoint = 0;
  // preCompLayer.outPoint = getDuration; //以当前合成时间为出点
  // //preCompLayer.outPoint = compDuration*timeEultiple; //
}
