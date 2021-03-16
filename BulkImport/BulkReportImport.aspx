<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BulkReportImport.aspx.cs" Inherits="BulkImport_BulkReportImport" EnableSessionState="ReadOnly" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">

        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("headerDiv").clientHeight
            var importButton = document.getElementById("fileDiv").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - importButton - 60 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }

    </script>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td id="headerDiv">
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="110" OnClick="btnBack_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div id="fileDiv">
        <table style="padding: 10px">
            <tr>
                <td style="font-size: large">Select_File :</td>
                <td>
                    <asp:FileUpload ID="FileUpload1" runat="server" />
                </td>
                <td>
                    <telerik:RadButton ID="btnValidate" runat="server" Text="Import" Width="110" OnClick="btnValidate_Click"></telerik:RadButton>
                </td>
                <td style="font-size: large">
                    <asp:HyperLink ID="linkImportFormat" runat="server" Width="150px">Import Format</asp:HyperLink>
                </td>
                <td style="text-align: right">
                    <telerik:RadButton ID="btnErrlog" runat="server" Text="Error Log" Width="110" OnClick="btnErrlog_Click" ForeColor="Red"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>

        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AutoGenerateColumns="true" AllowPaging="true" PageSize="50"
            PagerStyle-AlwaysVisible="true" OnItemDataBound="itemsGrid_ItemDataBound"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <GroupingSettings ShowUnGroupButton="true"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <MasterTableView TableLayout="Auto" AllowMultiColumnSorting="true" EnableHeaderContextMenu="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            </MasterTableView>

        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="itemsErrorSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
</asp:Content>

