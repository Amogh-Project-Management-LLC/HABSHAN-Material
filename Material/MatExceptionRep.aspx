<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatExceptionRep.aspx.cs" Inherits="Material_MatExceptionRep" Title="ESD" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= ReportsGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        window.onresize = Test;
        window.onload = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= ReportsGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - divFooterButton - 35 + "px";
            grid.get_element().style.width = width - 15 + "px";
            grid.repaint();
        }
        function handleSpace(event) {
            var keyPressed = event.which || event.keyCode;
            if (keyPressed == 13) {
                event.preventDefault();
                event.stopPropagation();
            }
        }
        function upload_pdf() {
            try {
                var id = $find("<%=ReportsGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("EXCP_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=31&REF_ID=" + id, "RadWindow2", 650, 450);
            }
            catch (err) {
                txt = "Select any ESD!";
                alert(txt);
            }
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div>
        <table style="width: 100%; background-color: gainsboro;" id="HeaderButtons">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewReport" runat="server" Text="New ESD" Width="100" OnClick="btnNewReport_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewItems" runat="server" Text="Items" Width="80" OnClick="btnViewItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click"></telerik:RadButton>
                </td>
                <td>
                    <asp:LinkButton ID="linkPDFImport" runat="server" OnClientClick="upload_pdf(); return false;">
                        <telerik:RadButton ID="btnPDFImport" runat="server" Text="PDF Import" Width="110"></telerik:RadButton>
                    </asp:LinkButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnDownload" runat="server" Text="Download Files" Width="150px" OnClick="btnDownload_Click"></telerik:RadButton>
                </td>
                <td style="width: 100%; text-align: right;">
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>

    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="ReportsGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div>
        <telerik:RadGrid ID="ReportsGridView" runat="server" DataSourceID="MatExceptionDataSource" AllowFilteringByColumn="True" MasterTableView-EditMode="InPlace"
            OnEditCommand="ReportsGridView_EditCommand" AllowPaging="true" PageSize="15" AllowSorting="true" PagerStyle-AlwaysVisible="true"
            onkeypress="handleSpace(event)" OnItemCommand="ReportsGridView_ItemCommand" OnDataBinding="ReportsGridView_DataBinding" OnPreRender="itemsGrid_PreRender"
            OnItemDataBound="ReportsGridView_ItemDataBound" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
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
            <MasterTableView AutoGenerateColumns="False" DataSourceID="MatExceptionDataSource" DataKeyNames="EXCP_ID" ClientDataKeyNames="EXCP_ID"
                AllowMultiColumnSorting="true" TableLayout="Fixed">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridTemplateColumn ItemStyle-Width="15px" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="35px" />
                        <HeaderStyle Width="35px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="REP_NO" AllowFiltering="true" FilterControlAltText="Filter REP_NO column"
                        HeaderText="ESD REPORT NO" SortExpression="REP_NO" UniqueName="REP_NO" AutoPostBackOnFilter="true">
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="REP_DATE" DataType="System.DateTime" FilterControlAltText="Filter REP_DATE column"
                        HeaderText="REPORT DATE" SortExpression="REP_DATE" UniqueName="REP_DATE" AutoPostBackOnFilter="true" FilterControlWidth="60px">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DbSelectedDate='<%# Bind("REP_DATE") %>' DateInput-DateFormat="dd-MMM-yyyy"></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REP_DATELabel" runat="server" Text='<%# Eval("REP_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="MAT_RCV_NO" FilterControlAltText="Filter MAT_RCV_NO column" HeaderText="MRIR NO/TRANSF_RCV NO" SortExpression="MAT_RCV_NO" UniqueName="MAT_RCV_NO" AutoPostBackOnFilter="true" ReadOnly="True">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboMR1" runat="server" AppendDataBoundItems="True" DataSourceID="mrDataSource"
                                DataTextField="MAT_RCV_NO" DataValueField="MAT_RCV_ID" SelectedValue='<%# Bind("MAT_RCV_ID") %>'
                                Width="112px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="MAT_RCV_NOLabel" runat="server" Text='<%# Eval("MAT_RCV_NO") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="250px" />
                        <HeaderStyle Width="250px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="TYPE_NAME" AllowFiltering="true" FilterControlAltText="Filter TYPE_NAME column" FilterControlWidth="60px"
                        HeaderText="ESD REPORT TYPE" SortExpression="TYPE_NAME" UniqueName="TYPE_NAME" AutoPostBackOnFilter="true" ReadOnly="True">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PO_NO" AllowFiltering="true" FilterControlAltText="Filter PO_NO column" FilterControlWidth="60px"
                        HeaderText="PO_NO" SortExpression="PO_NO" UniqueName="PO_NO" AutoPostBackOnFilter="true" ReadOnly="True">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATE BY" ReadOnly="true"
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
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" AllowFiltering="false" FilterControlAltText="Filter ITEM_COUNT column"
                        HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" ReadOnly="True">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="FROM STORE"
                        SortExpression="STORE_NAME" UniqueName="STORE_NAME" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList1" runat="server" DataSourceID="storeDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" Width="130px"
                                SelectedValue='<%# Bind("STORE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" AllowFiltering="false" FilterControlAltText="Filter REMARKS column"
                        HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                </Columns>

            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <div style="background-color: gainsboro" id="divFooterHeight">
        <table>
            <tr>
                <td>
                    <div id="footerDiv">
                        <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
                    </div>
                </td>
                <td>
                    <telerik:RadButton ID="btnYes" runat="server" Text="Yes" Width="50px" OnClick="btnYes_Click" Visible="False" EnableViewState="false" Skin="Sunset"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnNo" runat="server" Text="No" Width="50px" Visible="False" EnableViewState="false" Skin="Telerik"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>

    <asp:ObjectDataSource ID="MatExceptionDataSource" runat="server" SelectMethod="GetData"
        TypeName="dsPO_ShipmentATableAdapters.PIP_MAT_EXCEPTION_REPTableAdapter" UpdateMethod="UpdateQuery"
        DeleteMethod="DeleteQuery" OldValuesParameterFormatString="original_{0}">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="REP_NO" Type="String" />
            <asp:Parameter Name="REP_DATE" Type="DateTime" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_EXCP_ID" Type="Decimal" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="original_EXCP_ID" Type="Decimal" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="mrDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT MIR_ID AS MAT_RCV_ID, MIR_NO AS MAT_RCV_NO FROM PRC_MAT_INSP WHERE (PROJ_ID = :PROJECT_ID) ORDER BY MIR_NO'>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID , STORE_NAME   FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlUserSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand='SELECT USER_ID,USER_NAME AS CREATE_BY FROM USERS  ORDER BY USER_NAME'></asp:SqlDataSource>
</asp:Content>
