<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="POInsp.aspx.cs" Inherits="Procurement_POInsp" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            //<![CDATA[
            function RowDblClick(sender, eventArgs) {
                editedRow = eventArgs.get_itemIndexHierarchical();
                $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
            }
            function upload_pdf() {
                try {
                    var id = $find("<%=itemsGrid.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("RFI_ID");
                    radopen("../Common/FileImport.aspx?TYPE_ID=10&REF_ID=" + id, "RadWindow2", 650, 450);
                }
                catch (err) {
                    txt = "Select any Transmittal!";
                    alert(txt);
                }
            }
            function handleSpace(sender, eventArgs) {
                var keyPressed = event.which || event.keyCode;
                if (keyPressed == 13) {
                    editedRow = eventArgs.get_itemIndexHierarchical();
                    $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
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
                var divButton = document.getElementById("HeaderButtons").clientHeight
                //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
                var divFooter = document.getElementById("footerDiv").clientHeight
                //var TestIDHeight = document.getElementById("TestID").clientHeight

                //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
                grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
                //grid.get_element().style.height = (height) - 262 + "px";
                grid.repaint();
            }
            //]]>
        </script>

    </telerik:RadCodeBlock>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <telerik:RadButton runat="server" ID="btnNew" Text="New RFI" Width="100px"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnMat" Text="Material" Width="100px" OnClick="btnMat_Click"></telerik:RadButton>
        <telerik:RadButton runat="server" ID="btnAddMat" Text="Add Material" Width="100px" OnClick="btnAddMat_Click"></telerik:RadButton>
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
        <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" 
            AllowFilteringByColumn="true" PageSize="50" AllowSorting="true" OnItemDataBound="itemsGrid_ItemDataBound" AllowPaging="true"
            OnDataBinding="itemsGrid_DataBinding1" OnItemCommand="itemsGrid_ItemCommand" onkeypress="handleSpace(event)" OnPreRender="itemsGrid_PreRender"
            EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
            <GroupingSettings CollapseAllTooltip="Collapse all groups"></GroupingSettings>
            <ClientSettings>
                <Selecting AllowRowSelect="True"></Selecting>
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>
            <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" EditMode="InPlace"
                DataKeyNames="RFI_ID" AllowMultiColumnSorting="true" ClientDataKeyNames="RFI_ID" AllowPaging="true" PagerStyle-AlwaysVisible="true"
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
                    <telerik:GridBoundColumn DataField="DISCIPLINE" ReadOnly="true" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE"
                        SortExpression="DISCIPLINE" UniqueName="DISCIPLINE" AllowFiltering="false">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RFI_NO" FilterControlAltText="Filter RFI_NO column" HeaderText="RFI NUMBER"
                        SortExpression="RFI_NO" UniqueName="RFI_NO" AutoPostBackOnFilter="true" FilterControlWidth="100px" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="RFI_DATE" DataType="System.DateTime" FilterControlAltText="Filter RFI_DATE column"
                        HeaderText="RFI CREATE DATE" SortExpression="RFI_DATE" UniqueName="RFI_DATE" AllowFiltering="false" ReadOnly="true">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtRFIDateEdit" runat="server" SelectedDate='<%# Bind("RFI_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RFI_DATELabel" runat="server" Text='<%# Eval("RFI_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="RFI_REPORT_NO" FilterControlAltText="Filter RFI_REPORT_NO column" HeaderText="RFI REPORT NUMBER"
                        SortExpression="RFI_REPORT_NO" UniqueName="RFI_REPORT_NO" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="RFI_REPORT_DATE" DataType="System.DateTime"
                        FilterControlAltText="Filter RFI_REPORT_DATE column" HeaderText="RFI REPORT DATE" SortExpression="RFI_REPORT_DATE"
                        UniqueName="RFI_REPORT_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtRFIDateEdit2" runat="server" DbSelectedDate='<%# Bind("RFI_REPORT_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RFI_DATELabel2" runat="server" Text='<%# Eval("RFI_REPORT_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="110px" />
                        <HeaderStyle Width="110px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="PO_NO" ReadOnly="true" FilterControlAltText="Filter PO_NO column" HeaderText="PO NUMBER"
                        SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" FilterControlWidth="100px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_VEND_NAME" ReadOnly="true" FilterControlAltText="Filter PO_VEND_NAME column" HeaderText="PO VENDOR"
                        SortExpression="PO_VEND_NAME" UniqueName="PO_VEND_NAME" AllowFiltering="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <%--  <telerik:GridBoundColumn DataField="CREATE_DATE" DataFormatString="{0:dd-MMM-yyyy}" ReadOnly="true" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column" HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE">
                    </telerik:GridBoundColumn>--%>
                </Columns>
                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"></EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" DeleteMethod="DeleteQuery" UpdateMethod="UpdateQuery" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_CTableAdapters.VIEW_PO_INSP_REQUESTTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="original_RFI_ID" Type="Decimal" />
        </DeleteParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RFI_REPORT_NO" Type="String" />
            <asp:Parameter Name="RFI_REPORT_DATE" Type="DateTime" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_RFI_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
</asp:Content>

