#NoEnv                  ;~不检查空变量为环境变量
#Persistent             ;~让脚本持久运行
#WinActivateForce       ;~强制激活窗口
#SingleInstance,Force   ;~运行替换旧实例
ListLines,Off           ;~不显示最近执行的脚本行
AutoTrim,On             ;~自动去除变量中前导和尾随空格制表符
SendMode,Input          ;~使用更速度和可靠方式发送键鼠点击
CoordMode,Menu          ;~相对于整个屏幕
SetBatchLines,-1        ;~脚本全速执行
SetWorkingDir,%A_ScriptDir% ;~脚本当前工作目录
F10::
selectZz:=Get_Zz()
;selectCheck:=Trim(selectZz," `t`n`r")
openFlag:=false
calcFlag:=false
calcResult:=""
selectResult:=""
Loop, parse, selectZz, `n, `r
{
	S_LoopField=%A_LoopField%
	if(S_LoopField=""){
	if(calcResult)
	calcResult.=A_LoopField "`n"
	if(selectResult)
	selectResult.=A_LoopField "`n"
continue
}
;一键计算数字加减乘除
if(RegExMatch(S_LoopField,"^[\(\)\.\d]+[+*/-]+[\(\)\.+*/-\d]+($|=$)")){
	formula:=S_LoopField
if(RegExMatch(S_LoopField,"^[\(\)\.\d]+[+*/-]+[\(\)\.+*/-\d]+=$")){
	StringTrimRight, formula, formula, 1
}
calc:=js_eval(formula)
selectResult.=A_LoopField
if(RegExMatch(S_LoopField,"^[\(\)\.\d]+[+*/-]+[\(\)\.+*/-\d]+=$")){
	calcFlag:=true
	selectResult.=calc
}else{
	calcResult.=calc "`n"
}
	selectResult.="`n"
	openFlag:=true
	continue
}
}
	if(calcResult){
		StringTrimRight, calcResult, calcResult, 1
		ToolTip,%calcResult%
		Clipboard:=calcResult
				;SetTimer,RemoveToolTip,% (calcResult="?") ? 1000 : 3000
		}
	if(calcFlag && selectResult){
		StringTrimRight, selectResult, selectResult, 1
		Send_Str_Zz(selectResult)
		}
		;if(openFlag)

return
;~;[输出短语]
Send_Str_Zz(strZz,tf=false){
	if(tf){
		strZz:=Get_Transform_Val(strZz)
	}
	Candy_Saved:=ClipboardAll
	Clipboard:=strZz
	SendInput,^v
	MsgBox %Clipboard%
	Sleep,200
	Clipboard:=Candy_Saved
}
;~;获取变量展开转换后的值
Get_Transform_Val(var){
	try{
		Transform,varTemp,Deref,%var%
		return varTemp
	}catch{
		return var
	}
}
;~;[获取选中]
Get_Zz(){
	global Candy_isFile
	global Candy_Select
	Candy_Saved:=ClipboardAll
	Clipboard=
	SendInput,^c
	if (ClipWaitTime != 0.1) && WinActive("ahk_group ClipWaitGUI"){
		ClipWait,%ClipWaitTime%
	}else{
		ClipWait,0.1
	}
	If(ErrorLevel){
		Clipboard:=Candy_Saved
		return
	}
	Candy_isFile:=DllCall("IsClipboardFormatAvailable","UInt",15)
	CandySel=%Clipboard%
	Candy_Select=%ClipboardAll%
	Clipboard:=Candy_Saved
	return CandySel
}

;~;[利用HTML中JS的eval函数来计算]
js_eval(exp)
{
	HtmlObj:=ComObjCreate("HTMLfile")
	exp:=escapeString(exp)
	HtmlObj.write("<body><script>var t=document.body;t.innerText='';t.innerText=eval('" . exp . "');</script></body>")
	return InStr(cabbage:=HtmlObj.body.innerText, "body") ? "?" : cabbage
}
escapeString(string){
	string:=RegExReplace(string, "('|""|&|\\|\\n|\\r|\\t|\\b|\\f)", "\$1")
	string:=RegExReplace(string, "\R", "\n")
	return string
}
