<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TC_Upload.aspx.cs" Inherits="HeatNo_TC_Upload" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <asp:DetailsView ID="tcDetailsView" runat="server" AutoGenerateRows="False" CssClass="DataWebControlStyle"
                    DataSourceID="tcDataSource" Height="50px" Width="628px" OnDataBound="tcDetailsView_DataBound">
                    <Fields>
                        <asp:BoundField DataField="TC_CODE" HeaderText="TC Code" SortExpression="TC_CODE" />
                        <asp:BoundField DataField="DIR_OBJ" HeaderText="Directory" SortExpression="DIR_OBJ" />
                        <asp:BoundField DataField="PATH" HeaderText="Physical Path" SortExpression="PATH" />
                    </Fields>
                    <FieldHeaderStyle Width="100px" BackColor="#FFFFC0" />
                </asp:DetailsView>

            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Label ID="Label1" runat="server" Text="Browse the entire pdf file"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 82px; background-color: #ccccff">
                            <asp:Label ID="Label2" runat="server" Text="File Name"></asp:Label>
                        </td>
                        <td>
                            <asp:FileUpload ID="pdfUpload" runat="server" Width="443px" />
                            <asp:RequiredFieldValidator ID="fileValidator" runat="server" ControlToValidate="pdfUpload"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnCancel" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    CausesValidation="False" OnClick="btnCancel_Click" Text="Back" Width="75px" />
                <asp:Button ID="btnGrab" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    OnClick="btnGrab_Click" Text="Upload" Width="75px" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="dirDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT DIR_ID, DIR_OBJ FROM DIR_OBJECTS ORDER BY DIR_OBJ'>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="tcDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsGeneralTableAdapters.PIP_TEST_CARDSTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
