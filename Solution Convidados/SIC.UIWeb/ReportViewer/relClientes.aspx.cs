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

using System.Data.SqlClient;
using System.Web.Configuration;
using Microsoft.Reporting.WebForms;
using System.IO;
using System.Drawing;
using EVENTOS.BLL;

namespace EVENTOS.UIWeb.ReportViewer
{

    public partial class relClientes : System.Web.UI.Page
    {
        #region metodos e procedimentos

        //Marcos: emula um MessageBox
        private void messageBox(string msg)
        {
            Label obj = new Label();
            obj.Text = "<script language='javascript'>" + Environment.NewLine + "window.alert('" + msg + "')</script>";
            Page.Controls.Add(obj);
        }

        //Marcos: limpa qualquer campo do form
        private void limpaCampos(Control campo)
        {
            foreach (Control ctl in campo.Controls)
                if (ctl is TextBox)
                    ((TextBox)ctl).Text = string.Empty;
                else if (ctl.Controls.Count > 0)
                    limpaCampos(ctl);
        }

        private void listaClientes(string filtro)
        {
            if (filtro == null)
            {
                filtro = "";
            }

            EVENTOS.BLL.convidadosBll obj = new EVENTOS.BLL.convidadosBll();
            string reportPath = Server.MapPath("~\\ReportViewer\\rdlCliente.rdlc");

            //Marcos: informando os dados para o reportview 
            rvPrintPreview.LocalReport.DataSources.Add(new ReportDataSource("dsCliente", obj.dtRetornaDados("select * from TABCLI where nome LIKE '" + filtro + "%'")));
            rvPrintPreview.LocalReport.ReportPath = reportPath;
            rvPrintPreview.LocalReport.Refresh();
            rvPrintPreview.LocalReport.Dispose();
            

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

        #endregion 

        protected void Page_Load(object sender, EventArgs e)
        {
            //Marcos: listarClientes(TextBox1.Text);           
        }

        
        protected void Button1_Click(object sender, EventArgs e)
        {
            switch(Button1.Text){
                case "Exibir Relatório":
                    Button1.Text = "Novo Relatório";
                    rvPrintPreview.Visible = true;
                    listaClientes(TextBox1.Text);
                    Panel1.Visible = false;
                    break;
                case "Novo Relatório":
                    Button1.Text = "Exibir Relatório";
                    rvPrintPreview.Visible = false;
                    Button1.PostBackUrl = "~/ReportViewer/relClientes.aspx";
                    Panel1.Visible = true;
                    break;
            }
            
        }


    }
}
