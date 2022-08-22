using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;	            //  É o principal espaço de nomes da ADO .NET e contém as classes usadas por todos os provedores; classes que representam tabelas, colunas, linhas e também a classe DataSet. Além disso possui diversas interfaces como IDbCommand, IDbConnection, e IDbDataAdapter que são usadas por todos os provedores gerenciados.
using System.Data.OleDb;        //	Define classes que trabalham com fonte de dados OLE DB usando o provedor .NET OleDb.
using System.Data.Odbc;         //	Define classes que trabalham com fonte de dados ODBC usando o provedor .NET Odbc.
using System.Data.SqlClient;    //	Define classes que trabalham com fonte de dados SQL Server 7.0 ou superior.
using System.Data.SqlTypes;     //	Define classes que representam tipos de dados específicos para o SQL Server.

namespace EVENTOS.DAL
{
        
    public class acessoDadosDAL
    {
        #region STRING DE CONEXÃO
    
            // Firebird
            private const string connFirebird = @"User=SYSDBA;Password=masterkey;Database=c:\mmstec\database\small.gdb;DataSource=localhost;Port=3050;Dialect=3;";

            // Microsoft Paradox Driver 5.X
            // Tipo:  ODBC Driver
            // Uso.:  Driver={Microsoft Paradox Driver (*.db )}
            private const string connParadox5 = @"Driver={Microsoft Paradox Driver (*.db )};DriverID=538;Fil=Paradox 5.X;DefaultDir=c:\mmstec\winsic.mms\;Dbq=c:\mmstec\winsic.mms\;CollatingSequence=ASCII";

            // Microsoft Paradox Driver 7.X
            // Tipo:  ODBC Driver
            // Uso.:  Driver={Microsoft Paradox Driver (*.db )}
            private const string connParadox7 = @"Provider=MSDASQL;Persist Security Info=False;Mode=Read;Extended Properties='DSN=Paradox;DBQ=C:\mmstec\winsic.mms;DefaultDir=c:\mmstec\winsic.mms;DriverId=538;FIL=Paradox 7.X;MaxBufferSize=2048;PageTimeout=600;';Initial Catalog=C:\mmstec\winsic.mms";

            // Microsoft Jet OLE DB 4.0/OLE DB 12.0
            // Tipo:  OLE DB Provider
            // Uso.:  Provider=Microsoft.Jet.OLEDB.4.0
            private const string conexaoParadox     = @"Provider=Microsoft.Jet.OleDb.4.0;Data Source=c:\winsic;Extended Properties=Paradox 4.x;";
            private const string conexaoAccess      = @"Provider=Microsoft.Jet.OleDb.4.0;Data Source=C:\mmstec\My Dropbox\DATABASE\convidados.mdb";
            private const string conexaoAccess2007  = @"Provider=Microsoft.Jet.OleDb.12.0;Data Source=C:\mmstec\My Dropbox\DATABASE\convidados.accdb";    
            private const string conexaoFirebird    = @"Provider=IbOleDb;Location=localhost;Data Source=c:\mmstec\database\small.gdb;User ID=SYSDBA;Password=masterkey;Extended Properties='sql Dialect=3;Character Set=ISO8859_1;Collate = PT_BR'";
            private const string conexaoSql         = @"Provider=SqlOleDb;Data Source=bmc-01\sqlexpress;Initial Catalog=SIC;User ID=sa;Password=sa$123S";
            
            //SQL NATIVO
            private const string conexaoSqlPadrao   = @"Data Source=bmc-01\sqlexpress;Initial Catalog=SIC;User ID=sa;Password=sa$123S";

            // Fonte: http://www.connectionstrings.com/

        #endregion 

        public static string StringDeConexao
        {
            get
            {
                return conexaoAccess;
            }
        }


    }
}
