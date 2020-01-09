/******************************************
__MXSDOC__
Author:				Gavyn Thompson
Company:				GTVFX
Website:				www.gtvfx.com
Email:				gthompson@gtvfx.com
ScriptVersion:			v1.0.00
Updated:				11/20/2013
[Purpose]
Collects all scene dependencies and copies them to a single folder along with a copy of the Max file itself.
Once this package is sent off elsewhere, the repath button with reconnect all the dependency paths to the local folder structure.
[KEYWORDS]
Localize, Assets, Collect
__END__
******************************************/
struct localizeSceneStruct
(
	self,
	ro,
	fileAssetsArr = #(),
	fileAssetsDir,
	localizedSceneFile,
	
	fn collectAssetData =
	(
		fileAssetsArr = getMAXFileAssetMetadata (maxFilePath + maxFilename)
		fileAssetsDir = (maxFilePath + "\\" + (getFileNameFile maxFileName) + "\\fileAssets\\")
	),
	fn collectFileAssets_FN =
	(
		if fileAssetsArr.count != 0 then
		(
			makeDir fileAssetsDir
			for i in fileAssetsArr do
			(
				copyFile i.fileName (fileAssetsDir + "\\" + filenameFromPath i.fileName)
			)
			localizedSceneFile = (maxFilePath + "\\" + (getFileNameFile maxFileName) + "\\" + maxFileName)
			copyFile (maxFilePath+maxFileName) localizedSceneFile
		)
	),
	fn repathFileAssetsToLocalFolder_FN sceneFile =
	(
		if fileAssetsArr.count != 0 then
		(
			for i in fileAssetsArr do
			(
				newPath = (maxFilePath + "\\fileAssets\\" + (fileNameFromPath i.fileName))
				i.fileName = newPath
				setMAXFileAssetMetadata sceneFile fileAssetsArr
			)
		)
		True
	),
	fn ui =
	(
		rollout ro "Localize Scene By GTVFX" width:250 height:120
		(
			local self
			button btn_localize "Localize Scene" width:(ro.width - 20) height:40 tooltip:"Collects the current Max file and all scene dependencies and copies them to a localized folder."
			button btn_repath "Repath Scene Assets" width:(ro.width - 20) height:40 tooltip:"Sets the path of all scene assets to the fileAssets folder in the root directory of the Max file."
			hyperLink hyp_website "www.gtvfx.com" color:orange  hoverColor:red visitedColor:orange address:"http://www.gtvfx.com" pos:[(ro.width/2-40),(ro.height - 23)]
			fn _init pself =
			(
				self = pself
			)
			on ro help do
			(
				format "***** GTVFX: Help coming soon. *****\n"
			)
			on btn_localize pressed do
			(
				self.collectAssetData()
				self.collectFileAssets_FN()
				if self.repathFileAssetsToLocalFolder_FN self.localizedSceneFile then
				(
					if (queryBox "File localized successfully.\nOpen file location?") then
					(
						shellLaunch (getFileNamePath self.localizedSceneFile)  ""
					)
				)
			)
			on btn_repath pressed do
			(
				self.collectAssetData()
				self.repathFileAssetsToLocalFolder_FN (maxfilePath + maxFileName)
				loadMaxFile (maxfilePath + maxFileName) quiet:true
			)
		)
		createDialog ro
		ro._init self
	),
	fn _init =
	(
		self = this
		ui()
	),
	init = _init()
)
	
try(destroyDialog localizeScene.ro)catch()
localizeScene = localizeSceneStruct()
