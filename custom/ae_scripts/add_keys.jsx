add2Keys();	
//--------------------------------------//
			function add2Keys(){
				app.beginUndoGroup("Add Keys");
				var myComp = app.project.activeItem;
				var seLayers=myComp.selectedLayers;

				for(var x=0; x<seLayers.length ; x++){//colect all selected properties

					for(var y=0 ; y<seLayers[x].selectedProperties.length ; y++){
						//skip when select property is propertyGroup
						if(seLayers[x].selectedProperties[y].propertyType  == PropertyType.NAMED_GROUP) continue;
						
						var selProp =seLayers[x].selectedProperties[y];
						if(selProp.canVaryOverTime ===true){
							var newKey = selProp.addKey(myComp.time);
							//selProp.setSelectedAtKey(newKey, true);
						}
					}
				}
				app.endUndoGroup();
			}//end add2keys
