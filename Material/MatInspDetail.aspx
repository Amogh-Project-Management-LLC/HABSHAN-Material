<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatInspDetail.aspx.cs" Inherits="Material_MatInspDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= grdMRIRItems.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= grdMRIRItems.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divwidth = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight

            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = divwidth - 15 + "px";
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
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="110" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="110" Visible="false"></telerik:RadButton>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="Add Items" Width="100"></telerik:RadButton>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Import Barcode" Width="130" OnClick="btnImport_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnUpdate" runat="server" Text="Update Weight" Width="110" Visible="false"></telerik:RadButton>
                    <telerik:RadButton ID="btnImportExcel" runat="server" Text="Bulk Import.." Width="110" OnClick="btnImportExcel_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnImportFromMR" runat="server" Text="Import From RFI" Width="150" OnClick="btnImportFromMR_Click"></telerik:RadButton>
                    <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" Width="150" ForeColor="Red" Visible="false"
                        OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
        <telerik:RadGrid ID="grdMRIRItems" runat="server" PageSize="50" AllowPaging="True" DataSourceID="ObjSrcMRIRItems"  AllowAutomaticDeletes="true" MasterTableView-EditMode="InPlace"
            AllowAutomaticUpdates="true" OnSelectedIndexChanged="grdMRIRItems_SelectedIndexChanged" Font-Size="9pt" AllowSorting="true" OnItemDataBound="grdMRIRItems_ItemDataBound"
            PagerStyle-AlwaysVisible="true" OnItemCommand="grdMRIRItems_ItemCommand" OnDataBinding="grdMRIRItems_DataBinding" onkeypress="handleSpace(event)"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowMultiRowSelection="true">

            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" FrozenColumnsCount="7" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="ObjSrcMRIRItems" DataKeyNames="MIR_ITEM_ID" AllowFilteringByColumn="true"
                AllowMultiColumnSorting="true" TableLayout="Fixed" ClientDataKeyNames="MIR_ITEM_ID">
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
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" FilterControlWidth="50px"
                        SortExpression="PO_ITEM" UniqueName="PO_ITEM" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MIR_ITEM" FilterControlAltText="Filter MIR_ITEM column" HeaderText="MIR ITEM" FilterControlWidth="50px"
                        SortExpression="MIR_ITEM" UniqueName="MIR_ITEM" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" FilterControlWidth="100px"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" ReadOnly="True" AutoPostBackOnFilter="true">
                        <ItemStyle Width="160px" />
                        <HeaderStyle Width="160px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION"
                        SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" ReadOnly="True" AutoPostBackOnFilter="true">
                        <ItemStyle Width="160px" />
                        <HeaderStyle Width="160px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV QTY"
                        SortExpression="RCV_QTY" UniqueName="RCV_QTY" AllowFiltering="false">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACPT_QTY" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACPT QTY"
                        SortExpression="ACPT_QTY" UniqueName="ACPT_QTY" AllowFiltering="false">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIECES" FilterControlAltText="Filter PIECES column" HeaderText="PIECES"
                        SortExpression="PIECES" UniqueName="PIECES" AllowFiltering="false">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AS_PER_PL_QTY" FilterControlAltText="Filter AS_PER_PL_QTY column" HeaderText="PL QTY"
                        SortExpression="AS_PER_PL_QTY" UniqueName="AS_PER_PL_QTY" AllowFiltering="false">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXC_QTY" FilterControlAltText="Filter EXC_QTY column" HeaderText="EXCESS"
                        SortExpression="EXC_QTY" UniqueName="EXC_QTY" AllowFiltering="false">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SH_QTY" FilterControlAltText="Filter SH_QTY column" HeaderText="SHORTAGE"
                        SortExpression="SH_QTY" UniqueName="SH_QTY" AllowFiltering="false">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DAMAG_QTY" FilterControlAltText="Filter DAMAG_QTY column" HeaderText="DAMAGE"
                        SortExpression="DAMAG_QTY" UniqueName="DAMAG_QTY" AllowFiltering="false">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TOTAL_WT" ReadOnly="true" FilterControlAltText="Filter TOTAL_WT column"
                        HeaderText="WEIGHT (KG)" SortExpression="TOTAL_WT" UniqueName="TOTAL_WT" DataType="System.Decimal" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO" AutoPostBackOnFilter="true"
                        SortExpression="HEAT_NO" UniqueName="HEAT_NO" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" HeaderText="PAINT SYS" AutoPostBackOnFilter="true"
                        SortExpression="PAINT_SYS" UniqueName="PAINT_SYS" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TC_CODE" ReadOnly="true" FilterControlAltText="Filter TC_CODE column" HeaderText="MTC CODE" FilterControlWidth="50px"
                        SortExpression="TC_CODE" UniqueName="TC_CODE" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" ReadOnly="true" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" FilterControlWidth="50px"
                        SortExpression="ITEM_NAM" UniqueName="ITEM_NAM">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" ReadOnly="true" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" FilterControlWidth="50px"
                        SortExpression="SIZE_DESC" UniqueName="SIZE_DESC">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" ReadOnly="true" FilterControlAltText="Filter WALL_THK column"
                        HeaderText="THK" SortExpression="WALL_THK" UniqueName="WALL_THK" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" ReadOnly="true" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" FilterControlWidth="50px"
                        SortExpression="UOM_NAME" UniqueName="UOM_NAME">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" FilterControlAltText="Filter CABLE_DRUM_NO column" HeaderText="CABLE DRUM NO" FilterControlWidth="50px"
                        SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_STORE_LOC" ReadOnly="true" FilterControlAltText="Filter SUB_STORE_LOC column" HeaderText="SUB STORE LOC" FilterControlWidth="50px"
                        SortExpression="SUB_STORE_LOC" UniqueName="SUB_STORE_LOC">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_WAREHOUSE" FilterControlAltText="Filter SUB_WAREHOUSE column" HeaderText="SUB WAREHOUSE" FilterControlWidth="50px"
                        SortExpression="SUB_WAREHOUSE" UniqueName="SUB_WAREHOUSE">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LINE_NO" FilterControlAltText="Filter LINE_NO column" HeaderText="LINE NO" FilterControlWidth="50px"
                        SortExpression="LINE_NO" UniqueName="LINE_NO">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RACK_NO" FilterControlAltText="Filter RACK_NO column" HeaderText="RACK NO" FilterControlWidth="50px"
                        SortExpression="RACK_NO" UniqueName="RACK_NO">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHELF_NO" FilterControlAltText="Filter SHELF_NO column" HeaderText="SHELF NO" FilterControlWidth="50px"
                        SortExpression="SHELF_NO" UniqueName="SHELF_NO">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" FilterControlWidth="50px"
                        SortExpression="REMARKS" UniqueName="REMARKS">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MIR_ITEM_ID" FilterControlAltText="Filter MIR_ITEM_ID column" HeaderText="MIR_ITEM_ID"
                        SortExpression="MIR_ITEM_ID" UniqueName="MIR_ITEM_ID" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="1px" />
                        <ItemStyle Width="1px" />
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>

                    <PopUpSettings Modal="True" KeepInScreenBounds="True"></PopUpSettings>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="ObjSrcMRIRItems" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MIR_DTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_MIR_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MIR_ID" QueryStringField="MIR_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="MIR_ITEM" Type="String" />
            <asp:Parameter Name="RCV_QTY" Type="Decimal" />
            <asp:Parameter Name="ACPT_QTY" Type="Decimal" />
            <asp:Parameter Name="PIECES" Type="Decimal" />
            <asp:Parameter Name="AS_PER_PL_QTY" Type="Decimal" />
            <asp:Parameter Name="EXC_QTY" Type="Decimal" />
            <asp:Parameter Name="SH_QTY" Type="Decimal" />
            <asp:Parameter Name="DAMAG_QTY" Type="Decimal" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="PAINT_SYS" Type="String" />
            <asp:Parameter Name="SUB_WAREHOUSE" Type="String" />
            <asp:Parameter Name="LINE_NO" Type="String" />
            <asp:Parameter Name="RACK_NO" Type="String" />
            <asp:Parameter Name="SHELF_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="Original_MIR_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

