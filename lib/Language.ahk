curver = 1.0 ; 声明当前版本
IfNotExist, config.ini
IniWrite, CN, config.ini, config, Language
else
IniRead, Language, config.ini, config, Language
; if (A_Language = "0804")
If Language=CN
{
    global _AppName:="WorkFlows"
    global _Welcome:="欢迎使用"
    global _Author:="BoBO"
    global _Authors="BoBO(lingchuanbo@gmail.com)" 
    global _Exit="退出"
    global _Restart="重启"
    global _Path="路径配置"
    global _Updating="正在更新 WorkFlows"
    global _Updater="更新主程序"
    global _UpdatPlugins="更新插件"
    global _UpdateCompleted="更新成功"
    global _AeUpdating="正在更新AfterEffect..."
    global _MaxUpdating="正在更新3DsMax..."
    global _HotKeyManagement="热键管理"
    global _aboutMe="关于我"
    global _BackupRestore="备份还原config.ini"

    global _VIMMode:="进入 WorkFlows"
    global _ExitVIMMode:="退出 WorkFlows"
    

    global _StartUp="开机自启"
    global _Config="配置快捷键"
    global _Help="  帮助文档"
    global _Feedback="  反馈与建议"
    global _Web="  官网"
    global _Update="  更新"
    global _Language = "语言(&L)"

    global _PoorNetwork="与 网络 连接不畅！请稍后再试。"
    global _ConfirmExit="遇到问题？请尝试下列解决方法！`n`n1. 阅读帮助文档`n2. 重启 WorkFlows`n3. 更新 WorkFlows`n4. 反馈您的问题`n`n仍然退出 WorkFlows？"
    ;Plugins_Photoshop
    global _Photoshop_OpenSave = "打开&关闭"
    global _Photoshop_NewFile ="创建新文件"

    global _AutoUpdate ="正在更新插件，更新完毕自动重启脚本！"
    ;Ctrl+C  Ctrl+C加强
    global _searchGoogle = "谷歌搜索"
    global _searchDogeDoge = "狗狗搜索"
    global _googleTranslateCn = "谷歌翻译成中文"
    global _googleTranslateEn = "谷歌翻译成英文"

    global _Base64En = "Base64加密"
    global _Base64De = "Base64解密"
    global _QR = "生成二维码"
}
; if ( A_Language != "0404" and A_Language != "0804" )
Else
{

    global _AppName:="WorkFlows"
    global _Welcome:="Welcome Use..."
    global _Authors="BoBOlingchuanbo@gmail.com"
    

    global _MaxUpdating="Update 3DsMax..."
    global _UpdateCompleted="Update Completed"
    global _Path="Path Config"
    global _HotKeyManagement="Hot Key Management"

    global _Exit="Exit"
    global _Restart="Restart"
    global _Updater="Check for Update"
    global _Updating="Updating"
    global _AeUpdating="Update AfterEffect..."
    global _MaxUpdating="Update 3DsMax..."
    global _UpdateCompleted="Update Completed"

    global _StartUp="Start VIMD on system startup"
    global _Config="WorkFlows Configure"
    global _Help="WorkFlows Help"
    global _Feedback="Feedback and Request"
    global _Language = "&Language"

    global _PoorNetwork="Poor connection with Internet! Please try again later."
    global _ConfirmExit="Encountered an issue? Please try these solutions!`n`n1. Read the help file`n2. Restart VIMD`n3. Update VIMD`n4. Report the issue`n`nExit Vimdesktop anyway?"

    global _Photoshop_OpenSave ="OpenSave"
    global _Photoshop_NewFile :="NewFile"

    global _VIMMode:="Enter WorkFlows"
    global _ExitVIMMode:="Exit WorkFlows"
}