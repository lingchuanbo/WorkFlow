
(function(me){

	var rbIndex = 4;
	//-------------------------------------------------------------------------
	var winObj = ( me instanceof Panel) ? me : new Window("palette", "批项目设置 Mod:BoBO", [ 0,  -60,  144,  190]  ,{resizeable:true, maximizeButton:true, minimizeButton:true});

	//-------------------------------------------------------------------------
	var btnGetSize = winObj.add("button", [   5,    5,    5+ 140,    5+  24], "获取" );
	btnGetSize.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var stWidth = winObj.add("statictext", [  13,   43,   13+  32,   43+  18], "宽");
	stWidth.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var stHeight = winObj.add("statictext", [  13,   72,   13+  32,   72+  18], "高");
	stHeight.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var stFps = winObj.add("statictext", [  13,   100,   13+  32,   100+  18], "帧率");
	stFps.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var stDuration = winObj.add("statictext", [  13,   130,   13+  32,   130+  18], "时长");
	stDuration.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var edWidth = winObj.add("edittext", [  50,   40,   50+  95,   40+  21], "");
	edWidth.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var edHeight = winObj.add("edittext", [  50,   70,   50+  95,   70+  21], "");
	edHeight.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var edFps = winObj.add("edittext", [  50,   100,   50+  95,   100+  21], "");
	edFps.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var edDuration = winObj.add("edittext", [  50,   130,   50+  95,   130+  21], "");
	edDuration.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	var stPos = winObj.add("statictext", [  13,   158,   13+  32,   158+  18], "Position");
	var rb = [];
	rb.push( winObj.add("radiobutton", [  57,   157,   57+  15,   157+  15], ""));
	rb.push( winObj.add("radiobutton", [  78,   157,   78+  15,   157+  15], ""));
	rb.push( winObj.add("radiobutton", [  99,   157,   99+  15,   157+  15], ""));
	rb.push( winObj.add("radiobutton", [  57,  178,   57+  15,  178+  15], ""));
	rb.push( winObj.add("radiobutton", [  78,  178,   78+  15,  178+  15], ""));
	rb.push( winObj.add("radiobutton", [  99,  178,   99+  15,  178+  15], ""));
	rb.push( winObj.add("radiobutton", [  57,  199,   57+  15,  199+  15], ""));
	rb.push( winObj.add("radiobutton", [  78,  199,   78+  15,  199+  15], ""));
	rb.push( winObj.add("radiobutton", [  99,  199,   99+  15,  199+  15], ""));

	var btnSetSize = winObj.add("button", [   5,  220,    5+ 140, 220+  24], "应用" );
	btnSetSize.graphics.font = ScriptUI.newFont("Tahoma",ScriptUI.FontStyle.REGULAR, 11);

	rb[rbIndex].value = true;
	
	//-------------------------------------------------------------------------
	function dispRbIndex()
	{
		var s = "Position";
		switch(rbIndex)
		{
			case 0: s ="左上"; break;
			case 1: s ="中上"; break;
			case 2: s ="左上"; break;
			case 3: s ="左中"; break;
			case 4: s ="中间"; break;
			case 5: s ="右中"; break;
			case 6: s ="左下"; break;
			case 7: s ="中下"; break;
			case 8: s ="右下"; break;
		}
		stPos.text = s;
	}
	//-------------------------------------------------------------------------
	for ( var i=0; i<rb.length; i++){
		rb[i].idx = i;
		rb[i].onClick = function()
		{
			rbIndex = this.idx;
			dispRbIndex();
		}
	}
	dispRbIndex();

	//-------------------------------------------------------------------------
	function resizeWin()
	{
		var b = winObj.bounds;
		var w = b.width -10;
		var gb = btnGetSize.bounds;
		gb.width = w;
		btnGetSize.bounds = gb;
		
		var wb = edWidth.bounds;
		wb.width = w - 45;
		edWidth.bounds = wb;

		var hb = edHeight.bounds;
		hb.width = w -45;
		edHeight.bounds = hb;

		var fps = edFps.bounds;
		fps.width = w -45;
		edFps.bounds = fps;

		var duration = edDuration.bounds;
		duration.width = w -45;
		edDuration.bounds = duration;
		
		var sb = btnSetSize.bounds;
		sb.width = w;
		btnSetSize.bounds = sb;
	}
	resizeWin();
	winObj.onResize = resizeWin;
	//-------------------------------------------------------------------------
	function getComp()
	{
		var ret = [];
		var sl = app.project.selection;
		if ( sl.length>0){
			for ( var i=0; i<sl.length; i++){
				if ( sl[i] instanceof CompItem) {
					ret.push(sl[i]);
				}
				//判断是否选中素材
				if ( sl[i] instanceof FootageItem) {
                    ret.push(sl[i]);
				}

			}
		}
		return ret;
	}
	//-------------------------------------------------------------------------
//合成获取frameDuration
	function getCompSize()
	{
		var lst = getComp();
		var fpss=1/lst[0].frameRate
		if ( lst.length==1){
			
			edWidth.text = lst[0].width +""; //宽
			edHeight.text = lst[0].height +""; //高
			edFps.text = lst[0].frameRate +""; //帧率
			edDuration.text =lst[0].duration * lst[0].frameRate +""; //合成时间
		}
		
	}
//素材获取
	function getFootage()
	{
		var lst = getComp();
		if ( lst.length==1){
			
			edFps.text = lst[0].mainSource.conformFrameRate  +""; //素材帧率
		
		}
	}

//合成素材分流处理
function getCompFootage()
	{
		var sl = app.project.selection;
		if ( sl.length==1){
			for ( var i=0; i<sl.length; i++){
				if ( sl[i] instanceof CompItem) {
					getCompSize()
				}

				if ( sl[i] instanceof FootageItem) {
					getFootage()
				}
			}
		}
		if ( sl.length==0){
			alert("请选择对象吧");
		}
		if ( sl.length>1){
			alert("获取有点多 我迷失了，你可以选择一个试试！");
		}
	}


	// btnGetSize.onClick = getCompSize;
	btnGetSize.onClick = getCompFootage;


	//-------------------------------------------------------------------------
	// if ( ( me instanceof Panel) == false){
	// 	var lst = getComp();
	// 	if ( lst.length>0){
	// 		edWidth.text = lst[0].width +"";
	// 		edHeight.text = lst[0].height +"";
	// 		edFps.text = lst[0].frameRate +"";
	// 		edDuration.text =lst[0].duration +""; 
	// 	}
	// }
	//-------------------------------------------------------------------------
	function setCompSizeSub(cmp,w,h,p)
	{
		if ( (cmp.width == w)&&(cmp.height == h)) return;
		
		var addPos = [0,0,0];
		var aw = w - cmp.width;
		var ah = h - cmp.height;
		
		switch(p)
		{
			case 0:
				addPos[0] = 0;
				addPos[1] = 0;
				break; // そのまま
			case 1:
				addPos[0] = aw/2;
				addPos[1] = 0;
				break;
			case 2:
				addPos[0] = aw;
				addPos[1] = 0;
				break;

			case 3:
				addPos[0] = 0;
				addPos[1] = ah/2;
				break;
			case 4:
				addPos[0] = aw/2;
				addPos[1] = ah/2;
				break;
			case 5:
				addPos[0] = aw;
				addPos[1] = ah/2;
				break;

			case 6:
				addPos[0] = 0;
				addPos[1] = ah;
				break;
			case 7:
				addPos[0] = aw/2;
				addPos[1] = ah;
				break;
			case 8:
				addPos[0] = aw;
				addPos[1] = ah;
				break;
		}

		cmp.width = w;
		cmp.height = h;

		if ( cmp.numLayers>0){
			for ( var i=1; i<=cmp.numLayers; i++){
				var lyr = cmp.layer(i);
				if ( lyr.parent == null) {
					var pos = lyr.property("ADBE Transform Group").property("ADBE Position");
					if ( pos.numKeys==0){
						var pp = pos.value;
						pp[0] += addPos[0];
						pp[1] += addPos[1];
						pos.setValue(pp);
					}else{
						for ( var i=1; i<=pos.numKeys; i++)
						{
							var pp = pos.keyValue(i);
							pp[0] += addPos[0];
							pp[1] += addPos[1];
							pos.setValueAtKey(i,pp);
						}
					}
				}
			}
		}
	}
	//-------------------------------------------------------------------------
	function setCompSize()
	{
		var w = 0;
		var h = 0;
		var f = 0;

		try{
			w = eval(edWidth.text);
		}catch(e){
			alert("为空或者不是数字");
			return;
		}
		if (typeof(w) != "number"){
			alert("为空或者不是数字");
			return;
		}

		try{
			h = eval(edHeight.text);
		}catch(e){
			alert("为空或者不是数字");
			return;
		}
		if (typeof(h) != "number"){
			alert("为空或者不是数字");
			return;
		}

		try{
			f = eval(edFps.text);
		}catch(e){
			alert("为空或者不是数字");
			return;
		}
		if (typeof(f) != "number"){
			alert("为空或者不是数字");
			return;
		}

		try{
			d = eval(edDuration.text);
		}catch(e){
			alert("为空或者不是数字");
			return;
		}
		if (typeof(d) != "number"){
			alert("为空或者不是数字");
			return;
		}

		var p = rbIndex;
		if ( (p<0)||(p>=9)) {
			p = 4;
			rbIndex = p;
			dispRbIndex();
		}
		var lst = getComp();
		if ( lst.length>0){
			app.beginUndoGroup("コンポサイズ変更");
			for ( var i=0; i<lst.length; i++){
				setCompSizeSub(lst[i],w,h,p);
				lst[i].frameRate=f;
				lst[i].duration=d/f;
			}
			app.endUndoGroup();
		}else{
			alert("コンポを選んでください");
		}
	}

	function setFootage()
	{
		var f = 0;
		try{
			f = eval(edFps.text);
		}catch(e){
			alert("为空或者不是数字");
			return;
		}
		if (typeof(f) != "number"){
			alert("为空或者不是数字");
			return;
		}
		if(f > 999){
			alert("超了")
		}

		var lst = getComp();
		if ( lst.length>0){
			app.beginUndoGroup("コンポサイズ変更");
			for ( var i=0; i<lst.length; i++){
				lst[i].mainSource.conformFrameRate=f;
			}
			app.endUndoGroup();
		}else{
			alert("コンポを選んでください");
		}
	}


//合成素材分流处理
function setCompFootage()
	{
		try{
			var sl = app.project.selection;
			if ( sl.length>0){
				for ( var i=0; i<sl.length; i++){
					if ( sl[i] instanceof CompItem) {
						setCompSize()
					}
	
					if ( sl[i] instanceof FootageItem) {
						setFootage()
					}
				}
			}
			else{
				alert("请选择一个或多个合成组&素材！");
			}
		}catch(e){
			alert("1.不能混搭修改，合成是合成，素材是素材,\n2.数字不要那么任性,超出AE的设定\n 宽高最大99999 帧率最大999");
			return;
		}
	}
	// btnSetSize.onClick = setCompSize;
	btnSetSize.onClick = setCompFootage;
	//-------------------------------------------------------------------------
	if ( ( me instanceof Panel) == false){
		winObj.center(); 
		winObj.show();
	}
	//-------------------------------------------------------------------------
})(this);