///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     CLS
     set date format to "dd,mm,yyyy"
     set date brit
     set epoch to 1900
     set cursor on
     AUTOR        := "(C) Marcos Morais de Sousa - 1995/"+TRAN(YEAR(DATE()),"@E 9999")
     SISTEMA      := "MMSTEC ETIQUETAS (R) - vers„o "+Dtos(directory(procname()+".exe")[1,3])
     EMPRESA      := "MFB Material de constru‡Æo LTDA."
     do while .T.
          NOME         := SPACE(40)
          ENDE         := SPACE(40)
          BAIR         := SPACE(40)
          CIDA         := SPACE(40)
          ESTA         := SPACE(02)
          CEP          := SPACE(09)
          MSUP         := 1
          MESQ         := 1
          @ 01,00 say padc(sistema,80)
          @ 02,00 say padc(autor,80)
          @ 03,00 say padc(EMPRESA,80)
          @ 05,05 SAY REPL("-",70)      COLOR "W/N"
          @ 07,05 say PADL("NOME:",11) GET NOME PICT "@!" COLOR "r/w,W+/B"                         
          @ 08,05 say PADL("ENDERECO:",11) GET ENDE PICT "@!" COLOR "r/w,W+/B"                         
          @ 09,05 say PADL("BAIRRO:",11) GET BAIR PICT "@!" COLOR "r/w,W+/B"                         
          @ 10,05 say PADL("CIDADE:",11) GET CIDA PICT "@!" COLOR "r/w,W+/B"                         
          @ 11,05 say PADL("ESTADO:",11) GET ESTA PICT "@!" COLOR "r/w,W+/B"                         
          @ 12,05 say PADL("CEP:",11) GET CEP PICT "99999-999" COLOR "r/w,W+/B"                         
          @ 16,05 say PADL("MARGEM",11)+PADR("/ETIQUETA",11) 
          @ 18,05 say PADL("SUPERIROR:",11) GET MSUP PICT "@!" COLOR "r/w,W+/B"
          @ 19,05 say PADL("ESQUERDA:",11) GET MESQ PICT "@!" COLOR "r/w,W+/B"
          set cursor on
          read
          set cursor off
          if lastkey()=27
             @ row(), col() say padc(" IMPRESSÇO CANCELADA ",80-COL())
             quit
          endif
          NOME         := ALLTRIM(NOME)
          ENDE         := ALLTRIM(ENDE)
          BAIR         := ALLTRIM(BAIR)
          CIDA         := ALLTRIM(CIDA)
          ESTA         := ALLTRIM(ESTA)
          CEP          := ALLTRIM(CEP)
          MSUP         := MSUP
          MESQ         := MESQ
          set printer on
          set console off
          set device to printer
          if (!isprinter())
              alert("A V I S O;; A IMPRESSORA ESTA DESLIGADA OU APRESENTA PROBLEMAS."+;
                              ";VERIFIQUE O OCORRIDO E TENTE NOVAMENTE")
              quit
              else
              ALERT("PREPARE A IMPRESSORA!",{ PADC("ENTER",7) })
              LIN=MSUP
              COL=MESQ
              @ LIN+0,COL SAY NOME
              @ LIN+1,COL SAY ENDE
              @ LIN+2,COL SAY BAIR
              @ LIN+3,COL SAY CIDA
              @ LIN+4,COL SAY ESTA
              @ LIN+5,COL SAY CEP PICT "99999-999"
          endif
      *If (Alert("IMPRIMIR OUTRA ETIQUETA?;",{ padc("NAO",05), padc("SIM",05) } ,"W+/R") == 1)
      *    EXIT
      *else
      *    CLS
      *    set printer off
      *    set console on
      *    set device to screen
      *    MSUP=1
      *    MESQ=1
      *    LOOP
      *ENDIF
      EXIT
ENDDO
eject
set devi to screen
set printer off
set console on
QUIT
