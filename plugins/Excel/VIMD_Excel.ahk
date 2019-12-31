    ;~ #Include  %A_ScriptDir%\acc.ahk
    #Include  %A_ScriptDir%\Lib\acc.ahk
    global excel
/*
    ;~ global Workbook
    ;~ global excel
    ;~ global ActiveSheet
    ;~ global ActiveCell
    ;~ global Selection
    ;~ global lLastRow ;整个表的最末尾行
    ;~ global lLastColumn ;整个表最末尾列
    ;~ global SelectionFirstRow ;当前选择内容首行
    ;~ global SelectionFirstColumn ;当前选择内容首列
    ;~ global SelectionLastColumn ;当前选择内容末列
    ;~ global SelectionLastRow ;当前选择内容末行
    ;~ global SelectionType ; 当前选择单元格类型 1=A1  2=A1:B1 4=A1:A2 16=A1:B2  18=A1:B1 A1:B2 20=A1:A2 A1:B2
    ;~ global FontColor := -4165632  ;填充字体颜色-默认蓝色
    ;~ global CellColor := -16711681 ;填充表格颜色-默认黄色
    ;~ global LastSelectSheetIndex:=  ;最后选中的工作表的序号
    ;~ ;XlDirection常量
    ;~ global xlDown := -4121    ;向下
    ;~ global xlToLeft := -4159  ;向左
    ;~ global xlToRight := -4161 ;向右
    ;~ global xlUp := -4162      ;向上
    ;~ ;XlAutoFillType常量
    ;~ global xlFillCopy:=1     ;将源区域的值和格式复制到目标区域
    ;~ global xlFillDefault:=0     ;确定用于填充目标区域的值和格式
    ;~ global xlFillFormats:=3     ;只复制格式
    ;~ global xlFillSeries:=2     ;扩展到目标区域，如1,2，扩展到3,4,5
    ;~ global xlFillValuse:=4     ;值
    ;~ global xlGrowthTrend:=10     ;乘法关系，如1,2，扩展到4,8,16
    ;~ global xlLinearTrend:=9     ;加法关系，如1,3，扩展到5,6,9
    ;~ ; XlLinestyle常量
    ;~ global xlDot:=-4118              ;
    ;~ global xlContinuous:=1              ;
    ;~ global xlDash:=-4115              ;
    ;~ global xlDouble:= -4119             ;
    ;~ ; XlBorderWeight常量
    ;~ global xlHairline:=1
    ;~ global xlMedium:=-4138
    ;~ global xlThick:=4
    ;~ global xlThin:=2
    ;~ ;XlBordersIndex    常量
    ;~ global xlDiagonalDown:=5
    ;~ global xlDiagonalUp:=6
    ;~ global xlEdgeBottom:=9
    ;~ global xlEdgeLeft:=7
    ;~ global xlEdgeRight:=10
    ;~ global xlEdgeTop:=8
    ;~ global xlInsideHorizontal:=12
    ;~ global xlInsideVertical:=11
    ;~ ;XlHAlign   常量
    ;~ global xlHAlignCenter	:=-4108
    ;~ global xlHAlignCenterAcrossSelection:=	7
    ;~ global xlHAlignDistributed	:=-4117
    ;~ global xlHAlignFill:=	5
    ;~ global xlHAlignGeneral:=	1
    ;~ global xlHAlignJustify:=	-4130
    ;~ global xlHAlignLeft:=	-4131
    ;~ global xlHAlignRight	:=-4152
    ;~ ;XlVAlign  常量
    ;~ Global xlVAlignBottom:=-4107
    ;~ Global xlVAlignCenter:=-4108
    ;~ Global xlVAlignDistributed:=-4117
    ;~ Global xlVAlignJustify:=-4130
    ;~ Global xlVAlignTop:=-4160
    ;~ ; XlUnderlineStyle  常量
    ;~ Global xlUnderlineStyleDouble:=-4119
    ;~ Global xlUnderlineStyleDoubleAccounting:=5
    ;~ Global xlUnderlineStyleNone:=-4142
    ;~ Global xlUnderlineStyleSingle:=2
    ;~ Global xlUnderlineStyleSingleAccounting:=4
    ;~ ; XlBuiltInDialog  常量
    ;~ Global xlDialogPageSetup:=7
    ;~ Global xlDialogSummaryInfo:=474
    ;~ Global xlDialogFilter:=447
    ;~ Global xlDialogSort:=39
    ;~ Global xlDialogDataDelete:=36
    ;~ ; XlAutoFilterOperator  常量
    ;~ Global xlAnd:=1
    ;~ Global xlBottom10Items:=4
    ;~ Global xlBottom10Percent:=6
    ;~ Global xlFilterCellColor:=8
    ;~ Global xlFilterDynamic:=11
    ;~ Global xlFilterFontColor:=9
    ;~ Global xlFiterIcon:=10
    ;~ Global xlFilterValues:=7
    ;~ Global xlOr:=2
    ;~ Global xlTop10Items:=3
    ;~ Global xlTop10Percent:=5
    ;~ ; XlWindowView  常量
    ;~ Global xlNormalView:=1
    ;~ Global xlPageBreakPreview:=2
    ;~ ; XlPasteSpecialOperation  常量
    ;~ Global 常量名:=对应数字
    ;~ Global xlPasteSpecialOperationAdd:=2
    ;~ Global xlPasteSpecialOperationDivide:=5
    ;~ Global xlPasteSpecialOperationMultiply:=4
    ;~ Global xlPasteSpecialOperationNone:=-4142
    ;~ Global xlPasteSpecialOperationSubtract:=3
    ;~ ; XlPasteType  常量
    ;~ Global 常量名:=对应数字
    ;~ Global xlPasteAll:=-4104
    ;~ Global xlPasteAllExceptBorders:=7
    ;~ Global xlPasteColumnWidths:=8
    ;~ Global xlPasteComments:=-4144
    ;~ Global xlPasteFormats:=-4122
    ;~ Global xlPasteFormulas:=-4123
    ;~ Global xlPasteFormulasAndNumberFormats:=11
    ;~ Global xlPasteValidation:=6
    ;~ Global xlPasteValues:=-4163
    ;~ Global xlPasteValuesAndNumberFormats:=12

    ;~ ;自定义颜色 常量
    ;~ global CBlack:=1    ;黑
    ;~ global CWhite:=2    ;白
    ;~ global CRed:=3      ;红
    ;~ global CGreen:=4    ;绿
    ;~ global CBlue:=5     ;蓝
    ;~ global CYellow:=6       ;黄
    ;~ global CMagenta:=7       ;粉红
    ;~ global CCyan:=8       ;青
    ;~ global CGray25:=15       ;灰色25
    ;~ global CGray40:=48       ;灰色40
    ;~ global CGray50:=16       ;灰色50
    ;~ global CPurple:=17       ;紫
    ;~ global CLightRed:=22      ;浅红
    ;~ global CSkyBlue:=33       ;天蓝
    ;~ global CCyanGreen:=34       ;浅青绿
    ;~ global CLightGreen:=35       ;浅绿
    ;~ global CLightYellow:=36       ;浅黄
    ;~ global CLightBlue:=37       ;浅蓝
    ;~ global CRoseRed:=38       ;玫瑰红
    ;~ global CLigthPurple:=39       ;浅紫
    ;~ global COrangeBrown:=40       ;茶色
    ;~ global CMiddleBlue:=41       ;浅蓝
    ;~ global CWaterGreen:=42       ;水绿色
    ;~ global CGrassGreen:=43       ;青草绿
    ;~ global CGold:=44       ;金
    ;~ global CLightOrange:=45       ;浅橙
    ;~ global COrange:=46       ;橙
    ;~ global CBlueGray:=47       ;蓝灰
    ;~ global CDarkCyan:=49       ;深青
    ;~ global CMiddleGreen:=50       ;中绿
    ;~ global CTan:=53       ;褐
    ;~ global CDarkBlue:=55       ;黑蓝
    ;~ global CAuto:=-4105       ;自动
    ;~ global CNone:=-4142       ;无色
*/
 
 {
;~ ^p::
	;~ xl := ComObjActive("Excel.Application")
    ;~ msgstr:=xl .selection.address
    ;~ msgbox % msgstr
;~ return
}
 
 ;======【通用】============================================================
/*
    函数:  Excel_Get
    作用: 返回word对象
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Get(WinTitle="ahk_class XLMAIN") {	; by Sean and Jethrow, minor modification by Learning one
	global excel
    ControlGet, hwnd, hwnd, , Excel71, %WinTitle%
	if !hwnd
		return
	Window := Acc_ObjectFromWindow(hwnd, -16)
	Loop
		try
			Application := Window.Application
		catch
			ControlSend, Excel71, {esc}, %WinTitle%
	Until !!Application
	excel:=Application
    return Application
}	; http://www.autohotkey.com/forum/viewtopic.php?p=492448#492448

/*
    函数:  Excel_Destroy
    作用: 摧毁Excel对象
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Destroy(){
	global excel
    excel.ScreenUpdating:=true
	excel:=
}

;======【文件】============================================================
/*
    函数:  Excel_OpenFile
    作用:  打开对话框
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_OpenFile(){
	sendinput,^o
}

/*
    函数:  Excel_SaveFile
    作用:  保存
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_SaveFile(){
	sendinput,^s
}

/*
    函数:  Excel_SaveFileAs
    作用:  另存为
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_SaveFileAs(){
	sendinput,^+s
}

/*
    函数:  Excel_CloseExcel
    作用:  关闭
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_CloseExcel(){
	global excel
	Excel_Get()
	try
		excel.Activeworkbook.Close
	Excel_Destroy()
}

/*
    函数:  Excel_SaveAndExit
    作用:  保存退出
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
	wdDialogFileSummaryInfo:=86
*/
Excel_SaveAndExit(){
	global excel
	Excel_Get()
	Excel_Dialogs(86)
	if !(excel.Activeworkbook.Saved)
		send,^s
	excel.Activeworkbook.Close
	Excel_Destroy()
}

