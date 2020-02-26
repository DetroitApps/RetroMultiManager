/*
    Main functions
*/

; Misc

ResolutionNotSupported() {
    MsgBox 0x31, % Translate("ResolutionNotSupportedTitle"), % Translate("ResolutionNotSupportedMsg", A_ScreenWidth, A_ScreenHeight)

    IfMsgBox Cancel, {
        ExitApp
    }
}

SetMasterPassword() {
    InputBox, password, % Translate("MasterPasswordTitle"), % Translate("MasterPasswordMsg"),hide,,130
    If (ErrorLevel)
        ExitApp
    Else If (password = "")
    {
        MsgBox, 49, Translate("Error"), % Translate("EmptyMasterPasswordError")
        IfMsgBox Ok
            SetMasterPassword()
        IfMsgBox Cancel
            ExitApp
    }
    Else
        return password
}

SleepHandler(addedSleep){
    global

    local step := 750 ;each speed mode will add or decrease initial value based on step
    local defaultSleep := 50
    speed := addedSleep + defaultSleep + ((Settings.Speed - 1) * step)
    Sleep speed
}

CheckForUpdates(){
    UrlDownloadToFile, https://raw.githubusercontent.com/DetroitApps/RetroMultiManager/master/version.txt, githubVersion.txt ; kind of hardcoded
    FileRead, githubVersion, githubVersion.txt
    FileRead, localVersion, version.txt
    githubVersion := Trim(githubVersion, OmitChars := " `n")
    localVersion := Trim(localVersion, OmitChars := " `n")
    If (githubVersion != localVersion)
    {
        MsgBox, % 68, % Translate("UpdateFoundTitle"), % Translate("UpdateFoundMsg", localVersion, githubVersion)
        IfMsgBox, Yes
            Run, https://github.com/DetroitApps/RetroMultiManager/releases
    }
    FileDelete, githubVersion.txt
}