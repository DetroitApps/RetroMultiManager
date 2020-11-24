/*
    Scenario: AttachDofusInstance
*/

Main:
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