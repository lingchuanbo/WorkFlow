curver = 1.0 ; 声明当前版本
IfNotExist, config.ini
IniWrite, CN, config.ini, config, Language
else
IniRead, Language, config.ini, config, Language
; if (A_Language = "0804")
If Language=CN
{
    vim.Comment("<GoogleChrome_SwithMode>", "切换模式")
    vim.Comment("<GoogleChrome_下载>", "下载列表")
    vim.Comment("<Google_搜索>", "搜索") 
    vim.Comment("<Google_刷新>", "刷新/双击强制刷新")
    vim.Comment("<GoogleChrome_无痕>", "无痕Chrome")
    vim.Comment("<GoogleChrome_清除浏览数据>", "清除浏览数据")
    vim.Comment("<GoogleChrome_OpenGoogle>", ".. Google")
    vim.Comment("<GoogleChrome_OpenYoutube>", ".. Youtube")
    vim.Comment("<GoogleChrome_OpenTranslate>", ".. 谷歌翻译")
    vim.Comment("<GoogleChrome_OpenDogeDoge>", ".. 中文搜索")
}
else
{
    vim.Comment("<GoogleChrome_SwithMode>", "切换模式")
    vim.Comment("<GoogleChrome_下载>", "下载列表")
    vim.Comment("<Google_搜索>", "搜索") 
    vim.Comment("<Google_刷新>", "刷新/双击强制刷新")
    vim.Comment("<GoogleChrome_无痕>", "无痕Chrome")
    vim.Comment("<GoogleChrome_清除浏览数据>", "清除浏览数据")
    vim.Comment("<GoogleChrome_OpenGoogle>", ".. Google")
    vim.Comment("<GoogleChrome_OpenYoutube>", ".. Youtube")
    vim.Comment("<GoogleChrome_OpenTranslate>", ".. 谷歌翻译")
    vim.Comment("<GoogleChrome_OpenDogeDoge>", ".. 中文搜索")
}

 