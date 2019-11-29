/*
    Scenario: Close Dofus Instances
*/

F12::
Main:
    API.GuiUpdateProgressText("Closing Dofus instances...")
    API.GuiUpdateProgressBar(0)

    i := 0
    Loop % API.GetNbWindows()
    {
        API.CloseWindow(1)
        SleepHandler(0)
        i++
    }
    API.LogWrite("Successfully closed " i " windows.")    
    API.ClearWindowList()
    API.GuiUpdateProgressText("Done.")
    API.GuiUpdateProgressBar(100)
return