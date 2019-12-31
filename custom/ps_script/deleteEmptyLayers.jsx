// script.name = deleteEmptyLayers,jsx
// script.description = deletes empty layers and sublayers. If a sublayer is not empty, its parent empty layer will not be removed.
// script.requirement = an open illustrator
// script.parent = CarlosCanto // 10/14/2017
// script.support = canto29@yahoo.com;

// usage - open Illustrator before running the script


function main() {
    try {var idoc = app.activeDocument;}
    catch (e) {alert ('Open a document and try again'); return };
    
    var emptyLayers = [];
    getEmptyLayers (idoc, emptyLayers);
    
    for (var a=0; a<emptyLayers.length; a++) {
        //$.writeln(emptyLayers[a].name);
        //$.writeln(emptyLayers[a].canDelete);
        emptyLayers[a].remove();
    }
}

// return empty layers, except the ones that have sublayers with objects
function getEmptyLayers(container, arr) {
    var layers = container.layers; 
    
	for (var k=0; k<layers.length; k++) {
        try {
            var ilayer = layers[k];
            ilayer.canDelete = true; // initialize all layers with deletion flag set to true
            
            // process sublayers first
            if (ilayer.layers.length>0) {
                getEmptyLayers (ilayer, arr)
            }
            
            // then process objects in current layer
            // if layer has a sublayer with objects, deletion flag was previously set to false
            // ignore this layer and set it's parent layer (container) to false as well, otherwise add to Empty Layers array
            if (ilayer.pageItems.length==0 && ilayer.canDelete) {
                arr.push(ilayer);
            }
            // if layer has objects, set deletion flag to false and its parent layer to false as well
            else {
                ilayer.canDelete = false;
                container.canDelete = false;
            }
        }
        catch(e){/*$.writeln (contaner.name)*/}
	}
}

main();