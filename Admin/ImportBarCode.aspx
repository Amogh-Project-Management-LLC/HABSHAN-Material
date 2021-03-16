<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportBarCode.aspx.cs" Inherits="ImportBarCode" Title="Import Barcode" %>

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
    <table style="width: 100%">
        <tr>
            <td style="vertical-align: top;">
                <div class="dutton_div">
                    <table>
                        <tr>
                            <td>
                                <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="70px" Skin="Sunset" OnClick="btnBack_Click">
                                </telerik:RadButton>
                            </td>
                            <td>
                                <telerik:RadButton ID="btnExptErrExcel" runat="server" Text="Export Error to Excel" Width="130px" Skin="Telerik" OnClick="btnExptErrExcel_Click">
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </div>
                <div>
                    <table>
                        <tr>
                            <td style="width: 100px; background-color: whitesmoke">Data Type
                            </td>
                            <td>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                                    <asp:ListItem Value="1" Text="Fitup Data" Selected="True"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="Welding Data"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
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
                            <asp:GridView ID="jointsGridView" runat="server" AutoGenerateColumns="False" SkinID="GridViewSkin"
                                DataSourceID="JointsDataSource" Width="800px" AllowPaging="True">
                                <Columns>
                                    <asp:BoundField DataField="DWG_NO" HeaderText="Iso Dwg No" SortExpression="DWG_NO" />
                                    <asp:BoundField DataField="JOINT_NO" HeaderText="Joint No" SortExpression="JOINT_NO" />
                                    <asp:BoundField DataField="CAT_NAME" HeaderText="Category" SortExpression="CAT_NAME" />
                                    <asp:BoundField DataField="ERR_DESCR" HeaderText="Error" SortExpression="ERR_DESCR" />
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
            </td>
            <td style="vertical-align: top; text-align: right; width: 400px;">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/icons/barcode-3d.png" ImageAlign="Right" />
            </td>
        </tr>
    </table>
</asp:Content>