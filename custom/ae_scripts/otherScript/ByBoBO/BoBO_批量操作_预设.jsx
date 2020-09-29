//selctionCompToDo
//BoBO
//20190723
//0.1
var selectedItems = app.project.selection;

var enDir = $.getenv("WorkFlow") ; //获取WorkFlow环境路径
var getDir=enDir.replace(/\\/g, '\/'); //转换字符
var getPath = "/custom/ae_presetAnimation/添加流光.ffx";//请在这行修改预设文件
var myPreset = File(getDir+getPath);//合并路径

for (var i=0,len=selectedItems.length; i<len; i++)
{
	var item = selectedItems[i];
	if ( selectedItems[i] instanceof CompItem ){    
               
          var myLayer = 1 ; //素材请用   "素材名" | index 请输出数字
          selectedItems[i].layer(myLayer).selected = true; // 激活图层
          selectedItems[i].layer(myLayer).applyPreset(myPreset) ; // 添加预设
          selectedItems[i].layer(myLayer).selected = false; // 不图层
     }else{

           alert ("No");

    }

}


