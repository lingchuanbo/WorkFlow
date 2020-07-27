//selctionCompToDo
//BoBO
//20190723
//多选合成操作
//0.1
var selectedItems = app.project.selection;

for (var i=0,len=selectedItems.length; i<len; i++)
{
			var item = selectedItems[i];
			if ( selectedItems[i] instanceof CompItem ){         
                     var myLayer = 1 ; //素材请用   "素材名" | index 请输出数字
                     
                     var myEffect=item.layer(myLayer).property("Effects").addProperty("Deep Glow"); //添加特效
                     
                     myEffect.property("Radius").setValue(100); //设置属性
                     
                }else{
                    
                alert ("No");          
    }
}


