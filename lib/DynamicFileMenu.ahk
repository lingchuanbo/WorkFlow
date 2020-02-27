;DynamicFileMenu.ahk
;by BGM 动态菜单
;http://www.autohotkey.com/board/topic/95219-dynamicfilemenuahk/

menu_fromfiles(submenuname, menutitle, whatsub, whatdir, filemask="*", parentmenu="", folders=1){
        menucount := 0
        loop, %whatdir%\*, 1, 0
        {
            if(file_isfolder(A_LoopFileFullPath)){
                if(folders){
                      menucount := menu_fromfiles(A_LoopFileFullPath, a_loopfilename, whatsub, A_LoopFileFullPath, filemask, submenuname, folders)                                   
                }
            }else{
                 loop, %A_LoopFileDir%\%filemask%, 0, 0
                {
                    menu, %submenuname%, add, %a_loopfilename%, %whatsub%
                    menucount++                
                }                
            }
        }
        if(parentmenu && menucount){
            menu, %parentmenu%, add, %menutitle%, :%submenuname%
            return menucount
        }       
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

;returns true if the item is a folder, false if is a file
file_isfolder(whatfile){
    lastchar := substr(whatfile, 0, 1) ;fetch the last character from the string
    if(lastchar != "\")
        whatfile := whatfile . "\"
    if(fileexist(whatfile))
        return true
}
;动态菜单结束