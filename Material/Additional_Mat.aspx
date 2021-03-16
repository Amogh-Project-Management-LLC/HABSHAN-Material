<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Additional_Mat.aspx.cs" Inherits="Erection_MatIssueLoose" Title="Additional Mat Issue" %>

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
                var id = $find("<%=IssueGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("ADD_ISSUE_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=15&REF_ID=" + id, "RadWindow2", 650, 450);
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
            var divHeight = document.getElementById("PageHeader").clientHeight
            var width = document.getElementById("PageHeader").clientWidth
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooterButton = document.getElementById("divFooterHeight").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            //var TestIDHeight = document.getElementById("TestID").clientHeight

            //document.getElementById("TestID").innerHTML = "height:" + height + "/PageHeader:" + divHeight + "/HeaderButtons:" + divButton + "/FooterDiv:" + divFooter+"/TestID:" + TestIDHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - divFooterButton - 60 + "px";
            grid.get_element().style.width = width - 15 + "px";
            //grid.get_element().style.height = (height) - 262 + "px";
            grid.repaint();
        }
            //]]>
    </script>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div id="HeaderButtons">
        <table style="width: 100%; background-color: gainsboro">
            <tr>
                <td>
                    <telerik:RadButton ID="btnNewIssue" runat="server" Text="New MIV" Width="100" OnClick="btnNewIssue_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPipeRemain" runat="server" Text="Remain" Width="80" OnClick="btnPipeRemain_Click" Visible="false"></telerik:RadButton>
                </td>
                <%--    <td>
                    <telerik:RadButton ID="btnBOM" runat="server" Text="BOM" Width="80" OnClick="btnBOM_Click"></telerik:RadButton>
                </td>--%>
                <td>
                    <telerik:RadButton ID="btnViewMats" runat="server" Text="Items" Width="80" OnClick="btnViewMats_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadDropDownList ID="ddReports" runat="server" Width="200px">
                        <Items>
                            <telerik:DropDownListItem Value="11" Text="Bulk Material Report" Selected="true" />
                            <telerik:DropDownListItem Value="12" Text="Use Remains Report" />
                            <%-- <telerik:DropDownListItem Value="12.1" Text="Bill of Materials Report" />--%>
                        </Items>
                    </telerik:RadDropDownList>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="100" OnClick="btnPreview_Click"></telerik:RadButton>
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
                    <telerik:RadButton ID="btnImportExcel" runat="server" Text="Bulk MIV Import" Width="150px" OnClick="btnImportExcel_Click"></telerik:RadButton>
                </td>

                <td style="width: 100%; text-align: right;">
                    <telerik:RadTextBox ID="txtSearch" runat="server" AutoPostBack="True" EmptyMessage="Search Here"
                        OnTextChanged="txtSearch_TextChanged" Width="200px" Visible="false">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <asp:DropDownList ID="PageList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="PageList_SelectedIndexChanged" Visible="false"
                        Width="137px">
                    </asp:DropDownList>
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
        <telerik:RadGrid ID="IssueGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False"
            DataSourceID="issueDataSource" PageSize="50" Width="100%" AllowFilteringByColumn="true" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true"
            OnRowEditing="LooseIssueGridView_RowEditing" onkeypress="handleSpace(event)" OnDataBound="IssueGridView_DataBound" AllowSorting="true" OnItemDataBound="IssueGridView_ItemDataBound"
            DataKeyNames="ADD_ISSUE_ID" OnItemCommand="IssueGridView_ItemCommand" OnDataBinding="IssueGridView_DataBinding" OnPreRender="itemsGrid_PreRender">
            <ClientSettings Selecting-AllowRowSelect="true">
                <Selecting AllowRowSelect="true" />
                <Scrolling AllowScroll="true" UseStaticHeaders="true" />
            </ClientSettings>
            <ClientSettings AllowKeyboardNavigation="true">
                <KeyboardNavigationSettings EnableKeyboardShortcuts="true" AllowSubmitOnEnter="true"
                    AllowActiveRowCycle="true" CollapseDetailTableKey="LeftArrow" ExpandDetailTableKey="RightArrow"></KeyboardNavigationSettings>
                <ClientEvents OnRowDblClick="RowDblClick"></ClientEvents>
            </ClientSettings>

            <MasterTableView EditMode="InPlace" DataKeyNames="ADD_ISSUE_ID" AllowMultiColumnSorting="true" ClientDataKeyNames="ADD_ISSUE_ID" PagerStyle-AlwaysVisible="true">
                <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="55px" />
                        <HeaderStyle Width="55px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmDialogType="RadWindow">

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

                    <telerik:GridTemplateColumn DataField="DISCIPLINE" FilterControlAltText="Filter DISCIPLINE column" HeaderText="DISCIPLINE"
                        SortExpression="DISCIPLINE" UniqueName="DISCIPLINE" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditDiscipline" runat="server" DataSourceID="sqlDisciplineSource"
                                DataTextField="DISCIPLINE" DataValueField="DISCIPLINE_ID" AppendDataBoundItems="true" DropDownHeight="200px" DropDownWidth="200px" Width="120px"
                                SelectedValue='<%# Bind("DISCIPLINE_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="DISCIPLINELabel" runat="server" Text='<%# Eval("DISCIPLINE") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="ISSUE_NO" FilterControlAltText="Filter ISSUE_NO column" HeaderText="ISSUE NO"
                        SortExpression="ISSUE_NO" UniqueName="ISSUE_NO" AutoPostBackOnFilter="true"
                        FilterControlWidth="70px">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REFERENCE_NO" FilterControlAltText="Filter REFERENCE_NO column" HeaderText="SUB AREA"
                        SortExpression="REFERENCE_NO" UniqueName="REFERENCE_NO" AutoPostBackOnFilter="true"
                        FilterControlWidth="70px">
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn DataField="ISSUE_DATE" UniqueName="ISSUE_DATE"  HeaderText="ISSUE DATE" SortExpression="ISSUE_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("ISSUE_DATE") %>' Width="120px"></telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Bind("ISSUE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="ISSUE_BY" FilterControlAltText="Filter ISSUE_BY column" HeaderText="ISSUE BY"
                        SortExpression="ISSUE_BY" UniqueName="ISSUE_BY" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditISSUE_BY" runat="server" DataSourceID="sqlUserSource"
                                DataTextField="ISSUE_BY" DataValueField="ISSUE_BY" AppendDataBoundItems="true" DropDownHeight="200px" DropDownWidth="200px" Width="120px"
                                SelectedValue='<%# Bind("ISSUE_BY") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="ISSUE_BYLabel" runat="server" Text='<%# Eval("ISSUE_BY") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn DataField="SUB_CON_NAME" FilterControlAltText="Filter SUB_CON_NAME column" HeaderText="SUBCON"
                        SortExpression="SUB_CON_NAME" UniqueName="SUB_CON_NAME" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditSUB_CON_NAME" runat="server" DataSourceID="sqlSubconSource"
                                DataTextField="SUB_CON_NAME" DataValueField="SC_ID" AppendDataBoundItems="true" DropDownHeight="200px" DropDownWidth="200px" Width="120px"
                                SelectedValue='<%# Bind("SC_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="SUB_CON_NAMELabel" runat="server" Text='<%# Eval("SUB_CON_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                     <telerik:GridTemplateColumn DataField="REF_SUBCON" FilterControlAltText="Filter REF_SUBCON column" HeaderText="REF SUBCON"
                        SortExpression="REF_SUBCON" UniqueName="REF_SUBCON" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditREF_SUBCON" runat="server" DataSourceID="sqlRefSubconSource"
                                DataTextField="REF_SUBCON" DataValueField="REF_SC_ID" AppendDataBoundItems="true" DropDownHeight="200px" DropDownWidth="200px" Width="120px"
                                SelectedValue='<%# Bind("REF_SC_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="REF_SUBCONLabel" runat="server" Text='<%# Eval("REF_SUBCON") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="STORE_NAME" FilterControlAltText="Filter STORE_NAME column" HeaderText="STORE"
                        SortExpression="STORE_NAME" UniqueName="STORE_NAME" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlEditSTORE_NAME" runat="server" DataSourceID="sqlStoreSource"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" AppendDataBoundItems="true" DropDownHeight="200px" DropDownWidth="200px" Width="120px"
                                SelectedValue='<%# Bind("STORE_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="STORE_NAMELabel" runat="server" Text='<%# Eval("STORE_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT"
                        SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" AllowFiltering="false" ReadOnly="true">
                        <ItemStyle Width="70px" />
                        <HeaderStyle Width="70px" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS"
                        SortExpression="REMARKS" UniqueName="REMARKS" AutoPostBackOnFilter="true"
                        FilterControlWidth="70px">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>

    <div style="background-color: gainsboro;" id="divFooterHeight">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnDelete" runat="server" Text="Delete" Width="80" OnClick="btnDelete_Click"></telerik:RadButton>
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

    <asp:SqlDataSource ID="SubconDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT SUB_CON_ID, SUB_CON_NAME FROM SUB_CONTRACTOR
