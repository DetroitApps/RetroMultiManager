/*
    Scenario: OpenDofusInstances
*/

SC056::
+SC056::
Main:
    If GetKeyState("LShift")
        destWin := GetDestinationWindow(false)
    Else
        destWin := GetDestinationWindow(true)
    window := API.GetWindow(destWin)

    API.LogWrite("Dest window is number #" destWin " (hwnd " window.hwnd ")")
    window.Activate()
    API.CurrentWindow := destWin
return

GetDestinationWindow(ascend)
{
    If ascend 
        destWin := (API.CurrentWindow = API.GetNbActiveAccounts()) ? 1 : API.CurrentWindow + 1
    Else
        destWin := (API.CurrentWindow = 1) ? API.GetNbActiveAccounts() : API.CurrentWindow - 1
    return destWin
}