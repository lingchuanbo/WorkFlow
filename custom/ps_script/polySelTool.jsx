﻿var idslct = charIDToTypeID( "slct" );
    var desc = new ActionDescriptor();
    var idnull = charIDToTypeID( "null" );
        var ref = new ActionReference();
        var idpolySelTool = stringIDToTypeID( "polySelTool" );
        ref10.putClass( idpolySelTool );
    desc.putReference( idnull, ref10 );
    var iddontRecord = stringIDToTypeID( "dontRecord" );
    desc.putBoolean( iddontRecord, true );
    var idforceNotify = stringIDToTypeID( "forceNotify" );
    desc.putBoolean( idforceNotify, true );
executeAction( idslct, desc, DialogModes.NO );