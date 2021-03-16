<%@ Page Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true"
    Title="Columns Access" CodeFile="UserModuleRoles.aspx.cs" Inherits="Home_ContactsUserInfo" %>

<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RadConfirm(sender, args) {
            var callBackFunction = function (shouldSubmit) {
                if (shouldSubmit) {
                    sender.click();
                    if (Telerik.Web.Browser.ff) {
                        sender.get_element().click();
                    }
                }
            };

            var text = "Are you sure to add all columns?";
            radconfirm(text, callBackFunction, 300, 200, null, "RadConfirm");
            args.set_cancel(true);
        }
    </script>
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
         <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server" >
            <ContentTemplate>
                <table>
                    <tr>
                        <td>
                            <telerik:RadComboBox ID="ddlModule" runat="server" Width="350px" DataSourceID="ModuleDataSource" DataTextField="MODULE_NAME" DataValueField="MODULE_ID" Height="200px"
                                AppendDataBoundItems="true" AllowCustomText="true" Filter="Contains" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlModule_SelectedIndexChanged"
                                EmptyMessage="Select Module Name">
                            </telerik:RadComboBox>
                        </td>

                        <td>
                            <telerik:RadButton ID="btnSubmit" runat="server" Text="Save" Width="130" OnClick="btnSubmit_Click1"></telerik:RadButton>
                        </td>

                         <td>
                            <telerik:RadButton ID="btnAllRoles" runat="server" Text="Full Access" Width="130" OnClick="btnAllRoles_Click" ForeColor="Red" OnClientClicking="RadConfirm" ></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>


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
                                AllowTransfer="True" TransferToID="Role_ListBoxDestination" AllowTransferOnDoubleClick="True" AutoPostBack="true"
                                DataTextField="HIDE_COL_NAME" DataValueField="SEQ" SelectionMode="Multiple">
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
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT USER_MODULE_COLUMNS.*,MODULE_NAME FROM USER_MODULE_COLUMNS 
                       INNER JOIN USER_MODULE ON USER_MODULE_COLUMNS.MODULE_ID=USER_MODULE.MODULE_ID 
                       WHERE USER_MODULE.MODULE_ID =:MODULE_ID ORDER BY SEQ">
        <SelectParameters>
            <asp:ControlParameter Name="MODULE_ID" ControlID="ddlModule" DefaultValue="-1" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="ModuleDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM USER_MODULE  ORDER BY MODULE_ID"></asp:SqlDataSource>
</asp:Content>
