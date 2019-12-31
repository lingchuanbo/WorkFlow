#target photoshop

var myBrushratio = 5;//画面サイズを割る
var myMonitorsize = 1440; //モニタの高さ
setBrushFeatures (Math.min(5000,Math.round(myMonitorsize/myBrushratio/getZoomLevel()*100)),50,0,100,25,0,0);


function getZoomLevel(){
var ref = new ActionReference();
ref.putProperty( stringIDToTypeID('property'), stringIDToTypeID('zoom')); 
ref.putEnumerated( charIDToTypeID("Dcmn"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt") ); 
var desc = executeActionGet(ref);
return Number(desc.getDouble(stringIDToTypeID('zoom'))*100).toFixed(1);
};


// ---Original script by https://forums.adobe.com/message/8691930  JJMack---

//        Features(Diameter,Hardness,Angle,Roundness,Spacing,Flipy,Flipx)   
//setBrushFeatures(undefined,undefined,undefined,undefined,undefined,undefined,undefined);    
//setBrushFeatures(13,0,0,100,25,0,0);       //Adobe Defaults   
//setBrushFeatures(13,0,0,100,25,true,true); //Diameter,Hardness,Angle,Roundness,Spacing,Flipy,Flipx   
//setBrushFeatures(13,0,0,100,25,1,0);       //Diameter,Hardness,Angle,Roundness,Spacing,Flipy,Flipx        
//setBrushFeatures(13,0,0,100,25,0);         //Diameter,Hardness,Angle,Roundness,Spacing,Flipy   
//setBrushFeatures(13,0,0,100,1);            //Diameter,Hardness,Angle,Roundness,Spacing   
//setBrushFeatures(13,0,0,50);               //Diameter,Hardness,Angle,Roundness   
//setBrushFeatures(13,0,45);                 //Diameter,Hardness,Angle   
//setBrushFeatures(13,50);                   //Diameter,Hardness   



//==============================================================================================//  
function setBrushFeatures (Diameter,Hardness,Angle,Roundness,Spacing,Flipy,Flipx) {    
    //A Brush tool must be the current tool  
    if (!app.toolSupportsBrushes(app.currentTool)) selectBrush();  //CC 2014  
    var ref = new ActionReference();    
    ref.putEnumerated( charIDToTypeID("capp"), charIDToTypeID("Ordn"), charIDToTypeID("Trgt") );    
    var appDesc = executeActionGet(ref);    
    var toolDesc = appDesc.getObjectValue(stringIDToTypeID('currentToolOptions'));    
    var brushDesc = toolDesc.getObjectValue(stringIDToTypeID('brush'));    
    if (Diameter == undefined) Diameter = brushDesc.getDouble(stringIDToTypeID('diameter'));    
    if (Hardness == undefined) Hardness = brushDesc.getDouble(stringIDToTypeID('hardness'));    
    if (Angle == undefined ) Angle = brushDesc.getDouble(stringIDToTypeID('angle'));    
    if (Roundness  == undefined) Roundness = brushDesc.getDouble(stringIDToTypeID('roundness'));    
    if (Spacing == undefined) Spacing = brushDesc.getDouble(stringIDToTypeID('spacing'));    
    if (Flipy == undefined) Flipy = brushDesc.getBoolean(stringIDToTypeID('flipY'));    
    if (Flipx == undefined) Flipx = brushDesc.getBoolean(stringIDToTypeID('flipX'));   
    var desc = new ActionDescriptor();    
    var ref = new ActionReference();    
    ref.putEnumerated( charIDToTypeID( "Brsh" ), charIDToTypeID( "Ordn" ), charIDToTypeID( "Trgt" ) );    
    desc.putReference( charIDToTypeID( "null" ), ref );    
    var desc1 = new ActionDescriptor();    
    desc1.putDouble(stringIDToTypeID('diameter'), Diameter);    
    desc1.putDouble(stringIDToTypeID('hardness'), Hardness);    
    desc1.putDouble(stringIDToTypeID('angle'), Angle);    
    desc1.putDouble(stringIDToTypeID('roundness'), Roundness);    
    desc1.putUnitDouble( stringIDToTypeID('spacing'), charIDToTypeID('#Prc'), Spacing);    
    desc1.putBoolean(stringIDToTypeID('flipY'), Flipy);    
    desc1.putBoolean(stringIDToTypeID('flipX'), Flipx);    
    desc.putObject( stringIDToTypeID('to'), charIDToTypeID( "Brsh" ), desc1 );    
    executeAction( charIDToTypeID( "setd" ), desc, DialogModes.NO );    
}   
function selectBrush() {  
    //select brush scriptlistener code  
    var idslct = charIDToTypeID( "slct" );  
    var desc12 = new ActionDescriptor();  
    var idnull = charIDToTypeID( "null" );  
    var ref8 = new ActionReference();  
    var idPbTl = charIDToTypeID( "PbTl" );  
    ref8.putClass( idPbTl );  
    desc12.putReference( idnull, ref8 );  
    executeAction( idslct, desc12, DialogModes.NO );  
} 