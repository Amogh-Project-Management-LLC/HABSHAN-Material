<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    Title="Change Password" CodeFile="ChangePassword.aspx.cs" Inherits="Admin_ChangePassword" %>

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
    <div style="background-color: whitesmoke;">
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
                        <asp:TextBox ID="txtUserName" runat="server" Width="150px" ReadOnly="True" Enabled="false"></asp:TextBox>
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
                        <asp:TextBox ID="txtPasswordConfirm" runat="server" Width="150px" TextMode="Password"></asp:TextBox>
                        <cc1:PasswordStrength runat="server" ID="PasswordStrengthConfirm" TargetControlID="txtPasswordConfirm"
                            StrengthStyles="BarIndicator;BarIndicatorYellow;BarIndicatorOrange;BarIndicatorGreen"
                            TextStrengthDescriptions="Poor;Weak;Average;Good" BarIndicatorCssClass="BarIndicator"
                            BarBorderCssClass="BarBorder">
                        </cc1:PasswordStrength>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="RolesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ROLE_NAME, ROLE_DESC FROM ROLE_DESCRIPTION ORDER BY ROLE_NAME"></asp:SqlDataSource>
</asp:Content>