Foxit_Phantom: ;{
	vim.setwin("Foxit_Phantom","classFoxitPhantom","")
	vim.SetTimeOut(300,"Foxit_Phantom")
	
	vim.mode("普通模式","Foxit_Phantom")
	vim.map("<insert>","<Phantom_切换到【VIM模式】>","Foxit_Phantom")
	vim.comment("<Phantom_切换到【VIM模式】>","按下Esc键可以切换为VIM模式")
	
	vim.mode("VIM模式","Foxit_Phantom")
	vim.map("<esc>","<Phantom_切换到【普通模式】>","Foxit_Phantom")
	vim.map("f","<Phantom_视图-适合页面>","Foxit_Phantom")
	vim.comment("<Phantom_视图-适合页面>","视图-适合页面")
	vim.map("w","<Foxit_Phantom_PageUp>","Foxit_Phantom")
	vim.map("s","<Foxit_Phantom_PageDown>","Foxit_Phantom")
	vim.map("dc","<Phantom_页面管理-删除当前页>","Foxit_Phantom")
	vim.map("df","<Phantom_页面管理-删除从到>","Foxit_Phantom")
	vim.map("rr","<Phantom_视图-顺时针-全部>","Foxit_Phantom")
	vim.map("rf","<Phantom_视图-逆时针-全部>","Foxit_Phantom")
	vim.map("v","<Phantom_编辑-书签>","Foxit_Phantom")
	vim.map("pa","<Phantom_文件-打印全部>","Foxit_Phantom")
	vim.map("ee","<Phantom_页面管理-旋转-当前页-顺90>","Foxit_Phantom")
	vim.map("qq","<Phantom_页面管理-旋转-当前页-逆90>","Foxit_Phantom")
	vim.map("xx","<Phantom_页面管理-旋转-当前页-180>","Foxit_Phantom")
	vim.map("ef","<Phantom_页面管理-旋转-从到-顺90>","Foxit_Phantom")
	vim.map("qf","<Phantom_页面管理-旋转-从到-逆90>","Foxit_Phantom")
	vim.map("xf","<Phantom_页面管理-旋转-从到-180>","Foxit_Phantom")
	vim.map("z","<Phantom_视图-放大>","Foxit_Phantom")
	vim.map("Z","<Phantom_视图-缩小>","Foxit_Phantom")
	vim.map(":Q","<Phantom_文件-保存关闭>","Foxit_Phantom")
	vim.map(":q","<Phantom_文件-不保存关闭>","Foxit_Phantom")
	vim.map("b","<Phantom_编辑-批量添加书签>","Foxit_Phantom")
	vim.map("n","<Phantom_编辑-菜单选择标签内容>","Foxit_Phantom")
	vim.map("cc","<Phantom_页面管理-提取页面-当前>","Foxit_Phantom")
	vim.map("cf","<Phantom_页面管理-提取页面-从到>","Foxit_Phantom")
	vim.map("m","<Phantom_编辑-输入标签内容>","Foxit_Phantom")
	vim.map("ea","<Phantom_页面管理-旋转-全部-顺90>","Foxit_Phantom")
	vim.map("W","<Foxit_Phantom_Home>","Foxit_Phantom")
	vim.map("S","<Foxit_Phantom_End>","Foxit_Phantom")
	vim.map("qa","<Phantom_页面管理-旋转-全部-逆90>","Foxit_Phantom")
	vim.map("xa","<Phantom_页面管理-旋转-全部-180>","Foxit_Phantom")
	vim.map(":S","<Foxit_Phantom_另存为（Ctrl+Shift+S）>","Foxit_Phantom")
	vim.map("'","<Phantom_文件-从多文档创建PDF>","Foxit_Phantom")
	vim.map("i","<Phantom_页面管理-插入页面-从文件>","Foxit_Phantom")
	vim.map("pc","<Phantom_文件-打印当前页面>","Foxit_Phantom")
	vim.map("pf","<Phantom_文件-打印从到>","Foxit_Phantom")
	vim.map("p","<Phantom_文件-打印对话框>","Foxit_Phantom")
	vim.map("Q","<Phantom_关闭当前标签>","Foxit_Phantom")
	vim.map("A","<Phantom_切换到左边标签>","Foxit_Phantom")
	vim.map("D","<Phantom_切换到右边标签>","Foxit_Phantom")
	vim.map("a","<Foxit_Phantom_向左>","Foxit_Phantom")
	vim.map(":s","<Foxit_Phantom_保存（Ctrl+S）>","Foxit_Phantom")
	vim.map("<a-q>","<Foxit_Phantom_关闭（Alt+F4）>","Foxit_Phantom")
	vim.map("<capslock>","<VIMD_清除输入键>","Foxit_Phantom")
return
;}



