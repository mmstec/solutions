* ------------------------------------------------------------------------
* Modulo.......: PCX50.PRG
* Autor........: Marcos Morais de Sousa.
* Data.........: Julho 1997
* Copyright....: (C), MMSTEC Artes Gr ficas & Inform tica Ltda - 1995/1997
* Notas........: Clipper 5.x, Demo para biblioteca CLFPCX50.
* ------------------------------------------------------------------------
* Assume VGA ou EGA instalado.
* [But that could of Course be checked using Expand's EGAthere()/VGAthere()]

Parameter PCXfile
Local x
CLS

?? "Vizualizando Arquivo PCX, no "+version()+" usando biblioteca CLFPCX50 no "+OS()
?
if PCXfile = NIL
	
	? 'Use  :   PCX50 <NomeArquivo>'
	? 'Obs. :   <NomeArquivo> ‚ um arquivo PCX.'
	? '         PCX50 suporta VGA 320x200x256, VGA 640x480x16 e'
	? '         EGA 640x350x16 para visualiza‡„o no monitor.'
	? ''
	? '         Att:. Marcos Morais de Sousa.'

else
	if At('.',PCXfile)=0
		PCXfile = PCXfile + '.PCX'
	endif
	save screen
	x := FastPCX(PCXfile)
	do case
		case x = 0          && Displayed OK.
			* - Agora no modo Gr fico, pressione uma tecla e retorne ao Sistema Operacional.
			inkey(0)
			txtMode()
			restore screen
		case x = 1
			? '"&PCXfile" n„o encontrado.'
		case x = 2
			? '"&PCXfile" n„o ‚ arquivo PCX.'
		case x = 3
			? '"&PCXfile" n„o suportou o formato PCX e/ou n„o ‚ verdadeiramente um Arquivo PCX.'
	endcase
endif
?
quit

