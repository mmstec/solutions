
* TITULO     : ALGO - LIVRO DE PRECOS
* DATA       : 12/05/97
* PROGRAMA   : LIVROARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("PRODUTOS.DBF")
     CREATE ARQ_STRU
     IF .NOT. USEREDE("ARQ_STRU",.T.,10)
          @ 0,0 SAY "" 
          ? CHR(7)
          MENSAGEM("Nao foi possivel criar os arquivos",5)
          SET COLOR TO W
          CLEAR
          SET CURSOR ON
          CLOSE ALL
          QUIT
     ENDIF
     REPARQ("REFERENCIA","C", 15,  0)
     REPARQ("GRUPOOOOOO","C", 20,  0)
     REPARQ("DESCRICAOO","C", 35,  0)
     REPARQ("MARCAAAAAA","C", 10,  0)
     REPARQ("PRECOAVIST","N", 10,  2)
     REPARQ("DIGITADOR","C", 20,  0)
     CREATE PRODUTOS FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("GRUPOSSS.DBF")
     CREATE ARQ_STRU
     IF .NOT. USEREDE("ARQ_STRU",.T.,10)
          @ 0,0 SAY "" 
          ? CHR(7)
          MENSAGEM("Nao foi possivel criar os arquivos",5)
          SET COLOR TO W
          CLEAR
          SET CURSOR ON
          CLOSE ALL
          QUIT
     ENDIF
     REPARQ("CODIGOOOOO","C",  1,  0)
     REPARQ("DESCRICAOO","C", 20,  0)
     REPARQ("OBSERVACAO","M", 10,  0)
     REPARQ("DIGITADOR","C", 20,  0)
     CREATE GRUPOSSS FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
 
FUNCTION REPARQ
*
* -> Funcao que carrega os dados dos campos no arquivo "ARQ_STRU"
PARA REP1,REP2,REP3,REP4
IF .NOT. ADIREG(0)
     @ 0,0 SAY ""
     ? CHR(7)
     MENSAGEM("Nao foi possivel criar os arquivos",5)
     SET COLOR TO W
     CLEAR
     SET CURSOR ON
     CLOSE ALL
     QUIT
ENDIF
REPLACE FIELD_NAME WITH M->REP1,FIELD_TYPE WITH M->REP2
REPLACE FIELD_LEN  WITH M->REP3,FIELD_DEC  WITH M->REP4
UNLOCK
**
** Bloco de inser‡„o ARQ.B02
**
 
* Final do programa LIVROARQ.PRG