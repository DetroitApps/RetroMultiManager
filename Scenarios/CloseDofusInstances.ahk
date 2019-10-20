+F12::
CloseDofusInstances:
    Loop % API.GetTotalWindows()
        API.CloseWindow(A_Index)
    API.ResetWindowsIndex()
return