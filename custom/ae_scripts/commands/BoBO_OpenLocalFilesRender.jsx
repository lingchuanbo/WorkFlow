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
    var ipos = getDirPath.lastIndexOf("\\");
    var delString=getDirPath.substring(ipos);
    var dirPath=getDirPath.replace(delString,"")
    var Dir=getDir + ':' + dirPath +"\\"
    system.callSystem("Explorer /select," + Dir+"\"");
}else{
    alert("当前无渲染文件！")
}