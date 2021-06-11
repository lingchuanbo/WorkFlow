  ;重定义以下Sace，让Sace不被禁用   
    vim.map("<Space>", "<Tc_DoubleSpace>", "TTOTAL_CMD")  ;选中取消
    ; vim.map("<Alt>", "<TC_AltSwitch>", "TTOTAL_CMD")  ;收藏夹/双按访问历史记录
    ; vim.map("<Alt>", "<cm_DirectoryHotlist>", "TTOTAL_CMD")  ;收藏夹
    ; vim.map("<BS>", "<TC_Double_Backspace>", "TTOTAL_CMD")  ;上一层
    ;vim.map("<CapsLock>", "<cm_DirectoryHotlist>", "TTOTAL_CMD")  ;
    ;vim.map("<LCtrl>", "<TC_GoToParentEx>", "TTOTAL_CMD")  ;上一层
;根据原来这些数字键下方键对应的功能与系统原生快捷键设置的

    vim.map("1", "<TC_Un7zip>", "TTOTAL_CMD")  ;解压
    ; vim.map("1", "<TC_BZUnpackFiles>", "TTOTAL_CMD")  ;解压
    ;vim.map("1", "<ShowHelp>", "TTOTAL_CMD")  ;解压
    vim.map("2", "<cm_ContextMenu>", "TTOTAL_CMD")  ;弹出Q上下文菜单
    vim.map("3", "<cm_SrcQuickview>", "TTOTAL_CMD")  ;预览F3
    vim.map("4", "<cm_edit>", "TTOTAL_CMD")  ;编辑F4
    vim.map("5", "<TC_CopyUseQueues>", "TTOTAL_CMD")  ;无需确认复制到另一窗口F5
    vim.map("6", "<TC_MoveUseQueues>", "TTOTAL_CMD")   ;无需确认移动到另一窗口F6
    vim.map("7", "<cm_CopyNamesToClip>", "TTOTAL_CMD")  ;复制文件名
    vim.map("8", "<cm_Delete>", "TTOTAL_CMD")  ;删除
    vim.map("9", "<Space>", "TTOTAL_CMD")  ;模拟空格，选中取消
    vim.map("0", "<cm_MkDir>", "TTOTAL_CMD")  ;新建文件夹
    vim.map("<F1>", "<TC_double_Compare>", "TTOTAL_CMD")  ;比较
    vim.map("<F4>", "<TC_SwitchF4>", "TTOTAL_CMD")
    ; vim.map("<F5>", "<TC_GotoAe>", "TTOTAL_CMD") ;一键到AE
    vim.map("<F2>", "<TC_double_F2>", "TTOTAL_CMD") ;
    vim.map("<F11>", "<TC_SwitchWindows>", "TTOTAL_CMD")  ;切换窗口
    vim.map("/", "<cm_ShowQuickSearch>", "TTOTAL_CMD")  ;
    ; vim.map("<SP-1>", "<TC_To7zip>", "TTOTAL_CMD")
    vim.map("<SP-1>", "<TC_azHistory_Mod>", "TTOTAL_CMD")
    vim.map("<SP-4>", "<Home>", "TTOTAL_CMD")
    vim.map("<SP-0>", "<End>", "TTOTAL_CMD")
    vim.map("<SP-a>", "<TC_CreateNewFile>", "TTOTAL_CMD")
    vim.map("<SP-b>", "<cm_IntCompareFilesByContent>", "TTOTAL_CMD")
    vim.map("<SP-n>", "<cm_OpenNewTab>", "TTOTAL_CMD")
    vim.map("<SP-m>", "<cm_DirectoryHistory>", "TTOTAL_CMD")
    vim.map("<SP-i>", "<TC_Help>", "TTOTAL_CMD")   
    vim.map("<SP-o>", "<TC_MkDirPasteFile>", "TTOTAL_CMD")
    vim.map("<SP-r>", "<cm_MultiRenameFiles>", "TTOTAL_CMD")
    vim.map("<SP-u>", "<Space>", "TTOTAL_CMD")
    vim.map("<SP-x>", "<cm_Delete>", "TTOTAL_CMD")
    vim.map("<SP-y>", "<cm_CopyFullNamesToClip>", "TTOTAL_CMD")
    vim.map("<SP-t>", "<TC_TwoFileExchangeName>", "TTOTAL_CMD")
    vim.map("<SP-/>", "<cm_SearchFor>", "TTOTAL_CMD")  
    vim.map("<SP-[>", "<cm_UnselectCurrentName>", "TTOTAL_CMD")
    vim.map("<SP-]>", "<cm_SelectCurrentExtension>", "TTOTAL_CMD")
    vim.map("<SP-\>", "<cm_ExchangeSelBoth>", "TTOTAL_CMD") ;|
    vim.map("<SP-->", "<cm_SwitchSeparateTree>", "TTOTAL_CMD")
    vim.map("<SP-=>", "<cm_MatchSrc>", "TTOTAL_CMD")
    vim.map("<SP-;>", "<cm_List>", "TTOTAL_CMD") ;弹窗预览i
	vim.map("<SP-'>", "<cm_EditPath>", "TTOTAL_CMD")
	vim.map("<SP-'>", "<cm_FocusCmdLine>", "TTOTAL_CMD") ;"
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    vim.map("<F9>1", "<TC_TCIMG_RenAddDateTime>", "TTOTAL_CMD")
    vim.map("<F9>2", "<TC_TCIMG_DirGetUp>", "TTOTAL_CMD") ;"
    vim.map("<F9>3", "<TC_TCIMG_MoveExtensions>", "TTOTAL_CMD") ;"
    vim.map("<F9>4", "<TC_TCIMG_DirGetInputName>", "TTOTAL_CMD") ;"
    vim.map("<F9>", "<TC_Everyting>", "TTOTAL_CMD")  ;收藏夹
    ; vim.map("<F9>5", "<TC_FastCopy_CopyCVT>", "TTOTAL_CMD") ;"
    ; vim.map("<F9>6", "<TC_FastCopy_Copy>", "TTOTAL_CMD") ;"

    ;双按
    vim.map("c", "<TC_double_ClearDupTab>", "TTOTAL_CMD") ;清理重复标签 
    vim.map("f", "<TC_double_Everything>", "TTOTAL_CMD") ;清理重复标签 
    vim.map("q", "<TC_double_返回>", "TTOTAL_CMD") 
    vim.map("x", "<TC_double_关闭非活动窗口>", "TTOTAL_CMD") 

    vim.map("C-A-q", "<TC_test>", "TTOTAL_CMD") 
