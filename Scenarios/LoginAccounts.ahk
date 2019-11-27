/*
    Scenario: LoginAccounts
*/

Main:
    inputX := 0
    inputY := 0
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    inputX := Scenario.GetValueFromIni(section, "x")
    inputY := Scenario.GetValueFromIni(section, "y")
    If (!inputX || !inputY)
    {
        API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
        MsgBox, 16, Error, Couldn't load account input position from INI, stopping current scenario.
        return
    }
    i := 1
    Loop, % API.GetTotalAccounts() {
        ;Skip unactive accounts
        If !ArrayAccounts[A_Index].IsActive
        {
            API.LogWrite("Skipping account #" A_Index ", marked as inactive.")
            Continue
        }
        If (Settings.WaitForAnkamaShield = True)
            MsgBox, % Translate("UnlockShield", API.GetUsername(A_Index))
        API.LogWrite("Trying to connect account #" A_Index ".")
        window := API.GetWindow(i)
        window.Activate()
        window.WaitActive()
        window.Maximize()
        Sleep, 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click
        Sleep, 50 * Settings.Speed
        Send, ^a
        Sleep, 50 * Settings.Speed
        SendRaw, % API.GetUsername(A_Index)
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        SendRaw, % API.GetPassword(A_Index)
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        Send {Enter}
        API.GuiUpdateProgressBar(i, API.GetNbWindows())
        i++
        SleepHandler(0) ;handle sleep based on speed settings (parameter is for added sleep)
    }
    API.GuiUpdateProgressBar(100)
    return