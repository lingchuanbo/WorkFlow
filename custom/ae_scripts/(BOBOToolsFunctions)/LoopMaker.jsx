var preCompSuffix = "_looped";
var multiLayerPreCompName = "Looped Comp";
var loopDissolveLength = 60;
var promptForDissolveLength = false;
var useBlendEffect = true;
var scriptTitle = "循环工具™";
var scriptVersion = "1.7";
var tlm_data = new Object();
$.localize = true;
tlm_data.dissolveLengthText = {
    //en: "Loop dissolve length (in frames)",
    en: "循环溶解长度（以帧为单位）",
    es: "Duración del disuelvo del ciclo (en marcos)",
    fr: "Durée du fondu de la boucle (en images)",
    de: "Länge der Loop-Überblendung (in Frames)",
    ja: "ループディゾルブの長さ(フレーム指定)",
    ko: "루프 디 졸브의 길 이(프레임 지정)",
    it: "Lunghezza dissolvenza Loop (in frames)"
};
tlm_data.useBlendEffectBtn = {
    //en: "Use blend effect",
    en: "使用混合特效",
    es: "Usar efecto \"Fusionar\"",
    fr: "Utiliser l\\'effet de fusion",
    de: "Benutze Überblendungseffekt",
    ja: "ブレンドエフェクトを使用",
    ko: "브 랜드 이펙트를 사용",
    it: "Utilizza effetto fusione"
};
tlm_data.loopButtonText = {
    //en: "Loop!",
    en: "循环!",
    es: "Loop!",
    fr: "Boucler!",
    de: "Loop!",
    ja: "ループ！",
    ko: "루 프!",
    it: "Loop!"
};
tlm_data.useBlendEffectHelp = {
    //en: "Use the blend effect for the loop dissolve transition. The blend effect creates a more filmic look but takes longer to render.  If this option is off, layer opacity will be used instead.",
    en: "使用混合效果进行循环溶解过渡。混合效果会产生更多的电影外观，但渲染时间会更长。如果禁用此选项，则将使用图层不透明度。",
    es: "Usar el efecto \"Fusionar\" para el disuelvo del ciclo. El efecto \"Fusionar\" crea un resultado más fílmico pero se tarda mas en procesar.  Si esta opción no esta elegida se usará la opacidad de la capa.",
    fr: "Utilisez l'effet de fusion pour la transition en fondu de la boucle. L'effet de fusion donne un rendu plus cinématographique mais demande plus de temps de rendu. Si cette option est désactivée, l'opacité du calque sera utilisé à la place.",
    de: "Benutze den Überblendungseffekt für die Loop-Überblendung. Der Überblendungseffekt schafft einen mehr filmischen Look aber braucht länger zum Rendern. Wenn die Option deaktiviert ist, wird statt dessen die Transparenz der Ebene verwendet.",
    ja: "ループディゾルブのトランジションにブレンドエフェクトを使用します。ブレンドエ フェクトを使用するとより映画的表現になりますが、レンダリングに少し 時間がかかります。オプションがオフの場合は代わりに透明度を使用します。",
    ko: "루프 디 졸브의 트 렌지션에 브랜드 이 펙트를 사 용합니다. 브랜드 효 과를 사 용하면 보다 영 화적 표 현이 되지만, 렌 더링에 조 금 더 시 간이 걸 립니다. 옵션이 오 프된 경 우에는 대신에 투 명도를 사 용합니다.",
    it: "Usa l’effetto fusione per la transizione a dissolvenza del loop. L’effetto fusione crea un aspetto cinematografico ma impiega più tempo nel renderizzare. Se questa opzione è disabilitata, la trasparenza del livello sarà utilizzata al suo posto. "
};
tlm_data.dissolveLengthPrompt = {
    //en: "How long would you like the loop dissolve length to be?\n(Please enter the amount in frames)",
    en: "你想要循环溶解长度多长时间？ \n (请输入帧数)",
    es: "¿Cuánto tiempo debe ser el disuelvo del ciclo?\n(Cantidad en marcos)",
    fr: "De quelle longueur souhaitez vous le fondu de la boucle ?\n(Entrez la durée en images)",
    de: "Wie lang soll die Länge der Loop-Überblendung sein?\n(Bitte geben Sie die Dauer in Frames an)",
    ja: "ループ時のディゾルブの長さはいくつにしますか？\n(フレーム数を指定してください)",
    ko: "루프를 적 용할때 디 졸브의 길이는 몇 프레임으로 하시겠습니까?\n(프 레임수를 지 정해 주세요)",
    it: "Quanto vorresti lunga la dissolvenza del loop?\n(Inserire il numero di frames)"
};
tlm_data.selectLayersError = {
    //en: "Please select the layer(s) you would like to loop",
    en: "请选择您要循环的图层",
    es: "Por favor, seleccione la capa (s) que desea circular",
    fr: "Sélectionnez le ou les calques à faire boucler",
    de: "Bitte selektieren Sie die Ebene(n), die geloopt werden sollen",
    ja: "ループさせたいレイヤーを選択してください",
    ko: "루프 시 키고 싶 은 레이어를 선택해 주세요",
    it: "Selezionare il/I livello/I da far diventare loop"
};
tlm_data.selectCompError = {
    //en: "Please select the comp you would like to work in",
    en: "请选择合成进行工作",
    es: "Por favor seleccione la composición en que le gustaría trabajar",
    fr: "Sélectionnez la composition avec laquelle vous souhaitez travailler",
    de: "Bitte selektieren Sie die Komposition, in der Sie arbeiten möchten.",
    ja: "適用させたいコンポジションを選択してください",
    ko: "적 용시키고 싶은 컴 포지션을 선 택해 주세요",
    it: "Selezionare la composizione che si desidera utilizzare."
};
tlm_data.dissolveTooLongError = {
    //en: "The dissolve length is too long for the duration of the selected footage\nPlease enter a new dissolve length shorter than %1 frames",
    en: "在所选素材的持续时间内，溶解长度太长\n请输入短于 %1 帧的新溶解长度",
    es: "El tiempo del disuelvo del ciclo es demasiado largo para la duración de las imágenes seleccionadas\nPor favor, introduzca un tiempo inferior a %1 marcos",
    fr: "La durée de fondue est trop longue par rapport à la durée du métrage sélectionné\nEntrez une nouvelle durée plus courte d'au moins %1 image(s)",
    de: "Die Überblendungslänge ist zu lang für die Dauer der gewählten Filmmaterials.\nBitte geben Sie eine neue Überblendungslänge kürzer als einen Frame an.",
    ja: "ディゾルブの長さが選択されたフッテージに対して長すぎます\n新しくディゾルブの長さを、%1 フレームより短い数値で入力してください",
    ko: "선 택된 영상의 디졸브의 길이가 너무 깊니다.\n새 로운 디 졸브의 길이를,%1 프 레임보다 짧은 수치로 입력해 주세요",
    it: "La lunghezza di dissolvenza è troppo lunga per la durata della clip selezionata.\nInserire una lunghezza di dissolvenza più corta di %1 frames"
};
tlm_data.setTimeRemapError = {
    //en: "Error setting timeRemap for Loop Comp",
    en: "设置Loop Comp的timeRemap时出错",
    es: "Error estableciendo remapeo de tiempo para la composición de ciclo",
    fr: "Erreur lors de l'initialisation du remappage temporel de la composition à boucler",
    de: "Fehler beim Setzen von timeRemap für die Loop-Komposition.",
    ja: "ループコンポジションのタイムリマップ設定エラー",
    ko: "루 프 컴포지션의 타 임리맵 설 정 에러",
    it: "Errore impostazioni Modifica Tempo per la Composizione Loop"
};
tlm_data.beyondBoundsError = {
    //en: "One of more of the selected layers go beyond the bounds of the comp.  Layers will be trimmed to the comp duration.",
    en: "一个或多个选定的图层超出了comp的范围。图层将被修剪为补偿持续时间。",
    es: "Una o más de las capas seleccionadas van más allá de los límites de la composición. Las capas se van a recortar a la duración de la composición.",
    fr: "Un, ou plusieurs calques sélectionnés dépassent le point de sortie de la composition. Le ou les calques seront rognés à la durée de la composition.",
    de: "Eine oder mehrere der ausgewählten Ebenen gehen über die Grenzen der Komposition hinweg. Die Ebenen werden auf die Dauer der Komposition getrimmt.",
    ja: "コンポジションの領域を超えているレイヤーがあります。それらはコンポジションのデュレーションでトリミングされます。",
    ko: "포 지션의 길이보다 긴 레 이어가 있습니다. 그 레 이어들은  컴 포지션의 길 이에 맞추어 트 리밍 됩 니다. ",
    it: "Uno o più dei livelli selezionati supera la durata della composizione. I livelli verranno tranciati alla durata della composizione"
};
tlm_data.loopTypes = {
    en: "[\"cycle\",\"ping-pong\",\"freeze\"]"
};

