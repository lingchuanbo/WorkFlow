  ;重定义以下Sace，让Sace不被禁用   
    vim.map("<Space>", "<Enter>", "TCQuickSearch")  ;选中取消
    vim.map("<Alt>", "<cm_DirectoryHotlist>", "TCQuickSearch")  ;收藏夹
    vim.map("<Ctrl>", "<TC_GoToParentEx>", "TCQuickSearch")  ;上一层
;根据原来这些数字键下方键对应的功能与系统原生快捷键设置的
    vim.map("1", "<TC_BZUnpackFiles>", "TCQuickSearch")  ;解压
    vim.map("2", "<cm_ContextMenu>", "TCQuickSearch")  ;弹出上下文菜单
    vim.map("3", "<cm_SrcQuickview>", "TCQuickSearch")  ;预览F3
    vim.map("4", "<cm_edit>", "TCQuickSearch")  ;编辑F4
    vim.map("5", "<TC_CopyUseQueues>", "TCQuickSearch")  ;无需确认复制到另一窗口F5
    vim.map("6", "<TC_MoveUseQueues>", "TCQuickSearch")   ;无需确认移动到另一窗口F6
    vim.map("7", "<cm_CopyNamesToClip>", "TCQuickSearch")  ;复制文件名
    vim.map("8", "<cm_Delete>", "TCQuickSearch")  ;删除
    vim.map("9", "<Space>", "TCQuickSearch")  ;模拟空格，选中取消
    vim.map("0", "<cm_MkDir>", "TCQuickSearch")  ;新建文件夹
    vim.map("<SP-4>", "<Home>", "TCQuickSearch")
    vim.map("<SP-0>", "<End>", "TCQuickSearch")
    vim.map("<SP-a>", "<TC_CreateNewFile>", "TCQuickSearch")
    vim.map("<SP-b>", "<cm_IntCompareFilesByContent>", "TCQuickSearch")
    vim.map("<SP-n>", "<cm_OpenNewTab>", "TCQuickSearch")
    vim.map("<SP-m>", "<cm_DirectoryHistory>", "TCQuickSearch")
    vim.map("<SP-i>", "<TC_Help>", "TCQuickSearch")   
    vim.map("<SP-o>", "<TC_MkDirPasteFile>", "TCQuickSearch")
    vim.map("<SP-r>", "<cm_MultiRenameFiles>", "TCQuickSearch")
    vim.map("<SP-u>", "<Space>", "TCQuickSearch")
    vim.map("<SP-w>", "<TC_ReOpenTab>", "TCQuickSearch")   
    vim.map("<SP-x>", "<cm_Delete>", "TCQuickSearch")
    vim.map("<SP-y>", "<cm_CopyFullNamesToClip>", "TCQuickSearch")
    vim.map("<SP-t>", "<TC_TwoFileExchangeName>", "TCQuickSearch")
    vim.map("<SP-/>", "<cm_SearchFor>", "TCQuickSearch")  
    vim.map("<SP-[>", "<cm_UnselectCurrentName>", "TCQuickSearch")
    vim.map("<SP-]>", "<cm_SelectCurrentExtension>", "TCQuickSearch")
    vim.map("<SP-\>", "<cm_ExchangeSelBoth>", "TCQuickSearch") ;|
    vim.map("<SP-->", "<cm_SwitchSeparateTree>", "TCQuickSearch")
    vim.map("<SP-=>", "<cm_MatchSrc>", "TCQuickSearch")
    vim.map("<SP-;>", "<cm_List>", "TCQuickSearch") ;弹窗预览
	vim.map("<SP-'>", "<cm_EditPath>", "TCQuickSearch")
	vim.map("<SP-'>", "<cm_FocusCmdLine>", "TCQuickSearch") ;"
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    
    
;KJ上下选中，HL左右选中
    vim.map("<SP-h>", "<left>", "TCQuickSearch")
    vim.map("<SP-j>", "<down>", "TCQuickSearch")
    vim.map("<SP-k>", "<up>", "TCQuickSearch")
    vim.map("<SP-l>", "<right>", "TCQuickSearch")
;ED上下选中，AF左右标签
	vim.map("<SP-e>", "<TC_UpSelect>", "TCQuickSearch")
    vim.map("<SP-d>", "<TC_DownSelect>", "TCQuickSearch")
    vim.map("<SP-s>", "<cm_SwitchToPreviousTab>", "TCQuickSearch")
    vim.map("<SP-f>", "<cm_SwitchToNextTab>", "TCQuickSearch")
