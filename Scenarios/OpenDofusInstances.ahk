/*
    Scenario: OpenDofusInstances
*/

Main:
    API.GuiUpdateProgressText("Opening Dofus instances...")
    API.GuiUpdateProgressBar(0)

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()

    Loop % nbAccounts {
        If !ArrayAccounts[A_Index].IsActive
            Continue
        Run, % Settings.DofusPath
        API.GuiUpdateProgressBar(A_Index, nbAccounts)
        SleepHandler(0)
        sleep, 200 * Settings.Speed
        WinGet, window, ID, Dofus
        this_window := API.NewWindow(window)
        this_window.WaitOpen()
        this_window.SetTitle(ArrayAccounts[A_Index])
    }

    API.LogWrite("Successfully opened " . API.GetNbWindows() " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return