function buildUI(thisObj) {
    if (thisObj instanceof Panel) {
        var myPal = thisObj;
    } else {
        var myPal = new Window("palette", scriptTitle + " " + scriptVersion, undefined, {
            resizeable: false
        });
    }
    if (myPal != null) {
        var res = "group { \n\t\t\t\t\torientation: 'column', \n\t\t\t\t\talignment:['left','top'], \n\t\t\t\t\talignChildren:['left','top'], \n\t\t\t\t\tlength: Group { \n\t\t\t\t\t\torientation: 'row', \n\t\t\t\t\t\tdissolveLengthTxt: StaticText {text:'" + tlm_localize(tlm_data.dissolveLengthText) + "'}, \n\t\t\t\t\t\tdissolveLength: EditText {preferredSize:[50,20]}, \n                           loopType: DropDownList {properties:{items:" + tlm_localize(tlm_data.loopTypes) + "},preferredSize:[90,20]}, \n\t\t\t\t\t} \n                       useBlendEffect: Checkbox{text:'" + tlm_localize(tlm_data.useBlendEffectBtn) + "'}, \n\t\t\t\t\tloopBtn: Button {text:'" + tlm_localize(tlm_data.loopButtonText) + "', alignment: ['right','top'],preferredSize:[90,30]} , \n\t\t\t\t}";
        myPal.grp = myPal.add(res);
        myPal.layout.layout(true);
        myPal.grp.length.dissolveLengthTxt.helpTip = tlm_localize(tlm_data.dissolveLengthPrompt);
        myPal.grp.length.dissolveLength.helpTip = tlm_localize(tlm_data.dissolveLengthPrompt);
        myPal.grp.useBlendEffect.helpTip = tlm_localize(tlm_data.useBlendEffectHelp);
        myPal.grp.length.dissolveLength.text = loopDissolveLength;
        myPal.grp.length.dissolveLength.onChange = function () {
            loopDissolveLength = parseFloat(this.text);
        };
        myPal.grp.length.loopType.selection = 0;
        myPal.grp.length.loopType.onChange = function () {
            myPal.grp.length.dissolveLength.enabled = myPal.grp.length.dissolveLengthTxt.enabled = myPal.grp.useBlendEffect.enabled = this.selection == 0;
        };
        myPal.grp.useBlendEffect.value = useBlendEffect;
        myPal.grp.loopBtn.onClick = function () {
            preFlight(myPal);
        };
    }
    return myPal;
}

