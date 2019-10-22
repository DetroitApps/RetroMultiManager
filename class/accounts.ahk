/*
    Class Account
*/

Class Account {
    __New(_Username, _Password, _Nickname, _CharacterClass, _IsActive){
        static idIndex := 1

        this.Username := _Username
        this.Password := _Password
        this.Nickname := _Nickname
        this.CharacterClass := _CharacterClass
        this.IsActive := _IsActive
        this.Id := idIndex++
    }
}