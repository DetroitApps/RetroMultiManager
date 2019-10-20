/*
    Tools: Merge Scenario
*/

mergedFilePath := A_ScriptDir . "\..\Scenarios\Out\MergedScenarios.ahk"
mergedFile := FileOpen(mergedFilePath, "w")
mergedFile.WriteLine(";This file is automatically generated by the MergeScenarios tool.")
mergedFile.WriteLine(";Do not edit it!`n")

directory := A_ScriptDir . "\..\Scenarios\"
Loop, %directory%*.ahk
{
    fileNumber := A_Index
    mergedFile.WriteLine(";Scenario merged from: " . A_LoopFileFullPath)
    Loop
    {
        FileReadLine, line, %A_LoopFileFullPath%, %A_Index%
        if ErrorLevel
            break
        If (InStr(line, "Main:"))
        {
            scenarioName := StrSplit(A_LoopFileName, ".")[1]
            mergedFile.WriteLine(scenarioName . ":")
            mergedFile.WriteLine("`t;Header (auto-generated)")
            mergedFile.WriteLine("`tScenario := New API.Scenario(" . fileNumber . ",""" . scenarioName . """)")
            mergedFile.WriteLine("`tcurrentScenario := Scenario")
            mergedFile.WriteLine("`t;End Header`n")
        }
        Else
            mergedFile.WriteLine(line)
    }
    mergedFile.WriteLine()
}
mergedFile.Close()
ExitApp