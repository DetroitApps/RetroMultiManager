;This file is automatically generated by the MergeScenarios tool.
;Do not edit it!

;Scenario merged from: C:\Dev\AHK\RetroMultiManager\Tools\..\Scenarios\CloseDofusInstances.ahk
+F12::
CloseDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(1,"CloseDofusInstances")
	currentScenario := Scenario
	;End Header

    GUI_UpdateText("Closing Dofus instances...")
    GUI_UpdateBar(0)

    Loop % API.GetTotalWindows()
        API.CloseWindow(A_Index)
    API.LogWrite("Successfully closed " . API.GetTotalWindows() . " windows.")
    GUI_UpdateText("Done.")
    GUI_UpdateBar(100)
    API.ResetWindowsIndex()
return

;Scenario merged from: C:\Dev\AHK\RetroMultiManager\Tools\..\Scenarios\LoginAccounts.ahk
/*
    Scenario LoginAccounts
    Will perform one OCR scan to find account input. 
    If it fails, it tries to load from default values (TO DO)
*/

LoginAccounts:
	;Header (auto-generated)
	Scenario := New API.Scenario(2,"LoginAccounts")
	currentScenario := Scenario
	;End Header

    inputX := 0
    inputY := 0
    
    GUI_UpdateBar(0)
    Loop, % API.GetTotalWindows() {
        window := API.GetWindow(A_Index)
        window.Activate()
        window.Maximize()
        Sleep, 50 * oSettings.Speed
        If (A_Index = 1)
        {
            If (oSettings.EnableOCR = True)
                Gosub, GetAccountInputPosition
            If (!inputX || !inputY || inputX = 0 || inputY = 0)
            {
                API.LogWriteError("OCR failed or disabled. Trying to get account input position from default settings.")
                IniRead, inputX, Resources\%A_ScreenHeight%p\window.ini, InputAccount, x, 0
                IniRead, inputY, Resources\%A_ScreenHeight%p\window.ini, InputAccount, y, 0
                If (inputX = "0" || inputY = "0")
                {
                    API.LogWriteError("Couldn't load account input position from INI, stopping current scenario.", 1)
                    return
                }
                Else 
                    API.LogWrite("IniRead found input with position [" . inputX . "," . inputY . "].")
            }
            Else
            {
                API.LogWrite("OCR found match with position [" . inputX . "," . inputY . "].")
                inputY += 70 ; might not work for every resolution, to be tested!
            }
        }
        MouseMove, inputX, inputY, 5 * oSettings.Speed
        Click
        Sleep, 50 * oSettings.Speed
        SendRaw, % API.GetUsername(A_Index)
        Sleep, 50 * oSettings.Speed
        Send, {Tab}
        Sleep, 50 * oSettings.Speed
        SendRaw, % API.GetPassword(A_Index)
        Sleep, 50 * oSettings.Speed
        Send, {Tab}
        Sleep, 50 * oSettings.Speed
        Send {Enter}
        GUI_UpdateBar(A_Index, API.GetTotalWindows())
        SleepHandler(0) ;handle sleep based on speed settings (parameter is for added sleep)
    }
    GUI_UpdateBar(100)
    return

GetAccountInputPosition:
    MouseMove, 0, 0
    Sleep 1000 * oSettings.Speed
    API.SearchImageInWindow("account.png", inputX, inputY)
    Sleep 1500 * oSettings.Speed
    return

;Scenario merged from: C:\Dev\AHK\RetroMultiManager\Tools\..\Scenarios\OpenDofusInstances.ahk
OpenDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(3,"OpenDofusInstances")
	currentScenario := Scenario
	;End Header

    GUI_UpdateText("Opening Dofus instances...")
    GUI_UpdateBar(0)

    API.ClearWindowList()
    nbAccounts := API.GetTotalAccounts()

    i := 1
    Loop % nbAccounts {
        If !ArrayAccounts[i].IsActive
            Continue
        Run, % oSettings.DofusPath,,, pid
        API.WindowList[i] := New API.Window(pid)
        API.WindowList[i].WaitOpen()
        API.WindowList[i].SetTitle(ArrayAccounts[i])
        GUI_UpdateBar(i, nbAccounts)
        SleepHandler(0)
        i++
    }
    API.LogWrite("Successfully opened " . nbAccounts " windows.")
    GUI_UpdateBar(100)
    GUI_UpdateText("Done.")
    return

