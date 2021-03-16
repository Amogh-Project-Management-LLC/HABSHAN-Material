<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatRFIDetail.aspx.cs" Inherits="Material_MatRFIDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var width = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = width - 15 + "px";

            grid.repaint();
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        function RadConfirm(sender, args) {
            var callBackFunction = function (shouldSubmit) {
                if (shouldSubmit) {
                    sender.click();
                    if (Telerik.Web.Browser.ff) {
                        sender.get_element().click();
                    }
                }
            };

            var text = "Are you sure you want to Delete?";
            radconfirm(text, callBackFunction, 300, 200, null, "RadConfirm");
            args.set_cancel(true);
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAddItems" runat="server" Text="Add Items" Width="100px" OnClick="btnAddItems_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnDeleteAll" runat="server" Text="Delete Selected Items"
            OnClientClicking="RadConfirm" Width="200px" ForeColor="Red" Visible="false" OnClick="btnDeleteAll_Click">
        </telerik:RadButton>

    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" PageSize="50" OnItemDataBound="itemsGrid_ItemDataBound"
            AllowSorting="true" AllowFilteringByColumn="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)"
            OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding" EnableHeaderContextMenu="true"
            EnableHeaderContextFilterMenu="true" AllowMultiRowSelection="true">
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
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="REQ_ITEM_ID" AllowMultiColumnSorting="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column"
                        HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" FilterControlWidth="100px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column"
                        HeaderText="PO ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM" FilterControlWidth="60px" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <%--  <telerik:GridBoundColumn DataField="MAT_CODE2" ReadOnly="true" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2"  ItemStyle-Width="30px"  FilterControlWidth="50px">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" ReadOnly="true" FilterControlAltText="Filter MAT_DESCR column" AutoPostBackOnFilter="true"
                        HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" FilterControlWidth="80px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="PIECES" DataType="System.Decimal" FilterControlAltText="Filter PIECES column" AutoPostBackOnFilter="true"
                        HeaderText="PIECES" SortExpression="PIECES" UniqueName="PIECES" FilterControlWidth="60px" DataFormatString="{0:N2}">
                        <ItemStyle Width="100px" HorizontalAlign="Right" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="INSP_QTY" DataType="System.Decimal" FilterControlAltText="Filter INSP_QTY column" AutoPostBackOnFilter="true"
                        HeaderText="QTY" SortExpression="INSP_QTY" UniqueName="INSP_QTY" FilterControlWidth="60px" DataFormatString="{0:N2}">
                        <ItemStyle Width="100px" HorizontalAlign="Right" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" ReadOnly="true" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT"
                        SortExpression="UOM_NAME" UniqueName="UOM_NAME" AllowFiltering="false">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" ReadOnly="true" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE"
                        SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" ReadOnly="true" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                        SortExpression="WALL_THK" UniqueName="WALL_THK" AllowFiltering="false">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" ReadOnly="true" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME"
                        SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LOT_NO" FilterControlAltText="Filter LOT_NO column" HeaderText="LOT NO" AutoPostBackOnFilter="true"
                        SortExpression="LOT_NO" UniqueName="LOT_NO" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS"
                        AllowFiltering="false">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="REQ_ITEM_ID" FilterControlAltText="Filter REQ_ITEM_ID column" HeaderText="REQ_ITEM_ID"
                        SortExpression="REQ_ITEM_ID" UniqueName="REQ_ITEM_ID" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="1px" />
                        <ItemStyle Width="1px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialETableAdapters.VIEW_MAT_INSP_REQUEST_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_REQ_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="REQ_ID" QueryStringField="REQ_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="INSP_QTY" Type="Decimal" />
            <asp:Parameter Name="PIECES" Type="Decimal" />
            <asp:Parameter Name="LOT_NO" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_REQ_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

