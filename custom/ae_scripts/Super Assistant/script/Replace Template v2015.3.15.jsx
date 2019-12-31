//作者：阿木亮	邮箱：982632988@qq.com	最后修改时间：2015/3/31

var replaceTemplate = {};

replaceTemplate.xml = {
	read: function (xmlFile) {//读取xml文件，返回一个XML对象
		xmlFile.open("r");
		var xmlString = xmlFile.read();
		var myXML = new XML(xmlString);
		xmlFile.close();
		
		return myXML;
	},
};

replaceTemplate.file = {
	read: function (path) {//读取文本文件，返回String对象（文本文件路径）
		var file = File(path);
		file.open("r");
		var myString = file.read();
		file.close();
		
		return myString;
	},
	create: function (path, text) {//创建文本文件，返回File对象（文本文件路径，文本内容）
		var newFile = new File(path);
		newFile.open('w');
		if(text != null) {
			newFile.write(text);
		}
		newFile.close();
		
		return newFile;
	},
};

replaceTemplate.treeview = {
	addListOfFolder: function (node, folder, format) {//从文件夹创建树形图（节点，文件夹，格式(例如'png|jpg')）
		var pathFiles = folder.getFiles();
		for(var i = 0; i < pathFiles.length; i++) {
			if (pathFiles[i] instanceof Folder){
				if(pathFiles[i].name.match(/^\(.*\)$/)) {
					continue;
				}
				var newNode = node.add('node', File.decode(pathFiles[i].name));
				newNode.source = pathFiles[i];
				arguments.callee(newNode, pathFiles[i], format);
			}else {
				if(format == null) {
					//node.add('item', File.decode(pathFiles[i].name));
					continue;
				}
				if(eval("pathFiles[i].name.match(/\.(" + format + ")$/i)")) {
					var newItem = node.add('item', File.decode(pathFiles[i].name));
					newItem.source = pathFiles[i];
					/*var imageFile = File(pathFiles[i].path + '/' + eval("pathFiles[i].name.replace(/(" + format + ")$/,'')") + 'png');
					if(imageFile.exists) {
						newItem.image = imageFile;
					}*/
				}
			}
		}
	},
	removeEmptyNode: function (node) {//删除没有item的节点(节点)
		for(var len = node.items.length, i = len - 1; i >= 0; i--) {
			if(node.items[i].type == 'node') {
				arguments.callee(node.items[i]);
				if(node.items[i].items.length == 0) {
					node.remove(node.items[i]);
				}
			}
		}
	},
	getPathOfNode: function (node, sign) {//根据树形图生成路径(节点，连接符)
		var myPath = sign;
		if(node.parent != null && node.parent.type == 'node') {
			myPath = arguments.callee(node.parent, sign) + node.parent.text + sign;
		}
		return myPath;
	},
	expandAllNode: function (node) {//展开所有节点（节点）
		node.expanded = 1;
		for(var i = 0; i < node.items.length; i++) {
			if(node.items[i].type == 'node') {
				arguments.callee(node.items[i]);
			}
		}
	},
};

replaceTemplate.project = {
	getSelectedLayers: function () {//获取选中的图层，返回图层数组，否则返回false
		var thisComp = app.project.activeItem;
		if(!(thisComp instanceof CompItem) || thisComp.selectedLayers.length == 0){
			return false;
		}
		return thisComp.selectedLayers;
	},
	getItemById: function (id) {//通过item的id获取对应item，否则返回false (id)
		for(var i = 1; i <= app.project.numItems; i++) {
			if(app.project.item(i).id == parseInt(id)) {
				return app.project.item(i);
			}
		}
	
		return false;
	},
	lookItemInProjectPanel: function (item) {//在窗口中找到并选中项目 (项目)
		for(var i = 1; i <= app.project.numItems; i++) {
			if(app.project.item(i).selected) {
				app.project.item(i).selected = 0;
			}
		}
		item.selected = 1;
	},
	looklayerInComp: function (layer) {//在显示合成并选中图层 (图层)
		var myComp = layer.containingComp;
		if(parseInt(app.version) > 9) {//因为cs4不支持openInViewer()函数
			myComp.openInViewer();
		}
		var sl = myComp.selectedLayers;
		for(var i = 0; i < sl.length; i++) {
			sl[i].selected = 0;
		}
		layer.selected = 1;
	},
};

replaceTemplate.window = {
	resize: function (window) {//自动改变布局大小（窗口）
		window.layout.layout(true);
		window.layout.resize();
		window.onResizing = window.onResize = function () {
			this.layout.resize();
		}
	},
};	

//以上为自定义库函数

replaceTemplate.str = {//从这里更改界面文字
	win: {
		title: 'Replace Template v2015.3.15',
		scheme: '方案',
		schemeInfo: '未命名方案.xml',
		create: '新建',
		importScheme: '导入',
		save: '保存',
		saveAs: '另存为',
		types: ['素材', '文本'],
		force: '强制读取',
		link: '链接',
		match: '匹配',
		matchType: ['原始比例', '匹配图层（高度/宽度）', '匹配图层高度', '匹配图层宽度', '匹配合成（高度/宽度）', '匹配合成高度', '匹配合成宽度'],
		centerLayer: '居中图层',
		replaceSource: '替换源',
		sequence: '序列帧',
		replaceCurrent: '替换当前',
		replaceAll: '全部替换',
		confirmSaveScheme: '是否保存当前方案？',
		dialogSelectFile: '请选择文件',
		alertSaveSuccess: '保存成功！',
		alertHasAdded: '已添加过图层',
		alertInvalidXML: '无效的xml文件！',
		alertSetting: '脚本正在请求文件写入或访问网络，请到"首选项->常规"确保"允许脚本写入文件和访问网络"一项被勾选',
		tipAdd: '添加',
		tipRemove: '移除',
		tipSmartAdd: '智能添加类似图层',
		tipSourceAdd: '从素材添加图层',
		tipRemoveAll: '清空',
		tipLookSource: '查看源',
		tipLookLayer: '查看图层',
		tipEnabled: '图层可见/不可见',
		tipBrowseFile: '浏览文件',
		tipTexts: '编辑文本',
	},
	fileWin: {
		title: '浏览文件',
		selectFile: '选择文件夹',
		refresh: '刷新',
		filterS: ' 过滤：',
		sS: ' 关键字:',
		filter: 'jpg|png|psd|avi|gif',
		tS: ' 显示方式:',
		expandAll: ' 展开',
		removed: '移除',
		link: '链接',
		linkAll: '自动链接全部',
		autoReplace: '自动替换',
	},
	textWin: {
		title: '文本',
		removed: '移除',
		link: '替换文本',
		autoReplace: '自动替换',
		separatorT: '分隔符',
		separator: '#',
	},
}

replaceTemplate.buyLink = "http://item.taobao.com/item.htm?spm=0.0.0.0.DJjeKc&id=43047415047";
replaceTemplate.schemePath = '';
replaceTemplate.importFolder = new Folder();

