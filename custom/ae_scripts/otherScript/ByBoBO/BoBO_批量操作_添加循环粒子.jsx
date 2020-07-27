//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

var selectedItem = app.project.item

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
          //创建粒子固态层
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

          newComp2.layer(1).selected = true; // 激活图层

     } else {

          alert("No");
     }


}


function _addCompose() {

     if (actComp instanceof CompItem) {
          // 确认选择一个或多个层
          var myLayers = actComp.selectedLayers;
          if (myLayers.length > 0) {
               //设置新合成入点 出点时间

               var newInPoint = myLayers[0].inPoint;
               var newOutPoint = myLayers[0].outPoint;
               // 创建合成名字
               var newCompName = "Loop_comp ";
               var layerName = myLayers[0].name;
               if (layerName.length > 26) {
                    layerName = layerName.substring(0, 26);
               }
               newCompName += layerName;


               var layerIndices = new Array();
               for (var i = 0; i < myLayers.length; i++) {
                    layerIndices[layerIndices.length] = myLayers[i].index;

                    if (myLayers[i].inPoint < newInPoint) newInPoint = myLayers[i].inPoint;
                    if (myLayers[i].outPoint > newOutPoint) newOutPoint = myLayers[i].outPoint;
               }

               // 创建新合成


               layerIndices.push(layerIndices - 1, layerIndices - 2, layerIndices - 3);

               var newComp = actComp.layers.precompose(layerIndices, newCompName, true);

               // 修改合成5倍时间

               var preCompLayer = actComp.selectedLayers[0];

               preCompLayer.source.duration = compDuration / fps;
               preCompLayer.inPoint = newInPoint;
               preCompLayer.outPoint = newOutPoint; //以当前合成时间为出点
               //preCompLayer.outPoint = compDuration*timeEultiple; //
          }
     }
}

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
       layerName = layerName.substring(0, 26);
       //alert(layerName);
     }
     newCompName += layerName;
   
     var myLayers = item.selectedLayers;
     if (myLayers.length > 0){
       //alert (myLayers[0].index);
       var indexComp = myLayers[0].index;
     }else{
       alert ("No layers selected.");
     }
      
     //var indexComp = item.layer(4).index;
     var layerIndices = new Array();
   
     // 创建新合成
     layerIndices.push(indexComp - 0,indexComp - 1, indexComp - 2, indexComp - 3);
     var newComp = item.layers.precompose(layerIndices, newCompName, true);
     
     // 修改合成5倍时间
   
     var preCompLayer = item.selectedLayers[0];
   
     preCompLayer.source.duration = getDuration;
     preCompLayer.inPoint = 0;
     preCompLayer.outPoint = getDuration; //以当前合成时间为出点
     //preCompLayer.outPoint = compDuration*timeEultiple; //
   }