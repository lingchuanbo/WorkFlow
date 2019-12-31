Fn SetDefaultLanguageToChinese = 
(
    if (MaxVersion() )[1] >= 15000 do
    if "2052" != GetINISetting (GetMAXIniFile()) "File Language Options" "LanguageToUseForFileIO" do 
    (
        DialogMonitorOPS.UnRegisterNotification id:#SetDefaultLanguageToChinese
        Fn DialogMonitorCallBackSetDefaultLanguageToChinese = 
        (
            currentHandle = DialogMonitorOPS.GetWindowHandle()
            if "Preference Settings" == UIAccessor.GetWindowText currentHandle do
            (
                languageNames = #("Chinese","English","German","French","japanese","Korean","Current")
                childrens = Windows.getChildrenHWND currentHandle
                
                languageLabel = undefined 
                for tempControl in childrens where tempControl[5] == "Default Language:" do 
                (
                    languageLabel = tempControl
                )
                if languageLabel != undefined do
                for tempControl in childrens where 
                (
                    tempControl[2]==languageLabel[2] and \
                    tempControl[3]==languageLabel[3]  and \
                    "ComboBox" == tempControl[4] and \
                    FindItem languageNames tempControl[5] != 0
                )
                do
                (
                    UIAccessor.SendMessage tempControl[1] 0x014E 6 0
                )
                UIAccessor.SendMessageID currentHandle #IDOK
            )
            true
        )
        DialogMonitorOPS.RegisterNotification DialogMonitorCallBackSetDefaultLanguageToChinese id:#SetDefaultLanguageToChinese
        DialogMonitorOPS.Enabled = true
        DialogMonitorOPS.ShowNotification()
        max file preferences
        DialogMonitorOPS.UnRegisterNotification id:#SetDefaultLanguageToChinese
        DialogMonitorOPS.Enabled = false
    )
)
SetDefaultLanguageToChinese()