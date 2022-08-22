using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.OleDb;
using System.Data;
using System.Collections;
using eventos.TAB;

namespace eventos.DAL
{
    public class convidados
    {

        /// <summary>
        /// Método CRUD(SELECT, INSERT, UPDADE E DELETE) que executa a query sql.
        /// INSERT
        /// </summary>
        /// <param name="convidados"></param>
        public void executarInsert(TAB.convidados registro)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();

            query.Append("INSERT INTO convidados (");
            query.Append(" convidadosCartao, ");
            query.Append(" convidadosNome, ");
            query.Append(" convidadosTipo, ");
            query.Append(" convidadosPresenca ");
            query.Append(") VALUES (");
            query.Append(" @convidadosCartao, ");
            query.Append(" @convidadosNome, ");
            query.Append(" @convidadosTipo, ");
            query.Append(" @convidadosPresenca ");
            query.Append(")");

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;

                    cmd.Parameters.AddWithValue("@convidadosCartao", registro.convidadosCartao);
                    cmd.Parameters.AddWithValue("@convidadosNome", registro.convidadosNome);
                    cmd.Parameters.AddWithValue("@convidadosTipo", registro.convidadosTipo);
                    cmd.Parameters.AddWithValue("@convidadosPresenca", registro.convidadosPresenca);
                    conn.Open();
                    int resultado = cmd.ExecuteNonQuery();
                    if (resultado != 1)
                    {
                        throw new Exception("Não foi possível INCLUIR o registro.");
                    }
                }
            }
        }

        /// <summary>
        /// Método CRUD(SELECT, INSERT, UPDADE E DELETE) que executa a query sql.
        /// UPDATE
        /// </summary>
        /// <param name="convidados"></param>
        public void executarUpdade(TAB.convidados registro)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();

            query.Append("UPDATE convidados SET ");
            query.Append(" convidadosCartao=@convidadosCartao, ");
            query.Append(" convidadosNome=@convidadosNome, ");
            query.Append(" convidadosTipo=@convidadosTipo, ");
            query.Append(" convidadosPresenca=@convidadosPresenca ");
            query.Append(" WHERE convidadosId=@convidadosId");

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;

                    cmd.Parameters.AddWithValue("@convidadosCartao", registro.convidadosCartao);
                    cmd.Parameters.AddWithValue("@convidadosNome", registro.convidadosNome);
                    cmd.Parameters.AddWithValue("@convidadosTipo", registro.convidadosTipo);
                    cmd.Parameters.AddWithValue("@convidadosPresenca", registro.convidadosPresenca);
                    cmd.Parameters.AddWithValue("@convidadosId", registro.convidadosId);
                    conn.Open();
                    int resultado = cmd.ExecuteNonQuery();
                    if (resultado != 1)
                    {
                      throw new Exception("Não foi possível ALTERAR o registro.");
                    }
                }
            }
        }

        /// <summary>
        /// Método CRUD(SELECT, INSERT, UPDADE E DELETE) que executa a query sql.
        /// DELETE
        /// </summary>
        /// <param name="convidados"></param>
        public void executarDelete(int p)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();

            query.Append("DELETE * FROM convidados WHERE ");
            query.Append(" convidadosId=@convidadosId");

            using (OleDbConnection conn = new OleDbConnection(connect))
            {
                using (OleDbCommand cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@convidadosId", p);
                    conn.Open();
                    int resultado = cmd.ExecuteNonQuery();
                    if (resultado != 1)
                    {
                        throw new Exception("Não foi possível DELETAR o registro.");
                    }
                }
            }
        }



        public ArrayList retornarQueryArrayList(string query)
        {
            var connect = dados.stringConnection;
            using (OleDbConnection conn = new OleDbConnection(connect))
            {
                using (OleDbCommand cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;
                    conn.Open();
                    OleDbDataReader dr = cmd.ExecuteReader();
                    ArrayList lista = new ArrayList();
                    while (dr.Read())
                    {
                        TAB.convidados registro = new TAB.convidados();
                        registro.convidadosId = Convert.ToInt32(dr["convidadosId"]);
                        registro.convidadosNome = dr["convidadosNome"].ToString();
                        registro.convidadosCartao = dr["convidadosCartao"].ToString();
                        registro.convidadosTipo = dr["convidadosTipo"].ToString();
                        registro.convidadosPresenca = dr["convidadosPresenca"].ToString();
                        lista.Add(registro);
                    }
                    dr.Close();
                    conn.Close();
                    return lista;
                }
            }
            
        }
    }
}
