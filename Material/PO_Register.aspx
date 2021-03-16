<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    CodeFile="PO_Register.aspx.cs" Inherits="PO_Register" Title="New PO" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke; padding: 4px;">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click"></telerik:RadButton>
    </div>

    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 120px; background-color: Gainsboro">PO Number
                        </td>
                        <td>
                            <asp:TextBox ID="txtPO" runat="server" Width="180px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="poValidator" runat="server" ControlToValidate="txtPO"
                                ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: Gainsboro">PO Date
                        </td>
                        <td>
                            <telerik:RadDatePicker ID="txtCreateDate" runat="server" DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                            <asp:RequiredFieldValidator ID="CreateDateRequiredFieldValidator" runat="server" ErrorMessage="*" ControlToValidate="txtCreateDate" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: Gainsboro">Manufacture
                        </td>
                        <td>
                            <asp:TextBox ID="txtManufacture" runat="server" Width="180px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: Gainsboro">Origin</td>
                        <td>
                            <asp:TextBox ID="txtOrigin" runat="server" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: Gainsboro">PO Terms</td>
                        <td>
                            <asp:TextBox ID="txtPO_Terms" runat="server" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: Gainsboro">PO Place</td>
                        <td>
                            <asp:TextBox ID="txtPO_Place" runat="server" Width="180px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="cmpDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT COMPANY_ID, COMPANY_CODE FROM COMPANY WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY COMPANY_CODE">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>