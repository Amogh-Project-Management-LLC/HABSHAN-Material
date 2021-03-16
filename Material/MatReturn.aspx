<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="MatReturn.aspx.cs" Inherits="Material_MatReturn" Title="Material Return" %>

<%@ MasterType VirtualPath="~/MasterPage.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script type="text/javascript">
        //<![CDATA[

        function upload_pdf() {
            try {
                var id = $find("<%=returnGridView.ClientID %>").get_masterTableView().get_selectedItems()[0].getDataKeyValue("MAT_RET_ID");
                radopen("../Common/FileImport.aspx?TYPE_ID=28&REF_ID=" + id, "RadWindow2", 650, 450);
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
        function RowDblClick(sender, eventArgs) {
            editedRow = eventArgs.get_itemIndexHierarchical();
            $find("<%= returnGridView.ClientID %>").get_masterTableView().editItem(editedRow);
        }
        function RefreshParent(sender, eventArgs) {
            location.href = location.href;
        }

        window.onresize = Test;
        Sys.Application.add_load(Test);
        function Test() {
            var grid = $find('<%= returnGridView.ClientID %>')
            var height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
            var width = document.getElementById("PageHeader").clientWidth
            var divHeight = document.getElementById("PageHeader").clientHeight
            var divButton = document.getElementById("HeaderButtons").clientHeight
            var divFooter = document.getElementById("footerDiv").clientHeight
            grid.get_element().style.height = (height) - divHeight - divButton - divFooter - 70 + "px";
            grid.get_element().style.width = width - 20 + "px";
            grid.repaint();
        }
            //]]>
    </script>


    <div id="HeaderButtons" style="background-color: whitesmoke;">
        <table style="width: 100%;">
            <tr>
                <td>
                    <telerik:RadButton ID="btnRegist" runat="server" Text="New" Width="80" OnClick="btnRegist_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnItems" runat="server" Text="Materials" Width="80" OnClick="btnItems_Click"></telerik:RadButton>
                </td>
                <td>
                    <telerik:RadButton ID="btnPreview" runat="server" Text="Preview" Width="80" OnClick="btnPreview_Click1"></telerik:RadButton>
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

    <div>
        <telerik:RadGrid ID="returnGridView" runat="server" AllowPaging="True" AutoGenerateColumns="False" PagerStyle-AlwaysVisible="true" AllowSorting="true" AllowFilteringByColumn="true"
            DataKeyNames="MAT_RET_ID" DataSourceID="returnDataSource" OnItemCommand="returnGridView_ItemCommand" CellSpacing="-1" GridLines="None" OnItemDataBound="returnGridView_ItemDataBound"
            onkeypress="handleSpace(event)" OnDataBound="returnGridView_DataBound" PageSize="50" OnRowEditing="returnGridView_RowEditing" AllowAutomaticDeletes="true" AllowAutomaticUpdates="true">
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
            <PagerStyle Mode="NextPrevAndNumeric" PageSizes="10,20,50,100,500" />
            <MasterTableView AutoGenerateColumns="False" DataSourceID="returnDataSource" DataKeyNames="MAT_RET_ID" AllowMultiColumnSorting="true"
                ClientDataKeyNames="MAT_RET_ID" TableLayout="Fixed" EditMode="InPlace">
                <Columns>
                    <telerik:GridEditCommandColumn ButtonType="ImageButton">
                        <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridEditCommandColumn>
                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete">
                        <ItemStyle Width="30px" />
                        <HeaderStyle Width="30px" />
                    </telerik:GridButtonColumn>

                    <telerik:GridTemplateColumn ItemStyle-Width="15px" AllowFiltering="false">
                        <ItemTemplate>
                            <asp:Label ID="pdf" runat="server" Text=""></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="45px" />
                        <HeaderStyle Width="45px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridBoundColumn DataField="RETURN_NO" HeaderText="RETURN NO" SortExpression="RETURN_NO" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                    </telerik:GridBoundColumn>

                    <%--<telerik:GridTemplateColumn HeaderText="Return Date" SortExpression="RET_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RET_DATE", "{0:dd-MMM-yyyy}") %>'
                                Width="120px"></asp:TextBox>
                        </EditItemTemplate>

                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("RET_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="100px" />
                        <HeaderStyle Width="100px" />
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn DataField="RET_DATE" DataType="System.DateTime" FilterControlAltText="Filter RET_DATE column"
                        HeaderText="Return Date" SortExpression="RET_DATE" UniqueName="RET_DATE" EnableHeaderContextMenu="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="txtRET_DATEedit" runat="server" DbSelectedDate='<%# Bind("RET_DATE") %>'
                                DateInput-DateFormat="dd-MMM-yyyy">
                            </telerik:RadDatePicker>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="RET_DATELabel" runat="server" Text='<%# Eval("RET_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>
                    
                    <telerik:GridBoundColumn DataField="RET_BY" HeaderText="Return by" SortExpression="RET_BY" AutoPostBackOnFilter="true" AllowFiltering="false">
                        <ItemStyle Width="150px" />
                        <HeaderStyle Width="150px" />
                    </telerik:GridBoundColumn>
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

                    <%--<telerik:GridTemplateColumn HeaderText="From Area" SortExpression="AREA_FROM" AutoPostBackOnFilter="true" FilterControlWidth="30px">
                        <EditItemTemplate>
                            <telerik:RadTextBox ID="txtArea" runat="server" Text='<%# Bind("AREA_FROM") %>' Width="93px"></telerik:RadTextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("AREA_FROM") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="60px" />
                        <HeaderStyle Width="60px" />
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn DataField="AREA_FROM" FilterControlAltText="Filter AREA_FROM column" HeaderText="AREA FROM"
                        SortExpression="AREA_FROM" UniqueName="AREA_FROM" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="cboAREA_FROM" runat="server" DataSourceID="AreaDataSource" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                ItemsPerRequest="10" ShowMoreResultsBox="true"
                                DataTextField="AREA_FROM" DataValueField="AREA_FROM" SelectedValue='<%# Bind("AREA_FROM") %>'
                                AppendDataBoundItems="True">
                                <Items>
                                    <telerik:RadComboBoxItem Selected="true" />
                                </Items>
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("AREA_FROM") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>

                    <%--<telerik:GridTemplateColumn HeaderText="To Store" SortExpression="STORE2" FilterControlAltText="Filter STORE2 column"  UniqueName="STORE2">
                        <EditItemTemplate>
                            <asp:DropDownList ID="cboStore2" runat="server" AppendDataBoundItems="True" DataSourceID="storeDataSource" 
                                DataTextField="STORE_NAME" DataValueField="STORE_ID" SelectedValue='<%# Bind("STORE_ID2") %>' Width="180px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("STORE2") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                        <HeaderStyle Width="120px" />
                    </telerik:GridTemplateColumn>--%>
                    <telerik:GridTemplateColumn DataField="STORE2" FilterControlAltText="Filter STORE2 column" HeaderText="To Store"
                        SortExpression="STORE2" UniqueName="STORE2" AllowFiltering="true" AutoPostBackOnFilter="true">
                        <ItemStyle Width="200px" />
                        <HeaderStyle Width="200px" />
                        <EditItemTemplate>
                            <telerik:RadComboBox ID="cboStore2" runat="server" DataSourceID="storeDataSource" AllowCustomText="true" Filter="Contains" Width="220px" DropDownWidth="250px" Height="200px"
                                ItemsPerRequest="10" ShowMoreResultsBox="true"
                                DataTextField="STORE_NAME" DataValueField="STORE_ID2" SelectedValue='<%# Bind("STORE_ID2") %>'
                                AppendDataBoundItems="True">
                                <Items>
                                    <telerik:RadComboBoxItem Selected="true" />
                                </Items>
                            </telerik:RadComboBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("STORE2") %>'></asp:Label>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ITEM_COUNT" AutoPostBackOnFilter="true" FilterControlAltText="Filter ITEM_COUNT column" HeaderText="ITEM COUNT" SortExpression="ITEM_COUNT" UniqueName="ITEM_COUNT"
                        ReadOnly="true" FilterControlWidth="40px">
                        <ItemStyle Width="90px" />
                        <HeaderStyle Width="90px" />
                    </telerik:GridBoundColumn>

                    <telerik:GridTemplateColumn DataField="USER_NAME" FilterControlAltText="Filter USER_NAME column" HeaderText="CREATED BY"
                        SortExpression="USER_NAME" UniqueName="USER_NAME" FilterControlWidth="50px" AutoPostBackOnFilter="true">
                        <EditItemTemplate>
                            <telerik:RadDropDownList ID="ddlUser" runat="server" DataSourceID="UserDataSource" DropDownWidth="200px" DropDownHeight="300px"
                                DataTextField="USER_NAME" DataValueField="USER_ID" Width="130px" AppendDataBoundItems="true"
                                SelectedValue='<%# Bind("USER_ID") %>'>
                                <Items>
                                    <telerik:DropDownListItem Text="(Select)" Value="" />
                                </Items>
                            </telerik:RadDropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblUser" runat="server" Text='<%# Eval("USER_NAME") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Width="180px" />
                        <HeaderStyle Width="180px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="CREATE_DATE" DataType="System.DateTime" FilterControlAltText="Filter CREATE_DATE column"
                        HeaderText="CREATE DATE" SortExpression="CREATE_DATE" UniqueName="CREATE_DATE" AllowFiltering="false">
                        <EditItemTemplate>
                            <telerik:RadDatePicker ID="RadDatePicker1" runat="server" DateInput-DateFormat="dd-MMM-yyyy" DbSelectedDate='<%# Bind("CREATE_DATE") %>' Width="120px"></telerik:RadDatePicker>

                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="CREATE_DATELabel" runat="server" Text='<%# Eval("CREATE_DATE", "{0:dd-MMM-yyyy}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                        <ItemStyle Width="150px" />
                    </telerik:GridTemplateColumn>


                    <telerik:GridBoundColumn DataField="REMARKS" HeaderText="Remarks" SortExpression="REMARKS" AllowFiltering="false">
                        <ItemStyle Width="130px" />
                        <HeaderStyle Width="130px" />
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <GroupingSettings CaseSensitive="false" />
        </telerik:RadGrid>
    </div>


    <asp:ObjectDataSource ID="returnDataSource" runat="server" DeleteMethod="DeleteQuery"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="dsMaterialATableAdapters.PIP_MAT_RETURNTableAdapter"
        UpdateMethod="UpdateQuery">
        <DeleteParameters>
            <asp:Parameter Name="original_MAT_RET_ID" Type="Decimal" />
        </DeleteParameters>
        <UpdateParameters>

            <asp:Parameter Name="RETURN_NO" Type="String" />
            <asp:Parameter Name="RET_DATE" Type="DateTime" />
            <asp:Parameter Name="RET_BY" Type="String" />
            <asp:Parameter Name="STORE_ID2" Type="Decimal" />
            <asp:Parameter Name="REMARKS" Type="String" />
            <asp:Parameter Name="AREA_FROM" Type="String" />
            <asp:Parameter Name="USER_ID" Type="Decimal" />
            <asp:Parameter Name="REF_SC_ID" Type="Decimal" />
            <asp:Parameter Name="CREATE_DATE" Type="DateTime" />
            <asp:Parameter Name="original_MAT_RET_ID" Type="Decimal" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID"
                Type="Decimal" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:SqlDataSource ID="storeDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>" SelectCommand="SELECT STORE_ID AS  STORE_ID2, STORE_NAME FROM STORES_DEF WHERE (PROJECT_ID = :PROJECT_ID) ORDER BY STORE_NAME">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="-1" Name="PROJECT_ID" SessionField="PROJECT_ID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="AreaDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT DISTINCT AREA_L2 AS AREA_FROM FROM VIEW_IPMS_AREA 
        UNION SELECT SUB_AREA AS AREA_FROM FROM MATERIAL_SUB_AREA 
         ORDER BY AREA_FROM"></asp:SqlDataSource>
    <asp:SqlDataSource ID="UserDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>"
        ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  USER_NAME ,USER_ID FROM USERS ORDER BY USER_NAME"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlRefSubconSource" runat="server" ConnectionString="<%$ ConnectionStrings:ipmsConnectionString %>" ProviderName="<%$ ConnectionStrings:ipmsConnectionString.ProviderName %>"
        SelectCommand="SELECT  SUB_CON_NAME AS REF_SUBCON,SUB_CON_ID as REF_SC_ID FROM REF_SUB_CONTRACTOR"></asp:SqlDataSource>
</asp:Content>
