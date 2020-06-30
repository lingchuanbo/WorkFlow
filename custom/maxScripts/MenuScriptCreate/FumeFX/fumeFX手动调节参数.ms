-- 存放路径
Dir="D:\\maxFxDate\\FumeFX\\22061\\walk\\脚\\3"
-- 创建目录
makeDir(Dir)all:true
-- FX保存格式
setPath=Dir+"\\a.fxd"

for obj in selection do
(
    obj.SetPath setPath #("default", "nocheck")
    obj.SetPath setPath #("wavelet", "nocheck")
    obj.SetPath setPath #("retimer", "nocheck")
    obj.SetPath setPath #("illummap", "nocheck")
)



 
 