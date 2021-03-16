<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatRFI.aspx.cs" Inherits="Material_MatRFI" %>

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
                var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("RFI_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=12&REF_ID=" + id, "RadWindow2", 650, 450);
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
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }

            //]]>
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnNew" Text="New RFI" Width="100px"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnMat" Text="Items" Width="80px" OnClick="btnMat_Click"></telerik:RadButton>

        <telerik:RadButton runat="server" ID="btnPreview" Text="Preview" Width="100px" OnClick="btnPreview_Click"></telerik:RadButton>
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
    <div style="margin-top: 2px">
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" MasterTableView-EditMode="InPlace" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            OnItemDataBound="itemsGrid_ItemDataBound" onkeypress="handleSpace(event)" AllowSorting="true" PageSize="50" Height="330px"
            AllowFilteringByColumn="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" OnItemCommand="itemsGrid_ItemCommand" OnDataBinding="itemsGrid_DataBinding" OnPreRender="itemsGrid_PreRender">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings Selecting-AllowRowSelect="true">
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource"
                AllowMultiColumnSorting="true" DataKeyNames="RFI_ID" ClientDataKeyNames="RFI_ID"
                TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn CommandName="Delete" ButtonType="ImageButton">

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

                    <telerik:GridTemplateColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE"
                        UniqueName="DISCIPLINE" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains" FilterControlWidth="80px">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlDiscEdit" runat="server" DataSourceID="sqlDiscSource"
                                DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" AppendDataBoundItems="true" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                SelectedValue='<%# Bind("DISCIPLINE_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DISCIPLINELabel" runat="server" Text='<%# Eval("DISCIPLINE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE NAME"
                        SortExpression="STORE_NAME" UniqueName="STORE_NAME" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlstore" runat="server" DataSourceID="storeDataSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID") %>'
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="STORE_NAMELabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="200px" />
                        <ItemStyle Width="200px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="RFI_NO" FilterControlAltText="Filter RFI_NO column" HeaderText="RFI NUMBER"
                        SortExpression="RFI_NO" UniqueName="RFI_NO" FilterControlWidth="90px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CLIENT_RFI_NO" FilterControlAltText="Filter CLIENT_RFI_NO column" HeaderText="CLIENT RFI NUMBER"
                        SortExpression="CLIENT_RFI_NO" UniqueName="CLIENT_RFI_NO" FilterControlWidth="90px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MAT_RCV_NO" ReadOnly="true" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MRR NO"
                        SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO" FilterControlWidth="90px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="RFI_DATE" DataType="System.DateTime" FilterControlAltText="Filter RFI_DATE column"
                        HeaderText="RFI DATE" SortExpression="RFI_DATE" UniqueName="RFI_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtRFIDateEdit" runat="server" DbSelectedDate='<%# Bind("RFI_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RFI_DATELabel" runat="server" Text='<%# Eval("RFI_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" ReadOnly="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER"
                        SortExpression="PO_NO" UniqueName="PO_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_VEND_NAME" ReadOnly="true" FilterControlAltText="Filter PO_VEND_NAME column" HeaderText="PO VENDOR NAME" SortExpression="PO_VEND_NAME" UniqueName="PO_VEND_NAME"
                        FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="300px" />
                        <HeaderStyle Width="300px" />
                    </telerik:GridBoundColumn>
                 

                     <telerik:GridTemplateColumn DataField="CREATED_BY" FilterControlAltText="Filter CREATED_BY column" HeaderText="CREATED BY"
                        SortExpression="CREATED_BY" UniqueName="CREATED_BY" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlUser" runat="server" DataSourceID="userDataSource"
                                DataTextField="CREATED_BY" DataValueField="USER_ID" SelectedValue='<%# Bind("USER_ID") %>'
                                Width="120px" DropDownWidth="200px" DropDownHeight="200px">
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CREATED_BYLabel" runat="server" Text='<%# Eval("CREATED_BY") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="135px" />
                        <ItemStyle Width="135px" />
                    </telerik:GridTemplateColumn>


                    <telerik:GridBoundColumn DataField="SHIPMENT_NO" FilterControlAltText="Filter SHIPMENT_NO column" HeaderText="SHIPMENT NO"
                        SortExpression="SHIPMENT_NO" UniqueName="SHIPMENT_NO" FilterControlWidth="80px" AutoPostBackOnFilter="true">
                        <ItemStyle Width="140px" />
                        <HeaderStyle Width="140px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT"
                        SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="MRIR_PERCENT" FilterControlAltText="Filter MRIR_PERCENT column" HeaderText="MRIR %"
                        SortExpression="MRIR_PERCENT" UniqueName="MRIR_PERCENT" ItemStyle-Width="30px" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="40px" ReadOnly="true" DataType="System.Decimal">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                        SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <%-- <telerik:GridBoundColumn DataField="CREATE_DATE" ReadOnly="true" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" ItemStyle-Width="60px" AllowFiltering="false">
                    </telerik:GridBoundColumn>--%>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="dsMaterialETableAdapters.VIEW_MAT_INSP_REQUESTTableAdapter" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_RFI_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="RFI_NO" Type="String" />
            <asp:Parameter Name="CLIENT_RFI_NO" Type="String" />
            <asp:Parameter Name="RFI_DATE" Type="DateTime" />
            <asp:Parameter Name="USER_ID" Type="Decimal" />
            <asp:Parameter Name="SHIPMENT_NO" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RFI_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlDiscSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  *
FROM DISCIPLINE_DEF"></asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="userDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT  USER_ID, USER_NAME AS CREATED_BY
FROM USERS
ORDER BY   USER_NAME"></asp:SqlDataSource>
</asp:Content>

