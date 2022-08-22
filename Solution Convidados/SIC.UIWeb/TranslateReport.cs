using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;


namespace EVENTOS.UIWeb
{
    // como usar a tradução:
    /*
    private void Imprimir()
    {
        TranslateReport rpt = new TranslateReport();
        reportViewer1.Messages = rpt;
        reportViewer1.RefreshReport();
    }
    */

    public class TranslateReport : Microsoft.Reporting.WebForms.IReportViewerMessages
    {
        //Abaixo da Classe do Form1
        public string BackButtonToolTip
        {
            get { return "Volta a janela principal"; }
        }

        public string BackMenuItemText
        {
            get { return "Voltar"; }
        }


        public string ChangeCredentialsText
        {
            get { return "Opção"; }
        }

        public string CurrentPageTextBoxToolTip
        {
            get { return "Página Atual"; }
        }

        public string DocumentMapButtonToolTip
        {
            get { return "Mostra ou Oculta Mapa do Documento"; }
        }

        public string DocumentMapMenuItemText
        {
            get { return "Documento"; }
        }

        public string ExportButtonToolTip
        {
            get { return "Exportar"; }
        }

        public string ExportMenuItemText
        {
            get { return "Exportar"; }
        }

        public string FalseValueText
        {
            get { return "Falso"; }
        }

        public string FindButtonText
        {
            get { return "Procurar"; }
        }

        public string FindButtonToolTip
        {
            get { return "Procura texto no relatório"; }
        }

        public string FindNextButtonText
        {
            get { return "Próximo"; }
        }

        public string FindNextButtonToolTip
        {
            get { return "Procura próxima ocorrência no relatório"; }
        }


        public string FirstPageButtonToolTip
        {
            get { return "Primeira Página"; }
        }

        public string LastPageButtonToolTip
        {
            get { return "Ultima Página"; }
        }


        public string NextPageButtonToolTip
        {
            get { return "Próxima Página"; }
        }

        public string NoMoreMatches
        {
            get { return "Pesquisa do documento concluida"; }
        }

        public string NullCheckBoxText
        {
            get { return "Nulo"; }
        }

        public string NullCheckBoxToolTip
        {
            get { return "Valor Nulo"; }
        }

        public string NullValueText
        {
            get { return "Nulo"; }
        }

        public string PageOf
        {
            get { return "de"; }
        }

        public string PageSetupButtonToolTip
        {
            get { return "Configurar Página"; }
        }

        public string PageSetupMenuItemText
        {
            get { return "Configurar Página"; }
        }

        public string ParameterAreaButtonToolTip
        {
            get { return "Parametro"; }
        }

        public string PasswordPrompt
        {
            get { return "Senha"; }
        }

        public string PreviousPageButtonToolTip
        {
            get { return "Página Anterior"; }
        }

        public string PrintButtonToolTip
        {
            get { return "Imprimir"; }
        }

        public string PrintLayoutButtonToolTip
        {
            get { return "Visualizar Impressão"; }
        }

        public string PrintLayoutMenuItemText
        {
            get { return "Visualiza Impressão"; }
        }

        public string PrintMenuItemText
        {
            get { return "Imprimir"; }
        }

        public string ProgressText
        {
            get { return "Relatório está sendo gerado..."; }
        }

        public string RefreshButtonToolTip
        {
            get { return "Atualizar"; }
        }

        public string RefreshMenuItemText
        {
            get { return "Atualizar"; }
        }

        public string SearchTextBoxToolTip
        {
            get { return "Procurar Texto"; }
        }

        public string SelectAll
        {
            get { return "Selecionar Todos"; }
        }

        public string SelectAValue
        {
            get { return "Selecione um Valor"; }
        }

        public string StopButtonToolTip
        {
            get { return "Para Geração de Relatório"; }
        }

        public string StopMenuItemText
        {
            get { return "Parar"; }
        }

        public string TextNotFound
        {
            get { return "Não Encontrado"; }
        }

        public string TotalPagesToolTip
        {
            get { return "Total de Páginas"; }
        }

        public string TrueValueText
        {
            get { return "Verdadeiro"; }
        }

        public string UserNamePrompt
        {
            get { return "Usuário"; }
        }

        public string ViewReportButtonText
        {
            get { return "Ver Relatório"; }
        }

        public string ViewReportButtonToolTip
        {
            get { return "Ver Relatório"; }
        }

        public string ZoomControlToolTip
        {
            get { return "Zoom"; }
        }

        public string ZoomMenuItemText
        {
            get { return "Zoom"; }
        }

        public string ZoomToPageWidth
        {
            get { return "Largura da Página"; }
        }

        public string ZoomToWholePage
        {
            get { return "Página Inteira"; }
        }

        #region IReportViewerMessages Members


        public string ChangeCredentialsToolTip
        {
            get { throw new NotImplementedException(); }
        }

        public string DocumentMap
        {
            get { throw new NotImplementedException(); }
        }

        public string ExportButtonText
        {
            get { throw new NotImplementedException(); }
        }

        public string ExportFormatsToolTip
        {
            get { throw new NotImplementedException(); }
        }

        public string InvalidPageNumber
        {
            get { throw new NotImplementedException(); }
        }

        public string SelectFormat
        {
            get { throw new NotImplementedException(); }
        }

        public string TodayIs
        {
            get { throw new NotImplementedException(); }
        }

        #endregion

        #region IReportViewerMessages Members

        string Microsoft.Reporting.WebForms.IReportViewerMessages.BackButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ChangeCredentialsText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ChangeCredentialsToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.CurrentPageTextBoxToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.DocumentMap
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.DocumentMapButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ExportButtonText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ExportButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ExportFormatsToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.FalseValueText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.FindButtonText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.FindButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.FindNextButtonText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.FindNextButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.FirstPageButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.InvalidPageNumber
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.LastPageButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.NextPageButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.NoMoreMatches
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.NullCheckBoxText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.NullValueText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.PageOf
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ParameterAreaButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.PasswordPrompt
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.PreviousPageButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.PrintButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ProgressText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.RefreshButtonToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.SearchTextBoxToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.SelectAValue
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.SelectAll
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.SelectFormat
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.TextNotFound
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.TodayIs
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.TrueValueText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.UserNamePrompt
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ViewReportButtonText
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ZoomControlToolTip
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ZoomToPageWidth
        {
            get { throw new NotImplementedException(); }
        }

        string Microsoft.Reporting.WebForms.IReportViewerMessages.ZoomToWholePage
        {
            get { throw new NotImplementedException(); }
        }

        #endregion
    }
}
