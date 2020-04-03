//初始化文件,可能会被覆盖!
var myProject = app.project;
var myNumItemsIndex = myProject.renderQueue.numItems;
if (myNumItemsIndex >= 1) {
    var myRQItem = myProject.renderQueue.item(myNumItemsIndex);
    var myRQFile = myRQItem.outputModule(1).file;
    var myFileName = myProject.file.name;
    var str=decodeURI(myRQFile);
    var getAllDir=str.replace(/\//g,"\\");
    var getDir=getAllDir.substr(1,1);
    var getDirPath=getAllDir.substring(2);
    var Dir=getDir + ':' + getDirPath
    system.callSystem("F:\\BoBOAHK\\WorkFlow\\tools\\TotalCMD\\TOTALCMD.EXE /O /T /R=" + Dir);
}else{
    alert("当前无渲染文件！")
}