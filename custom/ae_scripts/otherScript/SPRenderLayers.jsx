// rd_RenderLayers.jsx
// Copyright (c) 2006-2013 redefinery (Jeffrey R. Almasol). All rights reserved.
// check it: www.redefinery.com
// 
// Name: rd_RenderLayers
// Version: 3.1
// 
// Description:
// This script renders each of the selected layers separately. You might
// find this script useful if layers represent different versions of an
// effect or different parts of an effect that you want to render as
// separate "passes" for flexibility in how they get composited.
// 
// Rendering uses existing render settings and output module template, so
// be sure to create them beforehand. When you run this script, you can
// select the templates to use; select the range of frames for each selected
// layer to render; control if unselected, adjustment, active camera, and
// light layers should be rendered as well; and define the name for each 
// rendered output. Each rendered layer will generate separate "render 
// finished" sounds.
// 
// The Output Name Template can be defined with the same properties
// available in the File Name Templates dialog box, with the following
// additions:
//    [layerName] - Current layer's name
//    [layerNumber] - Current layer's index number
// 
// Note: If you select an output template that uses a single-image
// format (such as Photoshop), be sure to include the [#####] property
// in the Output Name Template.
//
// Note: If the layer is completely outside of the composition time range,
// the layer will not be rendered. However, if you select a range of 
// Work Area and the layer is outside of the composition's work area, the
// layer will still be rendered.
// 
// The Queue Only option is available only when Layer Range to Render 
// is set to Layer In/Out Range or Work Area. Also, this mode creates a 
// temp folder (in the same location as the comp) with " - Temp Comps" 
// in the name. The comp is duplicated (with incremented comp name) 
// to retain the state of each selected layer.
// 
// Note: This version of the script requires After Effects CS5 
// or later. It can be used as a dockable panel by placing the 
// script in a ScriptUI Panels subfolder of the Scripts folder, 
// and then choosing this script from the Window menu.
// 
// Enhancements requested by Gary Jaeger and James Tobias.
// 
// Legal stuff:
// This script is provided "as is," without warranty of any kind, expressed
// or implied. In no event shall the author be held liable for any damages
// arising in any way from the use of this script.
// 
// In other words, I'm just trying to share knowledge with and help out my
// fellow AE script heads, so don't blame me if my code doesn't rate. :-)




