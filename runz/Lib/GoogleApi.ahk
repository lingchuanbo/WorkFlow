GoogleTranslateApi(KeyWord:="", api:="google", lang:="zh-cn|auto", paras*)
{
    static apis:="|google|bing|microsoft|youdao|yd_key|go_key|"
        , lans :="auto|af|af-ZA|sq|sq-AL|ar|ar-DZ|ar-BH|ar-EG|ar-IQ|ar-JO|ar-KW|ar-LB|ar-LY|ar-MA|ar-OM|ar-QA|ar-SA|ar-SY|ar-TN|ar-AE|ar-YE|hy|hy-AM|"
            . "az|az-AZ-Cyrl|az-AZ-Latn|eu|eu-ES|be|be-BY|bg|bg-BG|ca|ca-ES|zh-HK|zh-MO|zh-CN|zh-CHS|zh-SG|zh-TW|zh-CHT|hr|hr-HR|cs|cs-CZ|da|da-DK|div|"
            . "div-MV|nl|nl-BE|nl-NL|en|en-AU|en-BZ|en-CA|en-CB|en-IE|en-JM|en-NZ|en-PH|en-ZA|en-TT|en-GB|en-US|en-ZW|et|et-EE|fo|fo-FO|fa|fa-IR|fi|"
            . "fi-FI|fr|fr-BE|fr-CA|fr-FR|fr-LU|fr-MC|fr-CH|gl|gl-ES|ka|ka-GE|de|de-AT|de-DE|de-LI|de-LU|de-CH|el|el-GR|gu|gu-IN|he|he-IL|hi|hi-IN|hu|"
            . "hu-HU|is|is-IS|id|id-ID|it|it-IT|it-CH|ja|ja-JP|kn|kn-IN|kk|kk-KZ|kok|kok-IN|ko|ko-KR|ky|ky-KZ|lv|lv-LV|lt|lt-LT|mk|mk-MK|ms|ms-BN|ms-MY|mr|"
            . "mr-IN|mn|mn-MN|no|nb-NO|nn-NO|pl|pl-PL|pt|pt-BR|pt-PT|pa|pa-IN|ro|ro-RO|ru|ru-RU|sa|sa-IN|sr-SP-Cyrl|sr-SP-Latn|sk|sk-SK|sl|sl-SI|es|es-AR|"
            . "es-BO|es-CL|es-CO|es-CR|es-DO|es-EC|es-SV|es-GT|es-HN|es-MX|es-NI|es-PA|es-PY|es-PE|es-PR|es-ES|es-UY|es-VE|sw|sw-KE|sv|sv-FI|sv-SE|syr|"
            . "syr-SY|ta|ta-IN|tt|tt-RU|te|te-IN|th|th-TH|tr|tr-TR|uk|uk-UA|ur|ur-PK|uz|uz-UZ-Cyrl|uz-UZ-Latn|vi|vi-VN|"
        , reggoogle := "^\[+""(.*?)"","""
        , regyoudao := "^.*?translation"":\[""(.*?)""\],"""
        , regbing   := "^<[^>]+>(.*?)<\/string>$"
        , ls1:="zh-cn", ls:="auto"
    uapi:={}, ulang:={}
    loop, Parse, api, `|
    {
        uapi[A_Index] := A_LoopField
    }
    loop, Parse, lang, `|
    {
        ulang[A_Index] := A_LoopField
    }
    loop, % (ua:=StrLen(uapi[1]))
    {
        api:=(tag:=RegExMatch(apis,"\b(?<!-)" SubStr(uapi[1], 1, ua+1-(i:=a_index))))
            ? SubStr(apis, tag, InStr(apis, "|",, tag)-tag)
            : (i=ua
                ? "google"
                : "")
        if api
            break
    }
    api := api = "microsoft" ? "bing" : api
    if (api="google" && InStr(uapi[1],"cn"))
        uapi[4]:=1
    loop, 2 ;ulang.MaxIndex()
    {
        j:=A_Index
            , ulang[j]:=InStr(lans, "|" ulang[j] "|") ? ulang[j] : (ls%j%? ls%j%: ls)
    }
    start := A_TickCount
        , url := u%api% KeyWord
    if IsFunc("translateApi_" api)
        url := translateApi_%api%(KeyWord, uapi, ulang)
    else
        return
    ;~ sbox(api, url, uapi, ulang)
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("GET", url)
    WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
    WebRequest.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0")
    WebRequest.Send()
    result := WebRequest.ResponseText
    ObjRelease(WebRequest)
    ;~ WebRequest.Close()
    RegExMatch(result, "S)" reg%api%, txt)
    return txt1
}
translateApi_bing(paras*)
{
/*
http://api.microsofttranslator.com/v2/Http.svc/Translate?appId=74FE953EB48E1487E94F4BF9C425B6290FF2DA48&from=" . langfrom . "&to=" . langto . "&text=" . var
*/
    static host1:= "http://api.microsofttranslator.com/v2/Http.svc/Translate?appId=74FE953EB48E1487E94F4BF9C425B6290FF2DA48"
        , KeyWord:=1, apis:=2, lans:=3
        , a_api:=1, a_id:=2, a_key:=3, a_gcn:=4
        , tl:=1, sl:=2
    url := host1
        . "&from=" (paras[lans][sl] = "auto" ? "" : RegExReplace(paras[lans][sl], "S)-.*$"))
        . "&to=" (RegExReplace(paras[lans][tl], "S)-.*$"))
        . "&text=" paras[KeyWord]
    return url
}
translateApi_google(paras*)
{
/*
http://translate.google.cn/translate_a/single?client=at&sl=auto&tl=zh-CN&dt=t&q=
https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=en-gb&dt=t&q=
*/
    static host1:= "https://translate.google.cn/translate_a/single?client=at"
        , host2 := "https://translate.googleapis.com/translate_a/single?client=gtx"
        , KeyWord:=1, apis:=2, lans:=3
        , a_api:=1, a_id:=2, a_key:=3, a_gcn:=4
        , tl:=1, sl:=2
    url := (paras[apis][a_gcn] ? host1 : host2)
        . "&sl=" paras[lans][sl]
        . "&tl=" paras[lans][tl]
        . "&dt=t"
        . "&q=" paras[KeyWord]
    return url
}
translateApi_youdao(paras*)
{
/*
http://fanyi.youdao.com/fanyiapi.do?keyfrom=qqqqqqqq123&key=86514254&type=data&doctype=json&version=1.1&q=
*/
    static host1:= "http://fanyi.youdao.com/fanyiapi.do"
        , KeyWord:=1, apis:=2, lans:=3
        , a_api:=1, a_id:=2, a_key:=3, a_gcn:=4
        , tl:=1, sl:=2
    Sleep, 3000
    return host1
        . "?keyfrom=" (paras[apis][a_id]?paras[apis][a_id]:"qqqqqqqq123")
        . "&key=" (paras[apis][a_key]?paras[apis][a_key]:"86514254")
        . "&type=data"
        . "&doctype=json"
        . "&version=1.1"
        . "&q=" paras[KeyWord]
}
Uri_Enc(l:="")
{
    static enc:="Encode"
    if IsFunc("Uri_Encode")
        l := Uri_%enc%(l)
    l := RegExReplace(l,"S)""|`n|`r|\,", ". ")
    return l
}
GoogleTranslate(str, from := "auto", to :=0)  {
   static JS := CreateScriptObj(), _ := JS.( GetJScripObject() ) := JS.("delete ActiveXObject; delete GetObject;")
;  static JS := CreateScriptObj(), _ := JS.( GetJScript() ) := JS.("delete ActiveXObject; delete GetObject;")
   if(!to)				; If no "to" parameter was passed
      to := GetISOLanguageCode()	; Assign the system (OS) language to "to"
   if(from = to)			; If the "from" and "to" parameters are the same
      Return str			; Abort translation and return the original string
   json := SendRequest(JS, str, to, from, proxy := "")
   oJSON := JS.("(" . json . ")")
 
   if !IsObject(oJSON[1])  {
      Loop % oJSON[0].length
         trans .= oJSON[0][A_Index - 1][0]
   }
   else  {
      MainTransText := oJSON[0][0][0]
      Loop % oJSON[1].length  {
         trans .= "`n+"
         obj := oJSON[1][A_Index-1][1]
         Loop % obj.length  {
            txt := obj[A_Index - 1]
            trans .= (MainTransText = txt ? "" : "`n" txt)
         }
      }
   }
   if !IsObject(oJSON[1])
      MainTransText := trans := Trim(trans, ",+`n ")
   else
      trans := MainTransText . "`n+`n" . Trim(trans, ",+`n ")
 
   from := oJSON[2]
   trans := Trim(trans, ",+`n ")
   Return trans
}
 
