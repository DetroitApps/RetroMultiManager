/*
    Scenario: OpenDofusInstances
*/

Main:
    API.GuiUpdateProgressBar(0, 3)
    API.GuiUpdateProgressText("Opening Dofus instances...")

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()

    Loop % nbAccounts {
        If !ArrayAccounts[A_Index].IsActive
            Continue
        Run, % Settings.DofusPath
        SleepHandler(0)
    }
    
    API.GuiUpdateProgressBar(1, 3)
    API.GuiUpdateProgressText("Waiting for all window(s)...")
    maxTry := 10
    i := 0
    WinGet, windows, List, Dofus

    ;Wait for all account to be ready to login
    While, windows != nbAccounts And i <= maxTry {
        WinGet, windows, List, Dofus
        API.LogWrite("Wait for all account to be ready to login (" i "/" maxTry ")")
        i := i + 1
        SleepHandler(0)
    }
    
    ;If a window wasn't found after timeout, raise Exception
    if (i > maxTry) {
        API.LogWrite("Only " windows " window(s) opened, " nbAccounts " expected")
        MsgBox, An error has occured : Only %windows% window(s) opened, %nbAccounts% expected
        return
    }

    API.GuiUpdateProgressBar(2, 3)
    API.GuiUpdateProgressText("Saving windows state...")

    ;Save all Dofus instances
    Loop % windows {
        API.SaveWindow(windows%A_Index%, A_Index)
        API.getWindow(A_Index).SetTitle(ArrayAccounts[A_Index], A_Index)
        API.LogWrite("Successfully opened '" . API.getUsername(A_Index) "' windows.")
    }

    API.GuiUpdateProgressBar(3, 3)
    API.GuiUpdateProgressText("Done.")
    return