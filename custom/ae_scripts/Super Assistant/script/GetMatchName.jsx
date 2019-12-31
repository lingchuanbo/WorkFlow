var getMatchName = new Object();

getMatchName.str = {
	title: 'getMatchName',
	get: '获取',
}

getMatchName.win = function(obj) {
	var str = this.str;
	var newWin = obj instanceof Panel? obj : new Window('palette', str.title, undefined, {resizeable: 1});
	newWin.margins = 0;
	var g = newWin.add("group{\
		alignment: ['fill', 'top'],\
		spacing: 0,\
		texts: EditText{readonly: 1, alignment: ['fill', 'center']},\
		ok: Button{alignment: ['right', 'center']},\
	}");
	
	var texts = g.texts;
	var ok = g.ok;
	ok.text = str.get;
	
	ok.onClick = function() {
		var sl = getMatchName.getSelectedLayers();
		if(sl == false){
			return;
		}
		var myPro = sl[0].selectedProperties;
		if(myPro.length > 0) {
			var myStr = '';
			var depth = myPro[myPro.length - 1].propertyDepth;
			var currentP = myPro[myPro.length - 1];
			for (var i = 1; i <= depth; i++) {
				myStr = '(\'' + currentP.matchName + '\')' + myStr;
				currentP = currentP.parentProperty;
			}
			//if(myPro.length > 1 && myPro[1].parentProperty.matchName == myPro[0].matchName) {//添加子集（如果选中了效果的子集，其父级也会被选中）
			//	myStr += '(\'' + myPro[1].matchName + '\')';
			//}
			texts.text = myStr;
		}
	}
	ok.onClick();
	
	newWin.layout.layout(true);
	newWin.onResizing = function() {
		this.layout.resize();
	}
	
	return newWin;
}

getMatchName.getSelectedLayers = function() {
	var thisComp = app.project.activeItem;
	if(!(thisComp instanceof CompItem) || thisComp.selectedLayers.length == 0){
		return false;
	}
	return thisComp.selectedLayers;
}

var getMatchNameWin = getMatchName.win(this);
if(getMatchNameWin instanceof Window) {
	getMatchNameWin.center();
	getMatchNameWin.show();
}