;KJ上下选中，HL左右选中
    vim.map("<SP-h>", "<left>", "TTOTAL_CMD")
    vim.map("<SP-j>", "<down>", "TTOTAL_CMD")
    vim.map("<SP-k>", "<up>", "TTOTAL_CMD")
    vim.map("<SP-l>", "<right>", "TTOTAL_CMD")
;ED上下选中，AF左右标签
	vim.map("<SP-e>", "<TC_UpSelect>", "TTOTAL_CMD")
    vim.map("<SP-d>", "<TC_DownSelect>", "TTOTAL_CMD")
    vim.map("<SP-s>", "<cm_SwitchToPreviousTab>", "TTOTAL_CMD")
    vim.map("<SP-f>", "<cm_SwitchToNextTab>", "TTOTAL_CMD")
;PQ解压压缩   
;    vim.map("<SP-q>", "<TC_BZUnpackFiles>", "TTOTAL_CMD")
    vim.map("<SP-q>", "<TC_BZPackFiles>", "TTOTAL_CMD")  
    
    ;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    vim.map("<SP-w>", "<TC_ReOpenTab>", "TTOTAL_CMD")    
  
    

    vim.map("<A-e>1", "<cm_SrcShort>", "TTOTAL_CMD")  
    vim.map("<A-e>2", "<cm_SrcComments>", "TTOTAL_CMD")
    vim.map("<A-e>3", "<cm_SrcLong>", "TTOTAL_CMD") 
    vim.map("<A-e>q", "<cm_SrcTree>", "TTOTAL_CMD") 
    vim.map("<A-e>w", "<cm_SrcThumbs>", "TTOTAL_CMD") 
    vim.map("<A-e>e", "<cm_SrcByDateTime>", "TTOTAL_CMD") 
    vim.map("<A-e>a", "<cm_SrcUnsorted>", "TTOTAL_CMD")
    vim.map("<A-e>s", "<cm_SrcNegOrder>", "TTOTAL_CMD") 

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	;复制/移动到右侧 f取file的意思 filecopy
    ;移动到右侧 c取copy的意思 filecopy
    ;~ vim.map("<SP-c>c", "<cm_CopyOtherpanel>", "TTOTAL_CMD")
    ;ff复制到剪切板 fz剪切到剪切板 fv粘贴
    ;~ vim.map("<SP-c>f", "<cm_CopyToClipboard>", "TTOTAL_CMD")
    ;使用队列复制/移动到右侧 q-queue, fcq会影响对fc的使用，改用fqc/fqx的方式
    vim.map("<SP-c>qc", "<TC_CopyUseQueues>", "TTOTAL_CMD")
    ;fb复制到收藏夹某个目录，fd移动到收藏夹的某个目录
    vim.map("<SP-c>d", "<TC_CopyDirectoryHotlist>", "TTOTAL_CMD")
    ;~ vim.map("<SP-c>g", "<cm_CopySrcPathToClip>", "TTOTAL_CMD")
    ;~ vim.map("<SP-c>t", "<cm_SyncChangeDir>", "TTOTAL_CMD")
    vim.map("<SP-c>e", "<TC_FileCopyForBak>", "TTOTAL_CMD")
    vim.map("<SP-c>c", "<cm_CopyNamesToClip>", "TTOTAL_CMD")
    ;复制到文件夹不打开目录
    ;~ vim.map("<SP-c>n", "<TC_OpenDirAndPaste>", "TTOTAL_CMD")   
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
;移动到右侧 v取 剪辑粘贴的意思
;从剪贴板粘贴到当前文件夹  
    ;~ vim.map("<SP-v>x", "<cm_PasteFromClipboard>", "TTOTAL_CMD")
