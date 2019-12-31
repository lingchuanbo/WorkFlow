var doc = app.activeDocument;

function removevisiblelayers(doc) {
    for( var i = doc.artLayers.length-1; 0 <= i; i--) {
        try {
            if(!doc.artLayers[i].visible) {
                doc.artLayers[i].remove();
            }
        } 
        catch (e) {
        }
    }
    for( var i = doc.layerSets.length-1; 0 <= i; i--) {
        removevisiblelayers(doc.layerSets[i]);
    }
}
removevisiblelayers(doc);