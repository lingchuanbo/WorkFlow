//now works with sequences or still images, windows only 
//decodeURI
//URIToWinPath
//edit nov2017 so we get nicer paths (windows-like c:/file path instead of \c\file%20path

BatchReplaceFileLocationsWithTextFile();

function BatchReplaceFileLocationsWithTextFile() {
    
    app.beginUndoGroup("Change File Locations");
    
    var txtFile = new File("~/Desktop/tempAE.txt");
    txtFile.open("w","TEXT","????");
    txt = "";
    sel = app.project.selection;
    var isSequence = new Array();
    if(sel.length == 0){
       alert("Select footage items.");
    }else{
        for(i=0;i<app.project.selection.length;i++){
            isSequence[i] = !sel[i].mainSource.isStill;
            txt += URIToWinPath(sel[i].mainSource.file.toString())+"\n";
        }
        txtFile.write(decodeURI("*** 修改完按提示保存，否者不起作用！***\n\n"));
        txtFile.write(decodeURI(txt));
        txtFile.close();
        txtFile.execute();
        isOk = confirm("确定改变路径 ?\n\n重新加载中... ...!");
        if(isOk){
           txtFile.open("r","TEXT","????"); 
           contents = txtFile.read();
           arrayContents = contents.split("\n");

           for(i=0;i<app.project.selection.length;i++){
                var tmpFile =  new File(WinPathtoURI(arrayContents[i+2]));
                //alert(tmpFile);
                if(isSequence[i]){
                    sel[i].replaceWithSequence(tmpFile,0);
                }else{
                    sel[i].replace(tmpFile);
                }
                
                writeLn(Math.round((i+1)/app.project.selection.length*100)+"%");
           }
        }
    }
    app.endUndoGroup();  
}

function URIToWinPath(path){
	str = path.replace(/\//, "");
	str = str.replace(/\//, ":/");
	str = str.replace(/%20/g, " ");
	str = str.replace(/\//g, "\\");
	return str;
}
function WinPathtoURI(path){
    //windows, for now, the only one available!
    str = "/"+path.replace(":\\", "/");
    str = str.replace(/\\/g, "/");
    str = str.replace(/ /g, "%20");
    //str = str.substring(0,str.lastIndexOf("/"));
    return str;
}


// {
//     app.beginUndoGroup("Change File Locations");
    
//     var txtFile = new File("~/Desktop/tempAE.txt");
//     txtFile.open("w","TEXT","????");
//     txt = "";
//     sel = app.project.selection;
//     var isSequence = new Array();
//     if(sel.length == 0){
//        alert("Select footage items.");
//     }else{
//         for(i=0;i<app.project.selection.length;i++){
//             isSequence[i] = !sel[i].mainSource.isStill;
//             txt += URIToWinPath(sel[i].mainSource.file.toString())+"\n";
//         }
//         txtFile.write(decodeURI("*** 修改完按提示保存，否者不起作用！***\n\n"));
//         txtFile.write(decodeURI(txt));
//         txtFile.close();
//         txtFile.execute();
//         isOk = confirm("确定改变路径 ?\n\n重新加载中... ...!");
//         if(isOk){
//            txtFile.open("r","TEXT","????"); 
//            contents = txtFile.read();
//            arrayContents = contents.split("\n");

//            for(i=0;i<app.project.selection.length;i++){
//                 var tmpFile =  new File(WinPathtoURI(arrayContents[i+2]));
//                 //alert(tmpFile);
//                 if(isSequence[i]){
//                     sel[i].replaceWithSequence(tmpFile,0);
//                 }else{
//                     sel[i].replace(tmpFile);
//                 }
                
//                 writeLn(Math.round((i+1)/app.project.selection.length*100)+"%");
//            }
//         }
//     }
//     app.endUndoGroup();
// }