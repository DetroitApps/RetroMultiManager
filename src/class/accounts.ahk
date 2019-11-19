/*
    Class Account
*/

Class Account {
    __New(_Username, _Password, _Nickname, _Initiative, _CharacterClass, _IsActive, _ServerSlot := 1, _PlayerSlot := 1)
    {
        static idIndex := 1

        this.Username := _Username
        this.Password := _Password
        this.Nickname := _Nickname
        this.Initiative := _Initiative
        this.CharacterClass := _CharacterClass
        this.IsActive := _IsActive
        this.ServerSlot := _ServerSlot
        this.PlayerSlot := _PlayerSlot
        this.Id := idIndex++
    }
}