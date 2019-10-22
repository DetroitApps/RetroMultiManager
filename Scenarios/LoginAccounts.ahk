/*
    Scenario: LoginAccounts
    Will perform one OCR scan to find account input. 
    If it fails, it tries to load from default values (TO DO)
*/

Main:
    inputX := 0
    inputY := 0
    
    API.GuiUpdateProgressBar(0)
    Loop, % API.GetTotalWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        window.Maximize()
        Sleep, 50 * Settings.Speed
        If (A_Index = 1)
        {
            If (Settings.EnableOCR = True)
                Gosub, GetAccountInputPosition
            If (!inputX || !inputY || inputX = 0 || inputY = 0)
            {
                API.LogWrite("OCR failed or disabled. Trying to get account input position from default settings.", 1)
                ;Scenario.
                section := A_ScreenWidth . "x" . A_ScreenHeight
                IniRead, inputX, Scenarios\OpenDofusInstances.ini, %section%, x, 0
                IniRead, inputY, Scenarios\OpenDofusInstances.ini, %section%, y, 0
                If (inputX = "0" || inputY = "0")
                {
                    API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
                    return
                }
                Else 
                    API.LogWrite("IniRead found input with position [" . inputX . "," . inputY . "].")
            }
            Else
            {
                API.LogWrite("OCR found match with position [" . inputX . "," . inputY . "].")
                inputY += 70 ; might not work for every resolution, to be tested!
            }
        }
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click
        Sleep, 50 * Settings.Speed
        SendRaw, % API.GetUsername(A_Index)
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        SendRaw, % API.GetPassword(A_Index)
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        ;Send {Enter}
        API.GuiUpdateProgressBar(A_Index, API.GetTotalWindows())
        SleepHandler(0) ;handle sleep based on speed settings (parameter is for added sleep)
    }
    API.GuiUpdateProgressBar(100)
    return

GetAccountInputPosition:
    MouseMove, 0, 0
    Sleep 1000 * Settings.Speed
    API.SearchImageInWindow("account" . A_ScreenWidth . "x" . A_ScreenHeight . ".png", inputX, inputY)
    Sleep 1500 * Settings.Speed
    return