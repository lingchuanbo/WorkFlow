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
    var getDir=getAllDir.substr(1,1);
    //获取盘符
    var getDirPath=getAllDir.substring(2);
    //删除末尾字符串
    
    var ipos = getDirPath.lastIndexOf("\\");
    var delString=getDirPath.substring(ipos);
    var dirPath=getDirPath.replace(delString,"")

    //完整路经
    var Dir=getDir + ':' + dirPath +"\\"
    system.callSystem("Explorer /select," + Dir+"\"");
}else{
    alert("当前无渲染文件！")
}