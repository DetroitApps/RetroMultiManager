;This file is automatically generated by the MergeScenarios tool.
;Do not edit it!

;Scenario merged from: Scenarios\AttachDofusInstances.ahk
/*
    Scenario: AttachDofusInstance
*/

AttachDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(1,"AttachDofusInstances")
	currentScenario := Scenario
	;End Header

    nbAccounts := API.GetNbAccounts()

    WinGet,WinList,List,,,Program Manager

    API.GuiUpdateProgressBar(0, WinList)
    API.GuiUpdateProgressText("Check for all open windows.")

    API.LogWrite("Start AttachDofusInstance Scenario.")
    API.LogWrite("Searching all windows containing keyword '" InputDofusWindowName "'.")

    i := 1

    nbAttachedAccount := 0

    Loop % WinList {

        ;Break if no account need to be attach
        If API.GetNbAccounts() = API.GetNbWindows()
            Break

        CurrentAhkId := WinList%i%
        WinGetTitle,CurrentWinTitle,ahk_id %CurrentAhkId%

        Cont=1
        loop,parse,TempPID,`n
        Cont:=(A_LoopField=PID) ? 0 : Cont

        ; Check if CurrentWindows have "InputDofusWindowName" in its title
        If (InStr(CurrentWinTitle, InputDofusWindowName) && Cont) {
            API.LogWrite("This windows has been found : '" CurrentWinTitle "'")

            Loop % nbAccounts {

                ;Skip if window already exists for this account
                If (API.WindowExists(ArrayAccounts[A_Index]) <> -1)
                {
                    API.LogWrite("\___> Skipping account #" A_Index " (" ArrayAccounts[A_Index].Nickname "), window with this account already opened.")
                    Continue
                }

                ; Check if CurrentWindows have "Nickname" in its title
                If InStr(CurrentWinTitle, ArrayAccounts[A_Index].Nickname)
                {
                    API.LogWrite("\___> Matches with account #" A_Index " (" ArrayAccounts[A_Index].Nickname ")")

                    this_window := API.NewWindow(CurrentAhkId, ArrayAccounts[A_Index])
                    this_window.SetTitle()
                    API.AddWindowToListView(this_window.id)

                    nbAttachedAccount++
                    Break
                }
            }
        }
        
        API.GuiUpdateProgressBar(i, WinList)
        i++
    }

    If (Settings.AlwaysOrganize = True)
        GoSub, Organize

    API.LogWrite("Linked to " nbAttachedAccount " windows.")
    API.GuiUpdateProgressBar(WinList, WinList)
    API.GuiUpdateProgressText("Linked to " nbAttachedAccount " windows.")

    return

;Scenario merged from: Scenarios\CloseDofusInstances.ahk
/*
    Scenario: Close Dofus Instances
*/

CloseDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(2,"CloseDofusInstances")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressText("Closing Dofus instances...")
    API.GuiUpdateProgressBar(0)

    i := 0
    Loop % API.GetNbWindows()
    {
        API.CloseWindow(1)
        Sleep, 50 * Settings.SpeedConnection
        i++
    }
    API.LogWrite("Successfully closed " i " windows.")    
    API.ClearWindowList()
    API.GuiUpdateProgressText("Done.")
    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\ConnectPlayersOnServer.ahk
/*
    Scenario: ConnectPlayersOnServer
*/

ConnectPlayersOnServer:
	;Header (auto-generated)
	Scenario := New API.Scenario(3,"ConnectPlayersOnServer")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressBar(0)

    section := A_ScreenWidth . "x" . A_ScreenHeight
    Loop, % API.GetNbWindows()
    {
        window := API.GetWindow(A_Index)

        ;Skip if already connected
        If (window.isConnected = True)
            Continue

        window.Activate()
        window.WaitActive()
        
        ;Get server slot position
        inputX := Scenario.GetValueFromIni(section, "x" window.account.ServerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" window.account.ServerSlot)
        If (!inputX || !inputY)
        {
            API.LogWrite("Couldn't load server slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load server slot position from INI, stopping current scenario.
            return
        }

        ;Connect on server
        MouseMove, inputX, inputY, 5 * Settings.SpeedConnection
        Click, 2

        SleepHandler(-100)

        API.GuiUpdateProgressBar(A_Index, API.GetNbWindows()*2)
    }

    ;-----------------------------------------------------------------
    Loop, % API.GetNbWindows()
    {
        window := API.GetWindow(A_Index)

        ;Skip if already connected
        If (window.isConnected = True)
            Continue

        window.Activate()
        window.WaitActive()

        ;Get player slot position
        inputX := Scenario.GetValueFromIni(section, "x" window.account.PlayerSlot)
        inputY := Scenario.GetValueFromIni(section, "y" window.account.PlayerSlot)
        If (inputX = -1 || inputY = -1)
        {
            API.LogWrite("Couldn't load player slot position from INI, stopping current scenario.", 2)
            MsgBox, 16, Error, Couldn't load player slot position from INI, stopping current scenario.
            return
        }

        ;Connect player
        MouseMove, inputX, inputY, 5 * Settings.SpeedConnection
        Click, 3

        SleepHandler(-100)

        API.GuiUpdateProgressBar(A_Index+ API.GetNbWindows(), API.GetNbWindows()*2)
    }

    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\CycleWindows.ahk
/*
    Scenario: OpenDofusInstances
*/

CycleWindows:
	;Header (auto-generated)
	Scenario := New API.Scenario(4,"CycleWindows")
	currentScenario := Scenario
	;End Header

    API.CheckCurrentWindow()
    destWin := (API.CurrentWindow = API.GetNbLinkedWindows()) ? 1 : API.CurrentWindow + 1
    window := API.GetWindow(destWin)
    API.LogWrite("Dest window is number #" destWin " (hwnd " window.hwnd ")")
    window.Activate()
    API.CurrentWindow := destWin
return

;Scenario merged from: Scenarios\CycleWindowsBackwards.ahk
/*
    Scenario: OpenDofusInstances
*/

CycleWindowsBackwards:
	;Header (auto-generated)
	Scenario := New API.Scenario(5,"CycleWindowsBackwards")
	currentScenario := Scenario
	;End Header

    API.CheckCurrentWindow()
    destWin := (API.CurrentWindow = 1) ? API.GetNbLinkedWindows() : API.CurrentWindow - 1
    window := API.GetWindow(destWin)
    API.LogWrite("Dest window is number #" destWin " (hwnd " window.hwnd ")")
    window.Activate()
    API.CurrentWindow := destWin
return

;Scenario merged from: Scenarios\LoginAccounts.ahk
/*
    Scenario: LoginAccounts
*/

LoginAccounts:
	;Header (auto-generated)
	Scenario := New API.Scenario(6,"LoginAccounts")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressBar(0)

    inputX := 0
    inputY := 0
    section := A_ScreenWidth . "x" . A_ScreenHeight
    inputX := Scenario.GetValueFromIni(section, "x")
    inputY := Scenario.GetValueFromIni(section, "y")
    If (!inputX || !inputY)
    {
        API.LogWrite("Couldn't load account input position from INI, stopping current scenario.", 2)
        MsgBox, 16, Error, Couldn't load account input position from INI, stopping current scenario.
        return
    }

    Loop, % API.GetNbWindows() {
        API.LogWrite("Trying to connect account #" A_Index ".")

        window := API.GetWindow(A_Index)
        If (window.isConnected = True)
        {
            API.LogWrite("Skipping window #" A_Index ", already connected.")
            Continue
        }
        
        If (Settings.WaitForAnkamaShield = True)
            MsgBox, % Translate("UnlockShield", API.GetUsername(A_Index))

        window.Activate()
        window.WaitActive()
        window.Maximize()

        ;Username
        Sleep, 50 * Settings.SpeedConnection
        MouseMove, inputX, inputY, 5 * Settings.SpeedConnection
        Click
        Sleep, 50 * Settings.SpeedConnection
        Send, ^a
        Sleep, 50 * Settings.SpeedConnection
        SendRaw, % window.account.username
        Sleep, 50 * Settings.SpeedConnection

        ;Password
        Send, {Tab}
        Sleep, 50 * Settings.SpeedConnection
        SendRaw, % window.account.password
        Sleep, 50 * Settings.SpeedConnection
        Send, {Tab}
        Sleep, 50 * Settings.SpeedConnection
        Send {Enter}
        API.GuiUpdateProgressBar(i, API.GetNbWindows())
        i++
        SleepHandler(0)
    }
    API.GuiUpdateProgressBar(100)
    return

;Scenario merged from: Scenarios\MoveAllPlayers.ahk
/*
    Scenario: MoveAllPlayers
*/

MoveAllPlayers:
	;Header (auto-generated)
	Scenario := New API.Scenario(7,"MoveAllPlayers")
	currentScenario := Scenario
	;End Header

    SetControlDelay, -1
    API.GuiUpdateProgressBar(0)
    nbWindow := API.GetNbLinkedWindows()

    Loop, % nbWindow {
        window := API.GetWindow(A_Index)
        API.GuiUpdateProgressText("Moving player " A_Index ".")
        API.GuiUpdateProgressBar(A_Index, nbWindow)

        MouseGetPos, outputX, outputY        
        ControlClick, % " x"outputX " y"outputY, % "ahk_id "window.hwnd,, left, 2

        If (A_Index <> nbWindow)
        {
            Random, rand, % Settings.DelayMoveSpeedBegin, % Settings.DelayMoveSpeedEnd
            API.GuiUpdateProgressText("Rand : " rand)
            Sleep, % rand
        }
    }
    
    API.LogWrite("Successfully moved " nbWindow " characters.")
    API.GuiUpdateProgressBar(100)
return

;Scenario merged from: Scenarios\OpenDofusInstances.ahk
/*
    Scenario: OpenDofusInstances
*/

OpenDofusInstances:
	;Header (auto-generated)
	Scenario := New API.Scenario(8,"OpenDofusInstances")
	currentScenario := Scenario
	;End Header

    API.GuiUpdateProgressBar(0, 3)
    API.GuiUpdateProgressText("Opening Dofus instances...")

    nbAccounts := API.GetNbAccounts()

    i := 1
    Loop % nbAccounts {
        ;Skip if account is set as inactive
        If !ArrayAccounts[A_Index].IsActive
            Continue
        
        ;Skip if window already exists for the same account
        If (API.WindowExists(ArrayAccounts[A_Index]) <> -1)
        {
            API.LogWrite("Skipping account #" A_Index ", window with same account already opened.")
            Continue
        }
        
        Run, % Settings.DofusPath

        WinWait, % Settings.DofusWindowName, , 10
        if ErrorLevel
        {
            MsgBox, 16, % Translate("Error"), % Translate("WinWaitTimeOutMsg")
            API.LogWrite("Game window couldn't be detected (Timeout).")
            return
        }

        WinGet, window, ID, % Settings.DofusWindowName
        this_window := API.NewWindow(window, ArrayAccounts[A_Index])
        this_window.WaitOpen()
        this_window.SetTitle()

        API.AddWindowToListView(this_window.id)
        API.GuiUpdateProgressBar(A_Index, API.GetNbActiveAccounts())
        
        i++
        Sleep 250
    }

    If (Settings.AlwaysOrganize = True)
        GoSub, Organize

    API.LogWrite("Successfully opened " i - 1 " windows.")
    API.GuiUpdateProgressBar(100)
    API.GuiUpdateProgressText("Done.")
    return

;Scenario merged from: Scenarios\Organize.ahk
/*
    Scenario: Reorganize windows according to initiative 
*/

Organize:
	;Header (auto-generated)
	Scenario := New API.Scenario(9,"Organize")
	currentScenario := Scenario
	;End Header

    API.DeleteClosedWindows()
    orderedWindowList := OrderWindowListWithInitiative()
    API.SetWindowList(orderedWindowList)
    API.OrganizeTaskbar()
    API.RefreshWindowsListView()
return

OrderWindowListWithInitiative() {
    tempWindowList := API.GetLinkedWindowList()
    orderedWindowList := {}

    While (tempWindowList.Length() != 0) 
    {
        maxInitiativeIndex := -1
        Loop, % tempWindowList.Length() 
        {
            If (tempWindowList[A_Index].account.initiative > tempWindowList[maxInitiativeIndex].account.initiative) 
                maxInitiativeIndex := A_Index
        }
        API.LogWrite("Maximum initiative is " tempWindowList[maxInitiativeIndex].title " with " tempWindowList[maxInitiativeIndex].account.initiative " initiative.")
        orderedWindowList.Push(tempWindowList[maxInitiativeIndex])
        tempWindowList.RemoveAt(maxInitiativeIndex)
    }

    unlinkedList := API.GetUnlinkedWindowList()
    Loop, % unlinkedList.MaxIndex()
        orderedWindowList.Push(unlinkedList[A_Index])
    return orderedWindowList
}

