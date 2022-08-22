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
    public class convidadosDAL
    {
        /// <summary>
        /// Autor: Marcos
        /// </summary> 
        /// <param name="texto">Preencher um DataTable</param>
        /// <returns>Preenche DataTable</returns>
        public DataTable dtListar(string filtro)
        {
            // Acessando o SQL Server
            // Provedor usado : SQL Server .NET Data Provider
            // namespace utilizado : System.Data.SqlClient
            //SqlConnection cn = new SqlConnection();
            //SqlDataAdapter da = new SqlDataAdapter();

            // Acessando o Microsoft Access
            // Provedor usado : Microsoft Jet OLE DB 4.0
            // namespace utilizado : System.Data.Oledb
            OleDbConnection cn = new OleDbConnection();
            OleDbDataAdapter da = new OleDbDataAdapter();
            try
            {
                DataTable dt = new DataTable();
                cn.ConnectionString = DAL.acessoDadosDAL.StringDeConexao;

                //adaptadores
                //da.SelectCommand = new SqlCommand(); // para uso com SQL server
                da.SelectCommand = new OleDbCommand(); // para uso com access
                da.SelectCommand.CommandText = filtro;
                da.SelectCommand.CommandTimeout = 300;
                da.SelectCommand.Connection = cn;

                da.Fill(dt);
                return dt;
            }
            catch (OleDbException ex)
            {
                throw new Exception("Servidor SQL Erro:" + ex.ErrorCode);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            finally
            {
                cn.Close();
            }
        }
    }
}
