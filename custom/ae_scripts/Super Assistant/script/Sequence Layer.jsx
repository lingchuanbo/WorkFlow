//作者：阿木亮	邮箱：982632988@qq.com	时间：2014/11/20

function AMLFunction() {}

AMLFunction.prototype = {
	dropdownlist: {},
	project: {},
	array: {},
	window: {},
	check: {},
};

AMLFunction.prototype.dropdownlist = {
	addItem: function (list, array) {
		for(var i = 0; i < array.length; i++) {
			if(array[i] == null) {
				list.add('separator');
			}else {
				list.add('item', array[i]);
			}
		}
	},
};

AMLFunction.prototype.project = {
	getSelectedLayers: function () {
		var thisComp = app.project.activeItem;
		if(!(thisComp instanceof CompItem) || thisComp.selectedLayers.length == 0){
			return false;
		}
		return thisComp.selectedLayers;
	},
};

AMLFunction.prototype.array = {
	invert: function (array) {
		var newArray = new Array;
		for(var i = 0; i < array.length; i++) {
			newArray[i] = array[array.length - 1 - i];
		}
		return newArray;
	},
	random: function (array) {
		var newArray = new Array;
		for(var i = 0; i < array.length; i++) {
			var start = Math.round(Math.random() * newArray.length);
			newArray.splice(start, 0, array[i]);
		}
		return newArray;
	},
};

AMLFunction.prototype.window = {
	resize: function (window) {
		window.layout.layout(true);
		window.layout.resize();
		window.onResizing = window.onResize = function () {
			this.layout.resize();
		}
	},
};

AMLFunction.prototype.check = {
	isNumber: function (str) {
		var myNum = parseFloat(str);
		if(isNaN(myNum)) {
			return 0;
		}else {
			return myNum;
		}
	},

};


//-------------------------------------------------------------------------
var seqLayer = new AMLFunction();

seqLayer.str = {
	title: 'Sequence Layer',
	OK: '确定',
	sequence: '序列',
	sequenceList: ['正向', '反向', '随机'],
	unit: '单位',
	unitList: ['帧', '秒'],
	offset: '随机偏移',
};

seqLayer.win = function (obj) {
	var str = this.str;
	//创建窗口
	var win = (obj instanceof Panel) ? obj : new Window("palette", str.title, undefined, {resizeable: true});
	win.margins = 0;
	var group = win.group = win.add(
		"group{\
			alignment: ['fill','fill'],\
			alignChildren: ['fill','top'],\
			orientation: 'column',\
			spacing: 2,\
			top: Group{\
				spacing: 0,\
				value: EditText{text: '0', alignment: ['fill','center'],},\
				OK: Button{alignment: ['right','center'], size: [50, 25]},\
			},\
			center: Group{\
				spacing: 10,\
				alignChildren: ['left','center'],\
				left: Group{\
					spacing: 0,\
					alignChildren: ['left','center'],\
					text: StaticText{},\
					list: DropDownList{},\
				},\
				right: Group{\
					spacing: 0,\
					alignChildren: ['left','center'],\
					text: StaticText{},\
					list: DropDownList{},\
				},\
			},\
			bottom: Group{\
				spacing: 0,\
				alignChildren: ['left','center'],\
				offset: Checkbox{},\
				right: Group{\
					spacing: 0,\
					alignment: ['fill','center'],\
					alignChildren: ['fill','center'],\
					min: EditText{text: '0',},\
					max: EditText{text: '0',},\
				},\
			},\
		}"
	);
	var move = group.top.value;
	var OK = group.top.OK;
	OK.text = str.OK;
	group.center.left.text.text = str.sequence;
	var sequence = group.center.left.list;
	this.dropdownlist.addItem(sequence, str.sequenceList);
	var unit = group.center.right.list;
	this.dropdownlist.addItem(unit, str.unitList);
	group.center.right.text.text = str.unit;
	var offset = group.bottom.offset;
	offset.text = str.offset;
	var offsetValue = group.bottom.right;
	
	//事件
	offset.onClick = function () {
		if(this.value) {
			offsetValue.visible = 1;
		}else {
			offsetValue.visible = 0;
		}
	}
	
	OK.onClick = function () {
		var sl = seqLayer.project.getSelectedLayers();
		if(!sl) {
			return;
		}
	
		if(sequence.selection.index == 1) {
			sl = seqLayer.array.invert(sl);
		}else if(sequence.selection.index == 2) {
			sl = seqLayer.array.random(sl);
		}
	
		var value0 = seqLayer.check.isNumber(move.text);
		var min = seqLayer.check.isNumber(offsetValue.min.text);
		var max = seqLayer.check.isNumber(offsetValue.max.text);
		app.beginUndoGroup(str.title);
		for(var i = 0; i < sl.length; i++) {
			var value = value0;
			var time = value0;
			if(offset.value) {
				time += Math.random() * (max - min) + min;
			}
			if(unit.selection.index == 0) {
				time *= app.project.activeItem.frameDuration;
				value *= app.project.activeItem.frameDuration;
			}
			sl[i].startTime += time + value * (i - 1);
		}
		app.endUndoGroup();
		
	}

	this.window.resize(win);
	sequence.selection = 0;//初始化
	unit.selection = 0;
	offset.onClick();
	return win;
}

var seqLayerWin = seqLayer.win(this);
if(seqLayerWin instanceof Window) {
	seqLayerWin.center();
	seqLayerWin.show();
}