Excel: 
    vim.setwin("Excel","XLMAIN","excel.exe")
    vim.SetTimeOut(300,"Excel")

    vim.mode("普通模式","Excel")
    vim.map("<insert>","<Excel_切换到【VIM模式】>","Excel")
    
    vim.mode("VIM模式","Excel")
    vim.map("<esc>","<Excel_切换到【普通模式】>","Excel")
    vim.map("i","<Excel_单元格-编辑-在头部输入>","Excel")
    vim.map("I","<Excel_单元格-编辑-在尾部输入>","Excel")
    
    vim.map("x","<Excel_剪贴（Ctrl+X）>","Excel")
    vim.map("hn","<Excel_行-插入行-当前单元格下方>","Excel")
    vim.map("hy","<Excel_行-插入行-当前单元格上方>","Excel")
    vim.map("hj","<Excel_列-插入列-当前单元格右侧>","Excel")
    vim.map("hg","<Excel_列-插入列-当前单元格左侧>","Excel")
    vim.map("R","<Excel_替换（Ctrl+H）>","Excel")
    
    vim.map("*s","<Excel_单元格-编辑-替换输入>","Excel")
    ;~ vim.map("---n","<Excel_其他-查找下一项>","Excel")
    ;~ vim.map("---N","<Excel_其他-查找上一项>","Excel")
    ;~ vim.map("---yu","<Excel_单元格-填充-以上方单元格值>","Excel")
    ;~ vim.map("---yd","<Excel_单元格-填充-以下方单元格值>","Excel")
    ;~ vim.map("---yr","<Excel_单元格-填充-以右侧单元格值>","Excel")
    ;~ vim.map("---yl","<Excel_单元格-填充-以左侧单元格值>","Excel")
    ;~ vim.map("---P","<Excel_剪切板-选择性粘贴>","Excel")
    ;~ vim.map("---q","<Excel_列-列宽减小>","Excel")
    ;~ vim.map("---Q","<Excel_列-列宽增加>","Excel")
    ;~ vim.map("---r","<Excel_其他-重复命令>","Excel")
    
    vim.map("v","<Excel_粘贴（Ctrl+V）>","Excel")
    vim.map("V","<Excel_剪贴板-粘贴为数值>","Excel")
    vim.map("[","<Excel_其他-调整所选行高h-列宽w-字号f>","Excel")
    vim.map("qy","<Excel_行-自动行高>","Excel")
    vim.map("qh","<Excel_列-自动列宽>","Excel")
   
    vim.map("bH","<Excel_格式-边框-内部水平方向-点线>","Excel")
    vim.map("bh","<Excel_格式-边框-内部水平方向-实线>","Excel")
    vim.map("bV","<Excel_格式-边框-内部垂直方向-点线>","Excel")
    vim.map("bv","<Excel_格式-边框-内部垂直方向-实线>","Excel")
    vim.map("be","<Excel_格式-边框-四周实线>","Excel")
    vim.map("bE","<Excel_格式-边框-四周粗实线>","Excel")
    vim.map("b=","<Excel_格式-边框-四周双线>","Excel")
    vim.map("bn","<Excel_格式-边框-全部无边框>","Excel")
    vim.map("q1","<Excel_格式-对齐-水平-左对齐>","Excel")
    vim.map("q2","<Excel_格式-对齐-水平-居中>","Excel")
    vim.map("q3","<Excel_格式-对齐-水平-右对齐>","Excel")
    vim.map("q4","<Excel_格式-对齐-水平-跨列对齐>","Excel")
    vim.map("q5","<Excel_缩进对齐-增加>","Excel")
    vim.map("q6","<Excel_格式-缩进对齐-取消>","Excel")
    vim.map("q7","<Excel_格式-对齐-垂直-靠上>","Excel")
    vim.map("q8","<Excel_格式-对齐-垂直-居中>","Excel")
    vim.map("q9","<Excel_格式-对齐-垂直-靠下>","Excel")
    ;~ vim.map("<LT>","<Excel_格式-字号变小>","Excel")
    ;~ vim.map("<RT>","<Excel_格式-字号变大>","Excel")
    vim.map("e,","<Excel_格式-千分位>","Excel")
    vim.map("e9","<Excel_格式-用括号格式化负数>","Excel")
    vim.map("e5","<Excel_格式-百分号>","Excel")
    vim.map("qb","<Excel_格式-设置/取消粗体>","Excel")
    vim.map("qi","<Excel_格式-设置/取消斜体>","Excel")
    vim.map("qu","<Excel_格式-设置/取消下划线>","Excel")
    vim.map("QQ","<Excel_工作表-切换到下个工作表（可循环）>","Excel")
    vim.map("Qq","<Excel_工作表-切换到前个工作表（可循环）>","Excel")
    vim.map("Qa","<Excel_工作表-移动到左侧>","Excel")
    vim.map("Qd","<Excel_工作表-移动到右侧>","Excel")
    vim.map("Qi","<Excel_工作表-插入新工作表>","Excel")
    vim.map("Qn","<Excel_工作表-插入新工作表>","Excel")
    vim.map("QD","<Excel_工作表-删除当前工作表>","Excel")
    vim.map("Qv","<Excel_工作表-复制并粘贴当前工作表>","Excel")
    vim.map("Qr","<Excel_工作表-以当前单元格的值重命名工作表>","Excel")
    vim.map("Qf","<Excel_工作表-选择第一个工作表>","Excel")
    vim.map("Qe","<Excel_工作表-选择最后一个工作表>","Excel")
    vim.map("Qr","<Excel_工作表-以当前单元格的值重命名工作表>","Excel")
    vim.map("p1","<Excel_页面设置-以当前单元格的值设置页眉左侧>","Excel")
    vim.map("p2","<Excel_页面设置-以当前单元格的值设置页眉中间>","Excel")
    vim.map("p3","<Excel_页面设置-以当前单元格的值设置页眉右侧>","Excel")
    vim.map("p7","<Excel_页面设置-以当前单元格的值设置页脚左侧>","Excel")
    vim.map("p8","<Excel_页面设置-以当前单元格的值设置页脚中间>","Excel")
    vim.map("p9","<Excel_页面设置-以当前单元格的值设置页脚右侧>","Excel")
    vim.map("ps","<Excel_视图-页面设置对话框>","Excel")
    vim.map("qf","<Excel_格式-字体颜色-红>","Excel")
    vim.map("qc","<Excel_格式-填充颜色-黄>","Excel")
    vim.map("e=","<Excel_格式-增加小数位>","Excel")
    vim.map("e-","<Excel_格式-减少小数位>","Excel")
    vim.map(":o","<Excel_文件-打开Excel文件>","Excel")
    vim.map(":s","<Excel_文件-保存Excel文件>","Excel")
    vim.map(":S","<Excel_文件-另存Excel文件>","Excel")
    vim.map(":q","<Excel_文件-退出Excel>","Excel")
    vim.map(":x","<Excel_文件-保存并退出Excel>","Excel")
    vim.map("hw","<Excel_格式-自动换行>","Excel")
    vim.map("pv","<Excel_视图-切换正常查看/分页预览>","Excel")
    vim.map("pr","<Excel_视图-打印预览>","Excel")
    vim.map("pp","<Excel_页面设置-在页脚中间设置[x/x]页码>","Excel")
    vim.map("pl","<Excel_视图-显示/不显示自动分页线>","Excel")
    vim.map("pa","<Excel_数据处理-设置打印区域>","Excel")
    vim.map("hh","<Excel_单元格-合并/取消>","Excel")
    vim.map("pn","<Excel_页面设置-在页眉中间设置文件名称>","Excel")
    vim.map("pd","<Excel_页面设置-在页眉右侧设置当前日期>","Excel")
    vim.map("z","<Excel_视图-放大>","Excel")
    vim.map("Z","<Excel_视图-缩小>","Excel")
    
    vim.map("fa","<Excel_筛选-重置所选列>","Excel")
    vim.map("fA","<Excel_筛选-重置所有列>","Excel")
    vim.map("fd","<Excel_筛选-显示筛选对话框>","Excel")
    vim.map("fl","<Excel_筛选-显示内容列表>","Excel")
    vim.map("f=","<Excel_筛选-数值相等（=）的单元格>","Excel")
    vim.map("fo","<Excel_筛选-数值大于等于（>=）的单元格>","Excel")
    vim.map("fu","<Excel_筛选-数值小于等于（<=）的单元格>","Excel")
    ;~ vim.map("f<RT>","<Excel_筛选-数值大于（>）的单元格>","Excel")
    ;~ vim.map("f<LT>","<Excel_筛选-数值小于（<）的单元格>","Excel")
    vim.map("fs","<Excel_筛选-相同的单元格>","Excel")
    vim.map("fn","<Excel_筛选-不相同的单元格>","Excel")
    vim.map("ff","<Excel_筛选-非空单元格>","Excel")
    vim.map("fb","<Excel_筛选-空单元格>","Excel")
    vim.map("fi","<Excel_筛选-包含>","Excel")
    vim.map("fe","<Excel_筛选-不包含>","Excel")
    vim.map("fB","<Excel_筛选-开头是>","Excel")
    vim.map("fr","<Excel_筛选-填充颜色>","Excel")
    vim.map("ft","<Excel_筛选-字体颜色>","Excel")
    vim.map("f1","<Excel_筛选-与所选单元格前1个字符相同>","Excel")
    vim.map("f2","<Excel_筛选-与所选单元格前1-2个字符相同>","Excel")
    vim.map("f3","<Excel_筛选-与所选单元格前1-3个字符相同>","Excel")
    vim.map("f4","<Excel_筛选-与所选单元格前1-4个字符相同>","Excel")
    vim.map("f5","<Excel_筛选-与所选单元格前1-5个字符相同>","Excel")
    vim.map("f6","<Excel_筛选-与所选单元格前1-6个字符相同>","Excel")
    vim.map("f7","<Excel_筛选-与所选单元格前1-7个字符相同>","Excel")
    vim.map("f8","<Excel_筛选-与所选单元格前1-8个字符相同>","Excel")
    vim.map("f9","<Excel_筛选-与所选单元格前1-9个字符相同>","Excel")
    vim.map("fE","<Excel_筛选-结尾是>","Excel")
    vim.map("fss","<Excel_筛选-升序排列>","Excel")
    vim.map("fsr","<Excel_筛选-降序排列>","Excel")
    vim.map("F9","<Excel_筛选-与所选单元格后1-9个字符相同>","Excel")
    vim.map("F1","<Excel_筛选-与所选单元格后1个字符相同>","Excel")
    vim.map("F2","<Excel_筛选-与所选单元格后1-2个字符相同>","Excel")
    vim.map("F3","<Excel_筛选-与所选单元格后1-3个字符相同>","Excel")
    vim.map("F4","<Excel_筛选-与所选单元格后1-4个字符相同>","Excel")
    vim.map("F5","<Excel_筛选-与所选单元格后1-5个字符相同>","Excel")
    vim.map("F6","<Excel_筛选-与所选单元格后1-6个字符相同>","Excel")
    vim.map("F7","<Excel_筛选-与所选单元格后1-7个字符相同>","Excel")
    vim.map("F8","<Excel_筛选-与所选单元格后1-8个字符相同>","Excel")
    vim.map("fm","<Excel_筛选-自动筛选>","Excel")
    vim.map("a","<Excel_向左>","Excel")
    vim.map("s","<Excel_向下>","Excel")
    vim.map("w","<Excel_向上>","Excel")
    vim.map("d","<Excel_向右>","Excel")
    vim.map("gg","<Excel_定位-列首个单元格>","Excel")
    vim.map("G","<Excel_定位-列最后一个非空单元格>","Excel")
    vim.map("S","<Excel_选择-区域-到当前区域边缘-下>","Excel")
    vim.map("W","<Excel_选择-区域-到当前区域边缘-上>","Excel")
    vim.map("A","<Excel_选择-区域-到当前区域边缘-左>","Excel")
    vim.map("gd","<Excel_定位-到当前区域边缘-右>","Excel")
    vim.map("]","<Excel_定位-到[x]列[n]行>","Excel")
    vim.map("yy","<Excel_行-选中行>","Excel")
    vim.map("yh","<Excel_列-选中列>","Excel")
    vim.map("ey","<Excel_行-删除选中行>","Excel")
    vim.map("eh","<Excel_列-删除选中列>","Excel")
    vim.map("el","<Excel_单元格-删除单元格-右侧单元格左移>","Excel")
    vim.map("eu","<Excel_单元格-删除单元格-下方单元格上移>","Excel")
    vim.map("ew","<Excel_行-删除行-从当前行到顶部>","Excel")
    vim.map("es","<Excel_行-删除行-从当前行到底部>","Excel")
    vim.map("ea","<Excel_列-删除列-从当前列到左侧头部>","Excel")
    vim.map("ed","<Excel_列-删除列-从当前列到右侧尾部>","Excel")
    vim.map("D","<Excel_选择-区域-到当前区域边缘-右>","Excel")
    vim.map("gs","<Excel_定位-到当前区域边缘-下>","Excel")
    vim.map("gw","<Excel_定位-到当前区域边缘-上>","Excel")
    vim.map("ga","<Excel_定位-到当前区域边缘-左>","Excel")
    vim.map("na","<Excel_定位-到当前区域（左）单元格>","Excel")
    vim.map("ns","<Excel_定位-到当前区域（下）单元格>","Excel")
    vim.map("nd","<Excel_定位-到当前区域（右）单元格>","Excel")
    vim.map("nw","<Excel_定位-到当前区域（上）单元格>","Excel")
    vim.map("c","<Excel_复制（Ctrl+C）>","Excel")
    vim.map("bb","<Excel_格式-边框-全部细实线>","Excel")
    vim.map("bB","<Excel_格式-边框-边实内点>","Excel")
    vim.map("e1","<Excel_格式-小数点1位>","Excel")
    vim.map("e2","<Excel_格式-小数点2位>","Excel")
    vim.map("e3","<Excel_格式-小数点3位>","Excel")
    vim.map("e4","<Excel_格式-小数点0位>","Excel")
    vim.map("e0","<Excel_格式-显示/不显示【零值】>","Excel")
    vim.map("j","<Excel_运行宏-临时1>","Excel")
    vim.map("k","<Excel_运行宏-临时2>","Excel")
    vim.map("l","<Excel_运行宏-临时3>","Excel")
    vim.map("m","<Excel_运行宏-临时4>","Excel")
    vim.map("hs","<Excel_视图-排序>","Excel")
    vim.map("hd","<Excel_数据处理-删除重复项>","Excel")
    vim.map("F","<Excel_查找（Ctrl+F）>","Excel")
    vim.map("rR","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rr","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rb","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rB","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("ry","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rY","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rg","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rG","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("r1","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("r2","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("r3","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("r4","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rw","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rk","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("ra","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rn","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("ro","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("rO","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tr","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tR","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tb","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tB","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("ty","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tY","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tg","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tG","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("to","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tO","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("t1","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("t2","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("t3","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("t4","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tw","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("tk","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("ta","<Excel_格式-指定填充/字体颜色>","Excel")
    vim.map("uy","<Excel_行-选中行-隐藏>","Excel")
    vim.map("uY","<Excel_行-选中行-显示>","Excel")
    vim.map("uh","<Excel_列-选中列-隐藏>","Excel")
    vim.map("uH","<Excel_列-选中列-显示>","Excel")
    vim.map(":c","<Excel_其他-错误检查>","Excel")
    vim.map("<space>","<Excel_编辑单元格（F2功能）>","Excel")
    vim.map("X","<Excel_工作表循环-切换工作表>","Excel")
    vim.map("N","<Excel_工作表循环-定义原始工作表>","Excel")
    vim.map("f[","<Excel_筛选-输入框>","Excel")
    vim.map("hm","<Excel_单元格-合并且保留所有内容>","Excel")
    vim.map("hz","<Excel_其他-批注-添加>","Excel")
    vim.map("o","<Excel_其他-临时命令>","Excel")
    vim.map(":?","<Excel_VIMD显示热键帮助>","Excel")
    vim.map("<a-q>","<Excel_文件-不保存关闭>","Excel")
    vim.map("<capslock>","<Excel_VIMD清除输入>","Excel")
    vim.map("C","<Excel_其他-格式刷>","Excel")
    vim.map("pm","<Excel_页面设置-页边距>","Excel")
    vim.map("po","<Excel_页面设置-设置为1页宽>","Excel")
    vim.map("ph","<Excel_页面设置-纸张横向>","Excel")
    vim.map("pz","<Excel_页面设置-纸张纵向>","Excel")
    vim.map("qn","<Excel_单元格-格式-Excel>","Excel")
    vim.map("qt","<Excel_单元格-格式-文本>","Excel")
    vim.map("qdd","<Excel_单元格-格式-日期(20170101)>","Excel")
    vim.map("qd-","<Excel_单元格-格式-日期(2017-01-01)>","Excel")
    vim.map("qd/","<Excel_单元格-格式-日期(2017/01/01)>","Excel")
    vim.map("qd.","<Excel_单元格-格式-日期(2017.01.01)>","Excel")
    vim.map("qdz","<Excel_单元格-格式-日期(2017年01月01日)>","Excel")
    ;~ vim.map("<MButton>","<Excel_右键临时命令>","Excel")
    ;~ vim.map("<XButton1>","<Excel_其他-十字光标-启用>","Excel")
    ;~ vim.map("<XButton2>","<Excel_其他-十字光标-取消>","Excel")
    vim.map("pt","<Excel_页面布局-顶端标题行/左端标题列>","Excel")
return




<Excel_切换到【VIM模式】>:  ;{
    send,{esc}
    vim.mode("VIM模式","Excel")
    SetModUIInsert()
    ; MsgBox, 0, 提示, 【VIM模式】, 0.3
    ;excel:=Excel_Get()
    ;excel.statusBar:="VIM模式"
return
;}

<Excel_切换到【普通模式】>:  ;{
    send,{esc}
    SetModUINormal()
    vim.mode("普通模式","Excel")
    ; MsgBox, 0, 提示, 【普通模式】, 0.3
    ;excel:=Excel_Get()
    ;excel.statusBar:=black
return
;}

<Excel_单元格-编辑-在头部输入>:  ;{
    Excel_Range_Edit("F")
return
;}

<Excel_单元格-编辑-在尾部输入>:  ;{
    Excel_Range_Edit("E")
return
;}

<Excel_单元格-编辑-替换输入>:  ;{
    Excel_Range_Edit("R")
return
;}

<Excel_剪贴（Ctrl+X）>:  ;{
    sendinput,^x
return
;}

<Excel_行-插入行-当前单元格下方>:  ;{
    Excel_Row_Insert("B")
return
;}

<Excel_行-插入行-当前单元格上方>:  ;{
    Excel_Row_Insert("T")
return
;}

<Excel_列-插入列-当前单元格右侧>:  ;{
    Excel_Column_Insert("R")
return
;}

<Excel_列-插入列-当前单元格左侧>:  ;{
    Excel_Column_Insert("L")
return
;}

<Excel_替换（Ctrl+H）>:  ;{
    sendinput,^h
return
;}

<Excel_其他-查找下一项>:  ;{
    Excel_Find_NextOrPrevious("N")
return
;}

<Excel_其他-查找上一项>:  ;{
    Excel_Find_NextOrPrevious("P")
return
;}

<Excel_单元格-填充-以上方单元格值>:  ;{
    Excel_Range_FillWith("上")
return
;}

<Excel_单元格-填充-以下方单元格值>:  ;{
Excel_Range_FillWith("下")
return
;}

<Excel_单元格-填充-以右侧单元格值>:  ;{
Excel_Range_FillWith("右")
return
;}

<Excel_单元格-填充-以左侧单元格值>:  ;{
Excel_Range_FillWith("左")
return
;}

<Excel_粘贴（Ctrl+V）>:  ;{
sendinput,^v
return
;}

<Excel_剪切板-选择性粘贴>:  ;{
Excel_Cliboard_PasteSelcet()
return
;}

<Excel_剪贴板-粘贴为数值>:  ;{
Excel_Cliboard_PasteAsValue()
return
;}

<Excel_其他-调整所选行高h-列宽w-字号f>:  ;{
Excel_SetNNN()
return
;}

<Excel_行-自动行高>:  ;{
Excel_Row_AutoHeight()
return
;}

<Excel_列-自动列宽>:  ;{
Excel_Column_AutoWidth()
return
;}

<Excel_列-列宽减小>:  ;{
Excel_Column_SetWidth("-1")
return
;}

<Excel_列-列宽增加>:  ;{
Excel_Column_SetWidth("+1")
return
;}

<Excel_格式-边框-内部水平方向-点线>:  ;{
Excel_Format_SetBonder("内部水平","点线","极细")
return
;}

<Excel_格式-边框-内部水平方向-实线>:  ;{
Excel_Format_SetBonder("内部水平","实线","细")
return
;}

<Excel_格式-边框-内部垂直方向-点线>:  ;{
Excel_Format_SetBonder("内部垂直","点线","极细")
return
;}

<Excel_格式-边框-内部垂直方向-实线>:  ;{
Excel_Format_SetBonder("内部垂直","实线","细")
return
;}

<Excel_格式-边框-四周实线>:  ;{
Excel_Format_SetBonder("四周","实线","细")
return
;}

<Excel_格式-边框-四周粗实线>:  ;{
Excel_Format_SetBonder("四周","实线","中")
return
;}

<Excel_格式-边框-四周双线>:  ;{
 Excel_Format_SetBonder("四周","双线","粗")
return
;}

<Excel_格式-边框-全部无边框>:  ;{
Excel_Format_SetBonder("全部","无","细")
return
;}

<Excel_格式-对齐-水平-左对齐>:  ;{
Excel_Format_SetAlignment("水平","左对齐")
return
;}

<Excel_格式-对齐-水平-居中>:  ;{
Excel_Format_SetAlignment("水平","居中")
return
;}

<Excel_格式-对齐-水平-右对齐>:  ;{
Excel_Format_SetAlignment("水平","右对齐")
return
;}

<Excel_格式-对齐-水平-跨列对齐>:  ;{
Excel_Format_SetAlignment("水平","跨列对齐")
return
;}

<Excel_缩进对齐-增加>:  ;{
Excel_Format_InsertIndent(1)
return
;}

<Excel_格式-缩进对齐-取消>:  ;{
Excel_Format_InsertIndent(-1)
return
;}

<Excel_格式-对齐-垂直-靠上>:  ;{
Excel_Format_SetAlignment("垂直","靠上")
return
;}

<Excel_格式-对齐-垂直-居中>:  ;{
Excel_Format_SetAlignment("垂直","居中")
return
;}

<Excel_格式-对齐-垂直-靠下>:  ;{
Excel_Format_SetAlignment("垂直","靠下")
return
;}

<Excel_格式-字号变小>:  ;{
Excel_Format_SetFontSize("-1")
return
;}

<Excel_格式-字号变大>:  ;{
Excel_Format_SetFontSize("+1")
return
;}

<Excel_格式-千分位>:  ;{
Excel_Format_Thousands()
return
;}

<Excel_格式-用括号格式化负数>:  ;{
Excel_Format_SetMinus()
return
;}

<Excel_格式-百分号>:  ;{
Excel_Format_SetPercent()
return
;}

<Excel_格式-设置/取消粗体>:  ;{
Excel_Format_SetBold()
return
;}

<Excel_格式-设置/取消斜体>:  ;{
Excel_Format_SetItalic()
return
;}

<Excel_格式-设置/取消下划线>:  ;{
Excel_Format_SetUnderline()
return
;}

<Excel_工作表-切换到下个工作表（可循环）>:  ;{
Excel_Worksheet_SelectNext()
return
;}

<Excel_工作表-切换到前个工作表（可循环）>:  ;{
Excel_Worksheet_SelectPrevious()
return
;}

<Excel_工作表-移动到左侧>:  ;{
Excel_Worksheet_MoveLeft()
return
;}

<Excel_工作表-移动到右侧>:  ;{
Excel_Worksheet_MoveRight()
return
;}

<Excel_工作表-插入新工作表>:  ;{
Excel_Worksheet_Insert()
return
;}

<Excel_工作表-删除当前工作表>:  ;{
Excel_Worksheet_DeleteCurrent()
return
;}

<Excel_工作表-复制并粘贴当前工作表>:  ;{
Excel_Worksheet_CopyAndPaste()
return
;}

<Excel_工作表-以当前单元格的值重命名工作表>:  ;{
Excel_Worksheet_Rename()
return
;}

<Excel_工作表-选择第一个工作表>:  ;{
Excel_Worksheet_Select("F")
return
;}

<Excel_工作表-选择最后一个工作表>:  ;{
Excel_Worksheet_Select("E")
return
;}

<Excel_页面设置-以当前单元格的值设置页眉左侧>:  ;{
Excel_PageSetup_SetHeader("L","")
return
;}

<Excel_页面设置-以当前单元格的值设置页眉中间>:  ;{
Excel_PageSetup_SetHeader("C","")
return
;}

<Excel_页面设置-以当前单元格的值设置页眉右侧>:  ;{
Excel_PageSetup_SetHeader("R","")
return
;}

<Excel_页面设置-以当前单元格的值设置页脚左侧>:  ;{
Excel_PageSetup_SetFooter("L","")
return
;}

<Excel_页面设置-以当前单元格的值设置页脚中间>:  ;{
Excel_PageSetup_SetFooter("C","")
return
;}

<Excel_页面设置-以当前单元格的值设置页脚右侧>:  ;{
Excel_PageSetup_SetFooter("R","")
return
;}

<Excel_视图-页面设置对话框>:  ;{
Excel_Dialogs_PageSetup()
return
;}

<Excel_格式-字体颜色-红>:  ;{
Excel_Format_SetColor("tr")
return
;}

<Excel_格式-填充颜色-黄>:  ;{
Excel_Format_SetColor("ry")
return
;}

<Excel_格式-增加小数位>:  ;{
Excel_Format_SetDecimalNum_Grow()
return
;}

<Excel_格式-减少小数位>:  ;{
Excel_Format_SetDecimalNum_Shrink()
return
;}

<Excel_文件-打开Excel文件>:  ;{
Excel_OpenFile()
return
;}

<Excel_文件-保存Excel文件>:  ;{
Excel_SaveFile()
return
;}

<Excel_文件-另存Excel文件>:  ;{
Excel_SaveFileAs()
return
;}

<Excel_文件-退出Excel>:  ;{
Excel_CloseExcel()
return
;}

<Excel_文件-保存并退出Excel>:  ;{
Excel_SaveAndExit()
return
;}

<Excel_格式-自动换行>:  ;{
Excel_Format_WrapText()
return
;}

<Excel_视图-切换正常查看/分页预览>:  ;{
Excel_View_NormalOrPageBreak()
return
;}

<Excel_视图-打印预览>:  ;{
Excel_View_PrintPreView()
return
;}

<Excel_页面设置-在页脚中间设置[x/x]页码>:  ;{
Excel_PageSetup_SetFooter("C","&P/&N")
return
;}

<Excel_视图-显示/不显示自动分页线>:  ;{
Excel_View_DisplayAutomaticPageBreaks()
return
;}

<Excel_数据处理-设置打印区域>:  ;{
Excel_Data_SetPrintArea()
return
;}

<Excel_单元格-合并/取消>:  ;{
Excel_Range_Merge()
return
;}

<Excel_页面设置-在页眉中间设置文件名称>:  ;{
Excel_PageSetup_SetHeader("C","&F")
return
;}

<Excel_页面设置-在页眉右侧设置当前日期>:  ;{
Excel_PageSetup_SetHeader("R","&D")
return
;}

<Excel_视图-放大>:  ;{
Excel_Zoom("+5")
return
;}

<Excel_视图-缩小>:  ;{
Excel_Zoom("-10")
return
;}

<Excel_其他-重复命令>:  ;{
Excel_RepeatAction()
return
;}

<Excel_筛选-重置所选列>:  ;{
Excel_Filter_ResetCurrentColumn()
return
;}

<Excel_筛选-重置所有列>:  ;{
Excel_Filter_ResetAllColumns()
return
;}

<Excel_筛选-显示筛选对话框>:  ;{
Excel_Filter_ShowDialog()
return
;}

<Excel_筛选-显示内容列表>:  ;{
Excel_Filter_ShowList()
return
;}

<Excel_筛选-数值相等（=）的单元格>:  ;{
Excel_Filter_Equal()
return
;}

<Excel_筛选-数值大于等于（>=）的单元格>:  ;{
Excel_Filter_EqualOrGreater()
return
;}

<Excel_筛选-数值小于等于（<=）的单元格>:  ;{
Excel_Filter_EqualOrLesser()
return
;}

<Excel_筛选-数值大于（>）的单元格>:  ;{
Excel_Filter_Greater()
return
;}

<Excel_筛选-数值小于（<）的单元格>:  ;{
Excel_Filter_Lesser()
return
;}

<Excel_筛选-相同的单元格>:  ;{
Excel_Filter_Same()
return
;}

<Excel_筛选-不相同的单元格>:  ;{
Excel_Filter_NotEqual()
return
;}

<Excel_筛选-非空单元格>:  ;{
Excel_Filter_NotEmpty()
return
;}

<Excel_筛选-空单元格>:  ;{
Excel_Filter_Empty()
return
;}

<Excel_筛选-包含>:  ;{
Excel_Filter_Include()
return
;}

<Excel_筛选-不包含>:  ;{
Excel_Filter_NotInclude()
return
;}

<Excel_筛选-开头是>:  ;{
Excel_Filter_BeginWith()
return
;}

<Excel_筛选-填充颜色>:  ;{
Excel_Filter_InteriorColor()
return
;}

<Excel_筛选-字体颜色>:  ;{
Excel_Filter_FontColor()
return
;}

<Excel_筛选-与所选单元格前1个字符相同>:  ;{
Excel_Filter_EqualAsFront(1)
return
;}

<Excel_筛选-与所选单元格前1-2个字符相同>:  ;{
Excel_Filter_EqualAsFront(2)
return
;}

<Excel_筛选-与所选单元格前1-3个字符相同>:  ;{
Excel_Filter_EqualAsFront(3)
return
;}

<Excel_筛选-与所选单元格前1-4个字符相同>:  ;{
Excel_Filter_EqualAsFront(4)
return
;}

<Excel_筛选-与所选单元格前1-5个字符相同>:  ;{
Excel_Filter_EqualAsFront(5)
return
;}

<Excel_筛选-与所选单元格前1-6个字符相同>:  ;{
Excel_Filter_EqualAsFront(6)
return
;}

<Excel_筛选-与所选单元格前1-7个字符相同>:  ;{
Excel_Filter_EqualAsFront(7)
return
;}

<Excel_筛选-与所选单元格前1-8个字符相同>:  ;{
Excel_Filter_EqualAsFront(8)
return
;}

<Excel_筛选-与所选单元格前1-9个字符相同>:  ;{
Excel_Filter_EqualAsFront(9)
return
;}

<Excel_筛选-结尾是>:  ;{
Excel_Filter_EndWith()
return
;}

<Excel_筛选-升序排列>:  ;{
Excel_Filter_Sort(0)
return
;}

<Excel_筛选-降序排列>:  ;{
Excel_Filter_Sort(1)
return
;}

<Excel_筛选-与所选单元格后1-9个字符相同>:  ;{
Excel_Filter_EqualAsBehind(9)
return
;}

<Excel_筛选-与所选单元格后1个字符相同>:  ;{
Excel_Filter_EqualAsBehind(1)
return
;}

<Excel_筛选-与所选单元格后1-2个字符相同>:  ;{
Excel_Filter_EqualAsBehind(2)
return
;}

<Excel_筛选-与所选单元格后1-3个字符相同>:  ;{
Excel_Filter_EqualAsBehind(3)
return
;}

<Excel_筛选-与所选单元格后1-4个字符相同>:  ;{
Excel_Filter_EqualAsBehind(4)
return
;}

<Excel_筛选-与所选单元格后1-5个字符相同>:  ;{
Excel_Filter_EqualAsBehind(5)
return
;}

<Excel_筛选-与所选单元格后1-6个字符相同>:  ;{
Excel_Filter_EqualAsBehind(6)
return
;}

<Excel_筛选-与所选单元格后1-7个字符相同>:  ;{
Excel_Filter_EqualAsBehind(7)
return
;}

<Excel_筛选-与所选单元格后1-8个字符相同>:  ;{
Excel_Filter_EqualAsBehind(8)
return
;}

<Excel_筛选-自动筛选>:  ;{
Excel_Filter_AutoFilter()
return
;}

<Excel_向左>:  ;{
sendinput,{left}
return
;}

<Excel_向下>:  ;{
sendinput,{down}
return
;}

<Excel_向上>:  ;{
sendinput,{up}
return
;}

<Excel_向右>:  ;{
sendinput,{right}
return
;}

<Excel_定位-列首个单元格>:  ;{
Excel_Location_ColumnFirstCell()
return
;}

<Excel_定位-列最后一个非空单元格>:  ;{
Excel_Location_ColumnLastCell()
return
;}

<Excel_选择-区域-到当前区域边缘-下>:  ;{
Excel_Selection_AddRegion("下")
return
;}

<Excel_选择-区域-到当前区域边缘-上>:  ;{
Excel_Selection_AddRegion("上")
return
;}

<Excel_选择-区域-到当前区域边缘-左>:  ;{
Excel_Selection_AddRegion("左")
return
;}

<Excel_定位-到当前区域边缘-右>:  ;{
Excel_Location_EdgeCell("右")
return
;}

<Excel_定位-到[x]列[n]行>:  ;{
Excel_Location_Cell()
return
;}

<Excel_行-选中行>:  ;{
Excel_Row_Select()
return
;}

<Excel_列-选中列>:  ;{
Excel_Column_Select()
return
;}

<Excel_行-删除选中行>:  ;{
Excel_Row_DeleteSelect()
return
;}

<Excel_列-删除选中列>:  ;{
Excel_Column_DeleteSelect()
return
;}

<Excel_单元格-删除单元格-右侧单元格左移>:  ;{
Excel_Selection_Delete("左移")
return
;}

<Excel_单元格-删除单元格-下方单元格上移>:  ;{
Excel_Selection_Delete("上移")
return
;}

<Excel_行-删除行-从当前行到顶部>:  ;{
Excel_Row_DeleteFromCurrentToFirst()
return
;}

<Excel_行-删除行-从当前行到底部>:  ;{
Excel_Row_DeleteFromCurrentToLast()
return
;}

<Excel_列-删除列-从当前列到左侧头部>:  ;{
Excel_Column_DeleteFromCurrentToFirst()
return
;}

<Excel_列-删除列-从当前列到右侧尾部>:  ;{
Excel_Column_DeleteFromCurrentToLast()
return
;}

<Excel_选择-区域-到当前区域边缘-右>:  ;{
Excel_Selection_AddRegion("右")
return
;}

<Excel_定位-到当前区域边缘-下>:  ;{
Excel_Location_EdgeCell("下")
return
;}

<Excel_定位-到当前区域边缘-上>:  ;{
Excel_Location_EdgeCell("上")
return
;}

<Excel_定位-到当前区域边缘-左>:  ;{
Excel_Location_EdgeCell("左")
return
;}

<Excel_定位-到当前区域（左）单元格>:  ;{
Excel_Location_EdgeNextCell("左")
return
;}

<Excel_定位-到当前区域（下）单元格>:  ;{
Excel_Location_EdgeNextCell("下")
return
;}

<Excel_定位-到当前区域（右）单元格>:  ;{
Excel_Location_EdgeNextCell("右")
return
;}

<Excel_定位-到当前区域（上）单元格>:  ;{
Excel_Location_EdgeNextCell("上")
return
;}

<Excel_复制（Ctrl+C）>:  ;{
sendinput,^c
return
;}

<Excel_格式-边框-全部细实线>:  ;{
Excel_Format_SetBonder("全部","实线","细")
return
;}

<Excel_格式-边框-边实内点>:  ;{
Excel_Format_SetBonder("内部垂直","点线","极细")
sleep,100
Excel_Format_SetBonder("内部水平","点线","极细")
sleep,100
Excel_Format_SetBonder("四周","实线","细")
return
;}

<Excel_格式-小数点1位>:  ;{
Excel_Format_SetDecimalNum(1)
return
;}

<Excel_格式-小数点2位>:  ;{
Excel_Format_SetDecimalNum(2)
return
;}

<Excel_格式-小数点3位>:  ;{
Excel_Format_SetDecimalNum(3)
return
;}

<Excel_格式-小数点0位>:  ;{
Excel_Format_SetDecimalNum(0)
return
;}

<Excel_格式-显示/不显示【零值】>:  ;{
Excel_Format_DisplayZeros()
return
;}

<Excel_运行宏-临时1>:  ;{
try
comObjactive("excel.application").run("Personal.xlsb!公式类_1复制数据公式")
return
;}

<Excel_运行宏-临时2>:  ;{
try
comObjactive("excel.application").run("Personal.xlsb!公式类_2粘贴数据公式")
return
;}

<Excel_运行宏-临时3>:  ;{
;comObjactive("excel.application").run("Personal.xlsb!公式类_2粘贴数据公式")
;excel:=Excel_Get()
;sendinput,^{enter}
;sleep,300
global excel
Excel_Get()
excel.Cells(1,6).select
Excel_Destroy()
return
;}

<Excel_运行宏-临时4>:  ;{
sendinput,{Enter}
;comObjactive("excel.application").run("Personal.xlsb!公式类_2粘贴数据公式")
global excel
Excel_Get()
excel.Cells(1,6).select
Excel_Destroy()
return
;}

<Excel_视图-排序>:  ;{
Excel_Dialogs_Sort()
return
;}

<Excel_数据处理-删除重复项>:  ;{
Excel_Data_DeleteRepetition()
return
;}

<Excel_查找（Ctrl+F）>:  ;{
    sendinput,^f
return
;}

<Excel_格式-指定填充/字体颜色>:  ;{
Excel_Format_SetColor()
return
;}

<Excel_行-选中行-隐藏>:  ;{
Excel_Row_Hide(1)
return
;}

<Excel_行-选中行-显示>:  ;{
Excel_Row_Hide(0)
return
;}

<Excel_列-选中列-隐藏>:  ;{
Excel_Column_Hide(1)
return
;}

<Excel_列-选中列-显示>:  ;{
Excel_Column_Hide(0)
return
;}

<Excel_其他-错误检查>:  ;{
Excel_ErrorCheck()
return
;}

<Excel_编辑单元格（F2功能）>:  ;{
Excel_Range_Edit()
return
;}

<Excel_工作表循环-切换工作表>:  ;{
Excel_Worksheet_Switch()
return
;}

<Excel_工作表循环-定义原始工作表>:  ;{
Excel_Worksheet_DefSwitchFrom()
return
;}

<Excel_筛选-输入框>:  ;{
Excel_Filter_InputBox()
return
;}

<Excel_单元格-合并且保留所有内容>:  ;{
Excel_Range_MergeAndKeepValue()
return
;}

<Excel_其他-批注-添加>:  ;{
Excel_Comment_Add()
return
;}

<Excel_其他-临时命令>:  ;{
sendinput,!=
sleep,300
sendinput,{enter}
return
;}

<Excel_VIMD显示热键帮助>:  ;{
;~ QZ_VIMD_ShowKeyHelp()
return
;}

<Excel_文件-不保存关闭>:  ;{
send,!{f4}
sleep,400
send,n
return
;}

<Excel_VIMD清除输入>:  ;{
;~ QZ_VIMD_ClearInput()
return
;}

<Excel_其他-格式刷>:  ;{
Excel_FormatBrush()
return
;}

<Excel_页面设置-页边距>:  ;{
Excel_setMargin("0.5,0.5,0.5,0.5,0,0|1,1,1,1,0.5,0.5|1.5,1.5,1.5,1.5,0.5,0.5|2,2,2,2,1,1|2.5,2.5,2.5,2.5,1.5,1.5|2.54,2.54,3.17,3.17,1.5,1.75")
return
;}

<Excel_页面设置-设置为1页宽>:  ;{
Excel_PageSetup_FitTo1PageWide()
return
;}

<Excel_页面设置-纸张横向>:  ;{
Excel_PageSetup_SetOrientation("横向")
return
;}

<Excel_页面设置-纸张纵向>:  ;{
Excel_PageSetup_SetOrientation("纵向")
return
;}

<Excel_单元格-格式-Excel>:  ;{
Excel_Format_Normal()
return
;}

<Excel_单元格-格式-文本>:  ;{
Excel_Format_Text()
return
;}

<Excel_单元格-格式-日期(20170101)>:  ;{
Excel_Format_Date("d")
return
;}

<Excel_单元格-格式-日期(2017-01-01)>:  ;{
Excel_Format_Date("-")
return
;}

<Excel_单元格-格式-日期(2017/01/01)>:  ;{
Excel_Format_Date("/")
return
;}

<Excel_单元格-格式-日期(2017.01.01)>:  ;{
Excel_Format_Date(".")
return
;}

<Excel_单元格-格式-日期(2017年01月01日)>:  ;{
Excel_Format_Date("z")
return
;}

<Excel_右键临时命令>:  ;{
;--------------------------------------
;作用：重复命令【F4】后，选中G1
sendinput,{F4}
sleep,100
global excel
Excel_Get()
excel.Cells(1,7).select


return
;}

<Excel_其他-十字光标-启用>:  ;{
;---------------------------------------
;作用：十字光标显示
Excel_CursorCross(1)
return
;}

<Excel_其他-十字光标-取消>:  ;{
;---------------------------------------
;作用：十字光标显示
Excel_CursorCross(0)
return
;}

<Excel_页面布局-顶端标题行/左端标题列>:  ;{
Excel_PageSetup_PrintTitle()
return
;}

#include *i %A_ScriptDir%\plugins\Excel\VIMD_Excel.ahk
