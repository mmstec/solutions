
* TITULO     :  M.F.B.   Consulta de Cheques   Vers„o 1.0
* DATA       : 09/04/97
* PROGRAMA   : FINANARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("FINANCAS.DBF")
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
     REPARQ("ESTADO","C",  1,  0)
     REPARQ("NUMERO_DOC","C", 15,  0)
     REPARQ("CLIENT_DOC","C", 40,  0)
     REPARQ("VALOR__DOC","N", 10,  2)
     REPARQ("F_PAG__DOC","C",  1,  0)
     REPARQ("OBS_01_DOC","C", 30,  0)
     REPARQ("OBS_02_DOC","C", 30,  0)
     REPARQ("VENCIM_DOC","D",  8,  0)
     REPARQ("PAGAME_DOC","D",  8,  0)
     REPARQ("BANCO","C",  3,  0)
     CREATE FINANCAS FROM ARQ_STRU
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
 
* Final do programa FINANARQ.PRG