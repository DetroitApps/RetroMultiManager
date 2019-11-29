/*
    Scenario: LoginAccounts
*/

Main:
    API.GuiUpdateProgressBar(0)

    inputX := 0
    inputY := 0
    section := A_ScreenWidth . "x" . A_ScreenHeight
    inputX := Scenario.GetValueFromIni(section, "x")
    inputY := Scenario.GetValueFromIni(section, "y")
    If (!inputX || !inputY)
    {
        API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
        MsgBox, 16, Error, Couldn't load account input position from INI, stopping current scenario.
        return
    }

    Loop, % API.GetNbWindows() {
        If (Settings.WaitForAnkamaShield = True)
            MsgBox, % Translate("UnlockShield", API.GetUsername(A_Index))
        API.LogWrite("Trying to connect account #" A_Index ".")
        window := API.GetWindow(A_Index)
        window.Activate()
        window.WaitActive()
        window.Maximize()
        Sleep, 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click
        Sleep, 50 * Settings.Speed
        Send, ^a
        Sleep, 50 * Settings.Speed
        SendRaw, % window.account.username
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        SendRaw, % window.account.password
        Sleep, 50 * Settings.Speed
        Send, {Tab}
        Sleep, 50 * Settings.Speed
        Send {Enter}
        API.GuiUpdateProgressBar(i, API.GetNbAccounts())
        i++
        SleepHandler(0)
    }
    API.GuiUpdateProgressBar(100)
    return