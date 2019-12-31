{
// SPRenderQueueTools.jsx
// 重新规整说明功能定义
// This script creates and shows a floating palette.
// The floating palette contains buttons that launch a variety of
// render queue scripts.

function SPRenderQueueTools(thisObj)
{
	function buildUI(thisObj) {
		var panel = (thisObj instanceof Panel) ? thisObj : new Window("palette","RenderTools_ByBoBO v_0.1",undefined, {resizeable:true});
		res = "group{orientation:'row',alignment:['center','fill'],\
					groupOne: Group{orientation:'column',alignment:['center','fill'],alignChildren:['fill','top'],\
						button1: Button{},\
						button2: Button{},\
						button3: Button{},\
                           Divider1: Panel{},\
						button4: Button{},\
						button5: Button{},\
						Divider2: Panel{},\
						button6: Button{},\
						button7: Button{},\
						Divider3: Panel{},\
						button8: Button{},\
						button9: Button{},\
						button10: Button{},\
						Divider4: Panel{},\
						buttonHelp: Button{text:'?'},\
					},\
				}";
		
		panel.grp = panel.add(res);
		return panel;
	}
	// Called when a button is pressed, to invoke its associated script
	function onHelpButtonClick() {
		alert("使用帮助:\n\n"  +

                           "【选择渲染目录 P:合成名】\n"+
                           "##在项目窗口选择合成组. 以合成组名创建目录输出.\n\n"+
                           
                            "【选择渲染目录 P:动作/方向】\n"+
                            "##在项目窗口选择合成组. 注意此功能合成组命名规则必须是##_方向_动作名.比如.\n"+
                            "a01_北_attack1\n"+
                            "a02_北_attack2\n"+
                            "... ..."+
                            "创建目录结构 【.../动作名/方向】\n\n"+
                            "\n" +
                            
                            "【选择渲染目录 P:按数字/动作/方向】\n"+
                             "##在项目窗口选择合成组. 注意此功能合成组命名规则必须是 数字_方向_动作名.比如.\n"+
                            "1_北_attack1\n"+
                            "11_北_attack2\n"+
                            "... ..."+
                            "创建目录结构 【...数字/动作名/方向】\n\n"+
                            "\n" +

                            "【改变输出目录 P:按合成名】\n"+
                              "##在渲染列队. 单选或多选,目录以合成组名.\n\n"+
                            "【改变输出目录 P:按动作/方向】\n"+
                             "##在渲染列队. 单选或多选,目录以动作/方向命名.\n\n"+


                            "在渲染列队单独创建目录输出\n\n"+
                            "在渲染列队增加代理模块输出\n\n"+

                            "在渲染列队设置输出模板\n\n"+
                            "在合成组中单层渲染输出\n\n"+

                            "渲染模版\n\n"+
			"\n" +
			"", "SPRenderQueueTools"
			  );
	}

	// Called when a button is pressed, to invoke its associated script
	function onScriptButtonClick() {
		var prevCurrentFolder = Folder.current;
		Folder.current = this.currentDirectory;

		// The scriptFile variable was set during addButton.
		// Run the script by opening it, reading it, and evaluating its contents.
		var scriptFile = new File(this.scriptFileName);
		scriptFile.open();
		eval(scriptFile.read());
		scriptFile.close();

		Folder.current = prevCurrentFolder;
	}

	// This function adds a new script-launching button to the palette
	function setScriptButton(button, buttonLabel, buttonCurrentDirectory, buttonScriptName) {
		// JavaScript has an unusual but useful bit of functionality.
		// You can just assign a value to a new variable name and JS will
		// store it for you. The lines below create new variables named
		// scriptName and currentDirectory within button, and sets them
		// to buttonScriptName and myCurrentDirectory.
		// Later, in the onButtonClick() callback, the button will first
		// re-establish the current directory, then load and
		// run that file.
		button.text = buttonLabel;
		button.scriptFileName  = buttonScriptName;
		button.currentDirectory = buttonCurrentDirectory;

		button.onClick = onScriptButtonClick;
	}

	function isSecurityPrefSet() {
		var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
		return (securitySetting == 1);
	}

	if (isSecurityPrefSet() == true) {
		//
		// Save the value of the current directory.
		// -- In some cases, the current directory value is lost when button and other
		// callbacks are invoked from a floating palette.
		// -- Some of the buttons in the demo palette need to read other script
		// files.  The most convenient notation for the filenames is to specify them
		// relative to the current directory. And if the current directory is set wrong,
		// then the nested scripts will fail to run correctly.
		// -- to fix this, save the current directory now, and make sure to 
		// re-establish it during onScriptButtonClick(). This will insure that the 
		// files run during onScriptButtonCl
		var myDirectory = Folder.current;
		var scriptDirectory = new Folder(myDirectory.absoluteURI+"");

		// Create and show a floating palette
		//
		//var myPanel = new Window("palette","SPRenderQueueTools");
		var myPanel = buildUI(thisObj);



		setScriptButton(myPanel.grp.groupOne.button1, "选择渲染目录 P:合成名",  scriptDirectory, "SPCreateFolderAndOutputForSelectedComps.jsx");
         setScriptButton(myPanel.grp.groupOne.button2, "选择渲染目录 P:动作/方向", scriptDirectory, "BRender_CreateFolderAndOutputForSelectedComps_AttackDirection.jsx");
         setScriptButton(myPanel.grp.groupOne.button3, "选择渲染目录 P:按数字/动作/方向", scriptDirectory, "Render_B_SPCreateFolderAndOutputForSelectedComps2.jsx");
        

         setScriptButton(myPanel.grp.groupOne.button4, "改变输出目录 P:按合成名", scriptDirectory, "SPChangeRenderLocations.jsx");
         setScriptButton(myPanel.grp.groupOne.button5, "改变输出目录 P:按动作/方向",  scriptDirectory, "Render_B_SPChangeRenderLocations.jsx");	    
        
        
		setScriptButton(myPanel.grp.groupOne.button6, "在渲染列队单独创建目录输出",  scriptDirectory, "SPCreateFolderForRenderQueueSequences.jsx");
		setScriptButton(myPanel.grp.groupOne.button7, "在渲染列队增加代理模块输出", scriptDirectory, "SPAddProxyModuleToRenderQueueItems.jsx");

		setScriptButton(myPanel.grp.groupOne.button8, "在渲染列队设置输出模板", scriptDirectory, "SPSetTemplateOfOutputModuleN.jsx");   
         setScriptButton(myPanel.grp.groupOne.button9, "分层渲染", scriptDirectory, "SPRenderLayers.jsx");
		setScriptButton(myPanel.grp.groupOne.button10, "渲染模版",  scriptDirectory, "AED_RenderTemplates.jsx");	
        //setScriptButton(myPanel.grp.groupOne.button9, "合成名渲染输出", scriptDirectory, "Render_B_SPChangeRenderLocations2.jsx");
        //setScriptButton(myPanel.grp.groupOne.button6, "Create WIP render for selected comps",  scriptDirectory, "SPCreateWipRenderForSelectedComps.jsxbin");
		//setScriptButton(myPanel.grp.groupOne.button7, "Update WIP items in render queue",  scriptDirectory, "SPUpdateWipItemsInRenderQueue.jsx");
		myPanel.grp.groupOne.buttonHelp.onClick = onHelpButtonClick;

		//Seyp panel resizing
		myPanel.layout.layout(true);
		myPanel.grp.minimumSize = myPanel.grp.size;
		
		// Make panel resize still
		myPanel.layout.resize();
		myPanel.onResizing = myPanel.onResize = function(){this.layout.resize()};

		if (( myPanel != null) && (myPanel instanceof Window)){
			myPanel.center();
			myPanel.show();
		}
	
	} else {
		alert ("This demo requires the scripting security preference to be set.\nGo to the \"General\" panel of your application preferences, and make sure that \"Allow Scripts to Write Files and Access Network\" is checked.", "Demo Palette");
	}
}


SPRenderQueueTools(this);
}
