OpenDofusInstances:
    GUI_UpdateText("Opening Dofus instances...")
    GUI_UpdateBar(0)

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()
    Loop % nbAccounts {
        Run, % oSettings.DofusPath,,, pid
        
        API.WindowList[A_Index] := New API.Window(pid)
        API.WindowList[A_Index].WaitOpen()
        API.WindowList[A_Index].SetTitle(ArrayAccounts[A_Index])
        GUI_UpdateBar(A_Index, nbAccounts)
        SleepHandler(0)
    }
    GUI_UpdateBar(100)
    GUI_UpdateText("Done.")
    return