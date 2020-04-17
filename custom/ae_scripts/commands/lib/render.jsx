//Name
function SPCreateFolderAndOutputForSelectedCompsName(){
	var scriptName = "Create Folder for Render Queue Sequences";		
	// Check a project is open
	if (!app.project)
	{
		alert ("A project must be open to use this script.", scriptName);
		return;
	}
	var newLocation = Folder.selectDialog("Select a render output folder...");
	if (newLocation != null) {
		app.beginUndoGroup(scriptName);
		var selectedItems = app.project.selection;
		for (var i=0,len=selectedItems.length; i<len; i++)
		{
			var item = selectedItems[i];
			if ( selectedItems[i] instanceof CompItem ){
				RQItem = app.project.renderQueue.items.add(item);
				var lastOMItem = RQItem.outputModules[1];								
				// var sequenceFolderPath = new Folder ( newLocation.toString() + "/" + item.name )
				var sequenceFolderPath = new Folder ( newLocation.toString())
				sequenceFolderPath.create();
				//var sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name + "_[#####]" );
				var sequencePath = new File ( newLocation.toString() + "/"+item.name+"_[#]" );				
				lastOMItem.file = sequencePath;							
				// Remove _[#####] for non frame sequence type
				var outputPath = lastOMItem.file.fsName;
				// get the output file's prefix and extension
				var index = outputPath.lastIndexOf( "\\" );
				var outputFile = outputPath.substring( index + 1, outputPath.length );
				index = outputFile.lastIndexOf( "." );
				var outputPrefix = outputFile.substring( 0, index );
				var outputExt = outputFile.substring( index + 1, outputFile.length );
				if (IsMovieFormat( outputExt ))
				{
					// sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name) ;
					sequencePath = new File ( newLocation.toString()) ;
					lastOMItem.file = sequencePath;
				}
			}
		}

		app.endUndoGroup();	
	}
}
//Attack/Direction
function SPCreateFolderAndOutputForSelectedCompsAttackDirection() {
	var scriptName = "Create Folder for Render Queue Sequences";
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
				//AnimationName
				//var AniName = item.name.substring(0, item.name.indexOf('_'));
				var AniName = item.name.match(/#(\S*)#/)[1]; //获取动作名
				//var dirStr2 = item.name.match(/[^_]+$/);
				var sequenceFolderPath = new Folder(newLocation.toString() + "/" + AniName + "/" + dirStr);
				sequenceFolderPath.create();

				//var sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name + "_[#####]" );
				var sequencePath = new File(newLocation.toString() + "/" + AniName + "/" + dirStr + "/" + item.name + "#[#####]");
				//var sequencePath = new File ( newLocation.toString() + "/" + dirStr + "/" + itemName + "/" + item.name + "_[#####]" );

				lastOMItem.file = sequencePath;
			}
		}

		app.endUndoGroup();
	}
}
//Name/Attack/Direction
function SPCreateFolderAndOutputForSelectedCompsNameAttackDirection() {
	var scriptName = "Create Folder for Render Queue Sequences";
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
				var sequencePath = new File(newLocation.toString() + "/" + Name + "/" + AniName + "/" + dirStr + "/" + item.name +"#[#####]");
				//var sequencePath = new File ( newLocation.toString() + "/" + dirStr + "/" + itemName + "/" + item.name + "_[#####]" );

				lastOMItem.file = sequencePath;
			}
		}

		app.endUndoGroup();
	}
}
//Name/Direction
function SPCreateFolderAndOutputForSelectedCompsNameDirection() {
	var scriptName = "Create Folder for Render Queue Sequences";
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
				var dirStr = item.name.match(/[\u4E00-\u9FA5]/g).toString().replace(',', '');
				//var itemName = item.name.substr(item.name.lastIndexOf(dirStr) + dirStr.length + 1);
				//Name
				var Name= item.name.substring(0, item.name.indexOf('#'));//获取第一个字段
				//var AniName = item.name.match(/#(\S*)#/)[1]; //获取中间字符

				var sequenceFolderPath = new Folder(newLocation.toString() + "/" + Name + "/" + dirStr);
				sequenceFolderPath.create();

				//var sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name + "_[#####]" );
				var sequencePath = new File(newLocation.toString() + "/" + Name + "/"  + "/" + dirStr + "/"+ item.name + "#" +"[#####]");
				//var sequencePath = new File ( newLocation.toString() + "/" + dirStr + "/" + itemName + "/" + item.name + "_[#####]" );

				lastOMItem.file = sequencePath;
			}
		}

		app.endUndoGroup();
	}
}
function IsMovieFormat(extension) {
	var movieFormat = false;
	if (extension != null) {
		// These formats are all the ones included in DFusion, as well
		// as all the formats in AE that don't contain [#####].
		if (extension == "vdr" || extension == "wav" || extension == "dvs" ||
			extension == "fb" || extension == "omf" || extension == "omfi" ||
			extension == "stm" || extension == "tar" || extension == "vpr" ||
			extension == "gif" || extension == "img" || extension == "flc" ||
			extension == "flm" || extension == "mp3" || extension == "mov" ||
			extension == "rm" || extension == "avi" || extension == "wmv" ||
			extension == "mpg" || extension == "m4a" || extension == "mpeg" ||
			extension == "flv") {
			movieFormat = true;
		}
	}
	return movieFormat;
}