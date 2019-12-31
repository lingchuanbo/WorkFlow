/*
SPCreateFolderForRenderQueueSequences()

For sequences in render queue, make a folder based on the sequence name in the seqence parent.

Written by Dnaiel Harkness, Spinifex Group, 2013

*/

{
	function SPCreateFolderForRenderQueueSequences()
	{
		var scriptName = "在渲染列队创建目录输出";
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
		var skipMovieMessage = "";
		var skipFolderMessage = "";
		for (var i=1,len=myQueue.numItems; i<=len; i++)
		{
			var RQItem = myQueue.item(i);
			// Can only modify queued items
			if (RQItem.status == RQItemStatus.QUEUED)
			{			
				// Create a folder for each file sequence the set the output module to that
				var lastOMItem = RQItem.outputModules[RQItem.numOutputModules];				
				
				var sequenceFileName = lastOMItem.file.name.replace( "_%5B#####%5D","") ; // Remove _[#####]
				if (sequenceFileName == lastOMItem.file.name) 
				{
					shouldShowSkipAlert = true;
					skipMovieMessage = skipMovieMessage +sequenceFileName +" \n\n";
				}
				else{
					
					sequenceFileName = sequenceFileName.substr(0, sequenceFileName.lastIndexOf('.')); // Remove Extension
					if (sequenceFileName == lastOMItem.file.parent.name) 
					{
						shouldShowSkipAlert = true;
						skipFolderMessage = skipFolderMessage + sequenceFileName + "\n\n"
					}
					else{
						
						var sequenceFolderPath = new Folder ( lastOMItem.file.path + "/" + sequenceFileName )
						sequenceFolderPath.create();
						var sequencePath = new File ( sequenceFolderPath.path + "/" + sequenceFolderPath.name + "/" + lastOMItem.file.name );
						
						lastOMItem.file = sequencePath;
					}
				}
			}
			
		}
		if (shouldShowSkipAlert){
			if (skipMovieMessage){
				skipMovieMessage = "- 这些项目的最后输出模块不是序列:\n\n" + skipMovieMessage;
			}
			if (skipFolderMessage){
				skipFolderMessage = "- 这些项目正确设置了文件夹:\n\n" + skipFolderMessage;
			}
			alert("跳过了以下项目:\n"+skipFolderMessage+skipMovieMessage, scriptName);
		}
		app.endUndoGroup();
	}

	SPCreateFolderForRenderQueueSequences();
}
