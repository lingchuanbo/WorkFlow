//selctionCompToDo
//BoBO
//20190723
//多选合成批操作-删除层
//0.1

var selectedItems = app.project.selection;

for (var i=0,len=selectedItems.length; i<len; i++)
{
    var item = selectedItems[i];
    var myLayer = 1 ; 
    item.layer(myLayer).remove();
}
