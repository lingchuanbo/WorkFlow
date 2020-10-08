//功能
//清理空项目 空组 未使用的素材 Solids
ReduceSolids();
RemoveUnusedSolids();
ReduceFootages();
RemoveUnusedFootages();
RemoveEmptyComps();
RemoveEmptyFolders();
alert("清理完成");

function ReduceSolids() {
    if (app.project.numItems > 0) {
        // if (){
        //     var includeName = false;
        // } else {
            var includeName = true;
        }
        var redundantSolids = 0;
        // app.beginUndoGroup((locAELang == "fr" ? "Réduire les Solides redondants" : "Reduce redundant Solids"));
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
        //alert((locAELang == "fr" ? "Solide(s) redondant(s) réduit(s) dans le projet : " + redundantSolids + "\rVous avez la possibilité d'annuler l'opération." : "Redundant Solid(s) reduced in the project : " + redundantSolids + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Solides redondants" : "Redundant Solids"));
    // } else {
    //     //alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Réduire les Solides redondants" : "Reduce redundant Solids"))
    // }
}

function RemoveUnusedSolids() {
    if (app.project.numItems > 0) {
        var removedSolids = 0;
        // app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Solides non-utilisés" : "Remove unused Solids"));
        for (var i = app.project.numItems; i >= 1; --i) {
            var curItem = app.project.item(i);
            if (curItem.mainSource instanceof SolidSource && curItem.usedIn.length == 0) {
                curItem.remove();
                removedSolids++;
            }
        }
        app.endUndoGroup();
        //alert((locAELang == "fr" ? "Solide(s) non utilisé(s) retiré(s) du projet : " + removedSolids + "\rVous avez la possibilité d'annuler l'opération." : "Unused Solid(s) removed from the project : " + removedSolids + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Solides non utilisés" : "Unused Solids"));
    } else {
        //alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Solides non-utilisés" : "Remove unused Solids"))
    }
}

function ReduceFootages() {
    if (app.project.numItems > 0) {
        var redundantFootages = 0;
        // app.beginUndoGroup((locAELang == "fr" ? "Réduire les Métrages redondants" : "Reduce redundant Footages"));
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
        //alert((locAELang == "fr" ? "Métrage(s) redondant(s) réduit(s) dans le projet : " + redundantFootages + "\rVous avez la possibilité d'annuler l'opération." : "Redundant Footage(s) reduced in the project : " + redundantFootages + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Métrages redondants" : "Redundant Footages"));
    } else {
        //alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Réduire les Métrages redondants" : "Reduce redundant Footages"))
    }
}

function RemoveUnusedFootages() {
    if (app.project.numItems > 0) {
        var removedFootages = 0;
        // app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Métrages non-utilisés" : "Remove unused Footages"));
        for (var i = app.project.numItems; i >= 1; --i) {
            var curItem = app.project.item(i);
            if (!(curItem.mainSource instanceof SolidSource) && curItem instanceof FootageItem && curItem.usedIn.length == 0) {
                curItem.remove();
                removedFootages++;
            }
        }
        app.endUndoGroup();
        //alert((locAELang == "fr" ? "Métrage(s) non utilisé(s) retiré(s) du projet : " + removedFootages + "\rVous avez la possibilité d'annuler l'opération." : "Unused Footage(s) removed from the project : " + removedFootages + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Métrages non utilisés" : "Unused Footages"));
    } else {
        //alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Métrages non-utilisés" : "Remove unused Footages"))
    }
}

function RemoveEmptyComps() {
    if (app.project.numItems > 0) {
        var removeEmptyComp = 0;
        // app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Compositions vides" : "Remove empty Compositions"));
        for (var i = app.project.numItems; i >= 1; --i) {
            var curItem = app.project.item(i);
            if (curItem instanceof CompItem && curItem.layers.length == 0) {
                curItem.remove();
                removeEmptyComp++;
            }
        }
        app.endUndoGroup();
        //alert((locAELang == "fr" ? "Composition(s) vide(s) retirée(s) du projet : " + removeEmptyComp + "\rVous avez la possibilité d'annuler l'opération." : "Empty Composition(s) removed from the project : " + removeEmptyComp + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Compositions vides" : "Empty Compositions"));
    } else {
        //alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Compositions vides" : "Remove empty Compositions"))
    }
}

function RemoveEmptyFolders() {
    if (app.project.numItems > 0) {
        var removeEmptyFolder = 0;
        // app.beginUndoGroup((locAELang == "fr" ? "Supprimer les Dossiers vides" : "Remove empty Folders"));
        for (var i = app.project.numItems; i >= 1; --i) {
            var curItem = app.project.item(i);
            if (curItem instanceof FolderItem && curItem.numItems == 0) {
                curItem.remove();
                removeEmptyFolder++;
            }
        }
        app.endUndoGroup();
        //alert((locAELang == "fr" ? "Dossier(s) vide(s) retirée(s) du projet : " + removeEmptyFolder + "\rVous avez la possibilité d'annuler l'opération." : "Empty Folder(s) removed from the project : " + removeEmptyFolder + "\rYou have the possibility to undo the operation."), (locAELang == "fr" ? "Dossiers vides" : "Empty Folders"));
    } else {
        //alert((locAELang == "fr" ? "Il n'y a aucun élément dans le projet !" : "There are no items in the project !"), (locAELang == "fr" ? "Supprimer les Dossiers vides" : "Remove empty Folders"))
    }
}
