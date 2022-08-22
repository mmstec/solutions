<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="relClientes.aspx.cs" Inherits="SIC.UIWeb.CrystalReports.relClientes" %>

<%@ Register assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Print Preview (Clientes)</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <CR:CrystalReportViewer ID="crPrintPreview" runat="server" 
            AutoDataBind="true" EnableDatabaseLogonPrompt="False" 
            EnableParameterPrompt="False" />
    
    </div>
    </form>
</body>
</html>
