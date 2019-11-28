/*
    Scenario: MoveAllPlayers
*/

^SC056::
Main:
    API.GuiUpdateProgressBar(0)
    MouseGetPos, outputX, outputY
    nbWindow := API.GetTotalAccounts()
    Loop, % nbWindow {
        window := API.GetWindow(A_Index)
        API.GuiUpdateProgressText("Moving player " A_Index ".")
        API.GuiUpdateProgressBar(A_Index, nbWindow)

        window.Activate()
        window.WaitActive()

        Click, outputX, outputY

        Sleep 250
    }
    
    window := API.GetWindow(1)
    window.Activate()
    window.WaitActive()
    
    API.LogWrite("Successfully moved " nbWindow " characters.")
    API.GuiUpdateProgressBar(100)
return