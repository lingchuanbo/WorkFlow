cTID = function(s) { return app.charIDToTypeID(s); };
sTID = function(s) { return app.stringIDToTypeID(s); };
 
function clearguides () {
    var desc1 = new ActionDescriptor();
    var ref1 = new ActionReference();
    ref1.putEnumerated(cTID('Mn  '), cTID('MnIt'), cTID('ClrG'));
    desc1.putReference(cTID('null'), ref1);
    executeAction(cTID('slct'), desc1, DialogModes.NO);
  };
 
clearguides ();