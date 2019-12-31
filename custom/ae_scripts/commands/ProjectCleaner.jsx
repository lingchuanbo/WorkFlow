{
	// Cleaner_by.BoBO
	// 版本：1.1
	// 清理多余固态层/素材
	// 清理未使用固态层/素材
	// 清理空合成组/文件夹

	// 更新日志
		//20180905  新增减少项目
	var locAELang = findLanguage();
    function findLanguage() {
        var langCode = "";
        switch (app.language) {
            case Language.ENGLISH:
                angCode = "en";
				break;
			case Language.CHINESE:
                angCode = "zh";
            break;
            case Language.FRENCH:
                langCode = "fr";
                break;
            case Language.GERMAN:
                langCode = "de";
                break;
            case Language.ITALIAN:
                langCode = "it";
                break;
            case Language.SPANISH:
                langCode = "es";
                break;
            default:
                break;
        }
        return langCode;
	}

	function ProjectCleaner(thisObj) {
		function buildUI(thisObj) {
			var panel = (thisObj instanceof Panel) ? thisObj : new Window("palette", "项目清理V1.0_by.BoBO", undefined, {
				resizeable: true
			});
			res = "group{orientation:'row',alignment:['center','fill'],\
					groupOne: Group{orientation:'column',alignment:['center','fill'],alignChildren:['fill','top'],\
						reduceSolidsBtn: Button{text:'多余固态层'},\
						reduceFootageBtn: Button{text:'多余素材'},\
						reduceProjectBtn: Button{text:'减少项目'},\
						Divider2: Panel{},\
						removeSolidsBtn: Button{text:'未使用固态层'},\
						removeFootageBtn: Button{text:'未使用素材'},\
						Divider3: Panel{},\
						removeCompBtn: Button{text:'空合成组'},\
						removeFolderBtn: Button{text:'空文件夹'},\
						buttonHelp: Button{text:'Help'},\
					},\
				}";
			panel.grp = panel.add(res);
			return panel;
		}
		// Called when a button is pressed, to invoke its associated script
		function onHelpButtonClick() {
			alert("帮助:\n\n" +
				"##用得开心就好！##\n\n" +
				"", "SPRenderQueueTools"
			);
		}

		function isSecurityPrefSet() {
			var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
			return (securitySetting == 1);
		}

		if (isSecurityPrefSet() == true) {
			//var myDirectory = Folder.current;
			//var scriptDirectory = new Folder(myDirectory.absoluteURI + "/(BOBOToolsFunctions)");
			// Create and show a floating palette
			//QuickAccess.jsxbin
			//var myPanel = new Window("palette","SPRenderQueueTools");
			var myPanel = buildUI(thisObj);
			myPanel.grp.groupOne.reduceSolidsBtn.onClick = ReduceSolids;
			myPanel.grp.groupOne.reduceFootageBtn.onClick = ReduceFootages;
			myPanel.grp.groupOne.reduceProjectBtn.onClick = ReduceProject;
			myPanel.grp.groupOne.removeSolidsBtn.onClick = RemoveUnusedSolids;
			myPanel.grp.groupOne.removeFootageBtn.onClick = RemoveUnusedFootages;
			myPanel.grp.groupOne.removeCompBtn.onClick = RemoveEmptyComps;
			myPanel.grp.groupOne.removeFolderBtn.onClick = RemoveEmptyFolders;
			myPanel.grp.groupOne.buttonHelp.onClick = onHelpButtonClick;

			//Seyp panel resizing
			myPanel.layout.layout(true);
			myPanel.grp.minimumSize = myPanel.grp.size;

			// Make panel resize still
			myPanel.layout.resize();
			myPanel.onResizing = myPanel.onResize = function () {
				this.layout.resize()
			};

			if ((myPanel != null) && (myPanel instanceof Window)) {
				myPanel.center();
				myPanel.show();
			}

		} else {
			alert("This demo requires the scripting security preference to be set.\nGo to the \"General\" panel of your application preferences, and make sure that \"Allow Scripts to Write Files and Access Network\" is checked.", "Demo Palette");
		}

		function ReduceSolids() {
			if (app.project.numItems > 0) {
				if (confirm((locAELang == "fr" ? "Ignorer le nom ?\r\rChoisir d'ignorer le nom permet un nettoyage en profondeur des Solides redondants dans le projet, peu importe le nom.\r\rSinon, choisir de ne pas ignorer le nom, seules les caractéristiques des Solides redondants seront prises en compte." : "Ignore the name ?\r\rChoose to ignore the name allows a thorough cleaning of redundant Solids in the project, regardless of the name.\r\rOtherwise, choose not to ignore the name, only the characteristics of redundant Solids will be taken into account."), (locAELang == "fr" ? "Réduire les Solides redondants" : "Reduce redundant Solids"))) {
					var includeName = false;
				} else {
					var includeName = true;
				}
				var redundantSolids = 0;
				app.beginUndoGroup((locAELang == "fr" ? "Réduire les Solides redondants" : "Reduce redundant Solids"));
				for (var i = 1; i < app.project.numItems; i += 1) {
					var curItem = app.project.item(i);
					if (curItem.mainSource instanceof SolidSource && curItem.usedIn.length != 0) {
						for (var j = app.project.numItems; j >= 1; --j) {
							var target = app.project.item(j);
							if (target.mainSource instanceof SolidSource && target.usedIn.length != 0 && target.id != curItem.id) {
								var SolidName = (includeName == true ? ((target.name == curItem.name ? true : false)) : true);
								var SolidColorR = (target.mainSource.color[0] == curItem.mainSource.color[0] ? true : false);
								var SolidColorG = (target.mainSource.color[1] == curItem.mainSource.color[1] ? true : false);
								var SolidColorB = (target.mainSource.color[2] == curItem.mainSource.color[2] ? true : false);
								var SolidWidth = (target.width == curItem.width ? true : false);
								var SolidHeight = (target.height == curItem.height ? true : false);
								var SolidPixelAspect = (target.pixelAspect == curItem.pixelAspect ? true : false);
								if (SolidName && SolidColorR && SolidColorG && SolidColorB && SolidWidth && SolidHeight && SolidPixelAspect) {
									redundantSolids++;
									var tab = [];
									for (var k = 0; k < target.usedIn.length; k += 1) {
										tab.push(target.usedIn[k]);
									}
									for (var k = 0; k < tab.length; k += 1) {
										try {
											for (var n = 1; n <= (tab[k]).layers.length; n += 1) {
												if ((tab[k]).layer(n).source instanceof FootageItem && (tab[k]).layer(n).source.name == target.name && (tab[k]).layer(n).source.id == target.id) {
													(tab[k]).layer(n).replaceSource(curItem, true);
												}
											}
										} catch (error) {

										}
									}
									target.remove();
								}
							}
						}
					}
				}
				app.endUndoGroup();
				alert((locAELang == "fr" ? "Solide(s) redondant(s) réduit(s) dans le projet : " + redundantSolids + "\rVous avez la possibilité d'annuler l'opération." : "Redundant Solid(s) reduced in the project : " + redundantSolids + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Solides redondants" : "Redundant Solids"));
			} else {
				alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Réduire les Solides redondants" : "Reduce redundant Solids"))
			}
		}

		function RemoveUnusedSolids() {
			if (app.project.numItems > 0) {
				var removedSolids = 0;
				app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Solides non-utilisés" : "Remove unused Solids"));
				for (var i = app.project.numItems; i >= 1; --i) {
					var curItem = app.project.item(i);
					if (curItem.mainSource instanceof SolidSource && curItem.usedIn.length == 0) {
						curItem.remove();
						removedSolids++;
					}
				}
				app.endUndoGroup();
				alert((locAELang == "fr" ? "Solide(s) non utilisé(s) retiré(s) du projet : " + removedSolids + "\rVous avez la possibilité d'annuler l'opération." : "Unused Solid(s) removed from the project : " + removedSolids + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Solides non utilisés" : "Unused Solids"));
			} else {
				alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Solides non-utilisés" : "Remove unused Solids"))
			}
		}

		function ReduceFootages() {
			if (app.project.numItems > 0) {
				var redundantFootages = 0;
				app.beginUndoGroup((locAELang == "fr" ? "Réduire les Métrages redondants" : "Reduce redundant Footages"));
				for (var i = 1; i < app.project.numItems; i += 1) {
					var curItem = app.project.item(i);
					if (!(curItem.mainSource instanceof SolidSource) && curItem instanceof FootageItem && curItem.usedIn.length != 0) {
						for (var j = app.project.numItems; j >= 1; --j) {
							var target = app.project.item(j);
							if (!(target.mainSource instanceof SolidSource) && target instanceof FootageItem && target.usedIn.length != 0 && target.id != curItem.id) {
								var FootageName = (target.name == curItem.name ? true : false);
								var FootageWidth = (target.width == curItem.width ? true : false);
								var FootageHeight = (target.height == curItem.height ? true : false);
								var FootagePixelAspect = (target.pixelAspect == curItem.pixelAspect ? true : false);
								var FootageIps = (target.frameRate == curItem.frameRate ? true : false);
								var FootageDuration = (target.duration == curItem.duration ? true : false);
								if (FootageName && FootageWidth && FootageHeight && FootagePixelAspect && FootageIps && FootageDuration) {
									redundantFootages++;
									var tab = [];
									for (var k = 0; k < target.usedIn.length; k += 1) {
										tab.push(target.usedIn[k]);
									}
									for (var k = 0; k < tab.length; k += 1) {
										try {
											for (var n = 1; n <= (tab[k]).layers.length; n += 1) {
												if ((tab[k]).layer(n).source instanceof FootageItem && (tab[k]).layer(n).source.name == target.name && (tab[k]).layer(n).source.id == target.id) {
													(tab[k]).layer(n).replaceSource(curItem, true);
												}
											}
										} catch (error) {

										}
									}
									target.remove();
								}
							}
						}
					}
				}
				app.endUndoGroup();
				alert((locAELang == "fr" ? "Métrage(s) redondant(s) réduit(s) dans le projet : " + redundantFootages + "\rVous avez la possibilité d'annuler l'opération." : "Redundant Footage(s) reduced in the project : " + redundantFootages + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Métrages redondants" : "Redundant Footages"));
			} else {
				alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Réduire les Métrages redondants" : "Reduce redundant Footages"))
			}
		}

		function RemoveUnusedFootages() {
			if (app.project.numItems > 0) {
				var removedFootages = 0;
				app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Métrages non-utilisés" : "Remove unused Footages"));
				for (var i = app.project.numItems; i >= 1; --i) {
					var curItem = app.project.item(i);
					if (!(curItem.mainSource instanceof SolidSource) && curItem instanceof FootageItem && curItem.usedIn.length == 0) {
						curItem.remove();
						removedFootages++;
					}
				}
				app.endUndoGroup();
				alert((locAELang == "fr" ? "Métrage(s) non utilisé(s) retiré(s) du projet : " + removedFootages + "\rVous avez la possibilité d'annuler l'opération." : "Unused Footage(s) removed from the project : " + removedFootages + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Métrages non utilisés" : "Unused Footages"));
			} else {
				alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Métrages non-utilisés" : "Remove unused Footages"))
			}
		}

		function RemoveEmptyComps() {
			if (app.project.numItems > 0) {
				var removeEmptyComp = 0;
				app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Compositions vides" : "Remove empty Compositions"));
				for (var i = app.project.numItems; i >= 1; --i) {
					var curItem = app.project.item(i);
					if (curItem instanceof CompItem && curItem.layers.length == 0) {
						curItem.remove();
						removeEmptyComp++;
					}
				}
				app.endUndoGroup();
				alert((locAELang == "fr" ? "Composition(s) vide(s) retirée(s) du projet : " + removeEmptyComp + "\rVous avez la possibilité d'annuler l'opération." : "Empty Composition(s) removed from the project : " + removeEmptyComp + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Compositions vides" : "Empty Compositions"));
			} else {
				alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Compositions vides" : "Remove empty Compositions"))
			}
		}

		function RemoveEmptyFolders() {
			if (app.project.numItems > 0) {
				var removeEmptyFolder = 0;
				app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Dossiers vides" : "Remove empty Folders"));
				for (var i = app.project.numItems; i >= 1; --i) {
					var curItem = app.project.item(i);
					if (curItem instanceof FolderItem && curItem.numItems == 0) {
						curItem.remove();
						removeEmptyFolder++;
					}
				}
				app.endUndoGroup();
				alert((locAELang == "fr" ? "Dossier(s) vide(s) retirée(s) du projet : " + removeEmptyFolder + "\rVous avez la possibilité d'annuler l'opération." : "Empty Folder(s) removed from the project : " + removeEmptyFolder + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Dossiers vides" : "Empty Folders"));
			} else {
				alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Dossiers vides" : "Remove empty Folders"))
			}
		}

		function ReduceProject(){
			//ReduceProject
			var currentComp;
			function selComp(){
				currentComp=app.project.activeItem;
				if(currentComp instanceof CompItem){
					return true;
				}else{
					alert ("请选择合成");
					return false;
						}
				}
				if(selComp()){
					app.project.reduceProject(currentComp);
					alert ("OK！！！！");
			}
		}
	}
	ProjectCleaner(this);
}