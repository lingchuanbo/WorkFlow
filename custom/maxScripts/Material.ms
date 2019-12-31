/*
--原文：https://blog.csdn.net/dingd_158/article/details/51252966 
*/
--创建球体、修改球体分段数并给球体赋予标准材质或者将标准材质漫反射颜色修改为任意color
sphere()

select object()

s = $
s.segs = 32
s.material = standard()                 --给当前obj制定标准材质
s.material = standard diffuse:yellow  --给当前标准材质球制定具体漫反射颜色

--高光属性修改
s.material.specular_level = 70  --修改高光级别
s.material.glossiness = 50      --修改高光光泽度
s.material.soften = 0.5         --修改高光软化值
--自发光属性修改

s.material.self_illumination = 50   --自发光亮度为50
s.material.useSelfIllumColor = on   --开启自发光颜色
s.material.selfillumcolor = color 159 159 159   --自定义自发光颜色

/*
//

//
--不透明属性修改

s.material.opacity = 50     --设置不透明度

明暗器基本参数修改

s.material.shadertype = 0 - 7 
0--->Anisotropic        [Anisotropic]
1--->Blinn              [Blinn]
2--->Matal              [金属]
3--->Multi-Layer        [多层]
4--->Oren-Nayar-Blinn   [Oren-Nayar-Blinn]
5--->Phong              [Phong]
6--->Strauss            [Strauss]
7--->Translucent Shader [半透明]

贴图通道修改
s.material.maps[2] = checker()      --给通道2【漫反射通道】指定棋盘格贴图
s.material.diffusemap = marble()    --给通道2【漫反射通道】指定大理石贴图
showtexturemap a.material on        --在场景中显示该材质效果
【通道支持索引和具体名称方式操作贴图通道，以下索引从1开始。具体名称不赘述自行查找】
1--->Ambient Color      --环境光颜色
2--->Diffuse Color      ==>漫反射颜色
3--->Specular Color     ==>高光颜色
4--->Specular level     ==>高光级别
5--->Glossiness         ==>光泽度
6--->self-illumination  ==>自发光
7--->Opacity            ==>不透明度
8--->Filter Color       ==>过滤色
9--->Bump               ==>凹凸贴图
10--->Reflection        ==>反射
11--->Refraction        ==>折射
12--->Displacement      ==>置换

--修改材质通道中的子属性

s.material.maps[2].size = 50        --血管大小
s.material.maps[2].vein_width = 0.3 --血管宽度
s.material.maps[2].color1 = red     --子属性中的一号颜色
s.material.maps[2].color2 = blue    --子属性中的二号颜色
s.material.maps[2].coords.tiling = [1.1,2,2]    --瓷砖 point3值类型
s.material.maps[2].coords.offset = [0.1,0,2]    --偏移 point3值类型
s.material.maps[2].coords.angle = [20,0,20]     --角度 point3值类型

--修改任意材质球
meditmaterials[3] = inknpaint()     --修改3号材质球为卡通材质 总共24个材质球 索引从1开始
meditmaterials[2] = multimaterial() --修改2号材质球为多维材质
meditmaterials[2].materiallist[1-10] = inknpaint  --修改多维材质球中的第一个材质为卡通材质 索引1-10
meditmaterials[2].materiallist[4].paint_map = checker() --多维中第4材质的子属性中绘制-亮区属性中(lighted)添加棋方格图片
meditmaterials[2].materiallist[4].paint_color = blue--多维中第4材质的子属性中绘制-亮区颜色修改
meditmaterials[4].materiallist[4].paint_levels = 10 --多维中第4材质的子属性绘制-级别修改
meditmaterials[4].materiallist[4].ink_on= off       --墨水开关
meditmaterials[4].materiallist[4].out_ink_on = off  --轮廓线

--材质球之间的复制
meditmaterials[4] = copy meditmaterials[1]  --将1号材质复制给4号材质
for m=1 to 24 do meditmaterials[m] = standard() --将所有材质球类型改为标准材质
for m=1 to 24 do meditmaterials[m].diffuse = (random balck white)   --漫反射颜色随机在黑色与白色之间
for m=1 to 24 do meditmaterials[m].specular_level = 90  --高光级别
for m=1 to 24 do meditmaterials[m].glossiness = 50      --光泽度
--------------------- 

for m=1 to 24 do meditmaterials[m] = inknpaint()    
--统一修改24个材质球类型为卡通材质
for m=1 to 24 do meditmaterials[m].paint_color = (random yellow red)    
--统一修改卡通材质亮区值为随黄色与红色的随机值
for m=1 to 24 do selection[m].material = meditmaterials[m]  
--统一将所选24个物体的材质球类型设置为材质框中的24色
for i in selection do showtexturemap i.material on  
--统一将所选材质的贴图显示在编辑器视窗中

for i in selection do i.material = meditmaterials[random 1 24]  
--随机将材质球中1-24号赋予给场景中选中的物体
for i in selection do i.material.diffusemap = bitmaptexture filename:"C:\Users\Public\Pictures\Sample Pictures\考拉.jpg"      
--统一将选中的物体的材质球中的漫反射贴图，换成一张位图。位图位于C盘.....
for m=1 to 24 do meditmaterials[m].diffusemap = bitmaptexture filename:"C:\Users\Public\Pictures\Sample Pictures\考拉.jpg"
--统一将所有材质球中的漫反射贴图，换成一张位图。位图位于C盘.....
for m=1 to 24 do meditmaterials[m].diffusemap.starttime = (random 10 30)
--将所有材质求的漫反射贴图，播放时间随机化 10 - 30之间
--------------------- 
*/