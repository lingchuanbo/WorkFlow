Word: ;{
  global word
  vim.setwin("Word","OpusApp","WINWORD.EXE")
  vim.SetTimeOut(300,"Word")
  vim.mode("普通模式","Word")
  vim.map("<insert>","<Word_切换到【VIM模式】>","Word")
  
  vim.mode("VIM模式","Word")
  vim.map("<esc>","<Word_切换到【普通模式】>","Word")
  vim.map("e1","<Word_字号-初号(42)>","Word")
  vim.map("E1","<Word_字号-小初(36)>","Word")
  vim.map("a","<Word_向左>","Word")
  vim.map("d","<Word_向右>","Word")
  vim.map("w","<Word_向上>","Word")
  vim.map("s","<Word_向下>","Word")
  vim.map("W","<Word_PageUp>","Word")
  vim.map("S","<Word_PageDown>","Word")
  vim.map("A","<Word_Home>","Word")
  vim.map("D","<Word_End>","Word")
  vim.map("z","<Word_缩小10/100>","Word")
  vim.map("Z","<Word_放大5/100>","Word")
  ;~ vim.map("<RT>","<Word_字号-放大>","Word")
  ;~ vim.map("<LT>","<Word_字号-缩小>","Word")
  vim.map("[","<Word_设置字号、行距、显示比例>","Word")
  vim.map("c","<Word_复制（Ctrl+C）>","Word")
  vim.map("x","<Word_剪贴（Ctrl+X）>","Word")
  vim.map("v","<Word_粘贴（Ctrl+V）>","Word")
  vim.map("V","<Word_粘贴为无格式文本>","Word")
  vim.map("h","<Word_替换>","Word")
  vim.map("q1","<Word_左对齐>","Word")
  vim.map("q2","<Word_居中>","Word")
  vim.map("q3","<Word_右对齐>","Word")
  vim.map("q4","<Word_两端对齐>","Word")
  vim.map("q5","<Word_分散对齐>","Word")
  vim.map("qb","<Word_设置/取消粗体>","Word")
  vim.map("qd","<Word_设置/取消删除线>","Word")
  vim.map("qi","<Word_设置/取消斜体>","Word")
  vim.map("qu","<Word_设置/取消下划线>","Word")
  vim.map("e1","<Word_字号-一号(26)>","Word")
  vim.map("E0","<Word_字号-小初(36)>","Word")
  vim.map("e0","<Word_字号-初号(42)>","Word")
  vim.map("E1","<Word_字号-小一(24)>","Word")
  vim.map("e2","<Word_字号-二号(22)>","Word")
  vim.map("E2","<Word_字号-小二(18)>","Word")
  vim.map("e3","<Word_字号-三号(16)>","Word")
  vim.map("E3","<Word_字号-小三(15)>","Word")
  vim.map("e4","<Word_字号-四号(14)>","Word")
  vim.map("E4","<Word_字号-小四(12)>","Word")
  vim.map("e5","<Word_字号-五号(10)>","Word")
  vim.map("E5","<Word_字号-小五(9)>","Word")
  vim.map("e6","<Word_字号-六号(7)>","Word")
  vim.map("E6","<Word_字号-小六(6)>","Word")
  vim.map("e7","<Word_字号-七号(5)>","Word")
  vim.map("e-","<Word_字号-缩小>","Word")
  vim.map("e=","<Word_字号-放大>","Word")
  vim.map("ra","<Word_设置字体底色颜色>","Word")
  vim.map("rb","<Word_设置字体底色颜色>","Word")
  vim.map("rB","<Word_设置字体底色颜色>","Word")
  vim.map("rg","<Word_设置字体底色颜色>","Word")
  vim.map("rG","<Word_设置字体底色颜色>","Word")
  vim.map("r1","<Word_设置字体底色颜色>","Word")
  vim.map("r2","<Word_设置字体底色颜色>","Word")
  vim.map("r3","<Word_设置字体底色颜色>","Word")
  vim.map("r4","<Word_设置字体底色颜色>","Word")
  vim.map("rk","<Word_设置字体底色颜色>","Word")
  vim.map("rn","<Word_设置字体底色颜色>","Word")
  vim.map("ro","<Word_设置字体底色颜色>","Word")
  vim.map("rO","<Word_设置字体底色颜色>","Word")
  vim.map("rr","<Word_设置字体底色颜色>","Word")
  vim.map("rR","<Word_设置字体底色颜色>","Word")
  vim.map("rw","<Word_设置字体底色颜色>","Word")
  vim.map("ry","<Word_设置字体底色颜色>","Word")
  vim.map("rY","<Word_设置字体底色颜色>","Word")
  vim.map("ta","<Word_设置字体底色颜色>","Word")
  vim.map("tb","<Word_设置字体底色颜色>","Word")
  vim.map("tB","<Word_设置字体底色颜色>","Word")
  vim.map("tg","<Word_设置字体底色颜色>","Word")
  vim.map("tG","<Word_设置字体底色颜色>","Word")
  vim.map("t1","<Word_设置字体底色颜色>","Word")
  vim.map("t2","<Word_设置字体底色颜色>","Word")
  vim.map("t3","<Word_设置字体底色颜色>","Word")
  vim.map("t4","<Word_设置字体底色颜色>","Word")
  vim.map("tk","<Word_设置字体底色颜色>","Word")
  vim.map("to","<Word_设置字体底色颜色>","Word")
  vim.map("tO","<Word_设置字体底色颜色>","Word")
  vim.map("tr","<Word_设置字体底色颜色>","Word")
  vim.map("tR","<Word_设置字体底色颜色>","Word")
  vim.map("tw","<Word_设置字体底色颜色>","Word")
  vim.map("ty","<Word_设置字体底色颜色>","Word")
  vim.map("tY","<Word_设置字体底色颜色>","Word")
  vim.map("fs","<Word_字体-宋体>","Word")
  vim.map("ff","<Word_字体-仿宋>","Word")
  vim.map("fy","<Word_宋体-微软雅黑>","Word")
  vim.map("fh","<Word_字体-黑体>","Word")
  vim.map("ft","<Word_字体-Times_New_Roman>","Word")
  vim.map("ps","<Word_页面设置对话框>","Word")
  vim.map(":o","<Word_打开Word文件>","Word")
  vim.map(":s","<Word_保存Word文件>","Word")
  vim.map(":S","<Word_另存Word文件>","Word")
  vim.map(":x","<Word_保存并退出Word>","Word")
  vim.map(":q","<Word_退出Word>","Word")
  ;~ vim.map(":?","<Word_VIMD显示热键帮助>","Word")
  vim.map("g1","<Word_段落行距-单倍(1)>","Word")
  vim.map("G1","<Word_段落行距-1.5倍(1.5)>","Word")
  vim.map("g2","<Word_段落行距-2倍(2)>","Word")
  vim.map("G2","<Word_段落行距-2.5倍(2.5)>","Word")
  vim.map("g3","<Word_段落行距-3倍(3)>","Word")
  vim.map("G3","<Word_段落行距-3.5倍(3.5)>","Word")
  vim.map("g4","<Word_段落行距-4倍>","Word")
  vim.map("G4","<Word_段落行距-4.5倍>","Word")
  vim.map("g5","<Word_段落行距-5倍>","Word")
  vim.map("ga","<Word_段前间距-自动>","Word")
  vim.map("g0","<Word_段前间距-0行>","Word")
  vim.map("gf","<Word_首行缩进2字符(0.35)>","Word")
  vim.map("ii","<Word_插入-图片>","Word")
  vim.map("ip","<Word_插入分页符-下一页(0)>","Word")
  vim.map("in","<Word_插入分页符-下一节(2)>","Word")
  vim.map("hh","<Word_图片-嵌入型(7)>","Word")
  vim.map("hg","<Word_图片-四周型(0)>","Word")
  vim.map("hj","<Word_图片-紧密环绕型(1)>","Word")
  vim.map("ht","<Word_图片-穿越型环绕(2)>","Word")
  vim.map("hu","<Word_图片-上下型环绕(4)>","Word")
  vim.map("hn","<Word_图片-衬于文字下方(31)>","Word")
  vim.map("hy","<Word_图片-浮于文字上方(32)>","Word")
  vim.map("H1","<Word_大纲-1级目录>","Word")
  vim.map("H2","<Word_大纲-2级目录>","Word")
  vim.map("H3","<Word_大纲-3级目录>","Word")
  vim.map("H4","<Word_大纲-4级目录>","Word")
  vim.map("H5","<Word_大纲-5级目录>","Word")
  vim.map("H6","<Word_大纲-6级目录>","Word")
  vim.map("H7","<Word_大纲-7级目录>","Word")
  vim.map("H8","<Word_大纲-8级目录>","Word")
  vim.map("H9","<Word_大纲-9级目录>","Word")
  vim.map("H0","<Word_大纲-正文>","Word")
  vim.map("H-","<Word_大纲-目录升级(正文、大纲9到1)>","Word")
  vim.map("H=","<Word_大纲-目录降级(大纲1到9、正文)>","Word")
  vim.map("pr","<Word_打印预览>","Word")
  vim.map("pm","<Word_页边距设置>","Word")
  vim.map("it","<Word_插入-表格>","Word")
  vim.map("C","<Word_复制格式>","Word")
  vim.map("b","<Word_粘贴格式>","Word")
  vim.map("j","<Word_批处理格式文档1>","Word")
  vim.map("k","<Word_批处理格式文档2>","Word")
  vim.map("l","<Word_批处理格式文档3>","Word")
  vim.map("o","<Word_临时命令>","Word")
  vim.map("m","<Word_批处理格式文档4>","Word")
  vim.map("T","<Word_定位文档开头（Ctrl+Home）>","Word")
  vim.map("B","<Word_定位文档结尾（Ctrl+End）>","Word")
  vim.map("<CapsLock>","<VIMD_清除输入键>","Revit")
  vim.map("id-","<Word_插入-日期（2017-12-31）>","Word")
  vim.map("idz","<Word_插入-日期（2017年12月31日）>","Word")
  vim.map("id.","<Word_插入-日期（2017.12.31）>","Word")
  vim.map("<a-q>","<Word_退出Word>","Word")
  
  vim.BeforeActionDo("Word_BeforeActionDo", "Word")
return
;}

