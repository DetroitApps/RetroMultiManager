/*
    Main functions
*/

#Include src\functions\i18n.ahk

; Misc

ResolutionNotSupported() {
    MsgBox 0x31, Resolution not supported, You resolution %A_ScreenWidth%x%A_ScreenHeight% is currently not supported.`n`nPlease refer to the GitHub for more information.

    IfMsgBox Cancel, {
        ExitApp
    }
}
*/

SetMasterPassword() {
    InputBox, password, Master Password,Type your master password:,hide,,130
    If (ErrorLevel)
        ExitApp
    Else If (password = "")
    {
        MsgBox, 49, Error, % "Master password can't be empty. `nPress Ok to retry."
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

    local step := 500 ;each speed mode will add or decrease initial value based on step
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
        MsgBox, % 68, Update found, An update exists!`nCurrentVersion: %localVersion%`nNew version: %githubVersion%`nWould you like to visit GitHub release page ?
        IfMsgBox, Yes
            Run, https://github.com/DetroitApps/RetroMultiManager/releases
    }
    FileDelete, githubVersion.txt
}