replaceTemplate.win = function(obj) {
	var str = this.str.win;
	{//界面
	var win = (obj instanceof Panel)? obj : new Window('window', str.title, undefined, {resizeable: true});
	win.margins = 0;
	{
	mainGroup = win.group = win.add(
		"group{\
			spacing: 0,\
			alignment: ['fill', 'fill'],\
			alignChildren: ['fill','top'],\
			orientation: 'column',\
			top: Panel{\
				margins: 0,\
				spacing: 0,\
				orientation: 'row',\
				scheme: Button{alignment: ['left', 'center'], size: [50, 20]},\
				right: Group{\
					spacing: 0,\
					alignment: ['fill', 'center'],\
					orientation: 'stack',\
					info: StaticText{alignment: ['fill', 'center']},\
					list: Group{\
						spacing: 0,\
						alignment: ['left', 'center'],\
						create: Button{size: [50, 20]},\
						importScheme: Button{size: [50, 20]},\
						save: Button{size: [50, 20]},\
						saveAs: Button{size: [50, 20]},\
					},\
				},\
				help: Button{text: '?', alignment: ['right', 'center'], size: [15, 20]},\
				types: DropDownList{alignment: ['right', 'center']},\
			},\
			bottom: Group{\
				margins: 0,\
				spacing: 0,\
				alignment: ['fill', 'fill'],\
				orientation: 'stick',\
				G1: Group{\
					margins: 0,\
					spacing: 0,\
					alignment: ['fill', 'fill'],\
					orientation: 'column',\
					center: Panel{\
						margins: 0,\
						spacing: 0,\
						alignment: ['fill', 'fill'],\
						orientation: 'column',\
						top: Group{\
							spacing: 0,\
							alignment: ['fill', 'top'],\
							a: Button{text:'+', alignment: ['left', 'center'], size: [20, 20]},\
							r: Button{text:'-', alignment: ['left', 'center'], size: [20, 20]},\
							aa: Button{text:'++', alignment: ['left', 'center'], size: [20, 20]},\
							sa: Button{text:'S+', alignment: ['left', 'center'], size: [20, 20]},\
							rr: Button{text:'--', alignment: ['left', 'center'], size: [20, 20]},\
							force: Checkbox{alignment: ['left', 'center']},\
							s: Button{text:'S', alignment: ['center', 'center'], size: [20, 20]},\
							c: Button{text:'C', alignment: ['center', 'center'], size: [20, 20]},\
							v: Button{text:'V', alignment: ['center', 'center'], size: [20, 20]},\
							f: Button{text:'F', alignment: ['right', 'center'], size: [20, 20]},\
						},\
						tree: TreeView{alignment: ['fill', 'fill']},\
					},\
					bottom: Group{\
						margins: 2,\
						spacing: 2,\
						alignment: ['fill', 'bottom'],\
						orientation: 'row',\
						left: Panel{\
							margins: 2,\
							spacing: 2,\
							alignment: ['fill', 'bottom'],\
							alignChildren: ['fill','top'],\
							orientation: 'column',\
							line1: Group{\
								spacing: 0,\
								link: Button{alignment: ['left', 'center'], size: [50, 20]},\
								path: EditText{alignment: ['fill', 'center'], size: [, 20]},\
							},\
							line2: Group{\
								spacing: 0,\
								match: StaticText{alignment: ['left', 'center']},\
								matchType: DropDownList{alignment: ['left', 'center']},\
								centerLayer: Checkbox{alignment: ['left', 'center']},\
							},\
							line3: Group{\
								spacing: 10,\
								replaceSource: Checkbox{alignment: ['left', 'center']},\
								sequence: Checkbox{alignment: ['left', 'center']},\
							},\
						},\
						right: Panel{\
							margins: 2,\
							spacing: 2,\
							alignment: ['right', 'fill'],\
							alignChildren: ['fill','fill'],\
							orientation: 'column',\
							replaceCurrent: Button{},\
							replaceAll: Button{},\
						},\
					},\
				},\
				G2: Group{\
					margins: 0,\
					spacing: 0,\
					alignment: ['fill', 'fill'],\
					orientation: 'column',\
					center: Panel{\
						margins: 0,\
						spacing: 0,\
						alignment: ['fill', 'fill'],\
						orientation: 'column',\
						top: Group{\
							spacing: 0,\
							alignment: ['fill', 'top'],\
							a: Button{text:'+', alignment: ['left', 'center'], size: [20, 20]},\
							r: Button{text:'-', alignment: ['left', 'center'], size: [20, 20]},\
							aa: Button{text:'++', alignment: ['left', 'center'], size: [20, 20]},\
							rr: Button{text:'--', alignment: ['left', 'center'], size: [20, 20]},\
							c: Button{text:'C', alignment: ['center', 'center'], size: [20, 20]},\
							v: Button{text:'V', alignment: ['center', 'center'], size: [20, 20]},\
							t: Button{text:'T', alignment: ['right', 'center'], size: [20, 20]},\
						},\
						tree: TreeView{alignment: ['fill', 'fill']},\
					},\
					bottom: Group{\
						margins: 2,\
						spacing: 2,\
						alignment: ['fill', 'fill'],\
						orientation: 'row',\
						left: Panel{\
							margins: 0,\
							alignment: ['fill', 'fill'],\
							alignChildren: ['fill','fill'],\
						},\
						right: Panel{\
							margins: 2,\
							spacing: 2,\
							alignment: ['right', 'fill'],\
							alignChildren: ['fill','fill'],\
							orientation: 'column',\
							replaceCurrent: Button{},\
							replaceAll: Button{},\
						},\
					},\
				},\
			},\
			\
			\
			\
		}");
	}
	var scheme = mainGroup.top.scheme;
	scheme.text = str.scheme;
	var schemeInfo = mainGroup.top.right.info;
	schemeInfo.text = str.schemeInfo;
	schemeInfo.graphics.foregroundColor = schemeInfo.graphics.newPen (schemeInfo.graphics.PenType.SOLID_COLOR, [0, 0.7, 0], 2);
	var schemeList = mainGroup.top.right.list;
	schemeList.visible = 0;
	schemeList.create.text = str.create;
	schemeList.importScheme.text = str.importScheme;
	schemeList.save.text = str.save;
	schemeList.saveAs.text = str.saveAs;
	var help = mainGroup.top.help; help.visible = 1;//添加帮助前暂时隐藏帮助按钮
	var types = mainGroup.top.types;
	for(var i = 0; i < str.types.length; i++) {
		types.add('item', str.types[i]);
	}
	var G1 = mainGroup.bottom.G1;
	var G1a = G1.center.top.a; G1a.helpTip = str.tipAdd;
	var G1r = G1.center.top.r; G1r.helpTip = str.tipRemove;
	var G1aa = G1.center.top.aa; G1aa.helpTip = str.tipSmartAdd;
	var G1sa = G1.center.top.sa; G1sa.helpTip = str.tipSourceAdd;
	var G1rr = G1.center.top.rr; G1rr.helpTip = str.tipRemoveAll;
	var force = G1.center.top.force;
	force.text = str.force;
	var G1s = G1.center.top.s; G1s.helpTip = str.tipLookSource;
	var G1c = G1.center.top.c; G1c.helpTip = str.tipLookLayer;
	var G1v = G1.center.top.v; G1v.helpTip = str.tipEnabled;
	var G1f = G1.center.top.f; G1f.helpTip = str.tipBrowseFile;
	var G1T = G1.center.tree;
	replaceTemplate.imageTree = G1T;
	var G1A = G1.bottom;
	var G2 = mainGroup.bottom.G2;
	var G2a = G2.center.top.a; G2a.helpTip = str.tipAdd;
	var G2r = G2.center.top.r; G2r.helpTip = str.tipRemove;
	var G2aa = G2.center.top.aa; G2aa.helpTip = str.tipSmartAdd;
	var G2rr = G2.center.top.rr; G2rr.helpTip = str.tipRemoveAll;
	var G2c = G2.center.top.c; G2c.helpTip = str.tipLookLayer;
	var G2v = G2.center.top.v; G2v.helpTip = str.tipEnabled;
	var G2t = G2.center.top.t; G2t.helpTip = str.tipTexts;
	var G2T = G2.center.tree;
	replaceTemplate.textTree = G2T;
	var G2A = G2.bottom;
	var attr1 = G1A.left;
	var attr2 = G2A.left;
	var link = attr1.line1.link;
	link.text = str.link;
	var linkPath = attr1.line1.path;
	replaceTemplate.linkPath = linkPath;
	attr1.line2.match.text = str.match;
	var matchType = attr1.line2.matchType;
	for(var i = 0; i < str.matchType.length; i++) {
		matchType.add('item', str.matchType[i]);
	}
	var centerLayer = attr1.line2.centerLayer;
	centerLayer.text = str.centerLayer;
	var replaceSource = attr1.line3.replaceSource;
	replaceSource.text = str.replaceSource;
	var sequence = attr1.line3.sequence;
	sequence.text = str.sequence;
	var texts = attr2.texts = attr2.add('edittext', undefined, '', {multiline:1});
	var execute1 = G1A.right;
	var execute2 = G2A.right;
	var replaceCurrent1 = execute1.replaceCurrent;
	replaceCurrent1.text = str.replaceCurrent;
	replaceTemplate.replaceCurrent1 = replaceCurrent1;
	var replaceAll1 = execute1.replaceAll;
	replaceAll1.text = str.replaceAll;
	var replaceCurrent2 = execute2.replaceCurrent;
	replaceTemplate.replaceCurrent2 = replaceCurrent2;
	replaceCurrent2.text = str.replaceCurrent;
	var replaceAll2 = execute2.replaceAll;
	replaceAll2.text = str.replaceAll;
	}

	scheme.onClick = function() {
		schemeList.visible = !schemeList.visible;
		schemeInfo.visible = !schemeList.visible;
	}
	
	types.onChange = function() {
		if(this.selection.index == 0) {
			G1.visible = 1;
			G2.visible = 0;
		}else {
			G1.visible = 0;
			G2.visible = 1;
		}
	}

	schemeList.create.onClick = function() {
		if(confirm(str.confirmSaveScheme)) {
			if(!schemeList.save.onClick()) {
				scheme.onClick();
				return false;
			}
		}else {
			scheme.onClick();
		}
		replaceTemplate.schemePath = '';
		schemeInfo.text = str.schemeInfo;
		G1T.removeAll();
		G2T.removeAll();
		G1T.onChange();
		G2T.onChange();
		return true;
	}

	schemeList.importScheme.onClick = function() {
		if(!schemeList.create.onClick()) {
			return false;
		}
		var myFile = File.openDialog(str.dialogSelectFile, 'javascript:*.xml*');
		if(myFile == null) {
			return;
		}
		var myXML = replaceTemplate.xml.read(myFile);
		//G1T.removeAll();
		//G2T.removeAll();
		//G1T.onChange();
		//G2T.onChange();
		if(!isValid(myXML.title) || myXML.title != 'scheme') {
			alert(str.alertInvalidXML);
			return;
		}
		replaceTemplate.buildListFromXml(G1T, myXML.image);
		replaceTemplate.buildListFromXml2(G2T, myXML.text);
		replaceTemplate.treeview.removeEmptyNode(G1T);
		replaceTemplate.treeview.removeEmptyNode(G2T);
		schemeInfo.text = File.decode(myFile.name);
		replaceTemplate.schemePath = myFile.path + '/' + myFile.name;
		//scheme.onClick();
	}

	schemeList.save.onClick = function() {
		if (!replaceTemplate.isSecurityPrefSet()) {//保证ae允许写入文件
			alert (str.alertSetting);	
			try{
				app.executeCommand(2359);
			}catch (e) {
				alert(e);
			}
			if (!replaceTemplate.isSecurityPrefSet()) {
				return false;
			}
		}
		if(replaceTemplate.schemePath == '') {
			return schemeList.saveAs.onClick();
		}
		var myScheme = <xml><title>scheme</title><image></image><text></text></xml>;
		replaceTemplate.treeToXML(G1T, myScheme.image);
		replaceTemplate.treeToXML2(G2T, myScheme.text);
		replaceTemplate.file.create(replaceTemplate.schemePath, myScheme);
		alert(str.alertSaveSuccess);
		schemeInfo.text = File.decode(File(replaceTemplate.schemePath).name);
		scheme.onClick();
		return true;
	}

	schemeList.saveAs.onClick = function() {
		//var myScheme = <xml><title>scheme</title><image></image><text></text></xml>;
		//replaceTemplate.treeToXML(G1T, myScheme.image);
		//replaceTemplate.treeToXML2(G2T, myScheme.text);
		var myFile = File.saveDialog("另存为", 'javascript:*.xml*');
		if(myFile == null) {
			return false;
		}
		//replaceTemplate.file.create(myFile.path + '/' + myFile.name, myScheme);
		//schemeInfo.text = File.decode(myFile.name);
		replaceTemplate.schemePath = myFile.path + '/' + myFile.name;
		schemeList.save.onClick();
		//alert(str.alertSaveSuccess);
		//scheme.onClick();
		return true;
	}
	
	G1a.click = function(sl) {
		if(!sl || sl.length <= 0) {
			return;
		}
	
		var containingComp = sl[0].containingComp;
		var myNode = replaceTemplate.check(G1T, containingComp);
		for(var i = 0; i < sl.length; i++) {
			if(!force.value && !(sl[i].source instanceof FootageItem) && !(sl[i].source instanceof CompItem)) {
				continue;
			}
			var b = 1;
			for(var j = 0; j < myNode.items.length; j++){
				if(myNode.items[j].id == containingComp.id && myNode.items[j].layerIndex == sl[i].index) {
					b = 0;
					alert(str.alertHasAdded + ' ' + containingComp.name + ' --> 图层' + sl[i].index + ' ' + sl[i].name);
					break;
				}
			}
			if(b) {
				var newItem = myNode.add('item', containingComp.name + ' --> 图层' + sl[i].index + ' ' + sl[i].name);
				newItem.id = containingComp.id;
				newItem.layerIndex = sl[i].index;
				newItem.link = '';
				newItem.match = 1;
				newItem.centerLayer = 1;
				newItem.replaceSource = sl[i].source.usedIn&&sl[i].source.usedIn.length>1 ? 0:1;
				newItem.sequence = 0;
			}
		}
		replaceTemplate.treeview.removeEmptyNode(G1T);
		G1T.onChange();
	}
	G1a.onClick = function() {
		var sl = replaceTemplate.project.getSelectedLayers();
		if(!sl) {
			return;
		}
		G1a.click(sl);
	}
	
	G1r.onClick = function() {
		var s = G1T.selection;
		if(!isValid(s)) {
			return;
		}
		//G1T.remove(s);
		s.parent.remove(s);
		replaceTemplate.treeview.removeEmptyNode(G1T);
		G1T.onChange();
		//schemeInfo.text = File.decode(File(replaceTemplate.schemePath).name + '*');
	}
	
	G1aa.onClick = function() {
		var s = G1T.selection;
		if(!isValid(s)) {
			return;
		}
        var myFolders = [];
        for(var i = 0; i < app.project.selection.length; i++) {//将选择的文件夹也包含在内
            if(app.project.selection[i] instanceof FolderItem) {
                myFolders.push(app.project.selection[i]);
            }
        }
        var c = replaceTemplate.project.getItemById(s.id);
        myFolders.push(c.parentFolder);
        
        for(var k = 0; k < myFolders.length; k++) {
            var myFolder = myFolders[k];
            if(myFolder == null) {
                myFolder = app.project;
            }
            var myItems = myFolder.items;
            /*for(var i = 1; i <= myItems.length; i++) {
                if(!(myItems[i] instanceof CompItem)) {
                    continue;
                }
                var myIndex = myItems[i].numLayers < s.layerIndex ? myItems[i].numLayers : s.layerIndex;
                var sl = myItems[i].layer(s.layerIndex);
                if(!isValid(sl.source)) {// || !(sl.source instanceof FootageItem) && !(sl.source instanceof CompItem)
                    continue;
                }
                c.layer(myIndex).copyToComp(myItems)
            }*/
            app.beginUndoGroup(str.tipSmartAdd);
            for(var i = 1; i <= myItems.length; i++) {
                if(!(myItems[i] instanceof CompItem)) {
                    continue;
                }
                if(force.value) {
                    if(myItems[i].numLayers < s.layerIndex) {
                        c.layer(s.layerIndex).copyToComp(myItems[i]);
                        myItems[i].layer(1).moveToEnd();
                        var sl = myItems[i].layer(myItems[i].numLayers);
                    }else {
                        var sl = myItems[i].layer(s.layerIndex);
                    }
                } else {
                    if(myItems[i].numLayers < s.layerIndex) {
                        continue;
                    }
                    var sl = myItems[i].layer(s.layerIndex);
                    if(!isValid(sl.source) || !(sl.source instanceof FootageItem) && !(sl.source instanceof CompItem)) {
                        continue;
                    }
                }
                var b = 1;
                var myNode = replaceTemplate.check(G1T, myItems[i]);
                for(var j = 0; j < myNode.items.length; j++){
                    if(myNode.items[j].id == myItems[i].id && myNode.items[j].layerIndex == s.layerIndex) {
                        b = 0;
                        break;
                    }
                }
                if(b) {
                    var newItem = myNode.add('item', myItems[i].name + ' --> 图层' + sl.index + ' ' + sl.name);
                    newItem.id = myItems[i].id;
                    newItem.layerIndex = sl.index;
                    newItem.link = '';
                    newItem.match = s.match;
					newItem.centerLayer = s.centerLayer;
                    newItem.replaceSource = s.replaceSource;
                    newItem.sequence = s.sequence;
                }
            }
		}
		app.endUndoGroup();
		G1T.onChange();
	}
	
	G1sa.onClick = function() {
		var selectedItems = app.project.selection;
		if(!selectedItems.length) {//如果没有选择的item则返回
			return;
		}
		/*****************上面为验证，下面为执行命令***************************/
		for(var i = 0; i < selectedItems.length; i++) {
			var source = selectedItems[i];
			if(!source.usedIn) {//如果选择的item不是有有源的则跳过下面的步骤继续循环
				continue;
			}
			
			var usedInComps = source.usedIn;//获取所有使用该素材的合成
			for(var j = 0; j < usedInComps.length; j++) {
				var sl = [];//用来存放使用选中素材的图层
				var comp = usedInComps[j];
				for(var k = 1; k <= comp.numLayers; k++) {
					if(comp.layer(k).source == source) {
						sl.push(comp.layer(k));
					}
				}
				G1a.click(sl);
			}
		}
	
	}

	G1rr.onClick = function() {
		G1T.removeAll();
		G1T.onChange();
	}
	
	G1s.onClick = function() {
		var s = G1T.selection;
		if(!replaceTemplate.checkImageItem(s)) {
			return;
		}
		var myItem = replaceTemplate.project.getItemById(s.id);
		if(s.type == 'node') {
			replaceTemplate.project.lookItemInProjectPanel(myItem);
		}else {
			if(isValid(myItem.layer(s.layerIndex).source)) {
				replaceTemplate.project.lookItemInProjectPanel(myItem.layer(s.layerIndex).source);
			}
		}
	}
	
	G1c.onClick = G1T.onDoubleClick = function() {
		var s = G1T.selection;
		if(!replaceTemplate.checkImageItem(s) || s.type == 'node') {
			return;
		}
		var myItem = replaceTemplate.project.getItemById(s.id);
		replaceTemplate.project.lookItemInProjectPanel(myItem);
		replaceTemplate.project.looklayerInComp(myItem.layer(s.layerIndex));
	}
	
	G1v.click = function(tree) {
		if(tree.items.length == 0) {
			return;
		}
		var s = tree.selection;
		var myItem = [];
		if(!isValid(s)) {
			replaceTemplate.getAllItem(tree, myItem); 
		}else if(s.type == 'node') {
			replaceTemplate.getAllItem(s, myItem);
		}else{
			myItem[0] = s;
		}
	
		app.beginUndoGroup(str.tipEnabled);
		var v = !replaceTemplate.project.getItemById(myItem[0].id).layer(myItem[0].layerIndex).enabled;
		for(var i = 0; i < myItem.length; i++) {
			if(!replaceTemplate.checkImageItem(myItem[i]) && !replaceTemplate.checkTextItem(myItem[i])) {
				continue;
			}
			var l = replaceTemplate.project.getItemById(myItem[i].id).layer(myItem[i].layerIndex);
			l.enabled = v;
		}
		app.endUndoGroup();
	}
	
	G1v.onClick = function() {
		G1v.click(G1T);
	}
	
	G2v.onClick = function() {
		G1v.click(G2T);
	}
	
	G1f.onClick = function() {
		var fileWin = replaceTemplate.fileWin();
		fileWin.center();
		fileWin.show();
	}

	G2c.onClick = G2T.onDoubleClick = function() {
		var s = G2T.selection;
		if(!replaceTemplate.checkTextItem(s) || s.type == 'node') {
			return;
		}
		var myItem = replaceTemplate.project.getItemById(s.id);
		replaceTemplate.project.lookItemInProjectPanel(myItem);
		replaceTemplate.project.looklayerInComp(myItem.layer(s.layerIndex));
	}
	
	G2a.onClick = function() {
		var sl = replaceTemplate.project.getSelectedLayers();
		if(!sl) {
			return;
		}
		var myNode = replaceTemplate.check(G2T, app.project.activeItem);
		for(var i = 0; i < sl.length; i++) {
			if(!(sl[i] instanceof TextLayer)) {
				continue;
			}
			var b = 1;
			for(var j = 0; j < myNode.items.length; j++){
				if(myNode.items[j].id == app.project.activeItem.id && myNode.items[j].layerIndex == sl[i].index) {
					b = 0;
					alert(str.alertHasAdded + ' ' + app.project.activeItem.name + ' --> 图层' + sl[i].index + ' ' + sl[i].name);
					break;
				}
			}
			if(b) {
				var newItem = myNode.add('item', app.project.activeItem.name + ' --> 图层' + sl[i].index + ' ' + sl[i].name);
				newItem.id = app.project.activeItem.id;
				newItem.layerIndex = sl[i].index;
				newItem.texts = sl[i].text.sourceText.value;
			}
		}
		replaceTemplate.treeview.removeEmptyNode(G2T);
		G2T.onChange();
		//schemeInfo.text = File.decode(File(replaceTemplate.schemePath).name + '*');
	}
	
	G2r.onClick = function() {
		var s = G2T.selection;
		if(!isValid(s)) {
			return;
		}
		s.parent.remove(s);
		replaceTemplate.treeview.removeEmptyNode(G2T);
		G2T.onChange();
		//schemeInfo.text = File.decode(File(replaceTemplate.schemePath).name + '*');
	}
	
	G2aa.onClick = function() {
		var s = G2T.selection;
		if(!isValid(s)) {
			return;
		}
         var myFolders = [];
        for(var i = 0; i < app.project.selection.length; i++) {//将选择的文件夹也包含在内
            if(app.project.selection[i] instanceof FolderItem) {
                myFolders.push(app.project.selection[i]);
            }
        }
        var c = replaceTemplate.project.getItemById(s.id);
        myFolders.push(c.parentFolder);
        
        for(var k = 0; k < myFolders.length; k++) {
            var myFolder = myFolders[k];
            if(myFolder == null) {
                myFolder = app.project;
            }
            var myItems = myFolder.items;
            for(var i = 1; i <= myItems.length; i++) {
                if(!(myItems[i] instanceof CompItem)) {
                    continue;
                }
                if(myItems[i].numLayers < s.layerIndex) {
                    continue;
                }
                var sl = myItems[i].layer(s.layerIndex);
                if(!(sl instanceof TextLayer)) {
                    continue;
                }
                var b = 1;
                var myNode = replaceTemplate.check(G2T, myItems[i]);
                for(var j = 0; j < myNode.items.length; j++){
                    if(myNode.items[j].id == myItems[i].id && myNode.items[j].layerIndex == s.layerIndex) {
                        b = 0;
                        break;
                    }
                }
                if(b) {
                    var newItem = myNode.add('item', myItems[i].name + ' --> 图层' + sl.index + ' ' + sl.name);
                    newItem.id = myItems[i].id;
                    newItem.layerIndex = sl.index;
                    newItem.texts = sl.text.sourceText.value;
                }
            }
		}
		G2T.onChange();
	}
	
	G2rr.onClick = function() {
		G2T.removeAll();
		G2T.onChange();
	}
	
	G2t.onClick = function() {
		var textWin = replaceTemplate.textWin();
		textWin.center();
		textWin.show();
	}
	
	G1T.onChange = function() {
		if(this.items.length == 0 || !isValid(this.selection) || this.selection.type == 'node') {
			linkPath.text = '';
			matchType.selection = null;
			replaceSource.value = 0;
			attr1.enabled = 0;
			replaceCurrent1.enabled = 0;
		} else {
			var s = this.selection;
			linkPath.text = s.link;
			matchType.selection = s.match;
			centerLayer.value = s.centerLayer;
			replaceSource.value = s.replaceSource;
			sequence.value = s.sequence;
			attr1.enabled = 1;
			replaceCurrent1.enabled = 1;
		}
	}

	G1T.addEventListener("keydown",function(event)//监听事件，delete
	{
		if(event.keyName=="Delete")
		{
			G1r.onClick();   
        }
    });

	G2T.addEventListener("keydown",function(event)//监听事件，delete
	{
		if(event.keyName=="Delete")
		{
			G2r.onClick();   
        }
    });
	
	G2T.onChange = function() {
		if(this.items.length == 0 || !isValid(this.selection) || this.selection.type == 'node') {
			texts.text = '';
			attr2.enabled = 0;
			replaceCurrent2.enabled = 0;
		} else {
			var s = this.selection;
			texts.text = s.texts;
			attr2.enabled = 1;
			replaceCurrent2.enabled = 1;
		}
	}
	
	link.onClick = function() {
		var myFile = File.openDialog(str.dialogSelectFile, 'All files:*.*');
		if(myFile == null) {
			return;
		}
		linkPath.text = File.decode(myFile.path + '/' + myFile.name);
		linkPath.onChange();
	}
	
	linkPath.onChange = linkPath.onChanging = function() {
		if(!isValid(G1T.selection) || G1T.selection.type == 'node') {
			return;
		}
		G1T.selection.link = this.text;
	}
	
	matchType.onChange = function() {
		if(!isValid(G1T.selection) || G1T.selection.type == 'node') {
			return;
		}
		G1T.selection.match = this.selection.index;
	}
	
	centerLayer.onClick = function() {
		if(!isValid(G1T.selection) || G1T.selection.type == 'node') {
			return;
		}
		G1T.selection.centerLayer = this.value? 1 : 0;
	}
	
	replaceSource.onClick = function() {
		if(!isValid(G1T.selection) || G1T.selection.type == 'node') {
			return;
		}
		G1T.selection.replaceSource = this.value? 1 : 0;
	}
	
	sequence.onClick = function() {
		if(!isValid(G1T.selection) || G1T.selection.type == 'node') {
			return;
		}
		G1T.selection.sequence = this.value? 1 : 0;
	}
	
	texts.onChange = function() {
		if(!isValid(G2T.selection) || G2T.selection.type == 'node') {
			return;
		}
		G2T.selection.texts = texts.text;
	}

	replaceCurrent1.click = function(s) {
		//var s = G1T.selection;
		if(!replaceTemplate.checkImageItem(s) || s.type == 'node') {
			return;
		}
		//s.link = linkPath.text;
		//s.match = matchType.selection.index;
		//s.replaceSource = replaceSource.value;
		//s.sequence = sequence.value;
		var myFile = File(s.link);
		try{
			var myItem = replaceTemplate.project.getItemById(s.id);
			var myLayer = myItem.layer(s.layerIndex);
			if(!(myLayer.source instanceof FootageItem) && !(myLayer.source instanceof CompItem)) {//当强制读取时将会添加无源图层，这时用一个固态层代替
				var newLayer = myItem.layers.addSolid([1,1,1], myLayer.name, myItem.width, myItem.height, myItem.pixelAspect, myItem.duration);
				newLayer.moveBefore(myLayer);
				myLayer.remove();
				var myLayer = newLayer;
			}
			var newItem = myLayer.source;
			var matchLayer = {};
			matchLayer.height = myLayer.height;
			matchLayer.width = myLayer.width;
			matchLayer.scale = myLayer.transform.scale;
			if(newItem.mainSource instanceof FileSource && s.replaceSource) {
				if(s.sequence) {
					newItem.replaceWithSequence(myFile, false);
				}else {
					newItem.replace(myFile);
				}
			}else {
				var io = new ImportOptions(myFile);
				io.sequence = s.sequence;
				newItem = app.project.importFile(io);
				newItem.parentFolder = myLayer.source.parentFolder;
			}
			replaceTemplate.matchScale(s.match, myItem, matchLayer, newItem);
			myLayer.replaceSource(newItem,true);
			if(s.centerLayer) {
				myLayer.position.setValue([myItem.width, myItem.height]/2);
			}
			s.text = myItem.name + ' --> ' + myLayer.name;
		}catch(err) {
			alert(err);
		}
	}

	replaceCurrent1.onClick = function() {
		app.beginUndoGroup(str.replaceCurrent);
		replaceCurrent1.click(G1T.selection);
		app.endUndoGroup();
	}

	replaceCurrent2.click = function(s) {
		try{
			if(!replaceTemplate.checkTextItem(s) || s.type == 'node') {
				return;
			}
			var myItem = replaceTemplate.project.getItemById(s.id);
			myItem.layer(s.layerIndex).text.sourceText.setValue(s.texts);
			s.text = myItem.name + ' --> ' + myItem.layer(s.layerIndex).name;
		}catch(err) {
			alert(err);
		}
	}

	replaceCurrent2.onClick = function() {
		app.beginUndoGroup(str.replaceCurrent);
		replaceCurrent2.click(G2T.selection);
		app.endUndoGroup();
	}

	replaceAll1.onClick = function() {
		var myItem = [];
		replaceTemplate.getAllItem(G1T, myItem);
		app.beginUndoGroup(str.replaceAll);
		try{
			for(var i = 0; i < myItem.length; i++) {
				replaceCurrent1.click(myItem[i]);
			}
		}catch(err){
			alert(err);
		}
		app.endUndoGroup();
		G1T.onChange();
	}

	replaceAll2.onClick = function() {
		var myItem = [];
		replaceTemplate.getAllItem(G2T, myItem);
		app.beginUndoGroup(str.replaceAll);
		try{
			for(var i = 0; i < myItem.length; i++) {
				replaceCurrent2.click(myItem[i]);
			}
		}catch(err){
			alert(err);
		}
		app.endUndoGroup();
		G2T.onChange();
	}

	help.onClick = function() {
		alert('版本号：2015.3.15\n作者：阿木亮\n邮箱：982632988@qq.com\n\n感谢支持C4DSKY\nhttp://c4dsky.com/');
	}
	
	
	this.window.resize(win);
	
	
	
	G1T.onChange();
	G2T.onChange();
	types.selection = 0;
    return win;
}

