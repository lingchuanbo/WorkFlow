
mxs.Using "Menu_Lib"

(
	local menuDir = (( ::mxs.GetCodePath() ) + @"\lib\userinterface\menus\" )
	
	global MXS_MENUS = ::Menu_Lib sourceDir:menuDir defaultCategory:"mxs" strGlobal:"MXS_MENUS"
)