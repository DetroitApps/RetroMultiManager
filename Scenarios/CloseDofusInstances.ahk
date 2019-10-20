+F12::
Main:
    GUI_UpdateText("Closing Dofus instances...")
    GUI_UpdateBar(0)

    Loop % API.GetTotalWindows()
        API.CloseWindow(A_Index)
    API.LogWrite("Successfully closed " . API.GetTotalWindows() . " windows.")
    GUI_UpdateText("Done.")
    GUI_UpdateBar(100)
    API.ResetWindowsIndex()
return