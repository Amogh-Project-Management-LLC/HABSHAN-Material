<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatInspDetailImport.aspx.cs" Inherits="Material_MatInspImport" %>

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
            var divFooter = document.getElementById("footerDiv").clientHeight         
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            grid.get_element().style.width = width - 15 + "px";
            
            grid.repaint();
       }    
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
    </script>

    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click"></telerik:RadButton>

    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlGridSource" AllowMultiRowSelection="true"
            AllowPaging="true" AllowSorting="true" AllowFilteringByColumn="true" onkeypress="handleSpace(event)"   PagerStyle-AlwaysVisible="true" PageSize="50" OnItemDataBound="itemsGrid_ItemDataBound">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Resizing AllowColumnResize="true"  AllowRowResize="false" ResizeGridOnColumnResize="false"
                    ClipCellContentOnResize="true" EnableRealTimeResize="false" AllowResizeToFit="true"/>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlGridSource" TableLayout="Fixed" >
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="checkCol" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="checkItems" runat="server" Checked="true" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkHeaderItems" runat="server" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="checkHeaderItems_CheckedChanged" />
                        </HeaderTemplate>
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" SortExpression="PO_ITEM" UniqueName="PO_ITEM" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="100px"/>
                        <HeaderStyle Width="100px"/>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                        <ItemStyle Width="150px"/>
                        <HeaderStyle Width="150px"/>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="150px">
                        <ItemStyle Width="450px"/>
                        <HeaderStyle Width="450px"/>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" FilterControlWidth="80px">
                        <ItemStyle Width="120px"/>
                        <HeaderStyle Width="120px"/>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" SortExpression="UOM_NAME" UniqueName="UOM_NAME" AllowFiltering="false">
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_QTY" FilterControlAltText="Filter INSP_QTY column" HeaderText="RFI QTY" AllowFiltering="false" AutoPostBackOnFilter="true" SortExpression="INSP_QTY" UniqueName="INSP_QTY" >
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRIR_QTY" FilterControlAltText="Filter MRIR_QTY column" HeaderText="MRIR QTY" AllowFiltering="false" AutoPostBackOnFilter="true" SortExpression="MRIR_QTY" UniqueName="MRIR_QTY">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BAL_MRIR_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_MRIR_QTY column" HeaderText="BAL MRIR QTY" SortExpression="BAL_MRIR_QTY" UniqueName="BAL_MRIR_QTY" AllowFiltering="false" FilterControlWidth="50" ItemStyle-Width="50">
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_MRIR_QTYTextBox" runat="server" Text='<%# Bind("BAL_MRIR_QTY") %>' Width="70px"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="AS PER PL QTY" UniqueName="PL_QTY" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPLQty" runat="server" Width="50px" Text='<%# Bind("BAL_MRIR_QTY") %>' ></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>

                     <telerik:GridBoundColumn DataField="PIECES" FilterControlAltText="Filter PIECES column" HeaderText="PIECES" AllowFiltering="false" AutoPostBackOnFilter="true" SortExpression="PIECES" UniqueName="PIECES">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="BAL_PIECES" DataType="System.Decimal" FilterControlAltText="Filter BAL_PIECES column" HeaderText="BAL PIECES" SortExpression="BAL_PIECES" UniqueName="BAL_PIECES" AllowFiltering="false" FilterControlWidth="50" ItemStyle-Width="50">
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_PIECESTextBox" runat="server" Text='<%# Bind("BAL_PIECES") %>' Width="70px"></asp:TextBox>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn HeaderText="SUBSTORE" UniqueName="SUBSTORE" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlsubstore" runat="server" Width="180px" 
                                DataSourceID="SubStoreDataSource" DataTextField="STORE_L1" DataValueField="SUBSTORE_ID"></telerik:RadDropDownList>
                        </ItemTemplate>
                          <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
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
                    <%-- <telerik:GridTemplateColumn DataField="HEAT_NO" UniqueName="HEAT_NO" HeaderText="HEAT NO" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="ddlHeatNo" runat="server" DataTextField="Heat_no" DataValueField="Heat_no"
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                        </ItemTemplate>

                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                   --%>
                   <%-- <telerik:GridTemplateColumn HeaderText="CABLE DRUM NO" UniqueName="CABLE_DRUM_NO" AllowFiltering="false">
                        <ItemTemplate>
                            <telerik:RadDropDownList ID="txtCableDrumNo" runat="server" Width="150px" 
                                DataSourceID="SqlDataSource1" DataTextField="CABLE_DRUM_NO" DataValueField="CABLE_DRUM_NO"></telerik:RadDropDownList>
                        </ItemTemplate>
                          <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn HeaderText="HEAT NO" UniqueName="HEAT_NO" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtHeatNo" runat="server" Width="150px"></asp:TextBox>
                        </ItemTemplate>
                         <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="MTC NO" UniqueName="MTC_NO" AllowFiltering="false" >
                        <ItemTemplate>
                            <asp:TextBox ID="txtMTCNo" runat="server" Width="150px" Text="NA"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                   
                    <telerik:GridTemplateColumn HeaderText="PAINT_SYS" UniqueName="PAINT_SYS" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtPaintSys" runat="server" Width="100px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn HeaderText="UNIT WEIGHT" UniqueName="UNIT_WT" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtUnitWt" runat="server" Width="50px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                   
                    <telerik:GridTemplateColumn HeaderText="SUB WAREHOUSE" UniqueName="SUB_WAREHOUSE" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtSubWarehouse" runat="server" Width="100px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="LINE NO" UniqueName="LINE_NO" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtLineNo" runat="server" Width="100px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="RACK NO" UniqueName="RACK_NO" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtRackNo" runat="server" Width="100px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="SHELF NO" UniqueName="SHELF_NO" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtShelfNo" runat="server" Width="100px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn HeaderText="EXCESS" UniqueName="EXCESS" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtExcess" runat="server" Width="50px" Text="0"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="SHORTAGE" UniqueName="SHORTAGE" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtShortage" runat="server" Width="50px" Text="0"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn HeaderText="DAMAGE" UniqueName="DAMAGE" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtDamage" runat="server" Width="50px" Text="0"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>
                   <telerik:GridTemplateColumn HeaderText="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:TextBox ID="txtRemarks" runat="server" Width="150px"></asp:TextBox>
                        </ItemTemplate>
                          <ItemStyle Width="170px" />
                        <HeaderStyle Width="170px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_ID" FilterControlAltText="Filter MAT_ID column" HeaderText="MAT_ID" SortExpression="MAT_ID" UniqueName="MAT_ID" AllowFiltering="false">
                        <ItemStyle Width="1px" />
                        <HeaderStyle Width="1px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlGridSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT RFI_ID, PO_ITEM, MAT_ID, MAT_CODE1, ITEM_NAM, UOM_NAME,
                        MAT_DESCR, INSP_QTY, MRIR_QTY, BAL_MRIR_QTY,PIECES,BAL_PIECES
                        FROM VIEW_MRIR_BAL_FROM_RFI 
                        WHERE RFI_ID IN (SELECT RFI_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID)
                        ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MIR_ID" QueryStringField="MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SubStoreDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT STORE_L1,SUBSTORE_ID FROM STORES_SUB
                        WHERE STORE_ID IN (SELECT STORE_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID)
                        ORDER BY STORE_L1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MIR_ID" QueryStringField="MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT PIP_MAT_RECEIVE_DETAIL.CABLE_DRUM_NO FROM PIP_MAT_RECEIVE_DETAIL,PIP_MAT_INSP_REQUEST_DT
WHERE PIP_MAT_RECEIVE_DETAIL.RCV_ITEM_ID = PIP_MAT_INSP_REQUEST_DT.RCV_ITEM_ID
AND  REQ_ID IN (SELECT RFI_ID FROM PRC_MAT_INSP WHERE MIR_ID = :MIR_ID)
ORDER BY CABLE_DRUM_NO">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MIR_ID" QueryStringField="MIR_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="HeatNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" >
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DrumNoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" 
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" >
    </asp:SqlDataSource>
</asp:Content>

