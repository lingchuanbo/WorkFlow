var myProject = app.project;
var myNumItemsIndex = myProject.renderQueue.numItems;
if (myNumItemsIndex >= 1) {
    var myRQItem = myProject.renderQueue.item(myNumItemsIndex);
    var myRQFile = myRQItem.outputModule(1).file;
    var myFileName = myProject.file.name;
    var str=decodeURI(myRQFile);
    // \替换/
    var getAllDir=str.replace(/\//g,"\\"); 
    //分割字符串
    //
    var getDir=getAllDir.substr(1,1);
    //获取盘符
    var getDirPath=getAllDir.substring(2);

    //完整路经
    var Dir=getDir + ':' + getDirPath

    system.callSystem("F:\\BoBOProgram\\TotalCMD\\TOTALCMD.EXE /O /T /R=" + Dir);
}else{
    alert("当前无渲染文件！")
}