replaceTemplate.fileWin = function() {
	var str = this.str.fileWin;
	{//界面
	var win = new Window('window', str.title, undefined, {resizeable: true});
	win.margins = 0;
	var mainG = win.mainGroup = win.add(
		"group{\
			spacing: 0,\
			alignment: ['fill', 'fill'],\
			alignChildren: ['fill','top'],\
			orientation: 'column',\
			top: Panel{\
				spacing: 0,\
				margins: 0,\
				orientation: 'row',\
				select: Button{},\
				refresh: Button{},\
				filterS: StaticText{},\
				filter: EditText{alignment: ['fill', 'center']},\
			},\
			s: Group{\
				spacing: 0,\
				sS: StaticText{alignment: ['left', 'center']},\
				s: EditText{alignment: ['fill', 'center']},\
				expandAll: Button{alignment: ['right', 'center']},\
				removed: Button{alignment: ['right', 'center']},\
			},\
			f: Group{\
				alignment: ['fill', 'fill'],\
				spacing: 0,\
				orientation: 'stack',\
				t: TreeView{alignment: ['fill', 'fill']},\
				st: TreeView{alignment: ['fill', 'fill']},\
			},\
			bottom: Group{\
				alignment: ['fill', 'bottom'],\
				spacing: 0,\
				link: Button{},\
				linkAll: Button{},\
				autoReplace: Checkbox{alignment: ['left', 'center']},\
				folderPath: EditText{alignment: ['fill', 'center'], enabled: 0,},\
			},\
		}");
	
	var selectFile = mainG.top.select;
	selectFile.text = str.selectFile;
	var refresh = mainG.top.refresh;
	refresh.text = str.refresh;
	mainG.top.filterS.text = str.filterS;
	var filter = mainG.top.filter;
	filter.text = str.filter;
	mainG.s.sS.text = str.sS;
	var search = mainG.s.s;
	search.text = '';
	var expandAll = mainG.s.expandAll;
	expandAll.text = str.expandAll;
	var removed = mainG.s.removed;
	removed.text = str.removed;
	var fileTree = mainG.f.t;
	var searchTree = mainG.f.st;
	var link = mainG.bottom.link;
	link.text = str.link;
	var linkAll = mainG.bottom.linkAll;
	linkAll.text = str.linkAll;
	var autoReplace = mainG.bottom.autoReplace;
	autoReplace.text = str.autoReplace;
	var folderPath = mainG.bottom.folderPath;
	folderPath.text = '';
	}

	selectFile.onClick = function() {
		var myFolder = Folder.selectDialog("选择AE脚本文件夹位置");
		if(myFolder == null) {
			return;
		}
		replaceTemplate.importFolder = myFolder;
		folderPath.text = File.decode(replaceTemplate.importFolder.path + '/' + replaceTemplate.importFolder.name);
		refresh.onClick();
	}
	
	refresh.onClick = function() {
		fileTree.removeAll();
		search.text = '';
		search.onChanging();
		replaceTemplate.treeview.addListOfFolder(fileTree, replaceTemplate.importFolder, filter.text);
		replaceTemplate.treeview.removeEmptyNode(fileTree);
	}

	search.onChanging = function() {
		if(this.text == '') {
			searchTree.visible = 0;
			fileTree.visible = 1;
			return;
		}
		searchTree.visible = 1
		fileTree.visible = 0;
		searchTree.removeAll();
		replaceTemplate.buildListFromText(searchTree, fileTree, this.text);
		replaceTemplate.treeview.removeEmptyNode(searchTree);
		replaceTemplate.treeview.expandAllNode(searchTree);
	}

	expandAll.onClick = function() {
		if(fileTree.visible) {
			var tree = fileTree;
		}else {
			var tree = searchTree;
		}
		var s = tree.selection;
		if(!isValid(s)) {
			replaceTemplate.treeview.expandAllNode(tree);
		}else if(s.type == 'node') {
			replaceTemplate.treeview.expandAllNode(s);
		}
	}

	removed.onClick = function() {
		if(fileTree.visible) {
			var tree = fileTree;
		}else {
			var tree = searchTree;
		}
		var s = tree.selection;
		if(!isValid(s)) {
			return;
		}
		s.parent.remove(s);
		replaceTemplate.treeview.removeEmptyNode(tree);
	}

	fileTree.addEventListener("keydown",function(event)//监听事件，delete
	{
		if(event.keyName=="Delete")
		{
			removed.onClick();   
        }
    });

	searchTree.addEventListener("keydown",function(event)//监听事件，delete
	{
		if(event.keyName=="Delete")
		{
			removed.onClick();   
        }
    });

	link.onClick = function() {
		if(fileTree.visible) {
			var tree = fileTree;
		}else {
			var tree = searchTree;
		}
		var s = tree.selection;
		var s0 = replaceTemplate.imageTree.selection;
		if(!isValid(s) || !isValid(s0) || s.type == 'node' || s0.type == 'node') {
			return;
		}
		replaceTemplate.linkPath.text = File.decode(s.source.path + '/' + s.source.name);
		replaceTemplate.linkPath.onChange();
		if(autoReplace.value) {
			replaceTemplate.replaceCurrent1.click(s0);
		}
	}

	fileTree.onDoubleClick = searchTree.onDoubleClick = function() {
		expandAll.onClick();
		link.onClick();
	}
	
	linkAll.onClick = function() {
		if(fileTree.visible) {
			var tree = fileTree;
		}else {
			var tree = searchTree;
		}
		var imageTree = replaceTemplate.imageTree;
		var myFile = [];
		var myItem = [];
		if(isValid(tree.selection) && tree.selection.type == 'node') {
			tree = tree.selection;
		}
		if(tree.items.length == 0) {
			return;
		}
		if(isValid(imageTree.selection) && imageTree.selection.type == 'node') {
			imageTree = imageTree.selection;
		}
		replaceTemplate.getAllFile(tree, myFile);
		replaceTemplate.getAllItem(imageTree, myItem);
		
		app.beginUndoGroup(str.linkAll);
		try{
			for(var i = 0; i < myItem.length; i++) {
				myItem[i].link = File.decode(myFile[i % myFile.length].path + '/' + myFile[i % myFile.length].name);
				if(autoReplace.value) {
					replaceTemplate.replaceCurrent1.click(myItem[i]);
				}
			}
		}catch(err){
			alert(err);
		}
		app.endUndoGroup();
		replaceTemplate.imageTree.onChange();
	}

	this.window.resize(win);
	
	search.onChanging();
    return win;
}