<Phantom_切换到【VIM模式】>:  ;{
send,{esc}
SetModUIInsert()
vim.mode("VIM模式","Foxit_Phantom")
; MsgBox, 0, 提示, 【VIM模式】, 0.3
return
;}

<Phantom_切换到【普通模式】>:  ;{
send,{esc}
SetModUINormal()
vim.mode("普通模式","Foxit_Phantom")
; MsgBox, 0, 提示, 【普通模式】, 0.3
return
;}

<Phantom_视图-适合页面>:  ;{
;send,!v
;send,p
;send,s
WinMenuSelectItem, A, , 视图, 页面布局,单面
;send,^2
WinMenuSelectItem, A, , 视图, 缩放,适合页面
return
;}

<Foxit_Phantom_PageUp>:  ;{
Send {PgUp}
return
;}

<Foxit_Phantom_PageDown>:  ;{
Send {PgDn}
return
;}

<Phantom_页面管理-删除当前页>:  ;{
;send !o
;send d
WinMenuSelectItem, A, , 页面管理, 删除页面
send o
send {enter}
return
;}

<Phantom_页面管理-删除从到>:  ;{
;send !o
;send d
WinMenuSelectItem, A, , 页面管理, 删除页面

return
;}

<Phantom_视图-顺时针-全部>:  ;{
send ^+=
return
;}

<Phantom_视图-逆时针-全部>:  ;{
send ^+-
return
;}

<Phantom_编辑-书签>:  ;{
MyDefault=%Clipboard%
;~ InputBox, OutputVar,提示,请输入书签名称, ,,,,,,,%MyDefault%
InputBox, OutputVar,提示,请输入书签名称
;~ if (OutputVar="")
	;~ return
;sendinput,!e
;sendinput,d
WinMenuSelectItem, A, , 编辑, 添加书签
NewStr=%MyDefault%%OutputVar%
sleep,300
send,%NewStr%
sleep,100
sendinput,{enter}

return
;}

<Phantom_文件-打印全部>:  ;{
sendinput,^p
sleep,300
sendinput,{enter}
return
;}

<Phantom_页面管理-旋转-当前页-顺90>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{down}
sendinput,{enter}
controlclick,Button7,,旋转页面,,
return
;}

<Phantom_页面管理-旋转-当前页-逆90>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{enter}
controlclick,Button7,,旋转页面,,
return
;}

<Phantom_页面管理-旋转-当前页-180>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{down}
sendinput,{down}
sendinput,{enter}
controlclick,Button7,,旋转页面,,
return
;}

<Phantom_页面管理-旋转-从到-顺90>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{down}
;sendinput,{enter}

return
;}

<Phantom_页面管理-旋转-从到-逆90>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
;sendinput,{enter}
return
;}

<Phantom_页面管理-旋转-从到-180>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{down}
sendinput,{down}
;sendinput,{enter}
return
;}

<Phantom_视图-放大>:  ;{
;sendinput,^NumpadAdd
;sendinput,!v
;sendinput,z
;sendinput,m
WinMenuSelectItem, A, , 视图, 缩放,放大

return
;}

<Phantom_视图-缩小>:  ;{
;sendinput,^Numpadsub
;sendinput,!v
;sendinput,z
;sendinput,o
WinMenuSelectItem, A, , 视图, 缩放,缩小
return
;}

<Phantom_文件-保存关闭>:  ;{
sendinput,^s
sendinput,^w
return
;}

<Phantom_文件-不保存关闭>:  ;{
sendinput,^w
sendinput,n
return
;}

<Phantom_编辑-批量添加书签>:  ;{
global CurID
global PageStr
while (CurID>0)
{
	NewStr:=PageStr[CurID]
	if (NewStr="")
		break
	MsgBox, 3, 提示, 标签内容为：%NewStr%`n`n确认请按【Yes】，前一个标签【No】，退出【Cancel】
	IfMsgBox Yes
	{
		;sendinput,!e
		;sendinput,d
WinMenuSelectItem, A, , 编辑, 添加书签
		sleep,300
		sendinput,%NewStr%
		sleep,100
		sendinput,{enter}
		sleep,100
		CurID+=1
		mouseclick,,500,500
		sleep,300
		sendinput,{PgDn}
		continue
	}	
	IfMsgBox no
	{
		CurID-=1
		if (CurID=0)
			CurID=1
		continue
	}
	IfMsgBox Cancel
		break
}
return
;}

