curver = 1.0 ; 声明当前版本
; IfNotExist, config.ini
; IniWrite, CN, config.ini, config, Language
; else
IniRead, Language, config.ini, config, Language
; if (A_Language = "0804")
If Language=CN
{
    vim.Comment("<PS_创建新文档>","创建新文档")
    vim.Comment("<PS_创建新图层>","创建新图层")

    
    vim.Comment("<PS_Brush_Swith>","笔刷&双击涂抹")
    vim.Comment("<PS_Brush_Big>","笔刷 放大")
    vim.Comment("<PS_Brush_Small>","笔刷 放小")
    vim.Comment("<PS_Eraser>","橡皮檫")
    vim.Comment("<PS_Remove_AllEmptyLayer>","清理所有空图层")
    vim.Comment("<PS_Remove_AllInvisibleHiddenLayers>","清理所有未显示图层")
    vim.Comment("<PS_Script_RotateMe>","旋转增强脚本")
    vim.Comment("<PS_Script_TransformEach>","位置增强脚本")

    vim.Comment("<PS_Duplicate_D>","双击复制图层&长按删除")

    
    vim.Comment("<PS_Screen_Small>", "屏幕:缩小&双击按屏幕最大化")
    vim.Comment("<PS_Screen_Big>", "屏幕:放大&双击按屏幕100%显示")
    vim.Comment("<PS_AutoUpdate>", "Photoshop脚本更新")

    vim.Comment("<Photoshop_SwithMode>", "【-----模式切换-----】")
    

    vim.Comment("<PS_透明度加>","透明度 +")
    vim.Comment("<PS_透明度减>","透明度 -")

    vim.Comment("<PS_层上>","图层 向上移")
    vim.Comment("<PS_层下>","图层 向下移")
    vim.Comment("<PS_Duplicate_旋转>","双击水平翻转&长按画布旋转")

    vim.Comment("<PS_打开颜色面板>","打开颜色面板")
    vim.Comment("<PS_填充颜色>","填充颜色")
    vim.Comment("<PS_GradientPaint>","颜料桶切换&双击填充")

    vim.Comment("<PS_Double_T>","变换")
    vim.Comment("<PS_Duplicate_X>","双按关闭文件")

    vim.Comment("<PS_Duplicate_图层中心>","图层居中")
    vim.Comment("<PS_Double_N>","新建图层&双按新建文件")


    vim.Comment("<PS_切换标签>","切换标签")
    vim.Comment("<PS_明颜色>","颜色 加亮")
    vim.Comment("<PS_暗颜色>","颜色 加暗")
    vim.Comment("<PS_Duplicate_图层>","图层 [新建|复制|删除]")
    vim.Comment("<PS_OneKeyDefault>","切换 [选择|框选|多边形|魔术棒]")
    vim.Comment("<PS_Duplicate_独立显示>","独立显示")
    vim.Comment("<PS_Duplicate_打开保存>","双按打开|长按保存")
    vim.Comment("<PS_Duplicate_画笔橡皮擦涂抹>","切换 [画笔|橡皮擦] 双按涂抹")
    vim.Comment("<PS_工笔>","切换 [画笔种类]")
    vim.Comment("<PS_选区切换>","切换 [选区]")
    vim.Comment("<PS_多边选区切换>","切换 [多边选区]")
    
}
else
{
    vim.Comment("<PS_创建新文档>","NewFiles")
    vim.Comment("<PS_Brush_Big>","Brush_Big")
    vim.Comment("<PS_Brush_Small>","Brush_Small")
    vim.Comment("<PS_Eraser>","Eraser")

    vim.Comment("<PS_Remove_AllEmptyLayer>","AllEmptyLayer")
    vim.Comment("<PS_Remove_AllInvisibleHiddenLayers>","AllInvisibleHiddenLayers")
    vim.Comment("<PS_Script_RotateMe>","RotateMe")
    vim.Comment("<PS_Script_TransformEach>","TransformEach")

    vim.Comment("<PS_透明度加>","Opacity Up")
    vim.Comment("<PS_透明度减>","Opacity Down")

    vim.Comment("<PS_层上>","Layer Up")
    vim.Comment("<PS_层下>","Layer Down")

    vim.Comment("<PS_Duplicate_图层中心>","图层居中")
    vim.Comment("<PS_切换标签>","切换标签")
    vim.Comment("<PS_明颜色>","颜色 加亮")
    vim.Comment("<PS_暗颜色>","颜色 加暗")
    vim.Comment("<PS_Duplicate_图层>","图层 [新建|复制|删除]")
    vim.Comment("<PS_OneKeyDefault>","切换 [选择|框选|多边形|魔术棒]")
}

 