replaceTemplate.textWin = function() {
	var str = this.str.textWin;
	var win = new Window('window', str.title, undefined, {resizeable: true});
	win.margins = 0;
	var mainG = win.mainGroup = win.add(
		"group{\
			spacing: 0,\
			alignment: ['fill', 'fill'],\
			alignChildren: ['fill','top'],\
			orientation: 'column',\
			top: Panel{\
				spacing: 0,\
				margins: 0,\
				alignment: ['fill', 'fill'],\
				alignChildren: ['fill','fill'],\
			},\
			bottom: Group{\
				alignment: ['fill', 'bottom'],\
				spacing: 0,\
				link: Button{},\
				autoReplace: Checkbox{alignment: ['left', 'center']},\
				separatorT: StaticText{alignment: ['right', 'center']},\
				separator: EditText{alignment: ['right', 'center']},\
			},\
		}");

	var texts = mainG.top.texts = mainG.top.add('edittext', undefined, '', {multiline:1});
	var link = mainG.bottom.link;
	link.text = str.link;
	var autoReplace = mainG.bottom.autoReplace;
	autoReplace.text = str.autoReplace;
	mainG.bottom.separatorT.text = str.separatorT;
	var separator = mainG.bottom.separator;
	separator.preferredSize.width = 100;
	separator.text = str.separator;

	link.onClick = function() {
		var textTree = replaceTemplate.textTree;
		var myText = [];
		var myItem = [];
		if(isValid(textTree.selection) && textTree.selection.type == 'node') {
			textTree = textTree.selection;
		}
		replaceTemplate.getAllItem(textTree, myItem);
		eval("myText = texts.text.split(/" + separator.text + "/)");
		try{//用try语句保证可以正确完成搜索，可以包含正则表达式
			eval("myText = texts.text.split(/"+myText+"/)");
		}catch(err){
			try{
				eval("myText = texts.text.split("+myText+")");
			}catch(err){}
		}
		app.beginUndoGroup(str.link);
		try{
			for(var i = 0; i < myItem.length; i++) {
				myItem[i].texts = myText[i % myText.length];
				if(autoReplace.value) {
					replaceTemplate.replaceCurrent2.click(myItem[i]);
				}
			}
		}catch(err){
			alert(err);
		}
		app.endUndoGroup();
		replaceTemplate.textTree.onChange();
	}


	this.window.resize(win);
	
    return win;
}