<Phantom_编辑-菜单选择标签内容>:  ;{
global CurID
global PageStr

MouseGetPos,CurX,CurY
menu,RMenu,Add
menu,RMenu,DeleteAll
loop,% PageStr.MaxIndex()
	menu,RMenu,add,% PageStr[A_index],MySub_AddPDFLebal
menu,RMenu,show,%CurX%,%CurY%
return

MySub_AddPDFLebal:
	;sendinput,!e
	;sendinput,d
WinMenuSelectItem, A, , 编辑, 添加书签
	sleep,300
	sendinput,%A_ThisMenuItem%
	sleep,100
	sendinput,{enter}
	sleep,100
	mouseclick,,500,500
	sleep,300
	sendinput,{PgDn}
return
return
;}

<Phantom_页面管理-提取页面-当前>:  ;{
;sendinput,!o
;sendinput,e
WinMenuSelectItem, A, , 页面管理, 提取页面
sleep,300
sendinput,s
sleep,100
sendinput,{space}
sendinput,{enter}
return
;}

<Phantom_页面管理-提取页面-从到>:  ;{
;sendinput,!o
;sendinput,e
WinMenuSelectItem, A, , 页面管理, 提取页面
sleep,300
sendinput,s
sleep,100
sendinput,{space}
return
;}

<Phantom_编辑-输入标签内容>:  ;{
global CurID
global PageStr:=[]

gui,font,s12
Gui Add, Edit, x9 y2 w465 h400 vMyVar_PDFLabels,
Gui Add, Button, x78 y405 w75 h32 default gMySub_PDFLabelOK, 确认
Gui Add, Button, x250 y405 w75 h32 gMySub_PDFLabelClear, 清空
gui,font
Gui Show, w481 h440, 输入标签内容
Return

MySub_PDFLabelOK()
{
	global CurID
	global PageStr:=[]
	GuiControlget,MyVar_PDFLabels,,MyVar_PDFLabels
	Loop, parse, MyVar_PDFLabels, `n, `r  ; 
	{
		if (A_LoopField!="")
			PageStr[A_Index]:=A_LoopField
	}
	CurID:=1
	gui,destroy
	msgbox,0,,% "已加载" PageStr.Length() "个书签",1
	return
}

MySub_PDFLabelClear()
{
	GuiControl,,MyVar_PDFLabels
	return
}
return
;}

<Phantom_页面管理-旋转-全部-顺90>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{down}
sendinput,{tab}
sendinput,{up}
sendinput,{up}
sendinput,{up}
sendinput,{enter}
return
;}

<Foxit_Phantom_Home>:  ;{
sendinput,{Home}
return
;}

<Foxit_Phantom_End>:  ;{
sendinput,{End}
return
;}

<Phantom_页面管理-旋转-全部-逆90>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{tab}
sendinput,{up}
sendinput,{up}
sendinput,{up}
sendinput,{enter}
return
;}

<Phantom_页面管理-旋转-全部-180>:  ;{
;sendinput,!o
;sendinput,t
WinMenuSelectItem, A, , 页面管理, 旋转页面
controlclick,combobox1,,旋转页面,,
sendinput,{down}
sendinput,{down}
sendinput,{tab}
sendinput,{up}
sendinput,{up}
sendinput,{up}
sendinput,{enter}
return
;}

<Foxit_Phantom_另存为（Ctrl+Shift+S）>:  ;{
sendinput,^+s
return
;}

