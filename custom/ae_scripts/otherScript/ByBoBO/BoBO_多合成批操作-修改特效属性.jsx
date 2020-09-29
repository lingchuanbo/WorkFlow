//selctionCompToDo
//BoBO
//20190723
//多选合成操作
//0.1a

var selectedItems = app.project.selection;

for (var i=0,len=selectedItems.length; i<len; i++)
{
	var item = selectedItems[i];
	if ( selectedItems[i] instanceof CompItem ){         
//~        var myLayer = "99999.png" ; //素材请用   "素材名" | index 请输出数字
            var LayerNum = 2 ; //素材请用   "素材名" | index 请输出数字

            color=[255,0,0]; // Color 1 //
            colorMid=[111,34,198]; // Color 1 //
            //var myEffect=item.layer(LayerNum).property("Effects").Property("Deep Glow"); //添加特效
            var myEffect=item.layer(LayerNum).property("Effects").property("S_TexturePlasma"); //添加特效
            // var myEffect=item.layer(LayerNum).property("Effects").property("Distance Gradation"); //添加特效
            //myEffect.property("Color").setValue(1.5); //设置属性
            //var myEffect=item.layer(LayerNum).property("Transform").property("Scale").setValue([60,60,100]); //基本属性设置
            // myEffect.property("Radius").setValue(30); //设置属性
            myEffect.property("Phase Speed").setValue(1.0); //设置属性
            // myEffect.property("Color").setValue(color/255); //颜色转换
            //myEffect.property("Midtones").setValue(colorMid/255); //颜色转换
            // myEffect.property("Gradation Color").setValue(color/255); //颜色转换
            // myEffect.property("Glow Width").setValue(16); 
            // myEffect.property("Width Red").setValue(1);
            // myEffect.property("Width Green").setValue(1);
            // myEffect.property("Width Blue").setValue(1);


//~        B=[251,174,65]; // Color 1 //
//~        //var myEffect=item.layer(3).property("Effects").addProperty("Deep Glow"); //添加特效
//~        var myEffect=item.layer(3).property("Effects").addProperty("S_Glow"); //添加特效
//~        myEffect.property("Brightness").setValue(1.5); //设置属性
//~        myEffect.property("Color").setValue(B/255); //颜色转换
//~        myEffect.property("Glow Width").setValue(24); 
//~        myEffect.property("Width Red").setValue(1);
//~        myEffect.property("Width Green").setValue(1);
//~        myEffect.property("Width Blue").setValue(1);
        // _ModifyEffect();
    }else{             
        alert ("No");          
    }
}

function _AddEffect(){
    
                     var myLayer = "99999.png" ; //素材请用   "素材名" | index 请输出数字
                  
                     B=[251,174,65]; // Color 1 //
                     //var myEffect=item.layer(3).property("Effects").addProperty("Deep Glow"); //添加特效
                     var myEffect=item.layer(3).property("Effects").addProperty("S_Glow"); //添加特效
                     myEffect.property("Brightness").setValue(1.5); //设置属性
                     myEffect.property("Color").setValue(B/255); //颜色转换
                     myEffect.property("Glow Width").setValue(24); 
                     myEffect.property("Width Red").setValue(1);
                     myEffect.property("Width Green").setValue(1);
                     myEffect.property("Width Blue").setValue(1);
    }
function _ModifyEffect(){
                     var myEffect=item.layer(4).property("Effects").property("S_Glow"); //添加特效
                     myEffect.property("Brightness").setValue(1.5); //设置属性
                     //myEffect.property("Brightness").setValue(1.5); //设置属性
                     //myEffect.property("Color").setValue(B/255); //颜色转换
                     //myEffect.property("Glow Width").setValue(24); 
                     //myEffect.property("Width Red").setValue(1);
                     //myEffect.property("Width Green").setValue(1);
                     //myEffect.property("Width Blue").setValue(1);
}