;======【页面设置】============================================================
/*
    函数:  Excel_PageSetup_SetHeader
    作用:  设置页眉
    参数: fPos，位置，L=左侧，C=中间，R=右侧
            fText，设置内容
            空，以当前单元格内容设置
            &F，文件名称
            &D，当前日期
            &P/&N，设置[x/x]页码
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_PageSetup_SetHeader(fPos:="C",fText:=""){
    global excel
    Excel_Get()
    if (fText="")
        fText:=excel.ActiveCell.Value
    if (fPos="L"){
        try
            excel.ActiveSheet.PageSetup.LeftHeader :=fText
    }else if (fPos="C"){
        try
            excel.ActiveSheet.PageSetup.CenterHeader :=fText
    }else if (fPos="R"){
        try
            excel.ActiveSheet.PageSetup.RightHeader :=fText
    }
    Excel_Destroy()
}

/*
    函数:  Excel_PageSetup_SetFooter
    作用:  设置页脚
    参数: fPos，位置，L=左侧，C=中间，R=右侧
            fText，设置内容，为空，则以当前单元格内容设置
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_PageSetup_SetFooter(fPos:="C",fText:=""){
    global excel
    Excel_Get()
    if (fText="")
        fText:=excel.ActiveCell.Value
    if (fPos="L"){
        try
            excel.ActiveSheet.PageSetup.LeftFooter :=fText
    }else if (fPos="C"){
        try
            excel.ActiveSheet.PageSetup.CenterFooter :=fText
    }else if (fPos="R"){
        try
            excel.ActiveSheet.PageSetup.RightFooter :=fText
    }
    Excel_Destroy()
}

/*
    函数: Excel_PageSetup_SetOrientation
    作用: 设置页面方向
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
    xlLandscape:=2
    xlPortrait:=1
*/
Excel_PageSetup_SetOrientation(fOrientation:="纵向"){
	global excel
    Excel_Get()
    if(fOrientation="横向"){
        try
            excel.ActiveSheet.PageSetup.Orientation := 2
    }
    if(fOrientation="纵向"){
        try
            excel.ActiveSheet.PageSetup.Orientation := 1
    }
	Excel_Destroy()
}

