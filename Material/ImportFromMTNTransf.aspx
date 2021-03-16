<%@ Page Title="MTN Receive" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportFromMTNTransf.aspx.cs" Inherits="MTNReceiveDetailImportFromMTNTransf" %>

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
            OnItemDataBound="itemsGrid_ItemDataBound" onkeypress="handleSpace(event)" PageSize="50" PagerStyle-AlwaysVisible="true" AllowPaging="True" >
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
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlGridSource" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500,1000" />
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                         <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="PO_ID" FilterControlAltText="Filter PO_ID column" HeaderText="PO_ID" AllowFiltering="false" SortExpression="PO_ID" UniqueName="PO_ID">
                        <ItemStyle Width="1px" />
                        <HeaderStyle Width="1px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" AllowFiltering="true" SortExpression="PO_NO" UniqueName="PO_NO">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <%-- <telerik:GridBoundColumn DataField="TRANSF_NO" FilterControlAltText="Filter TRANSF_NO column" HeaderText="TRANSF NO" AllowFiltering="false" SortExpression="TRANSF_NO" UniqueName="TRANSF_NO">
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_ITEM_NO" FilterControlAltText="Filter MR_ITEM_NO column" HeaderText="MR ITEM NO" AutoPostBackOnFilter="true"
                         SortExpression="MR_ITEM_NO" UniqueName="MR_ITEM_NO" FilterControlWidth="40px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" AllowFiltering="true" AutoPostBackOnFilter="true" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" FilterControlWidth="80px">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="HEAT_NO" UniqueName="HEAT_NO" HeaderText="HEAT NO" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataTextField="HEAT_NO" DataValueField="HEAT_NO"
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
                    <telerik:GridTemplateColumn DataField="NO_OF_PIECE" DataType="System.Decimal" FilterControlAltText="Filter NO_OF_PIECE column" HeaderText="NO OF PIECE" AllowFiltering="false" SortExpression="NO_OF_PIECE" UniqueName="NO_OF_PIECE">
                        <EditItemTemplate>
                            <asp:TextBox ID="NO_OF_PIECETextBox" runat="server" Text='<%# Bind("NO_OF_PIECE") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="NO_OF_PIECELabel" runat="server" Text='<%# Eval("NO_OF_PIECE") %>' onkeydown="return (event.keyCode!=13);" Width="80px" ></telerik:RadTextBox>
                        </ItemTemplate>
                         <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="PAINT_SYS" FilterControlAltText="Filter PAINT_SYS column" HeaderText="PAINT SYS" AllowFiltering="false" SortExpression="PAINT_SYS" UniqueName="PAINT_SYS">
                         <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANSF_QTY" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_QTY column" HeaderText="TRANSF QTY" AllowFiltering="false" SortExpression="TRANSF_QTY" UniqueName="TRANSF_QTY">
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV QTY" AllowFiltering="false" SortExpression="RCV_QTY" UniqueName="RCV_QTY">
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="EXCESS_QTY" DataType="System.Decimal" FilterControlAltText="Filter EXCESS_QTY column" HeaderText="EXCESS QTY" AllowFiltering="false" SortExpression="EXCESS_QTY" UniqueName="EXCESS_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="EXCESS_QTYTextBox" runat="server" Text='<%# Bind("EXCESS_QTY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="EXCESS_QTYLabel" runat="server" Text='<%# Eval("EXCESS_QTY") %>' onkeydown="return (event.keyCode!=13);" Width="80px"></telerik:RadTextBox>
                        </ItemTemplate>
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="SHORT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SHORT_QTY column" HeaderText="SHORTAGE QTY" AllowFiltering="false" SortExpression="SHORT_QTY" UniqueName="SHORT_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="SHORT_QTYTextBox" runat="server" Text='<%# Bind("SHORT_QTY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="SHORT_QTYLabel" runat="server" Text='<%# Eval("SHORT_QTY") %>' onkeydown="return (event.keyCode!=13);" Width="80px"></telerik:RadTextBox>
                        </ItemTemplate>
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="DAMAGE_QTY" DataType="System.Decimal" FilterControlAltText="Filter DAMAGE_QTY column" HeaderText="DAMAGE QTY" AllowFiltering="false" SortExpression="DAMAGE_QTY" UniqueName="DAMAGE_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="DAMAGE_QTYTextBox" runat="server" Text='<%# Bind("DAMAGE_QTY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="DAMAGE_QTYLabel" runat="server" Text='<%# Eval("DAMAGE_QTY") %>' onkeydown="return (event.keyCode!=13);" Width="80px"></telerik:RadTextBox>
                        </ItemTemplate>
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="BAL_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="BAL TO RECEIVE QTY" AllowFiltering="false" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                        <EditItemTemplate>
                            <asp:TextBox ID="BAL_QTYTextBox" runat="server" Text='<%# Bind("BAL_QTY") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <telerik:RadTextBox ID="BAL_QTYLabel" runat="server" Text='<%# Eval("BAL_QTY") %>' onkeydown="return (event.keyCode!=13);" Width="80px" ></telerik:RadTextBox>
                        </ItemTemplate>
                         <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlGridSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT * FROM view_mat_transfer_rcv_bal
           WHERE    TRANSF_ID IN  
            (SELECT TRANSF_ID FROM PIP_MAT_TRANSFER_RCV,PIP_MAT_TRANSFER_RCV_DT
             WHERE PIP_MAT_TRANSFER_RCV.RCV_ID =  PIP_MAT_TRANSFER_RCV_DT.RCV_ID(+)
             AND PIP_MAT_TRANSFER_RCV.RCV_ID = :RCV_ID 
            ) AND bal_qty &gt; 0
        ORDER BY   MR_ITEM_NO">
        <SelectParameters>
            <asp:QueryStringParameter Name="RCV_ID" DefaultValue="-1" QueryStringField="RCV_ID" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="HeatNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DrumNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"></asp:SqlDataSource>
</asp:Content>

