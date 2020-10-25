; RunZ:Date
; 简体繁体互相转换

Date:
    @("rq", "日期")
return

rq:
    Jq:=GetLunarJq(A_Now,1), LunarDate:=Date2LunarDate(A_Now) ;(SubStr(A_Now,7,2)=Jq[1]?" ( " Jq[2] " )":"")
    DisplayResult("公历：" SubStr(A_Now,1,4) "年" SubStr(A_Now,5,2) "月"SubStr(A_Now,7,2) "日" "`n`n" "农历：" LunarDate[1] (LunarDate[5]?" - " LunarDate[5]:""))
return

/*
	GetLunarJq(A_Now)--->节气查询
	Date2LunarDate(A_Now)--->公历日期转化为农历日期+公历日期转化为干支日期记年法
	Date_GetDate(A_Now)--->农历日期转换为公历日期
*/

;;================================================================================================================================
/*
	返回数组为4个值（该方法适用于20世纪和21世纪）
	[当前月份节气所在哪日，节气名称，所在节气农历月份，节气名称拼音缩写]
*/
GetLunarJq(date,s:=0){   ;s=1获取当前日期真实节气数据，s为空获取该月份第一个节气公历时间
	If (strlen(date)<8||date~="\.")
		return []
	year:=SubStr(date,1,4), month:=SubStr(date,5,2), D:=0.2422, Y:=SubStr(year,3,2), L:=month>2?Floor(SubStr(year,3,2)/4):Floor((SubStr(year,3,2)-1)/4)
	If (SubStr(date,1,6)>190002&&SubStr(date,1,6)<200001){
		C:=[[[6.11,"小寒",12,"xh"],[20.84,"大寒",12,"dh"]],[[4.6295,"立春",1,"lc"],[19.4599,"雨水",1,"ys"]],[[6.3826,"惊蛰",2,"jz"],[21.4155,"春分",2,"cf"]],[[5.59,"清明",3,"qm"],[20.888,"谷雨",3,"gy"]],[[6.318,"立夏",4,"lx"],[21.86,"小满",4,"xm"]],[[6.5,"芒种",5,"mz"],[22.2,"夏至",5,"xz"]],[[7.928,"小暑",6,"xs"],[23.65,"大暑",6,"ds"]],[[28.35,"立秋",7,"lq"],[23.95,"处暑",7,"cs"]],[[8.44,"白露",8,"bl"],[23.822,"秋分",8,"qf"]],[[9.098,"寒露",9,"hl"],[24.218,"霜降",9,"sj"]],[[8.218,"立冬",10,"ld"],[23.08,"小雪",10,"xx"]],[[7.9,"大雪",11,"dx"],[22.6,"冬至",11,"dz"]]]
		jq:=Floor(Y*D+C[month,1,1])-L, result:=[jq,C[month,1,2],C[month,1,3],C[month,1,4]]
		If SubStr(date,7,2)>=Floor(Y*D+C[month,2,1])-L
			result:=[Floor(Y*D+C[month,2,1])-L,C[month,2,2],C[month,2,3],C[month,2,4]]
		If (s&&SubStr(date,7,2)<jq&&SubStr(date,1,6)>190002)
			result:=[Floor(Y*D+C[(month=1?12:month-1),2,1])-L,C[(month=1?12:month-1),2,2],C[(month=1?12:month-1),2,3],C[(month=1?12:month-1),2,4]]
		for section,element in [[2084,"cf"],[1911,"lx"],[2008,"xm"],[1902,"mz"],[1928,"xz"],[1925,"xs"],[2016,"xs"],[1922,"ds"],[2002,"lq"],[1927,"bl"],[1942,"qf"],[2089,"sj"],[2089,"ld"],[1978,"xx"],[1954,"dx"],[1982,"xh"],[2000,"dh"],[2082,"dh"]]
			If (result[4]=element[2]&&year=element[1])
				result[1]:=result[1]+1
		for section,element in [[2026,"ys"],[1918,"dz"],[2021,"dz"],[2019,"xh"]]
			If (result[4]=element[2]&&year=element[1])
				result[1]:=result[1]-1
		return result
	}else if (SubStr(date,1,6)>200000&&SubStr(date,1,6)<209912){
		C:=[[[5.4055,"小寒",12,"xh"],[20.12,"大寒",12,"dh"]],[[3.87,"立春",1,"lc"],[18.73,"雨水",1,"ys"]],[[5.63,"惊蛰",2,"jz"],[20.646,"春分",2,"cf"]],[[4.81,"清明",3,"qm"],[20.1,"谷雨",3,"gy"]],[[5.52,"立夏",4,"lx"],[21.04,"小满",4,"xm"]],[[5.678,"芒种",5,"mz"],[21.37,"夏至",5,"xz"]],[[7.108,"小暑",6,"xs"],[22.83,"大暑",6,"ds"]],[[7.5,"立秋",7,"lq"],[23.13,"处暑",7,"cs"]],[[7.646,"白露",8,"bl"],[23.042,"秋分",8,"qf"]],[[8.318,"寒露",9,"hl"],[23.438,"霜降",9,"sj"]],[[7.438,"立冬",10,"ld"],[22.36,"小雪",10,"xx"]],[[7.18,"大雪",11,"dx"],[21.94,"冬至",11,"dz"]]]
		jq:=Floor(Y*D+C[month,1,1])-L, result:=[jq,C[month,1,2],C[month,1,3],C[month,1,4]]
		If SubStr(date,7,2)>=Floor(Y*D+C[month,2,1])-L
			result:=[Floor(Y*D+C[month,2,1])-L,C[month,2,2],C[month,2,3],C[month,2,4]]
		If (s&&SubStr(date,7,2)<jq&&SubStr(date,1,6)>200000)
			result:=[Floor(Y*D+C[(month=1?12:month-1),2,1])-L,C[(month=1?12:month-1),2,2],C[(month=1?12:month-1),2,3],C[(month=1?12:month-1),2,4]]
		for section,element in [[2084,"cf"],[1911,"lx"],[2008,"xm"],[1902,"mz"],[1928,"xz"],[1925,"xs"],[2016,"xs"],[1922,"ds"],[2002,"lq"],[1927,"bl"],[1942,"qf"],[2089,"sj"],[2089,"ld"],[1978,"xx"],[1954,"dx"],[1982,"xh"],[2000,"dh"],[2082,"dh"]]
			If (result[4]=element[2]&&year=element[1])
				result[1]:=result[1]+1
		for section,element in [[2026,"ys"],[1918,"dz"],[2021,"dz"],[2019,"xh"]]
			If (result[4]=element[2]&&year=element[1])
				result[1]:=result[1]-1
		return result
	}else{
		return []
	}
}

