<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MRDetail.aspx.cs" Inherits="Procurement_MRDetail" %>

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
            grid.get_element().style.width = width - 20 + "px";
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
        function RowDblClickCancel(sender, eventArgs) {
            return false;
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
                    <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton runat="server" ID="btnAdd" Text="Add Items" Width="100px" OnClick="btnAdd_Click" Visible="false"></telerik:RadButton>
                    <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" Width="150px" ForeColor="Red" Visible="false"
                        OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>


    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" DataSourceID="itemsDataSource" GridLines="None" AllowSorting="true" AllowMultiRowSelection="true"
            AllowPaging="true" PageSize="50" AllowFilteringByColumn="true" OnItemCommand="itemsGrid_ItemCommand" OnItemDataBound="itemsGrid_ItemDataBound"
            OnDataBinding="itemsGrid_DataBinding" PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)"
            OnFilterCheckListItemsRequested="RadGrid_FilterCheckListItems" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" FilterType="HeaderContext"
            OnPreRender="itemsGrid_PreRender">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="True" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                
            </ClientSettings>

            <MasterTableView AutoGenerateColumns="False" DataKeyNames="MR_ITEM_ID" DataSourceID="itemsDataSource" EditMode="InPlace"
                AllowMultiColumnSorting="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>

                    <telerik:GridEditCommandColumn ButtonType="ImageButton" EnableHeaderContextMenu="false">
                        <HeaderStyle Width="55px" />
                        <ItemStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn UniqueName="DeleteColumn" ButtonType="ImageButton" CommandName="Delete" EnableHeaderContextMenu="false">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect" EnableHeaderContextMenu="false">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    <%-- <telerik:GridBoundColumn DataField="AREA" FilterControlAltText="Filter AREA column" HeaderText="AREA" SortExpression="AREA" 
                        UniqueName="AREA" AllowFiltering="false" ReadOnly="true">
                         <HeaderStyle Width="100px" />                        
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_AREA" FilterControlAltText="Filter SUB_AREA column" HeaderText="SUB AREA" 
                        SortExpression="SUB_AREA" UniqueName="SUB_AREA" AllowFiltering="false" ReadOnly="true">
                         <HeaderStyle Width="100px" />                        
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" AllowFiltering="true" 
                        FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM" SortExpression="MR_ITEM_NO"
                        UniqueName="MR_ITEM_NO" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="70px" />
                        <ItemStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SEC_KEY" AllowFiltering="false" DataType="System.Decimal"
                        FilterControlAltText="Filter SEC_KEY column" HeaderText="SEQ" ReadOnly="True" SortExpression="SEC_KEY" Visible="false"
                        UniqueName="SEC_KEY">
                        <HeaderStyle Width="50px" />
                        <ItemStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TAG_NO" FilterControlAltText="Filter TAG_NO column" HeaderText="TAG NO"
                        SortExpression="TAG_NO" UniqueName="TAG_NO" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="ITEM_DESCR" FilterControlAltText="Filter ITEM_DESCR column" HeaderText="ITEM DESCRIPTION"
                        SortExpression="ITEM_DESCR" UniqueName="ITEM_DESCR" AutoPostBackOnFilter="true" ReadOnly="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="250px" />
                        <ItemStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                        SortExpression="WALL_THK" UniqueName="WALL_THK" AutoPostBackOnFilter="true" ReadOnly="true" EnableHeaderContextMenu="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_QTY" DataType="System.Decimal" FilterControlAltText="Filter MR_QTY column" HeaderText="QTY" DataFormatString="{0:N2}"
                        ItemStyle-HorizontalAlign="Right" SortExpression="MR_QTY" UniqueName="MR_QTY" EnableHeaderContextMenu="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PREV_QTY" EnableHeaderContextMenu="false" DataType="System.Decimal"
                        FilterControlAltText="Filter PREV_QTY column" HeaderText="PREV QTY" DataFormatString="{0:N2}"
                        ItemStyle-HorizontalAlign="Right" SortExpression="PREV_QTY" UniqueName="PREV_QTY">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DELTA_QTY" EnableHeaderContextMenu="false" DataType="System.Decimal" DataFormatString="{0:N2}"
                        ItemStyle-HorizontalAlign="Right" FilterControlAltText="Filter DELTA_QTY column" HeaderText="DELTA QTY"
                        SortExpression="DELTA_QTY" UniqueName="DELTA_QTY" ReadOnly="true">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DELIVERY_POINT" FilterControlAltText="Filter DELIVERY_POINT column"
                        HeaderText="DELIVERY POINT" SortExpression="DELIVERY_POINT" UniqueName="DELIVERY_POINT" AutoPostBackOnFilter="true"
                        FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CONST_AREA" FilterControlAltText="Filter CONST_AREA column" HeaderText="CONSTRUCTION AREA"
                        SortExpression="CONST_AREA" UniqueName="CONST_AREA" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                        SortExpression="REMARKS" UniqueName="REMARKS" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM_ID" FilterControlAltText="Filter MR_ITEM_ID column" HeaderText="MR ITEM ID"
                        SortExpression="MR_ITEM_ID" UniqueName="MR_ITEM_ID" EnableHeaderContextMenu="false" ReadOnly="true">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

   <asp:SqlDataSource ID="itemsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM   VIEW_ADAPTER_MAT_REQ_DETAILS WHERE (MR_ID = :MR_ID)"
        DeleteCommand="DELETE FROM PIP_MAT_REQUISITION_DETAIL WHERE  (MR_ITEM_ID = :MR_ITEM_ID)"
        UpdateCommand="UPDATE PIP_MAT_REQUISITION_DETAIL
                       SET       MR_ITEM_NO = :MR_ITEM_NO, TAG_NO = :TAG_NO, MAT_CODE1 = :MAT_CODE1, MR_QTY = :MR_QTY, PREV_QTY = :PREV_QTY, DELIVERY_POINT = :DELIVERY_POINT, CONST_AREA = :CONST_AREA, REMARKS = :REMARKS
                       WHERE (MR_ITEM_ID = :MR_ITEM_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MR_ID" QueryStringField="MR_ID" Type="Decimal" />
        </SelectParameters>
       <DeleteParameters>
            <asp:Parameter Name="MR_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
         <UpdateParameters>
            <asp:Parameter Name="MR_ITEM_NO" Type="String" />
            <asp:Parameter Name="TAG_NO" Type="String" />
            <asp:Parameter Name="MAT_CODE1" Type="String" />
            <asp:Parameter Name="MR_QTY" Type="Decimal" />
            <asp:Parameter Name="PREV_QTY" Type="Decimal" />
            <asp:Parameter Name="DELIVERY_POINT" Type="String" />
            <asp:Parameter Name="CONST_AREA" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="MR_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

