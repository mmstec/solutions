* ------------------------------------------------------------------------
* Module.......: CLPFPCX50.PRG
* Author.......: Pepijn Smits.
* Date.........: Mar 1991
* Copyright....: (c)1991, Pepijn Smits Software.
* Notes........: Clipper 5.01 part of Clipper "Fast" EGA/VGA PCX library.
* ------------------------------------------------------------------------
* FastPCX():   Display a EGA/VGA PCX picture on the screen, quickly..
* returns:     0 = All okay, still in Graph mode, restore with txtMode()!
*         1 - file not found
*         2 - not PCX file!
*         3 - Not proper format (not full screen EGA/VGA PCX file)
* Assumes VGA or EGA installed when PCX file requires one.
* [But that could of Course be checked using Expand's EGAthere()/VGAthere()]

Function FastPCX(FileName)
Local Handle := fopen(FileName)
Local Header
Local BPP,X2,Y2               && Bits/Pixel, Lower X and Y
Local Count
Local Palette
Local Buffer
if Handle <= 0
	return 1            && Open Error
else
	Header := Space(128)
	fread(handle,@header,128)
	if SubStr(Header,1,1) <> chr(10)
		fclose(handle)
		return 2       && N„o ‚ um arquivo PCX!
	else
		* - Determine if format Okay, ie. if PCX is:
		* - VGA 320x200x256 or VGA 640x480x16 or EGA 640x350x16
		BPP := Asc(SubStr(Header,4,1))
		X2 := Bin2w(SubStr(Header,9,2))
		Y2 := Bin2w(SubStr(Header,11,2))

		if (BPP=8) .and. (X2=319) .and. (Y2=199)
			* - Got a VGA 320x200x256 here..

			* - Read the Palette Info
			Palette := Space(768)
			fseek(handle,-768,2)
			fread(handle,@palette,768)

			* - Determine length and goto begin picture
			Count := fseek(handle,0,2) - 128 - 768
			buffer := space(Count)
			fseek(handle,128)

			* - Set VGA mode, Palette and Draw the picture.
			VGA13mode()
			SetVGAPal(@Palette,256)
			fread(handle,@buffer,Count)
			VGA13Show(@Buffer,Count)

		elseif (BPP=1) .and. (X2=639) .and. (Y2=479)
			* - Got a VGA 640x480x16 here..

			* - Determine length, and goto begin picture
			Count := fseek(handle,0,2) - 128
			buffer := space(Count)
			fseek(handle,128)

			* - Set VGA mode, Palette and Draw the picture.
			VGA12init()
			Palette := SubStr(Header,17,48)
			SetVGAPal(@Palette,16)
			fread(handle,@buffer,Count)
			VGA12Show(@Buffer,Count)

		elseif (BPP=1) .and. (X2=639) .and. (Y2=349)
			* - Got a EGA 640x350x16 here..

			* - Determine length, and goto begin picture
			Count := fseek(handle,0,2) - 128
			buffer := space(Count)
			fseek(handle,128)

			* - Set EGA mode, Palette and draw the picture.
			EGA10init()
			Palette := SubStr(Header,17,48)
			SetEGApal(@Palette)
			fread(handle,@buffer,Count)
			EGA10Show(@Buffer,Count)

		else
			* - Nope, no supported picture here
			fclose(handle)
			return 3
		endif
		fclose(handle)
		return 0
	endif
endif