/*
    函数:  Excel_setMargin
    作用: 获取数据
    参数: fMargins
    返回:
    作者:  Kawvin
    版本:  0.1
	使用方法：Excel_setMargin("1,1,1,1,0.5,0.5|2,2,2,2,1.5,1.5|3.17,3.17,2.54,2.54,1.5,1.75")
*/
Excel_setMargin(fMargins){
	global MyXlsLM,MyXlsRM,MyXlsTM,MyXlsBM,MyXlsHD,MyXlsFD
	MyXlsLM:=0,MyXlsRM:=0,MyXlsTM:=0,MyXlsBM:=0,MyXlsHD:=0,MyXlsFD:=0
	GUI XlsMargin:Destroy
	GUI XlsMargin: -DPIScale
	GUI XlsMargin:Default
	Gui XlsMargin:Font, s12
	Gui XlsMargin:Add, GroupBox, x12 y2 w542 h225, 页边距
	Gui XlsMargin:Add, ListView, x22 y27 w521 h189 AltSubmit Grid gMyXlsMarginsList, 上边距|下边距|左边距|右边距|页眉边距|页脚边距
	Gui XlsMargin:Add, Text, x15 y235 w70 h29 +0x200, 上边距
	Gui XlsMargin:Add, Text, x15 y275 w70 h29 +0x200, 下边距
	Gui XlsMargin:Add, Text, x210 y235 w70 h29 +0x200, 左边距
	Gui XlsMargin:Add, Text, x210 y275 w70 h29 +0x200, 右边距
	Gui XlsMargin:Add, Text, x390 y235 w85 h29 +0x200, 页眉边距
	Gui XlsMargin:Add, Text, x390 y275 w85 h29 +0x200, 页脚边距
	loop,Parse,fMargins,`|
	{
		if strlen(trim(A_LoopField))
			XlsMArray:=StrSplit(A_LoopField,",")
		else
			continue
		if (A_index=1)
			MyXlsTM:=XlsMArray[1],MyXlsBM:=XlsMArray[2],MyXlsLM:=XlsMArray[3],MyXlsRM:=XlsMArray[4],MyXlsHD:=XlsMArray[5],MyXlsFD:=XlsMArray[6]
		LV_Add("",XlsMArray[1],XlsMArray[2],XlsMArray[3],XlsMArray[4],XlsMArray[5],XlsMArray[6])
	}
	LV_ModifyCol(1," center")
	LV_ModifyCol(2," center")
	LV_ModifyCol(3," center")
	LV_ModifyCol(4," center")
	LV_ModifyCol(5," center")
	LV_ModifyCol(6," center")
	Gui XlsMargin:Add, Edit, x90 y233 w70 h31 center  vMyXlsTM,%MyXlsTM%
	Gui XlsMargin:Add, Edit, x90 y273 w70 h31 center  vMyXlsBM,%MyXlsBM%
	Gui XlsMargin:Add, Edit, x280 y233 w70 h31 center  vMyXlsLM,%MyXlsLM%
	Gui XlsMargin:Add, Edit, x280 y273 w70 h31 center  vMyXlsRM,%MyXlsRM%
	Gui XlsMargin:Add, Edit, x480 y233 w70 h31 center  vMyXlsHD,%MyXlsHD%
	Gui XlsMargin:Add, Edit, x480 y273 w70 h31 center  vMyXlsFD,%MyXlsFD%
	Gui XlsMargin:Add, Button, x120 y325 w100 h40 Default gMyXlsMarginsOK, 确定
	Gui XlsMargin:Add, Button, x350 y325 w100 h40 gMyXlsMarginsCancel, 取消
	Gui XlsMargin:Add, Text, x30 y375  h29 +0x200, 单击选中修改，双击直接设置
	Gui XlsMargin:Font
	Gui XlsMargin:Show, w570 h410, 页边距设置
	Return
	
	MyXlsMarginsOK:
		GUI XlsMargin:Default
		guicontrolget,MyXlsTM,,MyXlsTM
		guicontrolget,MyXlsBM,,MyXlsBM
		guicontrolget,MyXlsLM,,MyXlsLM
		guicontrolget,MyXlsRM,,MyXlsRM
		guicontrolget,MyXlsHD,,MyXlsHD
		guicontrolget,MyXlsFD,,MyXlsFD
		Excel_PageSetup_Margin(MyXlsTM,MyXlsBM,MyXlsLM,MyXlsRM,MyXlsHD,MyXlsFD)
		GUI XlsMargin:Destroy
	return
	
	MyXlsMarginsCancel:
		GUI XlsMargin:Destroy
	return
	
	MyXlsMarginsList:
		GUI XlsMargin:Default
		LV_GetText(MyXlsTM, A_EventInfo,1) 
		LV_GetText(MyXlsBM, A_EventInfo,2) 
		LV_GetText(MyXlsLM, A_EventInfo,3) 
		LV_GetText(MyXlsRM, A_EventInfo,4) 
		LV_GetText(MyXlsHD, A_EventInfo,5) 
		LV_GetText(MyXlsFD, A_EventInfo,6) 
		if A_GuiEvent = DoubleClick
		{
			Excel_PageSetup_Margin(MyXlsTM,MyXlsBM,MyXlsLM,MyXlsRM,MyXlsHD,MyXlsFD)
			GUI XlsMargin:Destroy
		}
		if A_GuiEvent = normal
		{
			guicontrol,,MyXlsTM,%MyXlsTM%
			guicontrol,,MyXlsBM,%MyXlsBM%
			guicontrol,,MyXlsLM,%MyXlsLM%
			guicontrol,,MyXlsRM,%MyXlsRM%
			guicontrol,,MyXlsHD,%MyXlsHD%
			guicontrol,,MyXlsFD,%MyXlsFD%
		}
	return
}

/*
    函数:  Excel_PageSetup_Margin
    作用: 设置页面边距，页眉、页脚边距
    参数: fTM,fBM,fLM,fRM，上，下，左，右边距，fHD，设置页眉边距，fFD，设置页脚边距
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Excel_PageSetup_Margin(fTM:="",fBM:="",fLM:="",fRM:="",fHD:="",fFD:=""){
	global excel
	Excel_Get()
	;~ msgbox % CentimetersToPoints(fTM)
	;~ return
	if(fTM!="")
		try
			excel.ActiveSheet.PageSetup.TopMargin:=fTM*28.3527	;CentimetersToPoints(fTM)
	if(fBM!="")
		try
			excel.ActiveSheet.PageSetup.BottomMargin:=fBM*28.3527	;CentimetersToPoints(fBM)
	if(fLM!="")
		try
			excel.ActiveSheet.PageSetup.LeftMargin:=fLM*28.3527	;CentimetersToPoints(fLM)
	if(fRM!="")
		try
			excel.ActiveSheet.PageSetup.RightMargin:=fRM*28.3527	;CentimetersToPoints(fRM)
	if(fHD!="")
		try
			excel.ActiveSheet.PageSetup.HeaderMargin:=fHD*28.3527	;CentimetersToPoints(fHD)
	if(fFD!="")
		try
			excel.ActiveSheet.PageSetup.FooterMargin:=fFD*28.3527	;CentimetersToPoints(fFD)
	Excel_Destroy()
}

/*
    函数:  Excel_PageSetup_FitTo1PageWide
    作用: 设置到1页宽
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Excel_PageSetup_FitTo1PageWide(){
    global excel
	Excel_Get()
    excel.PrintCommunication := False
    try{
        excel.ActiveSheet.PageSetup.PrintErrors := False
        excel.ActiveSheet.PageSetup.Zoom := False
        excel.ActiveSheet.PageSetup.FitToPagesWide := 1         ;数字或False
        ;excel.ActiveSheet.PageSetup.FitToPagesTall := False        ;数字或False
        ;excel.ActiveSheet.PageSetup.CenterHorizontally = False
        ;excel.ActiveSheet.PageSetup.CenterVertically = False
    }
    excel.PrintCommunication := true
    Excel_Destroy()
}

/*
    函数:  Excel_PageSetup_PrintTitle
    作用: 设置顶端标题行或左端标题列
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Excel_PageSetup_PrintTitle(){
    global excel
	Excel_Get()
    TitleStr:=excel.selection.address
    excel.PrintCommunication := False
    if regexmatch(TitleStr,"\$\d+\:\$\d+"){
        try{
            excel.ActiveSheet.PageSetup.PrintTitleRows := TitleStr
            excel.ActiveSheet.PageSetup.PrintTitleColumns := ""
        }
    }else if regexmatch(TitleStr,"\$[a-zA-Z]+\:\$[a-zA-Z]+"){
        try{
            excel.ActiveSheet.PageSetup.PrintTitleRows := ""
            excel.ActiveSheet.PageSetup.PrintTitleColumns := TitleStr
        }
    } else  {
        MsgBox, 64, 提示, 请选择【整行】或【整列】
    }
    excel.PrintCommunication := true
    Excel_Destroy()
}

;======【工作表】============================================================
/*
    函数:  Excel_Worksheet_Rename
    作用:  设置页脚
    参数: fText，设置内容，为空，则以当前单元格内容设置
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_Rename(fText:=""){
    global excel
    Excel_Get()
    if (fText="")
        fText:=excel.ActiveCell.Value
    try
        excel.ActiveSheet.Name := fText
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_Switch
    作用:  循环切换工作表
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_Switch(){
    global LastSelectSheetIndex
    global excel
    Excel_Get()
    OldIndex:=LastSelectSheetIndex
    try
        LastSelectSheetIndex:=excel.ActiveSheet.index
    catch e
        LastSelectSheetIndex:=1
    try
        excel.Worksheets(OldIndex).Select
    catch e
        excel.Worksheets(1).Select
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_DefSwitchFrom
    作用:  定义原始工作表
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_DefSwitchFrom(){
    global LastSelectSheetIndex
    global excel
    Excel_Get()
    try
        LastSelectSheetIndex:=excel.ActiveSheet.index
    catch e
        LastSelectSheetIndex:=1
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_MoveRight
    作用:  当前工作表移动到右侧
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_MoveRight(){
    global excel
    Excel_Get()
    excel.ActiveSheet.Select
    If (excel.ActiveSheet.index = excel.Worksheets.Count )
        try
            excel.ActiveSheet.Move(Before:=excel.sheets(1))
    Else 
        try
            excel.ActiveSheet.Move(,After:=excel.sheets(excel.ActiveSheet.index + 1))
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_MoveLeft
    作用:  当前工作表移动到左侧
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_MoveLeft(){
    global excel
    Excel_Get()
    excel.ActiveSheet.Select
    If (excel.ActiveSheet.index = 1)
        try
            excel.ActiveSheet.Move(,After:=excel.sheets(excel.Worksheets.Count))
    Else
        try
            excel.ActiveSheet.Move(Before:=excel.sheets(excel.ActiveSheet.index - 1))
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_Select
    作用:  选择工作表
    参数:  fIndex，F=第1个，E=最后一个，1,2.....为第几个
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_Select(fIndex){
    global excel
    Excel_Get()
    if (fIndex="F"){
        try
            excel.Worksheets(1).Select
    }else if (fIndex="E"){
        try
            excel.Worksheets(excel.Worksheets.Count).Select
    }else{
        try
            excel.Worksheets(fIndex).Select
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_SelectNext
    作用:  切换到下个工作表（可循环）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_SelectNext(){
    global excel
    Excel_Get()
    If (excel.ActiveSheet.index = excel.Worksheets.Count )
        try
            excel.Worksheets(1).Select
    Else
        try
            excel.ActiveSheet.Next.Select
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_SelectPrevious
    作用:  切换到前个工作表（可循环）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_SelectPrevious(){
    global excel
    Excel_Get()
    If (excel.ActiveSheet.index = 1)
        try
            excel.Worksheets(excel.Worksheets.Count).Select
    Else
        try
            excel.ActiveSheet.Previous.Select
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_DeleteCurrent
    作用:  删除工作表
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_DeleteCurrent(){
    global excel
    Excel_Get()
    try
        excel.ActiveWindow.SelectedSheets.delete
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_CopyAndPaste
    作用:  复制并粘贴工作表
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_CopyAndPaste(){
    global excel
    Excel_Get()
    try
        excel.ActiveSheet.Copy(,After:=excel.ActiveSheet)
    Excel_Destroy()
}

/*
    函数:  Excel_Worksheet_Insert
    作用:  插入工作表
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Worksheet_Insert(){
    global excel
    Excel_Get()
    try
        excel.ActiveWorkbook.Sheets.Add
    Excel_Destroy()
}

;======【行】============================================================
/*
    函数:  Excel_Row_SetHeight
    作用:  修改行高
    参数: -n，减少n，+n，增加n，n，设置为n
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_SetHeight(fHeight:="-1"){
    if (fHeight="")
		return
    global excel
    Excel_Get() 
    currentHeight := excel.Cells(excel.Selection.Row, excel.Selection.Row).RowHeight
    if (regexmatch(fHeight,"\+[0-9]+")) {		;增加行高
		HeightNum:=substr(fHeight,2)
		try
            excel.Selection.RowHeight := currentHeight+HeightNum
	}else if (regexmatch(fHeight,"\-[0-9]+")) {	;减小行高
		HeightNum:=substr(fHeight,2)
		try
			excel.Selection.RowHeight := currentHeight-HeightNum
	}else if (regexmatch(fHeight,"[0-9]+")) {		;设置行高		
		HeightNum:=substr(fHeight,1)
        try
            excel.Selection.RowHeight :=HeightNum
	}
	Excel_Destroy()
}

/*
    函数:  Excel_Row_AutoHeight
    作用:  修改行高
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_AutoHeight(){
    global excel
    Excel_Get()
    Rngs_left := excel.Selection.Column
    Rngs_top := excel.Selection.Row
    Rngs_right := Rngs_left + excel.Selection.Columns.Count - 1
    Rngs_bottom := Rngs_top + excel.Selection.Rows.Count - 1
    leftC := StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[2]
    rightC := StrSplit(excel.Cells(Rngs_top, Rngs_right).Address, "$")[2]
    topR:=StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[3]
    bottomR:=StrSplit(excel.Cells(Rngs_bottom, Rngs_left).Address, "$")[3]
    Selected_top_left := leftC . Rngs_top
    Selected_bottom_right := rightC .  Rngs_bottom
    Selected_range_string := Selected_top_left .  ":" . Selected_bottom_right
    Selected_range :=  excel.ActiveSheet.Range(Selected_range_string)
    try
        Selected_range.rows.autofit
    Excel_Destroy()
}

/*
    函数:  Excel_Row_DeleteFromCurrentToLast
    作用:  删除行，从当前行到最后一行
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_DeleteFromCurrentToLast(){
    global excel
    Excel_Get()  
    Rngs_left := excel.Selection.Column
    Rngs_top := excel.Selection.Row
    Rngs_right := Rngs_left + excel.Selection.Columns.Count - 1
    Rngs_bottom := Rngs_top + excel.Selection.Rows.Count - 1
    leftC := StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[2]
    rightC := StrSplit(excel.Cells(Rngs_top, Rngs_right).Address, "$")[2]
    topR:=StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[3]
    bottomR:=StrSplit(excel.Cells(Rngs_bottom, Rngs_left).Address, "$")[3]
    Selected_rows_string:=bottomR . ":65536"
    Selected_range :=  excel.ActiveSheet.Range(Selected_rows_string)
    try
        Selected_range.delete
    Excel_Destroy()
}

/*
    函数:  Excel_Row_DeleteFromCurrentToFirst
    作用:  删除行，从当前行到第一行
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_DeleteFromCurrentToFirst(){
    global excel
    Excel_Get()   
    Rngs_left := excel.Selection.Column
    Rngs_top := excel.Selection.Row
    Rngs_right := Rngs_left + excel.Selection.Columns.Count - 1
    Rngs_bottom := Rngs_top + excel.Selection.Rows.Count - 1
    leftC := StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[2]
    rightC := StrSplit(excel.Cells(Rngs_top, Rngs_right).Address, "$")[2]
    topR:=StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[3]
    bottomR:=StrSplit(excel.Cells(Rngs_bottom, Rngs_left).Address, "$")[3]
    Selected_rows_string:="1:" . topR
    Selected_range :=  excel.ActiveSheet.Range(Selected_rows_string)
    try
        Selected_range.delete
    Excel_Destroy()
}

/*
    函数:  Excel_Row_DeleteSelect
    作用:  删除选中行
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_DeleteSelect(){
    global excel
    Excel_Get()
    try
        excel.Selection.EntireRow.Delete
    Excel_Destroy()
    ;~ sendinput,^-
    ;~ sleep,30
    ;~ sendinput,!r
    ;~ sleep,30
    ;~ sendinput,{enter}
}

/*
    函数:  Excel_Row_Insert
    作用:  插入列
    参数: fPos,T=上侧，B=下侧
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlInsertFormatOrigin  常量
    xlFormatFromLeftOrAbove:=0
    xlFormatFromRightOrBelow:=1
*/
Excel_Row_Insert(fPos:="T"){
    global excel
    Excel_Get()
    if (fPos="B")
        excel.cells(excel.ActiveCell.row+1,excel.ActiveCell.column).select
    excel.Selection.EntireRow.Insert ;(CopyOrigin:=0)
}

/*
    函数:  Excel_Row_Select
    作用:  选中行
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_Select(){
    global excel
    Excel_Get()
    try
        excel.Selection.EntireRow.Select
    Excel_Destroy()
}

/*
    函数:  Excel_Row_Hide
    作用:  显示/隐藏 选中t行
    参数: 显示=0，隐藏=1
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Row_Hide(fTpye:=0){
    global excel
    Excel_Get()
    try{
        if(fTpye=0)
            excel.Selection.EntireRow.Hidden :=false
        else
            excel.Selection.EntireRow.Hidden :=true
    }
    Excel_Destroy()
}

;======【列】============================================================
/*
    函数:  Excel_Column_SetWidth
    作用:  修改列宽
    参数: -n，减少n，+n，增加n，n，设置为n
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_SetWidth(fWidth:="-1"){
    if (fWidth="")
		return
    global excel
    Excel_Get() 
    currentWidth := excel.Cells(excel.Selection.Column, excel.Selection.Column).ColumnWidth
    if (regexmatch(fWidth,"\+[0-9]+")) {		;增加列宽
		WidthNum:=substr(fWidth,2)
		try
            excel.Selection.ColumnWidth := currentWidth+WidthNum
	}else if (regexmatch(fWidth,"\-[0-9]+")) {	;减小列宽
		WidthNum:=substr(fWidth,2)
		try
			excel.Selection.ColumnWidth := currentWidth-WidthNum
	}else if (regexmatch(fWidth,"[0-9]+")) {		;设置列宽 		
		WidthNum:=substr(fWidth,1)
        try
            excel.Selection.ColumnWidth :=WidthNum
	}
	Excel_Destroy()
}

/*
    函数:  Excel_Column_AutoWidth
    作用:  自动列宽
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_AutoWidth(){
    global excel
    Excel_Get() 
    Rngs_left := excel.Selection.Column
    Rngs_top := excel.Selection.Row
    Rngs_right := Rngs_left + excel.Selection.Columns.Count - 1
    Rngs_bottom := Rngs_top + excel.Selection.Rows.Count - 1
    leftC := StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[2]
    rightC := StrSplit(excel.Cells(Rngs_top, Rngs_right).Address, "$")[2]
    topR:=StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[3]
    bottomR:=StrSplit(excel.Cells(Rngs_bottom, Rngs_left).Address, "$")[3]
    Selected_top_left := leftC . Rngs_top
    Selected_bottom_right := rightC .  Rngs_bottom
    Selected_range_string := Selected_top_left .  ":" . Selected_bottom_right
    Selected_range :=  excel.ActiveSheet.Range(Selected_range_string)
    try
        Selected_range.columns.autofit
    Excel_Destroy()
}

/*
    函数:  Excel_Column_DeleteFromCurrentToLast
    作用:  删除列，从当前列到最后一列
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_DeleteFromCurrentToLast(){
    global excel
    Excel_Get()  
    Rngs_left := excel.Selection.Column
    Rngs_top := excel.Selection.Row
    Rngs_right := Rngs_left + excel.Selection.Columns.Count - 1
    Rngs_bottom := Rngs_top + excel.Selection.Rows.Count - 1
    leftC := StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[2]
    rightC := StrSplit(excel.Cells(Rngs_top, Rngs_right).Address, "$")[2]
    topR:=StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[3]
    bottomR:=StrSplit(excel.Cells(Rngs_bottom, Rngs_left).Address, "$")[3]
    Selected_columns_string:=rightC . ":XFD"
    Selected_range :=  excel.ActiveSheet.Range(Selected_columns_string)
    try
        Selected_range.delete
    Excel_Destroy()
}

/*
    函数:  Excel_Column_DeleteFromCurrentToFirst
    作用:  删除列，从当前列到第一列
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_DeleteFromCurrentToFirst(){
    global excel
    Excel_Get()    
    Rngs_left := excel.Selection.Column
    Rngs_top := excel.Selection.Row
    Rngs_right := Rngs_left + excel.Selection.Columns.Count - 1
    Rngs_bottom := Rngs_top + excel.Selection.Rows.Count - 1
    leftC := StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[2]
    rightC := StrSplit(excel.Cells(Rngs_top, Rngs_right).Address, "$")[2]
    topR:=StrSplit(excel.Cells(Rngs_top, Rngs_left).Address, "$")[3]
    bottomR:=StrSplit(excel.Cells(Rngs_bottom, Rngs_left).Address, "$")[3]
    Selected_columns_string:="A:" . leftC
    Selected_range :=  excel.ActiveSheet.Range(Selected_columns_string)
    try
        Selected_range.delete
     Excel_Destroy()
}

/*
    函数:  Excel_Column_DeleteSelect
    作用:  删除选中列
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_DeleteSelect(){
    global excel
    Excel_Get()
    try
        excel.Selection.EntireColumn.Delete
    Excel_Destroy()
}

/*
    函数:  Excel_Column_Insert
    作用:  插入列
    参数: fPos,L=左侧，R=右侧
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlInsertFormatOrigin  常量
    xlFormatFromLeftOrAbove:=0
    xlFormatFromRightOrBelow:=1
*/
Excel_Column_Insert(fPos:="L"){
    global excel
    Excel_Get()
    if (fPos="R")
        excel.cells(excel.ActiveCell.row,excel.ActiveCell.column+1).select
    excel.Selection.EntireColumn.Insert ;(CopyOrigin:=0)
    Excel_Destroy()
}

/*
    函数:  Excel_Column_Select
    作用:  选中列
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_Select(){
    global excel
    Excel_Get()
    try
        excel.Selection.EntireColumn.Select
    Excel_Destroy()
}

/*
    函数:  Excel_Column_Hide
    作用:  显示/隐藏 选中列
    参数: 显示=0，隐藏=1
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Column_Hide(fTpye:=0){
    global excel
    Excel_Get()
    try{
        if(fTpye=0)
            excel.Selection.EntireColumn.Hidden := false
        else
            excel.Selection.EntireColumn.Hidden := true
    }
    Excel_Destroy()
}


;======【单元格】============================================================
/*
    函数:  Excel_Selection_Delete
    作用:  删除选中，上移
    参数: fType，上移，左移，整行，整列
    返回: 
    作者:  Kawvin
    版本:  0.1
    XlDirection常量
    xlToLeft := -4159  ;向左
    xlUp := -4162      ;向上
*/
Excel_Selection_Delete(fType:="上移"){
    if(fType="")
        return
    global excel
    Excel_Get()
    if(fType="上移")
        try
            excel.Selection.Delete(Shift:=-4162)
    if(fType="左移")
        try
            excel.Selection.Delete(Shift:=-4159)
    if(fType="整行")
        try
            excel.Selection.EntireRow.Delete
    if(fType="整列")
        try
            excel.Selection.EntireColumn.Delete
    Excel_Destroy()
}

/*
    函数:  Excel_Selection_AddRange
    作用:  添加选择单元格
    参数: 上，下，左，右
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Selection_AddRange(fDirection){
    if (fDirection="")
        return
    if (fDirection="上")
        sendinput,+{up}
    if (fDirection="下")
        sendinput,+{down}
    if (fDirection="左")
        sendinput,+{left}
    if (fDirection="右")
        sendinput,+{right}
}

/*
    函数:  Excel_Selection_AddRegion
    作用:  添加选择区域
    参数: 上，下，左，右
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Selection_AddRegion(fDirection){
    if (fDirection="")
        return
    if (fDirection="上")
        sendinput,^+{up}
    if (fDirection="下")
        sendinput,^+{down}
    if (fDirection="左")
        sendinput,^+{left}
    if (fDirection="右")
        sendinput,^+{right}
}

/*
    函数:  Excel_Range_Merge
    作用:  合并单元格
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Range_Merge(){
    global excel
    Excel_Get()
    If (excel.Selection.MergeCells)
        try
            excel.Selection.MergeCells :=False
    Else
        try
            excel.Selection.MergeCells :=  True
    Excel_Destroy()
}

/*
    函数:  Excel_Range_MergeAndKeepValue
    作用:  合并单元格且保留所有内容
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Range_MergeAndKeepValue(){
    global excel
    Excel_Get()
    try{    
        CellsCount:=excel.Selection.count()
        RngR:=
        RngC:=
        RngNewStr:=
        loop,% CellsCount
        {
            RngR:=excel.selection.cells(A_index)
            if not IsObject(RngC)
            {
                RngC:=RngR
                RngNewStr := RngR.formula
                continue
            }
            if (RngC.Column()<>RngR.Column())
                RngNewStr := RngNewStr  .  " "  .  RngR.formula
          Else
                RngNewStr := RngNewStr  .  "`n"  .  RngR.formula
            RngR:=
        }
        RngC.formula:=RngNewStr
        excel.DisplayAlerts := False
        excel.Selection.MergeCells :=  True
        excel.DisplayAlerts := True
    }
    excel.DisplayAlerts := True
    Excel_Destroy()
}

