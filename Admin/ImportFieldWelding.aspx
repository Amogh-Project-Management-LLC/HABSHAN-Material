<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportFieldWelding.aspx.cs"
    Inherits="ImportFieldWelding" Title="Import Field Welding" %>

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
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="70px" Skin="Sunset" OnClick="btnBack_Click">
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnExptErrExcel" Enabled="false" runat="server" Text="Export Error to Excel" Width="130px" Skin="Telerik" OnClick="btnExptErrExcel_Click">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div class="dutton_div">
        <telerik:RadProgressBar runat="server" ID="UpdateProgress" Width="200px" RenderMode="Lightweight" Skin="Silk">
            <AnimationSettings Duration="500" EnableChunkAnimation="true" />
        </telerik:RadProgressBar>
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
    <div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="jointsGridView" runat="server" AutoGenerateColumns="true" SkinID="GridViewSkin"
                    Width="800px" AllowPaging="True">
                    <Columns>
                    </Columns>
                    <EmptyDataTemplate>
                        No Errors Found!
                    </EmptyDataTemplate>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>

        <asp:SqlDataSource ID="JointsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
            ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DWG_NO, JOINT_NO, CAT_NAME, ERR_DESCR FROM VIEW_BARCODE_ERR_B ORDER BY DWG_NO, JOINT_NO"></asp:SqlDataSource>
    </div>
</asp:Content>