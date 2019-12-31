//作者：阿木亮	邮箱：982632988@qq.com	日期：2015/2/12
			



var magicCube = {
	language: 1,
	currentComp: null,
	distance: 100,//方块之间的间隔
	facelayers: [],//用来存储选取的图层，0为内部纹理，1-6为六个面的纹理
	faceComps: [],//用来存储作为纹理的合成，0为内部纹理，1-6为六个面的纹理
	cubes: [],//用来存储方块cube对象
	number: 3,//魔方的阶数
	cube: function() {
		this.id;
		this.currentP = [0, 0, 0];
		this.P0 = 0;
		this.P1 = 0;
		this.P2 = 0;
		this.rotation = [0, 0, 0];
		this.size = [100, 100, 100];
		this.cubeLayer = null;
		this.cubeNull = null;
	}
}
//
magicCube.en_str = {
	win: {
		title: 'Magic Cube',
		left: {
			title: 'Texture',
			face: ['Inside', 'Front', 'Back', 'Top', 'Bottom', 'Left', 'Right'],
			refresh: 'Refresh',
		},
		right: {
			top: {
				title: 'Create',
				name: 'Name',
				tier: 'Tier',
				size: 'Size',
				depth: 'Depth',
				duration: 'Duration',
				stroke: 'Stroke',
				blur: 'MotionBlur',
				create: 'Create',
				get: 'Get',
			},
			bottom: {
				title: 'Animation',
				step: 'Step(id,start,end,multiple)',
				create: 'Create',
			},
		},
		alert1: 'Parameter format of the input is not correct',
		alert2: 'Order magic number is a positive integer',
		alert3: 'The depth is positive integer',
		alert4: 'Texture layers invalid',
		alert5: 'The cube is invalid, please re create a cube',
		alert6: '下次打开该脚本时设置生效',
		alert7: 'Please make sure that the start time is less than the end time',
		alert8: 'The multiple is positive integer',
		alert9: 'Existing time overlap on different directions',
		alert10: ['Get ', ' successfully!'],
		alert11: 'Unsuccessfully!',
	},
	help: {
		title: 'help',
		txt: "    This script can create a magic cube, may realize from the one tier (of course only a cube box) to any tier, and can do rotation animation. And the small cube block is independent, You can do modify further on the basis of the exiting magic  cube animation.\
\
Operation steps:\
\
1. Specify texture. Click the Refresh button, the drop-down menus will display the current comp layers, and if there is selected layers in the current comp only read the selected layer\
\
2. Create a magic cube. You can set the following parameters:\
    *Name\
    *Tier (positive integer)\
    *Size (positive integer, attention to it is  the size of  little cubes)\
    *Depth (the layer series from the outside to the inside , sometimes  the small block inside can not see , there is not have to establish internal block, then you can set the Depth to 1)\
    *Duration\
    *Stroke (find the faces folder in the project panel, change the stroke width and color in stroke comp)\
    *MotionBlur\
    Create a cube, you can modify the block size and distance in effect panel of  the contral layer, you can also find the texture comp in the faces folder and change the texture\
    And you can get the created cube by Get button\
\
3. Create animation. Pay attention to the rotation step writing formats (see the help (? Button)). You can repeat the animation, until the next cube is created\
\
\
Authors: Amuliang\
E-mail: 982632988@qq.com",
	},
	stepHelp: {
		title: 'writing forms',
		txt: "Input rotation steps in the text box. Pay attention to the following format problems:\
\
Single step writing format: ID, start, end, multiple\
\
Separate properties with a comma ','\
\
*id: integer. This is the mark of rotating ranks, arrayed from front to the back, from top to bottom, from left to right. such as the 3x3 cube, ID for 1-9, 1-3 is from front to back , 4-6 is from top to bottom, 7-9 is from left to right. 4x4 cube’s ID is 1-12. If there is a prefix '-', represent  counterclockwise, Otherwise represent clockwise, based on the front, top, left.\
For convenience, you can add a suffix. you can add the suffix for the f or F (front's first letter),t or T (top's first letter), l or L (left's first letter). Such as the 3x3 cube, if the suffix for the F, 2f=2, if the suffix for the T, 2t=3+2=5, if the suffix for the L, 2L=3+3+2=8\
\
*start: float, in seconds. If the prefix is '+', for the accumulation, the value is the last step's end plus this step's start\
\
*end: float, in seconds. If the prefix plus '+', for the accumulation, the value is start plus end\
\
*multiple: optional integer. The default rotation angle of per step is 90 degrees, if the given this parameter the rotation is 90 multiplied by the multiple\
\
Except 'space' ',' '.' '+' '-' '0-9' 'ftlFTL', you can use any character to separate the steps, as follows\
\
The square brackets: [-3t, 1,3] [2t, 1,2,2]\
Brackets: (-3f, 1,2.5) (2L, +1, +2)\
Enter:\
-3t, 1,2\
2L, +1, +1,3\
\
In which you can add notes, the script will automatically remove the invalid characters or steps.",
	},
	contralEffect: [
		['dispersion', 'ADBE Slider Control', 0],
		['scale', 'ADBE Slider Control', 100]
	],
	expression: {
		try_str: ['try{\n', '\n}catch(err){\nvalue;\n}'],
		anchorPoint: 'd = parent.effect("dispersion")(1);\nvalue*(1 + d/100);',
		scale: 's = parent.parent.effect("scale")(1);\nvalue*s/100;'
	}

}

