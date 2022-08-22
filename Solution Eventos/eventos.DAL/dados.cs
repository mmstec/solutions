using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data;	            //  É o principal espaço de nomes da ADO .NET e contém as classes usadas por todos os provedores; classes que representam tabelas, colunas, linhas e também a classe DataSet. Além disso possui diversas interfaces como IDbCommand, IDbConnection, e IDbDataAdapter que são usadas por todos os provedores gerenciados.
using System.Data.OleDb;        //	Define classes que trabalham com fonte de dados OLE DB usando o provedor .NET OleDb.
using System.Data.Odbc;         //	Define classes que trabalham com fonte de dados ODBC usando o provedor .NET Odbc.
using System.Data.SqlClient;    //	Define classes que trabalham com fonte de dados SQL Server 7.0 ou superior.
using System.Data.SqlTypes;     //	Define classes que representam tipos de dados específicos para o SQL Server.

namespace eventos.DAL
{

    /// Design Pattern
    /// GUI->BLL->DAL->BD 
    /// 
    /// <summary>
    /// Titulo:         DAL (Data Access Layer) 
    /// Descrição:      Classe para ao acesso à dados
    /// Criador:        Marcos Morais de Sousa
    /// Criada em:      01/04/2010
    /// Contato:        mmstec@gmail.com
    /// leia: http://www.brunocampagnolo.com/2009_2/aspnet/dal/indexJavaScript.html
    /// </summary>
    
    public class dados
    {
        public static string stringConnection
        {
            get{return @""+ConfigurationManager.ConnectionStrings["ROTA"].ToString();}
        }
 
        //MÉTODOS
        /// <summary>
        /// Método que retorna a conexão com  a base de dados.
        /// </summary>
        /// <returns></returns> 
        public static OleDbConnection connection()
        {
            try
            {
                //Instância o sqlconnection com a string de conexão.
                //SqlConnection sqlconnection = new SqlConnection(ConfigurationSettings.AppSettings["ConnectionString"].ToString());
                OleDbConnection cnn = new OleDbConnection(ConfigurationManager.ConnectionStrings["ROTA"].ToString());
                //Verifica se a conexão esta fechada.
                if (cnn.State == ConnectionState.Closed)
                {
                    //Abri a conexão.
                    cnn.Open();
                }
                //Retorna o sqlconnection.
                return cnn;
            }
            catch (OleDbException ex)
            {
                throw ex;
            }

        }

        /// <summary>
        /// Método que retorna um datareader com o resultado da query.
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        public OleDbDataReader retornarQuery(string query)
        {
            try
            {
                //Instância o sqlcommand com a query sql que será executada e a conexão.
                OleDbCommand comando = new OleDbCommand(query, dados.connection());

                //Executa a query sql.
                var retornaQuery = comando.ExecuteReader();

                //Fecha a conexão.
                connection().Close();

                //Retorna o dataReader com o resultado
                return retornaQuery;

            }
            catch (OleDbException ex)
            {
                throw ex;
            }

        }

          /// <summary>
        /// Método que retorna o resultado da consulta sql em um dataTable.
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        public DataTable retornarQueryDataTable(string query)
        {
            var connect = dados.stringConnection;
            var dt = new DataTable();

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query, conn))
                {
                    cmd.CommandType = CommandType.Text;
                    var da = new OleDbDataAdapter(cmd);
                    da.Fill(dt);
                    return dt;
                }
            }
        }


        /// <summary>
        /// Método que retorna o resultado da consulta sql em um dataTable.
        /// </summary>
        /// <param name="query"></param>
        /// <returns></returns>
        public DataSet retornarQueryDataSet(string query)
        {
            var connect = dados.stringConnection;
            var ds = new DataSet();

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query, conn))
                {
                    cmd.CommandType = CommandType.Text;
                    var da = new OleDbDataAdapter(cmd);
                    da.Fill(ds);
                    return ds;
                }
            }
        }

        /// <summary>
        /// Método CRUD que executa a query sql.
        /// SELECT, INSERT, DELETE E UPDADE
        /// </summary>
        /// <param name="query"></param>
        public void executarQuery(string query)
        {
            try
            {
                //Instância o sqlcommand com a query sql que será executada e a conexão.
                OleDbCommand comando = new OleDbCommand(query, dados.connection());
                //Executa a query sql.
                comando.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        /// <summary>
        /// Método que executa a query sql e retorna o identity.
        /// </summary>
        /// <param name="query"></param>
        public int executaQueryIdentity(string query)
        {
            try
            {
                //Instância o sqlcommand com a query sql que será executada e a conexão.
                OleDbCommand comando = new OleDbCommand(query, dados.connection());
                comando.CommandType = CommandType.Text;

                //Executa a query sql.

                //comando.ExecuteNonQuery();
                return Convert.ToInt32(comando.ExecuteScalar());

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
