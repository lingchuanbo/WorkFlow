
	// app.beginUndoGroup("BlendingMode DIFFERENCE");
	myComp = app.project.activeItem;
	seLayers=myComp.selectedLayers; 
	for(i=0;i<seLayers.length;i++){
            var myEffect=seLayers[i].property("Effects").addProperty('滑块控制'); //添加特效
            myEffect.name="错开帧数"

            var myEffectTxt = "s= Math.round(effect('错开帧数')('滑块'))" + "\n" + 
            "" + "\n" + 
            "f = timeToFrames(time);" + "\n" + 
            "" + "\n" + 
            "d = timeToFrames(source.duration);" + "\n" + 
            "" + "\n" + 
            "framesToTime((s+f)%d);";
            // seLayers[i].transform.position.expression = 'loopOut("Cycle")';
            seLayers[i].timeRemapEnabled = true;
            seLayers[i].property("ADBE Time Remapping").expression = myEffectTxt
            //seLayers[i].timeRemapEnabled = false;
	}
	// app.endUndoGroup();