magicCube.cn_str = {
	win: {
		title: 'Magic Cube',
		left: {
			title: '纹理',
			face: ['内部', '前', '后', '上', '下', '左', '右'],
			refresh: '刷新',
		},
		right: {
			top: {
				title: '创建',
				name: '名称',
				tier: '阶数',
				size: '尺寸',
				depth: '深度',
				duration: '持续时间',
				stroke: '描边',
				blur: '运动模糊',
				create: '创建',
				get: '获取',
			},
			bottom: {
				title: '动画',
				step: '步骤(id,时间,倍率)',
				create: '创建',
			},
		},
		alert1: '参数格式输入不正确',
		alert2: '魔方阶数为正整数',
		alert3: '深度为正整数',
		alert4: '无效的纹理图层',
		alert5: '魔方无效，请重新建立魔方',
		alert6: 'The setting will take effect the next time you start the script',
		alert7: '请确保开始时间点小于结束时间点',
		alert8: '倍率为正整数',
		alert9: '不同方向上存在时间穿插',
		alert10: ['获取 ', ' 成功！'],
		alert11: '获取失败！',
	},
	help: {
		title: '帮助',
		txt: "    该脚本为创建魔方脚本，可实现从一阶（当然仅为一个正方体盒子）到任意阶魔方的创建，并可以做旋转动画，且魔方小物块独立，您可以在已有魔方动画基础上对魔方进行进一步的动画修改。\
\
操作步骤：\
\
1.指定纹理。点击刷新按钮，下拉菜单中将会显示当前合成中图层，如果当前合成中存在被选中图层则只读取选中图层\
\
2.创建魔方。您可设置以下参数：\
    *名字\
    *阶数（正整数）\
    *尺寸（正整数，注意为魔方小方块的尺寸）\
    *深度（正整数，即为从外向内的层级数，有时内部小物块看不到则无需建立内部物块，这时可以设置深度为1）\
    *持续时间\
    *描边（在项目面板中生成的文件夹中找到faces文件夹，在描边（stroke）中可以更改描边的宽度和颜色）\
    *运动模糊\
    创建魔方后，在总合成的contral图层的效果面板中可以修改物块间距和大小，您也可以在faces文件夹下找到纹理图层并更换纹理\
    点击获取可以获取曾经创建过得魔方\
\
3.创建动画。创建动画的魔方基于最新生成的魔方，注意旋转步骤的书写格式（详见其帮助（？按钮）），动画可重复修改，但是创建下一个魔方后上一个魔方动画将不可修改\
\
作者：阿木亮\
邮箱：982632988@qq.com",
	},
	stepHelp: {
		title: '书写格式',
		txt: "该文本框输入旋转步骤，需要注意以下格式问题：\
\
单步书写格式为：id,开始,结束,倍率\
\
参数间以英文状态下逗号“,”隔开\
\
*id：整数。此为旋转行列的标记，按照从前到后，从上到下，从左到右的顺序排序，例如3x3的魔方，id为1-9，1-3位从前到后的三层，4-6位从上到下的三层，7-9位从左到右的三层，4x4魔方的id则为1-12。id前加负号“-”，则为逆时针，否则为顺时针，以前上左三个方向为准。\
为书写方便，可以在id后加一后缀，可添加后缀为f或F（front首字母），t或T（top首字母），l或L（left首字母），以三阶魔方为例，如果后缀为f，2f=2，如果后缀为t，2t=3+2=5，如果后缀为L，2L=3+3+2=8\
\
*开始：浮点数，单位为秒。如果前缀为正号“+”，为累加，则该时间点为上一步结束时间点与该数值的和\
\
*结束：浮点数，单位为秒。如果前缀为正号“+”，为累加，则该时间点为开始时间点与该数值的和\
\
*倍率：可选正整数。单步默认旋转角度为90度，如果给定倍率参数则单步旋转角度为90乘倍率所得数值\
\
每一步之间可以用除空格“ ”逗号“,”句号“.”加号“+”减号“-”数字“0-9”及字母“ftlFTL”外的任何字符分隔，如下\
\
中括号：[-3t,1,3] [2t,1,2,2]\
括号：(-3f,1,2.5) (2L,+1,+2)\
回车：\
-3t,1,2\
2L,+1,+1,3\
\
可以在其中加入注释，脚本将自动将无效字符或步骤排除",
	},
	contralEffect: [
		['分散度', 'ADBE Slider Control', 0],
		['缩放', 'ADBE Slider Control', 100]
	],
	expression: {
		try_str: ['try{\n', '\n}catch(err){\nvalue;\n}'],
		anchorPoint: 'd = parent.effect("分散度")(1);\nvalue*(1 + d/100);',
		scale: 's = parent.parent.effect("缩放")(1);\nvalue*s/100;'
	}

}
//
magicCube.win = function (obj) {
	var str = this.str.win;
	{//界面
	var newWin =(obj instanceof Panel)? obj : new Window('window', str.title, undefined, {resizeable: true});
	var g = newWin.winGroup = newWin.add(
		"Group{\
			alignment:['fill','fill'],\
			orientation: 'row',\
			left: Panel{\
				alignment:['left','fill'],\
				alignChildren :['fill','top'],\
				refresh: Button{},\
			},\
			right: Group{\
				alignment:['fill','fill'],\
				orientation: 'column',\
				top: Panel{\
					alignment:['fill','top'],\
					alignChildren :['fill','top'],\
					orientation: 'column',\
					r1: Group{\
						alignChildren :['left','center'],\
						orientation: 'row',\
						nameS: StaticText{},\
						name: EditText{text: 'Magic Cube', alignment:['fill','center'], size: [200, 20]},\
						help: Button{text: '?', alignment:['right','center'], size: [15, 20]},\
					},\
					r2: Group{\
						alignChildren :['left','center'],\
						orientation: 'row',\
						tierS: StaticText{},\
						tier: EditText{text: '3', size: [50, 20]},\
						sizeS: StaticText{},\
						size_: EditText{text: '100', size: [50, 20]},\
						depthS: StaticText{},\
						depth: EditText{text: '1', size: [50, 20]},\
					},\
					r3: Group{\
						alignChildren :['left','center'],\
						orientation: 'row',\
						durationS: StaticText{},\
						duration: EditText{text: '30', size: [50, 20]},\
					},\
					r4: Group{\
						alignChildren :['left','center'],\
						orientation: 'row',\
						strokeS: Checkbox{},\
						strokeSize: EditText{text: '10', size: [50, 20]},\
						blur: Checkbox{},\
					},\
					r5: Group{\
						alignChildren :['left','center'],\
						orientation: 'row',\
						createM: Button{},\
						getM: Button{},\
					},\
				},\
				bottom: Panel{\
					alignment:['fill','fill'],\
					orientation: 'column',\
					r1: Group{\
						alignment:['fill','top'],\
						stepS: StaticText{alignment:['left','center'],},\
						help: Button{text: '?', alignment:['right','center'], size: [15, 20]},\
					},\
					r2: Group{\
						alignment:['fill','fill'],\
						alignChildren :['fill','fill'],\
					},\
					r3: Group{\
						alignment:['fill','bottom'],\
						alignChildren :['left','center'],\
						orientation: 'row',\
						createC: Button{},\
					},\
				},\
			},\
		}"
	);
	
	//纹理组
	var left = g.left;
	var leftStr = str.left;
	left.text = leftStr.title;
	var refresh = left.refresh;
	refresh.text = leftStr.refresh;
	var faces = [];
	var faceStr = leftStr.face;
	for(var i = 0; i < faceStr.length; i++) {
		var r = left.add('group');
		r.alignChildren = ['left','center'];
		r.add('statictext', undefined, faceStr[i]);
		var d = r.add('DropDownList');
		d.alignment = ['right','center'];
		d.size = [100, 20];
		faces.push(d);
	}
	//创建组
	var top = g.right.top;
	var topStr = str.right.top;
	top.text = topStr.title;
	top.r1.nameS.text = topStr.name;
	var name = top.r1.name;
	var help = top.r1.help;
	top.r2.tierS.text = topStr.tier;
	var tier = top.r2.tier;
	top.r2.sizeS.text = topStr.size;
	var size = top.r2.size_;
	top.r2.depthS.text = topStr.depth;
	var depth = top.r2.depth;
	top.r3.durationS.text = topStr.duration;
	var duration = top.r3.duration;
	var isStroke = top.r4.strokeS;
	isStroke.text = topStr.stroke;
	isStroke.value = true;
	var stroke = top.r4.strokeSize;
	var blur = top.r4.blur;
	blur.text = topStr.blur;
	var createM = top.r5.createM;
	createM.text = topStr.create;
	var getM = top.r5.getM;
	getM.text = topStr.get;
	//动画组
	var bottom = g.right.bottom;
	var bottomStr = str.right.bottom;
	bottom.text = bottomStr.title;
	bottom.r1.stepS.text = bottomStr.step;
	var stepHelp = bottom.r1.help;
	var step = bottom.r2.step = bottom.r2.add('edittext', undefined, '', {multiline:1});
	if(app.settings.haveSetting(magicCube.scriptName, 'step')) {
		step.text = app.settings.getSetting(magicCube.scriptName, 'step');
	}else {
		step.text = 'example: [2,0,1] [-3t,+1,+1,2]';
	}
	var createC = bottom.r3.createC;
	createC.text = bottomStr.create;
	}

	//事件
	refresh.onClick = function() {
		if(!magicCube.getSelectedLayers()) {
			return false;
		}
		var layers = [];
		var n = magicCube.faceLayers.length;
		if(n > 0) {
			layers = magicCube.faceLayers;
			layers.unshift(0);
		}else {
			layers = magicCube.currentComp.layers;
			n = layers.length;
		}
		for(var i = 0; i < faces.length; i++) {
			faces[i].removeAll();
			for(var j = 1; j <= n; j++) {
				var item = faces[i].add('item', layers[j].name);
				item.layer = layers[j];
			}
			faces[i].selection = i < n ? i : n-1;
		}
	}

	createM.onClick = function() {
		if(!magicCube.isNumber(tier.text) || !magicCube.isNumber(size.text) || !magicCube.isNumber(stroke.text) || !magicCube.isNumber(depth.text) || !magicCube.isNumber(duration.text)) {
			alert(str.alert1);
			return false;
		}
		if(parseInt(tier.text) < 1) {
			alert(str.alert2);
			return false;
		}
		if(parseInt(depth.text) < 1) {
			alert(str.alert3);
			return false;
		}
		var faces_ = [];
		for(var i = 0; i < faces.length; i++) {
			if(faces[i].selection == null || !isValid(faces[i].selection.layer)) {
				alert(str.alert4);
				return false;
			}
			faces_.push(faces[i].selection.layer);
		}
		magicCube.number = parseInt(tier.text);
		magicCube.distance = parseInt(size.text);
		magicCube.duration = parseFloat(duration.text);
		magicCube.blur = blur.value;
		
		app.beginUndoGroup(name.text);
		try{
			magicCube.createCube(name.text, parseInt(tier.text), parseInt(size.text), isStroke.value, parseFloat(stroke.text), parseInt(depth.text), faces_);
		}catch(err){
			alert(err);
		}
		app.endUndoGroup();
	}

	getM.onClick = function() {
		var selection = app.project.selection;
		var aItem = app.project.activeItem;
		
		if(selection.length > 0) {
			var cubeComp = selection[0];
			if(cubeComp instanceof CompItem && magicCube.getMagicCube(cubeComp)) {
				alert(str.alert10[0] + cubeComp.name + str.alert10[1]);
			}
		}else if(aItem instanceof CompItem && magicCube.getMagicCube(aItem)){
			alert(str.alert10[0] + aItem.name + str.alert10[1]);
		}else if(aItem instanceof CompItem) {
			var sl = aItem.selectedLayers;
			if(sl.length > 0 && sl[0].source instanceof CompItem && magicCube.getMagicCube(sl[0].source)) {
				alert(str.alert10[0] + sl[0].source.name + str.alert10[1]);
			}
		}else {
			alert(str.alert11);
		}
	}

	createC.onClick = function() {
		var stepSplited = step.text.split(/[^ftlFTL\d\+\-\,\.\ ]+/);//初步分割
		var steps = [];
		var finalStep = [[0,0,0]];
		for(var i = 0; i < stepSplited.length; i++) {//筛选有元素
			if(magicCube.isNumber(stepSplited[i])) {
				steps.push(stepSplited[i]);
			}
		}
		for(var i = 0; i < steps.length; i++) {//有效元素中筛选有效值
			var s = steps[i].split(',');
			var ss = [];
			for(var j = 0; j < s.length; j++) {
				if(magicCube.isNumber(s[j])) {
					ss.push(s[j]);
				}
			}
			if(ss.length == 3 || ss.length == 4) {//筛选有效步骤
				var mth = ss[0].match(/[ftlFTL]/);//验证第一个参数
				if(mth) {
					var sign = parseInt(ss[0]) > 0 ? 1:-1;
					ss[0] = parseInt(ss[0]);
					if(String(mth).match(/[tT]/)) {
						ss[0] = parseInt(ss[0]) + sign*magicCube.number;
					}else if(String(mth).match(/[lL]/)) {
						ss[0] = parseInt(ss[0]) + sign*2*magicCube.number;
					}
				}
				//验证第二三个参数
					var tstep = [];
					var l = finalStep.length;
					if(l>0) {
						if(ss[1].match(/\+/)) {
							ss[1] = parseFloat(finalStep[l-1][finalStep[l-1].length-1][1]) + parseFloat(ss[1]);
						}
						if(ss[2].match(/\+/)) {
							ss[2] = parseFloat(ss[2]) + parseFloat(ss[1]);
						}
					}
					if(parseFloat(ss[2])<=parseFloat(ss[1])) {
						alert(str.alert7);
						return false;
					}
					tstep.push([0, parseFloat(ss[1])]);
					if(ss.length == 3) {
						tstep.push([ss[0], parseFloat(ss[2])]);
					}else {//处理第四个参数
						var n = parseInt(ss[3]);
						if(n < 1) {
							alert(str.alert8);
							return false;
						}
						for(var k = 1; k <= n; k++) {
							tstep.push([ss[0], parseFloat(ss[1]) + k*(ss[2]-ss[1])/n]);
						}
					}
					finalStep.push(tstep);
			}
		}
		
		if(!check(finalStep)) {
			alert(str.alert9);
			return false;
		}
		
		app.beginUndoGroup(bottomStr.create);
		try{
			magicCube.rotateCube(magicCube.cubes, finalStep);
		}catch(err){
			alert(err);
		}
		app.endUndoGroup();
		
		app.settings.saveSetting(magicCube.scriptName, 'step', step.text);//暂时保存文本内容在ae中
		
		function check(finalSteps) {//用来验证不同方向上有没有时间重叠
			var ori = [[[0,0]], [[0,0]], [[0,0]]];
			var n = magicCube.number;
			for(var i = 0; i < finalSteps.length; i++) {
				var finalStep = finalSteps[i];
				for(var j = i; j >= 0; j--) {
					if(Math.floor((Math.abs(finalStep[1][0])-1)/n) != Math.floor((Math.abs(finalSteps[j][1][0])-1)/n)) {
						if(finalStep[0][1] < finalSteps[j][finalSteps[j].length-1][1]) {
							return false;
						}
						for(var k = j; k >= 0; k--) {
							if(Math.floor((Math.abs(finalSteps[k][1][0])-1)/n) == Math.abs((Math.floor(finalSteps[j][1][0])-1)/n)) {
								if(finalStep[0][1] < finalSteps[k][finalSteps[j].length-1][1]) {
									return false;
								}
							}else {
								break;
							}
						}
					}
				}
				for(var j = i; j < finalSteps.length; j++) {
					if(Math.floor((Math.abs(finalStep[1][0])-1)/n) != Math.floor((Math.abs(finalSteps[j][1][0])-1)/n)) {
						if(finalStep[finalStep.length-1][1] > finalSteps[j][0][1]) {
							return false;
						}
						for(var k = j; k < finalSteps.length; k++) {
							if(Math.floor((Math.abs(finalSteps[k][1][0])-1)/n) == Math.floor((Math.abs(finalSteps[j][1][0])-1)/n)) {
								if(finalStep[finalStep.length-1][1] > finalSteps[k][0][1]) {
									return false;
								}
							}else {
								break;
							}
						}
					}
				}
			}
			return true;
		}
	}
	
	help.onClick = function() {
		var hstr = magicCube.str.help;
		var scriptLang = magicCube.language;
		
		var helpWin = magicCube.helpWin = new Window('palette', hstr.title, undefined);
		helpWin.margins = 0;
		helpWin.spacing = 2;
		helpWin.preferredSize = [400, 400];
		var lang = helpWin.add('dropdownlist', undefined, ['English', '中文']);
		lang.alignment = ['left', 'top'];
		lang.selection = scriptLang;
		var txt = helpWin.add('edittext', undefined, '', {multiline:1, readonly:1});
		txt.alignment = ['fill', 'fill'];
		txt.text = hstr.txt;
		
		lang.onChange = function() {
			var index = lang.selection.index;
			if(index == scriptLang) {
				return;
			}
			app.settings.saveSetting(magicCube.scriptName, 'language', index);
			var alert6 = index==1 ? magicCube.en_str.win.alert6:magicCube.cn_str.win.alert6;
			alert(alert6);
		}
		
		helpWin.center();
		helpWin.show();
	}

	stepHelp.onClick = function() {
		var hstr = magicCube.str.stepHelp;
		var stepHelpWin = magicCube.stepHelpWin = new Window('palette', hstr.title, undefined);
		stepHelpWin.margins = 0;
		stepHelpWin.preferredSize = [400, 400];
		var txt = stepHelpWin.add('edittext', undefined, '', {multiline:1, readonly:1});
		txt.alignment = ['fill', 'fill'];
		txt.text = hstr.txt;
		
		stepHelpWin.center();
		stepHelpWin.show();
	}
	
	newWin.layout.layout(true);
	newWin.layout.resize();
	newWin.onResizing = newWin.onResize = function () { this.layout.resize(); } 
	
	return newWin;
}

