/*
    Scenario: ConnectPlayersOnServer
*/

Main:
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    Loop, % API.GetNbWindows()
    {
        window := API.GetWindow(A_Index)

        ;Skip if already connected
        If (window.isConnected = True)
            Continue

        window.Activate()
        window.WaitActive()
        
        ;Get server slot position
        inputX := Scenario.GetValueFromIni(section, "x" window.account.ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" window.account.ServerSlot)
        If (!inputX || !inputY)
        {
            API.LogWrite("Couldn't load server slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load server slot position from INI, stopping current scenario.
            return
        }

        ;Connect on server
        SleepHandler(0)

        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2

        Sleep 500 ;Static sleep

        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows()*2)
    }

    ;-----------------------------------------------------------------
    Loop, % API.GetNbWindows()
    {
        window := API.GetWindow(A_Index)

        ;Skip if already connected
        If (window.isConnected = True)
            Continue

        window.Activate()
        window.WaitActive()

        ;Get player slot position
        inputX := Scenario.GetValueFromIni(section, "x" window.account.PlayerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" window.account.PlayerSlot)
        If (inputX = -1 || inputY = -1)
        {
            API.LogWrite("Couldn't load player slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load player slot position from INI, stopping current scenario.
            return
        }

        ;Connect player
        SleepHandler(0)

        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2

        API.GuiUpdateProgressBar(A_Index+ API.GetNbWindows(), API.GetNbWindows()*2)
    }

    API.GuiUpdateProgressBar(100)
return