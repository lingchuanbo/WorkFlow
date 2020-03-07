; WinHttpRequest.ahk
; https://gist.github.com/tmplinshi/a74c7f0cc7f1510ce0ad
;	v1.06 (2018-07-12) - 增加默认 User-Agent
;	v1.05 (2017-09-07) - 增加 DetectCharset 选项
;	v1.04 (2017-08-29) - 增加自动使用响应头的编码
;	v1.03 (2016-01-18) - 增加“加载 gzip.dll 失败”提示，防止忘记复制 gzip.dll 到脚本目录。
; 	v1.02 (2015-12-26) - 修复在 XP 系统中解压 gzip 数据失败的问题。
; 	v1.01 (2015-12-07)

/*
	用法:
		WinHttpRequest( URL, ByRef In_POST__Out_Data="", ByRef In_Out_HEADERS="", Options="" )
	--------------------------------------------------------------------------------------------
	参数:
		URL               - 网址
		
		In_POST__Out_Data - POST数据/返回数据。
		                    若该变量为空则进行 GET 请求，否则为 POST
		                    
		In_Out_HEADERS    - 请求头/响应头（多个请求头用换行符分隔）
		
		Options           - 选项（多个选项用换行符分隔）

			NO_AUTO_REDIRECT - 禁止自动重定向
			Timeout: 秒钟    - 超时（默认为 30 秒）
			Proxy: IP:端口   - 代理
			Codepage: XXX    - 代码页。例如 Codepage: 65001
			Charset: 编码    - 字符集。例如 Charset: UTF-8
			SaveAs: 文件名   - 下载到文件
			Compressed       - 向网站请求 GZIP 压缩数据，并解压。
			                  （需要文件 gzip.dll -- http://pan.baidu.com/s/1pKqKTzt）
			Method: 请求方法 - 可以为 GET/POST/HEAD 其中的一个。
			                   这个选项可以省略，除非你需要 HEAD 请求，或者 POST 数据为空时强制使用 POST。
			DetectCharset    - 如果响应头没有包含编码，则继续从网页源码中检测
	--------------------------------------------------------------------------------------------
	返回:
		成功返回 -1, 超时返回 0, 无响应则返回为空
	--------------------------------------------------------------------------------------------
	清除 Cookies 的方法:
		WinHttpRequest( [] )
	--------------------------------------------------------------------------------------------
	示例:
		例1 - GET
			url := "https://www.baidu.com/"

			WinHttpRequest(url, ioData := "", ioHdr := "")
			; 也可以简单写成 WinHttpRequest(url, ioData)，
			; 但是一定要确保 ioData 为空，不然是进行 POST，而不是 GET

			MsgBox, % ioData

		例2 - POST
			url := "https://www.baidu.com/"
			postData := "key=value&key2=value2"
			reqHeaders =
			(LTrim
				User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0
				Referer: https://www.baidu.com
			)
			WinHttpRequest(url, ioData := postData, ioHdr := reqHeaders)
*/
WinHttpRequest( URL, ByRef In_POST__Out_Data="", ByRef In_Out_HEADERS="", Options="" )
{
	static nothing := ComObjError(0) ; 禁用 COM 错误提示
	static UserAgent := "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36"
	static oHTTP   := WinHttpRequest_Init(UserAgent)
	static oADO    := ComObjCreate("adodb.stream")

	If IsObject(URL) ; 如果第一个参数是数组，则重新创建 WinHttp 对象，以便清除 Cookies
		return oHTTP := ComObjCreate("WinHttp.WinHttpRequest.5.1"), oHTTP.Option(0) := UserAgent

	; 打开 URL
	If (In_POST__Out_Data != "") || InStr(Options, "Method: POST")
		oHTTP.Open("POST", URL, True)
	Else If InStr(Options, "Method: HEAD")
		oHTTP.Open("HEAD", URL, True)
	Else
		oHTTP.Open("GET", URL, True)

	; 解析请求头
	If In_Out_HEADERS
	{
		In_Out_HEADERS := Trim(In_Out_HEADERS, " `t`r`n")
		Loop, Parse, In_Out_HEADERS, `n, `r
		{
			If !( _pos := InStr(A_LoopField, ":") )
				Continue

			Header_Name  := SubStr(A_LoopField, 1, _pos-1)
			Header_Value := SubStr(A_LoopField, _pos+1)

			If (  Trim(Header_Value) != ""  )
				oHTTP.SetRequestHeader( Header_Name, Header_Value )
		}
	}

	If (In_POST__Out_Data != "") && !InStr(In_Out_HEADERS, "Content-Type:")
		oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")

	; 解析选项
	If Options
	{
		Loop, Parse, Options, `n, `r
		{
			If ( _pos := InStr(A_LoopField, "Timeout:") )
				Timeout := SubStr(A_LoopField, _pos+8)
			Else If ( _pos := InStr(A_LoopField, "Proxy:") )
				oHTTP.SetProxy( 2, SubStr(A_LoopField, _pos+6) )
			Else If ( _pos := InStr(A_LoopField, "Codepage:") )
				oHTTP.Option(2) := SubStr(A_LoopField, _pos+9)
		}

		oHTTP.Option(6) := InStr(Options, "NO_AUTO_REDIRECT") ? 0 : 1

		If InStr(Options, "Compressed")
			oHTTP.SetRequestHeader("Accept-Encoding", "gzip, deflate")
	}

	If (Timeout > 30)
		oHTTP.SetTimeouts(0, 60000, 30000, Timeout * 1000)

	; 发送请求
	oHTTP.Send(In_POST__Out_Data)
	retCode := oHTTP.WaitForResponse(Timeout ? Timeout : -1)

	; 自动检测编码
	If !InStr(Options, "Charset:") {
		if InStr(oHTTP.GetResponseHeader("Content-Type"), "charset=utf-8")
			Options .= "`n" . "Charset: UTF-8"
		else if !InStr(Options, "Compressed") && InStr(Options, "DetectCharset") {
			if RegExMatch(oHTTP.ResponseText, "i)<meta [^>]*?http-equiv=['""]Content-Type['""] [^>]*?charset=UTF-8")
				Options .= "`n" . "Charset: UTF-8"
		}
	}

	; 处理返回结果
	If InStr(Options, "Compressed")
	&& (oHTTP.GetResponseHeader("Content-Encoding") = "gzip") {
		body := oHTTP.ResponseBody
		size := body.MaxIndex() + 1

		VarSetCapacity(data, size)
		DllCall("oleaut32\SafeArrayAccessData", "ptr", ComObjValue(body), "ptr*", pdata)
		DllCall("RtlMoveMemory", "ptr", &data, "ptr", pdata, "ptr", size)
		DllCall("oleaut32\SafeArrayUnaccessData", "ptr", ComObjValue(body))

		size := GZIP_DecompressBuffer(data, size)

		; 不可以直接 ComObjValue(oHTTP.ResponseBody)！
		; 需要先将 oHTTP.ResponseBody 赋值给变量，如 body，然后再 ComObjValue(body)。
		; 直接 ComObjValue(oHTTP.ResponseBody) 会导致在 XP 系统无法获取 gzip 文件的未压缩大小。

		If InStr(Options, "SaveAs:") {
			RegExMatch(Options, "i)SaveAs:[ \t]*\K[^\r\n]+", SavePath)
			FileOpen(SavePath, "w").RawWrite(&data, size)
		} Else {
			RegExMatch(Options, "i)Charset:[ \t]*\K[\w-]+", Encoding)
			In_POST__Out_Data := StrGet(&data, size, Encoding)

			if !Encoding && InStr(Options, "DetectCharset") {
				if RegExMatch(In_POST__Out_Data, "i)<meta [^>]*?http-equiv=['""]Content-Type['""] [^>]*?charset=UTF-8")
					In_POST__Out_Data := StrGet(&data, size, "UTF-8")
			}
		}
	}
	Else If InStr(Options, "SaveAs:")
	{
		RegExMatch(Options, "i)SaveAs:[ \t]*\K[^\r\n]+", SavePath)

		oADO.Type := 1 ; adTypeBinary = 1
		oADO.Open()
		oADO.Write( oHTTP.ResponseBody )
		oADO.SaveToFile( SavePath, 2 )
		oADO.Close()

		In_POST__Out_Data := ""
	}
	Else If InStr(Options, "Charset:")
	{
		RegExMatch(Options, "i)Charset:[ \t]*\K[\w-]+", Encoding)

		oADO.Type     := 1 ; adTypeBinary = 1
		oADO.Mode     := 3 ; adModeReadWrite = 3
		oADO.Open()
		oADO.Write( oHTTP.ResponseBody )
		oADO.Position := 0
		oADO.Type     := 2 ; adTypeText = 2
		oADO.Charset  := Encoding
		In_POST__Out_Data := IsByRef(In_POST__Out_Data) ? oADO.ReadText() : ""
		oADO.Close()
	}
	Else
		In_POST__Out_Data := IsByRef(In_POST__Out_Data) ? oHTTP.ResponseText : ""
	
	In_Out_HEADERS := "HTTP/1.1 " oHTTP.Status " " oHTTP.StatusText "`n" oHTTP.GetAllResponseHeaders()

	Return retCode ; 成功返回 -1, 超时返回 0, 无响应则返回为空
}

