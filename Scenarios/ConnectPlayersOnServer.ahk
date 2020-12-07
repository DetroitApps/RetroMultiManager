/*
    Scenario: ConnectPlayersOnServer
*/

Main:
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight

    ; -------------
    ; Select server
    ; -------------
    Loop, % API.GetNbWindows()
    {
        DofusInstanceWindow := API.GetWindow(A_Index)

        ;Skip if already connected
        If (DofusInstanceWindow.isConnected = True)
            Continue

        DofusInstanceWindow.Activate()
        DofusInstanceWindow.WaitActive()
        
        ;Get server slot position
        inputX := Scenario.GetValueFromIni(section, "x" DofusInstanceWindow.account.ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" DofusInstanceWindow.account.ServerSlot)
        If (!inputX || !inputY)
        {
            API.LogWrite("Couldn't load server slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load server slot position from INI, stopping current scenario.
            return
        }

        ;Connect on server
        MouseMove, inputX, inputY, 5 * Settings.SpeedConnection
        Click, 2

        SleepHandler(-100)

        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows()*3)
    }

    ; -------------
    ; Select player
    ; -------------
    Loop, % API.GetNbWindows()
    {
        DofusInstanceWindow := API.GetWindow(A_Index)

        ;Skip if already connected
        If (DofusInstanceWindow.isConnected = True)
            Continue

        DofusInstanceWindow.Activate()
        DofusInstanceWindow.WaitActive()

        ;Get player slot position
        inputX := Scenario.GetValueFromIni(section, "x" DofusInstanceWindow.account.PlayerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" DofusInstanceWindow.account.PlayerSlot)
        If (inputX = -1 || inputY = -1)
        {
            API.LogWrite("Couldn't load player slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load player slot position from INI, stopping current scenario.
            return
        }

        ;Connect player
        MouseMove, inputX, inputY, 5 * Settings.SpeedConnection
        Click, 3

        SleepHandler(-100)

        API.GuiUpdateProgressBar(A_Index+ API.GetNbWindows(), API.GetNbWindows()*3)
    }

    
    ; -------------
    ; Update window
    ; -------------
    Loop, % API.GetNbWindows()
    {
        DofusInstanceWindow := API.GetWindow(A_Index)

        ;Skip if already connected
        If (DofusInstanceWindow.isConnected = True)
            Continue
        
        DofusInstanceWindow.SetTitle()
        DofusInstanceWindow.isConnected := True
        
        API.GuiUpdateProgressBar(A_Index + (API.GetNbWindows()*2), API.GetNbWindows()*3)
    }

    API.GuiUpdateProgressBar(100)
return