function findInAndOut(selLayers, check) {
    var myComp = app.project.activeItem;
    var myIn = myComp.duration;
    var myOut = 0;
    for (var i = 0; i < selLayers.length; i += 1) {
        var curLayer = selLayers[i];
        var curLayerIn = (curLayer.stretch < 0 ? curLayer.outPoint : curLayer.inPoint);
        var curLayerOut = (curLayer.stretch < 0 ? curLayer.inPoint : curLayer.outPoint);
        myIn = (curLayerIn < myIn ? curLayerIn : myIn);
        myOut = (curLayerOut > myOut ? curLayerOut : myOut);
    }
    if (myIn < 0 || myOut > myComp.duration) {
        if (check) {
            alert(tlm_data.beyondBoundsError)
        }
        myIn = 0;
        myOut = myComp.duration;
    }
    return [myIn, myOut];
}

function shiftLayers(selLayers, shiftAmount) {
    for (var i = 0; i < selLayers.length; i += 1) {
        (selLayers[i]).startTime += shiftAmount;
    }
}

function makeTrimmedPreComp(selLayers, name) {
    var myComp = app.project.activeItem;
    var myIndicies = new Array();
    for (var i = 0; i < selLayers.length; i += 1) {
        myIndicies[i] = (selLayers[i]).index;
    }
    var InOut = findInAndOut(selLayers, false);
    var preComp = myComp.layers.precompose(myIndicies, name, true);
    preComp.duration = InOut[1] - InOut[0];
    var preCompLayer = app.project.activeItem.selectedLayers[0];
    preCompLayer.startTime = InOut[0];
    preCompLayer.outPoint = InOut[1];
    for (var p = 1; p <= preComp.numLayers; p += 1) {
        preComp.layer(p).startTime -= InOut[0];
    }
    return [preComp, preCompLayer];
}

