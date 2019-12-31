/*
20181029 改变目录生成方式 增加是否选中合成组

SPCreateFolderAndOutputForSelectedComps()

Make a series of folders based ons elected comp names in a given location

Written by Dnaiel Harkness, Spinifex Group, 2013

TODO:

detect if new file is a movie and remove the "_[#####]"
 //删除效果
deleteEffects();
function deleteEffects() {
    var activeItem = app.project.activeItem;
    if (activeItem instanceof CompItem) {
        var selectedLayers = activeItem.selectedLayers;
        var numSelectedLayers = selectedLayers.length;
         if (numSelectedLayers >= 1) {
                    for (var i = 0; i < numSelectedLayers; i += 1) {
                        deleteAllEffectsFromLayer(selectedLayers[i]);
                    }
                } else {
                    alert("请选择一个或多个图层.", "BoBO提示你");
                }
        }
}
#include "./lib/function.jsx"

var currentComp;function selComp(){
    currentComp=app.project.activeItem;
    if(currentComp instanceof CompItem){
            return true;
     }else{
	    alert ("请选择渲染合成");
            return false;
         }
}
FolderToComps();

function FolderToComps() {
	var activeItem = app.project.activeItem;
	if (activeItem instanceof CompItem) {
		var selectedComp = activeItem.selectedComp;
		var numSelectedComp = selectedComp.length;
		if (numSelectedComp >= 1) {
			for (var i = 0; i < numSelectedComp; i += 1) {
				SPCreateFolderAndOutputForSelectedComps();
			}
		} else {
			alert("请选择一个或多个图层.", "BoBO提示你");
		}
	}
}

*/
SPCreateFolderAndOutputForSelectedComps();

function SPCreateFolderAndOutputForSelectedComps() {
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


		/*
		//build Intern=face
		var myWin = new Window ("dialog", "Settings", undefined)
		var addOutputModuleCheckBox = myWin.add("checkbox",undefined,"Add Output Module");
		var OMTemplateDropDown = myWin.add("dropdownList",undefined, OMTemplates);
		whichOMTemplate.selection = 1;
		myWin.add("button",undefined,"OK");
		myWin.center();
		myWin.show();
		*/


		for (var i = 0, len = selectedItems.length; i < len; i++) {
			var item = selectedItems[i];
			if (selectedItems[i] instanceof CompItem) {
				RQItem = app.project.renderQueue.items.add(item);
				var lastOMItem = RQItem.outputModules[1];

				var dirStr = item.name.match(/[\u4E00-\u9FA5]/g).toString().replace(',', '');
				var itemName = item.name.substr(item.name.lastIndexOf(dirStr) + dirStr.length + 1);
				//AnimationName
				//var AniName = item.name.substring(0, item.name.indexOf('_'));
				var AniName = item.name.match(/_(\S*)_/)[1]; //获取中间字符

				var sequenceFolderPath = new Folder(newLocation.toString() + "/" + AniName + "/" + dirStr);
				sequenceFolderPath.create();

				//var sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name + "_[#####]" );
				var sequencePath = new File(newLocation.toString() + "/" + AniName + "/" + dirStr + "/" + item.name + "_[#####]");
				//var sequencePath = new File ( newLocation.toString() + "/" + dirStr + "/" + itemName + "/" + item.name + "_[#####]" );

				lastOMItem.file = sequencePath;


				/*
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
							sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name) ;
							lastOMItem.file = sequencePath;
						}
						*/
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
	
