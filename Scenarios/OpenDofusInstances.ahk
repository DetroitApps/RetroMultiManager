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
        Run, % Settings.DofusPath,,, pid
        window := API.NewWindow(pid)
        window.WaitOpen()
        window.SetTitle(ArrayAccounts[A_Index])
        API.GuiUpdateProgressBar(A_Index, nbAccounts)
        SleepHandler(0)
    }
    API.LogWrite("Successfully opened " . API.GetNbWindows() " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return