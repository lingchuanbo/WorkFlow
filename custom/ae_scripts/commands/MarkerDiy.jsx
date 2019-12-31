(function rd_CompSetter(thisObj) {
    var rd_CompSetterData = [];
    rd_CompSetterData.scriptName = "自定义分布标记 by BoBO";
    rd_CompSetterData.scriptTitle = rd_CompSetterData.scriptName + " v1.0";
    rd_CompSetterData.strKey = {
        en: "几帧:"
    };
    rd_CompSetterData.strKeyCaption = {
        en: ""
    };
    rd_CompSetterData.strMarker = {
        en: "标记:"
    };
    rd_CompSetterData.strMarkerCaption = {
        en: ""
    };
    rd_CompSetterData.strApply = {
        en: "应用"
    };

    function rd_CompSetter_localize(strVar) {
        return strVar.en;
    }

    function rd_CompSetter_buildUI(thisObj) {
        var pal = (thisObj instanceof Panel ? thisObj : new Window("palette", rd_CompSetterData.scriptName, undefined, {
            resizeable: true
        }));
        if (pal !== null) {
            res = "group { \n\t\t\t\torientation:'column', alignment:['fill','top'],\n\t\t\t\tfps: Group {\n\t\t\t\t\talignment:['fill','top'], alignChildren:['left','center'], \n\t\t\t\t\topt: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strKey) + "', value:false }, \n\t\t\t\t\tfld: EditText { text:'15', characters:7, preferredSize:[300,20] }, \n\t\t\t\t\tuom: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strKeyCaption) + "' }, \n\t\t\t\t}, \n\t\t\t\tloop: Group { \n\t\t\t\t\talignment:['fill','top'], alignChildren:['left','center'], \n\t\t\t\t\topt: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strMarker) + "', value:false }, \n\t\t\t\t\tfld: EditText { text:'15', characters:7, preferredSize:[300,20] }, \n\t\t\t\t\tuom: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strMarkerCaption) + "' }, \n\t\t\t\t}, \n\t\t\t\tsep3: Group { \n\t\t\t\t\torientation:'row', alignment:['fill','top'], \n\t\t\t\t\trule: Panel { \n\t\t\t\t\t\theight: 2, alignment:['fill','center'], \n\t\t\t\t\t}, \n\t\t\t\t}, \n\t\t\t\tcmds: Group { \n\t\t\t\t\talignment:['right','top'], \n\t\t\t\t\tapplyBtn: Button { text:'" + rd_CompSetter_localize(rd_CompSetterData.strApply) + "', preferredSize:[-1,20] }, \n\t\t\t\t}, \n\t\t\t}";
            pal.grp = pal.add(res);
            //pal.grp.fps.opt.preferredSize.width = pal.grp.loop.opt.preferredSize.width = pal.layout.layout(true);
            pal.grp.fps.opt.onClick = function () {
                var state = this.value;
                this.parent.fld.enabled = this.parent.uom.enabled = state;
                if (state) {
                    this.parent.fld.active = false
                }
            };
            pal.grp.fps.fld.onChange = function () {
                // 筛选为数字
                // var enteredValue = this.text;
                // if (isNaN(enteredValue) || enteredValue <= 1) {
                //     this.text = "1"
                // } else {
                //     if (enteredValue > 10000) {
                //         this.text = "10000"
                //     }
                // }
            };
            pal.grp.loop.opt.onClick = function () {
                var state = this.value;
                this.parent.fld.enabled = this.parent.uom.enabled = state;
                if (state) {
                    this.parent.fld.active = true
                }
            };
            pal.grp.loop.fld.onChange = function () {
                // var enteredValue = this.text;
                // if (isNaN(enteredValue) || enteredValue <= 1) {
                //     this.text = "1"
                // } else {
                //     if (enteredValue > 99) {
                //         this.text = "99"
                //     }
                // }
            };
            pal.grp.cmds.applyBtn.onClick = rd_CompSetter_doCompSetter_Layer;
        }
        return pal;
    }

    function rd_CompSetter_doCompSetter_Layer() {

        var actComp = app.project.activeItem;
        var selLayers = actComp.selectedLayers;
        var myLayer;

        var iputTime = this.parent.parent.fps.fld.text; //获取输入帧
        var iputMarker = this.parent.parent.loop.fld.text;//获取输入标记


        iputTimes = iputTime.split(",");//切割数组
        iputMarkers = iputMarker.split(","); //切割数组


        for (i = k1 = 0, ref = selLayers.length; k1 < ref; i = k1 += 1) {
            for (var t = 0, len = iputTimes.length = iputMarkers.length; t < len; t++) {
                addedMarker = new MarkerValue(iputMarkers[t]);
                var fps = 1 / actComp.frameDuration; //转化时间到帧
                (selLayers[i]).property("Marker").setValueAtTime(iputTimes[t] / fps, addedMarker);//执行
            }
        }
    }

    if ((app.version) < 10) {
        alert(rd_CompSetter_localize(rd_CompSetterData.strMinAE100), rd_CompSetterData.scriptName)
    } else {
         rdcsePal = rd_CompSetter_buildUI(thisObj);
        if (rdcsePal !== null) {
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_fpsOpt")) {
                rdcsePal.grp.fps.opt.value = (app.settings.getSetting("redefinery", "rd_CompSetter_fpsOpt"))
            }
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_fps")) {
                rdcsePal.grp.fps.fld.text = (app.settings.getSetting("redefinery", "rd_CompSetter_fps")).toString()
            }
            rdcsePal.grp.fps.fld.enabled = rdcsePal.grp.fps.opt.value;
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_loopOpt")) {
                rdcsePal.grp.loop.opt.value = (app.settings.getSetting("redefinery", "rd_CompSetter_loopOpt") )
            }
            if (app.settings.haveSetting("redefinery", "rd_CompSetter_loop")) {
                rdcsePal.grp.loop.fld.text = (app.settings.getSetting("redefinery", "rd_CompSetter_loop")).toString()
            }
            rdcsePal.grp.loop.fld.enabled = rdcsePal.grp.loop.opt.value;
            rdcsePal.onClose = function () {
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
//=== "false" ? false : true