<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ImportBarcodeDataDetail.aspx.cs" Inherits="Material_ImportBarcodeDataDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
         window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test()
        {
            var grid=$find('<%= RadGrid1.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
            var masterTable = $find("<%=RadGrid1.ClientID %>").get_masterTableView();
          
            grid.get_element().style.height = (height) - 260 + "px";
            grid.get_element()
      
            grid.repaint();         
        }
    </script>
    <div style="background-color: whitesmoke">
        <telerik:RadButton runat="server" ID="btnBack" Width="80px" Text="Back" OnClick="btnDetail_Click">
            <Icon PrimaryIconUrl="../Images/New-Icons/Left-Arrow.png" />
        </telerik:RadButton>
        
    </div>
    <div style="margin-top:4px">
        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="None">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" AllowAutomaticUpdates="true" DataKeyNames="ITEM_ID" 
                AllowAutomaticDeletes="true" EditMode="InPlace" TableLayout="Fixed" PageSize="50" AllowPaging="true" PagerStyle-AlwaysVisible="true">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow" ConfirmText="Are you sure you want to delete?">
                        <ItemStyle Width="40px" />
                          <HeaderStyle Width="40px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridBoundColumn DataField="MAT_CODE1" ReadOnly="true" FilterControlAltText="Filter MAT_CODE1 column" HeaderText="MAT_CODE1" SortExpression="MAT_CODE1" UniqueName="MAT_CODE1">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="HEATNO" FilterControlAltText="Filter HEATNO column" HeaderText="HEATNO" SortExpression="HEATNO" UniqueName="HEATNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="SUBSTORE" FilterControlAltText="Filter SUBSTORE column" HeaderText="SUBSTORE" SortExpression="SUBSTORE" UniqueName="SUBSTORE">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sqlSubStoreSource" DataTextField="STORE_L1" DataValueField="SUBSTORE_ID"
                                 SelectedValue='<%# Bind("SUBSTOREID") %>'></asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SUBSTORELabel" runat="server" Text='<%# Eval("SUBSTORE") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="CABLEDRUMNO" FilterControlAltText="Filter CABLEDRUMNO column" HeaderText="CABLEDRUMNO" SortExpression="CABLEDRUMNO" UniqueName="CABLEDRUMNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="BOXNO" FilterControlAltText="Filter BOXNO column" HeaderText="BOXNO" SortExpression="BOXNO" UniqueName="BOXNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RACKNO" FilterControlAltText="Filter RACKNO column" HeaderText="RACKNO" SortExpression="RACKNO" UniqueName="RACKNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ROWNO" FilterControlAltText="Filter ROWNO column" HeaderText="ROWNO" SortExpression="ROWNO" UniqueName="ROWNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FLAGNO" ReadOnly="true" FilterControlAltText="Filter FLAGNO column" HeaderText="FLAGNO" SortExpression="FLAGNO" UniqueName="FLAGNO">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="QTY" DataType="System.Decimal" FilterControlAltText="Filter QTY column" HeaderText="QTY" SortExpression="QTY" UniqueName="QTY">
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsBarcodeTableAdapters.VIEW_BARCODE_IMPORT_DETAILTableAdapter" DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ITEM_ID" Type="Object" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="XXX" Name="DOCUMENT_NO" QueryStringField="doc_no" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="HEATNO" Type="String" />
            <asp:Parameter Name="SUBSTOREID" Type="Decimal" />
            <asp:Parameter Name="CABLEDRUMNO" Type="String" />
            <asp:Parameter Name="BOXNO" Type="String" />
            <asp:Parameter Name="RACKNO" Type="String" />
            <asp:Parameter Name="ROWNO" Type="String" />
            <asp:Parameter Name="QTY" Type="Decimal" />
            <asp:Parameter Name="original_ITEM_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlSubStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_L1, SUBSTORE_ID
FROM STORES_SUB
WHERE STORE_ID = :STORE_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HiddenStoreID" DefaultValue="-1" Name="STORE_ID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HiddenStoreID" runat="server" />
</asp:Content>

