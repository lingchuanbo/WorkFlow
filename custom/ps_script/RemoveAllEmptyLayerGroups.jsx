var doc = app.activeDocument;
 
function removeallemptylayergroups(doc) {
    var foundEmpty = true;
    for( var i = doc.layerSets.length-1; 0 <= i; i--) {
        if( removeallemptylayergroups(doc.layerSets[i])) {
            doc.layerSets[i].remove();
        } else {
            foundEmpty = false;
        }
    }
    if (doc.artLayers.length > 0) {
        foundEmpty = false;
    }
    return foundEmpty;
}
 
removeallemptylayergroups(doc);