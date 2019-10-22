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
