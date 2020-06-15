(function(Global) {
#include 'F:/BoBOAHK/WorkFlow/custom/ae_scripts/commands/lib/UIParser.jsx'
#include 'F:/BoBOAHK/WorkFlow/custom/ae_scripts/commands/lib/Tree.jsx'
var _ = UIParser(Global);
 var subUIJson = {
 	// 帮助
 	helpUI: {
 		group: {type:'group', orientation:'column', align:'fill', children:{
 			picture: {type:'image', align:'top', label:'picture'},
 			help_box: {type:'edittext', align:'fill', properties:{multiline:1, readonly:1}},
 		}}
 	}
 }

 var fns = {
 	createWin: function(title, json, exec, finalexec) {
 		var newWin = new Window('palette', title, undefined, {resizeable: true});
 		_(newWin).addUI(json);
 		_(newWin).layout();
 		_(newWin).find('*').layout();
 		exec(newWin);
 		_.window.resize(newWin);
 		if(finalexec) finalexec(newWin);
 		if(newWin.size[0] < 300) newWin.size[0] = 300;
 		newWin.show();
 		return newWin;
 	},
 };

 var helpFile = File("F:/BoBOAHK/WorkFlow/custom/ae_scripts/commands/PluginsReg.txt");
 if(helpFile.exists) var helpStr = _.file.read(File("F:/BoBOAHK/WorkFlow/custom/ae_scripts/commands/PluginsReg.txt"));
 else helpStr = 'Null';
 //alert(helpStr);
 fns.createWin('常用注册信息 By.BoBO', subUIJson.helpUI, function(e) {
     try{
     var win = e;
     var pic = _(win).find('#picture')[0];
     var help = _(win).find('#help_box')[0];
    //setImage(pic, pic.label);
     help.text = helpStr;
     }catch(err){alert(err)}
 });
})(this);