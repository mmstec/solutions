* ------------------------------------------------------------------------
* Module.......: PCX87.PRG
* Author.......: Pepijn Smits.
* Date.........: Mar 1991
* Copyright....: (c)1991, Pepijn Smits Software.
* Notes........: Clipper '87 Demo of CLFPCX87 library.
* ------------------------------------------------------------------------
* Assumes VGA or EGA installed.
* [But that could of Course be checked using Expand's EGAthere()/VGAthere()]

Parameter PCXfile
Private x

?? "PCX Viewer, Written in Clipper Summer '87 using `Fast' PCX library."
?
if pcount()=0
	? 'Usage:   PCX87 <FileName>'
	? 'Where:   <FileName> is a PCX file. It will then be displayed.'
	? '         PCX87 only supports VGA 320x200x256, VGA 640x480x16 and'
	? '         EGA 640x350x16 full screen pictures.'
	? '         Written by Pepijn Smits.'
else
        if At('.',PCXfile)=0
		PCXfile = PCXfile + '.PCX'
	endif
	save screen
	x = FastPCX(PCXfile)
	do case
		case x = 0		&& Displayed OK.
			* - Now in Graph mode, press key to return to DOS.
			inkey(0)
			txtMode()
			restore screen
		case x = 1
			? 'File Not found.'
		case x = 2
			? 'Not a PCX file.'
		case x = 3
			? 'File has unsupported PCX format.'
	endcase
endif
?
quit
