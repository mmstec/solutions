<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="SIC.UIWeb._default" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table border="0" cellpadding="4" cellspacing="0" class="lisa">
                
        <!-- LINHA 1 /-->
        <tr>
            <td><FORM METHOD="POST" NAME="MENUC" ACTION="/cgi-bin/sicweb.exe/MenuCadastroClientes" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="C" VALUE="Cadastro de clientes" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENUE" ACTION="/cgi-bin/sicweb.exe/MenuEstoque" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="E" VALUE="Controle de estoque" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENUV" ACTION="/cgi-bin/sicweb.exe/MenuVendas" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="V" VALUE="Vendas" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENUA" ACTION="/cgi-bin/sicweb.exe/MenuAtendimento" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="A" VALUE="Atendimento" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENUF" ACTION="/cgi-bin/sicweb.exe/MenuFinanceiro" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="F" VALUE="Financeiro" name="BT" CLASS=btPadrao>
            </FORM></td>
         </tr>
            
         <!-- LINHA 2 /-->
         <tr>
            <td><FORM METHOD="POST" NAME="MENUO" ACTION="/cgi-bin/sicweb.exe/MenuCadFor" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="O" VALUE="Fornecedores" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENU3" ACTION="/cgi-bin/sicweb.exe/Funcionarios" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="3" VALUE="Funcionários" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENUR" ACTION="/cgi-bin/sicweb.exe/MenuRelatorios" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="R" VALUE="Relatórios" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENU2" ACTION="/cgi-bin/sicweb.exe/EnviarRecado" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="2" VALUE="Enviar recado" name="BT" CLASS=btPadrao>
            </FORM></td>
            
            <td><FORM METHOD="POST" NAME="MENUL" ACTION="/cgi-bin/sicweb.exe/Log" onSubmit="desabilitar(this)">
            <input type="HIDDEN" name="VALIDADOR" value="353183263353066286200744504120">
            <INPUT TYPE="submit" accessKey="L" VALUE="Log de acessos" name="BT" CLASS=btPadrao>
            </FORM></td>
        </tr>
        
        <!-- LINHA 3 /-->
         <tr>
            <td>
                <asp:Button ID="Button1" runat="server" Text="Clientes" CssClass="btVerde" 
                    onclick="Button1_Click" /></td>
            <td>
                <asp:Button ID="Button2" runat="server" Text="Contas recebidas" 
                    CssClass="btVerde" /></td>
            <td>
                <asp:Button ID="Button3" runat="server" Text="Contas a receber" 
                    CssClass="btVerde" /></td>
            <td>
                <asp:Button ID="Button4" runat="server" Text="Button" CssClass="btVerde" 
                    Visible="False" /></td>
            <td>
                <asp:Button ID="Button5" runat="server" Text="Button" CssClass="btVerde" 
                    Visible="False" /></td>
        </tr>
        
    </table>
</asp:Content>
