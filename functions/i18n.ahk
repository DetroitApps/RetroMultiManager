/*
    Internationalisation related functions
*/

Translate(key, args := 0, customLanguageFile := 0)
{
    ; Language file
    languageFolder := "Resources\i18n"
    If !customLanguageFile
        languageFile := % languageFolder "\" Settings.Language ".ini"
    Else
        languageFile := % languageFolder "\" customLanguageFile ".ini"

    If !FileExist(languageFile)
    {
        MsgBox, % MBICON["Error"] + MBBTN["RetryCancel"], Fatal Error, % "Couldn't load language file '" languageFile "'. Program aborted."
        IfMsgBox, Retry
            Translate(key, args, customLanguageFile)
        Else
            ExitApp
    }

    translatedText := TranslateX(key, languageFile)    
    ;Deal with error
    If !translatedText
    {
        If Settings.Dev {
            Loop {
                If translatedText
                    break
                MsgBox, % MBICON["Error"] + MBBTN["AbortRetryIgnore"], Error, % "File " languageFile " is missing string for key {" key "}.`nPress Ignore to continue anyway."
                IfMsgBox, Abort
                    ExitApp
                IfMsgBox, Retry
                    translatedText := TranslateX(key, languageFile)
                Else
                    return % "{" key "}"
            }
        }
        Else
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
    IniRead, readValue, %languageFile%, Strings, %key%, %A_Space%
    
    If !readValue
        return readValue

    translatedText := readValue
    
    ;Check for multiline message (key2, key3 etc...)
    i := 2
    Loop {
        IniRead, readValue, %languageFile%, Strings, %key%%i%, %A_Space%
        If !readValue
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
