using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace eventos.TAB
{
    public class usuarios
    {
        #region ATRIBUTOS/PROPIEDADES (GETS SETS)
        
        // ATRIBUTOS
        private int _usuariosID;
        private string _usuariosNome;
        private string _usuariosLogin;
        private string _usuariosSenha;
        private string _usuariosPerfil;
        private Boolean _usuariosOnline;
        private string _usuariosEmail;
        private DateTime _usuariosDataLogin;
        private DateTime _usuariosDataCadastro;
        private byte[] _usuariosFoto;

        //PROPIEDADES
        public int usuariosID
        {
            get { return _usuariosID; }
            set { _usuariosID = value; }
        }
        public string usuariosNome
        {
            get { return _usuariosNome; }
            set { _usuariosNome = value; }
        }
        public string usuariosLogin
        {
            get { return _usuariosLogin; }
            set { _usuariosLogin = value; }
        }
        public string usuariosSenha
        {
            get { return _usuariosSenha; }
            set { _usuariosSenha = value; }
        }
        public string usuariosPerfil
        {
            get { return _usuariosPerfil; }
            set { _usuariosPerfil = value; }
        }
        public Boolean usuariosOnline
        {
            get { return _usuariosOnline; }
            set { _usuariosOnline = value; }
        }
        public string usuariosEmail
        {
            get { return _usuariosEmail; }
            set { _usuariosEmail = value; }
        }
        public DateTime usuariosDataLogin
        {
            get { return _usuariosDataLogin; }
            set { _usuariosDataLogin = value; }
        }
        public DateTime usuariosDataCadastro
        {
            get { return _usuariosDataCadastro; }
            set { _usuariosDataCadastro = value; }
        }
        public byte[] usuariosFoto
        {
            get { return _usuariosFoto; }
            set { _usuariosFoto = value; }
        }
        #endregion
    }
}
