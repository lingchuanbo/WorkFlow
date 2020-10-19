BRender_CreateFolderAndOutputForSelectedComps_Name();

function BRender_CreateFolderAndOutputForSelectedComps_Name() {
    
    SPCreateFolderAndOutputForSelectedCompsName();
    
}
function SPCreateFolderAndOutputForSelectedCompsName(){
	var scriptName = "创建渲染目录";		
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
				 var sequenceFolderPath = new Folder ( newLocation.toString() + "/" + item.name )
				//var sequenceFolderPath = new Folder ( newLocation.toString() + "/")
				sequenceFolderPath.create();
				var sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + "[#####]" );
				// var sequencePath = new File ( newLocation.toString() + "/" + item.name + "/" + "[#####]" );				
				lastOMItem.file = sequencePath;							
				// Remove _[#####] for non frame sequence type
				var outputPath = lastOMItem.file.fsName;
				// get the output file's prefix and extension
				var index = outputPath.lastIndexOf( "\\" );
				var outputFile = outputPath.substring( index + 1, outputPath.length );
				index = outputFile.lastIndexOf( "." );
				var outputPrefix = outputFile.substring( 0, index );
				var outputExt = outputFile.substring( index + 1, outputFile.length );
				// if (IsMovieFormat( outputExt ))
				// {
				// 	sequencePath = new File ( newLocation.toString() + "/" + sequenceFolderPath.name + "/" + item.name) ;
				// 	// sequencePath = new File ( newLocation.toString()+ "/"+ item.name +"/" + "[#####]" ) ;
				// 	lastOMItem.file = sequencePath;
				// }
			}
		}

		app.endUndoGroup();	
	}
}
