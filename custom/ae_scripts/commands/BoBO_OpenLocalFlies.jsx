
function revealFile(filePath) {
	if ( filePath instanceof File ) {
		filePath = filePath.fsName;
	}

	var command = "open -R";
	if ($.os.indexOf("Win") != -1) {
		command = "Explorer /select,";
	}
	arg = "\"" + filePath + "\"";
	return system.callSystem(command + " " + arg);
}

if(app.project.file !== null){
    // var path = app.project.file.fsName;
    // $.writeln(path);
    var path=app.project['file'];
    revealFile(path);
}else{
    alert("文件未保存，请先保存文件！")
}
