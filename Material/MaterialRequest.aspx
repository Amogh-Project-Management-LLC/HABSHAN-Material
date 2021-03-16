<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MaterialRequest.aspx.cs" Inherits="Material_MaterialRequest" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        //<![CDATA[
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= RadGrid1.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=RadGrid1.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MAT_REQ_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=14&REF_ID=" + id, "RadWindow2", 650, 450);
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


        ////grid size//////////////////////
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
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
            grid.get_element().style.width = width - 20 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }

        ////////grid size////////////////////
            //]]>
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div>
        <table style="background-color: gainsboro" id="HeaderButtons">
            <tr>
                <td>

                    <telerik:RadButton ID="btnAdd" runat="server" Text="New MR" Width="80"></telerik:RadButton>

                </td>
                <td>
                    <telerik:RadButton ID="btnItems1" runat="server" Text="Items" Width="80" OnClick="btnItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" OnClick="btnPreview_Click1" Width="100px"></telerik:RadButton>
                </td>
                <td>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDFR" runat="server" Text="Bulk MR" Width="100px" OnClick="btnMR_Click" CausesValidation="false"></telerik:RadButton>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <telerik:RadTextBox ID="txtSearch" runat="server" Width="200" EmptyMessage="Search Here" AutoPostBack="True" Visible="false"></telerik:RadTextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <telerik:RadButton ID="btnSendMail" runat="server" Text="Send Mail" OnClick="btnSendMail_Click" Width="100px"></telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="RadGrid1" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <table class="TableStyle" style="width: 100%">
        <tr>
            <td>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                    <ContentTemplate>
                        <telerik:RadGrid ID="RadGrid1" runat="server" DataSourceID="itemsDataSource" AllowSorting="true" onkeypress="handleSpace(event)" OnItemDataBound="RadGrid1_ItemDataBound" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true"
                            PageSize="50" AllowFilteringByColumn="true" OnItemCommand="RadGrid1_ItemCommand" OnDataBinding="RadGrid1_DataBinding"
                            OnPreRender="itemsGrid_PreRender" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
                            <GroupingSettings CollapseAllTooltip="Collapse all groups" />
                            <ClientSettings>
                                <Selecting AllowRowSelect="true" />
                                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
                                <Virtualization EnableVirtualization="true" InitiallyCachedItemsCount="100" ItemsPerView="100" />
                            </ClientSettings>
                            <ClientSettings AllowKeyboardNavigation="true">
                                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
                            </ClientSettings>
                            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource"
                                DataKeyNames="MAT_REQ_ID" EditMode="InPlace" AllowMultiColumnSorting="true" AllowPaging="true"
                                ClientDataKeyNames="MAT_REQ_ID" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                                <Columns>
                                    <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                                        <ItemStyle Width="55px" />
                                        <HeaderStyle Width="55px" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn
                                        ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete" Text="Delete"
                                        UniqueName="DeleteColumn">
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
                                    <telerik:GridBoundColumn DataField="MAT_REQ_NO" FilterControlAltText="Filter MAT_REQ_NO column"
                                        HeaderText="REQUEST NUMBER" SortExpression="MAT_REQ_NO" UniqueName="MAT_REQ_NO"
                                        FilterControlWidth="80px" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="150px" />
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="MAT_REQ_DATE" DataType="System.DateTime" FilterControlAltText="Filter MAT_REQ_DATE column"
                                        HeaderText="REQUEST DATE" SortExpression="MAT_REQ_DATE" UniqueName="MAT_REQ_DATE" AllowFiltering="false">
                                        <EditItemTemplate>
                                            <telerik:RadDatePicker ID="txtEditReqDate" runat="server" SelectedDate='<%# Bind("MAT_REQ_DATE")%>'
                                                DateInput-DateFormat="dd-MMM-yyyy">
                                            </telerik:RadDatePicker>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="MAT_REQ_DATELabel" runat="server" Text='<%# Eval("MAT_REQ_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="160px" />
                                        <HeaderStyle Width="160px" />
                                    </telerik:GridTemplateColumn>
                                    <%--<telerik:GridBoundColumn DataField="AREA" FilterControlAltText="Filter AREA column"
                                        HeaderText="AREA" SortExpression="AREA" UniqueName="AREA"
                                        FilterControlWidth="40px" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>--%>
                                    <telerik:GridTemplateColumn DataField="AREA" FilterControlAltText="Filter AREA column" HeaderText="AREA" FilterControlWidth="50px"
                                        SortExpression="AREA" UniqueName="AREA" AllowFiltering="true" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cboAREA" runat="server" DataSourceID="AreaDataSource" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                                ItemsPerRequest="10" ShowMoreResultsBox="true"
                                                DataTextField="AREA" DataValueField="AREA" SelectedValue='<%# Bind("AREA") %>'
                                                AppendDataBoundItems="True">
                                                <Items>
                                                    <telerik:RadComboBoxItem Selected="true" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("AREA") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <%--<telerik:GridBoundColumn DataField="SUB_AREA" FilterControlAltText="Filter SUB_AREA column"
                                        HeaderText="SUB AREA" SortExpression="SUB_AREA" UniqueName="SUB_AREA"
                                        FilterControlWidth="40px" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>--%>
                                    <telerik:GridTemplateColumn DataField="SUB_AREA" FilterControlAltText="Filter SUB_AREA column" HeaderText="SUB AREA" FilterControlWidth="50px"
                                        SortExpression="SUB_AREA" UniqueName="SUB_AREA" AllowFiltering="true" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                        <EditItemTemplate>
                                            <telerik:RadComboBox ID="cboSUBAREA" runat="server" DataSourceID="subAreaDataSource" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                                ItemsPerRequest="10" ShowMoreResultsBox="true"
                                                DataTextField="SUB_AREA" DataValueField="SUB_AREA" SelectedValue='<%# Bind("SUB_AREA") %>'
                                                AppendDataBoundItems="True">
                                                <Items>
                                                    <telerik:RadComboBoxItem Selected="true" />
                                                </Items>
                                            </telerik:RadComboBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("SUB_AREA") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>


                                    <telerik:GridTemplateColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="CREATED BY" SortExpression="USER_NAME"
                                        UniqueName="USER_NAME" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains" FilterControlWidth="80px">
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList ID="ddlUserEdit" runat="server" DataSourceID="sqlUserSource"
                                                DataTextField="USER_NAME" DataValueField="USER_ID" AppendDataBoundItems="true" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                                SelectedValue='<%# Bind("USER_ID") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="UserLabel" runat="server" Text='<%# Eval("USER_NAME") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="140px" />
                                        <HeaderStyle Width="140px" />

                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="REQ_FROM" FilterControlAltText="Filter REQ_FROM column" HeaderText="REQ FROM" FilterControlWidth="80px"
                                        SortExpression="REQ_FROM" UniqueName="REQ_FROM" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList ID="ddlFromStoreEdit" runat="server" DataSourceID="sqlFromStoreSource"
                                                DataTextField="REQ_FROM" DataValueField="REQ_FROM" AppendDataBoundItems="true" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                                SelectedValue='<%# Bind("REQ_FROM") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="FromStoreLabel" runat="server" Text='<%# Eval("REQ_FROM") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="140px" />
                                        <HeaderStyle Width="140px" />
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="REQUEST TO" FilterControlWidth="80px"
                                        SortExpression="STORE_NAME" UniqueName="STORE_NAME" AutoPostBackOnFilter="true" FilterCheckListEnableLoadOnDemand="true" CurrentFilterFunction="Contains">
                                        <EditItemTemplate>
                                            <telerik:RadDropDownList ID="ddlToStoreEdit" runat="server" DataSourceID="sqlToStoreSource"
                                                DataTextField="STORE_NAME" DataValueField="REQ_TO_STORE_ID" AppendDataBoundItems="true" Width="120px" DropDownWidth="200px" DropDownHeight="200px"
                                                SelectedValue='<%# Bind("REQ_TO_STORE_ID") %>'>
                                                <Items>
                                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                                </Items>
                                            </telerik:RadDropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="ToStoreLabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Width="140px" />
                                        <HeaderStyle Width="140px" />
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column"
                                        HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" ReadOnly="true"
                                        FilterControlWidth="40px" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="90px" />
                                        <HeaderStyle Width="90px" />
                                    </telerik:GridBoundColumn>

                                    <telerik:GridBoundColumn DataField="TRANSFER_PERCENT" FilterControlAltText="Filter TRANSFER_PERCENT column"
                                        HeaderText="TRANSFER %" SortExpression="TRANSFER_PERCENT" UniqueName="TRANSFER_PERCENT" ReadOnly="true"
                                        FilterControlWidth="40px" AutoPostBackOnFilter="true">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" 
                                        HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="true" 
                                        AutoPostBackOnFilter="true" FilterControlWidth="50px">
                                        <ItemStyle Width="150px" />
                                        <HeaderStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="STATUS_FLG" UniqueName="STATUS_FLG" HeaderText="STATUS FLG" SortExpression="STATUS_FLG"
                                        AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="40px">
                                        <ItemStyle Width="100px" />
                                        <HeaderStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <GroupingSettings CaseSensitive="false" />
                        </telerik:RadGrid>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="dsMaterialCTableAdapters.VIEW_MATERIAL_REQUESTTableAdapter"
        DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="MAT_REQ_NO" Type="String" />
            <asp:Parameter Name="MAT_REQ_DATE" Type="DateTime" />
            <asp:Parameter Name="AREA" Type="String" />
            <asp:Parameter Name="SUB_AREA" Type="String" />
            <asp:Parameter Name="USER_ID" Type="Decimal" />
            <asp:Parameter Name="REQ_FROM" Type="String" />
            <asp:Parameter Name="REQ_TO_STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="STATUS_FLG" Type="String" />


            <asp:Parameter Name="Original_MAT_REQ_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="MAT_REQ_NO" PropertyName="Text"
                Type="String" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="MailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT USER_NAME FROM USERS_PDF_MAIL_LIST"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDiscSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  * FROM DISCIPLINE_DEF  ORDER BY DISCIPLINE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlUserSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME,USER_ID FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlToStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  STORE_NAME,STORE_ID AS REQ_TO_STORE_ID FROM STORES_DEF ORDER BY STORE_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlFromStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  STORE_NAME AS REQ_FROM,STORE_ID FROM STORES_DEF ORDER BY STORE_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="areaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" 
         SelectCommand="SELECT distinct area_l3 AS AREA from amg_piping.ipms_area
                        UNION SELECT AREA  FROM MATERIAL_SUB_AREA ">        
            </asp:SqlDataSource>
    <asp:SqlDataSource ID="subAreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
         SelectCommand="SELECT DISTINCT AREA_L2  AS SUB_AREA from AMG_PIPING.IPMS_AREA 
                        UNION SELECT SUB_AREA  FROM MATERIAL_SUB_AREA ">
    </asp:SqlDataSource>

</asp:Content>

