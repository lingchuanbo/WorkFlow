//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;


//这是与Workflow的预设库转换就不多说了

var enDir = $.getenv("WorkFlow") ; //获取WorkFlow环境路径
var getDir=enDir.replace(/\\/g, '\/'); //转换字符
var getPath = "/custom/ae_presetAnimation/三国@武器边缘发光.ffx";//请在这行修改预设文件 这里要说下 你保存的预设最好都放在这里
var myPreset = File(getDir+getPath);//合并路径



for (var i = 0, len = selectedItems.length; i < len; i++) {

     var item = selectedItems[i];

     if ( selectedItems[i] instanceof CompItem ){      

          //我们先第一个 图层index
          //我们控制图层1
          var mylayer = 1


          selectedItems[i].layer(myLayer).selected = true; // 激活图层 这句必须要声明 否则会报错
          //意思呢 就是选中的图层,图层是第一个,true是激活 也就是我们鼠标选中的意思 也就是鼠标选中所有合成的图层一
          //然后进行操作
          selectedItems[i].layer(myLayer).applyPreset(myPreset) ; // 添加预设
          //这句话的意思是,选中的合成组中的图层1 激活预设 括号的意思是调用
          //我们直接运行一下

          //这是删除图层
          // selectedItems[i].layer(mylayer).remove();


          //定义特效对象 我们就以s_glow为对象
          // var myEffect=item.layer(mylayer).property("Effects").addProperty("S_Glow");
          // //先添加颜色
          // //定义一个颜色值
          // color=[106,5,200]
          // myEffect.property("Color").setValue(color/255); //这里要进行颜色转换 RGB/255
          // myEffect.property("Brightness").setValue(10); //直接照抄
          // myEffect.property("Glow Width").setValue(5); //直接照抄

          // var myEffect=deleteAllEffectsFromLayer(item.layer(myLayer));

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