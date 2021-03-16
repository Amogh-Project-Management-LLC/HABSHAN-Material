<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POBatchDetail.aspx.cs" Inherits="Procurement_POBatchDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();

            grid.get_element().style.height = (height) - 260 + "px";
            grid.get_element()
            grid.repaint();
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>

        <telerik:RadButton ID="btnImport" runat="server" Text="Import From PO" OnClick="btnImport_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnMove" runat="server" Text="Move Items" Width="100px" OnClick="btnMove_Click"></telerik:RadButton>

    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" onkeypress="handleSpace(event)"
            AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" PageSize="50" Height="330px" AllowSorting="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>

            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="BATCH_ID, PO_ITEM_ID,SPLIT_ID" AllowMultiColumnSorting="true" EditMode="InPlace" AllowPaging="true" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">

                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" ReadOnly="true" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO ITEM NO" SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO" AutoPostBackOnFilter="true" FilterControlWidth="70px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_ID" ReadOnly="true" FilterControlAltText="Filter SPLIT_ID column" HeaderText="SPLIT ID" SortExpression="SPLIT_ID" UniqueName="SPLIT_ID" AutoPostBackOnFilter="true" FilterControlWidth="70px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="MAT_DESCR" ReadOnly="true" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="200px">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" ReadOnly="true" FilterControlAltText="Filter WALL_THK column"
                        HeaderText="THK" SortExpression="WALL_THK" UniqueName="WALL_THK" AutoPostBackOnFilter="true" AllowFiltering="false">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BATCH_QTY" DataType="System.Decimal" FilterControlAltText="Filter BATCH_QTY column" HeaderText="BATCH QTY" SortExpression="BATCH_QTY" UniqueName="BATCH_QTY" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <%-- <telerik:GridBoundColumn DataField="MRR_QTY" DataType="System.Decimal" FilterControlAltText="Filter MRR_QTY column" HeaderText="MRR QTY" SortExpression="MRR_QTY" UniqueName="MRR_QTY" AutoPostBackOnFilter="true" FilterControlWidth="50px" ReadOnly="true">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRR_RECV_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter MRR_RECV_DATE column" HeaderText="MRR RECV DATE" SortExpression="MRR_RECV_DATE" UniqueName="MRR_RECV_DATE" AutoPostBackOnFilter="true" FilterControlWidth="50px" ReadOnly="true">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="UOM" ReadOnly="true" FilterControlAltText="Filter UOM column" HeaderText="UOM" SortExpression="UOM" UniqueName="UOM" AllowFiltering="false">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_BATCH_PLAN_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_BATCH_ID" Type="Decimal" />
            <asp:Parameter Name="original_PO_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPLIT_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="BATCH_ID" QueryStringField="BATCH_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="BATCH_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_BATCH_ID" Type="Decimal" />
            <asp:Parameter Name="original_PO_ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="original_SPLIT_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

