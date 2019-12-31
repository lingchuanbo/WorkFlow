try{
	var ls = app.project.activeItem.selectedLayers;
	for(var i = ls.length-1; i >= 0; i--) {
		ls[i].rotation.setValue(0);
	}
}catch(err){}