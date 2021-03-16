<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ExportTextCsv.aspx.cs"
    Inherits="ExportTextCsv" Title="Export Data" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .dutton_div {
            width: 300px;
            padding: 5px;
            background-color: whitesmoke;
            margin: 3px;
            border-radius: 5px;
        }
    </style>

    <div class="dutton_div">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="70px" Skin="Sunset" OnClick="btnBack_Click">
                    </telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnUpdateDate" runat="server" Text="Update Date" Width="100px" Skin="Sunset" OnClick="btnUpdateDate_Click">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <table>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Data Type</td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                        <ContentTemplate>
                            <asp:RadioButtonList ID="DataTypeList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DataTypeList_SelectedIndexChanged">
                                <asp:ListItem Text="Spoolgen" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Welding/ Inspection/ Status" Value="2"></asp:ListItem>
                            </asp:RadioButtonList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Filter by
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <asp:RadioButtonList ID="FilterByList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="FilterByList_SelectedIndexChanged">
                                <asp:ListItem Text="Date" Value="1" Selected="True"></asp:ListItem>
                                <asp:ListItem Text="Isometric" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Transmittal" Value="3"></asp:ListItem>
                                <asp:ListItem Text="All" Value="4"></asp:ListItem>
                            </asp:RadioButtonList>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Filter Value</td>
                <td>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddFilterValue" runat="server" Width="220px" DataSourceID="filterValDataSource">
                            </asp:DropDownList>
                            <telerik:RadTextBox ID="txtFilterValue" runat="server" Visible="False" Width="220px"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 100px; background-color: whitesmoke">Data Source</td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:ListBox ID="viewsListBox" runat="server" Height="150px" Width="300px" DataSourceID="viewsListDataSource" DataTextField="EXT_DATA" DataValueField="EXT_ID"></asp:ListBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div class="dutton_div">
        <telerik:RadButton ID="btnDownload" runat="server" Text="Download" Width="100px" OnClick="btnDownload_Click"></telerik:RadButton>
    </div>

    <asp:SqlDataSource ID="filterValDataSource" runat="server"
        ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT EXPORT_DATE, to_char(EXPORT_DATE, 'dd-Mon-yyyy') AS EXPORT_DATE_TXT FROM VIEW_CMS_EXP_DATE ORDER BY EXPORT_DATE DESC"></asp:SqlDataSource>
    <asp:SqlDataSource ID="viewsListDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT EXT_ID, EXT_DATA FROM EXTERNAL_DATA WHERE (PROJECT_ID = :PROJECT_ID) AND (CAN_EXPORT = 'Y') AND (EXP_TYPE = :EXP_TYPE) ORDER BY EXT_DATA">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
            <asp:ControlParameter ControlID="DataTypeList" DefaultValue="'Y'" Name="EXP_TYPE" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>