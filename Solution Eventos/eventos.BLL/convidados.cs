using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using eventos.DAL;
using System.Collections;

/// <summary>
/// 
/// Autor ...:  Marcos
/// Modelo...:  GUI/BLL/DAL/BD
/// Descrição:  Meu Design Pattern ou padrão de desenvolvimento 
///             Design Pattern DAL (Data Access Layer) é um modelo dedicado ao acesso à dados
/// Camada:     BLL - Camada de Persitência
/// 
/// </summary> 
/// <param name="texto">A Camada de Persitência fica  entre a camada de negócios e o bando de dados.</param>
/// <returns>A Camada de Persitência fica  entre a camada de negócios e o bando de dados.</returns>
namespace eventos.BLL 
{
    public class convidados
    {
        public DataTable retornarQueryDataTable(string query)
        {
            DAL.dados cmd = new DAL.dados();
            return cmd.retornarQueryDataTable(query);
        }
        public ArrayList retornarQueryArrayList(string query)
        {
            DAL.convidados cmd = new DAL.convidados();
            return cmd.retornarQueryArrayList(query);
        }
        public void executarInsert(TAB.convidados registro)
        {
            if (registro.convidadosCartao.Length <= 8)
            {
                registro.convidadosCartao.PadLeft(8, '0');
            }
            if (registro.convidadosNome.Length <= 0)
            {
                registro.convidadosNome = " ";
            }
            DAL.convidados cmd = new DAL.convidados();
            cmd.executarInsert(registro);
        }
        public void executarUpdate(TAB.convidados registro)
        {
            if (registro.convidadosCartao.Length <= 8)
            {
                registro.convidadosCartao.PadLeft(8, '0');
            }
            if (registro.convidadosNome.Length <= 0)
            {
                registro.convidadosNome = " ";
            }
            DAL.convidados cmd = new DAL.convidados();
            cmd.executarUpdade(registro);
        }
        public void executarDelete(int registro)
        {
              DAL.convidados cmd = new DAL.convidados();
              cmd.executarDelete(registro);
        }
    }
}
