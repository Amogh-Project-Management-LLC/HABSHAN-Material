<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_MRIR.aspx.cs" Inherits="Material_MaterialStock_MRIR" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 50 + "px";
            grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnBack" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnExport" Text="Export" Width="80px" OnClick="btnExport_Click"></telerik:RadButton>
    </div>
    <div>
        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="sqlDataSource" GridLines="None">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="sqlDataSource" PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridBoundColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUB_CON_NAME" SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MIR_NO" FilterControlAltText="Filter MIR_NO column" HeaderText="MIR_NO" SortExpression="MIR_NO" UniqueName="MIR_NO">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="INSP_DATE" DataFormatString="{0:dd-MMM-yyyy}" DataType="System.DateTime" FilterControlAltText="Filter INSP_DATE column" HeaderText="INSP_DATE" SortExpression="INSP_DATE" UniqueName="INSP_DATE">
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO_NO" SortExpression="PO_NO" UniqueName="PO_NO">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRV_NUMBER" FilterControlAltText="Filter MRV_NUMBER column" HeaderText="MRV_NUMBER" SortExpression="MRV_NUMBER" UniqueName="MRV_NUMBER">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE_NAME" SortExpression="STORE_NAME" UniqueName="STORE_NAME">
                         <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                        </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RCV_QTY" DataType="System.Decimal" FilterControlAltText="Filter RCV_QTY column" HeaderText="RCV_QTY" SortExpression="RCV_QTY" UniqueName="RCV_QTY">
                         <ItemStyle Width="80px" HorizontalAlign="Right"/>
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACPT_QTY" DataType="System.Decimal" FilterControlAltText="Filter ACPT_QTY column" HeaderText="ACPT_QTY" SortExpression="ACPT_QTY" UniqueName="ACPT_QTY">
                   <ItemStyle Width="80px" HorizontalAlign="Right"/>
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT_NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TC_CODE" FilterControlAltText="Filter TC_CODE column" HeaderText="TC_CODE" SortExpression="TC_CODE" UniqueName="TC_CODE">
                        
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="sqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT JOB_CODE, MIR_NO, SRN_NO, INSP_DATE, SUB_CON_NAME, PO_NO, SHIP_NO, MRV_NUMBER, STORE_NAME, MAT_CODE1,
MAT_CODE2, SIZE_DESC, RANGE_A, RANGE_B, SIZE1, SIZE2, WALL_THK, ITEM_NAM, SG_GROUP, MAT_DESCR, UOM,
RCV_QTY, ACPT_QTY, AS_PER_PL_QTY, HEAT_NO, PAINT_SYS, PO_ITEM, MIR_ITEM, TC_CODE, PDF_FLG, STORE_L1, REMARKS, MRIR_REMARKS, TOTAL_WT, SUPPLIER_VENDORNAME FROM VIEW_MAT_MRIR_SUMMARY
WHERE MAT_ID = :MAT_ID">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="-1" Name="MAT_ID" QueryStringField="MAT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

