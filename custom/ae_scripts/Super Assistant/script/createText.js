path = 'text.txt';
var str = _.file.read(File(rootPath + path));
var arr = str.split('\n');
var comp = app.project.activeItem;
for(var i = arr.length-1; i >= 0; i--) {
	comp.layers.addText(arr[i]);
}