/*
    Scenario: OpenDofusInstances
*/

Main:
    API.GuiUpdateProgressBar(0, 3)
    API.GuiUpdateProgressText("Opening Dofus instances...")

    API.ClearWindowList()
    nbAccounts := API.GetNbAccounts()

    i := 1
    Loop % nbAccounts {
        If !ArrayAccounts[A_Index].IsActive
            Continue
        Run, % Settings.DofusPath
        API.GuiUpdateProgressBar(A_Index, nbAccounts)
        SleepHandler(0)
        sleep, 200 * Settings.Speed
        WinGet, window, ID, Dofus
        this_window := API.NewWindow(window, ArrayAccounts[A_Index])
        this_window.WaitOpen()
        this_window.SetTitle(ArrayAccounts[A_Index])
        API.AddWindowToListView(i)
        i++
    }

    API.LogWrite("Successfully opened " i " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return