//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

var selectedItem =app.project.item

for (var i = 0, len = selectedItems.length; i < len; i++) {

     var mySelection = selectedItems[i];
     var mySelections = selectedItem[i];
     
     var myLayer = 1 ; 



     // 创建新合成



     var newCompName = mySelection.layer(myLayer).name+"Loop_comp "; //合成组名字

     mySelections.layers.precompose([1],newCompName,true)
     
}