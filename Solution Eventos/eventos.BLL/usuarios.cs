using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using eventos.DAL;
using eventos.TAB;
using System.Collections;

namespace eventos.BLL
{
    /// <summary>
    /// Nome        : usuariosBLL
    /// Criador     : Marcos Morais de Sousa
    /// Criada      : 03/04/2010
    /// Contato     : mmstec@gmail.com
    /// Observação  : Business Logic Layer
    ///               Esta classe implementa as regras de negócio
    /// </summary>
    public class usuarios
    {
        public DataTable retornarQueryDataTable(string query)
        {
            DAL.dados cmd = new DAL.dados();
            return cmd.retornarQueryDataTable(query);
        }
        public ArrayList retornarQueryArrayList(string query)
        {
            DAL.usuarios cmd = new DAL.usuarios();
            return cmd.retornarQueryArrayList(query);
        }
        public void executarInsert(TAB.usuarios registro)
        {
            if (registro.usuariosEmail == null)
            {
                registro.usuariosEmail = string.Empty;
            }
            else
            {
                registro.usuariosEmail = registro.usuariosEmail.ToLower();
            }
            if (registro.usuariosOnline == null)
            {
                registro.usuariosOnline = false;
            }
            if (registro.usuariosDataCadastro == null)
            {
                registro.usuariosDataCadastro = DateTime.Now.Date;
            }
            if (registro.usuariosDataLogin == null)
            {
                registro.usuariosDataLogin = DateTime.Now.Date;
            }
            DAL.usuarios cmd = new DAL.usuarios();
            cmd.executarInsert(registro);
        }
        public void executarUpdate(TAB.usuarios registro)
        {
            if (registro.usuariosEmail == null)
            {
                registro.usuariosEmail = string.Empty;
            }
            else
            {
                registro.usuariosEmail = registro.usuariosEmail.ToLower();
            }
            if (registro.usuariosOnline == null)
            {
                registro.usuariosOnline = false;
            }
            if (registro.usuariosDataCadastro == null)
            {
                registro.usuariosDataCadastro = DateTime.Now.Date;
            }
            if (registro.usuariosDataLogin == null)
            {
                registro.usuariosDataLogin = DateTime.Now.Date;
            }
            DAL.usuarios cmd = new DAL.usuarios();
            cmd.executarUpdade(registro);
        }
        public void executarDelete(int registro)
        {
            DAL.usuarios cmd = new DAL.usuarios();
            cmd.executarDelete(registro);
        }
        public void executarUpdateLogin(TAB.usuarios registro)
        {
            DAL.usuarios cmd = new DAL.usuarios();
            cmd.executarUpdadeLogin(registro);
        }

    }
}
