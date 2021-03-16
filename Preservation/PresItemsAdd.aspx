<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PresItemsAdd.aspx.cs" Inherits="PreservationItemsAdd" %>

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
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 70 + "px";
            grid.get_element().style.width = width-15 + "px";           
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnSave" runat="server" Text="Save" Width="100px" OnClick="btnSave_Click"></telerik:RadButton>

    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="sqlGridSource" AllowMultiRowSelection="true" 
            AllowFilteringByColumn="true" AllowPaging="true" PageSize="50" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlGridSource" PageSize="50" PagerStyle-AlwaysVisible="true">
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridClientSelectColumn UniqueName="ClientSelect">
                          <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridClientSelectColumn>   
                     <telerik:GridBoundColumn DataField="MIR_ITEM_ID" DataType="System.Decimal" FilterControlAltText="Filter MIR_ITEM_ID column" HeaderText="MIR ITEM ID" SortExpression="MIR_ITEM_ID" UniqueName="MIR_ITEM_ID" AllowFiltering="false">
                           <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridBoundColumn>
         
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" FilterControlWidth="60px" AutoPostBackOnFilter="true">
                          <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true">
                           <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AutoPostBackOnFilter="true">
                          <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" SortExpression="UOM_NAME" UniqueName="UOM_NAME" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                          <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACPT_QTY" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="MRIR QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY" AllowFiltering="false">
                          <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRESV_QTY" DataType="System.Decimal" FilterControlAltText="Filter PRESV_QTY column" HeaderText="PRESVATION QTY" SortExpression="PRESV_QTY" UniqueName="PRESV_QTY" AllowFiltering="false">
                          <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
         
                    <telerik:GridTemplateColumn DataField="BAL_TO_PRESERV" DataType="System.Decimal" FilterControlAltText="Filter BAL_TO_PRESERV column" HeaderText="BAL LEFT TO PRESERVE" SortExpression="BAL_TO_PRESERV" UniqueName="BAL_TO_PRESERV" AllowFiltering="false">
                          <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                        <EditItemTemplate>
                            <asp:TextBox ID="BAL_TO_PRESERVTextBox" runat="server" Text='<%# Bind("BAL_TO_PRESERV") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            
                            <telerik:RadTextBox ID="BAL_TO_PRESERVLabel" runat="server" Text='<%# Eval("BAL_TO_PRESERV") %>' Width="80px"></telerik:RadTextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
             <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlGridSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand="SELECT * FROM VIEW_MRIR_PRESERV_BAL
                        WHERE MIR_ID IN (SELECT MIR_ID FROM PRES_MAT WHERE PRESERV_ID = :PRESERV_ID)
                        ORDER BY MAT_CODE1">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="PRESERV_ID" QueryStringField="PRESERV_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

