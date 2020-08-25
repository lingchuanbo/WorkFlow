; RunZ:Translate
; 翻译

Translate:
    @("yd", "有道词典在线翻译")
    @("fy", "翻译")
    @("tq", "天气")

return

fy:
    word := Arg == "" ? clipboard : Arg
    getWord:=YouDaoApi(word)
    ExplorerPath := word
    if (g_Conf.Config.Translate=0)
    {
        Youdao_yb:= json(getWord, "basic.phonetic") ;音标
	    Youdao_jbsy:= json(getWord, "basic.explains") ;基本释义
	    Youdao_wlsy:= json(getWord, "web.value") ;网络释义

        Youdao=音标:%Youdao_yb%`n`n基本释义:%Youdao_jbsy%`n`n%Youdao_wlsy%`n`n`n来源:网易有道翻译
	    DisplayResult(Youdao)
    }
    if (g_Conf.Config.Translate=1)
    {
        if (RegExMatch(ExplorerPath,"[^\x00-\xff]+"))
        {
            DisplayResult(GoogleTranslate(word,from := "auto", to :=0409)"`n来源:Google翻译")
            return

        }
        if (RegExMatch(ExplorerPath,"^[A-Za-z]+"))
        {
            DisplayResult(GoogleTranslate(word)"`n`n`来源:Google翻译")
            return
        }
    }
    ; 谷歌翻译中英文
    ; word := Arg == "" ? clipboard : Arg
    ; ExplorerPath := word
	; if (RegExMatch(ExplorerPath,"[^\x00-\xff]+"))
	; {
    ;     DisplayResult(GoogleTranslate(word,from := "auto", to :=0409))
	; 	return

	; }
	; if (RegExMatch(ExplorerPath,"^[A-Za-z]+"))
	; {
	; 	DisplayResult(GoogleTranslate(word))
	; 	return

	; }
	; DisplayResult(GoogleTranslate(word))
return


yd:
    word := Arg == "" ? clipboard : Arg
    getWord:=YouDaoApi(word)

    Youdao_yb:= json(getWord, "basic.phonetic") ;音标
	Youdao_jbsy:= json(getWord, "basic.explains") ;基本释义
	Youdao_wlsy:= json(getWord, "web.value") ;网络释义

    Youdao=音标:%Youdao_yb%`n`n基本释义:%Youdao_jbsy%`n`n%Youdao_wlsy%`n`n

	DisplayResult(Youdao)
return

tq:

    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    ;~ http://doc.tianqiapi.com/603579 接口获取
    WebRequest.Open("GET", "http://www.tianqiapi.com/api?version=v9&appid=87251199&appsecret=YHNEsQ3g")  ;北京 不同地区更新此链接即可
    WebRequest.Send()
    result := WebRequest.ResponseText
    Clipboard:=result
    ; 用 json 提取数据, 和 javascript 类似
    weatherCity := json(result, "city")
    weatherTime := json(result, "update_time")
    weatherDay := json(result, "data.day")T
    weatherAlarm := json(result, "data.alarm.alarm_content")
    weatherWeekDay := json(result, "data.wea_day")

    weatherTem:= json(result, "data.tem")
    weatherTem1:= json(result, "data.tem1")
    weatherTem2:= json(result, "data.tem2")

    weather=城市:%weatherCity% 更新时间:%weatherTime%`n`n日期:%weatherDay%`n`n天气:%weatherWeekDay%`n`n当前温度:%weatherTem%  白天温度:%weatherTem1% 晚上温度:%weatherTem2% `n`n%weatherAlarm%
    
    DisplayResult(JavaEscapedToUnicode(weather))
return


;Json乱码转中文
JavaEscapedToUnicode(s) {
	i := 1
	while j := RegExMatch(s, "\\u[A-Fa-f0-9]{1,4}", m, i)
		e .= SubStr(s, i, j-i) Chr("0x" SubStr(m, 3)), i := j + StrLen(m)
	return e . SubStr(s, i)
}