
var help = '此脚本为重命名脚本，旨在方便ae用户对项目或图层的批量处理，轻\n'+
                '松完成复杂的重命名操作。\n'+
                '功能：\n'+
                '1.可以选择对项目面板中项目的重命名和合成中图层的重命名；\n'+
                '2.简单重命名，可选择是否添加后缀；\n'+
                '3.实现对图层名字中指定字符进行替换，如果您精通正则表达式，可\n'+
                '  以对字符串进行匹配；\n'+
                '4.可以在指定位置实现对字符的替换或添加(1、2、3代表正序字符\n'+
                '  位置，-1、-2、-3代表倒序字符位置，0为最后位置)，如果希望替\n'+
                '  换多处用逗号隔开；\n'+
                '5.可以有选择的对重命名对象进行过滤操作。\n'+
                '\n'+
                '\n'+
                '-----------作者：阿木亮----------邮箱：982632988@qq.com--------\n';

//创建UI
function buideUI(obj){
    var win=(obj instanceof Panel)? obj : new Window("palette", 'rename', [0,0,205,270]);
    with(win){
        win.object = add( "statictext", [10,5,35,20], '对象', {name: 'object', } );
        win.project = add( "radiobutton", [45,5,90,20], '项目', {name: 'project', } );
        win.layers = add( "radiobutton", [95,5,140,20], '图层', {name: 'layers', } );  win.layers.value=true;
        win.help = add( "button", [175,2,195,24], '？' );
        win.newName = add( "edittext", [10,30,125,50], undefined, {name: 'newName', } );
        win.rename = add( "button", [130,30,200,52], '重命名' ); 
        win.isSimple = add( "radiobutton", [5,57,75,77], '仅重命名', {name: 'isSimple', } ); win.isSimple.value=true;
        win.isAppChar = add( "radiobutton", [5,82,100,102], '替换指定字符', {name: 'isAppChar', } );
        win.isPosChar = add( "radiobutton", [5,107,90,127], '在指定位置', {name: 'isPosChar', } );
        win.hasSuffix = add( "checkbox", [85,57,155,77], '添加后缀', {name: 'hasSuffix', } ); win.hasSuffix.value=true;
        win.replaceChar = add( "edittext", [105,82,200,102], undefined, {name: 'replaceChar', } ); win.replaceChar.enabled=false;
        win.isReplace = add( "radiobutton", [90,107,135,127], '替换', {name: 'isReplace', } ); win.isReplace.value=true; win.isReplace.enabled=false;
        win.isAdd = add( "radiobutton", [140,107,210,127], '添加', {name: 'isAdd', } ); win.isAdd.enabled=false;
        win.replacePos = add( "edittext", [5,127,200,147], undefined, {name: 'replacePos', } ); win.replacePos.enabled=false;
        win.filter = add( "panel", [5,152,200,262], '过滤器', {name: 'filter', } );  //建立图层过滤器面板
        with(win.filter){
            win.filter.hasSolid = add( "checkbox", [5,10,65,30], '固态层', {name: 'hasSolid', } ); win.filter.hasSolid.enabled=false;
            win.filter.hasShape = add( "checkbox", [70,10,130,30], '形状层', {name: 'hasShape', } ); win.filter.hasShape.enabled=false;
            win.filter.hasCamera = add( "checkbox", [135,10,195,30], '摄像机', {name: 'hasCamera', } ); win.filter.hasCamera.enabled=false;
            win.filter.hasText = add( "checkbox", [5,30,65,50], '文字层', {name: 'hasText', } ); win.filter.hasText.enabled=false;
            win.filter.hasLight = add( "checkbox", [70,30,130,50], '灯光', {name: 'hasLight', } ); win.filter.hasLight.enabled=false;
            win.filter.selectAll = add( "checkbox", [5,75,75,97], '全选', {name: 'selectAll', } ); win.filter.selectAll.value=true;
        }
        win.filter.visible=true;
        win.filter1 = add( "panel", [5,152,200,262], '过滤器', {name: 'filter1', } );  //建立项目过滤器面板
        with(win.filter1){
            win.filter1.hasCompItem = add( "checkbox", [5,10,65,30], '合成', {name: 'hasCompItem', } ); win.filter1.hasCompItem.enabled=false;
            win.filter1.hasFootageItem = add( "checkbox", [70,10,130,30], '影片', {name: 'hasFootageItem', } ); win.filter1.hasFootageItem.enabled=false;
            win.filter1.hasFolderItem = add( "checkbox", [135,10,195,30], '文件夹', {name: 'hasFolderItem', } ); win.filter1.hasFolderItem.enabled=false;
            win.filter1.selectAll = add( "checkbox", [5,75,75,97], '全选', {name: 'selectAll', } ); win.filter1.selectAll.value=true;
        }
        win.filter1.visible=false;
    }

    win.project.onClick=function(){
        win.filter.visible=false;
        win.filter1.visible=true;
    }
    win.layers.onClick=function(){
        win.filter.visible=true;
        win.filter1.visible=false;
    }
    win.help.onClick=function(){
        alert(help);
    }

    win.isPosChar.onClick=function(){
        win.hasSuffix.enabled=false;
        win.replaceChar.enabled=false;
        win.isReplace.enabled=true;
        win.isAdd.enabled=true;
        win.replacePos.enabled=true;
    }

    win.isAppChar.onClick=function(){
        win.hasSuffix.enabled=false;
        win.replaceChar.enabled=true;
        win.isReplace.enabled=false;
        win.isAdd.enabled=false;
        win.replacePos.enabled=false;
    }

    win.isSimple.onClick=function(){
        win.hasSuffix.enabled=true;
        win.replaceChar.enabled=false;
        win.isReplace.enabled=false;
        win.isAdd.enabled=false;
        win.replacePos.enabled=false;
    }

    win.filter.selectAll.onClick=function(){
        if(win.filter.selectAll.value==true){
            win.filter.hasSolid.value=true;
            win.filter.hasShape.value=true;
            win.filter.hasText.value=true;
            win.filter.hasCamera.value=true;
            win.filter.hasLight.value=true;
            win.filter.hasSolid.enabled=false;
            win.filter.hasShape.enabled=false;
            win.filter.hasText.enabled=false;
            win.filter.hasCamera.enabled=false;
            win.filter.hasLight.enabled=false;
        }else{
            win.filter.hasSolid.value=false;
            win.filter.hasShape.value=false;
            win.filter.hasText.value=false;
            win.filter.hasCamera.value=false;
            win.filter.hasLight.value=false;
            win.filter.hasSolid.enabled=true;
            win.filter.hasShape.enabled=true;
            win.filter.hasText.enabled=true;
            win.filter.hasCamera.enabled=true;
            win.filter.hasLight.enabled=true;
        }
    }
    win.filter1.selectAll.onClick=function(){
        if(win.filter1.selectAll.value==true){
            win.filter1.hasCompItem.value=true;
            win.filter1.hasFootageItem.value=true;
            win.filter1.hasFolderItem.value=true;
            win.filter1.hasCompItem.enabled=false;
            win.filter1.hasFootageItem.enabled=false;
            win.filter1.hasFolderItem.enabled=false;
        }else{
            win.filter1.hasCompItem.value=false;
            win.filter1.hasFootageItem.value=false;
            win.filter1.hasFolderItem.value=false;
            win.filter1.hasCompItem.enabled=true;
            win.filter1.hasFootageItem.enabled=true;
            win.filter1.hasFolderItem.enabled=true;
        }
    }
    return win;
}
var win=buideUI(this);
if(win instanceof Window){
    win.center();
    win.show();
}

