; RunZ:webAi
; 翻译

webAi:
    @("jqr", "天气：输入：天气深圳 `n 中英翻译：输入：翻译i love you `n 智能聊天： 输入：你好 `n 笑话： 输入：笑话 `n 歌词⑴：输入：歌词后来 `n 歌词⑵：输入：歌词后来-刘若英 `n 计算⑴：输入：计算1+1*2/3-4 `n 计算⑵：输入：1+1*2/3-4 `n ＩＰ⑴：输入：归属127.0.0.1 `n ＩＰ⑵：输入：127.0.0.1 `n 手机⑴：输入：归属13430108888 `n 手机⑵：输入：13430108888 `n 成语查询：输入：成语一生一世 `n 五笔/拼音：输入：好字的五笔/拼音")
    ; @("xw", "新闻")
return


jqr:
    word := Arg == "" ? clipboard : Arg
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    ;~ http://doc.tianqiapi.com/603579 接口获取
    ApiHttp := "http://api.qingyunke.com/api.php?key=free&appid=0&msg=" + word
    WebRequest.Open("GET", ApiHttp)  ;北京 不同地区更新此链接即可
    WebRequest.Send()
    result := WebRequest.ResponseText
    Clipboard:=result
    content := json(result, "content")

    DisplayResult(RegExReplace(JavaEscapedToUnicode(content),"{br}", "`n"))
return

; xw:
;     word := Arg == "" ? clipboard : Arg
;     WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
;     ;~ http://doc.tianqiapi.com/603579 接口获取
;     ApiHttp := "https://www.inoreader.com/stream/user/1006151627/tag/0.%E4%BC%A0%E7%BB%9F%E5%AA%92%E4%BD%93/view/json.json"
    
;     WebRequest.Open("GET", ApiHttp)  ;北京 不同地区更新此链接即可
;     WebRequest.Send()
;     result := WebRequest.ResponseText
;     Clipboard:=result
;     content := json(result, "items")

;     DisplayResult(RegExReplace(JavaEscapedToUnicode(content),"{br}", "`n"))
; return
