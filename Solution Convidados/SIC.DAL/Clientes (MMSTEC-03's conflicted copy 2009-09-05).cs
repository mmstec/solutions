using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace SIC.DAL
{
    public class ClientesDAL

    {
        /// <summary>
        /// Autor: Marcos
        /// Realizar comandos (Update, Delete, Insert)
        /// Exemplo: DataSet utilizador = RetornarDados("utilizadores", "SELECT codigo, nome FROM tabela WHERE nome='Marcos'");
        /// </summary> 
        /// <param name="texto">Preencher um DataSet (Select)</param>
        /// <returns>Preencher um DataSet (Select)</returns>
        public DataSet RetornarDados(string tabela, string instrucao)
        {
            SqlConnection ligar = new SqlConnection(DAL.AcessoDados.StringDeConexao);
            ligar.Open();
            SqlDataAdapter da = new SqlDataAdapter(instrucao, ligar);
            DataSet ds = new DataSet();
            da.Fill(ds, tabela);
            ligar.Close();
            return ds;
        }

        public DataTable Listar(string filtro)
        {
            SqlConnection cn = new SqlConnection();
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt = new DataTable();

            try
            {
                cn.ConnectionString = DAL.AcessoDados.StringDeConexao;
                
                //adaptador
                da.SelectCommand = new SqlCommand();
                da.SelectCommand.CommandText = "spSelecionaCliente";
                da.SelectCommand.CommandTimeout = 300;
                da.SelectCommand.Connection = cn;
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                //parâmetros da stored procedure
                SqlParameter pfiltro;
                pfiltro = da.SelectCommand.Parameters.Add("@filtro", SqlDbType.Text);
                pfiltro.Value = filtro;

                da.Fill(dt);
                return dt;
            }
            catch (SqlException ex)
            {
                throw new Exception("Servidor SQL Erro:" + ex.Number);
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

        public DataTable Selecionar(string filtro)
        {
            ClientesDAL obj = new ClientesDAL();
            return obj.Selecionar(filtro);
        }
    }
}
