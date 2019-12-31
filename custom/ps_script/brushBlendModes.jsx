var bmsS = ["normal", "dissolve", "behind", "clearEnum",
            "darken", "multiply", "colorBurn", "linearBurn", "darkerColor",
            "lighten", "screen", "colorDodge", "linearDodge", "lighterColor",
            "overlay", "softLight", "hardLight", "vividLight", "linearLight", "pinLight", "hardMix",
            "difference", "exclusion", "blendSubtraction", "blendDivide",
            "hue", "saturation", "color", "luminosity",  ]; 

// Select the paint brush tool
var idslct = stringIDToTypeID( "select" );
var desc226 = new ActionDescriptor();
var idnull = stringIDToTypeID( "null" );
var ref170 = new ActionReference();
var idPbTl = stringIDToTypeID( "paintbrushTool" );
ref170.putClass( idPbTl );
desc226.putReference( idnull, ref170 );
executeAction( idslct, desc226, DialogModes.NO );

// blend mode
var desc = new ActionDescriptor();
var idset = stringIDToTypeID( "set" );
//alert(desc.getEnumerationValue(stringIDToTypeID("mode")));
desc.putEnumerated(stringIDToTypeID("mode"), stringIDToTypeID("blendModel"), stringIDToTypeID("clearEnum"));
desc226.putObject( stringIDToTypeID( "to" ), stringIDToTypeID( "null" ), desc);
executeAction( idset, desc226, DialogModes.NO );