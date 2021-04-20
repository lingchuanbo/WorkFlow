fn replaceSub str1 str2 str3=(
    while ((i=findstring str1 str2) != undefined) do
    (
        str1 = replace str1 i str2.count str3
    )
    return str1
)

theName = "00000"

Prefix = ".tga"

str=maxfilename

strName=replaceSub str ".max" ""+"\\"

outPutDir=maxfilepath + strName
-- 创建文件夹
makeDir outPutDir

outPutFiledir =  maxfilepath + strName + theName + Prefix 

rendOutputFileName = outPutFiledir