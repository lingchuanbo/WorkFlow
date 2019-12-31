var idslct = charIDToTypeID( "slct" );
    var desc = new ActionDescriptor();
    var idnull = charIDToTypeID( "null" );
        var ref = new ActionReference();
        var idquickSelectTool = stringIDToTypeID( "quickSelectTool" );
        ref.putClass( idquickSelectTool );
    desc.putReference( idnull, ref14 );
executeAction( idslct, desc, DialogModes.NO );