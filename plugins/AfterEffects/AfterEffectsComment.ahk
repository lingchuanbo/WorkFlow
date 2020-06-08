curver = 1.0 ; 
; IfNotExist, config.ini
; ; IniWrite, CN, config.ini, config, Language
; else
IniRead, Language, config.ini, config, Language
; 中英文分开 如果只是中文就在IF填写 可以无视else部分
If Language=CN
{
;Plus
    global _AERelinker="素材定位"
    global _AeDynamicComp="共享合成"
    global _AeAutoMatte="自动分层"
    global _AeMaskTransformer="遮罩转换"
    global _AeCompsitionOption="合成组设置"
    global _AeSpriteOMatic="切图动画"
    global _AeImmigrationREG = " 批量导入素材"
    global _AeBatchReplaceFile = " 批量替换素材"
    global _AeRENDER = "动作/方向"
    global _AeNameRENDER = "名字/动作/方向"
    global _AeNameDirection = "名字/方向"
    global _AeName = "名字"
    global _AeRenderGarden = "RenderGarden "
    global _AeProjectConver = "TSV转换"
    global _AeSaveCompAsProject = "导出合成组"
    global _AeCompDuplicator = "塌陷合成组"
    global _AePropertiesToFxControls = "调节层控制"
    global _AeBatchRename = "批量重命名"
    global _AeBakeExpressionsKey = "表达式转关键帧"
    global _AeFootageBatch= "素材批处理"

    global _AeDeletePosition="X位置"
    global _AeDeleteMask="X遮罩"
    global _AeDeleteMark="X标记"
    global _AeResetAll="重置所有"
    global _AeDeleteKey="X帧"
    global _AeDisableExpressions="禁用表达式"
    global _AeEnableExpressions="开启表达式"
    global _AeDeleteEff="X特效"
    global _AeDeleteExp="X表达式"
    global _AeAxis0="轴心0"

;定义注释
    vim.Comment("<AfterEffects_SwithMode>","切换模式")
    vim.Comment("<Ae_Open>","打开")
    vim.Comment("<Ae_Save>","保存")
    vim.Comment("<Ae_SaveAs>","另存为")
    vim.Comment("<Ae_OpenRecent>","最近打开")
    vim.Comment("<Ae_Import>","导入")
    vim.Comment("<Ae_Exit>","退出")
    vim.Comment("<Ae_Script_BoboTools>","BoBO_AeTools")
    vim.Comment("<Ae_Script_QuickMenu>","QuickMenu")
    vim.Comment("<Ae_Script_KeyBoard>","KeyBoard")
    vim.Comment("<Ae_Script_CompSetter>","批合成重设")
    vim.Comment("<Ae_Script_batchFootage>","批素材重设")
    vim.Comment("<Ae_Script_AutoMatte>","AE自动遮罩分层")
;双按    
    vim.Comment("<Ae_Double_q>","双按_【q】_渲染")
    vim.Comment("<Ae_Double_c>","合成(创建|预合成|设置)")
    vim.Comment("<Ae_Double_x>","双按_【x】_退出AE")
    vim.Comment("<Ae_Double_w>","双按_【w】_打开")
    vim.Comment("<Ae_Double_z>","双按_【z】_窗口100%%")
    vim.Comment("<Ae_Double_o>","双按_【o】_打开")
    vim.Comment("<Ae_Double_k>","双按_【k】_合成设置")
    vim.Comment("<Ae_Double_y>", "层(创建|设置|删除)")
    vim.Comment("<Ae_Double_d>", "粘贴|删除(长按)")

    vim.Comment("<Ae_Double_h>", "隐藏|双击独立显示|长按锁定")
    vim.Comment("<Ae_Double_n>", "创建固态层|新建合成组|长按创建调节层")

    vim.Comment("<Ae_Double_Tab>", "默认|双按搜索") 
    vim.Comment("<Ae_Double_F1>", "多功能F1|双按整理清理项目") 
    vim.Comment("<Ae_Double_F2>", "上一帧|双按第一帧") 
    vim.Comment("<Ae_Double_F3>", "下一帧|双第最后一帧") 
    vim.Comment("<Ae_Double_F4>", "双按关闭|长按关闭所有合成") 
    vim.Comment("<Ae_Double_F9>", "渲染工具")
    

    vim.Comment("<Ae_Press_p>","长按_K位置关键帧")
    vim.Comment("<Ae_Press_s>","长按_K缩放关键帧")
    vim.Comment("<Ae_Press_r>","长按_K旋转关键帧|双按查找层源")
    vim.Comment("<Ae_Press_t>","长按_K透明关键帧")


    vim.Comment("<Ae_OpenClose_Solo>","图层独立显示")
    vim.Comment("<Ae_OpenClose_Lock>","图层锁定")
    vim.Comment("<Ae_OpenClose_Hides>","图层隐藏显示")
    vim.Comment("<AfterEffects_新建合成>", "新建合成")
    vim.Comment("<AfterEffects_固态层>", "新建固态层")
    vim.Comment("<AfterEffects_调节层>", "新建调节层")
    vim.Comment("<AfterEffects_Null>", "新建Null")
    vim.Comment("<Ae_Remove>", "删除所有效果")
    vim.Comment("<ShowHelp2>","隐藏帮助")
    vim.Comment("<Ae_CllectFiles>","打包文件")
    vim.Comment("<Ae_AllMemoryDisk>","清理内存和数据")
    vim.Comment("<Ae_UpDater>","插件更新")
    vim.Comment("<Ae_Help3>","vimAE帮助文档")
    vim.Comment("<Ae_Help_Script>","AEScriptHelp")

    vim.Comment("<AfterEffects_优化合成时间>","修剪合成时间")
    vim.Comment("<Ae_ReplaceFootageFile2>","替换素材")
    

    vim.Comment("<Ae_CopyPaste>","按单键复制双键粘贴")
    vim.Comment("<Ae_foolParent>","Ae_foolParent")
    vim.Comment("<Ae_differenceToggle>", "切换 图层模式")
    vim.Comment("<Ae_layerGuideLayer>", "网格层")
    vim.Comment("<Ae_jumpToKey>", "跳至关键帧")
    vim.Comment("<Ae_MaskAndShapeVisibility>", "显示 遮罩图形")
    vim.Comment("<Ae_simpleNamer>", "简单重命名")
    vim.Comment("<Ae_PointCenter>", "中心点 归位")
    vim.Comment("<Ae_LayerInterceptLeft>", "图层截取 左边")
    vim.Comment("<Ae_LayerInterceptRight>", "图层截取 右边")
    vim.Comment("<Ae_SwitchLabel>", "切换 标签|长按s删除")    
    
    
    vim.Comment("<Ae_Preset_Ani1>","位置")
    vim.Comment("<Ae_Preset_Apply>","预设应用")
    vim.Comment("<HelpAe>","帮助")
    vim.Comment("<PluginsReg>","帮助")
    vim.Comment("<AeSpace>","播放")
    vim.Comment("<Ae_ProjectCleaner>","项目清理")
    vim.Comment("<Ae_ReloadFootage>","重载素材")
    vim.Comment("<Ae_Script_GlobalRename>","重命名工具")

    vim.Comment("<Ae_Double_->","缩小")
    vim.Comment("<Ae_Double_=>","缩小|双按100%显示")

    vim.Comment("<Ae_Double_[>","双按 工作区缩进(左)")
    vim.Comment("<Ae_Double_]>","双按 工作区缩进(右)")

    vim.Comment("<Ae_Double_Ctrl>", "添加关键帧")
    vim.Comment("<Ae_Double_Shift>", "切换曲线")



    global _AeVersion:="当前版本:2.0"
}
else
{

}

 