
* TITULO     : MFB - CONTROLE DE VENDAS
* DATA       : 12/05/97
* PROGRAMA   : MFBARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("CIMENTO.DBF")
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
   REPARQ("CLIENTE","C", 30,  0)
   REPARQ("DOCUMENT","C", 10,  0)
   REPARQ("RS_FIXO","N", 10,  2)
   REPARQ("QUANT_SACO","N", 10,  2)
   REPARQ("TOTAL","N", 10,  2)
   REPARQ("VENDA","D",  8,  0)
   REPARQ("VENCIMENTO","D",  8,  0)
   REPARQ("PAGAMENTO","D",  8,  0)
   REPARQ("OBSERVACAO","C", 30,  0)
   CREATE CIMENTO FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("MANUTENC.DBF")
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
   REPARQ("RS_FIXO","N", 10,  2)
   REPARQ("DATA","D",  8,  0)
   CREATE MANUTENC FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("PAGOFP.DBF")
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
   REPARQ("CLIENTE","C", 30,  0)
   REPARQ("DOCUMENT","C", 10,  0)
   REPARQ("RS_UNITARI","N", 10,  2)
   REPARQ("QUANT_SACO","N", 10,  2)
   REPARQ("TOTAL","N", 10,  2)
   REPARQ("VENDA","D",  8,  0)
   REPARQ("PAGAMENTO","D",  8,  0)
   REPARQ("ENTREGA","D",  8,  0)
   REPARQ("OBSERVACAO","C", 30,  0)
   CREATE PAGOFP FROM ARQ_STRU
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
 
* Final do programa MFBARQ.PRG