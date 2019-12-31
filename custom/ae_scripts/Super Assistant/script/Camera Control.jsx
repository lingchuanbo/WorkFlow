//作者：阿木亮	邮箱：982632988@qq.com	日期：2015/3/30

(function(global){
	var ac = app.project.activeItem;//获取当前活动项
	if(!(ac instanceof CompItem)) {//如果当前活动项不是合成停止运行
		return false;
	}

	var effect = [
		['半径', 'ADBE Slider Control', 1000],
		['水平旋转', 'ADBE Angle Control', 0],
		['上下旋转', 'ADBE Angle Control', 45],
		['自转', 'ADBE Angle Control', 0],
		['缩放', 'ADBE Slider Control', 1000],
		['景深开关', 'ADBE Checkbox Control', 0],
		['景深', 'ADBE Slider Control', 1000],
		['光圈', 'ADBE Slider Control', 500],
		['显示网格', 'ADBE Checkbox Control', 1],
	];
	
	app.endUndoGroup();//先endUndoGroup是因为脚本可能包含在一个专门执行脚本的脚本里运行，与原脚本的代码冲突
	app.beginUndoGroup('Create Camera');
	/*********************************添加控制空物体*************************************/
	var contral = ac.layers.addNull();
	contral.name = '摄像机控制';
	for(var i = 0; i < effect.length; i++) {
		var newEffect = contral.effect.addProperty(effect[i][1]);
		newEffect.name = effect[i][0];
		newEffect(1).setValue(effect[i][2]);
	}
	contral.threeDLayer = true;
	contral.guideLayer = true;
	contral.orientation.setValue([0,0,270]);
	contral.scale.expression = '[100,100,100]';
	contral.xRotation.expression = 'effect("水平旋转")(1)';
	contral.yRotation.expression = '-effect("上下旋转")(1)';
	contral.zRotation.expression = 'effect("自转")(1)';
	
	/********************************创建摄像机******************************************/
	var camera = ac.layers.addCamera('摄像机', [ac.width,ac.height]/2);
	camera.threeDLayer = true;
	camera.parent = contral;
	camera.shy = true;
	camera.orientation.setValue([0,0,90]);
	camera.pointOfInterest.expression = 'parent.anchorPoint';
	camera.position.expression = 'r = parent.effect("半径")(1);[0,0,-r]';
	camera.cameraOption.zoom.expression= 'parent.effect("缩放")(1)';
	camera.cameraOption.depthOfField.expression= 'parent.effect("景深开关")(1)';
    camera.cameraOption.focusDistance.expression= 'parent.effect("景深")(1)';
    camera.cameraOption.aperture.expression= 'parent.effect("光圈")(1)';
	camera.locked = true;
	
	/********************************创建焦距参考点******************************************/
	var focal = ac.layers.addNull();
	focal.name = '焦距参考点';
	focal.parent = contral;
	focal.threeDLayer = true;
	focal.guideLayer = true;
	focal.anchorPoint.setValue([50,50,0]);
	focal.shy = true;
	focal.position.expression = '//这个表达式使焦距参考点被约束于摄像机与目标之间\nc = thisComp.layer("摄像机");\nv = c.pointOfInterest - c.position;\nc.position + normalize(v)*parent.effect("景深")(1)';
	focal.autoOrient = AutoOrientType.CAMERA_OR_POINT_OF_INTEREST;
	
	/********************************创建参考网格******************************************/
	var grid = ac.layers.addSolid([1,1,1], '网格参考', 10000, 10000, ac.pixelAspect, ac.duration);
	grid.threeDLayer = true;
	grid.guideLayer = true;
	grid.shy = true;
	grid.locked = true;
	grid.orientation.setValue([-90,0,0]);
	grid.opacity.expression = 'thisComp.layer("摄像机控制").effect("显示网格")(1)*100';
	
	var grid1 = grid.effect.addProperty('ADBE Grid');
	grid1.name = '小网格';
	grid1(2).setValue(2);
	grid1(4).setValue(100);
	grid1(6).expression = 'r = thisComp.layer("摄像机控制").effect("半径")(1);\nlinear(r, 0, 5000, 1, 5)';
	grid1(13).expression = 'r = thisComp.layer("摄像机控制").effect("半径")(1);\nlinear(r, 100, 5000, 100, 0)';
	
	var grid1 = grid.effect.addProperty('ADBE Grid');
	grid1.name = '大网格';
	grid1(2).setValue(2);
	grid1(4).setValue(1000);
	grid1(6).expression = 'r = thisComp.layer("摄像机控制").effect("半径")(1);\nlinear(r, 1000, 2000, 5, 10)';
	grid1(14).setValue(2);
	
})(this);