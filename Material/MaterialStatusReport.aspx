<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStatusReport.aspx.cs" Inherits="Material_MaterialStatusReport" %>

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
            //var TestIDHeight = document.getElementById("TestID").clientHeight
            
            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divFooterButton - divButton - divFooter - 90 + "px";
            grid.get_element().style.width = width - 15 + "px";

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
        <%--<telerik:RadButton ID="btnMTO" runat="server" Text="Line MTO" Width="100px" OnClick="btnMTO_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnBOM" runat="server" Text="ISO MTO" Width="100px" OnClick="btnBOM_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPO" runat="server" Text="PO" Width="100px" OnClick="btnPO_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnReceived" runat="server" Text="MRV" Width="100px" OnClick="btnReceived_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnMRIR" runat="server" Text="MRIR" Width="100px" OnClick="btnMRIR_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnStore" runat="server" Text="STORE WISE STATUS" Width="150px" OnClick="btnStore_Click"></telerik:RadButton>--%>
        <%--<telerik:RadButton ID="btnTrans" runat="server" Text="Transfer" Width="80" OnClick="btnTrans_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnAddIssue" runat="server" Text="Add Issue" Width="80" OnClick="btnAddIssue_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnHeatNos" runat="server" Text="Heat Nos" Width="80" OnClick="btnHeatNos_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnMTC" runat="server" Text="MTC" Width="80" OnClick="btnMTC_Click"></telerik:RadButton>  --%>      
    </div>
    <div style="margin-top: 5px;">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource"  onkeypress="handleSpace(event)" 
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            AllowPaging="True" PageSize="50" AllowFilteringByColumn="True" AllowSorting="true" AutoGenerateColumns="true" OnColumnCreated="itemsGrid_ColumnCreated">
            <GroupingSettings CollapseAllTooltip="Collapse all groups" CaseSensitive="false"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" FrozenColumnsCount="2"/>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="true" DataSourceID="sqlDownloadSource"  AllowMultiColumnSorting="true" >
                 <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>

              <%--      <telerik:GridBoundColumn DataField="DISCIPLINE" AutoPostBackOnFilter="true" FilterControlAltText="Filter DISCIPLINE column" 
                        HeaderText="DISCIPLINE" SortExpression="DISCIPLINE" UniqueName="DISCIPLINE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_NO" AutoPostBackOnFilter="true" FilterControlAltText="Filter MR_NO column" HeaderText="MR NO" SortExpression="MR_NO" UniqueName="MR_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" AutoPostBackOnFilter="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" SortExpression="PO_NO" UniqueName="PO_NO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE" AutoPostBackOnFilter="true" FilterControlAltText="Filter MAT_CODE column" HeaderText="MATERIAL CODE" SortExpression="MAT_CODE" UniqueName="MAT_CODE">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlAltText="Filter MAT_DESCR column" HeaderText="MAT DESCRIPTION" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAME" AutoPostBackOnFilter="true" FilterControlAltText="Filter ITEM_NAME column" HeaderText="ITEM NAME" SortExpression="ITEM_NAME" UniqueName="ITEM_NAME">
                    </telerik:GridBoundColumn>                  
                    <telerik:GridBoundColumn DataField="SIZE_DESC" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo"  AllowFiltering="true" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE DESCRIPTION" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="WALL_THK" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo"
                        AllowFiltering="true" FilterControlAltText="Filter WALL_THK column" HeaderText="THK" SortExpression="WALL_THK"
                        UniqueName="WALL_THK">
                    </telerik:GridBoundColumn>
                      <telerik:GridBoundColumn DataField="UNIT" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo"  AllowFiltering="true" FilterControlAltText="Filter UNIT column" HeaderText="UNIT" SortExpression="UNIT" UniqueName="UNIT">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter PO_QTY column" HeaderText="PO QTY" SortExpression="PO_QTY" UniqueName="PO_QTY">
                    </telerik:GridBoundColumn>
                    <%--<telerik:GridBoundColumn DataField="SRN_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter SRN_QTY column" HeaderText="SRN QTY" SortExpression="SRN_QTY" UniqueName="SRN_QTY">
                    </telerik:GridBoundColumn>--%>
                    <%--<telerik:GridBoundColumn DataField="RCVD_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter RCVD_QTY column" HeaderText="RECEIVE QTY" SortExpression="RCVD_QTY" UniqueName="RCVD_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACPT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACCEPT QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY">
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="TRANSF_OUT_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter TRANSF_OUT_QTY column" HeaderText="TRANSFER QTY" SortExpression="TRANSF_OUT_QTY" UniqueName="TRANSF_OUT_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TRANS_RCV_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter TRANS_RCV_QTY column" HeaderText="MTN RECEIVE" SortExpression="TRANS_RCV_QTY" UniqueName="TRANS_RCV_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ADD_ISSUE" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter ADD_ISSUE column" HeaderText="ISSUE QTY" SortExpression="ADD_ISSUE" UniqueName="ADD_ISSUE">
                    </telerik:GridBoundColumn>              
                    <telerik:GridBoundColumn DataField="REMAIN_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter REMAIN_QTY column" HeaderText="REMAIN QTY" SortExpression="REMAIN_QTY" UniqueName="REMAIN_QTY"  Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QRNTINE_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter QRNTINE_QTY column" HeaderText="QUARANTINE" SortExpression="QRNTINE_QTY" UniqueName="QRNTINE_QTY"  Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BAL_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter BAL_QTY column" HeaderText="BALANCE" SortExpression="BAL_QTY" UniqueName="BAL_QTY">
                    </telerik:GridBoundColumn>--%>
              
                    </Columns>
                
            </MasterTableView>           
        </telerik:RadGrid>
    </div>
    <div style="margin-top: 5px; background-color: whitesmoke" id="divFooterHeight">
        <telerik:RadButton ID="btnDownload" runat="server" Text="Download" Width="100px" OnClick="btnDownload_Click"></telerik:RadButton>
        <telerik:RadButton ID="btndownShort" runat="server" Text="Download Shortage" Width="150px" OnClick="btndownShort_Click" Visible="false"></telerik:RadButton>    
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsGeneralBTableAdapters.VIEW_MAT_STATUS_REPTableAdapter"></asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDownloadSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_NAME, MAT_CODE1, OLD_MAT_CODE,DISCIPLINE,PO_NO,MR_NO, SIZE_DESC, WALL_THK, MAT_DESCR, ITEM_NAM, UOM, PO_QTY,RCVD_QTY, ACPT_QTY, SD_QTY, SD_CLR_QTY, TRANS_RCV_QTY,
                                   TOTAL_JC_QTY,ADD_ISSUE AS MAT_MIV_QTY, TRANSF_OUT_QTY, REMAIN_QTY, QRNTINE_QTY,RETURN_QTY, BAL_QTY FROM VIEW_ITEM_REP_A"></asp:SqlDataSource>
    <%--<asp:SqlDataSource ID="sqlDownShort" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_MAT_STATUS_REP
WHERE po_short_qty &gt; 0"></asp:SqlDataSource>--%>
</asp:Content>

