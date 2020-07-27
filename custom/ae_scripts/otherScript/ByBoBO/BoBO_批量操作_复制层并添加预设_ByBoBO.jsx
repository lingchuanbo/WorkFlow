//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;


// var enDir = $.getenv("vimdir") ; //获取VIMD环境路径
// var getDir=enDir.replace(/\\/g, '\/'); //转换字符
// var getPath = "/custom/ae_presetAnimation/xm5@外发光_炮弹兵.ffx";//请在这行修改预设文件
// var myPreset = File(getDir+getPath);//合并路径


for (var i = 0, len = selectedItems.length; i < len; i++) {

     _duplicateLayer(); //运行duplicateLayer函数
     //需要激活图层信息才能添加预设

     // selectedItems[i].layer(1).selected = true; // 激活图层2
     // selectedItems[i].layer(1).applyPreset(myPreset)
     //信添加预设结束
    // selectedItems[i].layer(2).remove(); //与上面命令结合用 批量删除哪一层 数字为哪一层
    
}


// var proj = app.project;
// for (var i = 0; i < proj.selection.length; i++) {
//      var item = proj.selection[i];
//      if (item instanceof CompItem){
//           var layer = item.layer[2]
//           layer.applyPreset(myPreset);
//      }
//      // selectedItems[i].layer[2].applyPreset(myPreset); //与上面命令结合用 批量删除哪一层 数字为哪一层
// }


function _duplicateLayer() {
     var selectedItems = app.project.selection; //选择
     var item = selectedItems[i];
     var myName = selectedItems.name;

     if (selectedItems[i] instanceof CompItem) {
          duplicateLayes = item.layer(1).duplicate(); //数字1为复制对象
          duplicateLayes.name = "dup" + myName; //复制后重命名 批量无效 后面在试试其它方式
          //添加特效-以DeepGlow为例
          // var addEff = duplicateLayes.property("Effects").addProperty("Deep Glow");
          //  addEff.property("Radius").setValue(100); //设置Radius属性
          // addEff.property("Exposure").setValue(0.3); //设置Exposure属性
          //		dupundefined.blendingMode = BlendingMode.ADD;
          //moveToBeginning(), moveToEnd(), moveBefore(), and moveAfter()   层级函数
          duplicateLayes.blendingMode = BlendingMode.ADD; //设置层模式
          duplicateLayes.moveToBeginning(); //放到最底层
     } else {
          alert("No");
     }
}
