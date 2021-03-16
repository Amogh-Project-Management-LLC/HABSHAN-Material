<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialCatalogGrid.aspx.cs" Inherits="MaterialCatalogGrid" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
        Sys.Application.add_load(Test);
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("btndiv").clientHeight

            var divFooter = document.getElementById("footerDiv").clientHeight

            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 65 + "px";
            grid.get_element().style.width = width - 15 + "px";

            grid.repaint();
        }
        function RowDblClick(sender, eventArgs) {
            
            window.radopen("MaterialTotalStatus.aspx?MAT_CODE1=" + eventArgs.getDataKeyValue("MAT_CODE1"),null,1000,500);
        }
    </script>
    <div id="btndiv" style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnRegister" runat="server" Text="New Material" Width="110" OnClick="btnRegister_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnStatus" runat="server" Text="Status" OnClick="btnStatus_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSummary" runat="server" Text="Store Wise Status" Width="150" OnClick="btnSummary_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnView" runat="server" Text="View" OnClick="btnView_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnImportMat" runat="server" Text="Bulk Matcode Import" Width="110" OnClick="btnImportMat_Click"></telerik:RadButton>

    </div>
    <div style="margin-top: 2px">
        <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
            <PersistenceSettings>
                <telerik:PersistenceSetting ControlID="itemsGrid" />
            </PersistenceSettings>
        </telerik:RadPersistenceManager>

        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" PageSize="50" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            AllowSorting="true" AllowFilteringByColumn="true" OnPreRender="itemsGrid_PreRender" OnItemDataBound="itemsGrid_ItemDataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowColumnsReorder="True" AllowKeyboardNavigation="true">
                <Resizing AllowColumnResize="true"></Resizing>
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <ClientSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="MAT_ID,MAT_CODE1" ClientDataKeyNames="MAT_ID,MAT_CODE1" AllowMultiColumnSorting="true"
                EnableHeaderContextMenu="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" PageSize="50" AllowFilteringByColumn="true"
                TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <%--<telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridTemplateColumn DataField="MAT_CODE1" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" FilterControlWidth="120px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MAT_CODE1") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# DataBinder.Eval(Container, "DataItem.MAT_CODE1") %>'>
                            </asp:Label>
                            <%-- <telerik:RadToolTip RenderMode="Lightweight" ID="RadToolTip1" runat="server" TargetControlID="Label1" Width="150px"
                                Font-Size="Larger" RelativeTo="Element" Position="TopCenter">
                                <table>
                                    <tr>
                                        <td>MAT CODE:<%# DataBinder.Eval(Container, "DataItem.MAT_CODE1") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>ITEM NAME: <%# DataBinder.Eval(Container, "DataItem.ITEM_NAM") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>PO QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_PO_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>IRN REL QTY:<%# DataBinder.Eval(Container, "DataItem.SUM_RELEASE_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>MRR RECV QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_RECV_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>MRIR ACPT QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_MRIR_ACPT_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>MR REQUEST QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_MAT_REQ_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>TRANSFER QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_TRANSF_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>MAT RCV QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_TRANS_RECV_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>MIV REQ QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_MIV_REQ_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>MIV ISSUE QTY: <%# DataBinder.Eval(Container, "DataItem.SUM_MIV_ISSUE_QTY") %>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>BALANCE: <%# DataBinder.Eval(Container, "DataItem.BALANCE") %>
                                        </td>
                                    </tr>

                                </table>
                            </telerik:RadToolTip>--%>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE2" FilterControlAltText="Filter MAT_CODE2 column" HeaderText="MATERIAL CODE2" SortExpression="MAT_CODE2" UniqueName="MAT_CODE2" FilterControlWidth="120px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="WALL THK" SortExpression="WALL_THK" UniqueName="WALL_THK" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM" FilterControlAltText="Filter UOM column" HeaderText="UNIT" SortExpression="UOM" UniqueName="UOM" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" FilterControlWidth="120px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NUMBER" SortExpression="HEAT_NO" UniqueName="HEAT_NO" FilterControlWidth="60px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <div style="background-color: whitesmoke">
        <table>
            <tr>
                <td>
                    <div id="footerDiv">
                        <telerik:RadButton ID="btnPOdepend" runat="server" Text="PO" Width="80" OnClick="btnPOdepend_Click"></telerik:RadButton>
                    </div>
                </td>
                <td>
                    <telerik:RadButton ID="btnRecvd" runat="server" Text="MRV" Width="80" OnClick="btnRecvd_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMRIR" runat="server" Text="MRIR" Width="80" OnClick="btnMRIR_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnTrans" runat="server" Text="Transfer" Width="80" OnClick="btnTrans_Click"></telerik:RadButton>
                </td>

                <td>
                    <telerik:RadButton ID="btnAddIssue" runat="server" Text="Add Issue" Width="80" OnClick="btnAddIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnHeatNos" runat="server" Text="Heat Nos" Width="80" OnClick="btnHeatNos_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMTC_Click"></telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsMainTablesATableAdapters.VIEW_ADAPTER_MAT_STOCKTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />

        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

