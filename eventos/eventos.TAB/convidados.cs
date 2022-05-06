using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace eventos.TAB
{
    //public class convidados : List<convidados>
    //{
    //}
    public class convidados
    {
        //PRIVATE MEMBER VARIABLES
        private System.Int32 _convidadosId;
        private System.String _convidadosCartao;
        private System.String _convidadosNome;
        private System.String _convidadosTipo;
        private System.String _convidadosPresenca;

        //PUBLIC PROPERTIES
        public System.Int32 convidadosId { get { return _convidadosId; } set { _convidadosId = value; } }
        public System.String convidadosCartao { get { return _convidadosCartao; } set { _convidadosCartao = value; } }
        public System.String convidadosNome { get { return _convidadosNome; } set { _convidadosNome = value; } }
        public System.String convidadosTipo { get { return _convidadosTipo; } set { _convidadosTipo = value; } }
        public System.String convidadosPresenca { get { return _convidadosPresenca; } set { _convidadosPresenca = value; } }
    }
}
