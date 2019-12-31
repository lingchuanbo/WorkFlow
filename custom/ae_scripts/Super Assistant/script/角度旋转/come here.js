try{
var comp = app.project.activeItem;
var anchor = comp.layer(1);
var sl = comp.selectedLayers;
for(var i = sl.length-1; i >= 0; i--) {
	sl[i].enabled = true;
	sl[i].position.setValue(anchor.position.value);
}
}catch(err){}