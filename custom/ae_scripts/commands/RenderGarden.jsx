if (typeof JSON !== "object") {
    JSON = {};
}
(function () {
    "use strict";
    var rx_one = /^[\],:{}\s]*$/;
    var rx_two = /\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g;
    var rx_three = /"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g;
    var rx_four = /(?:^|:|,)(?:\s*\[)+/g;
    var rx_escapable = /[\\"\u0000-\u001f\u007f-\u009f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;
    var rx_dangerous = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g;

    function f(n) {
        return (n < 10 ? "0" + n : n);
    }

    function this_value() {
        return this.valueOf();
    }
    if (typeof Date.prototype.toJSON !== "function") {
        Date.prototype.toJSON = function () {
            return (isFinite(this.valueOf()) ? this.getUTCFullYear() + "-" + f(this.getUTCMonth() + 1) + "-" + f(this.getUTCDate()) + "T" + f(this.getUTCHours()) + ":" + f(this.getUTCMinutes()) + ":" + f(this.getUTCSeconds()) + "Z" : null);
        };
        Boolean.prototype.toJSON = this_value;
        Number.prototype.toJSON = this_value;
        String.prototype.toJSON = this_value;
    }

    function quote(string) {
        rx_escapable.lastIndex = 0;
        return (rx_escapable.test(string) ? "\"" + string.replace(rx_escapable, function (a) {
            var c = meta[a];
            return (typeof c === "string" ? c : "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4));
        }) + "\"" : "\"" + string + "\"");
    }

    function str(key, holder) {
        var mind = gap;
        var value = holder[key];
        if (value && typeof value === "object" && typeof value.toJSON === "function") {
            value = value.toJSON(key);
        }
        if (typeof rep === "function") {
            value = rep.call(holder, key, value);
        }
        switch (typeof value) {
            case "string":
                return quote(value);
            case "number":
                return (isFinite(value) ? String(value) : "null");
            case "boolean":
            case "null":
                return String(value);
            case "object":
                if (!value) {
                    return "null";
                }
                gap += indent;
                partial = [];
                if (Object.prototype.toString.apply(value) === "[object Array]") {
                    length = value.length;
                    for (var i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || "null";
                    }
                    v = ((partial.length === 0 ? "[]" : gap) ? "[\n" + gap + partial.join(",\n" + gap) + "\n" + mind + "]" : "[" + partial.join(",") + "]");
                    gap = mind;
                    return v;
                }
                if (rep && typeof rep === "object") {
                    length = rep.length;
                    for (var i = 0; i < length; i += 1) {
                        if (typeof rep[i] === "string") {
                            k = rep[i];
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ": " : ":") + v);
                            }
                        }
                    }
                } else {
                    for (var k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ": " : ":") + v);
                            }
                        }
                    }
                }
                v = ((partial.length === 0 ? "{}" : gap) ? "{\n" + gap + partial.join(",\n" + gap) + "\n" + mind + "}" : "{" + partial.join(",") + "}");
                gap = mind;
                return v;
        }
    }
    if (typeof JSON.stringify !== "function") {
        meta = {
            "\b": "\\b",
            "\t": "\\t",
            "\n": "\\n",
            "\f": "\\f",
            "\r": "\\r",
            "\"": "\\\"",
            "\\": "\\\\"
        };
        JSON.stringify = function (value, replacer, space) {
            gap = "";
            indent = "";
            if (typeof space === "number") {
                for (var i = 0; i < space; i += 1) {
                    indent += " ";
                }
            } else {
                if (typeof space === "string") {
                    indent = space;
                }
            }
            rep = replacer;
            if (replacer && typeof replacer !== "function" && typeof replacer !== "object" || typeof replacer.length !== "number") {
                throw new Error("JSON.stringify")
            }
            return str("", {
                "": value
            });
        };
    }
    if (typeof JSON.parse !== "function") {
        JSON.parse = function (text, reviver) {
            function walk(holder, key) {
                var value = holder[key];
                if (value && typeof value === "object") {
                    for (var k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = walk(value, k);
                            if (v !== undefined) {
                                value[k] = v;
                            } else {
                                delete value[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, value);
            }
            text = String(text);
            rx_dangerous.lastIndex = 0;
            if (rx_dangerous.test(text)) {
                text = text.replace(rx_dangerous, function (a) {
                    return "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4);
                });
            }
            if (rx_one.test(text.replace(rx_two, "@").replace(rx_three, "]").replace(rx_four, ""))) {
                j = eval("(" + text + ")");
                return (typeof reviver === "function" ? walk({
                    "": j
                }, "") : j);
            }
            throw new SyntaxError("JSON.parse")
        };
    }
})();
if (typeof Folder.pathSep !== "string") {
    Folder.pathSep = (Folder.fs === "Macintosh" ? "/" : "\\")
}
if (typeof Folder.prototype.folder !== "function") {
    Folder.prototype.folder = function (name) {
        return new Folder(this.fsName + Folder.pathSep + name);
    }
}
if (typeof Folder.prototype.file !== "function") {
    Folder.prototype.file = function (name) {
        return new File(this.fsName + Folder.pathSep + name);
    }
}
if (typeof Folder.prototype.dispName !== "function") {
    Folder.prototype.dispName = function () {
        if (this.displayName != "") {
            return this.displayName;
        } else {
            return decodeURI(this.name);
        }
    }
}
if (typeof File.prototype.dispName !== "function") {
    File.prototype.dispName = function () {
        if (this.displayName != "") {
            return this.displayName;
        } else {
            return decodeURI(this.name);
        }
    }
}
if (typeof File.prototype.incrementedFile !== "function") {
    File.prototype.incrementedFile = function () {
        var wholeFileName = this.dispName();
        var incrementedName = wholeFileName;
        var numberMatches = wholeFileName.match(/[0-9]+/g);
        if (numberMatches instanceof Array && numberMatches.length > 0) {
            var numberStringToIncrement = numberMatches[numberMatches.length - 1];
            var numberToIncrementTo = parseInt(numberStringToIncrement, 10) + 1;
            var numberStringReplace = numberToIncrementTo.toString();
            while (numberStringReplace.length < numberStringToIncrement.length) {
                numberStringReplace = "0" + numberStringReplace
            }
            incrementedName = wholeFileName.replace(new RegExp(numberStringToIncrement, "g"), numberStringReplace);
        } else {
            incrementedName = wholeFileName.substr(0, wholeFileName.length - 4) + "_01.aep";
        }
        var incrementedFile = this.parent.file(incrementedName);
        return incrementedFile;
    }
}
if (typeof File.prototype.fileExtension !== "function") {
    File.prototype.fileExtension = function () {
        var dispName = this.dispName();
        var dotPos = dispName.lastIndexOf(".");
        if (dotPos > 0 && dotPos < (dispName.length - 1)) {
            return dispName.substring(dotPos + 1);
        } else {
            return null;
        }
    }
}
if (typeof File.prototype.baseName !== "function") {
    File.prototype.baseName = function () {
        var baseName = this.dispName();
        baseName = baseName.replace(/[_\.]?\[#+\]/, "");
        var dotPos = baseName.lastIndexOf(".");
        if (dotPos > -1) {
            return baseName.substring(0, dotPos);
        } else {
            return baseName;
        }
    }
}
if (typeof File.prototype.isFrameSequence !== "function") {
    File.prototype.isFrameSequence = function () {
        return this.dispName().search(/\[#+\]/) > -1;
    }
}
if (typeof File.prototype.frameInSequence !== "function") {
    File.prototype.frameInSequence = function (number) {
        var dispName = this.dispName();
        var sequenceToken = dispName.search(/\[#+\]/);
        if (sequenceToken < 0) {
            return this;
        }
        var cursor = sequenceToken + 1;
        var frameNumLen = 0;
        while (dispName[cursor++] == "#") {
            frameNumLen++
        }
        var frameNumStr = number.toString();
        while (frameNumStr.length < frameNumLen) {
            frameNumStr = "0" + frameNumStr
        }
        return this.parent.file(dispName.replace(/\[#+\]/, frameNumStr));
    }
}
(function (thisObj) {
    var versionNumber = "1.1.2";
    var renderGardenKey = "RenderGarden";
    var renderGardenRunBeforeKey = "runBefore";
    var renderGardenNumberOfSeedsKey = "numberOfSeeds";
    var renderGardenUsePriorityKey = "usePriority";
    var renderGardenPriorityKey = "priority";
    var renderGardenPostRenderActionsKey = "postRenderActions";
    var renderGardenSeedBankKey = "seedBank";
    var renderGardenIncrementAndSaveKey = "incrementAndSave";
    var renderGardenRelativeKey = "relativePaths";
    var renderGardenGardenerKey = "gardener";
    var renderGardenShortSeedsKey = "shortSeeds";
    var renderGardenAECommandKey = "AEcommand";
    var renderGardenAERenderKey = "aerenderPath_" + app.version.substr(0, 4);
    var renderGardenPythonKey = "pythonPath";
    var renderGardenFFmpegKey = "FFmpeg";
    var renderGardenCombineCommandKey = "combineCommand";
    var renderGardenQuickTimeKey = "quicktime";
    var renderGardenQuickTimeCodecKey = "quicktimeCodec";
    var renderGardenQuickTimeCommandKey = "quicktimeCommand";
    var renderGardenQuickTimeExtensionKey = "quicktimeExtension";
    var renderGardenDnxhdFormatKey = "dnxhdFormat";
    var renderGardenH264Key = "h264";
    var renderGardenH264CommandKey = "h264command";
    var renderGardenH264ExtensionKey = "h264extension";
    var renderGardenDoneAlertKey = "doneAlert";
    var renderGardenDoneAlertCommandKey = "doneAlertCommand";
    var renderGardenCheckFilesKey = "checkFiles";
    var renderGardenCountFramesKey = "countFrames";
    var renderGardenCheckSuccessKey = "checkSuccess";
    var renderGardenCheckErrorKey = "checkError";
    var defaultRenderCommand = "\"{aerender}\" -project \"{project}\" -rqindex {rqindex} -output \"{output}\" -s {start} -e {end} -v ERRORS_AND_PROGRESS";
    var defaultCombineCommand = "\"{ffmpeg}\" -loglevel verbose -y -f concat -i \"{input}\" -c copy -movflags +write_colr \"{output}\"";
    var defaultQuickTimeCommand = "\"{ffmpeg}\" -loglevel verbose -y {start} {framerate} -i \"{input}\" {codec} \"{output}\"";
    var defaultH264Command = "\"{ffmpeg}\" -loglevel verbose -y {start} {framerate} -i \"{input}\" {resize} -c:v libx264 -pix_fmt yuv420p -crf 10 \"{output}\"";
    var defaultQuickTimeExtension = "mov";
    var defaultH264Extension = "mp4";
    var quickTimeCodecs = {
        Animation: "-c:v qtrle",
        DNxHD: "-c:v dnxhd {dnxhd}",
        HAP: "-c:v hap -format hap",
        "HAP Alpha": "-c:v hap -format hap_alpha",
        "HAP Q": "-c:v hap -format hap_q",
        "Photo - JPEG": "-c:v mjpeg -q 3",
        "ProRes 422": "-c:v prores_ks -profile:v standard",
        "ProRes 422 (HQ)": "-c:v prores_ks -profile:v hq",
        "ProRes 422 (LT)": "-c:v prores_ks -profile:v lt",
        "ProRes 422 (Proxy)": "-c:v prores_ks -profile:v proxy",
        "ProRes 4444": "-c:v prores_ks -profile:v 4444",
        "ProRes 4444 XQ": "-c:v prores_ks -profile:v 4444xq"
    };
    var defaultQuickTimeCodec = "ProRes 422";
    var dnxhdFormats = {
        "720p DNxHD HQX 10-bit": {
            profile: null,
            resolution: "1280x720",
            pixelFormat: "yuv422p10",
            bitsAndRates: {
                "23.976": 90,
                "25": 90,
                "50": 180,
                "59.94": 220
            }
        },
        "720p DNxHD HQ 8-bit": {
            profile: null,
            resolution: "1280x720",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 90,
                "25": 90,
                "29.97": 110,
                "50": 180,
                "59.94": 220
            }
        },
        "720p DNxHD SQ 8-bit": {
            profile: null,
            resolution: "960x720",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 42,
                "25": 60,
                "29.97": 75,
                "50": 120,
                "59.94": 145
            }
        },
        "720p DNxHD SQ Thin Raster 8-bit": {
            profile: null,
            resolution: "1440x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 42,
                "25": 60,
                "50": 75,
                "59.94": 115
            }
        },
        "1080i DNxHD HQX 10-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p10",
            bitsAndRates: {
                "25": 185,
                "29.97": 220
            }
        },
        "1080i DNxHD HQ 8-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "25": 185,
                "29.97": 220
            }
        },
        "1080i DNxHD HQ Thin Raster 8-bit": {
            profile: null,
            resolution: "1440x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 80,
                "25": 90,
                "50": 100,
                "59.94": 110
            }
        },
        "1080i DNxHD SQ 8-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "25": 120,
                "29.97": 145
            }
        },
        "1080i DNxHD SQ Thin Raster 8-bit": {
            profile: null,
            resolution: "1440x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "25": 120,
                "29.97": 145
            }
        },
        "1080p DNxHD HQX 10-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p10",
            bitsAndRates: {
                "23.976": 350,
                "25": 390,
                "29.97": 440,
                "50": 730,
                "59.94": 880
            }
        },
        "1080p DNxHD HQ 10-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p10",
            bitsAndRates: {
                "23.976": 175,
                "25": 185,
                "50": 365,
                "59.94": 440
            }
        },
        "1080p DNxHD HQ 8-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 175,
                "25": 185,
                "29.97": 220,
                "50": 365,
                "59.94": 440
            }
        },
        "1080p DNxHD SQ 8-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 115,
                "25": 120,
                "29.97": 145,
                "50": 240,
                "59.94": 290
            }
        },
        "1080p DNxHD SQ Thin Raster 8-bit": {
            profile: null,
            resolution: "1440x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 63,
                "25": 84,
                "50": 100,
                "59.94": 110
            }
        },
        "1080p DNxHD LB 8-bit": {
            profile: null,
            resolution: "1920x1080",
            pixelFormat: "yuv422p",
            bitsAndRates: {
                "23.976": 36,
                "25": 36,
                "29.97": 45,
                "50": 75,
                "59.94": 90
            }
        },
        "DNxHR RGB 444 10-bit": {
            profile: "dnxhr_444",
            resolution: null,
            pixelFormat: "gbrap10be",
            bitsAndRates: null
        },
        "DNxHR HQX 10-bit": {
            profile: "dnxhr_hqx",
            resolution: null,
            pixelFormat: "yuv422p10",
            bitsAndRates: null
        },
        "DNxHR HQ 8-bit": {
            profile: "dnxhr_hq",
            resolution: null,
            pixelFormat: "yuv422p",
            bitsAndRates: null
        },
        "DNxHR SQ 8-bit": {
            profile: "dnxhr_sq",
            resolution: null,
            pixelFormat: "yuv422p",
            bitsAndRates: null
        },
        "DNxHR LB 8-bit": {
            profile: "dnxhr_lb",
            resolution: null,
            pixelFormat: "yuv422p",
            bitsAndRates: null
        }
    };
    var defaultDnxhdFormat = "DNxHR HQX 10-bit";
    var macDefaultAlertCommand = "osascript -e \"display dialog \\\"RenderGarden complete: {job}\\n\\nTime to complete: {renderDuration}\\\" buttons {\\\"OK\\\"} with icon (POSIX file \\\"{RenderGarden}/RenderGarden Gardener.app/Contents/Resources/appIcon.icns\\\") with title \\\"RenderGarden\\\"\" &";
    var winDefaultAlertCommand = "msg * /self /TIME:0 \"RenderGarden complete: {job} ({renderDuration})\"";
    var defaultAlertCommand = (File.fs == "Macintosh" ? macDefaultAlertCommand : winDefaultAlertCommand);
    var renderGardenPrefs = {};

    function loadPrefs() {
        var prefsFile = (File.fs == "Macintosh" ? new File("~/Library/Preferences/com.mekajiki.RenderGarden.settings") : Folder.userData.file("com.mekajiki.RenderGarden.settings"));
        if (prefsFile.exists) {
            var opened = prefsFile.open("r");
            if (opened) {
                prefsFile.encoding = "UTF-8";
                var contents = prefsFile.read();
                try {
                    renderGardenPrefs = JSON.parse(contents);
                } catch (e) {
                    var savePrefs = confirm("RenderGarden preferences corrupted\nSave your old preferences file?", false, "RenderGarden");
                    if (savePrefs) {
                        var backupPrefsFile = File.saveDialog("Save old Preferences to where?");
                        if (backupPrefsFile != null) {
                            var backupOpened = backupPrefsFile.open("w");
                            if (backupOpened) {
                                var wrote = backupPrefsFile.write(contents);
                                if (!wrote) {
                                    alert("Error writing Preferences backup")
                                }
                                backupPrefsFile.close();
                            }
                        }
                    }
                } finally {
                    prefsFile.close();
                }
            } else {
                debugger
            }
        }
    }

    function savePrefs() {
        var prefsFile = (File.fs == "Macintosh" ? new File("~/Library/Preferences/com.mekajiki.RenderGarden.settings") : Folder.userData.file("com.mekajiki.RenderGarden.settings"));
        var opened = prefsFile.open("w");
        if (opened) {
            prefsFile.encoding = "UTF-8";
            var contents = JSON.stringify(renderGardenPrefs);
            var wrote = prefsFile.write(contents);
            if (!wrote) {
                debugger
            }
            prefsFile.close();
        } else {
            debugger
        }
    }

    function storedInAEPrefs(key) {
        return key == renderGardenAERenderKey || key == renderGardenAECommandKey;
    }

    function haveSetting(key) {
        if (storedInAEPrefs(key)) {
            return app.settings.haveSetting(renderGardenKey, key);
        } else {
            return key in renderGardenPrefs;
        }
    }

    function saveSetting(key, value) {
        if (storedInAEPrefs(key)) {
            app.settings.saveSetting(renderGardenKey, key, value);
        } else {
            renderGardenPrefs[key] = value;
            savePrefs();
        }
    }

    function getInt(val) {
        if (typeof val === "number" || val instanceof Number) {
            return Math.round(val);
        }
        val = parseInt(val, 10);
        if (isNaN(val)) {
            return 0;
        } else {
            return val;
        }
    }

    function getBool(val) {
        if (typeof val === "boolean") {
            return val;
        }
        if (val instanceof Boolean) {
            return val.valueOf();
        }
        if (typeof val === "string" || val instanceof String) {
            return val != "false";
        }
        return !(!val);
    }

    function getString(val) {
        if (typeof val === "string") {
            return val;
        }
        if (val instanceof String) {
            return val.valueOf();
        }
        if (val == null || val == undefined) {
            return "";
        }
        return val.toString();
    }

    function loadSetting(key, defaultValue) {
        if (!haveSetting(key)) {
            saveSetting(key, defaultValue)
        }
        var val = (storedInAEPrefs(key) ? app.settings.getSetting(renderGardenKey, key) : renderGardenPrefs[key]);
        if (key == renderGardenNumberOfSeedsKey || key == renderGardenPriorityKey) {
            return getInt(val);
        } else if (key == renderGardenRunBeforeKey || key == renderGardenUsePriorityKey || key == renderGardenPostRenderActionsKey || key == renderGardenIncrementAndSaveKey || key == renderGardenRelativeKey || key == renderGardenGardenerKey || key == renderGardenShortSeedsKey || key == renderGardenCheckSuccessKey || key == renderGardenCheckErrorKey || key == renderGardenCheckFilesKey || key == renderGardenCountFramesKey || key == renderGardenQuickTimeKey || key == renderGardenH264Key || key == renderGardenDoneAlertKey) {
            return getBool(val);
        } else {
            return getString(val);
        }
    }

    function paddedNumber(num) {
        var numLength = 2;
        var result = num.toString();
        for (var n = 1; n < numLength; n += 1) {
            var threshold = Math.pow(10, n);
            if (num < threshold) {
                result = "0" + result
            }
        }
        return result;
    }

    function deleteFolderContents(aFolder) {
        if (!(aFolder instanceof Folder)) {
            debugger
        }
        if (aFolder.alias) {
            debugger
        }
        var folderContents = aFolder.getFiles();
        if (folderContents == null || !(folderContents instanceof Array)) {
            debugger
        }
        for (var i = 0; i < folderContents.length; i += 1) {
            var folderItem = folderContents[i];
            if (folderItem instanceof Folder) {
                if (!folderItem.alias) {
                    deleteFolderContents(folderItem)
                }
                var removed = folderItem.remove();
                if (!removed) {
                    debugger
                }
            } else if (folderItem instanceof File) {
                var removed = folderItem.remove();
                if (!removed) {
                    debugger
                }
            } else {
                debugger
            }
        }
    }

    function aerenderDefault() {
        var versionString = app.version;
        var versionMajorString = versionString.substr(0, versionString.indexOf("."));
        var majorVersion = parseInt(versionMajorString);
        if (File.fs == "Macintosh") {
            var aerenderFile = Folder.startup.parent.parent.parent.file("aerender");
            if (aerenderFile.exists) {
                return aerenderFile.fsName;
            }
            if (majorVersion == 15) {
                return "/Applications/Adobe After Effects CC 2018/aerender";
            } else if (majorVersion == 14) {
                return "/Applications/Adobe After Effects CC 2017/aerender";
            } else if (majorVersion == 13) {
                if (versionString.substr(0, 4) == "13.0" || versionString.substr(0, 4) == "13.1" || versionString.substr(0, 4) == "13.2") {
                    return "/Applications/Adobe After Effects 2014/aerender";
                } else {
                    return "/Applications/Adobe After Effects 2015/aerender";
                }
            } else if (majorVersion == 12) {
                return "/Applications/Adobe After Effects CC/aerender";
            } else if (majorVersion == 11) {
                return "/Applications/Adobe After Effects CS6/aerender";
            } else {
                return "";
            }
        } else {
            var aerenderFile = Folder.startup.file("aerender.exe");
            if (aerenderFile.exists) {
                return aerenderFile.fsName;
            }
            if (majorVersion == 15) {
                return "C:\\Program Files\\Adobe\\Adobe After Effects CC 2018\\Support Files\\aerender.exe";
            } else if (majorVersion == 14) {
                return "C:\\Program Files\\Adobe\\Adobe After Effects CC 2017\\Support Files\\aerender.exe";
            } else if (majorVersion == 13) {
                if (versionString.substr(0, 4) == "13.0" || versionString.substr(0, 4) == "13.1" || versionString.substr(0, 4) == "13.2") {
                    return "C:\\Program Files\\Adobe\\Adobe After Effects CC 2014\\Support Files\\aerender.exe";
                } else {
                    return "C:\\Program Files\\Adobe\\Adobe After Effects CC 2015\\Support Files\\aerender.exe";
                }
            } else if (majorVersion == 12) {
                return "C:\\Program Files\\Adobe\\Adobe After Effects CC\\Support Files\\aerender.exe";
            } else if (majorVersion == 11) {
                return "C:\\Program Files\\Adobe\\Adobe After Effects CS6\\Support Files\\aerender.exe";
            } else {
                return "";
            }
        }
    }

    function relativePathFunc(destinationPath, originPath) {
        var destinationArray = destinationPath.split(Folder.pathSep);
        var originArray = originPath.split(Folder.pathSep);
        if (destinationArray[0] != originArray[0]) {
            return destinationPath;
        }
        while (destinationArray.length > 0 && originArray.length > 0 && destinationArray[0] == originArray[0]) {
            destinationArray.shift();
            originArray.shift();
        }
        if (originArray.length > 0) {
            while (originArray.length > 0) {
                destinationArray.unshift("..");
                originArray.shift();
            }
        } else {
            destinationArray.unshift(".")
        }
        return "{pwd}" + destinationArray.join(Folder.pathSep);
    }

    function relativePath(destination, origin) {
        if (typeof destination !== "string") {
            destination = destination.fsName
        }
        if (typeof origin !== "string") {
            origin = origin.fsName
        }
        var relPaths = loadSetting(renderGardenRelativeKey, true);
        if (relPaths) {
            return relativePathFunc(destination, origin);
        } else {
            return destination;
        }
    }

    function indexInArray(array, obj) {
        if (!(array instanceof Array)) {
            throw "Expected an array"
        }
        var rval = obj;
        if (rval instanceof File || rval instanceof Folder) {
            rval = rval.fsName
        }
        for (var i = 0; i < array.length; i += 1) {
            var lval = array[i];
            if (lval instanceof File || lval instanceof Folder) {
                lval = lval.fsName
            }
            if (lval == rval) {
                return i;
            }
        }
        return -1;
    }

    function makeSuperSafeName(name) {
        if (typeof name !== "string" && !(name instanceof String)) {
            debugger
        }
        var combiningDiacriticalMarks = /[\u0300-\u036f]/g;
        return name.replace(/ /g, "_").replace(combiningDiacriticalMarks, "").replace(/[^\x00-\x7F]/g, "U").replace(/[^0-9A-Za-z_\-\[\]\.]/g, "");
    }

    function makeSafeName(name) {
        if (typeof name !== "string" && !(name instanceof String)) {
            debugger
        }
        if (File.fs == "Macintosh") {
            return makeSuperSafeName(name);
        } else {
            return makeSuperSafeName(name);
        }
    }

    function setSeedBank(path) {
        if (typeof path !== "string" && !(path instanceof String)) {
            debugger
        }
        saveSetting(renderGardenSeedBankKey, path);
        var hasBadChars = false;
        if (File.fs == "Macintosh") {
            var badChars = /[\u00a0-\u00ff\u0131\u0152\u0153\u0178\u0192\u02c6\u02c7\u02d8-\u02dd\u03a9\u03c0\u2013\u2014]/g;
            hasBadChars = path.search(/[!@#$%\^&*\(\)\[\]{}?\\|'";:,<>=]/) > -1 || path.search(badChars) > -1;
        } else {
            hasBadChars = path.search(/[^0-9A-Za-z_+-\\ ]/) > -1;
        }
        if (hasBadChars) {
            alert("Warning: Unsafe characters detected in Seed Bank path.\nRenderGarden may behave erratically.", "RenderGarden")
        }
    }

    function makeApplet(command, appletName, appletFolder) {
        var relPaths = loadSetting(renderGardenRelativeKey, true);
        if (File.fs == "Macintosh") {
            var seedCommandFile = appletFolder.file(appletName + ".txt");
            var opened = seedCommandFile.open("w");
            if (opened) {
                seedCommandFile.encoding = "UTF-8";
                if (relPaths) {
                    seedCommandFile.writeln("on getParentFolder for anAlias");
                    seedCommandFile.writeln("\t set AppleScript's text item delimiters to \":\"");
                    seedCommandFile.writeln("\t set pathItems to every text item of (anAlias as string)");
                    seedCommandFile.writeln("\t if item (count of pathItems) of pathItems is \"\" then");
                    seedCommandFile.writeln("\t\t set pathItems to items 1 through ((count of pathItems) - 1) of pathItems");
                    seedCommandFile.writeln("\t end if");
                    seedCommandFile.writeln("\t set parentPathItems to items 1 through ((count of pathItems) - 1) of pathItems");
                    seedCommandFile.writeln("\t set theResult to alias (parentPathItems as string)");
                    seedCommandFile.writeln("\t set AppleScript's text item delimiters to \"\"");
                    seedCommandFile.writeln("\t return theResult");
                    seedCommandFile.writeln("end getParentFolder");
                    seedCommandFile.writeln("");
                    seedCommandFile.writeln("on replaceText for inputText from searchText to replaceText");
                    seedCommandFile.writeln("\t set AppleScript's text item delimiters to searchText");
                    seedCommandFile.writeln("\t set itemList to every text item of inputText");
                    seedCommandFile.writeln("\t set AppleScript's text item delimiters to replaceText");
                    seedCommandFile.writeln("\t set outputText to itemList as string");
                    seedCommandFile.writeln("\t set AppleScript's text item delimiters to \"\"");
                    seedCommandFile.writeln("\t return outputText");
                    seedCommandFile.writeln("end replaceText");
                    seedCommandFile.writeln("");
                    seedCommandFile.writeln("set theCommand to \"" + command.replace(/\"/g, "\\\"") + "\"");
                    seedCommandFile.writeln("");
                    seedCommandFile.writeln("set currentPath to POSIX path of (getParentFolder for path to me)");
                    seedCommandFile.writeln("");
                    seedCommandFile.writeln("set theCommand to (replaceText for theCommand from \"{pwd}\" to currentPath)");
                    seedCommandFile.writeln("");
                    seedCommandFile.writeln("tell application \"Terminal\"");
                    seedCommandFile.writeln("\t activate");
                    seedCommandFile.writeln("\t set theTab to do script theCommand");
                    seedCommandFile.writeln("\t set custom title of theTab to \"" + appletName + "\"");
                    seedCommandFile.writeln("\t try");
                    seedCommandFile.writeln("\t\t set current settings of theTab to settings set \"Grass\"");
                    seedCommandFile.writeln("\t end try");
                    seedCommandFile.writeln("end tell");
                } else {
                    seedCommandFile.writeln("tell application \"Terminal\"");
                    seedCommandFile.writeln("\t activate");
                    seedCommandFile.writeln("\t set theTab to do script \"" + command.replace(/\"/g, "\\\"") + "\"");
                    seedCommandFile.writeln("\t set custom title of theTab to \"" + File(path).dispName() + "\"");
                    seedCommandFile.writeln("\t try");
                    seedCommandFile.writeln("\t\t set current settings of theTab to settings set \"Grass\"");
                    seedCommandFile.writeln("\t end try");
                    seedCommandFile.writeln("end tell");
                }
                var closed = seedCommandFile.close();
                if (!closed) {
                    debugger
                }
                var applet = appletFolder.folder(appletName + ".app");
                var compileCommand = "osacompile -o \"" + applet.fsName + "\" \"" + seedCommandFile.fsName + "\"";
                var cmdResult = system.callSystem(compileCommand);
                if (!applet.exists) {
                    debugger
                }
                var removed = seedCommandFile.remove();
                if (!removed) {
                    debugger
                }
                return applet;
            } else {
                debugger
            }
        } else {
            var batchFile = appletFolder.file(appletName + ".bat");
            var opened = batchFile.open("w");
            if (opened) {
                batchFile.encoding = "UTF-8";
                var cmdString = command.replace(/%/g, "%%").replace(/{pwd}/g, "%~d0%~p0");
                var wrote = batchFile.writeln(cmdString);
                if (!wrote) {
                    debugger
                }
                var closed = batchFile.close();
                if (!closed) {
                    debugger
                }
                return batchFile;
            } else {
                debugger
            }
        }
    }

    function trimString(str) {
        if (typeof str === "string" || str instanceof String) {
            var whitespace = " \t\r\n\b\f\v";
            var startIndex = 0;
            while (startIndex < str.length && whitespace.search(str[startIndex]) >= 0) {
                startIndex++
            }
            if (startIndex >= str.length) {
                return "";
            }
            var endIndex = str.length - 1;
            while (endIndex > startIndex && whitespace.search(str[endIndex]) >= 0) {
                endIndex--
            }
            return str.substring(startIndex, endIndex + 1);
        } else {
            return str;
        }
    }
    if (typeof renderGarden_hostname !== "string") {
        var fullHostName = system.callSystem("hostname");
        renderGarden_hostname = trimString(fullHostName).split(".")[0];
    }

    function makeGardenerSeed(command, seedType, successString, failString, successFiles, frames, dependsArray, thisComputerOnly, seedName, seedFolder) {
        var gardenerFile = seedFolder.file("ready_" + seedName + ".renderGarden");
        var opened = gardenerFile.open("w");
        if (opened) {
            gardenerFile.encoding = "UTF-8";
            var jsonObj = {
                name: seedName,
                type: seedType,
                cmds: [{
                    cmd: command
                }]
            };
            if (typeof successString == "string" || successString instanceof String && successString.length > 0) {
                jsonObj.cmds[0].success = successString
            }
            if (typeof failString == "string" || failString instanceof String && failString.length > 0) {
                jsonObj.cmds[0].fail = failString
            }
            if (successFiles instanceof Array && successFiles.length > 0) {
                var outputPaths = [];
                for (var i = 0; i < successFiles.length; i += 1) {
                    outputPaths.push(relativePath(successFiles[i], seedFolder))
                }
                jsonObj.cmds[0].output = outputPaths;
            }
            if (frames != 0) {
                jsonObj.cmds[0].frames = frames
            }
            if (dependsArray instanceof Array && dependsArray.length > 0) {
                jsonObj.depends = dependsArray
            }
            if (thisComputerOnly) {
                jsonObj.groups = [renderGarden_hostname]
            }
            if (seedType == "ffmpeg" || seedType == "combine") {
                jsonObj.cmds[0].printerr = true
            }
            var currentDate = new Date();
            jsonObj.submitted = currentDate.toString();
            jsonObj.comment = "This file created by RenderGarden for After Effects";
            jsonObj.version = versionNumber;
            var jsonString = JSON.stringify(jsonObj);
            var wrote = gardenerFile.write(jsonString);
            if (!wrote) {
                throw "Failed to write seed"
            }
            var closed = gardenerFile.close();
            if (!closed) {
                debugger
            }
        } else {
            throw "Failed to create gardenerFile"
        }
    }

    function defaultPythonCommand() {
        if (File.fs == "Windows") {
            return "C:\\Python27\\python.exe";
        } else {
            return "python";
        }
    }

    function isFilePath(path) {
        if (typeof path === "string" && path.search(" ") == -1) {
            for (var i = 0; i < path.length; i += 1) {
                if (path[i] == Folder.pathSep) {
                    return true;
                }
            }
            return false;
        } else {
            return false;
        }
    }

    function pythonPresent() {
        if (typeof renderGarden_PythonPresent !== "boolean" || !renderGarden_PythonPresent) {
            var pythonCommand = loadSetting(renderGardenPythonKey, defaultPythonCommand());
            if (isFilePath(pythonCommand) && !File(pythonCommand).exists) {
                renderGarden_PythonPresent = false;
                return renderGarden_PythonPresent;
            }
            if (File.fs == "Windows") {
                var pythonResult = system.callSystem("cmd.exe /c " + pythonCommand + " --version");
                renderGarden_PythonPresent = pythonResult.search(/not recognized/i) == -1 && pythonResult.search(/cannot find/i) == -1;
            } else {
                var pythonResult = system.callSystem(pythonCommand + " --version");
                renderGarden_PythonPresent = pythonResult.search(/not found/i) == -1;
            }
        }
        return renderGarden_PythonPresent;
    }

    function wmicPresent() {
        if (typeof renderGarden_wmicPresent !== "boolean") {
            if (File.fs == "Windows") {
                var wmicLocation = trimString(system.callSystem("where wmic"));
                renderGarden_wmicPresent = wmicLocation.search(File.pathSep) != -1 && wmicLocation.search(" ") == -1 && File(wmicLocation).exists;
            } else {
                renderGarden_wmicPresent = false
            }
        }
        return renderGarden_wmicPresent;
    }

    function gardenersRunning() {
        if (File.fs == "Windows" && !wmicPresent()) {
            return -1;
        }
        var processesString = (File.fs == "Windows" ? system.callSystem("wmic process get Commandline") : system.callSystem("ps"));
        var gardenerMatches = processesString.match(/Gardener\.py/g);
        return (gardenerMatches instanceof Array ? gardenerMatches.length : 0);
    }
    if (typeof renderGarden_lastRevealValue !== "boolean") {
        renderGarden_lastRevealValue = true
    }

    function postOpDialog(renderJobsApplets) {
        var dialog = new Window("dialog", "RenderGarden", [0, 0, 350, 200]);
        dialog.add("statictext", [50, 10, 300, 30], "Seeds created for " + renderJobsApplets.length.toString() + " item(s).");
        var useGardener = loadSetting(renderGardenGardenerKey, true);
        if (useGardener) {
            if (!pythonPresent()) {
                alert("Python not installed. Unable to run Gardener script.", "RenderGarden");
                useGardener = false;
            } else {
                var pythonCommand = loadSetting(renderGardenPythonKey, defaultPythonCommand());
                var pythonResult = system.callSystem(pythonCommand + " --version");
                if (pythonResult.search(/2\.6/) == -1 && pythonResult.search(/2\.7/) == -1) {
                    alert("RenderGarden requires Python 2.7. Installed version is " + pythonResult, "RenderGarden");
                    useGardener = false;
                }
            }
        }
        var runningGardeners = gardenersRunning();
        var maxJobs = 16;
        var defaultJobs = 2 - (useGardener ? runningGardeners : 0);
        if (defaultJobs < 0) {
            defaultJobs = 0
        }
        var gardenerScriptFile = null;
        if (useGardener) {
            var thisScriptPath = $.fileName;
            var thisScript = File(thisScriptPath);
            var gardenerScriptFiles = thisScript.parent.getFiles("Gardener.py");
            if (gardenerScriptFiles instanceof Array && gardenerScriptFiles.length > 0) {
                gardenerScriptFile = gardenerScriptFiles[0];
            } else {
                var gardenerAppFolders = thisScript.parent.getFiles("RenderGarden Gardener.app");
                if (gardenerAppFolders instanceof Array && gardenerAppFolders.length > 0) {
                    var gardenerAppFolder = gardenerAppFolders[0];
                    var gardenerAppScriptFile = gardenerAppFolder.folder("Contents").folder("Resources").file("Gardener.py");
                    if (gardenerAppScriptFile.exists) {
                        gardenerScriptFile = gardenerAppScriptFile
                    }
                }
            }
        } else {
            var totalSeeds = renderJobsApplets.length * renderJobsApplets[0].length;
            if (maxJobs > totalSeeds) {
                maxJobs = totalSeeds
            }
            if (defaultJobs > maxJobs) {
                defaultJobs = maxJobs
            }
        }
        var actionText = (useGardener ? ((gardenerScriptFile != null ? "How many more Gardener processes to launch?\nYou are currently running " + runningGardeners + "." : "Unable to locate Gardener script.")) : "How many aerender processes to launch?");
        dialog.add("statictext", [50, 35, 350, 70], actionText, {
            multiline: true
        });
        var menu = null;
        if (!useGardener || gardenerScriptFile != null) {
            menu = dialog.add("dropdownlist", [50, 70, 150, 90]);
            if (useGardener) {
                menu.add("item", "Notify only");
                menu.add("separator");
            }
            for (var i = 0; i <= maxJobs; i += 1) {
                var newItem = menu.add("item", i.toString());
                if (i == defaultJobs) {
                    menu.selection = newItem
                }
            }
        } else {
            if (useGardener && gardenerScriptFile == null) {
                dialog.add("statictext", [50, 70, 300, 90], "Unable to locate Gardener.py.");
            }
        }
        var multipleCompsCheck = null;
        if (!useGardener) {
            multipleCompsCheck = dialog.add("checkbox", [50, 100, 275, 120], "Render multiple comps");
            multipleCompsCheck.value = renderJobsApplets.length > 1;
            multipleCompsCheck.enabled = renderJobsApplets.length > 1;
        }
        var revealString = "Reveal Seed Bank in " + (File.fs == "Windows" ? "Explorer" : "Finder");
        var revealCheck = dialog.add("checkbox", [50, 120, 275, 140], revealString);
        revealCheck.value = renderGarden_lastRevealValue;
        var closeButton = dialog.add("button", [115, 150, 215, 170], "Close");
        closeButton.onClick = function () {
            dialog.close();
        };
        dialog.defaultElement = dialog.add("button", [225, 150, 325, 170], "OK");
        dialog.defaultElement.onClick = function () {
            if (!useGardener || gardenerScriptFile != null) {
                var numberOfProcesses = (menu.selection.text == "Notify only" ? 1 : parseInt(menu.selection.text));
                if (numberOfProcesses < 0) {
                    numberOfProcesses = 0
                } else {
                    if (numberOfProcesses > maxJobs) {
                        numberOfProcesses = maxJobs
                    }
                }
                if (useGardener) {
                    var gardenerFolderPath = loadSetting(renderGardenSeedBankKey, "");
                    if (Folder(gardenerFolderPath).exists) {
                        var pythonCommand = loadSetting(renderGardenPythonKey, defaultPythonCommand());
                        var notifyArg = (menu.selection.text == "Notify only" ? " --type notify" : "");
                        var terminalCommand = pythonCommand + " \"" + gardenerScriptFile.fsName + "\"" + notifyArg + " \"" + gardenerFolderPath + "\"";
                        if (File.fs == "Macintosh") {
                            var theme = (menu.selection.text == "Notify only" ? "Novel" : "Grass");
                            var command = "osascript <<EOF\ntell application \"Terminal\"\nactivate\nset theTab to do script \"" + terminalCommand.replace(/\"/g, "\\\"") + "\"" + "\n" + "set custom title of theTab to \"Gardener\"" + "\n" + "try" + "\n" + "set current settings of theTab to settings set \"" + theme + "\"" + "\n" + "end try" + "\n" + "end tell" + "\n" + "EOF" + "\n";
                            for (var i = 0; i < numberOfProcesses; i += 1) {
                                system.callSystem(command);
                            }
                        } else {
                            var gardenerBatchFile = Folder(gardenerFolderPath).file("launchGardener.bat");
                            var opened = gardenerBatchFile.open("w");
                            if (opened) {
                                gardenerBatchFile.encoding = "UTF-8";
                                var wrote = gardenerBatchFile.writeln(terminalCommand);
                                if (!wrote) {
                                    debugger
                                }
                                gardenerBatchFile.close();
                                for (var i = 0; i < numberOfProcesses; i += 1) {
                                    gardenerBatchFile.execute();
                                }
                            } else {
                                throw "Error launching Gardeners"
                            }
                        }
                    } else {
                        alert("Error launching Gardeners\nSeed bank folder does not exist.", "RenderGarden", true)
                    }
                } else {
                    var multipleComps = multipleCompsCheck.value;
                    var numberOfComps = (multipleComps ? renderJobsApplets.length : 1);
                    var seedsPerComp = renderJobsApplets[0].length;
                    var totalSeeds = numberOfComps * seedsPerComp;
                    if (numberOfProcesses > totalSeeds) {
                        numberOfProcesses = totalSeeds
                    }
                    var jobArray = [];
                    for (var i = 0; i < numberOfProcesses; i += 1) {
                        var compNum = i % numberOfComps;
                        var seedNum = Math.floor(i / numberOfComps);
                        jobArray.push(renderJobsApplets[compNum][seedNum]);
                    }
                    for (var i = 0; i < jobArray.length; i += 1) {
                        (jobArray[i]).execute()
                    }
                }
            }
            if (revealCheck.value) {
                if (File.fs == "Macintosh") {
                    system.callSystem("open \"" + loadSetting(renderGardenSeedBankKey, "") + "\"")
                } else {
                    system.callSystem("explorer \"" + loadSetting(renderGardenSeedBankKey, "") + "\"")
                }
            }
            renderGarden_lastRevealValue = revealCheck.value;
            dialog.close();
        };
        dialog.center();
        dialog.show();
    }

    function launchMoreGardeners() {
        var gardenerScriptFile = null;
        var thisScriptPath = $.fileName;
        var thisScript = File(thisScriptPath);
        var gardenerScriptFiles = thisScript.parent.getFiles("Gardener.py");
        if (gardenerScriptFiles instanceof Array && gardenerScriptFiles.length > 0) {
            gardenerScriptFile = gardenerScriptFiles[0];
        } else {
            var gardenerAppFolders = thisScript.parent.getFiles("RenderGarden Gardener.app");
            if (gardenerAppFolders instanceof Array && gardenerAppFolders.length > 0) {
                var gardenerAppFolder = gardenerAppFolders[0];
                var gardenerAppScriptFile = gardenerAppFolder.folder("Contents").folder("Resources").file("Gardener.py");
                if (gardenerAppScriptFile.exists) {
                    gardenerScriptFile = gardenerAppScriptFile
                }
            }
        }
        if (gardenerScriptFile instanceof File && gardenerScriptFile.exists) {
            var seedBankFolder = new Folder(loadSetting(renderGardenSeedBankKey, ""));
            if (!seedBankFolder.exists) {
                seedBankFolder = Folder.selectDialog("Choose your seed bank");
                if (seedBankFolder != null && seedBankFolder.exists) {
                    setSeedBank(seedBankFolder.fsName)
                }
            }
            if (seedBankFolder != null && seedBankFolder.exists) {
                var dialog = new Window("dialog", "RenderGarden", [0, 0, 350, 140]);
                var questionTest = "How many additional Gardeners to launch?\nYou are currently running " + gardenersRunning() + ".";
                dialog.add("statictext", [50, 10, 300, 50], questionTest, {
                    multiline: true
                });
                var maxJobs = 16;
                var defaultJobs = 2;
                var menu = dialog.add("dropdownlist", [120, 50, 220, 70]);
                menu.add("item", "Notify only");
                menu.add("separator");
                for (var i = 0; i <= maxJobs; i += 1) {
                    var newItem = menu.add("item", i.toString());
                    if (i == defaultJobs) {
                        menu.selection = newItem
                    }
                }
                var cancelButton = dialog.add("button", [115, 100, 215, 120], "Cancel");
                cancelButton.onClick = function () {
                    dialog.close();
                };
                dialog.defaultElement = dialog.add("button", [225, 100, 325, 120], "OK");
                dialog.defaultElement.onClick = function () {
                    var numberOfProcesses = (menu.selection.text == "Notify only" ? 1 : parseInt(menu.selection.text));
                    if (numberOfProcesses < 0) {
                        numberOfProcesses = 0
                    } else {
                        if (numberOfProcesses > maxJobs) {
                            numberOfProcesses = maxJobs
                        }
                    }
                    var pythonCommand = loadSetting(renderGardenPythonKey, defaultPythonCommand());
                    var notifyArg = (menu.selection.text == "Notify only" ? " --type notify" : "");
                    var terminalCommand = pythonCommand + " \"" + gardenerScriptFile.fsName + "\"" + notifyArg + " \"" + seedBankFolder.fsName + "\"";
                    if (File.fs == "Macintosh") {
                        var theme = (menu.selection.text == "Notify only" ? "Novel" : "Grass");
                        var command = "osascript <<EOF\ntell application \"Terminal\"\nactivate\nset theTab to do script \"" + terminalCommand.replace(/\"/g, "\\\"") + "\"" + "\n" + "set custom title of theTab to \"Gardener\"" + "\n" + "try" + "\n" + "set current settings of theTab to settings set \"" + theme + "\"" + "\n" + "end try" + "\n" + "end tell" + "\n" + "EOF" + "\n";
                        for (var i = 0; i < numberOfProcesses; i += 1) {
                            system.callSystem(command);
                        }
                    } else {
                        var gardenerBatchFile = seedBankFolder.file("launchGardener.bat");
                        var opened = gardenerBatchFile.open("w");
                        if (opened) {
                            gardenerBatchFile.encoding = "UTF-8";
                            var wrote = gardenerBatchFile.writeln(terminalCommand);
                            if (!wrote) {
                                debugger
                            }
                            gardenerBatchFile.close();
                            for (var i = 0; i < numberOfProcesses; i += 1) {
                                gardenerBatchFile.execute();
                            }
                        } else {
                            throw "Error launching Gardeners"
                        }
                    }
                    dialog.close();
                };
                dialog.center();
                dialog.show();
            }
        } else {
            var missingThing = (File.fs == "Macintosh" ? "RenderGarden Gardener app" : "Gardener.py script");
            alert("Couldn't find " + missingThing + ".\nCopy it to the same folder as RenderGarden.jsxbin", "RenderGarden", true);
        }
    }

    function makeStuff(showPostRenderDialog) {
        var numQueued = 0;
        var numSeeds = loadSetting(renderGardenNumberOfSeedsKey, 3);
        if (numSeeds < 1) {
            numSeeds = 1
        } else {
            if (numSeeds > 9999) {
                numSeeds = 9999
            }
        }
        var ffmpegPath = loadSetting(renderGardenFFmpegKey, "");
        var pathCheckArray = [];
        for (var i = 1; i <= app.project.renderQueue.numItems; i += 1) {
            var item = app.project.renderQueue.items[i];
            if (item.status == RQItemStatus.QUEUED) {
                numQueued++;
                var outputModule = item.outputModules[1];
                var frameSequence = outputModule.file.isFrameSequence();
                if (!frameSequence && numSeeds > 1) {
                    var ffmpegFile = new File(ffmpegPath);
                    if (!ffmpegFile.exists) {
                        alert("FFmpeg path required in Prefs Panel to join movie seeds", "RenderGarden", true);
                        return;
                    }
                }
                var outputPath = outputModule.file.fsName;
                for (var j = 0; j < pathCheckArray.length; j += 1) {
                    if (outputPath == pathCheckArray[j]) {
                        alert("Mutiple render queue items use output file " + outputPath, "RenderGarden", true);
                        return;
                    }
                }
                pathCheckArray.push(outputPath);
            }
        }
        if (numQueued == 0) {
            alert("No render queue items queued", "RenderGarden", true);
            return;
        } else {
            numQueued = 0
        }
        var aerenderPath = loadSetting(renderGardenAERenderKey, aerenderDefault());
        if (aerenderPath.length == 0) {
            alert("No aerender path specified", "RenderGarden", true);
            return;
        } else {
            var aerenderFile = new File(aerenderPath);
            if (!aerenderFile.exists) {
                alert("aerender path appears invalid\n" + aerenderPath, "RenderGarden")
            }
        }
        var seedBankFolder = new Folder(loadSetting(renderGardenSeedBankKey, ""));
        if (!seedBankFolder.exists) {
            seedBankFolder = Folder.selectDialog("Choose your seed bank");
            if (seedBankFolder != null && seedBankFolder.exists) {
                setSeedBank(seedBankFolder.fsName)
            }
        }
        if (seedBankFolder == null || !seedBankFolder.exists) {
            alert("Invalid seed bank", "Error", "RenderGarden", true);
            return;
        }
        var teamProject = typeof app.project.isAnyTeamProjectOpen === "function" && app.project.isAnyTeamProjectOpen();
        if (teamProject) {
            alert("RenderGarden doesn't handle team projects.\nAsk us about RenderGardenTeams.", "Error", "RenderGarden", true);
            return;
        }
        app.project.save();
        if (app.project.file == null) {
            alert("Project must be saved", "Error", "RenderGarden", true);
            return;
        }
        var projectFile = app.project.file;
        var copyProject = !loadSetting(renderGardenIncrementAndSaveKey, false);
        if (!copyProject) {
            var incrementedFile = projectFile.incrementedFile();
            app.project.save(incrementedFile);
        }
        var outputPathsAltered = false;
        var renderJobsApplets = [];
        try {
            for (var itemNum = 1; itemNum <= app.project.renderQueue.numItems; itemNum += 1) {
                var item = app.project.renderQueue.items[itemNum];
                if (item.status == RQItemStatus.QUEUED) {
                    write(item.comp.name);
                    var frameDuration = item.comp.frameDuration;
                    var projectStartFrame = app.project.displayStartFrame;
                    var frameStart = Math.round((item.comp.displayStartTime + item.timeSpanStart) / frameDuration) + projectStartFrame;
                    var frameEnd = Math.round((frameStart + (item.timeSpanDuration / frameDuration)) - 1);
                    var totalFrames = (frameEnd - frameStart) + 1;
                    if (numSeeds > totalFrames) {
                        numSeeds = totalFrames
                    }
                    if (item.outputModules.length > 1) {
                        alert(item.comp.name + "\n" + "not handling multiple output modules, only first one queued", "RenderGarden")
                    }
                    var outputModule = item.outputModules[1];
                    var outputFile = outputModule.file;
                    if (File.fs == "Windows" && outputFile.fsName.search(/[^\x00-\x7F]/) > -1) {
                        var newOutputFile = File(outputFile.fsName.replace(/[^\x00-\x7F]/g, "U"));
                        outputFile = newOutputFile;
                        outputPathsAltered = true;
                    }
                    if (!outputFile.parent.exists) {
                        var created = outputFile.parent.create();
                        if (!created) {
                            throw "Output folder does not exist: " + outputFile.parent.fsName
                        }
                    }
                    var fileExtension = outputFile.fileExtension();
                    if (fileExtension == null) {
                        fileExtension = "mov"
                    }
                    var frameSequence = outputFile.isFrameSequence();
                    var useGardener = loadSetting(renderGardenGardenerKey, true);
                    var usePriority = loadSetting(renderGardenUsePriorityKey, false);
                    var priority = loadSetting(renderGardenPriorityKey, 3);
                    var renderGardenFolder = seedBankFolder.folder((usePriority ? priority.toString() + "_" : "") + makeSafeName(projectFile.baseName()));
                    var compName = makeSafeName(item.comp.name);
                    var seedFolder = renderGardenFolder.folder(paddedNumber(itemNum) + "_" + compName);
                    if (seedFolder.exists) {
                        deleteFolderContents(seedFolder);
                    } else {
                        var created = seedFolder.create();
                        if (!created) {
                            throw "Failed to create " + seedFolder.fsName
                        }
                    }
                    var aliasFile = seedFolder.file("_output");
                    var created = aliasFile.createAlias(outputFile.parent.fsName);
                    if (!created) {
                        debugger
                    }
                    var renderProjectFile = (copyProject ? seedFolder.folder("_source").file(makeSafeName(projectFile.dispName())) : projectFile);
                    if (copyProject) {
                        var parentCreated = renderProjectFile.parent.create();
                        if (!parentCreated) {
                            debugger
                        }
                        var copied = projectFile.copy(renderProjectFile);
                        if (!copied) {
                            throw "Failed to copy project to " + renderProjectFile.fsName
                        }
                        var aliasProject = renderProjectFile.parent.file("_original.aep");
                        var created = aliasProject.createAlias(projectFile.fsName);
                        if (!created) {
                            debugger
                        }
                    }
                    var movieSegmentsFolder = seedFolder.folder("_segments");
                    var appletFolder = (useGardener ? seedFolder.folder("_scripts") : seedFolder);
                    var gardenerSeedsFolder = seedFolder;
                    var seedNameBase = makeSafeName(outputFile.baseName());
                    var appletArray = [];
                    var combineArray = [];
                    var renderSeedsArray = [];
                    for (var seedNum = 0; seedNum < numSeeds; seedNum += 1) {
                        var seedStart = frameStart + Math.round(seedNum * (totalFrames / numSeeds));
                        var seedEnd = (frameStart + Math.round((seedNum + 1) * (totalFrames / numSeeds))) - 1;
                        var seedOutputFile = outputFile;
                        var command = loadSetting(renderGardenAECommandKey, defaultRenderCommand);
                        var shortSeedNames = loadSetting(renderGardenShortSeedsKey, false);
                        var seedName = "seed" + paddedNumber(seedNum + 1) + (shortSeedNames ? "" : "_" + seedNameBase);
                        renderSeedsArray.push(seedName);
                        if (!frameSequence && numSeeds > 1) {
                            if (!movieSegmentsFolder.exists) {
                                var created = movieSegmentsFolder.create();
                                if (!created) {
                                    throw "Failed to create " + movieSegmentsFolder.fsName
                                }
                            }
                            seedOutputFile = movieSegmentsFolder.file(makeSuperSafeName(seedName) + "." + fileExtension);
                            combineArray.push(seedOutputFile);
                            if (command.search("{output}") == -1) {
                                command += " -output {output}"
                            }
                        }

                        function makeCommand(commandTemplate, relativeFolder) {
                            var cmd = commandTemplate;
                            cmd = cmd.replace(/{RenderGarden}/g, File($.fileName).parent.fsName);
                            cmd = cmd.replace(/{python}/g, loadSetting(renderGardenPythonKey, defaultPythonCommand()));
                            cmd = cmd.replace(/{aerender}/g, loadSetting(renderGardenAERenderKey, aerenderDefault()));
                            cmd = cmd.replace(/{project}/g, relativePath(renderProjectFile, relativeFolder));
                            cmd = cmd.replace(/{rqindex}/g, itemNum.toString());
                            cmd = cmd.replace(/{comp}/g, decodeURI(item.comp.name));
                            cmd = cmd.replace(/{output}/g, relativePath(seedOutputFile, relativeFolder));
                            cmd = cmd.replace(/{start}/g, seedStart.toString());
                            cmd = cmd.replace(/{end}/g, seedEnd.toString());
                            cmd = cmd.replace(/{imageMemory}/g, 30);
                            cmd = cmd.replace(/{totalMemory}/g, 30);
                            return cmd;
                        }
                        if (!appletFolder.exists) {
                            var created = appletFolder.create();
                            if (!created) {
                                throw "Failed to create " + appletFolder.fsName
                            }
                        }
                        var newApplet = makeApplet(makeCommand(command, appletFolder), seedName, appletFolder);
                        appletArray.push(newApplet);
                        if (useGardener) {
                            if (!gardenerSeedsFolder.exists) {
                                var created = gardenerSeedsFolder.create();
                                if (!created) {
                                    throw "Failed to create " + gardenerSeedsFolder.fsName
                                }
                            }
                            var checkFiles = loadSetting(renderGardenCheckFilesKey, true);
                            var countFrames = loadSetting(renderGardenCountFramesKey, false);
                            var checkSuccess = loadSetting(renderGardenCheckSuccessKey, false);
                            var checkError = loadSetting(renderGardenCheckErrorKey, false);
                            var successString = (checkSuccess ? "Finished composition" : null);
                            var failString = (checkError ? "error" : null);
                            var outputFiles = null;
                            if (checkFiles) {
                                outputFiles = [];
                                if (frameSequence) {
                                    for (var i = seedStart; i <= seedEnd; i++) {
                                        outputFiles.push(seedOutputFile.frameInSequence(i));
                                    }
                                } else {
                                    outputFiles.push(seedOutputFile)
                                }
                            }
                            var framesToCount = (countFrames ? (1 + seedEnd) - seedStart : 0);
                            makeGardenerSeed(makeCommand(command, gardenerSeedsFolder), "ae", successString, failString, outputFiles, framesToCount, null, false, seedName, gardenerSeedsFolder);
                        }
                    }
                    renderJobsApplets.push(appletArray);
                    var combineSeedName = "combine" + (shortSeedNames ? "" : "_" + seedNameBase);
                    if (combineArray.length > 0) {
                        var inputListFile = movieSegmentsFolder.file("files" + (shortSeedNames ? "" : "_" + makeSuperSafeName(seedNameBase)) + ".txt");
                        var inputListOpened = inputListFile.open("w");
                        if (inputListOpened) {
                            inputListFile.encoding = "UTF-8";
                            for (var i = 0; i < combineArray.length; i += 1) {
                                var seedFile = combineArray[i];
                                var wrote = inputListFile.writeln("file '" + seedFile.dispName() + "'");
                                if (!wrote) {
                                    debugger
                                }
                            }
                            inputListFile.close();
                        } else {
                            throw "Couldn't create inputList"
                        }
                        var combineTemplate = loadSetting(renderGardenCombineCommandKey, defaultCombineCommand);
                        var appletCombineCommand = combineTemplate;
                        appletCombineCommand = appletCombineCommand.replace(/{RenderGarden}/g, File($.fileName).parent.fsName);
                        appletCombineCommand = appletCombineCommand.replace(/{python}/g, loadSetting(renderGardenPythonKey, defaultPythonCommand()));
                        appletCombineCommand = appletCombineCommand.replace(/{ffmpeg}/g, ffmpegPath);
                        appletCombineCommand = appletCombineCommand.replace(/{input}/g, relativePath(inputListFile, appletFolder));
                        appletCombineCommand = appletCombineCommand.replace(/{output}/g, relativePath(outputFile, appletFolder));
                        if (File.fs == "Windows") {
                            appletCombineCommand = "cd \"" + relativePath(movieSegmentsFolder, appletFolder) + "\" && " + appletCombineCommand;
                        }
                        makeApplet(appletCombineCommand, combineSeedName, appletFolder);
                        if (useGardener) {
                            var gardenerCombineCommand = combineTemplate;
                            gardenerCombineCommand = gardenerCombineCommand.replace(/{RenderGarden}/g, File($.fileName).parent.fsName);
                            gardenerCombineCommand = gardenerCombineCommand.replace(/{python}/g, loadSetting(renderGardenPythonKey, defaultPythonCommand()));
                            gardenerCombineCommand = gardenerCombineCommand.replace(/{ffmpeg}/g, ffmpegPath);
                            gardenerCombineCommand = gardenerCombineCommand.replace(/{input}/g, relativePath(inputListFile, gardenerSeedsFolder));
                            gardenerCombineCommand = gardenerCombineCommand.replace(/{output}/g, relativePath(outputFile, gardenerSeedsFolder));
                            if (File.fs == "Windows") {
                                gardenerCombineCommand = "cd \"" + relativePath(movieSegmentsFolder, gardenerSeedsFolder) + "\" && " + gardenerCombineCommand
                            }
                            makeGardenerSeed(gardenerCombineCommand, "combine", null, null, null, null, renderSeedsArray, false, combineSeedName, gardenerSeedsFolder);
                        }
                    }
                    var makeQuickTime = loadSetting(renderGardenQuickTimeKey, false) && loadSetting(renderGardenPostRenderActionsKey, true);
                    var makeH264 = loadSetting(renderGardenH264Key, false) && loadSetting(renderGardenPostRenderActionsKey, false);
                    var postProcessMovieArray = [];
                    if (makeQuickTime || makeH264 && ffmpegPath.length) {
                        function adobeToFFmpegPath(path) {
                            if (path.search(/\[#+\]/) > -1) {
                                var padStringArray = path.match(/\[#+\]/);
                                var padSize = padStringArray[0].length - 2;
                                return path.replace(/\[#+\]/g, "%0" + padSize.toString() + "d");
                            } else {
                                return path;
                            }
                        }

                        function replaceCommandTokens(cmd, input, output) {
                            var frameRate = 1 / frameDuration;
                            var codec = loadSetting(renderGardenQuickTimeCodecKey, defaultQuickTimeCodec);
                            if (!(codec in quickTimeCodecs)) {
                                codec = defaultQuickTimeCodec
                            }
                            var codecString = quickTimeCodecs[codec];
                            if (codec == "DNxHD") {
                                var dnxhdFormat = loadSetting(renderGardenDnxhdFormatKey, defaultDnxhdFormat);
                                if (!(dnxhdFormat in dnxhdFormats)) {
                                    dnxhdFormat = defaultDnxhdFormat
                                }
                                var dnxhdDict = dnxhdFormats[dnxhdFormat];
                                var filterCommand = "-vf \"";
                                if (dnxhdDict.resolution != null) {
                                    filterCommand += "scale=" + dnxhdDict.resolution + ", "
                                }
                                filterCommand += "format=" + dnxhdDict.pixelFormat;
                                filterCommand += "\"";
                                var profileFlag = (dnxhdDict.profile == null ? "" : " -profile:v " + dnxhdDict.profile);
                                var bitrateFlag = "";
                                if (dnxhdDict.bitsAndRates != null) {
                                    var fpsDiff = 999;
                                    var bitrate = 440;
                                    for (var thisFrameRate in dnxhdDict.bitsAndRates) {
                                        var thisFpsDiff = Math.abs(frameRate - thisFrameRate);
                                        if (thisFpsDiff < fpsDiff) {
                                            fpsDiff = thisFpsDiff;
                                            bitrate = dnxhdDict.bitsAndRates[thisFrameRate];
                                        }
                                    }
                                    bitrateFlag = " -b:v " + bitrate.toString() + "M";
                                }
                                var dnxhdCodecSettings = filterCommand + profileFlag + bitrateFlag;
                                codecString = codecString.replace(/{dnxhd}/g, dnxhdCodecSettings);
                            }
                            var resizeString = "";
                            if (item.comp.width > 3072 || item.comp.height > 2048 || item.comp.width % 2 || item.comp.height % 2) {
                                var newWidth = item.comp.width;
                                var newHeight = item.comp.height;
                                if (item.comp.width > 3072 || item.comp.height > 2048) {
                                    if (newWidth > newHeight) {
                                        newWidth = 1920;
                                        newHeight = Math.round((newWidth * item.comp.height) / item.comp.width);
                                    } else {
                                        newHeight = 1000;
                                        newWidth = Math.round((newHeight * item.comp.width) / item.comp.height);
                                    }
                                }
                                newWidth += (newWidth % 2);
                                newHeight += (newHeight % 2);
                                resizeString = "-vf scale=" + newWidth + "x" + newHeight;
                            }
                            var command = cmd;
                            command = command.replace(/{RenderGarden}/g, File($.fileName).parent.fsName);
                            command = command.replace(/{python}/g, loadSetting(renderGardenPythonKey, defaultPythonCommand()));
                            command = command.replace(/{ffmpeg}/g, ffmpegPath);
                            command = command.replace(/{framerate}/g, (frameSequence ? "-framerate " + frameRate.toString() : ""));
                            command = command.replace(/{start}/g, (frameSequence ? "-start_number " + frameStart.toString() : ""));
                            command = command.replace(/{input}/g, input);
                            command = command.replace(/{resize}/g, resizeString);
                            command = command.replace(/{codec}/g, codecString);
                            command = command.replace(/{output}/g, output);
                            return command;
                        }
                        var movieDependsArray = (combineArray.length > 0 ? [combineSeedName] : renderSeedsArray);
                        if (makeQuickTime) {
                            var codecString = loadSetting(renderGardenQuickTimeCodecKey, defaultQuickTimeCodec).replace(/[ \-\(\)]+/g, "");
                            var quickTimeFile = outputFile.parent.file(outputFile.baseName() + "_QT_" + codecString + "." + loadSetting(renderGardenQuickTimeExtensionKey, defaultQuickTimeExtension));
                            var quickTimeSeedName = "QT" + (shortSeedNames ? "" : "_" + seedNameBase);
                            var appletQuickTimeCommand = replaceCommandTokens(loadSetting(renderGardenQuickTimeCommandKey, defaultQuickTimeCommand), adobeToFFmpegPath(relativePath(outputFile, appletFolder)), relativePath(quickTimeFile, appletFolder));
                            makeApplet(appletQuickTimeCommand, quickTimeSeedName, appletFolder);
                            if (useGardener) {
                                var gardenerQuickTimeCommand = replaceCommandTokens(loadSetting(renderGardenQuickTimeCommandKey, defaultQuickTimeCommand), adobeToFFmpegPath(relativePath(outputFile, gardenerSeedsFolder)), relativePath(quickTimeFile, gardenerSeedsFolder));
                                makeGardenerSeed(gardenerQuickTimeCommand, "ffmpeg", null, null, null, null, movieDependsArray, false, quickTimeSeedName, gardenerSeedsFolder);
                                postProcessMovieArray.push(quickTimeSeedName);
                            }
                        }
                        if (makeH264) {
                            var h264Command = loadSetting(renderGardenH264CommandKey, defaultH264Command);
                            var codecString = (h264Command.search(/265/) > -1 ? "H265" : "H264");
                            var h264File = outputFile.parent.file(outputFile.baseName() + "_" + codecString + "." + loadSetting(renderGardenH264ExtensionKey, defaultH264Extension));
                            var h264SeedName = "MP4" + (shortSeedNames ? "" : "_" + seedNameBase);
                            var appletH264Command = replaceCommandTokens(h264Command, adobeToFFmpegPath(relativePath(outputFile, appletFolder)), relativePath(h264File, appletFolder));
                            makeApplet(appletH264Command, h264SeedName, appletFolder);
                            if (useGardener) {
                                var gardenerH264Command = replaceCommandTokens(h264Command, adobeToFFmpegPath(relativePath(outputFile, gardenerSeedsFolder)), relativePath(h264File, gardenerSeedsFolder));
                                makeGardenerSeed(gardenerH264Command, "ffmpeg", null, null, null, null, movieDependsArray, false, h264SeedName, gardenerSeedsFolder);
                                postProcessMovieArray.push(h264SeedName);
                            }
                        }
                    }
                    var doneAlert = loadSetting(renderGardenDoneAlertKey, true) && loadSetting(renderGardenPostRenderActionsKey, true) && useGardener;
                    if (doneAlert) {
                        var alertDependsArray = (postProcessMovieArray.length > 0 ? postProcessMovieArray : ((combineArray.length > 0 ? [combineSeedName] : renderSeedsArray)));
                        var doneSeedName = "done_alert" + (shortSeedNames ? "" : "_" + seedNameBase);
                        var alertCommand = loadSetting(renderGardenDoneAlertCommandKey, defaultAlertCommand);
                        alertCommand = alertCommand.replace(/{RenderGarden}/g, File($.fileName).parent.fsName);
                        alertCommand = alertCommand.replace(/{job}/g, seedNameBase);
                        alertCommand = alertCommand.replace(/{python}/g, loadSetting(renderGardenPythonKey, defaultPythonCommand()));
                        alertCommand = alertCommand.replace(/{ffmpeg}/g, ffmpegPath);
                        alertCommand = alertCommand.replace(/{output}/g, relativePath(outputFile, gardenerSeedsFolder));
                        makeGardenerSeed(alertCommand, "notify", null, null, null, null, alertDependsArray, true, doneSeedName, gardenerSeedsFolder);
                    }
                    item.render = false;
                    numQueued++;
                }
            }
        } catch (e) {
            alert("Error: " + e.toString(), "RenderGarden", true);
        } finally {
            clearOutput();
            if (outputPathsAltered) {
                alert("Warning: Some output paths contained unsafe characters and had to be altered", "RenderGarden")
            }
            if (numQueued > 0) {
                saveSetting(renderGardenRunBeforeKey, true);
                if (showPostRenderDialog) {
                    postOpDialog(renderJobsApplets)
                }
            } else {
                alert("No render queue items queued", "RenderGarden", true)
            }
        }
    }

    function openURL(urlString) {
        if (File.fs == "Macintosh") {
            system.callSystem("open " + urlString)
        } else {
            system.callSystem("cmd.exe /c start " + urlString)
        }
    }

    function aboutBox() {
        var pythonMissing = !pythonPresent();
        var pythonWrongVersion = false;
        if (!pythonMissing) {
            var pythonCommand = loadSetting(renderGardenPythonKey, defaultPythonCommand());
            var pythonResult = system.callSystem(pythonCommand + " --version");
            pythonWrongVersion = pythonResult.search(/2\.6/) == -1 && pythonResult.search(/2\.7/) == -1;
        }
        var ffmpegPath = loadSetting(renderGardenFFmpegKey, "");
        var ffmpegMissing = !File(ffmpegPath).exists;
        var aboutDialog = new Window("dialog", "About RenderGarden", [0, 0, 350, 210]);
        var aboutString = "RenderGarden from Mekajiki.\nIt's not a farm, just a little garden.\n\nVersion " + versionNumber + "\n\n";
        if (pythonMissing) {
            aboutString += "Python is missing.\n"
        } else if (pythonWrongVersion) {
            aboutString += "Wrong Python Version.\n"
        } else {
            aboutString += "Python installed.\n"
        }
        if (ffmpegMissing) {
            aboutString += "FFmpeg missing.\n"
        } else {
            aboutString += "FFmpeg installed.\n"
        }
        aboutDialog.add("statictext", [50, 20, 300, 135], aboutString, {
            multiline: true
        });
        var supportButton = aboutDialog.add("button", [100, 135, 250, 155], "Support");
        supportButton.onClick = function () {
            openURL("http://www.mekajiki.com/rendergarden/support");
        };
        aboutDialog.defaultElement = aboutDialog.add("button", [125, 170, 225, 190], "Close");
        aboutDialog.defaultElement.onClick = function () {
            aboutDialog.close();
        };
        aboutDialog.center();
        aboutDialog.show();
    }

    function welcomeDialog() {
        var pythonMissing = !pythonPresent();
        var pythonResult = "";
        var pythonWrongVersion = false;
        if (!pythonMissing) {
            var pythonCommand = loadSetting(renderGardenPythonKey, defaultPythonCommand());
            pythonResult = system.callSystem(pythonCommand + " --version");
            pythonWrongVersion = pythonResult.search(/2\.7/) == -1;
        }
        var ffmpegPath = loadSetting(renderGardenFFmpegKey, "");
        var ffmpegMissing = !File(ffmpegPath).exists;
        var welcomeDialogWindow = new Window("dialog", "Welcome to RenderGarden", [0, 0, 350, 350]);
        var welcomeString = "Thank you for installing RenderGarden from Mekajiki. It's not a farm, just a little garden.\n\n";
        if (pythonMissing || pythonWrongVersion || ffmpegMissing) {
            welcomeString += "To unlock RenderGarden's full functionality, you'll need to download and install some free software.\n\n";
            if (pythonMissing) {
                welcomeString += "Python 2.7 is required to run the Gardener script.\n\n"
            } else if (pythonWrongVersion) {
                welcomeString += "Python 2.7 is required to run the Gardener script. You have " + pythonResult + "\n"
            } else {
                welcomeString += "You seem to be running a compatible version of Python: " + pythonResult + "\n"
            }
            if (ffmpegMissing) {
                welcomeString += "FFmpeg is used to combine movie segments and encode movies as a post process. You need to download it, place it in the same location on each computer in your Garden, and set the FFmpeg path in RenderGarden's preferences.\n"
            }
            var downloadButton = welcomeDialogWindow.add("button", [100, 260, 250, 280], "Download");
            downloadButton.onClick = function () {
                openURL("http://www.mekajiki.com/rendergarden/downloads");
            };
        } else {
            welcomeString += "\nIt looks like Python and FFmpeg are all set. Happy Gardening!\n\n\n\n\n\n(This dialog will stop appearing after you successfully plant some seeds.)";
        }
        welcomeDialogWindow.add("statictext", [50, 20, 300, 260], welcomeString, {
            multiline: true
        });
        welcomeDialogWindow.defaultElement = welcomeDialogWindow.add("button", [225, 300, 325, 320], "OK");
        welcomeDialogWindow.defaultElement.onClick = function () {
            welcomeDialogWindow.close();
        };
        welcomeDialogWindow.center();
        welcomeDialogWindow.show();
    }

    function commandsDialog() {
        var childrenAlignment = ["fill", "top"];
        var itemAlignment = "left";
        var rightAlignment = "right";
        var labelCharacters = 10;
        var dialog = new Window("dialog", "Commands", [0, 0, 800, 300], {
            resizeable: true
        });
        var topText = dialog.add("statictext", undefined, "Templates for FFmpeg commands");
        topText.helpTip = "RenderGarden runs FFmpeg commands for certain tasks such as combining movie segments and encoding movies from image sequences. You can customize these arguments to change its behavior, allowing you to do pretty much anything FFmpeg allows. See ffmpeg.org for complete documentation and to download FFmpeg.\n\nAll of these commands support tokens that RenderGarden will replace with paths and other parameters. See the ToolTip for each task to see which tokens it supports.";
        var combineGroup = dialog.add("group", undefined);
        combineGroup.alignChildren = childrenAlignment;
        var combineLabel = combineGroup.add("statictext", undefined, "Combine:");
        combineLabel.alignment = itemAlignment;
        combineLabel.characters = labelCharacters;
        var combineDefault = combineGroup.add("button", undefined, "Default");
        combineDefault.alignment = itemAlignment;
        var combineField = combineGroup.add("edittext", undefined);
        combineField.text = loadSetting(renderGardenCombineCommandKey, defaultCombineCommand);
        combineField.helpTip = "Command used to merge movie segments into a single movie without re-encoding. Tokens:\n{ffmpeg} - path to FFmpeg, set in prefs\n{input} - path to text file containing names of movie segments\n{output} - path where the final movie will be saved";
        combineDefault.onClick = function () {
            combineField.text = defaultCombineCommand;
        };
        var quickTimeGroup = dialog.add("group", undefined);
        quickTimeGroup.alignChildren = childrenAlignment;
        var quickTimeLabel = quickTimeGroup.add("statictext", undefined, "QuickTime:");
        quickTimeLabel.alignment = itemAlignment;
        quickTimeLabel.characters = labelCharacters;
        var quickTimeDefault = quickTimeGroup.add("button", undefined, "Default");
        quickTimeDefault.alignment = itemAlignment;
        var quickTimeExtensionField = quickTimeGroup.add("edittext", undefined);
        quickTimeExtensionField.alignment = itemAlignment;
        quickTimeExtensionField.text = loadSetting(renderGardenQuickTimeExtensionKey, defaultQuickTimeExtension);
        quickTimeExtensionField.characters = 4;
        quickTimeExtensionField.helpTip = "File extension used for QuickTime files, usually mov";
        var quickTimeCommandField = quickTimeGroup.add("edittext", undefined);
        quickTimeCommandField.text = loadSetting(renderGardenQuickTimeCommandKey, defaultQuickTimeCommand);
        quickTimeCommandField.helpTip = "Command used to mae a QuickTime file from After Effects' output. Tokens:\n{ffmpeg} - path to FFmpeg, set in prefs\n{start} - start frame of an image sequence\n{framerate} - frame rate of an image sequence\n{input} - path to input movie or image sequence\n{codec} - output movie codec settings\n{output} - path where the final movie will be saved";
        quickTimeDefault.onClick = function () {
            quickTimeExtensionField.text = defaultQuickTimeExtension;
            quickTimeCommandField.text = defaultQuickTimeCommand;
        };
        var h264Group = dialog.add("group", undefined);
        h264Group.alignChildren = childrenAlignment;
        var h264Label = h264Group.add("statictext", undefined, "MP4:");
        h264Label.alignment = itemAlignment;
        h264Label.characters = labelCharacters;
        var h264Default = h264Group.add("button", undefined, "Default");
        h264Default.alignment = itemAlignment;
        var h264Assistant = h264Group.add("button", undefined, "Assistant");
        h264Assistant.alignment = itemAlignment;
        var h264ExtensionField = h264Group.add("edittext", undefined);
        h264ExtensionField.alignment = itemAlignment;
        h264ExtensionField.text = loadSetting(renderGardenH264ExtensionKey, defaultH264Extension);
        h264ExtensionField.characters = 4;
        h264ExtensionField.helpTip = "File extension used for H.264/H.265 files, usually mp4";
        var h264CommandField = h264Group.add("edittext", undefined);
        h264CommandField.text = loadSetting(renderGardenH264CommandKey, defaultH264Command);
        h264CommandField.helpTip = "Command used to make an MP4 file from After Effects' output. Tokens:\n{ffmpeg} - path to FFmpeg, set in prefs\n{start} - start frame of an image sequence\n{framerate} - frame rate of an image sequence\n{input} - path to input movie or image sequence\n{resize} - resize the movie if it exceeds H.264 limits\n{output} - path where the final movie will be saved";
        h264Default.onClick = function () {
            h264ExtensionField.text = defaultH264Extension;
            h264CommandField.text = defaultH264Command;
        };
        h264Assistant.onClick = function () {
            var defaultCRF = 10;
            var minCRF = 0;
            var maxCRF = 51;
            var defaultBitrate = 8;
            var minBitrate = 1;
            var maxBitrate = 100;
            var assistantDialog = new Window("dialog", "RenderGarden MP4 Assistant", [0, 0, 350, 340], {
                resizeable: false
            });
            var x264Radio = assistantDialog.add("radiobutton", [90, 10, 150, 30], "H.264");
            var x265Radio = assistantDialog.add("radiobutton", [230, 10, 320, 30], "H.265");
            x264Radio.value = true;
            var codecLabel = assistantDialog.add("statictext", [10, 10, 60, 30], "Codec:");
            codecLabel.helpTip = x264Radio.helpTip = x265Radio.helpTip = "Codec to use. Go with H.264 unless you know you want H.265 (aka HEVC).";
            var pixFormat420Radio = assistantDialog.add("radiobutton", [90, 50, 150, 70], "4:2:0");
            var pixFormat422Radio = assistantDialog.add("radiobutton", [160, 50, 220, 70], "4:2:2");
            var pixFormat444Radio = assistantDialog.add("radiobutton", [230, 50, 290, 70], "4:4:4");
            pixFormat420Radio.value = true;
            var pixFormatLabel = assistantDialog.add("statictext", [10, 50, 60, 70], "Format:");
            pixFormatLabel.helpTip = pixFormat420Radio.helpTip = pixFormat422Radio.helpTip = pixFormat444Radio.helpTip = "YUV Pixel format.";
            var qualityRadio = assistantDialog.add("radiobutton", [10, 90, 80, 110], "Quality:");
            var bitrateRadio = assistantDialog.add("radiobutton", [10, 130, 80, 150], "Bit Rate:");
            qualityRadio.value = true;
            var qualityTextbox = assistantDialog.add("edittext", [90, 90, 130, 110], defaultCRF);
            var qualitySlider = assistantDialog.add("slider", [140, 90, 330, 110], maxCRF - defaultCRF, minCRF, maxCRF);
            qualityRadio.helpTip = qualityTextbox.helpTip = qualitySlider.helpTip = "Video quality, aka CRF. In this case lower is better. 0 means lossless and 51 is worst possible.";
            qualityTextbox.onChange = function () {
                qualitySlider.value = maxCRF - parseInt(qualityTextbox.text);
            };
            qualitySlider.onChange = qualitySlider.onChanging = function () {
                qualityTextbox.text = Math.round(maxCRF - qualitySlider.value);
            };
            var bitrateTextbox = assistantDialog.add("edittext", [90, 130, 130, 150], defaultBitrate);
            var bitrateSlider = assistantDialog.add("slider", [140, 130, 330, 150], defaultBitrate, minBitrate, maxBitrate);
            bitrateRadio.helpTip = bitrateTextbox.helpTip = bitrateSlider.helpTip = "Specify a bit rate in Mbps";
            bitrateSlider.onChange = bitrateSlider.onChanging = function () {
                bitrateTextbox.text = bitrateSlider.value;
            };
            bitrateTextbox.onChange = function () {
                var bitrate = parseFloat(bitrateTextbox.text);
                if (isNaN(bitrate)) {
                    bitrateTextbox.text = bitrate = defaultBitrate
                }
                if (bitrate > maxBitrate) {
                    bitrate = maxBitrate
                } else {
                    if (bitrate < minBitrate) {
                        bitrate = minBitrate
                    }
                }
                bitrateSlider.value = bitrate;
            };
            var twoPassCheckbox = assistantDialog.add("checkbox", [90, 170, 180, 190], "2-pass");
            twoPassCheckbox.value = true;
            twoPassCheckbox.helpTip = "Two-pass encoding. Only available in bit rate mode";
            qualityRadio.onClick = bitrateRadio.onClick = function () {
                qualityTextbox.enabled = qualitySlider.enabled = qualityRadio.value;
                bitrateTextbox.enabled = bitrateSlider.enabled = twoPassCheckbox.enabled = bitrateRadio.value;
            };
            qualityRadio.onClick();
            var presetLabel = assistantDialog.add("statictext", [40, 210, 80, 230], "Preset:");
            var presetMenu = assistantDialog.add("dropdownlist", [90, 210, 200, 230]);
            presetLabel.helpTip = presetMenu.helpTip = "Speed preset to use. Slower speeds result in better quality encoding for the same file size. Medium is FFmpeg's default.";
            presetMenu.selection = presetMenu.add("item", "None");
            presetMenu.add("separator");
            presetMenu.add("item", "ultrafast");
            presetMenu.add("item", "superfast");
            presetMenu.add("item", "veryfast");
            presetMenu.add("item", "faster");
            presetMenu.add("item", "fast");
            presetMenu.add("item", "medium");
            presetMenu.add("item", "slow");
            presetMenu.add("item", "slower");
            presetMenu.add("item", "veryslow");
            var tuneLabel = assistantDialog.add("statictext", [40, 240, 80, 260], "Tune:");
            var tuneMenu = assistantDialog.add("dropdownlist", [90, 240, 200, 260]);
            tuneLabel.helpTip = tuneMenu.helpTip = "Tune setting to use. Alters codec settings for different footage types.\nfilm – use for high quality movie content; lowers deblocking\nanimation – good for cartoons; uses higher deblocking and more reference frames\ngrain – preserves the grain structure in old, grainy film material\nstillimage – good for slideshow-like content\nfastdecode – allows faster decoding by disabling certain filters\nzerolatency – good for fast encoding and low-latency streaming";
            tuneMenu.selection = tuneMenu.add("item", "None");
            tuneMenu.add("separator");
            tuneMenu.add("item", "film");
            tuneMenu.add("item", "animation");
            tuneMenu.add("item", "grain");
            tuneMenu.add("item", "stillimage");
            tuneMenu.add("item", "fastdecode");
            tuneMenu.add("item", "zerolatency");
            var cancelAssistantButton = assistantDialog.add("button", [180, 300, 250, 320], "Cancel");
            cancelAssistantButton.onClick = function () {
                assistantDialog.close();
            };
            var okAssistantButtonButton = assistantDialog.add("button", [260, 300, 330, 320], "OK");
            assistantDialog.defaultElement = okAssistantButtonButton;
            okAssistantButtonButton.onClick = function () {
                var qualityTemplate = "\"{ffmpeg}\" -loglevel verbose -y {start} {framerate} -i \"{input}\" {resize} -c:v {codec} -pix_fmt {pixfmt} -crf {crf} {tune} {speed} \"{output}\"";
                var bitrateTemplate = "\"{ffmpeg}\" -loglevel verbose -y {start} {framerate} -i \"{input}\" {resize} -c:v {codec} -pix_fmt {pixfmt} -b:v {bitrate}M {tune} {speed} \"{output}\"";
                var bitrateTwopassTemplate = "\"{ffmpeg}\" -loglevel verbose -y {start} {framerate} -i \"{input}\" {resize} -c:v {codec} -pix_fmt {pixfmt} -b:v {bitrate}M {tune} {speed} -pass 1 -f mp4 /dev/null && \"{ffmpeg}\" -loglevel verbose -y {start} {framerate} -i \"{input}\" {resize} -c:v {codec} -pix_fmt {pixfmt} -b:v {bitrate}M {tune} {speed} -pass 2 \"{output}\"";
                if (File.fs == "Windows") {
                    bitrateTwopassTemplate = bitrateTwopassTemplate.replace("/dev/null", "NIL")
                }
                var codec = (x265Radio.value ? "libx265 -tag:v hvc1" : "libx264");
                var pixelFormat = (pixFormat444Radio.value ? "yuv444p" : ((pixFormat422Radio.value ? "yuv422p" : "yuv420p")));
                var crf = parseInt(qualityTextbox.text);
                var bitrate = parseFloat(bitrateTextbox.text);
                var template = (qualityRadio.value ? qualityTemplate : ((twoPassCheckbox.value ? bitrateTwopassTemplate : bitrateTemplate)));
                if (x265Radio.value) {
                    template = template.replace(/{resize}/g, "")
                }
                var tunePreset = tuneMenu.selection.text;
                if (x265Radio.value) {
                    switch (tunePreset) {
                        case "film":
                            tunePreset = "grain";
                            break;
                        case "grain":
                        case "zerolatency":
                        case "fastdecode":
                            break;
                        default:
                            tunePreset = "None";
                    }
                }
                template = template.replace(/{codec}/g, codec);
                template = template.replace(/{pixfmt}/g, pixelFormat);
                template = template.replace(/{crf}/g, crf.toString());
                template = template.replace(/{bitrate}/g, bitrate.toString());
                template = template.replace(/{tune}/g, (tunePreset == "None" ? "" : "-tune " + tunePreset));
                template = template.replace(/{speed}/g, (presetMenu.selection.text == "None" ? "" : "-preset " + presetMenu.selection.text));
                h264CommandField.text = template;
                assistantDialog.close();
            };
            assistantDialog.center();
            assistantDialog.show();
        };
        var doneAlertText = dialog.add("statictext", undefined, "Done Alert command, runs at end of job");
        var doneAlertGroup = dialog.add("group", undefined);
        doneAlertGroup.alignChildren = childrenAlignment;
        var doneAlertLabel = doneAlertGroup.add("statictext", undefined, "Done Alert:");
        doneAlertLabel.alignment = itemAlignment;
        doneAlertLabel.characters = labelCharacters;
        var doneAlertDefault = doneAlertGroup.add("button", undefined, "Default");
        doneAlertDefault.alignment = itemAlignment;
        var doneAlertCommandField = doneAlertGroup.add("edittext", undefined);
        doneAlertCommandField.text = loadSetting(renderGardenDoneAlertCommandKey, defaultAlertCommand);
        doneAlertCommandField.helpTip = "Command used to display an alert that the job is complete. Tokens:\n{job} - job name\n{renderStart} - time renderting began\n{renderEnd} - time rendering ended\n{renderTime} - total rendering time for all seeds\n{renderDuration} - time between render start and render end\n{jobStart} - time job was submitted\n{jobEnd} - time job ended and alert displayed\n{jobDuration} - time between job submission and alert display";
        doneAlertDefault.onClick = function () {
            doneAlertCommandField.text = defaultAlertCommand;
        };
        var buttonGroup = dialog.add("group", undefined);
        buttonGroup.alignChildren = ["right", "top"];
        var cancelButton = buttonGroup.add("button", undefined, "Cancel");
        cancelButton.alignment = rightAlignment;
        var okButton = buttonGroup.add("button", undefined, "OK");
        okButton.alignment = rightAlignment;
        dialog.defaultElement = okButton;
        cancelButton.onClick = function () {
            dialog.close();
        };
        okButton.onClick = function () {
            if (combineField.text.length > 0) {
                saveSetting(renderGardenCombineCommandKey, combineField.text)
            }
            if (quickTimeExtensionField.text.length > 0) {
                saveSetting(renderGardenQuickTimeExtensionKey, quickTimeExtensionField.text)
            }
            if (quickTimeCommandField.text.length > 0) {
                saveSetting(renderGardenQuickTimeCommandKey, quickTimeCommandField.text)
            }
            if (h264ExtensionField.text.length > 0) {
                saveSetting(renderGardenH264ExtensionKey, h264ExtensionField.text)
            }
            if (h264CommandField.text.length > 0) {
                saveSetting(renderGardenH264CommandKey, h264CommandField.text)
            }
            if (doneAlertCommandField.text.length > 0) {
                saveSetting(renderGardenDoneAlertCommandKey, doneAlertCommandField.text)
            }
            dialog.close();
        };
        dialog.onResizing = dialog.onResizing = function () {
            var margin = 5;
            var rowHeight = 20;
            var gap = 15;
            topText.bounds = [margin, margin, dialog.size[0] - margin, margin + rowHeight];
            combineGroup.bounds = [topText.bounds[0], topText.bounds[3] + gap, topText.bounds[2], topText.bounds[3] + gap + rowHeight];
            quickTimeGroup.bounds = [combineGroup.bounds[0], combineGroup.bounds[3] + gap, combineGroup.bounds[2], combineGroup.bounds[3] + gap + rowHeight];
            h264Group.bounds = [quickTimeGroup.bounds[0], quickTimeGroup.bounds[3] + gap, quickTimeGroup.bounds[2], quickTimeGroup.bounds[3] + gap + rowHeight];
            doneAlertText.bounds = [topText.bounds[0], h264Group.bounds[3] + gap + gap, topText.bounds[2], h264Group.bounds[3] + gap + gap + rowHeight];
            doneAlertGroup.bounds = [h264Group.bounds[0], doneAlertText.bounds[3] + gap, h264Group.bounds[2], doneAlertText.bounds[3] + gap + rowHeight];
            buttonGroup.bounds = [dialog.size[0] - 200, ((dialog.size[1] - margin) - rowHeight) - rowHeight, (dialog.size[0] - margin) - margin, (dialog.size[1] - margin) - rowHeight];
            combineGroup.layout.resize();
            quickTimeGroup.layout.resize();
            h264Group.layout.resize();
            doneAlertGroup.layout.resize();
            buttonGroup.layout.resize();
        };
        dialog.layout.layout();
        combineGroup.layout.layout();
        quickTimeGroup.layout.layout();
        h264Group.layout.layout();
        doneAlertGroup.layout.layout();
        buttonGroup.layout.layout();
        dialog.onResizing();
        dialog.center();
        dialog.show();
    }

    function makeMP4() {
        var ffmpegPath = loadSetting(renderGardenFFmpegKey, "");
        var ffmpegFile = new File(ffmpegPath);
        if (!ffmpegFile.exists) {
            alert("FFmpeg path required in Prefs Panel", "RenderGarden", true);
            return;
        }
        var seedBankFolder = new Folder(loadSetting(renderGardenSeedBankKey, ""));
        if (!seedBankFolder.exists) {
            seedBankFolder = Folder.selectDialog("Choose your seed bank");
            if (seedBankFolder != null && seedBankFolder.exists) {
                setSeedBank(seedBankFolder.fsName)
            }
        }
        if (seedBankFolder == null || !seedBankFolder.exists) {
            alert("Invalid seed bank", "Error", "RenderGarden", true);
            return;
        }
        var inputFile = File.openDialog("Choose source movie");
        if (inputFile != null) {
            var outputFile = File.saveDialog("Set output file");
            if (outputFile != null) {
                inputFile = File(inputFile.fsName);
                outputFile = File(outputFile.fsName);
                var renderGardenFolder = seedBankFolder.folder(makeSafeName(inputFile.baseName()));
                var seedFolder = renderGardenFolder.folder(makeSafeName(outputFile.baseName()));
                if (seedFolder.exists) {
                    deleteFolderContents(seedFolder);
                } else {
                    var created = seedFolder.create();
                    if (!created) {
                        throw "Failed to create " + seedFolder.fsName
                    }
                }
                var command = loadSetting(renderGardenH264CommandKey, defaultH264Command);
                command = command.replace(/{RenderGarden}/g, File($.fileName).parent.fsName);
                command = command.replace(/{python}/g, loadSetting(renderGardenPythonKey, defaultPythonCommand()));
                command = command.replace(/{ffmpeg}/g, ffmpegPath);
                command = command.replace(/{framerate}/g, "");
                command = command.replace(/{start}/g, "");
                command = command.replace(/{input}/g, inputFile.fsName);
                command = command.replace(/{resize}/g, "");
                command = command.replace(/{output}/g, outputFile.fsName);
                var seedName = "FFmpeg_" + makeSafeName(inputFile.baseName());
                makeGardenerSeed(command, "ffmpeg", null, null, null, null, null, false, seedName, seedFolder);
                if (gardenersRunning() > 0) {
                    alert("Seed planted", "Success", "RenderGarden", true)
                } else {
                    launchMoreGardeners()
                }
            }
        }
    }

    function postRenderActionsDialog() {
        var childrenAlignment = ["fill", "top"];
        var itemAlignment = "left";
        var rightAlignment = "right";
        var dialog = new Window("dialog", "Post Render Actions", [0, 0, 400, 250], {
            resizeable: false
        });
        var reencodeText = dialog.add("statictext", undefined, "Re-encode your completed AE render into an MP4 or QuickTime");
        var h264Check = dialog.add("checkbox", undefined, "MP4");
        h264Check.value = loadSetting(renderGardenH264Key, false);
        h264Check.helpTip = "Create H.264/H.265 MP4 from rendered AE output. Parameters can be adjusted in the Change Commands dialog, MP4 Assistant.";
        var h264Button = dialog.add("button", undefined, "+");
        h264Button.onClick = function () {
            makeMP4();
        };
        h264Button.helpTip = "Plant an MP4 transcode seed right now.\nUses the current FFmpeg command line template.\nClick this button, then choose your source movie, then your output destination.\nThat's it!";
        var quickTimeCheck = dialog.add("checkbox", undefined, "QuickTime");
        quickTimeCheck.value = loadSetting(renderGardenQuickTimeKey, false);
        quickTimeCheck.helpTip = "Create QuickTime from rendered AE output.";
        var quickTimeCodecMenu = dialog.add("dropdownlist", undefined);
        var quickTimeCodecCurrent = loadSetting(renderGardenQuickTimeCodecKey, defaultQuickTimeCodec);
        if (!(quickTimeCodecCurrent in quickTimeCodecs)) {
            quickTimeCodecCurrent = defaultQuickTimeCodec
        }
        for (var codec in quickTimeCodecs) {
            var newItem = quickTimeCodecMenu.add("item", codec);
            if (codec == quickTimeCodecCurrent) {
                quickTimeCodecMenu.selection = newItem
            }
        }
        quickTimeCodecMenu.helpTip = "Codec for QuickTime movie";
        var dnxhdMenu = dialog.add("dropdownlist", undefined);
        dnxhdMenu.helpTip = "Flavor of DNxHD to use";
        var dnxhdCurrent = loadSetting(renderGardenDnxhdFormatKey, defaultDnxhdFormat);
        if (!(dnxhdCurrent in dnxhdFormats)) {
            dnxhdCurrent = defaultDnxhdFormat
        }
        for (var format in dnxhdFormats) {
            var newItem = dnxhdMenu.add("item", format);
            if (format == dnxhdCurrent) {
                dnxhdMenu.selection = newItem
            }
        }
        quickTimeCodecMenu.enabled = quickTimeCheck.value;
        dnxhdMenu.visible = quickTimeCheck.value && quickTimeCodecMenu.selection.text == "DNxHD";
        quickTimeCheck.onClick = function () {
            quickTimeCodecMenu.enabled = quickTimeCheck.value;
            dnxhdMenu.visible = quickTimeCheck.value && quickTimeCodecMenu.selection.text == "DNxHD";
        };
        quickTimeCodecMenu.onChange = function () {
            dnxhdMenu.visible = quickTimeCheck.value && quickTimeCodecMenu.selection.text == "DNxHD";
        };
        var alertText = dialog.add("statictext", undefined, "Display an alert dialog when render is complete");
        var alertCheck = dialog.add("checkbox", undefined, "Render complete alert");
        alertCheck.value = loadSetting(renderGardenDoneAlertKey, true);
        alertCheck.helpTip = "Alert dialog will appear on submitting machine after all other seeds have completed. Submitting machine must have a Gardener running.";
        var commandsButton = dialog.add("button", undefined, "Commands…");
        commandsButton.alignment = itemAlignment;
        commandsButton.onClick = function () {
            commandsDialog();
        };
        var cancelButton = dialog.add("button", undefined, "Cancel");
        cancelButton.onClick = function () {
            dialog.close();
        };
        var okButton = dialog.add("button", undefined, "OK");
        dialog.defaultElement = okButton;
        okButton.onClick = function () {
            saveSetting(renderGardenH264Key, h264Check.value);
            saveSetting(renderGardenQuickTimeKey, quickTimeCheck.value);
            if (quickTimeCheck.value) {
                saveSetting(renderGardenQuickTimeCodecKey, quickTimeCodecMenu.selection.text)
            }
            if (quickTimeCheck.value && quickTimeCodecMenu.selection.text == "DNxHD") {
                saveSetting(renderGardenDnxhdFormatKey, dnxhdMenu.selection.text)
            }
            saveSetting(renderGardenDoneAlertKey, alertCheck.value);
            dialog.close();
        };
        dialog.onResizing = dialog.onResizing = function () {
            var margin = 10;
            var rowHeight = 20;
            var gap = 10;
            var indent = 30;
            var checkWidth = 80;
            var menuWidth = 220;
            reencodeText.bounds = [margin, margin, dialog.size[0] - margin, margin + rowHeight];
            h264Check.bounds = [reencodeText.bounds[0] + indent, reencodeText.bounds[3] + gap, reencodeText.bounds[0] + indent + checkWidth, reencodeText.bounds[3] + gap + rowHeight];
            quickTimeCheck.bounds = [h264Check.bounds[0], h264Check.bounds[3] + gap, h264Check.bounds[2], h264Check.bounds[3] + gap + rowHeight];
            quickTimeCodecMenu.bounds = [quickTimeCheck.bounds[2] + gap, quickTimeCheck.bounds[1] - 2, quickTimeCheck.bounds[2] + gap + menuWidth, quickTimeCheck.bounds[3]];
            h264Button.bounds = [quickTimeCodecMenu.bounds[2] - 20, h264Check.bounds[1], quickTimeCodecMenu.bounds[2], h264Check.bounds[3] - 2];
            dnxhdMenu.bounds = [quickTimeCodecMenu.bounds[0], quickTimeCodecMenu.bounds[3] + gap, quickTimeCodecMenu.bounds[2], quickTimeCodecMenu.bounds[3] + gap + rowHeight];
            alertText.bounds = [reencodeText.bounds[0], dnxhdMenu.bounds[3] + gap, reencodeText.bounds[2], dnxhdMenu.bounds[3] + gap + rowHeight];
            alertCheck.bounds = [h264Check.bounds[0], alertText.bounds[3] + gap, h264Check.bounds[0] + checkWidth + checkWidth, alertText.bounds[3] + gap + rowHeight];
            commandsButton.bounds = [margin, ((dialog.size[1] - margin) - rowHeight) - 10, margin + 100, (dialog.size[1] - margin) - 5];
            cancelButton.bounds = [dialog.size[0] - 190, commandsButton.bounds[1], dialog.size[0] - 100, commandsButton.bounds[3]];
            okButton.bounds = [dialog.size[0] - 90, commandsButton.bounds[1], dialog.size[0] - margin, commandsButton.bounds[3]];
        };
        dialog.layout.layout();
        dialog.onResizing();
        dialog.center();
        dialog.show();
    }

    function createUI(obj) {
        loadPrefs();
        var childrenAlignment = ["fill", "top"];
        var itemAlignment = "left";
        var rightAlignment = "right";
        var panel = (obj instanceof Panel ? obj : new Window("palette", "RenderGarden", undefined, {
            resizeable: true
        }));
        panel.alignChildren = childrenAlignment;
        var plantGroup = panel.add("group", undefined);
        plantGroup.alignChildren = childrenAlignment;
        var plantButton = plantGroup.add("button", undefined, "Plant the Seeds!");
        plantButton.helpTip = "Add comps to the Render Queue, then click here to plant Seeds and launch Gardeners which will render in the background";
        var aboutButton = plantGroup.add("button", undefined, "?");
        aboutButton.maximumSize = [30, 30];
        aboutButton.alignment = ["right", "center"];
        aboutButton.helpTip = "RenderGarden from Mekajiki lets you set up a simple ad hoc render farm (well, maybe not a farm, more like a little garden).\n\nAdd comps to your render queue, plant the seeds, and launch Gardeners to do your rendering in the background. You can run multiple Gardeners on one machine to better take advantage of multiple CPU cores, or run Gardeners on other computers on your network to harness their processors as well.";
        aboutButton.onClick = function () {
            aboutBox();
        };
        var seedsGroup = panel.add("group", undefined);
        seedsGroup.alignChildren = childrenAlignment;
        var seedsLabel = seedsGroup.add("statictext", undefined, "Seeds:");
        seedsLabel.alignment = itemAlignment;
        seedsLabel.characters = 10;
        var seedsTextBox = seedsGroup.add("edittext", undefined);
        seedsTextBox.alignment = itemAlignment;
        seedsTextBox.characters = 4;
        var seedsSlider = seedsGroup.add("slider", undefined, 5, 1, 10);
        seedsTextBox.text = seedsSlider.value = loadSetting(renderGardenNumberOfSeedsKey, 3);
        seedsSlider.onChanging = seedsSlider.onChange = function () {
            seedsTextBox.text = Math.round(seedsSlider.value);
            saveSetting(renderGardenNumberOfSeedsKey, Math.round(seedsSlider.value));
        };
        seedsTextBox.onChange = function () {
            var newValue = parseInt(seedsTextBox.text);
            if (isNaN(newValue)) {
                seedsTextBox.text = 5
            } else if (newValue < 1) {
                seedsTextBox.text = 1
            } else {
                if (newValue > 9999) {
                    seedsTextBox.text = 9999
                }
            }
            seedsSlider.value = parseInt(seedsTextBox.text);
            saveSetting(renderGardenNumberOfSeedsKey, parseInt(seedsTextBox.text));
        };
        seedsSlider.helpTip = seedsLabel.helpTip = seedsTextBox.helpTip = "Break each item in your render queue into this number of tasks";
        var priorityGroup = panel.add("group", undefined);
        priorityGroup.alignChildren = childrenAlignment;
        var doPriorityCheck = priorityGroup.add("checkbox", undefined, "Priority");
        doPriorityCheck.alignment = itemAlignment;
        doPriorityCheck.characters = 7;
        doPriorityCheck.value = loadSetting(renderGardenUsePriorityKey, false);
        var priorityTextBox = priorityGroup.add("edittext", undefined);
        priorityTextBox.alignment = itemAlignment;
        priorityTextBox.characters = 4;
        priorityTextBox.text = loadSetting(renderGardenPriorityKey, 3);
        var prioritySlider = priorityGroup.add("slider", undefined, 3, 1, 5);
        prioritySlider.value = 6 - parseInt(priorityTextBox.text);
        prioritySlider.onChanging = prioritySlider.onChange = function () {
            priorityTextBox.text = Math.round(6 - prioritySlider.value);
            saveSetting(renderGardenPriorityKey, Math.round(6 - prioritySlider.value));
        };
        priorityTextBox.onChange = function () {
            var newValue = parseInt(priorityTextBox.text);
            if (isNaN(newValue)) {
                priorityTextBox.text = 3
            } else if (newValue < 1) {
                priorityTextBox.text = 1
            } else {
                if (newValue > 5) {
                    priorityTextBox.text = 5
                }
            }
            prioritySlider.value = 6 - parseInt(priorityTextBox.text);
            saveSetting(renderGardenPriorityKey, parseInt(priorityTextBox.text));
        };
        doPriorityCheck.helpTip = priorityTextBox.helpTip = prioritySlider.helpTip = "Render job priority. Jobs with priority 1 will get rendered first, jobs with larger numbers later.\n\nPriority is appended to front of the job folder, forcing the Gardener script to pick it up earlier in alphabetical order.\n\nUsed in conjunction with the Gardener script.";
        var actionsGroup = panel.add("group", undefined);
        actionsGroup.alignChildren = childrenAlignment;
        var actionsCheck = actionsGroup.add("checkbox", undefined, "Post Render Actions");
        actionsCheck.alignment = itemAlignment;
        actionsCheck.value = loadSetting(renderGardenPostRenderActionsKey, true);
        actionsCheck.helpTip = "Enable actions to be performed after your completed AE render. Allows you to re-encode the ouput to MP4 or QuickTime.";
        var configureActionsButton = actionsGroup.add("button", undefined, "Configure");
        configureActionsButton.alignment = itemAlignment;
        configureActionsButton.enabled = actionsCheck.value;
        configureActionsButton.onClick = function () {
            postRenderActionsDialog();
        };
        configureActionsButton.helpTip = "Configure your Post Render Actions";
        actionsCheck.onClick = function () {
            saveSetting(renderGardenPostRenderActionsKey, actionsCheck.value);
            configureActionsButton.enabled = actionsCheck.value;
        };
        panel.add("panel", undefined);
        var launchButton = panel.add("button", undefined, "Launch More Gardeners");
        launchButton.minimumSize = launchButton.maximumSize = [180, 25];
        launchButton.alignment = itemAlignment;
        launchButton.helpTip = "Launch more instances of the Gardener script to render existing seeds";
        var showPrefsButton = panel.add("button", undefined, "Show Prefs");
        showPrefsButton.minimumSize = showPrefsButton.maximumSize = [180, 25];
        showPrefsButton.alignment = itemAlignment;
        var prefsPanel = panel.add("panel", undefined, "Prefs");
        prefsPanel.alignChildren = childrenAlignment;
        prefsPanel.visible = false;
        showPrefsButton.onClick = function () {
            prefsPanel.visible = !prefsPanel.visible;
            showPrefsButton.text = (prefsPanel.visible ? "Hide Prefs" : "Show Prefs");
        };
        var prefsLabelJustifyCharacters = 16;
        prefsPanel.add("statictext", undefined, "General Prefs (Set these before using RenderGarden)");
        var pythonGroup = prefsPanel.add("group", undefined);
        pythonGroup.alignChildren = childrenAlignment;
        var pythonLabel = pythonGroup.add("statictext", undefined, "Python command:");
        pythonLabel.characters = prefsLabelJustifyCharacters;
        pythonLabel.alignment = itemAlignment;
        var pythonDownload = pythonGroup.add("button", undefined, "Download");
        pythonDownload.alignment = itemAlignment;
        pythonDownload.helpTip = "Windows users need to install Python. Mac users should already have it.";
        pythonDownload.onClick = function () {
            openURL("http://www.mekajiki.com/rendergarden/downloads");
        };
        var pythonDefaultButton = pythonGroup.add("button", undefined, "Default");
        pythonDefaultButton.alignment = itemAlignment;
        var pythonBrowse = pythonGroup.add("button", undefined, "Browse…");
        pythonBrowse.alignment = itemAlignment;
        var pythonField = pythonGroup.add("edittext", undefined);
        pythonField.text = loadSetting(renderGardenPythonKey, defaultPythonCommand());
        pythonField.onChange = function () {
            saveSetting(renderGardenPythonKey, pythonField.text);
            delete renderGarden_PythonPresent;
        };
        pythonField.helpTip = pythonLabel.helpTip = "Python command. If the python command is in your shell's PATH variable, this can just be \"python\", like it is on Mac.";
        pythonDefaultButton.onClick = function () {
            pythonField.text = defaultPythonCommand();
            pythonField.onChange();
        };
        pythonBrowse.onClick = function () {
            var defaultFile = new File((File.fs == "Macintosh" ? "/usr/bin/python" : "C:\\Python27\\python.exe"));
            var fileResult = defaultFile.openDlg("Pick your Python program");
            if (fileResult != null) {
                pythonField.text = (fileResult.fsName.indexOf(" ") < 0 ? fileResult.fsName : "\"" + fileResult.fsName + "\"");
                pythonField.onChange();
            }
        };
        var ffmpegGroup = prefsPanel.add("group", undefined);
        ffmpegGroup.alignChildren = childrenAlignment;
        var ffmpegLabel = ffmpegGroup.add("statictext", undefined, "FFmpeg path:");
        ffmpegLabel.characters = prefsLabelJustifyCharacters;
        ffmpegLabel.alignment = itemAlignment;
        var ffmpegDownload = ffmpegGroup.add("button", undefined, "Download");
        ffmpegDownload.alignment = itemAlignment;
        ffmpegDownload.helpTip = "Mac and Windows users will need to download FFmpeg and place it in the same location on each computer in your Garden.";
        ffmpegDownload.onClick = function () {
            openURL("http://www.mekajiki.com/rendergarden/downloads");
        };
        var ffmpegBrowse = ffmpegGroup.add("button", undefined, "Browse…");
        ffmpegBrowse.alignment = itemAlignment;
        var ffmpegField = ffmpegGroup.add("edittext", undefined);
        ffmpegField.text = loadSetting(renderGardenFFmpegKey, "");
        ffmpegField.onChange = function () {
            saveSetting(renderGardenFFmpegKey, ffmpegField.text);
        };
        ffmpegField.helpTip = ffmpegLabel.helpTip = "Path to FFmpeg command, used for combining movies.";
        ffmpegBrowse.onClick = function () {
            var fileResult = File.openDialog("Pick your FFmpeg program");
            if (fileResult != null) {
                ffmpegField.text = fileResult.fsName;
                ffmpegField.onChange();
            }
        };
        var seedBankGroup = prefsPanel.add("group", undefined);
        seedBankGroup.alignChildren = childrenAlignment;
        var seedBankLabel = seedBankGroup.add("statictext", undefined, "Seed Bank:");
        seedBankLabel.characters = prefsLabelJustifyCharacters;
        seedBankLabel.alignment = itemAlignment;
        var seedBankPathBrowse = seedBankGroup.add("button", undefined, "Browse…");
        seedBankPathBrowse.alignment = itemAlignment;
        var seedBankPathField = seedBankGroup.add("edittext", undefined);
        seedBankPathField.text = loadSetting(renderGardenSeedBankKey, "");
        seedBankPathField.onChange = function () {
            setSeedBank(seedBankPathField.text);
        };
        seedBankLabel.helpTip = seedBankPathField.helpTip = "Seed Bank path. All RenderGarden files will be created in this folder.";
        seedBankPathBrowse.onClick = function () {
            var currentFolder = Folder(seedBankPathField.text);
            var prompt = "Pick your Seed Bank folder";
            var folderResult = (currentFolder.exists ? currentFolder.selectDlg(prompt) : Folder.selectDialog(prompt));
            if (folderResult != null) {
                seedBankPathField.text = folderResult.fsName;
                seedBankPathField.onChange();
            }
        };
        plantButton.onClick = function () {
            var seedBankFolder = new Folder(loadSetting(renderGardenSeedBankKey, ""));
            if (!seedBankFolder.exists) {
                seedBankFolder = Folder.selectDialog("Choose your seed bank");
                if (seedBankFolder != null && seedBankFolder.exists) {
                    seedBankPathField.text = seedBankFolder.fsName;
                    seedBankPathField.onChange();
                }
            }
            if (seedBankFolder != null && seedBankFolder.exists) {
                makeStuff(true)
            }
        };
        launchButton.onClick = function () {
            var seedBankFolder = new Folder(loadSetting(renderGardenSeedBankKey, ""));
            if (!seedBankFolder.exists) {
                seedBankFolder = Folder.selectDialog("Choose your seed bank");
                if (seedBankFolder != null && seedBankFolder.exists) {
                    seedBankPathField.text = seedBankFolder.fsName;
                    seedBankPathField.onChange();
                }
            }
            if (seedBankFolder != null && seedBankFolder.exists) {
                launchMoreGardeners()
            }
        };
        prefsPanel.add("panel", undefined);
        prefsPanel.add("statictext", undefined, "Advanced Prefs (You should probably not touch these unless you really know what you are doing.)");
        var commandGroup = prefsPanel.add("group", undefined);
        commandGroup.alignChildren = childrenAlignment;
        var commandLabel = commandGroup.add("statictext", undefined, "Render command:");
        commandLabel.characters = prefsLabelJustifyCharacters;
        commandLabel.alignment = itemAlignment;
        var defaultButton = commandGroup.add("button", undefined, "Default");
        defaultButton.alignment = rightAlignment;
        defaultButton.onClick = function () {
            commandField.text = defaultRenderCommand;
            commandField.onChange();
        };
        var commandField = commandGroup.add("edittext", undefined, "cmd");
        commandField.text = loadSetting(renderGardenAECommandKey, defaultRenderCommand);
        commandField.onChange = function () {
            saveSetting(renderGardenAECommandKey, commandField.text);
        };
        var renderCommandTip = "RenderGarden will replace certain tokens with relevant vaues:\n{aerender} - aerender command path, from below\n{project} - path to project, use with -project\n{rqindex} - index number of the render queue item, use with -rqindex\n{comp} - comp name, use with -comp, use either this OR {rqindex}\n{output} - output path, use with -output\n{start} - start frame for seed, use with -s\n{end} - end frame for seed, use with -e";
        commandLabel.helpTip = commandField.helpTip = renderCommandTip;
        var aerenderGroup = prefsPanel.add("group", undefined);
        aerenderGroup.alignChildren = childrenAlignment;
        var aerenderLabel = aerenderGroup.add("statictext", undefined, "aerender path:");
        aerenderLabel.characters = prefsLabelJustifyCharacters;
        aerenderLabel.alignment = itemAlignment;
        var aerenderDefaultButton = aerenderGroup.add("button", undefined, "Default");
        aerenderDefaultButton.alignment = itemAlignment;
        var aerenderBrowse = aerenderGroup.add("button", undefined, "Browse…");
        aerenderBrowse.alignment = itemAlignment;
        var aerenderField = aerenderGroup.add("edittext", undefined);
        aerenderField.text = loadSetting(renderGardenAERenderKey, aerenderDefault());
        aerenderField.onChange = function () {
            saveSetting(renderGardenAERenderKey, aerenderField.text);
        };
        aerenderField.helpTip = aerenderLabel.helpTip = "Path to aerender command, substituted in command for {aerender}";
        aerenderDefaultButton.onClick = function () {
            aerenderField.text = aerenderDefault();
            aerenderField.onChange();
        };
        aerenderBrowse.onClick = function () {
            var fileResult = File.openDialog("Pick your aerender command");
            if (fileResult != null) {
                aerenderField.text = fileResult.fsName;
                aerenderField.onChange();
            }
        };
        var movieCommandGroup = prefsPanel.add("group", undefined);
        movieCommandGroup.alignChildren = childrenAlignment;
        var movieCommandLabel = movieCommandGroup.add("statictext", undefined, "Commands:");
        movieCommandLabel.alignment = itemAlignment;
        movieCommandLabel.characters = prefsLabelJustifyCharacters;
        var commandButton = movieCommandGroup.add("button", undefined, "Change Commands…");
        commandButton.maximumSize = [200, 40];
        commandButton.onClick = commandsDialog;
        movieCommandLabel.helpTip = commandButton.helpTip = "Edit the commands RenderGarden runs in the terminal";
        var incrementAndSaveCheck = prefsPanel.add("checkbox", undefined, "Increment and Save");
        incrementAndSaveCheck.value = loadSetting(renderGardenIncrementAndSaveKey, false);
        incrementAndSaveCheck.onClick = function () {
            saveSetting(renderGardenIncrementAndSaveKey, incrementAndSaveCheck.value);
        };
        incrementAndSaveCheck.helpTip = "Increment and Save your project on every submission.\n\nThis option may be needed if your network does not have a central server, breaking projects that are copied to the seed bank.";
        var relativeCheck = prefsPanel.add("checkbox", undefined, "Relative paths");
        relativeCheck.value = loadSetting(renderGardenRelativeKey, true);
        relativeCheck.onClick = function () {
            saveSetting(renderGardenRelativeKey, relativeCheck.value);
        };
        relativeCheck.helpTip = "Use relative paths in applets, protects against different mount paths on different machines";
        prefsPanel.add("panel", undefined);
        var gardenerCheck = prefsPanel.add("checkbox", undefined, "Use Gardener");
        gardenerCheck.value = loadSetting(renderGardenGardenerKey, true);
        gardenerCheck.onClick = function () {
            saveSetting(renderGardenGardenerKey, gardenerCheck.value);
            doPriorityCheck.enabled = gardenerCheck.value;
            priorityTextBox.enabled = prioritySlider.enabled = doPriorityCheck.value && gardenerCheck.value;
        };
        gardenerCheck.helpTip = "Create files to use with the Gardener Python script";
        doPriorityCheck.enabled = gardenerCheck.value;
        priorityTextBox.enabled = prioritySlider.enabled = doPriorityCheck.value && gardenerCheck.value;
        doPriorityCheck.onClick = function () {
            saveSetting(renderGardenUsePriorityKey, doPriorityCheck.value);
            priorityTextBox.enabled = prioritySlider.enabled = doPriorityCheck.value && gardenerCheck.value;
        };
        var shortSeedsCheck = prefsPanel.add("checkbox", undefined, "Short seed names");
        shortSeedsCheck.value = loadSetting(renderGardenShortSeedsKey, false);
        shortSeedsCheck.onClick = function () {
            saveSetting(renderGardenShortSeedsKey, shortSeedsCheck.value);
        };
        shortSeedsCheck.helpTip = "Don't include the name of the output file in seed filenames";
        var detectionMessage = prefsPanel.add("statictext", undefined, "Gardener success/failure detection. For advanced users only.");
        detectionMessage.helpTip = "Unfortunately, aerender can be flakey. It will sometimes fail for whatever reason, but then report to the operating system that it succeeded by returning an exit code of 0.\n\nThese controls let you add extra methods for Gardener to tell if aerender really suceeded. To know if you should use these controls, read the logs that aerender is outputting.";
        var detectionGroup = prefsPanel.add("group", undefined);
        detectionGroup.alignChildren = childrenAlignment;
        var checkFilesCheck = detectionGroup.add("checkbox", undefined, "Output files");
        checkFilesCheck.value = loadSetting(renderGardenCheckFilesKey, true);
        checkFilesCheck.onClick = function () {
            saveSetting(renderGardenCheckFilesKey, checkFilesCheck.value);
        };
        checkFilesCheck.helpTip = "After the render is complete, Gardener will check to see if the output file(s) exist. If any of them do not, the seed will be marked as failed and re-queued.";
        var countFramesCheck = detectionGroup.add("checkbox", undefined, "Count frames");
        countFramesCheck.value = loadSetting(renderGardenCountFramesKey, false);
        countFramesCheck.onClick = function () {
            saveSetting(renderGardenCountFramesKey, countFramesCheck.value);
        };
        countFramesCheck.helpTip = "Parse the log to make sure the number of frames expected is the number rendered. If fewer appear to have been rendered, seed will fail and get re-queued.";
        var checkSuccessCheck = detectionGroup.add("checkbox", undefined, "Finished string");
        checkSuccessCheck.value = loadSetting(renderGardenCheckSuccessKey, false);
        checkSuccessCheck.onClick = function () {
            saveSetting(renderGardenCheckSuccessKey, checkSuccessCheck.value);
        };
        checkSuccessCheck.helpTip = "Will scan the log for the phrase \"Finished composition\" and only consider the render successful if it appears. This option can be useful when rendering movies, as the file will exist even if the render does not complete successfully.";
        var checkErrorCheck = detectionGroup.add("checkbox", undefined, "Error string");
        checkErrorCheck.value = loadSetting(renderGardenCheckErrorKey, false);
        checkErrorCheck.onClick = function () {
            saveSetting(renderGardenCheckErrorKey, checkErrorCheck.value);
        };
        checkErrorCheck.helpTip = "Will scan the log for the word \"error\" and will mark the seed as failed if it appears. Note that aerender sometimes flags warnings as errors.";
        if (!(panel.layout instanceof AutoLayoutManager)) {
            alert("no autolayout", "RenderGarden")
        }
        panel.onResizing = function () {
            panel.layout.resize();
        };
        panel.onShow = function () {
            panel.layout.layout();
        };
        if (panel instanceof Window) {
            panel.center();
            panel.show();
        }
        panel.layout.layout();
        if (!loadSetting(renderGardenRunBeforeKey, false)) {
            welcomeDialog();
        }
        return panel;
    }

    function CheckSerial(serialString) {
        function FlipBytes(number) {
            return (((number & 255) << 16) | (number & 65280)) | ((number & 16711680) >> 16);
        }
        var pseudoRandomArray = [73469948, 32972012, 63304631, 40861222, 150825, 38233813, 32583654, 27549202, 51084837, 56609425, 31743962, 62722240, 72913224, 80284178, 45185022, 16758944, 41676787, 58811322, 4882962, 10284942, 5296327, 50207697, 44950491, 69699945, 3065057, 82727479, 80904610, 69942751, 5999134, 44649253, 147513, 65785928];

        function GetCode(encoded, number) {
            var swappedCode = encoded - pseudoRandomArray[number % pseudoRandomArray.length];
            return FlipBytes(swappedCode);
        }

        function GetProductID(code) {
            return (code & 240) >> 4;
        }

        function GetReserved(code) {
            return code & 15;
        }

        function GetNumber(code) {
            return (code & 16776960) >> 8;
        }
        if (serialString.length < 19 || serialString[4] != "-" || serialString[9] != "-" || serialString[14] != "-") {
            return null;
        }
        var productCode = serialString.substr(0, 4);
        var product = (productCode == "RG10" ? "RenderGarden" : "NULL");
        var productID = (product == "RenderGarden" ? 1 : 0);
        if (productID == 0) {
            return null;
        }
        var numberString = serialString.substr(15);
        while (numberString[0] == "0" && numberString.length > 1) {
            numberString = numberString.substr(1)
        }
        var number = parseInt(numberString);
        if (isNaN(number)) {
            return null;
        }
        if (product == "RenderGarden") {
            var badRenderGardenNumbers = [6];
            if (indexInArray(badRenderGardenNumbers, number) >= 0) {
                return null;
            }
        }
        var codeString = serialString.substr(5, 4) + serialString.substr(10, 4);
        while (codeString[0] == "0" && codeString.length > 1) {
            codeString = codeString.substr(1)
        }
        var encoded = parseInt(codeString);
        if (isNaN(encoded)) {
            return null;
        }
        var code = GetCode(encoded, number);
        if (GetProductID(code) != productID) {
            return null;
        }
        if (GetReserved(code) != 0) {
            return null;
        }
        if (GetNumber(code) != number) {
            return null;
        }
        return product;
    }

    function VerifySerial(serialString) {
        return CheckSerial(serialString) == "RenderGarden";
    }

    function LoadAndCheckSerial() {
        var machinePrefsFile = (File.fs == "Macintosh" ? new File("/Library/Preferences/com.sunfish.CenterBoard.userData") : Folder.appData.file("com.sunfish.CenterBoard.userData"));
        var machineOpened = machinePrefsFile.open("r");
        if (machineOpened) {
            var machineString = machinePrefsFile.readln();
            machinePrefsFile.close();
            if (VerifySerial(machineString)) {
                return true;
            }
        }
        var userPrefsFile = (File.fs == "Macintosh" ? new File("~/Library/Preferences/com.sunfish.CenterBoard.userData") : Folder.userData.file("com.sunfish.CenterBoard.userData"));
        var userOpened = userPrefsFile.open("r");
        if (userOpened) {
            var userString = userPrefsFile.readln();
            userPrefsFile.close();
            if (VerifySerial(userString)) {
                return true;
            }
        }
        return false;
    }

    function CheckAndStoreSerial(serialString) {
        if (VerifySerial(serialString)) {
            var machineSerialFile = (File.fs == "Macintosh" ? new File("/Library/Preferences/com.sunfish.CenterBoard.userData") : Folder.appData.file("com.sunfish.CenterBoard.userData"));
            var machineOpened = machineSerialFile.open("w");
            if (machineOpened) {
                machineSerialFile.encoding = "UTF-8";
                var wrote = machineSerialFile.writeln(serialString);
                if (!wrote) {
                    debugger
                }
                machineSerialFile.close();
            }
            var userSerialFile = (File.fs == "Macintosh" ? new File("~/Library/Preferences/com.sunfish.CenterBoard.userData") : Folder.userData.file("com.sunfish.CenterBoard.userData"));
            var userOpened = userSerialFile.open("w");
            if (userOpened) {
                userSerialFile.encoding = "UTF-8";
                var wrote = userSerialFile.writeln(serialString);
                if (!wrote) {
                    debugger
                }
                userSerialFile.close();
            }
            return true;
        } else {
            return false;
        }
    }

    function external_plant_seeds() {
        if (LoadAndCheckSerial()) {
            var seedBankFolder = new Folder(loadSetting(renderGardenSeedBankKey, ""));
            if (!seedBankFolder.exists) {
                seedBankFolder = Folder.selectDialog("Choose your seed bank");
                if (seedBankFolder != null && seedBankFolder.exists) {
                    seedBankPathField.text = seedBankFolder.fsName;
                    seedBankPathField.onChange();
                }
            }
            if (seedBankFolder != null && seedBankFolder.exists) {
                makeStuff(false)
            }
        } else {
            alert("RenderGarden is not licensed")
        }
    }
    RenderGarden_PlantSeeds = external_plant_seeds;
    if (!app.preferences.getPrefAsLong("Main Pref Section", "Pref_SCRIPTING_FILE_NETWORK_SECURITY")) {
        alert("RenderGarden requires the scripting security preference to be set.\nGo to the \"General\" panel of your application preferences,\nand make sure that \"Allow Scripts to Write Files and Access Network\" is checked.", "RenderGarden");
    } else {
        if (LoadAndCheckSerial()) {
            createUI(thisObj);
        } else {
            var machineTrialFile = (File.fs == "Macintosh" ? new File("/Library/Preferences/com.herring.userData") : Folder.appData.file("com.herring.userData"));
            var userTrialFile = (File.fs == "Macintosh" ? new File("~/Library/Preferences/com.herring.userData") : Folder.userData.file("com.herring.userData"));
            var trialSection = "Herring";
            var trialKey = "UserData";
            var currentDate = new Date();
            var trialStart = 0;
            if (!app.settings.haveSetting(trialSection, trialKey) && !machineTrialFile.exists && !userTrialFile.exists) {
                var currentDateString = currentDate.toString();
                app.settings.saveSetting(trialSection, trialKey, currentDateString);
                var machineOpened = machineTrialFile.open("w");
                if (machineOpened) {
                    machineTrialFile.encoding = "UTF-8";
                    var wrote = machineTrialFile.writeln(currentDateString);
                    if (!wrote) {
                        debugger
                    }
                    machineTrialFile.close();
                }
                var userOpened = userTrialFile.open("w");
                if (userOpened) {
                    userTrialFile.encoding = "UTF-8";
                    var wrote = userTrialFile.writeln(currentDateString);
                    if (!wrote) {
                        debugger
                    }
                    userTrialFile.close();
                }
                trialStart = currentDate.getTime();
            } else {
                if (app.settings.haveSetting(trialSection, trialKey)) {
                    var prefsString = app.settings.getSetting(trialSection, trialKey);
                    var prefsDate = new Date(prefsString);
                    var prefsSecs = prefsDate.getTime();
                    if (!isNaN(prefsSecs)) {
                        trialStart = prefsSecs
                    }
                }
                if (trialStart == 0 && machineTrialFile.exists) {
                    var machineOpened = machineTrialFile.open("r");
                    if (machineOpened) {
                        var machineString = machineTrialFile.readln();
                        machineTrialFile.close();
                        var machineDate = new Date(machineString);
                        var machineSecs = machineDate.getTime();
                        if (!isNaN(machineSecs)) {
                            trialStart = machineSecs
                        }
                    }
                }
                if (trialStart == 0 && userTrialFile.exists) {
                    var userOpened = userTrialFile.open("r");
                    if (userOpened) {
                        var userString = userTrialFile.readln();
                        userTrialFile.close();
                        var userDate = new Date(userString);
                        var userSecs = userDate.getTime();
                        if (!isNaN(userSecs)) {
                            trialStart = userSecs
                        }
                    }
                }
            }
            var trialTime = currentDate.getTime() - trialStart;
            var trialDays = 7;
            var trialPeriod = trialDays * 24 * 60 * 60 * 1000;
            var trialOK = trialTime < trialPeriod;
            var trialDaysLeft = (trialOK ? Math.round((trialPeriod - trialTime) / 86400000) : 0);
            var registerDialog = new Window("dialog", "RenderGarden", [0, 0, 350, 140], {
                resizeable: false
            });
            var registerText = "Register your copy of RenderGarden.\n" + (trialOK ? trialDaysLeft.toString() + " days remain in the trial period." : "The trial period is over.");
            registerDialog.add("statictext", [50, 20, 300, 60], registerText, {
                multiline: true
            });
            var serialField = registerDialog.add("edittext", [50, 60, 300, 80]);
            var buyButton = registerDialog.add("button", [50, 100, 120, 120], "Buy");
            buyButton.onClick = function () {
                openURL("http://rendergarden.io");
            };
            var cancelTrialButton = registerDialog.add("button", [150, 100, 220, 120], (trialOK ? "Trial" : "Cancel"));
            if (trialOK) {
                cancelTrialButton.onClick = function () {
                    registerDialog.close();
                    createUI(thisObj);
                };
            } else {
                cancelTrialButton.onClick = function () {
                    registerDialog.close();
                };
            }
            var registerButton = registerDialog.add("button", [230, 100, 300, 120], "Register");
            registerButton.onClick = function () {
                if (CheckAndStoreSerial(trimString(serialField.text))) {
                    registerDialog.close();
                    createUI(thisObj);
                } else {
                    alert("Invalid serial number", "RenderGarden")
                }
            };
            registerDialog.center();
            registerDialog.show();
        }
    }
})(this);