using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using EVENTOS.DAL;

/// <summary>
/// Autor ...: Marcos
/// Modelo...: GUI/BLL/DAL/BD
/// Descrição: BLL - Camada de Persitência
/// </summary> 
/// <param name="texto">A Camada de Persitência fica  entre a camada de negócios e o bando de dados.</param>
/// <returns>A Camada de Persitência fica  entre a camada de negócios e o bando de dados.</returns>
namespace EVENTOS.BLL 
{
    public class convidadosBll
    {
    
        public DataTable dtRetornaDados(string filtro)
        {
            convidadosDAL obj = new convidadosDAL();
            return obj.dtListar(filtro);
        }
 
    }
}