magicCube.cube.prototype = {//方块对象的共有函数
	changeR: function(cube, axis, sign) {//改变角度值，axis为轴，sign为顺时针或者逆时针
		var cp = magicCube.cp;
		var cs = magicCube.cs;
		cp.orientation.setValue([0, 0, 0]);
		cs.orientation.setValue(cube.rotation);
		cs.parent = cp;
		switch(axis) {
			case 0 : cp.orientation.setValue([sign*90, 0, 0]);break;
			case 1 : cp.orientation.setValue([0, sign*90, 0]);break;
			case 2 : cp.orientation.setValue([0, 0, sign*90]);break;
		}
		cs.parent = null;
		return cs.orientation.value;
	},
	changeP: function(axis, sign, n) {//返回计算改变位置的值,axis为轴，sign为顺时针或者逆时针，n为魔方阶数
		switch(axis) {
			case 0 : return this.changeP0(this.currentP[1], this.currentP[2], sign, n);
			case 1 : return this.changeP0(this.currentP[2], this.currentP[0], sign, n);
			case 2 : return this.changeP0(this.currentP[0], this.currentP[1], sign, n);
		}
	},
	changeP0: function(axis1, axis2, sign, n) {//计算改变位置的值，辅助changeP的函数,axis1和axis2为要改变的轴的值，sign为顺时针或者逆时针，n为魔方阶数
		var i = axis2;
		if(sign == 1) {
			axis2 = axis1;
			axis1 = n - 1 - i;
		}else {
			axis2 = n - 1 - axis1;
			axis1 = i;
		}
		return [axis1, axis2];
	}
}

