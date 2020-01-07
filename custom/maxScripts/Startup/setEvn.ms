--设置本地环境$maxScripts.
    --读取workflow ini地址
    evnPath="F:\BoBOAHK\WorkFlow\custom\maxScripts"

    if symbolicPaths.isUserPathName "$maxScripts" == false do symbolicPaths.addUserPath "$maxScripts" evnPath
    symbolicPaths.setUserPathValue "$maxScripts" evnPath