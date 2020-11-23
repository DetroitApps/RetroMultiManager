/*
    Scenario: AttachDofusInstance
*/

Main:
    nbAccounts := API.GetNbAccounts()

    WinGet,WinList,List,,,Program Manager

    API.GuiUpdateProgressBar(0, WinList)

    nbAttachedAccount := 0

    Loop % WinList {
        Current := WinList%A_Index%
        WinGetTitle,WinTitle,ahk_id %Current%

        Cont=1
        loop,parse,TempPID,`n
        Cont:=(A_LoopField=PID) ? 0 : Cont

        If WinTitle && Cont {
            i := 1
            Loop % nbAccounts {

                ;Skip if window already exists for the same account
                If (API.WindowExists(ArrayAccounts[A_Index]) <> -1)
                {
                    API.LogWrite("Skipping account #" A_Index ", window with same account already opened.")
                    Continue
                }

                If WinTitle contains % ArrayAccounts[i].Nickname " - Dofus Retro"
                {
                    this_window := API.NewWindow(Current, ArrayAccounts[A_Index])
                    this_window.SetTitle()
                    API.AddWindowToListView(this_window.id)

                    nbAttachedAccount++
                }
                i++
            }
        }
        
        API.GuiUpdateProgressBar(A_Index, WinList)
    }

    If (Settings.AlwaysOrganize = True)
        GoSub, Organize

    API.LogWrite("Successfully opened " i - 1 " windows.")
    ; API.GuiUpdateProgressBar(100)
    ; API.GuiUpdateProgressText("Done.")
    return