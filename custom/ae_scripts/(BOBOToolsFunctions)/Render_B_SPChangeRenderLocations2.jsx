﻿{
	// Change Render Locations.jsx
	//
	// This script prompts the user for a new output folder to use for queued items in the Render Queue.
	
	function SPChangeRenderLocations()
	{
		var scriptName = "Change Render Locations";
		var newLocation = Folder.selectDialog("Select a render output folder...");
		
		if (newLocation != null) {
			app.beginUndoGroup(scriptName);
			
			var renderLocations = "The following render paths were changed:\n";
			
			// Process all render queue items whose status is set to Queued.
			for (i = 1; i <= app.project.renderQueue.numItems; ++i) {
				
				var curItem = app.project.renderQueue.item(i);
				
				if (curItem.status == RQItemStatus.QUEUED) {
					// Change all output modules for the current render queue item.
					for (j = 1; j <= curItem.numOutputModules; ++j) {
						var curOM = curItem.outputModule(j);
						
						var oldLocation = curOM.file;
						curOM.file = new File(newLocation.toString() + "/" + oldLocation.name);
						
						renderLocations = renderLocations + curItem.comp.name + " output path:\n"+curOM.file.fsName+"\n\n";
						
						
					}
				}
			}
		
			alert(renderLocations, scriptName);
			app.endUndoGroup();
		}
	}
	
	
	SPChangeRenderLocations();
}