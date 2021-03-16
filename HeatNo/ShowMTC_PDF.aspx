<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="ShowMTC_PDF.aspx.cs" Inherits="HeatNo_ShowMTC_PDF" Title="View PDF" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .div1 {
            padding: 10px 10px 10px 10px;
            text-align: center;
        }
    </style>
    <div class="div1">
        <asp:Label ID="PDF_URL_Label" runat="server" Text=""></asp:Label>
    </div>
</asp:Content>