replaceTemplate.buildListFromXml = function (myNode, myXML) {//根据xml生成树形图函数（节点，xml）
	for(var i = 0; myXML.node[i] != null; i++){
			var myItem = replaceTemplate.project.getItemById(parseInt(myXML.node[i].id));
			if(!isValid(myItem) || !(myItem instanceof FolderItem)) {
				continue;
			}
			var newNode = myNode.add('node', myItem.name);
			newNode.id = myXML.node[i].id;
			arguments.callee(newNode, myXML.node[i]);
	}
	for(var i = 0; myXML.item[i] != null; i++){
			var myItem = replaceTemplate.project.getItemById(parseInt(myXML.item[i].id));
			if(!isValid(myItem) || !(myItem instanceof CompItem)) {
				continue;
			}
			//var myLayer = myItem.layer(parseInt(myXML.item[i].layerIndex));
			if(!isValid(myItem.layer(parseInt(myXML.item[i].layerIndex)))) {// || !(myLayer.source instanceof CompItem || myLayer.source instanceof FootageItem)) {
				continue;
			}
			var newItem = myNode.add('item', myItem.name + ' --> ' + myItem.layer(parseInt(myXML.item[i].layerIndex)).name);
			newItem.id = myXML.item[i].id;
			newItem.layerIndex = parseInt(myXML.item[i].layerIndex);
			newItem.link = myXML.item[i].link;
			newItem.match = parseInt(myXML.item[i].match);
			newItem.replaceSource = parseInt(myXML.item[i].replaceSource);
			newItem.sequence = parseInt(myXML.item[i].sequence);
	}
}

