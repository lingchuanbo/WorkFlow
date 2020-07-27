//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;
var item = selectedItems[i]; //选中的项目
for (var i = 0, len = selectedItems.length; i < len; i++) {

     // _duplicateLayer(); //运行duplicateLayer函数Adjustment
     var newSolid = item.layers.addSolid([255,255,255], "Adjustment Layer", item.width, item.height,1);
     newSolid.adjustmentLayer = true; //固态层转调节层

}


function _duplicateLayer() {
     var selectedItems = app.project.selection; // 选择
     var item = selectedItems[i]; //选中的项目
     var myName = selectedItems.name;

     if (selectedItems[i] instanceof CompItem) {

          duplicateLayes = item.layer(3).duplicate(); //数字1为复制对象 这是要复制的对象 比如我复制第一层 这个1是index也就是
          //duplicateLayes.name = "拷贝到的图层"+"_copy"; //复制后重命名 批量无效 后面在试试其它方式 这是拷贝 名字 自定义 也可以忽略
          //duplicateLayes.blendingMode = BlendingMode.ADD; //设置层模式 这是图层模式 比如add
          duplicateLayes.moveToEnd(); //放到最底层 是复制在对象的上面和下面
          // moveToBeginning(), moveToEnd(最下面), moveBefore(之后), and moveAfter(上面)   层级函数
     } else {
          alert("No");
     }
}
