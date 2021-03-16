<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AreaListNew.aspx.cs" Inherits="Home_AreaListNew" Title="New Area" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnBack" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    OnClick="btnBack_Click" Text="Back" Width="80px" CausesValidation="False" />
            </td>
        </tr>
        <tr>
            <td>
                <table class="TableStyle" style="width: 100%">
                    <tr>
                        <td style="width: 100px; background-color: #ccccff">
                            <asp:Label ID="Label1" runat="server" Text="Area Level 1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAreaL1" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="areaL1Validator" runat="server" ControlToValidate="txtAreaL1"
                                ErrorMessage="*"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: #ccccff">
                            <asp:Label ID="Label2" runat="server" Text="Area Level 2"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAreaL2" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: #ccccff">
                            <asp:Label ID="Label3" runat="server" Text="Area Level 3"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAreaL3" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; background-color: #ccccff">
                            <asp:Label ID="Label5" runat="server" Text="Description"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescr" runat="server" Width="411px"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="background-color: #99ccff">
                <asp:Button ID="btnSubmit" runat="server" BackColor="SkyBlue" BorderColor="SteelBlue"
                    OnClick="btnSubmit_Click" Text="Submit" Width="79px" />
            </td>
        </tr>
    </table>
</asp:Content>
