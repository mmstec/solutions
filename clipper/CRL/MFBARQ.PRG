
* TITULO     : *** Barreto Constru‡„o ***
* DATA       : 17/04/97
* PROGRAMA   : MFBARQ.PRG
* COMENTARIO : CRIACAO DE ARQUIVOS
 
FUNCTION CRIARQ
*
* -> Funcao que cria banco de dados (arquivos "DBF")
**
** Bloco de inser‡„o ARQ.B01
**
IF .NOT. FILE("AVISTACM.DBF")
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
     REPARQ("NOMECLIENT","C", 30,  0)
     REPARQ("NATADUPLIC","C", 13,  0)
     REPARQ("QUANTSACOS","N", 10,  2)
     REPARQ("VALORUNITA","N", 10,  2)
     REPARQ("VALORVENDA","N", 10,  2)
     REPARQ("VENDEDOR","C",  1,  0)
     REPARQ("OBSERVACAO","C", 30,  0)
     CREATE AVISTACM FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("AVISTALJ.DBF")
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
     REPARQ("FORMAVENDA","C",  1,  0)
     REPARQ("NOMECLIENT","C", 30,  0)
     REPARQ("NATADUPLIC","C", 13,  0)
     REPARQ("VALORVENDA","N", 10,  2)
     REPARQ("VENDEDOR","C",  1,  0)
     REPARQ("OBSNUMERO","C", 13,  0)
     REPARQ("OBSERVACAO","C", 30,  0)
     CREATE AVISTALJ FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("APRAZOCM.DBF")
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
     REPARQ("DATAVENDA","D",  8,  0)
     REPARQ("DATAVENCI","D",  8,  0)
     REPARQ("DATAPAGAM","D",  8,  0)
     REPARQ("REFERENCIA","C", 14,  0)
     REPARQ("NOMECLIENT","C", 30,  0)
     REPARQ("NATADUPLIC","C", 13,  0)
     REPARQ("QUANTSACOS","N", 10,  2)
     REPARQ("VALORUNITA","N", 10,  2)
     REPARQ("VALORVENDA","N", 10,  2)
     REPARQ("VENDEDOR","C",  1,  0)
     REPARQ("OBSERVACAO","C", 30,  0)
     REPARQ("DIGITADOR","C", 20,  0)
     CREATE APRAZOCM FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("APRAZOLJ.DBF")
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
     REPARQ("DATAVENDA","D",  8,  0)
     REPARQ("DATAVENCI","D",  8,  0)
     REPARQ("DATAPAGAM","D",  8,  0)
     REPARQ("REFERENCIA","C", 14,  0)
     REPARQ("NOMECLIENT","C", 30,  0)
     REPARQ("NATADUPLIC","C", 13,  0)
     REPARQ("VALORVENDA","N", 10,  2)
     REPARQ("VENDEDOR","C",  1,  0)
     REPARQ("OBSERVACAO","C", 30,  0)
     REPARQ("DIGITADOR","C", 20,  0)
     CREATE APRAZOLJ FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("UNITARIO.DBF")
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
     CREATE UNITARIO FROM ARQ_STRU
ENDIF
USE
ERASE ARQ_STRU.DBF
IF .NOT. FILE("FICHACLI.DBF")
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
     REPARQ("CODICPFCGC","C", 14,  0)
     REPARQ("________RG","C", 14,  0)
     REPARQ("INSCRICAOE","C", 14,  0)
     REPARQ("NOMECPFCGC","C", 30,  0)
     REPARQ("NOMEFANTAS","C", 30,  0)
     REPARQ("ENDERECO","C", 30,  0)
     REPARQ("BAIRRO","C", 30,  0)
     REPARQ("CIDADE","C", 18,  0)
     REPARQ("CEP","C", 10,  0)
     REPARQ("ESTADO","C",  2,  0)
     REPARQ("TELEFONE01","C", 13,  0)
     REPARQ("TELEFONE02","C", 13,  0)
     REPARQ("TELEFONE03","C", 13,  0)
     REPARQ("AVAL_NOME","C", 30,  0)
     REPARQ("AVAL_CPF","C", 14,  0)
     REPARQ("REFCOM_001","C", 30,  0)
     REPARQ("REFCOM_002","C", 30,  0)
     REPARQ("REFCOM_003","C", 30,  0)
     REPARQ("REFCOMFON1","C", 13,  0)
     REPARQ("REFCOMFON2","C", 13,  0)
     REPARQ("REFCOMFON3","C", 13,  0)
     REPARQ("OBSERVACAO","M", 10,  0)
     REPARQ("QUALIFICAC","C",  1,  0)
     REPARQ("DATAINCLUS","D",  8,  0)
     REPARQ("DIGITADOR","C", 20,  0)
     CREATE FICHACLI FROM ARQ_STRU
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