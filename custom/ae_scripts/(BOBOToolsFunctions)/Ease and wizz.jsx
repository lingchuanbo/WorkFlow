// Ease and Wizz 2.5.3
// Ian Haigh 2017 (mail@ianhaigh.com)

// An After Effects adaptation of Robert Penner's easing equations.
// Installation, usage, and terms at http://aescripts.com/ease-and-wizz/

// The "Ease and Wizz" name is derived from the Pulp song "Sorted for E's and Wizz"
// https://www.youtube.com/watch?v=AIaehhYLVZA
// ... in case you were wondering

function ease_and_wizz_script(ui_reference) {
    "use strict";

    var ease_and_wizz = {}; // put all global variables on this object to avoid namespace clashes

    function ew_indexOf(searchElement, ary) {
        var i;
        // For backwards compatibility, as old versions of AE don't implement indexOf for Array.
        // Also, not using a polyfill to avoid prototype and possibly polluting namespace.
        for (i = 0; i < ary.length; i += 1) {
            if (ary[i] === searchElement) {
                return i;
            }
        }
        return -1;
    }

    var ew_getPathToEasingFolder = function () {
        // much simpler, thanks Jeff
        var folderObj = new Folder((new File($.fileName).parent).fsName + "/" + ease_and_wizz.EASING_FOLDER);
        return folderObj;
    };

    var ew_normaliseName = function (str) {
        str = str.replace(new RegExp(" \\+ "), ""); // if the "type" is "In + Out"
        str = str.replace(new RegExp(","), ""); // if it's a multi-easing type
        return str.replace(new RegExp(" ", "g"), "-").toLowerCase();
    };

    var ew_canProceed = function () {
        var activeItem = app.project.activeItem;
        if (activeItem === null) {
            alert("Select a keyframe or two.");
            return false;
        }
        if (activeItem.selectedProperties === "") {
            alert("Please select at least one keyframe.");
            return false;
        }

        return true;
    };

    var ew_determineFileName = function () {
        // defaults
        var easingType = "inOut";
        var easeandwizzOrCurvaceous = "-easeandwizz";
        var keyframesToAffect = "-allKeys";
        var filenameSuffix = ".txt";
        var multiPrefix = "multi-";

        // what kind of curve is it, e.g. expo, back etc
        var easingListSelection = ease_and_wizz.easingList.selection.text;

        // first up: is it a multi easing type?
        if (easingListSelection.indexOf(",") > 0) {
            // yes it is, because the name contains a comma. We're done here
            return (multiPrefix + ew_normaliseName(easingListSelection) + filenameSuffix);
        }

        // otherwise it's the original, single easing type
        // loop through the two menu objects and see what the user's selected

        // easeAndWizz, or curvaceous?
        if (ease_and_wizz.curvaceousCheckbox.value) {
            easeandwizzOrCurvaceous = "-curvaceous";
        }

        // which keys should be affected?
        keyframesToAffect = ew_normaliseName(ease_and_wizz.keysList.selection.text);

        // then, should the expression be In, Out, or Both?
        easingType = ew_normaliseName(ease_and_wizz.typeList.selection.text);

        // finally, the actual shape of the curve
        var curveType = ew_normaliseName(easingListSelection);
        var fileToLoad = curveType + "-" + easingType + easeandwizzOrCurvaceous + "-" + keyframesToAffect + filenameSuffix;
        return fileToLoad;
    };

    var ew_readFile = function (filename) {
        var the_code;
        var easing_folder = ew_getPathToEasingFolder();
        var file_handle = new File(easing_folder.fsName + "/" + filename);

        if (!file_handle.exists) {
            throw new Error("I can't find this file: '" + filename + "'. \n\nI looked in here: '" + easing_folder.fsName + "'. \n\nPlease refer to the installation guide and try installing again, or go to:\n\nhttp://aescripts.com/ease-and-wizz/\n\nfor more info.");
        }

        try {
            file_handle.open("r");
            the_code = file_handle.read();
        } catch (e) {
            throw new Error("I couldn't read the easing equation file: " + e);
        } finally {
            file_handle.close();
        }

        return (the_code);
    };

    var ew_setProps = function (expressionCode) {
        var selectedProperties = app.project.activeItem.selectedProperties;
        var numOfChangedProperties = 0;
        var currentProperty;
        var i;

        // retain the whitespace
        expressionCode = expressionCode.replace(/\n\n/g, "\n \n");


        for (i = 0; i < selectedProperties.length; i += 1) {
            currentProperty = selectedProperties[i];

            if ((currentProperty.propertyValueType === PropertyValueType.SHAPE) && !ease_and_wizz.curvaceousCheckbox.value) {
                alert(ease_and_wizz.CURVACEOUS_ERROR_TXT);
                return;
            }

            if (currentProperty.numKeys >= 2 && currentProperty.canSetExpression) {
                // don't do anything if we can't set an expression
                // likewise if there aren't at least two keyframes
                currentProperty.expression = expressionCode;
                numOfChangedProperties += 1;
            }
        }

        var easingType = ease_and_wizz.easingList.selection.text;
        clearOutput();
        if (numOfChangedProperties === 1) {
            writeLn("Applied \"" + easingType + "\" to 1 property.");
        } else {
            writeLn("Applied \"" + easingType + "\" to " + numOfChangedProperties + " properties.");
        }
    };

    var ew_fixMenus = function () {
        var i;
        var current;
        if (ease_and_wizz.curvaceousCheckbox.value === true) {
            // turning on Curvaceous; remove the options that aren't compatible

            // reset keys menu
            if (ease_and_wizz.keysList.selection.text === "Start only") {
                ease_and_wizz.keysList.selection = 0;
            }

            // before removing options, make sure a valid easing type remains selected
            var curveType = ease_and_wizz.easingList.selection.text;

            // none of the following play with Curvaceous
            if (curveType === "Elastic" || curveType === "Back" || curveType.indexOf(",") > 0) {
                ease_and_wizz.easingList.selection = "Expo";
            }

            // now take 'em away
            ease_and_wizz.easingList.find("Elastic").enabled = false;
            ease_and_wizz.easingList.find("Back").enabled = false;
            ease_and_wizz.keysList.find("Start only").enabled = false;
            app.settings.saveSetting("easeandwizz", ease_and_wizz.CURVACEOUS_SETTINGS_KEY, "1");

            // turn off multi-easing items
            for (i = 0; i < ease_and_wizz.multiLookup.length; i += 1) {
                current = ease_and_wizz.multiLookup[i];
                ease_and_wizz.easingList.find(current).enabled = false;
            }
        } else {
            // turning off Curvaceous, add the missing items
            ease_and_wizz.easingList.find("Elastic").enabled = true;
            ease_and_wizz.easingList.find("Back").enabled = true;
            ease_and_wizz.keysList.find("Start only").enabled = true;

            // turn on multi-easing items
            for (i = 0; i < ease_and_wizz.multiLookup.length; i += 1) {
                current = ease_and_wizz.multiLookup[i];
                ease_and_wizz.easingList.find(current).enabled = true;
            }

            app.settings.saveSetting("easeandwizz", ease_and_wizz.CURVACEOUS_SETTINGS_KEY, "0");
        }
    };

    var ew_set_easing_menu = function () {
        if (app.settings.haveSetting("easeandwizz", ease_and_wizz.EASING_SETTINGS_KEY)) {
            var value = app.settings.getSetting("easeandwizz", ease_and_wizz.EASING_SETTINGS_KEY); // from the settings
            ease_and_wizz.easingList.selection = ew_indexOf(value, ease_and_wizz.easingTypesAry);
        } else {
            ease_and_wizz.easingList.selection = 0; // select the first item
        }
    };

    var ew_applyExpressions = function () {
        if (!ew_canProceed()) {
            return false;
        }

        var fileToLoad = ew_determineFileName();
        app.beginUndoGroup("Ease and Wizz");

        try {
            ease_and_wizz.easingEquation = ew_readFile(fileToLoad);
        } catch (e) {
            Window.alert(e);
            return false;
        }

        ew_setProps(ease_and_wizz.easingEquation);
        app.endUndoGroup();
    };

    var ew_createPalette = function (thisObj) {
        var LIST_DIMENSIONS = [0, 0, 140, 15];
        var STATIC_TEXT_DIMENSIONS = [0, 0, 60, 15];

        if (thisObj instanceof Panel) {
            ease_and_wizz.palette = thisObj;
        } else {
            ease_and_wizz.palette = new Window("palette", "Easing", undefined, {resizeable: true});
        }

        ease_and_wizz.palette.margins = 6;
        ease_and_wizz.palette.alignChildren = "left";

        // fix the text display in the popup menu - thanks Jeff Almasol
        var winGfx = ease_and_wizz.palette.graphics;
        var darkColorBrush = winGfx.newPen(winGfx.BrushType.SOLID_COLOR, [0, 0, 0], 1);
        var key;

        // popup menus


        // "easing" menu

        var easingGrp = ease_and_wizz.palette.add("group", undefined, "Easing group");
        easingGrp.add("statictext", STATIC_TEXT_DIMENSIONS, "Easing:");

        ease_and_wizz.easingList = easingGrp.add("dropdownlist", LIST_DIMENSIONS, ease_and_wizz.easingTypesAry);
        ease_and_wizz.easingList.helpTip = ease_and_wizz.TOOLTIP_EASING;
        ease_and_wizz.easingList.graphics.foregroundColor = darkColorBrush;

        ew_set_easing_menu();

        ease_and_wizz.easingList.onChange = function () {
            if (ease_and_wizz.easingList.selection === null) {
                // tried to select a greyed-out item, ignore
                ew_set_easing_menu();
                // return;
            } else {
                app.settings.saveSetting("easeandwizz", ease_and_wizz.EASING_SETTINGS_KEY, ease_and_wizz.easingList.selection.text);
            }
        };

        // "type" menu

        var typeGrp = ease_and_wizz.palette.add("group", undefined, "Type group");
        typeGrp.add("statictext", STATIC_TEXT_DIMENSIONS, "Type:");

        ease_and_wizz.typeList = typeGrp.add("dropdownlist", LIST_DIMENSIONS, ease_and_wizz.inOutLookup);
        ease_and_wizz.typeList.graphics.foregroundColor = darkColorBrush;
        ease_and_wizz.typeList.helpTip = ease_and_wizz.TOOLTIP_TYPE;

        if (app.settings.haveSetting("easeandwizz", ease_and_wizz.TYPE_SETTINGS_KEY)) {
            key = app.settings.getSetting("easeandwizz", ease_and_wizz.TYPE_SETTINGS_KEY); // from the settings
            ease_and_wizz.typeList.selection = ew_indexOf(key, ease_and_wizz.inOutLookup);
        } else {
            ease_and_wizz.typeList.selection = 0; // select the first item
        }

        ease_and_wizz.typeList.onChange = function () {
            app.settings.saveSetting("easeandwizz", ease_and_wizz.TYPE_SETTINGS_KEY, ease_and_wizz.typeList.selection.text);
        };

        // "keys" menu

        var keysGrp = ease_and_wizz.palette.add("group", undefined, "Keys group");
        keysGrp.add("statictext", STATIC_TEXT_DIMENSIONS, "Keys:");

        ease_and_wizz.keysList = keysGrp.add("dropdownlist", LIST_DIMENSIONS, ease_and_wizz.keysLookup);
        ease_and_wizz.keysList.graphics.foregroundColor = darkColorBrush;
        ease_and_wizz.keysList.helpTip = ease_and_wizz.TOOLTIP_KEYS;

        if (app.settings.haveSetting("easeandwizz", ease_and_wizz.KEYS_SETTINGS_KEY) && !ease_and_wizz.curvaceousCheckbox.value) {
            key = app.settings.getSetting("easeandwizz", ease_and_wizz.KEYS_SETTINGS_KEY); // from the settings
            ease_and_wizz.keysList.selection = ew_indexOf(key, ease_and_wizz.keysLookup);
        } else {
            ease_and_wizz.keysList.selection = 0; // select the first item
        }

        ease_and_wizz.keysList.onChange = function () {
            app.settings.saveSetting("easeandwizz", ease_and_wizz.KEYS_SETTINGS_KEY, ease_and_wizz.keysList.selection.text);
        };


        // curvaceous checkbox
        var curvaceousGrp = ease_and_wizz.palette.add("group", undefined, "Curvaceous group");

        curvaceousGrp.add("statictext", STATIC_TEXT_DIMENSIONS, "\u00A0");
        ease_and_wizz.curvaceousCheckbox = curvaceousGrp.add("checkbox", undefined, "Curvaceous");
        ease_and_wizz.curvaceousCheckbox.helpTip = ease_and_wizz.TOOLTIP_CURVACEOUS;

        if (app.settings.haveSetting("easeandwizz", ease_and_wizz.CURVACEOUS_SETTINGS_KEY)) {
            if (app.settings.getSetting("easeandwizz", ease_and_wizz.CURVACEOUS_SETTINGS_KEY) === "1") {
                ease_and_wizz.curvaceousCheckbox.value = true;
            } else {
                ease_and_wizz.curvaceousCheckbox.value = false;
            }
        } else {
            // no setting, choose the default
            ease_and_wizz.curvaceousCheckbox.value = false;
        }


        // update the panel
        ease_and_wizz.curvaceousCheckbox.onClick = ew_fixMenus;


        // apply button
        var buttonGrp = ease_and_wizz.palette.add("group", undefined, "Button group");
        buttonGrp.add("statictext", STATIC_TEXT_DIMENSIONS, "");

        ////////////////////
        // apply button
        ////////////////////

        var applyBtn = buttonGrp.add("button", undefined, "Apply");
        applyBtn.onClick = ew_applyExpressions;
        var helpBtn = buttonGrp.add("button {text:'?', maximumSize:[30,30]}");
        helpBtn.onClick = function () {
            alert("Ease and Wizz v" + ease_and_wizz.VERSION + "\n" + ease_and_wizz.strHelpText, "Ease and Wizz");
        };


        if (ease_and_wizz.palette instanceof Window) {
            ease_and_wizz.palette.show();
        } else {
            ease_and_wizz.palette.layout.layout(true);
        }

        ew_fixMenus();
    };

    ease_and_wizz.EASING_FOLDER = "easingExpressions";
    ease_and_wizz.VERSION = "2.5.3";
    ease_and_wizz.easingEquation = "";
    ease_and_wizz.palette = {};

    // palette controls
    ease_and_wizz.easingList = {};
    ease_and_wizz.typeList = {};
    ease_and_wizz.keysList = {};
    ease_and_wizz.curvaceousCheckbox = {};

    // define values for the controls
    ease_and_wizz.keysLookup = ["All", "Start and end", "Start only"];
    ease_and_wizz.inOutLookup = ["In + Out", "In", "Out"];
    ease_and_wizz.multiLookup = ["Expo out, Expo in", "Expo in, Expo out", "Back out, Expo in", "Back out, Back in", "Elastic out, Back in", "Elastic out, Expo in", "Bounce out, Expo in"];

    // names of the settings to be saved
    ease_and_wizz.CURVACEOUS_SETTINGS_KEY = "curvaceous";
    ease_and_wizz.TYPE_SETTINGS_KEY = "type";
    ease_and_wizz.KEYS_SETTINGS_KEY = "keys";
    ease_and_wizz.EASING_SETTINGS_KEY = "easing";

    // easing curves, including the multi-types
    ease_and_wizz.easingTypesAry = ["Expo", "Circ", "Quint", "Quart", "Quad", "Sine", "-", "Bounce", "Back", "Elastic", "-"].concat(ease_and_wizz.multiLookup);

    // strings used in the interface
    ease_and_wizz.strHelpText = "Ease and Wizz is a set of expressions that give you more animation options, such as exponential, elastic, and bounce. Simply select a keyframe, choose the type of easing, and click \"Apply\". The relevant expression will be attached to that property.\n" +
            "\n" +
            "Turn on the Curvaceous checkbox if you're animating mask or shape paths, or curved motion paths.\n" +
            "\n" +
            "Latest version, documentation, and videos are available from aescripts.com/ease-and-wizz/\n" +
            "\n" +
            "Thanks for using Ease and Wizz!\nIan Haigh (ianhaigh.com)";
    ease_and_wizz.TOOLTIP_CURVACEOUS = "Turn this on if you’re easing a mask shape or shape path. Note that due to the way it works, Curvaceous automatically disables the “special” easing types, back, bounce, and elastic.";
    ease_and_wizz.TOOLTIP_KEYS = "When there are more than two keyframes, this affects whether it eases ALL of the keyframes (the default), the first and last two, or only the first two. Other keyframes will behave as usual.";
    ease_and_wizz.TOOLTIP_EASING = "Choose the type of easing here. They're arranged from most dramatic (expo) to least dramatic (sine), followed by “special effects” (back, bounce, elastic).\n\nFinally, the multi-easing types: one easing type, followed by the other. They apply to the first two and the last two keyframes of a property.";
    ease_and_wizz.TOOLTIP_TYPE = "Whether the values ease in, out, or both.";
    ease_and_wizz.CURVACEOUS_ERROR_TXT = "It looks like you have a Mask Path selected. To apply Ease and Wizz to a Mask Path, select the ‘Curvaceous’ checkbox and try again.";

    ew_createPalette(ui_reference);
}

ease_and_wizz_script(this);
