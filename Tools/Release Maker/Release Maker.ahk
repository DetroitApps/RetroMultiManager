/*
    Release Maker
*/

#SingleInstance Force

dataPath := "Retro Multi Manager"
FileCreateDir, %dataPath%

rootDir := "..\..\"
FileRead, version, %rootDir%version.txt
IniRead, build, build.ini, Build, Id
zipFilename := "RetroMultiManager_" . version . "_build" . build . ".zip"
7zFilename := "RetroMultiManager-" . version . "_build" . build . ".7z"

Loop, Read, MakeFile
{
    newFilename := ""
    folderName := ""
    If (InStr(A_LoopReadLine, "\"))
    {
        folderName := StrSplit(A_LoopReadLine, "\")[1]
        FileCreateDir, %dataPath%\%folderName%
    }
    ;Compile ahk files
    If (InStr(A_LoopReadLine, ".ahk"))
    {
        outputFile := rootDir . StrSplit(A_LoopReadLine, ".")[1] . ".exe"
        cmd :=  """c:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe"" /in """ . rootDir . A_LoopReadLine
                . """ /out """ . outputFile 
                 . """ /icon """ . rootDir . "Resources\icon.ico"""
        RunWait, %cmd%
        newFilename := outputFile
        FileCopy, %outputFile%, %dataPath%\%folderName%, 1
    }
    If (newFilename != "")
        filename := newFilename
    Else
    {
        filename := rootDir . A_LoopReadLine
        FileCopy, %filename%, %dataPath%, 1
    }
}

FileCreateDir, %version%
RunWait, "C:\Program Files\7-Zip\7z.exe" u Releases\%version%\%zipFilename% "%dataPath%"
RunWait, "C:\Program Files\7-Zip\7z.exe" u Releases\%version%\%7zFilename% "%dataPath%"


/*FileCopy, %zipFilename%, , 1
FileCopy, %7zFilename%, %version%, 1
*/

FileRemoveDir, %dataPath%, 1
build++
IniWrite, %build%, build.ini, Build, Id

ExitApp

F12::
    ExitApp
    return