WHERE PROJ_ID = :PROJECT_ID
ORDER BY SUB_CON_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID, STORE_NAME FROM STORES_DEF WHERE PROJECT_ID = :PROJECT_ID ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ObjectDataSource ID="issueDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterial_IssueATableAdapters.PIP_MAT_ISUE_ADDTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>

            <asp:Parameter Name="DISCIPLINE_ID" Type="Decimal" />
            <asp:Parameter Name="ISSUE_NO" Type="String" />
            <asp:Parameter Name="REFERENCE_NO" Type="String" />
            <asp:Parameter Name="ISSUE_DATE" Type="DateTime" />
            <asp:Parameter Name="ISSUE_BY" Type="String" />
            <asp:Parameter Name="SC_ID" Type="Decimal" />
            <asp:Parameter Name="REF_SC_ID" Type="Decimal" />
            <asp:Parameter Name="STORE_ID" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="original_ADD_ISSUE_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="%" Name="FILTER" PropertyName="Text" Type="String" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="catDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand='SELECT "CAT_ID", "CATEGORY" FROM "PIP_MAT_ISSUE_ADD_CAT"'></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDisciplineSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT DISCIPLINE, DISCIPLINE_ID 
FROM DISCIPLINE_DEF
ORDER BY DISCIPLINE"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlUserSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME as ISSUE_BY,USER_ID FROM USERS"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  SUB_CON_NAME,SUB_CON_ID as SC_ID FROM SUB_CONTRACTOR"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlStoreSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  * FROM STORES_DEF"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlRefSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  SUB_CON_NAME AS REF_SUBCON,SUB_CON_ID as REF_SC_ID FROM REF_SUB_CONTRACTOR"></asp:SqlDataSource>
    
</asp:Content>

