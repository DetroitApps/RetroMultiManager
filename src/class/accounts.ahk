/*
    Class Account
*/

Class Account {
    __New(_Username, _Password, _Nickname, _CharacterClass, _IsActive, _PlayerSlot := 1, _ServerSlot := 1){
        static idIndex := 1

        this.Username := _Username
        this.Password := _Password
        this.Nickname := _Nickname
        this.CharacterClass := _CharacterClass
        this.IsActive := _IsActive
        this.PlayerSlot := _PlayerSlot
        this.ServerSlot := _ServerSlot
        this.Id := idIndex++
    }
}