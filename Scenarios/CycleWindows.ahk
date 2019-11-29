/*
    Scenario: OpenDofusInstances
*/

Main:
    destWin := (API.CurrentWindow = API.GetNbLinkedWindows()) ? 1 : API.CurrentWindow + 1
    window := API.GetWindow(destWin)
    API.LogWrite("Dest window is number #" destWin " (hwnd " window.hwnd ")")
    window.Activate()
    API.CurrentWindow := destWin
return