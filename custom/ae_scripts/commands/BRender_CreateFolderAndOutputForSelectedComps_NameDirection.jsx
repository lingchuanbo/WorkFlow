BRender_CreateFolderAndOutputForSelectedComps_NameDirection();

function BRender_CreateFolderAndOutputForSelectedComps_NameDirection() {
    
    SPCreateFolderAndOutputForSelectedCompsNameDirection();
    
}
#include "./lib/render.jsx" //载入渲染函数
//~ function BRender_CreateFolderAndOutputForSelectedComps_AttackDirection() {
//~     //判断是否选中合成组 
//~     var proj = app.project;
//~     var curComp = app.project.activeItem;
//~       if (!curComp || !(curComp instanceof CompItem)) {
//~    // if (curComp instanceof CompItem) {
//~         
//~         alert('请选择合成组操作');
//~         
//~         return;
//~     } else {
//~         alert('xuanhao');
//~        // SPCreateFolderAndOutputForSelectedCompsAttackDirection();
//~     }
//~ }
//~ //判断是否合成组 素材类型
//~ function doSelectionComps() {
//~     for (var i = 0; i < app.project.selection.length; i++) {
//~         var activeItem = app.project.selection[i]; // = app.project.activeItem;
//~         if ((activeItem == null) || !(activeItem instanceof CompItem)) {
//~             alert('请选择合成组操作');
//~             return;
//~         } else {
//~             //var activeComp = activeItem;      
//~             alert('选中了');
//~             SPCreateFolderAndOutputForSelectedCompsAttackDirection();
//~         }
//~     }
//~ }
//~     //  #include "./lib/render.jsx" //载入渲染函数