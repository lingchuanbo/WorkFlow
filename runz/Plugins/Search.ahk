; RunZ:Search
; 搜索

Search:
    @("ssgg", "Google搜索")
    @("ssbd", "Baidu搜索")
    @("ssdd", "多吉搜索")
    @("ssmg", "Magi搜索")
    
    ; @("jd", "京东")
return

ssgg:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://www.google.com.hk/#newwindow=1&safe=strict&q=%word%
return

ssbd:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://www.baidu.com/baidu?wd=%word%
return

ssdd:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://www.dogedoge.com/results?q=%word%
return

ssmg:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://magi.com/search?q=%word%
return
