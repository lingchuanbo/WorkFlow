-- 【public】获取ini文件的内容
-- @param file： 文件名
-- @param topic：节点
-- @param key：  关键字
-- @param val：  需要获取的内容
function getLocalINIValue file topic key =
(   
	local val = undefined
	if doesFileExist file then
	(
		val = getINISetting file topic key
	)
)

-- 【public】设置ini文件的内容
-- @param filePath： 文件路径
-- @param filename： 文件名
-- @param topic：    节点
-- @param key：      关键字
-- @param val：      内容
function setLocalINIValue filePath fileName topic key val =
(   
	makedir filePath --没有路径文件夹时生成该文件夹
    local file = filePath + fileName
	setINISetting file topic key val
)

--设置本地环境$maxScripts.
--读取workflow ini地址
evnPath=getLocalINIValue "E:\BoBOAHK\Vimdesktop\config.ini" "config" "MaxScripts"

if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" evnPath
symbolicPaths.setUserPathValue "$maxScripts" evnPath
