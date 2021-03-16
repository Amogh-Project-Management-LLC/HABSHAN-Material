<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="GraphViewer.aspx.cs" Inherits="BasicReports_GraphViewer" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>



<%@ Register Assembly="Telerik.ReportViewer.WebForms, Version=12.0.18.227, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke;">
        <a href="javascript:history.back(1)" 
            onmouseout="document.getElementById('backicon').src='../images/back_a.png' ;"
            onmouseover="document.getElementById('backicon').src='../images/back_b.png' ;">
            <img border="0" id="backicon" src="../Images/back_a.png" /></a>
    </div>
    <div>
        <telerik:ReportViewer ID="ReportViewer1" runat="server"
            Width="100%" Height="500px" ViewMode="PrintPreview"></telerik:ReportViewer>
    </div>
</asp:Content>