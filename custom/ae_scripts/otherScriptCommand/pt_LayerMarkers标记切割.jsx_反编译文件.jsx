function pt_AddMarkers(l) {
    function F(W) {
        var U = (W instanceof Panel ? W : new Window("palette", z, undefined));
        if (U != null) {
            var V = "group { \t\t\t\t\torientation: 'column', alignment:['left','top'], \t\t\t\t\tselectionDropDown: DropDownList { properties:{items:" + o + "}, alignment:['fill','center']}, \t\t\t\t\ttheStack: Group { orientation:'stack', alignment:['fill','top'], \t\t\t\t\t\taddMarkers: Group { orientation:'column', \t\t\t\t\t\t\taddAt: Group { orientation: 'row', alignment:['fill','top'], \t\t\t\t\t\t\t\ttext: StaticText { text:'Based on:', alignment:['left','center']}, \t\t\t\t\t\t\t\tdropDown: DropDownList { properties:{items:" + q + "}, alignment:['left','center']}, \t\t\t\t\t\t\t}, \t\t\t\t\t\t\taddTo: Group { orientation: 'row', alignment:['fill','top'], \t\t\t\t\t\t\t\ttext: StaticText { text:'Add to:', alignment:['left','center']}, \t\t\t\t\t\t\t\tdropDown: DropDownList { properties:{items:" + i + "}, alignment:['right','center']}, \t\t\t\t\t\t\t}, \t\t\t\t\t\t}, \t\t\t\t\t\tsplitAtMarkers: Group { orientation:'column', alignment:['fill','top'], \t\t\t\t\t\t\tsplitOrder: Group { orientation: 'row', alignment:['fill','top'], \t\t\t\t\t\t\t\ttext: StaticText { text:'Split Layers:', alignment:['left','center']}, \t\t\t\t\t\t\t\tdropDown: DropDownList { properties:{items:" + n + "}, alignment:['fill','center']}, \t\t\t\t\t\t\t}, \t\t\t\t\t\t\tkeepMarkers: Checkbox { text:'Keep Markers On Split Layers', alignment:['left','center']}, \t\t\t\t\t\t}, \t\t\t\t\t}, \t\t\t\t\tfooter: Group { alignment:['fill', 'top'], \t\t\t\t\t\tabout: Button { text:'" + Q + "', maximumSize:[40,30], alignment:['left','center'] }, \t\t\t\t\t\tapply: Button { text:'Apply', alignment:['fill','center'] }, \t\t\t\t\t}, \t\t\t\t}";
            U.grp = U.add(V);
            U.grp.selectionDropDown.selection = 0;
            U.grp.theStack.addMarkers.addAt.dropDown.selection = 0;
            U.grp.theStack.addMarkers.addTo.dropDown.selection = 0;
            U.grp.theStack.splitAtMarkers.keepMarkers.value = true;
            U.grp.theStack.splitAtMarkers.visible = false;
            U.grp.theStack.splitAtMarkers.splitOrder.dropDown.selection = 0;
            if (parseFloat(app.version) >= 12) {
                if (app.preferences.havePref("Split Layer", "Grow Layer Stack Upwards", PREFType.PREF_Type_MACHINE_INDEPENDENT) && app.preferences.getPrefAsBool("Split Layer", "Grow Layer Stack Upwards", PREFType.PREF_Type_MACHINE_INDEPENDENT) == false) {
                    U.grp.theStack.splitAtMarkers.splitOrder.dropDown.selection = 1;
                }
            } else {
                if (app.preferences.havePref("Split Layer", "Grow Layer Stack Upwards") && app.preferences.getPrefAsBool("Split Layer", "Grow Layer Stack Upwards") == false) {
                    U.grp.theStack.splitAtMarkers.splitOrder.dropDown.selection = 1;
                }
            }
            U.grp.theStack.addMarkers.addTo.dropDown.preferredSize = U.grp.theStack.addMarkers.addAt.dropDown.preferredSize;
            U.grp.selectionDropDown.onChange = T;
            if (e) {
                U.grp.theStack.addMarkers.addAt.dropDown.onChange = U.grp.theStack.addMarkers.addTo.dropDown.onChange = U.grp.theStack.splitAtMarkers.splitOrder.dropDown.onChange = function () {
                    if (this.selection.index >= (this.items.length / 2)) {
                        this.selection = 0;
                    }
                };
            }
            U.grp.footer.apply.onClick = R;
            U.grp.footer.about.onClick = function () {
                if (H == null || H.visible == false) {
                    B();
                } else {
                    H.show();
                }
            };
            if (Math.floor(parseFloat(app.version)) == 8) {
                U.grp.selectionDropDown.graphics.foregroundColor = U.grp.theStack.addMarkers.addAt.dropDown.graphics.foregroundColor = U.grp.theStack.addMarkers.addTo.dropDown.graphics.foregroundColor = U.grp.theStack.splitAtMarkers.splitOrder.dropDown.graphics.foregroundColor = U.graphics.newPen(U.graphics.BrushType.SOLID_COLOR, [0, 0, 0], 1);
            }
        }
        return U;
    }

    function T() {
        if (e && this.selection.index >= (this.items.length / 2)) {
            this.selection = 0;
        }
        if (this.selection.index != 0) {
            x.grp.theStack.addMarkers.visible = false;
            x.grp.theStack.splitAtMarkers.visible = true;
        } else {
            x.grp.theStack.splitAtMarkers.visible = false;
            x.grp.theStack.addMarkers.visible = true;
        }
    }

    function R() {
        if (x.grp.selectionDropDown.selection.index == 1) {
            h();
        } else {
            w();
        }
    }

    function J(V, U) {
        if (V > U) {
            return 1;
        } else {
            return -1;
        }
    }

    function w() {
        var ac = app.project.activeItem;
        if (ac == null || !(ac instanceof CompItem)) {
            alert("You need to select a composition first.");
            return;
        }
        var ap = x.grp.theStack.addMarkers.addTo.dropDown.selection.index;
        if (ap == 1) {
            if (ac.selectedLayers.length == 0) {
                alert("You need to select at least one layer first.");
                return;
            }
            if (ac.selectedLayers.length > 1) {
                M();
                return;
            }
        } else {
            if (ap == 2) {
                Y = ac.usedIn;
                if (Y.length == 0) {
                    alert("To use the Nested Layers option this composition must be nested inside another comp.");
                    return;
                }
            }
        }
        var ao = x.grp.theStack.addMarkers.addAt.dropDown.selection.index;
        var an = ao != 1 && ao != 4;
        var ae = ao == 1 || ao == 2;
        var W = ao == 3;
        var V = ao == 4;
        var af = new Array();
        var al = new Array();
        for (var ak = 1; ak <= ac.numLayers; ak += 1) {
            X = ac.layer(ak);
            if (an) {
                af.push(X.inPoint);
            }
            if (ae) {
                af.push(X.outPoint - ac.frameDuration);
            } else {
                if (W) {
                    af.push(X.outPoint);
                }
            }
            if (V) {
                ag = (((X.outPoint - X.inPoint) - ac.frameDuration) / 2) + X.inPoint;
                ag = Math.round(ag / ac.frameDuration) * ac.frameDuration;
                af.push(ag);
            }
        }
        af = af.sort(J);
        al.push(af[0]);
        for (var ak = 1; ak < af.length; ak += 1) {
            if (af[ak] > al[al.length - 1]) {
                al.push(af[ak]);
            }
        }
        af = al;
        if (af.length == 0) {
            clearOutput();
            writeLn("No markers were added.");
        } else {
            app.beginUndoGroup("Add Markers At Cuts");
            ab = new MarkerValue("");
            am = 0;
            if (ap == 0) {
                U = ac.layers.addSolid([0, 0, 0], ac.name + " cuts", ac.width, ac.height, ac.pixelAspect, ac.duration);
                U.enabled = false;
                Z = U.property("ADBE Marker");
                for (var ak = 0; ak < af.length; ak += 1) {
                    am++;
                    Z.setValueAtTime(af[ak], ab);
                }
            } else {
                if (ap == 1) {
                    for (var ak = 0; ak < ac.selectedLayers.length; ak += 1) {
                        ai = ac.selectedLayers[ak];
                        Z = ai.property("ADBE Marker");
                        for (var aj = 0; aj < af.length; aj += 1) {
                            if (af[aj] < ai.inPoint) {
                                continue;
                            }
                            if ((af[aj] + 0.001) >= ai.outPoint) {
                                break;
                            }
                            if (Z.numKeys > 0 && Z.keyTime(Z.nearestKeyIndex(af[aj])) == af[aj]) {
                                continue;
                            } else {
                                am++;
                                Z.setValueAtTime(af[aj], ab);
                            }
                        }
                    }
                } else {
                    if (ap == 2) {
                        for (var ak = 0; ak < Y.length; ak += 1) {
                            aa = Y[ak];
                            for (var aj = 1; aj <= aa.numLayers; aj += 1) {
                                ai = aa.layer(aj);
                                if (ai.source == ac) {
                                    Z = ai.property("ADBE Marker");
                                    for (var ah = 0; ah < af.length; ah += 1) {
                                        ad = af[ah] + ai.startTime;
                                        if (ad < ai.inPoint) {
                                            continue;
                                        }
                                        if ((ad + 0.001) >= ai.outPoint) {
                                            break;
                                        }
                                        if (Z.numKeys > 0 && Z.keyTime(Z.nearestKeyIndex(ad)) == ad) {
                                            continue;
                                        } else {
                                            am++;
                                            Z.setValueAtTime(ad, ab);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            clearOutput();
            writeLn(am + " markers were added.");
            app.endUndoGroup();
        }
    }

    function M() {
        var Z = app.project.activeItem;
        var ag = 0;
        if (Z == null || !(Z instanceof CompItem)) {
            alert("You need to select a composition first.");
            return;
        }
        var W = x.grp.theStack.addMarkers.addAt.dropDown.selection.index;
        var ac = W != 1 && W != 4;
        var ah = W == 1 || W == 2;
        var U = W == 3;
        var aa = W == 4;
        var ad = new MarkerValue("");
        var V = new Array();
        app.beginUndoGroup("Add Markers At Cuts");
        for (var X = 0; X < Z.selectedLayers.length; X += 1) {
            V.length = 0;
            af = Z.selectedLayers[X];
            if (ac) {
                V.push(af.inPoint);
            }
            if (ah) {
                V.push(af.outPoint - Z.frameDuration);
            } else {
                if (U) {
                    V.push(af.outPoint);
                }
            }
            if (aa) {
                ab = (((af.outPoint - af.inPoint) - Z.frameDuration) / 2) + af.inPoint;
                ab = Math.round(ab / Z.frameDuration) * Z.frameDuration;
                V.push(ab);
            }
            ag += V.length;
            ae = af.property("ADBE Marker");
            for (var Y = 0; Y < V.length; Y += 1) {
                if (ae.numKeys > 0 && ae.keyTime(ae.nearestKeyIndex(V[Y])) == V[Y]) {
                    continue;
                } else {
                    ae.setValueAtTime(V[Y], ad);
                }
            }
        }
        clearOutput();
        writeLn(ag + " markers were added.");
        app.endUndoGroup();
    }

    function h() {
        var W = app.project.activeItem;
        if (W == null || !(W instanceof CompItem)) {
            alert("You need to select at least one layer first.");
        } else {
            var V = W.selectedLayers;
            if (V.length == 0) {
                alert("You need to select at least one layer first.");
            } else {
                app.beginUndoGroup("Split At Markers");
                for (var U = 0; U < V.length; U += 1) {
                    a(V[U]);
                }
                app.endUndoGroup();
            }
        }
    }

    function a(ac) {
        var aa = new Array();
        var X = new Array();
        var ae = new Array();
        var ag = ac.inPoint;
        var W = ac.outPoint;
        var af = ac.property("ADBE Marker");
        var Y = af.numKeys;
        for (var Z = 1; Z <= Y; Z += 1) {
            if (af.keyTime(Z) > ag && af.keyTime(Z) < W) {
                aa.push(af.keyTime(Z));
                X.push(af.keyValue(Z).comment);
            }
        }
        if (aa.length == 0) {
            return;
        }
        var V = ac.duplicate();
        ac.enabled = false;
        af = V.property("Marker");
        while (af.numKeys > 0) {
            af.removeKey(1);
        }
        for (var Z = 0; Z < aa.length; Z += 1) {
            U = V.duplicate();
            U.outPoint = aa[Z];
            ae.push(U);
            V.inPoint = aa[Z];
            V.outPoint = ac.outPoint;
            if (x.grp.theStack.splitAtMarkers.splitOrder.dropDown.selection.index == 0) {
                V.moveBefore(U);
            }
        }
        ae.push(V);
        if (x.grp.theStack.splitAtMarkers.keepMarkers.value == true) {
            var ab = 0;
            if (ae[0].inPoint < aa[0]) {
                ab = 1;
            }
            for (var Z = 0; Z < aa.length; Z += 1) {
                ad = new MarkerValue(X[Z]);
                (ae[Z + ab]).property("Marker").setValueAtTime(aa[Z], ad);
            }
        }
    }

    function m(V, U) {
        if (app.settings.haveSetting(V, U)) {
            return app.settings.getSetting(V, U);
        } else {
            return "";
        }
    }

    function L(Z) {
        var X = "";
        var V = null;
        var U = null;
        var W = new Socket();
        W.encoding = "binary";
        if (W.open("notify.aescripts.com:80", "binary")) {
            W.write("GET /versioncheck2.php?json=0&id=" + Z + " HTTP/1.1\nHost: notify.aescripts.com\n\nConnection: close\n\n");
            var Y = W.read();
            W.close();
            if (Y != undefined) {
                Y = Y.toString();
                if (Y != "" && Y.indexOf("BeginVersion") != -1 && Y.indexOf("EndVersion") != -1) {
                    Y = Y.substring(Y.lastIndexOf("BeginVersion") + 12, Y.lastIndexOf("EndVersion"));
                    return Y;
                } else {
                    return null;
                }
            } else {
                return null;
            }
        }
    }

    function j(U) {
        var V = L(D);
        if (V == undefined) {
            if (U == "help") {
                alert("Update check failed. Please try again.");
            }
            return;
        }
        if (parseFloat(V) > E) {
            if (confirm(p.replace("%N", z).replace("%V", V))) {
                k(v);
            }
        } else {
            if (U == "help") {
                alert("No new updates found.");
            }
        }
    }

    function B() {
        H = new Window("palette { \t\t\t\torientation: 'column' , text:'" + z + "', \t\t\t\theaderST: StaticText { text:'" + I + "', alignment:['left','top'] }, \t\t\t\thelpET: EditText { text:'', alignment:['fill','fill'], properties:{multiline:true}}, \t\t\t\tupdateChk: Group { orientation:'row', alignment:['fill','bottom'], alignChildren:['left','center'], \t\t\t\t\tupdateCheck: Checkbox { text:'Check for updates on launch' }, \t\t\t\t\tupdateBut: Button { text:'Check for updates now' }, \t\t\t\t}, \t\t\t}");
        var U = H;
        if (e != null) {
            U.dropDownFix = U.add("group { orientation:'row', alignment:['fill','bottom'], alignChildren:['left','center'], \t\t\t\t\tdropDownCheck: Checkbox { text:'Fix dropdown menus if displayed incorrectly. Relaunch script after changing.' }, \t\t\t\t}");
            U.dropDownFix.dropDownCheck.value = C;
            U.dropDownFix.dropDownCheck.onClick = function () {
                C = this.value;
                app.settings.saveSetting(P, "ptScripts_DropDownFix", C);
                app.preferences.saveToDisk();
                alert("This fixes an issue where drop-down menus don't display all options.\nRelaunch script to apply the changes.\n\nWhen enabled, if there are no more menu options and just extra blank entries then you aren't affected and can turn this pref off.\n\nNOTE: This setting covers all my updated 'pt_' scripts so only needs to be set once.");
            };
        }
        U.buttons = U.add("group{ orientation: 'row', alignment:['fill','bottom'], \t\t\t\thelpBtn1: Button { text:'" + t + "', alignment:['fill','center'] }, \t\t\t\thelpBtn2: Button { text:'" + r + "', alignment:['fill','center'] }, \t\t\t}");
        if (x instanceof Window) {
            U.helpET.text = A + N;
        } else {
            U.helpET.text = A;
        }
        U.helpET.onChange = U.helpET.onChanging = function () {
            if (x instanceof Window) {
                this.text = A + N;
            } else {
                this.text = A;
            }
        };
        U.updateChk.updateCheck.value = y;
        U.updateChk.updateCheck.onClick = function () {
            ptIS_Data_updateCheck = this.value;
            app.settings.saveSetting(P, z + "_UpdateCheck", y);
            app.preferences.saveToDisk();
        };
        U.updateChk.updateBut.onClick = function () {
            j("help");
        };
        U.buttons.helpBtn1.preferredSize.height = U.buttons.helpBtn2.preferredSize.height = U.buttons.helpBtn2.preferredSize.height * 1.5;
        U.buttons.helpBtn1.onClick = function () {
            if (c()) {
                k(G);
            } else {
                alert(O, z);
            }
        };
        U.buttons.helpBtn2.onClick = function () {
            if (c()) {
                k(g);
            } else {
                alert(O, z);
            }
        };
        U.layout.layout(true);
        U.size = [500, 550];
        if (U.size.width > 500) {
            U.size = [250, 275];
        }
        U.show();
    }

    function k(U) {
        if ($.os.indexOf("Windows") != -1) {
            system.callSystem("cmd /c \"" + S + U + "\"");
        } else {
            system.callSystem(d + U + K);
        }
    }

    function c() {
        var U = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
        return U == 1;
    }
    var y = true;
    var z = "pt_LayerMarkers";
    var E = 1.1;
    var s = z + " v" + E;
    var P = "ptscripts";
    var b = false;
    var C = false;
    if ($.os.indexOf("Windows") != -1 && parseFloat(app.version) >= 13) {
        e = false;
    }
    if (e != null) {
        f = m(P, "ptScripts_DropDownFix");
        if (f != "") {
            e = C = f == "true";
            b = true;
        }
    }
    var o = "[\"Add Markers At Cuts\",\"Split Layers At Markers\"]";
    var q = "[\"Layer In Points\", \"Layer Out Points\", \"In & Out Points\", \"In & Out+1 Points\", \"Layer Mid Points\"]";
    var i = "[\"New Solid Layer\", \"Selected Layers\",\"Nested Layers\"]";
    var n = "[\"Upwards\", \"Downwards\"]";
    if (e) {
        o = "[\"Add Markers At Cuts\",\"Split Layers At Markers\",\" \",\" \"]";
        q = "[\"Layer In Points\", \"Layer Out Points\", \"In & Out Points\", \"In & Out+1 Points\", \"Layer Mid Points\",\" \",\" \",\" \",\" \",\" \"]";
        i = "[\"New Solid Layer\", \"Selected Layers\",\"Nested Layers\",\" \",\" \",\" \"]";
        n = "[\"Upwards\", \"Downwards\",\" \",\" \"]";
    }
    var t = "Watch Demo, Download Updates @ aescripts.com";
    var G = "http://aescripts.com/pt_layermarkers/";
    var r = "My other scripts";
    var g = "http://aescripts.com/authors/paul-tuersley/";
    var v = "https://aescripts.com/downloadable/customer/products/";
    var u = Folder.commonFiles.parent.fsName;
    var S = ($.os.indexOf("XP") != -1 ? "\"" + u + "\\Internet Explorer\\iexplore.exe\" " : "start ");
    var d = "open \"";
    var K = "\"";
    var O = "This script requires the scripting security preference to be set.\nGo to the \"General\" panel of the application preferences and make sure \"Allow Scripts to Write Files and Access Network\" is checked.";
    var p = localize({
        en: "Update Available\nA newer version (v%V) of %N is available.\n\nWould you like to go to your downloads page at aescripts.com?"
    });
    var D = 208;
    var Q = "?";
    var I = s + " © 2010-2017 Paul Tuersley";
    var A = "This script has two functions. It can split selected layers at their layer markers, and also add markers at the in/out points of any layers in a composition.\n\n\n1 - ADD MARKERS AT CUTS:\nThis has various options for adding layer markers based on the in/out points of layers in a composition. Among other uses, it can help timeline navigation as you can then jump between edit points using the J and K keys. It can also be used to make frame selections suitable for pt_ContactSheet.\n\nHOW TO USE: Choose from the options below, then click Apply to add layer markers. With Selected Layers you'll need to select some layers first.\n\nBASED ON: Choose whether layer markers are based on in and/or out points.\n\nADD TO: Choose whether markers are added to a new solid layer, any selected layers or to nested comp layers. Markers are only added if within a layer's in/out points.\n\n\n2 - SPLIT LAYERS AT MARKERS:\nThis is similar to After Effects' built-in Split Layers feature. It splits selected layers into multiple layers wherever they have a layer marker.\n\nHOW TO USE: Select the layers (with markers) that you want to split and click Apply.\n\nSPLIT UP / DOWN: Choose whether the split layers will be stacked upwards or downwards, with the default setting matching the Preferences > General > Create Split Layers Above Original Layer setting.\n\nNote: This script requires After Effects CS3 or later.";
    var N = " It can be used as a dockable panel by placing the script in a ScriptUI Panels subfolder of the Scripts folder, and then choosing this script from the Windows menu.";
    if (parseFloat(app.version) < 8) {
        alert("This script requires After Effects CS3 or later.");
    } else {
        var f = m(P, z + "_UpdateCheck");
        if (f != "") {
            y = f == "true";
        } else {
            app.settings.saveSetting(P, z + "_UpdateCheck", y);
            app.preferences.saveToDisk();
        }
        var x = F(l);
        if (x != null) {
            if (x instanceof Window) {
                x.center();
                x.show();
            } else {
                x.layout.layout(true);
            }
            if (y) {
                j();
            }
            if (e != null && b == false) {
                alert("WARNING: Due to an After Effects bug in Windows CC2014 and later, using a high-res display may cause dropdown menus to display incorrectly. If you encounter this, click [ ? ] and check the 'Fix dropdown menus...' pref then relaunch " + z);
                app.settings.saveSetting(P, "ptScripts_DropDownFix", e);
                app.preferences.saveToDisk();
            }
        }
    }
}
pt_AddMarkers(this);