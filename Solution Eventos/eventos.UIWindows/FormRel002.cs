using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Microsoft.Reporting.WinForms;

namespace SIC.UIWindows
{
    public partial class FormRel002 : Form
    {
        public FormRel002()
        {
            InitializeComponent();
        }

        private void FormRel002_Load(object sender, EventArgs e)
        {
            // Set the processing mode for the ReportViewer to Local
            reportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport localReport = reportViewer1.LocalReport;
            localReport.ReportPath = "Report002.rdlc";
            SIC.BLL.ClientesBLL obj = new SIC.BLL.ClientesBLL();
            localReport.DataSources = obj.dsRetornaDados("select * from tabcli");
            reportViewer1.RefreshReport();

        }

    
    }
}
