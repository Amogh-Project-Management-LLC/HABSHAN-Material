<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PODetails.aspx.cs" Inherits="Procurement_PODetails" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divwidth = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = divwidth - 15 + "px";
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
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Width="80px">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Material" Visible="false"></telerik:RadButton>
        <telerik:RadButton ID="btnImportMR" runat="server" Text="Import MR MTO" OnClick="btnImportMR_Click"></telerik:RadButton>

        <telerik:RadButton RenderMode="Lightweight" ID="btnDeleteAll" runat="server" Text="Delete Selected Items" Width="150" ForeColor="Red" Visible="false"
            OnClientClicking="RadConfirm" OnClick="btnDeleteAll_Click">
        </telerik:RadButton>
    </div>

    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" AllowPaging="True" AllowMultiRowSelection="true"
            AllowSorting="true" PagerStyle-AlwaysVisible="true" OnItemCommand="itemsGrid_ItemCommand" onkeypress="handleSpace(event)"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            PageSize="50" OnDataBinding="itemsGrid_DataBinding" AllowFilteringByColumn="true" OnItemDataBound="itemsGrid_ItemDataBound">
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Scrolling UseStaticHeaders="true" AllowScroll="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" DataKeyNames="PO_ITEM_ID"
                AllowMultiColumnSorting="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>
                    

                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM"
                        SortExpression="PO_ITEM" UniqueName="PO_ITEM" AllowFiltering="true" FilterControlWidth="30px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="60px" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <%-- <telerik:GridBoundColumn DataField="MAT_CODE2" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MAT CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2" AutoPostBackOnFilter="true" ItemStyle-Width="40px" FilterControlWidth="60px" ReadOnly="true">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE3" FilterControlAltText="Filter MAT_CODE3 column" HeaderText="MAT CODE3" SortExpression="MAT_CODE3" UniqueName="MAT_CODE3" AutoPostBackOnFilter="true"  ItemStyle-Width="40px" FilterControlWidth="60px" ReadOnly="true">
                    </telerik:GridBoundColumn>   --%>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCR"
                        SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UoM" SortExpression="UOM_NAME" UniqueName="UOM_NAME" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AllowFiltering="false" >
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                        SortExpression="WALL_THK" UniqueName="WALL_THK" AllowFiltering="false" >
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />

                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIECES" DataType="System.Decimal" FilterControlAltText="Filter PIECES column"
                        HeaderText="PIECES" SortExpression="PIECES" UniqueName="PIECES" AllowFiltering="false"
                        DataFormatString="{0:N2}">
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column"
                        HeaderText="PO QTY" SortExpression="PO_QTY" UniqueName="PO_QTY" AllowFiltering="false" DataFormatString="{0:N2}">
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V1_QTY" DataType="System.Decimal" FilterControlAltText="Filter V1_QTY column"
                        HeaderText="VO-OO1 QTY" SortExpression="V1_QTY" UniqueName="V1_QTY" AllowFiltering="false" DataFormatString="{0:N2}">
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V2_QTY" DataType="System.Decimal" FilterControlAltText="Filter V2_QTY column"
                        HeaderText="VO-OO2 QTY" SortExpression="V2_QTY" UniqueName="V2_QTY" AllowFiltering="false" DataFormatString="{0:N2}">
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V3_QTY" DataType="System.Decimal" FilterControlAltText="Filter V3_QTY column"
                        HeaderText="VO-OO3 QTY" SortExpression="V3_QTY" UniqueName="V3_QTY" AllowFiltering="false" DataFormatString="{0:N2}">
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V4_QTY" DataType="System.Decimal" FilterControlAltText="Filter V4_QTY column"
                        HeaderText="VO-OO4 QTY" SortExpression="V4_QTY" UniqueName="V4_QTY" AllowFiltering="false" DataFormatString="{0:N2}">
                        <ItemStyle Width="90px" HorizontalAlign="Right" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CDD_DATE" DataType="System.DateTime" FilterControlAltText="Filter CDD_DATE column" HeaderText="CDD DATE" SortExpression="CDD_DATE" UniqueName="CDD_DATE" FilterControlWidth="60px" ReadOnly="true"
                        DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA" DataType="System.DateTime" FilterControlAltText="Filter ETA column" HeaderText="ETA" SortExpression="ETA" UniqueName="ETA" FilterControlWidth="60px" ReadOnly="true"
                        DataFormatString="{0:dd-MMM-yyyy}" AutoPostBackOnFilter="true">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DETAIL_REMARKS" FilterControlAltText="Filter DETAIL_REMARKS column" HeaderText="DETAIL REMARKS" SortExpression="DETAIL_REMARKS"
                        UniqueName="DETAIL_REMARKS" FilterControlWidth="60px"
                        AutoPostBackOnFilter="true">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_ID" FilterControlAltText="Filter PO_ITEM_ID column" HeaderText="PO ITEM ID"
                        SortExpression="PO_ITEM_ID" UniqueName="PO_ITEM_ID" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_ATableAdapters.VIEW_ADAPTER_PO_DETAILTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="original_PO_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PO_ID" QueryStringField="PO_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="PIECES" Type="Decimal" />
            <asp:Parameter Name="PO_QTY" Type="Decimal" />
            <asp:Parameter Name="V1_QTY" Type="Decimal" />
            <asp:Parameter Name="V2_QTY" Type="Decimal" />
            <asp:Parameter Name="V3_QTY" Type="Decimal" />
            <asp:Parameter Name="V4_QTY" Type="Decimal" />
            <asp:Parameter Name="SIZE_DESC" Type="String" />
            <asp:Parameter Name="WALL_THK" Type="String" />
            <asp:Parameter Name="MAT_DESCR" Type="String" />
            <asp:Parameter Name="original_PO_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

