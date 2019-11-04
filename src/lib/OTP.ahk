XOR_String_Plus(String,Key)
{
	Key_Pos := 1
	Loop, Parse, String
	{
		String_XOR .= Chr((Asc(A_LoopField) ^ Asc(SubStr(Key,Key_Pos,1))) + 15000)
		Key_Pos += 1
		if (Key_Pos > StrLen(Key))
			Key_Pos := 1
	}
	return String_XOR
}

XOR_String_Minus(String,Key)
{
	Key_Pos := 1
	Loop, Parse, String
	{
		String_XOR .= Chr(((Asc(A_LoopField) - 15000) ^ Asc(SubStr(Key,Key_Pos,1))))
		Key_Pos += 1
		if (Key_Pos > StrLen(Key))
			Key_Pos := 1
	}
	return String_XOR
}