//获取当前选中的合成
function selComp(){
    var thisComp=app.project.activeItem;
    if(!(thisComp instanceof CompItem)){alert('没有选中合成'); return false;}
    else if(thisComp.selectedLayers.length<1){alert('请选中图层'); return false;}
    else{sl=thisComp.selectedLayers; return true;}
}
//获取项目面板选中的项目
function selItems(){
    items=app.project.items;
    selectedItems=[];
    for(var i=1;i<=items.length;i++){if(items[i].selected==true) selectedItems.push(items[i]);}
    if(selectedItems.length<1){alert('没有选中项'); return false;}
    else{return true;}
}
//对必要项进行赋值
function initialise(){
    isProject=win.project.value;
    isLayers=win.layers.value;
    isSimple=win.isSimple.value;
    hasSuffix=win.hasSuffix.value;
    isPosChar=win.isPosChar.value;
    isAdd=win.isAdd.value;
    isReplace=win.isReplace.value;
    isAppChar=win.isAppChar.value;
    isAllSelected=true;
    newName=String(win.newName.text);
    replaceChar=String(win.replaceChar.text);
    replacePos=String(win.replacePos.text);
}
//图层过滤器
function filter(i){
    if(win.filter.selectAll.value==true){return true;}
    else if(sl[i] instanceof AVLayer){if(win.filter.hasSolid.value==false) return false;}
    else if(sl[i] instanceof ShapeLayer){if(win.filter.hasShape.value==false) return false;}
    else if(sl[i] instanceof TextLayer){if(win.filter.hasText.value==false) return false;}
    else if(sl[i] instanceof CameraLayer){if(win.filter.hasCamera.value==false) return false;}
    else if(sl[i] instanceof LightLayer){if(win.filter.hasLight.value==false) return false;}
    else{return true;}
}
//项目过滤器
function filter1(i){
    if(win.filter1.selectAll.value==true){return true;}
    else if(selectedItems[i] instanceof CompItem){if(win.filter1.hasCompItem.value==false) return false;}
    else if(selectedItems[i] instanceof FootageItem){if(win.filter1.hasFootageItem.value==false) return false;}
    else if(selectedItems[i] instanceof FolderItem){if(win.filter1.hasFolderItem.value==false) return false;}
    else{return true;}
}
 //图层简单重命名