replaceTemplate.buildListFromXml2 = function (myNode, myXML) {//根据xml生成树形图函数（节点，xml）
	for(var i = 0; myXML.node[i] != null; i++){
			var myItem = replaceTemplate.project.getItemById(parseInt(myXML.node[i].id));
			if(!isValid(myItem) || !(myItem instanceof FolderItem)) {
				continue;
			}
			var newNode = myNode.add('node', replaceTemplate.project.getItemById(parseInt(myXML.node[i].id)).name);
			newNode.id = myXML.node[i].id;
			arguments.callee(newNode, myXML.node[i]);
	}
	for(var i = 0; myXML.item[i] != null; i++){
			var myItem = replaceTemplate.project.getItemById(parseInt(myXML.item[i].id));
			if(!isValid(myItem) || !(myItem instanceof CompItem)) {
				continue;
			}
			//var myLayer = myItem.layer(parseInt(myXML.item[i].layerIndex));
			if(!isValid(myItem.layer(parseInt(myXML.item[i].layerIndex))) || !(myItem.layer(parseInt(myXML.item[i].layerIndex)) instanceof TextLayer)) {
				continue;
			}
			var myItem = replaceTemplate.project.getItemById(parseInt(myXML.item[i].id));
			var newItem = myNode.add('item', myItem.name + ' --> ' + myItem.layer(parseInt(myXML.item[i].layerIndex)).name);
			newItem.id = myXML.item[i].id;
			newItem.layerIndex = parseInt(myXML.item[i].layerIndex);
			newItem.texts = myXML.item[i].texts;
	}
}

