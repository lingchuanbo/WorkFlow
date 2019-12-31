var s2t = function (s) { return app.stringIDToTypeID(s) };

var d = new ActionDescriptor();
d.putEnumerated( s2t( "presetKind" ), s2t( "presetKindType" ), s2t( "presetKindCustom" ));
executeAction( s2t( "Adjs" ), d, DialogModes.ALL );