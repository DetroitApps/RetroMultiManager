/*
    Scenario: ConnectPlayersOnServer
*/

Main:
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    Loop, % API.GetNbWindows() {

        ;Get value for server slot
        inputX := Scenario.GetValueFromIni(section, "x" ArrayAccounts[A_Index].ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" ArrayAccounts[A_Index].ServerSlot)
        If (inputX = -1 || inputY = -1)
        {
            API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
            return
        }

        window := API.GetWindow(A_Index)
        window.Activate()
        window.WaitActive()

        ;Connect on server
        Sleep 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2
        Sleep 1500

        ;Get value for player slot
        If (ArrayAccounts[A_Index].ServerSlot != ArrayAccounts[A_Index].PlayerSlot)
        {
            inputX := Scenario.GetValueFromIni(section, "x" ArrayAccounts[A_Index].PlayerSlot)
            inputY := Scenario.GetValueFromIni(section, "y" ArrayAccounts[A_Index].PlayerSlot)
            If (inputX = -1 || inputY = -1)
            {
                API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
                return
            }
            MouseMove, inputX, inputY, 5 * Settings.Speed
        }

        ;Connect player
        Sleep 50 * Settings.Speed
        Click, 2
        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows())
        Sleep 500
    }

    API.LogWrite("Successfully connected " API.GetNbWindows() " characters.")
    API.GuiUpdateProgressBar(100)
return