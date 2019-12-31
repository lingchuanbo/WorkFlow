//作者：阿木亮	邮箱：982632988@qq.com	时间：2014/11/2

var lanternLayer={
    title : 'Lantern Layer',
    contral_str : '控制体',
    contralName_str : 'contral',
    layerName_str : 'layer',
	extractLayer_str : '提取图层到合成上方',
	parentLayer_str : '不连续图层间指定上一图层',
	allParentLayer_str : '全部指定上一图层',
	originalSize_str : '全部保持原始大小',
    refresh_str : '刷新',
    OK_str : ['确定','添加'],
    list_str : '新建空物体',
    alert_str : '请选择图层',
	alertNoLayer_str : '所选图层不存在',
    contralEffect_str : ['间距','宽度/高度','滚动','横向','反向'],
    layerEffect_str : ['自定义前一图层','前一图层','原始大小'],
}

lanternLayer.positonExpression_str =
"try{\
	distance = parent.effect('"+lanternLayer.contralEffect_str[0]+"')(1);//图层间距\
	roll = parent.effect('"+lanternLayer.contralEffect_str[2]+"')(1);//图层滚动\
	direction = parent.effect('"+lanternLayer.contralEffect_str[3]+"')(1);//图层方向\
	inversion = parent.effect('"+lanternLayer.contralEffect_str[4]+"')(1);//图层反方向\
	if(effect('"+lanternLayer.layerEffect_str[0]+"')(1)==true){parentLayer = effect('"+lanternLayer.layerEffect_str[1]+"')(1);}//获取上一图层\
	else{parentLayer = thisComp.layer(index-1);}\
	h = parentLayer.height;\
	w = parentLayer.width;\
	s = parentLayer.transform.scale[0];\
	if(parentLayer!=parent){p = parentLayer.transform.position;roll=0;}\
	else{p=value;distance=0;h=0;w=0;}\
	\
	if(direction == false){\
		if(inversion==true){a = -h*s/200-distance-height*transform.scale[0]/200+roll;}\
		else{a = h*s/200+distance+height*transform.scale[0]/200+roll;}\
		p+[0,a];\
	}else{\
		if(inversion==true){a = -w*s/200-distance-width*transform.scale[0]/200+roll;}\
		else{a = w*s/200+distance+width*transform.scale[0]/200+roll;}\
		p+[a,0];\
	}\
}catch(err){value}";
		
lanternLayer.scaleExpression_str =
"try{\
	if(effect('"+lanternLayer.layerEffect_str[2]+"')(1)==false){\
		w = parent.effect('"+lanternLayer.contralEffect_str[1]+"')(1);\
		direction = parent.effect('"+lanternLayer.contralEffect_str[3]+"')(1);\
		\
		if(direction == false){\
		r = w/width;\
		}else{\
		r = w/height;\
		}\
		[r,r]*100;\
	}else{value}\
}catch(err){value}";

lanternLayer.getSelectLayer = function (){//获取选中的图层函数
    this.thisComp = app.project.activeItem;
    if(!(this.thisComp instanceof CompItem)||this.thisComp.selectedLayers.length==0){
        alert(lanternLayer.alert_str);
        return false;
    }
    this.selectedLayers = this.thisComp.selectedLayers;
    return true;
}

lanternLayer.getNullLayer = function (){//获取空对象函数
    this.thisComp = app.project.activeItem;
    if(!(this.thisComp instanceof CompItem)){
        return false;
    }
    this.nullLayers =[];
    var sl = this.thisComp.layers;
    for(var i=1;i<=sl.length;i++){
        if(sl[i].property("Marker").numKeys > 0 && sl[i].property("Marker").keyValue(1).comment == this.contralName_str) {
			this.nullLayers.push(sl[i]);
		}
    }
    return true;
}

