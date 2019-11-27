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
    }

    WinGet, windows, List, Dofus
    i := windows
    Loop, %windows%
    {
        this_window := windows%i%
        win := API.NewWindow(this_window)
        win.WaitOpen()
        win.SetTitle(ArrayAccounts[A_Index])
        i--
    }

    API.LogWrite("Successfully opened " . API.GetNbWindows() " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return