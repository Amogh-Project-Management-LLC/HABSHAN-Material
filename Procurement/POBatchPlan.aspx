<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POBatchPlan.aspx.cs" Inherits="Procurement_POBatchPlan" %>

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
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 70 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }

        function new_batch_revision() {
            try {
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("BATCH_ID");
                radopen("POBatchRevNew.aspx?BATCH_ID=" + id, "RadWindow2", 850, 500);
            }
            catch (err) {
                txt = "Select Batch";
                alert(txt);
            }
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }

    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnCreate" runat="server" Text="New Batch"></telerik:RadButton>
        <%-- <telerik:RadButton ID="btnRevision" runat="server" Text="Create Revision" OnClientClick="new_batch_revision(); return false;"></telerik:RadButton>--%>
        <asp:LinkButton ID="linkRevision" runat="server" OnClientClick="new_batch_revision(); return false;">
            <telerik:RadButton ID="btnNewRevision" runat="server" Text="New Revision" Width="110"></telerik:RadButton>
        </asp:LinkButton>
        <telerik:RadButton ID="btnRevision" runat="server" Text="Revisions" OnClick="btnRevision_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnBatchItems" runat="server" Text="Batch Items" OnClick="btnBatchItems_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSearchItems" runat="server" Text="Search Items"></telerik:RadButton>
        <%--<telerik:RadButton ID="btnBulkImport" runat="server" Text="Bulk Import" OnClick="btnBulkImport_Click"></telerik:RadButton>--%>
        <telerik:RadDropDownList ID="ddlStatus" runat="server" OnSelectedIndexChanged="ddlStatus_SelectedIndexChanged" AutoPostBack="true">
            <Items>
                <telerik:DropDownListItem Text="Update Batch Status" Value="" Selected="true" />
                <telerik:DropDownListItem Text="Batch Pending" Value="Pending" />
                <telerik:DropDownListItem Text="Batch Approved" Value="Approved" />
                <telerik:DropDownListItem Text="Batch Rejected" Value="Rejected" />
            </Items>
        </telerik:RadDropDownList>
        <telerik:RadDropDownList ID="ddlRevStatus" runat="server" OnSelectedIndexChanged="ddlRevStatus_SelectedIndexChanged" AutoPostBack="true">
            <Items>
                <telerik:DropDownListItem Text="Update Rev Status" Value="" Selected="true" />
                <telerik:DropDownListItem Text="Rev Pending" Value="Pending" />
                <telerik:DropDownListItem Text="Rev Approved" Value="Approved" />
                <telerik:DropDownListItem Text="Rev Rejected" Value="Rejected" />
            </Items>
        </telerik:RadDropDownList>
        <telerik:RadButton ID="bulkBatchImport" runat="server" Text="Bulk Batch Import" Width="200px" OnClick="bulkBatchImport_Click">
            <Icon PrimaryIconUrl="../Images/icons/excel.png" />
        </telerik:RadButton>

    </div>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" PageSize="50"
            AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" OnItemCommand="itemsGrid_ItemCommand" onkeypress="handleSpace(event)"
            AllowSorting="true" AllowFilteringByColumn="true" OnPreRender="itemsGrid_PreRender" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="BATCH_ID" ClientDataKeyNames="BATCH_ID" AllowMultiColumnSorting="true"
                AllowPaging="true" PagerStyle-AlwaysVisible="true" EditMode="InPlace">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER" SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" FilterControlWidth="140px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BATCH_NO" FilterControlAltText="Filter BATCH_NO column" HeaderText="BATCH NO" SortExpression="BATCH_NO" UniqueName="BATCH_NO" AutoPostBackOnFilter="true" FilterControlWidth="35px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_NO" FilterControlAltText="Filter REV_NO column" HeaderText="REVISION" SortExpression="REV_NO" UniqueName="REV_NO" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="35px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DELIVERY_FORECAST" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter DELIVERY_FORECAST column" HeaderText="DELIVERY FORECAST" SortExpression="DELIVERY_FORECAST" UniqueName="DELIVERY_FORECAST" AutoPostBackOnFilter="true" FilterControlWidth="60px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATE BY" SortExpression="CREATE_BY" UniqueName="CREATE_BY" AutoPostBackOnFilter="true" FilterControlWidth="65px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" DataType="System.DateTime" DataFormatString="{0:dd-MMM-yyyy}" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" AutoPostBackOnFilter="true" FilterControlWidth="60px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STATUS" FilterControlAltText="Filter STATUS column" HeaderText="BATCH STATUS" SortExpression="STATUS" UniqueName="STATUS" AutoPostBackOnFilter="true" FilterControlWidth="70px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REV_STATUS" FilterControlAltText="Filter REV_STATUS column" HeaderText="REV STATUS" SortExpression="REV_STATUS" UniqueName="REV_STATUS" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXPEDITOR" FilterControlAltText="Filter EXPEDITOR column" HeaderText="EXPEDITOR" SortExpression="EXPEDITOR" UniqueName="EXPEDITOR" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="70px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_NAME" FilterControlAltText="Filter VENDOR_NAME column" HeaderText="VENDOR" SortExpression="VENDOR_NAME" UniqueName="VENDOR_NAME" AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="180px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" AllowFiltering="false" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AutoPostBackOnFilter="true" FilterControlWidth="70px">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_BATCH_PLANTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_BATCH_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_BATCH_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