;将当前文件夹下的选定文件移动到上层目录中,
    vim.map("<SP-v>u", "<TC_MoveSelectedFilesToPrevFolder>", "TTOTAL_CMD")
;将当前文件夹下的全部文件移动到上层目录中
    vim.map("<SP-v>a", "<TC_MoveAllFilesToPrevFolder>", "TTOTAL_CMD")    
;粘贴文件，如果光标下为目录则粘贴进该目录
    vim.map("<SP-v>c", "<TC_PasteFileEx>", "TTOTAL_CMD")
;移动到另一个窗口(F6)
    ;~ vim.map("<SP-v>v", "<cm_MoveOnly>", "TTOTAL_CMD")
;剪切选中的文件到剪贴板    
    ;~ vim.map("<SP-v>e", "<cm_CutToClipboard>", "TTOTAL_CMD")
;移动到常用文件夹    
    vim.map("<SP-v>d", "<TC_MoveDirectoryHotlist>", "TTOTAL_CMD")
;无需确认，使用队列移动文件至另一窗口
    vim.map("<SP-v>qx", "<TC_MoveUseQueues>", "TTOTAL_CMD")
;查找相同的文件
    vim.map("<S-v>", "<TC_SameFiles>", "TTOTAL_CMD")
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ;~ vim.map("<SP-g>a", "<cm_CloseAllTabs>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>g", "<TC_GoToLine>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>$", "<TC_LastLine>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>c", "<cm_CloseCurrentTab>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>b", "<cm_CompareFilesByContent>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>e", "<cm_Exchange>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>r", "<TC_ReOpenTab>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>w", "<cm_ExchangeWithTabs>", "TTOTAL_CMD") 
    ;~ vim.map("<SP-g>q", "<TC_HomeSelect>", "TTOTAL_CMD")
    ;~ vim.map("<SP-g>/", "<TC_EndSelect>", "TTOTAL_CMD")
    vim.map("<SP-g>1", "<cm_SrcActivateTab1>", "TTOTAL_CMD")
    vim.map("<SP-g>2", "<cm_SrcActivateTab2>", "TTOTAL_CMD")
    vim.map("<SP-g>3", "<cm_SrcActivateTab3>", "TTOTAL_CMD")
    vim.map("<SP-g>4", "<cm_SrcActivateTab4>", "TTOTAL_CMD")
    vim.map("<SP-g>5", "<cm_SrcActivateTab5>", "TTOTAL_CMD")
    vim.map("<SP-g>s", "<TC_FileUnlock>", "TTOTAL_CMD")    
    vim.map("<SP-g>d", "<TC_FileUnlockDelete>", "TTOTAL_CMD")    
    vim.map("<SP-g>e", "<TC_EXOpen>", "TTOTAL_CMD")  

	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	vim.map("<SP-z>f", "<cm_SrcByName>", "TTOTAL_CMD")
    vim.map("<SP-z>e", "<cm_SrcByExt>", "TTOTAL_CMD")
    vim.map("<SP-z>s", "<cm_SrcBySize>", "TTOTAL_CMD")
    vim.map("<SP-z>d", "<cm_SrcByDateTime>", "TTOTAL_CMD")
    vim.map("<SP-z>r", "<cm_SrcNegOrder>", "TTOTAL_CMD")
    vim.map("<SP-z>1", "<cm_SrcSortByCol1>", "TTOTAL_CMD")
    vim.map("<SP-z>2", "<cm_SrcSortByCol2>", "TTOTAL_CMD")
    vim.map("<SP-z>3", "<cm_SrcSortByCol3>", "TTOTAL_CMD")
    vim.map("<SP-z>4", "<cm_SrcSortByCol4>", "TTOTAL_CMD")
    vim.map("<SP-z>5", "<cm_SrcSortByCol5>", "TTOTAL_CMD")
    vim.map("<SP-z>z", "<TC_Undo>", "TTOTAL_CMD")   
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	vim.map("<SP-,>b", "<cm_VisButtonbar>", "TTOTAL_CMD")
    vim.map("<SP-,>c", "<cm_VisDriveCombo>", "TTOTAL_CMD")
    vim.map("<SP-,>d", "<cm_VisDriveButtons>", "TTOTAL_CMD")
    vim.map("<SP-,>e", "<cm_CommandBrowser>", "TTOTAL_CMD")
    vim.map("<SP-,>f", "<cm_VisKeyButtons>", "TTOTAL_CMD")
    vim.map("<SP-,>h", "<cm_SwitchIgnoreList>", "TTOTAL_CMD")
    ; vim.map("<SP-,>m", "<TC_ToggleMenu>", "TTOTAL_CMD")
    vim.map("<SP-,>m", "<TC_ShowMainMenu>", "TTOTAL_CMD")
    vim.map("<SP-,>n", "<cm_VisCmdLine>", "TTOTAL_CMD")
    vim.map("<SP-,>o", "<cm_VisTwoDriveButtons>", "TTOTAL_CMD")
    vim.map("<SP-,>r", "<cm_VisDriveCombo>", "TTOTAL_CMD")
    vim.map("<SP-,>s", "<cm_VisStatusbar>", "TTOTAL_CMD")
    vim.map("<SP-,>t", "<cm_VisTabHeader>", "TTOTAL_CMD")
    vim.map("<SP-,>w", "<cm_VisDirTabs>", "TTOTAL_CMD")
    vim.map("<SP-,>a", "<TC_StyleC40000>", "TTOTAL_CMD")
    vim.map("<SP-,>,", "<cm_SrcThumbs>", "TTOTAL_CMD")
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	vim.map("<SP-.>z", "<cm_50Percent>", "TTOTAL_CMD")
    vim.map("<SP-.>h", "<TC_Toggle_50_100Percent_V>", "TTOTAL_CMD")
    vim.map("<SP-.>i", "<TC_WinMaxLeft>", "TTOTAL_CMD")
    vim.map("<SP-.>o", "<TC_WinMaxRight>", "TTOTAL_CMD")
    vim.map("<SP-.>t", "<TC_AlwayOnTop>", "TTOTAL_CMD")
    vim.map("<SP-.>n", "<cm_Minimize>", "TTOTAL_CMD")
    vim.map("<SP-.>m", "<cm_Maximize>", "TTOTAL_CMD")
    vim.map("<SP-.>r", "<cm_Restore>", "TTOTAL_CMD")
    vim.map("<SP-.>v", "<cm_VerticalPanels>", "TTOTAL_CMD")

    vim.map("<F5>", "<TC_复制不需要确定>", "TTOTAL_CMD")
    vim.map("<F6>", "<TC_移动不需要确定>", "TTOTAL_CMD")
    vim.map("<F2>", "<TC_重命名和添加时间>", "TTOTAL_CMD")