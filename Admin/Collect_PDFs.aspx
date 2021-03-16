<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Collect_PDFs.aspx.cs" Inherits="Admin_Collect_PDFs" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .div_style {
            padding-top: 2px;
            padding-bottom: 2px;
        }
    </style>

    <div class="div_style">
        <table>
            <tr>
                <td style="background-color: gainsboro; width: 150px;">Spoolgen PDFs Path
                </td>
                <td>
                    <telerik:RadTextBox ID="txtSpoolgen_PDF_Path" runat="server" Width="600px" EmptyMessage="Spoolgen PDF Path"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="background-color: gainsboro; width: 150px;">Hard-Copy Path</td>
                <td>
                    <telerik:RadTextBox ID="txtHardCopy_Path" runat="server" Width="600px" EmptyMessage="Hard-Copy PDF Path"></telerik:RadTextBox>
                </td>
            </tr>
            <tr>
                <td style="background-color: gainsboro; width: 150px;">MTC PDFs</td>
                <td>
                    <telerik:RadTextBox ID="txtMTC_Pdf" runat="server" Width="600px" EmptyMessage="MTC PDF Path"></telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <table class="div_style">
        <tr>
            <td>
                <telerik:RadButton ID="btnCollectSpoolgenPDF" runat="server" Text="Collect Spoolgen PDFs" Width="200px" OnClick="btnCollectSpoolgenPDF_Click"></telerik:RadButton>
            </td>
            <td>
                <telerik:RadButton ID="btnCollectHardCopyPDF" runat="server" Text="Collect Hardcopy PDFs" Width="200px" OnClick="btnCollectHardCopyPDF_Click"></telerik:RadButton>
            </td>
            <td>
                <telerik:RadButton ID="btnMTC_Pdf" runat="server" Text="MTC PDFs" Width="200px" OnClick="btnMTC_Pdf_Click"></telerik:RadButton>
            </td>
        </tr>
    </table>
    <div class="div_style">
        <telerik:RadListBox ID="Log_RadListBox" runat="server" Height="370px" Width="700px">
            <Items>
                <telerik:RadListBoxItem runat="server" Text="" />
            </Items>
        </telerik:RadListBox>
    </div>
</asp:Content>