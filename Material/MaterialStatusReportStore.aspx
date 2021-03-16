<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStatusReportStore.aspx.cs" Inherits="Material_MaterialStatusReportStore" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = (width-20) + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnDownload" runat="server" Text="Download" Width="100px" OnClick="btnDownload_Click"></telerik:RadButton>
    </div>
    <div style="margin-top: 5px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"
            AllowPaging="True" PageSize="50" AllowFilteringByColumn="True" AllowSorting="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" CaseSensitive="false"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="MAT_ID" AllowMultiColumnSorting="true" TableLayout="Fixed">
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>
                    <telerik:GridBoundColumn DataField="STORE_NAME" FilterControlWidth="80px" AutoPostBackOnFilter="true" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DISCIPLINE" FilterControlWidth="80px" AutoPostBackOnFilter="true" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE" UniqueName="DISCIPLINE">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER" SortExpression="PO_NO" UniqueName="PO_NO">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAME" AutoPostBackOnFilter="true" FilterControlAltText="Filter ITEM_NAME column" HeaderText="ITEM NAME" SortExpression="ITEM_NAME" UniqueName="ITEM_NAME" FilterControlWidth="60px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUB_WAREHOUSE" AutoPostBackOnFilter="true" FilterControlAltText="Filter SUB_WAREHOUSE column" HeaderText="SUB WAREHOUSE" SortExpression="SUB_WAREHOUSE" UniqueName="SUB_WAREHOUSE" FilterControlWidth="70px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RACK_NO" AutoPostBackOnFilter="true" FilterControlAltText="Filter RACK_NO column" HeaderText="RACK NO" SortExpression="RACK_NO" UniqueName="RACK_NO" FilterControlWidth="40px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LINE_NO" AutoPostBackOnFilter="true" FilterControlAltText="Filter LINE_NO column" HeaderText="LINE NO" SortExpression="LINE_NO" UniqueName="LINE_NO" FilterControlWidth="40px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHELF_NO" AutoPostBackOnFilter="true" FilterControlAltText="Filter SHELF_NO column" HeaderText="SHELF NO" SortExpression="SHELF_NO" UniqueName="SHELF_NO" FilterControlWidth="40px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" AllowFiltering="true" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE DESC" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" FilterControlWidth="30px">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCVD_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter RCVD_QTY column" HeaderText="RECEIVE QTY" SortExpression="RCVD_QTY" UniqueName="RCVD_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACPT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACCEPT QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="SD_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter SD_QTY column" HeaderText="SD QTY" SortExpression="SD_QTY" UniqueName="SD_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                   <%-- <telerik:GridBoundColumn DataField="TRANSF_IN_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_IN_QTY column" HeaderText="TRANSFER IN QTY" SortExpression="TRANSF_IN_QTY" UniqueName="TRANSF_IN_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>--%>
                    <telerik:GridBoundColumn DataField="TRANSF_OUT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_OUT_QTY column" HeaderText="TRANSFER QTY" SortExpression="TRANSF_OUT_QTY" UniqueName="TRANSF_OUT_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANS_RCV_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter TRANS_RCV_QTY column" HeaderText="MTN RECEIVE" SortExpression="TRANS_RCV_QTY" UniqueName="TRANS_RCV_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ADD_ISSUE" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter ADD_ISSUE column" HeaderText="ISSUE QTY" SortExpression="ADD_ISSUE" UniqueName="ADD_ISSUE">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="QRNT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter QRNT_QTY column" HeaderText="QRNT QTY" SortExpression="QRNT_QTY" UniqueName="QRNT_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BAL_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="BALANCE" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                        <ItemStyle Width="80px" HorizontalAlign="Right" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>

    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" 
        TypeName="dsGeneralBTableAdapters.VIEW_ITEM_REP_STORETableAdapter"></asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDownloadSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT STORE_NAME,PO_NO,DISCIPLINE, MAT_CODE1, SIZE_DESC, WALL_THK, MAT_DESCR,
                        ITEM_NAME, UOM, RCVD_QTY, ACPT_QTY, SD_QTY,TRANS_RCV_QTY, ADD_ISSUE,
                        TRANSF_OUT_QTY,  QRNT_QTY,BAL_QTY, SUB_WAREHOUSE,RACK_NO,LINE_NO,SHELF_NO
                        FROM VIEW_ITEM_REP_STORE"></asp:SqlDataSource>

</asp:Content>