<Phantom_文件-从多文档创建PDF>:  ;{
;^f12::
gui Destroy
gui New
Gui Font, s12
Gui Add, Text, x10 y15 w85 h26 +0x200, 文件目录：
Gui Add, Edit, x100 y15 w384 h26 vMyVar_FileDir
Gui Add, Button, x490 y15 w70 h26, PDF浏览
Gui Add, ComboBox, x100 y50 w160 vMyVar_FileExt,pdf|jpg|png|bmp 
Gui Add, Text, x10 y47 w85 h30 +0x200, 文件格式：
Gui Add, Edit, x10 y85 w550 h500 vMyVar_FileList
Gui Add, Button, x110 y600 w75 h39, PDF合并
Gui Add, Button, x250 y600 w75 h39, PDF清空
Gui Add, Button, x390 y600 w75 h39, PDF退出
Gui Font
Gui Show, w570 h650, 批量合并文件
Return

ButtonPDF浏览:
	;~ Gui PDFMarge:Default
	FileSelectFolder, MyVar_FileDir
	if ErrorLevel
		return
	if (MyVar_FileDir="")
		return
	MyVar_FileDir := RegExReplace(MyVar_FileDir, "\\$")  ; 移除默认的反斜线,如果存在.
	guicontrol,,MyVar_FileDir,%MyVar_FileDir%
return

ButtonPDF合并:
	;~ Gui PDFMarge:Default
	gui,Submit
	NotExistList:=
	ExistList:=
	if (MyVar_FileExt="")
		msgbox ,请选择文件后缀名！
	loop,Parse,MyVar_FileList,`n,`r
	{
		TemFileNameNoExt:=trim(A_LoopField)
		if (TemFileNameNoExt="")
			continue
		TemFileFullPath=%MyVar_FileDir%\%TemFileNameNoExt%.%MyVar_FileExt%
		ifnotexist,%TemFileFullPath%
			NotExistList.=TemFileNameNoExt "." MyVar_FileExt "`n" 
		else
			ExistList.=TemFileFullPath "`n" 
	}
	NotExistList:=RegExReplace(NotExistList,"\s*$","")   ;顺便删除最后的空白行，可根据需求注释掉
	ExistList:=RegExReplace(ExistList,"\s*$","")   ;顺便删除最后的空白行，可根据需求注释掉
	if strlen(NotExistList)
	{
		Clipboard=%NotExistList%
		MsgBox, 4, 提示, 以下文件不存在，是否继续？`n文件列表已复制到剪贴板，如有需要，请先粘贴保存`n`n%NotExistList%
	}
	IfMsgBox ,no
		goto ,ButtonPDF退出

	winget,AppPath,ProcessPath ,ahk_exe Foxit Phantom.exe
	
	if AppPath=
		return
	;~ AppPath:="C:\Program Files (x86)\foxit software\foxit phantom\Foxit Phantom.exe"
	;~ AppPath:=QZData( "%Foxit_Phantom%" )
	run,"%AppPath%"
	sleep,2000
	#WinActivateForce
	WinActivate,,ahk_class classFoxitPhantom
	;~ sleep,1500
	sendinput,!f
	sleep,100
	sendinput,f
	sleep,100
	sendinput,m
	;~ ControlClick,Button2,多文档转换
	sendinput,{tab}
	loop,Parse,ExistList,`n,`r
	{
		TemFileFullPath:=trim(A_LoopField)
		;~ msgbox % TemFileFullPath
		sendinput,{enter}
		sleep,300
		Clipboard=%TemFileFullPath%
		;~ sendinput,{Raw}%TemFileFullPath%
		sendinput,^v
		sleep,300
		sendinput,{enter}
	}
	sendinput,!m
	goto ,ButtonPDF退出
return

ButtonPDF清空:
	;~ Gui PDFMarge:Default
	guicontrol,,MyVar_FileDir,
	guicontrol,,MyVar_FileList,
	guicontrol,,MyVar_FileExt,||
	guicontrol,,MyVar_FileExt,pdf|jpg|png|bmp 
	MyVar_FileDir:=
	MyVar_FileList:=
	MyVar_FileExt:=
return

ButtonPDF退出:
	;~ Gui PDFMarge:Destroy
    gui,Destroy
return
;}


<Phantom_页面管理-插入页面-从文件>:  ;{
WinMenuSelectItem, A,, 页面管理,插入页面,从文件
sendinput,{tab}
sleep,50
sendinput,{enter}
return
;}

<Phantom_文件-打印当前页面>:  ;{
sendinput,^p
sleep,300
sendinput,!u
sleep,100
sendinput,{enter}

return
;}

<Phantom_文件-打印从到>:  ;{
InputBox, NewString, 输入, 请输入页码范围`n如：1-4或2`,4-8, , 300,150
if ErrorLevel
	return
if (NewString="")
	return
else
{
	sendinput,^p
	sleep,300
	sendinput,!e
	sleep,100
	ControlSetText, Edit3, %NewString%, , 打印
	sleep,300
	sendinput,{enter}
}
return
;}

<Phantom_文件-打印对话框>:  ;{
sendinput,^p
return
;}

<Phantom_关闭当前标签>:  ;{
sendinput,^w
return
;}

<Phantom_切换到左边标签>:  ;{
sendinput,^+{tab}
return
;}

<Phantom_切换到右边标签>:  ;{
sendinput,^{tab}
return
;}

<Foxit_Phantom_向左>:  ;{
sendinput,{left}
return
;}

<Foxit_Phantom_保存（Ctrl+S）>:  ;{
sendinput,^s
return
;}

<Foxit_Phantom_关闭（Alt+F4）>:  ;{
send,!{f4}
return
;}


