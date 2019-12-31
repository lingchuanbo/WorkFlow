var w = new Window ("palette", "Photos Videos Comps To Comps");
w.orientation = "row";
w.add("button", undefined,"Select",{name:"ok"}).onClick = function(){ SelFootage(); }
var dd = w.add("dropdownlist", undefined, ["Landscape", "Portrait", "Original"]);
dd.selection = 0;
w.add("button", undefined,"Apply",{name:"ok"}).onClick = function(){ SelComps(); }
w.show();
FootageList = new Array();
function SelFootage()
	{
	var mySelectedItems = [];
	for (var i = 1; i <= app.project.numItems; i++)
		{
			if (app.project.item(i).selected)
			mySelectedItems[mySelectedItems.length] = app.project.item(i);
		}
	for (var b = 0; b < mySelectedItems.length; b++)
		{
			var mySelection = mySelectedItems[b];
			var myComp = app.project.items;
			FootageList[FootageList.length] = mySelection;
		}
	}
function SelComps()
{
app.beginUndoGroup("Add To Comps");
	var mySelectedItems = [];
	for (var i = 1; i <= app.project.numItems; i++)
		{
			if (app.project.item(i).selected)
			mySelectedItems[mySelectedItems.length] = app.project.item(i);
		}
	for (var b = 0; b < mySelectedItems.length; b++)
		{
			var mySelection = mySelectedItems[b];
			var myComp = app.project.items;
			var myLayer = mySelection.layers.add(FootageList[b]);
			var myTransform = myLayer.Effects.addProperty("Transform");
			var Lsize = mySelection.width / myLayer.width * 100
			var Psize = mySelection.height / myLayer.height * 100
			var Osize = myLayer.width / myLayer.width * 100
			if (dd.selection.index == 0){
			size = Lsize
			}
			if (dd.selection.index == 1){
			size = Psize
			}
			if (dd.selection.index == 2){
			size = Osize
			}
			myTransform.property(4).setValue(size);
		}
FootageList = []
app.endUndoGroup();
}