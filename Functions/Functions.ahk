/*
    Main functions
*/

; Translation

Translate(key, args := 0, customLanguageFile := 0)
{
    ; Language file
    languageFolder := "Language"
    If !customLanguageFile
        languageFile := % languageFolder "\" Settings.Language ".ini"
    Else
        languageFile := % languageFolder "\" customLanguageFile ".ini"

    translatedText := TranslateX(key, languageFile)    
    ;Deal with error
    If (translatedText = 0)
    {
        If Settings.Dev {
            Loop {
                MsgBox, % MBICON["Error"] + MBBTN["AbortRetryIgnore"], Error, Can't find language file "%languageFile%" or missing string for key {%key%}. Press Ignore to continue anyway.
                IfMsgBox, Abort
                    ExitApp
                IfMsgBox, Retry
                    TranslateX(key, languageFile)
                Else
                    break
            }
        }
        return % "{" key "}"
    }

    ;check and replace args ({1}, {2}, ...)
    If args
        Loop % args.MaxIndex()
            translatedText := TranslateReplaceArgs(translatedText, args[A_Index], A_Index)
    return translatedText
}

TranslateX(ByRef key, ByRef languageFile)
{
    IniRead, readValue, %languageFile%, Strings, %key%, 0
    
    If (readValue = 0)
        return readValue

    translatedText := readValue
    
    ;Check for multiline message (key2, key3 etc...)
    i := 2
    Loop {
        IniRead, readValue, %languageFile%, Strings, %key%%i%, 0
        If (readValue = 0)
            return translatedText
        Else
            translatedText := translatedText . "`n" . readValue
        i++
    }
}

TranslateReplaceArgs(textToParse, Byref var, ByRef index)
{
    If InStr(textToParse, "{" . index . "}")
        return StrReplace(textToParse, "{" . index . "}", var)
    return textToParse
}

TranslateError()
{

}

; Misc

ScreenCompatible() {
    MsgBox, 35, OCR, Your resolution is compatible with OCR. Would you like to download a preset of images from GitHub (less than 8 ko) ?
    IfMsgBox Yes
    {
        Gosub, DownloadOCRPreset
        return True
    }
    IfMsgBox No
        return False
    IfMsgBox Cancel
        ExitApp
}

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

ExitGracefully(){
    Logger.Write("Program exited gracefully with " . Logger.TotalWarning . " warning and " . Logger.TotalErrors . " errors.")
    Logger.CloseLogFiles()
    ExitApp
}