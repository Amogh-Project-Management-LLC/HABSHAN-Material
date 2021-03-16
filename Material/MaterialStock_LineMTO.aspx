<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialStock_LineMTO.aspx.cs" Inherits="Material_MaterialStock_LineMTO" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            // var width = document.getElementById("RadMenu1").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            //grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px"
            OnClick="btnBack_Click">
        </telerik:RadButton>
    </div>
    <div style="margin-top: 3px;">
        <telerik:RadGrid ID="RadGrid1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource1"
            AllowFilteringByColumn="true" Width="100%">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="SqlDataSource1" TableLayout="Fixed">
                <Columns>
                    <telerik:GridBoundColumn DataField="LINE_NO" AllowFiltering="true" FilterControlAltText="Filter LINE_NO column" HeaderText="LINE_NO" SortExpression="LINE_NO" UniqueName="LINE_NO">
                    
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AREA_L1" AllowFiltering="false" FilterControlAltText="Filter AREA_L1 column" HeaderText="AREA_L1" SortExpression="AREA_L1" UniqueName="AREA_L1">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LINE_CLASS" AllowFiltering="false" FilterControlAltText="Filter LINE_CLASS column" HeaderText="LINE_CLASS" SortExpression="LINE_CLASS" UniqueName="LINE_CLASS">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAIN_MAT" AllowFiltering="false" FilterControlAltText="Filter MAIN_MAT column" HeaderText="MAIN_MAT" SortExpression="MAIN_MAT" UniqueName="MAIN_MAT">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LINE_SIZE" AllowFiltering="false" FilterControlAltText="Filter LINE_SIZE column" HeaderText="LINE_SIZE" SortExpression="LINE_SIZE" UniqueName="LINE_SIZE">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PRIORITY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter PRIORITY column" HeaderText="PRIORITY" SortExpression="PRIORITY" UniqueName="PRIORITY">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PART_NO" AllowFiltering="false" FilterControlAltText="Filter PART_NO column" HeaderText="PART_NO" SortExpression="PART_NO" UniqueName="PART_NO">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MTO_QTY" AllowFiltering="false" DataType="System.Decimal" FilterControlAltText="Filter MTO_QTY column" HeaderText="MTO_QTY" SortExpression="MTO_QTY" UniqueName="MTO_QTY">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_AVL" AllowFiltering="false" FilterControlAltText="Filter PO_AVL column" HeaderText="PO_AVL" SortExpression="PO_AVL" UniqueName="PO_AVL">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MR_AVL" AllowFiltering="false" FilterControlAltText="Filter MR_AVL column" HeaderText="MR_AVL" SortExpression="MR_AVL" UniqueName="MR_AVL">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ETA_MONTH" AllowFiltering="false" FilterControlAltText="Filter ETA_MONTH column" HeaderText="ETA_MONTH" SortExpression="ETA_MONTH" UniqueName="ETA_MONTH">
                    <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT *
FROM VIEW_LINE_MTO
WHERE PART_NO = :PART_NO">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenField1" DefaultValue="XXX" Name="PART_NO" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenField1" runat="server" />
</asp:Content>