magicCube.change = function(cube, id) {//通过id，改变当前cube的currentP和rotation的值
	if(id == 0) {//id等于0默认不执行操作
		return false;
	}
	var sign = id < 0 ? -1 : 1;//sign用来标记是顺时针还是逆时针
	var n = this.number;
	var x = Math.floor((Math.abs(id) - 1)/n);
	if(cube.currentP[2 - x] != (Math.abs(id)-1)%n) {
		return false;
	}
	cube.rotation = cube.changeR(cube, 2-x, sign);
	var ab = cube.changeP(2-x, sign, n);
	cube.currentP[(3-x)%3] = ab[0];
	cube.currentP[(4-x)%3] = ab[1];
}
magicCube.create = {
	createCubes: function(cubes, magicCubeComp, contralNull, parentFolder) {//前后上下左右,cubes为方块数组，magicCubeComp是将方块放在那个合成，parentFolder为总文件夹
		var cubesFolder = app.project.items.addFolder('cubes');//cubesFolder为存放方块的文件夹
		cubesFolder.parentFolder = parentFolder;
		for(var i = 0; i < cubes.length; i++) {//开始创建方块
			this.createCube(cubes[i], magicCubeComp, contralNull, cubesFolder);
			
		}
	},
	createCube: function(cube, magicCubeComp, contralNull, cubesFolder) {//前后上下左右，创建单个方块
		var expStr = magicCube.str.expression;
		var p = cube.currentP;
		var c = magicCube.currentComp;
		var d = magicCube.distance;
		var n = magicCube.number;
		
		//创建块物体的文件夹，块物体合成
		var cubeFolder = app.project.items.addFolder('cube' + '[' + String(p) + ']');
		var newComp = app.project.items.addComp('cube' + '[' + String(p) + ']', c.width, c.height, c.pixelAspect, magicCube.duration, c.frameRate);
		cubeFolder.parentFolder = cubesFolder;
		newComp.parentFolder = cubesFolder;
		
		//创建块物体控制层
		var myNull = magicCubeComp.layers.addNull();
		myNull.name = 'cube' + '[' + String(p) + ']';
		myNull.threeDLayer = true;
		myNull.anchorPoint.setValue(-1*[p[0]-(n-1)/2, p[1]-(n-1)/2, p[2]-(n-1)/2]*d);
		myNull.position.setValue([1, 1, 1]*d*(n-1)/2);
		
		//向总合成中添加空物块合成
		var newLayer = magicCubeComp.layers.add(newComp);//将方块添加到主合成
		newLayer.threeDLayer = true;
		newLayer.collapseTransformation = true;
		newLayer.position.setValue(p*d);
		newLayer.anchorPoint.setValue([0, 0, 0]);
		cube.cubeLayer = newLayer;
		cube.cubeNull = myNull;
		newLayer.parent = myNull;
		newLayer.shy = true;
		newLayer.scale.expression = expStr.try_str[0] + expStr.scale + expStr.try_str[1];
		
		myNull.parent = contralNull;
		myNull.position.setValue([0,0,0]);
		myNull.anchorPoint.expression = expStr.try_str[0] + expStr.anchorPoint + expStr.try_str[1];
		
		//创建块物体的六个面
		var id = 0;
		if(p[0] == 0) {
			id = 5;
		}else if(p[0] == n-1) {
			id = 6;
		}else {
			id = 5.5;
		}
		this.createFace(id, cube, newComp, cubeFolder);
		if(p[1] == 0) {
			id = 3;
		}else if(p[1] == n-1) {
			id = 4;
		}else {
			id = 3.5;
		}
		this.createFace(id, cube, newComp, cubeFolder);
		if(p[2] == 0) {
			id = 1;
		}else if(p[2] == n-1) {
			id = 2;
		}else {
			id = 1.5;
		}
		this.createFace(id, cube, newComp, cubeFolder);
	},
	createFace: function(id, cube, cubeComp, cubeFolder) {
		var str = magicCube.str.win.left;
		var p = cube.currentP;
		var d = magicCube.distance;
		var size = [d,d,d];
		var n = magicCube.number;
		
		var sign = -1;
		var dp = -1*[d, d, d]/2;
		var dp2 = -1*dp - size;
		switch(id) {
			case 1.5 : id = 0;
			case 1 : sign *= -1;
			case 2 : {
				if(p[0] == n-1) dp2[0] = dp[0];
				if(p[1] == n-1) dp2[1] = dp[1];
				var newFace = this.createFaceComp(id, p[0], p[1], size[0], size[1], cubeComp, cubeFolder, str.face[1]);
				newFace.transform.position.setValue([dp2[0], dp2[1], dp2[2]*sign]);
				newFace.transform.orientation.setValue([0, 0, 0]);
				var newFace = this.createFaceComp((n == 1 ? id+1 : 0), p[0], p[1], size[0], size[1], cubeComp, cubeFolder, str.face[2]);
				newFace.position.setValue([dp2[0], dp2[1], (dp2[2]>0?(dp2[2]-size[2]):(size[2]+dp2[2]))*sign]);
				newFace.orientation.setValue([0, 0, 0]);
				break;
			}
			case 3.5 : id = 0;
			case 3 : sign *= -1;
			case 4 : {
				if(p[0] == n-1) dp2[0] = dp[0];
				if(p[2] == n-1) dp2[2] = dp[2];
				var newFace = this.createFaceComp(id, p[0], p[2], size[0], size[2], cubeComp, cubeFolder, str.face[3]);
				newFace.transform.position.setValue([dp2[0], dp2[1]*sign, dp2[2]]);
				newFace.transform.orientation.setValue([90, 0, 0]);
				var newFace = this.createFaceComp((n == 1 ? id+1 : 0), p[0], p[2], size[0], size[2], cubeComp, cubeFolder, str.face[4]);
				newFace.position.setValue([dp2[0], (dp2[1]>0?(dp2[1]-size[1]):(size[1]+dp2[1]))*sign, dp2[2]]);
				newFace.orientation.setValue([90, 0, 0]);
				break;
			}
			case 5.5 : id = 0;
			case 5 : sign *= -1; 
			case 6 : {
				if(p[1] == n-1) dp2[1] = dp[1];
				if(p[2] == n-1) dp2[2] = dp[2];
				var newFace = this.createFaceComp(id, p[2], p[1], size[2], size[1], cubeComp, cubeFolder, str.face[5]);
				newFace.transform.position.setValue([dp2[0]*sign, dp2[1], dp2[2]]);
				newFace.transform.orientation.setValue([0, -90, 0]);
				var newFace = this.createFaceComp((n == 1 ? id+1 : 0), p[2], p[1], size[2], size[1], cubeComp, cubeFolder, str.face[6]);
				newFace.position.setValue([(dp2[0]>0?(dp2[0]-size[0]):(size[0]+dp2[0]))*sign, dp2[1], dp2[2]]);
				newFace.orientation.setValue([0, -90, 0]);
			}
		}
	},
	createFaceComp: function(id, p1, p2, width, height, cubeComp, cubeFolder, name) {
		var face = magicCube.faceComps[Math.floor(id)];
		var c = magicCube.currentComp;
		var newFace = app.project.items.addComp(name, width, height, c.pixelAspect, magicCube.duration, c.frameRate);
		newFace.parentFolder = cubeFolder;
		var newLayer = newFace.layers.add(face);
		newLayer.anchorPoint.setValue([0, 0]);
		newLayer.position.setValue(-1*[width*p1, height*p2]);
		var newLayer = cubeComp.layers.add(newFace);
		newLayer.threeDLayer = true;
		newLayer.motionBlur = magicCube.blur;
		newLayer.anchorPoint.setValue([0, 0, 0]);
		return newLayer;
	}
}

