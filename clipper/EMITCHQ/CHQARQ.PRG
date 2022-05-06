
* TITULO     : Recep‡„o/Emiss„o de cheques
* DATA       : 15/05/97
* PROGRAMA   : CHQARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("CHQEMT.DBF")
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
   REPARQ("NOMEDOBANK","C", 30,  0)
   REPARQ("NUMEROAGEN","C", 10,  0)
   REPARQ("NUMEROCONT","C", 20,  0)
   REPARQ("NUMERO_CHQ","C", 20,  0)
   REPARQ("VALORDOCHQ","N", 10,  2)
   REPARQ("DATAPPAGAR","D",  8,  0)
   REPARQ("FINALIDADE","C", 30,  0)
   CREATE CHQEMT FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("CHQRCB.DBF")
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
   REPARQ("NUMEROAGEN","C", 10,  0)
   REPARQ("NOMEDOBANK","C", 30,  0)
   REPARQ("NUMEROCONT","C", 20,  0)
   REPARQ("NUMERO_CHQ","C", 20,  0)
   REPARQ("CPFCGC_CLI","C", 14,  0)
   REPARQ("NOMEDO_CLI","C", 40,  0)
   REPARQ("VALORDOCHQ","N", 10,  2)
   REPARQ("DATAPSAQUE","D",  8,  0)
   REPARQ("FINALIDADE","C", 40,  0)
   CREATE CHQRCB FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("BANCOS.DBF")
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
   REPARQ("NUMEROAGEN","C", 10,  0)
   REPARQ("NOMEDOBANK","C", 30,  0)
   CREATE BANCOS FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("CONTAS.DBF")
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
   REPARQ("NUMEROAGEN","C", 10,  0)
   REPARQ("NOMEDOBANK","C", 30,  0)
   REPARQ("NUMEROCONT","C", 20,  0)
   REPARQ("ESPECIFICA","C", 20,  0)
   CREATE CONTAS FROM ARQ_STRU
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
 
* Final do programa CHQARQ.PRG