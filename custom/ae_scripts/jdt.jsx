var found = new Array (50);
var w = new Window ('palette');
w.pbar = w.add ('progressbar', undefined, 0, found.length);
w.pbar.preferredSize.width = 300;
w.show();
for (var i = 0; i < found.length; i++){
w.pbar.value = i+1;
$.sleep(0); // Do something useful here
}