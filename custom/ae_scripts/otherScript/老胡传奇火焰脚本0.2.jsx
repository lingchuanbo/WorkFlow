//老胡传奇火焰配色
//20190703修正素材名字
sel = app.project.selection;
var isSequence = new Array();
   if(sel.length == 0){
       alert("选择素材操作");
    }else{
    compCode_LaoHuFire();
}
function URIToWinPath(path){
     str = path.replace(":\\", "/");
	return str;
}

function compCode_LaoHuFire() {

app.beginUndoGroup(File.decode("%E9%A2%84%E5%90%88%E6%88%90%2011"));

try {
        for(i=0;i<app.project.selection.length;i++){
        isSequence[i] = !sel[i].mainSource.isStill;
         txt = URIToWinPath(sel[i].mainSource.file.toString());//+"\n";
         txtName = URIToWinPath(sel[i].mainSource.file.name.toString());//+"\n";
        //alert(decodeURI(txt));
        var getNewPath = decodeURI(txt);
        var getName = decodeURI(txtName);
       //alert(getName);
}
// CREATE FOLDER HIERARCHY START
	var comps_folder_properties = {"name":"Comps","typeName":"Folder","label":2,"comment":""};
	var comps_folder = findProjectItem(app.project.rootFolder, false, comps_folder_properties);
	if (comps_folder === null) {
		comps_folder = app.project.items.addFolder(comps_folder_properties.name);
		comps_folder.label = comps_folder_properties.label;
	}
	var precomps_folder_properties = {"name":" Precomps","typeName":"Folder","label":2,"comment":""};
	var precomps_folder = findProjectItem(comps_folder, false, precomps_folder_properties);
	if (precomps_folder === null) {
		precomps_folder = app.project.items.addFolder(precomps_folder_properties.name);
		precomps_folder.label = precomps_folder_properties.label;
		precomps_folder.parentFolder = comps_folder;
	}
	var footage_folder_properties = {"name":"Footage","typeName":"Folder","label":2,"comment":""};
	var footage_folder = findProjectItem(app.project.rootFolder, false, footage_folder_properties);
	if (footage_folder === null) {
		footage_folder = app.project.items.addFolder(footage_folder_properties.name);
		footage_folder.label = footage_folder_properties.label;
	}
	var png_folder_properties = {"name":"png","typeName":"Folder","label":2,"comment":""};
	var png_folder = findProjectItem(footage_folder, false, png_folder_properties);
	if (png_folder === null) {
		png_folder = app.project.items.addFolder(png_folder_properties.name);
		png_folder.label = png_folder_properties.label;
		png_folder.parentFolder = footage_folder;
	}
// CREATE FOLDER HIERARCHY END

// CREATE COMPOSITIONS START
	var compcode11_comp_properties = {"name":getName+"火焰效果","typeName":"Composition","label":15,"comment":"","height":700,"width":963,"pixelAspect":1,"bgColor":[0.19607843137255,0.19607843137255,0.19607843137255],"duration":1,"numLayers":1,"frameRate":12};
	var compcode11_comp = app.project.items.addComp(compcode11_comp_properties.name, compcode11_comp_properties.width, compcode11_comp_properties.height, compcode11_comp_properties.pixelAspect, compcode11_comp_properties.duration, compcode11_comp_properties.frameRate);
		compcode11_comp.time = 0.58333333333333;
		compcode11_comp.bgColor = compcode11_comp_properties.bgColor;
		compcode11_comp.shutterPhase = -90;
		compcode11_comp.resolutionFactor = [1, 1];
		compcode11_comp.parentFolder = comps_folder;
	var compcode8_comp_properties = {"name":"预合成 8","typeName":"Composition","label":15,"comment":"","height":700,"width":963,"pixelAspect":1,"bgColor":[0.19607843137255,0.19607843137255,0.19607843137255],"duration":5.08333333333333,"numLayers":3,"frameRate":12};
	var compcode8_comp = findProjectItem(precomps_folder, false, compcode8_comp_properties);
	var compcode8_comp_populate = false;
	if (compcode8_comp === null) {
		compcode8_comp = app.project.items.addComp(compcode8_comp_properties.name, compcode8_comp_properties.width, compcode8_comp_properties.height, compcode8_comp_properties.pixelAspect, compcode8_comp_properties.duration, compcode8_comp_properties.frameRate);
		compcode8_comp.time = 0.58333333333333;
		compcode8_comp.bgColor = compcode8_comp_properties.bgColor;
		compcode8_comp.shutterPhase = -90;
		compcode8_comp.workAreaDuration = 1;
		compcode8_comp.resolutionFactor = [1, 1];
		compcode8_comp.parentFolder = precomps_folder;
		compcode8_comp_populate = true;
	}
	var compcode3_comp_properties = {"name":"预 合成 3","typeName":"Composition","label":15,"comment":"","height":700,"width":963,"pixelAspect":1,"bgColor":[0.19607843137255,0.19607843137255,0.19607843137255],"duration":5.08333333333333,"numLayers":1,"frameRate":12};
	var compcode3_comp = findProjectItem(precomps_folder, false, compcode3_comp_properties);
	var compcode3_comp_populate = false;
	if (compcode3_comp === null) {
		compcode3_comp = app.project.items.addComp(compcode3_comp_properties.name, compcode3_comp_properties.width, compcode3_comp_properties.height, compcode3_comp_properties.pixelAspect, compcode3_comp_properties.duration, compcode3_comp_properties.frameRate);
		compcode3_comp.time = 0.58333333333333;
		compcode3_comp.bgColor = compcode3_comp_properties.bgColor;
		compcode3_comp.shutterPhase = -90;
		compcode3_comp.workAreaDuration = 1;
		compcode3_comp.resolutionFactor = [1, 1];
		compcode3_comp.parentFolder = precomps_folder;
		compcode3_comp_populate = true;
	}
	var compcode7_comp_properties = {"name":"预合成 7","typeName":"Composition","label":15,"comment":"","height":700,"width":963,"pixelAspect":1,"bgColor":[0.19607843137255,0.19607843137255,0.19607843137255],"duration":2.08333333333333,"numLayers":2,"frameRate":12};
	var compcode7_comp = findProjectItem(precomps_folder, false, compcode7_comp_properties);
	var compcode7_comp_populate = false;
	if (compcode7_comp === null) {
		compcode7_comp = app.project.items.addComp(compcode7_comp_properties.name, compcode7_comp_properties.width, compcode7_comp_properties.height, compcode7_comp_properties.pixelAspect, compcode7_comp_properties.duration, compcode7_comp_properties.frameRate);
		compcode7_comp.time = 0.58333333333333;
		compcode7_comp.bgColor = compcode7_comp_properties.bgColor;
		compcode7_comp.shutterPhase = -90;
		compcode7_comp.workAreaDuration = 1;
		compcode7_comp.resolutionFactor = [1, 1];
		compcode7_comp.parentFolder = precomps_folder;
		compcode7_comp_populate = true;
	}
// CREATE COMPOSITIONS END

// IMPORT FOOTAGE ITEMS START

	var png_footage_properties = {"name":getName,"typeName":"Footage","label":3,"comment":"","mainSource":{"file":{"fullName":getNewPath}}};
	var png_footage = findProjectItem(png_folder, false, png_footage_properties);

	if (png_footage === null) {
		var png_importOptions = new ImportOptions(new File(png_footage_properties.mainSource.file.fullName));

		png_importOptions.sequence = true;
		png_footage = app.project.importFile(png_importOptions);
		png_footage.name = png_footage_properties.name;
		png_footage.label = png_footage_properties.label;
		png_footage.mainSource.conformFrameRate = 23.9759979248047;
		png_footage.mainSource.fieldSeparationType = FieldSeparationType.OFF;
		png_footage.parentFolder = png_folder;
		png_footage.selected = false;
	}
// IMPORT FOOTAGE ITEMS END

// Working with comp "预合成 11", varName "compcode11_comp";
	compcode11_comp.openInViewer();
	// Add existing composition "预合成 8", varName "compcode8_comp";
	var compcode8 = compcode11_comp.layers.add(compcode8_comp);
		compcode8.outPoint = 5.0333251953125;
		compcode8.blendingMode = BlendingMode.ADD;
		compcode8.moveToEnd();
		if (compcode8.property("ADBE Effect Parade").canAddProperty("S_Glow")) {
			compcode8.property("ADBE Effect Parade").addProperty("S_Glow");
		} else {
			return alert("Cannot apply \"S_Glow\" (S_Glow) effect to layer \"" + compcode8.name + "\" because you don't have this effect installed on your system.");
		}
		compcode8.property("ADBE Effect Parade").property(1).name = "S_Glow";
		compcode8.property("ADBE Effect Parade").property(1).enabled = false;
		compcode8.property("ADBE Effect Parade").property(1).property("S_Glow-0050").setValue(1);
		compcode8.property("ADBE Effect Parade").property(1).property("S_Glow-0051").setValue([1,0.32567474246025,0.09019607305527,1]);
		compcode8.property("ADBE Effect Parade").property(1).property("S_Glow-0052").setValue(0);
		compcode8.property("ADBE Effect Parade").property(1).property("S_Glow-0054").setValue(23);
		compcode8.property("ADBE Effect Parade").property(1).property("S_Glow-0058").setValue(1);
		compcode8.property("ADBE Effect Parade").property(1).property("S_Glow-0059").setValue(1);
		compcode8.property("ADBE Effect Parade").addProperty("ADBE Sharpen");
		compcode8.property("ADBE Effect Parade").property(2).name = "Sharpen";
		compcode8.property("ADBE Effect Parade").property(2).enabled = false;
		compcode8.property("ADBE Effect Parade").property(2).property("ADBE Sharpen-0001").setValue(26);
		if (compcode8.property("ADBE Effect Parade").canAddProperty("S_Glow")) {
			compcode8.property("ADBE Effect Parade").addProperty("S_Glow");
		} else {
			return alert("Cannot apply \"S_Glow 2\" (S_Glow) effect to layer \"" + compcode8.name + "\" because you don't have this effect installed on your system.");
		}
		compcode8.property("ADBE Effect Parade").property(3).name = "S_Glow 2";
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0050").setValue(1);
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0051").setValue([1,0.39778545498848,0.10196077823639,1]);
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0052").setValue(0);
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0054").setValue(0);
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0058").setValue(1);
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0059").setValue(1);
		compcode8.property("ADBE Effect Parade").property(3).property("S_Glow-0102").setValue(1);
		if (compcode8.property("ADBE Effect Parade").canAddProperty("S_Glow")) {
			compcode8.property("ADBE Effect Parade").addProperty("S_Glow");
		} else {
			return alert("Cannot apply \"S_Glow 3\" (S_Glow) effect to layer \"" + compcode8.name + "\" because you don't have this effect installed on your system.");
		}
		compcode8.property("ADBE Effect Parade").property(4).name = "S_Glow 3";
		compcode8.property("ADBE Effect Parade").property(4).property("S_Glow-0050").setValue(1);
		compcode8.property("ADBE Effect Parade").property(4).property("S_Glow-0054").setValue(12);
		compcode8.property("ADBE Effect Parade").property(4).property("S_Glow-0058").setValue(1);
		compcode8.property("ADBE Effect Parade").property(4).property("S_Glow-0059").setValue(1);
		compcode8.property("ADBE Effect Parade").property(4).property("S_Glow-0102").setValue(1);
		if (compcode8.property("ADBE Effect Parade").canAddProperty("S_Glow")) {
			compcode8.property("ADBE Effect Parade").addProperty("S_Glow");
		} else {
			return alert("Cannot apply \"S_Glow 4\" (S_Glow) effect to layer \"" + compcode8.name + "\" because you don't have this effect installed on your system.");
		}
		compcode8.property("ADBE Effect Parade").property(5).name = "S_Glow 4";
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0050").setValue(0.8);
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0051").setValue([1,0.45647060871124,0.09411764144897,1]);
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0052").setValue(0);
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0054").setValue(44);
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0058").setValue(1);
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0059").setValue(1);
		compcode8.property("ADBE Effect Parade").property(5).property("S_Glow-0102").setValue(1);
		compcode8.property("ADBE Effect Parade").addProperty("ADBE Sharpen");
		compcode8.property("ADBE Effect Parade").property(6).name = File.decode("%E9%94%90%E5%8C%96%202");
		compcode8.property("ADBE Effect Parade").property(6).property("ADBE Sharpen-0001").setValue(30);
		compcode8.property("ADBE Transform Group").property("ADBE Position").setValue([467.5,358,0]);
		compcode8.selected = false;
// Working with comp "预合成 8", varName "compcode8_comp";
if (compcode8_comp_populate === true) {
	// Add existing composition "预 合成 3", varName "compcode3_comp";
	var compcode3 = compcode8_comp.layers.add(compcode3_comp);
		compcode3.outPoint = 5.0333251953125;
		compcode3.blendingMode = BlendingMode.ADD;
		compcode3.moveToEnd();
		if (compcode3.property("ADBE Effect Parade").canAddProperty("cy Image Wipe")) {
			compcode3.property("ADBE Effect Parade").addProperty("cy Image Wipe");
		} else {
			return alert("Cannot apply \"FEC Image Wipe\" (cy Image Wipe) effect to layer \"" + compcode3.name + "\" because you don't have this effect installed on your system.");
		}
		compcode3.property("ADBE Effect Parade").property(1).name = "FEC Image Wipe";
		compcode3.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0001").setValue(0.52);
		compcode3.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0002").setValue(0.36000610351563);
		compcode3.property("ADBE Effect Parade").addProperty("ADBE Tint");
		compcode3.property("ADBE Effect Parade").property(2).name = "Tint";
		compcode3.property("ADBE Effect Parade").property(2).property("ADBE Tint-0001").setValue([0.65490198135376,0.0590695887804,0.0590695887804,1]);
		compcode3.property("ADBE Effect Parade").property(2).property("ADBE Tint-0002").setValue([0.65490198135376,0.09245675802231,0,1]);
		if (compcode3.property("ADBE Effect Parade").canAddProperty("S_MathOps")) {
			compcode3.property("ADBE Effect Parade").addProperty("S_MathOps");
		} else {
			return alert("Cannot apply \"S_MathOps\" (S_MathOps) effect to layer \"" + compcode3.name + "\" because you don't have this effect installed on your system.");
		}
		compcode3.property("ADBE Effect Parade").property(3).name = "S_MathOps";
		compcode3.property("ADBE Effect Parade").property(3).property("S_MathOps-0051").setValue(1.47);
		compcode3.property("ADBE Effect Parade").addProperty("ADBE Glo2");
		compcode3.property("ADBE Effect Parade").property(4).name = "Glow";
		compcode3.selected = false;
	// Add existing composition "预 合成 3", varName "compcode3_comp";
	var compcode4 = compcode8_comp.layers.add(compcode3_comp);
		compcode4.outPoint = 5.0333251953125;
		compcode4.blendingMode = BlendingMode.ADD;
		compcode4.moveToEnd();
		if (compcode4.property("ADBE Effect Parade").canAddProperty("cy Image Wipe")) {
			compcode4.property("ADBE Effect Parade").addProperty("cy Image Wipe");
		} else {
			return alert("Cannot apply \"FEC Image Wipe\" (cy Image Wipe) effect to layer \"" + compcode4.name + "\" because you don't have this effect installed on your system.");
		}
		compcode4.property("ADBE Effect Parade").property(1).name = "FEC Image Wipe";
		compcode4.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0001").setValue(0.33);
		compcode4.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0002").setValue(0.36000610351563);
		compcode4.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0005").setValue(2);
		compcode4.property("ADBE Effect Parade").addProperty("ADBE Tint");
		compcode4.property("ADBE Effect Parade").property(2).name = "Tint";
		compcode4.property("ADBE Effect Parade").property(2).property("ADBE Tint-0001").setValue([1,0.73725491762161,0.32156863808632,1]);
		compcode4.property("ADBE Effect Parade").property(2).property("ADBE Tint-0002").setValue([1,0.73660898208618,0.321568608284,0]);
		if (compcode4.property("ADBE Effect Parade").canAddProperty("S_MathOps")) {
			compcode4.property("ADBE Effect Parade").addProperty("S_MathOps");
		} else {
			return alert("Cannot apply \"S_MathOps\" (S_MathOps) effect to layer \"" + compcode4.name + "\" because you don't have this effect installed on your system.");
		}
		compcode4.property("ADBE Effect Parade").property(3).name = "S_MathOps";
		compcode4.property("ADBE Effect Parade").property(3).property("S_MathOps-0051").setValue(1.47);
		compcode4.selected = false;
	// Add existing composition "预 合成 3", varName "compcode3_comp";
	var compcode5 = compcode8_comp.layers.add(compcode3_comp);
		compcode5.outPoint = 5.0333251953125;
		compcode5.moveToEnd();
		compcode5.property("ADBE Effect Parade").addProperty("ADBE Tint");
		compcode5.property("ADBE Effect Parade").property(1).name = "Tint";
		compcode5.property("ADBE Effect Parade").property(1).property("ADBE Tint-0001").setValue([1,0.38410174846649,0.08235293626785,1]);
		compcode5.property("ADBE Effect Parade").property(1).property("ADBE Tint-0002").setValue([1,0.38431373238564,0.08235294371843,1]);
		if (compcode5.property("ADBE Effect Parade").canAddProperty("S_MathOps")) {
			compcode5.property("ADBE Effect Parade").addProperty("S_MathOps");
		} else {
			return alert("Cannot apply \"S_MathOps\" (S_MathOps) effect to layer \"" + compcode5.name + "\" because you don't have this effect installed on your system.");
		}
		compcode5.property("ADBE Effect Parade").property(2).name = "S_MathOps";
		compcode5.property("ADBE Effect Parade").property(2).property("S_MathOps-0051").setValue(1.34);
		compcode5.selected = false;


	// Apply outOfRange values
		compcode3.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0005").setValue(2);

}
// Working with comp "预 合成 3", varName "compcode3_comp";
if (compcode3_comp_populate === true) {
	// Add existing composition "预合成 7", varName "compcode7_comp";
	var compcode7 = compcode3_comp.layers.add(compcode7_comp);
		compcode7.moveToEnd();
		compcode7.property("ADBE Effect Parade").addProperty("ADBE Displacement Map");
		compcode7.property("ADBE Effect Parade").property(1).name = "Displacement Map";
		compcode7.property("ADBE Effect Parade").property(1).property("ADBE Displacement Map-0003").setValue(9);
		compcode7.property("ADBE Effect Parade").property(1).property("ADBE Displacement Map-0005").setValue(1);
		if (compcode7.property("ADBE Effect Parade").canAddProperty("cy Image Wipe")) {
			compcode7.property("ADBE Effect Parade").addProperty("cy Image Wipe");
		} else {
			return alert("Cannot apply \"FEC Image Wipe\" (cy Image Wipe) effect to layer \"" + compcode7.name + "\" because you don't have this effect installed on your system.");
		}
		compcode7.property("ADBE Effect Parade").property(2).name = "FEC Image Wipe";
		compcode7.property("ADBE Effect Parade").property(2).property("cy Image Wipe-0001").setValue(0.14);
		compcode7.property("ADBE Effect Parade").property(2).property("cy Image Wipe-0002").setValue(0.18000610351563);
		compcode7.property("ADBE Effect Parade").property(2).property("cy Image Wipe-0005").setValue(1);
		compcode7.property("ADBE Effect Parade").addProperty("CC Vector Blur");
		compcode7.property("ADBE Effect Parade").property(3).name = "CC Vector Blur";
		compcode7.property("ADBE Effect Parade").property(3).property("CC Vector Blur-0002").setValue(5);
		compcode7.property("ADBE Effect Parade").property(3).property("CC Vector Blur-0004").setValue(100);
		compcode7.property("ADBE Effect Parade").property(3).property("CC Vector Blur-0007").setValue(0);
		if (compcode7.property("ADBE Effect Parade").canAddProperty("KNSW Unmult")) {
			compcode7.property("ADBE Effect Parade").addProperty("KNSW Unmult");
		} else {
			return alert("Cannot apply \"UnMult\" (KNSW Unmult) effect to layer \"" + compcode7.name + "\" because you don't have this effect installed on your system.");
		}
		compcode7.property("ADBE Effect Parade").property(4).name = "UnMult";
		compcode7.selected = false;


	// Apply outOfRange values
		compcode3.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0005").setValue(2);

}
// Working with comp "预合成 7", varName "compcode7_comp";
if (compcode7_comp_populate === true) {
	// Add existing footage item "内观武器烟雾[020000-020018].png", varName "png_footage";
	var png = compcode7_comp.layers.add(png_footage);
		png.startTime = -1.066650390625;
		png.inPoint = -0.28429227493355;
		png.outPoint = -0.27419126483254;
		png.blendingMode = BlendingMode.ADD;
		png.moveToEnd();
		png.property("ADBE Effect Parade").addProperty("ADBE Tint");
		png.property("ADBE Effect Parade").property(1).name = "Tint";
		png.property("ADBE Transform Group").property("ADBE Position").setValue([488,365,0]);
		png.property("ADBE Transform Group").property("ADBE Scale").setValue([100,100,100]);
		var pngOpacity = png.property("ADBE Transform Group").property("ADBE Opacity");
			var pngOpacity_keyTimesArray = [-0.00001627604167,0.99998372395833];
			var pngOpacity_valuesArray = [100,0];
			pngOpacity.setValuesAtTimes(pngOpacity_keyTimesArray, pngOpacity_valuesArray);
		png.selected = false;
	// Add existing footage item "内观武器烟雾[020000-020018].png", varName "png_footage";
	var png1 = compcode7_comp.layers.add(png_footage);
		png1.startTime = -0.066650390625;
		png1.inPoint = -0.066650390625;
		png1.outPoint = 0.72578938802083;
		png1.blendingMode = BlendingMode.ADD;
		png1.moveToEnd();
		png1.property("ADBE Effect Parade").addProperty("ADBE Tint");
		png1.property("ADBE Effect Parade").property(1).name = "Tint";
		png1.property("ADBE Transform Group").property("ADBE Position").setValue([488,365,0]);
		png1.property("ADBE Transform Group").property("ADBE Scale").setValue([100,100,100]);
		var png1Opacity = png1.property("ADBE Transform Group").property("ADBE Opacity");
			var png1Opacity_keyTimesArray = [-0.00001627604167,0.99998372395833];
			var png1Opacity_valuesArray = [0,100];
			png1Opacity.setValuesAtTimes(png1Opacity_keyTimesArray, png1Opacity_valuesArray);
		png1.selected = false;


	// Apply outOfRange values
		compcode3.property("ADBE Effect Parade").property(1).property("cy Image Wipe-0005").setValue(2);

}
compcode11_comp.openInViewer();

return {
	compItem : compcode11_comp
};

} catch (e) {
	alert (e.toString() + "\nScript File: " + File.decode(e.fileName).replace(/^.*[\|\/]/, '') + 
		"\nFunction: " + arguments.callee.name + 
		"\nError on Line: " + e.line.toString());
}
app.endUndoGroup();


function findProjectItem(searchFolder, recursion, userData) {
	var folderItem;
	for (var i = 1, il = searchFolder.items.length; i <= il; i++) {
		folderItem = searchFolder.items[i];
			if (propertiesMatch(folderItem, userData))
				return folderItem;
			else if (recursion === true && folderItem instanceof FolderItem && folderItem.numItems > 0) {
				var item = findProjectItem(folderItem, recursion, userData);
				if (item !== null) return item;
			}
		}
	return null;
}

function propertiesMatch(projectItem, userData) {
	if (typeof userData === "undefined") return true;

	for (var propertyName in userData) {
		if (!userData.hasOwnProperty(propertyName)) continue;

		if (typeof userData[propertyName] !== typeof projectItem[propertyName])
			return false;

		if (isArray(userData[propertyName]) && isArray(projectItem[propertyName])) {
			if (userData[propertyName].toString() !== projectItem[propertyName].toString()) {
				return false;
			}
		} else if (typeof userData[propertyName] === "object" && typeof projectItem[propertyName] === "object") {
			if (!propertiesMatch(projectItem[propertyName], userData[propertyName])) {
				return false;
			}
		} else if (projectItem[propertyName] !== userData[propertyName]) {
			return false;
		}
	}
	return true;
}

function isArray(object) {
	return Object.prototype.toString.apply(object) === "[object Array]";
}

}

