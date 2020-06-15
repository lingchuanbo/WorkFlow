;DynamicFileMenu.ahk
;by BGM 动态菜单 1.1
;修改BoBO 支持多格式   *.ms|*.mse [|]分开
;http://www.autohotkey.com/board/topic/95219-dynamicfilemenuahk/

menu_fromfiles(submenuname, menutitle, whatsub, whatdir, filemask="*", parentmenu="", folders=1){
        menucount := 0
        filemasks=%filemask%
        filemasksArray := StrSplit(filemasks, "|") ; 裁减支持格式
        ; MsgBox, %filemaskArray%
        loop, %whatdir%\*, 1, 0
        {
            if(file_isfolder(A_LoopFileFullPath)){
                if(folders){
                      menucount := menu_fromfiles(A_LoopFileFullPath, a_loopfilename, whatsub, A_LoopFileFullPath, filemask, submenuname, folders)                              
                }
            }else{
                    Loop % filemasksArray.MaxIndex() ; 循环获取支持格式
                    {
                        this_file := filemasksArray[a_index]
                        ; loop, %A_LoopFileDir%\%filemask%, 0, 0
                        loop, %A_LoopFileDir%\%this_file%, 0, 0
                        ; loop, %A_LoopFileDir%\%TemA%, 0, 0 ; 添加多格式
                        {
                            menu, %submenuname%, add, %a_loopfilename%, %whatsub%
                            menucount++               
                        }     
                    }           
            }
        }
        if(parentmenu && menucount){
            menu, %parentmenu%, add, %menutitle%, :%submenuname%
            return menucount
        } 
        return menu_fromfiles
}

;fetches the correct path from the menu
menu_itempath(whatmenu, whatdir){
    if(a_thismenu = whatmenu){
    endpath = %whatdir%\%a_thismenuitem%
        return endpath
    }else{
        endpath = %a_thismenu%\%a_thismenuitem%
        return endpath
    }
}

;如果项目是文件夹，则返回true；如果是文件，则返回false
file_isfolder(whatfile){
    lastchar := substr(whatfile, 0, 1) ;从字符串获取最后一个字符
    if(lastchar != "\")
        whatfile := whatfile . "\"
    if(fileexist(whatfile))
        return true
}



