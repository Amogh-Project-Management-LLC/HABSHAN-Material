<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Mat_Transf_ItemsAdd.aspx.cs" Inherits="Material_TransfAdd" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
    function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }
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
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }

    </script>
    <div style="background-color: whitesmoke" id="btndiv">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="80px" OnClick="btnSave_Click"></telerik:RadButton>

    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlGridSource" AllowMultiRowSelection="true" AllowFilteringByColumn="true"
            OnItemDataBound="itemsGrid_ItemDataBound" AllowPaging="true" PageSize="50" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <HeaderStyle HorizontalAlign="Center" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlGridSource" DataKeyNames="MAT_CODE1">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                          <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridClientSelectColumn>

                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" AllowFiltering="true" SortExpression="PO_NO" UniqueName="PO_NO">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" FilterControlWidth="60px"  HeaderText="ITEM NAME" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM NO"
                        SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO" FilterControlWidth="40px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="HEAT_NO" UniqueName="HEAT_NO" HeaderText="HEAT NO" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataTextField="Heat_no" DataValueField="Heat_no"
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                        </ItemTemplate>

                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO" HeaderText="CABLE DRUM NO" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlCableNo" runat="server" DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO" 
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <%--     <telerik:GridTemplateColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column"
                        HeaderText="HEAT NO" AllowFiltering="false" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="HEAT_NOTextBox" runat="server" Text='<%# Bind("HEAT_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="HEAT_NOLabel" runat="server" Text='<%# Eval("HEAT_NO") %>' Width="80px" onkeydown="return (event.keyCode!=13);"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="CABLE_DRUM_NO" FilterControlAltText="Filter CABLE_DRUM_NO column"
                        HeaderText="CABLE DRUM NO" AllowFiltering="false" SortExpression="CABLE_DRUM_NO" UniqueName="CABLE_DRUM_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="CABLE_DRUM_NOTextBox" runat="server" Text='<%# Bind("CABLE_DRUM_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="CABLE_DRUM_NOLabel" runat="server" Text='<%# Eval("CABLE_DRUM_NO") %>' Width="80px" onkeydown="return (event.keyCode!=13);"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" 
                        HeaderText="PAINT SYS" AllowFiltering="false" SortExpression="PAINT_SYS" UniqueName="PAINT_SYS">
                        <EditItemTemplate>
                            <asp:TextBox ID="PAINT_SYSTextBox" runat="server" Text='<%# Bind("PAINT_SYS") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="PAINT_SYSLabel" runat="server" Text='<%# Eval("PAINT_SYS") %>' Width="80px"  onkeydown="return (event.keyCode!=13);"></telerik:RadTextBox>
                        </ItemTemplate>

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>


                    <telerik:GridBoundColumn DataField="REQ_QTY" DataType="System.Decimal" FilterControlAltText="Filter REQ_QTY column" HeaderText="REQ QTY" AllowFiltering="false" SortExpression="REQ_QTY" UniqueName="REQ_QTY">

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="AVL_STOCK" DataType="System.Decimal" FilterControlAltText="Filter AVL_STOCK column"
                        HeaderText="AVAILABLE STOCK" SortExpression="AVL_STOCK" UniqueName="AVL_STOCK" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WHC_PO_BAL_QTY" DataType="System.Decimal" FilterControlAltText="Filter WHC_PO_BAL_QTY column"
                        HeaderText="WHC PO BAL QTY" SortExpression="WHC_PO_BAL_QTY" UniqueName="WHC_PO_BAL_QTY" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BALANCE_STOCK" DataType="System.Decimal" FilterControlAltText="Filter BALANCE_STOCK column"
                        HeaderText="BAL TO TRANSFER QTY" AllowFiltering="false" SortExpression="BALANCE_STOCK" UniqueName="BALANCE_STOCK">
                        <EditItemTemplate>
                            <asp:TextBox ID="BAL_QTYTextBox" runat="server" Text='<%# Bind("BALANCE_STOCK") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="BAL_QTYLabel" runat="server" Text='<%# Eval("BALANCE_STOCK") %>' Width="80px"  onkeydown="return (event.keyCode!=13);"></telerik:RadTextBox>
                        </ItemTemplate>

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="BOX_NO" FilterControlAltText="Filter BOX_NO column"
                        HeaderText="BOX NO" AllowFiltering="false" SortExpression="PAINT_SYS" UniqueName="BOX_NO">
                        <EditItemTemplate>
                            <asp:TextBox ID="BOX_NOTextBox" runat="server" Text='<%# Bind("BOX_NO") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="BOX_NOLabel" runat="server" Text='<%# Eval("BOX_NO") %>' Width="80px"  onkeydown="return (event.keyCode!=13);"></telerik:RadTextBox>
                        </ItemTemplate>

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="NO_OF_PIECE" FilterControlAltText="Filter NO_OF_PIECE column"
                        HeaderText="NO OF PIECE" AllowFiltering="false" SortExpression="PAINT_SYS" UniqueName="NO_OF_PIECE">
                        <EditItemTemplate>
                            <asp:TextBox ID="NO_OF_PIECETextBox" runat="server" Text='<%# Bind("NO_OF_PIECE") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="NO_OF_PIECELabel" runat="server" Text='<%# Eval("NO_OF_PIECE") %>' Width="80px"  onkeydown="return (event.keyCode!=13);"></telerik:RadTextBox>
                        </ItemTemplate>

                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <asp:SqlDataSource ID="sqlGridSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_MAT_ISSUE_BALANCE_MAIN2
           WHERE    MAT_REQ_ID IN  
            (SELECT MAT_REQ_ID FROM PIP_MAT_TRANSF,PIP_MAT_TRANSF_DETAIL
             WHERE PIP_MAT_TRANSF.TRANSF_ID =  PIP_MAT_TRANSF_DETAIL.TRANSF_ID(+)
             AND PIP_MAT_TRANSF.TRANSF_ID = :TRANSF_ID 
            ) AND balance_stock &gt; 0
        ORDER BY   MR_ITEM_NO ">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="TRANSF_ID" QueryStringField="TRANSF_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="HeatNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DrumNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>

</asp:Content>