lanternLayer.win = function (obj){//创建窗口函数
    var newWin =(obj instanceof Panel)? obj : new Window('palette', this.title, undefined, {resizeable: true});
	newWin.winGroup = newWin.add(
		"Group{\
			alignment:['fill','fill'],\
			alignChildren :['fill','top'],\
			orientation: 'column',\
			topGroup: Group{\
				alignChildren :['fill','center'],\
				orientation: 'row',\
				contral: StaticText{alignment:['left','center'],},\
				selectContral: DropDownList{alignment:['left','center'],},\
			},\
			contralName: EditText{},\
			extractLayer: Checkbox{},\
			parentLayer: Checkbox{},\
			allParentLayer: Checkbox{},\
			originalSize: Checkbox{},\
			buttonGroup: Group{\
				alignChildren :['fill','center'],\
				orientation: 'row',\
				refresh: Button{},\
				OK: Button{},\
			}\
		}"
	);
    newWin.winGroup.topGroup.contral.text = this.contral_str;
    var selectContral = newWin.winGroup.topGroup.selectContral;
	selectContral.add('item', lanternLayer.list_str);
    var contralName = newWin.winGroup.contralName;
    contralName.text = this.contralName_str;
	var extractLayer = newWin.winGroup.extractLayer;
	extractLayer.text = this.extractLayer_str;
	var parentLayer = newWin.winGroup.parentLayer;
	parentLayer.text = this.parentLayer_str;
	var allParentLayer = newWin.winGroup.allParentLayer;
	allParentLayer.text = this.allParentLayer_str;
	var originalSize = newWin.winGroup.originalSize;
	originalSize.text = this.originalSize_str;
    newWin.winGroup.buttonGroup.refresh.text = this.refresh_str;
	var OKButton = newWin.winGroup.buttonGroup.OK;
    OKButton.text = this.OK_str[0];
	
    //----------------------------事件-----------------------------------------
	
	newWin.layout.layout(true);
	newWin.layout.resize();
	newWin.onResizing = newWin.onResize = function () { this.layout.resize(); } 

	newWin.onActivate = function (){//CC中，因为在selectContral.onChange中函数中的代码会错所以写在了这里
		if(selectContral.selection == null && selectContral.items.length > 0) {
			selectContral.selection = 0;
		}
	}

	extractLayer.onClick = allParentLayer.onClick =function () {
		if(extractLayer.value == true || allParentLayer.value == true) {
			parentLayer.enabled = false;
		}else{
			parentLayer.enabled = true;
		}
	}

    selectContral.onChange = function (){//确保列表选择项不为空
        if(this.selection == 0 || this.selection == null) {
			contralName.enabled = true;
			OKButton.text = lanternLayer.OK_str[0];
		} else {
			contralName.enabled = false;
			OKButton.text = lanternLayer.OK_str[1];
		}
    }

    contralName.onChange= function (){
        if(contralName.text=='') contralName.text=lanternLayer.contralName_str;
    }

    newWin.winGroup.buttonGroup.refresh.onClick = function () {
        selectContral.removeAll();//初始化列表
        selectContral.add('item', lanternLayer.list_str);
        selectContral.add('separator');
        if(lanternLayer.getNullLayer() == true) {
            for(var i=0;i<lanternLayer.nullLayers.length;i++){//循环生成列表
                selectContral.add('item',lanternLayer.nullLayers[i].name);
            }
        }
		selectContral.selection=0;
    }

    OKButton.onClick=function (){
        if(lanternLayer.getSelectLayer()==false) return false;
		app.beginUndoGroup(lanternLayer.title);
        if(selectContral.selection == 0 || selectContral.selection == null){//确定控制体，如果为0或null创建空物体
			lanternLayer.contralLayer = lanternLayer.thisComp.layers.addNull();
			lanternLayer.contralLayer.name = contralName.text;
			lanternLayer.contralLayer.moveBefore(lanternLayer.selectedLayers[0]);//如果是新建的空对象移动到选中的第一个图层上面
			
			for(var i=0;i<3;i++){//为控制层添加效果
				var myEffect = lanternLayer.contralLayer.effect.addProperty('ADBE Slider Control');
				myEffect.name = lanternLayer.contralEffect_str[i];
			}
			lanternLayer.contralLayer.effect(2)(1).setValue(200);
			var myEffect = lanternLayer.contralLayer.effect.addProperty('ADBE Checkbox Control');
			myEffect.name = lanternLayer.contralEffect_str[3];
			myEffect(1).setValue(true);
			var myEffect = lanternLayer.contralLayer.effect.addProperty('ADBE Checkbox Control');
			myEffect.name = lanternLayer.contralEffect_str[4];
			var myMarker = new MarkerValue(lanternLayer.contralName_str);//为控制层添加标记，以便识别
			lanternLayer.contralLayer.property("Marker").setValueAtTime(0, myMarker);
        }else{
			if(isValid(lanternLayer.nullLayers[selectContral.selection.index-2])) {//判断当前选择的控制体是否可用
				lanternLayer.contralLayer = lanternLayer.nullLayers[selectContral.selection.index-2];
			}else{
					alert(lanternLayer.alertNoLayer_str);
					newWin.winGroup.buttonGroup.refresh.onClick();
					return false;
			}
		}
		
		for(var i=0;i<lanternLayer.selectedLayers.length;i++) {//如果选中图层中有控制层则将其从数组中删掉
			if(lanternLayer.selectedLayers[i] == lanternLayer.contralLayer) {
				lanternLayer.selectedLayers.splice(i,1);
				break;
			}
		}
	
		if(extractLayer.value == true) {//提取图层到合成的最前面
			for(var i=0;i<lanternLayer.selectedLayers.length;i++) {
				lanternLayer.selectedLayers[i].moveBefore(lanternLayer.thisComp.layer(i+1));//i+1确保先选中的图层排在前面
			}
			lanternLayer.contralLayer.moveToBeginning();
		}
		
        for(var i=0;i<lanternLayer.selectedLayers.length;i++){//循环为图层添加效果及表达式
			lanternLayer.selectedLayers[i].parent = lanternLayer.contralLayer;
			if(lanternLayer.selectedLayers[i].property("Marker").numKeys > 0 && lanternLayer.selectedLayers[i].property("Marker").keyValue(1).comment == lanternLayer.layerName_str) {
				continue;//如果图层有标记则不再执行下面的代码
			}
			var myEffect = lanternLayer.selectedLayers[i].effect.addProperty('ADBE Checkbox Control');//开始添加效果
			myEffect.name = lanternLayer.layerEffect_str[0];
			var myEffect = lanternLayer.selectedLayers[i].effect.addProperty('ADBE Layer Control');
			myEffect.name = lanternLayer.layerEffect_str[1];
			myEffect(1).setValue(0);
			if(parentLayer.value == true && allParentLayer.value == false) {//指定图层的上一图层
				if(i == 0 && lanternLayer.selectedLayers[i].index != lanternLayer.contralLayer.index + 1) {
					lanternLayer.selectedLayers[i].effect(myEffect.propertyIndex-1)(1).setValue(true);
					myEffect(1).setValue(lanternLayer.contralLayer.index);
				}else if(i != 0 && lanternLayer.selectedLayers[i].index != lanternLayer.selectedLayers[i-1].index + 1) {
					lanternLayer.selectedLayers[i].effect(myEffect.propertyIndex-1)(1).setValue(true);
					myEffect(1).setValue(lanternLayer.selectedLayers[i-1].index);
				}
			}else if(allParentLayer.value == true) {
				lanternLayer.selectedLayers[i].effect(myEffect.propertyIndex-1)(1).setValue(true);
				if(i == 0) {
					myEffect(1).setValue(lanternLayer.contralLayer.index);
				}else{
					myEffect(1).setValue(lanternLayer.selectedLayers[i-1].index);
				}
			}
			var myEffect = lanternLayer.selectedLayers[i].effect.addProperty('ADBE Checkbox Control');
			myEffect.name = lanternLayer.layerEffect_str[2];
			myEffect(1).setValue(originalSize.value);

			lanternLayer.selectedLayers[i].transform.position.expression = lanternLayer.positonExpression_str;//添加表达式
			lanternLayer.selectedLayers[i].transform.scale.expression = lanternLayer.scaleExpression_str;
			
			var myMarker = new MarkerValue(lanternLayer.layerName_str);//为图层添加标记，以便识别
			lanternLayer.selectedLayers[i].property("Marker").setValueAtTime(0, myMarker);
        }
        app.endUndoGroup();
    }

    newWin.winGroup.buttonGroup.refresh.onClick();
    return newWin;
}

var lanternLayerWin = lanternLayer.win(this);
if(lanternLayerWin instanceof Window) {
	lanternLayerWin.center();
	lanternLayerWin.show();
}