magicCube.rotateCube = function(cubes, finalSteps) {
	for(var i = 0; i < cubes.length; i++) {
		if(!isValid(cubes[i].cubeNull)) {
			alert(magicCube.str.win.alert5);
			return false;
		}
		
		//初始化
		var ork = cubes[i].cubeNull.orientation;
		while(ork.numKeys > 0) {
			ork.removeKey(1);
		}
		ork.setValue([0,0,0]);
		cubes[i].currentP = [cubes[i].P0, cubes[i].P1, cubes[i].P2];
		cubes[i].rotation = [0,0,0];
		//
	}
	for(var s = 0; s < finalSteps.length; s++) {
		var finalStep = finalSteps[s];
		for(var i = 0; i < cubes.length; i++) {
			var orient = cubes[i].cubeNull.orientation;
			var rotations = [];
			for(var j = 0; j < finalStep.length; j++) {
				this.change(cubes[i], finalStep[j][0]);
				rotations.push(cubes[i].rotation);
			}
			
			for(var k = 0; k < rotations.length; k++) {
				if((k == 0 && rotations[k] == rotations[k+1]) || (k == rotations.length-1 && rotations[k] == rotations[k-1])) {
					if(orient.numKeys == 0) {
						orient.setValue(rotations[k]);
					}
					continue;
				} 
				if(k != 0 && k != rotations.length-1 && rotations[k] == rotations[k-1] && rotations[k] == rotations[k+1]) {
					continue;
				}
				orient.setValueAtTime(parseFloat(finalStep[k][1]), rotations[k]);
				if(k != rotations.length-1 && finalStep[k][1] == finalStep[k+1][1]) {
					orient.setSpatialContinuousAtKey(orient.numKeys, true);
				}
			}
		}
	}
}

