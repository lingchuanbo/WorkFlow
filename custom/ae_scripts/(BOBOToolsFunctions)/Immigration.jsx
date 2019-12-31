//
//多个版本Ae记得在AE配置文件新增加字段
//Adobe After Effects 16.0 Prefs.txt
//["Settings_aescripts"]
//	"Immigration_Registration" = ""Immigration_Registration" = "CG**Percia**87002265STE""
//
function Immigration(thisObj) {
    var Immigration_Data = new Object();
    Immigration_Data.scriptName = "Immigration";
    Immigration_Data.scriptVersion = " v1.41";
    Immigration_Data.betaMode = false;
    Immigration_Data.betaExpiration = new Date(2009, 9, 1);
    Immigration_Data.checkTrial = true;
    Immigration_Data.scriptTitle = Immigration_Data.scriptName + " " + Immigration_Data.scriptVersion;
    Immigration_Data.loggingMode = false;
    Immigration_Data.logFileLocation = "~/Desktop";
    Immigration_Data.validSeqExtensions = "ai,bmp,bw,cin,cr2,crw,dcr,dng,dib,dpx,eps,erf,exr,gif,hdr,icb,iff,jpe,jpeg,jpg,mos,mrw,nef,orf,pbm,pef,pct,pcx,pdf,pic,pict,png,ps,psd,pxr,raf,raw,rgb,rgbe,rla,rle,rpf,sgi,srf,tdi,tga,tif,tiff,vda,vst,x3f,xyze";
    Immigration_Data.validNonSeqExtensions = "aec,aep,aif,aiff,avi,dv,qt,mov,m4v,mpg,mxf,xml,r3d,wav,wvm";
    if ($.os.indexOf("Mac") != -1) {
        Immigration_Data.cmdKey = "⌘";
        Immigration_Data.LoadButtonFont = "Apple Symbols";
        Immigration_Data.LoadButtonFontSize = 24;
    } else {
        Immigration_Data.cmdKey = "Ctrl";
        Immigration_Data.LoadButtonFont = "Lucida Sans Unicode";
        Immigration_Data.LoadButtonFontSize = 18;
    }
    Immigration_Data.trialLengthDays = 14;
    Immigration_Data.trialLengthLaunches = 25;
    Immigration_Data.strImmigrationTrialUrl = "http://bit.ly/Immigration_Trial_End";
    Immigration_Data.strExpiredAlert = "Sorry, this trial version of the script has expired.\nYou can purchase a license at http://aescripts.com/immigration\n\n(If you have an internet connection you will be taken there once you hit OK)";
    Immigration_Data.strImmigrationTrialThanks = "Thanks for trying Immigration!";
    Immigration_Data.strImmigrationTrialTxt = "%E days left in the trial";
    Immigration_Data.strImmigrationTrialTxt2 = "%E launches left in the trial";
    Immigration_Data.strImmigrationTrialWelcomeHeader = "Welcome to IMMIGRATION from aescripts.com";
    Immigration_Data.strImmigrationTrialWelcomeMsg = "Please enter the CG**Percia**87002265STE code.  If pasting the code with " + Immigration_Data.cmdKey + "+V doesn't work try Edit->Paste. If you need to retrieve your license you can do so at http://license.aescripts.com\nTo run in trial mode type: trial\n";
    if (app.settings.haveSetting("aescripts", "Immigration_doFilePreSort")) {
        Immigration_Data.doExtensionSort = !(app.settings.getSetting("aescripts", "Immigration_doFilePreSort") == "false")
    } else {
        Immigration_Data.doExtensionSort = false
    }
    Immigration_Data.moreAccurateAutoMatch = true;
    Immigration_Data.autoMatchLevenDistanceTolerance = 1;
    Immigration_Data.browseBtnStart = "Browse";
    Immigration_Data.browseBtnStartInstr = "Please choose a starting folder";
    Immigration_Data.browseBtn = "Browse";
    Immigration_Data.browseBtnTip = "Browse Folders";
    Immigration_Data.browseRecentInstr = "or choose a recent location                                                                                                                     ";
    Immigration_Data.browseRecentInstrTip = "Recently used Folders";
    Immigration_Data.browseCurrentFolderTip = "Currently browsing folder:";
    Immigration_Data.folderError = "The selected folder no longer exists";
    Immigration_Data.missingFileError = "Path not valid or file no longer exists or insufficient permissions to access file. (If you stopped a search using Esc then try searching again)";
    Immigration_Data.recentFolders = 10;
    Immigration_Data.recursionDepth = 10;
    Immigration_Data.sortBtn = "Sort";
    Immigration_Data.filterTxt = "Filter:";
    Immigration_Data.filterTxtTip = "Items that match this filter will be selected.";
    Immigration_Data.filterExtensionTip = "File extention filter.";
    Immigration_Data.goButton = "Import";
    Immigration_Data.goFolderButton = "Import into Folder";
    Immigration_Data.replaceButton = "Replace";
    Immigration_Data.replaceProxyButton = "Add/Replace Proxy";
    Immigration_Data.proxyModeButton = "Proxy Mode";
    Immigration_Data.proxyModeButtonHelpTip = "When proxy mode is on, a proxy will be added if an item does not have a proxy. If the item already has a proxy, the proxy will be replaced. ";
    Immigration_Data.hierarchyButton = "Maintain hierarchy";
    Immigration_Data.hierarchyButtonHelpTip = "Will recreate the folder hierarchy of the selected file(s) in the project panel.  If the hierarchy already exists in the project it will be maintained using the existing folders.";
    Immigration_Data.matchOptions = ["Auto-Match Files", "Manual Match Files (Top->Bottom)"];
    Immigration_Data.matchOptionsTip = "This determines how the Replace mode determines a match. Auto-Match will attempt to match similar names items (even if they are not exactly the same).  Manual will match items in order from top to bottom.";
    Immigration_Data.FrameRate = "Set Frame Rate:";
    Immigration_Data.FrameRange = "Set Range:";
    Immigration_Data.FrameRangeErrorIn = "In point cannot be greater than the Out Point, it will be reset to the original value";
    Immigration_Data.FrameRangeErrorOut = "Out point cannot be less than the In Point, it will be reset to the original value";
    Immigration_Data.defaultFrameRate = "15";
    Immigration_Data.switchToReplaceButton = "Switch to Replace Mode";
    Immigration_Data.switchToImportButton = "Switch to Import Mode";
    Immigration_Data.switchToReplaceButtonTip = "Switches Immigration to Replace Mode as long as there are items selected in project panel";
    Immigration_Data.switchToImportButtonTip = "Switch to Import Mode by deselecting all items in the project panel";
    Immigration_Data.switchToReplaceError = "To switch to Replace Mode you must have the items you want to replace selected in the project panel";
    Immigration_Data.refreshButton = "Refresh Item Count";
    Immigration_Data.refreshButtonTip = "Refresh " + Immigration_Data.scriptName + " window to reflect newly made selections in the project panel";
    Immigration_Data.refreshFail = "To Replace you must have the same number of items selected in the project panel and the  " + Immigration_Data.scriptName + " window.";
    Immigration_Data.previewButton = "Preview File Matches";
    Immigration_Data.previewButtonTip = "Will preview how the files will be paired to be replaced.";
    Immigration_Data.closePreviewButton = "Close Preview";
    Immigration_Data.closePreviewButtonTip = "Close preview and return to file selection window.";
    Immigration_Data.listBoxPreviewTitle = "PREVIEW";
    Immigration_Data.listBoxPreviewError = "***ERROR***";
    Immigration_Data.readyToReplace = " ";
    Immigration_Data.selectedItems = "    Selected Items:";
    Immigration_Data.strHelp = "?";
    Immigration_Data.strHelpTip = "Help and Preferences";
    Immigration_Data.strMinAE80 = "This script requires Adobe After Effects CS3 or later.";
    Immigration_Data.allFilter = "All";
    Immigration_Data.loading = "Scanning folders, please wait...";
    Immigration_Data.reloading = "Reloading Folder...";
    Immigration_Data.loadingFolders = "Detecting Folders...";
    Immigration_Data.stop = "Stop Scan";
    Immigration_Data.sorting = "Sorting...";
    Immigration_Data.statusTxt = "no info yet";
    Immigration_Data.statusTxtHelpTip = "This displays the number of items selected in Immigration and the Project Panel (" + Immigration_Data.cmdKey + "-0).  To do a " + Immigration_Data.replaceButton + " or " + Immigration_Data.replaceProxyButton + " the same number of items need to be selected.";
    Immigration_Data.welcomeTxt = Immigration_Data.scriptName + " " + Immigration_Data.scriptVersion;
    Immigration_Data.nothingSelected = "Please select at least one item to import";
    Immigration_Data.unevenSelection = "To do a " + Immigration_Data.replaceButton + " or " + Immigration_Data.replaceProxyButton + " the same number of items need to be selected in Immigration and the Project Panel (" + Immigration_Data.cmdKey + "-0)";
    Immigration_Data.strSelProj = "Please open a project first to use this script";
    Immigration_Data.filterError = "The was an invalid character entered. Please fix and try again.";
    Immigration_Data.padAmount = 15;
    if ($.os.indexOf("Mac") != -1 && $.os.match(10.4)) {
        Immigration_Data.LoadButtonShort = "↷";
    } else {
        Immigration_Data.LoadButtonShort = "↻";
    }
    Immigration_Data.LoadButtonShortAlt = "R";
    Immigration_Data.LoadButtonFontError = "Font Error: Reload button labeled R instead";
    Immigration_Data.LoadButtonFontAlt = "arial || dialog";
    Immigration_Data.LoadButtonFontSizeAlt = 16;
    Immigration_Data.LoadButtonTip = "Reload Folder";
    Immigration_Data.recentFolderArraySeparator = ":";
    Immigration_Data.encodedRootName = "Immigration_temp_folder89B12z9";
    Immigration_Data.replaceError = "One or more of the selected items in the Project Panel are not footage items.\nThis means they cannot be replaced.  Make sure all project panel items to be replaced are footage items.";
    Immigration_Data.importError = "There are no items selected in the Project Panel.\nThe button said %RB instead of " + Immigration_Data.goButton + " because the items in the project panel were de-selected after making a selection in " + Immigration_Data.scriptName + ".  " + "(You should always make your selection in the project panel first, then in " + Immigration_Data.scriptName + ")\n\n" + "Would you like to continue with an " + Immigration_Data.goButton + " instead of %RB?";
    Immigration_Data.importError2 = "To " + Immigration_Data.replaceButton + " you must select the items in the Project Panel BEFORE you make your selection in " + Immigration_Data.scriptName + ".\n\n" + "If you are trying to " + Immigration_Data.goButton + ", make sure there are no items selected in the project panel.";
    Immigration_Data.importError3 = "There is a folder selected in the Project Panel.\nThe button said %RB instead of " + Immigration_Data.goFolderButton + " because the folder in the project panel was selected after making a selection in " + Immigration_Data.scriptName + ". " + "(You should always make your selection in the project panel first, then in " + Immigration_Data.scriptName + ")\n\n" + "Would you like to continue with " + Immigration_Data.goFolderButton + " instead of %RB?";
    Immigration_Data.importError4 = "There is a folder selected in the Project Panel.\nThe button said " + Immigration_Data.goButton + " instead of " + Immigration_Data.goFolderButton + " because the folder in the Project Panel was selected after making a selection in " + Immigration_Data.scriptName + "." + "(You should always make your selection in the project panel first, then in " + Immigration_Data.scriptName + ")\n\n" + "Would you like to continue with " + Immigration_Data.goFolderButton + " instead of " + Immigration_Data.goButton + "?";
    Immigration_Data.strErrScriptAccess = "This script requires the scripting security preference to be set.\nGo to the \"General\" panel of the application preferences and make sure \"Allow Scripts to Write Files and Access Network\" is checked.";
    Immigration_Data.strAES = "http://aescripts.com";
    Immigration_Data.strAESUrl = "http://aescripts.com";
    Immigration_Data.strClose = "Close";
    Immigration_Data.strPreferences = "Preferences";
    Immigration_Data.strCollapseHelp = "Hide Instructions";
    Immigration_Data.strExpandHelp = "Show Instructions";
    Immigration_Data.strCurrDirInclude = "Include current folder when maintaining hierarchy";
    Immigration_Data.strRecentDir = "Number of recent folders to save:";
    Immigration_Data.strRecursionDepth = "Subfolder levels (recursion):";
    Immigration_Data.strFolderFilter = "Folder filter";
    Immigration_Data.strFolderFilterSeparator = ",";
    Immigration_Data.strFolderFilterOptions = ["None", "Exclude", "Include"];
    Immigration_Data.strFileAgeFilter = "File age filter";
    Immigration_Data.strFileAgeFilterOptions = ["None", "Exclude files", "Include files"];
    Immigration_Data.strFileAgeFilterOptions2 = ["less than", "greater than"];
    Immigration_Data.strFileAgeFilterTimeOptions = ["days", "hours"];
    Immigration_Data.strFileAgeFilterSuffix = "old";
    Immigration_Data.strPreSortFiles = "Pre-sort files (required for non-zero padded sequences)";
    Immigration_Data.strImmigration = "Post Comments";
    Immigration_Data.strImmigrationHelpUrl = "http://bit.ly/immigration_Help_Button";
    Immigration_Data.strTutorial = "Video Tutorial";
    Immigration_Data.strTutorialUrl = "http://bit.ly/immigration_Help_Button";
    Immigration_Data.winProgramFiles = Folder.commonFiles.parent.fsName;
    Immigration_Data.winBrowserCmd = "start ";
    Immigration_Data.winBrowserCmd1 = Immigration_Data.winProgramFiles + "\\Internet Explorer\\iexplore.exe";
    Immigration_Data.macBrowserCmdStart = "open \"";
    Immigration_Data.macBrowserCmdEnd = "\"";
    Immigration_Data.projSaveWarning = "It's been over %e minutes since you last saved this project.\nImmigration needs to chit chat with the operating system to work so it's a good idea to save your project before it gets to work.\n\nWould you like to save the project before proceeding?";
    Immigration_Data.projSaveWarning2 = "Immigration needs to chit chat with the operating system to work so it's a good idea to save your project before it gets to work.\n\nWould you like to save the project before proceeding?";
    Immigration_Data.projSaveMins = 0;
    Immigration_Data.betaExpiredWarning = "Sorry this beta version has expired.\n\nIf you have an internet connection you will be taken to http://aescripts.com once you hit OK to look for a current version.\nAlternatively you can delete the After Effects preferences to restart the trial period.";
    Immigration_Data.initialWarning = "Depending on how many files and folders you are searching, it could take a little\nbit of time for " + Immigration_Data.scriptName + " to finish its search so it is a good idea to: \n\n" + "• Have the Info Panel (" + Immigration_Data.cmdKey + " 2) open to see the progress.\n\n";
    if (parseFloat(app.version) >= 10) {
        Immigration_Data.initialWarning += "• Once a search has started you can stop it by hitting the escape key.\n\n";
    } else {
        Immigration_Data.initialWarning += "• Once a search has started you can stop it by hitting " + Immigration_Data.cmdKey + " . (period)\n\n";
    }
    Immigration_Data.initialWarning += "• Sequences must have leading zeroes to be detected properly.\n   (unless you turn on the \"Pre-sort files\" option" + ($.os.indexOf("Windows") != -1 ? " which requires perl to be installed" : "") + ")\n\n";
    Immigration_Data.proxyWarning = "%E\n\nhas a proxy.  Would you like to replace the proxy instead of the main footage item?\n";
    Immigration_Data.dontWarnWarning = "Don't show this again";
    Immigration_Data.applyToAll = "Apply to All";
    Immigration_Data.initialTitleWarning = "Getting Started with " + Immigration_Data.scriptName;
    Immigration_Data.proxyTitleWarning = "Proxy Detected";
    Immigration_Data.proxyButton = "Replace Proxy";
    Immigration_Data.mainButton = "Replace Main";
    Immigration_Data.okWarning = "OK";
    Immigration_Data.cancelWarning = "Cancel";
    Immigration_Data.strHelpHeader = Immigration_Data.scriptTitle + " ©2009-2011 aescripts.com";
    if ($.os.indexOf("Mac") != -1) {
        Immigration_Data.strHelpTextExtra1 = "You can also Exclude or Include files based on how old they are by entering the amount of days.  You can enter fractional numbers to match less than a day.\n\n";
        Immigration_Data.strHelpTextExtra2 = "If you have to deal with filesequences that are not zero-padded or files with the same name but different extensions in the same folder: File01.jpg and File01.psd.  You can turn on the pre-sort preference in the external preferences file that will identify these sequences properly but will be slower to search, especially in folders with thousands of files.\n\n";
    } else {
        Immigration_Data.strHelpTextExtra1 = "\n\n";
        Immigration_Data.strHelpTextExtra2 = "\n";
    }
    Immigration_Data.strHelpText = "This script makes batch importing and replacing footage items easy!\nSimply launch the script and press " + Immigration_Data.browseBtnStart + " or, if available, select a previously used folder.\n\n" + "IMPORTANT: \n" + "Sequences must have leading zeroes to be identified correctly and cannot have any illegal characters in the path or file name.\n" + "If you must work with un-padded file sequences or " + "if there are files with the same name but different extension (for example: File1.jpg and File1.tif) then turn on the \"Pre-sort files\" option below " + "(Please note that this will make searching slower so only use this option if necessary).\n\n" + "To Import or Batch Import: \n" + "Make sure that there are no items selected in the project panel (or press the " + Immigration_Data.switchToImportButton + " button), then select the items you wish to import in " + Immigration_Data.scriptName + " and press  " + Immigration_Data.goButton + ".  " + "If any of the selected items to import are file sequences they will be conformed to the frame rate set in the panel.  " + "If you have a folder selected in the project panel before choosing your items to import, the items will be imported into that folder.\n" + "If " + Immigration_Data.hierarchyButton + " is checked, " + Immigration_Data.scriptName + " will recreate the folder hierarchy of the selected file(s) in the project panel.  If the hierarchy already exists in the project it will be maintained using the existing folders.  If using the " + Immigration_Data.goFolderButton + " feature, the selected project folder will be considered the root of the hierarchy.   This feature works by searching folder names so make sure you don't have any duplicate folder names in your project.\n\n" + "To Replace or Batch Replace: \n" + "Select items to be replaced in the project panel first.  Then select the files in  " + Immigration_Data.scriptName + ".  Once the same number " + "of items are selected, the " + Immigration_Data.replaceButton + " button will become active.  " + Immigration_Data.matchOptions[0] + " will attempt to match same or similar name items.  " + Immigration_Data.matchOptions[1] + " requires that the items are selected in Top->Bottom order in both the project panel and the " + Immigration_Data.scriptName + " window and they will be replaced in that order.  Pressing the " + Immigration_Data.previewButton + " button will give you a preview of how the " + "items will be matched when they are replaced or added as a proxy.  While in Preview mode you can change the match mode to preview how the files will be matched." + "If the Replace button is not active and you have the same number of items selected, try hitting the " + Immigration_Data.refreshButton + " button.  " + "Pressing the " + Immigration_Data.switchToImportButton + " button will de-select all the items in the project panel and switch to Import mode.\n\n" + Immigration_Data.proxyModeButton + ":\n" + "When proxy mode is on a proxy will be added if an item does not have a proxy or if the item already has a proxy, the proxy will be replaced.  If adding a sequence as a proxy, the frame rate will be conformed to the frame rate set in the panel.\n\n" + Immigration_Data.filterTxt + "\n" + "Text entered in the " + Immigration_Data.filterTxt + " text box will select any items that match. This feature supports regular expressions (see cheatsheet below).  " + "The filter pulldown allows you filter a specific extension, setting the Filter to " + Immigration_Data.allFilter + " will show all allowable extensions.  You can modify the allowable extensions by editing the script file in a text editor and modifying the VALID EXTENSIONS section.\n\n" + "Frame Rate and Frame Range:\n" + "You can select one or more sequences to import at once.  Set the frame rate for the sequences (all selected sequences will be assigned the same frame rate on import) then click " + Immigration_Data.goButton + " and they will be imported.  If you only have one sequence selected you " + "can specify a subrange to import where it says " + Immigration_Data.FrameRange + "\n\n" + Immigration_Data.strFolderFilter + ":\n" + "If you would like certain folders to be excluded from the search, set " + Immigration_Data.strFolderFilter + " below to " + Immigration_Data.strFolderFilterOptions[1] + " and enter the name of the folder you would like to exclude.  This field is case sensitive. " + "If you would like to  exclude more than one word separate them with a comma like this: red,blue.  Be aware that spaces are considered so don't use any spaces unless you intend for them to be included in the name match. " + "The  " + Immigration_Data.strFolderFilterOptions[2] + " feature will search recursively but only return files for folders whose name match, so make sure to include the name of the folder which includes the files you want.  For example if the hierarchy is \\jobs\\3d\\diffuse " + "and you want the files in the diffuse folder, you would search for diffuse.  Searching for 3d would not include the diffuse folder.  As with exclude you can add more than one word separated by comma so 3d,diffuse will return all the files in the 3d folder as well as the diffuse folder.  " + Immigration_Data.strHelpTextExtra1 + "ADVANCED SETTINGS: \n" + "You can override which extensions you want Immigration to work with by editing the user preferences file that is created after the first time you run Immigration.  You can find this file in the same directory where the script is installed.\n" + "Be cautious when editing this file as any formatting errors will prevent it from being read in properly. To restore the file to it's default value, simply delete the file (but not the Folder) and it will be re-created the next time you launch Immigration.\n" + Immigration_Data.strHelpTextExtra2 + "Note: This version of the script requires After Effects CS3 or later. It can be used as a dockable panel by placing the script in a ScriptUI Panels subfolder of the Scripts folder, and then choosing this script from the Window menu.\n";
    if (isSecurityPrefSet()) {
        Immigration_Data.fileOutput = "ImmigrationFileOutput.txt";
        if ($.os.indexOf("Mac") != -1) {
            Immigration_Data.tempOutput = Folder.temp.toString() + "/" + Immigration_Data.fileOutput;
        } else {
            try {
                var perlCheck = String(system.callSystem("cmd /c \"wperl -v\""));
                if (perlCheck.match("This is perl")) {
                    Immigration_Data.foundPerl = true;
                } else {
                    Immigration_Data.foundPerl = false;
                }
                Immigration_Data.tempFolder = String(system.callSystem("cmd /c \"echo %temp%\"")).replace(/(\r|\n)/g, "");
                Immigration_Data.tempOutput = Immigration_Data.tempFolder + "/" + Immigration_Data.fileOutput;
            } catch (err) {
                alert(err);
            }
        }
        var updatePrefs = false;
        var scriptsFile = new File($.fileName);
        Immigration_Data.prefsFile = new File(scriptsFile.path + "/Immigration_preferences.txt");
        if (Immigration_Data.prefsFile.exists) {
            try {
                $.evalFile(Immigration_Data.prefsFile);
            } catch (err) {
                alert("Error loading custom prefs file\n" + err.toString());
            }
            if (Immigration_Data.prefsVersion != Immigration_Data.scriptVersion) {
                updatePrefs = true;
            }
        }
        if (!Immigration_Data.prefsFile.exists || updatePrefs) {
            var prefsFile = File(scriptsFile.path + "/Immigration_preferences.txt");
            try {
                prefsFile.open("w", "TEXT", "????");
                prefsFile.writeln("//Immigration User Preferences File");
                prefsFile.writeln("Immigration_Data.prefsVersion = \"" + Immigration_Data.scriptVersion + "\";");
                prefsFile.writeln(" ");
                prefsFile.writeln("//Please be careful when editing this document to make sure you leave all the formatting including quotes and punctuation the same as it is.");
                prefsFile.writeln("//Please restart the script for the changes to take effect (you do not need to restart after effects).");
                prefsFile.writeln("//Delete this file to reset it to its default setting.");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln("///////// FILE EXTENSIONS /////////");
                prefsFile.writeln(" ");
                prefsFile.writeln("//Valid File Sequence Extensions, files with these extensions will be treated as file sequences.  Make sure there are no spaces between commas and that there is no comma after the last extension.");
                prefsFile.writeln(" ");
                prefsFile.writeln("Immigration_Data.validSeqExtensions = \"" + Immigration_Data.validSeqExtensions + "\";");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln("//Valid File Non-Sequence Extensions, files with these extensions will not be treated as file sequences.  Make sure there are no spaces between commas and that there is no comma after the last extension.");
                prefsFile.writeln(" ");
                prefsFile.writeln("Immigration_Data.validNonSeqExtensions = \"" + Immigration_Data.validNonSeqExtensions + "\";");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln(" ");
                prefsFile.writeln("///////// SAFETY /////////");
                prefsFile.writeln(" ");
                prefsFile.writeln("//Number of minutes that a project goes unsaved before Immigration warns to save before starting.  Set to 0 (zero) to disable this feature.");
                prefsFile.writeln(" ");
                prefsFile.writeln("Immigration_Data.projSaveMins = " + Immigration_Data.projSaveMins + ";");
                prefsFile.writeln(" ");
                prefsFile.close();
            } catch (err) {
                alert("Could not create custom preferences file.\n" + err.toString());
            }
        }
        Immigration_Data.matchIcon00Hex = "89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000204944415478DA62FCFFFF3F03298089814430AA6154C3D0D100000000FFFF0300556D031DC867A9270000000049454E44AE426082";
        Immigration_Data.matchIcon01Hex = "89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000204944415478DA62119C19C2400A606220118C6A18D530743400000000FFFF0300450E01212A5609090000000049454E44AE426082";
        Immigration_Data.matchIcon02Hex = "89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000244944415478DA625C7DDEFF3F030580898142306AC0A801A3060C160300000000FFFF03008B0302E8A2CD83200000000049454E44AE426082";
        Immigration_Data.matchIcon03Hex = "89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000244944415478DA62BC76DEFF3F030580898142306AC0A801A3060C160300000000FFFF030039970313371732990000000049454E44AE426082";
        Immigration_Data.matchIcon04Hex = "89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000244944415478DA62FCFFD0FF3F030580898142306AC0A801A3060C160300000000FFFF03002909034EFDFDAD270000000049454E44AE426082";
        Immigration_Data.matchIcon05Hex = "89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC546000000244944415478DA62FC71D0E93F030580898142306AC0A801A3060C160300000000FFFF03005628031A221686C60000000049454E44AE426082";
        Immigration_Data.matchIcon06Hex = "89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF61000000097048597300000B1300000B1301009A9C1800000A4F6943435050686F746F73686F70204943432070726F66696C65000078DA9D53675453E9163DF7DEF4424B8880944B6F5215082052428B801491262A2109104A8821A1D91551C1114545041BC8A088038E8E808C15512C0C8A0AD807E421A28E83A3888ACAFBE17BA36BD6BCF7E6CDFEB5D73EE7ACF39DB3CF07C0080C9648335135800CA9421E11E083C7C4C6E1E42E40810A2470001008B3642173FD230100F87E3C3C2B22C007BE000178D30B0800C04D9BC0301C87FF0FEA42995C01808401C07491384B08801400407A8E42A600404601809D98265300A0040060CB6362E300502D0060277FE6D300809DF8997B01005B94211501A09100201365884400683B00ACCF568A450058300014664BC43900D82D00304957664800B0B700C0CE100BB200080C00305188852900047B0060C8232378008499001446F2573CF12BAE10E72A00007899B23CB9243945815B082D710757572E1E28CE49172B14366102619A402EC27999193281340FE0F3CC0000A0911511E083F3FD78CE0EAECECE368EB60E5F2DEABF06FF226262E3FEE5CFAB70400000E1747ED1FE2C2FB31A803B06806DFEA225EE04685E0BA075F78B66B20F40B500A0E9DA57F370F87E3C3C45A190B9D9D9E5E4E4D84AC4425B61CA577DFE67C25FC057FD6CF97E3CFCF7F5E0BEE22481325D814704F8E0C2CCF44CA51CCF92098462DCE68F47FCB70BFFFC1DD322C44962B9582A14E35112718E449A8CF332A52289429229C525D2FF64E2DF2CFB033EDF3500B06A3E017B912DA85D6303F64B27105874C0E2F70000F2BB6FC1D4280803806883E1CF77FFEF3FFD47A02500806649927100005E44242E54CAB33FC708000044A0812AB0411BF4C1182CC0061CC105DCC10BFC6036844224C4C24210420A64801C726029AC82422886CDB01D2A602FD4401D34C051688693700E2EC255B80E3D700FFA61089EC128BC81090441C808136121DA8801628A58238E08179985F821C14804128B2420C9881451224B91354831528A542055481DF23D720239875C46BA913BC8003282FC86BC47319481B2513DD40CB543B9A8371A8446A20BD06474319A8F16A09BD072B41A3D8C36A1E7D0AB680FDA8F3E43C730C0E8180733C46C302EC6C342B1382C099363CBB122AC0CABC61AB056AC03BB89F563CFB17704128145C0093604774220611E4148584C584ED848A8201C243411DA093709038451C2272293A84BB426BA11F9C4186232318758482C23D6128F132F107B8843C437241289433227B9900249B1A454D212D246D26E5223E92CA99B34481A2393C9DA646BB20739942C202BC885E49DE4C3E433E41BE421F25B0A9D624071A4F853E22852CA6A4A19E510E534E5066598324155A39A52DDA8A15411358F5A42ADA1B652AF5187A81334759A39CD8316494BA5ADA295D31A681768F769AFE874BA11DD951E4E97D057D2CBE947E897E803F4770C0D861583C7886728199B18071867197718AF984CA619D38B19C754303731EB98E7990F996F55582AB62A7C1591CA0A954A9526951B2A2F54A9AAA6AADEAA0B55F355CB548FA95E537DAE46553353E3A909D496AB55AA9D50EB531B5367A93BA887AA67A86F543FA47E59FD890659C34CC34F43A451A0B15FE3BCC6200B6319B3782C216B0DAB86758135C426B1CDD97C762ABB98FD1DBB8B3DAAA9A13943334A3357B352F394663F07E39871F89C744E09E728A797F37E8ADE14EF29E2291BA6344CB931655C6BAA96979658AB48AB51AB47EBBD36AEEDA79DA6BD45BB59FB810E41C74A275C2747678FCE059DE753D953DDA70AA7164D3D3AF5AE2EAA6BA51BA1BB4477BF6EA7EE989EBE5E809E4C6FA7DE79BDE7FA1C7D2FFD54FD6DFAA7F5470C5806B30C2406DB0CCE183CC535716F3C1D2FC7DBF151435DC34043A561956197E18491B9D13CA3D5468D460F8C69C65CE324E36DC66DC6A326062621264B4DEA4DEE9A524DB9A629A63B4C3B4CC7CDCCCDA2CDD699359B3D31D732E79BE79BD79BDFB7605A785A2CB6A8B6B86549B2E45AA659EEB6BC6E855A3959A558555A5DB346AD9DAD25D6BBADBBA711A7B94E934EAB9ED667C3B0F1B6C9B6A9B719B0E5D806DBAEB66DB67D6167621767B7C5AEC3EE93BD937DBA7D8DFD3D070D87D90EAB1D5A1D7E73B472143A563ADE9ACE9CEE3F7DC5F496E92F6758CF10CFD833E3B613CB29C4699D539BD347671767B97383F3888B894B82CB2E973E2E9B1BC6DDC8BDE44A74F5715DE17AD2F59D9BB39BC2EDA8DBAFEE36EE69EE87DC9FCC349F299E593373D0C3C843E051E5D13F0B9F95306BDFAC7E4F434F8167B5E7232F632F9157ADD7B0B7A577AAF761EF173EF63E729FE33EE33C37DE32DE595FCC37C0B7C8B7CB4FC36F9E5F85DF437F23FF64FF7AFFD100A78025016703898141815B02FBF87A7C21BF8E3F3ADB65F6B2D9ED418CA0B94115418F82AD82E5C1AD2168C8EC90AD21F7E798CE91CE690E85507EE8D6D00761E6618BC37E0C2785878557863F8E7088581AD131973577D1DC4373DF44FA449644DE9B67314F39AF2D4A352A3EAA2E6A3CDA37BA34BA3FC62E6659CCD5589D58496C4B1C392E2AAE366E6CBEDFFCEDF387E29DE20BE37B17982FC85D7079A1CEC2F485A716A92E122C3A96404C884E3894F041102AA8168C25F21377258E0A79C21DC267222FD136D188D8435C2A1E4EF2482A4D7A92EC91BC357924C533A52CE5B98427A990BC4C0D4CDD9B3A9E169A76206D323D3ABD31839291907142AA214D93B667EA67E66676CBAC6585B2FEC56E8BB72F1E9507C96BB390AC05592D0AB642A6E8545A28D72A07B267655766BFCD89CA3996AB9E2BCDEDCCB3CADB90379CEF9FFFED12C212E192B6A5864B572D1D58E6BDAC6A39B23C7179DB0AE315052B865606AC3CB88AB62A6DD54FABED5797AE7EBD267A4D6B815EC1CA82C1B5016BEB0B550AE5857DEBDCD7ED5D4F582F59DFB561FA869D1B3E15898AAE14DB1797157FD828DC78E51B876FCABF99DC94B4A9ABC4B964CF66D266E9E6DE2D9E5B0E96AA97E6970E6E0DD9DAB40DDF56B4EDF5F645DB2F97CD28DBBB83B643B9A3BF3CB8BC65A7C9CECD3B3F54A454F454FA5436EED2DDB561D7F86ED1EE1B7BBCF634ECD5DB5BBCF7FD3EC9BEDB5501554DD566D565FB49FBB3F73FAE89AAE9F896FB6D5DAD4E6D71EDC703D203FD07230EB6D7B9D4D51DD23D54528FD62BEB470EC71FBEFE9DEF772D0D360D558D9CC6E223704479E4E9F709DFF71E0D3ADA768C7BACE107D31F761D671D2F6A429AF29A469B539AFB5B625BBA4FCC3ED1D6EADE7AFC47DB1F0F9C343C59794AF354C969DAE982D39367F2CF8C9D959D7D7E2EF9DC60DBA2B67BE763CEDF6A0F6FEFBA1074E1D245FF8BE73BBC3BCE5CF2B874F2B2DBE51357B8579AAF3A5F6DEA74EA3CFE93D34FC7BB9CBB9AAEB95C6BB9EE7ABDB57B66F7E91B9E37CEDDF4BD79F116FFD6D59E393DDDBDF37A6FF7C5F7F5DF16DD7E7227FDCECBBBD97727EEADBC4FBC5FF440ED41D943DD87D53F5BFEDCD8EFDC7F6AC077A0F3D1DC47F7068583CFFE91F58F0F43058F998FCB860D86EB9E383E3939E23F72FDE9FCA743CF64CF269E17FEA2FECBAE17162F7EF8D5EBD7CED198D1A197F29793BF6D7CA5FDEAC0EB19AFDBC6C2C61EBEC97833315EF456FBEDC177DC771DEFA3DF0F4FE47C207F28FF68F9B1F553D0A7FB93199393FF040398F3FC63332DDB000000206348524D00007A25000080830000F9FF000080E9000075300000EA6000003A980000176F925FC5460000002B4944415478DA62FCCFC0F09F8102C0C4402160A4D4058C43DF0B14BB60D4805103A86200000000FFFF030079A70815684531800000000049454E44AE426082";
        Immigration_Data.matchIcon00 = getIcon(File(Folder.temp.fsName + "/00.png"), Immigration_Data.matchIcon00Hex);
        Immigration_Data.matchIcon01 = getIcon(File(Folder.temp.fsName + "/01.png"), Immigration_Data.matchIcon01Hex);
        Immigration_Data.matchIcon02 = getIcon(File(Folder.temp.fsName + "/02.png"), Immigration_Data.matchIcon02Hex);
        Immigration_Data.matchIcon03 = getIcon(File(Folder.temp.fsName + "/03.png"), Immigration_Data.matchIcon03Hex);
        Immigration_Data.matchIcon04 = getIcon(File(Folder.temp.fsName + "/04.png"), Immigration_Data.matchIcon04Hex);
        Immigration_Data.matchIcon05 = getIcon(File(Folder.temp.fsName + "/05.png"), Immigration_Data.matchIcon05Hex);
        Immigration_Data.matchIcon06 = getIcon(File(Folder.temp.fsName + "/06.png"), Immigration_Data.matchIcon06Hex);
    }
    Immigration_Data.endMatchRegex = new RegExp("([0-9]+.)([^.]+$)");
    Immigration_Data.validExtensions = Immigration_Data.validSeqExtensions + "," + Immigration_Data.validNonSeqExtensions;
    Immigration_Data.validExtensionsArray = Immigration_Data.validExtensions.split(",");
    Immigration_Data.validNonSeqExtensionsArray = Immigration_Data.validNonSeqExtensions.split(",");
    Immigration_Data.validExtensionsArray.sort();
    var myRegEx = ".(";
    for (var e = 0; e < Immigration_Data.validExtensionsArray.length; e += 1) {
        if (e == 0) {
            myRegEx += "(" + Immigration_Data.validExtensionsArray[e] + ")";
        } else {
            myRegEx += "|(" + Immigration_Data.validExtensionsArray[e] + ")";
        }
    }
    myRegEx += ")$";
    Immigration_Data.extensionFilterRegex = new RegExp(myRegEx, "i");
    Immigration_Data.extensionFilterRegexAll = Immigration_Data.extensionFilterRegex;
    var myNonSeqRegEx = ".(";
    for (var e = 0; e < Immigration_Data.validNonSeqExtensionsArray.length; e += 1) {
        if (e == 0) {
            myNonSeqRegEx += "(" + Immigration_Data.validNonSeqExtensionsArray[e] + ")";
        } else {
            myNonSeqRegEx += "|(" + Immigration_Data.validNonSeqExtensionsArray[e] + ")";
        }
    }
    myNonSeqRegEx += ")$";
    Immigration_Data.nonSequenceRegex = new RegExp(myNonSeqRegEx, "i");

    function Immigration_buildUI(thisObj) {
        var pal = (thisObj instanceof Panel ? thisObj : new Window("palette", Immigration_Data.scriptName, undefined, {
            resizeable: true
        }));
        if (pal != null) {
            //var res = "group { \n\t\t\t\t\torientation:'column', alignment:['fill','fill'], \n\t\t\t\t\toptions: Group { \n\t\t\t\t\t\tmargins:0, \n\t\t\t\t\t\tspacing:0, \n\t\t\t\t\t\talignment:['left','top'], \n\t\t\t\t\t\talignChildren:['left','top'], \n\t\t\t\t\t\tbrowse: Button { text:'" + Immigration_Data.browseBtn + "',  helpTip:'" + Immigration_Data.browseBtnTip + "' }, \n\t\t\t\t\t\tloadBtn: Button { text:'" + Immigration_Data.LoadButtonShort + "',  helpTip:'" + Immigration_Data.LoadButtonTip + "' }, \n\t\t\t\t\t\tfilterTxt: StaticText { text:'" + Immigration_Data.filterTxt + "'}, \n\t\t\t\t\t\tfilterType: EditText { helpTip:'" + Immigration_Data.filterTxtTip + "' }, \n\t\t\t\t\t\tspace: StaticText { text:'.' }, \n\t\t\t\t\t\tfilter: DropDownList {  helpTip:'" + Immigration_Data.filterExtensionTip + "' }, \n\t\t\t\t\t\thelp: Button { text:'" + Immigration_Data.strHelp + "', maximumSize:[30,20], helpTip:'" + Immigration_Data.strHelpTip + "' }, \n\t\t\t\t\t}, \n\t\t\t\t\tdirs: Group { \n\t\t\t\t\t\torientation:'row', \n\t\t\t\t\t\tmargins:0, \n\t\t\t\t\t\tspacing:0, \n\t\t\t\t\t\talignment:['left','top'], \n\t\t\t\t\t\talignChildren:['left','top'], \n\t\t\t\t\t\tname: DropDownList {  helpTip:'" + Immigration_Data.browseRecentInstrTip + "'  }, \n\t\t\t\t\t}, \n\t\t\t\t\tlist: Group { \n\t\t\t\t\t\torientation:'column', \n\t\t\t\t\t\talignment:['fill','fill'], \n\t\t\t\t\t\talignChildren:['fill','fill'], \n\t\t\t\t\t\tmargins:0, \n\t\t\t\t\t\tspacing:0, \n\t\t\t\t\t\tstatus1: StaticText { text:'" + Immigration_Data.welcomeTxt + "', alignment:['left','top'], indent: 5,}, \n\t\t\t\t\t\tstatus2: StaticText {text:'" + Immigration_Data.welcomeTxt + "',alignment:['left','top'], indent: 5,}, \n\t\t\t\t\tlisting: Group { \n\t\t\t\t\t\torientation:'stack', \n\t\t\t\t\t\talignment:['fill','fill'], \n\t\t\t\t\t\talignChildren:['fill','fill'], \n\t\t\t\t\t\tlistBox3: TreeView {  }, \n\t\t\t\t\t\tlistBox2: ListBox { properties:{ multiselect:true} }, \n\t\t\t\t\t\tlistBox: ListBox { properties:{ multiselect:true} }, \n\t\t\t\t\t}, \n\t\t\t\t\t}, \n\t\t\t\t\tbuttons: Group { \n\t\t\t\t\tmargins:0, \n\t\t\t\t\tspacing:0, \n\t\t\t\t\torientation:'row', \n\t\t\t\t\talignment:['fill','bottom'], \n\t\t\t\t\talignChildren:['left','bottom'], \n\t\t\t\t\tbuttonsL: Group { \n\t\t\t\t\tmargins:0, \n\t\t\t\t\tspacing:0, \n\t\t\t\t\torientation:'column', \n\t\t\t\t\tdeSelect: Button { text:'" + Immigration_Data.switchToReplaceButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.switchToReplaceButtonTip + "' }, \n\t\t\t\t\trefresh: Button { text:'" + Immigration_Data.refreshButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.refreshButtonTip + "' }, \n\t\t\t\t\tstatusFR: Group { \n\t\t\t\t\torientation:'stack', \n\t\t\t\t\talignment:['fill','top'], \n\t\t\t\t\talignChildren:['left','center'], \n\t\t\t\t\tbuttonsFR: Group { \n\t\t\t\t\t\talignment:['fill','bottom'], \n\t\t\t\t\t\talignChildren:['left','center'], \n\t\t\t\t\t\tframeRateText: StaticText { text:'" + Immigration_Data.FrameRate + "' }, \n\t\t\t\t\t\tframeRate: EditText { text:'" + Immigration_Data.defaultFrameRate + "' }, \n\t\t\t\t\t}, \n\t\t\t\t\tstatus: StaticText { text:'" + Immigration_Data.statusTxt + "', helpTip:'" + Immigration_Data.statusTxtHelpTip + "',alignment:['left','bottom'] }, \n\t\t\t\t\tpreview2: Button { text:'" + Immigration_Data.previewButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.previewButtonTip + "' }, \n\t\t\t\t\t}, \n\t\t\t\t\tstatusRange: Group { \n\t\t\t\t\torientation:'stack', \n\t\t\t\t\tmargins:0, \n\t\t\t\t\tspacing:0, \n\t\t\t\t\talignment:['fill','bottom'], \n\t\t\t\t\talignChildren:['left','center'], \n\t\t\t\t\tbuttonsRange: Group { \n\t\t\t\t\t\talignment:['fill','top'], \n\t\t\t\t\t\talignChildren:['left','center'], \n\t\t\t\t\t\tframeRangeText:StaticText { text:'" + Immigration_Data.FrameRange + "' }, \n\t\t\t\t\t\tframeRangeIn: EditText { text:'' }, \n\t\t\t\t\t\tframeRangeOut: EditText { text:'' }, \n\t\t\t\t\t}, \n\t\t\t\t\tstatus: StaticText { text:'" + Immigration_Data.statusTxt + "', helpTip:'" + Immigration_Data.statusTxtHelpTip + "', alignment:['left','top'], }, \n\t\t\t\t\tpreview: Button { text:'" + Immigration_Data.previewButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.previewButtonTip + "' }, \n\t\t\t\t\t}, \n\t\t\t\t\t}, \n\t\t\t\t\tbuttonsR: Group { \n\t\t\t\t\tmargins:0, \n\t\t\t\t\tspacing:0, \n\t\t\t\t\torientation:'column', \n\t\t\t\t\talignment:['fill','bottom'], \n\t\t\t\t\talignChildren:['right','bottom'], \n\t\t\t\t\tmode: Checkbox  { text:'" + Immigration_Data.proxyModeButton + "', }, \n\t\t\t\t\tmatch: DropDownList { helpTip:'" + Immigration_Data.matchOptionsTip + "'  }, \n\t\t\t\t\tdoIt: Button { text:'" + Immigration_Data.goButton + "'}, \n\t\t\t\t\t}, \n\t\t\t\t\t}, \n\t\t\t\t} ";
            var res = "group { "+
                "                    orientation:'column', alignment:['fill','fill'], "+
                "                    options: Group { "+
                "                        margins:0, "+
                "                        spacing:0, "+
                "                        alignment:['left','top'], "+
                "                        alignChildren:['left','top'], "+
                "                        browse: Button { text:'" + Immigration_Data.browseBtn + "',  helpTip:'" + Immigration_Data.browseBtnTip + "' }, "+
                "                        loadBtn: Button { text:'" + Immigration_Data.LoadButtonShort + "',  helpTip:'" + Immigration_Data.LoadButtonTip + "' }, "+
                "                        filterTxt: StaticText { text:'" + Immigration_Data.filterTxt + "'}, "+
                "                        filterType: EditText { helpTip:'" + Immigration_Data.filterTxtTip + "' }, "+
                "                        space: StaticText { text:'.' }, "+
                "                        filter: DropDownList {  helpTip:'" + Immigration_Data.filterExtensionTip + "' }, "+
                "                        help: Button { text:'" + Immigration_Data.strHelp + "', maximumSize:[30,20], helpTip:'" + Immigration_Data.strHelpTip + "' }, "+
                "                    }, "+
                "                    dirs: Group { "+
                "                        orientation:'row', "+
                "                        margins:0, "+
                "                        spacing:0, "+
                "                        alignment:['left','top'], "+
                "                        alignChildren:['left','top'], "+
                "                        name: DropDownList {  helpTip:'" + Immigration_Data.browseRecentInstrTip + "'  }, "+
                "                    }, "+
                "                    list: Group { "+
                "                        orientation:'column', "+
                "                        alignment:['fill','fill'], "+
                "                        alignChildren:['fill','fill'], "+
                "                        margins:0, "+
                "                        spacing:0, "+
                "                        status1: StaticText { text:'" + Immigration_Data.welcomeTxt + "', alignment:['left','top'], indent: 5,}, "+
                "                        status2: StaticText {text:'" + Immigration_Data.welcomeTxt + "',alignment:['left','top'], indent: 5,}, "+
                "                    listing: Group { "+
                "                        orientation:'stack', "+
                "                        alignment:['fill','fill'], "+
                "                        alignChildren:['fill','fill'], "+
                "                        listBox3: TreeView {  }, "+
                "                        listBox2: ListBox { properties:{ multiselect:true} }, "+
                "                        listBox: ListBox { properties:{ multiselect:true} }, "+
                "                    }, "+
                "                    }, "+
                "                    buttons: Group { "+
                "                    margins:0, "+
                "                    spacing:0, "+
                "                    orientation:'row', "+
                "                    alignment:['fill','bottom'], "+
                "                    alignChildren:['left','bottom'], "+
                "                    buttonsL: Group { "+
                "                    margins:0, "+
                "                    spacing:0, "+
                "                    orientation:'column', "+
                "                    deSelect: Button { text:'" + Immigration_Data.switchToReplaceButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.switchToReplaceButtonTip + "' }, "+
                "                    refresh: Button { text:'" + Immigration_Data.refreshButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.refreshButtonTip + "' }, "+
                "                    statusFR: Group { "+
                "                    orientation:'stack', "+
                "                    alignment:['fill','top'], "+
                "                    alignChildren:['left','center'], "+
                "                    buttonsFR: Group { "+
                "                        alignment:['fill','bottom'], "+
                "                        alignChildren:['left','center'], "+
                "                        frameRateText: StaticText { text:'" + Immigration_Data.FrameRate + "' }, "+
                "                        frameRate: EditText { text:'" + Immigration_Data.defaultFrameRate + "' }, "+
                "                    }, "+
                "                    status: StaticText { text:'" + Immigration_Data.statusTxt + "', helpTip:'" + Immigration_Data.statusTxtHelpTip + "',alignment:['left','bottom'] }, "+
                "                    preview2: Button { text:'" + Immigration_Data.previewButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.previewButtonTip + "' }, "+
                "                    }, "+
                "                    statusRange: Group { "+
                "                    orientation:'stack', "+
                "                    margins:0, "+
                "                    spacing:0, "+
                "                    alignment:['fill','bottom'], "+
                "                    alignChildren:['left','center'], "+
                "                    buttonsRange: Group { "+
                "                        alignment:['fill','top'], "+
                "                        alignChildren:['left','center'], "+
                "                        frameRangeText:StaticText { text:'" + Immigration_Data.FrameRange + "' }, "+
                "                        frameRangeIn: EditText { text:'' }, "+
                "                        frameRangeOut: EditText { text:'' }, "+
                "                    }, "+
                "                    status: StaticText { text:'" + Immigration_Data.statusTxt + "', helpTip:'" + Immigration_Data.statusTxtHelpTip + "', alignment:['left','top'], }, "+
                "                    preview: Button { text:'" + Immigration_Data.previewButton + "', alignment:['left','top'],  helpTip:'" + Immigration_Data.previewButtonTip + "' }, "+
                "                    }, "+
                "                    }, "+
                "                    buttonsR: Group { "+
                "                    margins:0, "+
                "                    spacing:0, "+
                "                    orientation:'column', "+
                "                    alignment:['fill','bottom'], "+
                "                    alignChildren:['right','bottom'], "+
                "                    mode: Checkbox  { text:'" + Immigration_Data.proxyModeButton + "', }, "+
                "                    match: DropDownList { helpTip:'" + Immigration_Data.matchOptionsTip + "'  }, "+
                "                    doIt: Button { text:'" + Immigration_Data.goButton + "'}, "+
                "                    }, "+
                "                    }, "+
                "                } ";
            pal.grp = pal.add(res);
            var winGfx = pal.graphics;
            var darkColorPen = winGfx.newPen(winGfx.BrushType.SOLID_COLOR, [0, 0, 0], 1);
            var grayColorPen = winGfx.newPen(winGfx.BrushType.SOLID_COLOR, [0.3, 0.3, 0.3], 1);
            var greenColorPen = winGfx.newPen(winGfx.BrushType.SOLID_COLOR, [0, 0.5, 0], 1);
            var whiteColorPen = winGfx.newPen(winGfx.BrushType.SOLID_COLOR, [1, 1, 1], 1);
            var darkColorBrush = winGfx.newBrush(winGfx.BrushType.SOLID_COLOR, [0, 0, 0], 1);
            var greenColorBrush = winGfx.newBrush(winGfx.BrushType.SOLID_COLOR, [0, 0.5, 0], 1);
            var whiteColorBrush = winGfx.newBrush(winGfx.BrushType.SOLID_COLOR, [1, 1, 1], 1);
            var grayColorBrush = winGfx.newBrush(winGfx.BrushType.SOLID_COLOR, [0.5, 0.5, 0.5], 1);
            var boldFont = ScriptUI.newFont("dialog || palette", ScriptUI.FontStyle.BOLD, 12);
            var smallFont = ScriptUI.newFont("dialog || palette", ScriptUI.FontStyle.REGULAR, 9);
            if (parseFloat(app.version) >= 9) {

            }
            pal.grp.list.listing.listBox.graphics.foregroundColor = darkColorPen;
            if ($.os.indexOf("Windows") != -1) {
                pal.grp.list.listing.listBox3.graphics.foregroundColor = greenColorPen;
            } else {
                pal.grp.list.listing.listBox3.graphics.foregroundColor = darkColorPen;
            }
            pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.graphics.foregroundColor = darkColorPen;
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.graphics.foregroundColor = darkColorPen;
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.graphics.foregroundColor = darkColorPen;
            pal.grp.options.filter.graphics.foregroundColor = darkColorPen;
            pal.grp.buttons.buttonsR.match.graphics.foregroundColor = darkColorPen;
            pal.grp.dirs.name.graphics.foregroundColor = darkColorPen;
            if (parseFloat(app.version) < 10) {
                pal.grp.list.status1.graphics.foregroundColor = grayColorPen;
                pal.grp.list.status2.graphics.foregroundColor = grayColorPen;
            }
            pal.grp.list.status1.graphics.font = boldFont;
            pal.grp.list.status2.graphics.font = smallFont;
            pal.grp.list.graphics.backgroundColor = whiteColorBrush;
            pal.grp.options.filterType.graphics.foregroundColor = darkColorPen;
            pal.grp.options.space.preferredSize.width = 3;
            pal.grp.dirs.name.maximumSize.width = 310;
            pal.grp.list.status1.preferredSize.width = 310;
            pal.grp.list.status2.preferredSize.width = 310;
            pal.grp.buttons.preferredSize.width = 150;
            pal.grp.options.filterType.preferredSize.width = 60;
            pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.preferredSize.width = 51;
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.preferredSize.width = 34;
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.preferredSize.width = 34;
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
            pal.grp.buttons.buttonsR.mode.minimumSize.width = 150;
            pal.grp.buttons.buttonsR.doIt.size = [150, 55];
            pal.grp.list.listing.listBox2.visible = false;
            pal.grp.list.listing.listBox3.visible = false;
            pal.grp.options.browse.text = Immigration_Data.browseBtnStart;
            pal.grp.options.browse.maximumSize = [60, 25];
            pal.grp.options.browse.minimumSize = [60, 25];
            pal.grp.options.loadBtn.minimumSize = [40, 25];
            pal.grp.options.loadBtn.maximumSize = [40, 25];
            pal.grp.buttons.buttonsR.doIt.enabled = false;
            pal.grp.buttons.buttonsR.mode.visible = false;
            pal.grp.buttons.buttonsL.statusFR.status.preferredSize.width = 140;
            pal.grp.buttons.buttonsL.deSelect.visible = false;
            pal.grp.buttons.buttonsL.refresh.visible = false;
            pal.grp.buttons.buttonsL.deSelect.preferredSize.width = 150;
            pal.grp.buttons.buttonsL.refresh.preferredSize.width = 150;
            pal.grp.buttons.buttonsL.statusRange.preview.preferredSize.width = 146;
            pal.grp.buttons.buttonsL.statusRange.status.preferredSize.width = 165;
            pal.grp.buttons.buttonsL.statusFR.status.visible = false;
            pal.grp.buttons.buttonsL.statusFR.preview2.visible = false;
            pal.grp.buttons.buttonsL.statusRange.status.visible = false;
            pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
            if ($.os.indexOf("Windows") != -1) {
                pal.grp.options.spacing = 4;
                pal.grp.buttons.buttonsL.margins = 3;
                pal.grp.buttons.buttonsL.spacing = 2;
                pal.grp.buttons.buttonsR.margins = 2;
                pal.grp.buttons.buttonsR.spacing = 2;
                pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.preferredSize.width = 63;
                pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.preferredSize.width = 38;
                pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.preferredSize.width = 37;
                pal.grp.buttons.buttonsL.statusRange.preview.preferredSize.width = 150;
            }
            try {
                var largerFont = ScriptUI.newFont(Immigration_Data.LoadButtonFont, ScriptUI.FontStyle.REGULAR, Immigration_Data.LoadButtonFontSize);
                pal.grp.options.loadBtn.graphics.font = largerFont;
            } catch (err) {
                var largerFont = ScriptUI.newFont(Immigration_Data.LoadButtonFontAlt, ScriptUI.FontStyle.REGULAR, Immigration_Data.LoadButtonFontSizeAlt);
                pal.grp.options.loadBtn.text = Immigration_Data.LoadButtonShortAlt;
            }
            pal.grp.list.status2.text = "";
            pal.grp.options.filter.add("item", Immigration_Data.allFilter);
            for (var a = 0; a < Immigration_Data.validExtensionsArray.length; a += 1) {
                pal.grp.options.filter.add("item", Immigration_Data.validExtensionsArray[a]);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_extensionFilter")) {
                pal.grp.options.filter.selection = parseInt(app.settings.getSetting("aescripts", "Immigration_extensionFilter"), 10);
            } else {
                pal.grp.options.filter.selection = 0;
            }
            pal.grp.dirs.name.add("item", Immigration_Data.browseRecentInstr);
            pal.grp.dirs.name.visible = false;
            pal.grp.options.loadBtn.visible = false;
            for (var b = 0; b < Immigration_Data.matchOptions.length; b += 1) {
                pal.grp.buttons.buttonsR.match.add("item", Immigration_Data.matchOptions[b]);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_matchMode")) {
                pal.grp.buttons.buttonsR.match.selection = parseInt(app.settings.getSetting("aescripts", "Immigration_matchMode"), 10);
            } else {
                pal.grp.buttons.buttonsR.match.selection = 0;
            }
            pal.grp.buttons.buttonsR.match.maximumSize.width = 150;
            pal.grp.buttons.buttonsR.match.minimumSize.width = 150;
            pal.grp.buttons.buttonsR.match.visible = false;
            if (app.settings.haveSetting("aescripts", "Immigration_numRecentDir")) {
                var recentNum = parseInt(app.settings.getSetting("aescripts", "Immigration_numRecentDir"), 10);
            } else {
                var recentNum = Immigration_Data.recentFolders;
            }
            if (app.settings.haveSetting("aescripts", "Immigration_recentDir") && recentNum != 0) {
                pal.grp.dirs.name.visible = true;
                var recentDirArray = app.settings.getSetting("aescripts", "Immigration_recentDir").split(Immigration_Data.recentFolderArraySeparator);
                for (var i = 0; i < recentDirArray.length; i += 1) {
                    var dirTest = new Folder(recentDirArray[i]);
                    if (dirTest.exists) {
                        pal.grp.dirs.name.add("item", recentDirArray[i]);
                    }
                }
                pal.grp.dirs.name.selection = 0;
            }
            if (pal.grp.dirs.name.items.length == 1 && pal.grp.dirs.name.items[0].text == Immigration_Data.browseRecentInstr) {
                pal.grp.dirs.name.visible = false;
            }
            pal.grp.dirs.name.onChange = function () {
                if (pal.grp.options.filter.selection.text != Immigration_Data.allFilter) {
                    var myRegEx = ".(" + pal.grp.options.filter.selection.text + ")$";
                    Immigration_Data.extensionFilterRegex = new RegExp(myRegEx, "i");
                } else {
                    Immigration_Data.extensionFilterRegex = Immigration_Data.extensionFilterRegexAll;
                }
                var doFilter = true;
                if (this.selection != null) {
                    var mainDirTest = new Folder(this.selection.text);
                    if (mainDirTest.exists) {
                        var mainDir = this.selection.text;
                        if (pal.grp.dirs.name.selection.index != 0) {
                            var myStatus2 = this.parent.parent.parent.grp.list.status2;
                            changeDir(pal, mainDir, doFilter, myStatus2);
                            pal.grp.options.loadBtn.visible = true;
                            pal.grp.dirs.name.selection = 0;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = false;
                            pal.grp.buttons.buttonsR.doIt.enabled = false;
                            pal.grp.buttons.buttonsR.mode.visible = false;
                            setStatus(pal, mainDir);
                            selectListBoxText(pal);
                            pal.layout.resize();
                        }
                    } else {
                        if (pal.grp.dirs.name.selection.text != Immigration_Data.browseBtnStartInstr) {
                            alert("Unfinished search state\nThis happens if you hit Esc to stop a search.  Please try your search again without stopping and things should be back to normal working condition");
                            this.remove(this.selection.index);
                            this.selection = 0;
                        }
                    }
                }
                if (pal.grp.dirs.name.items.length == 0 || pal.grp.dirs.name.items.length == 1 && pal.grp.dirs.name.items[0].text == Immigration_Data.browseRecentInstr) {
                    pal.grp.dirs.name.visible = false;
                }
            };
            pal.grp.options.browse.onClick = function () {
                var goAhead = true;
                // if (pal.grp.dirs.name.visible == false
                // || (pal.grp.dirs.name.visible == true && pal.grp.dirs.name.selection.text == Immigration_Data.browseRecentInstr)) {
                //     var warn = true;
                //     if (app.settings.haveSetting("aescripts", "Immigration_initialWarning")) {
                //         var warnPref = app.settings.getSetting("aescripts", "Immigration_initialWarning");
                //         if (warnPref == "0") {
                //             warn = false;
                //         }
                //     }
                //     if (warn) {
                //         if (typeof initialWarningDialog_unitTest == "undefined") {
                //             goAhead = new initialWarningDialog().run();
                //         }
                //     }
                // }
                if (goAhead) {
                    if (pal.grp.options.filter.selection.text != Immigration_Data.allFilter) {
                        var myRegEx = ".(" + pal.grp.options.filter.selection.text + ")$";
                        Immigration_Data.extensionFilterRegex = new RegExp(myRegEx, "i");
                    } else {
                        Immigration_Data.extensionFilterRegex = Immigration_Data.extensionFilterRegexAll;
                    }
                    var myStatus2 = this.parent.parent.parent.grp.list.status2;
                    var doFilter = false;
                    var mainDir = "";
                    var validChangeDir = changeDir(this.parent.parent.parent, mainDir, doFilter, myStatus2);
                    if (validChangeDir != null) {
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                        pal.grp.buttons.buttonsR.doIt.enabled = false;
                        pal.grp.buttons.buttonsR.mode.visible = false;
                        pal.grp.dirs.name.selection = 0;
                        if (pal.grp.dirs.name.selection.text != Immigration_Data.browseRecentInstr) {
                            mainDir = pal.grp.dirs.name.selection.text;
                            setStatus(pal, mainDir);
                        }
                        selectListBoxText(pal);
                    }
                }
            };
            pal.grp.options.filter.onChange = function () {
                if (pal.grp.options.filter.selection.text != Immigration_Data.allFilter) {
                    var myRegEx = ".(" + pal.grp.options.filter.selection.text + ")$";
                    Immigration_Data.extensionFilterRegex = new RegExp(myRegEx, "i");
                } else {
                    Immigration_Data.extensionFilterRegex = Immigration_Data.extensionFilterRegexAll;
                }
                var doFilter = true;
                if (pal.grp.dirs.name.selection != null) {
                    if (pal.grp.dirs.name.selection.text == Immigration_Data.browseRecentInstr || pal.grp.dirs.name.selection.text == Immigration_Data.browseBtnStartInstr) {

                    } else {
                        var mainDir = pal.grp.dirs.name.selection.text;
                        var myStatus2 = this.parent.parent.parent.grp.list.status2;
                        changeDir(this.parent.parent.parent, mainDir, doFilter, myStatus2);
                        pal.grp.options.loadBtn.visible = true;
                        pal.grp.options.browse.text = Immigration_Data.browseBtn;
                        pal.grp.dirs.name.selection = 0;
                        pal.grp.buttons.buttonsR.doIt.enabled = false;
                        pal.grp.buttons.buttonsR.mode.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                        pal.grp.dirs.name.selection = 0;
                        setStatus(pal, mainDir);
                        selectListBoxText(pal);
                    }
                }
            };
            pal.grp.options.loadBtn.onClick = function () {
                if (pal.grp.options.filter.selection.text != Immigration_Data.allFilter) {
                    var myRegEx = ".(" + pal.grp.options.filter.selection.text + ")$";
                    Immigration_Data.extensionFilterRegex = new RegExp(myRegEx, "i");
                } else {
                    Immigration_Data.extensionFilterRegex = Immigration_Data.extensionFilterRegexAll;
                }
                var doFilter = true;
                var mainDir = pal.grp.dirs.name.selection.text;
                pal.grp.list.status1.text = Immigration_Data.reloading;
                var myStatus2 = this.parent.parent.parent.grp.list.status2;
                changeDir(this.parent.parent.parent, mainDir, doFilter, myStatus2);
                pal.grp.options.browse.text = Immigration_Data.browseBtn;
                pal.grp.buttons.buttonsR.doIt.enabled = false;
                pal.grp.buttons.buttonsR.mode.visible = false;
                pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                pal.grp.buttons.buttonsL.deSelect.visible = false;
                pal.grp.dirs.name.selection = 0;
                setStatus(pal, mainDir);
                selectListBoxText(pal);
            };
            pal.grp.buttons.buttonsR.mode.onClick = function () {
                if (this.text == Immigration_Data.proxyModeButton) {
                    if (this.value) {
                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceProxyButton;
                    } else {
                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceButton;
                    }
                    if (!pal.grp.list.listing.listBox3.visible) {
                        pal.grp.buttons.buttonsL.statusFR.status.visible = !this.value;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = this.value;
                        pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                        pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                        pal.grp.buttons.buttonsL.refresh.visible = true;
                        pal.grp.buttons.buttonsR.match.visible = true;
                    }
                    if (pal.grp.buttons.buttonsL.statusRange.preview.text != Immigration_Data.previewButton) {
                        buildReplaceHelpTip(pal.grp.list.listing.listBox, pal.grp.list.listing.listBox2, pal);
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                    }
                }
            };
            pal.grp.buttons.buttonsR.match.onChange = function () {
                if (pal.grp.buttons.buttonsL.statusRange.preview.text != Immigration_Data.previewButton) {
                    buildReplaceHelpTip(pal.grp.list.listing.listBox, pal.grp.list.listing.listBox2, pal);
                    pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                }
                app.settings.saveSetting("aescripts", "Immigration_matchMode", pal.grp.buttons.buttonsR.match.selection.index);
            };
            pal.grp.buttons.buttonsL.statusRange.preview.onClick = function () {
                if (this.text == Immigration_Data.previewButton) {
                    buildReplaceHelpTip(pal.grp.list.listing.listBox, pal.grp.list.listing.listBox2, pal);
                    pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                    mainDir = pal.grp.list.status1.text;
                    pal.grp.list.listing.listBox.visible = false;
                    pal.grp.list.listing.listBox3.visible = true;
                    pal.grp.buttons.buttonsL.refresh.visible = false;
                    pal.grp.buttons.buttonsL.deSelect.visible = false;
                    pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                    this.text = Immigration_Data.closePreviewButton;
                    this.helpTip = Immigration_Data.closePreviewButtonTip;
                    pal.grp.list.status1.text = Immigration_Data.listBoxPreviewTitle;
                    pal.grp.options.enabled = false;
                    pal.grp.dirs.enabled = false;
                    pal.layout.layout(true);
                    pal.layout.resize();
                } else {
                    pal.grp.buttons.buttonsL.refresh.visible = true;
                    pal.grp.buttons.buttonsL.deSelect.visible = true;
                    if (pal.grp.buttons.buttonsR.mode.value) {
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                    }
                    this.text = Immigration_Data.previewButton;
                    this.helpTip = Immigration_Data.previewButtonTip;
                    pal.grp.list.listing.listBox.visible = true;
                    pal.grp.list.listing.listBox3.visible = false;
                    pal.grp.list.graphics.backgroundColor = whiteColorBrush;
                    pal.grp.list.status1.graphics.foregroundColor = grayColorPen;
                    pal.grp.list.status1.text = mainDir.slice(mainDir.lastIndexOf("/") + 1);
                    pal.grp.options.enabled = true;
                    pal.grp.dirs.enabled = true;
                    pal.layout.layout(true);
                    pal.layout.resize();
                }
            };
            pal.grp.buttons.buttonsL.refresh.onClick = function () {
                var frameRange = "1-1";
                var myRange = [1, 1];
                var isSeq = false;
                if (pal.grp.list.listing.listBox.selection != null) {
                    var mySel = (pal.grp.list.listing.listBox.items[pal.grp.list.listing.listBox.selection[0].index]).toString();
                    if (pal.grp.list.listing.listBox.selection.length == 1 && mySel.match(Immigration_Data.nonSequenceRegex) == null) {
                        if (mySel.indexOf("[") != -1) {
                            var myRangeText = mySel.slice(mySel.indexOf("[") + 1, mySel.indexOf("]"));
                            myRange = myRangeText.split("-");
                            isSeq = true;
                        } else {
                            isSeq = false;
                            myRange = [1, 1];
                        }
                    }
                    if (pal.grp.list.listing.listBox.selection.length != 1 || pal.grp.list.listing.listBox.selection == null || !isSeq) {
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        pal.grp.buttons.buttonsL.deSelect.visible = true;
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        pal.grp.buttons.buttonsR.mode.visible = true;
                    } else {
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = true;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.text = myRange[0];
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.text = myRange[1];
                        pal.grp.buttons.buttonsL.deSelect.visible = true;
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        pal.grp.buttons.buttonsR.mode.visible = true;
                    }
                    if (pal.grp.list.listing.listBox.selection.length == 1 && !isSeq) {
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                    } else {
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                    }
                    if (pal.grp.list.listing.listBox.selection.length > 0) {
                        pal.grp.buttons.buttonsR.doIt.enabled = true;
                        pal.grp.buttons.buttonsL.deSelect.visible = true;
                    }
                    if (pal.grp.list.listing.listBox.selection.length == 0) {
                        pal.grp.buttons.buttonsR.doIt.visible = false;
                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                        pal.grp.buttons.buttonsR.doIt.enabled = false;
                        pal.grp.buttons.buttonsR.mode.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                    }
                    if (app.project.selection.length > 0) {
                        if (app.project.selection[0] instanceof FolderItem) {
                            pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goFolderButton;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                            pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                            pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        } else {
                            if (app.project.selection[0] instanceof FootageItem || app.project.selection[0] instanceof CompItem) {
                                pal.grp.buttons.buttonsR.mode.visible = true;
                                if (pal.grp.buttons.buttonsR.mode.value) {
                                    pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceProxyButton;
                                } else {
                                    pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceButton;
                                }
                                pal.grp.buttons.buttonsR.mode.text = Immigration_Data.proxyModeButton;
                                pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.proxyModeButtonHelpTip;
                                pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                                pal.grp.buttons.buttonsL.statusFR.status.text = Immigration_Data.selectedItems;
                                pal.grp.buttons.buttonsL.statusFR.status.visible = !pal.grp.buttons.buttonsR.mode.value;
                                pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = pal.grp.buttons.buttonsR.mode.value;
                                pal.grp.buttons.buttonsL.statusRange.status.text = "Project:" + app.project.selection.length + ", Immigration:" + pal.grp.list.listing.listBox.selection.length;
                                pal.grp.buttons.buttonsL.statusRange.status.visible = true;
                                pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                pal.grp.buttons.buttonsL.deSelect.visible = true;
                                pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                                pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                                pal.grp.buttons.buttonsL.refresh.visible = true;
                                pal.grp.buttons.buttonsR.match.visible = true;
                                if (app.project.selection.length == pal.grp.list.listing.listBox.selection.length) {
                                    pal.grp.buttons.buttonsR.doIt.enabled = true;
                                    pal.grp.buttons.buttonsR.mode.text = Immigration_Data.proxyModeButton;
                                    pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.proxyModeButtonHelpTip;
                                    pal.grp.buttons.buttonsL.statusFR.status.text = Immigration_Data.readyToReplace;
                                    pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                    pal.grp.buttons.buttonsL.statusRange.preview.visible = true;
                                } else {
                                    pal.grp.buttons.buttonsR.doIt.enabled = false;
                                    pal.grp.list.listing.listBox.helpTip = Immigration_Data.unevenSelection;
                                    pal.grp.buttons.buttonsR.doIt.helpTip = Immigration_Data.unevenSelection;
                                    alert(Immigration_Data.refreshFail);
                                }
                            } else {
                                if (pal.grp.list.listing.listBox.selection.length == 1 && isSeq) {
                                    pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                                }
                                pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                                pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                                pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                                pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                                pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                                pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                                pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                                pal.grp.buttons.buttonsL.refresh.visible = true;
                                pal.grp.buttons.buttonsR.match.visible = true;
                                pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                            }
                        }
                    } else {
                        if (pal.grp.list.listing.listBox.selection.length == 1 && isSeq) {
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        }
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                        pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                        pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                        pal.grp.buttons.buttonsL.refresh.visible = false;
                        pal.grp.buttons.buttonsR.match.visible = false;
                        alert(Immigration_Data.switchToReplaceError);
                        pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                    }
                }
            };
            pal.grp.buttons.buttonsL.deSelect.onClick = function () {
                if (this.text == Immigration_Data.switchToImportButton) {
                    pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                    pal.grp.buttons.buttonsR.doIt.enabled = true;
                    if (pal.grp.list.listing.listBox.selection != null) {
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.doIt.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for " + pal.grp.buttons.buttonsR.doIt.text;
                    } else {
                        pal.grp.list.listing.listBox.helpTip = "No items selected for " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.doIt.helpTip = "No items selected for " + pal.grp.buttons.buttonsR.doIt.text;
                    }
                    pal.grp.buttons.buttonsR.mode.visible = false;
                    pal.grp.buttons.buttonsR.mode.value = false;
                    pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                    pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                    pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                    pal.grp.buttons.buttonsL.deSelect.visible = false;
                    pal.grp.buttons.buttonsL.refresh.visible = false;
                    pal.grp.buttons.buttonsR.match.visible = false;
                    pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                    pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                    pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                    pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                    pal.grp.options.filterType.text = "";
                    if (pal.grp.list.listing.listBox.selection != null) {
                        var mySel = (pal.grp.list.listing.listBox.items[pal.grp.list.listing.listBox.selection[0].index]).toString();
                        if (pal.grp.list.listing.listBox.selection.length == 1 && mySel.match(Immigration_Data.nonSequenceRegex) == null) {
                            if (mySel.indexOf("[") != -1) {
                                var myRangeText = mySel.slice(mySel.indexOf("[") + 1, mySel.indexOf("]"));
                                myRange = myRangeText.split("-");
                                isSeq = true;
                            } else {
                                isSeq = false;
                                myRange = [1, 1];
                            }
                        }
                        if (pal.grp.list.listing.listBox.selection.length != 1 || pal.grp.list.listing.listBox.selection == null || !isSeq) {
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                            pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                            pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                            pal.grp.buttons.buttonsL.refresh.visible = false;
                            pal.grp.buttons.buttonsR.match.visible = false;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                            pal.grp.buttons.buttonsR.mode.visible = true;
                        } else {
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = true;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.text = myRange[0];
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.text = myRange[1];
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                            pal.grp.buttons.buttonsR.mode.visible = true;
                        }
                        if (pal.grp.list.listing.listBox.selection.length == 1 && !isSeq) {
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        } else {
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        }
                        if (pal.grp.list.listing.listBox.selection.length > 0) {
                            pal.grp.buttons.buttonsR.doIt.enabled = true;
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                        }
                        if (pal.grp.list.listing.listBox.selection.length == 0) {
                            pal.grp.buttons.buttonsR.doIt.visible = false;
                            pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                            pal.grp.buttons.buttonsR.doIt.enabled = false;
                            pal.grp.buttons.buttonsR.mode.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                            pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                            pal.grp.buttons.buttonsL.refresh.visible = false;
                            pal.grp.buttons.buttonsR.match.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = false;
                        }
                    }
                    for (var i = 1; i <= app.project.numItems; i += 1) {
                        app.project.item(i).selected = false
                    }
                } else {
                    var frameRange = "1-1";
                    var myRange = [1, 1];
                    var isSeq = false;
                    if (pal.grp.list.listing.listBox.selection != null) {
                        var mySel = (pal.grp.list.listing.listBox.items[pal.grp.list.listing.listBox.selection[0].index]).toString();
                        if (pal.grp.list.listing.listBox.selection.length == 1 && mySel.match(Immigration_Data.nonSequenceRegex) == null) {
                            if (mySel.indexOf("[") != -1) {
                                var myRangeText = mySel.slice(mySel.indexOf("[") + 1, mySel.indexOf("]"));
                                myRange = myRangeText.split("-");
                                isSeq = true;
                            } else {
                                isSeq = false;
                                myRange = [1, 1];
                            }
                        }
                        if (pal.grp.list.listing.listBox.selection.length != 1 || pal.grp.list.listing.listBox.selection == null || !isSeq) {
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                            pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                            pal.grp.buttons.buttonsR.mode.visible = true;
                        } else {
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = true;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.text = myRange[0];
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.text = myRange[1];
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                            pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                            pal.grp.buttons.buttonsR.mode.visible = true;
                        }
                        if (pal.grp.list.listing.listBox.selection.length == 1 && !isSeq) {
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        } else {
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        }
                        if (pal.grp.list.listing.listBox.selection.length > 0) {
                            pal.grp.buttons.buttonsR.doIt.enabled = true;
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                        }
                        if (pal.grp.list.listing.listBox.selection.length == 0) {
                            pal.grp.buttons.buttonsR.doIt.visible = false;
                            pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                            pal.grp.buttons.buttonsR.doIt.enabled = false;
                            pal.grp.buttons.buttonsR.mode.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = false;
                        }
                        if (app.project.selection.length > 0) {
                            if (app.project.selection[0] instanceof FolderItem) {
                                pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goFolderButton;
                                pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                                pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                                pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                                pal.grp.buttons.buttonsL.deSelect.visible = true;
                                pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                                pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                                pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                            } else {
                                if (app.project.selection[0] instanceof FootageItem || app.project.selection[0] instanceof CompItem) {
                                    pal.grp.buttons.buttonsR.mode.visible = true;
                                    if (pal.grp.buttons.buttonsR.mode.value) {
                                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceProxyButton;
                                    } else {
                                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceButton;
                                    }
                                    pal.grp.buttons.buttonsR.mode.text = Immigration_Data.proxyModeButton;
                                    pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.proxyModeButtonHelpTip;
                                    pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                                    pal.grp.buttons.buttonsL.statusFR.status.text = "Selected Items:";
                                    pal.grp.buttons.buttonsL.statusFR.status.visible = !pal.grp.buttons.buttonsR.mode.value;
                                    pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = pal.grp.buttons.buttonsR.mode.value;
                                    pal.grp.buttons.buttonsL.statusRange.status.text = "Project:" + app.project.selection.length + ", Immigration:" + pal.grp.list.listing.listBox.selection.length;
                                    pal.grp.buttons.buttonsL.statusRange.status.visible = true;
                                    pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                    pal.grp.buttons.buttonsL.deSelect.visible = true;
                                    pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                                    pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                                    pal.grp.buttons.buttonsL.refresh.visible = true;
                                    pal.grp.buttons.buttonsR.match.visible = true;
                                    if (app.project.selection.length == pal.grp.list.listing.listBox.selection.length) {
                                        pal.grp.buttons.buttonsR.doIt.enabled = true;
                                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.proxyModeButton;
                                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.proxyModeButtonHelpTip;
                                        pal.grp.buttons.buttonsL.statusFR.status.text = Immigration_Data.readyToReplace;
                                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                        pal.grp.buttons.buttonsL.statusRange.preview.visible = true;
                                    } else {
                                        pal.grp.buttons.buttonsR.doIt.enabled = false;
                                        pal.grp.list.listing.listBox.helpTip = Immigration_Data.unevenSelection;
                                        pal.grp.buttons.buttonsR.doIt.helpTip = Immigration_Data.unevenSelection;
                                    }
                                } else {
                                    if (pal.grp.list.listing.listBox.selection.length == 1 && isSeq) {
                                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                                    }
                                    pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                                    pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                                    pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                                    pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                                    pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                                    pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                                    pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                                    pal.grp.buttons.buttonsL.refresh.visible = true;
                                    pal.grp.buttons.buttonsR.match.visible = true;
                                    pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                    pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                }
                            }
                        } else {
                            if (pal.grp.list.listing.listBox.selection.length == 1 && isSeq) {
                                pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            }
                            pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                            pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                            pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                            pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                            pal.grp.buttons.buttonsL.refresh.visible = false;
                            pal.grp.buttons.buttonsR.match.visible = false;
                            alert(Immigration_Data.switchToReplaceError);
                            pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                        }
                    }
                }
            };
            var onChangingThreshold = 50;
            pal.grp.options.filterType.onChanging = function () {
                if (pal.grp.list.listing.listBox.items.length < onChangingThreshold) {
                    var myType = this.text.replace(/[-[\]{}()*+?.\\^$|,#\s]/g, "\\$&");
                    for (var i = 0; i < pal.grp.list.listing.listBox.items.length; i += 1) {
                        try {
                            if (this.text != "" && (pal.grp.list.listing.listBox.items[i]).text.match(myType)) {
                                (pal.grp.list.listing.listBox.items[i]).selected = true;
                            } else {
                                (pal.grp.list.listing.listBox.items[i]).selected = false;
                            }
                        } catch (err) {
                            alert(Immigration_Data.filterError + " - " + err.toString());
                            this.text = "";
                        }
                    }
                }
            };
            pal.grp.options.filterType.onChange = function () {
                if (pal.grp.list.listing.listBox.items.length > onChangingThreshold) {
                    var myType = this.text.replace(/[-[\]{}()*+?.\\^$|,#\s]/g, "\\$&");
                    for (var i = 0; i < pal.grp.list.listing.listBox.items.length; i += 1) {
                        try {
                            if (this.text != "" && (pal.grp.list.listing.listBox.items[i]).text.match(myType)) {
                                (pal.grp.list.listing.listBox.items[i]).selected = true;
                            } else {
                                (pal.grp.list.listing.listBox.items[i]).selected = false;
                            }
                        } catch (err) {
                            alert(Immigration_Data.filterError + " - " + err.toString());
                        }
                    }
                }
            };
            pal.grp.list.listing.listBox.onChange = function () {
                var frameRange = "1-1";
                var myRange = [1, 1];
                var isSeq = false;
                if (this.selection != null) {
                    var mySel = (this.items[this.selection[0].index]).toString();
                    if (this.selection.length == 1 && mySel.match(Immigration_Data.nonSequenceRegex) == null) {
                        if (mySel.indexOf("[") != -1) {
                            var myRangeText = mySel.slice(mySel.indexOf("[") + 1, mySel.indexOf("]"));
                            myRange = myRangeText.split("-");
                            isSeq = true;
                        } else {
                            isSeq = false;
                            myRange = [1, 1];
                        }
                    }
                    if (this.selection.length != 1 || this.selection == null || !isSeq) {
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        pal.grp.buttons.buttonsL.deSelect.visible = true;
                        pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                        pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                        pal.grp.buttons.buttonsL.refresh.visible = false;
                        pal.grp.buttons.buttonsR.match.visible = false;
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        pal.grp.buttons.buttonsR.mode.visible = true;
                    } else {
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = true;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.text = myRange[0];
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.text = myRange[1];
                        pal.grp.buttons.buttonsL.deSelect.visible = true;
                        pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                        pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                        pal.grp.buttons.buttonsL.refresh.visible = false;
                        pal.grp.buttons.buttonsR.match.visible = false;
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        pal.grp.buttons.buttonsR.mode.visible = true;
                    }
                    if (this.selection.length == 1 && !isSeq) {
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                    } else {
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                    }
                    if (this.selection.length > 0) {
                        pal.grp.buttons.buttonsR.doIt.enabled = true;
                        pal.grp.buttons.buttonsL.deSelect.visible = true;
                    }
                    if (this.selection.length == 0) {
                        pal.grp.buttons.buttonsR.doIt.visible = false;
                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                        pal.grp.buttons.buttonsR.doIt.enabled = false;
                        pal.grp.buttons.buttonsR.mode.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                    }
                    if (app.project.selection.length > 0) {
                        if (app.project.selection[0] instanceof FolderItem) {
                            pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goFolderButton;
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                            pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                            pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                            pal.grp.buttons.buttonsL.deSelect.visible = true;
                            pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                            pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                            pal.grp.buttons.buttonsL.refresh.visible = true;
                            pal.grp.buttons.buttonsR.match.visible = true;
                            pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                            pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                            pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                            pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                            pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        } else {
                            if (app.project.selection[0] instanceof FootageItem || app.project.selection[0] instanceof CompItem) {
                                pal.grp.buttons.buttonsR.mode.visible = true;
                                if (pal.grp.buttons.buttonsR.mode.value) {
                                    pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceProxyButton;
                                } else {
                                    pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.replaceButton;
                                }
                                pal.grp.buttons.buttonsR.mode.text = Immigration_Data.proxyModeButton;
                                pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.proxyModeButtonHelpTip;
                                pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                                pal.grp.buttons.buttonsL.statusFR.status.text = "Selected Items:";
                                pal.grp.buttons.buttonsL.statusFR.status.visible = !pal.grp.buttons.buttonsR.mode.value;
                                pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = pal.grp.buttons.buttonsR.mode.value;
                                pal.grp.buttons.buttonsL.statusRange.status.text = "Project:" + app.project.selection.length + ", Immigration:" + this.selection.length;
                                pal.grp.buttons.buttonsL.statusRange.status.visible = true;
                                pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                pal.grp.buttons.buttonsL.deSelect.visible = true;
                                pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                                pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                                pal.grp.buttons.buttonsL.refresh.visible = true;
                                pal.grp.buttons.buttonsR.match.visible = true;
                                if (app.project.selection.length == this.selection.length) {
                                    pal.grp.buttons.buttonsR.doIt.enabled = true;
                                    pal.grp.buttons.buttonsR.mode.text = Immigration_Data.proxyModeButton;
                                    pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.proxyModeButtonHelpTip;
                                    pal.grp.buttons.buttonsL.statusFR.status.text = Immigration_Data.readyToReplace;
                                    pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                    pal.grp.buttons.buttonsL.statusRange.preview.visible = true;
                                } else {
                                    pal.grp.buttons.buttonsR.doIt.enabled = false;
                                    this.helpTip = Immigration_Data.unevenSelection;
                                    pal.grp.buttons.buttonsR.doIt.helpTip = Immigration_Data.unevenSelection;
                                }
                            } else {
                                if (this.selection.length == 1 && isSeq) {
                                    pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                                }
                                pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                                pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                                pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                                pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                                pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                                pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToImportButton;
                                pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToImportButtonTip;
                                pal.grp.buttons.buttonsL.refresh.visible = true;
                                pal.grp.buttons.buttonsR.match.visible = true;
                                pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                            }
                        }
                    } else {
                        if (this.selection.length == 1 && isSeq) {
                            pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = true;
                        }
                        pal.grp.list.listing.listBox.helpTip = pal.grp.list.listing.listBox.selection.length + " items selected for  " + pal.grp.buttons.buttonsR.doIt.text;
                        pal.grp.buttons.buttonsR.mode.text = Immigration_Data.hierarchyButton;
                        pal.grp.buttons.buttonsR.mode.helpTip = Immigration_Data.hierarchyButtonHelpTip;
                        pal.grp.buttons.buttonsR.doIt.text = Immigration_Data.goButton;
                        pal.grp.buttons.buttonsL.deSelect.text = Immigration_Data.switchToReplaceButton;
                        pal.grp.buttons.buttonsL.deSelect.helpTip = Immigration_Data.switchToReplaceButtonTip;
                        pal.grp.buttons.buttonsL.refresh.visible = false;
                        pal.grp.buttons.buttonsR.match.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                    }
                }
            };
            pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.onChange = function () {
                var myFR = parseInt(this.text, 10);
                if (myFR < 0.01) {
                    this.text = 0.01;
                }
                if (myFR > 99) {
                    this.text = 99;
                }
                app.settings.saveSetting("aescripts", "Immigration_frameRate", pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text);
            };
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.onChange = function () {
                var frameRange = "1-1";
                var myRange = [1, 1];
                var isSeq = false;
                var mySel = (pal.grp.list.listing.listBox.items[pal.grp.list.listing.listBox.selection[0].index]).toString();
                if (pal.grp.list.listing.listBox.selection.length == 1 && mySel.match(Immigration_Data.nonSequenceRegex) == null) {
                    if (mySel.indexOf("[") != -1) {
                        var myRangeText = mySel.slice(mySel.indexOf("[") + 1, mySel.indexOf("]"));
                        myRange = myRangeText.split("-");
                        isSeq = true;
                    }
                }
                var userSetIn = parseInt(this.text, 10);
                var userSetOut = parseInt(pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.text, 10);
                var rangeIn = parseInt(myRange[0], 10);
                var rangeOut = parseInt(myRange[1], 10);
                if (userSetIn < rangeIn) {
                    this.text = rangeIn;
                }
                if (userSetIn > rangeOut || userSetIn > userSetOut) {
                    alert(Immigration_Data.FrameRangeErrorIn);
                    this.text = rangeIn;
                }
            };
            pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.onChange = function () {
                var frameRange = "1-1";
                var myRange = [1, 1];
                var isSeq = false;
                var mySel = (pal.grp.list.listing.listBox.items[pal.grp.list.listing.listBox.selection[0].index]).toString();
                if (pal.grp.list.listing.listBox.selection.length == 1 && mySel.match(Immigration_Data.nonSequenceRegex) == null) {
                    if (mySel.indexOf("[") != -1) {
                        var myRangeText = mySel.slice(mySel.indexOf("[") + 1, mySel.indexOf("]"));
                        myRange = myRangeText.split("-");
                        isSeq = true;
                    }
                }
                var userSetIn = parseInt(pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.text, 10);
                var userSetOut = parseInt(this.text, 10);
                var rangeIn = parseInt(myRange[0], 10);
                var rangeOut = parseInt(myRange[1], 10);
                if (userSetOut > rangeOut) {
                    this.text = rangeOut;
                }
                if (userSetOut < rangeIn || userSetOut < userSetIn) {
                    alert(Immigration_Data.FrameRangeErrorOut);
                    this.text = rangeOut;
                }
            };
            pal.grp.buttons.buttonsR.doIt.onClick = function () {
                clearOutput();
                write(this.text + " in progress...");
                var saveStatus1 = pal.grp.list.status1.text;
                var saveStatus2 = pal.grp.list.status2.text;
                var projSelection = app.project.selection;
                var goAhead = true;
                var setFolder = false;
                var replaceFile = false;
                var replaceError = false;
                var projSelArray = new Array();
                if (projSelection.length > 0) {
                    if (projSelection.length == 1 && projSelection[0] instanceof FolderItem) {
                        setFolder = true;
                        var saveFolder = projSelection[0];
                        replaceFile = false;
                    } else {
                        var saveFolder = null;
                        for (var m = 0; m < projSelection.length; m += 1) {
                            projSelArray[m] = projSelection[m];
                            if (projSelection[m] instanceof FootageItem) {
                                replaceFile = true;
                                setFolder = false;
                            } else {
                                replaceFile = false;
                                if (pal.grp.buttons.buttonsR.mode.value && pal.grp.buttons.buttonsR.mode.text == Immigration_Data.proxyModeButton && projSelection[m] instanceof CompItem) {
                                    replaceError = false;
                                    replaceFile = true;
                                } else {
                                    replaceError = true;
                                    break;
                                }
                            }
                        }
                    }
                }
                if (pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.replaceButton || pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.replaceProxyButton && replaceError) {
                    alert(Immigration_Data.replaceError);
                    goAhead = false;
                }
                if (projSelection.length == 0 && pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.replaceButton || pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.replaceProxyButton) {
                    goAhead = confirm(Immigration_Data.importError.replace(/%RB/g, pal.grp.buttons.buttonsR.doIt.text));
                }
                if (projSelection.length > 0 && pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.goButton && !(projSelection.length == 1 && projSelection[0] instanceof FolderItem)) {
                    alert(Immigration_Data.importError2);
                    goAhead = false;
                }
                if (projSelection.length == 1 && projSelection[0] instanceof FolderItem && pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.replaceButton || pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.replaceProxyButton) {
                    goAhead = confirm(Immigration_Data.importError3.replace(/%RB/g, pal.grp.buttons.buttonsR.doIt.text));
                }
                if (projSelection.length == 1 && projSelection[0] instanceof FolderItem && pal.grp.buttons.buttonsR.doIt.text == Immigration_Data.goButton) {
                    goAhead = confirm(Immigration_Data.importError4);
                }
                if (goAhead) {
                    var mySel = pal.grp.list.listing.listBox;
                    var mySelselection = pal.grp.list.listing.listBox.selection;
                    var mySel2 = pal.grp.list.listing.listBox2;
                    if (mySelselection == null) {
                        alert(Immigration_Data.nothingSelected);
                    } else {
                        var undoStr = Immigration_Data.scriptName;
                        app.beginUndoGroup(undoStr + "-" + pal.grp.buttons.buttonsR.doIt.text);
                        if (pal.grp.buttons.buttonsR.mode.value && pal.grp.buttons.buttonsR.mode.text == Immigration_Data.hierarchyButton) {
                            var setHierarchy = true;
                        } else {
                            var setHierarchy = false;
                        }
                        var includeCurrentFolder = true;
                        if (setFolder) {
                            var mySavedParentFolder = saveFolder;
                        } else {
                            var mySavedParentFolder = app.project.rootFolder;
                        }
                        mainDir = pal.grp.dirs.name.selection.text;
                        if (replaceFile && pal.grp.buttons.buttonsR.match.selection.index == 0) {
                            var mySel2Array = new Array();
                            for (var j = 0; j < mySelselection.length; j += 1) {
                                var mySelitem = (mySel.items[(mySelselection[j]).index]).toString();
                                var mySel2item = (mySel2.items[(mySelselection[j]).index]).toString();
                                var mySel2PiecesArray = mySel2item.split(":");
                                if (mySel2PiecesArray.length < 2) {
                                    var shortLength = 2 - mySel2PiecesArray.length;
                                    for (var m = 0; m <= shortLength; m += 1) {
                                        mySel2PiecesArray.push("");
                                    }
                                }
                                mySel2PiecesArray.push(mySelitem.slice(mySelitem.lastIndexOf("/") + 1));
                                mySel2Array[j] = mySel2PiecesArray;
                            }
                            var myProjSelection = app.project.selection;
                            var myProjArray = new Array();
                            for (var r = 0; r < myProjSelection.length; r += 1) {
                                if (myProjSelection[r] instanceof FootageItem) {
                                    var myType = "Footage";
                                    if ((myProjSelection[r]).mainSource.file != null) {
                                        var myProjItem = unescape((myProjSelection[r]).file.name);
                                        if (!(myProjSelection[r]).mainSource.isStill) {
                                            var testA = Immigration_Data.endMatchRegex.exec(myProjItem);
                                            var testAint = parseInt(testA, 10);
                                            if (testA != null) {
                                                var namePrefix = myProjItem.slice(0, myProjItem.search(testA[0]));
                                                var nameExt = "." + testA[2];
                                            } else {
                                                var dotPos = myProjItem.lastIndexOf(".");
                                                if (dotPos == -1) {
                                                    var namePrefix = myProjItem;
                                                    var nameExt = "";
                                                } else {
                                                    var namePrefix = myProjItem.slice(0, dotPos);
                                                    var nameExt = "." + myProjItem.slice(dotPos + 1, myProjItem.length);
                                                }
                                            }
                                        } else {
                                            var dotPos = myProjItem.lastIndexOf(".");
                                            if (dotPos == -1) {
                                                var namePrefix = myProjItem;
                                                var nameExt = "";
                                            } else {
                                                var namePrefix = myProjItem.slice(0, dotPos);
                                                var nameExt = "." + myProjItem.slice(dotPos + 1, myProjItem.length);
                                            }
                                        }
                                    } else {
                                        var myProjItem = (myProjSelection[r]).name;
                                        var nameExt = "";
                                    }
                                } else {
                                    var namePrefix = (myProjSelection[r]).name + " because it is not a footage item.";
                                    if (myProjSelection[r] instanceof CompItem) {
                                        var myType = "Comp";
                                    } else {
                                        var myType = "Error";
                                    }
                                }
                                myProjArray[r] = [namePrefix, nameExt, myType, myProjSelection[r]];
                            }
                            myProjArray.reverse();
                            app.project.showWindow(false);
                            app.project.showWindow(true);
                            app.executeCommand(2004);
                            var myCounter = 0;
                            var myProjArrayLength = myProjArray.length;
                            var s = myProjArray.length - 1;
                            while (myProjArray.length > 0) {
                                clearOutput();
                                writeLn(this.text + " Auto-Match Mode" + " in progress...");
                                if (s < 0) {
                                    s = myProjArray.length - 1;
                                }
                                var myLevenDistances = new Array();
                                for (var t = 0; t < mySel2Array.length; t += 1) {
                                    myLevenDistances[t] = [PadDigits(levenDistance((mySel2Array[t])[1] + (mySel2Array[t])[2], (myProjArray[s])[0] + (myProjArray[s])[1]), Immigration_Data.padAmount), (mySel2Array[t])[0], t];
                                }
                                myLevenDistances.sort();
                                myCounter++;
                                if (Immigration_Data.moreAccurateAutoMatch) {
                                    if (parseInt(myLevenDistances[0], 10) > Immigration_Data.autoMatchLevenDistanceTolerance && myCounter < myProjArrayLength) {
                                        s--;
                                        continue;
                                    }
                                }
                                var isSequence = true;
                                if (myLevenDistances[0][1].search(/\[1-1\]$/) != -1) {
                                    isSequence = false;
                                }
                                var cleanedName = myLevenDistances[0][1].slice(Immigration_Data.padAmount, myLevenDistances[0][1].lastIndexOf("["));
                                var myFile = File(Folder.encode(mainDir) + "/" + cleanedName);
                                if (myFile.exists) {
                                    var io = new ImportOptions(myFile);
                                } else {
                                    alert(Immigration_Data.missingFileError + "\n\n" + File.decode(myFile));
                                    break;
                                }
                                var saveOldNameForExpressionsFix = (myProjArray[s])[3].name;
                                if (!pal.grp.buttons.buttonsR.mode.value) {
                                    if (isSequence) {
                                        try {
                                            (myProjArray[s])[3].replaceWithSequence(myFile, false);
                                        } catch (err) {
                                            alert(err.toString());
                                            break;
                                        }
                                    } else {
                                        try {
                                            var theNewFile = (myProjArray[s])[3].replace(myFile);
                                        } catch (err) {
                                            alert(err.toString());
                                            break;
                                        }
                                    }
                                    app.project.autoFixExpressions(saveOldNameForExpressionsFix, (myProjArray[s])[3].name);
                                } else {
                                    if (isSequence) {
                                        try {
                                            (myProjArray[s])[3].setProxyWithSequence(myFile, false);
                                            (myProjArray[s])[3].proxySource.conformFrameRate = pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text;
                                        } catch (err) {
                                            alert(err.toString());
                                            break;
                                        }
                                    } else {
                                        try {
                                            (myProjArray[s])[3].setProxy(myFile);
                                        } catch (err) {
                                            alert(err.toString());
                                            break;
                                        }
                                    }
                                }
                                pal.grp.buttons.buttonsR.mode.visible = false;
                                pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                                pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                (myProjArray[s])[3].selected = true;
                                mySel2Array.splice(parseInt(myLevenDistances[0][2], 10), 1);
                                myProjArray.splice(s, 1);
                                pal.grp.list.status1.text = this.text + " in progress...";
                                pal.grp.list.status2.text = (myProjArrayLength - s) + " out of " + myProjArrayLength;
                                writeLn(this.text + ": " + (myProjArrayLength - s) + " out of " + myProjArrayLength);
                                s--;
                            }
                        } else {
                            app.project.showWindow(false);
                            app.project.showWindow(true);
                            app.executeCommand(2004);
                            var mySel2Array = new Array();
                            for (var j = 0; j < mySelselection.length; j += 1) {
                                mySel2Array[j] = (mySel2.items[(mySelselection[j]).index]).toString().split(":")[0];
                            }
                            mySel2Array.sort();
                            for (var i = 0; i < mySelselection.length; i += 1) {
                                clearOutput();
                                writeLn(this.text + " in progress...");
                                var isSequence = false;
                                if ((mySel2Array[i]).search(/\[1-1\]$/) == -1) {
                                    var cleanedName = (mySel2Array[i]).slice(Immigration_Data.padAmount, (mySel2Array[i]).lastIndexOf("["));
                                    isSequence = true;
                                } else {
                                    var cleanedName = (mySel2Array[i]).slice(Immigration_Data.padAmount, (mySel2Array[i]).lastIndexOf("["));
                                }
                                var myFile = File(Folder.encode(mainDir) + "/" + cleanedName);
                                if (myFile.exists) {
                                    try {
                                        var io = new ImportOptions(myFile);
                                    } catch (err) {
                                        alert(err.toString());
                                        break;
                                    }
                                } else {
                                    alert(Immigration_Data.missingFileError + "\n\n" + File.decode(myFile));
                                    break;
                                }
                                if (isSequence) {
                                    var myRangeText = (mySel2Array[i]).slice((mySel2Array[i]).lastIndexOf("[") + 1, (mySel2Array[i]).lastIndexOf("]"));
                                    var myRange = myRangeText.split("-");
                                    var setIn = parseInt(pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeIn.text, 10);
                                    var setOut = parseInt(pal.grp.buttons.buttonsL.statusRange.buttonsRange.frameRangeOut.text, 10);
                                    io.sequence = true;
                                    if (mySelselection.length == 1 && setIn != myRange[0] || setOut != myRange[1]) {
                                        try {
                                            io.rangeStart = setIn;
                                            io.rangeEnd = setOut;
                                        } catch (err) {
                                            alert(err.toString());
                                            break;
                                        }
                                    }
                                }
                                if (!replaceFile) {
                                    try {
                                        var myImportedFile = app.project.importFile(io);
                                    } catch (err) {
                                        alert(err.toString());
                                        break;
                                    }
                                    if (isSequence) {
                                        myImportedFile.mainSource.conformFrameRate = pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text;
                                    }
                                    if (setHierarchy) {
                                        var myMainDir = mainDir.split("/");
                                        var myParentFolder = myMainDir.pop();
                                        var myPath = cleanedName.split("/");
                                        myPath.pop();
                                        myPath.shift();
                                        if (includeCurrentFolder) {
                                            myPath.unshift(myParentFolder);
                                        }
                                        if (setFolder) {
                                            var setFolderHierarchy = getFolderHierarchy(saveFolder);
                                            for (var s = setFolderHierarchy.length - 1; s > -1; s--) {
                                                myPath.unshift(setFolderHierarchy[s]);
                                            }
                                        }
                                        var buildFolderHierarchyLibraryArray = buildFolderHierarchyLibrary(includeCurrentFolder);
                                        var myProjHierarchyArray = buildFolderHierarchyLibraryArray[0];
                                        var myProjFolderArray = buildFolderHierarchyLibraryArray[1];
                                        var myTempPath = new Array();
                                        var mySavedLength = 0;
                                        for (var p = 0; p < myPath.length; p += 1) {
                                            myTempPath.push(myPath[p]);
                                            var getArrayIndex = IsInArray(myTempPath.join("/"), myProjHierarchyArray);
                                            if (getArrayIndex == -1) {
                                                var myNewPath = myTempPath.slice(mySavedLength);
                                            } else {
                                                mySavedParentFolder = myProjFolderArray[getArrayIndex];
                                                mySavedLength = myTempPath.length;
                                            }
                                        }
                                        if (getArrayIndex == -1) {
                                            mySavedParentFolder = makeFolderHierarchy(myNewPath, mySavedParentFolder);
                                        } else {
                                            mySavedParentFolder = myProjFolderArray[getArrayIndex];
                                        }
                                    }
                                    myImportedFile.parentFolder = mySavedParentFolder;
                                    myImportedFile.selected = true;
                                    pal.grp.buttons.buttonsR.mode.visible = false;
                                    pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                                } else {
                                    var doReplace = true;
                                    if (pal.grp.buttons.buttonsR.mode.value) {
                                        if (isSequence) {
                                            var nameRegex = Immigration_Data.endMatchRegex.exec(cleanedName);
                                            var myNamePrefix = cleanedName.slice(0, cleanedName.search(nameRegex[1]));
                                            var myNameExt = "." + nameRegex[2];
                                            var reAssembledName = myNamePrefix + "[" + myRangeText + "]" + myNameExt;
                                        } else {
                                            var reAssembledName = (mySel2Array[i]).slice(Immigration_Data.padAmount);
                                        }
                                        doReplace = true;
                                    }
                                    if (doReplace) {
                                        var saveOldNameForExpressionsFix = (projSelArray[i]).name;
                                        if (isSequence) {
                                            if (!pal.grp.buttons.buttonsR.mode.value) {
                                                try {
                                                    (projSelArray[i]).replaceWithSequence(myFile, false);
                                                    app.project.autoFixExpressions(saveOldNameForExpressionsFix, (projSelArray[i]).name);
                                                } catch (err) {
                                                    alert(err.toString());
                                                    break;
                                                }
                                            } else {
                                                try {
                                                    (projSelArray[i]).setProxyWithSequence(myFile, false);
                                                    (projSelArray[i]).proxySource.conformFrameRate = pal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text;
                                                } catch (err) {
                                                    alert(err.toString());
                                                    break;
                                                }
                                            }
                                        } else {
                                            if (!pal.grp.buttons.buttonsR.mode.value) {
                                                try {
                                                    (projSelArray[i]).replace(myFile);
                                                    app.project.autoFixExpressions(saveOldNameForExpressionsFix, (projSelArray[i]).name);
                                                } catch (err) {
                                                    alert(err.toString());
                                                    break;
                                                }
                                            } else {
                                                try {
                                                    (projSelArray[i]).setProxy(myFile);
                                                } catch (err) {
                                                    alert(err.toString());
                                                    break;
                                                }
                                            }
                                        }
                                        pal.grp.buttons.buttonsR.mode.visible = false;
                                        pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                                        (projSelArray[i]).selected = true;
                                    } else {
                                        clearOutput();
                                        writeLn(File.decode(reAssembledName));
                                        writeLn("skipped");
                                    }
                                }
                                pal.grp.list.status1.text = this.text + " in progress...";
                                pal.grp.list.status2.text = i + 1 + " out of " + mySelselection.length;
                                writeLn(this.text + ": " + i + 1 + " out of " + mySelselection.length);
                            }
                        }
                        if (setHierarchy && !includeCurrentFolder) {
                            removeEncodedRoot(setFolder, saveFolder);
                        }
                        pal.grp.list.listing.listBox.selection = null;
                        pal.grp.buttons.buttonsR.mode.value = false;
                        pal.grp.buttons.buttonsR.mode.visible = false;
                        pal.grp.buttons.buttonsR.doIt.enabled = false;
                        pal.grp.buttons.buttonsR.match.visible = false;
                        pal.grp.buttons.buttonsL.refresh.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.buttonsFR.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.buttonsRange.visible = false;
                        pal.grp.buttons.buttonsL.deSelect.visible = false;
                        pal.grp.buttons.buttonsL.statusFR.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.status.visible = false;
                        pal.grp.buttons.buttonsL.statusRange.preview.visible = false;
                    }
                    pal.grp.options.filterType.text = "";
                    pal.grp.list.status1.text = saveStatus1;
                    pal.grp.list.status2.text = saveStatus2;
                    if (pal.grp.buttons.buttonsL.statusRange.preview.text != Immigration_Data.previewButton) {
                        pal.grp.buttons.buttonsL.statusRange.preview.text = Immigration_Data.previewButton;
                        pal.grp.buttons.buttonsL.statusRange.preview.helpTip = Immigration_Data.previewButtonTip;
                        pal.grp.list.listing.listBox.visible = true;
                        pal.grp.list.listing.listBox3.visible = false;
                        pal.grp.list.graphics.backgroundColor = whiteColorBrush;
                        pal.grp.list.status1.graphics.foregroundColor = grayColorPen;
                        pal.grp.list.status1.text = mainDir.slice(mainDir.lastIndexOf("/") + 1);
                        pal.grp.options.enabled = true;
                        pal.grp.dirs.enabled = true;
                        pal.layout.layout(true);
                        pal.layout.resize();
                    }
                }
                clearOutput();
            };
            pal.grp.options.help.onClick = function () {
                if (typeof helpWindow_unitTest == "undefined") {
                    new helpWindow().run();
                }
            };
            pal.layout.layout(true);
            pal.grp.minimumSize = pal.grp.size;
            pal.layout.resize();
            pal.onResizing = pal.onResize = function () {
                this.layout.resize();
            };
            pal.grp.options.filter.onChange = function () {
                app.settings.saveSetting("aescripts", "Immigration_extensionFilter", pal.grp.options.filter.selection.index);
            };
        }
        return pal;
    }

    function setStatus(palObj, mainDir) {
        var currentDir = mainDir.substring(mainDir.lastIndexOf("/") + 1, mainDir.length);
        var filterType = 0;
        var filter = "";
        var fileAgeType = 0;
        var fileAgeDelta = 0;
        var fileAge = 0;
        var fileAgeTime = 0;
        var doPreSort = 0;
        if (app.settings.haveSetting("aescripts", "Immigration_folderFilter")) {
            filterType = parseInt(app.settings.getSetting("aescripts", "Immigration_folderFilter"), 10);
        }
        if (filterType != 0) {
            if (app.settings.haveSetting("aescripts", "Immigration_folderFilterText")) {
                filter = app.settings.getSetting("aescripts", "Immigration_folderFilterText");
            }
        }
        if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilter")) {
            fileAgeType = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeFilter"), 10);
        }
        if (fileAgeType != 0) {
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilter2")) {
                fileAgeDelta = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeFilter2"), 10);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilterText")) {
                fileAge = parseFloat(app.settings.getSetting("aescripts", "Immigration_fileAgeFilterText"), 10);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeTime")) {
                fileAgeTime = app.settings.getSetting("aescripts", "Immigration_fileAgeTime");
            }
        }
        var filterTxt = "\t\t" + Immigration_Data.strFolderFilterOptions[filterType] + " folder: " + filter;
        var statusTxt = "" + currentDir + "";
        palObj.grp.list.status1.text = statusTxt;
        palObj.grp.list.status1.helpTip = Immigration_Data.browseCurrentFolderTip + " " + currentDir;
        if (filterType != 0) {
            palObj.grp.list.status2.text = filterTxt + "\t";
        } else {
            palObj.grp.list.status2.text = "";
        }
        if (fileAgeType != 0) {
            if (isNaN(fileAge)) {
                fileAge = 0;
            }
            if (fileAge == 0 || fileAge > 1) {
                var addS = "s";
            } else {
                var addS = "";
            }
            palObj.grp.list.status2.text += " " + Immigration_Data.strFileAgeFilterOptions[fileAgeType] + " " + Immigration_Data.strFileAgeFilterOptions2[fileAgeDelta] + " " + fileAge + " " + (Immigration_Data.strFileAgeFilterTimeOptions[fileAgeTime]).substr(0, (Immigration_Data.strFileAgeFilterTimeOptions[fileAgeTime]).length - 1) + addS + " old";
        }
        palObj.grp.list.status2.text += (Immigration_Data.doExtensionSort ? " (file pre-sort is on)" : "");
    }

    function PadDigits(n, totalDigits) {
        n = n.toString();
        var pd = "";
        if (totalDigits > n.length) {
            for (var m = 0; m < totalDigits - n.length; m += 1) {
                pd += "0";
            }
        }
        return pd + n.toString();
    }

    function levenDistance(a, b) {
        var m = a.length;
        var n = b.length;
        if (m < n) {
            var c = a;
            a = b;
            b = c;
            var o = m;
            m = n;
            n = o;
        }
        var r = new Array();
        r[0] = new Array();
        for (var c = 0; c < n + 1; c += 1) {
            r[0][c] = c;
        }
        for (var i = 1; i < m + 1; i += 1) {
            r[i] = new Array();
            (r[i])[0] = i;
            for (var j = 1; j < n + 1; j += 1) {
                cost = (a.charAt(i - 1) == b.charAt(j - 1) ? 0 : 1);
                r[i][j] = minimator(r[i - 1][j] + 1, r[i][j - 1] + 1, r[i - 1][j - 1] + cost);
            }
        }
        return r[m][n];
    }

    function minimator(x, y, z) {
        if (x < y && x < z) {
            return x;
        }
        if (y < x && y < z) {
            return y;
        }
        return z;
    }

    function buildReplaceHelpTip(pal1, pal2, palObj) {
        var mySel = pal1;
        var mySelselection = pal1.selection;
        var mySel2 = pal2;
        palObj.grp.list.listing.listBox3.removeAll();
        var mySel2Array = new Array();
        for (var j = 0; j < mySelselection.length; j += 1) {
            var mySelitem = (mySel.items[(mySelselection[j]).index]).toString();
            var mySel2item = (mySel2.items[(mySelselection[j]).index]).toString();
            var mySel2PiecesArray = mySel2item.split(":");
            if (mySel2PiecesArray.length < 2) {
                var shortLength = 2 - mySel2PiecesArray.length;
                for (var m = 0; m <= shortLength; m += 1) {
                    mySel2PiecesArray.push("");
                }
            }
            mySel2PiecesArray.push(mySelitem.slice(mySelitem.lastIndexOf("/") + 1));
            mySel2Array[j] = mySel2PiecesArray;
        }
        var myProjSelection = app.project.selection;
        var myProjArray = new Array();
        for (var r = 0; r < myProjSelection.length; r += 1) {
            if (myProjSelection[r] instanceof FootageItem) {
                var myType = "Footage";
                if ((myProjSelection[r]).mainSource.file != null) {
                    var myProjItem = unescape((myProjSelection[r]).file.name);
                    if (!(myProjSelection[r]).mainSource.isStill) {
                        var testA = Immigration_Data.endMatchRegex.exec(myProjItem);
                        var testAint = parseInt(testA, 10);
                        if (testA != null) {
                            var namePrefix = myProjItem.slice(0, myProjItem.search(testA[0]));
                            var nameExt = "." + testA[2];
                        } else {
                            var dotPos = myProjItem.lastIndexOf(".");
                            if (dotPos == -1) {
                                var namePrefix = myProjItem;
                                var nameExt = "";
                            } else {
                                var namePrefix = myProjItem.slice(0, dotPos);
                                var nameExt = "." + myProjItem.slice(dotPos + 1, myProjItem.length);
                            }
                        }
                    } else {
                        var dotPos = myProjItem.lastIndexOf(".");
                        if (dotPos == -1) {
                            var namePrefix = myProjItem;
                            var nameExt = "";
                        } else {
                            var namePrefix = myProjItem.slice(0, dotPos);
                            var nameExt = "." + myProjItem.slice(dotPos + 1, myProjItem.length);
                        }
                    }
                } else {
                    var myProjItem = (myProjSelection[r]).name;
                    var nameExt = "";
                }
            } else {
                var namePrefix = (myProjSelection[r]).name;
                var nameExt = "";
                if (myProjSelection[r] instanceof CompItem) {
                    var myType = "Comp";
                } else {
                    var myType = "Error";
                }
            }
            myProjArray[r] = [namePrefix, nameExt, myType, (myProjSelection[r]).name];
        }
        var myHelpTip = palObj.grp.buttons.buttonsR.match.selection.text + " " + palObj.grp.buttons.buttonsR.doIt.text + " PREVIEW:\n\n";
        palObj.grp.list.listing.listBox3.add("item", palObj.grp.buttons.buttonsR.match.selection.text + " " + palObj.grp.buttons.buttonsR.doIt.text);
        palObj.grp.list.listing.listBox3.add("item", "----------------------------------------------");
        if (palObj.grp.buttons.buttonsR.match.selection.index == 0) {
            clearOutput();
            writeLn("Calculating Auto-Matches");
            myProjArray.reverse();
            var myCounter = 0;
            var myProjArrayLength = myProjArray.length;
            var s = myProjArray.length - 1;
            var saveLength = myProjArray.length;
            while (myProjArray.length > 0) {
                clearOutput();
                if (s < 0) {
                    s = myProjArray.length - 1;
                }
                var myLevenDistances = new Array();
                for (var t = 0; t < mySel2Array.length; t += 1) {
                    myLevenDistances[t] = [PadDigits(levenDistance((mySel2Array[t])[1] + (mySel2Array[t])[2], (myProjArray[s])[0] + (myProjArray[s])[1]), Immigration_Data.padAmount), (mySel2Array[t])[3], t];
                }
                myLevenDistances.sort();
                myCounter++;
                if (Immigration_Data.moreAccurateAutoMatch) {
                    if (parseInt(myLevenDistances[0][0], 10) > Immigration_Data.autoMatchLevenDistanceTolerance && myCounter < myProjArrayLength) {
                        s--;
                        continue;
                    }
                }
                switch (palObj.grp.buttons.buttonsR.doIt.text) {
                    case Immigration_Data.replaceButton:
                        if ((myProjArray[s])[2] != "Error" && (myProjArray[s])[2] != "Comp") {
                            myHelpTip += myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase() + "\n" + (myProjArray[s])[3] + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase());
                            palObj.grp.list.listing.listBox3.add("item", (myProjArray[s])[3]);
                        } else {
                            myHelpTip += Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0] + "\n" + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0]);
                            palObj.grp.list.listing.listBox3.add("item", myLevenDistances[0][1].toString() + " cannot be matched");
                            (myProjArray[s])[2] = "Error";
                        }
                        break;
                    case Immigration_Data.replaceProxyButton:
                        if ((myProjArray[s])[2] != "Error") {
                            myHelpTip += myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase() + "\n" + (myProjArray[s])[3] + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase());
                            palObj.grp.list.listing.listBox3.add("item", (myProjArray[s])[3]);
                        } else {
                            myHelpTip += Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0] + "\n" + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0]);
                            palObj.grp.list.listing.listBox3.add("item", myLevenDistances[0][1].toString() + " cannot be matched");
                            (myProjArray[s])[2] = "Error";
                        }
                        break;
                }
                if (parseInt(myLevenDistances[0][0], 10) == 0) {
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon01;
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon01;
                }
                switch (parseInt(myLevenDistances[0][0], 10)) {
                    case 1:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon02;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon02;
                        break;
                    case 2:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon03;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon03;
                        break;
                    case 3:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon04;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon04;
                        break;
                    case 4:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon05;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon05;
                        break;
                }
                if (parseInt(myLevenDistances[0][0], 10) > 4) {
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon00;
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon00;
                }
                if ((myProjArray[s])[2] == "Error") {
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon06;
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon06;
                }
                mySel2Array.splice(parseInt(myLevenDistances[0][2], 10), 1);
                myProjArray.splice(s, 1);
                s--;
                writeLn("Matching item " + (saveLength - myProjArray.length) + " out of " + saveLength);
            }
        }
        if (palObj.grp.buttons.buttonsR.match.selection.index == 1) {
            mySel2Array.sort();
            for (var s = 0; s < Math.min(myProjArray.length, mySel2Array.length); s += 1) {
                var myLevenDistances = new Array();
                myLevenDistances[0] = [PadDigits(levenDistance((mySel2Array[s])[1] + (mySel2Array[s])[2], (myProjArray[s])[0] + (myProjArray[s])[1]), Immigration_Data.padAmount), (mySel2Array[s])[3], s];
                switch (palObj.grp.buttons.buttonsR.doIt.text) {
                    case Immigration_Data.replaceButton:
                        if ((myProjArray[s])[2] != "Error" && (myProjArray[s])[2] != "Comp") {
                            myHelpTip += myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase() + "\n" + (myProjArray[s])[3] + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase());
                            palObj.grp.list.listing.listBox3.add("item", (myProjArray[s])[3]);
                        } else {
                            myHelpTip += Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0] + "\n" + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0]);
                            palObj.grp.list.listing.listBox3.add("item", myLevenDistances[0][1].toString() + " cannot be matched");
                            (myProjArray[s])[2] = "Error";
                        }
                        break;
                    case Immigration_Data.replaceProxyButton:
                        if ((myProjArray[s])[2] != "Error") {
                            myHelpTip += myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase() + "\n" + (myProjArray[s])[3] + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", myLevenDistances[0][1].toString() + " " + palObj.grp.buttons.buttonsR.doIt.text.replace(/replace/i, "replaces").toUpperCase());
                            palObj.grp.list.listing.listBox3.add("item", (myProjArray[s])[3]);
                        } else {
                            myHelpTip += Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0] + "\n" + "\n\n";
                            palObj.grp.list.listing.listBox3.add("node", Immigration_Data.listBoxPreviewError + " CANNOT " + palObj.grp.buttons.buttonsR.doIt.text.toUpperCase() + " " + (myProjArray[s])[0]);
                            palObj.grp.list.listing.listBox3.add("item", myLevenDistances[0][1].toString() + " cannot be matched");
                            (myProjArray[s])[2] = "Error";
                        }
                        break;
                }
                if (parseInt(myLevenDistances[0][0], 10) == 0) {
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon01;
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon01;
                }
                switch (parseInt(myLevenDistances[0][0], 10)) {
                    case 1:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon02;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon02;
                        break;
                    case 2:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon03;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon03;
                        break;
                    case 3:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon04;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon04;
                        break;
                    case 4:
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon05;
                        (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon05;
                        break;
                }
                if (parseInt(myLevenDistances[0][0], 10) > 4) {
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon00;
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon00;
                }
                if ((myProjArray[s])[2] == "Error") {
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 1]).image = Immigration_Data.matchIcon06;
                    (palObj.grp.list.listing.listBox3.items[palObj.grp.list.listing.listBox3.items.length - 2]).image = Immigration_Data.matchIcon06;
                }
            }
        }
        return myHelpTip;
    }

    function selectListBoxText(palObj) {
        var myType = "\\" + palObj.grp.options.filterType.text;
        for (var i = 0; i < palObj.grp.list.listing.listBox.items.length; i += 1) {
            if (palObj.grp.options.filterType.text != "" && (palObj.grp.list.listing.listBox.items[i]).text.match(myType)) {
                (palObj.grp.list.listing.listBox.items[i]).selected = true;
            } else {
                (palObj.grp.list.listing.listBox.items[i]).selected = false;
            }
        }
    }

    function getFolderHierarchy(myFolder) {
        var myFolderHierarchy = new Array();
        var theParentFolder = myFolder.parentFolder;
        myFolderHierarchy[myFolderHierarchy.length] = theParentFolder.name;
        myFolderHierarchy[myFolderHierarchy.length] = myFolder.name;
        var foundRoot = false;
        while (!foundRoot) {
            if (theParentFolder != app.project.rootFolder) {
                myFolderHierarchy.unshift(theParentFolder.parentFolder.name);
                theParentFolder = theParentFolder.parentFolder;
            } else {
                foundRoot = true;
            }
        }
        myFolderHierarchy.shift();
        return myFolderHierarchy;
    }

    function buildFolderHierarchyLibrary() {
        var folderHierarchyLibrary = new Array();
        var FHLfolder = new Array();
        for (var g = app.project.numItems; g > 0; g--) {
            if (app.project.item(g) instanceof FolderItem) {
                folderHierarchyLibrary[folderHierarchyLibrary.length] = getFolderHierarchy(app.project.item(g)).join("/");
                FHLfolder[FHLfolder.length] = app.project.item(g);
            }
        }
        return [folderHierarchyLibrary, FHLfolder];
    }

    function removeEncodedRoot(setFolder, saveFolder) {
        for (var g = 1; g <= app.project.numItems; g += 1) {
            if (app.project.item(g) instanceof FolderItem) {
                if (app.project.item(g).parentFolder.name == Immigration_Data.encodedRootName) {
                    if (setFolder) {
                        app.project.item(g).parentFolder = saveFolder;
                    } else {
                        app.project.item(g).parentFolder = app.project.rootFolder;
                    }
                }
            }
            if (app.project.item(g).name == Immigration_Data.encodedRootName) {
                var encodedFolder = app.project.item(g);
            }
        }
        encodedFolder.remove();
    }

    function makeFolderHierarchy(myPath, saveFolder) {
        for (var f = 0; f < myPath.length; f += 1) {
            var myFolder = app.project.items.addFolder(myPath[f]);
            myFolder.parentFolder = saveFolder;
            saveFolder = myFolder;
        }
        return myFolder;
    }

    function initialWarningDialog() {
        this.windowRef = null;
    }

    initialWarningDialog.prototype.run = function () {
        var yMover = 80;
        var bottomMover = 10;
        var win = new Window("dialog", Immigration_Data.initialTitleWarning, [100, 100, 580, 220 + yMover]);
        this.windowRef = win;
        win.btnPanel = win.add("group", [10, 5, 600, 175 + yMover]);
        win.btnPanel.text = win.btnPanel.add("statictext", [10, 10, 600, 75 + yMover], Immigration_Data.initialWarning, {
            multiline: true
        });
        win.btnPanel.warnBtn = win.btnPanel.add("checkbox", [20, 65 + yMover + bottomMover, 200, 85 + yMover + bottomMover], Immigration_Data.dontWarnWarning);
        win.btnPanel.cancelBtn = win.btnPanel.add("button", [240, 65 + yMover + bottomMover, 340, 85 + yMover + bottomMover], Immigration_Data.cancelWarning);
        win.btnPanel.okBtn = win.btnPanel.add("button", [350, 65 + yMover + bottomMover, 450, 85 + yMover + bottomMover], Immigration_Data.okWarning);
        win.btnPanel.warnBtn.onClick = function () {
            if (this.value) {
                app.settings.saveSetting("aescripts", "Immigration_initialWarning", "0");
            }
        };
        var yes = false;
        win.btnPanel.cancelBtn.onClick = function () {
            yes = false;
            win.close();
        };
        win.btnPanel.okBtn.onClick = function () {
            yes = true;
            win.close();
        };
        win.center();
        win.show();
        return yes;
    };

    function proxyWarningDialog() {
        this.windowRef = null;
    }

    proxyWarningDialog.prototype.run = function () {
        var yMover = 80;
        var win = new Window("dialog", Immigration_Data.proxyTitleWarning, [100, 100, 580, 210 + yMover]);
        this.windowRef = win;
        win.btnPanel = win.add("group", [10, 10, 600, 150 + yMover]);
        win.btnPanel.text = win.btnPanel.add("statictext", [10, 10, 600, 50 + yMover], Immigration_Data.proxyWarning, {
            multiline: true
        });
        win.btnPanel.warnBtn = win.btnPanel.add("checkbox", [20, 65 + yMover, 200, 85 + yMover], Immigration_Data.applyToAll);
        win.btnPanel.cancelBtn = win.btnPanel.add("button", [240, 65 + yMover, 340, 85 + yMover], Immigration_Data.mainButton);
        win.btnPanel.okBtn = win.btnPanel.add("button", [350, 65 + yMover, 450, 85 + yMover], Immigration_Data.proxyButton);
        win.btnPanel.warnBtn.onClick = function () {
            if (this.value) {
                app.settings.saveSetting("aescripts", "Immigration_proxyApplyToAll", "1");
            }
        };
        var yes = false;
        win.btnPanel.cancelBtn.onClick = function () {
            yes = false;
            win.close();
        };
        win.btnPanel.okBtn.onClick = function () {
            yes = true;
            win.close();
        };
        win.center();
        win.show();
        return yes;
    };

    function helpWindow() {
        this.windowRef = null;
    }

    helpWindow.prototype.run = function () {
        var regHeader = localize({
            en: "Registered to: ",
        });
        if ($.os.indexOf("Mac") != -1 || Immigration_Data.foundPerl) {
            var prefMover = -20;
        } else {
            var prefMover = 0;
        }
        if ($.os.indexOf("Windows") != -1) {
            var winMover = 25;
        } else {
            var winMover = 0;
        }
        var win = new Window("palette", Immigration_Data.scriptName, [100, 0, 580, 625 + winMover]);
        this.windowRef = win;
        win.headerPanel = win.add("group", [10, 0, 600, 70]);
        win.headerPanel.headerTxt = win.headerPanel.add("statictext", [10, 5, 400, 25], Immigration_Data.strHelpHeader);
        win.headerPanel.regTxt = win.headerPanel.add("statictext", [10, 22, 400, 35], regHeader);
        win.headerPanel.collapseBtn = win.headerPanel.add("checkbox", [7, 50, 400, 70], Immigration_Data.strCollapseHelp);
        win.helpPanel = win.add("group", [10, 70, 600, 460 + prefMover]);
        win.helpPanel.helpTxt = win.helpPanel.add("edittext", [10, 0, 450, 390 + prefMover], Immigration_Data.strHelpText, {
            multiline: true
        });
        win.prefsPanel = win.add("group", [10, 465 + prefMover, 600, 625 + winMover]);
        win.prefsPanel.recursion = win.prefsPanel.add("edittext", [170, 45 + prefMover, 205, 65 + prefMover]);
        win.prefsPanel.recursionTxt = win.prefsPanel.add("statictext", [15, 45 + prefMover, 185, 65 + prefMover], Immigration_Data.strRecursionDepth);
        win.prefsPanel.recentDir = win.prefsPanel.add("edittext", [405, 45 + prefMover, 440, 65 + prefMover]);
        win.prefsPanel.recentDirTxt = win.prefsPanel.add("statictext", [220, 45 + prefMover, 410, 65 + prefMover], Immigration_Data.strRecentDir);
        win.prefsPanel.folderFilterTxt = win.prefsPanel.add("statictext", [15, 77 + prefMover, 85, 97 + prefMover], Immigration_Data.strFolderFilter);
        win.prefsPanel.folderFilterOptions = win.prefsPanel.add("dropdownlist", [90, 75 + prefMover, 190, 95 + prefMover]);
        win.prefsPanel.folderFilter = win.prefsPanel.add("edittext", [195, 75 + prefMover, 440, 95 + prefMover]);
        if ($.os.indexOf("Mac") != -1 || Immigration_Data.foundPerl) {
            win.prefsPanel.fileAgeFilterTxt = win.prefsPanel.add("statictext", [15, 82, 85, 102], Immigration_Data.strFileAgeFilter);
            win.prefsPanel.fileAgeFilterOptions = win.prefsPanel.add("dropdownlist", [90, 82, 190, 102]);
            win.prefsPanel.fileAgeFilterOptions2 = win.prefsPanel.add("dropdownlist", [195, 82, 300, 102]);
            win.prefsPanel.fileAgeFilter = win.prefsPanel.add("edittext", [305, 82, 345, 102]);
            win.prefsPanel.fileAgeFilterTime = win.prefsPanel.add("dropdownlist", [350, 82, 420, 102]);
            win.prefsPanel.fileAgeFilterTxtSuffix = win.prefsPanel.add("statictext", [425, 82, 455, 102], Immigration_Data.strFileAgeFilterSuffix);
            win.prefsPanel.doPreSort = win.prefsPanel.add("checkbox", [15, 110, 350, 135], Immigration_Data.strPreSortFiles);
        }
        win.prefsPanel.tutBtn = win.prefsPanel.add("button", [10, 140, 150, 170], Immigration_Data.strTutorial);
        win.prefsPanel.commentsBtn = win.prefsPanel.add("button", [160, 140, 300, 170], Immigration_Data.strImmigration);
        win.prefsPanel.aesBtn = win.prefsPanel.add("button", [310, 140, 450, 170], Immigration_Data.strClose);
        win.prefsPanel.commentsBtn.visible = false;
        var collapseAmt = 380;
        win.headerPanel.collapseBtn.onClick = function () {
            collapseInstructions(this);
        };

        function collapseInstructions(btnObj) {
            app.settings.saveSetting("aescripts", "Immigration_collapseInstructions", btnObj.value);
            var winBounds = win.bounds;
            var headerPanelBounds = win.headerPanel.bounds;
            var helpPanelBounds = win.helpPanel.bounds;
            var prefsPanelBounds = win.prefsPanel.bounds;
            var recursionBounds = win.prefsPanel.recursion.bounds;
            var recursionTxtBounds = win.prefsPanel.recursionTxt.bounds;
            var recentDirBounds = win.prefsPanel.recentDir.bounds;
            var recentDirTxtBounds = win.prefsPanel.recentDirTxt.bounds;
            var folderFilterTxtBounds = win.prefsPanel.folderFilterTxt.bounds;
            var folderFilterOptionsBounds = win.prefsPanel.folderFilterOptions.bounds;
            var folderFilterBounds = win.prefsPanel.folderFilter.bounds;
            if ($.os.indexOf("Mac") != -1 || Immigration_Data.foundPerl) {
                var fileAgeFilterTxtBounds = win.prefsPanel.fileAgeFilterTxt.bounds;
                var fileAgeFilterOptionsBounds = win.prefsPanel.fileAgeFilterOptions.bounds;
                var fileAgeFilterOptions2Bounds = win.prefsPanel.fileAgeFilterOptions2.bounds;
                var fileAgeFilterBounds = win.prefsPanel.fileAgeFilter.bounds;
                var fileAgeFilterTimeBounds = win.prefsPanel.fileAgeFilterTime.bounds;
                var fileAgeFilterTxtSuffixBounds = win.prefsPanel.fileAgeFilterTxtSuffix.bounds;
            }
            var tutBtnBounds = win.prefsPanel.tutBtn.bounds;
            var commentsBtnBounds = win.prefsPanel.commentsBtn.bounds;
            var aesBtnBounds = win.prefsPanel.aesBtn.bounds;
            if (btnObj.value) {
                btnObj.text = Immigration_Data.strExpandHelp;
                win.helpPanel.visible = false;
                win.helpPanel.bounds = [helpPanelBounds[0], helpPanelBounds[1], helpPanelBounds[2], helpPanelBounds[3] - collapseAmt];
                win.prefsPanel.bounds = [prefsPanelBounds[0], prefsPanelBounds[1] - collapseAmt, prefsPanelBounds[2], prefsPanelBounds[3] - collapseAmt];
                win.bounds = [winBounds[0], winBounds[1], winBounds[2], winBounds[3] - collapseAmt];
                if ($.os.indexOf("Windows") != -1) {
                    win.center();
                }
            } else {
                btnObj.text = Immigration_Data.strCollapseHelp;
                win.bounds = [winBounds[0], winBounds[1], winBounds[2], winBounds[3] + collapseAmt];
                win.prefsPanel.bounds = [prefsPanelBounds[0], prefsPanelBounds[1] + collapseAmt, prefsPanelBounds[2], prefsPanelBounds[3] + collapseAmt];
                win.helpPanel.bounds = [helpPanelBounds[0], helpPanelBounds[1], helpPanelBounds[2], helpPanelBounds[3] + collapseAmt];
                win.helpPanel.visible = true;
                if ($.os.indexOf("Windows") != -1) {
                    win.center();
                }
            }
        }

        for (var i = 0; i < Immigration_Data.strFolderFilterOptions.length; i += 1) {
            win.prefsPanel.folderFilterOptions.add("item", Immigration_Data.strFolderFilterOptions[i]);
        }
        if (app.settings.haveSetting("aescripts", "Immigration_folderFilter")) {
            win.prefsPanel.folderFilterOptions.selection = parseInt(app.settings.getSetting("aescripts", "Immigration_folderFilter"), 10);
        } else {
            win.prefsPanel.folderFilterOptions.selection = 0;
        }
        if (app.settings.haveSetting("aescripts", "Immigration_collapseInstructions")) {
            win.headerPanel.collapseBtn.value = !(app.settings.getSetting("aescripts", "Immigration_collapseInstructions") == "false");
            if (win.headerPanel.collapseBtn.value) {
                collapseInstructions(win.headerPanel.collapseBtn)
            }
        }
        if (app.settings.haveSetting("aescripts", "Immigration_folderFilterText")) {
            win.prefsPanel.folderFilter.text = app.settings.getSetting("aescripts", "Immigration_folderFilterText");
        }
        if (win.prefsPanel.folderFilterOptions.selection.index == 0) {
            win.prefsPanel.folderFilter.visible = false;
        } else {
            win.prefsPanel.folderFilter.visible = true;
        }
        win.prefsPanel.folderFilterOptions.onChange = function () {
            app.settings.saveSetting("aescripts", "Immigration_folderFilter", this.selection.index);
            if (win.prefsPanel.folderFilterOptions.selection.index == 0) {
                win.prefsPanel.folderFilter.visible = false;
            } else {
                win.prefsPanel.folderFilter.visible = true;
            }
        };
        win.prefsPanel.folderFilter.onChanging = function () {
            app.settings.saveSetting("aescripts", "Immigration_folderFilterText", this.text);
        };
        if ($.os.indexOf("Mac") != -1 || Immigration_Data.foundPerl) {
            for (var i = 0; i < Immigration_Data.strFileAgeFilterOptions.length; i += 1) {
                win.prefsPanel.fileAgeFilterOptions.add("item", Immigration_Data.strFileAgeFilterOptions[i]);
            }
            for (var i = 0; i < Immigration_Data.strFileAgeFilterOptions2.length; i += 1) {
                win.prefsPanel.fileAgeFilterOptions2.add("item", Immigration_Data.strFileAgeFilterOptions2[i]);
            }
            for (var i = 0; i < Immigration_Data.strFileAgeFilterTimeOptions.length; i += 1) {
                win.prefsPanel.fileAgeFilterTime.add("item", Immigration_Data.strFileAgeFilterTimeOptions[i]);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilter")) {
                win.prefsPanel.fileAgeFilterOptions.selection = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeFilter"), 10);
            } else {
                win.prefsPanel.fileAgeFilterOptions.selection = 0;
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilter2")) {
                win.prefsPanel.fileAgeFilterOptions2.selection = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeFilter2"), 10);
            } else {
                win.prefsPanel.fileAgeFilterOptions2.selection = 0;
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilterText")) {
                win.prefsPanel.fileAgeFilter.text = app.settings.getSetting("aescripts", "Immigration_fileAgeFilterText");
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeTime")) {
                win.prefsPanel.fileAgeFilterTime.selection = app.settings.getSetting("aescripts", "Immigration_fileAgeTime");
            } else {
                win.prefsPanel.fileAgeFilterTime.selection = 1;
            }
            if (app.settings.haveSetting("aescripts", "Immigration_doFilePreSort")) {
                win.prefsPanel.doPreSort.value = !(app.settings.getSetting("aescripts", "Immigration_doFilePreSort") == "false")
            }
            if (win.prefsPanel.fileAgeFilterOptions.selection.index == 0) {
                win.prefsPanel.fileAgeFilter.visible = false;
                win.prefsPanel.fileAgeFilterOptions2.visible = false;
                win.prefsPanel.fileAgeFilterTxtSuffix.visible = false;
                win.prefsPanel.fileAgeFilterTime.visible = false;
            } else {
                win.prefsPanel.fileAgeFilter.visible = true;
                win.prefsPanel.fileAgeFilterOptions2.visible = true;
                win.prefsPanel.fileAgeFilterTxtSuffix.visible = true;
                win.prefsPanel.fileAgeFilterTime.visible = true;
            }
            win.prefsPanel.fileAgeFilterOptions.onChange = function () {
                app.settings.saveSetting("aescripts", "Immigration_fileAgeFilter", this.selection.index);
                if (win.prefsPanel.fileAgeFilterOptions.selection.index == 0) {
                    win.prefsPanel.fileAgeFilter.visible = false;
                    win.prefsPanel.fileAgeFilterOptions2.visible = false;
                    win.prefsPanel.fileAgeFilterTxtSuffix.visible = false;
                    win.prefsPanel.fileAgeFilterTime.visible = false;
                } else {
                    win.prefsPanel.fileAgeFilter.visible = true;
                    win.prefsPanel.fileAgeFilterOptions2.visible = true;
                    win.prefsPanel.fileAgeFilterTxtSuffix.visible = true;
                    win.prefsPanel.fileAgeFilterTime.visible = true;
                }
            };
            win.prefsPanel.fileAgeFilterOptions2.onChange = function () {
                app.settings.saveSetting("aescripts", "Immigration_fileAgeFilter2", this.selection.index);
            };
            win.prefsPanel.fileAgeFilter.onChanging = function () {
                app.settings.saveSetting("aescripts", "Immigration_fileAgeFilterText", this.text);
            };
            win.prefsPanel.fileAgeFilterTime.onChange = function () {
                app.settings.saveSetting("aescripts", "Immigration_fileAgeTime", this.selection.index);
            };
            win.prefsPanel.doPreSort.onClick = function () {
                app.settings.saveSetting("aescripts", "Immigration_doFilePreSort", this.value);
                Immigration_Data.doExtensionSort = this.value;
            };
        }
        if (app.settings.haveSetting("aescripts", "Immigration_numRecentDir")) {
            win.prefsPanel.recentDir.text = app.settings.getSetting("aescripts", "Immigration_numRecentDir");
        } else {
            win.prefsPanel.recentDir.text = Immigration_Data.recentFolders;
        }
        if (app.settings.haveSetting("aescripts", "Immigration_recursionDepth")) {
            win.prefsPanel.recursion.text = app.settings.getSetting("aescripts", "Immigration_recursionDepth");
        } else {
            win.prefsPanel.recursion.text = Immigration_Data.recursionDepth;
        }
        win.prefsPanel.aesBtn.onClick = function () {
            win.close();
        };
        win.prefsPanel.tutBtn.onClick = function () {
            if (isSecurityPrefSet()) {
                openURL(Immigration_Data.strTutorialUrl);
            } else {
                alert(Immigration_Data.strErrScriptAccess);
            }
        };
        win.prefsPanel.commentsBtn.onClick = function () {
            if (isSecurityPrefSet()) {
                openURL(Immigration_Data.strImmigrationHelpUrl);
            } else {
                alert(Immigration_Data.strErrScriptAccess);
            }
        };
        win.prefsPanel.recentDir.onChange = function () {
            app.settings.saveSetting("aescripts", "Immigration_numRecentDir", this.text);
        };
        win.prefsPanel.recursion.onChange = function () {
            app.settings.saveSetting("aescripts", "Immigration_recursionDepth", this.text);
        };
        win.center();
        win.show();
        return true;
    };

    function checkProjSaveTime() {
        var numMins = parseInt(Immigration_Data.projSaveMins, 10);
        if (isNaN(numMins)) {
            numMins = 0;
        }
        if (numMins != 0) {
            if (app.project.file != null) {
                var myProjFile = File(app.project.file.fsName);
                var current = new Date();
                var currentTime = current.getTime();
                var projModified = new Date(myProjFile.modified);
                var projModifiedTime = projModified.getTime();
                var difSecs = (currentTime - projModifiedTime) / 1000;
                if ($.os.indexOf("Mac") != -1) {
                    var macTimeOffset = -2.5;
                } else {
                    var macTimeOffset = 0;
                }
                var difMins = ((difSecs / 60) + macTimeOffset).toFixed(0);
                var minsInSecs = numMins * 60;
                if (difSecs >= minsInSecs) {
                    var doSave = confirm(Immigration_Data.projSaveWarning.replace(/%e/, difMins));
                    if (doSave) {
                        app.project.save();
                    }
                }
            } else {
                var doSave = confirm(Immigration_Data.projSaveWarning2);
                if (doSave) {
                    app.project.save();
                }
            }
        }
    }

    function openURL(url) {
        if ($.os.indexOf("Windows") != -1) {
            system.callSystem("cmd /c \"" + Immigration_Data.winBrowserCmd + url + "\"");
        } else {
            system.callSystem(Immigration_Data.macBrowserCmdStart + url + Immigration_Data.macBrowserCmdEnd);
        }
    }

    function updateCurrentDropDown(palObj, recentFolderArray) {
        palObj.grp.dirs.name.removeAll();
        for (var i = 0; i < recentFolderArray.length; i += 1) {
            var dirTest = new Folder(recentFolderArray[i]);
            if (dirTest.exists) {
                palObj.grp.dirs.name.add("item", recentFolderArray[i]);
            }
        }
    }

    function IsInArray(theElement, theArray) {
        var arrayIndex = -1;
        for (var i = 0; i < theArray.length; i += 1) {
            if (theElement == theArray[i]) {
                arrayIndex = i
            }
        }
        return arrayIndex;
    }

    function updateCurrentFolderArray(currentDir) {
        if (app.settings.haveSetting("aescripts", "Immigration_recentDir")) {
            var recentDirArray = app.settings.getSetting("aescripts", "Immigration_recentDir").split(Immigration_Data.recentFolderArraySeparator);
        } else {
            var recentDirArray = new Array();
        }
        if (app.settings.haveSetting("aescripts", "Immigration_numRecentDir")) {
            var recentNum = parseInt(app.settings.getSetting("aescripts", "Immigration_numRecentDir"), 10);
        } else {
            var recentNum = Immigration_Data.recentFolders;
        }
        var arrayTest = IsInArray(currentDir, recentDirArray);
        if (arrayTest == -1) {
            recentDirArray.unshift(currentDir);
        } else {
            recentDirArray.splice(arrayTest, 1);
            recentDirArray.unshift(currentDir);
        }
        if (recentNum == 0) {
            recentNum = 1;
        }
        while (recentDirArray.length > recentNum) {
            recentDirArray.pop();
        }
        app.settings.saveSetting("aescripts", "Immigration_recentDir", recentDirArray.join(Immigration_Data.recentFolderArraySeparator));
        return recentDirArray;
    }

    function changeDir(palObj, mainDir, doFilter, myStatus2) {
        checkProjSaveTime();
        if (doFilter) {
            var getDir = new Folder(mainDir);
        } else {
            if (app.settings.haveSetting("aescripts", "Immigration_recentDir")) {
                var recentDirArray = app.settings.getSetting("aescripts", "Immigration_recentDir").split(Immigration_Data.recentFolderArraySeparator);
                var dirTest = new Folder(recentDirArray[0]);
                if (dirTest.exists) {
                    var lastDir = dirTest;
                } else {
                    var lastDir = Folder.myDocuments;
                }
            } else {
                var lastDir = Folder.myDocuments;
            }
            var getDir = lastDir.selectDlg(Immigration_Data.browseBtnInstr);
            if (getDir == null) {
                return getDir;
            }
        }
        palObj.grp.list.status1.text = Immigration_Data.loading;
        palObj.grp.list.listing.listBox.removeAll();
        palObj.grp.list.listing.listBox2.removeAll();
        var rootFolder = getDir;
        var recursionCount = 0;
        if (app.settings.haveSetting("aescripts", "Immigration_recursionDepth")) {
            var recursionDepth = app.settings.getSetting("aescripts", "Immigration_recursionDepth");
        } else {
            var recursionDepth = Immigration_Data.recursionDepth;
        }
        var initial = new Date();
        var startTime = initial.getTime();
        processFolder(getDir, rootFolder, recursionCount, palObj, recursionDepth, myStatus2);
        var current = new Date();
        var curTime = current.getTime();
        var dif = curTime - startTime;
        var result = dif / 1000;
        if (result < 1) {
            result = "0" + result
        }
        result = result.toString();
        if (result.indexOf(".") == -1) {
            result += ".00"
        }
        if ((result.length - result.indexOf(".")) <= 2) {
            result += "0"
        }
        writeLn("Search time: " + result + " secs");
        var currentFolder = Folder.decode(getDir.fullName);
        var recentFolderArray = updateCurrentFolderArray(currentFolder);
        updateCurrentDropDown(palObj, recentFolderArray);
        palObj.grp.dirs.name.visible = true;
        palObj.grp.options.loadBtn.visible = true;
        palObj.grp.options.browse.text = Immigration_Data.browseBtn;
        return getDir;
    }

    function processFolder(getDir, rootFolder, recursionCount, palObj, recursionDepth, myStatus2) {
        clearOutput();
        writeLn(Immigration_Data.loading);
        var folderFilterType = 0;
        var folderFilter = "";
        if (app.settings.haveSetting("aescripts", "Immigration_folderFilter")) {
            folderFilterType = parseInt(app.settings.getSetting("aescripts", "Immigration_folderFilter"), 10);
        }
        if (folderFilterType != 0) {
            if (app.settings.haveSetting("aescripts", "Immigration_folderFilterText")) {
                folderFilter = app.settings.getSetting("aescripts", "Immigration_folderFilterText");
            }
        }
        folderFilter = folderFilter.replace(/\,\s+/g, ",").replace(/[-[\]{}()*+?.\\^$|#]/g, "\\$&");
        var myfolderFilterArray = folderFilter.split(Immigration_Data.strFolderFilterSeparator);
        var myfolderFilter = "" + myfolderFilterArray.join("|") + "";
        var currDirectory = getDir.fullName.replace(rootFolder.fullName, "") + "/";
        writeLn("folder: " + currDirectory);
        myStatus2.text = "folder: " + currDirectory;
        var subFolders = filterFolders(getDir, folderFilterType, myfolderFilter);
        var sortedFiles = new Array();
        if (folderFilterType != 2 || folderFilterType == 2 && getDir.name.match(myfolderFilter) != null) {
            sortedFiles = filterFiles(getDir);
        }
        myStatus2.text = "Finished Parsing folder: " + currDirectory;
        var fileList = filterSequences(sortedFiles, currDirectory);
        populatelistBox(palObj, currDirectory, fileList);
        if (subFolders.length > 0 && recursionCount < recursionDepth) {
            recursionCount++;
            for (var r = 0; r < subFolders.length; r += 1) {
                //console.log(subFolders[r]);
                processFolder(subFolders[r], rootFolder, recursionCount, palObj, recursionDepth, myStatus2);
            }
        }
        clearOutput();
    }

    function filterFolders(myFolder, filterType, myFilter) {
        var myDirs = betterGetFiles(myFolder.fsName.toString(), false);
        for (r = myDirs.length - 1; r > -1; r--) {
            if ($.os.indexOf("Mac") != -1) {
                if ((myDirs[r]).name.match(/^\./) != null) {
                    myDirs.splice(r, 1);
                }
            }
            switch (filterType) {
                case 0:
                    break;
                case 1:
                    if ((myDirs[r]).name.match(myFilter) != null) {
                        myDirs.splice(r, 1);
                    }
                    break;
                case 2:
                    break;
            }
        }
        return myDirs;
    }

    function folderCheck(f) {
        return f instanceof Folder;
    }

    function writeCmdScript() {
        var perlScript = Immigration_Data.tempFolder + "/Immigration_perlCmd.pl";
        var vbsFile = new File(Immigration_Data.tempFolder + "/Immigration_cmdLaunchScript.vbs");
        vbsFile.open("w", "TEXT", "????");
        vbsFile.writeln("Set objShell = WScript.CreateObject(\"WScript.Shell\")");
        vbsFile.writeln("objShell.Run \"%comspec% /c \"\"perl " + perlScript + "\"\"\",2,True");
        vbsFile.close();
    }

    function writePerlDirListScript(myFolderName, type, doSrt, fileAgeSettings) {
        if ($.os.indexOf("Mac") != -1) {
            var myPerl = "perl -le 'use File::Basename; ";
            myPerl += "@files = glob \"" + myFolderName + "/*\"; ";
        } else {
            var myPerl = "use File::Basename;\n";
            myPerl += "open (MYFILE, '>>" + Immigration_Data.tempOutput + "');\n";
            myPerl += "@files = glob '" + myFolderName + "/*';\n";
        }
        if (doSrt) {
            myPerl += "@files = map { $_->[0] }  ";
            myPerl += "sort { $a->[1] cmp $b->[1] ";
            myPerl += "|| ";
            myPerl += "$a->[2] <=> $b->[2] } ";
            myPerl += "map { m/(\\d+)(\\.[^.]+$)/ ? [$_, $2.$`,int($1)] : [$_, \"\", \"\"] } @files; ";
        }
        if (type) {
            myPerl += "@files = grep (" + Immigration_Data.extensionFilterRegex.toString() + ", @files);";
        }
        myPerl += "foreach $file (@files) { ";
        if (type) {
            myPerl += "if (-f $file) { ";
            if (fileAgeSettings[0] != 0) {
                if (fileAgeSettings[0] == 2 && fileAgeSettings[1] == 0 || fileAgeSettings[0] == 1 && fileAgeSettings[1] == 1) {
                    myPerl += "if (-M $file <= " + fileAgeSettings[2] + ") { ";
                } else {
                    myPerl += "if (-M $file >= " + fileAgeSettings[2] + ") { ";
                }
            }
            if ($.os.indexOf("Mac") != -1) {
                myPerl += "print basename($file); ";
            } else {
                myPerl += "print MYFILE basename($file).\"\\n\";\n";
            }
        } else {
            myPerl += "if (-d $file) { ";
            if ($.os.indexOf("Mac") != -1) {
                myPerl += "print $file; ";
            } else {
                myPerl += "print MYFILE $file.\"\\n\";\n";
            }
        }
        myPerl += "} ";
        if (type && fileAgeSettings[0] != 0) {
            myPerl += "} ";
        }
        if ($.os.indexOf("Mac") != -1) {
            myPerl += "}'";
        } else {
            myPerl += "}\n";
            myPerl += "close (MYFILE);";
            var perlFile = new File(Immigration_Data.tempFolder + "/Immigration_perlCmd.pl");
            perlFile.open("w", "TEXT", "????");
            perlFile.writeln(myPerl);
            perlFile.close();
        }
        return myPerl;
    }

    function betterGetFiles(myFolder, type, fileAgeSettings) {
        if ($.os.indexOf("Mac") != -1 || Immigration_Data.foundPerl && type && fileAgeSettings[0] != 0 || Immigration_Data.doExtensionSort) {
            var goAhead = true;
            if ($.os.indexOf("Mac") != -1) {
                var illegalCheck = myFolder.match(/(\\)|(\{)|(\})|(\')|(\")/g);
            } else {
                var illegalCheck = myFolder.match(/(\')|(\/)|(\?)|(<)|(>)|(\*)|(\")/g);
            }
            if (illegalCheck) {
                if (!type) {
                    alert("Illegal character: " + illegalCheck.toString().replace(/\,/g, " and ") + " found in folder name\n\n" + "Folder: \" " + myFolder.slice(myFolder.lastIndexOf("/") + 1).toString() + " \" will be skipped (ie. none of its files will be listed)")
                }
                goAhead = false;
                var getFilesArray = new Array();
            }
            if (goAhead) {
                if ($.os.indexOf("Mac") != -1) {
                    var myFolderEsc = myFolder.replace(/([\\\^\$*+[\]?{} =!:;><'\"(|)])/g, "\\$1");
                    var myFolderEsc2 = myFolderEsc.replace(/([\^\*+[\]? =!:;><'\"(|)])/g, "\\$1");
                } else {
                    var myFolderEsc2 = myFolder.replace(/'/g, "\\$1").replace(/\\/g, "/").replace(/ /g, "\\ ");
                }
                if (type) {
                    var myPerlCmd = writePerlDirListScript(myFolderEsc2, true, Immigration_Data.doExtensionSort, fileAgeSettings);
                } else {
                    var myPerlCmd = writePerlDirListScript(myFolderEsc2, false, false);
                }
                if ($.os.indexOf("Mac") != -1) {
                    var myCmd = myPerlCmd + " > " + Immigration_Data.tempOutput;
                } else {
                    var perlScript = Immigration_Data.tempFolder + "/Immigration_perlCmd.pl";
                    var myCmd = "cmd /c \"wperl " + perlScript + "\"";
                    var checkFile = File(Immigration_Data.tempOutput);
                    if (checkFile.exists) {
                        checkFile.remove();
                    }
                }
                var myOutput = system.callSystem(myCmd);
                if (type) {
                    clearOutput();
                    writeLn("Parsing Folder: " + Folder.decode(myFolder.slice(myFolder.lastIndexOf("/") + 1)));
                }
                var dumpFile = File(Immigration_Data.tempOutput);
                var fileOK = dumpFile.open("r", "TEXT", "???");
                if (fileOK) {
                    var fullFile = dumpFile.read();
                    if (!type) {
                        var getFilesArray = new Array();
                        var fileArray = fullFile.split("\n");
                        fileArray.pop();
                        for (var i = 0; i < fileArray.length; i += 1) {
                            getFilesArray[getFilesArray.length] = Folder(fileArray[i]);
                        }
                    } else {
                        var getFilesArray = fullFile.split("\n");
                        writeLn(getFilesArray.length + " items in folder");
                        getFilesArray.pop();
                    }
                    if (type) {
                        writeLn("Finished Parsing Folder: " + Folder.decode(myFolder.slice(myFolder.lastIndexOf("/") + 1)));
                    }
                    dumpFile.close();
                } else {
                    alert("Error\nImmigrationFileOutput file not found\nThis might be caused if Immigration is being run as an alias in the Scripts folder");
                }
            }
        } else {
            if (type) {
                var myCmd = "cmd /c \"dir /a-d /b /o:en \"" + myFolder + "\" > \"" + Immigration_Data.tempOutput + "\"\"";
            } else {
                var myCmd = "cmd /c \"dir /ad /b \"" + myFolder + "\" > \"" + Immigration_Data.tempOutput + "\"\"";
            }
            var checkFile = File(Immigration_Data.tempOutput);
            if (checkFile.exists) {
                checkFile.remove();
            }
            system.callSystem(myCmd);
            if (type) {
                clearOutput();
                writeLn("Parsing Folder: " + Folder.decode(myFolder.slice(myFolder.lastIndexOf("\\") + 1)));
            }
            var dumpFile = File(Immigration_Data.tempOutput);
            var fileOK = dumpFile.open("r", "TEXT", "???");
            if (fileOK) {
                var getFilesArray = new Array();
                var fullFile = dumpFile.read();
                var fileArray = fullFile.split("\n");
                if (type) {
                    writeLn(fileArray.length + " items in folder");
                }
                fileArray.pop();
                for (var i = 0; i < fileArray.length; i += 1) {
                    if (!type) {
                        getFilesArray[getFilesArray.length] = Folder(myFolder + "/" + fileArray[i]);
                    } else {
                        if ((fileArray[i]).match(/^\./) == null && (fileArray[i]).match(Immigration_Data.extensionFilterRegex)) {
                            getFilesArray[getFilesArray.length] = fileArray[i];
                        }
                    }
                }
                if (type) {
                    writeLn("Finished Parsing Folder: " + Folder.decode(myFolder.slice(myFolder.lastIndexOf("\\") + 1)));
                }
                dumpFile.close();
            } else {
                alert("Error\nImmigrationFileOutput file not found\nThis might be caused if Immigration is being run as an alias in the Scripts folder");
            }
        }
        return getFilesArray;
    }

    function filterFiles(myFolder) {
        var fileAgeFilterType = 0;
        var fileAgeFilterDelta = 0;
        var fileAgeFilter = NaN;
        var myTime = 0;
        if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilter")) {
            fileAgeFilterType = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeFilter"), 10);
        }
        if (fileAgeFilterType != 0) {
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilter2")) {
                fileAgeFilterDelta = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeFilter2"), 10);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeFilterText")) {
                fileAgeFilter = parseFloat(app.settings.getSetting("aescripts", "Immigration_fileAgeFilterText"), 10);
            }
            if (app.settings.haveSetting("aescripts", "Immigration_fileAgeTime")) {
                myTime = parseInt(app.settings.getSetting("aescripts", "Immigration_fileAgeTime"), 10);
            }
        }
        if (isNaN(fileAgeFilter)) {
            fileAgeFilterType = 0;
        } else {
            if (myTime == 1) {
                fileAgeFilter = (fileAgeFilter / 24).toFixed(2);
            }
        }
        var fileAgeSettings = [fileAgeFilterType, fileAgeFilterDelta, fileAgeFilter];
        var myFiles = betterGetFiles(myFolder.fsName, true, fileAgeSettings);
        return myFiles;
    }

    function alphanum(a, b) {
        function chunkify(t) {
            var tz = [];
            var x = 0;
            var y = -1;
            var n = 0;
            while (i = (j = t.charAt(x++)).charCodeAt(0)) {
                var m = i == 46 || i >= 48 && i <= 57;
                if (m !== n) {
                    tz[++y] = "";
                    n = m;
                }
                tz[y] += j;
            }
            return tz;
        }

        var aa = chunkify(a);
        var bb = chunkify(b);
        for (x = 0; aa[x] && bb[x]; x++) {
            if (aa[x] !== bb[x]) {
                var c = Number(aa[x]);
                var d = Number(bb[x]);
                if (c == aa[x] && d == bb[x]) {
                    return c - d;
                } else {
                    return (aa[x] > bb[x] ? 1 : -1);
                }
            }
        }
        return aa.length - bb.length;
    }

    function filterSequences(myFiles, currDir) {
        var s = myFiles;
        var myList = new Array();
        s.push("");
        var isSeq = false;
        var frameRangeStart = 1;
        var frameRangeEnd = 1;
        var mySeqName = "";
        var seqSaveFile = "";
        var jumpAhead = false;
        var jumpAheadAmount = 100;
        var jumpAheadPrefix = "";
        var jumpAheadExt = "";
        if (Immigration_Data.loggingMode) {
            var logFile = new File(Immigration_Data.logFileLocation + "/log-" + currDir.replace(/\//g, "") + ".txt");
            logFile.open("w", "TEXT", "????");
            logFile.writeln("currDir: " + currDir);
            logFile.writeln("s.length -1: " + (s.length - 1));
            logFile.writeln("jumpAheadAmount: " + jumpAheadAmount);
            logFile.writeln("myFiles:\r" + myFiles.toString());
        }
        var a = 0;
        var b = 0;
        var jumpAheadSavePlace = 0;
        var jumpAheadSave_i = 0;
        var i = 0;
        var counter = 0;
        while (i < (s.length - 1)) {
            if (Immigration_Data.loggingMode) {
                logFile.writeln("\rtop of loop i: " + i + "\r\r");
            }
            if (Immigration_Data.loggingMode) {
                logFile.writeln("counter:" + counter + "\n\n");
            }
            var testA = Immigration_Data.endMatchRegex.exec(s[i]);
            var testB = Immigration_Data.endMatchRegex.exec(s[i + 1]);
            var testAint = parseInt(testA, 10);
            var testBint = parseInt(testB, 10);
            if (testA != null) {
                var namePrefix = (s[i]).slice(0, (s[i]).search(testA[0]));
                var nameExt = "." + testA[2];
            } else {
                var dotPos = (s[i]).lastIndexOf(".");
                if (dotPos == -1) {
                    var namePrefix = s[i];
                    var nameExt = "";
                } else {
                    var namePrefix = (s[i]).slice(0, dotPos);
                    var nameExt = "." + (s[i]).slice(dotPos + 1, (s[i]).length);
                }
            }
            if (testB != null) {
                var namePrefixB = (s[i + 1]).slice(0, (s[i + 1]).search(testB[0]));
                var nameExtB = "." + testB[2];
            } else {
                var dotPosB = (s[i + 1]).lastIndexOf(".");
                if (dotPosB == -1) {
                    var namePrefixB = s[i + 1];
                    var nameExtB = "";
                } else {
                    var namePrefixB = (s[i + 1]).slice(0, dotPosB);
                    var nameExtB = "." + (s[i + 1]).slice(dotPosB + 1, (s[i + 1]).length);
                }
            }
            if (!isNaN(testAint)) {
                a = testAint;
            }
            if (!isNaN(testBint)) {
                b = testBint;
            }
            if (Immigration_Data.loggingMode) {
                logFile.writeln("namePrefix: " + namePrefix + " nameExt: " + nameExt + " jumpAheadSavePlace: " + jumpAheadSavePlace + " jumpAheadAmount: " + jumpAheadAmount);
            }
            if (Immigration_Data.loggingMode) {
                logFile.writeln("a: (" + a + ") " + s[i] + " " + a + " b: (" + b + ") " + s[i + 1] + " " + b);
            }
            if (jumpAhead && (jumpAheadPrefix != namePrefixB || jumpAheadExt != nameExtB || (jumpAheadSavePlace - b) != -1)) {
                if (Immigration_Data.loggingMode) {
                    logFile.writeln("jumpAheadPrefix: " + jumpAheadPrefix + " namePrefix: " + namePrefix + " jumpAheadExt: " + jumpAheadExt + " nameExt: " + nameExt + " a: " + a + " jumpAheadSavePlace: " + jumpAheadSavePlace + " jumpAhead: " + jumpAhead);
                }
                i = jumpAheadSave_i;
                jumpAhead = false;
                if (Immigration_Data.loggingMode) {
                    logFile.writeln("jumpAhead = false");
                }
            } else {
                if ((a - b) != -1 || namePrefix != namePrefixB || nameExt != nameExtB || nameExt.toLowerCase().match(Immigration_Data.nonSequenceRegex) && !jumpAhead) {
                    if (Immigration_Data.loggingMode) {
                        logFile.writeln("counter:" + counter);
                    }
                    counter = -1;
                    if (nameExt.toLowerCase().match(Immigration_Data.nonSequenceRegex)) {
                        isSeq = false;
                    }
                    if (isSeq) {
                        mySeqName = saveSeqName;
                        frameRangeEnd = a;
                    } else {
                        mySeqName = namePrefix;
                        frameRangeEnd = 1;
                        seqSaveFile = s[i];
                    }
                    myList[myList.length] = [mySeqName, frameRangeStart + "-" + frameRangeEnd, nameExt, seqSaveFile];
                    if (Immigration_Data.loggingMode) {
                        logFile.writeln("\n\n\nXXXXXX  GOT ONE  XXXXX       " + mySeqName + "\n\n\nmyList: " + myList.toString());
                    }
                    isSeq = false;
                    frameRangeStart = 1;
                } else {
                    if (!isSeq && !jumpAhead) {
                        var saveSeqName = namePrefix;
                        frameRangeStart = a;
                        seqSaveFile = s[i];
                    }
                    if ((a - b) == -1) {
                        isSeq = true;
                        if ((i + jumpAheadAmount) < (s.length - 3)) {
                            jumpAheadPrefix = namePrefix;
                            jumpAheadExt = nameExt;
                            if (Immigration_Data.loggingMode) {
                                logFile.writeln("jumpAheadPrefix: " + jumpAheadPrefix);
                                logFile.writeln("jumpAheadExt: " + jumpAheadExt);
                            }
                            jumpAheadSave_i = i;
                            jumpAheadSavePlace = a + jumpAheadAmount;
                            if (Immigration_Data.loggingMode) {
                                logFile.writeln("jumpAheadSavePlace: " + jumpAheadSavePlace);
                            }
                            jumpAhead = true;
                            if (Immigration_Data.loggingMode) {
                                logFile.writeln("jumpAhead = true");
                            }
                            i += jumpAheadAmount;
                            if (Immigration_Data.loggingMode) {
                                logFile.writeln("i += jumpAheadAmount: " + i);
                            }
                            continue;
                        } else {
                            if (Immigration_Data.loggingMode) {
                                logFile.writeln("Removing Jumpahead: " + s[i]);
                            }
                            jumpAhead = false;
                        }
                    }
                }
            }
            if ((i % jumpAheadAmount) == 0) {
                clearOutput();
                writeLn(Immigration_Data.loading);
                writeLn("folder: " + currDir + " file: " + i + " out of " + s.length);
            }
            i++;
            counter++;
        }
        if (Immigration_Data.loggingMode) {
            logFile.close;
        }
        return myList;
    }

    function populatelistBox(palObj, currDirectory, fileList) {
        for (var i = 0; i < fileList.length; i += 1) {
            var padAmount = Immigration_Data.padAmount;
            var decodedFileName = unescape((fileList[i])[3]);
            if ((fileList[i])[3].charAt(0) != ".") {
                if ((fileList[i])[1] == "1-1") {
                    palObj.grp.list.listing.listBox.add("item", currDirectory.toString() + decodedFileName);
                    palObj.grp.list.listing.listBox2.add("item", PadDigits(palObj.grp.list.listing.listBox.items.length, padAmount) + currDirectory.toString() + decodedFileName + "[" + (fileList[i])[1] + "]" + ":" + unescape((fileList[i])[0]) + ":" + unescape((fileList[i])[2]));
                } else {
                    palObj.grp.list.listing.listBox.add("item", currDirectory.toString() + File.decode((fileList[i])[0]).replace(/%20/g, " ") + "[" + (fileList[i])[1] + "]" + (fileList[i])[2]);
                    palObj.grp.list.listing.listBox2.add("item", PadDigits(palObj.grp.list.listing.listBox.items.length, padAmount) + currDirectory.toString() + decodedFileName + "[" + (fileList[i])[1] + "]" + ":" + unescape((fileList[i])[0]) + ":" + unescape((fileList[i])[2]));
                }
            }
        }
        return;
    }

    function getIcon(iconFile, hexStr) {
        var retFile = iconFile;
        if (!retFile.exists) {
            var binStr = hexToBin(hexStr);
            retFile = new File(retFile.fsName);
            retFile.encoding = "BINARY";
            retFile.open("w");
            retFile.write(binStr);
            retFile.close();
        }
        return retFile;
    }

    function hexToBin(hexStr) {
        var binStr = "";
        var hexChars = "0123456789ABCDEF";
        for (var h = 0; h < hexStr.length; h += 2) {
            hi = hexStr.charAt(h).toUpperCase();
            lo = hexStr.charAt(h + 1).toUpperCase();
            binStr += String.fromCharCode((hexChars.indexOf(hi) * 16) + hexChars.indexOf(lo));
        }
        return binStr;
    }

    function isSecurityPrefSet() {
        var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
        return securitySetting == 1;
    }

    function checkBeta() {
        var betaExpired = false;
        var today = new Date();
        var betaExpDate = Immigration_Data.betaExpiration;
        var one_day = 86400000;
        var todayInMs = parseInt(today, 10) / one_day;
        var betaExpInMs = parseInt(betaExpDate, 10) / one_day;
        if (todayInMs > betaExpInMs) {
            betaExpired = true;
        }
        return betaExpired;
    }

    function immigration_trial_serialization(cmd) {
        if (cmd == undefined) {
            cmd = "license"
        }
        var strScriptName = Immigration_Data.scriptName;
        var strTrialUrl = "http://aescripts.com/immigration";
        var privateNum = 56679;
        var supportEmail = "support@aescripts.com";
        var trialLengthDays = 14;
        var trialLengthLaunches = 10;
        var strExpiredAlert = localize({
            en: "Sorry, this trial version of the script has expired. \nYou can purchase a license at " + strTrialUrl + "\n\nWould you like to go there now?",
            de: "Die Testversion des Skriptes ist leider abgelaufen.\n Du kannst unter " + strTrialUrl + " eine Lizenz erwerben.\n\nMöchtest Du jetzt dorthin gehen?",
            fr: "Désolé, cette version d'essais du script a expiré. \nVous pouvez acheter une licence à " + strTrialUrl + "\n\nVoulez vous y aller maintenant ?"
        });
        var strRegSuccess = localize({
            en: "Registration Successful\nThank you for purchasing " + strScriptName + " and supporting the AE scripting community!",
            de: "Registrierung erfolgreich\nDanke für den Kauf von " + strScriptName + " und die Unterstützung der AE Scripting Community!",
            fr: "Enregistrement réussi\nMerci d'avoir acheté " + strScriptName + " et de contribuer à la communauté de script AE"
        });
        var strInvalidCode = localize({
            en: "Sorry, the registration code is not valid\n\nIf you require assistance please contact " + supportEmail,
            de: "Entschuldigung, der Registrierungscode ist nicht gültig.\n\nWenn Du Hilfe benötigst, kontaktiere bitte " + supportEmail,
            fr: "Désolé, le numéro de licence n'est pas valide\n\nSi vous avez besoin d'aide, merci de contacter " + supportEmail
        });
        var strCorruptedCode = localize({
            en: "Sorry, something must have happened to the registration code.  Please re-enter it at the prompt.\nIf you require assistance please contact " + supportEmail,
            de: "Entschuldigung, irgendetwas ist mit dem Registrierungscode passiert. Bitte gebe ihn erneut ein.\n\nWenn Du Hilfe benötigst, kontaktiere bitte " + supportEmail,
            fr: "Désolé, il y a eu un problème avec votre numéro de licence. Merci de bien vouloir l'entrer de nouveau \n\nSi vous avez besoin d'aide, merci de contacter " + supportEmail
        });
        var strTrialThanks = localize({
            en: "Thanks for trying " + strScriptName + "!",
            de: "Danke, dass Du " + strScriptName + " ausprobierst!",
            fr: "Merci d'utiliser " + strScriptName + "!"
        });
        var strTrialTxt = localize({
            en: "%E days left in the trial",
            de: "%E Tage übrig für die Testversion",
            fr: "Il vous reste %E jours d'essais"
        });
        var strTrialTxt2 = localize({
            en: "%E launches left in the trial",
            de: "%E Programmstarts übrig für die Testversion",
            fr: "Il vous reste %E essais"
        });
        var strTrialWelcomeHeader = localize({
            en: "Welcome to " + strScriptName,
            de: "Willkommen bei " + strScriptName,
            fr: "Bienvenue sur " + strScriptName
        });
        var strErrScriptAccess = localize({
            en: "This script requires access to write files.\nGo to the \"General\" panel of the application preferences and make sure \"Allow Scripts to Write Files and Access Network\" is checked.",
            de: "Dieses Skript benötigt die Erlaubnis Dateien zu schreiben.\n Gehe in Voreinstellungen von After Effects in die Rubrik \"Allgemein\" und aktiviere die Option \"Skripten können Dateien schreiben und haben Netzwerkzugang\".",
            fr: "Ce script nécessite les droits d'écriture de fichiers.\nAllez dans le panneau \"Général\" des préférences de l'application et cochez \n\"Autoriser les scripts à écrire des fichiers et à accéder au réseau\""
        });
        var prefsSectionName = "aescripts";
        var prefsName = strScriptName + "_Registration";
        var winProgramFiles = Folder.commonFiles.parent.fsName;
        var winBrowserCmd = ($.os.indexOf("XP") != -1 ? "\"" + winProgramFiles + "\\Internet Explorer\\iexplore.exe\" " : "start ");
        var macBrowserCmdStart = "open \"";
        var macBrowserCmdEnd = "\"";
        if ($.os.indexOf("Mac") != -1) {
            var cmdKey = "⌘";
        } else {
            var cmdKey = "Ctrl";
        }
        var strTrialWelcomeMsg = localize({
            en: "Please enter the CG**Percia**87002265STE code.\nIf pasting the code with " + cmdKey + "+V doesn't work try " + (parseFloat(app.version) >= 10 ? "Right-Click and Paste" : "Edit->Paste") + "\nIf you need to retrieve your license you can do so at http://license.aescripts.com  To run in trial mode type: trial\n",
            de: "Bitte gebe den Lizenzcode ein. Wenn das Einfügen mit " + cmdKey + "+V nicht funktioniert, versuche Bearbeiten->Einfügen\n Deinen Lizenzcode erfährst Du unter http://license.aescripts.com. Um die Testversion zu starten, gebe \"trial\" ein.",
            fr: "Merci d'entrer votre numéro de licence.\nSi vous ne parvenez pas à coller le code avec " + cmdKey + "+V essayez Clique droit et Coller \nSi vous avez besoin de retrouver votre numéro de licence vous pouvez aller sur http://license.aescripts.com Pour lancer en mode essais, tapez : trial\n"
        });
        var prefHeader = "Initialization Fragments";
        var prefSection1 = (string_encode(strScriptName) * privateNum * 0.221).toString(36);
        var prefSection2 = (string_encode(strScriptName) * (privateNum / 3.243)).toString(36);

        function checkTrial(mode) {
            var trialExpired = false;
            var today = new Date();
            var one_day = 86400000;
            var todayInMsFixed = ((parseInt(today, 10) / one_day) / 1000000).toFixed(6);
            if (app.settings.haveSetting(prefHeader, prefSection1)) {
                var trialStartDate = parseInt(app.settings.getSetting(prefHeader, prefSection1), 16) / 100000000000;
            } else {
                var trialStartDate = todayInMsFixed;
                app.settings.saveSetting(prefHeader, prefSection1, (trialStartDate * 100000000000).toString(16));
            }
            if (app.settings.haveSetting(prefHeader, prefSection2)) {
                var launchCount = parseInt(app.settings.getSetting(prefHeader, prefSection2), 16) / 1000000000000;
                app.settings.saveSetting(prefHeader, prefSection2, ((launchCount + 1) * 1000000000000).toString(16));
            } else {
                var launchCount = 1;
                app.settings.saveSetting(prefHeader, prefSection2, (launchCount * 1000000000000).toString(16));
            }
            app.preferences.saveToDisk();
            var trialLengthSoFar = Math.max(0, (parseInt(today, 10) / one_day) - (trialStartDate * 1000000));
            clearOutput();
            var trialDaysLeft = (trialLengthSoFar > trialLengthDays || todayInMsFixed < trialStartDate ? 0 : Math.ceil(trialLengthDays - trialLengthSoFar));
            var launchesLeft = Math.max(0, trialLengthLaunches - launchCount);
            if (trialLengthSoFar > trialLengthDays && launchCount > trialLengthLaunches || todayInMsFixed < trialStartDate) {
                trialExpired = true;
            }
            if (trialDaysLeft > 0 && mode != "balance") {
                writeLn(strTrialThanks);
                writeLn(strTrialTxt.replace(/%E/g, trialDaysLeft));
            } else {
                if (!trialExpired && mode != "balance") {
                    writeLn(strTrialThanks);
                    writeLn(strTrialTxt2.replace(/%E/g, launchesLeft));
                }
            }
            if (mode == "balance") {
                return 5;
                return trialDaysLeft;
            } else {
                return trialExpired;
            }
        }

        function string_encode(str) {
            return (str.length * str.charCodeAt(0)) + str.charCodeAt(Math.floor((str.length - 1) * 0.1)) + str.charCodeAt(Math.floor((str.length - 1) * 0.2)) + str.charCodeAt(Math.floor((str.length - 1) * 0.3)) + str.charCodeAt(Math.floor((str.length - 1) * 0.4)) + str.charCodeAt(Math.floor((str.length - 1) * 0.5)) + str.charCodeAt(Math.floor((str.length - 1) * 0.7)) + str.charCodeAt(Math.floor((str.length - 1) * 0.8)) + str.charCodeAt(Math.floor((str.length - 1) * 0.9)) + str.charCodeAt(str.length - 1);
        }

        function checkCode(doPrompt, myReg, privateNum) {
            return "trial";
            myLicense = "0";
            if (doPrompt) {
                var myReg = prompt(strTrialWelcomeMsg, "CG**Percia**87002265STE", strTrialWelcomeHeader);
            }
            regOK = false;
            if (myReg) {
                if (myReg.toLowerCase() != "CG**Percia**87002265STE") {
                    var myRegArray = myReg.split("**");
                    if (myRegArray.length == 3) {
                        myLicense = myRegArray[2].substring(myRegArray[2].length - 3, myRegArray[2].length);
                        var name = myRegArray[0] + myRegArray[1] + myLicense;
                        var tempKey = myRegArray[2].substring(0, myRegArray[2].length - 3);
                        var nameEncode = string_encode(name);
                        var key = nameEncode * privateNum;
                        if (key == tempKey) {
                            if (doPrompt) {
                                app.settings.saveSetting(prefsSectionName, prefsName, myReg);
                                app.preferences.saveToDisk();
                                alert(strRegSuccess);
                            }
                            regOK = true;
                        } else {
                            if (doPrompt) {
                                alert(strInvalidCode);
                                checkCode(doPrompt);
                            } else {
                                alert(strCorruptedCode);
                                doPrompt = true;
                                app.settings.saveSetting(prefsSectionName, prefsName, "bad");
                                app.preferences.saveToDisk();
                                checkCode(doPrompt);
                            }
                        }
                    } else {
                        alert(strInvalidCode);
                        doPrompt = true;
                        app.settings.saveSetting(prefsSectionName, prefsName, "bad");
                        app.preferences.saveToDisk();
                        checkCode(doPrompt);
                    }
                } else {
                    if (checkTrial()) {
                        var goToUrl = confirm(strExpiredAlert);
                        if (isSecurityPrefSet() && goToUrl) {
                            openURL(strTrialUrl)
                        } else {
                            if (goToUrl) {
                                alert(strErrScriptAccess)
                            }
                        }
                    } else {
                        myLicense = "trial";
                        regOK = true;
                    }
                }
            }
            return (regOK ? myLicense : "0");
        }

        function isSecurityPrefSet() {
            var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
            return securitySetting == 1;
        }

        function openURL(url) {
            if ($.os.indexOf("Windows") != -1) {
                system.callSystem("cmd /c \"" + winBrowserCmd + url + "\"");
            } else {
                system.callSystem(macBrowserCmdStart + url + macBrowserCmdEnd);
            }
        }

        function parseRegistration(checkReg) {
            if (checkReg != null) {
                var myReg = checkReg.replace(/_/g, " ");
                var myRegArray = myReg.split("**");
                if (myRegArray.length == 3) {
                    var regFirstName = myRegArray[0];
                    var regLastName = myRegArray[1];
                    var numLicenses = 0;
                    var matchMutliLic = regLastName.match(/([^\(]+)\(([0-9]+) Users\)$/);
                    if (matchMutliLic != null && matchMutliLic.length == 3) {
                        regLastName = matchMutliLic[1];
                        numLicenses = parseFloat(matchMutliLic[2]);
                    }
                    var regName = regFirstName + " " + regLastName;
                    var regLicense = myRegArray[2].substring(myRegArray[2].length - 3, myRegArray[2].length);
                    var multiLicense = (numLicenses > 1 ? " for " + numLicenses + " Users" : " for 1 User");
                    switch (regLicense) {
                        case "SUL":
                            myLicense = " - License" + multiLicense;
                            break;
                        case "Pro":
                            myLicense = " - Pro License" + multiLicense;
                            break;
                        case "STE":
                            myLicense = " - Site License";
                            break;
                        case "psr":
                            myLicense = " - Pro Site License";
                            break;
                    }
                    var regHeader = regName + " " + myLicense;
                } else {
                    alert("Registration length is incorrect.");
                }
            } else {
                var daysLeft = checkTrial("balance");
                var regHeader = "Trial (" + daysLeft + " days left)";
            }
            return regHeader;
        }

        if (cmd == "license") {
            if (app.settings.haveSetting(prefsSectionName, prefsName)) {
                var myReg = app.settings.getSetting(prefsSectionName, prefsName);
                if (myReg == "bad") {
                    var doPrompt = true;
                } else {
                    var doPrompt = false;
                }
                var theLicense = checkCode(doPrompt, myReg, privateNum);
            } else {
                var doPrompt = true;
                var theLicense = checkCode(doPrompt, myReg, privateNum);
            }
            return theLicense;
        }
        if (cmd == "parseReg") {
             if (app.settings.haveSetting(prefsSectionName, prefsName)) {
                 myReg = app.settings.getSetting(prefsSectionName, prefsName);
                 var theRegistration = parseRegistration(myReg);
             } else
            {
                var theRegistration = parseRegistration(null);
            }
            return theRegistration;
        }
    }

    if (parseFloat(app.version) < 8) {
        alert(Immigration_Data.strMinAE80, Immigration_Data.scriptName);
    } else {
        if (Immigration_Data.betaMode) {
            var betaExpired = checkBeta();
        } else {
            var betaExpired = false;
        }
        if (betaExpired) {
            alert(Immigration_Data.betaExpiredWarning);
            if (isSecurityPrefSet()) {
                openURL(Immigration_Data.strImmigrationTrialUrl);
            } else {
                alert(Immigration_Data.strErrScriptAccess);
            }
        } else {
            if (Immigration_Data.checkTrial) {
                Immigration_Data.serial_Check = immigration_trial_serialization("license");
                if (Immigration_Data.serial_Check != "0") {
                    if (isSecurityPrefSet()) {
                        var myPal = Immigration_buildUI(thisObj);
                        if (myPal != null) {
                            if (app.settings.haveSetting("aescripts", "Immigration_frameRate")) {
                                myPal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text = app.settings.getSetting("aescripts", "Immigration_frameRate");
                            } else {
                                if (parseFloat(app.version) <= 10) {
                                    try {
                                        myPal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text = app.preferences.getPrefAsLong("General Section", "Default Import Sequence FPS");
                                    } catch (e) {

                                    }
                                } else {
                                    try {
                                        myPal.grp.buttons.buttonsL.statusFR.buttonsFR.frameRate.text = app.preferences.getPrefAsLong("Import Options Preference Section", "Import Options Default Sequence FPS");
                                    } catch (e) {

                                    }
                                }
                            }
                            if (myPal instanceof Window) {
                                myPal.center();
                                myPal.show();
                            } else {
                                myPal.layout.layout(true);
                            }
                        }
                    } else {
                        alert(Immigration_Data.strErrScriptAccess, Immigration_Data.scriptName);
                    }
                }
            }
        }
    }
}

Immigration(this);