Word_BeforeActionDo(){
  global vim
  ;~ global Revit_CurMode
  ;~ CurMode:=vim.GetCurMode("Revit")
  ;~ StatusBarGetText, TemStr, 1, A
  ;~ if instr(TemStr,"请输入长度"){
      ;~ Revit_CurMode:=(CurMode="数字模式") ? Revit_CurMode : CurMode
      ;~ vim.mode("数字模式","Revit")
      ;~ return False
  ;~ }
  ;~ ControlGetFocus, ctrl, A
  ;~ If RegExMatch(ctrl, "i)edit") 	;|| RegExMatch(ctrl, "i)netuihwnd2") || RegExMatch(ctrl, "i)netuihwnd4") || RegExMatch(ctrl, "i)netuihwnd5")
      ;~ Return true
  return False
}


<Word_切换到【VIM模式】>:  ;{
vim.mode("VIM模式","Word")
MsgBox, 0, 提示, 【VIM模式】, 0.3
return
;}

<Word_切换到【普通模式】>:  ;{
vim.mode("普通模式","Word")
MsgBox, 0, 提示, 【普通模式】, 0.3
return
;}

<Word_字号-初号(42)>:  ;{
Word_setFontSize(42)
return
;}

<Word_字号-小初(36)>:  ;{
Word_setFontSize(36)
return
;}

<Word_向左>:  ;{
sendinput,{left}
return
;}

<Word_向右>:  ;{
sendinput,{right}
return
;}

<Word_向上>:  ;{
sendinput,{up}
return
;}

<Word_向下>:  ;{
sendinput,{down}
return
;}

<Word_PageUp>:  ;{
Send {PgUp}
return
;}

<Word_PageDown>:  ;{
Send {PgDn}
return
;}

<Word_Home>:  ;{
sendinput,{Home}
return
;}

<Word_End>:  ;{
sendinput,{End}
return
;}

<Word_缩小10/100>:  ;{
Word_Zoom("-10")
return
;}

<Word_放大5/100>:  ;{
Word_Zoom("+5")
return
;}

<Word_字号-放大>:  ;{
Word_setFontGrow()
return
;}

<Word_字号-缩小>:  ;{
Word_setFontShrink()
return
;}

<Word_设置字号、行距、显示比例>:  ;{
Word_SetNNN()
return
;}

<Word_复制（Ctrl+C）>:  ;{
sendinput,^c
return
;}

<Word_剪贴（Ctrl+X）>:  ;{
    sendinput,^x
return
;}

<Word_粘贴（Ctrl+V）>:  ;{
sendinput,^v
return
;}

<Word_粘贴为无格式文本>:  ;{
Word_PastePlainText()
return
;}

<Word_替换>:  ;{
send,^h
return
;}

<Word_左对齐>:  ;{
Word_setAlignment("L")
return
;}

<Word_居中>:  ;{
Word_setAlignment("C")
return
;}

<Word_右对齐>:  ;{
Word_setAlignment("R")
return
;}

<Word_两端对齐>:  ;{
Word_setAlignment("J")
return
;}

<Word_分散对齐>:  ;{
Word_setAlignment("D")
return
;}

<Word_设置/取消粗体>:  ;{
Word_setBold()
return
;}

<Word_设置/取消删除线>:  ;{
Word_setStrikeThrough()
return
;}

<Word_设置/取消斜体>:  ;{
Word_setItalic()
return
;}

<Word_设置/取消下划线>:  ;{
Word_setUnderline()
return
;}

<Word_字号-一号(26)>:  ;{
Word_setFontSize(26)
return
;}

<Word_字号-小一(24)>:  ;{
Word_setFontSize(24)
return
;}

<Word_字号-二号(22)>:  ;{
Word_setFontSize(22)
return
;}

<Word_字号-小二(18)>:  ;{
Word_setFontSize(18)
return
;}

<Word_字号-三号(16)>:  ;{
Word_setFontSize(16)
return
;}

<Word_字号-小三(15)>:  ;{
Word_setFontSize(15)
return
;}

<Word_字号-四号(14)>:  ;{
Word_setFontSize(14)
return
;}

<Word_字号-小四(12)>:  ;{
Word_setFontSize(12)
return
;}

<Word_字号-五号(10)>:  ;{
Word_setFontSize(10)
return
;}

<Word_字号-小五(9)>:  ;{
Word_setFontSize(9)
return
;}

<Word_字号-六号(7)>:  ;{
Word_setFontSize(7)
return
;}

<Word_字号-小六(6)>:  ;{
Word_setFontSize(6)
return
;}

<Word_字号-七号(5)>:  ;{
Word_setFontSize(5)
return
;}

<Word_设置字体底色颜色>:  ;{
Word_setColor()
return
;}

<Word_字体-宋体>:  ;{
Word_setFontName("宋体")
return
;}

