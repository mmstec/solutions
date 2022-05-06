FUNCTION DBCRIA
   IF !FILE("DBSys.DBF")
      CAMPO0:={}
      AADD( CAMPO0,{"USUARIO","C", 30,  0})   
      AADD( CAMPO0,{"SENHA"  ,"C",  6,  0})
      AADD( CAMPO0,{"NIVEL"  ,"N",  1,  0})
      DBCREATE("dBsys",CAMPO0)
      IF FILE("DBSYS.DBF")
         USE DBSYS
         INDEX on SENHA+USUARIO to iDSYS1.NTX 
         INDEX on USUARIO+SENHA to iDSYS2.NTX 
         ALERT("PARA ENTRAR NO SISTEMA PELA PRIMEIRA VEZ,;"+;
               "CADASTRE PELO MENUS UM USUARIO E SENHA COM NIVEL 3;;"+;
               ";AGORA SEU SISTEMA JA ESTA PRONTO PARA O TRABALHO.;"+;
               ";PARA RECLAMA€åES OU SUGESTåES ENTRER EM CONTATO COM O PROGRAMADOR;;"+;
               ";"+M->AUTOR)
         INCSNH()
         CLS
         CLOSE DATABASES

        ELSE
         ALERT("PROBLEMAS NA CRIACAO DE ARQUIVOS")
         QUIT
      ENDIF
   ENDIF
   IF !FILE("dBFone.DBF") .or. !FILE("dBFone.DBT")
      CAMPO1:={}
      AADD( CAMPO1,{"CODIGO   ","C",  6,  0})
      AADD( CAMPO1,{"NOME     ","C", 45,  0})   
      AADD( CAMPO1,{"ENDERECO ","C", 30,  0})   
      AADD( CAMPO1,{"DDD      ","C",  4,  0})   
      AADD( CAMPO1,{"FONE     ","C", 15,  0})   
      AADD( CAMPO1,{"OBS      ","M", 10,  0})   
      AADD( CAMPO1,{"DATA     ","D",  8,  0})
      DBCREATE("DBFone",CAMPO1)
      IF FILE("DBFONE.DBF") .AND. FILE("DBFONE.DBT")
         USE DBFONE
         DBFONE->(DBAPPEND())
         REPLACE CODIGO    WITH STRZERO(RECNO(),6)
         REPLACE NOME      WITH ALLTRIM(M->AUTOR)
         REPLACE ENDERECO  WITH "CAM 06 CASA 10 PQ. ALGAROBAS"
         REPLACE DDD       WITH "0073"
         REPLACE FONE      WITH "525-2344/5932"
         REPLACE OBS       WITH DTOC(DATE())+" "+TIME()
         REPLACE DATA      WITH DATE()
         CLOSE DATABASES
        ELSE
         ALERT("PROBLEMAS NA CRIACAO DE ARQUIVOS")
         QUIT
      ENDIF
   ENDIF
RETURN.T.
 
 FUNCTION dBcompacta
 CLOSE DATABASES
 SAVE SCREEN TO M->T_ELA
 *RELEVO(05, 05, 21, 54,.F.,,2) // BARRA EQUERDA
 *RELEVO(06, 06, 17, 53,.F.,,2) // BARRA DE TITULO
 *RELEVO(18, 06, 20, 53,.T.,,2) // BARRA DE INFERIOR
 *RELEVO(00, 00, 24, 79,.T.)    // toda MAE
 *RELEVO(05, 55, 21, 74,.F.,,2) // tela DIREITA
 RELEVO(05, 05, 21, 54,.F.,,2) // tela EQUERDA
 RELEVO(06, 06, 08, 53,.T.,,2) // BARRA DE TITULO
 RELEVO(09, 06, 20, 53,.T.,,1) // BARRA INTERNA
 
 @ 07, 08 SAY PADC("MANUTEN€ÇO DA BASE DE DADOS",44)  COLOR "W+/R"
 @ 11, 07 SAY PADC("ATUALIZANDO BASE DE DADOS",43)    COLOR "W+/B"
 SELE 1
 USE DBSYS ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "BG+/B"
 INDEX on SENHA+USUARIO to iDSYS1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS1.NTX °±²Û",43) color "BG/b"
 INDEX on USUARIO+SENHA to iDSYS2.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS2.NTX °±²Û",43) color "BG/b"
 *
 SELE 2
 USE DBFONE ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "BG+/B"
 INDEX on NOME+DDD to idFONE1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDfone1.NTX °±²Û",43) color "BG/b"
 INDEX on DDD+FONE to idFONE2.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDfone2.NTX °±²Û",43) color "BG/b"
 *
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
 @ LIN-1,08 SAY PADC("þ",01) COLOR "W /B";@ LIN-1,09 SAY PADC("þ",01) COLOR "R+/B"
 @ LIN+0,COL+5+ grafico say "Û"+repl(" ",TAM-grafico)                     color "RG+/B"
 @ LIN+0,COL+0+ 0       say padL(alltrim(Str(percentual,3 )+"%"),4)       color "RG+/B"
 @ LIN-1,08 SAY PADC("þ",01) COLOR "G+/B";@ LIN-1,09 SAY PADC("þ",01) COLOR "W /B"
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
