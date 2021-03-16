<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReceive.aspx.cs" Inherits="Material_MatReceive" Title="MRR" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        //<![CDATA[
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= MatReceiveGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=MatReceiveGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MAT_RCV_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=11&REF_ID=" + id, "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any Transmittal!";
                alert(txt);
            }
        }

        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }

        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }

        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= MatReceiveGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width + "px";
            grid.repaint();
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div id="HeaderButtons">
        <table  background-color: gainsboro;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewTrans" runat="server" Text="New MRR" Width="80" OnClick="btnNewTrans_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="Items" Width="80" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>
              
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnGenerateBarcode" runat="server" Text="Generate Barcode" Width="150" OnClick="btnGenerateBarcode_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
                </td>
                <td style="text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server"
                        EmptyMessage="Search.." Width="200px" Visible="false">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton  ID="btnMrrIrnItems" runat="server" Text="Mrr Irn Items" Width="137px" OnClick="btnMrrIrnItems_Click" visible="false"></telerik:RadButton>
                </td>
               
            </tr>
        </table>
    </div>
     <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="MatReceiveGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div>
        <telerik:RadGrid ID="MatReceiveGridView" runat="server" DataSourceID="MatReceiveDataSource" MasterTableView-EditMode="InPlace"  AllowPaging="true" 
            PagerStyle-AlwaysVisible="true"  onkeypress="handleSpace(event)" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            CellSpacing="-1" PageSize="50" AllowFilteringByColumn="true" AllowSorting="true" 
            OnItemDataBound="MatReceiveGridView_ItemDataBound" OnItemCommand="MatReceiveGridView_ItemCommand" OnDataBinding="MatReceiveGridView_DataBinding" OnPreRender="itemsGrid_PreRender">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
             <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="MatReceiveDataSource" DataKeyNames="MAT_RCV_ID"
                AllowMultiColumnSorting="true" ClientDataKeyNames="MAT_RCV_ID" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500"/>
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <HeaderStyle Width="55px" />
                        <ItemStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" >
                        
                        <HeaderStyle Width="35px" />
                        <ItemStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn HeaderText="PDF" AllowFiltering="false" AllowSorting="true" SortExpression="PDF_FLAG">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="40px" />
                        <ItemStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE" UniqueName="DISCIPLINE" 
                        FilterControlWidth="90px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlDiscipline" runat="server" DataSourceID="sqlDiscipineSource" DataTextField="DISCIPLINE" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                DataValueField="DISCIPLINE_ID" SelectedValue='<%# Bind("DISCIPLINE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DISCIPLINELabel" runat="server" Text='<%# Eval("DISCIPLINE") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="140px" />
                        <ItemStyle Width="140px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MRR NUMBER" 
                        SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true" >
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="RECV_DATE" DataType="System.DateTime" FilterControlAltText="Filter RECV_DATE column" 
                        HeaderText="RECEIVE DATE" SortExpression="RECV_DATE" UniqueName="RECV_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("RECV_DATE") %>' Width="120px"></telerik:RadDatePicker>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RECV_DATELabel" runat="server" Text='<%# Eval("RECV_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="170px" />
                        <ItemStyle Width="170px" />
                    </telerik:GridTemplateColumn>
                    
                    <telerik:GridTemplateColumn DataField="RECV_BY" FilterControlAltText="Filter RECV_BY column" HeaderText="CREATED BY" SortExpression="RECV_BY" UniqueName="RECV_BY" 
                        FilterControlWidth="90px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlRECV_BY" runat="server" DataSourceID="sqlUserDataSource" DataTextField="RECV_BY" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                DataValueField="RECV_BY" SelectedValue='<%# Bind("RECV_BY") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RECV_BYLabel" runat="server" Text='<%# Eval("RECV_BY") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="140px" />
                        <ItemStyle Width="140px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="DELIVERY_POINT" FilterControlAltText="Filter DELIVERY_POINT column" HeaderText="DELIVERY POINT" 
                        SortExpression="DELIVERY_POINT" UniqueName="DELIVERY_POINT" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SHIP_NO" FilterControlAltText="Filter SHIP_NO column" HeaderText="SHIP NO" 
                        SortExpression="SHIP_NO" UniqueName="SHIP_NO" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <HeaderStyle Width="180px" />
                        <ItemStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME" 
                        SortExpression="STORE_NAME" UniqueName="STORE_NAME" AllowFiltering="true"  AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList3" runat="server" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px" >
                             </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="STORE_NAMELabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridTemplateColumn>
                 
                    <telerik:GridBoundColumn DataField="PO_NO"  FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"  ReadOnly="true"
                        SortExpression="PO_NO" UniqueName="PO_NO" FilterControlWidth="100px" AutoPostBackOnFilter="true">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="VENDOR_NAME" ReadOnly="true" FilterControlAltText="Filter VENDOR_NAME column" HeaderText="PO VENDOR NAME" SortExpression="VENDOR_NAME" UniqueName="VENDOR_NAME" 
                        FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridBoundColumn>
                   <%-- <telerik:GridBoundColumn DataField="SRN_NO" FilterControlAltText="Filter SRN_NO column" HeaderText="IRN No" 
                        SortExpression="SRN_NO" UniqueName="SRN_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridBoundColumn>--%>
                     <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN No" 
                        SortExpression="IRN_NO" UniqueName="IRN_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true" ReadOnly="true">
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" 
                         SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" AllowFiltering="false" ReadOnly="true">
                         <HeaderStyle Width="120px" />
                        <ItemStyle Width="120px" />
                    </telerik:GridBoundColumn>
                     <telerik:GridBoundColumn DataField="RFI_PERCENT" FilterControlAltText="Filter RFI_PERCENT column" HeaderText="RFI %"   DataType="System.Decimal"
                         SortExpression="RFI_PERCENT" UniqueName="RFI_PERCENT" AllowFiltering="true"  AutoPostBackOnFilter="true" ReadOnly="true" FilterControlWidth="40px">
                         <HeaderStyle Width="100px" />
                        <ItemStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"  
                        SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="true"  FilterControlWidth="70px" AutoPostBackOnFilter="true">
                          <HeaderStyle Width="500px" />
                        <ItemStyle Width="500px" />
                    </telerik:GridBoundColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
   

    <asp:ObjectDataSource ID="MatReceiveDataSource" runat="server" DeleteMethod="DeleteQuery"
        SelectMethod="GetData" TypeName="dsPO_ShipmentATableAdapters.VIEW_ADAPTER_MAT_RCVTableAdapter"
        UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_MAT_RCV_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
             <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_RCV_NO" Type="String" />
            <asp:Parameter Name="RECV_DATE" Type="DateTime" />
            <asp:Parameter Name="RECV_BY" Type="String" />
            <asp:Parameter Name="SHIP_NO" Type="String" />
            <asp:Parameter Name="DELIVERY_POINT" Type="String" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <%--<asp:Parameter Name="SRN_NO" Type="String" />--%>
            <asp:Parameter Name="original_MAT_RCV_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" Name="FILTER" PropertyName="Text" Type="String"
                DefaultValue="%" />
             <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDiscipineSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE_ID, DISCIPLINE FROM DISCIPLINE_DEF"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, mr_item AS ID FROM view_mrir_summary WHERE MAT_RCV_ID = :MAT_RCV_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="MatReceiveGridView" DefaultValue="-1" Name="MAT_RCV_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlUserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
        SelectCommand='SELECT USER_ID, USER_NAME AS RECV_BY FROM USERS  ORDER BY USER_NAME'>
       
    </asp:SqlDataSource>
    
</asp:Content>
