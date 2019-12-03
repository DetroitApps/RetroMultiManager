/*
    Scenario: ConnectPlayersOnServer
*/

Main:
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    i := 1
    Loop, % API.GetNbWindows()
    {
        window := API.GetWindow(A_Index)

        ;Skip if already connected
        If (window.isConnected = True)
            Continue
        
        ;Get server slot position
        inputX := Scenario.GetValueFromIni(section, "x" window.account.ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" window.account.ServerSlot)
        If (!inputX || !inputY)
        {
            API.LogWrite("Couldn't load server slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load server slot position from INI, stopping current scenario.
            return
        }

        window.Activate()
        window.WaitActive()

        ;Connect on server
        Sleep 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2

        Sleep 1500 ;Static sleep

        ;Get player slot position
        If (window.account.ServerSlot != window.account.PlayerSlot) ; this avoid useless reads from INI if the slots are the same
        {
            inputX := Scenario.GetValueFromIni(section, "x" window.account.PlayerSlot)
            inputY := Scenario.GetValueFromIni(section, "y" window.account.PlayerSlot)
            If (inputX = -1 || inputY = -1)
            {
                API.LogWrite("Couldn't load player slot position from INI, stopping current scenario.", 2)
                MsgBox, 16, Error, Couldn't load player slot position from INI, stopping current scenario.
                return
            }
            MouseMove, inputX, inputY, 5 * Settings.Speed
        }

        ;Connect player
        Sleep 50 * Settings.Speed
        Click, 2

        window.isConnected := True

        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows())
        i++
        SleepHandler(0)
    }

    API.GuiUpdateProgressBar(100)
return