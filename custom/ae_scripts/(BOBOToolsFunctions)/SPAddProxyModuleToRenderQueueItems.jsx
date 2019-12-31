﻿/*
SPAddProxyOutputToModuleRenderQueueItems()

Adds a new output module and makes a sub directory "proxy"

Written by Dnaiel Harkness, Spinifex Group, 2013

TODO::
Get template of output moudle and apply to new one
*/

{
	function SPAddProxyOutputToModuleRenderQueueItems()
	{
		var scriptName = "在渲染列队增加代理模块输出";
		var currentProject = app.project ;
		var myQueue = currentProject.renderQueue;
		
		// Check a project is open
		if (!currentProject)
		{
			alert ("A project must be open to use this script.", scriptName);
			return;
		}
	
		// Check for items in render queue
		if (myQueue.numItems < 1)
		{
			alert("You do not have any items set to render.", scriptName);	
			return;
		}

		var queuedRenderItems = 0;
		
		// Cycle through render queue and check if any queued items
		for (var i=1,len=myQueue.numItems; i<=len; i++)
		{
			var RQItem = myQueue.item(i);
			// Can only modify queued items
			if (RQItem.status == RQItemStatus.QUEUED)
			{
				queuedRenderItems++;
			}
		}
		if (queuedRenderItems == 0)
		{
			alert("当前无排队渲染. 该路径仅在排队渲染上设置.", scriptName);
			return;
		}

		// Cycle through render queue
		app.beginUndoGroup(scriptName);
		var shouldShowSkipAlert = false;
		var skipMessage = "跳过以下项目.输出模块中包含 \"proxy\"单词 :\n";

		for (var i=1,lenI=myQueue.numItems; i<=lenI; i++)
		{
			var RQItem = myQueue.item(i);
			// Can only modify queued items
			if (RQItem.status == RQItemStatus.QUEUED)
			{	
				var allPaths = "";
				for (var j=1, lenJ=RQItem.numOutputModules; j<=lenJ; j++)
				{
					var OutputModule = RQItem.outputModules[j];
					allPaths = allPaths+ OutputModule.file.path + OutputModule.file.name; 
				}
				
				if ( (allPaths).match("proxy") ) 
				{
					shouldShowSkipAlert = true;
					skipMessage = skipMessage + RQItem.comp.name + "\n\n";
				}
				else
				{
				
					RQItem.outputModules.add();
					// Create a folder for each file sequence the set the output module to that
					var lastOMItem = RQItem.outputModules[RQItem.numOutputModules];				
					var secondLastOMItem = RQItem.outputModules[RQItem.numOutputModules-1];
					
					var sequenceFileName = secondLastOMItem.file.name.replace( "_%5B#####%5D","") ; // Remove _[#####]
					sequenceFileName = sequenceFileName.substr(0, sequenceFileName.lastIndexOf('.')); // Remove Extension
					
		
					var sequenceFolderPath = new Folder ( secondLastOMItem.file.path + "/proxy/" )
					sequenceFolderPath.create();
					var sequencePath = new File ( sequenceFolderPath.path + "/proxy/" + secondLastOMItem.file.name );
					lastOMItem.file = sequencePath;
					
					lastOMItem.applyTemplate( secondLastOMItem.name );
				}
				
				
			}
			
		}
		if (shouldShowSkipAlert){
			alert(skipMessage, scriptName);
		}
		app.endUndoGroup();
	}

	SPAddProxyOutputToModuleRenderQueueItems();
}
