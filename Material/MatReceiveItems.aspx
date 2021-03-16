<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceiveItems.aspx.cs" Inherits="Material_MatReceiveItems" Title="MRV" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = width + "px";
            grid.repaint();
            //console.log("h:" + height + " W:" + width);
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
    <div>
        <table style="width: 100%; background-color: gainsboro;" id="HeaderButtons">
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80" OnClick="btnBack_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnAddItems" runat="server" Text="Add Items" Width="100" OnClick="btnAddItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDeleteAll" runat="server" Text="Delete Selected Items"
                        OnClientClicking="RadConfirm" Width="150" ForeColor="Red" Visible="false" OnClick="btnDeleteAll_Click">
                    </telerik:RadButton>
                </td>

                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtMatCode" runat="server" Width="200px" EmptyMessage="Search.." AutoPostBack="true" Visible="false"></telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <div>
        <telerik:RadGrid ID="itemsGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataKeyNames="RCV_ITEM_ID" DataSourceID="RecvItemsDataSource" SkinID="GridViewSkin" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
            PageSize="50" OnDataBound="itemsGridView_DataBound" OnRowUpdating="itemsGridView_RowUpdating" AllowSorting="true" PagerStyle-AlwaysVisible="true"
            OnPageIndexChanged="itemsGridView_PageIndexChanged" OnSelectedIndexChanged="itemsGridView_SelectedIndexChanged" onkeypress="handleSpace(event)"
            AllowFilteringByColumn="true" OnItemDataBound="itemsGridView_ItemDataBound" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true" AllowMultiRowSelection="true">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AllowMultiColumnSorting="true" DataSourceID="RecvItemsDataSource" DataKeyNames="RCV_ITEM_ID" EditMode="InPlace"
                TableLayout="Fixed">
<PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <HeaderStyle Width="55px" />
                        <ItemStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure you want to delete">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridClientSelectColumn>

                    <telerik:GridBoundColumn DataField="IRN_NO" HeaderText="IRN NO" SortExpression="IRN_NO" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="80px" ReadOnly="true">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM" FilterControlAltText="Filter MR_ITEM column" HeaderText="MR ITEM" FilterControlWidth="50px"
                        SortExpression="MR_ITEM" UniqueName="MR_ITEM" AutoPostBackOnFilter="true">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" FilterControlWidth="50px"
                        SortExpression="PO_ITEM" UniqueName="PO_ITEM" AutoPostBackOnFilter="true">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" FilterControlWidth="80px" AutoPostBackOnFilter="true" ReadOnly="true">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" ReadOnly="true" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <HeaderStyle Width="350px" />
                        <ItemStyle Width="350px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECV_QTY" FilterControlAltText="Filter RECV_QTY column" HeaderText="RECEIVED QTY" FilterControlWidth="50px"
                        SortExpression="RECV_QTY" UniqueName="RECV_QTY" AutoPostBackOnFilter="true">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIECES" FilterControlAltText="Filter PIECES column" HeaderText="RECEIVED PIECES" FilterControlWidth="50px"
                        SortExpression="PIECES" UniqueName="PIECES" AutoPostBackOnFilter="true">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="ACT_LEN" FilterControlAltText="Filter ACT_LEN column" HeaderText="LENGTH (PIPE)" FilterControlWidth="50px"
                        SortExpression="ACT_LEN" UniqueName="ACT_LEN" AutoPostBackOnFilter="true">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" HeaderText="SIZE" ReadOnly="True" SortExpression="SIZE_DESC"  AutoPostBackOnFilter="true" FilterControlWidth="50%">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" HeaderText="THK" ReadOnly="True" SortExpression="WALL_THK" AllowFiltering="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" HeaderText="ITEM NAME" ReadOnly="True" SortExpression="ITEM_NAM" AllowFiltering="false">
                        <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" HeaderText="UNIT" ReadOnly="True" SortExpression="UOM_NAME" AllowFiltering="false">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO" SortExpression="CABLE_DRUM_NO" AllowFiltering="false">
                        <HeaderStyle Width="130px" />
                        <ItemStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CTRL_NO" HeaderText="CONTROL NO" SortExpression="CTRL_NO" AllowFiltering="false">
                        <HeaderStyle Width="130px" />
                        <ItemStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="false">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_ITEM_ID" FilterControlAltText="Filter RCV_ITEM_ID column" HeaderText="RCV_ITEM_ID"
                        SortExpression="RCV_ITEM_ID" UniqueName="RCV_ITEM_ID" AllowFiltering="false" ReadOnly="true">
                        <HeaderStyle Width="1px" />
                        <ItemStyle Width="1px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="RecvItemsDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsPO_ShipmentATableAdapters.VIEW_ADAPTER_MAT_RCV_DETAILTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="MR_ITEM" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="RECV_QTY" Type="Decimal" />
            <asp:Parameter Name="PIECES" Type="Decimal" />
            <asp:Parameter Name="ACT_LEN" Type="Decimal" />
            <asp:Parameter Name="CABLE_DRUM_NO" Type="String" />
            <asp:Parameter Name="CTRL_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RCV_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_RCV_ID" QueryStringField="MAT_RCV_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <%-- <asp:SqlDataSource ID="statusDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STATUS_ID, STATUS_CODE FROM PIP_MAT_STATUS"></asp:SqlDataSource>--%>
</asp:Content>
