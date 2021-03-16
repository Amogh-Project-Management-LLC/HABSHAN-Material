<%@ Page Title="PO Vendor Data" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POVendorData.aspx.cs" Inherits="Procurement_POVendorData" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
          function upload_pdf() {
            try {
                var id = 1;
                radopen("../Common/MTCFileImport.aspx", "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any Transmittal!";
                alert(txt);
            }
        }

        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }


        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //  var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = width - 12 + "px";
            grid.repaint();
        }
    </script>
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <telerik:RadButton ID="btnBack" runat="server" Text="Back" Width="80px" OnClick="btnBack_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnImportIRN" runat="server" Text="Import.." Width="120px">
            <Icon PrimaryIconUrl="../Images/icons/excel.png" />
        </telerik:RadButton>
        <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
            <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
        </asp:LinkButton>
        <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="80px" OnClick="btnExport_Click"></telerik:RadButton>

    </div>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" PageSize="50" AllowFilteringByColumn="true"
            AllowSorting="true" PagerStyle-AlwaysVisible="true" OnItemDataBound="itemsGrid_ItemDataBound">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="IRN_NO,PO_NO,PO_ITEM,PIPE_NO,MTC_CODE" ClientDataKeyNames="MTC_CODE" DataSourceID="itemsDataSource" AllowMultiColumnSorting="true" TableLayout="Fixed">

                <Columns>
                    <telerik:GridTemplateColumn AllowFiltering="false" HeaderText="PDF">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN NO" ReadOnly="True" SortExpression="IRN_NO" UniqueName="IRN_NO" AutoPostBackOnFilter="true" FilterControlWidth="200px">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CLIENT_IRN" FilterControlAltText="Filter CLIENT_IRN column" HeaderText="CLIENT IRN" SortExpression="CLIENT_IRN" UniqueName="CLIENT_IRN" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO" ReadOnly="True" SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" FilterControlWidth="110px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT CODE" ReadOnly="True" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1" AutoPostBackOnFilter="true" FilterControlWidth="110px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_DESCR" FilterControlAltText="Filter MAT_DESCR column" HeaderText="DESCRIPTION" ReadOnly="True" SortExpression="MAT_DESCR" UniqueName="MAT_DESCR" AutoPostBackOnFilter="true" FilterControlWidth="200px">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SIZE_DESC" FilterControlAltText="Filter SIZE_DESC column" HeaderText="SIZE" ReadOnly="True" SortExpression="SIZE_DESC" UniqueName="SIZE_DESC" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_NAM" FilterControlAltText="Filter ITEM_NAM column" HeaderText="ITEM NAME" ReadOnly="True" SortExpression="ITEM_NAM" UniqueName="ITEM_NAM" AutoPostBackOnFilter="true" FilterControlWidth="110px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_ITEM" FilterControlAltText="Filter PO_ITEM column" HeaderText="PO ITEM" ReadOnly="True" SortExpression="PO_ITEM" UniqueName="PO_ITEM" AutoPostBackOnFilter="true" FilterControlWidth="40">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="LOT_NO" FilterControlAltText="Filter LOT_NO column" HeaderText="LOT NO" SortExpression="LOT_NO" UniqueName="LOT_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEAT_NO" FilterControlAltText="Filter HEAT_NO column" HeaderText="HEAT NO" SortExpression="HEAT_NO" UniqueName="HEAT_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MTC_CODE" FilterControlAltText="Filter MTC_CODE column" HeaderText="MTC CODE" SortExpression="MTC_CODE" UniqueName="MTC_CODE" AutoPostBackOnFilter="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIPE_NO" FilterControlAltText="Filter PIPE_NO column" HeaderText="PIPE NO" ReadOnly="True" SortExpression="PIPE_NO" UniqueName="PIPE_NO" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="UOM_NAME" FilterControlAltText="Filter UOM_NAME column" HeaderText="UNIT" ReadOnly="True" SortExpression="UOM_NAME" UniqueName="UOM_NAME" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Qty" FilterControlAltText="Filter Qty column" HeaderText="IRN Qty" ReadOnly="True" SortExpression="Qty" UniqueName="Qty" AllowFiltering="false">
                        <ItemStyle Width="80px" />
                        <HeaderStyle Width="80px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PIPE_LENGTH" DataType="System.Decimal" FilterControlAltText="Filter PIPE_LENGTH column" HeaderText="QTY/LENGTH" SortExpression="PIPE_LENGTH" UniqueName="PIPE_LENGTH" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsPO_ReportsATableAdapters.PO_VENDOR_DATATableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_IRN_NO" Type="String" />
            <asp:Parameter Name="Original_PO_NO" Type="String" />
            <asp:Parameter Name="Original_PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_PIPE_NO" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="IRN_NO" Type="String" />
            <asp:Parameter Name="CLIENT_IRN" Type="String" />
            <asp:Parameter Name="PO_NO" Type="String" />
            <asp:Parameter Name="PO_ITEM" Type="String" />
            <asp:Parameter Name="LOT_NO" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="MTC_CODE" Type="String" />
            <asp:Parameter Name="PIPE_NO" Type="String" />
            <asp:Parameter Name="PIPE_LENGTH" Type="Decimal" />
            <asp:Parameter Name="UOM" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PROJECT_ID" Type="Decimal" />
            <asp:Parameter Name="ITEM_ID" Type="Decimal" />
            <asp:Parameter Name="CLIENT_IRN" Type="String" />
            <asp:Parameter Name="LOT_NO" Type="String" />
            <asp:Parameter Name="HEAT_NO" Type="String" />
            <asp:Parameter Name="MTC_CODE" Type="String" />
            <asp:Parameter Name="PIPE_LENGTH" Type="Decimal" />
            <asp:Parameter Name="UOM" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
            <asp:Parameter Name="Original_IRN_NO" Type="String" />
            <asp:Parameter Name="Original_PO_NO" Type="String" />
            <asp:Parameter Name="Original_PO_ITEM" Type="String" />
            <asp:Parameter Name="Original_PIPE_NO" Type="String" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDataDownload" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT * FROM VIEW_PO_VENDOR_DATA"></asp:SqlDataSource>
</asp:Content>

