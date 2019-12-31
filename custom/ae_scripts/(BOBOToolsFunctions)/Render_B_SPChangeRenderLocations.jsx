{
	// Change Render Locations.jsx
	//
	// This script prompts the user for a new output folder to use for queued items in the Render Queue.
	
	function SPChangeRenderLocations()
	{
		var scriptName = "改变输出目录";
		var newLocation = Folder.selectDialog("请选择输出目录...");
		
		if (newLocation != null) {
			app.beginUndoGroup(scriptName);
			
			var renderLocations = "渲染路径发生改变:\n";
			
			// Process all render queue items whose status is set to Queued.
			for (i = 1; i <= app.project.renderQueue.numItems; ++i) {
				
				var curItem = app.project.renderQueue.item(i);
				
				if (curItem.status == RQItemStatus.QUEUED) {
					// Change all output modules for the current render queue item.
					for (j = 1; j <= curItem.numOutputModules; ++j) {
						var curOM = curItem.outputModule(j);
						
						var oldLocation = curOM.file;
						
						var oldLocation_name = decodeURI(oldLocation.name);
						
						//alert(oldLocation_name);
						
											
						var dirStr = oldLocation_name.match(/[\u4E00-\u9FA5]/g).toString().replace(',','');
						var itemName = oldLocation_name.substring(oldLocation_name.lastIndexOf(dirStr) + dirStr.length + 1, oldLocation_name.lastIndexOf('_'));
						
						var sequenceFolderPath = new Folder ( newLocation.toString() + "/" + itemName + "/" + dirStr );
						sequenceFolderPath.create();
						
						curOM.file = new File(newLocation.toString() + "/" + itemName + "/" + dirStr + "/" + oldLocation.name);
						
						renderLocations = renderLocations + newLocation.toString() + "/" + itemName + "/" + dirStr + "/" + oldLocation.name + "\n\n";
						
						//curOM.file = new File(newLocation.toString() + "/" + oldLocation.name);
						
						//renderLocations = renderLocations + newLocation.toString() + "/" + oldLocation.name +"\n\n";
						
						
					}
				}
			}
		
			//alert(renderLocations, scriptName);
			app.endUndoGroup();
		}
	}
	
	
	SPChangeRenderLocations();
}
