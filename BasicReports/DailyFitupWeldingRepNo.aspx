<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="DailyFitupWeldingRepNo.aspx.cs" Inherits="BasicReports_DailyFitupWeldingRepNo"
    Title="Welding Report" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnWelding" runat="server" Text="Welding" Width="80" OnClick="btnWelding_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <table>
        <tr>
            <td style="width: 150px; background-color: Gainsboro">Category
            </td>
            <td>
                <asp:RadioButtonList ID="rblCat" runat="server" Enabled="false">
                    <asp:ListItem Value="1">Shop</asp:ListItem>
                    <asp:ListItem Selected="True" Value="2">Field</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td style="background-color: Gainsboro; width: 150px;">Report No
            </td>
            <td>
                <asp:TextBox ID="txtReportNo" runat="server" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="ReportNoValidator" runat="server" ControlToValidate="txtReportNo"
                    ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
</asp:Content>