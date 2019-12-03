/*
    Labels
*/

AskReload:
    MsgBox, 49, % Translate("AskReloadTitle"), % Translate("AskReloadMsg")
    IfMsgBox, Ok
        Reload
    return

MergeScenarios:
    path = %A_ScriptDir%\Tools\Scenario Merger.ahk
    If FileExist(path)
    {
        RunWait, %path%
        Reload
    }
    return

VisitGithub:
    Run, https://github.com/DetroitApps/RetroMultiManager
    return

VisitDonations:
    Run, https://fr.tipeee.com/detroit-applications/
    return

ExitGracefully:
    Logger.Write("Program exited gracefully with " . Logger.TotalWarning . " warning and " . Logger.TotalErrors . " errors.")
    Logger.CloseLogFiles()
    ExitApp
    return


TestMsg:
    Msgbox, % "It's working chief!" . HK
    return

;Profile
LoadProfile:
    ;Mixing GUI and script
    Logger.Write("Starting loading profile.")
    profileIniPath := A_WorkingDir . "\Profiles\profile" . SelectProfile . ".ini"
    If (!FileExist(profileIniPath))
    {
        MsgBox,, % Translate("Error"), % Translate("ProfileNotExistingMsg", SelectProfile)
        return
    }
    Else 
    {
        ArrayAccounts := []
        If Settings.GuiStatus
        {
            GoSub, Gui_ClearAccountData
            GuiControl, Choose, SelectProfile, %SelectProfile%
            GuiControl,, CheckDefaultProfile, % Settings.DefaultProfile = SelectProfile ? 1 : 0
            SB_SetText(Translate("ActiveProfile") ": " SelectProfile, 3)
        }
        Loop, %NbAccountPerProfile% {
            IniRead, username, %profileIniPath%, Accounts, Username%A_Index%
            IniRead, password, %profileIniPath%, Accounts, Password%A_Index%
            IniRead, playerSlot, %profileIniPath%, Accounts, PlayerSlot%A_Index%
            IniRead, serverSlot, %profileIniPath%, Accounts, ServerSlot%A_Index%
            IniRead, nickname, %profileIniPath%, Accounts, Nickname%A_Index%
            IniRead, characterClass, %profileIniPath%, Accounts, Class%A_Index%
            IniRead, initiative, %profileIniPath%, Accounts, Initiative%A_Index%, 0
            IniRead, isActive, %profileIniPath%, Accounts, IsActive%A_Index%
            If (username = "ERROR" || password = "ERROR")
                break
            username := XOR_String_Minus(username, MasterPassword)
            password := XOR_String_Minus(password, MasterPassword)
            ArrayAccounts[A_Index] := New Account(username, password, nickname, initiative, characterClass, isActive, serverSlot, playerSlot)
            ;Logger.WriteAccount(ArrayAccounts[A_Index])
            If Settings.GuiStatus
            {
                GuiControl, Text, InputUsername%A_Index%, %username%
                GuiControl, Text, InputPassword%A_Index%, %password%
                GuiControl, Text, InputNickname%A_Index%, %nickname%
                GuiControl, Text, InputInitiative%A_Index%, %initiative%
                GuiControl, ChooseString, SelectClass%A_Index%, %characterClass%
                GuiControl, Choose, SelectPlayerSlot%A_Index%, %playerSlot%
                GuiControl, Choose, SelectServerSlot%A_Index%, %serverSlot%
                GuiControl, , CheckActive%A_Index%, %isActive%
            }
        }
    }
    return

SaveProfile:
    Logger.Write("Starting saving profile.")
    FileCreateDir, Profiles
    profileIniPath := A_WorkingDir . "\Profiles\profile" . SelectProfile . ".ini"
    file := FileOpen(profileIniPath, "w", "UTF-16")
    If (file = 0)
    {
        MsgBox,, % Translate("Error"), % "[" A_LastError "]" Translate("ErrorSaveProfile", profileIniPath) "."
        return
    }
    file.WriteLine("[Accounts]")
    Loop, %NbAccountPerProfile% {
        If (InputUsername%A_Index% = "" || InputPassword%A_Index% = "")
            break

        username := InputUsername%A_Index%
        username := XOR_String_Plus(username, MasterPassword)
        file.WriteLine("Username" . A_Index . "=" . username)
        password := InputPassword%A_Index%
        password := XOR_String_Plus(password, MasterPassword)
        file.WriteLine("Password" . A_Index . "=" . password)
        file.WriteLine("PlayerSlot" . A_Index . "=" . SelectPlayerSlot%A_Index%)
        file.WriteLine("ServerSlot" . A_Index . "=" . SelectServerSlot%A_Index%)
        file.WriteLine("Nickname" . A_Index . "=" . InputNickname%A_Index%)
        file.WriteLine("Class" . A_Index . "=" . SelectClass%A_Index%)
        file.WriteLine("Initiative" . A_Index . "=" . InputInitiative%A_Index%)
        IsActive := CheckActive%A_Index% = 1 ? 1 : 0
        file.WriteLine("IsActive" . A_Index . "=" . IsActive)
        ArrayAccounts[A_Index] := New Account(InputUsername%A_Index%, InputPassword%A_Index%, InputNickname%A_Index%, InputInitiative%A_Index%, SelectClass%A_Index%, IsActive, SelectServerSlot%A_Index%, SelectPlayerSlot%A_Index%)
        ;Logger.WriteAccount(ArrayAccounts[A_Index])
    }
    If (CheckDefaultProfile = 1)
        IniWrite, %SelectProfile%, %IniPath%, Program, DefaultProfile
    API.UpdateWindowsAccount()
    file.Close()
    Modifications := False
    return