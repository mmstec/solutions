<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="relClientes.aspx.cs" Inherits="SIC.UIWeb.ReportViewer.relClientes" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<%@ OutputCache Location="None" %>; 

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Print Preview (Clientes)</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
       
       <asp:Panel ID="Panel1" runat="server">
           <br />
           Digite um nome para filtrar ou deixe em branco<br />
           para exibir todos os registros:<br />
           <asp:TextBox ID="TextBox1" runat="server" Width="275px"></asp:TextBox><br />
       </asp:Panel>
       
       <asp:Button ID="Button1" runat="server" Text="Exibir Relatório" 
            onclick="Button1_Click" style="height: 26px" />       
       <br /><br />
       <rsweb:ReportViewer ID="rvPrintPreview" runat="server" AsyncRendering="False" Visible="false" SizeToReportContent="True">
       </rsweb:ReportViewer> 
    
    </div>
    </form>
</body>
</html>
