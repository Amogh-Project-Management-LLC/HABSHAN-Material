<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportBarcodeData.aspx.cs" Inherits="Material_ImportBarcodeData" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
                window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test()
        {
            var grid=$find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=itemsGrid.ClientID %>").get_masterTableView();
          
            grid.get_element().style.height = (height) - 260 + "px";
            grid.get_element()
      
            grid.repaint();         
        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Width="80px" Text="Back" OnClick="btnBack_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnDetail" Width="80px" Text="Detail" OnClick="btnDetail_Click">
            <Icon PrimaryIconUrl="../Images/icons/menu-icon.png" />
        </telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnSave" Width="80px" Text="Save" OnClick="btnSave_Click">
            <Icon PrimaryIconUrl="../Images/icons/icon-save2.png" />
        </telerik:RadButton>
    </div>
    <div style="margin-top:4px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" AllowMultiRowSelection="true" PageSize="50" PagerStyle-AlwaysVisible="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="DOCUMENTNO, MAT_CODE1, HEATNO, SUBSTORE, CABLEDRUMNO, BOXNO, RACKNO, ROWNO">
                <Columns>
                    <telerik:GridClientSelectColumn Display="true"></telerik:GridClientSelectColumn>
                    <telerik:GridBoundColumn DataField="DOCUMENTNO" FilterControlAltText="Filter DOCUMENTNO column" HeaderText="DOCUMENT NO" SortExpression="DOCUMENTNO" UniqueName="DOCUMENTNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_CODE1" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1"
                        SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEATNO" FilterControlAltText="Filter HEATNO column" HeaderText="HEAT NO" SortExpression="HEATNO" UniqueName="HEATNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SUBSTORE" FilterControlAltText="Filter SUBSTORE column" HeaderText="SUBSTORE" SortExpression="SUBSTORE" UniqueName="SUBSTORE">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CABLEDRUMNO" FilterControlAltText="Filter CABLEDRUMNO column" HeaderText="CABLE DRUM NO" SortExpression="CABLEDRUMNO" UniqueName="CABLEDRUMNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOXNO" FilterControlAltText="Filter BOXNO column" HeaderText="BOX NO" SortExpression="BOXNO" UniqueName="BOXNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RACKNO" FilterControlAltText="Filter RACKNO column" HeaderText="RACK NO" SortExpression="RACKNO" UniqueName="RACKNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ROWNO" FilterControlAltText="Filter ROWNO column" HeaderText="ROW NO" SortExpression="ROWNO" UniqueName="ROWNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ACCEPT_QTY" DataType="System.Decimal" FilterControlAltText="Filter ACCEPT_QTY column" HeaderText="ACCEPT_QTY" SortExpression="ACCEPT_QTY" UniqueName="ACCEPT_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="EXCESS_QTY" DataType="System.Decimal" FilterControlAltText="Filter EXCESS_QTY column" HeaderText="EXCESS_QTY" SortExpression="EXCESS_QTY" UniqueName="EXCESS_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHORT_QTY" DataType="System.Decimal" FilterControlAltText="Filter SHORT_QTY column" HeaderText="SHORT_QTY" SortExpression="SHORT_QTY" UniqueName="SHORT_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DAMAGE_QTY" DataType="System.Decimal" FilterControlAltText="Filter DAMAGE_QTY column" HeaderText="DAMAGE_QTY" SortExpression="DAMAGE_QTY" UniqueName="DAMAGE_QTY">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="OTHER_QTY" DataType="System.Decimal" FilterControlAltText="Filter OTHER_QTY column" HeaderText="QTY" SortExpression="OTHER_QTY" UniqueName="OTHER_QTY">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsBarcodeTableAdapters.VIEW_BARCODE_IMPORT_DATATableAdapter">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="XXX" Name="DOCUMENT_NO" QueryStringField="doc_no" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

