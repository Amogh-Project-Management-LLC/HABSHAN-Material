<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MaterialStoresRegister.aspx.cs" Inherits="Erection_ErectionRepRegister" Title="Store - New" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td >
                <telerik:RadButton ID="btnBack" runat="server"  Text="Back" Width="74px" OnClick="btnBack_Click" CausesValidation="False" />
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                    <tr>
                        <td style="width: 100px; background-color: #ccccff">
                            <asp:Label ID="Label1" runat="server" Text="Store"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtStore" runat="server" Width="150px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="storeValidator" runat="server" ErrorMessage="*" ControlToValidate="txtStore"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: #ccccff">
                            <asp:Label ID="Label2" runat="server" Text="Subcon"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboSubcon" runat="server" AppendDataBoundItems="True" DataSourceID="SubconDataSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SUB_CON_ID" OnDataBound="cboSubcon_DataBound"
                                Width="150px">
                                <asp:ListItem Selected="True" Value="-1">(Select)</asp:ListItem>
                            </asp:DropDownList>
                            <asp:CompareValidator ID="subconValidator" runat="server" ControlToValidate="cboSubcon"
                                ErrorMessage="*" Operator="NotEqual" ValueToCompare="-1"></asp:CompareValidator>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td >
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Submit" Width="74px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR WHERE PROJ_ID = :PROJECT_ID ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
