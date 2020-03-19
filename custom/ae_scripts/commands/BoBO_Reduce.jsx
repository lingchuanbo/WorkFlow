reduceMain();
function reduceMain() {
    var proj = app.project;
    var replacedLayers = 0;
    var projItems = [];
    var solidsFolder = null;
    var compTimes = [];
    findAll();
    findSolidsFolder();

    function findAll() {
        for (var i = 1; i <= proj.numItems; i += 1) {
            if (proj.item(i) instanceof CompItem) {
                projItems.push(proj.item(i));
                compTimes.push(proj.item(i).time);
            }
        }
    }

    function findSolidsFolder() {
        var tempComp = app.project.items.addComp("tempComp", 1920, 1080, 1, 15, 25);
        var tempSolid = tempComp.layers.addSolid([0.67, 0, 0.188], "tempSolid", 1920, 1080, 1, 1);
        solidsFolder = tempSolid.source.parentFolder;
        tempSolid.source.remove();
        tempComp.remove();
        if (solidsFolder == null) {
            alert("No Solids folder found. Please add a solid to the project. \n (Solids are used for footage replacement)");
            return 1;
        }
        var currentdate = new Date();
        var dateTime = currentdate.getDate() + "/" + currentdate.getMonth() + 1 + "/" + currentdate.getFullYear() + " @ " + currentdate.getHours() + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds();
        solidsComp = app.project.items.addComp("ReduceFL " + dateTime, 1920, 1080, 1, 15, 25);
        solidsComp.parentFolder = solidsFolder;
        cycleComps();
    }

    function cycleComps() {
        for (var i = 0; i < projItems.length; i += 1) {
            if ((projItems[i]).numLayers > 0) {
                for (var j = (projItems[i]).numLayers; j > 0; j--) {
                    checkLayer(projItems[i], (projItems[i]).layer(j));
                }
            }
        }
    }

    function checkLayer(myComp, myLayer) {
        if (myLayer.guideLayer == true) {
            return 2;
        }
        if (myLayer.isTrackMatte == true) {
            if (myComp.numLayers > myLayer.index) {
                if (checkLayerActive(myComp, myComp.layer(myLayer.index + 1)) != 0) {
                    return 2;
                }
            }
        }
        if (myLayer.source == undefined) {
            return 2;
        }
        if (myLayer.source.file != null || myLayer.source instanceof CompItem) {
            var layerActive = checkLayerActive(myComp, myLayer);
            if (layerActive == false) {
                replaceFL(myLayer);
            }
        }
        return 0;
    }

    function checkLayerActive(myComp, myLayer) {
        var compTime = myComp.time;
        if (myLayer.active == true) {
            return true;
        }
        if (myLayer.stretch >= 0) {
            var stretchOffset = 0.05;
        } else {
            var stretchOffset = -0.05;
        }
        var minTime = Math.max(0.05, myLayer.inPoint);
        var maxTime = Math.min(myComp.duration - 0.05, myLayer.inPoint);
        if (myLayer.inPoint < 0) {
            myComp.time = minTime + stretchOffset;
        } else {
            myComp.time = maxTime + stretchOffset;
        }
        if (myLayer.enabled == true && myLayer.transform.opacity.value == 0) {
            return true;
        } else {
            var returnVal = myLayer.active + myLayer.audioActive;
            resetTime();
            return returnVal;
        }

        function resetTime() {
            if (compTime >= 0 && compTime <= myComp.duration) {
                myComp.time = compTime;
            }
        }
    }

    function replaceFL(myLayer) {
        if (myLayer.duration == null) {
            footageDuration = 10;
        } else {
            footageDuration = myLayer.duration;
        }
        if (myLayer.width == 0) {
            var layerWidth = 100;
        } else {
            var layerWidth = myLayer.width;
        }
        if (myLayer.height == 0) {
            var layerHeight = 100;
        } else {
            var layerHeight = myLayer.height;
        }
        var mySolid = solidsComp.layers.addSolid([0.67, 0, 0.188], myLayer.name, layerWidth, layerHeight, 1, [footageDuration]);
        myLayer.replaceSource(mySolid.source, true);
        replacedLayers++;
    }
    resetComps();

    function resetComps() {
        for (var i = 0; i <= compTimes.length; i += 1) {
            if (compTimes[i] > 0) {
                (projItems[i]).time = compTimes[i];
            }
        }
    }
    alert("Replaced " + replacedLayers + " Footage Layers with solids.");
}