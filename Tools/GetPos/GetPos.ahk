/*
    Tool to export current mouse position in a log file.
*/

#NoEnv
#SingleInstance, Force
#Persistent

StringCaseSense On
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window

index := 1

FileCreateDir, logs
FormatTime, TimeString,, dd-MM-yyyy_hh-mm-sstt
logFilePath := "logs\export-" . TimeString . ".log"
logFile := FileOpen(logFilePath, "w")

logFile.WriteLine("GetPos is alive!")

return

Numpad5::
    MouseGetPos, outputX, outputY, outputWin, outputVarControl
    logFile.WriteLine("==============================================")
    logFile.WriteLine("Mouse position #" index++)
    logFile.WriteLine("Position:`t[" outputX "," outputY "]")
    logFile.WriteLine("Window:`t" outputWin)
    logFile.WriteLine("Control:`t" outputVarControl "`n")
return