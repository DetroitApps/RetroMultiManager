/*
    Logger
    Write a log file for debug/dev mode
*/

Class Logger {
    TotalWarnings := 0
    TotalErrors := 0
    LogFilePath := ""
    LogFileLatestPath := ""

    Write(ByRef content, level := 0, scenario := 0)
    {
        If Settings.Debug
        {
            this.OpenLogFiles()
            line := this.GetCurrentTime()
            Switch level
            {
                Default: 
                    line := line . "[INFO]"
                Case 1: 
                    line := line . "[WARNING]"
                    TotalWarnings++
                Case 2: 
                    line := line . "[ERROR]"
                    TotalErrors++
                Case 3: 
                    line := line . "[DEBUG]"
            }
            line := (scenario = 0) ? line . A_Space . content : line . "[Scenario " . scenario . "] " . content
            this.LogFile.WriteLine(line)
            this.LogFileLatest.WriteLine(line)
            this.CloseLogFiles()
        }
    }

    WriteAccount(ByRef account)
    {
        If Settings.Debug
        {
            this.Write("-----------------------------------------------")
            this.Write("Logging account information for #" account.Id)
            this.Write("Username: " this.HideInfo(account.Username))
            this.Write("Password: " this.HideInfo(account.Password))
            this.Write("Nickname: " account.Nickname)
            this.Write("CharacterClass: " account.CharacterClass)
            this.Write("IsActive: " account.IsActive)
            this.Write("ServerSlot: " account.ServerSlot)
            this.Write("PlayerSlot: " account.PlayerSlot)
            this.Write("-----------------------------------------------")
        }
    }

    HideInfo(info)
    {
        hiddenInfo := ""
        Loop % StrLen(info)
            hiddenInfo := hiddenInfo . "*"
        return hiddenInfo
    }

    GetCurrentTime()
    {
        FormatTime, TimeString,, [hh:mm:ss]
        return TimeString
    }

    OpenLogFiles()
    {
        If Settings.Debug
        {
            this.LogFile := FileOpen(this.LogFilePath, "a")
            this.LogFileLatest := FileOpen(this.LogFileLatestPath, "a")
        }
    }

    CloseLogFiles()
    {
        If Settings.Debug
        {
            this.LogFile.Close()
            this.LogFileLatest.Close()
        }
    }

    __New()
    {
        FileCreateDir, logs

        ;Logfile timestamped
        FormatTime, TimeString,, dd-MM-yyyy_hh-mm-sstt
        this.LogFilePath := "logs\" . TimeString . ".log"
        this.LogFile := FileOpen(this.LogFilePath, "w")

        ;Logfile latest
        this.LogFileLatestPath := "logs\latest.log"
        this.LogFileLatest := FileOpen(this.LogFileLatestPath, "w")
        
        this.Write(Settings.TitleApp . " is alive!")
    }
}