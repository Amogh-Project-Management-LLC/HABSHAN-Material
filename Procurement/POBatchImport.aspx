<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POBatchImport.aspx.cs" Inherits="Procurement_POBatchImport" %>

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
    <div style="background-color: whitesmoke">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px"  OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Save" Width="100px" OnClick="btnAdd_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png"   />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsSource" PageSize="50" AllowPaging="true" PagerStyle-AlwaysVisible="true" onkeypress="handleSpace(event)">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsSource" AllowFilteringByColumn="true" PageSize="50">
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="20,50,100,500,1000,2000,4000"/>
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="checkCol"  AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="checkItems" runat="server" Checked="true" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkHeaderItems" runat="server" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="checkHeaderItems_CheckedChanged" />
                        </HeaderTemplate>
                         <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />                
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO_ITEM_NO" SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO"  AutoPostBackOnFilter="true">
                     <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true">
                     <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT_DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true">
                         <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO_QTY" SortExpression="PO_QTY" UniqueName="PO_QTY" AllowFiltering="false">
                         <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BATCH_QTY" DataType="System.Decimal" FilterControlAltText="Filter BATCH_QTY column" HeaderText="BATCH QTY" SortExpression="BATCH_QTY" UniqueName="BATCH_QTY" AllowFiltering="false">
                         <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="BAL_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="REMAIN BATCH QTY" SortExpression="BAL_QTY" UniqueName="BAL_QTY" AllowFiltering="false">
                         <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_QTYTextBox" runat="server" Text='<%# Bind("BAL_QTY") %>' Width="50px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_PO_BATCH_BAL
WHERE po_id IN (SELECT po_id FROM PIP_PO_BATCH_PLAN WHERE BATCH_ID = :BATCH_ID) AND BAL_QTY &gt; 0">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="BATCH_ID" QueryStringField="BATCH_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