magicCube.getSelectedLayers = function() {
	var thisComp = app.project.activeItem;
	if(!(thisComp instanceof CompItem) || thisComp.numLayers.length == 0){
		this.currentComp = null;
		return false;
	}
	this.currentComp = thisComp;
	this.faceLayers = thisComp.selectedLayers;
	return thisComp.selectedLayers;
}

magicCube.isNumber = function (str) {//检验是否为数字，否则返回0（字符串）
	var myNum = parseFloat(str);
	if(isNaN(myNum)) {
		return false;
	}else {
		return true;
	}
}

magicCube.setLanguage = function(scriptName) {
	if(app.settings.haveSetting(scriptName, 'language')) {
		magicCube.language = app.settings.getSetting(scriptName, 'language');
	}else {
		magicCube.language = app.isoLanguage=="zh_CN"?1:0;
	}
}

magicCube.getMagicCube = function(cubeComp) {
	var layers = cubeComp.layers;
	var cubes = [];
	var n = 1;
	var cp = null;
	var cs = null;
	for(var i = 1; i <= layers.length; i++) {
		if(!layers[i].nullLayer) {
			continue;
		}
		if(layers[i].name == 'cp') {
			cp = layers[i];
		}else if(layers[i].name == 'cs') {
			cs = layers[i];
		}
		var p = layers[i].name.split(/[\[\]]/);
		for(var j = 1; j <= p.length; j++) {
			if(magicCube.isNumber(p[j]) && p[j].match(/\,/)) {
				var p2 = p[j].split(/\,/);
				if(p2.length == 3 && magicCube.isNumber(p2[0]) && magicCube.isNumber(p2[1]) && magicCube.isNumber(p2[2])) {
					var cube = new magicCube.cube();
					cube.P0 = parseInt(p2[0]);
					n = cube.P0 > n ? cube.P0 : n;
					cube.P1 = parseInt(p2[1]);
					n = cube.P1 > n ? cube.P1 : n;
					cube.P2 = parseInt(p2[2]);
					n = cube.P2 > n ? cube.P2 : n;
					cube.cubeNull = layers[i];
					cubes.push(cube);
					break;
				}
			}
		}
	}
	
	if(cubes.length <= (n+1)*(n+1)*(n+1) && cubes.length >= (n+1)*(n+1)*(n+1)-(n-1)*(n-1)*(n-1)) {
		//return true;
	}else {
		return false;
	}
	
	if(cp == null) {
		cp = cube.layers.addNull();
		cp.threeDLayer = true;
		cp.name = 'cp';
	}
	if(cs == null) {
		cs = cube.layers.addNull();
		cs.threeDLayer = true;
		cs.name = 'cs';
	}
	
	magicCube.cubes = cubes;
	magicCube.cp = cp;
	magicCube.cs = cs;
	magicCube.number = n+1;
	
	return true;
}

