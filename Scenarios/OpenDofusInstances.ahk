/*
    Scenario: OpenDofusInstances
*/

Main:
    API.GuiUpdateProgressText("Opening Dofus instances...")
    API.GuiUpdateProgressBar(0)

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()

    i := 1
    Loop % nbAccounts {
        If !ArrayAccounts[i].IsActive
            Continue
        Run, % Settings.DofusPath,,, pid
        API.WindowList[i] := New API.Window(pid)
        API.WindowList[i].WaitOpen()
        API.WindowList[i].SetTitle(ArrayAccounts[i])
        API.GuiUpdateProgressBar(i, nbAccounts)
        SleepHandler(0)
        i++
    }
    API.LogWrite("Successfully opened " . nbAccounts " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return