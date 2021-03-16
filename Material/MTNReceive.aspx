<%@ Page Title="MTN Receive" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MTNReceive.aspx.cs" Inherits="Material_MTNReceive" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        //<![CDATA[
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("RCV_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=17&REF_ID=" + id, "RadWindow2", 650, 450);
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
            var grid = $find('<%= itemsGrid.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var divHeight = document.getElementById("PageHeader").clientHeight
            var width = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
              grid.get_element().style.width = width - 12 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
            //]]>
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton ID="btnRegister" runat="server" Text="New MTN" Width="100px"></telerik:RadButton>
        <telerik:RadButton ID="btnMaterial" runat="server" Text="Items" Width="80px" OnClick="btnMaterial_Click"></telerik:RadButton>
        <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80px" OnClick="btnPreview_Click"></telerik:RadButton>
        <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
            <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
        </asp:LinkButton>
        <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
    </div>
     <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div style="margin-top: 3px">
        <telerik:RadGrid ID="itemsGrid" runat="server" AllowPaging="True" DataSourceID="itemsDataSource" CellSpacing="-1" GridLines="None"
            PageSize="50" AllowFilteringByColumn="true" AllowSorting="true" onkeypress="handleSpace(event)" OnItemDataBound="itemsGrid_ItemDataBound" 
            OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding" OnPreRender="itemsGrid_PreRender"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace" AllowMultiColumnSorting="true"
                DataKeyNames="RCV_ID" ClientDataKeyNames="RCV_ID"
                PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete"
                        ConfirmDialogType="RadWindow">
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridButtonColumn>
                    <telerik:GridTemplateColumn HeaderText="PDF" AllowFiltering="false" AllowSorting="true" SortExpression="PDF_FLAG">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="40px" />
                        <HeaderStyle Width="40px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="RCV_NUMBER" FilterControlAltText="Filter RCV_NUMBER column"
                        HeaderText="RECEIVE NO" SortExpression="RCV_NUMBER" UniqueName="RCV_NUMBER" FilterControlWidth="80px"
                        AutoPostBackOnFilter="true">
                        <ItemStyle Width="160px" />
                        <HeaderStyle Width="160px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RCV_DATE" DataType="System.DateTime" FilterControlAltText="Filter RCV_DATE column"
                        HeaderText="RECEIVE DATE" SortExpression="RCV_DATE" UniqueName="RCV_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("RCV_DATE") %>' Width="120px"></telerik:RadDatePicker>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("RCV_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    
                     <telerik:GridTemplateColumn DataField="RCV_BY" FilterControlAltText="Filter RCV_BY column" HeaderText="CREATED BY"
                        SortExpression="RCV_BY" UniqueName="RCV_BY" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlUser" runat="server" DataSourceID="UserDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="RCV_BY" DataValueField="RCV_BY" Width="130px" AppendDataBoundItems="true"
                                SelectedValue='<%# Bind("RCV_BY") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblUser" runat="server" Text='<%# Eval("RCV_BY") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TRANSF_NO" ReadOnly="true" FilterControlAltText="Filter TRANSF_NO column"
                        HeaderText="TRANSFER NO" SortExpression="TRANSF_NO" UniqueName="TRANSF_NO" FilterControlWidth="80px"
                        AutoPostBackOnFilter="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CONTAINER_NO" FilterControlAltText="Filter CONTAINER_NO column"
                        HeaderText="CONTAINER NO" SortExpression="CONTAINER_NO" UniqueName="CONTAINER_NO" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PACKING_LIST_NO" ReadOnly="false" FilterControlAltText="Filter PACKING_LIST_NO column"
                        HeaderText="PACKING LIST NO" SortExpression="PACKING_LIST_NO" UniqueName="PACKING_LIST_NO" AllowFiltering="false">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    
                     <telerik:GridTemplateColumn DataField="RECEIVE_STORE" FilterControlAltText="Filter RECEIVE_STORE column" HeaderText="RECEIVE STORE"
                        SortExpression="RECEIVE_STORE" UniqueName="RECEIVE_STORE" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList1" runat="server" DataSourceID="FromstoreDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="RECEIVE_STORE" DataValueField="STORE_ID" Width="130px"
                                SelectedValue='<%# Bind("STORE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("RECEIVE_STORE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" ReadOnly="true" FilterControlAltText="Filter ITEM_COUNT column"
                        HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" FilterControlWidth="50px">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" ReadOnly="false" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                          <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialETableAdapters.VIEW_MAT_TRANSFER_RCVTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RCV_NUMBER" Type="String" />
            <asp:Parameter Name="RCV_DATE" Type="DateTime" />
            <asp:Parameter Name="RCV_BY" Type="String" />
            <asp:Parameter Name="CONTAINER_NO" Type="String" />
            <asp:Parameter Name="PACKING_LIST_NO" Type="String" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RCV_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="FromstoreDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT STORE_ID , STORE_NAME AS RECEIVE_STORE  FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
     <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME AS RCV_BY FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>
</asp:Content>

