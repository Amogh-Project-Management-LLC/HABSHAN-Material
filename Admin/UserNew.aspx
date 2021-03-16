<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    Title="New User" CodeFile="UserNew.aspx.cs" Inherits="Admin_UserNew" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .BarBorder {
            border-style: dashed;
            border-width: 2px;
            width: 300px;
        }

        .BarIndicator {
            color: Red;
            background-color: Red;
        }

        .BarIndicatorYellow {
            color: Yellow;
            background-color: Yellow;
        }

        .BarIndicatorOrange {
            color: orange;
            background-color: orange;
        }

        .BarIndicatorGreen {
            color: Green;
            background-color: Green;
        }
    </style>
    <div style="padding-bottom: 5px; padding-left: 5px;">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click1"></telerik:RadButton>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">User Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtUserName" runat="server" Width="150px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="UserNameRequiredFieldValidator" runat="server" ControlToValidate="txtUserName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">Email</td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" Width="200px"></asp:TextBox>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">New Password
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" Width="150px" TextMode="Password"></asp:TextBox>
                        <cc1:PasswordStrength runat="server" ID="PasswordStrength1" TargetControlID="txtPassword"
                            StrengthStyles="BarIndicator;BarIndicatorYellow;BarIndicatorOrange;BarIndicatorGreen"
                            TextStrengthDescriptions="Poor;Weak;Average;Good" BarIndicatorCssClass="BarIndicator"
                            BarBorderCssClass="BarBorder">
                        </cc1:PasswordStrength>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">New Password (Confirm)
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword2" runat="server" Width="150px" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">
                        Designation
                    </td>
                    <td>
                        <asp:TextBox ID="txtDesignation" runat="server" Width="150px"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDesignation" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                 <tr>
                    <td style="width: 150px; background-color: Gainsboro;">
                        Company Name
                    </td>
                    <td>
                        <asp:TextBox ID="txtCompany" runat="server" Width="150px"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtCompany" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>