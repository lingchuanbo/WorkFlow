//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

for (var i = 0, len = selectedItems.length; i < len; i++) {
     _duplicateLayer(); //运行duplicateLayer函数
     // selectedItems[i].layer(2).remove(); //与上面命令结合用 批量删除哪一层 数字为哪一层
     // var LayerEffect = selectedItems[i].layer(2).property("Effects").addProperty("Deep Glow"); //添加特效
     // LayerEffect.property("Radius").setValue(75);; //添加特效
     // LayerEffect.property("Exposure").setValue(0.3);; //添加特效
}

function _duplicateLayer() {
     var selectedItems = app.project.selection; //选择
     var item = selectedItems[i];
     var myName = selectedItems.name;

     if (selectedItems[i] instanceof CompItem) {
          duplicateLayes = item.layer(1).duplicate(); //数字1为复制对象
          duplicateLayes.name = "dup" + myName; //复制后重命名 批量无效 后面在试试其它方式

//[251,174,65]

          添加特效-以DeepGlow为例
         var addEff = duplicateLayes.property("Effects").addProperty("Deep Glow");
         addEff.property("Radius").setValue(100); //设置Radius属性
         addEff.property("Exposure").setValue(0.3); //设置Exposure属性
          
          // moveToBeginning(), moveToEnd(), moveBefore(), and moveAfter()   层级函数
          duplicateLayes.moveToBeginning(); //放到最底层
     } else {
          alert("No");
     }
}
