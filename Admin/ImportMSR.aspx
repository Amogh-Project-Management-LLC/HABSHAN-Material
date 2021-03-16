<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportMSR.aspx.cs"
    Inherits="ImportMSR" Title="Import MSR" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .dutton_div {
            width: 300px;
            padding: 5px;
            background-color: whitesmoke;
            margin: 3px;
            border-radius: 5px;
        }
    </style>

    <div class="dutton_div">

        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="70px" Skin="Sunset" OnClick="btnBack_Click">
        </telerik:RadButton>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">File</td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" Width="400px" />
                </td>
            </tr>
        </table>
    </div>
    <div class="dutton_div">
        <telerik:RadButton ID="btnImport" runat="server" Text="Import" Width="100px" OnClick="btnImport_Click"></telerik:RadButton>
    </div>
</asp:Content>