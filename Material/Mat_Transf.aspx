<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Mat_Transf.aspx.cs" Inherits="Erection_MatIssueLoose" Title="Material Transfer" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        //<![CDATA[
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= IssueGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function upload_pdf() {
            try {
                var id = $find("<%=IssueGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("TRANSF_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=16&REF_ID=" + id, "RadWindow2", 650, 450);
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
            var grid = $find('<%= IssueGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            //var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 55 + "px";
            grid.get_element().style.width = width - 12 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
            //]]>
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div>
        <table style="background-color: gainsboro;" id="HeaderButtons">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New MTN" Width="100px" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Items" Width="80px" OnClick="btnViewMats_Click"></telerik:RadButton>
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
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnSendMail" runat="server" Text="Send Mail" OnClick="btnSendMail_Click" Width="100px"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnRCVstatus" runat="server" Text="Receive Flag" OnClick="btnRCVstatus_Click" Width="100px" Visible="false"></telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="IssueGridView" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <div>
        <telerik:RadGrid ID="IssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" AllowFilteringByColumn="true" PagerStyle-AlwaysVisible="true"
            DataSourceID="issueDataSource" PageSize="50" AllowSorting="true" onkeypress="handleSpace(event)"
            DataKeyNames="TRANSF_ID" OnItemDataBound="IssueGridView_ItemDataBound" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            OnItemCommand="IssueGridView_ItemCommand" OnDataBinding="IssueGridView_DataBinding" OnPreRender="itemsGrid_PreRender">
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
            <MasterTableView AutoGenerateColumns="false" EditMode="InPlace" DataSourceID="issueDataSource" DataKeyNames="TRANSF_ID" AllowMultiColumnSorting="true"
                PagerStyle-AlwaysVisible="true" AllowPaging="true" TableLayout="Fixed" ClientDataKeyNames="TRANSF_ID">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>

                    <telerik:GridButtonColumn ConfirmDialogType="RadWindow"
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
                    <telerik:GridBoundColumn DataField="DISCIPLINE" HeaderText="DISCIPLINE" SortExpression="DISCIPLINE"
                        FilterControlWidth="60px" AutoPostBackOnFilter="true" FilterControlAltText="DISCIPLINE" ReadOnly="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridBoundColumn DataField="TRANSF_NO" HeaderText="TRANSFER NO" SortExpression="TRANSF_NO"
                        FilterControlWidth="60px" AutoPostBackOnFilter="true" FilterControlAltText="TRANSF_NO">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column"
                        HeaderText="TRANSFER DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("CREATE_DATE") %>' Width="120px"></telerik:RadDatePicker>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="MAT_REQ_NO" HeaderText="TRANSFER REQ NO" SortExpression="MAT_REQ_NO"
                        AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="50px" ReadOnly="true">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="CREATE_BY" FilterControlAltText="Filter CREATE_BY column" HeaderText="CREATED BY"
                        SortExpression="CREATE_BY" UniqueName="CREATE_BY" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlUser" runat="server" DataSourceID="UserDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="CREATE_BY" DataValueField="CREATE_BY" Width="130px" AppendDataBoundItems="true"
                                SelectedValue='<%# Bind("CREATE_BY") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblUser" runat="server" Text='<%# Eval("CREATE_BY") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>

                    <%--     <telerik:GridTemplateColumn DataField="A_STORE" HeaderText="FROM STORE" SortExpression="A_STORE" FilterControlWidth="60px" FilterControlAltText="A_STORE"
                        AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList1" runat="server" DataSourceID="FromstoreDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="A_STORE" Width="130px"
                                DataValueField="A_STORE_ID" SelectedValue='<%# Bind("A_STORE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("A_STORE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="170px" />
                        <HeaderStyle Width="170px" />
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn DataField="A_STORE" FilterControlAltText="Filter A_STORE column" HeaderText="FROM STORE"
                        SortExpression="A_STORE" UniqueName="A_STORE" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList1" runat="server" DataSourceID="FromstoreDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="A_STORE" DataValueField="A_STORE_ID" Width="130px"
                                SelectedValue='<%# Bind("A_STORE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("A_STORE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="B_STORE" FilterControlAltText="Filter B_STORE column" HeaderText="TO STORE"
                        SortExpression="B_STORE" UniqueName="B_STORE" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="DropDownList12" runat="server" DataSourceID="storeDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="B_STORE" DataValueField="B_STORE_ID" Width="130px"
                                SelectedValue='<%# Bind("B_STORE_ID") %>'>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("B_STORE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" ReadOnly="true"
                        FilterControlWidth="50px"  AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECEIVE_PERCENT" HeaderText="RECEIVE %" SortExpression="RECEIVE_PERCENT" ReadOnly="true"
                        FilterControlWidth="50px" AllowFiltering="True" AutoPostBackOnFilter="true">
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="REMARKS" SortExpression="REMARKS" AllowFiltering="true" AutoPostBackOnFilter="true" FilterControlWidth="50px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="STATUS_FLG" HeaderText="STATUS FLG" SortExpression="STATUS_FLG" FilterControlWidth="60px"
                        AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="RECV_FLG" HeaderText="RECV FLG" SortExpression="RECV_FLG" FilterControlWidth="60px"
                        AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>



    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID AS B_STORE_ID, STORE_NAME AS B_STORE  FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="FromstoreDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID AS A_STORE_ID, STORE_NAME AS A_STORE  FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="issueDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialBTableAdapters.PIP_MAT_TRANSFTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="Original_TRANSF_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TRANSF_NO" Type="String" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="CREATE_BY" Type="String" />
            <asp:Parameter Name="A_STORE_ID" Type="Decimal" />
            <asp:Parameter Name="B_STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="STATUS_FLG" Type="String" />
            <asp:Parameter Name="RECV_FLG" Type="String" />
            <asp:Parameter Name="Original_TRANSF_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:SqlDataSource ID="MailDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT USER_NAME  FROM USERS_PDF_MAIL_LIST"></asp:SqlDataSource>
    <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME AS CREATE_BY FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>

</asp:Content>
