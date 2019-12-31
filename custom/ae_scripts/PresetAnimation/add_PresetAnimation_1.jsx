// var enDir = $.getenv("vimdir") ; //获取VIMD环境路径
// var getDir=enDir.replace(/\\/g, '\/'); //转换字符
// var getPath = "/custom/ae_presetAnimation/Transform@场景.ffx";//请在这行修改预设文件
// var myPreset = File(getDir+getPath);//合并路径
// layer.applyPreset(myPreset);

// var layer = app.project.activeItem.selectedLayers[0];

// layer.applyPreset(myPreset);

var main = function() {


    var enDir = $.getenv("vimdir") ; //获取VIMD环境路径
    var getDir=enDir.replace(/\\/g, '\/'); //转换字符
    var getPath = "/custom/ae_presetAnimation/xm5@外发光_血斧手.ffx";//请在这行修改预设文件
    var myPreset = File(getDir+getPath);//合并路径

    var proj = app.project;

    var folder = Folder.myDocuments.fsName + '/Adobe/After Effects CC 2014/User Presets/';

    var ffxspill1 = 'jacobs-spill-surpress-01.ffx';

    var presetfilepath = folder + ffxspill1; // "path/to/mypreset.ffx";

    var pfile = File(myPreset);

    if (pfile.exists !== true) {
      alert('Preset file does not exist');
      return;
    }
  
    app.beginUndoGroup('apply preset');
  
    for (var i = 0; i < proj.selection.length; i++) {
  
      var item = proj.selection[i];
  
      if (item instanceof CompItem) {
        var layer = item.layers[1];
        $.writeln(layer.name);
        layer.applyPreset(pfile);
      }
  
    }
    app.endUndoGroup();
    return 0;
  };
  
  
  var run = function(f) {
    return f();
  };
  
  run(main);