(
	try
	(
		local iniFile = pathConfig.GetDir #userscripts+"\\miauuScriptPack_Vol2\\miauuSnapsINI.ini"
		if doesFileExist iniFile do
		(
			if ((getINISetting iniFile "Rollout" "RunAtStartup") as booleanClass) == true do
			(
				fileIn (pathConfig.GetDir #userscripts+"\\miauuScriptPack_Vol2\\miauuSP_vol2_SnapsTool.mse")
			)
		)
	)catch()
)