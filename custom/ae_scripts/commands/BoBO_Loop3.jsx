// 创建窗口
var win = new Window('palette', '3层循环 ByBoBO');
this.windowRef = win;

win.pnl = win.add("panel", [5, 5, 170, 180], '控制');

win.pnl.stxt = win.pnl.add('statictext', [10, 15, 100, 35], "循环帧数 #:");
var theNum = win.pnl.add('edittext', [90, 15, 140, 35], '10');

win.pnl.okBtn = win.pnl.add("button", [10, 40, 60, 60], 'OK');
win.pnl.cnlBtn = win.pnl.add("button", [90, 40, 140, 60], 'Cancel');

win.pnl.okBtn.onClick = function () {
    _Loop2();
    win.close();
}
win.pnl.cnlBtn.onClick = function () {
    //$.writeln("Cancel Button Pressed");
    win.close();
}

win.show();

function on_textInput_changed() {

    var value = theNum.text;
    if (isNaN(value)) {
        alert(value + " 非数字. 请输入数字", scriptName);
    } else {

        theNumVal = value;
    }
}
function _Loop2(){
    var actComp = app.project.activeItem;
    var fps = 1 / actComp.frameDuration; //转化时间到帧
    var selLayers = actComp.selectedLayers;
    on_textInput_changed();
    var compDuration = theNumVal; //默认获取当前合成时间 单位帧  自定义载入值
    //var compDuration = actComp.duration * fps; //默认获取当前合成时间 单位帧  自定义载入值
    var compLoopDuration = (actComp.duration * fps) * 1; //获取当前合成时间 单位帧
    
    var nOpacity = [0, compDuration, compDuration * 2, compDuration * 3]; //帧所在位置
    
    var nValue = [0, 100, 100,0]; //透明K键帧数组
    
    if (selLayers.length == 0) {
    
      alert("请选择层操作");
    
    } else {
    
      for (i = k1 = 0, ref = selLayers.length; k1 < ref; i = k1 += 1) {
    
        for (var t = 0, len = nValue.length = nOpacity.length; t < len; t++) {
    
          var addedOpacity = nValue[t];
          var addTime = nOpacity[t] / fps;
    
          addedMarker = new MarkerValue("透明度:" + nValue[t]);
          
          (selLayers[i]).property("Opacity").setValueAtTime(addTime, addedOpacity); //透明动画
          (selLayers[i]).property("Marker").setValueAtTime(nOpacity[t] / fps, addedMarker); //标记
          (selLayers[i]).inPoint=0; //裁剪图层
        }
      }
    }
    _splitComp();
    _addCompose();
    //切割标记
function _splitComp() {
    for (var i = 0; i < selLayers.length; i += 1) {
  
      duplicateMarker(selLayers[i]);
    }
  }
  //切割标记函数
  function duplicateMarker(ac) {
    var aa = new Array();
    var X = new Array();
    var ae = new Array();
    var ag = ac.inPoint;
    var W = ac.outPoint;
    var af = ac.property("ADBE Marker");
    var Y = af.numKeys;
    //获取startTimes
    for (var i = 0; i < selLayers.length; i += 1) {
        
      var numTimes = -(selLayers[i].startTime) * fps;
    }
  
    for (var Z = 1; Z <= Y; Z += 1) {
      if (af.keyTime(Z) > ag && af.keyTime(Z) < W) {
        aa.push(af.keyTime(Z));
        X.push(af.keyValue(Z).comment);
      }
    }
    if (aa.length == 0) {
      return;
    }
    var V = ac.duplicate();
    ac.enabled = false;
    af = V.property("Marker");
    // while (af.numKeys > 0) {
    //   af.removeKey(1);
    // }
    for (var Z = 0; Z < aa.length; Z += 1) {
      U = V.duplicate();
      U.outPoint = aa[Z];
      ae.push(U);
      V.inPoint = aa[Z];
      V.outPoint = ac.outPoint;
      V.moveBefore(U);
      //V._addCompose();
      //V.moveToBeginning(U);
      //V.moveToEnd();
    }
    ae.push(V);
    var ab = 0;
    if (ae[0].inPoint < aa[0]) {
      ab = 1;
    }
    for (var Z = 0; Z < aa.length; Z += 1) {
      ad = new MarkerValue(X[Z]);
      (ae[Z + ab]).property("Marker").setValueAtTime(aa[Z], ad);
  
      var strTime = [0, compDuration * 1, compDuration * 2, compDuration * 3];
      var strTimes = strTime[Z];
  //alert(numTimes);
      (ae[Z + ab]).startTime = -strTimes / fps - compDuration / fps - numTimes / fps; //
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
}


