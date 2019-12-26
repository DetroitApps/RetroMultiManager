/*
    Scenario: MoveAllPlayers
*/

Main:
    API.GuiUpdateProgressBar(0)
    nbWindow := API.GetNbLinkedWindows()

    Loop, % nbWindow {
        window := API.GetWindow(A_Index)
        API.GuiUpdateProgressText("Moving player " A_Index ".")
        API.GuiUpdateProgressBar(A_Index, nbWindow)

        window.Activate()
        window.WaitActive()
        
        MouseGetPos, outputX, outputY
        MouseMove, outputX+1, outputY+1 ; Force focus on window
        MouseMove, outputX, outputY ; Force focus on window
        ;Click, outputX, outputY
        Send +{Click, outputX, outputY}

        Sleep 250
    }
    
    ;Reset on windows 1
    window := API.GetWindow(1)
    window.Activate()
    window.WaitActive()
    
    API.LogWrite("Successfully moved " nbWindow " characters.")
    API.GuiUpdateProgressBar(100)
return