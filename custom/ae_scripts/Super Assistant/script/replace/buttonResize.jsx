;(function() {
#include 'lib/UIParser.jsx'


var _ = UIParser(this);

function arrayButton(rowSpacing, columnSpacing) {
	//如果当前没有子元素直接退出
	if(this.children.length == 0) return;

	rowSpacing = rowSpacing || 5;
	columnSpacing = columnSpacing || 5;

	var c = this.children;
	var len = c.length;
	var width = this.size[0];

	var item = c[0];
	var itemWidth = item.size[0];
	var itemHeight = item.size[1];

	var num = Math.floor(width / (itemWidth + rowSpacing));
	for(var i = 0; i < len; i++) {
		var x = rowSpacing + (itemWidth + rowSpacing) * (i % num);
		var y = columnSpacing + (itemHeight + columnSpacing) * Math.floor(i / num);
		c[i].location = [x, y];
	}
}

var UIJson = {
	win : {type:'window', properties:{resizeable:true}, children:{
		mainGroup: {type:'group', orientation:'column', align:'fill', children:{
			//e: {type:'edittext', align:'fill_top'},
			editGroup: {type:'group', align:'fill', children:{
				add1: {type:'button'},
				add2: {type:'button'},
				add3: {type:'button'},
				add4: {type:'button'},
				add9: {type:'button'},
				add5: {type:'button'},
				add6: {type:'button'},
				add7: {type:'button'},
			}},
		}}//end of mainGroup
	}}//end of win
};

var win = _.newWindow(UIJson)[0];
_(win).find('.button').each(function(e) {
	if(e.text == '') e.size = [25, 25];
});
/********************重要变量的声明和辅助函数fns*******************************************************************/
//声明重要变量
var g = _(win).find('#editGroup')[0];
g.minimumSize = [0, 0];

//var e = _(win).find('#e')[0];
_('*').layout();
/**************显示界面******************************************************************************************/
g.arrayButton = arrayButton;
win.onResizing = function () {
	this.layout.resize();
	g.size = this.size;
	g.arrayButton();
}

win.show();
win.onResize();
alert(_.dir(g))
})();