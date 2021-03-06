﻿BRender_CreateFolderAndOutputForSelectedComps_NameAttackDirection();

function BRender_CreateFolderAndOutputForSelectedComps_NameAttackDirection() {
    
    SPCreateFolderAndOutputForSelectedCompsNameAttackDirection();
    
}
function SPCreateFolderAndOutputForSelectedCompsNameAttackDirection() {
	var scriptName = "创建渲染目录";
	// Check a project is open
	if (!app.project) {
		alert("A project must be open to use this script.", scriptName);
		return;
	}
	var newLocation = Folder.selectDialog("请选择输出目录...");
	if (newLocation != null) {
		app.beginUndoGroup(scriptName);
		var selectedItems = app.project.selection;

		for (var i = 0, len = selectedItems.length; i < len; i++) {
			var item = selectedItems[i];
			if (selectedItems[i] instanceof CompItem) {
				RQItem = app.project.renderQueue.items.add(item);
				var lastOMItem = RQItem.outputModules[1];
				//var dirStr = item.name.match(/[\u4E00-\u9FA5]/g).toString().replace(',', '');
				var dirStr = item.name.toString().split('#')[2]; //截取方向
				var itemName = item.name.substr(item.name.lastIndexOf(dirStr) + dirStr.length + 1);
				//Name
				var Name= item.name.substring(0, item.name.indexOf('#'));//获取第一个字段
				var AniName = item.name.match(/#(\S*)#/)[1]; //获取中间字符

				var sequenceFolderPath = new Folder(newLocation.toString() + "/" + Name + "/" + AniName + "/" + dirStr);
				sequenceFolderPath.create();
				//var sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name + "_[#####]" );
				var sequencePath = new File(newLocation.toString() + "/" + Name + "/" + AniName + "/" + dirStr + "/" + "[#####]");
				//var sequencePath = new File ( newLocation.toString() + "/" + dirStr + "/" + itemName + "/" + item.name + "_[#####]" );

				lastOMItem.file = sequencePath;
			}
		}

		app.endUndoGroup();
	}
}