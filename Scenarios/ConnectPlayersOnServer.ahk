/*
    Scenario: ConnectPlayersOnServer
*/

Main:
    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    i := 1
    Loop, % API.GetTotalAccounts() {
        ;Skip unactive accounts
        If !ArrayAccounts[A_Index].IsActive
        {
            API.LogWrite("Skipping character #" A_Index ", marked as inactive.")
            Continue
        }
        API.LogWrite("Trying to connect character #" A_Index " on server slot " ArrayAccounts[A_Index].ServerSlot " and player slot " ArrayAccounts[A_Index].PlayerSlot ".")        
        ;Get value for server slot
        inputX := Scenario.GetValueFromIni(section, "x" ArrayAccounts[A_Index].ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" ArrayAccounts[A_Index].ServerSlot)
        If (!inputX || !inputY)
        {
            API.LogWrite("Couldn't load server slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load server slot position from INI, stopping current scenario.
            return
        }

        window := API.GetWindow(i)
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
                API.LogWrite("Couldn't load player slot position from INI, stopping current scenario.", 2)
                MsgBox, 16, Error, Couldn't load player slot position from INI, stopping current scenario.
                return
            }
            MouseMove, inputX, inputY, 5 * Settings.Speed
        }

        ;Connect player
        Sleep 50 * Settings.Speed
        Click, 2
        API.GuiUpdateProgressBar(i, API.GetNbWindows())
        i++
        Sleep 1500
    }

    API.LogWrite("Successfully connected " i - 1 " characters.")
    API.GuiUpdateProgressBar(100)
return