replaceTemplate.matchScale = function(matchType, matchComp, matchLayer, newLayer) {
	var scale0 = matchLayer.scale.value;
	var scale = [1, 1, 1];
	var hc = matchComp.height;
	var wc = matchComp.width;
	var h0 = matchLayer.height;
	var w0 = matchLayer.width;
	var h = newLayer.height;
	var w = newLayer.width;
	switch(matchType) {
		case 0 : scale = scale0;break;
		case 1 : scale = [w0*scale0[0]/w, h0*scale0[1]/h, scale0[2]];break;
		case 2 : scale *= h0*scale0[1]/h;break;
		case 3 : scale *= w0*scale0[0]/w;break;
		case 4 : scale = [wc*100/w, hc*100/h];break;
		case 5 : scale *= hc*100/h;break;
		case 6 : scale *= wc*100/w;break;
	}

	matchLayer.scale.setValue(scale);
}

replaceTemplate.treeToXML = function(myTree, myXML) {
	var myItem = myTree.items;
	for(var i = 0; i < myItem.length; i++) {
		if(myItem[i].type == 'node') {
			var newNode = <node></node>;
			newNode.id = myItem[i].id;
			myXML.appendChild(newNode);
			arguments.callee(myItem[i], newNode);
		}else {
			var newItem = <item></item>;
			newItem.id = myItem[i].id;
			newItem.layerIndex = myItem[i].layerIndex;
			newItem.link = myItem[i].link;
			newItem.match = myItem[i].match;
			newItem.replaceSource = myItem[i].replaceSource;
			newItem.sequence = myItem[i].sequence;
			myXML.appendChild(newItem);
		}
	}
}

replaceTemplate.treeToXML2 = function(myTree, myXML) {
	var myItem = myTree.items;
	for(var i = 0; i < myItem.length; i++) {
		if(myItem[i].type == 'node') {
			var newNode = <node></node>;
			newNode.id = myItem[i].id;
			myXML.appendChild(newNode);
			arguments.callee(myItem[i], newNode);
		}else {
			var newItem = <item></item>;
			newItem.id = myItem[i].id;
			newItem.layerIndex = myItem[i].layerIndex;
			newItem.texts = myItem[i].texts;
			myXML.appendChild(newItem);
		}
	}
}


replaceTemplate.check = function(myTree, c) {//找到正确的添加父级
	var myItem = myTree.items;
	var myNode = myTree;
	if(c.parentFolder != null && c.parentFolder.parentFolder != null) {
		myNode = replaceTemplate.check2(myTree, c);
		if(myNode) {
			return myNode;
		}
		myNode = arguments.callee(myTree , c.parentFolder);
		myNode = myNode.add('node', c.parentFolder.name);
		myNode.id = c.parentFolder.id;
	}
	return myNode;
}

replaceTemplate.check2 = function(myTree, c) {//遍历所有节点找到树形图中与c（合成）的父文件夹相同id的项目，如果没有返回null
	var myItem = myTree.items;
	var myNode = false;
	if(c.parentFolder != null && c.parentFolder.parentFolder != null) {
		for(var i = 0; i < myItem.length; i++) {
			if(myItem[i].type == 'node') {
				if(myItem[i].id == c.parentFolder.id) {
					myNode = myItem[i];
					if(myNode) {
						break;
					}
				}else {
					myNode = arguments.callee(myItem[i], c);
					if(myNode) {
						break;
					}
				}
			}
		}
	}
	return myNode;
}

replaceTemplate.buildListFromText = function (myNode, myList, myText) {//根据文本搜索生成树形图函数（节点，原列表，文本）
	for(var i = 0;i < myList.items.length; i++) {
		if(myList.items[i].type == 'node') {
			var newNode = myNode.add('node', myList.items[i].text);
			newNode.source = myList.items[i].source;
			arguments.callee(newNode, myList.items[i], myText);
		}else {
			try{//用try语句保证可以正确完成搜索，可以包含正则表达式
				if(eval("myList.items[i].text.match(/"+myText+"/i)")) {//用“/ /i”可以保证忽略大小写
					var newItem = myNode.add('item', myList.items[i].text);
					newItem.source = myList.items[i].source;
				}
			}catch(err){
				try{
					if(eval("myList.items[i].text.match("+myText+")")) {
						var newItem = myNode.add('item', myList.items[i].text);
						newItem.source = myList.items[i].source;
					}
				}catch(err){}
			}
		}
	}
}