function makeLoop(palObj, selLayers) {
    useBlendEffect = palObj.grp.useBlendEffect.value;
    var loopType = palObj.grp.length.loopType.selection.text.replace(/-/g, "");
    var doDissolve = palObj.grp.length.loopType.selection == 0;
    var myComp = app.project.activeItem;
    var preCompName = (selLayers.length != 1 ? multiLayerPreCompName : selLayers[0].name + preCompSuffix);
    if (parseFloat(app.version) < 9) {
        var preCompName = (selLayers.length != 1 ? multiLayerPreCompName.substring(0, 31) : selLayers[0].name.substring(0, 31 - preCompSuffix.length) + preCompSuffix);
    }
    var myLayer = (selLayers.length != 1 || selLayers.length == 1 && selLayers[0].stretch != 100 || selLayers[0].opacity.expressionEnabled || selLayers[0].opacity.numKeys > 0 || selLayers[0].property("Effects") == null || selLayers[0].property("Effects") != null && selLayers[0].property("Effects").numProperties > 0 && useBlendEffect || selLayers[0].position.numKeys > 0 || selLayers[0].scale.numKeys > 0 || selLayers[0].rotation.numKeys > 0 || selLayers[0].anchorPoint.numKeys > 0 && useBlendEffect ? makeTrimmedPreComp(selLayers, multiLayerPreCompName + "_precomp")[1] : selLayers[0]);
    var loopPreComp = makeTrimmedPreComp([myLayer], preCompName);
    var mainLayer = loopPreComp[0].layer(1);
    if (doDissolve) {
        var dupLayer = mainLayer.duplicate();
        var dissolveLength = loopDissolveLength / loopPreComp[0].frameRate;
        dupLayer.outPoint = dissolveLength + (1 / loopPreComp[0].frameRate);
        var saveMainLayerOut = mainLayer.outPoint;
        mainLayer.inPoint = dissolveLength;
        mainLayer.outPoint = saveMainLayerOut;
        mainLayer.startTime -= dissolveLength;
        dupLayer.startTime = ((mainLayer.outPoint - dissolveLength) - (dupLayer.inPoint - dupLayer.startTime)) - (1 / loopPreComp[0].frameRate);
        if (!useBlendEffect) {
            dupLayer.opacity.setValueAtTime(dupLayer.inPoint, 0);
            dupLayer.opacity.setValueAtTime(dupLayer.outPoint - (1 / loopPreComp[0].frameRate), 100);
        } else {
            var myBlendEffect = dupLayer.property("ADBE Effect Parade").addProperty("ADBE Blend");
            myBlendEffect.property("ADBE Blend-0001").setValue(2);
            myBlendEffect.property("ADBE Blend-0002").setValue(1);
            myBlendEffect.property("ADBE Blend-0003").setValueAtTime(dupLayer.inPoint, 0);
            myBlendEffect.property("ADBE Blend-0003").setValueAtTime(dupLayer.outPoint - (1 / loopPreComp[0].frameRate), 1);
            mainLayer.outPoint = dupLayer.inPoint;
        }
        loopPreComp[0].duration = dupLayer.outPoint;
    } else {
        loopPreComp[0].duration = mainLayer.outPoint;
    }
    if (loopPreComp[1].canSetTimeRemapEnabled) {
        loopPreComp[1].timeRemapEnabled = true;
        loopPreComp[1].timeRemap.expression = (loopType == "freeze" ? "" : "(time <= key(1).time) ? loopIn('" + loopType + "') : loopOut('" + loopType + "')");
        var secondKeyValueMinus1Frame = loopPreComp[1].timeRemap.valueAtTime(loopPreComp[1].timeRemap.keyTime(2) - (1 / myComp.frameRate), true);
        loopPreComp[1].timeRemap.setValueAtTime(loopPreComp[1].timeRemap.keyTime(2) - (1 / myComp.frameRate), secondKeyValueMinus1Frame);
        if (loopPreComp[1].timeRemap.numKeys > 2) {
            loopPreComp[1].timeRemap.removeKey(3)
        }
    } else {
        alert(tlm_data.setTimeRemapError);
    }
}

