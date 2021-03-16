<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Utilities.aspx.cs" Inherits="Home_Utilities" %>
<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="vertical-align: top; padding-top:50px">
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnScan" runat="server" Text="Scan" Width="120px" OnClick="btnScan_Click"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="text-align: right; padding-right: 50px">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/utilities.png" Width="400" />
            </td>
        </tr>
    </table>
</asp:Content>

