<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PresDetail.aspx.cs" Inherits="Preservation_PresDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= ItemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth           
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight           
            var divFooter = document.getElementById("footerDiv").clientHeight           
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 70 + "px";
            grid.get_element().style.width = width-15 + "px";           
            grid.repaint();
        }   
            function handleSpace(event)
            {
                var keyPressed = event.which || event.keyCode;
                if (keyPressed == 13)
                {
                    event.preventDefault();
                    event.stopPropagation();
                }
            }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnAdd" runat="server" Text="Add Report" Width="100px"></telerik:RadButton>
       <%-- <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="100px"></telerik:RadButton>--%>
        <telerik:RadButton ID="btnItems" runat="server" Text="Items" Width="100px" OnClick="btnItems_Click"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="ItemsGrid" runat="server" DataSourceID="itemsDataSource" PagerStyle-AlwaysVisible="true" AllowSorting="true"
            CellSpacing="-1" AllowPaging="True" PageSize="50"  onkeypress="handleSpace(event)"  OnItemCommand="ItemsGrid_ItemCommand" OnDataBinding="ItemsGrid_DataBinding">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" AllowMultiColumnSorting="true"
                DataKeyNames="PRESERV_ID" TableLayout="Fixed" PagerStyle-AlwaysVisible="true" AllowFilteringByColumn="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
              <%--  <CommandItemSettings ExportToPdfText="Export to PDF" />--%>
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                    <HeaderStyle Width="20px" />
                     <ItemStyle Width="20px" />
                </RowIndicatorColumn>
                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                    <HeaderStyle Width="20px" />
                     <ItemStyle Width="20px" />
                </ExpandCollapseColumn>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="PRESERV_NO" ReadOnly="true" FilterControlAltText="Filter PRESERV_NO column" HeaderText="PRESERVATION NO" SortExpression="PRESERV_NO"
                     AutoPostBackOnFilter="true"   UniqueName="STORE_NAME" FilterControlWidth="200px">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRESERV_CODE" ReadOnly="true" FilterControlAltText="Filter PRESERV_CODE column" HeaderText="PRESERVATION CODE" SortExpression="PRESERV_CODE" UniqueName="PRESERV_CODE" FilterControlWidth="150px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_BY" ReadOnly="true" FilterControlAltText="Filter INSP_BY column" HeaderText="INSPECTION BY" SortExpression="INSP_BY" UniqueName="INSP_BY" AllowFiltering="false">
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRESERV_REP_NO" ReadOnly="true"  FilterControlAltText="Filter PRESERV_REP_NO column" HeaderText="PRESERVATION REPORT NO" SortExpression="PRESERV_REP_NO" UniqueName="PRESERV_REP_NO" FilterControlWidth="140px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="PRESERV_DATE" DataType="System.DateTime" FilterControlAltText="Filter PRESERV_DATE column" HeaderText="PRESERVATION DATE" SortExpression="PRESERV_DATE" UniqueName="PRESERV_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" SelectedDate='<%# Bind("PRESERV_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="PRESERV_DATELabel" runat="server" Text='<%# Eval("PRESERV_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" ReadOnly="true" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" AllowFiltering="false">
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="PO_NO" ReadOnly="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                         SortExpression="PO_NO" UniqueName="PO_NO" AllowFiltering="true" FilterControlWidth="60px">
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MIR_NO" FilterControlAltText="Filter MIR_NO column" HeaderText="MRIR NO" SortExpression="MIR_NO" UniqueName="MIR_NO" FilterControlWidth="200px" AutoPostBackOnFilter="true" ReadOnly="true">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="CREATED BY" SortExpression="USER_NAME" UniqueName="USER_NAME" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CREATE_DATE" FilterControlAltText="Filter CREATE_DATE column"  DataFormatString="{0:dd-MMM-yyyy}" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" AllowFiltering="false"  ReadOnly="true" >
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" FilterControlWidth="120px" AutoPostBackOnFilter="true">
                         <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                </Columns>           
            </MasterTableView> 
             <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPreservationTableAdapters.VIEW_PRES_MASTERTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_PRES_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
        <UpdateParameters>
            
            <asp:Parameter Name="PRESERV_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_PRESERV_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

