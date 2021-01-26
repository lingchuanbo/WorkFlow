; RunZ:Search
; 搜索

Search:
    @("ssgg", "Google搜索")
    @("ssbd", "Baidu搜索")
    @("ssdj", "多吉搜索")
    @("ssmg", "Magi搜索")
    @("biliblili", "在 Bilibili 搜索视频")
    @("youtube", "在 YouTuBe 站搜索视频")
    ; @("qimai", "在 七麦 查分析")
    
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

ssdj:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://www.dogedoge.com/results?q=%word%
return

ssmg:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://magi.com/search?q=%word%
return

biliblili:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://search.bilibili.com/all?keyword=%word%
return

youtube:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://www.youtube.com/results?search_query=%word%
return


qimai:
    word := UrlEncode(Arg == "" ? clipboard : Arg)
    Run, https://www.qimai.cn/search/index/country/cn/search/%word%
return



; !space:: ;cosea典藏级原创代码之谷歌搜索终极版
; run https://www.google.com/search?q=%clipboard% ;用google搜索剪切板的内容
; clipboard1=%clipboard%&tbs=qdr:1,sbd:1
; run https://www.google.com/search?q=%clipboard1% ;按时间排序
; run https://www.google.com/search?q=%clipboard%&tbs=qdr:m ;只显示最近一个月信息
; run https://www.google.com/search?q=%clipboard%&tbs=qdr:y ;只显示最近一年信息
; run https://www.google.com/search?q=%clipboard%&as_filetype=pdf ;指定PDF文件
; run https://www.google.com/search?q=%clipboard%&tbs=li:1 ;精确匹配
; run https://www.google.com/search?&as_epq=%clipboard% ;完全匹配
; run https://www.google.com/search?q=%clipboard% inurl:gov ;url包括gov的网站信息
; run https://www.google.com/search?q=intitle:%clipboard% ;文章标题中包含关键词的结果
; run https://www.google.com/search?q=%clipboard%&source=lnt&lr=lang_zh-CN|lang_zh-TW ;&source=lnt&lr=lang_zh-CN|lang_zh-TW，指定中文网页
; run https://www.google.com/search?q=%clipboard%&tbm=isch&tbs=imgo:1 ;&tbm=isch指定搜索谷歌图片
; run https://www.google.com/search?q=%clipboard%&tbm=isch&tbs=isz:l ;将URL更改为大尺寸图片&tbs=isz:l
; run https://image.baidu.com/search/index?z=3&tn=baiduimage&word=%clipboard% ;z=3是大尺寸，z=9是特大尺寸
; run https://www.behance.net/search?content=projects&sort=appreciations&time=week&featured_on_behance=true&search=%clipboard%
; run https://www.zcool.com.cn/search/content?&word=%clipboard%
; clipboard2=%clipboard%&tbm=isch&tbs=qdr:m,isz:l,imgo:1
; run https://www.google.com/search?q=%clipboard2% ;为URL添加&tbs=qdr:m，只显示新近一个月内的图片，&tbs=imgo:1，显示图片大小
; tooltip, 那晚，风也美，人也美。。。
; sleep 1500
; tooltip,
; return