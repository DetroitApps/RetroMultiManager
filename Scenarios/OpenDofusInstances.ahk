Main:
    GUI_UpdateText("Opening Dofus instances...")
    GUI_UpdateBar(0)

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()

    i := 1
    Loop % nbAccounts {
        If !ArrayAccounts[i].IsActive
            Continue
        Run, % oSettings.DofusPath,,, pid
        API.WindowList[i] := New API.Window(pid)
        API.WindowList[i].WaitOpen()
        API.WindowList[i].SetTitle(ArrayAccounts[i])
        GUI_UpdateBar(i, nbAccounts)
        SleepHandler(0)
        i++
    }
    API.LogWrite("Successfully opened " . nbAccounts " windows.")
    GUI_UpdateBar(100)
    GUI_UpdateText("Done.")
    return