replaceTemplate.getAllFile = function(myNode, fileArray) {//从节点开始获取文件，将结果保存到fileArray中
	for(var i = 0; i < myNode.items.length; i++) {
		if(myNode.items[i].type == 'node') {
			arguments.callee(myNode.items[i], fileArray);
		}else {
			fileArray.push(myNode.items[i].source);
		}
	}
}

replaceTemplate.getAllItem = function(myNode, ItemArray) {//从节点开始获取文件，将结果保存到ItemArray中
	for(var i = 0; i < myNode.items.length; i++) {
		if(myNode.items[i].type == 'node') {
			arguments.callee(myNode.items[i], ItemArray);
		}else {
			ItemArray.push(myNode.items[i]);
		}
	}
}

replaceTemplate.checkImageItem = function(s) {
	if(!isValid(s)) {
		return false;
	}
	var myItem = replaceTemplate.project.getItemById(s.id);
	if(s.type == 'node') {
		if(myItem instanceof FolderItem) {
			return true;
		}
	}else {
		if(myItem instanceof CompItem) {
			if(myItem.numLayers >= s.layerIndex){
				//var mySource = myItem.layer(s.layerIndex).source;
				//if(isValid(mySource)){
				//	if(mySource instanceof CompItem || mySource instanceof FootageItem) {
						return true;
				//	}
				//}
			}
		}
	}
	return false;
}

replaceTemplate.checkTextItem = function(s) {
	if(!isValid(s)) {
		return false;
	}
	var myItem = replaceTemplate.project.getItemById(s.id);
	if(s.type == 'node') {
		if(myItem instanceof FolderItem) {
			return true;
		}
	}else {
		if(myItem instanceof CompItem) {
			if(myItem.numLayers >= s.layerIndex){
				var myLayer = myItem.layer(s.layerIndex);
				if(myLayer instanceof TextLayer) {
					return true;
				}
			}
		}
	}
	return false;
}

replaceTemplate.isSecurityPrefSet = function() {
	try{
		var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
		return (securitySetting == 1);
	}catch(e){
		return (securitySetting = 1);
	}
}




//加密程序
replaceTemplate.checkActivation = function(scriptName, link, imageFile) {
	var sn = '';
	var ac = '';
	if(app.settings.haveSetting(scriptName, 'serialNumber') && app.settings.haveSetting(scriptName, 'activationCode')) {
		sn = app.settings.getSetting(scriptName, 'serialNumber');
		ac = app.settings.getSetting(scriptName, 'activationCode');
		if(checkActivationCode(sn, ac)) {
			return true;
		}
	}
	
	var checkActivationWin = new Window("palette", '激活');
	checkActivationWin.margins = 0;
	checkActivationWin.spacing = 0;
	if(imageFile != null) {
		var image = checkActivationWin.add("image", undefined, imageFile);
		image.size = [300, 100];
	}
	checkActivationWin.group = checkActivationWin.add(
	"group{\
		alignment: ['fill', 'fill'],\
		alignChildren: ['fill', 'top'],\
		orientation: 'column',\
		spacing: 1,\
		top: Group{\
			title: StaticText{text: '序列号：', alignment: ['left','center'],},\
			box: EditText{alignment: ['fill', 'center']},\
		},\
		center: Group{\
			title: StaticText{text: '激活码：', alignment: ['left','center'],},\
			box: EditText{alignment: ['fill', 'center']},\
		},\
		bottom: Group{\
			alignChildren: ['center','center'],\
			clear: Button{text: '清空'},\
			OK: Button{text: '确定'},\
			buy: Button{text: '购买'},\
		},\
		info: Group{\
			alignChildren: ['fill','center'],\
			official: Button{text: '更多资源请访问 http://c4dsky.com/'},\
		},\
	}");
	checkActivationWin.group.preferredSize[0] = 300;
	var snt = checkActivationWin.group.top.box;
	var act = checkActivationWin.group.center.box;
	snt.text = sn;
	act.text = ac;
	
	checkActivationWin.group.bottom.clear.onClick = function() {
		snt.text = '';
		act.text = '';
	}

	checkActivationWin.group.bottom.OK.onClick = function() {
		if(checkActivationCode(snt.text, act.text)) {
			app.settings.saveSetting(scriptName, 'serialNumber', snt.text);
			app.settings.saveSetting(scriptName, 'activationCode', act.text);
			alert('激活成功，感谢您的购买！');
			checkActivationWin.close();
			
			var replaceTemplateWin = replaceTemplate.win(this);
			if(replaceTemplateWin instanceof Window) {
				replaceTemplateWin.center();
				replaceTemplateWin.show();
			}
		
			return true;
		}else {
			alert('激活失败！');
			return false;
		}
	}

	checkActivationWin.group.bottom.buy.onClick = function() {
		if (!replaceTemplate.isSecurityPrefSet()) {//保证ae允许写入文件
			alert (replaceTemplate.str.win.alertSetting);	
			try{
				app.executeCommand(2359);
			}catch (e) {
				alert(e);
			}
			if (!replaceTemplate.isSecurityPrefSet()) {
				return false;
			}
		}
		system.callSystem("cmd /c explorer \"" + link + "\"");
	}

	checkActivationWin.group.info.official.onClick = function() {
		if (!replaceTemplate.isSecurityPrefSet()) {//保证ae允许写入文件
			alert (replaceTemplate.str.win.alertSetting);	
			try{
				app.executeCommand(2359);
			}catch (e) {
				alert(e);
			}
			if (!replaceTemplate.isSecurityPrefSet()) {
				return false;
			}
		}
		system.callSystem("cmd /c explorer \"http://c4dsky.com/\"");
	}

	
	checkActivationWin.center();
	checkActivationWin.show();

	function checkActivationCode(sn, ac) {//传递两个字符串参数，分别为注册号和激活码
		var key = [1, 0, 5, 8, 0, 2, 7, 5, 8, 4];//不同脚本可以只改变这个值，其他算法相同

		var snArray = [];
		for(var i = 0; i < 20; i++) {//将字符串分割成数字数组
			snArray[i] = parseInt(sn[i]);
		}
		var result = getActivationCode(key, snArray);
		var myac = read('/c/Windows/ac.txt');
		
		if(myac == result[1] && ac == result[2]) {
			return true;
		}else {
			return false;
		}

		function getActivationCode(key, snArray) {//返回一个三元数组，分别为磁盘序列号数组，一次激活码字符串，二次激活码字符串
			var result = [];
			var dsn = [];//磁盘序列号
			var ac = '';//一次激活码
			var ac2 = '';//二次激活码
			var letter = '0ABCDEFGHIJKLMNOPQRSTUVWXYZ';
			
			for(var i = 0; i < 10; i++) {
				dsn[i] = (snArray[i + 10] + 10 - snArray[i]) % 10;
			}
			for(var i = 0; i < 10; i++) {
				ac += letter[dsn[i] + key[i]];
			}
			for(var i = 0; i < 10; i++) {
				ac2 += letter[dsn[i] + snArray[i] + key[i]];
			}
			
			result[0] = dsn;
			result[1] = ac;
			result[2] = ac2;
			
			return result;
		}
	}

	function read(path) {
		var file = File(path);
		file.open("r");
		var myString = file.read();
		file.close();
		
		return myString;
	}
};

//执行
	var replaceTemplateWin = replaceTemplate.win(this);
	if(replaceTemplateWin instanceof Window) {
		replaceTemplateWin.center();
		replaceTemplateWin.show();
	}