;PQ解压压缩   
;    vim.map("<SP-q>", "<TC_BZUnpackFiles>", "TCQuickSearch")
    vim.map("<SP-q>", "<TC_BZPackFiles>", "TCQuickSearch")  
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    vim.map("<SP-w>", "<TC_ReOpenTab>", "TCQuickSearch")    
  
    

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	;复制/移动到右侧 f取file的意思 filecopy
    ;移动到右侧 c取copy的意思 filecopy
    ;~ vim.map("<SP-c>c", "<cm_CopyOtherpanel>", "TCQuickSearch")
    ;ff复制到剪切板 fz剪切到剪切板 fv粘贴
    ;~ vim.map("<SP-c>f", "<cm_CopyToClipboard>", "TCQuickSearch")
    ;使用队列复制/移动到右侧 q-queue, fcq会影响对fc的使用，改用fqc/fqx的方式
    vim.map("<SP-c>qc", "<TC_CopyUseQueues>", "TCQuickSearch")
    ;fb复制到收藏夹某个目录，fd移动到收藏夹的某个目录
    vim.map("<SP-c>d", "<TC_CopyDirectoryHotlist>", "TCQuickSearch")
    ;~ vim.map("<SP-c>g", "<cm_CopySrcPathToClip>", "TCQuickSearch")
    ;~ vim.map("<SP-c>t", "<cm_SyncChangeDir>", "TCQuickSearch")
    vim.map("<SP-c>e", "<TC_FileCopyForBak>", "TCQuickSearch")
    ;复制到文件夹不打开目录
    ;~ vim.map("<SP-c>n", "<TC_OpenDirAndPaste>", "TCQuickSearch")   
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
;移动到右侧 v取 剪辑粘贴的意思
;从剪贴板粘贴到当前文件夹  
    ;~ vim.map("<SP-v>x", "<cm_PasteFromClipboard>", "TCQuickSearch")
;将当前文件夹下的选定文件移动到上层目录中,
    vim.map("<SP-v>u", "<TC_MoveSelectedFilesToPrevFolder>", "TCQuickSearch")
;将当前文件夹下的全部文件移动到上层目录中
    vim.map("<SP-v>a", "<TC_MoveAllFilesToPrevFolder>", "TCQuickSearch")    
;粘贴文件，如果光标下为目录则粘贴进该目录
    vim.map("<SP-v>c", "<TC_PasteFileEx>", "TCQuickSearch")
;移动到另一个窗口(F6)
    ;~ vim.map("<SP-v>v", "<cm_MoveOnly>", "TCQuickSearch")
;剪切选中的文件到剪贴板    
    ;~ vim.map("<SP-v>e", "<cm_CutToClipboard>", "TCQuickSearch")
;移动到常用文件夹    
    vim.map("<SP-v>d", "<TC_MoveDirectoryHotlist>", "TCQuickSearch")
;无需确认，使用队列移动文件至另一窗口
    vim.map("<SP-v>qx", "<TC_MoveUseQueues>", "TCQuickSearch")
