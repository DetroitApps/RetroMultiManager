TestMsg:
    Msgbox, % "it's working chief!" . HK
    return

;Profile
LoadProfile:
    ;Mixing GUI and script
    profileIniPath := A_WorkingDir . "\Profiles\profile" . ProfileSelection . ".ini"
    If (!FileExist(profileIniPath))
    {
        MsgBox, % "Profile #" . ProfileSelection . " hasn't been created yet."
        return
    }
    Else 
    {   
        IniRead, Encrypt, %profileIniPath%, Security, Encrypt
        ArrayAccounts := []
        If oSettings.GuiStatus
        {
            GoSub, GuiClearAccountsData
            GuiControl,, CheckPasswordEncryption, %Encrypt%
            GuiControl,, CheckDefaultProfile, % oSettings.DefaultProfile = ProfileSelection ? 1 : 0
            SB_SetText("Active profile: " . ProfileSelection, 3)
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
                    password := AES.Decrypt(Password, MasterPassword, 256)
            ArrayAccounts[A_Index] := New Account(username, password, nickname, characterClass, isActive)
            If oSettings.GuiStatus
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
    profileIniPath := A_WorkingDir . "\Profiles\profile" . ProfileSelection . ".ini"
    File := FileOpen(profileIniPath, "w")
    If (File = 0)
    {
        MsgBox, % "[" . A_LastError .  "] Couldn't save profile with path " . profileIniPath . "."
        return
    }
    File.WriteLine("[Accounts]")
    Loop 8 {
        If (InputUsername%A_Index% = "" || InputPassword%A_Index% = "")
            break
        File.WriteLine("Username" . A_Index . "=" . InputUsername%A_Index%)
        Password := InputPassword%A_Index%
        If (CheckPasswordEncryption = 1)
            Password := AES.Encrypt(Password, MasterPassword, 256)
        File.WriteLine("Password" . A_Index . "=" . Password)
        File.WriteLine("Nickname" . A_Index . "=" . InputNickname%A_Index%)
        File.WriteLine("Class" . A_Index . "=" . SelectClass%A_Index%)
        IsActive := CheckActive%A_Index% = 1 ? 1 : 0
        File.WriteLine("IsActive" . A_Index . "=" . IsActive)
        ArrayAccounts[A_Index] := New Account(InputUsername%A_Index%, InputPassword%A_Index%, InputNickname%A_Index%,SelectClass%A_Index%, IsActive)
    }
    File.WriteLine("`n[Security]")
    Encrypt := CheckPasswordEncryption = 1 ? 1 : 0
    File.WriteLine("Encrypt=" . Encrypt)
    If (CheckDefaultProfile = 1)
        IniWrite, %ProfileSelection%, %IniPath%, Profile, Default
    File.Close()
    return