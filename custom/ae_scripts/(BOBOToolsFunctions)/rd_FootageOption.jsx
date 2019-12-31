{
	function rd_CompSetter(thisObj) {
		// Globals

		var rd_CompSetterData = new Object(); // Store globals in an object
		rd_CompSetterData.scriptName = "rd: 素材重设";
		rd_CompSetterData.scriptTitle = rd_CompSetterData.scriptName + " v2.7";
		rd_CompSetterData.strImgFPS = {
			en: "素材帧率:"
		};
		rd_CompSetterData.strImgFPSCaption = {
			en: "帧率"
		};
		rd_CompSetterData.strApply = {
			"en": "应用"
		};
		function rd_CompSetter_localize(strVar) {
			return strVar["en"];
		}
		function rd_CompSetter_buildUI(thisObj) {
			var pal = (thisObj instanceof Panel) ? thisObj : new Window("palette", rd_CompSetterData.scriptName, undefined, {
				resizeable: true
			});

			if (pal != null) {
				var res =
					"group { \
					orientation:'column', alignment:['fill','top'], \
                       imgfps: Group { \
						alignment:['fill','top'], alignChildren:['left','center'], \
						opt: Checkbox { text:'" + rd_CompSetter_localize(rd_CompSetterData.strImgFPS) + "', value:true }, \
						fld: EditText { text:'15', characters:7 }, \
						uom: StaticText { text:'" + rd_CompSetter_localize(rd_CompSetterData.strImgFPSCaption) + "' }, \
					}, \
					cmds: Group { \
						alignment:['right','top'], \
						applyBtn: Button { text:'" + rd_CompSetter_localize(rd_CompSetterData.strApply) + "' }, \
					}, \
				}";
				pal.grp = pal.add(res);
				// Workaround to ensure the edittext text color is black, even at darker UI brightness levels
				var winGfx = pal.graphics;
				var darkColorBrush = winGfx.newPen(winGfx.BrushType.SOLID_COLOR, [0, 0, 0], 1);

				pal.grp.imgfps.fld.graphics.foregroundColor = darkColorBrush;

				pal.layout.layout(true);
				pal.grp.minimumSize = pal.grp.size;
				pal.layout.resize();
				pal.onResizing = pal.onResize = function () {
					this.layout.resize();
				}

				pal.grp.imgfps.fld.onChange = function () {
					var enteredValue = this.text;

					if (isNaN(enteredValue) || (enteredValue <= 1))
						this.text = "1";
					else if (enteredValue > 99)
						this.text = "99";
				}
				pal.grp.cmds.applyBtn.onClick = rd_CompSetter_doCompSetter;
			}

			return pal;
		}

		function rd_CompSetter_compSetRecursively(imgfps) {
			var layer;
			var oldCompDur = comp.duration;
			// 改变所有图层_
			if (imgfps != -1)
				comp.imgframeRate = imgfps;
		}

		function rd_CompSetter_doCompSetter() {
			// Check that a project exists
			if (app.project == null) {
				alert(rd_CompSetter_localize(rd_CompSetterData.strErrNoProj), rd_CompSetterData.scriptName);
				return;
			}

              var proj = app.project;
			// Do the work
			app.beginUndoGroup(rd_CompSetterData.scriptName);
            
                
			for (var i = 0; i < proj.selection.length; i++) {  
				var comp = proj.selection[i];           
                  var newIMGFPS =parseFloat(this.parent.parent.imgfps.fld.text);-1 
                  comp.mainSource.conformFrameRate = newIMGFPS; 
			}
			app.endUndoGroup();
		}

		if (parseFloat(app.version) < 8.0)
			alert(rd_CompSetter_localize(rd_CompSetterData.strMinAE80), rd_CompSetterData.scriptName);
		else {
			// Build and show the console's floating palette
			var rdcsePal = rd_CompSetter_buildUI(thisObj);
			if (rdcsePal != null) {
				if (app.settings.haveSetting("redefinery", "rd_CompSetter_ImgfpsOpt"))
					rdcsePal.grp.imgfps.opt.value = (app.settings.getSetting("redefinery", "rd_CompSetter_ImgfpsOpt") == "false") ? false : true;
				if (app.settings.haveSetting("redefinery", "rd_CompSetter_Imgfps"))
					rdcsePal.grp.imgfps.fld.text = parseFloat(app.settings.getSetting("redefinery", "rd_CompSetter_Imgfps")).toString();
				rdcsePal.grp.imgfps.fld.enabled = rdcsePal.grp.imgfps.opt.value;

				rdcsePal.onClose = function () {

					app.settings.saveSetting("redefinery", "rd_CompSetter_imgfpsOpt", this.grp.imgfps.opt.value);
					app.settings.saveSetting("redefinery", "rd_CompSetter_imgfps", this.grp.imgfps.fld.text);
				}

				if (rdcsePal instanceof Window) {
					// Show the palette
					rdcsePal.center();
					rdcsePal.show();
				} else
					rdcsePal.layout.layout(true);
			}
		}
	}


	rd_CompSetter(this);
}