<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="IRN.aspx.cs" Inherits="Procurement_IRN" Title="IRN" EnableSessionState="ReadOnly"%>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
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
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 60 + "px";
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
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= itemsGrid.ClientID %>").get_masterTableView().editItem(editedRow);
        }
    </script>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    <div style="background-color: whitesmoke" id="HeaderButtons">
        <table>
            <tr>
                <td>
                    <telerik:RadButton ID="btnNew" runat="server" Text="New IRN" Width="100px" OnClick="btnNew_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnItems" runat="server" Text="Item List" Width="120px" OnClick="btnItems_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnView" runat="server" Text="View" Width="80px" OnClick="btnView_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="120px" OnClick="btnPreview_Click"></telerik:RadButton>
                    <telerik:RadButton ID="RadButton1" runat="server" Text="Upload IRN" OnClick="RadButton1_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/go-up.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="RadButton2" runat="server" Text="Upload IR Files" OnClick="RadButton2_Click">
                        <Icon PrimaryIconUrl="../Images/New-Icons/go-up.png" />
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnDownloadIR" runat="server" Text="Download IR Files" Width="150px" OnClick="btnDownloadIR_Click"></telerik:RadButton>
                    <telerik:RadButton ID="btnVendorData" runat="server" Text="MTC" Width="80px" OnClick="btnVendorData_Click"></telerik:RadButton>
                    <telerik:RadButton ID="bulkIrnImport" runat="server" Text="Bulk IRN Import" Width="200px" OnClick="bulkIrnImport_Click">
                        <Icon PrimaryIconUrl="../Images/icons/excel.png" />
                    </telerik:RadButton>

                </td>
                <td>
                    <table runat="server" id="tblUpload" visible="false">
                        <tr>
                            <td>Select IRN File:
                            </td>
                            <td>
                                <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="false" />
                            </td>
                            <td>
                                <asp:Button ID="btnUpload" runat="server" Text="Save" OnClick="btnUpload_Click" />
                                <asp:Button ID="btnHide" runat="server" Text="Hide" OnClick="btnHide_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table runat="server" id="tblUpload2" visible="false">
                        <tr>
                            <td>Select IR Files:
                            </td>
                            <td>
                                <input type="file" id="myfile" multiple="multiple" name="myfile" runat="server" size="100" />
                                <asp:Button ID="Button1" runat="server" Text="Save" OnClick="btnUpload2_Click" />
                                <asp:Button ID="Button2" runat="server" Text="Hide" OnClick="btnHide_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="text-align: right">
                    <telerik:RadTextBox ID="txtSearch" runat="server" Width="250px" EmptyMessage="IRN" AutoPostBack="true" Visible="false"></telerik:RadTextBox>
                </td>

            </tr>
        </table>
    </div>
    <telerik:RadPersistenceManager ID="RadPersistenceManager1" runat="server">
        <PersistenceSettings>
            <telerik:PersistenceSetting ControlID="itemsGrid" />
        </PersistenceSettings>
    </telerik:RadPersistenceManager>
    <asp:UpdatePanel ID="UpdatePanelGrid" runat="server">
        <ContentTemplate>
            <div style="margin-top: 3px">
                <telerik:RadGrid ID="itemsGrid" runat="server" CellSpacing="-1" DataSourceID="itemsDataSource" GridLines="None" AllowPaging="true" PagerStyle-AlwaysVisible="true"
                    AllowSorting="true" PageSize="50" AllowFilteringByColumn="true" OnDataBinding="itemsGrid_DataBinding" OnItemDataBound="itemsGrid_ItemDataBound" OnItemCommand="itemsGrid_ItemCommand" OnPreRender="itemsGrid_PreRender"
                    AllowAutomaticDeletes="true" AllowAutomaticUpdates="true" onkeypress="handleSpace(event)" EnableHeaderContextMenu="true" EnableHeaderContextFilterMenu="true">
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
                    <MasterTableView AutoGenerateColumns="False" DataSourceID="itemsDataSource" DataKeyNames="IRN_ID"
                        EditMode="InPlace" AllowMultiColumnSorting="true" AllowPaging="true" PagerStyle-AlwaysVisible="true" TableLayout="Fixed">
                        <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
                        <Columns>
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
                            <telerik:GridBoundColumn DataField="IRN_NO" FilterControlAltText="Filter IRN_NO column" HeaderText="IRN NO"
                                SortExpression="IRN_NO" UniqueName="IRN_NO" FilterControlWidth="200px" AutoPostBackOnFilter="true">
                                <ItemStyle Width="250px" />
                                <HeaderStyle Width="250px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="IRN_REV" FilterControlAltText="Filter IRN_REV column" HeaderText="IRN REV"
                                SortExpression="IRN_REV" UniqueName="IRN_REV" AllowFiltering="false">
                                <ItemStyle Width="70px" />
                                <HeaderStyle Width="70px" />
                            </telerik:GridBoundColumn>

                            <telerik:GridTemplateColumn DataField="IRN_DATE" DataType="System.DateTime" FilterControlAltText="Filter IRN_DATE column"
                                HeaderText="IRN DATE" SortExpression="IRN_DATE" UniqueName="IRN_DATE" AllowFiltering="false">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txtRFIDateEdit" runat="server" SelectedDate='<%# Bind("IRN_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="IRN_DATELabel" runat="server" Text='<%# Eval("IRN_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="170px" />
                                <HeaderStyle Width="170px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="PO_NO" FilterControlAltText="Filter PO_NO column" HeaderText="PO NO"
                                SortExpression="PO_NO" UniqueName="PO_NO" FilterControlWidth="150px" AutoPostBackOnFilter="true" ReadOnly="true">
                                <ItemStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                            </telerik:GridBoundColumn>

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
                            <telerik:GridTemplateColumn DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column"
                                HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" EnableHeaderContextMenu="false">
                                <EditItemTemplate>
                                    <telerik:RadDatePicker ID="txCREATE_DATE" runat="server" DbSelectedDate='<%# Bind("CREATE_DATE") %>'
                                        DateInput-DateFormat="dd-MMM-yyyy">
                                    </telerik:RadDatePicker>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="180px" />
                                <HeaderStyle Width="180px" />
                            </telerik:GridTemplateColumn>

                            <telerik:GridBoundColumn DataField="IRN_RESULT" FilterControlAltText="Filter IRN_RESULT column" HeaderText="IRN RESULT"
                                SortExpression="IRN_RESULT" UniqueName="IRN_RESULT" FilterControlWidth="60px">
                                <ItemStyle Width="110px" />
                                <HeaderStyle Width="110px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ITEM_COUNT" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT"
                                SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT" FilterControlWidth="60px" ReadOnly="true">
                                <ItemStyle Width="110px" />
                                <HeaderStyle Width="110px" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="REMARKS" FilterControlAltText="Filter REMARKS column" HeaderText="REMARKS" SortExpression="REMARKS" UniqueName="REMARKS" AllowFiltering="false">
                                <ItemStyle Width="800px" />
                                <HeaderStyle Width="800px" />
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <GroupingSettings CaseSensitive="false" />
                </telerik:RadGrid>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:ObjectDataSource ID="itemsDataSource" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Procurement_BTableAdapters.VIEW_PO_IRNTableAdapter" UpdateMethod="UpdateQuery" DeleteMethod="DeleteQuery">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" Type="Decimal" />
            <asp:ControlParameter ControlID="txtSearch" DefaultValue="XXX" Name="FILTER" PropertyName="Text" Type="String" />
            <asp:SessionParameter DefaultValue="-1" Name="USER_NAME" SessionField="USER_NAME" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ORIGINAL_IRN_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="IRN_REV" Type="String" />
            <asp:Parameter Name="IRN_DATE" Type="DateTime" />
            <asp:Parameter Name="IRN_RESULT" Type="String" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="IRN_NO" Type="String" />
            <asp:Parameter Name="USER_ID" Type="Decimal" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="ORIGINAL_IRN_ID" Type="Decimal" />
        </UpdateParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="sqlUserSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME,USER_ID FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>

</asp:Content>

