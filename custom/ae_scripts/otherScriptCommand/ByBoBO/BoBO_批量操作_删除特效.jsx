//selctionCompToDo
//BoBO
//20190723
//多选合成批操作-删除特效属性
//0.1

var selectedItems = app.project.selection;

for (var i=0,len=selectedItems.length; i<len; i++)
{
			var item = selectedItems[i];
			var myLayer = 2 ; 
			
			if ( selectedItems[i] instanceof CompItem ){  

					 //素材请用   "素材名.png" | index 请输出数字
                                  
                    //  var myEffect=deleteAllEffectsFromLayer(item.layer(myLayer));
                     item.layer(myLayer).blendingMode =BlendingMode.ADD; //改变层模式
                    //  item.layer(myLayer).remove(); //删除
                                        
                }else{
                    
                alert ("No");          
    }
}

function deleteAllEffectsFromLayer(layer) {
            if (!(layer instanceof LightLayer || layer instanceof CameraLayer)) {
                for (var i = layer.property("ADBE Effect Parade").numProperties; i > 0; i--) {
                    layer.property("ADBE Effect Parade").property(1).remove();
                }
            }
        }