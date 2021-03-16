<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportViewerDynamic.aspx.cs" Inherits="Material_ReportViewerDynamic" Title="Preview Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div>
        <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="450px" Width="100%">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>
</asp:Content>