<Word_字体-仿宋>:  ;{
Word_setFontName("仿宋")
return
;}

<Word_宋体-微软雅黑>:  ;{
Word_setFontName("微软雅黑")
return
;}

<Word_字体-黑体>:  ;{
Word_setFontName("黑体")
return
;}

<Word_字体-Times_New_Roman>:  ;{
Word_setFontName("Times New Roman")
return
;}

<Word_页面设置对话框>:  ;{
Word_Dialogs_PageSetup()
return
;}

<Word_打开Word文件>:  ;{
Word_OpenFile()
return
;}

<Word_保存Word文件>:  ;{
Word_SaveFile()
return
;}

<Word_另存Word文件>:  ;{
Word_SaveFileAs()
return
;}

<Word_保存并退出Word>:  ;{
Word_SaveAndExit()
return
;}

<Word_退出Word>:  ;{
Word_CloseWord()
return
;}

<Word_段落行距-单倍(1)>:  ;{
Word_setLineSpacing(1)
return
;}

<Word_段落行距-1.5倍(1.5)>:  ;{
Word_setLineSpacing(1.5)
return
;}

<Word_段落行距-2倍(2)>:  ;{
Word_setLineSpacing(2)
return
;}

<Word_段落行距-2.5倍(2.5)>:  ;{
Word_setLineSpacing(2.5)
return
;}

<Word_段落行距-3倍(3)>:  ;{
Word_setLineSpacing(3)
return
;}

<Word_段落行距-3.5倍(3.5)>:  ;{
Word_setLineSpacing(3.5)
return
;}

<Word_段落行距-4倍>:  ;{
Word_setLineSpacing(4)
return
;}

<Word_段落行距-4.5倍>:  ;{
Word_setLineSpacing(4.5)
return
;}

<Word_段落行距-5倍>:  ;{
Word_setLineSpacing(5)
return
;}

<Word_段前间距-自动>:  ;{
Word_setParagraphs_Space("","",1)
return
;}

<Word_段前间距-0行>:  ;{
Word_setParagraphs_Space(0,0,0)
return
;}

<Word_首行缩进2字符(0.35)>:  ;{
Word_setFirstLineIndent(0.35)
return
;}

<Word_插入-图片>:  ;{
Word_Dialogs_Insert_Picture()
return
;}

<Word_插入分页符-下一页(0)>:  ;{
Word_insertBreak(0)
return
;}

<Word_插入分页符-下一节(2)>:  ;{
Word_insertBreak(2)
return
;}

<Word_图片-嵌入型(7)>:  ;{
Word_setShape_WrapFormat(7)
return
;}

<Word_图片-四周型(0)>:  ;{
Word_setShape_WrapFormat(0)
return
;}

<Word_图片-紧密环绕型(1)>:  ;{
Word_setShape_WrapFormat(1)
return
;}

<Word_图片-穿越型环绕(2)>:  ;{
Word_setShape_WrapFormat(2)
return
;}

<Word_图片-上下型环绕(4)>:  ;{
Word_setShape_WrapFormat(4)
return
;}

<Word_图片-衬于文字下方(31)>:  ;{
Word_setShape_WrapFormat(31)
return
;}

<Word_图片-浮于文字上方(32)>:  ;{
Word_setShape_WrapFormat(32)
return
;}

<Word_大纲-1级目录>:  ;{
Word_setParagraphs_Style(1)
return
;}

<Word_大纲-2级目录>:  ;{
Word_setParagraphs_Style(2)
return
;}

<Word_大纲-3级目录>:  ;{
Word_setParagraphs_Style(3)
return
;}

<Word_大纲-4级目录>:  ;{
Word_setParagraphs_Style(4)
return
;}

<Word_大纲-5级目录>:  ;{
Word_setParagraphs_Style(5)
return
;}

<Word_大纲-6级目录>:  ;{
Word_setParagraphs_Style(6)
return
;}

<Word_大纲-7级目录>:  ;{
Word_setParagraphs_Style(7)
return
;}

<Word_大纲-8级目录>:  ;{
Word_setParagraphs_Style(8)
return
;}

<Word_大纲-9级目录>:  ;{
Word_setParagraphs_Style(9)
return
;}

<Word_大纲-正文>:  ;{
Word_setParagraphs_Style(0)
return
;}

<Word_大纲-目录升级(正文、大纲9到1)>:  ;{
Word_setParagraphs_Promote()
return
;}

<Word_大纲-目录降级(大纲1到9、正文)>:  ;{
Word_setParagraphs_Demote()
return
;}

<Word_打印预览>:  ;{
Word_Dialogs_PrintPreview()
return
;}

<Word_页边距设置>:  ;{
Word_setMargin("1,1,1,1,0.5,0.5|2,2,2,2,1,1|2.5,2.5,2.5,2.5,1.5,1.5|2.54,2.54,3.17,3.17,1.5,1.75")
return
;}

<Word_插入-表格>:  ;{
Word_Dialogs_Insert_Table()
return
;}

<Word_复制格式>:  ;{
Word_CopyFormat()
return
;}

<Word_粘贴格式>:  ;{
Word_PasteFormat()
return
;}

