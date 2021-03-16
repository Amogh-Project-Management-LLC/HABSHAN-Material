<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="LineServicesRegister.aspx.cs" Inherits="LineServicesRegister" Title="Line Services" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Back" Width="74px" CausesValidation="False" OnClick="btnBack_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <table style="width: 100%" class="TableStyle">
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label1" runat="server" Text="Line Service"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtLineSrv" runat="server" Width="100px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="serviceValidator" runat="server" ControlToValidate="txtLineSrv"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label3" runat="server" Text="Priority"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="cboPriority" runat="server" AppendDataBoundItems="True" DataSourceID="priorityDataSource"
                                DataTextField="TITLE" DataValueField="PRIORITY" Width="150px">
                                <asp:ListItem Selected="True"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label4" runat="server" Text="Service Description"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescr" runat="server" Width="300px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="descriptionValidator" runat="server" ControlToValidate="txtDescr"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 120px; background-color: #ccccff">
                            <asp:Label ID="Label5" runat="server" Text="Remarks"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="400px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    Text="Submit" Width="74px" OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="priorityDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT PRIORITY, PRIORITY || ': ' || DESCR AS TITLE FROM IPMS_PRIORITY ORDER BY PRIORITY">
    </asp:SqlDataSource>
</asp:Content>
