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
    window.Activate()
return

GetDestinationWindow(ascend)
{
    If ascend 
        destWin := (API.CurrentWindow = API.GetNbWindows()) ? 1 : API.CurrentWindow + 1
    Else
        destWin := (API.CurrentWindow = 1) ? API.GetNbWindows() : API.CurrentWindow - 1
    return destWin
}