; Take a 4-digit language code or (if no parameter) the current language code and return the corresponding 2-digit ISO code
GetISOLanguageCode(lang := 0) {
   LanguageCodeArray := { 0436: "af" ; Afrikaans
			, 041c: "sq" ; Albanian
			, 0401: "ar" ; Arabic_Saudi_Arabia
			, 0801: "ar" ; Arabic_Iraq
			, 0c01: "ar" ; Arabic_Egypt
			, 1001: "ar" ; Arabic_Libya
			, 1401: "ar" ; Arabic_Algeria
			, 1801: "ar" ; Arabic_Morocco
			, 1c01: "ar" ; Arabic_Tunisia
			, 2001: "ar" ; Arabic_Oman
			, 2401: "ar" ; Arabic_Yemen
			, 2801: "ar" ; Arabic_Syria
			, 2c01: "ar" ; Arabic_Jordan
			, 3001: "ar" ; Arabic_Lebanon
			, 3401: "ar" ; Arabic_Kuwait
			, 3801: "ar" ; Arabic_UAE
			, 3c01: "ar" ; Arabic_Bahrain
			, 042c: "az" ; Azeri_Latin
			, 082c: "az" ; Azeri_Cyrillic
			, 042d: "eu" ; Basque
			, 0423: "be" ; Belarusian
			, 0402: "bg" ; Bulgarian
			, 0403: "ca" ; Catalan
			, 0404: "zh-CN" ; Chinese_Taiwan
			, 0804: "zh-CN" ; Chinese_PRC
			, 0c04: "zh-CN" ; Chinese_Hong_Kong
			, 1004: "zh-CN" ; Chinese_Singapore
			, 1404: "zh-CN" ; Chinese_Macau
			, 041a: "hr" ; Croatian
			, 0405: "cs" ; Czech
			, 0406: "da" ; Danish
			, 0413: "nl" ; Dutch_Standard
			, 0813: "nl" ; Dutch_Belgian
			, 0409: "en" ; English_United_States
			, 0809: "en" ; English_United_Kingdom
			, 0c09: "en" ; English_Australian
			, 1009: "en" ; English_Canadian
			, 1409: "en" ; English_New_Zealand
			, 1809: "en" ; English_Irish
			, 1c09: "en" ; English_South_Africa
			, 2009: "en" ; English_Jamaica
			, 2409: "en" ; English_Caribbean
			, 2809: "en" ; English_Belize
			, 2c09: "en" ; English_Trinidad
			, 3009: "en" ; English_Zimbabwe
			, 3409: "en" ; English_Philippines
			, 0425: "et" ; Estonian
			, 040b: "fi" ; Finnish
			, 040c: "fr" ; French_Standard
			, 080c: "fr" ; French_Belgian
			, 0c0c: "fr" ; French_Canadian
			, 100c: "fr" ; French_Swiss
			, 140c: "fr" ; French_Luxembourg
			, 180c: "fr" ; French_Monaco
			, 0437: "ka" ; Georgian
			, 0407: "de" ; German_Standard
			, 0807: "de" ; German_Swiss
			, 0c07: "de" ; German_Austrian
			, 1007: "de" ; German_Luxembourg
			, 1407: "de" ; German_Liechtenstein
			, 0408: "el" ; Greek
			, 040d: "iw" ; Hebrew
			, 0439: "hi" ; Hindi
			, 040e: "hu" ; Hungarian
			, 040f: "is" ; Icelandic
			, 0421: "id" ; Indonesian
			, 0410: "it" ; Italian_Standard
			, 0810: "it" ; Italian_Swiss
			, 0411: "ja" ; Japanese
			, 0412: "ko" ; Korean
			, 0426: "lv" ; Latvian
			, 0427: "lt" ; Lithuanian
			, 042f: "mk" ; Macedonian
			, 043e: "ms" ; Malay_Malaysia
			, 083e: "ms" ; Malay_Brunei_Darussalam
			, 0414: "no" ; Norwegian_Bokmal
			, 0814: "no" ; Norwegian_Nynorsk
			, 0415: "pl" ; Polish
			, 0416: "pt" ; Portuguese_Brazilian
			, 0816: "pt" ; Portuguese_Standard
			, 0418: "ro" ; Romanian
			, 0419: "ru" ; Russian
			, 081a: "sr" ; Serbian_Latin
			, 0c1a: "sr" ; Serbian_Cyrillic
			, 041b: "sk" ; Slovak
			, 0424: "sl" ; Slovenian
			, 040a: "es" ; Spanish_Traditional_Sort
			, 080a: "es" ; Spanish_Mexican
			, 0c0a: "es" ; Spanish_Modern_Sort
			, 100a: "es" ; Spanish_Guatemala
			, 140a: "es" ; Spanish_Costa_Rica
			, 180a: "es" ; Spanish_Panama
			, 1c0a: "es" ; Spanish_Dominican_Republic
			, 200a: "es" ; Spanish_Venezuela
			, 240a: "es" ; Spanish_Colombia
			, 280a: "es" ; Spanish_Peru
			, 2c0a: "es" ; Spanish_Argentina
			, 300a: "es" ; Spanish_Ecuador
			, 340a: "es" ; Spanish_Chile
			, 380a: "es" ; Spanish_Uruguay
			, 3c0a: "es" ; Spanish_Paraguay
			, 400a: "es" ; Spanish_Bolivia
			, 440a: "es" ; Spanish_El_Salvador
			, 480a: "es" ; Spanish_Honduras
			, 4c0a: "es" ; Spanish_Nicaragua
			, 500a: "es" ; Spanish_Puerto_Rico
			, 0441: "sw" ; Swahili
			, 041d: "sv" ; Swedish
			, 081d: "sv" ; Swedish_Finland
			, 0449: "ta" ; Tamil
			, 041e: "th" ; Thai
			, 041f: "tr" ; Turkish
			, 0422: "uk" ; Ukrainian
			, 0420: "ur" ; Urdu
			, 042a: "vi"} ; Vietnamese
   If(lang)
     Return LanguageCodeArray[lang]
   Else Return LanguageCodeArray[A_Language]
}
SendRequest(JS, str, tl, sl, proxy) {
   ComObjError(false)
   http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
   ( proxy && http.SetProxy(2, proxy) )
   ;~ http.open( "POST", "https://translate.google.com/translate_a/single?client=webapp&sl="
   http.open( "POST", "https://translate.google.cn/translate_a/single?client=webapp&sl="
      . sl . "&tl=" . tl . "&hl=" . tl
      . "&dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t&ie=UTF-8&oe=UTF-8&otf=0&ssel=0&tsel=0&pc=1&kc=1"
      . "&tk=" . JS.("tk").(str), 1 )
 
   http.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded;charset=utf-8")
   http.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0")
   http.send("q=" . URIEncode(str))
   http.WaitForResponse(-1)
   Return http.responsetext
}
URIEncode(str, encoding := "UTF-8")  {
   VarSetCapacity(var, StrPut(str, encoding))
   StrPut(str, &var, encoding)
 
   While code := NumGet(Var, A_Index - 1, "UChar")  {
      bool := (code > 0x7F || code < 0x30 || code = 0x3D)
      UrlStr .= bool ? "%" . Format("{:02X}", code) : Chr(code)
   }
   Return UrlStr
}
 
; GetJScript()
; {
;    script =
;    (
;       var TKK = ((function() {
;         var a = 561666268;
;         var b = 1526272306;
;         return 406398 + '.' + (a + b);
;       })());
 
;       function b(a, b) {
;         for (var d = 0; d < b.length - 2; d += 3) {
;             var c = b.charAt(d + 2),
;                 c = "a" <= c ? c.charCodeAt(0) - 87 : Number(c),
;                 c = "+" == b.charAt(d + 1) ? a >>> c : a << c;
;             a = "+" == b.charAt(d) ? a + c & 4294967295 : a ^ c
;         }
;         return a
;       }
 
;       function tk(a) {
;           for (var e = TKK.split("."), h = Number(e[0]) || 0, g = [], d = 0, f = 0; f < a.length; f++) {
;               var c = a.charCodeAt(f);
;               128 > c ? g[d++] = c : (2048 > c ? g[d++] = c >> 6 | 192 : (55296 == (c & 64512) && f + 1 < a.length && 56320 == (a.charCodeAt(f + 1) & 64512) ?
;               (c = 65536 + ((c & 1023) << 10) + (a.charCodeAt(++f) & 1023), g[d++] = c >> 18 | 240,
;               g[d++] = c >> 12 & 63 | 128) : g[d++] = c >> 12 | 224, g[d++] = c >> 6 & 63 | 128), g[d++] = c & 63 | 128)
;           }
;           a = h;
;           for (d = 0; d < g.length; d++) a += g[d], a = b(a, "+-a^+6");
;           a = b(a, "+-3^+b+-f");
;           a ^= Number(e[1]) || 0;
;           0 > a && (a = (a & 2147483647) + 2147483648);
;           a `%= 1E6;
;           return a.toString() + "." + (a ^ h)
;       }
;    )
;    Return script
; }

GetJScripObject()  {   ; Here we create temp file to get a custom COM server using Windows Script Components (WSC) technology.
   VarSetCapacity(tmpFile, ((MAX_PATH := 260) - 14) << !!A_IsUnicode, 0)
   DllCall("GetTempFileName", Str, A_Temp, Str, "AHK", UInt, 0, Str, tmpFile)
   
   FileAppend,
   (
   <component>
   <public><method name='eval'/></public>
   <script language='JScript'></script>
   </component>
   ), % tmpFile
   
   JS := ObjBindMethod( ComObjGet("script:" . tmpFile), "eval" ) ; ComObjGet("script:" . tmpFile) is the way to invoke com-object without registration in the system
   FileDelete, % tmpFile
   Return JS
}

CreateScriptObj() {
   static doc
   doc := ComObjCreate("htmlfile")
   doc.write("<meta http-equiv='X-UA-Compatible' content='IE=9'>")
   Return ObjBindMethod(doc.parentWindow, "eval")
}

class DeepLTranslator {
	static formatURL := "https://www.deepl.com/en/translator#{2:s}/{3:s}/{1:s}"
	__New() {
		this.IE := ComObjCreate("InternetExplorer.Application") 
	}
	__Delete() {
		this.IE.Quit
	}
	translate(sourceText, languageOut, languageIn := "auto") {
		sourceURL := this.uriEncode(sourceText)
		url := Format(This.formatURL, sourceURL, languageIn, languageOut)
		this.navigate(url)
		return this.translation() 
	}
	
	navigate(url) {
		this.IE.Navigate(url)
		While (this.IE.readyState != 4 || this.IE.document.readyState != "complete" || this.IE.busy)
			Sleep 50
	}
	
	translation() {
		While ((result := this.IE.document.getElementsByTagName("textarea")[1].value) = "")
			Sleep 50
		return result
	}
	
	uriEncode(sourceText) {
		return StrReplace(sourceText, " ", "%20")
	}
}

YouDaoApi(KeyWord)
{
    KeyWord:=CustomFunc_SkSub_UrlEncode(KeyWord,"utf-8")
	url:="http://fanyi.youdao.com/fanyiapi.do?keyfrom=qqqqqqqq123&key=86514254&type=data&doctype=json&version=1.1&q=" . KeyWord
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("GET", url)
    WebRequest.Send()
    result := WebRequest.ResponseText
    Return result
}


json(ByRef js, s, v = "")
{
	j = %js%
	Loop, Parse, s, .
	{
		p = 2
		RegExMatch(A_LoopField, "([+\-]?)([^[]+)((?:\[\d+\])*)", q)
		Loop {
			If (!p := RegExMatch(j, "(?<!\\)(""|')([^\1]+?)(?<!\\)(?-1)\s*:\s*((\{(?:[^{}]++|(?-1))*\})|(\[(?:[^[\]]++|(?-1))*\])|"
				. "(?<!\\)(""|')[^\7]*?(?<!\\)(?-1)|[+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:,|$|\})", x, p))
				Return
			Else If (x2 == q2 or q2 == "*") {
				j = %x3%
				z += p + StrLen(x2) - 2
				If (q3 != "" and InStr(j, "[") == 1) {
					StringTrimRight, q3, q3, 1
					Loop, Parse, q3, ], [
					{
						z += 1 + RegExMatch(SubStr(j, 2, -1), "^(?:\s*((\[(?:[^[\]]++|(?-1))*\])|(\{(?:[^{\}]++|(?-1))*\})|[^,]*?)\s*(?:,|$)){" . SubStr(A_LoopField, 1) + 1 . "}", x)
						j = %x1%
					}
				}
				Break
			}
			Else p += StrLen(x)
		}
	}
	If v !=
	{
		vs = "
		If (RegExMatch(v, "^\s*(?:""|')*\s*([+\-]?\d+(?:\.\d*)?|true|false|null?)\s*(?:""|')*\s*$", vx)
			and (vx1 + 0 or vx1 == 0 or vx1 == "true" or vx1 == "false" or vx1 == "null" or vx1 == "nul"))
			vs := "", v := vx1
		StringReplace, v, v, ", \", All
		js := SubStr(js, 1, z := RegExMatch(js, ":\s*", zx, z) + StrLen(zx) - 1) . vs . v . vs . SubStr(js, z + StrLen(x3) + 1)
	}
	Return, j == "false" ? 0 : j == "true" ? 1 : j == "null" or j == "nul"
		? "" : SubStr(j, 1, 1) == """" ? SubStr(j, 2, -1) : j
}

CustomFunc_SkSub_UrlEncode(str, enc="UTF-8")
{
    enc:=trim(enc)
    If enc=
        Return str
   hex := "00", func := "msvcrt\" . (A_IsUnicode ? "swprintf" : "sprintf")
   VarSetCapacity(buff, size:=StrPut(str, enc)), StrPut(str, &buff, enc)
   While (code := NumGet(buff, A_Index - 1, "UChar")) && DllCall(func, "Str", hex, "Str", "%%%02X", "UChar", code, "Cdecl")
   encoded .= hex
   Return encoded
}