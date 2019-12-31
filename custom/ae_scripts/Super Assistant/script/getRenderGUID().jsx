var comp = app.project.activeItem.layer(1).containingComp;
$.writeln(comp.getRenderGUID(0));   //参数1,只要是个object就输出合成或者层的hash值,参数2,只要是true就输出hash值的xml格式的计算过程