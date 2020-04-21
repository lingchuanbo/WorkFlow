//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

for (var i = 0, len = selectedItems.length; i < len; i++) {
     var item = selectedItems[i];
     var myLayer = 1;


     //获取帧数
     var getDuration = item.duration;
     //获取帧率
     var frameDuration = 1 / item.frameDuration;
     //转换3倍帧数
     var compDuration = getDuration * 3;

     if (selectedItems[i] instanceof CompItem) {
          Marker(); //标记
          CutMarker(); //标记切割
          addComp(); //合并
     } else {

          alert("No");
     }
}
function Marker() {
     var newCompName = item.layer(myLayer).name; //合成组名字
     //第一层 合成组放三段素材
     var newComp = item.layers.precompose([1], newCompName + "Loop3_comp ", true)
     var duplicateLayes = newComp.layer(myLayer).duplicate()
     var duplicateLayes = newComp.layer(myLayer).duplicate()

     newComp.layer(1).selected = true; // 激活图层
     newComp.layer(2).selected = true; // 激活图层
     newComp.layer(3).selected = true; // 激活图层

     var preCompLayer = item.selectedLayers[0];
     preCompLayer.source.duration = compDuration; //新合成组时间
     preCompLayer.outPoint = compDuration; //以当前合成时间为出点

     //第二层 合成组加粒子固态层
     var newComp2 = item.layers.precompose([1], newCompName, true)
     var preCompLayer2 = item.selectedLayers[0];
     preCompLayer2.source.duration = compDuration; //新合成组时间
     preCompLayer2.outPoint = compDuration; //以当前合成时间为出点


     //创建粒子固态层 这边控制粒子属性
     var solidLayer = newComp2.layers.addSolid([1, 1, 1], "layer", newComp2.width, newComp2.height, 1.0);
     solidLayer.property("Effects").addProperty("Particular"); //添加特效

     var nOpacity = [0, getDuration, getDuration * 2]; //帧所在位置
     var nValue = [1, 2, 3]; //透明K键帧数组

     addedMarker1 = new MarkerValue("段数:" + nValue[0]);
     addedMarker2 = new MarkerValue("段数:" + nValue[1]);
     addedMarker3 = new MarkerValue("段数:" + nValue[2]);

     preCompLayer2.property("Marker").setValueAtTime(0, addedMarker1); //标记
     preCompLayer2.property("Marker").setValueAtTime(getDuration, addedMarker2); //标记
     preCompLayer2.property("Marker").setValueAtTime(getDuration * 2, addedMarker3); //标记

     newComp2.layer(myLayer).selected = true; // 激活图层
}

function CutMarker() {
     for (var i1 = 0, len = selectedItems.length; i1 < len; i1++) {
          var item = selectedItems[i1];
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

          for (var i2 = 0; i2 < selectedItems.length; i2 += 1) {
               var numTimes = -(item.layer(myLayer).startTime) * fps;
          }
          for (var i3 = 1; i3 <= itemCompMarkerKeys; i3 += 1) {
               if (itemCompMarker.keyTime(i3) > itemCompInPoint && itemCompMarker.keyTime(i3) < itemCompOutPoint) {
                    Markerkey.push(itemCompMarker.keyTime(i3));
                    MarkerName.push(itemCompMarker.keyValue(i3).comment);
               }
          }

          var itemCompDuplicate = itemComp.duplicate();
          itemComp.enabled = false;
          itemCompMarker = itemCompDuplicate.property("Marker");


          for (var i4 = 0; i4 < Markerkey.length; i4 += 1) {
               newDuplicate = itemCompDuplicate.duplicate();
               newDuplicate.outPoint = Markerkey[i4];
               layerDuplicate.push(newDuplicate);
               itemCompDuplicate.inPoint = Markerkey[i4];
               itemCompDuplicate.outPoint = itemComp.outPoint;
               itemCompDuplicate.moveBefore(newDuplicate);
          }

          layerDuplicate.push(itemCompDuplicate);
          var ab = 0;
          if (layerDuplicate[0].inPoint < Markerkey[0]) {
               ab = 1;
          }
          for (var i5 = 0; i5 < Markerkey.length; i5 += 1) {
               addMarker = new MarkerValue(MarkerName[i5]);
               (layerDuplicate[i5 + ab]).property("Marker").setValueAtTime(Markerkey[i5], addMarker);
               var strTime = [0, getDuration * 1, getDuration * 2];
               var strTimes = strTime[i5];
               (layerDuplicate[i5 + ab]).startTime = -strTimes - getDuration - numTimes; //
          }
     }
}

function addComp() {
     for (var b = 0, len = selectedItems.length; b < len; b++) {
          var item = selectedItems[b];
          var myLayer = 1;
          var fps = 1 / item.frameDuration;
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

          var myLayers = item.selectedLayers;
          // if (myLayers.length > 0){
            //alert (myLayers[0].index);
          var indexComp = myLayers[0].index;
          
          alert(indexComp);
          // }else{
          //   alert ("No layers selected.");
          // }
          //var indexComp = item.layer(4).index;
          var layerIndices = new Array();
          // 创建新合成
          layerIndices.push(indexComp - 0, indexComp - 1, indexComp - 2, indexComp - 3);
          var newComp = item.layers.precompose(layerIndices, newCompName, true);
          // 修改合成5倍时间
          var preCompLayer = item.selectedLayers[0];
          preCompLayer.source.duration = getDuration;
          preCompLayer.inPoint = 0;
          preCompLayer.outPoint = getDuration; //以当前合成时间为出点
          //preCompLayer.outPoint = compDuration*timeEultiple; //
     }
}