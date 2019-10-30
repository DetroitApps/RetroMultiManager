/*
    Scenario: ConnectPlayersOnServer
*/

Main:
    section := A_ScreenWidth . "x" . A_ScreenHeight
    inputX := Scenario.GetValueFromIni(section, "Server1_x")
    inputY := Scenario.GetValueFromIni(section, "Server1_y")

    API.GuiUpdateProgressBar(0)
    Loop, % API.GetNbWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        window.WaitActive()

        Sleep 50 * Settings.Speed
        MouseMove, inputX, inputY, 5 * Settings.Speed
        Click, 2
        Sleep 600 * Settings.Speed
        Click, 2
        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows())
        SleepHandler(0)
    }
    API.LogWrite("Successfully connected " API.GetNbWindows() " characters.")
    API.GuiUpdateProgressBar(100)
return