;查找相同的文件
    vim.map("<S-v>", "<TC_SameFiles>", "TCQuickSearch")
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ;~ vim.map("<SP-g>a", "<cm_CloseAllTabs>", "TCQuickSearch")
    ;~ vim.map("<SP-g>g", "<TC_GoToLine>", "TCQuickSearch")
    ;~ vim.map("<SP-g>$", "<TC_LastLine>", "TCQuickSearch")
    ;~ vim.map("<SP-g>c", "<cm_CloseCurrentTab>", "TCQuickSearch")
    ;~ vim.map("<SP-g>b", "<cm_CompareFilesByContent>", "TCQuickSearch")
    ;~ vim.map("<SP-g>e", "<cm_Exchange>", "TCQuickSearch")
    ;~ vim.map("<SP-g>r", "<TC_ReOpenTab>", "TCQuickSearch")
    ;~ vim.map("<SP-g>w", "<cm_ExchangeWithTabs>", "TCQuickSearch")
    ;~ vim.map("<SP-g>q", "<TC_HomeSelect>", "TCQuickSearch")
    ;~ vim.map("<SP-g>/", "<TC_EndSelect>", "TCQuickSearch")
    vim.map("<SP-g>1", "<cm_SrcActivateTab1>", "TCQuickSearch")
    vim.map("<SP-g>2", "<cm_SrcActivateTab2>", "TCQuickSearch")
    vim.map("<SP-g>3", "<cm_SrcActivateTab3>", "TCQuickSearch")
    vim.map("<SP-g>4", "<cm_SrcActivateTab4>", "TCQuickSearch")
    vim.map("<SP-g>5", "<cm_SrcActivateTab5>", "TCQuickSearch")
    vim.map("<SP-g>s", "<TC_FileUnlock>", "TCQuickSearch")    
    vim.map("<SP-g>d", "<TC_FileUnlockDelete>", "TCQuickSearch")    
    vim.map("<SP-g>e", "<TC_EXOpen>", "TCQuickSearch")  


	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	vim.map("<SP-z>f", "<cm_SrcByName>", "TCQuickSearch")
    vim.map("<SP-z>e", "<cm_SrcByExt>", "TCQuickSearch")
    vim.map("<SP-z>s", "<cm_SrcBySize>", "TCQuickSearch")
    vim.map("<SP-z>d", "<cm_SrcByDateTime>", "TCQuickSearch")
    vim.map("<SP-z>r", "<cm_SrcNegOrder>", "TCQuickSearch")
    vim.map("<SP-z>1", "<cm_SrcSortByCol1>", "TCQuickSearch")
    vim.map("<SP-z>2", "<cm_SrcSortByCol2>", "TCQuickSearch")
    vim.map("<SP-z>3", "<cm_SrcSortByCol3>", "TCQuickSearch")
    vim.map("<SP-z>4", "<cm_SrcSortByCol4>", "TCQuickSearch")
    vim.map("<SP-z>5", "<cm_SrcSortByCol5>", "TCQuickSearch")
    vim.map("<SP-z>z", "<TC_Undo>", "TCQuickSearch")   
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	vim.map("<SP-,>b", "<cm_VisButtonbar>", "TCQuickSearch")
    vim.map("<SP-,>c", "<cm_VisDriveCombo>", "TCQuickSearch")
    vim.map("<SP-,>d", "<cm_VisDriveButtons>", "TCQuickSearch")
    vim.map("<SP-,>e", "<cm_CommandBrowser>", "TCQuickSearch")
    vim.map("<SP-,>f", "<cm_VisKeyButtons>", "TCQuickSearch")
    vim.map("<SP-,>h", "<cm_SwitchIgnoreList>", "TCQuickSearch")
    vim.map("<SP-,>m", "<TC_ToggleMenu>", "TCQuickSearch")
    vim.map("<SP-,>n", "<cm_VisCmdLine>", "TCQuickSearch")
    vim.map("<SP-,>o", "<cm_VisTwoDriveButtons>", "TCQuickSearch")
    vim.map("<SP-,>r", "<cm_VisDriveCombo>", "TCQuickSearch")
    vim.map("<SP-,>s", "<cm_VisStatusbar>", "TCQuickSearch")
    vim.map("<SP-,>t", "<cm_VisTabHeader>", "TCQuickSearch")
    vim.map("<SP-,>w", "<cm_VisDirTabs>", "TCQuickSearch")
    vim.map("<SP-,>a", "<TC_StyleC40000>", "TCQuickSearch")
    vim.map("<SP-,>,", "<cm_SrcThumbs>", "TCQuickSearch")
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	vim.map("<SP-.>z", "<cm_50Percent>", "TCQuickSearch")
    vim.map("<SP-.>h", "<TC_Toggle_50_100Percent_V>", "TCQuickSearch")
    vim.map("<SP-.>i", "<TC_WinMaxLeft>", "TCQuickSearch")
    vim.map("<SP-.>o", "<TC_WinMaxRight>", "TCQuickSearch")
    vim.map("<SP-.>t", "<TC_AlwayOnTop>", "TCQuickSearch")
    vim.map("<SP-.>n", "<cm_Minimize>", "TCQuickSearch")
    vim.map("<SP-.>m", "<cm_Maximize>", "TCQuickSearch")
    vim.map("<SP-.>r", "<cm_Restore>", "TCQuickSearch")
    vim.map("<SP-.>v", "<cm_VerticalPanels>", "TCQuickSearch")
    


