/*
    Labels
*/

DownloadOCRPreset:
    FileCreateDir, Resources
    FileCreateDir, Resources\%A_ScreenHeight%p
    UrlDownloadToFile, https://raw.githubusercontent.com/DetroitApps/RetroMultiManager/master/Resources/%A_ScreenHeight%p/account.png, Resources\%A_ScreenHeight%p\account.png
    return

ToggleOCR:
    Settings.EnableOCR := !Settings.EnableOCR
    IniWrite, % Settings.EnableOCR ? "True" : "False", %IniPath%, Settings, EnableOCR
    return

MergeScenarios:
    path = %A_ScriptDir%\Tools\Scenario Merger.exe
    If FileExist(path)
    {
        RunWait, %path%
        Reload
    }
    Else
        MsgBox, % "You activated developer mode. Please compile the Scenario Merger script in the Tools folder in order to modify scenarios."
    return

VisitGithub:
    Run, https://github.com/DetroitApps/RetroMultiManager
    return


TestMsg:
    Msgbox, % "It's working chief!" . HK
    return

;Profile
LoadProfile:
    ;Mixing GUI and script
    profileIniPath := A_WorkingDir . "\Profiles\profile" . SelectProfile . ".ini"
    If (!FileExist(profileIniPath))
    {
        MsgBox, % "Profile #" . SelectProfile . " hasn't been created yet."
        return
    }
    Else 
    {   
        IniRead, Encrypt, %profileIniPath%, Security, Encrypt
        ArrayAccounts := []
        If Settings.GuiStatus
        {
            GoSub, Gui_ClearAccountData
            GuiControl,, CheckEncryption, %Encrypt%
            GuiControl, Choose, SelectProfile, %SelectProfile%
            GuiControl,, CheckDefaultProfile, % Settings.DefaultProfile = SelectProfile ? 1 : 0
            SB_SetText("Active profile: " . SelectProfile, 3)
        }
        Loop 8 {
            IniRead, username, %profileIniPath%, Accounts, Username%A_Index%
            IniRead, password, %profileIniPath%, Accounts, Password%A_Index%
            IniRead, nickname, %profileIniPath%, Accounts, Nickname%A_Index%
            IniRead, characterClass, %profileIniPath%, Accounts, Class%A_Index%
            IniRead, isActive, %profileIniPath%, Accounts, IsActive%A_Index%
            If (username = "ERROR" || password = "ERROR")
                break
            If (Encrypt = 1)
            {
                username := AES.Decrypt(username, MasterPassword, 256)
                username := RegExReplace(username, "[^[:ascii:]]") ;clean weird characters when decoding
                password := AES.Decrypt(password, MasterPassword, 256)
                password := RegExReplace(password, "[^[:ascii:]]")
            }
            ArrayAccounts[A_Index] := New Account(username, password, nickname, characterClass, isActive)
            If Settings.GuiStatus
            {
                GuiControl, Text, InputUsername%A_Index%, %username%
                GuiControl, Text, InputPassword%A_Index%, %password%
                GuiControl, Text, InputNickname%A_Index%, %nickname%
                GuiControl, ChooseString, SelectClass%A_Index%, %characterClass%
                GuiControl, , CheckActive%A_Index%, %isActive%
            }
        }
    }
    return

SaveProfile:
    FileCreateDir, Profiles
    profileIniPath := A_WorkingDir . "\Profiles\profile" . SelectProfile . ".ini"
    file := FileOpen(profileIniPath, "w")
    If (file = 0)
    {
        MsgBox, % "[" . A_LastError .  "] Couldn't save profile with path " . profileIniPath . "."
        return
    }
    file.WriteLine("[Accounts]")
    Loop 8 {
        If (InputUsername%A_Index% = "" || InputPassword%A_Index% = "")
            break

        username := InputUsername%A_Index%
        If (CheckEncryption = 1)
            username := AES.Encrypt(username, MasterPassword, 256)
        file.WriteLine("Username" . A_Index . "=" . username)
        password := InputPassword%A_Index%
        If (CheckEncryption = 1)
            password := AES.Encrypt(password, MasterPassword, 256)
        file.WriteLine("Password" . A_Index . "=" . password)
        file.WriteLine("Nickname" . A_Index . "=" . InputNickname%A_Index%)
        file.WriteLine("Class" . A_Index . "=" . SelectClass%A_Index%)
        IsActive := CheckActive%A_Index% = 1 ? 1 : 0
        file.WriteLine("IsActive" . A_Index . "=" . IsActive)
        ArrayAccounts[A_Index] := New Account(InputUsername%A_Index%, InputPassword%A_Index%, InputNickname%A_Index%, SelectClass%A_Index%, IsActive)
    }
    file.WriteLine("`n[Security]")
    Encrypt := CheckEncryption = 1 ? 1 : 0
    file.WriteLine("Encrypt=" . Encrypt)
    If (CheckDefaultProfile = 1)
        IniWrite, %SelectProfile%, %IniPath%, Profile, Default
    file.Close()
    return