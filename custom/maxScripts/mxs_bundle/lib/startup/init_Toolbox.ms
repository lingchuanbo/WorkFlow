mxs.Using "Toolbox"
mxs.Using "Toolbox_Callbacks"

if ::gtb.startUp then
(
	::gtb.run()
	if ( DoesFileExist ::gtb.gtbINI ) then
	(
		::gtb.updateUI_FN()
	)
	else
	(
		::gtb.saveUI_FN()
		::gtb.updateUI_FN()
	)
)
else
(
	format "***** Toolbox initialized without UI *****\n"
)