;闰月判断
IsLeap(year){
	if(((Mod(year,4)=0)&&(Mod(year, 100)!=0))||Mod(year, 400)=0)
		Return 1
	Else
		Return 0
}


/*
	<参数>
		Gregorian: 公历日期 格式 YYYYMMDD
	;;T=1时以立春计生肖年，否则以春节为准,适用范围：1900年~2100年农历数据
	<返回结果集>：
		农历中文日期+农历干支+农历标准数字格式+农历生肖的新旧标准标识+节气+闰月月份
		说明：闰月月份不存在则返回空，
		          农历生肖的新旧标准标识：
			Old--以立春为界
			New--以春节为界
*/
;-------------------------公历转农历-公历日期「大写」-------------------------
/*
	<参数>
		Gregorian: 公历日期 格式 YYYYMMDD
	;;T=1时以立春计生肖年，否则以春节为准,适用范围：1900年~2100年农历数据
	<返回结果集>：
		农历中文日期+农历干支+农历标准数字格式+农历生肖的新旧标准标识+节气+闰月月份
		说明：闰月月份不存在则返回空，
		          农历生肖的新旧标准标识：
			Old--以立春为界
			New--以春节为界
*/
Date2LunarDate(Gregorian,T:=0) {
	If strlen(Gregorian)>4&&Mod(strlen(Gregorian),2) {
		If Gregorian~="0$"
			Gregorian:=strlen(Gregorian)=5?Gregorian 101:Gregorian 1
		else If Gregorian~="1$"
			Gregorian:=strlen(Gregorian)=5?Gregorian 001:Gregorian 0
	}
	;1899年~2100年农历数据
	;前三位，Hex，转Bin，表示当年月份，1为大月，0为小月	;第四位，Dec，表示闰月天数，1为大月30天，0为小月29天
	;第五位，Hex，转Dec，表示是否闰月，0为不闰，否则为闰月月份	;后两位，Hex，转Dec，表示当年新年公历日期，格式MMDD
	Isleap:=0, LunarData:=["AB500D2","4BD0883","4AE00DB","A5700D0","54D0581","D2600D8","D9500CC","655147D","56A00D5","9AD00CA","55D027A","4AE00D2"
		,"A5B0682","A4D00DA","D2500CE","D25157E","B5500D6","56A00CC","ADA027B","95B00D3","49717C9","49B00DC","A4B00D0","B4B0580"
		,"6A500D8","6D400CD","AB5147C","2B600D5","95700CA","52F027B","49700D2","6560682","D4A00D9","EA500CE","6A9157E","5AD00D6"
		,"2B600CC","86E137C","92E00D3","C8D1783","C9500DB","D4A00D0","D8A167F","B5500D7","56A00CD","A5B147D","25D00D5","92D00CA"
		,"D2B027A","A9500D2","B550781","6CA00D9","B5500CE","535157F","4DA00D6","A5B00CB","457037C","52B00D4","A9A0883","E9500DA"
		,"6AA00D0","AEA0680","AB500D7","4B600CD","AAE047D","A5700D5","52600CA","F260379","D9500D1","5B50782","56A00D9","96D00CE"
		,"4DD057F","4AD00D7","A4D00CB","D4D047B","D2500D3","D550883","B5400DA","B6A00CF","95A1680","95B00D8","49B00CD","A97047D"
		,"A4B00D5","B270ACA","6A500DC","6D400D1","AF40681","AB600D9","93700CE","4AF057F","49700D7","64B00CC","74A037B","EA500D2"
		,"6B50883","5AC00DB","AB600CF","96D0580","92E00D8","C9600CD","D95047C","D4A00D4","DA500C9","755027A","56A00D1","ABB0781"
		,"25D00DA","92D00CF","CAB057E","A9500D6","B4A00CB","BAA047B","AD500D2","55D0983","4BA00DB","A5B00D0","5171680","52B00D8"
		,"A9300CD","795047D","6AA00D4","AD500C9","5B5027A","4B600D2","96E0681","A4E00D9","D2600CE","EA6057E","D5300D5","5AA00CB"
		,"76A037B","96D00D3","4AB0B83","4AD00DB","A4D00D0","D0B1680","D2500D7","D5200CC","DD4057C","B5A00D4","56D00C9","55B027A"
		,"49B00D2","A570782","A4B00D9","AA500CE","B25157E","6D200D6","ADA00CA","4B6137B","93700D3","49F08C9","49700DB","64B00D0"
		,"68A1680","EA500D7","6AA00CC","A6C147C","AAE00D4","92E00CA","D2E0379","C9600D1","D550781","D4A00D9","DA400CD","5D5057E"
		,"56A00D6","A6C00CB","55D047B","52D00D3","A9B0883","A9500DB","B4A00CF","B6A067F","AD500D7","55A00CD","ABA047C","A5A00D4"
		,"52B00CA","B27037A","69300D1","7330781","6AA00D9","AD500CE","4B5157E","4B600D6","A5700CB","54E047C","D1600D2","E960882"
		,"D5200DA","DAA00CF","6AA167F","56D00D7","4AE00CD","A9D047D","A2D00D4","D1500C9","F250279","D5200D1"]

	;分解公历年月日
	Year:=SubStr(Gregorian,1,4), Month:=SubStr(Gregorian,5,2), Day:=SubStr(Gregorian,7,2)
	if (Year>2100 Or Year<1899)
		return,"无效日期"
	;获取两百年内的农历数据
	Pos:=Year-1900+2 
	Data0:=LunarData[Pos-1],Data1:=LunarData[Pos]
	;判断农历年份
	Analyze(Data1,MonthInfo,LeapInfo,Leap,Newyear)
	Date1:=Year Newyear, Date2:=Gregorian
	EnvSub,Date2,Date1,Days
	;msgbox % Date2 "-" Date1 "-" Days
	If Date2<0	;和当年农历新年相差的天数
	{
		Analyze(Data0,MonthInfo,LeapInfo,Leap,Newyear)
		Year-=1
		Date1:= Year Newyear, Date2:=Gregorian
		;;msgbox % Date1 "-" Date2 "-" Newyear
		EnvSub,Date2,%Date1%,Days
	}
	;计算农历日期
	Date2+=1
	LYear:=Year	;农历年份，就是上面计算后的值
	if Leap	;有闰月
		p1:=SubStr(MonthInfo,1,Leap) ,p2:=SubStr(MonthInfo,Leap+1), thisMonthInfo:=p1 . LeapInfo . p2
	Else
		thisMonthInfo:=MonthInfo
	;msgbox % MonthInfo "-" Date2 "-" p2
	loop,13
	{
		thisMonth:=SubStr(thisMonthInfo,A_index,1), thisDays:=29+thisMonth
		if (Date2>thisDays)
			Date2:=Date2-thisDays
		Else
		{
			if leap
			{
				If (leap>=A_index)
					LMonth:=A_index, Isleap:=0
				Else
					LMonth:=A_index-1, Isleap:=a_index-leap=1?1:0
			}Else
				LMonth:=A_index, Isleap:=0
			LDay:=Date2
			Break
		}
	}
	LDate:=LYear (strlen(LMonth)=1?0 LMonth:LMonth) (strlen(LDay)=1?0 LDay:LDay) 
	;;msgbox % LDate "-" thisMonth
	;转换成习惯性叫法
	Tiangan:=["甲","乙","丙","丁","戊","己","庚","辛","壬","癸"], Dizhi=["子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"]
	Shengxiao:=["鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"], yuefen:=["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
	rizi:=["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"]
	;;纳音表
	nyb:=["甲子","乙丑","丙寅","丁卯","戊辰","己巳","庚午","辛未","壬申","癸酉","甲戌","乙亥"
		,"丙子","丁丑","戊寅","己卯","庚辰","辛巳","壬午","癸未","甲申","乙酉","丙戌","丁亥"
		,"戊子","己丑","庚寅","辛卯","壬辰","癸巳","甲午","乙未","丙申","丁酉","戊戌","己亥"
		,"庚子","辛丑","壬寅","癸卯","甲辰","乙巳","丙午","丁未","戊申","己酉","庚戌","辛亥"
		,"壬子","癸丑","甲寅","乙卯","丙辰","丁巳","戊午","己未","庚申","辛酉","壬戌","癸亥"]
	StratSj:=[1900,11]  ;以1900年1月1日的干支位置为基准
	If T
	{
		If (Month=2&&Day<GetLunarJq(Gregorian)[1]&&LMonth=1||Month=1&&LMonth=1)
			LYear:=LYear-1
		else If (Month=2&&Day>=GetLunarJq(Gregorian)[1]&&LMonth=12)
			LYear:=LYear+1
	}
	Order1:=Mod((LYear-4),10)+1, Order2:=Mod((LYear-4),12)+1
	LunarYear:=Tiangan[Order1] . Dizhi[Order2] . "(" . Shengxiao[Order2] . ")年", LunarMonth:=yuefen[LMonth], LDay:=rizi[LDay]
	LunarDate:=LunarYear (Isleap?"(闰)" LunarMonth:LunarMonth) LDay, JqDate:=GetLunarJq(Gregorian,1), JqDate_:=JqDate[1]=SubStr(Gregorian,7,2)?JqDate[2]:""
	;;msgbox % LunarDate JqDate[2] JqDate_
	DateVar:=Gregorian
	EnvSub, DateVar, 19000101, days
	DayPos:= Mod(DateVar+StratSj[2],60), MonthPos:=GetLunarJq(Gregorian,1)[3]
	flag:=GetLunarJq(SubStr(Gregorian,1,4) 02 SubStr(Gregorian,7,2)), last:=02 (strlen(flag[1])<2?0 flag[1]:flag[1])
	If T {
		If (SubStr(Gregorian,5,4)>=last)
			GzYear:=Tiangan[Order1] . Dizhi[Order2] "年"
		else
			Order1:=Mod(((SubStr(Gregorian,1,4)-1)-4),10)+1, Order2:=Mod(((SubStr(Gregorian,1,4)-1)-4),12)+1, GzYear:=Tiangan[Order1] . Dizhi[Order2] "年"
		If (Order1=1||Order1=6)
			monthArr:=[nyb[3],nyb[4],nyb[5],nyb[6],nyb[7],nyb[8],nyb[9],nyb[10],nyb[11],nyb[12],nyb[13],nyb[14]]
		else If (Order1=2||Order1=7)
			monthArr:=[nyb[15],nyb[16],nyb[17],nyb[18],nyb[19],nyb[20],nyb[21],nyb[22],nyb[23],nyb[24],nyb[25],nyb[26]]
		else If (Order1=3||Order1=8)
			monthArr:=[nyb[27],nyb[28],nyb[29],nyb[30],nyb[31],nyb[32],nyb[33],nyb[34],nyb[35],nyb[36],nyb[37],nyb[38]]
		else If (Order1=4||Order1=9)
			monthArr:=[nyb[39],nyb[40],nyb[41],nyb[42],nyb[43],nyb[44],nyb[45],nyb[46],nyb[47],nyb[48],nyb[49],nyb[50]]
		else If (Order1=5||Order1=10)
			monthArr:=[nyb[51],nyb[52],nyb[53],nyb[54],nyb[55],nyb[56],nyb[57],nyb[58],nyb[59],nyb[60],nyb[1],nyb[2]]
		GzMonth:=monthArr[MonthPos] "月", GzDays:=nyb[DayPos] "日"
	}else{
		GzYear:=SubStr(LunarDate,1,2) "年"
		If (SubStr(Gregorian,5,4)>=last) {
			If ((SubStr(Gregorian,1,4) 0101)>SubStr(LDate,1,8)) {
				Order1+=1
			}
		}else{
			;msgbox % Order1 "-" (SubStr(Gregorian,1,4) 0101) "-" SubStr(LDate,1,8)
			If ((SubStr(Gregorian,1,4) 0101)<=SubStr(LDate,1,8)) {
				Order1-=1
			}
		}
		If (Order1=1||Order1=6)
			monthArr:=[nyb[3],nyb[4],nyb[5],nyb[6],nyb[7],nyb[8],nyb[9],nyb[10],nyb[11],nyb[12],nyb[13],nyb[14]]
		else If (Order1=2||Order1=7)
			monthArr:=[nyb[15],nyb[16],nyb[17],nyb[18],nyb[19],nyb[20],nyb[21],nyb[22],nyb[23],nyb[24],nyb[25],nyb[26]]
		else If (Order1=3||Order1=8)
			monthArr:=[nyb[27],nyb[28],nyb[29],nyb[30],nyb[31],nyb[32],nyb[33],nyb[34],nyb[35],nyb[36],nyb[37],nyb[38]]
		else If (Order1=4||Order1=9)
			monthArr:=[nyb[39],nyb[40],nyb[41],nyb[42],nyb[43],nyb[44],nyb[45],nyb[46],nyb[47],nyb[48],nyb[49],nyb[50]]
		else If (Order1=5||Order1=10)
			monthArr:=[nyb[51],nyb[52],nyb[53],nyb[54],nyb[55],nyb[56],nyb[57],nyb[58],nyb[59],nyb[60],nyb[1],nyb[2]]

		GzMonth:=monthArr[MonthPos] "月", GzDays:=nyb[DayPos] "日"
	}
	If strlen(Gregorian)>9
	{
		If (SubStr(Gregorian,9,2)=24)
			return Date2LunarDate(SubStr(Gregorian,1,8) 00,T)
		sijian:=SubStr(Gregorian,9,2), sj:=Mod(sijian,2)?Floor((sijian+3)/2):Floor((sijian+2)/2)
		loop,10
			If (Tiangan[a_index]=SubStr(GzDays,1,1))
				sj_:=a_index>5?a_index-5:a_index
		GzSichen:=nyb[(sj_-1)*12+sj]
	}
	GzDate:=GzYear GzMonth GzDays (strlen(Gregorian)>9?GzSichen "时":"")
	;;msgbox % LunarDate "`n" GzDate Isleap
	return [LunarDate,strlen(GzDate)>8?GzDate:"",LDate,T?"Old":"New",JqDate_,leap]

}

/*
<参数>
Lunar:
农历日期
IsLeap:
是否闰月
如，某年闰7月，第一个7月不是闰月，第二个7月是闰月，IsLeap=1
当年没有闰月这个参数无效
<返回值>
公历日期(YYYYDDMM)
*/
Date_GetDate(Lunar,IsLeap=0)
{
	;分解农历年月日
	StringLeft,Year,Lunar,4
	StringMid,Month,Lunar,5,2
	StringRight,Day,Lunar,2
	if substr(Month,1,1)=0
		StringTrimLeft,month,month,1
	if (Year>2100 Or Year<1900 or Month>12 or Month<1 or Day>30 or Day<1)
	{
		errorinfo=无效日期
		return,errorinfo
	}

	;1899年~2100年农历数据
	;前三位，Hex，转Bin，表示当年月份，1为大月，0为小月
	;第四位，Dec，表示闰月天数，1为大月30天，0为小月29天
	;第五位，Hex，转Dec，表示是否闰月，0为不闰，否则为闰月月份
	;后两位，Hex，转Dec，表示当年新年公历日期，格式MMDD
	LunarData=
	(LTrim Join
	AB500D2,4BD0883,
	4AE00DB,A5700D0,54D0581,D2600D8,D9500CC,655147D,56A00D5,9AD00CA,55D027A,4AE00D2,
	A5B0682,A4D00DA,D2500CE,D25157E,B5500D6,56A00CC,ADA027B,95B00D3,49717C9,49B00DC,
	A4B00D0,B4B0580,6A500D8,6D400CD,AB5147C,2B600D5,95700CA,52F027B,49700D2,6560682,
	D4A00D9,EA500CE,6A9157E,5AD00D6,2B600CC,86E137C,92E00D3,C8D1783,C9500DB,D4A00D0,
	D8A167F,B5500D7,56A00CD,A5B147D,25D00D5,92D00CA,D2B027A,A9500D2,B550781,6CA00D9,
	B5500CE,535157F,4DA00D6,A5B00CB,457037C,52B00D4,A9A0883,E9500DA,6AA00D0,AEA0680,
	AB500D7,4B600CD,AAE047D,A5700D5,52600CA,F260379,D9500D1,5B50782,56A00D9,96D00CE,
	4DD057F,4AD00D7,A4D00CB,D4D047B,D2500D3,D550883,B5400DA,B6A00CF,95A1680,95B00D8,
	49B00CD,A97047D,A4B00D5,B270ACA,6A500DC,6D400D1,AF40681,AB600D9,93700CE,4AF057F,
	49700D7,64B00CC,74A037B,EA500D2,6B50883,5AC00DB,AB600CF,96D0580,92E00D8,C9600CD,
	D95047C,D4A00D4,DA500C9,755027A,56A00D1,ABB0781,25D00DA,92D00CF,CAB057E,A9500D6,
	B4A00CB,BAA047B,AD500D2,55D0983,4BA00DB,A5B00D0,5171680,52B00D8,A9300CD,795047D,
	6AA00D4,AD500C9,5B5027A,4B600D2,96E0681,A4E00D9,D2600CE,EA6057E,D5300D5,5AA00CB,
	76A037B,96D00D3,4AB0B83,4AD00DB,A4D00D0,D0B1680,D2500D7,D5200CC,DD4057C,B5A00D4,
	56D00C9,55B027A,49B00D2,A570782,A4B00D9,AA500CE,B25157E,6D200D6,ADA00CA,4B6137B,
	93700D3,49F08C9,49700DB,64B00D0,68A1680,EA500D7,6AA00CC,A6C147C,AAE00D4,92E00CA,
	D2E0379,C9600D1,D550781,D4A00D9,DA400CD,5D5057E,56A00D6,A6C00CB,55D047B,52D00D3,
	A9B0883,A9500DB,B4A00CF,B6A067F,AD500D7,55A00CD,ABA047C,A5A00D4,52B00CA,B27037A,
	69300D1,7330781,6AA00D9,AD500CE,4B5157E,4B600D6,A5700CB,54E047C,D1600D2,E960882,
	D5200DA,DAA00CF,6AA167F,56D00D7,4AE00CD,A9D047D,A2D00D4,D1500C9,F250279,D5200D1
	)

	;获取当年农历数据
	Pos:=(Year-1899)*8+1
	StringMid,Data,LunarData,%Pos%,7

	;判断公历日期
	Analyze(Data,MonthInfo,LeapInfo,Leap,Newyear)
	;计算到当天到当年农历新年的天数
	Sum=0
	if Leap			;有闰月
	{
		StringLeft,p1,MonthInfo,%Leap%
		StringTrimLeft,p2,MonthInfo,%Leap%
		thisMonthInfo:=p1 . LeapInfo . p2
		if (Leap!=Month and IsLeap=1)
		{
			errorinfo=该月不是闰月
			return,errorinfo
		}
		if (Month<=Leap and IsLeap=0)
		{
			loop,% Month-1
			{
				StringMid,thisMonth,thisMonthInfo,%A_index%,1
				Sum:=Sum+29+thisMonth
			}
		}
		Else
		{
			loop,% Month
			{
				StringMid,thisMonth,thisMonthInfo,%A_index%,1
				Sum:=Sum+29+thisMonth
			}
		}
	}
	Else
	{
		loop,% Month-1
		{
			thisMonthInfo:=MonthInfo
			StringMid,thisMonth,thisMonthInfo,%A_index%,1
			Sum:=Sum+29+thisMonth
		}
	}
	Sum:=Sum+Day-1

	GDate=%Year%%NewYear%
	GDate+=%Sum%,days
	StringTrimRight,Gdate,Gdate,6
	return,Gdate
}

;分析农历数据的函数 按上面所示规则分析
;4个回参分别对应四项
Analyze(Data,ByRef rtn1,ByRef rtn2,ByRef rtn3,ByRef rtn4)
{
	;rtn1
	StringLeft,Month,Data,3
	rtn1:=System("0x" . Month,"H","B")
	if Strlen(rtn1)<12
		rtn1:="0" . rtn1

	;rtn2
	StringMid,rtn2,Data,4,1

	;rtn3
	StringMid,leap,Data,5,1
	rtn3:=System("0x" . leap,"H","D")

	;rtn4
	StringRight,Newyear,Data,2
	rtn4:=System("0x" . newyear,"H","D")
	if strlen(rtn4)=3
		rtn4:="0" . rtn4
}

Bin(x)
{                ;dec-bin
	while x
	r:=1&x r,x>>=1
	return r
}
Dec(x)
{                ;bin-dec
	b:=StrLen(x),r:=0
	loop,parse,x
	r|=A_LoopField<<--b
	return r
}
Dec_Hex(x)                ;dec-hex
{
	SetFormat, IntegerFast, hex
	he := x
	he += 0
	he .= ""
	SetFormat, IntegerFast, d
	Return,he
}
Hex_Dec(x)
{
	SetFormat, IntegerFast, d
	de := x
	de := de + 0
	Return,de
}

system(x,InPutType="D",OutPutType="H")
{
	if InputType=B
	{
		IF OutPutType=D
		r:=Dec(x)
		Else IF OutPutType=H
		{
			x:=Dec(x)
			r:=Dec_Hex(x)
		}
	}
	Else If InputType=D
	{
		IF OutPutType=B
		r:=Bin(x)
		Else If OutPutType=H
		r:=Dec_Hex(x)
	}
	Else If InputType=H
	{
		IF OutPutType=B
		{
			x:=Hex_Dec(x)
			r:=Bin(x)
		}
		Else If OutPutType=D
		r:=Hex_Dec(x)
	}
	Return,r
}