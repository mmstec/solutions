FUNCTION dbCRIA
   IF !FILE("dBsys.DBF")
      CAMPO0:={}
      AADD( CAMPO0,{"USUARIO","C", 30,  0})   
      AADD( CAMPO0,{"SENHA"  ,"C",  6,  0})
      AADD( CAMPO0,{"NIVEL"  ,"N",  1,  0})
      DBCREATE("dBsys",CAMPO0)
   ENDIF
RETURN.T.
 
 FUNCTION dBcompacta()
 SAVE SCREEN TO M->T_ELA
 RELEVO(05, 05, 21, 54,.F.,,2) // BARRA EQUERDA
 RELEVO(06, 06, 17, 53,.F.,,2) // BARRA DE TITULO
 RELEVO(18, 06, 20, 53,.T.,,2) // BARRA DE INFERIOR
 @ 07, 08 SAY PADC("MANUTEN€ÇO DA BASE DE DADOS",44)  COLOR "W+ /R"
 @ 11, 08 SAY PADC("ATUALIZANDO BASE DE DADOS",43)    COLOR "BG+/B"
 *
 SELE 1
 USE DBCONTA ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "W+/B"
 INDEX on CODIGO to idCONTA1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDconta1.NTX °±²Û",43) color "B+/b"
 *
 SELE 2
 USE DBCAIXA ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "W+/B"
 INDEX on CODIGO to idCAIXA1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDcaixa1.NTX °±²Û",43) color "B+/b"
 ****
 SELE 3
 USE DBVALOR ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "W+/B"
 INDEX on DTOS(DATA)+LKCONTA+LKCAIXA to idVALOR1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDvalor1.NTX °±²Û",43) color "B+/b"
 INDEX on DTOS(DATA)+LKCAIXA+LKCONTA to idVALOR2.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDvalor2.NTX °±²Û",43) color "B+/b"
 INDEX on LKCONTA+LKCAIXA+DTOS(DATA) to idVALOR3.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDvalor3.NTX °±²Û",43) color "B+/b"
 INDEX on LKCAIXA+LKCONTA+DTOS(DATA) to idVALOR4.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDvalor4.NTX °±²Û",43) color "B+/b"
 INDEX on MES_ANO(DATA) to idVALOR5.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDvalor4.NTX °±²Û",43) color "B+/b"
 ****
 SELE 4
 USE DBSYS ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "W+/B"
 INDEX on SENHA+USUARIO to iDSYS1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS1.NTX °±²Û",43) color "B+/b"
 INDEX on USUARIO+SENHA to iDSYS2.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS2.NTX °±²Û",43) color "B+/b"
 INDEX on SENHA         to iDSYS3.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS3.NTX °±²Û",43) color "B+/b"
 RESTORE SCREEN FROM M->T_ELA
 RETURN.T.                                                                   

FUNCTION GRAFICO(LIN,COL,TAM,TITULO)
 IF LIN=NIL
    LIN=12
 ENDIF
 IF COL=NIL
    COL=(80-54)-2
 ENDIF
 IF TAM=NIL
    TAM=54
 ENDIF
 IF TITULO=NIL
    TITULO="ARQUIVO:"+ALIAS()
 ENDIF
 TAM=TAM-5
 GRAFICO   := int ( ( RecNo() / LastRec() ) * TAM  )
 PERCENTUAL:= int ( ( RecNo() / LastRec() ) * 100  )
 @ LIN+0,COL+5+ grafico say "Û"+repl(" ",TAM-grafico)                     color "RG+/B"
 @ LIN+0,COL+0+ 0       say padL(alltrim(Str(percentual,3 )+"%"),4)       color "RG+/B"
Return (.T.)

  FUNCTION DBMANUTENCAO
  IF DBF()+".DBF"="DBCONTA.DBF"
        ARQ=DBF()+".DBF - ARQUIVO DE CONTAS"
  ELSEIF DBF()+".DBF"="DBCAIXA.DBF" 
        ARQ=DBF()+".DBF - ARQUIVO DE CAIXAS"
  ELSEIF DBF()+".DBF"="DBVALOR.DBF"
        DBVALOR->COMISSAO=COMISSAO(VALOR,LKCONTA,LKCAIXA)
        ARQ=DBF()+".DBF - ARQUIVO DE VALORES"
        M->PERCENTUAL:=(DBVALOR->(COMISSAO)/DBVALOR->(VALOR))*100 
        dBvalor->LKPERC  =M->PERCENTUAL
        IF DBVALOR->COMISSAO<>0
           dBvalor->LKRESP  ="S"
           ELSE
           dBvalor->LKRESP  ="N"
       ENDIF
  ENDIF
  RETURN.T.