function tlm_localize(strVar, rplVar) {
    if (rplVar == undefined) {
        rplVar = ""
    }
    if (parseFloat(app.version) < 9) {
        var localLang = $.locale
    } else {
        var localLang = app.isoLanguage
    }
    if (typeof strVar[localLang.substring(0, localLang.indexOf("_"))] == "undefined") {
        var langStr = strVar.en.replace("%1", rplVar)
    } else {
        var langStr = (strVar[localLang.substring(0, localLang.indexOf("_"))]).replace("%1", rplVar)
    }
    return langStr;
}

function promptForNewDissolveLength(checkLength, myComp) {
    var newDissolveLength = prompt(tlm_localize(tlm_data.dissolveTooLongError, Math.floor(((checkLength[1] - checkLength[0]) * myComp.frameRate) / 2)), Math.floor(((checkLength[1] - checkLength[0]) * myComp.frameRate) / 4));
    if (newDissolveLength) {
        if (newDissolveLength >= (((checkLength[1] - checkLength[0]) * myComp.frameRate) / 2)) {
            var newDissolveLength = promptForNewDissolveLength(checkLength, myComp);
        }
        return newDissolveLength;
    } else {
        return false;
    }
}

function preFlight(palObj) {
    loopDissolveLength = parseInt(palObj.grp.length.dissolveLength.text, 10);
    var myComp = app.project.activeItem;
    if (!myComp || !(myComp instanceof CompItem)) {
        alert(tlm_localize(tlm_data.selectCompError));
        return;
    }
    var selLayers = app.project.activeItem.selectedLayers;
    if (selLayers.length == 0) {
        alert(tlm_localize(tlm_data.selectLayersError));
        return;
    }
    clearOutput();
    app.beginUndoGroup(scriptTitle);
    if (promptForDissolveLength) {
        var newDissolveLength = prompt(tlm_localize(tlm_data.dissolveLengthPrompt), loopDissolveLength);
        if (newDissolveLength) {
            loopDissolveLength = newDissolveLength
        } else {
            return;
        }
    }
    var checkLength = findInAndOut(selLayers, true);
    if (palObj.grp.length.loopType.selection == 0 && loopDissolveLength >= (((checkLength[1] - checkLength[0]) * myComp.frameRate) / 2)) {
        var newDissolveLength = promptForNewDissolveLength(checkLength, myComp);
        if (newDissolveLength != false) {
            loopDissolveLength = newDissolveLength;
        } else {
            return;
        }
    }
    makeLoop(palObj, selLayers);
}
var myPalette = buildUI(this);
if (myPalette != null && myPalette instanceof Window) {
    myPalette.show();
}