{
	// BoBO_Tools.jsx
	// 感谢原作者大力支持https://github.com/spinifexgroup-studio/studio_pipeline/tree/master/ae_scripts_develop
	// This script creates and shows a floating palette.
	// The floating palette contains buttons that launch a variety of
	// 对输出做了创建做了调整
	// 集合一些自己便捷工具
	// by_BOBO
	function BOBO_Tools(thisObj) {
		function buildUI(thisObj) {
			var panel = (thisObj instanceof Panel) ? thisObj : new Window("palette", "VFX_ToolsByBoBO", undefined, {
				resizeable: true
			});
			res = "group{orientation:'row',alignment:['center','fill'],\
					groupOne: Group{orientation:'column',alignment:['center','fill'],alignChildren:['fill','top'],\
						button1: Button{},\
						Divider1: Panel{},\
						button2: Button{},\
						button3: Button{},\
						button4: Button{},\
						button5: Button{},\
						button6: Button{},\
						button7: Button{},\
						button8: Button{},\
						button9: Button{},\
						button10: Button{},\
						Divider1: Panel{},\
						buttonHelp: Button{text:'Help v1.6版本'},\
					},\
				}";

			panel.grp = panel.add(res);
			return panel;
		}
		// Called when a button is pressed, to invoke its associated script
		function onHelpButtonClick() {
			alert("帮助:\n\n" +
				"##效率工作 开心生活！by_BoBO##\n\n" +

				"打开素材资源Immigration" +
				"提示注册输入CG**Percia**87002265STE不能能复制粘贴，要手动输入.\n\n" +

				"##############################################\n\n" +
				"更新历史\n\n" +
				"20180829 v 1.6 重新架构工具，删除不常用的功能.\n\n" +
				"20170731 v 1.5 新增加“重命名”功能，主要一些素材合成组等批量重命名.\n\n" +
				"20170506 v1.4 新增加 高版本转底版本功能,先打包文件在在生成【.tsv】文件.\n\n" +
				"20170428 v 1.3 新增功能.\n\n" +
				"保存合成组导出,单独导出合成组.\n\n" +
				"循环工具.\n\n" +
				"图片切换工具.\n\n" +
				"20170307 v 1.2 新增加OrganizeProjectAssets功能，主要重组规范素材.\n\n" +
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
			button.text = buttonLabel;
			button.scriptFileName = buttonScriptName;
			button.currentDirectory = buttonCurrentDirectory;
			button.currentDirectory = buttonCurrentDirectory;

			button.onClick = onScriptButtonClick;
		}

		function isSecurityPrefSet() {
			var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
			return (securitySetting == 1);
		}

		if (isSecurityPrefSet() == true) {
			var myDirectory = Folder.current;
			var scriptDirectory = new Folder(myDirectory.absoluteURI + "/(BOBOToolsFunctions)");

			var myPanel = buildUI(thisObj);
			setScriptButton(myPanel.grp.groupOne.button1, "渲染输出", scriptDirectory, "SPRenderQueueTools.jsx");
			setScriptButton(myPanel.grp.groupOne.button2, "规整项目", scriptDirectory, "OrganizeProjectAssets.jsxbin");
			setScriptButton(myPanel.grp.groupOne.button3, "项目清理", scriptDirectory, "ProjectCleaner.jsx");
			setScriptButton(myPanel.grp.groupOne.button4, "批量导入素材", scriptDirectory, "Immigration.jsxbin");
			setScriptButton(myPanel.grp.groupOne.button5, "快速访问", scriptDirectory, "QuickAccess.jsx");
			setScriptButton(myPanel.grp.groupOne.button6, "导出合成组", scriptDirectory, "SaveCompAsProject_v2.jsx");
			setScriptButton(myPanel.grp.groupOne.button7, "导出低版本", scriptDirectory, "pt_OpenSesame.jsxbin");
			setScriptButton(myPanel.grp.groupOne.button8, "循环A", scriptDirectory, "LoopMaker.jsxbin");
			setScriptButton(myPanel.grp.groupOne.button9, "循环B", scriptDirectory, "Quickloop.jsxbin");
			setScriptButton(myPanel.grp.groupOne.button10, "图集动画", scriptDirectory, "Sprite-O-Matic.jsx");
			//setScriptButton(myPanel.grp.groupOne.button11, "删除重置", scriptDirectory, "QuickDeleteAndReset.jsxbin");
			//setScriptButton(myPanel.grp.groupOne.button12, "曲线", scriptDirectory, "Ease and wizz.jsx");
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
	}


	BOBO_Tools(this);
}