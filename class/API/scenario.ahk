/*
    Class: Scenario
*/

Class Scenario {
    Title := ""

    __New(_Id, _Title)
    {
        this.Id := _Id
        this.Title := _Title
    }

    GetValueFromIni(ByRef section, ByRef key)
    {
        IniRead, readValue, % "Scenarios/" . this.Title ".ini", %section%, %key%, %A_Space%
        return readValue
    }
}