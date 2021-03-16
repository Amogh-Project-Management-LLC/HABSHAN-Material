<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportViewer.aspx.cs" Inherits="Material_ReportViewer" Title="Preview Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="background-color: whitesmoke;">
        <a href="javascript:history.back(1)" onmouseout="document.getElementById('backicon').src='../images/back_a.png' ;"
            onmouseover="document.getElementById('backicon').src='../images/back_b.png' ;">
            <img border="0" id="backicon" src="../Images/back_a.png" /></a>
    </div>
    <div>
        <rsweb:ReportViewer ID="ReportPreview" runat="server" Height="450px" Width="100%">
            <LocalReport EnableExternalImages="True" EnableHyperlinks="True" OnSubreportProcessing="ReportPreview_SubreportProcessing">
            </LocalReport>
        </rsweb:ReportViewer>
    </div>
</asp:Content>