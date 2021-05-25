//selctionCompToDo
//BoBO
//20190723
//0.1
var selectedItems = app.project.selection;

var enDir = $.getenv("WorkFlow") ; //获取WorkFlow环境路径
var getDir=enDir.replace(/\\/g, '\/'); //转换字符
// var getPath = "/custom/ae_presetAnimation/三国@武器边缘发光.ffx";//请在这行修改预设文件
var getPath = "/custom/ae_presetAnimation/凤凰改色3.ffx";//请在这行修改预设文件
var myPreset = File(getDir+getPath);//合并路径

for (var i=0,len=selectedItems.length; i<len; i++)
{
			var item = selectedItems[i];
			if ( selectedItems[i] instanceof CompItem ){         
                     var myLayer = 1 ; //素材请用   "素材名" | index 请输出数字
                    //  var myLayer = "素材名" ; //素材请用   "素材名" | index 请输出数字
                    // var myEffect=item.layer(myLayer).property("Effects").addProperty("Deep Glow"); //添加特效
                    // myEffect.property("Radius").setValue(100); //设置属性
                    // myEffect.property("Exposure").setValue(0.3); //设置属性
                    // var myEffect=item.layer(myLayer).property("Effects").addProperty("S_Glow"); //添加特效
                    // color=[255,98,67]; // Color 1 //
                    // myEffect.property("Brightness").setValue(1.5); //设置属性
                    // myEffect.property("Color").setValue(color/255); //颜色转换
                    // myEffect.property("Threshold").setValue(0); 
                    // myEffect.property("Glow Width").setValue(16); 
                    // myEffect.property("Width Red").setValue(1);
                    // myEffect.property("Width Green").setValue(1);
                    // myEffect.property("Width Blue").setValue(1);

                    //  myEffect.property("Radius").expression = "comp("GlobalControl").layer("ColorControl").effect("S_Glow")("Color")";

                    selectedItems[i].layer(myLayer).selected = true; // 激活图层 false & true
                    selectedItems[i].layer(myLayer).applyPreset(myPreset) ; // 添加预设
                    selectedItems[i].layer(myLayer).selected = false; // 激活图层 false & true

                    // selectedItems[i].layer(myLayer).property("Opacity").setValue(30); //透明动画

                }else{
                    
                alert ("No");          
    }
}