// rd_RenderLayers()
// 
// Description:
// This function contains the main logic for this script.
// 
// Parameters:
// thisObj - "this" object.
// 
// Returns:
// Nothing.
//
(function rd_RenderLayers(thisObj) {
	// Globals

	var rd_RenderLayersData = new Object(); // Store globals in an object
	rd_RenderLayersData.scriptName = "rd: Render Layers";
	rd_RenderLayersData.scriptTitle = rd_RenderLayersData.scriptName + " v3.1";

	rd_RenderLayersData.strLayerRange = {
		en: "Layer Range to Render:"
	};
	rd_RenderLayersData.strLayerRangeOpts = {
		en: '["Work Area", "Entire Composition", "Layer In/Out Range"]'
	};
	rd_RenderLayersData.strKeepInRender = {
		en: "Keep in Render:"
	};
	rd_RenderLayersData.strKeepInUnsel = {
		en: "Unselected layers"
	};
	rd_RenderLayersData.strKeepInAdjust = {
		en: "Adjustment layers"
	};
	rd_RenderLayersData.strKeepInActiveCam = {
		en: "Active Camera"
	};
	rd_RenderLayersData.strKeepInLights = {
		en: "Lights"
	};
	rd_RenderLayersData.strRSTemplate = {
		en: "Render Settings Template:"
	};
	rd_RenderLayersData.strOMTemplate = {
		en: "Output Module Template:"
	};
	rd_RenderLayersData.strRefresh = {
		en: "Refresh"
	};
	rd_RenderLayersData.strOutFolder = {
		en: "Output Folder:"
	};
	rd_RenderLayersData.strOutFolderBrowse = {
		en: "Browse..."
	};
	rd_RenderLayersData.strOutName = {
		en: "Output Name Template:"
	}
	rd_RenderLayersData.strQueueOnly = {
		en: "Queue Only"
	};
	rd_RenderLayersData.strRender = {
		en: "Render"
	};
	rd_RenderLayersData.strHelp = {
		en: "?"
	};
	rd_RenderLayersData.strErrNoCompSel = {
		en: "Cannot perform operation. Please select or open a single composition in the Project panel, and try again."
	};
	rd_RenderLayersData.strErrNoLayerSel = {
		en: "Cannot perform operation. Please select at least one layer, and try again."
	};
	rd_RenderLayersData.strMinAE100 = {
		en: "This script requires Adobe After Effects CS5 or later."
	};
	rd_RenderLayersData.strHelpText = {
		en: "Copyright (c) 2006-2013 redefinery (Jeffrey R. Almasol). \n" +
			"All rights reserved.\n" +
			"\n" +
			"This script renders each of the selected layers separately. You might find this script useful if layers represent different versions of an effect or different parts of an effect that you want to render as separate \"passes\" for flexibility in how they get composited.\n" +
			"\n" +
			"Rendering uses existing render settings and output module template, so be sure to create them beforehand. When you run this script, you can select the templates to use; select the range of frames for each selected layer to render; control if unselected, adjustment, active camera, and light layers should be rendered as well; and define the name for each rendered output. Each rendered layer will generate separate \"render finished\" sounds.\n" +
			"\n" +
			"The Output Name Template can be defined with the same properties available in the File Name Templates dialog box, with the following additions:\n" +
			"    [layerName] - Current layer's name\n" +
			"    [layerNumber] - Current layer's index number\n" +
			"\n" +
			"Note: If you select an output template that uses a single-image format (such as Photoshop), be sure to include the [#####] property in the Output Name Template.\n" +
			"\n" +
			"Note: If the layer is completely outside of the composition time range, the layer will not be rendered. However, if you select a range of Work Area and the layer is outside of the composition's work area, the layer will still be rendered.\n" +
			"\n" +
			"The Queue Only option is available only when Layer Range to Layer In/Out Range or Render is set to Work Area. Also, this mode creates a temp folder (in the same location as the comp) with \" - Temp Comps\" in the name. The comp is duplicated (with incremented comp name) to retain the state of each selected layer.\n" +
			"\n" +
			"Note: This version of the script requires After Effects CS5 or later. It can be used as a dockable panel by placing the script in a ScriptUI Panels subfolder of the Scripts folder, and then choosing this script from the Window menu.\n" +
			"\n" +
			"Enhancements requested by Gary Jaeger and James Tobias"
	};




	// rd_RenderLayers_localize()
	// 
	// Description:
	// This function localizes the given string variable based on the current locale.
	// 
	// Parameters:
	//   strVar - The string variable's name.
	// 
	// Returns:
	// String.
	//
	function rd_RenderLayers_localize(strVar) {
		return strVar["en"];
	}




	// rd_RenderLayers_buildUI()
	// 
	// Description:
	// This function builds the user interface.
	// 
	// Parameters:
	// thisObj - Panel object (if script is launched from Window menu); null otherwise.
	// 
	// Returns:
	// Window or Panel object representing the built user interface.
	//
	function rd_RenderLayers_buildUI(thisObj) {
		var pal = (thisObj instanceof Panel) ? thisObj : new Window("palette", rd_RenderLayersData.scriptName, undefined, {
			resizeable: true
		});

		if (pal !== null) {
			var res =
				"group { \
				orientation:'column', alignment:['fill','top'], \
				header: Group { \
					alignment:['fill','top'], \
					title: StaticText { text:'" + rd_RenderLayersData.scriptName + "', alignment:['fill','center'] }, \
					help: Button { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strHelp) + "', maximumSize:[30,20], alignment:['right','center'] }, \
				}, \
				r1: Group { \
					alignment:['fill','top'], \
					layerRange: StaticText { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strLayerRange) + "' }, \
					layerRangeList: DropDownList { properties:{items:" + rd_RenderLayers_localize(rd_RenderLayersData.strLayerRangeOpts) + "}, alignment:['fill','top'], preferredSize:[-1,20] }, \
				}, \
				r2: Group { \
					alignment:['fill','top'], \
					keepInRender: StaticText { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strKeepInRender) + "' }, \
					keepInUnsel: Checkbox { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strKeepInUnsel) + "', value:false }, \
					keepInAdjust: Checkbox { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strKeepInAdjust) + "', value:true }, \
				}, \
				r3: Group { \
					alignment:['fill','top'], \
					keepInActiveCam: Checkbox { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strKeepInActiveCam) + "', value:true }, \
					keepInLights: Checkbox { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strKeepInLights) + "', value:true }, \
				}, \
				r4: Group { \
					alignment:['fill','top'], \
					r4left: Group { \
						orientation:'column', alignment:['fill','center'], \
						r4top: Group { \
							alignment:['fill','top'], \
							rsTpl: StaticText { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strRSTemplate) + "' }, \
							rsTplList: DropDownList { alignment:['fill','top'], alignment:['fill','top'], preferredSize:[-1,20] }, \
						}, \
						r4btm: Group { \
							alignment:['fill','top'], \
							omTpl: StaticText { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strOMTemplate) + "' }, \
							omTplList: DropDownList { alignment:['fill','top'], alignment:['fill','top'], preferredSize:[-1,20] }, \
						}, \
					}, \
					refresh: Button { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strRefresh) + "', alignment:['right','center'], preferredSize:[-1,20] }, \
				}, \
				r5: Group { \
					alignment:['fill','top'], \
					outFolder: StaticText { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strOutFolder) + "' }, \
					outFolderName: EditText { text:'', characters:20, alignment:['fill','top'], preferredSize:[-1,20] }, \
					outFolderBrowse: Button { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strOutFolderBrowse) + "', alignment:['right','top'], preferredSize:[-1,20] }, \
				}, \
				r6: Group { \
					alignment:['fill','top'], \
					outName: StaticText { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strOutName) + "' }, \
					outNameTpl: EditText { text:'[layerName]_[#####]', characters:20, alignment:['fill','top'], preferredSize:[-1,20] }, \
				}, \
				cmds: Group { \
					alignment:['right','top'], \
					queueOnlyBtn: Button { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strQueueOnly) + "', preferredSize:[-1,20] }, \
					renderBtn: Button { text:'" + rd_RenderLayers_localize(rd_RenderLayersData.strRender) + "', preferredSize:[-1,20] }, \
				}, \
			}";
			pal.grp = pal.add(res);

			pal.grp.r1.layerRange.preferredSize.width =
				pal.grp.r2.keepInRender.preferredSize.width =
				pal.grp.r4.r4left.r4btm.omTpl.preferredSize.width =
				pal.grp.r5.outFolder.preferredSize.width =
				pal.grp.r6.outName.preferredSize.width =
				pal.grp.r4.r4left.r4top.rsTpl.preferredSize.width;
			pal.grp.r3.margins.left = pal.grp.r4.r4left.r4top.rsTpl.preferredSize.width + pal.grp.r2.spacing;

			pal.grp.r3.keepInActiveCam.preferredSize.width = pal.grp.r2.keepInUnsel.preferredSize.width;

			pal.grp.r4.r4left.r4btm.margins.top -= 5;
			pal.grp.cmds.margins.top += 5;

			pal.layout.layout(true);
			pal.grp.minimumSize = pal.grp.size;
			pal.layout.resize();
			pal.onResizing = pal.onResize = function () {
				this.layout.resize();
			}

			pal.grp.r1.layerRangeList.selection = 0;
			pal.grp.r1.layerRangeList.onChange = function () {
				// Enable the Queue Only button only if using Work Area
				this.parent.parent.cmds.queueOnlyBtn.enabled = (this.selection.index === 0) || (this.selection.index === 2);
			}

			pal.grp.r4.refresh.onClick = function () {
				rd_RenderLayers_doRefreshTemplates(this.parent.parent.parent);
			}
			pal.grp.r5.outFolderBrowse.onClick = function () {
				var defaultFolder = this.parent.outFolderName.text;
				if ($.os.indexOf("Windows") !== -1) // On Windows, escape backslashes first
					defaultFolder = defaultFolder.replace("\\", "\\\\");

				var folder = Folder.selectDialog("Output To Folder", defaultFolder);
				if (folder !== null)
					this.parent.outFolderName.text = folder.fsName;
			}

			pal.grp.header.help.onClick = function () {
				alert(rd_RenderLayersData.scriptTitle + "\n" + rd_RenderLayers_localize(rd_RenderLayersData.strHelpText), rd_RenderLayersData.scriptName);
			}
			pal.grp.cmds.queueOnlyBtn.onClick = function () {
				rd_RenderLayers_doRenderLayers(this.parent.parent, false);
			}
			pal.grp.cmds.renderBtn.onClick = function () {
				rd_RenderLayers_doRenderLayers(this.parent.parent, true);
			}

			pal.grp.cmds.margins.top += 5;
		}

		return pal;
	}




	// rd_RenderLayers_doRefreshTemplates()
	// 
	// Description:
	// This callback function rescans the render settings and output module templates,
	// updating the user interface.
	// 
	// Parameters:
	//   pal - Window object representing the palette.
	// 
	// Returns:
	// Nothing.
	// 
	function rd_RenderLayers_doRefreshTemplates(pal) {
		var activeComp = app.project.activeItem;

		if ((activeComp === null) || !(activeComp instanceof CompItem)) {
			alert(rd_RenderLayers_localize(rd_RenderLayersData.strErrNoCompSel));
			return;
		}

		pal.grp.r4.r4left.r4top.rsTplList.selection = null;
		pal.grp.r4.r4left.r4top.rsTplList.removeAll();

		pal.grp.r4.r4left.r4btm.omTplList.selection = null;
		pal.grp.r4.r4left.r4btm.omTplList.removeAll();

		// Get the list of render settings and output module templates
		// (Need to add a dummy comp to the render queue to do this)
		var rqi = app.project.renderQueue.items.add(activeComp);
		var om = rqi.outputModule(1); // Assumes at least one output module

		for (var i = 0; i < rqi.templates.length; i++)
			if (rqi.templates[i].indexOf("_HIDDEN") !== 0) // Don't add hidden templates, like for X-Factor
				pal.grp.r4.r4left.r4top.rsTplList.add("item", rqi.templates[i]);
		for (var i = 0; i < om.templates.length; i++)
			if (om.templates[i].indexOf("_HIDDEN") !== 0) // Don't add hidden templates, like for X-Factor
				pal.grp.r4.r4left.r4btm.omTplList.add("item", om.templates[i]);

		if (rqi.templates.length > 0) // Select the first template in the list, if there is at least one
			pal.grp.r4.r4left.r4top.rsTplList.selection = 0;
		if (om.templates.length > 0)
			pal.grp.r4.r4left.r4btm.omTplList.selection = 0;

		rqi.remove(); // Remove the temp render queue item
	}




	// rd_RenderLayers_doRenderLayers()
	// 
	// Description:
	// This callback function performs the main operation of rendering each selected
	// layer.
	// 
	// Parameters:
	//   groupObj - Group object containing the controls in the panel.
	//   doRender - Boolean controlling if we should actually render or just add to the render queue.
	// 
	// Returns:
	// Nothing.
	//
	function rd_RenderLayers_doRenderLayers(groupObj, doRender) {
		var layerRange = groupObj.r1.layerRangeList.selection.index;
		var keepUnselLayers = groupObj.r2.keepInUnsel.value;
		var keepAdjLayers = groupObj.r2.keepInAdjust.value;
		var keepActiveCam = groupObj.r3.keepInActiveCam.value;
		var keepLights = groupObj.r3.keepInLights.value;
		var rsTpl = groupObj.r4.r4left.r4top.rsTplList.selection;
		var omTpl = groupObj.r4.r4left.r4btm.omTplList.selection;
		var outFolder = groupObj.r5.outFolderName.text;
		var outName = groupObj.r6.outNameTpl.text;

		// Encapsulate all operations into a single undo event
		app.beginUndoGroup(rd_RenderLayersData.scriptName);

		var comp = app.project.activeItem;

		// Confirm that we still have selected layers in the current comp
		if ((comp === null) || !(comp instanceof CompItem)) {
			alert(rd_RenderLayers_localize(rd_RenderLayersData.strErrNoCompSel));
			return;
		} else if (comp.selectedLayers.length === 0) {
			alert(rd_RenderLayers_localize(rd_RenderLayersData.strErrNoLayerSel));
			return;
		}

		// Remember the on/off/selected states of the layers in the comp
		var layerStates = new Array();
		var selectedLayerIndices = new Array();
		var layer, state, layerIndex;

		for (var i = 1; i <= comp.numLayers; i++) {
			layer = comp.layer(i);
			state = "";

			if (layer.hasVideo && layer.enabled)
				state += "v";
			if (layer.hasAudio && layer.audioEnabled)
				state += "a";
			if ((layer.property("zoom") !== null) && layer.enabled) // Camera layers (c = visible)
				state += "c";
			if ((layer.property("intensity") !== null) && layer.enabled) // Light layers (l = visible)
				state += "l";
			if (layer.adjustmentLayer && layer.enabled) // Adjustment layers (j = visible)
				state += "j";
			if (layer.selected) {
				state += "s";
				selectedLayerIndices[selectedLayerIndices.length] = layer.index;
			}

			layerStates[layerStates.length] = state;
		}

		// If using Queue Only, save the current state of the comp as a temp so that the RQ item represents the selection
		if (!doRender)
			var queueOnlyFolder = comp.parentFolder.items.addFolder(comp.name + " - Temp Comps"); // Create in same folder as comp

		// Turn off any unselected layers, if not needing them for the render
		var noPrevCams = true; // Switch to false once we encounter the first (active) camera

		if (!keepUnselLayers) {
			for (var i = 0; i < layerStates.length; i++)
				if (layerStates[i].indexOf("s") === -1) // Check if not selected
			{
				layer = comp.layer(i + 1);

				// Skip turning off the active camera, lights, or adjustment layers, if enabled and requested to do so
				if ((layer.property("zoom") !== null) && layer.enabled) {
					if (keepActiveCam && noPrevCams)
						continue;

					noPrevCams = false; // Keep track of topmost cam
				} else if ((layer.property("intensity") !== null) && layer.enabled && keepLights)
					continue;
				else if (layer.adjustmentLayer && layer.enabled && keepAdjLayers)
					continue;

				layer.enabled = false;
				layer.audioEnabled = false;
			}
		}

		// Turn off all selected layers (in preparation for the per-layer rendering to come)
		for (var i = 0; i < selectedLayerIndices.length; i++) {
			comp.layer(selectedLayerIndices[i]).enabled = false;
			comp.layer(selectedLayerIndices[i]).audioEnabled = false;
		}

		// Remember the states of all renderable render queue items; turning off any that are to render
		var rq = app.project.renderQueue;
		var rqiStates = new Array();

		for (var i = 1; i <= rq.numItems; i++)
			if (rq.item(i).render && (rq.item(i).status === RQItemStatus.QUEUED)) {
				rqiStates[rqiStates.length] = i;
				rq.item(i).render = false;
			}

		// Remember the current work area, in case it gets reset during rendering
		var workAreaStart = comp.workAreaStart;
		var workAreaDuration = comp.workAreaDuration;
		var workAreaIsSingleFrame = (comp.workAreaDuration === comp.frameDuration);

		// Set the work area to the full comp (if needed)
		if (layerRange === 1) // Entire Composition
		{
			comp.workAreaStart = 0;
			comp.workAreaDuration = comp.duration - 0.001; // Seems to need some slop to avoid workAreaDuration range errors...odd
		}

		// Process each selected layer
		var rqi, om, outFName;
		var rangeIn, rangeOut;

		for (var i = 0; i < selectedLayerIndices.length; i++) {
			layerIndex = selectedLayerIndices[i];
			layer = comp.layer(layerIndex);

			// If layer is out of range of the comp, skip it
			if (layer.stretch > 0) {
				if ((layer.outPoint < 0) || (layer.inPoint > comp.duration))
					continue;
			} else {
				if ((layer.inPoint < 0) || (layer.outPoint > comp.duration))
					continue;
			}

			// Enable the current layer
			if (layerStates[layerIndex - 1].indexOf("v") !== -1)
				layer.enabled = true;
			if (layerStates[layerIndex - 1].indexOf("a") !== -1)
				layer.audioEnabled = true;

			// If using Queue Only, save the current state of the comp as a temp so that the RQ item represents the selection
			if (!doRender) {
				var compQueued = queueOnlyComp = comp.duplicate();
				queueOnlyComp.parentFolder = queueOnlyFolder; // Move duped comp into temp folder
			} else {
				var compQueued = comp;
			}
			// Add comp to the render queue
			rqi = rq.items.add(compQueued);

			// Set the comp work area to the layer range (if needed)
			if (layerRange === 2) // Layer In/Out Range
			{
				if (layer.stretch > 0) {
					rangeIn = (layer.inPoint < 0) ? 0 : layer.inPoint;
					rangeOut = (layer.outPoint > compQueued.duration) ? compQueued.duration : layer.outPoint;
				} else {
					rangeIn = (layer.outPoint < 0) ? 0 : layer.outPoint;
					rangeOut = (layer.inPoint > compQueued.duration) ? compQueued.duration : layer.inPoint;
				}

				compQueued.workAreaStart = 0; // Set to min size first, then resize -- to avoid problems setting range
				compQueued.workAreaDuration = compQueued.frameDuration;
				/*
				$.writeln(rangeIn+" to "+rangeOut+" (dur: "+(rangeOut-rangeIn)+")");
				$.writeln("  comp: 0 to "+comp.duration);
				$.writeln("  workAreaStart="+comp.workAreaStart+", workAreaDuration="+comp.workAreaDuration+", frameDuration="+comp.frameDuration);
				$.writeln("  workAreaDiff-rangeDiff="+(workAreaDuration-(rangeOut-rangeIn)));
				*/

				compQueued.workAreaStart = rangeIn;
				if ((rangeOut - rangeIn - compQueued.frameDuration) > 0.0001) // special-case layer in/out range being one frame to avoid precision problems
					compQueued.workAreaDuration = parseInt((rangeOut - rangeIn) * 1000) / 1000;
			}
			//Set folder



			// Set templates and output file name
			//输出模版和文件名
			rqi.applyTemplate(rsTpl);
			om = rqi.outputModule(1);
			om.applyTemplate(omTpl);

			outFName = outName;
			outFName = outFName.replace("[layerName]", layer.name);
			outFName = outFName.replace("[layerNumber]", layer.index);
			// outFName1=
			//输出文件夹设置 层名/南
			var sequenceFolderPath = new Folder(outFolder.toString() + "/" + layer.name + "/" + "南");
			sequenceFolderPath.create();
			//var sequencePath =new File(outFolder+"/"+ outFName);
			//输出文件设置 层名/南/outFName
			om.file = new File(outFolder.toString() + "/" + layer.name + "/" + "南" + "/" + outFName);

			// Render (if actually clicked Render)
			if (doRender)
				app.project.renderQueue.render();

			// Remove render queue item
			//rqi.remove();

			// Disable the current layer
			layer.enabled = false;
			layer.audioEnabled = false;
		}

		// Restore the work area (if modified)
		if (layerRange !== 0) // Entire Composition or Layer In/Out Range
		{
			comp.workAreaStart = 0; // Set to max size first, then shrink down -- to avoid problems setting range
			//			comp.workAreaDuration = parseInt(comp.frameDuration * 1000) / 1000;

			comp.workAreaStart = workAreaStart;
			if (!workAreaIsSingleFrame) // Avoid setting to a single frame -- seems to be sensitive to setting to a single frame duration
				comp.workAreaDuration = workAreaDuration;
		}

		// Restore any forceably unqueued render queue items
		for (var i = 0; i < rqiStates.length; i++)
			rq.item(rqiStates[i]).render = true;

		// Restore any selected layers
		for (var i = 0; i < selectedLayerIndices.length; i++) {
			layerIndex = selectedLayerIndices[i];
			if (layerStates[layerIndex - 1].indexOf("v") !== -1)
				comp.layer(layerIndex).enabled = true;
			if (layerStates[layerIndex - 1].indexOf("a") !== -1)
				comp.layer(layerIndex).audioEnabled = true;
		}

		// Restore any unselected layers, if previously turned off
		if (!keepUnselLayers) {
			for (var i = 0; i < layerStates.length; i++)
				if (layerStates[i].indexOf("s") === -1) // Check if not selected
			{
				layer = comp.layer(i + 1);

				if ((layerStates[i].indexOf("v") !== -1) || (layerStates[i].indexOf("c") !== -1) || (layerStates[i].indexOf("l") !== -1) || (layerStates[i].indexOf("j") !== -1))
					layer.enabled = true;
				if (layerStates[i].indexOf("a") !== -1)
					layer.audioEnabled = true;
			}
		}

		app.endUndoGroup();

		// Purge the undo cache to work around an issue with changing a layer or undoing after a render
		app.purge(PurgeTarget.UNDO_CACHES);
	}




	// main code:
	//

	// Prerequisites check
	if (parseFloat(app.version) < 10.0)
		alert(rd_RenderLayers_localize(rd_RenderLayersData.strMinAE100), rd_RenderLayersData.scriptName);
	else {
		var activeComp = app.project.activeItem;

		// Don't show the palette if no comp is active
		if ((activeComp === null) || !(activeComp instanceof CompItem))
			alert(rd_RenderLayers_localize(rd_RenderLayersData.strErrNoCompSel));
		else if (activeComp.selectedLayers.length === 0)
			alert(rd_RenderLayers_localize(rd_RenderLayersData.strErrNoLayerSel));
		else {
			// Build and show the palette
			var rdrlPal = rd_RenderLayers_buildUI(thisObj);
			if (rdrlPal !== null) {
				// Get the list of render settings and output module templates
				rd_RenderLayers_doRefreshTemplates(rdrlPal);

				if (rdrlPal instanceof Window) {
					// Show the palette
					rdrlPal.center();
					rdrlPal.show();
				} else
					rdrlPal.layout.layout(true);
			}
		}
	}
})(this);