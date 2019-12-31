/*########################################################################################################################
#	選択したレイヤーだけを表示・非表示するスクリプト
#	@author suimin <https://www.cg-method.com/>
########################################################################################################################*/

(function(){
    app.bringToFront();  
    var doc= activeDocument;
    var bg = doc.layers.length;
    var comp = "tmp";

    //背景がある場合は解除
    doc.layers[bg-1].isBackgroundLayer = false;

    doc.suspendHistory("選択したレイヤーだけを表示・非表示する", "main()");

    function main() {
        try{
            if (doc.layerComps[0].selected = doc.layerComps.getByName(comp) ) {
                restoreSelectLayer();
                deleteSelectLayer();
            } 
        }catch(e){
            doc.layerComps.add(comp);
            showSelectLayer();
            }
    }  

    //レイヤーカンプの表示を削除
    function deleteSelectLayer(){
        var idDlt = charIDToTypeID( "Dlt " );
        var desc9 = new ActionDescriptor();
        var idnull = charIDToTypeID( "null" );
        var ref4 = new ActionReference();
        var idcompsClass = stringIDToTypeID( "compsClass" );
        var idOrdn = charIDToTypeID( "Ordn" );
        var idTrgt = charIDToTypeID( "Trgt" );
        ref4.putEnumerated( idcompsClass, idOrdn, idTrgt );
        desc9.putReference( idnull, ref4 );
        executeAction( idDlt, desc9, DialogModes.NO );
    }

    //選択しているレイヤーのみ表示
    function showSelectLayer(){       
        var idShw = charIDToTypeID( "Shw " );
        var desc75 = new ActionDescriptor();
        var idnull = charIDToTypeID( "null" );
        var list42 = new ActionList();
        var ref68 = new ActionReference();
        var tgtLayerkind = activeDocument.activeLayer;
            if(tgtLayerkind.isBackgroundLayer){
                var idLyr = charIDToTypeID( "Lyr " );
                var idBckg = charIDToTypeID( "Bckg" );
                ref68.putProperty( idLyr, idBckg );
            } else {
                ref68.putIndex( charIDToTypeID("Lyr "), tgtLayerkind.itemIndex );
            }
        list42.putReference( ref68 );
        desc75.putList( idnull, list42 );
        var idTglO = charIDToTypeID( "TglO" );
        desc75.putBoolean( idTglO, true );
        executeAction( idShw, desc75, DialogModes.NO );
    }
        
     //もとの表示状態に戻す   
    function restoreSelectLayer(){    
        var idapplyComp = stringIDToTypeID( "applyComp" );
            var desc19 = new ActionDescriptor();
            var idnull = charIDToTypeID( "null" );
                var ref9 = new ActionReference();
                var idcompsClass = stringIDToTypeID( "compsClass" );
                ref9.putName( idcompsClass, "tmp" );
            desc19.putReference( idnull, ref9 );
        executeAction( idapplyComp, desc19, DialogModes.NO );
    }

})() ;