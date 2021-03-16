<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="TC_New.aspx.cs" Inherits="HeatNo_TC_New" Title="MTC" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: gainsboro">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnTC_Index" runat="server" Text="Back" Width="80px" OnClick="btnTC_Index_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 110px; background-color: whitesmoke">
                    <asp:Label ID="Label3" runat="server" Text="PO Number"></asp:Label>
                </td>
                <td>
                    <telerik:RadSearchBox ID="txtSearch" runat="server" DataSourceID="PO_SqlDataSource" DropDownSettings-Height="400px" ShowSearchButton="False"
                        DataTextField="PO_NO" DataValueField="PO_NO" Filter="StartsWith" MinFilterLength="3" Width="250px" OnSearch="txtSearch_Search">
                    </telerik:RadSearchBox>
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: whitesmoke">
                    <asp:Label ID="Label1" runat="server" Text="TC Number"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtTC_No" runat="server" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="tcValidator" runat="server" ControlToValidate="txtTC_No"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr style="display:none;">
                <td style="width: 110px; background-color: whitesmoke">
                    <asp:Label ID="Label2" runat="server" Text="PDF File"></asp:Label>
                </td>
                <td>
                    <asp:FileUpload ID="PDF_Upload" runat="server" Width="526px" />
                </td>
            </tr>
            <tr>
                <td style="width: 110px; background-color: whitesmoke">
                    <asp:Label ID="Label4" runat="server" Text="Remarks"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="PO_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PO_NO FROM PIP_PO WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY PO_NO">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="PO_NO_HiddenField" runat="server" />
</asp:Content>