WinHttpRequest_Init(ByRef UserAgent) {
	if !whr := ComObjCreate("WinHttp.WinHttpRequest.5.1") {
		MsgBox, 48, 错误, 创建 WinHttp.WinHttpRequest.5.1 对象失败！程序将退出。`n`n请下载 winhttp.dll 保存到 Windows 目录，并进行注册。
		ExitApp
	} else {
		return whr, whr.Option(0) := UserAgent
	}
}

GZIP_DecompressBuffer( ByRef var, nSz ) { ; 'Microsoft GZIP Compression DLL' SKAN 20-Sep-2010
; Decompress routine for 'no-name single file GZIP', available in process memory.
; Forum post :  www.autohotkey.com/forum/viewtopic.php?p=384875#384875
; Modified by Lexikos 25-Apr-2015 to accept the data size as a parameter.

; Modified version by tmplinshi
static hModule
static GZIP_InitDecompression, GZIP_CreateDecompression, GZIP_Decompress
     , GZIP_DestroyDecompression, GZIP_DeInitDecompression
If !hModule
{
	for i, dir in [".", A_LineFile "\..", A_AhkPath "\..\Lib"]
	{
		if FileExist(dllFile := dir "\gzip.dll")
		{
			hModule := DllCall("LoadLibrary", "Str", dllFile, "Ptr")
			Break
		}
	}
	if !dllFile {
		Gui, +OwnDialogs
		MsgBox, 48, 提示, 缺少文件 gzip.dll！程序将退出。
		ExitApp
	}
		
	For k, v in ["InitDecompression","CreateDecompression","Decompress","DestroyDecompression","DeInitDecompression"]
		GZIP_%v% := DllCall("GetProcAddress", Ptr, hModule, "AStr", v, "Ptr")
		
	if !GZIP_Decompress {
		Gui, +OwnDialogs
		MsgBox, 48, 错误, gzip.dll 版本不匹配。`n`n详细信息: 无法从 gzip.dll 找到 Decompress 函数。`n`n程序将退出。
		ExitApp
	}
}

 vSz :=  NumGet( var,nsz-4 ), VarSetCapacity( out,vsz,0 )
 DllCall( GZIP_InitDecompression )
 DllCall( GZIP_CreateDecompression, UIntP,CTX, UInt,1 )
 If ( DllCall( GZIP_Decompress, UInt,CTX, UInt,&var, UInt,nsz, UInt,&Out, UInt,vsz
    , UIntP,input_used, UIntP,output_used ) = 0 && ( Ok := ( output_used = vsz ) ) )
      VarSetCapacity( var,64 ), VarSetCapacity( var,0 ), VarSetCapacity( var,vsz,32 )
    , DllCall( "RtlMoveMemory", UInt,&var, UInt,&out, UInt,vsz )
 DllCall( GZIP_DestroyDecompression, UInt,CTX ),  DllCall( GZIP_DeInitDecompression )
Return Ok ? vsz : 0
}