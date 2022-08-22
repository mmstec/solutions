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
    public class usuarios
    {
        /// <summary>
        /// Método CRUD(SELECT, INSERT, UPDADE E DELETE) que executa a query sql.
        /// INSERT
        /// </summary>
        /// <param name="usuarios"></param>
        public void executarInsert(TAB.usuarios registro)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();
                   
            query.Append("INSERT INTO usuarios (");
            query.Append(" usuariosNome, ");
            query.Append(" usuariosLogin, ");
            query.Append(" usuariosSenha, ");
            query.Append(" usuariosPerfil, ");
            query.Append(" usuariosOnline, ");
            query.Append(" usuariosEmail, ");
            query.Append(" usuariosDataLogin, ");
            query.Append(" usuariosDataCadastro, ");
            query.Append(" usuariosFoto ");
            query.Append(") VALUES (");
            query.Append(" @usuariosNome, ");
            query.Append(" @usuariosLogin, ");
            query.Append(" @usuariosSenha, ");
            query.Append(" @usuariosPerfil, ");
            query.Append(" @usuariosOnline, ");
            query.Append(" @usuariosEmail, ");
            query.Append(" @usuariosDataLogin, ");
            query.Append(" @usuariosDataCadastro, ");
            query.Append(" @usuariosFoto ");
            query.Append(")");

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@usuariosNome", registro.usuariosNome);
                    cmd.Parameters.AddWithValue("@usuariosLogin", registro.usuariosLogin);
                    cmd.Parameters.AddWithValue("@usuariosSenha", registro.usuariosSenha);
                    cmd.Parameters.AddWithValue("@usuariosPerfil", registro.usuariosPerfil);
                    cmd.Parameters.AddWithValue("@usuariosOnline", registro.usuariosOnline);
                    cmd.Parameters.AddWithValue("@usuariosEmail", registro.usuariosEmail);
                    cmd.Parameters.AddWithValue("@usuariosDataLogin", registro.usuariosDataLogin);
                    cmd.Parameters.AddWithValue("@usuariosDataCadastro", registro.usuariosDataCadastro);
                    cmd.Parameters.AddWithValue("@usuariosDataFoto", registro.usuariosFoto);
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
        /// <param name="usuarios"></param>
        public void executarUpdade(TAB.usuarios registro)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();

            query.Append("UPDATE usuarios SET ");
            query.Append(" usuariosNome=@usuariosNome, ");
            query.Append(" usuariosLogin=@usuariosLogin, ");
            query.Append(" usuariosSenha=@usuariosSenha, ");
            query.Append(" usuariosPerfil=@usuariosPerfil, ");
            query.Append(" usuariosOnline=@usuariosOnline, ");
            query.Append(" usuariosEmail=@usuariosEmail, ");
            query.Append(" usuariosDataLogin=@usuariosDataLogin, ");
            query.Append(" usuariosDataCadastro=@usuariosDataCadastro, ");
            query.Append(" usuariosFoto=@usuariosFoto ");
            query.Append(" WHERE usuariosId=@usuariosId");

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@usuariosNome", registro.usuariosNome);
                    cmd.Parameters.AddWithValue("@usuariosLogin", registro.usuariosLogin);
                    cmd.Parameters.AddWithValue("@usuariosSenha", registro.usuariosSenha);
                    cmd.Parameters.AddWithValue("@usuariosPerfil", registro.usuariosPerfil);
                    cmd.Parameters.AddWithValue("@usuariosOnline", registro.usuariosOnline);
                    cmd.Parameters.AddWithValue("@usuariosEmail", registro.usuariosEmail);
                    cmd.Parameters.AddWithValue("@usuariosDataLogin", registro.usuariosDataLogin);
                    cmd.Parameters.AddWithValue("@usuariosDataCadastro", registro.usuariosDataCadastro);
                    cmd.Parameters.AddWithValue("@usuariosFoto", registro.usuariosFoto);
                    cmd.Parameters.AddWithValue("@usuariosId", registro.usuariosID);
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
        /// <param name="usuarios"></param>
        public void executarDelete(int usuarioID)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();

            query.Append("DELETE * FROM usuarios WHERE ");
            query.Append(" usuariosId=@usuariosId");

            using (OleDbConnection conn = new OleDbConnection(connect))
            {
                using (OleDbCommand cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@usuariosId", usuarioID);
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
                        TAB.usuarios registro = new TAB.usuarios();
                        registro.usuariosID = Convert.ToInt32(dr["usuariosId"]);
                        registro.usuariosNome = dr["usuariosNome"].ToString();
                        registro.usuariosLogin = dr["usuariosLogin"].ToString();
                        lista.Add(registro);
                    }
                    dr.Close();
                    conn.Close();
                    return lista;
                }
            }
            
        }

        public void executarUpdadeLogin(TAB.usuarios registro)
        {
            var connect = dados.stringConnection;
            var query = new StringBuilder();

            query.Append("UPDATE usuarios SET ");
            query.Append(" usuariosOnline=@usuariosOnline, ");
            query.Append(" usuariosDataLogin=@usuariosDataLogin ");
            query.Append(" WHERE usuariosId=@usuariosId");

            using (var conn = new OleDbConnection(connect))
            {
                using (var cmd = new OleDbCommand(query.ToString(), conn))
                {
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.AddWithValue("@usuariosOnline", registro.usuariosOnline);
                    cmd.Parameters.AddWithValue("@usuariosDataLogin", registro.usuariosDataLogin);
                    cmd.Parameters.AddWithValue("@usuariosId", registro.usuariosID);
                    conn.Open();
                    int resultado = cmd.ExecuteNonQuery();
                    if (resultado != 1)
                    {
                        throw new Exception("Não foi possível atualizar o registro.");
                    }
                }
            }
        }
    }
}
