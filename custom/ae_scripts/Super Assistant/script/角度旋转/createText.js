path = 'text.txt';
var str = _.file.read(File(rootPath + path));
var arr = str.split('\n');
var comp = app.project.activeItem;
for(var i = 0; i < arr.length; i++) {
	comp.layers.addText(arr[i]);
}