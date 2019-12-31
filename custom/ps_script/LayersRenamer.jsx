var selectedLayers = getSelectedLayersIdx();
var myResource = "dialog{ text: '" + selectedLayers.length + " Layers Selected', preferredSize:[-1, -1], alignChildren:'right',\n\t\t\t\t\tcontrols: Panel{ orientation: 'column', alignChildren:'right',\n\t\t\t\t\t\t\t\t  preferredSize:[250, -1],\n\t\t\t\t\t\ttxt: Group{ orientation: 'row',\n\t\t\t\t\t\t\tlabel: StaticText {text:'Text: '}\n\t\t\t\t\t\t\tinput: EditText {text:'', characters: 28, active:true}\n\t\t\t\t\t\t}\n\t\t\t\t\t\trbuttons: Group{orientation:'row',\n\t\t\t\t\t\t\tlabel: StaticText {text:'Mode: '}\n\t\t\t\t\t\t\tappend: RadioButton {text:'Append', value:true}\n\t\t\t\t\t\t\tprepend: RadioButton {text:'Prepend'}\n\t\t\t\t\t\t\treplace: RadioButton {text:'Replace'}\n\t\t\t\t\t\t}\n\t\t\t\t\t}\n\t\t\t\t\tbuttons: Group{ orientation: 'row', \n\t\t\t\t\t\tok_btn: Button {text:'OK'},\n\t\t\t\t\t\tcancel_btn: Button {text:'Cancel'},\n\t\t\t\t\t}\n\t\t\t\t}";
try {
    if (selectedLayers.length > 1) {
        var myWindow = new Window(myResource);
        if (myWindow.show() == 1) {
            var txt = myWindow.controls.txt.input.text;
            var append = myWindow.controls.rbuttons.append.value;
            var prepend = myWindow.controls.rbuttons.prepend.value;
            var replace = myWindow.controls.rbuttons.replace.value;
            if (append) {
                var preppendAppend_label = "Appended";
                var mode = "append";
            } else if (prepend) {
                var prependAppend_label = "Prepended";
                var mode = "prepend";
            } else {
                var prependAppend_label = "Replaced";
                var mode = "replace";
            }
            app.activeDocument.suspendHistory("[KAM] Layers Renamer Script (Learn more: http://blog.kam88.com)", "prependAppend(selectedLayers, txt, mode)");
            makeActiveByIndex(selectedLayers, false);
        }
    } else {
        alert("Error\nPlease select more than one layer");
    }
} catch (e) {
    alert(e);
}

function prependAppend(selectedLayers, txt, mode) {
    for (var i = 0; i < selectedLayers.length; i += 1) {
        makeActiveByIndex([selectedLayers[i]], false);
        tmpTxt = txt;
        tmpTxt = tmpTxt.replace("%n", selectedLayers.length - i);
        switch (mode) {
            case "append":
                app.activeDocument.activeLayer.name += tmpTxt;
                break;
            case "prepend":
                app.activeDocument.activeLayer.name = tmpTxt + app.activeDocument.activeLayer.name;
                break;
            case "replace":
                app.activeDocument.activeLayer.name = tmpTxt;
                break;
            default:
                app.activeDocument.activeLayer.name += tmpTxt;
                break;
        }
    }
}

function getSelectedLayersIdx() {
    var selectedLayers = new Array();
    var ref = new ActionReference();
    ref.putEnumerated(charIDToTypeID("Dcmn"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));
    var desc = executeActionGet(ref);
    if (desc.hasKey(stringIDToTypeID("targetLayers"))) {
        desc = desc.getList(stringIDToTypeID("targetLayers"));
        var c = desc.count;
        var selectedLayers = new Array();
        for (var i = 0; i < c; i += 1) {
            try {
                activeDocument.backgroundLayer;
                selectedLayers.push(desc.getReference(i).getIndex());
            } catch (e) {
                selectedLayers.push(desc.getReference(i).getIndex() + 1);
            }
        }
    } else {
        var ref = new ActionReference();
        ref.putProperty(charIDToTypeID("Prpr"), charIDToTypeID("ItmI"));
        ref.putEnumerated(charIDToTypeID("Lyr "), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));
        try {
            activeDocument.backgroundLayer;
            selectedLayers.push(executeActionGet(ref).getInteger(charIDToTypeID("ItmI")) - 1);
        } catch (e) {
            selectedLayers.push(executeActionGet(ref).getInteger(charIDToTypeID("ItmI")));
        }
    }
    return selectedLayers;
}

function makeActiveByIndex(idx, visible) {
    for (var i = 0; i < idx.length; i += 1) {
        var desc = new ActionDescriptor();
        var ref = new ActionReference();
        ref.putIndex(charIDToTypeID("Lyr "), idx[i]);
        desc.putReference(charIDToTypeID("null"), ref);
        if (i > 0) {
            var idselectionModifier = stringIDToTypeID("selectionModifier");
            var idselectionModifierType = stringIDToTypeID("selectionModifierType");
            var idaddToSelection = stringIDToTypeID("addToSelection");
            desc.putEnumerated(idselectionModifier, idselectionModifierType, idaddToSelection);
        }
        desc.putBoolean(charIDToTypeID("MkVs"), visible);
        executeAction(charIDToTypeID("slct"), desc, DialogModes.NO);
    }
}