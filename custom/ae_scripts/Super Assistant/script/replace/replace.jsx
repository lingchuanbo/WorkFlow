
;(function(Global) {
#include 'lib/UIParser.jsx'
#include 'lib/Tree.jsx'
#include 'lib/Map.jsx'
var _ = UIParser(Global);
//alert(Map)
_.app.allowAccessFile();//判断是否允许写入文件
/**************************创建窗口准备******************************************************************************/
var rootPath = File.decode(File($.fileName).path) + '/Super Assistant/';
var iconPath = rootPath + 'icon/';
var createGroupIcon = File(iconPath + 'createGroup.png');
var cache_file_path = rootPath + 'cache_file';
var favourateJsonPath = rootPath + 'favourate.json';
var effectJsonPath = rootPath + 'effect/effect.json';
//主界面UI
var UIJson = {
	mainWin : {type:'window', properties:{resizeable:true}, children:{
		mainGroup: {type:'group', orientation:'column', align:'fill', children:{
			//导航条
			navGroup: {type:'group', orientation:'row', align:'top', children:{
				file: {type:'button', align:'left_center'},
				help: {type:'button', align:'right_center'},
				trans: {type:'button', align:'right_center'},
			}},
			group: {type:'group', orientation:'row', align:'fill', children:{
				//左侧合成
				leftGroup: {type:'group', orientation:'row', align:'fill', children:{
					leftGroup: {type:'group', orientation:'column', align:'fill', children:{
						addGroup: {type:'group', orientation:'row', align:'top', children:{
							addCompFromComp: {type:'button', align:'left_center'},
							addCompFromSource: {type:'button', align:'left_center'},
							compFilter: {type:'edittext', align:'fill_center'},
						}},
						editGroup: {type:'group', orientation:'row', align:'fill_top', children:{
							addGroup: {type:'button', align:'left_center'},
							add2: {type:'button', align:'left_center'},
							add3: {type:'button', align:'left_center'},
							add4: {type:'button', align:'left_center'},
							add9: {type:'button', align:'left_center'},
							add5: {type:'button', align:'right_center'},
							add6: {type:'button', align:'right_center'},
							add7: {type:'button', align:'right_center'},
						}},
						listGroup: {type:'group', orientation:'row', align:'fill', children:{
							groupList: {type:'listbox', align:'fill', properties:{multiselect:1}},
							compList: {type:'listbox', align:'fill', properties:{multiselect:1}},
						}},
					}},
					replaceGroup: {type:'group', orientation:'column', align:'right_bottom', children:{
						replace: {type:'button', align:'center_top'},
						separatorLine2: {type:'panel', align:'top'},
						checkGroup: {type:'group', orientation:'column', align:'center_top', children:{
							add1: {type:'button', align:'center_top'},
							add2: {type:'button', align:'center_top'},
						}},
						separatorLine3: {type:'panel', align:'top'},
						matchGroup: {type:'group', orientation:'column', align:'center_top', children:{
							matchGroup1: {type:'group', orientation:'column', align:'center_top', children:{
								add1: {type:'button', align:'center_top'},
								add2: {type:'button', align:'center_top'},
							}},
							matchGroup2: {type:'group', orientation:'column', align:'center_top', children:{
								add1: {type:'button', align:'center_top'},
								add2: {type:'button', align:'center_top'},
							}},
						}},
					}},
				}},//end of leftGroup
				//右侧文件列表
				rightGroup: {type:'group', orientation:'column', align:'fill', children:{
					topGroup: {type:'group', orientation:'row', align:'top', children:{
						selectFolder: {type:'button', align:'left_center'},
						pictureFilter: {type:'edittext', align:'fill_center', text:'png|jpg|icon'},
					}},
					searchGroup: {type:'group', orientation:'row', align:'top', children:{
						search: {type:'edittext', align:'fill_center'},
						refresh: {type:'button', align:'right_center'},
						removePicture: {type:'button', align:'right_center'},
					}},
					pictureGroup: {type:'group', orientation:'row', align:'fill', children:{
						pictureList: {type:'listbox', align:'fill', properties:{multiselect:1}},
						folderList: {type:'treeview', align:'fill'},
					}},
				}},//end of rightGroup
			}}//end of group
		}}//end of mainGroup
	}}//end of mainWin
};
var subUIJson = {
	//创建组，重命名使用此UI
	groupUI:{
		group: {type:'group', align:'fill', children:{
			name_box: {type:'edittext', align:'fill_center'},
			save: {type:'button', align:'right_center', text:'Save'}
		}}
	},
};
/**************************辅助函数******************************************************************************/
var addTreeFromFolder =  function (node, folder, format, level) {//从文件夹创建树（节点，文件夹，格式(例如'png|jpg')）
	if(level == null) level = 10;
	if(!level) return;
	node = node.add('node', {name:File.decode(folder.name), source:folder});
	var pathFiles = folder.getFiles();
	for(var i = 0; i < pathFiles.length; i++) {
		if(pathFiles[i].resolve()) var myFile = pathFiles[i].resolve();
		else var myFile = pathFiles[i];
		if (myFile instanceof Folder){
			if(myFile.name.match(/^\(.*\)$/)) continue;
			arguments.callee(node, pathFiles[i], format, level-1);
		}else {
			var fileName = File.decode(myFile.name);
			if(eval("fileName.match(/\.(" + format + ")$/)")) {
				var newItem = node.add('item', {name:fileName, source:myFile});
			}
		}
	}
};
var addTreeViewFromTree =  function (node, tree, filter, exec) {//从树创建树形图
	var c = tree.children();
	for(var i = 0; i < c.length; i++) {
		if(filter && !filter(c[i])) continue;
		var newNode = null;
		var fileName = c[i].data.name;
		if (c[i].type == 'node'){
			newNode = node.add('node', fileName);
			newNode.dataItem = c[i];
			//newNode.image = createGroupIcon;
			arguments.callee(newNode, c[i], filter, exec);
		}else {
			newNode = node.add('item', fileName);
			newNode.dataItem = c[i];
		}
		if(exec && newNode) exec(newNode);
	}
};
var addListFromTree =  function (list, tree, filter, exec) {//从树创建树形图
	var count = 0;
	alft(list, tree, filter, exec);
	function alft(list, tree, filter, exec) {
		if(count > 1000) return;
		var c = tree.children();
		for(var i = 0; i < c.length; i++) {
			if(filter && !filter(c[i])) continue;
			var newNode = null;
			if (c[i].type == 'node'){
				arguments.callee(list, c[i], filter, exec);
			}else {
				newNode = list.add('item', c[i].data.name);
				newNode.dataItem = c[i];
				count++;
			}
			if(exec && newNode) exec(newNode);
		}
	}
};
/**************************创建窗口******************************************************************************/
var mainWin = Global instanceof Panel ? _(this).addUI(UIJson.mainWin.children)[0].parent : _.newWindow(UIJson)[0];
_.windows.push(mainWin);
_(mainWin).find('.button').each(function(e) {
	if(e.text == '') e.size = [20, 20];
});
//search.graphics.foregroundColor = search.graphics.newPen(search.graphics.PenType.SOLID_COLOR, [1, 0, 0], 1);
//search.graphics.backgroundColor = search.graphics.newBrush(search.graphics.BrushType.SOLID_COLOR, [0.7,0.7,0.7]);
_('*').layout();
_('*').style({spacing:2});
/********************重要变量的声明和辅助函数fns*******************************************************************/
//声明重要变量
var groupList = _('#groupList')[0];
var compList = _('#compList')[0];
var pictureList = _('#pictureList')[0];
var folderList = _('#folderList')[0];

var pictureFilter = _('#pictureFilter')[0];
var compFilter = _('#compFilter')[0];

var compTree = new Tree();
var compMap = new Map();
var pictureTree = new Tree();
pictureTree.folderTree = new Tree();

var fns = {
	createWin: function(title, json, exec, finalexec) {
		var newWin = new Window('palette', title, undefined, {resizeable: true});
		_(newWin).addUI(json);
		_(newWin).layout();
		_(newWin).find('*').layout();
		exec(newWin);
		_.window.resize(newWin);
		if(finalexec) finalexec(newWin);
		if(newWin.size[0] < 300) newWin.size[0] = 300;
		newWin.show();
		return newWin;
	},
	refreshFolder: function() {
		pictureTree.clear();
		folderList.removeAll();

		var folderArray = pictureTree.folderTree.children();
		for(var i = 0; i < folderArray.length; i++) {
			if(folderArray[i].data.source && folderArray[i].data.source.exists)
			{
				addTreeFromFolder(	pictureTree,
									folderArray[i].data.source,
									pictureFilter.text,
									5);
			}
			else
			{
				folderArray[i].remove();
			}
		}//end of for
		addTreeViewFromTree(folderList,
						pictureTree,
						function(e) { return e.type == 'node';}	);

		_.treeview.expandAllNode(folderList);
	},
	refreshGroup: function() {
		groupList.removeAll();
		var groups = compTree.children();
		for(var i = 0; i < groups.length; i++) groupList.add('item', groups[i].data.name).dataItem = groups[i];
	},
	refreshComp: function(s) {
		compList.removeAll();
		for(var i = 0; i < s.length; i++) addListFromTree(compList, s[i].dataItem);
	},
	addCompFromComp: function() {
		var s = [0];
		//if(app.project.activeItem instanceof CompItem) s.push(app.project.activeItem);
		//else {
		var sl = app.project.selection;
		if(sl.length == 0) return;
		for(var i = 0; i < sl.length; i++) s.push(sl[i]);
		//}
		var node;
		if(groupList.selection) {
			node = groupList.selection[0];
		}else {
			node = groupList.add('item', 'New group');
			node.dataItem = compTree.add('node', {name: 'New group'});
		}
		fns.addTreeFromSelectedComp(node.dataItem, s);
		fns.refreshComp([node]);
	},
	addCompFromSource: function() {
		var s = [0];
		var sl = app.project.selection;
		if(sl.length == 0) return;
		for(var i = 0; i < sl.length; i++) s.push(sl[i]);

		var node;
		if(groupList.selection) {
			node = groupList.selection[0];
		}else {
			node = groupList.add('item', 'New group');
			node.dataItem = compTree.add('node', {name: 'New group'});
		}
		fns.addTreeFromSelectedSource(node.dataItem, s);
		fns.refreshComp([node]);
	},
	addTreeFromSelectedComp: function(node, s, filter) {
		for(var i = 1; i <= s.length; i++) {
			var comp = s[i];
			if(comp instanceof FolderItem) arguments.callee(node, comp.items);
			else if(comp instanceof CompItem && fns.matchName(comp.name, compFilter.text)) {
				var id = comp.id;
				if(compMap.isValid(id)) {
					//if(confirm('The comp '+s[i].name+' is in '+value.parent.data.name+' group, Move it in '+node.data.name+' group?')) {
					comp.moveTo(node);
				}else{
					var newNode = node.add('item', {
						name: comp.name,
						compId: id,
						layerId: 1,
						comp: comp
					});
					compMap.add(id, newNode);
				}
			}//end of else
		}//end of for
	},
	addTreeFromSelectedSource: function(node, s, filter) {
		for(var i = 1; i <= s.length; i++) {
			var source = s[i];
			if(source instanceof FolderItem) {
				arguments.callee(node, source.items);
				continue;
			}
			if(!source || !source.usedIn) {//如果选择的item不是有有源的则跳过下面的步骤继续循环
				continue;
			}
			else if(fns.matchName(s[i].name, compFilter.text)) {
				var comps = source.usedIn;
				for(var j = 0; j < comps.length; j++) {
					var comp = comps[j];
					var id = comp.id;
					if(compMap.isValid(id)) {
						comp.moveTo(node);
					}else{
						var newNode = node.add('item', {
							name: comp.name,
							layerId: 1,
							compId: id,
							comp: comp
						});
						compMap.add(id, newNode);
					}
				}
			}//end of else
		}//end of for
	},
	matchName: function(name, filter) {
		if(filter == '') return true;
		try{//用try语句保证可以正确完成搜索，可以包含正则表达式
			if(!eval("name.match(/"+filter+"/i)")) return false;
		}catch(err){
			try{
				if(!eval("name.match("+filter+")")) return false;
			}catch(err){}
		}
		return true;
	},
	removeListItem: function(event) {
		if(event.keyName == 'Delete') {
			var s = this.selection;
			if(!s) return;
			for(var i = s.length - 1; i >= 0; i--) {
				s[i].dataItem.remove();
			//	alert(s[i].dataItem.parent.children().length)
				this.remove(s[i]);
			}
		}
    },
};



//事件绑定
_('*').each(function(e) {
	switch(e.id) {
		case 'selectFolder': e.onClick = function() {
			var folder = Folder.selectDialog('select a folder');
			if(!folder) return;
			pictureTree.folderTree.add('item', {source:folder});
			fns.refreshFolder();
		}; break;
		case 'folderList': e.onChange = function() {
			var s = this.selection;
			if(!s) return;
			pictureList.removeAll();
			addListFromTree(pictureList, s.dataItem);
		};
		e.addEventListener("keydown",function(event) {
			if(event.keyName == 'Delete') {
				var s = folderList.selection;
				if(!s) return;
				s.dataItem.remove();
				folderList.remove(s);
			}
	    });break;
		case 'groupList': e.onChange = function() {
			var s = this.selection;
			if(!s) return;
			fns.refreshComp(s);
		};
		case 'compList':
		case 'pictureList': e.addEventListener("keydown", fns.removeListItem); break;
		case 'addGroup': e.onClick = function() {
			fns.createWin('New Group', subUIJson.groupUI, function(e){
				var win = e;
				_(win).find('#save')[0].onClick = function(e) {
					var name = _(win).find('#name_box')[0];
					compTree.add('node', {name:name.text});
					win.close();
					fns.refreshGroup();
				}
			});
		}; break;
		case 'addCompFromComp': e.onClick = fns.addCompFromComp; break;
		case 'addCompFromSource': e.onClick = fns.addCompFromSource; break;
	}
});
/**************显示界面******************************************************************************************/
_.window.resize(mainWin);
if(mainWin instanceof Window) {
	mainWin.show();
}
})(this);