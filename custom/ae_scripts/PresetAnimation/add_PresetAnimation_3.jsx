var mypreset = File("E:\\Dropbox\\04_PCtools\\ahk\\Vimdesktop\\custom\\ae_presetAnimation\\Untitled.ffx"); //这里填你要预设的文件
var layer = app.project.activeItem.selectedLayers[0];
layer.applyPreset(mypreset);