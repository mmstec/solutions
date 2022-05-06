
* TITULO     : MFB - Duplicatas e Estoque do Cimento
* DATA       : 25/04/97
* PROGRAMA   : MONTEARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("EST_CIMT.DBF")
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
   REPARQ("DATA","D",  8,  0)
   REPARQ("COMPRA","N", 10,  1)
   REPARQ("VENDA","N", 10,  1)
   REPARQ("PGO_F_PEGA","N", 10,  1)
   REPARQ("HISTORICO","C", 30,  0)
   CREATE EST_CIMT FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("DOCUMENT.DBF")
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
   REPARQ("NDOCUMENTO","C", 15,  0)
   REPARQ("VALOR","N", 10,  2)
   REPARQ("VENCIMENTO","D",  8,  0)
   REPARQ("PAGAMENTO","D",  8,  0)
   REPARQ("HISTORICO","C", 30,  0)
   CREATE DOCUMENT FROM ARQ_STRU
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
 
* Final do programa MONTEARQ.PRG