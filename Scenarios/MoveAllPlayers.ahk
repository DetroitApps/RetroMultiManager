/*
    Scenario: MoveAllPlayers
*/

Main:
    SetControlDelay, -1
    API.GuiUpdateProgressBar(0)
    nbWindow := API.GetNbLinkedWindows()

    Loop, % nbWindow {
        window := API.GetWindow(A_Index)
        API.GuiUpdateProgressText("Moving player " A_Index ".")
        API.GuiUpdateProgressBar(A_Index, nbWindow)

        MouseGetPos, outputX, outputY        
        ControlClick, % " x"outputX " y"outputY, % "ahk_id "window.hwnd,, left, 2

        ; Prevent to add sleep after last account
        If (A_Index <> nbWindow)
        {
            Random, rand, % Settings.DelayMoveSpeedBegin, % Settings.DelayMoveSpeedEnd
            Sleep, % rand
        }
    }
    
    API.LogWrite("Successfully moved " nbWindow " characters.")
    API.GuiUpdateProgressBar(100)
return