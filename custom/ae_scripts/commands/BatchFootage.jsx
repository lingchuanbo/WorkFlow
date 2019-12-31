(function rd_CompSetter(thisObj) {
    var rd_CompSetterData = [];
    rd_CompSetterData.scriptName = "素材批处理 v1.0 By BoBO";
    rd_CompSetterData.scriptTitle = rd_CompSetterData.scriptName + " v1.0";
    rd_CompSetterData.strFPS = {
        en: "帧率:"
    };
    rd_CompSetterData.strFPSCaption = {
        en: "fps"
    };
    rd_CompSetterData.strLoop = {
        en: "循环:"
    };
    rd_CompSetterData.strLoopCaption = {
        en: "次"
    };
    rd_CompSetterData.strApply = {
        en: "应用"
    };
    function rd_CompSetter_localize(strVar) {
        return strVar.en;
    }
    function rd_CompSetter_buildUI(thisObj) {
        var pal = (thisObj instanceof Panel ? thisObj: new Window("palette", rd_CompSetterData.scriptName, undefined, {
            resizeable: true
        }));
        if (pal !== null) {
            res = "group { \n\t\t\t\torientation:'column', alignment:['fill','top'], \n\t\t\t\tfps: Group { \n\t\t\t\t\talignment:['fill','top'], alignChildren:['left','center'], \n\t\t\t\t\topt: Checkbox { text:'" + rd_CompSetter_localize(rd_CompSetterData.strFPS) + "', value:false }, \n\t\t\t\t\tfld: EditText { text:'15', characters:7, preferredSize:[-1,20] }, \n\t\t\t\t\tuom: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strFPSCaption) + "' }, \n\t\t\t\t}, \n\t\t\t\tloop: Group { \n\t\t\t\t\talignment:['fill','top'], alignChildren:['left','center'], \n\t\t\t\t\topt: Checkbox { text:'" + rd_CompSetter_localize(rd_CompSetterData.strLoop) + "', value:false }, \n\t\t\t\t\tfld: EditText { text:'15', characters:7, preferredSize:[-1,20] }, \n\t\t\t\t\tuom: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strLoopCaption) + "' }, \n\t\t\t\t}, \n\t\t\t\tsep3: Group { \n\t\t\t\t\torientation:'row', alignment:['fill','top'], \n\t\t\t\t\trule: Panel { \n\t\t\t\t\t\theight: 2, alignment:['fill','center'], \n\t\t\t\t\t}, \n\t\t\t\t}, \n\t\t\t\tcmds: Group { \n\t\t\t\t\talignment:['right','top'], \n\t\t\t\t\tapplyBtn: Button { text:'" + rd_CompSetter_localize(rd_CompSetterData.strApply) + "', preferredSize:[-1,20] }, \n\t\t\t\t}, \n\t\t\t}";
            pal.grp = pal.add(res);
            pal.grp.fps.opt.preferredSize.width = pal.grp.loop.opt.preferredSize.width = pal.layout.layout(true);
            pal.grp.fps.opt.onClick = function() {
                var state = this.value;
                this.parent.fld.enabled = this.parent.uom.enabled = state;
                if (state) {
                    this.parent.fld.active = true
                }
            };
            pal.grp.fps.fld.onChange = function() {
                var enteredValue = this.text;
                if (isNaN(enteredValue) || enteredValue <= 1) {
                    this.text = "1"
                } else {
                    if (enteredValue > 99) {
                        this.text = "99"
                    }
                }
            };
            pal.grp.loop.opt.onClick = function() {
                var state = this.value;
                this.parent.fld.enabled = this.parent.uom.enabled = state;
                if (state) {
                    this.parent.fld.active = true
                }
            };
            pal.grp.loop.fld.onChange = function() {
                var enteredValue = this.text;
                if (isNaN(enteredValue) || enteredValue <= 1) {
                    this.text = "1"
                } else {
                    if (enteredValue > 99) {
                        this.text = "99"
                    }
                }
            };
            pal.grp.cmds.applyBtn.onClick = rd_CompSetter_doCompSetter;
        }
        return pal;
    }
    function rd_CompSetter_compSetRecursively(comp, fps, recurse) {
        if (fps !== -1) {
            if (recurse && layer instanceof AVLayer && layer.source !== null && layer.source instanceof CompItem) {
                rd_CompSetter_compSetRecursively(layer.source, fps)
            }
        }
    }
    function rd_CompSetter_doCompSetter() {
        if (app.project === null) {
            alert(rd_CompSetter_localize(rd_CompSetterData.strErrNoProj), rd_CompSetterData.scriptName);
            return;
        }
        proj = app.project.selection;
        app.beginUndoGroup(rd_CompSetterData.scriptName);
        if (app.project.activeItem !== null && app.project.activeItem instanceof CompItem) {
            selComps = [app.project.activeItem];
        } else {
            selComps = proj.selection;
        }
        for (var i = 0; i < proj.length; i += 1) {
            comp = proj[i];
            newFPS = parseFloat(this.parent.parent.fps.fld.text);
            newLoop = parseFloat(this.parent.parent.loop.fld.text);
            comp.mainSource.conformFrameRate = newFPS;
            comp.mainSource.loop = newLoop;
            rd_CompSetter_compSetRecursively(comp, newFPS, newLoop);
        }
        app.endUndoGroup();
    }
    if (parseFloat(app.version) < 10) {
        alert(rd_CompSetter_localize(rd_CompSetterData.strMinAE100), rd_CompSetterData.scriptName)
    } else {
        rdcsePal = rd_CompSetter_buildUI(thisObj);
        if (rdcsePal !== null) {
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_fpsOpt")) {
                rdcsePal.grp.fps.opt.value = (app.settings.getSetting("redefinery", "rd_CompSetter_fpsOpt") === "false" ? false: true)
            }
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_fps")) {
                rdcsePal.grp.fps.fld.text = parseFloat(app.settings.getSetting("redefinery", "rd_CompSetter_fps")).toString()
            }
            rdcsePal.grp.fps.fld.enabled = rdcsePal.grp.fps.opt.value;
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_loopOpt")) {
                rdcsePal.grp.loop.opt.value = (app.settings.getSetting("redefinery", "rd_CompSetter_loopOpt") === "false" ? false: true)
            }
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_loop")) {
                rdcsePal.grp.loop.fld.text = parseFloat(app.settings.getSetting("redefinery", "rd_CompSetter_loop")).toString()
            }
            rdcsePal.grp.loop.fld.enabled = rdcsePal.grp.loop.opt.value;
            rdcsePal.onClose = function() {
                app.settings.saveSetting("redefinery", "rd_CompSetter_fpsOpt", this.grp.fps.opt.value);
                app.settings.saveSetting("redefinery", "rd_CompSetter_fps", this.grp.fps.fld.text);
                app.settings.saveSetting("redefinery", "rd_CompSetter_loopOpt", this.grp.loop.opt.value);
                app.settings.saveSetting("redefinery", "rd_CompSetter_loop", this.grp.loop.fld.text);
            };
            if (rdcsePal instanceof Window) {
                rdcsePal.center();
                rdcsePal.show();
            } else {
                rdcsePal.layout.layout(true)
            }
        }
    }
})(this);