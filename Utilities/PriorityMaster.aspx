<%@ Page Title="" Language="C#" MasterPageFile="~/PopupMasterPage.master" AutoEventWireup="true" CodeFile="PriorityMaster.aspx.cs" Inherits="Utilities_PriorityMaster" %>
<%@ MasterType VirtualPath="~/PopupMasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div>
        <div>
            <table style="width: 100%;">
                <tr>
                    <td>
                        <table style="height: 200px;">
                            <tr>
                                <td>
                                    <%--   <telerik:RadAjaxPanel runat="server" ID="RadAjaxPanel1">--%>
                                    <telerik:RadListBox ID="RadListBoxSource" runat="server" Height="200px" Width="200px"
                                        AllowReorder="True" AutoPostBack="true"
                                        DataKeyField="PRIORITY_FIELD" DataSourceID="dsPriorityOptions" DataTextField="PRIORITY_FIELD"
                                        DataValueField="PRIORITY_FIELD" AutoPostBackOnReorder="True" ButtonSettings-VerticalAlign="Middle"
                                        OnSelectedIndexChanged="RadListBoxSource_SelectedIndexChanged">
                                    </telerik:RadListBox>
                                    <%--</telerik:RadAjaxPanel>--%>
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnsubmit" runat="server" Text="Save Order" OnClick="btnsubmit_Click" ></telerik:RadButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: left;">
                                    <telerik:RadButton ID="btnExport" runat="server" Text="Export" OnClick="btnExport_Click" Visible="false"></telerik:RadButton>
                                    <telerik:RadButton ID="btnImport" runat="server" Text="Import" OnClick="btnImport_Click"></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="text-align: left; vertical-align:top; padding-top:40px;">
                        <asp:Panel ID="uploadOptions" runat="server" GroupingText="Upload Priority" visible="false" BackColor="#ffffcc" >
                            <table id="uploadOptions1" runat="server" enableviewstate="true" style="width: 100%;">
                            <tr>
                                <td>
                                    <asp:FileUpload ID="uploadPriorityExcel" runat="server" ToolTip="Select an Excel File" />
                                </td>
                                <td>
                                    <telerik:RadButton ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click"></telerik:RadButton>
                                </td>
                               
                            </tr>
                            <tr>
                                <td >
                                    <asp:RadioButtonList ID="rdoUploadOption" runat="server" RepeatDirection="Vertical">
                                        <asp:ListItem Text="Overwrite Existing & Upload" Value="APPEND" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="Delete Existing & Upload" Value="DELETE"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                 <td>
                                    <img alt="Bullet" src="../App_Themes/BlueTheme/images/icons/excel.png" />
                                    <asp:Label ID="lblSampleExcel" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        </asp:Panel>
                        
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center">
            <asp:Label ID="lblMessage" runat="server" Text="" Font-Bold="true" ForeColor="Green"></asp:Label>
        </div>
    </div>

    <asp:SqlDataSource ID="dsPriorityOptions" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"
        SelectCommand="SELECT priority_field FROM project_priority_options ORDER BY field_order"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsExport" runat="server" ConnectionString="<%$ ConnectionStrings:IpmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:IpmsConnectionString.ProviderName %>"></asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
        <ProgressTemplate>
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/ajax-loader-bar.gif"/>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>

