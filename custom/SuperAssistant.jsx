/*脚本内容从上往为：
	引用文件：UIParser.jsx 和 Tree.jsx
	脚本架构：
		表现层：利用UIParser书写UI，其中fns.createWin函数辅助创建小窗口
		数据层：利用Tree构建数据，脚本中全局变量
			_view 为模块集合的父级，并且为UIParser对象
			_view.current 为当前所在模块
			_view.current.tree 为Tree的实例，所有数据操作全部基于此树，每个模块都有一个树。每次刷新重新读取数据构建此树
			_view.current.likeTree 为Tree的实例，为“喜欢”功能的数据，数据来源为favourate.json，辅助_view.current.tree，但基本不直接对此树操作
		逻辑层：所有事件绑定全在脚本的下半部分，利用UIParser从表现层获取元素
	初始化：初始化界面数据
	显示：判断为面板型或窗口型将脚本界面显示出来
脚本文件夹：
	icon：存放图标
	lib：存放引用文件
	effect：存放effect.json
	script，expression，preset，template：分别存放脚本，表达式，预设，模板
	favourate.json：喜欢功能的信息
	readme：帮助文档
	cache_file: 产生的临时文件
*/

;(function(Global) {
#include 'ae_scripts/lib/UIParser.jsx'
#include 'ae_scripts/lib/Tree.jsx'
var _ = UIParser(Global);
_.app.allowAccessFile();//判断是否允许写入文件
/**************************创建窗口准备******************************************************************************/
// var rootPath = File.decode(File($.fileName).path) + '/ae_scripts/';
var rootPath = File.decode(File($.fileName).path) + '/ae_scripts/';
// var rootPathPresetAnimation = File.decode(File($.fileName).path) + '/PresetAnimation/';
// var rootPathScript = File.decode(File($.fileName).path) + '/otherScriptCommand/';
// var rootPathExpression = File.decode(File($.fileName).path) + '/Expression/';
// var rootPathAeFile = File.decode(File($.fileName).path) + '/AeFile/';

var iconPath = rootPath + 'icon/';
var createGroupIcon = File(iconPath + 'createGroup.png');
var cache_file_path = rootPath + 'cache_file';
var favourateJsonPath = rootPath + 'favourate.json';
var effectJsonPath = rootPath + 'effect/effect.json';
//主界面UI
var UIJson = {
	mainWin : {type:'window', properties:{resizeable:true}, children:{
		mainGroup: {type:'group', orientation:'column', align:'fill', children:{
			//搜索框
			searchGroup: {type:'group', orientation:'row', align:'top', children:{
				searchIcon: {type:'iconbutton', label:'search', align:'left_center', size:[20,20], enabled:0, properties:{style: 'toolbutton'}},
				search: {type:'edittext', align:'fill_center'},
			}},
			group: {type:'group', orientation:'row', align:'fill', children:{
				//左侧标签栏
				tabGroup: {type:'group', orientation:'column', align:'left_fill', children:{
					mode: {type:'group', orientation:'column', align:'top_fill', children:{
						scriptItem: {type:'iconbutton', size:[32,32], label:'script', label2:'script2', helpTip:'Scirpt', properties:{style: 'toolbutton'}},
						expressionItem: {type:'iconbutton', size:[32,32], label:'expression', label2:'expression2', helpTip:'Expression', properties:{style: 'toolbutton'}},
						presetItem: {type:'iconbutton', size:[32,32], label:'preset', label2:'preset2', helpTip:'Preset', properties:{style: 'toolbutton'}},
						templateItem: {type:'iconbutton', size:[32,32], label:'template', label2:'template2', helpTip:'Template', properties:{style: 'toolbutton'}},
						effectItem: {type:'iconbutton', size:[32,32], label:'effect', label2:'effect2', helpTip:'Effect', properties:{style: 'toolbutton'}}
					}},
					separatorLine: {type:'panel', align:'top'},
					refresh: {type:'iconbutton', align:'center_top', label:'refresh', helpTip:'Refresh', properties:{style: 'toolbutton'}},
					like: {type:'iconbutton', align:'center_top', label:'like', label2:'list', sign:0, helpTip:'List/Like', properties:{style: 'toolbutton'}},
					help: {type:'iconbutton', align:'center_top', label:'help', helpTip:'Help', properties:{style: 'toolbutton'}},
					apply: {type:'iconbutton', align:'center_bottom', size:[32,32], label:'apply', helpTip:'Apply', properties:{style: 'toolbutton'}},
				}},//end of topGroup
				separatorLine: {type:'panel', align:'left'},
				rightGroup: {type:'group', align:'fill_fill', orientation:'column', children:{
					//右侧列表栏
					topGroup: {type:'group', align:'fill_fill', orientation:'stack', children:{
						view: {type:'group', orientation:'stack', align:'fill_fill', alignChildren:['fill', 'fill'], children:{
							scriptList: {type:'treeview', label:'script', format:'js|jsx|jsxbin'},
							expressionList: {type:'treeview', label:'expression', format:'txt'},
							presetList: {type:'treeview', label:'preset', format:'ffx'},
							templateList: {type:'treeview', label:'template', format:'aep'},
							effectList: {type:'treeview', label:'effect'},
							searchList: {type:'treeview', align:'fill_fill', label:'search'},
						}},
						likeGroup: {type:'group', align:'right_bottom', orientation:'column', children:{
							likeBar: {type:'iconbutton', align:'center_bottom', label:'like_line', label2:'like_fill', helpTip:'Like', properties:{style: 'toolbutton'}},
							expandBar: {type:'iconbutton', align:'center_bottom', label:'expand', helpTip:'Expand', properties:{style: 'toolbutton'}},
						}},
						closeGroup: {type:'group', align:'right_bottom', orientation:'row', children:{
							moveUp: {type:'iconbutton', align:'right_center', label:'moveUp', helpTip:'Move up', properties:{style: 'toolbutton'}},
							moveDown: {type:'iconbutton', align:'right_center', label:'moveDown', helpTip:'Move down', properties:{style: 'toolbutton'}},
							moveTo: {type:'iconbutton', align:'right_center', label:'moveTo', helpTip:'Move to', properties:{style: 'toolbutton'}},
							closeBar: {type:'iconbutton', align:'right_center', label:'close', helpTip:'Close', properties:{style: 'toolbutton'}},
						}},
					}},
					//底部工具栏
					bottomGroup: {type:'group', orientation:'row', align:'fill_bottom', alignChildren:['right','center'], children:{
						createItem: {type:'iconbutton', size:[25,25], label:'create', helpTip:'New', properties:{style: 'toolbutton'}},
						createGroup: {type:'iconbutton', size:[25,25], label:'createGroup', helpTip:'New group', properties:{style: 'toolbutton'}},
						rename: {type:'iconbutton', size:[25,25], label:'rename', helpTip:'Rename', properties:{style: 'toolbutton'}},
						edit: {type:'iconbutton', size:[25,25], label:'edit', helpTip:'Edit', properties:{style: 'toolbutton'}},
						remove: {type:'iconbutton', size:[25,25], label:'delete', helpTip:'Delete', properties:{style: 'toolbutton'}},
						open: {type:'iconbutton', size:[25,25], label:'open', helpTip:'Open the file location', properties:{style: 'toolbutton'}}
					}}
				}}//end of leftGroup
			}}//end of group
		}}//end of mainGroup
	}}//end of mainWin
};
//
var subUIJson = {
	//创建组，重命名使用此UI
	groupUI:{
		group: {type:'group', align:'fill', children:{
			name_box: {type:'edittext', align:'fill_center'},
			save: {type:'button', align:'right_center', text:'Save'}
		}}
	},
	//文本创建与修改
	textUI:{
		group: {type:'group', align:'fill', orientation:'column', children:{
			text_box: {type:'edittext', align:'fill', properties:{multiline:1}},
			group: {type:'group', align:'bottom', children:{
				format_box: {type:'dropdownlist', align:'left_center'},
				name_box: {type:'edittext', align:'fill_center'},
				exec: {type:'button', align:'right_center', text:'Execute'},
				save: {type:'button', align:'right_center', text:'Save'}
			}}
		}}
	},
	//效果插件的添加与修改
	effectUI:{
		group: {type:'group', align:'fill', orientation:'column', children:{
			nameGroup: {type:'group', align:'top', children:{
				statictext: {type:'statictext', align:'left_center', text:'Name'},
				name_box: {type:'edittext', align:'fill_center'}
			}},
			applyNameGroup: {type:'group', align:'top', children:{
				statictext: {type:'statictext', align:'left_center', text:'Name To Use'},
				apply_name_box: {type:'edittext', align:'fill_center'}
			}},
			matchNameGroup: {type:'group', align:'top', children:{
				statictext: {type:'statictext', align:'left_center', text:'MatchName'},
				match_name_box: {type:'edittext', align:'fill_center'}
			}},
			save: {type:'button', align:'top', text:'Save'}
		}}
	},
	//移动到功能
	moveUI:{
		group: {type:'group', orientation:'column', align:'fill', children:{
			tree_box: {type:'treeview', align:'fill'},
			move_to: {type:'button', align:'bottom', text:'Move To'}
		}}
	},
	//添加预设
	layerTypeUI: {
		group: {type:'group', orientation:'column', align:'fill', children:{
			solid_layer: {type:'button', align:'top', text:'Solid'},
			shape_layer: {type:'button', align:'top', text:'Shape'},
			text_layer: {type:'button', align:'top', text:'Text'},
			null_layer: {type:'button', align:'top', text:'Null'},
			camera_layer: {type:'button', align:'top', text:'Camera'},
			light_layer: {type:'button', align:'top', text:'Light'},
		}}
	},
	//帮助
	helpUI: {
		group: {type:'group', orientation:'column', align:'fill', children:{
			picture: {type:'image', align:'top', label:'picture'},
			help_box: {type:'edittext', align:'fill', properties:{multiline:1, readonly:1}},
		}}
	}
}
/**************************辅助函数******************************************************************************/
var addTreeFromFolder =  function (node, folder, format, level) {//从文件夹创建树（节点，文件夹，格式(例如'png|jpg')）
	if(level == null) level = 10;
	if(!level) return;
	var pathFiles = folder.getFiles();
	for(var i = 0; i < pathFiles.length; i++) {
		if(pathFiles[i].resolve()) var myFile = pathFiles[i].resolve();
		else var myFile = pathFiles[i];
		var fileName = File.decode(myFile.name);
		if (myFile instanceof Folder){
			if(myFile.name.match(/^\(.*\)$/)) continue;
			var imageFile = File(myFile.path + '/' + fileName + '.png');
			var newNode = node.add('node', {name:fileName, source:myFile, image:imageFile});
			arguments.callee(newNode, myFile, format, level-1);
		}else {
			if(eval("fileName.match(/\.(" + format + ")$/)")) {
				var newItem = node.add('item', {name:fileName, source:myFile, image:fns.getImage(myFile)});
			}
		}
	}
};
var addListFromTree =  function (node, tree, filter, exec) {//从树创建树形图
	var c = tree.children();
	for(var i = 0; i < c.length; i++) {
		if(filter && !filter(c[i])) continue;
		var newNode = null;
		var fileName = c[i].data.name;
		if (c[i].type == 'node'){
			newNode = node.add('node', fileName);
			newNode.dataItem = c[i];
			if(c[i].data.image.exists) newNode.image = c[i].data.image;
			else newNode.image = createGroupIcon;
			arguments.callee(newNode, c[i], filter, exec);
		}else {
			newNode = node.add('item', fileName);
			newNode.dataItem = c[i];
			if(c[i].data.image.exists) newNode.image = c[i].data.image;
		}
		if(exec && newNode) exec(newNode);
	}
};
var addLikeListFromTree =  function (rootNode, tree, sign) {//从树创建喜爱列表
	if(!sign) {
		var filter = function(e) {
			return e.data.liked == 1;
		};
	}else var filter = function(e) {return true;};
	allft(rootNode, tree, filter);
	function allft(rootNode, tree) {
		var c = tree.children();
		for(var i = 0; i < c.length; i++) {
			var newNode = null;
			var fileName = c[i].data.name;
			if (c[i].type == 'node'){
				if(filter(c[i])) {
					newNode = rootNode.add('node', fileName);
					newNode.dataItem = c[i];
					if(c[i].data.image.exists) newNode.image = c[i].data.image;
					else newNode.image = createGroupIcon;
					addLikeListFromTree(newNode, c[i], 1);
				}else arguments.callee(rootNode, c[i], filter);
			}else {
				if(!filter(c[i])) continue;
				newNode = rootNode.add('item', fileName);
				newNode.dataItem = c[i];
				if(c[i].data.image.exists) newNode.image = c[i].data.image;
			}
		}
	}
};
var setImage = function(image, label) {
	var imageFile = File(iconPath + label + '.png');
	if(imageFile.exists) image.image = File(iconPath + label + '.png');
}
/**************************创建窗口******************************************************************************/
var mainWin = Global instanceof Panel ? _(Global).addUI(UIJson.mainWin.children)[0].parent : _.newWindow(UIJson)[0];
_.windows.push(mainWin);
_('.iconbutton').each(function(e) {
	setImage(e, e.label);
});
var search = _('#search')[0];
//search.graphics.foregroundColor = search.graphics.newPen(search.graphics.PenType.SOLID_COLOR, [1, 0, 0], 1);
search.graphics.backgroundColor = search.graphics.newBrush(search.graphics.BrushType.SOLID_COLOR, [0.7,0.7,0.7]);
_('*').layout();
_('*').style({spacing:2});
/********************重要变量的声明和辅助函数fns*******************************************************************/
//声明重要变量
var mode = _('#mode')[0];
mode.label = 'script';
var _view = _('#view');
_view.current = _view[0];
var _mode = _('#mode');
var searchView = _('#searchList')[0];
var effectList = _('#effectList')[0];
var expandBar = _('#expandBar')[0];
var closeBar = _('#closeBar')[0];
var likeBar = _('#likeBar')[0];
var likeButton = _('#like')[0];

var fns = {
	getImage: function(file) {
		return File(eval("file.fullName.replace(/(" + fns.getFormat(file.name) + ")$/,'png')"));
	},
	readJsonFile: function(file) {
		return eval('(' + _.file.read(file) + ')');
	},
	refresh: function(exec) {
		var current = _view.current;
		current.tree = new Tree();
		if(current.label == 'effect') {
			var effectJsonFile = File(effectJsonPath);
			if(!effectJsonFile.exists) {
				_.file.create(effectJsonPath, '{"children":[]}');
			}
			current.tree.readJson(fns.readJsonFile(effectJsonFile), null, function(e) {
				e.data.image = File(rootPath + 'effect/' + e.data.name + '.png');
				// e.data.image = File(rootPathExpression + 'effect/' + e.data.name + '.png');
				
			});
			current.tree.path = effectJsonPath;
		}else {
			var path = rootPath + current.label;
			var folder = Folder(path);
			if(!folder) alert('Path ' + path + ' does not exist!');
			else addTreeFromFolder(current.tree, folder, current.format);
		}
		//
		fns.rebuild(exec);
	},//end of refresh
	execScript: function(source) {
		$.evalFile(source);
	},
	execExpression: function(source) {
		var myExpression = _.file.read(source);
		var sl = _.project.getSelectedLayers();
		if(sl) {
			for(var i = 0; i < sl.length; i++){
				var mySelectedProperty = sl[i].selectedProperties;
				for(var j = 0; j < mySelectedProperty.length; j++){
					try {
						mySelectedProperty[j].expression = myExpression;
					}catch(err){}
				}
			}
		}
	},
	apply: function() {
		if(searchView.visible) var e = searchView;
		else var e = _view.current;
		if(e.selection.dataItem.type == 'node') return;
		var data = e.selection.dataItem.data;
		var label = _view.current.label;
		app.beginUndoGroup(e.selection.text);
		try{
			switch(label) {
				case 'script': fns.execScript(data.source); break;
				case 'expression': fns.execExpression(data.source); break;
				case 'preset':
					var sl = _.project.getSelectedLayers();
					if(sl) {
						for(var i = 0; i < sl.length; i++) {
							sl[i].applyPreset(data.source);
						}
					}else{
						var comp = _.project.getActiveComp();
						if(!comp) break;
						fns.createWin('Apply preset to', subUIJson.layerTypeUI, function(e) {
							var win = e;
							var oc = function() {
								var layer = null;
								switch(this.id) {
									case 'solid_layer': layer = comp.layers.addSolid([1,1,1], fns.getName(data.name), comp.width, comp.height, comp.pixelAspect, comp.duration); break;
									case 'shape_layer': layer = comp.layers.addShape(); break;
									case 'text_layer': layer = comp.layers.addText('Super Assistant'); break;
									case 'null_layer': layer = comp.layers.addNull(); break;
									case 'camera_layer': layer = comp.layers.addCamera('camera', [comp.width,comp.height]/2); break;
									case 'light_layer': layer = comp.layers.addLight('light', [comp.width,comp.height]/2); break;
								}
								if(layer) layer.applyPreset(data.source);
								win.close();
							}
							_(win).find('.button').each(function(e) {e.onClick = oc});
						});
					}; break;
				case 'template':
					app.endUndoGroup();
					app.project.importFile(new ImportOptions(data.source));
					break;
				case 'effect':
					var sl = _.project.getSelectedLayers();
					if(sl) {
						for(var i = 0; i < sl.length; i++) {
							var myEffect = sl[i].effect.addProperty(data.matchName);
							myEffect.name = data.applyName;
						}
					}; break;
			}//end of switch
		}catch(err){alert(err)}
		app.endUndoGroup();
	},//end of apply
	mode: function() {
		var label = this.label;
		_mode.children().each(function(e) {
			if(e.label == label) setImage(e, e.label2);
			else setImage(e, e.label);
		});
		_view.children().each(function(e) {
			if(e.label == label) {
				e.visible = 1;
				_view.current = e;
				mode.label = label;
			}
			else e.visible = 0;
		});
		if(label == 'effect') expandBar.visible  = 1;
		else expandBar.visible = closeBar.parent.visible = 0;
		if(_view.current.tree != null && likeButton.sign != _view.current.sign) {
			_view.current.sign = likeButton.sign;
			fns.rebuild();
		}
	},
	rebuild: function(exec) {
		//喜欢设置
		var current = _view.current;
		if(current.likeTree && current.label != 'effect') {
			var c = current.likeTree.children();
			for(var i = 0; i < c.length; i++) {
				var item = _view.current.tree.find(function(e) {
					return e.data.name && rootPath + c[i].data.path == e.data.source.fullName;
				});
				if(item) item.data.liked = 1;
				else {
					//if(confirm('Files or folders ' + c[i].data.path + ' are not exists, do you like to remove it from your favorite list?')) {
					c[i].remove();
					fns.saveJson(likeBar.tree);
				}
			}
		}
		setImage(likeBar, likeBar.label);
		//刷新列表
		_view.current.removeAll();
		if(likeButton.sign) addLikeListFromTree(_view.current, _view.current.tree);
		else addListFromTree(_view.current, _view.current.tree, null, exec);
	},
	getPath: function(noSelf) {//获取当前状态下的路径，如果当前选中项为node，noself将不会将此node加进去
		if(searchView.visible) var s = searchView.selection;
		else var s = _view.current.selection;
		var label = _view.current.label;
		if(label == 'effect' || !s) var path = rootPath + _view.current.label;
		else {
			var path = s.dataItem.data.source.path;
			if(!noSelf && s.dataItem.type == 'node') path += '/' + s.text;
		}
		return File.decode(path + '/');
	},
	getNode: function() {
		var s = effectList.selection;
		var node = _view.current.tree;
		if(s) {
			node = s.dataItem;
			if(node.type == 'item') node = node.parent;
		}
		return node;
	},
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
	saveJson: function(tree) {
		var jsonStr = _.JSON.stringify(tree.writeJson(function(n, v) {
			return n == 'name' || n == 'applyName' || n == 'matchName' || n == 'liked' || n == 'path';
		}));
		_.file.create(tree.path, jsonStr);
	},
	saveFile: function(data, name, content, format) {
		if(name == '') {
			alert('File name can not be empty!');
			return false;
		}
		if(data) {
			var path = data.source.path + '/';
			var oldName = path + data.name;
		}else {
			var path = fns.getPath();
			var oldPath = path + name + '.' + format;
		}
		var newPath = path + name + '.' + format;
		if ((!data || (name + '.' + format) != data.name) && File(newPath).exists && !confirm('A file with this name already exists.do you want to replace that file?')) return false;
		else {
			if(data) {
				File(oldPath).remove();
				fns.renameImage(data.image, name);
			}
			alert('Successfully saved!');
			return _.file.create(newPath, content);
		}
	},
	rename: function(dataItem, name) {
		var data = dataItem.data;
		var path = data.source.path + '/';
		var newName = name;
		if(dataItem.type == 'node') {
			if(Folder(path + newName).exists) {
				alert('A folder with this name already exit!');
				return;
			}
		}else {
			newName += '.' + fns.getFormat(data.source.name);
			if(File(path + newName).exists && !confirm('A file with this name already exists.do you want to replace that file?')) return;
		}
		data.source.rename(newName);
		fns.renameImage(data.image, name);
	},
	getName: function(fileName) {
		var index = fileName.lastIndexOf('.');
		if(index != -1) fileName = fileName.substring(0, index);
		return fileName;
	},
	getFormat: function(fileName) {
		return fileName.substring(fileName.lastIndexOf('.') + 1);
	},
	renameImage: function(image, name) {
		if(!image.exists) return;
		var fileName = name + '.png';
		var path = image.path + '/';
		if(confirm('Rename the icon?')) {
			if(File(path + fileName).exists) {
				var prefix = 'old_';
				var mixName = prefix + fileName;
				while(File(path + mixName).exists) mixName = prefix + mixName;
				File(path + fileName).rename(path + mixName);
			}
			image.rename(path + fileName);
		}
	},
	getExpression: function() {
		var sl = _.project.getSelectedLayers();
		if(sl && sl[0].selectedProperties.length > 0) {
			var slp = sl[0].selectedProperties;
			for(var j = 0; j < slp.length; j++) {
				if(isValid(slp[j].expression) && slp[j].expression != null) {
					return slp[j].expression;
					break;
				}
			}
		}
		return '';
	},
	getEffect: function() {
		var sl = _.project.getSelectedLayers();
		if(sl) {
			var myPro = sl[0].selectedProperties;
			if(myPro.length > 0 && myPro[0].parentProperty.matchName == 'ADBE Effect Parade') {
				return myPro[0];
			}
		}
		return false;
	},
	getRelativePath: function(file) {
		return file.fullName.replace(rootPath, '');
	},
};
/***************************绑定事件****************************************************************************/
_('*').each(function(e) {
	switch(e.id) {
		case 'refresh': e.onClick = fns.refresh; break;
		case 'help': e.onClick = function() {
			var helpFile = File(rootPath + 'readme.txt');
			if(helpFile.exists) var helpStr = _.file.read(File(rootPath + 'readme.txt'));
			else helpStr = 'Super Assistant was used for managing the scripts, expressions, presets, templates and effects what we used frequently, and it will improve the efficiency greatly.\nAuthor: Amuliang\nEmail: 982632988@qq.com\nDate: 2015/12/21';
			//alert(helpStr);
			fns.createWin('Help', subUIJson.helpUI, function(e) {
				try{
				var win = e;
				var pic = _(win).find('#picture')[0];
				var help = _(win).find('#help_box')[0];
				setImage(pic, pic.label);
				help.text = helpStr;
				}catch(err){alert(err)}
			});/////////////////////////////////////////////////////////////////////////////////
		}; break;
		case 'search': e.onChanging = function () {
			if(this.text == '') {
				searchView.visible = 0;
				_view.current.visible = 1;
				return;
			}
			searchView.visible = 1;
			_view.current.visible = 0;
			searchView.removeAll();
			var str = this.text;
			var tree = _view.current.tree;
			addListFromTree(searchView, _view.current.tree, function(e) {
				if(e.type == 'item') {
					try{//用try语句保证可以正确完成搜索，可以包含正则表达式
						if(!eval("e.data.name.match(/"+str+"/i)")) return false;
					}catch(err){
						try{
							if(!eval("e.data.name.match("+str+")")) return false;
						}catch(err){}
					}
				}
				return true;
			});
			_.treeview.removeEmptyNode(searchView);
			_.treeview.expandAllNode(searchView);
		}; break;
		case 'expandBar':
		case 'closeBar': e.onClick = function() {
			expandBar.visible = !expandBar.visible;
			closeBar.parent.visible = !closeBar.parent.visible;
		}; break;
		case 'like': e.onClick = function() {
			this.sign = !this.sign;
			if(this.sign) setImage(this, this.label2);
			else setImage(this, this.label);
			fns.rebuild();
			_view.current.sign = this.sign;
		}; break;
		case 'likeBar': e.onClick = function() {
			var s = _view.current.selection;
			if(!s) return;
			var data = s.dataItem.data;
			if(_view.current.label == 'effect') {
				if(data.liked) setImage(this, this.label);
				else setImage(this, this.label2);
				data.liked = !data.liked;
				fns.saveJson(effectList.tree);
			}else {
				if(data.liked) {
					var item = _view.current.likeTree.find(function(e) {
						return rootPath + e.data.path == data.source.fullName;
					});
					if(item) item.remove();
					setImage(this, this.label);
				}else {
					_view.current.likeTree.add('item', {
						name:File.decode(data.source.name),
						path:fns.getRelativePath(data.source)
					});
					setImage(this, this.label2);
				}
				data.liked = !data.liked;
				fns.saveJson(this.tree);
			}
			if(likeButton.sign) fns.rebuild();
		}; break;
		case 'moveUp': e.onClick = function() {
			var s = _view.current.selection;
			if(!s) {
				if(this.parent.selected) s = this.parent.selected;
				else return;
			}
			var dataItem = s.dataItem;
			if(dataItem.prev == null) return;
			var label = _view.current.label;
			if(label == 'effect') {
				dataItem.moveUp();
				fns.saveJson(effectList.tree);
				fns.rebuild();
				_.treeview.expandAllNode(_view.current);
				var moveUpButton = this;
				_(_view.current).find('*').each(function(e) {
					if(e.dataItem == dataItem)  moveUpButton.parent.selected = e;
				});
			}
		}; break;
		case 'moveDown': e.onClick = function() {
			var s = _view.current.selection;
			if(!s) {
				if(this.parent.selected) s = this.parent.selected;
				else return;
			}
			var dataItem = s.dataItem;
			if(dataItem.next == null) return;
			var label = _view.current.label;
			if(label == 'effect') {
				dataItem.moveDown();
				fns.saveJson(effectList.tree);
				fns.rebuild();
				_.treeview.expandAllNode(_view.current);
				var moveDownButton = this;
				_(_view.current).find('*').each(function(e) {
					if(e.dataItem == dataItem)  moveDownButton.parent.selected = e;
				});
			}
		}; break;
		case 'moveTo': e.onClick = function() {
			var current = _view.current;
			var s = current.selection;
			if(!s) return;
			var label = current.label;
			var dataItem = s.dataItem;
			fns.createWin('Move To', subUIJson.moveUI, function(e) {
				var win = e;
				var tree = _(win).find('#tree_box')[0];
				addListFromTree(tree, current.tree, function(e) {
					if(e.type == 'item' || e == dataItem) return false;
					else return true;
				});
				_(win).find('#move_to')[0].onClick = function() {
					if(label == 'effect') {
						if(tree.selection) {
							var di = tree.selection.dataItem;
							if(di.type == 'item') di = di.parent;
							dataItem.moveTo(di);
						}else dataItem.moveTo(current.tree.root);
						fns.saveJson(effectList.tree);
						win.close();
						fns.refresh();
					}else {

					}
				}
			});
		}; break;
		case 'apply': e.onClick = fns.apply; break;
		case 'createItem': e.onClick = function() {
			var label = _view.current.label;
			if(label == 'script' || label == 'expression') {
				fns.createWin('New', subUIJson.textUI, function(e){
					var win = e;
					var name = _(win).find('#name_box')[0];
					var content = _(win).find('#text_box')[0];
					var format = _(win).find('#format_box')[0];
					if(label == 'expression') content.text = fns.getExpression();
					_.dropdownlist.addItem(format, _view.current.format.split('|')).selection = 0;
					_(win).find('#exec')[0].onClick = function(e) {
						var file = _.file.create(cache_file_path, content.text);
						if(file) {
							try{
								if(label == 'script') fns.execScript(file);
								else fns.execExpression(file);
							}catch(err){alert(err.toString()+"\rError line:"+err.line.toString())}
						}
					}
					_(win).find('#save')[0].onClick = function(e) {
						fns.saveFile(null, name.text, content.text, format.selection.text);
						fns.refresh();
					}
				}, function(e) {
					e.size = [300, 300];
				});//end of createWin
			}else if(label == 'effect') {
				fns.createWin('New Effect', subUIJson.effectUI, function(e){
					var win = e;
					var name = _(win).find('#name_box')[0];
					var applyName = _(win).find('#apply_name_box')[0];
					var matchName = _(win).find('#match_name_box')[0];
					var myPro = fns.getEffect();
					if(myPro) {
							name.text = myPro.name;
							applyName.text = myPro.name;
							matchName.text = myPro.matchName;
					}
					_(win).find('#save')[0].onClick = function(e) {
						try{
						var node = fns.getNode();
						node.add('item', {name:name.text, applyName:applyName.text, matchName:matchName.text});
						fns.saveJson(effectList.tree);
						win.close();
						fns.refresh();
						}catch(err){alert(err.toString()+"\rError line:"+err.line.toString())}
					}//end of onClick
				});//end of createWin
			}
		}; break;
		case 'createGroup': e.onClick = function() {
			fns.createWin('New Group', subUIJson.groupUI, function(e){
				var win = e;
				_(win).find('#save')[0].onClick = function(e) {
					var name = _(win).find('#name_box')[0];
					if(_view.current.label == 'effect') {
						var node = fns.getNode();
						node.add('node', {name:name.text});
						fns.saveJson(effectList.tree);
					}else {
						var path = fns.getPath(1) + name.text;
						if(Folder(path).exists) {
							alert('A folder with this name already exists!');
							return;
						}else _.folder.create(path);
					}
					win.close();
					fns.refresh();
				}
			});
		}; break;
		case 'rename': e.onClick = function() {
			var s = _view.current.selection;
			if(!s) return;
			var label = _view.current.label;
			var dataItem = s.dataItem;
			var data = dataItem.data;
			var type = dataItem.type;
			fns.createWin('Rename', subUIJson.groupUI, function(e){
				var win = e;
				var name = _(win).find('#name_box')[0];
				if(type == 'node') name.text = data.name;
				else name.text = fns.getName(data.name);
				_(win).find('#save')[0].onClick = function(e) {
					if(label == 'effect') {
						data.name = name.text;
						fns.saveJson(effectList.tree);
					}else fns.rename(dataItem, name.text);
					win.close();
					fns.refresh();
				}//end of onClick
			});//end of createWin
		}; break;
		case 'edit': e.onClick = function() {
			var current = _view.current;
			var s = current.selection;
			if(!s || s.dataItem.type == 'node') return;
			var data = s.dataItem.data;
			var label = _view.current.label;
			if(label == 'effect') {
				fns.createWin('Edit effect', subUIJson.effectUI, function(e){
					var win = e;
					var name = _(win).find('#name_box')[0];
					var applyName = _(win).find('#apply_name_box')[0];
					var matchName = _(win).find('#match_name_box')[0];
					name.text = data.name;
					applyName.text = data.applyName;
					matchName.text = data.matchName;
					_(win).find('#save')[0].onClick = function(e) {
						data.name = name.text;
						data.applyName = applyName.text;
						data.matchName = matchName.text;
						fns.renameImage(data.image, name.text);
						fns.saveJson(effectList.tree);
						win.close();
						fns.refresh();
					}//end of onClick
				});//end of createWin
			}else if(label == 'script' || label == 'expression'){
				fns.createWin('Edit Text', subUIJson.textUI, function(e){
					var win = e;
					var name = _(win).find('#name_box')[0];
					var content = _(win).find('#text_box')[0];
					var format = fns.getFormat(data.name);
					name.text = fns.getName(data.name);
					content.text = _.file.read(data.source);
					_.dropdownlist.addItem(_(win).find('#format_box')[0], [format]).selection = 0;
					_(win).find('#exec')[0].onClick = function(e) {
						var file = _.file.create(cache_file_path, content.text);
						if(file) {
							try{
								if(label == 'script') fns.execScript(file);
								else fns.execExpression(file);
							}catch(err){alert(err.toString()+"\rError line:"+err.line.toString())}
						}
					}
					_(win).find('#save')[0].onClick = function(e) {
						fns.saveFile(data, name.text, content.text, format);
						fns.refresh();
					}//end of onClick
				});//end of createWin
			}
		}; break;
		case 'remove': e.onClick = function() {
			var s = _view.current.selection;
			if(!s || !confirm('Confirm delete? Will not be restored')) return;
			if(_view.current.label == 'effect') {
				s.dataItem.remove();
				fns.saveJson(effectList.tree);
				_view.current.remove(s);
			}else {
				var f = s.dataItem.data.source;
				if(f.exists) {
					f.remove();
					s.dataItem.remove();
				}
				if(!f.exists) _view.current.remove(s);
			}
		}; break;
		case 'open': e.onClick = function() {
			var path = fns.getPath();
			if(Folder(path).exists) {
				if(_.app.getOS() == 'windows') system.callSystem('cmd /c explorer ' + path.replace(/^\//, '').replace(/\//, ':\\').replace(/\//g, '\\'));
				else system.callSystem('open ' + path);
			}
		}; break;
	}
});
_(mode).children().each(function(e) {
	e.onClick = fns.mode;
});
/***************************初始化****************************************************************************/
//喜欢设置
var likeFile = File(favourateJsonPath);
likeBar.tree = new Tree();
if(!likeFile.exists) {
	_.file.create(favourateJsonPath, '{"children": [{"name": "script", "children": []}, {"name": "expression", "children": []}, {"name": "preset", "children": []}, {"name": "template", "children": []}, {"name": "effect", "children": []}]}');
}
likeBar.tree.readJson(fns.readJsonFile(File(favourateJsonPath)));
likeBar.tree.path = favourateJsonPath;
//
_view.children().each(function(e) {
	e.sign = 0;
	e.onDoubleClick = fns.apply;
	e.onChange = function() {
		var s = _view.current.selection;
		if(!s || !s.dataItem.data.liked) return setImage(likeBar, likeBar.label);
		else setImage(likeBar, likeBar.label2);
		//if(_view.current.label == 'effect') var item = data.liked;
		//else {
		//	var item = _view.current.likeTree.find(function(e) {
		//		return rootPath + e.data.path == data.source.fullName;
		//	});
		//}
	}
	var label = e.label;
	e.likeTree = likeBar.tree.find(function(e) {
		return e.data.name == label;
	});
});
//创建所有列表
var c = _(mode).children();
for(var i = c.length-1; i >= 0; i--) {
	fns.mode.call(c[i]);
	fns.refresh();
}
closeBar.parent.visible = 0;
/**************显示界面******************************************************************************************/
_.window.resize(mainWin);
if(mainWin instanceof Window) {
	mainWin.show();
}
})(this);