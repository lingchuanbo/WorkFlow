
	app.beginUndoGroup("BlendingMode DIFFERENCE");
	myComp = app.project.activeItem;
	seLayers=myComp.selectedLayers; 
	for(i=0;i<seLayers.length;i++){
		if(seLayers[i].blendingMode ==BlendingMode.NORMAL){
			seLayers[i].blendingMode =BlendingMode.ADD;
		}else{
			seLayers[i].blendingMode =BlendingMode.NORMAL;
		}

	}
	app.endUndoGroup();
