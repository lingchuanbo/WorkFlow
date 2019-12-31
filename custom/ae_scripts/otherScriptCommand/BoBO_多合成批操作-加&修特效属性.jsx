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

                   //_AddEffect();
                   _ModifyEffect();

                }else{             
                    
                alert ("No");          
    }
}

function _AddEffect(){ //添加
    
                     var myLayer = "99999.png" ; //素材请用   "素材名" | index 请输出数字
                  
                     B=[115,84,18]; // Color 1 //
                     //var myEffect=item.layer(3).property("Effects").addProperty("Deep Glow"); //添加特效
                     var myEffect=item.layer(2).property("Effects").addProperty("Tint"); //添加特效
//~                      myEffect.property("Brightness").setValue(1.5); //设置属性
                      myEffect.property("Map White To").setValue(B/255); //颜色转换
//~                      myEffect.property("Glow Width").setValue(24); 
//~                      myEffect.property("Width Red").setValue(1);
//~                      myEffect.property("Width Green").setValue(1);
//~                      myEffect.property("Width Blue").setValue(1);
    }
function _ModifyEffect(){ //修改
                    B=[114,78,2]; // Color 1 //
                     //var myEffect=item.layer(2).property("Effects").property("Tint"); //添加特效
                     //myEffect.property("Map White To").setValue(B/255); //颜色转换
                     //myEffect.property("Brightness").setValue(1.5); //设置属性
                     //myEffect.property("Color").setValue(B/255); //颜色转换
                     //myEffect.property("Brightness").setValue(1.5); //设置属性
                     //myEffect.property("Color").setValue(B/255); //颜色转换
                     //myEffect.property("Glow Width").setValue(24); 
                     //myEffect.property("Width Red").setValue(1);
                     //myEffect.property("Width Green").setValue(1);
                     //myEffect.property("Width Blue").setValue(1);
                    //// item.layer(2).blendingMode =BlendingMode.ADD 修改层级模式
                    item.layer(3).moveToEnd();
    }