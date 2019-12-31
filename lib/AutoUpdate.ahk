AutoUpdate(FILE, mode:=0, updateIntervalDays:=7, CHANGELOG:="", iniFile:="", backupNumber:=1) {
	iniFile := iniFile ? iniFile : GetNameNoExt(A_ScriptName) . ".ini"
	VERSION_FromScript_REGEX := "Oi)(?:^|\R);\s*ver\w*\s*=?\s*(\d+(?:\.\d+)?)(?:$|\R)"
	if NeedToCheckUpdate(mode, updateIntervalDays, iniFile) {
		if (CHANGELOG!="") {
			if Not (currVer := GetCurrentVer(iniFile))
				currVer := GetCurrentVerFromScript(VERSION_FromScript_REGEX)
			changelogContent := DownloadChangelog(CHANGELOG)
			If changelogContent {
				if (lastVer := GetLastVer(CHANGELOG, changelogContent)) {
					LastVerNews := GetLastVerNews(CHANGELOG, changelogContent)
					WriteLastCheckTime(iniFile)
					if Not (lastVer > currVer)
						Return
				}
			} else {
				if ((ErrorLevel != "") && (Manually := mode & 1)) {
					MsgBox 48,, %ErrorLevel%, 5
					Return
				}
			}
		}
		
		Update(FILE, mode, backupNumber, iniFile, currVer, lastVer, LastVerNews)
	}
}
NeedToCheckUpdate(mode, updateIntervalDays, iniFile) {
	if ((NotAuto := mode & 2) And Not (Manually := mode & 1)) {
		NeedToCheckUpdate := False
	} else if (A_Now > GetTimeToUpdate(updateIntervalDays, iniFile)) || (manually := mode & 1) {
		NeedToCheckUpdate := True
	}
	OutputDebug % "NeedToCheckUpdate: " (NeedToCheckUpdate ? "Yes" : "No")
	Return NeedToCheckUpdate
}
Update(FILE, mode, backupNumber, iniFile, currVer, lastVer, LastVerNews:="") {
	silentUpdate := ! ((mode & 4) || (mode & 1))
	if silentUpdate {
		OutputDebug % DownloadAndReplace(FILE, backupNumber, iniFile, lastVer, currVer)
		if (mode & 8)
			Reload
	} else {
		MsgBox, 36, %A_ScriptName% %currVer%, New version %lastVer% available.`n%LastVerNews%`nDownload it now? ; [Yes] [No]  [x][Don't check update]
		IfMsgBox Yes
		{
			if (Err := DownloadAndReplace(FILE, backupNumber, iniFile, lastVer, currVer)) {
				if ((Err != "") && (Err != "No access to the Internet"))
					MsgBox 48,, %Err%, 5
			} else {
				if (mode & 8)
					Reload
				else if ((mode & 16) || (mode & 1)) {
					MsgBox, 36, %A_ScriptName%, Script updated.`nRestart it now?
					IfMsgBox Yes
					{
						Reload ; no CL parameters!
					}
				}
			}
		}
	}
}
DownloadAndReplace(FILE, backupNumber, iniFile, lastVer, currVer) {
	; Download File from Net and replace origin
	; Return "" if update success Or return Error, if not
	; Write CurrentVersion to ini
	currFile := FileOpen(A_ScriptFullPath, "r").Read()
	if A_LastError
		Return "FileOpen Error: " A_LastError
	lastFile := UrlDownloadToVar(FILE)
	if ErrorLevel
		Return ErrorLevel
	OutputDebug DownloadAndReplace: File download
	if (RegExReplace(currFile, "\R", "`n") = RegExReplace(lastFile, "\R", "`n")) {
		WriteCurrentVersion(lastVer, iniFile)
		Return "Last version the same file"
	} else {
		backupName := A_ScriptFullPath ".v" currVer ".backup"
		FileCopy %A_ScriptFullPath%, %backupName%, 1
		if ErrorLevel
			Return "Error access to " A_ScriptFullPath " : " ErrorLevel

		file := FileOpen(A_ScriptFullPath, "w")
		if !IsObject(file) {
			MsgBox Can't open "%A_ScriptFullPath%" for writing.
			return
		}
		file.Write(lastFile)
		file.Close()

		; FileAppend %lastFile%, %A_ScriptFullPath%
		if ErrorLevel
			Return "Error create new " A_ScriptFullPath " : " ErrorLevel
	}
	WriteCurrentVersion(lastVer, iniFile)
	OutputDebug DownloadAndReplace: File update
}
GetTimeToUpdate(updateIntervalDays, iniFile) {
	timeToUpdate := GetLastCheckTime(iniFile)
	timeToUpdate += %updateIntervalDays%, days
	OutputDebug GetTimeToUpdate %timeToUpdate%
	Return timeToUpdate
}
GetLastCheckTime(iniFile) {
	IniRead lastCheckTime, %iniFile%, update, last check, 0
	OutputDebug LastCheckTime %lastCheckTime%
	Return lastCheckTime
}
WriteLastCheckTime(iniFile) {
	IniWrite, %A_Now%, %iniFile%, update, last check
	OutputDebug WriteLastCheckTime
	If ErrorLevel
		Return 1
}
WriteCurrentVersion(lastVer, iniFile) {
	OutputDebug WriteCurrentVersion %lastVer% to %iniFile%
	IniWrite %lastVer%, %iniFile%, update, current version
	If ErrorLevel
		Return 1
}
GetCurrentVer(iniFile) {
	IniRead currVer, %iniFile%, update, current version, 0
	OutputDebug, GetCurrentVer() = %currVer% from %iniFile%
	Return currVer
}
GetCurrentVerFromScript(Regex) {
	FileRead, ScriptText, % A_ScriptFullPath
	RegExMatch(ScriptText, Regex, currVerObj)
	currVer := currVerObj.1
	OutputDebug, GetCurrentVerFromScript() = %currVer% from %A_ScriptFullPath%
	Return currVer
}
GetLastVer(CHANGELOG, changelogContent) {
	If IsObject(CHANGELOG) {
		Regex := CHANGELOG[2]
		RegExMatch(changelogContent, Regex, changelogContentObj)
		lastVer := changelogContentObj.0
	} else
		lastVer := changelogContent

	OutputDebug, GetLastVer() = %lastVer%`, Regex = %Regex% 
	Return lastVer
}
GetLastVerNews(CHANGELOG, changelogContent) {
	If IsObject(CHANGELOG) {
		if (WhatNew_REGEX := CHANGELOG[3]) {
			RegExMatch(changelogContent, WhatNew_REGEX, WhatNewO)
			WhatNew := WhatNewO.1
		}
	}
	Return WhatNew
}
DownloadChangelog(CHANGELOG) {
	If IsObject(CHANGELOG)
		URL := CHANGELOG[1]
	else
		URL := CHANGELOG

	If changelogContent := UrlDownloadToVar(URL)
		Return changelogContent
}
UrlDownloadToVar(URL) {
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	try WebRequest.Open("GET", URL, true)
	catch	Error {
		ErrorLevel := "Wrong URL"
		return false
		}
	WebRequest.Send()
	try WebRequest.WaitForResponse()
	catch	Error {
		ErrorLevel := "No access to the Internet"
		return false
		}
	HTTPStatusCode := WebRequest.status
	if (SubStr(HTTPStatusCode, 1, 1) ~= "4|5") { ; 4xx — Client Error, 5xx — Server Error. wikipedia.org/wiki/List_of_HTTP_status_codes
		ErrorLevel := "HTTPStatusCode: " HTTPStatusCode
		return false
		}
	OutputDebug UrlDownloadToVar() HTTPStatusCode = %HTTPStatusCode% 
	ans:=WebRequest.ResponseText
	return ans
}
GetNameNoExt(FileName) {
	SplitPath FileName,,, Extension, NameNoExt
	Return NameNoExt
}
;~;[改进版URLDownloadToFile，来源于：http://ahkcn.net/thread-5658.html]
URLDownloadToFile(URL, FilePath, Options:="", RequestHeaders:="")
{
	Options:=this.解析信息到对象(Options)
	RequestHeaders:=this.解析信息到对象(RequestHeaders)

	ComObjError(0) 														 		;禁用 COM 错误通告。禁用后，检查 A_LastError 的值，脚本可以实现自己的错误处理
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")

	if (Options["EnableRedirects"]<>"")							;设置是否获取跳转后的页面信息
		WebRequest.Option(6):=Options["EnableRedirects"]
	;proxy_setting没值时，根据Proxy值的情况智能设定是否要进行代理访问。
	;这样的好处是多数情况下需要代理时依然只用给出代理服务器地址即可。而在已经给出代理服务器地址后，又可以很方便的对是否启用代理进行开关。
	if (Options["proxy_setting"]="" and Options["Proxy"]<>"")
		Options["proxy_setting"]:=2										;0表示 Proxycfg.exe 运行了且遵循 Proxycfg.exe 的设置（没运行则效果同设置为1）。1表示忽略代理直连。2表示使用代理
	if (Options["proxy_setting"]="" and Options["Proxy"]="")
		Options["proxy_setting"]:=1
	;设置代理服务器。微软的代码 SetProxy() 是放在 Open() 之前的，所以我也放前面设置，以免无效
	WebRequest.SetProxy(Options["proxy_setting"],Options["Proxy"],Options["ProxyBypassList"])
	if (Options["Timeout"]="")											;Options["Timeout"]如果被设置为-1，并不代表无限超时，而是依然遵循SetTimeouts第4个参数设置的最大超时时间
		WebRequest.SetTimeouts(0,60000,30000,0)			;0或-1都表示超时无限等待，正整数则表示最大超时（单位毫秒）
	else if (Options["Timeout"]>30)									;如果超时设置大于30秒，则需要将默认的最大超时时间修改为大于30秒
		WebRequest.SetTimeouts(0,60000,30000,Options["Timeout"]*1000)
	else
		WebRequest.SetTimeouts(0,60000,30000,30000)	;此为SetTimeouts的默认设置。这句可以不加，因为默认就是这样，加在这里是为了表述清晰。

	WebRequest.Open("GET", URL, true)   						;true为异步获取。默认是false，龟速的根源！！！卡顿的根源！！！

	;SetRequestHeader() 必须 Open() 之后才有效
	for k, v in RequestHeaders
	{
		if (k="Cookie")
		{
			WebRequest.SetRequestHeader("Cookie","tuzi")    ;先设置一个cookie，防止出错，msdn推荐这么做
			WebRequest.SetRequestHeader("Cookie",v)
		}
		WebRequest.SetRequestHeader(k,v)
	}

	Loop
	{
		WebRequest.Send()
		WebRequest.WaitForResponse(-1)								;WaitForResponse方法确保获取的是完整的响应。-1表示总是使用SetTimeouts设置的超时

		;获取状态码，一般status为200说明请求成功
		this.Status:=WebRequest.Status()
		this.StatusText:=WebRequest.StatusText()

		if (Options["expected_status"]="" or Options["expected_status"]=this.Status)
			break
		;尝试指定次数后页面返回的状态码依旧与预期状态码不一致，则抛出错误及详细错误信息（可使用我另一个错误处理函数专门记录处理它们）
		;即使number_of_retries为空，表达式依然成立，所以不用为number_of_retries设置初始值。
		else if (A_Index>=Options["number_of_retries"])
		{
			this.extra.URL:=URL
			this.extra.Expected_Status:=Options["expected_status"]
			this.extra.Status:=this.Status
			this.extra.StatusText:=this.StatusText
			throw, Exception("经过" Options.number_of_retries "次尝试后，服务器返回状态码依旧与期望值不一致", -1, Object(this.extra))
		}
	}

	ADO:=ComObjCreate("adodb.stream")   		;使用 adodb.stream 编码返回值。参考 http://bbs.howtoadmin.com/ThRead-814-1-1.html
	ADO.Type:=1														;以二进制方式操作
	ADO.Mode:=3 													;可同时进行读写
	ADO.Open()  														;开启物件
	ADO.Write(WebRequest.ResponseBody())    	;写入物件。注意没法将 WebRequest.ResponseBody() 存入一个变量，所以必须用这种方式写文件
	ADO.SaveToFile(FilePath,2)   						 	;文件存在则覆盖
	ADO.Close()
	this.ResponseHeaders:=this.解析信息到对象(WebRequest.GetAllResponseHeaders())
	return, 1
}
Check_Github(){
	return DllCall("Wininet.dll\InternetCheckConnection", "Ptr", &lpszUrl, "UInt", 0x1, "UInt", 0x0, "Int")
}
/*
AutoUpdate(FILE, mode:=0, updateIntervalDays:="", CHANGELOG:="", iniFile:="", backupNumber:=1) {
CHANGELOG := [CHANGELOG_URL, VERSION_REGEX, WhatNew_REGEX]
FILE := [FILE_URL, FILE_REGEX, VERSION_FromScript_REGEX]

ini file strucnure:
[update]
	last check
	current version
	?auto check
	?auto download
	?auto restart

mode:
	manually(ignore timeToUpdate)							1 ? set updateIntervalDays:=0
	if auto, don't check updated							2 ? if (autocheck) {AU()}
	if exist update, ask before download it 	4
	auto restart after download 							8
	if not autorestart, ask if restart need 	16

	Scenaries:
	1) Silent check new version available, if exist such, AutoUpdate
	2) Silent check new version available, if exist such, ask whether you want to update
	3) Manual check new version available, if exist such, ask whether you want to update
	• (ToolTip/MsgBox) asking whether you want to reload straight away

updateIntervalDays: check for update every %updateIntervalDays% days

CHANGELOG:
	1)"url"
	2)"url regex"

3 места хранения: .ahk, .ini, regestry
	1)ini
		"ini:"        IniRead currVer, %A_ScriptNameNoExt%.ini, update, current version, 0
		"ini:xxx"     IniRead currVer, %xxx%, update, current version, 0
	2)inside
		"inside:"				currVer := regex("Oi)^;\s*(?:version|ver)?\s*=?\s*(\d+(?:\.\d+)?)", A_Script)
		"inside:xxx"    currVer := regex(xxx, A_Script)
	3)regestry
		"regestry:"				RegRead, currVer, HKEY_CURRENT_USER, SOFTWARE\%A_ScriptNameNoExt%\CurrentVersion, Version
		"regestry:xxx"		RegRead, currVer, HKEY_CURRENT_USER, SOFTWARE\%xxx%, Version

2 опциональных значения для хранения: currVers (если не указана, скрипт при проверке скачивается полностью и сравнивается с текущим), lastCheckDate (если не указана, проверка происходит при каждом вызове ф-ии AutoUpdate())

backupNumber:

