<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="IRN_Detail.aspx.cs" Inherits="Procurement_IRN_Detail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
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
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAdd" Text="Add Items" Width="120px" OnClick="btnAdd_Click">
        </telerik:RadButton>       
            <telerik:RadButton ID="btnDeleteAll" runat="server" Text="Delete Selected Items"
                OnClientClicking="RadConfirm" Width="150" ForeColor="Red" Visible="false" OnClick="btnDeleteAll_Click">
            </telerik:RadButton>
      
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="margin-top: 3px">
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery" TypeName="Procurement_BTableAdapters.VIEW_PO_IRN_DETAILTableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="IRN_ID" QueryStringField="IRN_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RELEASE_QTY" Type="Decimal" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_IRN_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="Original_IRN_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" AllowSorting="true" OnItemCommand="itemsGrid_ItemCommand" onkeypress="handleSpace(event)"
            AllowPaging="true" PageSize="50" Height="330px" AllowFilteringByColumn="true" OnDataBinding="itemsGrid_DataBinding" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            DataKeyNames="IRN_ITEM_ID" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" OnItemDeleted="itemsGrid_ItemDeleted" OnItemDataBound="itemsGrid_ItemDataBound" AllowMultiRowSelection="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowPaging="true"
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed" DataKeyNames="IRN_ITEM_ID" EditMode="InPlace">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM" FilterControlWidth="30px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" ReadOnly="true"
                        FilterControlWidth="100px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" FilterControlWidth="140px" AutoPostBackOnFilter="true" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" FilterControlWidth="50px" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                        SortExpression="WALL_THK" UniqueName="WALL_THK" AutoPostBackOnFilter="true" ReadOnly="true" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_QTY" DataType="System.Decimal" FilterControlAltText="Filter INSP_QTY column" HeaderText="INSPECTION QTY" SortExpression="INSP_QTY" UniqueName="INSP_QTY" ReadOnly="true"
                        FilterControlWidth="50px" AutoPostBackOnFilter="true" DataFormatString="{0:N2}">
                        <ItemStyle Width="130px" HorizontalAlign="Right" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RELEASE_QTY" DataType="System.Decimal" FilterControlAltText="Filter RELEASE_QTY column"
                        HeaderText="RELEASE QTY" SortExpression="RELEASE_QTY" UniqueName="RELEASE_QTY" FilterControlWidth="50px"
                        AutoPostBackOnFilter="true" DataFormatString="{0:N2}">
                        <ItemStyle Width="130px" HorizontalAlign="Right" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" ReadOnly="true"
                        SortExpression="UOM_NAME" UniqueName="UOM_NAME" FilterControlWidth="30px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SPLIT_ID" FilterControlAltText="Filter SPLIT_ID column" HeaderText="SPLIT ID" SortExpression="SPLIT_ID" UniqueName="SPLIT_ID" ReadOnly="true"
                        FilterControlWidth="60px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIECES" FilterControlAltText="Filter PIECES column" HeaderText="PIECES" ReadOnly="true"
                        SortExpression="PIECES" UniqueName="PIECES" FilterControlWidth="30px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OLD_MAT_CODE" FilterControlAltText="Filter OLD_MAT_CODE column" HeaderText="OLD MATERIAL CODE" SortExpression="OLD_MAT_CODE" UniqueName="OLD_MAT_CODE" ReadOnly="true"
                        FilterControlWidth="100px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO"  ItemStyle-Width="30px"  FilterControlWidth="50px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TC_NO" FilterControlAltText="Filter TC_NO column" HeaderText="TC_NO" SortExpression="TC_NO" UniqueName="TC_NO"  ItemStyle-Width="30px"  FilterControlWidth="50px">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="IRN_ITEM_ID" FilterControlAltText="Filter IRN_ITEM_ID column" HeaderText="IRN_ITEM_ID"
                        SortExpression="IRN_ITEM_ID" UniqueName="IRN_ITEM_ID" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="1px" />
                        <ItemStyle Width="1px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </asp:Content>

