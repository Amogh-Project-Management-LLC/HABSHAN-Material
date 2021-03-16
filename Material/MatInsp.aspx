<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="MatInsp.aspx.cs" Inherits="Material_MatInsp" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            function RowDblClick(sender, eventArgs) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= grdMRIR.ClientID %>").get_masterTableView().editItem(editedRow);
            }
            function upload_pdf() {
                try {
                    var id = $find("<%=grdMRIR.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MIR_ID");
                    radopen("../Common/FileImport.aspx?TYPE_ID=13&REF_ID=" + id, "RadWindow2", 650, 450);
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
            //]]>

            window.onresize = Test;
            Sys.Application.add_load(Test);
            function Test() {
                var grid = $find('<%= grdMRIR.ClientID %>')
                var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
                var width = document.getElementById("PageHeader").clientWidth
                var divHeight = document.getElementById("PageHeader").clientHeight
                var divButton = document.getElementById("HeaderButtons").clientHeight
                //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
                var divFooter = document.getElementById("footerDiv").clientHeight
                grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
                grid.get_element().style.width = width + "px";
                grid.repaint();
            }
        </script>
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    </telerik:RadCodeBlock>
    <div style="background-color: whitesmoke;" id="HeaderButtons">
        <table style="width: 100%">
            <tr>
                <td>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="New MRIR" Width="110"></telerik:RadButton>
                    <telerik:RadButton ID="btnMaterial" runat="server" Text="Items" Width="80" OnClick="btnMaterial_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="110" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnGenerateBarcode" runat="server" Text="Generate Barcode" Width="150" OnClick="btnGenerateBarcode_Click"></telerik:RadButton>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
                    <telerik:RadButton ID="RadCreateESD" runat="server" Text="Create ESD" Width="140px" OnClick="RadCreateESD_Click"></telerik:RadButton>

                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" EmptyMessage="Search MRIR...." Width="250px" Visible="false"
                        AutoPostBack="true">
                    </telerik:RadTextBox>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="grdMRIR" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="min-height: 20px">
                <telerik:RadGrid ID="grdMRIR" runat="server" OnSelectedIndexChanged="grdMRIR_SelectedIndexChanged" CellSpacing="-1" DataSourceID="itemsDataSource"
                    AllowAutomaticDeletes="True" AllowAutomaticUpdates="True" AllowPaging="True" OnItemDataBound="grdMRIR_ItemDataBound" onkeypress="handleSpace(event)"
                    PageSize="50" Font-Size="9pt" MasterTableView-EditMode="InPlace" AllowSorting="true" AllowFilteringByColumn="true" PagerStyle-AlwaysVisible="true"
                    OnItemCommand="grdMRIR_ItemCommand" OnDataBinding="grdMRIR_DataBinding" OnPreRender="itemsGrid_PreRender"
                    EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
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
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="MIR_ID" AllowMultiColumnSorting="true"
                        ClientDataKeyNames="MIR_ID" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />

                        <Columns>
                            <%--<telerik:GridClientDeleteColumn ButtonType="ImageButton" ConfirmTitle="Confirm" ConfirmText="Are you sure you want to Delete this record ?"
                         CommandName="Delete"></telerik:GridClientDeleteColumn>--%>
                            <telerik:GridEditCommandColumn ButtonType="ImageButton">
                                <ItemStyle Width="55px" />
                                <HeaderStyle Width="55px" />
                            </telerik:GridEditCommandColumn>
                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
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

                            <telerik:GridBoundColumn DataField="DISCIPLINE" AllowFiltering="true" FilterControlAltText="Filter DISCIPLINE column" ReadOnly="true"
                                HeaderText="DISCIPLINE" SortExpression="DISCIPLINE" UniqueName="DISCIPLINE" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                <ItemStyle Width="140px" />
                                <HeaderStyle Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="MIR_NO" AllowFiltering="true" FilterControlAltText="Filter MIR_NO column"
                                HeaderText="MRIR NUMBER" SortExpression="MIR_NO" UniqueName="MIR_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridBoundColumn DataField="CLIENT_MRIR_NO" AllowFiltering="true" FilterControlAltText="Filter CLIENT_MRIR_NO column"
                                HeaderText="CLIENT MRIR NO" SortExpression="CLIENT_MRIR_NO" UniqueName="CLIENT_MRIR_NO" AutoPostBackOnFilter="true">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RFI_NO" AllowFiltering="true" FilterControlAltText="Filter RFI_NO column" ReadOnly="true"
                                HeaderText="RFI_NO" SortExpression="RFI_NO" UniqueName="RFI_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                <ItemStyle Width="140px" />
                                <HeaderStyle Width="140px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SHIP_NO" AllowFiltering="true" FilterControlAltText="Filter SHIP_NO column" 
                                HeaderText="SHIP_NO" SortExpression="SHIP_NO" UniqueName="SHIP_NO" AutoPostBackOnFilter="true" FilterControlWidth="80px">
                                <ItemStyle Width="140px" />
                                <HeaderStyle Width="140px" />
                            </telerik:GridBoundColumn>
                           
                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="INSP_DATE" DataType="System.DateTime"
                                FilterControlAltText="Filter INSP_DATE column" HeaderText="INSP DATE" SortExpression="INSP_DATE" UniqueName="INSP_DATE">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtInspDateEdit" runat="server" DbSelectedDate='<%# Bind("INSP_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy" Width="100px">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="INSP_DATELabel" runat="server" Text='<%# Eval("INSP_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="110px" />
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="RECEIVE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtCreateDateEdit" runat="server" DbSelectedDate='<%# Bind("CREATE_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy" Width="100px">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="110px" />
                                <HeaderStyle Width="110px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridTemplateColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATE BY"
                                SortExpression="CREATE_BY" UniqueName="CREATE_BY" AutoPostBackOnFilter="true">
                                <EditItemTemplate>
                                    <telerik:RadDropDownList ID="ddlDiscEdit" runat="server" DataSourceID="sqlUserSource"
                                        DataTextField="CREATE_BY" DataValueField="CREATE_BY" AppendDataBoundItems="true"
                                        SelectedValue='<%# Bind("CREATE_BY") %>'>
                                        <Items>
                                            <telerik:DropDownListItem Text="(Select)" Value="" />
                                        </Items>
                                    </telerik:RadDropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CREATE_BYLabel" runat="server" Text='<%# Eval("CREATE_BY") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="180px" />
                                <HeaderStyle Width="180px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="PO_NO" AllowFiltering="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                                SortExpression="PO_NO" UniqueName="PO_NO" ReadOnly="true">
                                <ItemStyle Width="150px" />
                                <HeaderStyle Width="150px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="VENDOR_NAME" ReadOnly="true" FilterControlAltText="Filter VENDOR_NAME column" HeaderText="PO VENDOR NAME" SortExpression="VENDOR_NAME" UniqueName="VENDOR_NAME"
                                FilterControlWidth="80px" AutoPostBackOnFilter="true">
                                <HeaderStyle Width="150px" />
                                <ItemStyle Width="150px" />
                            </telerik:GridBoundColumn>
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
                                <HeaderStyle Width="135px" />
                                <ItemStyle Width="135px" />
                            </telerik:GridTemplateColumn>

                            <%--  <telerik:GridBoundColumn DataField="PDF_FLG" AllowFiltering="false" FilterControlAltText="Filter PDF_FLG column" HeaderText="PDF FLG" SortExpression="PDF_FLG" UniqueName="PDF_FLG" ReadOnly="true">
                            </telerik:GridBoundColumn>--%>
                            <telerik:GridBoundColumn DataField="ITEM_COUNT" AllowFiltering="false" FilterControlAltText="Filter ITEM_COUNT column"
                                HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" ReadOnly="true">
                                <ItemStyle Width="100px" />
                                <HeaderStyle Width="100px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" AllowFiltering="false" FilterControlAltText="Filter REMARKS column"
                                HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>

                        </Columns>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn1 column" UniqueName="EditCommandColumn1">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </div>

            <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" InsertMethod="InsertQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.VIEW_ADAPTER_MIRTableAdapter" UpdateMethod="UpdateQuery">
                <DeleteParameters>
                    <asp:Parameter Name="original_MIR_ID" Type="Decimal" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PROJ_ID" Type="Decimal" />
                    <asp:Parameter Name="MIR_NO" Type="String" />
                    <asp:Parameter Name="INSP_DATE" Type="DateTime" />
                    <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
                    <asp:Parameter Name="CREATE_BY" Type="String" />
                    <asp:Parameter Name="PO_ID" Type="Decimal" />
                    <asp:Parameter Name="MRV_ID" Type="Decimal" />
                    <asp:Parameter Name="STORE_ID" Type="Decimal" />
                    <asp:Parameter Name="PDF_FLG" Type="String" />
                    <asp:Parameter Name="REMARKS" Type="String" />
                    <asp:Parameter Name="SRN_NO" Type="String" />
                    <asp:Parameter Name="SHIP_NO" Type="String" />
                    <asp:Parameter Name="MODE_OF_SHIPMENT" Type="String" />
                    <asp:Parameter Name="INVOICE_NO" Type="String" />
                    <asp:Parameter Name="PKG_LIST_NO" Type="String" />
                    <asp:Parameter Name="BL_AWB_TWBNO" Type="String" />
                    <asp:Parameter Name="MRIR_SC_ID" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="-1" Name="PROJ_ID" SessionField="PROJECT_ID" Type="Decimal" />
                    <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" Type="String" />
                    <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="MIR_NO" Type="String" />
                    <asp:Parameter Name="CLIENT_MRIR_NO" Type="String" />
                    <asp:Parameter Name="SHIP_NO" Type="String" />
                    <asp:Parameter Name="INSP_DATE" Type="DateTime" />
                    <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
                    <asp:Parameter Name="CREATE_BY" Type="String" />
                    <asp:Parameter Name="STORE_ID" Type="Decimal" />
                    <asp:Parameter Name="REMARKS" Type="String" />
                    <asp:Parameter Name="original_MIR_ID" Type="Decimal" />
                </UpdateParameters>
            </asp:ObjectDataSource>
            <asp:SqlDataSource ID="sqlExportMIR" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MIR_NO, INSP_DATE, CREATE_DATE, PO_NO,PO_ITEM, MIR_ITEM, MRV_NUMBER, SRN_NO, SHIP_NO, SUPPLIER_VENDORNAME, MODE_OF_SHIPMENT, INVOICE_NO,
                                PKG_LIST_NO, BL_AWB_TWBNO, STORE_NAME, SUB_CON_NAME, SUBSTORE, MAT_CODE1, MAT_CODE2, SIZE_DESC, WALL_THK,
                                ITEM_NAM, MAT_DESCR, UOM, RCV_QTY, ACPT_QTY, AS_PER_PL_QTY, REJ_QTY, HEAT_NO, PAINT_SYS, ESD_NO, MISSING_QTY, DAMAGE_QTY,
                                EXCESS_QTY, CLEAR_QTY, TC_CODE, CEVALUE, REMARKS
                                FROM VIEW_MRIR_ESD
                                WHERE MIR_ID = :MIR_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="grdMRIR" DefaultValue="-1" Name="MIR_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="sqlExportMIRAll" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MIR_NO, INSP_DATE, CREATE_DATE, PO_NO,PO_ITEM, MIR_ITEM, MRV_NUMBER, SRN_NO, SHIP_NO, SUPPLIER_VENDORNAME, MODE_OF_SHIPMENT, INVOICE_NO,
                            PKG_LIST_NO, BL_AWB_TWBNO, STORE_NAME, SUB_CON_NAME, SUBSTORE, MAT_CODE1, MAT_CODE2, SIZE_DESC, WALL_THK,
                            ITEM_NAM, MAT_DESCR, UOM, RCV_QTY, ACPT_QTY, AS_PER_PL_QTY, REJ_QTY, HEAT_NO, PAINT_SYS, ESD_NO, MISSING_QTY, DAMAGE_QTY,
                            EXCESS_QTY, CLEAR_QTY, TC_CODE, CEVALUE, REMARKS
                            FROM VIEW_MRIR_ESD
                            ORDER BY MIR_NO, MIR_ITEM"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT MAT_ID, MIR_ITEM AS ID FROM PRC_MAT_INSP_DETAIL WHERE MIR_ID = :MIR_ID">
                <SelectParameters>
                    <asp:ControlParameter ControlID="grdMRIR" DefaultValue="-1" Name="MIR_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <%-- <div style="background-color: whitesmoke" id="divFooterHeight">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnUploadPDF" runat="server" Text="Upload PDF" Width="120" Icon-PrimaryIconUrl="~/Images/icons/icon-upload.png">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnExport" runat="server" Text="Export" Width="110" Icon-PrimaryIconUrl="~/Images/icons/icon-save2.png" OnClick="btnExport_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnExportAll" runat="server" Text="Export All" Width="110"
                        Icon-PrimaryIconUrl="~/Images/icons/icon-save2.png" OnClick="btnExportAll_Click">
                    </telerik:RadButton>
                </td>

            </tr>
        </table>
    </div>--%>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlUserSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT USER_ID,USER_NAME AS CREATE_BY FROM USERS  ORDER BY USER_NAME'></asp:SqlDataSource>

</asp:Content>



