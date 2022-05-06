
* TITULO     :  MFB - Vendas Comissisionadas e Gerais
* DATA       : 03/06/97
* PROGRAMA   : VENDAARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("GRUP1234.DBF")
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
   REPARQ("VENDAS01","N", 10,  2)
   REPARQ("VENDAS02","N", 10,  2)
   REPARQ("VENDAS03","N", 10,  2)
   REPARQ("VENDAS04","N", 10,  2)
   REPARQ("TAXA0001","N",  4,  2)
   REPARQ("TAXA0002","N",  4,  2)
   REPARQ("TAXA0003","N",  4,  2)
   REPARQ("TAXA0004","N",  4,  2)
   REPARQ("DATA","D",  8,  0)
   CREATE GRUP1234 FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("GRUP5678.DBF")
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
   REPARQ("VENDAS05","N", 10,  2)
   REPARQ("VENDAS06","N", 10,  2)
   REPARQ("VENDAS07","N", 10,  2)
   REPARQ("VENDAS08","N", 10,  2)
   REPARQ("TAXA0005","N",  4,  2)
   REPARQ("TAXA0006","N",  4,  2)
   REPARQ("TAXA0007","N",  4,  2)
   REPARQ("TAXA0008","N",  4,  2)
   REPARQ("DATA","D",  8,  0)
   CREATE GRUP5678 FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("VENDASCM.DBF")
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
   REPARQ("DATA______","D",  8,  0)
   REPARQ("FIADO_____","N", 10,  2)
   REPARQ("QDE_SCOS_F","N", 10,  2)
   REPARQ("AVISTA____","N", 10,  2)
   REPARQ("QDE_SCOS_V","N", 10,  2)
   REPARQ("RECEBIDO__","N", 10,  2)
   REPARQ("QDE_SCOS_R","N", 10,  2)
   REPARQ("OBS_______","C", 30,  0)
   CREATE VENDASCM FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("VENDASLJ.DBF")
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
   REPARQ("FIADO","N", 10,  2)
   REPARQ("AVISTA","N", 10,  2)
   REPARQ("RECEBIMENO","N", 10,  2)
   REPARQ("DATA","D",  8,  0)
   CREATE VENDASLJ FROM ARQ_STRU
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
 
* Final do programa VENDAARQ.PRG