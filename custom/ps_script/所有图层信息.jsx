if (app.documents.length > 0) { // check if file is opened  
    var thisDoc = app.activeDocument;  
    var strResult = "Document layers' list:";  
    var tempLength = 0;  
    for (var i = 0 ; i < thisDoc.layers.length ; i++) { // loop through single layers or groups  
        var activeLayer = thisDoc.layers[i];  
        try{  
            tempLength = "contains " + activeLayer.layers.length + " layers";  
        }catch (err){  
            tempLength = "(not a group)";  
        }  
        strResult += "\n[" + i + "] " + thisDoc.layers[i].name + ": " + tempLength;  
    }  
    alert(strResult);  
}  