app.activeDocument.suspendHistory("Export as png", "main()");
function main() {
    if (app.documents.length) {
        var docRef = app.activeDocument;
        if (docRef.layers.length) {

            var selected = getSelectedLayersIdx();
            for (var i = 0; i < selected.length; i++) {
                var layer = selectByIndex(selected[i]),
                    width = layer.bounds[2] - layer.bounds[0],
                    height = layer.bounds[3] - layer.bounds[1];
                var newDoc = app.documents.add(width, height, 72, layer.name, NewDocumentMode.RGB, DocumentFill.TRANSPARENT);
                app.activeDocument = docRef;
                var targetLayer = layer.duplicate(newDoc, ElementPlacement.PLACEATBEGINNING);
                app.activeDocument = newDoc;

                var Position = targetLayer.bounds;
                targetLayer.translate(-Position[0], -Position[1]);

                //Options to export to PNG files
                var options = new ExportOptionsSaveForWeb();

                options.format = SaveDocumentType.PNG;
                options.PNG8 = false;
                options.transparency = true;
                options.optimized = true;

                var folder1 = Folder(docRef.path + '/export');
                if (!folder1.exists) folder1.create();

                newDoc.exportDocument(File(docRef.path + '/export/' + layer.name + '.png'), ExportType.SAVEFORWEB, options);

                //Close the temp document without saving the changes
                newDoc.close(SaveOptions.DONOTSAVECHANGES);
            }
        }
    }
}


function getSelectedLayersIdx() {


    var selectedLayers = new Array;

    var ref = new ActionReference();

    ref.putEnumerated(charIDToTypeID("Dcmn"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt"));


    var desc = executeActionGet(ref);


    if (desc.hasKey(stringIDToTypeID('targetLayers'))) {


        desc = desc.getList(stringIDToTypeID('targetLayers'));

        var c = desc.count

        var selectedLayers = new Array();


        for (var i = 0; i < c; i++) {


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


        var vis = app.activeDocument.activeLayer.visible;


        if (vis == true) app.activeDocument.activeLayer.visible = false;

        var desc9 = new ActionDescriptor();

        var list9 = new ActionList();

        var ref9 = new ActionReference();

        ref9.putEnumerated(charIDToTypeID('Lyr '), charIDToTypeID('Ordn'), charIDToTypeID('Trgt'));

        list9.putReference(ref9);

        desc9.putList(charIDToTypeID('null'), list9);

        executeAction(charIDToTypeID('Shw '), desc9, DialogModes.NO);


        if (app.activeDocument.activeLayer.visible == false) selectedLayers.shift();

        app.activeDocument.activeLayer.visible = vis;

    }


    return selectedLayers;

}


///////////////////////////////////////////////////////////////////////////////

// Function: selectByIndex

// Description: Sets the activeLayer by AM itemIndex and returns DOM active layer

// Usage: var idx = makeActiveByIndex( 7 );

// Input: Number (single idx)

// Return: activeLayer

///////////////////////////////////////////////////////////////////////////////


function selectByIndex(idx) {



    // avoid error when background layer idx is passed

    if (idx == 0) return;


    // if an array is passed use only the first element

    if (idx.length != undefined) {

        idx = idx[0];

    }


    // execute selection

    var desc = new ActionDescriptor();

    var ref = new ActionReference();

    ref.putIndex(charIDToTypeID('Lyr '), idx);

    desc.putReference(charIDToTypeID('null'), ref);

    executeAction(charIDToTypeID('slct'), desc, DialogModes.NO);

    return app.activeDocument.activeLayer;
}