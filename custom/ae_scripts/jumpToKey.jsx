 function jumpKey(){
            app.beginUndoGroup("preComp eachComp");
            var myComp = app.project.activeItem;
            var keyTimeArr =[];
            var selectedLayers = myComp.selectedLayers;

	       if(selectedLayers.length > 0){
               var selProp = selectedLayers[0].selectedProperties;
               var keys,keyTime;
               for(var i=0,l=selProp.length; i<l;i++){
                    if(selProp[i].numKeys !=0 && selProp[i].propertyType ==PropertyType.PROPERTY){
                        keys = selProp[i].selectedKeys[0];
                        keyTime=selProp[i].keyTime(keys);
                    }
               }   
            }
            myComp.time = keyTime;
            app.endUndoGroup();
        }
        
jumpKey();