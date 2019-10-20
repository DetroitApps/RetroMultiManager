/*
    Logger
*/

Class Logger {
    TotalWarning := 0
    TotalErrors := 0

    Write(content)
    {
        If oSettings.Debug
        {
            this.LogFile.WriteLine("[INFO] " . content)
            this.LogFileLatest.WriteLine("[INFO] " . content)
        }
    }

    WriteError(content, level := 0)
    {
        If oSettings.Debug
        {
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
        }
    }

    CloseLogFiles()
    {
        If oSettings.Debug
        {
            this.LogFile.Close()
            this.LogFileLatest.Close()
        }
    }

    __New()
    {
        FileCreateDir, Logs

        FormatTime, TimeString,, dd-MM-yyyy_hh-mmtt
        this.LogFile := FileOpen("Logs\" . TimeString . ".log", "w")
        this.LogFileLatest := FileOpen("Logs\latest.log", "w")
        
        this.Write("Initializing RMM.")
    }
}