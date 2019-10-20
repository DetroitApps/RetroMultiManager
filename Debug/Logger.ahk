/*
    Logger
*/

Class Logger {
    TotalWarning := 0
    TotalErrors := 0
    LogFilePath := ""
    LogFileLatestPath := ""

    Write(ByRef content)
    {
        If Settings.Debug
        {
            this.OpenLogFiles()
            FormatTime, TimeString,, [hh:mm:ss]
            this.LogFile.WriteLine(TimeString . "[INFO] " . content)
            this.LogFileLatest.WriteLine(TimeString . "[INFO] " . content)
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