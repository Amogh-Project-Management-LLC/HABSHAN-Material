<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POIRNItemAdd.aspx.cs" Inherits="Procurement_POInspDetailAdd" %>

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
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divFooterButton - divButton - divFooter - 150 + "px";
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
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="100px" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png"  />
        </telerik:RadButton>
        <telerik:RadButton ID="btnAdd" runat="server" Text="Save" Width="100px" OnClick="btnAdd_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/document-save.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsSource" AllowPaging="true" PageSize="50" onkeypress="handleSpace(event)">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsSource" AllowFilteringByColumn="true" AllowMultiColumnSorting="true">
                <Columns>
                    <telerik:GridTemplateColumn UniqueName="checkCol" ItemStyle-Width="20px" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:CheckBox ID="checkItems" runat="server" Checked="true" />
                        </ItemTemplate>
                        <HeaderTemplate>
                            <asp:CheckBox ID="checkHeaderItems" runat="server" Checked="true" AutoPostBack="true"
                                OnCheckedChanged="checkHeaderItems_CheckedChanged" />
                        </HeaderTemplate>


                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM_NO" FilterControlAltText="Filter PO_ITEM_NO column" HeaderText="PO ITEM NO" SortExpression="PO_ITEM_NO" UniqueName="PO_ITEM_NO" AutoPostBackOnFilter="true" ItemStyle-Width="20px" FilterControlWidth="40px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" ItemStyle-Width="50px" FilterControlWidth="80px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OLD_MAT_CODE" FilterControlAltText="Filter OLD_MAT_CODE column" HeaderText="OLD MATERIAL CODE" SortExpression="OLD_MAT_CODE" UniqueName="OLD_MAT_CODE" AutoPostBackOnFilter="true" ItemStyle-Width="50px" FilterControlWidth="80px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCR" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" ItemStyle-Width="250px" FilterControlWidth="250px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" SortExpression="UOM_NAME" UniqueName="UOM_NAME" AutoPostBackOnFilter="true" ItemStyle-Width="50px" FilterControlWidth="20px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO QTY" SortExpression="PO_QTY" UniqueName="PO_QTY" AutoPostBackOnFilter="true" ItemStyle-Width="20px" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REL_QTY" DataType="System.Decimal" FilterControlAltText="Filter REL_QTY column" HeaderText="RELEASED QTY" SortExpression="REL_QTY" UniqueName="REL_QTY" AutoPostBackOnFilter="true" ItemStyle-Width="20px" FilterControlWidth="40px">
                    </telerik:GridBoundColumn>


                    <telerik:GridTemplateColumn DataField="BAL_REL_QTY" DataType="System.Decimal" FilterControlAltText="Filter BAL_REL_QTY column" HeaderText="REMAIN RELEASE QTY" SortExpression="BAL_REL_QTY" UniqueName="BAL_REL_QTY" ItemStyle-Width="30px" FilterControlWidth="50px">
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_REL_QTYTextBox" runat="server" Text='<%# Bind("BAL_REL_QTY") %>' Width="80px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                     <telerik:GridTemplateColumn DataField="BAL_PIECES" DataType="System.Decimal" FilterControlAltText="Filter BAL_PIECES column" HeaderText="REMAIN BAL PIECES" SortExpression="BAL_PIECES" UniqueName="BAL_PIECES" ItemStyle-Width="30px" FilterControlWidth="50px">
                        <ItemTemplate>
                            <asp:TextBox ID="BAL_PIECESTextBox" runat="server" Text='<%# Bind("BAL_PIECES") %>' Width="80px"></asp:TextBox>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="itemsSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_PO_IRN_BAL
WHERE po_id IN (SELECT po_id FROM PIP_PO_IRN WHERE IRN_ID = :IRN_ID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="IRN_ID" QueryStringField="IRN_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

