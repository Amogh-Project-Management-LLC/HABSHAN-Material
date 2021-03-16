<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="UpdateSuppMTO.aspx.cs"
    Inherits="UpdateSuppMTO" Title="Update Support MTO" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .dutton_div {
            width: 400px;
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
    <div class="dutton_div">
        <telerik:RadProgressBar ID="RadProgressBar1" runat="server" MaxValue="10" Skin="Simple" ShowLabel="False"></telerik:RadProgressBar>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Support BOM</td>
                <td>
                    <telerik:RadCheckBox ID="replaceRadCheckBox" runat="server" Text="Replace if newer" Checked="True"></telerik:RadCheckBox>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Fabrication</td>
                <td>
                    <telerik:RadCheckBox ID="splPipesRadCheckBox" runat="server" Text="Add Shop Support Pipes to BOM" Checked="True"></telerik:RadCheckBox>
                </td>
            </tr>
        </table>
    </div>
    <div class="dutton_div">
        <telerik:RadButton ID="btnRun" runat="server" Text="Update" Width="100px" OnClick="btnRun_Click"></telerik:RadButton>
    </div>
</asp:Content>