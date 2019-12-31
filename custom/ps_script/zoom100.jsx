cTID = function(s) { return app.charIDToTypeID(s); };
sTID = function(s) { return app.stringIDToTypeID(s); };
 
doMenuItem = function(item, interactive) {
   var ref = new ActionReference();   ref.putEnumerated(cTID("Mn  "), cTID("MnIt"), item);   var desc = new ActionDescriptor();   desc.putReference(cTID("null"), ref);   try {     var mode = (interactive != true ? DialogModes.NO : DialogModes.ALL);     executeAction(sTID("select"), desc, mode);   } catch (e) {     if (!e.message.match("User cancelled")) {       throw e;     } else {       return false;     }   }   return true;
}
doMenuItem(cTID('ActP')); // Set Zoom to 100%