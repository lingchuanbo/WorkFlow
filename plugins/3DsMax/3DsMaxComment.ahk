curver = 1.0 ; 声明当前版本
; IfNotExist, config.ini
; IniWrite, CN, config.ini, config, Language
; else
IniRead, Language, config.ini, config, Language
; if (A_Language = "0804")
If Language=CN
{
    vim.Comment("<3DsMax_NormalMode>", "返回正常模式")
    vim.Comment("<3DsMax_InsertMode>", "进入插入模式")
    vim.Comment("<ShowHelp>","帮助")
    vim.Comment("<3DsMax_Help>", "帮助显示")

    vim.Comment("<3DsMax_Double_Q>", "渲染|退出所有界面(长按)")
    vim.Comment("<3DsMax_Double_W>","窗口切换(双按)")
    vim.Comment("<3DsMax_Double_E>","Z旋转90(双按)")
    vim.Comment("<3DsMax_Double_D>","复制|删除")
    vim.Comment("<3DsMax_Double_X>","搜索|ActiveType|删除")
    vim.Comment("<3DsMax_Double_O>","打开|保存")
    vim.Comment("<3DsMax_Double_P>", "隐藏显示命令面板(双按)")
    vim.Comment("<3DsMax_Double_I>", "独立|全部显示")

    vim.Comment("<3DsMax_Double_0>", "物体归0")

    vim.Comment("<3DsMax_render8Direction>", "八方向渲染/批渲染")
    vim.Comment("<3DsMax_Renderlayers>", "分层渲染")
    vim.Comment("<3DsMax_Double_F9>", "渲染/设置")


    vim.Comment("<3DsMax_PivotCenter>", "轴:中心")
    vim.Comment("<3DsMax_PivotReset>", "轴:重置")
    vim.Comment("<3DsMax_PivotRotate>", "轴:旋转")
    vim.Comment("<3DsMax_PivotSet>", "轴:点选位置")
    vim.Comment("<3DsMax_maxXYZ>", "轴:底边中心")

    vim.Comment("<3DsMax_Save>","保存")
    vim.Comment("<3DsMax_SaveAs>","保存")
    vim.Comment("<3DsMax_Open>","打开")
    vim.Comment("<3DsMax_Exit>","退出")
    vim.Comment("<3DsMax_Archive>","打包")
    vim.Comment("<3DsMax_Reset>","重置")
    vim.Comment("<3DsMax_Import>","导入")
    vim.Comment("<3DsMax_Export>","导出")
    vim.Comment("<3DsMax_UpDater>","3DsMax插件更新")
    vim.Comment("<3DsMax_CopyToStartup>","3DsMax配置初始化")
    
    vim.Comment("<3DsMax_maxToTotalcmd>","Total Commander")

    vim.Comment("<3DsMax_convertToSpline>","转化为Spline")
    vim.Comment("<3DsMax_convertToPoly>","转化为Poly")
    vim.Comment("<3DsMax_convertToMesh>","转化为Mesh")

    vim.Comment("<3DsMax_attachSelection>", "塌陷")
    vim.Comment("<3DsMax_Align>", "对齐")
    vim.Comment("<3DsMax_warp>", "绑定空间")

    vim.Comment("<3DsMax_SelectLink>", "链接")
    vim.Comment("<3DsMax_SelectUnLink>", "断开链接")
}
else
{
    vim.Comment("<3DsMax_NormalMode>", "Normal Mode")
    vim.Comment("<3DsMax_InsertMode>", "Insert Mode")
    vim.Comment("<ShowHelp>","Help")
    vim.Comment("<3DsMax_Help>", "ShowHelp")

    vim.Comment("<3DsMax_Double_Q>", "Render|CloseAllUI")
    vim.Comment("<3DsMax_Double_W>","SwitchViewport(Double)")
    vim.Comment("<3DsMax_Double_E>","Rotate:Z90(Double)")
    vim.Comment("<3DsMax_Double_D>","Clone|Delete")
    vim.Comment("<3DsMax_Double_X>","Search|ActiveType|Delete")
    vim.Comment("<3DsMax_Double_P>", "HidenShowPanel(Double)")
    vim.Comment("<3DsMax_Double_O>","Open|Save")
    vim.Comment("<3DsMax_Double_I>", "Isolate|All")

    vim.Comment("<3DsMax_Double_0>", "Object:0:0:0")

    vim.Comment("<3DsMax_Renderlayers>", "Render layers")  
    vim.Comment("<3DsMax_render8Direction>", "Render8Direction&Batch")
    vim.Comment("<3DsMax_Double_F9>", "Render/Option")

    vim.Comment("<3DsMax_PivotCenter>", "Pivot Center")
    vim.Comment("<3DsMax_PivotReset>", "Pivot Reset")
    vim.Comment("<3DsMax_PivotRotate>", "Pivot Rotate")
    vim.Comment("<3DsMax_PivotSet>", "Pivot Set")
    vim.Comment("<3DsMax_maxXYZ>", "Pivot ZCenter")

    vim.Comment("<3DsMax_Save>","Save")
    vim.Comment("<3DsMax_SaveAs>","SaveAs")
    vim.Comment("<3DsMax_Open>","Open")
    vim.Comment("<3DsMax_Exit>","Exit")
    vim.Comment("<3DsMax_Archive>","Archive")
    vim.Comment("<3DsMax_Reset>","Reset")
    vim.Comment("<3DsMax_Import>","Import")
    vim.Comment("<3DsMax_Export>","Export")
    vim.Comment("<3DsMax_UpDater>","UpDater")

    vim.Comment("<3DsMax_maxToTotalcmd>","Total Commander")

    vim.Comment("<3DsMax_convertToSpline>","Convert To Spline")
    vim.Comment("<3DsMax_convertToPoly>","Convert To Poly")
    vim.Comment("<3DsMax_convertToMesh>","Convert To Mesh")
}

 