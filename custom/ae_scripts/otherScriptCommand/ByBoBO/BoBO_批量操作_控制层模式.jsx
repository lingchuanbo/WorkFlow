//批操作_复制图层并添加属性
//BoBO
//20191113
//批操作
//
var selectedItems = app.project.selection;

for (var i = 0, len = selectedItems.length; i < len; i++) {

     var item = selectedItems[i];

     var myLayer = 3 ; 

     item.layer(myLayer).blendingMode = BlendingMode.ADD; //设置层模式 这是图层模式 比如add

     //item.layer(myLayer).remove();
}
//BlendingMode.NORMAL
// BlendingMode.ADD
// BlendingMode.ALPHA_ADD
// BlendingMode.CLASSIC_COLOR_BURN
// BlendingMode.CLASSIC_COLOR_DODGE
// BlendingMode.CLASSIC_DIFFERENCE
// BlendingMode.COLOR
// BlendingMode.COLOR_BURN
// BlendingMode.COLOR_DODGE
// BlendingMode.DANCING_DISSOLVE
// BlendingMode.DARKEN
// BlendingMode.DARKER_COLOR
// BlendingMode.DIFFERENCE
// BlendingMode.DISSOLVE
// BlendingMode.EXCLUSION
// BlendingMode.HARD_LIGHT
// BlendingMode.HARD_MIX
// BlendingMode.HUE
// BlendingMode.LIGHTEN
// BlendingMode.LIGHTER_COLOR
// BlendingMode.LINEAR_BURN
// BlendingMode.LINEAR_DODGE
// BlendingMode.LINEAR_LIGHT
// BlendingMode.LUMINESCENT_PREMUL
// BlendingMode.LUMINOSITY
// BlendingMode.MULTIPLY
// BlendingMode.NORMAL
// BlendingMode.OVERLAY
// BlendingMode.PIN_LIGHT
// BlendingMode.SATURATION
// BlendingMode.SCREEN
// BlendingMode.SILHOUETE_ALPHA
// BlendingMode.SILHOUETTE_LUMA
// BlendingMode.SOFT_LIGHT
// BlendingMode.STENCIL_ALPHA
// BlendingMode.STENCIL_LUMA
// BlendingMode.VIVID_LIGHT