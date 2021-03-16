<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="IsomeReports.aspx.cs" Inherits="BasicReports_IsomeReports" Title="Isometric Reports" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
    </div>

    <div>
        <table>
            <tr>
                <td style="width: 135px; background-color: Gainsboro">
                    <asp:Label ID="Label1" runat="server" Text="Spool Drawing:"></asp:Label>
                </td>
                <td class="TableStyle">
                    <asp:TextBox ID="txtFilter" runat="server" Width="179px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="filterValidator" runat="server" ControlToValidate="txtFilter"
                        ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 135px; background-color: Gainsboro">
                    <asp:Label ID="Label2" runat="server" Text="BOM Cat (Optional)"></asp:Label>
                </td>
                <td class="TableStyle">
                    <asp:DropDownList ID="cboBomCat" runat="server">
                        <asp:ListItem Value="-1">(Select One)</asp:ListItem>
                        <asp:ListItem Value="1">Shop</asp:ListItem>
                        <asp:ListItem Value="2">Field</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div style="background-color: whitesmoke;">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Joints" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNDE" runat="server" Text="NDE" Width="80" OnClick="btnNDE_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>