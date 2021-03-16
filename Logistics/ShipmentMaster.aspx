<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ShipmentMaster.aspx.cs" Inherits="Logistics_ShipmentMaster" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
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
 
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnAdd" Text="New Ship" Width="120px"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnDetail" Text="Ship Detail" Width="120px" OnClick="btnDetail_Click"></telerik:RadButton>
    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" onkeypress="handleSpace(event)"
            AllowPaging="true" PageSize="50" Height="330px" AllowFilteringByColumn="true" AllowSorting="true">
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="SHIP_ID" AllowMultiColumnSorting="true"
                 TableLayout="Fixed">
                <Columns>
                    <telerik:GridBoundColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP NO" 
                        SortExpression="SHIP_NO" UniqueName="SHIP_NO" FilterControlWidth="50px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_CR_DT" DataType="System.DateTime" FilterControlAltText="Filter SHIP_CR_DT column"
                        HeaderText="CREATE DATE" SortExpression="SHIP_CR_DT" UniqueName="SHIP_CR_DT" DataFormatString="{0:dd-MMM-yyyy}"  
                        FilterControlWidth="60px">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_REF_NO" FilterControlAltText="Filter SHIP_REF_NO column" HeaderText="SHIP REF NO" 
                        SortExpression="SHIP_REF_NO" UniqueName="SHIP_REF_NO" FilterControlWidth="80px">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_DOC_REF_NO" FilterControlAltText="Filter SHIP_DOC_REF_NO column" 
                        HeaderText="DOCUMENT NO" SortExpression="SHIP_DOC_REF_NO" UniqueName="SHIP_DOC_REF_NO"  FilterControlWidth="80px">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FROM_PORT_CODE" FilterControlAltText="Filter FROM_PORT_CODE column" HeaderText="FROM PORT" 
                        SortExpression="FROM_PORT_CODE" UniqueName="FROM_PORT_CODE" FilterControlWidth="80px">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TO_PORT_CODE" FilterControlAltText="Filter TO_PORT_CODE column" HeaderText="TO PORT" 
                        SortExpression="TO_PORT_CODE" UniqueName="TO_PORT_CODE"  FilterControlWidth="80px">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANSP_TYPE" FilterControlAltText="Filter TRANSP_TYPE column" HeaderText="TRANSP TYPE" 
                        SortExpression="TRANSP_TYPE" UniqueName="TRANSP_TYPE"  FilterControlWidth="80px">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_REMARKS" FilterControlAltText="Filter SHIP_REMARKS column" HeaderText="SHIP REMARKS" 
                        SortExpression="SHIP_REMARKS" UniqueName="SHIP_REMARKS"  FilterControlWidth="100px">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CARGO_TYPE_DESC" FilterControlAltText="Filter CARGO_TYPE_DESC column" 
                        HeaderText="CARGO TYPE" SortExpression="CARGO_TYPE_DESC" UniqueName="CARGO_TYPE_DESC"  FilterControlWidth="80px">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsLogistics_ATableAdapters.VIEW_PRC_SHIP_MASTERTableAdapter">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

