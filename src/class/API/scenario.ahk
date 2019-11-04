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
        API.LogWrite("Trying to get value for key '" key "' in section '" section "' from INI file '" this.Title ".ini'.")
        IniRead, readValue, % "resources/" . this.Title ".ini", %section%, %key%, %A_Space%
        API.LogWrite("Result: " readValue)
        return readValue
    }
}