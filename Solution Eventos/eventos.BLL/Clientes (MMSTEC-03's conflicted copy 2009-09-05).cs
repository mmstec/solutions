using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using SIC.DAL;

namespace SIC.BLL
{
    public class ClientesBLL
    {
        public DataTable Listar(string filtro)
        {
            ClientesDAL obj = new ClientesDAL();
            return obj.Listar(filtro);
        }

        public DataTable Selecionar(string filtro)
        {
            ClientesDAL obj = new ClientesDAL();
            return obj.Selecionar(filtro);
        }

        public DataSet RetornarDados(string tabela, string instrucao)
        {
            ClientesDAL obj = new ClientesDAL();
            return obj.RetornarDados(tabela, instrucao);
        }
    }
}
