//初始化文件,可能会被覆盖!
var arif_globals = {
    scriptName: "Reveal in Finder",
    scriptVersion: "1.0",
    strErrScriptAccess: "This script requires access to write files.\nGo to the \"General\" panel of the application preferences and make sure \"Allow Scripts to Write Files and Access Network\" is checked."
};
Ae_RevealInFinder();

function Ae_RevealInFinder() {
    if (!isSecurityPrefSet()) {
        alert(arif_globals.strErrScriptAccess);
        app.executeCommand(2359);
        if (!isSecurityPrefSet()) {
            return;
        }
    }
    app.beginUndoGroup(arif_globals.scriptName);
    var myComp = app.project.activeItem;
    if (myComp == null) {
        return;
    }
    if (myComp instanceof CompItem && myComp.selectedLayers.length != 1) {
        alert("Please select only 1 layer");
        return;
    }
    if (myComp instanceof CompItem) {
        var myLayer = myComp.selectedLayers[0];
        if (myLayer.source == null || myLayer.source.file == null) {
            alert("The selected layer does not have a source in the Finder");
            return;
        }
        myLayer = myLayer.source.file;
    }
    if (myComp instanceof FootageItem) {
        var myLayer = myComp.file;
        if (myLayer == null) {
            alert("The selected item does not have a source in the Finder");
            return;
        }
    }
    if ($.os.indexOf("Mac") != -1) {
        system.callSystem("open -a Finder \"" + myLayer.parent.fsName + "\"");
        if (myLayer.fsName.match(/'/) == null) {
            var revealAppleScript = "osascript -e 'tell application \"Finder\" to select POSIX file \"" + myLayer.fsName + "\"'";
            system.callSystem(revealAppleScript);
        }
    } else {

            system.callSystem("F:\\BoBOAHK\\WorkFlow\\tools\\TotalCMD\\TOTALCMD.EXE /O /S /L=" + myLayer.fsName + "\"" );
    }

    function isSecurityPrefSet() {
        var securitySetting = app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY");
        return securitySetting == 1;
    }
}