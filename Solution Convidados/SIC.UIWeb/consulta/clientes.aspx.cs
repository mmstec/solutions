using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using EVENTOS.BLL;

namespace EVENTOS.UIWeb.consulta
{
    public partial class clientes : System.Web.UI.Page
    {
        private void listaClientes(string filtro)
        {
            if (filtro == null)
            {
                filtro = "";
            }

            EVENTOS.BLL.convidadosBll obj = new EVENTOS.BLL.convidadosBll();
            string reportPath = Server.MapPath("~\\ReportClientes.rdlc");

            //Marcos: informando os dados para o reportview 
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("dsCliente", obj.dtRetornaDados("select * from TABCLI where nome LIKE '" + filtro + "%'")));
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.LocalReport.Dispose();


            //Marcos: exportando os dados do relatório para PDF
            /*string mimeType;
            string encoding;
            string fileNameExtension;
            Warning[] warnings;
            string[] streamids;
            byte[] exportBytes = rvPrintPreview.LocalReport.Render("PDF", null, out mimeType, out encoding, out fileNameExtension, out streamids, out warnings);
            HttpContext.Current.Response.Buffer = true;
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.ContentType = mimeType;
            HttpContext.Current.Response.AddHeader("content-disposition", "inline; filename=ExportedReport." + fileNameExtension);
            HttpContext.Current.Response.BinaryWrite(exportBytes);
            HttpContext.Current.Response.Flush();
            HttpContext.Current.Response.End();*/
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            listaClientes("");
        }
    }
}
