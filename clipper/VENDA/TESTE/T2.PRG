clear
set color to W+/N,W+/B
set date format to "dd,mm,yy"
set date brit
arq1 :="DBVALOR"   // origem  de dados
arq2 :="BACKUP"   // destino de dados
M->contaREG:=0
sele 1
     use (arq1)
     index on dtos(data)+LKCONTA+LKCAIXA TO TRANSF.NTX
     
sele 2
     use (arq2)
     zap
sele 1
go top
do while (arq1)->(!eof())
         @ 07, 20 say "Arquivo        :" + padl(DBF(),10)   color 'w/n'
         @ 08, 20 say "Registro Total :" +Str(LastRec(),10) color 'w/n'
         @ 09, 20 say "Registro Atual :" +Str(M->contaREG,10) color 'w/n'
         v0    :=(arq1)->DATA
         v1    :=(arq1)->LKCONTA
         v2    :=(arq1)->LKCAIXA
         v3    :=(arq1)->VALOR
         v4    :=(arq1)->COMISSAO
         sele 2
         append blank
         (arq2)->DATA       := v0
         (arq2)->LKCONTA    := V1
         (arq2)->LKCAIXA    := V2
         (arq2)->VALOR      := v3
         (arq2)->COMISSAO   := v4
         
         @ 11, 20 say "Arquivo        :" +padL(DBF(),10)
         @ 12, 20 say "Registro Total :" +Str(LastRec(),10)
         @ 13, 20 say "Registro Atual :" +Str(Recno(),10)
         sele 1                           
         M->contaREG++
         skip
enddo
close databases
QUIT

