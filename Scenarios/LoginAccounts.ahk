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
        API.LogWrite("Trying to connect account #" A_Index ".")

        DofusInstanceWindow := API.GetWindow(A_Index)
        If (DofusInstanceWindow.isConnected = True)
        {
            API.LogWrite("Skipping window #" A_Index ", already connected.")
            Continue
        }
        
        If (Settings.WaitForAnkamaShield = True)
            MsgBox, % Translate("UnlockShield", API.GetUsername(A_Index))

        DofusInstanceWindow.Activate()
        DofusInstanceWindow.WaitActive()
        DofusInstanceWindow.Maximize()

        ;Username
        Sleep, 100 * Settings.SpeedConnection
        MouseMove, inputX, inputY, 5 * Settings.SpeedConnection
        Click
        Sleep, 50 * Settings.SpeedConnection
        Send, ^a
        Sleep, 50 * Settings.SpeedConnection
        SendRaw, % DofusInstanceWindow.account.username
        Sleep, 50 * Settings.SpeedConnection

        ;Password
        Send, {Tab}
        Sleep, 50 * Settings.SpeedConnection
        SendRaw, % DofusInstanceWindow.account.password
        Sleep, 50 * Settings.SpeedConnection
        Send, {Tab}
        Sleep, 50 * Settings.SpeedConnection
        Send {Enter}
        API.GuiUpdateProgressBar(i, API.GetNbWindows())
        i++
        SleepHandler(0)
    }
    API.GuiUpdateProgressBar(100)
    return