// Iterates through history states and snapshots,gives boolean result if snapshot name matches entered text.
 
function checkhistorystates(snapshotavailable,nameofsnapshot) {
var snapshotavailable = false;
var doc = app.activeDocument;
var theHist = doc.historyStates;
var theSnaps = new Array;
for (var m = 0; m < theHist.length; m++) {
    var theState = theHist[m];
    if (theState.snapshot == true  && theState.name == nameofsnapshot ) {
    snapshotavailable= true;
    return snapshotavailable;
    return nameofsnapshot;
    theSnaps.push(theState)  
    }
};
return snapshotavailable;
}
 
var snapshotstatus = checkhistorystates(false,'Initial');
 
if (snapshotstatus == true) {
    alert ("True");
    }
else if (snapshotstatus != true) {
    alert ("False");
    }