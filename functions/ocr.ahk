/*
    OCR related functions
*/

OCR_GetPositionFromImage(imageFile, ByRef x, ByRef y)
{
	startSearchX := 0
	startSearchY := 0
	endSearchX := 1920
	endSearchY := 1080
	Loop
	{
		;Image Search
		ImageSearch, outputX, outputY, %startSearchX%, %startSearchY%, %endSearchX%, %endSearchY%, %imageFile%
		If (outputX || outputY)
		{
			x := outputX
			y := outputY
			break
		}
		endSearchY -= 100
		endSearchX -= 100
		Sleep 50
		If (endSearchY <= startSearchY || endSearchX <= startSearchX)
			MsgBox Never found
			break
	}
	return
}