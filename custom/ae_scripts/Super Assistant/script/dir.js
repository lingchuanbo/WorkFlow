var comp = app.project.activeItem;

var layer = comp.layers[1];
var layer2 = comp.layers[2];

var str = layer.getRenderGUID(0);
var str2 = layer2.getRenderGUID(0);
var str3 = comp.getRenderGUID(0);


//alert(str + '\n' + str2 + '\n' + str3);
alert(_.dir(layer));