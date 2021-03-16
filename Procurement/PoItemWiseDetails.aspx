<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PoItemWiseDetails.aspx.cs" Inherits="PoItemWise" Title="PO Details" EnableSessionState="ReadOnly" %>
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
            grid.get_element().style.height = (height) - divHeight - 60 + "px"
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }
</script>

 
    
    <div id="raddiv" style="display: inline-block;">
        <telerik:RadGrid ID="itemsGrid" ShowStatusBar="true" DataSourceID="PoGridDataSource" runat="server" PagerStyle-AlwaysVisible="true" 
            AutoGenerateColumns="False" PageSize="50" AllowSorting="True" AllowMultiRowSelection="False" AllowPaging="True"  OnPreRender="itemsGrid_PreRender"
            OnItemCommand="itemsGrid_ItemCommand" OnItemCreated="itemsGrid_ItemCreated" OnDataBound="itemsGrid_DataBound" EnableHeaderContextMenu="true"
        EnableHeaderContextFilterMenu="true" RetainExpandStateOnRebind="true" >
            <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />

            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
            </ClientSettings>
            <MasterTableView Name="PoGrid" CommandItemDisplay="Top"    EnableHierarchyExpandAll="true" DataSourceID="PoGridDataSource" DataKeyNames="PO_NO,PO_ITEM" AllowMultiColumnSorting="True"
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed" AllowFilteringByColumn="true" RowIndicatorColumn-Display="false" ExpandCollapseColumn-Display="true"
                HierarchyLoadMode="ServerBind">
                <CommandItemSettings ShowExportToExcelButton="true"  ShowRefreshButton="false" ShowAddNewRecordButton="false"></CommandItemSettings>

                <DetailTables>
                    <telerik:GridTableView Name="BatchGrid"  HierarchyDefaultExpanded="true" EnableHierarchyExpandAll="true" AllowFilteringByColumn="true" DataKeyNames="BATCH_NO" 
                        DataSourceID="BatchDataSource" runat="server" AllowPaging="true"  Width="55%" PageSize="5" HierarchyLoadMode="ServerBind" >
                         <ItemStyle BackColor="#ccffcc" />
                        <AlternatingItemStyle BackColor="#ccffcc" />
                        <ParentTableRelation>
                            <telerik:GridRelationFields DetailKeyField="PO_NO" MasterKeyField="PO_NO"></telerik:GridRelationFields>
                            <telerik:GridRelationFields DetailKeyField="PO_ITEM" MasterKeyField="PO_ITEM"></telerik:GridRelationFields>
                        </ParentTableRelation>
                      
                        <Columns>
                        <telerik:GridBoundColumn DataField="BATCH_NO" FilterControlAltText="Filter BATCH_NO column" AutoPostBackOnFilter="true" 
                                HeaderText="BATCH NO" SortExpression="BATCH_NO" UniqueName="BATCH_NO">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="BATCH_REV" FilterControlAltText="Filter BATCH_REV column" HeaderText="BATCH REV"
                                AutoPostBackOnFilter="true" SortExpression="BATCH_REV" UniqueName="BATCH_REV">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="BATCH_QTY" FilterControlAltText="Filter BATCH_QTY column" HeaderText="BATCH QTY"
                                AutoPostBackOnFilter="true" SortExpression="BATCH_QTY" UniqueName="BATCH_QTY">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DELIVERY_FORECAST" FilterControlAltText="Filter DELIVERY_FORECAST column" HeaderText="DELIVERY FORECAST"
                                AutoPostBackOnFilter="true" SortExpression="DELIVERY_FORECAST" UniqueName="DELIVERY_FORECAST">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                        </Columns>

                    </telerik:GridTableView>
                </DetailTables>
                <Columns>
                  <telerik:GridBoundColumn DataField="DISCIPLINE" UniqueName="DISCIPLINE" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE" FilterControlWidth="80px" AutoPostBackOnFilter="true" >
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="PO_NO" UniqueName="PO_NO" HeaderText="PO NO" SortExpression="PO_NO" FilterControlWidth="120px" AutoPostBackOnFilter="true" >
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" UniqueName="PO_ITEM" HeaderText="PO ITEM" SortExpression="PO_ITEM" FilterControlWidth="40px" AutoPostBackOnFilter="true" >
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" UniqueName="MAT_CODE1" HeaderText="MAT CODE1" SortExpression="MAT_CODE1" FilterControlWidth="80px" AutoPostBackOnFilter="true" >
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" UniqueName="MAT_DESCR" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" FilterControlWidth="120px" AutoPostBackOnFilter="true" >
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" UniqueName="ITEM_NAM" HeaderText="ITEM_NAM" SortExpression="ITEM_NAM" FilterControlWidth="100px" AutoPostBackOnFilter="true" >
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE"
                        SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" FilterControlAltText="Filter WALL_THK column" HeaderText="THK"
                        SortExpression="WALL_THK" UniqueName="WALL_THK" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UNIT" FilterControlAltText="Filter UNIT column" HeaderText="UNIT" 
                        SortExpression="UNIT" UniqueName="UNIT" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" UniqueName="PO_QTY" HeaderText="PO QTY" SortExpression="PO_QTY" 
                        FilterControlAltText="Filter PO_QTY column" FilterControlWidth="60px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MS2_QTY" UniqueName="MS2_QTY" HeaderText="MS2 QTY" SortExpression="MS2_QTY"
                        FilterControlAltText="Filter MS2_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V1_QTY" UniqueName="V1_QTY" HeaderText="V1 QTY" SortExpression="V1_QTY"
                        FilterControlAltText="Filter V1_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V2_QTY" UniqueName="V2_QTY" HeaderText="V2 QTY" SortExpression="V2_QTY"
                        FilterControlAltText="Filter V2_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V3_QTY" UniqueName="V3_QTY" HeaderText="V3 QTY" SortExpression="V3_QTY"
                        FilterControlAltText="Filter V3_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V4_QTY" UniqueName="V4_QTY" HeaderText="V4 QTY" SortExpression="V4_QTY"
                        FilterControlAltText="Filter V4_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V5_QTY" UniqueName="V5_QTY" HeaderText="V5 QTY" SortExpression="V5_QTY"
                        FilterControlAltText="Filter V5_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V6_QTY" UniqueName="V6_QTY" HeaderText="V6 QTY" SortExpression="V6_QTY"
                        FilterControlAltText="Filter V6_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="V7_QTY" UniqueName="V7_QTY" HeaderText="V7 QTY" SortExpression="V7_QTY"
                        FilterControlAltText="Filter V7_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BATCH_QTY" UniqueName="BATCH_QTY" HeaderText="BATCH QTY" SortExpression="BATCH_QTY"
                        FilterControlAltText="Filter BATCH_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="IRN_QTY" UniqueName="IRN_QTY" HeaderText="IRN QTY" SortExpression="IRN_QTY"
                        FilterControlAltText="Filter IRN_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRR_QTY" UniqueName="MRR_QTY" HeaderText="MRR QTY" SortExpression="MRR_QTY"
                        FilterControlAltText="Filter MRR_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRIR_QTY" UniqueName="MRIR_QTY" HeaderText="MRIR QTY" SortExpression="MRIR_QTY"
                        FilterControlAltText="Filter MRIR_QTY column" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                </Columns>

            </MasterTableView>
            <ExportSettings ExportOnlyData="true" IgnorePaging="true" HideStructureColumns="true" OpenInNewWindow="true">
                <Excel Format="Html"></Excel>
            </ExportSettings>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <div style="height: 110px; width: 92%">
        <asp:RadioButtonList ID="RadioButtonList1" runat="server">
            <asp:ListItem Text="Export all items" Value="All"></asp:ListItem>
            <asp:ListItem Text="Export expanded items only" Value="Expanded"  Selected="True"></asp:ListItem>
            <asp:ListItem Text="Collapse all items before export" Value="Collapsed"></asp:ListItem>
        </asp:RadioButtonList>

        <asp:CheckBox ID="CheckBox1" runat="server" Text="Enable colouring when exporting"
            Checked="true"></asp:CheckBox>

    </div>

  <asp:SqlDataSource ID="PoGridDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" DataSourceMode="DataReader" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT    DISCIPLINE, PO_NO, PO_ITEM, MAT_CODE1, MAT_DESCR, ITEM_NAM, SIZE_DESC, WALL_THK, UNIT,
                                 PO_QTY, V1_QTY,V2_QTY, V3_QTY, V4_QTY, V5_QTY, V6_QTY, V7_QTY,BATCH_QTY, 
                                 SPLIT_BATCH_QTY, IRN_QTY, MRR_QTY, MRIR_QTY,MS2_QTY
                     FROM VIEW_PO_REPORT_MAIN"></asp:SqlDataSource>
    <asp:SqlDataSource ID="BatchDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" DataSourceMode="DataReader" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT   PO_NO,PO_ITEM_NO ,BATCH_NO,BATCH_REV,BATCH_QTY, DELIVERY_FORECAST
                                FROM VIEW_PO_BATCH_PLAN_DETAIL
                       WHERE PO_NO = :PO_NO AND PO_ITEM_NO = :PO_ITEM">
        <SelectParameters>
            <asp:SessionParameter Name="PO_NO" SessionField="PO_NO" Type="String" />
            <asp:SessionParameter Name="PO_ITEM" SessionField="PO_ITEM" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
   
</asp:Content>
