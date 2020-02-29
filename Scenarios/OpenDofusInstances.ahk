/*
    Scenario: OpenDofusInstances
*/

Main:
    API.GuiUpdateProgressBar(0, 3)
    API.GuiUpdateProgressText("Opening Dofus instances...")

    nbAccounts := API.GetNbAccounts()

    i := 1
    Loop % nbAccounts {
        ;Skip if account is set as inactive
        If !ArrayAccounts[A_Index].IsActive
            Continue
        
        ;Skip if window already exists for the same account
        If (API.WindowExists(ArrayAccounts[A_Index]) <> -1)
        {
            API.LogWrite("Skipping account #" A_Index ", window with same account already opened.")
            Continue
        }
        
        Run, % Settings.DofusPath

        WinWait, % Settings.DofusWindowName
        if ErrorLevel
        {
            MsgBox, 16, % Translate("Error"), % Translate("WinWaitTimeOutMsg")
            API.LogWrite("Game window couldn't be detected (Timeout).")
            return
        }

        WinGet, window, ID, % Settings.DofusWindowName
        this_window := API.NewWindow(window, ArrayAccounts[A_Index])
        this_window.WaitOpen()
        this_window.SetTitle()

        API.AddWindowToListView(this_window.id)
        API.GuiUpdateProgressBar(A_Index, API.GetNbActiveAccounts())
        
        i++
    }

    If (Settings.AlwaysOrganize = True)
        GoSub, Organize

    API.LogWrite("Successfully opened " i - 1 " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return