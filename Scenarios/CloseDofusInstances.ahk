/*
    Scenario: Close Dofus Instances
*/

F12::
Main:
    API.GuiUpdateProgressText("Closing Dofus instances...")
    API.GuiUpdateProgressBar(0)

    Loop % API.GetNbAccounts()
        API.CloseWindow(A_Index)
    API.LogWrite("Successfully closed " . API.GetNbAccounts() . " windows.")    
    API.ClearWindowList()
    API.GuiUpdateProgressText("Done.")
    API.GuiUpdateProgressBar(100)
return