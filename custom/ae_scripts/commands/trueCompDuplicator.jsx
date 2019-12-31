{
    /////////////////////////////////////////////////////////////////////////
    //
    // True Comp Duplicator v3
    //
    // ©2010 Brennan Chapman
    // Author: Brennan Chapman
    // 2.0 enhancements: Brennan Chapman & Lloyd Alvarez
    //
    // Creates a complete duplicate of a comp hierarchy including subcomps.
    // Also, makes sure if a comp is used multiple times that it only gets duplicated
    // once and all remaining references point to the first duplicate.
    //
    // Version History
    // 1.0 initial release - 04/2010
    // 2.0 Added UI,  search and replace new comp name, maintian hierarchy and arrange into new folder option, non-english AE support, blessed for CS5 - 05/2010
    // 2.1 Fixed folder hierarchy when using add into new folder option and CS3 comp name limit bug  - 08/2010
    // 2.2 Fixed bug when running script from Scripts menu - 02/2011 (LA)
    // 3.0 Massive update
    //      - Updates expressions
    //      - Multiple copies
    //      - Depth limit
    //      - Duplicates Footage Items
    //      - Exclude Filter
    //      - Select multiple comps at once
    //      - Improved naming
    //      - Help
    //      - Progress Dialog
    // 3.1 - Fixes
    //      New Features
    //      - Expression Erros window
    //      - New Update Expression Algorithm and Help info
    //      Bug Fixes
    //      - Fixed errors with special characters (*/#$%) in comp names.
    //      - Fixed expression errors when replacing comp names and layer names.
    //      - Fixed expression counter not resetting.
    //      - Fixed expressions only using last copy when duplicating multiple copies.
    // 3.2 - Fix
    //      - Fixed variable issue with Elementary script clashing with tcd_prefsToSave
    // 3.3 - Fix
    //      - Fixed Search Replace and Increment of last digit in names
    //      - Added gui option for incrementing last number
    // 3.4 - Fix
    //      - Reorganized increment before search and replace in rename
    // 3.5 - Fix
    //      - Fixed regex error when replacing expressions, and accounts for multiple
    //         comp("***").layer("***") expressions in one line
    // 3.6 - Fix
    //      - Fix to allow names longer than 31 characters post CS3
    //      - Added ability to set label colors on duplicates
    // 3.7 - Fix
    //      - Adjusted order of increment to happen after the search and replace
    //      - Added ability to increment either the first or last character of a name.
    // 3.8 - Fix
    //      - Fixed compatibility for getting label colors with all versions of after effects
    //
    // 3.9 - Fix
    //      - Fixed compatibility with After Effects CC
    // 3.9.1 - Fix
    //      - After Effects CS4 fix, they only had 15 label colors, compared to the 16 currently
    // 3.9.2 - Fix
    //      - Fixed removing of leading zeros
    // 3.9.3 - Fix
    //      - Bugfix for Group Items Into Folder without a number in the folder name
    // 3.9.4 - Feature and Fix
    //      - Fixed extra debug lines being active causing the script editor to open
    //      - Added regex option to exclude
    // 3.9.5 - Fixed Regex bug - commented out $.writeln on line 974 - LA
    // 3.9.6 - Fix
    //      - Added try except for label color
    // 3.9.7 - Features
    //      - Added duplicate solids
    //      - Add error dialog when duplicate a selection that contains items other than comps
    //      - Add select duplicates option to select the new top-level duplicates after duplicating
    // 3.9.8 - Fix
    //      - Bugfix for handling preferences cuasing duplicate not to work
    // 3.9.9 - Fix
    //      - Fix for AE incrementing name event when increment is unchecked
    // 3.9.10 - Feature
    //      - Speed up updating expresssions
    // 3.9.11 - Feature
    //      - Fix version identifier in help screen
    ////////////////////////////////////////////////////////////////////////
    
    // Global Variables
    var tcd_origParentFolder, tcd_parentFolder, tcd_fixExp, tcd_maxDepth, tcd_copyNum, tcd_progDlg;
    var tcd_scriptName = "True Comp Duplicator";
    var tcd_version = "3.9.11";
    var tcd_folderNameDef = "Duplicated Comps";
    var tcd_strHelpHeader = tcd_scriptName + " v" + tcd_version;
    var tcd_strHelpText = "This script creates a complete duplicate of the selected comp hierarchies, including sub-comps.\n\
    If a comp is used multiple times, the comp only gets duplicated once and all remaining references point to the first duplicate.\n\
    If the comps are arranged in a special folder hierarchy in the project panel, that folder hierarchy is preserved or duplicated (depending on user preference) for the duplicated comps.\n\
    This version saves you even more time, by adding much greater control over the duplication process.\n\
    New Item Naming\
    - You can add a prefix or suffix to the names of the duplicated items.\
    \tThis includes both comps, folders and footage.\
    - You can search and replace text in the names of the duplicated items.\
    \tNotes: The search string is not case-sensitive.\n\
    Options\
    - Group the duplicated items into a new folder with the specified name.\
    - Exclude items whose names contain the supplied prefix/suffix.\
    \tThis allows you to duplicate only some of the nested comps/footage.\
    - Depth limit for how many deep the duplication process should go.\
    - Update Expressions with comp name changes resulting from the\
    \tduplication process. Note: When updating expressions,\
    \tonly the following item references will be updated.\
          comp(\"DUPLICATE ITEM\'S NAME\")\
          comp(\"DUPLICATE ITEM'S NAME\").layer(\"DUPLICATE ITEM\'S NAME\")\
          thisComp.layer(\"DUPLICATE ITEM\'S NAME\")\
    - Duplicate Footage will duplicate the footage references in the project panel.\
    \tYou can then right-click and replace the duplicated footage\
    \twith different art/video.\
    \tNote: This will not actually duplicate the items on your hard drive,\
    \tjust their references in your project. This will not duplicate solids,\
    \tadjustment layers or null objects.\n\
    - Duplicate Solids will duplicate the solids used in the comps.\n\
    - Select Duplicates will select the new top-level duplicates after duplicating.\n\
    You can also specify the amount of copies to make.\
    Note: The last number in each copy's name will be automatically incremented. If there isn't a number, one will be added.\n\
    This version of the script requires After Effects CS3 or later. It can be used as a dockable panel by placing the script in the ScriptUI Panels subfolder of the Scripts folder, and then choosing this script from the Window menu.";
    var previousComps = [];
    var previousFolders = [];
    var previousFootage = [];
    var tcd_prefsToSave = [];
    var tcd_expFixCount = 0;
    
    // -- Prototypes
    if (typeof String.prototype.startsWith != 'function') {
      String.prototype.startsWith = function (str){
        return this.indexOf(str) == 0;
      };
    }
    
    if (typeof String.prototype.endsWith != 'function') {
      String.prototype.endsWith = function (str){
        return this.slice(-str.length) == str;
      };
    }
    
    // -- Functions
    function escapeRegExp(str) {
      return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
    }
    
    // Get the names of the label colors in order 1-16
    function tcd_getColorNames() {
        var colors = [];
    
        // Locate valid label preferences key
        var prefKeyBase = "Label Preference Text Section ";
        var prefKey = null;
        for (var i=1; i<=10; i++) {
            var newPrefKey = prefKeyBase + i;
            if (parseFloat(app.version) >= 12) {
                // After Effects CC splits up preference files into different groups
                // Adding the third parameter specifies which preference file to look in
                if (app.preferences.havePref(newPrefKey, "Label Text ID 2 # 1", PREFType.PREF_Type_MACHINE_INDEPENDENT)) {
                    prefKey = newPrefKey;
                    break;
                }
            } else {
                if (app.preferences.havePref(newPrefKey, "Label Text ID 2 # 1")) {
                    prefKey = newPrefKey;
                    break;
                }
            }
        }
    
        if (prefKey) {
            if (parseFloat(app.version) >= 12) {
                for (var i=1; i<=16; i++) {
                    if (app.preferences.havePref(newPrefKey, "Label Text ID 2 # " + i, PREFType.PREF_Type_MACHINE_INDEPENDENT)) {
                        try {
                            var col = app.preferences.getPrefAsString(prefKey , "Label Text ID 2 # " + i, PREFType.PREF_Type_MACHINE_INDEPENDENT);
                            colors.push(col);
                        } catch(e) {};
                    }
                }
            } else {
                for (var i=1; i<=16; i++) {
                    if (app.preferences.havePref(newPrefKey, "Label Text ID 2 # " + i)) {
                        try {
                            var col = app.preferences.getPrefAsString(prefKey , "Label Text ID 2 # " + i);
                            colors.push(col);
                        } catch(e) {};
                    }
                }
            }
        } else {
            //$.writeln("prefkey not found");
        }
        return colors;
    }
    
    function tcd_loadAndRegPref(prop, def) {
        // Load and register a setting stored in preferences
        // Setting name is auto determined based on property name in GUI
    
        // Get the property's name
        var name = null;
        for (var child in prop.parent) {
            if (prop.parent[child] == prop) {
                name = child;
            }
        }
    
        if (name != null) {
            var value = def;
            if (app.settings.haveSetting(tcd_scriptName, name)) {
                value = app.settings.getSetting(tcd_scriptName, name);
            }
    
            // Apply the value based on the type of control
            if (prop instanceof Checkbox) {
                prop.value =! (/^true$/i).test(value); // Opposite because notify() will invert
                prop.notify(); // Updates Enable/Disable
            } else if (prop instanceof EditText) {
                prop.text = value;
            } else if (prop instanceof DropDownList) {
                for (var i=0; i<prop.items.length; i++) {
                    if (prop.items[i].text === value) {
                        prop.selection = i;
                    }
                }
            }
        }
    
        tcd_prefsToSave.push(prop);
    }
    
    function tcd_savePrefs() {
        // Save all of the prefs found in tcd_prefsToSave
    
        for (var i=0; i<tcd_prefsToSave.length; i++) {
            var prop = tcd_prefsToSave[i];
    
            // Get the value based on the type of control
            var value = "";
            if (prop instanceof Checkbox) {
                value = prop.value;
            } else if (prop instanceof EditText) {
                value = prop.text;
            } else if (prop instanceof DropDownList && prop.selection) {
                value = prop.selection.text;
            }
    
            // Get the property's name
            var name = null;
            for (var child in prop.parent) {
                if (prop.parent[child] == prop) {
                    name = child;
                }
            }
    
            // Save the value to the preferences
            if (name != null) {
                app.settings.saveSetting(tcd_scriptName, name, value);
            }
        }
    }
    
    function tcd_buildUI(thisObj) {
    
        if (thisObj instanceof Panel) {
            var myPal = thisObj;
        } else {
            var myPal = new Window("palette",tcd_scriptName + " v" + tcd_version,undefined, {resizeable:true});
        }
    
        if (myPal != null) {
            var res =
            "group { \
                    alignment: ['fill', 'fill'], \
                    alignChildren: ['left','top'], \
                    orientation: 'column', \
                newNamesGrp: Panel { \
                    alignment: ['fill','top'], \
                    alignChildren: ['left','top'], \
                    text:'New Item Naming', \
                    preSufGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        preSufChk: Checkbox {text:''}, \
                        preSufDrp: DropDownList {alignment: ['left', 'center']}, \
                        preSufTxt: EditText {alignment: ['fill','center']}, \
                    }, \
                    replGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        replChk: Checkbox {text:''}, \
                        replSrchLbl: StaticText {text:'Search', aligment:['left','left']}, \
                        replSrchTxt: EditText {alignment: ['left','left'], preferredSize:[100,20]}, \
                        replReplLbl: StaticText {text:'Replace', alignment:['left','left']}, \
                        replReplTxt: EditText {alignment:['fill','left'], preferredSize:[100,20]}, \
                    }, \
                    incGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        incChk: Checkbox {text:''}, \
                        incLbl: StaticText {text:'Increment '}, \
                        incDrp: DropDownList {}, \
                        incLbl2: StaticText {text:' Number In Names', alignment:['fill','left']}, \
                    }, \
                    colGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        colChk: Checkbox {text:''}, \
                        colLbl: StaticText {text:'Label Color'}, \
                        colDrp: DropDownList {alignment: ['left', 'center']}, \
                    }, \
                }, \
                optionsGrp: Panel { \
                    alignment: ['fill','top'], \
                    alignChildren: ['left','top'], \
                    text:'Options', \
                    grpFldGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        grpFldChk: Checkbox {text:''}, \
                        grpFldLbl: StaticText {text:'Group Items Into Folder', alignment:['left','left']}, \
                        grpFldTxt: EditText {alignment:['fill','left']}, \
                    }, \
                    incExcGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        incExcChk: Checkbox {text:''}, \
                        incExcLbl: StaticText {text:'Exclude Items With', alignment:['left','left']}, \
                        incExcDrp: DropDownList {alignment:['left','center']}, \
                        incExcTxt: EditText {alignment:['fill','left'], preferredSize:[100,20]}, \
                    }, \
                    depGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        depChk: Checkbox {text:''}, \
                        depLbl: StaticText {text:'Depth Limit'}, \
                        depTxt: EditText {alignment:['left','left'], text:'1', preferredSize:[30,20]}, \
                    }, \
                    expGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        expChk: Checkbox {text:''}, \
                        expLbl: StaticText {text:'Update Expressions', alignment:['fill','left']}, \
                    }, \
                    dupFtgGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        dupFtgChk: Checkbox {text:''}, \
                        dupFtgLbl: StaticText {text:'Duplicate Footage (Slower)', alignment:['fill','left']}, \
                    } \
                    dupSldGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        dupSldChk: Checkbox {text:''}, \
                        dupSldLbl: StaticText {text:'Duplicate Solids', alignment:['fill','left']}, \
                    } \
                    selDupGrp: Group { \
                        orientation: 'row', \
                        alignment: ['fill','top'], \
                        selDupChk: Checkbox {text:''}, \
                        selDupLbl: StaticText {text:'Select duplicates', alignment:['fill','left']}, \
                    } \
                }, \
                toolsGrp: Panel { \
                    alignment: ['fill','top'], \
                    alignChildren: ['left','top'], \
                    text:'Tools', \
                    collectGrp: Group { \
                        orientation: 'row', \
                        collectBtn: Button {text:'Collect Dependencies', alignment:['right','top']} \
                    } \
                }, \
                btnGrp: Group { \
                    orientation: 'row', \
                    alignment: ['fill','top'], \
                    helpBtn: Button {text:'?', alignment:['left','top'], preferredSize:[30,20]}, \
                    copyLbl: StaticText {text:'Copies', alignment:['right','center']}, \
                    copyTxt: EditText {text:'1', alignment:['right','top'], preferredSize:[30,20]}, \
                    dupSelBtn: Button {text:' Duplicate Selected ', alignment:['right','top']}, \
                } \
            }";
    
            myPal.grp = myPal.add(res);
    
            // -- Enable/Disable items based on checkboxes
    
            // Prefix/Suffix
            myPal.grp.newNamesGrp.preSufGrp.preSufDrp.enabled = myPal.grp.newNamesGrp.preSufGrp.preSufChk.enabled.value;
            myPal.grp.newNamesGrp.preSufGrp.preSufTxt.enabled = myPal.grp.newNamesGrp.preSufGrp.preSufChk.enabled.value;
            myPal.grp.newNamesGrp.preSufGrp.preSufChk.onClick = function() {
                myPal.grp.newNamesGrp.preSufGrp.preSufDrp.enabled = this.value;
                myPal.grp.newNamesGrp.preSufGrp.preSufTxt.enabled = this.value;
            }
    
            // Search/Replace
            myPal.grp.newNamesGrp.replGrp.replSrchTxt.enabled = myPal.grp.newNamesGrp.replGrp.replChk.enabled.value;
            myPal.grp.newNamesGrp.replGrp.replReplTxt.enabled = myPal.grp.newNamesGrp.replGrp.replChk.enabled.value;
            myPal.grp.newNamesGrp.replGrp.replChk.onClick = function() {
                myPal.grp.newNamesGrp.replGrp.replSrchTxt.enabled = this.value;
                myPal.grp.newNamesGrp.replGrp.replReplTxt.enabled = this.value;
            }
    
            // Increment
            myPal.grp.newNamesGrp.incGrp.incDrp.enabled = myPal.grp.newNamesGrp.incGrp.incChk.enabled.value;
            myPal.grp.newNamesGrp.incGrp.incChk.onClick = function() {
                myPal.grp.newNamesGrp.incGrp.incDrp.enabled = this.value;
            }
    
            // Label Color
            myPal.grp.newNamesGrp.colGrp.colDrp.enabled = myPal.grp.newNamesGrp.colGrp.colChk.enabled.value;
            myPal.grp.newNamesGrp.colGrp.colChk.onClick = function() {
                myPal.grp.newNamesGrp.colGrp.colDrp.enabled = this.value;
            }
    
            // Exclude
            myPal.grp.optionsGrp.incExcGrp.incExcDrp.enabled = myPal.grp.optionsGrp.incExcGrp.incExcChk.enabled.value;
            myPal.grp.optionsGrp.incExcGrp.incExcTxt.enabled = myPal.grp.optionsGrp.incExcGrp.incExcChk.enabled.value;
            myPal.grp.optionsGrp.incExcGrp.incExcChk.onClick = function() {
                myPal.grp.optionsGrp.incExcGrp.incExcDrp.enabled = this.value;
                myPal.grp.optionsGrp.incExcGrp.incExcTxt.enabled = this.value;
            }
    
            // Group Into Folder
            myPal.grp.optionsGrp.grpFldGrp.grpFldTxt.enabled = myPal.grp.optionsGrp.grpFldGrp.grpFldChk.enabled.value;
            myPal.grp.optionsGrp.grpFldGrp.grpFldChk.onClick = function() {
                myPal.grp.optionsGrp.grpFldGrp.grpFldTxt.enabled = this.value;
            }
    
            // Depth Limit
            myPal.grp.optionsGrp.depGrp.depTxt.enabled = myPal.grp.optionsGrp.depGrp.depChk.enabled.value;
            myPal.grp.optionsGrp.depGrp.depChk.onClick = function() {
                myPal.grp.optionsGrp.depGrp.depTxt.enabled = this.value;
            }
    
            // -- Populate Drop Downs
    
            // Prefix/Suffix Drop Down
            var preSufOptions = ["Prefix","Suffix"];
            for (var i=0; i<preSufOptions.length; i++) {
                myPal.grp.newNamesGrp.preSufGrp.preSufDrp.add("item",preSufOptions[i]);
            }
            myPal.grp.newNamesGrp.preSufGrp.preSufDrp.selection = 1;
    
            // Increment Drop Down
            var incOptions = ["First","Last"];
            for (var i=0; i<incOptions.length; i++) {
                myPal.grp.newNamesGrp.incGrp.incDrp.add("item",incOptions[i]);
            }
            myPal.grp.newNamesGrp.incGrp.incDrp.selection = 1;
    
            // Exclude Drop Down
            var incExcOptionsB = ["Prefix","Suffix","Matching Regex"];
            for (var i=0; i<incExcOptionsB.length; i++) {
                myPal.grp.optionsGrp.incExcGrp.incExcDrp.add("item",incExcOptionsB[i]);
            }
            myPal.grp.optionsGrp.incExcGrp.incExcDrp.selection = 1;
    
            // Color Drop Downs
            var colors = tcd_getColorNames();
            for (var i=0; i<colors.length; i++) {
                myPal.grp.newNamesGrp.colGrp.colDrp.add("item", colors[i]);
            }
            myPal.grp.newNamesGrp.colGrp.colDrp.selection = 0;
    
            // -- Input Validation
    
            // Depth Limit
            myPal.grp.optionsGrp.depGrp.depTxt.onChange = function() {
                // Make sure the input is a positive integer
                if (/^\d*$/.test(this.text) != true) {
                    alert("ERROR: Invalid Depth Limit.\nMust be a positive integer.");
                    this.text = "1";
                }
            }
    
            // Copies
            myPal.grp.btnGrp.copyTxt.onChange = function() {
                // Make sure the input is a positive integer
                if (/^\d*$/.test(this.text) != true) {
                    alert("ERROR: Invalid Copy Value.\nMust be a positive integer greater than zero.");
                    this.text = "1";
                }
            }
    
            // -- Load and Register Settings
            var grp = myPal.grp
    
            // newNamesGrp
            tcd_loadAndRegPref(grp.newNamesGrp.preSufGrp.preSufChk, false);
            tcd_loadAndRegPref(grp.newNamesGrp.preSufGrp.preSufTxt, "");
            tcd_loadAndRegPref(grp.newNamesGrp.replGrp.replChk, false);
            tcd_loadAndRegPref(grp.newNamesGrp.replGrp.replSrchTxt, "");
            tcd_loadAndRegPref(grp.newNamesGrp.replGrp.replReplTxt, "");
            tcd_loadAndRegPref(grp.newNamesGrp.incGrp.incChk, true);
            tcd_loadAndRegPref(grp.newNamesGrp.incGrp.incDrp, "Last");
            tcd_loadAndRegPref(grp.newNamesGrp.colGrp.colDrp, "Red");
    
            // optionsGrp
            tcd_loadAndRegPref(grp.optionsGrp.grpFldGrp.grpFldChk, false);
            tcd_loadAndRegPref(grp.optionsGrp.grpFldGrp.grpFldTxt, "");
            tcd_loadAndRegPref(grp.optionsGrp.incExcGrp.incExcChk, false);
            tcd_loadAndRegPref(grp.optionsGrp.incExcGrp.incExcDrp, "Prefix");
            tcd_loadAndRegPref(grp.optionsGrp.incExcGrp.incExcTxt, "_");
            tcd_loadAndRegPref(grp.optionsGrp.depGrp.depChk, false);
            tcd_loadAndRegPref(grp.optionsGrp.depGrp.depTxt, "1");
            tcd_loadAndRegPref(grp.optionsGrp.expGrp.expChk, true);
            tcd_loadAndRegPref(grp.optionsGrp.dupFtgGrp.dupFtgChk, false);
            tcd_loadAndRegPref(grp.optionsGrp.dupSldGrp.dupSldChk, false);
            tcd_loadAndRegPref(grp.optionsGrp.selDupGrp.selDupChk, false);
    
            // btnGrp
            tcd_loadAndRegPref(grp.btnGrp.copyTxt, "1");
    
            // -- Buttons
    
            // Help
            myPal.grp.btnGrp.helpBtn.onClick = function () {
                if(typeof(helpWindow_unitTest) == "undefined") {
                    new helpWindow().run();
                }
            }
    
            // Duplicate Selected
            myPal.grp.btnGrp.dupSelBtn.onClick = function() {
    
                tcd_expFixCount = 0; // Reset
    
                // -- Validate the inputs
                var errors = [];
    
                // Prefix/Suffix
                if (myPal.grp.newNamesGrp.preSufGrp.preSufChk.value) {
                    if (myPal.grp.newNamesGrp.preSufGrp.preSufTxt.text === "") {
                        errors.push("No value supplied for " + myPal.grp.newNamesGrp.preSufGrp.preSufDrp.selection.text);
                    }
                }
    
                // Search/Replace
                if (myPal.grp.newNamesGrp.replGrp.replChk.value) {
                    if (myPal.grp.newNamesGrp.replGrp.replSrchTxt.text === "" ||
                        myPal.grp.newNamesGrp.replGrp.replReplTxt.text == "") {
                        errors.push("No value supplied for Search and Replace");
                    }
                }
    
                // Exclude
                if (myPal.grp.optionsGrp.incExcGrp.incExcChk.value) {
                    if (myPal.grp.optionsGrp.incExcGrp.incExcTxt.text == "") {
                        errors.push("No value supplied for " + myPal.grp.optionsGrp.incExcGrp.incExcLbl.text + " " + myPal.grp.optionsGrp.incExcGrp.incExcDrp.selection.text);
                    }
                    if (TRUECOMPDUP_PALETTE.grp.optionsGrp.incExcGrp.incExcDrp.selection.text == "Matching Regex") {
                        // Make sure the regex is valid
                        try {
                            var re = new RegExp(myPal.grp.optionsGrp.incExcGrp.incExcTxt.text, "g");
                        } catch(e) {
                            errors.push("Invalid regex for exclude: " + myPal.grp.optionsGrp.incExcGrp.incExcTxt.text);
                        }
                    }
                }
    
                // Group items into folder
                if (myPal.grp.optionsGrp.grpFldGrp.grpFldChk.value) {
                    if (myPal.grp.optionsGrp.grpFldGrp.grpFldTxt.text == "") {
                        errors.push("No value supplied for " + myPal.grp.optionsGrp.grpFldGrp.grpFldLbl.text);
                    }
                }
    
                // -- Make sure there are items selected in the project panel
                var selItems = app.project.selection.slice(0); // Make a copy for safety
                if (selItems.length <= 0) {
                    errors.push("No item selected in the project panel.");
                }
    
                // -- Ensure that selection only consists of comps
                for (var i=0; i<selItems.length; i++) {
                    if (!(selItems[i] instanceof CompItem)) {
                        errors.push("Selection contains items other than comps, please only select the top-level comp(s) you want to duplicate");
                        break;
                   }
                }
    
                // -- Save Settings
                // These were registered to be saved when they were loaded
                tcd_savePrefs();
    
                // Determine whether to fix expressions during replaceSource
                tcd_fixExp = TRUECOMPDUP_PALETTE.grp.optionsGrp.expGrp.expChk.value;
    
                // Determine max depth
                if (TRUECOMPDUP_PALETTE.grp.optionsGrp.depGrp.depChk.value) {
                    tcd_maxDepth = TRUECOMPDUP_PALETTE.grp.optionsGrp.depGrp.depTxt.text;
                } else {
                    tcd_maxDepth = -1;
                }
    
                // Determine the number of copies
                var copies = parseInt(myPal.grp.btnGrp.copyTxt.text);
    
                // -- Duplicate selected if no errors
                var expErrors = [];
                if (errors.length > 0) {
                    alert("Error\n" + errors.join("\n"));
                } else {
                    app.beginUndoGroup("True Comp Duplicator");
                    app.beginSuppressDialogs();
    
                    var max = app.project.numItems * copies;
                    if (tcd_fixExp) { max = max * 2; }
                    tcd_progDlg = new progressDlg().create("Duplicating Selected...", max);
    
                    var newComps = [];
                    var newFolders = [];
                    var newFootage = [];
    
                    try {
                        for (var c=0; c<copies; c++) {
                            tcd_progDlg.setTitle("Duplicating Selected...");
    
                            // Reset the list for each successive run
                            previousComps = []; previousFolders = []; previousFootage = [];
    
                            // Store the copy number so other functions can access it
                            tcd_copyNum = c;
    
                            // Create the group folder if specified
                            if (TRUECOMPDUP_PALETTE.grp.optionsGrp.grpFldGrp.grpFldChk.value) {
                                tcd_createGroupFolder(selItems[0]);
                            }
    
                            // Duplicate the item
                            var result = {};
                            for (var s=0; s<selItems.length; s++) {
                                result = tcd_duplicate(selItems[s]);
                            }
    
                            // Compile a list of the new comps
                            for (var i=0; i<result.comps.length; i++) {
                                newComps.push(result.comps[i].dest);
                            }
    
                            // Compile a list of the new folders
                            for (var i=0; i<result.folders.length; i++) {
                                newFolders.push(result.folders[i].dest);
                            }
    
                            // Compile a list of the new footage
                            for (var i=0; i<result.footage.length; i++) {
                                newFootage.push(result.footage[i].dest);
                            }
    
                            // Fix the expressions if needed
                            if (tcd_fixExp){
                                tcd_progDlg.setTitle("Updating Expressions...");
                                var expComps = [];
                                for (var i=0; i<result.comps.length; i++) {
                                    expComps.push(result.comps[i].dest);
                                }
                                var errors = tcd_updateExpressions(expComps);
                                expErrors.push.apply(expErrors, errors);
                            }
    
                            // Set label colors for comps
                            if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colChk.value) {
                                // newComps
                                for (var i=0; i<newComps.length; i++) {
                                    var index = TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colDrp.selection.index + 1;
                                    newComps[i].label = index;
                                }
    
                                // newFolders
                                for (var i=0; i<newFolders.length; i++) {
                                    var index = TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colDrp.selection.index + 1;
                                    newFolders[i].label = index;
                                }
    
                                // newFootage
                                for (var i=0; i<newFootage.length; i++) {
                                    var index = TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colDrp.selection.index + 1;
                                    newFootage[i].label = index;
                                }
                            }
                        }
                    } catch (err) {
                        alert(err);
                    }
    
                    var statusTxt = (newComps.length + newFolders.length + newFootage.length) + " items duplicated";
                    if (tcd_fixExp) {
                        statusTxt = statusTxt + ", " + tcd_expFixCount + " expressions updated";
                    }
    
                    if (TRUECOMPDUP_PALETTE.grp.optionsGrp.selDupGrp.selDupChk.value) {
                        var newSel = [];
                        for (var i=0; i<result.comps.length; i++) {
                            for (var s=0; s<selItems.length; s++) {
                                if (selItems[s] == result.comps[i].source) {
                                    selItems[s].selected = false;
                                    result.comps[i].dest.selected = true;
                                }
                            }
                        }
                    }
    
                    tcd_progDlg.complete("Process Complete!", statusTxt);
                    app.endSuppressDialogs(false);
                    app.endUndoGroup();
                }
                if (expErrors.length > 0) {
                    new expErrWindow().run(expErrors);
                }
            }
    
    
    
    
            // Collect Dependencies
            myPal.grp.toolsGrp.collectGrp.collectBtn.onClick = function() {
    
                tcd_expFixCount = 0; // Reset
    
                // -- Validate the inputs
                var errors = [];
    
                // Exclude
                if (myPal.grp.optionsGrp.incExcGrp.incExcChk.value) {
                    if (myPal.grp.optionsGrp.incExcGrp.incExcTxt.text == "") {
                        errors.push("No value supplied for " + myPal.grp.optionsGrp.incExcGrp.incExcLbl.text + " " + myPal.grp.optionsGrp.incExcGrp.incExcDrp.selection.text);
                    }
                    if (TRUECOMPDUP_PALETTE.grp.optionsGrp.incExcGrp.incExcDrp.selection.text == "Matching Regex") {
                        // Make sure the regex is valid
                        try {
                            var re = new RegExp(myPal.grp.optionsGrp.incExcGrp.incExcTxt.text, "g");
                        } catch(e) {
                            errors.push("Invalid regex for exclude: " + myPal.grp.optionsGrp.incExcGrp.incExcTxt.text);
                        }
                    }
                }
    
                // Group items into folder
                if (myPal.grp.optionsGrp.grpFldGrp.grpFldChk.value) {
                    if (myPal.grp.optionsGrp.grpFldGrp.grpFldTxt.text == "") {
                        errors.push("No value supplied for " + myPal.grp.optionsGrp.grpFldGrp.grpFldLbl.text);
                    }
                } else {
                    errors.push("To collect dependencies, you must enable 'Group Items Into Folder'")
                }
    
                // -- Make sure there are items selected in the project panel
                var selItems = app.project.selection.slice(0); // Make a copy for safety
                if (selItems.length <= 0) {
                    errors.push("No item selected in the project panel.");
                }
    
                // -- Ensure that selection only consists of comps
                for (var i=0; i<selItems.length; i++) {
                    if (!(selItems[i] instanceof CompItem)) {
                        errors.push("Selection contains items other than comps, please only select the top-level comp(s) you want to collect dependencies for.");
                        break;
                   }
                }
    
                // -- Save Settings
                // These were registered to be saved when they were loaded
                tcd_savePrefs();
    
                // Determine max depth
                if (TRUECOMPDUP_PALETTE.grp.optionsGrp.depGrp.depChk.value) {
                    tcd_maxDepth = TRUECOMPDUP_PALETTE.grp.optionsGrp.depGrp.depTxt.text;
                } else {
                    tcd_maxDepth = -1;
                }
    
                // -- Collect if no errors
                var expErrors = [];
                if (errors.length > 0) {
                    alert("Error\n" + errors.join("\n"));
                } else {
                    app.beginUndoGroup("Collect Dependencies");
                    app.beginSuppressDialogs();
    
                    tcd_progDlg = new progressDlg().create("Collecting Dependencies...");
    
                    var newComps = [];
                    var newFolders = [];
                    var newFootage = [];
    
                    try {
                        tcd_progDlg.setTitle("Collecting Dependencies...");
    
                        // Reset the list for each successive run
                        previousComps = []; previousFolders = []; previousFootage = [];
    
                        // Create the group folder
                        tcd_createGroupFolder(selItems[0]);
    
                        // Collect
                        var results = [];
                        for (var s=0; s<selItems.length; s++) {
                            results.push(tcd_collect(selItems[s]))
                        }
    
                        var newComps = []
                        var newFolders = []
                        var newFootage = []
                        for (var r=0; r<results.length; r++) {
                            var result = results[r]
                            newComps.push.apply(newComps, result.newComps)
                            newFolders.push.apply(newFolders, result.newFolders)
                            newFootage.push.apply(newFootage, result.newFootage)
                        }
    
                        // Set label colors for comps
                        if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colChk.value) {
                            // newComps
                            for (var i=0; i<newComps.length; i++) {
                                var index = TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colDrp.selection.index + 1;
                                newComps[i].label = index;
                            }
    
                            // newFolders
                            for (var i=0; i<newFolders.length; i++) {
                                var index = TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colDrp.selection.index + 1;
                                newFolders[i].label = index;
                            }
    
                            // newFootage
                            for (var i=0; i<newFootage.length; i++) {
                                var index = TRUECOMPDUP_PALETTE.grp.newNamesGrp.colGrp.colDrp.selection.index + 1;
                                newFootage[i].label = index;
                            }
                        }
                    } catch (err) {
                        alert(err);
                    }
    
                    var statusTxt = (newComps.length + newFolders.length + newFootage.length) + " items colected";
    
                    if (TRUECOMPDUP_PALETTE.grp.optionsGrp.selDupGrp.selDupChk.value) {
                        var newSel = [];
                        // Deselect existing items
                        for (var s=0; s<selItems.length; s++) {
                            selItems[s].selected = false;
                        }
    
                        // Select the comps
                        for (var i=0; i<prevComps.length; i++) {
                            prevComps[i].selected = true;
                        }
                    }
    
                    tcd_progDlg.complete("Process Complete!", statusTxt);
                    app.endSuppressDialogs(false);
                    app.endUndoGroup();
                }
                if (expErrors.length > 0) {
                    new expErrWindow().run(expErrors);
                }
            }
    
            // -- Final Cleanup
            myPal.layout.layout(true);
            myPal.layout.resize();
            myPal.onResizing = myPal.onResize = function () {this.layout.resize();}
        }
        return myPal;
    }
    
    // -- Progress Dialog
    function progressDlg() {
        this.windowRef = null;
    }
    
    progressDlg.prototype.create = function(title, max) {
        var win = new Window("palette", tcd_scriptName + " Progress",undefined,{resizeable:true, closeButton:false});  // bounds = [left, top, right, bottom]
        this.windowRef = win;
    
        var res =
        "group { \
            alignment: ['fill', 'fill'], \
            alignChildren: ['left','top'], \
            orientation: 'column', \
            titleTxt: StaticText {text:'"+title+"', alignment:['fill','left']}, \
            statusTxt: StaticText {text:'', alignment:['fill','left']}, \
            progGrp: Group { \
                orientation: 'row', \
                alignment: ['fill','top'], \
                progBar: Progressbar {alignment:['fill','center'], preferredSize:[200,-1], maxvalue:'"+max+"'}, \
                progBtn: Button {text:'Cancel', alignment:['right','center'], properties:{name:’cancel’}}, \
            }, \
        }";
    
        win.grp = win.add(res);
        win.cancelElement = win.grp.progGrp.progBtn;
        win.defaultElement = win.grp.progGrp.progBtn;
    
        // Cancel Button
        this.cancel = false;
        win.grp.progGrp.progBtn.onClick = function() {
            this.cancel = true;
            win.close();
        }
    
        // -- Final Cleanup
        win.layout.layout(true);
        win.layout.resize();
        win.onResizing = win.onResize = function () {this.layout.resize();}
    
    
        // Display the window
        win.center();
        win.show();
        return this;
    }
    
    progressDlg.prototype.setTitle = function(titleTxt) {
        this.windowRef.grp.titleTxt.text = titleTxt;
    }
    
    progressDlg.prototype.update = function(increment, statusTxt) {
        this.windowRef.grp.progGrp.progBar.value = this.windowRef.grp.progGrp.progBar.value + increment;
        this.windowRef.grp.statusTxt.text = statusTxt;
    }
    
    progressDlg.prototype.close = function() {
        this.windowRef.close();
    }
    
    progressDlg.prototype.complete = function(titleTxt, statusTxt) {
        this.windowRef.grp.titleTxt.text = titleTxt;
        this.windowRef.grp.statusTxt.text = statusTxt;
        this.windowRef.grp.progGrp.progBar.value = this.windowRef.grp.progGrp.progBar.maxvalue;
        this.windowRef.grp.progGrp.progBtn.text = "Ok";
        this.windowRef.grp.progGrp.progBtn.active = true;
    }
    
    // -- Help Window
    function helpWindow() {
        this.windowRef = null;
    }
    
    helpWindow.prototype.run = function() {
        var win = new Window("palette", tcd_scriptName,[100,0,580,600]);  // bounds = [left, top, right, bottom]
        this.windowRef = win;
        win.btnPanel = win.add("group", [10,10,600,600]);
        win.btnPanel.text = win.btnPanel.add("statictext", [10,10,400,25], tcd_strHelpHeader);
        win.btnPanel.warnBtn = win.btnPanel.add("edittext", [10,40,450,540], tcd_strHelpText, {multiline:true});
        win.btnPanel.aesBtn = win.btnPanel.add("button", [310, 550,450, 580], "http://aescripts.com");
    
        win.btnPanel.aesBtn.onClick = function() {
            openURL("http://aescripts.com");
        };
    
        // Display the window
        win.center();
        win.show();
        return true;
    }
    
    // -- Expression Error Window
    function expErrWindow() {
        this.windowRef = null;
    }
    
    expErrWindow.prototype.run = function(expErrors) {
        var win = new Window("palette", tcd_scriptName + " - Expression Errors",[100,0,580,600]);  // bounds = [left, top, right, bottom]
        this.windowRef = win;
        win.btnPanel = win.add("group", [10,10,600,600]);
        win.btnPanel.text = win.btnPanel.add("statictext", [10,10,400,25], "Duplication complete, but with " + expErrors.length + " expression error(s)...");
        win.btnPanel.warnBtn = win.btnPanel.add("edittext", [10,40,450,540], expErrors.join("\n\n"), {multiline:true});
        win.btnPanel.aesBtn = win.btnPanel.add("button", [310, 550,450, 580], "Ok");
    
        win.btnPanel.aesBtn.onClick = function() {
            win.close();
        };
    
        // Display the window
        win.center();
        win.show();
        return true;
    }
    
    
    function openURL(url)  // This function open a URL in a browser - Copyright (c) 2006-2007 redefinery (Jeffrey R. Almasol). All rights reserved.
    {
        if ($.os.indexOf("Windows") != -1){
            system.callSystem("cmd /c \""+ Folder.commonFiles.parent.fsName + "\\Internet Explorer\\iexplore.exe" + "\" " + url);
        } else {
            var cmd = "open \"" + url + "\"";  // Switched to open, tad bit faster
            // $.writeln("cmd: " + cmd);
            system.callSystem(cmd);
        }
    }
    
    function tcd_saveProjItmSel() {
        // Save the current selection of items in the project panel
        var result = app.project.selection.slice(0); // Make a copy
        return result;
    }
    
    function tcd_loadProjItmSel(sel) {
        // Load a saved selection of items in the project panel
        for (var i=0; i<sel.length; i++) { sel[i].selected = true; }
    }
    
    function tcd_clearProjItmSel() {
        // Deselect all project items
        for (var i=1; i<=app.project.numItems; i++) { app.project.item(i).selected = false; }
    }
    
    function tcd_duplicateProjItem(item) {
        // Duplicate the supplied project item
        // There isn't a direct way to duplicate footage items
        // through the JavaScript framework, so we'll use the menu
        // command to do it.
    
        var chk = tcd_checkPreviousFootage(item);
    
        var result = [];
        if (chk == null) {
    
            // Make sure the project panel is visible or this won't work
            app.project.showWindow(true);
    
            // Save current selection
            var sel = tcd_saveProjItmSel();
    
            // Deselect all items
            tcd_clearProjItmSel();
    
            // Store a list of item ids
            var beforeIDs = [];
            for (var d=1; d<=app.project.numItems; d++) {
                beforeIDs.push(app.project.item(d).id);
            }
    
            // Select specificied item
            item.selected = true;
    
            // Duplicate it using the menu command
            // To find the command ID use:
            //      app.findMenuCommandId("Duplicate"); // Result: 2080;
            // However, this will change depending on the language, so we will use the result
            app.executeCommand(2080);
    
            // Compare the saved list of ids to the current
            for (var d=1; d<=app.project.numItems; d++) {
                var itm = app.project.item(d);
    
                var found = false;
                for (var i=0; i<beforeIDs.length; i++) {
                    if (itm.id == beforeIDs[i]) { found = true; }
                }
    
                if (found == false) { result.push(itm); }
            }
            // Reload the selection
            tcd_clearProjItmSel(); tcd_loadProjItmSel(sel);
    
            if (result.length > 0 && result[0] != null) {
                // Change the items name
                for (var r=0; r<result.length; r++) {
                    result[r].name = tcd_changeName(item.name);
                }
    
                // Check if folder structure should be duplicated
                if (tcd_progDlg.cancel == false && TRUECOMPDUP_PALETTE.grp.optionsGrp.grpFldGrp.grpFldChk.value) {
                    // Duplicate the folder structure
                    result[0].parentFolder = tcd_duplicateFolderStructure(result[0].parentFolder);
                }
    
                // Store the footage in previousFootage
                var ftg = {};
                ftg.source = item;
                ftg.dest = result[0];
                previousFootage.push(ftg);
            }
    
        } else {
            result.push(chk);
        }
    
        // Return the new item
        if (result.length > 1) { return result;
        } else if (result.length == 1) { return result[0];
        } else { return null; };
    }
    
    function tcd_collect_deps_for_comp(comp) {
        var prevComps = []
        var prevFootage = []
        var prevFolders = []
    
        function _get_prevComp(comp) {
            for (var i=0; i<prevComps.length; i++) {
                if (prevComps[i].id == comp.id) {
                    return prevComps[i]
                }
            }
        }
    
        function _collect(comp, depth) {
            for (var i=1; i<=comp.numLayers; i++) {
                var layer = comp.layer(i);
    
                if (tcd_progDlg.cancel) { break; }
                tcd_progDlg.update(1, comp.name);
    
                if (layer instanceof AVLayer && tcd_incExcFilter(layer.source.name)) {
                    if (layer.source && layer.source instanceof CompItem) {
                        // Layer is a comp
    
                        // Make sure we are still complying with the depth limit
                        if (tcd_maxDepth == -1 || depth < tcd_maxDepth) {
                            // Check if this comp has already been duplicated
                            check = _get_prevComp(layer.source);
    
                            if (check == null) {
                                // Comp we haven't seen before
                                _collect(layer.source, depth+1);
    
                                // Update: Store the previousComps as an object
                                // This allows for faster processing later.
                                prevComps.push(layer.source.id);
                            }
                        }
                    } else if (layer.source.mainSource instanceof FileSource) {
                        // // Layer is an AVLayer and has a FileSource, so we'll duplicate it
                        // // There doesn't seem to be a benefit for duplicating solids, so we won't
                        // if (TRUECOMPDUP_PALETTE.grp.optionsGrp.dupFtgGrp.dupFtgChk.value) {
    
                        //     var newItem = tcd_duplicateProjItem(layer.source);
                        //     if (newItem != null) {
                        //         tcd_replaceSource(layer, newItem, tcd_fixExp);
                        //     }
                        // }
                    } else if (layer.source.mainSource instanceof SolidSource) {
                       //  if (TRUECOMPDUP_PALETTE.grp.optionsGrp.dupSldGrp.dupSldChk.value) {
    
                       //      var newItem = tcd_duplicateProjItem(layer.source);
                       //      if (newItem != null) {
                       //          tcd_replaceSource(layer, newItem, tcd_fixExp);
                       //      }
                       // }
                    }
                }
            }
    
            // Check if folder structure should be duplicated
            if (tcd_progDlg.cancel == false && TRUECOMPDUP_PALETTE.grp.optionsGrp.grpFldGrp.grpFldChk.value) {
                // Duplicate the folder structure
                comp.parentFolder = tcd_duplicateFolderStructure(comp.parentFolder);
             }
    
             return comp
        }
    
        _collect(comp, 0)
        result = {
            prevComps: prevComps,
            prevFootage: prevFootage,
            prevFolders: prevFolders,
        }
    
        return result
    }
    
    
    
    
    
    
    
    function tcd_duplicateCompStructure(comp, tcd_depth) {
        // Duplicate the supplied comp structure
    
        // -- Duplicate the incoming comp and set its name
        var newCompName = tcd_changeName(comp.name);
        var compResult = {};
        compResult.source = comp;
        var comp = comp.duplicate();
        comp.name = newCompName;
        compResult.dest = comp;
        previousComps.push(compResult);
    
        // -- Iterate through the comp and check for subcomps
        // and footage item's that need to be duplicated
        for (var i=1; i<=comp.numLayers; i++) {
            var layer = comp.layer(i);
    
            if (tcd_progDlg.cancel) { break; }
            tcd_progDlg.update(1, newCompName);
    
            if (layer instanceof AVLayer && tcd_incExcFilter(layer.source.name)) {
                if (layer.source && layer.source instanceof CompItem) {
                    // Layer is a comp
    
                    // Make sure we are still complying with the depth limit
                    if (tcd_maxDepth == -1 || tcd_depth < tcd_maxDepth) {
                        // Check if this comp has already been duplicated
                        check = tcd_checkPreviousComps(layer.source);
    
                        if (check != null) {
                            // If so, replace the source with the already duplicated comp
                            tcd_replaceSource(layer, check, tcd_fixExp);
                        } else {
                            // If not, duplicate it
    
                            // Update: Store the previousComps as an object
                            // This allows for faster processing later.
                            var compResult = {};
                            compResult.source = layer.source;
    
                            // Replace the source of the layer, and recursively check in that subcomp for sub-subcomps
                            var newComp = tcd_duplicateCompStructure(layer.source, tcd_depth+1);
                            tcd_replaceSource(layer, newComp, tcd_fixExp);
    
                            compResult.dest = layer.source;
                            previousComps.push(compResult);
                        }
                    }
                } else if (layer.source.mainSource instanceof FileSource) {
                    // Layer is an AVLayer and has a FileSource, so we'll duplicate it
                    // There doesn't seem to be a benefit for duplicating solids, so we won't
                    if (TRUECOMPDUP_PALETTE.grp.optionsGrp.dupFtgGrp.dupFtgChk.value) {
    
                        var newItem = tcd_duplicateProjItem(layer.source);
                        if (newItem != null) {
                            tcd_replaceSource(layer, newItem, tcd_fixExp);
                        }
                    }
                } else if (layer.source.mainSource instanceof SolidSource) {
                    if (TRUECOMPDUP_PALETTE.grp.optionsGrp.dupSldGrp.dupSldChk.value) {
    
                        var newItem = tcd_duplicateProjItem(layer.source);
                        if (newItem != null) {
                            tcd_replaceSource(layer, newItem, tcd_fixExp);
                        }
                   }
                }
            }
        }
    
        // Check if folder structure should be duplicated
        if (tcd_progDlg.cancel == false && TRUECOMPDUP_PALETTE.grp.optionsGrp.grpFldGrp.grpFldChk.value) {
            // Duplicate the folder structure
            comp.parentFolder = tcd_duplicateFolderStructure(comp.parentFolder);
         }
    
        // For the recursion, return the duplicate comp
        return comp;
    }
    
    function tcd_replaceSource(layer, newItem, fixExp) {
        // Replace Source, placeholder for any future improvements needed in this area
        layer.replaceSource(newItem, fixExp);
    }
    
    function tcd_incExcFilter(name) {
        // Determine whether to skip duplicating the specified item
        // Returns true to duplicate, false to skip
    
        // Make sure exclude was checked
        if (TRUECOMPDUP_PALETTE.grp.optionsGrp.incExcGrp.incExcChk.value) {
            // Determine whether we're looking for a prefix or suffix or matching regex
            // Then return the result if true
            var preSufTypeB = TRUECOMPDUP_PALETTE.grp.optionsGrp.incExcGrp.incExcDrp.selection.text;
            var preSufTxt = TRUECOMPDUP_PALETTE.grp.optionsGrp.incExcGrp.incExcTxt.text;
            if (preSufTypeB.toLowerCase() == "prefix") {
                if (name.startsWith(preSufTxt)) {
                    return false;
                }
            } else if (preSufTypeB.toLowerCase() == "suffix") {
                if (name.endsWith(preSufTxt)) {
                    return false;
                }
            } else if (preSufTypeB.toLowerCase() == "matching regex") {
                var re = new RegExp(preSufTxt,"g");
               // $.writeln("Regex match: "+ re.test(name) );
                if (re.test(name) ) {
                    return false;
                }
            }
        }
    
        return true;
    }
    
    function tcd_duplicateFolderStructure(folder) {
        // Duplicate the supplied folder structure
    
        // Check if the parent folder is root
        var check = tcd_checkPreviousFolders(folder);
    
        // If the folder hasn't been duplicated yet...
        if (folder == tcd_origParentFolder) {
            return tcd_parentFolder;
        } else if (check == null) {
            var sourceID = folder.id;
            var newFolder = app.project.items.addFolder(tcd_changeName(folder.name));
            var destID = newFolder.id;
    
            var fldr = {};
            fldr.source = folder;
            fldr.dest = newFolder;
            previousFolders.push(fldr);
    
            if (folder.parentFolder != null) {
                newFolder.parentFolder = tcd_duplicateFolderStructure(folder.parentFolder);
            }
    
            return newFolder;
        } else {
            return check;
        }
    }
    
    function tcd_checkPreviousComps(comp) {
        // Check the list of previous comps for the specified item's ID
        // to make sure it isn't duplicated twice
        for (var i=0; i<previousComps.length; i++) {
            if (previousComps[i].source.id == comp.id) { return previousComps[i].dest; }
        }
        return null;
    }
    
    function tcd_checkPreviousFolders(folder) {
        // Check the list of previous folders for the specified item's ID
        // to make sure it isn't duplicated twice
        for (var i=0; i<previousFolders.length; i++) {
            if (previousFolders[i].source.id == folder.id) { return previousFolders[i].dest; }
        }
        return null;
    }
    
    function tcd_checkPreviousFootage(footage) {
        // Check the list of previous footage for the specified item's ID
        // to make sure it isn't duplicated twice
        for (var i=0; i<previousFootage.length; i++) {
            if (previousFootage[i].source.id == footage.id) { return previousFootage[i].dest; }
        }
        return null;
    }
    
    function tcd_getItemWithID(id) {
        // Returns the proect item with the specified ID
        for (x=1; x<=app.project.numItems; x++) {
            if (app.project.item(x).id == id) { return app.project.item(x); }
        }
        return null;
    }
    
    function tcd_changeName(name) {
        // Adjust name based on New Item Naming values
        // $.writeln("tcd_changeName: " + name);
        var origName = name;
    
        // Prefix/Suffix
        if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.preSufGrp.preSufChk.value) {
            // Determine whether to use prefix or suffix
            var typ = TRUECOMPDUP_PALETTE.grp.newNamesGrp.preSufGrp.preSufDrp.selection.text;
            var txt = TRUECOMPDUP_PALETTE.grp.newNamesGrp.preSufGrp.preSufTxt.text;
    
            if (typ.toLowerCase() == "prefix") {
                name = txt + name;
                if (parseFloat(app.version) < 9) name = name.substring(0,29); // CS3 has a 31 character limit
            } else if (typ.toLowerCase() == "suffix") {
                // CS3 31 character limit, we'll trim beforehand so the suffix get's applied
                if (parseFloat(app.version) < 9) name = name.substring(0,29-txt.length); // CS3 has a 31 character limit
                name = name + txt;
            }
        }
    
        // Search/Replace
        if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.replGrp.replChk.value) {
            // $.writeln("name: " + name);
            var srchTxt = TRUECOMPDUP_PALETTE.grp.newNamesGrp.replGrp.replSrchTxt.text;
            var replTxt = TRUECOMPDUP_PALETTE.grp.newNamesGrp.replGrp.replReplTxt.text;
            // $.writeln("srchTxt: " + srchTxt);
            // $.writeln("replTxt: " + replTxt);
    
            var srchClean = srchTxt.replace(/[-[\]{}()*+?.\\^$|,#\:\s]/g, "\\$&");  // escape REGEX Special Characters
            // $.writeln("srchClean: " + srchClean);
            var srchTermRegex = new RegExp (srchClean, "gi");
            // $.writeln(srchTermRegex);
            //$.writeln("srchTermRegex: " + srchTermRegex);
            name = name.replace(srchTermRegex, replTxt);
            // $.writeln("result name: " + name);
            if (parseFloat(app.version) < 9) name = name.substring(0,29);  // CS3 has a 31 character limit
        }
    
    
        // Increment Last Number
        //$.writeln(TRUECOMPDUP_PALETTE.grp.newNamesGrp.incGrp.incChk.value);
        if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.incGrp.incChk.value) {
    
            if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.incGrp.incDrp.selection.text == "First" ) {
                // $.writeln("Before first increment: " + name);
                name = name.replace(/(\d+)/ ,
                    function(match, c1) {
                        var num = ++c1 + tcd_copyNum;
                        return tcd_pad(num, match.length);
                    }
                );
                // $.writeln("After first increment: " + name);
    
            } else if (TRUECOMPDUP_PALETTE.grp.newNamesGrp.incGrp.incDrp.selection.text == "Last" ) {
                //$.writeln("Before increment: " + name);
                name = name.replace(/(\d+)(?=\D*$)/g ,
                    function(match, c1) {
                        var num = ++c1 + tcd_copyNum;
                        return tcd_pad(num, match.length);
                    }
                );
                //$.writeln("After increment: " + name);
            }
        };
    
        // $.writeln("tcd_changeName Result: " + name);
        return name;
    }
    
    function tcd_updateExpressions (newComps) {
        // Loop through each duplicated comp and send each layer to tcd_processExpressions()
    
        var expErrors = [];
        for (var i=0; i < newComps.length; i++) {
            if (tcd_progDlg.cancel) break;
    
            if (newComps[i] != null) {
                var myComp = newComps[i];
    
                for (var j=1; j <= myComp.numLayers; j++) {
                    if (tcd_progDlg.cancel) break;
                    tcd_progDlg.update(1,"Comp: " + myComp.name + " - Layer: " + myComp.layer(j).name)
                    var errors = tcd_processExpressions(myComp.layer(j),myComp,tcd_progDlg);
                    if (errors.length > 0) {
                        for (var e=0; e<errors.length; e++) {
                            expErrors.push(errors[e]);
                        }
                    }
                }
            }
        }
        return expErrors;
    }
    
    var exp_compCheckRegExp = new RegExp ("comp\(\"*.\"\)", "g");
    var exp_compLyrRegEx = /comp\(\"(.+?)\"\)\.layer\(\"(.+?)\"\)/g;
    var exp_thisCompLyrRegEx = /thisComp.layer\(\"(.+?)\"\)/g;
    
    function tcd_processExpressions (myLayer,myComp) {
        // Process each layer's expressions, also supports property groups for myLayer for recursion
    
        var errors = [];
        for (var j=1; j<= myLayer.numProperties; j++) { //loop through the parent properties
    
            var prop = myLayer.property(j);
            if (prop.isModified == false) {
                // No modifications, so we can skip
                continue;
            }
    
            if (prop.numProperties != undefined && prop.numProperties > 0) {
                //Property group with children, let's recurse
                var err = tcd_processExpressions (prop,myComp);
                errors.push.apply(errors, err);
            }
        
            if (prop.canSetExpression &&  prop.expression != "") {
                // $.writeln ("Expression Found:\n" + myComp.name + ": "+ myLayer.name + ": "+ myLayer.property(j).name);
    
    
                var origExpression =  prop.expression;
                // $.writeln("Original Expression:\n" + origExpression);
    
                if (prop.expressionEnabled && prop.expressionError == "") {
                    var changed = false;
                    var expression = origExpression;
    
                    // --------------------------------------------------------------------------------------
                    // First, fix any comp("**") references
                    // --------------------------------------------------------------------------------------
                    if (exp_compCheckRegExp.test(expression)) {
                        for (var k=0; k < previousComps.length; k++) {
                            var oldCompName = previousComps[k].source.name;
                            if (expression.indexOf("comp(\""+oldCompName+"\")") != -1) {
                                var newCompName = previousComps[k].dest.name;
                                expression = expression.split("comp(\""+oldCompName+"\")").join("comp(\""+newCompName+"\")");
                            }
                        }
                    }
    
                    // --------------------------------------------------------------------------------------
                    // Second, fix any thisComp.layer("**") or comp("**").layer("**")  references
                    // We'll do this line by line so our regex returns the correct results
                    // --------------------------------------------------------------------------------------
    
                    var expLines = expression.split(/\r|\n/g);  // Make sure newlines are split
    
                    var result = null;
                    for (var l=0; l<expLines.length; l++) {
                        // Check for thisComp.layer("**") references
                        result = exp_thisCompLyrRegEx.exec(expLines[l]);
                        if (result != null) {
                            var sourceLayerName = result[1];
                            var sourceComp = null;
                            for (var c=0; c < previousComps.length; c++) {
                                if (previousComps[c].dest == myComp) {
                                    sourceComp = previousComps[c].source;
                                }
                            }
                            if (sourceComp != null) {
                                expLines[l] = fixLyrExpr(expLines[l], sourceLayerName, sourceComp, myComp);
                            }
                        }
    
                        // Check for comp("**").layer("**")  references
                        result = null;
                        
                        // This craziness loops over the match object
                        // http://stackoverflow.com/questions/7280586/javascript-regex-access-multiple-occurrences
                        // lastIndex is stored on the regex pattern
                        while (result = exp_compLyrRegEx.exec(expLines[l])) {
                            var sourceComp = null;
                            var destComp = null;
                            for (var c=0; c < previousComps.length; c++) {
                                if (previousComps[c].dest.name == result[1]) {
                                    destComp = previousComps[c].dest;
                                    sourceComp = previousComps[c].source;
                                }
                            }
                            var sourceLayerName = result[2];
                            if (sourceComp != null && destComp != null) {
                                expLines[l] = fixLyrExpr(expLines[l], sourceLayerName, sourceComp, destComp);
                            }
                        }
                    }
    
                    expression = expLines.join("\r");
    
                    if (expression === origExpression) {
                        continue
                        // $.writeln("No expression update needed.");
                    }
                
                    try {
                        myLayer.property(j).expression = expression;
                    } catch(err) {
                        errors.push(err.toString().replace("\r\r","\n"));
                    }
                    tcd_expFixCount++;
                }
            }
        }
        return errors;
    }
    
    function fixLyrExpr(expression, layerName, sourceComp, destComp) {
        // Update a layer expression based on the source and destination comps
        /*
        Get the layer number of the layer with the specified name in the source comp
        Get the layer name of the layer with the specified number in the new comp
        Replace the layer name in the expression with the new name
          */
    
        // $.writeln("fixLyrExpr Source: " + expression);
    
        // Get the layer number of layer with the lyrName in the sourceComp
        var lyrNum = null;
        for (var l=1; l<=sourceComp.numLayers; l++) {
            if (sourceComp.layer(l).name === layerName) {
                lyrNum = sourceComp.layer(l).index;
            }
        }
    
        var newLyrName = null;
        if (lyrNum != null) {
            // Get the layer name of the layer with the same index in the destComp
            newLyrName = destComp.layer(lyrNum).name;
        }
    
        // Replace the layer name in the expression
        if (newLyrName != null) {
            // $.writeln("fixLyrExpr Replace: " + "layer\(\""+layerName+"\"\)" + "->" + "layer\(\""+newLyrName+"\"\)");
            expression = expression.replace("layer\(\""+layerName+"\"\)", "layer\(\""+newLyrName+"\"\)");
        }
    
        // $.writeln("fixLyrExpr Result: " + expression);
        return expression;
    }
    
    function tcd_createGroupFolder(sampleItem) {
        // Create the group folder based on the hierarchy level of the sampleItem
    
        var folderName = TRUECOMPDUP_PALETTE.grp.optionsGrp.grpFldGrp.grpFldTxt.text
        // Increment Folder Name's Last Number for copies
        if (tcd_copyNum > 0) {
            if (/\d+(?!.*\d)/.test(folderName) != true) { folderName = folderName + "0"; }
        }
        var num = /\d+(?!.*\d)/.exec(folderName);
        var numPadding = 1;
        if (num != null) {
            var numPadding = num.toString().length;
        }
        folderName = folderName.replace(/\d+(?!.*\d)/, function(n){ return (tcd_pad((++n + tcd_copyNum - 1), numPadding)) });
        tcd_parentFolder = app.project.items.addFolder(folderName);
    
        // Store this in previous folders as the root
        var fldr = {}
        fldr.source = {id:'0',name:'root'};
        fldr.dest = tcd_parentFolder;
        previousFolders.push(fldr);
    
        // If the item is not in the root of the project,
        // then put the new folder on the same heirarchy level
        // as the original item's parent folder
        if (sampleItem.parentFolder.parentFolder) {
            tcd_parentFolder.parentFolder = sampleItem.parentFolder.parentFolder;
        } else {
            tcd_parentFolder.parentFolder = sampleItem.parentFolder;
        }
    
        var folder = {};
        folder.source = sampleItem.parentFolder;
        folder.dest = tcd_parentFolder;
        previousFolders.push(folder);
        // previousFolders[selItems[0].parentFolder.id] = tcd_parentFolder.id;
        tcd_origParentFolder = sampleItem.parentFolder;
    
        return tcd_parentFolder;
    }
    
    function tcd_duplicate(item) {
        // Main duplicate function
        if (item instanceof CompItem) {
            // -- Duplicate Comp Item
            tcd_duplicateCompStructure(item, 0); // 0 is the start depth
        } else {
            // -- Duplicate the project item
            tcd_duplicateProjItem(item);
        }
    
        // Return the the new comps
        var result = {};
        result.comps = previousComps.slice(0); // Make a copies
        result.folders = previousFolders.slice(0);
        result.footage = previousFootage.slice(0);
    
        return result;
    }
    
    function tcd_collect(item) {
        // Main duplicate function
        var result
        if (item instanceof CompItem) {
            result = tcd_collect_deps_for_comp(item); // 0 is the start depth
        } else {
            // -- Duplicate the project item
            // tcd_duplicateProjItem(item);
        }
    
        return result;
    }
    
    function tcd_pad(num, size) {
        // $.writeln("pad_num");
        // $.writeln(num);
        // $.writeln("pad_size");
        // $.writeln(size);
        var s = num+"";
        while (s.length < size) s = "0" + s;
        return s;
    }
    
    // -- Main
    var TRUECOMPDUP_PALETTE = tcd_buildUI(this);
    if (parseFloat(app.version) < 8) {
        alert("This script requires Adobe After Effects CS3 or later.", tcd_scriptName);
    } else {
        if (TRUECOMPDUP_PALETTE != null && TRUECOMPDUP_PALETTE instanceof Window) { TRUECOMPDUP_PALETTE.show(); }
    }
    } // End