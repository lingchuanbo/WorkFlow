//定义一个变量[document]，用来表示Photoshop的当前文档。
var document = app.activeDocument;

//调用[document]对象的[flipCanvas]方法，来翻转画布。此处设置为水平翻转。
//document.flipCanvas(Direction.HORIZONTAL);

//然后进行一次垂直方向的翻转。
document.flipCanvas(Direction.VERTICAL);