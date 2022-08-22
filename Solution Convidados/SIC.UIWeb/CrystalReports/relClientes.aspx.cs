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

//referencia ao banco de dados SQL
using System.Data.SqlClient;

//referencia ao crystal reports
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Web;
using System.IO;

//referencia connectionString web.config
using System.Text;
using EVENTOS.BLL;

namespace EVENTOS.UIWeb.CrystalReports
{
    public partial class relClientes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            EVENTOS.BLL.convidadosBll obj = new EVENTOS.BLL.convidadosBll();
            string strParthreport = Server.MapPath("~\\CrystalReports\\rptClientes.rpt");
            ReportDocument crReportDocument = new ReportDocument();
            
            crReportDocument.Load(strParthreport);
            crReportDocument.SetDataSource(obj.dtRetornaDados("select * from nome"));
            
            crPrintPreview.DisplayGroupTree = false;
            crPrintPreview.HasCrystalLogo = false;
            crPrintPreview.ReportSource = crReportDocument;

        }
       
    }
}
