/*
    Scenario LoginAccounts
    Will perform one OCR scan to find account input. 
    If it fails, it tries to load from default values (TO DO)
*/

LoginAccounts:
    inputX := 0
    inputY := 0
    
    GUI_UpdateBar(0)
    Loop, % API.GetTotalWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        window.Maximize()
        Sleep, 50 * oSettings.Speed
        If (A_Index = 1)
        {
            If (oSettings.EnableOCR = True)
                Gosub, GetAccountInputPosition
            If (!inputX || !inputY || inputX = 0 || inputY = 0)
            {
                Logger.WriteError("LoginAccounts: OCR failed or disabled. Trying to get account input position from default settings.")
                IniRead, inputX, Resources\%A_ScreenHeight%p\window.ini, InputAccount, x, 0
                IniRead, inputY, Resources\%A_ScreenHeight%p\window.ini, InputAccount, y, 0
                If (inputX = "0" || inputY = "0")
                {
                    Logger.WriteError("LoginAccounts: Couldn't load account input position from INI, stopping current scenario.", 1)
                    return
                }
            }
            Else
                Logger.Write("LoginAccounts: Image successfully found with position [." . inputX . "," . inputY . "].")
        }
        MouseMove, inputX, inputY + 70, 5 * oSettings.Speed
        Click
        Sleep, 50 * oSettings.Speed
        SendRaw, % API.GetUsername(A_Index)
        Sleep, 50 * oSettings.Speed
        Send, {Tab}
        Sleep, 50 * oSettings.Speed
        SendRaw, % API.GetPassword(A_Index)
        Sleep, 50 * oSettings.Speed
        Send, {Tab}
        Sleep, 50 * oSettings.Speed
        ;Send {Enter}
        GUI_UpdateBar(A_Index, API.GetTotalWindows())
        SleepHandler(0) ;handle sleep based on speed settings (parameter is for added sleep)
    }
    GUI_UpdateBar(100)
    return

GetAccountInputPosition:
    MouseMove, 0, 0
    Sleep 1000 * oSettings.Speed
    API.SearchImageInWindow("account.png", inputX, inputY)
    Sleep 1500 * oSettings.Speed
    return