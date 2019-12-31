//nulls created from puppet pins can be parented like normal layers
{
    app.beginUndoGroup("Create Null Controls on Puppet Pinsv");

    function getLayerFromProperty(prop){
        return prop.propertyGroup(prop.propertyDepth)
    }


    var c = app.project.activeItem;
    if( c != null && c.selectedProperties != null){
        var props = c.selectedProperties;
        j = 0;
        for(i = 0;i<props.length;i++){
            if(props[i].matchName == "ADBE FreePin3 PosPin Atom"){
                j++;
                child = props[i].property("ADBE FreePin3 PosPin Position");
                pos = [child.value[0],child.value[1]];
                nullLayer = app.project.activeItem.layers.addNull();
                nullLayer.name = "puppetCtrl"+j;
                nullLayer.position.setValue(pos);
                var expr = "thisComp.layer(\""+nullLayer.name+"\").toWorld(thisComp.layer(\""+nullLayer.name+"\").transform.anchorPoint)";
                child.expression = expr;
            }
        }
    }
    app.endUndoGroup();
}