/*
    函数:  Excel_Range_Edit
    作用:  编辑单元格
    参数: fPos，R=替换，F=头部，空格=尾部
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Range_Edit(fPos:=""){
    ;~ QZ_VIMD_ClearInput()
    if (fPos="R")
        sendinput,{del}
    sendinput,{f2}
    if (fPos="F")
        sendinput,{home}
}

/*
    函数:  Excel_Range_FillWith
    作用:  填充当前单元格-以
    参数: fPos，上，下，左，右
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Range_FillWith(fPos:=""){
    if (fPos="")
        return
    global excel
    Excel_Get() 
    if (fPos="上"){
        try
            excel.cells(excel.ActiveCell.row,excel.ActiveCell.column):=excel.cells(excel.ActiveCell.row-1,excel.ActiveCell.column)
    }
    if (fPos="下"){
        try
            excel.cells(excel.ActiveCell.row,excel.ActiveCell.column):=excel.cells(excel.ActiveCell.row+1,excel.ActiveCell.column)
    }
    if (fPos="左"){
        try
           excel.cells(excel.ActiveCell.row,excel.ActiveCell.column):=excel.cells(excel.ActiveCell.row,excel.ActiveCell.column-1)
    }
    if (fPos="事"){
        try
            excel.cells(excel.ActiveCell.row,excel.ActiveCell.column):=excel.cells(excel.ActiveCell.row,excel.ActiveCell.column+1)
    }
    Excel_Destroy()
}

;======【格式】============================================================
/*
    函数:  Excel_Format_SetBonder
    作用:  设置边框
    参数: fPos，绘图位置，全部，四周，向下对角线，向上对角线，底边框，左边框，右边框，上边框，内部水平，内部垂直
            fLinStele，线形，点线，实线，虚线，双线
            fWdight，线粗，粗，中，细，极细
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlLinestyle常量，xlDot:=-4118,xlContinuous:=1,xlDash:=-4115,xlDouble:= -4119,xlLineStyleNone :=-4142
    ; XlBorderWeight常量，xlHairline:=1,xlMedium:=-4138,xlThick:=4,xlThin:=2
    ;XlBordersIndex常量，xlDiagonalDown:=5,xlDiagonalUp:=6,xlEdgeBottom:=9,xlEdgeLeft:=7,xlEdgeRight:=10,xlEdgeTop:=8,xlInsideHorizontal:=12,xlInsideVertical:=11
    调用方法：
    内部垂直方向-实线   Excel_Format_SetBonder("内部垂直","实线","细")
    内部垂直方向-点线   Excel_Format_SetBonder("内部垂直","点线","极细")
    内部水平方向-实线   Excel_Format_SetBonder("内部水平","实线","细")
    内部水平方向-点线   Excel_Format_SetBonder("内部水平","点线","极细")
    边框-全部细实线      Excel_Format_SetBonder("全部","实线","细")
    边框-全部无边框      Excel_Format_SetBonder("全部","无","细")
    边框-四周双线         Excel_Format_SetBonder("四周","双线","粗")
    边框-四周实线         Excel_Format_SetBonder("四周","实线","细")
    边框-四周粗实线     Excel_Format_SetBonder("四周","实线","中")
    边框-边实内点         Excel_Format_SetBonder("四周","实线","细")+Excel_Format_SetBonder("内部垂直","点线","极细")+ Excel_Format_SetBonder("内部水平","点线","极细")
*/
Excel_Format_SetBonder(fPos,fLineStyle,fWeight){
    LineStyleArray:={"点线":-4118,"实线":1,"虚线":-4115,"双线":-4119,"无":-4142}
    WeightArray:={"粗":4,"中":-4138,"细":2,"极细":1}
    PosArray:={"向下对角线":5,"向上对角线":6,"底边框":9,"左边框":7,"右边框":10,"上边框":8,"内部水平":12,"内部垂直":11}
    global excel
    Excel_Get()
    excel.ScreenUpdating:=false
    if (fPos="四周")  {
        excel.Selection.Borders(PosArray["底边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["底边框"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["左边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["左边框"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["右边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["右边框"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["上边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["上边框"]).Weight := WeightArray[fWeight]
    } else if (fPos="全部"){
        excel.Selection.Borders(PosArray["内部水平"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["内部水平"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["内部垂直"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["内部垂直"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["底边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["底边框"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["左边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["左边框"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["右边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["右边框"]).Weight := WeightArray[fWeight]
        excel.Selection.Borders(PosArray["上边框"]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray["上边框"]).Weight := WeightArray[fWeight]
    } else {
        excel.Selection.Borders(PosArray[fPos]).LineStyle := LineStyleArray[fLineStyle]
        if (fLineStyle!="无")
            excel.Selection.Borders(PosArray[fPos]).Weight := WeightArray[fWeight]
    }
    excel.ScreenUpdating:=true
    Excel_Destroy()
}

/*
    函数:  Excel_Format_Thousands
    作用: 千分位
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_Thousands(){
    sendinput,!h
    sleep,30
    sendinput,k
    ;Selection:=excel.Selection
    ;Selection.Style := "Comma"
}

/*
    函数:  Excel_Format_InsertIndent
    作用: 缩进对齐
    参数: 正数增加缩进，负数减少缩进
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_InsertIndent(fIndent:=1){
    global excel
    Excel_Get()
    try
        excel.Selection.InsertIndent(fIndent)
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetFontSize
    作用:  设置字号
    参数: -n，减少n，+n，增加n，n，设置为n
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetFontSize(fSize:=10){
    if (fSize="")
		return
    global excel
    Excel_Get() 
    currentFontSize := excel.Selection.Font.Size
    if (regexmatch(fSize,"\+[0-9]+")) {		;增加字号
		FontSizeNum:=substr(fSize,2)
		try
            excel.Selection.Font.Size := currentFontSize+FontSizeNum
	}else if (regexmatch(fSize,"\-[0-9]+")) {	;减小字号
		FontSizeNum:=substr(fSize,2)
		try
			excel.Selection.Font.Size := currentFontSize-FontSizeNum
	}else if (regexmatch(fSize,"[0-9]+")) {		;设置字号 		
		FontSizeNum:=substr(fSize,1)
        try
            excel.Selection.Font.Size :=FontSizeNum
	}
	Excel_Destroy()
}
    
/*
    函数:  Excel_Format_SetAlignment
    作用: 设置对齐
    参数: fTpye，水平，垂直
    返回: fAlignment，（水平），居中，跨列居中，分散对齐，填充，常规，两端对齐，左对齐，右对齐
                                   （垂直），靠下，居中，分散对齐，两端对齐，靠上
    作者:  Kawvin
    版本:  0.1
    ;XlHAlign   常量
    xlHAlignCenter:=-4108，xlHAlignCenterAcrossSelection:=7，xlHAlignDistributed:=-4117，xlHAlignFill:=5，xlHAlignGeneral:=	1， xlHAlignJustify:=-4130，xlHAlignLeft:=-4131, xlHAlignRight	:=-4152
    ;XlVAlign  常量
    xlVAlignBottom:=-4107,xlVAlignCenter:=-4108,xlVAlignDistributed:=-4117,xlVAlignJustify:=-4130,xlVAlignTop:=-4160
*/
Excel_Format_SetAlignment(fTpye:="水平",fAlignment:="左对齐"){
    global excel
    Excel_Get() 
    if(fTpye="水平"){
        if(fAlignment="居中"){
            try
                excel.Selection.HorizontalAlignment := -4108
        } if(fAlignment="跨列居中"){
            try
                excel.Selection.HorizontalAlignment := 7
        }if(fAlignment="分散对齐"){
            try
                excel.Selection.HorizontalAlignment := -4117
        }if(fAlignment="填充"){
            try
                    excel.Selection.HorizontalAlignment := 5
        }if(fAlignment="常规"){
            try
                excel.Selection.HorizontalAlignment := 1
        }if(fAlignment="两端对齐"){
            try
                excel.Selection.HorizontalAlignment := -4130
        }if(fAlignment="左对齐"){
            try
                excel.Selection.HorizontalAlignment := -4131
        }if(fAlignment="右对齐"){
            try
                excel.Selection.HorizontalAlignment := -4152
        }
    }
    if(fTpye="垂直"){
        if(fAlignment="靠下"){
            try
                excel.Selection.VerticalAlignment := -4107
        } if(fAlignment="居中"){
            try
                excel.Selection.VerticalAlignment := -4108
        }if(fAlignment="分散对齐"){
            try
                excel.Selection.VerticalAlignment := -4117
        }if(fAlignment="两端对齐"){
            try
                excel.Selection.VerticalAlignment := -4130
        }if(fAlignment="靠上"){
            try
                excel.Selection.VerticalAlignment :=-4160
        }
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetDecimalNum
    作用: 设置对齐
    参数: fNum，小数位数
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetDecimalNum(fNum:=2){
    global excel
    Excel_Get() 
    if(fNum=0)
        StrNum:="0"
    else
        StrNum:="0." . substr("0000000000",1-fNum)
    try
        excel.Selection.NumberFormatLocal := StrNum
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetDecimalNum_Shrink
    作用: 减少小数位
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetDecimalNum_Shrink(){
    sendinput,!h
    sleep,30
    sendinput,9
}

/*
    函数:  Excel_Format_SetDecimalNum_Grow
    作用: 增加小数位
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetDecimalNum_Grow(){
    sendinput,!h
    sleep,30
    sendinput,0
}

/*
    函数:  Excel_Format_DisplayZeros
    作用: 显示/不显示【零值】
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_DisplayZeros(){
    global excel
    Excel_Get() 
    try
        excel.ActiveWindow.DisplayZeros := not excel.ActiveWindow.DisplayZeros
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetColor
    作用: 设置字体、填充颜色
    参数: fMyColor,如果为空，则自动获取热键值，否则设置
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetColor(fMyColor:=""){
    global Vim
	global excel
    Excel_Get() 
	if (fMyColor=""){
		MyType:=substr(Vim.HotKeyStr,1,1)
		MyIndex:=substr(Vim.HotKeyStr,2)
	} else {
		MyType:=substr(fMyColor,1,1)
		MyIndex:=substr(fMyColor,2)
	}
    if ((MyIndex+0)>0)
		MyIndex=g%MyIndex%
	;红色=3，蓝色=33，黄色=6，绿色=4，橙色=45，灰1=15，灰2=48，灰3=16，灰4=56，白色=2，黑色=1，自动=-4105，无=-4142
	;浅红=22，浅蓝=28，浅黄=36，浅绿=35，浅橙=40
    MyColorArray1:={"r":3,"b":33,"y":6,"g":4,"o":45,"g1":15,"g2":48,"g3":16,"g4":56,"w":2,"k":1,"a":-4105,"n":-4142}
    MyColorArray2:={"R":22,"B":28,"Y":36,"G":35,"O":40}
    if RegExMatch(MyIndex,"^[a-z0-9]+$")
        MyValue:=MyColorArray1[MyIndex]
    else
        MyValue:=MyColorArray2[MyIndex]
    if (MyType="r")		;填充颜色
	{
		try
			excel.Selection.Interior.ColorIndex:=MyValue
	}
    if (MyType="t")		;字体颜色
	{
		try
			excel.Selection.font.ColorIndex:=MyValue
	}
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetMinus
    作用: 用括号格式化负数
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetMinus(){
    global excel
    Excel_Get() 
    try
        excel.Selection.NumberFormatLocal := "0_);[红色](0)"
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetPercent
    作用: 百分号
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetPercent(){
    sendinput,!h
    sleep,30
    sendinput,p
    ;global excel
    ;Excel_Get() 
    ;excel.Selection.Style := "Percent"
    ;Excel_Destroy()
}

/*
    函数:  Excel_Format_SetUnderline
    作用: 设置/取消下划线
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlUnderlineStyle  常量
    xlUnderlineStyleDouble:=-4119
    xlUnderlineStyleDoubleAccounting:=5
    xlUnderlineStyleNone:=-4142
    xlUnderlineStyleSingle:=2
    xlUnderlineStyleSingleAccounting:=4
*/
Excel_Format_SetUnderline(){
    global excel
    Excel_Get() 
    try{
        If (excel.Selection.Font.Underline = -4142)
            excel.Selection.Font.Underline := 2
        Else
            excel.Selection.Font.Underline := -4142
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetItalic
    作用: 设置/取消斜体
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetItalic(){
    global excel
    Excel_Get() 
    try{
        If (excel.Selection.Font.Italic)
            excel.Selection.Font.Italic := False
        Else
            excel.Selection.Font.Italic := True
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Format_SetBold
    作用: 设置/取消粗体
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_SetBold(){
    global excel
    Excel_Get() 
    try{
        If (excel.Selection.Font.Bold)
            excel.Selection.Font.Bold := False
        Else
            excel.Selection.Font.Bold := True
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Format_WrapText
    作用: 自动换行
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_WrapText(){
    global excel
    Excel_Get() 
    try{
        If (excel.Selection.WrapText)
           excel.Selection.WrapText := False
        Else
           excel.Selection.WrapText := True
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Format_Normal
    作用: 通用格式
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_Normal(){
    global excel
    Excel_Get() 
    try
        excel.Selection.NumberFormatLocal := "G/通用格式"
    Excel_Destroy()
}

/*
    函数:  Excel_Format_Text
    作用: 通用格式
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_Text(){
    global excel
    Excel_Get() 
    try
        excel.Selection.NumberFormatLocal := "@"
    Excel_Destroy()
}

/*
    函数:  Excel_Format_Date
    作用: 通用格式
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_Date(fSplit:=""){
    global excel
    Excel_Get() 
    try{
        if(fSplit="d")
            excel.Selection.NumberFormatLocal := "yyyymmdd"
        if(fSplit="/")
            excel.Selection.NumberFormatLocal := "yyyy/mm/dd"
        if(fSplit="z")
            excel.Selection.NumberFormatLocal := "[$-x-sysdate]dddd, mmmm dd, yyyy"
        if(fSplit="-")
            excel.Selection.NumberFormatLocal := "yyyy-mm-dd"
        if(fSplit=".")
            excel.Selection.NumberFormatLocal := "yyyy.mm.dd"
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Format_setFontName
    作用: 设置字体E
    参数: fFontName
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Excel_Format_setFontName(fFontName:="宋体"){
	if (fFontName="")
		return
	global Excel
	Excel_Get()
	try
		Excel.Selection.Font.Name :=fFontName
	Excel_Destroy()
}

;======【视图】============================================================
/*
    函数:  Excel_View_NormalOrPageBreak
    作用:  切换正常查看/分页预览
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlWindowView  常量
    xlNormalView:=1
    xlPageBreakPreview:=2
*/
Excel_View_NormalOrPageBreak(){
    global excel
    Excel_Get() 
   If (excel.ActiveWindow.View = 2)
        excel.ActiveWindow.View := 1
    Else
        excel.ActiveWindow.View := 2
    Excel_Destroy()
}

/*
    函数:  Excel_View_PrintPreView
    作用:  打印预览
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_View_PrintPreView(){
    sendinput,^{f2}
}

/*
    函数:  Excel_View_DisplayAutomaticPageBreaks
    作用:  显示/不显示自动分页线
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_View_DisplayAutomaticPageBreaks(){
    global excel
    Excel_Get() 
    try
        excel.ActiveSheet.DisplayAutomaticPageBreaks := Not excel.ActiveSheet.DisplayAutomaticPageBreaks
    Excel_Destroy()
}

/*
    函数:  Excel_Zoom
    作用: 比例设置
    参数: +n，比例增加n
			 -n，比例减少n
			 n，设置比例为n
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Excel_Zoom(fZoom:="-5"){
	if (fZoom="")
		return
	global excel
	Excel_Get()
    excel.ScreenUpdating:=false
	if (regexmatch(fZoom,"\+[0-9]+")) {		;放大
		ZoomNum:=substr(fZoom,2)
		try
			excel.ActiveWindow.Zoom+=ZoomNum
	}else if (regexmatch(fZoom,"\-[0-9]+")) {	;缩小
		ZoomNum:=substr(fZoom,2)
		try
			excel.ActiveWindow.Zoom-=ZoomNum
	}else if (regexmatch(fZoom,"[0-9]+")) {		;设置比例 		
		ZoomNum:=substr(fZoom,1)
		if(ZoomNum<10)
			ZoomNum:=10
		if(ZoomNum>500)
			ZoomNum:=500
		try
			excel.ActiveWindow.Zoom:=ZoomNum
	}else {
		try
			excel.ActiveWindow.Zoom-=5
	}
    excel.ScreenUpdating:=true
	Excel_Destroy()
}

/*
    函数:  Excel_Dialogs
    作用: 显示对话框
    参数: fDig，对话框常数
    返回:
    作者:  Kawvin
    版本:  0.1
    XlBuiltInDialog  常量
    xlDialogPageSetup:=7
    xlDialogSummaryInfo:=474
    xlDialogFilter:=447
    xlDialogFilterAdvanced:=370
    xlDialogSort:=39
    xlDialogDataDelete:=36
    xlDialogPasteSpecial:=53    ;选择性粘贴

*/
Excel_Dialogs(fDig){
	if (fDig="")
		return
	global excel
    Excel_Get() 
	try
		excel.Dialogs(fDig).show
	;Excel_Destroy()
}

/*
    函数:  Excel_Dialogs_Sort
    作用:  排序对话框
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Dialogs_Sort(){
    global excel
	Excel_Dialogs(39)
	Excel_Destroy()
}

/*
    函数:  Excel_Dialogs_PageSetup
    作用:  显示页面设置对话框
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Dialogs_PageSetup(){
    global excel
	Excel_Dialogs(7)
	Excel_Destroy()
}

/*
    函数:  Excel_Dialogs_Insert_Picture
    作用: 插入图片对话框
    参数: 
    返回:
    作者:  天甜
    版本:  0.1
*/
Excel_Dialogs_Insert_Picture(){
	sendinput {Alt Down}{Alt Up}
	Sleep 150
	sendinput n
	sendinput p
	return
}

;======【数据处理】============================================================
/*
    函数:  Excel_Data_DeleteRepetition
    作用:  删除重复项
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Data_DeleteRepetition(){
    ;sendinput,!a
    sendinput,{alt down}    ;分开写，避免与其他截图类软件冲突
    sleep,50
    sendinput,{alt up}
    sleep,100
    sendinput,a
    sleep,100
    sendinput,m
}

/*
    函数:  Excel_Data_SetPrintArea
    作用:  设置打印区域
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Data_SetPrintArea(){
    global excel
    Excel_Get() 
    try
        excel.ActiveSheet.PageSetup.PrintArea := excel.Selection.Address
    Excel_Destroy()
}

;======【定位】============================================================
/*
    函数:  Excel_Location_ColumnFirstCell
    作用:  定位到列第一个单元格
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Location_ColumnFirstCell(){
    global excel
    Excel_Get() 
    try
        excel.Cells(1, excel.ActiveCell.Column).Select
    Excel_Destroy()
}

/*
    函数:  Excel_Location_Cell
    作用:  定位到[x]列[n]行
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Location_Cell(){
    prompt=
    (LTrim
    定位单元格，输入格式：
    1)移动到同行[B]列，命令格式：B
    2)移动到同列[16]行，命令格式：16
    3)移动到[C]列[5]行，命令格式：C5
    )
    InputBox,cmd_Buff,请输入命令,%prompt%, , 300,200
    if ErrorLevel
        return
    if (cmd_Buff="")
        return
    global excel
    Excel_Get() 
    try{
        if RegExMatch(cmd_Buff,"i)[a-z]+(\d)+")
        {
            buff_string := substr(cmd_buff, 1)
            excel.ActiveSheet.range(buff_string).Activate
        } else if RegExMatch(cmd_Buff,"im)[a-z]+$") {
            buff_string := substr(cmd_buff, 1)
            column_string := buff_string
            RngAdd:=column_string . excel.ActiveCell.Row
            excel.ActiveSheet.range(RngAdd).Activate
        } else if RegExMatch(cmd_Buff,"#*") {
            buff_string := substr(cmd_buff, 1)
            row_number := buff_string
            excel.Cells(row_number, excel.ActiveCell.Column).Activate
        } 
        excel.ScreenUpdating := True
    }
    excel.ScreenUpdating := True
    Excel_Destroy()
}

/*
    函数:  Excel_Location_EdgeCell
    作用:  定位到区域边缘
    参数: 上，下，左，右
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Location_EdgeCell(fDirection){
    if (fDirection="")
        return
    if (fDirection="上")
        sendinput,^{up}
    if (fDirection="下")
        sendinput,^{down}
    if (fDirection="左")
        sendinput,^{left}
    if (fDirection="右")
        sendinput,^{right}
}

/*
    函数:  Excel_Location_EdgeNextCell
    作用:  定位到区域边缘，下一单元格
    参数: 上，下，左，右
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Location_EdgeNextCell(fDirection){
    if (fDirection="")
        return
    if (fDirection="上"){
        sendinput,^{up}
        sendinput,{up}
    }
    if (fDirection="下"){
        sendinput,^{down}
        sendinput,{down}
    }
    if (fDirection="左"){
        sendinput,^{left}
        sendinput,{left}
    }
    if (fDirection="右"){
        sendinput,^{right}
        sendinput,{right}
    }
}

/*
    函数:  Excel_Location_ColumnLastCell
    作用:  定位列最后一个非空单元格
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
    ;XlDirection常量
    xlDown := -4121    ;向下
    xlToLeft := -4159  ;向左
    xlToRight := -4161 ;向右
    xlUp := -4162      ;向上
*/
Excel_Location_ColumnLastCell(){
    global excel
    Excel_Get() 
    try
        excel.Cells(excel.ActiveSheet.Rows.Count, excel.ActiveCell.Column).End(-4162).Activate
    Excel_Destroy()
}

;======【其他】============================================================
/*
    函数:  Excel_Comment_Add
    作用:  批注-添加
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Comment_Add(){
    global excel
    Excel_Get() 
    CurRow:=excel.ActiveCell.row
    CurCol:=excel.ActiveCell.Column
    InputBox, NewString, 输入, 请输入注释内容, , 300,150
    if ErrorLevel
        return
    if (NewString="")
        return
    try{
        excel.ActiveCell.AddComment
        excel.ActiveCell.Comment.Visible:= False
        NewString=% excel.UserName ": `n" NewString
        excel.ActiveCell.Comment.Text(Text:=NewString)
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Find_NextOrPrevious
    作用:  查找前一项，后一项
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Find_NextOrPrevious(fDriection:="N"){
    global excel
    Excel_Get() 
    try{
        if (fDriection="P")
            Rng:=excel.Cells.findPrevious(After:=excel.ActiveCell)
        if (fDriection="N")
            Rng:=excel.Cells.findNext(After:=excel.ActiveCell)
        if IsObject(Rng)
            Rng.Activate
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Cliboard_PasteAsValue
    作用:  粘贴为数值
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlPasteType  常量
    xlPasteAll:=-4104
    xlPasteAllExceptBorders:=7
    xlPasteColumnWidths:=8
    xlPasteComments:=-4144
    xlPasteFormats:=-4122
    xlPasteFormulas:=-4123
    xlPasteFormulasAndNumberFormats:=11
    xlPasteValidation:=6
    xlPasteValues:=-4163
    xlPasteValuesAndNumberFormats:=12
*/
Excel_Cliboard_PasteAsValue(){
    global excel
    Excel_Get() 
    try
        excel.Selection.PasteSpecial(Paste:=-4163)
    Excel_Destroy()
    ;sendinput,^!v
    ;sleep,50
    ;sendinput,v
    ;sleep,50
    ;sendinput,{enter}
}

/*
    函数:  Excel_Cliboard_PasteSelcet
    作用:  选择性粘贴
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Cliboard_PasteSelcet(){
    sendinput,^!v
}

/*
    函数:  Excel_SetNNN
    作用:  调整所选行高h[n],列宽w[n],字号f[n]
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_SetNNN(){
    prompt=
    (LTrim
    调整行高/列宽/字号，输入格式：
    1)调整所选行高为n，命令格式：h20
    2)调整所选列宽为n，命令格式：w8
    3)转变字号为n，命令格式：f14
    4)设置显示比例为n，命令格式：z80
    )
    InputBox,cmd_Buff,请输入命令,%prompt%, , 300,200
    if ErrorLevel
        return
    if (cmd_Buff="")
        return
    if RegExMatch(cmd_Buff,"i)h(\d)+")
    {
        buff_string := substr(cmd_buff, 2)
        Excel_Row_SetHeight(buff_string)
    } else if RegExMatch(cmd_Buff,"i)w(\d)+")  {
        buff_string := substr(cmd_buff, 2)
        Excel_Column_SetWidth(buff_string)
    } else if RegExMatch(cmd_Buff,"i)f(\d)+")  {
        buff_string := substr(cmd_buff, 2)
        Excel_Format_SetFontSize(buff_string)
    } else if RegExMatch(cmd_Buff,"i)z(\d)+")  {
        buff_string := substr(cmd_buff, 2)
        Excel_Zoom(buff_string)
    } 
}

/*
    函数:  Excel_FormatBrush
    作用:  格式刷
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
    xlPasteFormats:=-4122
*/
Excel_FormatBrush(){
    global excel
    Excel_Get() 
    try
        excel.Selection.PasteSpecial(Paste:=-4122)
    Excel_Destroy()

    ;~ Selection.copy
    ;~ MyCopyMode:=true
    ;~ try
    ;~ Selection.pastefomart
    ;~ excel.CutCopyMode := true

    ;~ send,{alt down}{alt up}
    ;~ send,hfp
    ;~ sendinput,^!v
    ;~ sleep,50
    ;~ sendinput,t
    ;~ sleep,50
    ;~ sendinput,{enter}
}

/*
    函数:  Excel_RepeatAction
    作用:  重复命令
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_RepeatAction(){
    sendinput,{f4}
}

/*
    函数:  Excel_ErrorCheck
    作用:  错误检查
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_ErrorCheck(){
    global excel
    Excel_Get() 
    loop,% excel.Worksheets.Count
    {
        Esh:=excel.Worksheets(A_index)
        Esh.activate
        loop,% Esh.UsedRange.count
        {
            ERng:=Esh.UsedRange.cells(A_index)
            if (ERng.text="#DIV/0!")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#DIV/0!"
                ERng.Select
                Excel_Destroy()
                return
            }
            if (ERng.text="#N/A")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#N/A"
                ERng.Select
                Excel_Destroy()
                return
            }
            if (ERng.text="#NAME?")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#NAME?"
                ERng.Select
                Excel_Destroy()
                return
            }
            if (ERng.text="#NULL!")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#NULL!"
                ERng.Select
                Excel_Destroy()
                return
            }
            if (ERng.text="#NUM!")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#NUM!"
                ERng.Select
                Excel_Destroy()
                return
            }
            if (ERng.text="#REF!")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#REF!"
                ERng.Select
                Excel_Destroy()
                return
            }
            if (ERng.text="#VALUE!")
            {
                MsgBox % "工作表：" . Esh.Name . "的单元格：" . ERng.Address . "`n" . "错误类型：#VALUE!"
                ERng.Select
                Excel_Destroy()
                return
            }
        }	
    }
    Excel_Destroy()
    MsgBox, 64, Excel_VIMD, 检查完毕，未发现错误。
}

/*
    函数:  Excel_CursorCross
    作用:  启用十字光标
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
    ; XlFormatConditionType  常量
    Global xlCellValue:=1
    Global xlExpression:=2
*/
Excel_CursorCross(aEnable:=1){
    global excel
    Excel_Get() 
    excel.Cells.FormatConditions.Delete
    if (aEnable=1)
    {
        iColor := 33
        try{
            excel.selection.EntireRow.FormatConditions.Delete
            excel.selection.EntireRow.FormatConditions.Add(2, , "TRUE")
            excel.selection.EntireRow.FormatConditions.Item(1).Interior.ColorIndex := iColor
            excel.selection.EntireColumn.FormatConditions.Delete
            excel.selection.EntireColumn.FormatConditions.Add(2, , "TRUE")
            excel.selection.EntireColumn.FormatConditions.Item(1).Interior.ColorIndex := iColor
        }
    }
    Excel_Destroy()
}

;======【筛选】============================================================
/*
    函数:  Excel_Filter_ShowList
    作用:  筛选，显示筛选内容列表
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_ShowList(){
    FilteredRowColon:=
    FilteredRow:=
    global excel
    Excel_Get() 
    try{
        FilteredRowColon := strSplit(excel.ActiveSheet.AutoFilter.Range.Rows(1).Address, "$")[3]
        FilteredRow := strSplit(FilteredRowColon, ":")[1]
        excel.Cells(FilteredRow, excel.ActiveCell.Column).Activate
        Sendinput,!{DOWN}
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_ShowDialog
    作用:  筛选，显示筛选对话框
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_ShowDialog(){
    FilteredRowColon:=
    FilteredRow:=
    global excel
    Excel_Get() 
    try{
        FilteredRowColon := strSplit(excel.ActiveSheet.AutoFilter.Range.Rows(1).Address, "$")[3]
        FilteredRow := strSplit(FilteredRowColon, ":")[1]
        excel.Cells(FilteredRow, excel.ActiveCell.Column).select
        Sendinput,!{DOWN}
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_NotInclude
    作用:  筛选，不包含
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_NotInclude(){
    global excel
    Excel_Get() 
    CustomAutoFilter("<>*", excel.ActiveCell.Value "*" ,"fe")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_NotEqual
    作用:  筛选，数值不等于（<>）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_NotEqual(){
    global excel
    Excel_Get() 
    CustomAutoFilter("<>", excel.ActiveCell.Value,"fn")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_EqualAsFront
    作用:  筛选，前几个字符相同
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_EqualAsFront(fN){
    buff_string:="f" . fN
    begin_int:=fN
    global excel
    Excel_Get() 
    CustomAutoFilter("=", substr(excel.ActiveCell.Value,1,begin_int)  "*",buff_string)
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_EqualAsBehind
    作用:  筛选，后几个字符相同
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_EqualAsBehind(fN){
    buff_string:="F" . fN
    begin_int:=fN
    global excel
    Excel_Get() 
    CustomAutoFilter("=", "*" substr(excel.ActiveCell.Value,1-begin_int),buff_string)
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Include
    作用:  筛选，包含
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Include(){
    global excel
    Excel_Get() 
    CustomAutoFilter("=*", excel.ActiveCell.Value "*" ,"fi")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Sort
    作用:  筛选，排列
    参数: fReserve,0=升序排列，1=降序排列
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Sort(fReserve:=0){
    FilteredRowColon:=
    FilteredRow:=
    global excel
    Excel_Get() 
    try{
        FilteredRowColon := strSplit(excel.ActiveSheet.AutoFilter.Range.Rows(1).Address, "$")(3)
        FilteredRow := strSplit(FilteredRowColon, ":")(1)
        excel.Cells(FilteredRow, excel.ActiveCell.Column).Activate
        Sendinput,!{DOWN}
        sleep,30
        if (fReserve)
            sendinput,o
        else
            sendinput,s
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_InteriorColor
    作用:  筛选，填充颜色
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_InteriorColor(){
    sendinput,{AppsKey}
    sleep,30
    sendinput,e
    sleep,30
    sendinput,c
}

/*
    函数:  Excel_Filter_FontColor
    作用:  筛选，字体颜色
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_FontColor(){
    sendinput,{AppsKey}
    sleep,30
    sendinput,e
    sleep,30
    sendinput,f
}

/*
    函数:  Excel_Filter_BeginWith
    作用:  筛选，开头是
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_BeginWith(){
    global excel
    Excel_Get() 
    CustomAutoFilter("=", excel.ActiveCell.Value "*" ,"fB")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_EqualOrGreater
    作用:  筛选，数值大于等于（>=）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_EqualOrGreater(){
    global excel
    Excel_Get() 
    CustomAutoFilter(">=", excel.ActiveCell.Value,"fo")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Greater
    作用:  筛选，数值大于（>）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Greater(){
    global excel
    Excel_Get() 
    CustomAutoFilter(">", excel.ActiveCell.Value,"f>")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_EqualOrLesser
    作用:  筛选，数值小于等于（<=）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_EqualOrLesser(){
    global excel
    Excel_Get() 
    CustomAutoFilter("<=", excel.ActiveCell.Value,"fu")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Lesser
    作用:  筛选，数值小于（<）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Lesser(){
    global excel
    Excel_Get() 
    CustomAutoFilter("<", excel.ActiveCell.Value,"f<")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Equal
    作用:  筛选，数值等于（=）
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Equal(){
    global excel
    Excel_Get() 
    CustomAutoFilter("", excel.ActiveCell.value,"f=")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Same
    作用:  筛选，相同的
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Same(){
    global excel
    Excel_Get() 
    CustomAutoFilter("=", excel.ActiveCell.value,"fs")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_Empty
    作用:  筛选，空单元格
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_Empty(){
    CustomAutoFilter("=", "","fb")
}

/*
    函数:  Excel_Filter_EndWith
    作用:  筛选，结尾是
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_EndWith(){
    global excel
    Excel_Get() 
    CustomAutoFilter("=", "*" excel.ActiveCell.Value,"fE")
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_InputBox
    作用:  筛选，输入框
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_InputBox(){
    prompt=
    (LTrim
    筛选输入数据，输入格式：
    01)小于%A_Tab%%A_Tab%命令格式：<30
    02)大于%A_Tab%%A_Tab%命令格式：>30
    03)等于（数值）%A_Tab%命令格式：=30
    04)相等%A_Tab%%A_Tab%命令格式：s30
    05)不等于%A_Tab%命令格式：<>30
    06)大于等于%A_Tab%命令格式：>=30
    07)小于等于%A_Tab%命令格式：<=30
    08)以xxx开头%A_Tab%命令格式：Bxxx
    09)以xxx结尾%A_Tab%命令格式：Exxx
    10)包含%A_Tab%%A_Tab%命令格式：i30
    11)不包含%A_Tab%命令格式：e30

    )
    InputBox,cmd_Buff,请输入命令,%prompt%, , 320,330 
    if ErrorLevel
        return
    if (cmd_Buff="")
        return
    if ((substr(cmd_Buff,1,2)=="<>") or  (substr(cmd_Buff,1,2)==">=") or  (substr(cmd_Buff,1,2)=="<="))
    {
        OutputType:=substr(cmd_Buff,1,2)
        OutputVar:=substr(cmd_Buff,3)
    } else {
        OutputType:=substr(cmd_Buff,1,1)
        OutputVar:=substr(cmd_Buff,2)
    }
    if (OutputType=="<")	;数值小于（<）
        CustomAutoFilter("<", OutputVar,"f<")
    else if (OutputType==">")	;数值大于（>）
        CustomAutoFilter(">", OutputVar,"f>")
    else if (OutputType=="=")  	;数值相等（=）
        CustomAutoFilter("=", OutputVar,"f=")
    else if (OutputType=="s") ;数值相等（=）
        CustomAutoFilter("=", OutputVar,"fs")
    else if (OutputType=="<>") ;不相同
        CustomAutoFilter("<>", OutputVar,"fn")
    else if (OutputType==">=")	;数值大于等于（>=）
        CustomAutoFilter(">=", OutputVar,"fo")
    else if (OutputType=="<=")	;数值小于等于（<=）
        CustomAutoFilter("<=", OutputVar,"fu")
    else if (OutputType=="B")	 ;以xxx开头
        CustomAutoFilter("=", OutputVar "*" ,"fB")
    else if (OutputType=="E")	 ;以xxx结尾
        CustomAutoFilter("=", "*" OutputVar,"fE")
    else if (OutputType=="i")	 ;包含
        CustomAutoFilter("=*", OutputVar "*" ,"fi")
    else if (OutputType=="e") ;不包含
        CustomAutoFilter("<>*", OutputVar "*" ,"fe")
}

/*
    函数:  Excel_Filter_NotEmpty
    作用:  筛选，非空单元格
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_NotEmpty(){
    CustomAutoFilter("<>", "","ff")
}

/*
    函数:  Excel_Filter_AutoFilter
    作用:  筛选，自动筛选
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_AutoFilter(){
    global excel
    Excel_Get() 
    try{
        If (excel.ActiveSheet.AutoFilterMode)
           excel.ActiveSheet.AutoFilterMode := False
        Else
           excel.Selection.AutoFilter
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_ResetAllColumns
    作用:  筛选，重置所有列筛选
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_ResetAllColumns(){
    global excel
    Excel_Get() 
    If (excel.ActiveSheet.AutoFilterMode)
    {
        try
            excel.ActiveSheet.ShowAllData
    }
    Excel_Destroy()
}

/*
    函数:  Excel_Filter_ResetCurrentColumn
    作用:  筛选，重置所选列筛选
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Excel_Filter_ResetCurrentColumn(){
    global excel
    Excel_Get() 
    try
        CustomAutoFilter("", excel.ActiveCell.Value,"fa")
    Excel_Destroy()
}

/*
    函数:  CustomAutoFilter
    作用:  主筛选函数
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
CustomAutoFilter(ArithmeticOpr, CurrentValue,period_buff){
    global excel
    Excel_Get() 
    try
    {
        fid:=
        fid_first_column:=
        CriteriaValue:=
        FilteredRowColon:=
        FilteredRow:=
        FilteredColumn:=
        c:=
        r:=
        b:=
        rgb:=
        CriteriaValue := ArithmeticOpr . CurrentValue    
        
        FilteredColumn := StrSplit(excel.ActiveSheet.AutoFilter.Range.Columns(1).Address, "$")(2)
        FilteredRowColon := StrSplit(excel.ActiveSheet.AutoFilter.Range.Rows(1).Address, "$")(3)
        FilteredRow := StrSplit(FilteredRowColon, ":")(1)

        fid_first_column := excel.ActiveSheet.Range(FilteredColumn "1:"   FilteredColumn   "1").Column
        fid := excel.ActiveCell.Column - fid_first_column + 1

        If (period_buff = "fa"){
            excel.ActiveSheet.Range("A1").CurrentRegion.AutoFilter(Field:=fid)
        } Else If (period_buff = "fc") Or (period_buff = "f'")  {  ;
            excel.ActiveSheet.Range("A1").CurrentRegion.AutoFilter(Field:=fid,,Operator:=xlFilterFontColor)
        } Else If (period_buff = "f=") {  ;
            excel.ActiveSheet.Range("A1").CurrentRegion.AutoFilter(Field:=fid,Criteria1:=CriteriaValue)
        } Else If (period_buff = "f;")   {
            TemColor:=excel.ActiveCell.Interior.color
            SetFormat, integerFast, hex
            msgbox % TemColor
            c := substr("000000"  TemColor, -5)
            r:=substr(c,1,2)
            g:=substr(c,3,2)
            b:=substr(5,2)
            SetFormat, IntegerFast, d
            r:=r
            g:=g
            b:=b
            rgb := "RGB(" . r . "," . g . "," . b . ")"
            MsgBox rgb
            excel.ActiveSheet.Range("A1").CurrentRegion.AutoFilter(Field:=fid, Criteria1:=rgb, Operator:=xlFilterCellColor)
        } Else {
          excel.ActiveSheet.Range("A1").CurrentRegion.AutoFilter(Field:=fid, Criteria1:=CriteriaValue)
        }
    }
    Excel_Destroy()
}

;{
;~ /* 
    ;~ 函数:  Excel_Filter_ShowDialog
    ;~ 作用:  筛选，显示筛选对话框
    ;~ 参数: 
    ;~ 返回: 
    ;~ 作者:  Kawvin
    ;~ 版本:  0.1
;~ */
;~ Excel_Filter_ShowDialog()
 ;~ {
    ;~ global excel
    ;~ Excel_Get() 
    ;~ fid:=
    ;~ fid_first_column:=
    ;~ CriteriaValue:=
    ;~ FilteredRowColon:=
    ;~ FilteredRow:=
    ;~ FilteredColumn:=
    ;~ FilteredColumn := strSplit(excel.ActiveSheet.AutoFilter.Range.Columns(1).Address, "$")[2]
    ;~ FilteredRowColon := strSplit(excel.ActiveSheet.AutoFilter.Range.Rows(1).Address, "$")[3]
    ;~ FilteredRow := strSplit(FilteredRowColon, ":")[1]
    
    ;~ fid_first_column := excel.ActiveSheet.Range(FilteredColumn   "1:"   FilteredColumn  "1").Column
    ;~ fid := excel.ActiveCell.Column - fid_first_column + 1
    ;~ msgbox fid_first_column : %fid_first_column%
    ;~ msgbox fid : %fid%
    
    ;~ if (excel.ActiveSheet.AutoFilterMode)
        ;~ excel.Dialogs(447).Show fid, excel.ActiveCell.Value
    ;~ else
        ;~ excel.Dialogs(447).Show
    ;~ Excel_Destroy()
;~ }
;}