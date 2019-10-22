/*
    Logger
    Write a log file for debug/dev mode
*/

Class Logger {
    TotalWarning := 0
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
                Default: line := line . "[INFO] "
                Case 1: line := line . "[WARNING] "
                Case 2: line := line . "[ERROR] "
                Case 3: line := line . "[DEBUG] "
            }
            line := (scenario = 0) ? line . content : "[Scenario " . scenario . "]" . line . content
            this.LogFile.WriteLine(line)
            this.LogFileLatest.WriteLine(line)
            this.CloseLogFiles()
        }
    }

    WriteError(ByRef content, level := 0)
    {
        If Settings.Debug
        {
            this.OpenLogFiles()
            If (level = 0)
            {
                this.LogFile.WriteLine("[WARNING] " . content)
                this.LogFileLatest.WriteLine("[WARNING] " . content)
                TotalWarning++
            }
            Else
            {
                this.LogFile.WriteLine("[ERROR] " . content)
                this.LogFileLatest.WriteLine("[ERROR] " . content)
                TotalErrors++
            }
            this.CloseLogFiles()
        }
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
        FileCreateDir, Logs

        ;Logfile timestamped
        FormatTime, TimeString,, dd-MM-yyyy_hh-mmtt
        this.LogFilePath := "Logs\" . TimeString . ".log"
        this.LogFile := FileOpen(this.LogFilePath, "w")

        ;Logfile latest
        this.LogFileLatestPath := "Logs\latest.log"
        this.LogFileLatest := FileOpen(this.LogFileLatestPath, "w")
        
        this.Write(Settings.TitleApp . " is alive!")
    }
}