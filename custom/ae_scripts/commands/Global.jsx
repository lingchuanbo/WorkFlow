//创建合成组
var newComp = app.project.items.addComp("Global",500,500,1,1,1);

//创建控制层
//人物层
var Global_Role = newComp.layers.addSolid([0,0,0], "Global_Role", newComp.width, newComp.height, 1);

//添加效果
var sliderctrl = Global_Role.Effects.addProperty("ADBE Slider Control");