//
magicCube.createCube = function(name, tier, size, isStroke, stroke, depth, faces) {
	var str = magicCube.str.win;
	var n = tier;
	var c = magicCube.currentComp;
	var d = size;

	//为纹理图层及描边创建新的合成，文件夹
	var magicCubeFaces = app.project.items.addFolder('Source');
	var magicCubeFaces2 = app.project.items.addFolder('Faces');
	if(isStroke) {
		var strokeComp = app.project.items.addComp(str.right.top.stroke, n*d, n*d, c.pixelAspect, magicCube.duration, c.frameRate);
		strokeComp.parentFolder = magicCubeFaces;
		var strokeLayer = strokeComp.layers.addSolid([1,1,1], str.right.top.stroke, n*d, n*d, c.pixelAspect, magicCube.duration);
		var strokeEffect = strokeLayer.effect.addProperty('ADBE Grid');
		strokeEffect(1).setValue([0,0]);
		strokeEffect(3).setValue([d,d]);
		strokeEffect(6).setValue(stroke);
	}
	magicCube.faceComps = [];
	for(var i = 0; i <= 6; i++) {
		var faceComp = app.project.items.addComp(str.left.face[i], n*d, n*d, c.pixelAspect, magicCube.duration, c.frameRate);
		faceComp.parentFolder = magicCubeFaces;
		var faceComp2 = app.project.items.addComp(str.left.face[i], n*d, n*d, c.pixelAspect, magicCube.duration, c.frameRate);
		faceComp2.parentFolder = magicCubeFaces2;
		magicCube.faceComps.push(faceComp2);
		//var faceComp = thisComp.layers.precompose(layers,mySuffix+"源合成",false);//预合成
		faces[i].copyToComp(faceComp);
		faceComp.layers[1].position.setValue([n*d*0.5, n*d*0.5]);
        faceComp2.layers.add(faceComp);
		faceComp2.layers[1].position.setValue([n*d*0.5, n*d*0.5]);
        if(i == 2 || i == 3 || i == 5) {
            faceComp2.layers[1].scale.setValue([-100, 100]);
        }
		if(isStroke) {
			faceComp2.layers.add(strokeComp, c.duration);
		}
	}
	
	//创建总文件夹，总合成，总控制空物体
	var magicCubeFolder = app.project.items.addFolder(name);
	var magicCubeComp = app.project.items.addComp(name, c.width, c.height, c.pixelAspect, magicCube.duration, c.frameRate);
	magicCubeComp.parentFolder = magicCubeFolder;
	magicCubeFaces.parentFolder = magicCubeFolder;
	magicCubeFaces2.parentFolder = magicCubeFolder;
	var myNull = magicCubeComp.layers.addNull();
	myNull.name = 'contral';
	myNull.threeDLayer = true;
	
	//创建前期的魔方块物体数据，存储在magicCube.cubes中
	magicCube.cubes = [];
	for(var i = 0; i < n; i++) {
		for(var j = 0; j < n; j++) {
			for(var k = 0; k < n; k++) {
				if(depth<n/2) {
					if((i+1 > depth && i+1 <= n-depth) && (j+1 > depth && j+1 <= n-depth) && (k+1 > depth && k+1 <= n-depth)) {
						continue;
					}
				}
				var a = new magicCube.cube();
				a.id = magicCube.cubes.length;
				a.P0 = i;
				a.P1 = j;
				a.P2 = k;
				a.currentP = [i, j, k];
				magicCube.cubes.push(a);
			}
		}
	}

	//这里创建辅助块物体获得旋转值的两个辅助空物体
	magicCube.cp = magicCubeComp.layers.addNull();
	magicCube.cp.name = 'cp';
	magicCube.cp.threeDLayer = true;
	magicCube.cs = magicCubeComp.layers.addNull();
	magicCube.cs.name = 'cs';
	magicCube.cs.threeDLayer = true;
	
	//创建块物体
	magicCube.create.createCubes(magicCube.cubes, magicCubeComp, myNull, magicCubeFolder);
	
	//将总控制空物体移到合成最前面，并为其添加效果及表达式
	myNull.moveToBeginning();
	var ce = magicCube.str.contralEffect;
	for(var i = 0; i < ce.length; i++) {
		var e = myNull.effect.addProperty(ce[i][1]);
		e.name = ce[i][0];
		e(1).setValue(ce[i][2]);
	}

	//将总合成移到当前合成
	c.layers.add(magicCubeComp);
	
	app.endUndoGroup();
}

//

magicCube.scriptName = 'Magic Cube';
magicCube.setLanguage(magicCube.scriptName);
magicCube.str = magicCube.language==0 ? magicCube.en_str : magicCube.cn_str;
var magicCubeWin = magicCube.win(this);
if(magicCubeWin instanceof Window) {
	magicCubeWin.center();
	magicCubeWin.show();
}