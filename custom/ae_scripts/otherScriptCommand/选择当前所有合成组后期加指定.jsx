// simple script to select all comps in a selection or project

if (app.project.selection.length > 0) {
    var selection = app.project.selection;
    for (var i = 0; i < selection.length; i++) {
        if (selection[i] instanceof CompItem) selection[i].selected = true
        else selection[i].selected = false;
    }

} 
else if (app.project.items.length > 0){
    for (var i = 1; i <= app.project.items.length; i++) {
        if (app.project.items[i] instanceof CompItem) app.project.items[i].selected = true
        else app.project.items[i].selected = false;
    }
}