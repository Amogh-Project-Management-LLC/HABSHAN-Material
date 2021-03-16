<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PODetailSplit.aspx.cs" Inherits="Procurement_PODetailSplit" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }

        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnNew" runat="server" Text="Create Split" Width="120px" Visible="false"></telerik:RadButton>
                    <telerik:RadButton ID="btnDetail" runat="server" Text="Detail" Width="80px" OnClick="btnDetail_Click" Visible="false"></telerik:RadButton>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="250px" EmptyMessage="Search Item...." AutoPostBack="true" Visible="false"></telerik:RadTextBox>
                </td>
            </tr>
        </table>


    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None"
            AllowPaging="true" AllowFilteringByColumn="true" MasterTableView-EditMode="InPlace" PageSize="50" OnDataBinding="itemsGrid_DataBinding"
            OnItemCommand="itemsGrid_ItemCommand">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="SPLIT_ITEM_ID" EditMode="InPlace" TableLayout="Fixed">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO ITEM NO"
                        SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO" AllowFiltering="false" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_ID" FilterControlAltText="Filter SPLIT_ID column" HeaderText="SPLIT ID" SortExpression="SPLIT_ID"
                        UniqueName="SPLIT_ID" AllowFiltering="false" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE1"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" FilterControlWidth="90px" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCR"
                        SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" FilterControlWidth="180px" AutoPostBackOnFilter="true" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ORD_QTY" DataType="System.Decimal" FilterControlAltText="Filter ORD_QTY column"
                        HeaderText="ORD QTY" SortExpression="ORD_QTY" UniqueName="ORD_QTY" FilterControlWidth="40px"
                        AutoPostBackOnFilter="true" ReadOnly="true" DataFormatString="{0:N2}">
                        <ItemStyle HorizontalAlign="Right" Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SPLIT_QTY column"
                        HeaderText="SPLIT QTY" SortExpression="SPLIT_QTY" UniqueName="SPLIT_QTY" FilterControlWidth="40px" AutoPostBackOnFilter="true"
                        ReadOnly="true" DataFormatString="{0:N2}">
                        <HeaderStyle Width="90px" />
                        <ItemStyle HorizontalAlign="Right" Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN NO" SortExpression="IRN_NO"
                        UniqueName="IRN_NO" AllowFiltering="false" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CDD" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter CDD column"
                        HeaderText="CDD" SortExpression="CDD" UniqueName="CDD" FilterControlWidth="40px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA_DATE" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter ETA_DATE column"
                        HeaderText="ETA DATE" SortExpression="ETA_DATE" UniqueName="ETA_DATE" FilterControlWidth="40px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" UpdateMethod="UpdateQuery" TypeName="Procurement_BTableAdapters.VIEW_PO_SPLIT_DETAIL11TableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CDD" Type="DateTime" />
            <asp:Parameter Name="ETA_DATE" Type="DateTime" />
            <asp:Parameter Name="Original_SPLIT_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

