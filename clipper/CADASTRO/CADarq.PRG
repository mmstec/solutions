FUNCTION dbCRIA
   IF !FILE("dBsys.DBF")
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
   IF !FILE("dBCAD.DBF") 
      CAMPO1:={}
      // DADOS PESSOAIS //
      AADD( CAMPO1,{"c1DATA"       ,"D",  8,  0}) ;@ 00,00 SAY "CRIADO CAMPO1"  
      AADD( CAMPO1,{"c1CODIGO"     ,"C",  6,  0}) ;@ 00,00 SAY "CRIADO CAMPO2"  
      AADD( CAMPO1,{"c1NOME"       ,"C", 45,  0}) ;@ 00,00 SAY "CRIADO CAMPO3"  
      AADD( CAMPO1,{"c1RG"         ,"C", 15,  0}) ;@ 00,00 SAY "CRIADO CAMPO4"  
      AADD( CAMPO1,{"c1CPF"        ,"C", 15,  0}) ;@ 00,00 SAY "CRIADO CAMPO5"  
      AADD( CAMPO1,{"c1CTRABN"     ,"C", 15,  0}) ;@ 00,00 SAY "CRIADO CAMPO6"  
      AADD( CAMPO1,{"c1CTRABS"     ,"C", 15,  0}) ;@ 00,00 SAY "CRIADO CAMPO7"  
      AADD( CAMPO1,{"c1NASCI"      ,"D",  8,  0}) ;@ 00,00 SAY "CRIADO CAMPO8"  
      AADD( CAMPO1,{"c1ENDE"       ,"C",  6,  0}) ;@ 00,00 SAY "CRIADO CAMPO09"  
      AADD( CAMPO1,{"c1FONE"       ,"C", 15,  0}) ;@ 00,00 SAY "CRIADO CAMPO10"  
      AADD( CAMPO1,{"c1OBS"        ,"M", 10,  0}) ;@ 00,00 SAY "CRIADO CAMPO11"  
      // DADOS DA ULTIMO TRABALHO //
      AADD( CAMPO1,{"c2EMPRESA"    ,"C", 45,  0}) ;@ 00,00 SAY "CRIADO CAMPO12"  
      AADD( CAMPO1,{"c2ENDE"       ,"C",  6,  0}) ;@ 00,00 SAY "CRIADO CAMPO13"  
      AADD( CAMPO1,{"c2FONE"       ,"C", 15,  0}) ;@ 00,00 SAY "CRIADO CAMPO14"  
      AADD( CAMPO1,{"c2CARGO"      ,"C", 30,  0}) ;@ 00,00 SAY "CRIADO CAMPO15"  
      AADD( CAMPO1,{"c2SALARIO"    ,"N", 10,  0}) ;@ 00,00 SAY "CRIADO CAMPO16"  
      AADD( CAMPO1,{"c2ADMISAO"    ,"D",  8,  0}) ;@ 00,00 SAY "CRIADO CAMPO17"  
      AADD( CAMPO1,{"c2DEMISAO"    ,"D",  8,  0}) ;@ 00,00 SAY "CRIADO CAMPO18"  
      AADD( CAMPO1,{"c2MOTIVO"     ,"C", 45,  0}) ;@ 00,00 SAY "CRIADO CAMPO19"  
      DBCREATE("dBCAD",CAMPO1)
      IF FILE("DBCAD.DBF")
         ALERT("OS ARQUIVOS FORAM CRIADOS COM EXITO",,"W+/G")
        ELSE
         ALERT("OS ARQUIVOS NAO PUDERAM SER CRIADOS COM EXITO","W+/R")
         QUIT
      ENDIF
   ENDIF
RETURN.T.
 
 FUNCTION dBcompacta
 CLOSE DATABASES
 SAVE SCREEN TO M->T_ELA
 RELEVO(05, 05, 21, 54,.F.,,2) // BARRA EQUERDA
 RELEVO(06, 06, 17, 53,.F.,,2) // BARRA DE TITULO
 RELEVO(18, 06, 20, 53,.T.,,2) // BARRA DE INFERIOR
 @ 07, 08 SAY PADC("MANUTEN€ÇO DA BASE DE DADOS",44)  COLOR "W+ /R"
 @ 11, 08 SAY PADC("ATUALIZANDO BASE DE DADOS",43)    COLOR "BG+/B"
 *
 SELE 1
 USE DBSYS ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "W+/B"
 INDEX on SENHA+USUARIO to iDSYS1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS1.NTX °±²Û",43) color "B+/b"
 INDEX on USUARIO+SENHA to iDSYS2.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° IDSYS2.NTX °±²Û",43) color "B+/b"
 *
 SELE 2
 USE DBCAD ;PACK;@ 12, 08 SAY PADC(dbf(),43)  COLOR "W+/B"
 INDEX on c1NOME+c1CODIGO to idCAD1.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDCAD1.NTX °±²Û",43) color "B+/b"
 INDEX on c1CODIGO+c1FONE to idCAD2.NTX EVAL {|| GRAFICO(19,07,43) } EVERY 1 ;@ 14,08 SAY PADC("Û²±° iDCAD2.NTX °±²Û",43) color "B+/b"
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
 @ LIN+0,COL+5+ grafico say "Û"+repl(" ",TAM-grafico)                     color "RG+/B"
 @ LIN+0,COL+0+ 0       say padL(alltrim(Str(percentual,3 )+"%"),4)       color "RG+/B"
Return (.T.)

  FUNCTION DBMANUTENCAO
  IF DBF()+".DBF"="DBCAD.DBF"
        ARQ=DBF()+".DBF - REGISTRO DE FUNCIONARIOS"
  ENDIF
  RETURN.T.
