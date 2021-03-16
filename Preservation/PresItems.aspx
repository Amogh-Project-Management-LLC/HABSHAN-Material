<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PresItems.aspx.cs" Inherits="PreservationItems" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
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
            grid.get_element().style.width = width+ "px";           
            grid.repaint();
        }
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
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="110" OnClick="btnBack_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnImportFromMR" runat="server" Text="Import From MRIR" Width="150" OnClick="btnImportFromMR_Click"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div>
                    
        <telerik:RadGrid ID="ItemsGrid" runat="server" AllowPaging="True" DataSourceID="ObjSrcPreservItems" CellSpacing="-1" GridLines="None" OnDataBinding="gridPreservItems_DataBinding"
            AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" PageSize="50" AllowSorting="true"  onkeypress="handleSpace(event)"  OnItemCommand="gridPreservItems_ItemCommand"  PagerStyle-AlwaysVisible="true" >
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
              <HeaderStyle HorizontalAlign="Center"  />             
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling UseStaticHeaders="true" AllowScroll="true" FrozenColumnsCount="6" SaveScrollPosition="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="ObjSrcPreservItems" PageSize="50" DataKeyNames="PRESERV_ITEM_ID"  AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                AllowFilteringByColumn="true" EditMode="InPlace" AllowMultiColumnSorting="true"  TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridClientDeleteColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmTitle="Confirm Delete"
                        ImageUrl="../Images/icon-cancel.gif"
                        ConfirmDialogWidth="400px">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridClientDeleteColumn>

                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1"
                        UniqueName="MAT_CODE1" AllowFiltering="true" ReadOnly="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                   
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MATERIAL DESCRIPTION"
                        SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AllowFiltering="true" ReadOnly="true" FilterControlWidth="100px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE"
                        SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" AutoPostBackOnFilter="true"
                        SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AllowFiltering="true" ReadOnly="true" FilterControlWidth="100px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT"
                        SortExpression="UOM_NAME" UniqueName="UOM_NAME" AllowFiltering="false" ReadOnly="true" >
                        <ItemStyle Width="50px" />
                        <HeaderStyle Width="50px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="PRESERV_QTY" FilterControlAltText="Filter PRESERV_QTY column" HeaderText="PRESERVATION QTY"
                        SortExpression="PRESERV_QTY" UniqueName="PRESERV_QTY" AllowFiltering="true" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRESERV_FREQUENCY" FilterControlAltText="Filter PRESERV_FREQUENCY column" HeaderText="PRESERV FREQUENCY"
                        AutoPostBackOnFilter="true" SortExpression="PRESERV_FREQUENCY" UniqueName="PRESERV_FREQUENCY" AllowFiltering="true" 
                        FilterControlWidth="60px" ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="SUB STORE" AutoPostBackOnFilter="true"
                        SortExpression="STORE_NAME" UniqueName="STORE_NAME" AllowFiltering="true" FilterControlWidth="50px" ReadOnly="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"  
                        SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false" >
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                   
                   
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="ObjSrcPreservItems" runat="server" DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPreservationTableAdapters.VIEW_PRESERVATION_MAT_DETAILTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="Original_PRESERV_ITEM_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:QueryStringParameter DefaultValue="-1" Name="PRESERV_ID" QueryStringField="PRESERV_ID" Type="Decimal" />
        </SelectParameters>
         <UpdateParameters>
            <asp:Parameter Name="PRESERV_QTY" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="Original_PRESERV_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

