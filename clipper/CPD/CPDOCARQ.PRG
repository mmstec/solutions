
* TITULO     :  Sistema de Contas a Pagar
* DATA       : 25/04/97
* PROGRAMA   : CPDOCARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("CPDOC.DBF")
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
   REPARQ("NUMERO","C", 10,  0)
   REPARQ("CEDENTE","C", 30,  0)
   REPARQ("VALOR","N", 10,  2)
   REPARQ("VENCIMENTO","D",  8,  0)
   REPARQ("PAGAMENTO","D",  8,  0)
   REPARQ("HISTORICO","C", 30,  0)
   CREATE CPDOC FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("CPCHK.DBF")
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
   REPARQ("NUMERO","C", 10,  0)
   REPARQ("CEDENTE","C", 30,  0)
   REPARQ("BANCO","C", 15,  0)
   REPARQ("CONTA","C", 15,  0)
   REPARQ("CIDADE","C", 15,  0)
   REPARQ("VALOR","N", 10,  2)
   REPARQ("VENCIMENTO","D",  8,  0)
   REPARQ("PAGAMENTO","D",  8,  0)
   REPARQ("HISTORICO","C", 30,  0)
   CREATE CPCHK FROM ARQ_STRU
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
 
* Final do programa CPDOCARQ.PRG