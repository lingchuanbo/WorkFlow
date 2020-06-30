-- FumeFX缓存路径设置
-- 支持多选FumeFX

-- 需要ui需要激活
-- try(destroyDialog rol_Browse)catch()
-- rollout rol_Browse "FumeFX缓存路径设置.BoBO"
-- (
   -- button btn_browse "选择路径"
 
   -- on btn_browse pressed do
   -- (
     dir = getSavePath caption:"Select Folder" initialDir:#images
     if dir != undefined do
     (
        allFiles = getFiles (dir + "\\a.fxd")
        -- print allFiles
        Path = dir + "\\a.fxd"
        for obj in selection do
        (
            obj.SetPath Path #("default", "nocheck")
            obj.SetPath Path #("wavelet", "nocheck")
            obj.SetPath Path #("retimer", "nocheck")
            obj.SetPath Path #("illummap", "nocheck")
        )
      )
   -- )
-- )
-- createDialog rol_Browse
-- 需要ui需要激活

-- -- 存放路径
-- Dir="D:\\maxFxDate\\FumeFX\\22061\\walk\\脚\\3"
-- -- 创建目录
-- makeDir(Dir)all:true
-- -- FX保存格式
-- setPath=Dir+"\\a.fxd"

-- for obj in selection do
-- (
--     obj.SetPath setPath #("default", "nocheck")
--     obj.SetPath setPath #("wavelet", "nocheck")
--     obj.SetPath setPath #("retimer", "nocheck")
--     obj.SetPath setPath #("illummap", "nocheck")
-- )


 