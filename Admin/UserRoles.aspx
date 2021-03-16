<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    Title="User Roles" CodeFile="UserRoles.aspx.cs" Inherits="Home_ContactsUserInfo" %>

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
                <table>
                    <tr>
                        <td>
                            <telerik:RadButton ID="btnChangePassword" runat="server" Text="Change Password" Width="130px" OnClick="btnChangePassword_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnReadOnly" runat="server" Text="Read-Only" Width="100px" OnClick="btnReadOnly_Click"></telerik:RadButton>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="80" OnClick="btnSubmit_Click1"></telerik:RadButton>
                        </td>
                    </tr>
                </table>
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
                        <asp:TextBox ID="txtUserName" runat="server" Width="150px" ReadOnly="True"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px; background-color: Gainsboro;">New Password
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" Width="150px" TextMode="Password" Enabled="false"></asp:TextBox>
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
                        <asp:TextBox ID="txtPassword2" runat="server" Width="150px" TextMode="Password" Enabled="false"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>

    <div>
        <table style="border-style: solid; border-color: Silver; border-width: 1px;">
            <tr style="background-color: whitesmoke;">
                <td style="text-align: center;">All Role
                </td>
                <td style="text-align: center;">Selected Role
                </td>
            </tr>
            <tr>
                <td style="width: 360px; vertical-align: top">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <telerik:RadListBox runat="server" ID="Role_ListBoxSource" Height="350px" Width="350px" Sort="Ascending"
                                AllowTransfer="True" TransferToID="Role_ListBoxDestination" AllowTransferOnDoubleClick="True"
                                DataSourceID="RolesSqlDataSource" DataTextField="ROLE_NAME" DataValueField="ROLE_NAME" OnDataBound="Role_ListBoxSource_DataBound" SelectionMode="Multiple">
                                <Items>
                                </Items>
                            </telerik:RadListBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="vertical-align: top;">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadListBox runat="server" Sort="Ascending" ID="Role_ListBoxDestination" Height="350px" Width="350px" SelectionMode="Multiple" AllowTransferOnDoubleClick="True">
                                <Items>
                                </Items>
                            </telerik:RadListBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <asp:SqlDataSource ID="RolesSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT ROLE_NAME, ROLE_DESC FROM ROLE_DESCRIPTION ORDER BY ROLE_NAME"></asp:SqlDataSource>
</asp:Content>