function simple(){
    if(sl.length==1||hasSuffix==false){
        for(var i=0;i<sl.length;i++){
            if(filter(i)==false) continue;
            sl[i].name=newName;
        }        
    }else{
        var j=0;
        var t=0;
        for(var i=0;i<sl.length;i++){
            if(filter(i)==false) continue;
            j+=1;
            t=i;
            if(j<=9){sl[i].name=newName+"_00"+(j);}
            else if(j<=99){sl[i].name=newName+"_0"+(j);}
            else{sl[i].name=newName+"_"+(j);}
        }
        if(j==1) sl[t].name=newName;
    }
}
//项目简单重命名
function simple1(){
    if(selectedItems.length==1||hasSuffix==false){
        for(var i=0;i<selectedItems.length;i++){
            if(filter1(i)==false) continue;
            selectedItems[i].name=newName;
        }        
    }else{
        var j=0;
        var t=0;
        for(var i=0;i<selectedItems.length;i++){
            if(filter1(i)==false) continue;
            j+=1;
            t=i;
            if(j<=9){selectedItems[i].name=newName+"_00"+(j);}
            else if(j<=99){selectedItems[i].name=newName+"_0"+(j);}
            else{selectedItems[i].name=newName+"_"+(j);}
        }
        if(j==1) selectedItems[t].name=newName;
    }
}
//图层指定位置重命名
function posChar(){
    var p=replacePos.split(',');
     for(var i=0;i<sl.length;i++){
        if(filter(i)==false) continue;
        var oldName=sl[i].name;
        var sepName=oldName.split('');
        var myStr='';
        if(isReplace==true){
            for(var j=0;j<p.length;j++){
                var a=parseInt(p[j]);
                if(a>oldName.length||a==0) continue;
                if(a>0){a-=1;}
                else{a=oldName.length+a;}
                if(isNaN(a)==false) sepName.splice(a,1,newName);
            }
        }else{
            for(var j=0;j<p.length;j++){
                var a=parseInt(p[j]);
                if(a>oldName.length) continue;
                if(a==0){a=oldName.length-1; sepName[a]=sepName[a]+newName; continue;}
                if(a>0){a-=1;}
                else{a=oldName.length+a;}
                if(isNaN(a)==false) sepName[a]=newName+sepName[a];
            }
        }
        for(var j=0;j<sepName.length;j++){myStr+=sepName[j];}
        sl[i].name=myStr;
    }
}
//项目指定位置重命名
function posChar1(){
    var p=replacePos.split(',');
     for(var i=0;i<selectedItems.length;i++){
        if(filter1(i)==false) continue;
        var oldName=selectedItems[i].name;
        var sepName=oldName.split('');
        var myStr='';
        if(isReplace==true){
            for(var j=0;j<p.length;j++){
                var a=parseInt(p[j]);
                if(a>oldName.length||a==0) continue;
                if(a>0){a-=1;}
                else{a=oldName.length+a;}
                if(isNaN(a)==false) sepName.splice(a,1,newName);
            }
        }else{
            for(var j=0;j<p.length;j++){
                var a=parseInt(p[j]);
                if(a>oldName.length) continue;
                if(a==0){a=oldName.length-1; sepName[a]=sepName[a]+newName; continue;}
                if(a>0){a-=1;}
                else{a=oldName.length+a;}
                if(isNaN(a)==false) sepName[a]=newName+sepName[a];
            }
        }
        for(var j=0;j<sepName.length;j++){myStr+=sepName[j];}
        selectedItems[i].name=myStr;
    }
}
//图层指定字符替换
function appChar(){
    for(var i=0;i<sl.length;i++){
        if(filter(i)==false) continue;
        var oldName=sl[i].name;
        if(replaceChar.charAt(0)=='/'){
            try{eval('sl[i].name=oldName.replace('+replaceChar+',newName)');}
            catch(err){alert('正则表达式格式不正确'); break;}    
        }else{
            sl[i].name=oldName.replace(replaceChar,newName);
        }
    }
}
//项目指定字符替换
function appChar1(){
    for(var i=0;i<selectedItems.length;i++){
        if(filter1(i)==false) continue;
        var oldName=selectedItems[i].name;
        if(replaceChar.charAt(0)=='/'){
            try{eval('selectedItems[i].name=oldName.replace('+replaceChar+',newName)');}
            catch(err){alert('正则表达式格式不正确'); break;}    
        }else{
            selectedItems[i].name=oldName.replace(replaceChar,newName);
        }
    }
}
//重命名
function rename(){
    if(isLayers==true){
        if(isSimple==true) simple();
        if(isPosChar==true){if(isNumber()==true) posChar();}
        if(isAppChar==true) appChar();
    }else{
        if(isSimple==true) simple1();
        if(isPosChar==true){if(isNumber()==true) posChar1();}
        if(isAppChar==true) appChar1();    
    }
}
//判断指定位置字符串是否为有效数字
function isNumber(){
    var p=replacePos.split(',');
    for(var i=0;i<p.length;i++){
        if(p[i]=='') continue;
        var b=parseFloat(p[i]);
        if(isNaN(b)){ alert('输入格式不正确'); return false; }
    }
    return true;
}

//点击“重命名”事件
win.rename.onClick=function(){
    if(win.layers.value==true){
        if(selComp()==true){
            initialise();
            app.beginUndoGroup("rename");
            rename();
            app.endUndoGroup();
        }
    }else{
        if(selItems()==true){
            initialise();
            app.beginUndoGroup("rename");
            rename();
            app.endUndoGroup();
        }
    }
}



