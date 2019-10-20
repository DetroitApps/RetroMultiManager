+F12::
Main:
    API.GuiUpdateProgressText("Closing Dofus instances...")
    API.GuiUpdateProgressBar(0)

    Loop % API.GetTotalWindows()
        API.CloseWindow(A_Index)
    API.LogWrite("Successfully closed " . API.GetTotalWindows() . " windows.")
    API.GuiUpdateProgressText("Done.")
    API.GuiUpdateProgressBar(100)
    API.ResetWindowsIndex()
return