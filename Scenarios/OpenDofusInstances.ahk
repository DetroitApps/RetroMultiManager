OpenDofusInstances:
    GUI_UpdateText("Opening Dofus instances...")
    GUI_UpdateBar(0)

    nbAccounts := API.GetNbAccounts()
    API.WindowList := [] ;get rid of old windows
    Loop % nbAccounts {
        Run, % oSettings.DofusPath,,, pid
        
        API.WindowList[A_Index] := New API.Window(pid)
        API.WindowList[A_Index].WaitOpen()
        API.WindowList[A_Index].SetTitle(ArrayAccounts[A_Index])

        GUI_UpdateBar(step)
        step += stepSize
        SleepHandler(0)
    }
    GUI_UpdateBar(100)
    GUI_UpdateText("Done.")
    return