<Word_批处理格式文档1>:  ;{
;Word_VIMD批处理使用示例
;不想设置的内容，直接在行前添加【;】，注释当前行即可
 ------------------------------------------------------------------------
;设置字号
;42=初号，36=小初，26=一号，24=小一，22=二号，18=小二,16=三号，15=小三，14=四号，12=小四，10=五号，9=小五,7=六号，6=小六，5=七号，5=八号
Word_setFontSize(22)

;设置字体
;宋体，黑体，仿宋，微软雅黑
Word_setFontName("宋体")

;设置字体、高亮颜色
;高亮颜色，ra=自动，rb=蓝色，rB=浅蓝，rg=绿色，rG=浅绿，r1=灰1，r2=灰2，r3=灰3，r4=灰4，rk=黑色，rn=无，ro=橙色，rO=浅橙，rr=红色，rR=浅红，rw=白色，ry=黄色，rY=浅黄
;Word_setColor("ry")
;字体颜色，ta=自动，tb=蓝色，tB=浅蓝，tg=绿色，tG=浅绿，t1=灰1，t2=灰2，t3=灰3，t4=灰4，tk=黑色，to=橙色，tO=浅橙，tr=红色，tR=浅红，tw=白色，ty=黄色，tY=浅黄
;Word_setColor("tr")

;设置对齐
;对齐格式，L=左对齐，C=居中，R=右对齐，J=两端对齐，D=分散对齐
Word_setAlignment("C")

;设置粗体
Word_setBold()
;设置斜体
;Word_setItalic()
;设置下划线
;Word_setUnderline()
;设置删除线
;Word_setStrikeThrough()

;设置行间距
;1,5=1.5倍行距
Word_setLineSpacing(1.5)
;设置段前段后0行，（段前行数，段后行数，1=自动|0=0行）
Word_setParagraphs_Space(0,0,0)

;设置首行缩进
;两字符=0.35
;Word_setFirstLineIndent(0.35)

;设置页边距
;(上边距，下边距，左边距，右边距，页眉边距，页脚边距）
;Word_PageSetup_Margin(1,1,1,1,0.5,0.5)

;设置纸张方面
;自动转换
;Word_PageSetup_Orientation()
return
;}

<Word_批处理格式文档2>:  ;{
;Word_VIMD批处理使用示例
;不想设置的内容，直接在行前添加【;】，注释当前行即可
 ---------------------------------------------------------------------------------------
;设置字号
;42=初号，36=小初，26=一号，24=小一，22=二号，18=小二,16=三号，15=小三，14=四号，12=小四，10=五号，9=小五,7=六号，6=小六，5=七号，5=八号
Word_setFontSize(12)

;设置字体
;宋体，黑体，仿宋，微软雅黑
Word_setFontName("宋体")

;设置字体、高亮颜色
;高亮颜色，ra=自动，rb=蓝色，rB=浅蓝，rg=绿色，rG=浅绿，r1=灰1，r2=灰2，r3=灰3，r4=灰4，rk=黑色，rn=无，ro=橙色，rO=浅橙，rr=红色，rR=浅红，rw=白色，ry=黄色，rY=浅黄
;Word_setColor("ry")
;字体颜色，ta=自动，tb=蓝色，tB=浅蓝，tg=绿色，tG=浅绿，t1=灰1，t2=灰2，t3=灰3，t4=灰4，tk=黑色，to=橙色，tO=浅橙，tr=红色，tR=浅红，tw=白色，ty=黄色，tY=浅黄
;Word_setColor("tr")

;设置对齐
;对齐格式，L=左对齐，C=居中，R=右对齐，J=两端对齐，D=分散对齐
Word_setAlignment("L")

;设置粗体
;Word_setBold()
;设置斜体
;Word_setItalic()
;设置下划线
;Word_setUnderline()
;设置删除线
;Word_setStrikeThrough()

;设置行间距
;1,5=1.5倍行距
Word_setLineSpacing(1.5)
;设置段前段后0行，（段前行数，段后行数，1=自动|0=0行）
Word_setParagraphs_Space(0,0,0)

;设置首行缩进
;两字符=0.35
Word_setFirstLineIndent(0.35)

;设置页边距
;(上边距，下边距，左边距，右边距，页眉边距，页脚边距）
;Word_PageSetup_Margin(1,1,1,1,0.5,0.5)

;设置纸张方面
;自动转换
;Word_PageSetup_Orientation()
return
;}

<Word_批处理格式文档3>:  ;{
;Word_VIMD批处理使用示例
;不想设置的内容，直接在行前添加【;】，注释当前行即可
 ---------------------------------------------------------------------------------------
;设置字号
;42=初号，36=小初，26=一号，24=小一，22=二号，18=小二,16=三号，15=小三，14=四号，12=小四，10=五号，9=小五,7=六号，6=小六，5=七号，5=八号
Word_setFontSize(10)

;设置字体
;宋体，黑体，仿宋，微软雅黑
Word_setFontName("宋体")

;设置字体、高亮颜色
;高亮颜色，ra=自动，rb=蓝色，rB=浅蓝，rg=绿色，rG=浅绿，r1=灰1，r2=灰2，r3=灰3，r4=灰4，rk=黑色，rn=无，ro=橙色，rO=浅橙，rr=红色，rR=浅红，rw=白色，ry=黄色，rY=浅黄
Word_setColor("ry")
;字体颜色，ta=自动，tb=蓝色，tB=浅蓝，tg=绿色，tG=浅绿，t1=灰1，t2=灰2，t3=灰3，t4=灰4，tk=黑色，to=橙色，tO=浅橙，tr=红色，tR=浅红，tw=白色，ty=黄色，tY=浅黄
Word_setColor("tr")

;设置对齐
;对齐格式，L=左对齐，C=居中，R=右对齐，J=两端对齐，D=分散对齐
Word_setAlignment("L")

;设置粗体
Word_setBold()
;设置斜体
Word_setItalic()
;设置下划线
Word_setUnderline()
;设置删除线
Word_setStrikeThrough()

;设置行间距
;1,5=1.5倍行距
Word_setLineSpacing(1.5)
;设置段前段后0行，（段前行数，段后行数，1=自动|0=0行）
Word_setParagraphs_Space(0,0,0)

;设置首行缩进
;两字符=0.35
Word_setFirstLineIndent(0.35)

;设置页边距
;(上边距，下边距，左边距，右边距，页眉边距，页脚边距）
Word_PageSetup_Margin(1,1,1,1,0.5,0.5)

;设置纸张方面
;自动转换
Word_PageSetup_Orientation()
return
;}

<Word_临时命令>:  ;{

return
;}

<Word_批处理格式文档4>:  ;{
;Word_VIMD批处理使用示例
;不想设置的内容，直接在行前添加【;】，注释当前行即可
--------------------------------------------------------------------------
;设置字号
;42=初号，36=小初，26=一号，24=小一，22=二号，18=小二,16=三号，15=小三，14=四号，12=小四，10=五号，9=小五,7=六号，6=小六，5=七号，5=八号
Word_setFontSize(10)

;设置字体
;宋体，黑体，仿宋，微软雅黑
Word_setFontName("宋体")

;设置字体、高亮颜色
;高亮颜色，ra=自动，rb=蓝色，rB=浅蓝，rg=绿色，rG=浅绿，r1=灰1，r2=灰2，r3=灰3，r4=灰4，rk=黑色，rn=无，ro=橙色，rO=浅橙，rr=红色，rR=浅红，rw=白色，ry=黄色，rY=浅黄
Word_setColor("ry")
;字体颜色，ta=自动，tb=蓝色，tB=浅蓝，tg=绿色，tG=浅绿，t1=灰1，t2=灰2，t3=灰3，t4=灰4，tk=黑色，to=橙色，tO=浅橙，tr=红色，tR=浅红，tw=白色，ty=黄色，tY=浅黄
Word_setColor("tr")

;设置对齐
;对齐格式，L=左对齐，C=居中，R=右对齐，J=两端对齐，D=分散对齐
Word_setAlignment("L")

;设置粗体
Word_setBold()
;设置斜体
Word_setItalic()
;设置下划线
Word_setUnderline()
;设置删除线
Word_setStrikeThrough()

;设置行间距
;1,5=1.5倍行距
Word_setLineSpacing(1.5)
;设置段前段后0行，（段前行数，段后行数，1=自动|0=0行）
Word_setParagraphs_Space(0,0,0)

;设置首行缩进
;两字符=0.35
Word_setFirstLineIndent(0.35)

;设置页边距
;(上边距，下边距，左边距，右边距，页眉边距，页脚边距）
Word_PageSetup_Margin(1,1,1,1,0.5,0.5)

;设置纸张方面
;自动转换
Word_PageSetup_Orientation()
return
;}

<Word_定位文档开头（Ctrl+Home）>:  ;{
send,^{home}
return
;}

<Word_定位文档结尾（Ctrl+End）>:  ;{
send,^{end}
return
;}

<Word_插入-日期（2017-12-31）>:  ;{
Word_Insert_Date("-")
return
;}

<Word_插入-日期（2017年12月31日）>:  ;{
Word_Insert_Date("z")
return
;}

<Word_插入-日期（2017.12.31）>:  ;{
Word_Insert_Date(".")
return
;}

/*  Word_VIMD批处理使用示例
;Word_VIMD批处理使用示例
;不想设置的内容，直接在行前添加【;】，注释当前行即可
 ---------------------------------------------------------------------------------------
;设置字号
;42=初号，36=小初，26=一号，24=小一，22=二号，18=小二,16=三号，15=小三，14=四号，12=小四，10=五号，9=小五,7=六号，6=小六，5=七号，5=八号
Word_setFontSize(10)

;设置字体
;宋体，黑体，仿宋，微软雅黑
Word_setFontName("宋体")

;设置字体、高亮颜色
;高亮颜色，ra=自动，rb=蓝色，rB=浅蓝，rg=绿色，rG=浅绿，r1=灰1，r2=灰2，r3=灰3，r4=灰4，rk=黑色，rn=无，ro=橙色，rO=浅橙，rr=红色，rR=浅红，rw=白色，ry=黄色，rY=浅黄
Word_setColor("ry")
;字体颜色，ta=自动，tb=蓝色，tB=浅蓝，tg=绿色，tG=浅绿，t1=灰1，t2=灰2，t3=灰3，t4=灰4，tk=黑色，to=橙色，tO=浅橙，tr=红色，tR=浅红，tw=白色，ty=黄色，tY=浅黄
Word_setColor("tr")

;设置对齐
;对齐格式，L=左对齐，C=居中，R=右对齐，J=两端对齐，D=分散对齐
Word_setAlignment("L")

;设置粗体
Word_setBold()
;设置斜体
Word_setItalic()
;设置下划线
Word_setUnderline()
;设置删除线
Word_setStrikeThrough()

;设置行间距
;1,5=1.5倍行距
Word_setLineSpacing(1.5)
;设置段前段后0行，（段前行数，段后行数，1=自动|0=0行）
Word_setParagraphs_Space(0,0,0)

;设置首行缩进
;两字符=0.35
Word_setFirstLineIndent(0.35)

;设置页边距
;(上边距，下边距，左边距，右边距，页眉边距，页脚边距）
Word_PageSetup_Margin(1,1,1,1,0.5,0.5)

;设置纸张方面
;自动转换
Word_PageSetup_Orientation()

*/

;===================================================================
/*
    函数:  Word_Get
    作用: 返回word对象
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_Get() {
	global word
	word:=ComObjActive("Word.Application")
	return
}

/*
    函数:  Word_Destroy
    作用: 摧毁word对象
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_Destroy(){
	global word
	word:=
}

/*
    函数:  Word_OpenFile
    作用:  打开对话框
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_OpenFile(){
	sendinput,^o
}

/*
    函数:  Word_PasteFormat
    作用:  粘贴格式
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_PasteFormat(){
	send,^+v
}

/*
    函数:  Word_CopyFormat
    作用:  复制格式
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_CopyFormat(){
	send,^+c
}

/*
    函数:  Word_SaveFile
    作用:  保存
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_SaveFile(){
	sendinput,^s
}

/*
    函数:  Word_SaveFileAs
    作用:  另存为
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_SaveFileAs(){
	sendinput,^+s
}

/*
    函数:  Word_CloseWord
    作用:  关闭
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_CloseWord(){
	global word
	Word_Get()
	try
		word.ActiveDocument.Close
	Word_Destroy()
}

/*
    函数:  Word_SaveAndExit
    作用:  保存退出
    参数: 
    返回: 
    作者:  Kawvin
    版本:  0.1
	wdDialogFileSummaryInfo:=86
*/
Word_SaveAndExit(){
	global word
	Word_Get()
	Word_Dialogs(86)
	if !(word.ActiveDocument.Saved)
		send,^s
	word.ActiveDocument.Close
	Word_Destroy()
}

/*
    函数:  Word_setFontSize
    作用: 设置字号
    参数: fSize
			42=初号，36=小初，26=一号，24=小一，22=二号，18=小二
			16=三号，15=小三，14=四号，12=小四，10=五号，9=小五
			7=六号，6=小六，5=七号，5=八号
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setFontSize(fSize:=10){
	if (fSize="")
		return
	global word
	Word_Get()
	try
		word.selection.font.size:=fSize
	Word_Destroy()
}

/*
    函数:  Word_setFontGrow
    作用: 设置字号加大
    参数:
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setFontGrow(){
	global word
	Word_Get()
	try
		word.selection.font.Grow
	Word_Destroy()
}

/*
    函数:  Word_setFontShrink
    作用: 设置字号减小
    参数:
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setFontShrink(){
	global word
	Word_Get()
	try
		word.selection.font.Shrink
	Word_Destroy()
}

Word_setColorMenu(){
	QuickInputList=
	(Ltrim
		&r)文字-红色
		&g)文字-绿色
		&b)文字-蓝色
		-
		&1)底色-红色
		&2)底色-绿色
		&3)底色-蓝色
	)

	menu,KyMenu_QuickInput,Add
	menu,KyMenu_QuickInput,DeleteAll
	Loop,parse,QuickInputList,`n,`r
	{
		if (A_LoopField="")
			continue
		if (A_LoopField="-")
			menu,KyMenu_QuickInput,Add
		else
			menu,KyMenu_QuickInput,Add,% A_LoopField,KyMenu_QuickInput_Handler2
	}
	menu,KyMenu_QuickInput,show
	return
	
	KyMenu_QuickInput_Handler2:
		outputStr:=substr(A_ThisMenuItem,2,1)
		if RegExMatch(outputStr,"i)[a-z]")
			outputStr:="t" . outputStr
		if RegExMatch(outputStr,"i)[0-9]")
			outputStr:="r" . outputStr
		Word_setColor(outputStr)
	return
}

/*
    函数:  Word_setFontColor
    作用: 设置字体颜色
    参数: fMyColor,如果为空，则自动获取热键值，否则设置
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setColor(fMyColor:=""){
	global VimD
	global word
	Word_Get()
	if (fMyColor=""){
		MyType:=substr(VimD.HotKeyStr,1,1)
		MyIndex:=substr(VimD.HotKeyStr,2)
	} else {
		MyType:=substr(fMyColor,1,1)
		MyIndex:=substr(fMyColor,2)
	}
	if ((MyIndex+0)>0)
		MyIndex=g%MyIndex%
	;红色=6，蓝色=2，黄色=7，绿色=4，橙色=14，灰1=16，灰2=16，灰3=15，灰4=9，白色=8，黑色=1，自动=0，无=0
	;浅红=5，浅蓝=3，浅黄=14，浅绿=11，浅橙=
	MyHighColorArray1:={"r":6,"b":2,"y":7,"g":4,"o":14,"g1":16,"g2":16,"g3":15,"g4":9,"w":8,"k":1,"a":0,"n":0}
	MyHighColorArray2:={"R":5,"B":3,"Y":14,"G":11,"O":14}
	if (MyType="r")		;高亮颜色
	{
		if RegExMatch(MyIndex,"^[a-z0-9]+$")
			MyValue:=MyHighColorArray1[MyIndex]
		else
			MyValue:=MyHighColorArray2[MyIndex]
		try
			word.Options.DefaultHighlightColorIndex:=MyValue
			word.selection.Range.HighlightColorIndex:=MyValue
	}
	;红色=255，蓝色=16711680，黄色=65535，绿色=32768，橙色=26367，灰1=142770819，灰2=12632256，灰3=8421504，灰4=2500134，白色=16777215，黑色=0，自动=-16777216，无=0
	;浅红=8420607，浅蓝=16737843，浅黄=10092543，浅绿=13434828，浅橙=39423
	MyFontColorArray1:={"r":255,"b":16711680,"y":65535,"g":32768,"o":26367,"g1":142770819,"g2":12632256,"g3":8421504,"g4":2500134,"w":16777215,"k":0,"a":-16777216,"n":0}
	MyFontColorArray2:={"R":8420607,"B":16737843,"Y":10092543,"G":13434828,"O":39423}
	if (MyType="t")		;字体颜色
	{
		if RegExMatch(MyIndex,"^[a-z0-9]+$")
			MyValue:=MyFontColorArray1[MyIndex]
		else
			MyValue:=MyFontColorArray2[MyIndex]
		try
			word.selection.Font.Color:=MyValue
	}
	Word_Destroy()
}

/*
    函数:  Word_setAlignment
    作用: 设置对齐
    参数: fAlignment	L=Left，C=Center，R=Right，J=Justify，D=Distribute
		;枚举常量类型：WdParagraphAlignment
		wdAlignParagraphCenter:=1
		wdAlignParagraphDistribute:=4
		wdAlignParagraphJustify:=3
		wdAlignParagraphJustifyHi:=7
		wdAlignParagraphJustifyLow:=8
		wdAlignParagraphJustifyMed:=5
		wdAlignParagraphLeft:=0
		wdAlignParagraphRight:=2
		wdAlignParagraphThaiJustify:=9
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setAlignment(fAlignment:="L"){
	if (fAlignment="")
		return
	global word
	Word_Get()
	aArray:={"L":0,"C":1,"R":2,"J":3,"D":4}
	try
		word.Selection.ParagraphFormat.Alignment :=aArray[fAlignment]
	Word_Destroy()
}

/*
    函数:  Word_setBold
    作用: 设置粗体
    参数: wdToggle:=9999998
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setBold(){
	global word
	Word_Get()
	try
		word.selection.font.Bold:=9999998
	Word_Destroy()
}

/*
    函数:  Word_setItalic
    作用: 设置斜体
    参数: wdToggle:=9999998
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setItalic(){
	global word
	Word_Get()
	try
		word.selection.font.Italic:=9999998
	Word_Destroy()
}

/*
    函数:  Word_setUnderline
    作用: 设置下划线
    参数:
			;枚举常量类型：WdUnderline
			wdUnderlineDash:=7
			wdUnderlineDashHeavy:=23
			wdUnderlineDashLong:=39
			wdUnderlineDashLongHeavy:=55
			wdUnderlineDotDash:=9
			wdUnderlineDotDashHeavy:=25
			wdUnderlineDotDotDash:=10
			wdUnderlineDotDotDashHeavy:=26
			wdUnderlineDotted:=4
			wdUnderlineDottedHeavy:=20
			wdUnderlineDouble:=3
			wdUnderlineNone:=0
			wdUnderlineSingle:=1
			wdUnderlineThick:=6
			wdUnderlineWavy:=11
			wdUnderlineWavyDouble:=43
			wdUnderlineWavyHeavy:=27
			wdUnderlineWords:=2
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setUnderline(){
	global word
	Word_Get()
	try
	{
		if (word.selection.font.Underline<>0)
			word.selection.font.Underline:=0
		else
			word.selection.font.Underline:=1
	}
	Word_Destroy()
}

/*
    函数:  Word_setStrikeThrough
    作用: 设置删除线
    参数: wdToggle:=9999998
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setStrikeThrough(){
	global word
	Word_Get()
	try
		word.selection.font.StrikeThrough:=9999998
	Word_Destroy()
}

/*
    函数:  Word_setLineSpacing
    作用: 设置行距
    参数: fLineSpacing
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setLineSpacing(fLineSpacing:=1){
	if (fLineSpacing="")
		return
	global word
	Word_Get()
	fLinesPoints:=fLineSpacing*12
	try
		word.selection.ParagraphFormat.LineSpacing:=fLinesPoints
	Word_Destroy()
}

/*
    函数:  Word_setFirstLineIndent
    作用: 设置首行缩进
    参数: fFirstLineIndent	，0.35=2字符
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setFirstLineIndent(fFirstLineIndent:=0.35){
	if (fFirstLineIndent="")
		return
	global word
	Word_Get()
	try
		word.Selection.ParagraphFormat.FirstLineIndent := CentimetersToPoints(fFirstLineIndent)
	Word_Destroy()
}

/*
    函数:  Word_insertBreak(fType)
    作用: 插入分隔符
    参数: fType，分隔符类型
    返回:
    作者:  Kawvin
    版本:  0.1
	wdSectionBreakNextPage:=2
	wdPageBreak:=7	分页符，Ctrl+Return
	0	分页符，Ctrl+Enter
*/
Word_insertBreak(fType:=0){
	if (fType="")
		return
	global word
	Word_Get()
	try
		word.Selection.InsertBreak(fType)
	Word_Destroy()
}

/*
    函数:  Word_setFontName
    作用: 设置字体
    参数: fFontName
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setFontName(fFontName:="宋体"){
	if (fFontName="")
		return
	global word
	Word_Get()
	try
		word.Selection.Font.Name :=fFontName
	Word_Destroy()
}

/*
    函数:  Word_Zoom
    作用: 比例设置
    参数: +n，比例增加n
			 -n，比例减少n
			 n，设置比例为n
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_Zoom(fZoom:="-5"){
	if (fZoom="")
		return
	global word
	Word_Get()
	if (regexmatch(fZoom,"\+[0-9]+")) {		;放大
		ZoomNum:=substr(fZoom,2)
		try
			word.ActiveWindow.ActivePane.View.Zoom.Percentage+=ZoomNum
	}else if (regexmatch(fZoom,"\-[0-9]+")) {	;缩小
		ZoomNum:=substr(fZoom,2)
		try
			word.ActiveWindow.ActivePane.View.Zoom.Percentage-=ZoomNum
	}else if (regexmatch(fZoom,"[0-9]+")) {		;设置比例 		
		ZoomNum:=substr(fZoom,1)
		if(ZoomNum<10)
			ZoomNum:=10
		if(ZoomNum>500)
			ZoomNum:=500
		try
			word.ActiveWindow.ActivePane.View.Zoom.Percentage:=ZoomNum
	}else {
		try
			word.ActiveWindow.ActivePane.View.Zoom.Percentage-=5
	}
	Word_Destroy()
}

/*
    函数:  Word_PastePlainText
    作用: 粘贴为无格式文本
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
	wdFormatPlainText:=22
*/
Word_PastePlainText(){
	global word
	Word_Get()
	try
		word.Selection.PasteAndFormat(22)
	Word_Destroy()
}

/*
    函数:  Word_SetNNN
    作用: 各类设置
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_SetNNN(){
	prompt=
	(LTrim
	调整行高/列宽/字号，输入格式：
	1)设置字号为n，命令格式：f20
	2)设置行距为n，命令格式：l2
	3)设置显示比例为n，命令格式：z80
	)
	InputBox,cmd_Buff,请输入命令,%prompt%, , 300,200   ;``
	if ErrorLevel
		return
	if (cmd_Buff="")
		return

	if RegExMatch(cmd_Buff,"i)f(\d)+")		;设置字号
	{
		buff_string := substr(cmd_buff, 2)
		Word_setFontSize(buff_string)
	} else if RegExMatch(cmd_Buff,"i)l(\d)+")  {
		buff_string := substr(cmd_buff, 2)
		Word_setLineSpacing(buff_string)
	} else if RegExMatch(cmd_Buff,"i)z(\d)+")  {
		buff_string := substr(cmd_buff, 2)
		Word_Zoom(buff_string)
	} else   {
		
	} 
}

/*
    函数:  Word_Dialogs
    作用: 显示对话框
    参数: fDig，对话框常数
    返回:
    作者:  Kawvin
    版本:  0.1
	wdDialogFilePrintSetup:=97
	wdDialogFilePageSetup:=178
	wdDialogFileSummaryInfo:=86
	wdDialogInsertPicture:=163
	wdDialogFilePrint:=88
	wdDialogTableInsertTable:=129


*/
Word_Dialogs(fDig){
	if (fDig="")
		return
	global word
	Word_Get()
	try
		word.Dialogs(fDig).show
	;Word_Destroy()
}

/*
    函数:  Word_Dialogs_Insert_Picture
    作用: 插入图片对话框
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_Dialogs_Insert_Picture(){
	global word
	Word_Dialogs(163)
	Word_Destroy()
}

/*
    函数:  Word_Dialogs_Insert_Table
    作用: 插入表格对话框
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_Dialogs_Insert_Table(){
	global word
	Word_Dialogs(129)
	Word_Destroy()
}

/*
    函数:  Word_Dialogs_PageSetup
    作用: 页面设置对话框
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_Dialogs_PageSetup(){
	global word
	Word_Dialogs(178)
	Word_Destroy()
}

/*
    函数:  Word_Dialogs_PrintPreview
    作用: 打印对话框
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_Dialogs_PrintPreview(){
	send,^p
}
	
/*
    函数:  Word_setShape_WrapFormat
    作用: 设置图片环绕方式
    参数: fWrapType		0=四周型,1=紧密型,2=穿越型环绕,31=衬于文字下方,32=浮于文字上方,4=上下型环绕,7=嵌入型
    返回:
    作者:  Kawvin
    版本:  0.1
	;枚举常量类型：WdWrapType
	wdWrapSquare:=0				四周型
	wdWrapTight:=1				紧密环绕型
	wdWrapThrough:=2			穿越型环绕
	wdWrapNone:=3				文字下方或文字上方
	wdWrapTopBottom:=4		上下型环绕
	wdWrapInline:=7				嵌入型
	
	wdSelectionInlineShape:=7
	wdSelectionShape:=8
*/
Word_setShape_WrapFormat(fWrapType:=7){
	if (fWrapType="")
		return
	global word
	Word_Get()
	if (word.Selection.type=7) {
		SelPic:=word.Selection.InlineShapes(1)
		if (fWrapType=0)||(fWrapType=1)||(fWrapType=2)||(fWrapType=31)||(fWrapType=32)
			SelPic:=SelPic.ConvertToShape()			;类型转换
		if (fWrapType=0)||(fWrapType=1)||(fWrapType=2)||(fWrapType=4)||(fWrapType=7) {
			try
				SelPic.WrapFormat.Type := fWrapType
		} else if (fWrapType=31) {
			try {
				SelPic.WrapFormat.Type :=3
				SelPic.ZOrder(5)			;图片衬于文字下方
			}
		} else if (fWrapType=32) {
			try {
				SelPic.WrapFormat.Type :=3
				SelPic.ZOrder(4)			;图片浮于文字上方
			}
		}
		Word_Destroy()
		return
	}
	if (word.Selection.type=8)  {
		SelPic:=word.Selection.ShapeRange(1)
		if (fWrapType=7)
			SelPic:=SelPic.ConvertToInlineShape()				;类型转换
		if (fWrapType=0)||(fWrapType=1)||(fWrapType=2)||(fWrapType=4)||(fWrapType=7) {
			try
				SelPic.WrapFormat.Type := fWrapType
		} else if (fWrapType=31) {
			try {
				SelPic.WrapFormat.Type :=3
				SelPic.ZOrder(5)			;图片衬于文字下方
			}
		} else if (fWrapType=32) {
			try {
				SelPic.WrapFormat.Type :=3
				SelPic.ZOrder(4)			;图片浮于文字上方
			}
		}
		Word_Destroy()
		return
	}
	Word_Destroy()
}

/*
    函数:  Word_setParagraphs_Style
    作用: 设置大纲级别
    参数: fStyle		0=正文，1=1级，...9=9级
    返回:
    作者:  Kawvin
    版本:  0.1
	wdStyleNormal:=-1
	wdStyleHeading1:=-2
	wdStyleHeading2:=-3
	wdStyleHeading3:=-4
	wdStyleHeading4:=-5
	wdStyleHeading5:=-6
	wdStyleHeading6:=-7
	wdStyleHeading7:=-8
	wdStyleHeading8:=-9
	wdStyleHeading9:=-10
*/
Word_setParagraphs_Style(fStyle:=0){
	if (fStyle="")
		return
	global word
	Word_Get()
	try
		word.Selection.Range.Style := word.ActiveDocument.Styles(0-fStyle-1)
	Word_Destroy()
}

/*
    函数:  Word_setParagraphs_Space
    作用: 设置段落段前、段后间距
    参数: fBefroe，段前行数，fAfter，段后行数，fAuto，自动行距(1,0)
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setParagraphs_Space(fBefroe:="",fAfter:="",fAuto:=""){
	global word
	Word_Get()
	if(fBefroe!="")
		try
			word.Selection.ParagraphFormat.SpaceBefore :=fBefroe
	if(fAfter!="")
		try
			word.Selection.ParagraphFormat.SpaceAfter :=fAfter
	if(fAuto=1){
		try{
			word.Selection.ParagraphFormat.SpaceBeforeAuto := True
			word.Selection.ParagraphFormat.SpaceAfterAuto := True
		}
	}else{
		try{
			word.Selection.ParagraphFormat.SpaceBeforeAuto := False
			word.Selection.ParagraphFormat.SpaceAfterAuto := false
		}
	}
	Word_Destroy()
}

/*
    函数:  Word_setParagraphs_Promote
    作用: 设置大纲级别-升级
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setParagraphs_Promote(){
	global word
	Word_Get()
	try
		word.Selection.Paragraphs.OutlinePromote
	Word_Destroy()
}

/*
    函数:  Word_setParagraphs_Demote
    作用: 设置大纲级别-降级
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_setParagraphs_Demote(){
	global word
	Word_Get()
	try
		word.Selection.Paragraphs.OutlineDemote
	Word_Destroy()
}

/*
    函数:  Word_PageSetup_Orientation
    作用: 设置页面方向
    参数: 
    返回:
    作者:  Kawvin
    版本:  0.1
	;枚举常量类型：WdOrientation
	wdOrientLandscape:=1
	wdOrientPortrait:=0
*/
Word_PageSetup_Orientation(){
	global word
	Word_Get()
	try
		word.Selection.PageSetup.Orientation:=!word.Selection.PageSetup.Orientation
	Word_Destroy()
}

/*
    函数:  Word_setMargin
    作用: 获取数据
    参数: fMargins
    返回:
    作者:  Kawvin
    版本:  0.1
	使用方法：Word_setMargin("1,1,1,1,0.5,0.5|2,2,2,2,1.5,1.5|3.17,3.17,2.54,2.54,1.5,1.75")
*/
Word_setMargin(fMargins){
	global MyDocLM,MyDocRM,MyDocTM,MyDocBM,MyDocHD,MyDocFD
	MyDocLM:=0,MyDocRM:=0,MyDocTM:=0,MyDocBM:=0,MyDocHD:=0,MyDocFD:=0
	GUI DocMargin:Destroy
	GUI DocMargin: -DPIScale
	GUI DocMargin:Default
	Gui DocMargin:Font, s12
	Gui DocMargin:Add, GroupBox, x12 y2 w542 h225, 页边距
	Gui DocMargin:Add, ListView, x22 y27 w521 h189 AltSubmit Grid gMyDocMarginsList, 上边距|下边距|左边距|右边距|页眉边距|页脚边距
	Gui DocMargin:Add, Text, x15 y235 w70 h29 +0x200, 上边距
	Gui DocMargin:Add, Text, x15 y275 w70 h29 +0x200, 下边距
	Gui DocMargin:Add, Text, x210 y235 w70 h29 +0x200, 左边距
	Gui DocMargin:Add, Text, x210 y275 w70 h29 +0x200, 右边距
	Gui DocMargin:Add, Text, x390 y235 w85 h29 +0x200, 页眉边距
	Gui DocMargin:Add, Text, x390 y275 w85 h29 +0x200, 页脚边距
	loop,Parse,fMargins,`|
	{
		if strlen(trim(A_LoopField))
			DocMArray:=StrSplit(A_LoopField,",")
		else
			continue
		if (A_index=1)
			MyDocTM:=DocMArray[1],MyDocBM:=DocMArray[2],MyDocLM:=DocMArray[3],MyDocRM:=DocMArray[4],MyDocHD:=DocMArray[5],MyDocFD:=DocMArray[6]
		LV_Add("",DocMArray[1],DocMArray[2],DocMArray[3],DocMArray[4],DocMArray[5],DocMArray[6])
	}
	LV_ModifyCol(1," center")
	LV_ModifyCol(2," center")
	LV_ModifyCol(3," center")
	LV_ModifyCol(4," center")
	LV_ModifyCol(5," center")
	LV_ModifyCol(6," center")
	Gui DocMargin:Add, Edit, x90 y233 w70 h31 center  vMyDocTM,%MyDocTM%
	Gui DocMargin:Add, Edit, x90 y273 w70 h31 center  vMyDocBM,%MyDocBM%
	Gui DocMargin:Add, Edit, x280 y233 w70 h31 center  vMyDocLM,%MyDocLM%
	Gui DocMargin:Add, Edit, x280 y273 w70 h31 center  vMyDocRM,%MyDocRM%
	Gui DocMargin:Add, Edit, x480 y233 w70 h31 center  vMyDocHD,%MyDocHD%
	Gui DocMargin:Add, Edit, x480 y273 w70 h31 center  vMyDocFD,%MyDocFD%
	Gui DocMargin:Add, Button, x120 y325 w100 h40 Default gMyDocMarginsOK, 确定
	Gui DocMargin:Add, Button, x350 y325 w100 h40 gMyDocMarginsCancel, 取消
	Gui DocMargin:Add, Text, x30 y375  h29 +0x200, 单击选中修改，双击直接设置
	Gui DocMargin:Font
	Gui DocMargin:Show, w570 h410, 页边距设置
	Return
	
	MyDocMarginsOK:
		GUI DocMargin:Default
		guicontrolget,MyDocTM,,MyDocTM
		guicontrolget,MyDocBM,,MyDocBM
		guicontrolget,MyDocLM,,MyDocLM
		guicontrolget,MyDocRM,,MyDocRM
		guicontrolget,MyDocHD,,MyDocHD
		guicontrolget,MyDocFD,,MyDocFD
		Word_PageSetup_Margin(MyDocTM,MyDocBM,MyDocLM,MyDocRM,MyDocHD,MyDocFD)
		GUI DocMargin:Destroy
	return
	
	MyDocMarginsCancel:
		GUI DocMargin:Destroy
	return
	
	MyDocMarginsList:
		GUI DocMargin:Default
		LV_GetText(MyDocTM, A_EventInfo,1) 
		LV_GetText(MyDocBM, A_EventInfo,2) 
		LV_GetText(MyDocLM, A_EventInfo,3) 
		LV_GetText(MyDocRM, A_EventInfo,4) 
		LV_GetText(MyDocHD, A_EventInfo,5) 
		LV_GetText(MyDocFD, A_EventInfo,6) 
		if A_GuiEvent = DoubleClick
		{
			Word_PageSetup_Margin(MyDocTM,MyDocBM,MyDocLM,MyDocRM,MyDocHD,MyDocFD)
			GUI DocMargin:Destroy
		}
		if A_GuiEvent = normal
		{
			guicontrol,,MyDocTM,%MyDocTM%
			guicontrol,,MyDocBM,%MyDocBM%
			guicontrol,,MyDocLM,%MyDocLM%
			guicontrol,,MyDocRM,%MyDocRM%
			guicontrol,,MyDocHD,%MyDocHD%
			guicontrol,,MyDocFD,%MyDocFD%
		}
	return
}

/*
    函数:  Word_PageSetup_Margin
    作用: 设置页面边距，页眉、页脚边距
    参数: fTM,fBM,fLM,fRM，上，下，左，右边距，fHD，设置页眉边距，fFD，设置页脚边距
    返回:
    作者:  Kawvin
    版本:  0.1
*/
Word_PageSetup_Margin(fTM:="",fBM:="",fLM:="",fRM:="",fHD:="",fFD:=""){
	global word
	Word_Get()
	;~ msgbox % CentimetersToPoints(fTM)
	;~ return
	if(fTM!="")
		try
			word.Selection.PageSetup.TopMargin:=fTM*28.3527	;CentimetersToPoints(fTM)
	if(fBM!="")
		try
			word.Selection.PageSetup.BottomMargin:=fBM*28.3527	;CentimetersToPoints(fBM)
	if(fLM!="")
		try
			word.Selection.PageSetup.LeftMargin:=fLM*28.3527	;CentimetersToPoints(fLM)
	if(fRM!="")
		try
			word.Selection.PageSetup.RightMargin:=fRM*28.3527	;CentimetersToPoints(fRM)
	if(fHD!="")
		try
			word.Selection.PageSetup.HeaderDistance:=fHD*28.3527	;CentimetersToPoints(fHD)
	if(fFD!="")
		try
			word.Selection.PageSetup.FooterDistance:=fFD*28.3527	;CentimetersToPoints(fFD)
	Word_Destroy()
}

/*
    函数:  CentimetersToPoints
    作用: 厘米转换为磅
    参数: fcm
    返回:
    作者:  Kawvin
    版本:  0.1
	1磅=1/72英寸=2.54/72厘米=0.03528厘米=0.3528毫米，1厘米=28.3527磅
*/
CentimetersToPoints(fcm){
	fPoints:=0
	if(fcm/1>0)
		fPoints:=fcm*28.3527
	return fPoints
}

/*
    函数:  Word_Format_Date
    作用: 日期格式
    参数: fSplit，z=20171231，/=2017/12/31，z=2017年12月31日，-=2017-12-31，.=2017.12.31
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_Format_Date(fSplit:="z"){
	StrDate:=""
	if(fSplit="d")
		StrDate=%A_YYYY%%A_MM%%A_DD%
	if(fSplit="/")
		StrDate=%A_YYYY%/%A_MM%/%A_DD%
	if(fSplit="z")
		StrDate=%A_YYYY%年%A_MM%月%A_DD%日
	if(fSplit="-")
		StrDate=%A_YYYY%-%A_MM%-%A_DD%
	if(fSplit=".")
		StrDate=%A_YYYY%.%A_MM%.%A_DD%
	return	StrDate
}

/*
    函数:  Word_Insert_Date
    作用: 日期格式
    参数: fSplit，z=20171231，/=2017/12/31，z=2017年12月31日，-=2017-12-31，.=2017.12.31
    返回: 
    作者:  Kawvin
    版本:  0.1
*/
Word_Insert_Date(fSplit:="z"){
	global word
	Word_Get() 
	if(fSplit="d")
		word.Selection.InsertDateTime(DateTimeFormat:="yyyyMMdd")
	if(fSplit="/")
		word.Selection.InsertDateTime(DateTimeFormat:="yyyy'/'MM'/'dd")
	if(fSplit="z")
		word.Selection.InsertDateTime(DateTimeFormat:="yyyy'年'M'月'd'日'")
	if(fSplit="-")
		word.Selection.InsertDateTime(DateTimeFormat:="yyyy'-'MM'-'dd")
	if(fSplit=".")
		word.Selection.InsertDateTime(DateTimeFormat:="yyyy'.'MM'.'dd")
	Word_Destroy()
}